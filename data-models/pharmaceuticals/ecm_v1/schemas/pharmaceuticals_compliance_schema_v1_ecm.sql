-- Schema for Domain: compliance | Business: Pharmaceuticals | Version: v1_ecm
-- Generated on: 2026-05-05 17:50:33

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `pharmaceuticals_ecm`.`compliance` COMMENT 'Manages enterprise-wide GxP compliance programs, regulatory inspection readiness, SOX controls, data integrity (ALCOA+), and cross-functional compliance monitoring including 21 CFR Part 11, EU Annex 11, and GDPR obligations';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` (
    `gxp_obligation_id` BIGINT COMMENT 'Unique identifier for the GxP regulatory obligation record. Primary key.',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: GxP obligations are jurisdiction-specific (FDA for US, EMA for EU). ICH regions have harmonized requirements. Essential for global compliance strategy, market entry planning, regulatory intelligence. ',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: GxP obligations are scoped to specific legal entities (manufacturing subsidiaries, research organizations). Regulatory inspections and compliance programs require entity-level obligation tracking for ',
    `material_id` BIGINT COMMENT 'Foreign key linking to masterdata.material. Business justification: Controlled substances and hazardous materials have specific GxP obligations (DEA registration, hazmat handling). Obligations vary by material classification. Required for regulatory compliance, materi',
    `plant_id` BIGINT COMMENT 'Foreign key linking to masterdata.plant. Business justification: GxP obligations vary by plant type (API manufacturing, sterile fill-finish). GMP requirements differ by product and process. Essential for site-specific compliance planning, inspection readiness, and ',
    `parent_gxp_obligation_id` BIGINT COMMENT 'Self-referencing FK on gxp_obligation (parent_gxp_obligation_id)',
    `applicable_functions` STRING COMMENT 'Comma-separated list of business functions to which this obligation applies (e.g., Quality Assurance, Manufacturing, Clinical Operations, Pharmacovigilance).',
    `applicable_products` STRING COMMENT 'Comma-separated list of product codes, therapeutic areas, or product families to which this obligation applies. Null if not product-specific.',
    `applicable_scope` STRING COMMENT 'The organizational scope to which this obligation applies: Enterprise-wide (all sites and functions), Site-specific (particular manufacturing or R&D sites), Function-specific (e.g., Quality, Clinical), Product-specific (certain drug products or therapeutic areas), or Process-specific (particular manufacturing or testing processes).. Valid values are `Enterprise-wide|Site-specific|Function-specific|Product-specific|Process-specific`',
    `applicable_sites` STRING COMMENT 'Comma-separated list of site codes or names where this obligation applies. Null if scope is enterprise-wide or not site-specific.',
    `audit_trail_required` BOOLEAN COMMENT 'Boolean indicator of whether systems or processes supporting this obligation must maintain complete audit trails of all activities and changes.',
    `capa_required` BOOLEAN COMMENT 'Boolean indicator of whether non-compliance with this obligation triggers mandatory CAPA (Corrective and Preventive Action) procedures.',
    `change_control_required` BOOLEAN COMMENT 'Boolean indicator of whether changes affecting this obligation must go through formal change control procedures.',
    `compliance_status` STRING COMMENT 'Current assessment of the organizations compliance with this obligation: Compliant (fully meeting requirements), Non-Compliant (not meeting requirements), Partially Compliant (meeting some but not all requirements), Not Assessed (no assessment performed yet), or Remediation in Progress (corrective actions underway).. Valid values are `Compliant|Non-Compliant|Partially Compliant|Not Assessed|Remediation in Progress`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this obligation record was first created in the system.',
    `data_integrity_requirement` BOOLEAN COMMENT 'Boolean indicator of whether this obligation includes specific data integrity requirements under ALCOA+ principles (Attributable, Legible, Contemporaneous, Original, Accurate, Complete, Consistent, Enduring, Available).',
    `documentation_retention_years` STRING COMMENT 'The minimum number of years that documentation related to this obligation must be retained, as mandated by regulation or internal policy.',
    `effective_date` DATE COMMENT 'The date on which this obligation became or will become enforceable for the organization.',
    `electronic_records_requirement` BOOLEAN COMMENT 'Boolean indicator of whether this obligation mandates compliance with electronic records and electronic signatures regulations (21 CFR Part 11, EU Annex 11).',
    `expiration_date` DATE COMMENT 'The date on which this obligation ceases to be enforceable, if applicable. Null for obligations with no defined end date.',
    `gdpr_applicability` BOOLEAN COMMENT 'Boolean indicator of whether this obligation involves processing of personal data subject to GDPR (General Data Protection Regulation) requirements.',
    `gxp_category` STRING COMMENT 'The GxP framework category this obligation belongs to: Good Manufacturing Practice (GMP), Good Clinical Practice (GCP), Good Laboratory Practice (GLP), Good Distribution Practice (GDP), Good Pharmacovigilance Practice (GPvP), or Good Documentation Practice (GDocP).. Valid values are `GMP|GCP|GLP|GDP|GPvP|GDocP`',
    `hipaa_applicability` BOOLEAN COMMENT 'Boolean indicator of whether this obligation involves protected health information (PHI) subject to HIPAA (Health Insurance Portability and Accountability Act) requirements.',
    `inspection_readiness_flag` BOOLEAN COMMENT 'Boolean indicator of whether the organization is inspection-ready for this obligation (True if all required documentation, controls, and evidence are in place and current; False otherwise).',
    `last_assessment_date` DATE COMMENT 'The date of the most recent compliance assessment or audit for this obligation.',
    `last_review_date` DATE COMMENT 'The date on which this obligation record was last reviewed for accuracy and applicability by the compliance team.',
    `next_assessment_date` DATE COMMENT 'The scheduled date for the next compliance assessment or audit of this obligation.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next periodic review of this obligation record.',
    `obligation_code` STRING COMMENT 'Business identifier for the obligation, typically derived from the source regulation or internal compliance framework (e.g., GMP-210-001, GCP-ICH-E6).. Valid values are `^[A-Z0-9]{6,20}$`',
    `obligation_description` STRING COMMENT 'Detailed description of what the organization is required to do under this obligation, including specific actions, documentation, or controls mandated.',
    `obligation_owner` STRING COMMENT 'The role, department, or individual responsible for ensuring compliance with this obligation (e.g., VP Quality Assurance, Head of Clinical Operations).',
    `obligation_status` STRING COMMENT 'Current lifecycle status of the obligation: Active (currently enforceable), Superseded (replaced by newer regulation), Retired (no longer applicable), Under Review (being assessed for applicability), or Pending Implementation (identified but not yet operationalized).. Valid values are `Active|Superseded|Retired|Under Review|Pending Implementation`',
    `obligation_title` STRING COMMENT 'Short descriptive title of the regulatory obligation (e.g., Batch Record Review and Approval, Informed Consent Documentation).',
    `regulation_source` STRING COMMENT 'The specific regulation, guideline, or directive that mandates this obligation (e.g., 21 CFR Part 211.192, EU GMP Annex 1, ICH Q7, GDPR Article 32).',
    `regulation_type` STRING COMMENT 'The legal or normative type of the source document: Federal Regulation (e.g., CFR), Directive (e.g., EU Directive), Guideline (e.g., ICH), Standard (e.g., ISO), or internal Policy.. Valid values are `Federal Regulation|Directive|Guideline|Standard|Policy`',
    `regulatory_authority` STRING COMMENT 'The governing body or agency that enforces this obligation (e.g., FDA, EMA, MHRA, PMDA, ICH).',
    `related_policy_references` STRING COMMENT 'Comma-separated list of internal policy document numbers or identifiers that govern compliance with this obligation.',
    `related_sop_references` STRING COMMENT 'Comma-separated list of SOP document numbers or identifiers that implement or support compliance with this obligation.',
    `risk_level` STRING COMMENT 'The assessed risk level associated with non-compliance with this obligation, based on potential impact to patient safety, product quality, regulatory standing, and business continuity.. Valid values are `Critical|High|Medium|Low`',
    `sox_control_flag` BOOLEAN COMMENT 'Boolean indicator of whether this obligation is also subject to SOX (Sarbanes-Oxley Act) internal control requirements for financial reporting.',
    `training_required` BOOLEAN COMMENT 'Boolean indicator of whether personnel training is required to ensure compliance with this obligation.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this obligation record was last modified.',
    `validation_requirement` STRING COMMENT 'The type of validation required to demonstrate compliance with this obligation, if applicable: Process Validation, Computer System Validation (CSV), Cleaning Validation, Analytical Method Validation, or Not Applicable.. Valid values are `Process Validation|Computer System Validation|Cleaning Validation|Analytical Method Validation|Not Applicable`',
    CONSTRAINT pk_gxp_obligation PRIMARY KEY(`gxp_obligation_id`)
) COMMENT 'Master record for all GxP regulatory obligations applicable to the enterprise, including GMP, GCP, GLP, GDP, and GPvP requirements. Captures the obligation source (regulation, guideline, directive), applicable jurisdiction, scope (site, function, product), effective date, obligation owner, and current compliance status. Serves as the authoritative register of what the organization is required to do under GxP frameworks including 21 CFR Parts 210/211, EU GMP Annex 1-20, ICH Q10, and equivalent global standards.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`compliance`.`program` (
    `program_id` BIGINT COMMENT 'Unique identifier for the compliance program. Primary key for the compliance program entity.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Compliance programs are owned by legal entities. Each subsidiary operates distinct programs based on jurisdiction and regulatory framework. Essential for program governance, budget allocation, and reg',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to masterdata.org_unit. Business justification: Compliance programs are organized by business unit (Quality, Manufacturing, Clinical). Program ownership and budget allocation follow org structure. Required for program governance, resource planning,',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `program_employee_id` BIGINT COMMENT 'Identifier of the executive or senior manager accountable for the compliance program. Typically a Vice President of Quality, Chief Compliance Officer, or functional head.',
    `parent_program_id` BIGINT COMMENT 'Self-referencing FK on program (parent_program_id)',
    `alcoa_plus_compliant` BOOLEAN COMMENT 'Indicates whether the compliance program enforces ALCOA+ data integrity principles: Attributable, Legible, Contemporaneous, Original, Accurate, plus Complete, Consistent, Enduring, and Available. Critical for GxP compliance programs.',
    `applicable_jurisdictions` STRING COMMENT 'Comma-separated list of countries or regulatory regions where this compliance program applies. Uses three-letter ISO country codes (e.g., USA, GBR, DEU, JPN, CHN) or regional codes (e.g., EU for European Union member states).',
    `budget_amount` DECIMAL(18,2) COMMENT 'Annual budget allocated to the compliance program in USD, covering personnel, training, technology, consulting, and audit costs.',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget amount. Typically USD for global pharmaceutical enterprises.. Valid values are `^[A-Z]{3}$`',
    `capa_integration` BOOLEAN COMMENT 'Indicates whether this compliance program is integrated with the enterprise CAPA system for tracking and resolving compliance deviations, audit findings, and quality issues.',
    `certification_expiry_date` DATE COMMENT 'Date when the current external certification or accreditation expires and requires renewal or re-audit.',
    `certification_status` STRING COMMENT 'Status of external certification or accreditation for this compliance program. Examples include ISO 37301 certification, SOX attestation, or industry-specific accreditation.. Valid values are `Not Certified|In Progress|Certified|Expired|Suspended`',
    `charter_document` STRING COMMENT 'Reference identifier or document management system location for the formal program charter that defines objectives, governance, roles, responsibilities, and success criteria.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the compliance program record was first created in the system. Audit trail field for data lineage and compliance tracking.',
    `csv_required` BOOLEAN COMMENT 'Indicates whether systems covered by this compliance program require formal Computer System Validation per 21 CFR Part 11, EU Annex 11, or GAMP 5 guidelines.',
    `effective_date` DATE COMMENT 'Date when the compliance program became or will become operationally effective and binding across the defined scope.',
    `escalation_procedure` STRING COMMENT 'Description of the escalation path and notification procedures for compliance breaches, audit findings, or regulatory issues identified within this program. Includes roles, timelines, and communication protocols.',
    `expiration_date` DATE COMMENT 'Date when the compliance program is scheduled to expire or be retired. Null for ongoing programs without a defined end date.',
    `external_audit_firm` STRING COMMENT 'Name of the external audit or consulting firm that provides independent assessment or certification of this compliance program. Applicable for SOX, ISO, or third-party GxP audits.',
    `governance_committee` STRING COMMENT 'Name of the cross-functional governance committee or steering group that oversees this compliance program. Examples include Quality Council, Compliance Steering Committee, or Data Integrity Governance Board.',
    `inspection_readiness_level` STRING COMMENT 'Assessment of the programs preparedness for regulatory inspection or external audit. Inspection Ready indicates all documentation, training, and evidence are current and accessible. Audit Verified indicates recent successful inspection or third-party audit.. Valid values are `Not Ready|Partially Ready|Inspection Ready|Audit Verified`',
    `key_performance_indicators` STRING COMMENT 'Comma-separated list of key performance indicators used to measure compliance program effectiveness. Examples include training completion rate, audit finding closure rate, deviation response time, or inspection deficiency count.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory inspection or external audit that assessed this compliance program.',
    `last_modified_by` STRING COMMENT 'User identifier or name of the person who last modified the compliance program record. Required for audit trail and ALCOA+ attributability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the compliance program record was last updated. Audit trail field for change tracking and data integrity compliance.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review or assessment of the compliance program by the governance committee or internal audit function.',
    `program_code` STRING COMMENT 'Externally-known unique alphanumeric code identifying the compliance program across the enterprise. Used in regulatory submissions and audit documentation.. Valid values are `^[A-Z0-9]{4,20}$`',
    `program_description` STRING COMMENT 'Comprehensive description of the compliance programs objectives, regulatory obligations, key controls, and business impact. Used in governance materials and regulatory submissions.',
    `program_name` STRING COMMENT 'Official name of the compliance program as documented in the program charter and governance materials.',
    `program_scope` STRING COMMENT 'Detailed description of the business functions, processes, systems, and geographic regions covered by this compliance program. Defines boundaries and applicability across the enterprise.',
    `program_status` STRING COMMENT 'Current lifecycle status of the compliance program. Draft indicates program is being designed. Active means program is operational. Under Review indicates periodic assessment or audit in progress. Suspended means program activities are temporarily halted. Remediation indicates program is addressing identified deficiencies. Retired means program has been formally closed.. Valid values are `Draft|Active|Under Review|Suspended|Retired|Remediation`',
    `program_type` STRING COMMENT 'Classification of the compliance program by regulatory domain. GxP includes Good Manufacturing Practice (GMP), Good Clinical Practice (GCP), Good Laboratory Practice (GLP), and Good Distribution Practice (GDP) programs. SOX refers to Sarbanes-Oxley internal controls. ABAC is Anti-Bribery and Corruption. HCP Transparency covers Sunshine Act and physician payment disclosure requirements. [ENUM-REF-CANDIDATE: GxP|SOX|Data Integrity|GDPR Privacy|ABAC|HCP Transparency|Environmental Health Safety|Export Control — 8 candidates stripped; promote to reference product]',
    `regulatory_authority` STRING COMMENT 'Primary regulatory agency or governing body that enforces the compliance obligations addressed by this program. Examples include FDA (U.S. Food and Drug Administration), EMA (European Medicines Agency), MHRA (UK), PMDA (Japan), NMPA (China), or DEA (Drug Enforcement Administration).',
    `regulatory_framework` STRING COMMENT 'Primary regulatory framework or standard governing this compliance program. Examples include 21 CFR Part 11 for electronic records, EU Annex 11 for computerized systems, GDPR for data privacy, ICH Q10 for pharmaceutical quality systems, or SOX Section 404 for internal controls.',
    `reporting_cadence` STRING COMMENT 'Frequency at which program performance metrics, compliance status, and risk indicators are reported to governance committees and executive leadership. [ENUM-REF-CANDIDATE: Weekly|Biweekly|Monthly|Quarterly|Semiannual|Annual|Ad Hoc — 7 candidates stripped; promote to reference product]',
    `risk_tier` STRING COMMENT 'Enterprise risk classification of the compliance program based on potential regulatory, financial, and reputational impact. Critical tier programs address patient safety, product quality, or financial reporting. High tier programs address significant regulatory obligations. Medium and Low tier programs address operational compliance requirements.. Valid values are `Critical|High|Medium|Low`',
    `sop_count` STRING COMMENT 'Number of Standard Operating Procedures (SOPs) that define processes and controls for this compliance program. Indicates program maturity and documentation completeness.',
    `training_frequency_months` STRING COMMENT 'Number of months between required refresher training cycles for personnel covered by this compliance program. Typical values are 12 (annual), 24 (biennial), or 36 (triennial) months.',
    `training_required` BOOLEAN COMMENT 'Indicates whether personnel working under this compliance program must complete mandatory training and demonstrate competency. Required for all GxP programs per ICH guidelines.',
    CONSTRAINT pk_program PRIMARY KEY(`program_id`)
) COMMENT 'Master record for enterprise-wide compliance programs managed by the compliance function, including GxP compliance programs, SOX internal controls programs, data integrity programs, GDPR/privacy programs, anti-bribery and corruption (ABAC) programs, and Sunshine Act/HCP transparency programs. Captures program name, regulatory framework, program owner, scope, governance structure, program charter, risk tier, and lifecycle status. Each program is a distinct, managed compliance initiative with its own governance, budget, and reporting cadence.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` (
    `internal_control_id` BIGINT COMMENT 'Unique identifier for the internal control record. Primary key for the internal control master data.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to masterdata.org_unit. Business justification: SOX and GxP controls are assigned to organizational units for execution. Control owners are typically org unit heads. Essential for control testing, deficiency remediation, and audit preparation.',
    `part11_system_id` BIGINT COMMENT 'Foreign key reference to the IT system or application where this control is executed or documented. Relevant for automated controls and ITGC controls.',
    `business_process_id` BIGINT COMMENT 'Foreign key reference to the business process taxonomy. Identifies which business process this control operates within (e.g., Procure-to-Pay, Order-to-Cash, Record-to-Report, Drug Manufacturing).',
    `risk_register_id` BIGINT COMMENT 'Foreign key reference to the enterprise risk register. Links this control to the specific risk(s) it is designed to mitigate.',
    `parent_internal_control_id` BIGINT COMMENT 'Self-referencing FK on internal_control (parent_internal_control_id)',
    `automation_level` STRING COMMENT 'Degree to which the control is automated. Fully Automated controls execute without human intervention; Semi-Automated controls combine system logic with manual review; Manual controls require complete human execution.. Valid values are `fully_automated|semi_automated|manual`',
    `cfr_part_11_applicable_flag` BOOLEAN COMMENT 'Indicates whether this control ensures compliance with 21 CFR Part 11 requirements for electronic records and electronic signatures in FDA-regulated systems.',
    `compensating_control_flag` BOOLEAN COMMENT 'Indicates whether this control serves as a compensating control for another control that has a deficiency or is not operating effectively. Compensating controls provide alternative risk mitigation.',
    `control_activity` STRING COMMENT 'Specific action or procedure performed to execute the control (e.g., Quality Assurance reviews and approves batch records before release, System enforces dual authorization for payments over $50,000).',
    `control_category` STRING COMMENT 'High-level categorization of the control. IT General Controls (ITGC) support IT infrastructure and applications; Business Process Controls operate within specific business processes; Entity-Level Controls operate across the organization; Application Controls are embedded in software; Manual Controls require human execution; Automated Controls execute via system logic.. Valid values are `itgc|business_process_control|entity_level_control|application_control|manual_control|automated_control`',
    `control_description` STRING COMMENT 'Detailed narrative describing the control objective, control activities, and how the control mitigates the identified risk. Includes the what, who, when, and how of the control execution.',
    `control_effectiveness_rating` STRING COMMENT 'Most recent assessment of whether the control is operating effectively. Effective means no deficiencies; Needs Improvement indicates minor deficiencies; Ineffective indicates material weaknesses; Not Tested means no recent testing has been performed.. Valid values are `effective|needs_improvement|ineffective|not_tested`',
    `control_evidence` STRING COMMENT 'Description of the documentation or artifacts that demonstrate control execution (e.g., Signed batch record with QA approval stamp, System audit log showing dual approval, Monthly reconciliation report with preparer and reviewer signatures).',
    `control_frequency` STRING COMMENT 'How often the control is executed or evaluated. Continuous and real-time controls operate automatically; periodic controls execute on a schedule; event-driven controls trigger based on specific business events. [ENUM-REF-CANDIDATE: continuous|real_time|daily|weekly|monthly|quarterly|annual|event_driven — 8 candidates stripped; promote to reference product]',
    `control_name` STRING COMMENT 'Short descriptive name of the internal control (e.g., Segregation of Duties for Invoice Approval, Batch Record Review and Approval).',
    `control_number` STRING COMMENT 'Business-facing unique identifier for the control, typically formatted as domain-category-sequence (e.g., FI-ITGC-0001, QM-BPC-0023). Used in audit documentation and control testing reports.. Valid values are `^[A-Z]{2,4}-[A-Z]{2,4}-[0-9]{4,6}$`',
    `control_objective` STRING COMMENT 'High-level statement of what the control is designed to achieve (e.g., Ensure completeness and accuracy of batch production records, Prevent unauthorized access to financial systems).',
    `control_owner` STRING COMMENT 'Name or identifier of the individual or role responsible for the design, implementation, and ongoing operation of the control. Accountable for control effectiveness and remediation of deficiencies.',
    `control_owner_email` STRING COMMENT 'Primary email address of the control owner for audit notifications, testing requests, and deficiency communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `control_status` STRING COMMENT 'Current lifecycle status of the control. Active controls are in operation; Inactive controls are temporarily suspended; Under Review controls are being assessed for design changes; Remediation in Progress controls have identified deficiencies being corrected; Retired controls are no longer in scope.. Valid values are `active|inactive|under_review|remediation_in_progress|retired`',
    `control_type` STRING COMMENT 'Classification of the control based on its timing relative to the risk event. Preventive controls stop errors before they occur, detective controls identify errors after occurrence, corrective controls remediate identified issues.. Valid values are `preventive|detective|corrective`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this control record was first created in the system. Part of audit trail for control inventory management.',
    `data_integrity_control_flag` BOOLEAN COMMENT 'Indicates whether this control specifically addresses ALCOA+ principles (Attributable, Legible, Contemporaneous, Original, Accurate, Complete, Consistent, Enduring, Available). Critical for pharmaceutical data integrity compliance.',
    `deficiency_count` STRING COMMENT 'Number of open control deficiencies, exceptions, or findings identified during testing. Includes control design deficiencies and operating effectiveness deficiencies.',
    `effective_end_date` DATE COMMENT 'Date when this control was retired or superseded. Null for active controls. Used for historical analysis and audit trail.',
    `effective_start_date` DATE COMMENT 'Date when this control became operational and in scope for compliance monitoring. Used for historical tracking and audit period determination.',
    `gdpr_applicable_flag` BOOLEAN COMMENT 'Indicates whether this control supports GDPR compliance for personal data protection, privacy rights, and data subject rights in EU operations or clinical trials.',
    `gxp_applicable_flag` BOOLEAN COMMENT 'Indicates whether this control supports GxP compliance (GMP, GLP, GCP, GDP). True if the control ensures data integrity, product quality, or patient safety in regulated pharmaceutical operations.',
    `gxp_regulation` STRING COMMENT 'Specific GxP regulation(s) this control supports (e.g., 21 CFR Part 211, EU GMP Annex 11, ICH Q7). Multiple regulations may be comma-separated. [ENUM-REF-CANDIDATE: 21_cfr_part_11|21_cfr_part_210|21_cfr_part_211|21_cfr_part_312|eu_gmp_annex_11|ich_q7|ich_q10|gdp_guidelines — promote to reference product]',
    `hipaa_applicable_flag` BOOLEAN COMMENT 'Indicates whether this control supports HIPAA compliance for protected health information (PHI) in US clinical trials, patient support programs, or pharmacovigilance activities.',
    `key_control_flag` BOOLEAN COMMENT 'Indicates whether this is a key control that directly addresses a significant risk and must be tested annually. Key controls are critical to the overall control environment and receive heightened audit focus.',
    `last_modified_by` STRING COMMENT 'User ID or name of the individual who last modified this control record. Supports ALCOA+ attributability requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this control record was most recently updated. Part of audit trail for change tracking.',
    `last_test_date` DATE COMMENT 'Date when the control was most recently tested for design and operating effectiveness by internal audit, external audit, or compliance team.',
    `material_weakness_flag` BOOLEAN COMMENT 'Indicates whether a material weakness has been identified in this control. Material weaknesses are deficiencies that create a reasonable possibility of material misstatement in financial statements and must be disclosed under SOX Section 404.',
    `next_test_due_date` DATE COMMENT 'Scheduled date for the next control testing cycle based on control frequency and risk rating. Used for audit planning and compliance monitoring.',
    `significant_deficiency_flag` BOOLEAN COMMENT 'Indicates whether a significant deficiency has been identified in this control. Significant deficiencies are less severe than material weaknesses but important enough to merit attention by those charged with governance.',
    `sox_applicable_flag` BOOLEAN COMMENT 'Indicates whether this control is in scope for SOX Section 302/404 compliance and must be tested annually for financial reporting integrity. True if the control is a key control over financial reporting.',
    `sox_section` STRING COMMENT 'Specific SOX section(s) this control supports. Section 302 relates to management certification of financial statements; Section 404 relates to internal control over financial reporting assessment.. Valid values are `section_302|section_404|both|not_applicable`',
    `testing_method` STRING COMMENT 'Primary audit testing procedure used to evaluate control design and operating effectiveness. Inquiry involves asking control performers; Observation involves watching control execution; Inspection involves examining evidence; Reperformance involves auditor executing the control; Data Analytics involves statistical or automated testing.. Valid values are `inquiry|observation|inspection|reperformance|walkthrough|data_analytics`',
    `created_by` STRING COMMENT 'User ID or name of the individual who created this control record. Supports ALCOA+ attributability requirements.',
    CONSTRAINT pk_internal_control PRIMARY KEY(`internal_control_id`)
) COMMENT 'Master record for internal controls established to satisfy regulatory requirements, SOX obligations, and GxP compliance mandates. Captures control ID, control name, control type (preventive, detective, corrective), control category (IT general control, business process control, entity-level control), control owner, frequency (continuous, daily, monthly, annual), testing method, and SOX applicability flag. Links to regulatory requirements and compliance programs. Serves as the authoritative control inventory for SOX Section 302/404 and GxP compliance assurance.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` (
    `control_assessment_id` BIGINT COMMENT 'Unique identifier for the control assessment record. Primary key for the control assessment entity.',
    `internal_control_id` BIGINT COMMENT 'Reference to the internal control being assessed. Links to the control master record defining the control objective, description, and ownership.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who performed the control assessment. Must be independent of the control owner per segregation of duties requirements. For external auditor assessments, references the engagement team member.',
    `quality_capa_id` BIGINT COMMENT 'Reference to the formal CAPA record created to address identified control deficiencies. Links to quality management system for tracking root cause analysis, corrective actions, preventive actions, and effectiveness verification per 21 CFR Part 211 Subpart J and ISO 9001 requirements.',
    `reviewer_employee_id` BIGINT COMMENT 'Reference to the employee who reviewed and approved the assessment results. Typically a senior compliance officer, quality assurance manager, or internal audit director. Required for SOX management assessment sign-off.',
    `previous_control_assessment_id` BIGINT COMMENT 'Self-referencing FK on control_assessment (previous_control_assessment_id)',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the control assessment was formally approved by the reviewer. Represents management sign-off on assessment conclusions and remediation plans. Required for SOX 404 management assessment certification.',
    `assessment_execution_date` DATE COMMENT 'Date when the control assessment testing was performed. Represents the principal business event timestamp for the assessment activity. May differ from period end date for interim or retrospective testing.',
    `assessment_notes` STRING COMMENT 'Free-text field for assessor observations, testing procedures performed, evidence examined, and other relevant assessment details. Supports audit trail and provides context for assessment conclusions and recommendations.',
    `assessment_number` STRING COMMENT 'Business identifier for the control assessment. Format: CA-YYYY-NNNNNN where YYYY is fiscal year and NNNNNN is sequential number. Used for external reporting and audit trail references.. Valid values are `^CA-[0-9]{4}-[0-9]{6}$`',
    `assessment_period_end_date` DATE COMMENT 'Ending date of the period under assessment. Defines the scope boundary for transaction sampling and control effectiveness evaluation.',
    `assessment_period_start_date` DATE COMMENT 'Beginning date of the period under assessment. For SOX testing, typically aligns with fiscal quarter or year start. For GxP assessments, may align with batch production periods or clinical trial phases.',
    `assessment_status` STRING COMMENT 'Current lifecycle state of the control assessment. Planned indicates assessment scheduled but not started. In progress indicates active testing underway. Testing complete indicates fieldwork finished, awaiting review. Under review indicates management or audit committee review in progress. Approved indicates assessment concluded with no material findings. Remediation required indicates deficiencies identified requiring Corrective and Preventive Action (CAPA).. Valid values are `planned|in_progress|testing_complete|under_review|approved|remediation_required`',
    `assessment_type` STRING COMMENT 'Classification of the control assessment activity. SOX control testing covers Sarbanes-Oxley 404 internal control evaluations. GxP compliance assessment covers Good Practice (GMP, GLP, GCP) regulatory compliance. ITGC evaluation covers IT General Controls. Process walkthrough covers end-to-end process documentation and control identification. Data integrity review covers ALCOA+ (Attributable, Legible, Contemporaneous, Original, Accurate, Complete, Consistent, Enduring, Available) principles. Vendor audit covers third-party Contract Manufacturing Organization (CMO) and Contract Research Organization (CRO) assessments.. Valid values are `sox_control_testing|gxp_compliance_assessment|itgc_evaluation|process_walkthrough|data_integrity_review|vendor_audit`',
    `control_effectiveness_rating` STRING COMMENT 'Qualitative assessment of control design and operating effectiveness. Highly effective indicates robust control with no exceptions and strong design. Effective indicates control operates as designed with minor exceptions. Needs improvement indicates control operates but has design weaknesses or recurring exceptions. Ineffective indicates control does not mitigate risk or has material failures.. Valid values are `highly_effective|effective|needs_improvement|ineffective`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the control assessment record was first created in the system. Part of audit trail for compliance and data integrity requirements.',
    `data_integrity_alcoa_compliance_flag` BOOLEAN COMMENT 'Indicator whether control assessment verified compliance with ALCOA+ data integrity principles: Attributable, Legible, Contemporaneous, Original, Accurate, Complete, Consistent, Enduring, and Available. Critical for GxP systems validation and 21 CFR Part 11 electronic records compliance.',
    `deficiency_classification` STRING COMMENT 'Severity classification of identified control deficiencies per SOX 404 and PCAOB standards. No deficiency indicates effective control. Control deficiency indicates a weakness that does not rise to significant deficiency. Significant deficiency indicates a deficiency or combination of deficiencies that is less severe than a material weakness yet important enough to merit attention by those charged with governance. Material weakness indicates a deficiency or combination of deficiencies such that there is a reasonable possibility that a material misstatement will not be prevented or detected on a timely basis.. Valid values are `no_deficiency|control_deficiency|significant_deficiency|material_weakness`',
    `deficiency_description` STRING COMMENT 'Detailed narrative description of identified control deficiencies, including root cause analysis, impact assessment, and specific instances of control failure. Required for significant deficiencies and material weaknesses reported to audit committee and external auditors.',
    `evidence_location` STRING COMMENT 'Reference to the storage location of assessment work papers and supporting evidence. May be document management system path, shared drive location, or electronic Trial Master File (eTMF) reference. Required for audit trail and regulatory inspection readiness.',
    `exceptions_identified_count` STRING COMMENT 'Number of control failures or deviations identified during testing. Exceptions indicate instances where the control did not operate as designed or was not performed. Used to calculate control deficiency rate and determine control effectiveness conclusion.',
    `external_auditor_reliance_flag` BOOLEAN COMMENT 'Indicator whether external auditors can rely on this internal control assessment for their financial statement audit. True indicates assessment meets PCAOB standards for auditor reliance. False indicates external auditors must perform independent testing. Critical for SOX 404(b) external auditor attestation.',
    `fiscal_quarter` STRING COMMENT 'Fiscal quarter in which the control assessment was performed. Used for quarterly SOX testing cycles and interim control effectiveness monitoring.. Valid values are `Q1|Q2|Q3|Q4`',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the control assessment was performed. Used for SOX 404 annual management assessment reporting and multi-year trend analysis of control effectiveness.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the control assessment record was last updated. Tracks changes to assessment status, test results, or remediation progress. Required for audit trail and change control per 21 CFR Part 11.',
    `population_size` STRING COMMENT 'Total number of control instances or transactions in the assessment period. Used to calculate sampling rates and extrapolate findings. For automated controls, may represent system-generated control executions. For manual controls, represents documented control performance instances.',
    `regulatory_inspection_readiness_flag` BOOLEAN COMMENT 'Indicator whether control assessment documentation is inspection-ready for FDA Pre-Approval Inspection (PAI), EMA inspection, or other regulatory authority audits. True indicates assessment package complete with evidence, work papers, and management sign-off per GxP requirements.',
    `remediation_completion_date` DATE COMMENT 'Actual date when corrective action implementation was completed. Used to calculate remediation cycle time and track compliance with remediation commitments made to audit committee and external auditors.',
    `remediation_due_date` DATE COMMENT 'Target completion date for corrective action implementation. Established based on deficiency severity and risk rating. Material weaknesses typically require remediation within 90 days. Significant deficiencies within 180 days. Monitored for SOX 404 management assessment and external auditor follow-up.',
    `remediation_required_flag` BOOLEAN COMMENT 'Indicator whether corrective action is required to address identified deficiencies. True indicates Corrective and Preventive Action (CAPA) plan must be developed and tracked. False indicates no remediation needed.',
    `remediation_status` STRING COMMENT 'Current state of corrective action implementation. Not required indicates no deficiencies identified. Planned indicates CAPA plan approved but not started. In progress indicates remediation activities underway. Completed indicates remediation actions finished, awaiting verification. Verified indicates remediation effectiveness confirmed through re-testing. Overdue indicates remediation past target completion date.. Valid values are `not_required|planned|in_progress|completed|verified|overdue`',
    `risk_rating` STRING COMMENT 'Assessment of residual risk exposure given identified control deficiencies. Critical indicates immediate risk of material financial misstatement or regulatory non-compliance. High indicates significant risk requiring prompt remediation. Medium indicates moderate risk with planned remediation. Low indicates minimal risk with monitoring.. Valid values are `critical|high|medium|low`',
    `sample_size` STRING COMMENT 'Number of control instances or transactions tested during the assessment. For sample testing, determined by statistical sampling methodology based on population size, expected error rate, and confidence level. For full population testing, equals total population. Null for walkthroughs and inquiry-only assessments.',
    `sox_scoping_flag` BOOLEAN COMMENT 'Indicator whether this control is in scope for SOX 404 management assessment and external auditor attestation. True indicates control is key to preventing or detecting material misstatements in financial reporting. Scoping based on materiality, risk assessment, and process-level controls over significant accounts and disclosures.',
    `test_result` STRING COMMENT 'Overall conclusion on control operating effectiveness. Effective indicates control operated as designed with no material exceptions. Ineffective indicates control failures that could result in material misstatement or compliance violation. Not tested indicates assessment planned but not executed. Not applicable indicates control not in operation during assessment period.. Valid values are `effective|ineffective|not_tested|not_applicable`',
    `testing_approach` STRING COMMENT 'Methodology used to evaluate control effectiveness. Inquiry involves interviewing control performers. Observation involves watching control execution in real-time. Inspection involves examining documentary evidence. Reperformance involves independently executing the control. Walkthrough involves tracing a single transaction end-to-end. Sample testing involves statistical sampling of control instances. Full population testing involves examining all control instances in the period. [ENUM-REF-CANDIDATE: inquiry|observation|inspection|reperformance|walkthrough|sample_testing|full_population_testing — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_control_assessment PRIMARY KEY(`control_assessment_id`)
) COMMENT 'Transactional record capturing the periodic testing and assessment of internal controls. Covers SOX control testing, GxP compliance assessments, and IT general control (ITGC) evaluations. Captures assessment period, assessor identity, testing approach (walkthrough, sample testing, full population), sample size, test results (effective, ineffective, not tested), deficiency classification (control deficiency, significant deficiency, material weakness), and remediation status. Feeds SOX 404 management assessment and external auditor reliance programs.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` (
    `inspection_readiness_id` BIGINT COMMENT 'Unique identifier for the inspection readiness program record.',
    `application_id` BIGINT COMMENT 'Foreign key linking to regulatory.application. Business justification: Readiness programs scoped to application lifecycle (original application, supplements). Tracks readiness status against application milestones for regulatory strategy execution and inspection risk mit',
    `designation_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_designation. Business justification: Designations (Breakthrough, PRIME, Orphan) trigger accelerated timelines and heightened inspection scrutiny. Links readiness program to designation for tailored preparation strategies and priority rev',
    `employee_id` BIGINT COMMENT 'Reference to the user who created the inspection readiness program record.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Inspection readiness programs require significant investment in gap remediation, mock inspections, training, and system upgrades. Tracked via internal orders for cost capture, budget management, and R',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified the inspection readiness program record.',
    `medicinal_product_id` BIGINT COMMENT 'Reference to the drug product or biological product subject to inspection, if the readiness program is product-specific.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to masterdata.plant. Business justification: Inspection readiness programs are site-specific. Mock inspections and gap assessments are conducted per plant. Required for readiness scoring, resource planning, and executive dashboards.',
    `primary_inspection_employee_id` BIGINT COMMENT 'Reference to the employee responsible for coordinating the inspection readiness program.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Inspection readiness programs are instances of compliance programs. Currently has redundant program_code and program_name attributes that duplicate compliance_program master data. Adding FK enables no',
    `regulatory_inspection_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_inspection. Business justification: Inspection readiness programs prepare for regulatory inspections. Once an inspection occurs, the readiness program should reference the actual inspection to close the loop and assess effectiveness. Th',
    `site_id` BIGINT COMMENT 'Reference to the manufacturing site, clinical site, or facility subject to inspection.',
    `submission_id` BIGINT COMMENT 'Foreign key linking to regulatory.submission. Business justification: Inspection readiness programs prepare sites for PAI triggered by specific submissions (NDA, BLA, MAA). Links readiness activities to submission timeline for PDUFA date planning and resource allocation',
    `parent_inspection_readiness_id` BIGINT COMMENT 'Self-referencing FK on inspection_readiness (parent_inspection_readiness_id)',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the inspection readiness program record was first created in the system.',
    `critical_gaps_identified_count` STRING COMMENT 'Number of critical gaps or deficiencies identified during readiness assessment that require immediate remediation.',
    `csv_compliance_status` STRING COMMENT 'Status of Computer System Validation compliance for systems within the inspection scope, per 21 CFR Part 11 and GAMP 5 guidelines.. Valid values are `Compliant|Non-Compliant|Partially Compliant|Under Review`',
    `data_integrity_assessment_status` STRING COMMENT 'Status of the ALCOA+ (Attributable, Legible, Contemporaneous, Original, Accurate, Complete, Consistent, Enduring, Available) data integrity assessment conducted as part of readiness.. Valid values are `Not Started|In Progress|Completed|Passed|Failed`',
    `document_review_completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of required Standard Operating Procedures (SOPs), batch records, and quality documents reviewed and updated for inspection readiness.',
    `gaps_remediated_count` STRING COMMENT 'Total number of identified gaps that have been successfully remediated and closed.',
    `gxp_category` STRING COMMENT 'The Good Practice category applicable to this inspection. GMP = Good Manufacturing Practice, GLP = Good Laboratory Practice, GCP = Good Clinical Practice, GDP = Good Distribution Practice, GVP = Good Pharmacovigilance Practice.. Valid values are `GMP|GLP|GCP|GDP|GVP`',
    `inspection_announcement_type` STRING COMMENT 'Indicates whether the inspection is announced in advance, unannounced, or triggered by a specific cause (e.g., adverse event, complaint).. Valid values are `Announced|Unannounced|For Cause`',
    `inspection_notification_received_flag` BOOLEAN COMMENT 'Indicates whether formal notification of the regulatory inspection has been received from the authority.',
    `inspection_scope` STRING COMMENT 'Detailed description of the scope of the inspection readiness program, including functional areas, product lines, or processes covered.',
    `inspection_type` STRING COMMENT 'Type of regulatory inspection the readiness program is preparing for. FDA PAI = Pre-Approval Inspection, EMA GMP = European Medicines Agency Good Manufacturing Practice, MHRA = Medicines and Healthcare products Regulatory Agency, WHO PQ = World Health Organization Prequalification, PMDA = Pharmaceuticals and Medical Devices Agency.. Valid values are `FDA PAI|FDA Surveillance|EMA GMP|MHRA Inspection|WHO PQ|PMDA Inspection`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the inspection readiness program record was last modified.',
    `major_gaps_identified_count` STRING COMMENT 'Number of major gaps or deficiencies identified during readiness assessment that require remediation before inspection.',
    `minor_gaps_identified_count` STRING COMMENT 'Number of minor gaps or observations identified during readiness assessment.',
    `mock_inspection_completed_date` DATE COMMENT 'Date when the mock inspection or readiness assessment exercise was completed.',
    `mock_inspection_scheduled_date` DATE COMMENT 'Scheduled date for the mock inspection or readiness assessment exercise.',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, observations, or special considerations for the inspection readiness program.',
    `notification_received_date` DATE COMMENT 'Date when formal notification of the regulatory inspection was received.',
    `open_capa_count` STRING COMMENT 'Number of open CAPA records associated with inspection readiness gaps that are still pending closure.',
    `program_end_date` DATE COMMENT 'Date when the inspection readiness program was completed or closed.',
    `program_start_date` DATE COMMENT 'Date when the inspection readiness program was initiated.',
    `program_status` STRING COMMENT 'Current lifecycle status of the inspection readiness program. [ENUM-REF-CANDIDATE: Planning|Active|Mock Inspection|Remediation|Ready|On Hold|Closed — 7 candidates stripped; promote to reference product]',
    `readiness_determination` STRING COMMENT 'Final determination of inspection readiness status based on assessment results and remediation completion.. Valid values are `Ready|Conditionally Ready|Not Ready|Pending Assessment`',
    `readiness_score` DECIMAL(18,2) COMMENT 'Quantitative assessment score representing the overall inspection readiness level, typically expressed as a percentage (0.00 to 100.00).',
    `regulatory_authority` STRING COMMENT 'The regulatory authority expected to conduct the inspection. FDA = U.S. Food and Drug Administration, EMA = European Medicines Agency, MHRA = Medicines and Healthcare products Regulatory Agency, PMDA = Pharmaceuticals and Medical Devices Agency, NMPA = National Medical Products Administration, WHO = World Health Organization, DEA = Drug Enforcement Administration, PIC/S = Pharmaceutical Inspection Co-operation Scheme. [ENUM-REF-CANDIDATE: FDA|EMA|MHRA|PMDA|NMPA|WHO|DEA|PIC/S — 8 candidates stripped; promote to reference product]',
    `risk_assessment_completed_flag` BOOLEAN COMMENT 'Indicates whether a formal risk assessment has been completed to identify inspection vulnerabilities and prioritize remediation activities.',
    `target_inspection_end_date` DATE COMMENT 'Expected or announced end date of the regulatory inspection.',
    `target_inspection_start_date` DATE COMMENT 'Expected or announced start date of the regulatory inspection.',
    `training_completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of required inspection readiness training completed by personnel within the scope of the program.',
    CONSTRAINT pk_inspection_readiness PRIMARY KEY(`inspection_readiness_id`)
) COMMENT 'Master record for regulatory inspection readiness programs and activities at the site, function, or product level. Captures readiness program scope (FDA PAI, EMA GMP inspection, MHRA, WHO PQ), target inspection window, readiness coordinator, mock inspection schedule, readiness score, identified gaps, remediation actions, and final readiness determination. Tracks the enterprises preparedness posture for announced and unannounced regulatory inspections across all GxP-regulated functions.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` (
    `regulatory_inspection_id` BIGINT COMMENT 'Unique identifier for the regulatory inspection record. Primary key.',
    `dmf_id` BIGINT COMMENT 'Foreign key linking to regulatory.dmf. Business justification: DMF (Drug Master File) facilities subject to GMP inspections. Links inspection to DMF for API/excipient supplier qualification, deficiency tracking, and authorization letter decisions by referencing a',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Inspection preparation and response activities are tracked as projects with associated costs via internal orders. Enables cost tracking for inspection readiness programs, mock inspections, and post-in',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Regulatory inspections target specific legal entities (registered manufacturers, sponsors). FDA Form 483s and EMA reports cite the legal entity. Critical for inspection tracking, CAPA assignment, and ',
    `medicinal_product_id` BIGINT COMMENT 'Foreign key reference to the drug product or investigational product that was the focus of the inspection, if applicable (e.g., for pre-approval inspections or product-specific GMP inspections).',
    `plant_id` BIGINT COMMENT 'Foreign key linking to masterdata.plant. Business justification: Inspections occur at specific manufacturing sites. FDA establishment identifiers link plants to inspection records. Essential for inspection history, CAPA tracking, site qualification. Removes denorma',
    `submission_id` BIGINT COMMENT 'Foreign key reference to the regulatory submission (IND, NDA, BLA, MAA) associated with this inspection, if applicable (e.g., for pre-approval inspections).',
    `site_id` BIGINT COMMENT 'Foreign key reference to the site or facility where the inspection was conducted. May reference internal manufacturing sites, clinical investigational sites, or third-party partner locations (CRO, CMO, CDMO).',
    `trial_id` BIGINT COMMENT 'Foreign key reference to the clinical trial that was the subject of the inspection, if applicable (e.g., for GCP inspections of clinical investigational sites).',
    `followup_regulatory_inspection_id` BIGINT COMMENT 'Self-referencing FK on regulatory_inspection (followup_regulatory_inspection_id)',
    `actual_end_date` DATE COMMENT 'Actual date when the on-site inspection activities concluded. Format: yyyy-MM-dd.',
    `actual_start_date` DATE COMMENT 'Actual date when the inspection commenced on-site. Format: yyyy-MM-dd.',
    `authority_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the country of the inspecting regulatory authority (e.g., USA for FDA, GBR for MHRA, JPN for PMDA).. Valid values are `^[A-Z]{3}$`',
    `capa_completion_target_date` DATE COMMENT 'Target date by which all CAPA activities related to the inspection findings are planned to be completed. Format: yyyy-MM-dd.',
    `capa_required` BOOLEAN COMMENT 'Boolean flag indicating whether Corrective and Preventive Actions (CAPA) are required to address inspection findings. True if CAPA plan must be developed and executed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory inspection record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `critical_findings_count` STRING COMMENT 'Number of critical or major findings identified during the inspection that pose significant risk to product quality, patient safety, or data integrity.',
    `follow_up_inspection_date` DATE COMMENT 'Scheduled or actual date of the follow-up inspection to verify closure of findings. Format: yyyy-MM-dd.',
    `follow_up_inspection_required` BOOLEAN COMMENT 'Boolean flag indicating whether the regulatory authority has indicated that a follow-up or re-inspection is required to verify corrective actions.',
    `form_483_issued` BOOLEAN COMMENT 'Boolean flag indicating whether the FDA issued a Form 483 (Inspectional Observations) at the conclusion of the inspection. Applicable to FDA inspections only.',
    `inspecting_authority` STRING COMMENT 'Name of the regulatory authority or health agency conducting the inspection (e.g., FDA, EMA, MHRA, PMDA, NMPA, state health department).',
    `inspection_duration_days` STRING COMMENT 'Total number of calendar days the inspection lasted, from actual start to actual end date.',
    `inspection_notes` STRING COMMENT 'Free-text field for internal notes, observations, or context related to the inspection. May include preparation notes, key discussion points, or lessons learned.',
    `inspection_number` STRING COMMENT 'Externally-known unique identifier or reference number assigned by the regulatory authority or internal tracking system for this inspection.',
    `inspection_outcome` STRING COMMENT 'Official outcome classification issued by the regulatory authority. NAI (No Action Indicated - no objectionable conditions), VAI (Voluntary Action Indicated - objectionable conditions that do not meet threshold for regulatory action), OAI (Official Action Indicated - significant violations requiring regulatory action), warning_letter (formal enforcement letter issued), consent_decree (legal agreement), pending (outcome not yet determined).. Valid values are `NAI|VAI|OAI|warning_letter|consent_decree|pending`',
    `inspection_report_received_date` DATE COMMENT 'Date when the company received the official inspection report or final classification letter from the regulatory authority. Format: yyyy-MM-dd.',
    `inspection_report_url` STRING COMMENT 'URL or file path to the stored inspection report document in the document management system (e.g., Veeva Vault RIM or QualityDocs).',
    `inspection_scope` STRING COMMENT 'Detailed description of the scope of the inspection, including specific areas, processes, systems, or products under review (e.g., sterile manufacturing line, clinical trial site for Protocol XYZ, pharmacovigilance database system).',
    `inspection_status` STRING COMMENT 'Current lifecycle status of the inspection: scheduled (planned but not started), in_progress (inspection underway), completed (inspection finished and report issued), cancelled (inspection did not occur), follow_up_required (additional actions or re-inspection needed).. Valid values are `scheduled|in_progress|completed|cancelled|follow_up_required`',
    `inspection_type` STRING COMMENT 'Type of regulatory inspection conducted. GMP (Good Manufacturing Practice), GCP (Good Clinical Practice), GLP (Good Laboratory Practice), GDP (Good Distribution Practice), pharmacovigilance, or pre-approval inspection (PAI).. Valid values are `GMP|GCP|GLP|GDP|pharmacovigilance|pre-approval`',
    `is_announced` BOOLEAN COMMENT 'Boolean flag indicating whether the inspection was announced (true) or unannounced (false). Unannounced inspections are common for GMP and pharmacovigilance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory inspection record was last updated or modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `lead_inspector_name` STRING COMMENT 'Full name of the lead inspector or principal investigator from the regulatory authority responsible for conducting the inspection.',
    `major_findings_count` STRING COMMENT 'Number of major findings or observations that represent significant deviations from regulatory requirements but may not be immediately critical.',
    `minor_findings_count` STRING COMMENT 'Number of minor findings or observations that represent less significant deviations or areas for improvement.',
    `notification_date` DATE COMMENT 'Date when the company was officially notified by the regulatory authority of the upcoming inspection. May be null for unannounced inspections. Format: yyyy-MM-dd.',
    `number_of_observations` STRING COMMENT 'Total count of observations, findings, or deficiencies cited by the inspectors during the inspection (e.g., number of items on Form 483 or equivalent inspection report).',
    `response_due_date` DATE COMMENT 'Deadline date by which the company must submit a formal written response to the inspection findings (e.g., response to Form 483 or inspection report). Format: yyyy-MM-dd.',
    `response_submitted_date` DATE COMMENT 'Actual date when the company submitted its formal written response to the regulatory authority addressing the inspection findings. Format: yyyy-MM-dd.',
    `scheduled_start_date` DATE COMMENT 'Planned or scheduled date when the inspection is expected to begin. Format: yyyy-MM-dd.',
    `site_type` STRING COMMENT 'Classification of the inspected site: manufacturing (drug production facility), clinical_site (investigational site for clinical trials), distribution_center (GDP-regulated warehouse), laboratory (analytical or R&D lab), cro (Contract Research Organization), cmo (Contract Manufacturing Organization), cdmo (Contract Development and Manufacturing Organization), headquarters (corporate office). [ENUM-REF-CANDIDATE: manufacturing|clinical_site|distribution_center|laboratory|cro|cmo|cdmo|headquarters — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_regulatory_inspection PRIMARY KEY(`regulatory_inspection_id`)
) COMMENT 'Master and transactional record for regulatory inspections conducted by health authorities at company sites, CRO/CMO partners, or clinical investigational sites. Captures inspection type (GMP, GCP, GLP, GDP, pharmacovigilance, pre-approval), inspecting agency, inspection dates, lead inspector, scope, site inspected, inspection outcome (no action indicated, voluntary action indicated, official action indicated, warning letter), and follow-up status. Distinct from quality.audit (which covers internal and supplier audits) — this is the authoritative record for external regulatory authority inspections.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` (
    `inspection_observation_id` BIGINT COMMENT 'Unique identifier for the inspection observation record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the employee or organizational unit assigned as the primary owner responsible for preparing and submitting the corrective action response to this observation.',
    `gxp_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.gxp_obligation. Business justification: Inspection observations cite specific regulatory obligations (CFR citations, GMP requirements). This FK links each observation to the master obligation record, enabling analysis of which obligations a',
    `health_authority_id` BIGINT COMMENT 'Foreign key reference to the regulatory health authority that raised this observation during the inspection (e.g., FDA, EMA, MHRA, PMDA).',
    `medicinal_product_id` BIGINT COMMENT 'Foreign key reference to the specific drug product or drug substance that was the subject of this observation, if the observation is product-specific. Null if the observation relates to general systems or facility issues.',
    `policy_document_id` BIGINT COMMENT 'The document control number or reference identifier for the formal response document submitted to the health authority. Links to the document management system.',
    `previous_observation_inspection_observation_id` BIGINT COMMENT 'Foreign key reference to the prior inspection observation record if this is identified as a repeat observation. Links to historical observation for trend analysis.',
    `quality_capa_id` BIGINT COMMENT 'Foreign key reference to the formal CAPA record opened in the quality management system to track the corrective action implementation for this observation.',
    `regulatory_inspection_id` BIGINT COMMENT 'Foreign key reference to the parent regulatory inspection event during which this observation was raised.',
    `root_cause_analysis_id` BIGINT COMMENT 'Foreign key reference to the formal root cause analysis investigation conducted to determine the underlying cause of this observation.',
    `site_id` BIGINT COMMENT 'Foreign key reference to the manufacturing facility, laboratory, or site where this observation was identified during the inspection.',
    `parent_inspection_observation_id` BIGINT COMMENT 'Self-referencing FK on inspection_observation (parent_inspection_observation_id)',
    `cfr_citation` STRING COMMENT 'The specific CFR section(s) cited by the inspector as the regulatory basis for this observation. For US inspections, typically references 21 CFR Parts 11, 210, 211, 312, or 314. For non-US inspections, may reference equivalent regulatory framework sections.',
    `closure_date` DATE COMMENT 'The date on which this observation was formally closed, indicating that the health authority has accepted the response and verified corrective action implementation, or the company has internally verified completion.',
    `closure_verification_method` STRING COMMENT 'The method by which closure of this observation was verified and confirmed. Indicates whether closure was based on health authority acceptance, follow-up inspection, or internal verification.. Valid values are `document_review|follow_up_inspection|self_verification|health_authority_acceptance`',
    `corrective_action_completion_date` DATE COMMENT 'The committed or actual date by which the corrective action will be or was completed. This date is communicated to the health authority as part of the response commitment.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this observation record was first created in the system. Audit trail field for data governance and compliance tracking.',
    `escalation_date` DATE COMMENT 'The date on which this observation was escalated to senior management or executive leadership for awareness and decision-making.',
    `escalation_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether this observation requires escalation to senior management or executive leadership due to severity, regulatory risk, or potential business impact.',
    `gmp_citation` STRING COMMENT 'The specific GMP guideline or ICH guideline section cited as the basis for this observation. May reference EU GMP Annex, PIC/S guidelines, or ICH Q-series quality guidelines.',
    `impact_assessment` STRING COMMENT 'A summary of the business and regulatory impact assessment conducted for this observation, including potential impact on product quality, patient safety, regulatory standing, and commercial operations.',
    `inspector_name` STRING COMMENT 'The name of the regulatory inspector who documented this observation. Used for tracking inspector patterns and communication history.',
    `internal_notes` STRING COMMENT 'Internal company notes and commentary regarding this observation, response strategy, lessons learned, or coordination activities. Not shared with the health authority.',
    `last_modified_by` STRING COMMENT 'The user ID or name of the individual who last modified this observation record. Audit trail field for data governance and compliance tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this observation record was last updated or modified. Audit trail field for data governance and compliance tracking.',
    `observation_category` STRING COMMENT 'The functional area or GMP system category to which this observation relates. Used to classify observations by business process area for trending and root cause analysis. [ENUM-REF-CANDIDATE: quality_system|data_integrity|facility_equipment|materials_management|production_process|laboratory_controls|packaging_labeling — 7 candidates stripped; promote to reference product]',
    `observation_classification` STRING COMMENT 'The severity classification assigned to the observation indicating the level of regulatory concern. Critical observations represent serious violations that may result in regulatory action; major observations are significant deviations from GxP requirements; minor observations are less serious deficiencies; informational observations are recommendations without compliance impact.. Valid values are `critical|major|minor|informational|other`',
    `observation_date` DATE COMMENT 'The date on which the inspector documented this observation during the inspection. This is the business event date from the inspection timeline.',
    `observation_reference_number` STRING COMMENT 'The official reference number or citation identifier assigned by the regulatory inspector to this specific observation. This is the externally-known identifier used in all correspondence with the health authority.. Valid values are `^[A-Z0-9-]+$`',
    `observation_status` STRING COMMENT 'The current lifecycle status of this observation in the inspection response workflow. Tracks progression from initial identification through response submission and final closure.. Valid values are `open|response_in_progress|response_submitted|under_review|closed|escalated`',
    `observation_text` STRING COMMENT 'The verbatim text of the observation, finding, or deficiency as documented by the regulatory inspector. This is the exact wording from the inspection report and must be preserved without modification for regulatory response purposes.',
    `proposed_corrective_action` STRING COMMENT 'The detailed description of the corrective and preventive actions (CAPA) proposed by the company to address the root cause of this observation and prevent recurrence. This text will be included in the formal response submission to the health authority.',
    `regulatory_action_risk` STRING COMMENT 'The assessed risk level that this observation may result in formal regulatory action such as warning letter, consent decree, import alert, or product recall. Based on observation severity, repeat status, and health authority enforcement history.. Valid values are `low|medium|high|critical`',
    `repeat_observation_flag` BOOLEAN COMMENT 'Boolean indicator of whether this observation is a repeat finding from a previous inspection at the same facility. Repeat observations carry higher regulatory risk and may trigger escalated enforcement action.',
    `response_due_date` DATE COMMENT 'The regulatory deadline by which the company must submit its formal response to the health authority addressing this observation. Typically 15 business days from inspection closeout for FDA inspections.',
    `response_owner_name` STRING COMMENT 'The full name of the individual or organizational unit assigned as the response owner for this observation.',
    `response_submission_date` DATE COMMENT 'The actual date on which the company submitted its formal written response to the health authority addressing this observation.',
    `risk_assessment_score` STRING COMMENT 'The internal risk score assigned to this observation based on the companys risk assessment methodology. Used to prioritize response efforts and resource allocation. Typically scored on a scale such as 1-25 based on severity and detectability.',
    `created_by` STRING COMMENT 'The user ID or name of the individual who created this observation record in the system. Audit trail field for data governance and compliance tracking.',
    CONSTRAINT pk_inspection_observation PRIMARY KEY(`inspection_observation_id`)
) COMMENT 'Individual observation, finding, or citation raised during a regulatory inspection. Captures observation reference number, observation text (verbatim from inspector), observation classification (critical, major, minor, informational), CFR/GMP citation, assigned response owner, proposed corrective action, response due date, health authority response submission date, and closure status. Each inspection generates multiple observations that must be tracked and responded to independently. Feeds the inspection response and CAPA workflow.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` (
    `inspection_response_id` BIGINT COMMENT 'Unique identifier for the inspection response record. Primary key for the inspection response entity.',
    `compliance_capa_id` BIGINT COMMENT 'Reference to the formal CAPA plan document that details the corrective and preventive actions committed to in this response. Links to quality management system.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Regulatory inspection responses require significant resources (external consultants, remediation activities, validation studies). Pharma companies track these costs via internal orders for financial p',
    `health_authority_id` BIGINT COMMENT 'Reference to the regulatory body that conducted the inspection and to whom this response is addressed. Examples include FDA, EMA, MHRA, PMDA.',
    `employee_id` BIGINT COMMENT 'Reference to the primary individual responsible for drafting and coordinating the inspection response. Typically a regulatory affairs professional or quality assurance manager.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Inspection responses are prepared and managed within the context of compliance programs. This FK associates each response with the relevant program (GMP, GCP, etc.) for program-level tracking of inspe',
    `quaternary_inspection_legal_reviewer_employee_id` BIGINT COMMENT 'Reference to the legal counsel who reviewed the response for legal risk and compliance implications. Null if no legal review was required.',
    `quinary_inspection_last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified the inspection response record. Supports audit trail and accountability requirements.',
    `regulatory_inspection_id` BIGINT COMMENT 'Reference to the regulatory inspection that triggered this response. Links to the parent inspection event.',
    `site_id` BIGINT COMMENT 'Reference to the manufacturing site, laboratory, or facility that was inspected and is the subject of this response.',
    `tertiary_inspection_quality_head_approver_employee_id` BIGINT COMMENT 'Reference to the senior quality executive who provided final approval for the response submission. Required signatory for formal regulatory responses.',
    `superseded_inspection_response_id` BIGINT COMMENT 'Self-referencing FK on inspection_response (superseded_inspection_response_id)',
    `actual_completion_date` DATE COMMENT 'Date when all committed corrective actions were verified as complete. Used to measure adherence to regulatory commitments.',
    `closure_date` DATE COMMENT 'Date when the health authority formally closed the inspection response matter, indicating satisfactory resolution of all observations.',
    `commitment_summary` STRING COMMENT 'High-level summary of the corrective and preventive actions (CAPA) committed to in the response. Provides executive overview of remediation strategy.',
    `consent_decree_related_flag` BOOLEAN COMMENT 'Indicates whether this response is related to an existing consent decree or regulatory agreement. True if consent decree obligations apply.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the inspection response record was first created in the system. Audit trail for record lifecycle tracking.',
    `executive_notification_flag` BOOLEAN COMMENT 'Indicates whether executive leadership was formally notified of this inspection response due to severity or business impact. True if executive notification occurred.',
    `health_authority_acceptance_status` STRING COMMENT 'Health authority determination on the adequacy of the response and proposed corrective actions. Drives follow-up actions and regulatory risk assessment. [ENUM-REF-CANDIDATE: pending_review|accepted|partially_accepted|rejected|additional_information_requested|closed_satisfactory|closed_unsatisfactory — 7 candidates stripped; promote to reference product]',
    `health_authority_acknowledgment_date` DATE COMMENT 'Date when the health authority formally acknowledged receipt of the response. Confirms successful delivery and initiates review period.',
    `health_authority_feedback` STRING COMMENT 'Official comments or additional requirements provided by the health authority in response to the submission. May include requests for clarification or supplemental information.',
    `impacted_product_list` STRING COMMENT 'Comma-separated list of product names or National Drug Code (NDC) numbers affected by the inspection findings. Used for impact assessment and regulatory reporting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the inspection response record. Tracks data currency and change history.',
    `legal_review_required_flag` BOOLEAN COMMENT 'Indicates whether legal counsel review was required for this response due to severity of findings or potential enforcement action. True if legal review was conducted.',
    `observation_count` STRING COMMENT 'Total number of inspection observations or findings being addressed in this response. Used for tracking response completeness and scope.',
    `product_impact_flag` BOOLEAN COMMENT 'Indicates whether the inspection findings and corrective actions impact marketed products, requiring potential regulatory notifications or market actions. True if products are impacted.',
    `reinspection_date` DATE COMMENT 'Scheduled or actual date of the follow-up inspection to verify corrective action implementation. Null if no reinspection is required.',
    `reinspection_required_flag` BOOLEAN COMMENT 'Indicates whether the health authority has mandated a follow-up inspection to verify implementation of corrective actions. True if reinspection is required.',
    `response_document_number` STRING COMMENT 'Unique business identifier for the formal response document submitted to the health authority. Used for tracking and referencing in regulatory correspondence.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `response_document_url` STRING COMMENT 'Link to the stored response document in the document management system. Provides access to the full formal response submission.',
    `response_document_version` STRING COMMENT 'Version number of the response document. Tracks revisions and resubmissions if additional information is requested by the health authority.. Valid values are `^vd+.d+$`',
    `response_language` STRING COMMENT 'Three-letter ISO 639-2 language code indicating the language in which the response was submitted. Typically matches the health authoritys official language.. Valid values are `^[A-Z]{3}$`',
    `response_status` STRING COMMENT 'Current lifecycle state of the inspection response. Tracks progression from initial drafting through health authority closure. [ENUM-REF-CANDIDATE: draft|under_review|approved|submitted|acknowledged|closed|reopened — 7 candidates stripped; promote to reference product]',
    `response_type` STRING COMMENT 'Classification of the response based on the type of regulatory communication being addressed. Determines the formality level and required content structure of the response.. Valid values are `form_483_response|warning_letter_response|untitled_letter_response|establishment_inspection_report_response|voluntary_action_indicated_response|official_action_indicated_response`',
    `risk_level` STRING COMMENT 'Assessment of the regulatory and business risk associated with the inspection findings and response. Drives escalation and resource allocation decisions.. Valid values are `low|medium|high|critical`',
    `submission_date` DATE COMMENT 'Date when the formal response was submitted to the health authority. Critical for tracking regulatory compliance timelines and commitments.',
    `submission_method` STRING COMMENT 'Method used to deliver the response to the health authority. Determines tracking and confirmation requirements.. Valid values are `electronic_submission|postal_mail|courier|hand_delivery|regulatory_portal`',
    `target_completion_date` DATE COMMENT 'Committed date by which all corrective actions outlined in the response will be fully implemented. Critical regulatory commitment tracked for compliance.',
    CONSTRAINT pk_inspection_response PRIMARY KEY(`inspection_response_id`)
) COMMENT 'Formal written response submitted to a health authority in reply to inspection observations, warning letters, or untitled letters. Captures response document reference, response type (483 response, warning letter response, establishment inspection report response), submission date, response author, regulatory affairs liaison, commitments made, timeline for corrective actions, and health authority acknowledgment status. Tracks the complete response lifecycle from drafting through health authority closure.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` (
    `part11_system_id` BIGINT COMMENT 'Unique identifier for the computerized system subject to 21 CFR Part 11 and EU Annex 11 regulations. Primary key.',
    `predecessor_part11_system_id` BIGINT COMMENT 'Self-referencing FK on part11_system (predecessor_part11_system_id)',
    `access_control_implemented` BOOLEAN COMMENT 'Indicates whether the system has access controls to limit system access to authorized individuals based on role and responsibility.',
    `access_control_method` STRING COMMENT 'Type of access control mechanism implemented to enforce authorization policies and restrict system functions.. Valid values are `role_based|attribute_based|mandatory|discretionary`',
    `annex11_applicable` BOOLEAN COMMENT 'Indicates whether the system is subject to EU Annex 11 requirements for computerized systems in GMP environments.',
    `audit_trail_enabled` BOOLEAN COMMENT 'Indicates whether the system has audit trail functionality enabled to capture secure, computer-generated, time-stamped electronic records of user actions.',
    `audit_trail_review_frequency` STRING COMMENT 'Frequency at which audit trail records are reviewed by quality assurance or system owners to detect unauthorized access or data manipulation.. Valid values are `daily|weekly|monthly|quarterly|event_driven`',
    `backup_recovery_validated` BOOLEAN COMMENT 'Indicates whether backup and disaster recovery procedures have been validated to ensure data availability and business continuity.',
    `change_control_required` BOOLEAN COMMENT 'Indicates whether changes to the system require formal change control procedures including impact assessment and revalidation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this system record was first created in the compliance inventory.',
    `data_integrity_controls` STRING COMMENT 'Level of data integrity controls implemented to ensure data is Attributable, Legible, Contemporaneous, Original, Accurate, Complete, Consistent, Enduring, and Available.. Valid values are `alcoa_plus_compliant|partial|not_implemented`',
    `data_residency_location` STRING COMMENT 'Geographic location or jurisdiction where system data is stored, critical for GDPR and data sovereignty compliance.',
    `decommission_date` DATE COMMENT 'Date when the system was retired from production use, requiring data archival and retention procedures per regulatory requirements.',
    `deployment_environment` STRING COMMENT 'Infrastructure deployment model for the system, impacting validation scope and data residency compliance.. Valid values are `on_premise|cloud|hybrid|saas`',
    `electronic_signature_enabled` BOOLEAN COMMENT 'Indicates whether the system supports electronic signatures that are legally binding equivalents to handwritten signatures under Part 11 requirements.',
    `electronic_signature_type` STRING COMMENT 'Method used for electronic signature implementation, ensuring unique identification and authentication of the signatory.. Valid values are `username_password|biometric|token_based|digital_certificate|hybrid`',
    `gdpr_applicable` BOOLEAN COMMENT 'Indicates whether the system processes personal data of EU residents and is subject to GDPR privacy and data protection requirements.',
    `go_live_date` DATE COMMENT 'Date when the system was first deployed into production and made available for business use following validation approval.',
    `gxp_criticality` STRING COMMENT 'Classification indicating whether the system directly impacts product quality, patient safety, or data integrity under GxP regulations (GMP, GLP, GCP, GDP).. Valid values are `gxp_critical|gxp_non_critical|non_gxp`',
    `hipaa_applicable` BOOLEAN COMMENT 'Indicates whether the system processes protected health information (PHI) and is subject to HIPAA privacy and security rules.',
    `inspection_findings` STRING COMMENT 'Classification of findings or observations from the last regulatory inspection related to this system.. Valid values are `no_findings|observations|warning_letter|form_483|critical`',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory inspection (FDA, EMA, MHRA) where this system was reviewed or audited.',
    `modified_by` STRING COMMENT 'User identifier of the individual who last modified this system record, ensuring accountability and traceability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this system record was last modified, supporting audit trail and change tracking requirements.',
    `part11_applicable` BOOLEAN COMMENT 'Indicates whether the system is subject to 21 CFR Part 11 requirements for electronic records and electronic signatures.',
    `part11_system_description` STRING COMMENT 'Detailed description of the systems business purpose, functional scope, and role in pharmaceutical operations.',
    `record_retention_period_years` STRING COMMENT 'Number of years that electronic records from this system must be retained to meet regulatory and business requirements.',
    `revalidation_due_date` DATE COMMENT 'Scheduled date for periodic revalidation or validation review to ensure continued system compliance and fitness for use.',
    `sox_controls_applicable` BOOLEAN COMMENT 'Indicates whether the system is subject to SOX internal controls over financial reporting, requiring additional audit and access controls.',
    `system_category` STRING COMMENT 'Functional category of the computerized system indicating its primary business domain and operational scope. [ENUM-REF-CANDIDATE: infrastructure|laboratory|manufacturing|clinical|quality|regulatory|commercial|supply_chain — 8 candidates stripped; promote to reference product]',
    `system_code` STRING COMMENT 'Unique alphanumeric code assigned to the system for identification and tracking purposes across compliance documentation.',
    `system_name` STRING COMMENT 'Official name of the computerized system as registered in the enterprise system inventory.',
    `system_owner` STRING COMMENT 'Name or identifier of the individual or department responsible for the systems business operation, compliance, and validation maintenance.',
    `system_status` STRING COMMENT 'Current operational status of the system in the enterprise inventory, indicating whether it is in active use or retired.. Valid values are `active|inactive|decommissioned|under_validation|suspended`',
    `system_version` STRING COMMENT 'Current version number or release identifier of the system software, critical for change control and validation documentation.',
    `validation_date` DATE COMMENT 'Date when the system validation was completed and approved, establishing the baseline for compliant operation.',
    `validation_status` STRING COMMENT 'Current validation state of the system under CSV requirements, indicating compliance with documented evidence of system fitness for intended use.. Valid values are `not_validated|validation_in_progress|validated|revalidation_required|retired`',
    `vendor_name` STRING COMMENT 'Name of the software vendor or system provider responsible for system development and support.',
    CONSTRAINT pk_part11_system PRIMARY KEY(`part11_system_id`)
) COMMENT 'Master record for computerized systems subject to 21 CFR Part 11 (FDA) and EU Annex 11 (EMA) electronic records and electronic signatures regulations. Captures system name, system owner, GxP criticality classification, validation status, audit trail capability, electronic signature implementation, access control configuration, system category (infrastructure, laboratory, manufacturing, clinical), and Part 11/Annex 11 compliance determination. Serves as the authoritative inventory of regulated computerized systems requiring Part 11/Annex 11 compliance management.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` (
    `esignature_event_id` BIGINT COMMENT 'Unique identifier for the electronic signature event. Primary key for the esignature_event product.',
    `part11_system_id` BIGINT COMMENT 'Identifier of the GxP-regulated computerized system in which the electronic signature event occurred.',
    `predecessor_signature_event_esignature_event_id` BIGINT COMMENT 'Identifier of the preceding electronic signature event in a sequential approval chain, if applicable.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the individual who executed the electronic signature. Links to the enterprise user or employee master.',
    `esignature_session_id` BIGINT COMMENT 'Unique identifier of the user session during which the electronic signature was executed, linking the signature to the broader audit trail.',
    `workflow_step_id` BIGINT COMMENT 'Identifier of the specific workflow step or approval stage at which the electronic signature was executed.',
    `countersign_esignature_event_id` BIGINT COMMENT 'Self-referencing FK on esignature_event (countersign_esignature_event_id)',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking this electronic signature event to the broader system audit trail or log entry for complete traceability.',
    `authentication_method` STRING COMMENT 'Method used to authenticate the signers identity at the time of signature execution (e.g., username/password, biometric, token-based, multi-factor authentication).. Valid values are `username_password|biometric|token|smart_card|multi_factor|single_sign_on`',
    `authentication_result` STRING COMMENT 'Outcome of the authentication attempt (success, failure, account locked, credentials expired).. Valid values are `success|failure|locked|expired`',
    `biometric_data_hash` STRING COMMENT 'Cryptographic hash of biometric data (fingerprint, retina scan) used for authentication, if biometric method was employed. Raw biometric data is not stored.',
    `compliance_validation_timestamp` TIMESTAMP COMMENT 'Date and time when the electronic signature event was validated for regulatory compliance by the system or quality assurance process.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this electronic signature event record was first created in the data lakehouse, recorded in UTC.',
    `delegation_flag` BOOLEAN COMMENT 'Indicates whether the signature was executed under delegated authority (True) or by the originally assigned individual (False).',
    `device_identifier` STRING COMMENT 'Unique identifier of the device (workstation, tablet, mobile device) used to execute the electronic signature.',
    `ip_address` STRING COMMENT 'Internet Protocol (IP) address of the device from which the electronic signature was executed, captured for audit trail and security purposes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this electronic signature event record was last modified in the data lakehouse, recorded in UTC.',
    `non_repudiation_token` STRING COMMENT 'Cryptographic hash or token generated at the time of signing to ensure non-repudiation and integrity of the signature event.',
    `record_reference` STRING COMMENT 'Unique identifier of the business record or document being signed within the source system (e.g., batch record ID, protocol ID, SOP ID).',
    `record_type` STRING COMMENT 'Type or category of the business record being signed. [ENUM-REF-CANDIDATE: batch_record|protocol|sop|deviation|capa|change_control|specification|validation_report|clinical_trial_document|manufacturing_instruction|quality_record|regulatory_submission|training_record|audit_report|investigation_report|other — promote to reference product]',
    `record_version_number` STRING COMMENT 'Version number or identifier of the business record at the time the electronic signature was executed, ensuring signature is tied to a specific record state.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether the electronic signature event meets all regulatory compliance requirements (21 CFR Part 11, EU Annex 11) at the time of execution.',
    `signature_image_path` STRING COMMENT 'File path or URI to the stored graphical representation of the electronic signature, if captured (e.g., stylus signature on tablet).',
    `signature_meaning` STRING COMMENT 'The intended meaning or purpose of the electronic signature as defined by the business process (e.g., reviewed, approved, authored, verified). [ENUM-REF-CANDIDATE: authored|reviewed|approved|verified|witnessed|acknowledged|released|rejected — 8 candidates stripped; promote to reference product]',
    `signature_reason` STRING COMMENT 'Optional free-text reason or comment provided by the signer at the time of signature execution, explaining the basis for their action.',
    `signature_sequence_number` STRING COMMENT 'Sequential order of this signature within a multi-signature workflow or approval chain for the same record.',
    `signature_status` STRING COMMENT 'Current status of the electronic signature event in its lifecycle.. Valid values are `completed|pending|failed|revoked|superseded`',
    `signature_timestamp` TIMESTAMP COMMENT 'Date and time when the electronic signature was executed, recorded in UTC with millisecond precision for audit trail integrity.',
    `signer_full_name` STRING COMMENT 'Full legal name of the individual who executed the electronic signature, captured at the time of signing for non-repudiation.',
    `signer_role` STRING COMMENT 'Functional role or job title of the signer at the time of signature execution (e.g., QA Manager, Manufacturing Supervisor, Principal Investigator).',
    `signer_username` STRING COMMENT 'Username or login ID of the individual who executed the electronic signature at the time of signing.',
    `source_system_name` STRING COMMENT 'Name of the source GxP-regulated system from which the electronic signature event was captured (e.g., Veeva Vault, MasterControl, TrackWise).',
    `workflow_step_name` STRING COMMENT 'Human-readable name or description of the workflow step at which the electronic signature was executed (e.g., QA Review, Final Approval).',
    CONSTRAINT pk_esignature_event PRIMARY KEY(`esignature_event_id`)
) COMMENT 'Transactional record capturing each electronic signature event executed within GxP-regulated computerized systems subject to 21 CFR Part 11 and EU Annex 11. Captures signer identity, signer role, system ID, record being signed, signature meaning (reviewed, approved, authored, verified), timestamp, authentication method (biometric, username/password), and non-repudiation confirmation. Provides the audit trail of electronic signature events required for regulatory compliance and inspection readiness.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` (
    `privacy_obligation_id` BIGINT COMMENT 'Unique identifier for the privacy obligation record. Primary key.',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Privacy regulations are country-specific (GDPR in EU, HIPAA in US). Data residency and transfer requirements vary. Essential for data governance, clinical trial compliance, patient consent management.',
    `data_processing_activity_id` BIGINT COMMENT 'Identifier linking this obligation to a specific data processing activity in the Record of Processing Activities (ROPA) required under GDPR Article 30.',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `primary_privacy_employee_id` BIGINT COMMENT 'Identifier of the individual or role responsible for ensuring compliance with this privacy obligation (typically a Data Protection Officer, Privacy Officer, or Compliance Manager).',
    `parent_privacy_obligation_id` BIGINT COMMENT 'Self-referencing FK on privacy_obligation (parent_privacy_obligation_id)',
    `applicable_data_category` STRING COMMENT 'The category of data to which this obligation applies (e.g., personal data, sensitive health data, clinical trial data, employee data, special category data). May be a comma-separated list for obligations spanning multiple categories.',
    `compliance_deadline` DATE COMMENT 'The date by which the organization must achieve or demonstrate compliance with this obligation. Null if no specific deadline applies.',
    `compliance_status` STRING COMMENT 'Current compliance status of the organization with respect to this privacy obligation.. Valid values are `compliant|non_compliant|in_progress|not_applicable|under_review`',
    `control_procedure_reference` STRING COMMENT 'Reference to the Standard Operating Procedure (SOP), policy document, or control framework that governs how this obligation is fulfilled.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this privacy obligation record was first created in the system.',
    `dpia_completion_date` DATE COMMENT 'Date when the Data Protection Impact Assessment was completed for this obligation, if applicable.',
    `dpia_required` BOOLEAN COMMENT 'Indicates whether a Data Protection Impact Assessment is required for this obligation under GDPR Article 35 or equivalent privacy regulations.',
    `effective_date` DATE COMMENT 'Date when this privacy obligation became effective and enforceable for the organization.',
    `escalation_procedure` STRING COMMENT 'Description of the escalation path and procedure to follow in case of non-compliance or breach related to this obligation.',
    `expiration_date` DATE COMMENT 'Date when this privacy obligation is no longer applicable or has been superseded by updated regulations. Null for ongoing obligations.',
    `external_reference_url` STRING COMMENT 'URL link to external guidance, regulatory text, or official documentation related to this privacy obligation.',
    `last_audit_date` DATE COMMENT 'Date of the most recent internal or external audit conducted to verify compliance with this privacy obligation.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the individual who last modified this privacy obligation record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this privacy obligation record was last updated or modified.',
    `legal_citation` STRING COMMENT 'Specific legal citation or article reference in the regulation that mandates this obligation (e.g., GDPR Article 33, HIPAA 45 CFR 164.404, CCPA Section 1798.150).',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this privacy obligation to ensure continued compliance and relevance.',
    `obligation_code` STRING COMMENT 'Business identifier code for the privacy obligation, used for external reference and reporting.. Valid values are `^[A-Z0-9_-]{4,20}$`',
    `obligation_description` STRING COMMENT 'Detailed description of the privacy obligation, including specific requirements, actions to be taken, and conditions under which the obligation is triggered.',
    `obligation_name` STRING COMMENT 'Human-readable name of the privacy obligation (e.g., GDPR Data Subject Access Request, HIPAA Breach Notification).',
    `obligation_type` STRING COMMENT 'Category of privacy obligation: consent management, data subject rights (access, erasure, portability), breach notification, data retention limits, cross-border transfer restrictions, or privacy impact assessment requirements.. Valid values are `consent_management|data_subject_rights|breach_notification|data_retention|cross_border_transfer|privacy_impact_assessment`',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Maximum financial penalty or fine amount for non-compliance with this obligation, in the specified currency.',
    `penalty_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the penalty amount (e.g., EUR, USD, GBP).. Valid values are `^[A-Z]{3}$`',
    `regulation_framework` STRING COMMENT 'The primary privacy regulation or framework that mandates this obligation (e.g., GDPR, CCPA, HIPAA, LGPD, PIPEDA, APPI).. Valid values are `GDPR|CCPA|HIPAA|LGPD|PIPEDA|APPI`',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory body or supervisory authority responsible for enforcing this privacy obligation (e.g., ICO, CNIL, FTC, HHS OCR).',
    `response_timeframe_hours` STRING COMMENT 'The maximum number of hours allowed to respond to or fulfill this obligation once triggered (e.g., 72 hours for GDPR breach notification, 30 days for data subject access requests).',
    `responsible_department` STRING COMMENT 'The business department or function responsible for implementing and maintaining compliance with this obligation (e.g., Legal, IT, Clinical Operations, Human Resources).',
    `review_frequency_months` STRING COMMENT 'Number of months between scheduled reviews of this privacy obligation (e.g., 6, 12, 24).',
    `risk_level` STRING COMMENT 'Risk severity level associated with non-compliance with this obligation, based on potential financial, reputational, and operational impact.. Valid values are `critical|high|medium|low`',
    `training_completion_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of required staff who have completed training related to this privacy obligation.',
    `training_required` BOOLEAN COMMENT 'Indicates whether staff training is required to ensure awareness and compliance with this privacy obligation.',
    CONSTRAINT pk_privacy_obligation PRIMARY KEY(`privacy_obligation_id`)
) COMMENT 'Master record for privacy and data protection obligations applicable to the enterprise under GDPR, CCPA, HIPAA, and other applicable privacy regulations. Captures the regulation, jurisdiction, obligation type (consent management, data subject rights, breach notification, data retention, cross-border transfer), applicable data categories (personal data, sensitive health data, clinical trial data), obligation owner, and compliance status. Distinct from gxp_obligation — this specifically covers privacy law obligations rather than GxP regulatory requirements.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` (
    `privacy_impact_assessment_id` BIGINT COMMENT 'Unique identifier for the privacy impact assessment record. Primary key for the privacy impact assessment entity.',
    `data_processing_activity_id` BIGINT COMMENT 'Foreign key linking to compliance.data_processing_activity. Business justification: Privacy Impact Assessments (PIAs/DPIAs) evaluate specific data processing activities for GDPR and privacy compliance. This FK links the assessment to the processing activity being evaluated. The proce',
    `privacy_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.privacy_obligation. Business justification: DPIAs (Data Protection Impact Assessments) are conducted to evaluate compliance with specific privacy obligations under GDPR, CCPA, etc. This FK links each assessment to the obligation(s) it evaluates',
    `superseded_privacy_impact_assessment_id` BIGINT COMMENT 'Self-referencing FK on privacy_impact_assessment (superseded_privacy_impact_assessment_id)',
    `approval_date` DATE COMMENT 'Date when the privacy impact assessment was formally approved by the accountable authority (e.g., data controller, privacy committee, executive sponsor).',
    `approved_by` STRING COMMENT 'Name and role of the individual who approved the privacy impact assessment. Demonstrates accountability under GDPR Article 5(2) and Article 24.',
    `assessment_completion_date` DATE COMMENT 'Date when the privacy impact assessment was completed and approved. Processing must not commence until DPIA is finalized and any required supervisory authority consultation is complete.',
    `assessment_conducted_by` STRING COMMENT 'Name and role of the individual or team who conducted the privacy impact assessment. Accountability requirement under GDPR Article 5(2) and Article 24.',
    `assessment_reference_number` STRING COMMENT 'Business-facing unique reference number for the privacy impact assessment, used for tracking and audit purposes. Format: PIA-YYYY-NNNNNN.. Valid values are `^PIA-[0-9]{4}-[0-9]{6}$`',
    `assessment_start_date` DATE COMMENT 'Date when the privacy impact assessment process was initiated. DPIA must be conducted before processing begins under GDPR Article 35(1) and Article 35(10).',
    `assessment_status` STRING COMMENT 'Current lifecycle status of the privacy impact assessment. Tracks progression from draft through DPO (Data Protection Officer) review to final approval or supervisory authority consultation. [ENUM-REF-CANDIDATE: draft|under_review|dpo_review|approved|rejected|requires_consultation|completed|archived — 8 candidates stripped; promote to reference product]',
    `assessment_type` STRING COMMENT 'Type of privacy assessment conducted. DPIA (Data Protection Impact Assessment) is required under GDPR Article 35 for high-risk processing; PIA is broader privacy assessment; threshold assessment determines if full DPIA is needed.. Valid values are `DPIA|PIA|threshold_assessment|full_assessment|light_touch_review|update_assessment`',
    `automated_decision_making` BOOLEAN COMMENT 'Indicates whether the processing involves automated decision-making including profiling that produces legal or similarly significant effects. Triggers mandatory DPIA under GDPR Article 35(3)(a).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this privacy impact assessment record was first created in the system. Part of audit trail required for GDPR accountability and 21 CFR Part 11 compliance.',
    `data_categories_processed` STRING COMMENT 'Comma-separated list of personal data categories processed (e.g., name, contact details, health records, genetic data, biometric identifiers, employment records). Required for GDPR Article 35(7)(b) assessment.',
    `data_protection_by_design` STRING COMMENT 'Description of how data protection by design and by default principles (GDPR Article 25) are implemented in the processing activity, including technical measures and default settings that minimize data processing.',
    `data_retention_period` STRING COMMENT 'Defined retention period for personal data processed in this activity. Must comply with GDPR Article 5(1)(e) storage limitation principle and applicable regulatory requirements (e.g., ICH E6 25-year retention for clinical trial data).',
    `data_subject_categories` STRING COMMENT 'Categories of individuals whose personal data is processed (e.g., clinical trial subjects, patients, healthcare professionals, employees, contractors). Required for GDPR Article 35(7)(b) assessment.',
    `data_subject_consultation` STRING COMMENT 'Description of how data subjects views were sought regarding the processing activity, where appropriate. GDPR Article 35(9) requires seeking views of data subjects or their representatives unless inappropriate.',
    `data_subject_count_estimate` STRING COMMENT 'Estimated number of data subjects whose personal data will be processed. Large-scale processing is a high-risk criterion under GDPR Article 35(3)(b) requiring mandatory DPIA.',
    `data_transfer_outside_eea` BOOLEAN COMMENT 'Indicates whether personal data is transferred outside the EEA. International transfers require additional safeguards under GDPR Chapter V (adequacy decision, standard contractual clauses, or binding corporate rules).',
    `document_location` STRING COMMENT 'File path or document management system reference to the full DPIA documentation. GDPR Article 35(7) requires documented assessment; Article 30 requires records of processing activities.',
    `dpo_consultation_date` DATE COMMENT 'Date when the DPO was consulted regarding the privacy impact assessment. Required for audit trail and GDPR Article 35(2) compliance demonstration.',
    `dpo_consulted` BOOLEAN COMMENT 'Indicates whether the Data Protection Officer was consulted during the DPIA process. DPO consultation is mandatory under GDPR Article 35(2) when conducting a DPIA.',
    `dpo_recommendation` STRING COMMENT 'DPOs advice and recommendations regarding the processing activity, risk mitigation measures, and compliance with GDPR. DPO must provide advice under GDPR Article 39(1)(c).',
    `large_scale_processing` BOOLEAN COMMENT 'Indicates whether the processing activity is considered large-scale under GDPR. Large-scale processing of special category data triggers mandatory DPIA under Article 35(3)(b).',
    `last_modified_by` STRING COMMENT 'User identifier of the person who last modified this privacy impact assessment record. Required for audit trail and accountability under GDPR Article 5(2) and 21 CFR Part 11.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this privacy impact assessment record was last modified. Required for audit trail and change tracking under GDPR Article 5(2) accountability principle and 21 CFR Part 11.',
    `legal_basis` STRING COMMENT 'Legal basis under GDPR Article 6 that justifies the processing of personal data. For special category data (health data in clinical trials), additional Article 9 basis must be documented separately.. Valid values are `consent|contract|legal_obligation|vital_interests|public_task|legitimate_interests`',
    `mitigation_measures` STRING COMMENT 'Detailed description of technical and organizational measures implemented to mitigate identified risks, including encryption, pseudonymization, access controls, data minimization, and safeguards. Required under GDPR Article 35(7)(d).',
    `necessity_assessment` STRING COMMENT 'Assessment of whether the processing is necessary for the specified purpose and whether the same purpose could be achieved with less intrusive means. Required under GDPR Article 35(7)(b) necessity and proportionality evaluation.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review of this privacy impact assessment. DPIAs must be reviewed regularly and updated when there are changes to processing operations, risks, or legal requirements.',
    `processing_purpose` STRING COMMENT 'Specific purpose(s) for which personal data is processed in this activity. Must be explicit, legitimate, and specified in accordance with GDPR Article 5(1)(b) purpose limitation principle.',
    `proportionality_assessment` STRING COMMENT 'Assessment of whether the processing is proportionate to the purpose, considering data minimization, storage limitation, and impact on data subjects. Required under GDPR Article 35(7)(b).',
    `residual_risk_level` STRING COMMENT 'Risk level remaining after implementation of mitigation measures. If residual risk remains high, supervisory authority consultation under GDPR Article 36 is mandatory.. Valid values are `low|medium|high|very_high`',
    `risk_identification_summary` STRING COMMENT 'Summary of identified risks to the rights and freedoms of data subjects arising from the processing activity. Includes risks of unauthorized access, data breach, discrimination, identity theft, or other harms. Required under GDPR Article 35(7)(c).',
    `risk_level` STRING COMMENT 'Overall assessed risk level to data subjects rights and freedoms. High or very high risk may require supervisory authority consultation under GDPR Article 36 before processing begins.. Valid values are `low|medium|high|very_high`',
    `special_category_data_processed` BOOLEAN COMMENT 'Indicates whether special category personal data (health data, genetic data, biometric data) is processed. True triggers heightened GDPR Article 9 requirements and mandatory DPIA under Article 35(3)(b).',
    `supervisory_authority_consultation_date` DATE COMMENT 'Date when the supervisory authority was consulted regarding the high-risk processing activity. Supervisory authority must respond within 8 weeks (extendable to 14 weeks) under GDPR Article 36(2).',
    `supervisory_authority_consultation_required` BOOLEAN COMMENT 'Indicates whether prior consultation with the supervisory authority is required under GDPR Article 36. Required when DPIA indicates high residual risk that cannot be adequately mitigated.',
    `supervisory_authority_response` STRING COMMENT 'Written advice received from the supervisory authority following consultation under GDPR Article 36. May include additional measures required or prohibition of processing.',
    `systematic_monitoring` BOOLEAN COMMENT 'Indicates whether the processing involves systematic monitoring of data subjects. Systematic monitoring of publicly accessible areas triggers mandatory DPIA under GDPR Article 35(3)(c).',
    `third_party_processors` STRING COMMENT 'List of third-party data processors (CROs, CMOs, cloud service providers) involved in the processing activity. Each processor must have a GDPR Article 28 data processing agreement in place.',
    `transfer_mechanism` STRING COMMENT 'Legal mechanism used for international data transfers outside EEA (e.g., EU-US Data Privacy Framework adequacy decision, Standard Contractual Clauses, Binding Corporate Rules). Required when data_transfer_outside_eea is true.. Valid values are `adequacy_decision|standard_contractual_clauses|binding_corporate_rules|derogation|not_applicable`',
    CONSTRAINT pk_privacy_impact_assessment PRIMARY KEY(`privacy_impact_assessment_id`)
) COMMENT 'Transactional record for Data Protection Impact Assessments (DPIAs) and Privacy Impact Assessments (PIAs) conducted for new or changed processing activities involving personal data. Captures processing activity description, data categories processed, data subjects affected, necessity and proportionality assessment, risk identification, risk mitigation measures, DPO consultation outcome, and supervisory authority consultation requirement. Required under GDPR Article 35 for high-risk processing activities including clinical trial data and patient health data.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`compliance`.`incident` (
    `incident_id` BIGINT COMMENT 'Unique identifier for the compliance incident record. Primary key.',
    `site_id` BIGINT COMMENT 'Identifier of the manufacturing site, clinical site, or facility where the incident occurred.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Compliance incidents (deviations, violations) trigger investigation and remediation work tracked via internal orders for cost capture, resource allocation, and project management. Standard practice in',
    `gxp_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.gxp_obligation. Business justification: Compliance incidents represent violations of specific regulatory obligations. Currently has affected_regulation and affected_regulation_section as text fields. This FK links each incident to the maste',
    `employee_id` BIGINT COMMENT 'Identifier of the quality or compliance manager who approved the closure of the incident.',
    `incident_employee_id` BIGINT COMMENT 'Identifier of the employee assigned as the primary owner responsible for investigating the incident.',
    `incident_reported_by_employee_id` BIGINT COMMENT 'Identifier of the employee or individual who initially reported the compliance incident.',
    `medicinal_product_id` BIGINT COMMENT 'Identifier of the drug product, drug substance, or investigational product affected by the incident, if applicable.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to masterdata.plant. Business justification: Compliance incidents (deviations, data integrity issues) occur at specific sites. Root cause and CAPA are site-specific. Essential for incident investigation, trend analysis, regulatory reporting. Rem',
    `program_id` BIGINT COMMENT 'Identifier of the compliance program under which this incident is tracked (e.g., GxP Compliance, SOX Controls, Privacy Program).',
    `related_incident_id` BIGINT COMMENT 'Self-referencing FK on incident (related_incident_id)',
    `actual_closure_date` DATE COMMENT 'Actual date when the incident was formally closed after completion of investigation and corrective actions.',
    `affected_batch_number` STRING COMMENT 'Batch or lot number of the affected product, if the incident is batch-specific.',
    `affected_function` STRING COMMENT 'Business function or department where the incident occurred (e.g., Manufacturing, Quality Control, Clinical Operations, Regulatory Affairs).',
    `affected_product_name` STRING COMMENT 'Name of the product affected by the compliance incident.',
    `affected_regulation` STRING COMMENT 'Primary regulation, standard, or requirement that was violated or potentially breached (e.g., 21 CFR Part 11, EU Annex 11, GDPR Article 32, SOX Section 404).',
    `affected_regulation_section` STRING COMMENT 'Specific section, article, or clause of the regulation that was violated.',
    `authority_notification_date` DATE COMMENT 'Date when the regulatory authority was notified of the incident, if reportable.',
    `authority_reference_number` STRING COMMENT 'Reference or tracking number assigned by the regulatory authority upon notification.',
    `capa_required` BOOLEAN COMMENT 'Indicates whether a formal CAPA is required to address the root cause and prevent recurrence.',
    `closure_approved_by_name` STRING COMMENT 'Full name of the individual who approved the incident closure.',
    `containment_effective` BOOLEAN COMMENT 'Indicates whether immediate containment actions were effective in preventing further impact.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the compliance incident record was first created in the system.',
    `discovery_date` DATE COMMENT 'Date when the compliance incident was first identified or discovered.',
    `discovery_timestamp` TIMESTAMP COMMENT 'Precise date and time when the compliance incident was first identified, including timezone.',
    `escalation_date` DATE COMMENT 'Date when the incident was escalated to a higher management level.',
    `escalation_status` STRING COMMENT 'Indicates the level to which the incident has been escalated within the organization based on severity and impact.. Valid values are `not_escalated|escalated_to_management|escalated_to_executive|escalated_to_board`',
    `immediate_action_taken` STRING COMMENT 'Description of immediate containment or corrective actions taken upon discovery of the incident to prevent further impact.',
    `incident_category` STRING COMMENT 'Primary classification of the compliance incident type. Categories align with major compliance program areas.. Valid values are `gxp_violation|sox_control_failure|privacy_breach|data_integrity|anti_bribery|sunshine_act_failure`',
    `incident_description` STRING COMMENT 'Detailed narrative description of the compliance incident, including what occurred, where, and initial observations.',
    `incident_number` STRING COMMENT 'Business-facing unique incident tracking number assigned upon incident creation. Format: INC-YYYYMMDD-sequence.. Valid values are `^INC-[0-9]{8}$`',
    `incident_status` STRING COMMENT 'Current lifecycle status of the compliance incident in the investigation and resolution workflow.. Valid values are `open|under_investigation|pending_capa|capa_in_progress|closed|cancelled`',
    `investigation_owner_name` STRING COMMENT 'Full name of the employee responsible for leading the incident investigation.',
    `jurisdiction` STRING COMMENT 'Geographic jurisdiction or country where the incident occurred or has regulatory implications. ISO 3166-1 alpha-3 country code.. Valid values are `^[A-Z]{3}$`',
    `last_modified_by` STRING COMMENT 'Username or identifier of the user who last modified the incident record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the compliance incident record was last updated.',
    `occurrence_date` DATE COMMENT 'Actual or estimated date when the compliance incident occurred or began. May differ from discovery date.',
    `regulatory_authority` STRING COMMENT 'Primary regulatory body with jurisdiction over the affected regulation (FDA, EMA, MHRA, PMDA, NMPA, DEA, etc.). [ENUM-REF-CANDIDATE: fda|ema|mhra|pmda|nmpa|dea|other — 7 candidates stripped; promote to reference product]',
    `reportable_to_authority` BOOLEAN COMMENT 'Indicates whether the incident must be reported to a regulatory authority per applicable regulations.',
    `reported_by_name` STRING COMMENT 'Full name of the individual who reported the incident.',
    `risk_rating` STRING COMMENT 'Overall risk rating considering both likelihood and impact of the compliance incident.. Valid values are `high|medium|low`',
    `root_cause_category` STRING COMMENT 'High-level classification of the root cause type.. Valid values are `human_error|process_failure|system_failure|training_gap|documentation_error|equipment_malfunction`',
    `root_cause_description` STRING COMMENT 'Detailed description of the identified root cause(s) of the compliance incident, determined through investigation.',
    `severity_level` STRING COMMENT 'Assessment of the incident severity based on potential impact to patient safety, product quality, regulatory standing, and business operations.. Valid values are `critical|major|moderate|minor`',
    `subcategory` STRING COMMENT 'Secondary classification providing additional granularity within the incident category (e.g., GMP deviation, GCP protocol violation, GDPR breach).',
    `target_closure_date` DATE COMMENT 'Planned or target date by which the incident investigation and all corrective actions should be completed.',
    `title` STRING COMMENT 'Brief descriptive title summarizing the nature of the compliance incident.',
    CONSTRAINT pk_incident PRIMARY KEY(`incident_id`)
) COMMENT 'Transactional record for compliance incidents, violations, and potential breaches identified across all compliance program areas including GxP violations, SOX control failures, privacy breaches, anti-bribery violations, and Sunshine Act reporting failures. Captures incident description, discovery date, discovery source (self-identified, audit, inspection, whistleblower), incident category, severity, affected regulation, root cause, immediate containment actions, and escalation status. Distinct from quality.deviation (manufacturing/lab deviations) — this covers compliance-specific incidents across all regulatory domains.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` (
    `compliance_capa_id` BIGINT COMMENT 'Unique identifier for the compliance CAPA record. Primary key for compliance-function-owned CAPAs addressing regulatory, SOX, and privacy remediation.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.cost_center. Business justification: Compliance CAPAs incur costs (remediation, system upgrades, consulting). Cost centers track compliance spending for budgeting and variance analysis. Required for financial planning, cost allocation, a',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the employee or role responsible for executing and completing the CAPA actions.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Compliance CAPAs from inspections/audits require budget allocation for remediation activities (consulting, equipment, validation). Finance tracks CAPA costs against approved budgets for cost control a',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Compliance CAPAs should link to finance internal orders for remediation budget tracking and cost allocation. This enables accurate tracking of compliance remediation costs and budget management for re',
    `gxp_obligation_id` BIGINT COMMENT 'Foreign key reference to the specific GxP obligation that was violated or at risk, if applicable.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to compliance.incident. Business justification: CAPAs are frequently initiated in response to compliance incidents. This FK allows linking a CAPA to the specific incident it remediates. The triggering_event_id already captures the event type, but i',
    `program_id` BIGINT COMMENT 'Foreign key reference to the compliance program under which this CAPA is managed.',
    `sox_control_test_id` BIGINT COMMENT 'Reference identifier for the SOX control that was deficient, if this CAPA addresses a SOX control deficiency.',
    `triggering_event_id` BIGINT COMMENT 'Reference identifier for the originating event (e.g., inspection observation number, audit finding ID, SOX control ID, incident ticket number).',
    `originating_compliance_capa_id` BIGINT COMMENT 'Self-referencing FK on compliance_capa (originating_compliance_capa_id)',
    `action_owner_department` STRING COMMENT 'Department or functional area of the action owner (e.g., Regulatory Affairs, Quality Assurance, IT Compliance, Legal).',
    `action_owner_name` STRING COMMENT 'Full name of the individual assigned as the action owner for this compliance CAPA.',
    `actual_completion_date` DATE COMMENT 'Actual date when all CAPA actions were completed. Null if still in progress.',
    `affected_regulation` STRING COMMENT 'Specific regulation, standard, or requirement that was violated or at risk (e.g., 21 CFR Part 11, EU Annex 11, GDPR Article 32, SOX Section 404).',
    `capa_number` STRING COMMENT 'Business identifier for the compliance CAPA, typically formatted as CCAPA-NNNNNN. Used for external communication and tracking.. Valid values are `^CCAPA-[0-9]{6,10}$`',
    `capa_status` STRING COMMENT 'Current lifecycle status of the compliance CAPA: open (initiated), in progress (actions underway), pending review (awaiting approval), effectiveness check (verifying success), closed (completed and verified), or cancelled (no longer applicable).. Valid values are `open|in_progress|pending_review|effectiveness_check|closed|cancelled`',
    `capa_type` STRING COMMENT 'Classification of the CAPA as corrective (addressing existing deficiency), preventive (mitigating potential risk), or combined (both corrective and preventive actions).. Valid values are `corrective|preventive|combined`',
    `closure_verification_by` STRING COMMENT 'Name or role of the individual who verified and approved CAPA closure (typically compliance manager, quality director, or regulatory lead).',
    `closure_verification_date` DATE COMMENT 'Date when the CAPA was formally verified as complete and closed.',
    `corrective_action_plan` STRING COMMENT 'Detailed description of corrective actions to be taken to address the existing compliance deficiency and prevent recurrence.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the compliance CAPA record was first created in the system.',
    `data_integrity_alcoa_plus_flag` BOOLEAN COMMENT 'Boolean indicator whether this CAPA addresses a data integrity deficiency related to ALCOA+ principles (Attributable, Legible, Contemporaneous, Original, Accurate, Complete, Consistent, Enduring, Available).',
    `effectiveness_check_criteria` STRING COMMENT 'Defined criteria and metrics to verify that the CAPA actions effectively resolved the deficiency and prevented recurrence.',
    `effectiveness_check_date` DATE COMMENT 'Date when the effectiveness check was performed to verify CAPA success.',
    `effectiveness_check_result` STRING COMMENT 'Outcome of the effectiveness check: effective (CAPA resolved issue), partially effective (some improvement), ineffective (issue persists), or pending (check not yet performed).. Valid values are `effective|partially_effective|ineffective|pending`',
    `escalation_date` DATE COMMENT 'Date when the CAPA was escalated to higher authority or governance body.',
    `escalation_required_flag` BOOLEAN COMMENT 'Boolean indicator whether this CAPA requires escalation to senior management, regulatory authority, or board-level governance committee.',
    `inspection_citation_reference` STRING COMMENT 'Specific citation or observation number from regulatory inspection report (e.g., FDA 483 observation number, EMA inspection finding reference).',
    `last_modified_by` STRING COMMENT 'Username or identifier of the individual who last modified the compliance CAPA record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the compliance CAPA record was last updated.',
    `preventive_action_plan` STRING COMMENT 'Detailed description of preventive actions to be taken to mitigate similar compliance risks in other areas or future scenarios.',
    `regulatory_authority` STRING COMMENT 'Regulatory body or authority associated with the triggering event (FDA, EMA, MHRA, PMDA, NMPA, DEA, PIC/S) or internal if self-identified. [ENUM-REF-CANDIDATE: FDA|EMA|MHRA|PMDA|NMPA|DEA|PIC/S|internal|other — 9 candidates stripped; promote to reference product]',
    `regulatory_response_due_date` DATE COMMENT 'Deadline by which formal response to regulatory authority must be submitted.',
    `regulatory_response_required_flag` BOOLEAN COMMENT 'Boolean indicator whether a formal response to regulatory authority is required for this CAPA (e.g., FDA 483 response, EMA inspection response).',
    `regulatory_response_submitted_date` DATE COMMENT 'Date when formal response to regulatory authority was submitted.',
    `risk_level` STRING COMMENT 'Risk assessment of the deficiency impact on patient safety, product quality, data integrity, or regulatory standing.. Valid values are `high|medium|low`',
    `root_cause_analysis_method` STRING COMMENT 'Methodology used to determine root cause: 5 Whys, Fishbone (Ishikawa), Fault Tree Analysis, Pareto Analysis, Failure Mode and Effects Analysis (FMEA), or other structured approach.. Valid values are `5_whys|fishbone|fault_tree|pareto|failure_mode_effects_analysis|other`',
    `root_cause_category` STRING COMMENT 'High-level categorization of the root cause: process deficiency, people/competency gap, technology/system failure, documentation inadequacy, training gap, or oversight/governance weakness.. Valid values are `process|people|technology|documentation|training|oversight`',
    `root_cause_determination` STRING COMMENT 'Detailed narrative of the identified root cause(s) of the compliance deficiency, based on the RCA methodology applied.',
    `severity_level` STRING COMMENT 'Severity classification of the compliance deficiency: critical (immediate regulatory action risk), major (significant compliance gap), moderate (notable issue), minor (low impact).. Valid values are `critical|major|moderate|minor`',
    `target_completion_date` DATE COMMENT 'Planned date by which all corrective and preventive actions must be completed.',
    `title` STRING COMMENT 'Brief descriptive title summarizing the compliance CAPA issue and remediation focus.',
    `triggering_event_date` DATE COMMENT 'Date when the triggering event occurred or was identified (e.g., inspection date, audit date, incident date).',
    `triggering_event_type` STRING COMMENT 'Category of event that initiated the compliance CAPA. Includes regulatory inspections, audit findings, SOX control deficiencies, GDPR breaches, and data integrity incidents.. Valid values are `regulatory_inspection|internal_audit|external_audit|sox_control_deficiency|gdpr_breach|data_integrity_incident`',
    CONSTRAINT pk_compliance_capa PRIMARY KEY(`compliance_capa_id`)
) COMMENT 'Corrective and Preventive Action records specific to the compliance domain, managing remediation of compliance incidents, control deficiencies, inspection observations, and audit findings that fall outside the quality management system scope. Captures CAPA ID, triggering event, root cause analysis methodology, root cause determination, corrective action plan, preventive action plan, action owner, target completion date, effectiveness check criteria, and closure verification. Distinct from quality.capa (which manages GxP manufacturing/lab CAPAs) — this covers compliance-function-owned CAPAs for regulatory, SOX, and privacy remediation.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` (
    `sox_control_test_id` BIGINT COMMENT 'Unique identifier for the SOX control test execution record.',
    `internal_control_id` BIGINT COMMENT 'Reference to the specific SOX control being tested under the Internal Control over Financial Reporting (ICFR) framework.',
    `employee_id` BIGINT COMMENT 'Identifier of the individual who performed the control test, typically from internal audit or management.',
    `reviewer_employee_id` BIGINT COMMENT 'Identifier of the individual who reviewed the test results, typically a senior auditor or manager.',
    `previous_sox_control_test_id` BIGINT COMMENT 'Self-referencing FK on sox_control_test (previous_sox_control_test_id)',
    `account_affected` STRING COMMENT 'General Ledger account or financial statement line item that this control is designed to protect.',
    `automation_level` STRING COMMENT 'Degree to which the control is automated versus requiring manual intervention.. Valid values are `manual|automated|hybrid`',
    `control_code` STRING COMMENT 'Business identifier for the control being tested, typically following organizational control numbering scheme.. Valid values are `^[A-Z0-9]{3,20}$`',
    `control_frequency` STRING COMMENT 'How often the control is designed to operate during the test period.. Valid values are `daily|weekly|monthly|quarterly|annually|event_driven`',
    `control_type` STRING COMMENT 'Nature of the control: preventive (stops errors before they occur), detective (identifies errors after occurrence), or corrective (remediates identified errors).. Valid values are `preventive|detective|corrective`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this test record was first created in the system.',
    `deficiency_classification` STRING COMMENT 'Severity classification of any identified control deficiency: control deficiency (minor), significant deficiency (important but not material), or material weakness (reasonable possibility of material misstatement).. Valid values are `no_deficiency|control_deficiency|significant_deficiency|material_weakness`',
    `entity_level_control_flag` BOOLEAN COMMENT 'Indicates whether this is an entity-level control that operates across the organization rather than at a process level.',
    `exception_description` STRING COMMENT 'Detailed narrative describing the nature of exceptions or control deviations identified during the test.',
    `exceptions_identified_count` STRING COMMENT 'Number of exceptions or deviations from the expected control operation identified during testing.',
    `external_auditor_reliance_flag` BOOLEAN COMMENT 'Indicates whether the external auditor plans to rely on this management test for their SOX 404 opinion.',
    `financial_statement_assertion` STRING COMMENT 'The specific financial statement assertion(s) addressed by this control (e.g., existence, completeness, valuation, rights and obligations, presentation and disclosure).',
    `fiscal_quarter` STRING COMMENT 'Fiscal quarter within the year for which the control test is performed.. Valid values are `Q1|Q2|Q3|Q4`',
    `fiscal_year` STRING COMMENT 'Fiscal year for which the SOX 404 assessment is being performed.',
    `it_dependent_flag` BOOLEAN COMMENT 'Indicates whether the control relies on IT general controls or application controls for its effectiveness.',
    `key_control_flag` BOOLEAN COMMENT 'Indicates whether this is a key control that directly addresses a significant risk to financial reporting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this test record was last updated.',
    `management_conclusion` STRING COMMENT 'Managements overall conclusion on the operating effectiveness of the control based on test results.. Valid values are `effective|ineffective|not_tested|not_applicable`',
    `population_size` STRING COMMENT 'Total number of transactions or items in the population from which the test sample was selected.',
    `process_area` STRING COMMENT 'Business process area to which this control belongs (e.g., Revenue Recognition, Inventory Valuation, Payroll, Fixed Assets).',
    `remediation_due_date` DATE COMMENT 'Target date by which remediation actions must be completed.',
    `remediation_plan` STRING COMMENT 'Description of the corrective action plan to address identified deficiencies.',
    `remediation_required_flag` BOOLEAN COMMENT 'Indicates whether corrective action or remediation is required based on test results.',
    `review_date` DATE COMMENT 'Date on which the test results were reviewed and approved.',
    `sample_selection_method` STRING COMMENT 'Statistical or non-statistical approach used to select the sample from the population for testing.. Valid values are `random|systematic|judgmental|stratified|haphazard`',
    `sample_size` STRING COMMENT 'Number of items selected for testing from the population.',
    `test_documentation_reference` STRING COMMENT 'Reference to the location or document management system identifier where detailed test workpapers and evidence are stored.',
    `test_execution_date` DATE COMMENT 'Date on which the control test was actually performed by the tester.',
    `test_objective` STRING COMMENT 'Specific objective or assertion being tested for this control (e.g., completeness, accuracy, authorization, existence).',
    `test_period_end_date` DATE COMMENT 'Ending date of the period for which the control effectiveness is being tested.',
    `test_period_start_date` DATE COMMENT 'Beginning date of the period for which the control effectiveness is being tested.',
    `test_status` STRING COMMENT 'Current lifecycle status of the control test execution.. Valid values are `planned|in_progress|completed|reviewed|approved`',
    `tester_name` STRING COMMENT 'Full name of the individual who executed the control test.',
    `tester_role` STRING COMMENT 'Organizational role of the individual performing the test, indicating whether performed by management or audit function.. Valid values are `management|internal_audit|external_audit|compliance_officer`',
    `testing_approach` STRING COMMENT 'Methodology used to test the control effectiveness: inquiry (asking questions), observation (watching process), inspection (examining evidence), or reperformance (executing control independently).. Valid values are `inquiry|observation|inspection|reperformance`',
    CONSTRAINT pk_sox_control_test PRIMARY KEY(`sox_control_test_id`)
) COMMENT 'Transactional record for SOX Section 404 internal control over financial reporting (ICFR) test executions performed by management and internal audit. Captures control reference, test period, tester identity, testing approach (inquiry, observation, inspection, re-performance), population size, sample selection methodology, exceptions identified, deficiency classification (control deficiency, significant deficiency, material weakness), and management conclusion. Feeds the annual SOX 404 management assessment and supports external auditor reliance.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` (
    `monitoring_activity_id` BIGINT COMMENT 'Unique identifier for the compliance monitoring activity record. Primary key for the compliance monitoring activity entity.',
    `gxp_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.gxp_obligation. Business justification: Compliance monitoring activities verify adherence to specific GxP obligations (GMP, GCP, GLP, etc.). This FK links each monitoring activity to the obligation(s) being assessed, enabling obligation-lev',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the employee who conducted the compliance monitoring activity. Links to the human resources employee master data.',
    `program_id` BIGINT COMMENT 'Foreign key reference to the enterprise compliance program under which this monitoring activity was conducted. Links to the compliance program master data.',
    `quality_capa_id` BIGINT COMMENT 'Foreign key reference to the formal Corrective and Preventive Action (CAPA) record initiated as a result of this monitoring activity. Null if no CAPA was required or has not yet been created.',
    `reviewer_employee_id` BIGINT COMMENT 'Foreign key reference to the employee who reviewed and approved the monitoring activity results. Links to the human resources employee master data.',
    `followup_monitoring_activity_id` BIGINT COMMENT 'Self-referencing FK on monitoring_activity (followup_monitoring_activity_id)',
    `activity_number` STRING COMMENT 'Business-facing unique identifier for the compliance monitoring activity, formatted as CMA-YYYYNNNN for external reference and tracking.. Valid values are `^CMA-[0-9]{8}$`',
    `alcoa_plus_assessment_flag` BOOLEAN COMMENT 'Boolean indicator of whether this monitoring activity specifically assessed data integrity compliance against ALCOA+ principles (Attributable, Legible, Contemporaneous, Original, Accurate, Complete, Consistent, Enduring, Available). True indicates ALCOA+ assessment was performed.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the monitoring activity results were formally reviewed and approved by the compliance reviewer. Represents a distinct lifecycle event from creation and modification.',
    `capa_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether formal Corrective and Preventive Action (CAPA) is required based on the monitoring findings. True indicates CAPA must be initiated; false indicates findings can be addressed through informal actions or no action required.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance monitoring activity record was first created in the system. Audit trail field for data lineage and compliance tracking.',
    `evidence_location` STRING COMMENT 'File path, document management system location, or repository reference where supporting evidence and documentation for the monitoring activity is stored.',
    `execution_date` DATE COMMENT 'Date when the compliance monitoring activity was actually performed or executed. Represents the real-world business event timestamp for the monitoring action.',
    `findings_count` STRING COMMENT 'Total number of compliance findings, observations, or exceptions identified during the monitoring activity. Zero indicates no issues found.',
    `findings_summary` STRING COMMENT 'High-level summary of the compliance findings identified during the monitoring activity, including nature of issues, patterns observed, and key concerns raised.',
    `fiscal_quarter` STRING COMMENT 'Fiscal quarter in which the monitoring activity was executed, used for compliance program reporting and trend analysis.. Valid values are `Q1|Q2|Q3|Q4`',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the monitoring activity was executed, used for compliance program reporting and trend analysis.',
    `inspection_readiness_impact` STRING COMMENT 'Assessment of how the monitoring findings impact the organizations readiness for regulatory inspection. Positive indicates findings improve readiness; neutral indicates no impact; negative indicates findings expose inspection vulnerabilities.. Valid values are `positive|neutral|negative`',
    `jurisdiction` STRING COMMENT 'Three-letter country code representing the regulatory jurisdiction applicable to this monitoring activity. Examples include USA for United States Food and Drug Administration (FDA), GBR for United Kingdom Medicines and Healthcare products Regulatory Agency (MHRA), JPN for Japan Pharmaceuticals and Medical Devices Agency (PMDA).. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance monitoring activity record was most recently updated. Audit trail field for data lineage and compliance tracking.',
    `monitor_name` STRING COMMENT 'Full name of the compliance professional or auditor who conducted the monitoring activity.',
    `monitored_function` STRING COMMENT 'Name of the business function or department being monitored, such as Commercial, Clinical Operations, Manufacturing, Quality Assurance, Regulatory Affairs, or Medical Affairs.',
    `monitored_site_code` STRING COMMENT 'Code identifying the specific site, facility, or location being monitored. May reference manufacturing plants, clinical sites, distribution centers, or office locations.',
    `monitored_site_name` STRING COMMENT 'Full name of the site, facility, or location being monitored for compliance.',
    `monitoring_methodology` STRING COMMENT 'Approach or method used to conduct the compliance monitoring activity. Includes desk review of documentation, on-site inspection, remote audit, data analytics and automated monitoring, statistical sampling, or continuous monitoring techniques.. Valid values are `desk_review|on_site_inspection|remote_audit|data_analytics|sampling|continuous_monitoring`',
    `monitoring_notes` STRING COMMENT 'Additional notes, observations, or contextual information captured during the monitoring activity that provide supplementary detail beyond the structured findings.',
    `monitoring_period_end_date` DATE COMMENT 'End date of the period being monitored. Defines the conclusion of the timeframe for which compliance activities are being reviewed.',
    `monitoring_period_start_date` DATE COMMENT 'Start date of the period being monitored. Defines the beginning of the timeframe for which compliance activities are being reviewed.',
    `monitoring_scope` STRING COMMENT 'Detailed description of the scope of the compliance monitoring activity, including specific processes, systems, sites, or functions being monitored and the boundaries of the monitoring effort.',
    `monitoring_status` STRING COMMENT 'Current lifecycle status of the compliance monitoring activity. Tracks progression from planning through execution to completion or cancellation.. Valid values are `planned|in_progress|completed|cancelled|on_hold`',
    `monitoring_type` STRING COMMENT 'Category of compliance monitoring activity being conducted. Includes Healthcare Professional (HCP) engagement monitoring for Sunshine Act compliance, promotional materials compliance monitoring, clinical trial compliance monitoring, Good Practice (GxP) process compliance monitoring, data integrity monitoring per ALCOA+ principles, and Sarbanes-Oxley (SOX) control monitoring.. Valid values are `hcp_engagement|promotional_materials|clinical_trial|gxp_process|data_integrity|sox_control`',
    `population_size` STRING COMMENT 'Total number of records, transactions, or items in the population from which the monitoring sample was drawn. Provides context for sample representativeness.',
    `recommended_actions` STRING COMMENT 'Detailed recommendations for corrective actions, process improvements, or remediation steps to address the findings identified during the monitoring activity.',
    `regulatory_framework` STRING COMMENT 'Primary regulatory framework or standard against which compliance is being monitored, such as 21 CFR Part 11, Good Manufacturing Practice (GMP), Good Clinical Practice (GCP), Good Laboratory Practice (GLP), Sarbanes-Oxley (SOX), General Data Protection Regulation (GDPR), or Sunshine Act.',
    `remediation_due_date` DATE COMMENT 'Target date by which remediation actions or corrective measures must be completed to address the monitoring findings. Null if no remediation is required.',
    `remediation_status` STRING COMMENT 'Current status of remediation efforts to address the monitoring findings. Tracks progress from identification through completion of corrective actions.. Valid values are `not_required|pending|in_progress|completed|overdue`',
    `reviewer_name` STRING COMMENT 'Full name of the compliance manager or supervisor who reviewed and approved the monitoring activity results.',
    `risk_rating` STRING COMMENT 'Overall risk rating assigned to the findings from the monitoring activity. Critical indicates immediate regulatory or patient safety risk; high indicates significant compliance risk; medium indicates moderate risk requiring attention; low indicates minor issues; none indicates no issues identified.. Valid values are `critical|high|medium|low|none`',
    `sample_size` STRING COMMENT 'Number of records, transactions, or items included in the monitoring sample when sampling methodology is used. Null for full population reviews or continuous monitoring.',
    CONSTRAINT pk_monitoring_activity PRIMARY KEY(`monitoring_activity_id`)
) COMMENT 'Transactional record for proactive compliance monitoring activities conducted by the compliance function across business units and functions. Covers HCP engagement monitoring (Sunshine Act), promotional materials compliance monitoring, clinical trial compliance monitoring, and GxP process compliance monitoring. Captures monitoring activity type, scope, period, monitored function/site, monitoring methodology, findings, risk rating, and recommended actions. Supports the enterprise compliance monitoring program and provides early warning of compliance risks before they become incidents.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` (
    `risk_register_id` BIGINT COMMENT 'Unique identifier for the compliance risk register entry. Primary key for the compliance risk register.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who is accountable for managing and monitoring this compliance risk. Typically a senior leader or functional head.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Compliance risks are identified, assessed, and managed within the context of specific compliance programs. This FK associates each risk with its governing program, enabling program-level risk reportin',
    `quaternary_risk_last_modified_by_employee_id` BIGINT COMMENT 'Identifier of the employee who most recently modified this compliance risk register record. Required for 21 CFR Part 11 electronic signature and audit trail compliance.',
    `tertiary_risk_created_by_employee_id` BIGINT COMMENT 'Identifier of the employee who created this compliance risk register record. Required for 21 CFR Part 11 electronic signature and audit trail compliance.',
    `parent_risk_register_id` BIGINT COMMENT 'Self-referencing FK on risk_register (parent_risk_register_id)',
    `applicable_jurisdiction` STRING COMMENT 'Geographic or regulatory jurisdiction(s) where this compliance risk applies. Comma-separated list of ISO 3166-1 alpha-3 country codes or regional identifiers (e.g., USA, GBR, DEU, EU, APAC).',
    `board_reporting_flag` BOOLEAN COMMENT 'Indicates whether this compliance risk is included in Board Audit Committee reporting. True for Critical risks, material compliance exposures, and risks with significant financial or reputational impact.',
    `control_effectiveness` STRING COMMENT 'Assessment of how well existing controls are operating to mitigate the compliance risk. Effective indicates controls are operating as designed; Partially Effective indicates gaps or weaknesses; Ineffective indicates controls are not functioning; Not Tested indicates controls have not been evaluated.. Valid values are `Effective|Partially Effective|Ineffective|Not Tested`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance risk register record was first created in the system. Used for audit trail and data lineage.',
    `escalation_required_flag` BOOLEAN COMMENT 'Indicates whether this compliance risk requires escalation to executive leadership or Board Audit Committee. True for Critical risks, risks exceeding appetite, or risks with overdue treatment plans.',
    `existing_controls_description` STRING COMMENT 'Narrative description of current controls, processes, and safeguards in place to mitigate the compliance risk. Includes preventive controls, detective controls, and corrective controls.',
    `identification_date` DATE COMMENT 'Date when the compliance risk was first identified and entered into the risk register.',
    `identification_source` STRING COMMENT 'Origin or method by which the compliance risk was identified. Sources include internal audit findings, external audit observations, regulatory inspection findings, self-assessment activities, Corrective and Preventive Action (CAPA) investigations, incident reports, management review, or third-party assessments. [ENUM-REF-CANDIDATE: Internal Audit|External Audit|Regulatory Inspection|Self-Assessment|CAPA|Incident Report|Management Review|Third-Party Assessment — 8 candidates stripped; promote to reference product]',
    `inherent_impact` STRING COMMENT 'Severity or magnitude of consequences if the compliance risk materializes, without considering existing controls. Rated on a five-point scale from Very Low to Very High. Impact dimensions include patient safety, product quality, regulatory sanctions, financial loss, and reputational damage.. Valid values are `Very Low|Low|Medium|High|Very High`',
    `inherent_likelihood` STRING COMMENT 'Probability or frequency of the compliance risk occurring in the absence of any controls. Rated on a five-point scale from Very Low to Very High.. Valid values are `Very Low|Low|Medium|High|Very High`',
    `inherent_risk_rating` STRING COMMENT 'Qualitative inherent risk classification derived from the inherent risk score. Used for risk prioritization and resource allocation. Critical risks require immediate executive attention and Board notification.. Valid values are `Low|Medium|High|Critical`',
    `inherent_risk_score` STRING COMMENT 'Quantitative inherent risk rating calculated as likelihood multiplied by impact, using a numerical scale (e.g., 1-25 where Very Low=1, Low=2, Medium=3, High=4, Very High=5). Represents risk exposure before controls.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance risk register record was most recently updated. Used for audit trail, change tracking, and data lineage.',
    `last_review_date` DATE COMMENT 'Date of the most recent formal review and reassessment of this compliance risk. Used to track review compliance and identify overdue reviews.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal review and reassessment of this compliance risk, calculated based on review frequency and last review date.',
    `regulatory_framework` STRING COMMENT 'Specific regulation, standard, or guidance document that defines the compliance obligation associated with this risk (e.g., 21 CFR Part 11, EU Annex 11, ICH Q10, GDPR Article 32).',
    `residual_impact` STRING COMMENT 'Severity or magnitude of consequences if the compliance risk materializes, after considering the effectiveness of existing controls. Rated on a five-point scale from Very Low to Very High.. Valid values are `Very Low|Low|Medium|High|Very High`',
    `residual_likelihood` STRING COMMENT 'Probability or frequency of the compliance risk occurring after considering the effectiveness of existing controls. Rated on a five-point scale from Very Low to Very High.. Valid values are `Very Low|Low|Medium|High|Very High`',
    `residual_risk_rating` STRING COMMENT 'Qualitative residual risk classification derived from the residual risk score. Used for risk appetite alignment and treatment decision-making.. Valid values are `Low|Medium|High|Critical`',
    `residual_risk_score` STRING COMMENT 'Quantitative residual risk rating calculated as residual likelihood multiplied by residual impact. Represents risk exposure after considering existing controls. Used for risk acceptance decisions and treatment prioritization.',
    `review_frequency` STRING COMMENT 'Cadence at which this compliance risk is formally reviewed and reassessed. High and Critical risks typically require more frequent review (monthly or quarterly); Low and Medium risks may be reviewed semi-annually or annually.. Valid values are `Monthly|Quarterly|Semi-Annually|Annually|Ad-Hoc`',
    `risk_appetite_alignment` STRING COMMENT 'Indicates whether the residual risk rating is aligned with the organizations risk appetite threshold. Exceeds Appetite triggers mandatory risk treatment; Within Appetite indicates acceptable risk level; Below Appetite may indicate over-control.. Valid values are `Within Appetite|Exceeds Appetite|Below Appetite`',
    `risk_appetite_threshold` STRING COMMENT 'Maximum level of residual risk that the organization is willing to accept for this compliance domain, as defined by the Board and executive leadership. Used to determine if additional risk treatment is required.. Valid values are `Low|Medium|High|Critical`',
    `risk_category` STRING COMMENT 'Primary regulatory domain or compliance framework to which this risk belongs. Categories include Good Practice (GxP), Sarbanes-Oxley (SOX), General Data Protection Regulation (GDPR), Anti-Bribery and Anti-Corruption (ABAC), Physician Payments Sunshine Act, Data Integrity (ALCOA+), Computer System Validation (CSV), and Health Insurance Portability and Accountability Act (HIPAA). [ENUM-REF-CANDIDATE: GxP|SOX|GDPR|ABAC|Sunshine Act|Data Integrity|CSV|HIPAA — 8 candidates stripped; promote to reference product]',
    `risk_code` STRING COMMENT 'Business identifier for the compliance risk, formatted as RISK-{DOMAIN}-{SEQUENCE} (e.g., RISK-GXP-000123). Used for external reporting and cross-referencing.. Valid values are `^RISK-[A-Z]{3}-[0-9]{6}$`',
    `risk_description` STRING COMMENT 'Detailed description of the compliance risk, including the nature of the risk, potential triggers, and business context. Provides comprehensive understanding for risk assessment and treatment planning.',
    `risk_owner_function` STRING COMMENT 'Business function or department of the risk owner (e.g., Quality Assurance, Regulatory Affairs, Manufacturing, Clinical Operations, IT, Finance).',
    `risk_status` STRING COMMENT 'Current lifecycle status of the compliance risk. Open indicates newly identified; Under Assessment indicates risk analysis in progress; Treatment in Progress indicates mitigation actions underway; Monitoring indicates residual risk being tracked; Closed indicates risk retired or no longer applicable; Escalated indicates risk elevated to executive or Board level.. Valid values are `Open|Under Assessment|Treatment in Progress|Monitoring|Closed|Escalated`',
    `risk_subcategory` STRING COMMENT 'Secondary classification providing granular categorization within the primary risk category (e.g., within GxP: GMP, GLP, GCP, GDP; within Data Integrity: ALCOA+, audit trail, electronic signature).',
    `risk_title` STRING COMMENT 'Concise title or name of the identified compliance risk. Used for executive dashboards and Board Audit Committee reporting.',
    `risk_treatment_decision` STRING COMMENT 'Strategic decision on how to address the compliance risk. Accept means no further action, risk is within appetite; Mitigate means implement additional controls to reduce risk; Transfer means shift risk to third party (e.g., insurance, outsourcing); Avoid means eliminate the activity that creates the risk.. Valid values are `Accept|Mitigate|Transfer|Avoid`',
    `treatment_completion_date` DATE COMMENT 'Actual date when the risk treatment plan was fully implemented and verified. Null if treatment is not yet complete or if risk treatment decision is Accept.',
    `treatment_due_date` DATE COMMENT 'Target completion date for implementing the risk treatment plan. Used for tracking and escalation. Null if risk treatment decision is Accept.',
    `treatment_plan_description` STRING COMMENT 'Detailed description of planned actions to mitigate, transfer, or avoid the compliance risk. Includes specific control enhancements, process changes, technology implementations, or organizational changes. Null if risk treatment decision is Accept.',
    `treatment_status` STRING COMMENT 'Current status of risk treatment plan execution. Not Started indicates plan approved but not yet initiated; In Progress indicates actions underway; Completed indicates all treatment actions implemented and verified; Overdue indicates treatment past due date; Cancelled indicates treatment plan abandoned. Null if risk treatment decision is Accept.. Valid values are `Not Started|In Progress|Completed|Overdue|Cancelled`',
    CONSTRAINT pk_risk_register PRIMARY KEY(`risk_register_id`)
) COMMENT 'Master record for the enterprise compliance risk register tracking identified compliance risks across all regulatory domains (GxP, SOX, GDPR, ABAC, Sunshine Act). Captures risk description, risk category, risk owner, inherent risk rating (likelihood × impact), existing controls, residual risk rating, risk appetite alignment, risk treatment decision (accept, mitigate, transfer, avoid), and risk review cadence. Serves as the authoritative compliance risk inventory for the Chief Compliance Officer and Board Audit Committee reporting.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` (
    `policy_document_id` BIGINT COMMENT 'Unique identifier for the compliance policy document record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who provided final approval for the current version of the document. Typically a senior compliance officer, quality head, or executive.',
    `owner_employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `policy_employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `primary_policy_employee_id` BIGINT COMMENT 'Identifier of the employee who is the designated owner and accountable party for this policy document. Typically a compliance officer, quality manager, or functional leader.',
    `superseded_policy_document_id` BIGINT COMMENT 'Self-referencing FK on policy_document (superseded_policy_document_id)',
    `applicable_functions` STRING COMMENT 'Comma-separated list of business functions or departments to which this policy applies (e.g., Manufacturing, Quality, R&D, Clinical Operations, Commercial). Null if enterprise-wide.',
    `applicable_regulation` STRING COMMENT 'Primary regulatory citation or framework that this document addresses (e.g., 21 CFR Part 11, EU Annex 11, GDPR Article 32, SOX Section 404, ICH Q10). Multiple regulations may be listed as comma-separated values.',
    `applicable_sites` STRING COMMENT 'Comma-separated list of site codes or names where this policy document is applicable. Null if enterprise-wide.',
    `approval_status` STRING COMMENT 'Current approval state of the document within the approval workflow. Pending = awaiting approval; Approved = all required approvals obtained; Rejected = approval denied; Conditional = approved with conditions or caveats.. Valid values are `pending|approved|rejected|conditional`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the document received final approval and was authorized for release.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this policy document record was first created in the system.',
    `data_integrity_requirement_flag` BOOLEAN COMMENT 'Indicates whether this policy document addresses ALCOA+ (Attributable, Legible, Contemporaneous, Original, Accurate, Complete, Consistent, Enduring, Available) data integrity principles. True = data integrity requirements included; False = not applicable.',
    `distribution_scope` STRING COMMENT 'Defines the organizational scope to which this policy document applies. Enterprise Wide = all employees and sites; Site Specific = applies to designated sites only; Department Specific = applies to specific functional areas; Role Specific = applies to specific job roles; Restricted = limited distribution to authorized personnel only.. Valid values are `enterprise_wide|site_specific|department_specific|role_specific|restricted`',
    `document_category` STRING COMMENT 'Primary compliance domain category that this document governs. GxP = Good Practice regulations (GMP, GLP, GCP); SOX = Sarbanes-Oxley financial controls; GDPR = General Data Protection Regulation; ABAC = Anti-Bribery and Anti-Corruption; Data Integrity = ALCOA+ principles; CSV = Computer System Validation. [ENUM-REF-CANDIDATE: gxp|sox|gdpr|abac|data_integrity|csv|other — 7 candidates stripped; promote to reference product]',
    `document_description` STRING COMMENT 'Detailed narrative description of the policy document purpose, scope, and key requirements. Provides context and summary of the document content.',
    `document_number` STRING COMMENT 'Externally-known unique identifier for the policy document following enterprise document numbering convention (e.g., COMP-POL-0001, COMP-SOP-0234).. Valid values are `^[A-Z]{2,4}-[A-Z]{3}-d{4}$`',
    `document_status` STRING COMMENT 'Current lifecycle status of the policy document. Draft = under development; In Review = submitted for approval; Approved = approved but not yet effective; Effective = currently in force; Superseded = replaced by newer version; Retired = no longer applicable; Obsolete = archived. [ENUM-REF-CANDIDATE: draft|in_review|approved|effective|superseded|retired|obsolete — 7 candidates stripped; promote to reference product]',
    `document_storage_location` STRING COMMENT 'File path, URL, or repository location where the official controlled copy of this policy document is stored (e.g., Veeva Vault document ID, SharePoint URL, document management system path).',
    `document_title` STRING COMMENT 'Full title of the compliance policy or procedure document as it appears on the official document.',
    `document_type` STRING COMMENT 'Classification of the document type within the compliance document hierarchy. Policy = high-level governance statement; SOP (Standard Operating Procedure) = detailed operational procedure; Guideline = recommended practice; Work Instruction = step-by-step task instruction; Procedure = process description; Standard = technical specification.. Valid values are `policy|sop|guideline|work_instruction|procedure|standard`',
    `effective_date` DATE COMMENT 'Date on which this version of the policy document becomes officially effective and enforceable across the organization.',
    `electronic_records_requirement_flag` BOOLEAN COMMENT 'Indicates whether this policy addresses electronic records and electronic signatures requirements per 21 CFR Part 11 or EU Annex 11. True = electronic records requirements included; False = not applicable.',
    `expiration_date` DATE COMMENT 'Date on which this policy document is scheduled to expire or be superseded. Null if the policy has no defined expiration.',
    `gdpr_applicability_flag` BOOLEAN COMMENT 'Indicates whether this policy addresses General Data Protection Regulation requirements for personal data protection and privacy. True = GDPR-related policy; False = not GDPR-related.',
    `governance_committee` STRING COMMENT 'Name of the governance committee or oversight body responsible for reviewing and approving this policy (e.g., Compliance Steering Committee, Quality Council, Data Governance Board).',
    `hipaa_applicability_flag` BOOLEAN COMMENT 'Indicates whether this policy addresses Health Insurance Portability and Accountability Act requirements for protected health information. True = HIPAA-related policy; False = not HIPAA-related.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this policy document record was last updated or modified.',
    `last_review_date` DATE COMMENT 'Date of the most recent periodic review of this policy document, regardless of whether changes were made.',
    `next_review_due_date` DATE COMMENT 'Scheduled date by which the next periodic review of this policy document must be completed.',
    `regulatory_authority` STRING COMMENT 'Governing body or regulatory agency whose requirements this document addresses (e.g., FDA, EMA, MHRA, PMDA, SEC, ICO). Multiple authorities may be listed as comma-separated values.',
    `related_policy_references` STRING COMMENT 'Comma-separated list of related policy document numbers that are cross-referenced or complementary to this document.',
    `review_cycle_months` STRING COMMENT 'Frequency in months at which this policy document must be reviewed for continued relevance and accuracy (e.g., 12 for annual review, 24 for biennial review).',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this policy document supports Sarbanes-Oxley Act compliance and internal financial controls. True = SOX-related policy; False = not SOX-related.',
    `superseded_document_number` STRING COMMENT 'Document number of the previous version that this current version supersedes or replaces. Null if this is the first version.',
    `training_frequency_months` STRING COMMENT 'Frequency in months at which refresher training on this policy must be completed by applicable personnel. Null if one-time training or training not required.',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether formal training on this policy document is mandatory for applicable personnel. True = training required; False = training not required.',
    `version_number` STRING COMMENT 'Current version number of the document following semantic versioning (major.minor format, e.g., 1.0, 2.3). Incremented with each approved revision.. Valid values are `^d+.d+$`',
    CONSTRAINT pk_policy_document PRIMARY KEY(`policy_document_id`)
) COMMENT 'Master record for the enterprise compliance policy and procedure document library including SOPs, policies, guidelines, and work instructions governing GxP, SOX, GDPR, ABAC, and other compliance obligations. Captures document title, document type (policy, SOP, guideline, work instruction), document owner, applicable regulation, version number, effective date, review cycle, approval status, and distribution scope. Distinct from quality SOPs managed in the QMS — this covers compliance-function-owned policies governing enterprise-wide compliance behavior.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` (
    `disclosure_id` BIGINT COMMENT 'Unique identifier for the compliance disclosure record. Primary key for the compliance_disclosure product.',
    `employee_id` BIGINT COMMENT 'Identifier of the senior employee or executive who provided final approval for the compliance disclosure submission, typically a Chief Compliance Officer or General Counsel.',
    `conflict_of_interest_id` BIGINT COMMENT 'Foreign key linking to compliance.conflict_of_interest. Business justification: Regulatory disclosures (e.g., Sunshine Act, transparency reporting) are often triggered by conflict of interest declarations. This FK links a disclosure to the underlying COI declaration that necessit',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Sunshine Act and transparency disclosures are country-specific. Reporting thresholds and formats vary by jurisdiction. Essential for disclosure preparation, submission tracking, publication monitoring',
    `disclosure_preparer_employee_id` BIGINT COMMENT 'Identifier of the employee who prepared or compiled the compliance disclosure filing.',
    `legal_entity_id` BIGINT COMMENT 'Identifier of the legal entity or organizational unit responsible for submitting this compliance disclosure, typically a subsidiary, affiliate, or business unit.',
    `original_disclosure_id` BIGINT COMMENT 'Reference to the original compliance disclosure record that this filing amends or replaces, establishing the amendment chain for audit purposes.',
    `program_id` BIGINT COMMENT 'Identifier of the enterprise compliance program under which this disclosure is managed, linking the disclosure to the broader compliance governance framework.',
    `reviewer_employee_id` BIGINT COMMENT 'Identifier of the employee who reviewed and approved the compliance disclosure prior to submission, typically a compliance officer or legal counsel.',
    `amended_disclosure_id` BIGINT COMMENT 'Self-referencing FK on disclosure (amended_disclosure_id)',
    `acknowledgment_date` DATE COMMENT 'Date on which the regulatory authority acknowledged receipt and acceptance of the compliance disclosure.',
    `acknowledgment_receipt_number` STRING COMMENT 'Confirmation or receipt number issued by the regulatory authority upon successful submission and acceptance of the compliance disclosure.',
    `amendment_reason` STRING COMMENT 'Business justification or explanation for amending a previously submitted compliance disclosure, documenting what was corrected or updated.',
    `amount` DECIMAL(18,2) COMMENT 'Total aggregate monetary value disclosed in this filing, representing the sum of all transfers of value, payments, or financial transactions covered by the disclosure for the reporting period. Null for non-monetary disclosures such as conflict of interest declarations.',
    `approval_date` DATE COMMENT 'Date on which the compliance disclosure received final internal approval for submission to the regulatory authority.',
    `content` STRING COMMENT 'Textual content or narrative description of the disclosure, used for non-monetary disclosures such as conflict of interest statements, anti-bribery declarations, or beneficial ownership details. May contain structured or unstructured text depending on disclosure type.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance disclosure record was first created in the system, capturing the initial data entry event.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the disclosure amount (e.g., USD, EUR, GBP). Null for non-monetary disclosures.. Valid values are `^[A-Z]{3}$`',
    `data_source_system` STRING COMMENT 'Name of the operational system or application from which the underlying transaction data for this compliance disclosure was extracted (e.g., Veeva CRM, SAP, Argus Safety).',
    `disclosure_number` STRING COMMENT 'Externally-known unique business identifier for the compliance disclosure filing, typically formatted as DISC-YYYY-NNNNNN.. Valid values are `^DISC-[0-9]{4}-[0-9]{6}$`',
    `disclosure_status` STRING COMMENT 'Current lifecycle status of the compliance disclosure: draft (in preparation), pending_review (awaiting internal approval), submitted (filed with regulatory body), acknowledged (receipt confirmed by authority), rejected (returned for correction), amended (resubmitted after correction), or withdrawn (cancelled). [ENUM-REF-CANDIDATE: draft|pending_review|submitted|acknowledged|rejected|amended|withdrawn — 7 candidates stripped; promote to reference product]',
    `disclosure_type` STRING COMMENT 'Category of compliance disclosure: Sunshine Act / Open Payments aggregate disclosure, EFPIA Disclosure Code submission, anti-bribery declaration, conflict of interest disclosure, beneficial ownership filing, or other regulatory filing type.. Valid values are `sunshine_act|efpia_disclosure|anti_bribery|conflict_of_interest|beneficial_ownership|other`',
    `due_date` DATE COMMENT 'Regulatory deadline by which the compliance disclosure must be submitted to remain in compliance with applicable laws and regulations.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which this compliance disclosure applies, used for financial reporting alignment and multi-year trend analysis.',
    `last_modified_by` STRING COMMENT 'User identifier or name of the person who last modified this compliance disclosure record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this compliance disclosure record, supporting change tracking and audit trail requirements.',
    `notes` STRING COMMENT 'Free-text field for additional comments, clarifications, or internal notes related to the compliance disclosure preparation, submission, or follow-up actions.',
    `publication_date` DATE COMMENT 'Date on which the compliance disclosure was made publicly available, if public disclosure is required by the applicable regulation.',
    `publication_url` STRING COMMENT 'Web address where the compliance disclosure has been publicly published, if applicable (e.g., EFPIA disclosures are typically published on company websites or central platforms).',
    `recipient_count` STRING COMMENT 'Total number of individual recipients (Healthcare Professionals, Healthcare Organizations, or other parties) included in this aggregate compliance disclosure. Applicable primarily to Sunshine Act and EFPIA disclosures.',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory body or government agency to which the compliance disclosure is submitted (e.g., CMS for Sunshine Act, national competent authority for EFPIA, SEC for beneficial ownership).',
    `rejection_reason` STRING COMMENT 'Explanation provided by the regulatory authority for rejecting the compliance disclosure, including specific deficiencies or errors that must be corrected before resubmission.',
    `reporting_period_end_date` DATE COMMENT 'End date of the reporting period covered by this compliance disclosure, typically the end of the calendar or fiscal year for annual aggregate disclosures.',
    `reporting_period_start_date` DATE COMMENT 'Start date of the reporting period covered by this compliance disclosure, typically the beginning of the calendar or fiscal year for annual aggregate disclosures.',
    `submission_date` DATE COMMENT 'Date on which the compliance disclosure was submitted to the regulatory authority or published per disclosure requirements.',
    `submission_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the compliance disclosure was electronically submitted or filed, capturing the exact moment of regulatory submission.',
    `submitting_entity_name` STRING COMMENT 'Legal name of the entity submitting the compliance disclosure, as registered with regulatory authorities.',
    `supporting_document_location` STRING COMMENT 'File path, document management system reference, or storage location for supporting documentation, evidence, and source data used to prepare the compliance disclosure.',
    `transaction_count` STRING COMMENT 'Total number of individual transfer of value transactions aggregated and reported in this compliance disclosure filing.',
    `created_by` STRING COMMENT 'User identifier or name of the person who created this compliance disclosure record in the system.',
    CONSTRAINT pk_disclosure PRIMARY KEY(`disclosure_id`)
) COMMENT 'Transactional record for mandatory compliance disclosures and regulatory filings managed by the compliance function, including Sunshine Act / Open Payments annual aggregate disclosures, EFPIA Disclosure Code submissions, anti-bribery declarations, conflict of interest disclosures, and beneficial ownership filings. Captures disclosure type, reporting period, submitting entity, regulatory body, submission date, disclosure amount or content, submission status, and acknowledgment receipt. Distinct from commercial.sunshine_disclosure (which is the commercial HCP-level transfer of value record) — this is the aggregate regulatory filing record.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` (
    `conflict_of_interest_id` BIGINT COMMENT 'Unique identifier for the conflict of interest declaration record.',
    `trial_id` BIGINT COMMENT 'Identifier of the clinical trial to which this COI declaration applies, if relevant. Null for non-trial-related declarations.',
    `master_id` BIGINT COMMENT 'Healthcare professional identifier if the declarant is an external HCP, investigator, or advisory board member. Null for internal employees.',
    `medicinal_product_id` BIGINT COMMENT 'Identifier of the drug product or investigational product to which this COI declaration applies, if relevant. Null for non-product-specific declarations.',
    `employee_id` BIGINT COMMENT 'Employee identifier if the declarant is an internal employee. Null for external declarants.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: COI declarations are managed under specific compliance programs (clinical trial integrity, commercial compliance, transparency). This FK links each declaration to its governing program, enabling progr',
    `reviewer_employee_id` BIGINT COMMENT 'Employee identifier of the compliance officer or manager who reviewed the COI declaration.',
    `prior_conflict_of_interest_id` BIGINT COMMENT 'Self-referencing FK on conflict_of_interest (prior_conflict_of_interest_id)',
    `attestation_statement` STRING COMMENT 'Text of the attestation or certification statement signed by the declarant affirming the accuracy and completeness of the declaration.',
    `attestation_timestamp` TIMESTAMP COMMENT 'Date and time when the declarant electronically signed or attested to the COI declaration.',
    `counterparty_name` STRING COMMENT 'Name of the organization, institution, or individual with whom the declarant has a conflicting relationship.',
    `counterparty_type` STRING COMMENT 'Category of the counterparty entity: pharmaceutical company, biotech company, Contract Research Organization (CRO), medical device company, academic institution, healthcare provider, government agency, or individual. [ENUM-REF-CANDIDATE: pharmaceutical_company|biotech_company|cro|medical_device_company|academic_institution|healthcare_provider|government_agency|individual — 8 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the COI declaration record was first created in the system.',
    `declarant_email` STRING COMMENT 'Primary email address of the declarant for correspondence regarding the COI declaration.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `declarant_name` STRING COMMENT 'Full legal name of the individual making the conflict of interest declaration.',
    `declarant_type` STRING COMMENT 'Category of individual making the declaration: employee, principal investigator, advisory board member, healthcare professional, consultant, or vendor representative.. Valid values are `employee|investigator|advisory_board_member|hcp|consultant|vendor`',
    `declaration_date` DATE COMMENT 'Date on which the conflict of interest declaration was submitted by the declarant.',
    `declaration_number` STRING COMMENT 'Business identifier for the COI declaration, formatted as COI-YYYYNNNN where YYYY is year and NNNN is sequence.. Valid values are `^COI-[0-9]{8}$`',
    `declaration_status` STRING COMMENT 'Current lifecycle status of the COI declaration: draft, submitted, under review, approved, rejected, or withdrawn.. Valid values are `draft|submitted|under_review|approved|rejected|withdrawn`',
    `declaration_type` STRING COMMENT 'Type of COI declaration: initial submission, annual recertification, ad-hoc update, triggered by event, or amendment to prior declaration.. Valid values are `initial|annual_recertification|ad_hoc|triggered|amendment`',
    `declared_value_amount` DECIMAL(18,2) COMMENT 'Monetary value of the financial interest or relationship, if quantifiable. Null for non-financial relationships.',
    `declared_value_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the declared value amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `disclosure_date` DATE COMMENT 'Date on which the conflict of interest was disclosed to the relevant regulatory authority, IRB, or other external body.',
    `disclosure_required_flag` BOOLEAN COMMENT 'Indicates whether this COI must be disclosed to regulatory authorities, institutional review boards (IRBs), or in publications (True) or not (False).',
    `effective_end_date` DATE COMMENT 'Date on which the conflict of interest or relationship ended or is expected to end. Null for ongoing relationships.',
    `effective_start_date` DATE COMMENT 'Date from which the conflict of interest or relationship became effective or began.',
    `interest_description` STRING COMMENT 'Detailed narrative description of the nature, scope, and context of the conflict of interest or relationship.',
    `last_modified_by` STRING COMMENT 'User ID or name of the individual who last modified the COI declaration record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the COI declaration record was last updated or modified.',
    `management_plan` STRING COMMENT 'Documented plan for managing or mitigating the identified conflict of interest, including specific controls, restrictions, or oversight measures.',
    `mitigation_required_flag` BOOLEAN COMMENT 'Indicates whether mitigation actions are required to manage the conflict of interest (True) or not (False).',
    `mitigation_status` STRING COMMENT 'Current status of mitigation actions: not required, planned, in progress, completed, or verified by compliance.. Valid values are `not_required|planned|in_progress|completed|verified`',
    `recertification_due_date` DATE COMMENT 'Date by which the declarant must submit an annual recertification or update of the COI declaration.',
    `recertification_status` STRING COMMENT 'Status of annual recertification requirement: current (up to date), overdue, not applicable, or pending submission.. Valid values are `current|overdue|not_applicable|pending`',
    `regulatory_authority` STRING COMMENT 'Regulatory body or institutional review board to which the COI was disclosed: FDA, EMA, MHRA, PMDA, NMPA, IRB, or other. [ENUM-REF-CANDIDATE: FDA|EMA|MHRA|PMDA|NMPA|IRB|other — 7 candidates stripped; promote to reference product]',
    `relationship_type` STRING COMMENT 'Nature of the conflict of interest: financial interest, employment, consulting arrangement, equity ownership, family relationship, personal relationship, board membership, or intellectual property rights. [ENUM-REF-CANDIDATE: financial_interest|employment|consulting|equity_ownership|family_relationship|personal_relationship|board_membership|intellectual_property — 8 candidates stripped; promote to reference product]',
    `review_date` DATE COMMENT 'Date on which the COI declaration was reviewed and a determination was made.',
    `review_notes` STRING COMMENT 'Internal notes and rationale documented by the reviewer regarding the COI assessment and determination.',
    `review_outcome` STRING COMMENT 'Result of the COI review: no conflict identified, managed conflict (acceptable with controls), prohibited conflict (unacceptable), requires mitigation, or pending review.. Valid values are `no_conflict|managed_conflict|prohibited_conflict|requires_mitigation|pending_review`',
    `supporting_document_location` STRING COMMENT 'File path or document management system reference to supporting documentation for the COI declaration (e.g., contracts, financial statements).',
    CONSTRAINT pk_conflict_of_interest PRIMARY KEY(`conflict_of_interest_id`)
) COMMENT 'Master and transactional record for conflict of interest (COI) declarations submitted by employees, investigators, advisory board members, and HCPs engaged by the company. Captures declarant identity, declaration date, relationship type (financial interest, employment, family relationship, personal relationship), counterparty, declared value or nature of interest, review outcome (no conflict, managed conflict, prohibited conflict), management plan, and annual recertification status. Supports ABAC compliance, clinical trial integrity, and HCP engagement governance.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` (
    `third_party_due_diligence_id` BIGINT COMMENT 'Unique identifier for the third party due diligence assessment record.',
    `business_partner_id` BIGINT COMMENT 'Foreign key linking to masterdata.business_partner. Business justification: Third-party due diligence assesses vendors, CROs, and distributors. Sanctions screening and GxP qualification are partner-specific. Essential for vendor qualification, risk management, audit planning.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who last modified the due diligence assessment record.',
    `primary_third_assessor_employee_id` BIGINT COMMENT 'Identifier of the employee responsible for conducting the due diligence assessment.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Third-party due diligence assessments are conducted as part of compliance programs (anti-bribery, vendor management, data privacy). This FK links each assessment to the program under which it was cond',
    `reviewer_employee_id` BIGINT COMMENT 'Identifier of the employee responsible for reviewing and approving the due diligence assessment.',
    `third_party_business_partner_id` BIGINT COMMENT 'Identifier of the third party entity being assessed (HCP, CRO, CMO, distributor, agent, consultant, vendor).',
    `prior_third_party_due_diligence_id` BIGINT COMMENT 'Self-referencing FK on third_party_due_diligence (prior_third_party_due_diligence_id)',
    `abac_screening_date` DATE COMMENT 'Date when anti-bribery and corruption screening was performed.',
    `abac_screening_status` STRING COMMENT 'Status of anti-bribery and corruption due diligence screening to assess corruption risk and compliance with FCPA (Foreign Corrupt Practices Act) and UK Bribery Act.. Valid values are `not_started|in_progress|clear|concerns_identified|under_review`',
    `approval_conditions` STRING COMMENT 'Specific conditions or restrictions attached to the approval decision, if applicable.',
    `approval_date` DATE COMMENT 'Date when the approval decision was made.',
    `approval_decision` STRING COMMENT 'Final decision on whether the third party is approved for engagement based on due diligence results.. Valid values are `approved|approved_with_conditions|rejected|pending`',
    `assessment_completed_date` DATE COMMENT 'Date when the due diligence assessment was completed and finalized.',
    `assessment_initiated_date` DATE COMMENT 'Date when the due diligence assessment was formally initiated.',
    `assessment_notes` STRING COMMENT 'Additional notes, observations, or comments captured during the due diligence assessment process.',
    `assessment_number` STRING COMMENT 'Business identifier for the due diligence assessment, used for tracking and reference purposes.',
    `assessment_status` STRING COMMENT 'Current lifecycle status of the due diligence assessment process. [ENUM-REF-CANDIDATE: initiated|in_progress|screening_complete|review|approved|rejected|on_hold — 7 candidates stripped; promote to reference product]',
    `country_of_operation` STRING COMMENT 'Primary country where the third party operates or is registered, using ISO 3166-1 alpha-3 country codes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the due diligence assessment record was first created in the system.',
    `data_integrity_verified_flag` BOOLEAN COMMENT 'Indicates whether data integrity controls and ALCOA+ (Attributable, Legible, Contemporaneous, Original, Accurate, Complete, Consistent, Enduring, Available) compliance were verified during due diligence.',
    `debarment_match_found_flag` BOOLEAN COMMENT 'Indicates whether a match was found on any debarment or exclusion list during screening.',
    `debarment_screening_date` DATE COMMENT 'Date when debarment screening was performed.',
    `debarment_screening_status` STRING COMMENT 'Status of screening against FDA debarment list, OIG (Office of Inspector General) exclusion list, and other regulatory debarment databases.. Valid values are `not_started|in_progress|clear|match_found|under_review`',
    `due_diligence_tier` STRING COMMENT 'Level of due diligence rigor applied based on risk assessment. Simplified for low-risk, standard for medium-risk, enhanced for high-risk third parties.. Valid values are `simplified|standard|enhanced`',
    `engagement_type` STRING COMMENT 'Type of business engagement or relationship with the third party. [ENUM-REF-CANDIDATE: clinical_trial|manufacturing|distribution|consulting|advisory|speaker|research|other — 8 candidates stripped; promote to reference product]',
    `evidence_document_location` STRING COMMENT 'File path or document management system reference where supporting evidence and documentation for the due diligence assessment is stored.',
    `gxp_compliance_verified_flag` BOOLEAN COMMENT 'Indicates whether GxP (Good Practice) compliance was verified for third parties involved in GxP-regulated activities (GMP, GLP, GCP, GDP).',
    `jurisdiction` STRING COMMENT 'Legal jurisdiction applicable to the third party relationship and due diligence requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the due diligence assessment record was last modified.',
    `next_rescreening_due_date` DATE COMMENT 'Scheduled date for the next periodic rescreening of the third party.',
    `overall_risk_rating` STRING COMMENT 'Consolidated risk rating assigned to the third party based on all due diligence screening results.. Valid values are `low|medium|high|critical`',
    `rejection_reason` STRING COMMENT 'Detailed explanation for rejection decision if the third party was not approved for engagement.',
    `reputational_risk_assessment_date` DATE COMMENT 'Date when reputational risk assessment was performed.',
    `reputational_risk_assessment_status` STRING COMMENT 'Status of reputational risk assessment including adverse media screening and background checks.. Valid values are `not_started|in_progress|clear|concerns_identified|under_review`',
    `rescreening_frequency_months` STRING COMMENT 'Number of months between periodic rescreening cycles for ongoing third party relationships.',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk score calculated based on due diligence findings, typically on a scale of 0-100.',
    `sanctions_match_found_flag` BOOLEAN COMMENT 'Indicates whether a match was found on any sanctions list during screening.',
    `sanctions_screening_date` DATE COMMENT 'Date when sanctions screening was performed.',
    `sanctions_screening_status` STRING COMMENT 'Status of sanctions screening against OFAC (Office of Foreign Assets Control) and other global sanctions lists.. Valid values are `not_started|in_progress|clear|match_found|under_review`',
    `third_party_type` STRING COMMENT 'Classification of the third party entity type. HCP = Healthcare Professional, CRO = Contract Research Organization, CMO = Contract Manufacturing Organization, CDMO = Contract Development and Manufacturing Organization. [ENUM-REF-CANDIDATE: HCP|CRO|CMO|CDMO|distributor|agent|consultant|vendor|service_provider|other — 10 candidates stripped; promote to reference product]',
    CONSTRAINT pk_third_party_due_diligence PRIMARY KEY(`third_party_due_diligence_id`)
) COMMENT 'Transactional record for compliance due diligence assessments conducted on third parties (HCPs, CROs, CMOs, distributors, agents, consultants) prior to engagement and periodically thereafter. Covers anti-bribery and corruption (ABAC) due diligence, sanctions screening, debarment checks (FDA debarment list, OIG exclusion list, OFAC), and reputational risk assessment. Captures third-party identity, engagement type, due diligence tier (simplified, standard, enhanced), screening results, risk rating, approval decision, and periodic re-screening schedule.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` (
    `debarment_check_id` BIGINT COMMENT 'Unique identifier for the debarment screening check record.',
    `business_partner_id` BIGINT COMMENT 'Foreign key linking to masterdata.business_partner. Business justification: Debarment checks screen business partners against FDA, OIG, and OFAC lists. Exclusion status affects contract eligibility. Essential for vendor onboarding, contract compliance, regulatory risk mitigat',
    `employee_id` BIGINT COMMENT 'Identifier of the user who last modified this debarment check record, supporting audit trail requirements.',
    `investigational_site_id` BIGINT COMMENT 'Identifier of the investigational site being screened for debarment or exclusion status.',
    `primary_debarment_adjudicator_employee_id` BIGINT COMMENT 'Identifier of the employee who performed the adjudication review and made the final determination.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Debarment and exclusion screening is a required activity under GCP compliance programs and vendor management programs. This FK associates each screening check with the relevant compliance program for ',
    `third_party_due_diligence_id` BIGINT COMMENT 'Foreign key linking to compliance.third_party_due_diligence. Business justification: Debarment checks are performed as part of third-party due diligence assessments. This FK establishes the parent-child relationship where a due diligence assessment includes multiple screening checks (',
    `prior_debarment_check_id` BIGINT COMMENT 'Self-referencing FK on debarment_check (prior_debarment_check_id)',
    `adjudication_date` DATE COMMENT 'Date when the adjudication decision was finalized.',
    `adjudication_notes` STRING COMMENT 'Detailed notes and rationale documented by the adjudicator explaining the decision and any mitigating factors considered.',
    `adjudication_outcome` STRING COMMENT 'Final determination from the adjudication process regarding whether the subject is cleared for participation or engagement.. Valid values are `approved|rejected|requires_mitigation|disqualified`',
    `adjudication_status` STRING COMMENT 'Status of the manual review and adjudication process for potential matches requiring human evaluation.. Valid values are `pending|under_review|cleared|confirmed_exclusion|escalated`',
    `check_number` STRING COMMENT 'Business identifier for the debarment screening check, used for tracking and reference purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this debarment check record was first created in the system.',
    `eu_sanctions_checked_flag` BOOLEAN COMMENT 'Indicates whether EU sanctions lists were checked during this screening.',
    `exclusion_effective_date` DATE COMMENT 'Date when the exclusion or debarment became effective for the matched individual or entity.',
    `exclusion_expiration_date` DATE COMMENT 'Date when the exclusion or debarment expires, if applicable. Null indicates permanent exclusion.',
    `exclusion_reason` STRING COMMENT 'Reason for exclusion or debarment as documented in the regulatory list, such as fraud, patient abuse, or controlled substance violations.',
    `fda_debarment_checked_flag` BOOLEAN COMMENT 'Indicates whether the FDA Debarment List under 21 CFR Part 312.70 was checked during this screening.',
    `gcp_compliance_flag` BOOLEAN COMMENT 'Indicates whether this screening check is required for Good Clinical Practice compliance under ICH E6(R2) guidelines.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this debarment check record was last updated or modified.',
    `lists_checked` STRING COMMENT 'Comma-separated list of regulatory exclusion and sanctions lists checked during this screening, such as FDA Debarment List, OIG LEIE, GSA SAM, OFAC SDN, EU Sanctions.',
    `match_confidence_score` DECIMAL(18,2) COMMENT 'Numerical score representing the confidence level of the match, typically expressed as a percentage from 0 to 100.',
    `match_count` STRING COMMENT 'Number of potential matches identified across all checked exclusion and sanctions lists.',
    `match_details` STRING COMMENT 'Detailed information about any matches found, including list name, match score, matched fields, and exclusion reason.',
    `match_list_name` STRING COMMENT 'Name of the specific exclusion or sanctions list on which a match was identified.',
    `match_status` STRING COMMENT 'Result of the screening check indicating whether the subject was found on any exclusion or sanctions list.. Valid values are `no_match|potential_match|confirmed_match|false_positive`',
    `next_screening_due_date` DATE COMMENT 'Date when the next periodic re-screening check is due for this subject.',
    `ofac_sdn_checked_flag` BOOLEAN COMMENT 'Indicates whether the OFAC Specially Designated Nationals and Blocked Persons list was checked during this screening.',
    `oig_leie_checked_flag` BOOLEAN COMMENT 'Indicates whether the OIG List of Excluded Individuals and Entities was checked during this screening.',
    `rescreening_trigger` STRING COMMENT 'Business event or condition that triggered this screening check, such as new hire, contract renewal, periodic review, or regulatory inspection preparation.',
    `risk_level` STRING COMMENT 'Risk classification assigned to this screening check based on the subjects role, access level, and potential impact to clinical trials or federal healthcare programs.. Valid values are `low|medium|high|critical`',
    `sam_exclusion_checked_flag` BOOLEAN COMMENT 'Indicates whether the GSA System for Award Management exclusions database was checked during this screening.',
    `screening_date` DATE COMMENT 'Date when the debarment screening check was performed.',
    `screening_frequency` STRING COMMENT 'Required frequency for re-screening this subject based on risk assessment and regulatory requirements.. Valid values are `one_time|monthly|quarterly|annual|continuous`',
    `screening_method` STRING COMMENT 'Method used to perform the debarment screening check, indicating level of automation versus manual review.. Valid values are `automated|manual|hybrid`',
    `screening_status` STRING COMMENT 'Current status of the debarment screening check in its lifecycle.. Valid values are `pending|in_progress|completed|failed|cancelled`',
    `screening_system` STRING COMMENT 'Name of the software system or service used to perform the debarment screening check.',
    `screening_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the debarment screening check was executed, including time zone information.',
    `screening_type` STRING COMMENT 'Type of subject being screened for debarment or exclusion status. [ENUM-REF-CANDIDATE: individual|entity|site|investigator|vendor|employee|contractor — 7 candidates stripped; promote to reference product]',
    `subject_address` STRING COMMENT 'Physical address of the individual or entity being screened, used for enhanced matching against exclusion lists.',
    `subject_country_code` STRING COMMENT 'Three-letter ISO country code representing the country of residence or registration of the subject being screened.. Valid values are `^[A-Z]{3}$`',
    `subject_date_of_birth` DATE COMMENT 'Date of birth of the individual being screened, used to improve matching accuracy and reduce false positives.',
    `subject_first_name` STRING COMMENT 'First name of the individual being screened, used for more precise matching against exclusion lists.',
    `subject_identifier` STRING COMMENT 'Unique identifier for the subject being screened, such as employee ID, vendor ID, investigator ID, or national identification number.',
    `subject_last_name` STRING COMMENT 'Last name of the individual being screened, used for more precise matching against exclusion lists.',
    `subject_type` STRING COMMENT 'Classification of the entity being screened (individual person or organizational entity).. Valid values are `person|organization|site|vendor`',
    CONSTRAINT pk_debarment_check PRIMARY KEY(`debarment_check_id`)
) COMMENT 'Transactional record for individual debarment, exclusion, and sanctions screening checks performed against regulatory exclusion lists including FDA Debarment List (21 CFR Part 312), OIG List of Excluded Individuals and Entities (LEIE), GSA System for Award Management (SAM) exclusions, OFAC Specially Designated Nationals (SDN) list, and EU sanctions lists. Captures individual or entity screened, screening date, lists checked, match status, match details, adjudication outcome, and re-screening trigger. Required for GCP compliance and federal healthcare program participation.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` (
    `attestation_id` BIGINT COMMENT 'Unique identifier for the compliance attestation record. Primary key for the compliance attestation entity.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee submitting the attestation. Links to the employee master data record.',
    `attestation_employee_id` BIGINT COMMENT 'Identifier of the user who last modified this attestation record. Provides audit trail for record changes.',
    `site_id` BIGINT COMMENT 'Identifier of the physical site or location where the attestor is based. Critical for GxP and site-specific compliance tracking.',
    `policy_document_id` BIGINT COMMENT 'Identifier of the policy or compliance document being attested to. Links to the document management system for full policy text and version history.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Attestations are submitted as part of specific compliance programs (SOX, GxP, privacy). Currently has regulatory_framework and jurisdiction attributes but no link to the master program record. This FK',
    `quality_capa_id` BIGINT COMMENT 'Identifier of the CAPA record initiated as a result of exceptions or non-compliance disclosed in this attestation. Null if no CAPA was required.',
    `reviewer_employee_id` BIGINT COMMENT 'Identifier of the compliance officer or manager who reviewed and approved this attestation. Null if attestation is pending review.',
    `prior_attestation_id` BIGINT COMMENT 'Self-referencing FK on attestation (prior_attestation_id)',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the attestation was formally approved. Represents the official acceptance of the attestation for compliance purposes.',
    `attestation_number` STRING COMMENT 'Business-facing unique identifier for the attestation, formatted as ATT-YYYYNNNN for external reference and audit trail purposes.. Valid values are `^ATT-[0-9]{8}$`',
    `attestation_status` STRING COMMENT 'Current lifecycle status of the attestation record. Tracks progression from submission through approval or rejection. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|rejected|expired|withdrawn — 7 candidates stripped; promote to reference product]',
    `attestation_type` STRING COMMENT 'Category of compliance attestation being submitted. Defines the regulatory or policy framework under which the attestation is made.. Valid values are `code_of_conduct|sox_certification|gxp_declaration|gdpr_data_handling|conflict_of_interest|training_completion`',
    `attestor_department` STRING COMMENT 'Organizational department or business unit of the attestor. Used for compliance reporting and analytics by organizational segment.',
    `attestor_email` STRING COMMENT 'Corporate email address of the attestor at the time of submission. Used for confirmation and audit trail.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `attestor_job_title` STRING COMMENT 'Job title or role of the attestor at the time of attestation submission. Provides context for attestation authority and scope.',
    `attestor_name` STRING COMMENT 'Full legal name of the individual submitting the attestation. Captured at time of submission for audit trail purposes.',
    `content` STRING COMMENT 'Full text of the attestation statement that the attestor is certifying. Captures the exact language of the commitment or declaration made.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this attestation record was first created in the system. Represents the initial capture of the attestation data.',
    `electronic_signature` STRING COMMENT 'Electronic signature or digital signature hash applied by the attestor to certify the attestation. Meets 21 CFR Part 11 requirements for electronic records.',
    `exception_description` STRING COMMENT 'Detailed description of any exceptions, qualifications, or instances of non-compliance disclosed by the attestor. Null if no exceptions were disclosed.',
    `exceptions_disclosed_flag` BOOLEAN COMMENT 'Indicates whether the attestor disclosed any exceptions, qualifications, or non-compliance instances as part of this attestation. True if exceptions were disclosed, false otherwise.',
    `expiration_date` DATE COMMENT 'Date when this attestation expires and requires renewal. Used for annual code of conduct certifications and periodic compliance declarations.',
    `fiscal_quarter` STRING COMMENT 'Fiscal quarter to which this attestation applies, if applicable. Used for quarterly SOX sub-certifications.. Valid values are `Q1|Q2|Q3|Q4`',
    `fiscal_year` STRING COMMENT 'Fiscal year to which this attestation applies. Used for SOX certifications and annual compliance reporting.',
    `follow_up_required_flag` BOOLEAN COMMENT 'Indicates whether follow-up action or investigation is required based on disclosed exceptions or review findings. True if follow-up is needed, false otherwise.',
    `gxp_category` STRING COMMENT 'Category of Good Practice regulation that this attestation covers. Applicable for GxP compliance declarations in pharmaceutical operations.. Valid values are `gmp|glp|gcp|gdp|gvp`',
    `ip_address` STRING COMMENT 'IP address from which the attestation was submitted. Captured for audit trail and security purposes per 21 CFR Part 11 requirements.. Valid values are `^(?:[0-9]{1,3}.){3}[0-9]{1,3}$`',
    `jurisdiction` STRING COMMENT 'Geographic jurisdiction or country code where this attestation applies. Uses ISO 3166-1 alpha-3 country codes.. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this attestation record was last updated. Tracks the most recent change to any field in the record.',
    `period_end_date` DATE COMMENT 'Ending date of the period covered by this attestation. Together with start date defines the attestation coverage window.',
    `period_start_date` DATE COMMENT 'Beginning date of the period covered by this attestation. Defines the temporal scope of compliance being certified.',
    `policy_version` STRING COMMENT 'Version number of the compliance policy or code of conduct document that the attestor is certifying adherence to. Ensures attestations are tied to specific policy versions.. Valid values are `^[0-9]{1,3}.[0-9]{1,3}$`',
    `regulatory_framework` STRING COMMENT 'Primary regulatory framework or standard that governs this attestation (e.g., 21 CFR Part 11, GDPR, HIPAA). Provides regulatory context for the attestation.',
    `review_notes` STRING COMMENT 'Comments or notes entered by the reviewer during the attestation review process. May include reasons for rejection or requests for clarification.',
    `review_timestamp` TIMESTAMP COMMENT 'Date and time when the attestation was reviewed and approved or rejected by the compliance reviewer. Null if not yet reviewed.',
    `risk_level` STRING COMMENT 'Risk level associated with this attestation based on the role, scope, and exceptions disclosed. Used for prioritizing compliance reviews and follow-up actions.. Valid values are `low|medium|high|critical`',
    `sox_section` STRING COMMENT 'Specific section of the Sarbanes-Oxley Act that this attestation relates to, if applicable. Primarily used for CEO/CFO certifications and internal control attestations.. Valid values are `section_302|section_404|section_906`',
    `submission_method` STRING COMMENT 'Method or channel through which the attestation was submitted. Tracks the interface used for compliance reporting.. Valid values are `web_portal|mobile_app|email|paper`',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the attestation was formally submitted by the attestor. Serves as the official submission record for audit and compliance purposes.',
    `training_completion_date` DATE COMMENT 'Date when the attestor completed the required compliance training associated with this attestation. Null if training was not required or not completed.',
    `training_completion_flag` BOOLEAN COMMENT 'Indicates whether required compliance training was completed prior to attestation submission. True if training was completed, false otherwise.',
    CONSTRAINT pk_attestation PRIMARY KEY(`attestation_id`)
) COMMENT 'Transactional record for formal compliance attestations and certifications submitted by employees, managers, and executives confirming adherence to compliance policies, codes of conduct, and regulatory obligations. Covers annual code of conduct certifications, SOX sub-certifications (CEO/CFO 302 certifications), GxP compliance declarations, and GDPR data handling attestations. Captures attestor identity, attestation type, attestation period, attestation content version, submission date, and any disclosed exceptions or qualifications.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` (
    `warning_letter_id` BIGINT COMMENT 'Unique identifier for the warning letter enforcement action record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who created this warning letter record in the system.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Warning letter remediation is a major cost center requiring dedicated budget tracking. Companies establish internal orders to capture all remediation costs (CAPA execution, validation, consulting) for',
    `gxp_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.gxp_obligation. Business justification: Warning letters cite specific regulatory obligations (CFR sections, GMP requirements). This FK links each warning letter to the master obligation record, enabling analysis of which obligations are mos',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last modified this warning letter record in the system.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to masterdata.plant. Business justification: Warning letters cite specific manufacturing sites. Site remediation and reinspection are tracked. Essential for regulatory action management and site closure risk assessment.',
    `primary_warning_employee_id` BIGINT COMMENT 'Employee identifier of the individual responsible for coordinating the warning letter response across quality, regulatory, and site teams.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Warning letters trigger compliance program activities and remediation efforts. Should be tracked within the context of the relevant compliance program (GMP, GCP, etc.) for program performance monitori',
    `quality_capa_id` BIGINT COMMENT 'Identifier of the CAPA plan initiated in response to the warning letter findings.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Warning letters are issued to specific legal entities. The entity must respond and implement CAPAs. Essential for regulatory action tracking, executive reporting, and consent decree management. Remove',
    `site_id` BIGINT COMMENT 'Identifier of the manufacturing site, clinical site, or facility that received the warning letter.',
    `regulatory_inspection_id` BIGINT COMMENT 'Identifier of the regulatory inspection that resulted in this warning letter, if applicable.',
    `policy_document_id` BIGINT COMMENT 'Document management system identifier or reference number for the formal response document submitted to the health authority.',
    `followup_warning_letter_id` BIGINT COMMENT 'Self-referencing FK on warning_letter (followup_warning_letter_id)',
    `actual_completion_date` DATE COMMENT 'Actual date when all corrective and preventive actions were completed and verified.',
    `cfr_citations` STRING COMMENT 'Specific CFR citations referenced in the warning letter (e.g., 21 CFR 211.22, 21 CFR 211.160, 21 CFR 312.50). Pipe-separated list for multiple citations.',
    `cited_violations` STRING COMMENT 'Summary of the violations cited in the warning letter, including specific regulatory deficiencies and non-compliance findings.',
    `closure_date` DATE COMMENT 'Date the warning letter was officially closed by the health authority after acceptance of corrective actions.',
    `closure_status` STRING COMMENT 'Final closure determination by the health authority indicating whether the response and corrective actions were satisfactory.. Valid values are `open|closed_satisfactory|closed_with_conditions|escalated_to_consent_decree|escalated_to_import_alert`',
    `commitment_summary` STRING COMMENT 'Summary of the corrective and preventive action commitments made to the health authority in the response.',
    `consent_decree_related_flag` BOOLEAN COMMENT 'Indicates whether the warning letter is related to or resulted in a consent decree with the health authority.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this warning letter record was first created in the system.',
    `executive_notification_flag` BOOLEAN COMMENT 'Indicates whether executive leadership (CEO, Board of Directors) was notified of the warning letter due to severity or business impact.',
    `gmp_citation` STRING COMMENT 'Specific GMP guideline or ICH guideline citations referenced in the warning letter (e.g., ICH Q7, EU GMP Annex 1).',
    `health_authority_acknowledgment_date` DATE COMMENT 'Date the health authority acknowledged receipt of the organizations response.',
    `health_authority_feedback` STRING COMMENT 'Feedback or comments provided by the health authority on the adequacy of the response and corrective actions.',
    `import_alert_flag` BOOLEAN COMMENT 'Indicates whether the warning letter resulted in an FDA import alert preventing product importation into the United States.',
    `issue_date` DATE COMMENT 'Date the warning letter was officially issued by the health authority. This is the principal business event timestamp for the enforcement action.',
    `issuing_authority` STRING COMMENT 'Name of the regulatory health authority that issued the warning letter (e.g., FDA, EMA, MHRA, PMDA, NMPA).',
    `issuing_authority_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the health authority that issued the letter (e.g., USA, GBR, JPN, CHN, DEU).. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this warning letter record was last modified in the system.',
    `legal_review_required_flag` BOOLEAN COMMENT 'Indicates whether legal counsel review is required for the response due to potential litigation or enforcement action risk.',
    `letter_document_url` STRING COMMENT 'Document management system URL or file path to the original warning letter document received from the health authority.',
    `letter_reference_number` STRING COMMENT 'Official reference number assigned by the health authority to the warning letter or untitled letter (e.g., FDA Warning Letter WL-2023-001234). This is the externally-known unique identifier for the enforcement communication.',
    `letter_status` STRING COMMENT 'Current lifecycle status of the warning letter from receipt through response, commitment fulfillment, and health authority closure. [ENUM-REF-CANDIDATE: received|under_review|response_in_progress|response_submitted|pending_closure|closed|escalated — 7 candidates stripped; promote to reference product]',
    `letter_type` STRING COMMENT 'Classification of the enforcement communication type issued by the health authority.. Valid values are `warning_letter|untitled_letter|regulatory_meeting_minutes|consent_decree|import_alert|other`',
    `notes` STRING COMMENT 'Internal notes, comments, or additional context regarding the warning letter, response strategy, or lessons learned.',
    `process_scope` STRING COMMENT 'Description of the manufacturing processes, quality control processes, or clinical trial processes that are within the scope of the warning letter.',
    `product_impact_flag` BOOLEAN COMMENT 'Indicates whether the warning letter findings have direct impact on marketed products, requiring potential recalls, holds, or market withdrawals.',
    `product_scope` STRING COMMENT 'Description of the drug products, drug substances, or biologics that are within the scope of the warning letter. May include product names, NDC codes, or therapeutic areas.',
    `public_disclosure_flag` BOOLEAN COMMENT 'Indicates whether the warning letter has been publicly disclosed by the health authority (e.g., published on FDA Warning Letters database).',
    `receipt_date` DATE COMMENT 'Date the warning letter was received by the organization or site.',
    `regulatory_action_risk` STRING COMMENT 'Assessment of potential escalated regulatory actions if corrective actions are not satisfactory (e.g., consent decree, injunction, criminal prosecution).. Valid values are `none|consent_decree|injunction|criminal_prosecution|product_seizure|import_detention`',
    `reinspection_date` DATE COMMENT 'Date of the follow-up reinspection conducted by the health authority to verify corrective actions.',
    `reinspection_required_flag` BOOLEAN COMMENT 'Indicates whether the health authority has required a follow-up reinspection to verify corrective actions.',
    `response_due_date` DATE COMMENT 'Deadline by which the organization must submit a formal response to the health authority, typically 15 business days from receipt for FDA warning letters.',
    `response_submission_date` DATE COMMENT 'Date the formal response was submitted to the health authority.',
    `risk_level` STRING COMMENT 'Internal risk assessment of the warning letter based on severity of violations, product impact, and regulatory consequences.. Valid values are `critical|high|medium|low`',
    `target_completion_date` DATE COMMENT 'Target date for completion of all corrective and preventive actions committed in the response.',
    CONSTRAINT pk_warning_letter PRIMARY KEY(`warning_letter_id`)
) COMMENT 'Master record for FDA Warning Letters, Untitled Letters, and equivalent formal enforcement communications received from health authorities. Captures letter reference number, issuing agency, issue date, receiving site or entity, cited violations (CFR citations), product or process scope, response deadline, response submission date, and closure status. Tracks the full lifecycle from receipt through response, commitment fulfillment, and health authority closure. Distinct from inspection_observation (individual findings) and inspection_response (formal response) — this is the authoritative record of the enforcement action itself.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`compliance`.`program_obligation_scope` (
    `program_obligation_scope_id` BIGINT COMMENT 'Unique identifier for this program-obligation scope assignment. Primary key.',
    `compliance_program_id` BIGINT COMMENT 'Foreign key to compliance_program',
    `gxp_obligation_id` BIGINT COMMENT 'Foreign key linking to the GxP regulatory obligation covered by this program',
    `program_id` BIGINT COMMENT 'Foreign key linking to the compliance program that manages this obligation',
    `assigned_by` STRING COMMENT 'Role or individual who assigned this obligation to this program, typically a compliance manager or program owner.',
    `assignment_date` DATE COMMENT 'Date when this obligation was formally assigned to this program in the compliance management system.',
    `compliance_status` STRING COMMENT 'Current assessment of compliance with this specific obligation within the context of this program. Status may differ from the obligations enterprise-wide status because program scope may be narrower. Explicitly identified in detection phase relationship data.',
    `coverage_percentage` DECIMAL(18,2) COMMENT 'Percentage of the obligations full scope that is covered by this program (0-100). Useful when an obligation spans multiple programs and each program covers a portion.',
    `effective_date` DATE COMMENT 'Date when this obligation was assigned to this program and became actively managed under the program scope. Explicitly identified in detection phase relationship data.',
    `expiration_date` DATE COMMENT 'Date when this obligation assignment to the program expires or is scheduled to be removed from program scope. Null for ongoing assignments. Explicitly identified in detection phase relationship data.',
    `inspection_readiness_flag` BOOLEAN COMMENT 'Boolean indicator of whether this program is inspection-ready for this specific obligation, based on program-specific controls and documentation.',
    `last_assessment_date` DATE COMMENT 'Date of the most recent compliance assessment for this obligation within this programs scope. Explicitly identified in detection phase relationship data.',
    `last_modified_by` STRING COMMENT 'User or system that last modified this program-obligation scope record.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp of the last modification to this program-obligation scope record.',
    `next_assessment_date` DATE COMMENT 'Scheduled date for the next compliance assessment of this obligation within this programs scope. Explicitly identified in detection phase relationship data.',
    `program_scope_notes` STRING COMMENT 'Free-text notes describing how this obligation is scoped within this program, including any program-specific interpretations, exclusions, or implementation details. Explicitly identified in detection phase relationship data.',
    `risk_level` STRING COMMENT 'Risk level of this obligation within the context of this specific program, which may differ from the obligations enterprise risk level based on program scope and controls. Explicitly identified in detection phase relationship data.',
    CONSTRAINT pk_program_obligation_scope PRIMARY KEY(`program_obligation_scope_id`)
) COMMENT 'This association product represents the assignment of specific GxP regulatory obligations to compliance programs. It captures which obligations are actively managed under which programs, the compliance status of each obligation within the program context, assessment schedules, and risk levels. Each record links one compliance_program to one gxp_obligation with attributes that exist only in the context of this program-obligation relationship, enabling compliance teams to track program effectiveness by obligation and manage regulatory coverage systematically.. Existence Justification: In pharmaceutical compliance operations, a single compliance program (e.g., GMP Compliance Program) actively manages multiple GxP obligations (e.g., batch record review, equipment qualification, cleaning validation), and conversely, a single GxP obligation (e.g., 21 CFR 211.192 production record review) is often covered by multiple compliance programs across different sites or business units. Compliance teams actively create, update, and manage these program-obligation assignments to ensure comprehensive regulatory coverage, track compliance status per program-obligation pair, and report on program effectiveness by obligation.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`compliance`.`fmv_assessment` (
    `fmv_assessment_id` BIGINT COMMENT 'Primary key for fmv_assessment',
    `master_id` BIGINT COMMENT 'Reference to the healthcare professional receiving compensation or services subject to FMV assessment, critical for transparency reporting.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or service provider being assessed for fair market value compliance.',
    `superseded_fmv_assessment_id` BIGINT COMMENT 'Self-referencing FK on fmv_assessment (superseded_fmv_assessment_id)',
    `approval_date` DATE COMMENT 'Date when the FMV assessment was formally approved by authorized reviewer, establishing compliance timestamp.',
    `assessed_value_amount` DECIMAL(18,2) COMMENT 'Monetary value determined as fair market value for the assessed item or service, used for transparency reporting and anti-kickback compliance.',
    `assessment_date` DATE COMMENT 'Date when the fair market value assessment was performed, critical for establishing temporal validity of valuation.',
    `assessment_number` STRING COMMENT 'Business identifier for the FMV assessment, externally referenced in compliance documentation and audit trails.',
    `assessment_scope` STRING COMMENT 'Detailed description of what is being assessed, including deliverables, time commitment, and expected outcomes.',
    `assessment_status` STRING COMMENT 'Current lifecycle state of the FMV assessment within the compliance approval workflow.',
    `assessment_type` STRING COMMENT 'Category of fair market value assessment being conducted, aligned with anti-kickback and transparency requirements.',
    `assessor_name` STRING COMMENT 'Name of the individual or team who conducted the fair market value assessment, required for audit trail.',
    `assessor_role` STRING COMMENT 'Functional role of the person who performed the assessment, establishing authority and expertise.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking this FMV assessment to detailed audit logs and supporting documentation for regulatory inspection readiness.',
    `comparable_data_sources` STRING COMMENT 'References to market data, industry benchmarks, or comparable transactions used to support the FMV determination.',
    `contract_reference_number` STRING COMMENT 'Reference to the associated contract or agreement for which this FMV assessment was performed, enabling cross-functional traceability.',
    `created_by_user` STRING COMMENT 'User identifier of the person who created this FMV assessment record, required for attributability under ALCOA+ principles.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this FMV assessment record was first created in the system, required for audit trail and ALCOA+ compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the assessed value amount.',
    `data_integrity_status` STRING COMMENT 'ALCOA+ compliance status indicating whether this FMV assessment record meets attributable, legible, contemporaneous, original, and accurate standards.',
    `deviation_from_benchmark_pct` DECIMAL(18,2) COMMENT 'Percentage variance between assessed value and industry benchmark, used to flag outliers requiring additional scrutiny.',
    `disclosure_required_flag` BOOLEAN COMMENT 'Indicates whether this FMV assessment must be disclosed in public transparency reports under applicable regulations.',
    `effective_end_date` DATE COMMENT 'Date when the assessed fair market value expires and requires reassessment, nullable for open-ended assessments.',
    `effective_start_date` DATE COMMENT 'Date from which the assessed fair market value becomes valid and enforceable for compliance purposes.',
    `geographic_market` STRING COMMENT 'Three-letter ISO country code representing the geographic market context for the FMV assessment, as fair market value varies by region.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this FMV assessment is currently active and valid for compliance purposes, or has been superseded or archived.',
    `justification_notes` STRING COMMENT 'Detailed rationale and supporting evidence for the assessed fair market value, critical for regulatory inspection readiness.',
    `last_modified_by_user` STRING COMMENT 'User identifier of the person who last modified this FMV assessment record, supporting audit trail and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this FMV assessment record, supporting change control and audit requirements.',
    `reassessment_due_date` DATE COMMENT 'Scheduled date for the next periodic review of fair market value, ensuring ongoing compliance with current market conditions.',
    `record_version_number` STRING COMMENT 'Version number of this FMV assessment record, incremented with each modification to support change tracking and data lineage.',
    `regulatory_framework` STRING COMMENT 'Primary regulatory standard or law governing this FMV assessment, determining disclosure and compliance obligations.',
    `reviewer_name` STRING COMMENT 'Name of the individual who reviewed and approved the FMV assessment, required for segregation of duties.',
    `risk_level` STRING COMMENT 'Compliance risk classification for this FMV assessment based on regulatory exposure and materiality.',
    `therapeutic_area` STRING COMMENT 'Medical specialty or therapeutic domain relevant to the FMV assessment, used for context-specific valuation.',
    `valuation_methodology` STRING COMMENT 'Method used to determine the fair market value, required for audit trail and regulatory defense.',
    CONSTRAINT pk_fmv_assessment PRIMARY KEY(`fmv_assessment_id`)
) COMMENT 'Master reference table for fmv_assessment. Referenced by fmv_assessment_id.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`compliance`.`triggering_event` (
    `triggering_event_id` BIGINT COMMENT 'Primary key for triggering_event',
    `employee_id` BIGINT COMMENT 'User identifier of the person who created this triggering event definition.',
    `modified_by_user_employee_id` BIGINT COMMENT 'User identifier of the person who last modified this triggering event definition.',
    `notification_template_id` BIGINT COMMENT 'Identifier of the standard notification template to be used when this triggering event occurs.',
    `workflow_template_id` BIGINT COMMENT 'Identifier of the standard workflow template to be initiated when this triggering event occurs.',
    `preceding_triggering_event_id` BIGINT COMMENT 'Self-referencing FK on triggering_event (preceding_triggering_event_id)',
    `alcoa_plus_principle` STRING COMMENT 'Specific ALCOA+ data integrity principle that this triggering event relates to (Attributable, Legible, Contemporaneous, Original, Accurate, Complete, Consistent, Enduring, Available).',
    `applicable_business_functions` STRING COMMENT 'Comma-separated list of business functions where this triggering event is applicable (e.g., manufacturing, clinical trials, quality control, regulatory affairs).',
    `applicable_therapeutic_areas` STRING COMMENT 'Comma-separated list of therapeutic areas where this triggering event is applicable (e.g., oncology, immunology, rare diseases). Null if applicable to all areas.',
    `approval_authority_role` STRING COMMENT 'Organizational role with authority to approve closure or resolution of this triggering event type.',
    `automated_detection_flag` BOOLEAN COMMENT 'Indicates whether this triggering event can be automatically detected by compliance monitoring systems (True) or requires manual identification (False).',
    `capa_required_flag` BOOLEAN COMMENT 'Indicates whether this triggering event type mandates initiation of a CAPA process (True) or not (False).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this triggering event record was first created in the system.',
    `triggering_event_description` STRING COMMENT 'Detailed description of the triggering event, including conditions that constitute the event and expected compliance response.',
    `detection_criteria` STRING COMMENT 'Technical or business criteria used to detect or identify when this triggering event has occurred.',
    `effective_end_date` DATE COMMENT 'Date on which this triggering event definition ceases to be effective. Null for currently active definitions.',
    `effective_start_date` DATE COMMENT 'Date from which this triggering event definition becomes effective and active in compliance monitoring.',
    `escalation_required_flag` BOOLEAN COMMENT 'Indicates whether this triggering event type requires automatic escalation to senior management or regulatory affairs (True) or not (False).',
    `event_category` STRING COMMENT 'High-level classification of the triggering event by compliance domain (quality, regulatory, safety, data integrity, GxP, SOX, GDPR).',
    `event_code` STRING COMMENT 'Unique alphanumeric code identifying the type of triggering event in compliance monitoring systems.',
    `event_name` STRING COMMENT 'Human-readable name of the triggering event (e.g., Deviation Detected, Audit Finding, CAPA Initiated).',
    `event_type` STRING COMMENT 'Specific type of triggering event within the category (deviation, audit finding, inspection observation, CAPA, change control, complaint, adverse event).',
    `inspection_readiness_flag` BOOLEAN COMMENT 'Indicates whether this triggering event type requires immediate inspection readiness activities (True) or not (False).',
    `investigation_required_flag` BOOLEAN COMMENT 'Indicates whether this triggering event type mandates a formal investigation (True) or can be resolved through standard procedures (False).',
    `last_review_date` DATE COMMENT 'Date when this triggering event definition was last reviewed and validated by compliance team.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this triggering event record was last modified.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this triggering event definition.',
    `owner_role` STRING COMMENT 'Organizational role or function responsible for managing and responding to this triggering event type (e.g., Quality Assurance Manager, Regulatory Affairs Director).',
    `priority` STRING COMMENT 'Priority level assigned to the triggering event for response and remediation activities (urgent, high, medium, low).',
    `regulatory_citation` STRING COMMENT 'Specific regulatory citation or section reference that mandates monitoring of this triggering event (e.g., 21 CFR 11.10, EU Annex 11 Section 4).',
    `regulatory_framework` STRING COMMENT 'Primary regulatory framework or standard that this triggering event is associated with (21 CFR Part 11, EU Annex 11, ICH Q10, GDPR, SOX, GMP, GCP, GLP).',
    `reportable_to_authority_flag` BOOLEAN COMMENT 'Indicates whether this triggering event type must be reported to regulatory authorities (True) or is internal only (False).',
    `reporting_timeframe_days` STRING COMMENT 'Number of days within which this triggering event must be reported to regulatory authorities if reportable. Null if not reportable.',
    `response_timeframe_hours` STRING COMMENT 'Maximum number of hours allowed for initial response to this triggering event type based on severity and priority.',
    `risk_assessment_required_flag` BOOLEAN COMMENT 'Indicates whether this triggering event type requires a formal risk assessment (True) or not (False).',
    `root_cause_analysis_required_flag` BOOLEAN COMMENT 'Indicates whether this triggering event type requires formal root cause analysis (True) or not (False).',
    `severity_level` STRING COMMENT 'Severity classification of the triggering event indicating the level of compliance risk or impact (critical, major, minor, informational).',
    `triggering_event_status` STRING COMMENT 'Current lifecycle status of this triggering event definition in the compliance monitoring system (active, inactive, deprecated, under review).',
    `version_number` STRING COMMENT 'Version number of this triggering event definition, following semantic versioning (e.g., v1.0, v2.1).',
    CONSTRAINT pk_triggering_event PRIMARY KEY(`triggering_event_id`)
) COMMENT 'Master reference table for triggering_event. Referenced by triggering_event_id.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_session` (
    `esignature_session_id` BIGINT COMMENT 'Primary key for esignature_session',
    `audit_trail_id` BIGINT COMMENT 'Identifier linking this electronic signature session to the corresponding audit trail record, ensuring complete traceability per ALCOA+ data integrity principles.',
    `delegated_from_user_employee_id` BIGINT COMMENT 'Identifier of the user who delegated their signature authority to the actual signer, if delegation was used.',
    `policy_document_id` BIGINT COMMENT 'Identifier of the document, record, or data object being signed during this electronic signature session.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who initiated or is assigned to complete the electronic signature session.',
    `witness_user_employee_id` BIGINT COMMENT 'Identifier of the user who served as a witness to the primary electronic signature, if witnessing was required.',
    `workflow_step_id` BIGINT COMMENT 'Identifier of the specific workflow step or approval stage that this electronic signature session fulfills within a broader business process.',
    `parent_esignature_session_id` BIGINT COMMENT 'Self-referencing FK on esignature_session (parent_esignature_session_id)',
    `application_name` STRING COMMENT 'Name of the software application or system module through which the electronic signature was executed.',
    `application_version` STRING COMMENT 'Version number of the software application at the time the electronic signature was captured, supporting system validation and audit requirements.',
    `authentication_method` STRING COMMENT 'Method used to authenticate the users identity during the electronic signature session, ensuring compliance with identity verification requirements.',
    `authentication_timestamp` TIMESTAMP COMMENT 'Date and time when the user successfully authenticated their identity to initiate or complete the signature session.',
    `completed_timestamp` TIMESTAMP COMMENT 'Date and time when the electronic signature session was successfully completed with all required signatures captured, or null if not yet completed.',
    `compliance_framework` STRING COMMENT 'Primary regulatory framework governing this electronic signature session, such as 21 CFR Part 11, EU Annex 11, or GDPR, guiding audit and validation requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this electronic signature session record was first created in the system, supporting audit trail and data lineage requirements.',
    `department_code` STRING COMMENT 'Code identifying the department or functional area of the signer, relevant for organizational audit trails and compliance reporting.',
    `device_identifier` STRING COMMENT 'Unique identifier of the device or workstation used to perform the electronic signature, supporting device-level audit trails.',
    `document_type` STRING COMMENT 'Classification of the document being signed, such as batch record, protocol, SOP, deviation report, or change control, relevant for compliance categorization.',
    `document_version` STRING COMMENT 'Version identifier of the document at the time of signature, ensuring traceability to the exact content that was approved or reviewed.',
    `expiration_timestamp` TIMESTAMP COMMENT 'Date and time when the electronic signature session will expire if not completed, enforcing time-bound signature requirements for compliance.',
    `failure_reason` STRING COMMENT 'Description of the reason why the electronic signature session failed or was cancelled, supporting root cause analysis and process improvement.',
    `full_name` STRING COMMENT 'Complete legal name of the individual performing the electronic signature, captured at the time of signature for audit and compliance purposes.',
    `initiated_timestamp` TIMESTAMP COMMENT 'Date and time when the electronic signature session was first initiated by the system or user, marking the beginning of the signature workflow.',
    `ip_address` STRING COMMENT 'IP address of the device from which the electronic signature session was initiated, captured for security audit and forensic analysis.',
    `is_delegated` BOOLEAN COMMENT 'Indicates whether this electronic signature session was performed under delegated authority, where one user signs on behalf of another per approved delegation rules.',
    `is_witnessed` BOOLEAN COMMENT 'Indicates whether this electronic signature session required or included a witness signature, common in critical GxP processes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this electronic signature session record was last updated, tracking any changes to session metadata for compliance purposes.',
    `location_code` STRING COMMENT 'Code representing the physical or organizational location where the electronic signature session was performed, supporting site-level compliance tracking.',
    `reason_for_signature` STRING COMMENT 'Free-text explanation or justification provided by the signer describing why the signature is being applied, supporting audit trail requirements.',
    `retry_count` STRING COMMENT 'Number of authentication or signature attempts made during this session, used to detect potential security issues or user difficulties.',
    `session_duration_seconds` STRING COMMENT 'Total duration of the electronic signature session in seconds, from initiation to completion or cancellation, used for performance monitoring and anomaly detection.',
    `session_number` STRING COMMENT 'Human-readable business identifier for the electronic signature session, typically displayed in audit reports and compliance documentation.',
    `session_status` STRING COMMENT 'Current lifecycle state of the electronic signature session, tracking progression from initiation through completion or termination.',
    `session_type` STRING COMMENT 'Classification of the electronic signature session based on its regulatory and business purpose within the GxP environment.',
    `signature_algorithm` STRING COMMENT 'Cryptographic algorithm used to generate the signature hash, such as SHA-256 or RSA, supporting technical validation of signature integrity.',
    `signature_hash` STRING COMMENT 'Cryptographic hash of the signed content at the time of signature, ensuring data integrity and detecting any subsequent tampering per ALCOA+ principles.',
    `signature_meaning` STRING COMMENT 'The intended meaning or purpose of the electronic signature as declared by the signer, such as Reviewed by, Approved by, Verified by, required per 21 CFR Part 11.',
    `username` STRING COMMENT 'Unique username of the individual performing the electronic signature, required for audit trail and non-repudiation per GxP regulations.',
    `witness_timestamp` TIMESTAMP COMMENT 'Date and time when the witness signature was applied, if witnessing was required for this session.',
    `workflow_step_name` STRING COMMENT 'Descriptive name of the workflow step or approval stage associated with this signature session, providing business context for the signature action.',
    CONSTRAINT pk_esignature_session PRIMARY KEY(`esignature_session_id`)
) COMMENT 'Master reference table for esignature_session. Referenced by session_id.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`compliance`.`workflow_step` (
    `workflow_step_id` BIGINT COMMENT 'Primary key for workflow_step',
    `document_template_id` BIGINT COMMENT 'Reference to the standard document template or form that must be completed for this workflow step.',
    `preceding_workflow_step_id` BIGINT COMMENT 'Self-referencing FK on workflow_step (preceding_workflow_step_id)',
    `alcoa_plus_principle` STRING COMMENT 'The primary ALCOA+ data integrity principle that this workflow step enforces or validates.',
    `approval_authority_level` STRING COMMENT 'Minimum organizational authority level required to approve or complete this workflow step.',
    `approved_by` STRING COMMENT 'Username or identifier of the authorized person who approved this workflow step definition for production use.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this workflow step definition was formally approved.',
    `audit_trail_level` STRING COMMENT 'Level of audit trail detail required for this workflow step, ranging from basic timestamp logging to comprehensive change tracking.',
    `change_control_number` STRING COMMENT 'Reference number of the change control request that authorized the creation or modification of this workflow step.',
    `control_effectiveness_rating` STRING COMMENT 'Assessment of how effectively this workflow step mitigates identified compliance risks, typically evaluated during internal audits.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this workflow step record was first created in the system.',
    `documentation_required` BOOLEAN COMMENT 'Indicates whether formal documentation or evidence must be attached or generated upon completion of this workflow step.',
    `effective_end_date` DATE COMMENT 'Date after which this workflow step definition is no longer active, used for version control and historical tracking.',
    `effective_start_date` DATE COMMENT 'Date from which this workflow step definition becomes active and enforceable.',
    `escalation_threshold_hours` DECIMAL(18,2) COMMENT 'Number of hours after which an incomplete workflow step triggers escalation to management or compliance officers.',
    `is_critical_control` BOOLEAN COMMENT 'Indicates whether this step represents a critical control point requiring enhanced monitoring and documentation per SOX or GxP requirements.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this workflow step is mandatory for compliance or can be optionally skipped based on business rules.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the person who last modified this workflow step definition.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this workflow step record was last updated in the system.',
    `last_review_date` DATE COMMENT 'Date when this workflow step definition was last reviewed and validated by compliance or quality assurance teams.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this workflow step definition to ensure continued regulatory alignment.',
    `regulatory_reference` STRING COMMENT 'Citation of the specific regulatory requirement, standard section, or guidance document that mandates or informs this workflow step.',
    `requires_electronic_signature` BOOLEAN COMMENT 'Indicates whether this workflow step requires electronic signature per 21 CFR Part 11 or EU Annex 11 regulations.',
    `responsible_role` STRING COMMENT 'The organizational role or job function responsible for executing this workflow step (e.g., Quality Assurance Manager, Compliance Officer, Data Steward).',
    `review_frequency_months` STRING COMMENT 'Number of months between mandatory reviews of this workflow step definition.',
    `risk_rating` STRING COMMENT 'Risk assessment rating for this workflow step based on potential impact to product quality, patient safety, or regulatory compliance.',
    `sequence_number` STRING COMMENT 'Numeric order of this step within its parent workflow, used for execution sequencing and process flow visualization.',
    `signature_meaning` STRING COMMENT 'The regulatory meaning or intent of the electronic signature required at this step (e.g., Reviewed by, Approved by, Verified by).',
    `sla_duration_hours` DECIMAL(18,2) COMMENT 'Target duration in hours for completing this workflow step, used for compliance monitoring and performance tracking.',
    `step_category` STRING COMMENT 'Functional category of the workflow step indicating the type of compliance activity performed.',
    `step_code` STRING COMMENT 'Unique business identifier code for the workflow step, used for external reference and system integration.',
    `step_description` STRING COMMENT 'Detailed description of the purpose, activities, and expected outcomes of this workflow step.',
    `step_name` STRING COMMENT 'Human-readable name of the workflow step.',
    `step_status` STRING COMMENT 'Current lifecycle status of the workflow step indicating whether it is in active use.',
    `system_integration_endpoint` STRING COMMENT 'API endpoint or system interface used to trigger or complete this workflow step programmatically.',
    `training_course_code` STRING COMMENT 'Code or identifier of the training course that personnel must complete to be qualified for this workflow step.',
    `training_required` BOOLEAN COMMENT 'Indicates whether personnel must complete specific training before being authorized to execute this workflow step.',
    `version_number` STRING COMMENT 'Version identifier for this workflow step definition, following semantic versioning conventions for change control.',
    `workflow_type` STRING COMMENT 'Classification of the workflow this step belongs to, aligned with enterprise compliance programs.',
    `created_by` STRING COMMENT 'Username or identifier of the person who created this workflow step definition.',
    CONSTRAINT pk_workflow_step PRIMARY KEY(`workflow_step_id`)
) COMMENT 'Master reference table for workflow_step. Referenced by workflow_step_id.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`compliance`.`business_process` (
    `business_process_id` BIGINT COMMENT 'Primary key for business_process',
    `parent_business_process_id` BIGINT COMMENT 'Self-referencing FK on business_process (parent_business_process_id)',
    `approval_status` STRING COMMENT 'Current approval status of the business process documentation and procedures.',
    `audit_trail_required` BOOLEAN COMMENT 'Indicates whether this process requires comprehensive audit trail capture for all activities and changes.',
    `capa_linkage_enabled` BOOLEAN COMMENT 'Indicates whether this process is linked to the CAPA system for tracking corrective and preventive actions.',
    `cfr_part_11_applicable` BOOLEAN COMMENT 'Indicates whether this process involves electronic records or electronic signatures subject to 21 CFR Part 11 requirements.',
    `change_control_required` BOOLEAN COMMENT 'Indicates whether changes to this business process must follow formal change control procedures.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this business process record was first created in the system.',
    `criticality_level` STRING COMMENT 'Risk-based criticality assessment of the process based on its impact on product quality, patient safety, and regulatory compliance.',
    `data_integrity_alcoa_plus_required` BOOLEAN COMMENT 'Indicates whether this process must adhere to ALCOA+ data integrity principles: Attributable, Legible, Contemporaneous, Original, Accurate, plus Complete, Consistent, Enduring, and Available.',
    `deviation_tracking_enabled` BOOLEAN COMMENT 'Indicates whether deviations from this business process are tracked and investigated per quality management requirements.',
    `effective_date` DATE COMMENT 'Date when this version of the business process became or will become effective and enforceable.',
    `electronic_signature_required` BOOLEAN COMMENT 'Indicates whether this process requires electronic signatures for approval and authorization steps.',
    `eu_annex_11_applicable` BOOLEAN COMMENT 'Indicates whether this process involves computerized systems subject to EU GMP Annex 11 requirements.',
    `expiration_date` DATE COMMENT 'Date when this version of the business process expires and requires review or renewal. Null if no expiration is defined.',
    `gdpr_applicable` BOOLEAN COMMENT 'Indicates whether this process handles personal data subject to GDPR privacy and data protection requirements.',
    `gxp_classification` STRING COMMENT 'Indicates which Good Practice regulation applies to this process: Good Manufacturing Practice (GMP), Good Clinical Practice (GCP), Good Laboratory Practice (GLP), Good Distribution Practice (GDP), Good Pharmacovigilance Practice (GVP), or non-GxP.',
    `inspection_readiness_score` DECIMAL(18,2) COMMENT 'Quantitative assessment score (0-100) indicating the processs readiness for regulatory inspection based on documentation completeness, training records, and compliance evidence.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this business process record was last modified.',
    `last_review_date` DATE COMMENT 'Date when the business process was last formally reviewed for accuracy, compliance, and effectiveness.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the business process indicating its operational readiness and approval status.',
    `next_review_date` DATE COMMENT 'Date when the business process is scheduled for its next periodic review.',
    `process_category` STRING COMMENT 'High-level categorization of the business process by functional area within pharmaceutical operations.',
    `process_code` STRING COMMENT 'Unique alphanumeric code assigned to the business process for external reference and regulatory documentation. Used in audit trails and compliance reports.',
    `process_description` STRING COMMENT 'Detailed description of the business process including its purpose, scope, and key activities.',
    `process_name` STRING COMMENT 'Full descriptive name of the business process as recognized across the enterprise.',
    `process_owner` STRING COMMENT 'Name or identifier of the individual or role accountable for the design, execution, and compliance of this business process.',
    `process_type` STRING COMMENT 'Classification of the process by its role in the enterprise: core operational, support, management oversight, or regulatory compliance.',
    `regulatory_framework` STRING COMMENT 'Primary regulatory framework(s) governing this process, such as 21 CFR Part 11, EU Annex 11, GDPR, or ICH guidelines. Multiple frameworks may be listed.',
    `responsible_department` STRING COMMENT 'Department or organizational unit primarily responsible for executing and maintaining this business process.',
    `retired_timestamp` TIMESTAMP COMMENT 'Timestamp when this business process was retired or made obsolete. Null if the process is still active.',
    `review_frequency_months` STRING COMMENT 'Required frequency for periodic review of this business process, expressed in months.',
    `risk_assessment_date` DATE COMMENT 'Date when the most recent risk assessment was performed for this business process.',
    `sop_reference_number` STRING COMMENT 'Reference number of the primary Standard Operating Procedure document that defines this business process.',
    `sox_control_applicable` BOOLEAN COMMENT 'Indicates whether this process is subject to Sarbanes-Oxley Act internal control requirements for financial reporting.',
    `training_required` BOOLEAN COMMENT 'Indicates whether personnel must complete formal training before executing this business process.',
    `validation_date` DATE COMMENT 'Date when the business process was last validated or qualified. Null if validation is not required or not yet performed.',
    `validation_status` STRING COMMENT 'Current validation status of the business process indicating whether it has been formally validated per regulatory requirements.',
    `version_number` STRING COMMENT 'Version number of the current business process definition following semantic versioning (major.minor).',
    CONSTRAINT pk_business_process PRIMARY KEY(`business_process_id`)
) COMMENT 'Master reference table for business_process. Referenced by process_id.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`compliance`.`data_processing_activity` (
    `data_processing_activity_id` BIGINT COMMENT 'Primary key for data_processing_activity',
    `internal_control_id` BIGINT COMMENT 'Reference identifier of the SOX control framework element associated with this processing activity.',
    `parent_data_processing_activity_id` BIGINT COMMENT 'Self-referencing FK on data_processing_activity (parent_data_processing_activity_id)',
    `activity_name` STRING COMMENT 'Human-readable name or title of the data processing activity (e.g., Clinical Trial Data Collection, Patient Consent Management, Pharmacovigilance Reporting).',
    `activity_reference_number` STRING COMMENT 'Externally-known unique reference code or identifier for the data processing activity used in regulatory filings and audit trails.',
    `activity_type` STRING COMMENT 'Classification of the data processing activity based on its primary function within the data lifecycle.',
    `alcoa_plus_compliant` BOOLEAN COMMENT 'Indicates whether this processing activity meets ALCOA+ data integrity principles (Attributable, Legible, Contemporaneous, Original, Accurate, Complete, Consistent, Enduring, Available).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this data processing activity record was first created in the compliance management system.',
    `cross_border_transfer` BOOLEAN COMMENT 'Indicates whether this processing activity involves transfer of data across international borders.',
    `data_category` STRING COMMENT 'Classification of the type of data being processed (e.g., Personal Health Information, Clinical Trial Data, Manufacturing Records, Employee Data).',
    `data_destination_system` STRING COMMENT 'Name or identifier of the system or application to which processed data is transferred or stored.',
    `data_processor_name` STRING COMMENT 'Name of the third-party organization or internal department acting as data processor for this activity.',
    `data_protection_officer_assigned` BOOLEAN COMMENT 'Indicates whether a Data Protection Officer has been assigned oversight responsibility for this processing activity.',
    `data_retention_period_days` STRING COMMENT 'Number of days that data processed under this activity must be retained to meet regulatory and business requirements.',
    `data_source_system` STRING COMMENT 'Name or identifier of the system or application from which data is collected or processed for this activity.',
    `data_subject_category` STRING COMMENT 'Classification of individuals whose data is being processed (e.g., Clinical Trial Participants, Patients, Healthcare Professionals, Employees).',
    `dpia_completion_date` DATE COMMENT 'Date when the Data Protection Impact Assessment was completed for this processing activity, if required.',
    `effective_end_date` DATE COMMENT 'Date when this data processing activity was or will be terminated or archived. Null for ongoing activities.',
    `effective_start_date` DATE COMMENT 'Date when this data processing activity became or will become active and operational.',
    `gxp_classification` STRING COMMENT 'Classification of the activity under Good Practice regulations (Good Clinical Practice, Good Laboratory Practice, Good Manufacturing Practice, Good Pharmacovigilance Practice, Good Distribution Practice).',
    `is_active` BOOLEAN COMMENT 'Indicates whether this data processing activity record is currently active and in use within the compliance program.',
    `last_audit_date` DATE COMMENT 'Date when this data processing activity was last audited for compliance with regulatory and internal standards.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this data processing activity record was most recently updated or modified.',
    `legal_basis` STRING COMMENT 'The lawful basis under which the data processing activity is conducted, as required by privacy regulations.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this data processing activity to ensure continued compliance.',
    `organizational_security_measures` STRING COMMENT 'Description of organizational and procedural safeguards implemented to protect data (e.g., training, access policies, incident response procedures).',
    `processing_purpose` STRING COMMENT 'Detailed description of the business and regulatory purpose for which the data processing activity is conducted (e.g., Support clinical trial protocol execution, Fulfill pharmacovigilance obligations).',
    `processing_status` STRING COMMENT 'Current lifecycle state of the data processing activity within the compliance management system.',
    `processor_contract_reference` STRING COMMENT 'Reference number or identifier of the data processing agreement or contract governing the processor relationship.',
    `recipient_countries` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes representing countries to which data is transferred.',
    `record_version` STRING COMMENT 'Version number of this data processing activity record, incremented with each modification to support audit trail and change control.',
    `regulatory_inspection_ready` BOOLEAN COMMENT 'Indicates whether documentation and controls for this processing activity are ready for regulatory inspection.',
    `requires_dpia` BOOLEAN COMMENT 'Indicates whether a Data Protection Impact Assessment is required for this processing activity under privacy regulations.',
    `responsible_department` STRING COMMENT 'Name of the business unit or department responsible for managing and overseeing this data processing activity.',
    `retention_justification` STRING COMMENT 'Business and regulatory rationale for the specified data retention period.',
    `risk_level` STRING COMMENT 'Risk classification of the data processing activity based on data sensitivity, regulatory impact, and potential harm to data subjects.',
    `sox_control_applicable` BOOLEAN COMMENT 'Indicates whether this data processing activity is subject to Sarbanes-Oxley internal control requirements.',
    `technical_security_measures` STRING COMMENT 'Description of technical safeguards implemented to protect data processed under this activity (e.g., encryption, access controls, audit logging).',
    `transfer_mechanism` STRING COMMENT 'Legal mechanism used to enable cross-border data transfer (e.g., Standard Contractual Clauses, Binding Corporate Rules, Adequacy Decision).',
    CONSTRAINT pk_data_processing_activity PRIMARY KEY(`data_processing_activity_id`)
) COMMENT 'Master reference table for data_processing_activity. Referenced by data_processing_activity_id.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`compliance`.`document_template` (
    `document_template_id` BIGINT COMMENT 'Primary key for document_template',
    `superseded_document_template_id` BIGINT COMMENT 'Self-referencing FK on document_template (superseded_document_template_id)',
    `access_control_level` STRING COMMENT 'Security classification level that determines who can view, use, or modify this document template.',
    `applicable_regions` STRING COMMENT 'Geographic regions or jurisdictions where this document template is approved for use, stored as comma-separated ISO country codes.',
    `approval_date` DATE COMMENT 'Date when this document template version received formal approval for use in compliance documentation.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether documents generated from this template require formal approval workflow before finalization.',
    `approved_by` STRING COMMENT 'Name or identifier of the authorized person who approved this document template version for use.',
    `audit_trail_required_flag` BOOLEAN COMMENT 'Indicates whether documents generated from this template must maintain a complete audit trail of all changes and access events.',
    `business_process` STRING COMMENT 'The specific business process or workflow that this document template supports within the pharmaceutical operations.',
    `change_control_number` STRING COMMENT 'Unique identifier linking this template version to the formal change control record that authorized its creation or modification.',
    `compliance_category` STRING COMMENT 'The specific Good Practice domain that this template supports within the pharmaceutical compliance ecosystem.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this document template record was first created in the system.',
    `data_integrity_level` STRING COMMENT 'Classification of the data integrity controls required for documents generated from this template based on ALCOA+ principles.',
    `document_template_description` STRING COMMENT 'Detailed description of the document template purpose, intended use cases, and the type of compliance documentation it generates.',
    `effective_date` DATE COMMENT 'Date when this document template version becomes officially active and available for use in document generation.',
    `electronic_signature_required_flag` BOOLEAN COMMENT 'Indicates whether documents generated from this template require electronic signatures to comply with 21 CFR Part 11 requirements.',
    `expiration_date` DATE COMMENT 'Date when this document template version is scheduled to expire or be retired from active use. Null indicates no planned expiration.',
    `file_format` STRING COMMENT 'The output file format that documents generated from this template will be produced in.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this document template is currently active and available for use in generating compliance documents.',
    `keywords` STRING COMMENT 'Comma-separated list of searchable keywords and tags to facilitate discovery and categorization of the document template.',
    `language_code` STRING COMMENT 'ISO 639-1 language code indicating the primary language of the document template content.',
    `last_review_date` DATE COMMENT 'Date when the document template was last formally reviewed for accuracy, compliance, and continued applicability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this document template record was last modified or updated.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next mandatory review of the document template to maintain compliance and quality standards.',
    `owner_department` STRING COMMENT 'The organizational department or functional unit responsible for maintaining and governing this document template.',
    `regulatory_framework` STRING COMMENT 'Primary regulatory framework or standard that this document template is designed to support and ensure compliance with.',
    `retention_period_years` STRING COMMENT 'Number of years that documents generated from this template must be retained to meet regulatory and compliance requirements.',
    `review_frequency_months` STRING COMMENT 'Number of months between mandatory periodic reviews of the document template to ensure continued compliance and relevance.',
    `document_template_status` STRING COMMENT 'Current lifecycle status of the document template indicating its approval state and usability for document generation.',
    `storage_location` STRING COMMENT 'File system path or repository location where the physical template file is stored for access and version control.',
    `supersedes_template_id` BIGINT COMMENT 'Reference to the previous document template version that this current version replaces or supersedes.',
    `template_code` STRING COMMENT 'Unique business identifier code for the document template used across the organization for reference and lookup purposes.',
    `template_name` STRING COMMENT 'Human-readable name of the document template that clearly identifies its purpose and content type.',
    `template_type` STRING COMMENT 'Classification of the document template by its functional category within the pharmaceutical compliance framework.',
    `therapeutic_area` STRING COMMENT 'The therapeutic area or disease category that this document template is primarily associated with, such as oncology, immunology, or rare diseases.',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether users must complete formal training before being authorized to use this document template.',
    `version_number` STRING COMMENT 'Version identifier for the document template following semantic versioning to track template evolution and changes over time.',
    CONSTRAINT pk_document_template PRIMARY KEY(`document_template_id`)
) COMMENT 'Master reference table for document_template. Referenced by document_template_id.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`compliance`.`notification_template` (
    `notification_template_id` BIGINT COMMENT 'Primary key for notification_template',
    `superseded_notification_template_id` BIGINT COMMENT 'Self-referencing FK on notification_template (superseded_notification_template_id)',
    `acknowledgment_required_flag` BOOLEAN COMMENT 'Indicates whether recipients must explicitly acknowledge receipt and review of notifications generated from this template.',
    `approval_status` STRING COMMENT 'Current approval workflow status for the notification template indicating whether it has passed quality and compliance review.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the notification template was formally approved for use, recorded in ISO 8601 format with timezone.',
    `approved_by_user_id` BIGINT COMMENT 'Identifier of the user who approved this notification template version for production use.',
    `audit_trail_required_flag` BOOLEAN COMMENT 'Indicates whether notifications generated from this template require full audit trail tracking including delivery, read, and acknowledgment timestamps per 21 CFR Part 11 requirements.',
    `body_content` STRING COMMENT 'Main message body content of the notification template. May include HTML markup and merge field placeholders for dynamic content insertion.',
    `business_unit` STRING COMMENT 'Organizational business unit or division that owns and maintains this notification template (e.g., Quality Assurance, Regulatory Affairs, Clinical Operations).',
    `change_control_number` STRING COMMENT 'Unique identifier linking this template version to the formal change control record that authorized its creation or modification.',
    `compliance_category` STRING COMMENT 'Primary compliance framework or regulatory domain this notification template supports (GxP, SOX, GDPR, 21 CFR Part 11, EU Annex 11, Data Integrity ALCOA+).',
    `content_format` STRING COMMENT 'Format specification for the body content indicating markup language or text encoding used.',
    `created_by_user_id` BIGINT COMMENT 'Identifier of the user who originally created this notification template record.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this notification template record was first created in the system, recorded in ISO 8601 format with timezone.',
    `effective_end_date` DATE COMMENT 'Date after which this notification template version is no longer active. Null indicates the template is currently effective with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date from which this notification template version becomes active and available for use in compliance notification workflows.',
    `electronic_signature_required_flag` BOOLEAN COMMENT 'Indicates whether acknowledgment of notifications from this template requires electronic signature per 21 CFR Part 11 electronic signature requirements.',
    `escalation_required_flag` BOOLEAN COMMENT 'Indicates whether notifications from this template require escalation to higher management levels if not acknowledged within a defined timeframe.',
    `escalation_timeframe_hours` STRING COMMENT 'Number of hours after notification delivery before escalation is triggered, if escalation is required.',
    `language_code` STRING COMMENT 'ISO 639-1 language code (with optional ISO 3166-1 country code) indicating the language of the template content (e.g., en, en-US, de-DE).',
    `last_modified_by_user_id` BIGINT COMMENT 'Identifier of the user who most recently modified this notification template record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this notification template record was most recently modified, recorded in ISO 8601 format with timezone.',
    `last_used_timestamp` TIMESTAMP COMMENT 'Date and time when this notification template was most recently used to generate a notification, recorded in ISO 8601 format with timezone.',
    `last_validation_date` DATE COMMENT 'Date when the notification template most recently completed validation testing and approval.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this notification template to ensure continued compliance and relevance.',
    `owner_user_id` BIGINT COMMENT 'Identifier of the user or role responsible for maintaining and updating this notification template.',
    `priority_level` STRING COMMENT 'Business priority classification for notifications generated from this template, influencing delivery urgency and routing.',
    `recipient_role` STRING COMMENT 'Target role or function that should receive notifications generated from this template (e.g., Quality Assurance Manager, Compliance Officer, Site Head).',
    `regulatory_classification` STRING COMMENT 'Classification indicating the regulatory significance and validation requirements for this notification template.',
    `retention_period_days` STRING COMMENT 'Number of days that notifications generated from this template must be retained to meet regulatory and compliance record-keeping requirements.',
    `notification_template_status` STRING COMMENT 'Current lifecycle status of the notification template indicating whether it is available for use in compliance notification workflows.',
    `subject_line` STRING COMMENT 'Default subject line or title for the notification when delivered. May contain merge field placeholders.',
    `template_code` STRING COMMENT 'Unique business identifier code for the notification template used for external reference and system integration.',
    `template_name` STRING COMMENT 'Human-readable name of the notification template describing its purpose and use case.',
    `template_type` STRING COMMENT 'Classification of the notification template by delivery channel or mechanism.',
    `trigger_event` STRING COMMENT 'Business event or condition that initiates the use of this notification template (e.g., inspection scheduled, deviation detected, audit finding opened).',
    `usage_count` BIGINT COMMENT 'Total number of times this notification template has been used to generate and send notifications since activation.',
    `validation_status` STRING COMMENT 'Current validation state of the notification template indicating whether it has passed required GxP validation protocols.',
    `version_number` STRING COMMENT 'Semantic version number of the template following major.minor.patch convention to track template revisions and changes.',
    CONSTRAINT pk_notification_template PRIMARY KEY(`notification_template_id`)
) COMMENT 'Master reference table for notification_template. Referenced by notification_template_id.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`compliance`.`workflow_template` (
    `workflow_template_id` BIGINT COMMENT 'Primary key for workflow_template',
    `superseded_workflow_template_id` BIGINT COMMENT 'Self-referencing FK on workflow_template (superseded_workflow_template_id)',
    `applicable_regions` STRING COMMENT 'Comma-separated list of geographic regions where this workflow template is applicable based on regional regulatory requirements.',
    `applicable_sites` STRING COMMENT 'Comma-separated list of site codes or identifiers where this workflow template is applicable and can be used.',
    `approval_level_count` STRING COMMENT 'Number of approval levels required for workflow instances created from this template.',
    `approval_required` BOOLEAN COMMENT 'Indicates whether workflow instances created from this template require formal approval before execution.',
    `approved_by_user_id` BIGINT COMMENT 'Identifier of the user who approved this workflow template version for use.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the workflow template was formally approved for use.',
    `audit_trail_enabled` BOOLEAN COMMENT 'Indicates whether comprehensive audit trail logging is enabled for workflow instances created from this template to support ALCOA+ data integrity principles.',
    `compliance_domain` STRING COMMENT 'The specific compliance domain or area that this workflow template addresses within the enterprise compliance program.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the workflow template record was first created in the system.',
    `data_retention_years` STRING COMMENT 'Required retention period in years for workflow instances and associated data created from this template to meet regulatory requirements.',
    `effective_date` DATE COMMENT 'Date when this workflow template version becomes effective and available for use in compliance processes.',
    `electronic_signature_required` BOOLEAN COMMENT 'Indicates whether electronic signatures compliant with 21 CFR Part 11 are required for workflow instances created from this template.',
    `escalation_enabled` BOOLEAN COMMENT 'Indicates whether automatic escalation is enabled for overdue workflow instances created from this template.',
    `estimated_duration_hours` DECIMAL(18,2) COMMENT 'Estimated average duration in hours for completing a workflow instance created from this template.',
    `expiration_date` DATE COMMENT 'Date when this workflow template version expires and should no longer be used for new workflow instances. Null indicates no expiration.',
    `gxp_critical` BOOLEAN COMMENT 'Indicates whether this workflow template is classified as GxP-critical requiring enhanced controls and validation.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the workflow template is currently active and available for creating new workflow instances.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the workflow template indicating its readiness for use and operational status.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the workflow template record was last modified.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of the workflow template.',
    `notification_enabled` BOOLEAN COMMENT 'Indicates whether automated notifications are enabled for workflow instances created from this template.',
    `owner_department` STRING COMMENT 'Department or organizational unit responsible for maintaining and governing this workflow template.',
    `owner_user_id` BIGINT COMMENT 'Identifier of the user who owns and is responsible for maintaining this workflow template.',
    `regulatory_framework` STRING COMMENT 'Primary regulatory framework or standard that this workflow template is designed to support and ensure compliance with.',
    `review_frequency_months` STRING COMMENT 'Required frequency in months for periodic review of the workflow template to ensure continued compliance and relevance.',
    `risk_classification` STRING COMMENT 'Risk classification level of the workflow template based on potential impact to product quality, patient safety, and regulatory compliance.',
    `sla_target_hours` DECIMAL(18,2) COMMENT 'Target service level agreement time in hours for completing workflow instances created from this template.',
    `sop_reference_number` STRING COMMENT 'Reference number of the Standard Operating Procedure that governs the use and execution of this workflow template.',
    `template_code` STRING COMMENT 'Unique business identifier code for the workflow template used for external reference and system integration.',
    `template_description` STRING COMMENT 'Detailed description of the workflow template including its purpose, scope, and intended use cases within compliance processes.',
    `template_name` STRING COMMENT 'Human-readable name of the workflow template describing its purpose and scope.',
    `template_type` STRING COMMENT 'Classification of the workflow template by its primary compliance function and business process area.',
    `training_course_id` BIGINT COMMENT 'Identifier of the training course required for users to be authorized to use this workflow template.',
    `training_required` BOOLEAN COMMENT 'Indicates whether users must complete specific training before being authorized to use this workflow template.',
    `validation_date` DATE COMMENT 'Date when the workflow template was last validated or qualified for GxP use.',
    `validation_status` STRING COMMENT 'Current validation status of the workflow template indicating whether it has undergone required validation activities per GxP requirements.',
    `version_number` STRING COMMENT 'Version identifier for the workflow template following semantic versioning to track template evolution and changes.',
    CONSTRAINT pk_workflow_template PRIMARY KEY(`workflow_template_id`)
) COMMENT 'Master reference table for workflow_template. Referenced by workflow_template_id.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`compliance`.`audit_trail` (
    `audit_trail_id` BIGINT COMMENT 'Primary key for audit_trail',
    `additional_metadata` STRING COMMENT 'JSON or XML formatted string containing additional context-specific metadata not captured in standard fields. Enables extensibility for system-specific audit requirements.',
    `change_reason` STRING COMMENT 'Business justification or reason provided by the user for making the change. Required for GxP-critical modifications.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether this audit event is subject to regulatory compliance requirements (True) or is operational-only (False).',
    `created_by_system` STRING COMMENT 'Name of the system or service that created this audit trail record in the centralized audit repository.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this audit trail record was created in the audit repository. Distinct from event_timestamp which captures the business event time.',
    `data_classification` STRING COMMENT 'Classification level of the data affected by this audit event per enterprise data governance policy (restricted, confidential, internal, public).',
    `device_identifier` STRING COMMENT 'Unique identifier of the physical or virtual device used to perform the action (e.g., workstation ID, mobile device ID).',
    `electronic_signature_applied` BOOLEAN COMMENT 'Indicates whether an electronic signature was applied to this event per 21 CFR Part 11 requirements (True/False).',
    `entity_id` STRING COMMENT 'Unique identifier of the specific business object instance that was affected (e.g., batch number, protocol ID, specification ID).',
    `entity_name` STRING COMMENT 'Human-readable name or description of the affected entity for audit trail readability.',
    `entity_type` STRING COMMENT 'Type of business object or data entity that was affected by the audited action (e.g., Batch Record, Product Specification, Clinical Trial Protocol, Quality Event).',
    `event_category` STRING COMMENT 'High-level categorization of the audit event for compliance reporting and analysis (data modification, access, security, configuration, workflow, system).',
    `event_timestamp` TIMESTAMP COMMENT 'Precise date and time when the audited event occurred in the source system. This is the business event time, distinct from record creation time.',
    `event_type` STRING COMMENT 'Classification of the audit event action performed (create, read, update, delete, approve, reject).',
    `exception_flag` BOOLEAN COMMENT 'Indicates whether this audit event represents an exception or anomaly requiring investigation (True/False).',
    `field_name` STRING COMMENT 'Name of the specific data field or attribute that was modified during the event. Null for non-modification events.',
    `gxp_critical` BOOLEAN COMMENT 'Indicates whether the audited data or process is GxP-critical and subject to heightened regulatory scrutiny (True/False).',
    `hash_value` STRING COMMENT 'Cryptographic hash of the audit record content to ensure data integrity and detect tampering per 21 CFR Part 11 requirements.',
    `investigation_required` BOOLEAN COMMENT 'Indicates whether this audit event requires formal investigation or follow-up action (True/False).',
    `ip_address` STRING COMMENT 'IP address of the device or workstation from which the action was performed.',
    `location` STRING COMMENT 'Physical or logical location where the action was performed (e.g., site name, facility, department).',
    `new_value` STRING COMMENT 'New value of the field after the change was applied. Null for delete operations or non-modification events.',
    `old_value` STRING COMMENT 'Previous value of the field before the change was applied. Null for create operations or non-modification events.',
    `parent_audit_trail_id` BIGINT COMMENT 'Reference to a parent audit trail record if this event is part of a cascading or hierarchical audit chain. Null for top-level events.',
    `record_status` STRING COMMENT 'Current lifecycle status of the audit trail record itself (active, archived, deleted, locked).',
    `regulatory_framework` STRING COMMENT 'Applicable regulatory framework or standard governing this audit event (e.g., 21 CFR Part 11, EU Annex 11, GDPR, SOX).',
    `retention_period_years` STRING COMMENT 'Number of years this audit record must be retained per regulatory and business requirements.',
    `session_id` STRING COMMENT 'Unique identifier for the user session during which the event occurred. Enables correlation of related audit events.',
    `severity_level` STRING COMMENT 'Severity classification of the audit event for risk assessment and compliance monitoring (critical, high, medium, low, informational).',
    `signature_meaning` STRING COMMENT 'Business meaning of the electronic signature if applied (e.g., Reviewed By, Approved By, Verified By).',
    `source_system` STRING COMMENT 'Name or identifier of the system of record where the audited event originated (e.g., LIMS, ERP, MES, CTMS).',
    `source_system_module` STRING COMMENT 'Specific module or functional area within the source system where the event occurred (e.g., Batch Record, Inventory Management, Clinical Trial Management).',
    `transaction_id` STRING COMMENT 'Unique identifier for the business transaction that triggered this audit event. Enables grouping of related audit records.',
    `user_full_name` STRING COMMENT 'Full legal name of the user who performed the action at the time of the event.',
    `user_id` STRING COMMENT 'Unique identifier of the user who performed the audited action. Links to enterprise identity management system.',
    `user_role` STRING COMMENT 'Business role or job function of the user at the time the action was performed (e.g., Quality Assurance Manager, Manufacturing Operator, Clinical Data Manager).',
    `workflow_state` STRING COMMENT 'State of the business workflow at the time of the event (e.g., Draft, In Review, Approved, Released, Archived).',
    CONSTRAINT pk_audit_trail PRIMARY KEY(`audit_trail_id`)
) COMMENT 'Master reference table for audit_trail. Referenced by audit_trail_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ADD CONSTRAINT `fk_compliance_gxp_obligation_parent_gxp_obligation_id` FOREIGN KEY (`parent_gxp_obligation_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`gxp_obligation`(`gxp_obligation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ADD CONSTRAINT `fk_compliance_program_parent_program_id` FOREIGN KEY (`parent_program_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ADD CONSTRAINT `fk_compliance_internal_control_part11_system_id` FOREIGN KEY (`part11_system_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`part11_system`(`part11_system_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ADD CONSTRAINT `fk_compliance_internal_control_business_process_id` FOREIGN KEY (`business_process_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`business_process`(`business_process_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ADD CONSTRAINT `fk_compliance_internal_control_risk_register_id` FOREIGN KEY (`risk_register_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`risk_register`(`risk_register_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ADD CONSTRAINT `fk_compliance_internal_control_parent_internal_control_id` FOREIGN KEY (`parent_internal_control_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`internal_control`(`internal_control_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ADD CONSTRAINT `fk_compliance_control_assessment_internal_control_id` FOREIGN KEY (`internal_control_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`internal_control`(`internal_control_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ADD CONSTRAINT `fk_compliance_control_assessment_previous_control_assessment_id` FOREIGN KEY (`previous_control_assessment_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`control_assessment`(`control_assessment_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ADD CONSTRAINT `fk_compliance_inspection_readiness_program_id` FOREIGN KEY (`program_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ADD CONSTRAINT `fk_compliance_inspection_readiness_regulatory_inspection_id` FOREIGN KEY (`regulatory_inspection_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection`(`regulatory_inspection_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ADD CONSTRAINT `fk_compliance_inspection_readiness_parent_inspection_readiness_id` FOREIGN KEY (`parent_inspection_readiness_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`inspection_readiness`(`inspection_readiness_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ADD CONSTRAINT `fk_compliance_regulatory_inspection_followup_regulatory_inspection_id` FOREIGN KEY (`followup_regulatory_inspection_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection`(`regulatory_inspection_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ADD CONSTRAINT `fk_compliance_inspection_observation_gxp_obligation_id` FOREIGN KEY (`gxp_obligation_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`gxp_obligation`(`gxp_obligation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ADD CONSTRAINT `fk_compliance_inspection_observation_policy_document_id` FOREIGN KEY (`policy_document_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`policy_document`(`policy_document_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ADD CONSTRAINT `fk_compliance_inspection_observation_previous_observation_inspection_observation_id` FOREIGN KEY (`previous_observation_inspection_observation_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`inspection_observation`(`inspection_observation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ADD CONSTRAINT `fk_compliance_inspection_observation_regulatory_inspection_id` FOREIGN KEY (`regulatory_inspection_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection`(`regulatory_inspection_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ADD CONSTRAINT `fk_compliance_inspection_observation_parent_inspection_observation_id` FOREIGN KEY (`parent_inspection_observation_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`inspection_observation`(`inspection_observation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ADD CONSTRAINT `fk_compliance_inspection_response_compliance_capa_id` FOREIGN KEY (`compliance_capa_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`compliance_capa`(`compliance_capa_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ADD CONSTRAINT `fk_compliance_inspection_response_program_id` FOREIGN KEY (`program_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ADD CONSTRAINT `fk_compliance_inspection_response_regulatory_inspection_id` FOREIGN KEY (`regulatory_inspection_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection`(`regulatory_inspection_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ADD CONSTRAINT `fk_compliance_inspection_response_superseded_inspection_response_id` FOREIGN KEY (`superseded_inspection_response_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`inspection_response`(`inspection_response_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` ADD CONSTRAINT `fk_compliance_part11_system_predecessor_part11_system_id` FOREIGN KEY (`predecessor_part11_system_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`part11_system`(`part11_system_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ADD CONSTRAINT `fk_compliance_esignature_event_part11_system_id` FOREIGN KEY (`part11_system_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`part11_system`(`part11_system_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ADD CONSTRAINT `fk_compliance_esignature_event_predecessor_signature_event_esignature_event_id` FOREIGN KEY (`predecessor_signature_event_esignature_event_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`esignature_event`(`esignature_event_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ADD CONSTRAINT `fk_compliance_esignature_event_esignature_session_id` FOREIGN KEY (`esignature_session_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`esignature_session`(`esignature_session_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ADD CONSTRAINT `fk_compliance_esignature_event_workflow_step_id` FOREIGN KEY (`workflow_step_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`workflow_step`(`workflow_step_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ADD CONSTRAINT `fk_compliance_esignature_event_countersign_esignature_event_id` FOREIGN KEY (`countersign_esignature_event_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`esignature_event`(`esignature_event_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` ADD CONSTRAINT `fk_compliance_privacy_obligation_data_processing_activity_id` FOREIGN KEY (`data_processing_activity_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`data_processing_activity`(`data_processing_activity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` ADD CONSTRAINT `fk_compliance_privacy_obligation_parent_privacy_obligation_id` FOREIGN KEY (`parent_privacy_obligation_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`privacy_obligation`(`privacy_obligation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ADD CONSTRAINT `fk_compliance_privacy_impact_assessment_data_processing_activity_id` FOREIGN KEY (`data_processing_activity_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`data_processing_activity`(`data_processing_activity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ADD CONSTRAINT `fk_compliance_privacy_impact_assessment_privacy_obligation_id` FOREIGN KEY (`privacy_obligation_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`privacy_obligation`(`privacy_obligation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ADD CONSTRAINT `fk_compliance_privacy_impact_assessment_superseded_privacy_impact_assessment_id` FOREIGN KEY (`superseded_privacy_impact_assessment_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment`(`privacy_impact_assessment_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ADD CONSTRAINT `fk_compliance_incident_gxp_obligation_id` FOREIGN KEY (`gxp_obligation_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`gxp_obligation`(`gxp_obligation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ADD CONSTRAINT `fk_compliance_incident_program_id` FOREIGN KEY (`program_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ADD CONSTRAINT `fk_compliance_incident_related_incident_id` FOREIGN KEY (`related_incident_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ADD CONSTRAINT `fk_compliance_compliance_capa_gxp_obligation_id` FOREIGN KEY (`gxp_obligation_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`gxp_obligation`(`gxp_obligation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ADD CONSTRAINT `fk_compliance_compliance_capa_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ADD CONSTRAINT `fk_compliance_compliance_capa_program_id` FOREIGN KEY (`program_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ADD CONSTRAINT `fk_compliance_compliance_capa_sox_control_test_id` FOREIGN KEY (`sox_control_test_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`sox_control_test`(`sox_control_test_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ADD CONSTRAINT `fk_compliance_compliance_capa_triggering_event_id` FOREIGN KEY (`triggering_event_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`triggering_event`(`triggering_event_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ADD CONSTRAINT `fk_compliance_compliance_capa_originating_compliance_capa_id` FOREIGN KEY (`originating_compliance_capa_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`compliance_capa`(`compliance_capa_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ADD CONSTRAINT `fk_compliance_sox_control_test_internal_control_id` FOREIGN KEY (`internal_control_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`internal_control`(`internal_control_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ADD CONSTRAINT `fk_compliance_sox_control_test_previous_sox_control_test_id` FOREIGN KEY (`previous_sox_control_test_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`sox_control_test`(`sox_control_test_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ADD CONSTRAINT `fk_compliance_monitoring_activity_gxp_obligation_id` FOREIGN KEY (`gxp_obligation_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`gxp_obligation`(`gxp_obligation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ADD CONSTRAINT `fk_compliance_monitoring_activity_program_id` FOREIGN KEY (`program_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ADD CONSTRAINT `fk_compliance_monitoring_activity_followup_monitoring_activity_id` FOREIGN KEY (`followup_monitoring_activity_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`monitoring_activity`(`monitoring_activity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ADD CONSTRAINT `fk_compliance_risk_register_program_id` FOREIGN KEY (`program_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ADD CONSTRAINT `fk_compliance_risk_register_parent_risk_register_id` FOREIGN KEY (`parent_risk_register_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`risk_register`(`risk_register_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ADD CONSTRAINT `fk_compliance_policy_document_superseded_policy_document_id` FOREIGN KEY (`superseded_policy_document_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`policy_document`(`policy_document_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ADD CONSTRAINT `fk_compliance_disclosure_conflict_of_interest_id` FOREIGN KEY (`conflict_of_interest_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest`(`conflict_of_interest_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ADD CONSTRAINT `fk_compliance_disclosure_original_disclosure_id` FOREIGN KEY (`original_disclosure_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`disclosure`(`disclosure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ADD CONSTRAINT `fk_compliance_disclosure_program_id` FOREIGN KEY (`program_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ADD CONSTRAINT `fk_compliance_disclosure_amended_disclosure_id` FOREIGN KEY (`amended_disclosure_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`disclosure`(`disclosure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ADD CONSTRAINT `fk_compliance_conflict_of_interest_program_id` FOREIGN KEY (`program_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ADD CONSTRAINT `fk_compliance_conflict_of_interest_prior_conflict_of_interest_id` FOREIGN KEY (`prior_conflict_of_interest_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest`(`conflict_of_interest_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ADD CONSTRAINT `fk_compliance_third_party_due_diligence_program_id` FOREIGN KEY (`program_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ADD CONSTRAINT `fk_compliance_third_party_due_diligence_prior_third_party_due_diligence_id` FOREIGN KEY (`prior_third_party_due_diligence_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence`(`third_party_due_diligence_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ADD CONSTRAINT `fk_compliance_debarment_check_program_id` FOREIGN KEY (`program_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ADD CONSTRAINT `fk_compliance_debarment_check_third_party_due_diligence_id` FOREIGN KEY (`third_party_due_diligence_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence`(`third_party_due_diligence_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ADD CONSTRAINT `fk_compliance_debarment_check_prior_debarment_check_id` FOREIGN KEY (`prior_debarment_check_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`debarment_check`(`debarment_check_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ADD CONSTRAINT `fk_compliance_attestation_policy_document_id` FOREIGN KEY (`policy_document_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`policy_document`(`policy_document_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ADD CONSTRAINT `fk_compliance_attestation_program_id` FOREIGN KEY (`program_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ADD CONSTRAINT `fk_compliance_attestation_prior_attestation_id` FOREIGN KEY (`prior_attestation_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`attestation`(`attestation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ADD CONSTRAINT `fk_compliance_warning_letter_gxp_obligation_id` FOREIGN KEY (`gxp_obligation_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`gxp_obligation`(`gxp_obligation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ADD CONSTRAINT `fk_compliance_warning_letter_program_id` FOREIGN KEY (`program_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ADD CONSTRAINT `fk_compliance_warning_letter_regulatory_inspection_id` FOREIGN KEY (`regulatory_inspection_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection`(`regulatory_inspection_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ADD CONSTRAINT `fk_compliance_warning_letter_policy_document_id` FOREIGN KEY (`policy_document_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`policy_document`(`policy_document_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ADD CONSTRAINT `fk_compliance_warning_letter_followup_warning_letter_id` FOREIGN KEY (`followup_warning_letter_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`warning_letter`(`warning_letter_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program_obligation_scope` ADD CONSTRAINT `fk_compliance_program_obligation_scope_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program_obligation_scope` ADD CONSTRAINT `fk_compliance_program_obligation_scope_gxp_obligation_id` FOREIGN KEY (`gxp_obligation_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`gxp_obligation`(`gxp_obligation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program_obligation_scope` ADD CONSTRAINT `fk_compliance_program_obligation_scope_program_id` FOREIGN KEY (`program_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`fmv_assessment` ADD CONSTRAINT `fk_compliance_fmv_assessment_superseded_fmv_assessment_id` FOREIGN KEY (`superseded_fmv_assessment_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`fmv_assessment`(`fmv_assessment_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`triggering_event` ADD CONSTRAINT `fk_compliance_triggering_event_notification_template_id` FOREIGN KEY (`notification_template_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`notification_template`(`notification_template_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`triggering_event` ADD CONSTRAINT `fk_compliance_triggering_event_workflow_template_id` FOREIGN KEY (`workflow_template_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`workflow_template`(`workflow_template_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`triggering_event` ADD CONSTRAINT `fk_compliance_triggering_event_preceding_triggering_event_id` FOREIGN KEY (`preceding_triggering_event_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`triggering_event`(`triggering_event_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_session` ADD CONSTRAINT `fk_compliance_esignature_session_audit_trail_id` FOREIGN KEY (`audit_trail_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`audit_trail`(`audit_trail_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_session` ADD CONSTRAINT `fk_compliance_esignature_session_policy_document_id` FOREIGN KEY (`policy_document_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`policy_document`(`policy_document_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_session` ADD CONSTRAINT `fk_compliance_esignature_session_workflow_step_id` FOREIGN KEY (`workflow_step_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`workflow_step`(`workflow_step_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_session` ADD CONSTRAINT `fk_compliance_esignature_session_parent_esignature_session_id` FOREIGN KEY (`parent_esignature_session_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`esignature_session`(`esignature_session_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`workflow_step` ADD CONSTRAINT `fk_compliance_workflow_step_document_template_id` FOREIGN KEY (`document_template_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`document_template`(`document_template_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`workflow_step` ADD CONSTRAINT `fk_compliance_workflow_step_preceding_workflow_step_id` FOREIGN KEY (`preceding_workflow_step_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`workflow_step`(`workflow_step_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`business_process` ADD CONSTRAINT `fk_compliance_business_process_parent_business_process_id` FOREIGN KEY (`parent_business_process_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`business_process`(`business_process_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`data_processing_activity` ADD CONSTRAINT `fk_compliance_data_processing_activity_internal_control_id` FOREIGN KEY (`internal_control_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`internal_control`(`internal_control_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`data_processing_activity` ADD CONSTRAINT `fk_compliance_data_processing_activity_parent_data_processing_activity_id` FOREIGN KEY (`parent_data_processing_activity_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`data_processing_activity`(`data_processing_activity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`document_template` ADD CONSTRAINT `fk_compliance_document_template_superseded_document_template_id` FOREIGN KEY (`superseded_document_template_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`document_template`(`document_template_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`notification_template` ADD CONSTRAINT `fk_compliance_notification_template_superseded_notification_template_id` FOREIGN KEY (`superseded_notification_template_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`notification_template`(`notification_template_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`workflow_template` ADD CONSTRAINT `fk_compliance_workflow_template_superseded_workflow_template_id` FOREIGN KEY (`superseded_workflow_template_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`workflow_template`(`workflow_template_id`);

-- ========= TAGS =========
ALTER SCHEMA `pharmaceuticals_ecm`.`compliance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `pharmaceuticals_ecm`.`compliance` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` SET TAGS ('dbx_subdomain' = 'regulatory_obligations');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ALTER COLUMN `gxp_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Obligation Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ALTER COLUMN `parent_gxp_obligation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ALTER COLUMN `applicable_functions` SET TAGS ('dbx_business_glossary_term' = 'Applicable Functions');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ALTER COLUMN `applicable_products` SET TAGS ('dbx_business_glossary_term' = 'Applicable Products');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ALTER COLUMN `applicable_scope` SET TAGS ('dbx_business_glossary_term' = 'Applicable Scope');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ALTER COLUMN `applicable_scope` SET TAGS ('dbx_value_regex' = 'Enterprise-wide|Site-specific|Function-specific|Product-specific|Process-specific');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ALTER COLUMN `applicable_sites` SET TAGS ('dbx_business_glossary_term' = 'Applicable Sites');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ALTER COLUMN `audit_trail_required` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ALTER COLUMN `capa_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ALTER COLUMN `change_control_required` SET TAGS ('dbx_business_glossary_term' = 'Change Control Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'Compliant|Non-Compliant|Partially Compliant|Not Assessed|Remediation in Progress');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ALTER COLUMN `data_integrity_requirement` SET TAGS ('dbx_business_glossary_term' = 'Data Integrity Requirement Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ALTER COLUMN `documentation_retention_years` SET TAGS ('dbx_business_glossary_term' = 'Documentation Retention Period (Years)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ALTER COLUMN `electronic_records_requirement` SET TAGS ('dbx_business_glossary_term' = 'Electronic Records Requirement Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ALTER COLUMN `gdpr_applicability` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Applicability Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ALTER COLUMN `gxp_category` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Category');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ALTER COLUMN `gxp_category` SET TAGS ('dbx_value_regex' = 'GMP|GCP|GLP|GDP|GPvP|GDocP');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ALTER COLUMN `hipaa_applicability` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Portability and Accountability Act (HIPAA) Applicability Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ALTER COLUMN `inspection_readiness_flag` SET TAGS ('dbx_business_glossary_term' = 'Inspection Readiness Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ALTER COLUMN `last_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Assessment Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ALTER COLUMN `next_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Next Assessment Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_business_glossary_term' = 'Obligation Reference Code');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ALTER COLUMN `obligation_description` SET TAGS ('dbx_business_glossary_term' = 'Obligation Description');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ALTER COLUMN `obligation_owner` SET TAGS ('dbx_business_glossary_term' = 'Obligation Owner');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ALTER COLUMN `obligation_status` SET TAGS ('dbx_business_glossary_term' = 'Obligation Status');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ALTER COLUMN `obligation_status` SET TAGS ('dbx_value_regex' = 'Active|Superseded|Retired|Under Review|Pending Implementation');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ALTER COLUMN `obligation_title` SET TAGS ('dbx_business_glossary_term' = 'Obligation Title');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ALTER COLUMN `regulation_source` SET TAGS ('dbx_business_glossary_term' = 'Regulation Source');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ALTER COLUMN `regulation_type` SET TAGS ('dbx_business_glossary_term' = 'Regulation Type');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ALTER COLUMN `regulation_type` SET TAGS ('dbx_value_regex' = 'Federal Regulation|Directive|Guideline|Standard|Policy');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ALTER COLUMN `related_policy_references` SET TAGS ('dbx_business_glossary_term' = 'Related Policy References');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ALTER COLUMN `related_sop_references` SET TAGS ('dbx_business_glossary_term' = 'Related Standard Operating Procedure (SOP) References');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'Critical|High|Medium|Low');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ALTER COLUMN `training_required` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ALTER COLUMN `validation_requirement` SET TAGS ('dbx_business_glossary_term' = 'Validation Requirement Type');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ALTER COLUMN `validation_requirement` SET TAGS ('dbx_value_regex' = 'Process Validation|Computer System Validation|Cleaning Validation|Analytical Method Validation|Not Applicable');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` SET TAGS ('dbx_subdomain' = 'regulatory_obligations');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ALTER COLUMN `program_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Program Owner Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ALTER COLUMN `program_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ALTER COLUMN `program_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ALTER COLUMN `parent_program_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ALTER COLUMN `alcoa_plus_compliant` SET TAGS ('dbx_business_glossary_term' = 'ALCOA Plus (ALCOA+) Compliant Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ALTER COLUMN `applicable_jurisdictions` SET TAGS ('dbx_business_glossary_term' = 'Applicable Jurisdictions');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ALTER COLUMN `capa_integration` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Integration Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'Not Certified|In Progress|Certified|Expired|Suspended');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ALTER COLUMN `charter_document` SET TAGS ('dbx_business_glossary_term' = 'Program Charter Document Reference');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ALTER COLUMN `csv_required` SET TAGS ('dbx_business_glossary_term' = 'Computer System Validation (CSV) Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ALTER COLUMN `escalation_procedure` SET TAGS ('dbx_business_glossary_term' = 'Escalation Procedure');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ALTER COLUMN `external_audit_firm` SET TAGS ('dbx_business_glossary_term' = 'External Audit Firm');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ALTER COLUMN `external_audit_firm` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ALTER COLUMN `governance_committee` SET TAGS ('dbx_business_glossary_term' = 'Governance Committee');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ALTER COLUMN `inspection_readiness_level` SET TAGS ('dbx_business_glossary_term' = 'Inspection Readiness Level');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ALTER COLUMN `inspection_readiness_level` SET TAGS ('dbx_value_regex' = 'Not Ready|Partially Ready|Inspection Ready|Audit Verified');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ALTER COLUMN `key_performance_indicators` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicators (KPIs)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ALTER COLUMN `program_description` SET TAGS ('dbx_business_glossary_term' = 'Program Description');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ALTER COLUMN `program_scope` SET TAGS ('dbx_business_glossary_term' = 'Program Scope');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'Draft|Active|Under Review|Suspended|Retired|Remediation');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ALTER COLUMN `reporting_cadence` SET TAGS ('dbx_business_glossary_term' = 'Reporting Cadence');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ALTER COLUMN `risk_tier` SET TAGS ('dbx_value_regex' = 'Critical|High|Medium|Low');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ALTER COLUMN `sop_count` SET TAGS ('dbx_business_glossary_term' = 'Standard Operating Procedure (SOP) Count');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ALTER COLUMN `training_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Training Frequency in Months');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ALTER COLUMN `training_required` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` SET TAGS ('dbx_subdomain' = 'regulatory_obligations');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `internal_control_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Control Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `part11_system_id` SET TAGS ('dbx_business_glossary_term' = 'System Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `business_process_id` SET TAGS ('dbx_business_glossary_term' = 'Business Process Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `risk_register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `parent_internal_control_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `automation_level` SET TAGS ('dbx_business_glossary_term' = 'Automation Level');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `automation_level` SET TAGS ('dbx_value_regex' = 'fully_automated|semi_automated|manual');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `cfr_part_11_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Code of Federal Regulations (CFR) Part 11 Applicable Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `compensating_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Compensating Control Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `control_activity` SET TAGS ('dbx_business_glossary_term' = 'Control Activity');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `control_category` SET TAGS ('dbx_business_glossary_term' = 'Control Category');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `control_category` SET TAGS ('dbx_value_regex' = 'itgc|business_process_control|entity_level_control|application_control|manual_control|automated_control');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `control_description` SET TAGS ('dbx_business_glossary_term' = 'Control Description');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `control_effectiveness_rating` SET TAGS ('dbx_business_glossary_term' = 'Control Effectiveness Rating');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `control_effectiveness_rating` SET TAGS ('dbx_value_regex' = 'effective|needs_improvement|ineffective|not_tested');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `control_evidence` SET TAGS ('dbx_business_glossary_term' = 'Control Evidence');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `control_frequency` SET TAGS ('dbx_business_glossary_term' = 'Control Frequency');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `control_name` SET TAGS ('dbx_business_glossary_term' = 'Control Name');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `control_number` SET TAGS ('dbx_business_glossary_term' = 'Control Number');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `control_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[A-Z]{2,4}-[0-9]{4,6}$');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `control_objective` SET TAGS ('dbx_business_glossary_term' = 'Control Objective');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `control_owner` SET TAGS ('dbx_business_glossary_term' = 'Control Owner');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `control_owner_email` SET TAGS ('dbx_business_glossary_term' = 'Control Owner Email Address');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `control_owner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `control_owner_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `control_status` SET TAGS ('dbx_business_glossary_term' = 'Control Status');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `control_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_review|remediation_in_progress|retired');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `control_type` SET TAGS ('dbx_business_glossary_term' = 'Control Type');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `control_type` SET TAGS ('dbx_value_regex' = 'preventive|detective|corrective');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `data_integrity_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Integrity Control Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `deficiency_count` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Count');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `gdpr_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Applicable Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `gxp_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Applicable Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `gxp_regulation` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Regulation');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `hipaa_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Portability and Accountability Act (HIPAA) Applicable Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `key_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Key Control Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `last_test_date` SET TAGS ('dbx_business_glossary_term' = 'Last Test Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `material_weakness_flag` SET TAGS ('dbx_business_glossary_term' = 'Material Weakness Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `next_test_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Test Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `significant_deficiency_flag` SET TAGS ('dbx_business_glossary_term' = 'Significant Deficiency Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `sox_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Applicable Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `sox_section` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Section');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `sox_section` SET TAGS ('dbx_value_regex' = 'section_302|section_404|both|not_applicable');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `testing_method` SET TAGS ('dbx_business_glossary_term' = 'Testing Method');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `testing_method` SET TAGS ('dbx_value_regex' = 'inquiry|observation|inspection|reperformance|walkthrough|data_analytics');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` SET TAGS ('dbx_subdomain' = 'regulatory_obligations');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ALTER COLUMN `control_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Control Assessment Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ALTER COLUMN `internal_control_id` SET TAGS ('dbx_business_glossary_term' = 'Control Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assessor Employee Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ALTER COLUMN `quality_capa_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Employee Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ALTER COLUMN `previous_control_assessment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ALTER COLUMN `assessment_execution_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Execution Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ALTER COLUMN `assessment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Notes');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_business_glossary_term' = 'Control Assessment Number');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_value_regex' = '^CA-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ALTER COLUMN `assessment_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Period End Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ALTER COLUMN `assessment_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Period Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|testing_complete|under_review|approved|remediation_required');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'sox_control_testing|gxp_compliance_assessment|itgc_evaluation|process_walkthrough|data_integrity_review|vendor_audit');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ALTER COLUMN `control_effectiveness_rating` SET TAGS ('dbx_business_glossary_term' = 'Control Effectiveness Rating');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ALTER COLUMN `control_effectiveness_rating` SET TAGS ('dbx_value_regex' = 'highly_effective|effective|needs_improvement|ineffective');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ALTER COLUMN `data_integrity_alcoa_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Integrity ALCOA+ Compliance Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ALTER COLUMN `deficiency_classification` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Classification');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ALTER COLUMN `deficiency_classification` SET TAGS ('dbx_value_regex' = 'no_deficiency|control_deficiency|significant_deficiency|material_weakness');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ALTER COLUMN `deficiency_description` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Description');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ALTER COLUMN `evidence_location` SET TAGS ('dbx_business_glossary_term' = 'Evidence Location');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ALTER COLUMN `exceptions_identified_count` SET TAGS ('dbx_business_glossary_term' = 'Exceptions Identified Count');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ALTER COLUMN `external_auditor_reliance_flag` SET TAGS ('dbx_business_glossary_term' = 'External Auditor Reliance Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ALTER COLUMN `population_size` SET TAGS ('dbx_business_glossary_term' = 'Population Size');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ALTER COLUMN `regulatory_inspection_readiness_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection Readiness Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ALTER COLUMN `remediation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ALTER COLUMN `remediation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Remediation Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'not_required|planned|in_progress|completed|verified|overdue');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ALTER COLUMN `sox_scoping_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Scoping Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ALTER COLUMN `test_result` SET TAGS ('dbx_business_glossary_term' = 'Test Result');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ALTER COLUMN `test_result` SET TAGS ('dbx_value_regex' = 'effective|ineffective|not_tested|not_applicable');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ALTER COLUMN `testing_approach` SET TAGS ('dbx_business_glossary_term' = 'Testing Approach');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` SET TAGS ('dbx_subdomain' = 'authority_inspections');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `inspection_readiness_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Readiness ID');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Application Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `designation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Designation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `primary_inspection_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Readiness Coordinator ID');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `primary_inspection_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `primary_inspection_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `regulatory_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site ID');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `parent_inspection_readiness_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `critical_gaps_identified_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Gaps Identified Count');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `csv_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Computer System Validation (CSV) Compliance Status');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `csv_compliance_status` SET TAGS ('dbx_value_regex' = 'Compliant|Non-Compliant|Partially Compliant|Under Review');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `data_integrity_assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Data Integrity Assessment Status');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `data_integrity_assessment_status` SET TAGS ('dbx_value_regex' = 'Not Started|In Progress|Completed|Passed|Failed');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `document_review_completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Document Review Completion Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `gaps_remediated_count` SET TAGS ('dbx_business_glossary_term' = 'Gaps Remediated Count');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `gxp_category` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Category');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `gxp_category` SET TAGS ('dbx_value_regex' = 'GMP|GLP|GCP|GDP|GVP');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `inspection_announcement_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Announcement Type');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `inspection_announcement_type` SET TAGS ('dbx_value_regex' = 'Announced|Unannounced|For Cause');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `inspection_notification_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notification Received Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `inspection_scope` SET TAGS ('dbx_business_glossary_term' = 'Inspection Scope');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `inspection_type` SET TAGS ('dbx_value_regex' = 'FDA PAI|FDA Surveillance|EMA GMP|MHRA Inspection|WHO PQ|PMDA Inspection');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `major_gaps_identified_count` SET TAGS ('dbx_business_glossary_term' = 'Major Gaps Identified Count');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `minor_gaps_identified_count` SET TAGS ('dbx_business_glossary_term' = 'Minor Gaps Identified Count');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `mock_inspection_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Mock Inspection Completed Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `mock_inspection_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Mock Inspection Scheduled Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Program Notes');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `notification_received_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Received Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `open_capa_count` SET TAGS ('dbx_business_glossary_term' = 'Open Corrective and Preventive Action (CAPA) Count');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `program_end_date` SET TAGS ('dbx_business_glossary_term' = 'Program End Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `program_start_date` SET TAGS ('dbx_business_glossary_term' = 'Program Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `readiness_determination` SET TAGS ('dbx_business_glossary_term' = 'Readiness Determination');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `readiness_determination` SET TAGS ('dbx_value_regex' = 'Ready|Conditionally Ready|Not Ready|Pending Assessment');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `readiness_score` SET TAGS ('dbx_business_glossary_term' = 'Readiness Score');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `risk_assessment_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Completed Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `target_inspection_end_date` SET TAGS ('dbx_business_glossary_term' = 'Target Inspection End Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `target_inspection_start_date` SET TAGS ('dbx_business_glossary_term' = 'Target Inspection Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ALTER COLUMN `training_completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` SET TAGS ('dbx_subdomain' = 'authority_inspections');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ALTER COLUMN `regulatory_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ALTER COLUMN `dmf_id` SET TAGS ('dbx_business_glossary_term' = 'Dmf Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ALTER COLUMN `trial_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Trial Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ALTER COLUMN `followup_regulatory_inspection_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ALTER COLUMN `authority_country_code` SET TAGS ('dbx_business_glossary_term' = 'Authority Country Code');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ALTER COLUMN `authority_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ALTER COLUMN `capa_completion_target_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Completion Target Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ALTER COLUMN `capa_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Required');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ALTER COLUMN `critical_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Findings Count');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ALTER COLUMN `follow_up_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Inspection Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ALTER COLUMN `follow_up_inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Inspection Required');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ALTER COLUMN `form_483_issued` SET TAGS ('dbx_business_glossary_term' = 'Form 483 (FDA) Issued');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspecting_authority` SET TAGS ('dbx_business_glossary_term' = 'Inspecting Authority');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspection_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Inspection Duration (Days)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspection_notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspection_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Number');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspection_outcome` SET TAGS ('dbx_business_glossary_term' = 'Inspection Outcome');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspection_outcome` SET TAGS ('dbx_value_regex' = 'NAI|VAI|OAI|warning_letter|consent_decree|pending');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspection_report_received_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Report Received Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspection_report_url` SET TAGS ('dbx_business_glossary_term' = 'Inspection Report Uniform Resource Locator (URL)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspection_report_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspection_scope` SET TAGS ('dbx_business_glossary_term' = 'Inspection Scope');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|follow_up_required');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_value_regex' = 'GMP|GCP|GLP|GDP|pharmacovigilance|pre-approval');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ALTER COLUMN `is_announced` SET TAGS ('dbx_business_glossary_term' = 'Is Announced Inspection');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ALTER COLUMN `lead_inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Lead Inspector Name');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ALTER COLUMN `lead_inspector_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ALTER COLUMN `major_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Major Findings Count');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ALTER COLUMN `minor_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Minor Findings Count');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ALTER COLUMN `number_of_observations` SET TAGS ('dbx_business_glossary_term' = 'Number of Observations');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ALTER COLUMN `response_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Response Submitted Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ALTER COLUMN `site_type` SET TAGS ('dbx_business_glossary_term' = 'Site Type');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` SET TAGS ('dbx_subdomain' = 'authority_inspections');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `inspection_observation_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Observation Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Response Owner Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `gxp_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Gxp Obligation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `health_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Health Authority Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `health_authority_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `health_authority_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `policy_document_id` SET TAGS ('dbx_business_glossary_term' = 'Response Document Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `previous_observation_inspection_observation_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Observation Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `quality_capa_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `regulatory_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `root_cause_analysis_id` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis (RCA) Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `parent_inspection_observation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `cfr_citation` SET TAGS ('dbx_business_glossary_term' = 'Code of Federal Regulations (CFR) Citation');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Observation Closure Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `closure_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Closure Verification Method');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `closure_verification_method` SET TAGS ('dbx_value_regex' = 'document_review|follow_up_inspection|self_verification|health_authority_acceptance');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `corrective_action_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `escalation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `gmp_citation` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Citation');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `impact_assessment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `inspector_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `internal_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `observation_category` SET TAGS ('dbx_business_glossary_term' = 'Observation Category');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `observation_classification` SET TAGS ('dbx_business_glossary_term' = 'Observation Classification');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `observation_classification` SET TAGS ('dbx_value_regex' = 'critical|major|minor|informational|other');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `observation_date` SET TAGS ('dbx_business_glossary_term' = 'Observation Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `observation_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Observation Reference Number');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `observation_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]+$');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `observation_status` SET TAGS ('dbx_business_glossary_term' = 'Observation Status');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `observation_status` SET TAGS ('dbx_value_regex' = 'open|response_in_progress|response_submitted|under_review|closed|escalated');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `observation_text` SET TAGS ('dbx_business_glossary_term' = 'Observation Text');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `observation_text` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `proposed_corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Proposed Corrective Action');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `proposed_corrective_action` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `regulatory_action_risk` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Action Risk');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `regulatory_action_risk` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `repeat_observation_flag` SET TAGS ('dbx_business_glossary_term' = 'Repeat Observation Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `response_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Response Owner Name');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `response_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Response Submission Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `risk_assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Score');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` SET TAGS ('dbx_subdomain' = 'authority_inspections');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `inspection_response_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Response Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `compliance_capa_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Plan Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `health_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Health Authority Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `health_authority_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `health_authority_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Response Author Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `quaternary_inspection_legal_reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Reviewer Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `quaternary_inspection_legal_reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `quaternary_inspection_legal_reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `quinary_inspection_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `quinary_inspection_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `quinary_inspection_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `regulatory_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `tertiary_inspection_quality_head_approver_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Head Approver Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `tertiary_inspection_quality_head_approver_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `tertiary_inspection_quality_head_approver_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `superseded_inspection_response_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `commitment_summary` SET TAGS ('dbx_business_glossary_term' = 'Commitment Summary');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `consent_decree_related_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Decree Related Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `executive_notification_flag` SET TAGS ('dbx_business_glossary_term' = 'Executive Notification Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `health_authority_acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Health Authority Acceptance Status');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `health_authority_acceptance_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `health_authority_acceptance_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `health_authority_acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Health Authority Acknowledgment Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `health_authority_acknowledgment_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `health_authority_acknowledgment_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `health_authority_feedback` SET TAGS ('dbx_business_glossary_term' = 'Health Authority Feedback');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `health_authority_feedback` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `health_authority_feedback` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `impacted_product_list` SET TAGS ('dbx_business_glossary_term' = 'Impacted Product List');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `legal_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `observation_count` SET TAGS ('dbx_business_glossary_term' = 'Observation Count');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `product_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Product Impact Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `reinspection_date` SET TAGS ('dbx_business_glossary_term' = 'Reinspection Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `reinspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Reinspection Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `response_document_number` SET TAGS ('dbx_business_glossary_term' = 'Response Document Number');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `response_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `response_document_url` SET TAGS ('dbx_business_glossary_term' = 'Response Document Uniform Resource Locator (URL)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `response_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `response_document_version` SET TAGS ('dbx_business_glossary_term' = 'Response Document Version');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `response_document_version` SET TAGS ('dbx_value_regex' = '^vd+.d+$');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `response_language` SET TAGS ('dbx_business_glossary_term' = 'Response Language');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `response_language` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `response_status` SET TAGS ('dbx_business_glossary_term' = 'Response Status');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `response_type` SET TAGS ('dbx_business_glossary_term' = 'Response Type');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `response_type` SET TAGS ('dbx_value_regex' = 'form_483_response|warning_letter_response|untitled_letter_response|establishment_inspection_report_response|voluntary_action_indicated_response|official_action_indicated_response');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'electronic_submission|postal_mail|courier|hand_delivery|regulatory_portal');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` SET TAGS ('dbx_subdomain' = 'electronic_records');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` ALTER COLUMN `part11_system_id` SET TAGS ('dbx_business_glossary_term' = '21 CFR (Code of Federal Regulations) Part 11 System ID');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` ALTER COLUMN `predecessor_part11_system_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` ALTER COLUMN `access_control_implemented` SET TAGS ('dbx_business_glossary_term' = 'Access Control Implemented');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` ALTER COLUMN `access_control_method` SET TAGS ('dbx_business_glossary_term' = 'Access Control Method');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` ALTER COLUMN `access_control_method` SET TAGS ('dbx_value_regex' = 'role_based|attribute_based|mandatory|discretionary');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` ALTER COLUMN `annex11_applicable` SET TAGS ('dbx_business_glossary_term' = 'EU (European Union) Annex 11 Applicable');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` ALTER COLUMN `audit_trail_enabled` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Enabled');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` ALTER COLUMN `audit_trail_review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Review Frequency');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` ALTER COLUMN `audit_trail_review_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|event_driven');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` ALTER COLUMN `backup_recovery_validated` SET TAGS ('dbx_business_glossary_term' = 'Backup and Recovery Validated');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` ALTER COLUMN `change_control_required` SET TAGS ('dbx_business_glossary_term' = 'Change Control Required');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` ALTER COLUMN `data_integrity_controls` SET TAGS ('dbx_business_glossary_term' = 'Data Integrity Controls (ALCOA+)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` ALTER COLUMN `data_integrity_controls` SET TAGS ('dbx_value_regex' = 'alcoa_plus_compliant|partial|not_implemented');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` ALTER COLUMN `data_residency_location` SET TAGS ('dbx_business_glossary_term' = 'Data Residency Location');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'System Decommission Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` ALTER COLUMN `deployment_environment` SET TAGS ('dbx_business_glossary_term' = 'Deployment Environment');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` ALTER COLUMN `deployment_environment` SET TAGS ('dbx_value_regex' = 'on_premise|cloud|hybrid|saas');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` ALTER COLUMN `electronic_signature_enabled` SET TAGS ('dbx_business_glossary_term' = 'Electronic Signature Enabled');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` ALTER COLUMN `electronic_signature_type` SET TAGS ('dbx_business_glossary_term' = 'Electronic Signature Type');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` ALTER COLUMN `electronic_signature_type` SET TAGS ('dbx_value_regex' = 'username_password|biometric|token_based|digital_certificate|hybrid');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` ALTER COLUMN `gdpr_applicable` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Applicable');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` ALTER COLUMN `go_live_date` SET TAGS ('dbx_business_glossary_term' = 'System Go-Live Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` ALTER COLUMN `gxp_criticality` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Criticality Classification');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` ALTER COLUMN `gxp_criticality` SET TAGS ('dbx_value_regex' = 'gxp_critical|gxp_non_critical|non_gxp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` ALTER COLUMN `hipaa_applicable` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Portability and Accountability Act (HIPAA) Applicable');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` ALTER COLUMN `inspection_findings` SET TAGS ('dbx_business_glossary_term' = 'Inspection Findings Classification');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` ALTER COLUMN `inspection_findings` SET TAGS ('dbx_value_regex' = 'no_findings|observations|warning_letter|form_483|critical');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` ALTER COLUMN `inspection_findings` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Regulatory Inspection Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` ALTER COLUMN `modified_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` ALTER COLUMN `part11_applicable` SET TAGS ('dbx_business_glossary_term' = '21 CFR (Code of Federal Regulations) Part 11 Applicable');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` ALTER COLUMN `part11_system_description` SET TAGS ('dbx_business_glossary_term' = 'System Description');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` ALTER COLUMN `record_retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Record Retention Period (Years)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` ALTER COLUMN `revalidation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Revalidation Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` ALTER COLUMN `sox_controls_applicable` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Controls Applicable');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` ALTER COLUMN `system_category` SET TAGS ('dbx_business_glossary_term' = 'System Category');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` ALTER COLUMN `system_code` SET TAGS ('dbx_business_glossary_term' = 'System Code');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` ALTER COLUMN `system_name` SET TAGS ('dbx_business_glossary_term' = 'System Name');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` ALTER COLUMN `system_owner` SET TAGS ('dbx_business_glossary_term' = 'System Owner');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` ALTER COLUMN `system_owner` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` ALTER COLUMN `system_status` SET TAGS ('dbx_business_glossary_term' = 'System Operational Status');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` ALTER COLUMN `system_status` SET TAGS ('dbx_value_regex' = 'active|inactive|decommissioned|under_validation|suspended');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` ALTER COLUMN `system_version` SET TAGS ('dbx_business_glossary_term' = 'System Version');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` ALTER COLUMN `validation_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Computer System Validation (CSV) Status');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'not_validated|validation_in_progress|validated|revalidation_required|retired');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`part11_system` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` SET TAGS ('dbx_subdomain' = 'electronic_records');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ALTER COLUMN `esignature_event_id` SET TAGS ('dbx_business_glossary_term' = 'Electronic Signature (E-Signature) Event ID');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ALTER COLUMN `part11_system_id` SET TAGS ('dbx_business_glossary_term' = 'System ID');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ALTER COLUMN `predecessor_signature_event_esignature_event_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Signature Event ID');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Signer User ID');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ALTER COLUMN `esignature_session_id` SET TAGS ('dbx_business_glossary_term' = 'Session ID');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ALTER COLUMN `workflow_step_id` SET TAGS ('dbx_business_glossary_term' = 'Workflow Step ID');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ALTER COLUMN `countersign_esignature_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ALTER COLUMN `authentication_method` SET TAGS ('dbx_business_glossary_term' = 'Authentication Method');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ALTER COLUMN `authentication_method` SET TAGS ('dbx_value_regex' = 'username_password|biometric|token|smart_card|multi_factor|single_sign_on');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ALTER COLUMN `authentication_result` SET TAGS ('dbx_business_glossary_term' = 'Authentication Result');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ALTER COLUMN `authentication_result` SET TAGS ('dbx_value_regex' = 'success|failure|locked|expired');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ALTER COLUMN `biometric_data_hash` SET TAGS ('dbx_business_glossary_term' = 'Biometric Data Hash');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ALTER COLUMN `biometric_data_hash` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ALTER COLUMN `biometric_data_hash` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ALTER COLUMN `compliance_validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Compliance Validation Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ALTER COLUMN `delegation_flag` SET TAGS ('dbx_business_glossary_term' = 'Delegation Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ALTER COLUMN `device_identifier` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ALTER COLUMN `device_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ALTER COLUMN `device_identifier` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ALTER COLUMN `non_repudiation_token` SET TAGS ('dbx_business_glossary_term' = 'Non-Repudiation Token');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ALTER COLUMN `non_repudiation_token` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ALTER COLUMN `record_reference` SET TAGS ('dbx_business_glossary_term' = 'Record ID');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ALTER COLUMN `record_type` SET TAGS ('dbx_business_glossary_term' = 'Record Type');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ALTER COLUMN `record_version_number` SET TAGS ('dbx_business_glossary_term' = 'Record Version Number');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ALTER COLUMN `signature_image_path` SET TAGS ('dbx_business_glossary_term' = 'Signature Image Path');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ALTER COLUMN `signature_image_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ALTER COLUMN `signature_meaning` SET TAGS ('dbx_business_glossary_term' = 'Signature Meaning');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ALTER COLUMN `signature_reason` SET TAGS ('dbx_business_glossary_term' = 'Signature Reason');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ALTER COLUMN `signature_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Signature Sequence Number');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ALTER COLUMN `signature_status` SET TAGS ('dbx_business_glossary_term' = 'Signature Status');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ALTER COLUMN `signature_status` SET TAGS ('dbx_value_regex' = 'completed|pending|failed|revoked|superseded');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ALTER COLUMN `signature_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Signature Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ALTER COLUMN `signer_full_name` SET TAGS ('dbx_business_glossary_term' = 'Signer Full Name');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ALTER COLUMN `signer_full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ALTER COLUMN `signer_full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ALTER COLUMN `signer_role` SET TAGS ('dbx_business_glossary_term' = 'Signer Role');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ALTER COLUMN `signer_username` SET TAGS ('dbx_business_glossary_term' = 'Signer Username');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ALTER COLUMN `signer_username` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ALTER COLUMN `signer_username` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ALTER COLUMN `source_system_name` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ALTER COLUMN `workflow_step_name` SET TAGS ('dbx_business_glossary_term' = 'Workflow Step Name');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` SET TAGS ('dbx_subdomain' = 'privacy_protection');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` ALTER COLUMN `privacy_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Obligation Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` ALTER COLUMN `data_processing_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Data Processing Activity Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` ALTER COLUMN `primary_privacy_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Owner Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` ALTER COLUMN `primary_privacy_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` ALTER COLUMN `primary_privacy_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` ALTER COLUMN `parent_privacy_obligation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` ALTER COLUMN `applicable_data_category` SET TAGS ('dbx_business_glossary_term' = 'Applicable Data Category');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|in_progress|not_applicable|under_review');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` ALTER COLUMN `control_procedure_reference` SET TAGS ('dbx_business_glossary_term' = 'Control Procedure Reference');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` ALTER COLUMN `dpia_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Impact Assessment (DPIA) Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` ALTER COLUMN `dpia_required` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Impact Assessment (DPIA) Required');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` ALTER COLUMN `escalation_procedure` SET TAGS ('dbx_business_glossary_term' = 'Escalation Procedure');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` ALTER COLUMN `external_reference_url` SET TAGS ('dbx_business_glossary_term' = 'External Reference Uniform Resource Locator (URL)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` ALTER COLUMN `legal_citation` SET TAGS ('dbx_business_glossary_term' = 'Legal Citation');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_business_glossary_term' = 'Obligation Code');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,20}$');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` ALTER COLUMN `obligation_description` SET TAGS ('dbx_business_glossary_term' = 'Obligation Description');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` ALTER COLUMN `obligation_name` SET TAGS ('dbx_business_glossary_term' = 'Obligation Name');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_business_glossary_term' = 'Obligation Type');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_value_regex' = 'consent_management|data_subject_rights|breach_notification|data_retention|cross_border_transfer|privacy_impact_assessment');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` ALTER COLUMN `regulation_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulation Framework');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` ALTER COLUMN `regulation_framework` SET TAGS ('dbx_value_regex' = 'GDPR|CCPA|HIPAA|LGPD|PIPEDA|APPI');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` ALTER COLUMN `response_timeframe_hours` SET TAGS ('dbx_business_glossary_term' = 'Response Timeframe Hours');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency Months');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` ALTER COLUMN `training_completion_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Rate Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` ALTER COLUMN `training_required` SET TAGS ('dbx_business_glossary_term' = 'Training Required');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` SET TAGS ('dbx_subdomain' = 'privacy_protection');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `privacy_impact_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Impact Assessment (PIA) ID');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `data_processing_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Data Processing Activity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `privacy_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Obligation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `superseded_privacy_impact_assessment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `assessment_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `assessment_conducted_by` SET TAGS ('dbx_business_glossary_term' = 'Assessment Conducted By');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `assessment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Assessment Reference Number');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `assessment_reference_number` SET TAGS ('dbx_value_regex' = '^PIA-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `assessment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'DPIA|PIA|threshold_assessment|full_assessment|light_touch_review|update_assessment');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `automated_decision_making` SET TAGS ('dbx_business_glossary_term' = 'Automated Decision Making Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `data_categories_processed` SET TAGS ('dbx_business_glossary_term' = 'Data Categories Processed');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `data_protection_by_design` SET TAGS ('dbx_business_glossary_term' = 'Data Protection by Design Measures');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `data_retention_period` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `data_subject_categories` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Categories');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `data_subject_consultation` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Consultation');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `data_subject_count_estimate` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Count Estimate');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `data_transfer_outside_eea` SET TAGS ('dbx_business_glossary_term' = 'Data Transfer Outside European Economic Area (EEA) Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `document_location` SET TAGS ('dbx_business_glossary_term' = 'Document Location');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `document_location` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `dpo_consultation_date` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Officer (DPO) Consultation Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `dpo_consulted` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Officer (DPO) Consulted Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `dpo_recommendation` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Officer (DPO) Recommendation');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `large_scale_processing` SET TAGS ('dbx_business_glossary_term' = 'Large Scale Processing Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `legal_basis` SET TAGS ('dbx_business_glossary_term' = 'Legal Basis for Processing');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `legal_basis` SET TAGS ('dbx_value_regex' = 'consent|contract|legal_obligation|vital_interests|public_task|legitimate_interests');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `mitigation_measures` SET TAGS ('dbx_business_glossary_term' = 'Risk Mitigation Measures');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `necessity_assessment` SET TAGS ('dbx_business_glossary_term' = 'Necessity Assessment');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `processing_purpose` SET TAGS ('dbx_business_glossary_term' = 'Processing Purpose');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `proportionality_assessment` SET TAGS ('dbx_business_glossary_term' = 'Proportionality Assessment');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `residual_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Level');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `residual_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `risk_identification_summary` SET TAGS ('dbx_business_glossary_term' = 'Risk Identification Summary');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Overall Risk Level');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `special_category_data_processed` SET TAGS ('dbx_business_glossary_term' = 'Special Category Data Processed Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `supervisory_authority_consultation_date` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Authority Consultation Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `supervisory_authority_consultation_required` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Authority Consultation Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `supervisory_authority_response` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Authority Response');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `systematic_monitoring` SET TAGS ('dbx_business_glossary_term' = 'Systematic Monitoring Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `third_party_processors` SET TAGS ('dbx_business_glossary_term' = 'Third Party Processors');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `transfer_mechanism` SET TAGS ('dbx_business_glossary_term' = 'International Transfer Mechanism');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `transfer_mechanism` SET TAGS ('dbx_value_regex' = 'adequacy_decision|standard_contractual_clauses|binding_corporate_rules|derogation|not_applicable');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` SET TAGS ('dbx_subdomain' = 'risk_remediation');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Site Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `gxp_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Gxp Obligation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Closure Approved By Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `incident_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation Owner Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `incident_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `incident_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `incident_reported_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reported By Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `incident_reported_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `incident_reported_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Product Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `related_incident_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `actual_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Closure Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `affected_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Affected Batch Number');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `affected_function` SET TAGS ('dbx_business_glossary_term' = 'Affected Function');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `affected_product_name` SET TAGS ('dbx_business_glossary_term' = 'Affected Product Name');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `affected_regulation` SET TAGS ('dbx_business_glossary_term' = 'Affected Regulation');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `affected_regulation_section` SET TAGS ('dbx_business_glossary_term' = 'Affected Regulation Section');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `authority_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Authority Notification Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `authority_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Authority Reference Number');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `capa_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `closure_approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Closure Approved By Name');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `containment_effective` SET TAGS ('dbx_business_glossary_term' = 'Containment Effective Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Discovery Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `discovery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Discovery Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `escalation_status` SET TAGS ('dbx_business_glossary_term' = 'Escalation Status');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `escalation_status` SET TAGS ('dbx_value_regex' = 'not_escalated|escalated_to_management|escalated_to_executive|escalated_to_board');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `immediate_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Immediate Action Taken');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `incident_category` SET TAGS ('dbx_business_glossary_term' = 'Incident Category');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `incident_category` SET TAGS ('dbx_value_regex' = 'gxp_violation|sox_control_failure|privacy_breach|data_integrity|anti_bribery|sunshine_act_failure');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `incident_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Description');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Number');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_value_regex' = '^INC-[0-9]{8}$');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Status');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|pending_capa|capa_in_progress|closed|cancelled');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `investigation_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Investigation Owner Name');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `occurrence_date` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `reportable_to_authority` SET TAGS ('dbx_business_glossary_term' = 'Reportable to Authority Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `reported_by_name` SET TAGS ('dbx_business_glossary_term' = 'Reported By Name');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'human_error|process_failure|system_failure|training_gap|documentation_error|equipment_malfunction');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|major|moderate|minor');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Incident Subcategory');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `target_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Target Closure Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Incident Title');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` SET TAGS ('dbx_subdomain' = 'risk_remediation');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `compliance_capa_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Corrective and Preventive Action (CAPA) ID');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Action Owner ID');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `gxp_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Obligation ID');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program ID');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `sox_control_test_id` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control ID');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `triggering_event_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Event Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `originating_compliance_capa_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `action_owner_department` SET TAGS ('dbx_business_glossary_term' = 'Action Owner Department');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `action_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Action Owner Name');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `affected_regulation` SET TAGS ('dbx_business_glossary_term' = 'Affected Regulation');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `capa_number` SET TAGS ('dbx_business_glossary_term' = 'Compliance CAPA Number');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `capa_number` SET TAGS ('dbx_value_regex' = '^CCAPA-[0-9]{6,10}$');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `capa_status` SET TAGS ('dbx_business_glossary_term' = 'CAPA Status');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `capa_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|pending_review|effectiveness_check|closed|cancelled');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `capa_type` SET TAGS ('dbx_business_glossary_term' = 'CAPA Type');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `capa_type` SET TAGS ('dbx_value_regex' = 'corrective|preventive|combined');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `closure_verification_by` SET TAGS ('dbx_business_glossary_term' = 'Closure Verification By');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `closure_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Verification Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `data_integrity_alcoa_plus_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Integrity ALCOA+ Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `effectiveness_check_criteria` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Check Criteria');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `effectiveness_check_date` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Check Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `effectiveness_check_result` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Check Result');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `effectiveness_check_result` SET TAGS ('dbx_value_regex' = 'effective|partially_effective|ineffective|pending');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `escalation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `inspection_citation_reference` SET TAGS ('dbx_business_glossary_term' = 'Inspection Citation Reference');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `preventive_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Plan');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `regulatory_response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Response Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `regulatory_response_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Response Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `regulatory_response_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Response Submitted Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `root_cause_analysis_method` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis (RCA) Method');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `root_cause_analysis_method` SET TAGS ('dbx_value_regex' = '5_whys|fishbone|fault_tree|pareto|failure_mode_effects_analysis|other');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'process|people|technology|documentation|training|oversight');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `root_cause_determination` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Determination');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|major|moderate|minor');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'CAPA Title');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `triggering_event_date` SET TAGS ('dbx_business_glossary_term' = 'Triggering Event Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `triggering_event_type` SET TAGS ('dbx_business_glossary_term' = 'Triggering Event Type');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ALTER COLUMN `triggering_event_type` SET TAGS ('dbx_value_regex' = 'regulatory_inspection|internal_audit|external_audit|sox_control_deficiency|gdpr_breach|data_integrity_incident');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` SET TAGS ('dbx_subdomain' = 'regulatory_obligations');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `sox_control_test_id` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Test ID');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `internal_control_id` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control ID');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Tester ID');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer ID');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `previous_sox_control_test_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `account_affected` SET TAGS ('dbx_business_glossary_term' = 'Account Affected');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `automation_level` SET TAGS ('dbx_business_glossary_term' = 'Automation Level');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `automation_level` SET TAGS ('dbx_value_regex' = 'manual|automated|hybrid');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `control_code` SET TAGS ('dbx_business_glossary_term' = 'Control Code');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `control_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `control_frequency` SET TAGS ('dbx_business_glossary_term' = 'Control Frequency');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `control_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annually|event_driven');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `control_type` SET TAGS ('dbx_business_glossary_term' = 'Control Type');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `control_type` SET TAGS ('dbx_value_regex' = 'preventive|detective|corrective');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `deficiency_classification` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Classification');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `deficiency_classification` SET TAGS ('dbx_value_regex' = 'no_deficiency|control_deficiency|significant_deficiency|material_weakness');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `entity_level_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Entity Level Control Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `exception_description` SET TAGS ('dbx_business_glossary_term' = 'Exception Description');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `exceptions_identified_count` SET TAGS ('dbx_business_glossary_term' = 'Exceptions Identified Count');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `external_auditor_reliance_flag` SET TAGS ('dbx_business_glossary_term' = 'External Auditor Reliance Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `financial_statement_assertion` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Assertion');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `it_dependent_flag` SET TAGS ('dbx_business_glossary_term' = 'Information Technology (IT) Dependent Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `key_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Key Control Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `management_conclusion` SET TAGS ('dbx_business_glossary_term' = 'Management Conclusion');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `management_conclusion` SET TAGS ('dbx_value_regex' = 'effective|ineffective|not_tested|not_applicable');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `population_size` SET TAGS ('dbx_business_glossary_term' = 'Population Size');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `process_area` SET TAGS ('dbx_business_glossary_term' = 'Process Area');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `remediation_plan` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `remediation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Remediation Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `sample_selection_method` SET TAGS ('dbx_business_glossary_term' = 'Sample Selection Method');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `sample_selection_method` SET TAGS ('dbx_value_regex' = 'random|systematic|judgmental|stratified|haphazard');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `test_documentation_reference` SET TAGS ('dbx_business_glossary_term' = 'Test Documentation Reference');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `test_execution_date` SET TAGS ('dbx_business_glossary_term' = 'Test Execution Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `test_objective` SET TAGS ('dbx_business_glossary_term' = 'Test Objective');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `test_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Test Period End Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `test_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Test Period Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `test_status` SET TAGS ('dbx_business_glossary_term' = 'Test Status');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `test_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|reviewed|approved');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `tester_name` SET TAGS ('dbx_business_glossary_term' = 'Tester Name');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `tester_role` SET TAGS ('dbx_business_glossary_term' = 'Tester Role');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `tester_role` SET TAGS ('dbx_value_regex' = 'management|internal_audit|external_audit|compliance_officer');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `testing_approach` SET TAGS ('dbx_business_glossary_term' = 'Testing Approach');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ALTER COLUMN `testing_approach` SET TAGS ('dbx_value_regex' = 'inquiry|observation|inspection|reperformance');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` SET TAGS ('dbx_subdomain' = 'authority_inspections');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `monitoring_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Monitoring Activity Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `gxp_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Gxp Obligation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Employee Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `quality_capa_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Employee Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `followup_monitoring_activity_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `activity_number` SET TAGS ('dbx_business_glossary_term' = 'Compliance Monitoring Activity Number');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `activity_number` SET TAGS ('dbx_value_regex' = '^CMA-[0-9]{8}$');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `alcoa_plus_assessment_flag` SET TAGS ('dbx_business_glossary_term' = 'ALCOA Plus Assessment Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Activity Approved Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `capa_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `evidence_location` SET TAGS ('dbx_business_glossary_term' = 'Evidence Storage Location');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Execution Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `findings_count` SET TAGS ('dbx_business_glossary_term' = 'Compliance Findings Count');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Compliance Findings Summary');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `inspection_readiness_impact` SET TAGS ('dbx_business_glossary_term' = 'Inspection Readiness Impact');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `inspection_readiness_impact` SET TAGS ('dbx_value_regex' = 'positive|neutral|negative');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `monitor_name` SET TAGS ('dbx_business_glossary_term' = 'Monitor Name');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `monitored_function` SET TAGS ('dbx_business_glossary_term' = 'Monitored Business Function');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `monitored_site_code` SET TAGS ('dbx_business_glossary_term' = 'Monitored Site Code');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `monitored_site_name` SET TAGS ('dbx_business_glossary_term' = 'Monitored Site Name');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `monitoring_methodology` SET TAGS ('dbx_business_glossary_term' = 'Compliance Monitoring Methodology');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `monitoring_methodology` SET TAGS ('dbx_value_regex' = 'desk_review|on_site_inspection|remote_audit|data_analytics|sampling|continuous_monitoring');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `monitoring_notes` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Activity Notes');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `monitoring_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Period End Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `monitoring_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Period Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `monitoring_scope` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Scope Description');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `monitoring_status` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Activity Status');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `monitoring_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|cancelled|on_hold');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `monitoring_type` SET TAGS ('dbx_business_glossary_term' = 'Compliance Monitoring Type');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `monitoring_type` SET TAGS ('dbx_value_regex' = 'hcp_engagement|promotional_materials|clinical_trial|gxp_process|data_integrity|sox_control');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `population_size` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Population Size');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `recommended_actions` SET TAGS ('dbx_business_glossary_term' = 'Recommended Corrective Actions');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Applicable Regulatory Framework');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|completed|overdue');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Compliance Risk Rating');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|none');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Sample Size');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` SET TAGS ('dbx_subdomain' = 'risk_remediation');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `risk_register_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Risk Register ID');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Owner Employee ID');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `quaternary_risk_last_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By Employee ID');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `quaternary_risk_last_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `quaternary_risk_last_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `tertiary_risk_created_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Created By Employee ID');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `tertiary_risk_created_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `tertiary_risk_created_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `parent_risk_register_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `applicable_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Applicable Jurisdiction');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `board_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Board Reporting Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `control_effectiveness` SET TAGS ('dbx_business_glossary_term' = 'Control Effectiveness Rating');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `control_effectiveness` SET TAGS ('dbx_value_regex' = 'Effective|Partially Effective|Ineffective|Not Tested');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `escalation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `existing_controls_description` SET TAGS ('dbx_business_glossary_term' = 'Existing Controls Description');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `identification_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Identification Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `identification_source` SET TAGS ('dbx_business_glossary_term' = 'Risk Identification Source');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `inherent_impact` SET TAGS ('dbx_business_glossary_term' = 'Inherent Risk Impact');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `inherent_impact` SET TAGS ('dbx_value_regex' = 'Very Low|Low|Medium|High|Very High');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `inherent_likelihood` SET TAGS ('dbx_business_glossary_term' = 'Inherent Risk Likelihood');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `inherent_likelihood` SET TAGS ('dbx_value_regex' = 'Very Low|Low|Medium|High|Very High');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `inherent_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Inherent Risk Rating');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `inherent_risk_rating` SET TAGS ('dbx_value_regex' = 'Low|Medium|High|Critical');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `inherent_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Inherent Risk Score');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Risk Review Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Risk Review Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `residual_impact` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Impact');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `residual_impact` SET TAGS ('dbx_value_regex' = 'Very Low|Low|Medium|High|Very High');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `residual_likelihood` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Likelihood');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `residual_likelihood` SET TAGS ('dbx_value_regex' = 'Very Low|Low|Medium|High|Very High');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `residual_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Rating');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `residual_risk_rating` SET TAGS ('dbx_value_regex' = 'Low|Medium|High|Critical');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `residual_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Score');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Risk Review Frequency');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `review_frequency` SET TAGS ('dbx_value_regex' = 'Monthly|Quarterly|Semi-Annually|Annually|Ad-Hoc');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `risk_appetite_alignment` SET TAGS ('dbx_business_glossary_term' = 'Risk Appetite Alignment Status');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `risk_appetite_alignment` SET TAGS ('dbx_value_regex' = 'Within Appetite|Exceeds Appetite|Below Appetite');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `risk_appetite_threshold` SET TAGS ('dbx_business_glossary_term' = 'Risk Appetite Threshold');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `risk_appetite_threshold` SET TAGS ('dbx_value_regex' = 'Low|Medium|High|Critical');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `risk_code` SET TAGS ('dbx_business_glossary_term' = 'Risk Identification Number');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `risk_code` SET TAGS ('dbx_value_regex' = '^RISK-[A-Z]{3}-[0-9]{6}$');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `risk_description` SET TAGS ('dbx_business_glossary_term' = 'Risk Description');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `risk_owner_function` SET TAGS ('dbx_business_glossary_term' = 'Risk Owner Function');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `risk_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Status');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `risk_status` SET TAGS ('dbx_value_regex' = 'Open|Under Assessment|Treatment in Progress|Monitoring|Closed|Escalated');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `risk_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Risk Subcategory');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `risk_title` SET TAGS ('dbx_business_glossary_term' = 'Risk Title');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `risk_treatment_decision` SET TAGS ('dbx_business_glossary_term' = 'Risk Treatment Decision');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `risk_treatment_decision` SET TAGS ('dbx_value_regex' = 'Accept|Mitigate|Transfer|Avoid');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `risk_treatment_decision` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `risk_treatment_decision` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `treatment_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Treatment Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `treatment_completion_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `treatment_completion_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `treatment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Treatment Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `treatment_due_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `treatment_due_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `treatment_plan_description` SET TAGS ('dbx_business_glossary_term' = 'Risk Treatment Plan Description');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `treatment_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Treatment Status');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `treatment_status` SET TAGS ('dbx_value_regex' = 'Not Started|In Progress|Completed|Overdue|Cancelled');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `treatment_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ALTER COLUMN `treatment_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` SET TAGS ('dbx_subdomain' = 'regulatory_obligations');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ALTER COLUMN `policy_document_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Document ID');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ALTER COLUMN `policy_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ALTER COLUMN `primary_policy_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Document Owner Employee ID');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ALTER COLUMN `primary_policy_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ALTER COLUMN `primary_policy_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ALTER COLUMN `superseded_policy_document_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ALTER COLUMN `applicable_functions` SET TAGS ('dbx_business_glossary_term' = 'Applicable Functions');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ALTER COLUMN `applicable_regulation` SET TAGS ('dbx_business_glossary_term' = 'Applicable Regulation');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ALTER COLUMN `applicable_sites` SET TAGS ('dbx_business_glossary_term' = 'Applicable Sites');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ALTER COLUMN `data_integrity_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Integrity Requirement Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ALTER COLUMN `distribution_scope` SET TAGS ('dbx_business_glossary_term' = 'Distribution Scope');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ALTER COLUMN `distribution_scope` SET TAGS ('dbx_value_regex' = 'enterprise_wide|site_specific|department_specific|role_specific|restricted');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ALTER COLUMN `document_category` SET TAGS ('dbx_business_glossary_term' = 'Document Category');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ALTER COLUMN `document_description` SET TAGS ('dbx_business_glossary_term' = 'Document Description');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[A-Z]{3}-d{4}$');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ALTER COLUMN `document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ALTER COLUMN `document_storage_location` SET TAGS ('dbx_business_glossary_term' = 'Document Storage Location');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ALTER COLUMN `document_title` SET TAGS ('dbx_business_glossary_term' = 'Document Title');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = 'policy|sop|guideline|work_instruction|procedure|standard');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ALTER COLUMN `electronic_records_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Records Requirement Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ALTER COLUMN `gdpr_applicability_flag` SET TAGS ('dbx_business_glossary_term' = 'GDPR (General Data Protection Regulation) Applicability Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ALTER COLUMN `governance_committee` SET TAGS ('dbx_business_glossary_term' = 'Governance Committee');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ALTER COLUMN `hipaa_applicability_flag` SET TAGS ('dbx_business_glossary_term' = 'HIPAA (Health Insurance Portability and Accountability Act) Applicability Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ALTER COLUMN `next_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ALTER COLUMN `related_policy_references` SET TAGS ('dbx_business_glossary_term' = 'Related Policy References');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ALTER COLUMN `review_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle Months');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'SOX (Sarbanes-Oxley Act) Control Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ALTER COLUMN `superseded_document_number` SET TAGS ('dbx_business_glossary_term' = 'Superseded Document Number');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ALTER COLUMN `training_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Training Frequency Months');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ALTER COLUMN `training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^d+.d+$');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` SET TAGS ('dbx_subdomain' = 'privacy_protection');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ALTER COLUMN `disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Disclosure Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ALTER COLUMN `conflict_of_interest_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Of Interest Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ALTER COLUMN `disclosure_preparer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Preparer Employee Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ALTER COLUMN `disclosure_preparer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ALTER COLUMN `disclosure_preparer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Submitting Entity Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ALTER COLUMN `original_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Original Disclosure Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Employee Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ALTER COLUMN `amended_disclosure_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ALTER COLUMN `acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ALTER COLUMN `acknowledgment_receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Receipt Number');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ALTER COLUMN `amendment_reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Amount');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ALTER COLUMN `content` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Content');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ALTER COLUMN `content` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ALTER COLUMN `disclosure_number` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Number');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ALTER COLUMN `disclosure_number` SET TAGS ('dbx_value_regex' = '^DISC-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ALTER COLUMN `disclosure_status` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Status');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ALTER COLUMN `disclosure_type` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Type');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ALTER COLUMN `disclosure_type` SET TAGS ('dbx_value_regex' = 'sunshine_act|efpia_disclosure|anti_bribery|conflict_of_interest|beneficial_ownership|other');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Notes');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ALTER COLUMN `publication_url` SET TAGS ('dbx_business_glossary_term' = 'Publication Uniform Resource Locator (URL)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ALTER COLUMN `recipient_count` SET TAGS ('dbx_business_glossary_term' = 'Recipient Count');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ALTER COLUMN `submitting_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Submitting Entity Name');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ALTER COLUMN `supporting_document_location` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Location');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ALTER COLUMN `transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Transaction Count');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` SET TAGS ('dbx_subdomain' = 'privacy_protection');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `conflict_of_interest_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict of Interest (COI) ID');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `trial_id` SET TAGS ('dbx_business_glossary_term' = 'Applicable Clinical Trial ID');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Declarant Healthcare Professional (HCP) ID');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Applicable Product ID');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Declarant Employee ID');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Employee ID');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `prior_conflict_of_interest_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `attestation_statement` SET TAGS ('dbx_business_glossary_term' = 'Attestation Statement');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `attestation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Attestation Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `counterparty_name` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Name');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `counterparty_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `counterparty_type` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Type');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `declarant_email` SET TAGS ('dbx_business_glossary_term' = 'Declarant Email Address');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `declarant_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `declarant_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `declarant_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `declarant_name` SET TAGS ('dbx_business_glossary_term' = 'Declarant Full Name');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `declarant_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `declarant_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `declarant_type` SET TAGS ('dbx_business_glossary_term' = 'Declarant Type');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `declarant_type` SET TAGS ('dbx_value_regex' = 'employee|investigator|advisory_board_member|hcp|consultant|vendor');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `declaration_date` SET TAGS ('dbx_business_glossary_term' = 'Declaration Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `declaration_number` SET TAGS ('dbx_business_glossary_term' = 'Declaration Number');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `declaration_number` SET TAGS ('dbx_value_regex' = '^COI-[0-9]{8}$');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `declaration_status` SET TAGS ('dbx_business_glossary_term' = 'Declaration Status');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `declaration_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|approved|rejected|withdrawn');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `declaration_type` SET TAGS ('dbx_business_glossary_term' = 'Declaration Type');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `declaration_type` SET TAGS ('dbx_value_regex' = 'initial|annual_recertification|ad_hoc|triggered|amendment');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `declared_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Declared Value Amount');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `declared_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `declared_value_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `declared_value_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Declared Value Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `declared_value_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `disclosure_date` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `disclosure_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `interest_description` SET TAGS ('dbx_business_glossary_term' = 'Interest Description');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `interest_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `management_plan` SET TAGS ('dbx_business_glossary_term' = 'Conflict Management Plan');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `management_plan` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `mitigation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `mitigation_status` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Status');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `mitigation_status` SET TAGS ('dbx_value_regex' = 'not_required|planned|in_progress|completed|verified');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `recertification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Recertification Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `recertification_status` SET TAGS ('dbx_business_glossary_term' = 'Recertification Status');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `recertification_status` SET TAGS ('dbx_value_regex' = 'current|overdue|not_applicable|pending');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Relationship Type');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `review_notes` SET TAGS ('dbx_business_glossary_term' = 'Review Notes');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `review_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Review Outcome');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `review_outcome` SET TAGS ('dbx_value_regex' = 'no_conflict|managed_conflict|prohibited_conflict|requires_mitigation|pending_review');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ALTER COLUMN `supporting_document_location` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Location');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` SET TAGS ('dbx_subdomain' = 'risk_remediation');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `third_party_due_diligence_id` SET TAGS ('dbx_business_glossary_term' = 'Third Party Due Diligence ID');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `business_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Business Partner Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `primary_third_assessor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assessor Employee ID');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `primary_third_assessor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `primary_third_assessor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Employee ID');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `third_party_business_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Third Party ID');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `prior_third_party_due_diligence_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `abac_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Anti-Bribery and Corruption (ABAC) Screening Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `abac_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Anti-Bribery and Corruption (ABAC) Screening Status');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `abac_screening_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|clear|concerns_identified|under_review');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `approval_conditions` SET TAGS ('dbx_business_glossary_term' = 'Approval Conditions');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `approval_decision` SET TAGS ('dbx_business_glossary_term' = 'Approval Decision');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `approval_decision` SET TAGS ('dbx_value_regex' = 'approved|approved_with_conditions|rejected|pending');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `assessment_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Completed Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `assessment_initiated_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Initiated Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `assessment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Notes');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `assessment_number` SET TAGS ('dbx_business_glossary_term' = 'Assessment Number');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `country_of_operation` SET TAGS ('dbx_business_glossary_term' = 'Country of Operation');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `data_integrity_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Integrity Verified Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `debarment_match_found_flag` SET TAGS ('dbx_business_glossary_term' = 'Debarment Match Found Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `debarment_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Debarment Screening Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `debarment_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Debarment Screening Status');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `debarment_screening_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|clear|match_found|under_review');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `due_diligence_tier` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence Tier');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `due_diligence_tier` SET TAGS ('dbx_value_regex' = 'simplified|standard|enhanced');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `engagement_type` SET TAGS ('dbx_business_glossary_term' = 'Engagement Type');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `evidence_document_location` SET TAGS ('dbx_business_glossary_term' = 'Evidence Document Location');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `gxp_compliance_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Compliance Verified Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `next_rescreening_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Rescreening Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `overall_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Risk Rating');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `overall_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `reputational_risk_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Reputational Risk Assessment Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `reputational_risk_assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Reputational Risk Assessment Status');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `reputational_risk_assessment_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|clear|concerns_identified|under_review');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `rescreening_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Rescreening Frequency Months');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `sanctions_match_found_flag` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Match Found Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `sanctions_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Status');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|clear|match_found|under_review');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ALTER COLUMN `third_party_type` SET TAGS ('dbx_business_glossary_term' = 'Third Party Type');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` SET TAGS ('dbx_subdomain' = 'risk_remediation');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `debarment_check_id` SET TAGS ('dbx_business_glossary_term' = 'Debarment Check ID');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `business_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Business Partner Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `investigational_site_id` SET TAGS ('dbx_business_glossary_term' = 'Site ID');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `primary_debarment_adjudicator_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Adjudicator Employee ID');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `primary_debarment_adjudicator_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `primary_debarment_adjudicator_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `third_party_due_diligence_id` SET TAGS ('dbx_business_glossary_term' = 'Third Party Due Diligence Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `prior_debarment_check_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `adjudication_date` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `adjudication_notes` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Notes');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `adjudication_outcome` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Outcome');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `adjudication_outcome` SET TAGS ('dbx_value_regex' = 'approved|rejected|requires_mitigation|disqualified');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `adjudication_status` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Status');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `adjudication_status` SET TAGS ('dbx_value_regex' = 'pending|under_review|cleared|confirmed_exclusion|escalated');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Check Number');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `eu_sanctions_checked_flag` SET TAGS ('dbx_business_glossary_term' = 'EU (European Union) Sanctions Checked Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `exclusion_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Effective Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `exclusion_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Expiration Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `exclusion_reason` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Reason');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `fda_debarment_checked_flag` SET TAGS ('dbx_business_glossary_term' = 'FDA (Food and Drug Administration) Debarment Checked Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `gcp_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'GCP (Good Clinical Practice) Compliance Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `lists_checked` SET TAGS ('dbx_business_glossary_term' = 'Lists Checked');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `match_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Match Confidence Score');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `match_count` SET TAGS ('dbx_business_glossary_term' = 'Match Count');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `match_details` SET TAGS ('dbx_business_glossary_term' = 'Match Details');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `match_list_name` SET TAGS ('dbx_business_glossary_term' = 'Match List Name');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `match_status` SET TAGS ('dbx_business_glossary_term' = 'Match Status');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `match_status` SET TAGS ('dbx_value_regex' = 'no_match|potential_match|confirmed_match|false_positive');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `next_screening_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Screening Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `ofac_sdn_checked_flag` SET TAGS ('dbx_business_glossary_term' = 'OFAC (Office of Foreign Assets Control) SDN (Specially Designated Nationals) Checked Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `oig_leie_checked_flag` SET TAGS ('dbx_business_glossary_term' = 'OIG (Office of Inspector General) LEIE (List of Excluded Individuals and Entities) Checked Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `rescreening_trigger` SET TAGS ('dbx_business_glossary_term' = 'Rescreening Trigger');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `sam_exclusion_checked_flag` SET TAGS ('dbx_business_glossary_term' = 'SAM (System for Award Management) Exclusion Checked Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `screening_date` SET TAGS ('dbx_business_glossary_term' = 'Screening Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `screening_frequency` SET TAGS ('dbx_business_glossary_term' = 'Screening Frequency');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `screening_frequency` SET TAGS ('dbx_value_regex' = 'one_time|monthly|quarterly|annual|continuous');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `screening_method` SET TAGS ('dbx_business_glossary_term' = 'Screening Method');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `screening_method` SET TAGS ('dbx_value_regex' = 'automated|manual|hybrid');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `screening_status` SET TAGS ('dbx_business_glossary_term' = 'Screening Status');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `screening_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|failed|cancelled');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `screening_system` SET TAGS ('dbx_business_glossary_term' = 'Screening System');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `screening_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Screening Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `screening_type` SET TAGS ('dbx_business_glossary_term' = 'Screening Type');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `subject_address` SET TAGS ('dbx_business_glossary_term' = 'Subject Address');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `subject_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `subject_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `subject_country_code` SET TAGS ('dbx_business_glossary_term' = 'Subject Country Code');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `subject_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `subject_date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Subject Date of Birth');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `subject_date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `subject_date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `subject_first_name` SET TAGS ('dbx_business_glossary_term' = 'Subject First Name');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `subject_first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `subject_first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `subject_identifier` SET TAGS ('dbx_business_glossary_term' = 'Subject Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `subject_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `subject_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `subject_last_name` SET TAGS ('dbx_business_glossary_term' = 'Subject Last Name');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `subject_last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `subject_last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `subject_type` SET TAGS ('dbx_business_glossary_term' = 'Subject Type');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ALTER COLUMN `subject_type` SET TAGS ('dbx_value_regex' = 'person|organization|site|vendor');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` SET TAGS ('dbx_subdomain' = 'privacy_protection');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `attestation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Attestation Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Attestor Employee Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `attestation_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `attestation_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `attestation_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Attestor Site Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `policy_document_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Document Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `quality_capa_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Employee Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `prior_attestation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `attestation_number` SET TAGS ('dbx_business_glossary_term' = 'Attestation Number');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `attestation_number` SET TAGS ('dbx_value_regex' = '^ATT-[0-9]{8}$');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `attestation_status` SET TAGS ('dbx_business_glossary_term' = 'Attestation Status');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `attestation_type` SET TAGS ('dbx_business_glossary_term' = 'Attestation Type');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `attestation_type` SET TAGS ('dbx_value_regex' = 'code_of_conduct|sox_certification|gxp_declaration|gdpr_data_handling|conflict_of_interest|training_completion');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `attestor_department` SET TAGS ('dbx_business_glossary_term' = 'Attestor Department');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `attestor_email` SET TAGS ('dbx_business_glossary_term' = 'Attestor Email Address');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `attestor_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `attestor_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `attestor_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `attestor_job_title` SET TAGS ('dbx_business_glossary_term' = 'Attestor Job Title');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `attestor_name` SET TAGS ('dbx_business_glossary_term' = 'Attestor Full Name');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `attestor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `attestor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `content` SET TAGS ('dbx_business_glossary_term' = 'Attestation Content');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `electronic_signature` SET TAGS ('dbx_business_glossary_term' = 'Electronic Signature');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `electronic_signature` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `electronic_signature` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `exception_description` SET TAGS ('dbx_business_glossary_term' = 'Exception Description');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `exception_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `exceptions_disclosed_flag` SET TAGS ('dbx_business_glossary_term' = 'Exceptions Disclosed Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `follow_up_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `gxp_category` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Category');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `gxp_category` SET TAGS ('dbx_value_regex' = 'gmp|glp|gcp|gdp|gvp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `ip_address` SET TAGS ('dbx_value_regex' = '^(?:[0-9]{1,3}.){3}[0-9]{1,3}$');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Attestation Period End Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Attestation Period Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `policy_version` SET TAGS ('dbx_business_glossary_term' = 'Policy Version');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `policy_version` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}.[0-9]{1,3}$');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `review_notes` SET TAGS ('dbx_business_glossary_term' = 'Review Notes');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `review_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `sox_section` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Section');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `sox_section` SET TAGS ('dbx_value_regex' = 'section_302|section_404|section_906');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'web_portal|mobile_app|email|paper');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ALTER COLUMN `training_completion_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` SET TAGS ('dbx_subdomain' = 'authority_inspections');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `warning_letter_id` SET TAGS ('dbx_business_glossary_term' = 'Warning Letter Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `gxp_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Gxp Obligation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `primary_warning_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Response Coordinator Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `primary_warning_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `primary_warning_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `quality_capa_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Entity Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Site Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `regulatory_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `policy_document_id` SET TAGS ('dbx_business_glossary_term' = 'Response Document Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `followup_warning_letter_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `cfr_citations` SET TAGS ('dbx_business_glossary_term' = 'Code of Federal Regulations (CFR) Citations');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `cited_violations` SET TAGS ('dbx_business_glossary_term' = 'Cited Violations');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Warning Letter Closure Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `closure_status` SET TAGS ('dbx_business_glossary_term' = 'Closure Status');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `closure_status` SET TAGS ('dbx_value_regex' = 'open|closed_satisfactory|closed_with_conditions|escalated_to_consent_decree|escalated_to_import_alert');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `commitment_summary` SET TAGS ('dbx_business_glossary_term' = 'Commitment Summary');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `consent_decree_related_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Decree Related Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `executive_notification_flag` SET TAGS ('dbx_business_glossary_term' = 'Executive Notification Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `gmp_citation` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Citation');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `health_authority_acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Health Authority Acknowledgment Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `health_authority_acknowledgment_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `health_authority_acknowledgment_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `health_authority_feedback` SET TAGS ('dbx_business_glossary_term' = 'Health Authority Feedback');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `health_authority_feedback` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `health_authority_feedback` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `import_alert_flag` SET TAGS ('dbx_business_glossary_term' = 'Import Alert Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Letter Issue Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Health Authority');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `issuing_authority_country_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority Country Code');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `issuing_authority_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `legal_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `letter_document_url` SET TAGS ('dbx_business_glossary_term' = 'Letter Document Uniform Resource Locator (URL)');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `letter_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Letter Reference Number');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `letter_status` SET TAGS ('dbx_business_glossary_term' = 'Letter Status');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `letter_type` SET TAGS ('dbx_business_glossary_term' = 'Letter Type');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `letter_type` SET TAGS ('dbx_value_regex' = 'warning_letter|untitled_letter|regulatory_meeting_minutes|consent_decree|import_alert|other');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `process_scope` SET TAGS ('dbx_business_glossary_term' = 'Process Scope');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `product_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Product Impact Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `product_scope` SET TAGS ('dbx_business_glossary_term' = 'Product Scope');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `public_disclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Letter Receipt Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `regulatory_action_risk` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Action Risk');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `regulatory_action_risk` SET TAGS ('dbx_value_regex' = 'none|consent_decree|injunction|criminal_prosecution|product_seizure|import_detention');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `reinspection_date` SET TAGS ('dbx_business_glossary_term' = 'Reinspection Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `reinspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Reinspection Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `response_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Response Submission Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program_obligation_scope` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program_obligation_scope` SET TAGS ('dbx_subdomain' = 'regulatory_obligations');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program_obligation_scope` SET TAGS ('dbx_association_edges' = 'compliance.compliance_program,compliance.gxp_obligation');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program_obligation_scope` ALTER COLUMN `program_obligation_scope_id` SET TAGS ('dbx_business_glossary_term' = 'Program Obligation Scope Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program_obligation_scope` ALTER COLUMN `compliance_program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program_obligation_scope` ALTER COLUMN `gxp_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Program Obligation Scope - Gxp Obligation Id');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program_obligation_scope` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Obligation Scope - Compliance Program Id');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program_obligation_scope` ALTER COLUMN `assigned_by` SET TAGS ('dbx_business_glossary_term' = 'Scope Assignment Owner');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program_obligation_scope` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Scope Assignment Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program_obligation_scope` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Program-Obligation Compliance Status');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program_obligation_scope` ALTER COLUMN `coverage_percentage` SET TAGS ('dbx_business_glossary_term' = 'Obligation Coverage Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program_obligation_scope` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Scope Effective Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program_obligation_scope` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Scope Expiration Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program_obligation_scope` ALTER COLUMN `inspection_readiness_flag` SET TAGS ('dbx_business_glossary_term' = 'Program-Obligation Inspection Readiness');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program_obligation_scope` ALTER COLUMN `last_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Program-Obligation Last Assessment Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program_obligation_scope` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Scope Record Last Modified By');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program_obligation_scope` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Scope Record Last Modified Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program_obligation_scope` ALTER COLUMN `next_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Program-Obligation Next Assessment Date');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program_obligation_scope` ALTER COLUMN `program_scope_notes` SET TAGS ('dbx_business_glossary_term' = 'Program Scope Notes');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program_obligation_scope` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Program-Obligation Risk Level');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`fmv_assessment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`fmv_assessment` SET TAGS ('dbx_subdomain' = 'risk_remediation');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`fmv_assessment` ALTER COLUMN `fmv_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Fmv Assessment Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`fmv_assessment` ALTER COLUMN `superseded_fmv_assessment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`fmv_assessment` ALTER COLUMN `assessor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`fmv_assessment` ALTER COLUMN `created_by_user` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`fmv_assessment` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`fmv_assessment` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`triggering_event` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`triggering_event` SET TAGS ('dbx_subdomain' = 'risk_remediation');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`triggering_event` ALTER COLUMN `triggering_event_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Event Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`triggering_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`triggering_event` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`triggering_event` ALTER COLUMN `preceding_triggering_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_session` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_session` SET TAGS ('dbx_subdomain' = 'electronic_records');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_session` ALTER COLUMN `esignature_session_id` SET TAGS ('dbx_business_glossary_term' = 'Esignature Session Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_session` ALTER COLUMN `parent_esignature_session_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_session` ALTER COLUMN `device_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_session` ALTER COLUMN `device_identifier` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_session` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_session` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_session` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_session` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_session` ALTER COLUMN `signature_hash` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_session` ALTER COLUMN `username` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_session` ALTER COLUMN `username` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`workflow_step` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`workflow_step` SET TAGS ('dbx_subdomain' = 'electronic_records');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`workflow_step` ALTER COLUMN `workflow_step_id` SET TAGS ('dbx_business_glossary_term' = 'Workflow Step Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`workflow_step` ALTER COLUMN `preceding_workflow_step_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`business_process` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`business_process` SET TAGS ('dbx_subdomain' = 'regulatory_obligations');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`business_process` ALTER COLUMN `business_process_id` SET TAGS ('dbx_business_glossary_term' = 'Business Process Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`business_process` ALTER COLUMN `parent_business_process_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`data_processing_activity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`data_processing_activity` SET TAGS ('dbx_subdomain' = 'privacy_protection');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`data_processing_activity` ALTER COLUMN `data_processing_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Data Processing Activity Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`data_processing_activity` ALTER COLUMN `parent_data_processing_activity_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`data_processing_activity` ALTER COLUMN `data_processor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`data_processing_activity` ALTER COLUMN `processor_contract_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`document_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`document_template` SET TAGS ('dbx_subdomain' = 'electronic_records');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`document_template` ALTER COLUMN `document_template_id` SET TAGS ('dbx_business_glossary_term' = 'Document Template Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`document_template` ALTER COLUMN `superseded_document_template_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`document_template` ALTER COLUMN `approved_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`document_template` ALTER COLUMN `storage_location` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`notification_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`notification_template` SET TAGS ('dbx_subdomain' = 'risk_remediation');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`notification_template` ALTER COLUMN `notification_template_id` SET TAGS ('dbx_business_glossary_term' = 'Notification Template Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`notification_template` ALTER COLUMN `superseded_notification_template_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`workflow_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`workflow_template` SET TAGS ('dbx_subdomain' = 'regulatory_obligations');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`workflow_template` ALTER COLUMN `workflow_template_id` SET TAGS ('dbx_business_glossary_term' = 'Workflow Template Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`workflow_template` ALTER COLUMN `superseded_workflow_template_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`audit_trail` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`audit_trail` SET TAGS ('dbx_subdomain' = 'electronic_records');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`audit_trail` ALTER COLUMN `audit_trail_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`audit_trail` ALTER COLUMN `device_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`audit_trail` ALTER COLUMN `device_identifier` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`audit_trail` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`audit_trail` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`audit_trail` ALTER COLUMN `user_full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`audit_trail` ALTER COLUMN `user_full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`audit_trail` ALTER COLUMN `user_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`audit_trail` ALTER COLUMN `user_id` SET TAGS ('dbx_pii_identifier' = 'true');
