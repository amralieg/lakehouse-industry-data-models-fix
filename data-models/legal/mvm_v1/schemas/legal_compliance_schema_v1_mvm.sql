-- Schema for Domain: compliance | Business: Legal | Version: v1_mvm
-- Generated on: 2026-05-07 14:36:17

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `legal_ecm`.`compliance` COMMENT 'Owns regulatory compliance obligations, control frameworks, and reporting requirements applicable to the firm and its clients. Covers AML/KYC program management, GDPR/CCPA/DPA data privacy controls, SOX compliance tracking, SRA regulatory returns, DPO activities, FATF obligations, and professional indemnity insurance. Distinct from conflict domain — compliance owns firm-level regulatory posture; conflict owns matter-level ethics screening.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `legal_ecm`.`compliance`.`regulatory_obligation` (
    `regulatory_obligation_id` BIGINT COMMENT 'Unique identifier for the regulatory obligation record. Primary key.',
    `control_framework_id` BIGINT COMMENT 'Foreign key linking to compliance.control_framework. Business justification: Each regulatory obligation is typically addressed within a primary control framework (e.g., ISO 27001, FATF 40 Recommendations). The existing STRING attribute control_framework_reference is a denormal',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Regulatory obligations are practice-area-specific (SRA standards for litigation, GDPR for data privacy). Compliance teams map obligations to practice areas for targeted training, control design, and r',
    `applicability_scope` STRING COMMENT 'Description of the scope of applicability within the firm (e.g., all offices, specific practice groups, client-facing roles, data processing activities).',
    `compliance_status` STRING COMMENT 'Current compliance status of the firm with respect to this obligation: compliant, non-compliant, in progress, under review, or not applicable.. Valid values are `compliant|non_compliant|in_progress|under_review|not_applicable`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory obligation record was first created in the system.',
    `effective_date` DATE COMMENT 'Date when this regulatory obligation becomes effective and enforceable for the firm.',
    `exemption_applicable_flag` BOOLEAN COMMENT 'Indicates whether the firm qualifies for any exemption or waiver from this obligation. True if an exemption applies, False otherwise.',
    `exemption_details` STRING COMMENT 'Details of any exemption or waiver that applies to the firm for this obligation, including the basis and expiry date of the exemption.',
    `expiry_date` DATE COMMENT 'Date when this regulatory obligation ceases to be applicable or is superseded. Null if the obligation is ongoing without a defined end date.',
    `external_audit_required_flag` BOOLEAN COMMENT 'Indicates whether an external audit or third-party assessment is required to verify compliance with this obligation. True if external audit is required, False otherwise.',
    `filing_frequency` STRING COMMENT 'Frequency at which regulatory filings or submissions are required for this obligation. Not applicable for ongoing conduct obligations.. Valid values are `annual|semi_annual|quarterly|monthly|event_based|not_applicable`',
    `governing_body` STRING COMMENT 'Name of the regulatory authority or governing body that mandates this obligation (e.g., American Bar Association, Solicitors Regulation Authority, Financial Action Task Force).',
    `is_active` BOOLEAN COMMENT 'Indicates whether this regulatory obligation is currently active and applicable to the firm. True if active, False if superseded or no longer applicable.',
    `jurisdiction` STRING COMMENT 'Three-letter ISO country code representing the jurisdiction where this obligation applies (e.g., USA, GBR, DEU).. Valid values are `^[A-Z]{3}$`',
    `last_assessment_date` DATE COMMENT 'Date when the most recent compliance assessment or audit was performed for this obligation.',
    `last_external_audit_date` DATE COMMENT 'Date when the most recent external audit or third-party assessment was conducted for this obligation. Null if no external audit has been performed.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory obligation record was last updated or modified.',
    `maximum_penalty_amount` DECIMAL(18,2) COMMENT 'Maximum monetary penalty or fine that can be imposed for non-compliance with this obligation, in the currency of the jurisdiction.',
    `next_external_audit_date` DATE COMMENT 'Scheduled date for the next external audit or third-party assessment of compliance with this obligation. Null if not applicable.',
    `next_filing_due_date` DATE COMMENT 'Due date for the next regulatory filing or submission required under this obligation. Null if not applicable.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next compliance review or assessment of this obligation.',
    `notes` STRING COMMENT 'Additional notes, comments, or context regarding this regulatory obligation, including any special considerations or historical information.',
    `obligation_category` STRING COMMENT 'Business category of the obligation (e.g., AML/KYC, Data Privacy, Professional Conduct, Financial Reporting, Client Protection, Professional Indemnity).',
    `obligation_code` STRING COMMENT 'Unique business identifier code for the regulatory obligation, used for external reference and reporting.. Valid values are `^[A-Z0-9]{3,20}$`',
    `obligation_description` STRING COMMENT 'Detailed description of the regulatory obligation, including scope, requirements, and applicability to the firm.',
    `obligation_name` STRING COMMENT 'Full name or title of the regulatory obligation as defined by the governing body.',
    `obligation_type` STRING COMMENT 'Classification of the obligation by its nature: periodic filing (regular submissions), ongoing conduct (continuous compliance), event-triggered (specific event response), registration, disclosure, or reporting.. Valid values are `periodic_filing|ongoing_conduct|event_triggered|registration|disclosure|reporting`',
    `penalty_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the maximum penalty amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `penalty_for_non_compliance` STRING COMMENT 'Description of penalties, sanctions, or consequences that may result from non-compliance with this obligation (e.g., fines, license suspension, disciplinary action).',
    `priority_level` STRING COMMENT 'Priority level assigned to this obligation for resource allocation and compliance planning (urgent, high, medium, low).. Valid values are `urgent|high|medium|low`',
    `regulatory_framework` STRING COMMENT 'Name of the regulatory framework or legislation under which this obligation falls (e.g., GDPR, CCPA, SOX, AML regulations, DPA).',
    `responsible_department` STRING COMMENT 'Department or business unit within the firm responsible for managing compliance with this obligation (e.g., Compliance, Risk Management, Legal Operations).',
    `responsible_officer` STRING COMMENT 'Name or title of the individual responsible for ensuring compliance with this obligation (e.g., Data Protection Officer, Chief Legal Officer, Compliance Partner).',
    `review_cycle` STRING COMMENT 'Frequency at which the firm must review and assess compliance with this obligation (e.g., annual, quarterly, continuous).. Valid values are `annual|semi_annual|quarterly|monthly|ad_hoc|continuous`',
    `risk_rating` STRING COMMENT 'Risk rating assigned to this obligation based on the potential impact of non-compliance on the firm (critical, high, medium, low).. Valid values are `critical|high|medium|low`',
    `source_legislation_url` STRING COMMENT 'URL or hyperlink to the official source legislation, regulation, or guidance document that defines this obligation.',
    `training_frequency` STRING COMMENT 'Frequency at which compliance training must be completed for this obligation. Not applicable if training is not required.. Valid values are `annual|semi_annual|quarterly|one_time|not_applicable`',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether mandatory training is required for personnel to ensure compliance with this obligation. True if training is required, False otherwise.',
    CONSTRAINT pk_regulatory_obligation PRIMARY KEY(`regulatory_obligation_id`)
) COMMENT 'Master registry of all regulatory obligations applicable to the firm across all jurisdictions of operation. Each obligation captures the governing body, jurisdiction, regulatory framework, obligation type (periodic filing, ongoing conduct, event-triggered), effective date, review cycle, current compliance status, and responsible officer. Serves as the authoritative catalog against which controls are designed, policies are written, training is mandated, and returns are filed. The single source of truth for answering what must we comply with?';

CREATE OR REPLACE TABLE `legal_ecm`.`compliance`.`control_framework` (
    `control_framework_id` BIGINT COMMENT 'Unique identifier for the compliance control framework record. Primary key.',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Control frameworks are implemented at practice area level (Lexcel for legal practice management, ISO 27001 for data-intensive practices). Practice areas adopt frameworks based on regulatory requiremen',
    `adoption_date` DATE COMMENT 'Date on which the firm formally adopted this control framework for compliance purposes. Marks the start of internal applicability.',
    `certification_body` STRING COMMENT 'Name of the accredited certification or audit body that conducts third-party assessments for this framework (e.g., BSI, UKAS, Big Four Audit Firm). Null if no certification is required.',
    `certification_required_flag` BOOLEAN COMMENT 'Indicates whether the firm is required to obtain third-party certification or attestation for compliance with this framework (e.g., ISO 27001 certification, SOC 2 audit). True if certification is mandatory or pursued; False otherwise.',
    `compliance_percentage` DECIMAL(18,2) COMMENT 'Current percentage of framework controls that are fully implemented and compliant, calculated as (compliant_controls / total_controls) * 100. Used for compliance dashboards and reporting.',
    `control_count` STRING COMMENT 'Total number of individual controls or requirements defined within this framework that the firm must implement and monitor. Derived from framework documentation.',
    `control_domain_mapping` STRING COMMENT 'Mapping of this framework to internal control domains or categories (e.g., Information Security, Data Privacy, Financial Controls, Ethical Conduct, Client Confidentiality). Pipe-separated if multiple domains.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this control framework record was first created in the system. Audit trail for data lineage.',
    `effective_from_date` DATE COMMENT 'Date from which the framework version became effective and enforceable within the firm. May differ from adoption_date if there was a transition period.',
    `effective_to_date` DATE COMMENT 'Date on which the framework version ceased to be effective, typically due to supersession by a newer version or decommissioning. Null if currently active.',
    `framework_code` STRING COMMENT 'Short alphanumeric code or abbreviation used to reference the framework internally (e.g., ISO27001, FATF40, SRA-CODE, GDPR-A32, SOX-COSO).',
    `framework_description` STRING COMMENT 'Detailed narrative description of the frameworks purpose, objectives, and key requirements. Provides business context for compliance teams.',
    `framework_name` STRING COMMENT 'Official name of the compliance control framework (e.g., ISO 27001, FATF 40 Recommendations, SRA Code of Conduct, GDPR Article 32 Technical and Organizational Measures, SOX COSO Framework).',
    `framework_status` STRING COMMENT 'Current lifecycle status of the framework within the firm: active (in force), superseded (replaced by newer version), retired (no longer applicable), under_review (being evaluated for adoption), pending_adoption (approved but not yet effective).. Valid values are `active|superseded|retired|under_review|pending_adoption`',
    `framework_type` STRING COMMENT 'Classification of the framework origin and authority: regulatory (mandated by law), industry_standard (voluntary consensus standard), internal (firm-developed), best_practice (guidance), certification (third-party audit), contractual (client-imposed).. Valid values are `regulatory|industry_standard|internal|best_practice|certification|contractual`',
    `framework_url` STRING COMMENT 'Web link to the official framework documentation, standard text, or regulatory guidance published by the issuing body.',
    `framework_version` STRING COMMENT 'Version or edition of the control framework (e.g., 2013, 2022, v4.0). Tracks updates and revisions to the framework standard.',
    `issuing_body` STRING COMMENT 'Name of the regulatory authority, standards organization, or governing body that published and maintains the framework (e.g., International Organization for Standardization, Financial Action Task Force, Solicitors Regulation Authority, European Commission).',
    `jurisdiction` STRING COMMENT 'Geographic or legal jurisdiction(s) where the framework applies (e.g., GBR, USA, EUR, Global). May be multi-valued pipe-separated for frameworks with broad applicability.',
    `last_certification_date` DATE COMMENT 'Date of the most recent successful certification or audit for this framework. Null if never certified or certification not required.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this control framework record. Audit trail for change tracking.',
    `last_review_date` DATE COMMENT 'Date of the most recent internal compliance review or assessment conducted for this framework.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether compliance with this framework is legally or contractually mandatory for the firm (True) or voluntary/best-practice (False).',
    `next_certification_due_date` DATE COMMENT 'Scheduled date for the next certification audit or recertification cycle. Used for compliance planning and audit scheduling.',
    `next_review_due_date` DATE COMMENT 'Scheduled date for the next internal compliance review or assessment of this framework. Used for compliance calendar and task management.',
    `notes` STRING COMMENT 'Free-text field for additional context, implementation notes, exceptions, or special considerations related to this framework. Used by compliance teams for operational documentation.',
    `review_frequency` STRING COMMENT 'Scheduled frequency at which the firms compliance with this framework is reviewed and assessed (e.g., annual, semi_annual, quarterly, monthly, ad_hoc, continuous monitoring).. Valid values are `annual|semi_annual|quarterly|monthly|ad_hoc|continuous`',
    `risk_rating` STRING COMMENT 'Assessed risk level associated with non-compliance with this framework: critical (severe legal/financial/reputational impact), high, medium, low. Informs prioritization of compliance activities.. Valid values are `critical|high|medium|low`',
    `scope_of_applicability` STRING COMMENT 'Description of the business functions, departments, practice areas, or data domains to which this framework applies (e.g., All Client Data Processing, Information Security, AML/KYC Program, Financial Reporting, Data Privacy for EU Clients).',
    CONSTRAINT pk_control_framework PRIMARY KEY(`control_framework_id`)
) COMMENT 'Master catalog of compliance control frameworks adopted by the firm (e.g., ISO 27001, FATF 40 Recommendations, SRA Code of Conduct, GDPR Article 32 measures, SOX COSO). Each record captures framework name, version, issuing body, adoption date, scope of applicability, and mapping to internal control domains. Provides the structural backbone against which individual controls are designed, tested, and audited.';

CREATE OR REPLACE TABLE `legal_ecm`.`compliance`.`compliance_control` (
    `compliance_control_id` BIGINT COMMENT 'Unique identifier for the compliance control record. Primary key for the compliance control entity.',
    `control_framework_id` BIGINT COMMENT 'FK to compliance.control_framework.control_framework_id — Every control must reference its parent framework — this is the fundamental structural relationship in control management. Without this FK, you cannot answer which controls implement ISO 27001? whic',
    `doc_template_id` BIGINT COMMENT 'Foreign key linking to document.doc_template. Business justification: Control evidence documentation process: compliance controls specify the document template used to collect and record control testing evidence (e.g., a checklist template for a specific control). Compl',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Compliance controls are designed to implement internal compliance policies. A control belongs to a policy (e.g., an AML control implements the AML policy). This 1:N relationship (one policy governs ma',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Controls are designed for specific practice areas (conflict checks in M&A, privilege logs in litigation). Control frameworks are practice-area-scoped. Required for practice-area-level control effectiv',
    `primary_compliance_control_framework_id` BIGINT COMMENT 'Reference to the parent compliance framework (e.g., SOX, ISO 27001, GDPR, SRA Code of Conduct) under which this control is defined. Links to the compliance_framework product.',
    `regulatory_obligation_id` BIGINT COMMENT 'Reference to the specific regulatory obligation or requirement that this control is designed to satisfy. Links to the compliance_obligation product.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.register. Business justification: Compliance controls are implemented to mitigate specific risk register entries. Legal compliance auditors producing control-to-risk mapping reports and risk treatment evidence require this direct link',
    `to_control_framework_id` BIGINT COMMENT 'FK to compliance.control_framework.control_framework_id — Every control must belong to a control framework. This is the fundamental parent-child relationship in control management — controls are designed WITHIN a framework. Without this FK, the control inven',
    `to_regulatory_obligation_id` BIGINT COMMENT 'FK to compliance.regulatory_obligation.regulatory_obligation_id — Controls exist to satisfy regulatory obligations. This many-to-many relationship (or FK to primary obligation) is essential for demonstrating regulatory coverage and identifying gaps. Required for any',
    `compensating_control_flag` BOOLEAN COMMENT 'Indicates whether this control serves as a compensating control for another control that is ineffective or not feasible. True if this control mitigates risk in lieu of a primary control; false otherwise.',
    `control_description` STRING COMMENT 'Comprehensive narrative description of how the control operates, including the procedures, systems, and personnel involved. Provides operational detail for control execution and testing.',
    `control_status` STRING COMMENT 'Current operational status of the control within the firms control framework. Active controls are currently enforced; inactive controls are not operational; suspended controls are temporarily paused; under_review indicates controls being assessed for effectiveness; retired controls are no longer applicable.. Valid values are `active|inactive|suspended|under_review|retired`',
    `control_type` STRING COMMENT 'Classification of the control based on its operational nature: preventive (stops issues before they occur), detective (identifies issues after occurrence), corrective (remediates identified issues), or directive (provides guidance and policy).. Valid values are `preventive|detective|corrective|directive`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this control record was first created in the system. Used for audit trail and data lineage purposes.',
    `documentation_reference` STRING COMMENT 'Reference to supporting documentation for the control, including policies, procedures, system configurations, and evidence repositories. May include document management system (DMS) identifiers or file paths.',
    `effective_from_date` DATE COMMENT 'Date when the control became operational and enforceable within the firm. Used to track control lifecycle and determine testing scope for audit periods.',
    `effective_to_date` DATE COMMENT 'Date when the control was retired or superseded. Null for active controls. Used for historical analysis and audit trail purposes.',
    `effectiveness_rating` STRING COMMENT 'Overall assessment of control effectiveness based on testing history, exception trends, and management evaluation. Used for control maturity reporting and prioritizing control enhancements.. Valid values are `highly_effective|effective|needs_improvement|ineffective`',
    `exception_count` STRING COMMENT 'Number of exceptions or control failures identified during the most recent control test. Exceptions represent instances where the control did not operate as designed or failed to achieve its objective.',
    `exception_description` STRING COMMENT 'Detailed narrative of any exceptions or control failures identified during testing, including root cause analysis, impact assessment, and context. Used for remediation planning and management reporting.',
    `frequency` STRING COMMENT 'Frequency at which the control is executed or reviewed. Continuous controls operate in real-time; event-driven controls are triggered by specific business events (e.g., new client intake, matter opening). [ENUM-REF-CANDIDATE: continuous|daily|weekly|monthly|quarterly|annually|event_driven — 7 candidates stripped; promote to reference product]',
    `gdpr_article_reference` STRING COMMENT 'Reference to the specific GDPR article(s) that this control addresses (e.g., Article 32 for Security of Processing, Article 25 for Data Protection by Design). Used for GDPR compliance documentation and Data Protection Officer (DPO) reporting.',
    `identifier` STRING COMMENT 'External business identifier for the control, typically following framework naming conventions (e.g., SOX-001, ISO-27001-A.5.1, SRA-COMP-042). Used for cross-referencing with audit documentation and regulatory submissions.. Valid values are `^[A-Z]{2,6}-[0-9]{3,5}$`',
    `iso_27001_control_reference` STRING COMMENT 'Reference to the corresponding ISO 27001:2013 Annex A control (e.g., A.9.2.1 for User Registration, A.18.1.1 for Identification of Applicable Legislation). Used for ISO 27001 certification and audit mapping.. Valid values are `^A.[0-9]{1,2}.[0-9]{1,2}$`',
    `key_control_flag` BOOLEAN COMMENT 'Indicates whether this control is designated as a key control within the firms control framework. Key controls are those that directly address significant risks and require enhanced monitoring and testing.',
    `last_test_conclusion` STRING COMMENT 'Outcome of the most recent control test. Effective indicates the control operated as designed with no exceptions; ineffective indicates control failures or design deficiencies; partially_effective indicates minor exceptions that do not materially impact control objective.. Valid values are `effective|ineffective|partially_effective|not_tested`',
    `last_test_date` DATE COMMENT 'Date when the control was most recently tested for design and operating effectiveness. Used to track testing currency and plan future testing cycles.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this control record was last modified. Used for audit trail, change tracking, and data quality monitoring.',
    `nature` STRING COMMENT 'Indicates whether the control is executed manually by personnel, automated through system processes, or a hybrid combination requiring both human and system intervention.. Valid values are `manual|automated|hybrid`',
    `next_test_due_date` DATE COMMENT 'Scheduled date for the next control test based on control frequency, risk rating, and regulatory requirements. Used for test planning and resource allocation.',
    `objective` STRING COMMENT 'Detailed statement of the controls intended outcome and the risk it is designed to mitigate. Describes what the control is meant to achieve in terms of regulatory compliance, risk reduction, or operational assurance.',
    `procedure` STRING COMMENT 'Step-by-step procedural instructions for executing the control, including specific actions, system interactions, approval workflows, and documentation requirements. Used by control operators and auditors.',
    `remediation_due_date` DATE COMMENT 'Target date by which remediation actions must be completed. Used for tracking remediation progress and escalating overdue items to management or audit committees.',
    `remediation_plan` STRING COMMENT 'Detailed plan for addressing identified control deficiencies, including specific corrective actions, responsible parties, timelines, and success criteria. Used to track remediation progress and closure.',
    `remediation_required_flag` BOOLEAN COMMENT 'Indicates whether remediation actions are required based on test results. True if control deficiencies or exceptions require corrective action; false if control is operating effectively.',
    `remediation_status` STRING COMMENT 'Current status of remediation efforts for identified control deficiencies. Tracks progress from identification through completion and validation of corrective actions.. Valid values are `not_started|in_progress|completed|overdue|cancelled`',
    `risk_rating` STRING COMMENT 'Assessment of the risk level associated with control failure or ineffectiveness. Critical and high ratings indicate controls that mitigate significant regulatory, financial, or reputational risks; low ratings indicate controls with limited impact if they fail.. Valid values are `critical|high|medium|low`',
    `sample_size` STRING COMMENT 'Number of control instances or transactions examined during the most recent control test. Used to assess the statistical validity of test conclusions and determine whether sample size meets audit standards.',
    `sox_scoping_flag` BOOLEAN COMMENT 'Indicates whether this control is in scope for SOX Section 404 compliance testing. True if the control is material to financial reporting and requires annual testing; false if out of scope.',
    `sra_standard_reference` STRING COMMENT 'Reference to the SRA Standards and Regulations that this control supports (e.g., SRA Accounts Rules, SRA Code of Conduct for Firms). Used for SRA regulatory returns and compliance reporting.',
    `testing_methodology` STRING COMMENT 'Method used to test the controls design and operating effectiveness. Walkthrough involves tracing a transaction through the control process; reperformance involves independently executing the control; sample testing involves examining a subset of control instances. [ENUM-REF-CANDIDATE: walkthrough|inquiry|observation|inspection|reperformance|sample_testing|analytical_review — 7 candidates stripped; promote to reference product]',
    `title` STRING COMMENT 'Short descriptive title of the control objective, providing a human-readable summary of the control purpose (e.g., Segregation of Duties for Financial Transactions, Client Data Encryption at Rest).',
    `utbms_task_code` STRING COMMENT 'UTBMS task code alignment for controls related to legal service delivery and billing. Enables mapping of compliance activities to client matters and billing structures. Example codes: L110 (Legal Research), A101 (Case Management).. Valid values are `^[A-Z][0-9]{3}$`',
    CONSTRAINT pk_compliance_control PRIMARY KEY(`compliance_control_id`)
) COMMENT 'Individual internal controls and their testing evidence, designed to satisfy regulatory obligations within a given framework. Control attributes capture identifier, objective, type (preventive, detective, corrective), owner, frequency, testing methodology, and UTBMS alignment. Testing attributes capture test date, tester, methodology (walkthrough, sample testing, re-performance), sample size, exceptions, test conclusion (effective/ineffective), and remediation flags. Serves as the SSOT for the firms control inventory and assurance evidence, supporting SOX, ISO 27001, and SRA compliance programmes.';

CREATE OR REPLACE TABLE `legal_ecm`.`compliance`.`aml_kyc_program` (
    `aml_kyc_program_id` BIGINT COMMENT 'Unique identifier for the firms AML/KYC program record. Primary key.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: The AML/KYC program implements the firms AML policy. N:1 relationship (many program versions per policy over time). Strengthens policy connections and helps resolve aml_kyc_program silo. No columns to',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: AML/KYC programs vary by practice area (corporate/transactional vs. litigation). Different risk profiles and regulatory requirements apply. MLRO designs practice-area-specific risk assessments, screen',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: An AML/KYC program is established to satisfy specific regulatory obligations (e.g., FATF 40 Recommendations, POCA 2002, EU AMLD). Linking the program to its primary governing regulatory obligation ena',
    `applicable_jurisdictions` STRING COMMENT 'Comma-separated list of jurisdictions (ISO 3166-1 alpha-3 codes) where the AML/KYC program applies.',
    `audit_findings_summary` STRING COMMENT 'Summary of findings and recommendations from the most recent independent audit of the AML/KYC program.',
    `board_approval_date` DATE COMMENT 'Date when the firms board or governing body approved the AML/KYC program.',
    `client_risk_rating` STRING COMMENT 'Overall risk rating for client-related AML/KYC risks based on the most recent assessment.. Valid values are `low|medium|high|very_high`',
    `control_effectiveness_rating` STRING COMMENT 'Assessment of the effectiveness of AML/KYC controls and procedures in mitigating identified risks.. Valid values are `effective|partially_effective|ineffective|not_tested`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the AML/KYC program record was first created in the system.',
    `delivery_channel_risk_rating` STRING COMMENT 'Overall risk rating for delivery channel-related AML/KYC risks (e.g., remote onboarding, in-person) based on the most recent assessment.. Valid values are `low|medium|high|very_high`',
    `effective_date` DATE COMMENT 'Date when the AML/KYC program became or will become operationally effective.',
    `expiry_date` DATE COMMENT 'Date when the AML/KYC program expires or requires renewal, if applicable.',
    `geographic_risk_rating` STRING COMMENT 'Overall risk rating for geographic/jurisdictional AML/KYC risks based on the most recent assessment.. Valid values are `low|medium|high|very_high`',
    `inherent_risk_rating` STRING COMMENT 'Overall inherent AML/KYC risk rating before considering mitigating controls.. Valid values are `low|medium|high|very_high`',
    `last_audit_date` DATE COMMENT 'Date when the most recent independent audit of the AML/KYC program was completed.',
    `last_risk_assessment_date` DATE COMMENT 'Date when the most recent enterprise-wide AML/KYC risk assessment was completed.',
    `last_updated_by` STRING COMMENT 'Name or identifier of the user who last updated the AML/KYC program record.',
    `mlro_email` STRING COMMENT 'Official email address of the Money Laundering Reporting Officer for regulatory communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `mlro_name` STRING COMMENT 'Full name of the designated Money Laundering Reporting Officer responsible for the AML/KYC program.',
    `mlro_phone` STRING COMMENT 'Direct contact phone number for the Money Laundering Reporting Officer.',
    `next_audit_due_date` DATE COMMENT 'Scheduled date for the next independent audit of the AML/KYC program.',
    `next_risk_assessment_due_date` DATE COMMENT 'Scheduled date for the next mandatory enterprise-wide AML/KYC risk assessment.',
    `product_service_risk_rating` STRING COMMENT 'Overall risk rating for product and service-related AML/KYC risks based on the most recent assessment.. Valid values are `low|medium|high|very_high`',
    `program_name` STRING COMMENT 'Official name or title of the AML/KYC program as registered with regulatory authorities.',
    `program_scope` STRING COMMENT 'Detailed description of the scope of the AML/KYC program, including covered business lines, matter types, and jurisdictions.',
    `program_status` STRING COMMENT 'Current lifecycle status of the AML/KYC program indicating its operational state.. Valid values are `draft|active|under_review|suspended|archived`',
    `program_version` STRING COMMENT 'Version identifier for the AML/KYC program, tracking iterations and updates over time.',
    `regulatory_approval_date` DATE COMMENT 'Date when the AML/KYC program received regulatory approval or acknowledgment.',
    `regulatory_approval_status` STRING COMMENT 'Status of regulatory approval or acknowledgment of the AML/KYC program by relevant authorities.. Valid values are `pending|approved|conditionally_approved|rejected|not_required`',
    `residual_risk_rating` STRING COMMENT 'Overall residual AML/KYC risk rating after applying mitigating controls and procedures.. Valid values are `low|medium|high|very_high`',
    `risk_appetite_statement` STRING COMMENT 'Formal statement defining the firms tolerance for AML/KYC risk across client types, geographies, and service lines.',
    `risk_assessment_frequency` STRING COMMENT 'Frequency at which enterprise-wide AML/KYC risk assessments are conducted.. Valid values are `annual|biannual|quarterly|ad_hoc|event_driven`',
    `risk_methodology` STRING COMMENT 'Description of the methodology, framework, or standard used to conduct the AML/KYC risk assessment.',
    `suspicious_activity_reports_filed` STRING COMMENT 'Total number of Suspicious Activity Reports filed under this program during the current reporting period.',
    `training_completion_rate` DECIMAL(18,2) COMMENT 'Percentage of required staff who have completed mandatory AML/KYC training as of the last assessment date.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the AML/KYC program record was last modified.',
    CONSTRAINT pk_aml_kyc_program PRIMARY KEY(`aml_kyc_program_id`)
) COMMENT 'Master record for the firms AML/KYC programme including enterprise-wide and matter-type-level risk assessments, as required by FATF obligations and jurisdiction-specific AML legislation. Programme attributes capture MLRO designation, programme scope, risk appetite, regulatory approval status, and applicable jurisdictions. Risk assessment attributes capture assessment date, assessor, risk categories (client, geographic, product/service, delivery channel), inherent and residual risk ratings, methodology, and findings. Provides the complete firm-level AML governance artifact distinct from individual client KYC checks owned by conflict/intake.';

CREATE OR REPLACE TABLE `legal_ecm`.`compliance`.`sar_filing` (
    `sar_filing_id` BIGINT COMMENT 'Unique identifier for the SAR filing record. Primary key.',
    `legal_document_id` BIGINT COMMENT 'Foreign key linking to document.legal_document. Business justification: SAR submissions are formal regulatory filings: NCA SAR Online submission, consent request to NCA, DAML/DAPOL defense documentation. Required for linking SAR register to actual filing documents for reg',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: SAR filings must be traceable to the specific legal service that triggered the suspicious activity (e.g., conveyancing, trust formation, corporate M&A). SRA and FATF AML guidance requires service-leve',
    `matter_id` BIGINT COMMENT 'Reference to the matter or engagement associated with the suspicious activity, if applicable.',
    `organisation_id` BIGINT COMMENT 'Foreign key linking to client.organisation. Business justification: SAR filings relate to suspicious activity by a subject entity — frequently a corporate organisation rather than an individual profile. Legal firms must link SARs directly to the client organisation fo',
    `aml_kyc_program_id` BIGINT COMMENT 'FK to compliance.aml_kyc_program.aml_kyc_program_id — SAR filings are made under the authority of the AML programme and by the MLRO designated in that programme. This link is essential for programme-level reporting on SAR activity.',
    `profile_id` BIGINT COMMENT 'Reference to the client involved in the suspicious activity, if applicable.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.register. Business justification: SAR filings represent crystallised AML risk events that must be logged in the risk register. Legal firms MLRO processes require each SAR to be traceable to a risk register entry for regulatory audit ',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: SAR filings are submitted under specific regulatory obligations (e.g., POCA 2002 s.330, TACT 2000 s.19, EU AMLD Article 33). Linking each SAR filing to the regulatory obligation that mandates it provi',
    `acknowledgment_date` DATE COMMENT 'Date on which the financial intelligence unit acknowledged receipt of the SAR.',
    `acknowledgment_reference` STRING COMMENT 'Reference number or confirmation code provided by the financial intelligence unit upon acknowledgment of the SAR.',
    `consent_outcome` STRING COMMENT 'Outcome of the Defence Against Money Laundering (DAML) consent request: granted, refused, or no response within statutory period.. Valid values are `granted|refused|no_response|not_applicable`',
    `consent_outcome_date` DATE COMMENT 'Date on which the consent outcome was received or the statutory notice period expired.',
    `consent_request_date` DATE COMMENT 'Date on which consent was requested from the financial intelligence unit to proceed with the transaction.',
    `consent_request_flag` BOOLEAN COMMENT 'Indicates whether the SAR includes a request for consent to proceed with the transaction (Defence Against Money Laundering - DAML).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the SAR filing record was first created in the system.',
    `filing_authority` STRING COMMENT 'Name of the financial intelligence unit or regulatory authority to which the SAR was submitted (e.g., National Crime Agency, FinCEN).',
    `filing_date` DATE COMMENT 'Date on which the SAR was officially submitted to the financial intelligence unit.',
    `filing_jurisdiction` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the jurisdiction to which the SAR was filed (e.g., GBR for UK NCA, USA for FinCEN). [ENUM-REF-CANDIDATE: GBR|USA|CAN|AUS|DEU|FRA|NLD|CHE — 8 candidates stripped; promote to reference product]',
    `filing_status` STRING COMMENT 'Current status of the SAR filing in its lifecycle from draft through submission and acknowledgment.. Valid values are `draft|pending_review|submitted|acknowledged|rejected|withdrawn`',
    `filing_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the SAR was submitted to the financial intelligence unit.',
    `follow_up_action_description` STRING COMMENT 'Description of any follow-up actions taken or required by the firm in response to the SAR filing.',
    `follow_up_action_required` BOOLEAN COMMENT 'Indicates whether follow-up action is required by the firm (e.g., enhanced due diligence, relationship termination).',
    `internal_reference_number` STRING COMMENT 'Internal tracking reference number assigned by the firm for SAR management and audit purposes.',
    `internal_report_date` DATE COMMENT 'Date on which the suspicious activity was first reported internally to the MLRO or compliance team.',
    `law_enforcement_reference` STRING COMMENT 'Reference number or case identifier provided by law enforcement if the SAR leads to an investigation or prosecution.',
    `mlro_name` STRING COMMENT 'Full name of the MLRO who authorized the SAR filing.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the SAR filing record was last modified or updated.',
    `relationship_terminated_flag` BOOLEAN COMMENT 'Indicates whether the client or matter relationship was terminated as a result of the suspicious activity.',
    `relationship_termination_date` DATE COMMENT 'Date on which the client or matter relationship was terminated following the SAR filing.',
    `reporter_name` STRING COMMENT 'Full name of the individual who initially identified and reported the suspicious activity internally.',
    `retention_expiry_date` DATE COMMENT 'Date on which the SAR record is eligible for deletion or archival per regulatory retention requirements (typically 5-7 years post-filing).',
    `review_notes` STRING COMMENT 'Internal notes and commentary from the MLRO or compliance team regarding the review and decision to file the SAR.',
    `sar_reference_number` STRING COMMENT 'Official reference number assigned by the financial intelligence unit (e.g., NCA, FinCEN) upon submission of the SAR.',
    `subject_identifier_type` STRING COMMENT 'Type of identifier used to identify the subject of the SAR (e.g., passport number, company registration number).. Valid values are `passport|national_id|company_registration|tax_id|other`',
    `subject_identifier_value` DECIMAL(18,2) COMMENT 'The actual identifier value for the subject (e.g., passport number, company registration number), stored securely.',
    `subject_name_anonymised` STRING COMMENT 'Anonymised or pseudonymised name of the individual or organisation that is the subject of the SAR, for internal audit trail purposes.',
    `subject_type` STRING COMMENT 'Type of entity that is the subject of the suspicious activity report.. Valid values are `individual|organisation|trust|partnership|other`',
    `suspicion_category` STRING COMMENT 'Primary category of suspicious activity being reported (e.g., money laundering, terrorist financing, fraud).. Valid values are `money_laundering|terrorist_financing|fraud|bribery_corruption|sanctions_breach|tax_evasion`',
    `suspicion_grounds` STRING COMMENT 'Detailed narrative describing the grounds for suspicion, including red flags, unusual patterns, and rationale for filing the SAR.',
    `tipping_off_risk_flag` BOOLEAN COMMENT 'Indicates whether there is a risk of tipping off the subject if certain actions are taken, requiring special handling.',
    `transaction_amount` DECIMAL(18,2) COMMENT 'Monetary value of the suspicious transaction or cumulative value of related transactions.',
    `transaction_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the transaction amount (e.g., GBP, USD, EUR).. Valid values are `^[A-Z]{3}$`',
    `transaction_date` DATE COMMENT 'Date on which the suspicious transaction or activity occurred or was first identified.',
    `transaction_reference` STRING COMMENT 'Reference number or identifier of the specific transaction or series of transactions that triggered the SAR.',
    CONSTRAINT pk_sar_filing PRIMARY KEY(`sar_filing_id`)
) COMMENT 'Suspicious Activity Report (SAR) filings submitted to the relevant financial intelligence unit (e.g., NCA in the UK, FinCEN in the US) by the firms MLRO. Captures SAR reference number, filing date, subject details (anonymised), transaction or matter reference, suspicion grounds, consent request status, defence against money laundering (DAML) consent outcome, and filing jurisdiction. Critical for FATF and AML regulatory compliance audit trails.';

CREATE OR REPLACE TABLE `legal_ecm`.`compliance`.`data_privacy_register` (
    `data_privacy_register_id` BIGINT COMMENT 'Unique identifier for the data privacy register entry. Primary key. Inferred role: MASTER_RESOURCE (registry entry for processing activity or DPIA). _canonical_skip_reason: Not applicable - this is a hybrid master/reference entity combining RoPA and DPIA entries; minimum categories applied as MASTER_RESOURCE.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Processing activities in the data privacy register are governed by the firms data privacy policy. N:1 relationship (many processing activities per policy). Strengthens policy connections. No columns t',
    `delivery_model_id` BIGINT COMMENT 'Foreign key linking to service.delivery_model. Business justification: GDPR Article 30 and Chapter V obligations (third-country transfers, SCCs) are directly triggered by the delivery model used (e.g., offshore LPO delivery). Linking delivery_model to data_privacy_regist',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: GDPR Article 30 records of processing activities must be linked to the specific legal service driving the processing (e.g., e-discovery, due diligence). Service-level DPIA triggers and data subject ri',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: ROPA entries are practice-area-specific (client data processing in employment law, IP portfolio data in patent practice). Processing activities vary by practice area. DPO requires practice-area-level ',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Data privacy processing activities in the register are governed by specific regulatory obligations (GDPR Article 30, CCPA, DPA 2018). Linking each register entry to its governing regulatory obligation',
    `controller_contact_email` STRING COMMENT 'Email address of the data controller contact person.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `controller_contact_name` STRING COMMENT 'Name of the representative or contact person for the data controller.',
    `controller_name` STRING COMMENT 'Legal name of the data controller responsible for determining the purposes and means of processing. Typically the law firm or its legal entity.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this register entry was first created in the system.',
    `data_privacy_register_status` STRING COMMENT 'Current lifecycle status of the register entry: draft (being prepared), active (in force), under_review (periodic review or audit), suspended (temporarily inactive), archived (historical record).. Valid values are `draft|active|under_review|suspended|archived`',
    `data_subject_categories` STRING COMMENT 'Categories of individuals whose personal data is processed (e.g., clients, employees, opposing parties, witnesses, vendors, job applicants). Pipe-separated list.',
    `dpia_completion_date` DATE COMMENT 'Date on which the DPIA was completed, if applicable.',
    `dpia_mitigation_measures` STRING COMMENT 'Measures envisaged to address the identified risks, including safeguards, security measures, and mechanisms to ensure protection of personal data, as required under GDPR Article 35(7)(d).',
    `dpia_required_flag` BOOLEAN COMMENT 'Indicates whether a DPIA is required for this processing activity under GDPR Article 35 (high risk to rights and freedoms of data subjects).',
    `dpia_trigger_reason` STRING COMMENT 'Reason why a DPIA is required, if dpia_required_flag is true (e.g., systematic monitoring, large-scale processing of special category data, automated decision-making with legal effects).',
    `dpo_consultation_date` DATE COMMENT 'Date on which the Data Protection Officer was consulted regarding the DPIA, as required under GDPR Article 35(2).',
    `dpo_consultation_outcome` STRING COMMENT 'Summary of the DPOs advice and recommendations following consultation on the DPIA.',
    `dpo_contact_email` STRING COMMENT 'Email address of the Data Protection Officer for inquiries and consultation.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `dpo_name` STRING COMMENT 'Name of the Data Protection Officer responsible for overseeing this processing activity and ensuring GDPR compliance.',
    `entry_type` STRING COMMENT 'Type of privacy register entry: Record of Processing Activities (RoPA) under GDPR Article 30, Data Protection Impact Assessment (DPIA) under GDPR Article 35, or combined entry covering both.. Valid values are `ropa|dpia|combined`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this register entry was last modified.',
    `last_review_date` DATE COMMENT 'Date of the most recent review of this register entry.',
    `legal_basis` STRING COMMENT 'The lawful basis under GDPR Article 6 for processing personal data: consent, contract performance, legal obligation, vital interests, public task, or legitimate interests.. Valid values are `consent|contract|legal_obligation|vital_interests|public_task|legitimate_interests`',
    `legitimate_interest_description` STRING COMMENT 'Detailed explanation of the legitimate interests pursued by the controller or third party, if legal_basis is legitimate_interests. Required under GDPR Article 6(1)(f).',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review of this register entry.',
    `organizational_security_measures` STRING COMMENT 'Description of organizational security measures implemented to protect personal data (e.g., staff training, access policies, data breach response procedures, confidentiality agreements).',
    `personal_data_categories` STRING COMMENT 'Categories of personal data being processed (e.g., identification data, contact details, financial information, employment records, legal case details). Pipe-separated list.',
    `processing_activity_code` STRING COMMENT 'Unique business identifier or reference code for the processing activity, used for cross-referencing with operational systems and audit trails.',
    `processing_activity_name` STRING COMMENT 'Human-readable name of the data processing activity (e.g., Client Onboarding KYC, Matter Document Management, Employee Performance Review).',
    `processing_purpose` STRING COMMENT 'Detailed description of the purposes of the data processing activity (e.g., client conflict checking, matter billing, employee recruitment, regulatory reporting).',
    `recipient_categories` STRING COMMENT 'Categories of recipients to whom personal data may be disclosed (e.g., courts, regulators, external counsel, IT service providers, cloud storage vendors). Pipe-separated list.',
    `retention_justification` STRING COMMENT 'Business or legal justification for the retention period, including references to applicable statutes of limitation, regulatory requirements, or legitimate business needs.',
    `retention_period` STRING COMMENT 'The time period for which personal data will be retained, or the criteria used to determine that period (e.g., 7 years post-matter closure, duration of employment plus 6 years).',
    `review_frequency` STRING COMMENT 'Frequency at which this register entry and associated DPIA (if applicable) are reviewed and updated.. Valid values are `annual|biannual|quarterly|ad_hoc|continuous`',
    `special_category_data_flag` BOOLEAN COMMENT 'Indicates whether the processing involves special categories of personal data under GDPR Article 9 (e.g., racial/ethnic origin, health data, biometric data, criminal convictions).',
    `special_category_data_types` STRING COMMENT 'Specific types of special category data processed, if special_category_data_flag is true (e.g., health, racial origin, criminal convictions). Pipe-separated list.',
    `supervisory_authority_consultation_date` DATE COMMENT 'Date on which the supervisory authority was consulted, if supervisory_authority_consultation_required_flag is true.',
    `supervisory_authority_consultation_required_flag` BOOLEAN COMMENT 'Indicates whether prior consultation with the supervisory authority is required under GDPR Article 36 (when DPIA indicates high residual risk).',
    `supervisory_authority_response` STRING COMMENT 'Summary of the supervisory authoritys response and any conditions or recommendations provided.',
    `technical_security_measures` STRING COMMENT 'Description of technical security measures implemented to protect personal data (e.g., encryption at rest and in transit, access controls, multi-factor authentication, pseudonymization).',
    `third_country_names` STRING COMMENT 'Names of third countries or international organizations to which data is transferred, if third_country_transfer_flag is true. Pipe-separated list of ISO 3166-1 alpha-3 country codes.',
    `third_country_transfer_flag` BOOLEAN COMMENT 'Indicates whether personal data is transferred to a third country or international organization outside the EEA.',
    `transfer_safeguard_details` STRING COMMENT 'Additional details about the transfer safeguard mechanism, including reference to documentation or approval decisions.',
    `transfer_safeguard_mechanism` STRING COMMENT 'The safeguard mechanism used for third country transfers: adequacy decision, standard contractual clauses (SCCs), binding corporate rules (BCRs), certification, code of conduct, or other approved mechanism.. Valid values are `adequacy_decision|standard_contractual_clauses|binding_corporate_rules|certification|code_of_conduct|other`',
    CONSTRAINT pk_data_privacy_register PRIMARY KEY(`data_privacy_register_id`)
) COMMENT 'Unified data privacy compliance register combining the Record of Processing Activities (RoPA) under GDPR Article 30 with Data Protection Impact Assessments (DPIAs) under Article 35. RoPA entries document processing activities, legal bases, data categories, subjects, retention periods, processors, and transfer mechanisms. DPIA entries document assessment triggers, necessity analysis, risk identification, mitigation measures, DPO consultation outcomes, and supervisory authority consultation requirements. Managed by the DPO function as the authoritative privacy compliance artifact.';

CREATE OR REPLACE TABLE `legal_ecm`.`compliance`.`control_test` (
    `control_test_id` BIGINT COMMENT 'Unique identifier for the control test record. Primary key.',
    `assessment_id` BIGINT COMMENT 'Foreign key linking to risk.assessment. Business justification: Control tests are performed as part of risk assessments. When a risk assessment is conducted, the compliance control tests executed in scope must be traceable to the assessment record — required for i',
    `compliance_control_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_control. Business justification: A compliance control test must reference the specific compliance control being tested. This is a critical missing relationship - tests without control references lack traceability. The FK will be popu',
    `legal_document_id` BIGINT COMMENT 'Foreign key linking to document.legal_document. Business justification: Control testing evidence management: compliance control tests produce evidence documents (test workpapers, sample results) stored in the DMS. The test record must reference the evidence document for a',
    `compliance_framework` STRING COMMENT 'The regulatory or compliance framework under which this control test is being performed. SOX (Sarbanes-Oxley Act) for financial controls, ISO 27001 for information security, GDPR (General Data Protection Regulation) for data privacy, SRA (Solicitors Regulation Authority) for legal practice compliance, FATF (Financial Action Task Force) for anti-money laundering. [ENUM-REF-CANDIDATE: sox|iso_27001|gdpr|ccpa|sra|fatf|pci_dss|aml|kyc — 9 candidates stripped; promote to reference product]',
    `control_deficiency_severity` STRING COMMENT 'Classification of the severity of any control deficiency identified during testing. Material weakness is a deficiency that results in a reasonable possibility of material misstatement. Significant deficiency is less severe than a material weakness but important enough to merit attention. Deficiency is a control shortcoming that does not rise to the level of significant deficiency.. Valid values are `none|deficiency|significant_deficiency|material_weakness`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this control test record was first created in the system.',
    `evidence_reference` STRING COMMENT 'Reference to the audit evidence or documentation supporting the test results. May include document identifiers, file paths, or workpaper references.',
    `exception_details` STRING COMMENT 'Detailed description of any exceptions or control failures identified during testing, including root cause analysis and potential impact.',
    `exception_rate_percentage` DECIMAL(18,2) COMMENT 'The calculated percentage of exceptions relative to the sample size. Expressed as a percentage (e.g., 2.50 for 2.5%). Used to assess control effectiveness and project population error rates.',
    `exceptions_identified_count` STRING COMMENT 'The number of exceptions, deviations, or control failures identified during testing. An exception occurs when the control did not operate as designed or was not performed.',
    `external_auditor_flag` BOOLEAN COMMENT 'Indicates whether this test was performed by an external auditor (True) or internal compliance/audit team (False).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this control test record was last updated or modified.',
    `notes` STRING COMMENT 'Additional notes, comments, or observations related to the control test that do not fit into other structured fields.',
    `population_size` STRING COMMENT 'The total number of items or transactions in the population from which the sample was drawn. Used to calculate sampling risk and exception rates.',
    `remediation_due_date` DATE COMMENT 'The target date by which identified control deficiencies must be remediated. Set by compliance or audit management based on deficiency severity.',
    `remediation_required_flag` BOOLEAN COMMENT 'Indicates whether remediation actions are required to address control deficiencies identified during testing. True if remediation is needed, False otherwise.',
    `review_date` DATE COMMENT 'The date on which the test results were reviewed and approved by the reviewer.',
    `risk_rating` STRING COMMENT 'The risk level associated with the control being tested. Higher risk controls typically require more frequent and rigorous testing.. Valid values are `critical|high|medium|low`',
    `sample_size` STRING COMMENT 'The number of items or transactions selected for testing. For sample-based testing, this represents the population subset examined. For non-sample tests (e.g., walkthrough), this may be 1 or null.',
    `sampling_method` STRING COMMENT 'The statistical or non-statistical approach used to select the sample from the population. [ENUM-REF-CANDIDATE: random|systematic|stratified|judgmental|haphazard|monetary_unit|attribute — 7 candidates stripped; promote to reference product]',
    `test_completion_date` DATE COMMENT 'The date on which all testing procedures were completed and results were finalized.',
    `test_conclusion` STRING COMMENT 'The overall conclusion reached by the tester regarding the effectiveness of the control based on test results. Effective means the control is operating as designed with no material exceptions. Ineffective means the control has failed or has material exceptions. Partially effective indicates some deficiencies but not material failures.. Valid values are `effective|ineffective|partially_effective|not_tested|inconclusive`',
    `test_date` DATE COMMENT 'The date on which the control test was performed. This is the principal business event timestamp for the test activity.',
    `test_methodology` STRING COMMENT 'The specific audit procedure or technique used to test the control. Walkthrough involves tracing a transaction through the process. Inquiry involves asking questions of personnel. Observation involves watching the control being performed. Inspection involves examining documents or records. Reperformance involves independently executing the control. [ENUM-REF-CANDIDATE: walkthrough|inquiry|observation|inspection_of_documents|inspection_of_records|reperformance|analytical_procedures|sample_testing — 8 candidates stripped; promote to reference product]',
    `test_objective` STRING COMMENT 'A description of the specific objective or assertion being tested. Defines what the test is intended to validate about the control (e.g., completeness, accuracy, authorization, existence).',
    `test_period_end_date` DATE COMMENT 'The ending date of the period covered by this control test. For operating effectiveness tests, defines the end of the observation window.',
    `test_period_start_date` DATE COMMENT 'The beginning date of the period covered by this control test. For operating effectiveness tests, defines the start of the observation window.',
    `test_procedure_description` STRING COMMENT 'Detailed narrative description of the specific procedures performed during the test, including steps taken, evidence examined, and criteria applied.',
    `test_reference_number` STRING COMMENT 'Business-facing unique reference number for the control test, used in audit documentation and reporting.. Valid values are `^[A-Z0-9-]+$`',
    `test_results_summary` STRING COMMENT 'Summary narrative of the test findings, including observations, exceptions identified, and overall assessment of control performance.',
    `test_status` STRING COMMENT 'Current lifecycle status of the control test activity.. Valid values are `planned|in_progress|completed|under_review|approved|remediation_required`',
    `test_type` STRING COMMENT 'Classification of the control test methodology. Design effectiveness tests evaluate whether the control is properly designed to prevent or detect errors. Operating effectiveness tests evaluate whether the control is functioning as designed over a period of time. [ENUM-REF-CANDIDATE: design_effectiveness|operating_effectiveness|walkthrough|inquiry|observation|inspection|reperformance — 7 candidates stripped; promote to reference product]',
    `testing_frequency` STRING COMMENT 'The planned frequency at which this control is tested as part of the compliance assurance program.. Valid values are `annual|semi_annual|quarterly|monthly|continuous|ad_hoc`',
    CONSTRAINT pk_control_test PRIMARY KEY(`control_test_id`)
) COMMENT 'Records of individual control testing activities performed against compliance controls, including design effectiveness testing and operating effectiveness testing. Captures test date, tester, test methodology (walkthrough, sample testing, re-performance), sample size, exceptions identified, exception rate, overall test conclusion (effective/ineffective), remediation required flag, and linkage to the parent compliance control. Supports SOX, ISO 27001, and SRA compliance assurance programmes.';

