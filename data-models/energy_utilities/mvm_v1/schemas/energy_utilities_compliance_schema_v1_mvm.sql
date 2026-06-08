-- Schema for Domain: compliance | Business: Energy Utilities | Version: v1_mvm
-- Generated on: 2026-05-05 00:40:03

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `energy_utilities_ecm`.`compliance` COMMENT 'Regulatory compliance management including NERC CIP audits, FERC reporting, PUC rate cases, environmental permits, emissions reporting to EPA, reliability standards documentation, SOX controls, and CPCN applications. Manages compliance obligations, audit trails, regulatory filings, evidence collection, enforcement action records, and regulatory correspondence. Serves as SSOT for compliance posture reporting to the Board and external regulators.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `energy_utilities_ecm`.`compliance`.`obligation` (
    `obligation_id` BIGINT COMMENT 'Unique identifier for the regulatory compliance obligation record.',
    `model_id` BIGINT COMMENT 'Foreign key linking to forecast.model. Business justification: NERC reliability standards (e.g., MOD-032) mandate specific load forecasting methodologies. RPS obligations require renewable generation forecast models for compliance tracking. Regulatory obligations',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this obligation is currently active and enforceable (True/False). Inactive obligations are retained for historical reference.',
    `applicability_scope` STRING COMMENT 'Business function or operational area to which the obligation applies (generation, transmission, distribution, trading, retail, wholesale, enterprise-wide, specific facility, specific asset class). [ENUM-REF-CANDIDATE: generation|transmission|distribution|trading|retail|wholesale|enterprise_wide|specific_facility|specific_asset_class — 9 candidates stripped; promote to reference product]',
    `board_reporting_flag` BOOLEAN COMMENT 'Indicates whether compliance status for this obligation must be reported to the Board of Directors (True/False).',
    `compliance_frequency` STRING COMMENT 'Frequency at which compliance with the obligation must be demonstrated or reported (continuous, daily, weekly, monthly, quarterly, semi-annual, annual, biennial, triennial, event-driven, one-time). [ENUM-REF-CANDIDATE: continuous|daily|weekly|monthly|quarterly|semi_annual|annual|biennial|triennial|event_driven|one_time — 11 candidates stripped; promote to reference product]',
    `compliance_notes` STRING COMMENT 'Free-text field for additional notes, context, or guidance related to compliance with this obligation.',
    `compliance_status` STRING COMMENT 'Current compliance status of the utility with respect to this obligation (compliant, non-compliant, in-progress, not-applicable, under-review, remediation-required).. Valid values are `compliant|non_compliant|in_progress|not_applicable|under_review|remediation_required`',
    `control_effectiveness_rating` STRING COMMENT 'Assessment of the effectiveness of internal controls in place to ensure compliance with this obligation (effective, needs-improvement, ineffective, not-assessed).. Valid values are `effective|needs_improvement|ineffective|not_assessed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this obligation record was first created in the system.',
    `effective_date` DATE COMMENT 'Date on which the compliance obligation became or will become effective and enforceable.',
    `enforcement_action_flag` BOOLEAN COMMENT 'Indicates whether an enforcement action has been taken against the utility for non-compliance with this obligation (True/False).',
    `evidence_collection_method` STRING COMMENT 'Method by which compliance evidence is collected for this obligation (automated, manual, hybrid, third-party).. Valid values are `automated|manual|hybrid|third_party`',
    `evidence_retention_period_years` STRING COMMENT 'Number of years that compliance evidence must be retained for this obligation.',
    `expiration_date` DATE COMMENT 'Date on which the compliance obligation expires or is superseded. Null if the obligation is ongoing.',
    `external_auditor_flag` BOOLEAN COMMENT 'Indicates whether this obligation is subject to external auditor review (True/False).',
    `governing_body` STRING COMMENT 'Regulatory authority or governing body that issued the compliance obligation (NERC, FERC, PUC, EPA, DOE, OSHA, IEC, IEEE, NAESB, SOX). [ENUM-REF-CANDIDATE: NERC|FERC|PUC|EPA|DOE|OSHA|IEC|IEEE|NAESB|SOX — 10 candidates stripped; promote to reference product]',
    `imposed_by_agency` BIGINT COMMENT 'FK to compliance.regulatory_agency.regulatory_agency_id — Each obligation is imposed by a governing regulatory body. This is a fundamental master-reference FK.',
    `last_audit_date` DATE COMMENT 'Date of the most recent internal or external audit that assessed compliance with this obligation.',
    `last_audit_result` STRING COMMENT 'Outcome of the most recent audit for this obligation (pass, fail, conditional-pass, not-audited).. Valid values are `pass|fail|conditional_pass|not_audited`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this obligation record was last modified.',
    `mitigation_plan_required_flag` BOOLEAN COMMENT 'Indicates whether a formal mitigation plan is required for this obligation (True/False).',
    `mitigation_plan_status` STRING COMMENT 'Current status of the mitigation plan for this obligation (not-required, planned, in-progress, completed, approved, rejected).. Valid values are `not_required|planned|in_progress|completed|approved|rejected`',
    `next_audit_date` DATE COMMENT 'Scheduled date for the next internal or external audit of this obligation.',
    `next_compliance_due_date` DATE COMMENT 'Next scheduled date by which compliance evidence or reporting is due for this obligation.',
    `obligation_category` STRING COMMENT 'High-level category grouping for the obligation (e.g., NERC CIP for cybersecurity, TPL for transmission planning, FAC for facilities, environmental, financial, safety, operational). [ENUM-REF-CANDIDATE: CIP|TPL|FAC|MOD|PRC|VAR|TOP|IRO|BAL|EOP|NUC|COM|environmental|financial|safety|operational — 16 candidates stripped; promote to reference product]',
    `obligation_code` STRING COMMENT 'Business-assigned unique code for the compliance obligation (e.g., NERC-CIP-007-6, FERC-717, PUC-RR-2023-01).. Valid values are `^[A-Z0-9]{3,20}$`',
    `obligation_description` STRING COMMENT 'Detailed description of what the utility is required to do to comply with this obligation, including specific actions, controls, or reporting requirements.',
    `obligation_name` STRING COMMENT 'Full descriptive name of the regulatory compliance obligation.',
    `obligation_type` STRING COMMENT 'Classification of the compliance obligation by its nature (reliability standard, tariff requirement, service territory rule, emissions limit, safety mandate, internal control, certificate condition, reporting requirement, operational requirement, financial requirement). [ENUM-REF-CANDIDATE: reliability_standard|tariff_requirement|service_territory_rule|emissions_limit|safety_mandate|internal_control|certificate_condition|reporting_requirement|operational_requirement|financial_requirement — 10 candidates stripped; promote to reference product]',
    `parent_obligation_code` STRING COMMENT 'Code of the parent obligation if this is a sub-requirement or part of a larger obligation. Null if this is a top-level obligation.',
    `penalty_amount_usd` DECIMAL(18,2) COMMENT 'Maximum or typical financial penalty amount in US dollars for non-compliance with this obligation.',
    `regulatory_citation` STRING COMMENT 'Full legal citation or reference to the regulation, standard, or rule (e.g., NERC CIP-007-6 R2, FERC Order 1000, 40 CFR Part 60).',
    `reporting_format` STRING COMMENT 'Format in which compliance reporting must be submitted (electronic, paper, web-portal, API, email).. Valid values are `electronic|paper|web_portal|api|email`',
    `reporting_system` STRING COMMENT 'Name of the external system or portal used for compliance reporting (e.g., NERC CMEP Portal, FERC eFiling, State PUC Portal).',
    `responsible_role` STRING COMMENT 'Job title or role responsible for managing compliance with this obligation (e.g., Compliance Manager, NERC CIP Coordinator, Environmental Manager).',
    `risk_rating` STRING COMMENT 'Internal risk rating assigned to this obligation based on impact and likelihood of non-compliance (critical, high, medium, low).. Valid values are `critical|high|medium|low`',
    `sub_requirement_count` STRING COMMENT 'Number of sub-requirements or parts within this obligation (e.g., NERC CIP-007-6 has multiple R1, R2, R3 requirements).',
    `updated_by_user` STRING COMMENT 'Username or identifier of the person who last updated this obligation record.',
    `vrf` STRING COMMENT 'NERC Violation Risk Factor indicating the potential impact of non-compliance on bulk electric system reliability (lower, medium, high). Applicable to NERC reliability standards only.. Valid values are `lower|medium|high`',
    `vsl` STRING COMMENT 'NERC Violation Severity Level indicating the degree of non-compliance (lower, moderate, high, severe). Applicable to NERC reliability standards only.. Valid values are `lower|moderate|high|severe`',
    CONSTRAINT pk_obligation PRIMARY KEY(`obligation_id`)
) COMMENT 'Master registry of all regulatory compliance obligations applicable to the utility, including NERC CIP standards, FERC tariff requirements, PUC service territory rules, EPA emissions limits, OSHA safety mandates, SOX internal controls, CPCN conditions, and NERC reliability standard sub-requirements. Each obligation record captures the governing body, regulatory citation, effective dates, applicability scope (generation, transmission, distribution, trading), compliance frequency, responsible organizational unit, violation risk factor (VRF), violation severity level (VSL) where applicable, and current compliance status. Serves as the SSOT for what the utility is required to do and by when, and drives audit preparation, evidence collection workflows, risk assessment prioritization, and regulatory filing schedules.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` (
    `regulatory_filing_id` BIGINT COMMENT 'Unique identifier for the regulatory filing record. Primary key.',
    `load_id` BIGINT COMMENT 'Foreign key linking to forecast.load. Business justification: Rate case filings and IRP submissions cite specific load forecasts as evidentiary support for revenue requirements and capacity needs. PUC dockets require utilities to reference the exact load forecas',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Each regulatory filing fulfills a specific regulatory obligation (e.g., annual FERC Form 1, quarterly PUC financial reports). Many filings can fulfill one obligation (1:N). Adding obligation_id FK lin',
    `rate_case_id` BIGINT COMMENT 'Foreign key linking to compliance.rate_case. Business justification: A regulatory filing can be part of a rate case proceeding. Many filings can relate to one rate case (1:N). The docket_number in regulatory_filing often references a rate case docket. Adding rate_case_',
    `regulatory_obligation_id` BIGINT COMMENT 'FK to compliance.obligation.obligation_id — Regulatory filings are submitted to fulfill specific compliance obligations. This link enables tracking which obligations have been satisfied by which filings.',
    `approval_date` DATE COMMENT 'The date on which the regulatory agency formally approved or accepted the filing, if applicable.',
    `commission_order_date` DATE COMMENT 'The date on which the regulatory commission issued its final order or decision on this filing.',
    `commission_order_number` STRING COMMENT 'The official order number issued by the regulatory commission in response to this filing (e.g., FERC Order No. 1000, PUC Order No. U-20788-A).',
    `cpcn_capital_cost_estimate` DECIMAL(18,2) COMMENT 'For CPCN applications, the estimated total capital expenditure (CAPEX) for the proposed project, expressed in USD.',
    `cpcn_environmental_review_status` STRING COMMENT 'For CPCN applications, the current status of required environmental impact assessments and regulatory reviews (e.g., NEPA, state environmental permits).. Valid values are `Not_Started|In_Progress|Completed|Approved|Conditional_Approval`',
    `cpcn_project_description` STRING COMMENT 'For CPCN applications, a detailed description of the proposed capital project, including scope, location, technology, and public benefit justification.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this regulatory filing record was first created in the system.',
    `docket_number` STRING COMMENT 'The official docket or case number assigned by the regulatory agency to track this proceeding or filing (e.g., FERC Docket No. ER21-1234, PUC Case No. U-20788).',
    `due_date` DATE COMMENT 'The regulatory deadline by which this filing must be submitted to remain in compliance.',
    `epa_emissions_report_type` STRING COMMENT 'For EPA emissions filings, the specific type of emissions reporting submission (e.g., annual inventory, continuous emissions monitoring system data, greenhouse gas reporting).. Valid values are `Annual_Emissions_Inventory|Quarterly_Emissions_Report|CEMS_Data_Submission|GHG_Reporting`',
    `filing_description` STRING COMMENT 'A detailed narrative description of the purpose, scope, and content of this regulatory filing, including key issues addressed and relief requested.',
    `filing_document_count` STRING COMMENT 'The total number of supporting documents, exhibits, and attachments included in this regulatory filing submission.',
    `filing_number` STRING COMMENT 'The externally-known unique identifier assigned to this regulatory submission by the utility or regulatory body (e.g., docket number, case number, filing reference).',
    `filing_period_end_date` DATE COMMENT 'The ending date of the reporting or compliance period covered by this filing.',
    `filing_period_start_date` DATE COMMENT 'The beginning date of the reporting or compliance period covered by this filing (e.g., start of fiscal year for FERC Form 1, start of quarter for EQR).',
    `filing_status` STRING COMMENT 'Current lifecycle status of the regulatory filing, tracking its progression from preparation through final disposition. [ENUM-REF-CANDIDATE: Draft|Submitted|Under_Review|Accepted|Rejected|Withdrawn|Pending_Response — 7 candidates stripped; promote to reference product]',
    `filing_submitted_to_agency` BIGINT COMMENT 'FK to compliance.regulatory_agency.regulatory_agency_id — Every regulatory filing is submitted to a specific regulatory agency. This is a fundamental FK for filtering and reporting filings by agency.',
    `filing_type` STRING COMMENT 'The category of regulatory filing, indicating the nature and purpose of the submission. [ENUM-REF-CANDIDATE: FERC_Form_1|FERC_EQR|FERC_Form_552|FERC_Market_Based_Rate|NERC_Audit_Submission|PUC_Rate_Case|PUC_Transmission_Rate_Case|CPCN_Application|IRP_Filing|EPA_Emissions_Report|RPS_Compliance_Filing|Self_Reported_Violation|FERC_Voluntary_Disclosure|EPA_Self_Disclosure|NERC_SPV|PUC_General_Rate_Case|FERC_Tariff_Filing|State_Environmental_Permit|OSHA_Incident_Report — promote to reference product]',
    `intervenor_party_count` STRING COMMENT 'For contested proceedings, the number of third-party intervenors (e.g., consumer advocates, industrial customers, competing utilities) who have formally intervened in the regulatory proceeding.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this regulatory filing record was last updated or modified.',
    `proposed_rate_change_percent` DECIMAL(18,2) COMMENT 'For rate case filings, the percentage increase or decrease in customer rates being proposed in this filing.',
    `public_hearing_date` DATE COMMENT 'The scheduled date of the public or evidentiary hearing for this filing, if applicable.',
    `public_hearing_scheduled_flag` BOOLEAN COMMENT 'Indicates whether a public hearing or evidentiary hearing has been scheduled by the regulatory agency for this filing (True/False).',
    `rate_case_test_year` STRING COMMENT 'For rate case filings, the historical or forecasted 12-month period used as the basis for determining revenue requirements and proposed rates.',
    `regulatory_agency` STRING COMMENT 'The governing body or regulatory authority to which this filing is submitted (e.g., FERC, NERC, EPA, State Public Utility Commission).. Valid values are `FERC|NERC|EPA|State_PUC|DOE|OSHA`',
    `rejection_date` DATE COMMENT 'The date on which the regulatory agency rejected the filing, if applicable.',
    `rejection_reason` STRING COMMENT 'The explanation provided by the regulatory agency for rejecting the filing, including deficiencies or non-compliance issues identified.',
    `responsible_preparer_email` STRING COMMENT 'The email address of the individual responsible for this filing, used for regulatory correspondence and internal coordination.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `responsible_preparer_name` STRING COMMENT 'The name of the individual or team responsible for preparing and submitting this regulatory filing.',
    `revenue_requirement_amount` DECIMAL(18,2) COMMENT 'For rate case filings, the total annual revenue requirement requested from ratepayers to recover costs and earn authorized return on equity (ROE). Expressed in USD.',
    `rps_compliance_year` STRING COMMENT 'For RPS compliance filings, the calendar year for which renewable energy procurement and Renewable Energy Certificate (REC) retirement is being reported.',
    `rps_rec_retired_count` STRING COMMENT 'For RPS compliance filings, the total number of Renewable Energy Certificates (RECs) retired to demonstrate compliance with state RPS mandates.',
    `rps_renewable_energy_mwh` DECIMAL(18,2) COMMENT 'For RPS compliance filings, the total megawatt-hours (MWh) of renewable energy procured or generated to meet RPS obligations.',
    `settlement_date` DATE COMMENT 'The date on which a settlement agreement was executed or approved by the regulatory agency, if applicable.',
    `settlement_status` STRING COMMENT 'For contested proceedings, indicates whether a settlement agreement has been reached among parties and its current approval status.. Valid values are `No_Settlement|Settlement_Proposed|Settlement_Approved|Settlement_Rejected`',
    `spv_discovery_date` DATE COMMENT 'For self-reported potential violations, the date on which the utility first discovered or became aware of the potential compliance violation.',
    `spv_mitigation_plan` STRING COMMENT 'For self-reported potential violations, a description of the corrective actions and mitigation measures implemented or planned to address the violation and prevent recurrence.',
    `spv_violation_description` STRING COMMENT 'For self-reported potential violations (SPVs) or voluntary disclosures, a detailed description of the compliance issue, standard violated, and circumstances of the violation.',
    `submission_date` DATE COMMENT 'The date on which the filing was officially submitted to the regulatory agency. This is the principal business event timestamp for the filing.',
    CONSTRAINT pk_regulatory_filing PRIMARY KEY(`regulatory_filing_id`)
) COMMENT 'Transactional record of every formal submission made to a regulatory body, encompassing routine periodic filings, regulatory proceeding applications, market transaction reports, proactive self-disclosures, rate case proceedings, and long-term resource planning filings. Covers FERC Form 1, FERC EQR, FERC Form 552, FERC market-based rate tariff filings, NERC reliability standard audit submissions, PUC general and transmission rate case filings (including test year, revenue requirement, proposed rate changes, intervenor parties, procedural milestones, settlement status, and commission orders), CPCN applications for major capital projects (including project description, capital cost, environmental review, and certificate conditions), IRP filings (including planning horizon, load forecast, resource scenarios, and commission approval), EPA emissions reports, RPS compliance filings, self-reported potential violations (SPVs), FERC voluntary disclosures, and EPA self-disclosure submissions. Captures filing type, docket number, regulatory agency, submission date, filing period, filing status, responsible preparer, and filing-type-specific detail attributes. SSOT for all outbound regulatory submissions, regulatory proceeding lifecycle tracking, proactive disclosure management, rate case management, and resource planning filings.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`compliance`.`audit` (
    `audit_id` BIGINT COMMENT 'Unique identifier for the compliance audit record. Primary key for the audit entity.',
    `der_system_id` BIGINT COMMENT 'Foreign key linking to interconnection.der_system. Business justification: Compliance audits inspect DER installations for IEEE 1547, UL 1741, NEC adherence. Auditors verify specific systems protection settings, anti-islanding, metering configuration. Audit scope often targ',
    `obligation_id` BIGINT COMMENT 'FK to compliance.obligation.obligation_id — Audits examine compliance with specific obligations or sets of obligations. Linking audit to obligation enables obligation-level audit coverage tracking.',
    `power_plant_id` BIGINT COMMENT 'Foreign key linking to generation.power_plant. Business justification: Compliance audits (NERC, EPA, state PUC) are conducted at specific power plant facilities. Auditors need to link audit records to the power plant for facility-specific audit scheduling, findings track',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.program. Business justification: An audit is conducted within the scope of a compliance program (e.g., NERC CIP Compliance Program). Many audits can be conducted for one program (1:N). Adding program_id FK links the audit to its gove',
    `actual_end_date` DATE COMMENT 'Actual date the audit concluded, recorded when field work is complete or final report is issued. May differ from scheduled end date due to scope changes or findings requiring additional investigation.',
    `actual_start_date` DATE COMMENT 'Actual date the audit commenced, recorded when audit activities begin. May differ from scheduled start date due to delays or rescheduling.',
    `audit_number` STRING COMMENT 'Externally-known unique business identifier for the audit, typically assigned by the auditing body or internal compliance system. Format varies by audit type (e.g., NERC-2024-001234, FERC-2024-5678, PUC-2024-9012).. Valid values are `^[A-Z]{2,6}-[0-9]{4}-[0-9]{4,6}$`',
    `audit_scope` STRING COMMENT 'Detailed description of the audit scope including specific standards, facilities, systems, processes, or business units under examination. For NERC CIP audits, lists applicable CIP standards (e.g., CIP-002 through CIP-014). For FERC audits, describes market activities or transactions. For PUC audits, identifies service territories or customer classes.',
    `audit_status` STRING COMMENT 'Current lifecycle status of the audit. Scheduled indicates audit is planned but not started, In Progress indicates active audit activities, Field Work Complete indicates on-site work finished awaiting report, Draft Report indicates preliminary findings issued, Final Report Issued indicates official audit report delivered, Closed indicates all follow-up complete, Suspended indicates audit paused or cancelled. [ENUM-REF-CANDIDATE: Scheduled|In_Progress|Field_Work_Complete|Draft_Report|Final_Report_Issued|Closed|Suspended — 7 candidates stripped; promote to reference product]',
    `audit_type` STRING COMMENT 'Classification of the audit based on regulatory framework and scope. NERC CIP covers Critical Infrastructure Protection reliability audits, FERC Market Behavior covers wholesale market conduct, PUC Service Quality covers retail service standards, SOX Internal Controls covers financial reporting controls, EPA Environmental covers emissions and environmental compliance, Internal Compliance covers self-assessments and internal audits.. Valid values are `NERC_CIP|FERC_Market_Behavior|PUC_Service_Quality|SOX_Internal_Controls|EPA_Environmental|Internal_Compliance`',
    `auditing_body` STRING COMMENT 'Name of the organization or regulatory entity conducting the audit. Examples include NERC Regional Entities (e.g., WECC, SERC, ReliabilityFirst), FERC Office of Enforcement, State Public Utility Commission, EPA Regional Office, Internal Audit Department, or external audit firm.',
    `auditing_body_type` STRING COMMENT 'Classification of the auditing organization. Federal Regulator includes FERC and EPA, Regional Entity includes NERC Regional Entities, State Regulator includes PUCs, Internal covers internal audit and compliance teams, External Firm covers third-party audit firms.. Valid values are `Federal_Regulator|Regional_Entity|State_Regulator|Internal|External_Firm`',
    `business_units_audited` STRING COMMENT 'List or description of specific business units, departments, or functional areas included in the audit scope. Examples include Generation Operations, Transmission Operations, Distribution Operations, Customer Service, IT/Cybersecurity, Finance, Environmental Compliance.',
    `closure_date` DATE COMMENT 'Date the audit was officially closed by the auditing body, indicating all findings resolved, corrective actions verified complete, and no further audit activities required.',
    `confidentiality_level` STRING COMMENT 'Classification of the audit records confidentiality and disclosure restrictions. Public indicates no restrictions, CEII (Critical Energy Infrastructure Information) indicates FERC-protected infrastructure data, Confidential indicates business-sensitive information, Privileged indicates attorney-client or work product privilege.. Valid values are `Public|CEII|Confidential|Privileged`',
    `corrective_action_plan_approved_date` DATE COMMENT 'Date the auditing body formally approved the utility Corrective Action Plan, authorizing implementation and establishing completion milestones.',
    `corrective_action_plan_due_date` DATE COMMENT 'Deadline date by which the utility must submit a detailed Corrective Action Plan addressing all audit findings and violations.',
    `corrective_action_plan_submitted_date` DATE COMMENT 'Actual date the utility submitted its Corrective Action Plan to the auditing body.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit record was first created in the compliance management system.',
    `critical_findings_count` STRING COMMENT 'Number of critical or severe findings identified that pose significant risk to reliability, safety, or compliance and typically require immediate corrective action.',
    `disposition` STRING COMMENT 'Overall outcome or conclusion of the audit. Compliant indicates no violations found, Non Compliant Minor indicates low-risk violations with minimal impact, Non Compliant Moderate indicates medium-risk violations requiring corrective action, Non Compliant Severe indicates high-risk violations with potential penalties or enforcement actions, Pending Review indicates audit complete but final disposition not yet determined.. Valid values are `Compliant|Non_Compliant_Minor|Non_Compliant_Moderate|Non_Compliant_Severe|Pending_Review`',
    `draft_report_issued_date` DATE COMMENT 'Date the preliminary or draft audit report was issued to the utility for review and comment before final report publication.',
    `final_report_issued_date` DATE COMMENT 'Date the final official audit report was issued by the auditing body, incorporating utility responses and auditor conclusions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit record was most recently updated in the compliance management system.',
    `lead_auditor_email` STRING COMMENT 'Primary email address of the lead auditor for official audit correspondence and evidence submission.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `lead_auditor_name` STRING COMMENT 'Full name of the lead auditor from the auditing body responsible for directing the audit, coordinating the audit team, and signing the final audit report.',
    `lead_auditor_phone` STRING COMMENT 'Primary contact phone number for the lead auditor.',
    `methodology` STRING COMMENT 'Primary methodology used to conduct the audit. On Site indicates auditors physically present at utility facilities, Remote indicates audit conducted via electronic document review and virtual meetings, Hybrid indicates combination of on-site and remote, Document Review indicates desk audit of submitted evidence, Spot Check indicates targeted sampling audit.. Valid values are `On_Site|Remote|Hybrid|Document_Review|Spot_Check`',
    `notes` STRING COMMENT 'Free-form text field for additional audit context, special circumstances, auditor observations, or internal comments not captured in structured fields.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Total monetary penalty assessed by the regulatory body for violations identified during the audit, expressed in US dollars. Zero if no penalty assessed.',
    `penalty_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the penalty amount. Typically USD for US-based utilities.. Valid values are `USD`',
    `period_end_date` DATE COMMENT 'Ending date of the time period under audit review. Represents the latest date for which records, transactions, and compliance evidence will be examined.',
    `period_start_date` DATE COMMENT 'Beginning date of the time period under audit review. Represents the earliest date for which records, transactions, and compliance evidence will be examined.',
    `priority` STRING COMMENT 'Priority level assigned to the audit based on risk assessment, regulatory mandate, or business criticality. Critical indicates highest priority requiring immediate attention, High indicates significant priority, Medium indicates standard priority, Low indicates routine or lower-risk audit.. Valid values are `Critical|High|Medium|Low`',
    `scheduled_end_date` DATE COMMENT 'Planned date for the audit to conclude, typically the expected date for completion of field work or final report issuance.',
    `scheduled_start_date` DATE COMMENT 'Planned date for the audit to commence, typically the date of initial kickoff meeting or first day of on-site field work.',
    `total_findings_count` STRING COMMENT 'Total number of audit findings, observations, or violations identified during the audit across all severity levels.',
    `trigger` STRING COMMENT 'Event or circumstance that initiated the audit. Scheduled Routine indicates planned periodic audit per compliance calendar, Risk Based indicates audit triggered by risk assessment, Incident Driven indicates audit following a reliability event or outage, Complaint Driven indicates audit initiated by customer or stakeholder complaint, Follow Up indicates audit to verify prior corrective actions, Self Report indicates audit following utility self-reported violation.. Valid values are `Scheduled_Routine|Risk_Based|Incident_Driven|Complaint_Driven|Follow_Up|Self_Report`',
    `utility_response_due_date` DATE COMMENT 'Deadline date by which the utility must submit formal written response to draft audit findings, including mitigation plans and corrective actions.',
    `utility_response_submitted_date` DATE COMMENT 'Actual date the utility submitted its formal written response to audit findings.',
    CONSTRAINT pk_audit PRIMARY KEY(`audit_id`)
) COMMENT 'Master record for each compliance audit conducted or received, covering NERC CIP reliability audits, FERC market behavior audits, PUC service quality audits, internal SOX control audits, and EPA environmental inspections. Captures audit type, auditing body, audit scope, audit period, lead auditor, utility audit coordinator, scheduled and actual dates, and overall audit disposition. Parent entity for all audit findings and evidence submissions.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` (
    `audit_finding_id` BIGINT COMMENT 'Unique identifier for the audit finding record. Primary key for the audit finding entity.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Billing accuracy audits, meter-to-cash process audits, and revenue assurance findings reference specific customer accounts. Required for audit evidence trails and corrective billing adjustments per re',
    `der_system_id` BIGINT COMMENT 'Foreign key linking to interconnection.der_system. Business justification: Audit findings cite specific DER systems for non-compliance (improper settings, missing labels, unauthorized modifications). Remediation tracking requires linking findings to the physical system. Crit',
    `generating_unit_id` BIGINT COMMENT 'Foreign key linking to generation.generating_unit. Business justification: Audit findings are frequently specific to individual generating units (NERC GADS data quality findings, CEMS monitoring deficiencies, unit-specific permit violations). Compliance staff must link findi',
    `nerc_cip_asset_id` BIGINT COMMENT 'Foreign key linking to compliance.nerc_cip_asset. Business justification: Audit findings in NERC CIP audits are about specific cyber assets. The audit_finding table has affected_assets (STRING) which is a denormalized reference to the assets involved. Direct FK to nerc_cip_',
    `premise_id` BIGINT COMMENT 'Foreign key linking to customer.premise. Business justification: Service quality audits (voltage compliance, outage duration, safety inspections) and interconnection compliance findings reference specific premises. Essential for tracking site-specific violations an',
    `audit_id` BIGINT COMMENT 'Reference to the parent audit engagement or assessment that originated this finding. Null if the finding was discovered through internal monitoring, self-assessment, or employee report rather than a formal audit.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: An audit finding represents a violation of a specific regulatory obligation. Many findings can relate to one obligation (1:N). Adding obligation_id FK links the finding to the specific obligation viol',
    `actual_penalty_amount` DECIMAL(18,2) COMMENT 'The final financial penalty amount in USD imposed by the regulatory body for this finding. Null until penalty is assessed and finalized. Confidential for financial reporting.',
    `affected_customers_count` STRING COMMENT 'The number of customers impacted by the finding, if applicable. Relevant for service quality findings, billing errors, or outage-related compliance issues. Null if finding does not directly impact customers.',
    `auditor_name` STRING COMMENT 'Name of the external auditor, regulatory inspector, or internal audit team member who identified the finding. Null if finding was discovered through self-monitoring or employee report. Confidential for internal use.',
    `business_unit` STRING COMMENT 'The business unit, department, or operational division responsible for the process or control that failed, and accountable for remediation. Examples: Transmission Operations, Distribution Engineering, Customer Service, Finance, IT Security.',
    `closed_by` STRING COMMENT 'Name or identifier of the individual who formally closed the finding after verification. Typically a compliance officer or audit manager. Confidential for internal use.',
    `closed_date` DATE COMMENT 'The date on which the finding was formally closed after successful remediation and verification. Null until finding is closed.',
    `closure_notes` STRING COMMENT 'Final notes or comments documenting the closure of the finding, including verification results, lessons learned, and any residual risks or follow-up actions. Used for knowledge management and continuous improvement.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this finding record was first created in the compliance management system. Audit trail field for record lifecycle tracking.',
    `discovery_date` DATE COMMENT 'The date on which the compliance deficiency, exception, gap, or near-miss was first identified or observed. This is the principal business event timestamp for the finding.',
    `discovery_method` STRING COMMENT 'The channel or mechanism through which the finding was identified. Distinguishes between externally-originated findings (NERC audits, FERC inspections) and internally-discovered exceptions (self-assessments, control testing, proactive monitoring). [ENUM-REF-CANDIDATE: external_audit|internal_audit|self_monitoring|control_testing|employee_report|operational_review|regulatory_inspection|third_party_assessment — 8 candidates stripped; promote to reference product]',
    `escalation_status` STRING COMMENT 'Indicates whether and to whom the finding has been escalated. Tracks escalation to senior management, Board of Directors, or external regulators. Self-reported status indicates proactive disclosure to regulatory body per NERC self-reporting requirements.. Valid values are `not_escalated|escalated_to_management|escalated_to_board|escalated_to_regulator|self_reported`',
    `evidence_location` STRING COMMENT 'File path, document repository location, or system reference where supporting evidence and documentation for this finding is stored. Used for audit trail and regulatory response preparation. Confidential for internal use.',
    `finding_description` STRING COMMENT 'Detailed narrative description of the compliance deficiency, exception, gap, or near-miss. Includes what was observed, what requirement was not met, and the specific circumstances of the finding. Used for audit documentation and regulatory correspondence.',
    `finding_reference_number` STRING COMMENT 'Business-facing unique reference number or tracking code assigned to this finding for external reporting and correspondence. Format varies by regulatory body (e.g., NERC PV-2024-001234, FERC-AUDIT-2024-XYZ-F01).',
    `finding_status` STRING COMMENT 'Current lifecycle status of the finding in the remediation workflow. Tracks progression from discovery through closure.. Valid values are `open|under_review|remediation_in_progress|pending_verification|closed|escalated`',
    `finding_type` STRING COMMENT 'Classification of the finding based on its nature and confirmation status. Potential violations (PVs) are unconfirmed pending investigation; confirmed violations have been substantiated; control deficiencies relate to SOX or internal controls; near-misses are proactive identifications before harm occurred. [ENUM-REF-CANDIDATE: potential_violation|confirmed_violation|control_deficiency|process_gap|documentation_deficiency|near_miss|repeat_finding — 7 candidates stripped; promote to reference product]',
    `impact_assessment` STRING COMMENT 'Narrative assessment of the actual or potential impact of the finding on grid reliability, customer service, financial reporting, environmental compliance, or other business objectives. Used for risk prioritization and Board reporting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this finding record was last updated or modified. Audit trail field for change tracking and data lineage.',
    `penalty_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for penalty amounts. Defaulted to USD for US-based energy utilities.. Valid values are `USD`',
    `potential_penalty_amount` DECIMAL(18,2) COMMENT 'Estimated or assessed financial penalty amount in USD that may be imposed by the regulatory body for this finding. Based on NERC penalty guidelines, FERC enforcement precedent, or PUC fine schedules. Confidential for internal risk assessment.',
    `previous_finding_reference` STRING COMMENT 'Reference number or identifier of the previous finding that this finding repeats or relates to. Null if not a repeat finding.',
    `remediation_completion_date` DATE COMMENT 'The actual date on which all corrective actions were completed and the finding was remediated. Null until remediation is complete.',
    `remediation_due_date` DATE COMMENT 'The target or mandated date by which the finding must be fully remediated and closed. May be set by regulatory body (for audit findings) or by internal compliance team (for self-identified findings).',
    `remediation_plan` STRING COMMENT 'Detailed description of the corrective action plan to address the finding, including specific steps, milestones, resources, and controls to be implemented. Required for NERC Mitigation Plans and FERC enforcement responses.',
    `remediation_status` STRING COMMENT 'Current status of the remediation effort. Tracks progress of corrective actions from planning through verification and closure.. Valid values are `not_started|in_progress|completed|verified|overdue`',
    `repeat_finding_flag` BOOLEAN COMMENT 'Boolean indicator of whether this finding is a repeat or recurrence of a previously identified and closed finding for the same or similar deficiency. Repeat findings carry higher regulatory scrutiny and potential penalties.',
    `risk_severity` STRING COMMENT 'Internal enterprise risk assessment of the finding based on likelihood and impact to business operations, financial performance, or regulatory standing. Distinct from regulatory severity classification; used for internal prioritization and resource allocation.. Valid values are `critical|high|medium|low`',
    `root_cause_analysis` STRING COMMENT 'Detailed root cause analysis narrative explaining why the finding occurred, including contributing factors, systemic issues, and causal chain. Required for NERC self-reports and FERC enforcement responses.',
    `root_cause_category` STRING COMMENT 'High-level categorization of the underlying root cause of the finding. Used for trend analysis and systemic issue identification across the compliance program. [ENUM-REF-CANDIDATE: process_failure|human_error|system_failure|inadequate_training|resource_constraint|design_flaw|communication_breakdown|third_party_failure|policy_gap|other — 10 candidates stripped; promote to reference product]',
    `self_report_date` DATE COMMENT 'The date on which the finding was self-reported to the regulatory body. Null if not yet reported or if self-report is not required.',
    `self_report_reference_number` STRING COMMENT 'The reference number or tracking identifier assigned by the regulatory body upon receipt of the self-report. Used for correspondence and enforcement tracking.',
    `self_report_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether this finding meets the criteria for mandatory self-reporting to the regulatory body (e.g., NERC self-report for potential CIP violations, FERC notification for market rule violations). True if self-report is required or recommended.',
    `severity_classification` STRING COMMENT 'Regulatory or internal severity rating of the finding based on potential impact to grid reliability, customer service, financial reporting integrity, or environmental compliance. Aligns with NERC Violation Severity Levels (VSL) for CIP findings and internal risk rating frameworks for other findings.. Valid values are `critical|high|moderate|low|minimal`',
    `verification_date` DATE COMMENT 'The date on which the remediation was independently verified and validated as effective by internal audit, compliance team, or external auditor. Required before finding can be closed.',
    `verified_by` STRING COMMENT 'Name or identifier of the individual or team that performed the verification and validation of remediation effectiveness. Confidential for internal use.',
    CONSTRAINT pk_audit_finding PRIMARY KEY(`audit_finding_id`)
) COMMENT 'Individual compliance deficiency, exception, gap, or near-miss record identified through formal audit, internal monitoring, control testing, self-assessment, or operational review. Covers NERC CIP potential violations (PVs), FERC market rule violations, PUC service quality deficiencies, SOX control deficiencies, internally discovered compliance exceptions, and proactive near-miss identifications. Captures finding reference number, associated audit (if audit-originated), violated standard or rule citation, severity classification, discovery method (external audit, internal audit, self-monitoring, employee report, control testing), finding description, root cause category, risk severity, business unit responsible, remediation due date, and escalation status (including whether self-reporting is warranted). Serves as the single register for all compliance deficiencies regardless of discovery channel — from formal audit findings to internally identified exceptions. Drives the enforcement and corrective action workflow, and feeds the self-report filing process when internal findings warrant proactive disclosure.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` (
    `enforcement_action_id` BIGINT COMMENT 'Unique identifier for the regulatory enforcement action record. Primary key.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.audit. Business justification: An enforcement action may be triggered by an audit that discovered violations. Many enforcement actions can result from one audit (1:N). Adding audit_id FK links the enforcement action to the triggeri',
    `corrective_action_plan_id` BIGINT COMMENT 'Identifier of the corrective action plan or mitigation plan submitted to the regulator to address the violation and prevent recurrence.',
    `audit_finding_id` BIGINT COMMENT 'FK to compliance.audit_finding.audit_finding_id — Enforcement actions arise from audit findings or self-reported violations. Links the enforcement lifecycle to the originating deficiency. Critical for penalty tracking and Board reporting.',
    `application_id` BIGINT COMMENT 'Foreign key linking to interconnection.application. Business justification: Enforcement actions arise from interconnection violations: unauthorized parallel operation before PTO, failure to meet study milestones, non-payment of fees. Penalties and mitigation plans reference t',
    `primary_enforcement_audit_finding_id` BIGINT COMMENT 'FK to compliance.audit_finding.audit_finding_id — Enforcement actions often originate from audit findings that escalate. The enforcement_action should reference the originating finding when applicable.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Enforcement actions often require or result in formal regulatory filings (e.g., SPV filings, settlement agreement filings, penalty payment filings). The enforcement_action table has regulatory_corresp',
    `action_issue_date` DATE COMMENT 'Date on which the regulatory agency formally issued or filed the enforcement action notice or order.',
    `action_number` STRING COMMENT 'Externally-known docket, case, or reference number assigned by the regulatory agency (e.g., NERC NAV number, FERC docket number, PUC case number, EPA NOV number, OSHA citation number).',
    `action_resolution_date` DATE COMMENT 'Date on which the enforcement action was formally resolved, closed, or finalized (e.g., settlement execution date, final order date, dismissal date).',
    `action_status` STRING COMMENT 'Current lifecycle status of the enforcement action (e.g., pending, contested, settled, final, closed, appealed, dismissed). [ENUM-REF-CANDIDATE: pending|contested|settled|final|closed|appealed|dismissed — 7 candidates stripped; promote to reference product]',
    `action_type` STRING COMMENT 'Classification of the enforcement action instrument issued by the regulator (e.g., NERC Notice of Alleged Violation (NAV), FERC Order to Show Cause, PUC complaint proceeding, EPA Notice of Violation (NOV), OSHA citation). [ENUM-REF-CANDIDATE: notice_of_alleged_violation|notice_of_violation|order_to_show_cause|complaint_proceeding|administrative_penalty|civil_penalty|citation|warning_letter|consent_order — 9 candidates stripped; promote to reference product]',
    `alleged_violation_description` STRING COMMENT 'Detailed narrative description of the alleged violation or non-compliance that triggered the enforcement action, including specific regulatory standard or requirement violated.',
    `appeal_decision_date` DATE COMMENT 'Date on which the appellate body issued its decision on the appeal of the enforcement action.',
    `appeal_filed_flag` BOOLEAN COMMENT 'Boolean indicator of whether the utility filed a formal appeal of the enforcement action decision (True = appeal filed, False = no appeal).',
    `audit_trail_reference` STRING COMMENT 'Reference identifier to the audit trail, evidence collection, or compliance documentation supporting the enforcement action response and defense.',
    `board_notification_flag` BOOLEAN COMMENT 'Boolean indicator of whether the enforcement action was reported to the Board of Directors due to materiality or significance (True = notified, False = not notified).',
    `contested_flag` BOOLEAN COMMENT 'Boolean indicator of whether the utility is contesting or has contested the enforcement action through formal proceedings or appeal (True = contested, False = not contested).',
    `cooperation_credit_flag` BOOLEAN COMMENT 'Boolean indicator of whether the utility received penalty mitigation credit for cooperating with the regulatory investigation (True = credit received, False = no credit).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this enforcement action record was first created in the system.',
    `enforcement_by_agency` BIGINT COMMENT 'FK to compliance.regulatory_agency.regulatory_agency_id — Enforcement actions are issued by specific regulatory agencies. This FK is essential for agency-level enforcement tracking and reporting.',
    `external_disclosure_flag` BOOLEAN COMMENT 'Boolean indicator of whether the enforcement action was disclosed in external financial reporting or regulatory filings (e.g., SEC Form 10-K, 10-Q) due to materiality (True = disclosed, False = not disclosed).',
    `final_penalty_assessed` DECIMAL(18,2) COMMENT 'Final monetary penalty amount assessed after any settlement negotiations, mitigation, or adjudication, expressed in USD.',
    `financial_exposure_classification` STRING COMMENT 'Internal classification of the financial materiality and exposure risk of the enforcement action based on penalty amount and potential impact (e.g., low, medium, high, critical).. Valid values are `low|medium|high|critical`',
    `issuing_agency` STRING COMMENT 'Name of the regulatory body or agency that initiated the enforcement action (e.g., NERC, FERC, State PUC, EPA, OSHA).',
    `issuing_agency_code` STRING COMMENT 'Standardized code or abbreviation for the issuing regulatory agency (e.g., NERC, FERC, EPA, OSHA, state PUC abbreviation).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this enforcement action record was last updated or modified.',
    `mitigation_factors_applied` STRING COMMENT 'Description of mitigating factors considered by the regulator in determining the final penalty, such as compliance history, self-reporting credit, cooperation with investigation, remedial actions taken, or financial condition.',
    `payment_date` DATE COMMENT 'Actual date on which the penalty payment was remitted to the regulatory agency.',
    `payment_due_date` DATE COMMENT 'Date by which the assessed penalty payment must be remitted to the regulatory agency.',
    `payment_status` STRING COMMENT 'Current status of the penalty payment obligation (e.g., not due, pending, paid, overdue, waived, deferred).. Valid values are `not_due|pending|paid|overdue|waived|deferred`',
    `penalty_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for penalty amounts. Defaults to USD for US utility operations.. Valid values are `USD`',
    `proposed_penalty_amount` DECIMAL(18,2) COMMENT 'Initial monetary penalty amount proposed by the regulatory agency in the enforcement action notice, expressed in USD.',
    `public_disclosure_url` STRING COMMENT 'URL link to the public disclosure or posting of the enforcement action on the regulatory agencys website (e.g., NERC public enforcement actions, FERC eLibrary).',
    `record_source_system` STRING COMMENT 'Name or code of the source system from which this enforcement action record originated (e.g., Compliance Management System, Legal Case Management System).',
    `regulatory_correspondence_reference` STRING COMMENT 'Reference identifier or file path to official correspondence, letters, or filings exchanged with the regulatory agency regarding this enforcement action.',
    `responsible_facility_code` STRING COMMENT 'Code or identifier of the specific facility, plant, substation, or asset where the alleged violation occurred.',
    `self_report_credit_flag` BOOLEAN COMMENT 'Boolean indicator of whether the utility received penalty mitigation credit for self-reporting the violation to the regulator (True = credit received, False = no credit).',
    `settlement_flag` BOOLEAN COMMENT 'Boolean indicator of whether the enforcement action was resolved through a settlement agreement between the utility and the regulatory agency (True = settled, False = not settled).',
    `settlement_terms` STRING COMMENT 'Summary of key terms and conditions agreed upon in the settlement, including penalty reduction, compliance commitments, and remedial actions.',
    `violated_standard_code` STRING COMMENT 'Code or identifier of the specific regulatory standard, rule, or requirement that was allegedly violated (e.g., NERC CIP-007-6, FERC Order 888, EPA 40 CFR Part 60, OSHA 29 CFR 1910).',
    `violation_end_date` DATE COMMENT 'End date of the period during which the alleged violation occurred or non-compliance was remediated.',
    `violation_severity_level` STRING COMMENT 'Severity classification of the alleged violation as determined by the regulator (e.g., NERC Violation Severity Level: minimal, lower, moderate, high, severe).. Valid values are `minimal|lower|moderate|high|severe`',
    `violation_start_date` DATE COMMENT 'Start date of the period during which the alleged violation occurred or non-compliance existed.',
    CONSTRAINT pk_enforcement_action PRIMARY KEY(`enforcement_action_id`)
) COMMENT 'Record of formal enforcement actions, associated monetary penalties, and sanctions initiated by regulators against the utility, including NERC Notice of Alleged Violation (NAV) with civil monetary penalties (CMPs), FERC Order to Show Cause with civil penalties, PUC complaint proceedings with fines, EPA Notice of Violation (NOV) with administrative penalties, and OSHA citations. Captures action type, issuing agency, docket or case number, alleged violation description, proposed penalty amount, final penalty assessed, payment due date, payment status, penalty mitigation factors applied (compliance history, self-reporting credit, cooperation), contested flag, settlement terms, action resolution date, and financial exposure classification. Serves as SSOT for all regulatory enforcement posture, penalty assessment and tracking, financial exposure reporting to the Board and external auditors, and penalty payment reconciliation.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`compliance`.`corrective_action_plan` (
    `corrective_action_plan_id` BIGINT COMMENT 'Unique identifier for the corrective action plan. Primary key.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.audit. Business justification: A Corrective Action Plan is frequently triggered directly by an audit (not only by individual findings). The audit table tracks CAP dates (corrective_action_plan_approved_date, corrective_action_plan_',
    `audit_finding_id` BIGINT COMMENT 'FK to compliance.audit_finding.audit_finding_id — Corrective action plans are created in response to audit findings. The CAP must reference the specific finding it remediates. This is the core remediation workflow link.',
    `der_system_id` BIGINT COMMENT 'Foreign key linking to interconnection.der_system. Business justification: CAPs remediate DER-specific violations (relay reconfiguration, inverter firmware updates, metering corrections). Implementation and verification require identifying the physical system. Critical for c',
    `generating_unit_id` BIGINT COMMENT 'Foreign key linking to generation.generating_unit. Business justification: Corrective action plans are frequently written for specific generating units (emissions exceedance CAP for Unit 2, NERC reliability CAP for a specific units protection system). Operations and complia',
    `primary_corrective_audit_finding_id` BIGINT COMMENT 'Reference to the audit finding, enforcement action, or self-identified compliance gap that triggered this corrective action plan.',
    `regulatory_correspondence_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_correspondence. Business justification: CAP submissions and approvals are communicated via formal regulatory correspondence. The corrective_action_plan table has regulatory_correspondence_reference (STRING) which is a denormalized reference',
    `actual_completion_date` DATE COMMENT 'The actual date on which all corrective actions were completed and verified.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual total cost in USD incurred to implement the corrective action plan, tracked for financial reporting and cost recovery analysis.',
    `actual_start_date` DATE COMMENT 'The actual date on which implementation of the corrective action plan commenced.',
    `approval_date` DATE COMMENT 'The date on which the regulatory body formally approved the corrective action plan.',
    `board_reporting_flag` BOOLEAN COMMENT 'Indicates whether this corrective action plan is included in Board-level compliance posture reporting due to its materiality or risk level.',
    `cap_number` STRING COMMENT 'Business identifier for the corrective action plan, typically formatted as CAP-YYYY-NNNN or similar convention used in regulatory correspondence.',
    `cap_status` STRING COMMENT 'Current lifecycle status of the corrective action plan indicating its stage in the remediation workflow. [ENUM-REF-CANDIDATE: Draft|Submitted|Under Review|Approved|In Progress|Completed|Closed|Rejected|Overdue — 9 candidates stripped; promote to reference product]',
    `cap_title` STRING COMMENT 'Short descriptive title of the corrective action plan summarizing the remediation focus.',
    `closure_date` DATE COMMENT 'The date on which the corrective action plan was formally closed after verification of completion and acceptance by the regulatory body.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of corrective action plan milestones and tasks completed, used for progress tracking and Board reporting.',
    `corrective_measures` STRING COMMENT 'Comprehensive description of the corrective actions, process changes, system enhancements, training programs, or policy updates committed to remediate the finding.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this corrective action plan record was first created in the system.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Estimated total cost in USD to implement the corrective action plan, including labor, materials, consulting, and system enhancements.',
    `evidence_of_completion` STRING COMMENT 'Description or reference to documentation, test results, audit reports, training records, or other evidence demonstrating successful completion of corrective actions.',
    `implementation_status` STRING COMMENT 'Current implementation progress status indicating whether the corrective action plan is on schedule, at risk, or delayed. [ENUM-REF-CANDIDATE: Not Started|In Progress|On Track|At Risk|Delayed|Completed|Verified — 7 candidates stripped; promote to reference product]',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this corrective action plan record was last modified, used for audit trail and change tracking.',
    `milestone_schedule` STRING COMMENT 'Structured schedule of key milestones, deliverables, and interim checkpoints with target dates for tracking progress of the corrective action plan.',
    `notes` STRING COMMENT 'Additional notes, comments, or context regarding the corrective action plan, including challenges, dependencies, or lessons learned.',
    `planned_completion_date` DATE COMMENT 'The target date by which all corrective actions are committed to be completed, as communicated to the regulatory body.',
    `planned_start_date` DATE COMMENT 'The date on which implementation of the corrective action plan is scheduled to begin.',
    `preventive_measures` STRING COMMENT 'Description of preventive measures implemented to ensure the compliance gap does not recur, including process controls, monitoring mechanisms, and governance enhancements.',
    `recurrence_flag` BOOLEAN COMMENT 'Indicates whether this corrective action plan addresses a recurring compliance issue that has been identified in previous audits or findings.',
    `regulatory_body` STRING COMMENT 'The regulatory authority to whom this corrective action plan is submitted or reported (NERC, FERC, PUC, EPA, etc.). [ENUM-REF-CANDIDATE: NERC|FERC|PUC|EPA|DOE|OSHA|State Commission|Other — 8 candidates stripped; promote to reference product]',
    `regulatory_standard` STRING COMMENT 'The specific regulatory standard, rule, or requirement that was violated or at risk (e.g., NERC CIP-007-6, FERC Order 2222, EPA Clean Air Act Section 111).',
    `root_cause_analysis` STRING COMMENT 'Detailed narrative describing the root cause analysis performed to identify the underlying factors that led to the compliance gap or violation.',
    `self_reported_flag` BOOLEAN COMMENT 'Indicates whether the compliance gap was self-identified and self-reported by the utility (True) or discovered through external audit or enforcement action (False).',
    `severity_level` STRING COMMENT 'Severity classification of the underlying finding or violation that this CAP addresses, reflecting risk to grid reliability, safety, or compliance posture.. Valid values are `Critical|High|Medium|Low`',
    `submission_date` DATE COMMENT 'The date on which the corrective action plan was formally submitted to the regulatory body for review and approval.',
    `updated_by` STRING COMMENT 'The user ID or name of the individual who last updated this corrective action plan record.',
    `verification_date` DATE COMMENT 'The date on which completion of the corrective action plan was independently verified.',
    `verification_method` STRING COMMENT 'The method used to verify completion of corrective actions (e.g., internal audit, third-party assessment, regulatory inspection, system testing).',
    `verified_by` STRING COMMENT 'Name or title of the individual or team that performed the verification of corrective action plan completion.',
    CONSTRAINT pk_corrective_action_plan PRIMARY KEY(`corrective_action_plan_id`)
) COMMENT 'Formal corrective action plan (CAP) developed in response to an audit finding, enforcement action, or self-identified compliance gap. Captures the associated finding or violation, root cause analysis narrative, corrective measures committed, milestone schedule, responsible owner, implementation status, and evidence of completion. Used to demonstrate remediation to NERC, FERC, PUC, and EPA. Tracks open CAPs for Board compliance posture reporting.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` (
    `evidence_record_id` BIGINT COMMENT 'Unique identifier for the compliance evidence record. Primary key.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Billing accuracy compliance evidence (rate application, tariff compliance, credit/collections practices) references specific customer accounts. Required for PUC audits and customer complaint investiga',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.audit. Business justification: Evidence records are collected to support specific audits (e.g., NERC CIP audit evidence packages). While evidence_record already links to audit_finding, evidence is often assembled at the audit level',
    `corrective_action_plan_id` BIGINT COMMENT 'Foreign key linking to compliance.corrective_action_plan. Business justification: Evidence records are collected to support corrective action plan closure and demonstrate remediation. Many evidence records can support one CAP (1:N). Adding corrective_action_plan_id FK links evidenc',
    `der_system_id` BIGINT COMMENT 'Foreign key linking to interconnection.der_system. Business justification: Evidence records document DER compliance: UL 1741 certifications, witness test reports, as-built drawings, protection relay settings. Auditors and regulators require system-specific evidence for inter',
    `enforcement_action_id` BIGINT COMMENT 'Foreign key linking to compliance.enforcement_action. Business justification: Evidence records are submitted in response to enforcement actions (e.g., penalty mitigation evidence, settlement documentation). Direct FK enables querying all evidence supporting a specific enforceme',
    `premise_id` BIGINT COMMENT 'Foreign key linking to customer.premise. Business justification: Service quality compliance evidence (meter test records, voltage monitoring data, interconnection inspections) references specific premises. Essential for demonstrating compliance with service standar',
    `audit_finding_id` BIGINT COMMENT 'FK to compliance.audit_finding.audit_finding_id — Evidence records are also collected in response to specific audit findings. This FK supports audit defense by linking evidence to the finding it addresses.',
    `obligation_id` BIGINT COMMENT 'FK to compliance.obligation.obligation_id — Evidence artifacts are collected to demonstrate compliance with specific obligations. This link is essential for audit preparation and compliance posture reporting.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Evidence records serve as supporting documentation for regulatory filings (e.g., FERC filings, EPA submissions). Direct FK links evidence artifacts to their associated formal filing. No bidirectional ',
    `tertiary_evidence_regulatory_obligation_id` BIGINT COMMENT 'Reference to the specific regulatory obligation or requirement that this evidence supports.',
    `access_restriction_notes` STRING COMMENT 'Free-text notes describing any special access restrictions, handling instructions, or security considerations for the evidence artifact.',
    `cap_closure_date` DATE COMMENT 'The date on which the corrective action plan (CAP) item or audit finding was formally closed based on this evidence. Nullable if CAP is not yet closed.',
    `cap_closure_flag` BOOLEAN COMMENT 'Boolean indicator of whether this evidence artifact was accepted as sufficient to close a corrective action plan (CAP) item or audit finding.',
    `chain_of_custody_status` STRING COMMENT 'Current status of the chain-of-custody for the evidence artifact. Indicates whether the evidence has maintained integrity and proper handling throughout its lifecycle.. Valid values are `intact|transferred|compromised|under_review`',
    `collection_date` DATE COMMENT 'The date on which the evidence artifact was collected, captured, or generated by the source system or custodian.',
    `compliance_standard_reference` STRING COMMENT 'Specific citation or reference to the compliance standard, regulation section, or control requirement that this evidence supports (e.g., NERC CIP-005-6 R1, SOX 404, EPA 40 CFR Part 75).',
    `confidentiality_classification` STRING COMMENT 'Data classification level of the evidence artifact indicating handling and access control requirements.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this evidence record was first created in the compliance management system.',
    `custodian_department` STRING COMMENT 'The organizational department or business unit of the custodian responsible for the evidence artifact.',
    `custodian_name` STRING COMMENT 'The full name of the custodian responsible for the evidence artifact. Maintained for audit trail and chain-of-custody purposes.',
    `digital_hash` STRING COMMENT 'Cryptographic hash (e.g., SHA-256) of the digital evidence artifact to ensure integrity verification and detect tampering. Critical for audit defense and regulatory examination.',
    `evidence_description` STRING COMMENT 'Detailed narrative description of the evidence artifact, including what it demonstrates, the context in which it was collected, and its relevance to the compliance obligation or audit finding.',
    `evidence_period_end_date` DATE COMMENT 'The ending date of the time period that this evidence artifact covers or represents. Nullable for ongoing or open-ended evidence.',
    `evidence_period_start_date` DATE COMMENT 'The beginning date of the time period that this evidence artifact covers or represents. For example, the start date of a log file or the effective date of a training certificate.',
    `evidence_status` STRING COMMENT 'Current lifecycle status of the evidence artifact in the compliance management process. Tracks progression from collection through validation to archival.. Valid values are `collected|under_review|validated|rejected|archived`',
    `evidence_title` STRING COMMENT 'Descriptive title or name of the evidence artifact for quick identification and cataloging.',
    `evidence_type` STRING COMMENT 'Classification of the evidence artifact by its nature and purpose. Examples include NERC CIP access control logs, protection system maintenance records, operator training certificates, FERC market transaction records, EPA stack test results, and SOX control test documentation.. Valid values are `access_control_log|maintenance_record|training_certificate|transaction_log|stack_test_result|control_test_documentation`',
    `file_format` STRING COMMENT 'The file format or media type of the evidence artifact (e.g., PDF, XLSX, CSV, DOCX, TXT, XML, JSON). [ENUM-REF-CANDIDATE: PDF|XLSX|CSV|DOCX|TXT|XML|JSON|PNG|JPEG|MP4|ZIP|MSG|EML — promote to reference product]',
    `file_size_bytes` BIGINT COMMENT 'The size of the evidence artifact file in bytes. Used for storage management and integrity verification.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this evidence record was last updated or modified in the compliance management system.',
    `legal_hold_case_reference` STRING COMMENT 'Reference to the legal case, investigation, or matter for which the evidence artifact is being preserved under legal hold. Nullable if no legal hold is active.',
    `legal_hold_flag` BOOLEAN COMMENT 'Boolean indicator of whether the evidence artifact is subject to a legal hold or litigation preservation order, preventing destruction regardless of retention policy.',
    `regulatory_framework` STRING COMMENT 'The primary regulatory framework or governing body under which this evidence is collected and maintained (e.g., NERC CIP, FERC, EPA, SOX, PUC, OSHA).. Valid values are `NERC_CIP|FERC|EPA|SOX|PUC|OSHA`',
    `rejection_reason` STRING COMMENT 'Explanation of why the evidence artifact was rejected or deemed insufficient. Nullable if evidence status is not rejected.',
    `retention_expiration_date` DATE COMMENT 'The calculated date on which the evidence artifact becomes eligible for destruction or archival per retention policy.',
    `retention_period_years` STRING COMMENT 'The number of years that the evidence artifact must be retained per regulatory or internal policy requirements before eligible for destruction.',
    `source_system` STRING COMMENT 'The operational system or application from which the evidence artifact was extracted or generated (e.g., SAP IS-U, OSIsoft PI, GE PowerOn ADMS, Oracle MDM).',
    `source_system_record_reference` STRING COMMENT 'The unique identifier or primary key of the evidence artifact in the source system from which it was extracted.',
    `storage_location_reference` STRING COMMENT 'Reference to the physical or digital storage location where the evidence artifact is maintained. May be a file path, document management system identifier, or physical archive location code.',
    `submission_date` DATE COMMENT 'The date on which the evidence artifact was formally submitted to auditors, regulators, or compliance management for review. Nullable if not yet submitted.',
    `submission_reference_number` STRING COMMENT 'The tracking or reference number assigned by the receiving organization or regulatory body upon submission of the evidence artifact.',
    `submitted_to_organization` STRING COMMENT 'The name of the external organization or regulatory body to which the evidence artifact was submitted (e.g., NERC, FERC, EPA, State PUC, external auditor firm).',
    `validation_date` DATE COMMENT 'The date on which the evidence artifact was reviewed and validated by compliance personnel or auditors as meeting the required standard.',
    `validation_notes` STRING COMMENT 'Free-text notes or comments recorded by the validator regarding the quality, completeness, or relevance of the evidence artifact.',
    CONSTRAINT pk_evidence_record PRIMARY KEY(`evidence_record_id`)
) COMMENT 'Repository of compliance evidence artifacts collected to demonstrate adherence to regulatory obligations and to address audit findings, including NERC CIP access control logs, protection system maintenance records, operator training certificates, FERC market transaction records, EPA stack test results, SOX control test documentation, and corrective action completion evidence. Captures evidence type, associated obligation or audit finding, collection date, evidence period covered, storage location reference, digital hash for integrity verification, custodian, and chain-of-custody status. Supports audit defense, regulatory examination, and CAP closure verification.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` (
    `regulatory_correspondence_id` BIGINT COMMENT 'Unique identifier for each regulatory correspondence record. Primary key for the regulatory correspondence entity.',
    `audit_id` BIGINT COMMENT 'Foreign key reference to a related regulatory audit or inspection record if the correspondence is part of an audit process.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Regulatory correspondence is frequently about specific compliance obligations (e.g., NERC information requests about specific CIP standards). The regulatory_correspondence table has compliance_obligat',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key reference to a related regulatory filing or submission if the correspondence is associated with a formal filing.',
    `rate_case_id` BIGINT COMMENT 'Foreign key linking to compliance.rate_case. Business justification: Regulatory correspondence can be part of a rate case proceeding (e.g., data requests, testimony, commission orders). Many correspondence records can relate to one rate case (1:N). The docket_number an',
    `agency_contact_email` STRING COMMENT 'Email address of the regulatory agency contact person for follow-up and correspondence tracking.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `agency_contact_name` STRING COMMENT 'Name of the regulatory agency representative or contact person who sent or is the recipient of the correspondence.',
    `agency_contact_phone` STRING COMMENT 'Phone number of the regulatory agency contact person.',
    `attachment_count` STRING COMMENT 'Number of attachments or supporting documents included with the correspondence.',
    `board_notification_date` DATE COMMENT 'Date the Board of Directors or executive leadership was notified of the correspondence. Format: yyyy-MM-dd.',
    `board_notification_flag` BOOLEAN COMMENT 'Indicates whether the correspondence is significant enough to require notification to the Board of Directors or executive leadership.',
    `closure_date` DATE COMMENT 'Date the correspondence matter was closed or resolved, indicating no further action is required. Format: yyyy-MM-dd.',
    `closure_notes` STRING COMMENT 'Notes documenting the resolution or closure of the correspondence matter, including any final actions taken or outcomes achieved.',
    `confidentiality_flag` BOOLEAN COMMENT 'Indicates whether the correspondence contains confidential, proprietary, or commercially sensitive information that requires special handling or redaction before public disclosure.',
    `correspondence_category` STRING COMMENT 'Categorical classification of the correspondence type. Examples include information request, data request, interrogatory, compliance schedule letter, audit notice, enforcement action, reporting acknowledgment, or general inquiry. [ENUM-REF-CANDIDATE: information_request|data_request|interrogatory|compliance_schedule|audit_notice|enforcement_action|reporting_acknowledgment|general_inquiry|notice_of_violation|settlement_agreement — promote to reference product]',
    `correspondence_number` STRING COMMENT 'Business identifier or reference number assigned to the correspondence by the utility or regulatory body. Used for tracking and citation in regulatory proceedings.',
    `correspondence_summary` STRING COMMENT 'Executive summary or abstract of the correspondence content for quick reference and reporting to senior management or the Board.',
    `correspondence_type` STRING COMMENT 'Indicates whether the correspondence is inbound (received from regulator) or outbound (sent to regulator).. Valid values are `inbound|outbound`',
    `correspondence_with_agency` BIGINT COMMENT 'FK to compliance.regulatory_agency.regulatory_agency_id — All regulatory correspondence is exchanged with a specific agency. Essential FK for correspondence management.',
    `created_by_user` STRING COMMENT 'Username or identifier of the system user who created the regulatory correspondence record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the regulatory correspondence record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `date_received` DATE COMMENT 'Date the correspondence was received by the utility (for inbound) or acknowledged by the regulator (for outbound). Format: yyyy-MM-dd.',
    `date_sent` DATE COMMENT 'Date the correspondence was sent (for outbound) or postmarked (for inbound). Format: yyyy-MM-dd.',
    `docket_number` STRING COMMENT 'Official docket number or proceeding reference assigned by the regulatory body. Used to link correspondence to specific regulatory cases, rate cases, or compliance proceedings.',
    `document_storage_location` STRING COMMENT 'File path, URL, or document management system reference where the physical or electronic correspondence document is stored.',
    `follow_up_due_date` DATE COMMENT 'Date by which follow-up action or supplemental response is due. Format: yyyy-MM-dd.',
    `follow_up_required_flag` BOOLEAN COMMENT 'Indicates whether additional follow-up action or supplemental response is required after the initial response.',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the system user who last modified the regulatory correspondence record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the regulatory correspondence record was last updated or modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `legal_review_completed_date` DATE COMMENT 'Date legal review of the correspondence or response was completed. Format: yyyy-MM-dd.',
    `legal_review_required_flag` BOOLEAN COMMENT 'Indicates whether the correspondence requires review by internal or external legal counsel before response.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty amount assessed or proposed in the correspondence if related to an enforcement action. Expressed in USD.',
    `priority_level` STRING COMMENT 'Priority level assigned to the correspondence based on urgency, regulatory impact, and potential enforcement risk. Critical priority indicates immediate action required.. Valid values are `critical|high|medium|low`',
    `proceeding_name` STRING COMMENT 'Name or title of the regulatory proceeding, case, or investigation to which this correspondence relates.',
    `regulatory_agency` STRING COMMENT 'The regulatory body or agency involved in the correspondence. Includes NERC (North American Electric Reliability Corporation), FERC (Federal Energy Regulatory Commission), PUC (Public Utility Commission), EPA (Environmental Protection Agency), DOE (Department of Energy), and OSHA (Occupational Safety and Health Administration).. Valid values are `NERC|FERC|PUC|EPA|DOE|OSHA`',
    `responding_department` STRING COMMENT 'Name of the internal department or business unit responsible for preparing the response. Examples include Legal, Regulatory Affairs, Compliance, Environmental, Operations, or Finance.',
    `response_acknowledgment_date` DATE COMMENT 'Date the regulatory agency acknowledged receipt of the utilitys response. Format: yyyy-MM-dd.',
    `response_due_date` DATE COMMENT 'Date by which a response is required or expected. Critical for tracking compliance with regulatory deadlines and avoiding enforcement actions. Format: yyyy-MM-dd.',
    `response_status` STRING COMMENT 'Current status of the response to the correspondence. Tracks whether a response is pending, in progress, completed, overdue, or not required.. Valid values are `pending|in_progress|completed|overdue|not_required`',
    `response_submitted_date` DATE COMMENT 'Date the utilitys response was submitted to the regulatory agency. Format: yyyy-MM-dd.',
    `subject_matter` STRING COMMENT 'Brief description of the subject matter or topic of the correspondence. Includes topics such as NERC CIP (Critical Infrastructure Protection) audits, FERC data requests, PUC rate case interrogatories, EPA emissions reporting, or DOE energy data submissions.',
    CONSTRAINT pk_regulatory_correspondence PRIMARY KEY(`regulatory_correspondence_id`)
) COMMENT 'Log of all formal written communications exchanged with regulatory bodies, including NERC information requests, FERC data requests, PUC interrogatories, EPA compliance schedule letters, and DOE reporting acknowledgments. Captures correspondence type (inbound/outbound), regulatory agency, docket or proceeding reference, subject matter, date sent or received, responding party, response due date, and response status. Ensures no regulatory communication falls through the cracks.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`compliance`.`nerc_cip_asset` (
    `nerc_cip_asset_id` BIGINT COMMENT 'Unique identifier for the NERC CIP asset record. Primary key for the asset registry subject to NERC CIP standards.',
    `bes_facility_id` BIGINT COMMENT 'Reference to the BES facility (substation, control center, generation plant) where this asset is located or to which it is logically associated.',
    `control_center_id` BIGINT COMMENT 'Reference to the control center (EMS, SCADA control room, DMS) responsible for operating or monitoring this asset.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Each NERC CIP asset is subject to specific CIP obligations (e.g., CIP-002 BES Cyber System Categorization, CIP-005 Electronic Security Perimeter). Many assets can be subject to one obligation (1:N). A',
    `registry_id` BIGINT COMMENT 'Reference to the physical or logical asset in the enterprise asset registry. Links this CIP-classified asset to the broader asset management system.',
    `asset_function` STRING COMMENT 'Operational function or role of the asset within the BES (e.g., real-time monitoring, automatic generation control, protective relaying, energy management).',
    `asset_identifier` STRING COMMENT 'Externally-known unique identifier or tag for the asset (e.g., serial number, asset tag, equipment ID). Used for audit and compliance tracking.',
    `asset_location` STRING COMMENT 'Physical or logical location of the asset (e.g., Substation 42, Control Center Building A, Data Center Rack 12). Organizational location data classified as confidential.',
    `asset_owner_organization` STRING COMMENT 'Business unit, division, or legal entity that owns this CIP asset. Used for accountability and audit trail.',
    `asset_type` STRING COMMENT 'Type or category of the asset (e.g., SCADA Server, EMS Workstation, Relay, RTU, Firewall, Router, Database Server).',
    `audit_trail_retention_days` STRING COMMENT 'Number of days audit logs and event records for this asset must be retained per CIP-007. Typically 90 calendar days minimum.',
    `bes_cyber_system_categorization` STRING COMMENT 'Classification of the asset within the NERC CIP framework: BES Cyber System, BES Cyber Asset, Electronic Access Point (EAP), Physical Access Control System, Protected Cyber Asset, or Non-BES Cyber System.. Valid values are `BES Cyber System|BES Cyber Asset|Electronic Access Point|Physical Access Control System|Protected Cyber Asset|Non-BES Cyber System`',
    `cip_impact_rating` STRING COMMENT 'Impact classification per NERC CIP-002: High, Medium, or Low. Determines the rigor of CIP standards applicable to this asset.. Valid values are `High|Medium|Low`',
    `cip_status` STRING COMMENT 'Current lifecycle status of the asset within the CIP compliance program: In Scope (subject to CIP standards), Out of Scope, Pending Assessment, Decommissioned, or Retired.. Valid values are `In Scope|Out of Scope|Pending Assessment|Decommissioned|Retired`',
    `cip_version` STRING COMMENT 'Version of the NERC CIP standard applicable to this asset (e.g., CIP-002-5.1a, CIP-005-6, CIP-007-6). Tracks which version of the standard governs compliance obligations.',
    `configuration_change_management_required` BOOLEAN COMMENT 'Indicates whether this asset is subject to CIP-010 Configuration Change Management and Configuration Monitoring requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this CIP asset record was first created in the registry. Used for audit trail and compliance documentation.',
    `decommission_date` DATE COMMENT 'Date the asset was decommissioned or removed from CIP scope. Used to track when CIP obligations cease.',
    `dial_up_connectivity` BOOLEAN COMMENT 'Indicates whether the asset has dial-up or modem connectivity, which requires specific CIP-005 access controls.',
    `external_connectivity` BOOLEAN COMMENT 'Indicates whether the asset has connectivity to networks outside the ESP, requiring additional CIP-005 controls.',
    `firmware_version` STRING COMMENT 'Current firmware or software version installed on the asset. Critical for CIP-007 patch management and vulnerability tracking.',
    `in_service_date` DATE COMMENT 'Date the asset was placed into operational service. Used to determine when CIP compliance obligations begin.',
    `ip_address` STRING COMMENT 'IP address assigned to the cyber asset. Required for Electronic Access Point (EAP) and ESP boundary documentation under CIP-005.',
    `last_cip_assessment_date` DATE COMMENT 'Date of the most recent CIP impact assessment or classification review for this asset, as required under CIP-002.',
    `last_patch_date` DATE COMMENT 'Date of the most recent security patch or software update applied to this asset. Required for CIP-007 patch management compliance.',
    `last_vulnerability_assessment_date` DATE COMMENT 'Date of the most recent vulnerability assessment performed on this asset, as required under CIP-007 and CIP-010.',
    `mac_address` STRING COMMENT 'MAC address of the network interface. Used for device identification and access control under CIP-005 and CIP-007.',
    `manufacturer` STRING COMMENT 'Manufacturer or vendor of the asset hardware or software (e.g., GE, Siemens, ABB, Cisco, OSIsoft).',
    `model_number` STRING COMMENT 'Model or part number of the asset. Used for vulnerability assessment and patch management under CIP-007.',
    `network_zone` STRING COMMENT 'Logical network zone or segment where the asset resides (e.g., Control Network, Corporate Network, DMZ). Used for ESP boundary definition.',
    `next_cip_assessment_due_date` DATE COMMENT 'Date by which the next CIP impact assessment or classification review must be completed. CIP-002 requires reassessment within 15 calendar months of the previous assessment.',
    `notes` STRING COMMENT 'Additional notes, comments, or context regarding the CIP classification, assessment, or compliance status of this asset.',
    `removable_media_controls_required` BOOLEAN COMMENT 'Indicates whether this asset requires CIP-011 removable media controls (USB drives, CDs, external hard drives).',
    `routable_protocol_enabled` BOOLEAN COMMENT 'Indicates whether the asset uses routable protocols (TCP/IP) that require Electronic Access Point (EAP) controls under CIP-005.',
    `transient_cyber_asset` BOOLEAN COMMENT 'Indicates whether this is a transient cyber asset (e.g., laptop, tablet, removable media) used for diagnostic testing, maintenance, or troubleshooting, subject to CIP-010 transient device controls.',
    `updated_by` STRING COMMENT 'User ID or name of the person who last updated this CIP asset record. Required for audit trail and accountability.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this CIP asset record was last modified. Required for audit trail and change tracking under CIP-010.',
    CONSTRAINT pk_nerc_cip_asset PRIMARY KEY(`nerc_cip_asset_id`)
) COMMENT 'Registry of utility assets subject to NERC CIP (Critical Infrastructure Protection) standards, including bulk electric system (BES) cyber systems, electronic access points (EAPs), electronic security perimeters (ESPs), physical security perimeters (PSPs), control centers, and high/medium/low impact BES cyber systems. Captures CIP impact classification per CIP-002, associated BES facility, cyber system categorization, responsible senior manager, applicable CIP standard versions, last assessment date, and next reassessment due date. SSOT for CIP asset inventory required under CIP-002 and drives CIP obligation applicability mapping.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` (
    `emissions_report_id` BIGINT COMMENT 'Unique identifier for the emissions compliance report. Primary key for the emissions report entity.',
    `environmental_permit_id` BIGINT COMMENT 'FK to compliance.environmental_permit.environmental_permit_id — Emissions reports are submitted under specific environmental permits (e.g., Title V permits). This link enables permit-level compliance tracking.',
    `generating_unit_id` BIGINT COMMENT 'Foreign key linking to generation.generating_unit. Business justification: EPA CEMS emissions reports are submitted per generating unit (ORISPL code + unit identifier). The existing FK only links to power_plant; unit-level FK is required for EPA Part 75 compliance, unit-spec',
    `generation_forecast_interval_id` BIGINT COMMENT 'Foreign key linking to forecast.generation_forecast_interval. Business justification: Emissions reports reference generation forecasts for allowance planning and compliance margin calculation. Forward-looking emissions compliance requires forecasted generation dispatch to ensure suffic',
    `original_report_emissions_report_id` BIGINT COMMENT 'Reference to the original emissions report ID if this is an amended report. Null for original submissions.',
    `power_plant_id` BIGINT COMMENT 'Identifier of the generation facility (plant unit) that produced the emissions being reported.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Each emissions report fulfills a specific regulatory obligation (e.g., EPA Title V reporting, state emissions reporting). Many reports can fulfill one obligation (1:N). Adding obligation_id FK links t',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Emissions reports are submitted to EPA as formal regulatory filings. The regulatory_filing table has epa_emissions_report_type field confirming this filing type. Direct FK links the emissions report t',
    `allowances_held` STRING COMMENT 'The number of emission allowances held by the facility for the pollutant type at the end of the reporting period, applicable to cap-and-trade programs.',
    `allowances_used` STRING COMMENT 'The number of emission allowances used (surrendered) to cover emissions during the reporting period, applicable to cap-and-trade programs.',
    `amendment_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this report is an amendment to a previously submitted report (True) or an original submission (False).',
    `amendment_reason` STRING COMMENT 'Explanation of the reason for amending the original emissions report, if applicable.',
    `applicable_emission_limit` DECIMAL(18,2) COMMENT 'The regulatory emission limit applicable to this facility and pollutant type for the reporting period, expressed in the same unit as measured emissions.',
    `authorized_representative_name` STRING COMMENT 'The name of the designated authorized representative who certifies the accuracy of the emissions report on behalf of the facility.',
    `cems_certification_status` STRING COMMENT 'The certification status of the CEMS equipment used for emissions monitoring, if applicable.. Valid values are `Certified|Provisional|Decertified|Not Applicable`',
    `certification_date` DATE COMMENT 'The date when the authorized representative certified the emissions report as accurate and complete.',
    `comments` STRING COMMENT 'Additional comments, notes, or explanatory information related to the emissions report.',
    `compliance_margin` DECIMAL(18,2) COMMENT 'The difference between the applicable emission limit and the measured emission quantity. Positive values indicate compliance; negative values indicate exceedance.',
    `compliance_status` STRING COMMENT 'The overall compliance status of the facility for this emissions report: Compliant (within limits), Non-Compliant (exceeded limits), Pending Review, or Conditional (compliant with conditions).. Valid values are `Compliant|Non-Compliant|Pending Review|Conditional`',
    `corrective_action_plan` STRING COMMENT 'Description of the corrective action plan implemented or planned to address non-compliance, if applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this emissions report record was first created in the system.',
    `data_quality_indicator` STRING COMMENT 'Indicator of the quality and completeness of the emissions data: Verified (QA/QC complete), Estimated (based on calculations), Provisional (preliminary data), or Incomplete (missing data elements).. Valid values are `Verified|Estimated|Provisional|Incomplete`',
    `emission_rate` DECIMAL(18,2) COMMENT 'The calculated emission rate for the pollutant, typically expressed as pounds per MMBtu or tons per MWh, depending on the regulatory program.',
    `emission_unit_of_measure` STRING COMMENT 'The unit of measure for the reported emission quantity (typically tons, but may include pounds or kilograms for certain pollutants).. Valid values are `tons|pounds|kilograms`',
    `exceedance_reason` STRING COMMENT 'Explanation or reason code for any emission limit exceedance, if applicable. Null if no exceedance occurred.',
    `gross_generation_mwh` DECIMAL(18,2) COMMENT 'The total gross electrical generation from the plant unit during the reporting period, measured in megawatt-hours (MWh).',
    `heat_input_mmbtu` DECIMAL(18,2) COMMENT 'The total heat input to the generation unit during the reporting period, measured in million British thermal units (MMBtu).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this emissions report record was last modified in the system.',
    `measured_emission_quantity` DECIMAL(18,2) COMMENT 'The measured quantity of emissions for the specified pollutant during the reporting period, expressed in tons.',
    `monitoring_methodology` STRING COMMENT 'The methodology used to measure emissions: CEMS (Continuous Emissions Monitoring System), PEMS (Predictive Emissions Monitoring System), Alternative monitoring, Fuel Sampling, or Mass Balance calculation.. Valid values are `CEMS|PEMS|Alternative|Fuel Sampling|Mass Balance`',
    `operating_hours` DECIMAL(18,2) COMMENT 'The total number of operating hours for the plant unit during the reporting period.',
    `orispl_code` STRING COMMENT 'The unique EPA-assigned ORISPL code identifying the power plant facility for regulatory reporting purposes.',
    `pollutant_type` STRING COMMENT 'The type of pollutant being reported: SO2 (Sulfur Dioxide), NOx (Nitrogen Oxides), CO2 (Carbon Dioxide), Mercury, PM2.5 (Particulate Matter 2.5 micrometers), or PM10 (Particulate Matter 10 micrometers).. Valid values are `SO2|NOx|CO2|Mercury|PM2.5|PM10`',
    `qa_qc_completion_date` DATE COMMENT 'The date when quality assurance and quality control procedures were completed for the emissions data.',
    `report_submission_date` DATE COMMENT 'The date when the emissions report was submitted to the regulatory agency (EPA or state environmental agency).',
    `reporting_period_end_date` DATE COMMENT 'The end date of the emissions reporting period covered by this report.',
    `reporting_period_start_date` DATE COMMENT 'The start date of the emissions reporting period covered by this report.',
    `submission_status` STRING COMMENT 'The current status of the emissions report submission to the regulatory agency.. Valid values are `Draft|Submitted|Accepted|Rejected|Under Review|Amended`',
    CONSTRAINT pk_emissions_report PRIMARY KEY(`emissions_report_id`)
) COMMENT 'Periodic emissions compliance report submitted to the EPA and state environmental agencies, covering SO2, NOx, CO2, mercury, and particulate matter emissions from generation facilities. Captures reporting period, facility (plant unit), pollutant type, measured emission quantity (tons), applicable emission limit, compliance margin, monitoring methodology (CEMS or alternative), and submission status. Supports EPA Clean Air Act Title IV Acid Rain Program, CSAPR, and state RPS compliance.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` (
    `environmental_permit_id` BIGINT COMMENT 'Primary key for environmental_permit',
    `power_plant_id` BIGINT COMMENT 'Identifier of the generation, transmission, or distribution facility covered by this environmental permit. Links permit to the physical asset location where environmental compliance is enforced.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Each environmental permit fulfills a specific regulatory obligation (e.g., EPA Title V air permit, NPDES water discharge permit). Many permits can fulfill one obligation (1:N). Adding obligation_id FK',
    `appeal_status` STRING COMMENT 'Status of any administrative or judicial appeal of permit conditions. Appeals can delay permit effectiveness or result in modified conditions.. Valid values are `no_appeal|appeal_pending|appeal_resolved|appeal_upheld`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this permit record was first created in the compliance management system. Used for audit trail and data lineage tracking.',
    `data_source_system` STRING COMMENT 'Name of the source system from which this permit record was ingested (e.g., SAP EHS, environmental compliance database, regulatory agency portal). Used for data lineage and reconciliation.',
    `effective_date` DATE COMMENT 'The date the environmental permit becomes legally binding and enforceable. May differ from issuance date if permit includes a delayed effective date provision.',
    `enforcement_action_flag` BOOLEAN COMMENT 'Indicates whether this permit is currently subject to an active enforcement action, consent decree, or compliance order from the regulatory agency.',
    `expiration_date` DATE COMMENT 'The date the environmental permit expires and must be renewed. Operating beyond expiration without renewal constitutes a violation subject to enforcement action and penalties.',
    `facility_epa_code` STRING COMMENT 'The unique EPA facility identification number assigned to the permitted facility. Used for all federal environmental reporting including emissions inventories and discharge monitoring reports.',
    `facility_name` STRING COMMENT 'Name of the utility facility covered by this environmental permit. Typically a power generation plant, substation, or operations center subject to environmental regulation.',
    `issuance_date` DATE COMMENT 'The date the environmental permit was officially issued by the regulatory agency. Marks the beginning of the permit term and the effective date for permit conditions.',
    `issuing_agency` STRING COMMENT 'Name of the federal, state, or local regulatory agency that issued the environmental permit. Typically EPA for federal permits or state environmental protection agency for state-delegated programs.',
    `issuing_agency_jurisdiction` STRING COMMENT 'The governmental jurisdiction level of the issuing agency. Determines the regulatory authority hierarchy and appeal process for permit conditions.. Valid values are `federal|state|local`',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory agency inspection of the permitted facility for compliance with permit conditions. Inspections may be routine or triggered by complaints or violations.',
    `last_inspection_result` STRING COMMENT 'Outcome of the most recent regulatory inspection. Major violations may result in enforcement actions, penalties, or permit modifications.. Valid values are `compliant|minor_violation|major_violation|not_applicable`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this permit record was last modified. Tracks changes to permit status, conditions, or administrative data for compliance audit purposes.',
    `monitoring_frequency` STRING COMMENT 'Required frequency for monitoring and reporting emissions or discharges under this permit. Determines compliance testing schedule and data submission deadlines to regulatory agencies.. Valid values are `continuous|daily|weekly|monthly|quarterly|annual`',
    `notes` STRING COMMENT 'Free-text field for additional notes, special circumstances, or historical context related to this permit. Used for internal compliance management and knowledge transfer.',
    `permit_conditions_summary` STRING COMMENT 'High-level summary of key permit conditions, operational restrictions, and compliance obligations. Detailed conditions are maintained in permit documentation repository.',
    `permit_document_url` STRING COMMENT 'URL or file path to the official permit document in the document management system. Provides access to full permit text, conditions, and attachments.',
    `permit_fee_amount` DECIMAL(18,2) COMMENT 'Annual or one-time fee paid to the regulatory agency for permit issuance, renewal, or maintenance. Fee structure varies by permit type and jurisdiction.',
    `permit_fee_currency` STRING COMMENT 'Currency code for permit fees. Typically USD for US-based utility operations.. Valid values are `USD`',
    `permit_number` STRING COMMENT 'The official permit number issued by the regulatory agency. This is the externally-known unique identifier used in all regulatory correspondence and compliance reporting.',
    `permit_status` STRING COMMENT 'Current lifecycle status of the environmental permit. Active permits authorize operations; expired or suspended permits require immediate remediation to avoid enforcement action.. Valid values are `active|expired|pending_renewal|suspended|revoked|under_review`',
    `permit_type` STRING COMMENT 'Classification of the environmental permit based on the regulatory program and environmental media regulated. Determines applicable compliance requirements and reporting obligations.. Valid values are `title_v_air|npdes_water_discharge|rcra_hazardous_waste|state_air_quality|state_water_quality|stormwater`',
    `permitted_discharge_limit_gallons_per_day` DECIMAL(18,2) COMMENT 'Maximum allowable daily water discharge volume in gallons per day under NPDES or state water discharge permit. Applies to cooling water, process water, and stormwater discharges.',
    `permitted_emission_limit_tons_per_year` DECIMAL(18,2) COMMENT 'Maximum allowable annual emissions in tons per year for regulated air pollutants under this permit. Exceeding this limit constitutes a permit violation and triggers enforcement action.',
    `public_comment_period_end_date` DATE COMMENT 'Date the public comment period closed for this permit. After this date, the permit becomes final unless appealed.',
    `public_notice_flag` BOOLEAN COMMENT 'Indicates whether this permit was subject to public notice and comment period as required for major permits under EPA regulations. Public participation is required for Title V and major NPDES permits.',
    `regulated_pollutants` STRING COMMENT 'Comma-separated list of specific pollutants regulated under this permit (e.g., SO2, NOx, PM2.5, mercury, lead, benzene). Each pollutant may have individual emission or discharge limits and monitoring requirements.',
    `renewal_application_date` DATE COMMENT 'The date the permit renewal application was submitted to the regulatory agency. Must typically be submitted 6-18 months before expiration depending on permit type and jurisdiction.',
    `renewal_status` STRING COMMENT 'Current status of the permit renewal process. Tracks whether renewal application has been submitted and the agencys decision status. Critical for avoiding permit lapses.. Valid values are `not_required|renewal_pending|renewal_submitted|renewal_approved|renewal_denied`',
    `reporting_frequency` STRING COMMENT 'Required frequency for submitting compliance reports to the regulatory agency. Missed reporting deadlines can result in notices of violation and penalties.. Valid values are `monthly|quarterly|semi_annual|annual`',
    `responsible_party_email` STRING COMMENT 'Email address of the responsible official for regulatory correspondence and compliance notifications related to this permit.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `responsible_party_name` STRING COMMENT 'Name of the individual or role designated as the responsible official for this permit as reported to the regulatory agency. This person certifies compliance reports and permit applications.',
    `responsible_party_phone` STRING COMMENT 'Phone number of the responsible official for urgent regulatory communications and compliance inquiries.',
    `responsible_party_title` STRING COMMENT 'Job title of the responsible official for this permit. Typically a senior operations or environmental manager with authority to certify compliance.',
    `special_conditions_flag` BOOLEAN COMMENT 'Indicates whether this permit includes special or non-standard conditions beyond typical permit requirements. Special conditions often require enhanced monitoring or operational controls.',
    `violation_count` STRING COMMENT 'Total number of documented violations of this permit since issuance. High violation counts may trigger enhanced oversight or permit revocation proceedings.',
    CONSTRAINT pk_environmental_permit PRIMARY KEY(`environmental_permit_id`)
) COMMENT 'Master record for all environmental operating permits held by the utility, including EPA Title V air permits, NPDES water discharge permits, RCRA hazardous waste permits, and state-issued environmental authorizations. Captures permit number, issuing agency, permitted facility, permit type, issuance date, expiration date, renewal status, permitted emission or discharge limits, and permit conditions. SSOT for environmental permit portfolio management.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` (
    `compliance_rec_certificate_id` BIGINT COMMENT 'Unique identifier for the REC certificate record. Primary key for the compliance REC certificate entity.',
    `forecast_renewable_id` BIGINT COMMENT 'Foreign key linking to forecast.forecast_renewable. Business justification: RPS compliance planning requires utilities to forecast renewable generation to determine REC procurement needs and retirement schedules. Compliance officers use renewable forecasts to ensure sufficien',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: REC certificates fulfill renewable portfolio standard (RPS) obligations. Many RECs can fulfill one obligation (1:N). Adding obligation_id FK links the REC to the RPS obligation it satisfies. The rps_j',
    `ppa_contract_id` BIGINT COMMENT 'Identifier of the Power Purchase Agreement (PPA) or REC purchase contract under which this REC was acquired. Links to contract management system for terms and conditions.',
    `power_plant_id` BIGINT COMMENT 'Identifier of the renewable energy generation facility that produced the energy for which this REC was issued. Links to the generation asset registry.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: REC certificates are retired and reported as part of RPS (Renewable Portfolio Standard) regulatory filings. The regulatory_filing table has rps_compliance_year, rps_rec_retired_count, rps_renewable_en',
    `certificate_status` STRING COMMENT 'Current lifecycle status of the REC certificate. Active certificates are available for trading or retirement; retired certificates have been used for compliance; transferred certificates have changed ownership; cancelled certificates are voided.. Valid values are `active|retired|expired|transferred|cancelled|pending`',
    `compliance_credit_mwh` DECIMAL(18,2) COMMENT 'Effective compliance credit value after applying any multipliers. Calculated as energy_quantity_mwh × rec_multiplier. This is the value counted toward RPS obligation fulfillment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this REC certificate record was first created in the internal compliance tracking system. Used for audit trail and data lineage purposes.',
    `current_owner_name` STRING COMMENT 'Name of the current legal owner of this REC certificate. Ownership may transfer multiple times before retirement. Confidential business information.',
    `data_source_system` STRING COMMENT 'Name of the source system or registry from which this REC data was ingested (e.g., WREGIS API, M-RETS feed, manual entry). Used for data lineage and reconciliation.',
    `eligibility_flags` STRING COMMENT 'Comma-separated list of special eligibility attributes or certifications for this REC (e.g., in-state, new facility, low-impact hydro, community solar). Used to match RECs to specific compliance requirements.',
    `emissions_avoided_co2_tons` DECIMAL(18,2) COMMENT 'Estimated tons of CO2 emissions avoided by the renewable generation represented by this REC, calculated using regional grid emission factors. Used for environmental impact reporting.',
    `energy_quantity_mwh` DECIMAL(18,2) COMMENT 'Quantity of renewable energy represented by this REC certificate, measured in megawatt-hours. Typically one REC equals one MWh of renewable generation, though some programs use different ratios.',
    `expiration_date` DATE COMMENT 'Date after which this REC can no longer be used for compliance purposes in the applicable jurisdiction. Many RPS programs impose vintage limits (e.g., RECs must be used within 3 years of generation).',
    `facility_location_country` STRING COMMENT 'Country where the generating facility is located. Most U.S. state RPS programs only accept RECs from facilities in the U.S. or specific Canadian provinces.. Valid values are `USA|CAN|MEX`',
    `facility_location_state` STRING COMMENT 'U.S. state or Canadian province where the generating facility is located. Geographic location affects RPS eligibility in many jurisdictions.',
    `generation_end_date` DATE COMMENT 'End date of the generation period for which this REC was issued. Defines the end of the time window during which the renewable energy was produced.',
    `generation_start_date` DATE COMMENT 'Start date of the generation period for which this REC was issued. Defines the beginning of the time window during which the renewable energy was produced.',
    `generation_technology_type` STRING COMMENT 'Type of renewable energy technology used to generate the electricity represented by this REC. Critical for RPS compliance as many states have technology-specific requirements or multipliers. [ENUM-REF-CANDIDATE: solar|wind|hydro|biomass|geothermal|landfill gas|tidal|wave — 8 candidates stripped; promote to reference product]',
    `generation_vintage_month` STRING COMMENT 'Calendar month (1-12) in which the renewable energy was generated. Provides granular vintage tracking for compliance and trading purposes.',
    `generation_vintage_year` STRING COMMENT 'Calendar year in which the renewable energy was generated. Vintage year determines eligibility for compliance periods under state RPS programs.',
    `issuance_date` DATE COMMENT 'Date on which this REC certificate was issued by the registry. Issuance typically occurs after generation data is verified and submitted to the registry.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this REC certificate record was last updated in the internal compliance tracking system. Tracks data currency and change history.',
    `last_transfer_date` DATE COMMENT 'Date of the most recent ownership transfer of this REC. Null if the REC has never been transferred from the original owner.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding this REC certificate, including special handling instructions, compliance considerations, or audit findings. Used for operational coordination and compliance documentation.',
    `original_owner_name` STRING COMMENT 'Name of the original owner to whom this REC was first issued, typically the generator or the entity with contractual rights to the RECs from the generation facility.',
    `purchase_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the purchase price. Typically USD for U.S. REC markets.. Valid values are `USD|CAD`',
    `purchase_price_per_rec` DECIMAL(18,2) COMMENT 'Price paid per REC certificate in the most recent transaction, typically in USD. Confidential commercial information used for cost tracking and portfolio valuation.',
    `rec_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to the energy quantity for compliance credit calculation. Some state RPS programs provide enhanced credit (e.g., 1.5x or 2.0x) for certain technologies, in-state generation, or other policy objectives.',
    `rec_serial_number` STRING COMMENT 'Unique serial number assigned by the registry to this REC certificate. This is the externally-known business identifier used for tracking, trading, and retirement of the certificate across registries and market participants.',
    `registry_name` STRING COMMENT 'Name of the registry system where this REC is registered and tracked. Registries provide independent verification and tracking of renewable energy generation and certificate lifecycle. [ENUM-REF-CANDIDATE: WREGIS|NEPOOL GIS|PJM GATS|M-RETS|NAR|ERCOT|MIRECS — 7 candidates stripped; promote to reference product]',
    `retirement_date` DATE COMMENT 'Date on which this REC was retired for compliance or voluntary purposes. Retired RECs cannot be traded or reused. Null if the REC has not been retired.',
    `retirement_reason` STRING COMMENT 'Reason for retiring this REC certificate. RPS compliance retirements are used to meet state renewable portfolio standards; voluntary retirements support corporate sustainability goals or green marketing claims.. Valid values are `RPS compliance|voluntary|contractual obligation|marketing claim|other`',
    `rps_compliance_year` STRING COMMENT 'Compliance year for which this REC was retired to meet RPS obligations. Null if not retired for RPS compliance. Critical for demonstrating compliance to state PUCs.',
    `rps_tier` STRING COMMENT 'RPS tier or category classification for this REC under the applicable state program. Many states have tiered structures with different technology eligibility and compliance requirements for each tier.. Valid values are `Tier 1|Tier 2|Solar|Main Tier|Alternative Compliance|Other`',
    `transfer_count` STRING COMMENT 'Number of times this REC has been transferred between owners since issuance. Provides insight into market activity and trading liquidity.',
    CONSTRAINT pk_compliance_rec_certificate PRIMARY KEY(`compliance_rec_certificate_id`)
) COMMENT 'Renewable Energy Certificate (REC) record tracking the generation, registration, transfer, retirement, and compliance use of RECs for Renewable Portfolio Standard (RPS) compliance. Captures REC serial number, generating facility, generation technology type, vintage period, MWh quantity, registry (WREGIS, NEPOOL GIS, PJM GATS, M-RETS), current owner, transfer history, retirement date, and associated RPS compliance obligation. SSOT for RPS certificate inventory, retirement tracking, and RPS compliance demonstration to state PUCs.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`compliance`.`rate_case` (
    `rate_case_id` BIGINT COMMENT 'Unique identifier for the rate case proceeding. Primary key for the rate case entity.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Rate cases are initiated to fulfill specific regulatory obligations (PUC/FERC rate-setting obligations). Direct FK to obligation links the rate case proceeding to its governing regulatory obligation, ',
    `administrative_law_judge` STRING COMMENT 'Name of the administrative law judge or hearing officer assigned to preside over the evidentiary hearing and issue a proposed decision. Null if not applicable in this jurisdiction.',
    `approved_rate_increase_percent` DECIMAL(18,2) COMMENT 'Overall percentage increase in customer rates approved by the commission in the final order. Expressed as a percentage. Null until final order is issued.',
    `case_description` STRING COMMENT 'Narrative description of the rate case purpose, scope, and key issues. Includes summary of major cost drivers, policy issues, and contested matters.',
    `case_status` STRING COMMENT 'Current procedural status of the rate case in its regulatory lifecycle. Tracks progression from initial filing through final commission order and any post-order proceedings. [ENUM-REF-CANDIDATE: draft|filed|pending|hearing_scheduled|hearing_complete|settlement_negotiation|commission_deliberation|final_order_issued|rehearing_requested|closed — 10 candidates stripped; promote to reference product]',
    `case_type` STRING COMMENT 'Classification of the rate case proceeding by its regulatory purpose and scope. General rate cases address overall revenue requirements; transmission rate cases address FERC OATT rates; distribution rate cases address local delivery rates; fuel adjustment clauses address fuel cost recovery; decoupling mechanisms address revenue decoupling from sales volume; formula rates address automatic rate adjustment mechanisms.. Valid values are `general_rate_case|transmission_rate_case|distribution_rate_case|fuel_adjustment_clause|decoupling_mechanism|formula_rate`',
    `commission_staff_analyst` STRING COMMENT 'Name of the primary commission staff analyst assigned to review and analyze the rate case filing.',
    `effective_date` DATE COMMENT 'Date the new rates approved in the final order become effective for customer billing. May differ from final order date due to suspension periods, phase-in schedules, or tariff filing requirements.',
    `evidentiary_hearing_end_date` DATE COMMENT 'Date the evidentiary hearing concluded. Null if case settled before hearing or hearing not yet completed.',
    `evidentiary_hearing_start_date` DATE COMMENT 'Date the evidentiary hearing commenced, where witnesses present testimony and are subject to cross-examination. Null if case settled before hearing or hearing not yet scheduled.',
    `filed_with_agency` BIGINT COMMENT 'FK to compliance.regulatory_agency.regulatory_agency_id — Rate cases are filed with specific PUCs or FERC. Essential FK for jurisdictional tracking.',
    `filing_date` DATE COMMENT 'Date the utility formally filed the rate case application with the regulatory commission. This date triggers statutory review timelines and procedural schedules.',
    `filing_jurisdiction` STRING COMMENT 'Regulatory jurisdiction where the rate case is filed. Use state abbreviation for state PUC filings (e.g., CA, TX, NY) or FERC for Federal Energy Regulatory Commission filings.. Valid values are `^[A-Z]{2,4}$`',
    `final_order_date` DATE COMMENT 'Date the commission issued its final order deciding the rate case. This date establishes the effective date for new rates (subject to any suspension or phase-in provisions).',
    `initial_brief_due_date` DATE COMMENT 'Deadline for parties to file initial post-hearing briefs summarizing their positions and legal arguments. Null if case settled or procedural schedule not yet established.',
    `intervenor_count` STRING COMMENT 'Number of parties granted intervenor status in the rate case proceeding, including consumer advocates, industrial customer groups, environmental organizations, and other stakeholders.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, observations, or context regarding the rate case proceeding that do not fit structured fields.',
    `prehearing_conference_date` DATE COMMENT 'Date of the prehearing conference where procedural schedule, discovery protocols, and hearing logistics are established. Null if not yet scheduled or if case settled before hearing.',
    `proposed_decision_date` DATE COMMENT 'Date the administrative law judge or hearing officer issued a proposed decision recommending findings and conclusions to the commission. Null if not applicable in this jurisdiction or if case settled.',
    `proposed_rate_increase_percent` DECIMAL(18,2) COMMENT 'Overall percentage increase in customer rates proposed by the utility in the initial filing, calculated as the change in revenue requirement divided by current revenues. Expressed as a percentage. Negative values indicate a rate decrease.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this rate case record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this rate case record was last modified in the system.',
    `regulatory_affairs_manager` STRING COMMENT 'Name of the regulatory affairs manager responsible for coordinating the utilitys rate case strategy, filings, and stakeholder engagement.',
    `rehearing_decision_date` DATE COMMENT 'Date the commission issued its decision on the rehearing petition. Null if no rehearing was requested or decision not yet issued.',
    `rehearing_request_date` DATE COMMENT 'Date the petition for rehearing was filed. Null if no rehearing was requested.',
    `rehearing_requested_flag` BOOLEAN COMMENT 'Indicates whether any party filed a petition for rehearing or reconsideration of the final commission order (True) or not (False).',
    `reply_brief_due_date` DATE COMMENT 'Deadline for parties to file reply briefs responding to initial briefs. Null if case settled or procedural schedule not yet established.',
    `settlement_date` DATE COMMENT 'Date the settlement agreement was executed by the parties. Null if the case was not settled.',
    `settlement_flag` BOOLEAN COMMENT 'Indicates whether the rate case was resolved through a settlement agreement among the utility, commission staff, and intervenor parties (True) or proceeded to a fully litigated commission decision (False).',
    `suspension_period_days` STRING COMMENT 'Number of days the commission suspended the proposed rate effective date to allow time for review and hearing. Statutory suspension periods vary by jurisdiction (e.g., 5 months for FERC, varies by state PUC).',
    `test_year_end_date` DATE COMMENT 'Ending date of the test year period used to establish the revenue requirement and cost of service.',
    `test_year_start_date` DATE COMMENT 'Beginning date of the test year period used to establish the revenue requirement and cost of service. Test year may be historical, future, or a hybrid period depending on jurisdiction.',
    CONSTRAINT pk_rate_case PRIMARY KEY(`rate_case_id`)
) COMMENT 'Master record for each PUC or FERC rate case proceeding initiated by or involving the utility, including general rate cases, transmission rate cases (FERC OATT), distribution rate cases, fuel adjustment clause proceedings, and decoupling mechanism filings. Captures docket number, filing jurisdiction, case type, test year, filed revenue requirement, proposed rate changes, intervenor parties, procedural schedule milestones (pre-hearing conference, evidentiary hearings, briefs, proposed decision), settlement status, and final commission order. Tracks the full proceeding lifecycle from initial filing through final order and any rehearing requests. SSOT for rate case lifecycle management.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`compliance`.`program` (
    `program_id` BIGINT COMMENT 'Primary key for program',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Compliance programs are established to fulfill specific regulatory obligations (e.g., NERC CIP program fulfills NERC CIP obligations). The program table has governing_regulatory_framework (STRING) whi',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this compliance program record is currently active in the system (True/False). Used for soft deletes and historical tracking.',
    `assessment_required_flag` BOOLEAN COMMENT 'Indicates whether a formal assessment or examination is required to demonstrate training competency (True/False).',
    `audit_frequency` STRING COMMENT 'The frequency at which this compliance program is subject to internal or external audit.. Valid values are `annual|biennial|triennial|quarterly|as_needed|continuous`',
    `board_reporting_flag` BOOLEAN COMMENT 'Indicates whether this compliance program status and metrics are reported to the Board of Directors (True/False).',
    `board_reporting_frequency` STRING COMMENT 'The frequency at which compliance program status is reported to the Board of Directors.. Valid values are `monthly|quarterly|semi_annual|annual|as_needed`',
    `budget_usd` DECIMAL(18,2) COMMENT 'The annual budget allocated to this compliance program in United States Dollars, including personnel, training, technology, and external audit costs.',
    `certification_issued_flag` BOOLEAN COMMENT 'Indicates whether a formal certification is issued upon successful completion of training (True/False).',
    `certification_validity_period_months` STRING COMMENT 'The number of months for which a training certification remains valid before recertification is required. Null if certification does not expire.',
    `charter_date` DATE COMMENT 'The date on which the compliance program was formally chartered and approved by executive leadership or the Board.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this compliance program record was first created in the system.',
    `document_repository_location` STRING COMMENT 'The system or location where compliance program documentation, policies, procedures, and evidence are stored (e.g., SharePoint site, document management system path).',
    `effective_date` DATE COMMENT 'The date on which the compliance program became operationally effective and binding on the organization.',
    `effectiveness_rating` STRING COMMENT 'Qualitative assessment of the compliance programs effectiveness in achieving its objectives and managing compliance risk.. Valid values are `highly_effective|effective|needs_improvement|ineffective|not_rated`',
    `evidence_retention_period_years` STRING COMMENT 'The number of years that compliance evidence and training records must be retained to satisfy regulatory and audit requirements.',
    `expiration_date` DATE COMMENT 'The date on which the compliance program is scheduled to expire or be reviewed for renewal. Null for perpetual programs.',
    `external_auditor_flag` BOOLEAN COMMENT 'Indicates whether this compliance program is subject to external auditor review (True/False).',
    `issuing_regulatory_body` STRING COMMENT 'The governing body or regulatory agency that issued the compliance mandate (e.g., NERC, FERC, EPA, SEC, OSHA, State PUC).',
    `last_audit_date` DATE COMMENT 'The date of the most recent internal or external audit of this compliance program.',
    `last_audit_result` STRING COMMENT 'The outcome of the most recent audit of this compliance program.. Valid values are `compliant|non_compliant|compliant_with_findings|not_audited`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this compliance program record was most recently modified.',
    `minimum_passing_score_pct` DECIMAL(18,2) COMMENT 'The minimum assessment score required to pass training and achieve compliance (e.g., 80.00 for NERC CIP training assessments).',
    `next_audit_date` DATE COMMENT 'The scheduled date for the next internal or external audit of this compliance program.',
    `notes` STRING COMMENT 'Free-form notes capturing additional context, special considerations, or historical information about the compliance program.',
    `owner_title` STRING COMMENT 'Job title of the program owner (e.g., Chief Compliance Officer, VP Regulatory Affairs, Director Environmental Compliance).',
    `program_code` STRING COMMENT 'Unique business identifier code for the compliance program (e.g., NERC-CIP, FERC-SOC, EPA-EMIS, SOX-FIN, OSHA-SAF).. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `program_description` STRING COMMENT 'Comprehensive narrative description of the compliance program objectives, scope, key activities, and deliverables.',
    `program_name` STRING COMMENT 'Full official name of the compliance program (e.g., NERC CIP Compliance Program, FERC Standards of Conduct Program, Environmental Compliance Program, SOX Compliance Program, OSHA Safety Compliance Program).',
    `program_status` STRING COMMENT 'Current lifecycle status of the compliance program.. Valid values are `active|inactive|under_development|suspended|retired`',
    `program_type` STRING COMMENT 'Classification of the compliance program by its origin and binding nature.. Valid values are `regulatory|statutory|voluntary|contractual|internal_policy`',
    `risk_rating` STRING COMMENT 'The assessed risk level associated with non-compliance under this program, considering both likelihood and impact.. Valid values are `critical|high|medium|low`',
    `scope_of_applicability` STRING COMMENT 'Detailed description of the organizational scope to which this compliance program applies (e.g., all generation facilities, all transmission assets rated above 100kV, all employees with access to BES Cyber Systems, all financial reporting personnel).',
    `training_completion_threshold_pct` DECIMAL(18,2) COMMENT 'The minimum percentage of assigned personnel who must complete training for the program to be considered compliant (e.g., 100.00 for NERC CIP, 95.00 for internal programs).',
    `training_frequency` STRING COMMENT 'The required frequency at which training must be completed or refreshed for this compliance program.. Valid values are `annual|biennial|quarterly|one_time|as_needed|continuous`',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether formal training is mandated for personnel under this compliance program (True/False).',
    `updated_by_user` STRING COMMENT 'The user ID or name of the person who last updated this compliance program record.',
    CONSTRAINT pk_program PRIMARY KEY(`program_id`)
) COMMENT 'Master record for each formal compliance program maintained by the utility, including the NERC CIP Compliance Program, FERC Standards of Conduct Program, Environmental Compliance Program, SOX Compliance Program, and OSHA Safety Compliance Program. Captures program name, governing regulatory framework, program owner, program charter date, scope of applicability, associated policies and procedures, and program effectiveness metrics. Includes the full training management lifecycle: training course catalog, training delivery methods, training assignments, and for each personnel training completion: assigned personnel role, training course, delivery method, assigned date, completion date, assessment score, pass/fail status, and certification expiry date. Provides the organizational structure for compliance management and serves as SSOT for compliance program inventory and all compliance training evidence required under NERC CIP-004, FERC Standards of Conduct, OSHA, and other regulatory training mandates.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`compliance`.`training_record` (
    `training_record_id` BIGINT COMMENT 'Primary key for training_record',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.audit. Business justification: Training records serve as compliance evidence for audits (NERC CIP personnel training requirements are audited). The training_record table has audit_evidence_reference (STRING) which is a denormalized',
    `obligation_id` BIGINT COMMENT 'Unique identifier of the regulatory obligation that mandates this training requirement.',
    `program_id` BIGINT COMMENT 'FK to compliance.program.program_id — Training records are associated with specific compliance programs (NERC CIP, SOX, OSHA). This FK enables program-level training compliance tracking.',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this training record is currently active (True) or has been archived/superseded (False).',
    `actual_time_spent_hours` DECIMAL(18,2) COMMENT 'Actual time spent by the employee completing the training, tracked by the learning management system.',
    `assessment_passed_flag` BOOLEAN COMMENT 'Indicates whether the employee passed the training assessment (True) or failed (False).',
    `assessment_score` DECIMAL(18,2) COMMENT 'Numeric score achieved by the employee on the training assessment or examination, typically expressed as a percentage (0.00 to 100.00).',
    `assigned_by_user` STRING COMMENT 'Username or identifier of the compliance officer or manager who assigned the training.',
    `assigned_date` DATE COMMENT 'Date on which the training was assigned to the employee.',
    `attempt_number` STRING COMMENT 'Number of attempts the employee has made to complete the training assessment.',
    `business_unit` STRING COMMENT 'Business unit or department to which the employee belongs (e.g., Generation Operations, Transmission, Distribution, IT).',
    `certification_expiry_date` DATE COMMENT 'Date on which the training certification expires and recertification or refresher training is required.',
    `certification_issue_date` DATE COMMENT 'Date on which the training completion certificate was issued.',
    `certification_number` STRING COMMENT 'Unique certificate number issued upon successful completion of the training, used for audit evidence.',
    `completion_date` DATE COMMENT 'Date on which the employee successfully completed the training course.',
    `completion_status` STRING COMMENT 'Current status of the training assignment indicating progress and completion state.. Valid values are `Not Started|In Progress|Completed|Failed|Overdue|Waived`',
    `compliance_year` STRING COMMENT 'Calendar year for which this training record satisfies compliance obligations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this training record was first created in the system.',
    `due_date` DATE COMMENT 'Date by which the training must be completed to maintain compliance.',
    `facility_code` STRING COMMENT 'Code identifying the utility facility or location where the employee is assigned (e.g., power plant, substation, control center).',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this training record was last modified.',
    `nerc_cip_role_flag` BOOLEAN COMMENT 'Indicates whether the employee holds a NERC CIP-designated role requiring enhanced cybersecurity training (True) or not (False).',
    `passing_score_threshold` DECIMAL(18,2) COMMENT 'Minimum score required to pass the training assessment and achieve compliance, typically expressed as a percentage.',
    `personnel_role` STRING COMMENT 'Job role or position of the employee at the time of training assignment (e.g., Control Room Operator, Substation Technician, Cybersecurity Analyst).',
    `recertification_frequency_months` STRING COMMENT 'Number of months between required recertification or refresher training cycles (e.g., 12 for annual, 36 for triennial).',
    `recertification_required_flag` BOOLEAN COMMENT 'Indicates whether periodic recertification is required for this training (True) or if it is a one-time requirement (False).',
    `record_source_system` STRING COMMENT 'Name of the source system from which this training record originated (e.g., SAP SuccessFactors, Cornerstone LMS, internal compliance tracking system).',
    `training_assignment_number` STRING COMMENT 'Business identifier for the training assignment, used for tracking and audit purposes.. Valid values are `^TRN-[0-9]{10}$`',
    `training_category` STRING COMMENT 'High-level category of the compliance training program.. Valid values are `NERC CIP|FERC Standards of Conduct|OSHA Safety|Environmental Compliance|SOX Ethics|Cybersecurity`',
    `training_course_code` STRING COMMENT 'Standardized code identifying the training course (e.g., CIP004-001 for NERC CIP-004 security awareness training).. Valid values are `^[A-Z]{3,6}-[0-9]{3,4}$`',
    `training_course_name` STRING COMMENT 'Full name of the compliance training course (e.g., NERC CIP Security Awareness Training, FERC Standards of Conduct Training).',
    `training_delivery_method` STRING COMMENT 'Method by which the training content is delivered to the personnel.. Valid values are `Instructor-Led|E-Learning|Webinar|On-the-Job|Blended|Self-Study`',
    `training_duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the training course in hours.',
    `training_notes` STRING COMMENT 'Free-text notes capturing additional context, special circumstances, or observations related to the training assignment and completion.',
    `training_type` STRING COMMENT 'Type of training assignment indicating whether it is initial onboarding, periodic refresher, recertification, or remedial training.. Valid values are `Initial|Refresher|Recertification|Remedial|Ad-Hoc`',
    `updated_by_user` STRING COMMENT 'Username or identifier of the user who last updated this training record.',
    `waiver_approval_date` DATE COMMENT 'Date on which the training waiver was approved.',
    `waiver_approved_by` STRING COMMENT 'Username or identifier of the compliance officer or manager who approved the training waiver.',
    `waiver_granted_flag` BOOLEAN COMMENT 'Indicates whether a waiver was granted exempting the employee from completing this training (True) or not (False).',
    `waiver_reason` STRING COMMENT 'Business justification for granting a training waiver, if applicable.',
    CONSTRAINT pk_training_record PRIMARY KEY(`training_record_id`)
) COMMENT 'Transactional record of compliance training assignments and completions for utility personnel, covering NERC CIP security awareness training, FERC Standards of Conduct training, OSHA safety training, environmental compliance training, and SOX ethics and anti-fraud training. Captures training course, assigned personnel role, training delivery method, assigned date, completion date, assessment score, and certification expiry. Supports NERC CIP-004 personnel training evidence requirements.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`compliance`.`violation` (
    `violation_id` BIGINT COMMENT 'Primary key for violation',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: Violations are frequently discovered through audit findings (NERC CIP audit process). The corrective_action_plan already links to violation, and corrective_action_plan links to audit_finding — but a d',
    `enforcement_action_id` BIGINT COMMENT 'Foreign key linking to compliance.enforcement_action. Business justification: Enforcement actions are initiated in response to specific violations. The enforcement_action table has violated_standard_code (STRING) as a denormalized reference. Direct FK from violation to enforcem',
    `generating_unit_id` BIGINT COMMENT 'Foreign key linking to generation.generating_unit. Business justification: Compliance violations are tied to specific generating units (NOx permit exceedance on a specific unit, NERC reliability standard violation for a units performance). Enforcement response, penalty calc',
    `application_id` BIGINT COMMENT 'Foreign key linking to interconnection.application. Business justification: Violations track interconnection non-compliance: operating without PTO, exceeding export limits, failure to maintain insurance. Violation records reference the application for penalty assessment, corr',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: A violation is a violation of a specific regulatory obligation. The violation table has regulation_code (STRING) which is a denormalized reference to the obligation/standard being violated. Direct FK ',
    `registry_id` BIGINT COMMENT 'Identifier of the asset (equipment, line, generator) implicated in the violation.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Violations are self-reported via regulatory filings (Self-Reported Violations / SPV in NERC CIP). The regulatory_filing table has spv_violation_description, spv_mitigation_plan, spv_discovery_date fie',
    `appeal_deadline` DATE COMMENT 'Final date by which an appeal must be filed.',
    `audit_trail` STRING COMMENT 'Free‑text log of audit notes, investigations, and evidentiary references.',
    `compliance_status` STRING COMMENT 'Current compliance posture related to the violation.',
    `corrective_action_plan` STRING COMMENT 'Description of the corrective actions required to remediate the violation.',
    `effective_date` DATE COMMENT 'Date on which the penalty becomes enforceable.',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the violation event occurred.',
    `is_appealed` BOOLEAN COMMENT 'Indicates whether the penalty or finding has been appealed.',
    `is_reported` BOOLEAN COMMENT 'Indicates whether the violation has been formally reported to the regulator.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary fine or penalty assessed for the violation (gross amount).',
    `penalty_currency` STRING COMMENT 'ISO 4217 currency code for the penalty amount.',
    `penalty_type` STRING COMMENT 'Classification of the monetary penalty (e.g., fine, fee, restitution).',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the violation record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the violation record.',
    `regulatory_body` STRING COMMENT 'Name of the governing agency that issued the violation (e.g., NERC, FERC, EPA).',
    `report_submission_date` DATE COMMENT 'Date the violation report was submitted to the regulatory body.',
    `resolution_date` DATE COMMENT 'Date when the violation was resolved or closed.',
    `severity` STRING COMMENT 'Severity rating assigned to the violation reflecting potential impact.',
    `source_system` STRING COMMENT 'Name of the source application or system that originated the violation record.',
    `violation_description` STRING COMMENT 'Narrative description of the violation, including facts and observations.',
    `violation_number` STRING COMMENT 'External reference number assigned to the violation by the regulatory body or internal tracking system.',
    `violation_status` STRING COMMENT 'Current lifecycle state of the violation.',
    `violation_type` STRING COMMENT 'Category of the violation based on regulatory domain.',
    CONSTRAINT pk_violation PRIMARY KEY(`violation_id`)
) COMMENT 'Master reference table for violation. Referenced by violation_id.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`compliance`.`bes_facility` (
    `bes_facility_id` BIGINT COMMENT 'Primary key for bes_facility',
    `parent_bes_facility_id` BIGINT COMMENT 'Self-referencing FK on bes_facility (parent_bes_facility_id)',
    `bes_facility_description` STRING COMMENT 'Free‑form text describing the facilitys purpose, characteristics, or notes.',
    `bes_facility_status` STRING COMMENT 'Current operational status of the facility.',
    `capacity_mw` DECIMAL(18,2) COMMENT 'Maximum electrical generation or transmission capacity of the facility in megawatts.',
    `city` STRING COMMENT 'City where the facility is located.',
    `commissioning_date` DATE COMMENT 'Date the facility entered service.',
    `compliance_status` STRING COMMENT 'Current compliance standing of the facility with applicable regulations.',
    `country_code` STRING COMMENT 'ISO‑3166‑1 alpha‑3 country code for the facility location. [ENUM-REF-CANDIDATE: USA|CAN|MEX|GBR|FRA|DEU|CHN|IND|BRA|AUS — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the facility record was first created in the system.',
    `data_source_system` STRING COMMENT 'Name of the source operational system that supplied the facility record.',
    `emission_factor_tco2_per_mwh` DECIMAL(18,2) COMMENT 'Average carbon dioxide emissions per megawatt‑hour produced at the facility.',
    `facility_code` STRING COMMENT 'Unique alphanumeric code assigned to the facility by the enterprise.',
    `facility_name` STRING COMMENT 'Human‑readable name of the facility.',
    `facility_type` STRING COMMENT 'Category of the facility indicating its role in the electric system.',
    `fuel_type` STRING COMMENT 'Primary energy source used by the facility (e.g., coal, gas, solar, wind, hydro, nuclear, biomass, geothermal, other). [ENUM-REF-CANDIDATE: coal|gas|nuclear|solar|wind|hydro|biomass|geothermal|other — promote to reference product]',
    `grid_connection_point` STRING COMMENT 'Identifier of the point where the facility connects to the transmission grid.',
    `inspection_status` STRING COMMENT 'Result of the most recent inspection.',
    `is_critical_infrastructure` BOOLEAN COMMENT 'True if the facility is designated as critical infrastructure under NERC CIP.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory or safety inspection.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the facility in decimal degrees.',
    `location_address` STRING COMMENT 'Physical street address of the facility.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the facility in decimal degrees.',
    `maintenance_contact_email` STRING COMMENT 'Email address of the primary maintenance contact for the facility.',
    `maintenance_contact_phone` STRING COMMENT 'Phone number of the primary maintenance contact for the facility.',
    `operating_company` STRING COMMENT 'Company responsible for day‑to‑day operation of the facility.',
    `owner_organization` STRING COMMENT 'Legal entity that owns the facility.',
    `retirement_date` DATE COMMENT 'Date the facility was permanently taken out of service, if applicable.',
    `state_province` STRING COMMENT 'State or province of the facility location.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the facility record.',
    `voltage_level_kv` DECIMAL(18,2) COMMENT 'Nominal voltage level at which the facility operates.',
    CONSTRAINT pk_bes_facility PRIMARY KEY(`bes_facility_id`)
) COMMENT 'Master reference table for bes_facility. Referenced by bes_facility_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_rate_case_id` FOREIGN KEY (`rate_case_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`rate_case`(`rate_case_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_program_id` FOREIGN KEY (`program_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_nerc_cip_asset_id` FOREIGN KEY (`nerc_cip_asset_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`nerc_cip_asset`(`nerc_cip_asset_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ADD CONSTRAINT `fk_compliance_enforcement_action_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ADD CONSTRAINT `fk_compliance_enforcement_action_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ADD CONSTRAINT `fk_compliance_enforcement_action_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ADD CONSTRAINT `fk_compliance_enforcement_action_primary_enforcement_audit_finding_id` FOREIGN KEY (`primary_enforcement_audit_finding_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ADD CONSTRAINT `fk_compliance_enforcement_action_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_primary_corrective_audit_finding_id` FOREIGN KEY (`primary_corrective_audit_finding_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_regulatory_correspondence_id` FOREIGN KEY (`regulatory_correspondence_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`regulatory_correspondence`(`regulatory_correspondence_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ADD CONSTRAINT `fk_compliance_evidence_record_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ADD CONSTRAINT `fk_compliance_evidence_record_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ADD CONSTRAINT `fk_compliance_evidence_record_enforcement_action_id` FOREIGN KEY (`enforcement_action_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`enforcement_action`(`enforcement_action_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ADD CONSTRAINT `fk_compliance_evidence_record_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ADD CONSTRAINT `fk_compliance_evidence_record_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ADD CONSTRAINT `fk_compliance_evidence_record_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ADD CONSTRAINT `fk_compliance_evidence_record_tertiary_evidence_regulatory_obligation_id` FOREIGN KEY (`tertiary_evidence_regulatory_obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ADD CONSTRAINT `fk_compliance_regulatory_correspondence_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ADD CONSTRAINT `fk_compliance_regulatory_correspondence_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ADD CONSTRAINT `fk_compliance_regulatory_correspondence_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ADD CONSTRAINT `fk_compliance_regulatory_correspondence_rate_case_id` FOREIGN KEY (`rate_case_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`rate_case`(`rate_case_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`nerc_cip_asset` ADD CONSTRAINT `fk_compliance_nerc_cip_asset_bes_facility_id` FOREIGN KEY (`bes_facility_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`bes_facility`(`bes_facility_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`nerc_cip_asset` ADD CONSTRAINT `fk_compliance_nerc_cip_asset_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ADD CONSTRAINT `fk_compliance_emissions_report_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ADD CONSTRAINT `fk_compliance_emissions_report_original_report_emissions_report_id` FOREIGN KEY (`original_report_emissions_report_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`emissions_report`(`emissions_report_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ADD CONSTRAINT `fk_compliance_emissions_report_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ADD CONSTRAINT `fk_compliance_emissions_report_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ADD CONSTRAINT `fk_compliance_environmental_permit_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` ADD CONSTRAINT `fk_compliance_compliance_rec_certificate_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` ADD CONSTRAINT `fk_compliance_compliance_rec_certificate_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`rate_case` ADD CONSTRAINT `fk_compliance_rate_case_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`program` ADD CONSTRAINT `fk_compliance_program_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`training_record` ADD CONSTRAINT `fk_compliance_training_record_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`training_record` ADD CONSTRAINT `fk_compliance_training_record_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`training_record` ADD CONSTRAINT `fk_compliance_training_record_program_id` FOREIGN KEY (`program_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_enforcement_action_id` FOREIGN KEY (`enforcement_action_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`enforcement_action`(`enforcement_action_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`bes_facility` ADD CONSTRAINT `fk_compliance_bes_facility_parent_bes_facility_id` FOREIGN KEY (`parent_bes_facility_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`bes_facility`(`bes_facility_id`);

-- ========= TAGS =========
ALTER SCHEMA `energy_utilities_ecm`.`compliance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `energy_utilities_ecm`.`compliance` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Identifier');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Model Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `applicability_scope` SET TAGS ('dbx_business_glossary_term' = 'Applicability Scope');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `board_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Board Reporting Flag');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `compliance_frequency` SET TAGS ('dbx_business_glossary_term' = 'Compliance Frequency');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|in_progress|not_applicable|under_review|remediation_required');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `control_effectiveness_rating` SET TAGS ('dbx_business_glossary_term' = 'Control Effectiveness Rating');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `control_effectiveness_rating` SET TAGS ('dbx_value_regex' = 'effective|needs_improvement|ineffective|not_assessed');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `enforcement_action_flag` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Flag');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `enforcement_action_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `evidence_collection_method` SET TAGS ('dbx_business_glossary_term' = 'Evidence Collection Method');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `evidence_collection_method` SET TAGS ('dbx_value_regex' = 'automated|manual|hybrid|third_party');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `evidence_retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Evidence Retention Period (Years)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `external_auditor_flag` SET TAGS ('dbx_business_glossary_term' = 'External Auditor Flag');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `governing_body` SET TAGS ('dbx_business_glossary_term' = 'Governing Body');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `last_audit_result` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Result');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `last_audit_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass|not_audited');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `mitigation_plan_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Plan Required Flag');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `mitigation_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Plan Status');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `mitigation_plan_status` SET TAGS ('dbx_value_regex' = 'not_required|planned|in_progress|completed|approved|rejected');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `next_compliance_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Compliance Due Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_category` SET TAGS ('dbx_business_glossary_term' = 'Obligation Category');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_business_glossary_term' = 'Obligation Code');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_description` SET TAGS ('dbx_business_glossary_term' = 'Obligation Description');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_name` SET TAGS ('dbx_business_glossary_term' = 'Obligation Name');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_business_glossary_term' = 'Obligation Type');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `parent_obligation_code` SET TAGS ('dbx_business_glossary_term' = 'Parent Obligation Code');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `penalty_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount (USD)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `penalty_amount_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `reporting_format` SET TAGS ('dbx_business_glossary_term' = 'Reporting Format');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `reporting_format` SET TAGS ('dbx_value_regex' = 'electronic|paper|web_portal|api|email');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `reporting_system` SET TAGS ('dbx_business_glossary_term' = 'Reporting System');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `responsible_role` SET TAGS ('dbx_business_glossary_term' = 'Responsible Role');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `sub_requirement_count` SET TAGS ('dbx_business_glossary_term' = 'Sub-Requirement Count');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `vrf` SET TAGS ('dbx_business_glossary_term' = 'Violation Risk Factor (VRF)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `vrf` SET TAGS ('dbx_value_regex' = 'lower|medium|high');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `vsl` SET TAGS ('dbx_business_glossary_term' = 'Violation Severity Level (VSL)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ALTER COLUMN `vsl` SET TAGS ('dbx_value_regex' = 'lower|moderate|high|severe');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `load_id` SET TAGS ('dbx_business_glossary_term' = 'Load Forecast Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `rate_case_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `commission_order_date` SET TAGS ('dbx_business_glossary_term' = 'Commission Order Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `commission_order_number` SET TAGS ('dbx_business_glossary_term' = 'Commission Order Number');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `cpcn_capital_cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Public Convenience and Necessity (CPCN) Capital Cost Estimate');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `cpcn_capital_cost_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `cpcn_environmental_review_status` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Public Convenience and Necessity (CPCN) Environmental Review Status');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `cpcn_environmental_review_status` SET TAGS ('dbx_value_regex' = 'Not_Started|In_Progress|Completed|Approved|Conditional_Approval');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `cpcn_project_description` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Public Convenience and Necessity (CPCN) Project Description');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `docket_number` SET TAGS ('dbx_business_glossary_term' = 'Docket Number');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Due Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `epa_emissions_report_type` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Emissions Report Type');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `epa_emissions_report_type` SET TAGS ('dbx_value_regex' = 'Annual_Emissions_Inventory|Quarterly_Emissions_Report|CEMS_Data_Submission|GHG_Reporting');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_description` SET TAGS ('dbx_business_glossary_term' = 'Filing Description');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_document_count` SET TAGS ('dbx_business_glossary_term' = 'Filing Document Count');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_number` SET TAGS ('dbx_business_glossary_term' = 'Filing Number');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Period End Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Period Start Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Filing Status');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_type` SET TAGS ('dbx_business_glossary_term' = 'Filing Type');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `intervenor_party_count` SET TAGS ('dbx_business_glossary_term' = 'Intervenor Party Count');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `proposed_rate_change_percent` SET TAGS ('dbx_business_glossary_term' = 'Proposed Rate Change Percentage');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `proposed_rate_change_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `public_hearing_date` SET TAGS ('dbx_business_glossary_term' = 'Public Hearing Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `public_hearing_scheduled_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Hearing Scheduled Flag');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `rate_case_test_year` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Test Year');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_agency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_agency` SET TAGS ('dbx_value_regex' = 'FERC|NERC|EPA|State_PUC|DOE|OSHA');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `rejection_date` SET TAGS ('dbx_business_glossary_term' = 'Rejection Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `responsible_preparer_email` SET TAGS ('dbx_business_glossary_term' = 'Responsible Preparer Email Address');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `responsible_preparer_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `responsible_preparer_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `responsible_preparer_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `responsible_preparer_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Preparer Name');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `revenue_requirement_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Requirement Amount');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `revenue_requirement_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `rps_compliance_year` SET TAGS ('dbx_business_glossary_term' = 'Renewable Portfolio Standard (RPS) Compliance Year');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `rps_rec_retired_count` SET TAGS ('dbx_business_glossary_term' = 'Renewable Portfolio Standard (RPS) Renewable Energy Certificate (REC) Retired Count');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `rps_renewable_energy_mwh` SET TAGS ('dbx_business_glossary_term' = 'Renewable Portfolio Standard (RPS) Renewable Energy Megawatt-Hours (MWh)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'No_Settlement|Settlement_Proposed|Settlement_Approved|Settlement_Rejected');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `spv_discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Self-Reported Potential Violation (SPV) Discovery Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `spv_mitigation_plan` SET TAGS ('dbx_business_glossary_term' = 'Self-Reported Potential Violation (SPV) Mitigation Plan');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `spv_violation_description` SET TAGS ('dbx_business_glossary_term' = 'Self-Reported Potential Violation (SPV) Description');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` SET TAGS ('dbx_subdomain' = 'compliance_auditing');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Identifier');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `der_system_id` SET TAGS ('dbx_business_glossary_term' = 'Der System Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `power_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Power Plant Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Number');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}-[0-9]{4}-[0-9]{4,6}$');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'NERC_CIP|FERC_Market_Behavior|PUC_Service_Quality|SOX_Internal_Controls|EPA_Environmental|Internal_Compliance');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `auditing_body` SET TAGS ('dbx_business_glossary_term' = 'Auditing Body');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `auditing_body_type` SET TAGS ('dbx_business_glossary_term' = 'Auditing Body Type');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `auditing_body_type` SET TAGS ('dbx_value_regex' = 'Federal_Regulator|Regional_Entity|State_Regulator|Internal|External_Firm');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `business_units_audited` SET TAGS ('dbx_business_glossary_term' = 'Business Units Audited');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Closure Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'Public|CEII|Confidential|Privileged');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `corrective_action_plan_approved_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) Approved Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `corrective_action_plan_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) Due Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `corrective_action_plan_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) Submitted Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `critical_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Findings Count');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Audit Disposition');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `disposition` SET TAGS ('dbx_value_regex' = 'Compliant|Non_Compliant_Minor|Non_Compliant_Moderate|Non_Compliant_Severe|Pending_Review');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `draft_report_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Draft Report Issued Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `final_report_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Final Report Issued Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `lead_auditor_email` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor Email Address');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `lead_auditor_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `lead_auditor_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `lead_auditor_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `lead_auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor Name');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `lead_auditor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `lead_auditor_phone` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor Phone Number');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `lead_auditor_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `lead_auditor_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `methodology` SET TAGS ('dbx_business_glossary_term' = 'Audit Methodology');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `methodology` SET TAGS ('dbx_value_regex' = 'On_Site|Remote|Hybrid|Document_Review|Spot_Check');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Period End Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Period Start Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Audit Priority');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'Critical|High|Medium|Low');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `scheduled_end_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `total_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Total Findings Count');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `trigger` SET TAGS ('dbx_business_glossary_term' = 'Audit Trigger');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `trigger` SET TAGS ('dbx_value_regex' = 'Scheduled_Routine|Risk_Based|Incident_Driven|Complaint_Driven|Follow_Up|Self_Report');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `utility_response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Utility Response Due Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ALTER COLUMN `utility_response_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Utility Response Submitted Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` SET TAGS ('dbx_subdomain' = 'compliance_auditing');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `der_system_id` SET TAGS ('dbx_business_glossary_term' = 'Der System Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `generating_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Generating Unit Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `nerc_cip_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Nerc Cip Asset Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `actual_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Penalty Amount');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `actual_penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `affected_customers_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Customers Count');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Name');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `auditor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Responsible Business Unit');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `closed_by` SET TAGS ('dbx_business_glossary_term' = 'Finding Closed By');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `closed_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Finding Closed Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `closure_notes` SET TAGS ('dbx_business_glossary_term' = 'Closure Notes');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Discovery Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `discovery_method` SET TAGS ('dbx_business_glossary_term' = 'Discovery Method');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `escalation_status` SET TAGS ('dbx_business_glossary_term' = 'Escalation Status');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `escalation_status` SET TAGS ('dbx_value_regex' = 'not_escalated|escalated_to_management|escalated_to_board|escalated_to_regulator|self_reported');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `evidence_location` SET TAGS ('dbx_business_glossary_term' = 'Evidence Location');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `evidence_location` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `finding_description` SET TAGS ('dbx_business_glossary_term' = 'Finding Description');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `finding_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Finding Reference Number');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `finding_status` SET TAGS ('dbx_business_glossary_term' = 'Finding Status');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `finding_status` SET TAGS ('dbx_value_regex' = 'open|under_review|remediation_in_progress|pending_verification|closed|escalated');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_business_glossary_term' = 'Finding Type');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `potential_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Potential Penalty Amount');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `potential_penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `previous_finding_reference` SET TAGS ('dbx_business_glossary_term' = 'Previous Finding Reference');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `remediation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Completion Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `remediation_plan` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|verified|overdue');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `repeat_finding_flag` SET TAGS ('dbx_business_glossary_term' = 'Repeat Finding Flag');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `risk_severity` SET TAGS ('dbx_business_glossary_term' = 'Risk Severity');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `risk_severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `self_report_date` SET TAGS ('dbx_business_glossary_term' = 'Self-Report Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `self_report_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Self-Report Reference Number');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `self_report_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Self-Report Required Flag');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `severity_classification` SET TAGS ('dbx_business_glossary_term' = 'Severity Classification');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `severity_classification` SET TAGS ('dbx_value_regex' = 'critical|high|moderate|low|minimal');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ALTER COLUMN `verified_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` SET TAGS ('dbx_subdomain' = 'compliance_auditing');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ALTER COLUMN `enforcement_action_id` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ALTER COLUMN `corrective_action_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Application Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ALTER COLUMN `action_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Issue Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ALTER COLUMN `action_number` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Number');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ALTER COLUMN `action_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Resolution Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ALTER COLUMN `action_status` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Status');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Type');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ALTER COLUMN `alleged_violation_description` SET TAGS ('dbx_business_glossary_term' = 'Alleged Violation Description');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ALTER COLUMN `appeal_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Decision Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ALTER COLUMN `appeal_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ALTER COLUMN `board_notification_flag` SET TAGS ('dbx_business_glossary_term' = 'Board of Directors Notification Flag');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ALTER COLUMN `contested_flag` SET TAGS ('dbx_business_glossary_term' = 'Contested Action Flag');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ALTER COLUMN `cooperation_credit_flag` SET TAGS ('dbx_business_glossary_term' = 'Cooperation Credit Flag');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ALTER COLUMN `external_disclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'External Disclosure Flag');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ALTER COLUMN `final_penalty_assessed` SET TAGS ('dbx_business_glossary_term' = 'Final Penalty Assessed Amount');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ALTER COLUMN `final_penalty_assessed` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ALTER COLUMN `financial_exposure_classification` SET TAGS ('dbx_business_glossary_term' = 'Financial Exposure Classification');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ALTER COLUMN `financial_exposure_classification` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ALTER COLUMN `issuing_agency` SET TAGS ('dbx_business_glossary_term' = 'Issuing Regulatory Agency');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ALTER COLUMN `issuing_agency_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Agency Code');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ALTER COLUMN `mitigation_factors_applied` SET TAGS ('dbx_business_glossary_term' = 'Penalty Mitigation Factors Applied');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Penalty Payment Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Penalty Payment Due Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Penalty Payment Status');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'not_due|pending|paid|overdue|waived|deferred');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ALTER COLUMN `proposed_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Proposed Penalty Amount');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ALTER COLUMN `proposed_penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ALTER COLUMN `public_disclosure_url` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure Uniform Resource Locator (URL)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ALTER COLUMN `regulatory_correspondence_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Correspondence Reference');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ALTER COLUMN `responsible_facility_code` SET TAGS ('dbx_business_glossary_term' = 'Responsible Facility Code');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ALTER COLUMN `self_report_credit_flag` SET TAGS ('dbx_business_glossary_term' = 'Self-Report Credit Flag');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ALTER COLUMN `settlement_flag` SET TAGS ('dbx_business_glossary_term' = 'Settlement Agreement Flag');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ALTER COLUMN `settlement_terms` SET TAGS ('dbx_business_glossary_term' = 'Settlement Agreement Terms');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ALTER COLUMN `settlement_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ALTER COLUMN `violated_standard_code` SET TAGS ('dbx_business_glossary_term' = 'Violated Standard Code');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ALTER COLUMN `violation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Violation Period End Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ALTER COLUMN `violation_severity_level` SET TAGS ('dbx_business_glossary_term' = 'Violation Severity Level (VSL)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ALTER COLUMN `violation_severity_level` SET TAGS ('dbx_value_regex' = 'minimal|lower|moderate|high|severe');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ALTER COLUMN `violation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Violation Period Start Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`corrective_action_plan` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`corrective_action_plan` SET TAGS ('dbx_subdomain' = 'compliance_auditing');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `corrective_action_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) ID');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `der_system_id` SET TAGS ('dbx_business_glossary_term' = 'Der System Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `generating_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Generating Unit Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `primary_corrective_audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Finding ID');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `regulatory_correspondence_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Correspondence Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `board_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Board Reporting Flag');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `cap_number` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) Number');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `cap_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) Status');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `cap_title` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) Title');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completion Percentage');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `corrective_measures` SET TAGS ('dbx_business_glossary_term' = 'Corrective Measures');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `evidence_of_completion` SET TAGS ('dbx_business_glossary_term' = 'Evidence of Completion');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `implementation_status` SET TAGS ('dbx_business_glossary_term' = 'Implementation Status');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `milestone_schedule` SET TAGS ('dbx_business_glossary_term' = 'Milestone Schedule');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `preventive_measures` SET TAGS ('dbx_business_glossary_term' = 'Preventive Measures');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `recurrence_flag` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Flag');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `regulatory_standard` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Standard');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `self_reported_flag` SET TAGS ('dbx_business_glossary_term' = 'Self-Reported Flag');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'Critical|High|Medium|Low');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` SET TAGS ('dbx_subdomain' = 'compliance_auditing');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ALTER COLUMN `evidence_record_id` SET TAGS ('dbx_business_glossary_term' = 'Evidence Record Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ALTER COLUMN `corrective_action_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ALTER COLUMN `der_system_id` SET TAGS ('dbx_business_glossary_term' = 'Der System Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ALTER COLUMN `enforcement_action_id` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ALTER COLUMN `tertiary_evidence_regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ALTER COLUMN `access_restriction_notes` SET TAGS ('dbx_business_glossary_term' = 'Access Restriction Notes');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ALTER COLUMN `cap_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) Closure Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ALTER COLUMN `cap_closure_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) Closure Flag');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ALTER COLUMN `chain_of_custody_status` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody Status');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ALTER COLUMN `chain_of_custody_status` SET TAGS ('dbx_value_regex' = 'intact|transferred|compromised|under_review');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ALTER COLUMN `collection_date` SET TAGS ('dbx_business_glossary_term' = 'Evidence Collection Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ALTER COLUMN `compliance_standard_reference` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard Reference');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ALTER COLUMN `confidentiality_classification` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Classification');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ALTER COLUMN `confidentiality_classification` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ALTER COLUMN `custodian_department` SET TAGS ('dbx_business_glossary_term' = 'Custodian Department');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ALTER COLUMN `custodian_name` SET TAGS ('dbx_business_glossary_term' = 'Custodian Name');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ALTER COLUMN `custodian_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ALTER COLUMN `digital_hash` SET TAGS ('dbx_business_glossary_term' = 'Digital Hash');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ALTER COLUMN `evidence_description` SET TAGS ('dbx_business_glossary_term' = 'Evidence Description');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ALTER COLUMN `evidence_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Evidence Period End Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ALTER COLUMN `evidence_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Evidence Period Start Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ALTER COLUMN `evidence_status` SET TAGS ('dbx_business_glossary_term' = 'Evidence Status');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ALTER COLUMN `evidence_status` SET TAGS ('dbx_value_regex' = 'collected|under_review|validated|rejected|archived');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ALTER COLUMN `evidence_title` SET TAGS ('dbx_business_glossary_term' = 'Evidence Title');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ALTER COLUMN `evidence_type` SET TAGS ('dbx_business_glossary_term' = 'Evidence Type');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ALTER COLUMN `evidence_type` SET TAGS ('dbx_value_regex' = 'access_control_log|maintenance_record|training_certificate|transaction_log|stack_test_result|control_test_documentation');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size in Bytes');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ALTER COLUMN `legal_hold_case_reference` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Case Reference');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ALTER COLUMN `legal_hold_case_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Flag');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_value_regex' = 'NERC_CIP|FERC|EPA|SOX|PUC|OSHA');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ALTER COLUMN `retention_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiration Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period in Years');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ALTER COLUMN `source_system_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Record Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ALTER COLUMN `storage_location_reference` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Reference');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ALTER COLUMN `storage_location_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ALTER COLUMN `submission_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Submission Reference Number');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ALTER COLUMN `submitted_to_organization` SET TAGS ('dbx_business_glossary_term' = 'Submitted To Organization');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ALTER COLUMN `validation_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ALTER COLUMN `validation_notes` SET TAGS ('dbx_business_glossary_term' = 'Validation Notes');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ALTER COLUMN `regulatory_correspondence_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Correspondence Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Related Audit Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Related Filing Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ALTER COLUMN `rate_case_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ALTER COLUMN `agency_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Agency Contact Email Address');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ALTER COLUMN `agency_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ALTER COLUMN `agency_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ALTER COLUMN `agency_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ALTER COLUMN `agency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Agency Contact Person Name');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ALTER COLUMN `agency_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ALTER COLUMN `agency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Agency Contact Phone Number');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ALTER COLUMN `agency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ALTER COLUMN `agency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ALTER COLUMN `attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Attachment Count');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ALTER COLUMN `board_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Board Notification Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ALTER COLUMN `board_notification_flag` SET TAGS ('dbx_business_glossary_term' = 'Board Notification Flag');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Closure Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ALTER COLUMN `closure_notes` SET TAGS ('dbx_business_glossary_term' = 'Closure Notes');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ALTER COLUMN `confidentiality_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Flag');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ALTER COLUMN `correspondence_category` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Category');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ALTER COLUMN `correspondence_number` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Reference Number');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ALTER COLUMN `correspondence_summary` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Summary');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ALTER COLUMN `correspondence_type` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Direction Type');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ALTER COLUMN `correspondence_type` SET TAGS ('dbx_value_regex' = 'inbound|outbound');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ALTER COLUMN `date_received` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Received Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ALTER COLUMN `date_sent` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Sent Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ALTER COLUMN `docket_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Docket Number');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ALTER COLUMN `document_storage_location` SET TAGS ('dbx_business_glossary_term' = 'Document Storage Location');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ALTER COLUMN `follow_up_due_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Due Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ALTER COLUMN `follow_up_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ALTER COLUMN `legal_review_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Completed Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ALTER COLUMN `legal_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Required Flag');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Priority Level');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ALTER COLUMN `proceeding_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Proceeding Name');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ALTER COLUMN `regulatory_agency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency Name');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ALTER COLUMN `regulatory_agency` SET TAGS ('dbx_value_regex' = 'NERC|FERC|PUC|EPA|DOE|OSHA');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ALTER COLUMN `responding_department` SET TAGS ('dbx_business_glossary_term' = 'Responding Department Name');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ALTER COLUMN `response_acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Response Acknowledgment Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ALTER COLUMN `response_status` SET TAGS ('dbx_business_glossary_term' = 'Response Status');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ALTER COLUMN `response_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|overdue|not_required');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ALTER COLUMN `response_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Response Submitted Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_correspondence` ALTER COLUMN `subject_matter` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Subject Matter');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`nerc_cip_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`nerc_cip_asset` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`nerc_cip_asset` ALTER COLUMN `nerc_cip_asset_id` SET TAGS ('dbx_business_glossary_term' = 'NERC CIP (Critical Infrastructure Protection) Asset ID');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`nerc_cip_asset` ALTER COLUMN `bes_facility_id` SET TAGS ('dbx_business_glossary_term' = 'BES (Bulk Electric System) Facility ID');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`nerc_cip_asset` ALTER COLUMN `control_center_id` SET TAGS ('dbx_business_glossary_term' = 'Control Center ID');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`nerc_cip_asset` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`nerc_cip_asset` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`nerc_cip_asset` ALTER COLUMN `asset_function` SET TAGS ('dbx_business_glossary_term' = 'Asset Function');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`nerc_cip_asset` ALTER COLUMN `asset_identifier` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`nerc_cip_asset` ALTER COLUMN `asset_location` SET TAGS ('dbx_business_glossary_term' = 'Asset Location');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`nerc_cip_asset` ALTER COLUMN `asset_location` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`nerc_cip_asset` ALTER COLUMN `asset_location` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`nerc_cip_asset` ALTER COLUMN `asset_owner_organization` SET TAGS ('dbx_business_glossary_term' = 'Asset Owner Organization');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`nerc_cip_asset` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Type');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`nerc_cip_asset` ALTER COLUMN `audit_trail_retention_days` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Retention Days');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`nerc_cip_asset` ALTER COLUMN `bes_cyber_system_categorization` SET TAGS ('dbx_business_glossary_term' = 'BES (Bulk Electric System) Cyber System Categorization');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`nerc_cip_asset` ALTER COLUMN `bes_cyber_system_categorization` SET TAGS ('dbx_value_regex' = 'BES Cyber System|BES Cyber Asset|Electronic Access Point|Physical Access Control System|Protected Cyber Asset|Non-BES Cyber System');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`nerc_cip_asset` ALTER COLUMN `cip_impact_rating` SET TAGS ('dbx_business_glossary_term' = 'CIP (Critical Infrastructure Protection) Impact Rating');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`nerc_cip_asset` ALTER COLUMN `cip_impact_rating` SET TAGS ('dbx_value_regex' = 'High|Medium|Low');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`nerc_cip_asset` ALTER COLUMN `cip_status` SET TAGS ('dbx_business_glossary_term' = 'CIP (Critical Infrastructure Protection) Status');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`nerc_cip_asset` ALTER COLUMN `cip_status` SET TAGS ('dbx_value_regex' = 'In Scope|Out of Scope|Pending Assessment|Decommissioned|Retired');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`nerc_cip_asset` ALTER COLUMN `cip_version` SET TAGS ('dbx_business_glossary_term' = 'CIP (Critical Infrastructure Protection) Standard Version');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`nerc_cip_asset` ALTER COLUMN `configuration_change_management_required` SET TAGS ('dbx_business_glossary_term' = 'Configuration Change Management Required');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`nerc_cip_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`nerc_cip_asset` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`nerc_cip_asset` ALTER COLUMN `dial_up_connectivity` SET TAGS ('dbx_business_glossary_term' = 'Dial-Up Connectivity');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`nerc_cip_asset` ALTER COLUMN `external_connectivity` SET TAGS ('dbx_business_glossary_term' = 'External Connectivity');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`nerc_cip_asset` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`nerc_cip_asset` ALTER COLUMN `in_service_date` SET TAGS ('dbx_business_glossary_term' = 'In-Service Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`nerc_cip_asset` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP (Internet Protocol) Address');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`nerc_cip_asset` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`nerc_cip_asset` ALTER COLUMN `last_cip_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last CIP (Critical Infrastructure Protection) Assessment Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`nerc_cip_asset` ALTER COLUMN `last_patch_date` SET TAGS ('dbx_business_glossary_term' = 'Last Patch Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`nerc_cip_asset` ALTER COLUMN `last_vulnerability_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Vulnerability Assessment Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`nerc_cip_asset` ALTER COLUMN `mac_address` SET TAGS ('dbx_business_glossary_term' = 'MAC (Media Access Control) Address');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`nerc_cip_asset` ALTER COLUMN `mac_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`nerc_cip_asset` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`nerc_cip_asset` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`nerc_cip_asset` ALTER COLUMN `network_zone` SET TAGS ('dbx_business_glossary_term' = 'Network Zone');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`nerc_cip_asset` ALTER COLUMN `next_cip_assessment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next CIP (Critical Infrastructure Protection) Assessment Due Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`nerc_cip_asset` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`nerc_cip_asset` ALTER COLUMN `removable_media_controls_required` SET TAGS ('dbx_business_glossary_term' = 'Removable Media Controls Required');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`nerc_cip_asset` ALTER COLUMN `routable_protocol_enabled` SET TAGS ('dbx_business_glossary_term' = 'Routable Protocol Enabled');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`nerc_cip_asset` ALTER COLUMN `transient_cyber_asset` SET TAGS ('dbx_business_glossary_term' = 'Transient Cyber Asset');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`nerc_cip_asset` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`nerc_cip_asset` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ALTER COLUMN `emissions_report_id` SET TAGS ('dbx_business_glossary_term' = 'Emissions Report ID');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ALTER COLUMN `generating_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Generating Unit Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ALTER COLUMN `generation_forecast_interval_id` SET TAGS ('dbx_business_glossary_term' = 'Generation Forecast Interval Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ALTER COLUMN `original_report_emissions_report_id` SET TAGS ('dbx_business_glossary_term' = 'Original Report ID');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ALTER COLUMN `power_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ALTER COLUMN `allowances_held` SET TAGS ('dbx_business_glossary_term' = 'Allowances Held');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ALTER COLUMN `allowances_used` SET TAGS ('dbx_business_glossary_term' = 'Allowances Used');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ALTER COLUMN `amendment_indicator` SET TAGS ('dbx_business_glossary_term' = 'Amendment Indicator');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ALTER COLUMN `amendment_reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ALTER COLUMN `applicable_emission_limit` SET TAGS ('dbx_business_glossary_term' = 'Applicable Emission Limit');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ALTER COLUMN `authorized_representative_name` SET TAGS ('dbx_business_glossary_term' = 'Authorized Representative Name');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ALTER COLUMN `authorized_representative_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ALTER COLUMN `cems_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Continuous Emissions Monitoring System (CEMS) Certification Status');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ALTER COLUMN `cems_certification_status` SET TAGS ('dbx_value_regex' = 'Certified|Provisional|Decertified|Not Applicable');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ALTER COLUMN `compliance_margin` SET TAGS ('dbx_business_glossary_term' = 'Compliance Margin');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'Compliant|Non-Compliant|Pending Review|Conditional');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ALTER COLUMN `data_quality_indicator` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Indicator');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ALTER COLUMN `data_quality_indicator` SET TAGS ('dbx_value_regex' = 'Verified|Estimated|Provisional|Incomplete');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ALTER COLUMN `emission_rate` SET TAGS ('dbx_business_glossary_term' = 'Emission Rate');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ALTER COLUMN `emission_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Emission Unit of Measure');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ALTER COLUMN `emission_unit_of_measure` SET TAGS ('dbx_value_regex' = 'tons|pounds|kilograms');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ALTER COLUMN `exceedance_reason` SET TAGS ('dbx_business_glossary_term' = 'Exceedance Reason');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ALTER COLUMN `gross_generation_mwh` SET TAGS ('dbx_business_glossary_term' = 'Gross Generation Megawatt-Hours (MWh)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ALTER COLUMN `heat_input_mmbtu` SET TAGS ('dbx_business_glossary_term' = 'Heat Input Million British Thermal Units (MMBtu)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ALTER COLUMN `measured_emission_quantity` SET TAGS ('dbx_business_glossary_term' = 'Measured Emission Quantity');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ALTER COLUMN `monitoring_methodology` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Methodology');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ALTER COLUMN `monitoring_methodology` SET TAGS ('dbx_value_regex' = 'CEMS|PEMS|Alternative|Fuel Sampling|Mass Balance');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ALTER COLUMN `operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ALTER COLUMN `orispl_code` SET TAGS ('dbx_business_glossary_term' = 'Office of Regulatory Information Systems Plant Location (ORISPL) Code');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ALTER COLUMN `pollutant_type` SET TAGS ('dbx_business_glossary_term' = 'Pollutant Type');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ALTER COLUMN `pollutant_type` SET TAGS ('dbx_value_regex' = 'SO2|NOx|CO2|Mercury|PM2.5|PM10');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ALTER COLUMN `qa_qc_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance Quality Control (QA/QC) Completion Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ALTER COLUMN `report_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Report Submission Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ALTER COLUMN `submission_status` SET TAGS ('dbx_value_regex' = 'Draft|Submitted|Accepted|Rejected|Under Review|Amended');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `environmental_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Identifier');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `power_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Permitted Facility ID');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Permit Appeal Status');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'no_appeal|appeal_pending|appeal_resolved|appeal_upheld');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Effective Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `enforcement_action_flag` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Flag');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Expiration Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `facility_epa_code` SET TAGS ('dbx_business_glossary_term' = 'Facility EPA (Environmental Protection Agency) Identification Number');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `facility_name` SET TAGS ('dbx_business_glossary_term' = 'Permitted Facility Name');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `issuance_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Issuance Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `issuing_agency` SET TAGS ('dbx_business_glossary_term' = 'Issuing Regulatory Agency');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `issuing_agency_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Issuing Agency Jurisdiction Level');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `issuing_agency_jurisdiction` SET TAGS ('dbx_value_regex' = 'federal|state|local');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Regulatory Inspection Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `last_inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Result');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `last_inspection_result` SET TAGS ('dbx_value_regex' = 'compliant|minor_violation|major_violation|not_applicable');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Environmental Monitoring Frequency');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_value_regex' = 'continuous|daily|weekly|monthly|quarterly|annual');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Permit Management Notes');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `permit_conditions_summary` SET TAGS ('dbx_business_glossary_term' = 'Permit Conditions Summary');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `permit_document_url` SET TAGS ('dbx_business_glossary_term' = 'Permit Document URL (Uniform Resource Locator)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `permit_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Permit Fee Amount');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `permit_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Permit Fee Currency Code');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `permit_fee_currency` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Number');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `permit_status` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Status');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `permit_status` SET TAGS ('dbx_value_regex' = 'active|expired|pending_renewal|suspended|revoked|under_review');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `permit_type` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Type');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `permit_type` SET TAGS ('dbx_value_regex' = 'title_v_air|npdes_water_discharge|rcra_hazardous_waste|state_air_quality|state_water_quality|stormwater');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `permitted_discharge_limit_gallons_per_day` SET TAGS ('dbx_business_glossary_term' = 'Permitted Discharge Limit (Gallons Per Day)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `permitted_emission_limit_tons_per_year` SET TAGS ('dbx_business_glossary_term' = 'Permitted Emission Limit (Tons Per Year)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `public_comment_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Public Comment Period End Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `public_notice_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Notice Flag');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `regulated_pollutants` SET TAGS ('dbx_business_glossary_term' = 'Regulated Pollutants List');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `renewal_application_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Application Submission Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Permit Renewal Status');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `renewal_status` SET TAGS ('dbx_value_regex' = 'not_required|renewal_pending|renewal_submitted|renewal_approved|renewal_denied');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Frequency');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `responsible_party_email` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Email Address');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `responsible_party_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `responsible_party_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `responsible_party_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `responsible_party_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Name');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `responsible_party_phone` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Phone Number');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `responsible_party_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `responsible_party_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `responsible_party_title` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Title');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `special_conditions_flag` SET TAGS ('dbx_business_glossary_term' = 'Special Conditions Flag');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ALTER COLUMN `violation_count` SET TAGS ('dbx_business_glossary_term' = 'Permit Violation Count');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` ALTER COLUMN `compliance_rec_certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Renewable Energy Certificate (REC) Certificate ID');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` ALTER COLUMN `forecast_renewable_id` SET TAGS ('dbx_business_glossary_term' = 'Renewable Forecast Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` ALTER COLUMN `ppa_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` ALTER COLUMN `ppa_contract_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` ALTER COLUMN `power_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Generation Facility ID');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` ALTER COLUMN `certificate_status` SET TAGS ('dbx_business_glossary_term' = 'REC Certificate Status');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` ALTER COLUMN `certificate_status` SET TAGS ('dbx_value_regex' = 'active|retired|expired|transferred|cancelled|pending');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` ALTER COLUMN `compliance_credit_mwh` SET TAGS ('dbx_business_glossary_term' = 'Compliance Credit Megawatt-Hours (MWh)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` ALTER COLUMN `current_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Current Owner Name');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` ALTER COLUMN `current_owner_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` ALTER COLUMN `eligibility_flags` SET TAGS ('dbx_business_glossary_term' = 'RPS Eligibility Flags');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` ALTER COLUMN `emissions_avoided_co2_tons` SET TAGS ('dbx_business_glossary_term' = 'Emissions Avoided Carbon Dioxide (CO2) Tons');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` ALTER COLUMN `energy_quantity_mwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Quantity Megawatt-Hours (MWh)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'REC Expiration Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` ALTER COLUMN `facility_location_country` SET TAGS ('dbx_business_glossary_term' = 'Facility Location Country');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` ALTER COLUMN `facility_location_country` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` ALTER COLUMN `facility_location_state` SET TAGS ('dbx_business_glossary_term' = 'Facility Location State');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` ALTER COLUMN `generation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Generation End Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` ALTER COLUMN `generation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Generation Start Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` ALTER COLUMN `generation_technology_type` SET TAGS ('dbx_business_glossary_term' = 'Generation Technology Type');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` ALTER COLUMN `generation_vintage_month` SET TAGS ('dbx_business_glossary_term' = 'Generation Vintage Month');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` ALTER COLUMN `generation_vintage_year` SET TAGS ('dbx_business_glossary_term' = 'Generation Vintage Year');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` ALTER COLUMN `issuance_date` SET TAGS ('dbx_business_glossary_term' = 'REC Issuance Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` ALTER COLUMN `last_transfer_date` SET TAGS ('dbx_business_glossary_term' = 'Last Transfer Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'REC Certificate Notes');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` ALTER COLUMN `original_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Original Owner Name');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` ALTER COLUMN `purchase_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Purchase Currency Code');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` ALTER COLUMN `purchase_currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` ALTER COLUMN `purchase_price_per_rec` SET TAGS ('dbx_business_glossary_term' = 'Purchase Price Per REC');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` ALTER COLUMN `purchase_price_per_rec` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` ALTER COLUMN `rec_multiplier` SET TAGS ('dbx_business_glossary_term' = 'REC Multiplier');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` ALTER COLUMN `rec_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Serial Number');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` ALTER COLUMN `registry_name` SET TAGS ('dbx_business_glossary_term' = 'REC Registry Name');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'REC Retirement Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` ALTER COLUMN `retirement_reason` SET TAGS ('dbx_business_glossary_term' = 'REC Retirement Reason');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` ALTER COLUMN `retirement_reason` SET TAGS ('dbx_value_regex' = 'RPS compliance|voluntary|contractual obligation|marketing claim|other');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` ALTER COLUMN `rps_compliance_year` SET TAGS ('dbx_business_glossary_term' = 'Renewable Portfolio Standard (RPS) Compliance Year');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` ALTER COLUMN `rps_tier` SET TAGS ('dbx_business_glossary_term' = 'RPS Tier Classification');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` ALTER COLUMN `rps_tier` SET TAGS ('dbx_value_regex' = 'Tier 1|Tier 2|Solar|Main Tier|Alternative Compliance|Other');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` ALTER COLUMN `transfer_count` SET TAGS ('dbx_business_glossary_term' = 'Transfer Count');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`rate_case` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`rate_case` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`rate_case` ALTER COLUMN `rate_case_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Identifier');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`rate_case` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`rate_case` ALTER COLUMN `administrative_law_judge` SET TAGS ('dbx_business_glossary_term' = 'Administrative Law Judge (ALJ) Name');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`rate_case` ALTER COLUMN `approved_rate_increase_percent` SET TAGS ('dbx_business_glossary_term' = 'Approved Rate Increase Percentage');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`rate_case` ALTER COLUMN `case_description` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Description');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`rate_case` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Lifecycle Status');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`rate_case` ALTER COLUMN `case_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Type');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`rate_case` ALTER COLUMN `case_type` SET TAGS ('dbx_value_regex' = 'general_rate_case|transmission_rate_case|distribution_rate_case|fuel_adjustment_clause|decoupling_mechanism|formula_rate');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`rate_case` ALTER COLUMN `commission_staff_analyst` SET TAGS ('dbx_business_glossary_term' = 'Commission Staff Analyst Name');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`rate_case` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Effective Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`rate_case` ALTER COLUMN `evidentiary_hearing_end_date` SET TAGS ('dbx_business_glossary_term' = 'Evidentiary Hearing End Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`rate_case` ALTER COLUMN `evidentiary_hearing_start_date` SET TAGS ('dbx_business_glossary_term' = 'Evidentiary Hearing Start Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`rate_case` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Filing Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`rate_case` ALTER COLUMN `filing_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Filing Jurisdiction Code');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`rate_case` ALTER COLUMN `filing_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}$');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`rate_case` ALTER COLUMN `final_order_date` SET TAGS ('dbx_business_glossary_term' = 'Final Commission Order Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`rate_case` ALTER COLUMN `initial_brief_due_date` SET TAGS ('dbx_business_glossary_term' = 'Initial Brief Due Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`rate_case` ALTER COLUMN `intervenor_count` SET TAGS ('dbx_business_glossary_term' = 'Intervenor Party Count');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`rate_case` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Notes');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`rate_case` ALTER COLUMN `prehearing_conference_date` SET TAGS ('dbx_business_glossary_term' = 'Prehearing Conference Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`rate_case` ALTER COLUMN `proposed_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Proposed Decision Issuance Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`rate_case` ALTER COLUMN `proposed_rate_increase_percent` SET TAGS ('dbx_business_glossary_term' = 'Proposed Rate Increase Percentage');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`rate_case` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`rate_case` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`rate_case` ALTER COLUMN `regulatory_affairs_manager` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Affairs Manager Name');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`rate_case` ALTER COLUMN `rehearing_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Rehearing Decision Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`rate_case` ALTER COLUMN `rehearing_request_date` SET TAGS ('dbx_business_glossary_term' = 'Rehearing Request Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`rate_case` ALTER COLUMN `rehearing_requested_flag` SET TAGS ('dbx_business_glossary_term' = 'Rehearing Requested Flag');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`rate_case` ALTER COLUMN `reply_brief_due_date` SET TAGS ('dbx_business_glossary_term' = 'Reply Brief Due Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`rate_case` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Agreement Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`rate_case` ALTER COLUMN `settlement_flag` SET TAGS ('dbx_business_glossary_term' = 'Settlement Agreement Flag');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`rate_case` ALTER COLUMN `suspension_period_days` SET TAGS ('dbx_business_glossary_term' = 'Rate Suspension Period Days');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`rate_case` ALTER COLUMN `test_year_end_date` SET TAGS ('dbx_business_glossary_term' = 'Test Year End Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`rate_case` ALTER COLUMN `test_year_start_date` SET TAGS ('dbx_business_glossary_term' = 'Test Year Start Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`program` SET TAGS ('dbx_subdomain' = 'compliance_auditing');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`program` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Identifier');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`program` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`program` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`program` ALTER COLUMN `assessment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Assessment Required Flag');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`program` ALTER COLUMN `audit_frequency` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`program` ALTER COLUMN `audit_frequency` SET TAGS ('dbx_value_regex' = 'annual|biennial|triennial|quarterly|as_needed|continuous');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`program` ALTER COLUMN `board_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Board Reporting Flag');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`program` ALTER COLUMN `board_reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Board Reporting Frequency');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`program` ALTER COLUMN `board_reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|as_needed');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`program` ALTER COLUMN `budget_usd` SET TAGS ('dbx_business_glossary_term' = 'Program Budget United States Dollars (USD)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`program` ALTER COLUMN `budget_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`program` ALTER COLUMN `certification_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Issued Flag');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`program` ALTER COLUMN `certification_validity_period_months` SET TAGS ('dbx_business_glossary_term' = 'Certification Validity Period Months');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`program` ALTER COLUMN `charter_date` SET TAGS ('dbx_business_glossary_term' = 'Charter Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`program` ALTER COLUMN `document_repository_location` SET TAGS ('dbx_business_glossary_term' = 'Document Repository Location');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`program` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`program` ALTER COLUMN `effectiveness_rating` SET TAGS ('dbx_business_glossary_term' = 'Program Effectiveness Rating');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`program` ALTER COLUMN `effectiveness_rating` SET TAGS ('dbx_value_regex' = 'highly_effective|effective|needs_improvement|ineffective|not_rated');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`program` ALTER COLUMN `evidence_retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Evidence Retention Period Years');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`program` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`program` ALTER COLUMN `external_auditor_flag` SET TAGS ('dbx_business_glossary_term' = 'External Auditor Flag');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`program` ALTER COLUMN `issuing_regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Issuing Regulatory Body');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`program` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`program` ALTER COLUMN `last_audit_result` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Result');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`program` ALTER COLUMN `last_audit_result` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|compliant_with_findings|not_audited');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`program` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`program` ALTER COLUMN `minimum_passing_score_pct` SET TAGS ('dbx_business_glossary_term' = 'Minimum Passing Score Percentage');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`program` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`program` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Program Notes');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`program` ALTER COLUMN `owner_title` SET TAGS ('dbx_business_glossary_term' = 'Program Owner Title');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`program` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`program` ALTER COLUMN `program_description` SET TAGS ('dbx_business_glossary_term' = 'Program Description');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_development|suspended|retired');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'regulatory|statutory|voluntary|contractual|internal_policy');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`program` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`program` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`program` ALTER COLUMN `scope_of_applicability` SET TAGS ('dbx_business_glossary_term' = 'Scope of Applicability');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`program` ALTER COLUMN `training_completion_threshold_pct` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Threshold Percentage');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`program` ALTER COLUMN `training_frequency` SET TAGS ('dbx_business_glossary_term' = 'Training Frequency');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`program` ALTER COLUMN `training_frequency` SET TAGS ('dbx_value_regex' = 'annual|biennial|quarterly|one_time|as_needed|continuous');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`program` ALTER COLUMN `training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`program` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`training_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`training_record` SET TAGS ('dbx_subdomain' = 'compliance_auditing');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`training_record` ALTER COLUMN `training_record_id` SET TAGS ('dbx_business_glossary_term' = 'Training Record Identifier');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`training_record` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`training_record` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation ID');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`training_record` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`training_record` ALTER COLUMN `actual_time_spent_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Time Spent Hours');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`training_record` ALTER COLUMN `assessment_passed_flag` SET TAGS ('dbx_business_glossary_term' = 'Assessment Passed Flag');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`training_record` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`training_record` ALTER COLUMN `assigned_by_user` SET TAGS ('dbx_business_glossary_term' = 'Assigned By User');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`training_record` ALTER COLUMN `assigned_date` SET TAGS ('dbx_business_glossary_term' = 'Assigned Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`training_record` ALTER COLUMN `attempt_number` SET TAGS ('dbx_business_glossary_term' = 'Attempt Number');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`training_record` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`training_record` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`training_record` ALTER COLUMN `certification_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Issue Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`training_record` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`training_record` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`training_record` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Completion Status');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`training_record` ALTER COLUMN `completion_status` SET TAGS ('dbx_value_regex' = 'Not Started|In Progress|Completed|Failed|Overdue|Waived');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`training_record` ALTER COLUMN `compliance_year` SET TAGS ('dbx_business_glossary_term' = 'Compliance Year');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`training_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`training_record` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`training_record` ALTER COLUMN `facility_code` SET TAGS ('dbx_business_glossary_term' = 'Facility Code');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`training_record` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`training_record` ALTER COLUMN `nerc_cip_role_flag` SET TAGS ('dbx_business_glossary_term' = 'NERC CIP (Critical Infrastructure Protection) Role Flag');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`training_record` ALTER COLUMN `passing_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Threshold');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`training_record` ALTER COLUMN `personnel_role` SET TAGS ('dbx_business_glossary_term' = 'Personnel Role');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`training_record` ALTER COLUMN `recertification_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Recertification Frequency Months');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`training_record` ALTER COLUMN `recertification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Recertification Required Flag');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`training_record` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`training_record` ALTER COLUMN `training_assignment_number` SET TAGS ('dbx_business_glossary_term' = 'Training Assignment Number');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`training_record` ALTER COLUMN `training_assignment_number` SET TAGS ('dbx_value_regex' = '^TRN-[0-9]{10}$');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`training_record` ALTER COLUMN `training_category` SET TAGS ('dbx_business_glossary_term' = 'Training Category');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`training_record` ALTER COLUMN `training_category` SET TAGS ('dbx_value_regex' = 'NERC CIP|FERC Standards of Conduct|OSHA Safety|Environmental Compliance|SOX Ethics|Cybersecurity');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`training_record` ALTER COLUMN `training_course_code` SET TAGS ('dbx_business_glossary_term' = 'Training Course Code');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`training_record` ALTER COLUMN `training_course_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3,6}-[0-9]{3,4}$');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`training_record` ALTER COLUMN `training_course_name` SET TAGS ('dbx_business_glossary_term' = 'Training Course Name');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`training_record` ALTER COLUMN `training_delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Training Delivery Method');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`training_record` ALTER COLUMN `training_delivery_method` SET TAGS ('dbx_value_regex' = 'Instructor-Led|E-Learning|Webinar|On-the-Job|Blended|Self-Study');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`training_record` ALTER COLUMN `training_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Duration Hours');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`training_record` ALTER COLUMN `training_notes` SET TAGS ('dbx_business_glossary_term' = 'Training Notes');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`training_record` ALTER COLUMN `training_type` SET TAGS ('dbx_business_glossary_term' = 'Training Type');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`training_record` ALTER COLUMN `training_type` SET TAGS ('dbx_value_regex' = 'Initial|Refresher|Recertification|Remedial|Ad-Hoc');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`training_record` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`training_record` ALTER COLUMN `waiver_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approval Date');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`training_record` ALTER COLUMN `waiver_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approved By');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`training_record` ALTER COLUMN `waiver_granted_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver Granted Flag');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`training_record` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`violation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`violation` SET TAGS ('dbx_subdomain' = 'compliance_auditing');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`violation` ALTER COLUMN `violation_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Identifier');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`violation` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`violation` ALTER COLUMN `enforcement_action_id` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`violation` ALTER COLUMN `generating_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Generating Unit Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`violation` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Application Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`violation` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`violation` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`violation` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`bes_facility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`bes_facility` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`bes_facility` ALTER COLUMN `bes_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Bes Facility Identifier');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`bes_facility` ALTER COLUMN `parent_bes_facility_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`bes_facility` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`bes_facility` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`bes_facility` ALTER COLUMN `location_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`bes_facility` ALTER COLUMN `location_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`bes_facility` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`bes_facility` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`bes_facility` ALTER COLUMN `maintenance_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`bes_facility` ALTER COLUMN `maintenance_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`bes_facility` ALTER COLUMN `maintenance_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `energy_utilities_ecm`.`compliance`.`bes_facility` ALTER COLUMN `maintenance_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
