-- Schema for Domain: compliance | Business: Health Insurance | Version: v1_mvm
-- Generated on: 2026-05-03 21:25:44

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `health_insurance_ecm`.`compliance` COMMENT 'Manages regulatory compliance obligations — HIPAA privacy and security (OCR), ACA market conduct, CMS audit readiness, state DOI filings, NCQA/URAC accreditation, SOC reporting, fraud waste and abuse (FWA) monitoring, and PHI breach notification. Owns regulatory submission calendars, audit findings, corrective action plans (CAPs), compliance attestations, and MLR compliance tracking. Supports ERISA filings and state fair hearing coordination.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `health_insurance_ecm`.`compliance`.`regulatory_obligation` (
    `regulatory_obligation_id` BIGINT COMMENT 'System-generated unique identifier for the regulatory obligation record.',
    `audit_findings` STRING COMMENT 'Summary of audit observations related to the obligation.',
    `compliance_regulatory_obligation_description` STRING COMMENT 'Full textual description of the regulatory obligation.',
    `compliance_regulatory_obligation_status` STRING COMMENT 'Lifecycle status of the regulatory obligation record.. Valid values are `active|inactive|retired|draft`',
    `compliance_status` STRING COMMENT 'Current compliance state of the obligation.. Valid values are `compliant|non-compliant|pending|exempt`',
    `corrective_action_plan` STRING COMMENT 'Planned actions to remediate any compliance gaps.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created.',
    `effective_date` DATE COMMENT 'Date the obligation becomes effective.',
    `exemption_allowed` BOOLEAN COMMENT 'Indicates whether an exemption from the obligation is possible.',
    `exemption_criteria` STRING COMMENT 'Conditions under which an exemption may be granted.',
    `expiration_date` DATE COMMENT 'Date the obligation expires or is superseded (nullable).',
    `filing_status` STRING COMMENT 'Current status of required filings.. Valid values are `filed|not_filed|pending|waived`',
    `frequency` STRING COMMENT 'How often the obligation must be satisfied.. Valid values are `annual|quarterly|monthly|one-time|as-needed`',
    `governing_body` STRING COMMENT 'Regulatory authority that issues the obligation (e.g., CMS, OCR, NAIC, State DOI).',
    `is_federal` BOOLEAN COMMENT 'True if the obligation applies at the federal level.',
    `is_state_specific` BOOLEAN COMMENT 'True if the obligation is limited to a particular state.',
    `jurisdiction` STRING COMMENT 'Geographic scope of the obligation (state, province, or federal).',
    `last_assessment_date` DATE COMMENT 'Date of the most recent compliance assessment.',
    `last_modified_by` STRING COMMENT 'User or process that performed the most recent update.',
    `next_due_date` DATE COMMENT 'Date the next compliance action is required.',
    `notes` STRING COMMENT 'Additional free‑form comments or observations.',
    `obligation_code` STRING COMMENT 'Business identifier code assigned to the regulatory obligation.',
    `obligation_type` STRING COMMENT 'Category of the regulatory requirement.. Valid values are `privacy|security|financial|reporting|accreditation|operational`',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty for non‑compliance.',
    `penalty_currency` STRING COMMENT 'Currency of the penalty amount.. Valid values are `USD|EUR|GBP`',
    `reference_url` STRING COMMENT 'Link to the official regulation or guidance document.',
    `regulatory_framework` STRING COMMENT 'Framework or statute under which the obligation falls (e.g., HIPAA, ACA, Medicare, State Law).',
    `reporting_frequency_months` STRING COMMENT 'Number of months between required reports.',
    `risk_impact` STRING COMMENT 'Potential business impact if the obligation is not met.. Valid values are `low|medium|high|critical`',
    `risk_likelihood` STRING COMMENT 'Likelihood of non‑compliance occurring.. Valid values are `low|medium|high|critical`',
    `risk_score` DECIMAL(18,2) COMMENT 'Calculated risk score (likelihood × impact).',
    `source_system` STRING COMMENT 'Originating operational system that supplied the obligation data.',
    `submission_deadline` DATE COMMENT 'Final date for filing required reports or documents.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `version_number` STRING COMMENT 'Version of the obligation definition for change tracking.',
    CONSTRAINT pk_regulatory_obligation PRIMARY KEY(`regulatory_obligation_id`)
) COMMENT 'Master record for each regulatory obligation the health plan must fulfill — HIPAA Privacy/Security Rules, ACA market conduct requirements, CMS Medicare/Medicaid mandates, state DOI filings, NCQA/URAC accreditation standards, ERISA requirements, SOC reporting obligations, and state Medicaid fair hearing compliance. Captures the governing body, regulatory framework, obligation type, effective date, jurisdiction, frequency, accountable business owner, compliance status, and obligation risk score (likelihood × impact of non-compliance). Includes tracking of state fair hearing obligations for Medicaid adverse benefit determinations under 42 CFR §438.400. Serves as the authoritative registry of all compliance requirements and the anchor entity linking to submissions, attestations, policies, and corrective actions that demonstrate adherence.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`compliance`.`regulatory_submission` (
    `regulatory_submission_id` BIGINT COMMENT 'System-generated unique identifier for each regulatory submission record.',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: ACA SBC filings, state DOI benefit package submissions, and ERISA filings are scoped to specific benefit packages. Regulators require benefit-package-level submission tracking. A health insurance comp',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.employer_group. Business justification: Regulatory Submission: submissions are filed on behalf of an employer group, needed for tracking filing status per group.',
    `group_renewal_id` BIGINT COMMENT 'Foreign key linking to employer.group_renewal. Business justification: Group renewals trigger specific regulatory filings (rate filings, form filings, state DOI submissions). Linking regulatory_submission to employer.group_renewal enables tracking which renewal cycle dro',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Regulatory submissions (e.g., CMS filing) are made for a particular health plan; linking enables tracking submission status per plan.',
    `provider_contract_id` BIGINT COMMENT 'Foreign key linking to contract.provider_contract. Business justification: Required: Certain regulatory submissions (e.g., network participation filings) are made per contract and must be tracked.',
    `rate_id` BIGINT COMMENT 'Foreign key linking to plan.rate. Business justification: Rate filings (SERFF submissions, state DOI rate approvals, ACA rate review filings) are a primary regulatory submission type. Linking the submission to the specific rate being filed is essential for r',
    `rate_schedule_id` BIGINT COMMENT 'Foreign key linking to billing.rate_schedule. Business justification: State DOI rate filing submissions directly reference the rate schedule being filed for approval. This FK links each regulatory submission to the specific rate schedule submitted, supporting rate filin',
    `regulatory_obligation_id` BIGINT COMMENT 'Link to the specific regulatory requirement that this submission satisfies.',
    `vbc_contract_id` BIGINT COMMENT 'Foreign key linking to contract.vbc_contract. Business justification: CMS ACO and VBC program participation requires specific regulatory submissions (MSSP applications, performance reports, settlement filings). Compliance teams must link submissions to VBC contracts to ',
    `acceptance_date` DATE COMMENT 'Date the regulator formally accepted the filing.',
    `attachment_count` STRING COMMENT 'Number of supporting documents attached to the submission.',
    `confirmation_number` STRING COMMENT 'Identifier returned by the regulator confirming receipt of the filing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the submission record was first created in the system.',
    `due_date` DATE COMMENT 'Deadline by which the regulatory filing must be completed.',
    `fee_currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency in which the filing fee is expressed.',
    `filing_fee_amount` DECIMAL(18,2) COMMENT 'Gross fee charged by the regulator for processing the submission.',
    `filing_period_end` DATE COMMENT 'End date of the reporting period covered by the submission.',
    `filing_period_start` DATE COMMENT 'Start date of the reporting period covered by the submission.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the filing is deemed critical for regulatory compliance (true) or routine (false).',
    `last_reminder_sent_date` DATE COMMENT 'Date the most recent reminder was sent to the responsible party.',
    `lead_time_days` STRING COMMENT 'Number of days between creation of the submission record and its due date.',
    `net_fee_amount` DECIMAL(18,2) COMMENT 'Net fee after any adjustments, discounts, or credits.',
    `regulatory_body` STRING COMMENT 'Government or accrediting entity to which the submission is made.. Valid values are `CMS|STATE_DOI|NCQA|OCR|ERISA|DOL`',
    `regulatory_submission_status` STRING COMMENT 'Current lifecycle state of the regulatory filing.. Valid values are `scheduled|draft|submitted|accepted|rejected|cancelled`',
    `rejection_reason_code` STRING COMMENT 'Standardized code indicating why a filing was rejected by the regulator.',
    `reminder_schedule` STRING COMMENT 'Human‑readable description of the reminder cadence (e.g., "30/15/5 days before due").',
    `submission_date` DATE COMMENT 'Actual calendar date the filing was submitted to the regulator.',
    `submission_description` STRING COMMENT 'Free‑text notes describing the purpose or special considerations of the filing.',
    `submission_method` STRING COMMENT 'Technical or physical channel used to deliver the filing.. Valid values are `edi|portal|paper|email`',
    `submission_number` STRING COMMENT 'External reference number assigned to the filing by the organization.',
    `submission_type` STRING COMMENT 'Category of the regulatory filing (e.g., annual notice, rate filing).. Valid values are `annual_notice|rate_filing|financial_statement|accreditation|breach_notification|mlr_report`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the submission record.',
    CONSTRAINT pk_regulatory_submission PRIMARY KEY(`regulatory_submission_id`)
) COMMENT 'Transactional record for each regulatory filing or submission — from scheduled deadline through actual filing. Captures submission type, regulatory body, due date, lead time days, reminder schedule, submission date, filing period, submission method (EDI, portal, paper), status (scheduled, draft, submitted, accepted, rejected), and confirmation identifiers. Covers CMS annual notices, state DOI rate filings, NAIC financial statements, NCQA accreditation submissions, OCR breach notifications, MLR rebate filings, ACA marketplace submissions, and ERISA filings (Form 5500, Summary Annual Report, Summary Plan Description, COBRA notices, QMCSO responses). Supports the annual regulatory calendar view used by compliance officers to manage deadlines across CMS, state DOIs, NCQA, OCR, ERISA, and DOL obligations. Links to the regulatory obligation it satisfies.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` (
    `audit_engagement_id` BIGINT COMMENT 'Unique identifier for the audit engagement record.',
    `adequacy_assessment_id` BIGINT COMMENT 'Foreign key linking to network.adequacy_assessment. Business justification: CMS ODAG and state network adequacy audits directly review adequacy assessments as primary evidence. Compliance auditors must link audit engagements to the specific adequacy assessment under review to',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: CMS program audits and state DOI audits are frequently scoped to specific benefit packages to assess EHB compliance, cost-sharing accuracy, and benefit design. A health insurance auditor would expect ',
    `broker_id` BIGINT COMMENT 'Foreign key linking to employer.broker. Business justification: State insurance departments and internal compliance teams conduct broker practice audits (commission accuracy, licensing compliance, suitability). Linking audit_engagement to employer.broker enables b',
    `delegation_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.delegation_agreement. Business justification: NCQA and URAC require health plans to conduct annual delegation audits against specific delegation agreements. Compliance teams must link audit engagements to delegation agreements to track audit freq',
    `facility_id` BIGINT COMMENT 'Foreign key linking to provider.facility. Business justification: Compliance audits are conducted against specific facilities for CMS Conditions of Participation, state facility licensing, and HIPAA security audits. Audit teams need to scope engagements to a specifi',
    `formulary_id` BIGINT COMMENT 'Foreign key linking to pharmacy.formulary. Business justification: CMS Part D formulary audits and NCQA/URAC PBM accreditation surveys directly target specific formulary versions. Audit engagements must reference the formulary under review to scope findings, track fo',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.employer_group. Business justification: Audit Management: each audit engagement is performed for a specific employer group, required for audit scheduling and reporting.',
    `group_practice_id` BIGINT COMMENT 'Foreign key linking to provider.group_practice. Business justification: Compliance audits target group practices for credentialing, billing integrity, and HEDIS data validation. Health plans conduct group-practice-level audit engagements to assess network quality and valu',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Audits verify compliance of a specific health plan; auditors need to reference the plan being audited for ACA reporting.',
    `pbm_contract_id` BIGINT COMMENT 'Foreign key linking to pharmacy.pbm_contract. Business justification: PBM contract audits (CMS, state DOI, internal) are a named, recurring business process. Health plans audit PBM contracts for rebate pass-through compliance, AWP discount guarantees, and generic dispen',
    `provider_contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract_provider_contract. Business justification: Payment accuracy audits and provider compliance audits are scoped to specific provider contracts. Health plan audit teams must link engagements to contracts for audit scoping, findings attribution, an',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: Network adequacy audits (CMS ODAG, state network audits) are conducted against specific provider networks. audit_engagement currently links to health_plan but not to the specific network under audit. ',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Audit engagements are performed to satisfy regulatory obligations; linking creates required hierarchy.',
    `audit_body` STRING COMMENT 'Organization or agency conducting the audit.. Valid values are `CMS|OCR|NCQA|URAC|State_DOI|Internal`',
    `audit_category` STRING COMMENT 'High-level category of the audit focus area.. Valid values are `financial|operational|clinical|IT|security`',
    `audit_cost_actual` DECIMAL(18,2) COMMENT 'Actual monetary cost incurred for the audit.',
    `audit_cost_estimate` DECIMAL(18,2) COMMENT 'Estimated monetary cost associated with conducting the audit.',
    `audit_currency` STRING COMMENT 'Currency code for cost fields.. Valid values are `USD|EUR|GBP|CAD|JPY`',
    `audit_document_reference` STRING COMMENT 'Identifier or path to the primary audit report document.',
    `audit_engagement_status` STRING COMMENT 'Current lifecycle status of the audit engagement.. Valid values are `planned|in_progress|completed|closed|cancelled`',
    `audit_findings_reference` STRING COMMENT 'Identifier linking to the detailed findings dataset.',
    `audit_followup_required` BOOLEAN COMMENT 'Indicates whether a follow-up audit is scheduled.',
    `audit_location` STRING COMMENT 'Geographic location or business unit where the audit is primarily conducted.',
    `audit_methodology` STRING COMMENT 'Methodology or standards used to conduct the audit (e.g., COSO, ISO27001).',
    `audit_notes` STRING COMMENT 'Free-text field for additional comments or observations.',
    `audit_number` STRING COMMENT 'External reference number assigned to the audit by the auditing body.',
    `audit_period_end` DATE COMMENT 'End date of the audit coverage period.',
    `audit_period_start` DATE COMMENT 'Start date of the audit coverage period.',
    `audit_priority` STRING COMMENT 'Priority level assigned to the audit engagement.. Valid values are `high|medium|low`',
    `audit_report_release_date` DATE COMMENT 'Date when the final audit report was released to stakeholders.',
    `audit_scope` STRING COMMENT 'Narrative describing the functional and geographic scope of the audit.',
    `audit_type` STRING COMMENT 'Category of audit based on purpose and scope.. Valid values are `regulatory|financial|operational|internal|external`',
    `compliance_framework` STRING COMMENT 'Regulatory framework(s) applicable to the audit.. Valid values are `HIPAA|ACA|CMS|NCQA|URAC|State_DOI`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit engagement record was first created in the system.',
    `critical_findings` STRING COMMENT 'Number of findings classified as critical severity.',
    `engagement_end_date` DATE COMMENT 'Date when the audit engagement concluded or was terminated.',
    `engagement_start_date` DATE COMMENT 'Date when the audit engagement officially began.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit engagement was last reviewed for status or changes.',
    `minor_findings` STRING COMMENT 'Number of findings classified as minor severity.',
    `overall_outcome` STRING COMMENT 'Final result of the audit after all findings are addressed.. Valid values are `favorable|unfavorable|conditional|pending`',
    `regulatory_citation` STRING COMMENT 'Reference to the specific regulation or statute cited for each finding.',
    `remediation_plan_due_date` DATE COMMENT 'Target date by which all remediation actions must be completed.',
    `remediation_status` STRING COMMENT 'Current status of remediation activities for audit findings.. Valid values are `not_started|in_progress|completed|overdue`',
    `risk_rating` STRING COMMENT 'Overall risk rating derived from audit findings.. Valid values are `high|medium|low`',
    `significant_findings` STRING COMMENT 'Number of findings classified as significant severity.',
    `total_findings` STRING COMMENT 'Total number of findings identified during the audit.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the audit engagement record.',
    CONSTRAINT pk_audit_engagement PRIMARY KEY(`audit_engagement_id`)
) COMMENT 'Master record for each formal audit or examination conducted by or against the health plan — CMS program audits (RADV, Part C/D), state DOI market conduct examinations, OCR HIPAA investigations, NCQA accreditation surveys, SOC 2 audits, internal compliance audits, and external financial audits. Captures audit type, auditing body, audit scope, audit period, lead auditor, engagement start/end dates, status, and overall audit outcome. Includes detailed finding tracking: finding type (condition, cause, effect), severity level (critical, significant, minor), regulatory citation, finding description, affected business area, root cause analysis, recommended remediation, and finding status through the lifecycle from identification through remediation and closure. Serves as the authoritative registry of all audit engagements and their findings.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`compliance`.`audit_finding` (
    `audit_finding_id` BIGINT COMMENT 'System-generated unique identifier for the audit finding record.',
    `audit_engagement_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_engagement. Business justification: Audit findings belong to an audit engagement; linking provides parent relationship and enables traceability.',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: CMS program audits and state DOI audits produce findings at the benefit package level (incorrect cost-sharing, missing EHB coverage, prior auth violations). Linking audit findings to benefit packages ',
    `header_id` BIGINT COMMENT 'Identifier of the claim linked to the finding, when relevant.',
    `policy_document_id` BIGINT COMMENT 'Foreign key linking to compliance.policy_document. Business justification: An audit finding typically cites the specific internal compliance policy, procedure, or SOP that was violated or deficient. Linking audit_finding to policy_document normalizes the policy reference — c',
    `premium_invoice_id` BIGINT COMMENT 'Foreign key linking to billing.premium_invoice. Business justification: CMS, MLR, and state DOI audit findings frequently cite specific premium invoices as evidence of billing errors or non-compliance. This FK enables auditors to directly reference the invoice under revie',
    `prior_authorization_id` BIGINT COMMENT 'Foreign key linking to pharmacy.prior_authorization. Business justification: CMS Part D and state DOI audits routinely target specific PA decisions for clinical criteria compliance and denial appropriateness. Audit findings must reference the exact PA record under review — a n',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: Credentialing and billing audit findings are scoped to individual providers. Compliance teams must link findings directly to providers for provider-level corrective action tracking, re-credentialing t',
    `affected_business_area` STRING COMMENT 'Business function or area affected by the finding.. Valid values are `claims|billing|provider_network|member_services|care_management|pharmacy`',
    `audit_category` STRING COMMENT 'Regulatory or compliance domain to which the finding relates.. Valid values are `HIPAA|ACA|CMS|NCQA|URAC|State`',
    `audit_finding_description` STRING COMMENT 'Detailed narrative describing the nature of the finding.',
    `audit_finding_source` STRING COMMENT 'Origin of the finding: internal audit, external audit, or regulatory review.. Valid values are `internal_audit|external_audit|regulatory`',
    `audit_finding_status` STRING COMMENT 'Current lifecycle status of the audit finding.. Valid values are `open|in_progress|resolved|closed`',
    `closed_timestamp` TIMESTAMP COMMENT 'Timestamp when the finding was formally closed after remediation.',
    `compliance_area` STRING COMMENT 'Specific compliance domain impacted by the finding.. Valid values are `HIPAA|ACA|CMS|NCQA|URAC|State`',
    `corrective_action_completion_date` DATE COMMENT 'Date when the corrective action was completed.',
    `corrective_action_status` STRING COMMENT 'Current status of the remediation work.. Valid values are `not_started|in_progress|completed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit finding record was created in the system.',
    `due_date` DATE COMMENT 'Date by which remediation actions must be completed.',
    `effectiveness_assessment` STRING COMMENT 'Qualitative assessment of remediation effectiveness.. Valid values are `effective|partially_effective|ineffective`',
    `effectiveness_score` STRING COMMENT 'Score (0‑100) measuring how effective the remediation was.',
    `evidence_document_reference` STRING COMMENT 'Reference (e.g., URL or file ID) to supporting evidence documents.',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated monetary impact associated with the finding.',
    `financial_impact_currency` STRING COMMENT 'Currency code for the financial impact amount.. Valid values are `USD|EUR|GBP|CAD|JPY|CHF`',
    `finding_number` STRING COMMENT 'Business identifier assigned to the finding for tracking and reference.',
    `finding_type` STRING COMMENT 'Classification of the finding as a condition, cause, or effect.. Valid values are `condition|cause|effect`',
    `identified_timestamp` TIMESTAMP COMMENT 'Timestamp when the finding was first identified during the audit.',
    `is_critical` BOOLEAN COMMENT 'True if the finding is deemed critical based on severity and impact.',
    `is_repeat_finding` BOOLEAN COMMENT 'Indicates whether this finding has been observed previously.',
    `last_review_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent review of the finding.',
    `notes` STRING COMMENT 'Free‑form notes added by auditors or reviewers.',
    `priority` STRING COMMENT 'Priority level assigned to the finding for remediation scheduling.. Valid values are `high|medium|low`',
    `regulatory_citation` STRING COMMENT 'Specific regulation, statute, or standard cited for the finding.',
    `remediation_action` STRING COMMENT 'Recommended corrective action to address the finding.',
    `remediation_due_date` DATE COMMENT 'Date by which the remediation must be completed.',
    `resolution` STRING COMMENT 'Final resolution outcome for the finding.. Valid values are `remediated|waived|deferred|rejected`',
    `reviewed_by` BIGINT COMMENT 'Identifier of the person who performed the latest review.',
    `risk_score` STRING COMMENT 'Numeric risk score (0‑100) representing the findings risk level.',
    `risk_score_source` STRING COMMENT 'Origin of the risk score calculation.. Valid values are `internal|external|model`',
    `root_cause` STRING COMMENT 'Analysis of the underlying cause that led to the finding.',
    `severity_level` STRING COMMENT 'Severity rating indicating the potential impact of the finding.. Valid values are `critical|significant|minor`',
    `tags` STRING COMMENT 'Comma‑separated tags for categorization and search.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the audit finding record.',
    `version` STRING COMMENT 'Version number for the finding record to support change tracking.',
    CONSTRAINT pk_audit_finding PRIMARY KEY(`audit_finding_id`)
) COMMENT 'Transactional record for each finding, deficiency, or observation identified during an audit engagement. Captures finding type (condition, cause, effect), severity level (critical, significant, minor), regulatory citation, finding description, affected business area, root cause analysis, and recommended remediation. Links to the parent audit engagement and drives the corrective action plan (CAP) process. Tracks finding status through the lifecycle from identification through remediation and closure.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`compliance`.`corrective_action_plan` (
    `corrective_action_plan_id` BIGINT COMMENT 'Unique system-generated identifier for the corrective action plan.',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: A Corrective Action Plan is created in direct response to an audit finding. The existing STRING field finding_reference is a denormalized text reference that should be replaced by a proper FK. The a',
    `facility_id` BIGINT COMMENT 'Foreign key linking to provider.facility. Business justification: Corrective action plans are issued against facilities following CMS surveys, state inspections, or accreditation findings. Health plans must track facility-level CAPs to assess network participation e',
    `actual_completion_date` DATE COMMENT 'Date when the CAP was actually completed.',
    `actual_cost_usd` DECIMAL(18,2) COMMENT 'Actual financial cost incurred for the CAP.',
    `audit_comments` STRING COMMENT 'Free-text comments from auditors or reviewers regarding the CAP.',
    `closed_timestamp` TIMESTAMP COMMENT 'Timestamp when the CAP was formally closed.',
    `compliance_category` STRING COMMENT 'High-level compliance domain of the issue.. Valid values are `privacy|security|financial|clinical|operational`',
    `compliance_deadline` DATE COMMENT 'Regulatory deadline by which remediation must be completed.',
    `corrective_action_plan_status` STRING COMMENT 'Current lifecycle status of the CAP.. Valid values are `draft|submitted|in_progress|completed|closed|rejected`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the CAP record was created in the system.',
    `estimated_cost_usd` DECIMAL(18,2) COMMENT 'Projected financial cost to implement the corrective actions.',
    `evidence_document_path` STRING COMMENT 'File system or URL location of supporting evidence artifacts.',
    `is_external_audit` BOOLEAN COMMENT 'Indicates whether the finding originated from an external audit.',
    `is_fwa_monitoring` BOOLEAN COMMENT 'Indicates if the CAP is related to FWA monitoring.',
    `last_milestone_status` STRING COMMENT 'Status of the most recent milestone.. Valid values are `not_started|in_progress|completed|blocked`',
    `milestone_count` STRING COMMENT 'Total number of milestones defined for the CAP.',
    `notes` STRING COMMENT 'Additional free-text notes about the CAP.',
    `owner_role` STRING COMMENT 'Role of the owner within the organization.. Valid values are `compliance_officer|risk_manager|clinical_lead|finance_lead|operations_manager`',
    `plan_name` STRING COMMENT 'Descriptive name of the corrective action plan.',
    `plan_number` STRING COMMENT 'External reference number assigned to the CAP.',
    `plan_type` STRING COMMENT 'Category of the CAP based on source of finding.. Valid values are `audit|regulatory|operational|clinical|financial`',
    `priority` STRING COMMENT 'Priority level assigned to the CAP.. Valid values are `low|medium|high|critical`',
    `regulatory_body` STRING COMMENT 'Regulatory authority associated with the finding. [ENUM-REF-CANDIDATE: CMS|OCR|NAIC|State_DOI|NCQA|URAC|Joint_Commission — 7 candidates stripped; promote to reference product]',
    `remediation_strategy` STRING COMMENT 'Planned approach to address the root cause.',
    `risk_score` STRING COMMENT 'Numeric risk score assigned to the CAP based on severity and impact.',
    `root_cause` STRING COMMENT 'Narrative of the root cause analysis for the finding.',
    `severity` STRING COMMENT 'Severity of the underlying finding.. Valid values are `minor|moderate|major|severe`',
    `target_completion_date` DATE COMMENT 'Planned date by which the CAP should be completed.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the CAP record.',
    CONSTRAINT pk_corrective_action_plan PRIMARY KEY(`corrective_action_plan_id`)
) COMMENT 'Master record for each Corrective Action Plan (CAP) developed in response to audit findings, regulatory violations, or accreditation deficiencies. Captures the triggering finding or violation, CAP type, remediation strategy, responsible owner, target completion date, and implementation status. Includes granular milestone tracking with individual action items, assigned owners, planned/actual completion dates, milestone status, evidence artifacts, and reviewer sign-off for each milestone. Tracks the full CAP lifecycle from submission to regulatory body through milestone completion, validation, and closure. Critical for CMS audit readiness and NCQA accreditation maintenance.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`compliance`.`cap_milestone` (
    `cap_milestone_id` BIGINT COMMENT 'Unique identifier for the corrective action plan milestone record.',
    `corrective_action_plan_id` BIGINT COMMENT 'Identifier of the parent corrective action plan to which this milestone belongs.',
    `actual_completion_date` DATE COMMENT 'Date the milestone was actually completed.',
    `actual_start_date` DATE COMMENT 'Date the milestone actually started.',
    `cap_milestone_status` STRING COMMENT 'Current lifecycle status of the milestone.. Valid values are `not_started|in_progress|completed|blocked|deferred|cancelled`',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Numeric progress indicator (0.00 – 100.00) representing how much of the milestone work is finished.',
    `compliance_category` STRING COMMENT 'Regulatory or compliance domain that the milestone addresses. [ENUM-REF-CANDIDATE: hipaa|aca|mlr|ncqa|urac|state_doi|fwa — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the milestone record was first created in the system.',
    `escalated_flag` BOOLEAN COMMENT 'True if the milestone has been escalated due to delays or issues.',
    `evidence_documentation_url` STRING COMMENT 'Link to the artifact or document that provides evidence of milestone completion.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the milestone is deemed critical for compliance or business impact.',
    `milestone_code` STRING COMMENT 'Business identifier or code assigned to the milestone for external reference.',
    `milestone_description` STRING COMMENT 'Detailed description of the work or outcome required for the milestone.',
    `milestone_name` STRING COMMENT 'Descriptive name of the milestone within the corrective action plan.',
    `milestone_type` STRING COMMENT 'Category that classifies the nature of the milestone activity.. Valid values are `documentation|training|process_change|system_update|audit|review`',
    `notes` STRING COMMENT 'Free‑form comments or observations related to the milestone.',
    `planned_completion_date` DATE COMMENT 'Target date by which the milestone should be completed.',
    `planned_start_date` DATE COMMENT 'Scheduled date for the milestone to begin.',
    `priority` STRING COMMENT 'Priority level indicating the importance or urgency of the milestone.. Valid values are `low|medium|high|critical`',
    `regulatory_reference` STRING COMMENT 'Reference identifier for the specific regulatory requirement, audit finding, or standard tied to the milestone.',
    `risk_level` STRING COMMENT 'Risk rating associated with the milestones impact on compliance or operations.. Valid values are `low|moderate|high|critical`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the milestone record.',
    CONSTRAINT pk_cap_milestone PRIMARY KEY(`cap_milestone_id`)
) COMMENT 'Transactional record tracking individual milestones and action items within a Corrective Action Plan (CAP). Captures milestone description, assigned owner, planned completion date, actual completion date, milestone status, evidence artifacts, and reviewer sign-off. Enables granular tracking of CAP progress and supports regulatory reporting on remediation timelines. Links to the parent CAP and provides the audit trail required by CMS, state DOIs, and NCQA for CAP validation.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`compliance`.`breach_incident` (
    `breach_incident_id` BIGINT COMMENT 'Primary key for breach_incident',
    `baa_id` BIGINT COMMENT 'Foreign key linking to compliance.baa. Business justification: When a PHI breach involves a business associate, the specific BAA governing that relationship is critical for determining breach notification requirements, liability, and remediation obligations. brea',
    `corrective_action_plan_id` BIGINT COMMENT 'Foreign key linking to compliance.corrective_action_plan. Business justification: A breach incident triggers a Corrective Action Plan to remediate the root cause and prevent recurrence. breach_incident currently has denormalized STRING fields corrective_action_plan and correctiv',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.group. Business justification: HIPAA requires health insurers to notify employer group sponsors when a breach affects their covered members. Linking breach_incident to employer.group enables group-level breach notification tracking',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: HIPAA breach notifications to HHS and state regulators are plan-specific. CMS requires plan-level breach tracking for Medicare Advantage. Breach incidents affect members enrolled in specific health pl',
    `provider_contract_id` BIGINT COMMENT 'Foreign key linking to contract.provider_contract. Business justification: Required: PHI breach incidents are reported against the specific provider contract responsible for the data.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_regulatory_obligation. Business justification: PHI breach incidents are governed by specific regulatory obligations — primarily the HIPAA Breach Notification Rule (45 CFR §164.400-414) and state breach notification laws. Linking breach_incident di',
    `affected_phi_categories` STRING COMMENT 'Comma-separated list of PHI categories impacted (e.g., demographic, clinical, claims).',
    `audit_findings` STRING COMMENT 'Summary of audit findings related to the breach.',
    `breach_cause_description` STRING COMMENT 'Narrative description of the cause of the breach.',
    `breach_discovery_date` DATE COMMENT 'Date the breach was discovered by the organization.',
    `breach_incident_number` STRING COMMENT 'External reference number assigned to the breach incident.',
    `breach_occurrence_date` DATE COMMENT 'Date the breach actually occurred (if known).',
    `breach_report_url` STRING COMMENT 'Link to the external breach report document.',
    `breach_resolution_date` DATE COMMENT 'Date the breach was fully resolved and closed.',
    `breach_source` STRING COMMENT 'Origin of the breach (internal staff, external actor, partner, unknown).. Valid values are `internal|external|partner|unknown`',
    `breach_status` STRING COMMENT 'Current lifecycle status of the breach investigation.. Valid values are `open|investigating|closed|pending|resolved`',
    `breach_type` STRING COMMENT 'Category of the breach event.. Valid values are `unauthorized_access|theft|loss|improper_disposal|other`',
    `business_associate_involved` BOOLEAN COMMENT 'Indicates whether a Business Associate was involved in the breach.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the breach incident record was created in the system.',
    `hhs_notification_date` DATE COMMENT 'Date HHS was notified of the breach.',
    `hhs_notified` BOOLEAN COMMENT 'Indicates if the U.S. Department of Health & Human Services was notified.',
    `notification_content_version` STRING COMMENT 'Version identifier of the notification content used.',
    `notification_date` DATE COMMENT 'Date the notification was sent.',
    `notification_delivery_confirmation` BOOLEAN COMMENT 'Indicates whether delivery confirmation was received.',
    `notification_method` STRING COMMENT 'Delivery channel used for the notification.. Valid values are `mail|email|substitute_notice|phone|fax`',
    `notification_obligation` STRING COMMENT 'Regulatory notification obligations triggered by the breach.. Valid values are `individual|hhs|state|media|none`',
    `notification_recipient_count` STRING COMMENT 'Number of recipients who received the notification.',
    `notification_type` STRING COMMENT 'Type of notification sent.. Valid values are `individual|hhs|state|media`',
    `number_of_individuals_affected` STRING COMMENT 'Count of distinct individuals whose PHI was compromised.',
    `number_of_records_affected` STRING COMMENT 'Total number of PHI records impacted.',
    `regulatory_filing_date` DATE COMMENT 'Date the breach was filed with the regulator.',
    `regulatory_filing_status` STRING COMMENT 'Status of required regulatory filings related to the breach.. Valid values are `not_filed|filed|rejected|accepted`',
    `risk_assessment_method` STRING COMMENT 'Methodology used for risk assessment.. Valid values are `qualitative|quantitative|hybrid`',
    `risk_assessment_score` DECIMAL(18,2) COMMENT 'Quantitative risk score resulting from breach risk assessment.',
    `state_notification_date` DATE COMMENT 'Date the state authority was notified.',
    `state_notified` BOOLEAN COMMENT 'Indicates if the relevant state authority was notified.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the breach incident record.',
    CONSTRAINT pk_breach_incident PRIMARY KEY(`breach_incident_id`)
) COMMENT 'Master record for each PHI (Protected Health Information) breach incident identified under HIPAA Breach Notification Rule (45 CFR §164.400–414). Captures breach discovery date, breach type (unauthorized access, theft, loss, improper disposal), affected PHI categories, number of individuals affected, breach cause, business associate involvement, risk assessment outcome, and notification obligations triggered. Includes full notification tracking: notification type (individual, HHS/OCR, media, state AG), notification method (mail, email, substitute notice), notification date, recipient count, content version, and delivery confirmation. Drives the 60-day OCR notification workflow and annual breach report to HHS. Critical for HIPAA compliance and OCR audit readiness.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`compliance`.`hipaa_privacy_request` (
    `hipaa_privacy_request_id` BIGINT COMMENT 'System-generated unique identifier for the HIPAA privacy request record.',
    `breach_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.breach_incident. Business justification: A HIPAA privacy request is frequently triggered by or associated with a specific PHI breach incident — members submit access or accounting-of-disclosures requests in response to breach notifications. ',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: HIPAA Privacy Rule compliance reporting requires plan-level tracking of access, amendment, and restriction requests. Plan-level privacy metrics and regulatory audits require associating each privacy r',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member who submitted the privacy request.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: HIPAA Right of Access and Amendment requests must be scoped to a specific coverage period. Compliance teams processing member PHI requests need to identify which policys records are in scope, enablin',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_regulatory_obligation. Business justification: HIPAA privacy requests are governed by specific regulatory obligations under the HIPAA Privacy Rule (45 CFR §164.524 for access, §164.526 for amendment, §164.528 for accounting of disclosures). Linkin',
    `appeal_deadline` DATE COMMENT 'Final date by which an appeal must be filed.',
    `appeal_outcome` STRING COMMENT 'Result of the appeal process, if applicable.. Valid values are `upheld|reversed|denied|withdrawn`',
    `audit_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the privacy request record was first created in the system.',
    `audit_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the privacy request record.',
    `denial_reason` STRING COMMENT 'Explanation provided when a request is denied or partially granted.',
    `disclosure_authorization_basis` STRING COMMENT 'Legal basis authorizing the PHI disclosure.. Valid values are `patient_authorization|legal_requirement|public_interest|court_order`',
    `disclosure_date` TIMESTAMP COMMENT 'Timestamp of the PHI disclosure, if one occurred.',
    `disclosure_logged` BOOLEAN COMMENT 'Indicates whether a PHI disclosure related to this request has been logged.',
    `disclosure_phicategories` STRING COMMENT 'Comma‑separated list of PHI categories disclosed (e.g., diagnosis, treatment, payment).',
    `disclosure_purpose` STRING COMMENT 'Business or legal purpose for which the PHI was disclosed.',
    `disclosure_recipient_type` STRING COMMENT 'Category of the entity receiving the disclosed PHI.. Valid values are `public_health|law_enforcement|research|legal|other`',
    `disposition` STRING COMMENT 'Outcome of the request (e.g., granted, denied, partially granted).',
    `is_appealed` BOOLEAN COMMENT 'Indicates whether the member has appealed the request decision.',
    `is_confidential_communication` BOOLEAN COMMENT 'True when the member requests that communications be handled confidentially.',
    `request_channel` STRING COMMENT 'Medium of the request (digital, paper, or phone).. Valid values are `digital|paper|phone`',
    `request_description` STRING COMMENT 'Free‑text description provided by the member detailing the request.',
    `request_number` STRING COMMENT 'Human‑readable reference number assigned to the privacy request.',
    `request_received_timestamp` TIMESTAMP COMMENT 'Date‑time when the privacy request was initially received.',
    `request_source` STRING COMMENT 'Channel through which the request was received (e.g., member portal, email, phone).. Valid values are `portal|email|phone|fax|mail`',
    `request_status` STRING COMMENT 'Current processing state of the privacy request.. Valid values are `pending|in_review|completed|denied|partially_granted|closed`',
    `request_type` STRING COMMENT 'Category of the privacy request as defined by HIPAA (e.g., access, amendment, accounting of disclosures, restriction, confidential communication).. Valid values are `access|amendment|accounting|restriction|confidential_communication`',
    `response_date` DATE COMMENT 'Date on which the organization completed its response to the request.',
    `response_due_date` DATE COMMENT 'Regulatory deadline by which a response must be provided (typically 30 days from receipt).',
    CONSTRAINT pk_hipaa_privacy_request PRIMARY KEY(`hipaa_privacy_request_id`)
) COMMENT 'Transactional record for HIPAA privacy operations — member privacy rights requests and PHI disclosure tracking. Covers access requests (right to access PHI), amendment requests, accounting of disclosures, restriction requests, and confidential communication requests under 45 CFR §164.500. Captures request type, member identifier, request receipt date, response due date, response date, request disposition (granted, denied, partially granted), denial reason, and appeal status. Includes PHI disclosure logging: disclosure date, recipient organization, recipient type (public health authority, law enforcement, research, legal), purpose of disclosure, PHI categories disclosed, and disclosure authorization basis. Excludes treatment, payment, and healthcare operations disclosures per HIPAA exemptions. Tracks compliance with HIPAA response timelines and supports OCR audit documentation.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`compliance`.`baa` (
    `baa_id` BIGINT COMMENT 'Surrogate primary key uniquely identifying each Business Associate Agreement record.',
    `delegation_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.delegation_agreement. Business justification: Delegation agreements (credentialing, UM, claims) require a BAA when the delegate handles PHI. Health plan compliance officers must link each BAA to its governing delegation agreement for NCQA delegat',
    `facility_id` BIGINT COMMENT 'Foreign key linking to provider.facility. Business justification: HIPAA Business Associate Agreements are executed with facilities (hospitals, labs, imaging centers) that handle PHI on behalf of the health plan. Compliance teams must link BAAs to the specific facili',
    `group_practice_id` BIGINT COMMENT 'Foreign key linking to provider.group_practice. Business justification: BAAs are executed with group practices that access or process member PHI (e.g., multi-specialty groups, IPAs). Compliance teams need to link BAAs to group practice entities for HIPAA compliance tracki',
    `provider_contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract_provider_contract. Business justification: HIPAA requires a BAA whenever a provider contract involves PHI sharing. Health insurance compliance teams must trace which provider contract necessitated each BAA for HIPAA audit trails, contract term',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Each BAA supports compliance with a regulatory obligation; linking enables obligation‑centric reporting.',
    `tpa_arrangement_id` BIGINT COMMENT 'Foreign key linking to employer.tpa_arrangement. Business justification: HIPAA requires a BAA with every TPA that handles PHI on behalf of a covered entity. Linking baa to tpa_arrangement enables tracking which BAA governs each TPA relationship — a direct HIPAA §164.308(b)',
    `agreement_number` STRING COMMENT 'External reference number or code assigned to the BAA by the health plan.',
    `agreement_status` STRING COMMENT 'Current lifecycle state of the BAA.. Valid values are `active|terminated|pending|draft|suspended`',
    `amendment_count` STRING COMMENT 'Total number of amendments executed against the original BAA.',
    `audit_rights` STRING COMMENT 'Rights granted to the health plan to audit the associates compliance with the BAA.',
    `breach_notification_requirements` STRING COMMENT 'Procedures and timelines the associate must follow to notify the health plan of a PHI breach.',
    `business_associate_name` STRING COMMENT 'Legal name of the vendor, TPA, PBM, clearinghouse, or other entity that receives PHI under the agreement.',
    `business_associate_type` STRING COMMENT 'Category of the business associate indicating the nature of the relationship.. Valid values are `vendor|tpa|pbm|clearinghouse|other`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the BAA record was first created in the data warehouse.',
    `data_disposal_method` STRING COMMENT 'Method the associate must use to dispose of retained PHI after the retention period.. Valid values are `destroy|deidentify|archive|return|other`',
    `data_retention_period_months` STRING COMMENT 'Number of months the associate must retain PHI before disposal.',
    `effective_end_date` DATE COMMENT 'Date on which the BAA expires or terminates; null for open‑ended agreements.',
    `effective_start_date` DATE COMMENT 'Date on which the BAA becomes legally binding.',
    `governing_law` STRING COMMENT 'Legal jurisdiction governing the agreement (e.g., state law, federal HIPAA).',
    `jurisdiction` STRING COMMENT 'Geographic jurisdiction (state or territory) applicable to the BAA.',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment to the BAA.',
    `permitted_phis` STRING COMMENT 'List or description of specific PHI categories the associate may handle (e.g., claims, enrollment, clinical data).',
    `regulatory_reference` STRING COMMENT 'Reference to the specific regulation(s) that the BAA satisfies (e.g., HIPAA, HITECH).',
    `renewal_notice_period_days` STRING COMMENT 'Number of days prior to expiration that the health plan must provide notice to renew.',
    `renewal_option` STRING COMMENT 'Specifies whether the BAA renews automatically, requires manual action, or does not renew.. Valid values are `auto|manual|none`',
    `scope_of_phi_use` STRING COMMENT 'Narrative description of permitted uses and disclosures of Protected Health Information under the agreement.',
    `security_obligations` STRING COMMENT 'Detailed security controls and safeguards the associate must implement to protect PHI.',
    `subcontractor_allowed` BOOLEAN COMMENT 'Indicates whether the business associate may engage subcontractors to perform PHI‑related services.',
    `subcontractor_details` STRING COMMENT 'Description of any approved subcontractors, their roles, and required safeguards.',
    `termination_clause` STRING COMMENT 'Text describing conditions under which the BAA may be terminated by either party.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the BAA record.',
    CONSTRAINT pk_baa PRIMARY KEY(`baa_id`)
) COMMENT 'Master record for each Business Associate Agreement (BAA) executed with vendors, TPAs, PBMs, clearinghouses, and other entities that handle PHI on behalf of the health plan under HIPAA (45 CFR §164.308). Captures business associate name, agreement effective date, expiration date, PHI use permissions, security obligations, breach notification requirements, subcontractor provisions, termination clauses, and agreement status. Serves as the authoritative registry of all BAAs and supports HIPAA compliance audits and vendor risk management.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`compliance`.`fwa_case` (
    `fwa_case_id` BIGINT COMMENT 'Unique system-generated identifier for the FWA case.',
    `broker_id` BIGINT COMMENT 'Foreign key linking to employer.broker. Business justification: Broker fraud (false enrollment submissions, commission manipulation) is a recognized FWA category in health insurance. Linking fwa_case to employer.broker enables structured broker FWA investigation t',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.group. Business justification: FWA investigations in health insurance frequently target employer groups submitting fraudulent enrollment data or inflated headcounts. Linking fwa_case to employer.group enables structured group-level',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: CMS requires plan-level FWA program reporting and case tracking for Medicare Advantage and Medicaid managed care plans. FWA cases are investigated within a specific health plans claims context. A com',
    `premium_payment_id` BIGINT COMMENT 'Foreign key linking to billing.premium_payment. Business justification: FWA cases involving premium fraud schemes (ghost enrollment, fictitious payments) reference specific premium payment records as evidence. This FK enables SIU investigators to directly link FWA cases t',
    `provider_contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract_provider_contract. Business justification: FWA cases are opened against providers operating under specific contracts. Linking enables contract-level FWA reporting, supports contract suspension/termination decisions, and satisfies CMS and OIG r',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: FWA cases with subject_type=PROVIDER reference a specific provider. subject_reference is a generic text field serving multiple subject types. A proper FK enables fraud investigators to retrieve all ',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_regulatory_obligation. Business justification: FWA cases are governed by specific regulatory obligations — CMS FWA program requirements, ACA Section 1128J, and state insurance fraud statutes. The fwa_case table currently has a compliance_reference',
    `vbc_contract_id` BIGINT COMMENT 'Foreign key linking to contract.vbc_contract. Business justification: VBC/ACO arrangements are subject to FWA investigations including manipulation of attributed member counts, upcoding to inflate quality scores, and fraudulent shared savings claims. CMS requires health',
    `allegation_description` STRING COMMENT 'Detailed description of the alleged fraud, waste, or abuse.',
    `audit_log_url` STRING COMMENT 'Link to the immutable audit log for this case.',
    `case_disposition` STRING COMMENT 'Final outcome of the case after investigation.. Valid values are `substantiated|unsubstantiated|law_enforcement|civil_penalty|referred`',
    `case_number` STRING COMMENT 'Business identifier assigned to the case for external reference and reporting.',
    `case_open_timestamp` TIMESTAMP COMMENT 'Timestamp when the case was officially opened.',
    `case_status` STRING COMMENT 'Current lifecycle status of the case.. Valid values are `open|in_progress|closed|referred|settled`',
    `case_type` STRING COMMENT 'Primary classification of the case as fraud, waste, or abuse.. Valid values are `fraud|waste|abuse`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the case record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.. Valid values are `USD|CAD|EUR|GBP|JPY|AUD`',
    `disposition_date` DATE COMMENT 'Date the case disposition was recorded.',
    `estimated_exposure_amount` DECIMAL(18,2) COMMENT 'Projected monetary loss associated with the alleged activity.',
    `evidence_reference` STRING COMMENT 'Link or identifier to supporting evidence stored in the evidence repository.',
    `is_high_risk` BOOLEAN COMMENT 'Flag indicating the case is considered high risk based on internal scoring.',
    `notes` STRING COMMENT 'Free‑form notes entered by investigators or reviewers.',
    `recovery_amount` DECIMAL(18,2) COMMENT 'Amount recovered or expected to be recovered from the subject.',
    `referral_date` DATE COMMENT 'Date the referral was received and the case was created.',
    `referral_source` STRING COMMENT 'Origin of the case referral, such as claim edit, data mining, tip line, law enforcement, or employee report.. Valid values are `claim_edit|data_mining|tip_line|law_enforcement|employee_report`',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether the case has been reported to a regulatory body (e.g., CMS, state fraud bureau).',
    `risk_score` DECIMAL(18,2) COMMENT 'Numeric risk score assigned during triage (0‑100 scale).',
    `subject_reference` BIGINT COMMENT 'Identifier of the subject (member, provider, or employer group) under investigation.',
    `subject_type` STRING COMMENT 'Entity type that is the subject of the investigation.. Valid values are `member|provider|employer_group`',
    `triage_outcome` STRING COMMENT 'Result of the initial triage review, indicating next steps.. Valid values are `escalated|closed|investigate|dismissed`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the case record.',
    CONSTRAINT pk_fwa_case PRIMARY KEY(`fwa_case_id`)
) COMMENT 'Master record for each Fraud, Waste, and Abuse (FWA) investigation — from initial referral intake through case disposition. Captures referral source (claim edits, data mining, tip line, law enforcement, employee reports), referral date, allegation description, supporting evidence references, triage outcome, case type (fraud, waste, abuse), subject type (member, provider, employer group), case open date, investigation status, assigned investigator, estimated financial exposure, recovery amount, and case disposition (substantiated, unsubstantiated, referred to law enforcement, civil monetary penalty). Supports CMS FWA program requirements, state insurance fraud bureau reporting, and annual FWA reporting to CMS.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`compliance`.`fwa_referral` (
    `fwa_referral_id` BIGINT COMMENT 'System-generated unique identifier for the FWA referral record.',
    `fwa_case_id` BIGINT COMMENT 'Identifier of the FWA case opened as a result of this referral, if any.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member who is the subject of the referral, when applicable.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: FWA investigations involving member identity fraud or benefit abuse require linking to the specific policy under which fraudulent activity occurred. Investigators need the policy to calculate financia',
    `provider_contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract_provider_contract. Business justification: FWA referrals target providers under specific contracts. The existing provider_npi plain-text field is insufficient for SIU workflows. Linking to the contract enables contract-level FWA tracking, paym',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: FWA referrals are frequently made against specific providers for billing fraud, upcoding, or unnecessary services. fwa_referral.provider_npi is a plain-text denormalization of the provider entity. Fra',
    `allegation_description` STRING COMMENT 'Free‑text description of the alleged fraud, waste, or abuse.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the referral record was first created in the data lake.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for the estimated loss amount.. Valid values are `USD|EUR|GBP|CAD|JPY`',
    `due_date` DATE COMMENT 'Target date by which the referral should be resolved or escalated.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the referral has been escalated to higher‑level review.',
    `estimated_loss_amount` DECIMAL(18,2) COMMENT 'Monetary estimate of potential loss associated with the alleged activity.',
    `evidence_reference` STRING COMMENT 'Link (URL or document ID) to supporting evidence attached to the referral.',
    `fwa_referral_status` STRING COMMENT 'Current lifecycle status of the referral within the investigation workflow.. Valid values are `new|in_review|assigned|closed|rejected`',
    `notes` STRING COMMENT 'Additional free‑form comments or observations captured by the investigator.',
    `priority` STRING COMMENT 'Priority level assigned to the referral for handling urgency.. Valid values are `low|medium|high|critical`',
    `referral_date` TIMESTAMP COMMENT 'Timestamp when the referral was received or logged in the SIU system.',
    `referral_number` STRING COMMENT 'Business identifier assigned to the referral for tracking and reporting.',
    `referral_source` STRING COMMENT 'Origin of the referral indicating how it was reported.. Valid values are `internal_detection|employee|member|provider|external_agency`',
    `referral_type` STRING COMMENT 'Category of the alleged wrongdoing.. Valid values are `fraud|waste|abuse|billing_error|other`',
    `subject_type` STRING COMMENT 'Classification of the entity that is the subject of the referral.. Valid values are `member|provider|employee|other`',
    `triage_outcome` STRING COMMENT 'Result of the initial triage assessment.. Valid values are `opened|closed|dismissed|escalated|pending`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the referral record.',
    CONSTRAINT pk_fwa_referral PRIMARY KEY(`fwa_referral_id`)
) COMMENT 'Transactional record for each FWA referral received by the Special Investigations Unit (SIU) from internal detection systems, employees, members, providers, or external agencies. Captures referral source, referral date, subject identifier, referral type, allegation description, supporting evidence references, triage outcome, and linkage to the resulting FWA case if opened. Tracks the intake and triage workflow for all FWA allegations and supports CMS annual FWA reporting requirements.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`compliance`.`mlr_calculation` (
    `mlr_calculation_id` BIGINT COMMENT 'Primary key for mlr_calculation',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: MLR calculations may be subject to audit findings — CMS and state regulators audit MLR calculations for accuracy, and findings are issued when calculations are deficient. The mlr_calculation table alr',
    `fee_schedule_id` BIGINT COMMENT 'Foreign key linking to contract.fee_schedule. Business justification: MLR calculations require the fee schedule used to determine allowed amounts in the incurred claims numerator. Health insurance actuaries and compliance officers must link MLR calculations to fee sched',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.group. Business justification: ACA §2718 requires MLR rebates for employer-sponsored plans to be distributed to the group sponsor. Linking mlr_calculation to employer.group enables group-level rebate disbursement tracking and ACA M',
    `health_plan_id` BIGINT COMMENT 'Foreign key to the health plan for which the MLR is being calculated.',
    `rate_schedule_id` BIGINT COMMENT 'Foreign key linking to billing.rate_schedule. Business justification: MLR calculations use earned premium data derived from specific rate schedules. This FK links each MLR calculation to the applicable rate schedule, enabling premium earned-amount reconciliation and sup',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: MLR calculations are performed to demonstrate compliance with regulatory obligations; linking ties calculations to obligations.',
    `year_id` BIGINT COMMENT 'Foreign key linking to plan.year. Business justification: ACA 45 CFR 158 requires annual MLR reporting tied to specific plan years. Linking mlr_calculation to the plan year entity enables MLR reporting workflows, open enrollment deadline tracking, and plan y',
    `calculation_date` DATE COMMENT 'Date on which the MLR calculation was performed.',
    `calculation_number` STRING COMMENT 'Human‑readable identifier assigned to the MLR calculation for reporting and audit purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the MLR calculation record was first created in the system.',
    `earned_premium_amount` DECIMAL(18,2) COMMENT 'Total earned premium dollars for the reporting period, forming the MLR denominator.',
    `incurred_claims_amount` DECIMAL(18,2) COMMENT 'Total dollar amount of claims incurred for the reporting period.',
    `line_of_business` STRING COMMENT 'Business line (e.g., HMO, PPO, Medicaid) associated with the MLR calculation.',
    `market_segment_code` STRING COMMENT 'Code representing the market segment (e.g., individual, group, Medicare) to which the calculation applies.',
    `mlr_calculation_status` STRING COMMENT 'Current processing status of the MLR calculation.. Valid values are `pending|calculated|approved|rejected`',
    `mlr_percentage` DECIMAL(18,2) COMMENT 'Calculated MLR ratio expressed as a percentage (incurred claims ÷ earned premium).',
    `notes` STRING COMMENT 'Free‑form comments or explanations entered by analysts.',
    `quality_improvement_expenses_amount` DECIMAL(18,2) COMMENT 'Dollar amount spent on quality improvement activities that count toward the MLR denominator.',
    `rebate_amount` DECIMAL(18,2) COMMENT 'Dollar amount of the rebate owed to members or the market segment.',
    `rebate_disbursement_date` DATE COMMENT 'Date on which the rebate payment was or will be disbursed.',
    `rebate_disbursement_status` STRING COMMENT 'Current status of the rebate payment process.. Valid values are `not_started|in_process|completed|failed`',
    `rebate_eligibility_flag` BOOLEAN COMMENT 'True if the calculated MLR exceeds the regulatory threshold and a rebate is required.',
    `reporting_year` STRING COMMENT 'Calendar year for which the MLR is being calculated.',
    `source_system` STRING COMMENT 'Name of the operational system that generated the source data for this calculation (e.g., HealthEdge, Milliman).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the MLR calculation record.',
    `version_number` STRING COMMENT 'Incremental version of the calculation record for audit trail purposes.',
    CONSTRAINT pk_mlr_calculation PRIMARY KEY(`mlr_calculation_id`)
) COMMENT 'Medical Loss Ratio (MLR) calculation and rebate processing record per ACA Section 2718 requirements. Captures reporting year, market segment, LOB, incurred claims, quality improvement expenses, earned premium, MLR percentage, rebate determination, rebate amount, and disbursement tracking.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` (
    `accreditation_program_id` BIGINT COMMENT 'Unique system-generated identifier for each accreditation program record.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: NCQA Health Plan Accreditation and URAC accreditation programs are scoped to specific health plans. CMS requires accreditation status for Medicare Advantage plans. A health insurance compliance expert',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Accreditation programs are driven by specific regulatory obligations; linking clarifies compliance scope.',
    `accountable_owner` STRING COMMENT 'Full name of the person or team accountable for the accreditation.',
    `accreditation_program_level` STRING COMMENT 'Level or tier assigned by the accrediting body (e.g., Level 1, Level 2).',
    `accreditation_program_status` STRING COMMENT 'Current state of the accreditation (e.g., accredited, provisional, denied).. Valid values are `accredited|provisional|denied|pending|revoked`',
    `accreditation_type` STRING COMMENT 'Classification of the accreditation program (e.g., health plan, provider, pharmacy).. Valid values are `health_plan|provider|pharmacy|network|member`',
    `accrediting_body` STRING COMMENT 'Name of the organization that issues the accreditation (e.g., NCQA, URAC, CMS).',
    `applicable_standards` STRING COMMENT 'List of standards, guidelines, or criteria the program must meet.',
    `audit_trail` STRING COMMENT 'Chronological notes capturing audit actions and decisions.',
    `benchmark_thresholds` STRING COMMENT 'Target values for performance measures used in the accreditation.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Progress of the accreditation process expressed as a percent.',
    `compliance_category` STRING COMMENT 'High‑level classification of the accreditations compliance focus.',
    `conditions` STRING COMMENT 'Any remedial actions, monitoring, or conditions required for continued accreditation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the accreditation record was first created.',
    `decision` STRING COMMENT 'Final decision made by the accrediting body.. Valid values are `accredited|denied|conditional|revoked`',
    `effective_from` DATE COMMENT 'Date on which the accreditation starts to be binding.',
    `effective_until` DATE COMMENT 'Date on which the accreditation ends; null if open‑ended.',
    `escalated_flag` BOOLEAN COMMENT 'True when issues have been escalated to senior management.',
    `evidence_documentation_url` STRING COMMENT 'Link to uploaded evidence files used in the accreditation review.',
    `final_score` DECIMAL(18,2) COMMENT 'Numeric score (e.g., 0‑100) resulting from the accreditation evaluation.',
    `is_critical` BOOLEAN COMMENT 'True if the accreditation is essential to business operations.',
    `last_modified_by` STRING COMMENT 'Identifier of the person or system that performed the most recent update.',
    `last_review_date` DATE COMMENT 'Date when the accreditation was last reviewed for compliance.',
    `measure_thresholds` STRING COMMENT 'Target thresholds for each evaluated measure.',
    `measures` STRING COMMENT 'Key performance or quality measures assessed during the accreditation.',
    `next_survey_due_date` DATE COMMENT 'Planned date for the next accreditation survey cycle.',
    `notes` STRING COMMENT 'Additional comments or observations about the accreditation.',
    `preliminary_findings` STRING COMMENT 'Initial observations and issues identified during the survey.',
    `program_code` STRING COMMENT 'Business identifier assigned by the accrediting organization.',
    `program_name` STRING COMMENT 'Descriptive name of the accreditation program (e.g., NCQA Health Plan Accreditation).',
    `rating` STRING COMMENT 'Star rating or equivalent tier based on the final score.. Valid values are `1_star|2_star|3_star|4_star|5_star`',
    `recommendations` STRING COMMENT 'Suggested improvements or corrective actions from the accrediting body.',
    `regulatory_reference` STRING COMMENT 'Citation of the specific regulation, statute, or standard governing the accreditation.',
    `renewal_cycle_months` STRING COMMENT 'Number of months between required renewal surveys.',
    `risk_level` STRING COMMENT 'Risk rating reflecting potential impact of non‑compliance.. Valid values are `low|medium|high`',
    `scope` STRING COMMENT 'Description of the functional and geographic scope covered by the accreditation.',
    `survey_end_date` DATE COMMENT 'Last day of the accreditation survey window.',
    `survey_start_date` DATE COMMENT 'First day of the accreditation survey window.',
    `survey_type` STRING COMMENT 'Type of survey associated with the accreditation (initial, renewal, focused).. Valid values are `initial|renewal|focused`',
    `surveyor_contact` STRING COMMENT 'Email address of the primary surveyor or accrediting liaison.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `surveyor_team` STRING COMMENT 'Name(s) of the surveyor(s) or consulting firm performing the review.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the accreditation record.',
    CONSTRAINT pk_accreditation_program PRIMARY KEY(`accreditation_program_id`)
) COMMENT 'Master record for each accreditation program the health plan participates in — NCQA Health Plan Accreditation, URAC Health Plan Accreditation, NCQA HEDIS, CAHPS survey programs, and CMS Star Ratings. Captures accrediting body, program name, accreditation type, current status (accredited, provisional, denied), accreditation level, effective/expiration dates, accountable business owner, and applicable standards/measures with benchmark thresholds. Includes full survey/review cycle tracking: survey type (initial, renewal, focused), survey date range, surveyor team, scope, preliminary findings, final score/rating, accreditation decision, and conditions or recommendations. Serves as the authoritative registry of all accreditation relationships and their evaluation history.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`compliance`.`accreditation_survey` (
    `accreditation_survey_id` BIGINT COMMENT 'System-generated unique identifier for the accreditation survey record.',
    `accreditation_program_id` BIGINT COMMENT 'Identifier of the accreditation program (e.g., NCQA, URAC, CMS) under which the survey is conducted.',
    `audit_engagement_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_engagement. Business justification: An accreditation survey conducted by NCQA, URAC, or CMS is a formal audit engagement — it is an examination conducted against the health plan with findings, scores, and outcomes. Linking accreditation',
    `delegation_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.delegation_agreement. Business justification: NCQA delegation surveys evaluate specific delegation agreements to assess whether delegated functions meet accreditation standards. Health plan accreditation teams must link surveys to delegation agre',
    `accreditation_decision` STRING COMMENT 'Final determination of accreditation status.. Valid values are `accredited|conditionally_accredited|not_accredited|pending`',
    `accreditation_survey_status` STRING COMMENT 'Current lifecycle status of the survey.. Valid values are `scheduled|in_progress|completed|closed|cancelled`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the survey record was first created in the system.',
    `end_timestamp` TIMESTAMP COMMENT 'Date and time when the accreditation survey was concluded.',
    `evidence_documentation_url` STRING COMMENT 'Link to the repository containing supporting evidence and documents submitted for the survey.',
    `final_score` DECIMAL(18,2) COMMENT 'Numeric score assigned by the accrediting body after final evaluation (e.g., 0.00 – 100.00).',
    `notes` STRING COMMENT 'Free‑form notes captured by the surveyor team.',
    `preliminary_findings` STRING COMMENT 'Initial observations and findings recorded during the survey before final evaluation.',
    `rating` STRING COMMENT 'Overall rating tier derived from the final score (1‑5 stars).',
    `recommendation` STRING COMMENT 'Recommendations or conditions issued by the surveyor for future compliance.',
    `risk_level` STRING COMMENT 'Risk classification associated with identified deficiencies.. Valid values are `low|moderate|high|critical`',
    `start_timestamp` TIMESTAMP COMMENT 'Date and time when the accreditation survey officially began.',
    `survey_location` STRING COMMENT 'Physical location or facility where the survey was performed.',
    `survey_method` STRING COMMENT 'Methodology used to conduct the survey (e.g., onsite visit, remote review).. Valid values are `onsite|remote|hybrid`',
    `survey_number` STRING COMMENT 'External reference number assigned by the accreditation body for this survey cycle.',
    `survey_region_code` STRING COMMENT 'Three‑letter ISO country code representing the region of the survey.. Valid values are `^[A-Z]{3}$`',
    `survey_scope` STRING COMMENT 'Description of the functional and geographic scope covered by the survey.',
    `survey_type` STRING COMMENT 'Classification of the survey purpose (e.g., initial accreditation, renewal, focused review).. Valid values are `initial|renewal|focused|ad_hoc`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the survey record.',
    CONSTRAINT pk_accreditation_survey PRIMARY KEY(`accreditation_survey_id`)
) COMMENT 'Transactional record for each accreditation survey or review cycle conducted by NCQA, URAC, or CMS. Captures survey type (initial, renewal, focused), survey date range, surveyor team, survey scope, preliminary findings, final score or rating, accreditation decision, and conditions or recommendations. Links to the parent accreditation program and drives corrective action planning for deficiencies identified during the survey. Tracks the full survey lifecycle from scheduling through final determination.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`compliance`.`policy_document` (
    `policy_document_id` BIGINT COMMENT 'System-generated unique identifier for the policy document record.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Compliance policy documents (HIPAA Notice of Privacy Practices, ACA non-discrimination notices, coverage determination policies) are plan-specific. Plan-level policy document management and regulatory',
    `provider_contract_id` BIGINT COMMENT 'Foreign key linking to contract.provider_contract. Business justification: Required: Contracts reference specific policy documents governing terms and compliance obligations.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_regulatory_obligation. Business justification: A compliance policy document is created and maintained to satisfy specific regulatory obligations — HIPAA policies satisfy OCR requirements, ACA policies satisfy CMS requirements, etc. Linking policy_',
    `approval_date` DATE COMMENT 'Date the policy was formally approved.',
    `approval_status` STRING COMMENT 'Result of the formal approval workflow.. Valid values are `pending|approved|rejected`',
    `archive_date` DATE COMMENT 'Date the policy was archived.',
    `compliance_area` STRING COMMENT 'Specific compliance domain the policy addresses (e.g., privacy, fraud waste abuse, risk adjustment).',
    `confidentiality_level` STRING COMMENT 'Sensitivity classification governing handling and distribution.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the policy record was first created in the system.',
    `distribution_scope` STRING COMMENT 'Audience for the policy (internal employees, external partners, regulators).',
    `document_format` STRING COMMENT 'File format of the stored policy document.. Valid values are `pdf|docx|html`',
    `document_size_bytes` BIGINT COMMENT 'File size of the electronic document in bytes.',
    `document_url` STRING COMMENT 'Link to the stored electronic version of the policy (e.g., S3, SharePoint).',
    `effective_date` DATE COMMENT 'Date on which the policy becomes operationally binding.',
    `expiration_date` DATE COMMENT 'Date on which the policy ceases to be in effect; null for indefinite policies.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the policy is currently in effect.',
    `is_archived` BOOLEAN COMMENT 'True if the policy has been moved to archival storage.',
    `is_confidential` BOOLEAN COMMENT 'True if the policy is marked confidential; aligns with confidentiality_level.',
    `next_review_date` DATE COMMENT 'Planned date for the subsequent review.',
    `policy_code` STRING COMMENT 'Business code or alphanumeric identifier used to reference the policy across systems.',
    `policy_document_category` STRING COMMENT 'High‑level grouping such as HIPAA Privacy, FWA, ACA Compliance, Credentialing, Claims Adjudication, etc.',
    `policy_document_status` STRING COMMENT 'Current lifecycle state of the policy.. Valid values are `draft|active|suspended|retired`',
    `policy_name` STRING COMMENT 'Descriptive title of the compliance policy, procedure, or SOP.',
    `policy_owner_department` STRING COMMENT 'Business unit or department that owns the policy.',
    `regulatory_citations` STRING COMMENT 'List of statutes, regulations, or standards referenced (e.g., HIPAA, ACA, CMS).',
    `review_date` DATE COMMENT 'Date the most recent review was performed.',
    `review_outcome` STRING COMMENT 'Result of the review process.. Valid values are `approved|revised|retired`',
    `review_type` STRING COMMENT 'Nature of the review (scheduled annual, triggered by event, or regulatory change).. Valid values are `annual|triggered|regulatory_change`',
    `revision_summary` STRING COMMENT 'Brief description of changes made in the latest version.',
    `updated_by` STRING COMMENT 'User identifier of the person who last modified the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the policy record.',
    `version_number` STRING COMMENT 'Semantic version identifier (e.g., 1.0, 2.1) tracking revisions.',
    `created_by` STRING COMMENT 'User identifier of the person who initially created the record.',
    CONSTRAINT pk_policy_document PRIMARY KEY(`policy_document_id`)
) COMMENT 'Master record for each internal compliance policy, procedure, or SOP — including version history and review tracking. Covers HIPAA privacy/security policies, FWA program policies, ACA compliance procedures, credentialing policies, and claims adjudication standards. Captures policy name, category, owner, effective date, version number, approval status, regulatory citations, and distribution scope. Tracks periodic reviews with review date, reviewer, review type (annual, triggered, regulatory change), outcome (approved, revised, retired), revision summary, next review date, and approver sign-off. Serves as the authoritative policy registry supporting NCQA, URAC, and CMS audit readiness.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_audit_engagement_id` FOREIGN KEY (`audit_engagement_id`) REFERENCES `health_insurance_ecm`.`compliance`.`audit_engagement`(`audit_engagement_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_policy_document_id` FOREIGN KEY (`policy_document_id`) REFERENCES `health_insurance_ecm`.`compliance`.`policy_document`(`policy_document_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `health_insurance_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`cap_milestone` ADD CONSTRAINT `fk_compliance_cap_milestone_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `health_insurance_ecm`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ADD CONSTRAINT `fk_compliance_breach_incident_baa_id` FOREIGN KEY (`baa_id`) REFERENCES `health_insurance_ecm`.`compliance`.`baa`(`baa_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ADD CONSTRAINT `fk_compliance_breach_incident_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `health_insurance_ecm`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ADD CONSTRAINT `fk_compliance_breach_incident_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`hipaa_privacy_request` ADD CONSTRAINT `fk_compliance_hipaa_privacy_request_breach_incident_id` FOREIGN KEY (`breach_incident_id`) REFERENCES `health_insurance_ecm`.`compliance`.`breach_incident`(`breach_incident_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`hipaa_privacy_request` ADD CONSTRAINT `fk_compliance_hipaa_privacy_request_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` ADD CONSTRAINT `fk_compliance_baa_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` ADD CONSTRAINT `fk_compliance_fwa_case_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_referral` ADD CONSTRAINT `fk_compliance_fwa_referral_fwa_case_id` FOREIGN KEY (`fwa_case_id`) REFERENCES `health_insurance_ecm`.`compliance`.`fwa_case`(`fwa_case_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`mlr_calculation` ADD CONSTRAINT `fk_compliance_mlr_calculation_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `health_insurance_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`mlr_calculation` ADD CONSTRAINT `fk_compliance_mlr_calculation_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ADD CONSTRAINT `fk_compliance_accreditation_program_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_survey` ADD CONSTRAINT `fk_compliance_accreditation_survey_accreditation_program_id` FOREIGN KEY (`accreditation_program_id`) REFERENCES `health_insurance_ecm`.`compliance`.`accreditation_program`(`accreditation_program_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_survey` ADD CONSTRAINT `fk_compliance_accreditation_survey_audit_engagement_id` FOREIGN KEY (`audit_engagement_id`) REFERENCES `health_insurance_ecm`.`compliance`.`audit_engagement`(`audit_engagement_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`policy_document` ADD CONSTRAINT `fk_compliance_policy_document_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= TAGS =========
ALTER SCHEMA `health_insurance_ecm`.`compliance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `health_insurance_ecm`.`compliance` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_obligation` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation ID');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `audit_findings` SET TAGS ('dbx_business_glossary_term' = 'Audit Findings (AUDIT_FINDINGS)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `compliance_regulatory_obligation_description` SET TAGS ('dbx_business_glossary_term' = 'Obligation Description (DESCRIPTION)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `compliance_regulatory_obligation_status` SET TAGS ('dbx_business_glossary_term' = 'Obligation Status (STATUS)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `compliance_regulatory_obligation_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|draft');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (COMPLIANCE_STATUS)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non-compliant|pending|exempt');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CORRECTIVE_ACTION_PLAN)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (EFFECTIVE_DATE)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `exemption_allowed` SET TAGS ('dbx_business_glossary_term' = 'Exemption Allowed (EXEMPTION_ALLOWED)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `exemption_criteria` SET TAGS ('dbx_business_glossary_term' = 'Exemption Criteria (EXEMPTION_CRITERIA)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (EXPIRATION_DATE)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Filing Status (FILING_STATUS)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `filing_status` SET TAGS ('dbx_value_regex' = 'filed|not_filed|pending|waived');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Obligation Frequency (FREQUENCY)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `frequency` SET TAGS ('dbx_value_regex' = 'annual|quarterly|monthly|one-time|as-needed');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `governing_body` SET TAGS ('dbx_business_glossary_term' = 'Governing Body (GOVERNING_BODY)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `is_federal` SET TAGS ('dbx_business_glossary_term' = 'Is Federal (IS_FEDERAL)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `is_state_specific` SET TAGS ('dbx_business_glossary_term' = 'Is State Specific (IS_STATE_SPECIFIC)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction (JURISDICTION)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `last_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Assessment Date (LAST_ASSESSMENT_DATE)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By (LAST_MODIFIED_BY)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `next_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Due Date (NEXT_DUE_DATE)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_business_glossary_term' = 'Obligation Code (OBLIGATION_CODE)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_business_glossary_term' = 'Obligation Type (OBLIGATION_TYPE)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_value_regex' = 'privacy|security|financial|reporting|accreditation|operational');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount (PENALTY_AMOUNT)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `penalty_currency` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency (PENALTY_CURRENCY)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `penalty_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `reference_url` SET TAGS ('dbx_business_glossary_term' = 'Reference URL (REFERENCE_URL)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework (REGULATORY_FRAMEWORK)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `reporting_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency (MONTHS)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `risk_impact` SET TAGS ('dbx_business_glossary_term' = 'Risk Impact (RISK_IMPACT)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `risk_impact` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `risk_likelihood` SET TAGS ('dbx_business_glossary_term' = 'Risk Likelihood (RISK_LIKELIHOOD)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `risk_likelihood` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score (RISK_SCORE)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SOURCE_SYSTEM)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `submission_deadline` SET TAGS ('dbx_business_glossary_term' = 'Submission Deadline (SUBMISSION_DEADLINE)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number (VERSION_NUMBER)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_submission` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission ID');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `group_renewal_id` SET TAGS ('dbx_business_glossary_term' = 'Group Renewal Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `provider_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Contract Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation ID');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `vbc_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vbc Contract Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Date');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Attachment Count');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Number');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency Code');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `filing_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Filing Fee Amount');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `filing_period_end` SET TAGS ('dbx_business_glossary_term' = 'Filing Period End Date');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `filing_period_start` SET TAGS ('dbx_business_glossary_term' = 'Filing Period Start Date');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Submission Flag');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `last_reminder_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reminder Sent Date');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `net_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Fee Amount');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_value_regex' = 'CMS|STATE_DOI|NCQA|OCR|ERISA|DOL');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `regulatory_submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `regulatory_submission_status` SET TAGS ('dbx_value_regex' = 'scheduled|draft|submitted|accepted|rejected|cancelled');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `reminder_schedule` SET TAGS ('dbx_business_glossary_term' = 'Reminder Schedule');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_description` SET TAGS ('dbx_business_glossary_term' = 'Submission Description');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'edi|portal|paper|email');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_number` SET TAGS ('dbx_business_glossary_term' = 'Submission Number');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_business_glossary_term' = 'Submission Type');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_value_regex' = 'annual_notice|rate_filing|financial_statement|accreditation|breach_notification|mlr_report');
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` SET TAGS ('dbx_subdomain' = 'audit_management');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement ID');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `adequacy_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Adequacy Assessment Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `broker_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `delegation_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Delegation Agreement Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `formulary_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `group_practice_id` SET TAGS ('dbx_business_glossary_term' = 'Group Practice Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `pbm_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Pbm Contract Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `provider_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Provider Contract Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_body` SET TAGS ('dbx_business_glossary_term' = 'Auditing Body');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_body` SET TAGS ('dbx_value_regex' = 'CMS|OCR|NCQA|URAC|State_DOI|Internal');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_category` SET TAGS ('dbx_business_glossary_term' = 'Audit Category');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_category` SET TAGS ('dbx_value_regex' = 'financial|operational|clinical|IT|security');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_cost_actual` SET TAGS ('dbx_business_glossary_term' = 'Audit Cost Actual');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Audit Cost Estimate');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_currency` SET TAGS ('dbx_business_glossary_term' = 'Audit Currency');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|JPY');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Document Reference');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_engagement_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement Status');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_engagement_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|closed|cancelled');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_findings_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Findings Reference');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_followup_required` SET TAGS ('dbx_business_glossary_term' = 'Audit Follow-up Required');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_location` SET TAGS ('dbx_business_glossary_term' = 'Audit Location');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_methodology` SET TAGS ('dbx_business_glossary_term' = 'Audit Methodology');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Number (AUDIT_NO)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_period_end` SET TAGS ('dbx_business_glossary_term' = 'Audit Period End Date');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_period_start` SET TAGS ('dbx_business_glossary_term' = 'Audit Period Start Date');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_priority` SET TAGS ('dbx_business_glossary_term' = 'Audit Priority');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_report_release_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Release Date');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'regulatory|financial|operational|internal|external');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_value_regex' = 'HIPAA|ACA|CMS|NCQA|URAC|State_DOI');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `critical_findings` SET TAGS ('dbx_business_glossary_term' = 'Critical Findings Count');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `engagement_end_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement End Date');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `engagement_start_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement Start Date');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Timestamp');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `minor_findings` SET TAGS ('dbx_business_glossary_term' = 'Minor Findings Count');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `overall_outcome` SET TAGS ('dbx_business_glossary_term' = 'Overall Audit Outcome');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `overall_outcome` SET TAGS ('dbx_value_regex' = 'favorable|unfavorable|conditional|pending');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `remediation_plan_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan Due Date');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|overdue');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `significant_findings` SET TAGS ('dbx_business_glossary_term' = 'Significant Findings Count');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `total_findings` SET TAGS ('dbx_business_glossary_term' = 'Total Findings Count');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` SET TAGS ('dbx_subdomain' = 'audit_management');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding ID');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `audit_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Related Claim Identifier (CLM_ID)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `policy_document_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Document Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `premium_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Premium Invoice Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `prior_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `affected_business_area` SET TAGS ('dbx_business_glossary_term' = 'Affected Business Area (BUS_AREA)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `affected_business_area` SET TAGS ('dbx_value_regex' = 'claims|billing|provider_network|member_services|care_management|pharmacy');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `audit_category` SET TAGS ('dbx_business_glossary_term' = 'Audit Category (CAT)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `audit_category` SET TAGS ('dbx_value_regex' = 'HIPAA|ACA|CMS|NCQA|URAC|State');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `audit_finding_description` SET TAGS ('dbx_business_glossary_term' = 'Finding Description (DESC)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `audit_finding_source` SET TAGS ('dbx_business_glossary_term' = 'Finding Source (SRC)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `audit_finding_source` SET TAGS ('dbx_value_regex' = 'internal_audit|external_audit|regulatory');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `audit_finding_status` SET TAGS ('dbx_business_glossary_term' = 'Finding Status (STAT)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `audit_finding_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|resolved|closed');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Finding Closed Timestamp (CLS_TS)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `compliance_area` SET TAGS ('dbx_business_glossary_term' = 'Compliance Area (COMP_AREA)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `compliance_area` SET TAGS ('dbx_value_regex' = 'HIPAA|ACA|CMS|NCQA|URAC|State');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `corrective_action_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Completion Date (CA_CMPL_DT)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status (CA_STAT)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (CRT_TS)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date (DUE_DT)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `effectiveness_assessment` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Assessment (EFF_ASMT)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `effectiveness_assessment` SET TAGS ('dbx_value_regex' = 'effective|partially_effective|ineffective');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `effectiveness_score` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Score (EFF_SCR)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `evidence_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Evidence Document Reference (EVD_REF)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount (FIN_IMP_AMT)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `financial_impact_currency` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Currency (FIN_IMP_CUR)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `financial_impact_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|JPY|CHF');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `finding_number` SET TAGS ('dbx_business_glossary_term' = 'Finding Number (FND)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_business_glossary_term' = 'Finding Type (FND_TYPE)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_value_regex' = 'condition|cause|effect');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `identified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Finding Identified Timestamp (ID_TS)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Finding Flag (CRIT_FLG)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `is_repeat_finding` SET TAGS ('dbx_business_glossary_term' = 'Repeat Finding Flag (REPEAT_FLG)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `last_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Review Timestamp (LRV_TS)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (NOTE)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Finding Priority (PRIO)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation (CIT)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `remediation_action` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action (RM_ACT)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date (RM_DUE_DT)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `resolution` SET TAGS ('dbx_business_glossary_term' = 'Finding Resolution (RES)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `resolution` SET TAGS ('dbx_value_regex' = 'remediated|waived|deferred|rejected');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By Identifier (RVW_BY_ID)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score (RSK_SCR)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `risk_score_source` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Source (RSK_SRC)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `risk_score_source` SET TAGS ('dbx_value_regex' = 'internal|external|model');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis (RCA)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level (SEV)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|significant|minor');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Finding Tags (TAG)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (UPD_TS)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Finding Version (VER)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`corrective_action_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`compliance`.`corrective_action_plan` SET TAGS ('dbx_subdomain' = 'audit_management');
ALTER TABLE `health_insurance_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `corrective_action_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan ID');
ALTER TABLE `health_insurance_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `health_insurance_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `actual_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual CAP Cost (USD)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `actual_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `audit_comments` SET TAGS ('dbx_business_glossary_term' = 'Audit Comments');
ALTER TABLE `health_insurance_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'CAP Closed Timestamp');
ALTER TABLE `health_insurance_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `compliance_category` SET TAGS ('dbx_business_glossary_term' = 'Compliance Category');
ALTER TABLE `health_insurance_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `compliance_category` SET TAGS ('dbx_value_regex' = 'privacy|security|financial|clinical|operational');
ALTER TABLE `health_insurance_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline');
ALTER TABLE `health_insurance_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `corrective_action_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan Status');
ALTER TABLE `health_insurance_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `corrective_action_plan_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|in_progress|completed|closed|rejected');
ALTER TABLE `health_insurance_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'CAP Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `estimated_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated CAP Cost (USD)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `estimated_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `evidence_document_path` SET TAGS ('dbx_business_glossary_term' = 'Evidence Document Path');
ALTER TABLE `health_insurance_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `is_external_audit` SET TAGS ('dbx_business_glossary_term' = 'External Audit Flag');
ALTER TABLE `health_insurance_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `is_fwa_monitoring` SET TAGS ('dbx_business_glossary_term' = 'Fraud Waste Abuse Monitoring Flag');
ALTER TABLE `health_insurance_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `last_milestone_status` SET TAGS ('dbx_business_glossary_term' = 'Last Milestone Status');
ALTER TABLE `health_insurance_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `last_milestone_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|blocked');
ALTER TABLE `health_insurance_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `milestone_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Milestones');
ALTER TABLE `health_insurance_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'CAP General Notes');
ALTER TABLE `health_insurance_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `owner_role` SET TAGS ('dbx_business_glossary_term' = 'CAP Owner Role');
ALTER TABLE `health_insurance_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `owner_role` SET TAGS ('dbx_value_regex' = 'compliance_officer|risk_manager|clinical_lead|finance_lead|operations_manager');
ALTER TABLE `health_insurance_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan Name');
ALTER TABLE `health_insurance_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan Number');
ALTER TABLE `health_insurance_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan Type');
ALTER TABLE `health_insurance_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'audit|regulatory|operational|clinical|financial');
ALTER TABLE `health_insurance_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'CAP Priority');
ALTER TABLE `health_insurance_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `health_insurance_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `health_insurance_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `remediation_strategy` SET TAGS ('dbx_business_glossary_term' = 'Remediation Strategy');
ALTER TABLE `health_insurance_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'CAP Risk Score');
ALTER TABLE `health_insurance_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `health_insurance_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'CAP Severity');
ALTER TABLE `health_insurance_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'minor|moderate|major|severe');
ALTER TABLE `health_insurance_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `health_insurance_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'CAP Last Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`compliance`.`cap_milestone` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`compliance`.`cap_milestone` SET TAGS ('dbx_subdomain' = 'audit_management');
ALTER TABLE `health_insurance_ecm`.`compliance`.`cap_milestone` ALTER COLUMN `cap_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Cap Milestone ID');
ALTER TABLE `health_insurance_ecm`.`compliance`.`cap_milestone` ALTER COLUMN `corrective_action_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan ID');
ALTER TABLE `health_insurance_ecm`.`compliance`.`cap_milestone` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `health_insurance_ecm`.`compliance`.`cap_milestone` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `health_insurance_ecm`.`compliance`.`cap_milestone` ALTER COLUMN `cap_milestone_status` SET TAGS ('dbx_business_glossary_term' = 'Milestone Status');
ALTER TABLE `health_insurance_ecm`.`compliance`.`cap_milestone` ALTER COLUMN `cap_milestone_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|blocked|deferred|cancelled');
ALTER TABLE `health_insurance_ecm`.`compliance`.`cap_milestone` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completion Percentage');
ALTER TABLE `health_insurance_ecm`.`compliance`.`cap_milestone` ALTER COLUMN `compliance_category` SET TAGS ('dbx_business_glossary_term' = 'Compliance Category');
ALTER TABLE `health_insurance_ecm`.`compliance`.`cap_milestone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`compliance`.`cap_milestone` ALTER COLUMN `escalated_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalated Flag');
ALTER TABLE `health_insurance_ecm`.`compliance`.`cap_milestone` ALTER COLUMN `evidence_documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Evidence Documentation URL');
ALTER TABLE `health_insurance_ecm`.`compliance`.`cap_milestone` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Is Critical Flag');
ALTER TABLE `health_insurance_ecm`.`compliance`.`cap_milestone` ALTER COLUMN `milestone_code` SET TAGS ('dbx_business_glossary_term' = 'Milestone Code (Unique Identifier)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`cap_milestone` ALTER COLUMN `milestone_description` SET TAGS ('dbx_business_glossary_term' = 'Milestone Description');
ALTER TABLE `health_insurance_ecm`.`compliance`.`cap_milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_business_glossary_term' = 'Milestone Name');
ALTER TABLE `health_insurance_ecm`.`compliance`.`cap_milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_business_glossary_term' = 'Milestone Type (e.g., Documentation, Training, Process Change, System Update, Audit, Review)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`cap_milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_value_regex' = 'documentation|training|process_change|system_update|audit|review');
ALTER TABLE `health_insurance_ecm`.`compliance`.`cap_milestone` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Milestone Notes');
ALTER TABLE `health_insurance_ecm`.`compliance`.`cap_milestone` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `health_insurance_ecm`.`compliance`.`cap_milestone` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `health_insurance_ecm`.`compliance`.`cap_milestone` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Milestone Priority');
ALTER TABLE `health_insurance_ecm`.`compliance`.`cap_milestone` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `health_insurance_ecm`.`compliance`.`cap_milestone` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `health_insurance_ecm`.`compliance`.`cap_milestone` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `health_insurance_ecm`.`compliance`.`cap_milestone` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `health_insurance_ecm`.`compliance`.`cap_milestone` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` SET TAGS ('dbx_subdomain' = 'privacy_protection');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `breach_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Breach Incident Identifier');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `baa_id` SET TAGS ('dbx_business_glossary_term' = 'Baa Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `corrective_action_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Group Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `provider_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Contract Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `affected_phi_categories` SET TAGS ('dbx_business_glossary_term' = 'Affected PHI Categories');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `affected_phi_categories` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `affected_phi_categories` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `audit_findings` SET TAGS ('dbx_business_glossary_term' = 'Audit Findings');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `audit_findings` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `audit_findings` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `breach_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Breach Cause Description');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `breach_cause_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `breach_cause_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `breach_discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Breach Discovery Date');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `breach_incident_number` SET TAGS ('dbx_business_glossary_term' = 'Breach Incident Number');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `breach_occurrence_date` SET TAGS ('dbx_business_glossary_term' = 'Breach Occurrence Date');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `breach_report_url` SET TAGS ('dbx_business_glossary_term' = 'External Breach Report URL');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `breach_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Breach Resolution Date');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `breach_source` SET TAGS ('dbx_business_glossary_term' = 'Breach Source');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `breach_source` SET TAGS ('dbx_value_regex' = 'internal|external|partner|unknown');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `breach_status` SET TAGS ('dbx_business_glossary_term' = 'Breach Status (Lifecycle)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `breach_status` SET TAGS ('dbx_value_regex' = 'open|investigating|closed|pending|resolved');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `breach_type` SET TAGS ('dbx_business_glossary_term' = 'Breach Type (Category)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `breach_type` SET TAGS ('dbx_value_regex' = 'unauthorized_access|theft|loss|improper_disposal|other');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `business_associate_involved` SET TAGS ('dbx_business_glossary_term' = 'Business Associate Involved');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `hhs_notification_date` SET TAGS ('dbx_business_glossary_term' = 'HHS Notification Date');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `hhs_notified` SET TAGS ('dbx_business_glossary_term' = 'HHS Notified');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `notification_content_version` SET TAGS ('dbx_business_glossary_term' = 'Notification Content Version');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `notification_delivery_confirmation` SET TAGS ('dbx_business_glossary_term' = 'Notification Delivery Confirmation');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Notification Method');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `notification_method` SET TAGS ('dbx_value_regex' = 'mail|email|substitute_notice|phone|fax');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `notification_obligation` SET TAGS ('dbx_business_glossary_term' = 'Notification Obligation');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `notification_obligation` SET TAGS ('dbx_value_regex' = 'individual|hhs|state|media|none');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `notification_recipient_count` SET TAGS ('dbx_business_glossary_term' = 'Notification Recipient Count');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `notification_type` SET TAGS ('dbx_business_glossary_term' = 'Notification Type');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `notification_type` SET TAGS ('dbx_value_regex' = 'individual|hhs|state|media');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `number_of_individuals_affected` SET TAGS ('dbx_business_glossary_term' = 'Number of Individuals Affected');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `number_of_records_affected` SET TAGS ('dbx_business_glossary_term' = 'Number of Records Affected');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `regulatory_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Date');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `regulatory_filing_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Status');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `regulatory_filing_status` SET TAGS ('dbx_value_regex' = 'not_filed|filed|rejected|accepted');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `risk_assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Method');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `risk_assessment_method` SET TAGS ('dbx_value_regex' = 'qualitative|quantitative|hybrid');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `risk_assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Score');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `state_notification_date` SET TAGS ('dbx_business_glossary_term' = 'State Notification Date');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `state_notified` SET TAGS ('dbx_business_glossary_term' = 'State Notified');
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`compliance`.`hipaa_privacy_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`compliance`.`hipaa_privacy_request` SET TAGS ('dbx_subdomain' = 'privacy_protection');
ALTER TABLE `health_insurance_ecm`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `hipaa_privacy_request_id` SET TAGS ('dbx_business_glossary_term' = 'HIPAA Privacy Request ID');
ALTER TABLE `health_insurance_ecm`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `breach_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Breach Incident Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `health_insurance_ecm`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `appeal_deadline` SET TAGS ('dbx_business_glossary_term' = 'Appeal Deadline');
ALTER TABLE `health_insurance_ecm`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome');
ALTER TABLE `health_insurance_ecm`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_value_regex' = 'upheld|reversed|denied|withdrawn');
ALTER TABLE `health_insurance_ecm`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `audit_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `audit_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `health_insurance_ecm`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `denial_reason` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason');
ALTER TABLE `health_insurance_ecm`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `disclosure_authorization_basis` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Authorization Basis');
ALTER TABLE `health_insurance_ecm`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `disclosure_authorization_basis` SET TAGS ('dbx_value_regex' = 'patient_authorization|legal_requirement|public_interest|court_order');
ALTER TABLE `health_insurance_ecm`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `disclosure_date` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Date');
ALTER TABLE `health_insurance_ecm`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `disclosure_logged` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Logged Indicator');
ALTER TABLE `health_insurance_ecm`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `disclosure_phicategories` SET TAGS ('dbx_business_glossary_term' = 'Disclosed PHI Categories');
ALTER TABLE `health_insurance_ecm`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `disclosure_purpose` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Purpose');
ALTER TABLE `health_insurance_ecm`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `disclosure_recipient_type` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Recipient Type');
ALTER TABLE `health_insurance_ecm`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `disclosure_recipient_type` SET TAGS ('dbx_value_regex' = 'public_health|law_enforcement|research|legal|other');
ALTER TABLE `health_insurance_ecm`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Request Disposition');
ALTER TABLE `health_insurance_ecm`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `is_appealed` SET TAGS ('dbx_business_glossary_term' = 'Appeal Indicator');
ALTER TABLE `health_insurance_ecm`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `is_confidential_communication` SET TAGS ('dbx_business_glossary_term' = 'Confidential Communication Request');
ALTER TABLE `health_insurance_ecm`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `request_channel` SET TAGS ('dbx_business_glossary_term' = 'Request Channel');
ALTER TABLE `health_insurance_ecm`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `request_channel` SET TAGS ('dbx_value_regex' = 'digital|paper|phone');
ALTER TABLE `health_insurance_ecm`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `request_description` SET TAGS ('dbx_business_glossary_term' = 'Request Description');
ALTER TABLE `health_insurance_ecm`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Request Number');
ALTER TABLE `health_insurance_ecm`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `request_received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Received Timestamp');
ALTER TABLE `health_insurance_ecm`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `request_source` SET TAGS ('dbx_business_glossary_term' = 'Request Source');
ALTER TABLE `health_insurance_ecm`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `request_source` SET TAGS ('dbx_value_regex' = 'portal|email|phone|fax|mail');
ALTER TABLE `health_insurance_ecm`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Request Status');
ALTER TABLE `health_insurance_ecm`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `request_status` SET TAGS ('dbx_value_regex' = 'pending|in_review|completed|denied|partially_granted|closed');
ALTER TABLE `health_insurance_ecm`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `request_type` SET TAGS ('dbx_business_glossary_term' = 'Request Type');
ALTER TABLE `health_insurance_ecm`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `request_type` SET TAGS ('dbx_value_regex' = 'access|amendment|accounting|restriction|confidential_communication');
ALTER TABLE `health_insurance_ecm`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `response_date` SET TAGS ('dbx_business_glossary_term' = 'Response Date');
ALTER TABLE `health_insurance_ecm`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` SET TAGS ('dbx_subdomain' = 'privacy_protection');
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` ALTER COLUMN `baa_id` SET TAGS ('dbx_business_glossary_term' = 'Business Associate Agreement Identifier (BAA_ID)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` ALTER COLUMN `delegation_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Delegation Agreement Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` ALTER COLUMN `group_practice_id` SET TAGS ('dbx_business_glossary_term' = 'Group Practice Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` ALTER COLUMN `provider_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Provider Contract Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` ALTER COLUMN `tpa_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Tpa Arrangement Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number (AGREEMENT_NUMBER)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status (AGREEMENT_STATUS)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'active|terminated|pending|draft|suspended');
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count (AMENDMENT_COUNT)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` ALTER COLUMN `audit_rights` SET TAGS ('dbx_business_glossary_term' = 'Audit Rights (AUDIT_RIGHTS)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` ALTER COLUMN `audit_rights` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` ALTER COLUMN `breach_notification_requirements` SET TAGS ('dbx_business_glossary_term' = 'Breach Notification Requirements (BREACH_NOTIFICATION_REQUIREMENTS)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` ALTER COLUMN `breach_notification_requirements` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` ALTER COLUMN `business_associate_name` SET TAGS ('dbx_business_glossary_term' = 'Business Associate Name (BUSINESS_ASSOCIATE_NAME)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` ALTER COLUMN `business_associate_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` ALTER COLUMN `business_associate_type` SET TAGS ('dbx_business_glossary_term' = 'Business Associate Type (BUSINESS_ASSOCIATE_TYPE)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` ALTER COLUMN `business_associate_type` SET TAGS ('dbx_value_regex' = 'vendor|tpa|pbm|clearinghouse|other');
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` ALTER COLUMN `data_disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Data Disposal Method (DATA_DISPOSAL_METHOD)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` ALTER COLUMN `data_disposal_method` SET TAGS ('dbx_value_regex' = 'destroy|deidentify|archive|return|other');
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` ALTER COLUMN `data_retention_period_months` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period (MONTHS) (DATA_RETENTION_PERIOD_MONTHS)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EFFECTIVE_END_DATE)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFFECTIVE_START_DATE)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law (GOVERNING_LAW)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction (JURISDICTION)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date (LAST_AMENDMENT_DATE)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` ALTER COLUMN `permitted_phis` SET TAGS ('dbx_business_glossary_term' = 'Permitted PHI Types (PERMITTED_PHIS)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` ALTER COLUMN `permitted_phis` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference (REGULATORY_REFERENCE)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` ALTER COLUMN `renewal_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period (DAYS) (RENEWAL_NOTICE_PERIOD_DAYS)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` ALTER COLUMN `renewal_option` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option (RENEWAL_OPTION)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` ALTER COLUMN `renewal_option` SET TAGS ('dbx_value_regex' = 'auto|manual|none');
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` ALTER COLUMN `scope_of_phi_use` SET TAGS ('dbx_business_glossary_term' = 'Scope of PHI Use (SCOPE_OF_PHI_USE)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` ALTER COLUMN `scope_of_phi_use` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` ALTER COLUMN `security_obligations` SET TAGS ('dbx_business_glossary_term' = 'Security Obligations (SECURITY_OBLIGATIONS)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` ALTER COLUMN `security_obligations` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` ALTER COLUMN `subcontractor_allowed` SET TAGS ('dbx_business_glossary_term' = 'Subcontractor Allowed Flag (SUBCONTRACTOR_ALLOWED)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` ALTER COLUMN `subcontractor_details` SET TAGS ('dbx_business_glossary_term' = 'Subcontractor Details (SUBCONTRACTOR_DETAILS)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` ALTER COLUMN `subcontractor_details` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` ALTER COLUMN `termination_clause` SET TAGS ('dbx_business_glossary_term' = 'Termination Clause (TERMINATION_CLAUSE)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` ALTER COLUMN `termination_clause` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` ALTER COLUMN `fwa_case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud, Waste, and Abuse Case ID (FWA_CASE_ID)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` ALTER COLUMN `broker_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Group Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` ALTER COLUMN `premium_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Premium Payment Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` ALTER COLUMN `provider_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Provider Contract Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` ALTER COLUMN `vbc_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vbc Contract Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` ALTER COLUMN `allegation_description` SET TAGS ('dbx_business_glossary_term' = 'Allegation Description (ALLEG_DESC)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` ALTER COLUMN `audit_log_url` SET TAGS ('dbx_business_glossary_term' = 'Audit Log URL (AUDIT_LOG_URL)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` ALTER COLUMN `case_disposition` SET TAGS ('dbx_business_glossary_term' = 'Case Disposition (CASE_DISP)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` ALTER COLUMN `case_disposition` SET TAGS ('dbx_value_regex' = 'substantiated|unsubstantiated|law_enforcement|civil_penalty|referred');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Case Number (CASE_NO)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` ALTER COLUMN `case_open_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Case Open Timestamp (CASE_OPEN_TS)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Case Status (CASE_STATUS)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` ALTER COLUMN `case_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|closed|referred|settled');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` ALTER COLUMN `case_type` SET TAGS ('dbx_business_glossary_term' = 'Case Type (CASE_TYPE)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` ALTER COLUMN `case_type` SET TAGS ('dbx_value_regex' = 'fraud|waste|abuse');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (CREATED_TS)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR_CD)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` ALTER COLUMN `disposition_date` SET TAGS ('dbx_business_glossary_term' = 'Disposition Date (DISP_DT)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` ALTER COLUMN `estimated_exposure_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Financial Exposure Amount (EST_EXP_AMT)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` ALTER COLUMN `evidence_reference` SET TAGS ('dbx_business_glossary_term' = 'Evidence Reference (EVID_REF)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` ALTER COLUMN `is_high_risk` SET TAGS ('dbx_business_glossary_term' = 'High Risk Indicator (HIGH_RISK_FLG)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Case Notes (CASE_NOTES)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` ALTER COLUMN `recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Recovery Amount (RECOVERY_AMT)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` ALTER COLUMN `referral_date` SET TAGS ('dbx_business_glossary_term' = 'Referral Date (REF_DT)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` ALTER COLUMN `referral_source` SET TAGS ('dbx_business_glossary_term' = 'Referral Source (REF_SRC)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` ALTER COLUMN `referral_source` SET TAGS ('dbx_value_regex' = 'claim_edit|data_mining|tip_line|law_enforcement|employee_report');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag (REG_REPORT_FLG)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score (RISK_SCORE)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` ALTER COLUMN `subject_reference` SET TAGS ('dbx_business_glossary_term' = 'Subject Identifier (SUBJ_ID)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` ALTER COLUMN `subject_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` ALTER COLUMN `subject_reference` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` ALTER COLUMN `subject_type` SET TAGS ('dbx_business_glossary_term' = 'Subject Type (SUBJ_TYPE)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` ALTER COLUMN `subject_type` SET TAGS ('dbx_value_regex' = 'member|provider|employer_group');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` ALTER COLUMN `triage_outcome` SET TAGS ('dbx_business_glossary_term' = 'Triage Outcome (TRIAGE_OUT)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` ALTER COLUMN `triage_outcome` SET TAGS ('dbx_value_regex' = 'escalated|closed|investigate|dismissed');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (UPDATED_TS)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_referral` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_referral` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_referral` ALTER COLUMN `fwa_referral_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Waste Abuse Referral ID (FWA_REFERRAL_ID)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_referral` ALTER COLUMN `fwa_case_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Case Identifier (CASE_ID)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_referral` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identifier (MEMBER_ID)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_referral` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_referral` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_referral` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_referral` ALTER COLUMN `provider_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Provider Contract Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_referral` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_referral` ALTER COLUMN `allegation_description` SET TAGS ('dbx_business_glossary_term' = 'Allegation Description (ALLEG_DESC)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_referral` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_referral` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURRENCY_CD)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_referral` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|JPY');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_referral` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date (DUE_DATE)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_referral` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag (ESCALATION_FLAG)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_referral` ALTER COLUMN `estimated_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Loss Amount (EST_LOSS_AMT)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_referral` ALTER COLUMN `evidence_reference` SET TAGS ('dbx_business_glossary_term' = 'Evidence Reference (EVID_REF)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_referral` ALTER COLUMN `fwa_referral_status` SET TAGS ('dbx_business_glossary_term' = 'Referral Status (REF_STATUS)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_referral` ALTER COLUMN `fwa_referral_status` SET TAGS ('dbx_value_regex' = 'new|in_review|assigned|closed|rejected');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_referral` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_referral` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority (PRIORITY)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_referral` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_referral` ALTER COLUMN `referral_date` SET TAGS ('dbx_business_glossary_term' = 'Referral Date (REF_DATE)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_referral` ALTER COLUMN `referral_number` SET TAGS ('dbx_business_glossary_term' = 'Referral Number (REF_NUM)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_referral` ALTER COLUMN `referral_source` SET TAGS ('dbx_business_glossary_term' = 'Referral Source (REF_SOURCE)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_referral` ALTER COLUMN `referral_source` SET TAGS ('dbx_value_regex' = 'internal_detection|employee|member|provider|external_agency');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_referral` ALTER COLUMN `referral_type` SET TAGS ('dbx_business_glossary_term' = 'Referral Type (REF_TYPE)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_referral` ALTER COLUMN `referral_type` SET TAGS ('dbx_value_regex' = 'fraud|waste|abuse|billing_error|other');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_referral` ALTER COLUMN `subject_type` SET TAGS ('dbx_business_glossary_term' = 'Subject Type (SUBJ_TYPE)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_referral` ALTER COLUMN `subject_type` SET TAGS ('dbx_value_regex' = 'member|provider|employee|other');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_referral` ALTER COLUMN `triage_outcome` SET TAGS ('dbx_business_glossary_term' = 'Triage Outcome (TRIAGE_OUTCOME)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_referral` ALTER COLUMN `triage_outcome` SET TAGS ('dbx_value_regex' = 'opened|closed|dismissed|escalated|pending');
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_referral` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`mlr_calculation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`compliance`.`mlr_calculation` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `health_insurance_ecm`.`compliance`.`mlr_calculation` ALTER COLUMN `mlr_calculation_id` SET TAGS ('dbx_business_glossary_term' = 'Mlr Calculation Identifier');
ALTER TABLE `health_insurance_ecm`.`compliance`.`mlr_calculation` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`mlr_calculation` ALTER COLUMN `fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`mlr_calculation` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Group Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`mlr_calculation` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Identifier');
ALTER TABLE `health_insurance_ecm`.`compliance`.`mlr_calculation` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`compliance`.`mlr_calculation` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`compliance`.`mlr_calculation` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`mlr_calculation` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`mlr_calculation` ALTER COLUMN `year_id` SET TAGS ('dbx_business_glossary_term' = 'Year Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`mlr_calculation` ALTER COLUMN `calculation_date` SET TAGS ('dbx_business_glossary_term' = 'MLR Calculation Date');
ALTER TABLE `health_insurance_ecm`.`compliance`.`mlr_calculation` ALTER COLUMN `calculation_number` SET TAGS ('dbx_business_glossary_term' = 'MLR Calculation Number');
ALTER TABLE `health_insurance_ecm`.`compliance`.`mlr_calculation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`compliance`.`mlr_calculation` ALTER COLUMN `earned_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Earned Premium Amount');
ALTER TABLE `health_insurance_ecm`.`compliance`.`mlr_calculation` ALTER COLUMN `incurred_claims_amount` SET TAGS ('dbx_business_glossary_term' = 'Incurred Claims Amount');
ALTER TABLE `health_insurance_ecm`.`compliance`.`mlr_calculation` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`mlr_calculation` ALTER COLUMN `market_segment_code` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Code');
ALTER TABLE `health_insurance_ecm`.`compliance`.`mlr_calculation` ALTER COLUMN `mlr_calculation_status` SET TAGS ('dbx_business_glossary_term' = 'MLR Calculation Status');
ALTER TABLE `health_insurance_ecm`.`compliance`.`mlr_calculation` ALTER COLUMN `mlr_calculation_status` SET TAGS ('dbx_value_regex' = 'pending|calculated|approved|rejected');
ALTER TABLE `health_insurance_ecm`.`compliance`.`mlr_calculation` ALTER COLUMN `mlr_percentage` SET TAGS ('dbx_business_glossary_term' = 'Medical Loss Ratio Percentage');
ALTER TABLE `health_insurance_ecm`.`compliance`.`mlr_calculation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'MLR Calculation Notes');
ALTER TABLE `health_insurance_ecm`.`compliance`.`mlr_calculation` ALTER COLUMN `quality_improvement_expenses_amount` SET TAGS ('dbx_business_glossary_term' = 'Quality Improvement Expenses Amount');
ALTER TABLE `health_insurance_ecm`.`compliance`.`mlr_calculation` ALTER COLUMN `rebate_amount` SET TAGS ('dbx_business_glossary_term' = 'Rebate Amount');
ALTER TABLE `health_insurance_ecm`.`compliance`.`mlr_calculation` ALTER COLUMN `rebate_disbursement_date` SET TAGS ('dbx_business_glossary_term' = 'Rebate Disbursement Date');
ALTER TABLE `health_insurance_ecm`.`compliance`.`mlr_calculation` ALTER COLUMN `rebate_disbursement_status` SET TAGS ('dbx_business_glossary_term' = 'Rebate Disbursement Status');
ALTER TABLE `health_insurance_ecm`.`compliance`.`mlr_calculation` ALTER COLUMN `rebate_disbursement_status` SET TAGS ('dbx_value_regex' = 'not_started|in_process|completed|failed');
ALTER TABLE `health_insurance_ecm`.`compliance`.`mlr_calculation` ALTER COLUMN `rebate_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Rebate Eligibility Indicator');
ALTER TABLE `health_insurance_ecm`.`compliance`.`mlr_calculation` ALTER COLUMN `reporting_year` SET TAGS ('dbx_business_glossary_term' = 'Reporting Year');
ALTER TABLE `health_insurance_ecm`.`compliance`.`mlr_calculation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `health_insurance_ecm`.`compliance`.`mlr_calculation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `health_insurance_ecm`.`compliance`.`mlr_calculation` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Record Version Number');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` SET TAGS ('dbx_subdomain' = 'accreditation_standards');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `accreditation_program_id` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Program Identifier');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `accountable_owner` SET TAGS ('dbx_business_glossary_term' = 'Accountable Business Owner');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `accreditation_program_level` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Level');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `accreditation_program_status` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `accreditation_program_status` SET TAGS ('dbx_value_regex' = 'accredited|provisional|denied|pending|revoked');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `accreditation_type` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Type');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `accreditation_type` SET TAGS ('dbx_value_regex' = 'health_plan|provider|pharmacy|network|member');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `accrediting_body` SET TAGS ('dbx_business_glossary_term' = 'Accrediting Body');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `applicable_standards` SET TAGS ('dbx_business_glossary_term' = 'Applicable Standards');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `benchmark_thresholds` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Thresholds');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Completion Percentage');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `compliance_category` SET TAGS ('dbx_business_glossary_term' = 'Compliance Category');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `conditions` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Conditions');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `decision` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Decision');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `decision` SET TAGS ('dbx_value_regex' = 'accredited|denied|conditional|revoked');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Effective Date');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Expiration Date');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `escalated_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `evidence_documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Evidence Documentation URL');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `final_score` SET TAGS ('dbx_business_glossary_term' = 'Final Accreditation Score');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Accreditation Flag');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `measure_thresholds` SET TAGS ('dbx_business_glossary_term' = 'Measure Thresholds');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `measures` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Measures');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `next_survey_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Survey Due Date');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'General Notes');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `preliminary_findings` SET TAGS ('dbx_business_glossary_term' = 'Preliminary Findings');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Program Code');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Program Name');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `rating` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Rating');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `rating` SET TAGS ('dbx_value_regex' = '1_star|2_star|3_star|4_star|5_star');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `recommendations` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Recommendations');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `renewal_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Cycle (Months)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Risk Level');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `scope` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Scope');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `survey_end_date` SET TAGS ('dbx_business_glossary_term' = 'Survey End Date');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `survey_start_date` SET TAGS ('dbx_business_glossary_term' = 'Survey Start Date');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `survey_type` SET TAGS ('dbx_business_glossary_term' = 'Survey Type');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `survey_type` SET TAGS ('dbx_value_regex' = 'initial|renewal|focused');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `surveyor_contact` SET TAGS ('dbx_business_glossary_term' = 'Surveyor Contact Email');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `surveyor_contact` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `surveyor_contact` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `surveyor_contact` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `surveyor_team` SET TAGS ('dbx_business_glossary_term' = 'Surveyor Team');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_survey` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_survey` SET TAGS ('dbx_subdomain' = 'accreditation_standards');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_survey` ALTER COLUMN `accreditation_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Survey ID');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_survey` ALTER COLUMN `accreditation_program_id` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Program ID');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_survey` ALTER COLUMN `audit_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_survey` ALTER COLUMN `delegation_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Delegation Agreement Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_survey` ALTER COLUMN `accreditation_decision` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Decision');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_survey` ALTER COLUMN `accreditation_decision` SET TAGS ('dbx_value_regex' = 'accredited|conditionally_accredited|not_accredited|pending');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_survey` ALTER COLUMN `accreditation_survey_status` SET TAGS ('dbx_business_glossary_term' = 'Survey Status');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_survey` ALTER COLUMN `accreditation_survey_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|closed|cancelled');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_survey` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_survey` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Survey End Timestamp');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_survey` ALTER COLUMN `evidence_documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Evidence Documentation URL');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_survey` ALTER COLUMN `final_score` SET TAGS ('dbx_business_glossary_term' = 'Final Survey Score');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_survey` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Survey Notes');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_survey` ALTER COLUMN `preliminary_findings` SET TAGS ('dbx_business_glossary_term' = 'Preliminary Findings');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_survey` ALTER COLUMN `rating` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Rating');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_survey` ALTER COLUMN `recommendation` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Recommendation');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_survey` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Survey Risk Level');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_survey` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_survey` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Survey Start Timestamp');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_survey` ALTER COLUMN `survey_location` SET TAGS ('dbx_business_glossary_term' = 'Survey Location');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_survey` ALTER COLUMN `survey_method` SET TAGS ('dbx_business_glossary_term' = 'Survey Method');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_survey` ALTER COLUMN `survey_method` SET TAGS ('dbx_value_regex' = 'onsite|remote|hybrid');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_survey` ALTER COLUMN `survey_number` SET TAGS ('dbx_business_glossary_term' = 'Survey Number');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_survey` ALTER COLUMN `survey_region_code` SET TAGS ('dbx_business_glossary_term' = 'Survey Region Code');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_survey` ALTER COLUMN `survey_region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_survey` ALTER COLUMN `survey_scope` SET TAGS ('dbx_business_glossary_term' = 'Survey Scope');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_survey` ALTER COLUMN `survey_type` SET TAGS ('dbx_business_glossary_term' = 'Survey Type');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_survey` ALTER COLUMN `survey_type` SET TAGS ('dbx_value_regex' = 'initial|renewal|focused|ad_hoc');
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_survey` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `health_insurance_ecm`.`compliance`.`policy_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`compliance`.`policy_document` SET TAGS ('dbx_subdomain' = 'accreditation_standards');
ALTER TABLE `health_insurance_ecm`.`compliance`.`policy_document` ALTER COLUMN `policy_document_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Document Identifier');
ALTER TABLE `health_insurance_ecm`.`compliance`.`policy_document` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`policy_document` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`compliance`.`policy_document` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`compliance`.`policy_document` ALTER COLUMN `provider_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Contract Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`policy_document` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`policy_document` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Approval Date');
ALTER TABLE `health_insurance_ecm`.`compliance`.`policy_document` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Policy Approval Status');
ALTER TABLE `health_insurance_ecm`.`compliance`.`policy_document` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `health_insurance_ecm`.`compliance`.`policy_document` ALTER COLUMN `archive_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Archive Date');
ALTER TABLE `health_insurance_ecm`.`compliance`.`policy_document` ALTER COLUMN `compliance_area` SET TAGS ('dbx_business_glossary_term' = 'Compliance Area');
ALTER TABLE `health_insurance_ecm`.`compliance`.`policy_document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Policy Confidentiality Level');
ALTER TABLE `health_insurance_ecm`.`compliance`.`policy_document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `health_insurance_ecm`.`compliance`.`policy_document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`compliance`.`policy_document` ALTER COLUMN `distribution_scope` SET TAGS ('dbx_business_glossary_term' = 'Policy Distribution Scope');
ALTER TABLE `health_insurance_ecm`.`compliance`.`policy_document` ALTER COLUMN `document_format` SET TAGS ('dbx_business_glossary_term' = 'Policy Document Format');
ALTER TABLE `health_insurance_ecm`.`compliance`.`policy_document` ALTER COLUMN `document_format` SET TAGS ('dbx_value_regex' = 'pdf|docx|html');
ALTER TABLE `health_insurance_ecm`.`compliance`.`policy_document` ALTER COLUMN `document_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Policy Document Size (Bytes)');
ALTER TABLE `health_insurance_ecm`.`compliance`.`policy_document` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Policy Document URL');
ALTER TABLE `health_insurance_ecm`.`compliance`.`policy_document` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Effective Date');
ALTER TABLE `health_insurance_ecm`.`compliance`.`policy_document` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Expiration Date');
ALTER TABLE `health_insurance_ecm`.`compliance`.`policy_document` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `health_insurance_ecm`.`compliance`.`policy_document` ALTER COLUMN `is_archived` SET TAGS ('dbx_business_glossary_term' = 'Is Archived Flag');
ALTER TABLE `health_insurance_ecm`.`compliance`.`policy_document` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Is Confidential Flag');
ALTER TABLE `health_insurance_ecm`.`compliance`.`policy_document` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Policy Review Date');
ALTER TABLE `health_insurance_ecm`.`compliance`.`policy_document` ALTER COLUMN `policy_code` SET TAGS ('dbx_business_glossary_term' = 'Policy Document Code');
ALTER TABLE `health_insurance_ecm`.`compliance`.`policy_document` ALTER COLUMN `policy_document_category` SET TAGS ('dbx_business_glossary_term' = 'Policy Category');
ALTER TABLE `health_insurance_ecm`.`compliance`.`policy_document` ALTER COLUMN `policy_document_status` SET TAGS ('dbx_business_glossary_term' = 'Policy Status');
ALTER TABLE `health_insurance_ecm`.`compliance`.`policy_document` ALTER COLUMN `policy_document_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|retired');
ALTER TABLE `health_insurance_ecm`.`compliance`.`policy_document` ALTER COLUMN `policy_name` SET TAGS ('dbx_business_glossary_term' = 'Policy Document Name');
ALTER TABLE `health_insurance_ecm`.`compliance`.`policy_document` ALTER COLUMN `policy_owner_department` SET TAGS ('dbx_business_glossary_term' = 'Policy Owner Department');
ALTER TABLE `health_insurance_ecm`.`compliance`.`policy_document` ALTER COLUMN `regulatory_citations` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citations');
ALTER TABLE `health_insurance_ecm`.`compliance`.`policy_document` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Review Date');
ALTER TABLE `health_insurance_ecm`.`compliance`.`policy_document` ALTER COLUMN `review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Policy Review Outcome');
ALTER TABLE `health_insurance_ecm`.`compliance`.`policy_document` ALTER COLUMN `review_outcome` SET TAGS ('dbx_value_regex' = 'approved|revised|retired');
ALTER TABLE `health_insurance_ecm`.`compliance`.`policy_document` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Policy Review Type');
ALTER TABLE `health_insurance_ecm`.`compliance`.`policy_document` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = 'annual|triggered|regulatory_change');
ALTER TABLE `health_insurance_ecm`.`compliance`.`policy_document` ALTER COLUMN `revision_summary` SET TAGS ('dbx_business_glossary_term' = 'Policy Revision Summary');
ALTER TABLE `health_insurance_ecm`.`compliance`.`policy_document` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By');
ALTER TABLE `health_insurance_ecm`.`compliance`.`policy_document` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `health_insurance_ecm`.`compliance`.`policy_document` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Policy Version Number');
ALTER TABLE `health_insurance_ecm`.`compliance`.`policy_document` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
