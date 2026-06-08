-- Schema for Domain: risk | Business: Legal | Version: v1_mvm
-- Generated on: 2026-05-07 14:36:20

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `legal_ecm`.`risk` COMMENT 'Owns enterprise and matter-level risk identification, assessment, and mitigation records for the firm. Covers professional indemnity exposure, data breach incident management (PII/GDPR), cybersecurity risk (ISO 27001), sanctions screening, and reputational risk flags. Provides the risk register that feeds compliance, conflict, and workforce domains without duplicating their operational data.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `legal_ecm`.`risk`.`register` (
    `register_id` BIGINT COMMENT 'Unique surrogate identifier for each discrete risk record in the enterprise-wide risk register. Primary key for the risk_register data product.',
    `category_id` BIGINT COMMENT 'Foreign key linking to risk.risk_category. Business justification: risk_register has risk_category (STRING) attribute that should normalize to risk_category reference table for consistency with risk_assessment and to ensure taxonomy integrity.',
    `profile_id` BIGINT COMMENT 'Reference to the client associated with this risk record, applicable when the risk is client-specific (e.g., sanctions exposure, reputational risk tied to a specific client relationship).',
    `actual_closure_date` DATE COMMENT 'The date on which the risk was formally closed, either because it was fully mitigated, accepted, or the risk event is no longer applicable. Null for open risks.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp recording when this risk register record was first created in the data platform. Used for audit trail and data lineage purposes.',
    `escalation_date` DATE COMMENT 'Date on which the risk was most recently escalated to a higher governance level. Null if the risk has never been escalated beyond the risk owner.',
    `escalation_level` STRING COMMENT 'Current escalation tier for this risk item, indicating the highest governance level to which the risk has been formally escalated. None indicates no escalation beyond the risk owner.. Valid values are `none|risk_owner|practice_group_head|risk_committee|managing_partner|regulator`',
    `estimated_financial_exposure` DECIMAL(18,2) COMMENT 'Estimated monetary value of the firms financial exposure if this risk materialises, expressed in the firms base currency. Includes potential professional indemnity claims, regulatory fines, and remediation costs. Classified confidential.',
    `exception_approved_by` STRING COMMENT 'Name and role of the senior authority (e.g., Managing Partner, General Counsel, Risk Committee Chair) who formally approved the policy exception for this risk. Populated only when is_exception_approved is True.',
    `exception_expiry_date` DATE COMMENT 'The date on which the approved policy exception expires and must be re-evaluated or revoked. Null if no exception is in force. Drives exception renewal alerts.',
    `identified_date` DATE COMMENT 'The calendar date on which this risk was first identified and logged in the risk register. Serves as the principal business event date for the risk lifecycle and is used in ageing analysis.',
    `inherent_impact` STRING COMMENT 'Impact rating of the risk materialising before any controls are applied, scored on a 1–5 scale (1=Negligible, 2=Minor, 3=Moderate, 4=Major, 5=Catastrophic). Combined with inherent_likelihood to produce the inherent risk rating.',
    `inherent_likelihood` STRING COMMENT 'Likelihood rating of the risk occurring before any controls are applied, scored on a 1–5 scale (1=Rare, 2=Unlikely, 3=Possible, 4=Likely, 5=Almost Certain) per the firms risk appetite matrix. Used to compute the inherent risk rating.',
    `inherent_risk_rating` STRING COMMENT 'Pre-control risk score calculated as inherent_likelihood × inherent_impact (range 1–25). Represents the gross risk exposure before mitigation. Used to prioritise risk treatment and populate the firms risk heat map.',
    `insurance_claim_ref` STRING COMMENT 'Reference number of the professional indemnity insurance claim raised with the firms insurer in relation to this risk event. Populated when a claim has been formally notified to the insurer. Classified confidential.',
    `is_exception_approved` BOOLEAN COMMENT 'Indicates whether a formal policy exception has been approved for this risk, permitting a deviation from the firms standard risk management policy. True when an approved exception is in force.',
    `last_reviewed_date` DATE COMMENT 'Date on which this risk record was most recently formally reviewed and assessed by the risk owner or Risk Committee. Used to calculate review cycle compliance and risk register staleness.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'System timestamp recording when this risk register record was most recently modified. Used to track the currency of risk assessments and trigger review cycle alerts.',
    `lpp_applies` BOOLEAN COMMENT 'Indicates whether Legal Professional Privilege (LPP) applies to the risk record or associated documentation, restricting disclosure in regulatory investigations or litigation. Governs access controls and eDiscovery handling.',
    `mitigation_description` STRING COMMENT 'Narrative description of the specific controls, actions, and measures implemented or planned to mitigate this risk. Includes procedural, technical, and contractual controls. Classified confidential as it may reveal security posture.',
    `mitigation_status` STRING COMMENT 'Current implementation status of the risk mitigation actions. Tracks whether controls have been designed, are being implemented, are fully operational, are overdue, or have been formally deferred.. Valid values are `not_started|in_progress|implemented|overdue|deferred`',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal review of this risk record by the risk owner or Risk Committee. Drives the review cycle scheduling process and generates overdue alerts when breached.',
    `pii_involved` BOOLEAN COMMENT 'Indicates whether Personally Identifiable Information (PII) is involved in this risk event (e.g., a data breach affecting client or employee personal data). True triggers GDPR/CCPA data breach assessment workflows.',
    `regulatory_body` STRING COMMENT 'Name of the regulatory authority to which this risk or incident must be reported (e.g., SRA, ICO, FCA, ABA, Law Society). Populated when regulatory_reporting_required is True. Free-text to accommodate multi-jurisdictional reporting.',
    `regulatory_notification_date` DATE COMMENT 'Date on which the firm formally notified the relevant regulatory body of this risk event or data breach. Null if notification has not yet been made. Critical for GDPR 72-hour breach notification compliance tracking.',
    `regulatory_reporting_required` BOOLEAN COMMENT 'Indicates whether this risk event or incident requires mandatory notification to a regulatory body (e.g., SRA, ICO under GDPR Article 33, FCA). True triggers the regulatory reporting workflow.',
    `residual_impact` STRING COMMENT 'Impact rating of the risk materialising after all current controls and mitigations have been applied, scored on a 1–5 scale. Combined with residual_likelihood to produce the residual risk rating.',
    `residual_likelihood` STRING COMMENT 'Likelihood rating of the risk occurring after all current controls and mitigations have been applied, scored on a 1–5 scale. Reflects the effectiveness of implemented controls.',
    `residual_risk_rating` STRING COMMENT 'Post-control risk score calculated as residual_likelihood × residual_impact (range 1–25). Represents the net risk exposure after mitigation. Primary metric for Risk Committee reporting and SRA regulatory submissions.',
    `risk_description` STRING COMMENT 'Detailed narrative describing the risk event, its potential causes, and the circumstances under which it could materialise. May contain sensitive matter or client information and is classified confidential.',
    `risk_domain` STRING COMMENT 'Indicates whether the risk is enterprise-wide or scoped to a specific domain such as a matter, client relationship, workforce, technology infrastructure, or third-party supplier.. Valid values are `enterprise|matter|client|workforce|technology|third_party`',
    `risk_ref_code` STRING COMMENT 'Human-readable, externally referenceable unique code assigned to each risk item (e.g., RSK-2024-00123). Used in Risk Committee reports, SRA submissions, and cross-domain communications.. Valid values are `^RSK-[0-9]{4}-[0-9]{5}$`',
    `risk_status` STRING COMMENT 'Current lifecycle state of the risk record. Open: identified and active. Under_review: being assessed. Mitigated: controls applied. Accepted: formally accepted with approval. Escalated: referred to Risk Committee or senior management. Closed: risk no longer active.. Valid values are `open|under_review|mitigated|accepted|escalated|closed`',
    `risk_subcategory` STRING COMMENT 'Secondary classification providing granular segmentation within the primary risk category (e.g., Phishing Attack under cybersecurity, Missed Limitation Deadline under professional_indemnity, GDPR Data Subject Request Failure under data_breach). Free-text to accommodate evolving risk taxonomy.',
    `risk_title` STRING COMMENT 'Short, descriptive title summarising the nature of the risk (e.g., Unauthorised disclosure of client PII via email). Used as the primary label in risk dashboards and committee reports.',
    `risk_treatment` STRING COMMENT 'The chosen treatment approach for this risk: mitigate (apply controls to reduce likelihood/impact), accept (formally acknowledge within appetite), transfer (insurance or contractual transfer), avoid (cease the activity), escalate (refer to senior governance body).. Valid values are `mitigate|accept|transfer|avoid|escalate`',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this risk was originated or first detected (e.g., Intapp Conflicts for conflict/sanctions flags, Elite 3E for billing anomalies, iManage for document-related breaches, Relativity for eDiscovery incidents, or manual entry). [ENUM-REF-CANDIDATE: intapp_conflicts|elite_3e|imanage|relativity|manual|ms_dynamics|netsuite — 7 candidates stripped; promote to reference product]',
    `target_closure_date` DATE COMMENT 'The planned date by which the risk is expected to be fully mitigated or closed. Used for tracking mitigation progress and reporting overdue items to the Risk Committee.',
    CONSTRAINT pk_register PRIMARY KEY(`register_id`)
) COMMENT 'Enterprise-wide and matter-level risk register serving as the authoritative single source of truth for all identified risks across professional indemnity, data breach, cybersecurity, sanctions, reputational, and operational categories. Each record represents a discrete risk item with classification, inherent and residual risk ratings (likelihood × impact matrix), current mitigation status, risk owner, escalation history, exception status (approved deviations from policy with approval metadata), and review cycle scheduling. Supports Risk Committee reporting, SRA regulatory submissions, ISO 31000 alignment, and feeds compliance, conflict, and workforce domains.';

CREATE OR REPLACE TABLE `legal_ecm`.`risk`.`category` (
    `category_id` BIGINT COMMENT 'Unique surrogate identifier for each risk category record in the enterprise risk taxonomy. Primary key. [_canonical_skip_reason: Entity role is REFERENCE_LOOKUP — a standardised code-list of risk classification types used across the risk register and incident management processes; per-role minimum categories are exempt.]',
    `parent_category_id` BIGINT COMMENT 'Self-referencing identifier pointing to the parent risk category, enabling a hierarchical taxonomy (e.g., Data Privacy – PII/GDPR as a child of Regulatory Risk). Null for top-level categories.',
    `aml_relevance_flag` BOOLEAN COMMENT 'Indicates whether this risk category is associated with Anti-Money Laundering (AML) or sanctions screening obligations. When true, matters and clients under this category require enhanced Know Your Client (KYC) due diligence and Suspicious Activity Report (SAR) monitoring.',
    `applicable_jurisdiction` STRING COMMENT 'ISO 3166-1 alpha-2 or alpha-3 country code indicating the primary jurisdiction in which this risk category applies. Use GLB for globally applicable categories. Supports multi-jurisdictional risk management across the firms international offices.. Valid values are `^[A-Z]{2,3}$`',
    `category_code` STRING COMMENT 'Firm-assigned alphanumeric code uniquely identifying the risk category within the enterprise risk taxonomy (e.g., PI-001 for Professional Indemnity, DP-001 for Data Privacy). Used as the stable business key across risk register, incident management, and compliance reporting systems.. Valid values are `^[A-Z]{2,10}-[0-9]{3}$`',
    `category_description` STRING COMMENT 'Detailed narrative description of the risk category, including the nature of the risk, typical triggers, and the business functions or matters most exposed. Supports risk awareness training and knowledge management.',
    `category_name` STRING COMMENT 'Human-readable name of the risk category as used in firm-wide risk registers, compliance dashboards, and management reporting (e.g., Professional Indemnity, Data Privacy – PII/GDPR, Cybersecurity – ISO 27001, Sanctions and AML, Reputational Risk, Operational Risk, Regulatory Compliance Risk).',
    `category_status` STRING COMMENT 'Current lifecycle status of this risk category within the firms taxonomy. Active categories are available for use in risk register entries; deprecated categories are retained for historical reporting only; under_review categories are pending approval for modification.. Valid values are `active|inactive|deprecated|under_review`',
    `control_framework_reference` STRING COMMENT 'Reference to the specific control framework, standard, or policy document that governs the mitigating controls applicable to this risk category (e.g., ISO 27001 Annex A, GDPR Article 32 Technical Measures, SRA AML Policy, FATF Recommendation 10). Enables traceability from risk category to control library.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time at which this risk category record was first created in the enterprise risk taxonomy. Provides the audit trail entry point for taxonomy governance and change management.',
    `cybersecurity_relevance_flag` BOOLEAN COMMENT 'Indicates whether this risk category falls within the scope of the firms ISO 27001 Information Security Management System (ISMS). When true, associated risks are subject to ISO 27001 Annex A control requirements and must be included in the Statement of Applicability.',
    `effective_from_date` DATE COMMENT 'Date from which this risk category became or becomes effective within the firms risk taxonomy. Supports temporal validity tracking and ensures risk register entries are only associated with categories that were active at the time of the risk event.',
    `effective_to_date` DATE COMMENT 'Date on which this risk category ceases to be effective within the firms risk taxonomy. Null for currently active categories. Enables point-in-time risk reporting and historical taxonomy reconstruction.',
    `escalation_level` STRING COMMENT 'Minimum organisational level to which risk incidents under this category must be escalated when the residual risk score exceeds the appetite threshold. Drives automated escalation routing in the risk management workflow.. Valid values are `practice_group|risk_committee|managing_partner|board`',
    `external_reference_code` STRING COMMENT 'External standard or regulatory reference code that maps this risk category to an industry-standard taxonomy (e.g., ISO 31000 risk category code, COSO ERM category, SRA Risk Outlook category code). Supports benchmarking and regulatory reporting alignment.',
    `governing_body` STRING COMMENT 'Name of the primary regulatory or professional body whose rules or standards give rise to this risk category (e.g., Solicitors Regulation Authority, American Bar Association, Financial Action Task Force, Information Commissioners Office). Supports jurisdiction-specific risk reporting.',
    `hierarchy_level` STRING COMMENT 'Numeric depth of this category within the risk taxonomy hierarchy. Level 1 represents top-level domains; higher values represent increasingly granular sub-categories. Supports hierarchical roll-up in risk dashboards and regulatory reports.',
    `hierarchy_path` STRING COMMENT 'Delimited string representing the full ancestry path of the risk category within the taxonomy (e.g., Regulatory Risk > Data Privacy > PII/GDPR). Facilitates breadcrumb navigation and hierarchical filtering in risk reporting tools.',
    `inherent_risk_score` DECIMAL(18,2) COMMENT 'Numeric composite score representing the firms inherent (pre-control) exposure for this risk category, calculated as the product of likelihood and impact ratings on the firms standard risk matrix. Provides a baseline for risk prioritisation before mitigating controls are applied.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time at which this risk category record was most recently updated. Supports change tracking, data lineage, and audit trail requirements for the Silver Layer lakehouse.',
    `last_reviewed_by` STRING COMMENT 'Name or identifier of the risk owner, partner, or committee member who last formally reviewed and approved this risk category. Supports accountability and audit trail requirements under the firms risk governance framework.',
    `last_reviewed_date` DATE COMMENT 'Date on which this risk category definition was most recently formally reviewed and approved by the Risk Committee or designated risk owner. Provides an audit trail for taxonomy governance.',
    `lpp_relevance_flag` BOOLEAN COMMENT 'Indicates whether this risk category involves matters that may engage Legal Professional Privilege (LPP), requiring special handling protocols to preserve privilege and avoid inadvertent waiver. Relevant for litigation, regulatory investigation, and eDiscovery risk categories.',
    `matter_type_applicability` STRING COMMENT 'Comma-separated list or description of the matter types or practice areas to which this risk category is most applicable (e.g., Litigation, Arbitration, M&A, Corporate Transactions, IP Portfolio Management, All Matters). Guides risk assessment scoping during matter intake.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal review of this risk category definition, appetite thresholds, and associated controls. Ensures the taxonomy remains current with evolving regulatory requirements and firm risk profile.',
    `notification_deadline_days` STRING COMMENT 'Maximum number of calendar days within which a risk incident under this category must be reported to the relevant regulatory authority (e.g., 72 hours / 3 days for GDPR personal data breaches under Article 33). Null if no mandatory external notification applies.',
    `owner_role` STRING COMMENT 'Job title or role designation of the individual or function responsible for owning and managing risks under this category at the firm level (e.g., Chief Risk Officer, Data Protection Officer, General Counsel, Head of Compliance). Distinct from matter-level risk owners.',
    `pii_relevance_flag` BOOLEAN COMMENT 'Indicates whether this risk category is directly associated with the handling, processing, or breach of Personally Identifiable Information (PII). When true, risk register entries under this category are subject to GDPR Article 33/34 breach notification obligations and DPA compliance controls.',
    `professional_indemnity_flag` BOOLEAN COMMENT 'Indicates whether this risk category is relevant to the firms professional indemnity insurance exposure. When true, incidents under this category must be reported to the firms PI insurer and tracked in the claims management process.',
    `regulatory_framework` STRING COMMENT 'Primary regulatory or legal framework associated with this risk category (e.g., GDPR, ISO 27001, FATF AML, SOX, SRA Code of Conduct, ABA Model Rules, PCI DSS, CCPA). Used to link risk categories to applicable compliance obligations and regulatory reporting requirements.',
    `regulatory_reporting_required` BOOLEAN COMMENT 'Indicates whether incidents or risk register entries under this category must be reported to an external regulatory or supervisory body (e.g., ICO for GDPR breaches, SRA for serious misconduct, OFAC for sanctions violations). Triggers mandatory notification workflows.',
    `residual_risk_score` DECIMAL(18,2) COMMENT 'Numeric composite score representing the firms residual (post-control) exposure for this risk category after mitigating controls have been applied. Used to assess whether the risk falls within the firms risk appetite threshold.',
    `review_frequency` STRING COMMENT 'Mandated frequency at which risk register entries under this category must be formally reviewed and updated by the responsible risk owner. Supports the firms periodic risk assessment cycle and regulatory compliance obligations.. Valid values are `monthly|quarterly|semi_annual|annual`',
    `risk_appetite_level` STRING COMMENT 'Qualitative risk appetite classification for this category as declared in the firms risk appetite framework. Zero tolerance applies to categories such as sanctions breaches and money laundering; low to professional indemnity and data privacy; moderate to operational risk.. Valid values are `zero_tolerance|low|moderate|open`',
    `risk_appetite_threshold` DECIMAL(18,2) COMMENT 'Maximum acceptable residual risk score for this category as defined in the firms risk appetite statement. Residual scores exceeding this threshold trigger escalation to the Risk Committee or Managing Partner. Aligns with SRA and ABA professional conduct obligations.',
    `risk_domain` STRING COMMENT 'High-level domain grouping to which this risk category belongs, enabling portfolio-level risk aggregation and reporting. Maps to the firms enterprise risk framework domains. [ENUM-REF-CANDIDATE: professional|data_privacy|cybersecurity|sanctions_aml|reputational|operational|regulatory|financial|strategic — promote to reference product]',
    `risk_impact_rating` STRING COMMENT 'Standard impact rating assigned to this risk category, reflecting the potential severity of harm to the firm, its clients, or third parties if the risk materialises. Covers financial, reputational, regulatory, and operational impact dimensions.. Valid values are `very_low|low|medium|high|very_high`',
    `risk_likelihood_rating` STRING COMMENT 'Standard likelihood rating assigned to this risk category within the firms risk appetite framework, indicating the probability of occurrence. Used as the default likelihood baseline when creating new risk register entries under this category.. Valid values are `very_low|low|medium|high|very_high`',
    `risk_type` STRING COMMENT 'Classification of the risk category by its nature within the risk management lifecycle: inherent (pre-control), residual (post-control), emerging (newly identified), or systemic (firm-wide structural exposure). Drives how risk assessments are scoped and reported.. Valid values are `inherent|residual|emerging|systemic`',
    `sort_order` STRING COMMENT 'Integer value controlling the display sequence of this risk category in risk registers, dashboards, and dropdown selection lists. Lower values appear first. Enables consistent presentation across risk management tools and reports.',
    `utbms_task_code` STRING COMMENT 'UTBMS task code associated with the legal work type most commonly linked to this risk category (e.g., L430 for Written Discovery in litigation risk, C300 for Due Diligence in transactional risk). Enables cross-referencing between risk categories and billing/matter management data in Elite 3E.. Valid values are `^[A-Z][0-9]{3}$`',
    CONSTRAINT pk_category PRIMARY KEY(`category_id`)
) COMMENT 'Reference taxonomy of risk categories applicable to a legal services firm, including professional indemnity, data privacy (PII/GDPR), cybersecurity (ISO 27001), sanctions and AML, reputational, operational, and regulatory risk types. Provides standardized classification codes used across the risk register and incident management processes.';

