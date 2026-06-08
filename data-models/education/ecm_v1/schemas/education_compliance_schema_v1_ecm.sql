-- Schema for Domain: compliance | Business: Education | Version: v1_ecm
-- Generated on: 2026-05-06 12:27:59

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `education_ecm`.`compliance` COMMENT 'Ensures institutional adherence to federal, state, and accreditation requirements. Manages Title IX investigations, Clery Act reporting, ADA accommodations, FERPA audits, NCAA eligibility, accreditation self-studies, regulatory filings, audit findings, corrective actions, and policy enforcement across the institution.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `education_ecm`.`compliance`.`regulatory_requirement` (
    `regulatory_requirement_id` BIGINT COMMENT 'Unique identifier for the regulatory requirement record. Primary key for the regulatory requirement catalog.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to hr.org_unit. Business justification: Regulatory requirements assign organizational accountability for compliance monitoring and reporting. Enables requirement workload distribution, organizational compliance scoring, and resource allocat',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this regulatory requirement is currently active and enforceable. True for active requirements, false for superseded or expired requirements.',
    `applicability_criteria` STRING COMMENT 'Specific conditions or criteria that determine when this requirement applies (e.g., applies to all Title IV participating institutions, applies to NCAA Division I athletics programs, applies to programs with clinical components, applies to institutions with on-campus housing).',
    `applicability_scope` STRING COMMENT 'Defines the organizational scope to which this requirement applies: institution-wide (all units), program-specific (certain academic programs), department-specific (specific departments), college-specific (specific colleges/schools), campus-specific (specific campus locations), student-specific (certain student populations), employee-specific (certain employee groups). [ENUM-REF-CANDIDATE: institution-wide|program-specific|department-specific|college-specific|campus-specific|student-specific|employee-specific — 7 candidates stripped; promote to reference product]',
    `citation_reference` STRING COMMENT 'Specific legal or regulatory citation (e.g., 20 U.S.C. § 1232g, 34 CFR Part 99, 34 CFR 668.46, HLC Criterion 2.A.1). Provides precise statutory or regulatory section reference.',
    `compliance_status` STRING COMMENT 'Current institutional compliance status for this requirement: compliant (fully meeting obligation), non-compliant (not meeting obligation), in-progress (working toward compliance), not-applicable (requirement does not apply), under-review (compliance assessment underway), remediation-required (corrective action needed).. Valid values are `compliant|non-compliant|in-progress|not-applicable|under-review|remediation-required`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory requirement record was first created in the compliance catalog system. Provides audit trail for record creation.',
    `documentation_requirements` STRING COMMENT 'Description of records, evidence, or documentation that must be maintained to demonstrate compliance with this requirement (e.g., training completion records, audit trails, signed attestations, published notices, meeting minutes).',
    `effective_date` DATE COMMENT 'Date when this regulatory requirement became or becomes effective and enforceable. Marks the start of the compliance obligation period.',
    `enforcement_mechanism` STRING COMMENT 'Description of how this requirement is enforced and what consequences exist for non-compliance (e.g., loss of Title IV eligibility, accreditation sanctions, civil penalties, loss of NCAA membership, corrective action plans, public disclosure of violations).',
    `expiration_date` DATE COMMENT 'Date when this regulatory requirement expires or is superseded, if applicable. Null for ongoing requirements with no sunset provision.',
    `external_reporting_system` STRING COMMENT 'Name of the external system or portal used for submitting compliance reports or filings (e.g., IPEDS Data Collection System, NCAA Compliance Assistance, Federal Student Aid Portal, Accreditation Portal). Null if no external reporting is required.',
    `implementation_notes` STRING COMMENT 'Internal notes on how the institution implements or interprets this requirement, including operational procedures, system configurations, or special considerations.',
    `last_audit_date` DATE COMMENT 'Date of the most recent internal or external audit or compliance review that assessed this requirement. Used to track audit history and compliance verification.',
    `last_audit_result` STRING COMMENT 'Outcome of the most recent audit or compliance review: compliant (no findings), non-compliant (findings identified), compliant-with-recommendations (compliant but improvements suggested), not-reviewed (not included in audit scope).. Valid values are `compliant|non-compliant|compliant-with-recommendations|not-reviewed`',
    `last_compliance_certification_date` DATE COMMENT 'Date when the responsible officer last certified institutional compliance with this requirement. Used for attestation tracking and accountability.',
    `last_updated_by` STRING COMMENT 'Name or identifier of the person who last updated this regulatory requirement record. Provides accountability for data maintenance.',
    `last_updated_date` DATE COMMENT 'Date when this regulatory requirement record was last updated in the compliance catalog. Used to track currency of compliance information.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory requirement record was last modified. Provides audit trail for record changes and supports change tracking.',
    `next_reporting_due_date` DATE COMMENT 'Due date for the next required compliance report or filing submission to the regulatory body, if applicable. Null for non-reporting requirements.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next institutional compliance review or assessment of this requirement. Used for compliance calendar planning and tracking.',
    `penalty_description` STRING COMMENT 'Specific penalties or sanctions that may be imposed for non-compliance, including monetary fines, program restrictions, loss of funding, accreditation probation, or other enforcement actions.',
    `record_retention_period` STRING COMMENT 'Required duration for retaining compliance documentation and evidence (e.g., 3 years, 5 years, 7 years, permanent). Specifies minimum retention period mandated by regulation or institutional policy.',
    `regulatory_body` STRING COMMENT 'Name of the governing or enforcement agency responsible for this requirement (e.g., U.S. Department of Education, Higher Learning Commission, SACSCOC, NCAA, Office for Civil Rights, State Board of Education).',
    `regulatory_source` STRING COMMENT 'Name of the law, regulation, or standard that mandates this requirement (e.g., Family Educational Rights and Privacy Act, Title IX of the Education Amendments of 1972, Jeanne Clery Disclosure of Campus Security Policy and Campus Crime Statistics Act, Americans with Disabilities Act, Higher Learning Commission Criteria for Accreditation).',
    `related_requirements` STRING COMMENT 'List or description of other regulatory requirements that are related, dependent, or cross-referenced with this requirement. Captures interdependencies in the compliance landscape.',
    `reporting_frequency` STRING COMMENT 'Required frequency for submitting compliance reports or filings to the regulatory body, if applicable. Not-applicable for requirements that do not involve periodic reporting. [ENUM-REF-CANDIDATE: annual|biennial|quarterly|monthly|one-time|event-driven|not-applicable — 7 candidates stripped; promote to reference product]',
    `requirement_code` STRING COMMENT 'Business identifier code for the regulatory requirement (e.g., FERPA-001, TITLE-IX-042, CLERY-ACT-15). Used for external reference and cross-system tracking.. Valid values are `^[A-Z0-9-]{3,20}$`',
    `requirement_description` STRING COMMENT 'Detailed narrative description of the compliance obligation, including what must be done, by whom, and under what conditions. Captures the substantive content of the regulatory mandate.',
    `requirement_name` STRING COMMENT 'Full descriptive name of the regulatory requirement (e.g., Annual Security Report Publication, Student Privacy Rights Notification, Athletic Eligibility Certification).',
    `requirement_type` STRING COMMENT 'Classification of the compliance obligation type: reporting (periodic submission), disclosure (public notification), certification (attestation), audit (examination), training (education mandate), policy (governance requirement), procedural (operational process), documentation (record-keeping). [ENUM-REF-CANDIDATE: reporting|disclosure|certification|audit|training|policy|procedural|documentation — 8 candidates stripped; promote to reference product]',
    `responsible_officer_name` STRING COMMENT 'Name of the individual officer or position holder with primary accountability for this compliance requirement (e.g., Chief Compliance Officer, Title IX Coordinator, Director of Financial Aid, Faculty Athletics Representative).',
    `review_frequency` STRING COMMENT 'Required frequency for institutional review or reassessment of compliance with this requirement: annual (yearly), biennial (every two years), triennial (every three years), quarterly, monthly, continuous (ongoing monitoring), event-driven (triggered by specific events), as-needed (no fixed schedule). [ENUM-REF-CANDIDATE: annual|biennial|triennial|quarterly|monthly|continuous|event-driven|as-needed — 8 candidates stripped; promote to reference product]',
    `risk_level` STRING COMMENT 'Institutional assessment of the risk severity associated with non-compliance: critical (severe institutional impact), high (significant impact), medium (moderate impact), low (minimal impact). Used for prioritizing compliance efforts.. Valid values are `critical|high|medium|low`',
    `supporting_policy_reference` STRING COMMENT 'Reference to institutional policies, procedures, or guidelines that implement this regulatory requirement (e.g., policy number, policy title, handbook section). Links regulatory mandate to internal governance documents.',
    `training_audience` STRING COMMENT 'Description of who must complete required training (e.g., all employees, faculty only, student-athletes, Title IX coordinators, research administrators, financial aid staff). Null if no training is required.',
    `training_frequency` STRING COMMENT 'Required frequency for completing compliance training: annual (yearly), biennial (every two years), one-time (initial training only), as-needed (when role changes or updates occur), not-applicable (no training required).. Valid values are `annual|biennial|one-time|as-needed|not-applicable`',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether this requirement mandates specific training for employees, students, or other constituencies. True if training is required, false otherwise.',
    CONSTRAINT pk_regulatory_requirement PRIMARY KEY(`regulatory_requirement_id`)
) COMMENT 'Master catalog of all federal, state, and accreditation regulatory requirements applicable to the institution. Captures requirement source (e.g., Title IV, FERPA, Clery Act, ADA, Title IX, IPEDS, NCAA), regulatory body, effective dates, applicability scope (institution-wide, program-specific, department-specific), compliance obligation type, citation reference, and enforcement mechanism. Serves as the authoritative reference for all compliance obligations tracked across the institution.';

CREATE OR REPLACE TABLE `education_ecm`.`compliance`.`obligation` (
    `obligation_id` BIGINT COMMENT 'Primary key for obligation',
    `employee_id` BIGINT COMMENT 'Reference to the employee designated as the compliance officer responsible for overseeing and ensuring fulfillment of this obligation.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Compliance obligations are operationalized through formal institutional policies. For example, a Title IX regulatory obligation is implemented through the institutions Title IX policy. The policy_ref',
    `regulatory_requirement_id` BIGINT COMMENT 'Reference to the source regulatory requirement that mandates this obligation (e.g., FERPA regulation, Title IX statute, Clery Act provision, NCAA bylaw, accreditation standard).',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to hr.org_unit. Business justification: Compliance obligations are assigned to organizational units for execution accountability. Enables obligation workload distribution, organizational compliance dashboards, and budget allocation for comp',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual financial cost incurred to fulfill the obligation. Expressed in USD.',
    `actual_effort_hours` DECIMAL(18,2) COMMENT 'Actual number of staff hours spent fulfilling the obligation, captured for process improvement and future estimation accuracy.',
    `audit_finding_count` STRING COMMENT 'Number of audit findings or deficiencies identified during the most recent audit of this obligation. Zero indicates full compliance.',
    `completion_date` DATE COMMENT 'The actual date when the obligation was fulfilled. Null if not yet completed.',
    `completion_status` STRING COMMENT 'Detailed status of the obligation fulfillment process: not-started (no action taken), in-progress (work underway), submitted (delivered to governing body), approved (accepted by regulator), rejected (requires rework), partially-complete (some components done).. Valid values are `not-started|in-progress|submitted|approved|rejected|partially-complete`',
    `corrective_action_due_date` DATE COMMENT 'Deadline by which corrective actions must be completed to address audit findings or compliance deficiencies. Null if no corrective action is required.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether corrective action is required to address audit findings or compliance gaps (true) or the obligation is in full compliance (false).',
    `cost_estimate` DECIMAL(18,2) COMMENT 'Estimated financial cost to fulfill the obligation, including staff time, external consultant fees, technology costs, and materials. Expressed in USD.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance obligation record was first created in the system. Used for audit trail and data lineage.',
    `due_date` DATE COMMENT 'The deadline by which the compliance obligation must be fulfilled. For recurring obligations, this represents the next due date.',
    `effective_end_date` DATE COMMENT 'The date when this compliance obligation expires or is no longer required. Null for ongoing obligations.',
    `effective_start_date` DATE COMMENT 'The date when this compliance obligation becomes active and enforceable for the institution.',
    `escalation_threshold_days` STRING COMMENT 'Number of days before the due date when the obligation should be escalated to senior leadership if not yet completed (e.g., 30 days for critical obligations, 14 days for standard obligations).',
    `estimated_effort_hours` DECIMAL(18,2) COMMENT 'Projected number of staff hours required to complete the obligation, used for resource planning and workload management.',
    `evidence_location` STRING COMMENT 'File path, URL, or document management system reference where supporting documentation and evidence of compliance are stored (e.g., SharePoint folder, compliance management system record ID).',
    `frequency` STRING COMMENT 'Recurrence pattern for the obligation: annual (yearly), biennial (every two years), quarterly (four times per year), monthly, event-triggered (upon specific incidents), one-time (single occurrence), continuous (ongoing monitoring). [ENUM-REF-CANDIDATE: annual|biennial|quarterly|monthly|event-triggered|one-time|continuous — 7 candidates stripped; promote to reference product]',
    `governing_body` STRING COMMENT 'Name of the regulatory or accreditation body that mandates this obligation (e.g., U.S. Department of Education, HLC, SACSCOC, NCAA, AACSB, ABET, ABA, FERPA, Title IX Office).',
    `is_active` BOOLEAN COMMENT 'Indicates whether this compliance obligation record is currently active (true) or has been logically deleted or archived (false). Used for soft-delete pattern.',
    `last_audit_date` DATE COMMENT 'The date of the most recent internal or external audit of this compliance obligation. Used to track audit cycles and identify obligations due for review.',
    `next_audit_date` DATE COMMENT 'The scheduled date for the next internal or external audit of this compliance obligation.',
    `notes` STRING COMMENT 'Free-text field for additional context, special instructions, historical notes, or clarifications about the obligation that do not fit in structured fields.',
    `obligation_code` STRING COMMENT 'Business identifier code for the compliance obligation, used for external reference and reporting (e.g., FERPA-001, TITLEIX-002, CLERY-003).. Valid values are `^[A-Z0-9]{3,20}$`',
    `obligation_name` STRING COMMENT 'Full descriptive name of the compliance obligation (e.g., Annual FERPA Audit, Title IX Training Completion, Clery Act Crime Statistics Report).',
    `obligation_status` STRING COMMENT 'Current lifecycle status of the compliance obligation: active (in effect), pending (scheduled but not yet due), completed (fulfilled), overdue (past deadline), waived (exempted), suspended (temporarily inactive).. Valid values are `active|pending|completed|overdue|waived|suspended`',
    `obligation_type` STRING COMMENT 'Classification of the compliance obligation by activity type: reporting (regulatory filings), training (mandatory education), investigation (incident response), audit (compliance review), self-study (accreditation), filing (document submission), certification (attestation), monitoring (ongoing oversight). [ENUM-REF-CANDIDATE: reporting|training|investigation|audit|self-study|filing|certification|monitoring — 8 candidates stripped; promote to reference product]',
    `penalty_description` STRING COMMENT 'Description of potential consequences for non-compliance, including financial penalties, loss of accreditation, loss of federal funding eligibility, sanctions, or reputational damage.',
    `priority_level` STRING COMMENT 'Business priority classification for the obligation based on regulatory impact and institutional risk: critical (federal mandate with severe penalties), high (accreditation requirement), medium (state requirement), low (internal policy).. Valid values are `critical|high|medium|low`',
    `requires_board_approval` BOOLEAN COMMENT 'Indicates whether this obligation requires formal approval from the Board of Trustees or Regents before submission (true) or can be handled at the administrative level (false).',
    `requires_external_audit` BOOLEAN COMMENT 'Indicates whether this obligation requires validation or certification by an external auditor or third-party reviewer (true) or can be self-certified (false).',
    `submission_method` STRING COMMENT 'The mechanism by which the obligation deliverable is submitted to the governing body: online-portal (e.g., IPEDS portal), email, mail (physical documents), in-person (site visit), system-integration (automated data feed), not-applicable (internal obligations).. Valid values are `online-portal|email|mail|in-person|system-integration|not-applicable`',
    `training_completion_rate` DECIMAL(18,2) COMMENT 'Percentage of required staff who have completed mandatory training associated with this obligation. Expressed as a percentage (0.00 to 100.00).',
    `training_required` BOOLEAN COMMENT 'Indicates whether staff training is required as part of fulfilling this obligation (true) or training is not applicable (false). Examples include Title IX training, FERPA training, Clery Act training.',
    `updated_by` STRING COMMENT 'Username or identifier of the person who last modified this compliance obligation record. Used for accountability and audit purposes.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance obligation record was last modified. Used for audit trail and change tracking.',
    `created_by` STRING COMMENT 'Username or identifier of the person who created this compliance obligation record. Used for accountability and audit purposes.',
    CONSTRAINT pk_obligation PRIMARY KEY(`obligation_id`)
) COMMENT 'Institutional compliance obligations derived from regulatory requirements, mapped to responsible offices, compliance officers, and reporting deadlines. Tracks obligation type (reporting, training, investigation, audit, self-study), frequency (annual, biennial, event-triggered), assigned owner, due dates, escalation thresholds, and current fulfillment status. Links regulatory requirements to institutional accountability structures.';

CREATE OR REPLACE TABLE `education_ecm`.`compliance`.`policy` (
    `policy_id` BIGINT COMMENT 'Unique identifier for the institutional policy record. Primary key.',
    `it_policy_id` BIGINT COMMENT 'Foreign key linking to technology.it_policy. Business justification: Institutional compliance policies (data retention, records management, acceptable use) are implemented through IT policies. Auditors trace compliance policy requirements to technical controls. For exa',
    `supersedes_policy_id` BIGINT COMMENT 'Reference to the previous policy version that this policy replaces. Enables version lineage tracking and historical analysis.',
    `acknowledgment_required_flag` BOOLEAN COMMENT 'Indicates whether individuals subject to this policy must formally acknowledge receipt and understanding. Common for high-risk policies and annual compliance certifications.',
    `applicability_scope` STRING COMMENT 'Defines which populations or organizational units are subject to this policy. Critical for determining enforcement jurisdiction and compliance obligations. [ENUM-REF-CANDIDATE: all_university|undergraduate_students|graduate_students|faculty|staff|contractors|visitors — 7 candidates stripped; promote to reference product]',
    `approval_date` DATE COMMENT 'Date on which the issuing authority formally approved this policy version. Used for version control and audit trails.',
    `audit_trail_notes` STRING COMMENT 'Free-text field capturing significant events in the policy lifecycle: amendments, emergency suspensions, legal challenges, or regulatory guidance changes. Supports compliance audits and accreditation reviews.',
    `compliance_framework` STRING COMMENT 'The primary compliance or accreditation framework this policy addresses. Used to map policies to regulatory reporting requirements and audit checklists. [ENUM-REF-CANDIDATE: ferpa|title_ix|clery_act|ada|hipaa|ncaa|aacsb|abet|hlc|sacscoc — 10 candidates stripped; promote to reference product]',
    `contact_email` STRING COMMENT 'Email address for inquiries related to this policy. Used by students, faculty, staff, and external parties seeking clarification or reporting concerns.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_office` STRING COMMENT 'Office or department that serves as the primary point of contact for questions, interpretations, and guidance on this policy (e.g., Office of Compliance, Title IX Office, Registrar).',
    `contact_phone` STRING COMMENT 'Phone number for the contact office. Supports accessibility and provides alternative communication channel for policy inquiries.. Valid values are `^+?[1-9]d{1,14}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this policy record was first created in the system. Part of the audit trail for data governance and compliance tracking.',
    `document_repository_path` STRING COMMENT 'File path or document management system location where the authoritative version of this policy is stored (e.g., SharePoint path, DMS identifier).',
    `effective_date` DATE COMMENT 'Date on which this policy became or will become enforceable. May differ from approval date to allow for communication and training periods.',
    `enforcement_mechanism` STRING COMMENT 'Description of how violations of this policy are detected, investigated, and adjudicated (e.g., student conduct process, HR grievance procedure, Title IX investigation protocol).',
    `expiration_date` DATE COMMENT 'Date on which this policy version ceases to be enforceable. Nullable for policies without a predetermined end date.',
    `geographic_scope` STRING COMMENT 'Defines the physical or virtual locations where this policy applies. Important for multi-campus institutions and online programs.. Valid values are `all_locations|main_campus|branch_campuses|online_programs|international_sites`',
    `issuing_authority` STRING COMMENT 'The governing body or office that formally adopted and authorized this policy (e.g., Board of Trustees, President, Provost, Vice President for Finance).',
    `keywords` STRING COMMENT 'Comma-separated list of searchable terms and phrases that facilitate policy discovery and retrieval (e.g., discrimination, harassment, accommodations, privacy).',
    `last_review_date` DATE COMMENT 'Date of the most recent formal review of this policy by the policy owner or governing body. Used to track compliance with review cycle requirements.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this policy record. Used to track data freshness and trigger downstream refresh processes.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next mandatory review of this policy. Calculated based on review cycle frequency and last review date.',
    `owner` STRING COMMENT 'The office, department, or individual responsible for maintaining, interpreting, and enforcing this policy (e.g., Office of Compliance, Title IX Coordinator, Registrar).',
    `policy_category` STRING COMMENT 'Primary classification of the policy domain. Determines which compliance frameworks and regulatory requirements apply. [ENUM-REF-CANDIDATE: academic_integrity|title_ix|ada_accessibility|ferpa_privacy|research_ethics|financial_management|safety_security|human_resources|student_affairs|athletics|information_technology|facilities|procurement — promote to reference product]. Valid values are `academic_integrity|title_ix|ada_accessibility|ferpa_privacy|research_ethics|financial_management`',
    `policy_number` STRING COMMENT 'Externally-known unique policy identifier assigned by the institution (e.g., AA-001, FERPA-1234). Used for reference in communications, audits, and compliance documentation.. Valid values are `^[A-Z]{2,4}-d{3,5}$`',
    `policy_status` STRING COMMENT 'Current lifecycle state of the policy. Active policies are enforceable; superseded policies have been replaced by newer versions; archived policies are retained for historical reference only. [ENUM-REF-CANDIDATE: draft|under_review|approved|active|suspended|archived|superseded — 7 candidates stripped; promote to reference product]',
    `public_visibility_flag` BOOLEAN COMMENT 'Indicates whether this policy is published on the public-facing institutional website or restricted to internal audiences. Transparency requirement for certain compliance policies.',
    `regulatory_basis` STRING COMMENT 'The federal, state, or accreditation requirement that mandates or informs this policy (e.g., Title IX of the Education Amendments of 1972, FERPA 34 CFR Part 99, HLC Criterion 2.A).',
    `related_policies` STRING COMMENT 'Comma-separated list of policy numbers or titles that are related to or referenced by this policy. Supports cross-referencing and policy ecosystem mapping.',
    `review_cycle_months` STRING COMMENT 'Frequency in months at which this policy must be reviewed (e.g., 12, 24, 36). Determined by regulatory requirements, risk level, and institutional governance standards.',
    `sanctions_description` STRING COMMENT 'Summary of potential consequences for policy violations, ranging from warnings to expulsion, termination, or legal action. Used for transparency and due process.',
    `subcategory` STRING COMMENT 'Secondary classification providing additional granularity within the primary category (e.g., under Title IX: sexual harassment, discrimination, retaliation).',
    `summary` STRING COMMENT 'Brief executive summary of the policy purpose, scope, and key provisions. Used for policy catalogs, training materials, and quick reference guides.',
    `title` STRING COMMENT 'Full official title of the policy as approved by the governing body. Human-readable identifier used in policy manuals and institutional communications.',
    `training_frequency_months` STRING COMMENT 'Frequency in months at which personnel must complete refresher training on this policy. Nullable if training is one-time or not required.',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether institutional personnel must complete formal training on this policy. True for policies with significant compliance risk (Title IX, FERPA, research ethics).',
    `url` STRING COMMENT 'Web address where the full text of this policy is published. Enables direct access for students, faculty, staff, and external auditors.. Valid values are `^https?://.*$`',
    `version_number` STRING COMMENT 'Semantic version identifier for this policy iteration (e.g., 1.0, 2.1). Incremented with each revision to maintain version history and audit trail.. Valid values are `^d+.d+$`',
    CONSTRAINT pk_policy PRIMARY KEY(`policy_id`)
) COMMENT 'Institutional policy master record covering all formally adopted policies governing academic, administrative, financial, and student affairs. Captures policy number, title, category (academic integrity, Title IX, ADA, FERPA, research ethics, financial, safety), issuing authority, approval date, effective date, review cycle, policy owner, version history, and applicability scope. Serves as the SSOT for institutional policy governance.';

CREATE OR REPLACE TABLE `education_ecm`.`compliance`.`policy_version` (
    `policy_version_id` BIGINT COMMENT 'Unique identifier for this specific version of an institutional policy. Primary key for the policy version record.',
    `employee_id` BIGINT COMMENT 'Employee who holds the approval authority and formally approved this policy version. Links to the executive or administrator who signed off.',
    `policy_id` BIGINT COMMENT 'Reference to the parent policy document that this version belongs to. Links to the master policy entity.',
    `primary_policy_author_employee_id` BIGINT COMMENT 'Employee who drafted or authored this version of the policy. Typically a compliance officer, legal counsel, or policy administrator.',
    `superseded_version_policy_version_id` BIGINT COMMENT 'Reference to the previous policy version that this version replaces. Null for the first version. Enables full version lineage tracking required for accreditation self-studies.',
    `tertiary_policy_contact_employee_id` BIGINT COMMENT 'Employee designated as the primary contact for questions or concerns about this policy version. Typically a compliance officer or policy administrator.',
    `accessibility_compliant_flag` BOOLEAN COMMENT 'Indicates whether this policy document version meets ADA Section 508 and WCAG 2.1 accessibility standards. True when document is accessible to users with disabilities.',
    `acknowledgment_required_flag` BOOLEAN COMMENT 'Indicates whether employees or students must formally acknowledge receipt and understanding of this policy version. True for policies requiring signed acknowledgment for compliance purposes.',
    `approval_authority` STRING COMMENT 'Title or role of the individual or body authorized to approve this policy version (e.g., President, Board of Trustees, Provost, Vice President for Compliance). Defines governance hierarchy.',
    `approval_date` DATE COMMENT 'Date when the approval authority formally approved this policy version. Marks the transition from draft/review to approved status.',
    `archived_date` DATE COMMENT 'Date when this policy version was moved to archived status. Null for non-archived versions. Supports retention schedule compliance.',
    `archived_flag` BOOLEAN COMMENT 'Indicates whether this policy version has been archived and is no longer actively referenced. True for historical versions retained for audit and accreditation purposes but not displayed in active policy libraries.',
    `change_summary` STRING COMMENT 'Executive summary of changes made in this version compared to the previous version. Describes what was added, modified, or removed and why.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this policy version record was first created in the system. Audit field for tracking record creation.',
    `document_format` STRING COMMENT 'File format of the policy document (PDF, Word, HTML, Markdown). Indicates how the policy is stored and published.. Valid values are `pdf|docx|html|markdown`',
    `document_url` STRING COMMENT 'Web address or document management system link to the full text of this policy version. Provides access to the authoritative policy document.. Valid values are `^https?://.*$`',
    `effective_date` DATE COMMENT 'Date when this policy version becomes officially active and enforceable across the institution. May differ from approval date to allow for communication and training periods.',
    `expiration_date` DATE COMMENT 'Date when this policy version is scheduled to expire or undergo mandatory review. Null for policies without scheduled expiration. Supports periodic review requirements for accreditation.',
    `legal_review_comments` STRING COMMENT 'Confidential comments and recommendations provided by legal counsel during their review. May include risk assessments, suggested language changes, or approval conditions.',
    `legal_review_date` DATE COMMENT 'Date when legal counsel completed their review of this policy version. Required for compliance audit trails.',
    `legal_review_required_flag` BOOLEAN COMMENT 'Indicates whether this policy version requires formal legal counsel review before approval. True for policies with legal, regulatory, or contractual implications.',
    `legal_review_status` STRING COMMENT 'Current status of legal counsel review for this policy version. Tracks whether legal has approved, rejected, or conditionally approved the policy language.. Valid values are `not_required|pending|in_progress|approved|rejected|conditional_approval`',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this policy version record was last modified in the system. Audit field for tracking record updates.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next mandatory review of this policy. Supports periodic review cycles required by accreditation agencies and best practices in policy governance.',
    `public_comment_period_flag` BOOLEAN COMMENT 'Indicates whether this policy version was subject to a public comment period before finalization. True for policies affecting broad campus populations or required by shared governance.',
    `regulatory_framework` STRING COMMENT 'Primary federal, state, or accreditation regulation that this policy addresses (e.g., FERPA, Title IX, Clery Act, ADA, SACSCOC Standard 3.3.1). Links policy to external compliance requirements. [ENUM-REF-CANDIDATE: ferpa|title_ix|clery_act|ada|title_iv|hipaa|ncaa|sacscoc|hlc|abet|aacsb|gasb|fasb — promote to reference product]',
    `responsible_office` STRING COMMENT 'Name of the institutional office or department responsible for administering and enforcing this policy (e.g., Office of Compliance, Office of General Counsel, Human Resources, Title IX Office).',
    `review_frequency_months` STRING COMMENT 'Standard review cycle for this policy in months (e.g., 12, 24, 36). Defines how often the policy must be reviewed for currency and compliance.',
    `revision_reason` STRING COMMENT 'Primary business driver or trigger for creating this new version. Indicates whether the revision was driven by external compliance requirements, internal improvements, or scheduled review cycles. [ENUM-REF-CANDIDATE: regulatory_change|accreditation_requirement|legal_update|operational_improvement|periodic_review|incident_response|stakeholder_feedback — 7 candidates stripped; promote to reference product]',
    `scope_description` STRING COMMENT 'Detailed description of which institutional units, populations, or activities this policy version applies to. Defines the boundaries of policy applicability.',
    `stakeholder_consultation_flag` BOOLEAN COMMENT 'Indicates whether this policy version underwent formal stakeholder consultation or shared governance review before approval. True for policies requiring faculty senate, student government, or staff council input.',
    `superseded_date` DATE COMMENT 'Date when this policy version was superseded by a newer version and transitioned from active to superseded status. Null for currently active versions.',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether employees or students are required to complete training on this policy version. True for policies with mandatory compliance training requirements (e.g., Title IX, FERPA, safety).',
    `version_number` STRING COMMENT 'Semantic version number for this policy revision (e.g., 1.0, 2.1, 3.0.1). Follows standard versioning conventions to indicate major and minor revisions.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    `version_status` STRING COMMENT 'Current lifecycle status of this policy version. Tracks progression from draft through approval to active use and eventual supersession.. Valid values are `draft|under_review|approved|active|superseded|archived`',
    `version_title` STRING COMMENT 'Full title of the policy as it appears in this version. May change across versions to reflect scope or terminology updates.',
    `word_count` STRING COMMENT 'Total word count of the policy document in this version. Used for readability analysis and to track policy complexity over time.',
    CONSTRAINT pk_policy_version PRIMARY KEY(`policy_version_id`)
) COMMENT 'Version history for institutional policies, capturing each revision cycle including version number, change summary, author, legal review status, approval authority, approval date, effective date, superseded version reference, and reason for revision. Enables full audit trail of policy evolution required for accreditation self-studies and regulatory audits.';

