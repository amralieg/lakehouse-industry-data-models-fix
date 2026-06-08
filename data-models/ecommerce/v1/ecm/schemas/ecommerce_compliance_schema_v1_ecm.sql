-- Schema for Domain: compliance | Business: Ecommerce | Version: v1_ecm
-- Generated on: 2026-05-04 23:24:09

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `ecommerce_ecm`.`compliance` COMMENT 'Manages regulatory compliance tracking, audit management, data protection (GDPR/CCPA), PCI DSS certification lifecycle, consumer protection regulations, and legal hold processes for the e-commerce platform. Owns regulation registry, audit schedules, certification records, and compliance evidence.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `ecommerce_ecm`.`compliance`.`regulation` (
    `regulation_id` BIGINT COMMENT 'System-generated unique identifier for each regulation record.',
    `parent_regulation_id` BIGINT COMMENT 'Self-referencing FK on regulation (parent_regulation_id)',
    `audit_evidence_required` STRING COMMENT 'Types of evidence needed to demonstrate compliance (e.g., logs, certificates).',
    `compliance_deadline` DATE COMMENT 'Date by which compliance actions must be completed.',
    `compliance_obligation_type` STRING COMMENT 'Indicates if compliance with the regulation is legally mandatory or voluntary.. Valid values are `mandatory|voluntary`',
    `compliance_status` STRING COMMENT 'Current compliance posture against the regulation.. Valid values are `compliant|non_compliant|partial|exempt`',
    `consumer_protection_requirements` STRING COMMENT 'Obligations to protect consumer rights (e.g., refund policies, advertising standards).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the regulation record was first created in the system.',
    `data_protection_level` STRING COMMENT 'Level of data protection required (e.g., "high", "standard").',
    `effective_date` DATE COMMENT 'Date on which the regulation becomes legally binding.',
    `enforcement_status` STRING COMMENT 'Whether the regulation is currently being enforced by the authority.. Valid values are `enforced|not_enforced|pending`',
    `expiry_date` DATE COMMENT 'Date on which the regulation ceases to be in effect (nullable for open‑ended regulations).',
    `is_mandatory` BOOLEAN COMMENT 'True if the regulation is mandatory for the business, false otherwise.',
    `jurisdiction` STRING COMMENT 'Geographic or legal jurisdiction to which the regulation applies (e.g., "EU", "California").',
    `last_audit_date` DATE COMMENT 'Date of the most recent compliance audit for this regulation.',
    `notes` STRING COMMENT 'Free‑form comments or observations.',
    `payment_security_requirements` STRING COMMENT 'Requirements related to payment data security (e.g., PCI DSS compliance).',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Maximum monetary penalty stipulated for non‑compliance.',
    `privacy_requirements` STRING COMMENT 'Specific privacy obligations (e.g., consent, data minimization).',
    `regulation_category` STRING COMMENT 'High‑level classification of the regulation purpose.. Valid values are `data_privacy|payment_security|consumer_protection|tax|trade|environmental`',
    `regulation_code` STRING COMMENT 'Standardized short code or identifier for the regulation (e.g., "GDPR", "PCI_DSS").',
    `regulation_description` STRING COMMENT 'Full textual description of the regulations purpose and requirements.',
    `regulation_name` STRING COMMENT 'Human‑readable title of the regulation (e.g., "General Data Protection Regulation").',
    `regulation_status` STRING COMMENT 'Current lifecycle state of the regulation record.. Valid values are `active|inactive|pending|retired`',
    `regulation_type` STRING COMMENT 'More specific type within the category (e.g., "Consent Management" under Data Privacy).',
    `regulatory_body` STRING COMMENT 'Governing authority that issues or enforces the regulation (e.g., "European Commission", "PCI SSC").',
    `scope` STRING COMMENT 'Geographic scope of applicability.. Valid values are `global|regional|country_specific`',
    `source_url` STRING COMMENT 'Link to the official regulation document or web page.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the regulation record.',
    `version_number` STRING COMMENT 'Version of the regulation record after amendments.',
    CONSTRAINT pk_regulation PRIMARY KEY(`regulation_id`)
) COMMENT 'Master registry of all applicable regulations, laws, and standards governing the e-commerce platform. Captures regulation name, jurisdiction (GDPR, CCPA, PCI DSS, COPPA, CAN-SPAM, consumer protection acts), regulatory body, effective date, expiry date, applicability scope (global, regional, country-specific), regulation category (data privacy, payment security, consumer protection, tax, trade), compliance obligation type (mandatory, voluntary), and current enforcement status. Serves as the authoritative SSOT for all regulatory obligations the platform must satisfy.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`compliance`.`obligation` (
    `obligation_id` BIGINT COMMENT 'System-generated unique identifier for the compliance obligation record.',
    `regulation_id` BIGINT COMMENT 'Identifier of the parent regulation or standard that creates this obligation.',
    `parent_obligation_id` BIGINT COMMENT 'Self-referencing FK on obligation (parent_obligation_id)',
    `audit_log_reference` STRING COMMENT 'Identifier linking to the audit log entry for this obligation.',
    `compliance_category` STRING COMMENT 'High‑level category of the obligation.. Valid values are `privacy|security|financial|operational`',
    `compliance_evidence_url` STRING COMMENT 'Link to stored evidence supporting compliance.',
    `compliance_status` STRING COMMENT 'Result of the latest compliance assessment.. Valid values are `compliant|non_compliant|partial|not_applicable`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the obligation record was first created in the system.',
    `due_date` DATE COMMENT 'Calendar date by which the obligation must be fulfilled.',
    `effective_from` DATE COMMENT 'Date when the obligation becomes effective.',
    `effective_until` DATE COMMENT 'Date when the obligation expires or is no longer applicable (null if indefinite).',
    `enforcement_penalty` STRING COMMENT 'Description of penalties or sanctions for non‑compliance.',
    `evidence_required` BOOLEAN COMMENT 'Indicates whether supporting evidence must be provided for this obligation.',
    `evidence_status` STRING COMMENT 'Current status of the required compliance evidence.. Valid values are `provided|pending|not_required`',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether the obligation is mandatory (true) or optional (false).',
    `last_review_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent compliance review.',
    `next_review_timestamp` TIMESTAMP COMMENT 'Planned timestamp for the next compliance review.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information.',
    `obligation_code` STRING COMMENT 'Human‑readable code that uniquely identifies the obligation within the organization.',
    `obligation_description` STRING COMMENT 'Full textual description of what the obligation requires.',
    `obligation_name` STRING COMMENT 'Descriptive name of the compliance obligation.',
    `obligation_status` STRING COMMENT 'Current lifecycle state of the obligation.. Valid values are `active|inactive|waived|deferred|completed`',
    `obligation_type` STRING COMMENT 'Category of the compliance requirement.. Valid values are `data_subject_right|breach_notification|consent_management|record_retention|security_control|audit_requirement`',
    `record_source_system` STRING COMMENT 'System of record where the obligation originated. [ENUM-REF-CANDIDATE: order_management|warehouse_management|product_information|customer_data_platform|payment_gateway|erp|transportation_management|marketing_automation|search_recommendation|seller_portal — 10 candidates stripped; promote to reference product]',
    `recurrence_pattern` STRING COMMENT 'How often the obligation repeats.. Valid values are `one_time|annual|quarterly|monthly|continuous`',
    `responsible_business_unit` STRING COMMENT 'Internal business unit accountable for satisfying the obligation.',
    `retention_period_days` STRING COMMENT 'Number of days required to retain records related to the obligation.',
    `risk_tier` STRING COMMENT 'Risk classification assigned to the obligation based on potential impact.. Valid values are `low|medium|high|critical`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the obligation record.',
    CONSTRAINT pk_obligation PRIMARY KEY(`obligation_id`)
) COMMENT 'Defines specific compliance obligations derived from regulations and standards applicable to the e-commerce platform. Captures obligation name, parent regulation reference, obligation type (data subject rights, breach notification, consent management, record retention, security control, audit requirement), responsible business unit, due date, recurrence pattern (one-time, annual, quarterly, continuous), obligation status (active, waived, deferred), and risk tier. Bridges the regulation registry to operational compliance activities.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`compliance`.`program` (
    `program_id` BIGINT COMMENT 'Unique system-generated identifier for the compliance program.',
    `parent_program_id` BIGINT COMMENT 'Self-referencing FK on program (parent_program_id)',
    `applicable_regulations` STRING COMMENT 'Comma‑separated list of regulations (e.g., GDPR, PCI DSS, CCPA) that the program addresses.',
    `audit_count` STRING COMMENT 'Total number of audits performed to date.',
    `audit_frequency` STRING COMMENT 'Planned interval between compliance audits.. Valid values are `annual|semiannual|quarterly|monthly`',
    `budget_amount` DECIMAL(18,2) COMMENT 'Total monetary budget allocated to the program.',
    `ccpa_compliant` BOOLEAN COMMENT 'Indicates whether the program meets CCPA requirements.',
    `certification_date` DATE COMMENT 'Date when the program achieved certification.',
    `certification_status` STRING COMMENT 'Current certification outcome for the program.. Valid values are `certified|pending|failed|revoked`',
    `compliance_issues_count` STRING COMMENT 'Number of open compliance issues identified.',
    `compliance_score` DECIMAL(18,2) COMMENT 'Quantitative score (0‑100) reflecting compliance health.',
    `compliance_status` STRING COMMENT 'Overall compliance posture of the program.. Valid values are `compliant|non_compliant|partial`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the program record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the budget.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `data_protection_level` STRING COMMENT 'Classification of data handled by the program.. Valid values are `restricted|confidential|internal|public`',
    `documentation_url` STRING COMMENT 'Link to the central repository of program documentation.',
    `effective_from` DATE COMMENT 'Date when the program becomes effective.',
    `effective_until` DATE COMMENT 'Date when the program ends or is retired (nullable for open‑ended programs).',
    `gdpr_compliant` BOOLEAN COMMENT 'Indicates whether the program meets GDPR obligations.',
    `jurisdiction` STRING COMMENT 'Geographic jurisdiction(s) the program applies to.. Valid values are `US|EU|CA|AU`',
    `last_audit_date` DATE COMMENT 'Date of the most recent audit execution.',
    `lifecycle_status` STRING COMMENT 'Lifecycle phase of the compliance program.. Valid values are `planning|active|remediation|certified|retired`',
    `next_audit_date` DATE COMMENT 'Planned date for the upcoming audit.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the program.',
    `owner` STRING COMMENT 'Full legal name of the person responsible for the program.',
    `pci_dss_compliant` BOOLEAN COMMENT 'Indicates whether the program meets PCI DSS requirements.',
    `privacy_impact_assessment_completed` BOOLEAN COMMENT 'True when a Privacy Impact Assessment has been performed and approved.',
    `program_category` STRING COMMENT 'Secondary categorization (e.g., data protection, financial, consumer rights).',
    `program_description` STRING COMMENT 'Detailed narrative describing the program objectives and scope.',
    `program_name` STRING COMMENT 'Human‑readable name of the compliance program.',
    `program_scope` STRING COMMENT 'Brief description of the functional and geographic scope covered by the program.',
    `program_status` STRING COMMENT 'Current operational status of the program.. Valid values are `active|inactive|planned|retired`',
    `program_type` STRING COMMENT 'High‑level classification of the program purpose.. Valid values are `regulatory|security|privacy|operational`',
    `regulatory_body` STRING COMMENT 'Primary regulatory authority overseeing the program. [ENUM-REF-CANDIDATE: FTC|PCI_SSC|ISO|GDPR|CCPA|CPSC|WTO|NIST|SOX — promote to reference product]',
    `remediation_deadline` DATE COMMENT 'Target date for resolving all open compliance issues.',
    `risk_level` STRING COMMENT 'Categorical risk tier based on the risk score.. Valid values are `low|medium|high`',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk rating (0‑100) derived from risk assessments.',
    `sponsoring_executive` STRING COMMENT 'Name of the senior executive sponsoring the program.',
    `stakeholder_count` STRING COMMENT 'Number of distinct internal or external stakeholders involved.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the program record.',
    `version_number` STRING COMMENT 'Incremental version for optimistic concurrency control.',
    CONSTRAINT pk_program PRIMARY KEY(`program_id`)
) COMMENT 'Master record defining named compliance programs managed by the compliance function, such as GDPR Compliance Program, PCI DSS Certification Program, CCPA Readiness Program, or Consumer Protection Program. Captures program name, program owner, sponsoring executive, program scope, applicable regulations, program lifecycle status (planning, active, remediation, certified, retired), program start and end dates, budget allocation, and overall risk posture. Provides the organizational container for grouping related obligations, audits, and certifications.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`compliance`.`audit` (
    `audit_id` BIGINT COMMENT 'Unique system-generated identifier for the audit record.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Audit belongs to a compliance program; replace string with proper FK',
    `regulation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulation. Business justification: Audit references the regulation it audits; replace free‑text reference with a foreign key to regulation.',
    `seller_profile_id` BIGINT COMMENT 'Foreign key linking to seller.seller_profile. Business justification: Audit records are scoped to a specific seller; compliance audits require linking each audit to the seller being examined.',
    `follow_up_audit_id` BIGINT COMMENT 'Self-referencing FK on audit (follow_up_audit_id)',
    `approval_status` STRING COMMENT 'Governance decision on audit acceptance.. Valid values are `approved|rejected|pending`',
    `approval_timestamp` TIMESTAMP COMMENT 'Exact time when the audit was approved.',
    `approved_by` STRING COMMENT 'Name of the individual who approved the audit.',
    `audit_category` STRING COMMENT 'High‑level classification of the audit focus area.. Valid values are `financial|security|operational|privacy|compliance`',
    `audit_name` STRING COMMENT 'Descriptive name of the audit (e.g., "Q2 2024 PCI DSS Audit").',
    `audit_number` STRING COMMENT 'External reference number or code assigned to the audit by the organization.',
    `audit_status` STRING COMMENT 'Current lifecycle state of the audit.. Valid values are `scheduled|in_progress|findings_issued|remediation|closed`',
    `audit_type` STRING COMMENT 'Category of audit indicating its origin and purpose.. Valid values are `internal|external|regulatory|soc2|pci_qsa|iso27001`',
    `auditing_entity` STRING COMMENT 'Name of the internal team or external firm conducting the audit.',
    `ccpa_compliance_flag` BOOLEAN COMMENT 'Indicates compliance with California Consumer Privacy Act.',
    `certification_expiry` DATE COMMENT 'Date when the certification granted by the audit expires.',
    `certification_status` STRING COMMENT 'Current certification state resulting from the audit.. Valid values are `certified|pending|revoked`',
    `cost` DECIMAL(18,2) COMMENT 'Total monetary cost incurred for conducting the audit.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit record was first created in the system.',
    `currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for audit_cost.',
    `data_protection_impact` STRING COMMENT 'Assessed impact on data protection controls.. Valid values are `low|medium|high`',
    `document_url` STRING COMMENT 'Link to the stored audit report or supporting documentation.',
    `evidence_count` BIGINT COMMENT 'Number of evidence items collected during the audit.',
    `findings_summary` STRING COMMENT 'High‑level summary of audit findings and observations.',
    `frequency` STRING COMMENT 'Planned recurrence interval for this type of audit.. Valid values are `annual|biennial|quarterly|ad_hoc`',
    `gdpr_compliance_flag` BOOLEAN COMMENT 'Indicates compliance with GDPR obligations.',
    `issues_count` BIGINT COMMENT 'Total count of distinct audit issues identified.',
    `lead_auditor` STRING COMMENT 'Primary individual responsible for leading the audit.',
    `location` STRING COMMENT 'Physical or logical location where the audit was performed.',
    `methodology` STRING COMMENT 'Methodological approach used for the audit.. Valid values are `standard|custom|risk_based`',
    `next_audit_due` DATE COMMENT 'Scheduled date for the subsequent audit cycle.',
    `notes` STRING COMMENT 'Free‑form notes captured by auditors.',
    `overall_opinion` STRING COMMENT 'Final judgment of the audit outcome.. Valid values are `pass|qualified|fail`',
    `owner` STRING COMMENT 'Individual accountable for the audit execution.',
    `pci_compliance_flag` BOOLEAN COMMENT 'Indicates whether PCI DSS requirements were satisfied.',
    `period_end` DATE COMMENT 'Date when the audit period ends.',
    `period_start` DATE COMMENT 'Date when the audit period begins.',
    `privacy_impact` STRING COMMENT 'Assessed impact on personal data privacy.. Valid values are `low|medium|high`',
    `remediation_plan` STRING COMMENT 'Planned actions to address identified findings.',
    `review_date` DATE COMMENT 'Date when the audit results were reviewed by governance.',
    `risk_rating` STRING COMMENT 'Risk level assigned to the audit based on findings.. Valid values are `low|medium|high|critical`',
    `scope` STRING COMMENT 'Defined boundaries and focus areas of the audit (e.g., payment processing, data privacy).',
    `sox_compliance_flag` BOOLEAN COMMENT 'Indicates compliance with Sarbanes‑Oxley Act requirements.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the audit record.',
    `version` STRING COMMENT 'Version identifier for the audit record (e.g., v1.0, v2.1).',
    CONSTRAINT pk_audit PRIMARY KEY(`audit_id`)
) COMMENT 'Master record for each compliance audit conducted against the e-commerce platform, including internal audits, external third-party audits, and regulatory examinations. Captures audit name, audit type (internal, external, regulatory, SOC 2, PCI QSA, ISO 27001), audit scope, auditing entity or firm, lead auditor, audit period start and end dates, audit status (scheduled, in-progress, findings-issued, remediation, closed), overall audit opinion (pass, qualified, fail), and associated compliance program. Serves as the SSOT for all audit lifecycle management.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`compliance`.`audit_schedule` (
    `audit_schedule_id` BIGINT COMMENT 'System-generated unique identifier for each audit schedule record.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.audit. Business justification: Schedule must reference the audit it belongs to; creates parent-child relationship',
    `rescheduled_from_audit_schedule_id` BIGINT COMMENT 'Self-referencing FK on audit_schedule (rescheduled_from_audit_schedule_id)',
    `assigned_auditor` STRING COMMENT 'Name of the internal auditor or external audit firm responsible for the audit.',
    `assigned_auditor_contact` STRING COMMENT 'Email address for contacting the assigned auditor or audit firm.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `audit_category` STRING COMMENT 'Indicates whether the audit is performed by internal staff or an external firm.. Valid values are `internal|external`',
    `audit_fiscal_year` STRING COMMENT 'Fiscal year to which the audit is attributed.',
    `audit_location` STRING COMMENT 'Physical or logical location where the audit activities will be conducted.',
    `audit_priority` STRING COMMENT 'Business priority assigned to the audit (high, medium, low).. Valid values are `high|medium|low`',
    `audit_schedule_status` STRING COMMENT 'Current lifecycle status of the audit schedule.. Valid values are `planned|confirmed|rescheduled|cancelled`',
    `audit_scope` STRING COMMENT 'Narrative describing the functional, geographic, or process scope of the audit.',
    `audit_type` STRING COMMENT 'Classification of the audit (e.g., compliance, security, financial, operational).',
    `business_unit` STRING COMMENT 'Organizational unit or department that is subject to the audit.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit schedule record was first created in the system.',
    `documentation_link` STRING COMMENT 'URL or path to the audit plan, checklist, or related documentation.',
    `estimated_effort_hours` STRING COMMENT 'Projected number of person‑hours required to complete the audit.',
    `notes` STRING COMMENT 'Free‑form comments or observations related to the audit schedule.',
    `planned_end_date` DATE COMMENT 'Date the audit is planned to conclude.',
    `planned_start_date` DATE COMMENT 'Date the audit is planned to commence.',
    `recurrence_pattern` STRING COMMENT 'Frequency with which the audit repeats.. Valid values are `annual|semi-annual|quarterly|monthly|none`',
    `regulation_code` STRING COMMENT 'Identifier of the regulation, standard, or policy driving the audit (e.g., "PCI_DSS", "GDPR").',
    `risk_level` STRING COMMENT 'Risk rating associated with the audit based on impact and likelihood.. Valid values are `high|medium|low`',
    `status_reason` STRING COMMENT 'Explanation for the current status (e.g., reason for cancellation or delay).',
    `target_period_end` DATE COMMENT 'End date of the audit coverage period.',
    `target_period_start` DATE COMMENT 'Start date of the audit coverage period (e.g., fiscal quarter being audited).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the audit schedule record.',
    CONSTRAINT pk_audit_schedule PRIMARY KEY(`audit_schedule_id`)
) COMMENT 'Operational scheduling record defining the planned audit calendar for the compliance domain. Captures scheduled audit name, audit type, target audit period, planned start date, planned end date, assigned auditor or audit firm, business unit in scope, associated regulation or standard, scheduling status (planned, confirmed, rescheduled, cancelled), and recurrence pattern (annual, semi-annual, quarterly). Enables proactive audit planning and resource allocation across the compliance calendar.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`compliance`.`audit_finding` (
    `audit_finding_id` BIGINT COMMENT 'Unique system-generated identifier for each audit finding.',
    `audit_id` BIGINT COMMENT 'Reference to the overall audit session or campaign this finding belongs to.',
    `related_audit_finding_id` BIGINT COMMENT 'Self-referencing FK on audit_finding (related_audit_finding_id)',
    `actual_closure_date` DATE COMMENT 'Date the finding was officially closed or accepted as risk.',
    `affected_control` STRING COMMENT 'Reference to the internal control or process impacted by the finding.',
    `audit_finding_description` STRING COMMENT 'Detailed narrative describing the observation, deficiency, or recommendation.',
    `audit_finding_status` STRING COMMENT 'Current lifecycle state of the finding.. Valid values are `open|in_remediation|remediated|accepted_risk|closed`',
    `compliance_framework` STRING COMMENT 'Regulatory or standards framework to which the finding relates.. Valid values are `PCI_DSS|GDPR|CCPA|SOX|FTC|ISO_27001`',
    `evidence_url` STRING COMMENT 'Link to supporting documentation or artifacts stored in the evidence repository.',
    `finding_code` STRING COMMENT 'Human‑readable business identifier for the finding, used in reports and communications.. Valid values are `^FND-d{6}$`',
    `finding_created_timestamp` TIMESTAMP COMMENT 'Exact moment the finding was recorded in the audit system.',
    `finding_type` STRING COMMENT 'Category of the finding indicating its nature and impact.. Valid values are `critical_deficiency|major_non_conformance|minor_observation|best_practice_recommendation`',
    `jurisdiction` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code indicating the legal jurisdiction affected.. Valid values are `[A-Z]{3}`',
    `priority` STRING COMMENT 'Business‑defined priority level for remediation effort.. Valid values are `p1|p2|p3|p4`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the audit finding record was first created in the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the audit finding record.',
    `remediation_owner` STRING COMMENT 'Team or individual accountable for executing the remediation.',
    `remediation_recommendation` STRING COMMENT 'Suggested actions to correct or mitigate the finding.',
    `risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk score derived from severity and impact factors.',
    `root_cause_analysis` STRING COMMENT 'Explanation of the underlying cause that led to the finding.',
    `severity_rating` STRING COMMENT 'Severity assigned to the finding based on potential impact.. Valid values are `critical|high|medium|low`',
    `target_remediation_date` DATE COMMENT 'Planned date by which remediation should be completed.',
    `title` STRING COMMENT 'Concise title summarizing the audit finding.',
    CONSTRAINT pk_audit_finding PRIMARY KEY(`audit_finding_id`)
) COMMENT 'Transactional record capturing each finding, observation, or deficiency identified during a compliance audit. Captures finding title, finding description, finding type (critical deficiency, major non-conformance, minor observation, best-practice recommendation), severity rating (critical, high, medium, low), affected control or process, root cause analysis, remediation recommendation, finding status (open, in-remediation, remediated, accepted-risk, closed), target remediation date, and actual closure date. Core operational record for audit finding lifecycle management.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`compliance`.`remediation_plan` (
    `remediation_plan_id` BIGINT COMMENT 'Unique identifier for the remediation plan record.',
    `audit_finding_id` BIGINT COMMENT 'Identifier of the audit finding or compliance gap that this plan addresses.',
    `risk_assessment_id` BIGINT COMMENT 'Identifier of the risk assessment record associated with the remediation plan.',
    `escalated_from_remediation_plan_id` BIGINT COMMENT 'Self-referencing FK on remediation_plan (escalated_from_remediation_plan_id)',
    `actual_completion_date` DATE COMMENT 'Date when the remediation plan was actually completed.',
    `approach_description` STRING COMMENT 'Narrative of the remediation approach, steps, and methodology.',
    `audit_evidence_reference` STRING COMMENT 'Identifier of the audit evidence record linked to this remediation plan.',
    `compliance_category` STRING COMMENT 'Regulatory domain the plan belongs to (e.g., PCI_DSS, GDPR, CCPA).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the remediation plan record was first created.',
    `effective_from` DATE COMMENT 'Date when the remediation plan becomes active.',
    `effective_until` DATE COMMENT 'Date when the remediation plan expires or is retired (nullable for open‑ended plans).',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the remediation plan has been escalated to higher management.',
    `evidence_url` STRING COMMENT 'Link to stored evidence (documents, screenshots, logs) proving remediation completion.',
    `last_review_date` DATE COMMENT 'Date when the remediation plan was last reviewed for relevance or updates.',
    `milestone_checkpoints` STRING COMMENT 'JSON string capturing milestone names, target dates, and completion flags.',
    `notes` STRING COMMENT 'Free‑form field for any extra comments or observations.',
    `plan_code` STRING COMMENT 'Business identifier or code for the remediation plan, used in external reporting and tracking.',
    `plan_description` STRING COMMENT 'Detailed description of the remediation plan objectives and scope.',
    `plan_name` STRING COMMENT 'Human‑readable name of the remediation plan.',
    `plan_type` STRING COMMENT 'Classification of the remediation plan by its nature (e.g., policy change, technical fix, process improvement, training).. Valid values are `policy|technical|process|training`',
    `planned_completion_date` DATE COMMENT 'Target date for completing all remediation activities.',
    `priority` STRING COMMENT 'Business priority assigned to the remediation plan.. Valid values are `high|medium|low`',
    `regulatory_requirement` STRING COMMENT 'Specific regulation or standard clause addressed (e.g., GDPR Art.5, PCI DSS 12.3).',
    `remediation_plan_status` STRING COMMENT 'Current lifecycle status of the remediation plan.. Valid values are `draft|approved|in_progress|completed|overdue|cancelled`',
    `review_status` STRING COMMENT 'Current status of the most recent plan review.. Valid values are `pending|completed`',
    `severity` STRING COMMENT 'Severity level of the compliance gap addressed by the plan.. Valid values are `critical|high|medium|low`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the remediation plan record.',
    CONSTRAINT pk_remediation_plan PRIMARY KEY(`remediation_plan_id`)
) COMMENT 'Operational record tracking the remediation plan and action items associated with audit findings, compliance gaps, or risk assessments. Captures plan name, linked finding or risk, remediation owner, remediation approach description, planned completion date, actual completion date, remediation status (draft, approved, in-progress, completed, overdue, cancelled), milestone checkpoints, escalation flag, and evidence of completion. Enables structured tracking of compliance gap closure across the organization.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`compliance`.`certification` (
    `certification_id` BIGINT COMMENT 'Unique surrogate key for each certification record.',
    `program_id` BIGINT COMMENT 'Reference to the compliance program that this certification supports.',
    `renewed_from_certification_id` BIGINT COMMENT 'Self-referencing FK on certification (renewed_from_certification_id)',
    `audit_evidence_url` STRING COMMENT 'Link to stored audit evidence or certification documents.',
    `audit_frequency` STRING COMMENT 'Planned frequency of audits required to maintain the certification.. Valid values are `annual|biennial|quarterly`',
    `audit_scope` STRING COMMENT 'Scope of the audit (e.g., full, partial, specific control set).',
    `certification_code` STRING COMMENT 'Unique identifier or certificate number assigned by the certifying body.',
    `certification_name` STRING COMMENT 'Human‑readable name of the certification (e.g., PCI DSS Level 1).',
    `certification_status` STRING COMMENT 'Current lifecycle status of the certification.. Valid values are `active|expired|suspended|revoked|in_renewal`',
    `certifying_body` STRING COMMENT 'Organization that issued the certification (e.g., PCI SSC, ISO).',
    `cost_amount` DECIMAL(18,2) COMMENT 'Monetary cost incurred to obtain or maintain the certification.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the certification record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the cost amount.',
    `effective_from` DATE COMMENT 'Date the certification becomes effective for the organization.',
    `effective_until` DATE COMMENT 'Date the certification ceases to be effective (may differ from expiry).',
    `expiry_date` DATE COMMENT 'Date the certification expires if not renewed.',
    `issue_date` DATE COMMENT 'Date the certification was officially issued.',
    `last_audit_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent audit associated with this certification.',
    `renewal_date` DATE COMMENT 'Planned date for certification renewal activities.',
    `renewal_status` STRING COMMENT 'Current status of the renewal process.. Valid values are `pending|completed|failed`',
    `risk_level` STRING COMMENT 'Risk rating associated with the certifications scope.. Valid values are `low|medium|high`',
    `scope_description` STRING COMMENT 'Textual description of the business processes, systems, or locations covered by the certification.',
    `standard` STRING COMMENT 'Standard or framework under which the certification is granted.. Valid values are `pci_dss|iso_27001|soc_2|gdpr|cisa|hipaa`',
    `standard_version` STRING COMMENT 'Version of the certification standard (e.g., ISO 27001:2022).',
    `status_reason` STRING COMMENT 'Explanation for the current status (e.g., reason for suspension).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the certification record.',
    CONSTRAINT pk_certification PRIMARY KEY(`certification_id`)
) COMMENT 'Master record for compliance certifications and attestations obtained by the e-commerce platform, including PCI DSS Level 1 certification, ISO 27001, SOC 2 Type II, GDPR Article 42 certification, and similar. Captures certification name, certifying body, certification standard version, certification scope, issue date, expiry date, certification status (active, expired, suspended, revoked, in-renewal), certificate number, and associated compliance program. SSOT for the certification lifecycle and renewal management.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`compliance`.`evidence` (
    `evidence_id` BIGINT COMMENT 'Unique system-generated identifier for the compliance evidence record.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Evidence is tied to a specific compliance obligation; replace string with FK',
    `superseded_evidence_id` BIGINT COMMENT 'Self-referencing FK on evidence (superseded_evidence_id)',
    `audit_comments` STRING COMMENT 'Additional comments or notes recorded during audit reviews of the evidence.',
    `chain_of_custody` STRING COMMENT 'Notes documenting handling, transfers, and verification steps for the evidence.',
    `checksum` STRING COMMENT 'SHA‑256 hash of the evidence file for integrity verification.. Valid values are `^[A-Fa-f0-9]{64}$`',
    `collected_by` STRING COMMENT 'Name of the person or system that performed the evidence collection.',
    `collection_timestamp` TIMESTAMP COMMENT 'Date and time when the evidence was originally collected.',
    `collector_role` STRING COMMENT 'Role or function of the collector (e.g., auditor, system, compliance officer).',
    `compliance_framework` STRING COMMENT 'Regulatory or standards framework to which the evidence relates.. Valid values are `GDPR|CCPA|PCI_DSS|SOX|FTC|ISO_27001`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this evidence record was first created in the system.',
    `evidence_code` STRING COMMENT 'Human‑readable code or number assigned to the evidence artifact for tracking.',
    `evidence_description` STRING COMMENT 'Free‑text description providing context or details about the evidence.',
    `evidence_status` STRING COMMENT 'Current processing status of the evidence.. Valid values are `collected|reviewed|accepted|rejected`',
    `evidence_type` STRING COMMENT 'Category of the evidence artifact. [ENUM-REF-CANDIDATE: training_record — promote to reference product]. Valid values are `policy_document|screenshot|log_extract|test_result|attestation|contract_clause`',
    `file_size_bytes` BIGINT COMMENT 'Size of the evidence file in bytes.',
    `format` STRING COMMENT 'File format of the stored evidence artifact.. Valid values are `pdf|docx|png|jpg|txt|json`',
    `is_confidential` BOOLEAN COMMENT 'Indicates whether the evidence contains confidential or restricted information.',
    `jurisdiction` STRING COMMENT 'Three‑letter ISO country code of the jurisdiction governing the evidence.. Valid values are `^[A-Z]{3}$`',
    `retention_expiry_date` DATE COMMENT 'Date after which the evidence must be archived or destroyed per policy.',
    `storage_location` STRING COMMENT 'Path, URL, or repository identifier where the evidence artifact is stored.',
    `title` STRING COMMENT 'Descriptive title of the evidence artifact.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the evidence record.',
    CONSTRAINT pk_evidence PRIMARY KEY(`evidence_id`)
) COMMENT 'Transactional record capturing compliance evidence artifacts collected to demonstrate adherence to regulations, audit requirements, or certification standards. Captures evidence title, evidence type (policy document, screenshot, log extract, test result, attestation, contract clause, training record), collection date, collected by, associated obligation or audit finding, evidence status (collected, reviewed, accepted, rejected), storage location reference, retention expiry date, and chain-of-custody notes. Core operational record for evidence management in audit and certification workflows.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`compliance`.`privacy_notice` (
    `privacy_notice_id` BIGINT COMMENT 'System-generated unique identifier for the privacy notice record.',
    `regulation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulation. Business justification: Privacy notice is issued to satisfy a regulation; link to regulation',
    `superseded_privacy_notice_id` BIGINT COMMENT 'Self-referencing FK on privacy_notice (superseded_privacy_notice_id)',
    `approval_status` STRING COMMENT 'Current approval state of the notice within the legal review workflow.. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the notice was approved.',
    `character_count` STRING COMMENT 'Number of characters in the notice text.',
    `compliance_ccpa` BOOLEAN COMMENT 'True if the notice satisfies California Consumer Privacy Act requirements.',
    `compliance_eprivacy` BOOLEAN COMMENT 'True if the notice satisfies the EU ePrivacy Directive.',
    `compliance_gdpr` BOOLEAN COMMENT 'True if the notice satisfies GDPR requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the notice record was first created in the system.',
    `data_retention_period_days` STRING COMMENT 'Number of days the notice must be retained for audit purposes after expiration.',
    `document_format` STRING COMMENT 'File format of the stored notice.. Valid values are `html|pdf|text`',
    `effective_from` DATE COMMENT 'Date on which the notice becomes legally effective.',
    `effective_until` DATE COMMENT 'Date on which the notice expires or is superseded (nullable for open‑ended notices).',
    `is_internal_use_only` BOOLEAN COMMENT 'True if the notice is intended for internal staff only and not published publicly.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether the notice is required by law for the given jurisdiction.',
    `jurisdiction` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code representing the legal jurisdiction the notice applies to.',
    `language_locale` STRING COMMENT 'Locale identifier (e.g., "en_US", "fr_FR") indicating language and regional formatting.. Valid values are `^[a-z]{2}_[A-Z]{2}$`',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Timestamp of the last compliance review of the notice.',
    `legal_owner` STRING COMMENT 'Internal department or team responsible for the notice.',
    `notice_code` STRING COMMENT 'Business identifier or code used to reference the notice in internal systems.',
    `notice_text` STRING COMMENT 'Complete textual content of the privacy notice.',
    `notice_type` STRING COMMENT 'Category of the notice indicating its legal purpose.. Valid values are `privacy_policy|cookie_notice|terms_of_service|data_processing_summary`',
    `privacy_notice_status` STRING COMMENT 'Current lifecycle status of the notice.. Valid values are `draft|published|archived|retired`',
    `publication_channel` STRING COMMENT 'Channel where the notice is presented to users.. Valid values are `website|mobile_app|checkout_flow|email`',
    `review_cycle_days` STRING COMMENT 'Planned number of days between mandatory reviews of the notice.',
    `source_system` STRING COMMENT 'Originating system that authored or uploaded the notice (e.g., CMS, Legal Portal).',
    `summary_text` STRING COMMENT 'Short summary or excerpt of the notice for quick reference.',
    `title` STRING COMMENT 'Human‑readable title of the privacy notice (e.g., "Privacy Policy").',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the notice record.',
    `version_number` STRING COMMENT 'Semantic version of the notice (e.g., "1.0" or "2.1.3").. Valid values are `^d+.d+(.d+)?$`',
    `word_count` STRING COMMENT 'Number of words in the notice text.',
    CONSTRAINT pk_privacy_notice PRIMARY KEY(`privacy_notice_id`)
) COMMENT 'Master record for all privacy notices, cookie policies, and data processing disclosures published by the e-commerce platform. Captures notice name, notice type (privacy policy, cookie notice, terms of service, data processing agreement summary), applicable jurisdiction, version number, effective date, expiry or superseded date, publication channel (website, mobile app, checkout flow), language/locale, notice status (draft, published, archived), and the full notice text body. Enables version-controlled management of all customer-facing privacy disclosures required under GDPR, CCPA, and ePrivacy regulations.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`compliance`.`legal_hold` (
    `legal_hold_id` BIGINT COMMENT 'Unique system-generated identifier for the legal hold record.',
    `superseded_legal_hold_id` BIGINT COMMENT 'Self-referencing FK on legal_hold (superseded_legal_hold_id)',
    `actual_release_date` DATE COMMENT 'Date when the hold was officially released; null if still active.',
    `anticipated_end_date` DATE COMMENT 'Planned date for hold termination, if known.',
    `audit_evidence_required` BOOLEAN COMMENT 'Indicates whether supporting audit evidence must be collected for this hold.',
    `compliance_deadline` DATE COMMENT 'Date by which compliance actions related to the hold must be completed.',
    `compliance_status` STRING COMMENT 'Current compliance state of the hold.. Valid values are `compliant|non_compliant|pending`',
    `consumer_protection_requirements` STRING COMMENT 'Requirements from consumer‑protection regulations (e.g., FTC) relevant to the hold.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the legal hold record was first created in the system.',
    `custodians_notified` STRING COMMENT 'Comma‑separated list of individuals or teams notified about the hold.',
    `data_categories` STRING COMMENT 'Comma‑separated list of data categories (e.g., PII, financial, transaction logs) that are subject to the hold.',
    `data_protection_level` STRING COMMENT 'Classifies the sensitivity of the data under hold.. Valid values are `high|medium|low`',
    `hold_category` STRING COMMENT 'Higher‑level classification (e.g., litigation, regulatory, internal).',
    `hold_name` STRING COMMENT 'Descriptive name given to the legal hold for easy identification.',
    `hold_reason` STRING COMMENT 'Business or legal rationale for initiating the hold.',
    `hold_scope_description` STRING COMMENT 'Narrative describing the scope of data, documents, and systems covered by the hold.',
    `hold_start_date` DATE COMMENT 'Date when the legal hold becomes effective.',
    `hold_status` STRING COMMENT 'Current lifecycle status of the hold.. Valid values are `active|released|extended|disputed|pending`',
    `hold_type` STRING COMMENT 'Category of the hold: litigation, regulatory investigation, or internal investigation.. Valid values are `litigation|regulatory|internal`',
    `hold_version` STRING COMMENT 'Version number of the hold record to track amendments.',
    `issuing_authority` STRING COMMENT 'Legal team, department, or external authority that issued the hold.',
    `jurisdiction` STRING COMMENT 'Geographic or legal jurisdiction governing the hold (e.g., US, EU).',
    `last_audit_date` DATE COMMENT 'Date of the most recent audit performed for this hold.',
    `legal_matter_reference` STRING COMMENT 'External reference or case number linking the hold to a specific legal matter.',
    `notes` STRING COMMENT 'Free‑form notes or comments added by legal or compliance teams.',
    `payment_security_requirements` STRING COMMENT 'PCI DSS or other payment‑security obligations tied to the hold.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Potential monetary penalty associated with non‑compliance of the hold.',
    `privacy_requirements` STRING COMMENT 'Specific privacy obligations (e.g., GDPR, CCPA) applicable to the hold.',
    `regulatory_body` STRING COMMENT 'Regulatory authority whose requirements drive the hold (e.g., FTC, GDPR, PCI SSC).',
    `retention_period_days` STRING COMMENT 'Number of days data must be retained under the hold.',
    `systems_in_scope` STRING COMMENT 'Comma‑separated list of operational systems (e.g., OMS, WMS, PIM) whose data are covered.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the legal hold record.',
    CONSTRAINT pk_legal_hold PRIMARY KEY(`legal_hold_id`)
) COMMENT 'Master record managing legal hold orders placed on data and documents to preserve evidence for litigation, regulatory investigation, or e-discovery. Captures hold name, hold type (litigation hold, regulatory investigation, internal investigation), issuing authority or legal team, hold scope description, data categories and systems in scope, hold start date, anticipated hold end date, actual release date, hold status (active, released, extended, disputed), custodians notified, and associated legal matter reference. SSOT for legal hold lifecycle management ensuring data preservation obligations are met.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`compliance`.`legal_hold_custodian` (
    `legal_hold_custodian_id` BIGINT COMMENT 'System-generated unique identifier for the legal hold custodian record.',
    `legal_hold_id` BIGINT COMMENT 'Identifier of the legal hold event to which this custodian is linked.',
    `replaced_legal_hold_custodian_id` BIGINT COMMENT 'Self-referencing FK on legal_hold_custodian (replaced_legal_hold_custodian_id)',
    `acknowledgment_date` DATE COMMENT 'Date the custodian acknowledged the legal hold.',
    `acknowledgment_status` STRING COMMENT 'Current acknowledgment status of the custodian regarding the legal hold.. Valid values are `acknowledged|pending|declined`',
    `custodian_identifier` STRING COMMENT 'Internal identifier for the custodian such as employee ID, vendor ID, or system owner code.',
    `custodian_name` STRING COMMENT 'Legal name of the custodian (person or organization) subject to the legal hold.',
    `custodian_role` STRING COMMENT 'Business role or function of the custodian within the organization or vendor relationship.',
    `custodian_type` STRING COMMENT 'Classification of the custodian: internal employee, external vendor, or system owner.. Valid values are `internal_employee|external_vendor|system_owner`',
    `data_sources_in_scope` STRING COMMENT 'Comma-separated list of data source systems (e.g., OMS, WMS, CDP) covered by this custodians legal hold.',
    `email_address` STRING COMMENT 'Email address used to notify the custodian of the legal hold.',
    `hold_end_date` DATE COMMENT 'Date when the legal hold was released or expired for the custodian (nullable if still active).',
    `hold_instructions` STRING COMMENT 'Specific instructions or actions the custodian must follow to preserve data.',
    `hold_start_date` DATE COMMENT 'Date when the legal hold became effective for the custodian.',
    `hold_status` STRING COMMENT 'Lifecycle status of the legal hold for this custodian.. Valid values are `active|released|expired`',
    `notification_date` DATE COMMENT 'Date the custodian was first notified of the legal hold.',
    `phone_number` STRING COMMENT 'Phone number used to notify the custodian of the legal hold.',
    `primary_contact_method` STRING COMMENT 'Preferred method for legal hold notifications (e.g., email, phone, SMS).. Valid values are `email|phone|sms`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the legal hold custodian record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the legal hold custodian record.',
    CONSTRAINT pk_legal_hold_custodian PRIMARY KEY(`legal_hold_custodian_id`)
) COMMENT 'Association record linking individual data custodians (employees, system owners, third-party processors) to active legal holds. Captures custodian name, custodian role, custodian type (internal employee, external vendor, system owner), notification date, acknowledgment status and date, data sources in custodian scope, custodian hold status (active, released), and any custodian-specific hold instructions. Enables granular tracking of legal hold notification and acknowledgment obligations across all relevant data custodians.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`compliance`.`risk_assessment` (
    `risk_assessment_id` BIGINT COMMENT 'Unique system-generated identifier for each risk assessment record.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Supplier risk assessment informs procurement sourcing decisions and supplier selection.',
    `previous_risk_assessment_id` BIGINT COMMENT 'Self-referencing FK on risk_assessment (previous_risk_assessment_id)',
    `assessment_date` DATE COMMENT 'Date on which the risk assessment was performed.',
    `assessment_name` STRING COMMENT 'Descriptive name given to the risk assessment.',
    `assessment_outcome` STRING COMMENT 'Result of the assessment indicating whether risk is acceptable, accepted, or requires remediation.. Valid values are `Acceptable|Accepted|Remediation_Required`',
    `assessment_scope` STRING COMMENT 'Scope of the assessment, describing the systems, processes, or business units covered.',
    `assessment_type` STRING COMMENT 'Category of the assessment, such as Data Protection Impact Assessment (DPIA) or PCI DSS risk assessment.. Valid values are `DPIA|PCI_Risk|Vendor_Risk|General_Compliance`',
    `assessment_version` STRING COMMENT 'Version identifier for the risk assessment record, supporting change tracking.',
    `audit_evidence_required` BOOLEAN COMMENT 'Indicates whether audit evidence is mandatory for this assessment.',
    `compliance_framework` STRING COMMENT 'Regulatory or standards framework under which the assessment was conducted.. Valid values are `GDPR|PCI_DSS|CCPA|SOX|ISO27001`',
    `control_gaps` STRING COMMENT 'Description of gaps in controls identified during the assessment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the risk assessment record was first created in the system.',
    `evidence_documentation_url` STRING COMMENT 'Link to stored evidence supporting the assessment.',
    `evidence_status` STRING COMMENT 'Current status of evidence collection.. Valid values are `Collected|Pending|Not_Required`',
    `identified_risks` STRING COMMENT 'Free‑text list or JSON of risks identified during the assessment.',
    `impact_rating` STRING COMMENT 'Impact rating assigned to the identified risks.. Valid values are `Low|Medium|High|Critical`',
    `inherent_risk_score` STRING COMMENT 'Numeric score (0‑100) representing the risk before controls are applied.',
    `likelihood_rating` STRING COMMENT 'Likelihood rating assigned to the identified risks.. Valid values are `Low|Medium|High|Critical`',
    `mitigation_deadline` DATE COMMENT 'Target date by which mitigation actions should be completed.',
    `mitigation_plan` STRING COMMENT 'Planned actions to address identified control gaps.',
    `next_review_date` DATE COMMENT 'Planned date for the next risk reassessment.',
    `regulatory_body` STRING COMMENT 'Governing body or authority associated with the regulation (e.g., FTC, PCI SSC).',
    `residual_risk_score` STRING COMMENT 'Numeric score (0‑100) after existing controls are considered.',
    `reviewed_by_name` STRING COMMENT 'Name of the reviewer.',
    `risk_assessment_status` STRING COMMENT 'Current lifecycle status of the risk assessment.. Valid values are `Draft|In_Review|Approved|Rejected|Closed`',
    `risk_category` STRING COMMENT 'High‑level category of the risk (e.g., Data Protection, Payment Security).',
    `risk_description` STRING COMMENT 'Detailed description of the identified risk.',
    `risk_owner_name` STRING COMMENT 'Human‑readable name of the risk owner.',
    `risk_score_calculation_method` STRING COMMENT 'Description of the methodology used to calculate inherent and residual risk scores.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the risk assessment record.',
    CONSTRAINT pk_risk_assessment PRIMARY KEY(`risk_assessment_id`)
) COMMENT 'Transactional record capturing formal compliance and privacy risk assessments conducted across the e-commerce platform, including Data Protection Impact Assessments (DPIAs) required under GDPR Article 35, PCI DSS risk assessments, and general compliance risk reviews. Captures assessment name, assessment type (DPIA, PCI risk assessment, vendor risk assessment, general compliance review), assessment scope, assessment date, risk owner, identified risks with likelihood and impact ratings, inherent risk score, residual risk score after controls, control gaps identified, assessment outcome (acceptable risk, risk accepted, remediation required), and next review date.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`compliance`.`control` (
    `control_id` BIGINT COMMENT 'Unique system-generated identifier for the compliance control.',
    `regulation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulation. Business justification: Control applies to a specific regulation; replace free‑text attribute with a foreign key to regulation.',
    `parent_control_id` BIGINT COMMENT 'Self-referencing FK on control (parent_control_id)',
    `automation_flag` BOOLEAN COMMENT 'Indicates whether the control is automated (true) or manual (false).',
    `compliance_status` STRING COMMENT 'Current compliance status of the control against its applicable regulation.. Valid values are `compliant|non_compliant|partial|not_applicable`',
    `continuous_monitoring` BOOLEAN COMMENT 'Indicates whether the control is continuously monitored by automated systems.',
    `control_category` STRING COMMENT 'Broad category indicating whether the control is technical, administrative, or physical.. Valid values are `technical|administrative|physical`',
    `control_code` STRING COMMENT 'Business‑unique alphanumeric code used to reference the control.',
    `control_description` STRING COMMENT 'Detailed narrative describing the purpose, scope, and mechanics of the control.',
    `control_name` STRING COMMENT 'Human‑readable name of the control as defined in the compliance framework.',
    `control_status` STRING COMMENT 'Current operational status of the control.. Valid values are `active|inactive|compensating|retired`',
    `control_type` STRING COMMENT 'Classification of the control by its purpose: preventive, detective, or corrective.. Valid values are `preventive|detective|corrective`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the control record was first created in the system.',
    `dependent_controls` STRING COMMENT 'Comma‑separated list of other control codes that this control depends on.',
    `documentation_reference` STRING COMMENT 'Reference identifier (e.g., policy number, SOP ID) to the formal documentation governing the control.',
    `effective_from` DATE COMMENT 'Date when the control became effective.',
    `effective_until` DATE COMMENT 'Date when the control is scheduled to be retired or become obsolete (nullable).',
    `evidence_retention_period_days` STRING COMMENT 'Number of days evidence for this control must be retained per regulatory requirement.',
    `evidence_url` STRING COMMENT 'Link to the stored evidence supporting the controls effectiveness.',
    `frequency` STRING COMMENT 'How often the control is performed or evaluated.. Valid values are `continuous|daily|weekly|monthly|annual`',
    `last_audit_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent audit activity related to this control.',
    `last_test_date` DATE COMMENT 'Date when the control was most recently tested.',
    `last_test_result` STRING COMMENT 'Outcome of the most recent control test.. Valid values are `pass|fail|partial|not_tested`',
    `next_test_due` DATE COMMENT 'Planned date for the next scheduled test of the control.',
    `notes` STRING COMMENT 'Free‑form field for additional remarks, observations, or exceptions.',
    `owner` STRING COMMENT 'Name or identifier of the business unit or individual responsible for the control.',
    `remediation_action` STRING COMMENT 'Planned corrective action if the control fails its test.',
    `reporting_requirement` STRING COMMENT 'Specific reporting obligation linked to the control (e.g., quarterly PCI DSS audit).',
    `risk_score` DECIMAL(18,2) COMMENT 'Numeric risk score (0‑100) reflecting the controls impact and likelihood.',
    `risk_tier` STRING COMMENT 'Risk level associated with the controls failure.. Valid values are `low|medium|high|critical`',
    `scope_description` STRING COMMENT 'Narrative describing the business processes, systems, or data covered by the control.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the control record.',
    `version` STRING COMMENT 'Version identifier for the control definition (e.g., v1.2).',
    CONSTRAINT pk_control PRIMARY KEY(`control_id`)
) COMMENT 'Master record defining the compliance controls framework implemented across the e-commerce platform to satisfy regulatory and certification requirements. Captures control ID, control name, control description, control type (preventive, detective, corrective), control category (technical, administrative, physical), applicable regulation or standard (GDPR, PCI DSS, CCPA, SOC 2), control owner, control frequency (continuous, daily, monthly, annual), automation flag, control status (active, inactive, compensating), and last test date. Serves as the SSOT for the internal controls inventory.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`compliance`.`control_test` (
    `control_test_id` BIGINT COMMENT 'Unique identifier for the control test record.',
    `control_id` BIGINT COMMENT 'Identifier of the control that is being tested.',
    `tester_id` BIGINT COMMENT 'Identifier of the individual who performed the test.',
    `retest_of_control_test_id` BIGINT COMMENT 'Self-referencing FK on control_test (retest_of_control_test_id)',
    `audit_evidence_required` BOOLEAN COMMENT 'Indicates whether supporting audit evidence is required for this test.',
    `audit_evidence_url` STRING COMMENT 'Link to the audit evidence file or repository.',
    `compliance_deadline` DATE COMMENT 'Date by which compliance remediation must be completed.',
    `compliance_framework` STRING COMMENT 'Regulatory or standards framework governing the control.. Valid values are `SOC2|PCI_DSS|GDPR|CCPA|SOX`',
    `compliance_status` STRING COMMENT 'Current compliance status of the control after testing.. Valid values are `compliant|non_compliant|pending|exempt`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the control test record was first created in the system.',
    `data_classification` STRING COMMENT 'Classification level of the test record for data governance.. Valid values are `restricted|confidential|internal|public`',
    `deficiencies` STRING COMMENT 'Text description of any deficiencies or gaps found during testing.',
    `evidence_url` STRING COMMENT 'Link to supporting evidence or documentation for the test.',
    `execution_timestamp` TIMESTAMP COMMENT 'Date and time when the test was executed.',
    `is_automated` BOOLEAN COMMENT 'Flag indicating whether the test was performed by automated monitoring.',
    `jurisdiction` STRING COMMENT 'Country code of the jurisdiction governing the control.. Valid values are `^[A-Z]{3}$`',
    `last_review_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent review of the test result.',
    `management_response` STRING COMMENT 'Response or remediation plan provided by management for identified deficiencies.',
    `next_review_timestamp` TIMESTAMP COMMENT 'Planned timestamp for the next scheduled review.',
    `notes` STRING COMMENT 'Additional free‑form notes captured by the tester.',
    `regulatory_body` STRING COMMENT 'Governing body responsible for the regulation (e.g., FTC, PCI SSC).',
    `result_score` DECIMAL(18,2) COMMENT 'Numeric score (0‑100) representing the degree of effectiveness.',
    `retention_period_days` STRING COMMENT 'Number of days the test record must be retained for compliance.',
    `retest_date` DATE COMMENT 'Planned date for a follow‑up test to verify remediation.',
    `risk_rating` STRING COMMENT 'Risk rating associated with the control test outcome.. Valid values are `low|medium|high|critical`',
    `sample_size` STRING COMMENT 'Number of items, transactions, or records sampled for the test.',
    `test_category` STRING COMMENT 'High‑level category of the control being tested.. Valid values are `security|privacy|financial|operational|regulatory`',
    `test_code` STRING COMMENT 'Business identifier code for the test, used for reference in audit logs and reports.',
    `test_duration_seconds` STRING COMMENT 'Total time taken to execute the test, measured in seconds.',
    `test_environment` STRING COMMENT 'Technical environment where the test was performed.. Valid values are `production|staging|development|test`',
    `test_methodology` STRING COMMENT 'Methodology or approach used to conduct the test.',
    `test_name` STRING COMMENT 'Descriptive name of the control test.',
    `test_result` STRING COMMENT 'Overall outcome of the test indicating control effectiveness.. Valid values are `effective|ineffective|partially_effective`',
    `test_scope` STRING COMMENT 'Scope or boundary of the test (e.g., process, system, transaction).',
    `test_status` STRING COMMENT 'Current lifecycle status of the test execution.. Valid values are `pending|in_progress|completed|failed`',
    `test_type` STRING COMMENT 'Type of test performed to evaluate control effectiveness.. Valid values are `design_effectiveness|operating_effectiveness|walkthrough|automated_monitoring`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the control test record.',
    CONSTRAINT pk_control_test PRIMARY KEY(`control_test_id`)
) COMMENT 'Transactional record capturing the results of compliance control testing and effectiveness evaluations. Captures test name, tested control reference, test type (design effectiveness, operating effectiveness, walkthrough, automated monitoring), test execution date, tester identity, test methodology, sample size, test result (effective, ineffective, partially effective), deficiencies identified, management response, and retest date. Provides the audit trail for control testing activities required by SOC 2, PCI DSS, and internal audit programs.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`compliance`.`vendor_compliance_assessment` (
    `vendor_compliance_assessment_id` BIGINT COMMENT 'Unique identifier for each vendor compliance assessment.',
    `data_processing_agreement_id` BIGINT COMMENT 'Identifier of the DPA linked to this assessment.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Vendor compliance assessments are part of a compliance program',
    `supplier_id` BIGINT COMMENT 'Identifier of the third‑party vendor being assessed.',
    `previous_vendor_compliance_assessment_id` BIGINT COMMENT 'Self-referencing FK on vendor_compliance_assessment (previous_vendor_compliance_assessment_id)',
    `assessment_conducted_by` STRING COMMENT 'Name of the individual or organization that performed the assessment.',
    `assessment_conducted_by_contact` STRING COMMENT 'Email address of the assessor for follow‑up.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `assessment_conducted_by_contact_phone` STRING COMMENT 'Phone number of the assessor.',
    `assessment_number` STRING COMMENT 'Business identifier or code assigned to the assessment.',
    `assessment_outcome` STRING COMMENT 'Result of the compliance assessment.. Valid values are `compliant|conditionally_compliant|non_compliant`',
    `assessment_timestamp` TIMESTAMP COMMENT 'Date and time when the assessment was performed.',
    `assessment_type` STRING COMMENT 'Method used to conduct the compliance assessment.. Valid values are `questionnaire|on_site_audit|certification_review`',
    `compliance_frameworks` STRING COMMENT 'Comma‑separated list of regulatory frameworks assessed for the vendor.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the assessment record was first created.',
    `critical_findings` STRING COMMENT 'Key compliance issues identified during the assessment.',
    `dpa_status` STRING COMMENT 'Current status of the Data Processing Agreement with the vendor.. Valid values are `signed|pending|not_required`',
    `evidence_documentation_url` STRING COMMENT 'Link to supporting evidence documents for the assessment.',
    `jurisdiction` STRING COMMENT 'Three‑letter ISO country code representing the vendors primary jurisdiction.. Valid values are `^[A-Z]{3}$`',
    `next_assessment_due_date` DATE COMMENT 'Planned date for the next compliance assessment of the vendor.',
    `notes` STRING COMMENT 'Additional comments or observations recorded by the assessor.',
    `regulatory_body` STRING COMMENT 'Governing authority associated with the compliance framework (e.g., GDPR, PCI SSC).',
    `remediation_requirements` STRING COMMENT 'Specific actions the vendor must take to remediate findings.',
    `risk_score` DECIMAL(18,2) COMMENT 'Numeric risk score derived from the assessment findings.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the assessment record.',
    `vendor_compliance_assessment_status` STRING COMMENT 'Current lifecycle status of the assessment.. Valid values are `pending|in_progress|completed|failed`',
    `vendor_name` STRING COMMENT 'Legal name of the vendor.',
    CONSTRAINT pk_vendor_compliance_assessment PRIMARY KEY(`vendor_compliance_assessment_id`)
) COMMENT 'Transactional record capturing third-party vendor and processor compliance assessments conducted as part of GDPR Article 28 processor due diligence, PCI DSS third-party service provider (TPSP) requirements, and general vendor risk management. Captures vendor name, vendor type (data processor, sub-processor, payment processor, logistics partner), assessment date, assessment type (questionnaire, on-site audit, certification review), compliance frameworks assessed, assessment outcome (compliant, conditionally compliant, non-compliant), critical findings, remediation requirements, next assessment due date, and data processing agreement status. Distinct from procurement supplier assessments — this record is owned by compliance and focuses on regulatory obligations.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`compliance`.`consent_policy` (
    `consent_policy_id` BIGINT COMMENT 'Unique identifier for the consent policy record.',
    `regulation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulation. Business justification: Consent policy is defined for a specific regulation; replace string with FK',
    `superseded_consent_policy_id` BIGINT COMMENT 'Self-referencing FK on consent_policy (superseded_consent_policy_id)',
    `audit_evidence_required` BOOLEAN COMMENT 'Indicates whether audit evidence must be collected for this policy.',
    `compliance_evidence_url` STRING COMMENT 'Link to documentation or evidence supporting compliance status.',
    `compliance_status` STRING COMMENT 'Current compliance assessment of the consent policy.. Valid values are `compliant|non_compliant|partial|under_review`',
    `consent_policy_status` STRING COMMENT 'Current lifecycle status of the consent policy.. Valid values are `active|inactive|pending|retired|draft`',
    `consent_type` STRING COMMENT 'Category of consent being governed (e.g., marketing email, SMS, push notification, cookie analytics, cookie advertising, profiling).. Valid values are `marketing_email|sms|push_notification|cookie_analytics|cookie_advertising|profiling`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the consent policy record was first created.',
    `data_retention_period_days` STRING COMMENT 'Number of days personal data may be retained under this consent policy.',
    `effective_date` DATE COMMENT 'Date when the consent policy becomes effective.',
    `expiry_date` DATE COMMENT 'Date when the consent policy expires or is superseded (nullable for open‑ended).',
    `granularity_level` STRING COMMENT 'Level of detail at which consent is applied (global, category, item, or purpose).. Valid values are `global|category|item|purpose`',
    `is_default` BOOLEAN COMMENT 'Flag indicating if this policy is the default for its consent type.',
    `is_required` BOOLEAN COMMENT 'Indicates whether the consent is mandatory under applicable regulation.',
    `last_review_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent compliance review of the consent policy.',
    `mechanism` STRING COMMENT 'Method by which consent is obtained (opt‑in, opt‑out, double opt‑in).. Valid values are `opt_in|opt_out|double_opt_in`',
    `notes` STRING COMMENT 'Free‑form notes or comments about the consent policy.',
    `policy_code` STRING COMMENT 'System-generated code uniquely identifying the consent policy.',
    `policy_description` STRING COMMENT 'Detailed description of the purpose and scope of the consent policy.',
    `policy_name` STRING COMMENT 'Human‑readable name of the consent policy.',
    `policy_version` STRING COMMENT 'Version identifier of the consent policy (e.g., v1.0, v2.1).',
    `review_cycle` STRING COMMENT 'Frequency at which the consent policy must be reviewed.. Valid values are `annual|biannual|quarterly|monthly|ad_hoc`',
    `source_system` STRING COMMENT 'Originating system that created or maintains the consent policy record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the consent policy record.',
    `created_by` STRING COMMENT 'Identifier of the user or system that created the consent policy.',
    CONSTRAINT pk_consent_policy PRIMARY KEY(`consent_policy_id`)
) COMMENT 'Master record defining the consent collection policies and configurations governing how customer consent is captured, stored, and managed across the e-commerce platform. Captures policy name, consent type (marketing email, SMS, push notification, cookie analytics, cookie advertising, data sharing with third parties, profiling), applicable regulation (GDPR, CCPA, ePrivacy), consent mechanism (opt-in, opt-out, double opt-in), consent granularity level, policy version, effective date, expiry date, and policy status. Distinct from customer.consent_event (which records individual customer consent actions) — this entity defines the policy framework governing those events.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`compliance`.`retention_policy` (
    `retention_policy_id` BIGINT COMMENT 'Unique surrogate identifier for the retention policy record.',
    `regulation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulation. Business justification: Retention policy is governed by a regulation; replace code with FK',
    `superseded_retention_policy_id` BIGINT COMMENT 'Self-referencing FK on retention_policy (superseded_retention_policy_id)',
    `compliance_status` STRING COMMENT 'Current compliance assessment of the policy against its governing regulation.. Valid values are `compliant|non_compliant|partial|under_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the policy record was first created.',
    `data_category` STRING COMMENT 'Category of data to which the retention policy applies.. Valid values are `customer_pii|order_record|payment_data|behavioral_data|marketing_data|audit_log`',
    `data_sensitivity_classification` STRING COMMENT 'Classification level indicating the sensitivity of the data subject to the policy.. Valid values are `restricted|confidential|internal|public`',
    `deletion_method` STRING COMMENT 'Technique used to remove or render data unusable after the retention period.. Valid values are `anonymization|pseudonymization|hard_delete|archival`',
    `effective_date` DATE COMMENT 'Date when the retention policy becomes effective.',
    `last_review_date` DATE COMMENT 'Date when the policy was last reviewed.',
    `maximum_retention_period_days` STRING COMMENT 'Maximum number of days the data may be retained before deletion.',
    `minimum_retention_period_days` STRING COMMENT 'Minimum number of days the data must be retained.',
    `next_review_date` DATE COMMENT 'Planned date for the next policy review.',
    `notes` STRING COMMENT 'Free‑form comments or additional information about the policy.',
    `policy_code` STRING COMMENT 'Business code or short identifier used to reference the policy.',
    `policy_name` STRING COMMENT 'Human‑readable name of the retention policy.',
    `policy_owner` STRING COMMENT 'Business owner or responsible team for the retention policy.',
    `retention_action` STRING COMMENT 'Action to be taken when the retention expiry date is reached.. Valid values are `anonymize|pseudonymize|delete|archive`',
    `retention_audit_log_reference` STRING COMMENT 'Identifier linking to audit evidence supporting the policys compliance.',
    `retention_basis` STRING COMMENT 'Legal or business basis for retaining the data.. Valid values are `legal_obligation|legitimate_interest|contractual|regulatory`',
    `retention_expiry_date` DATE COMMENT 'Calculated date when the data must be deleted or otherwise disposed.',
    `retention_extension_allowed` BOOLEAN COMMENT 'Indicates whether the retention period may be extended beyond the maximum.',
    `retention_extension_justification` STRING COMMENT 'Reason and approval details for any extension of the retention period.',
    `retention_policy_status` STRING COMMENT 'Current lifecycle status of the retention policy.. Valid values are `active|inactive|pending|retired`',
    `retention_reason` STRING COMMENT 'Narrative explanation why the data must be retained.',
    `retention_review_owner` STRING COMMENT 'Person or team responsible for conducting the periodic policy review.',
    `retention_review_status` STRING COMMENT 'Current status of the most recent retention policy review.. Valid values are `completed|overdue|in_progress|not_started`',
    `retention_trigger_event` STRING COMMENT 'Business event that initiates the retention period (e.g., order completion, account closure).',
    `retention_type` STRING COMMENT 'Classification of the retention rule (e.g., legal, contractual, internal policy).. Valid values are `legal|contractual|policy`',
    `review_cycle_months` STRING COMMENT 'Number of months between mandatory policy reviews.',
    `source_system` STRING COMMENT 'Source system or application where the policy was originally defined.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the policy record.',
    `version` STRING COMMENT 'Version identifier for change management of the policy.',
    CONSTRAINT pk_retention_policy PRIMARY KEY(`retention_policy_id`)
) COMMENT 'Master record defining data retention and deletion policies for each data category managed on the e-commerce platform. Captures policy name, data category (customer PII, order records, payment data, behavioral data, audit logs, marketing data), applicable regulation driving retention (GDPR Article 5(1)(e), PCI DSS Requirement 3, tax law, consumer protection), minimum retention period, maximum retention period, retention basis (legal obligation, legitimate interest, contractual), deletion method (anonymization, pseudonymization, hard delete), policy owner, effective date, and review cycle. SSOT for data lifecycle and retention governance.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`compliance`.`training` (
    `training_id` BIGINT COMMENT 'Unique identifier for the compliance training record.',
    `regulation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulation. Business justification: Training is tied to a regulation; replace code attribute with a foreign key to regulation.',
    `prerequisite_training_id` BIGINT COMMENT 'Self-referencing FK on training (prerequisite_training_id)',
    `audit_evidence_url` STRING COMMENT 'Link to stored evidence of training completion for audit purposes.',
    `certification_expiry_date` DATE COMMENT 'Expiration date of the certification, if applicable.',
    `certification_required` BOOLEAN COMMENT 'Indicates if a certification is awarded upon completion.',
    `compliance_evidence_required` STRING COMMENT 'Description of evidence needed to demonstrate completion for audit.',
    `cost_usd` DECIMAL(18,2) COMMENT 'Monetary cost associated with the training.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the training record was created.',
    `delivery_format` STRING COMMENT 'Method used to deliver the training content.. Valid values are `e_learning|instructor_led|video|blended`',
    `duration_minutes` STRING COMMENT 'Total length of the training in minutes.',
    `effective_date` DATE COMMENT 'Date when the training becomes effective or available.',
    `expiration_date` DATE COMMENT 'Date after which the training is no longer valid.',
    `external_provider` STRING COMMENT 'Name of third‑party provider delivering the training, if any.',
    `language` STRING COMMENT 'Primary language of the training content.. Valid values are `en|es|fr|de|zh|ja`',
    `last_review_date` DATE COMMENT 'Date when the training content was last reviewed for relevance.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates if the training is mandatory for the target audience.',
    `next_review_date` DATE COMMENT 'Planned date for the next review of the training content.',
    `notes` STRING COMMENT 'Additional free-text notes about the training.',
    `passing_score_percent` STRING COMMENT 'Minimum score required to pass the training.',
    `recurrence_requirement` STRING COMMENT 'Frequency at which the training must be retaken.. Valid values are `annual|one_time|role_change|periodic|onboarding`',
    `retention_period_days` STRING COMMENT 'Number of days to retain training records.',
    `target_audience` STRING COMMENT 'Intended audience for the training. [ENUM-REF-CANDIDATE: all_staff|engineering|customer_service|finance|sellers|contractors|management — 7 candidates stripped; promote to reference product]',
    `training_code` STRING COMMENT 'Unique business identifier or code for the training.',
    `training_name` STRING COMMENT 'Human readable name of the compliance training program.',
    `training_status` STRING COMMENT 'Current lifecycle status of the training.. Valid values are `active|retired|draft|pending|archived`',
    `training_type` STRING COMMENT 'Category of compliance training based on regulation or policy.. Valid values are `gdpr_awareness|pci_dss_security|anti_bribery|consumer_protection|data_handling|other`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the training record.',
    `version_number` STRING COMMENT 'Version identifier of the training content.',
    CONSTRAINT pk_training PRIMARY KEY(`training_id`)
) COMMENT 'Master record for compliance training programs and courses required for employees and contractors on the e-commerce platform. Captures training name, training type (GDPR awareness, PCI DSS security, anti-bribery, consumer protection, data handling), target audience (all staff, engineering, customer service, finance, sellers), delivery format (e-learning, instructor-led, video), training duration, passing score threshold, recurrence requirement (annual, one-time, role-change triggered), training status (active, retired), and associated regulation or policy. Enables management of mandatory compliance training obligations.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`compliance`.`training_completion` (
    `training_completion_id` BIGINT COMMENT 'Unique identifier for the training completion record.',
    `training_id` BIGINT COMMENT 'Identifier of the mandatory compliance training program.',
    `retake_of_training_completion_id` BIGINT COMMENT 'Self-referencing FK on training_completion (retake_of_training_completion_id)',
    `assessment_max_score` DECIMAL(18,2) COMMENT 'Maximum possible score for the assessment.',
    `assessment_pass_threshold` DECIMAL(18,2) COMMENT 'Minimum score required to pass the assessment.',
    `assessment_score` DECIMAL(18,2) COMMENT 'Score achieved on the training assessment (e.g., 85.00).',
    `assessment_type` STRING COMMENT 'Type of assessment used to evaluate the trainee.. Valid values are `quiz|exam|simulation`',
    `assigned_date` DATE COMMENT 'Date the training was assigned to the trainee.',
    `certificate_reference` STRING COMMENT 'Reference (e.g., URL or ID) to the issued certificate of completion.',
    `completion_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the trainee completed the training.',
    `compliance_requirement` STRING COMMENT 'Regulatory framework the training satisfies.. Valid values are `GDPR|PCI_DSS|SOX|CCPA|HIPAA|OTHER`',
    `compliance_status` STRING COMMENT 'Result of compliance verification for this training record.. Valid values are `compliant|non_compliant|exempt`',
    `due_date` DATE COMMENT 'Deadline by which the training must be completed.',
    `evidence_document_reference` STRING COMMENT 'Reference to supporting evidence uploaded for audit.',
    `expiration_date` DATE COMMENT 'Date when the training certification expires, if applicable.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether the training is required by policy.',
    `language` STRING COMMENT 'Language in which the training was provided.',
    `location` STRING COMMENT 'Physical or virtual location where the training was delivered.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the training completion.',
    `pass_fail` STRING COMMENT 'Result of the assessment indicating pass or fail.. Valid values are `pass|fail`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the training completion record was first created.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `training_completion_code` STRING COMMENT 'External reference code for the training completion, used in audit reports.',
    `training_completion_status` STRING COMMENT 'Current lifecycle status of the training assignment.. Valid values are `assigned|in_progress|completed|overdue|waived`',
    `training_method` STRING COMMENT 'Method used to deliver the training.. Valid values are `online|in_person|virtual_classroom|self_paced`',
    `training_program_name` STRING COMMENT 'Human‑readable name of the compliance training program.',
    `training_version` STRING COMMENT 'Version identifier of the training content delivered.',
    `waiver_reason` STRING COMMENT 'Reason provided when training is waived.',
    CONSTRAINT pk_training_completion PRIMARY KEY(`training_completion_id`)
) COMMENT 'Transactional record capturing individual employee or contractor completion of mandatory compliance training courses. Captures trainee identity, training program reference, assigned date, completion date, assessment score, pass/fail outcome, completion status (assigned, in-progress, completed, overdue, waived), waiver reason if applicable, certificate of completion reference, and training version completed. Provides the audit trail for demonstrating workforce compliance training obligations under GDPR, PCI DSS, and internal policy requirements.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`compliance`.`regulatory_change` (
    `regulatory_change_id` BIGINT COMMENT 'Unique identifier for the regulatory change record.',
    `regulation_id` BIGINT COMMENT 'Identifier of the regulation affected by this change.',
    `amends_regulatory_change_id` BIGINT COMMENT 'Self-referencing FK on regulatory_change (amends_regulatory_change_id)',
    `audit_evidence_required` BOOLEAN COMMENT 'Indicates if audit evidence must be collected for this change.',
    `business_areas_impacted` STRING COMMENT 'Comma‑separated list of business areas affected by the change.',
    `change_status` STRING COMMENT 'Current lifecycle status of the regulatory change.. Valid values are `monitoring|impact_assessed|response_planned|implemented|closed`',
    `change_type` STRING COMMENT 'Type of regulatory change (e.g., new regulation, amendment).. Valid values are `new_regulation|amendment|enforcement_guidance|court_ruling|authority_decision`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created.',
    `effective_date` DATE COMMENT 'Date the regulatory change becomes effective.',
    `expiration_date` DATE COMMENT 'Date the regulatory change expires, if applicable.',
    `impact_assessment_status` STRING COMMENT 'Current status of the impact assessment for the change.. Valid values are `not_started|in_progress|completed`',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether compliance with the change is mandatory.',
    `jurisdiction` STRING COMMENT 'Country or region jurisdiction of the regulatory change.. Valid values are `^[A-Z]{3}$`',
    `notes` STRING COMMENT 'Free‑form notes or comments about the regulatory change.',
    `publication_date` DATE COMMENT 'Date the regulatory change was published.',
    `record_source_system` STRING COMMENT 'Name of the source system that supplied the regulatory change record.',
    `regulatory_change_description` STRING COMMENT 'Detailed description of the regulatory change.',
    `required_response_actions` STRING COMMENT 'Actions required to comply with the regulatory change.',
    `response_deadline` DATE COMMENT 'Deadline by which required actions must be completed.',
    `risk_tier` STRING COMMENT 'Risk tier associated with the regulatory change.. Valid values are `low|medium|high`',
    `severity_level` STRING COMMENT 'Severity rating of the regulatory change impact.. Valid values are `low|medium|high|critical`',
    `source_url` STRING COMMENT 'Link to the official publication or source document.',
    `title` STRING COMMENT 'Title summarizing the regulatory change.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    CONSTRAINT pk_regulatory_change PRIMARY KEY(`regulatory_change_id`)
) COMMENT 'Transactional record tracking regulatory changes, new legislation, and amendments to existing regulations that may impact the e-commerce platforms compliance posture. Captures change title, affected regulation, change type (new regulation, amendment, enforcement guidance, court ruling, supervisory authority decision), jurisdiction, publication date, effective date, impact assessment status, assigned compliance owner, business areas impacted, required response actions, response deadline, and change status (monitoring, impact-assessed, response-planned, implemented, closed). Enables proactive regulatory horizon scanning and change management.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`compliance`.`compliance_exception` (
    `compliance_exception_id` BIGINT COMMENT 'System-generated unique identifier for the compliance exception record.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Compliance exception must reference the obligation it exempts',
    `renewed_from_compliance_exception_id` BIGINT COMMENT 'Self-referencing FK on compliance_exception (renewed_from_compliance_exception_id)',
    `affected_policy` STRING COMMENT 'Identifier or name of the policy, control, or regulation that the exception impacts.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the exception was formally approved.',
    `approving_authority_name` STRING COMMENT 'Full name of the approving manager or compliance officer.',
    `business_event_timestamp` TIMESTAMP COMMENT 'Timestamp representing the primary business event associated with the exception (e.g., date of request submission).',
    `business_justification` STRING COMMENT 'Explanation of why the exception is required from a business perspective.',
    `compensating_controls` STRING COMMENT 'Description of alternative controls put in place to mitigate risk while the exception is active.',
    `compliance_exception_status` STRING COMMENT 'Current lifecycle state of the exception.. Valid values are `pending-approval|approved|expired|revoked`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the exception record was first created in the system.',
    `exception_number` STRING COMMENT 'Human‑readable unique code assigned to the exception for tracking and reference.',
    `exception_type` STRING COMMENT 'Category of the exception: policy exception, control exception, or regulatory deviation.. Valid values are `policy|control|regulatory`',
    `expiry_timestamp` TIMESTAMP COMMENT 'Date and time when the exception expires or is scheduled to be revoked.',
    `notes` STRING COMMENT 'Free‑form comments or additional information captured by compliance analysts.',
    `remediation_plan_reference` STRING COMMENT 'Identifier linking to the remediation plan that addresses the root cause of the exception.',
    `requestor_name` STRING COMMENT 'Full name of the person or organization submitting the exception request.',
    `risk_acceptance_rationale` STRING COMMENT 'Reasoning for accepting the residual risk associated with the exception.',
    `risk_level` STRING COMMENT 'Qualitative assessment of the residual risk associated with the exception.. Valid values are `low|medium|high`',
    `start_timestamp` TIMESTAMP COMMENT 'Date and time when the exception becomes effective.',
    `title` STRING COMMENT 'Brief title summarizing the nature of the compliance exception.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the exception record.',
    CONSTRAINT pk_compliance_exception PRIMARY KEY(`compliance_exception_id`)
) COMMENT 'Transactional record capturing formally approved exceptions to compliance policies, controls, or regulatory requirements where full compliance cannot be immediately achieved. Captures exception title, exception type (policy exception, control exception, regulatory deviation), affected policy or control, business justification, risk acceptance rationale, exception requestor, approving authority, approval date, exception start date, exception expiry date, compensating controls in place, exception status (pending-approval, approved, expired, revoked), and remediation plan reference. Provides the governance audit trail for risk-accepted compliance deviations.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` (
    `supervisory_correspondence_id` BIGINT COMMENT 'Unique system-generated identifier for each supervisory correspondence record.',
    `program_id` BIGINT COMMENT 'Identifier of the compliance program governing this correspondence.',
    `in_reply_to_supervisory_correspondence_id` BIGINT COMMENT 'Self-referencing FK on supervisory_correspondence (in_reply_to_supervisory_correspondence_id)',
    `associated_regulation_code` STRING COMMENT 'Regulation code (e.g., GDPR, PCI_DSS) that this correspondence relates to.',
    `attachment_count` STRING COMMENT 'Number of supporting documents attached to the correspondence.',
    `audit_evidence_url` STRING COMMENT 'Link to the location of audit evidence files stored in the document repository.',
    `audit_log_reference` STRING COMMENT 'Identifier linking to the detailed audit log entry for this correspondence.',
    `authority_name` STRING COMMENT 'Full legal name of the supervisory authority (e.g., Federal Trade Commission).',
    `authority_type` STRING COMMENT 'Category of the authority handling the correspondence.. Valid values are `dpa|pci_ssc|ftc|cfpb|national_consumer_authority`',
    `communication_channel` STRING COMMENT 'Primary channel used for the correspondence exchange.. Valid values are `email|phone|portal|mail`',
    `compliance_deadline` DATE COMMENT 'Date by which compliance actions related to the correspondence must be completed.',
    `compliance_status` STRING COMMENT 'Current compliance status of the correspondence with respect to the associated regulation.. Valid values are `compliant|non_compliant|pending|exempt`',
    `confidentiality_level` STRING COMMENT 'Classification of the correspondence data per corporate policy.. Valid values are `restricted|confidential|internal|public`',
    `correspondence_type` STRING COMMENT 'Nature of the communication with the supervisory authority.. Valid values are `inquiry|investigation_notice|enforcement_action|voluntary_disclosure|response_submission|approval_request`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the correspondence record was first created in the system.',
    `data_protection_level` STRING COMMENT 'Level of data protection applied to the correspondence content.. Valid values are `high|medium|low`',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the correspondence has been escalated for higher-level review.',
    `evidence_attached_flag` BOOLEAN COMMENT 'True if supporting evidence documents are attached to the correspondence.',
    `follow_up_due_date` DATE COMMENT 'Date by which any required follow‑up must be completed.',
    `follow_up_required` BOOLEAN COMMENT 'Indicates whether additional action is required after the initial response.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether responding to this correspondence is mandatory under law.',
    `jurisdiction` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code of the authoritys jurisdiction.',
    `last_response_date` DATE COMMENT 'Date the most recent response was sent to the authority.',
    `notes` STRING COMMENT 'Additional comments or observations recorded by compliance staff.',
    `priority` STRING COMMENT 'Business-assigned priority level for handling the correspondence.. Valid values are `low|medium|high|critical`',
    `record_source_system` STRING COMMENT 'Name of the operational system that originated the correspondence record.',
    `reference_number` STRING COMMENT 'External reference number assigned by the regulatory authority or internal tracking system.',
    `response_deadline` DATE COMMENT 'Date by which a response must be provided to the authority.',
    `response_method` STRING COMMENT 'Medium used to deliver the response to the authority.. Valid values are `email|portal|postal|fax|phone`',
    `response_outcome` STRING COMMENT 'Result of the authoritys review of the submitted response.. Valid values are `accepted|rejected|pending|partial|withdrawn`',
    `response_submitted_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the response was submitted.',
    `response_summary` STRING COMMENT 'Brief textual summary of the response provided to the authority.',
    `retention_period_days` STRING COMMENT 'Number of days the correspondence record must be retained per policy.',
    `risk_tier` STRING COMMENT 'Risk tier assigned to the correspondence based on potential impact.. Valid values are `low|medium|high|critical`',
    `submission_date` DATE COMMENT 'Date the correspondence was initially submitted to the authority.',
    `supervisory_correspondence_status` STRING COMMENT 'Current processing state of the correspondence.. Valid values are `received|acknowledged|response_submitted|closed|escalated`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the correspondence record.',
    CONSTRAINT pk_supervisory_correspondence PRIMARY KEY(`supervisory_correspondence_id`)
) COMMENT 'Master record managing all formal correspondence and communications with regulatory supervisory authorities, including data protection authorities (DPAs), payment card industry bodies, consumer protection agencies, and tax authorities. Captures correspondence reference number, authority name, authority type (DPA, PCI SSC, FTC, CFPB, national consumer authority), correspondence type (inquiry, investigation notice, enforcement action, voluntary disclosure, response submission, approval request), submission date, response deadline, correspondence status (received, acknowledged, response-submitted, closed, escalated), associated regulation, and linked compliance program or breach incident. SSOT for regulatory authority engagement tracking.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`compliance`.`tester` (
    `tester_id` BIGINT COMMENT 'Primary key for tester',
    `supervised_by_tester_id` BIGINT COMMENT 'Self-referencing FK on tester (supervised_by_tester_id)',
    `tester_category` STRING COMMENT 'Broad classification of the tester type for reporting and governance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the tester record was first created in the system.',
    `tester_description` STRING COMMENT 'Detailed description of the tester, including its objectives, scope, and any special considerations.',
    `documentation_url` STRING COMMENT 'Link to the detailed documentation or specification for the tester.',
    `effective_from` DATE COMMENT 'Date when the tester becomes valid for use in compliance activities.',
    `effective_until` DATE COMMENT 'Date when the tester is retired or no longer applicable. Null if indefinite.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether execution of this tester is mandatory for compliance certification.',
    `last_executed_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent execution of this tester in the compliance program.',
    `tester_name` STRING COMMENT 'Human‑readable name of the tester, describing its purpose or scope.',
    `owner_department` STRING COMMENT 'Business department responsible for maintaining the tester definition.',
    `tester_status` STRING COMMENT 'Current lifecycle status of the tester record.',
    `test_level` STRING COMMENT 'Granularity level of the tester within the testing hierarchy.',
    `tester_code` STRING COMMENT 'Short alphanumeric code used to reference the tester in compliance documentation and system configurations.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the tester record.',
    CONSTRAINT pk_tester PRIMARY KEY(`tester_id`)
) COMMENT 'Master reference table for tester. Referenced by tester_id.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`compliance`.`data_processing_agreement` (
    `data_processing_agreement_id` BIGINT COMMENT 'Primary key for data_processing_agreement',
    `superseded_data_processing_agreement_id` BIGINT COMMENT 'Self-referencing FK on data_processing_agreement (superseded_data_processing_agreement_id)',
    `agreement_name` STRING COMMENT 'Human‑readable name of the data processing agreement.',
    `agreement_number` STRING COMMENT 'External reference number assigned to the agreement.',
    `agreement_type` STRING COMMENT 'Category of the agreement indicating the regulatory framework it addresses.',
    `amendment_date` DATE COMMENT 'Date of the most recent amendment to the agreement.',
    `audit_frequency_months` STRING COMMENT 'Interval in months at which compliance audits are performed.',
    `breach_notification_requirements` STRING COMMENT 'Obligations and timelines for notifying breaches under the agreement.',
    `ccpa_compliance_flag` BOOLEAN COMMENT 'Indicates if the agreement meets CCPA requirements.',
    `compliance_status` STRING COMMENT 'Current compliance assessment of the agreement.',
    `contact_email` STRING COMMENT 'Primary email address for agreement-related communications.',
    `contact_phone` STRING COMMENT 'Primary phone number for agreement-related communications.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the agreement record was first created in the system.',
    `data_access_controls` STRING COMMENT 'Controls governing who can access the data under the agreement.',
    `data_categories` STRING COMMENT 'Types of personal data covered (e.g., identifiers, contact information, transaction data). [ENUM-REF-CANDIDATE: identifiers|contact|transaction|behavioral|location|financial|health — promote to reference product]',
    `data_controller` STRING COMMENT 'Organization that determines the purposes and means of processing personal data.',
    `data_encryption_at_rest` BOOLEAN COMMENT 'Indicates whether data is encrypted while stored.',
    `data_encryption_in_transit` BOOLEAN COMMENT 'Indicates whether data is encrypted during transmission.',
    `data_processor` STRING COMMENT 'Organization that processes personal data on behalf of the controller.',
    `data_retention_policy` STRING COMMENT 'Policy describing how long data is retained and deletion procedures.',
    `data_subject_rights` STRING COMMENT 'Procedures for handling data subject access, correction, deletion, etc.',
    `data_transfer_location` STRING COMMENT 'Geographic location(s) where transferred data will be stored or processed.',
    `data_transfer_mechanism` STRING COMMENT 'Legal mechanism used for cross‑border data transfers.',
    `effective_from` DATE COMMENT 'Date when the agreement becomes binding.',
    `effective_until` DATE COMMENT 'Date when the agreement expires or ends; null for open‑ended agreements.',
    `gdpr_compliance_flag` BOOLEAN COMMENT 'Indicates if the agreement meets GDPR requirements.',
    `jurisdiction` STRING COMMENT 'Primary legal jurisdiction governing the agreement, expressed as ISO 3166‑1 alpha‑3 country code.',
    `last_audit_date` DATE COMMENT 'Date of the most recent compliance audit.',
    `lawful_basis` STRING COMMENT 'Legal basis for processing personal data under GDPR.',
    `next_audit_due` DATE COMMENT 'Scheduled date for the next compliance audit.',
    `pci_dss_scope` STRING COMMENT 'Scope of PCI DSS applicability within the agreement.',
    `purpose_of_processing` STRING COMMENT 'Business purpose(s) for which personal data is processed under the agreement.',
    `renewal_option` STRING COMMENT 'Whether the agreement renews automatically, requires manual renewal, or does not renew.',
    `retention_period_days` STRING COMMENT 'Number of days personal data is retained before deletion.',
    `security_measures` STRING COMMENT 'Technical and organizational safeguards applied to protect data.',
    `signed_by` STRING COMMENT 'Name of the individual who signed the agreement on behalf of the organization.',
    `signed_date` DATE COMMENT 'Date when the agreement was signed by the parties.',
    `data_processing_agreement_status` STRING COMMENT 'Current lifecycle status of the agreement.',
    `termination_clause` STRING COMMENT 'Text describing conditions under which the agreement may be terminated.',
    `termination_date` DATE COMMENT 'Actual date the agreement was terminated, if applicable.',
    `third_party_sharing` BOOLEAN COMMENT 'Indicates whether data is shared with third parties beyond the processor.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the agreement record.',
    `version_number` STRING COMMENT 'Version identifier of the agreement document.',
    CONSTRAINT pk_data_processing_agreement PRIMARY KEY(`data_processing_agreement_id`)
) COMMENT 'Master reference table for data_processing_agreement. Referenced by data_processing_agreement_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulation` ADD CONSTRAINT `fk_compliance_regulation_parent_regulation_id` FOREIGN KEY (`parent_regulation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`regulation`(`regulation_id`);
ALTER TABLE `ecommerce_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_regulation_id` FOREIGN KEY (`regulation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`regulation`(`regulation_id`);
ALTER TABLE `ecommerce_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_parent_obligation_id` FOREIGN KEY (`parent_obligation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ADD CONSTRAINT `fk_compliance_program_parent_program_id` FOREIGN KEY (`parent_program_id`) REFERENCES `ecommerce_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_program_id` FOREIGN KEY (`program_id`) REFERENCES `ecommerce_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_regulation_id` FOREIGN KEY (`regulation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`regulation`(`regulation_id`);
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_follow_up_audit_id` FOREIGN KEY (`follow_up_audit_id`) REFERENCES `ecommerce_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_schedule` ADD CONSTRAINT `fk_compliance_audit_schedule_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `ecommerce_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_schedule` ADD CONSTRAINT `fk_compliance_audit_schedule_rescheduled_from_audit_schedule_id` FOREIGN KEY (`rescheduled_from_audit_schedule_id`) REFERENCES `ecommerce_ecm`.`compliance`.`audit_schedule`(`audit_schedule_id`);
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `ecommerce_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_related_audit_finding_id` FOREIGN KEY (`related_audit_finding_id`) REFERENCES `ecommerce_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `ecommerce_ecm`.`compliance`.`remediation_plan` ADD CONSTRAINT `fk_compliance_remediation_plan_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `ecommerce_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `ecommerce_ecm`.`compliance`.`remediation_plan` ADD CONSTRAINT `fk_compliance_remediation_plan_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `ecommerce_ecm`.`compliance`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `ecommerce_ecm`.`compliance`.`remediation_plan` ADD CONSTRAINT `fk_compliance_remediation_plan_escalated_from_remediation_plan_id` FOREIGN KEY (`escalated_from_remediation_plan_id`) REFERENCES `ecommerce_ecm`.`compliance`.`remediation_plan`(`remediation_plan_id`);
ALTER TABLE `ecommerce_ecm`.`compliance`.`certification` ADD CONSTRAINT `fk_compliance_certification_program_id` FOREIGN KEY (`program_id`) REFERENCES `ecommerce_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `ecommerce_ecm`.`compliance`.`certification` ADD CONSTRAINT `fk_compliance_certification_renewed_from_certification_id` FOREIGN KEY (`renewed_from_certification_id`) REFERENCES `ecommerce_ecm`.`compliance`.`certification`(`certification_id`);
ALTER TABLE `ecommerce_ecm`.`compliance`.`evidence` ADD CONSTRAINT `fk_compliance_evidence_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `ecommerce_ecm`.`compliance`.`evidence` ADD CONSTRAINT `fk_compliance_evidence_superseded_evidence_id` FOREIGN KEY (`superseded_evidence_id`) REFERENCES `ecommerce_ecm`.`compliance`.`evidence`(`evidence_id`);
ALTER TABLE `ecommerce_ecm`.`compliance`.`privacy_notice` ADD CONSTRAINT `fk_compliance_privacy_notice_regulation_id` FOREIGN KEY (`regulation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`regulation`(`regulation_id`);
ALTER TABLE `ecommerce_ecm`.`compliance`.`privacy_notice` ADD CONSTRAINT `fk_compliance_privacy_notice_superseded_privacy_notice_id` FOREIGN KEY (`superseded_privacy_notice_id`) REFERENCES `ecommerce_ecm`.`compliance`.`privacy_notice`(`privacy_notice_id`);
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold` ADD CONSTRAINT `fk_compliance_legal_hold_superseded_legal_hold_id` FOREIGN KEY (`superseded_legal_hold_id`) REFERENCES `ecommerce_ecm`.`compliance`.`legal_hold`(`legal_hold_id`);
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold_custodian` ADD CONSTRAINT `fk_compliance_legal_hold_custodian_legal_hold_id` FOREIGN KEY (`legal_hold_id`) REFERENCES `ecommerce_ecm`.`compliance`.`legal_hold`(`legal_hold_id`);
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold_custodian` ADD CONSTRAINT `fk_compliance_legal_hold_custodian_replaced_legal_hold_custodian_id` FOREIGN KEY (`replaced_legal_hold_custodian_id`) REFERENCES `ecommerce_ecm`.`compliance`.`legal_hold_custodian`(`legal_hold_custodian_id`);
ALTER TABLE `ecommerce_ecm`.`compliance`.`risk_assessment` ADD CONSTRAINT `fk_compliance_risk_assessment_previous_risk_assessment_id` FOREIGN KEY (`previous_risk_assessment_id`) REFERENCES `ecommerce_ecm`.`compliance`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `ecommerce_ecm`.`compliance`.`control` ADD CONSTRAINT `fk_compliance_control_regulation_id` FOREIGN KEY (`regulation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`regulation`(`regulation_id`);
ALTER TABLE `ecommerce_ecm`.`compliance`.`control` ADD CONSTRAINT `fk_compliance_control_parent_control_id` FOREIGN KEY (`parent_control_id`) REFERENCES `ecommerce_ecm`.`compliance`.`control`(`control_id`);
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` ADD CONSTRAINT `fk_compliance_control_test_control_id` FOREIGN KEY (`control_id`) REFERENCES `ecommerce_ecm`.`compliance`.`control`(`control_id`);
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` ADD CONSTRAINT `fk_compliance_control_test_tester_id` FOREIGN KEY (`tester_id`) REFERENCES `ecommerce_ecm`.`compliance`.`tester`(`tester_id`);
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` ADD CONSTRAINT `fk_compliance_control_test_retest_of_control_test_id` FOREIGN KEY (`retest_of_control_test_id`) REFERENCES `ecommerce_ecm`.`compliance`.`control_test`(`control_test_id`);
ALTER TABLE `ecommerce_ecm`.`compliance`.`vendor_compliance_assessment` ADD CONSTRAINT `fk_compliance_vendor_compliance_assessment_data_processing_agreement_id` FOREIGN KEY (`data_processing_agreement_id`) REFERENCES `ecommerce_ecm`.`compliance`.`data_processing_agreement`(`data_processing_agreement_id`);
ALTER TABLE `ecommerce_ecm`.`compliance`.`vendor_compliance_assessment` ADD CONSTRAINT `fk_compliance_vendor_compliance_assessment_program_id` FOREIGN KEY (`program_id`) REFERENCES `ecommerce_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `ecommerce_ecm`.`compliance`.`vendor_compliance_assessment` ADD CONSTRAINT `fk_compliance_vendor_compliance_assessment_previous_vendor_compliance_assessment_id` FOREIGN KEY (`previous_vendor_compliance_assessment_id`) REFERENCES `ecommerce_ecm`.`compliance`.`vendor_compliance_assessment`(`vendor_compliance_assessment_id`);
ALTER TABLE `ecommerce_ecm`.`compliance`.`consent_policy` ADD CONSTRAINT `fk_compliance_consent_policy_regulation_id` FOREIGN KEY (`regulation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`regulation`(`regulation_id`);
ALTER TABLE `ecommerce_ecm`.`compliance`.`consent_policy` ADD CONSTRAINT `fk_compliance_consent_policy_superseded_consent_policy_id` FOREIGN KEY (`superseded_consent_policy_id`) REFERENCES `ecommerce_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `ecommerce_ecm`.`compliance`.`retention_policy` ADD CONSTRAINT `fk_compliance_retention_policy_regulation_id` FOREIGN KEY (`regulation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`regulation`(`regulation_id`);
ALTER TABLE `ecommerce_ecm`.`compliance`.`retention_policy` ADD CONSTRAINT `fk_compliance_retention_policy_superseded_retention_policy_id` FOREIGN KEY (`superseded_retention_policy_id`) REFERENCES `ecommerce_ecm`.`compliance`.`retention_policy`(`retention_policy_id`);
ALTER TABLE `ecommerce_ecm`.`compliance`.`training` ADD CONSTRAINT `fk_compliance_training_regulation_id` FOREIGN KEY (`regulation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`regulation`(`regulation_id`);
ALTER TABLE `ecommerce_ecm`.`compliance`.`training` ADD CONSTRAINT `fk_compliance_training_prerequisite_training_id` FOREIGN KEY (`prerequisite_training_id`) REFERENCES `ecommerce_ecm`.`compliance`.`training`(`training_id`);
ALTER TABLE `ecommerce_ecm`.`compliance`.`training_completion` ADD CONSTRAINT `fk_compliance_training_completion_training_id` FOREIGN KEY (`training_id`) REFERENCES `ecommerce_ecm`.`compliance`.`training`(`training_id`);
ALTER TABLE `ecommerce_ecm`.`compliance`.`training_completion` ADD CONSTRAINT `fk_compliance_training_completion_retake_of_training_completion_id` FOREIGN KEY (`retake_of_training_completion_id`) REFERENCES `ecommerce_ecm`.`compliance`.`training_completion`(`training_completion_id`);
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_regulation_id` FOREIGN KEY (`regulation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`regulation`(`regulation_id`);
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_amends_regulatory_change_id` FOREIGN KEY (`amends_regulatory_change_id`) REFERENCES `ecommerce_ecm`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `ecommerce_ecm`.`compliance`.`compliance_exception` ADD CONSTRAINT `fk_compliance_compliance_exception_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `ecommerce_ecm`.`compliance`.`compliance_exception` ADD CONSTRAINT `fk_compliance_compliance_exception_renewed_from_compliance_exception_id` FOREIGN KEY (`renewed_from_compliance_exception_id`) REFERENCES `ecommerce_ecm`.`compliance`.`compliance_exception`(`compliance_exception_id`);
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` ADD CONSTRAINT `fk_compliance_supervisory_correspondence_program_id` FOREIGN KEY (`program_id`) REFERENCES `ecommerce_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` ADD CONSTRAINT `fk_compliance_supervisory_correspondence_in_reply_to_supervisory_correspondence_id` FOREIGN KEY (`in_reply_to_supervisory_correspondence_id`) REFERENCES `ecommerce_ecm`.`compliance`.`supervisory_correspondence`(`supervisory_correspondence_id`);
ALTER TABLE `ecommerce_ecm`.`compliance`.`tester` ADD CONSTRAINT `fk_compliance_tester_supervised_by_tester_id` FOREIGN KEY (`supervised_by_tester_id`) REFERENCES `ecommerce_ecm`.`compliance`.`tester`(`tester_id`);
ALTER TABLE `ecommerce_ecm`.`compliance`.`data_processing_agreement` ADD CONSTRAINT `fk_compliance_data_processing_agreement_superseded_data_processing_agreement_id` FOREIGN KEY (`superseded_data_processing_agreement_id`) REFERENCES `ecommerce_ecm`.`compliance`.`data_processing_agreement`(`data_processing_agreement_id`);

-- ========= TAGS =========
ALTER SCHEMA `ecommerce_ecm`.`compliance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `ecommerce_ecm`.`compliance` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulation` SET TAGS ('dbx_subdomain' = 'regulatory_governance');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulation` ALTER COLUMN `regulation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulation ID');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulation` ALTER COLUMN `parent_regulation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulation` ALTER COLUMN `audit_evidence_required` SET TAGS ('dbx_business_glossary_term' = 'Audit Evidence Required');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulation` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulation` ALTER COLUMN `compliance_obligation_type` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Type');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulation` ALTER COLUMN `compliance_obligation_type` SET TAGS ('dbx_value_regex' = 'mandatory|voluntary');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|partial|exempt');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulation` ALTER COLUMN `consumer_protection_requirements` SET TAGS ('dbx_business_glossary_term' = 'Consumer Protection Requirements');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulation` ALTER COLUMN `data_protection_level` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Level');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulation` ALTER COLUMN `enforcement_status` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Status');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulation` ALTER COLUMN `enforcement_status` SET TAGS ('dbx_value_regex' = 'enforced|not_enforced|pending');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulation` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulation` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory Flag');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulation` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulation` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Regulation Notes');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulation` ALTER COLUMN `payment_security_requirements` SET TAGS ('dbx_business_glossary_term' = 'Payment Security Requirements');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulation` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulation` ALTER COLUMN `privacy_requirements` SET TAGS ('dbx_business_glossary_term' = 'Privacy Requirements');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulation` ALTER COLUMN `regulation_category` SET TAGS ('dbx_business_glossary_term' = 'Regulation Category');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulation` ALTER COLUMN `regulation_category` SET TAGS ('dbx_value_regex' = 'data_privacy|payment_security|consumer_protection|tax|trade|environmental');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulation` ALTER COLUMN `regulation_code` SET TAGS ('dbx_business_glossary_term' = 'Regulation Code');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulation` ALTER COLUMN `regulation_description` SET TAGS ('dbx_business_glossary_term' = 'Regulation Description');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulation` ALTER COLUMN `regulation_name` SET TAGS ('dbx_business_glossary_term' = 'Regulation Name');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulation` ALTER COLUMN `regulation_status` SET TAGS ('dbx_business_glossary_term' = 'Regulation Status');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulation` ALTER COLUMN `regulation_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulation` ALTER COLUMN `regulation_type` SET TAGS ('dbx_business_glossary_term' = 'Regulation Type');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulation` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulation` ALTER COLUMN `scope` SET TAGS ('dbx_business_glossary_term' = 'Regulation Scope');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulation` ALTER COLUMN `scope` SET TAGS ('dbx_value_regex' = 'global|regional|country_specific');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulation` ALTER COLUMN `source_url` SET TAGS ('dbx_business_glossary_term' = 'Regulation Source URL');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulation` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Regulation Version Number');
ALTER TABLE `ecommerce_ecm`.`compliance`.`obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`compliance`.`obligation` SET TAGS ('dbx_subdomain' = 'regulatory_governance');
ALTER TABLE `ecommerce_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Identifier');
ALTER TABLE `ecommerce_ecm`.`compliance`.`obligation` ALTER COLUMN `regulation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulation Identifier (REGULATION_ID)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`obligation` ALTER COLUMN `parent_obligation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`obligation` ALTER COLUMN `audit_log_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Log Reference (AUDIT_LOG_REFERENCE)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`obligation` ALTER COLUMN `compliance_category` SET TAGS ('dbx_business_glossary_term' = 'Compliance Category (COMPLIANCE_CATEGORY)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`obligation` ALTER COLUMN `compliance_category` SET TAGS ('dbx_value_regex' = 'privacy|security|financial|operational');
ALTER TABLE `ecommerce_ecm`.`compliance`.`obligation` ALTER COLUMN `compliance_evidence_url` SET TAGS ('dbx_business_glossary_term' = 'Compliance Evidence URL (COMPLIANCE_EVIDENCE_URL)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (COMPLIANCE_STATUS)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|partial|not_applicable');
ALTER TABLE `ecommerce_ecm`.`compliance`.`obligation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`obligation` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Obligation Due Date (DUE_DATE)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`obligation` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFFECTIVE_FROM)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`obligation` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EFFECTIVE_UNTIL)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`obligation` ALTER COLUMN `enforcement_penalty` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Penalty (ENFORCEMENT_PENALTY)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`obligation` ALTER COLUMN `evidence_required` SET TAGS ('dbx_business_glossary_term' = 'Evidence Required Flag (EVIDENCE_REQUIRED)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`obligation` ALTER COLUMN `evidence_status` SET TAGS ('dbx_business_glossary_term' = 'Evidence Status (EVIDENCE_STATUS)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`obligation` ALTER COLUMN `evidence_status` SET TAGS ('dbx_value_regex' = 'provided|pending|not_required');
ALTER TABLE `ecommerce_ecm`.`compliance`.`obligation` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag (IS_MANDATORY)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`obligation` ALTER COLUMN `last_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Review Timestamp (LAST_REVIEW_TIMESTAMP)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`obligation` ALTER COLUMN `next_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Next Review Timestamp (NEXT_REVIEW_TIMESTAMP)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`obligation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (NOTES)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_business_glossary_term' = 'Obligation Code (OBLIGATION_CODE)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_description` SET TAGS ('dbx_business_glossary_term' = 'Obligation Description (DESCRIPTION)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_name` SET TAGS ('dbx_business_glossary_term' = 'Obligation Name (NAME)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_status` SET TAGS ('dbx_business_glossary_term' = 'Obligation Lifecycle Status (STATUS)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_status` SET TAGS ('dbx_value_regex' = 'active|inactive|waived|deferred|completed');
ALTER TABLE `ecommerce_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_business_glossary_term' = 'Obligation Type (OBLIGATION_TYPE)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_value_regex' = 'data_subject_right|breach_notification|consent_management|record_retention|security_control|audit_requirement');
ALTER TABLE `ecommerce_ecm`.`compliance`.`obligation` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (RECORD_SOURCE_SYSTEM)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`obligation` ALTER COLUMN `recurrence_pattern` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Pattern (RECURRENCE_PATTERN)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`obligation` ALTER COLUMN `recurrence_pattern` SET TAGS ('dbx_value_regex' = 'one_time|annual|quarterly|monthly|continuous');
ALTER TABLE `ecommerce_ecm`.`compliance`.`obligation` ALTER COLUMN `responsible_business_unit` SET TAGS ('dbx_business_glossary_term' = 'Responsible Business Unit (RESPONSIBLE_BUSINESS_UNIT)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`obligation` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (RETENTION_PERIOD_DAYS)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`obligation` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier (RISK_TIER)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`obligation` ALTER COLUMN `risk_tier` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `ecommerce_ecm`.`compliance`.`obligation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` SET TAGS ('dbx_subdomain' = 'regulatory_governance');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program ID');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `parent_program_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `applicable_regulations` SET TAGS ('dbx_business_glossary_term' = 'Applicable Regulations');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `audit_count` SET TAGS ('dbx_business_glossary_term' = 'Audit Count');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `audit_frequency` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `audit_frequency` SET TAGS ('dbx_value_regex' = 'annual|semiannual|quarterly|monthly');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Program Budget Amount');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `ccpa_compliant` SET TAGS ('dbx_business_glossary_term' = 'CCPA Compliant Flag');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'certified|pending|failed|revoked');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `compliance_issues_count` SET TAGS ('dbx_business_glossary_term' = 'Compliance Issues Count');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Compliance Score');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|partial');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `data_protection_level` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Level');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `data_protection_level` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Program Documentation URL');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `gdpr_compliant` SET TAGS ('dbx_business_glossary_term' = 'GDPR Compliant Flag');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = 'US|EU|CA|AU');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'planning|active|remediation|certified|retired');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Program Notes');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Program Owner Name');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `owner` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `owner` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `pci_dss_compliant` SET TAGS ('dbx_business_glossary_term' = 'PCI DSS Compliant Flag');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `privacy_impact_assessment_completed` SET TAGS ('dbx_business_glossary_term' = 'PIA Completed Flag');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `program_category` SET TAGS ('dbx_business_glossary_term' = 'Program Category');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `program_description` SET TAGS ('dbx_business_glossary_term' = 'Program Description');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Name');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `program_scope` SET TAGS ('dbx_business_glossary_term' = 'Program Scope');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|retired');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'regulatory|security|privacy|operational');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `remediation_deadline` SET TAGS ('dbx_business_glossary_term' = 'Remediation Deadline');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `sponsoring_executive` SET TAGS ('dbx_business_glossary_term' = 'Sponsoring Executive Name');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `sponsoring_executive` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `sponsoring_executive` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `stakeholder_count` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Count');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`program` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Record Version Number');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` SET TAGS ('dbx_subdomain' = 'audit_management');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit ID');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `regulation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Profile Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `follow_up_audit_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Approval Status');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audit Approval Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `approved_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `approved_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `audit_category` SET TAGS ('dbx_business_glossary_term' = 'Audit Category');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `audit_category` SET TAGS ('dbx_value_regex' = 'financial|security|operational|privacy|compliance');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `audit_name` SET TAGS ('dbx_business_glossary_term' = 'Audit Name');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Number');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|findings_issued|remediation|closed');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'internal|external|regulatory|soc2|pci_qsa|iso27001');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `auditing_entity` SET TAGS ('dbx_business_glossary_term' = 'Auditing Entity');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `ccpa_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'CCPA Compliance Flag');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `certification_expiry` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'certified|pending|revoked');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `cost` SET TAGS ('dbx_business_glossary_term' = 'Audit Cost');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audit Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Audit Currency');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `data_protection_impact` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Impact Level');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `data_protection_impact` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Audit Document URL');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `evidence_count` SET TAGS ('dbx_business_glossary_term' = 'Evidence Count');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Findings Summary');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `frequency` SET TAGS ('dbx_value_regex' = 'annual|biennial|quarterly|ad_hoc');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `gdpr_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'GDPR Compliance Flag');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `issues_count` SET TAGS ('dbx_business_glossary_term' = 'Issues Count');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `lead_auditor` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `lead_auditor` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `lead_auditor` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Audit Location');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `methodology` SET TAGS ('dbx_business_glossary_term' = 'Audit Methodology');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `methodology` SET TAGS ('dbx_value_regex' = 'standard|custom|risk_based');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `next_audit_due` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `overall_opinion` SET TAGS ('dbx_business_glossary_term' = 'Overall Audit Opinion');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `overall_opinion` SET TAGS ('dbx_value_regex' = 'pass|qualified|fail');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Audit Owner');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `owner` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `owner` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `pci_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'PCI Compliance Flag');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `period_end` SET TAGS ('dbx_business_glossary_term' = 'Audit Period End Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `period_start` SET TAGS ('dbx_business_glossary_term' = 'Audit Period Start Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `privacy_impact` SET TAGS ('dbx_business_glossary_term' = 'Privacy Impact Level');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `privacy_impact` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `remediation_plan` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Review Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `sox_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'SOX Compliance Flag');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audit Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Audit Version');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_schedule` SET TAGS ('dbx_subdomain' = 'audit_management');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `audit_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Schedule Identifier');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `rescheduled_from_audit_schedule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `assigned_auditor` SET TAGS ('dbx_business_glossary_term' = 'Assigned Auditor');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `assigned_auditor_contact` SET TAGS ('dbx_business_glossary_term' = 'Assigned Auditor Contact Email');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `assigned_auditor_contact` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `audit_category` SET TAGS ('dbx_business_glossary_term' = 'Audit Category');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `audit_category` SET TAGS ('dbx_value_regex' = 'internal|external');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `audit_fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Audit Fiscal Year');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `audit_location` SET TAGS ('dbx_business_glossary_term' = 'Audit Location');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `audit_priority` SET TAGS ('dbx_business_glossary_term' = 'Audit Priority');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `audit_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `audit_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Schedule Status');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `audit_schedule_status` SET TAGS ('dbx_value_regex' = 'planned|confirmed|rescheduled|cancelled');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope Description');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit In Scope');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `documentation_link` SET TAGS ('dbx_business_glossary_term' = 'Audit Documentation Link');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `estimated_effort_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Effort (Hours)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Schedule Notes');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `recurrence_pattern` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Pattern');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `recurrence_pattern` SET TAGS ('dbx_value_regex' = 'annual|semi-annual|quarterly|monthly|none');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `regulation_code` SET TAGS ('dbx_business_glossary_term' = 'Regulation or Standard Code');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Audit Risk Level');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Audit Status Reason');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `target_period_end` SET TAGS ('dbx_business_glossary_term' = 'Target Audit Period End');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `target_period_start` SET TAGS ('dbx_business_glossary_term' = 'Target Audit Period Start');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_finding` SET TAGS ('dbx_subdomain' = 'audit_management');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_finding` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Identifier');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_finding` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Session Identifier');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_finding` ALTER COLUMN `related_audit_finding_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_finding` ALTER COLUMN `actual_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Closure Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_finding` ALTER COLUMN `affected_control` SET TAGS ('dbx_business_glossary_term' = 'Affected Control Identifier');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_finding` ALTER COLUMN `audit_finding_description` SET TAGS ('dbx_business_glossary_term' = 'Finding Description');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_finding` ALTER COLUMN `audit_finding_status` SET TAGS ('dbx_business_glossary_term' = 'Finding Status');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_finding` ALTER COLUMN `audit_finding_status` SET TAGS ('dbx_value_regex' = 'open|in_remediation|remediated|accepted_risk|closed');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_finding` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_finding` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_value_regex' = 'PCI_DSS|GDPR|CCPA|SOX|FTC|ISO_27001');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_finding` ALTER COLUMN `evidence_url` SET TAGS ('dbx_business_glossary_term' = 'Evidence URL');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_finding` ALTER COLUMN `finding_code` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Code');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_finding` ALTER COLUMN `finding_code` SET TAGS ('dbx_value_regex' = '^FND-d{6}$');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_finding` ALTER COLUMN `finding_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Finding Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_business_glossary_term' = 'Finding Type (Classification)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_value_regex' = 'critical_deficiency|major_non_conformance|minor_observation|best_practice_recommendation');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_finding` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction (Country Code)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_finding` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_finding` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Finding Priority');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_finding` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'p1|p2|p3|p4');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_finding` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_finding` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_finding` ALTER COLUMN `remediation_owner` SET TAGS ('dbx_business_glossary_term' = 'Remediation Owner');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_finding` ALTER COLUMN `remediation_recommendation` SET TAGS ('dbx_business_glossary_term' = 'Remediation Recommendation');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_finding` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score (Numeric)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_finding` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_finding` ALTER COLUMN `severity_rating` SET TAGS ('dbx_business_glossary_term' = 'Severity Rating (Risk Level)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_finding` ALTER COLUMN `severity_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_finding` ALTER COLUMN `target_remediation_date` SET TAGS ('dbx_business_glossary_term' = 'Target Remediation Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit_finding` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Finding Title');
ALTER TABLE `ecommerce_ecm`.`compliance`.`remediation_plan` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`compliance`.`remediation_plan` SET TAGS ('dbx_subdomain' = 'audit_management');
ALTER TABLE `ecommerce_ecm`.`compliance`.`remediation_plan` ALTER COLUMN `remediation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan ID');
ALTER TABLE `ecommerce_ecm`.`compliance`.`remediation_plan` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Linked Audit Finding Identifier');
ALTER TABLE `ecommerce_ecm`.`compliance`.`remediation_plan` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Linked Risk Identifier');
ALTER TABLE `ecommerce_ecm`.`compliance`.`remediation_plan` ALTER COLUMN `escalated_from_remediation_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`remediation_plan` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`remediation_plan` ALTER COLUMN `approach_description` SET TAGS ('dbx_business_glossary_term' = 'Remediation Approach Description');
ALTER TABLE `ecommerce_ecm`.`compliance`.`remediation_plan` ALTER COLUMN `audit_evidence_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Evidence Reference');
ALTER TABLE `ecommerce_ecm`.`compliance`.`remediation_plan` ALTER COLUMN `compliance_category` SET TAGS ('dbx_business_glossary_term' = 'Compliance Category');
ALTER TABLE `ecommerce_ecm`.`compliance`.`remediation_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`remediation_plan` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`remediation_plan` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`remediation_plan` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `ecommerce_ecm`.`compliance`.`remediation_plan` ALTER COLUMN `evidence_url` SET TAGS ('dbx_business_glossary_term' = 'Evidence URL');
ALTER TABLE `ecommerce_ecm`.`compliance`.`remediation_plan` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`remediation_plan` ALTER COLUMN `milestone_checkpoints` SET TAGS ('dbx_business_glossary_term' = 'Milestone Checkpoints (JSON)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`remediation_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `ecommerce_ecm`.`compliance`.`remediation_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan Code');
ALTER TABLE `ecommerce_ecm`.`compliance`.`remediation_plan` ALTER COLUMN `plan_description` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan Description');
ALTER TABLE `ecommerce_ecm`.`compliance`.`remediation_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan Name');
ALTER TABLE `ecommerce_ecm`.`compliance`.`remediation_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan Type (TYPE)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`remediation_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'policy|technical|process|training');
ALTER TABLE `ecommerce_ecm`.`compliance`.`remediation_plan` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`remediation_plan` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Remediation Priority');
ALTER TABLE `ecommerce_ecm`.`compliance`.`remediation_plan` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `ecommerce_ecm`.`compliance`.`remediation_plan` ALTER COLUMN `regulatory_requirement` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Reference');
ALTER TABLE `ecommerce_ecm`.`compliance`.`remediation_plan` ALTER COLUMN `remediation_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan Status (STATUS)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`remediation_plan` ALTER COLUMN `remediation_plan_status` SET TAGS ('dbx_value_regex' = 'draft|approved|in_progress|completed|overdue|cancelled');
ALTER TABLE `ecommerce_ecm`.`compliance`.`remediation_plan` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `ecommerce_ecm`.`compliance`.`remediation_plan` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'pending|completed');
ALTER TABLE `ecommerce_ecm`.`compliance`.`remediation_plan` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Remediation Severity');
ALTER TABLE `ecommerce_ecm`.`compliance`.`remediation_plan` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `ecommerce_ecm`.`compliance`.`remediation_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`compliance`.`certification` SET TAGS ('dbx_subdomain' = 'regulatory_governance');
ALTER TABLE `ecommerce_ecm`.`compliance`.`certification` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Certification ID');
ALTER TABLE `ecommerce_ecm`.`compliance`.`certification` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program ID');
ALTER TABLE `ecommerce_ecm`.`compliance`.`certification` ALTER COLUMN `renewed_from_certification_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`certification` ALTER COLUMN `audit_evidence_url` SET TAGS ('dbx_business_glossary_term' = 'Audit Evidence URL');
ALTER TABLE `ecommerce_ecm`.`compliance`.`certification` ALTER COLUMN `audit_frequency` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency');
ALTER TABLE `ecommerce_ecm`.`compliance`.`certification` ALTER COLUMN `audit_frequency` SET TAGS ('dbx_value_regex' = 'annual|biennial|quarterly');
ALTER TABLE `ecommerce_ecm`.`compliance`.`certification` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope');
ALTER TABLE `ecommerce_ecm`.`compliance`.`certification` ALTER COLUMN `certification_code` SET TAGS ('dbx_business_glossary_term' = 'Certification Code');
ALTER TABLE `ecommerce_ecm`.`compliance`.`certification` ALTER COLUMN `certification_name` SET TAGS ('dbx_business_glossary_term' = 'Certification Name');
ALTER TABLE `ecommerce_ecm`.`compliance`.`certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `ecommerce_ecm`.`compliance`.`certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|revoked|in_renewal');
ALTER TABLE `ecommerce_ecm`.`compliance`.`certification` ALTER COLUMN `certifying_body` SET TAGS ('dbx_business_glossary_term' = 'Certifying Body');
ALTER TABLE `ecommerce_ecm`.`compliance`.`certification` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Certification Cost Amount');
ALTER TABLE `ecommerce_ecm`.`compliance`.`certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`certification` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`compliance`.`certification` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`certification` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`certification` ALTER COLUMN `last_audit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`certification` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`certification` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status');
ALTER TABLE `ecommerce_ecm`.`compliance`.`certification` ALTER COLUMN `renewal_status` SET TAGS ('dbx_value_regex' = 'pending|completed|failed');
ALTER TABLE `ecommerce_ecm`.`compliance`.`certification` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `ecommerce_ecm`.`compliance`.`certification` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `ecommerce_ecm`.`compliance`.`certification` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Certification Scope Description');
ALTER TABLE `ecommerce_ecm`.`compliance`.`certification` ALTER COLUMN `standard` SET TAGS ('dbx_business_glossary_term' = 'Certification Standard');
ALTER TABLE `ecommerce_ecm`.`compliance`.`certification` ALTER COLUMN `standard` SET TAGS ('dbx_value_regex' = 'pci_dss|iso_27001|soc_2|gdpr|cisa|hipaa');
ALTER TABLE `ecommerce_ecm`.`compliance`.`certification` ALTER COLUMN `standard_version` SET TAGS ('dbx_business_glossary_term' = 'Standard Version');
ALTER TABLE `ecommerce_ecm`.`compliance`.`certification` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Status Reason');
ALTER TABLE `ecommerce_ecm`.`compliance`.`certification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`evidence` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`compliance`.`evidence` SET TAGS ('dbx_subdomain' = 'audit_management');
ALTER TABLE `ecommerce_ecm`.`compliance`.`evidence` ALTER COLUMN `evidence_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Evidence Identifier (COMPLIANCE_EVIDENCE_ID)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`evidence` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`evidence` ALTER COLUMN `superseded_evidence_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`evidence` ALTER COLUMN `audit_comments` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Comments (AUDIT_COMMENTS)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`evidence` ALTER COLUMN `chain_of_custody` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody Notes (CHAIN_OF_CUSTODY)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`evidence` ALTER COLUMN `checksum` SET TAGS ('dbx_business_glossary_term' = 'File Checksum SHA‑256 (FILE_CHECKSUM_SHA256)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`evidence` ALTER COLUMN `checksum` SET TAGS ('dbx_value_regex' = '^[A-Fa-f0-9]{64}$');
ALTER TABLE `ecommerce_ecm`.`compliance`.`evidence` ALTER COLUMN `collected_by` SET TAGS ('dbx_business_glossary_term' = 'Collected By (COLLECTED_BY)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`evidence` ALTER COLUMN `collection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Evidence Collection Timestamp (EVIDENCE_COLLECTION_TS)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`evidence` ALTER COLUMN `collector_role` SET TAGS ('dbx_business_glossary_term' = 'Collector Role (COLLECTOR_ROLE)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`evidence` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework (COMPLIANCE_FRAMEWORK)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`evidence` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_value_regex' = 'GDPR|CCPA|PCI_DSS|SOX|FTC|ISO_27001');
ALTER TABLE `ecommerce_ecm`.`compliance`.`evidence` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RECORD_CREATED_TS)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`evidence` ALTER COLUMN `evidence_code` SET TAGS ('dbx_business_glossary_term' = 'Evidence Identifier (EVIDENCE_CODE)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`evidence` ALTER COLUMN `evidence_description` SET TAGS ('dbx_business_glossary_term' = 'Evidence Description (EVIDENCE_DESC)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`evidence` ALTER COLUMN `evidence_status` SET TAGS ('dbx_business_glossary_term' = 'Evidence Status (EVIDENCE_STATUS)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`evidence` ALTER COLUMN `evidence_status` SET TAGS ('dbx_value_regex' = 'collected|reviewed|accepted|rejected');
ALTER TABLE `ecommerce_ecm`.`compliance`.`evidence` ALTER COLUMN `evidence_type` SET TAGS ('dbx_business_glossary_term' = 'Evidence Type (EVIDENCE_TYPE)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`evidence` ALTER COLUMN `evidence_type` SET TAGS ('dbx_value_regex' = 'policy_document|screenshot|log_extract|test_result|attestation|contract_clause');
ALTER TABLE `ecommerce_ecm`.`compliance`.`evidence` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size in Bytes (FILE_SIZE_BYTES)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`evidence` ALTER COLUMN `format` SET TAGS ('dbx_business_glossary_term' = 'Evidence File Format (EVIDENCE_FORMAT)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`evidence` ALTER COLUMN `format` SET TAGS ('dbx_value_regex' = 'pdf|docx|png|jpg|txt|json');
ALTER TABLE `ecommerce_ecm`.`compliance`.`evidence` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Confidential Flag (IS_CONFIDENTIAL)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`evidence` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Country Code (JURISDICTION_COUNTRY_CODE)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`evidence` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`compliance`.`evidence` ALTER COLUMN `retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiry Date (RETENTION_EXPIRY_DATE)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`evidence` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Reference (STORAGE_LOCATION)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`evidence` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Evidence Title (EVIDENCE_TITLE)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`evidence` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RECORD_UPDATED_TS)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`privacy_notice` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`compliance`.`privacy_notice` SET TAGS ('dbx_subdomain' = 'regulatory_governance');
ALTER TABLE `ecommerce_ecm`.`compliance`.`privacy_notice` ALTER COLUMN `privacy_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Notice ID');
ALTER TABLE `ecommerce_ecm`.`compliance`.`privacy_notice` ALTER COLUMN `regulation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`privacy_notice` ALTER COLUMN `superseded_privacy_notice_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`privacy_notice` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `ecommerce_ecm`.`compliance`.`privacy_notice` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `ecommerce_ecm`.`compliance`.`privacy_notice` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`privacy_notice` ALTER COLUMN `character_count` SET TAGS ('dbx_business_glossary_term' = 'Character Count');
ALTER TABLE `ecommerce_ecm`.`compliance`.`privacy_notice` ALTER COLUMN `compliance_ccpa` SET TAGS ('dbx_business_glossary_term' = 'CCPA Applicability');
ALTER TABLE `ecommerce_ecm`.`compliance`.`privacy_notice` ALTER COLUMN `compliance_eprivacy` SET TAGS ('dbx_business_glossary_term' = 'ePrivacy Directive Applicability');
ALTER TABLE `ecommerce_ecm`.`compliance`.`privacy_notice` ALTER COLUMN `compliance_gdpr` SET TAGS ('dbx_business_glossary_term' = 'GDPR Applicability');
ALTER TABLE `ecommerce_ecm`.`compliance`.`privacy_notice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`privacy_notice` ALTER COLUMN `data_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period (Days)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`privacy_notice` ALTER COLUMN `document_format` SET TAGS ('dbx_business_glossary_term' = 'Document Format');
ALTER TABLE `ecommerce_ecm`.`compliance`.`privacy_notice` ALTER COLUMN `document_format` SET TAGS ('dbx_value_regex' = 'html|pdf|text');
ALTER TABLE `ecommerce_ecm`.`compliance`.`privacy_notice` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`privacy_notice` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`privacy_notice` ALTER COLUMN `is_internal_use_only` SET TAGS ('dbx_business_glossary_term' = 'Internal‑Use‑Only Flag');
ALTER TABLE `ecommerce_ecm`.`compliance`.`privacy_notice` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `ecommerce_ecm`.`compliance`.`privacy_notice` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction (Country Code)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`privacy_notice` ALTER COLUMN `language_locale` SET TAGS ('dbx_business_glossary_term' = 'Language / Locale');
ALTER TABLE `ecommerce_ecm`.`compliance`.`privacy_notice` ALTER COLUMN `language_locale` SET TAGS ('dbx_value_regex' = '^[a-z]{2}_[A-Z]{2}$');
ALTER TABLE `ecommerce_ecm`.`compliance`.`privacy_notice` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`privacy_notice` ALTER COLUMN `legal_owner` SET TAGS ('dbx_business_glossary_term' = 'Legal Owner');
ALTER TABLE `ecommerce_ecm`.`compliance`.`privacy_notice` ALTER COLUMN `notice_code` SET TAGS ('dbx_business_glossary_term' = 'Privacy Notice Code');
ALTER TABLE `ecommerce_ecm`.`compliance`.`privacy_notice` ALTER COLUMN `notice_text` SET TAGS ('dbx_business_glossary_term' = 'Full Notice Text');
ALTER TABLE `ecommerce_ecm`.`compliance`.`privacy_notice` ALTER COLUMN `notice_type` SET TAGS ('dbx_business_glossary_term' = 'Privacy Notice Type');
ALTER TABLE `ecommerce_ecm`.`compliance`.`privacy_notice` ALTER COLUMN `notice_type` SET TAGS ('dbx_value_regex' = 'privacy_policy|cookie_notice|terms_of_service|data_processing_summary');
ALTER TABLE `ecommerce_ecm`.`compliance`.`privacy_notice` ALTER COLUMN `privacy_notice_status` SET TAGS ('dbx_business_glossary_term' = 'Notice Status');
ALTER TABLE `ecommerce_ecm`.`compliance`.`privacy_notice` ALTER COLUMN `privacy_notice_status` SET TAGS ('dbx_value_regex' = 'draft|published|archived|retired');
ALTER TABLE `ecommerce_ecm`.`compliance`.`privacy_notice` ALTER COLUMN `publication_channel` SET TAGS ('dbx_business_glossary_term' = 'Publication Channel');
ALTER TABLE `ecommerce_ecm`.`compliance`.`privacy_notice` ALTER COLUMN `publication_channel` SET TAGS ('dbx_value_regex' = 'website|mobile_app|checkout_flow|email');
ALTER TABLE `ecommerce_ecm`.`compliance`.`privacy_notice` ALTER COLUMN `review_cycle_days` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle (Days)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`privacy_notice` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`compliance`.`privacy_notice` ALTER COLUMN `summary_text` SET TAGS ('dbx_business_glossary_term' = 'Notice Summary Text');
ALTER TABLE `ecommerce_ecm`.`compliance`.`privacy_notice` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Privacy Notice Title');
ALTER TABLE `ecommerce_ecm`.`compliance`.`privacy_notice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`privacy_notice` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `ecommerce_ecm`.`compliance`.`privacy_notice` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^d+.d+(.d+)?$');
ALTER TABLE `ecommerce_ecm`.`compliance`.`privacy_notice` ALTER COLUMN `word_count` SET TAGS ('dbx_business_glossary_term' = 'Word Count');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold` SET TAGS ('dbx_subdomain' = 'regulatory_governance');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold` ALTER COLUMN `legal_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Identifier');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold` ALTER COLUMN `superseded_legal_hold_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold` ALTER COLUMN `actual_release_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Release Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold` ALTER COLUMN `anticipated_end_date` SET TAGS ('dbx_business_glossary_term' = 'Anticipated Hold End Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold` ALTER COLUMN `audit_evidence_required` SET TAGS ('dbx_business_glossary_term' = 'Audit Evidence Required');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold` ALTER COLUMN `consumer_protection_requirements` SET TAGS ('dbx_business_glossary_term' = 'Consumer Protection Requirements');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold` ALTER COLUMN `custodians_notified` SET TAGS ('dbx_business_glossary_term' = 'Custodians Notified');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold` ALTER COLUMN `custodians_notified` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold` ALTER COLUMN `custodians_notified` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold` ALTER COLUMN `data_categories` SET TAGS ('dbx_business_glossary_term' = 'Data Categories in Scope');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold` ALTER COLUMN `data_protection_level` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Level');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold` ALTER COLUMN `data_protection_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold` ALTER COLUMN `hold_category` SET TAGS ('dbx_business_glossary_term' = 'Hold Category');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold` ALTER COLUMN `hold_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Name');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold` ALTER COLUMN `hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold` ALTER COLUMN `hold_scope_description` SET TAGS ('dbx_business_glossary_term' = 'Hold Scope Description');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold` ALTER COLUMN `hold_start_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Start Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_business_glossary_term' = 'Hold Status');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_value_regex' = 'active|released|extended|disputed|pending');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Type');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_value_regex' = 'litigation|regulatory|internal');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold` ALTER COLUMN `hold_version` SET TAGS ('dbx_business_glossary_term' = 'Hold Version');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold` ALTER COLUMN `legal_matter_reference` SET TAGS ('dbx_business_glossary_term' = 'Legal Matter Reference');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Notes');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold` ALTER COLUMN `payment_security_requirements` SET TAGS ('dbx_business_glossary_term' = 'Payment Security Requirements');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold` ALTER COLUMN `privacy_requirements` SET TAGS ('dbx_business_glossary_term' = 'Privacy Requirements');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (Days)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold` ALTER COLUMN `systems_in_scope` SET TAGS ('dbx_business_glossary_term' = 'Systems in Scope');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold_custodian` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold_custodian` SET TAGS ('dbx_subdomain' = 'regulatory_governance');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold_custodian` ALTER COLUMN `legal_hold_custodian_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Custodian ID');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold_custodian` ALTER COLUMN `legal_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold ID');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold_custodian` ALTER COLUMN `replaced_legal_hold_custodian_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold_custodian` ALTER COLUMN `acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Date (DATE)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold_custodian` ALTER COLUMN `acknowledgment_status` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Status (STATUS)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold_custodian` ALTER COLUMN `acknowledgment_status` SET TAGS ('dbx_value_regex' = 'acknowledged|pending|declined');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold_custodian` ALTER COLUMN `custodian_identifier` SET TAGS ('dbx_business_glossary_term' = 'Custodian Identifier (ID)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold_custodian` ALTER COLUMN `custodian_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold_custodian` ALTER COLUMN `custodian_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold_custodian` ALTER COLUMN `custodian_name` SET TAGS ('dbx_business_glossary_term' = 'Custodian Full Name (NAME)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold_custodian` ALTER COLUMN `custodian_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold_custodian` ALTER COLUMN `custodian_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold_custodian` ALTER COLUMN `custodian_role` SET TAGS ('dbx_business_glossary_term' = 'Custodian Role (ROLE)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold_custodian` ALTER COLUMN `custodian_type` SET TAGS ('dbx_business_glossary_term' = 'Custodian Type (TYPE)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold_custodian` ALTER COLUMN `custodian_type` SET TAGS ('dbx_value_regex' = 'internal_employee|external_vendor|system_owner');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold_custodian` ALTER COLUMN `data_sources_in_scope` SET TAGS ('dbx_business_glossary_term' = 'Data Sources In Scope (SOURCES)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold_custodian` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Custodian Email Address (EMAIL)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold_custodian` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold_custodian` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold_custodian` ALTER COLUMN `hold_end_date` SET TAGS ('dbx_business_glossary_term' = 'Hold End Date (DATE)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold_custodian` ALTER COLUMN `hold_instructions` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Instructions (INSTRUCTIONS)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold_custodian` ALTER COLUMN `hold_start_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Start Date (DATE)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold_custodian` ALTER COLUMN `hold_status` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Status (STATUS)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold_custodian` ALTER COLUMN `hold_status` SET TAGS ('dbx_value_regex' = 'active|released|expired');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold_custodian` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date (DATE)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold_custodian` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Custodian Phone Number (PHONE)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold_custodian` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold_custodian` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold_custodian` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Method (METHOD)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold_custodian` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_value_regex' = 'email|phone|sms');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold_custodian` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp (TIMESTAMP)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`legal_hold_custodian` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp (TIMESTAMP)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`risk_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`compliance`.`risk_assessment` SET TAGS ('dbx_subdomain' = 'regulatory_governance');
ALTER TABLE `ecommerce_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Identifier');
ALTER TABLE `ecommerce_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `previous_risk_assessment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `assessment_name` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Name');
ALTER TABLE `ecommerce_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `assessment_outcome` SET TAGS ('dbx_business_glossary_term' = 'Assessment Outcome');
ALTER TABLE `ecommerce_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `assessment_outcome` SET TAGS ('dbx_value_regex' = 'Acceptable|Accepted|Remediation_Required');
ALTER TABLE `ecommerce_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `assessment_scope` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Scope');
ALTER TABLE `ecommerce_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Type');
ALTER TABLE `ecommerce_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'DPIA|PCI_Risk|Vendor_Risk|General_Compliance');
ALTER TABLE `ecommerce_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `assessment_version` SET TAGS ('dbx_business_glossary_term' = 'Assessment Version');
ALTER TABLE `ecommerce_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `audit_evidence_required` SET TAGS ('dbx_business_glossary_term' = 'Audit Evidence Required');
ALTER TABLE `ecommerce_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `ecommerce_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_value_regex' = 'GDPR|PCI_DSS|CCPA|SOX|ISO27001');
ALTER TABLE `ecommerce_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `control_gaps` SET TAGS ('dbx_business_glossary_term' = 'Control Gaps');
ALTER TABLE `ecommerce_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `evidence_documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Evidence Documentation URL');
ALTER TABLE `ecommerce_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `evidence_status` SET TAGS ('dbx_business_glossary_term' = 'Evidence Status');
ALTER TABLE `ecommerce_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `evidence_status` SET TAGS ('dbx_value_regex' = 'Collected|Pending|Not_Required');
ALTER TABLE `ecommerce_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `identified_risks` SET TAGS ('dbx_business_glossary_term' = 'Identified Risks');
ALTER TABLE `ecommerce_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `impact_rating` SET TAGS ('dbx_business_glossary_term' = 'Impact Rating');
ALTER TABLE `ecommerce_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `impact_rating` SET TAGS ('dbx_value_regex' = 'Low|Medium|High|Critical');
ALTER TABLE `ecommerce_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `inherent_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Inherent Risk Score');
ALTER TABLE `ecommerce_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `likelihood_rating` SET TAGS ('dbx_business_glossary_term' = 'Likelihood Rating');
ALTER TABLE `ecommerce_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `likelihood_rating` SET TAGS ('dbx_value_regex' = 'Low|Medium|High|Critical');
ALTER TABLE `ecommerce_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `mitigation_deadline` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Deadline');
ALTER TABLE `ecommerce_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `mitigation_plan` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Plan');
ALTER TABLE `ecommerce_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `ecommerce_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `residual_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Score');
ALTER TABLE `ecommerce_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `reviewed_by_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `ecommerce_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `risk_assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Status');
ALTER TABLE `ecommerce_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `risk_assessment_status` SET TAGS ('dbx_value_regex' = 'Draft|In_Review|Approved|Rejected|Closed');
ALTER TABLE `ecommerce_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `ecommerce_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `risk_description` SET TAGS ('dbx_business_glossary_term' = 'Risk Description');
ALTER TABLE `ecommerce_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `risk_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Risk Owner Name');
ALTER TABLE `ecommerce_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `risk_score_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Calculation Method');
ALTER TABLE `ecommerce_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control` SET TAGS ('dbx_subdomain' = 'audit_management');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control` ALTER COLUMN `control_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Control ID');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control` ALTER COLUMN `regulation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control` ALTER COLUMN `parent_control_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control` ALTER COLUMN `automation_flag` SET TAGS ('dbx_business_glossary_term' = 'Automation Flag');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|partial|not_applicable');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control` ALTER COLUMN `continuous_monitoring` SET TAGS ('dbx_business_glossary_term' = 'Continuous Monitoring Flag');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control` ALTER COLUMN `control_category` SET TAGS ('dbx_business_glossary_term' = 'Control Category');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control` ALTER COLUMN `control_category` SET TAGS ('dbx_value_regex' = 'technical|administrative|physical');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control` ALTER COLUMN `control_code` SET TAGS ('dbx_business_glossary_term' = 'Control Code');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control` ALTER COLUMN `control_description` SET TAGS ('dbx_business_glossary_term' = 'Control Description');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control` ALTER COLUMN `control_name` SET TAGS ('dbx_business_glossary_term' = 'Control Name');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control` ALTER COLUMN `control_status` SET TAGS ('dbx_business_glossary_term' = 'Control Status');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control` ALTER COLUMN `control_status` SET TAGS ('dbx_value_regex' = 'active|inactive|compensating|retired');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control` ALTER COLUMN `control_type` SET TAGS ('dbx_business_glossary_term' = 'Control Type');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control` ALTER COLUMN `control_type` SET TAGS ('dbx_value_regex' = 'preventive|detective|corrective');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control` ALTER COLUMN `dependent_controls` SET TAGS ('dbx_business_glossary_term' = 'Dependent Controls');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control` ALTER COLUMN `documentation_reference` SET TAGS ('dbx_business_glossary_term' = 'Documentation Reference');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control` ALTER COLUMN `evidence_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Evidence Retention Period (Days)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control` ALTER COLUMN `evidence_url` SET TAGS ('dbx_business_glossary_term' = 'Evidence URL');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Control Frequency');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control` ALTER COLUMN `frequency` SET TAGS ('dbx_value_regex' = 'continuous|daily|weekly|monthly|annual');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control` ALTER COLUMN `last_audit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control` ALTER COLUMN `last_test_date` SET TAGS ('dbx_business_glossary_term' = 'Last Test Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control` ALTER COLUMN `last_test_result` SET TAGS ('dbx_business_glossary_term' = 'Last Test Result');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control` ALTER COLUMN `last_test_result` SET TAGS ('dbx_value_regex' = 'pass|fail|partial|not_tested');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control` ALTER COLUMN `next_test_due` SET TAGS ('dbx_business_glossary_term' = 'Next Test Due Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Control Notes');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Control Owner');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control` ALTER COLUMN `remediation_action` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control` ALTER COLUMN `reporting_requirement` SET TAGS ('dbx_business_glossary_term' = 'Reporting Requirement');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control` ALTER COLUMN `risk_tier` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Control Version');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` SET TAGS ('dbx_subdomain' = 'audit_management');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` ALTER COLUMN `control_test_id` SET TAGS ('dbx_business_glossary_term' = 'Control Test ID');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` ALTER COLUMN `control_id` SET TAGS ('dbx_business_glossary_term' = 'Control ID');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` ALTER COLUMN `tester_id` SET TAGS ('dbx_business_glossary_term' = 'Tester ID');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` ALTER COLUMN `retest_of_control_test_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` ALTER COLUMN `audit_evidence_required` SET TAGS ('dbx_business_glossary_term' = 'Audit Evidence Required');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` ALTER COLUMN `audit_evidence_url` SET TAGS ('dbx_business_glossary_term' = 'Audit Evidence URL');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_value_regex' = 'SOC2|PCI_DSS|GDPR|CCPA|SOX');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending|exempt');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` ALTER COLUMN `data_classification` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` ALTER COLUMN `deficiencies` SET TAGS ('dbx_business_glossary_term' = 'Identified Deficiencies');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` ALTER COLUMN `evidence_url` SET TAGS ('dbx_business_glossary_term' = 'Evidence URL');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` ALTER COLUMN `execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test Execution Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` ALTER COLUMN `is_automated` SET TAGS ('dbx_business_glossary_term' = 'Is Automated');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` ALTER COLUMN `last_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Review Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` ALTER COLUMN `management_response` SET TAGS ('dbx_business_glossary_term' = 'Management Response');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` ALTER COLUMN `next_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Next Review Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Test Notes');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` ALTER COLUMN `result_score` SET TAGS ('dbx_business_glossary_term' = 'Result Score');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (Days)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` ALTER COLUMN `retest_date` SET TAGS ('dbx_business_glossary_term' = 'Retest Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` ALTER COLUMN `test_category` SET TAGS ('dbx_business_glossary_term' = 'Test Category');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` ALTER COLUMN `test_category` SET TAGS ('dbx_value_regex' = 'security|privacy|financial|operational|regulatory');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` ALTER COLUMN `test_code` SET TAGS ('dbx_business_glossary_term' = 'Control Test Code');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` ALTER COLUMN `test_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Test Duration (Seconds)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` ALTER COLUMN `test_environment` SET TAGS ('dbx_business_glossary_term' = 'Test Environment');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` ALTER COLUMN `test_environment` SET TAGS ('dbx_value_regex' = 'production|staging|development|test');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` ALTER COLUMN `test_methodology` SET TAGS ('dbx_business_glossary_term' = 'Test Methodology');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` ALTER COLUMN `test_name` SET TAGS ('dbx_business_glossary_term' = 'Control Test Name');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` ALTER COLUMN `test_result` SET TAGS ('dbx_business_glossary_term' = 'Test Result');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` ALTER COLUMN `test_result` SET TAGS ('dbx_value_regex' = 'effective|ineffective|partially_effective');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` ALTER COLUMN `test_scope` SET TAGS ('dbx_business_glossary_term' = 'Test Scope');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` ALTER COLUMN `test_status` SET TAGS ('dbx_business_glossary_term' = 'Control Test Status');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` ALTER COLUMN `test_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|failed');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Control Test Type');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'design_effectiveness|operating_effectiveness|walkthrough|automated_monitoring');
ALTER TABLE `ecommerce_ecm`.`compliance`.`control_test` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`vendor_compliance_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`compliance`.`vendor_compliance_assessment` SET TAGS ('dbx_subdomain' = 'regulatory_governance');
ALTER TABLE `ecommerce_ecm`.`compliance`.`vendor_compliance_assessment` ALTER COLUMN `vendor_compliance_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Compliance Assessment ID');
ALTER TABLE `ecommerce_ecm`.`compliance`.`vendor_compliance_assessment` ALTER COLUMN `data_processing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Data Processing Agreement ID');
ALTER TABLE `ecommerce_ecm`.`compliance`.`vendor_compliance_assessment` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`vendor_compliance_assessment` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `ecommerce_ecm`.`compliance`.`vendor_compliance_assessment` ALTER COLUMN `previous_vendor_compliance_assessment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`vendor_compliance_assessment` ALTER COLUMN `assessment_conducted_by` SET TAGS ('dbx_business_glossary_term' = 'Assessment Conducted By');
ALTER TABLE `ecommerce_ecm`.`compliance`.`vendor_compliance_assessment` ALTER COLUMN `assessment_conducted_by_contact` SET TAGS ('dbx_business_glossary_term' = 'Assessor Contact Email');
ALTER TABLE `ecommerce_ecm`.`compliance`.`vendor_compliance_assessment` ALTER COLUMN `assessment_conducted_by_contact` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `ecommerce_ecm`.`compliance`.`vendor_compliance_assessment` ALTER COLUMN `assessment_conducted_by_contact` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`vendor_compliance_assessment` ALTER COLUMN `assessment_conducted_by_contact` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`vendor_compliance_assessment` ALTER COLUMN `assessment_conducted_by_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Assessor Contact Phone');
ALTER TABLE `ecommerce_ecm`.`compliance`.`vendor_compliance_assessment` ALTER COLUMN `assessment_conducted_by_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`vendor_compliance_assessment` ALTER COLUMN `assessment_conducted_by_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`vendor_compliance_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_business_glossary_term' = 'Assessment Number');
ALTER TABLE `ecommerce_ecm`.`compliance`.`vendor_compliance_assessment` ALTER COLUMN `assessment_outcome` SET TAGS ('dbx_business_glossary_term' = 'Assessment Outcome');
ALTER TABLE `ecommerce_ecm`.`compliance`.`vendor_compliance_assessment` ALTER COLUMN `assessment_outcome` SET TAGS ('dbx_value_regex' = 'compliant|conditionally_compliant|non_compliant');
ALTER TABLE `ecommerce_ecm`.`compliance`.`vendor_compliance_assessment` ALTER COLUMN `assessment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assessment Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`vendor_compliance_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `ecommerce_ecm`.`compliance`.`vendor_compliance_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'questionnaire|on_site_audit|certification_review');
ALTER TABLE `ecommerce_ecm`.`compliance`.`vendor_compliance_assessment` ALTER COLUMN `compliance_frameworks` SET TAGS ('dbx_business_glossary_term' = 'Compliance Frameworks');
ALTER TABLE `ecommerce_ecm`.`compliance`.`vendor_compliance_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`vendor_compliance_assessment` ALTER COLUMN `critical_findings` SET TAGS ('dbx_business_glossary_term' = 'Critical Findings');
ALTER TABLE `ecommerce_ecm`.`compliance`.`vendor_compliance_assessment` ALTER COLUMN `dpa_status` SET TAGS ('dbx_business_glossary_term' = 'Data Processing Agreement Status');
ALTER TABLE `ecommerce_ecm`.`compliance`.`vendor_compliance_assessment` ALTER COLUMN `dpa_status` SET TAGS ('dbx_value_regex' = 'signed|pending|not_required');
ALTER TABLE `ecommerce_ecm`.`compliance`.`vendor_compliance_assessment` ALTER COLUMN `evidence_documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Evidence Documentation URL');
ALTER TABLE `ecommerce_ecm`.`compliance`.`vendor_compliance_assessment` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Country Code');
ALTER TABLE `ecommerce_ecm`.`compliance`.`vendor_compliance_assessment` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`compliance`.`vendor_compliance_assessment` ALTER COLUMN `next_assessment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Assessment Due Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`vendor_compliance_assessment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Notes');
ALTER TABLE `ecommerce_ecm`.`compliance`.`vendor_compliance_assessment` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `ecommerce_ecm`.`compliance`.`vendor_compliance_assessment` ALTER COLUMN `remediation_requirements` SET TAGS ('dbx_business_glossary_term' = 'Remediation Requirements');
ALTER TABLE `ecommerce_ecm`.`compliance`.`vendor_compliance_assessment` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `ecommerce_ecm`.`compliance`.`vendor_compliance_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`vendor_compliance_assessment` ALTER COLUMN `vendor_compliance_assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `ecommerce_ecm`.`compliance`.`vendor_compliance_assessment` ALTER COLUMN `vendor_compliance_assessment_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|failed');
ALTER TABLE `ecommerce_ecm`.`compliance`.`vendor_compliance_assessment` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `ecommerce_ecm`.`compliance`.`consent_policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`compliance`.`consent_policy` SET TAGS ('dbx_subdomain' = 'regulatory_governance');
ALTER TABLE `ecommerce_ecm`.`compliance`.`consent_policy` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy ID');
ALTER TABLE `ecommerce_ecm`.`compliance`.`consent_policy` ALTER COLUMN `regulation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`consent_policy` ALTER COLUMN `superseded_consent_policy_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`consent_policy` ALTER COLUMN `audit_evidence_required` SET TAGS ('dbx_business_glossary_term' = 'Audit Evidence Required');
ALTER TABLE `ecommerce_ecm`.`compliance`.`consent_policy` ALTER COLUMN `compliance_evidence_url` SET TAGS ('dbx_business_glossary_term' = 'Compliance Evidence URL');
ALTER TABLE `ecommerce_ecm`.`compliance`.`consent_policy` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `ecommerce_ecm`.`compliance`.`consent_policy` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|partial|under_review');
ALTER TABLE `ecommerce_ecm`.`compliance`.`consent_policy` ALTER COLUMN `consent_policy_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Status');
ALTER TABLE `ecommerce_ecm`.`compliance`.`consent_policy` ALTER COLUMN `consent_policy_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired|draft');
ALTER TABLE `ecommerce_ecm`.`compliance`.`consent_policy` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `ecommerce_ecm`.`compliance`.`consent_policy` ALTER COLUMN `consent_type` SET TAGS ('dbx_value_regex' = 'marketing_email|sms|push_notification|cookie_analytics|cookie_advertising|profiling');
ALTER TABLE `ecommerce_ecm`.`compliance`.`consent_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`consent_policy` ALTER COLUMN `data_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period (Days)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`consent_policy` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`consent_policy` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`consent_policy` ALTER COLUMN `granularity_level` SET TAGS ('dbx_business_glossary_term' = 'Consent Granularity Level');
ALTER TABLE `ecommerce_ecm`.`compliance`.`consent_policy` ALTER COLUMN `granularity_level` SET TAGS ('dbx_value_regex' = 'global|category|item|purpose');
ALTER TABLE `ecommerce_ecm`.`compliance`.`consent_policy` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Is Default');
ALTER TABLE `ecommerce_ecm`.`compliance`.`consent_policy` ALTER COLUMN `is_required` SET TAGS ('dbx_business_glossary_term' = 'Is Required');
ALTER TABLE `ecommerce_ecm`.`compliance`.`consent_policy` ALTER COLUMN `last_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Review Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`consent_policy` ALTER COLUMN `mechanism` SET TAGS ('dbx_business_glossary_term' = 'Consent Mechanism');
ALTER TABLE `ecommerce_ecm`.`compliance`.`consent_policy` ALTER COLUMN `mechanism` SET TAGS ('dbx_value_regex' = 'opt_in|opt_out|double_opt_in');
ALTER TABLE `ecommerce_ecm`.`compliance`.`consent_policy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `ecommerce_ecm`.`compliance`.`consent_policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Code');
ALTER TABLE `ecommerce_ecm`.`compliance`.`consent_policy` ALTER COLUMN `policy_description` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Description');
ALTER TABLE `ecommerce_ecm`.`compliance`.`consent_policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Name');
ALTER TABLE `ecommerce_ecm`.`compliance`.`consent_policy` ALTER COLUMN `policy_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Version');
ALTER TABLE `ecommerce_ecm`.`compliance`.`consent_policy` ALTER COLUMN `review_cycle` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle');
ALTER TABLE `ecommerce_ecm`.`compliance`.`consent_policy` ALTER COLUMN `review_cycle` SET TAGS ('dbx_value_regex' = 'annual|biannual|quarterly|monthly|ad_hoc');
ALTER TABLE `ecommerce_ecm`.`compliance`.`consent_policy` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`compliance`.`consent_policy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`consent_policy` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `ecommerce_ecm`.`compliance`.`retention_policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`compliance`.`retention_policy` SET TAGS ('dbx_subdomain' = 'regulatory_governance');
ALTER TABLE `ecommerce_ecm`.`compliance`.`retention_policy` ALTER COLUMN `retention_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy ID');
ALTER TABLE `ecommerce_ecm`.`compliance`.`retention_policy` ALTER COLUMN `regulation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`retention_policy` ALTER COLUMN `superseded_retention_policy_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`retention_policy` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `ecommerce_ecm`.`compliance`.`retention_policy` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|partial|under_review');
ALTER TABLE `ecommerce_ecm`.`compliance`.`retention_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`retention_policy` ALTER COLUMN `data_category` SET TAGS ('dbx_business_glossary_term' = 'Data Category');
ALTER TABLE `ecommerce_ecm`.`compliance`.`retention_policy` ALTER COLUMN `data_category` SET TAGS ('dbx_value_regex' = 'customer_pii|order_record|payment_data|behavioral_data|marketing_data|audit_log');
ALTER TABLE `ecommerce_ecm`.`compliance`.`retention_policy` ALTER COLUMN `data_sensitivity_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Sensitivity Classification');
ALTER TABLE `ecommerce_ecm`.`compliance`.`retention_policy` ALTER COLUMN `data_sensitivity_classification` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `ecommerce_ecm`.`compliance`.`retention_policy` ALTER COLUMN `deletion_method` SET TAGS ('dbx_business_glossary_term' = 'Deletion Method');
ALTER TABLE `ecommerce_ecm`.`compliance`.`retention_policy` ALTER COLUMN `deletion_method` SET TAGS ('dbx_value_regex' = 'anonymization|pseudonymization|hard_delete|archival');
ALTER TABLE `ecommerce_ecm`.`compliance`.`retention_policy` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`retention_policy` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`retention_policy` ALTER COLUMN `maximum_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Maximum Retention Period (Days)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`retention_policy` ALTER COLUMN `minimum_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Minimum Retention Period (Days)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`retention_policy` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`retention_policy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `ecommerce_ecm`.`compliance`.`retention_policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy Code');
ALTER TABLE `ecommerce_ecm`.`compliance`.`retention_policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy Name');
ALTER TABLE `ecommerce_ecm`.`compliance`.`retention_policy` ALTER COLUMN `policy_owner` SET TAGS ('dbx_business_glossary_term' = 'Policy Owner');
ALTER TABLE `ecommerce_ecm`.`compliance`.`retention_policy` ALTER COLUMN `retention_action` SET TAGS ('dbx_business_glossary_term' = 'Retention Action');
ALTER TABLE `ecommerce_ecm`.`compliance`.`retention_policy` ALTER COLUMN `retention_action` SET TAGS ('dbx_value_regex' = 'anonymize|pseudonymize|delete|archive');
ALTER TABLE `ecommerce_ecm`.`compliance`.`retention_policy` ALTER COLUMN `retention_audit_log_reference` SET TAGS ('dbx_business_glossary_term' = 'Retention Audit Log Reference');
ALTER TABLE `ecommerce_ecm`.`compliance`.`retention_policy` ALTER COLUMN `retention_basis` SET TAGS ('dbx_business_glossary_term' = 'Retention Basis');
ALTER TABLE `ecommerce_ecm`.`compliance`.`retention_policy` ALTER COLUMN `retention_basis` SET TAGS ('dbx_value_regex' = 'legal_obligation|legitimate_interest|contractual|regulatory');
ALTER TABLE `ecommerce_ecm`.`compliance`.`retention_policy` ALTER COLUMN `retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiry Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`retention_policy` ALTER COLUMN `retention_extension_allowed` SET TAGS ('dbx_business_glossary_term' = 'Retention Extension Allowed');
ALTER TABLE `ecommerce_ecm`.`compliance`.`retention_policy` ALTER COLUMN `retention_extension_justification` SET TAGS ('dbx_business_glossary_term' = 'Retention Extension Justification');
ALTER TABLE `ecommerce_ecm`.`compliance`.`retention_policy` ALTER COLUMN `retention_policy_status` SET TAGS ('dbx_business_glossary_term' = 'Policy Status');
ALTER TABLE `ecommerce_ecm`.`compliance`.`retention_policy` ALTER COLUMN `retention_policy_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `ecommerce_ecm`.`compliance`.`retention_policy` ALTER COLUMN `retention_reason` SET TAGS ('dbx_business_glossary_term' = 'Retention Reason');
ALTER TABLE `ecommerce_ecm`.`compliance`.`retention_policy` ALTER COLUMN `retention_review_owner` SET TAGS ('dbx_business_glossary_term' = 'Retention Review Owner');
ALTER TABLE `ecommerce_ecm`.`compliance`.`retention_policy` ALTER COLUMN `retention_review_status` SET TAGS ('dbx_business_glossary_term' = 'Retention Review Status');
ALTER TABLE `ecommerce_ecm`.`compliance`.`retention_policy` ALTER COLUMN `retention_review_status` SET TAGS ('dbx_value_regex' = 'completed|overdue|in_progress|not_started');
ALTER TABLE `ecommerce_ecm`.`compliance`.`retention_policy` ALTER COLUMN `retention_trigger_event` SET TAGS ('dbx_business_glossary_term' = 'Retention Trigger Event');
ALTER TABLE `ecommerce_ecm`.`compliance`.`retention_policy` ALTER COLUMN `retention_type` SET TAGS ('dbx_business_glossary_term' = 'Retention Type');
ALTER TABLE `ecommerce_ecm`.`compliance`.`retention_policy` ALTER COLUMN `retention_type` SET TAGS ('dbx_value_regex' = 'legal|contractual|policy');
ALTER TABLE `ecommerce_ecm`.`compliance`.`retention_policy` ALTER COLUMN `review_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle (Months)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`retention_policy` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy Source System');
ALTER TABLE `ecommerce_ecm`.`compliance`.`retention_policy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`retention_policy` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy Version');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training` SET TAGS ('dbx_subdomain' = 'compliance_training');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training` ALTER COLUMN `training_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Training ID');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training` ALTER COLUMN `regulation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training` ALTER COLUMN `prerequisite_training_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training` ALTER COLUMN `audit_evidence_url` SET TAGS ('dbx_business_glossary_term' = 'Audit Evidence URL (AEU)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date (CED)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training` ALTER COLUMN `certification_required` SET TAGS ('dbx_business_glossary_term' = 'Certification Required (CR)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training` ALTER COLUMN `compliance_evidence_required` SET TAGS ('dbx_business_glossary_term' = 'Compliance Evidence Required (CER)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training` ALTER COLUMN `cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Training Cost (USD) (TC)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp (CT)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training` ALTER COLUMN `delivery_format` SET TAGS ('dbx_business_glossary_term' = 'Delivery Format (DF)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training` ALTER COLUMN `delivery_format` SET TAGS ('dbx_value_regex' = 'e_learning|instructor_led|video|blended');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Training Duration (Minutes)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (ED)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (EXD)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training` ALTER COLUMN `external_provider` SET TAGS ('dbx_business_glossary_term' = 'External Provider (EP)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Language (L)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training` ALTER COLUMN `language` SET TAGS ('dbx_value_regex' = 'en|es|fr|de|zh|ja');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date (LRD)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag (MF)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date (NRD)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (N)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training` ALTER COLUMN `passing_score_percent` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Percentage (PSP)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training` ALTER COLUMN `recurrence_requirement` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Requirement (RR)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training` ALTER COLUMN `recurrence_requirement` SET TAGS ('dbx_value_regex' = 'annual|one_time|role_change|periodic|onboarding');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (Days) (RP)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience (TA)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training` ALTER COLUMN `training_code` SET TAGS ('dbx_business_glossary_term' = 'Training Code (TC)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training` ALTER COLUMN `training_name` SET TAGS ('dbx_business_glossary_term' = 'Training Name (TN)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training` ALTER COLUMN `training_status` SET TAGS ('dbx_business_glossary_term' = 'Training Status (TS)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training` ALTER COLUMN `training_status` SET TAGS ('dbx_value_regex' = 'active|retired|draft|pending|archived');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training` ALTER COLUMN `training_type` SET TAGS ('dbx_business_glossary_term' = 'Training Type (TT)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training` ALTER COLUMN `training_type` SET TAGS ('dbx_value_regex' = 'gdpr_awareness|pci_dss_security|anti_bribery|consumer_protection|data_handling|other');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp (UT)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number (VN)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training_completion` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training_completion` SET TAGS ('dbx_subdomain' = 'compliance_training');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training_completion` ALTER COLUMN `training_completion_id` SET TAGS ('dbx_business_glossary_term' = 'Training Completion ID');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training_completion` ALTER COLUMN `training_id` SET TAGS ('dbx_business_glossary_term' = 'Training Program Identifier');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training_completion` ALTER COLUMN `retake_of_training_completion_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training_completion` ALTER COLUMN `assessment_max_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Maximum Score');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training_completion` ALTER COLUMN `assessment_pass_threshold` SET TAGS ('dbx_business_glossary_term' = 'Assessment Pass Threshold');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training_completion` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training_completion` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training_completion` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'quiz|exam|simulation');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training_completion` ALTER COLUMN `assigned_date` SET TAGS ('dbx_business_glossary_term' = 'Assigned Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training_completion` ALTER COLUMN `certificate_reference` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Completion Reference');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training_completion` ALTER COLUMN `certificate_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training_completion` ALTER COLUMN `certificate_reference` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training_completion` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training_completion` ALTER COLUMN `compliance_requirement` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training_completion` ALTER COLUMN `compliance_requirement` SET TAGS ('dbx_value_regex' = 'GDPR|PCI_DSS|SOX|CCPA|HIPAA|OTHER');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training_completion` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training_completion` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training_completion` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training_completion` ALTER COLUMN `evidence_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Evidence Document Reference');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training_completion` ALTER COLUMN `evidence_document_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training_completion` ALTER COLUMN `evidence_document_reference` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training_completion` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training_completion` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory Training');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training_completion` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Training Language');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training_completion` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Training Location');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training_completion` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training_completion` ALTER COLUMN `pass_fail` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Outcome');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training_completion` ALTER COLUMN `pass_fail` SET TAGS ('dbx_value_regex' = 'pass|fail');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training_completion` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training_completion` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training_completion` ALTER COLUMN `training_completion_code` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Code');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training_completion` ALTER COLUMN `training_completion_status` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Status');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training_completion` ALTER COLUMN `training_completion_status` SET TAGS ('dbx_value_regex' = 'assigned|in_progress|completed|overdue|waived');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training_completion` ALTER COLUMN `training_method` SET TAGS ('dbx_business_glossary_term' = 'Training Delivery Method');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training_completion` ALTER COLUMN `training_method` SET TAGS ('dbx_value_regex' = 'online|in_person|virtual_classroom|self_paced');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training_completion` ALTER COLUMN `training_program_name` SET TAGS ('dbx_business_glossary_term' = 'Training Program Name');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training_completion` ALTER COLUMN `training_version` SET TAGS ('dbx_business_glossary_term' = 'Training Version');
ALTER TABLE `ecommerce_ecm`.`compliance`.`training_completion` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulatory_change` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulatory_change` SET TAGS ('dbx_subdomain' = 'regulatory_governance');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `regulatory_change_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change ID');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `regulation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulation ID');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `amends_regulatory_change_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `audit_evidence_required` SET TAGS ('dbx_business_glossary_term' = 'Audit Evidence Required');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `business_areas_impacted` SET TAGS ('dbx_business_glossary_term' = 'Business Areas Impacted');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `change_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change Status');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `change_status` SET TAGS ('dbx_value_regex' = 'monitoring|impact_assessed|response_planned|implemented|closed');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `change_type` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change Type');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `change_type` SET TAGS ('dbx_value_regex' = 'new_regulation|amendment|enforcement_guidance|court_ruling|authority_decision');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `impact_assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment Status');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `impact_assessment_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction (ISO 3166-1 alpha-3 country code)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `regulatory_change_description` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change Description');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `required_response_actions` SET TAGS ('dbx_business_glossary_term' = 'Required Response Actions');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `response_deadline` SET TAGS ('dbx_business_glossary_term' = 'Response Deadline');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `risk_tier` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `source_url` SET TAGS ('dbx_business_glossary_term' = 'Source URL');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change Title');
ALTER TABLE `ecommerce_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`compliance_exception` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`compliance`.`compliance_exception` SET TAGS ('dbx_subdomain' = 'regulatory_governance');
ALTER TABLE `ecommerce_ecm`.`compliance`.`compliance_exception` ALTER COLUMN `compliance_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Exception ID');
ALTER TABLE `ecommerce_ecm`.`compliance`.`compliance_exception` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`compliance_exception` ALTER COLUMN `renewed_from_compliance_exception_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`compliance_exception` ALTER COLUMN `affected_policy` SET TAGS ('dbx_business_glossary_term' = 'Affected Policy');
ALTER TABLE `ecommerce_ecm`.`compliance`.`compliance_exception` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`compliance_exception` ALTER COLUMN `approving_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority Name');
ALTER TABLE `ecommerce_ecm`.`compliance`.`compliance_exception` ALTER COLUMN `approving_authority_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`compliance_exception` ALTER COLUMN `approving_authority_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`compliance_exception` ALTER COLUMN `business_event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Business Event Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`compliance_exception` ALTER COLUMN `business_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `ecommerce_ecm`.`compliance`.`compliance_exception` ALTER COLUMN `compensating_controls` SET TAGS ('dbx_business_glossary_term' = 'Compensating Controls');
ALTER TABLE `ecommerce_ecm`.`compliance`.`compliance_exception` ALTER COLUMN `compliance_exception_status` SET TAGS ('dbx_business_glossary_term' = 'Exception Status');
ALTER TABLE `ecommerce_ecm`.`compliance`.`compliance_exception` ALTER COLUMN `compliance_exception_status` SET TAGS ('dbx_value_regex' = 'pending-approval|approved|expired|revoked');
ALTER TABLE `ecommerce_ecm`.`compliance`.`compliance_exception` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`compliance_exception` ALTER COLUMN `exception_number` SET TAGS ('dbx_business_glossary_term' = 'Exception Number');
ALTER TABLE `ecommerce_ecm`.`compliance`.`compliance_exception` ALTER COLUMN `exception_type` SET TAGS ('dbx_business_glossary_term' = 'Exception Type');
ALTER TABLE `ecommerce_ecm`.`compliance`.`compliance_exception` ALTER COLUMN `exception_type` SET TAGS ('dbx_value_regex' = 'policy|control|regulatory');
ALTER TABLE `ecommerce_ecm`.`compliance`.`compliance_exception` ALTER COLUMN `expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Exception Expiry Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`compliance_exception` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Exception Notes');
ALTER TABLE `ecommerce_ecm`.`compliance`.`compliance_exception` ALTER COLUMN `remediation_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan Reference');
ALTER TABLE `ecommerce_ecm`.`compliance`.`compliance_exception` ALTER COLUMN `requestor_name` SET TAGS ('dbx_business_glossary_term' = 'Requestor Name');
ALTER TABLE `ecommerce_ecm`.`compliance`.`compliance_exception` ALTER COLUMN `requestor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`compliance_exception` ALTER COLUMN `requestor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`compliance_exception` ALTER COLUMN `risk_acceptance_rationale` SET TAGS ('dbx_business_glossary_term' = 'Risk Acceptance Rationale');
ALTER TABLE `ecommerce_ecm`.`compliance`.`compliance_exception` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `ecommerce_ecm`.`compliance`.`compliance_exception` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `ecommerce_ecm`.`compliance`.`compliance_exception` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Exception Start Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`compliance_exception` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Exception Title');
ALTER TABLE `ecommerce_ecm`.`compliance`.`compliance_exception` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` SET TAGS ('dbx_subdomain' = 'regulatory_governance');
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` ALTER COLUMN `supervisory_correspondence_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Correspondence ID');
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Linked Compliance Program ID');
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` ALTER COLUMN `in_reply_to_supervisory_correspondence_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` ALTER COLUMN `associated_regulation_code` SET TAGS ('dbx_business_glossary_term' = 'Associated Regulation Code');
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` ALTER COLUMN `attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Attachment Count');
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` ALTER COLUMN `audit_evidence_url` SET TAGS ('dbx_business_glossary_term' = 'Audit Evidence URL');
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` ALTER COLUMN `audit_log_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Log Reference');
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` ALTER COLUMN `authority_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Name');
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` ALTER COLUMN `authority_type` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Type');
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` ALTER COLUMN `authority_type` SET TAGS ('dbx_value_regex' = 'dpa|pci_ssc|ftc|cfpb|national_consumer_authority');
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` ALTER COLUMN `communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Communication Channel');
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` ALTER COLUMN `communication_channel` SET TAGS ('dbx_value_regex' = 'email|phone|portal|mail');
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline');
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending|exempt');
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` ALTER COLUMN `correspondence_type` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Type');
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` ALTER COLUMN `correspondence_type` SET TAGS ('dbx_value_regex' = 'inquiry|investigation_notice|enforcement_action|voluntary_disclosure|response_submission|approval_request');
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` ALTER COLUMN `data_protection_level` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Level');
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` ALTER COLUMN `data_protection_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` ALTER COLUMN `evidence_attached_flag` SET TAGS ('dbx_business_glossary_term' = 'Evidence Attached Flag');
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` ALTER COLUMN `follow_up_due_date` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Due Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` ALTER COLUMN `follow_up_required` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Required');
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` ALTER COLUMN `last_response_date` SET TAGS ('dbx_business_glossary_term' = 'Last Response Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Notes');
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Priority');
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Reference Number');
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` ALTER COLUMN `response_deadline` SET TAGS ('dbx_business_glossary_term' = 'Response Deadline');
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` ALTER COLUMN `response_method` SET TAGS ('dbx_business_glossary_term' = 'Response Method');
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` ALTER COLUMN `response_method` SET TAGS ('dbx_value_regex' = 'email|portal|postal|fax|phone');
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` ALTER COLUMN `response_outcome` SET TAGS ('dbx_business_glossary_term' = 'Response Outcome');
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` ALTER COLUMN `response_outcome` SET TAGS ('dbx_value_regex' = 'accepted|rejected|pending|partial|withdrawn');
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` ALTER COLUMN `response_submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Response Submitted Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` ALTER COLUMN `response_summary` SET TAGS ('dbx_business_glossary_term' = 'Response Summary');
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (Days)');
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier');
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` ALTER COLUMN `risk_tier` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` ALTER COLUMN `supervisory_correspondence_status` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Status');
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` ALTER COLUMN `supervisory_correspondence_status` SET TAGS ('dbx_value_regex' = 'received|acknowledged|response_submitted|closed|escalated');
ALTER TABLE `ecommerce_ecm`.`compliance`.`supervisory_correspondence` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`compliance`.`tester` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`compliance`.`tester` SET TAGS ('dbx_subdomain' = 'audit_management');
ALTER TABLE `ecommerce_ecm`.`compliance`.`tester` ALTER COLUMN `tester_id` SET TAGS ('dbx_business_glossary_term' = 'Tester Identifier');
ALTER TABLE `ecommerce_ecm`.`compliance`.`tester` ALTER COLUMN `supervised_by_tester_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`data_processing_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`compliance`.`data_processing_agreement` SET TAGS ('dbx_subdomain' = 'regulatory_governance');
ALTER TABLE `ecommerce_ecm`.`compliance`.`data_processing_agreement` ALTER COLUMN `data_processing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Data Processing Agreement Identifier');
ALTER TABLE `ecommerce_ecm`.`compliance`.`data_processing_agreement` ALTER COLUMN `superseded_data_processing_agreement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`data_processing_agreement` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`data_processing_agreement` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`data_processing_agreement` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`compliance`.`data_processing_agreement` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