CREATE OR REPLACE TABLE `legal_ecm`.`compliance`.`indemnity_policy` (
    `indemnity_policy_id` BIGINT COMMENT 'Unique identifier for the professional indemnity insurance policy record.',
    `line_id` BIGINT COMMENT 'Foreign key linking to service.line. Business justification: Law firms structure professional indemnity cover by service line (e.g., separate PI limits for litigation vs. corporate finance). Line-level insurance coverage reporting and renewal negotiations with ',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Professional indemnity insurance is mandated by regulatory obligations (SRA Indemnity Insurance Rules, Solicitors Act 1974). Linking the indemnity policy to the regulatory obligation that requires it ',
    `annual_premium_amount` DECIMAL(18,2) COMMENT 'The total annual premium paid or payable for this professional indemnity insurance policy.',
    `broker_contact_email` STRING COMMENT 'Primary email address for the insurance broker handling this policy.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `broker_contact_phone` STRING COMMENT 'Primary telephone number for the insurance broker handling this policy.',
    `broker_name` STRING COMMENT 'Name of the insurance broker or intermediary who arranged the professional indemnity policy.',
    `claims_made_basis_flag` BOOLEAN COMMENT 'Indicates whether the policy operates on a claims-made basis (true) or occurrence basis (false), determining when coverage is triggered.',
    `claims_notification_email` STRING COMMENT 'Email address to which claims and potential claims must be notified under the terms of this policy.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `claims_notification_phone` STRING COMMENT 'Telephone number for notifying claims and potential claims to the insurer.',
    `compliance_certificate_issued_flag` BOOLEAN COMMENT 'Indicates whether a certificate of compliance or certificate of insurance has been issued confirming the policy meets regulatory minimum requirements.',
    `coverage_period_end_date` DATE COMMENT 'The date on which the professional indemnity insurance coverage expires or terminates.',
    `coverage_period_start_date` DATE COMMENT 'The date on which the professional indemnity insurance coverage becomes effective and binding.',
    `coverage_territory` STRING COMMENT 'Geographic scope of coverage defining where claims arising from professional services will be covered (e.g., worldwide, UK only, EU, excluding USA).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this professional indemnity policy record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this policy (limits, excess, premium).. Valid values are `^[A-Z]{3}$`',
    `excess_amount` DECIMAL(18,2) COMMENT 'The deductible or self-insured retention amount that the firm must pay before the insurers coverage applies to a claim.',
    `exclusions_summary` STRING COMMENT 'Summary of key exclusions, limitations, and circumstances under which coverage does not apply.',
    `extended_reporting_period_months` STRING COMMENT 'Number of months of extended reporting period (tail coverage) included in the policy, allowing claims to be reported after the policy expiration date for incidents that occurred during the coverage period.',
    `insurer_name` STRING COMMENT 'Legal name of the insurance company providing the professional indemnity coverage.',
    `insurer_reference_number` STRING COMMENT 'Internal reference number assigned by the insurer for tracking and correspondence purposes.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this policy record is currently active and in force.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this professional indemnity policy record was last updated or modified.',
    `last_review_date` DATE COMMENT 'The date on which this policy was last reviewed for adequacy of coverage, compliance with regulatory requirements, and alignment with firm risk profile.',
    `limit_of_indemnity_amount` DECIMAL(18,2) COMMENT 'The maximum amount the insurer will pay for all claims and associated costs during the policy period, representing the aggregate coverage limit.',
    `limit_per_claim_amount` DECIMAL(18,2) COMMENT 'The maximum amount the insurer will pay for any single claim or related series of claims, representing the per-occurrence limit.',
    `next_premium_due_date` DATE COMMENT 'The date on which the next premium payment is due for this policy.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next review of this policys adequacy and compliance.',
    `notes` STRING COMMENT 'Additional notes, comments, or special conditions related to this professional indemnity insurance policy.',
    `policy_document_reference` STRING COMMENT 'Reference identifier or document management system location for the full policy wording, schedule, and endorsements.',
    `policy_number` STRING COMMENT 'The externally-known unique policy number assigned by the insurer for this professional indemnity insurance policy.. Valid values are `^[A-Z0-9]{8,20}$`',
    `policy_status` STRING COMMENT 'Current lifecycle status of the professional indemnity insurance policy.. Valid values are `active|expired|cancelled|pending_renewal|lapsed|terminated`',
    `policy_type` STRING COMMENT 'Classification of the professional indemnity policy indicating whether it is primary coverage, excess layer, run-off coverage for closed practices, top-up coverage, or successor practice coverage.. Valid values are `primary|excess|run_off|top_up|successor_practice`',
    `premium_payment_frequency` STRING COMMENT 'The frequency at which premium payments are made for this policy.. Valid values are `annual|semi_annual|quarterly|monthly`',
    `premium_payment_status` STRING COMMENT 'Current status of premium payment obligations for this policy period.. Valid values are `paid|outstanding|overdue|partial`',
    `qualifying_insurer_flag` BOOLEAN COMMENT 'Indicates whether the insurer is a qualifying insurer as defined by the SRA or relevant regulatory authority, meeting minimum financial strength and regulatory requirements.',
    `regulatory_filing_date` DATE COMMENT 'The date on which the policy details were filed with or notified to the regulatory authority.',
    `regulatory_filing_reference` STRING COMMENT 'Reference number or identifier for the regulatory filing or notification submitted to the SRA or other regulatory authority confirming this policy meets minimum requirements.',
    `renewal_date` DATE COMMENT 'The date on which this policy is scheduled for renewal or replacement with a successor policy.',
    `renewal_notice_sent_date` DATE COMMENT 'The date on which the renewal notice was sent to the firm by the insurer or broker.',
    `responsible_partner_name` STRING COMMENT 'Name of the partner or senior officer responsible for managing this professional indemnity insurance policy and ensuring regulatory compliance.',
    `retroactive_date` DATE COMMENT 'The earliest date from which claims arising from professional services will be covered under this policy, establishing the backward coverage limit for claims-made policies.',
    CONSTRAINT pk_indemnity_policy PRIMARY KEY(`indemnity_policy_id`)
) COMMENT 'Professional indemnity insurance records covering both policy master data and claims lifecycle, as required by SRA, Law Society, and other bar regulators. Policy attributes include insurer, policy number, coverage period, limits, excess, retroactive date, qualifying insurer status, and premium. Claims attributes include notification date, claimant details, matter reference, alleged negligence, exposure estimates, insurer acknowledgement, reserve and settlement amounts, and closure status. Provides the unified PI compliance artifact for regulatory reporting and premium renewal actuarial analysis.';