CREATE OR REPLACE TABLE `education_ecm`.`compliance`.`title_ix_case` (
    `title_ix_case_id` BIGINT COMMENT 'Unique identifier for the Title IX case record. Primary key.',
    `cybersecurity_incident_id` BIGINT COMMENT 'Foreign key linking to technology.cybersecurity_incident. Business justification: Title IX cases increasingly involve cyber harassment, non-consensual image sharing, unauthorized access to victim accounts, or electronic stalking. OCR guidance requires institutions to address techno',
    `employee_id` BIGINT COMMENT 'Unique identifier for the Title IX Coordinator overseeing this case.',
    `profile_id` BIGINT COMMENT 'Unique identifier for the individual filing the Title IX complaint. Links to student, employee, or person record.',
    `quaternary_title_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the system user who last modified this Title IX case record.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Title IX case management is a federal regulatory requirement under Title IX of the Education Amendments of 1972 (20 U.S.C. §§ 1681-1688) and implementing regulations (34 CFR Part 106). Each case is tr',
    `tertiary_title_decision_maker_employee_id` BIGINT COMMENT 'Unique identifier for the decision-maker who issued the determination regarding responsibility.',
    `appeal_basis` STRING COMMENT 'Grounds on which the appeal is based, as permitted under Title IX regulations.. Valid values are `procedural_irregularity|new_evidence|conflict_of_interest|other`',
    `appeal_decision_date` DATE COMMENT 'Date when the appeal decision was issued.',
    `appeal_filed_by` STRING COMMENT 'Identifies which party filed the appeal (complainant, respondent, or both).. Valid values are `complainant|respondent|both`',
    `appeal_filed_date` DATE COMMENT 'Date when an appeal was filed by either the complainant or respondent.',
    `appeal_filed_flag` BOOLEAN COMMENT 'Indicates whether an appeal has been filed by either party following the determination.',
    `appeal_outcome` STRING COMMENT 'Result of the appeal decision by the appellate decision-maker.. Valid values are `affirmed|reversed|remanded|modified`',
    `case_closure_date` DATE COMMENT 'Date when the Title IX case was officially closed, including all appeals and sanctions implementation.',
    `case_number` STRING COMMENT 'Externally-known business identifier for the Title IX case, formatted as TIX-YYYY-#####.. Valid values are `^TIX-[0-9]{4}-[0-9]{5}$`',
    `case_status` STRING COMMENT 'Current lifecycle status of the Title IX case in the grievance process workflow. [ENUM-REF-CANDIDATE: intake|investigation|hearing_scheduled|determination_issued|appeal_pending|closed|dismissed — 7 candidates stripped; promote to reference product]',
    `case_type` STRING COMMENT 'Classification of the Title IX complaint based on the nature of the alleged conduct.. Valid values are `sexual_harassment|sexual_assault|stalking|dating_violence|domestic_violence|retaliation`',
    `clery_reportable_flag` BOOLEAN COMMENT 'Indicates whether this Title IX case involves a Clery Act reportable crime.',
    `complainant_type` STRING COMMENT 'Classification of the complainants relationship to the institution. [ENUM-REF-CANDIDATE: student|employee|faculty|staff|visitor|contractor|other — 7 candidates stripped; promote to reference product]',
    `confidentiality_request_flag` BOOLEAN COMMENT 'Indicates whether the complainant requested confidentiality or that no investigation be pursued.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this Title IX case record was first created in the system.',
    `determination_date` DATE COMMENT 'Date when the written determination regarding responsibility was issued.',
    `determination_outcome` STRING COMMENT 'Final determination regarding whether the respondent is responsible for violating Title IX policy.. Valid values are `responsible|not_responsible|insufficient_evidence|dismissed`',
    `determination_rationale` STRING COMMENT 'Written rationale explaining the basis for the determination outcome, including credibility assessments and evidence evaluation.',
    `formal_complaint_filed_date` DATE COMMENT 'Date when the formal Title IX complaint was filed by the complainant or signed by the Title IX Coordinator.',
    `grievance_process_type` STRING COMMENT 'Type of Title IX grievance process being followed for this case.. Valid values are `formal|informal|supportive_measures_only`',
    `hearing_date` DATE COMMENT 'Date when the live hearing was conducted for the Title IX case, if applicable.',
    `incident_date` DATE COMMENT 'Date when the alleged Title IX incident occurred.',
    `incident_description` STRING COMMENT 'Detailed narrative description of the alleged Title IX incident as reported by the complainant.',
    `incident_location` STRING COMMENT 'Description of the location where the alleged Title IX incident occurred (on-campus, off-campus, or specific building/area).',
    `interim_measures_flag` BOOLEAN COMMENT 'Indicates whether emergency removal or administrative leave was implemented during the investigation.',
    `investigation_completion_date` DATE COMMENT 'Date when the Title IX investigation was completed and investigative report finalized.',
    `investigation_start_date` DATE COMMENT 'Date when the formal Title IX investigation commenced.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this Title IX case record was last updated.',
    `law_enforcement_notified_flag` BOOLEAN COMMENT 'Indicates whether local law enforcement was notified of the incident.',
    `ocr_complaint_filed_flag` BOOLEAN COMMENT 'Indicates whether a complaint was filed with the U.S. Department of Education Office for Civil Rights related to this case.',
    `report_date` DATE COMMENT 'Date when the Title IX complaint was officially reported to the institution.',
    `respondent_type` STRING COMMENT 'Classification of the respondents relationship to the institution. [ENUM-REF-CANDIDATE: student|employee|faculty|staff|visitor|contractor|other — 7 candidates stripped; promote to reference product]',
    `retaliation_reported_flag` BOOLEAN COMMENT 'Indicates whether retaliation against the complainant or witnesses was reported during or after the case.',
    `sanctions_imposed` STRING COMMENT 'Description of disciplinary sanctions or remedies imposed on the respondent if found responsible.',
    `supportive_measures_provided` STRING COMMENT 'Description of non-disciplinary, non-punitive individualized services offered to complainant and/or respondent.',
    CONSTRAINT pk_title_ix_case PRIMARY KEY(`title_ix_case_id`)
) COMMENT 'Tracks Title IX complaints, investigations, and resolutions as required under the U.S. Department of Education Title IX regulations. Captures complainant type, respondent type, incident date, report date, case type (sexual harassment, sexual assault, stalking, dating violence), assigned investigator, grievance process type (formal/informal), hearing panel details, determination outcome, appeal status, sanctions imposed, and case closure date. Supports mandatory Title IX coordinator reporting and OCR audit readiness.';

CREATE OR REPLACE TABLE `education_ecm`.`compliance`.`clery_incident` (
    `clery_incident_id` BIGINT COMMENT 'Unique identifier for the Clery Act reportable incident. Primary key for the clery_incident data product.',
    `building_id` BIGINT COMMENT 'Foreign key linking to facility.building. Business justification: Clery Act incidents (campus crimes, safety incidents) occur in specific campus buildings. This FK links compliance.clery_incident to the facility building master, enabling geographic analysis of campu',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Clery Act requires tracking Campus Security Authority who received/reported incident. CSA designation is employee role. Enables CSA training compliance reporting and incident audit trails required by ',
    `cybersecurity_incident_id` BIGINT COMMENT 'Foreign key linking to technology.cybersecurity_incident. Business justification: Clery Act incidents may involve cybersecurity events: stalking via email, unauthorized access to victim records, image-based abuse distributed electronically. Campus safety and IT security must coordi',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Clery Act incident reporting is a specific federal regulatory requirement (Jeanne Clery Disclosure of Campus Security Policy and Campus Crime Statistics Act). Each incident is tracked under this regul',
    `residence_hall_id` BIGINT COMMENT 'Foreign key linking to studentlife.residence_hall. Business justification: Clery Act requires geographic classification of crimes; residence halls are on-campus residential facilities requiring specific reporting. Compliance offices must accurately categorize incidents by bu',
    `studentlife_housing_assignment_id` BIGINT COMMENT 'Foreign key linking to studentlife.housing_assignment. Business justification: Clery incidents involving students in housing require tracking victim/respondent housing status for timely warnings, supportive measures, and no-contact order enforcement. Campus safety and housing mu',
    `arrest_made` BOOLEAN COMMENT 'Indicates whether an arrest was made in connection with this incident. Arrests are reported separately in the Annual Security Report (ASR) statistics for certain offense categories.',
    `case_number` STRING COMMENT 'Official case number assigned by the law enforcement agency investigating the incident. Used for cross-referencing with police reports and court proceedings.',
    `clery_crime_category` STRING COMMENT 'The Clery Act crime classification for this incident as defined in the Handbook for Campus Safety and Security Reporting. Includes criminal offenses, hate crimes, and Violence Against Women Act (VAWA) offenses. Determines statistical reporting category in the Annual Security Report (ASR). [ENUM-REF-CANDIDATE: criminal_homicide|sex_offense_forcible|sex_offense_non_forcible|robbery|aggravated_assault|burglary|motor_vehicle_theft|arson|hate_crime|dating_violence|domestic_violence|stalking — 12 candidates stripped; promote to reference product]',
    `clery_geography_classification` STRING COMMENT 'The geographic classification of the incident location per Clery Act definitions: on-campus (including residential facilities), non-campus property (controlled by institution), public property (adjacent to campus), or not within Clery geography. Determines whether the incident must be included in Annual Security Report (ASR) statistics.. Valid values are `on_campus|on_campus_residential|non_campus|public_property|not_clery_geography`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this incident record was first created in the system. Used for audit trail and data lineage tracking.',
    `disciplinary_referral_made` BOOLEAN COMMENT 'Indicates whether the incident was referred for campus disciplinary action. Disciplinary referrals are reported separately in the Annual Security Report (ASR) for liquor law violations, drug law violations, and illegal weapons possession.',
    `disposition_status` STRING COMMENT 'Current status of the incident investigation and resolution. Tracks lifecycle from initial report through final disposition. Unfounded incidents are excluded from Clery statistics per federal guidance. [ENUM-REF-CANDIDATE: open|under_investigation|closed_arrest_made|closed_no_arrest|referred_for_prosecution|referred_for_disciplinary_action|unfounded|administratively_closed — 8 candidates stripped; promote to reference product]',
    `emergency_notification_issued` BOOLEAN COMMENT 'Indicates whether an emergency notification was issued in response to this incident. Emergency notifications are required for significant emergencies or dangerous situations involving an immediate threat to the health or safety of students or employees.',
    `hate_crime_bias_category` STRING COMMENT 'The bias motivation category for hate crime incidents as defined by the Clery Act and FBI Uniform Crime Reporting (UCR) Hate Crime Statistics Program. Required for hate crime statistical reporting in the Annual Security Report (ASR). [ENUM-REF-CANDIDATE: race|religion|sexual_orientation|gender|gender_identity|ethnicity|national_origin|disability — 8 candidates stripped; promote to reference product]',
    `incident_date` DATE COMMENT 'The calendar date on which the Clery reportable incident occurred. This is the principal business event timestamp for statistical reporting and Annual Security Report (ASR) compilation.',
    `incident_narrative` STRING COMMENT 'Detailed narrative description of the incident, including circumstances, actions taken, and outcomes. Used for internal investigation and case management. Confidential and not disclosed in public crime logs or Annual Security Report (ASR).',
    `incident_number` STRING COMMENT 'Business identifier assigned by campus security or law enforcement to uniquely identify this incident in operational systems. Used for cross-referencing with police reports and internal case management systems.. Valid values are `^[A-Z0-9]{6,20}$`',
    `incident_time` TIMESTAMP COMMENT 'The time of day (24-hour format HH:MM) when the incident occurred, if known. Used for temporal pattern analysis and resource allocation planning.',
    `included_in_asr` BOOLEAN COMMENT 'Indicates whether this incident was included in the institutions Annual Security Report (ASR) statistical disclosure to the U.S. Department of Education. Unfounded incidents and incidents outside Clery geography are excluded.',
    `is_hate_crime` BOOLEAN COMMENT 'Indicates whether the incident meets the definition of a hate crime under the Clery Act: a criminal offense motivated by bias based on race, religion, sexual orientation, gender, gender identity, ethnicity, national origin, or disability. Hate crimes are reported separately in the Annual Security Report (ASR).',
    `is_residential_facility` BOOLEAN COMMENT 'Indicates whether the incident occurred in an on-campus student housing facility. Residential facility incidents are reported as a separate sub-category in the Annual Security Report (ASR) per Clery Act requirements.',
    `is_vawa_offense` BOOLEAN COMMENT 'Indicates whether the incident is a Violence Against Women Act (VAWA) offense: dating violence, domestic violence, or stalking. VAWA offenses are reported separately in the Annual Security Report (ASR) and trigger specific victim notification and support obligations.',
    `law_enforcement_agency` STRING COMMENT 'Name of the law enforcement agency that responded to or investigated the incident (e.g., campus police, local police department, county sheriff). Used for inter-agency coordination and crime log documentation.',
    `location_description` STRING COMMENT 'Free-text description of the specific location where the incident occurred (e.g., building name, room number, parking lot, street address). Used for internal investigation and geographic pattern analysis.',
    `modified_by` STRING COMMENT 'Username or identifier of the user who last modified this incident record. Used for audit trail and accountability in compliance reporting.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this incident record was last modified. Used for audit trail and change tracking to ensure data integrity for regulatory reporting.',
    `reported_date` DATE COMMENT 'The date on which the incident was first reported to a Campus Security Authority (CSA) or law enforcement. Distinct from incident_date; used to track reporting lag and timely warning obligations.',
    `reporting_source` STRING COMMENT 'The source from which the incident was reported: Campus Security Authority (CSA), law enforcement, anonymous tip line, direct victim report, or third-party witness. Determines compliance with CSA reporting obligations.. Valid values are `campus_security_authority|law_enforcement|anonymous_tip|victim_report|third_party`',
    `reporting_year` STRING COMMENT 'The calendar year in which the incident occurred, used for Annual Security Report (ASR) statistical compilation. Clery statistics are reported by calendar year, not academic or fiscal year.',
    `timely_warning_issued` BOOLEAN COMMENT 'Indicates whether a timely warning was issued to the campus community in response to this incident. Timely warnings are required for Clery crimes that represent a serious or continuing threat to students and employees.',
    `unfounded_reason` STRING COMMENT 'Explanation for why the incident was determined to be unfounded (false or baseless) through investigation by sworn or commissioned law enforcement personnel. Unfounded incidents are excluded from Clery statistics but must be documented and reported separately.',
    `victim_notification_provided` BOOLEAN COMMENT 'Indicates whether the victim was provided with written notification of rights, resources, and support services as required by the Clery Act and VAWA. Applies to victims of dating violence, domestic violence, sexual assault, and stalking.',
    CONSTRAINT pk_clery_incident PRIMARY KEY(`clery_incident_id`)
) COMMENT 'Records campus security incidents required for Clery Act Annual Security Report (ASR) disclosure. Captures incident date, location (on-campus, non-campus, public property, residential facility), Clery crime category (criminal homicide, sex offenses, robbery, aggravated assault, burglary, motor vehicle theft, arson, hate crimes, VAWA offenses), reporting source (CSA or law enforcement), disposition status, hate crime bias indicator, and geographic classification per Clery geography definitions. Feeds the annual CLERY statistical disclosure to the U.S. Department of Education.';

CREATE OR REPLACE TABLE `education_ecm`.`compliance`.`ada_accommodation` (
    `ada_accommodation_id` BIGINT COMMENT 'Unique identifier for the ADA accommodation record. Primary key for the accommodation request and approval lifecycle.',
    `term_id` BIGINT COMMENT 'Academic term when the accommodation becomes effective. Relevant for student accommodations tied to course enrollment.',
    `enterprise_application_id` BIGINT COMMENT 'Foreign key linking to technology.enterprise_application. Business justification: ADA accommodations are delivered via technology platforms: assistive tech in LMS, captioning services, accessible document formats in content management systems. OCR compliance reviews require institu',
    `employee_id` BIGINT COMMENT 'Identifier for the employee (faculty or staff) requesting accommodation. Links to the employee master record when requestor is an employee.',
    `profile_id` BIGINT COMMENT 'Identifier for the student requesting accommodation. Links to the student master record when requestor is a student.',
    `residence_room_id` BIGINT COMMENT 'Foreign key linking to studentlife.residence_room. Business justification: Disability services must track which specific rooms meet accommodation requirements (ADA features, bathroom type, bed height). Direct link enables verification that assigned room matches approved acco',
    `studentlife_housing_assignment_id` BIGINT COMMENT 'Foreign key linking to studentlife.housing_assignment. Business justification: ADA accommodations frequently drive specific housing assignments (accessible rooms, ground floor, proximity to facilities). Disability services coordinates directly with housing to implement approved ',
    `tertiary_ada_modified_by_employee_id` BIGINT COMMENT 'Employee identifier for the staff member who last modified this accommodation record. Supports audit trail and accountability.',
    `accommodation_description` STRING COMMENT 'Detailed description of the specific accommodation(s) approved, including implementation instructions and any limitations or conditions.',
    `accommodation_type` STRING COMMENT 'Primary category of accommodation approved. Multiple accommodations may be recorded as separate records or in accommodation details. [ENUM-REF-CANDIDATE: extended_time|note_taker|captioning|interpreter|accessible_housing|assistive_technology|flexible_schedule|modified_duties|ergonomic_equipment|accessible_parking|dietary|other — 12 candidates stripped; promote to reference product]',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this accommodation is currently active and in effect. False for expired, withdrawn, or superseded accommodations.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual cost incurred to implement the accommodation. Tracked for compliance reporting and budget management.',
    `appeal_date` DATE COMMENT 'Date the appeal was formally filed with the institution.',
    `appeal_filed_flag` BOOLEAN COMMENT 'Indicates whether the requestor filed a formal appeal of the accommodation decision.',
    `appeal_outcome` STRING COMMENT 'Result of the appeal review process.. Valid values are `upheld|overturned|modified|pending`',
    `approval_date` DATE COMMENT 'Date the accommodation was formally approved by the authorized coordinator or committee.',
    `approval_status` STRING COMMENT 'Current status of the accommodation request in the approval and implementation lifecycle.. Valid values are `approved|denied|pending|withdrawn|expired`',
    `confidentiality_agreement_signed_flag` BOOLEAN COMMENT 'Indicates whether the requestor signed the confidentiality agreement authorizing limited disclosure of accommodation information to implementing parties.',
    `cost_estimate` DECIMAL(18,2) COMMENT 'Estimated cost to implement the accommodation. Used for undue hardship analysis and budget planning.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this accommodation record was first created in the system.',
    `delivery_confirmation_date` DATE COMMENT 'Date the implementing office confirmed the accommodation was successfully delivered and available to the requestor.',
    `delivery_status` STRING COMMENT 'Current status of accommodation implementation by the responsible office. Tracks progress from approval to delivery.. Valid values are `not_started|in_progress|delivered|delayed|cancelled`',
    `denial_reason` STRING COMMENT 'Documented rationale for denial of accommodation request, typically citing undue hardship, fundamental alteration, or lack of nexus to disability.',
    `disability_category` STRING COMMENT 'High-level classification of the disability type for accommodation planning. Does not include specific diagnosis to maintain privacy. [ENUM-REF-CANDIDATE: learning|mobility|visual|hearing|psychological|chronic_health|temporary — 7 candidates stripped; promote to reference product]',
    `documentation_received_date` DATE COMMENT 'Date the institution received medical or professional documentation supporting the accommodation request.',
    `documentation_type` STRING COMMENT 'Type of professional documentation provided to support the accommodation request (medical evaluation, psychoeducational assessment, functional capacity evaluation).. Valid values are `medical|psychological|educational|functional`',
    `effective_end_date` DATE COMMENT 'Date the accommodation expires or is scheduled for renewal review. May be null for permanent accommodations.',
    `effective_start_date` DATE COMMENT 'Date the approved accommodation becomes active and available for use by the requestor.',
    `eligibility_determination` STRING COMMENT 'Outcome of the eligibility review process determining whether the requestor qualifies for accommodations under ADA or Section 504.. Valid values are `eligible|not_eligible|pending_review|additional_info_required`',
    `eligibility_determination_date` DATE COMMENT 'Date the eligibility determination was made by the disability services coordinator or accommodation review committee.',
    `implementing_office` STRING COMMENT 'Department or office responsible for delivering the accommodation (Disability Services, HR, Facilities, Registrar, Housing, IT).',
    `interactive_process_completed_flag` BOOLEAN COMMENT 'Indicates whether the required interactive process between requestor and institution was completed per ADA requirements.',
    `interactive_process_notes` STRING COMMENT 'Documentation of the interactive process discussions, alternatives considered, and rationale for final accommodation decision.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this accommodation record was last updated. Tracks changes throughout the accommodation lifecycle.',
    `notification_sent_date` DATE COMMENT 'Date the accommodation approval letter or notification was sent to the requestor and relevant implementing offices.',
    `ocr_complaint_filed_flag` BOOLEAN COMMENT 'Indicates whether a complaint related to this accommodation was filed with the U.S. Department of Education Office for Civil Rights.',
    `record_source_system` STRING COMMENT 'Source system from which this accommodation record originated (Accommodate, Clockwork, Banner, Workday, manual entry).',
    `renewal_date` DATE COMMENT 'Date by which the accommodation must be renewed or will automatically expire. Triggers notification to requestor and coordinator.',
    `renewal_required_flag` BOOLEAN COMMENT 'Indicates whether the accommodation requires periodic renewal with updated documentation. True for temporary or condition-specific accommodations.',
    `request_date` DATE COMMENT 'Date the accommodation request was formally submitted to the disability services office or HR accommodation coordinator.',
    `request_number` STRING COMMENT 'Business identifier for the accommodation request. Used for tracking and communication with requestor and implementing offices.',
    `requestor_type` STRING COMMENT 'Classification of the individual requesting accommodation. Determines applicable compliance framework and approval workflow.. Valid values are `student|faculty|staff|visitor|applicant`',
    CONSTRAINT pk_ada_accommodation PRIMARY KEY(`ada_accommodation_id`)
) COMMENT 'Master record for ADA and Section 504 disability accommodation requests and approved accommodations for students, faculty, and staff. Captures requestor type, disability category, documentation received date, eligibility determination, accommodation type (extended time, captioning, interpreter, accessible housing, assistive technology), approval status, effective term, renewal date, implementing office, and accommodation delivery confirmation. Supports ADA/Section 504 compliance and OCR audit readiness.';

CREATE OR REPLACE TABLE `education_ecm`.`compliance`.`ferpa_disclosure` (
    `ferpa_disclosure_id` BIGINT COMMENT 'Unique identifier for each FERPA-governed disclosure of student education records to third parties. Primary key for the disclosure audit trail required by U.S. Department of Education regulations.',
    `authorizing_identity_account_id` BIGINT COMMENT 'Foreign key linking to technology.identity_account. Business justification: FERPA disclosures must be authorized by authenticated institutional users. Audit trails require linking disclosure events to NetID for accountability and non-repudiation. OCR audits verify that only a',
    `employee_id` BIGINT COMMENT 'Unique identifier of the institutional official who authorized the disclosure. Links to the employee master record for accountability and audit trail.',
    `health_visit_id` BIGINT COMMENT 'Foreign key linking to studentlife.health_visit. Business justification: FERPA disclosures of student health records must reference specific visits disclosed. Compliance tracking requires linking disclosure authorization to exact health visit records released. Essential fo',
    `identity_account_id` BIGINT COMMENT 'User identifier of the person who last modified this disclosure record. Used for accountability and audit trail purposes.',
    `profile_id` BIGINT COMMENT 'Unique identifier of the student whose education records were disclosed. Links to the student master record in the Student Information System (SIS).',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: FERPA disclosures are governed by specific provisions of the Family Educational Rights and Privacy Act (20 U.S.C. § 1232g). Each disclosure must comply with specific FERPA exceptions (e.g., school off',
    `academic_term_code` STRING COMMENT 'Code identifying the academic term to which the disclosed records pertain, if applicable. Used for contextualizing transcript and enrollment verification disclosures.',
    `audit_review_date` DATE COMMENT 'Date on which this disclosure record was reviewed during a FERPA compliance audit. Used for tracking audit coverage and compliance verification.',
    `audit_review_flag` BOOLEAN COMMENT 'Indicates whether this disclosure record has been reviewed as part of an internal or external FERPA compliance audit. True if reviewed, False if pending review.',
    `authorizing_official_title` STRING COMMENT 'Job title or position of the institutional official who authorized the disclosure. Used to verify legitimate educational interest and authorization authority.',
    `consent_date` DATE COMMENT 'Date on which the student or eligible parent provided written consent for the disclosure. Null if disclosure was made under a FERPA exception not requiring consent.',
    `consent_form_reference` STRING COMMENT 'Reference number or document identifier of the signed consent form authorizing the disclosure, if applicable. Links to the consent document repository for audit verification.',
    `consent_obtained_flag` BOOLEAN COMMENT 'Indicates whether written consent from the student (or parent if student is a dependent minor) was obtained prior to disclosure. True if consent was obtained, False if disclosure was made under a FERPA exception.',
    `court_jurisdiction` STRING COMMENT 'Name and jurisdiction of the court that issued the order or subpoena, if applicable. Used for legal compliance tracking and audit documentation.',
    `court_order_number` STRING COMMENT 'Reference number of the court order or subpoena compelling disclosure, if applicable. Required for disclosures made under judicial order exception.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this disclosure record was first created in the system. Used for audit trail and data lineage tracking.',
    `disclosure_date` DATE COMMENT 'The date on which the student education records were disclosed to the third party. This is the principal business event timestamp for FERPA compliance reporting.',
    `disclosure_method` STRING COMMENT 'The method or channel through which the education records were transmitted to the recipient. Used for security audit and compliance with data protection requirements. [ENUM-REF-CANDIDATE: electronic_secure_portal|email_encrypted|postal_mail|fax|in_person_pickup|phone_verbal|electronic_transcript_service — 7 candidates stripped; promote to reference product]',
    `disclosure_notes` STRING COMMENT 'Additional notes, comments, or context regarding the disclosure event. Used for documenting special circumstances, follow-up actions, or compliance considerations.',
    `disclosure_number` STRING COMMENT 'Human-readable business identifier for the disclosure event, formatted as FERPA-YYYY-NNNNNN for external reference and audit tracking.. Valid values are `^FERPA-[0-9]{4}-[0-9]{6}$`',
    `disclosure_purpose` STRING COMMENT 'Detailed explanation of the legitimate educational interest, legal requirement, or other purpose for which the education records were disclosed. Required for FERPA compliance documentation.',
    `disclosure_status` STRING COMMENT 'Current lifecycle status of the disclosure record. Tracks the disclosure from authorization through completion and any subsequent review or dispute processes.. Valid values are `pending|completed|cancelled|under_review|disputed`',
    `disclosure_timestamp` TIMESTAMP COMMENT 'Precise date and time when the disclosure occurred, including time zone. Used for detailed audit trail and chronological sequencing of disclosure events.',
    `emergency_justification` STRING COMMENT 'Detailed explanation of the health or safety emergency that justified disclosure without consent under the FERPA emergency exception. Required for emergency disclosures.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this disclosure record was last updated. Used for tracking changes to disclosure documentation and audit trail integrity.',
    `legal_basis` STRING COMMENT 'The specific FERPA exception or legal authority under which the disclosure was made. Determines whether student consent was required and governs redisclosure restrictions. [ENUM-REF-CANDIDATE: written_consent|legitimate_educational_interest|directory_information|school_transfer|financial_aid|accreditation|judicial_order|subpoena|health_safety_emergency|state_local_authorities|audit_evaluation — 11 candidates stripped; promote to reference product]',
    `recipient_email` STRING COMMENT 'Email address of the recipient for follow-up communication and verification of disclosure receipt. Used for electronic disclosure confirmation.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `recipient_name` STRING COMMENT 'Full name of the individual or organization that received the disclosed education records. Required for FERPA audit trail and compliance verification.',
    `recipient_organization` STRING COMMENT 'Name of the organization or institution to which the recipient is affiliated, if applicable. Used for tracking disclosures to educational institutions, employers, and government agencies.',
    `recipient_phone` STRING COMMENT 'Contact phone number of the recipient for verification and follow-up regarding the disclosed records.',
    `recipient_type` STRING COMMENT 'Classification of the third party to whom the education records were disclosed. Determines applicable FERPA exception category and reporting requirements. [ENUM-REF-CANDIDATE: parent|legal_guardian|school_official|other_institution|employer|financial_aid_agency|accrediting_organization|court_order|law_enforcement|health_safety_emergency|research_organization — 11 candidates stripped; promote to reference product]',
    `record_type` STRING COMMENT 'Classification of the type of education records disclosed. Used for categorizing disclosures by record sensitivity and regulatory reporting requirements. [ENUM-REF-CANDIDATE: transcript|enrollment_verification|financial_aid_records|disciplinary_records|health_records|academic_progress|degree_audit|course_schedule|grades|attendance — 10 candidates stripped; promote to reference product]',
    `records_disclosed` STRING COMMENT 'Detailed description of the specific education records that were disclosed, including document types, date ranges, and content categories. Required for FERPA audit trail completeness.',
    `redisclosure_notification_text` STRING COMMENT 'The exact text of the redisclosure restriction notification provided to the recipient, as required by FERPA regulations. Documents compliance with notification requirements.',
    `redisclosure_restriction_flag` BOOLEAN COMMENT 'Indicates whether the recipient was notified that the disclosed records may not be redisclosed without student consent. True if redisclosure restrictions apply per FERPA requirements.',
    `student_notification_date` DATE COMMENT 'Date on which the student was notified of the disclosure, if notification was required. Used for compliance with FERPA notification requirements.',
    `student_notification_flag` BOOLEAN COMMENT 'Indicates whether the student was notified of the disclosure. True if notification was provided, False if notification was not required or not yet completed.',
    CONSTRAINT pk_ferpa_disclosure PRIMARY KEY(`ferpa_disclosure_id`)
) COMMENT 'Tracks all FERPA-governed disclosures of student education records to third parties. Captures student identifier, disclosure date, recipient type (parent, employer, law enforcement, court order, accreditor), disclosure purpose, legal basis for disclosure (consent, legitimate educational interest, health/safety emergency, judicial order), records disclosed, authorizing official, and consent form reference. Mandatory for FERPA compliance audit trail and U.S. Department of Education reporting.';

CREATE OR REPLACE TABLE `education_ecm`.`compliance`.`accreditation_review` (
    `accreditation_review_id` BIGINT COMMENT 'Unique identifier for the accreditation review record. Primary key for the accreditation review entity.',
    `academic_program_id` BIGINT COMMENT 'Reference to the specific academic program under review for programmatic accreditation. Null for institutional accreditation reviews.',
    `accrediting_body_id` BIGINT COMMENT 'FK to compliance.accrediting_body',
    `accreditation_standard_id` BIGINT COMMENT 'Foreign key linking to compliance.accreditation_standard. Business justification: Each accreditation review cycle evaluates the institution against a specific set of standards from the accrediting body. The review assesses compliance with individual standards. FK will be populated ',
    `enterprise_application_id` BIGINT COMMENT 'Foreign key linking to technology.enterprise_application. Business justification: Accreditation reviews assess institutional technology infrastructure (SIS, LMS, library systems, advising platforms) for standards compliance. Accreditors require evidence that systems support learnin',
    `identity_account_id` BIGINT COMMENT 'User identifier of the person who created this accreditation review record in the system.',
    `employee_id` BIGINT COMMENT 'Employee identifier for the self-study coordinator, linking to the institutional human resources system.',
    `student_org_id` BIGINT COMMENT 'Foreign key linking to studentlife.student_org. Business justification: Program accreditation reviews assess student engagement and co-curricular learning. Accreditors review student organization participation data as evidence of program quality and student development ou',
    `updated_by_user_identity_account_id` BIGINT COMMENT 'User identifier of the person who last modified this accreditation review record in the system.',
    `accreditation_decision_date` DATE COMMENT 'Official date the accrediting body issued its accreditation decision following review of the self-study and site visit reports.',
    `accreditation_effective_date` DATE COMMENT 'Date the accreditation status becomes effective. May differ from decision date due to administrative processing or appeal periods.',
    `accreditation_expiration_date` DATE COMMENT 'Date the current accreditation status expires, triggering the next review cycle. Null for denied or withdrawn status.',
    `accreditation_status` STRING COMMENT 'Current accreditation standing resulting from the review: accredited (initial grant), reaffirmed (renewed), probation (conditional status with deficiencies), show-cause (at risk of loss), withdrawn (voluntarily surrendered), denied (not granted), or deferred (decision postponed). [ENUM-REF-CANDIDATE: accredited|reaffirmed|probation|show_cause|withdrawn|denied|deferred — 7 candidates stripped; promote to reference product]',
    `accreditation_type` STRING COMMENT 'Classification of the accreditation scope: institutional (entire institution), programmatic (specific academic program or department), or specialized (professional/discipline-specific).. Valid values are `institutional|programmatic|specialized`',
    `appeal_filed_date` DATE COMMENT 'Date the formal appeal of the accreditation decision was filed with the accrediting body. Null if no appeal was filed.',
    `appeal_filed_flag` BOOLEAN COMMENT 'Indicator of whether the institution or program filed a formal appeal of the accreditation decision (True) or not (False).',
    `appeal_outcome` STRING COMMENT 'Result of the appeal process: upheld (original decision stands), overturned (decision reversed), modified (decision changed), or pending (under review). Null if no appeal was filed.. Valid values are `upheld|overturned|modified|pending`',
    `appeal_resolution_date` DATE COMMENT 'Date the appeal process was concluded and final outcome determined. Null if no appeal was filed or appeal is still pending.',
    `cip_code` STRING COMMENT 'Six-digit CIP code identifying the academic discipline or program area under review (format: XX.XXXX). Used for programmatic accreditation alignment.. Valid values are `^d{2}.d{4}$`',
    `conditions_issued_flag` BOOLEAN COMMENT 'Indicator of whether the accrediting body issued formal conditions, stipulations, or requirements that must be addressed (True) or not (False).',
    `conditions_summary` STRING COMMENT 'Summary text of formal conditions, stipulations, or requirements issued by the accrediting body that the institution or program must address.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this accreditation review record was first created in the system.',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated or actual financial impact of the accreditation review process, including self-study preparation costs, site visit expenses, consultant fees, and remediation costs. Expressed in US dollars.',
    `interim_report_due_date` DATE COMMENT 'Deadline for submission of the required interim progress report to the accrediting body. Null if no interim report is required.',
    `interim_report_required_flag` BOOLEAN COMMENT 'Indicator of whether the institution or program is required to submit an interim progress report before the next full review cycle (True) or not (False).',
    `interim_report_submitted_date` DATE COMMENT 'Actual date the interim progress report was submitted to the accrediting agency. Null if not yet submitted or not required.',
    `next_review_due_date` DATE COMMENT 'Scheduled date for the next comprehensive accreditation review cycle to commence.',
    `public_disclosure_date` DATE COMMENT 'Date the accreditation status and any conditions were publicly disclosed on the institutional website or through official channels.',
    `public_disclosure_required_flag` BOOLEAN COMMENT 'Indicator of whether the accreditation status and any conditions must be publicly disclosed per regulatory requirements (True) or not (False).',
    `recommendations_issued_flag` BOOLEAN COMMENT 'Indicator of whether the accrediting body issued advisory recommendations for improvement (True) or not (False). Recommendations are non-binding guidance.',
    `recommendations_summary` STRING COMMENT 'Summary text of advisory recommendations for improvement issued by the accrediting body. These are non-binding suggestions for enhancement.',
    `review_coordinator_notes` STRING COMMENT 'Internal notes and observations from the institutional accreditation coordinator regarding the review process, challenges, lessons learned, and follow-up actions.',
    `review_cycle_type` STRING COMMENT 'Type of accreditation review cycle being conducted: initial (first-time accreditation), reaffirmation (renewal), focused visit (targeted review), interim monitoring (progress check), substantive change (major institutional change), or comprehensive (full evaluation).. Valid values are `initial|reaffirmation|focused_visit|interim_monitoring|substantive_change|comprehensive`',
    `review_period_end_date` DATE COMMENT 'Date marking the conclusion of the accreditation review cycle or evaluation period.',
    `review_period_start_date` DATE COMMENT 'Date marking the beginning of the accreditation review cycle or evaluation period.',
    `self_study_due_date` DATE COMMENT 'Deadline for submission of the institutional or programmatic self-study report to the accrediting body.',
    `self_study_lead_name` STRING COMMENT 'Full name of the faculty or administrative leader responsible for coordinating the self-study process and report preparation.',
    `self_study_submitted_date` DATE COMMENT 'Actual date the self-study report was submitted to the accrediting agency.',
    `site_visit_end_date` DATE COMMENT 'Scheduled end date for the accreditation site visit. Null for single-day visits.',
    `site_visit_scheduled_date` DATE COMMENT 'Scheduled date for the accreditation site visit by the peer review team. Represents the start date for multi-day visits.',
    `site_visit_team_chair` STRING COMMENT 'Full name of the peer reviewer serving as chair of the site visit evaluation team.',
    `site_visit_team_size` STRING COMMENT 'Number of peer reviewers on the site visit evaluation team.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this accreditation review record was last modified in the system.',
    CONSTRAINT pk_accreditation_review PRIMARY KEY(`accreditation_review_id`)
) COMMENT 'Master record for institutional and programmatic accreditation review cycles. Captures accrediting body (HLC, SACSCOC, ABET, AACSB, ABA, LCME, MSCHE), accreditation type (institutional, programmatic), review cycle type (initial, reaffirmation, focused visit, interim monitoring), review period start and end dates, self-study lead, site visit date, accreditation status (accredited, probation, show-cause, withdrawn), conditions or recommendations issued, and next review date. Central governance record for all accreditation activities.';

CREATE OR REPLACE TABLE `education_ecm`.`compliance`.`accreditation_standard` (
    `accreditation_standard_id` BIGINT COMMENT 'Primary key for accreditation_standard',
    `accrediting_body_id` BIGINT COMMENT 'Reference to the accrediting agency or body that issued this standard. Links to the accrediting organization responsible for oversight (e.g., HLC, SACSCOC, AACSB, ABET).',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to hr.org_unit. Business justification: Accreditation standards assign organizational accountability for compliance evidence collection and maintenance. Enables workload distribution reporting, evidence request routing, and organizational c',
    `accreditor_guidance_url` STRING COMMENT 'Web link to the accrediting bodys official guidance, handbook, or resource page for this standard, providing authoritative reference material.',
    `applicability_level` STRING COMMENT 'Indicates whether this standard applies at the institutional level (entire university), program level (specific degree programs), or other organizational unit.. Valid values are `institutional|program|departmental|college|school`',
    `compliance_notes` STRING COMMENT 'Free-text field for institutional notes, observations, or context regarding compliance status, challenges, corrective actions, or improvement plans for this standard.',
    `compliance_status` STRING COMMENT 'Current institutional compliance status for this accreditation standard, reflecting the most recent self-study or review outcome.. Valid values are `compliant|non_compliant|partially_compliant|under_review|not_applicable|pending_evidence`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this accreditation standard record was first created in the institutional compliance system.',
    `criterion_description` STRING COMMENT 'Detailed narrative description of the accreditation criterion, including expectations, requirements, and evidence guidelines as defined by the accrediting body.',
    `effective_date` DATE COMMENT 'The date on which this version of the accreditation standard became effective and institutions were required to demonstrate compliance.',
    `evidence_requirement_summary` STRING COMMENT 'Summary of the types of evidence, documentation, or artifacts required to demonstrate compliance with this standard (e.g., policies, data reports, assessment results, meeting minutes).',
    `expiration_date` DATE COMMENT 'The date on which this version of the standard is superseded or no longer in effect. Null if the standard remains current.',
    `is_core_requirement` BOOLEAN COMMENT 'Boolean flag indicating whether this standard is a core or foundational requirement (true) versus a supplementary or optional criterion (false). Core requirements are typically non-negotiable for accreditation.',
    `last_review_date` DATE COMMENT 'The date on which this standard was most recently reviewed by the institution or the accrediting body during a site visit, self-study, or interim report.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next formal review or assessment of compliance with this standard, typically aligned with accreditation cycles.',
    `priority_level` STRING COMMENT 'Internal institutional priority assigned to this standard based on risk, resource requirements, or strategic importance for accreditation maintenance.. Valid values are `critical|high|medium|low`',
    `standard_category` STRING COMMENT 'The thematic category or domain to which this standard belongs, grouping related criteria for organizational and reporting purposes. [ENUM-REF-CANDIDATE: mission|governance|faculty|curriculum|student_support|financial_resources|assessment|institutional_effectiveness|educational_quality|integrity — 10 candidates stripped; promote to reference product]',
    `standard_number` STRING COMMENT 'The official alphanumeric identifier assigned by the accrediting body to this standard or criterion (e.g., Criterion 3.A, Standard 4.2, Principle II.B).',
    `standard_title` STRING COMMENT 'The official title or short name of the accreditation standard as published by the accrediting body.',
    `standard_version` STRING COMMENT 'Version identifier for the standard, as accrediting bodies periodically revise and update their criteria. Tracks which edition of the standard is in effect.',
    `standard_weight` DECIMAL(18,2) COMMENT 'Numeric weight or scoring factor assigned to this standard by the accrediting body or institution, used in aggregate compliance scoring or risk assessment models.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this accreditation standard record was most recently updated, reflecting changes to compliance status, notes, or standard details.',
    CONSTRAINT pk_accreditation_standard PRIMARY KEY(`accreditation_standard_id`)
) COMMENT 'Catalog of accreditation standards and criteria from each accrediting body applicable to the institution or its programs. Captures accrediting body, standard number, standard title, criterion description, standard category (mission, governance, faculty, curriculum, student support, financial resources, assessment), applicability (institutional or program-level), and current compliance status. Used to map self-study evidence and corrective actions to specific accreditation criteria.';

CREATE OR REPLACE TABLE `education_ecm`.`compliance`.`corrective_action` (
    `corrective_action_id` BIGINT COMMENT 'Unique identifier for the corrective action plan record. Primary key.',
    `accreditation_review_id` BIGINT COMMENT 'Foreign key linking to compliance.accreditation_review. Business justification: Corrective action plans are frequently issued in response to accreditation review findings (conditions, recommendations, or areas needing improvement). When finding_source indicates accreditation, thi',
    `audit_finding_id` BIGINT COMMENT 'Reference to the audit finding, accreditation condition, or regulatory citation that triggered this corrective action plan.',
    `employee_id` BIGINT COMMENT 'Reference to the employee designated as the primary owner of the corrective action plan, typically a director, dean, or vice president.',
    `org_unit_id` BIGINT COMMENT 'Reference to the department, division, or organizational unit responsible for implementing the corrective action plan.',
    `policy_id` BIGINT COMMENT 'Reference to the institutional policy that was violated or requires revision as part of the corrective action plan.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: corrective_action currently has regulatory_framework as a STRING field. While corrective_action already links to audit_finding (which links to regulatory_requirement), many corrective actions are issu',
    `actual_completion_date` DATE COMMENT 'Date on which the corrective action plan was actually completed and all remediation activities were finalized. Null if still in progress.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual financial cost incurred to implement the corrective action plan. Null if implementation is not yet complete or costs have not been fully reconciled.',
    `board_notification_required` BOOLEAN COMMENT 'Indicates whether the board of trustees must be formally notified of this corrective action plan due to materiality, reputational risk, or governance requirements.',
    `cap_number` STRING COMMENT 'Business identifier for the corrective action plan, typically assigned by the compliance office or audit management system.',
    `closure_date` DATE COMMENT 'Date on which the corrective action plan was officially closed by the auditor, accreditor, or regulatory agency, indicating full resolution of the finding.',
    `closure_status` STRING COMMENT 'Indicates whether the corrective action plan has been officially closed by the auditor, accreditor, or regulatory agency. Open means still active; pending verification means awaiting final review; verified means accepted but not yet formally closed; closed means officially resolved; reopened means previously closed but reactivated due to recurrence.. Valid values are `open|pending_verification|verified|closed|reopened`',
    `corrective_action_description` STRING COMMENT 'Detailed narrative of the corrective actions to be taken to remediate the finding, including specific steps, process changes, policy revisions, training programs, or system enhancements.',
    `corrective_action_status` STRING COMMENT 'Current lifecycle status of the corrective action plan. Draft indicates initial planning; submitted means plan has been sent to auditors/accreditors; in progress indicates active implementation; under review means awaiting validation; completed means actions finished; closed means finding officially resolved; overdue indicates missed target date. [ENUM-REF-CANDIDATE: draft|submitted|in_progress|under_review|completed|closed|overdue — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the corrective action plan record was first created in the system.',
    `escalation_date` DATE COMMENT 'Date on which the corrective action plan was escalated to senior leadership or the board of trustees. Null if no escalation occurred.',
    `escalation_required` BOOLEAN COMMENT 'Indicates whether the corrective action plan requires escalation to senior leadership, the board of trustees, or external authorities due to severity, cost, or strategic impact.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Estimated financial cost to implement the corrective action plan, including personnel time, technology investments, consulting fees, training expenses, and other resources.',
    `evidence_of_remediation` STRING COMMENT 'Documentation or artifacts demonstrating that the corrective action has been implemented and the finding has been remediated. May include policy documents, training records, system screenshots, process flowcharts, or audit reports.',
    `external_report_date` DATE COMMENT 'Date on which the corrective action plan was reported to external agencies. Null if external reporting has not yet occurred or is not required.',
    `external_reporting_required` BOOLEAN COMMENT 'Indicates whether the corrective action plan must be reported to external agencies such as the U.S. Department of Education, accreditors, state regulators, or other oversight bodies.',
    `finding_description` STRING COMMENT 'Detailed description of the audit finding, accreditation condition, regulatory citation, or compliance deficiency that this corrective action plan addresses.',
    `finding_source` STRING COMMENT 'Origin of the finding that necessitated this corrective action. Indicates whether the issue was identified by external auditors, internal auditors, accreditation bodies, regulatory agencies, institutional self-assessment, or peer review.. Valid values are `external_audit|internal_audit|accreditor|regulatory_agency|self_assessment|peer_review`',
    `implementation_plan` STRING COMMENT 'Structured plan outlining the phases, milestones, resources, and timeline for executing the corrective action. May include project management details and dependencies.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when the corrective action plan record was most recently modified, reflecting the latest status, milestone completion, or other updates.',
    `milestone_count` STRING COMMENT 'Total number of implementation milestones or checkpoints defined in the corrective action plan. Used to track progress granularity.',
    `milestones_completed` STRING COMMENT 'Number of implementation milestones that have been successfully completed to date. Used to calculate progress percentage.',
    `monitoring_frequency` STRING COMMENT 'Frequency at which the corrective action and related processes will be monitored post-implementation to ensure sustained compliance and prevent recurrence.. Valid values are `daily|weekly|monthly|quarterly|annually|as_needed`',
    `notes` STRING COMMENT 'Additional comments, context, or observations related to the corrective action plan, including challenges encountered, lessons learned, or recommendations for future improvements.',
    `recurrence_risk` STRING COMMENT 'Assessment of the likelihood that the finding will recur after the corrective action is implemented. High risk indicates systemic issues requiring ongoing monitoring; low risk indicates isolated incidents unlikely to repeat.. Valid values are `high|moderate|low`',
    `responsible_officer_name` STRING COMMENT 'Full name of the institutional officer or administrator responsible for overseeing the corrective action plan implementation.',
    `responsible_unit_name` STRING COMMENT 'Name of the department, division, or organizational unit accountable for executing the corrective action plan (e.g., Financial Aid Office, Registrar, Human Resources, Athletics).',
    `severity_level` STRING COMMENT 'Classification of the finding severity based on risk to institutional compliance, financial impact, or reputational harm. Critical findings require immediate action; low findings may be addressed over longer timeframes.. Valid values are `critical|high|moderate|low`',
    `target_completion_date` DATE COMMENT 'Planned date by which the corrective action plan is expected to be fully implemented and the finding remediated. Often negotiated with auditors or accreditors.',
    `verification_date` DATE COMMENT 'Date on which the corrective action was verified as complete by the auditor, accreditor, or compliance officer. Null if verification has not yet occurred.',
    `verification_method` STRING COMMENT 'Method used by auditors, accreditors, or compliance officers to verify that the corrective action has been successfully implemented and the finding resolved.. Valid values are `document_review|site_visit|data_analysis|interview|testing|observation`',
    `verified_by` STRING COMMENT 'Name or identifier of the auditor, accreditor, compliance officer, or other authority who verified the completion and effectiveness of the corrective action.',
    CONSTRAINT pk_corrective_action PRIMARY KEY(`corrective_action_id`)
) COMMENT 'Tracks corrective action plans (CAPs) issued in response to audit findings, accreditation conditions, regulatory citations, or internal compliance reviews. Captures finding source (external audit, internal audit, accreditor, regulatory agency), finding description, severity level, responsible unit, corrective action description, implementation milestones, target completion date, actual completion date, evidence of remediation, and closure status. Supports ongoing monitoring of institutional compliance remediation.';

CREATE OR REPLACE TABLE `education_ecm`.`compliance`.`audit_finding` (
    `audit_finding_id` BIGINT COMMENT 'Unique identifier for the audit finding record. Primary key.',
    `accreditation_review_id` BIGINT COMMENT 'Foreign key linking to compliance.accreditation_review. Business justification: Audit findings can arise from accreditation site visits and reviews. When audit_type indicates an accreditation review, this FK links the finding to the specific review cycle. FK will be NULL for non-',
    `audit_id` BIGINT COMMENT 'Reference to the parent audit engagement or review that produced this finding.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Audit findings must cite the specific regulatory requirement or standard that was violated. The criteria field (text description of the standard) becomes redundant when we can FK to the authoritative ',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Audit finding resolution requires independent verification by qualified personnel. Links verifier identity for accountability, enables verification workload tracking, and provides audit trail required',
    `actual_completion_date` DATE COMMENT 'The date on which the corrective action was actually completed and verified, if applicable.',
    `affected_program` STRING COMMENT 'The name of the academic program, administrative unit, or operational area to which the finding applies.',
    `affected_unit` STRING COMMENT 'The specific department, division, or organizational unit responsible for the area where the finding was identified.',
    `audit_period_end_date` DATE COMMENT 'The ending date of the period under audit review.',
    `audit_period_start_date` DATE COMMENT 'The beginning date of the period under audit review.',
    `audit_type` STRING COMMENT 'The type of audit or review that generated this finding (internal audit, external audit, federal program review, A-133/Uniform Guidance single audit, accreditation review, NCAA certification, Title IV program review, state audit). [ENUM-REF-CANDIDATE: internal|external|federal_program_review|single_audit|accreditation_review|ncaa_certification|title_iv_program_review|state_audit — 8 candidates stripped; promote to reference product]',
    `auditing_entity` STRING COMMENT 'The name of the organization or body that conducted the audit and issued the finding (e.g., internal audit department, external CPA firm, U.S. Department of Education, regional accreditor, state auditor).',
    `cause` STRING COMMENT 'The underlying reason or root cause that led to the condition—why the deficiency occurred (e.g., lack of training, inadequate controls, resource constraints).',
    `cfda_number` STRING COMMENT 'The five-digit CFDA number (now known as Assistance Listings number) identifying the federal program to which the finding relates, if applicable (format: XX.XXX).. Valid values are `^[0-9]{2}.[0-9]{3}$`',
    `condition` STRING COMMENT 'A statement of what was found during the audit—the actual state or practice observed that deviates from the criteria.',
    `corrective_action_plan` STRING COMMENT 'Detailed plan outlining the specific steps, resources, timelines, and responsible parties for addressing and resolving the audit finding.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this audit finding record was first created in the system.',
    `effect` STRING COMMENT 'The actual or potential impact or consequence of the finding on the institution, program, or stakeholders (e.g., financial loss, compliance risk, reputational harm).',
    `federal_program_name` STRING COMMENT 'The name of the federal program associated with the CFDA number, if applicable (e.g., Federal Pell Grant Program, Federal Work-Study, NIH Research Grants).',
    `finding_category` STRING COMMENT 'Classification of the severity and nature of the finding per audit standards (material weakness, significant deficiency, noncompliance, observation, best practice recommendation, control deficiency).. Valid values are `material_weakness|significant_deficiency|noncompliance|observation|best_practice_recommendation|control_deficiency`',
    `finding_description` STRING COMMENT 'Detailed narrative describing the condition identified, the criteria or standard that was not met, the cause of the deficiency, and the effect or potential impact on the institution.',
    `finding_issued_date` DATE COMMENT 'The date on which the audit finding was formally issued or communicated to management in the audit report.',
    `finding_number` STRING COMMENT 'The externally-known unique identifier or reference number assigned to this finding within the audit report (e.g., 2024-A133-001).',
    `finding_title` STRING COMMENT 'A concise, descriptive title summarizing the nature of the audit finding.',
    `finding_type` STRING COMMENT 'The functional domain or regulatory area to which the finding pertains (financial, compliance, operational, information technology, Title IV financial aid, research administration, NCAA athletics, FERPA privacy, Clery Act campus safety, Title IX equity). [ENUM-REF-CANDIDATE: financial|compliance|operational|information_technology|title_iv|research|ncaa|ferpa|clery_act|title_ix — 10 candidates stripped; promote to reference product]',
    `management_response` STRING COMMENT 'The institutions official response to the finding, including agreement or disagreement with the finding, planned corrective actions, responsible parties, and target completion dates.',
    `notes` STRING COMMENT 'Additional notes, context, or supplementary information related to the finding, corrective actions, or follow-up activities.',
    `prior_finding_reference` STRING COMMENT 'Reference number of the prior audit finding if this is a repeat finding, enabling tracking of unresolved issues across audit cycles.',
    `questioned_costs_amount` DECIMAL(18,2) COMMENT 'The dollar amount of costs questioned by the auditor due to noncompliance, lack of supporting documentation, or unallowability under federal or state regulations.',
    `questioned_costs_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for questioned costs (typically USD for U.S. institutions).. Valid values are `^[A-Z]{3}$`',
    `recommendation` STRING COMMENT 'The auditors recommended corrective action or improvement to address the finding and prevent recurrence.',
    `repeat_finding_flag` BOOLEAN COMMENT 'Indicates whether this finding was previously identified in a prior audit period and has not been fully resolved (True = repeat finding, False = new finding).',
    `reported_to_federal_agency_flag` BOOLEAN COMMENT 'Indicates whether this finding was reported to a federal oversight agency such as the U.S. Department of Education or federal awarding agency (True = reported, False = not reported).',
    `reported_to_governing_board_flag` BOOLEAN COMMENT 'Indicates whether this finding was reported to the institutions Board of Trustees or governing body (True = reported, False = not reported).',
    `resolution_status` STRING COMMENT 'Current status of the finding in the corrective action lifecycle (open, in progress, pending verification, resolved, closed, overdue).. Valid values are `open|in_progress|pending_verification|resolved|closed|overdue`',
    `responsible_party` STRING COMMENT 'The name or title of the individual, department, or unit responsible for implementing the corrective action plan.',
    `risk_level` STRING COMMENT 'The assessed level of risk or priority associated with the finding based on potential impact and likelihood (critical, high, medium, low).. Valid values are `critical|high|medium|low`',
    `target_completion_date` DATE COMMENT 'The planned or committed date by which the corrective action is expected to be fully implemented and the finding resolved.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this audit finding record was last modified or updated.',
    `verification_date` DATE COMMENT 'The date on which the corrective action was verified as complete and effective by internal audit or other oversight body.',
    `verification_method` STRING COMMENT 'The method or process used to verify that the corrective action has been effectively implemented (e.g., follow-up audit, management certification, testing of controls).',
    CONSTRAINT pk_audit_finding PRIMARY KEY(`audit_finding_id`)
) COMMENT 'Records findings from internal audits, external audits (federal program reviews, A-133/Uniform Guidance single audits), and accreditation reviews. Captures audit type, auditing entity, audit period, finding number, finding category (material weakness, significant deficiency, noncompliance, observation), affected program or unit, federal program CFDA number if applicable, questioned costs, management response, and resolution status. Feeds corrective action planning and regulatory reporting.';

