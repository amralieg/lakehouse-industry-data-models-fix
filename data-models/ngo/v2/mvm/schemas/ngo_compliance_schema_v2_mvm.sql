-- Schema for Domain: compliance | Business: Ngo | Version: v2_mvm
-- Generated on: 2026-06-20 07:36:11

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_ngo_v1`.`compliance` COMMENT 'Manages regulatory filing, statutory reporting, and organizational accountability obligations. Covers IRS 501(c)(3) filings, Charity Commission returns, IATI transparency reporting, CHS self-assessments, HAP accountability frameworks, Single Audit requirements for US federal awards, and organizational governance documentation.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` (
    `regulatory_filing_id` BIGINT COMMENT 'Unique identifier for the regulatory filing record. Primary key for the regulatory filing entity.',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Regulatory filings (government registration renewals, annual statutory reports) are submitted by a specific country office. Linking regulatory_filing to country_office enables office-level compliance ',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Each regulatory filing satisfies a specific compliance obligation from the master obligation catalog. One filing is for one obligation; one obligation generates many filings over time (recurring oblig',
    `acceptance_date` DATE COMMENT 'Date on which the regulatory authority formally accepted the filing as complete and compliant. Marks successful completion of the filing obligation.',
    `acknowledgment_date` DATE COMMENT 'Date on which the regulatory authority acknowledged receipt of the filing. Confirms that the submission was received and entered into the processing queue.',
    `amendment_flag` BOOLEAN COMMENT 'Indicates whether this filing is an amendment or correction of a previously submitted filing. True if this is an amended return, false if original filing.',
    `authorized_signatory_name` STRING COMMENT 'Full name of the individual authorized to sign and submit the regulatory filing on behalf of the organization. Typically an officer or director with legal authority.',
    `authorized_signatory_title` STRING COMMENT 'Official title or position of the authorized signatory. Examples include Executive Director, Board Chair, President, or Chief Executive Officer (CEO).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this regulatory filing record was first created in the system. Marks the beginning of the filing lifecycle for audit trail purposes.',
    `document_url` STRING COMMENT 'Web address or file path where the submitted filing document is stored for retrieval and audit purposes. May point to internal document management system or external regulatory portal.',
    `due_date` DATE COMMENT 'Statutory or regulatory deadline by which the filing must be submitted to avoid penalties or loss of status. Calculated based on fiscal year end and jurisdiction-specific rules.',
    `extended_due_date` DATE COMMENT 'New filing deadline after an approved extension. Replaces the original due date for compliance tracking purposes.',
    `extension_granted_flag` BOOLEAN COMMENT 'Indicates whether the requested filing deadline extension was granted by the regulatory authority. True if extension was approved, false if denied or not applicable.',
    `extension_requested_flag` BOOLEAN COMMENT 'Indicates whether an extension of the filing deadline was requested from the regulatory authority. True if extension was requested, false otherwise.',
    `filing_fee_amount` DECIMAL(18,2) COMMENT 'Monetary fee charged by the regulatory authority for processing the filing. Amount in the organizations functional currency.',
    `filing_fee_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the filing fee amount. Examples include USD, GBP, EUR.. Valid values are `^[A-Z]{3}$`',
    `filing_fee_payment_date` DATE COMMENT 'Date on which the filing fee was paid to the regulatory authority. Used to confirm payment and avoid processing delays.',
    `filing_notes` STRING COMMENT 'Free-text field for internal notes, comments, or special circumstances related to the filing. Used to document unusual situations, preparer communications, or follow-up actions required.',
    `filing_number` STRING COMMENT 'Externally-known unique identifier or confirmation number assigned by the regulatory authority or filing system upon submission. Examples include IRS e-file confirmation number, Charity Commission submission reference, or state registration number.',
    `filing_period_end_date` DATE COMMENT 'End date of the fiscal or reporting period covered by this regulatory filing. Defines the conclusion of the time span for which financial and operational data are reported.',
    `filing_period_start_date` DATE COMMENT 'Start date of the fiscal or reporting period covered by this regulatory filing. Defines the beginning of the time span for which financial and operational data are reported.',
    `filing_status` STRING COMMENT 'Current lifecycle status of the regulatory filing. Tracks progression from initial draft through submission, acknowledgment, and final acceptance or rejection by the regulatory authority. [ENUM-REF-CANDIDATE: draft|submitted|acknowledged|accepted|rejected|resubmitted|withdrawn|pending_review — 8 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this regulatory filing record was most recently updated. Tracks all changes throughout the filing lifecycle from draft to final acceptance.',
    `preparer_name` STRING COMMENT 'Full name of the individual or firm responsible for preparing the regulatory filing. May be internal staff or external consultant/accountant.',
    `preparer_organization` STRING COMMENT 'Name of the organization or firm employing the preparer, if applicable. Identifies external accounting firms, consultancies, or legal advisors engaged to prepare the filing.',
    `preparer_ptin` STRING COMMENT 'IRS-issued Preparer Tax Identification Number for the individual who prepared the filing. Required for paid tax return preparers in the United States.',
    `public_disclosure_flag` BOOLEAN COMMENT 'Indicates whether this filing is subject to public disclosure requirements. True for filings that must be made available for public inspection (e.g., IRS Form 990), false for confidential regulatory reports.',
    `rejection_date` DATE COMMENT 'Date on which the regulatory authority rejected the filing due to errors, omissions, or non-compliance. Triggers resubmission workflow.',
    `rejection_reason_code` STRING COMMENT 'Standardized code assigned by the regulatory authority indicating the specific reason for filing rejection. Used to identify and correct errors for resubmission. [ENUM-REF-CANDIDATE: IRS Reject Code 0001|0002|0003|0004|0005|0006|... — promote to reference product]. Reference code - denormalized from lookup/standard (natural key)',
    `rejection_reason_description` STRING COMMENT 'Detailed narrative explanation of why the filing was rejected by the regulatory authority. Provides context and guidance for corrective action.',
    `resubmission_count` STRING COMMENT 'Number of times this filing has been resubmitted after rejection. Tracks the iteration history for audit and quality improvement purposes.',
    `review_date` DATE COMMENT 'Date on which the internal review and approval of the filing was completed. Marks the point at which the filing was deemed ready for submission.',
    `reviewer_name` STRING COMMENT 'Full name of the individual responsible for reviewing and approving the regulatory filing before submission. Typically a senior finance officer, legal counsel, or executive director.',
    `reviewer_title` STRING COMMENT 'Job title or role of the individual who reviewed and approved the filing. Examples include Chief Financial Officer (CFO), Executive Director, or Board Treasurer.',
    `submission_channel` STRING COMMENT 'Method or channel through which the filing was submitted to the regulatory authority. Distinguishes between electronic filing systems, paper mail, online portals, and third-party filing services.. Valid values are `electronic|paper|online_portal|third_party_service|mail|in_person`',
    `submission_date` DATE COMMENT 'Actual date on which the filing was submitted to the regulatory authority. Used to determine timeliness and compliance with due date requirements.',
    `submission_timestamp` TIMESTAMP COMMENT 'Precise date and time when the filing was transmitted to the regulatory authority or filing portal. Provides audit trail for electronic submissions.',
    CONSTRAINT pk_regulatory_filing PRIMARY KEY(`regulatory_filing_id`)
) COMMENT 'Master record of all statutory and regulatory filings including full submission audit trail. Covers IRS Form 990, Charity Commission annual returns, state charitable solicitation registrations, and foreign agent registration filings. Tracks filing type, jurisdiction, due date, submission date, channel (electronic/paper/portal), confirmation number, status lifecycle (draft → submitted → acknowledged → accepted/rejected), preparer, reviewer, filing period, rejection reason codes, and resubmission history. Each submission attempt is recorded for complete audit trail. Source systems: eTools (assurance/audit tracking), SAP S/4HANA (VISION) (regulatory compliance), IATI Registry (publication tracking), eZHACT (HACT compliance). Deployed as Delta Lake tables in Databricks Unity Catalog with row-level security, column masking, and medallion architecture (bronze/silver/gold).';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`compliance`.`obligation` (
    `obligation_id` BIGINT COMMENT 'Primary key for obligation',
    `funding_source_id` BIGINT COMMENT 'Foreign key linking to grant.funding_source. Business justification: NGO compliance obligations are funder-specific (e.g., USAID mandates single audit, EU requires IATI). Linking obligation to funding_source enables compliance teams to pull all regulatory obligations b',
    `chs_self_assessment_required` BOOLEAN COMMENT 'Indicates whether this obligation requires a self-assessment against the Core Humanitarian Standard (CHS) commitments.',
    `obligation_code` STRING COMMENT 'Internal or external reference code for the obligation (e.g., IRS-990, CC-AR, IATI-PUB, CHS-SA).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this compliance obligation record was first created in the system.',
    `documentation_required` STRING COMMENT 'Description of the documents, reports, or evidence that must be prepared or submitted to fulfill this obligation (e.g., Audited financial statements, Program impact report, Beneficiary data summary, Board meeting minutes).',
    `effective_date` DATE COMMENT 'The date when this obligation first became applicable or enforceable for the organization.',
    `escalation_threshold_days` STRING COMMENT 'The number of days before the due date when an alert or escalation should be triggered to ensure timely completion.',
    `expiration_date` DATE COMMENT 'The date when this obligation ceases to be applicable or enforceable, if applicable. Null for ongoing obligations.',
    `fiscal_year_applicable` STRING COMMENT 'The fiscal year or reporting period to which this obligation applies (e.g., FY2024, 2024, Q1-2024).',
    `frequency` STRING COMMENT 'How often the obligation must be fulfilled: annual, quarterly, monthly, semi-annual, biennial, one-time (single occurrence), ad-hoc (irregular), event-driven (triggered by specific events). [ENUM-REF-CANDIDATE: annual|quarterly|monthly|semi-annual|biennial|one-time|ad-hoc|event-driven — 8 candidates stripped; promote to reference product]',
    `governing_body` STRING COMMENT 'The regulatory authority, oversight body, or standard-setting organization that mandates or oversees this obligation (e.g., Internal Revenue Service, Charity Commission, OCHA, CHS Alliance, USAID).',
    `iati_publication_required` BOOLEAN COMMENT 'Indicates whether this obligation requires publication of data to the IATI Registry for transparency and accountability.',
    `jurisdiction` STRING COMMENT 'The geographic or organizational scope where this obligation applies (e.g., United States, United Kingdom, European Union, Global, State of California, Country Office Kenya).',
    `last_completed_date` DATE COMMENT 'The date when this obligation was most recently fulfilled or submitted successfully.',
    `lead_time_days` STRING COMMENT 'The number of days in advance that preparation or submission must begin to meet the obligation deadline.',
    `legal_basis` STRING COMMENT 'The specific law, regulation, standard, or contractual clause that establishes this obligation (e.g., IRC Section 501(c)(3), 2 CFR 200.501, CHS Commitment 1, Grant Agreement Clause 12.3).',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this compliance obligation record was last updated or modified.',
    `obligation_name` STRING COMMENT 'The official name or title of the compliance obligation (e.g., IRS Form 990 Annual Return, Charity Commission Annual Return, IATI Publication).',
    `next_due_date` DATE COMMENT 'The next scheduled date by which this obligation must be fulfilled or submitted.',
    `notes` STRING COMMENT 'Additional notes, instructions, or context related to this obligation, including special handling requirements or historical context.',
    `obligation_status` STRING COMMENT 'Current lifecycle status of the obligation: active (in force and must be fulfilled), pending (upcoming or not yet effective), completed (fulfilled for current period), overdue (past due date and not fulfilled), waived (exempted or not applicable), suspended (temporarily not enforced).. Valid values are `active|pending|completed|overdue|waived|suspended`',
    `obligation_type` STRING COMMENT 'Classification of the obligation by its source or nature: regulatory (government-mandated), donor (funder-specific requirement), voluntary (self-imposed accountability framework), contractual (grant or partnership agreement condition), statutory (legal requirement).. Valid values are `regulatory|donor|voluntary|contractual|statutory`',
    `penalty_description` STRING COMMENT 'Description of the consequences, penalties, or sanctions that may result from non-compliance (e.g., Loss of tax-exempt status, Fines up to $50,000, Grant suspension, Reputational damage).',
    `responsible_person` STRING COMMENT 'The name or identifier of the individual accountable for ensuring this obligation is fulfilled (e.g., Chief Financial Officer, Compliance Manager, MEL Director).',
    `responsible_unit` STRING COMMENT 'The department, team, or organizational unit responsible for fulfilling this obligation (e.g., Finance Department, Compliance Office, MEL Team, Legal Affairs, Country Office).',
    `risk_rating` STRING COMMENT 'The severity of risk to the organization if this obligation is not fulfilled: critical (severe legal or reputational consequences), high (significant impact), medium (moderate impact), low (minimal impact).. Valid values are `critical|high|medium|low`',
    `single_audit_required` BOOLEAN COMMENT 'Indicates whether this obligation requires a Single Audit under 2 CFR 200 Subpart F for US federal awards exceeding the threshold.',
    `submission_method` STRING COMMENT 'The channel or mechanism through which the obligation must be fulfilled or submitted (e.g., online portal, email, postal mail, in-person delivery, API, FTP).. Valid values are `online_portal|email|postal_mail|in_person|api|ftp`',
    `submission_url` STRING COMMENT 'The web address or portal URL where the obligation must be submitted, if applicable.',
    CONSTRAINT pk_obligation PRIMARY KEY(`obligation_id`)
) COMMENT 'Master catalog of all recurring and one-time compliance obligations the organization must fulfill across regulatory, donor, and voluntary accountability frameworks. Includes IRS 990 filings, Charity Commission returns, IATI publications, CHS self-assessments, Single Audit requirements (2 CFR 200), state registrations, OCHA reporting, and donor-specific conditions. Captures obligation name, governing body, legal basis, frequency, jurisdiction, responsible unit, lead time, and risk rating. Overdue obligations escalate to incident records via obligation_schedule monitoring. Source systems: eTools (assurance/audit tracking), SAP S/4HANA (VISION) (regulatory compliance), IATI Registry (publication tracking), eZHACT (HACT compliance). Deployed as Delta Lake tables in Databricks Unity Catalog with row-level security, column masking, and medallion architecture (bronze/silver/gold).';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` (
    `obligation_schedule_id` BIGINT COMMENT 'Unique identifier for the compliance obligation schedule entry. Primary key for the obligation schedule product.',
    `obligation_id` BIGINT COMMENT 'Reference to the parent compliance obligation that this schedule entry is tracking. Links to the master obligation registry.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Obligation schedules track when compliance filings are due. When the obligation is completed, the schedule should reference the actual regulatory filing that satisfied it. One schedule entry results i',
    `actual_effort_hours` DECIMAL(18,2) COMMENT 'Actual number of staff hours spent completing this obligation. Used for capacity planning and process improvement. Null if not yet completed.',
    `completion_status` STRING COMMENT 'Overall completion status of the scheduled obligation. Indicates whether the obligation is pending, actively being worked, completed on time, overdue, waived by authority, or deferred to a future period.. Valid values are `pending|in_progress|completed|overdue|waived|deferred`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this obligation schedule entry was first created in the system. Supports audit trail and compliance history tracking.',
    `effective_due_date` DATE COMMENT 'The actual due date in effect for this obligation, taking into account any approved extensions. Equals extended_due_date if extension granted, otherwise equals planned_due_date.',
    `escalation_date` DATE COMMENT 'Date when the obligation was escalated to senior management or executive leadership due to risk of non-compliance. Null if no escalation has occurred.',
    `escalation_threshold_days` STRING COMMENT 'Number of days before the effective due date when the obligation should be escalated to senior management if not yet completed. Enables proactive deadline monitoring.',
    `escalation_triggered_flag` BOOLEAN COMMENT 'Boolean indicator of whether this obligation has triggered an escalation alert due to approaching deadline or overdue status. True if escalation has been triggered, False otherwise.',
    `estimated_effort_hours` DECIMAL(18,2) COMMENT 'Estimated number of staff hours required to complete this obligation, including data collection, preparation, review, and submission activities.',
    `extended_due_date` DATE COMMENT 'Revised due date if an extension has been granted by the regulatory authority or approved internally. Null if no extension applies.',
    `extension_granted_flag` BOOLEAN COMMENT 'Boolean indicator of whether the requested extension was approved by the regulatory authority. True if extension granted, False if denied or not applicable.',
    `extension_reason` STRING COMMENT 'Business justification or reason provided when requesting an extension (e.g., Awaiting final audit report, Staff transition, System migration delay).',
    `extension_requested_flag` BOOLEAN COMMENT 'Boolean indicator of whether an extension has been formally requested from the regulatory authority. True if extension requested, False otherwise.',
    `jurisdiction` STRING COMMENT 'Legal jurisdiction or regulatory authority under which this obligation falls (e.g., United States - IRS, United Kingdom - Charity Commission, International - IATI).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this obligation schedule entry was last updated. Tracks changes to due dates, assignments, status, or other schedule attributes.',
    `non_compliance_risk` STRING COMMENT 'Assessment of the organizational risk if this obligation is not met on time. Severe risk includes loss of tax-exempt status, funding restrictions, or legal penalties.. Valid values are `severe|high|moderate|low|minimal`',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty or fine amount assessed for late or non-compliant submission. Null if no penalty applies or obligation completed on time.',
    `penalty_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the penalty amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `planned_due_date` DATE COMMENT 'Original scheduled due date for the compliance obligation as defined by the regulatory authority or internal policy.',
    `priority_level` STRING COMMENT 'Business priority assigned to this obligation based on regulatory impact, financial risk, and organizational importance. Critical obligations have severe non-compliance penalties.. Valid values are `critical|high|medium|low`',
    `recurrence_pattern` STRING COMMENT 'Frequency pattern for this obligation. Indicates whether it is a one-time requirement, recurring annually, quarterly, monthly, biennially, or triggered by specific events.. Valid values are `one_time|annual|quarterly|monthly|biennial|event_driven`',
    `regulatory_framework` STRING COMMENT 'Specific regulatory framework or standard governing this obligation (e.g., IRS 501(c)(3), OMB Uniform Guidance 2 CFR 200, IATI Standard, CHS, Sphere Standards).',
    `reviewer_notes` STRING COMMENT 'Internal notes and comments from compliance reviewers, auditors, or executive leadership regarding this obligation schedule entry. Used for quality assurance and process improvement.',
    `supporting_document_count` STRING COMMENT 'Number of supporting documents, attachments, or exhibits required or submitted with this obligation (e.g., financial statements, audit reports, program narratives).',
    `waiver_reason` STRING COMMENT 'Explanation for why this obligation was waived or exempted by the regulatory authority or internal policy (e.g., Below revenue threshold, Disaster relief exemption).',
    `workflow_stage` STRING COMMENT 'Current stage in the compliance workflow process. Tracks progression from initial data collection through final submission and acknowledgment. [ENUM-REF-CANDIDATE: not_started|data_collection|draft_preparation|internal_review|executive_review|final_approval|submission_ready|submitted|acknowledged — 9 candidates stripped; promote to reference product]',
    CONSTRAINT pk_obligation_schedule PRIMARY KEY(`obligation_schedule_id`)
) COMMENT 'Operational schedule linking compliance obligations to specific fiscal periods, deadlines, and responsible staff. Tracks planned due date, extended due date (if extension granted), assigned compliance officer, review workflow stage, escalation thresholds, and completion status. Enables proactive compliance calendar management and deadline monitoring across all jurisdictions and reporting frameworks. Source systems: eTools (assurance/audit tracking), SAP S/4HANA (VISION) (regulatory compliance), IATI Registry (publication tracking), eZHACT (HACT compliance). Deployed as Delta Lake tables in Databricks Unity Catalog with row-level security, column masking, and medallion architecture (bronze/silver/gold).';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`compliance`.`single_audit` (
    `single_audit_id` BIGINT COMMENT 'Unique identifier for the Single Audit engagement record. Primary key for this entity.',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Single audits (US federal OMB Uniform Guidance) are conducted at the entity/country office level covering federal expenditures in that offices portfolio. Linking single_audit to country_office enable',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Single Audits (OMB Uniform Guidance 2 CFR 200) satisfy federal audit obligations for organizations expending $750K+ in federal awards. The obligation table tracks single_audit_required flag. One audit',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Single Audit results must be filed with the Federal Audit Clearinghouse (FAC) as a regulatory filing. One Single Audit generates one regulatory filing submission. The filing details (submission date, ',
    `audit_cost_amount` DECIMAL(18,2) COMMENT 'Total cost paid or payable to the auditor firm for conducting the Single Audit engagement.',
    `audit_finding_count` STRING COMMENT 'Total number of audit findings reported in the Schedule of Findings and Questioned Costs.',
    `audit_period_end` STRING COMMENT 'End date of the audit period. Per 2 CFR 200.501 Single Audit requirements for entities expending >= $750,000 in Federal awards. Aligns with fiscal year end.',
    `audit_period_end_date` DATE COMMENT 'The ending date of the fiscal year or audit period covered by this Single Audit engagement.',
    `audit_period_start_date` DATE COMMENT 'The beginning date of the fiscal year or audit period covered by this Single Audit engagement.',
    `audit_report_date` DATE COMMENT 'Date when the auditor issued the final Single Audit report package.',
    `audit_status` STRING COMMENT 'Current lifecycle status of the Single Audit engagement: planned, in_progress, fieldwork_complete, report_draft, report_final, submitted_to_fac, or closed. [ENUM-REF-CANDIDATE: planned|in_progress|fieldwork_complete|report_draft|report_final|submitted_to_fac|closed — 7 candidates stripped; promote to reference product]',
    `audit_year` STRING COMMENT 'The fiscal year for which the Single Audit is being conducted, typically a four-digit year (e.g., 2023).',
    `auditor_contact_email` STRING COMMENT 'Email address of the primary auditor contact for this Single Audit engagement.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `auditor_contact_name` STRING COMMENT 'Name of the primary contact person at the auditor firm responsible for this engagement.',
    `auditor_contact_phone` STRING COMMENT 'Phone number of the primary auditor contact for this Single Audit engagement.',
    `auditor_ein` STRING COMMENT 'Federal Employer Identification Number of the auditor firm conducting the Single Audit.. Valid values are `^d{2}-d{7}$`',
    `auditor_firm_name` STRING COMMENT 'Name of the independent certified public accounting firm or auditor conducting the Single Audit.',
    `compliance_opinion_type` STRING COMMENT 'Type of audit opinion issued on compliance with federal award requirements: unmodified (clean), qualified, adverse, or disclaimer of opinion.. Valid values are `unmodified|qualified|adverse|disclaimer`',
    `corrective_action_plan_date` DATE COMMENT 'Date when the organization submitted its corrective action plan to address audit findings.',
    `corrective_action_plan_submitted_flag` BOOLEAN COMMENT 'Indicates whether the organization submitted a corrective action plan addressing audit findings as required.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this Single Audit record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the federal expenditure amount (typically USD for US federal awards).. Valid values are `^[A-Z]{3}$`',
    `engagement_letter_date` DATE COMMENT 'Date when the audit engagement letter was signed between the organization and the auditor firm.',
    `federal_expenditure_amount` DECIMAL(18,2) COMMENT 'Total amount of federal awards expended by the organization during the audit period, triggering Single Audit requirement if $750,000 or more.',
    `fieldwork_end_date` DATE COMMENT 'Date when the auditor completed fieldwork for the Single Audit.',
    `fieldwork_start_date` DATE COMMENT 'Date when the auditor began on-site or remote fieldwork for the Single Audit.',
    `financial_statement_opinion_type` STRING COMMENT 'Type of audit opinion issued on the organizations financial statements: unmodified (clean), qualified, adverse, or disclaimer of opinion.. Valid values are `unmodified|qualified|adverse|disclaimer`',
    `going_concern_issue_flag` BOOLEAN COMMENT 'Indicates whether the auditor raised substantial doubt about the organizations ability to continue as a going concern.',
    `internal_control_opinion_type` STRING COMMENT 'Type of audit opinion issued on internal control over financial reporting and compliance: unmodified, qualified, adverse, or disclaimer.. Valid values are `unmodified|qualified|adverse|disclaimer`',
    `low_risk_auditee_flag` BOOLEAN COMMENT 'Indicates whether the organization qualifies as a low-risk auditee under OMB Uniform Guidance criteria, which may reduce the number of major programs tested.',
    `major_program_count` STRING COMMENT 'Number of federal programs identified as major programs requiring detailed compliance testing under the risk-based approach.',
    `material_weakness_identified_flag` BOOLEAN COMMENT 'Indicates whether the auditor identified any material weaknesses in internal control over financial reporting or compliance.',
    `notes` STRING COMMENT 'Free-text notes or comments related to the Single Audit engagement, including special circumstances, follow-up actions, or internal observations.',
    `questioned_cost_amount` DECIMAL(18,2) COMMENT 'Total dollar amount of questioned costs identified by the auditor across all federal programs.',
    `sefa_reference_number` STRING COMMENT 'Reference number or identifier for the Schedule of Expenditures of Federal Awards (SEFA) prepared as part of the Single Audit package.',
    `significant_deficiency_identified_flag` BOOLEAN COMMENT 'Indicates whether the auditor identified any significant deficiencies in internal control over financial reporting or compliance.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this Single Audit record was last updated in the system.',
    CONSTRAINT pk_single_audit PRIMARY KEY(`single_audit_id`)
) COMMENT 'Master record for Single Audit engagements required under OMB Uniform Guidance 2 CFR 200 for organizations expending $750,000 or more in US federal awards in a fiscal year. Captures audit period, auditor firm, engagement type (financial statement audit, compliance audit), federal expenditure threshold, Schedule of Expenditures of Federal Awards (SEFA) reference, audit opinion type, and submission to the Federal Audit Clearinghouse (FAC). Source systems: eTools (assurance/audit tracking), SAP S/4HANA (VISION) (regulatory compliance), IATI Registry (publication tracking), eZHACT (HACT compliance). Deployed as Delta Lake tables in Databricks Unity Catalog with row-level security, column masking, and medallion architecture (bronze/silver/gold).';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` (
    `audit_finding_id` BIGINT COMMENT 'Primary key for audit_finding',
    `single_audit_id` BIGINT COMMENT 'Foreign key linking to compliance.single_audit. Business justification: Audit findings discovered during Single Audit engagements (OMB Uniform Guidance 2 CFR 200) should reference the specific Single Audit. The existing audit_id points to compliance.audit (cross-domain)',
    `subaward_id` BIGINT COMMENT 'Foreign key linking to grant.subaward. Business justification: Single audit findings are frequently attributed to specific subawards (questioned costs, internal control weaknesses at subgrantee level). This FK enables subaward-level finding tracking required for ',
    `actual_resolution_date` DATE COMMENT 'The actual date on which the finding was fully resolved and remediated, as verified by management or subsequent audit. Null if the finding is still open or in remediation.',
    `audit_period_end_date` DATE COMMENT 'The end date of the audit period during which this finding was identified. Typically the end of the organizations fiscal year under audit.',
    `audit_period_start_date` DATE COMMENT 'The start date of the audit period during which this finding was identified. Typically the beginning of the organizations fiscal year under audit.',
    `auditor_name` STRING COMMENT 'Name of the external audit firm or auditor who identified this finding during the audit engagement.',
    `cause_description` STRING COMMENT 'Explanation of the underlying reason or root cause that led to the condition. This identifies why the deficiency occurred (e.g., lack of training, inadequate controls, resource constraints).',
    `cfda_number` STRING COMMENT 'The five-digit CFDA number (now known as Assistance Listings number) identifying the federal program under which the finding was identified. Format is XX.XXX where the first two digits represent the federal agency and the last three represent the specific program.. Business document/reference number (natural key). Valid values are `^[0-9]{2}.[0-9]{3}$`',
    `compliance_requirement_type` STRING COMMENT 'The specific type of compliance requirement that was violated or not met, as defined in the OMB Compliance Supplement (e.g., Activities Allowed or Unallowed, Allowable Costs/Cost Principles, Cash Management, Eligibility, Equipment and Real Property Management, Matching, Period of Performance, Procurement, Program Income, Reporting, Subrecipient Monitoring, Special Tests and Provisions).',
    `condition_description` STRING COMMENT 'Detailed description of the actual condition or deficiency found during the audit. This describes what the auditor observed or identified as problematic.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this audit finding record was first created in the system.',
    `criteria_description` STRING COMMENT 'Description of the required standard, regulation, policy, or grant provision that was not met. This establishes the benchmark against which the condition is measured.',
    `effect_description` STRING COMMENT 'Description of the actual or potential impact or consequence of the finding. This explains what harm or risk resulted from the condition (e.g., misstated financial statements, unallowable costs charged to grant, noncompliance with donor restrictions).',
    `expected_resolution_date` DATE COMMENT 'The target date by which the organization expects to fully resolve and remediate this finding based on the corrective action plan.',
    `fac_submission_date` DATE COMMENT 'The date on which the audit report containing this finding was submitted to the Federal Audit Clearinghouse. Null if not yet submitted.',
    `federal_agency_name` STRING COMMENT 'Name of the federal agency that provided the funding for the program under which this finding was identified (e.g., USAID, BHA, Department of State, HHS).',
    `federal_award_identification_number` STRING COMMENT 'The unique Federal Award Identification Number assigned by the federal agency to the specific award under which this finding was identified.. Identity document number (PII - natural identifier)',
    `finding_identified_date` DATE COMMENT 'The date on which the auditor formally identified and documented this finding during the audit fieldwork or reporting process.',
    `finding_reference_number` STRING COMMENT 'The externally-known unique reference number assigned to this audit finding by the auditor, typically following the format YYYY-NNN or similar audit-specific numbering convention.. Reference number to source document (natural key)',
    `finding_status` STRING COMMENT 'Current lifecycle status of the audit finding. Open indicates newly identified and not yet addressed. In remediation indicates corrective action plan is being implemented. Resolved indicates corrective actions completed and pending verification. Closed indicates finding fully remediated and verified. Repeat finding indicates this issue was identified in a prior audit period.. Valid values are `open|in_remediation|resolved|closed|repeat_finding`',
    `finding_title` STRING COMMENT 'Brief descriptive title or summary of the audit finding, providing a high-level overview of the issue identified.',
    `finding_type` STRING COMMENT 'Classification of the audit finding based on severity and nature. Material weakness indicates a deficiency or combination of deficiencies in internal control such that there is a reasonable possibility that a material misstatement will not be prevented or detected. Significant deficiency is less severe than a material weakness but important enough to merit attention. Questioned cost represents costs that do not comply with grant terms. Noncompliance indicates violation of laws, regulations, or grant provisions.. Valid values are `material_weakness|significant_deficiency|questioned_cost|noncompliance|other_matter`',
    `is_fraud_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this finding includes indicators of potential fraud, waste, or abuse. True if fraud indicators are present and require further investigation.',
    `is_material_weakness` BOOLEAN COMMENT 'Boolean flag indicating whether this finding represents a material weakness in internal control over financial reporting or compliance. True if the finding is classified as a material weakness.',
    `is_repeat_finding` BOOLEAN COMMENT 'Boolean flag indicating whether this finding was previously identified in a prior audit period and has not been fully resolved. True if this is a repeat finding.',
    `is_significant_deficiency` BOOLEAN COMMENT 'Boolean flag indicating whether this finding represents a significant deficiency in internal control. True if the finding is classified as a significant deficiency.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this audit finding record was last updated or modified in the system.',
    `management_response` STRING COMMENT 'The organizations management response to the audit finding, including agreement or disagreement with the finding and planned corrective actions.',
    `notes` STRING COMMENT 'Additional notes, comments, or context related to this audit finding, including follow-up actions, communications with auditors, or internal discussions.',
    `prior_finding_reference_number` STRING COMMENT 'Reference number of the prior audit finding if this is a repeat finding. Links to the original finding from a previous audit period.. Reference number to source document (natural key)',
    `questioned_cost_amount` DECIMAL(18,2) COMMENT 'The monetary amount of costs questioned by the auditor due to noncompliance with grant terms, unallowable costs, or lack of supporting documentation. Null if the finding does not involve questioned costs.',
    `questioned_cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the questioned cost amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `recommendation_description` STRING COMMENT 'Auditors recommendation for corrective action to address the finding. This provides guidance on steps the organization should take to remediate the deficiency.',
    `reported_to_federal_audit_clearinghouse` BOOLEAN COMMENT 'Boolean flag indicating whether this finding has been reported to the Federal Audit Clearinghouse as part of the Single Audit submission. True if reported to FAC.',
    `responsible_department` STRING COMMENT 'The internal department or functional area responsible for addressing and remediating this finding (e.g., Finance, Program Operations, Grants Management, Human Resources).',
    `responsible_person_name` STRING COMMENT 'Name of the individual assigned primary responsibility for implementing the corrective action plan and resolving this finding.',
    `risk_category` STRING COMMENT 'Classification of the type of risk this finding represents (e.g., Financial Risk, Compliance Risk, Operational Risk, Reputational Risk, Fraud Risk).',
    `severity_level` STRING COMMENT 'Internal classification of the findings severity based on organizational risk assessment. Critical findings pose immediate risk to funding or compliance. High findings require urgent attention. Medium findings should be addressed in the normal course. Low findings are minor issues.. Valid values are `critical|high|medium|low`',
    CONSTRAINT pk_audit_finding PRIMARY KEY(`audit_finding_id`)
) COMMENT 'Transactional record of each finding, material weakness, significant deficiency, or questioned cost identified during a Single Audit or internal compliance audit. Captures finding reference number, finding type (material weakness, significant deficiency, questioned cost, noncompliance), federal program CFDA number, finding description, condition, criteria, cause, effect, and recommendation. Links to corrective action plans. Source systems: eTools (assurance/audit tracking), SAP S/4HANA (VISION) (regulatory compliance), IATI Registry (publication tracking), eZHACT (HACT compliance). Deployed as Delta Lake tables in Databricks Unity Catalog with row-level security, column masking, and medallion architecture (bronze/silver/gold).';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` (
    `corrective_action_plan_id` BIGINT COMMENT 'Unique identifier for the corrective action plan record.',
    `audit_finding_id` BIGINT COMMENT 'Reference to the audit finding, CHS non-conformity, or compliance issue that triggered this corrective action plan.',
    `subaward_id` BIGINT COMMENT 'Foreign key linking to grant.subaward. Business justification: Corrective action plans are issued to subgrantees following audit findings or monitoring visits. This FK links CAPs to the specific subaward, enabling subgrantee performance management, flow-down comp',
    `actual_completion_date` DATE COMMENT 'Actual date when the corrective action plan was fully implemented and verified as complete. Null if still in progress.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual financial cost incurred to implement the corrective action plan. Null if not yet completed or cost not tracked.',
    `audit_report_reference` STRING COMMENT 'Reference to the audit report document that contains the original finding, including report number and page reference.',
    `cap_number` STRING COMMENT 'Business identifier for the corrective action plan, typically formatted as CAP-YYYY-NNN or similar organizational convention.',
    `cap_status` STRING COMMENT 'Current lifecycle status of the corrective action plan, tracking progress from initiation through closure. [ENUM-REF-CANDIDATE: draft|open|in_progress|pending_verification|closed|overdue|cancelled — 7 candidates stripped; promote to reference product]',
    `corrective_action_description` STRING COMMENT 'Detailed narrative describing the specific corrective actions to be taken to address the finding, including process changes, policy updates, training, or system enhancements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the corrective action plan record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for estimated and actual costs.. Valid values are `^[A-Z]{3}$`',
    `donor_notification_date` DATE COMMENT 'Date when the donor or funding agency was notified of the finding and corrective action plan. Null if notification not required or not yet sent.',
    `donor_notification_required` BOOLEAN COMMENT 'Indicates whether the donor or funding agency must be notified of the finding and corrective action plan per grant agreement terms.',
    `escalation_date` DATE COMMENT 'Date when the corrective action plan was escalated to higher authority. Null if no escalation occurred.',
    `escalation_required` BOOLEAN COMMENT 'Indicates whether the corrective action plan requires escalation to senior management, board of directors, or external parties due to severity or complexity.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Estimated financial cost to implement the corrective action plan, including staff time, system changes, training, and other resources.',
    `finding_reference_number` STRING COMMENT 'External reference number from the audit report, CHS verification report, or donor compliance review that documented the original finding.. Reference number to source document (natural key)',
    `finding_severity` STRING COMMENT 'Severity level of the finding as assessed by auditors or compliance reviewers, indicating urgency and risk exposure.. Valid values are `critical|high|medium|low`',
    `finding_type` STRING COMMENT 'Classification of the underlying issue that necessitated the corrective action plan.. Valid values are `audit_finding|chs_non_conformity|donor_compliance_issue|internal_control_deficiency|regulatory_violation|fraud_allegation`',
    `management_response` STRING COMMENT 'Official management response to the finding, documenting agreement or disagreement with the finding and planned corrective actions.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the corrective action plan record was last modified.',
    `notes` STRING COMMENT 'Additional notes, comments, or context related to the corrective action plan, including progress updates, challenges encountered, or lessons learned.',
    `preventive_measures` STRING COMMENT 'Description of preventive measures implemented to reduce the risk of recurrence, such as policy changes, training programs, or system controls.',
    `recurrence_risk` STRING COMMENT 'Assessment of the risk that the finding could recur if corrective actions are not sustained or are inadequately implemented.. Valid values are `high|medium|low`',
    `regulatory_reporting_date` DATE COMMENT 'Date when the finding and corrective action plan were reported to regulatory authorities. Null if reporting not required or not yet submitted.',
    `regulatory_reporting_required` BOOLEAN COMMENT 'Indicates whether the finding and corrective action plan must be reported to regulatory authorities such as IRS, Charity Commission, or OCHA.',
    `responsible_department` STRING COMMENT 'Department or organizational unit responsible for executing the corrective action plan.',
    `root_cause_analysis` STRING COMMENT 'Analysis of the underlying root cause(s) that led to the finding, supporting effective remediation and prevention of recurrence.',
    `sphere_standard_reference` STRING COMMENT 'Reference to the specific Sphere Humanitarian Charter or Minimum Standard that was not met, if the finding relates to humanitarian quality standards.',
    `target_completion_date` DATE COMMENT 'Planned date by which the corrective action plan is expected to be fully implemented and closed.',
    `verification_date` DATE COMMENT 'Date when the corrective action was verified as complete and effective by auditors, compliance officers, or management.',
    `verification_method` STRING COMMENT 'Method used to verify that the corrective action has been effectively implemented and the finding has been remediated. [ENUM-REF-CANDIDATE: document_review|site_visit|testing|management_attestation|external_audit|internal_audit|chs_verification — 7 candidates stripped; promote to reference product]',
    `verification_notes` STRING COMMENT 'Detailed notes from the verification process, documenting evidence reviewed and conclusions reached regarding corrective action effectiveness.',
    CONSTRAINT pk_corrective_action_plan PRIMARY KEY(`corrective_action_plan_id`)
) COMMENT 'Master record of corrective action plans (CAPs) developed in response to audit findings, CHS non-conformities, donor compliance issues, or internal control deficiencies. Captures finding reference, corrective action description, responsible manager, target completion date, actual completion date, verification method, and status (open, in progress, closed, overdue). Supports management response documentation required by 2 CFR 200 and CHS Alliance. Source systems: eTools (assurance/audit tracking), SAP S/4HANA (VISION) (regulatory compliance), IATI Registry (publication tracking), eZHACT (HACT compliance). Deployed as Delta Lake tables in Databricks Unity Catalog with row-level security, column masking, and medallion architecture (bronze/silver/gold).';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` (
    `donor_requirement_id` BIGINT COMMENT 'Primary key for donor_requirement',
    `subaward_id` BIGINT COMMENT 'Foreign key linking to grant.subaward. Business justification: Flow-down compliance requirements apply to specific subawards (e.g., FFATA reporting, procurement standards). This FK links donor requirements to the subaward they govern, enabling subaward compliance',
    `actual_effort_hours` DECIMAL(18,2) COMMENT 'The actual number of staff hours expended in fulfilling this compliance requirement, used for future planning and cost analysis.',
    `approval_date` DATE COMMENT 'The date on which the donor formally approved or accepted the compliance submission.',
    `compliance_status` STRING COMMENT 'Current status of the organizations compliance with this requirement, tracking progress from initiation through approval or waiver. [ENUM-REF-CANDIDATE: not_started|in_progress|submitted|under_review|approved|overdue|waived — 7 candidates stripped; promote to reference product]',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the associated cost amount.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this compliance requirement record was first created in the system.',
    `deliverable_format` STRING COMMENT 'The required format or medium for the compliance deliverable, such as PDF report, online portal submission, or physical document.',
    `donor_contact_email` STRING COMMENT 'The email address of the donor representative responsible for receiving and reviewing compliance submissions.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `donor_contact_name` STRING COMMENT 'The name of the donor representative or point of contact for questions and submissions related to this compliance requirement.',
    `due_date` DATE COMMENT 'The date by which the compliance requirement must be fulfilled and submitted to the donor.',
    `effective_end_date` DATE COMMENT 'The date on which this compliance requirement expires or is no longer applicable, typically aligned with grant closure.',
    `effective_start_date` DATE COMMENT 'The date from which this compliance requirement becomes active and applicable to the grant.',
    `estimated_effort_hours` DECIMAL(18,2) COMMENT 'The estimated number of staff hours required to complete and submit this compliance requirement.',
    `internal_policy_reference` STRING COMMENT 'Reference to the organizations internal policy or procedure document that governs how this compliance requirement is fulfilled.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this compliance requirement record was last updated or modified.',
    `non_compliance_consequence` STRING COMMENT 'Description of the potential consequences or penalties for failing to meet this compliance requirement, such as grant suspension, fund recovery, or donor relationship damage.',
    `non_compliance_risk_level` STRING COMMENT 'The assessed risk level to the organization if this compliance requirement is not met, considering financial, reputational, and operational impacts.. Valid values are `low|medium|high|critical`',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or context related to this compliance requirement, used for internal coordination and knowledge sharing.',
    `priority_level` STRING COMMENT 'The urgency and importance level assigned to this compliance requirement, used for resource allocation and risk management.. Valid values are `critical|high|medium|low`',
    `requirement_description` STRING COMMENT 'Detailed narrative description of the compliance requirement, including specific obligations, deliverables, and conditions imposed by the donor.',
    `requirement_reference_number` STRING COMMENT 'External reference number or code assigned by the donor to this compliance requirement, used for tracking and correspondence.. Reference number to source document (natural key)',
    `requirement_title` STRING COMMENT 'Short descriptive title of the compliance requirement for quick identification and reporting.',
    `responsible_department` STRING COMMENT 'The organizational department or unit responsible for managing and fulfilling this compliance requirement.',
    `submission_date` DATE COMMENT 'The actual date on which the compliance deliverable was submitted to the donor.',
    `submission_method` STRING COMMENT 'The channel or mechanism through which the compliance deliverable must be submitted to the donor.. Valid values are `email|online_portal|postal_mail|in_person|ftp`',
    `supporting_document_url` STRING COMMENT 'URL or file path to supporting documentation, templates, or guidance materials related to this compliance requirement.',
    `waiver_granted_flag` BOOLEAN COMMENT 'Indicates whether the donor has approved a waiver or exemption for this compliance requirement.',
    `waiver_justification` STRING COMMENT 'The rationale or explanation provided for requesting a waiver from this compliance requirement.',
    `waiver_requested_flag` BOOLEAN COMMENT 'Indicates whether the organization has formally requested a waiver or exemption from this compliance requirement.',
    CONSTRAINT pk_donor_requirement PRIMARY KEY(`donor_requirement_id`)
) COMMENT 'Master record of specific compliance requirements imposed by individual institutional donors (USAID, DFID, EU, UN agencies) on grants awarded to the organization. Captures donor name, grant reference, requirement type (financial reporting, programmatic reporting, audit, visibility, procurement rules, anti-terrorism certification, NICRA application), requirement description, due date, and compliance status. Distinct from general regulatory obligations — these are donor-specific contractual compliance conditions. Source systems: eTools (assurance/audit tracking), SAP S/4HANA (VISION) (regulatory compliance), IATI Registry (publication tracking), eZHACT (HACT compliance). Deployed as Delta Lake tables in Databricks Unity Catalog with row-level security, column masking, and medallion architecture (bronze/silver/gold).';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`compliance`.`incident` (
    `incident_id` BIGINT COMMENT 'Unique identifier for the compliance incident record. Primary key.',
    `country_office_id` BIGINT COMMENT 'Identifier of the country office or field location where the incident occurred.',
    `subaward_id` BIGINT COMMENT 'Foreign key linking to grant.subaward. Business justification: Compliance incidents frequently occur at the subgrantee level (fund misuse, procurement violations). This FK enables subaward-level incident tracking, supports FFATA/FSRS reporting requirements, and a',
    `allegation_category` STRING COMMENT 'Specific category of the allegation within the broader incident type. Supports detailed classification for MEL and donor reporting. [ENUM-REF-CANDIDATE: corruption|theft|misappropriation|conflict_of_interest|harassment|discrimination|safeguarding_violation|data_breach|regulatory_noncompliance — 9 candidates stripped; promote to reference product]',
    `corrective_action_taken` STRING COMMENT 'Summary of corrective actions, disciplinary measures, or process improvements implemented in response to the incident.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this incident record was first created in the system.',
    `incident_description` STRING COMMENT 'Detailed narrative description of the incident, allegations, and circumstances. Confidential to protect investigation and individuals.',
    `donor_notification_date` DATE COMMENT 'Date when the donor was formally notified of the incident per contractual obligations.',
    `donor_notification_required_flag` BOOLEAN COMMENT 'Indicates whether the incident meets donor notification thresholds per grant agreements. True if notification is required.',
    `estimated_financial_impact_usd` DECIMAL(18,2) COMMENT 'Estimated financial loss or exposure in US Dollars resulting from the incident. Used for materiality assessment and donor reporting thresholds.',
    `incident_date` DATE COMMENT 'Date when the alleged incident or violation occurred. May be approximate if exact date is unknown.',
    `incident_number` STRING COMMENT 'Externally-visible unique incident reference number used for tracking and donor reporting. Format: INC-YYYYMMDD.. Incident report number (natural key). Valid values are `^INC-[0-9]{8}$`',
    `incident_status` STRING COMMENT 'Current lifecycle status of the incident in the investigation and resolution workflow.. Valid values are `reported|under_review|investigation_open|investigation_closed|resolved|dismissed`',
    `incident_type` STRING COMMENT 'Primary classification of the compliance incident. Determines investigation protocol and reporting obligations.. Valid values are `fraud|financial_mismanagement|procurement_irregularity|data_protection_violation|ethical_breach|safeguarding`',
    `investigation_assigned_to` STRING COMMENT 'Name or identifier of the investigator or investigation team assigned to the case. Confidential to protect investigation integrity.',
    `investigation_completion_date` DATE COMMENT 'Date when the investigation was formally closed and findings documented.',
    `investigation_finding` STRING COMMENT 'Final determination of the investigation regarding the validity of the allegation. Confidential until disclosure obligations are met.. Valid values are `substantiated|partially_substantiated|unsubstantiated|inconclusive`',
    `investigation_notes` STRING COMMENT 'Internal notes and observations from the investigation process. Confidential working document.',
    `investigation_start_date` DATE COMMENT 'Date when formal investigation was initiated following triage and preliminary assessment.',
    `last_modified_by` STRING COMMENT 'User or system identifier of the person who last modified this incident record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this incident record was last updated.',
    `lessons_learned` STRING COMMENT 'Key lessons and insights captured from the incident for organizational learning and process improvement per MEL framework.',
    `public_disclosure_flag` BOOLEAN COMMENT 'Indicates whether the incident and its resolution have been publicly disclosed per transparency commitments. True if disclosed.',
    `regulatory_report_date` DATE COMMENT 'Date when the incident was reported to the relevant regulatory authority.',
    `regulatory_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether the incident must be reported to regulatory authorities (Charity Commission, IRS, OCHA). True if reporting is required.',
    `reported_date` DATE COMMENT 'Date when the incident was first reported to the organization through any channel.',
    `reporter_anonymity_flag` BOOLEAN COMMENT 'Indicates whether the reporter requested anonymity or submitted the report anonymously. True if anonymous.',
    `reporter_contact_info` STRING COMMENT 'Contact information for the reporter if they provided it and did not request anonymity. Used for follow-up and feedback.',
    `reporting_channel` STRING COMMENT 'Channel or mechanism through which the incident was reported to the organization. [ENUM-REF-CANDIDATE: internal_detection|anonymous_hotline|whistleblower_portal|donor_notification|beneficiary_complaint|partner_report|audit_finding — 7 candidates stripped; promote to reference product]',
    `resolution_date` DATE COMMENT 'Date when all corrective actions were completed and the incident was formally closed.',
    `severity_level` STRING COMMENT 'Assessed severity of the incident based on impact to beneficiaries, financial exposure, reputational risk, and regulatory implications.. Valid values are `critical|high|medium|low`',
    `triage_outcome` STRING COMMENT 'Initial triage decision determining the handling pathway for the reported incident.. Valid values are `escalate_to_investigation|refer_to_management|refer_to_hr|refer_to_legal|no_action_required|duplicate`',
    `created_by` STRING COMMENT 'User or system identifier of the person who created this incident record.',
    CONSTRAINT pk_incident PRIMARY KEY(`incident_id`)
) COMMENT 'Regulatory and organizational compliance incident (policy violations, audit findings, regulatory breaches, fraud, conflict of interest). Managed by compliance/legal teams. Source of truth for compliance case management. Distinct from safeguarding.safeguarding_incident which specifically tracks PSEA/safeguarding incidents with survivor-centered protocols. [SSOT Disambiguation] Role: Domain-specific view/extension. Cross-reference: safeguarding.safeguarding_incident. Distinction: safeguarding.safeguarding_incident is SSOT for PSEA/safeguarding incidents; compliance.compliance_incident covers regulatory/policy compliance breaches unrelated to safeguarding. Authoritative SSOT: safeguarding.safeguarding_incident.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` (
    `sanctions_screening_id` BIGINT COMMENT 'Unique identifier for the sanctions screening record. Primary key.',
    `donor_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.donor_requirement. Business justification: Sanctions screening (OFAC, debarment lists) is often mandated by specific donor compliance requirements. The sanctions_screening table has donor_requirement_flag, donor_name, and grant_reference_numbe',
    `incident_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_incident. Business justification: When a sanctions screening identifies a non-false-positive match (match_result indicates hit, false_positive_flag = false), it triggers a compliance incident requiring investigation and resolution. Th',
    `subaward_id` BIGINT COMMENT 'Foreign key linking to grant.subaward. Business justification: NGOs must screen subgrantees against OFAC/UN sanctions lists before executing subawards and at rescreening intervals. This FK links screening results to the subaward entity being vetted, enabling pre-',
    `certification_statement` STRING COMMENT 'Text of the anti-terrorism certification or compliance statement that this screening supports.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this sanctions screening record was first created in the system.',
    `false_positive_flag` BOOLEAN COMMENT 'Indicates whether a potential match was determined to be a false positive after investigation.',
    `legal_basis` STRING COMMENT 'Legal authority or executive order requiring the sanctions screening (e.g., US Executive Order 13224, UN Security Council Resolution 1267, EU Regulation 2580/2001).',
    `match_details` STRING COMMENT 'Detailed information about the match, including list entry details, matching criteria, and any aliases or alternate spellings that triggered the match.',
    `match_result` STRING COMMENT 'Outcome of the sanctions screening check indicating whether the subject was found on any sanctions list.. Valid values are `clear|potential_match|confirmed_match`',
    `match_score` DECIMAL(18,2) COMMENT 'Numerical confidence score (0-100) indicating the likelihood of a true match when potential matches are identified. Higher scores indicate stronger matches.',
    `next_screening_due_date` DATE COMMENT 'Date when the next periodic rescreening is due for this subject.',
    `rescreening_frequency_days` STRING COMMENT 'Number of days between required rescreening checks for this subject (e.g., 90, 180, 365).',
    `rescreening_required_flag` BOOLEAN COMMENT 'Indicates whether periodic rescreening is required for this subject based on risk profile or donor requirements.',
    `resolution_action` STRING COMMENT 'Action taken to resolve a potential or confirmed match (e.g., cleared after review, engagement blocked, escalated to legal, OFAC license requested, alternative vendor sourced).',
    `resolution_date` DATE COMMENT 'Date when the screening result was resolved and a final determination was made.',
    `resolution_notes` STRING COMMENT 'Detailed notes documenting the investigation, evidence reviewed, and rationale for the resolution decision.',
    `reviewer_email` STRING COMMENT 'Email address of the reviewer who approved the resolution decision.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `reviewer_name` STRING COMMENT 'Name of the senior compliance officer or legal counsel who reviewed and approved the resolution of a potential or confirmed match.',
    `risk_rating` STRING COMMENT 'Overall risk rating assigned to the subject based on screening results, geographic factors, and business context.. Valid values are `low|medium|high|critical`',
    `sanctions_list_checked` STRING COMMENT 'Name of the sanctions or debarment list(s) checked during this screening. Pipe-separated list for multiple lists (e.g., OFAC SDN|UN Security Council|EU Sanctions|World Bank Debarment).',
    `screener_email` STRING COMMENT 'Email address of the staff member who performed the screening, for audit trail and follow-up purposes.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `screener_name` STRING COMMENT 'Name of the staff member or compliance officer who performed or initiated the screening.',
    `screening_date` DATE COMMENT 'Date when the sanctions screening check was performed.',
    `screening_method` STRING COMMENT 'Method used to perform the sanctions screening check.. Valid values are `automated|manual|hybrid`',
    `screening_status` STRING COMMENT 'Current status of the sanctions screening record in the compliance workflow.. Valid values are `pending|in_review|cleared|blocked|escalated`',
    `screening_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the sanctions screening check was initiated, including time zone information.',
    `screening_tool` STRING COMMENT 'Name of the software tool or service used to perform the screening (e.g., Dow Jones Risk & Compliance, LexisNexis Bridger, manual OFAC search).',
    `subject_address` STRING COMMENT 'Known address or location of the subject being screened, used for geographic risk assessment.',
    `subject_date_of_birth` DATE COMMENT 'Date of birth of the individual being screened, used for identity matching and disambiguation.',
    `subject_identifier` STRING COMMENT 'Unique identifier of the subject in the source system (e.g., vendor ID, staff ID, beneficiary registration number).',
    `subject_name` STRING COMMENT 'Full name of the individual or organization being screened. May include legal name, aliases, or transliterations.',
    `subject_nationality` STRING COMMENT 'Nationality or country of citizenship of the individual or country of registration for organizations. Pipe-separated list for multiple nationalities.',
    `subject_type` STRING COMMENT 'Type of entity being screened against sanctions lists.. Valid values are `vendor|partner|staff|beneficiary|donor|volunteer`',
    `supporting_documentation` STRING COMMENT 'References to supporting documents, evidence, or file paths for screening reports, investigation notes, and approval records.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this sanctions screening record was last modified.',
    CONSTRAINT pk_sanctions_screening PRIMARY KEY(`sanctions_screening_id`)
) COMMENT 'Master record of sanctions and debarment screening checks performed against OFAC (Office of Foreign Assets Control), UN Security Council, EU, and other sanctions lists for vendors, partners, staff, and beneficiaries. Captures screening date, subject name, list checked, match result (clear, potential match, confirmed match), resolution action, screener identity, and re-screening frequency. Critical for anti-terrorism certification compliance required by USAID, DFID, and EU donors, and for organizational due diligence under US Executive Orders and UN resolutions. Source systems: eTools (assurance/audit tracking), SAP S/4HANA (VISION) (regulatory compliance), IATI Registry (publication tracking), eZHACT (HACT compliance). Deployed as Delta Lake tables in Databricks Unity Catalog with row-level security, column masking, and medallion architecture (bronze/silver/gold).';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ADD CONSTRAINT `fk_compliance_obligation_schedule_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ADD CONSTRAINT `fk_compliance_obligation_schedule_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ADD CONSTRAINT `fk_compliance_single_audit_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ADD CONSTRAINT `fk_compliance_single_audit_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_single_audit_id` FOREIGN KEY (`single_audit_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`single_audit`(`single_audit_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ADD CONSTRAINT `fk_compliance_sanctions_screening_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ADD CONSTRAINT `fk_compliance_sanctions_screening_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`incident`(`incident_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_ngo_v1`.`compliance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_ngo_v1`.`compliance` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` SET TAGS ('dbx_subdomain' = 'regulatory_obligations');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `amendment_flag` SET TAGS ('dbx_business_glossary_term' = 'Amendment Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `authorized_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Authorized Signatory Name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `authorized_signatory_name` SET TAGS ('dbx_pii_de_identified' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `authorized_signatory_name` SET TAGS ('dbx_sensitivity' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `authorized_signatory_name` SET TAGS ('dbx_pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `authorized_signatory_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `authorized_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Authorized Signatory Title');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document Uniform Resource Locator (URL)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Due Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `extended_due_date` SET TAGS ('dbx_business_glossary_term' = 'Extended Due Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `extension_granted_flag` SET TAGS ('dbx_business_glossary_term' = 'Extension Granted Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `extension_requested_flag` SET TAGS ('dbx_business_glossary_term' = 'Extension Requested Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Filing Fee Amount');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Filing Fee Currency Code');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_fee_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_fee_currency_code` SET TAGS ('dbx_lookup_candidate' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_fee_currency_code` SET TAGS ('dbx_lookup_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_fee_currency_code` SET TAGS ('dbx_needs_lookup_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_fee_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Fee Payment Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_notes` SET TAGS ('dbx_business_glossary_term' = 'Filing Notes');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_number` SET TAGS ('dbx_business_glossary_term' = 'Filing Number');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_number` SET TAGS ('dbx_lookup_candidate' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_number` SET TAGS ('dbx_lookup' = 'pending');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_number` SET TAGS ('dbx_needs_lookup_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_number` SET TAGS ('dbx_lookup_pending' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_number` SET TAGS ('dbx_lookup_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_number` SET TAGS ('dbx_lookup_code' = 'unmapped');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Period End Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Period Start Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Filing Status');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `preparer_name` SET TAGS ('dbx_business_glossary_term' = 'Preparer Name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `preparer_name` SET TAGS ('dbx_pii_de_identified' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `preparer_name` SET TAGS ('dbx_sensitivity' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `preparer_name` SET TAGS ('dbx_pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `preparer_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `preparer_organization` SET TAGS ('dbx_business_glossary_term' = 'Preparer Organization');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `preparer_ptin` SET TAGS ('dbx_business_glossary_term' = 'Preparer Tax Identification Number (PTIN)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `preparer_ptin` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `public_disclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `rejection_date` SET TAGS ('dbx_business_glossary_term' = 'Rejection Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_lookup_candidate' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_lookup' = 'pending');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_needs_lookup_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_lookup_pending' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_lookup_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_lookup_code' = 'unmapped');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_denormalized_ref' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `rejection_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Description');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `resubmission_count` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Count');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_pii_de_identified' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_sensitivity' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `reviewer_title` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Title');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `submission_channel` SET TAGS ('dbx_business_glossary_term' = 'Submission Channel');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `submission_channel` SET TAGS ('dbx_value_regex' = 'electronic|paper|online_portal|third_party_service|mail|in_person');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` SET TAGS ('dbx_subdomain' = 'regulatory_obligations');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Identifier');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `funding_source_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Source Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `chs_self_assessment_required` SET TAGS ('dbx_business_glossary_term' = 'Core Humanitarian Standard (CHS) Self-Assessment Required');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_business_glossary_term' = 'Obligation Code');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_lookup_candidate' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_lookup' = 'pending');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_needs_lookup_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_lookup_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_lookup_code' = 'unmapped');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_self_ref' = 'hierarchy');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `documentation_required` SET TAGS ('dbx_business_glossary_term' = 'Documentation Required');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `escalation_threshold_days` SET TAGS ('dbx_business_glossary_term' = 'Escalation Threshold (Days)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `fiscal_year_applicable` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year Applicable');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Obligation Frequency');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `governing_body` SET TAGS ('dbx_business_glossary_term' = 'Governing Body');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `iati_publication_required` SET TAGS ('dbx_business_glossary_term' = 'International Aid Transparency Initiative (IATI) Publication Required');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `last_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Completed Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `legal_basis` SET TAGS ('dbx_business_glossary_term' = 'Legal Basis');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_name` SET TAGS ('dbx_business_glossary_term' = 'Obligation Name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_name` SET TAGS ('dbx_pii_de_identified' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_name` SET TAGS ('dbx_sensitivity' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_name` SET TAGS ('dbx_pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `next_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Due Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Obligation Notes');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_status` SET TAGS ('dbx_business_glossary_term' = 'Obligation Status');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_status` SET TAGS ('dbx_value_regex' = 'active|pending|completed|overdue|waived|suspended');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_business_glossary_term' = 'Obligation Type');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_value_regex' = 'regulatory|donor|voluntary|contractual|statutory');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `penalty_description` SET TAGS ('dbx_business_glossary_term' = 'Penalty Description');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `responsible_person` SET TAGS ('dbx_business_glossary_term' = 'Responsible Person');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `responsible_person` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `responsible_person` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `responsible_unit` SET TAGS ('dbx_business_glossary_term' = 'Responsible Unit');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `single_audit_required` SET TAGS ('dbx_business_glossary_term' = 'Single Audit Required');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'online_portal|email|postal_mail|in_person|api|ftp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `submission_url` SET TAGS ('dbx_business_glossary_term' = 'Submission Uniform Resource Locator (URL)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` SET TAGS ('dbx_subdomain' = 'regulatory_obligations');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `obligation_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Schedule Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `actual_effort_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Effort Hours');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Completion Status');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `completion_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|overdue|waived|deferred');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `effective_due_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Due Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `escalation_threshold_days` SET TAGS ('dbx_business_glossary_term' = 'Escalation Threshold Days');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `escalation_triggered_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Triggered Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `estimated_effort_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Effort Hours');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `extended_due_date` SET TAGS ('dbx_business_glossary_term' = 'Extended Due Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `extension_granted_flag` SET TAGS ('dbx_business_glossary_term' = 'Extension Granted Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `extension_reason` SET TAGS ('dbx_business_glossary_term' = 'Extension Reason');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `extension_requested_flag` SET TAGS ('dbx_business_glossary_term' = 'Extension Requested Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `non_compliance_risk` SET TAGS ('dbx_business_glossary_term' = 'Non-Compliance Risk');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `non_compliance_risk` SET TAGS ('dbx_value_regex' = 'severe|high|moderate|low|minimal');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_lookup_candidate' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_lookup' = 'pending');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_needs_lookup_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_lookup_pending' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_lookup_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_lookup_code' = 'unmapped');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `planned_due_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Due Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `recurrence_pattern` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Pattern');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `recurrence_pattern` SET TAGS ('dbx_value_regex' = 'one_time|annual|quarterly|monthly|biennial|event_driven');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `reviewer_notes` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Notes');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `supporting_document_count` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Count');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `workflow_stage` SET TAGS ('dbx_business_glossary_term' = 'Workflow Stage');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` SET TAGS ('dbx_subdomain' = 'audit_findings');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `single_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Single Audit Identifier');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `audit_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement Cost Amount');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `audit_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `audit_finding_count` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Count');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `audit_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Period End Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `audit_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Period Start Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `audit_report_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Issuance Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Single Audit Status');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `audit_year` SET TAGS ('dbx_business_glossary_term' = 'Audit Fiscal Year');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `auditor_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Auditor Contact Email Address');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `auditor_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `auditor_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `auditor_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `auditor_contact_email` SET TAGS ('dbx_sensitivity' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `auditor_contact_email` SET TAGS ('dbx_pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `auditor_contact_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `auditor_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Contact Name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `auditor_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `auditor_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `auditor_contact_name` SET TAGS ('dbx_sensitivity' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `auditor_contact_name` SET TAGS ('dbx_pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `auditor_contact_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `auditor_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Auditor Contact Phone Number');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `auditor_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `auditor_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `auditor_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `auditor_contact_phone` SET TAGS ('dbx_pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `auditor_contact_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `auditor_ein` SET TAGS ('dbx_business_glossary_term' = 'Auditor Employer Identification Number (EIN)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `auditor_ein` SET TAGS ('dbx_value_regex' = '^d{2}-d{7}$');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `auditor_ein` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `auditor_firm_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Firm Name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `auditor_firm_name` SET TAGS ('dbx_pii_de_identified' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `auditor_firm_name` SET TAGS ('dbx_sensitivity' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `auditor_firm_name` SET TAGS ('dbx_pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `auditor_firm_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `compliance_opinion_type` SET TAGS ('dbx_business_glossary_term' = 'Federal Compliance Opinion Type');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `compliance_opinion_type` SET TAGS ('dbx_value_regex' = 'unmodified|qualified|adverse|disclaimer');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `corrective_action_plan_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan Submission Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `corrective_action_plan_submitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan Submitted Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `currency_code` SET TAGS ('dbx_lookup_candidate' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `currency_code` SET TAGS ('dbx_lookup' = 'pending');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `currency_code` SET TAGS ('dbx_needs_lookup_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `currency_code` SET TAGS ('dbx_lookup_pending' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `currency_code` SET TAGS ('dbx_lookup_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `currency_code` SET TAGS ('dbx_lookup_code' = 'unmapped');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `engagement_letter_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement Letter Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `federal_expenditure_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Federal Expenditure Amount');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `fieldwork_end_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Fieldwork End Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `fieldwork_start_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Fieldwork Start Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `financial_statement_opinion_type` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Opinion Type');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `financial_statement_opinion_type` SET TAGS ('dbx_value_regex' = 'unmodified|qualified|adverse|disclaimer');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `going_concern_issue_flag` SET TAGS ('dbx_business_glossary_term' = 'Going Concern Issue Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `internal_control_opinion_type` SET TAGS ('dbx_business_glossary_term' = 'Internal Control Opinion Type');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `internal_control_opinion_type` SET TAGS ('dbx_value_regex' = 'unmodified|qualified|adverse|disclaimer');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `low_risk_auditee_flag` SET TAGS ('dbx_business_glossary_term' = 'Low-Risk Auditee Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `major_program_count` SET TAGS ('dbx_business_glossary_term' = 'Major Program Count');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `material_weakness_identified_flag` SET TAGS ('dbx_business_glossary_term' = 'Material Weakness Identified Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `questioned_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Questioned Cost Amount');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `sefa_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Schedule of Expenditures of Federal Awards (SEFA) Reference Number');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `sefa_reference_number` SET TAGS ('dbx_lookup_candidate' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `sefa_reference_number` SET TAGS ('dbx_lookup' = 'pending');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `sefa_reference_number` SET TAGS ('dbx_needs_lookup_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `sefa_reference_number` SET TAGS ('dbx_lookup_pending' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `sefa_reference_number` SET TAGS ('dbx_lookup_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `sefa_reference_number` SET TAGS ('dbx_lookup_code' = 'unmapped');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `significant_deficiency_identified_flag` SET TAGS ('dbx_business_glossary_term' = 'Significant Deficiency Identified Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` SET TAGS ('dbx_subdomain' = 'audit_findings');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Identifier');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `single_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Single Audit Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `subaward_id` SET TAGS ('dbx_business_glossary_term' = 'Subaward Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `actual_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Resolution Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `audit_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Period End Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `audit_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Period Start Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `auditor_name` SET TAGS ('dbx_pii_de_identified' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `auditor_name` SET TAGS ('dbx_sensitivity' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `auditor_name` SET TAGS ('dbx_pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `auditor_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `cause_description` SET TAGS ('dbx_business_glossary_term' = 'Cause Description');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `cfda_number` SET TAGS ('dbx_business_glossary_term' = 'Catalog of Federal Domestic Assistance (CFDA) Number');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `cfda_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2}.[0-9]{3}$');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `cfda_number` SET TAGS ('dbx_lookup_candidate' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `cfda_number` SET TAGS ('dbx_lookup' = 'pending');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `cfda_number` SET TAGS ('dbx_needs_lookup_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `cfda_number` SET TAGS ('dbx_lookup_pending' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `cfda_number` SET TAGS ('dbx_lookup_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `cfda_number` SET TAGS ('dbx_lookup_code' = 'unmapped');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `cfda_number` SET TAGS ('dbx_natural_key' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `compliance_requirement_type` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement Type');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `condition_description` SET TAGS ('dbx_business_glossary_term' = 'Condition Description');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `criteria_description` SET TAGS ('dbx_business_glossary_term' = 'Criteria Description');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `effect_description` SET TAGS ('dbx_business_glossary_term' = 'Effect Description');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `expected_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Resolution Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `fac_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Federal Audit Clearinghouse (FAC) Submission Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `federal_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Federal Agency Name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `federal_agency_name` SET TAGS ('dbx_pii_de_identified' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `federal_agency_name` SET TAGS ('dbx_sensitivity' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `federal_agency_name` SET TAGS ('dbx_pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `federal_agency_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `federal_award_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Federal Award Identification Number (FAIN)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `federal_award_identification_number` SET TAGS ('dbx_lookup_candidate' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `federal_award_identification_number` SET TAGS ('dbx_lookup' = 'pending');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `federal_award_identification_number` SET TAGS ('dbx_needs_lookup_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `federal_award_identification_number` SET TAGS ('dbx_lookup_pending' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `federal_award_identification_number` SET TAGS ('dbx_lookup_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `federal_award_identification_number` SET TAGS ('dbx_lookup_code' = 'unmapped');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `federal_award_identification_number` SET TAGS ('dbx_natural_key' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_identified_date` SET TAGS ('dbx_business_glossary_term' = 'Finding Identified Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Finding Reference Number');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_reference_number` SET TAGS ('dbx_lookup_candidate' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_reference_number` SET TAGS ('dbx_lookup' = 'pending');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_reference_number` SET TAGS ('dbx_needs_lookup_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_reference_number` SET TAGS ('dbx_lookup_pending' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_reference_number` SET TAGS ('dbx_lookup_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_reference_number` SET TAGS ('dbx_lookup_code' = 'unmapped');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_reference_number` SET TAGS ('dbx_natural_key' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_status` SET TAGS ('dbx_business_glossary_term' = 'Finding Status');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_status` SET TAGS ('dbx_value_regex' = 'open|in_remediation|resolved|closed|repeat_finding');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_title` SET TAGS ('dbx_business_glossary_term' = 'Finding Title');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_business_glossary_term' = 'Finding Type');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_value_regex' = 'material_weakness|significant_deficiency|questioned_cost|noncompliance|other_matter');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `is_fraud_indicator` SET TAGS ('dbx_business_glossary_term' = 'Is Fraud Indicator Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `is_material_weakness` SET TAGS ('dbx_business_glossary_term' = 'Is Material Weakness Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `is_repeat_finding` SET TAGS ('dbx_business_glossary_term' = 'Is Repeat Finding Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `is_significant_deficiency` SET TAGS ('dbx_business_glossary_term' = 'Is Significant Deficiency Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `management_response` SET TAGS ('dbx_business_glossary_term' = 'Management Response');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Finding Notes');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `prior_finding_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Prior Finding Reference Number');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `prior_finding_reference_number` SET TAGS ('dbx_lookup_candidate' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `prior_finding_reference_number` SET TAGS ('dbx_lookup' = 'pending');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `prior_finding_reference_number` SET TAGS ('dbx_needs_lookup_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `prior_finding_reference_number` SET TAGS ('dbx_lookup_pending' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `prior_finding_reference_number` SET TAGS ('dbx_lookup_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `prior_finding_reference_number` SET TAGS ('dbx_lookup_code' = 'unmapped');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `prior_finding_reference_number` SET TAGS ('dbx_natural_key' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `questioned_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Questioned Cost Amount');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `questioned_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Questioned Cost Currency Code');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `questioned_cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `questioned_cost_currency_code` SET TAGS ('dbx_lookup_candidate' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `questioned_cost_currency_code` SET TAGS ('dbx_lookup_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `questioned_cost_currency_code` SET TAGS ('dbx_needs_lookup_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `recommendation_description` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Description');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `reported_to_federal_audit_clearinghouse` SET TAGS ('dbx_business_glossary_term' = 'Reported to Federal Audit Clearinghouse (FAC) Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `responsible_person_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Person Name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `responsible_person_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `responsible_person_name` SET TAGS ('dbx_pii_de_identified' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `responsible_person_name` SET TAGS ('dbx_sensitivity' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `responsible_person_name` SET TAGS ('dbx_pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `responsible_person_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` SET TAGS ('dbx_subdomain' = 'audit_findings');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `corrective_action_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) ID');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Finding ID');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `subaward_id` SET TAGS ('dbx_business_glossary_term' = 'Subaward Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `audit_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Reference');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `cap_number` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) Number');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `cap_number` SET TAGS ('dbx_lookup_candidate' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `cap_number` SET TAGS ('dbx_lookup' = 'pending');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `cap_number` SET TAGS ('dbx_needs_lookup_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `cap_number` SET TAGS ('dbx_lookup_pending' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `cap_number` SET TAGS ('dbx_lookup_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `cap_number` SET TAGS ('dbx_lookup_code' = 'unmapped');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `cap_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) Status');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_lookup_candidate' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_lookup' = 'pending');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_needs_lookup_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_lookup_pending' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_lookup_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_lookup_code' = 'unmapped');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `donor_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Donor Notification Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `donor_notification_date` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `donor_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Donor Notification Required');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `donor_notification_required` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `escalation_required` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `finding_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Finding Reference Number');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `finding_reference_number` SET TAGS ('dbx_lookup_candidate' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `finding_reference_number` SET TAGS ('dbx_lookup' = 'pending');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `finding_reference_number` SET TAGS ('dbx_needs_lookup_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `finding_reference_number` SET TAGS ('dbx_lookup_pending' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `finding_reference_number` SET TAGS ('dbx_lookup_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `finding_reference_number` SET TAGS ('dbx_lookup_code' = 'unmapped');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `finding_reference_number` SET TAGS ('dbx_natural_key' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `finding_severity` SET TAGS ('dbx_business_glossary_term' = 'Finding Severity');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `finding_severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `finding_type` SET TAGS ('dbx_business_glossary_term' = 'Finding Type');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `finding_type` SET TAGS ('dbx_value_regex' = 'audit_finding|chs_non_conformity|donor_compliance_issue|internal_control_deficiency|regulatory_violation|fraud_allegation');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `management_response` SET TAGS ('dbx_business_glossary_term' = 'Management Response');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `preventive_measures` SET TAGS ('dbx_business_glossary_term' = 'Preventive Measures');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `recurrence_risk` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Risk');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `recurrence_risk` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `regulatory_reporting_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `regulatory_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `sphere_standard_reference` SET TAGS ('dbx_business_glossary_term' = 'Sphere Standard Reference');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `verification_notes` SET TAGS ('dbx_business_glossary_term' = 'Verification Notes');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` SET TAGS ('dbx_subdomain' = 'regulatory_obligations');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `donor_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Requirement Identifier');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `donor_requirement_id` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `subaward_id` SET TAGS ('dbx_business_glossary_term' = 'Subaward Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `actual_effort_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Effort Hours');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_lookup_candidate' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_lookup_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_needs_lookup_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `deliverable_format` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Format');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `donor_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Donor Contact Email');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `donor_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `donor_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `donor_contact_email` SET TAGS ('dbx_pii_de_identified' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `donor_contact_email` SET TAGS ('dbx_sensitivity' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `donor_contact_email` SET TAGS ('dbx_pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `donor_contact_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `donor_contact_email` SET TAGS ('dbx_pii_donor' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `donor_contact_email` SET TAGS ('dbx_mask_in_non_prod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `donor_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Donor Contact Name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `donor_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `donor_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `donor_contact_name` SET TAGS ('dbx_sensitivity' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `donor_contact_name` SET TAGS ('dbx_pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `donor_contact_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `donor_contact_name` SET TAGS ('dbx_pii_donor' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `donor_contact_name` SET TAGS ('dbx_mask_in_non_prod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `estimated_effort_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Effort Hours');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `internal_policy_reference` SET TAGS ('dbx_business_glossary_term' = 'Internal Policy Reference');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `non_compliance_consequence` SET TAGS ('dbx_business_glossary_term' = 'Non-Compliance Consequence');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `non_compliance_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Non-Compliance Risk Level');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `non_compliance_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `requirement_description` SET TAGS ('dbx_business_glossary_term' = 'Requirement Description');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `requirement_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Requirement Reference Number');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `requirement_reference_number` SET TAGS ('dbx_lookup_candidate' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `requirement_reference_number` SET TAGS ('dbx_lookup' = 'pending');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `requirement_reference_number` SET TAGS ('dbx_needs_lookup_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `requirement_reference_number` SET TAGS ('dbx_lookup_pending' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `requirement_reference_number` SET TAGS ('dbx_lookup_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `requirement_reference_number` SET TAGS ('dbx_lookup_code' = 'unmapped');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `requirement_reference_number` SET TAGS ('dbx_natural_key' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `requirement_title` SET TAGS ('dbx_business_glossary_term' = 'Requirement Title');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'email|online_portal|postal_mail|in_person|ftp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `supporting_document_url` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document URL');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `waiver_granted_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver Granted Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `waiver_justification` SET TAGS ('dbx_business_glossary_term' = 'Waiver Justification');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `waiver_requested_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver Requested Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` SET TAGS ('dbx_subdomain' = 'audit_findings');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident ID');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Country Office ID');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `country_office_id` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `subaward_id` SET TAGS ('dbx_business_glossary_term' = 'Subaward Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `allegation_category` SET TAGS ('dbx_business_glossary_term' = 'Allegation Category');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `incident_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Description');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `incident_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `donor_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Donor Notification Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `donor_notification_date` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `donor_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Donor Notification Required Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `donor_notification_required_flag` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `estimated_financial_impact_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Financial Impact (USD)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `estimated_financial_impact_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Number');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_value_regex' = '^INC-[0-9]{8}$');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_lookup_candidate' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_lookup' = 'pending');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_needs_lookup_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_lookup_pending' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_lookup_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_lookup_code' = 'unmapped');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_natural_key' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Status');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_value_regex' = 'reported|under_review|investigation_open|investigation_closed|resolved|dismissed');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Type');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_value_regex' = 'fraud|financial_mismanagement|procurement_irregularity|data_protection_violation|ethical_breach|safeguarding');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `investigation_assigned_to` SET TAGS ('dbx_business_glossary_term' = 'Investigation Assigned To');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `investigation_assigned_to` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `investigation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completion Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `investigation_finding` SET TAGS ('dbx_business_glossary_term' = 'Investigation Finding');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `investigation_finding` SET TAGS ('dbx_value_regex' = 'substantiated|partially_substantiated|unsubstantiated|inconclusive');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `investigation_finding` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `investigation_notes` SET TAGS ('dbx_business_glossary_term' = 'Investigation Notes');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `investigation_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `investigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `lessons_learned` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `public_disclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `regulatory_report_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `reported_date` SET TAGS ('dbx_business_glossary_term' = 'Reported Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `reporter_anonymity_flag` SET TAGS ('dbx_business_glossary_term' = 'Reporter Anonymity Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `reporter_contact_info` SET TAGS ('dbx_business_glossary_term' = 'Reporter Contact Information');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `reporter_contact_info` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `reporter_contact_info` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `reporting_channel` SET TAGS ('dbx_business_glossary_term' = 'Reporting Channel');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `triage_outcome` SET TAGS ('dbx_business_glossary_term' = 'Triage Outcome');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `triage_outcome` SET TAGS ('dbx_value_regex' = 'escalate_to_investigation|refer_to_management|refer_to_hr|refer_to_legal|no_action_required|duplicate');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`incident` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` SET TAGS ('dbx_subdomain' = 'audit_findings');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `sanctions_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening ID');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `donor_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Requirement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `donor_requirement_id` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `subaward_id` SET TAGS ('dbx_business_glossary_term' = 'Subaward Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `certification_statement` SET TAGS ('dbx_business_glossary_term' = 'Certification Statement');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `false_positive_flag` SET TAGS ('dbx_business_glossary_term' = 'False Positive Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `legal_basis` SET TAGS ('dbx_business_glossary_term' = 'Legal Basis');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `match_details` SET TAGS ('dbx_business_glossary_term' = 'Match Details');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `match_result` SET TAGS ('dbx_business_glossary_term' = 'Match Result');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `match_result` SET TAGS ('dbx_value_regex' = 'clear|potential_match|confirmed_match');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `match_score` SET TAGS ('dbx_business_glossary_term' = 'Match Score');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `next_screening_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Screening Due Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `rescreening_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Rescreening Frequency Days');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `rescreening_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Rescreening Required Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `resolution_action` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `reviewer_email` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Email');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `reviewer_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `reviewer_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `reviewer_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `reviewer_email` SET TAGS ('dbx_sensitivity' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `reviewer_email` SET TAGS ('dbx_pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `reviewer_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_pii_de_identified' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_sensitivity' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `sanctions_list_checked` SET TAGS ('dbx_business_glossary_term' = 'Sanctions List Checked');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `screener_email` SET TAGS ('dbx_business_glossary_term' = 'Screener Email');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `screener_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `screener_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `screener_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `screener_email` SET TAGS ('dbx_sensitivity' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `screener_email` SET TAGS ('dbx_pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `screener_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `screener_name` SET TAGS ('dbx_business_glossary_term' = 'Screener Name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `screener_name` SET TAGS ('dbx_pii_de_identified' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `screener_name` SET TAGS ('dbx_sensitivity' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `screener_name` SET TAGS ('dbx_pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `screener_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `screening_date` SET TAGS ('dbx_business_glossary_term' = 'Screening Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `screening_method` SET TAGS ('dbx_business_glossary_term' = 'Screening Method');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `screening_method` SET TAGS ('dbx_value_regex' = 'automated|manual|hybrid');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `screening_status` SET TAGS ('dbx_business_glossary_term' = 'Screening Status');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `screening_status` SET TAGS ('dbx_value_regex' = 'pending|in_review|cleared|blocked|escalated');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `screening_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Screening Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `screening_tool` SET TAGS ('dbx_business_glossary_term' = 'Screening Tool');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `subject_address` SET TAGS ('dbx_business_glossary_term' = 'Subject Address');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `subject_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `subject_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `subject_address` SET TAGS ('dbx_sensitivity' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `subject_address` SET TAGS ('dbx_pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `subject_address` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `subject_date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Subject Date of Birth');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `subject_date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `subject_date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `subject_date_of_birth` SET TAGS ('dbx_pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `subject_identifier` SET TAGS ('dbx_business_glossary_term' = 'Subject Identifier');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `subject_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `subject_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `subject_name` SET TAGS ('dbx_business_glossary_term' = 'Subject Name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `subject_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `subject_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `subject_name` SET TAGS ('dbx_sensitivity' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `subject_name` SET TAGS ('dbx_pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `subject_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `subject_nationality` SET TAGS ('dbx_business_glossary_term' = 'Subject Nationality');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `subject_nationality` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `subject_nationality` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `subject_nationality` SET TAGS ('dbx_pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `subject_nationality` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `subject_nationality` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `subject_type` SET TAGS ('dbx_business_glossary_term' = 'Subject Type');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `subject_type` SET TAGS ('dbx_value_regex' = 'vendor|partner|staff|beneficiary|donor|volunteer');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `supporting_documentation` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documentation');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