CREATE OR REPLACE TABLE `legal_ecm`.`compliance`.`indemnity_claim` (
    `indemnity_claim_id` BIGINT COMMENT 'Unique identifier for the professional indemnity insurance claim record. Primary key for the indemnity claim entity.',
    `doc_version_id` BIGINT COMMENT 'Foreign key linking to document.doc_version. Business justification: Professional negligence claim — version-specific document identification: indemnity claims allege negligence in specific advice. The claim must reference the exact document version containing the alle',
    `indemnity_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.indemnity_policy. Business justification: Claims are made UNDER a policy. N:1 relationship (many claims per policy). indemnity_claim has policy_number and policy_year attributes that reference indemnity_policy. Adding FK resolves silo for ind',
    `legal_document_id` BIGINT COMMENT 'Foreign key linking to document.legal_document. Business justification: Claim notifications, coverage opinions, settlement agreements are legal documents: insurer notification letter, coverage counsel opinion, settlement deed, SRA report of claim. Required for linking ind',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: Indemnity claims must be traceable to the specific legal service that gave rise to alleged negligence. This is essential for claims management reporting, insurer reserve calculations, and risk analysi',
    `matter_id` BIGINT COMMENT 'Reference to the matter that is the subject of the alleged negligence or professional liability claim.',
    `pi_claim_id` BIGINT COMMENT 'Foreign key linking to risk.pi_claim. Business justification: compliance.indemnity_claim (insurance management record) and risk.pi_claim (risk register entry) represent the same PI claim event from different functional perspectives. Claims coordinators cross-ref',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Professional indemnity claims arise from practice-area-specific work. Underwriters price coverage by practice area risk profile. Essential for practice-area-level claims analysis, reserve setting, and',
    `profile_id` BIGINT COMMENT 'Reference to the client who is the claimant or on whose matter the alleged negligence occurred.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Indemnity claims may trigger specific regulatory reporting obligations (e.g., SRA mandatory reporting of claims above threshold). The sra_reportable_flag and sra_report_date attributes on indemnity_cl',
    `alleged_negligence_description` STRING COMMENT 'Detailed narrative description of the alleged professional negligence, error, omission, or breach of duty that forms the basis of the claim. Includes circumstances, timeline, and alleged impact.',
    `claim_closure_date` DATE COMMENT 'Date on which the claim was formally closed by the insurer and the firm, either through settlement, withdrawal, or dismissal.',
    `claim_reference_number` STRING COMMENT 'External claim reference number assigned by the insurer or the firms risk management system. Used for correspondence with insurers and tracking across systems.. Valid values are `^[A-Z0-9]{8,20}$`',
    `claim_status` STRING COMMENT 'Current lifecycle status of the indemnity claim. Tracks progression from initial notification through investigation, settlement, and closure. [ENUM-REF-CANDIDATE: notified|acknowledged|investigating|reserved|settled|closed|withdrawn — 7 candidates stripped; promote to reference product]',
    `claim_type` STRING COMMENT 'Classification of the nature of the professional indemnity claim based on the type of alleged error or omission. [ENUM-REF-CANDIDATE: negligence|breach_of_duty|conflict_of_interest|missed_deadline|inadequate_advice|document_error|fraud|other — 8 candidates stripped; promote to reference product]',
    `claimant_contact_email` STRING COMMENT 'Primary email address for correspondence with the claimant or their legal representative.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `claimant_contact_phone` STRING COMMENT 'Primary telephone number for the claimant or their legal representative.',
    `claimant_name` STRING COMMENT 'Full name of the individual or organization making the claim against the firm. May be the client or a third party affected by the alleged negligence.',
    `claimant_type` STRING COMMENT 'Classification of the claimants relationship to the firm and the matter in question.. Valid values are `client|third_party|counterparty|regulatory_body|other`',
    `claims_handler_name` STRING COMMENT 'Name of the individual at the insurer or third-party administrator responsible for managing this claim.',
    `closure_reason` STRING COMMENT 'Reason for closing the claim, indicating the final outcome or disposition.. Valid values are `settled|withdrawn|dismissed|no_coverage|other`',
    `coverage_confirmation_date` DATE COMMENT 'Date on which the insurer confirmed or denied coverage for the claim.',
    `coverage_confirmation_status` STRING COMMENT 'Status of the insurers determination regarding whether the claim is covered under the professional indemnity policy.. Valid values are `pending|confirmed|denied|partial|under_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this indemnity claim record was first created in the system.',
    `defence_costs_amount` DECIMAL(18,2) COMMENT 'Total costs incurred in defending the claim, including legal fees, expert witness fees, and other litigation expenses. May be covered by the insurer depending on policy terms.',
    `defence_costs_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the defence costs amount.. Valid values are `^[A-Z]{3}$`',
    `estimated_exposure_amount` DECIMAL(18,2) COMMENT 'Initial estimate of the firms potential financial exposure or liability for this claim, including damages, costs, and interest. Updated as the claim progresses.',
    `estimated_exposure_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated exposure amount.. Valid values are `^[A-Z]{3}$`',
    `incident_date` DATE COMMENT 'Date on which the alleged negligent act, error, or omission occurred or was discovered.',
    `insurer_acknowledgement_date` DATE COMMENT 'Date on which the insurer formally acknowledged receipt of the claim notification.',
    `insurer_name` STRING COMMENT 'Name of the professional indemnity insurance carrier to whom the claim has been notified.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this indemnity claim record was last updated in the system.',
    `notes` STRING COMMENT 'Free-text field for additional notes, observations, or context regarding the claim, its handling, or its resolution.',
    `notification_date` DATE COMMENT 'Date on which the claim was first notified to the firms risk management or compliance team. Critical for SRA reporting and policy coverage determination.',
    `policy_year` STRING COMMENT 'Insurance policy year during which the claim was notified or the incident occurred, depending on policy terms (claims-made vs occurrence basis).',
    `reserve_amount` DECIMAL(18,2) COMMENT 'Financial reserve amount set aside by the insurer or the firm to cover the anticipated cost of settling or defending the claim. Updated as the claim progresses.',
    `reserve_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the reserve amount.. Valid values are `^[A-Z]{3}$`',
    `reserve_last_updated_date` DATE COMMENT 'Date on which the reserve amount was last reviewed and updated by the insurer or claims handler.',
    `risk_rating` STRING COMMENT 'Assessment of the risk level and potential impact of this claim on the firms reputation, finances, and regulatory standing.. Valid values are `low|medium|high|critical`',
    `settlement_amount` DECIMAL(18,2) COMMENT 'Final settlement amount paid to resolve the claim, including damages, costs, and interest. Null if the claim has not been settled.',
    `settlement_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the settlement amount.. Valid values are `^[A-Z]{3}$`',
    `settlement_date` DATE COMMENT 'Date on which the claim was formally settled and payment was made or agreed.',
    `sra_report_date` DATE COMMENT 'Date on which the claim was reported to the Solicitors Regulation Authority, if applicable.',
    `sra_reportable_flag` BOOLEAN COMMENT 'Indicates whether this claim meets the threshold for mandatory reporting to the Solicitors Regulation Authority under professional indemnity insurance rules.',
    CONSTRAINT pk_indemnity_claim PRIMARY KEY(`indemnity_claim_id`)
) COMMENT 'Professional indemnity insurance claims made against or notified under the firms indemnity policy. Captures claim reference, notification date, claimant details, matter reference, alleged negligence description, estimated exposure, insurer acknowledgement date, coverage confirmation status, reserve amount, settlement amount, and claim closure date. Supports SRA compliance obligations and actuarial reporting for premium renewal.';