CREATE OR REPLACE TABLE `education_ecm`.`compliance`.`regulatory_filing` (
    `regulatory_filing_id` BIGINT COMMENT 'Unique identifier for the regulatory filing record. Primary key for the regulatory filing entity.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Regulatory filings are the deliverable for many tracked compliance obligations. The obligation record tracks the due date, responsible party, and status; the filing record captures the actual submissi',
    `original_filing_regulatory_filing_id` BIGINT COMMENT 'Reference to the original regulatory filing that this amended filing is correcting. Null for original filings. Links amended filings to their predecessors for audit trail purposes.',
    `identity_account_id` BIGINT COMMENT 'Foreign key linking to technology.identity_account. Business justification: Regulatory filings (IPEDS, Title IV, state reports) are prepared and submitted by authenticated users via institutional identity systems. Audit trails for federal compliance require linking submission',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Each regulatory filing satisfies a specific federal, state, or accreditation requirement. For example, an A-133 audit filing satisfies federal single audit requirements; a state authorization renewal ',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Regulatory filings (IPEDS, state reports) require documented internal review before submission. Links reviewer for accountability, enables workload tracking, and provides audit trail for data quality ',
    `academic_year` STRING COMMENT 'The academic year to which this filing pertains, typically expressed in format YYYY-YYYY (e.g., 2023-2024). Used for organizing filings by academic cycle.',
    `acceptance_date` DATE COMMENT 'The date on which the regulatory body officially accepted the filing as complete and compliant. Marks the successful completion of the filing obligation.',
    `certification_date` DATE COMMENT 'The date on which the authorized institutional official certified the accuracy and completeness of the filing. Must precede or match the submission date.',
    `certification_statement` STRING COMMENT 'The text of the certification or attestation statement signed by the authorized institutional official, affirming the accuracy and completeness of the filing. Required for many federal and accreditation filings.',
    `certifying_official_name` STRING COMMENT 'The name of the institutional official (e.g., President, CFO, Compliance Officer) who certified the accuracy of the filing. This individual assumes legal responsibility for the submission.',
    `certifying_official_title` STRING COMMENT 'The job title or position of the institutional official who certified the filing (e.g., President, Chief Financial Officer, Vice President for Compliance).',
    `confirmation_reference` STRING COMMENT 'The confirmation number, receipt identifier, or tracking code provided by the regulatory body upon successful submission. Serves as proof of filing and is used for follow-up inquiries.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this regulatory filing record was first created in the system. Part of the audit trail for record lifecycle tracking.',
    `document_repository_path` STRING COMMENT 'The file path or location in the institutional document management system where supporting documentation and the final filing package are stored. Used for audit trail and historical reference.',
    `due_date` DATE COMMENT 'The regulatory deadline by which this filing must be submitted to remain in compliance. Used to track on-time vs. late submissions.',
    `filing_description` STRING COMMENT 'A detailed description of the filing content, purpose, and scope. May include notes about special circumstances, data sources, or methodology used in preparing the filing.',
    `filing_number` STRING COMMENT 'The externally-known reference number or tracking identifier assigned to this regulatory filing by the institution or regulatory body. Used for correspondence and audit trail purposes.',
    `filing_period_end_date` DATE COMMENT 'The ending date of the reporting period covered by this regulatory filing. Defines the temporal scope of data included in the submission.',
    `filing_period_start_date` DATE COMMENT 'The beginning date of the reporting period covered by this regulatory filing. For annual filings, typically the start of the academic or fiscal year.',
    `filing_status` STRING COMMENT 'Current lifecycle status of the regulatory filing. Tracks the filing through its workflow from initial draft through final acceptance or rejection by the regulatory body. [ENUM-REF-CANDIDATE: draft|in_review|submitted|accepted|rejected|under_review|resubmitted|withdrawn — 8 candidates stripped; promote to reference product]',
    `filing_type` STRING COMMENT 'The category or type of regulatory filing. Identifies the specific compliance requirement being addressed (e.g., IPEDS for Integrated Postsecondary Education Data System, Clery ASR for Annual Security Report, Title IV PPA for Program Participation Agreement, NCAA APR for Academic Progress Rate, NCAA GSR for Graduation Success Rate, FISAP for Fiscal Operations Report and Application to Participate). [ENUM-REF-CANDIDATE: IPEDS|Clery ASR|Title IV PPA|NCAA APR|NCAA GSR|State Authorization|Gainful Employment|90/10 Rule|FISAP|Accreditation Self-Study — 10 candidates stripped; promote to reference product]',
    `filing_url` STRING COMMENT 'The web address or portal link where the filing was submitted or can be accessed for review. Provides direct access to the regulatory body submission system.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this filing pertains, expressed as a four-digit year (e.g., 2024 for FY2024). Used for financial and budgetary filings.',
    `is_amended_filing` BOOLEAN COMMENT 'Boolean flag indicating whether this filing is an amendment or correction to a previously accepted filing. True if this is a corrected resubmission, False for original filings.',
    `is_late_filing` BOOLEAN COMMENT 'Boolean flag indicating whether the filing was submitted after the regulatory deadline. True if submission_date is after due_date, False otherwise. Used for compliance monitoring and risk assessment.',
    `modified_by` STRING COMMENT 'The username or identifier of the system user who last modified this regulatory filing record. Used for accountability and audit purposes.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this regulatory filing record was last modified. Updated whenever any attribute of the filing is changed. Part of the audit trail for data lineage.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, comments, or context about the filing. May include information about data challenges, special circumstances, or follow-up actions required.',
    `preparer_email` STRING COMMENT 'The email address of the staff member who prepared the filing. Used for regulatory body follow-up and internal audit trail.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `preparer_name` STRING COMMENT 'The name of the institutional staff member who prepared the regulatory filing. Used for accountability and follow-up questions.',
    `preparer_phone` STRING COMMENT 'The contact phone number of the staff member who prepared the filing. Provided to regulatory bodies for clarification requests.',
    `regulatory_body` STRING COMMENT 'The name of the federal, state, or accreditation agency to which this filing is submitted (e.g., U.S. Department of Education, HLC, SACSCOC, NCAA, State Higher Education Commission).',
    `regulatory_body_code` STRING COMMENT 'Standardized code or abbreviation for the regulatory body (e.g., ED for Department of Education, HLC for Higher Learning Commission, SACSCOC for Southern Association of Colleges and Schools Commission on Colleges).',
    `rejection_date` DATE COMMENT 'The date on which the regulatory body rejected the filing. Used to track the timeline for corrective action and resubmission.',
    `rejection_reason` STRING COMMENT 'The reason provided by the regulatory body for rejecting the filing. Includes specific data quality issues, missing information, or compliance deficiencies that must be corrected before resubmission.',
    `resubmission_count` STRING COMMENT 'The number of times this filing has been resubmitted after initial rejection. Used to track data quality issues and process improvement opportunities.',
    `review_date` DATE COMMENT 'The date on which the filing was reviewed and approved by the designated reviewer. Documents the internal approval workflow.',
    `submission_date` DATE COMMENT 'The date on which the filing was officially submitted to the regulatory body. This is the business event date that determines compliance with filing deadlines.',
    `submission_method` STRING COMMENT 'The mechanism or channel through which the filing was submitted to the regulatory body (e.g., online portal, email, postal mail, electronic data exchange, API integration). [ENUM-REF-CANDIDATE: online_portal|email|postal_mail|fax|electronic_data_exchange|api|manual_upload — 7 candidates stripped; promote to reference product]',
    `submission_timestamp` TIMESTAMP COMMENT 'The precise date and time when the filing was submitted to the regulatory body, including time zone information. Used for audit trail and deadline verification purposes.',
    `submitting_office` STRING COMMENT 'The institutional office or department responsible for preparing and submitting this regulatory filing (e.g., Office of Institutional Research, Compliance Office, Financial Aid Office, Athletics Compliance).',
    CONSTRAINT pk_regulatory_filing PRIMARY KEY(`regulatory_filing_id`)
) COMMENT 'Tracks all mandatory regulatory filings and submissions to federal, state, and accreditation bodies. Captures filing type (IPEDS, Clery ASR, Title IV Program Participation Agreement, NCAA APR/GSR, state authorization, gainful employment, 90/10 rule), filing period, submitting office, submission date, submission method, filing status (draft, submitted, accepted, rejected, under review), regulatory body, and confirmation reference. Serves as the institutional calendar and audit trail for all external compliance submissions.';