CREATE OR REPLACE TABLE `legal_ecm`.`risk`.`assessment` (
    `assessment_id` BIGINT COMMENT 'Unique surrogate identifier for each formal risk assessment record within the enterprise risk register. Primary key for the risk_assessment data product.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to ip.ip_asset. Business justification: Formal IP risk assessments (FTO assessments, invalidity risk assessments, FRAND compliance assessments) are conducted at the individual IP asset level. risk.assessment has register_id and matter_id bu',
    `beneficial_owner_id` BIGINT COMMENT 'Foreign key linking to client.beneficial_owner. Business justification: UBO due diligence assessment: risk assessments are conducted specifically on beneficial owners as part of the AML/KYC programme. Linking the assessment to the assessed beneficial owner is required for',
    `category_id` BIGINT COMMENT 'Foreign key linking to risk.risk_category. Business justification: risk_assessment has risk_category (STRING) attribute that should normalize to the risk_category reference table. This is the authoritative taxonomy for risk categories. Standard reference FK pattern.',
    `hearing_id` BIGINT COMMENT 'Foreign key linking to matter.hearing. Business justification: Pre-hearing and post-hearing risk assessments are a standard litigation risk management process. Legal risk managers formally reassess litigation exposure at key hearing milestones (e.g., pre-trial, s',
    `kyc_record_id` BIGINT COMMENT 'Foreign key linking to client.kyc_record. Business justification: Enhanced Due Diligence (EDD) process: risk assessments are formally conducted against KYC records during periodic KYC reviews. Linking the assessment to the specific KYC record it evaluated is require',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter associated with this risk assessment, where the assessment is matter-specific (e.g., litigation exposure, transaction risk). Null for firm-level enterprise risk assessments.',
    `profile_id` BIGINT COMMENT 'Reference to the client whose engagement or matter is the subject of this risk assessment. Supports client-level risk aggregation and Know Your Client (KYC) / Anti-Money Laundering (AML) compliance reporting.',
    `register_id` BIGINT COMMENT 'Reference to the parent risk item in the enterprise risk register that this assessment evaluates. Links the point-in-time assessment to the persistent risk record.',
    `risk_control_id` BIGINT COMMENT 'Foreign key linking to risk.risk_control. Business justification: Risk assessments evaluate the effectiveness of specific controls. Business semantics: this assessment evaluated this control. Valid relationship for control effectiveness tracking.',
    `account_id` BIGINT COMMENT 'Foreign key linking to trust.account. Business justification: AML and IOLTA compliance risk assessments are performed on specific trust accounts. Role-prefix trust_account used because assessment already has profile_id and matter_id FKs; this identifies the sp',
    `assessment_date` DATE COMMENT 'The calendar date on which the formal risk assessment was conducted. Represents the principal business event date for this assessment cycle, distinct from record creation timestamp.',
    `assessment_status` STRING COMMENT 'Current lifecycle state of the risk assessment record. Draft indicates work in progress; in_review indicates pending senior sign-off; approved indicates formally accepted; superseded indicates replaced by a newer assessment; closed indicates the risk has been retired.. Valid values are `draft|in_review|approved|superseded|closed`',
    `control_effectiveness_rating` STRING COMMENT 'Assessment of how well the existing controls mitigate the identified risk. Drives the reduction from inherent to residual risk score. Evaluated against the firms control framework aligned with ISO 27001 Annex A controls.. Valid values are `ineffective|partially_effective|effective|highly_effective`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this risk assessment record was first created in the system. Supports audit trail and data lineage requirements under ISO 27001 and GDPR.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the estimated financial exposure amount (e.g., GBP, USD, EUR). Supports multi-currency risk reporting for international matters.. Valid values are `^[A-Z]{3}$`',
    `escalation_level` STRING COMMENT 'The organisational level to which this risk has been escalated based on its residual risk score relative to appetite. None indicates no escalation required; practice_group to practice group risk lead; risk_committee to the firms Risk and Compliance Committee; board to the Managing Partner or Board.. Valid values are `none|practice_group|risk_committee|board`',
    `estimated_financial_exposure` DECIMAL(18,2) COMMENT 'Estimated maximum financial exposure or loss amount associated with this risk, expressed in the firms base currency. Used for professional indemnity reserve calculations and risk-weighted financial reporting. Classified confidential as it contains sensitive financial strategy data.',
    `inherent_impact_rating` STRING COMMENT 'Qualitative rating of the severity of consequence if the risk event occurs before any controls are applied. Considers financial, reputational, regulatory, and operational dimensions of impact.. Valid values are `very_low|low|medium|high|very_high`',
    `inherent_likelihood_rating` STRING COMMENT 'Qualitative rating of the probability that the risk event will occur before any controls are applied. Represents the raw, unmitigated likelihood on a five-point scale aligned with the firms risk appetite framework.. Valid values are `very_low|low|medium|high|very_high`',
    `inherent_risk_score` DECIMAL(18,2) COMMENT 'Numerical composite score representing the unmitigated risk level, typically derived as the product of inherent likelihood and inherent impact ratings mapped to a numeric scale. Used for risk prioritisation before control assessment.',
    `is_dpia_required` BOOLEAN COMMENT 'Indicates whether a Data Protection Impact Assessment (DPIA) is required for this risk item under GDPR Article 35. True when the risk involves high-risk processing of personal data, triggering mandatory DPIA before processing commences.',
    `is_lpp_sensitive` BOOLEAN COMMENT 'Indicates whether this risk assessment record or its associated matter is subject to Legal Professional Privilege (LPP). When True, access is restricted to authorised legal personnel and the record is excluded from certain regulatory disclosures.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this risk assessment record was most recently modified. Used for change tracking, optimistic concurrency control, and audit compliance.',
    `methodology` STRING COMMENT 'Methodology used to evaluate the risk. Qualitative uses descriptive scales; quantitative uses numerical probability and financial impact modelling; semi_quantitative combines both approaches. Determines how inherent and residual scores are interpreted.. Valid values are `qualitative|quantitative|semi_quantitative`',
    `next_review_date` DATE COMMENT 'Scheduled date by which this risk assessment must be reviewed and refreshed. Drives the periodic risk review cycle mandated by ISO 27001 and SRA requirements. Alerts are triggered when this date approaches.',
    `notes` STRING COMMENT 'Free-text field for the assessor to record additional context, caveats, assumptions, or observations that do not fit structured fields. Classified confidential as notes may contain sensitive matter or client strategy information.',
    `pii_data_involved` BOOLEAN COMMENT 'Indicates whether the risk scenario involves Personally Identifiable Information (PII) or personal data as defined under GDPR. True triggers additional data protection controls and potential DPIA requirement.',
    `reference` STRING COMMENT 'Externally-known business identifier for the risk assessment, formatted as RA-{YYYY}-{NNNNNN}. Used in correspondence, audit trails, and regulatory submissions to uniquely reference a specific assessment cycle.. Valid values are `^RA-[0-9]{4}-[0-9]{6}$`',
    `regulatory_framework` STRING COMMENT 'The primary regulatory or compliance framework under which this risk assessment is conducted (e.g., ISO 27001, GDPR, SRA, FATF, SOX, PCI DSS, CCPA). Supports regulatory reporting segmentation and framework-specific risk aggregation.',
    `residual_impact_rating` STRING COMMENT 'Qualitative rating of the severity of consequence after existing controls have been applied. Used alongside residual likelihood to compute the residual risk score.. Valid values are `very_low|low|medium|high|very_high`',
    `residual_likelihood_rating` STRING COMMENT 'Qualitative rating of the probability that the risk event will occur after existing controls have been applied. Reflects the post-control likelihood used to determine whether residual risk is within appetite.. Valid values are `very_low|low|medium|high|very_high`',
    `residual_risk_score` DECIMAL(18,2) COMMENT 'Numerical composite score representing the remaining risk level after controls are applied. Compared against the risk appetite threshold to determine whether the risk is acceptable or requires further treatment.',
    `review_cycle` STRING COMMENT 'The mandated frequency at which this risk assessment must be reviewed and refreshed. Drives scheduling of next_review_date and supports compliance with ISO 27001 periodic review requirements.. Valid values are `monthly|quarterly|semi_annual|annual|ad_hoc`',
    `risk_description` STRING COMMENT 'Detailed narrative description of the risk scenario, including the threat source, vulnerability, and potential consequence. May contain sensitive matter or client information and is classified confidential. Supports Legal Professional Privilege (LPP) considerations.',
    `risk_domain` STRING COMMENT 'High-level classification of the risk domain being assessed. Professional indemnity covers malpractice exposure; data_breach covers PII/GDPR incidents; cybersecurity covers ISO 27001 threats; sanctions covers FATF/AML screening; reputational covers client or matter reputational flags. [ENUM-REF-CANDIDATE: professional_indemnity|data_breach|cybersecurity|sanctions|reputational|operational|regulatory|financial — promote to reference product]',
    `risk_score_scale` STRING COMMENT 'The numerical scale used for inherent and residual risk scoring in this assessment (e.g., 1_to_5, 1_to_10, 1_to_25). Ensures correct interpretation of scores when the firm operates multiple scoring frameworks across practice groups.. Valid values are `1_to_5|1_to_10|1_to_25`',
    `risk_title` STRING COMMENT 'Short, human-readable label for the risk item being assessed (e.g., Unauthorised disclosure of privileged documents, Sanctions exposure — client XYZ). Used in dashboards, reports, and risk register summaries.',
    `risk_treatment_option` STRING COMMENT 'The selected risk treatment strategy for this assessment. Accept means the firm tolerates the residual risk; mitigate means additional controls will be implemented; transfer means risk is shifted (e.g., via professional indemnity insurance); avoid means the risk-generating activity is discontinued.. Valid values are `accept|mitigate|transfer|avoid`',
    `sanctions_flag` BOOLEAN COMMENT 'Indicates whether this risk assessment was triggered by or relates to a sanctions screening alert (e.g., OFAC, UN, EU sanctions lists). True requires escalation to the firms Anti-Money Laundering (AML) compliance officer.',
    `source_system` STRING COMMENT 'Name of the operational system of record from which this risk assessment originated or was ingested (e.g., Intapp Conflicts, Elite 3E, manual entry). Supports data lineage tracking in the Databricks Silver Layer.',
    `treatment_description` STRING COMMENT 'Narrative description of the specific actions, controls, or measures to be implemented under the selected risk treatment option. Classified confidential as it may contain sensitive operational or legal strategy information.',
    `treatment_due_date` DATE COMMENT 'Target date by which the agreed risk treatment actions must be completed. Used for tracking remediation progress and escalation when treatment is overdue.',
    `within_appetite` BOOLEAN COMMENT 'Indicates whether the residual risk score falls within the firms defined risk appetite threshold. True means the risk is acceptable; False triggers mandatory escalation and treatment action. Derived from comparing residual_risk_score against risk_appetite_threshold but stored for reporting efficiency.',
    CONSTRAINT pk_assessment PRIMARY KEY(`assessment_id`)
) COMMENT 'Formal risk assessment record capturing the structured evaluation of a specific risk item at a point in time. Records inherent risk score, control effectiveness rating, residual risk score, likelihood rating, impact rating, risk appetite threshold comparison, assessor identity, assessment methodology (qualitative/quantitative), and next review date. Supports periodic risk review cycles mandated by ISO 27001 and SRA requirements.';