CREATE OR REPLACE TABLE `legal_ecm`.`compliance`.`policy` (
    `policy_id` BIGINT COMMENT 'Primary key for policy',
    `control_framework_id` BIGINT COMMENT 'Foreign key linking to compliance.control_framework. Business justification: Policies are often written to implement specific control framework requirements (e.g., Information Security Policy implements ISO 27001, Data Retention Policy implements GDPR requirements). The po',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Compliance policies are scoped to practice areas (data retention for litigation, conflict policies for M&A). Practice groups implement policies differently. Required for practice-area-level policy att',
    `regulatory_obligation_id` BIGINT COMMENT 'FK to compliance.regulatory_obligation.regulatory_obligation_id — Compliance policies are written to satisfy regulatory obligations. This FK enables gap analysis — which obligations lack a governing policy — and is fundamental to policy governance.',
    `applicability_scope` STRING COMMENT 'Description of the organizational scope to which the policy applies (e.g., All Partners and Employees, Client-Facing Staff, IT Department, Global Operations).',
    `approval_authority` STRING COMMENT 'Name or title of the individual or committee with authority to approve the policy (e.g., Chief Legal Officer, Compliance Committee, Board of Directors).',
    `approval_date` DATE COMMENT 'Date when the policy was formally approved by the designated authority.',
    `breach_reporting_procedure` STRING COMMENT 'Description of the procedure for reporting breaches or violations of this policy.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the policy record was first created in the system.',
    `document_location` STRING COMMENT 'File path, DMS reference, or URL where the full policy document is stored (e.g., iManage workspace ID, NetDocuments link).',
    `effective_date` DATE COMMENT 'Date when the policy becomes binding and enforceable within the firm.',
    `exemption_applicable_flag` BOOLEAN COMMENT 'Indicates whether exemptions or waivers from this policy are permitted under certain conditions.',
    `exemption_details` STRING COMMENT 'Description of circumstances under which exemptions may be granted and the approval process required.',
    `expiry_date` DATE COMMENT 'Date when the policy ceases to be in force, nullable for policies without a defined end date.',
    `external_audit_required_flag` BOOLEAN COMMENT 'Indicates whether the policy requires external audit or independent review for compliance verification.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the policy record is currently active and in use.',
    `jurisdiction` STRING COMMENT 'Geographic or legal jurisdiction to which the policy applies (e.g., GBR, USA, EUR, Global).',
    `last_external_audit_date` DATE COMMENT 'Date when the policy was last audited by an external party.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the policy record was last updated.',
    `last_review_date` DATE COMMENT 'Date when the policy was most recently reviewed and approved.',
    `next_external_audit_date` DATE COMMENT 'Scheduled date for the next external audit of policy compliance.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next mandatory policy review.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or context regarding the policy.',
    `objective` STRING COMMENT 'High-level business objective or purpose of the policy, explaining what regulatory or operational risk it mitigates.',
    `owner_department` STRING COMMENT 'Department or business unit responsible for the policy (e.g., Compliance, Risk Management, Legal Operations).',
    `penalty_for_non_compliance` STRING COMMENT 'Description of internal disciplinary actions or external penalties that may result from policy violations.',
    `policy_code` STRING COMMENT 'Unique business identifier code for the policy, typically following firm naming convention (e.g., AML-001, GDPR-002, SOX-003).. Valid values are `^[A-Z]{3,6}-[0-9]{3,5}$`',
    `policy_name` STRING COMMENT 'Full name of the compliance policy (e.g., Anti-Money Laundering Policy, Data Protection Policy, Conflicts of Interest Policy).',
    `policy_status` STRING COMMENT 'Current lifecycle status of the policy indicating its approval and operational state.. Valid values are `draft|under_review|approved|active|superseded|archived`',
    `policy_type` STRING COMMENT 'Category of compliance policy indicating the regulatory domain it addresses.. Valid values are `AML|Data Protection|Anti-Bribery|Sanctions|Conflicts of Interest|Information Security`',
    `priority_level` STRING COMMENT 'Operational priority assigned to the policy for resource allocation and monitoring.. Valid values are `urgent|high|medium|low`',
    `regulatory_framework` STRING COMMENT 'Primary regulatory framework or legislation that the policy addresses (e.g., GDPR, CCPA, SOX, FATF, SRA Code of Conduct).',
    `regulatory_obligations_satisfied` STRING COMMENT 'Comma-separated list or description of specific regulatory obligations that this policy satisfies (e.g., GDPR Article 5, FATF Recommendation 10, SOX Section 404).',
    `review_cycle_months` STRING COMMENT 'Frequency in months at which the policy must be reviewed and reaffirmed (e.g., 12, 24, 36).',
    `risk_rating` STRING COMMENT 'Risk severity rating assigned to the policy area, indicating the potential impact of non-compliance.. Valid values are `critical|high|medium|low`',
    `source_legislation_url` STRING COMMENT 'URL or reference link to the primary legislation, regulation, or guidance document that the policy is based on.',
    `training_frequency_months` STRING COMMENT 'Frequency in months at which training must be completed by applicable staff (e.g., 12, 24).',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether mandatory training is required for staff subject to this policy.',
    `version_number` STRING COMMENT 'Version identifier for the policy document following semantic versioning (e.g., 1.0, 2.1, 3.0).. Valid values are `^[0-9]+.[0-9]+$`',
    CONSTRAINT pk_policy PRIMARY KEY(`policy_id`)
) COMMENT 'Master register of the firms internal compliance policies and procedures, including AML policy, data protection policy, anti-bribery policy, sanctions policy, conflicts of interest policy, and information security policy. Captures policy name, policy owner, version, effective date, review cycle, approval authority, regulatory obligations satisfied, and current status (draft, approved, superseded). Provides the policy governance layer above individual controls.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_control_framework_id` FOREIGN KEY (`control_framework_id`) REFERENCES `legal_ecm`.`compliance`.`control_framework`(`control_framework_id`);
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ADD CONSTRAINT `fk_compliance_compliance_control_control_framework_id` FOREIGN KEY (`control_framework_id`) REFERENCES `legal_ecm`.`compliance`.`control_framework`(`control_framework_id`);
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ADD CONSTRAINT `fk_compliance_compliance_control_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ADD CONSTRAINT `fk_compliance_compliance_control_primary_compliance_control_framework_id` FOREIGN KEY (`primary_compliance_control_framework_id`) REFERENCES `legal_ecm`.`compliance`.`control_framework`(`control_framework_id`);
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ADD CONSTRAINT `fk_compliance_compliance_control_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ADD CONSTRAINT `fk_compliance_compliance_control_to_control_framework_id` FOREIGN KEY (`to_control_framework_id`) REFERENCES `legal_ecm`.`compliance`.`control_framework`(`control_framework_id`);
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ADD CONSTRAINT `fk_compliance_compliance_control_to_regulatory_obligation_id` FOREIGN KEY (`to_regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ADD CONSTRAINT `fk_compliance_aml_kyc_program_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ADD CONSTRAINT `fk_compliance_aml_kyc_program_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ADD CONSTRAINT `fk_compliance_sar_filing_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ADD CONSTRAINT `fk_compliance_sar_filing_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ADD CONSTRAINT `fk_compliance_data_privacy_register_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ADD CONSTRAINT `fk_compliance_data_privacy_register_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`compliance`.`control_test` ADD CONSTRAINT `fk_compliance_control_test_compliance_control_id` FOREIGN KEY (`compliance_control_id`) REFERENCES `legal_ecm`.`compliance`.`compliance_control`(`compliance_control_id`);
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ADD CONSTRAINT `fk_compliance_indemnity_policy_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ADD CONSTRAINT `fk_compliance_indemnity_claim_indemnity_policy_id` FOREIGN KEY (`indemnity_policy_id`) REFERENCES `legal_ecm`.`compliance`.`indemnity_policy`(`indemnity_policy_id`);
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ADD CONSTRAINT `fk_compliance_indemnity_claim_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`compliance`.`policy` ADD CONSTRAINT `fk_compliance_policy_control_framework_id` FOREIGN KEY (`control_framework_id`) REFERENCES `legal_ecm`.`compliance`.`control_framework`(`control_framework_id`);
ALTER TABLE `legal_ecm`.`compliance`.`policy` ADD CONSTRAINT `fk_compliance_policy_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= TAGS =========
ALTER SCHEMA `legal_ecm`.`compliance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `legal_ecm`.`compliance` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` SET TAGS ('dbx_subdomain' = 'regulatory_obligations');
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation ID');
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `control_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Control Framework Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `applicability_scope` SET TAGS ('dbx_business_glossary_term' = 'Applicability Scope');
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|in_progress|under_review|not_applicable');
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `exemption_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Exemption Applicable Flag');
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `exemption_details` SET TAGS ('dbx_business_glossary_term' = 'Exemption Details');
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `external_audit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'External Audit Required Flag');
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `filing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Filing Frequency');
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `filing_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly|event_based|not_applicable');
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `governing_body` SET TAGS ('dbx_business_glossary_term' = 'Governing Body');
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `last_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Assessment Date');
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `last_external_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last External Audit Date');
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `maximum_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Penalty Amount');
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `next_external_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next External Audit Date');
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `next_filing_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Filing Due Date');
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `obligation_category` SET TAGS ('dbx_business_glossary_term' = 'Obligation Category');
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_business_glossary_term' = 'Obligation Code');
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `obligation_description` SET TAGS ('dbx_business_glossary_term' = 'Obligation Description');
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `obligation_name` SET TAGS ('dbx_business_glossary_term' = 'Obligation Name');
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_business_glossary_term' = 'Obligation Type');
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_value_regex' = 'periodic_filing|ongoing_conduct|event_triggered|registration|disclosure|reporting');
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `penalty_for_non_compliance` SET TAGS ('dbx_business_glossary_term' = 'Penalty for Non-Compliance');
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'urgent|high|medium|low');
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `responsible_officer` SET TAGS ('dbx_business_glossary_term' = 'Responsible Officer');
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `review_cycle` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle');
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `review_cycle` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly|ad_hoc|continuous');
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `source_legislation_url` SET TAGS ('dbx_business_glossary_term' = 'Source Legislation URL');
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `training_frequency` SET TAGS ('dbx_business_glossary_term' = 'Training Frequency');
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `training_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|one_time|not_applicable');
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `legal_ecm`.`compliance`.`control_framework` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`compliance`.`control_framework` SET TAGS ('dbx_subdomain' = 'control_management');
ALTER TABLE `legal_ecm`.`compliance`.`control_framework` ALTER COLUMN `control_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Control Framework Identifier (ID)');
ALTER TABLE `legal_ecm`.`compliance`.`control_framework` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`compliance`.`control_framework` ALTER COLUMN `adoption_date` SET TAGS ('dbx_business_glossary_term' = 'Adoption Date');
ALTER TABLE `legal_ecm`.`compliance`.`control_framework` ALTER COLUMN `certification_body` SET TAGS ('dbx_business_glossary_term' = 'Certification Body');
ALTER TABLE `legal_ecm`.`compliance`.`control_framework` ALTER COLUMN `certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Required Flag');
ALTER TABLE `legal_ecm`.`compliance`.`control_framework` ALTER COLUMN `compliance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Compliance Percentage');
ALTER TABLE `legal_ecm`.`compliance`.`control_framework` ALTER COLUMN `control_count` SET TAGS ('dbx_business_glossary_term' = 'Control Count');
ALTER TABLE `legal_ecm`.`compliance`.`control_framework` ALTER COLUMN `control_domain_mapping` SET TAGS ('dbx_business_glossary_term' = 'Control Domain Mapping');
ALTER TABLE `legal_ecm`.`compliance`.`control_framework` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`compliance`.`control_framework` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `legal_ecm`.`compliance`.`control_framework` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `legal_ecm`.`compliance`.`control_framework` ALTER COLUMN `framework_code` SET TAGS ('dbx_business_glossary_term' = 'Framework Code');
ALTER TABLE `legal_ecm`.`compliance`.`control_framework` ALTER COLUMN `framework_description` SET TAGS ('dbx_business_glossary_term' = 'Framework Description');
ALTER TABLE `legal_ecm`.`compliance`.`control_framework` ALTER COLUMN `framework_name` SET TAGS ('dbx_business_glossary_term' = 'Framework Name');
ALTER TABLE `legal_ecm`.`compliance`.`control_framework` ALTER COLUMN `framework_status` SET TAGS ('dbx_business_glossary_term' = 'Framework Status');
ALTER TABLE `legal_ecm`.`compliance`.`control_framework` ALTER COLUMN `framework_status` SET TAGS ('dbx_value_regex' = 'active|superseded|retired|under_review|pending_adoption');
ALTER TABLE `legal_ecm`.`compliance`.`control_framework` ALTER COLUMN `framework_type` SET TAGS ('dbx_business_glossary_term' = 'Framework Type');
ALTER TABLE `legal_ecm`.`compliance`.`control_framework` ALTER COLUMN `framework_type` SET TAGS ('dbx_value_regex' = 'regulatory|industry_standard|internal|best_practice|certification|contractual');
ALTER TABLE `legal_ecm`.`compliance`.`control_framework` ALTER COLUMN `framework_url` SET TAGS ('dbx_business_glossary_term' = 'Framework Uniform Resource Locator (URL)');
ALTER TABLE `legal_ecm`.`compliance`.`control_framework` ALTER COLUMN `framework_version` SET TAGS ('dbx_business_glossary_term' = 'Framework Version');
ALTER TABLE `legal_ecm`.`compliance`.`control_framework` ALTER COLUMN `issuing_body` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body');
ALTER TABLE `legal_ecm`.`compliance`.`control_framework` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `legal_ecm`.`compliance`.`control_framework` ALTER COLUMN `last_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Certification Date');
ALTER TABLE `legal_ecm`.`compliance`.`control_framework` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`compliance`.`control_framework` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `legal_ecm`.`compliance`.`control_framework` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `legal_ecm`.`compliance`.`control_framework` ALTER COLUMN `next_certification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Certification Due Date');
ALTER TABLE `legal_ecm`.`compliance`.`control_framework` ALTER COLUMN `next_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Due Date');
ALTER TABLE `legal_ecm`.`compliance`.`control_framework` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm`.`compliance`.`control_framework` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency');
ALTER TABLE `legal_ecm`.`compliance`.`control_framework` ALTER COLUMN `review_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly|ad_hoc|continuous');
ALTER TABLE `legal_ecm`.`compliance`.`control_framework` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `legal_ecm`.`compliance`.`control_framework` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `legal_ecm`.`compliance`.`control_framework` ALTER COLUMN `scope_of_applicability` SET TAGS ('dbx_business_glossary_term' = 'Scope of Applicability');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` SET TAGS ('dbx_subdomain' = 'control_management');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ALTER COLUMN `compliance_control_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Control Identifier (ID)');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ALTER COLUMN `doc_template_id` SET TAGS ('dbx_business_glossary_term' = 'Doc Template Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ALTER COLUMN `primary_compliance_control_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework Identifier (ID)');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Identifier (ID)');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ALTER COLUMN `compensating_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Compensating Control Flag');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ALTER COLUMN `control_description` SET TAGS ('dbx_business_glossary_term' = 'Control Description');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ALTER COLUMN `control_status` SET TAGS ('dbx_business_glossary_term' = 'Control Lifecycle Status');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ALTER COLUMN `control_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|under_review|retired');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ALTER COLUMN `control_type` SET TAGS ('dbx_business_glossary_term' = 'Control Type');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ALTER COLUMN `control_type` SET TAGS ('dbx_value_regex' = 'preventive|detective|corrective|directive');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ALTER COLUMN `documentation_reference` SET TAGS ('dbx_business_glossary_term' = 'Control Documentation Reference');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Control Effective From Date');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Control Effective To Date');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ALTER COLUMN `effectiveness_rating` SET TAGS ('dbx_business_glossary_term' = 'Control Effectiveness Rating');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ALTER COLUMN `effectiveness_rating` SET TAGS ('dbx_value_regex' = 'highly_effective|effective|needs_improvement|ineffective');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ALTER COLUMN `exception_count` SET TAGS ('dbx_business_glossary_term' = 'Control Test Exception Count');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ALTER COLUMN `exception_description` SET TAGS ('dbx_business_glossary_term' = 'Control Exception Description');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Control Execution Frequency');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ALTER COLUMN `gdpr_article_reference` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Article Reference');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ALTER COLUMN `identifier` SET TAGS ('dbx_business_glossary_term' = 'Control Business Identifier');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ALTER COLUMN `identifier` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}-[0-9]{3,5}$');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ALTER COLUMN `iso_27001_control_reference` SET TAGS ('dbx_business_glossary_term' = 'ISO 27001 Control Reference');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ALTER COLUMN `iso_27001_control_reference` SET TAGS ('dbx_value_regex' = '^A.[0-9]{1,2}.[0-9]{1,2}$');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ALTER COLUMN `key_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Key Control Flag');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ALTER COLUMN `last_test_conclusion` SET TAGS ('dbx_business_glossary_term' = 'Last Test Conclusion');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ALTER COLUMN `last_test_conclusion` SET TAGS ('dbx_value_regex' = 'effective|ineffective|partially_effective|not_tested');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ALTER COLUMN `last_test_date` SET TAGS ('dbx_business_glossary_term' = 'Last Control Test Date');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ALTER COLUMN `nature` SET TAGS ('dbx_business_glossary_term' = 'Control Nature');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ALTER COLUMN `nature` SET TAGS ('dbx_value_regex' = 'manual|automated|hybrid');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ALTER COLUMN `next_test_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Control Test Due Date');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ALTER COLUMN `objective` SET TAGS ('dbx_business_glossary_term' = 'Control Objective');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ALTER COLUMN `procedure` SET TAGS ('dbx_business_glossary_term' = 'Control Procedure');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ALTER COLUMN `remediation_plan` SET TAGS ('dbx_business_glossary_term' = 'Control Remediation Plan');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ALTER COLUMN `remediation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Remediation Required Flag');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|overdue|cancelled');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Control Risk Rating');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Control Test Sample Size');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ALTER COLUMN `sox_scoping_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Scoping Flag');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ALTER COLUMN `sra_standard_reference` SET TAGS ('dbx_business_glossary_term' = 'Solicitors Regulation Authority (SRA) Standard Reference');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ALTER COLUMN `testing_methodology` SET TAGS ('dbx_business_glossary_term' = 'Control Testing Methodology');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Control Title');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ALTER COLUMN `utbms_task_code` SET TAGS ('dbx_business_glossary_term' = 'Uniform Task-Based Management System (UTBMS) Task Code');
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ALTER COLUMN `utbms_task_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{3}$');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` SET TAGS ('dbx_subdomain' = 'financial_crime');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `aml_kyc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Know Your Client (KYC) Program ID');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `applicable_jurisdictions` SET TAGS ('dbx_business_glossary_term' = 'Applicable Jurisdictions');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `audit_findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Audit Findings Summary');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `audit_findings_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `board_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Board Approval Date');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `client_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Client Risk Rating');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `client_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `client_risk_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `control_effectiveness_rating` SET TAGS ('dbx_business_glossary_term' = 'Control Effectiveness Rating');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `control_effectiveness_rating` SET TAGS ('dbx_value_regex' = 'effective|partially_effective|ineffective|not_tested');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `control_effectiveness_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `delivery_channel_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Risk Rating');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `delivery_channel_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `delivery_channel_risk_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Program Effective Date');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Program Expiry Date');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `geographic_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Geographic Risk Rating');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `geographic_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `geographic_risk_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `inherent_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Inherent Risk Rating');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `inherent_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `inherent_risk_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `last_risk_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Risk Assessment Date');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By User');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `mlro_email` SET TAGS ('dbx_business_glossary_term' = 'MLRO Email Address');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `mlro_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `mlro_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `mlro_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `mlro_name` SET TAGS ('dbx_business_glossary_term' = 'Money Laundering Reporting Officer (MLRO) Name');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `mlro_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `mlro_phone` SET TAGS ('dbx_business_glossary_term' = 'MLRO Phone Number');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `mlro_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `mlro_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `next_risk_assessment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Risk Assessment Due Date');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `product_service_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Product and Service Risk Rating');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `product_service_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `product_service_risk_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'AML/KYC Program Name');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `program_scope` SET TAGS ('dbx_business_glossary_term' = 'Program Scope');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'draft|active|under_review|suspended|archived');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `program_version` SET TAGS ('dbx_business_glossary_term' = 'Program Version');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|conditionally_approved|rejected|not_required');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `residual_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Rating');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `residual_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `residual_risk_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `risk_appetite_statement` SET TAGS ('dbx_business_glossary_term' = 'Risk Appetite Statement');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `risk_appetite_statement` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `risk_assessment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Frequency');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `risk_assessment_frequency` SET TAGS ('dbx_value_regex' = 'annual|biannual|quarterly|ad_hoc|event_driven');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `risk_methodology` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Methodology');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `suspicious_activity_reports_filed` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Reports (SAR) Filed Count');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `suspicious_activity_reports_filed` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `training_completion_rate` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Rate Percentage');
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` SET TAGS ('dbx_subdomain' = 'financial_crime');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `sar_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Filing ID');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Document Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `organisation_id` SET TAGS ('dbx_business_glossary_term' = 'Organisation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `acknowledgment_reference` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Reference');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `consent_outcome` SET TAGS ('dbx_business_glossary_term' = 'Consent Outcome');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `consent_outcome` SET TAGS ('dbx_value_regex' = 'granted|refused|no_response|not_applicable');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `consent_outcome_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Outcome Date');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `consent_request_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Request Date');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `consent_request_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Request Flag');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `filing_authority` SET TAGS ('dbx_business_glossary_term' = 'Filing Authority');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `filing_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Filing Jurisdiction');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Filing Status');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|submitted|acknowledged|rejected|withdrawn');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `filing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Filing Timestamp');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `follow_up_action_description` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Action Description');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `follow_up_action_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `follow_up_action_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Action Required');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `internal_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Internal Reference Number');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `internal_report_date` SET TAGS ('dbx_business_glossary_term' = 'Internal Report Date');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `law_enforcement_reference` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Reference');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `law_enforcement_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `mlro_name` SET TAGS ('dbx_business_glossary_term' = 'Money Laundering Reporting Officer (MLRO) Name');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `mlro_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `relationship_terminated_flag` SET TAGS ('dbx_business_glossary_term' = 'Relationship Terminated Flag');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `relationship_termination_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Termination Date');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `reporter_name` SET TAGS ('dbx_business_glossary_term' = 'Reporter Name');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `reporter_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiry Date');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `review_notes` SET TAGS ('dbx_business_glossary_term' = 'Review Notes');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `review_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `sar_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Reference Number');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `subject_identifier_type` SET TAGS ('dbx_business_glossary_term' = 'Subject Identifier Type');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `subject_identifier_type` SET TAGS ('dbx_value_regex' = 'passport|national_id|company_registration|tax_id|other');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `subject_identifier_value` SET TAGS ('dbx_business_glossary_term' = 'Subject Identifier Value');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `subject_identifier_value` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `subject_identifier_value` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `subject_name_anonymised` SET TAGS ('dbx_business_glossary_term' = 'Subject Name (Anonymised)');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `subject_name_anonymised` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `subject_name_anonymised` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `subject_type` SET TAGS ('dbx_business_glossary_term' = 'Subject Type');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `subject_type` SET TAGS ('dbx_value_regex' = 'individual|organisation|trust|partnership|other');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `suspicion_category` SET TAGS ('dbx_business_glossary_term' = 'Suspicion Category');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `suspicion_category` SET TAGS ('dbx_value_regex' = 'money_laundering|terrorist_financing|fraud|bribery_corruption|sanctions_breach|tax_evasion');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `suspicion_grounds` SET TAGS ('dbx_business_glossary_term' = 'Suspicion Grounds');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `suspicion_grounds` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `tipping_off_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Tipping Off Risk Flag');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ALTER COLUMN `transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Transaction Reference');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` SET TAGS ('dbx_subdomain' = 'regulatory_obligations');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `data_privacy_register_id` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Register ID');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `delivery_model_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Model Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `controller_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Controller Contact Email');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `controller_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `controller_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `controller_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `controller_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Controller Contact Name');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `controller_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `controller_name` SET TAGS ('dbx_business_glossary_term' = 'Data Controller Name');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `data_privacy_register_status` SET TAGS ('dbx_business_glossary_term' = 'Entry Status');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `data_privacy_register_status` SET TAGS ('dbx_value_regex' = 'draft|active|under_review|suspended|archived');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `data_subject_categories` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Categories');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `dpia_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Impact Assessment (DPIA) Completion Date');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `dpia_mitigation_measures` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Impact Assessment (DPIA) Mitigation Measures');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `dpia_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Impact Assessment (DPIA) Required Flag');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `dpia_trigger_reason` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Impact Assessment (DPIA) Trigger Reason');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `dpo_consultation_date` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Officer (DPO) Consultation Date');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `dpo_consultation_outcome` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Officer (DPO) Consultation Outcome');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `dpo_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Officer (DPO) Contact Email');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `dpo_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `dpo_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `dpo_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `dpo_name` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Officer (DPO) Name');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `dpo_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `entry_type` SET TAGS ('dbx_business_glossary_term' = 'Entry Type');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `entry_type` SET TAGS ('dbx_value_regex' = 'ropa|dpia|combined');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `legal_basis` SET TAGS ('dbx_business_glossary_term' = 'Legal Basis for Processing');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `legal_basis` SET TAGS ('dbx_value_regex' = 'consent|contract|legal_obligation|vital_interests|public_task|legitimate_interests');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `legitimate_interest_description` SET TAGS ('dbx_business_glossary_term' = 'Legitimate Interest Description');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `organizational_security_measures` SET TAGS ('dbx_business_glossary_term' = 'Organizational Security Measures');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `personal_data_categories` SET TAGS ('dbx_business_glossary_term' = 'Personal Data Categories');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `processing_activity_code` SET TAGS ('dbx_business_glossary_term' = 'Processing Activity Code');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `processing_activity_name` SET TAGS ('dbx_business_glossary_term' = 'Processing Activity Name');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `processing_purpose` SET TAGS ('dbx_business_glossary_term' = 'Processing Purpose');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `recipient_categories` SET TAGS ('dbx_business_glossary_term' = 'Recipient Categories');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `retention_justification` SET TAGS ('dbx_business_glossary_term' = 'Retention Justification');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `retention_period` SET TAGS ('dbx_business_glossary_term' = 'Retention Period');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `review_frequency` SET TAGS ('dbx_value_regex' = 'annual|biannual|quarterly|ad_hoc|continuous');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `special_category_data_flag` SET TAGS ('dbx_business_glossary_term' = 'Special Category Data Flag');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `special_category_data_types` SET TAGS ('dbx_business_glossary_term' = 'Special Category Data Types');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `supervisory_authority_consultation_date` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Authority Consultation Date');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `supervisory_authority_consultation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Authority Consultation Required Flag');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `supervisory_authority_response` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Authority Response');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `technical_security_measures` SET TAGS ('dbx_business_glossary_term' = 'Technical Security Measures');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `third_country_names` SET TAGS ('dbx_business_glossary_term' = 'Third Country Names');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `third_country_transfer_flag` SET TAGS ('dbx_business_glossary_term' = 'Third Country Transfer Flag');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `transfer_safeguard_details` SET TAGS ('dbx_business_glossary_term' = 'Transfer Safeguard Details');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `transfer_safeguard_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Transfer Safeguard Mechanism');
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ALTER COLUMN `transfer_safeguard_mechanism` SET TAGS ('dbx_value_regex' = 'adequacy_decision|standard_contractual_clauses|binding_corporate_rules|certification|code_of_conduct|other');
ALTER TABLE `legal_ecm`.`compliance`.`control_test` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`compliance`.`control_test` SET TAGS ('dbx_subdomain' = 'control_management');
ALTER TABLE `legal_ecm`.`compliance`.`control_test` ALTER COLUMN `control_test_id` SET TAGS ('dbx_business_glossary_term' = 'Control Test Identifier (ID)');
ALTER TABLE `legal_ecm`.`compliance`.`control_test` ALTER COLUMN `assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Assessment Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`compliance`.`control_test` ALTER COLUMN `compliance_control_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Control Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`compliance`.`control_test` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Document Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`compliance`.`control_test` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `legal_ecm`.`compliance`.`control_test` ALTER COLUMN `control_deficiency_severity` SET TAGS ('dbx_business_glossary_term' = 'Control Deficiency Severity');
ALTER TABLE `legal_ecm`.`compliance`.`control_test` ALTER COLUMN `control_deficiency_severity` SET TAGS ('dbx_value_regex' = 'none|deficiency|significant_deficiency|material_weakness');
ALTER TABLE `legal_ecm`.`compliance`.`control_test` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`compliance`.`control_test` ALTER COLUMN `evidence_reference` SET TAGS ('dbx_business_glossary_term' = 'Evidence Reference');
ALTER TABLE `legal_ecm`.`compliance`.`control_test` ALTER COLUMN `exception_details` SET TAGS ('dbx_business_glossary_term' = 'Exception Details');
ALTER TABLE `legal_ecm`.`compliance`.`control_test` ALTER COLUMN `exception_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Exception Rate Percentage');
ALTER TABLE `legal_ecm`.`compliance`.`control_test` ALTER COLUMN `exceptions_identified_count` SET TAGS ('dbx_business_glossary_term' = 'Exceptions Identified Count');
ALTER TABLE `legal_ecm`.`compliance`.`control_test` ALTER COLUMN `external_auditor_flag` SET TAGS ('dbx_business_glossary_term' = 'External Auditor Flag');
ALTER TABLE `legal_ecm`.`compliance`.`control_test` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`compliance`.`control_test` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm`.`compliance`.`control_test` ALTER COLUMN `population_size` SET TAGS ('dbx_business_glossary_term' = 'Population Size');
ALTER TABLE `legal_ecm`.`compliance`.`control_test` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date');
ALTER TABLE `legal_ecm`.`compliance`.`control_test` ALTER COLUMN `remediation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Remediation Required Flag');
ALTER TABLE `legal_ecm`.`compliance`.`control_test` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `legal_ecm`.`compliance`.`control_test` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `legal_ecm`.`compliance`.`control_test` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `legal_ecm`.`compliance`.`control_test` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `legal_ecm`.`compliance`.`control_test` ALTER COLUMN `sampling_method` SET TAGS ('dbx_business_glossary_term' = 'Sampling Method');
ALTER TABLE `legal_ecm`.`compliance`.`control_test` ALTER COLUMN `test_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Test Completion Date');
ALTER TABLE `legal_ecm`.`compliance`.`control_test` ALTER COLUMN `test_conclusion` SET TAGS ('dbx_business_glossary_term' = 'Test Conclusion');
ALTER TABLE `legal_ecm`.`compliance`.`control_test` ALTER COLUMN `test_conclusion` SET TAGS ('dbx_value_regex' = 'effective|ineffective|partially_effective|not_tested|inconclusive');
ALTER TABLE `legal_ecm`.`compliance`.`control_test` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Test Execution Date');
ALTER TABLE `legal_ecm`.`compliance`.`control_test` ALTER COLUMN `test_methodology` SET TAGS ('dbx_business_glossary_term' = 'Test Methodology');
ALTER TABLE `legal_ecm`.`compliance`.`control_test` ALTER COLUMN `test_objective` SET TAGS ('dbx_business_glossary_term' = 'Test Objective');
ALTER TABLE `legal_ecm`.`compliance`.`control_test` ALTER COLUMN `test_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Test Period End Date');
ALTER TABLE `legal_ecm`.`compliance`.`control_test` ALTER COLUMN `test_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Test Period Start Date');
ALTER TABLE `legal_ecm`.`compliance`.`control_test` ALTER COLUMN `test_procedure_description` SET TAGS ('dbx_business_glossary_term' = 'Test Procedure Description');
ALTER TABLE `legal_ecm`.`compliance`.`control_test` ALTER COLUMN `test_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Test Reference Number');
ALTER TABLE `legal_ecm`.`compliance`.`control_test` ALTER COLUMN `test_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]+$');
ALTER TABLE `legal_ecm`.`compliance`.`control_test` ALTER COLUMN `test_results_summary` SET TAGS ('dbx_business_glossary_term' = 'Test Results Summary');
ALTER TABLE `legal_ecm`.`compliance`.`control_test` ALTER COLUMN `test_status` SET TAGS ('dbx_business_glossary_term' = 'Test Status');
ALTER TABLE `legal_ecm`.`compliance`.`control_test` ALTER COLUMN `test_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|under_review|approved|remediation_required');
ALTER TABLE `legal_ecm`.`compliance`.`control_test` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type');
ALTER TABLE `legal_ecm`.`compliance`.`control_test` ALTER COLUMN `testing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Testing Frequency');
ALTER TABLE `legal_ecm`.`compliance`.`control_test` ALTER COLUMN `testing_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly|continuous|ad_hoc');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` SET TAGS ('dbx_subdomain' = 'policy_indemnity');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `indemnity_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Indemnity Policy ID');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Line Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `annual_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Premium Amount');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `annual_premium_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `broker_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Broker Contact Email');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `broker_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `broker_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `broker_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Broker Contact Phone');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `broker_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `broker_name` SET TAGS ('dbx_business_glossary_term' = 'Broker Name');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `claims_made_basis_flag` SET TAGS ('dbx_business_glossary_term' = 'Claims Made Basis Flag');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `claims_notification_email` SET TAGS ('dbx_business_glossary_term' = 'Claims Notification Email');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `claims_notification_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `claims_notification_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `claims_notification_phone` SET TAGS ('dbx_business_glossary_term' = 'Claims Notification Phone');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `claims_notification_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `compliance_certificate_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certificate Issued Flag');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `coverage_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Period End Date');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `coverage_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Period Start Date');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `coverage_territory` SET TAGS ('dbx_business_glossary_term' = 'Coverage Territory');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `excess_amount` SET TAGS ('dbx_business_glossary_term' = 'Excess Amount');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `exclusions_summary` SET TAGS ('dbx_business_glossary_term' = 'Exclusions Summary');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `extended_reporting_period_months` SET TAGS ('dbx_business_glossary_term' = 'Extended Reporting Period Months');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `insurer_name` SET TAGS ('dbx_business_glossary_term' = 'Insurer Name');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `insurer_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Insurer Reference Number');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `limit_of_indemnity_amount` SET TAGS ('dbx_business_glossary_term' = 'Limit of Indemnity Amount');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `limit_per_claim_amount` SET TAGS ('dbx_business_glossary_term' = 'Limit Per Claim Amount');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `next_premium_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Premium Due Date');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `policy_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Policy Document Reference');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `policy_number` SET TAGS ('dbx_business_glossary_term' = 'Policy Number');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `policy_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_business_glossary_term' = 'Policy Status');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_value_regex' = 'active|expired|cancelled|pending_renewal|lapsed|terminated');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_business_glossary_term' = 'Policy Type');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_value_regex' = 'primary|excess|run_off|top_up|successor_practice');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `premium_payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Premium Payment Frequency');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `premium_payment_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `premium_payment_status` SET TAGS ('dbx_business_glossary_term' = 'Premium Payment Status');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `premium_payment_status` SET TAGS ('dbx_value_regex' = 'paid|outstanding|overdue|partial');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `qualifying_insurer_flag` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Insurer Flag');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `regulatory_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Date');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `regulatory_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Reference');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `renewal_notice_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Sent Date');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `responsible_partner_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Partner Name');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ALTER COLUMN `retroactive_date` SET TAGS ('dbx_business_glossary_term' = 'Retroactive Date');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` SET TAGS ('dbx_subdomain' = 'policy_indemnity');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `indemnity_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Indemnity Claim Identifier (ID)');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `doc_version_id` SET TAGS ('dbx_business_glossary_term' = 'Doc Version Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `indemnity_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Indemnity Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Notification Document Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier (ID)');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `pi_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Pi Claim Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `alleged_negligence_description` SET TAGS ('dbx_business_glossary_term' = 'Alleged Negligence Description');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `alleged_negligence_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `claim_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Closure Date');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `claim_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Claim Reference Number');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `claim_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `claim_status` SET TAGS ('dbx_business_glossary_term' = 'Claim Status');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `claim_type` SET TAGS ('dbx_business_glossary_term' = 'Claim Type');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `claimant_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Claimant Contact Email Address');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `claimant_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `claimant_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `claimant_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `claimant_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Claimant Contact Phone Number');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `claimant_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `claimant_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `claimant_name` SET TAGS ('dbx_business_glossary_term' = 'Claimant Name');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `claimant_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `claimant_type` SET TAGS ('dbx_business_glossary_term' = 'Claimant Type');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `claimant_type` SET TAGS ('dbx_value_regex' = 'client|third_party|counterparty|regulatory_body|other');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `claims_handler_name` SET TAGS ('dbx_business_glossary_term' = 'Claims Handler Name');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `closure_reason` SET TAGS ('dbx_business_glossary_term' = 'Closure Reason');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `closure_reason` SET TAGS ('dbx_value_regex' = 'settled|withdrawn|dismissed|no_coverage|other');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `coverage_confirmation_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Confirmation Date');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `coverage_confirmation_status` SET TAGS ('dbx_business_glossary_term' = 'Coverage Confirmation Status');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `coverage_confirmation_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|denied|partial|under_review');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `defence_costs_amount` SET TAGS ('dbx_business_glossary_term' = 'Defence Costs Amount');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `defence_costs_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `defence_costs_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Defence Costs Currency Code');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `defence_costs_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `estimated_exposure_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Exposure Amount');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `estimated_exposure_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `estimated_exposure_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Estimated Exposure Currency Code');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `estimated_exposure_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `insurer_acknowledgement_date` SET TAGS ('dbx_business_glossary_term' = 'Insurer Acknowledgement Date');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `insurer_name` SET TAGS ('dbx_business_glossary_term' = 'Insurer Name');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `policy_year` SET TAGS ('dbx_business_glossary_term' = 'Policy Year');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Reserve Amount');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `reserve_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `reserve_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Reserve Currency Code');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `reserve_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `reserve_last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Reserve Last Updated Date');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `settlement_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency Code');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `settlement_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `sra_report_date` SET TAGS ('dbx_business_glossary_term' = 'Solicitors Regulation Authority (SRA) Report Date');
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ALTER COLUMN `sra_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Solicitors Regulation Authority (SRA) Reportable Flag');
ALTER TABLE `legal_ecm`.`compliance`.`policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`compliance`.`policy` SET TAGS ('dbx_subdomain' = 'regulatory_obligations');
ALTER TABLE `legal_ecm`.`compliance`.`policy` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier');
ALTER TABLE `legal_ecm`.`compliance`.`policy` ALTER COLUMN `control_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Implementing Control Framework Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`compliance`.`policy` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`compliance`.`policy` ALTER COLUMN `applicability_scope` SET TAGS ('dbx_business_glossary_term' = 'Applicability Scope');
ALTER TABLE `legal_ecm`.`compliance`.`policy` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `legal_ecm`.`compliance`.`policy` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm`.`compliance`.`policy` ALTER COLUMN `breach_reporting_procedure` SET TAGS ('dbx_business_glossary_term' = 'Breach Reporting Procedure');
ALTER TABLE `legal_ecm`.`compliance`.`policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`compliance`.`policy` ALTER COLUMN `document_location` SET TAGS ('dbx_business_glossary_term' = 'Policy Document Location');
ALTER TABLE `legal_ecm`.`compliance`.`policy` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `legal_ecm`.`compliance`.`policy` ALTER COLUMN `exemption_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Exemption Applicable Flag');
ALTER TABLE `legal_ecm`.`compliance`.`policy` ALTER COLUMN `exemption_details` SET TAGS ('dbx_business_glossary_term' = 'Exemption Details');
ALTER TABLE `legal_ecm`.`compliance`.`policy` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `legal_ecm`.`compliance`.`policy` ALTER COLUMN `external_audit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'External Audit Required Flag');
ALTER TABLE `legal_ecm`.`compliance`.`policy` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `legal_ecm`.`compliance`.`policy` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `legal_ecm`.`compliance`.`policy` ALTER COLUMN `last_external_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last External Audit Date');
ALTER TABLE `legal_ecm`.`compliance`.`policy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`compliance`.`policy` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `legal_ecm`.`compliance`.`policy` ALTER COLUMN `next_external_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next External Audit Date');
ALTER TABLE `legal_ecm`.`compliance`.`policy` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `legal_ecm`.`compliance`.`policy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm`.`compliance`.`policy` ALTER COLUMN `objective` SET TAGS ('dbx_business_glossary_term' = 'Policy Objective');
ALTER TABLE `legal_ecm`.`compliance`.`policy` ALTER COLUMN `owner_department` SET TAGS ('dbx_business_glossary_term' = 'Policy Owner Department');
ALTER TABLE `legal_ecm`.`compliance`.`policy` ALTER COLUMN `penalty_for_non_compliance` SET TAGS ('dbx_business_glossary_term' = 'Penalty for Non-Compliance');
ALTER TABLE `legal_ecm`.`compliance`.`policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_business_glossary_term' = 'Policy Code');
ALTER TABLE `legal_ecm`.`compliance`.`policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3,6}-[0-9]{3,5}$');
ALTER TABLE `legal_ecm`.`compliance`.`policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_business_glossary_term' = 'Policy Name');
ALTER TABLE `legal_ecm`.`compliance`.`policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_business_glossary_term' = 'Policy Status');
ALTER TABLE `legal_ecm`.`compliance`.`policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|active|superseded|archived');
ALTER TABLE `legal_ecm`.`compliance`.`policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_business_glossary_term' = 'Policy Type');
ALTER TABLE `legal_ecm`.`compliance`.`policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_value_regex' = 'AML|Data Protection|Anti-Bribery|Sanctions|Conflicts of Interest|Information Security');
ALTER TABLE `legal_ecm`.`compliance`.`policy` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `legal_ecm`.`compliance`.`policy` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'urgent|high|medium|low');
ALTER TABLE `legal_ecm`.`compliance`.`policy` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `legal_ecm`.`compliance`.`policy` ALTER COLUMN `regulatory_obligations_satisfied` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligations Satisfied');
ALTER TABLE `legal_ecm`.`compliance`.`policy` ALTER COLUMN `review_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle Months');
ALTER TABLE `legal_ecm`.`compliance`.`policy` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `legal_ecm`.`compliance`.`policy` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `legal_ecm`.`compliance`.`policy` ALTER COLUMN `source_legislation_url` SET TAGS ('dbx_business_glossary_term' = 'Source Legislation URL');
ALTER TABLE `legal_ecm`.`compliance`.`policy` ALTER COLUMN `training_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Training Frequency Months');
ALTER TABLE `legal_ecm`.`compliance`.`policy` ALTER COLUMN `training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `legal_ecm`.`compliance`.`policy` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `legal_ecm`.`compliance`.`policy` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