CREATE OR REPLACE TABLE `education_ecm`.`compliance`.`training_program` (
    `training_program_id` BIGINT COMMENT 'Primary key for training_program',
    `certificate_template_id` BIGINT COMMENT 'Identifier for the certificate template used to generate completion certificates for this training program. References the document management or certificate generation system. Null if no certificate is issued.',
    `enterprise_application_id` BIGINT COMMENT 'Foreign key linking to technology.enterprise_application. Business justification: Compliance training (Title IX, FERPA, cybersecurity awareness) is delivered via enterprise LMS platforms (Canvas, Blackboard). Accreditors and auditors require tracking which system hosts each trainin',
    `identity_account_id` BIGINT COMMENT 'Identifier of the system user or administrator who created this training program record. Used for accountability and audit purposes.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to hr.org_unit. Business justification: Compliance training programs are owned and maintained by specific organizational units (HR, Title IX, EHS). Links owner for content update accountability, budget allocation, and organizational trainin',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Many compliance training programs are mandated by specific federal regulations (Title IX training, Clery Act training, FERPA training, export control training, etc.). The regulatory_basis text field b',
    `updated_by_user_identity_account_id` BIGINT COMMENT 'Identifier of the system user or administrator who last modified this training program record. Used for accountability and audit purposes.',
    `accessibility_compliant_flag` BOOLEAN COMMENT 'Indicates whether the training content meets ADA (Americans with Disabilities Act) and WCAG (Web Content Accessibility Guidelines) accessibility standards for learners with disabilities. True if compliant; false if not verified or non-compliant.',
    `accreditation_body` STRING COMMENT 'Name of the professional or accreditation organization that recognizes or awards credit for this training program (e.g., AACSB, ABET, state bar association, medical board). Null if no external accreditation applies.',
    `accreditation_credit_hours` DECIMAL(18,2) COMMENT 'Number of continuing education or professional development credit hours awarded for completion of this training, if applicable. Used for professional licensure and accreditation reporting. Null if no credit is awarded.',
    `audit_trail_required_flag` BOOLEAN COMMENT 'Indicates whether detailed audit trails of participant access, progress, and completion must be maintained for regulatory or accreditation purposes. True if audit trail is required; false for standard tracking only.',
    `certificate_issued_flag` BOOLEAN COMMENT 'Indicates whether a certificate of completion is issued to participants who successfully complete the training. True if certificate is issued; false if no certificate is provided.',
    `completion_deadline_days` STRING COMMENT 'Number of days from assignment date by which the training must be completed. Used to calculate individual due dates when training is assigned to users. Null if no specific deadline applies.',
    `contact_email` STRING COMMENT 'Email address of the department or individual responsible for questions, support, and administration of this training program. Used for participant inquiries and technical support.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Phone number of the department or individual responsible for questions, support, and administration of this training program. Used for participant inquiries and technical support.',
    `content_url` STRING COMMENT 'Web address or LMS (Learning Management System) link where the training content is hosted and accessible to assigned users. Used for direct navigation to training materials.. Valid values are `^https?://.*$`',
    `content_version` STRING COMMENT 'Version identifier for the training content, updated when material is revised to reflect regulatory changes, policy updates, or content improvements. Follows semantic versioning convention (e.g., v1.0, v2.1).. Valid values are `^v?[0-9]+.[0-9]+(.[0-9]+)?$`',
    `cost_per_learner` DECIMAL(18,2) COMMENT 'Cost in USD charged per learner for access to or completion of the training program. Used for budgeting and financial planning. Null for internally-developed training with no per-learner cost.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this training program record was first created in the system. Used for audit trail and data lineage tracking.',
    `delivery_modality` STRING COMMENT 'Method by which the training content is delivered to participants. Online training is completed via LMS (Learning Management System) or web portal; in-person training is conducted in physical sessions; hybrid combines online and in-person components; self-paced allows learners to complete at their own schedule; instructor-led requires scheduled sessions with a facilitator.. Valid values are `online|in_person|hybrid|self_paced|instructor_led`',
    `duration_minutes` STRING COMMENT 'Expected time in minutes required to complete the training program, including all modules, assessments, and required activities. Used for scheduling and compliance tracking.',
    `effective_end_date` DATE COMMENT 'Date on which this training program version is no longer effective or available for new assignments. Null for programs with no planned end date. Used to manage training content lifecycle and version transitions.',
    `effective_start_date` DATE COMMENT 'Date on which this training program version became or will become effective and available for assignment. Used to manage training content transitions and regulatory compliance effective dates.',
    `ipeds_reporting_flag` BOOLEAN COMMENT 'Indicates whether completion data for this training program must be included in IPEDS (Integrated Postsecondary Education Data System) reporting to the U.S. Department of Education. True if IPEDS reporting is required; false otherwise.',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code (optionally with ISO 3166-1 country code) indicating the primary language in which the training content is delivered (e.g., en for English, es for Spanish, en-US for US English).. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `learning_objectives` STRING COMMENT 'Specific, measurable learning outcomes that participants are expected to achieve upon completion of the training. Aligned with regulatory requirements and institutional policy goals.',
    `mobile_compatible_flag` BOOLEAN COMMENT 'Indicates whether the training content is optimized for and accessible on mobile devices (smartphones, tablets). True if mobile-compatible; false if desktop-only.',
    `passing_score_percentage` DECIMAL(18,2) COMMENT 'Minimum percentage score required on the training assessment to achieve completion status. Null if the training does not include a graded assessment. Expressed as a percentage (e.g., 80.00 represents 80%).',
    `recertification_frequency_months` STRING COMMENT 'Number of months after completion before the training must be retaken to maintain compliance. Common values include 12 (annual), 24 (biennial), or 36 (triennial). Null if the training is one-time only and does not require recertification.',
    `target_audience` STRING COMMENT 'Description of the population required to complete this training program. Examples include all employees, faculty only, student-athletes, new students, researchers with human subjects protocols, department chairs, Title IX coordinators, or other role-based or attribute-based cohorts.',
    `training_code` STRING COMMENT 'Externally-known unique code for the training program used in communications, reporting, and system integrations. Typically follows institutional coding standards.. Valid values are `^[A-Z0-9]{4,12}$`',
    `training_name` STRING COMMENT 'Official name of the compliance training program as displayed to users and in institutional documentation.',
    `training_program_description` STRING COMMENT 'Detailed description of the training program content, learning objectives, and compliance purpose. Provides context for administrators and participants about what the training covers and why it is required.',
    `training_program_status` STRING COMMENT 'Current lifecycle status of the training program. Active programs are available for assignment and completion; inactive programs are temporarily unavailable; under_review programs are being evaluated for content or policy updates; archived programs are retained for historical record but no longer assigned; draft programs are in development and not yet published.. Valid values are `active|inactive|under_review|archived|draft`',
    `training_type` STRING COMMENT 'Classification of the training program based on institutional requirement level. Mandatory training is required by law or policy; recommended training is strongly encouraged; optional training is available but not required; conditional training is required for specific roles or circumstances.. Valid values are `mandatory|recommended|optional|conditional`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this training program record was last modified. Used for audit trail, change tracking, and data quality monitoring.',
    `vendor_name` STRING COMMENT 'Name of the external vendor or content provider that developed or supplies the training program, if applicable. Null for internally-developed training. Used for vendor management and contract tracking.',
    CONSTRAINT pk_training_program PRIMARY KEY(`training_program_id`)
) COMMENT 'Master record for mandatory compliance training programs required by federal law, accreditation standards, or institutional policy. Captures training program name, regulatory basis (Title IX, Clery, FERPA, HIPAA, research ethics, conflict of interest, ADA), target audience (all employees, faculty, student-athletes, new students, researchers), delivery modality (online, in-person, hybrid), completion deadline, recertification frequency, and training content version. Distinct from course catalog — these are compliance-mandated training obligations.';

CREATE OR REPLACE TABLE `education_ecm`.`compliance`.`compliance_training_completion` (
    `compliance_training_completion_id` BIGINT COMMENT 'Unique identifier for the compliance training completion record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the individual who completed the training. Links to employee, faculty, student, or contractor records depending on trainee type.',
    `identity_account_id` BIGINT COMMENT 'Foreign key linking to technology.identity_account. Business justification: Training completion records must link to institutional identity (NetID) for audit trails, SSO authentication, and cross-system reporting. OCR audits and accreditation reviews require verifiable identi',
    `lms_course_shell_id` BIGINT COMMENT 'Unique identifier for the course in the Learning Management System (Canvas LMS or similar platform).',
    `training_program_id` BIGINT COMMENT 'Unique identifier for the compliance training program completed.',
    `accreditation_eligible_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this training completion can be used as evidence for accreditation self-studies and regulatory audits (True) or not (False).',
    `assessment_score` DECIMAL(18,2) COMMENT 'Numerical score achieved by the trainee on the training assessment, typically expressed as a percentage (0.00 to 100.00).',
    `assignment_date` DATE COMMENT 'Date when the training was assigned to the trainee.',
    `attempt_number` STRING COMMENT 'Sequential number indicating which attempt this represents if the trainee took the training multiple times.',
    `audit_trail_notes` STRING COMMENT 'Additional notes or comments related to the training completion for audit and compliance tracking purposes.',
    `browser_type` STRING COMMENT 'Web browser used by the trainee to access and complete the training.',
    `certificate_issue_date` DATE COMMENT 'Date when the completion certificate was officially issued to the trainee.',
    `certificate_issued_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a completion certificate was issued to the trainee (True) or not (False).',
    `certificate_number` STRING COMMENT 'Unique certificate identifier issued upon successful completion of the training program.',
    `completion_date` DATE COMMENT 'Date when the trainee successfully completed the compliance training program.',
    `completion_method` STRING COMMENT 'Delivery method through which the training was completed.. Valid values are `online|in_person|hybrid|webinar|self_paced|instructor_led`',
    `completion_status` STRING COMMENT 'Current status of the training completion record indicating whether the trainee successfully met all requirements.. Valid values are `completed|passed|failed|incomplete|waived|expired`',
    `completion_timestamp` TIMESTAMP COMMENT 'Precise date and time when the trainee completed the training, including time zone information for audit trail purposes.',
    `compliance_category` STRING COMMENT 'Primary regulatory or compliance domain that this training addresses. [ENUM-REF-CANDIDATE: title_ix|clery_act|ferpa|hipaa|irb|research_ethics|data_security|harassment_prevention — 8 candidates stripped; promote to reference product]',
    `data_source_system` STRING COMMENT 'Name of the source system from which this training completion record originated (e.g., Canvas LMS, Workday HCM, third-party compliance training platform).',
    `device_type` STRING COMMENT 'Type of device used by the trainee to complete the training.. Valid values are `desktop|laptop|tablet|mobile|other`',
    `due_date` DATE COMMENT 'Date by which the trainee was required to complete the training.',
    `expiration_date` DATE COMMENT 'Date when the training completion expires and recertification is required, if applicable.',
    `ip_address` STRING COMMENT 'IP address from which the trainee accessed and completed the training, captured for security and audit purposes.',
    `mandatory_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this training was mandatory (True) or voluntary (False) for the trainee.',
    `overdue_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the training was completed after the due date (True) or on time (False).',
    `pass_fail_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the trainee passed (True) or failed (False) the training assessment.',
    `passing_score_required` DECIMAL(18,2) COMMENT 'Minimum score required to pass the training assessment at the time of completion, captured for historical accuracy.',
    `recertification_frequency_months` STRING COMMENT 'Number of months between required recertifications for this training program.',
    `recertification_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether periodic recertification is required (True) or not (False) for this training program.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Date and time when this completion record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this completion record was last modified in the system.',
    `supervisor_notification_date` DATE COMMENT 'Date when the supervisor was notified of the training completion.',
    `supervisor_notified_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the trainees supervisor was notified of the completion (True) or not (False).',
    `trainee_type` STRING COMMENT 'Classification of the individual completing the training based on their relationship to the institution.. Valid values are `employee|faculty|student|contractor|volunteer|affiliate`',
    `training_duration_minutes` STRING COMMENT 'Total time in minutes the trainee spent completing the training program.',
    `training_provider` STRING COMMENT 'Name of the organization or vendor that provided the training content and platform.',
    `training_version` STRING COMMENT 'Version number or identifier of the training content completed, important for tracking content updates and ensuring compliance with current regulations.',
    `waiver_approved_by` STRING COMMENT 'Name or identifier of the individual who approved the training waiver.',
    `waiver_granted_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a waiver was granted exempting the trainee from completing this training (True) or not (False).',
    `waiver_reason` STRING COMMENT 'Explanation for why a training waiver was granted, if applicable.',
    CONSTRAINT pk_compliance_training_completion PRIMARY KEY(`compliance_training_completion_id`)
) COMMENT 'Transactional record of individual compliance training completions by employees, faculty, students, and contractors. Captures trainee identifier, trainee type, training program, completion date, assessment score, pass/fail status, certificate issued flag, completion method, and expiration date for recertification. Supports Title IX, Clery, FERPA, and research compliance training mandates and provides evidence for accreditation self-studies and regulatory audits.';

CREATE OR REPLACE TABLE `education_ecm`.`compliance`.`state_authorization` (
    `state_authorization_id` BIGINT COMMENT 'Unique identifier for the state authorization record. Primary key for tracking institutional compliance with state authorization requirements for distance education and physical presence activities.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: State authorization for distance education and physical presence is mandated by federal regulations (34 CFR 600.9) and varies by state. Each state authorization record fulfills a specific regulatory r',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: State authorization compliance requires designated institutional contact for agency communication. Enables accountability tracking, workload analysis, and ensures continuity when staff transitions. Re',
    `agency_contact_email` STRING COMMENT 'Email address of the primary contact person at the state agency for authorization communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `agency_contact_name` STRING COMMENT 'Name of the primary contact person at the state agency for authorization inquiries and correspondence.',
    `agency_contact_phone` STRING COMMENT 'Telephone number of the primary contact person at the state agency for authorization inquiries.',
    `agency_website_url` STRING COMMENT 'Web address of the state agency responsible for authorization. Provides access to application forms, requirements, and regulatory guidance.',
    `annual_report_due_date` DATE COMMENT 'Date by which the institution must submit the annual report to the state agency. Null if no annual report is required.',
    `annual_report_required_flag` BOOLEAN COMMENT 'Indicates whether the state requires the institution to submit an annual report or data filing to maintain authorization. True if annual reporting is required; false if not required.',
    `application_date` DATE COMMENT 'Date the institution submitted the authorization application to the state agency. Establishes timeline for processing and compliance tracking.',
    `authorization_fee_amount` DECIMAL(18,2) COMMENT 'Dollar amount of the application or renewal fee charged by the state agency for authorization. Null if no fee is required.',
    `authorization_number` STRING COMMENT 'Official reference number or certificate number issued by the state agency granting authorization. Used for verification and audit purposes.',
    `authorization_status` STRING COMMENT 'Current lifecycle state of the state authorization. Authorized indicates active compliance; pending indicates application submitted; expired indicates lapsed authorization requiring renewal; denied indicates rejected application; withdrawn indicates institution voluntarily ceased activity; not required indicates exemption or exclusion applies.. Valid values are `authorized|pending|expired|denied|withdrawn|not_required`',
    `authorization_type` STRING COMMENT 'Category of activity requiring state authorization. Distance education covers online program delivery; physical presence includes offices, classrooms, or administrative sites; clinical placement applies to healthcare and education programs; recruiting covers admissions activities; field experience and internship cover supervised learning activities in the state.. Valid values are `distance_education|physical_presence|clinical_placement|recruiting|field_experience|internship`',
    `authorized_program_list` STRING COMMENT 'Comma-separated list of academic programs or CIP codes specifically authorized for delivery in this state. Some states require program-level authorization rather than blanket institutional authorization.',
    `complaint_disclosure_status` STRING COMMENT 'Indicates whether the institution has published the required student complaint process disclosure for this state. Disclosed indicates compliance; not disclosed indicates missing disclosure; not required indicates no disclosure obligation.. Valid values are `disclosed|not_disclosed|not_required`',
    `compliance_notes` STRING COMMENT 'Free-text field for documenting special conditions, restrictions, or institutional notes related to this state authorization. Used for tracking unique requirements or historical context.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time this state authorization record was first created in the institutional system. Used for audit trail and data lineage purposes.',
    `effective_date` DATE COMMENT 'Date on which the state authorization becomes active and the institution is legally permitted to conduct the specified activities in the state.',
    `enrolled_student_count` STRING COMMENT 'Number of students enrolled in programs or courses delivered in this state under this authorization. Used for reporting and fee calculation purposes in some states.',
    `exemption_basis` STRING COMMENT 'Legal or regulatory basis for exemption from state authorization requirements. Describes the specific statute, regulation, or policy provision granting the exemption.',
    `exemption_flag` BOOLEAN COMMENT 'Indicates whether the institution qualifies for an exemption from state authorization requirements in this state. True if exempt under state law or regulation; false if authorization is required.',
    `expiration_date` DATE COMMENT 'Date on which the state authorization expires and the institution must cease activities or submit a renewal application. Null for perpetual authorizations.',
    `fee_payment_date` DATE COMMENT 'Date the institution paid the authorization or renewal fee to the state agency. Used for financial reconciliation and compliance tracking.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this state authorization record is currently active and in use. True for active records; false for historical or superseded records.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time this state authorization record was most recently updated. Used for audit trail and change tracking purposes.',
    `last_report_submission_date` DATE COMMENT 'Date the institution most recently submitted an annual report or compliance filing to the state agency for this authorization.',
    `last_review_date` DATE COMMENT 'Date of the most recent institutional review or audit of this state authorization record for compliance verification purposes.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next institutional compliance review of this state authorization to ensure ongoing adherence to state requirements.',
    `physical_location_address` STRING COMMENT 'Street address of the physical presence location in the state, if applicable. Required for physical presence authorizations; null for distance education-only authorizations.',
    `physical_location_city` STRING COMMENT 'City of the physical presence location in the state, if applicable.',
    `physical_location_postal_code` STRING COMMENT 'ZIP or postal code of the physical presence location in the state, if applicable.',
    `renewal_date` DATE COMMENT 'Target date by which the institution must submit a renewal application to maintain continuous authorization. Typically set in advance of expiration date to allow processing time.',
    `responsible_office` STRING COMMENT 'Name of the institutional office or department responsible for managing this state authorization and ensuring ongoing compliance. Typically the Office of Compliance, Office of the Registrar, or Office of Distance Education.',
    `sara_participation_flag` BOOLEAN COMMENT 'Indicates whether the institution relies on SARA membership for authorization in this state. True if SARA provides reciprocal authorization; false if state-specific authorization is required.',
    `state_agency_name` STRING COMMENT 'Official name of the state agency responsible for granting and overseeing authorization. Typically a state board of higher education, department of education, or professional licensing board.',
    `state_code` STRING COMMENT 'Two-letter postal abbreviation for the state in which authorization is required. Identifies the jurisdiction for compliance tracking and reporting purposes.. Valid values are `^[A-Z]{2}$`',
    `state_name` STRING COMMENT 'Full legal name of the state requiring authorization for institutional operations or distance education delivery.',
    `student_complaint_process_url` STRING COMMENT 'Web address where students can access information about filing complaints with the state agency. Required disclosure under 34 CFR 668.43(b) for distance education programs.',
    CONSTRAINT pk_state_authorization PRIMARY KEY(`state_authorization_id`)
) COMMENT 'Tracks state authorization compliance for distance education and physical presence activities in states other than the institutions home state. Captures state, authorization type (distance education, physical presence, clinical placement, recruiting), application status, authorization number, effective date, expiration date, renewal date, authorized program list, student complaint process disclosure status, and state agency contact. Required under 34 CFR 600.9 and SARA (State Authorization Reciprocity Agreement) participation.';