CREATE OR REPLACE TABLE `legal_ecm`.`risk`.`risk_control` (
    `risk_control_id` BIGINT COMMENT 'Unique surrogate identifier for each risk control record in the enterprise risk register. Primary key for the risk_control data product.',
    `category_id` BIGINT COMMENT 'Foreign key linking to risk.risk_category. Business justification: Controls are designed to mitigate specific categories of risk. risk_control has control_category (STRING) which should normalize to risk_category table for taxonomy consistency.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to contract.obligation. Business justification: Risk controls are implemented to ensure specific contractual obligations are met (e.g., a data security control ensuring GDPR processing obligations are fulfilled). Legal compliance teams map controls',
    `register_id` BIGINT COMMENT 'Reference to the parent risk item in the enterprise risk register that this control is designed to mitigate. Links the control to its associated risk exposure.',
    `approval_date` DATE COMMENT 'Date on which this control was formally approved by the designated approver. Required for ISO 27001 governance documentation and SRA compliance audit trails.',
    `automation_flag` BOOLEAN COMMENT 'Indicates whether the control is automated (True) or manual (False). Automated controls are executed by systems (e.g., Intapp Conflicts automated screening, iManage access controls); manual controls rely on human action. Informs risk appetite assessments and operational resilience planning.',
    `control_description` STRING COMMENT 'Detailed narrative describing the purpose, scope, and mechanism of the control, including how it addresses the identified risk. Supports ISO 27001 Statement of Applicability (SoA) documentation.',
    `control_name` STRING COMMENT 'Short, human-readable title of the risk control (e.g., Privileged Access Review, PII Data Encryption at Rest, Conflict Check Gate). Used in dashboards, audit reports, and SRA compliance reviews.',
    `control_type` STRING COMMENT 'Classification of the control by its functional purpose in the risk management lifecycle. Preventive controls stop risk events; detective controls identify them; corrective controls remediate them; deterrent controls discourage threats; compensating controls substitute for primary controls; directive controls mandate behaviour.. Valid values are `preventive|detective|corrective|deterrent|compensating|directive`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time at which this risk control record was first created in the enterprise risk register. Provides the audit trail start point for ISO 27001 and SRA compliance reviews.',
    `deficiency_description` STRING COMMENT 'Narrative description of any control deficiency, gap, or weakness identified during the most recent test. Null if no deficiency was found. Feeds the remediation workflow and is referenced in ISO 27001 nonconformity reports and SRA compliance submissions.',
    `design_effectiveness_rating` STRING COMMENT 'Assessment of whether the control is suitably designed to address the risk it targets, independent of whether it is operating correctly. Adequate: design is fit for purpose. Inadequate: design has structural gaps. Not Assessed: design review not yet completed.. Valid values are `adequate|inadequate|not_assessed`',
    `domain` STRING COMMENT 'Business risk domain that this control primarily addresses (e.g., Professional Indemnity, Data Privacy / GDPR, Cybersecurity, Sanctions Screening, Reputational Risk, Anti-Money Laundering (AML), Conflict of Interest). [ENUM-REF-CANDIDATE: professional_indemnity|data_privacy|cybersecurity|sanctions_screening|reputational|aml|conflict_of_interest|regulatory_compliance — promote to reference product]',
    `evidence_reference` STRING COMMENT 'Document Management System (DMS) reference or iManage Work document identifier for the evidence artefact supporting the most recent control test (e.g., screenshots, logs, policy documents, access reports). Required for ISO 27001 audit evidence packages.',
    `gdpr_relevant_flag` BOOLEAN COMMENT 'Indicates whether this control is relevant to the firms General Data Protection Regulation (GDPR) compliance obligations, including Personally Identifiable Information (PII) protection and data breach prevention (True) or not (False). Supports Data Protection Officer (DPO) reporting.',
    `implementation_date` DATE COMMENT 'The date on which the control was fully implemented and became operational. Used to calculate control age, schedule periodic reviews, and demonstrate timely remediation to SRA and ISO 27001 auditors.',
    `implementation_status` STRING COMMENT 'Current lifecycle state of the controls implementation. Planned: approved but not yet started. In Progress: actively being deployed. Implemented: fully operational. Deferred: postponed with documented rationale. Not Applicable: formally excluded from scope with SoA justification.. Valid values are `planned|in_progress|implemented|deferred|not_applicable`',
    `inherent_risk_rating` STRING COMMENT 'The assessed level of risk exposure before any controls are applied. Provides the baseline against which control effectiveness is measured. Required for ISO 27001 risk treatment plan documentation.. Valid values are `critical|high|medium|low|negligible`',
    `iso_annex_a_reference` STRING COMMENT 'The specific ISO 27001:2022 Annex A control identifier to which this control maps (e.g., A.5.1, A.8.24). Enables traceability between the firms control catalogue and the ISO certification framework. Required for Statement of Applicability (SoA) reporting.. Valid values are `^A.[0-9]{1,2}.[0-9]{1,2}(.[0-9]{1,2})?$`',
    `iso_soa_included_flag` BOOLEAN COMMENT 'Indicates whether this control is included in the firms ISO 27001 Statement of Applicability (SoA) (True) or formally excluded with documented justification (False). Mandatory field for ISO 27001 certification maintenance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time at which this risk control record was most recently updated. Supports change tracking, audit trail requirements, and incremental data loading in the Databricks Silver Layer.',
    `last_test_date` DATE COMMENT 'Date on which the most recently completed control test instance was executed. Used to determine whether the control is within its required testing cadence and to flag overdue tests for the compliance team.',
    `last_test_outcome` STRING COMMENT 'Result of the most recently completed control test instance. Pass: control operated as designed. Fail: control did not operate as designed. Partial Pass: control operated with minor deficiencies. Not Applicable: test was not applicable in the period.. Valid values are `pass|fail|partial_pass|not_applicable`',
    `lpp_scope_flag` BOOLEAN COMMENT 'Indicates whether this control is specifically designed to protect Legal Professional Privilege (LPP) material from unauthorised disclosure (True) or not (False). Critical for controls governing iManage Work access, Relativity matter workspaces, and client communication channels.',
    `mitigates_risk` BIGINT COMMENT 'FK to risk.risk_register.risk_register_id — Controls are implemented to mitigate specific risks. This many-to-many relationship (via junction or FK array) is essential for control-to-risk traceability required by ISO 27001.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review or re-assessment of the controls design and operational effectiveness. Drives the control testing calendar and ensures compliance with ISO 27001 continuous improvement requirements.',
    `operational_effectiveness_rating` STRING COMMENT 'Assessment of how well the control is operating in practice to mitigate the associated risk. Derived from the most recent completed test cycle. Effective: control operates as designed. Partially Effective: control operates but with gaps. Ineffective: control fails to mitigate risk. Not Tested: no test has been completed.. Valid values are `effective|partially_effective|ineffective|not_tested`',
    `pii_scope_flag` BOOLEAN COMMENT 'Indicates whether this control specifically addresses the protection of Personally Identifiable Information (PII) held by the firm (True) or not (False). Used to scope GDPR Article 32 technical and organisational measures documentation.',
    `priority` STRING COMMENT 'Business-assigned priority level for this control, reflecting the criticality of the risk it mitigates and the urgency of maintaining its effectiveness. Used to prioritise control testing resources and remediation efforts.. Valid values are `critical|high|medium|low`',
    `reference_code` STRING COMMENT 'Externally-known unique alphanumeric code assigned to this control, aligned to the ISO 27001 Annex A control numbering scheme or the firms internal control catalogue (e.g., ISO-A.8.1-001). Used for cross-referencing in audit reports and SRA compliance submissions.. Valid values are `^[A-Z]{2,6}-[A-Z0-9]{2,10}-[0-9]{3,6}$`',
    `remediation_completed_date` DATE COMMENT 'Date on which the remediation action was confirmed as completed and verified. Null if remediation is not yet complete. Used to close the deficiency lifecycle and update the ISO 27001 nonconformity register.',
    `remediation_due_date` DATE COMMENT 'Target date by which the identified control deficiency must be remediated. Null if no remediation is required. Used to track overdue remediations and escalate to the Risk Committee and SRA as required.',
    `remediation_required_flag` BOOLEAN COMMENT 'Indicates whether a remediation action is required as a result of the most recent control test (True) or not (False). Triggers the remediation workflow and escalation process for overdue items.',
    `remediation_status` STRING COMMENT 'Current status of the remediation action for any identified control deficiency. Not Required: no deficiency found. Open: remediation identified but not started. In Progress: remediation underway. Completed: deficiency resolved and verified. Overdue: remediation due date has passed without completion.. Valid values are `not_required|open|in_progress|completed|overdue`',
    `residual_risk_rating` STRING COMMENT 'The assessed level of risk remaining after this control and any other mitigating measures are applied. Represents the firms net exposure. Used in risk appetite reporting to the firms Risk Committee and in SRA regulatory submissions.. Valid values are `critical|high|medium|low|negligible`',
    `review_frequency` STRING COMMENT 'Mandated frequency at which this control must be reviewed and tested. Determines the cadence of scheduled test instances and supports audit planning for ISO 27001 surveillance audits and SRA compliance reviews.. Valid values are `monthly|quarterly|semi_annual|annual|ad_hoc`',
    `soa_exclusion_justification` STRING COMMENT 'Documented rationale for excluding this control from the ISO 27001 Statement of Applicability (SoA). Null if the control is included. Required by ISO 27001:2022 Clause 6.1.3(d) for all excluded Annex A controls.',
    `source_system` STRING COMMENT 'Name of the operational system of record in which this control is primarily configured or enforced (e.g., Intapp Conflicts, iManage Work, Relativity, SAP SuccessFactors). Supports lineage tracing and system-level risk assessments.',
    `sra_reportable_flag` BOOLEAN COMMENT 'Indicates whether a control failure or deficiency associated with this control is reportable to the Solicitors Regulation Authority (SRA) under mandatory reporting obligations (True) or not (False). Supports regulatory breach management workflows.',
    `test_methodology` STRING COMMENT 'The approach used to test the control in the most recent test instance. Inquiry: interviews with control operators. Observation: direct observation of control execution. Inspection: review of evidence documents. Re-performance: independent re-execution of the control. Walkthrough: end-to-end process trace. Automated Scan: system-generated test.. Valid values are `inquiry|observation|inspection|re_performance|walkthrough|automated_scan`',
    `to_register` BIGINT COMMENT 'FK to risk.risk_register.risk_register_id — Controls mitigate specific risks. The risk_control description states linkage to mitigated risk items. This FK is essential for control-to-risk traceability required by ISO 27001.',
    `to_risk_register` BIGINT COMMENT 'FK to risk.risk_register.risk_register_id — Controls mitigate specific risks. The many-to-many relationship between controls and risk items is the core of risk management. Without this link, you cannot answer what controls address this risk? ',
    CONSTRAINT pk_risk_control PRIMARY KEY(`risk_control_id`)
) COMMENT 'Catalog of risk controls and mitigating measures implemented to address identified risks, including complete control testing and audit history. Each record captures control type (preventive, detective, corrective), control owner, implementation status, operational effectiveness rating, and linkage to mitigated risk items. Embeds the full testing lifecycle: each test instance records test date, tester identity, test methodology, evidence reference, pass/fail outcome, deficiencies identified, remediation required flag, and remediation due date. Provides the consolidated control-and-test audit trail required for ISO 27001 certification and SRA compliance reviews. Aligned to ISO 27001 Annex A control framework.';

