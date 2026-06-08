-- Schema for Domain: compliance | Business: Legal | Version: v8_ecm
-- Generated on: 2026-05-21 01:11:35

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `legal_ecm_v1`.`compliance` COMMENT 'Owns regulatory compliance obligations, control frameworks, and reporting requirements applicable to the firm and its clients. Covers AML/KYC program management, GDPR/CCPA/DPA data privacy controls, SOX compliance tracking, SRA regulatory returns, DPO activities, FATF obligations, and professional indemnity insurance. Distinct from conflict domain — compliance owns firm-level regulatory posture; conflict owns matter-level ethics screening.';

-- ========= TABLES =========
CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`compliance`.`regulatory_obligation` (
    `regulatory_obligation_id` BIGINT COMMENT 'Unique identifier for the regulatory obligation record. Primary key.',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Regulatory obligations are practice-area-specific (SRA standards for litigation, GDPR for data privacy). Compliance teams map obligations to practice areas for targeted training, control design, and r',
    `applicability_scope` STRING COMMENT 'Description of the scope of applicability within the firm (e.g., all offices, specific practice groups, client-facing roles, data processing activities).',
    `compliance_status` STRING COMMENT 'Current compliance status of the firm with respect to this obligation: compliant, non-compliant, in progress, under review, or not applicable.. Valid values are `compliant|non_compliant|in_progress|under_review|not_applicable`',
    `control_framework_reference` STRING COMMENT 'Reference to the control framework or control catalog entry that maps to this obligation (e.g., ISO 27001 control number, SOX control ID).',
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
    `related_policy_reference` STRING COMMENT 'Reference to the internal firm policy or procedure document that addresses compliance with this obligation.',
    `responsible_department` STRING COMMENT 'Department or business unit within the firm responsible for managing compliance with this obligation (e.g., Compliance, Risk Management, Legal Operations).',
    `responsible_officer` STRING COMMENT 'Name or title of the individual responsible for ensuring compliance with this obligation (e.g., Data Protection Officer, Chief Legal Officer, Compliance Partner).',
    `review_cycle` STRING COMMENT 'Frequency at which the firm must review and assess compliance with this obligation (e.g., annual, quarterly, continuous).. Valid values are `annual|semi_annual|quarterly|monthly|ad_hoc|continuous`',
    `risk_rating` STRING COMMENT 'Risk rating assigned to this obligation based on the potential impact of non-compliance on the firm (critical, high, medium, low).. Valid values are `critical|high|medium|low`',
    `source_legislation_url` STRING COMMENT 'URL or hyperlink to the official source legislation, regulation, or guidance document that defines this obligation.',
    `training_frequency` STRING COMMENT 'Frequency at which compliance training must be completed for this obligation. Not applicable if training is not required.. Valid values are `annual|semi_annual|quarterly|one_time|not_applicable`',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether mandatory training is required for personnel to ensure compliance with this obligation. True if training is required, False otherwise.',
    CONSTRAINT pk_regulatory_obligation PRIMARY KEY(`regulatory_obligation_id`)
) COMMENT 'Master registry of all regulatory obligations applicable to the firm across all jurisdictions of operation. Each obligation captures the governing body, jurisdiction, regulatory framework, obligation type (periodic filing, ongoing conduct, event-triggered), effective date, review cycle, current compliance status, and responsible officer. Serves as the authoritative catalog against which controls are designed, policies are written, training is mandated, and returns are filed. The single source of truth for answering what must we comply with?';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`compliance`.`control_framework` (
    `control_framework_id` BIGINT COMMENT 'Unique identifier for the compliance control framework record. Primary key.',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Control frameworks are implemented at practice area level (Lexcel for legal practice management, ISO 27001 for data-intensive practices). Practice areas adopt frameworks based on regulatory requiremen',
    `timekeeper_id` BIGINT COMMENT 'Identifier of the internal role or individual responsible for overseeing compliance with this framework (e.g., Data Protection Officer (DPO), Chief Compliance Officer, Information Security Manager). Links to workforce or role registry.',
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

CREATE OR REPLACE TABLE `legal_ecm_v1`.`compliance`.`compliance_control` (
    `compliance_control_id` BIGINT COMMENT 'Unique identifier for the compliance control record. Primary key for the compliance control entity.',
    `user_id` BIGINT COMMENT 'Reference to the user who last modified this control record. Used for audit trail and accountability purposes. Links to workforce or employee product.',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Controls are designed for specific practice areas (conflict checks in M&A, privilege logs in litigation). Control frameworks are practice-area-scoped. Required for practice-area-level control effectiv',
    `timekeeper_id` BIGINT COMMENT 'Reference to the individual (partner, director, or manager) responsible for the design, implementation, and ongoing effectiveness of the control. Typically links to workforce or employee product.',
    `control_framework_id` BIGINT COMMENT 'FK to compliance.control_framework.control_framework_id — Every control must reference its parent framework — this is the fundamental structural relationship in control management. Without this FK, you cannot answer which controls implement ISO 27001? whic',
    `regulatory_obligation_id` BIGINT COMMENT 'FK to compliance.regulatory_obligation.regulatory_obligation_id — Controls are designed to satisfy specific regulatory obligations. This FK enables the critical compliance mapping: obligation → control → test evidence. Required for any regulatory audit.',
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

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`compliance`.`aml_kyc_program` (
    `aml_kyc_program_id` BIGINT COMMENT 'Unique identifier for the firms AML/KYC program record. Primary key.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: The AML/KYC program implements the firms AML policy. N:1 relationship (many program versions per policy over time). Strengthens policy connections and helps resolve aml_kyc_program silo. No columns to',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: AML/KYC programs vary by practice area (corporate/transactional vs. litigation). Different risk profiles and regulatory requirements apply. MLRO designs practice-area-specific risk assessments, screen',
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
    `program_documentation_location` STRING COMMENT 'Reference to the storage location or document management system path where the full AML/KYC program documentation is maintained.',
    `program_name` STRING COMMENT 'Official name or title of the AML/KYC program as registered with regulatory authorities.',
    `program_scope` STRING COMMENT 'Detailed description of the scope of the AML/KYC program, including covered business lines, matter types, and jurisdictions.',
    `program_status` STRING COMMENT 'Current lifecycle status of the AML/KYC program indicating its operational state.. Valid values are `draft|active|under_review|suspended|archived`',
    `program_version` STRING COMMENT 'Version identifier for the AML/KYC program, tracking iterations and updates over time.',
    `regulatory_approval_date` DATE COMMENT 'Date when the AML/KYC program received regulatory approval or acknowledgment.',
    `regulatory_approval_status` STRING COMMENT 'Status of regulatory approval or acknowledgment of the AML/KYC program by relevant authorities.. Valid values are `pending|approved|conditionally_approved|rejected|not_required`',
    `residual_risk_rating` STRING COMMENT 'Overall residual AML/KYC risk rating after applying mitigating controls and procedures.. Valid values are `low|medium|high|very_high`',
    `risk_appetite_statement` STRING COMMENT 'Formal statement defining the firms tolerance for AML/KYC risk across client types, geographies, and service lines.',
    `risk_assessment_findings` STRING COMMENT 'Summary of key findings, observations, and recommendations from the most recent AML/KYC risk assessment.',
    `risk_assessment_frequency` STRING COMMENT 'Frequency at which enterprise-wide AML/KYC risk assessments are conducted.. Valid values are `annual|biannual|quarterly|ad_hoc|event_driven`',
    `risk_assessor_name` STRING COMMENT 'Name of the individual or team responsible for conducting the most recent AML/KYC risk assessment.',
    `risk_methodology` STRING COMMENT 'Description of the methodology, framework, or standard used to conduct the AML/KYC risk assessment.',
    `suspicious_activity_reports_filed` STRING COMMENT 'Total number of Suspicious Activity Reports filed under this program during the current reporting period.',
    `training_completion_rate` DECIMAL(18,2) COMMENT 'Percentage of required staff who have completed mandatory AML/KYC training as of the last assessment date.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the AML/KYC program record was last modified.',
    CONSTRAINT pk_aml_kyc_program PRIMARY KEY(`aml_kyc_program_id`)
) COMMENT 'Master record for the firms AML/KYC programme including enterprise-wide and matter-type-level risk assessments, as required by FATF obligations and jurisdiction-specific AML legislation. Programme attributes capture MLRO designation, programme scope, risk appetite, regulatory approval status, and applicable jurisdictions. Risk assessment attributes capture assessment date, assessor, risk categories (client, geographic, product/service, delivery channel), inherent and residual risk ratings, methodology, and findings. Provides the complete firm-level AML governance artifact distinct from individual client KYC checks owned by conflict/intake.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`compliance`.`aml_risk_assessment` (
    `aml_risk_assessment_id` BIGINT COMMENT 'Unique identifier for the AML risk assessment record.',
    `aml_kyc_program_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_kyc_program. Business justification: AML risk assessments are conducted UNDER the firms AML/KYC programme. N:1 relationship (many assessments per program over time). Resolves silo for both aml_risk_assessment and aml_kyc_program. No colu',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to ip.license_agreement. Business justification: AML risk assessment for high-value IP licensing (FRAND, cross-border, technology transfer) is required under AML/KYC programs. Essential for assessing money laundering risk in IP transactions and ensu',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: AML risk assessments are practice-area-scoped (high risk for corporate/M&A, lower for litigation). Risk ratings and controls vary by practice area. MLRO requires practice-area-level risk profiling for',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: AML risk assessments identify financial crime risks requiring enterprise risk register entries for MLRO reporting, board oversight, and regulatory examination responses. Critical for unified AML/enter',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: AML risk assessments are conducted to satisfy specific AML regulatory obligations (FATF, jurisdiction-specific AML laws). N:1 relationship (many assessments per obligation). Strengthens regulatory_obl',
    `adverse_media_screening_coverage` STRING COMMENT 'Extent to which adverse media screening is performed within the assessed risk category: full, partial, or none.. Valid values are `full|partial|none`',
    `assessment_date` DATE COMMENT 'The date on which the AML risk assessment was conducted or completed.',
    `assessment_methodology` STRING COMMENT 'Description of the methodology, framework, or approach used to conduct the AML risk assessment, such as FATF-based risk matrix, scenario analysis, or third-party framework.',
    `assessment_reference_number` STRING COMMENT 'Business-facing unique reference number for the AML risk assessment, used for tracking and reporting purposes.. Valid values are `^AML-[0-9]{4}-[0-9]{6}$`',
    `assessment_status` STRING COMMENT 'Current lifecycle status of the AML risk assessment: draft (in preparation), in review (under MLRO review), approved (active and in force), superseded (replaced by newer assessment), or archived (historical record).. Valid values are `draft|in_review|approved|superseded|archived`',
    `assessment_type` STRING COMMENT 'The scope and level of the AML risk assessment: firm-wide enterprise assessment, matter-type-level assessment, client segment assessment, geographic risk assessment, product/service risk assessment, or delivery channel assessment.. Valid values are `firm_wide|matter_type|client_segment|geographic|product_service|delivery_channel`',
    `assessor_name` STRING COMMENT 'The name of the individual or team who conducted the AML risk assessment, typically the Money Laundering Reporting Officer (MLRO) or compliance team member.',
    `assessor_role` STRING COMMENT 'The role or title of the assessor within the firm, such as MLRO, Compliance Officer, or Risk Manager.',
    `board_presentation_date` DATE COMMENT 'The date on which the AML risk assessment was presented to the firms board or senior management for review and governance oversight.',
    `control_effectiveness_rating` STRING COMMENT 'Assessment of how effectively the firms AML controls mitigate the inherent risk: ineffective, partially effective, effective, or highly effective.. Valid values are `ineffective|partially_effective|effective|highly_effective`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this AML risk assessment record was first created in the system.',
    `data_sources` STRING COMMENT 'List or description of the data sources and inputs used in the assessment, such as client intake data, transaction monitoring reports, regulatory guidance, and industry benchmarks.',
    `effective_from_date` DATE COMMENT 'The date from which this AML risk assessment becomes effective and governs the firms AML risk posture.',
    `effective_until_date` DATE COMMENT 'The date until which this AML risk assessment remains valid. Nullable for assessments without a predetermined expiry.',
    `external_audit_date` DATE COMMENT 'The date of the most recent external audit or independent review of this AML risk assessment, if applicable.',
    `external_auditor_name` STRING COMMENT 'The name of the external auditor or consulting firm that reviewed the AML risk assessment, if applicable.',
    `findings_summary` STRING COMMENT 'Narrative summary of the key findings from the AML risk assessment, including identified vulnerabilities, control gaps, and areas of elevated risk.',
    `high_risk_jurisdictions_identified` STRING COMMENT 'List of high-risk or non-cooperative jurisdictions identified in the assessment that pose elevated AML risk to the firm, based on FATF lists or internal risk criteria.',
    `inherent_risk_rating` STRING COMMENT 'The level of AML risk before considering the effect of controls and mitigations: low, medium, high, or very high.. Valid values are `low|medium|high|very_high`',
    `inherent_risk_score` DECIMAL(18,2) COMMENT 'Numeric score representing the inherent AML risk level, typically on a scale (e.g., 0-100) used for quantitative risk aggregation and trending.',
    `jurisdiction_scope` STRING COMMENT 'The geographic or jurisdictional scope of the assessment, such as specific countries, regions, or global firm-wide coverage.',
    `key_risk_indicators` STRING COMMENT 'Summary of the key risk indicators or metrics evaluated during the assessment, such as high-risk jurisdiction exposure percentage, PEP client count, or cash transaction volume.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this AML risk assessment record was last modified or updated.',
    `mlro_approval_date` DATE COMMENT 'The date on which the Money Laundering Reporting Officer formally approved the AML risk assessment.',
    `mlro_approval_name` STRING COMMENT 'The name of the Money Laundering Reporting Officer who approved the assessment.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next periodic review of this AML risk assessment, typically annually or as required by regulatory change.',
    `notes` STRING COMMENT 'Additional notes, comments, or context related to the AML risk assessment, including any special circumstances or deviations from standard methodology.',
    `pep_exposure_flag` BOOLEAN COMMENT 'Indicates whether the assessment identified material exposure to Politically Exposed Persons (PEPs) requiring enhanced due diligence.',
    `recommendations` STRING COMMENT 'Recommended actions or control enhancements to address identified risks and improve the firms AML posture, such as enhanced due diligence procedures or additional training.',
    `regulatory_framework` STRING COMMENT 'The primary regulatory framework or jurisdiction-specific AML regulations under which this assessment was conducted, such as UK Money Laundering Regulations, US Bank Secrecy Act, or FATF 40 Recommendations.',
    `regulatory_submission_date` DATE COMMENT 'The date on which the AML risk assessment was submitted to the regulatory authority, if applicable.',
    `regulatory_submission_flag` BOOLEAN COMMENT 'Indicates whether this AML risk assessment was submitted to a regulatory authority as part of compliance reporting obligations.',
    `residual_risk_rating` STRING COMMENT 'The level of AML risk remaining after applying controls and mitigations: low, medium, high, or very high. This is the net risk exposure.. Valid values are `low|medium|high|very_high`',
    `residual_risk_score` DECIMAL(18,2) COMMENT 'Numeric score representing the residual AML risk level after controls, used for quantitative risk aggregation and reporting.',
    `risk_appetite_alignment` STRING COMMENT 'Indicates whether the residual risk is within the firms stated AML risk appetite: within appetite, near limit (requires monitoring), or exceeds appetite (requires remediation).. Valid values are `within_appetite|near_limit|exceeds_appetite`',
    `risk_category` STRING COMMENT 'The primary risk category being assessed: client risk (client type, profile), geographic risk (jurisdiction exposure), product/service risk (legal service types), delivery channel risk (how services are delivered), transaction risk (payment methods, volumes), or other.. Valid values are `client|geographic|product_service|delivery_channel|transaction|other`',
    `risk_subcategory` STRING COMMENT 'A more granular classification within the primary risk category, such as specific client segment, jurisdiction, or service line.',
    `sanctions_screening_coverage` STRING COMMENT 'Extent to which sanctions screening controls are applied within the assessed risk category: full (all clients/matters screened), partial (selective screening), or none.. Valid values are `full|partial|none`',
    `transaction_monitoring_coverage` STRING COMMENT 'Extent to which transaction monitoring controls are applied within the assessed risk category: full, partial, or none.. Valid values are `full|partial|none`',
    `version_number` STRING COMMENT 'Version number of the AML risk assessment, incremented with each revision or update to track assessment evolution over time.',
    CONSTRAINT pk_aml_risk_assessment PRIMARY KEY(`aml_risk_assessment_id`)
) COMMENT 'Firm-level and matter-type-level AML risk assessments conducted under FATF and jurisdiction-specific AML regulations. Captures assessment date, assessor, risk category (client, geographic, product/service, delivery channel), inherent risk rating, residual risk rating after controls, assessment methodology, findings narrative, and next scheduled review. Supports the firms enterprise-wide AML risk posture distinct from individual client due diligence.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`compliance`.`sar_filing` (
    `sar_filing_id` BIGINT COMMENT 'Unique identifier for the SAR filing record. Primary key.',
    `legal_document_id` BIGINT COMMENT 'Foreign key linking to document.legal_document. Business justification: SAR submissions are formal regulatory filings: NCA SAR Online submission, consent request to NCA, DAML/DAPOL defense documentation. Required for linking SAR register to actual filing documents for reg',
    `matter_id` BIGINT COMMENT 'Reference to the matter or engagement associated with the suspicious activity, if applicable.',
    `aml_kyc_program_id` BIGINT COMMENT 'FK to compliance.aml_kyc_program.aml_kyc_program_id — SAR filings are made under the authority of the AML programme and by the MLRO designated in that programme. This link is essential for programme-level reporting on SAR activity.',
    `timekeeper_id` BIGINT COMMENT 'Reference to the Money Laundering Reporting Officer who authorized and submitted the SAR.',
    `profile_id` BIGINT COMMENT 'Reference to the client involved in the suspicious activity, if applicable.',
    `regulatory_breach_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_breach. Business justification: Failure to file required SARs within statutory deadlines constitutes a regulatory breach requiring notification and remediation. Compliance violation. Links SAR to breach record when filing obligation',
    `sanctions_check_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_check. Business justification: Suspicious Activity Reports are often triggered by sanctions screening hits. The sar_filing table has suspicion_category which may include sanctions-related categories. Linking the SAR to the specific',
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

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`compliance`.`data_privacy_register` (
    `data_privacy_register_id` BIGINT COMMENT 'Unique identifier for the data privacy register entry. Primary key. Inferred role: MASTER_RESOURCE (registry entry for processing activity or DPIA). _canonical_skip_reason: Not applicable - this is a hybrid master/reference entity combining RoPA and DPIA entries; minimum categories applied as MASTER_RESOURCE.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Processing activities in the data privacy register are governed by the firms data privacy policy. N:1 relationship (many processing activities per policy). Strengthens policy connections. No columns t',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: ROPA entries are practice-area-specific (client data processing in employment law, IP portfolio data in patent practice). Processing activities vary by practice area. DPO requires practice-area-level ',
    `controller_contact_email` STRING COMMENT 'Email address of the data controller contact person.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `controller_contact_name` STRING COMMENT 'Name of the representative or contact person for the data controller.',
    `controller_name` STRING COMMENT 'Legal name of the data controller responsible for determining the purposes and means of processing. Typically the law firm or its legal entity.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this register entry was first created in the system.',
    `data_privacy_register_status` STRING COMMENT 'Current lifecycle status of the register entry: draft (being prepared), active (in force), under_review (periodic review or audit), suspended (temporarily inactive), archived (historical record).. Valid values are `draft|active|under_review|suspended|archived`',
    `data_subject_categories` STRING COMMENT 'Categories of individuals whose personal data is processed (e.g., clients, employees, opposing parties, witnesses, vendors, job applicants). Pipe-separated list.',
    `dpia_completion_date` DATE COMMENT 'Date on which the DPIA was completed, if applicable.',
    `dpia_mitigation_measures` STRING COMMENT 'Measures envisaged to address the identified risks, including safeguards, security measures, and mechanisms to ensure protection of personal data, as required under GDPR Article 35(7)(d).',
    `dpia_necessity_assessment` STRING COMMENT 'Assessment of the necessity and proportionality of the processing operations in relation to the purposes, as required under GDPR Article 35(7)(b).',
    `dpia_required_flag` BOOLEAN COMMENT 'Indicates whether a DPIA is required for this processing activity under GDPR Article 35 (high risk to rights and freedoms of data subjects).',
    `dpia_risk_identification` STRING COMMENT 'Identification of risks to the rights and freedoms of data subjects arising from the processing, as required under GDPR Article 35(7)(c).',
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

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`compliance`.`dpia` (
    `dpia_id` BIGINT COMMENT 'Unique identifier for the Data Protection Impact Assessment record. Primary key.',
    `assessment_id` BIGINT COMMENT 'Foreign key linking to risk.risk_assessment. Business justification: DPIAs are specialized risk assessments for data protection under GDPR Article 35. DPIA process feeds enterprise risk assessment for privacy risks, enabling unified risk treatment and ICO consultation ',
    `data_privacy_register_id` BIGINT COMMENT 'Foreign key linking to compliance.data_privacy_register. Business justification: DPIAs are conducted FOR specific processing activities registered in the data privacy register. N:1 relationship (many DPIAs per processing activity over time as risks change). Resolves silo for data_',
    `legal_document_id` BIGINT COMMENT 'Foreign key linking to document.legal_document. Business justification: DPIA outputs documented in formal assessment reports: GDPR Article 35 DPIA report, ICO DPIA template completion, supervisory authority consultation correspondence. Required for linking DPIA register e',
    `matter_id` BIGINT COMMENT 'Reference to the client matter or engagement for which this DPIA is being conducted, if applicable. Links to the Matter domain for client-facing processing activities.',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: DPIAs are triggered by practice-area-specific processing (automated document review in litigation, AI contract analysis in corporate). Risk assessments are practice-area-contextualized. DPO requires p',
    `profile_id` BIGINT COMMENT 'Reference to the client organization for whom this processing activity is being performed, if the DPIA relates to client-specific data processing.',
    `approval_date` DATE COMMENT 'Date on which the DPIA was formally approved.',
    `approval_status` STRING COMMENT 'Final approval status indicating whether the processing activity may proceed based on the DPIA outcome.. Valid values are `pending|approved|conditionally_approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the individual who approved the DPIA (typically a senior compliance officer, DPO, or General Counsel).',
    `assessment_completion_date` DATE COMMENT 'Date on which the DPIA assessment was completed and submitted for review.',
    `assessment_conducted_by` STRING COMMENT 'Name or identifier of the individual or team responsible for conducting the DPIA.',
    `assessment_reference_number` STRING COMMENT 'Business-facing unique reference number for the DPIA, typically formatted as DPIA-YYYY-NNNN for external communication and audit trails.. Valid values are `^DPIA-[0-9]{4}-[0-9]{4}$`',
    `assessment_start_date` DATE COMMENT 'Date on which the DPIA assessment process was initiated.',
    `assessment_status` STRING COMMENT 'Current lifecycle status of the DPIA in the review and approval workflow. [ENUM-REF-CANDIDATE: draft|under_review|dpo_review|awaiting_authority_consultation|approved|rejected|requires_revision — 7 candidates stripped; promote to reference product]',
    `assessment_title` STRING COMMENT 'Descriptive title of the DPIA identifying the processing activity or project being assessed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this DPIA record was first created in the system.',
    `data_categories` STRING COMMENT 'Categories of personal data involved in the processing activity (e.g., contact details, financial data, special category data, criminal conviction data). Comma-separated list.',
    `data_controller_name` STRING COMMENT 'Name of the legal entity acting as data controller for the processing activity under assessment (typically the firm itself or a client).',
    `data_minimization_measures` STRING COMMENT 'Description of measures implemented to ensure only the minimum necessary personal data is collected and processed.',
    `data_processor_name` STRING COMMENT 'Name of any third-party data processor involved in the processing activity, if applicable.',
    `data_subject_categories` STRING COMMENT 'Categories of individuals whose personal data is being processed (e.g., clients, employees, opposing parties, witnesses, beneficiaries). Comma-separated list.',
    `data_subjects_consulted_flag` BOOLEAN COMMENT 'Indicates whether data subjects or their representatives were consulted regarding the processing, where appropriate.',
    `dpo_advice` STRING COMMENT 'Summary of advice and recommendations provided by the DPO during consultation.',
    `dpo_consultation_date` DATE COMMENT 'Date on which the DPO was consulted regarding the DPIA.',
    `dpo_consulted_flag` BOOLEAN COMMENT 'Indicates whether the Data Protection Officer was consulted during the DPIA process as required under GDPR Article 35(2).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this DPIA record was most recently modified.',
    `last_review_date` DATE COMMENT 'Date on which the DPIA was most recently reviewed and updated.',
    `lawful_basis` STRING COMMENT 'The lawful basis under GDPR Article 6 that justifies the processing activity.. Valid values are `consent|contract|legal_obligation|vital_interests|public_task|legitimate_interests`',
    `mitigation_measures` STRING COMMENT 'Description of technical and organizational measures implemented to mitigate identified risks, including safeguards, security measures, and mechanisms to ensure protection of personal data.',
    `necessity_assessment` STRING COMMENT 'Assessment of whether the processing is necessary to achieve the stated purpose, and whether the purpose could be achieved through less intrusive means.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review of this DPIA.',
    `processing_purpose` STRING COMMENT 'The specific business or legal purpose for which the personal data is being processed (e.g., client matter management, litigation support, regulatory compliance, employee performance management).',
    `proportionality_assessment` STRING COMMENT 'Assessment of whether the processing is proportionate to the purpose, considering the rights and freedoms of data subjects and the benefits to the controller and society.',
    `residual_risk_level` STRING COMMENT 'Assessed risk level remaining after mitigation measures have been applied.. Valid values are `low|medium|high|very_high`',
    `retention_period` STRING COMMENT 'The period for which personal data will be retained, or the criteria used to determine that period.',
    `review_frequency` STRING COMMENT 'Scheduled frequency for reviewing and updating the DPIA to ensure it remains current and accurate.. Valid values are `annual|biannual|quarterly|on_change|continuous`',
    `risk_identification_summary` STRING COMMENT 'Summary of identified risks to the rights and freedoms of data subjects arising from the processing activity, including likelihood and severity assessment.',
    `risk_level` STRING COMMENT 'Overall assessed risk level to data subjects after considering likelihood and severity of potential impacts.. Valid values are `low|medium|high|very_high`',
    `special_category_data_flag` BOOLEAN COMMENT 'Indicates whether the processing involves special category data as defined under GDPR Article 9 (racial/ethnic origin, political opinions, religious beliefs, trade union membership, genetic data, biometric data, health data, sex life, or sexual orientation).',
    `supervisory_authority_consultation_date` DATE COMMENT 'Date on which the supervisory authority was consulted, if required.',
    `supervisory_authority_consultation_required_flag` BOOLEAN COMMENT 'Indicates whether prior consultation with the supervisory authority is required because the DPIA indicates high residual risk that cannot be adequately mitigated.',
    `supervisory_authority_decision` STRING COMMENT 'Summary of the decision or guidance provided by the supervisory authority following consultation.',
    `supervisory_authority_reference` STRING COMMENT 'Reference number or identifier assigned by the supervisory authority for the consultation, if applicable.',
    `trigger_reason` STRING COMMENT 'The specific criterion under GDPR Article 35(3) or supervisory authority guidance that triggered the requirement to conduct this DPIA. [ENUM-REF-CANDIDATE: systematic_monitoring|automated_decision_making|large_scale_special_category|large_scale_criminal_data|innovative_technology|data_matching|profiling|biometric_data|genetic_data|location_tracking|vulnerable_data_subjects|cross_border_transfer — 12 candidates stripped; promote to reference product]',
    `vulnerable_data_subjects_flag` BOOLEAN COMMENT 'Indicates whether the processing involves vulnerable data subjects such as children, elderly, mentally incapacitated individuals, or employees in an imbalanced power relationship.',
    CONSTRAINT pk_dpia PRIMARY KEY(`dpia_id`)
) COMMENT 'Data Protection Impact Assessment (DPIA) records conducted for high-risk processing activities as required under GDPR Article 35. Captures assessment trigger, processing description, necessity and proportionality assessment, risk identification, risk mitigation measures, DPO consultation outcome, supervisory authority consultation requirement flag, approval status, and review schedule. Owned by the DPO function within the compliance domain.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` (
    `data_subject_request_id` BIGINT COMMENT 'Unique identifier for the data subject request. Primary key for this entity.',
    `timekeeper_id` BIGINT COMMENT 'Foreign key linking to workforce.timekeeper. Business justification: Data subject requests (GDPR SARs, erasure requests) are assigned to specific DPO team timekeepers for handling. Linking to timekeeper enables workload balancing, response time tracking by handler, and',
    `client_contact_id` BIGINT COMMENT 'Foreign key linking to client.contact. Business justification: Data subject requests (GDPR, CCPA) often come from known client contacts. This FK links the request to the contact master when the requestor is a client contact. is_new_attribute=true because contact_',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Data subject requests are handled according to the firms data privacy policy. N:1 relationship (many requests per policy). Resolves silo for data_subject_request. No columns to remove - request-specif',
    `legal_document_id` BIGINT COMMENT 'Foreign key linking to document.legal_document. Business justification: DSR responses documented in formal correspondence: GDPR Article 15 subject access response letter, Article 17 erasure confirmation, Article 21 objection acknowledgment. Required for linking DSR regist',
    `data_privacy_register_id` BIGINT COMMENT 'FK to compliance.data_privacy_register.data_privacy_register_id — Data subject requests relate to specific processing activities documented in the RoPA. Linking DSRs to the relevant processing activity enables the DPO to assess scope and respond accurately.',
    `privacy_breach_id` BIGINT COMMENT 'Foreign key linking to compliance.privacy_breach. Business justification: Data subject requests are often filed by individuals affected by privacy breaches (e.g., requesting confirmation of what data was exposed, requesting deletion after a breach). Linking the DSR to the b',
    `authorized_representative_flag` BOOLEAN COMMENT 'Indicates whether the request is being made by an authorized representative on behalf of the data subject (e.g., parent, guardian, attorney, executor).',
    `complaint_lodged_flag` BOOLEAN COMMENT 'Indicates whether the data subject has lodged a formal complaint with the supervisory authority (ICO, CNIL, etc.) regarding the handling of their request.',
    `complaint_reference` STRING COMMENT 'Reference number of the complaint lodged with the supervisory authority, if applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this data subject request record was first created in the system.',
    `data_subject_address` STRING COMMENT 'Postal address of the data subject. Used for identity verification and postal correspondence.',
    `data_subject_identifier` STRING COMMENT 'Internal firm identifier for the data subject (e.g., client ID, contact ID, employee ID) if the individual is known to the firm.',
    `data_volume_pages` STRING COMMENT 'Total number of pages of personal data provided to the data subject in response to the request.',
    `data_volume_records` STRING COMMENT 'Total number of database records or data entries provided to the data subject in response to the request.',
    `escalation_date` DATE COMMENT 'Date on which the data subject request was escalated.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the request has been escalated to senior management, legal counsel, or external advisors due to complexity, sensitivity, or dispute.',
    `escalation_reason` STRING COMMENT 'Reason for escalating the data subject request, such as legal complexity, high-profile client, or potential regulatory complaint.',
    `exemption_applied` STRING COMMENT 'Legal exemption applied to withhold or redact certain data from the response, such as Legal Professional Privilege (LPP), third-party rights, or ongoing litigation.',
    `extended_deadline_date` DATE COMMENT 'Extended deadline date if an extension has been granted. GDPR allows up to 2 additional months; CCPA allows up to 45 additional days.',
    `extension_applied_flag` BOOLEAN COMMENT 'Indicates whether the firm has applied for and communicated an extension to the statutory deadline due to complexity or volume.',
    `extension_reason` STRING COMMENT 'Reason provided to the data subject for extending the statutory deadline, such as complexity or volume of requests.',
    `identity_verification_date` DATE COMMENT 'Date on which the data subjects identity was successfully verified.',
    `identity_verification_method` STRING COMMENT 'Method used to verify the identity of the data subject making the request. [ENUM-REF-CANDIDATE: government_id|passport|utility_bill|credit_reference|knowledge_based|biometric|existing_client_records — 7 candidates stripped; promote to reference product]',
    `identity_verification_status` STRING COMMENT 'Status of identity verification process to confirm the requestor is the legitimate data subject or authorized representative.. Valid values are `not_started|pending|verified|failed|exemption_applied`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this data subject request record was last modified or updated.',
    `lpp_exemption_flag` BOOLEAN COMMENT 'Indicates whether Legal Professional Privilege exemption was applied to withhold privileged communications between lawyer and client.',
    `notes` STRING COMMENT 'Free-text notes and comments regarding the handling of the data subject request, including internal communications, decisions, and special circumstances.',
    `outcome` STRING COMMENT 'Final outcome of the data subject request after processing and response.. Valid values are `fully_granted|partially_granted|refused|withdrawn_by_subject|no_data_held`',
    `processing_time_days` STRING COMMENT 'Total number of calendar days taken to process and respond to the data subject request, from receipt to response.',
    `receipt_channel` STRING COMMENT 'Channel through which the data subject request was received by the firm.. Valid values are `email|postal_mail|web_portal|phone|in_person|third_party_representative`',
    `receipt_date` DATE COMMENT 'Date the data subject request was received by the firm. Used to calculate statutory response deadline.',
    `receipt_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the data subject request was received, including time zone. Used for audit trail and SLA tracking.',
    `refusal_reason` STRING COMMENT 'Detailed reason for refusing the data subject request, if applicable. Must be communicated to the data subject with information about complaint rights.',
    `regulatory_jurisdiction` STRING COMMENT 'Primary regulatory jurisdiction governing this data subject request (e.g., UK for GDPR/DPA, California for CCPA). ISO 3166-1 alpha-3 country code. [ENUM-REF-CANDIDATE: GBR|USA|DEU|FRA|IRL|NLD|ESP|ITA|AUS|CAN — 10 candidates stripped; promote to reference product]',
    `representative_name` STRING COMMENT 'Full name of the authorized representative making the request on behalf of the data subject, if applicable.',
    `representative_relationship` STRING COMMENT 'Relationship of the authorized representative to the data subject.. Valid values are `parent|guardian|attorney|executor|power_of_attorney|other`',
    `request_reference_number` STRING COMMENT 'Externally-facing unique reference number provided to the data subject for tracking purposes. Format: DSR-YYYYMMDD-XXXXXX.. Valid values are `^DSR-[0-9]{8}-[A-Z0-9]{6}$`',
    `request_scope_description` STRING COMMENT 'Detailed description of the scope of the data subject request, including specific data categories, time periods, or systems requested by the data subject.',
    `request_status` STRING COMMENT 'Current lifecycle status of the data subject request in the DPO workflow. [ENUM-REF-CANDIDATE: received|identity_verification_pending|identity_verified|under_review|in_progress|awaiting_approval|completed|rejected|withdrawn|escalated — 10 candidates stripped; promote to reference product]',
    `request_type` STRING COMMENT 'Type of data subject rights request under GDPR/CCPA/DPA. Subject Access Request (SAR) is the most common type.. Valid values are `subject_access_request|right_to_erasure|right_to_rectification|right_to_data_portability|right_to_object|right_to_restrict_processing`',
    `response_date` DATE COMMENT 'Date on which the firm provided its response to the data subject request.',
    `response_method` STRING COMMENT 'Method used to deliver the response to the data subject.. Valid values are `email|postal_mail|secure_portal|encrypted_file|in_person|phone`',
    `statutory_deadline_date` DATE COMMENT 'Statutory deadline by which the firm must respond to the data subject request. Typically 30 calendar days from receipt under GDPR, 45 days under CCPA.',
    `systems_searched` STRING COMMENT 'Comma-separated list of internal systems and databases searched to fulfill the data subject request (e.g., Elite 3E, iManage, Relativity, email archives).',
    `third_party_data_flag` BOOLEAN COMMENT 'Indicates whether the request involves personal data of third parties that must be redacted or exempted from disclosure.',
    CONSTRAINT pk_data_subject_request PRIMARY KEY(`data_subject_request_id`)
) COMMENT 'Tracks individual data subject rights requests received and processed by the firm under GDPR, CCPA, and DPA, including Subject Access Requests (SARs), right to erasure, right to rectification, data portability, and objection requests. Captures request type, receipt date, identity verification status, response due date (statutory deadline), response date, outcome, exemptions applied (e.g., LPP), and escalation history. Managed by the DPO function.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` (
    `privacy_breach_id` BIGINT COMMENT 'Primary key for privacy_breach',
    `attorney_profile_id` BIGINT COMMENT 'Foreign key reference to the partner or senior lawyer responsible for overseeing the breach response and client communication.',
    `data_privacy_register_id` BIGINT COMMENT 'FK to compliance.data_privacy_register.data_privacy_register_id — Privacy breaches relate to specific processing activities. The breach assessment requires knowing what data categories and subjects are affected, which is documented in the RoPA entry.',
    `legal_document_id` BIGINT COMMENT 'Foreign key linking to document.legal_document. Business justification: Breach notifications to ICO/data subjects are legal documents: GDPR Article 33 supervisory authority notification, Article 34 data subject notification. Required for linking breach register to actual ',
    `matter_id` BIGINT COMMENT 'Foreign key reference to the client matter associated with the breach, if the breach relates to client data processed in the context of a specific legal matter.',
    `primary_data_privacy_register_id` BIGINT COMMENT 'Foreign key linking to compliance.data_privacy_register. Business justification: Privacy breaches occur in the context of specific processing activities. N:1 relationship (many breaches per processing activity). Strengthens connections for data_privacy_register. No columns to remo',
    `user_id` BIGINT COMMENT 'User identifier of the person who created this breach incident record. Audit trail field.',
    `privacy_last_modified_by_user_id` BIGINT COMMENT 'User identifier of the person who last modified this breach incident record. Audit trail field.',
    `profile_id` BIGINT COMMENT 'Foreign key reference to the client whose personal data was affected by the breach, if applicable.',
    `data_breach_incident_id` BIGINT COMMENT 'Foreign key linking to risk.data_breach_incident. Business justification: Privacy breaches (GDPR/ICO perspective) and data breach incidents (risk management perspective) represent the same event. Compliance record must reference canonical risk incident for unified breach re',
    `timekeeper_id` BIGINT COMMENT 'Foreign key reference to the compliance or IT staff member assigned as the incident owner responsible for coordinating the breach response.',
    `affected_data_categories` STRING COMMENT 'Comma-separated list or structured description of the categories of personal data affected by the breach (e.g., names, contact details, financial information, special category data under GDPR Article 9).',
    `affected_system_name` STRING COMMENT 'Name of the IT system, application, or platform from which the breach originated or which was compromised.',
    `breach_cause` STRING COMMENT 'Root cause category of the breach incident. Used for trend analysis and preventive control design. [ENUM-REF-CANDIDATE: human_error|system_failure|malicious_attack|third_party_failure|physical_loss|unauthorised_access|misconfiguration — 7 candidates stripped; promote to reference product]',
    `breach_description` STRING COMMENT 'Detailed narrative description of the nature of the breach, including circumstances, systems affected, and how the breach occurred.',
    `breach_location` STRING COMMENT 'Physical or logical location where the breach occurred (e.g., office location, system name, third-party processor).',
    `breach_status` STRING COMMENT 'Current lifecycle status of the breach incident in the firms incident response workflow.. Valid values are `reported|under_investigation|contained|remediated|closed`',
    `breach_type` STRING COMMENT 'Classification of the breach according to GDPR Article 4(12) categories: accidental or unlawful destruction, loss, alteration, unauthorised disclosure of, or access to, personal data.. Valid values are `accidental_loss|accidental_destruction|accidental_alteration|unauthorised_disclosure|unauthorised_access|unlawful_processing`',
    `containment_date` TIMESTAMP COMMENT 'Date and time when the breach was successfully contained and no further data loss was occurring.',
    `containment_measures_taken` STRING COMMENT 'Description of immediate actions taken to contain the breach and prevent further data loss or unauthorised access.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this breach incident record was first created in the system. Audit trail field.',
    `data_records_count` STRING COMMENT 'Approximate or exact number of personal data records affected by the breach. May differ from data subjects count if multiple records per subject exist.',
    `data_subject_notification_date` TIMESTAMP COMMENT 'Date and time when affected data subjects were notified of the breach. Required without undue delay under GDPR Article 34(1).',
    `data_subject_notification_method` STRING COMMENT 'Method used to notify affected data subjects of the breach (e.g., direct email, postal mail, public communication if individual contact is disproportionate).. Valid values are `email|postal_mail|phone|public_communication|website_notice`',
    `data_subject_notification_required_flag` BOOLEAN COMMENT 'Indicates whether direct notification to affected data subjects is required under GDPR Article 34. True if the breach is likely to result in high risk to data subjects.',
    `data_subjects_count` STRING COMMENT 'Approximate or exact number of data subjects (individuals) whose personal data was affected by the breach. Required for regulatory notification under GDPR Article 33(3)(b).',
    `discovery_date` TIMESTAMP COMMENT 'Date and time when the breach was first discovered or became known to the firm. Critical for calculating the 72-hour notification window under GDPR.',
    `discovery_method` STRING COMMENT 'How the breach was identified: through internal monitoring, external notification, audit, or other means.. Valid values are `internal_audit|system_alert|employee_report|client_complaint|third_party_notification|regulatory_inquiry`',
    `dpo_notification_date` TIMESTAMP COMMENT 'Date and time when the DPO was notified of the breach incident.',
    `dpo_notified_flag` BOOLEAN COMMENT 'Indicates whether the firms Data Protection Officer (DPO) was notified of the breach. True if DPO was notified.',
    `incident_date` TIMESTAMP COMMENT 'Date and time when the breach incident occurred or is estimated to have occurred. This is the actual event timestamp, distinct from discovery or reporting dates.',
    `incident_reference_number` STRING COMMENT 'Business-facing unique reference number assigned to the breach incident for tracking and communication purposes. Used in regulatory notifications and internal reporting.',
    `insurance_claim_filed_flag` BOOLEAN COMMENT 'Indicates whether a claim was filed under the firms professional indemnity or cyber insurance policy for costs related to the breach. True if claim was filed.',
    `insurance_claim_reference` STRING COMMENT 'Reference number of the insurance claim filed in relation to the breach incident, if applicable.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this breach incident record was last updated. Audit trail field.',
    `post_incident_review_completed_flag` BOOLEAN COMMENT 'Indicates whether a post-incident review or lessons-learned analysis has been completed. True if review is complete.',
    `post_incident_review_date` TIMESTAMP COMMENT 'Date when the post-incident review was completed and findings documented.',
    `post_incident_review_outcome` STRING COMMENT 'Summary of findings, lessons learned, and recommendations from the post-incident review. Used to improve controls and prevent recurrence.',
    `preventive_controls_implemented` STRING COMMENT 'Description of new or enhanced controls implemented as a result of the breach to prevent similar incidents in the future.',
    `regulatory_penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty or fine imposed by the supervisory authority as a result of the breach, if any. Null if no penalty was imposed.',
    `regulatory_penalty_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the regulatory penalty amount (e.g., GBP, EUR, USD).. Valid values are `^[A-Z]{3}$`',
    `remediation_actions_taken` STRING COMMENT 'Description of measures taken or proposed to address the breach and mitigate its possible adverse effects, as required under GDPR Article 33(3)(d).',
    `remediation_completion_date` TIMESTAMP COMMENT 'Date and time when all remediation actions were completed and the incident was fully resolved.',
    `risk_assessment_rationale` STRING COMMENT 'Detailed explanation of the risk assessment conclusion, including factors considered such as nature of data, likelihood of misuse, and potential consequences to data subjects.',
    `risk_assessment_to_data_subjects` STRING COMMENT 'Assessment of the likely risk to the rights and freedoms of data subjects as a result of the breach. Determines notification obligations under GDPR Article 34.. Valid values are `low|medium|high|critical`',
    `special_category_data_involved_flag` BOOLEAN COMMENT 'Indicates whether the breach involved special categories of personal data as defined in GDPR Article 9 (racial/ethnic origin, political opinions, religious beliefs, health data, biometric data, etc.). True if special category data was affected.',
    `supervisory_authority_name` STRING COMMENT 'Name of the supervisory authority to which the breach was notified (e.g., Information Commissioners Office (ICO), CNIL, BfDI).',
    `supervisory_authority_notification_date` TIMESTAMP COMMENT 'Date and time when the breach was notified to the supervisory authority. Must be within 72 hours of discovery unless delay is justified under GDPR Article 33(1).',
    `supervisory_authority_notification_required_flag` BOOLEAN COMMENT 'Indicates whether notification to the supervisory authority (ICO in UK, or relevant EU DPA) is required under GDPR Article 33. True if notification is mandatory.',
    `supervisory_authority_reference_number` STRING COMMENT 'Reference or case number assigned by the supervisory authority upon receipt of the breach notification.',
    CONSTRAINT pk_privacy_breach PRIMARY KEY(`privacy_breach_id`)
) COMMENT 'Records of personal data breaches as defined under GDPR Article 4(12), including accidental or unlawful destruction, loss, alteration, or unauthorised disclosure of PII. Captures incident date, discovery date, breach type, affected data categories, number of data subjects impacted, risk assessment to data subjects, ICO/supervisory authority notification requirement flag, notification date, remediation actions, and post-incident review outcome. Owned by the DPO/compliance function.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` (
    `regulatory_return_id` BIGINT COMMENT 'Unique identifier for the regulatory return or filing. Primary key.',
    `legal_document_id` BIGINT COMMENT 'Foreign key linking to document.legal_document. Business justification: Regulatory returns are legal documents: SRA annual regulatory return, accountants report under SRA Accounts Rules, diversity data report. Required for linking regulatory return register to actual sub',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Regulatory returns are practice-area-specific (SRA accounts rules for client money, SQE reporting for training). Filing requirements vary by practice area. Required for practice-area-level regulatory ',
    `timekeeper_id` BIGINT COMMENT 'Foreign key linking to workforce.timekeeper. Business justification: Regulatory returns (SRA, SolicitorConnect, AML returns) require named timekeeper as preparer for audit trails, quality control, and regulatory accountability. Firms track who prepared each filing for ',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Regulatory returns are filed to satisfy regulatory obligations. N:1 relationship (many returns per obligation). Resolves silo for regulatory_return. No visible columns to remove - regulatory_body and ',
    `regulatory_breach_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_breach. Business justification: Regulatory returns are often filed to report breaches to governing bodies (SRA, ICO, etc.). The return_type attribute includes breach_type, and breach_indicator is a boolean flag. Linking the return',
    `accountant_name` STRING COMMENT 'Name of the external accountant or accounting firm that prepared or certified the accountants report (applicable for SRA Accountants Report and similar filings).',
    `accountant_registration_number` STRING COMMENT 'Professional registration or license number of the external accountant or accounting firm (e.g., ICAEW membership number, CPA license number).',
    `approval_date` DATE COMMENT 'Date on which the regulatory return was formally approved for submission.',
    `approver_name` STRING COMMENT 'Name of the individual who provided final approval for submission of the regulatory return (e.g., Managing Partner, COFA, Board Chair).',
    `approver_role` STRING COMMENT 'Job title or role of the individual who approved the return for submission (e.g., Managing Partner, COFA, Board Chair).',
    `breach_description` STRING COMMENT 'Detailed narrative description of the regulatory breach or compliance incident, including circumstances, impact, and parties affected. Applicable only when breach_indicator is True.',
    `breach_discovery_date` DATE COMMENT 'Date on which the regulatory breach or compliance incident was first discovered or identified by the firm. Applicable only when breach_indicator is True.',
    `breach_indicator` BOOLEAN COMMENT 'Flag indicating whether this return is related to a regulatory breach or compliance incident (True if breach-related, False otherwise).',
    `breach_occurrence_date` DATE COMMENT 'Date on which the regulatory breach or compliance incident actually occurred (may differ from discovery date). Applicable only when breach_indicator is True.',
    `breach_severity` STRING COMMENT 'Severity level of the regulatory breach or compliance incident (e.g., low, medium, high, critical). Applicable only when breach_indicator is True.. Valid values are `low|medium|high|critical`',
    `breach_type` STRING COMMENT 'Classification of the regulatory breach or compliance incident being reported (e.g., client money breach, conflict of interest, data breach, AML/KYC failure, professional indemnity lapse). Applicable only when breach_indicator is True. [ENUM-REF-CANDIDATE: client_money_breach|conflict_of_interest|data_breach|aml_kyc_failure|professional_indemnity_lapse|accounts_rules_breach|conduct_breach|other — 8 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the regulatory return record was first created in the system.',
    `jurisdiction` STRING COMMENT 'Legal jurisdiction or geographic scope of the regulatory return (e.g., England and Wales, California, New York, Federal).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the regulatory return record was last updated or modified in the system.',
    `modified_by` STRING COMMENT 'Name or identifier of the user who last modified the regulatory return record.',
    `notes` STRING COMMENT 'Additional internal notes, comments, or context related to the regulatory return, its preparation, submission, or regulatory response.',
    `preparer_role` STRING COMMENT 'Job title or role of the individual who prepared the return (e.g., Compliance Officer for Legal Practice (COLP), Compliance Officer for Finance and Administration (COFA), DPO).',
    `query_response_date` DATE COMMENT 'Actual date on which the firm submitted its response to regulatory queries or requests for additional information.',
    `query_response_due_date` DATE COMMENT 'Deadline by which the firm must respond to regulatory queries or requests for additional information.',
    `regulatory_acknowledgement_date` DATE COMMENT 'Date on which the regulatory body formally acknowledged receipt of the return or filing.',
    `regulatory_body` STRING COMMENT 'Name of the governing or regulatory body to which the return is submitted (e.g., Solicitors Regulation Authority, Legal Services Board, State Bar of California, ABA).',
    `regulatory_findings` STRING COMMENT 'Summary of any findings, observations, or concerns raised by the regulatory body during review of the return.',
    `regulatory_queries` STRING COMMENT 'Record of any queries, questions, or requests for additional information issued by the regulatory body in relation to the return.',
    `regulatory_reference_number` STRING COMMENT 'Reference number or case identifier assigned by the regulatory body upon receipt or review of the return.',
    `remediation_actions` STRING COMMENT 'Description of corrective and preventive actions taken or planned to address the breach and prevent recurrence. Applicable only when breach_indicator is True.',
    `remediation_completion_date` DATE COMMENT 'Date on which all remediation actions were completed or are expected to be completed. Applicable only when breach_indicator is True.',
    `reporting_period_end_date` DATE COMMENT 'End date of the period covered by the regulatory return (e.g., fiscal year end, calendar year end).',
    `reporting_period_start_date` DATE COMMENT 'Start date of the period covered by the regulatory return (e.g., fiscal year start, calendar year start).',
    `return_number` STRING COMMENT 'External reference number or identifier assigned to the regulatory return by the firm or regulatory body (e.g., SRA Annual Report 2024-001).',
    `return_type` STRING COMMENT 'Classification of the regulatory return or filing (e.g., SRA Annual Report, COFA Certificate, Accountants Report, Regulatory Breach Notification, Remediation Plan). [ENUM-REF-CANDIDATE: annual_report|accountants_report|cofa_certificate|regulatory_breach_notification|remediation_plan|compliance_certificate|financial_return|practice_information_return|diversity_report|client_money_report — 10 candidates stripped; promote to reference product]',
    `reviewer_name` STRING COMMENT 'Name of the individual who reviewed the regulatory return prior to submission (e.g., Managing Partner, General Counsel, Chief Legal Officer).',
    `reviewer_role` STRING COMMENT 'Job title or role of the individual who reviewed the return (e.g., Managing Partner, General Counsel (GC), Chief Legal Officer (CLO)).',
    `root_cause_analysis` STRING COMMENT 'Analysis of the underlying root cause(s) of the regulatory breach or compliance incident (e.g., process failure, system error, human error, inadequate controls). Applicable only when breach_indicator is True.',
    `submission_date` DATE COMMENT 'Actual date on which the regulatory return was submitted to the regulatory body.',
    `submission_due_date` DATE COMMENT 'Regulatory deadline by which the return must be submitted to the governing body.',
    `submission_method` STRING COMMENT 'Method or channel used to submit the regulatory return (e.g., online portal, email, postal mail, electronic filing system).. Valid values are `online_portal|email|postal_mail|electronic_filing_system|in_person`',
    `submission_status` STRING COMMENT 'Current lifecycle status of the regulatory return (e.g., draft, pending review, submitted, acknowledged, accepted, rejected, remediation required). [ENUM-REF-CANDIDATE: draft|pending_review|pending_approval|submitted|acknowledged|under_review|accepted|rejected|remediation_required — 9 candidates stripped; promote to reference product]',
    `supporting_documents` STRING COMMENT 'List or reference to supporting documentation submitted with the regulatory return (e.g., accountants report, financial statements, audit reports, evidence of remediation).',
    CONSTRAINT pk_regulatory_return PRIMARY KEY(`regulatory_return_id`)
) COMMENT 'Regulatory returns, periodic filings, and breach notifications submitted to governing bodies such as the SRA, Legal Services Board, ABA, state bar associations, and financial regulators. Covers routine returns (SRA Annual Report, COFA certificate, accountants report) and event-triggered filings (regulatory breach notifications, remediation plans). Captures return/filing type, reporting period, submission details, regulatory body, preparer, reviewer, approval status, breach severity and root cause where applicable, and any regulatory findings or queries raised. Serves as the SSOT for all firm-level regulatory submissions and compliance incident reporting.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`compliance`.`compliance_control_test` (
    `compliance_control_test_id` BIGINT COMMENT 'Unique identifier for the control test record. Primary key.',
    `audit_program_id` BIGINT COMMENT 'Reference to the broader audit program or compliance assurance program under which this test is being conducted.',
    `compliance_control_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_control. Business justification: A compliance control test must reference the specific compliance control being tested. This is a critical missing relationship - tests without control references lack traceability. The FK will be popu',
    `timekeeper_id` BIGINT COMMENT 'Reference to the individual who performed the control test. Typically a compliance analyst, internal auditor, or external auditor.',
    `reviewer_timekeeper_id` BIGINT COMMENT 'Reference to the individual who reviewed and approved the control test results. Typically a senior compliance officer or audit manager.',
    `risk_control_id` BIGINT COMMENT 'Foreign key linking to risk.risk_control. Business justification: Control testing validates effectiveness of risk controls. Natural operational link for control assurance programs, enabling test results to update risk control effectiveness ratings and residual risk ',
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
    CONSTRAINT pk_compliance_control_test PRIMARY KEY(`compliance_control_test_id`)
) COMMENT 'Records of individual control testing activities performed against compliance controls, including design effectiveness testing and operating effectiveness testing. Captures test date, tester, test methodology (walkthrough, sample testing, re-performance), sample size, exceptions identified, exception rate, overall test conclusion (effective/ineffective), remediation required flag, and linkage to the parent compliance control. Supports SOX, ISO 27001, and SRA compliance assurance programmes.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`compliance`.`regulatory_breach` (
    `regulatory_breach_id` BIGINT COMMENT 'Primary key for regulatory_breach',
    `compliance_control_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_control. Business justification: Regulatory breaches often result from control failures. Linking the breach to the failed control provides root cause traceability and supports remediation planning. This FK is optional (nullable) as n',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Breaches occur within practice area context (missed filing deadline in corporate, privilege breach in litigation). Root cause analysis and remediation are practice-area-specific. Required for practice',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key reference to the regulatory obligation that was breached. Links to the compliance.regulatory_obligation product.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Regulatory breaches are risk events requiring enterprise risk register tracking for board reporting, regulatory notifications, and risk appetite monitoring. Legal firms must track breach-to-risk linka',
    `timekeeper_id` BIGINT COMMENT 'Foreign key linking to workforce.timekeeper. Business justification: Regulatory breaches require assignment to a responsible timekeeper for remediation, client notification, and regulator liaison. Linking to timekeeper enables tracking of breach remediation workload an',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Regulatory breaches often constitute violations of internal compliance policies. This provides traceability from the breach to the policy that was violated, supporting root cause analysis and remediat',
    `actual_remediation_date` DATE COMMENT 'Actual date on which all remediation actions were completed and the breach was fully resolved. Null if remediation is still in progress.',
    `affected_client_count` STRING COMMENT 'Number of clients directly impacted by the breach. Used to assess scope and determine notification obligations under GDPR, CCPA, and professional conduct rules.',
    `affected_matter_count` STRING COMMENT 'Number of legal matters or cases impacted by the breach. Relevant for assessing operational and reputational impact.',
    `breach_category` STRING COMMENT 'High-level categorization of the breach by business domain: financial controls, data privacy, professional conduct, operational compliance, regulatory reporting, or client funds management.. Valid values are `FINANCIAL|DATA_PRIVACY|CONDUCT|OPERATIONAL|REPORTING|CLIENT_FUNDS`',
    `breach_description` STRING COMMENT 'Detailed narrative description of the breach, including what occurred, which controls failed, and the scope of the violation. Confidential business information.',
    `breach_reference_number` STRING COMMENT 'Externally-known unique reference number assigned to the breach for tracking and reporting purposes. Format: BRH-YYYYNNNN.. Valid values are `^BRH-[0-9]{8}$`',
    `breach_status` STRING COMMENT 'Current lifecycle status of the breach record. Tracks progression from identification through investigation, remediation, and closure.. Valid values are `IDENTIFIED|UNDER_INVESTIGATION|REMEDIATION_IN_PROGRESS|REMEDIATED|CLOSED|ESCALATED`',
    `breach_type` STRING COMMENT 'Classification of the regulatory breach by the governing framework or regulation violated. AML = Anti-Money Laundering, KYC = Know Your Client, GDPR = General Data Protection Regulation, CCPA = California Consumer Privacy Act, DPA = Data Protection Act, SOX = Sarbanes-Oxley Act, SRA = Solicitors Regulation Authority, IOLTA = Interest on Lawyers Trust Accounts, LEDES = Legal Electronic Data Exchange Standard. [ENUM-REF-CANDIDATE: AML|KYC|GDPR|CCPA|DPA|SOX|SRA_CONDUCT|PROFESSIONAL_INDEMNITY|IOLTA|LEDES — 10 candidates stripped; promote to reference product]',
    `client_notification_date` DATE COMMENT 'Date on which affected clients were notified of the breach. Null if notification not yet completed or not required.',
    `client_notification_required_flag` BOOLEAN COMMENT 'Indicates whether affected clients must be directly notified of the breach under GDPR, CCPA, or professional conduct obligations. True = client notification required.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this breach record was first created in the system. Audit trail field.',
    `discovery_date` DATE COMMENT 'Date on which the breach was first identified or discovered by the firm. Critical for determining notification timelines under GDPR (72 hours) and other regulatory frameworks.',
    `discovery_method` STRING COMMENT 'Mechanism or channel through which the breach was identified. Used to assess effectiveness of internal controls and detection systems. [ENUM-REF-CANDIDATE: INTERNAL_AUDIT|EXTERNAL_AUDIT|SELF_REPORTED|CLIENT_COMPLAINT|REGULATOR_INSPECTION|SYSTEM_ALERT|WHISTLEBLOWER|THIRD_PARTY_NOTIFICATION — 8 candidates stripped; promote to reference product]',
    `dpo_notification_date` TIMESTAMP COMMENT 'Date and time when the Data Protection Officer was notified of the breach. Null if DPO notification not applicable or not yet completed.',
    `dpo_notified_flag` BOOLEAN COMMENT 'Indicates whether the firms Data Protection Officer was notified of the breach. Required under GDPR for data privacy breaches. True = DPO notified.',
    `escalated_to_executive_flag` BOOLEAN COMMENT 'Indicates whether the breach was escalated to executive leadership (e.g., Managing Partner, General Counsel, Chief Legal Officer). True = executive escalation occurred.',
    `escalation_date` TIMESTAMP COMMENT 'Date and time when the breach was escalated to executive leadership. Null if no escalation occurred.',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated or actual financial cost of the breach to the firm, including fines, penalties, remediation costs, legal fees, and reputational damage. Confidential business information.',
    `financial_impact_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the financial impact amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `impact_assessment` STRING COMMENT 'Documented assessment of the breach impact on clients, firm operations, regulatory standing, and reputation. Includes scope of affected parties and potential harm.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this breach record is currently active and under management. False = breach has been closed or archived.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this breach record was last updated. Audit trail field for tracking changes over the breach lifecycle.',
    `notes` STRING COMMENT 'Additional free-text notes, observations, or context related to the breach. May include investigator comments, follow-up actions, or lessons learned.',
    `notified_regulator` STRING COMMENT 'Name of the regulatory body or supervisory authority to which the breach was reported (e.g., ICO, SRA, State Bar, SEC).',
    `occurrence_date` DATE COMMENT 'Actual or estimated date when the breach occurred. May differ from discovery date if the breach was historical or latent.',
    `professional_indemnity_claim_flag` BOOLEAN COMMENT 'Indicates whether the breach has triggered or may trigger a professional indemnity insurance claim. True = claim filed or anticipated.',
    `professional_indemnity_claim_reference` STRING COMMENT 'Reference number for the professional indemnity insurance claim associated with this breach. Null if no claim filed.',
    `regulator_reference_number` STRING COMMENT 'Reference or case number assigned by the regulatory authority upon receipt of the breach notification. Used for tracking regulatory correspondence and follow-up.',
    `regulatory_notification_date` TIMESTAMP COMMENT 'Actual date and time when the breach was formally notified to the relevant regulatory authority. Null if notification not yet completed.',
    `regulatory_notification_deadline` TIMESTAMP COMMENT 'Deadline by which the breach must be reported to the regulator. GDPR requires notification within 72 hours of discovery; other frameworks have varying timelines.',
    `regulatory_notification_required_flag` BOOLEAN COMMENT 'Indicates whether the breach must be reported to a regulatory authority under applicable law or professional conduct rules. True = notification required.',
    `regulatory_penalty_amount` DECIMAL(18,2) COMMENT 'Actual or potential fine or penalty imposed by the regulatory authority as a result of the breach. Null if no penalty assessed or not yet determined.',
    `regulatory_penalty_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the regulatory penalty amount.. Valid values are `^[A-Z]{3}$`',
    `remediation_owner` STRING COMMENT 'Name or identifier of the individual or department responsible for executing the remediation plan and ensuring corrective actions are completed.',
    `remediation_owner_department` STRING COMMENT 'Department or business unit to which the remediation owner belongs (e.g., Compliance, Risk, IT, Finance, Legal Operations).',
    `remediation_plan` STRING COMMENT 'Documented plan outlining corrective actions, control enhancements, and process changes to address the breach and prevent recurrence. Confidential business information.',
    `remediation_status` STRING COMMENT 'Current status of the remediation effort. Tracks progress toward completion of corrective actions.. Valid values are `NOT_STARTED|IN_PROGRESS|ON_HOLD|COMPLETED|OVERDUE`',
    `root_cause` STRING COMMENT 'Identified underlying cause of the breach following investigation. May include process failure, system error, human error, inadequate training, or control gap.',
    `severity_rating` STRING COMMENT 'Assessment of the breach severity based on impact to the firm, clients, and regulatory standing. Critical = immediate regulatory notification and senior leadership escalation required.. Valid values are `CRITICAL|HIGH|MEDIUM|LOW`',
    `target_remediation_date` DATE COMMENT 'Planned or committed date by which all remediation actions will be completed and the breach fully resolved.',
    CONSTRAINT pk_regulatory_breach PRIMARY KEY(`regulatory_breach_id`)
) COMMENT 'Records of identified compliance breaches or regulatory violations at the firm level, distinct from data breaches (which are privacy-specific). Captures breach type (AML, SRA conduct, SOX, GDPR, professional indemnity), discovery date, root cause, severity rating, regulatory notification obligation flag, notification date, remediation plan, remediation owner, target resolution date, and actual resolution date. Feeds into the firms regulatory risk posture and professional indemnity insurance disclosures.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` (
    `indemnity_policy_id` BIGINT COMMENT 'Unique identifier for the professional indemnity insurance policy record.',
    `practice_area_id` BIGINT COMMENT 'Foreign key to service.practice_area.practice_area_id',
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
    `practice_areas_covered` STRING COMMENT 'Description of the legal practice areas and service types covered under this professional indemnity policy.',
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

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`compliance`.`indemnity_claim` (
    `indemnity_claim_id` BIGINT COMMENT 'Unique identifier for the professional indemnity insurance claim record. Primary key for the indemnity claim entity.',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the partner who had primary responsibility for the matter at the time of the alleged negligence.',
    `indemnity_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.indemnity_policy. Business justification: Claims are made UNDER a policy. N:1 relationship (many claims per policy). indemnity_claim has policy_number and policy_year attributes that reference indemnity_policy. Adding FK resolves silo for ind',
    `legal_document_id` BIGINT COMMENT 'Foreign key linking to document.legal_document. Business justification: Claim notifications, coverage opinions, settlement agreements are legal documents: insurer notification letter, coverage counsel opinion, settlement deed, SRA report of claim. Required for linking ind',
    `matter_id` BIGINT COMMENT 'Reference to the matter that is the subject of the alleged negligence or professional liability claim.',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Professional indemnity claims arise from practice-area-specific work. Underwriters price coverage by practice area risk profile. Essential for practice-area-level claims analysis, reserve setting, and',
    `timekeeper_id` BIGINT COMMENT 'Reference to the fee earner (associate, solicitor, or other timekeeper) who performed the work that is the subject of the alleged negligence.',
    `profile_id` BIGINT COMMENT 'Reference to the client who is the claimant or on whose matter the alleged negligence occurred.',
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

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`compliance`.`training_programme` (
    `training_programme_id` BIGINT COMMENT 'Primary key for training_programme',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Training programmes implement and educate on compliance policies. N:1 relationship (many programmes per policy). training_programme has related_policy_reference (STRING) which should be formalized as ',
    `timekeeper_id` BIGINT COMMENT 'Foreign key linking to workforce.timekeeper. Business justification: Compliance training programmes require a named timekeeper as content owner for accountability, version control, and regulatory audit trails. Legal firms track who is responsible for maintaining each c',
    `knowledge_asset_id` BIGINT COMMENT 'Foreign key linking to knowledge.knowledge_asset. Business justification: Training programmes reference knowledge assets (precedents, practice notes, research memos) as learning materials. This link enables training content management and tracks which knowledge assets suppo',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: CPD training is practice-area-specific (IP training for patent attorneys, AML training for corporate). Regulatory bodies require practice-area-aligned training. Essential for CPD compliance tracking a',
    `practice_group_id` BIGINT COMMENT 'Foreign key linking to workforce.practice_group. Business justification: Practice-specific compliance training (AML for corporate, GDPR for tech practice, conflicts for litigation) requires linking training programmes to practice groups for targeted delivery and CPD tracki',
    `regulatory_obligation_id` BIGINT COMMENT 'FK to compliance.regulatory_obligation.regulatory_obligation_id — Training programmes exist to satisfy specific regulatory obligations (e.g., FATF requires AML training, GDPR requires privacy awareness). This FK enables compliance officers to demonstrate obligation ',
    `accreditation_body` STRING COMMENT 'Name of the professional body or regulatory authority that has accredited or approved this training programme (e.g., SRA, Law Society, ABA, IBA).',
    `accreditation_reference` STRING COMMENT 'Reference number or identifier assigned by the accreditation body for this training programme.',
    `assessment_required_flag` BOOLEAN COMMENT 'Indicates whether participants must complete a formal assessment or examination to pass the training programme.',
    `certificate_issued_flag` BOOLEAN COMMENT 'Indicates whether a completion certificate is issued to participants who successfully complete the training.',
    `cost_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the cost per participant (e.g., GBP, USD, EUR).. Valid values are `^[A-Z]{3}$`',
    `cost_per_participant` DECIMAL(18,2) COMMENT 'Cost charged per participant for completing the training programme, used for budget planning and cost allocation. Null for internally developed free training.',
    `cpd_credits` DECIMAL(18,2) COMMENT 'Number of CPD or CLE credits awarded upon successful completion of the training programme.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this training programme record was first created in the system.',
    `delivery_format` STRING COMMENT 'Format in which the training is made available to participants, distinct from delivery method.. Valid values are `online|in-person|hybrid|on-demand|scheduled`',
    `delivery_method` STRING COMMENT 'Primary method by which the training programme is delivered to participants.. Valid values are `e-learning|instructor-led|blended|webinar|workshop|self-study`',
    `duration_hours` DECIMAL(18,2) COMMENT 'Expected duration of the training programme in hours, used for CPD/CLE credit calculation and scheduling.',
    `external_url` STRING COMMENT 'Web address or link to the external training platform or provider portal where the programme is accessed, if applicable.',
    `frequency` STRING COMMENT 'Required frequency at which participants must complete or refresh this training programme.. Valid values are `annual|biannual|quarterly|one-time|as-needed|triennial`',
    `internal_system_reference` STRING COMMENT 'Reference identifier or course code in the internal Learning Management System (LMS) or Human Resources Management (HRM) system.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the training programme is currently active and available for enrollment and completion.',
    `language` STRING COMMENT 'Primary language in which the training programme content is delivered, using ISO 639-2 three-letter language codes (e.g., ENG for English, FRA for French).. Valid values are `^[A-Z]{3}$`',
    `last_content_update_date` DATE COMMENT 'Date when the training programme content was last substantively updated or revised.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this training programme record was last modified or updated.',
    `launch_date` DATE COMMENT 'Date when the training programme was first made available to participants.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next content review and update cycle to ensure continued regulatory compliance and relevance.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or special instructions related to the training programme administration or content.',
    `pass_mark_percentage` DECIMAL(18,2) COMMENT 'Minimum percentage score required to successfully complete the training programme and receive credit. Null if no assessment is required.',
    `practice_group_scope` STRING COMMENT 'Specific practice groups or departments for which this training is mandatory or recommended (e.g., Corporate, Litigation, IP, Employment). Null if applicable to all practice groups.',
    `prerequisite_programmes` STRING COMMENT 'List or description of other training programmes that must be completed before participants can enroll in this programme. Null if no prerequisites exist.',
    `programme_code` STRING COMMENT 'Unique business identifier code for the training programme, used for external reference and system integration.. Valid values are `^[A-Z0-9]{6,20}$`',
    `programme_description` STRING COMMENT 'Detailed description of the training programme content, learning objectives, and scope.',
    `programme_name` STRING COMMENT 'Full name of the compliance training programme as displayed to users and in reporting.',
    `programme_status` STRING COMMENT 'Current lifecycle status of the training programme indicating its availability and operational state.. Valid values are `active|inactive|draft|under-review|retired|suspended`',
    `provider_name` STRING COMMENT 'Name of the external training provider or vendor if the programme is delivered by a third party. Null for internally developed training.',
    `recurrence_interval_months` STRING COMMENT 'Number of months between required completions for recurring training programmes. Null for one-time training.',
    `regulatory_framework` STRING COMMENT 'Primary regulatory framework or compliance area that this training programme addresses (e.g., Anti-Money Laundering (AML), General Data Protection Regulation (GDPR), California Consumer Privacy Act (CCPA), Anti-Bribery and Corruption (ABC), Continuing Professional Development (CPD), Continuing Legal Education (CLE)). [ENUM-REF-CANDIDATE: AML|GDPR|CCPA|DPA|SOX|ABC|FATF|SRA|PII|LPP|CPD|CLE|ISO27001|PCI-DSS — 14 candidates stripped; promote to reference product]',
    `related_policy_reference` STRING COMMENT 'Reference to the firm policy document or control framework that this training programme supports or implements.',
    `retirement_date` DATE COMMENT 'Date when the training programme was or will be retired and no longer available for new completions. Null for active programmes.',
    `target_audience` STRING COMMENT 'Description of the intended audience for this training programme, including roles, practice groups, or seniority levels (e.g., all fee earners, partners only, support staff, specific practice groups).',
    `target_role_category` STRING COMMENT 'Categorical classification of the primary role groups required to complete this training. [ENUM-REF-CANDIDATE: all-staff|fee-earners|partners|associates|paralegals|support-staff|practice-specific|management — 8 candidates stripped; promote to reference product]',
    `training_category` STRING COMMENT 'Classification of the training programme based on requirement level and purpose.. Valid values are `mandatory|recommended|optional|refresher|induction|specialized`',
    `version_effective_date` DATE COMMENT 'Date from which this version of the training programme became effective and available for completion.',
    `version_number` STRING COMMENT 'Version identifier for the training programme content, incremented when material updates are made to reflect regulatory changes or content improvements.. Valid values are `^[0-9]+.[0-9]+$`',
    CONSTRAINT pk_training_programme PRIMARY KEY(`training_programme_id`)
) COMMENT 'Compliance training programme records covering mandatory regulatory training requirements such as AML awareness, GDPR/data privacy, anti-bribery and corruption (ABC), sanctions screening, and CPD/CLE compliance obligations. Captures training programme name, regulatory requirement it satisfies, delivery method, frequency, target audience (by role/practice group), pass mark, and version. Distinct from individual completion records tracked in workforce domain — this entity owns the programme definition.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`compliance`.`sanctions_check` (
    `sanctions_check_id` BIGINT COMMENT 'Primary key for sanctions_check',
    `aml_kyc_program_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_kyc_program. Business justification: Sanctions screening checks are performed as part of the firms AML/KYC programme. N:1 relationship (many checks per program). Connects sanctions_check to aml_kyc_program. No columns to remove - check-s',
    `ownership_id` BIGINT COMMENT 'Foreign key linking to ip.ownership. Business justification: Sanctions screening of IP owners and assignees is required for AML/KYC compliance in IP transactions, especially cross-border assignments and licensing. Essential for ensuring IP ownership transfers c',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to ip.license_agreement. Business justification: Sanctions screening of licensors and licensees is required for AML/KYC compliance in IP licensing, especially high-value or cross-border agreements. Essential for ensuring licensing parties are not sa',
    `matter_id` BIGINT COMMENT 'Identifier of the matter record associated with this sanctions screening, if the screening was performed in the context of a specific legal matter.',
    `profile_id` BIGINT COMMENT 'Identifier of the client record associated with this sanctions screening, if the subject is a client or related to a client matter.',
    `timekeeper_id` BIGINT COMMENT 'Employee identifier of the compliance officer who reviewed this screening result.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this sanctions screening result record was first created in the system.',
    `disposition_date` DATE COMMENT 'Date on which the final disposition decision was made for this screening result.',
    `disposition_rationale` STRING COMMENT 'Detailed explanation and business justification for the disposition decision, including evidence reviewed and reasoning applied.',
    `escalation_date` DATE COMMENT 'Date on which the screening result was escalated to senior compliance management or external authorities. Null if no escalation occurred.',
    `escalation_recipient` STRING COMMENT 'Name and role of the individual or authority to whom the screening result was escalated (e.g., Chief Compliance Officer, MLRO, NCA).',
    `escalation_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether this screening result requires escalation to senior compliance management or external authorities.',
    `is_active` BOOLEAN COMMENT 'Boolean indicator of whether this screening result record is currently active and valid. False indicates the record has been superseded or archived.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this sanctions screening result record was last updated or modified.',
    `match_details` STRING COMMENT 'Detailed description of the match found, including the matched name from the sanctions list, list entry reference number, and any additional identifying information.',
    `match_score` DECIMAL(18,2) COMMENT 'Numerical confidence score (0.00 to 100.00) indicating the strength of the match between the subject and the sanctions list entry. Higher scores indicate stronger matches.',
    `match_type` STRING COMMENT 'Type of match identified during screening: exact name match, fuzzy match, alias match, phonetic match, or no match found.. Valid values are `exact|fuzzy|alias|phonetic|no_match`',
    `notes` STRING COMMENT 'Additional free-text notes, observations, or context relevant to this sanctions screening result.',
    `regulatory_report_reference` STRING COMMENT 'Reference number of any regulatory report filed as a result of this screening (e.g., SAR reference number). Null if no report was filed.',
    `regulatory_reporting_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether this screening result requires mandatory reporting to regulatory authorities (e.g., Suspicious Activity Report filing).',
    `reviewing_officer_name` STRING COMMENT 'Full name of the compliance officer or authorized personnel who reviewed and made the disposition decision.',
    `risk_rating` STRING COMMENT 'Overall risk rating assigned to this screening result based on match score, subject type, jurisdiction, and other risk factors.. Valid values are `low|medium|high|critical`',
    `sanctions_list_screened` STRING COMMENT 'Identifier of the sanctions list(s) screened against: OFAC SDN (Office of Foreign Assets Control Specially Designated Nationals), HM Treasury (UK), EU Consolidated List, UN Sanctions List, or Combined All.. Valid values are `OFAC_SDN|HM_Treasury|EU_Consolidated|UN_Sanctions|Combined_All`',
    `screening_date` DATE COMMENT 'Date on which the sanctions screening check was performed.',
    `screening_disposition` STRING COMMENT 'Final disposition of the screening result: cleared (no action required), escalated (referred to compliance officer), blocked (transaction/engagement prevented), pending review, or false positive (match dismissed).. Valid values are `cleared|escalated|blocked|pending_review|false_positive`',
    `screening_reference_number` STRING COMMENT 'Business-facing unique reference number assigned to this screening check for tracking and audit purposes.',
    `screening_system_name` STRING COMMENT 'Name of the automated screening system or platform used to perform the sanctions check (e.g., Dow Jones, World-Check, ComplyAdvantage).',
    `screening_system_version` STRING COMMENT 'Version number of the screening system or sanctions list database used at the time of screening, for audit trail purposes.',
    `screening_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the sanctions screening check was executed, including time zone information.',
    `screening_trigger_event` STRING COMMENT 'Business event that triggered this sanctions screening check: client onboarding, matter opening, periodic review, transaction review, manual request, or system alert.. Valid values are `client_onboarding|matter_opening|periodic_review|transaction_review|manual_request|system_alert`',
    `subject_country_of_residence` STRING COMMENT 'Three-letter ISO country code representing the country of residence or incorporation of the subject being screened.. Valid values are `^[A-Z]{3}$`',
    `subject_date_of_birth` DATE COMMENT 'Date of birth of the individual subject being screened, used for enhanced matching accuracy. Null for non-individual subjects.',
    `subject_name` STRING COMMENT 'Full name of the individual or entity being screened against sanctions lists.',
    `subject_national_identifier` STRING COMMENT 'National identification number, passport number, or registration number of the subject being screened, used for enhanced matching.',
    `subject_type` STRING COMMENT 'Classification of the subject being screened: individual person, organisation, beneficial owner, counterparty, related party, or trust.. Valid values are `individual|organisation|beneficial_owner|counterparty|related_party|trust`',
    CONSTRAINT pk_sanctions_check PRIMARY KEY(`sanctions_check_id`)
) COMMENT 'Records of sanctions list screening checks performed against clients, counterparties, beneficial owners, and related parties against OFAC SDN, HM Treasury, EU Consolidated, and UN sanctions lists. Captures screening date, subject name, subject type, list screened, match type (exact, fuzzy, alias), match score, disposition (cleared, escalated, blocked), reviewing officer, and disposition rationale. Supports FATF obligations and AML programme requirements. Firm-level screening infrastructure distinct from matter-level conflict checks.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` (
    `regulatory_change_id` BIGINT COMMENT 'Unique identifier for the regulatory change record. Primary key.',
    `regulatory_obligation_id` BIGINT COMMENT 'FK to compliance.regulatory_obligation.regulatory_obligation_id — Regulatory changes impact existing obligations or create new ones. This FK enables impact assessment and obligation register updates when new regulations are enacted.',
    `timekeeper_id` BIGINT COMMENT 'Employee identifier of the individual responsible for leading the implementation of required changes.',
    `control_framework_id` BIGINT COMMENT 'Foreign key linking to compliance.control_framework. Business justification: Regulatory changes often necessitate updates to control frameworks (e.g., new GDPR guidance requires ISO 27001 control updates). The regulatory_change table has regulatory_framework as a string, but l',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Regulatory changes impact specific practice areas (SRA transparency rules for conveyancing, GDPR for data privacy practice). Impact assessments are practice-area-scoped. Required for practice-area-lev',
    `primary_regulatory_obligation_id` BIGINT COMMENT 'Foreign key reference to the regulatory obligation record created as a result of this regulatory change, if applicable.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Regulatory changes trigger risk assessments and create risk register entries as part of horizon scanning and regulatory change management. Essential for tracking implementation risks and compliance ga',
    `regulatory_implementation_owner_timekeeper_id` BIGINT COMMENT 'Foreign key linking to workforce.timekeeper. Business justification: Regulatory changes require a named timekeeper as implementation owner for tracking accountability, workload, and completion. The existing implementation_owner_employee_id(unlinked) should map to timek',
    `change_description` STRING COMMENT 'Detailed narrative description of the regulatory change, including scope, intent, and key provisions that may impact the firm.',
    `change_reference_number` STRING COMMENT 'Externally-known unique reference number or code assigned to this regulatory change by the issuing body or internal tracking system.',
    `change_status` STRING COMMENT 'Current lifecycle status of the regulatory change: proposed (under consultation), published (finalized but not yet effective), effective (in force), superseded (replaced by newer regulation), or withdrawn.. Valid values are `proposed|published|effective|superseded|withdrawn`',
    `change_title` STRING COMMENT 'Short descriptive title or name of the regulatory change, legislative update, or guidance document.',
    `change_type` STRING COMMENT 'Classification of the nature of the regulatory change: new regulation, amendment to existing regulation, repeal, guidance, interpretation, advisory, or consultation. [ENUM-REF-CANDIDATE: new_regulation|amendment|repeal|guidance|interpretation|advisory|consultation — 7 candidates stripped; promote to reference product]',
    `consultation_response_deadline` DATE COMMENT 'Deadline by which the firm must submit its consultation response to the governing body.',
    `consultation_response_required_flag` BOOLEAN COMMENT 'Indicates whether the firm intends to submit a formal response to a regulatory consultation or request for comment associated with this change.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory change record was first created in the system.',
    `dpo_review_date` DATE COMMENT 'Date on which the Data Protection Officer (DPO) completed their review of this regulatory change.',
    `dpo_review_required_flag` BOOLEAN COMMENT 'Indicates whether this regulatory change requires review and approval by the firms Data Protection Officer (DPO) due to data privacy implications.',
    `effective_date` DATE COMMENT 'Date on which the regulatory change becomes legally effective and enforceable. May be future-dated for phased implementation.',
    `governing_body` STRING COMMENT 'Name of the regulatory authority, governing body, or legislative entity that issued the change (e.g., American Bar Association (ABA), Solicitors Regulation Authority (SRA), International Bar Association (IBA), Financial Action Task Force (FATF), Information Commissioners Office (ICO), Securities and Exchange Commission (SEC), Financial Conduct Authority (FCA)).',
    `impact_assessment_date` DATE COMMENT 'Date on which the impact assessment was completed and approved.',
    `impact_assessment_status` STRING COMMENT 'Current status of the internal impact assessment process to evaluate the implications of this regulatory change on the firms operations and compliance posture.. Valid values are `not_started|in_progress|completed|approved`',
    `impact_severity` STRING COMMENT 'Assessed severity level of the regulatory changes impact on the firms compliance posture, operations, and risk exposure.. Valid values are `critical|high|medium|low|negligible`',
    `impacted_business_functions` STRING COMMENT 'Comma-separated list of internal business functions or departments affected by this regulatory change (e.g., Client Intake, Matter Management, Billing, Knowledge Management, Trust Accounting).',
    `implementation_deadline` DATE COMMENT 'Internal deadline by which the firm must complete all required actions to comply with the regulatory change.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this regulatory change record is currently active and relevant for compliance tracking. Inactive records represent historical or superseded changes.',
    `jurisdiction` STRING COMMENT 'Geographic or legal jurisdiction to which this regulatory change applies (e.g., USA, GBR, EUR, state-specific, or international).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory change record was last updated or modified.',
    `legal_counsel_review_date` DATE COMMENT 'Date on which internal legal counsel or General Counsel (GC) completed their review of this regulatory change.',
    `legal_counsel_review_required_flag` BOOLEAN COMMENT 'Indicates whether this regulatory change requires review by internal legal counsel or General Counsel (GC) for legal interpretation and compliance strategy.',
    `notes` STRING COMMENT 'Free-text field for additional comments, observations, or context related to this regulatory change.',
    `policy_update_required_flag` BOOLEAN COMMENT 'Indicates whether existing firm policies, procedures, or governance documents require updates to reflect this regulatory change.',
    `publication_date` DATE COMMENT 'Date on which the regulatory change was officially published or announced by the governing body.',
    `regulatory_framework` STRING COMMENT 'Name of the overarching regulatory framework or compliance regime to which this change belongs (e.g., General Data Protection Regulation (GDPR), California Consumer Privacy Act (CCPA), Sarbanes-Oxley Act (SOX), Anti-Money Laundering (AML), Know Your Client (KYC), Legal Professional Privilege (LPP)).',
    `regulatory_obligation_created_flag` BOOLEAN COMMENT 'Indicates whether this regulatory change has resulted in the creation of a new entry in the regulatory obligation register.',
    `related_policy_references` STRING COMMENT 'Comma-separated list of internal policy document references or identifiers that are affected by or related to this regulatory change.',
    `required_control_updates` STRING COMMENT 'Description of the control framework updates, policy changes, or procedural modifications required to achieve compliance with this regulatory change.',
    `responsible_department` STRING COMMENT 'Name of the department or business unit with primary accountability for implementing and maintaining compliance with this regulatory change.',
    `risk_rating` STRING COMMENT 'Overall risk rating assigned to non-compliance with this regulatory change, considering likelihood and impact of regulatory breach.. Valid values are `critical|high|medium|low`',
    `source_document_reference` STRING COMMENT 'Official citation or reference number of the source legislation, regulation, or guidance document (e.g., Public Law number, Statutory Instrument number, Directive number).',
    `source_document_url` STRING COMMENT 'Web address or hyperlink to the official source document, legislation text, or guidance publication from the governing body.',
    `system_changes_description` STRING COMMENT 'Description of the system, technology, or data management changes required to achieve compliance with this regulatory change.',
    `system_changes_required_flag` BOOLEAN COMMENT 'Indicates whether changes to operational systems, technology platforms, or data management systems are required to support compliance with this regulatory change.',
    `training_completion_deadline` DATE COMMENT 'Deadline by which all required training on this regulatory change must be completed by relevant staff.',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether firm-wide or targeted training is required to educate staff on the implications and requirements of this regulatory change.',
    CONSTRAINT pk_regulatory_change PRIMARY KEY(`regulatory_change_id`)
) COMMENT 'Tracks incoming regulatory changes, legislative updates, and new guidance from governing bodies (ABA, SRA, IBA, FATF, ICO, SEC, FCA) that may impact the firms compliance posture. Captures change source, publication date, effective date, impacted regulatory frameworks, impacted practice areas, impact assessment status, required control updates, implementation owner, and implementation deadline. Feeds the regulatory obligation register when new obligations are confirmed.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`compliance`.`policy` (
    `policy_id` BIGINT COMMENT 'Primary key for policy',
    `control_framework_id` BIGINT COMMENT 'Foreign key linking to compliance.control_framework. Business justification: Policies are often written to implement specific control framework requirements (e.g., Information Security Policy implements ISO 27001, Data Retention Policy implements GDPR requirements). The po',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Compliance policies are scoped to practice areas (data retention for litigation, conflict policies for M&A). Practice groups implement policies differently. Required for practice-area-level policy att',
    `regulatory_obligation_id` BIGINT COMMENT 'FK to compliance.regulatory_obligation.regulatory_obligation_id — Compliance policies are written to satisfy regulatory obligations. This FK enables gap analysis — which obligations lack a governing policy — and is fundamental to policy governance.',
    `timekeeper_id` BIGINT COMMENT 'Employee identifier of the policy owner.',
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
    `related_policy_references` STRING COMMENT 'Comma-separated list of related policy codes or names that should be read in conjunction with this policy.',
    `review_cycle_months` STRING COMMENT 'Frequency in months at which the policy must be reviewed and reaffirmed (e.g., 12, 24, 36).',
    `risk_rating` STRING COMMENT 'Risk severity rating assigned to the policy area, indicating the potential impact of non-compliance.. Valid values are `critical|high|medium|low`',
    `source_legislation_url` STRING COMMENT 'URL or reference link to the primary legislation, regulation, or guidance document that the policy is based on.',
    `superseded_policy_code` STRING COMMENT 'Policy code of the previous version or policy that this policy replaces, establishing version lineage.',
    `training_frequency_months` STRING COMMENT 'Frequency in months at which training must be completed by applicable staff (e.g., 12, 24).',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether mandatory training is required for staff subject to this policy.',
    `version_number` STRING COMMENT 'Version identifier for the policy document following semantic versioning (e.g., 1.0, 2.1, 3.0).. Valid values are `^[0-9]+.[0-9]+$`',
    CONSTRAINT pk_policy PRIMARY KEY(`policy_id`)
) COMMENT 'Master register of the firms internal compliance policies and procedures, including AML policy, data protection policy, anti-bribery policy, sanctions policy, conflicts of interest policy, and information security policy. Captures policy name, policy owner, version, effective date, review cycle, approval authority, regulatory obligations satisfied, and current status (draft, approved, superseded). Provides the policy governance layer above individual controls.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` (
    `audit_engagement_id` BIGINT COMMENT 'Unique identifier for the audit engagement record. Primary key for the audit engagement entity.',
    `timekeeper_id` BIGINT COMMENT 'Employee identifier for the responsible officer accountable for audit remediation.',
    `engagement_owner_timekeeper_id` BIGINT COMMENT 'Employee identifier for the lead auditor if the audit is conducted internally or by a known staff member.',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Audits are scoped by practice area (SRA audit of conveyancing, ISO audit of IP practice). Regulatory audits target specific practice areas. Essential for practice-area-level audit planning, resource a',
    `control_framework_id` BIGINT COMMENT 'FK to compliance.control_framework.control_framework_id — Audit engagements are scoped against specific control frameworks (e.g., ISO 27001 surveillance audit, SOX controls audit). This FK defines audit scope and enables framework-level assurance reporting.',
    `primary_lead_auditor_timekeeper_id` BIGINT COMMENT 'Foreign key linking to workforce.timekeeper. Business justification: Internal compliance audits are conducted by firm timekeepers (often senior associates or compliance specialists). Linking lead auditor to timekeeper enables workload tracking, CPD credit allocation, a',
    `audit_documentation_location` STRING COMMENT 'File path, document management system reference, or storage location for the complete audit engagement documentation and working papers.',
    `audit_period_end_date` DATE COMMENT 'The end date of the period under audit review. Defines the conclusion of the timeframe for which compliance and controls are being assessed.',
    `audit_period_start_date` DATE COMMENT 'The start date of the period under audit review. Defines the beginning of the timeframe for which compliance and controls are being assessed.',
    `audit_scope` STRING COMMENT 'Detailed description of the scope of the audit engagement, including the business units, processes, controls, and regulatory obligations covered.',
    `audit_status` STRING COMMENT 'Current lifecycle status of the audit engagement from planning through closure.. Valid values are `planned|in_progress|fieldwork_complete|draft_issued|final_issued|closed`',
    `audit_type` STRING COMMENT 'Classification of the audit engagement by its nature and purpose. [ENUM-REF-CANDIDATE: internal_compliance_review|external_regulatory_inspection|iso_27001_surveillance|aml_audit|gdpr_audit|sox_compliance_audit|sra_inspection|pci_dss_audit|data_protection_audit|professional_indemnity_review — promote to reference product]. Valid values are `internal_compliance_review|external_regulatory_inspection|iso_27001_surveillance|aml_audit|gdpr_audit|sox_compliance_audit`',
    `auditor_type` STRING COMMENT 'Classification indicating whether the audit is conducted by internal staff, external consultants, or a regulatory authority.. Valid values are `internal|external|regulatory_body`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this audit engagement record was first created in the system.',
    `critical_findings_count` STRING COMMENT 'The number of critical severity findings identified that represent immediate and significant compliance or control failures.',
    `draft_report_date` DATE COMMENT 'The date on which the draft audit report was issued to management for review and response.',
    `engagement_name` STRING COMMENT 'Descriptive name of the audit engagement identifying the subject and scope of the audit.',
    `engagement_reference_number` STRING COMMENT 'Business-facing unique reference number assigned to the audit engagement for tracking and communication purposes.',
    `external_auditor_name` STRING COMMENT 'Name of the external audit firm or regulatory body conducting the audit. Null for internal audits.',
    `fieldwork_end_date` DATE COMMENT 'The date on which the audit fieldwork and evidence gathering activities concluded.',
    `fieldwork_start_date` DATE COMMENT 'The date on which the audit fieldwork and evidence gathering activities commenced.',
    `final_report_date` DATE COMMENT 'The date on which the final audit report was issued incorporating management responses and final audit opinion.',
    `findings_closed_count` STRING COMMENT 'The number of audit findings that have been remediated and verified as closed.',
    `findings_open_count` STRING COMMENT 'The number of audit findings that remain open and require remediation action.',
    `findings_overdue_count` STRING COMMENT 'The number of audit findings that have passed their target remediation date and remain open.',
    `follow_up_audit_required_flag` BOOLEAN COMMENT 'Indicates whether a follow-up audit engagement is required to verify remediation of findings.',
    `follow_up_audit_scheduled_date` DATE COMMENT 'The scheduled date for the follow-up audit engagement to verify closure of findings.',
    `high_findings_count` STRING COMMENT 'The number of high severity findings identified that represent material compliance or control weaknesses.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this audit engagement record is currently active in the system.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this audit engagement record was last updated in the system.',
    `low_findings_count` STRING COMMENT 'The number of low severity findings identified that represent minor compliance or control observations.',
    `management_response_due_date` DATE COMMENT 'The deadline by which management is required to provide formal responses to audit findings and proposed remediation plans.',
    `management_response_received_date` DATE COMMENT 'The actual date on which management submitted their formal response to the audit findings.',
    `medium_findings_count` STRING COMMENT 'The number of medium severity findings identified that represent moderate compliance or control gaps.',
    `notes` STRING COMMENT 'Additional free-text notes, observations, or context relevant to the audit engagement.',
    `overall_audit_opinion` STRING COMMENT 'The auditors overall conclusion regarding the effectiveness of controls and compliance with the regulatory framework under review.. Valid values are `satisfactory|satisfactory_with_observations|needs_improvement|unsatisfactory|adverse`',
    `regulatory_framework` STRING COMMENT 'The regulatory framework or control standard against which the audit is conducted (e.g., GDPR, AML/KYC, ISO 27001, SOX, SRA Code of Conduct).',
    `regulatory_report_reference` STRING COMMENT 'Reference number or identifier for any regulatory report filed as a result of this audit engagement.',
    `regulatory_report_submission_date` DATE COMMENT 'The date on which the regulatory report was submitted to the governing authority.',
    `regulatory_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether the audit findings require formal reporting to an external regulatory body or governing authority.',
    `responsible_department` STRING COMMENT 'The department or business unit primarily responsible for addressing the audit findings and implementing remediation actions.',
    `responsible_officer_name` STRING COMMENT 'Name of the senior officer or executive responsible for overseeing the remediation of audit findings and ensuring compliance.',
    `total_findings_count` STRING COMMENT 'The total number of audit findings identified during the engagement across all severity levels.',
    CONSTRAINT pk_audit_engagement PRIMARY KEY(`audit_engagement_id`)
) COMMENT 'Records of internal and external compliance audit engagements and their findings, conducted against the firms regulatory obligations and control frameworks. Covers SRA inspections, ISO 27001 surveillance audits, external AML audits, and internal compliance reviews. Each engagement captures audit type, auditor (internal/external), scope, audit period, fieldwork dates, report dates, management responses, overall opinion, and individual findings with severity ratings, root causes, recommended actions, remediation owners, target dates, and closure verification. Serves as the complete audit lifecycle record from planning through finding remediation.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`compliance`.`audit_finding` (
    `audit_finding_id` BIGINT COMMENT 'Unique identifier for the audit finding record. Primary key.',
    `timekeeper_id` BIGINT COMMENT 'Foreign key linking to workforce.timekeeper. Business justification: Audit findings require remediation by named timekeepers. Linking action owner to timekeeper enables tracking of open findings by owner, workload balancing, and performance review input for remediation',
    `audit_engagement_id` BIGINT COMMENT 'Reference to the parent compliance audit engagement during which this finding was raised.',
    `auditor_employee_timekeeper_id` BIGINT COMMENT 'Employee identifier of the auditor who raised the finding.',
    `compliance_control_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_control. Business justification: Audit findings relate to specific compliance controls that were tested. N:1 relationship (many findings per control). audit_finding has control_reference (STRING) which likely refers to compliance_con',
    `finding_owner_timekeeper_id` BIGINT COMMENT 'Employee identifier of the action owner responsible for remediation.',
    `ip_asset_id` BIGINT COMMENT 'Foreign key linking to ip.asset. Business justification: Audit findings related to IP asset management (valuation errors, recordal failures, inadequate protection measures) require linkage to specific assets. Essential for tracking audit remediation and con',
    `legal_document_id` BIGINT COMMENT 'Foreign key linking to document.legal_document. Business justification: Audit reports, management responses, remediation plans are legal documents: external audit report, management representation letter, corrective action plan, board resolution approving remediation. Req',
    `matter_id` BIGINT COMMENT 'Reference to the matter if the finding relates to a specific legal matter or case.',
    `profile_id` BIGINT COMMENT 'Reference to the client if the finding relates to a specific client matter or engagement.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Audit findings identifying control deficiencies create or update risk register entries as part of risk management response cycle. Essential for audit-to-risk remediation tracking and governance report',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Audit findings often identify policy violations. The finding already has related_policy_reference as a string attribute, which should be replaced by this FK for referential integrity. This provides tr',
    `actual_closure_date` DATE COMMENT 'Actual date on which the finding was verified as resolved and formally closed.',
    `agreed_action` STRING COMMENT 'The specific action agreed between auditor and management to remediate the finding.',
    `auditor_name` STRING COMMENT 'Name of the auditor who raised the finding.',
    `control_reference` STRING COMMENT 'Reference to the specific control or control framework element that is deficient or non-compliant.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit finding record was first created in the system.',
    `escalation_date` DATE COMMENT 'Date on which the finding was escalated to higher authority.',
    `escalation_recipient` STRING COMMENT 'Name or role of the individual or body to whom the finding was escalated (e.g., General Counsel, Board Audit Committee, SRA).',
    `escalation_required_flag` BOOLEAN COMMENT 'Indicates whether the finding requires escalation to senior management, board, or regulatory authority due to severity or nature.',
    `evidence_reference` STRING COMMENT 'Reference to the audit evidence or documentation supporting the finding (e.g., document ID, file path, sample reference).',
    `finding_category` STRING COMMENT 'Classification of the finding type: control gap (missing or ineffective control), policy breach (violation of internal policy), regulatory non-compliance (failure to meet external regulatory requirement), process deficiency (operational process weakness), documentation gap (missing or inadequate documentation), or system weakness (technology control failure).. Valid values are `control_gap|policy_breach|regulatory_non_compliance|process_deficiency|documentation_gap|system_weakness`',
    `finding_description` STRING COMMENT 'Detailed narrative description of the audit finding, including the condition observed, the criteria or standard against which it was assessed, and the context.',
    `finding_raised_date` DATE COMMENT 'Date on which the audit finding was formally raised and documented.',
    `finding_reference_number` STRING COMMENT 'Business-facing unique reference number assigned to this finding for tracking and reporting purposes.',
    `finding_status` STRING COMMENT 'Current lifecycle status of the finding: open (newly raised, no action started), in progress (remediation underway), pending verification (action completed, awaiting audit verification), closed (verified and resolved), overdue (past target date without closure).. Valid values are `open|in_progress|pending_verification|closed|overdue`',
    `finding_title` STRING COMMENT 'Concise title or summary of the audit finding for quick identification and reporting.',
    `finding_type` STRING COMMENT 'Nature of the finding: observation (noted fact without immediate action), recommendation (suggested improvement), non-conformance (failure to meet requirement), or opportunity for improvement (enhancement suggestion).. Valid values are `observation|recommendation|non_conformance|opportunity_for_improvement`',
    `impact_assessment` STRING COMMENT 'Assessment of the actual or potential business, regulatory, or operational impact of the finding.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this finding record is currently active in the system. False if the record has been archived or superseded.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit finding record was last updated or modified.',
    `management_response` STRING COMMENT 'Managements formal response to the finding, including acceptance, planned actions, or alternative approach.',
    `notes` STRING COMMENT 'Additional notes, comments, or context related to the finding, remediation, or verification process.',
    `recommended_action` STRING COMMENT 'Auditors recommended corrective or remedial action to address the finding and mitigate associated risk.',
    `regulatory_framework` STRING COMMENT 'The regulatory framework or standard against which the finding was assessed (e.g., GDPR, SOX, SRA Code of Conduct, AML regulations).',
    `regulatory_report_reference` STRING COMMENT 'Reference number or identifier of the regulatory report filed in relation to this finding.',
    `regulatory_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether the finding must be reported to an external regulatory body or governing authority.',
    `related_policy_reference` STRING COMMENT 'Reference to the internal policy or procedure that is relevant to this finding.',
    `responsible_department` STRING COMMENT 'Department or business unit responsible for addressing the finding.',
    `risk_rating` STRING COMMENT 'Overall risk rating associated with the finding if left unaddressed, considering likelihood and impact.. Valid values are `very_high|high|medium|low|very_low`',
    `root_cause` STRING COMMENT 'Analysis of the underlying root cause(s) that led to the finding, supporting effective remediation.',
    `severity` STRING COMMENT 'Severity rating of the finding based on potential impact and urgency: critical (immediate action required, significant regulatory or business risk), high (prompt action needed, material risk), medium (moderate risk, action required within normal cycle), low (minor issue, improvement opportunity).. Valid values are `critical|high|medium|low`',
    `target_remediation_date` DATE COMMENT 'Target date by which the agreed remediation action should be completed.',
    `verification_date` DATE COMMENT 'Date on which the auditor verified the effectiveness of the remediation action.',
    `verification_notes` STRING COMMENT 'Auditors notes and observations from the verification activity, including evidence reviewed and conclusion.',
    `verification_status` STRING COMMENT 'Status of the auditors verification of the remediation action: not started, scheduled, in progress, verified (action confirmed effective), or failed verification (action inadequate, finding remains open).. Valid values are `not_started|scheduled|in_progress|verified|failed_verification`',
    CONSTRAINT pk_audit_finding PRIMARY KEY(`audit_finding_id`)
) COMMENT 'Individual findings raised during compliance audit engagements, including observations, recommendations, and agreed management actions. Captures finding reference, parent audit engagement, finding category (control gap, policy breach, regulatory non-compliance), severity (critical, high, medium, low), root cause, recommended action, management response, action owner, target remediation date, actual closure date, and verification status. Supports ongoing compliance assurance and regulatory reporting.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`compliance`.`audit_scope` (
    `audit_scope_id` BIGINT COMMENT 'Unique identifier for this audit scope record. Primary key.',
    `audit_engagement_id` BIGINT COMMENT 'Foreign key linking to the audit engagement that includes this obligation in its scope',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to the regulatory obligation being audited within this engagement',
    `audit_period_end_date` DATE COMMENT 'The end date of the audit period for this specific obligation within this engagement. May differ from the overall engagement audit period if obligations have different review cycles.',
    `audit_period_start_date` DATE COMMENT 'The start date of the audit period for this specific obligation within this engagement. May differ from the overall engagement audit period if obligations have different review cycles.',
    `auditor_notes` STRING COMMENT 'Free-text notes and observations recorded by the auditor regarding this obligation during this engagement',
    `exceptions_identified` STRING COMMENT 'Number of exceptions or control failures identified during testing of this obligation',
    `obligation_compliance_status` STRING COMMENT 'The audit conclusion regarding compliance with this specific obligation within this engagement: compliant, non_compliant, partially_compliant, not_tested, in_progress',
    `obligation_findings_count` STRING COMMENT 'The number of audit findings identified that relate specifically to this regulatory obligation within this audit engagement',
    `obligation_risk_rating` STRING COMMENT 'Risk rating assigned to this obligation within the context of this audit engagement based on inherent risk, control effectiveness, and audit findings: critical, high, medium, low',
    `obligation_test_results_summary` STRING COMMENT 'Summary of the testing procedures performed and results obtained for this specific obligation during this audit engagement',
    `sample_size` STRING COMMENT 'Number of items or transactions sampled during testing of this obligation within this audit engagement',
    `scope_inclusion_date` DATE COMMENT 'Date when this regulatory obligation was formally included in the audit engagement scope during planning',
    `scope_status` STRING COMMENT 'Current status of audit work for this obligation within this engagement: planned, in_fieldwork, testing_complete, reported, closed',
    `testing_approach` STRING COMMENT 'Description of the audit testing methodology and procedures applied to assess compliance with this obligation in this engagement',
    CONSTRAINT pk_audit_scope PRIMARY KEY(`audit_scope_id`)
) COMMENT 'This association product represents the scoping relationship between audit engagements and regulatory obligations. It captures which specific regulatory obligations are included in the scope of each audit engagement, along with the compliance assessment results, findings, and test outcomes specific to that obligation within that audit. Each record links one audit engagement to one regulatory obligation with attributes that exist only in the context of this specific audit-obligation pairing.. Existence Justification: Audit engagements are explicitly scoped to cover multiple regulatory obligations, and each regulatory obligation is audited repeatedly across multiple audit engagements over time. Audit teams actively manage the scoping process during audit planning, defining which obligations are in-scope for each engagement. The relationship carries significant operational data including compliance assessment results, findings counts, test results, and risk ratings that are specific to each obligation-engagement pairing.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`compliance`.`policy_acknowledgement` (
    `policy_acknowledgement_id` BIGINT COMMENT 'Unique identifier for this policy acknowledgement record. Primary key.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to the policy that was acknowledged',
    `profile_id` BIGINT COMMENT 'Foreign key linking to the client who acknowledged the policy',
    `acceptance_status` STRING COMMENT 'Current status of the policy acknowledgement. Acknowledged indicates active acceptance, Pending indicates awaiting client response, Declined indicates client refused (may block engagement), Expired indicates acknowledgement has passed renewal date, Superseded indicates a newer version has been acknowledged.',
    `acknowledged_by_contact_email` STRING COMMENT 'Email address of the individual who acknowledged the policy. Used for audit trail and for sending renewal notifications.',
    `acknowledged_by_contact_name` STRING COMMENT 'Name of the individual at the client organization who provided the acknowledgement. For individual clients, this is the client themselves. For corporate clients, this is the authorized representative.',
    `acknowledgement_date` DATE COMMENT 'Date when the client formally acknowledged and accepted the policy. This is the audit timestamp for regulatory compliance purposes.',
    `acknowledgement_document_reference` STRING COMMENT 'Reference to the signed acknowledgement document stored in the document management system. Critical for regulatory audit and dispute resolution.',
    `attestation_method` STRING COMMENT 'The method by which the client provided acknowledgement. Electronic Signature and Wet Signature provide strongest audit evidence. Implied by Engagement may be used for existing clients under legacy policies.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this acknowledgement record was created.',
    `next_acknowledgement_due_date` DATE COMMENT 'Scheduled date when the client must re-acknowledge this policy. Calculated based on the policy review cycle and regulatory requirements. Used to trigger renewal workflows.',
    `reminder_sent_date` DATE COMMENT 'Date when the most recent renewal reminder was sent to the client. Used to track compliance workflow progress.',
    `required_for_engagement_flag` BOOLEAN COMMENT 'Indicates whether acknowledgement of this policy is mandatory before the firm can accept new matters from this client. AML and conflicts policies are typically mandatory.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this acknowledgement record was last modified.',
    `version_acknowledged` STRING COMMENT 'The specific version number of the policy that was acknowledged by the client. Critical for audit trail as policies evolve over time and clients must re-acknowledge new versions.',
    CONSTRAINT pk_policy_acknowledgement PRIMARY KEY(`policy_acknowledgement_id`)
) COMMENT 'This association product represents the formal acknowledgement event between client_profile and policy. It captures the regulatory requirement for clients to acknowledge and accept specific compliance policies as part of the client onboarding and ongoing compliance management process. Each record links one client to one policy version with the date acknowledged, acceptance status, attestation method, and next renewal date. This is a critical audit trail for regulatory compliance and risk management.. Existence Justification: Legal services firms are required by regulators to obtain and track client acknowledgement of multiple compliance policies (AML, conflicts of interest, data protection, engagement terms, etc.). Each client must acknowledge multiple policies, and each policy must be acknowledged by multiple clients. The business actively manages this relationship through onboarding workflows, renewal cycles, and audit trail maintenance for regulatory examinations.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`compliance`.`audit_program` (
    `audit_program_id` BIGINT COMMENT 'Primary key for audit_program',
    `employee_id` BIGINT COMMENT 'Identifier of the individual who approved this audit program for execution.',
    `department_id` BIGINT COMMENT 'Identifier of the department or business unit that owns or is subject to this audit program.',
    `parent_audit_program_id` BIGINT COMMENT 'Self-referencing FK on audit_program (parent_audit_program_id)',
    `primary_lead_auditor_employee_id` BIGINT COMMENT 'Identifier of the lead auditor assigned to execute this audit program.',
    `program_owner_employee_id` BIGINT COMMENT 'Identifier of the individual or role responsible for the overall management and governance of this audit program.',
    `control_framework_id` BIGINT COMMENT 'Foreign key linking to compliance.control_framework. Business justification: Audit programs are often designed to test compliance with specific control frameworks (e.g., ISO 27001 Annual Audit Program, SOX Controls Testing Program). The audit_program table has compliance_f',
    `approval_date` DATE COMMENT 'Date when the audit program was formally approved.',
    `approval_status` STRING COMMENT 'Current approval status of the audit program by governance or management.',
    `audit_criteria` STRING COMMENT 'Set of policies, procedures, standards, or requirements used as a reference against which audit evidence is compared.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Allocated budget for executing this audit program, in the firms base currency (GBP for UK-based legal firms).',
    `compliance_framework` STRING COMMENT 'Primary regulatory or compliance framework that this audit program addresses (e.g., SOX, GDPR, AML/KYC, FATF, SRA regulatory returns).',
    `confidentiality_level` STRING COMMENT 'Data classification level for the audit program documentation and findings.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit program record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget amount (e.g., GBP, USD, EUR).',
    `effective_end_date` DATE COMMENT 'Date when the audit program is scheduled to conclude or be retired. Null for ongoing programs.',
    `effective_start_date` DATE COMMENT 'Date when the audit program becomes active and binding for execution.',
    `estimated_duration_days` STRING COMMENT 'Estimated number of days required to complete one full cycle of this audit program.',
    `frequency` STRING COMMENT 'Scheduled frequency at which this audit program is executed (e.g., annual, quarterly, ad-hoc).',
    `is_active` BOOLEAN COMMENT 'Indicates whether this audit program is currently active and in use.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this audit program is mandated by regulation or is voluntary/discretionary.',
    `last_execution_date` DATE COMMENT 'Date when this audit program was last executed or completed.',
    `last_review_date` DATE COMMENT 'Date when the audit program was last reviewed or updated by governance.',
    `methodology` STRING COMMENT 'The audit approach or methodology employed in this program (e.g., risk-based, compliance-based, process-based).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit program record was last modified or updated.',
    `next_review_date` DATE COMMENT 'Date when the audit program is scheduled for its next periodic review or update.',
    `next_scheduled_date` DATE COMMENT 'Date when the next execution of this audit program is scheduled to begin.',
    `notes` STRING COMMENT 'Additional notes, comments, or context regarding the audit program.',
    `objective` STRING COMMENT 'Primary business objective or goal of the audit program (e.g., verify SOX controls effectiveness, assess GDPR compliance posture, validate AML procedures).',
    `priority` STRING COMMENT 'Business priority level assigned to this audit program for resource allocation and scheduling.',
    `program_code` STRING COMMENT 'Unique business identifier or reference code for the audit program used in reporting and tracking.',
    `program_name` STRING COMMENT 'The official name or title of the audit program (e.g., Annual SOX Compliance Audit, GDPR Data Privacy Review).',
    `program_status` STRING COMMENT 'Current lifecycle status of the audit program indicating its operational state.',
    `program_type` STRING COMMENT 'Classification of the audit program based on its origin and purpose (internal firm audit, external regulatory audit, client-requested audit, or combined).',
    `regulatory_authority` STRING COMMENT 'Name of the external regulatory body or authority mandating or overseeing this audit program (e.g., Solicitors Regulation Authority, Financial Conduct Authority, Information Commissioners Office).',
    `requires_external_auditor` BOOLEAN COMMENT 'Indicates whether this audit program requires participation or oversight by an external independent auditor.',
    `retention_period_years` STRING COMMENT 'Number of years that audit program records and findings must be retained per regulatory or firm policy.',
    `risk_level` STRING COMMENT 'Overall risk classification of the areas covered by this audit program, determining priority and resource allocation.',
    `scope_description` STRING COMMENT 'Detailed description of the audit programs scope, including areas covered, processes examined, and boundaries of the audit.',
    `version_number` STRING COMMENT 'Version number of the audit program document or framework (e.g., 1.0, 2.1).',
    CONSTRAINT pk_audit_program PRIMARY KEY(`audit_program_id`)
) COMMENT 'Master reference table for audit_program. Referenced by audit_program_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ADD CONSTRAINT `fk_compliance_compliance_control_control_framework_id` FOREIGN KEY (`control_framework_id`) REFERENCES `legal_ecm_v1`.`compliance`.`control_framework`(`control_framework_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ADD CONSTRAINT `fk_compliance_compliance_control_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ADD CONSTRAINT `fk_compliance_compliance_control_to_control_framework_id` FOREIGN KEY (`to_control_framework_id`) REFERENCES `legal_ecm_v1`.`compliance`.`control_framework`(`control_framework_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ADD CONSTRAINT `fk_compliance_compliance_control_to_regulatory_obligation_id` FOREIGN KEY (`to_regulatory_obligation_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ADD CONSTRAINT `fk_compliance_aml_kyc_program_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm_v1`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ADD CONSTRAINT `fk_compliance_aml_risk_assessment_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm_v1`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ADD CONSTRAINT `fk_compliance_aml_risk_assessment_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ADD CONSTRAINT `fk_compliance_sar_filing_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm_v1`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ADD CONSTRAINT `fk_compliance_sar_filing_regulatory_breach_id` FOREIGN KEY (`regulatory_breach_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_breach`(`regulatory_breach_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ADD CONSTRAINT `fk_compliance_sar_filing_sanctions_check_id` FOREIGN KEY (`sanctions_check_id`) REFERENCES `legal_ecm_v1`.`compliance`.`sanctions_check`(`sanctions_check_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ADD CONSTRAINT `fk_compliance_data_privacy_register_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm_v1`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ADD CONSTRAINT `fk_compliance_dpia_data_privacy_register_id` FOREIGN KEY (`data_privacy_register_id`) REFERENCES `legal_ecm_v1`.`compliance`.`data_privacy_register`(`data_privacy_register_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ADD CONSTRAINT `fk_compliance_data_subject_request_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm_v1`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ADD CONSTRAINT `fk_compliance_data_subject_request_data_privacy_register_id` FOREIGN KEY (`data_privacy_register_id`) REFERENCES `legal_ecm_v1`.`compliance`.`data_privacy_register`(`data_privacy_register_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ADD CONSTRAINT `fk_compliance_data_subject_request_privacy_breach_id` FOREIGN KEY (`privacy_breach_id`) REFERENCES `legal_ecm_v1`.`compliance`.`privacy_breach`(`privacy_breach_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ADD CONSTRAINT `fk_compliance_privacy_breach_data_privacy_register_id` FOREIGN KEY (`data_privacy_register_id`) REFERENCES `legal_ecm_v1`.`compliance`.`data_privacy_register`(`data_privacy_register_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ADD CONSTRAINT `fk_compliance_privacy_breach_primary_data_privacy_register_id` FOREIGN KEY (`primary_data_privacy_register_id`) REFERENCES `legal_ecm_v1`.`compliance`.`data_privacy_register`(`data_privacy_register_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` ADD CONSTRAINT `fk_compliance_regulatory_return_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` ADD CONSTRAINT `fk_compliance_regulatory_return_regulatory_breach_id` FOREIGN KEY (`regulatory_breach_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_breach`(`regulatory_breach_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control_test` ADD CONSTRAINT `fk_compliance_compliance_control_test_audit_program_id` FOREIGN KEY (`audit_program_id`) REFERENCES `legal_ecm_v1`.`compliance`.`audit_program`(`audit_program_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control_test` ADD CONSTRAINT `fk_compliance_compliance_control_test_compliance_control_id` FOREIGN KEY (`compliance_control_id`) REFERENCES `legal_ecm_v1`.`compliance`.`compliance_control`(`compliance_control_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ADD CONSTRAINT `fk_compliance_regulatory_breach_compliance_control_id` FOREIGN KEY (`compliance_control_id`) REFERENCES `legal_ecm_v1`.`compliance`.`compliance_control`(`compliance_control_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ADD CONSTRAINT `fk_compliance_regulatory_breach_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ADD CONSTRAINT `fk_compliance_regulatory_breach_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm_v1`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ADD CONSTRAINT `fk_compliance_indemnity_claim_indemnity_policy_id` FOREIGN KEY (`indemnity_policy_id`) REFERENCES `legal_ecm_v1`.`compliance`.`indemnity_policy`(`indemnity_policy_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ADD CONSTRAINT `fk_compliance_training_programme_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm_v1`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ADD CONSTRAINT `fk_compliance_training_programme_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ADD CONSTRAINT `fk_compliance_sanctions_check_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm_v1`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_control_framework_id` FOREIGN KEY (`control_framework_id`) REFERENCES `legal_ecm_v1`.`compliance`.`control_framework`(`control_framework_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_primary_regulatory_obligation_id` FOREIGN KEY (`primary_regulatory_obligation_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ADD CONSTRAINT `fk_compliance_policy_control_framework_id` FOREIGN KEY (`control_framework_id`) REFERENCES `legal_ecm_v1`.`compliance`.`control_framework`(`control_framework_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ADD CONSTRAINT `fk_compliance_policy_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_control_framework_id` FOREIGN KEY (`control_framework_id`) REFERENCES `legal_ecm_v1`.`compliance`.`control_framework`(`control_framework_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_audit_engagement_id` FOREIGN KEY (`audit_engagement_id`) REFERENCES `legal_ecm_v1`.`compliance`.`audit_engagement`(`audit_engagement_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_compliance_control_id` FOREIGN KEY (`compliance_control_id`) REFERENCES `legal_ecm_v1`.`compliance`.`compliance_control`(`compliance_control_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm_v1`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_scope` ADD CONSTRAINT `fk_compliance_audit_scope_audit_engagement_id` FOREIGN KEY (`audit_engagement_id`) REFERENCES `legal_ecm_v1`.`compliance`.`audit_engagement`(`audit_engagement_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_scope` ADD CONSTRAINT `fk_compliance_audit_scope_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy_acknowledgement` ADD CONSTRAINT `fk_compliance_policy_acknowledgement_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm_v1`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ADD CONSTRAINT `fk_compliance_audit_program_parent_audit_program_id` FOREIGN KEY (`parent_audit_program_id`) REFERENCES `legal_ecm_v1`.`compliance`.`audit_program`(`audit_program_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ADD CONSTRAINT `fk_compliance_audit_program_control_framework_id` FOREIGN KEY (`control_framework_id`) REFERENCES `legal_ecm_v1`.`compliance`.`control_framework`(`control_framework_id`);

-- ========= TAGS =========
ALTER SCHEMA `legal_ecm_v1`.`compliance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `legal_ecm_v1`.`compliance` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation ID');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `applicability_scope` SET TAGS ('dbx_business_glossary_term' = 'Applicability Scope');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|in_progress|under_review|not_applicable');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `control_framework_reference` SET TAGS ('dbx_business_glossary_term' = 'Control Framework Reference');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `exemption_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Exemption Applicable Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `exemption_details` SET TAGS ('dbx_business_glossary_term' = 'Exemption Details');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `external_audit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'External Audit Required Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `filing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Filing Frequency');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `filing_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly|event_based|not_applicable');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `governing_body` SET TAGS ('dbx_business_glossary_term' = 'Governing Body');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `last_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Assessment Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `last_external_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last External Audit Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `maximum_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Penalty Amount');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `next_external_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next External Audit Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `next_filing_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Filing Due Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `obligation_category` SET TAGS ('dbx_business_glossary_term' = 'Obligation Category');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_business_glossary_term' = 'Obligation Code');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `obligation_description` SET TAGS ('dbx_business_glossary_term' = 'Obligation Description');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `obligation_name` SET TAGS ('dbx_business_glossary_term' = 'Obligation Name');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_business_glossary_term' = 'Obligation Type');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_value_regex' = 'periodic_filing|ongoing_conduct|event_triggered|registration|disclosure|reporting');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `penalty_for_non_compliance` SET TAGS ('dbx_business_glossary_term' = 'Penalty for Non-Compliance');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'urgent|high|medium|low');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `related_policy_reference` SET TAGS ('dbx_business_glossary_term' = 'Related Policy Reference');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `responsible_officer` SET TAGS ('dbx_business_glossary_term' = 'Responsible Officer');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `review_cycle` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `review_cycle` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly|ad_hoc|continuous');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `source_legislation_url` SET TAGS ('dbx_business_glossary_term' = 'Source Legislation URL');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `training_frequency` SET TAGS ('dbx_business_glossary_term' = 'Training Frequency');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `training_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|one_time|not_applicable');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`control_framework` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`compliance`.`control_framework` ALTER COLUMN `control_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Control Framework Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`control_framework` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`control_framework` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Framework Owner Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`control_framework` ALTER COLUMN `adoption_date` SET TAGS ('dbx_business_glossary_term' = 'Adoption Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`control_framework` ALTER COLUMN `certification_body` SET TAGS ('dbx_business_glossary_term' = 'Certification Body');
ALTER TABLE `legal_ecm_v1`.`compliance`.`control_framework` ALTER COLUMN `certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Required Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`control_framework` ALTER COLUMN `compliance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Compliance Percentage');
ALTER TABLE `legal_ecm_v1`.`compliance`.`control_framework` ALTER COLUMN `control_count` SET TAGS ('dbx_business_glossary_term' = 'Control Count');
ALTER TABLE `legal_ecm_v1`.`compliance`.`control_framework` ALTER COLUMN `control_domain_mapping` SET TAGS ('dbx_business_glossary_term' = 'Control Domain Mapping');
ALTER TABLE `legal_ecm_v1`.`compliance`.`control_framework` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`compliance`.`control_framework` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`control_framework` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`control_framework` ALTER COLUMN `framework_code` SET TAGS ('dbx_business_glossary_term' = 'Framework Code');
ALTER TABLE `legal_ecm_v1`.`compliance`.`control_framework` ALTER COLUMN `framework_description` SET TAGS ('dbx_business_glossary_term' = 'Framework Description');
ALTER TABLE `legal_ecm_v1`.`compliance`.`control_framework` ALTER COLUMN `framework_name` SET TAGS ('dbx_business_glossary_term' = 'Framework Name');
ALTER TABLE `legal_ecm_v1`.`compliance`.`control_framework` ALTER COLUMN `framework_status` SET TAGS ('dbx_business_glossary_term' = 'Framework Status');
ALTER TABLE `legal_ecm_v1`.`compliance`.`control_framework` ALTER COLUMN `framework_status` SET TAGS ('dbx_value_regex' = 'active|superseded|retired|under_review|pending_adoption');
ALTER TABLE `legal_ecm_v1`.`compliance`.`control_framework` ALTER COLUMN `framework_type` SET TAGS ('dbx_business_glossary_term' = 'Framework Type');
ALTER TABLE `legal_ecm_v1`.`compliance`.`control_framework` ALTER COLUMN `framework_type` SET TAGS ('dbx_value_regex' = 'regulatory|industry_standard|internal|best_practice|certification|contractual');
ALTER TABLE `legal_ecm_v1`.`compliance`.`control_framework` ALTER COLUMN `framework_url` SET TAGS ('dbx_business_glossary_term' = 'Framework Uniform Resource Locator (URL)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`control_framework` ALTER COLUMN `framework_version` SET TAGS ('dbx_business_glossary_term' = 'Framework Version');
ALTER TABLE `legal_ecm_v1`.`compliance`.`control_framework` ALTER COLUMN `issuing_body` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body');
ALTER TABLE `legal_ecm_v1`.`compliance`.`control_framework` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `legal_ecm_v1`.`compliance`.`control_framework` ALTER COLUMN `last_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Certification Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`control_framework` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`compliance`.`control_framework` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`control_framework` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`control_framework` ALTER COLUMN `next_certification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Certification Due Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`control_framework` ALTER COLUMN `next_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Due Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`control_framework` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm_v1`.`compliance`.`control_framework` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency');
ALTER TABLE `legal_ecm_v1`.`compliance`.`control_framework` ALTER COLUMN `review_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly|ad_hoc|continuous');
ALTER TABLE `legal_ecm_v1`.`compliance`.`control_framework` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `legal_ecm_v1`.`compliance`.`control_framework` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `legal_ecm_v1`.`compliance`.`control_framework` ALTER COLUMN `scope_of_applicability` SET TAGS ('dbx_business_glossary_term' = 'Scope of Applicability');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `compliance_control_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Control Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `user_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `user_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `user_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Control Owner Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `control_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Control Framework Id');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `to_control_framework_id` SET TAGS ('dbx_business_glossary_term' = 'To Control Framework Id');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `to_regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'To Regulatory Obligation Id');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `compensating_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Compensating Control Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `control_description` SET TAGS ('dbx_business_glossary_term' = 'Control Description');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `control_status` SET TAGS ('dbx_business_glossary_term' = 'Control Lifecycle Status');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `control_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|under_review|retired');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `control_type` SET TAGS ('dbx_business_glossary_term' = 'Control Type');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `control_type` SET TAGS ('dbx_value_regex' = 'preventive|detective|corrective|directive');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `documentation_reference` SET TAGS ('dbx_business_glossary_term' = 'Control Documentation Reference');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Control Effective From Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Control Effective To Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `effectiveness_rating` SET TAGS ('dbx_business_glossary_term' = 'Control Effectiveness Rating');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `effectiveness_rating` SET TAGS ('dbx_value_regex' = 'highly_effective|effective|needs_improvement|ineffective');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `exception_count` SET TAGS ('dbx_business_glossary_term' = 'Control Test Exception Count');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `exception_description` SET TAGS ('dbx_business_glossary_term' = 'Control Exception Description');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Control Execution Frequency');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `gdpr_article_reference` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Article Reference');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `identifier` SET TAGS ('dbx_business_glossary_term' = 'Control Business Identifier');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `identifier` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}-[0-9]{3,5}$');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `iso_27001_control_reference` SET TAGS ('dbx_business_glossary_term' = 'ISO 27001 Control Reference');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `iso_27001_control_reference` SET TAGS ('dbx_value_regex' = '^A.[0-9]{1,2}.[0-9]{1,2}$');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `key_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Key Control Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `last_test_conclusion` SET TAGS ('dbx_business_glossary_term' = 'Last Test Conclusion');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `last_test_conclusion` SET TAGS ('dbx_value_regex' = 'effective|ineffective|partially_effective|not_tested');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `last_test_date` SET TAGS ('dbx_business_glossary_term' = 'Last Control Test Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `nature` SET TAGS ('dbx_business_glossary_term' = 'Control Nature');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `nature` SET TAGS ('dbx_value_regex' = 'manual|automated|hybrid');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `next_test_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Control Test Due Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `objective` SET TAGS ('dbx_business_glossary_term' = 'Control Objective');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `procedure` SET TAGS ('dbx_business_glossary_term' = 'Control Procedure');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `remediation_plan` SET TAGS ('dbx_business_glossary_term' = 'Control Remediation Plan');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `remediation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Remediation Required Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|overdue|cancelled');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Control Risk Rating');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Control Test Sample Size');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `sox_scoping_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Scoping Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `sra_standard_reference` SET TAGS ('dbx_business_glossary_term' = 'Solicitors Regulation Authority (SRA) Standard Reference');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `testing_methodology` SET TAGS ('dbx_business_glossary_term' = 'Control Testing Methodology');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Control Title');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `utbms_task_code` SET TAGS ('dbx_business_glossary_term' = 'Uniform Task-Based Management System (UTBMS) Task Code');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ALTER COLUMN `utbms_task_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{3}$');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `aml_kyc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Know Your Client (KYC) Program ID');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `applicable_jurisdictions` SET TAGS ('dbx_business_glossary_term' = 'Applicable Jurisdictions');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `audit_findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Audit Findings Summary');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `audit_findings_summary` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `board_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Board Approval Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `client_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Client Risk Rating');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `client_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `client_risk_rating` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `control_effectiveness_rating` SET TAGS ('dbx_business_glossary_term' = 'Control Effectiveness Rating');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `control_effectiveness_rating` SET TAGS ('dbx_value_regex' = 'effective|partially_effective|ineffective|not_tested');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `control_effectiveness_rating` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `delivery_channel_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Risk Rating');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `delivery_channel_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `delivery_channel_risk_rating` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Program Effective Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Program Expiry Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `geographic_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Geographic Risk Rating');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `geographic_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `geographic_risk_rating` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `inherent_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Inherent Risk Rating');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `inherent_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `inherent_risk_rating` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `last_risk_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Risk Assessment Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By User');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `mlro_email` SET TAGS ('dbx_business_glossary_term' = 'MLRO Email Address');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `mlro_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `mlro_email` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `mlro_email` SET TAGS ('dbx_dbx_pii_email' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `mlro_name` SET TAGS ('dbx_business_glossary_term' = 'Money Laundering Reporting Officer (MLRO) Name');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `mlro_name` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `mlro_phone` SET TAGS ('dbx_business_glossary_term' = 'MLRO Phone Number');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `mlro_phone` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `mlro_phone` SET TAGS ('dbx_dbx_pii_phone' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `next_risk_assessment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Risk Assessment Due Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `product_service_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Product and Service Risk Rating');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `product_service_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `product_service_risk_rating` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `program_documentation_location` SET TAGS ('dbx_business_glossary_term' = 'Program Documentation Location');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `program_documentation_location` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'AML/KYC Program Name');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `program_scope` SET TAGS ('dbx_business_glossary_term' = 'Program Scope');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'draft|active|under_review|suspended|archived');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `program_version` SET TAGS ('dbx_business_glossary_term' = 'Program Version');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|conditionally_approved|rejected|not_required');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `residual_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Rating');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `residual_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `residual_risk_rating` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `risk_appetite_statement` SET TAGS ('dbx_business_glossary_term' = 'Risk Appetite Statement');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `risk_appetite_statement` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `risk_assessment_findings` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Findings');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `risk_assessment_findings` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `risk_assessment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Frequency');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `risk_assessment_frequency` SET TAGS ('dbx_value_regex' = 'annual|biannual|quarterly|ad_hoc|event_driven');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `risk_assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessor Name');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `risk_assessor_name` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `risk_methodology` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Methodology');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `suspicious_activity_reports_filed` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Reports (SAR) Filed Count');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `suspicious_activity_reports_filed` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `training_completion_rate` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Rate Percentage');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `aml_risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Risk Assessment ID');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `aml_kyc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Kyc Program Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip License Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `adverse_media_screening_coverage` SET TAGS ('dbx_business_glossary_term' = 'Adverse Media Screening Coverage');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `adverse_media_screening_coverage` SET TAGS ('dbx_value_regex' = 'full|partial|none');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `assessment_methodology` SET TAGS ('dbx_business_glossary_term' = 'Assessment Methodology');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `assessment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Assessment Reference Number');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `assessment_reference_number` SET TAGS ('dbx_value_regex' = '^AML-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|superseded|archived');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'firm_wide|matter_type|client_segment|geographic|product_service|delivery_channel');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Assessor Name');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `assessor_role` SET TAGS ('dbx_business_glossary_term' = 'Assessor Role');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `board_presentation_date` SET TAGS ('dbx_business_glossary_term' = 'Board Presentation Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `control_effectiveness_rating` SET TAGS ('dbx_business_glossary_term' = 'Control Effectiveness Rating');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `control_effectiveness_rating` SET TAGS ('dbx_value_regex' = 'ineffective|partially_effective|effective|highly_effective');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `data_sources` SET TAGS ('dbx_business_glossary_term' = 'Data Sources');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `effective_until_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `external_audit_date` SET TAGS ('dbx_business_glossary_term' = 'External Audit Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `external_auditor_name` SET TAGS ('dbx_business_glossary_term' = 'External Auditor Name');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Findings Summary');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `high_risk_jurisdictions_identified` SET TAGS ('dbx_business_glossary_term' = 'High-Risk Jurisdictions Identified');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `inherent_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Inherent Risk Rating');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `inherent_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `inherent_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Inherent Risk Score');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `jurisdiction_scope` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Scope');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `key_risk_indicators` SET TAGS ('dbx_business_glossary_term' = 'Key Risk Indicators (KRI)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `mlro_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Money Laundering Reporting Officer (MLRO) Approval Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `mlro_approval_name` SET TAGS ('dbx_business_glossary_term' = 'Money Laundering Reporting Officer (MLRO) Approval Name');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `pep_exposure_flag` SET TAGS ('dbx_business_glossary_term' = 'Politically Exposed Person (PEP) Exposure Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `recommendations` SET TAGS ('dbx_business_glossary_term' = 'Recommendations');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `regulatory_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `regulatory_submission_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `residual_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Rating');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `residual_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `residual_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Score');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `risk_appetite_alignment` SET TAGS ('dbx_business_glossary_term' = 'Risk Appetite Alignment');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `risk_appetite_alignment` SET TAGS ('dbx_value_regex' = 'within_appetite|near_limit|exceeds_appetite');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'client|geographic|product_service|delivery_channel|transaction|other');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `risk_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Risk Subcategory');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `sanctions_screening_coverage` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Coverage');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `sanctions_screening_coverage` SET TAGS ('dbx_value_regex' = 'full|partial|none');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `transaction_monitoring_coverage` SET TAGS ('dbx_business_glossary_term' = 'Transaction Monitoring Coverage');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `transaction_monitoring_coverage` SET TAGS ('dbx_value_regex' = 'full|partial|none');
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `sar_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Filing ID');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Document Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `aml_kyc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Aml Kyc Program Id');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Money Laundering Reporting Officer (MLRO) ID');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `regulatory_breach_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Breach Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `sanctions_check_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Sanctions Check Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `acknowledgment_reference` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Reference');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `consent_outcome` SET TAGS ('dbx_business_glossary_term' = 'Consent Outcome');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `consent_outcome` SET TAGS ('dbx_value_regex' = 'granted|refused|no_response|not_applicable');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `consent_outcome_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Outcome Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `consent_request_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Request Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `consent_request_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Request Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `filing_authority` SET TAGS ('dbx_business_glossary_term' = 'Filing Authority');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `filing_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Filing Jurisdiction');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Filing Status');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|submitted|acknowledged|rejected|withdrawn');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `filing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Filing Timestamp');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `follow_up_action_description` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Action Description');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `follow_up_action_description` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `follow_up_action_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Action Required');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `internal_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Internal Reference Number');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `internal_report_date` SET TAGS ('dbx_business_glossary_term' = 'Internal Report Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `law_enforcement_reference` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Reference');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `law_enforcement_reference` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `mlro_name` SET TAGS ('dbx_business_glossary_term' = 'Money Laundering Reporting Officer (MLRO) Name');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `mlro_name` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `relationship_terminated_flag` SET TAGS ('dbx_business_glossary_term' = 'Relationship Terminated Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `relationship_termination_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Termination Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `reporter_name` SET TAGS ('dbx_business_glossary_term' = 'Reporter Name');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `reporter_name` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiry Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `review_notes` SET TAGS ('dbx_business_glossary_term' = 'Review Notes');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `review_notes` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `sar_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Reference Number');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `subject_identifier_type` SET TAGS ('dbx_business_glossary_term' = 'Subject Identifier Type');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `subject_identifier_type` SET TAGS ('dbx_value_regex' = 'passport|national_id|company_registration|tax_id|other');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `subject_identifier_value` SET TAGS ('dbx_business_glossary_term' = 'Subject Identifier Value');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `subject_identifier_value` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `subject_identifier_value` SET TAGS ('dbx_dbx_pii_identifier' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `subject_name_anonymised` SET TAGS ('dbx_business_glossary_term' = 'Subject Name (Anonymised)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `subject_name_anonymised` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `subject_name_anonymised` SET TAGS ('dbx_dbx_pii_identifier' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `subject_type` SET TAGS ('dbx_business_glossary_term' = 'Subject Type');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `subject_type` SET TAGS ('dbx_value_regex' = 'individual|organisation|trust|partnership|other');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `suspicion_category` SET TAGS ('dbx_business_glossary_term' = 'Suspicion Category');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `suspicion_category` SET TAGS ('dbx_value_regex' = 'money_laundering|terrorist_financing|fraud|bribery_corruption|sanctions_breach|tax_evasion');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `suspicion_grounds` SET TAGS ('dbx_business_glossary_term' = 'Suspicion Grounds');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `suspicion_grounds` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `tipping_off_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Tipping Off Risk Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ALTER COLUMN `transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Transaction Reference');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `data_privacy_register_id` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Register ID');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `controller_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Controller Contact Email');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `controller_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `controller_contact_email` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `controller_contact_email` SET TAGS ('dbx_dbx_pii_email' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `controller_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Controller Contact Name');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `controller_contact_name` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `controller_name` SET TAGS ('dbx_business_glossary_term' = 'Data Controller Name');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `data_privacy_register_status` SET TAGS ('dbx_business_glossary_term' = 'Entry Status');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `data_privacy_register_status` SET TAGS ('dbx_value_regex' = 'draft|active|under_review|suspended|archived');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `data_subject_categories` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Categories');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `dpia_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Impact Assessment (DPIA) Completion Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `dpia_mitigation_measures` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Impact Assessment (DPIA) Mitigation Measures');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `dpia_necessity_assessment` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Impact Assessment (DPIA) Necessity Assessment');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `dpia_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Impact Assessment (DPIA) Required Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `dpia_risk_identification` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Impact Assessment (DPIA) Risk Identification');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `dpia_trigger_reason` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Impact Assessment (DPIA) Trigger Reason');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `dpo_consultation_date` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Officer (DPO) Consultation Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `dpo_consultation_outcome` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Officer (DPO) Consultation Outcome');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `dpo_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Officer (DPO) Contact Email');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `dpo_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `dpo_contact_email` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `dpo_contact_email` SET TAGS ('dbx_dbx_pii_email' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `dpo_name` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Officer (DPO) Name');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `dpo_name` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `entry_type` SET TAGS ('dbx_business_glossary_term' = 'Entry Type');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `entry_type` SET TAGS ('dbx_value_regex' = 'ropa|dpia|combined');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `legal_basis` SET TAGS ('dbx_business_glossary_term' = 'Legal Basis for Processing');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `legal_basis` SET TAGS ('dbx_value_regex' = 'consent|contract|legal_obligation|vital_interests|public_task|legitimate_interests');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `legitimate_interest_description` SET TAGS ('dbx_business_glossary_term' = 'Legitimate Interest Description');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `organizational_security_measures` SET TAGS ('dbx_business_glossary_term' = 'Organizational Security Measures');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `personal_data_categories` SET TAGS ('dbx_business_glossary_term' = 'Personal Data Categories');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `processing_activity_code` SET TAGS ('dbx_business_glossary_term' = 'Processing Activity Code');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `processing_activity_name` SET TAGS ('dbx_business_glossary_term' = 'Processing Activity Name');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `processing_purpose` SET TAGS ('dbx_business_glossary_term' = 'Processing Purpose');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `recipient_categories` SET TAGS ('dbx_business_glossary_term' = 'Recipient Categories');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `retention_justification` SET TAGS ('dbx_business_glossary_term' = 'Retention Justification');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `retention_period` SET TAGS ('dbx_business_glossary_term' = 'Retention Period');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `review_frequency` SET TAGS ('dbx_value_regex' = 'annual|biannual|quarterly|ad_hoc|continuous');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `special_category_data_flag` SET TAGS ('dbx_business_glossary_term' = 'Special Category Data Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `special_category_data_types` SET TAGS ('dbx_business_glossary_term' = 'Special Category Data Types');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `supervisory_authority_consultation_date` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Authority Consultation Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `supervisory_authority_consultation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Authority Consultation Required Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `supervisory_authority_response` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Authority Response');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `technical_security_measures` SET TAGS ('dbx_business_glossary_term' = 'Technical Security Measures');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `third_country_names` SET TAGS ('dbx_business_glossary_term' = 'Third Country Names');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `third_country_transfer_flag` SET TAGS ('dbx_business_glossary_term' = 'Third Country Transfer Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `transfer_safeguard_details` SET TAGS ('dbx_business_glossary_term' = 'Transfer Safeguard Details');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `transfer_safeguard_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Transfer Safeguard Mechanism');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ALTER COLUMN `transfer_safeguard_mechanism` SET TAGS ('dbx_value_regex' = 'adequacy_decision|standard_contractual_clauses|binding_corporate_rules|certification|code_of_conduct|other');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `dpia_id` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Impact Assessment (DPIA) ID');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `data_privacy_register_id` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Register Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Document Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|conditionally_approved|rejected');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `assessment_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Completion Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `assessment_conducted_by` SET TAGS ('dbx_business_glossary_term' = 'Assessment Conducted By');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `assessment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Assessment Reference Number');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `assessment_reference_number` SET TAGS ('dbx_value_regex' = '^DPIA-[0-9]{4}-[0-9]{4}$');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `assessment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Start Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `assessment_title` SET TAGS ('dbx_business_glossary_term' = 'Assessment Title');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `data_categories` SET TAGS ('dbx_business_glossary_term' = 'Data Categories');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `data_controller_name` SET TAGS ('dbx_business_glossary_term' = 'Data Controller Name');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `data_minimization_measures` SET TAGS ('dbx_business_glossary_term' = 'Data Minimization Measures');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `data_processor_name` SET TAGS ('dbx_business_glossary_term' = 'Data Processor Name');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `data_subject_categories` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Categories');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `data_subjects_consulted_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Subjects Consulted Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `dpo_advice` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Officer (DPO) Advice');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `dpo_consultation_date` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Officer (DPO) Consultation Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `dpo_consulted_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Officer (DPO) Consulted Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `lawful_basis` SET TAGS ('dbx_business_glossary_term' = 'Lawful Basis');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `lawful_basis` SET TAGS ('dbx_value_regex' = 'consent|contract|legal_obligation|vital_interests|public_task|legitimate_interests');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `mitigation_measures` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Measures');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `necessity_assessment` SET TAGS ('dbx_business_glossary_term' = 'Necessity Assessment');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `processing_purpose` SET TAGS ('dbx_business_glossary_term' = 'Processing Purpose');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `proportionality_assessment` SET TAGS ('dbx_business_glossary_term' = 'Proportionality Assessment');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `residual_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Level');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `residual_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `retention_period` SET TAGS ('dbx_business_glossary_term' = 'Retention Period');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `review_frequency` SET TAGS ('dbx_value_regex' = 'annual|biannual|quarterly|on_change|continuous');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `risk_identification_summary` SET TAGS ('dbx_business_glossary_term' = 'Risk Identification Summary');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `special_category_data_flag` SET TAGS ('dbx_business_glossary_term' = 'Special Category Data Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `supervisory_authority_consultation_date` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Authority Consultation Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `supervisory_authority_consultation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Authority Consultation Required Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `supervisory_authority_decision` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Authority Decision');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `supervisory_authority_reference` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Authority Reference');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `trigger_reason` SET TAGS ('dbx_business_glossary_term' = 'Trigger Reason');
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ALTER COLUMN `vulnerable_data_subjects_flag` SET TAGS ('dbx_business_glossary_term' = 'Vulnerable Data Subjects Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `data_subject_request_id` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Request ID');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Dpo Officer Timekeeper Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `client_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Response Document Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `data_privacy_register_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Data Privacy Register Id');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `privacy_breach_id` SET TAGS ('dbx_business_glossary_term' = 'Related Privacy Breach Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `authorized_representative_flag` SET TAGS ('dbx_business_glossary_term' = 'Authorized Representative Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `complaint_lodged_flag` SET TAGS ('dbx_business_glossary_term' = 'Complaint Lodged Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `complaint_reference` SET TAGS ('dbx_business_glossary_term' = 'Complaint Reference Number');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `data_subject_address` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Address');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `data_subject_address` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `data_subject_address` SET TAGS ('dbx_dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `data_subject_identifier` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Identifier');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `data_subject_identifier` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `data_subject_identifier` SET TAGS ('dbx_dbx_pii_identifier' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `data_volume_pages` SET TAGS ('dbx_business_glossary_term' = 'Data Volume in Pages');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `data_volume_records` SET TAGS ('dbx_business_glossary_term' = 'Data Volume in Records');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `exemption_applied` SET TAGS ('dbx_business_glossary_term' = 'Exemption Applied');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `extended_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Extended Deadline Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `extension_applied_flag` SET TAGS ('dbx_business_glossary_term' = 'Extension Applied Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `extension_reason` SET TAGS ('dbx_business_glossary_term' = 'Extension Reason');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `identity_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Identity Verification Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `identity_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Identity Verification Method');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `identity_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Identity Verification Status');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `identity_verification_status` SET TAGS ('dbx_value_regex' = 'not_started|pending|verified|failed|exemption_applied');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `lpp_exemption_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Professional Privilege (LPP) Exemption Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Request Notes');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Request Outcome');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'fully_granted|partially_granted|refused|withdrawn_by_subject|no_data_held');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `processing_time_days` SET TAGS ('dbx_business_glossary_term' = 'Processing Time in Days');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `receipt_channel` SET TAGS ('dbx_business_glossary_term' = 'Receipt Channel');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `receipt_channel` SET TAGS ('dbx_value_regex' = 'email|postal_mail|web_portal|phone|in_person|third_party_representative');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Receipt Timestamp');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `refusal_reason` SET TAGS ('dbx_business_glossary_term' = 'Refusal Reason');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `representative_name` SET TAGS ('dbx_business_glossary_term' = 'Representative Name');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `representative_name` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `representative_name` SET TAGS ('dbx_dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `representative_relationship` SET TAGS ('dbx_business_glossary_term' = 'Representative Relationship');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `representative_relationship` SET TAGS ('dbx_value_regex' = 'parent|guardian|attorney|executor|power_of_attorney|other');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `request_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Request Reference Number');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `request_reference_number` SET TAGS ('dbx_value_regex' = '^DSR-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `request_scope_description` SET TAGS ('dbx_business_glossary_term' = 'Request Scope Description');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Request Status');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `request_type` SET TAGS ('dbx_business_glossary_term' = 'Request Type');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `request_type` SET TAGS ('dbx_value_regex' = 'subject_access_request|right_to_erasure|right_to_rectification|right_to_data_portability|right_to_object|right_to_restrict_processing');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `response_date` SET TAGS ('dbx_business_glossary_term' = 'Response Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `response_method` SET TAGS ('dbx_business_glossary_term' = 'Response Method');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `response_method` SET TAGS ('dbx_value_regex' = 'email|postal_mail|secure_portal|encrypted_file|in_person|phone');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `statutory_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Statutory Deadline Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `systems_searched` SET TAGS ('dbx_business_glossary_term' = 'Systems Searched');
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ALTER COLUMN `third_party_data_flag` SET TAGS ('dbx_business_glossary_term' = 'Third Party Data Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `privacy_breach_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Breach Identifier');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Partner ID');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `data_privacy_register_id` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Register Id');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Notification Document Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `primary_data_privacy_register_id` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Register Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `user_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `user_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `user_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `privacy_last_modified_by_user_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `privacy_last_modified_by_user_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `privacy_last_modified_by_user_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `data_breach_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Data Breach Incident Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Owner ID');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `affected_data_categories` SET TAGS ('dbx_business_glossary_term' = 'Affected Data Categories');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `affected_data_categories` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `affected_system_name` SET TAGS ('dbx_business_glossary_term' = 'Affected System Name');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `affected_system_name` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `breach_cause` SET TAGS ('dbx_business_glossary_term' = 'Breach Cause');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `breach_cause` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `breach_description` SET TAGS ('dbx_business_glossary_term' = 'Breach Description');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `breach_description` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `breach_location` SET TAGS ('dbx_business_glossary_term' = 'Breach Location');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `breach_location` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `breach_status` SET TAGS ('dbx_business_glossary_term' = 'Breach Status');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `breach_status` SET TAGS ('dbx_value_regex' = 'reported|under_investigation|contained|remediated|closed');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `breach_type` SET TAGS ('dbx_business_glossary_term' = 'Breach Type');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `breach_type` SET TAGS ('dbx_value_regex' = 'accidental_loss|accidental_destruction|accidental_alteration|unauthorised_disclosure|unauthorised_access|unlawful_processing');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `containment_date` SET TAGS ('dbx_business_glossary_term' = 'Containment Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `containment_measures_taken` SET TAGS ('dbx_business_glossary_term' = 'Containment Measures Taken');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `containment_measures_taken` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `data_records_count` SET TAGS ('dbx_business_glossary_term' = 'Data Records Count');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `data_subject_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Notification Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `data_subject_notification_method` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Notification Method');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `data_subject_notification_method` SET TAGS ('dbx_value_regex' = 'email|postal_mail|phone|public_communication|website_notice');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `data_subject_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Notification Required Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `data_subjects_count` SET TAGS ('dbx_business_glossary_term' = 'Data Subjects Count');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Discovery Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `discovery_method` SET TAGS ('dbx_business_glossary_term' = 'Discovery Method');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `discovery_method` SET TAGS ('dbx_value_regex' = 'internal_audit|system_alert|employee_report|client_complaint|third_party_notification|regulatory_inquiry');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `dpo_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Officer (DPO) Notification Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `dpo_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Officer (DPO) Notified Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `incident_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Reference Number');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `insurance_claim_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Claim Filed Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `insurance_claim_reference` SET TAGS ('dbx_business_glossary_term' = 'Insurance Claim Reference');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `insurance_claim_reference` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `post_incident_review_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Post-Incident Review Completed Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `post_incident_review_date` SET TAGS ('dbx_business_glossary_term' = 'Post-Incident Review Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `post_incident_review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Post-Incident Review Outcome');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `post_incident_review_outcome` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `preventive_controls_implemented` SET TAGS ('dbx_business_glossary_term' = 'Preventive Controls Implemented');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `preventive_controls_implemented` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `regulatory_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Penalty Amount');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `regulatory_penalty_amount` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `regulatory_penalty_currency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Penalty Currency');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `regulatory_penalty_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `remediation_actions_taken` SET TAGS ('dbx_business_glossary_term' = 'Remediation Actions Taken');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `remediation_actions_taken` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `remediation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Completion Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `risk_assessment_rationale` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Rationale');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `risk_assessment_rationale` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `risk_assessment_to_data_subjects` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment to Data Subjects');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `risk_assessment_to_data_subjects` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `special_category_data_involved_flag` SET TAGS ('dbx_business_glossary_term' = 'Special Category Data Involved Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `supervisory_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Authority Name');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `supervisory_authority_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Authority Notification Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `supervisory_authority_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Authority Notification Required Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ALTER COLUMN `supervisory_authority_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Authority Reference Number');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` ALTER COLUMN `regulatory_return_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Return ID');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Return Document Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Preparer Timekeeper Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` ALTER COLUMN `regulatory_breach_id` SET TAGS ('dbx_business_glossary_term' = 'Reported Regulatory Breach Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` ALTER COLUMN `accountant_name` SET TAGS ('dbx_business_glossary_term' = 'Accountant Name');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` ALTER COLUMN `accountant_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Accountant Registration Number');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` ALTER COLUMN `approver_role` SET TAGS ('dbx_business_glossary_term' = 'Approver Role');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` ALTER COLUMN `breach_description` SET TAGS ('dbx_business_glossary_term' = 'Breach Description');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` ALTER COLUMN `breach_discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Breach Discovery Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` ALTER COLUMN `breach_indicator` SET TAGS ('dbx_business_glossary_term' = 'Breach Indicator');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` ALTER COLUMN `breach_occurrence_date` SET TAGS ('dbx_business_glossary_term' = 'Breach Occurrence Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` ALTER COLUMN `breach_severity` SET TAGS ('dbx_business_glossary_term' = 'Breach Severity');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` ALTER COLUMN `breach_severity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` ALTER COLUMN `breach_type` SET TAGS ('dbx_business_glossary_term' = 'Breach Type');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` ALTER COLUMN `preparer_role` SET TAGS ('dbx_business_glossary_term' = 'Preparer Role');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` ALTER COLUMN `query_response_date` SET TAGS ('dbx_business_glossary_term' = 'Query Response Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` ALTER COLUMN `query_response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Query Response Due Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` ALTER COLUMN `regulatory_acknowledgement_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Acknowledgement Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` ALTER COLUMN `regulatory_findings` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Findings');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` ALTER COLUMN `regulatory_queries` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Queries');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` ALTER COLUMN `regulatory_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference Number');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` ALTER COLUMN `remediation_actions` SET TAGS ('dbx_business_glossary_term' = 'Remediation Actions');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` ALTER COLUMN `remediation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Completion Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` ALTER COLUMN `return_number` SET TAGS ('dbx_business_glossary_term' = 'Return Reference Number');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` ALTER COLUMN `return_type` SET TAGS ('dbx_business_glossary_term' = 'Return Type');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` ALTER COLUMN `reviewer_role` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Role');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Submission Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` ALTER COLUMN `submission_due_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Due Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'online_portal|email|postal_mail|electronic_filing_system|in_person');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` ALTER COLUMN `supporting_documents` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documents');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control_test` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control_test` ALTER COLUMN `compliance_control_test_id` SET TAGS ('dbx_business_glossary_term' = 'Control Test Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control_test` ALTER COLUMN `audit_program_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Program Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control_test` ALTER COLUMN `compliance_control_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Control Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control_test` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Tester Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control_test` ALTER COLUMN `reviewer_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control_test` ALTER COLUMN `risk_control_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Control Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control_test` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control_test` ALTER COLUMN `control_deficiency_severity` SET TAGS ('dbx_business_glossary_term' = 'Control Deficiency Severity');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control_test` ALTER COLUMN `control_deficiency_severity` SET TAGS ('dbx_value_regex' = 'none|deficiency|significant_deficiency|material_weakness');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control_test` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control_test` ALTER COLUMN `evidence_reference` SET TAGS ('dbx_business_glossary_term' = 'Evidence Reference');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control_test` ALTER COLUMN `exception_details` SET TAGS ('dbx_business_glossary_term' = 'Exception Details');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control_test` ALTER COLUMN `exception_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Exception Rate Percentage');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control_test` ALTER COLUMN `exceptions_identified_count` SET TAGS ('dbx_business_glossary_term' = 'Exceptions Identified Count');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control_test` ALTER COLUMN `external_auditor_flag` SET TAGS ('dbx_business_glossary_term' = 'External Auditor Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control_test` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control_test` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control_test` ALTER COLUMN `population_size` SET TAGS ('dbx_business_glossary_term' = 'Population Size');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control_test` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control_test` ALTER COLUMN `remediation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Remediation Required Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control_test` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control_test` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control_test` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control_test` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control_test` ALTER COLUMN `sampling_method` SET TAGS ('dbx_business_glossary_term' = 'Sampling Method');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control_test` ALTER COLUMN `test_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Test Completion Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control_test` ALTER COLUMN `test_conclusion` SET TAGS ('dbx_business_glossary_term' = 'Test Conclusion');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control_test` ALTER COLUMN `test_conclusion` SET TAGS ('dbx_value_regex' = 'effective|ineffective|partially_effective|not_tested|inconclusive');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control_test` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Test Execution Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control_test` ALTER COLUMN `test_methodology` SET TAGS ('dbx_business_glossary_term' = 'Test Methodology');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control_test` ALTER COLUMN `test_objective` SET TAGS ('dbx_business_glossary_term' = 'Test Objective');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control_test` ALTER COLUMN `test_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Test Period End Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control_test` ALTER COLUMN `test_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Test Period Start Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control_test` ALTER COLUMN `test_procedure_description` SET TAGS ('dbx_business_glossary_term' = 'Test Procedure Description');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control_test` ALTER COLUMN `test_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Test Reference Number');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control_test` ALTER COLUMN `test_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]+$');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control_test` ALTER COLUMN `test_results_summary` SET TAGS ('dbx_business_glossary_term' = 'Test Results Summary');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control_test` ALTER COLUMN `test_status` SET TAGS ('dbx_business_glossary_term' = 'Test Status');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control_test` ALTER COLUMN `test_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|under_review|approved|remediation_required');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control_test` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control_test` ALTER COLUMN `testing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Testing Frequency');
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control_test` ALTER COLUMN `testing_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly|continuous|ad_hoc');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `regulatory_breach_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Breach Identifier');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `compliance_control_id` SET TAGS ('dbx_business_glossary_term' = 'Failed Compliance Control Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Related Regulatory Obligation ID');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Officer Timekeeper Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Violated Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `actual_remediation_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Remediation Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `affected_client_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Client Count');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `affected_matter_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Matter Count');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `breach_category` SET TAGS ('dbx_business_glossary_term' = 'Breach Category');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `breach_category` SET TAGS ('dbx_value_regex' = 'FINANCIAL|DATA_PRIVACY|CONDUCT|OPERATIONAL|REPORTING|CLIENT_FUNDS');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `breach_description` SET TAGS ('dbx_business_glossary_term' = 'Breach Description');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `breach_description` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `breach_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Breach Reference Number');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `breach_reference_number` SET TAGS ('dbx_value_regex' = '^BRH-[0-9]{8}$');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `breach_status` SET TAGS ('dbx_business_glossary_term' = 'Breach Status');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `breach_status` SET TAGS ('dbx_value_regex' = 'IDENTIFIED|UNDER_INVESTIGATION|REMEDIATION_IN_PROGRESS|REMEDIATED|CLOSED|ESCALATED');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `breach_type` SET TAGS ('dbx_business_glossary_term' = 'Breach Type');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `client_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Client Notification Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `client_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Client Notification Required Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Discovery Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `discovery_method` SET TAGS ('dbx_business_glossary_term' = 'Discovery Method');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `dpo_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Officer (DPO) Notification Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `dpo_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Officer (DPO) Notified Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `escalated_to_executive_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalated to Executive Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `financial_impact_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Currency Code');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `financial_impact_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `impact_assessment` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `notes` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `notified_regulator` SET TAGS ('dbx_business_glossary_term' = 'Notified Regulator');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `occurrence_date` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `professional_indemnity_claim_flag` SET TAGS ('dbx_business_glossary_term' = 'Professional Indemnity Claim Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `professional_indemnity_claim_reference` SET TAGS ('dbx_business_glossary_term' = 'Professional Indemnity Claim Reference');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `professional_indemnity_claim_reference` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `regulator_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Regulator Reference Number');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `regulatory_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `regulatory_notification_deadline` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Deadline');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `regulatory_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `regulatory_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Penalty Amount');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `regulatory_penalty_amount` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `regulatory_penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Penalty Currency Code');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `regulatory_penalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `remediation_owner` SET TAGS ('dbx_business_glossary_term' = 'Remediation Owner');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `remediation_owner_department` SET TAGS ('dbx_business_glossary_term' = 'Remediation Owner Department');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `remediation_plan` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `remediation_plan` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'NOT_STARTED|IN_PROGRESS|ON_HOLD|COMPLETED|OVERDUE');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `root_cause` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `severity_rating` SET TAGS ('dbx_business_glossary_term' = 'Severity Rating');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `severity_rating` SET TAGS ('dbx_value_regex' = 'CRITICAL|HIGH|MEDIUM|LOW');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ALTER COLUMN `target_remediation_date` SET TAGS ('dbx_business_glossary_term' = 'Target Remediation Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `indemnity_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Indemnity Policy ID');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `annual_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Premium Amount');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `annual_premium_amount` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `broker_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Broker Contact Email');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `broker_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `broker_contact_email` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `broker_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Broker Contact Phone');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `broker_contact_phone` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `broker_name` SET TAGS ('dbx_business_glossary_term' = 'Broker Name');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `claims_made_basis_flag` SET TAGS ('dbx_business_glossary_term' = 'Claims Made Basis Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `claims_notification_email` SET TAGS ('dbx_business_glossary_term' = 'Claims Notification Email');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `claims_notification_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `claims_notification_email` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `claims_notification_phone` SET TAGS ('dbx_business_glossary_term' = 'Claims Notification Phone');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `claims_notification_phone` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `compliance_certificate_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certificate Issued Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `coverage_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Period End Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `coverage_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Period Start Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `coverage_territory` SET TAGS ('dbx_business_glossary_term' = 'Coverage Territory');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `excess_amount` SET TAGS ('dbx_business_glossary_term' = 'Excess Amount');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `exclusions_summary` SET TAGS ('dbx_business_glossary_term' = 'Exclusions Summary');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `extended_reporting_period_months` SET TAGS ('dbx_business_glossary_term' = 'Extended Reporting Period Months');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `insurer_name` SET TAGS ('dbx_business_glossary_term' = 'Insurer Name');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `insurer_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Insurer Reference Number');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `limit_of_indemnity_amount` SET TAGS ('dbx_business_glossary_term' = 'Limit of Indemnity Amount');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `limit_per_claim_amount` SET TAGS ('dbx_business_glossary_term' = 'Limit Per Claim Amount');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `next_premium_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Premium Due Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `policy_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Policy Document Reference');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `policy_number` SET TAGS ('dbx_business_glossary_term' = 'Policy Number');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `policy_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_business_glossary_term' = 'Policy Status');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_value_regex' = 'active|expired|cancelled|pending_renewal|lapsed|terminated');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_business_glossary_term' = 'Policy Type');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_value_regex' = 'primary|excess|run_off|top_up|successor_practice');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `practice_areas_covered` SET TAGS ('dbx_business_glossary_term' = 'Practice Areas Covered');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `premium_payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Premium Payment Frequency');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `premium_payment_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `premium_payment_status` SET TAGS ('dbx_business_glossary_term' = 'Premium Payment Status');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `premium_payment_status` SET TAGS ('dbx_value_regex' = 'paid|outstanding|overdue|partial');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `qualifying_insurer_flag` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Insurer Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `regulatory_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `regulatory_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Reference');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `renewal_notice_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Sent Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `responsible_partner_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Partner Name');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ALTER COLUMN `retroactive_date` SET TAGS ('dbx_business_glossary_term' = 'Retroactive Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `indemnity_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Indemnity Claim Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Partner Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `indemnity_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Indemnity Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Notification Document Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Fee Earner Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `alleged_negligence_description` SET TAGS ('dbx_business_glossary_term' = 'Alleged Negligence Description');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `alleged_negligence_description` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `claim_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Closure Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `claim_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Claim Reference Number');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `claim_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `claim_status` SET TAGS ('dbx_business_glossary_term' = 'Claim Status');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `claim_type` SET TAGS ('dbx_business_glossary_term' = 'Claim Type');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `claimant_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Claimant Contact Email Address');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `claimant_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `claimant_contact_email` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `claimant_contact_email` SET TAGS ('dbx_dbx_pii_email' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `claimant_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Claimant Contact Phone Number');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `claimant_contact_phone` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `claimant_contact_phone` SET TAGS ('dbx_dbx_pii_phone' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `claimant_name` SET TAGS ('dbx_business_glossary_term' = 'Claimant Name');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `claimant_name` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `claimant_type` SET TAGS ('dbx_business_glossary_term' = 'Claimant Type');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `claimant_type` SET TAGS ('dbx_value_regex' = 'client|third_party|counterparty|regulatory_body|other');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `claims_handler_name` SET TAGS ('dbx_business_glossary_term' = 'Claims Handler Name');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `closure_reason` SET TAGS ('dbx_business_glossary_term' = 'Closure Reason');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `closure_reason` SET TAGS ('dbx_value_regex' = 'settled|withdrawn|dismissed|no_coverage|other');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `coverage_confirmation_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Confirmation Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `coverage_confirmation_status` SET TAGS ('dbx_business_glossary_term' = 'Coverage Confirmation Status');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `coverage_confirmation_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|denied|partial|under_review');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `defence_costs_amount` SET TAGS ('dbx_business_glossary_term' = 'Defence Costs Amount');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `defence_costs_amount` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `defence_costs_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Defence Costs Currency Code');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `defence_costs_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `estimated_exposure_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Exposure Amount');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `estimated_exposure_amount` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `estimated_exposure_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Estimated Exposure Currency Code');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `estimated_exposure_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `insurer_acknowledgement_date` SET TAGS ('dbx_business_glossary_term' = 'Insurer Acknowledgement Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `insurer_name` SET TAGS ('dbx_business_glossary_term' = 'Insurer Name');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `notes` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `policy_year` SET TAGS ('dbx_business_glossary_term' = 'Policy Year');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Reserve Amount');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `reserve_amount` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `reserve_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Reserve Currency Code');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `reserve_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `reserve_last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Reserve Last Updated Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `settlement_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency Code');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `settlement_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `sra_report_date` SET TAGS ('dbx_business_glossary_term' = 'Solicitors Regulation Authority (SRA) Report Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ALTER COLUMN `sra_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Solicitors Regulation Authority (SRA) Reportable Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `training_programme_id` SET TAGS ('dbx_business_glossary_term' = 'Training Programme Identifier');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Content Owner Timekeeper Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `knowledge_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Asset Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `practice_group_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Group Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Regulatory Obligation Id');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `accreditation_reference` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Reference');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `assessment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Assessment Required Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `certificate_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issued Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `cost_per_participant` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Participant');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `cost_per_participant` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `cpd_credits` SET TAGS ('dbx_business_glossary_term' = 'Continuing Professional Development (CPD) Credits');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `delivery_format` SET TAGS ('dbx_business_glossary_term' = 'Delivery Format');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `delivery_format` SET TAGS ('dbx_value_regex' = 'online|in-person|hybrid|on-demand|scheduled');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'e-learning|instructor-led|blended|webinar|workshop|self-study');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Duration Hours');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `external_url` SET TAGS ('dbx_business_glossary_term' = 'External URL');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Training Frequency');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `frequency` SET TAGS ('dbx_value_regex' = 'annual|biannual|quarterly|one-time|as-needed|triennial');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `internal_system_reference` SET TAGS ('dbx_business_glossary_term' = 'Internal System Reference');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Language');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `language` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `last_content_update_date` SET TAGS ('dbx_business_glossary_term' = 'Last Content Update Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Launch Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `pass_mark_percentage` SET TAGS ('dbx_business_glossary_term' = 'Pass Mark Percentage');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `practice_group_scope` SET TAGS ('dbx_business_glossary_term' = 'Practice Group Scope');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `prerequisite_programmes` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Programmes');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `programme_code` SET TAGS ('dbx_business_glossary_term' = 'Programme Code');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `programme_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `programme_description` SET TAGS ('dbx_business_glossary_term' = 'Programme Description');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `programme_name` SET TAGS ('dbx_business_glossary_term' = 'Programme Name');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `programme_status` SET TAGS ('dbx_business_glossary_term' = 'Programme Status');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `programme_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|under-review|retired|suspended');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `provider_name` SET TAGS ('dbx_business_glossary_term' = 'Provider Name');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `recurrence_interval_months` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Interval Months');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `related_policy_reference` SET TAGS ('dbx_business_glossary_term' = 'Related Policy Reference');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `target_role_category` SET TAGS ('dbx_business_glossary_term' = 'Target Role Category');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `training_category` SET TAGS ('dbx_business_glossary_term' = 'Training Category');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `training_category` SET TAGS ('dbx_value_regex' = 'mandatory|recommended|optional|refresher|induction|specialized');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `version_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Version Effective Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ALTER COLUMN `sanctions_check_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Check Identifier');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ALTER COLUMN `aml_kyc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Kyc Program Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ALTER COLUMN `ownership_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Ownership Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip License Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewing Officer Employee ID');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ALTER COLUMN `disposition_date` SET TAGS ('dbx_business_glossary_term' = 'Disposition Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ALTER COLUMN `disposition_rationale` SET TAGS ('dbx_business_glossary_term' = 'Disposition Rationale');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ALTER COLUMN `escalation_recipient` SET TAGS ('dbx_business_glossary_term' = 'Escalation Recipient');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ALTER COLUMN `escalation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ALTER COLUMN `match_details` SET TAGS ('dbx_business_glossary_term' = 'Match Details');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ALTER COLUMN `match_score` SET TAGS ('dbx_business_glossary_term' = 'Match Score');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ALTER COLUMN `match_type` SET TAGS ('dbx_business_glossary_term' = 'Match Type');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ALTER COLUMN `match_type` SET TAGS ('dbx_value_regex' = 'exact|fuzzy|alias|phonetic|no_match');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ALTER COLUMN `regulatory_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Reference');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ALTER COLUMN `reviewing_officer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewing Officer Name');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ALTER COLUMN `sanctions_list_screened` SET TAGS ('dbx_business_glossary_term' = 'Sanctions List Screened');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ALTER COLUMN `sanctions_list_screened` SET TAGS ('dbx_value_regex' = 'OFAC_SDN|HM_Treasury|EU_Consolidated|UN_Sanctions|Combined_All');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ALTER COLUMN `screening_date` SET TAGS ('dbx_business_glossary_term' = 'Screening Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ALTER COLUMN `screening_disposition` SET TAGS ('dbx_business_glossary_term' = 'Screening Disposition');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ALTER COLUMN `screening_disposition` SET TAGS ('dbx_value_regex' = 'cleared|escalated|blocked|pending_review|false_positive');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ALTER COLUMN `screening_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Screening Reference Number');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ALTER COLUMN `screening_system_name` SET TAGS ('dbx_business_glossary_term' = 'Screening System Name');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ALTER COLUMN `screening_system_version` SET TAGS ('dbx_business_glossary_term' = 'Screening System Version');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ALTER COLUMN `screening_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Screening Timestamp');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ALTER COLUMN `screening_trigger_event` SET TAGS ('dbx_business_glossary_term' = 'Screening Trigger Event');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ALTER COLUMN `screening_trigger_event` SET TAGS ('dbx_value_regex' = 'client_onboarding|matter_opening|periodic_review|transaction_review|manual_request|system_alert');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ALTER COLUMN `subject_country_of_residence` SET TAGS ('dbx_business_glossary_term' = 'Subject Country of Residence');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ALTER COLUMN `subject_country_of_residence` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ALTER COLUMN `subject_date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Subject Date of Birth');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ALTER COLUMN `subject_date_of_birth` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ALTER COLUMN `subject_date_of_birth` SET TAGS ('dbx_dbx_pii_dob' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ALTER COLUMN `subject_name` SET TAGS ('dbx_business_glossary_term' = 'Subject Name');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ALTER COLUMN `subject_name` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ALTER COLUMN `subject_name` SET TAGS ('dbx_dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ALTER COLUMN `subject_national_identifier` SET TAGS ('dbx_business_glossary_term' = 'Subject National Identifier');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ALTER COLUMN `subject_national_identifier` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ALTER COLUMN `subject_national_identifier` SET TAGS ('dbx_dbx_pii_national_id' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ALTER COLUMN `subject_type` SET TAGS ('dbx_business_glossary_term' = 'Subject Type');
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ALTER COLUMN `subject_type` SET TAGS ('dbx_value_regex' = 'individual|organisation|beneficial_owner|counterparty|related_party|trust');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ALTER COLUMN `regulatory_change_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change ID');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Implementation Owner Employee ID');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ALTER COLUMN `control_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Impacted Control Framework Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ALTER COLUMN `primary_regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation ID');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ALTER COLUMN `regulatory_implementation_owner_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Implementation Owner Timekeeper Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ALTER COLUMN `change_description` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change Description');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ALTER COLUMN `change_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Change Reference Number');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ALTER COLUMN `change_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change Status');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ALTER COLUMN `change_status` SET TAGS ('dbx_value_regex' = 'proposed|published|effective|superseded|withdrawn');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ALTER COLUMN `change_title` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change Title');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ALTER COLUMN `change_type` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change Type');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ALTER COLUMN `consultation_response_deadline` SET TAGS ('dbx_business_glossary_term' = 'Consultation Response Deadline');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ALTER COLUMN `consultation_response_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Consultation Response Required Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ALTER COLUMN `dpo_review_date` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Officer (DPO) Review Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ALTER COLUMN `dpo_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Officer (DPO) Review Required Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ALTER COLUMN `governing_body` SET TAGS ('dbx_business_glossary_term' = 'Governing Body');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ALTER COLUMN `impact_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ALTER COLUMN `impact_assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment Status');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ALTER COLUMN `impact_assessment_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|approved');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ALTER COLUMN `impact_severity` SET TAGS ('dbx_business_glossary_term' = 'Impact Severity');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ALTER COLUMN `impact_severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|negligible');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ALTER COLUMN `impacted_business_functions` SET TAGS ('dbx_business_glossary_term' = 'Impacted Business Functions');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ALTER COLUMN `implementation_deadline` SET TAGS ('dbx_business_glossary_term' = 'Implementation Deadline');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ALTER COLUMN `legal_counsel_review_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Counsel Review Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ALTER COLUMN `legal_counsel_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Counsel Review Required Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ALTER COLUMN `policy_update_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Policy Update Required Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ALTER COLUMN `regulatory_obligation_created_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Created Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ALTER COLUMN `related_policy_references` SET TAGS ('dbx_business_glossary_term' = 'Related Policy References');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ALTER COLUMN `required_control_updates` SET TAGS ('dbx_business_glossary_term' = 'Required Control Updates');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ALTER COLUMN `source_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Document Reference');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ALTER COLUMN `source_document_url` SET TAGS ('dbx_business_glossary_term' = 'Source Document Uniform Resource Locator (URL)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ALTER COLUMN `system_changes_description` SET TAGS ('dbx_business_glossary_term' = 'System Changes Description');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ALTER COLUMN `system_changes_required_flag` SET TAGS ('dbx_business_glossary_term' = 'System Changes Required Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ALTER COLUMN `training_completion_deadline` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Deadline');
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ALTER COLUMN `training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ALTER COLUMN `control_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Implementing Control Framework Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Owner Employee ID');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ALTER COLUMN `applicability_scope` SET TAGS ('dbx_business_glossary_term' = 'Applicability Scope');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ALTER COLUMN `breach_reporting_procedure` SET TAGS ('dbx_business_glossary_term' = 'Breach Reporting Procedure');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ALTER COLUMN `document_location` SET TAGS ('dbx_business_glossary_term' = 'Policy Document Location');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ALTER COLUMN `exemption_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Exemption Applicable Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ALTER COLUMN `exemption_details` SET TAGS ('dbx_business_glossary_term' = 'Exemption Details');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ALTER COLUMN `external_audit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'External Audit Required Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ALTER COLUMN `last_external_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last External Audit Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ALTER COLUMN `next_external_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next External Audit Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ALTER COLUMN `objective` SET TAGS ('dbx_business_glossary_term' = 'Policy Objective');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ALTER COLUMN `owner_department` SET TAGS ('dbx_business_glossary_term' = 'Policy Owner Department');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ALTER COLUMN `penalty_for_non_compliance` SET TAGS ('dbx_business_glossary_term' = 'Penalty for Non-Compliance');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_business_glossary_term' = 'Policy Code');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3,6}-[0-9]{3,5}$');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_business_glossary_term' = 'Policy Name');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_business_glossary_term' = 'Policy Status');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|active|superseded|archived');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_business_glossary_term' = 'Policy Type');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_value_regex' = 'AML|Data Protection|Anti-Bribery|Sanctions|Conflicts of Interest|Information Security');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'urgent|high|medium|low');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ALTER COLUMN `regulatory_obligations_satisfied` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligations Satisfied');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ALTER COLUMN `related_policy_references` SET TAGS ('dbx_business_glossary_term' = 'Related Policy References');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ALTER COLUMN `review_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle Months');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ALTER COLUMN `source_legislation_url` SET TAGS ('dbx_business_glossary_term' = 'Source Legislation URL');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ALTER COLUMN `superseded_policy_code` SET TAGS ('dbx_business_glossary_term' = 'Superseded Policy Code');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ALTER COLUMN `training_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Training Frequency Months');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ALTER COLUMN `training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement ID');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Officer Employee ID');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ALTER COLUMN `engagement_owner_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor Employee ID');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ALTER COLUMN `engagement_owner_timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ALTER COLUMN `engagement_owner_timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ALTER COLUMN `control_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Control Framework Id');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ALTER COLUMN `primary_lead_auditor_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor Timekeeper Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_documentation_location` SET TAGS ('dbx_business_glossary_term' = 'Audit Documentation Location');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Period End Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Period Start Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|fieldwork_complete|draft_issued|final_issued|closed');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'internal_compliance_review|external_regulatory_inspection|iso_27001_surveillance|aml_audit|gdpr_audit|sox_compliance_audit');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ALTER COLUMN `auditor_type` SET TAGS ('dbx_business_glossary_term' = 'Auditor Type');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ALTER COLUMN `auditor_type` SET TAGS ('dbx_value_regex' = 'internal|external|regulatory_body');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ALTER COLUMN `critical_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Findings Count');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ALTER COLUMN `draft_report_date` SET TAGS ('dbx_business_glossary_term' = 'Draft Report Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ALTER COLUMN `engagement_name` SET TAGS ('dbx_business_glossary_term' = 'Engagement Name');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ALTER COLUMN `engagement_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Engagement Reference Number');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ALTER COLUMN `external_auditor_name` SET TAGS ('dbx_business_glossary_term' = 'External Auditor Name');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ALTER COLUMN `fieldwork_end_date` SET TAGS ('dbx_business_glossary_term' = 'Fieldwork End Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ALTER COLUMN `fieldwork_start_date` SET TAGS ('dbx_business_glossary_term' = 'Fieldwork Start Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ALTER COLUMN `final_report_date` SET TAGS ('dbx_business_glossary_term' = 'Final Report Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ALTER COLUMN `findings_closed_count` SET TAGS ('dbx_business_glossary_term' = 'Findings Closed Count');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ALTER COLUMN `findings_open_count` SET TAGS ('dbx_business_glossary_term' = 'Findings Open Count');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ALTER COLUMN `findings_overdue_count` SET TAGS ('dbx_business_glossary_term' = 'Findings Overdue Count');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ALTER COLUMN `follow_up_audit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Audit Required Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ALTER COLUMN `follow_up_audit_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Audit Scheduled Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ALTER COLUMN `high_findings_count` SET TAGS ('dbx_business_glossary_term' = 'High Findings Count');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ALTER COLUMN `low_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Low Findings Count');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ALTER COLUMN `management_response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Management Response Due Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ALTER COLUMN `management_response_received_date` SET TAGS ('dbx_business_glossary_term' = 'Management Response Received Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ALTER COLUMN `medium_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Medium Findings Count');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ALTER COLUMN `overall_audit_opinion` SET TAGS ('dbx_business_glossary_term' = 'Overall Audit Opinion');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ALTER COLUMN `overall_audit_opinion` SET TAGS ('dbx_value_regex' = 'satisfactory|satisfactory_with_observations|needs_improvement|unsatisfactory|adverse');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ALTER COLUMN `regulatory_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Reference');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ALTER COLUMN `regulatory_report_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Submission Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ALTER COLUMN `responsible_officer_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Officer Name');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ALTER COLUMN `total_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Total Findings Count');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Identifier');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Action Owner Timekeeper Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `audit_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement Identifier');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `auditor_employee_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Auditor Employee Identifier');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `auditor_employee_timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `auditor_employee_timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `compliance_control_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Control Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_owner_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Action Owner Employee Identifier');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_owner_timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_owner_timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `ip_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Asset Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Finding Document Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Violated Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `actual_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Closure Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `agreed_action` SET TAGS ('dbx_business_glossary_term' = 'Agreed Management Action');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Name');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `control_reference` SET TAGS ('dbx_business_glossary_term' = 'Control Reference');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `escalation_recipient` SET TAGS ('dbx_business_glossary_term' = 'Escalation Recipient');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `escalation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `evidence_reference` SET TAGS ('dbx_business_glossary_term' = 'Evidence Reference');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_category` SET TAGS ('dbx_business_glossary_term' = 'Finding Category');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_category` SET TAGS ('dbx_value_regex' = 'control_gap|policy_breach|regulatory_non_compliance|process_deficiency|documentation_gap|system_weakness');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_description` SET TAGS ('dbx_business_glossary_term' = 'Finding Description');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_raised_date` SET TAGS ('dbx_business_glossary_term' = 'Finding Raised Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Finding Reference Number');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_status` SET TAGS ('dbx_business_glossary_term' = 'Finding Status');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|pending_verification|closed|overdue');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_title` SET TAGS ('dbx_business_glossary_term' = 'Finding Title');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_business_glossary_term' = 'Finding Type');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_value_regex' = 'observation|recommendation|non_conformance|opportunity_for_improvement');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `management_response` SET TAGS ('dbx_business_glossary_term' = 'Management Response');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `recommended_action` SET TAGS ('dbx_business_glossary_term' = 'Recommended Action');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `regulatory_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Reference');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `related_policy_reference` SET TAGS ('dbx_business_glossary_term' = 'Related Policy Reference');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'very_high|high|medium|low|very_low');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Finding Severity');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `target_remediation_date` SET TAGS ('dbx_business_glossary_term' = 'Target Remediation Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `verification_notes` SET TAGS ('dbx_business_glossary_term' = 'Verification Notes');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'not_started|scheduled|in_progress|verified|failed_verification');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_scope` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_scope` ALTER COLUMN `audit_scope_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope Identifier');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_scope` ALTER COLUMN `audit_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope - Audit Engagement Id');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_scope` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope - Regulatory Obligation Id');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_scope` ALTER COLUMN `audit_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Period End Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_scope` ALTER COLUMN `audit_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Period Start Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_scope` ALTER COLUMN `auditor_notes` SET TAGS ('dbx_business_glossary_term' = 'Auditor Notes');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_scope` ALTER COLUMN `exceptions_identified` SET TAGS ('dbx_business_glossary_term' = 'Exceptions Identified');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_scope` ALTER COLUMN `obligation_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Obligation Compliance Status');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_scope` ALTER COLUMN `obligation_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Obligation Findings Count');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_scope` ALTER COLUMN `obligation_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Obligation Risk Rating');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_scope` ALTER COLUMN `obligation_test_results_summary` SET TAGS ('dbx_business_glossary_term' = 'Obligation Test Results Summary');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_scope` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_scope` ALTER COLUMN `scope_inclusion_date` SET TAGS ('dbx_business_glossary_term' = 'Scope Inclusion Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_scope` ALTER COLUMN `scope_status` SET TAGS ('dbx_business_glossary_term' = 'Scope Status');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_scope` ALTER COLUMN `testing_approach` SET TAGS ('dbx_business_glossary_term' = 'Testing Approach');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy_acknowledgement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy_acknowledgement` ALTER COLUMN `policy_acknowledgement_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Acknowledgement Identifier');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy_acknowledgement` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Acknowledgement - Compliance Policy Id');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy_acknowledgement` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Acknowledgement - Client Profile Id');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy_acknowledgement` ALTER COLUMN `acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Status');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy_acknowledgement` ALTER COLUMN `acknowledged_by_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Acknowledged By Contact Email');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy_acknowledgement` ALTER COLUMN `acknowledged_by_contact_email` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy_acknowledgement` ALTER COLUMN `acknowledged_by_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Acknowledged By Contact Name');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy_acknowledgement` ALTER COLUMN `acknowledged_by_contact_name` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy_acknowledgement` ALTER COLUMN `acknowledged_by_contact_name` SET TAGS ('dbx_dbx_pii_identifier' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy_acknowledgement` ALTER COLUMN `acknowledgement_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy_acknowledgement` ALTER COLUMN `acknowledgement_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Document Reference');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy_acknowledgement` ALTER COLUMN `attestation_method` SET TAGS ('dbx_business_glossary_term' = 'Attestation Method');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy_acknowledgement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy_acknowledgement` ALTER COLUMN `next_acknowledgement_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Acknowledgement Due Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy_acknowledgement` ALTER COLUMN `reminder_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Reminder Sent Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy_acknowledgement` ALTER COLUMN `required_for_engagement_flag` SET TAGS ('dbx_business_glossary_term' = 'Required for Engagement Flag');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy_acknowledgement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy_acknowledgement` ALTER COLUMN `version_acknowledged` SET TAGS ('dbx_business_glossary_term' = 'Policy Version Acknowledged');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ALTER COLUMN `audit_program_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Program Identifier');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Id');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ALTER COLUMN `parent_audit_program_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Audit Program Id');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ALTER COLUMN `parent_audit_program_id` SET TAGS ('dbx_dbx_self_ref_fk' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ALTER COLUMN `primary_lead_auditor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor Employee Id');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ALTER COLUMN `primary_lead_auditor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ALTER COLUMN `primary_lead_auditor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ALTER COLUMN `program_owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ALTER COLUMN `program_owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ALTER COLUMN `program_owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ALTER COLUMN `control_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Target Control Framework Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ALTER COLUMN `audit_criteria` SET TAGS ('dbx_business_glossary_term' = 'Audit Criteria');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ALTER COLUMN `budget_amount` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ALTER COLUMN `estimated_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration Days');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Frequency');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ALTER COLUMN `last_execution_date` SET TAGS ('dbx_business_glossary_term' = 'Last Execution Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ALTER COLUMN `methodology` SET TAGS ('dbx_business_glossary_term' = 'Methodology');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ALTER COLUMN `next_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Date');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ALTER COLUMN `objective` SET TAGS ('dbx_business_glossary_term' = 'Objective');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ALTER COLUMN `requires_external_auditor` SET TAGS ('dbx_business_glossary_term' = 'Requires External Auditor');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period Years');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