CREATE OR REPLACE TABLE `education_ecm`.`compliance`.`internal_review` (
    `internal_review_id` BIGINT COMMENT 'Primary key for internal_review',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Internal compliance reviews require documented reviewer assignment for accountability and conflict-of-interest tracking. Enables reviewer workload balancing, qualification verification, and audit trai',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: internal_review currently has related_policy_reference as a STRING field (likely free text or policy number). Adding policy_id FK provides structured linkage to the policy master table, enabling preci',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key reference to the primary regulatory requirement or compliance obligation being assessed in this review.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to hr.org_unit. Business justification: Compliance reviews target specific organizational units for scope definition and accountability. Enables review workload distribution, organizational compliance scoring, and risk-based audit planning ',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this compliance review record is currently active and relevant for reporting and tracking purposes.',
    `compliance_score` DECIMAL(18,2) COMMENT 'Quantitative compliance score or rating assigned based on review results, typically expressed as a percentage or index value.',
    `confidentiality_level` STRING COMMENT 'Data classification level assigned to the review and its findings, governing access and distribution.. Valid values are `Public|Internal|Confidential|Restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance review record was first created in the system.',
    `documentation_location` STRING COMMENT 'File path, URL, or repository location where the full review documentation, workpapers, and evidence are stored.',
    `external_reporting_date` DATE COMMENT 'Date when findings were reported to external regulatory or accreditation bodies, if applicable.',
    `external_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether findings from this internal review must be reported to external regulatory bodies or accreditation agencies.',
    `findings_count` STRING COMMENT 'Total number of discrete findings or issues identified during the review.',
    `findings_summary` STRING COMMENT 'Executive summary of the review findings, including key observations, compliance gaps, and areas of concern.',
    `follow_up_due_date` DATE COMMENT 'Target date by which follow-up actions or verification review should be completed.',
    `follow_up_required_flag` BOOLEAN COMMENT 'Indicates whether follow-up actions or a subsequent review is required to verify remediation of findings.',
    `follow_up_status` STRING COMMENT 'Current status of follow-up actions or verification activities related to this review.. Valid values are `Not Started|In Progress|Completed|Overdue|Waived`',
    `methodology_description` STRING COMMENT 'Description of the review methodology employed, including sampling approach, data sources, interview protocols, and analytical techniques.',
    `modified_by` STRING COMMENT 'User ID or name of the individual who last modified this compliance review record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance review record was last modified.',
    `population_size` STRING COMMENT 'Total number of records, cases, or transactions in the population from which the sample was drawn, if applicable.',
    `recommendations_count` STRING COMMENT 'Total number of discrete recommendations issued to address findings.',
    `recommendations_issued` STRING COMMENT 'Summary of corrective actions, process improvements, or policy changes recommended as a result of the review.',
    `report_issued_date` DATE COMMENT 'Date when the formal compliance review report was issued to stakeholders.',
    `report_recipients` STRING COMMENT 'List of individuals, offices, or committees to whom the review report was distributed (e.g., President, Board of Trustees, Compliance Committee).',
    `responsible_officer_name` STRING COMMENT 'Full name of the individual (e.g., department head, dean, director) accountable for remediation of findings.',
    `review_code` STRING COMMENT 'Business identifier for the compliance review, typically formatted as type-year-sequence (e.g., FERPA-2024-00123, NCAA-2024-00045).. Valid values are `^[A-Z]{2,4}-[0-9]{4}-[0-9]{3,5}$`',
    `review_completion_date` DATE COMMENT 'Date when the compliance review was completed and findings finalized.',
    `review_name` STRING COMMENT 'Descriptive name or title of the compliance review (e.g., FY2024 FERPA Records Audit, Title IX Program Review - Athletics).',
    `review_notes` STRING COMMENT 'Additional notes, context, or observations recorded by the review team that provide supplementary information.',
    `review_period_end_date` DATE COMMENT 'End date of the period being reviewed (the timeframe of activities/records under examination).',
    `review_period_start_date` DATE COMMENT 'Start date of the period being reviewed (the timeframe of activities/records under examination).',
    `review_start_date` DATE COMMENT 'Date when the compliance review activity commenced (distinct from the period being reviewed).',
    `review_status` STRING COMMENT 'Current lifecycle status of the compliance review.. Valid values are `Planned|In Progress|Under Review|Completed|Cancelled|On Hold`',
    `review_team_members` STRING COMMENT 'Comma-separated list or narrative description of additional team members who participated in the review.',
    `review_type` STRING COMMENT 'Category of internal compliance review being conducted. Aligns with major regulatory frameworks and institutional compliance domains. [ENUM-REF-CANDIDATE: FERPA Audit|Title IX Program Review|NCAA Compliance Review|Financial Aid Program Review|Research Compliance Review|Clery Act Review|ADA Accommodations Review|HIPAA Compliance Review|IRB Protocol Review|Export Control Review|Conflict of Interest Review|Data Privacy Review|Other — 13 candidates stripped; promote to reference product]',
    `risk_rating` STRING COMMENT 'Overall risk rating assigned to the review findings, reflecting the severity and potential impact of identified compliance gaps.. Valid values are `Critical|High|Medium|Low|Informational`',
    `sample_size` STRING COMMENT 'Number of records, cases, or transactions sampled during the review, if applicable.',
    `scope_description` STRING COMMENT 'Detailed description of the review scope, including departments, processes, systems, or populations covered by the review.',
    `created_by` STRING COMMENT 'User ID or name of the individual who created this compliance review record.',
    CONSTRAINT pk_internal_review PRIMARY KEY(`internal_review_id`)
) COMMENT 'Records internal compliance reviews, program reviews, and self-assessments conducted by the compliance office or designated compliance officers. Captures review type (FERPA audit, Title IX program review, NCAA compliance review, financial aid program review, research compliance review), scope, review period, lead reviewer, methodology, findings summary, risk rating, recommendations issued, and follow-up action status. Distinct from external audit_finding — this captures internally initiated compliance monitoring activities.';

CREATE OR REPLACE TABLE `education_ecm`.`compliance`.`risk_assessment` (
    `risk_assessment_id` BIGINT COMMENT 'Unique identifier for the compliance risk assessment record. Primary key for the risk assessment entity.',
    `identity_account_id` BIGINT COMMENT 'System user identifier of the compliance staff member who created this risk assessment record.',
    `modified_by_user_identity_account_id` BIGINT COMMENT 'System user identifier of the compliance staff member who last modified this risk assessment record.',
    `policy_id` BIGINT COMMENT 'Foreign key reference to the institutional policy that governs or addresses this compliance risk area.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key reference to the specific regulatory requirement or compliance obligation that this risk relates to, if applicable.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Enterprise risk management requires designated risk owner with accountability for mitigation. Links owner for escalation workflows, enables risk portfolio analysis by personnel, and provides governanc',
    `superseded_risk_assessment_id` BIGINT COMMENT 'Self-referencing FK on risk_assessment (superseded_risk_assessment_id)',
    `accreditation_impact_flag` BOOLEAN COMMENT 'Indicator of whether this compliance risk could affect institutional or programmatic accreditation status if not properly managed.',
    `active_flag` BOOLEAN COMMENT 'Indicator of whether this risk assessment is currently active and relevant for compliance monitoring, or has been archived/closed.',
    `affected_population` STRING COMMENT 'Description of the institutional stakeholder groups impacted by this risk, such as students, faculty, staff, alumni, research participants, or external partners.',
    `assessment_date` DATE COMMENT 'Date when the formal risk assessment analysis was completed, including likelihood and impact evaluation.',
    `board_reporting_required_flag` BOOLEAN COMMENT 'Indicator of whether this risk assessment must be reported to the Board of Trustees Audit Committee based on severity and institutional governance requirements.',
    `control_effectiveness` STRING COMMENT 'Assessment of how well the current mitigation controls are functioning to reduce the risk to acceptable levels.. Valid values are `effective|partially_effective|ineffective|not_tested`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this risk assessment record was first created in the compliance management system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated financial impact, typically USD for U.S. higher education institutions.. Valid values are `^[A-Z]{3}$`',
    `estimated_financial_impact` DECIMAL(18,2) COMMENT 'Projected monetary cost to the institution if the risk materializes, including potential fines, penalties, legal costs, remediation expenses, and lost revenue.',
    `external_reporting_required_flag` BOOLEAN COMMENT 'Indicator of whether this risk must be disclosed to external regulatory bodies, accreditors, or government agencies.',
    `identification_date` DATE COMMENT 'Date when the compliance risk was first identified and entered into the institutional risk register.',
    `inherent_impact_rating` STRING COMMENT 'Severity assessment of the consequences if the risk materializes without any mitigation controls, rated on a five-point scale from insignificant to catastrophic.. Valid values are `insignificant|minor|moderate|major|catastrophic`',
    `inherent_likelihood_rating` STRING COMMENT 'Probability assessment of the risk occurring without any mitigation controls in place, rated on a five-point scale from rare to almost certain.. Valid values are `rare|unlikely|possible|likely|almost_certain`',
    `inherent_risk_score` STRING COMMENT 'Calculated numerical score representing the inherent risk level before mitigation, typically derived from likelihood multiplied by impact (scale 1-25).',
    `last_board_report_date` DATE COMMENT 'Date when this risk was most recently presented to the Board of Trustees or Audit Committee for review and oversight.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this risk assessment record was most recently updated, used for audit trail and data currency tracking.',
    `last_review_date` DATE COMMENT 'Date of the most recent periodic review of this risk assessment, used to track currency of risk evaluation.',
    `mitigation_strategy` STRING COMMENT 'Comprehensive description of the controls, processes, policies, and actions implemented or planned to reduce the likelihood or impact of the risk.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this risk assessment, based on review frequency and risk level.',
    `residual_impact_rating` STRING COMMENT 'Severity assessment of the consequences if the risk materializes after considering existing mitigation controls, rated on a five-point scale.. Valid values are `insignificant|minor|moderate|major|catastrophic`',
    `residual_likelihood_rating` STRING COMMENT 'Probability assessment of the risk occurring after considering existing mitigation controls and strategies, rated on a five-point scale.. Valid values are `rare|unlikely|possible|likely|almost_certain`',
    `residual_risk_score` STRING COMMENT 'Calculated numerical score representing the residual risk level after mitigation controls are applied, used to prioritize compliance monitoring activities (scale 1-25).',
    `responsible_office` STRING COMMENT 'Name of the institutional department or office with primary responsibility for monitoring and mitigating this compliance risk.',
    `review_frequency_months` STRING COMMENT 'Number of months between scheduled reviews of this risk assessment, typically ranging from 3 to 12 months based on risk severity.',
    `risk_appetite_threshold` STRING COMMENT 'Institutional tolerance level for this risk category, expressed as a numerical score. Residual risk scores above this threshold require escalation and additional mitigation.',
    `risk_category` STRING COMMENT 'Primary classification of the risk type: regulatory (compliance with laws/regulations), financial (monetary impact), reputational (institutional image), operational (process/system failures), strategic (mission alignment), or legal (litigation exposure).. Valid values are `regulatory|financial|reputational|operational|strategic|legal`',
    `risk_description` STRING COMMENT 'Detailed narrative description of the compliance risk, including the nature of the risk, potential triggers, and context within institutional operations.',
    `risk_notes` STRING COMMENT 'Additional contextual information, observations, or commentary about the risk assessment, mitigation progress, or special considerations.',
    `risk_number` STRING COMMENT 'Business-facing unique identifier for the risk assessment, formatted as RISK-XXXXXX for external communication and tracking.. Valid values are `^RISK-[0-9]{6}$`',
    `risk_status` STRING COMMENT 'Current lifecycle state of the risk assessment: identified (newly discovered), assessed (analysis complete), active (requires ongoing attention), mitigated (controls implemented), closed (resolved), or monitoring (under surveillance).. Valid values are `identified|assessed|active|mitigated|closed|monitoring`',
    `risk_subcategory` STRING COMMENT 'Secondary classification providing granular detail within the primary risk category, such as Title IX, FERPA, Clery Act, NCAA, accreditation, financial aid, research compliance, or data privacy.',
    `risk_title` STRING COMMENT 'Concise title or name of the identified compliance risk for quick reference and reporting.',
    `risk_trend` STRING COMMENT 'Directional indicator of how the risk profile is changing over time based on comparison of current and historical assessments.. Valid values are `increasing|stable|decreasing`',
    CONSTRAINT pk_risk_assessment PRIMARY KEY(`risk_assessment_id`)
) COMMENT 'Institutional compliance risk register tracking identified compliance risks, risk categories (regulatory, financial, reputational, operational), likelihood and impact ratings, risk owners, mitigation strategies, residual risk scores, review frequency, and risk trend over time. Used by the Chief Compliance Officer to prioritize compliance monitoring activities, allocate resources, and report to the Board Audit Committee on institutional risk posture. Feeds enterprise risk management reporting and accreditation self-studies.';

CREATE OR REPLACE TABLE `education_ecm`.`compliance`.`ipeds_submission` (
    `ipeds_submission_id` BIGINT COMMENT 'Unique identifier for each IPEDS survey submission record. Primary key for the ipeds_submission product.',
    `original_submission_ipeds_submission_id` BIGINT COMMENT 'Reference to the original submission record if this is a revision, creating an audit trail of data corrections and resubmissions.',
    `employee_id` BIGINT COMMENT 'Internal employee identifier for the staff member who prepared the IPEDS submission, linking to the institutional human resources system.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: IPEDS (Integrated Postsecondary Education Data System) submissions are mandatory federal reporting requirements under the Higher Education Opportunity Act (HEOA). Each survey component (enrollment, fi',
    `amended_ipeds_submission_id` BIGINT COMMENT 'Self-referencing FK on ipeds_submission (amended_ipeds_submission_id)',
    `acceptance_date` DATE COMMENT 'The date on which NCES officially accepted the submission as complete and compliant, closing the reporting obligation for this survey component and year.',
    `certification_date` DATE COMMENT 'The date on which the IPEDS Keyholder certified the accuracy and completeness of the submission data, fulfilling the institutional attestation requirement.',
    `certification_statement` STRING COMMENT 'The official certification text affirming that the submitted data is accurate, complete, and compliant with NCES reporting standards, as required for submission.',
    `collection_period` STRING COMMENT 'The seasonal collection window during which this survey component is due. IPEDS operates on a three-cycle annual collection schedule.. Valid values are `Fall|Winter|Spring`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp recording when this IPEDS submission record was first created in the institutional compliance tracking system.',
    `data_extraction_date` DATE COMMENT 'The date on which the source data was extracted from institutional systems for IPEDS reporting, establishing the data snapshot point for compliance verification.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Internal institutional assessment score reflecting the completeness, accuracy, and consistency of the submission data prior to NCES submission, used for quality assurance.',
    `due_date` DATE COMMENT 'The official deadline by which the institution must submit this IPEDS survey component to NCES to maintain compliance with federal reporting requirements.',
    `edit_report_error_count` STRING COMMENT 'Number of errors identified in the NCES edit report that must be resolved before the submission can be accepted, indicating data quality issues.',
    `edit_report_warning_count` STRING COMMENT 'Number of warnings flagged in the NCES edit report that require institutional explanation or verification but do not block submission acceptance.',
    `imputation_flag` BOOLEAN COMMENT 'Indicator showing whether NCES applied statistical imputation to fill missing data elements in this submission, affecting data reliability and comparability.',
    `imputation_summary` STRING COMMENT 'Description of which data elements were imputed by NCES and the methodology used, providing transparency for institutional data quality review.',
    `is_active` BOOLEAN COMMENT 'Flag indicating whether this submission record is the current active version or has been superseded by a revision, supporting historical data management.',
    `is_late_submission` BOOLEAN COMMENT 'Flag indicating whether the submission was filed after the official NCES deadline, which may trigger compliance warnings or affect institutional standing.',
    `is_revision` BOOLEAN COMMENT 'Flag indicating whether this submission is a revision of previously submitted data, typically required when errors are discovered post-acceptance.',
    `keyholder_name` STRING COMMENT 'Full name of the designated IPEDS Keyholder who has authority to certify and submit data on behalf of the institution to NCES.',
    `keyholder_title` STRING COMMENT 'Official job title of the IPEDS Keyholder, documenting their institutional authority and responsibility for federal reporting compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp recording the most recent update to this IPEDS submission record, supporting audit trail and change tracking requirements.',
    `lock_date` DATE COMMENT 'The date on which the institution locked the submission in the IPEDS system, preventing further edits and finalizing the data for NCES review.',
    `nces_confirmation_number` STRING COMMENT 'Unique confirmation identifier issued by NCES upon successful submission receipt, serving as proof of compliance and audit documentation.',
    `notes` STRING COMMENT 'Free-text field for institutional staff to document special circumstances, data anomalies, methodology changes, or other contextual information relevant to this submission.',
    `peer_comparison_group` STRING COMMENT 'The peer group classification assigned by NCES or selected by the institution for benchmarking purposes in IPEDS data feedback reports.',
    `preparer_email` STRING COMMENT 'Email address of the survey preparer for NCES communication and institutional coordination regarding this submission.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `preparer_name` STRING COMMENT 'Full name of the institutional staff member responsible for compiling and preparing the IPEDS survey data for this submission.',
    `preparer_phone` STRING COMMENT 'Contact phone number for the survey preparer, used by NCES for clarification questions or submission issues.',
    `public_disclosure_date` DATE COMMENT 'The date on which NCES makes this submission data publicly available through College Navigator and IPEDS Data Center, fulfilling transparency requirements.',
    `responsible_office` STRING COMMENT 'Name of the institutional office or department responsible for this IPEDS submission, typically Institutional Research or Compliance.',
    `revision_reason` STRING COMMENT 'Explanation of why the data was revised after initial submission, documenting the nature of the error or data quality issue that necessitated correction.',
    `source_system` STRING COMMENT 'Name of the institutional system of record from which the IPEDS data was extracted, documenting data lineage and supporting audit requirements.',
    `submission_date` DATE COMMENT 'The date on which the institution officially submitted the completed IPEDS survey component to NCES through the IPEDS Data Collection System.',
    `submission_method` STRING COMMENT 'The technical method used to transmit the IPEDS data to NCES, indicating whether data was manually entered, uploaded via file, or integrated via API.. Valid values are `web_entry|data_upload|api_integration`',
    `submission_number` STRING COMMENT 'Business identifier for the IPEDS submission, typically combining institution identifier, survey component, and academic year for external reference and tracking.',
    `submission_status` STRING COMMENT 'Current lifecycle status of the IPEDS submission indicating its progress through the institutional review, submission, and NCES acceptance workflow. [ENUM-REF-CANDIDATE: draft|in_progress|submitted|locked|accepted|rejected|revision_required — 7 candidates stripped; promote to reference product]',
    `submission_timestamp` TIMESTAMP COMMENT 'Precise date and time when the IPEDS submission was transmitted to NCES, used for audit trail and compliance verification purposes.',
    `survey_component` STRING COMMENT 'The specific IPEDS survey component being submitted. Each component collects different institutional data required by NCES for federal reporting compliance. [ENUM-REF-CANDIDATE: Institutional Characteristics|Completions|12-month Enrollment|Fall Enrollment|Finance|Human Resources|Student Financial Aid|Graduation Rates|Outcome Measures|Admissions — 10 candidates stripped; promote to reference product]',
    `survey_year` STRING COMMENT 'The academic year for which the IPEDS data is being reported, typically represented as the ending year (e.g., 2024 for the 2023-2024 academic year).',
    `unitid` STRING COMMENT 'Six-digit unique identifier assigned by NCES to each postsecondary institution participating in federal student aid programs. This is the primary institutional identifier in IPEDS.. Valid values are `^[0-9]{6}$`',
    CONSTRAINT pk_ipeds_submission PRIMARY KEY(`ipeds_submission_id`)
) COMMENT 'Tracks annual IPEDS (Integrated Postsecondary Education Data System) survey submissions including completion, enrollment, graduation rate, finance, and human resources surveys required by NCES for federal reporting compliance';

CREATE OR REPLACE TABLE `education_ecm`.`compliance`.`standard_requirement_mapping` (
    `standard_requirement_mapping_id` BIGINT COMMENT 'Primary key for the standard_requirement_mapping association',
    `accreditation_standard_id` BIGINT COMMENT 'Foreign key linking to the accreditation standard being mapped to regulatory requirements.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to the regulatory requirement that underlies or is satisfied by the accreditation standard.',
    `compliance_status` STRING COMMENT 'Current compliance status for this specific standard-requirement mapping. Indicates whether the institution is meeting both the standard and the underlying requirement through this mapping.',
    `coverage_scope` STRING COMMENT 'Description of the scope or extent to which the accreditation standard addresses the regulatory requirement. May specify which aspects of the requirement are covered.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this mapping record was first created.',
    `effective_date` DATE COMMENT 'The date when this mapping became effective and recognized by the institution. Used to track when the crosswalk was established or updated.',
    `evidence_reference` STRING COMMENT 'Reference to documentation or evidence that supports this mapping, such as accreditor guidance documents, legal opinions, or institutional policy references.',
    `expiration_date` DATE COMMENT 'The date when this mapping is no longer valid, typically due to changes in standards or regulations. Null if the mapping is currently active.',
    `last_review_date` DATE COMMENT 'The date when this mapping was most recently reviewed or validated by the compliance office. Used to ensure mappings remain current as standards and regulations evolve.',
    `mapping_notes` STRING COMMENT 'Free-text field for institutional notes about this specific mapping, including rationale, interpretation guidance, or special considerations.',
    `mapping_type` STRING COMMENT 'Classification of how the accreditation standard relates to the regulatory requirement: direct (standard explicitly implements the regulation), indirect (standard addresses the regulation through related criteria), partial (standard covers only part of the requirement), full (standard fully satisfies the requirement).',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review of this mapping to ensure continued accuracy and relevance.',
    `updated_by` STRING COMMENT 'Identifier of the user or system that most recently updated this mapping record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this mapping record was most recently updated.',
    `created_by` STRING COMMENT 'Identifier of the user or system that created this mapping record.',
    CONSTRAINT pk_standard_requirement_mapping PRIMARY KEY(`standard_requirement_mapping_id`)
) COMMENT 'This association product represents the compliance mapping between accreditation standards and underlying regulatory requirements. It captures the explicit crosswalk maintained by institutions to demonstrate how accreditation standards satisfy federal and state regulatory obligations. Each record links one accreditation standard to one regulatory requirement with mapping metadata including effective dates, mapping type, coverage scope, and compliance status. This is a core compliance artifact used during self-studies, audits, and regulatory reporting.. Existence Justification: In higher education compliance operations, institutions actively maintain standard-requirement crosswalk matrices that map accreditation standards to underlying federal and state regulatory requirements. One accreditation standard frequently addresses multiple regulatory requirements (e.g., a faculty qualification standard may satisfy Title IV, state authorization, and professional accreditation requirements), and one regulatory requirement is typically addressed by multiple accreditation standards (e.g., FERPA requirements are addressed through standards on records management, student services, and IT security). These mappings are living documents maintained by compliance offices, updated during self-studies, and used for audit preparation and regulatory reporting.';

CREATE OR REPLACE TABLE `education_ecm`.`compliance`.`policy_implementation` (
    `policy_implementation_id` BIGINT COMMENT 'Unique identifier for this policy-to-regulatory-requirement implementation mapping. Primary key.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to the institutional policy that implements the regulatory requirement',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to the regulatory requirement being addressed by the policy',
    `citation_mapping` STRING COMMENT 'Specific sections or provisions within the policy that address the regulatory requirement. Enables precise cross-referencing for audits and accreditation reviews.',
    `compliance_level` STRING COMMENT 'Assessment of how well this policy satisfies the regulatory requirement: fully_compliant (meets all obligations), substantially_compliant (meets most with minor gaps), partially_compliant (significant gaps exist), non_compliant (does not meet requirement), not_applicable (requirement does not apply).',
    `coverage_scope` STRING COMMENT 'Extent to which this policy addresses the regulatory requirement: full (completely satisfies), partial (addresses some aspects), supplemental (provides additional guidance), indirect (supports compliance indirectly).',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this implementation mapping record was first created in the compliance management system.',
    `gap_analysis_notes` STRING COMMENT 'Detailed findings from compliance reviews identifying any gaps, deficiencies, or areas where the policy does not fully address the regulatory requirement. Used for remediation planning and accreditation self-studies.',
    `implementation_date` DATE COMMENT 'Date when this policy was formally adopted or updated to address this specific regulatory requirement. Tracks when the implementation relationship became effective.',
    `last_audit_date` DATE COMMENT 'Date when this specific policy-to-requirement mapping was last reviewed or audited for adequacy and compliance. Distinct from audits of the policy or requirement individually.',
    `last_updated_date` TIMESTAMP COMMENT 'Timestamp when this implementation mapping record was most recently modified, reflecting changes to coverage scope, compliance level, or gap analysis findings.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next compliance review of this implementation mapping. Calculated based on regulatory review cycles and institutional audit schedules.',
    `responsible_reviewer` STRING COMMENT 'Name or position of the compliance officer or subject matter expert responsible for reviewing and certifying this implementation mapping.',
    `review_status` STRING COMMENT 'Current status of the implementation mapping review: current (recently verified), needs_review (scheduled for assessment), under_review (actively being evaluated), gap_identified (deficiency found), compliant (verified as adequate).',
    CONSTRAINT pk_policy_implementation PRIMARY KEY(`policy_implementation_id`)
) COMMENT 'This association product represents the implementation relationship between institutional policies and regulatory requirements. It captures how each policy addresses specific regulatory obligations, including implementation dates, coverage scope, compliance levels, and gap analysis findings. Each record links one policy to one regulatory requirement with attributes that exist only in the context of this implementation relationship.. Existence Justification: In higher education compliance operations, institutional policies routinely implement multiple regulatory requirements (e.g., a Title IX policy addresses federal Title IX regulations, Clery Act reporting, and state anti-discrimination laws), and regulatory requirements are typically addressed by multiple policies (e.g., FERPA requirements are implemented through records management policies, student conduct policies, and IT security policies). Compliance officers actively manage policy-to-regulation mappings as operational records with implementation dates, coverage assessments, gap analysis findings, and review statuses - this is required for accreditation self-studies and federal program reviews.';

CREATE OR REPLACE TABLE `education_ecm`.`compliance`.`accrediting_body` (
    `accrediting_body_id` BIGINT COMMENT 'Primary key for accrediting_body',
    `parent_accrediting_body_id` BIGINT COMMENT 'Self-referencing FK on accrediting_body (parent_accrediting_body_id)',
    `accreditation_cycle_years` STRING COMMENT 'Standard number of years in the accreditation cycle used by this accrediting body (e.g., 5, 7, 10 years).',
    `accreditation_type` STRING COMMENT 'Type of accreditation provided by this body: institutional (whole institution), programmatic (specific programs), specialized (specific disciplines), national, or regional.',
    `acronym` STRING COMMENT 'Standard acronym or abbreviation used to identify the accrediting body (e.g., HLC, SACSCOC, ABET).',
    `annual_report_required` BOOLEAN COMMENT 'Indicates whether accredited institutions must submit annual reports to this accrediting body.',
    `city` STRING COMMENT 'City where the accrediting body headquarters is located.',
    `complaint_process_url` STRING COMMENT 'URL to the accrediting bodys complaint and grievance process documentation.',
    `contact_email` STRING COMMENT 'Primary contact email address for the accrediting body.',
    `contact_phone` STRING COMMENT 'Primary contact phone number for the accrediting body.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the accrediting body is headquartered.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this accrediting body record was first created in the system.',
    `discipline_focus` STRING COMMENT 'Primary academic discipline or professional field focus of the accrediting body for specialized or programmatic accreditors (e.g., Engineering, Business, Nursing, Law).',
    `geographic_scope` STRING COMMENT 'Geographic scope of the accrediting bodys jurisdiction: regional (specific U.S. region), national (entire U.S.), or international.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this accrediting body is currently active and operational.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this accrediting body record was last updated in the system.',
    `last_review_date` DATE COMMENT 'Date of the most recent recognition review conducted by the recognizing authority.',
    `mailing_address_line1` STRING COMMENT 'First line of the mailing address for the accrediting body headquarters.',
    `mailing_address_line2` STRING COMMENT 'Second line of the mailing address for the accrediting body headquarters (suite, floor, building).',
    `member_institution_count` STRING COMMENT 'Total number of institutions or programs currently accredited by this accrediting body.',
    `accrediting_body_name` STRING COMMENT 'Official legal name of the accrediting body or accreditation agency.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next recognition review by the recognizing authority.',
    `notes` STRING COMMENT 'Additional notes, comments, or special considerations related to this accrediting body.',
    `peer_review_required` BOOLEAN COMMENT 'Indicates whether this accrediting body requires peer review as part of its accreditation process.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the accrediting body headquarters.',
    `recognition_date` DATE COMMENT 'Date when the accrediting body was first recognized by the U.S. Department of Education or CHEA.',
    `recognition_expiration_date` DATE COMMENT 'Date when the current recognition period expires and renewal is required.',
    `recognition_status` STRING COMMENT 'Current recognition status of the accrediting body by the U.S. Department of Education or CHEA.',
    `recognizing_authority` STRING COMMENT 'The authority that recognizes this accrediting body: USDE (U.S. Department of Education), CHEA (Council for Higher Education Accreditation), both, other, or none.',
    `region` STRING COMMENT 'Specific geographic region served by the accrediting body if it is a regional accreditor (e.g., Middle States, New England, North Central, Northwest, Southern, Western).',
    `self_study_required` BOOLEAN COMMENT 'Indicates whether this accrediting body requires institutions to complete a comprehensive self-study as part of the accreditation process.',
    `short_name` STRING COMMENT 'Abbreviated or commonly used short name for the accrediting body.',
    `site_visit_required` BOOLEAN COMMENT 'Indicates whether this accrediting body requires on-site evaluation visits as part of the accreditation process.',
    `standards_effective_date` DATE COMMENT 'Date when the current version of accreditation standards became effective.',
    `standards_version` STRING COMMENT 'Current version or edition of the accreditation standards used by this accrediting body.',
    `state_province` STRING COMMENT 'State or province where the accrediting body headquarters is located.',
    `substantive_change_policy_url` STRING COMMENT 'URL to the accrediting bodys substantive change policy documentation.',
    `title_iv_eligibility_required` BOOLEAN COMMENT 'Indicates whether accreditation by this body is required for institutions to participate in federal Title IV student financial aid programs.',
    `website_url` STRING COMMENT 'Official website URL of the accrediting body.',
    CONSTRAINT pk_accrediting_body PRIMARY KEY(`accrediting_body_id`)
) COMMENT 'Master reference table for accrediting_body. Referenced by accrediting_body_id.';

CREATE OR REPLACE TABLE `education_ecm`.`compliance`.`audit` (
    `audit_id` BIGINT COMMENT 'Primary key for audit',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: audit currently has regulatory_framework as a STRING field (e.g., Title IV, FERPA, NCAA). Adding regulatory_requirement_id FK provides structured linkage to the regulatory_requirement master tab',
    `followup_audit_id` BIGINT COMMENT 'Self-referencing FK on audit (followup_audit_id)',
    `accreditation_body` STRING COMMENT 'The name of the accrediting agency or regulatory body for which this audit was conducted, such as HLC, SACSCOC, ABET, or U.S. Department of Education.',
    `actual_end_date` DATE COMMENT 'The date when audit fieldwork was actually completed, which may differ from the scheduled end date.',
    `actual_remediation_date` DATE COMMENT 'The date when corrective actions were verified as fully implemented and audit findings were closed.',
    `actual_start_date` DATE COMMENT 'The date when audit fieldwork actually commenced, which may differ from the scheduled start date due to operational factors.',
    `audit_cost` DECIMAL(18,2) COMMENT 'The total cost incurred for the audit engagement, including internal staff time and external fees, expressed in U.S. dollars.',
    `audit_hours` DECIMAL(18,2) COMMENT 'The total number of staff hours invested in conducting the audit engagement, including planning, fieldwork, and reporting.',
    `audit_methodology` STRING COMMENT 'The audit approach and techniques used, such as risk-based audit, compliance audit, process audit, or systems audit.',
    `audit_number` STRING COMMENT 'Human-readable business identifier for the audit, typically formatted as AUD-YYYY-NNNNNN.',
    `audit_objective` STRING COMMENT 'The primary purpose and goals of the audit engagement, describing what the audit seeks to accomplish or verify.',
    `audit_scope` STRING COMMENT 'The breadth and boundaries of the audit engagement, defining what organizational units, processes, or systems are included in the examination.',
    `audit_status` STRING COMMENT 'Current lifecycle state of the audit. Planned audits are scheduled but not started, in-progress audits are actively being conducted, fieldwork indicates data collection phase, reporting indicates draft preparation, issued means final report delivered, and closed indicates all follow-up completed.',
    `audit_type` STRING COMMENT 'Classification of the audit based on its purpose and scope. Internal audits are conducted by institutional staff, external audits by third parties, compliance audits verify regulatory adherence, financial audits examine fiscal controls, operational audits assess process efficiency, and academic audits review program quality.',
    `auditor_organization` STRING COMMENT 'The name of the organization or department conducting the audit, such as Internal Audit, external audit firm name, or regulatory agency.',
    `compliance_status` STRING COMMENT 'The determination of whether the audited area meets applicable regulatory, policy, or accreditation requirements.',
    `confidentiality_level` STRING COMMENT 'The data classification level assigned to the audit report and working papers, determining who may access the audit documentation.',
    `corrective_action_plan_received_date` DATE COMMENT 'The date when managements corrective action plan was received by the audit function.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this audit record was first created in the system.',
    `critical_finding_count` STRING COMMENT 'The number of critical-severity findings identified that require immediate management attention and remediation.',
    `department_audited` STRING COMMENT 'The name of the academic or administrative department that is the subject of the audit.',
    `estimated_remediation_date` DATE COMMENT 'The target date by which management commits to fully implement corrective actions to address audit findings.',
    `external_auditor_fee` DECIMAL(18,2) COMMENT 'The fee paid to external audit firms or consultants for conducting the audit, expressed in U.S. dollars. Null for internal audits.',
    `finding_count` STRING COMMENT 'The total number of audit findings identified during the engagement, including all severity levels.',
    `follow_up_due_date` DATE COMMENT 'The date by which management must submit corrective action plans or follow-up responses to audit findings.',
    `follow_up_required` BOOLEAN COMMENT 'Indicates whether management is required to provide follow-up responses or corrective action plans for audit findings.',
    `high_finding_count` STRING COMMENT 'The number of high-severity findings identified that represent significant control weaknesses.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this audit record was most recently updated.',
    `lead_auditor_name` STRING COMMENT 'The full name of the principal auditor responsible for conducting and overseeing the audit engagement.',
    `low_finding_count` STRING COMMENT 'The number of low-severity findings identified that represent minor control weaknesses or opportunities for improvement.',
    `medium_finding_count` STRING COMMENT 'The number of medium-severity findings identified that represent moderate control weaknesses.',
    `notes` STRING COMMENT 'Free-form text field for capturing additional context, observations, or special circumstances related to the audit engagement.',
    `overall_opinion` STRING COMMENT 'The auditors overall conclusion regarding the adequacy and effectiveness of controls in the audited area. Satisfactory indicates effective controls, needs improvement indicates control gaps requiring attention, unsatisfactory indicates significant control deficiencies, and adverse indicates pervasive control failures.',
    `population_size` STRING COMMENT 'The total number of items or transactions in the population from which the audit sample was drawn.',
    `report_distribution_list` STRING COMMENT 'Comma-separated list of roles or individuals who received the final audit report, such as Board of Trustees, President, CFO, Audit Committee.',
    `report_issued_date` DATE COMMENT 'The date when the final audit report was formally issued to stakeholders.',
    `risk_rating` STRING COMMENT 'The overall risk assessment assigned to the audit area based on potential impact and likelihood of control failures. Critical indicates severe institutional risk, high indicates significant risk, moderate indicates manageable risk, and low indicates minimal risk.',
    `sample_size` STRING COMMENT 'The number of items or transactions selected for detailed testing during the audit.',
    `sampling_method` STRING COMMENT 'The technique used to select items for testing during the audit. Statistical sampling uses probability theory, judgmental sampling relies on auditor expertise, random sampling selects items by chance, stratified sampling divides population into subgroups, and census examines all items.',
    `scheduled_end_date` DATE COMMENT 'The planned date when the audit engagement is scheduled to be completed.',
    `scheduled_start_date` DATE COMMENT 'The planned date when the audit engagement is scheduled to begin.',
    CONSTRAINT pk_audit PRIMARY KEY(`audit_id`)
) COMMENT 'Master reference table for audit. Referenced by audit_id.';

CREATE OR REPLACE TABLE `education_ecm`.`compliance`.`certificate_template` (
    `certificate_template_id` BIGINT COMMENT 'Primary key for certificate_template',
    `accrediting_body_id` BIGINT COMMENT 'Reference to the external accreditation or regulatory body that recognizes or requires this certificate type.',
    `approved_by_user_identity_account_id` BIGINT COMMENT 'Reference to the user who approved this certificate template for active use.',
    `competency_framework_id` BIGINT COMMENT 'Reference to the competency or learning outcomes framework associated with this certificate template.',
    `division_id` BIGINT COMMENT 'Reference to the academic department or administrative unit responsible for this certificate template.',
    `identity_account_id` BIGINT COMMENT 'Reference to the user who created this certificate template record.',
    `last_modified_by_user_identity_account_id` BIGINT COMMENT 'Reference to the user who most recently modified this certificate template record.',
    `finance_vendor_id` BIGINT COMMENT 'Reference to the external print vendor or service provider used for physical certificate production.',
    `program_id` BIGINT COMMENT 'Reference to the academic or professional program associated with this certificate template.',
    `parent_certificate_template_id` BIGINT COMMENT 'Self-referencing FK on certificate_template (parent_certificate_template_id)',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether certificates generated from this template require administrative approval before issuance.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this certificate template was approved for active use.',
    `background_image_url` STRING COMMENT 'URL or file path to the background image or watermark used in the certificate template.',
    `blockchain_verification_enabled_flag` BOOLEAN COMMENT 'Indicates whether certificates generated from this template are registered on a blockchain for tamper-proof verification.',
    `compliance_framework` STRING COMMENT 'Regulatory or accreditation framework that this certificate template supports (e.g., Title IX, Clery Act, FERPA, NCAA, ADA, regional accreditor standards). [ENUM-REF-CANDIDATE: title_ix|clery_act|ferpa|ncaa|ada|sacscoc|hlc|msche|wscuc|nwccu|neche — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this certificate template record was first created in the system.',
    `credential_type` STRING COMMENT 'Classification of the credential represented by this certificate template within the institutional credential framework.',
    `credit_hours` DECIMAL(18,2) COMMENT 'Number of academic credit hours or continuing education units represented by the credential on this certificate template.',
    `certificate_template_description` STRING COMMENT 'Detailed description of the certificate template purpose, usage context, and intended recipients.',
    `digital_signature_enabled_flag` BOOLEAN COMMENT 'Indicates whether certificates generated from this template support digital signature technology for authentication.',
    `effective_end_date` DATE COMMENT 'Date when this certificate template is no longer active for new certificate generation. Null indicates no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when this certificate template becomes active and available for use in certificate generation.',
    `expiration_period_months` STRING COMMENT 'Number of months after issuance when certificates from this template expire and require renewal. Null indicates no expiration.',
    `issuing_authority_name` STRING COMMENT 'Name of the institutional office, department, or official authorized to issue certificates from this template.',
    `issuing_authority_title` STRING COMMENT 'Official title of the person or office authorized to issue certificates from this template (e.g., Registrar, Dean, President).',
    `language_code` STRING COMMENT 'ISO 639-1 language code indicating the primary language of the certificate template (e.g., en, es, fr).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this certificate template record was most recently modified.',
    `layout_format` STRING COMMENT 'Page orientation format for the certificate template.',
    `logo_image_url` STRING COMMENT 'URL or file path to the institutional logo image displayed on the certificate.',
    `page_size` STRING COMMENT 'Standard page size specification for the certificate template.',
    `paper_stock_specification` STRING COMMENT 'Technical specification of the paper stock used for physical certificates including weight, finish, and security features.',
    `public_display_flag` BOOLEAN COMMENT 'Indicates whether certificates issued from this template can be publicly displayed or shared by recipients.',
    `renewal_eligible_flag` BOOLEAN COMMENT 'Indicates whether certificates issued from this template are eligible for renewal after expiration.',
    `seal_required_flag` BOOLEAN COMMENT 'Indicates whether an official institutional seal or embossment is required on certificates generated from this template.',
    `security_features` STRING COMMENT 'Description of security features embedded in the certificate template such as watermarks, holograms, QR codes, or blockchain verification.',
    `signature_block_count` STRING COMMENT 'Number of signature blocks included in the certificate template for authorized signatories.',
    `certificate_template_status` STRING COMMENT 'Current lifecycle status of the certificate template indicating its availability for use.',
    `template_code` STRING COMMENT 'Unique business identifier code for the certificate template used for external reference and system integration.',
    `template_name` STRING COMMENT 'Human-readable name of the certificate template describing its purpose or program.',
    `template_type` STRING COMMENT 'Classification of the certificate template by its primary purpose within the institution.',
    `transcript_notation` STRING COMMENT 'Standard text notation that appears on the academic transcript when this certificate is awarded.',
    `verification_url` STRING COMMENT 'URL where third parties can verify the authenticity of certificates issued from this template.',
    `version_number` STRING COMMENT 'Semantic version number of the certificate template to track revisions and updates.',
    CONSTRAINT pk_certificate_template PRIMARY KEY(`certificate_template_id`)
) COMMENT 'Master reference table for certificate_template. Referenced by certificate_template_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `education_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`compliance`.`policy` ADD CONSTRAINT `fk_compliance_policy_supersedes_policy_id` FOREIGN KEY (`supersedes_policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ADD CONSTRAINT `fk_compliance_policy_version_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ADD CONSTRAINT `fk_compliance_policy_version_superseded_version_policy_version_id` FOREIGN KEY (`superseded_version_policy_version_id`) REFERENCES `education_ecm`.`compliance`.`policy_version`(`policy_version_id`);
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ADD CONSTRAINT `fk_compliance_title_ix_case_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` ADD CONSTRAINT `fk_compliance_clery_incident_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ADD CONSTRAINT `fk_compliance_ferpa_disclosure_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ADD CONSTRAINT `fk_compliance_accreditation_review_accrediting_body_id` FOREIGN KEY (`accrediting_body_id`) REFERENCES `education_ecm`.`compliance`.`accrediting_body`(`accrediting_body_id`);
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ADD CONSTRAINT `fk_compliance_accreditation_review_accreditation_standard_id` FOREIGN KEY (`accreditation_standard_id`) REFERENCES `education_ecm`.`compliance`.`accreditation_standard`(`accreditation_standard_id`);
ALTER TABLE `education_ecm`.`compliance`.`accreditation_standard` ADD CONSTRAINT `fk_compliance_accreditation_standard_accrediting_body_id` FOREIGN KEY (`accrediting_body_id`) REFERENCES `education_ecm`.`compliance`.`accrediting_body`(`accrediting_body_id`);
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ADD CONSTRAINT `fk_compliance_corrective_action_accreditation_review_id` FOREIGN KEY (`accreditation_review_id`) REFERENCES `education_ecm`.`compliance`.`accreditation_review`(`accreditation_review_id`);
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ADD CONSTRAINT `fk_compliance_corrective_action_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `education_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ADD CONSTRAINT `fk_compliance_corrective_action_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ADD CONSTRAINT `fk_compliance_corrective_action_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_accreditation_review_id` FOREIGN KEY (`accreditation_review_id`) REFERENCES `education_ecm`.`compliance`.`accreditation_review`(`accreditation_review_id`);
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `education_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `education_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_original_filing_regulatory_filing_id` FOREIGN KEY (`original_filing_regulatory_filing_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`compliance`.`training_program` ADD CONSTRAINT `fk_compliance_training_program_certificate_template_id` FOREIGN KEY (`certificate_template_id`) REFERENCES `education_ecm`.`compliance`.`certificate_template`(`certificate_template_id`);
ALTER TABLE `education_ecm`.`compliance`.`training_program` ADD CONSTRAINT `fk_compliance_training_program_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ADD CONSTRAINT `fk_compliance_compliance_training_completion_training_program_id` FOREIGN KEY (`training_program_id`) REFERENCES `education_ecm`.`compliance`.`training_program`(`training_program_id`);
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ADD CONSTRAINT `fk_compliance_state_authorization_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`compliance`.`internal_review` ADD CONSTRAINT `fk_compliance_internal_review_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`compliance`.`internal_review` ADD CONSTRAINT `fk_compliance_internal_review_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ADD CONSTRAINT `fk_compliance_risk_assessment_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ADD CONSTRAINT `fk_compliance_risk_assessment_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ADD CONSTRAINT `fk_compliance_risk_assessment_superseded_risk_assessment_id` FOREIGN KEY (`superseded_risk_assessment_id`) REFERENCES `education_ecm`.`compliance`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ADD CONSTRAINT `fk_compliance_ipeds_submission_original_submission_ipeds_submission_id` FOREIGN KEY (`original_submission_ipeds_submission_id`) REFERENCES `education_ecm`.`compliance`.`ipeds_submission`(`ipeds_submission_id`);
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ADD CONSTRAINT `fk_compliance_ipeds_submission_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ADD CONSTRAINT `fk_compliance_ipeds_submission_amended_ipeds_submission_id` FOREIGN KEY (`amended_ipeds_submission_id`) REFERENCES `education_ecm`.`compliance`.`ipeds_submission`(`ipeds_submission_id`);
ALTER TABLE `education_ecm`.`compliance`.`standard_requirement_mapping` ADD CONSTRAINT `fk_compliance_standard_requirement_mapping_accreditation_standard_id` FOREIGN KEY (`accreditation_standard_id`) REFERENCES `education_ecm`.`compliance`.`accreditation_standard`(`accreditation_standard_id`);
ALTER TABLE `education_ecm`.`compliance`.`standard_requirement_mapping` ADD CONSTRAINT `fk_compliance_standard_requirement_mapping_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`compliance`.`policy_implementation` ADD CONSTRAINT `fk_compliance_policy_implementation_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`compliance`.`policy_implementation` ADD CONSTRAINT `fk_compliance_policy_implementation_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`compliance`.`accrediting_body` ADD CONSTRAINT `fk_compliance_accrediting_body_parent_accrediting_body_id` FOREIGN KEY (`parent_accrediting_body_id`) REFERENCES `education_ecm`.`compliance`.`accrediting_body`(`accrediting_body_id`);
ALTER TABLE `education_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_followup_audit_id` FOREIGN KEY (`followup_audit_id`) REFERENCES `education_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `education_ecm`.`compliance`.`certificate_template` ADD CONSTRAINT `fk_compliance_certificate_template_accrediting_body_id` FOREIGN KEY (`accrediting_body_id`) REFERENCES `education_ecm`.`compliance`.`accrediting_body`(`accrediting_body_id`);
ALTER TABLE `education_ecm`.`compliance`.`certificate_template` ADD CONSTRAINT `fk_compliance_certificate_template_parent_certificate_template_id` FOREIGN KEY (`parent_certificate_template_id`) REFERENCES `education_ecm`.`compliance`.`certificate_template`(`certificate_template_id`);

-- ========= TAGS =========
ALTER SCHEMA `education_ecm`.`compliance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `education_ecm`.`compliance` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_requirement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_requirement` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Identifier (ID)');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Org Unit Id (Foreign Key)');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `applicability_criteria` SET TAGS ('dbx_business_glossary_term' = 'Applicability Criteria');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `applicability_scope` SET TAGS ('dbx_business_glossary_term' = 'Applicability Scope');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `citation_reference` SET TAGS ('dbx_business_glossary_term' = 'Citation Reference');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non-compliant|in-progress|not-applicable|under-review|remediation-required');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `documentation_requirements` SET TAGS ('dbx_business_glossary_term' = 'Documentation Requirements');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `enforcement_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Mechanism');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `external_reporting_system` SET TAGS ('dbx_business_glossary_term' = 'External Reporting System');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `implementation_notes` SET TAGS ('dbx_business_glossary_term' = 'Implementation Notes');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `last_audit_result` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Result');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `last_audit_result` SET TAGS ('dbx_value_regex' = 'compliant|non-compliant|compliant-with-recommendations|not-reviewed');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `last_compliance_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Certification Date');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Date');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `next_reporting_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Reporting Due Date');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `penalty_description` SET TAGS ('dbx_business_glossary_term' = 'Penalty Description');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `record_retention_period` SET TAGS ('dbx_business_glossary_term' = 'Record Retention Period');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulatory_source` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Source');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `related_requirements` SET TAGS ('dbx_business_glossary_term' = 'Related Requirements');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `requirement_code` SET TAGS ('dbx_business_glossary_term' = 'Requirement Code');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `requirement_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{3,20}$');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `requirement_description` SET TAGS ('dbx_business_glossary_term' = 'Requirement Description');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `requirement_name` SET TAGS ('dbx_business_glossary_term' = 'Requirement Name');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `requirement_type` SET TAGS ('dbx_business_glossary_term' = 'Requirement Type');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `responsible_officer_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Officer Name');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `supporting_policy_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Policy Reference');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `training_audience` SET TAGS ('dbx_business_glossary_term' = 'Training Audience');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `training_frequency` SET TAGS ('dbx_business_glossary_term' = 'Training Frequency');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `training_frequency` SET TAGS ('dbx_value_regex' = 'annual|biennial|one-time|as-needed|not-applicable');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `education_ecm`.`compliance`.`obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`compliance`.`obligation` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `education_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Identifier');
ALTER TABLE `education_ecm`.`compliance`.`obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer Identifier (ID)');
ALTER TABLE `education_ecm`.`compliance`.`obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`obligation` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `education_ecm`.`compliance`.`obligation` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Identifier (ID)');
ALTER TABLE `education_ecm`.`compliance`.`obligation` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Org Unit Id (Foreign Key)');
ALTER TABLE `education_ecm`.`compliance`.`obligation` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `education_ecm`.`compliance`.`obligation` ALTER COLUMN `actual_effort_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Effort Hours');
ALTER TABLE `education_ecm`.`compliance`.`obligation` ALTER COLUMN `audit_finding_count` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Count');
ALTER TABLE `education_ecm`.`compliance`.`obligation` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `education_ecm`.`compliance`.`obligation` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Completion Status');
ALTER TABLE `education_ecm`.`compliance`.`obligation` ALTER COLUMN `completion_status` SET TAGS ('dbx_value_regex' = 'not-started|in-progress|submitted|approved|rejected|partially-complete');
ALTER TABLE `education_ecm`.`compliance`.`obligation` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `education_ecm`.`compliance`.`obligation` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `education_ecm`.`compliance`.`obligation` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate');
ALTER TABLE `education_ecm`.`compliance`.`obligation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`compliance`.`obligation` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Obligation Due Date');
ALTER TABLE `education_ecm`.`compliance`.`obligation` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `education_ecm`.`compliance`.`obligation` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `education_ecm`.`compliance`.`obligation` ALTER COLUMN `escalation_threshold_days` SET TAGS ('dbx_business_glossary_term' = 'Escalation Threshold Days');
ALTER TABLE `education_ecm`.`compliance`.`obligation` ALTER COLUMN `estimated_effort_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Effort Hours');
ALTER TABLE `education_ecm`.`compliance`.`obligation` ALTER COLUMN `evidence_location` SET TAGS ('dbx_business_glossary_term' = 'Evidence Location');
ALTER TABLE `education_ecm`.`compliance`.`obligation` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Obligation Frequency');
ALTER TABLE `education_ecm`.`compliance`.`obligation` ALTER COLUMN `governing_body` SET TAGS ('dbx_business_glossary_term' = 'Governing Body');
ALTER TABLE `education_ecm`.`compliance`.`obligation` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Record Flag');
ALTER TABLE `education_ecm`.`compliance`.`obligation` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `education_ecm`.`compliance`.`obligation` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Date');
ALTER TABLE `education_ecm`.`compliance`.`obligation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Obligation Notes');
ALTER TABLE `education_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_business_glossary_term' = 'Obligation Code');
ALTER TABLE `education_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `education_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_name` SET TAGS ('dbx_business_glossary_term' = 'Obligation Name');
ALTER TABLE `education_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_status` SET TAGS ('dbx_business_glossary_term' = 'Obligation Status');
ALTER TABLE `education_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_status` SET TAGS ('dbx_value_regex' = 'active|pending|completed|overdue|waived|suspended');
ALTER TABLE `education_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_business_glossary_term' = 'Obligation Type');
ALTER TABLE `education_ecm`.`compliance`.`obligation` ALTER COLUMN `penalty_description` SET TAGS ('dbx_business_glossary_term' = 'Penalty Description');
ALTER TABLE `education_ecm`.`compliance`.`obligation` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `education_ecm`.`compliance`.`obligation` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `education_ecm`.`compliance`.`obligation` ALTER COLUMN `requires_board_approval` SET TAGS ('dbx_business_glossary_term' = 'Requires Board Approval Flag');
ALTER TABLE `education_ecm`.`compliance`.`obligation` ALTER COLUMN `requires_external_audit` SET TAGS ('dbx_business_glossary_term' = 'Requires External Audit Flag');
ALTER TABLE `education_ecm`.`compliance`.`obligation` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `education_ecm`.`compliance`.`obligation` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'online-portal|email|mail|in-person|system-integration|not-applicable');
ALTER TABLE `education_ecm`.`compliance`.`obligation` ALTER COLUMN `training_completion_rate` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Rate Percentage');
ALTER TABLE `education_ecm`.`compliance`.`obligation` ALTER COLUMN `training_required` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `education_ecm`.`compliance`.`obligation` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `education_ecm`.`compliance`.`obligation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`compliance`.`obligation` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `education_ecm`.`compliance`.`policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`compliance`.`policy` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `education_ecm`.`compliance`.`policy` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier (ID)');
ALTER TABLE `education_ecm`.`compliance`.`policy` ALTER COLUMN `it_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Implementing It Policy Id (Foreign Key)');
ALTER TABLE `education_ecm`.`compliance`.`policy` ALTER COLUMN `supersedes_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Supersedes Policy Identifier (ID)');
ALTER TABLE `education_ecm`.`compliance`.`policy` ALTER COLUMN `acknowledgment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Required Flag');
ALTER TABLE `education_ecm`.`compliance`.`policy` ALTER COLUMN `applicability_scope` SET TAGS ('dbx_business_glossary_term' = 'Applicability Scope');
ALTER TABLE `education_ecm`.`compliance`.`policy` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `education_ecm`.`compliance`.`policy` ALTER COLUMN `audit_trail_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Notes');
ALTER TABLE `education_ecm`.`compliance`.`policy` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `education_ecm`.`compliance`.`policy` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `education_ecm`.`compliance`.`policy` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`compliance`.`policy` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`policy` ALTER COLUMN `contact_office` SET TAGS ('dbx_business_glossary_term' = 'Contact Office');
ALTER TABLE `education_ecm`.`compliance`.`policy` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `education_ecm`.`compliance`.`policy` ALTER COLUMN `contact_phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `education_ecm`.`compliance`.`policy` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`compliance`.`policy` ALTER COLUMN `document_repository_path` SET TAGS ('dbx_business_glossary_term' = 'Document Repository Path');
ALTER TABLE `education_ecm`.`compliance`.`policy` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `education_ecm`.`compliance`.`policy` ALTER COLUMN `enforcement_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Mechanism');
ALTER TABLE `education_ecm`.`compliance`.`policy` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `education_ecm`.`compliance`.`policy` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `education_ecm`.`compliance`.`policy` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'all_locations|main_campus|branch_campuses|online_programs|international_sites');
ALTER TABLE `education_ecm`.`compliance`.`policy` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `education_ecm`.`compliance`.`policy` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Policy Keywords');
ALTER TABLE `education_ecm`.`compliance`.`policy` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `education_ecm`.`compliance`.`policy` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `education_ecm`.`compliance`.`policy` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `education_ecm`.`compliance`.`policy` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Policy Owner');
ALTER TABLE `education_ecm`.`compliance`.`policy` ALTER COLUMN `policy_category` SET TAGS ('dbx_business_glossary_term' = 'Policy Category');
ALTER TABLE `education_ecm`.`compliance`.`policy` ALTER COLUMN `policy_category` SET TAGS ('dbx_value_regex' = 'academic_integrity|title_ix|ada_accessibility|ferpa_privacy|research_ethics|financial_management');
ALTER TABLE `education_ecm`.`compliance`.`policy` ALTER COLUMN `policy_number` SET TAGS ('dbx_business_glossary_term' = 'Policy Number');
ALTER TABLE `education_ecm`.`compliance`.`policy` ALTER COLUMN `policy_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-d{3,5}$');
ALTER TABLE `education_ecm`.`compliance`.`policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_business_glossary_term' = 'Policy Status');
ALTER TABLE `education_ecm`.`compliance`.`policy` ALTER COLUMN `public_visibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Visibility Flag');
ALTER TABLE `education_ecm`.`compliance`.`policy` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `education_ecm`.`compliance`.`policy` ALTER COLUMN `related_policies` SET TAGS ('dbx_business_glossary_term' = 'Related Policies');
ALTER TABLE `education_ecm`.`compliance`.`policy` ALTER COLUMN `review_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle (Months)');
ALTER TABLE `education_ecm`.`compliance`.`policy` ALTER COLUMN `sanctions_description` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Description');
ALTER TABLE `education_ecm`.`compliance`.`policy` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Policy Subcategory');
ALTER TABLE `education_ecm`.`compliance`.`policy` ALTER COLUMN `summary` SET TAGS ('dbx_business_glossary_term' = 'Policy Summary');
ALTER TABLE `education_ecm`.`compliance`.`policy` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Policy Title');
ALTER TABLE `education_ecm`.`compliance`.`policy` ALTER COLUMN `training_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Training Frequency (Months)');
ALTER TABLE `education_ecm`.`compliance`.`policy` ALTER COLUMN `training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `education_ecm`.`compliance`.`policy` ALTER COLUMN `url` SET TAGS ('dbx_business_glossary_term' = 'Policy Uniform Resource Locator (URL)');
ALTER TABLE `education_ecm`.`compliance`.`policy` ALTER COLUMN `url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `education_ecm`.`compliance`.`policy` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `education_ecm`.`compliance`.`policy` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^d+.d+$');
ALTER TABLE `education_ecm`.`compliance`.`policy_version` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`compliance`.`policy_version` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ALTER COLUMN `policy_version_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Version Identifier (ID)');
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee Identifier (ID)');
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier (ID)');
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ALTER COLUMN `primary_policy_author_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Author Employee Identifier (ID)');
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ALTER COLUMN `primary_policy_author_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ALTER COLUMN `primary_policy_author_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ALTER COLUMN `superseded_version_policy_version_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Version Identifier (ID)');
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ALTER COLUMN `tertiary_policy_contact_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Employee Identifier (ID)');
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ALTER COLUMN `tertiary_policy_contact_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ALTER COLUMN `tertiary_policy_contact_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ALTER COLUMN `accessibility_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Compliant Flag');
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ALTER COLUMN `acknowledgment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Required Flag');
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ALTER COLUMN `archived_date` SET TAGS ('dbx_business_glossary_term' = 'Archived Date');
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ALTER COLUMN `archived_flag` SET TAGS ('dbx_business_glossary_term' = 'Archived Flag');
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ALTER COLUMN `change_summary` SET TAGS ('dbx_business_glossary_term' = 'Change Summary');
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ALTER COLUMN `document_format` SET TAGS ('dbx_business_glossary_term' = 'Document Format');
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ALTER COLUMN `document_format` SET TAGS ('dbx_value_regex' = 'pdf|docx|html|markdown');
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document Uniform Resource Locator (URL)');
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ALTER COLUMN `document_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ALTER COLUMN `legal_review_comments` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Comments');
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ALTER COLUMN `legal_review_comments` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ALTER COLUMN `legal_review_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Date');
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ALTER COLUMN `legal_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Required Flag');
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ALTER COLUMN `legal_review_status` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Status');
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ALTER COLUMN `legal_review_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|approved|rejected|conditional_approval');
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ALTER COLUMN `public_comment_period_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Comment Period Flag');
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ALTER COLUMN `responsible_office` SET TAGS ('dbx_business_glossary_term' = 'Responsible Office');
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency in Months');
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Revision Reason');
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ALTER COLUMN `stakeholder_consultation_flag` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Consultation Flag');
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ALTER COLUMN `superseded_date` SET TAGS ('dbx_business_glossary_term' = 'Superseded Date');
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ALTER COLUMN `training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ALTER COLUMN `version_status` SET TAGS ('dbx_business_glossary_term' = 'Version Status');
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ALTER COLUMN `version_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|active|superseded|archived');
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ALTER COLUMN `version_title` SET TAGS ('dbx_business_glossary_term' = 'Version Title');
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ALTER COLUMN `word_count` SET TAGS ('dbx_business_glossary_term' = 'Word Count');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` SET TAGS ('dbx_subdomain' = 'incident_management');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `title_ix_case_id` SET TAGS ('dbx_business_glossary_term' = 'Title IX Case ID');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `cybersecurity_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Related Cybersecurity Incident Id (Foreign Key)');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Title IX Coordinator ID');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Complainant ID');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `quaternary_title_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `quaternary_title_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `quaternary_title_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `tertiary_title_decision_maker_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Decision Maker ID');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `tertiary_title_decision_maker_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `tertiary_title_decision_maker_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `appeal_basis` SET TAGS ('dbx_business_glossary_term' = 'Appeal Basis');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `appeal_basis` SET TAGS ('dbx_value_regex' = 'procedural_irregularity|new_evidence|conflict_of_interest|other');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `appeal_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Decision Date');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `appeal_filed_by` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed By');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `appeal_filed_by` SET TAGS ('dbx_value_regex' = 'complainant|respondent|both');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `appeal_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Date');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `appeal_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_value_regex' = 'affirmed|reversed|remanded|modified');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `case_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Case Closure Date');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Title IX Case Number');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `case_number` SET TAGS ('dbx_value_regex' = '^TIX-[0-9]{4}-[0-9]{5}$');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Title IX Case Status');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `case_type` SET TAGS ('dbx_business_glossary_term' = 'Title IX Case Type');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `case_type` SET TAGS ('dbx_value_regex' = 'sexual_harassment|sexual_assault|stalking|dating_violence|domestic_violence|retaliation');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `clery_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Clery Act Reportable Flag');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `complainant_type` SET TAGS ('dbx_business_glossary_term' = 'Complainant Type');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `confidentiality_request_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Request Flag');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `determination_date` SET TAGS ('dbx_business_glossary_term' = 'Determination Date');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `determination_outcome` SET TAGS ('dbx_business_glossary_term' = 'Determination Outcome');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `determination_outcome` SET TAGS ('dbx_value_regex' = 'responsible|not_responsible|insufficient_evidence|dismissed');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `determination_rationale` SET TAGS ('dbx_business_glossary_term' = 'Determination Rationale');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `determination_rationale` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `formal_complaint_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Formal Complaint Filed Date');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `grievance_process_type` SET TAGS ('dbx_business_glossary_term' = 'Grievance Process Type');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `grievance_process_type` SET TAGS ('dbx_value_regex' = 'formal|informal|supportive_measures_only');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `hearing_date` SET TAGS ('dbx_business_glossary_term' = 'Hearing Date');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `incident_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Description');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `incident_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `incident_location` SET TAGS ('dbx_business_glossary_term' = 'Incident Location');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `interim_measures_flag` SET TAGS ('dbx_business_glossary_term' = 'Interim Measures Flag');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `investigation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completion Date');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `investigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `law_enforcement_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Notified Flag');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `ocr_complaint_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Office for Civil Rights (OCR) Complaint Filed Flag');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `report_date` SET TAGS ('dbx_business_glossary_term' = 'Report Date');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `respondent_type` SET TAGS ('dbx_business_glossary_term' = 'Respondent Type');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `retaliation_reported_flag` SET TAGS ('dbx_business_glossary_term' = 'Retaliation Reported Flag');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `sanctions_imposed` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Imposed');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `sanctions_imposed` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `supportive_measures_provided` SET TAGS ('dbx_business_glossary_term' = 'Supportive Measures Provided');
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ALTER COLUMN `supportive_measures_provided` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` SET TAGS ('dbx_subdomain' = 'incident_management');
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` ALTER COLUMN `clery_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Clery Incident Identifier (ID)');
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Csa Employee Id (Foreign Key)');
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` ALTER COLUMN `cybersecurity_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Cybersecurity Incident Id (Foreign Key)');
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` ALTER COLUMN `residence_hall_id` SET TAGS ('dbx_business_glossary_term' = 'Residence Hall Id (Foreign Key)');
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` ALTER COLUMN `studentlife_housing_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Housing Assignment Id (Foreign Key)');
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` ALTER COLUMN `arrest_made` SET TAGS ('dbx_business_glossary_term' = 'Arrest Made Indicator');
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Case Number');
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` ALTER COLUMN `clery_crime_category` SET TAGS ('dbx_business_glossary_term' = 'Clery Act Crime Category');
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` ALTER COLUMN `clery_geography_classification` SET TAGS ('dbx_business_glossary_term' = 'Clery Act Geography Classification');
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` ALTER COLUMN `clery_geography_classification` SET TAGS ('dbx_value_regex' = 'on_campus|on_campus_residential|non_campus|public_property|not_clery_geography');
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` ALTER COLUMN `disciplinary_referral_made` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Referral Made Indicator');
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` ALTER COLUMN `disposition_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Disposition Status');
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` ALTER COLUMN `emergency_notification_issued` SET TAGS ('dbx_business_glossary_term' = 'Emergency Notification Issued Indicator');
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` ALTER COLUMN `hate_crime_bias_category` SET TAGS ('dbx_business_glossary_term' = 'Hate Crime Bias Category');
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Occurrence Date');
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` ALTER COLUMN `incident_narrative` SET TAGS ('dbx_business_glossary_term' = 'Incident Narrative Description');
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` ALTER COLUMN `incident_narrative` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Report Number');
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` ALTER COLUMN `incident_time` SET TAGS ('dbx_business_glossary_term' = 'Incident Occurrence Time');
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` ALTER COLUMN `included_in_asr` SET TAGS ('dbx_business_glossary_term' = 'Included in Annual Security Report (ASR) Indicator');
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` ALTER COLUMN `is_hate_crime` SET TAGS ('dbx_business_glossary_term' = 'Hate Crime Indicator');
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` ALTER COLUMN `is_residential_facility` SET TAGS ('dbx_business_glossary_term' = 'Residential Facility Indicator');
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` ALTER COLUMN `is_vawa_offense` SET TAGS ('dbx_business_glossary_term' = 'Violence Against Women Act (VAWA) Offense Indicator');
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` ALTER COLUMN `law_enforcement_agency` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Agency Name');
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Location Description');
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` ALTER COLUMN `reported_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Reported Date');
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` ALTER COLUMN `reporting_source` SET TAGS ('dbx_business_glossary_term' = 'Incident Reporting Source');
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` ALTER COLUMN `reporting_source` SET TAGS ('dbx_value_regex' = 'campus_security_authority|law_enforcement|anonymous_tip|victim_report|third_party');
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` ALTER COLUMN `reporting_year` SET TAGS ('dbx_business_glossary_term' = 'Clery Reporting Year');
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` ALTER COLUMN `timely_warning_issued` SET TAGS ('dbx_business_glossary_term' = 'Timely Warning Issued Indicator');
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` ALTER COLUMN `unfounded_reason` SET TAGS ('dbx_business_glossary_term' = 'Unfounded Incident Reason');
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` ALTER COLUMN `victim_notification_provided` SET TAGS ('dbx_business_glossary_term' = 'Victim Notification Provided Indicator');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` SET TAGS ('dbx_subdomain' = 'incident_management');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `ada_accommodation_id` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Accommodation ID');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Effective Term ID');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `enterprise_application_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Application Id (Foreign Key)');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student ID');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `residence_room_id` SET TAGS ('dbx_business_glossary_term' = 'Residence Room Id (Foreign Key)');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `studentlife_housing_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Housing Assignment Id (Foreign Key)');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `tertiary_ada_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By Employee ID');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `tertiary_ada_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `tertiary_ada_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `accommodation_description` SET TAGS ('dbx_business_glossary_term' = 'Accommodation Description');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `accommodation_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `accommodation_type` SET TAGS ('dbx_business_glossary_term' = 'Accommodation Type');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Accommodation Actual Cost');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `appeal_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Date');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `appeal_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_value_regex' = 'upheld|overturned|modified|pending');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|denied|pending|withdrawn|expired');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `confidentiality_agreement_signed_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Agreement Signed Flag');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Accommodation Cost Estimate');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `delivery_confirmation_date` SET TAGS ('dbx_business_glossary_term' = 'Accommodation Delivery Confirmation Date');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|delivered|delayed|cancelled');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `denial_reason` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `disability_category` SET TAGS ('dbx_business_glossary_term' = 'Disability Category');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `disability_category` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `documentation_received_date` SET TAGS ('dbx_business_glossary_term' = 'Documentation Received Date');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `documentation_type` SET TAGS ('dbx_business_glossary_term' = 'Documentation Type');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `documentation_type` SET TAGS ('dbx_value_regex' = 'medical|psychological|educational|functional');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `eligibility_determination` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Determination');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `eligibility_determination` SET TAGS ('dbx_value_regex' = 'eligible|not_eligible|pending_review|additional_info_required');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `eligibility_determination_date` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Determination Date');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `implementing_office` SET TAGS ('dbx_business_glossary_term' = 'Implementing Office');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `interactive_process_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Interactive Process Completed Flag');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `interactive_process_notes` SET TAGS ('dbx_business_glossary_term' = 'Interactive Process Notes');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `interactive_process_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Accommodation Notification Sent Date');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `ocr_complaint_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Office for Civil Rights (OCR) Complaint Filed Flag');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `renewal_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Accommodation Request Date');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Accommodation Request Number');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `requestor_type` SET TAGS ('dbx_business_glossary_term' = 'Requestor Type');
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ALTER COLUMN `requestor_type` SET TAGS ('dbx_value_regex' = 'student|faculty|staff|visitor|applicant');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` SET TAGS ('dbx_subdomain' = 'incident_management');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `ferpa_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Family Educational Rights and Privacy Act (FERPA) Disclosure Identifier');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `authorizing_identity_account_id` SET TAGS ('dbx_business_glossary_term' = 'Authorizing Identity Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Authorizing Official Identifier');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `health_visit_id` SET TAGS ('dbx_business_glossary_term' = 'Health Visit Id (Foreign Key)');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `health_visit_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `health_visit_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student Identifier');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `academic_term_code` SET TAGS ('dbx_business_glossary_term' = 'Academic Term Code');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `audit_review_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Review Date');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `audit_review_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Review Flag');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `authorizing_official_title` SET TAGS ('dbx_business_glossary_term' = 'Authorizing Official Title');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `consent_form_reference` SET TAGS ('dbx_business_glossary_term' = 'Consent Form Reference Number');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `consent_obtained_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained Flag');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `court_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Court Jurisdiction');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `court_order_number` SET TAGS ('dbx_business_glossary_term' = 'Court Order Number');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `court_order_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `disclosure_date` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Date');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `disclosure_method` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Method');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `disclosure_notes` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Notes');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `disclosure_number` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Reference Number');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `disclosure_number` SET TAGS ('dbx_value_regex' = '^FERPA-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `disclosure_purpose` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Purpose');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `disclosure_status` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Status');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `disclosure_status` SET TAGS ('dbx_value_regex' = 'pending|completed|cancelled|under_review|disputed');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `disclosure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Timestamp');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `emergency_justification` SET TAGS ('dbx_business_glossary_term' = 'Health or Safety Emergency Justification');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `legal_basis` SET TAGS ('dbx_business_glossary_term' = 'Legal Basis for Disclosure');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `recipient_email` SET TAGS ('dbx_business_glossary_term' = 'Recipient Email Address');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `recipient_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `recipient_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `recipient_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `recipient_name` SET TAGS ('dbx_business_glossary_term' = 'Recipient Name');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `recipient_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `recipient_organization` SET TAGS ('dbx_business_glossary_term' = 'Recipient Organization');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `recipient_organization` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `recipient_phone` SET TAGS ('dbx_business_glossary_term' = 'Recipient Phone Number');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `recipient_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `recipient_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `recipient_type` SET TAGS ('dbx_business_glossary_term' = 'Recipient Type');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `record_type` SET TAGS ('dbx_business_glossary_term' = 'Education Record Type');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `records_disclosed` SET TAGS ('dbx_business_glossary_term' = 'Records Disclosed Description');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `redisclosure_notification_text` SET TAGS ('dbx_business_glossary_term' = 'Redisclosure Notification Text');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `redisclosure_restriction_flag` SET TAGS ('dbx_business_glossary_term' = 'Redisclosure Restriction Flag');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `student_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Student Notification Date');
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ALTER COLUMN `student_notification_flag` SET TAGS ('dbx_business_glossary_term' = 'Student Notification Flag');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` SET TAGS ('dbx_subdomain' = 'accreditation_standards');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `accreditation_review_id` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Review Identifier (ID)');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Identifier (ID)');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `accrediting_body_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `accreditation_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Accreditation Standard Id (Foreign Key)');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `enterprise_application_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewed Application Id (Foreign Key)');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User Identifier (ID)');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Self-Study Lead Employee Identifier (ID)');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `student_org_id` SET TAGS ('dbx_business_glossary_term' = 'Student Org Id (Foreign Key)');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `updated_by_user_identity_account_id` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User Identifier (ID)');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `updated_by_user_identity_account_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `updated_by_user_identity_account_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `accreditation_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Decision Date');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `accreditation_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Effective Date');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `accreditation_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Expiration Date');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `accreditation_type` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Type');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `accreditation_type` SET TAGS ('dbx_value_regex' = 'institutional|programmatic|specialized');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `appeal_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Date');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `appeal_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_value_regex' = 'upheld|overturned|modified|pending');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `appeal_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Resolution Date');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `cip_code` SET TAGS ('dbx_business_glossary_term' = 'Classification of Instructional Programs (CIP) Code');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `cip_code` SET TAGS ('dbx_value_regex' = '^d{2}.d{4}$');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `conditions_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Conditions Issued Flag');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `conditions_summary` SET TAGS ('dbx_business_glossary_term' = 'Conditions Summary');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `interim_report_due_date` SET TAGS ('dbx_business_glossary_term' = 'Interim Report Due Date');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `interim_report_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Interim Report Required Flag');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `interim_report_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Interim Report Submitted Date');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `next_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Due Date');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `public_disclosure_date` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure Date');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `public_disclosure_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure Required Flag');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `recommendations_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Recommendations Issued Flag');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `recommendations_summary` SET TAGS ('dbx_business_glossary_term' = 'Recommendations Summary');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `review_coordinator_notes` SET TAGS ('dbx_business_glossary_term' = 'Review Coordinator Notes');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `review_cycle_type` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle Type');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `review_cycle_type` SET TAGS ('dbx_value_regex' = 'initial|reaffirmation|focused_visit|interim_monitoring|substantive_change|comprehensive');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `review_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period End Date');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `review_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period Start Date');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `self_study_due_date` SET TAGS ('dbx_business_glossary_term' = 'Self-Study Report Due Date');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `self_study_lead_name` SET TAGS ('dbx_business_glossary_term' = 'Self-Study Lead Name');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `self_study_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Self-Study Report Submitted Date');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `site_visit_end_date` SET TAGS ('dbx_business_glossary_term' = 'Site Visit End Date');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `site_visit_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Site Visit Scheduled Date');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `site_visit_team_chair` SET TAGS ('dbx_business_glossary_term' = 'Site Visit Team Chair Name');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `site_visit_team_size` SET TAGS ('dbx_business_glossary_term' = 'Site Visit Team Size');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_standard` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_standard` SET TAGS ('dbx_subdomain' = 'accreditation_standards');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_standard` ALTER COLUMN `accreditation_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Standard Identifier');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_standard` ALTER COLUMN `accrediting_body_id` SET TAGS ('dbx_business_glossary_term' = 'Accrediting Body Identifier (ID)');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_standard` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Org Unit Id (Foreign Key)');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_standard` ALTER COLUMN `accreditor_guidance_url` SET TAGS ('dbx_business_glossary_term' = 'Accreditor Guidance Uniform Resource Locator (URL)');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_standard` ALTER COLUMN `applicability_level` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Standard Applicability Level');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_standard` ALTER COLUMN `applicability_level` SET TAGS ('dbx_value_regex' = 'institutional|program|departmental|college|school');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_standard` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_standard` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_standard` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|partially_compliant|under_review|not_applicable|pending_evidence');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_standard` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_standard` ALTER COLUMN `criterion_description` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Criterion Description');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_standard` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Standard Effective Date');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_standard` ALTER COLUMN `evidence_requirement_summary` SET TAGS ('dbx_business_glossary_term' = 'Evidence Requirement Summary');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_standard` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Standard Expiration Date');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_standard` ALTER COLUMN `is_core_requirement` SET TAGS ('dbx_business_glossary_term' = 'Is Core Requirement Flag');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_standard` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_standard` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_standard` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Standard Priority Level');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_standard` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_standard` ALTER COLUMN `standard_category` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Standard Category');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_standard` ALTER COLUMN `standard_number` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Standard Number');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_standard` ALTER COLUMN `standard_title` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Standard Title');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_standard` ALTER COLUMN `standard_version` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Standard Version');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_standard` ALTER COLUMN `standard_weight` SET TAGS ('dbx_business_glossary_term' = 'Standard Weight');
ALTER TABLE `education_ecm`.`compliance`.`accreditation_standard` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` SET TAGS ('dbx_subdomain' = 'audit_monitoring');
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) ID');
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ALTER COLUMN `accreditation_review_id` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Review Id (Foreign Key)');
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Finding ID');
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Officer ID');
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Organizational Unit ID');
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Related Policy ID');
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ALTER COLUMN `board_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Board Notification Required Flag');
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ALTER COLUMN `cap_number` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) Number');
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ALTER COLUMN `closure_status` SET TAGS ('dbx_business_glossary_term' = 'Closure Status');
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ALTER COLUMN `closure_status` SET TAGS ('dbx_value_regex' = 'open|pending_verification|verified|closed|reopened');
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) Status');
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ALTER COLUMN `escalation_required` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost');
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ALTER COLUMN `evidence_of_remediation` SET TAGS ('dbx_business_glossary_term' = 'Evidence of Remediation');
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ALTER COLUMN `external_report_date` SET TAGS ('dbx_business_glossary_term' = 'External Report Date');
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ALTER COLUMN `external_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'External Reporting Required Flag');
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ALTER COLUMN `finding_description` SET TAGS ('dbx_business_glossary_term' = 'Finding Description');
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ALTER COLUMN `finding_source` SET TAGS ('dbx_business_glossary_term' = 'Finding Source');
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ALTER COLUMN `finding_source` SET TAGS ('dbx_value_regex' = 'external_audit|internal_audit|accreditor|regulatory_agency|self_assessment|peer_review');
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ALTER COLUMN `implementation_plan` SET TAGS ('dbx_business_glossary_term' = 'Implementation Plan');
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ALTER COLUMN `milestone_count` SET TAGS ('dbx_business_glossary_term' = 'Milestone Count');
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ALTER COLUMN `milestones_completed` SET TAGS ('dbx_business_glossary_term' = 'Milestones Completed');
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annually|as_needed');
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ALTER COLUMN `recurrence_risk` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Risk');
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ALTER COLUMN `recurrence_risk` SET TAGS ('dbx_value_regex' = 'high|moderate|low');
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ALTER COLUMN `responsible_officer_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Officer Name');
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ALTER COLUMN `responsible_officer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ALTER COLUMN `responsible_unit_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Organizational Unit Name');
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|moderate|low');
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'document_review|site_visit|data_analysis|interview|testing|observation');
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` SET TAGS ('dbx_subdomain' = 'audit_monitoring');
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Identifier (ID)');
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ALTER COLUMN `accreditation_review_id` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Review Id (Foreign Key)');
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Identifier (ID)');
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By Employee Id (Foreign Key)');
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ALTER COLUMN `affected_program` SET TAGS ('dbx_business_glossary_term' = 'Affected Program');
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ALTER COLUMN `affected_unit` SET TAGS ('dbx_business_glossary_term' = 'Affected Unit');
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ALTER COLUMN `audit_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Period End Date');
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ALTER COLUMN `audit_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Period Start Date');
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ALTER COLUMN `auditing_entity` SET TAGS ('dbx_business_glossary_term' = 'Auditing Entity');
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ALTER COLUMN `cause` SET TAGS ('dbx_business_glossary_term' = 'Audit Cause');
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ALTER COLUMN `cfda_number` SET TAGS ('dbx_business_glossary_term' = 'Catalog of Federal Domestic Assistance (CFDA) Number');
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ALTER COLUMN `cfda_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2}.[0-9]{3}$');
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ALTER COLUMN `condition` SET TAGS ('dbx_business_glossary_term' = 'Audit Condition');
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP)');
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ALTER COLUMN `effect` SET TAGS ('dbx_business_glossary_term' = 'Audit Effect');
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ALTER COLUMN `federal_program_name` SET TAGS ('dbx_business_glossary_term' = 'Federal Program Name');
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ALTER COLUMN `finding_category` SET TAGS ('dbx_business_glossary_term' = 'Finding Category');
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ALTER COLUMN `finding_category` SET TAGS ('dbx_value_regex' = 'material_weakness|significant_deficiency|noncompliance|observation|best_practice_recommendation|control_deficiency');
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ALTER COLUMN `finding_description` SET TAGS ('dbx_business_glossary_term' = 'Finding Description');
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ALTER COLUMN `finding_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Finding Issued Date');
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ALTER COLUMN `finding_number` SET TAGS ('dbx_business_glossary_term' = 'Finding Number');
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ALTER COLUMN `finding_title` SET TAGS ('dbx_business_glossary_term' = 'Finding Title');
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_business_glossary_term' = 'Finding Type');
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ALTER COLUMN `management_response` SET TAGS ('dbx_business_glossary_term' = 'Management Response');
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Finding Notes');
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ALTER COLUMN `prior_finding_reference` SET TAGS ('dbx_business_glossary_term' = 'Prior Finding Reference Number');
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ALTER COLUMN `questioned_costs_amount` SET TAGS ('dbx_business_glossary_term' = 'Questioned Costs Amount');
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ALTER COLUMN `questioned_costs_currency` SET TAGS ('dbx_business_glossary_term' = 'Questioned Costs Currency Code');
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ALTER COLUMN `questioned_costs_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ALTER COLUMN `recommendation` SET TAGS ('dbx_business_glossary_term' = 'Auditor Recommendation');
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ALTER COLUMN `repeat_finding_flag` SET TAGS ('dbx_business_glossary_term' = 'Repeat Finding Flag');
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ALTER COLUMN `reported_to_federal_agency_flag` SET TAGS ('dbx_business_glossary_term' = 'Reported to Federal Agency Flag');
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ALTER COLUMN `reported_to_governing_board_flag` SET TAGS ('dbx_business_glossary_term' = 'Reported to Governing Board Flag');
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|pending_verification|resolved|closed|overdue');
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Identifier (ID)');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `original_filing_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Original Filing Identifier (ID)');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_business_glossary_term' = 'Preparer Identity Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Employee Id (Foreign Key)');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `academic_year` SET TAGS ('dbx_business_glossary_term' = 'Academic Year');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Date');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `certification_statement` SET TAGS ('dbx_business_glossary_term' = 'Certification Statement');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `certifying_official_name` SET TAGS ('dbx_business_glossary_term' = 'Certifying Official Name');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `certifying_official_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `certifying_official_title` SET TAGS ('dbx_business_glossary_term' = 'Certifying Official Title');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `confirmation_reference` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Reference Number');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `document_repository_path` SET TAGS ('dbx_business_glossary_term' = 'Document Repository Path');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Due Date');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_description` SET TAGS ('dbx_business_glossary_term' = 'Filing Description');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_number` SET TAGS ('dbx_business_glossary_term' = 'Filing Reference Number');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Period End Date');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Period Start Date');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Filing Status');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_type` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Type');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_url` SET TAGS ('dbx_business_glossary_term' = 'Filing Uniform Resource Locator (URL)');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year (FY)');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `is_amended_filing` SET TAGS ('dbx_business_glossary_term' = 'Amended Filing Indicator');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `is_late_filing` SET TAGS ('dbx_business_glossary_term' = 'Late Filing Indicator');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Filing Notes');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `preparer_email` SET TAGS ('dbx_business_glossary_term' = 'Preparer Email Address');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `preparer_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `preparer_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `preparer_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `preparer_name` SET TAGS ('dbx_business_glossary_term' = 'Preparer Full Name');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `preparer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `preparer_phone` SET TAGS ('dbx_business_glossary_term' = 'Preparer Phone Number');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `preparer_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `preparer_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body Name');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_body_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body Code');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `rejection_date` SET TAGS ('dbx_business_glossary_term' = 'Rejection Date');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `resubmission_count` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Count');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `submitting_office` SET TAGS ('dbx_business_glossary_term' = 'Submitting Office Name');
ALTER TABLE `education_ecm`.`compliance`.`training_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`compliance`.`training_program` SET TAGS ('dbx_subdomain' = 'incident_management');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `training_program_id` SET TAGS ('dbx_business_glossary_term' = 'Training Program Identifier');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `certificate_template_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate Template Identifier (ID)');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `enterprise_application_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Application Id (Foreign Key)');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Org Unit Id (Foreign Key)');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `updated_by_user_identity_account_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier (ID)');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `updated_by_user_identity_account_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `updated_by_user_identity_account_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `accessibility_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Compliant Flag');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `accreditation_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Credit Hours');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `audit_trail_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Required Flag');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `certificate_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issued Flag');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `completion_deadline_days` SET TAGS ('dbx_business_glossary_term' = 'Completion Deadline in Days');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `content_url` SET TAGS ('dbx_business_glossary_term' = 'Content Uniform Resource Locator (URL)');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `content_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `content_version` SET TAGS ('dbx_business_glossary_term' = 'Content Version');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `content_version` SET TAGS ('dbx_value_regex' = '^v?[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `cost_per_learner` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Learner');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `cost_per_learner` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `delivery_modality` SET TAGS ('dbx_business_glossary_term' = 'Delivery Modality');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `delivery_modality` SET TAGS ('dbx_value_regex' = 'online|in_person|hybrid|self_paced|instructor_led');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Training Duration in Minutes');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `ipeds_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Integrated Postsecondary Education Data System (IPEDS) Reporting Flag');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `learning_objectives` SET TAGS ('dbx_business_glossary_term' = 'Learning Objectives');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `mobile_compatible_flag` SET TAGS ('dbx_business_glossary_term' = 'Mobile Compatible Flag');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `mobile_compatible_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `mobile_compatible_flag` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `passing_score_percentage` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Percentage');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `recertification_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Recertification Frequency in Months');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `training_code` SET TAGS ('dbx_business_glossary_term' = 'Training Program Code');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `training_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `training_name` SET TAGS ('dbx_business_glossary_term' = 'Training Program Name');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `training_program_description` SET TAGS ('dbx_business_glossary_term' = 'Training Program Description');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `training_program_status` SET TAGS ('dbx_business_glossary_term' = 'Training Program Status');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `training_program_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_review|archived|draft');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `training_type` SET TAGS ('dbx_business_glossary_term' = 'Training Program Type');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `training_type` SET TAGS ('dbx_value_regex' = 'mandatory|recommended|optional|conditional');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`compliance`.`training_program` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` SET TAGS ('dbx_subdomain' = 'incident_management');
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ALTER COLUMN `compliance_training_completion_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Training Completion ID');
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Trainee Identifier');
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_business_glossary_term' = 'Identity Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ALTER COLUMN `lms_course_shell_id` SET TAGS ('dbx_business_glossary_term' = 'Learning Management System (LMS) Course ID');
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ALTER COLUMN `training_program_id` SET TAGS ('dbx_business_glossary_term' = 'Training Program Identifier');
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ALTER COLUMN `accreditation_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Eligible Flag');
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score');
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ALTER COLUMN `attempt_number` SET TAGS ('dbx_business_glossary_term' = 'Attempt Number');
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ALTER COLUMN `audit_trail_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Notes');
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ALTER COLUMN `browser_type` SET TAGS ('dbx_business_glossary_term' = 'Browser Type');
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ALTER COLUMN `certificate_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issue Date');
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ALTER COLUMN `certificate_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issued Flag');
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ALTER COLUMN `completion_method` SET TAGS ('dbx_business_glossary_term' = 'Completion Method');
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ALTER COLUMN `completion_method` SET TAGS ('dbx_value_regex' = 'online|in_person|hybrid|webinar|self_paced|instructor_led');
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Completion Status');
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ALTER COLUMN `completion_status` SET TAGS ('dbx_value_regex' = 'completed|passed|failed|incomplete|waived|expired');
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ALTER COLUMN `compliance_category` SET TAGS ('dbx_business_glossary_term' = 'Compliance Category');
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|laptop|tablet|mobile|other');
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ALTER COLUMN `overdue_flag` SET TAGS ('dbx_business_glossary_term' = 'Overdue Flag');
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ALTER COLUMN `pass_fail_indicator` SET TAGS ('dbx_business_glossary_term' = 'Pass Fail Indicator');
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ALTER COLUMN `passing_score_required` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Required');
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ALTER COLUMN `recertification_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Recertification Frequency Months');
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ALTER COLUMN `recertification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Recertification Required Flag');
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ALTER COLUMN `supervisor_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Notification Date');
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ALTER COLUMN `supervisor_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Notified Flag');
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ALTER COLUMN `trainee_type` SET TAGS ('dbx_business_glossary_term' = 'Trainee Type');
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ALTER COLUMN `trainee_type` SET TAGS ('dbx_value_regex' = 'employee|faculty|student|contractor|volunteer|affiliate');
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ALTER COLUMN `training_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Training Duration Minutes');
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ALTER COLUMN `training_provider` SET TAGS ('dbx_business_glossary_term' = 'Training Provider');
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ALTER COLUMN `training_version` SET TAGS ('dbx_business_glossary_term' = 'Training Version');
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ALTER COLUMN `waiver_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approved By');
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ALTER COLUMN `waiver_granted_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver Granted Flag');
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `state_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'State Authorization ID');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Staff Employee Id (Foreign Key)');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `agency_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Agency Contact Email');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `agency_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `agency_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `agency_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `agency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Agency Contact Name');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `agency_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `agency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Agency Contact Phone');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `agency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `agency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `agency_website_url` SET TAGS ('dbx_business_glossary_term' = 'Agency Website URL');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `annual_report_due_date` SET TAGS ('dbx_business_glossary_term' = 'Annual Report Due Date');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `annual_report_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Annual Report Required Flag');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Date');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `authorization_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Authorization Fee Amount');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Authorization Number');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Authorization Status');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `authorization_status` SET TAGS ('dbx_value_regex' = 'authorized|pending|expired|denied|withdrawn|not_required');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `authorization_type` SET TAGS ('dbx_business_glossary_term' = 'Authorization Type');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `authorization_type` SET TAGS ('dbx_value_regex' = 'distance_education|physical_presence|clinical_placement|recruiting|field_experience|internship');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `authorized_program_list` SET TAGS ('dbx_business_glossary_term' = 'Authorized Program List');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `complaint_disclosure_status` SET TAGS ('dbx_business_glossary_term' = 'Complaint Disclosure Status');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `complaint_disclosure_status` SET TAGS ('dbx_value_regex' = 'disclosed|not_disclosed|not_required');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `enrolled_student_count` SET TAGS ('dbx_business_glossary_term' = 'Enrolled Student Count');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `exemption_basis` SET TAGS ('dbx_business_glossary_term' = 'Exemption Basis');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `exemption_flag` SET TAGS ('dbx_business_glossary_term' = 'Exemption Flag');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `fee_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Fee Payment Date');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `last_report_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Last Report Submission Date');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `physical_location_address` SET TAGS ('dbx_business_glossary_term' = 'Physical Location Address');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `physical_location_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `physical_location_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `physical_location_city` SET TAGS ('dbx_business_glossary_term' = 'Physical Location City');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `physical_location_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Physical Location Postal Code');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `physical_location_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `physical_location_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `responsible_office` SET TAGS ('dbx_business_glossary_term' = 'Responsible Office');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `sara_participation_flag` SET TAGS ('dbx_business_glossary_term' = 'State Authorization Reciprocity Agreement (SARA) Participation Flag');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `state_agency_name` SET TAGS ('dbx_business_glossary_term' = 'State Agency Name');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `state_name` SET TAGS ('dbx_business_glossary_term' = 'State Name');
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ALTER COLUMN `student_complaint_process_url` SET TAGS ('dbx_business_glossary_term' = 'Student Complaint Process URL');
ALTER TABLE `education_ecm`.`compliance`.`internal_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`compliance`.`internal_review` SET TAGS ('dbx_subdomain' = 'audit_monitoring');
ALTER TABLE `education_ecm`.`compliance`.`internal_review` ALTER COLUMN `internal_review_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Review Identifier');
ALTER TABLE `education_ecm`.`compliance`.`internal_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Reviewer Employee Id (Foreign Key)');
ALTER TABLE `education_ecm`.`compliance`.`internal_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`internal_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`internal_review` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `education_ecm`.`compliance`.`internal_review` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement ID');
ALTER TABLE `education_ecm`.`compliance`.`internal_review` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Org Unit Id (Foreign Key)');
ALTER TABLE `education_ecm`.`compliance`.`internal_review` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `education_ecm`.`compliance`.`internal_review` ALTER COLUMN `compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Compliance Score');
ALTER TABLE `education_ecm`.`compliance`.`internal_review` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `education_ecm`.`compliance`.`internal_review` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'Public|Internal|Confidential|Restricted');
ALTER TABLE `education_ecm`.`compliance`.`internal_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`compliance`.`internal_review` ALTER COLUMN `documentation_location` SET TAGS ('dbx_business_glossary_term' = 'Documentation Location');
ALTER TABLE `education_ecm`.`compliance`.`internal_review` ALTER COLUMN `external_reporting_date` SET TAGS ('dbx_business_glossary_term' = 'External Reporting Date');
ALTER TABLE `education_ecm`.`compliance`.`internal_review` ALTER COLUMN `external_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'External Reporting Required Flag');
ALTER TABLE `education_ecm`.`compliance`.`internal_review` ALTER COLUMN `findings_count` SET TAGS ('dbx_business_glossary_term' = 'Findings Count');
ALTER TABLE `education_ecm`.`compliance`.`internal_review` ALTER COLUMN `findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Findings Summary');
ALTER TABLE `education_ecm`.`compliance`.`internal_review` ALTER COLUMN `follow_up_due_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Due Date');
ALTER TABLE `education_ecm`.`compliance`.`internal_review` ALTER COLUMN `follow_up_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `education_ecm`.`compliance`.`internal_review` ALTER COLUMN `follow_up_status` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Status');
ALTER TABLE `education_ecm`.`compliance`.`internal_review` ALTER COLUMN `follow_up_status` SET TAGS ('dbx_value_regex' = 'Not Started|In Progress|Completed|Overdue|Waived');
ALTER TABLE `education_ecm`.`compliance`.`internal_review` ALTER COLUMN `methodology_description` SET TAGS ('dbx_business_glossary_term' = 'Methodology Description');
ALTER TABLE `education_ecm`.`compliance`.`internal_review` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `education_ecm`.`compliance`.`internal_review` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `education_ecm`.`compliance`.`internal_review` ALTER COLUMN `population_size` SET TAGS ('dbx_business_glossary_term' = 'Population Size');
ALTER TABLE `education_ecm`.`compliance`.`internal_review` ALTER COLUMN `recommendations_count` SET TAGS ('dbx_business_glossary_term' = 'Recommendations Count');
ALTER TABLE `education_ecm`.`compliance`.`internal_review` ALTER COLUMN `recommendations_issued` SET TAGS ('dbx_business_glossary_term' = 'Recommendations Issued');
ALTER TABLE `education_ecm`.`compliance`.`internal_review` ALTER COLUMN `report_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Report Issued Date');
ALTER TABLE `education_ecm`.`compliance`.`internal_review` ALTER COLUMN `report_recipients` SET TAGS ('dbx_business_glossary_term' = 'Report Recipients');
ALTER TABLE `education_ecm`.`compliance`.`internal_review` ALTER COLUMN `responsible_officer_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Officer Name');
ALTER TABLE `education_ecm`.`compliance`.`internal_review` ALTER COLUMN `review_code` SET TAGS ('dbx_business_glossary_term' = 'Review Code');
ALTER TABLE `education_ecm`.`compliance`.`internal_review` ALTER COLUMN `review_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{4}-[0-9]{3,5}$');
ALTER TABLE `education_ecm`.`compliance`.`internal_review` ALTER COLUMN `review_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `education_ecm`.`compliance`.`internal_review` ALTER COLUMN `review_name` SET TAGS ('dbx_business_glossary_term' = 'Review Name');
ALTER TABLE `education_ecm`.`compliance`.`internal_review` ALTER COLUMN `review_notes` SET TAGS ('dbx_business_glossary_term' = 'Review Notes');
ALTER TABLE `education_ecm`.`compliance`.`internal_review` ALTER COLUMN `review_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period End Date');
ALTER TABLE `education_ecm`.`compliance`.`internal_review` ALTER COLUMN `review_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period Start Date');
ALTER TABLE `education_ecm`.`compliance`.`internal_review` ALTER COLUMN `review_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Start Date');
ALTER TABLE `education_ecm`.`compliance`.`internal_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `education_ecm`.`compliance`.`internal_review` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'Planned|In Progress|Under Review|Completed|Cancelled|On Hold');
ALTER TABLE `education_ecm`.`compliance`.`internal_review` ALTER COLUMN `review_team_members` SET TAGS ('dbx_business_glossary_term' = 'Review Team Members');
ALTER TABLE `education_ecm`.`compliance`.`internal_review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Review Type');
ALTER TABLE `education_ecm`.`compliance`.`internal_review` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `education_ecm`.`compliance`.`internal_review` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'Critical|High|Medium|Low|Informational');
ALTER TABLE `education_ecm`.`compliance`.`internal_review` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `education_ecm`.`compliance`.`internal_review` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `education_ecm`.`compliance`.`internal_review` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` SET TAGS ('dbx_subdomain' = 'audit_monitoring');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Identifier (ID)');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `modified_by_user_identity_account_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `modified_by_user_identity_account_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `modified_by_user_identity_account_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Related Policy Identifier (ID)');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Identifier (ID)');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Owner Employee Id (Foreign Key)');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `superseded_risk_assessment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `accreditation_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Impact Flag');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Record Flag');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `affected_population` SET TAGS ('dbx_business_glossary_term' = 'Affected Population');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Date');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `board_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Board Reporting Required Flag');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `control_effectiveness` SET TAGS ('dbx_business_glossary_term' = 'Control Effectiveness');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `control_effectiveness` SET TAGS ('dbx_value_regex' = 'effective|partially_effective|ineffective|not_tested');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `estimated_financial_impact` SET TAGS ('dbx_business_glossary_term' = 'Estimated Financial Impact');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `estimated_financial_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `external_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'External Reporting Required Flag');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `identification_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Identification Date');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `inherent_impact_rating` SET TAGS ('dbx_business_glossary_term' = 'Inherent Impact Rating');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `inherent_impact_rating` SET TAGS ('dbx_value_regex' = 'insignificant|minor|moderate|major|catastrophic');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `inherent_likelihood_rating` SET TAGS ('dbx_business_glossary_term' = 'Inherent Likelihood Rating');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `inherent_likelihood_rating` SET TAGS ('dbx_value_regex' = 'rare|unlikely|possible|likely|almost_certain');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `inherent_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Inherent Risk Score');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `last_board_report_date` SET TAGS ('dbx_business_glossary_term' = 'Last Board Report Date');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `mitigation_strategy` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Strategy');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `residual_impact_rating` SET TAGS ('dbx_business_glossary_term' = 'Residual Impact Rating');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `residual_impact_rating` SET TAGS ('dbx_value_regex' = 'insignificant|minor|moderate|major|catastrophic');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `residual_likelihood_rating` SET TAGS ('dbx_business_glossary_term' = 'Residual Likelihood Rating');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `residual_likelihood_rating` SET TAGS ('dbx_value_regex' = 'rare|unlikely|possible|likely|almost_certain');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `residual_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Score');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `responsible_office` SET TAGS ('dbx_business_glossary_term' = 'Responsible Office');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency in Months');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `risk_appetite_threshold` SET TAGS ('dbx_business_glossary_term' = 'Risk Appetite Threshold');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'regulatory|financial|reputational|operational|strategic|legal');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `risk_description` SET TAGS ('dbx_business_glossary_term' = 'Risk Description');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `risk_notes` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Notes');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `risk_number` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Number');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `risk_number` SET TAGS ('dbx_value_regex' = '^RISK-[0-9]{6}$');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `risk_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Status');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `risk_status` SET TAGS ('dbx_value_regex' = 'identified|assessed|active|mitigated|closed|monitoring');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `risk_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Risk Subcategory');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `risk_title` SET TAGS ('dbx_business_glossary_term' = 'Risk Title');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `risk_trend` SET TAGS ('dbx_business_glossary_term' = 'Risk Trend');
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `risk_trend` SET TAGS ('dbx_value_regex' = 'increasing|stable|decreasing');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `ipeds_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Integrated Postsecondary Education Data System (IPEDS) Submission Identifier');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `original_submission_ipeds_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Original IPEDS Submission Identifier');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Preparer Employee Identifier');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `amended_ipeds_submission_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'NCES Acceptance Date');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `certification_statement` SET TAGS ('dbx_business_glossary_term' = 'Data Certification Statement');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `collection_period` SET TAGS ('dbx_business_glossary_term' = 'IPEDS Collection Period');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `collection_period` SET TAGS ('dbx_value_regex' = 'Fall|Winter|Spring');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `data_extraction_date` SET TAGS ('dbx_business_glossary_term' = 'Data Extraction Date');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Due Date');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `edit_report_error_count` SET TAGS ('dbx_business_glossary_term' = 'Edit Report Error Count');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `edit_report_warning_count` SET TAGS ('dbx_business_glossary_term' = 'Edit Report Warning Count');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `imputation_flag` SET TAGS ('dbx_business_glossary_term' = 'NCES Imputation Flag');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `imputation_summary` SET TAGS ('dbx_business_glossary_term' = 'Imputation Summary');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Record Indicator');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `is_late_submission` SET TAGS ('dbx_business_glossary_term' = 'Late Submission Indicator');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `is_revision` SET TAGS ('dbx_business_glossary_term' = 'Revision Indicator');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `keyholder_name` SET TAGS ('dbx_business_glossary_term' = 'IPEDS Keyholder Name');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `keyholder_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `keyholder_title` SET TAGS ('dbx_business_glossary_term' = 'Keyholder Job Title');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `lock_date` SET TAGS ('dbx_business_glossary_term' = 'IPEDS Lock Date');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `nces_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'NCES Confirmation Number');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Submission Notes');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `peer_comparison_group` SET TAGS ('dbx_business_glossary_term' = 'IPEDS Peer Comparison Group');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `preparer_email` SET TAGS ('dbx_business_glossary_term' = 'Preparer Email Address');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `preparer_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `preparer_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `preparer_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `preparer_name` SET TAGS ('dbx_business_glossary_term' = 'Survey Preparer Name');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `preparer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `preparer_phone` SET TAGS ('dbx_business_glossary_term' = 'Preparer Phone Number');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `preparer_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `preparer_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `public_disclosure_date` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure Date');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `responsible_office` SET TAGS ('dbx_business_glossary_term' = 'Responsible Office Name');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Revision Reason');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Submission Date');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'web_entry|data_upload|api_integration');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `submission_number` SET TAGS ('dbx_business_glossary_term' = 'IPEDS Submission Number');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `survey_component` SET TAGS ('dbx_business_glossary_term' = 'IPEDS Survey Component');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `survey_year` SET TAGS ('dbx_business_glossary_term' = 'IPEDS Survey Year');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `unitid` SET TAGS ('dbx_business_glossary_term' = 'IPEDS Unit Identification (UNITID) Code');
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ALTER COLUMN `unitid` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `education_ecm`.`compliance`.`standard_requirement_mapping` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `education_ecm`.`compliance`.`standard_requirement_mapping` SET TAGS ('dbx_subdomain' = 'accreditation_standards');
ALTER TABLE `education_ecm`.`compliance`.`standard_requirement_mapping` SET TAGS ('dbx_association_edges' = 'compliance.accreditation_standard,compliance.regulatory_requirement');
ALTER TABLE `education_ecm`.`compliance`.`standard_requirement_mapping` ALTER COLUMN `standard_requirement_mapping_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Requirement Mapping - Standard Requirement Mapping Id');
ALTER TABLE `education_ecm`.`compliance`.`standard_requirement_mapping` ALTER COLUMN `accreditation_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Requirement Mapping - Compliance Accreditation Standard Id');
ALTER TABLE `education_ecm`.`compliance`.`standard_requirement_mapping` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Requirement Mapping - Regulatory Requirement Id');
ALTER TABLE `education_ecm`.`compliance`.`standard_requirement_mapping` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Mapping Compliance Status');
ALTER TABLE `education_ecm`.`compliance`.`standard_requirement_mapping` ALTER COLUMN `coverage_scope` SET TAGS ('dbx_business_glossary_term' = 'Coverage Scope');
ALTER TABLE `education_ecm`.`compliance`.`standard_requirement_mapping` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`compliance`.`standard_requirement_mapping` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Mapping Effective Date');
ALTER TABLE `education_ecm`.`compliance`.`standard_requirement_mapping` ALTER COLUMN `evidence_reference` SET TAGS ('dbx_business_glossary_term' = 'Evidence Reference');
ALTER TABLE `education_ecm`.`compliance`.`standard_requirement_mapping` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Mapping Expiration Date');
ALTER TABLE `education_ecm`.`compliance`.`standard_requirement_mapping` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Mapping Last Review Date');
ALTER TABLE `education_ecm`.`compliance`.`standard_requirement_mapping` ALTER COLUMN `mapping_notes` SET TAGS ('dbx_business_glossary_term' = 'Mapping Notes');
ALTER TABLE `education_ecm`.`compliance`.`standard_requirement_mapping` ALTER COLUMN `mapping_type` SET TAGS ('dbx_business_glossary_term' = 'Mapping Type');
ALTER TABLE `education_ecm`.`compliance`.`standard_requirement_mapping` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Mapping Next Review Date');
ALTER TABLE `education_ecm`.`compliance`.`standard_requirement_mapping` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `education_ecm`.`compliance`.`standard_requirement_mapping` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `education_ecm`.`compliance`.`standard_requirement_mapping` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `education_ecm`.`compliance`.`policy_implementation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `education_ecm`.`compliance`.`policy_implementation` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `education_ecm`.`compliance`.`policy_implementation` SET TAGS ('dbx_association_edges' = 'compliance.policy,compliance.regulatory_requirement');
ALTER TABLE `education_ecm`.`compliance`.`policy_implementation` ALTER COLUMN `policy_implementation_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Implementation ID');
ALTER TABLE `education_ecm`.`compliance`.`policy_implementation` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Implementation - Policy Id');
ALTER TABLE `education_ecm`.`compliance`.`policy_implementation` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Implementation - Regulatory Requirement Id');
ALTER TABLE `education_ecm`.`compliance`.`policy_implementation` ALTER COLUMN `citation_mapping` SET TAGS ('dbx_business_glossary_term' = 'Citation Mapping');
ALTER TABLE `education_ecm`.`compliance`.`policy_implementation` ALTER COLUMN `compliance_level` SET TAGS ('dbx_business_glossary_term' = 'Compliance Level');
ALTER TABLE `education_ecm`.`compliance`.`policy_implementation` ALTER COLUMN `coverage_scope` SET TAGS ('dbx_business_glossary_term' = 'Coverage Scope');
ALTER TABLE `education_ecm`.`compliance`.`policy_implementation` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `education_ecm`.`compliance`.`policy_implementation` ALTER COLUMN `gap_analysis_notes` SET TAGS ('dbx_business_glossary_term' = 'Gap Analysis Notes');
ALTER TABLE `education_ecm`.`compliance`.`policy_implementation` ALTER COLUMN `implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Implementation Date');
ALTER TABLE `education_ecm`.`compliance`.`policy_implementation` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `education_ecm`.`compliance`.`policy_implementation` ALTER COLUMN `last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Date');
ALTER TABLE `education_ecm`.`compliance`.`policy_implementation` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `education_ecm`.`compliance`.`policy_implementation` ALTER COLUMN `responsible_reviewer` SET TAGS ('dbx_business_glossary_term' = 'Responsible Reviewer');
ALTER TABLE `education_ecm`.`compliance`.`policy_implementation` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `education_ecm`.`compliance`.`accrediting_body` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`compliance`.`accrediting_body` SET TAGS ('dbx_subdomain' = 'accreditation_standards');
ALTER TABLE `education_ecm`.`compliance`.`accrediting_body` ALTER COLUMN `accrediting_body_id` SET TAGS ('dbx_business_glossary_term' = 'Accrediting Body Identifier');
ALTER TABLE `education_ecm`.`compliance`.`accrediting_body` ALTER COLUMN `parent_accrediting_body_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`accrediting_body` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`accrediting_body` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`accrediting_body` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`accrediting_body` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`accrediting_body` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`accrediting_body` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`accrediting_body` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`accrediting_body` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`accrediting_body` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`accrediting_body` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`audit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`compliance`.`audit` SET TAGS ('dbx_subdomain' = 'audit_monitoring');
ALTER TABLE `education_ecm`.`compliance`.`audit` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Identifier');
ALTER TABLE `education_ecm`.`compliance`.`audit` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`compliance`.`audit` ALTER COLUMN `followup_audit_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`audit` ALTER COLUMN `audit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`audit` ALTER COLUMN `external_auditor_fee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`compliance`.`certificate_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`compliance`.`certificate_template` SET TAGS ('dbx_subdomain' = 'incident_management');
ALTER TABLE `education_ecm`.`compliance`.`certificate_template` ALTER COLUMN `certificate_template_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate Template Identifier');
ALTER TABLE `education_ecm`.`compliance`.`certificate_template` ALTER COLUMN `parent_certificate_template_id` SET TAGS ('dbx_self_ref_fk' = 'true');