CREATE OR REPLACE TABLE `legal_ecm`.`risk`.`indemnity_exposure` (
    `indemnity_exposure_id` BIGINT COMMENT 'Unique surrogate identifier for each professional indemnity exposure record. Primary key for the indemnity_exposure data product within the risk domain.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.contract_agreement. Business justification: Indemnity exposure records are generated by contracts containing indemnity clauses (contract_agreement.indemnity_clause_flag). PI and risk teams track indemnity exposure per originating contract for i',
    `asset_id` BIGINT COMMENT 'Foreign key linking to ip.ip_asset. Business justification: PI indemnity exposure records must be traceable to the specific IP asset that triggered the exposure (e.g., abandoned patent due to advice error). This supports PI insurance renewal submissions and ri',
    `category_id` BIGINT COMMENT 'Foreign key linking to risk.risk_category. Business justification: Indemnity exposures are categorized by risk type. indemnity_exposure has exposure_type (STRING) which should normalize to risk_category for taxonomy consistency.',
    `check_id` BIGINT COMMENT 'Reference to the conflict check record that identified or is associated with the conflict-of-interest dimension of this exposure. Links to the conflict domain to provide the full conflict screening context without duplicating conflict data.',
    `docket_id` BIGINT COMMENT 'Foreign key linking to matter.docket. Business justification: Indemnity exposure records are created and managed at the litigation case (docket) level for reserve-setting and insurer notification purposes. Legal risk managers track exposure per active docket for',
    `indemnity_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.indemnity_policy. Business justification: Indemnity exposure records track potential claims against a specific PI policy. Risk managers aggregate total exposure per policy for renewal submissions and insurer notifications. policy_number, poli',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Professional indemnity exposures often arise from billing disputes or fee-related client complaints. Firms link PI exposure to the triggering invoice for reserve calculation, insurer notification, and',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to ip.license_agreement. Business justification: License agreement drafting errors (missed FRAND obligations, incorrect royalty structures, defective exclusivity terms) are a named PI exposure category in legal services. Linking indemnity_exposure d',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter or case from which this professional indemnity exposure arises. Links the exposure record to the matter management domain for context on the underlying work.',
    `pi_claim_id` BIGINT COMMENT 'Foreign key linking to risk.pi_claim. Business justification: An indemnity exposure can crystallize into a formal PI claim. The exposure is the potential liability stage; the claim is the formal claim filed stage. Valid progression relationship. Replaces cla',
    `profile_id` BIGINT COMMENT 'Reference to the client entity associated with this indemnity exposure. Enables risk aggregation by client and supports Know Your Client (KYC) and conflict-check linkage.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Professional indemnity exposures are enterprise risks and should be tracked in the risk register. Valid business relationship for PI risk aggregation.',
    `termination_id` BIGINT COMMENT 'Foreign key linking to contract.termination. Business justification: Terminations with disputes, penalties, or wrongful termination allegations directly generate indemnity exposure records. PI teams track termination-triggered exposures separately for insurance notific',
    `account_id` BIGINT COMMENT 'Foreign key linking to trust.account. Business justification: Indemnity exposures arising from trust fund mismanagement must reference the specific trust account. Role-prefix trust_account used because indemnity_exposure already has profile_id and matter_id; t',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp at which this indemnity exposure record was first created in the risk register. Provides the audit trail anchor for the records lifecycle and supports data lineage tracking in the Databricks Silver Layer.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts on this exposure record (estimated_claim_value, reserve_amount, excess_amount, settlement_amount). Supports multi-currency PI exposure reporting for international practices.. Valid values are `^[A-Z]{3}$`',
    `estimated_claim_value` DECIMAL(18,2) COMMENT 'The firms current best estimate of the total monetary value of the potential claim arising from this exposure, expressed in the firms base currency. Used for reserve-setting, PI insurance renewal, and risk appetite monitoring. Reviewed and updated as new information becomes available.',
    `excess_amount` DECIMAL(18,2) COMMENT 'The amount of the policy excess (deductible) applicable to this exposure under the firms professional indemnity insurance policy. Represents the portion of any claim the firm must bear before insurer coverage is triggered. Critical for net exposure calculation.',
    `exposure_linked_to_risk` BIGINT COMMENT 'FK to risk.risk_register.risk_register_id — PI exposures should reference the risk register item they relate to for consolidated risk reporting.',
    `exposure_narrative` STRING COMMENT 'Free-text description of the circumstances giving rise to this professional indemnity exposure, including the nature of the alleged failing, the clients complaint, and any relevant background. Confidential and subject to Legal Professional Privilege (LPP) where applicable.',
    `exposure_reference` STRING COMMENT 'Externally-known business reference number assigned to this PI exposure record, used in correspondence with insurers, brokers, and internal risk committees. Format: PI-{YYYY}-{NNNNNN}.. Valid values are `^PI-[0-9]{4}-[0-9]{6}$`',
    `exposure_status` STRING COMMENT 'Current lifecycle status of the indemnity exposure record, from initial identification through insurer notification, active reservation, litigation, and final closure. Drives workflow routing and risk appetite monitoring.. Valid values are `identified|notified|under_investigation|reserved|closed|litigated`',
    `external_counsel_engaged_flag` BOOLEAN COMMENT 'Indicates whether the firm has engaged external legal counsel to advise on or defend the claim arising from this exposure. True if external counsel has been instructed; False if the matter is being handled internally or no claim has been made.',
    `external_counsel_firm` STRING COMMENT 'Name of the external law firm engaged to advise on or defend the claim arising from this exposure. Populated when external_counsel_engaged_flag is True. Used for conflict screening and cost tracking.',
    `identified_date` DATE COMMENT 'The date on which the firm first became aware of the potential professional indemnity exposure. Critical for determining the policy year applicable and meeting insurer notification deadlines.',
    `insurer_notification_date` DATE COMMENT 'The date on which the firm formally notified its professional indemnity insurer of this exposure. Null if insurer_notified_flag is False. Used to verify compliance with policy notification obligations and to anchor the claims-made trigger.',
    `insurer_notified_flag` BOOLEAN COMMENT 'Indicates whether the firms professional indemnity insurer has been formally notified of this exposure. A value of True confirms notification has been made; False indicates notification is pending or not yet required.',
    `internal_investigation_status` STRING COMMENT 'Current status of the firms internal investigation into the circumstances giving rise to this exposure. Tracks whether a root cause analysis has been initiated, is ongoing, or has been completed and findings documented.. Valid values are `not_started|in_progress|completed|escalated`',
    `investigation_completed_date` DATE COMMENT 'The date on which the firms internal investigation into this exposure was formally concluded and findings documented. Null if internal_investigation_status is not completed. Used for risk governance reporting.',
    `jurisdiction` STRING COMMENT 'The legal jurisdiction (ISO 3166-1 alpha-2 or alpha-3 country code) in which the matter giving rise to this exposure was conducted and where any claim would be adjudicated. Determines applicable professional conduct rules and limitation periods.. Valid values are `^[A-Z]{2,3}$`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp at which this indemnity exposure record was most recently modified. Used for incremental data pipeline processing, change detection, and audit trail maintenance in the Databricks Silver Layer.',
    `limitation_expiry_date` DATE COMMENT 'The date on which the applicable statute of limitations or limitation period for a claim arising from this exposure expires. Critical for risk management and determining whether an exposure can still give rise to a formal claim. Varies by jurisdiction and exposure type.',
    `lpp_applies_flag` BOOLEAN COMMENT 'Indicates whether Legal Professional Privilege (LPP) applies to the documents and communications associated with this exposure record, restricting disclosure in any subsequent litigation or regulatory investigation. True if LPP is asserted; False if not applicable or waived.',
    `matter_close_date` DATE COMMENT 'The date on which the underlying legal matter from which this exposure arises was formally closed in the practice management system. Used to calculate the elapsed time between matter closure and exposure identification, informing limitation period analysis.',
    `pi_renewal_submission_flag` BOOLEAN COMMENT 'Indicates whether this exposure record has been included in the firms most recent professional indemnity insurance renewal submission to the insurer or broker. True confirms inclusion; False indicates it is pending inclusion or not yet due.',
    `practice_area` STRING COMMENT 'The legal practice area (e.g., Corporate, Litigation, Real Estate, Employment, Intellectual Property) associated with the matter giving rise to this exposure. Enables risk concentration analysis by practice group and informs PI insurance underwriting submissions. [ENUM-REF-CANDIDATE: corporate|litigation|real_estate|employment|intellectual_property|regulatory_compliance|tax|private_client|other — promote to reference product]',
    `regulatory_body` STRING COMMENT 'Name of the regulatory body to which this exposure has been or may be referred (e.g., Solicitors Regulation Authority, State Bar Association, Legal Services Board). Populated when regulatory_referral_flag is True.',
    `regulatory_referral_flag` BOOLEAN COMMENT 'Indicates whether this exposure has been or is required to be referred to a regulatory body (e.g., SRA, State Bar Association, Legal Services Board). True if a regulatory referral has been made or is pending. Drives compliance domain notifications.',
    `reputational_risk_flag` BOOLEAN COMMENT 'Indicates whether this exposure carries a significant reputational risk dimension beyond the financial liability, such as media attention, regulatory scrutiny, or high-profile client involvement. True triggers enhanced monitoring and senior partner escalation.',
    `reserve_amount` DECIMAL(18,2) COMMENT 'The financial reserve set aside by the firm (or agreed with the insurer) to cover the estimated liability for this exposure. Feeds the firms balance sheet provisioning and PI insurance renewal submissions. Distinct from the estimated claim value as it reflects the agreed reserving position.',
    `reserve_last_reviewed_date` DATE COMMENT 'The date on which the financial reserve for this exposure was most recently reviewed and confirmed or updated by the risk committee or responsible partner. Ensures reserves remain current and supports PI insurance renewal accuracy.',
    `risk_severity` STRING COMMENT 'The firms internal risk severity rating for this exposure, reflecting the combination of estimated financial impact and likelihood of a formal claim being made. Drives escalation protocols, partner notification requirements, and risk committee reporting.. Valid values are `low|medium|high|critical`',
    `root_cause_category` STRING COMMENT 'High-level categorisation of the root cause of the professional failing giving rise to this exposure, as determined during the firms internal investigation. Used for risk management trend analysis and process improvement initiatives.. Valid values are `process_failure|supervision_failure|communication_failure|knowledge_gap|system_error|external_factor`',
    `settlement_amount` DECIMAL(18,2) COMMENT 'The actual monetary amount agreed in settlement of the claim arising from this exposure. Populated only when exposure_status is closed and the matter was resolved by settlement. Null for open or litigated exposures. Used for actuarial analysis and PI renewal benchmarking.',
    `settlement_date` DATE COMMENT 'The date on which the claim arising from this exposure was formally settled or resolved. Populated when exposure_status transitions to closed. Used for claims lifecycle analytics and PI insurance renewal reporting.',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this exposure record originated or was ingested into the Silver Layer. Supports data lineage, reconciliation, and audit requirements.. Valid values are `elite_3e|manual_entry|risk_register|intapp_conflicts`',
    `to_register` BIGINT COMMENT 'FK to risk.risk_register.risk_register_id — PI exposure records represent specific risk items that should link back to the risk register for consolidated risk reporting.',
    `to_risk_register` BIGINT COMMENT 'FK to risk.risk_register.risk_register_id — PI exposure records should link to the risk register item they represent. This connects the financial exposure tracking to the broader risk management framework.',
    CONSTRAINT pk_indemnity_exposure PRIMARY KEY(`indemnity_exposure_id`)
) COMMENT 'Professional indemnity (PI) exposure record tracking the firms estimated liability exposure on a per-matter or per-claim basis. Captures exposure type (negligence, breach of duty, conflict of interest), estimated claim value, reserve amount, insurer notified flag, notification date, policy year, excess amount, and current exposure status. Feeds the firms PI insurance renewal process and risk appetite monitoring.';

CREATE OR REPLACE TABLE `legal_ecm`.`risk`.`pi_claim` (
    `pi_claim_id` BIGINT COMMENT 'Unique surrogate identifier for the professional indemnity claim record. Primary key for the pi_claim data product in the risk domain.',
    `account_id` BIGINT COMMENT 'Foreign key linking to trust.account. Business justification: PI claims arising from misappropriation or mishandling of trust funds must be linked to the specific trust account involved. Legal PI insurers and risk managers require this link to investigate the cl',
    `category_id` BIGINT COMMENT 'Foreign key linking to risk.risk_category. Business justification: PI claims are categorized by risk type. pi_claim has breach_category (STRING) which should normalize to risk_category for taxonomy consistency.',
    `data_breach_incident_id` BIGINT COMMENT 'Foreign key linking to risk.data_breach_incident. Business justification: pi_claim.data_breach_reference (STRING) is a free-text reference to a data breach incident that triggered or is associated with this PI claim. Normalizing this to a proper FK data_breach_incident_id →',
    `indemnity_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.indemnity_policy. Business justification: PI claims are made under a specific indemnity policy. Claims managers need full policy terms (limit, excess, coverage period) when managing a claim. policy_number, policy_year, and insurer_name on pi_',
    `matter_id` BIGINT COMMENT 'Reference to the underlying client matter from which the professional indemnity claim arises. Links the claim to the matter record in Elite 3E for context on the work performed, responsible timekeeper, and practice group.',
    `profile_id` BIGINT COMMENT 'Reference to the client entity associated with the matter giving rise to the claim. Enables linkage to the client domain for relationship history, KYC status, and conflict check records.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: PI claims are materialized risks and should be tracked in the risk register. Valid business relationship for claims risk management.',
    `adr_method` STRING COMMENT 'The Alternative Dispute Resolution (ADR) method employed or proposed for resolving the PI claim outside of formal litigation. Null or none if the claim is proceeding through court litigation or has been resolved without ADR.. Valid values are `none|mediation|arbitration|expert_determination|negotiation`',
    `alleged_breach_date` DATE COMMENT 'The date on which the alleged act, error, or omission giving rise to the claim is said to have occurred. Relevant for determining the applicable policy period on a claims-made or occurrence basis and for limitation period analysis.',
    `alleged_breach_description` STRING COMMENT 'Narrative description of the alleged act, error, or omission forming the basis of the professional indemnity claim. Includes the nature of the professional failing alleged (e.g., negligent advice, missed deadline, conflict of interest, breach of confidentiality). Protected by Legal Professional Privilege (LPP) considerations.',
    `claim_amount` DECIMAL(18,2) COMMENT 'The gross monetary amount claimed by the claimant against the firm, as stated in the formal claim notification or pleadings. Represents the claimants quantification of alleged loss before any negotiation, mitigation, or settlement.',
    `claim_currency` STRING COMMENT 'ISO 4217 three-letter currency code in which the claim amount is denominated (e.g., USD, GBP, EUR). Required for multi-currency PI exposure reporting and insurer communication.. Valid values are `^[A-Z]{3}$`',
    `claim_date` DATE COMMENT 'The date on which the formal claim was made against the firm by the claimant or their legal representative. This is the principal business event date for the claim and determines the applicable policy year for PI insurance purposes.',
    `claim_outcome` STRING COMMENT 'The final resolution outcome of the professional indemnity claim. Populated upon closure of the claim. Used for risk analytics, insurer reporting, and lessons-learned reviews. [ENUM-REF-CANDIDATE: settled|dismissed|judgment_for_claimant|judgment_for_firm|withdrawn|mediated|arbitrated — 7 candidates stripped; promote to reference product]',
    `claim_reference_number` STRING COMMENT 'Externally-known alphanumeric reference number assigned to the claim at inception, used in all correspondence with the PI insurer, coverage counsel, and claimant. Follows the firms PI claim numbering convention (e.g., PI-2024-000123).. Valid values are `^PI-[0-9]{4}-[0-9]{6}$`',
    `claim_status` STRING COMMENT 'Current lifecycle status of the professional indemnity claim. Tracks progression from initial notification through investigation, insurer notification, litigation or negotiation, and final resolution. [ENUM-REF-CANDIDATE: open|under_investigation|notified_to_insurer|in_litigation|settled|closed|withdrawn — promote to reference product]',
    `claimant_jurisdiction` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the jurisdiction in which the claimant is domiciled or in which the claim is being pursued. Relevant for determining applicable law, limitation periods, and cross-border PI coverage.. Valid values are `^[A-Z]{3}$`',
    `claimant_name` STRING COMMENT 'Full legal name of the party making the professional indemnity claim against the firm. May be the firms own client, a third party, or a counterparty to a transaction on which the firm advised. Classified confidential due to sensitivity of claim proceedings.',
    `claimant_type` STRING COMMENT 'Classification of the claimants relationship to the firm. Distinguishes between the firms own clients, third parties who relied on the firms work product, counterparties to transactions, and regulatory bodies bringing disciplinary claims.. Valid values are `client|third_party|counterparty|regulatory_body|other`',
    `closure_date` DATE COMMENT 'The date on which the professional indemnity claim was formally closed, whether by settlement, judgment, withdrawal, or other resolution. Null for open claims. Used to calculate claim duration and for portfolio run-off analysis.',
    `coverage_confirmed` BOOLEAN COMMENT 'Indicates whether the PI insurer has confirmed that the claim falls within the scope of the firms professional indemnity policy coverage. True when coverage is confirmed; False when coverage is denied or under reservation of rights.',
    `coverage_denial_reason` STRING COMMENT 'Narrative explanation provided by the insurer for any denial of coverage or reservation of rights. Populated only when coverage_confirmed is False. Used for coverage dispute management and legal review.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp at which the PI claim record was first created in the risk data product. Represents the audit trail creation event, distinct from the claim_date (when the claim was made) and notification_date (when the insurer was notified).',
    `deductible_amount` DECIMAL(18,2) COMMENT 'The self-insured retention or deductible amount applicable to this claim under the firms PI policy. Represents the portion of the claim cost borne directly by the firm before insurer indemnity applies.',
    `defence_costs_incurred` DECIMAL(18,2) COMMENT 'Cumulative legal and professional costs incurred by the firm in defending the PI claim, including external coverage counsel fees, expert witness fees, and court costs. Tracked separately from the settlement amount for insurer reimbursement and cost management purposes.',
    `ethical_wall_required` BOOLEAN COMMENT 'Indicates whether an ethical wall (information barrier) has been established in Intapp Conflicts to prevent the timekeepers involved in the underlying matter from accessing PI claim information, protecting privilege and avoiding further conflict exposure.',
    `insurer_claim_reference` STRING COMMENT 'The reference number assigned to the claim by the PI insurer for tracking within the insurers own claims management system. Used in all insurer correspondence and for reconciliation between the firms records and the insurers records.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp at which the PI claim record was most recently modified. Used for audit trail, data lineage, and incremental load processing in the Databricks Silver Layer.',
    `limitation_expiry_date` DATE COMMENT 'The date on which the applicable limitation period for the claimants cause of action expires. Critical for assessing whether the claim is time-barred and for managing the firms procedural response deadlines.',
    `lpp_applies` BOOLEAN COMMENT 'Indicates whether Legal Professional Privilege (LPP) has been asserted over communications and documents relating to this PI claim. When True, access to claim documents is restricted to authorised personnel only, consistent with LPP obligations.',
    `notes` STRING COMMENT 'Free-text field for recording material developments, key decisions, insurer correspondence summaries, and other significant events in the lifecycle of the PI claim. Protected as confidential due to potential LPP and privilege considerations.',
    `notification_date` DATE COMMENT 'The date on which the firm formally notified its PI insurer of the claim or circumstance that may give rise to a claim. Timely notification is a condition of coverage under most PI policies; late notification may prejudice the firms right to indemnity.',
    `pii_data_involved` BOOLEAN COMMENT 'Indicates whether the alleged breach involves the unauthorised disclosure, loss, or mishandling of Personally Identifiable Information (PII). When True, the claim may also trigger data breach notification obligations under GDPR, CCPA, or DPA 2018.',
    `practice_area` STRING COMMENT 'The legal practice area associated with the matter from which the claim arises. Used for risk analytics to identify practice areas with elevated PI exposure and to inform risk management and training priorities. [ENUM-REF-CANDIDATE: corporate|litigation|intellectual_property|employment|real_estate|regulatory|tax|banking_finance|private_client|other — promote to reference product]',
    `regulatory_report_date` DATE COMMENT 'The date on which the firm submitted the required regulatory report to the relevant governing body (e.g., SRA, state bar). Null if no regulatory report is required or if the report has not yet been filed.',
    `regulatory_report_required` BOOLEAN COMMENT 'Indicates whether the PI claim triggers a mandatory regulatory reporting obligation, such as notification to the SRA, state bar association, or other governing body. True when reporting is required under applicable professional conduct rules.',
    `reserve_amount` DECIMAL(18,2) COMMENT 'The financial reserve established by the firm and/or its PI insurer to cover the estimated ultimate cost of the claim, including potential settlement, defence costs, and associated expenses. Used for financial provisioning and insurer reporting.',
    `settlement_amount` DECIMAL(18,2) COMMENT 'The agreed monetary amount paid to the claimant to resolve the professional indemnity claim, as recorded upon settlement. Null if the claim has not been settled. Distinct from the original claim amount and the reserve.',
    `settlement_date` DATE COMMENT 'The date on which the settlement agreement was executed and the claim was formally resolved by payment or other agreed consideration. Null if the claim has not been settled.',
    CONSTRAINT pk_pi_claim PRIMARY KEY(`pi_claim_id`)
) COMMENT 'Professional indemnity (PI) claim record capturing formal claims made against the firm by clients or third parties. Records claimant details, claim date, matter reference, alleged breach description, claim amount, insurer reference, coverage confirmation, legal representation assigned, settlement amount, claim outcome, and closure date. Managed in coordination with the firms PI insurer and external coverage counsel.';

CREATE OR REPLACE TABLE `legal_ecm`.`risk`.`data_breach_incident` (
    `data_breach_incident_id` BIGINT COMMENT 'Primary key for data_breach_incident',
    `account_id` BIGINT COMMENT 'Foreign key linking to trust.trust_account. Business justification: Data breaches often affect specific trust accounts containing client PII and transaction data. Breach containment and ICO notification require identifying affected trust accounts for client notificati',
    `category_id` BIGINT COMMENT 'Foreign key linking to risk.risk_category. Business justification: Data breach incidents are categorized by risk type. data_breach_incident has breach_type (STRING) which should normalize to risk_category for taxonomy consistency.',
    `matter_id` BIGINT COMMENT 'Identifier of the legal matter associated with the breached data, if the breach is matter-specific.',
    `profile_id` BIGINT COMMENT 'Identifier of the client whose data was compromised, if the breach is client-specific.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Data breach incidents are a category of enterprise risk and should be tracked in the risk register. Valid business relationship for risk aggregation and governance.',
    `affected_system` STRING COMMENT 'Name or identifier of the IT system, application, or platform where the breach occurred (e.g., iManage Work, Elite 3E, email server, file share).',
    `breach_severity` STRING COMMENT 'Assessed severity level of the data breach based on volume of data, sensitivity, and potential harm to data subjects.. Valid values are `low|medium|high|critical`',
    `breach_source` STRING COMMENT 'Origin of the breach: internal actor, external threat actor, third-party vendor, or unknown.. Valid values are `internal|external|third_party|unknown`',
    `client_data_flag` BOOLEAN COMMENT 'Indicates whether confidential client data or client matter information was compromised in the breach.',
    `containment_date` DATE COMMENT 'Date when the breach was successfully contained and further unauthorized access or data loss was prevented.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this data breach incident record was first created in the system.',
    `data_categories_involved` STRING COMMENT 'Comma-separated list of data categories compromised in the breach (e.g., PII, special category data under GDPR Article 9, LPP-protected information, financial data, health data).',
    `data_subject_notification_date` DATE COMMENT 'Date when affected data subjects were notified of the breach, if notification was required.',
    `data_subject_notification_method` STRING COMMENT 'Method used to notify affected data subjects of the breach (email, postal mail, phone call, public notice).. Valid values are `email|postal_mail|phone|public_notice|not_applicable`',
    `data_subject_notification_required_flag` BOOLEAN COMMENT 'Indicates whether direct notification to affected data subjects is required under GDPR Article 34 or other applicable privacy laws.',
    `data_subjects_affected_count` STRING COMMENT 'Estimated or confirmed number of individual data subjects (clients, employees, third parties) whose personal data was compromised in the breach.',
    `discovered_by` STRING COMMENT 'Name or role of the individual, team, or automated system that discovered the breach (e.g., IT Security Team, employee report, automated monitoring).',
    `discovery_date` DATE COMMENT 'Date when the data breach or privacy incident was first discovered or reported to the firm.',
    `discovery_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the data breach incident was first discovered, critical for GDPR 72-hour notification clock.',
    `dpo_notified_date` DATE COMMENT 'Date when the firms Data Protection Officer was notified of the breach incident.',
    `estimated_financial_impact` DECIMAL(18,2) COMMENT 'Estimated financial impact of the breach including investigation costs, remediation costs, regulatory fines, legal fees, and potential compensation to affected parties.',
    `external_counsel_engaged_flag` BOOLEAN COMMENT 'Indicates whether external legal counsel was engaged to advise on the breach incident and regulatory obligations.',
    `forensic_investigation_flag` BOOLEAN COMMENT 'Indicates whether a formal forensic investigation was conducted by internal or external cybersecurity experts.',
    `gdpr_72_hour_deadline` TIMESTAMP COMMENT 'Calculated timestamp representing the 72-hour deadline from discovery for notifying the supervisory authority under GDPR Article 33.',
    `ico_notification_date` DATE COMMENT 'Date when the breach was formally notified to the UK Information Commissioners Office (ICO) or equivalent supervisory authority.',
    `ico_notification_status` STRING COMMENT 'Current status of the regulatory notification to the ICO or equivalent data protection authority.. Valid values are `not_required|pending|submitted|acknowledged|under_review|closed`',
    `ico_reference_number` STRING COMMENT 'Reference number assigned by the ICO or supervisory authority upon receipt of the breach notification.',
    `incident_date` DATE COMMENT 'Estimated or confirmed date when the actual breach or unauthorized access occurred, which may differ from discovery date.',
    `incident_owner` STRING COMMENT 'Name or identifier of the individual responsible for managing the breach incident response and remediation.',
    `incident_reference_number` STRING COMMENT 'Externally-known unique reference number assigned to the data breach incident for tracking and regulatory reporting purposes. Format: DBI-YYYY-NNNNNN.. Valid values are `^DBI-[0-9]{4}-[0-9]{6}$`',
    `incident_status` STRING COMMENT 'Current lifecycle status of the data breach incident in the investigation and remediation workflow.. Valid values are `reported|under_investigation|contained|remediated|closed|regulatory_notified`',
    `insurance_claim_filed_flag` BOOLEAN COMMENT 'Indicates whether a professional indemnity or cyber insurance claim has been filed for this breach incident.',
    `insurance_claim_reference` STRING COMMENT 'Reference number of the insurance claim filed for this breach incident, if applicable.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this data breach incident record was last updated or modified.',
    `law_enforcement_notified_flag` BOOLEAN COMMENT 'Indicates whether law enforcement authorities were notified of the breach incident.',
    `law_enforcement_reference` STRING COMMENT 'Reference number or case identifier assigned by law enforcement if the breach was reported to police or other authorities.',
    `lpp_protected_data_flag` BOOLEAN COMMENT 'Indicates whether data protected by Legal Professional Privilege (attorney-client privileged communications) was compromised in the breach.',
    `notification_required_flag` BOOLEAN COMMENT 'Indicates whether regulatory notification to a supervisory authority (ICO, DPA, state attorney general) is required under applicable data protection laws.',
    `pii_compromised_flag` BOOLEAN COMMENT 'Indicates whether Personally Identifiable Information was compromised in the breach.',
    `remediation_actions_taken` STRING COMMENT 'Detailed description of remediation actions taken to address the breach, prevent recurrence, and mitigate harm to data subjects (e.g., password resets, system patches, access revocation, enhanced monitoring).',
    `root_cause_analysis` STRING COMMENT 'Summary of the root cause analysis conducted to identify the underlying cause of the breach and prevent future incidents.',
    `special_category_data_flag` BOOLEAN COMMENT 'Indicates whether special category data (sensitive personal data under GDPR Article 9: racial/ethnic origin, political opinions, religious beliefs, health data, biometric data, etc.) was compromised.',
    CONSTRAINT pk_data_breach_incident PRIMARY KEY(`data_breach_incident_id`)
) COMMENT 'Data breach and privacy incident record tracking all actual or suspected breaches of PII, confidential client data, or LPP-protected information. Captures incident discovery date, breach type (unauthorized access, accidental disclosure, ransomware, insider threat), data subjects affected count, data categories involved (PII, special category, LPP), regulatory notification obligations triggered (GDPR 72-hour, DPA, CCPA), ICO/DPA notification status, and remediation actions taken. Supports GDPR Article 33/34 breach notification obligations.';

CREATE OR REPLACE TABLE `legal_ecm`.`risk`.`matter_risk_profile` (
    `matter_risk_profile_id` BIGINT COMMENT 'Unique identifier for the matter risk profile record. Primary key for this entity. Role: MASTER_RESOURCE (risk profile as a managed resource).',
    `kyc_record_id` BIGINT COMMENT 'Foreign key linking to client.kyc_record. Business justification: Matter onboarding risk process: the matter risk profile is informed by the clients current KYC record status and tier. Linking directly to the KYC record enables automated risk tier inheritance and s',
    `matter_id` BIGINT COMMENT 'Identifier of the legal matter to which this risk profile applies. Links this risk profile to the specific case or engagement being assessed.',
    `profile_id` BIGINT COMMENT 'Identifier of the client associated with this matter. Enables client-level risk aggregation and portfolio analysis.',
    `aml_risk_flag` BOOLEAN COMMENT 'Indicates whether the matter presents elevated anti-money laundering risk requiring enhanced due diligence, source of funds verification, and suspicious activity monitoring.',
    `client_credit_risk_rating` STRING COMMENT 'Credit risk assessment of the client using standard rating scale, indicating likelihood of payment default and informing billing arrangements and retainer requirements. [ENUM-REF-CANDIDATE: AAA|AA|A|BBB|BB|B|CCC|CC|C|D — 10 candidates stripped; promote to reference product]',
    `client_payment_history_flag` STRING COMMENT 'Historical payment performance indicator for this client based on past matters, informing credit risk and billing strategy.. Valid values are `excellent|good|fair|poor|new_client`',
    `conflict_risk_level` STRING COMMENT 'Assessment of potential conflicts of interest based on client relationships, adverse parties, and matter subject matter, informing ethical wall requirements and engagement decisions.. Valid values are `none|low|medium|high`',
    `cross_border_flag` BOOLEAN COMMENT 'Indicates whether the matter involves multiple jurisdictions, triggering additional conflict-of-laws analysis and regulatory compliance requirements.',
    `cybersecurity_risk_level` STRING COMMENT 'Assessment of cybersecurity and data breach risk for this matter based on data sensitivity, technology platforms used, third-party access, and threat landscape, informing ISO 27001 controls.. Valid values are `low|medium|high|critical`',
    `ediscovery_volume_exposure` STRING COMMENT 'Assessment of the volume and complexity of Electronically Stored Information (ESI) that may be subject to discovery, impacting matter cost, timeline, and technology-assisted review (TAR) requirements.. Valid values are `none|low|medium|high|very_high`',
    `escalation_date` DATE COMMENT 'Date when the matter was escalated to higher authority for review and approval, if escalation was required.',
    `escalation_required_flag` BOOLEAN COMMENT 'Indicates whether this matter risk profile requires escalation to senior management, risk committee, or board level due to risk tier or specific risk factors.',
    `esi_volume_gb` DECIMAL(18,2) COMMENT 'Estimated volume of ESI in gigabytes that may be subject to collection, review, and production in this matter, driving eDiscovery cost and resource planning.',
    `estimated_matter_value` DECIMAL(18,2) COMMENT 'Estimated total value at stake in the matter (transaction value, claim amount, or potential liability), used to assess proportionality of risk and insurance coverage adequacy. Expressed in firm base currency.',
    `insurance_notification_date` DATE COMMENT 'Date when professional indemnity insurer was notified of this matter, if notification was required.',
    `insurance_notification_required_flag` BOOLEAN COMMENT 'Indicates whether professional indemnity insurer notification is required for this matter based on risk profile and policy terms.',
    `jurisdictional_risk_level` STRING COMMENT 'Risk rating based on the legal jurisdictions involved, considering political stability, judicial predictability, enforcement mechanisms, and regulatory environment.. Valid values are `low|medium|high|very_high`',
    `last_review_date` DATE COMMENT 'Date of the most recent risk profile review, typically conducted at matter milestones (mid-matter review, pre-trial, significant developments).',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this risk profile record, supporting change tracking and audit requirements.',
    `lpp_sensitivity_level` STRING COMMENT 'Assessment of the sensitivity of privileged communications and work product in this matter, driving information security controls and ethical wall requirements.. Valid values are `standard|elevated|high|critical`',
    `matter_complexity_rating` STRING COMMENT 'Assessment of the legal and factual complexity of the matter considering number of parties, jurisdictions, legal issues, document volume, and expert requirements.. Valid values are `low|medium|high|very_high`',
    `matter_profile_references_risks` BIGINT COMMENT 'FK to risk.risk_register.risk_register_id — Matter risk profiles aggregate risk dimensions that may reference specific risk register items for that matter.',
    `matter_value_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated matter value (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `media_exposure_likelihood` STRING COMMENT 'Probability that the matter will attract media attention or public scrutiny, informing communications strategy and reputational risk management.. Valid values are `none|low|medium|high|very_high`',
    `next_review_date` DATE COMMENT 'Scheduled date for the next mandatory risk profile review, driven by overall risk tier and matter lifecycle stage.',
    `notes` STRING COMMENT 'Free-text field for additional risk assessment notes, context, and qualitative factors not captured in structured fields.',
    `overall_risk_tier` STRING COMMENT 'Consolidated risk rating for the matter using traffic-light classification: green (low risk), amber (medium risk), red (high risk). Drives partner review frequency and approval thresholds.. Valid values are `green|amber|red`',
    `pii_data_volume_category` STRING COMMENT 'Classification of the volume of PII involved in the matter, informing GDPR compliance requirements, data breach risk exposure, and data protection impact assessment needs.. Valid values are `none|minimal|moderate|substantial|extensive`',
    `primary_jurisdiction` STRING COMMENT 'Three-letter ISO country code representing the primary legal jurisdiction governing this matter (e.g., USA, GBR, DEU).. Valid values are `^[A-Z]{3}$`',
    `professional_indemnity_exposure` STRING COMMENT 'Assessment of potential professional liability and malpractice risk exposure for this matter, informing insurance notification requirements and risk mitigation protocols.. Valid values are `low|medium|high|very_high`',
    `profile_created_date` DATE COMMENT 'Date when this risk profile was initially created, typically at matter intake or new business approval stage.',
    `profile_created_timestamp` TIMESTAMP COMMENT 'Precise timestamp when this risk profile record was first created in the system, supporting audit trail and lifecycle tracking.',
    `profile_reference_number` STRING COMMENT 'Human-readable unique reference code for this matter risk profile, typically formatted as MRP-YYYYNNNN for external communication and audit trails.. Valid values are `^MRP-[0-9]{8}$`',
    `profile_status` STRING COMMENT 'Current lifecycle status of the risk profile indicating whether it is in draft, actively monitored, under review by risk committee, escalated to senior management, closed upon matter completion, or archived.. Valid values are `draft|active|under_review|escalated|closed|archived`',
    `regulatory_scrutiny_level` STRING COMMENT 'Assessment of the level of regulatory oversight and reporting requirements applicable to this matter, considering industry sector, transaction type, and jurisdictional requirements.. Valid values are `none|low|medium|high|critical`',
    `reputational_risk_rating` STRING COMMENT 'Assessment of potential reputational harm to the firm from association with this matter, considering client profile, matter type, public visibility, and ethical considerations.. Valid values are `low|medium|high|critical`',
    `risk_mitigation_plan` STRING COMMENT 'Summary of key risk mitigation strategies and controls implemented for this matter, including enhanced supervision, ethical walls, insurance notifications, and client communications.',
    `sanctions_screening_required_flag` BOOLEAN COMMENT 'Indicates whether parties, jurisdictions, or transaction elements require screening against international sanctions lists (OFAC, UN, EU) to ensure compliance with economic sanctions regimes.',
    `special_category_data_flag` BOOLEAN COMMENT 'Indicates whether the matter involves GDPR Article 9 special category data (racial/ethnic origin, political opinions, religious beliefs, health data, biometric data, genetic data, sex life/orientation), requiring heightened data protection controls.',
    `third_party_risk_flag` BOOLEAN COMMENT 'Indicates whether the matter involves third-party service providers (expert witnesses, eDiscovery vendors, co-counsel, ALSPs) requiring vendor due diligence and data sharing agreements.',
    `to_register` BIGINT COMMENT 'FK to risk.risk_register.risk_register_id — Matter risk profiles aggregate risk dimensions that may correspond to registered risks. This enables drill-down from matter risk tier to specific risk items.',
    `to_risk_register` BIGINT COMMENT 'FK to risk.risk_register.risk_register_id — Matter risk profiles aggregate risk items from the register that pertain to a specific matter. This link enables the roll-up view.',
    CONSTRAINT pk_matter_risk_profile PRIMARY KEY(`matter_risk_profile_id`)
) COMMENT 'Matter-level risk profile aggregating all risk dimensions for a specific legal matter including complexity rating, jurisdictional risk, client credit risk, legal professional privilege (LPP) sensitivity, eDiscovery/ESI volume exposure, regulatory scrutiny level, and overall matter risk tier (green/amber/red). Created at matter intake and updated at key lifecycle milestones (mid-matter review, pre-trial, closure). Provides the consolidated risk view consumed by matter management, billing, and partner review processes.';

CREATE OR REPLACE TABLE `legal_ecm`.`risk`.`mitigation_action` (
    `mitigation_action_id` BIGINT COMMENT 'Unique identifier for the risk mitigation action record. Primary key.',
    `assessment_id` BIGINT COMMENT 'Foreign key linking to risk.assessment. Business justification: A mitigation action is frequently triggered by a formal risk assessment — the assessment identifies the risk treatment option and the mitigation_action records the specific remediation step assigned. ',
    `asset_id` BIGINT COMMENT 'Foreign key linking to ip.ip_asset. Business justification: IP risk mitigation actions (filing divisionals to mitigate invalidity risk, recording assignments to cure ownership defects, filing disclaimers) are directly tied to specific IP assets. Linking mitiga',
    `category_id` BIGINT COMMENT 'Foreign key linking to risk.risk_category. Business justification: Mitigation actions target specific risk categories. Assuming action_category (STRING) aligns with risk taxonomy and should normalize to risk_category table.',
    `kyc_record_id` BIGINT COMMENT 'Foreign key linking to client.kyc_record. Business justification: KYC remediation process: mitigation actions are frequently raised to address KYC deficiencies (e.g., missing documents, expired verification). Linking the mitigation action to the specific KYC record ',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter associated with this mitigation action, if the risk is matter-specific. Null for enterprise-level risks.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to contract.obligation. Business justification: Risk mitigation actions are frequently designed to ensure contractual obligations are fulfilled (e.g., GDPR data handling obligations, regulatory reporting obligations). Legal compliance teams link mi',
    `phase_id` BIGINT COMMENT 'Foreign key linking to matter.phase. Business justification: Mitigation actions are assigned to specific matter phases (e.g., discovery-phase e-discovery cost controls, trial-phase witness preparation). Phase-level mitigation tracking is standard in legal proje',
    `profile_id` BIGINT COMMENT 'Reference to the client associated with this mitigation action, if the risk is client-specific. Null for enterprise-level risks.',
    `register_id` BIGINT COMMENT 'Reference to the parent risk in the risk register that this mitigation action addresses.',
    `risk_control_id` BIGINT COMMENT 'Foreign key linking to risk.risk_control. Business justification: Mitigation actions implement, test, or remediate specific controls. Business semantics: this action addresses this control. Creates valid chain: risk_mitigation_action → risk_control → risk_register',
    `account_id` BIGINT COMMENT 'Foreign key linking to trust.account. Business justification: Risk mitigation actions targeting trust accounts (e.g., increase reconciliation frequency, freeze account pending AML review, add dual-signatory requirement) must reference the specific trust account.',
    `action_description` STRING COMMENT 'Detailed description of the mitigation or remediation action to be taken, including specific steps, controls, or interventions required.',
    `action_owner_name` STRING COMMENT 'Full name of the individual assigned as the action owner, denormalized for reporting convenience.',
    `action_priority` STRING COMMENT 'Priority level assigned to the mitigation action based on risk severity and urgency: critical (immediate), high (urgent), medium (standard), or low (routine).. Valid values are `critical|high|medium|low`',
    `action_reference_number` STRING COMMENT 'Business-facing unique reference code for the mitigation action, used in reporting and tracking (e.g., RMA-00012345).. Valid values are `^[A-Z]{2,4}-[0-9]{4,8}$`',
    `action_status` STRING COMMENT 'Current lifecycle status of the mitigation action: assigned (not started), in_progress (underway), pending_review (awaiting approval), completed (finished), overdue (past due date), or cancelled (no longer required).. Valid values are `assigned|in_progress|pending_review|completed|overdue|cancelled`',
    `action_title` STRING COMMENT 'Short descriptive title of the mitigation action for quick identification and reporting.',
    `action_type` STRING COMMENT 'Classification of the mitigation action by control type: preventive (avoid risk), detective (identify occurrence), corrective (fix issue), compensating (alternative control), directive (policy/procedure), or recovery (restore after event).. Valid values are `preventive|detective|corrective|compensating|directive|recovery`',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual financial cost incurred to implement the mitigation action, captured for budget tracking and ROI analysis.',
    `actual_effort_hours` DECIMAL(18,2) COMMENT 'Actual number of hours spent completing the mitigation action, captured for performance tracking and future estimation.',
    `assigned_date` DATE COMMENT 'Date when the mitigation action was formally assigned to the action owner.',
    `completion_date` DATE COMMENT 'Actual date when the mitigation action was completed and closed. Null if action is not yet completed.',
    `completion_evidence` STRING COMMENT 'Description or reference to evidence demonstrating completion of the mitigation action (e.g., document reference, system log, attestation, audit report).',
    `completion_status` STRING COMMENT 'Detailed completion state: not_started (no work done), partial (in progress), complete (finished but not verified), verified (reviewed and approved), or rejected (completion not accepted).. Valid values are `not_started|partial|complete|verified|rejected`',
    `control_effectiveness_rating` STRING COMMENT 'Post-implementation assessment of how effective the mitigation action was in reducing the risk: effective (fully mitigated), partially_effective (some reduction), ineffective (no impact), or not_tested (not yet evaluated).. Valid values are `effective|partially_effective|ineffective|not_tested`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this mitigation action record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for estimated and actual cost amounts (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `due_date` DATE COMMENT 'Target completion date for the mitigation action, used for tracking and escalation.',
    `escalation_date` DATE COMMENT 'Date when the mitigation action was escalated to senior management or the risk committee. Null if no escalation occurred.',
    `escalation_reason` STRING COMMENT 'Explanation of why the mitigation action was escalated (e.g., overdue, insufficient resources, control ineffective, regulatory deadline).',
    `escalation_required` BOOLEAN COMMENT 'Flag indicating whether this mitigation action requires escalation to senior management or the risk committee due to delays, resource constraints, or effectiveness concerns.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Estimated financial cost to implement the mitigation action, including internal labor, external counsel, technology, or other resources.',
    `estimated_effort_hours` DECIMAL(18,2) COMMENT 'Estimated number of hours required to complete the mitigation action, used for resource planning and capacity management.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this mitigation action record was most recently modified, used for audit trail and change tracking.',
    `lpp_applies` BOOLEAN COMMENT 'Flag indicating whether Legal Professional Privilege applies to this mitigation action and its associated documentation, restricting disclosure.',
    `pii_involved` BOOLEAN COMMENT 'Flag indicating whether this mitigation action involves processing or handling of Personally Identifiable Information (PII), triggering additional data protection controls.',
    `regulatory_body` STRING COMMENT 'Name of the regulatory body or governing authority to which this mitigation action must be reported (e.g., ICO, SRA, State Bar, FCA).',
    `regulatory_framework` STRING COMMENT 'Applicable regulatory or compliance framework that this mitigation action addresses (e.g., GDPR, ISO 27001, AML, SOX, SRA Code of Conduct). [ENUM-REF-CANDIDATE: GDPR|ISO_27001|AML|SOX|SRA_Code|CCPA|PCI_DSS|FATF|DPA — promote to reference product]',
    `regulatory_reporting_required` BOOLEAN COMMENT 'Flag indicating whether completion or failure of this mitigation action must be reported to a regulatory body or governing authority.',
    `residual_risk_reassessment_date` DATE COMMENT 'Date when the residual risk was reassessed following completion of this mitigation action. Null if reassessment not yet performed.',
    `residual_risk_reassessment_required` BOOLEAN COMMENT 'Flag indicating whether completion of this action triggers a formal reassessment of the residual risk rating in the risk register.',
    `review_comments` STRING COMMENT 'Comments or notes provided by the reviewer regarding the quality, completeness, or effectiveness of the mitigation action.',
    `review_date` DATE COMMENT 'Date when the completed mitigation action was formally reviewed and verified by the reviewer.',
    CONSTRAINT pk_mitigation_action PRIMARY KEY(`mitigation_action_id`)
) COMMENT 'Transactional record of each risk mitigation or remediation action assigned to address an identified risk or control deficiency. Captures action description, action owner, assigned date, due date, priority, completion status, completion date, evidence of completion, and residual risk re-assessment trigger. Provides the action tracking layer that drives risk reduction workflows and management reporting.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `legal_ecm`.`risk`.`register` ADD CONSTRAINT `fk_risk_register_category_id` FOREIGN KEY (`category_id`) REFERENCES `legal_ecm`.`risk`.`category`(`category_id`);
ALTER TABLE `legal_ecm`.`risk`.`category` ADD CONSTRAINT `fk_risk_category_parent_category_id` FOREIGN KEY (`parent_category_id`) REFERENCES `legal_ecm`.`risk`.`category`(`category_id`);
ALTER TABLE `legal_ecm`.`risk`.`assessment` ADD CONSTRAINT `fk_risk_assessment_category_id` FOREIGN KEY (`category_id`) REFERENCES `legal_ecm`.`risk`.`category`(`category_id`);
ALTER TABLE `legal_ecm`.`risk`.`assessment` ADD CONSTRAINT `fk_risk_assessment_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`risk`.`assessment` ADD CONSTRAINT `fk_risk_assessment_risk_control_id` FOREIGN KEY (`risk_control_id`) REFERENCES `legal_ecm`.`risk`.`risk_control`(`risk_control_id`);
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ADD CONSTRAINT `fk_risk_risk_control_category_id` FOREIGN KEY (`category_id`) REFERENCES `legal_ecm`.`risk`.`category`(`category_id`);
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ADD CONSTRAINT `fk_risk_risk_control_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ADD CONSTRAINT `fk_risk_indemnity_exposure_category_id` FOREIGN KEY (`category_id`) REFERENCES `legal_ecm`.`risk`.`category`(`category_id`);
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ADD CONSTRAINT `fk_risk_indemnity_exposure_pi_claim_id` FOREIGN KEY (`pi_claim_id`) REFERENCES `legal_ecm`.`risk`.`pi_claim`(`pi_claim_id`);
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ADD CONSTRAINT `fk_risk_indemnity_exposure_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ADD CONSTRAINT `fk_risk_pi_claim_category_id` FOREIGN KEY (`category_id`) REFERENCES `legal_ecm`.`risk`.`category`(`category_id`);
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ADD CONSTRAINT `fk_risk_pi_claim_data_breach_incident_id` FOREIGN KEY (`data_breach_incident_id`) REFERENCES `legal_ecm`.`risk`.`data_breach_incident`(`data_breach_incident_id`);
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ADD CONSTRAINT `fk_risk_pi_claim_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ADD CONSTRAINT `fk_risk_data_breach_incident_category_id` FOREIGN KEY (`category_id`) REFERENCES `legal_ecm`.`risk`.`category`(`category_id`);
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ADD CONSTRAINT `fk_risk_data_breach_incident_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ADD CONSTRAINT `fk_risk_mitigation_action_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `legal_ecm`.`risk`.`assessment`(`assessment_id`);
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ADD CONSTRAINT `fk_risk_mitigation_action_category_id` FOREIGN KEY (`category_id`) REFERENCES `legal_ecm`.`risk`.`category`(`category_id`);
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ADD CONSTRAINT `fk_risk_mitigation_action_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ADD CONSTRAINT `fk_risk_mitigation_action_risk_control_id` FOREIGN KEY (`risk_control_id`) REFERENCES `legal_ecm`.`risk`.`risk_control`(`risk_control_id`);

-- ========= TAGS =========
ALTER SCHEMA `legal_ecm`.`risk` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `legal_ecm`.`risk` SET TAGS ('dbx_domain' = 'risk');
ALTER TABLE `legal_ecm`.`risk`.`register` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`risk`.`register` SET TAGS ('dbx_subdomain' = 'risk_governance');
ALTER TABLE `legal_ecm`.`risk`.`register` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register ID');
ALTER TABLE `legal_ecm`.`risk`.`register` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Category Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`risk`.`register` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`risk`.`register` ALTER COLUMN `actual_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Closure Date');
ALTER TABLE `legal_ecm`.`risk`.`register` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm`.`risk`.`register` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `legal_ecm`.`risk`.`register` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `legal_ecm`.`risk`.`register` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'none|risk_owner|practice_group_head|risk_committee|managing_partner|regulator');
ALTER TABLE `legal_ecm`.`risk`.`register` ALTER COLUMN `estimated_financial_exposure` SET TAGS ('dbx_business_glossary_term' = 'Estimated Financial Exposure');
ALTER TABLE `legal_ecm`.`risk`.`register` ALTER COLUMN `estimated_financial_exposure` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`risk`.`register` ALTER COLUMN `exception_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Exception Approved By');
ALTER TABLE `legal_ecm`.`risk`.`register` ALTER COLUMN `exception_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Exception Expiry Date');
ALTER TABLE `legal_ecm`.`risk`.`register` ALTER COLUMN `identified_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Identified Date');
ALTER TABLE `legal_ecm`.`risk`.`register` ALTER COLUMN `inherent_impact` SET TAGS ('dbx_business_glossary_term' = 'Inherent Impact Score');
ALTER TABLE `legal_ecm`.`risk`.`register` ALTER COLUMN `inherent_likelihood` SET TAGS ('dbx_business_glossary_term' = 'Inherent Likelihood Score');
ALTER TABLE `legal_ecm`.`risk`.`register` ALTER COLUMN `inherent_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Inherent Risk Rating');
ALTER TABLE `legal_ecm`.`risk`.`register` ALTER COLUMN `insurance_claim_ref` SET TAGS ('dbx_business_glossary_term' = 'Professional Indemnity Insurance Claim Reference');
ALTER TABLE `legal_ecm`.`risk`.`register` ALTER COLUMN `insurance_claim_ref` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`risk`.`register` ALTER COLUMN `is_exception_approved` SET TAGS ('dbx_business_glossary_term' = 'Exception Approved Flag');
ALTER TABLE `legal_ecm`.`risk`.`register` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `legal_ecm`.`risk`.`register` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `legal_ecm`.`risk`.`register` ALTER COLUMN `lpp_applies` SET TAGS ('dbx_business_glossary_term' = 'Legal Professional Privilege (LPP) Applies Flag');
ALTER TABLE `legal_ecm`.`risk`.`register` ALTER COLUMN `mitigation_description` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Description');
ALTER TABLE `legal_ecm`.`risk`.`register` ALTER COLUMN `mitigation_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`risk`.`register` ALTER COLUMN `mitigation_status` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Status');
ALTER TABLE `legal_ecm`.`risk`.`register` ALTER COLUMN `mitigation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|implemented|overdue|deferred');
ALTER TABLE `legal_ecm`.`risk`.`register` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `legal_ecm`.`risk`.`register` ALTER COLUMN `pii_involved` SET TAGS ('dbx_business_glossary_term' = 'Personally Identifiable Information (PII) Involved Flag');
ALTER TABLE `legal_ecm`.`risk`.`register` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `legal_ecm`.`risk`.`register` ALTER COLUMN `regulatory_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Date');
ALTER TABLE `legal_ecm`.`risk`.`register` ALTER COLUMN `regulatory_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `legal_ecm`.`risk`.`register` ALTER COLUMN `residual_impact` SET TAGS ('dbx_business_glossary_term' = 'Residual Impact Score');
ALTER TABLE `legal_ecm`.`risk`.`register` ALTER COLUMN `residual_likelihood` SET TAGS ('dbx_business_glossary_term' = 'Residual Likelihood Score');
ALTER TABLE `legal_ecm`.`risk`.`register` ALTER COLUMN `residual_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Rating');
ALTER TABLE `legal_ecm`.`risk`.`register` ALTER COLUMN `risk_description` SET TAGS ('dbx_business_glossary_term' = 'Risk Description');
ALTER TABLE `legal_ecm`.`risk`.`register` ALTER COLUMN `risk_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`risk`.`register` ALTER COLUMN `risk_domain` SET TAGS ('dbx_business_glossary_term' = 'Risk Domain');
ALTER TABLE `legal_ecm`.`risk`.`register` ALTER COLUMN `risk_domain` SET TAGS ('dbx_value_regex' = 'enterprise|matter|client|workforce|technology|third_party');
ALTER TABLE `legal_ecm`.`risk`.`register` ALTER COLUMN `risk_ref_code` SET TAGS ('dbx_business_glossary_term' = 'Risk Reference Code');
ALTER TABLE `legal_ecm`.`risk`.`register` ALTER COLUMN `risk_ref_code` SET TAGS ('dbx_value_regex' = '^RSK-[0-9]{4}-[0-9]{5}$');
ALTER TABLE `legal_ecm`.`risk`.`register` ALTER COLUMN `risk_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Status');
ALTER TABLE `legal_ecm`.`risk`.`register` ALTER COLUMN `risk_status` SET TAGS ('dbx_value_regex' = 'open|under_review|mitigated|accepted|escalated|closed');
ALTER TABLE `legal_ecm`.`risk`.`register` ALTER COLUMN `risk_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Risk Sub-Category');
ALTER TABLE `legal_ecm`.`risk`.`register` ALTER COLUMN `risk_title` SET TAGS ('dbx_business_glossary_term' = 'Risk Title');
ALTER TABLE `legal_ecm`.`risk`.`register` ALTER COLUMN `risk_treatment` SET TAGS ('dbx_business_glossary_term' = 'Risk Treatment Strategy');
ALTER TABLE `legal_ecm`.`risk`.`register` ALTER COLUMN `risk_treatment` SET TAGS ('dbx_value_regex' = 'mitigate|accept|transfer|avoid|escalate');
ALTER TABLE `legal_ecm`.`risk`.`register` ALTER COLUMN `risk_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`risk`.`register` ALTER COLUMN `risk_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`risk`.`register` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `legal_ecm`.`risk`.`register` ALTER COLUMN `target_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Target Closure Date');
ALTER TABLE `legal_ecm`.`risk`.`category` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `legal_ecm`.`risk`.`category` SET TAGS ('dbx_subdomain' = 'risk_governance');
ALTER TABLE `legal_ecm`.`risk`.`category` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Category ID');
ALTER TABLE `legal_ecm`.`risk`.`category` ALTER COLUMN `parent_category_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Risk Category ID');
ALTER TABLE `legal_ecm`.`risk`.`category` ALTER COLUMN `aml_relevance_flag` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Relevance Flag');
ALTER TABLE `legal_ecm`.`risk`.`category` ALTER COLUMN `applicable_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Applicable Jurisdiction');
ALTER TABLE `legal_ecm`.`risk`.`category` ALTER COLUMN `applicable_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `legal_ecm`.`risk`.`category` ALTER COLUMN `category_code` SET TAGS ('dbx_business_glossary_term' = 'Risk Category Code');
ALTER TABLE `legal_ecm`.`risk`.`category` ALTER COLUMN `category_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,10}-[0-9]{3}$');
ALTER TABLE `legal_ecm`.`risk`.`category` ALTER COLUMN `category_description` SET TAGS ('dbx_business_glossary_term' = 'Risk Category Description');
ALTER TABLE `legal_ecm`.`risk`.`category` ALTER COLUMN `category_name` SET TAGS ('dbx_business_glossary_term' = 'Risk Category Name');
ALTER TABLE `legal_ecm`.`risk`.`category` ALTER COLUMN `category_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Category Status');
ALTER TABLE `legal_ecm`.`risk`.`category` ALTER COLUMN `category_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|under_review');
ALTER TABLE `legal_ecm`.`risk`.`category` ALTER COLUMN `control_framework_reference` SET TAGS ('dbx_business_glossary_term' = 'Control Framework Reference');
ALTER TABLE `legal_ecm`.`risk`.`category` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`risk`.`category` ALTER COLUMN `cybersecurity_relevance_flag` SET TAGS ('dbx_business_glossary_term' = 'Cybersecurity Relevance Flag');
ALTER TABLE `legal_ecm`.`risk`.`category` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `legal_ecm`.`risk`.`category` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `legal_ecm`.`risk`.`category` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `legal_ecm`.`risk`.`category` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'practice_group|risk_committee|managing_partner|board');
ALTER TABLE `legal_ecm`.`risk`.`category` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Code');
ALTER TABLE `legal_ecm`.`risk`.`category` ALTER COLUMN `governing_body` SET TAGS ('dbx_business_glossary_term' = 'Governing Body');
ALTER TABLE `legal_ecm`.`risk`.`category` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Category Hierarchy Level');
ALTER TABLE `legal_ecm`.`risk`.`category` ALTER COLUMN `hierarchy_path` SET TAGS ('dbx_business_glossary_term' = 'Risk Category Hierarchy Path');
ALTER TABLE `legal_ecm`.`risk`.`category` ALTER COLUMN `inherent_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Inherent Risk Score');
ALTER TABLE `legal_ecm`.`risk`.`category` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`risk`.`category` ALTER COLUMN `last_reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed By');
ALTER TABLE `legal_ecm`.`risk`.`category` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `legal_ecm`.`risk`.`category` ALTER COLUMN `lpp_relevance_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Professional Privilege (LPP) Relevance Flag');
ALTER TABLE `legal_ecm`.`risk`.`category` ALTER COLUMN `matter_type_applicability` SET TAGS ('dbx_business_glossary_term' = 'Matter Type Applicability');
ALTER TABLE `legal_ecm`.`risk`.`category` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `legal_ecm`.`risk`.`category` ALTER COLUMN `notification_deadline_days` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Deadline (Days)');
ALTER TABLE `legal_ecm`.`risk`.`category` ALTER COLUMN `owner_role` SET TAGS ('dbx_business_glossary_term' = 'Risk Category Owner Role');
ALTER TABLE `legal_ecm`.`risk`.`category` ALTER COLUMN `pii_relevance_flag` SET TAGS ('dbx_business_glossary_term' = 'Personally Identifiable Information (PII) Relevance Flag');
ALTER TABLE `legal_ecm`.`risk`.`category` ALTER COLUMN `professional_indemnity_flag` SET TAGS ('dbx_business_glossary_term' = 'Professional Indemnity (PI) Relevance Flag');
ALTER TABLE `legal_ecm`.`risk`.`category` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `legal_ecm`.`risk`.`category` ALTER COLUMN `regulatory_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `legal_ecm`.`risk`.`category` ALTER COLUMN `residual_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Score');
ALTER TABLE `legal_ecm`.`risk`.`category` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Risk Category Review Frequency');
ALTER TABLE `legal_ecm`.`risk`.`category` ALTER COLUMN `review_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual');
ALTER TABLE `legal_ecm`.`risk`.`category` ALTER COLUMN `risk_appetite_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Appetite Level');
ALTER TABLE `legal_ecm`.`risk`.`category` ALTER COLUMN `risk_appetite_level` SET TAGS ('dbx_value_regex' = 'zero_tolerance|low|moderate|open');
ALTER TABLE `legal_ecm`.`risk`.`category` ALTER COLUMN `risk_appetite_threshold` SET TAGS ('dbx_business_glossary_term' = 'Risk Appetite Threshold');
ALTER TABLE `legal_ecm`.`risk`.`category` ALTER COLUMN `risk_domain` SET TAGS ('dbx_business_glossary_term' = 'Risk Domain');
ALTER TABLE `legal_ecm`.`risk`.`category` ALTER COLUMN `risk_impact_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Impact Rating');
ALTER TABLE `legal_ecm`.`risk`.`category` ALTER COLUMN `risk_impact_rating` SET TAGS ('dbx_value_regex' = 'very_low|low|medium|high|very_high');
ALTER TABLE `legal_ecm`.`risk`.`category` ALTER COLUMN `risk_likelihood_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Likelihood Rating');
ALTER TABLE `legal_ecm`.`risk`.`category` ALTER COLUMN `risk_likelihood_rating` SET TAGS ('dbx_value_regex' = 'very_low|low|medium|high|very_high');
ALTER TABLE `legal_ecm`.`risk`.`category` ALTER COLUMN `risk_type` SET TAGS ('dbx_business_glossary_term' = 'Risk Type');
ALTER TABLE `legal_ecm`.`risk`.`category` ALTER COLUMN `risk_type` SET TAGS ('dbx_value_regex' = 'inherent|residual|emerging|systemic');
ALTER TABLE `legal_ecm`.`risk`.`category` ALTER COLUMN `sort_order` SET TAGS ('dbx_business_glossary_term' = 'Sort Order');
ALTER TABLE `legal_ecm`.`risk`.`category` ALTER COLUMN `utbms_task_code` SET TAGS ('dbx_business_glossary_term' = 'Uniform Task-Based Management System (UTBMS) Task Code');
ALTER TABLE `legal_ecm`.`risk`.`category` ALTER COLUMN `utbms_task_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{3}$');
ALTER TABLE `legal_ecm`.`risk`.`assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`risk`.`assessment` SET TAGS ('dbx_subdomain' = 'risk_governance');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment ID');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Asset Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `beneficial_owner_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficial Owner Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Category Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `hearing_id` SET TAGS ('dbx_business_glossary_term' = 'Hearing Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `kyc_record_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Record Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk ID');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `risk_control_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Control Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Date');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Status');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|superseded|closed');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `control_effectiveness_rating` SET TAGS ('dbx_business_glossary_term' = 'Control Effectiveness Rating');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `control_effectiveness_rating` SET TAGS ('dbx_value_regex' = 'ineffective|partially_effective|effective|highly_effective');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'none|practice_group|risk_committee|board');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `estimated_financial_exposure` SET TAGS ('dbx_business_glossary_term' = 'Estimated Financial Exposure');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `estimated_financial_exposure` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `inherent_impact_rating` SET TAGS ('dbx_business_glossary_term' = 'Inherent Impact Rating');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `inherent_impact_rating` SET TAGS ('dbx_value_regex' = 'very_low|low|medium|high|very_high');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `inherent_likelihood_rating` SET TAGS ('dbx_business_glossary_term' = 'Inherent Likelihood Rating');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `inherent_likelihood_rating` SET TAGS ('dbx_value_regex' = 'very_low|low|medium|high|very_high');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `inherent_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Inherent Risk Score');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `is_dpia_required` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Impact Assessment (DPIA) Required Indicator');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `is_lpp_sensitive` SET TAGS ('dbx_business_glossary_term' = 'Legal Professional Privilege (LPP) Sensitive Indicator');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `methodology` SET TAGS ('dbx_business_glossary_term' = 'Assessment Methodology');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `methodology` SET TAGS ('dbx_value_regex' = 'qualitative|quantitative|semi_quantitative');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Notes');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `pii_data_involved` SET TAGS ('dbx_business_glossary_term' = 'Personally Identifiable Information (PII) Data Involved Indicator');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `reference` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Reference Number');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `reference` SET TAGS ('dbx_value_regex' = '^RA-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `residual_impact_rating` SET TAGS ('dbx_business_glossary_term' = 'Residual Impact Rating');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `residual_impact_rating` SET TAGS ('dbx_value_regex' = 'very_low|low|medium|high|very_high');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `residual_likelihood_rating` SET TAGS ('dbx_business_glossary_term' = 'Residual Likelihood Rating');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `residual_likelihood_rating` SET TAGS ('dbx_value_regex' = 'very_low|low|medium|high|very_high');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `residual_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Score');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `review_cycle` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `review_cycle` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|ad_hoc');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `risk_description` SET TAGS ('dbx_business_glossary_term' = 'Risk Description');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `risk_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `risk_domain` SET TAGS ('dbx_business_glossary_term' = 'Risk Domain');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `risk_score_scale` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Scale');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `risk_score_scale` SET TAGS ('dbx_value_regex' = '1_to_5|1_to_10|1_to_25');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `risk_title` SET TAGS ('dbx_business_glossary_term' = 'Risk Title');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `risk_treatment_option` SET TAGS ('dbx_business_glossary_term' = 'Risk Treatment Option');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `risk_treatment_option` SET TAGS ('dbx_value_regex' = 'accept|mitigate|transfer|avoid');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `risk_treatment_option` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `risk_treatment_option` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `sanctions_flag` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Flag');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `treatment_description` SET TAGS ('dbx_business_glossary_term' = 'Risk Treatment Description');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `treatment_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `treatment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Treatment Due Date');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `treatment_due_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `treatment_due_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`risk`.`assessment` ALTER COLUMN `within_appetite` SET TAGS ('dbx_business_glossary_term' = 'Within Risk Appetite Indicator');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` SET TAGS ('dbx_subdomain' = 'risk_governance');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `risk_control_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Control ID');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Category Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Item ID');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `automation_flag` SET TAGS ('dbx_business_glossary_term' = 'Control Automation Flag');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `control_description` SET TAGS ('dbx_business_glossary_term' = 'Control Description');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `control_name` SET TAGS ('dbx_business_glossary_term' = 'Control Name');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `control_type` SET TAGS ('dbx_business_glossary_term' = 'Control Type');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `control_type` SET TAGS ('dbx_value_regex' = 'preventive|detective|corrective|deterrent|compensating|directive');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `deficiency_description` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Description');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `design_effectiveness_rating` SET TAGS ('dbx_business_glossary_term' = 'Design Effectiveness Rating');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `design_effectiveness_rating` SET TAGS ('dbx_value_regex' = 'adequate|inadequate|not_assessed');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `domain` SET TAGS ('dbx_business_glossary_term' = 'Control Domain');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `evidence_reference` SET TAGS ('dbx_business_glossary_term' = 'Evidence Reference');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `gdpr_relevant_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Relevant Flag');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Implementation Date');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `implementation_status` SET TAGS ('dbx_business_glossary_term' = 'Implementation Status');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `implementation_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|implemented|deferred|not_applicable');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `inherent_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Inherent Risk Rating');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `inherent_risk_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|negligible');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `iso_annex_a_reference` SET TAGS ('dbx_business_glossary_term' = 'ISO 27001 Annex A Reference');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `iso_annex_a_reference` SET TAGS ('dbx_value_regex' = '^A.[0-9]{1,2}.[0-9]{1,2}(.[0-9]{1,2})?$');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `iso_soa_included_flag` SET TAGS ('dbx_business_glossary_term' = 'ISO 27001 Statement of Applicability (SoA) Included Flag');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `last_test_date` SET TAGS ('dbx_business_glossary_term' = 'Last Test Date');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `last_test_outcome` SET TAGS ('dbx_business_glossary_term' = 'Last Test Outcome');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `last_test_outcome` SET TAGS ('dbx_value_regex' = 'pass|fail|partial_pass|not_applicable');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `lpp_scope_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Professional Privilege (LPP) Scope Flag');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `operational_effectiveness_rating` SET TAGS ('dbx_business_glossary_term' = 'Operational Effectiveness Rating');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `operational_effectiveness_rating` SET TAGS ('dbx_value_regex' = 'effective|partially_effective|ineffective|not_tested');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `pii_scope_flag` SET TAGS ('dbx_business_glossary_term' = 'Personally Identifiable Information (PII) Scope Flag');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Control Priority');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `reference_code` SET TAGS ('dbx_business_glossary_term' = 'Control Reference Code');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `reference_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}-[A-Z0-9]{2,10}-[0-9]{3,6}$');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `remediation_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Completed Date');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `remediation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Remediation Required Flag');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'not_required|open|in_progress|completed|overdue');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `residual_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Rating');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `residual_risk_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|negligible');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `review_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|ad_hoc');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `soa_exclusion_justification` SET TAGS ('dbx_business_glossary_term' = 'Statement of Applicability (SoA) Exclusion Justification');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `sra_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Solicitors Regulation Authority (SRA) Reportable Flag');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `test_methodology` SET TAGS ('dbx_business_glossary_term' = 'Test Methodology');
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ALTER COLUMN `test_methodology` SET TAGS ('dbx_value_regex' = 'inquiry|observation|inspection|re_performance|walkthrough|automated_scan');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` SET TAGS ('dbx_subdomain' = 'indemnity_claims');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `indemnity_exposure_id` SET TAGS ('dbx_business_glossary_term' = 'Professional Indemnity (PI) Exposure ID');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Asset Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Category Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `check_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check ID');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `indemnity_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Indemnity Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `pi_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Pi Claim Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `termination_id` SET TAGS ('dbx_business_glossary_term' = 'Termination Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `estimated_claim_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Claim Value');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `estimated_claim_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `excess_amount` SET TAGS ('dbx_business_glossary_term' = 'Policy Excess Amount');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `excess_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `exposure_narrative` SET TAGS ('dbx_business_glossary_term' = 'Exposure Narrative');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `exposure_narrative` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `exposure_reference` SET TAGS ('dbx_business_glossary_term' = 'Professional Indemnity (PI) Exposure Reference Number');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `exposure_reference` SET TAGS ('dbx_value_regex' = '^PI-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `exposure_status` SET TAGS ('dbx_business_glossary_term' = 'Professional Indemnity (PI) Exposure Status');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `exposure_status` SET TAGS ('dbx_value_regex' = 'identified|notified|under_investigation|reserved|closed|litigated');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `external_counsel_engaged_flag` SET TAGS ('dbx_business_glossary_term' = 'External Counsel Engaged Flag');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `external_counsel_firm` SET TAGS ('dbx_business_glossary_term' = 'External Counsel Firm Name');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `identified_date` SET TAGS ('dbx_business_glossary_term' = 'Exposure Identified Date');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `insurer_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Insurer Notification Date');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `insurer_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurer Notified Flag');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `internal_investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Internal Investigation Status');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `internal_investigation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|escalated');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `investigation_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Internal Investigation Completed Date');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `limitation_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Limitation Period Expiry Date');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `lpp_applies_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Professional Privilege (LPP) Applies Flag');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `matter_close_date` SET TAGS ('dbx_business_glossary_term' = 'Underlying Matter Close Date');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `pi_renewal_submission_flag` SET TAGS ('dbx_business_glossary_term' = 'Professional Indemnity (PI) Renewal Submission Flag');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `practice_area` SET TAGS ('dbx_business_glossary_term' = 'Practice Area');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `regulatory_referral_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Referral Flag');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `reputational_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Reputational Risk Flag');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Reserve Amount');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `reserve_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `reserve_last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Reserve Last Reviewed Date');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `risk_severity` SET TAGS ('dbx_business_glossary_term' = 'Risk Severity Rating');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `risk_severity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'process_failure|supervision_failure|communication_failure|knowledge_gap|system_error|external_factor');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'elite_3e|manual_entry|risk_register|intapp_conflicts');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` SET TAGS ('dbx_subdomain' = 'indemnity_claims');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `pi_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Professional Indemnity (PI) Claim ID');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Category Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `data_breach_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Data Breach Incident Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `indemnity_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Indemnity Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `adr_method` SET TAGS ('dbx_business_glossary_term' = 'Alternative Dispute Resolution (ADR) Method');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `adr_method` SET TAGS ('dbx_value_regex' = 'none|mediation|arbitration|expert_determination|negotiation');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `alleged_breach_date` SET TAGS ('dbx_business_glossary_term' = 'Alleged Breach Date');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `alleged_breach_description` SET TAGS ('dbx_business_glossary_term' = 'Alleged Breach Description');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `alleged_breach_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `claim_amount` SET TAGS ('dbx_business_glossary_term' = 'PI Claim Amount');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `claim_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `claim_currency` SET TAGS ('dbx_business_glossary_term' = 'PI Claim Currency');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `claim_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `claim_date` SET TAGS ('dbx_business_glossary_term' = 'PI Claim Date');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `claim_outcome` SET TAGS ('dbx_business_glossary_term' = 'PI Claim Outcome');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `claim_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Professional Indemnity (PI) Claim Reference Number');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `claim_reference_number` SET TAGS ('dbx_value_regex' = '^PI-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `claim_status` SET TAGS ('dbx_business_glossary_term' = 'PI Claim Status');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `claimant_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Claimant Jurisdiction');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `claimant_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `claimant_name` SET TAGS ('dbx_business_glossary_term' = 'Claimant Name');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `claimant_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `claimant_name` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `claimant_type` SET TAGS ('dbx_business_glossary_term' = 'Claimant Type');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `claimant_type` SET TAGS ('dbx_value_regex' = 'client|third_party|counterparty|regulatory_body|other');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'PI Claim Closure Date');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `coverage_confirmed` SET TAGS ('dbx_business_glossary_term' = 'PI Coverage Confirmed Flag');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `coverage_denial_reason` SET TAGS ('dbx_business_glossary_term' = 'PI Coverage Denial Reason');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `coverage_denial_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'PI Policy Deductible Amount');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `defence_costs_incurred` SET TAGS ('dbx_business_glossary_term' = 'PI Defence Costs Incurred');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `defence_costs_incurred` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `ethical_wall_required` SET TAGS ('dbx_business_glossary_term' = 'Ethical Wall Required Flag');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `insurer_claim_reference` SET TAGS ('dbx_business_glossary_term' = 'Insurer Claim Reference Number');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `limitation_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Limitation Period Expiry Date');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `lpp_applies` SET TAGS ('dbx_business_glossary_term' = 'Legal Professional Privilege (LPP) Applies Flag');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'PI Claim Notes');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Insurer Notification Date');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `pii_data_involved` SET TAGS ('dbx_business_glossary_term' = 'Personally Identifiable Information (PII) Data Involved Flag');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `practice_area` SET TAGS ('dbx_business_glossary_term' = 'Practice Area');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `regulatory_report_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Date');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `regulatory_report_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Required Flag');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'PI Claim Reserve Amount');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `reserve_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'PI Settlement Amount');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'PI Settlement Date');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` SET TAGS ('dbx_subdomain' = 'indemnity_claims');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ALTER COLUMN `data_breach_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Data Breach Incident Identifier');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Category Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ALTER COLUMN `affected_system` SET TAGS ('dbx_business_glossary_term' = 'Affected System');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ALTER COLUMN `breach_severity` SET TAGS ('dbx_business_glossary_term' = 'Breach Severity');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ALTER COLUMN `breach_severity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ALTER COLUMN `breach_source` SET TAGS ('dbx_business_glossary_term' = 'Breach Source');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ALTER COLUMN `breach_source` SET TAGS ('dbx_value_regex' = 'internal|external|third_party|unknown');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ALTER COLUMN `client_data_flag` SET TAGS ('dbx_business_glossary_term' = 'Client Data Compromised Flag');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ALTER COLUMN `containment_date` SET TAGS ('dbx_business_glossary_term' = 'Containment Date');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ALTER COLUMN `data_categories_involved` SET TAGS ('dbx_business_glossary_term' = 'Data Categories Involved');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ALTER COLUMN `data_subject_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Notification Date');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ALTER COLUMN `data_subject_notification_method` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Notification Method');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ALTER COLUMN `data_subject_notification_method` SET TAGS ('dbx_value_regex' = 'email|postal_mail|phone|public_notice|not_applicable');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ALTER COLUMN `data_subject_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Notification Required Flag');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ALTER COLUMN `data_subjects_affected_count` SET TAGS ('dbx_business_glossary_term' = 'Data Subjects Affected Count');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ALTER COLUMN `discovered_by` SET TAGS ('dbx_business_glossary_term' = 'Discovered By');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ALTER COLUMN `discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Discovery Date');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ALTER COLUMN `discovery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Discovery Timestamp');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ALTER COLUMN `dpo_notified_date` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Officer (DPO) Notified Date');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ALTER COLUMN `estimated_financial_impact` SET TAGS ('dbx_business_glossary_term' = 'Estimated Financial Impact');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ALTER COLUMN `estimated_financial_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ALTER COLUMN `external_counsel_engaged_flag` SET TAGS ('dbx_business_glossary_term' = 'External Counsel Engaged Flag');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ALTER COLUMN `forensic_investigation_flag` SET TAGS ('dbx_business_glossary_term' = 'Forensic Investigation Flag');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ALTER COLUMN `gdpr_72_hour_deadline` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) 72-Hour Notification Deadline');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ALTER COLUMN `ico_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Information Commissioners Office (ICO) Notification Date');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ALTER COLUMN `ico_notification_status` SET TAGS ('dbx_business_glossary_term' = 'Information Commissioners Office (ICO) Notification Status');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ALTER COLUMN `ico_notification_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|submitted|acknowledged|under_review|closed');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ALTER COLUMN `ico_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Information Commissioners Office (ICO) Reference Number');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ALTER COLUMN `incident_owner` SET TAGS ('dbx_business_glossary_term' = 'Incident Owner');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ALTER COLUMN `incident_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Reference Number');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ALTER COLUMN `incident_reference_number` SET TAGS ('dbx_value_regex' = '^DBI-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Status');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_value_regex' = 'reported|under_investigation|contained|remediated|closed|regulatory_notified');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ALTER COLUMN `insurance_claim_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Claim Filed Flag');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ALTER COLUMN `insurance_claim_reference` SET TAGS ('dbx_business_glossary_term' = 'Insurance Claim Reference');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ALTER COLUMN `law_enforcement_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Notified Flag');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ALTER COLUMN `law_enforcement_reference` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Reference');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ALTER COLUMN `lpp_protected_data_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Professional Privilege (LPP) Protected Data Flag');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ALTER COLUMN `notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required Flag');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ALTER COLUMN `pii_compromised_flag` SET TAGS ('dbx_business_glossary_term' = 'Personally Identifiable Information (PII) Compromised Flag');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ALTER COLUMN `remediation_actions_taken` SET TAGS ('dbx_business_glossary_term' = 'Remediation Actions Taken');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ALTER COLUMN `special_category_data_flag` SET TAGS ('dbx_business_glossary_term' = 'Special Category Data Compromised Flag');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` SET TAGS ('dbx_subdomain' = 'risk_governance');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `matter_risk_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Risk Profile ID');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `kyc_record_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Record Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `aml_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Risk Flag');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `client_credit_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Client Credit Risk Rating');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `client_payment_history_flag` SET TAGS ('dbx_business_glossary_term' = 'Client Payment History Flag');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `client_payment_history_flag` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|new_client');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `conflict_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Conflict Risk Level');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `conflict_risk_level` SET TAGS ('dbx_value_regex' = 'none|low|medium|high');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `cross_border_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Border Flag');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `cybersecurity_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Cybersecurity Risk Level');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `cybersecurity_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `ediscovery_volume_exposure` SET TAGS ('dbx_business_glossary_term' = 'Electronic Discovery (eDiscovery) Volume Exposure');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `ediscovery_volume_exposure` SET TAGS ('dbx_value_regex' = 'none|low|medium|high|very_high');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `escalation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `esi_volume_gb` SET TAGS ('dbx_business_glossary_term' = 'Electronically Stored Information (ESI) Volume in Gigabytes (GB)');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `estimated_matter_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Matter Value');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `estimated_matter_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `insurance_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Notification Date');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `insurance_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Notification Required Flag');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `jurisdictional_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Jurisdictional Risk Level');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `jurisdictional_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `lpp_sensitivity_level` SET TAGS ('dbx_business_glossary_term' = 'Legal Professional Privilege (LPP) Sensitivity Level');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `lpp_sensitivity_level` SET TAGS ('dbx_value_regex' = 'standard|elevated|high|critical');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `matter_complexity_rating` SET TAGS ('dbx_business_glossary_term' = 'Matter Complexity Rating');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `matter_complexity_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `matter_value_currency` SET TAGS ('dbx_business_glossary_term' = 'Matter Value Currency');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `matter_value_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `media_exposure_likelihood` SET TAGS ('dbx_business_glossary_term' = 'Media Exposure Likelihood');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `media_exposure_likelihood` SET TAGS ('dbx_value_regex' = 'none|low|medium|high|very_high');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Risk Profile Notes');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `overall_risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Overall Risk Tier');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `overall_risk_tier` SET TAGS ('dbx_value_regex' = 'green|amber|red');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `pii_data_volume_category` SET TAGS ('dbx_business_glossary_term' = 'Personally Identifiable Information (PII) Data Volume Category');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `pii_data_volume_category` SET TAGS ('dbx_value_regex' = 'none|minimal|moderate|substantial|extensive');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `primary_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Primary Jurisdiction');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `primary_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `professional_indemnity_exposure` SET TAGS ('dbx_business_glossary_term' = 'Professional Indemnity Exposure');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `professional_indemnity_exposure` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `profile_created_date` SET TAGS ('dbx_business_glossary_term' = 'Profile Created Date');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `profile_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Profile Created Timestamp');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `profile_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Profile Reference Number');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `profile_reference_number` SET TAGS ('dbx_value_regex' = '^MRP-[0-9]{8}$');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_business_glossary_term' = 'Profile Status');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_value_regex' = 'draft|active|under_review|escalated|closed|archived');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `regulatory_scrutiny_level` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Scrutiny Level');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `regulatory_scrutiny_level` SET TAGS ('dbx_value_regex' = 'none|low|medium|high|critical');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `reputational_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Reputational Risk Rating');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `reputational_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `risk_mitigation_plan` SET TAGS ('dbx_business_glossary_term' = 'Risk Mitigation Plan');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `sanctions_screening_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Required Flag');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `special_category_data_flag` SET TAGS ('dbx_business_glossary_term' = 'Special Category Data Flag');
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ALTER COLUMN `third_party_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Risk Flag');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` SET TAGS ('dbx_subdomain' = 'risk_governance');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ALTER COLUMN `mitigation_action_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Mitigation Action ID');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ALTER COLUMN `assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Assessment Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Asset Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Category Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ALTER COLUMN `kyc_record_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Record Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk ID');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ALTER COLUMN `risk_control_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Control Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ALTER COLUMN `action_description` SET TAGS ('dbx_business_glossary_term' = 'Action Description');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ALTER COLUMN `action_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Action Owner Name');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ALTER COLUMN `action_priority` SET TAGS ('dbx_business_glossary_term' = 'Action Priority');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ALTER COLUMN `action_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ALTER COLUMN `action_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Action Reference Number');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ALTER COLUMN `action_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{4,8}$');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ALTER COLUMN `action_status` SET TAGS ('dbx_business_glossary_term' = 'Action Status');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ALTER COLUMN `action_status` SET TAGS ('dbx_value_regex' = 'assigned|in_progress|pending_review|completed|overdue|cancelled');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ALTER COLUMN `action_title` SET TAGS ('dbx_business_glossary_term' = 'Action Title');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Action Type');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ALTER COLUMN `action_type` SET TAGS ('dbx_value_regex' = 'preventive|detective|corrective|compensating|directive|recovery');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ALTER COLUMN `actual_effort_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Effort Hours');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ALTER COLUMN `assigned_date` SET TAGS ('dbx_business_glossary_term' = 'Assigned Date');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ALTER COLUMN `completion_evidence` SET TAGS ('dbx_business_glossary_term' = 'Completion Evidence');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Completion Status');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ALTER COLUMN `completion_status` SET TAGS ('dbx_value_regex' = 'not_started|partial|complete|verified|rejected');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ALTER COLUMN `control_effectiveness_rating` SET TAGS ('dbx_business_glossary_term' = 'Control Effectiveness Rating');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ALTER COLUMN `control_effectiveness_rating` SET TAGS ('dbx_value_regex' = 'effective|partially_effective|ineffective|not_tested');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ALTER COLUMN `escalation_required` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ALTER COLUMN `estimated_effort_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Effort Hours');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ALTER COLUMN `lpp_applies` SET TAGS ('dbx_business_glossary_term' = 'Legal Professional Privilege (LPP) Applies');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ALTER COLUMN `pii_involved` SET TAGS ('dbx_business_glossary_term' = 'Personally Identifiable Information (PII) Involved');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ALTER COLUMN `regulatory_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ALTER COLUMN `residual_risk_reassessment_date` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Reassessment Date');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ALTER COLUMN `residual_risk_reassessment_required` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Reassessment Required');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ALTER COLUMN `review_comments` SET TAGS ('dbx_business_glossary_term' = 'Review Comments');
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
