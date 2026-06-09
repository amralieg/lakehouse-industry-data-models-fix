-- Schema for Domain: contract | Business: Legal | Version: v1_mvm
-- Generated on: 2026-05-07 14:36:18

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `legal_ecm`.`contract` COMMENT 'Governs the full Contract Lifecycle Management (CLM) pipeline for both client-facing engagement letters (LOE, POA, SPA, NDA) and firm vendor/supplier agreements. Owns contract templates, obligation tracking, milestone alerts, renewal management, and executed agreement metadata. Distinct from the matter domain — contract owns the agreement artifact; matter owns the work performed under it.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `legal_ecm`.`contract`.`agreement` (
    `agreement_id` BIGINT COMMENT 'Unique identifier for the agreement record. Primary key for the agreement entity.',
    `agreement_type_id` BIGINT COMMENT 'Foreign key linking to contract.agreement_type. Business justification: Agreement has a STRING column agreement_type that should be normalized to FK to the agreement_type reference table. This is a standard reference data normalization pattern. The agreement_type refere',
    `aml_kyc_program_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_kyc_program. Business justification: Each contract agreement is subject to AML/KYC screening under a specific program. Agreement-level linkage to the governing AML/KYC program is required for MLRO audit trails, regulatory examination res',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Agreements must conform to firm compliance policies (conflicts policy, client acceptance policy, fee arrangement policy). Contract approval workflows verify policy compliance before execution. Essenti',
    `contact_id` BIGINT COMMENT 'Foreign key linking to client.client_contact. Business justification: Legal operations require identifying the designated client-side contact for each contract agreement for execution notifications, amendment communications, and renewal approvals. A legal services domai',
    `data_privacy_register_id` BIGINT COMMENT 'Foreign key linking to compliance.data_privacy_register. Business justification: Data processing agreements and contracts involving personal data processing must be traceable to the relevant data privacy register entry — a direct GDPR Article 30 requirement. DPOs and compliance te',
    `delivery_model_id` BIGINT COMMENT 'Foreign key linking to service.delivery_model. Business justification: Delivery model (onshore, offshore, managed service) is a contractual commitment governing how services are rendered. Linking enables resource planning, SLA compliance monitoring, and delivery model pe',
    `engagement_opportunity_id` BIGINT COMMENT 'Foreign key linking to intake.engagement_opportunity. Business justification: Executed agreements link back to originating business development opportunities for win/loss analysis, origination credit allocation, pipeline conversion metrics, and estimated-vs-actual value trackin',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to matter.jurisdiction. Business justification: contract_agreement has a plain text jurisdiction attribute (denormalized). Normalizing to matter.jurisdiction enables jurisdiction-based contract compliance reporting, choice-of-law analysis, and re',
    `kyc_record_id` BIGINT COMMENT 'Foreign key linking to client.kyc_record. Business justification: AML/KYC regulatory compliance requires traceability: which specific KYC record cleared a contract agreement for execution. contract_agreement has aml_kyc_verified_flag but no FK to the authorizing kyc',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: Agreements implement specific legal service offerings from the firms service catalog. Essential for revenue attribution by service line, service performance analytics, and cross-sell analysis. Legal ',
    `matter_id` BIGINT COMMENT 'Reference to the matter under which this agreement is executed or managed. Nullable for firm vendor agreements not tied to client matters.',
    `outside_counsel_guideline_id` BIGINT COMMENT 'Foreign key linking to client.outside_counsel_guideline. Business justification: Outside counsel guidelines (OCGs) govern billing rates, staffing restrictions, and reporting requirements for each engagement. A contract agreement (panel appointment, engagement letter) must referenc',
    `package_id` BIGINT COMMENT 'Foreign key linking to service.package. Business justification: Legal service contracts are frequently structured around a defined service package (e.g., bundled M&A advisory). Linking enables package utilization reporting, scope management, and cross-sell analysi',
    `parent_agreement_contract_agreement_id` BIGINT COMMENT 'Reference to the parent or master agreement if this is a subsidiary agreement, amendment, or SOW. Nullable for standalone agreements.',
    `pricing_model_id` BIGINT COMMENT 'Foreign key linking to service.pricing_model. Business justification: Agreements must reference their governing pricing model (hourly, fixed-fee, contingency, blended rate) for billing system integration, fee arrangement compliance audits, and financial reporting. Core ',
    `profile_id` BIGINT COMMENT 'Reference to the client party who is a counterparty to this agreement.',
    `rate_card_id` BIGINT COMMENT 'Foreign key linking to service.rate_card. Business justification: Contract agreements are priced against a negotiated rate card. Linking enables billing reconciliation, rate compliance audits, and client billing guideline enforcement — a core legal billing operation',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Contracts inherently carry risks (indemnity exposure, liability caps, regulatory compliance) tracked in risk registers for PI insurance underwriting, matter risk profiling, and breach prevention. Esse',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Agreements must comply with specific regulatory obligations (GDPR data processing requirements, AML client acceptance rules, SRA engagement terms). Legal teams track which regulatory obligations each ',
    `rfp_submission_id` BIGINT COMMENT 'Foreign key linking to intake.rfp_submission. Business justification: Contract agreements resulting from won RFPs must be traceable to the originating rfp_submission for business development reporting, fee arrangement validation, and panel appointment audit. Legal-servi',
    `sla_template_id` BIGINT COMMENT 'Foreign key linking to service.sla_template. Business justification: Contract agreements incorporate specific SLA commitments (response times, turnaround targets, breach thresholds). Linking to sla_template enables SLA breach monitoring, client reporting, and regulator',
    `template_id` BIGINT COMMENT 'Reference to the contract template from which this agreement was generated. Nullable for bespoke agreements.',
    `tier_id` BIGINT COMMENT 'Foreign key linking to service.tier. Business justification: Client service tier (Platinum, Gold, Standard) is a contractual commitment determining pricing levels, SLA standards, and partner involvement. Linking enables tier-compliance reporting and ensures con',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the agreement, used in correspondence and filings.',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the agreement within the CLM pipeline. [ENUM-REF-CANDIDATE: Draft|Under Review|Pending Execution|Executed|Active|Suspended|Terminated|Expired|Cancelled — 9 candidates stripped; promote to reference product]',
    `amendment_count` STRING COMMENT 'Total number of formal amendments executed against this agreement.',
    `aml_kyc_verified_flag` BOOLEAN COMMENT 'Indicates whether AML and KYC checks have been completed and verified for the counterparty prior to agreement execution.',
    `approval_date` DATE COMMENT 'Date on which the agreement received final internal approval.',
    `approval_status` STRING COMMENT 'Current approval status of the agreement within the internal review and authorization workflow.. Valid values are `Pending Approval|Approved|Rejected|Conditional Approval`',
    `approved_by` STRING COMMENT 'Name or identifier of the individual who provided final approval for the agreement.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the agreement automatically renews upon expiry unless terminated.',
    `confidentiality_classification` STRING COMMENT 'Data classification level assigned to the agreement document and its contents.. Valid values are `Public|Internal|Confidential|Restricted|Highly Restricted`',
    `contract_value` DECIMAL(18,2) COMMENT 'Total monetary value of the agreement as stated in the contract terms. Nullable for non-monetary agreements.',
    `counterparty_name` STRING COMMENT 'Legal name of the counterparty organization or individual who is the other signatory to the agreement.',
    `counterparty_type` STRING COMMENT 'Classification of the counterparty by relationship type to the firm. [ENUM-REF-CANDIDATE: Client|Vendor|Supplier|Partner|Government Entity|Individual|Other — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the contract value (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `dispute_resolution_method` STRING COMMENT 'Method of dispute resolution specified in the agreement. ADR (Alternative Dispute Resolution), ICC (International Chamber of Commerce), LCIA (London Court of International Arbitration). [ENUM-REF-CANDIDATE: Litigation|Arbitration|Mediation|ADR|ICC|LCIA|Other — 7 candidates stripped; promote to reference product]',
    `document_storage_path` STRING COMMENT 'File path or URI to the executed agreement document in the Document Management System (DMS).',
    `effective_date` DATE COMMENT 'Date on which the agreement becomes legally binding and enforceable.',
    `execution_date` DATE COMMENT 'Date on which the agreement was signed by all parties.',
    `expiry_date` DATE COMMENT 'Date on which the agreement terminates or expires. Nullable for open-ended or perpetual agreements.',
    `gdpr_compliant_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes GDPR-compliant data processing terms and clauses.',
    `governing_law` STRING COMMENT 'Jurisdiction and legal framework under which the agreement is governed (e.g., New York Law, English Law, Delaware Law).',
    `indemnity_clause_flag` BOOLEAN COMMENT 'Indicates whether the agreement contains an indemnity or hold-harmless clause.',
    `limitation_of_liability_flag` BOOLEAN COMMENT 'Indicates whether the agreement contains a limitation of liability clause.',
    `lpp_flag` BOOLEAN COMMENT 'Indicates whether the agreement is protected by Legal Professional Privilege and subject to attorney-client confidentiality.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the agreement record was last modified or updated.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to the agreement.',
    `originating_office` STRING COMMENT 'Firm office or practice location that originated and owns this agreement.',
    `renewal_notice_days` STRING COMMENT 'Number of days prior to expiry that renewal notice must be provided. Nullable if not applicable.',
    `termination_date` DATE COMMENT 'Actual date on which the agreement was terminated prior to its natural expiry. Nullable if not terminated early.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required for termination as specified in the agreement terms.',
    `title` STRING COMMENT 'Descriptive title or subject line of the agreement as it appears on the executed document.',
    `version_number` STRING COMMENT 'Version number of the agreement document, incremented with each amendment or revision.',
    CONSTRAINT pk_agreement PRIMARY KEY(`agreement_id`)
) COMMENT 'Master record for every executed or in-progress contract artifact owned by the firm, covering client-facing instruments (LOE, NDA, SPA, POA) and firm vendor/supplier agreements. SSOT for agreement identity, counterparty references, effective/expiry dates, governing law, jurisdiction, contract value, currency, confidentiality classification, LPP flag, execution status, and CLM stage.';

CREATE OR REPLACE TABLE `legal_ecm`.`contract`.`agreement_type` (
    `agreement_type_id` BIGINT COMMENT 'Unique identifier for the agreement type. Primary key for the agreement type reference table.',
    `pricing_model_id` BIGINT COMMENT 'Foreign key linking to service.pricing_model. Business justification: Agreement types have default pricing models that auto-populate during engagement letter generation. Supports template configuration, new matter intake automation, and ensures consistent fee arrangemen',
    `sla_template_id` BIGINT COMMENT 'Foreign key linking to service.sla_template. Business justification: Each agreement type (MSA, Retainer, NDA) has default SLA commitments. Linking to a default sla_template enables automated SLA assignment during contract creation, ensuring consistency across all contr',
    `agreement_type_category` STRING COMMENT 'High-level classification of the agreement type by business function: client engagement (LOE, retainer), vendor/supplier (MSA, SOW), internal administrative, regulatory compliance, intellectual property (IP licensing, PCT filings), or dispute resolution (ADR, arbitration).. Valid values are `client_engagement|vendor_supplier|internal_administrative|regulatory_compliance|intellectual_property|dispute_resolution`',
    `aml_kyc_required` BOOLEAN COMMENT 'Indicates whether agreements of this type require Anti-Money Laundering (AML) and Know Your Client (KYC) checks before execution. True if AML/KYC is mandatory; False otherwise.',
    `approval_workflow_required` BOOLEAN COMMENT 'Indicates whether agreements of this type require formal approval workflow (e.g., partner sign-off, risk committee review) before execution. True if approval workflow is mandatory; False otherwise.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether agreements of this type typically include automatic renewal provisions. True if auto-renewal is standard; False otherwise.',
    `confidentiality_level` STRING COMMENT 'Default confidentiality classification for agreements of this type: public, internal, confidential, highly confidential, or attorney-client privileged (covered by Legal Professional Privilege - LPP).. Valid values are `public|internal|confidential|highly_confidential|attorney_client_privileged`',
    `conflict_check_required` BOOLEAN COMMENT 'Indicates whether agreements of this type require a conflict of interest check before execution. True if conflict checking is mandatory (typical for client engagements); False otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this agreement type record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `default_dispute_resolution` STRING COMMENT 'Standard dispute resolution mechanism for this agreement type: litigation (court proceedings), arbitration (binding arbitration under ICC, LCIA, or other rules), mediation (facilitated negotiation), or negotiation (direct party-to-party resolution).. Valid values are `litigation|arbitration|mediation|negotiation`',
    `default_governing_law` STRING COMMENT 'Default jurisdiction whose laws govern agreements of this type (e.g., New York, England and Wales, Delaware). Null if no standard governing law applies.',
    `default_notice_period_days` STRING COMMENT 'Standard number of days required for termination or non-renewal notice for this agreement type. Null if no standard notice period applies.',
    `default_term_months` STRING COMMENT 'Standard duration in months for this agreement type. Null if the agreement type does not have a standard term (e.g., perpetual agreements or one-time transactions).',
    `effective_end_date` DATE COMMENT 'Date on which this agreement type was retired or deprecated. Null if the agreement type is still active. Format: yyyy-MM-dd.',
    `effective_start_date` DATE COMMENT 'Date from which this agreement type became available for use in the firms contract lifecycle management system. Format: yyyy-MM-dd.',
    `electronic_signature_allowed` BOOLEAN COMMENT 'Indicates whether agreements of this type can be executed using electronic signatures (e.g., DocuSign, Adobe Sign). True if electronic signature is legally acceptable; False if wet signature is required.',
    `financial_threshold_usd` DECIMAL(18,2) COMMENT 'Monetary threshold in USD above which agreements of this type require additional approval or review (e.g., partner sign-off for engagements over $100,000). Null if no financial threshold applies.',
    `frand_applicable` BOOLEAN COMMENT 'Indicates whether agreements of this type are subject to Fair Reasonable and Non-Discriminatory (FRAND) licensing terms, typically for standard-essential patents. True if FRAND terms apply; False otherwise.',
    `gdpr_applicable` BOOLEAN COMMENT 'Indicates whether agreements of this type typically involve processing of personal data subject to GDPR. True if GDPR compliance clauses are standard; False otherwise.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this agreement type is currently active and available for use in new agreements. True if active; False if deprecated or retired.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this agreement type record was last updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `ledes_billing_code` STRING COMMENT 'LEDES billing code associated with this agreement type for electronic invoice submission. Null if no specific LEDES code applies.. Valid values are `^[A-Z0-9]{1,10}$`',
    `milestone_tracking_required` BOOLEAN COMMENT 'Indicates whether agreements of this type require milestone and obligation tracking (e.g., deliverable dates, payment schedules, renewal dates). True if milestone tracking is standard; False otherwise.',
    `party_type` STRING COMMENT 'Indicates whether the agreement type is typically bilateral (two parties), multilateral (more than two parties), or unilateral (one party with obligations).. Valid values are `bilateral|multilateral|unilateral`',
    `requires_countersignature` BOOLEAN COMMENT 'Indicates whether agreements of this type require countersignature by the counterparty to be legally binding. True if countersignature is required; False if unilateral execution is sufficient.',
    `requires_notarization` BOOLEAN COMMENT 'Indicates whether agreements of this type require notarization or witnessing to be legally enforceable. True if notarization is required; False otherwise.',
    `retention_period_years` STRING COMMENT 'Minimum number of years that executed agreements of this type must be retained per regulatory and professional standards. Null if no specific retention requirement applies.',
    `sort_order` STRING COMMENT 'Numeric value used to control the display order of agreement types in user interfaces and reports. Lower values appear first.',
    `sox_applicable` BOOLEAN COMMENT 'Indicates whether agreements of this type are subject to Sarbanes-Oxley Act compliance requirements (e.g., financial controls, audit trails). True if SOX compliance is required; False otherwise.',
    `template_available` BOOLEAN COMMENT 'Indicates whether a standard template is available for this agreement type in the firms document management system (DMS). True if template exists; False if agreements are drafted from scratch.',
    `type_code` STRING COMMENT 'Short alphanumeric code representing the agreement type (e.g., LOE, NDA, SPA, POA, MSA, SOW). Used for system integration and UTBMS alignment.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `type_description` STRING COMMENT 'Detailed description of the agreement type, including its purpose, typical use cases, and key characteristics within the legal services context.',
    `type_name` STRING COMMENT 'Full business name of the agreement type (e.g., Letter of Engagement, Non-Disclosure Agreement, Share Purchase Agreement, Power of Attorney, Master Services Agreement, Statement of Work, Vendor Agreement, Retainer Agreement, Alternative Dispute Resolution (ADR) Arbitration Agreement).',
    `utbms_task_code` STRING COMMENT 'UTBMS task code aligned with this agreement type for billing and matter management purposes (e.g., L110 for case assessment, L120 for pleadings). Null if no specific UTBMS code applies.. Valid values are `^[A-Z][0-9]{3}$`',
    CONSTRAINT pk_agreement_type PRIMARY KEY(`agreement_type_id`)
) COMMENT 'Reference classification of contract instrument types recognized by the firm, including LOE (Letter of Engagement), NDA (Non-Disclosure Agreement), SPA (Share Purchase Agreement), POA (Power of Attorney), MSA (Master Services Agreement), SOW (Statement of Work), vendor agreement, retainer agreement, and ADR arbitration agreement. Carries UTBMS-aligned codes, default renewal terms, standard notice periods, and governing regulatory framework flags (GDPR, SOX, FRAND).';

CREATE OR REPLACE TABLE `legal_ecm`.`contract`.`template` (
    `template_id` BIGINT COMMENT 'Unique identifier for the contract template record. Primary key.',
    `agreement_type_id` BIGINT COMMENT 'Foreign key linking to contract.agreement_type. Business justification: Contract_template has a STRING column agreement_type that should be normalized to FK to the agreement_type reference table. Templates are designed for specific agreement types, and this FK establish',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Templates embed compliance policy requirements (standard confidentiality terms per information security policy, limitation of liability per risk policy). Template approval processes verify policy alig',
    `doc_template_id` BIGINT COMMENT 'Foreign key linking to document.doc_template. Business justification: Contract templates are stored as document templates in the DMS. Linking contract.template to document.doc_template enables document generation workflows, version control, and DMS integration. Legal op',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to matter.jurisdiction. Business justification: template has plain text jurisdiction attribute (denormalized). Normalizing to matter.jurisdiction enables jurisdiction-specific template selection and compliance validation — standard legal document',
    `package_id` BIGINT COMMENT 'Foreign key linking to service.package. Business justification: Service packages have associated standard contract templates. Linking enables package-driven template selection during contract drafting, ensuring the correct template is used for each service package',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Contract templates are organized by practice area for knowledge management, template library navigation, and precedent retrieval. Replaces denormalized practice_group string with structured FK. Essent',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Contract templates are designed to satisfy specific regulatory obligations (FCA-regulated advisory agreements, GDPR data processing agreements). Compliance teams track template-to-obligation coverage ',
    `segment_id` BIGINT COMMENT 'Foreign key linking to client.segment. Business justification: Contract templates in legal services are segment-specific — enterprise clients use templates with different standard terms, liability caps, and billing provisions than mid-market clients. Legal ops te',
    `sla_template_id` BIGINT COMMENT 'Foreign key linking to service.sla_template. Business justification: Contract templates embed SLA terms. Linking to sla_template enables template governance: when an SLA template is updated, all contract templates referencing it are flagged for review — a critical docu',
    `superseded_by_template_id` BIGINT COMMENT 'Reference to the contract_template_id of the newer template version that replaces this one. Null if this is the current active version.',
    `access_control_level` STRING COMMENT 'Access control classification determining which users or groups can view and use this template within the firm.. Valid values are `public|practice_group|partner_only|restricted`',
    `approval_date` DATE COMMENT 'Date on which the template received formal approval for use in client engagements.',
    `approval_status` STRING COMMENT 'Current approval status of the template indicating whether it has passed the firms review and approval process for production use.. Valid values are `pending|approved|rejected|conditional`',
    `approved_by` STRING COMMENT 'Name or identifier of the partner, practice group leader, or committee that approved this template for use.',
    `client_facing_flag` BOOLEAN COMMENT 'Indicates whether this template is used for client-facing engagement agreements (True) or internal/vendor agreements (False).',
    `compliance_tags` STRING COMMENT 'Comma-separated list of compliance frameworks and regulatory requirements this template addresses (e.g., GDPR, SOX, AML, CCPA, FRAND).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this template record was first created in the system.',
    `dms_document_reference` STRING COMMENT 'Unique identifier of the template document in the firms Document Management System (iManage Work or NetDocuments) for retrieval and version control.',
    `dms_folder_path` STRING COMMENT 'Hierarchical folder path or workspace location in the DMS where the template is stored for organizational and access control purposes.',
    `document_format` STRING COMMENT 'File format of the template document stored in the Document Management System (DMS).. Valid values are `docx|pdf|rtf|odt|html`',
    `effective_date` DATE COMMENT 'Date from which this template version became active and available for use in contract drafting.',
    `expiration_date` DATE COMMENT 'Date on which this template version is scheduled to be retired or replaced. Null for templates with no planned expiration.',
    `industry_sector` STRING COMMENT 'Target industry sector or sectors for which this template is designed (e.g., Financial Services, Healthcare, Technology, Energy, Manufacturing). Null for general-purpose templates.',
    `keywords` STRING COMMENT 'Comma-separated list of keywords and search terms to facilitate template discovery and retrieval in the knowledge management system.',
    `language_locale` STRING COMMENT 'Language and locale code for the template content following ISO 639-1 and ISO 3166-1 standards (e.g., en-US, en-GB, fr-FR, de-DE).',
    `last_modified_by` STRING COMMENT 'Name or identifier of the user who most recently modified this template record or its associated document.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this template record or its associated document was last modified.',
    `last_review_date` DATE COMMENT 'Date of the most recent legal and compliance review of the template to ensure currency with regulatory changes and best practices.',
    `mandatory_use_flag` BOOLEAN COMMENT 'Indicates whether use of this template is mandatory for the specified agreement type and jurisdiction (True) or optional (False). Enforces firm policy and risk management standards.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of the template to maintain compliance and relevance.',
    `optional_clauses_count` STRING COMMENT 'Number of optional or conditional clauses in the template that may be included or excluded based on the specific engagement requirements.',
    `page_count` STRING COMMENT 'Number of pages in the template document at standard formatting, useful for estimating review and negotiation effort.',
    `review_frequency_months` STRING COMMENT 'Number of months between scheduled reviews of the template (e.g., 12 for annual review, 24 for biennial review).',
    `risk_rating` STRING COMMENT 'Risk classification of the agreement type this template represents, reflecting potential exposure and the level of partner review required.. Valid values are `low|medium|high|critical`',
    `template_code` STRING COMMENT 'Unique business identifier code for the template used for cataloging and reference (e.g., NDA-STD-001, SPA-M&A-002).',
    `template_description` STRING COMMENT 'Detailed description of the templates purpose, scope, and appropriate use cases to guide attorneys in selecting the correct template for their matter.',
    `template_name` STRING COMMENT 'Human-readable name of the contract template (e.g., Standard NDA, Share Purchase Agreement, Letter of Engagement).',
    `template_status` STRING COMMENT 'Current lifecycle status of the template indicating whether it is available for use, under review, or retired from active service.. Valid values are `draft|active|deprecated|archived|under_review|suspended`',
    `transaction_type` STRING COMMENT 'Type of transaction or matter this template is designed to support (e.g., M&A, Financing, Licensing, Employment, Real Estate, Dispute Resolution).',
    `usage_count` STRING COMMENT 'Number of times this template has been used to generate executed agreements, indicating popularity and proven reliability.',
    `usage_instructions` STRING COMMENT 'Guidance and instructions for attorneys on how to properly customize and use this template, including required fields, optional clauses, and approval workflows.',
    `variable_fields_count` STRING COMMENT 'Number of variable fields or merge fields in the template that require customization for each specific engagement or transaction.',
    `version_number` STRING COMMENT 'Version identifier of the template following the firms versioning convention (e.g., 1.0, 2.3, 3.1.5) to track template evolution and updates.',
    `word_count` STRING COMMENT 'Approximate word count of the template document, useful for estimating review time and complexity.',
    `created_by` STRING COMMENT 'Name or identifier of the attorney or knowledge management professional who created the initial version of this template.',
    CONSTRAINT pk_template PRIMARY KEY(`template_id`)
) COMMENT 'Approved master template library for each agreement type maintained in the firms document management system. Tracks template version, practice group owner, jurisdiction applicability, language locale, last review date, approval status, precedent reference, and mandatory-use lock flag. Serves as the catalog of approved starting points for contract drafting.';

CREATE OR REPLACE TABLE `legal_ecm`.`contract`.`contract_party` (
    `contract_party_id` BIGINT COMMENT 'Unique identifier for the contract party record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Reference to the parent contract or agreement to which this party is bound.',
    `aml_kyc_program_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_kyc_program. Business justification: Each contracting party undergoes AML/KYC screening under a specific program. The MLRO and compliance team require traceability from each party to the governing AML/KYC program for SRA compliance, susp',
    `conflict_party_id` BIGINT COMMENT 'Foreign key linking to conflict.conflict_party. Business justification: Contract parties must be conflict-checked entities in legal practice. Links the partys role in a specific contract to their master conflict record for KYC/AML verification, sanctions screening, and r',
    `contact_id` BIGINT COMMENT 'Foreign key linking to client.client_contact. Business justification: A contract party who is a client representative should be linked to the canonical client_contact record for conflict checks, sanctions screening, and signatory authority verification. contract_party h',
    `individual_id` BIGINT COMMENT 'Foreign key linking to client.individual. Business justification: Contract parties can be individuals (personal service agreements, settlement agreements with individuals). This FK links contract parties to the individual master when party_type is individual. is_new',
    `kyc_screening_id` BIGINT COMMENT 'Foreign key linking to intake.kyc_screening. Business justification: Contract parties must have a completed KYC screening before contract execution. Linking to the kyc_screening record provides the full regulatory audit trail (risk score, PEP/sanctions hits, EDD status',
    `organisation_id` BIGINT COMMENT 'Foreign key linking to client.organisation. Business justification: Contract parties are often existing client organisations (engagement letters, retainer agreements, etc.). This FK normalizes party data by linking to the organisation master. is_new_attribute=true bec',
    `profile_id` BIGINT COMMENT 'Foreign key linking to client.client_profile. Business justification: Contract parties need direct link to client_profile for conflict checking, billing consolidation, and relationship reporting. When a contract party is a firm client (is_client flag), this link enables',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.register. Business justification: Third-party risk management: counterparties with sanctions screening, AML/KYC flags require dedicated risk register entries. Legal operations teams track vendor and counterparty risk separately from c',
    `address_line1` STRING COMMENT 'The first line of the partys registered or principal business address (street number and name).',
    `address_line2` STRING COMMENT 'The second line of the partys registered or principal business address (suite, floor, building name).',
    `authorized_signatory_name` STRING COMMENT 'The full name of the individual authorized to sign the contract on behalf of this party.',
    `city` STRING COMMENT 'The city or municipality of the partys registered or principal business address.',
    `confidentiality_obligation_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this party is bound by confidentiality or Non-Disclosure Agreement (NDA) obligations under the contract (True) or not (False).',
    `country_code` STRING COMMENT 'The ISO 3166-1 alpha-3 country code of the partys registered or principal business address (e.g., USA, GBR, CAN).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this contract party record was first created in the system.',
    `email` STRING COMMENT 'The primary email address for the party organization or individual for contract-related communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `execution_date` DATE COMMENT 'The date on which this party executed (signed) the contract.',
    `execution_method` STRING COMMENT 'The method by which this party executed the contract (wet signature, electronic signature, digital signature, corporate seal, notarized).. Valid values are `wet_signature|electronic_signature|digital_signature|seal|notarized`',
    `indemnity_obligation_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this party has indemnity obligations under the contract (True) or not (False).',
    `is_client` BOOLEAN COMMENT 'Boolean flag indicating whether this party is a client of the firm (True) or not (False).',
    `is_firm_entity` BOOLEAN COMMENT 'Boolean flag indicating whether this party represents the law firm itself (True) or an external counterparty (False).',
    `is_opposing_counsel` BOOLEAN COMMENT 'Boolean flag indicating whether this party represents opposing counsel or an adverse party in a matter (True) or not (False).',
    `is_vendor` BOOLEAN COMMENT 'Boolean flag indicating whether this party is a vendor or supplier to the firm (True) or not (False).',
    `liability_cap_amount` DECIMAL(18,2) COMMENT 'The maximum liability amount applicable to this party under the contract terms, if specified.',
    `liability_cap_currency` STRING COMMENT 'The ISO 4217 three-letter currency code for the liability cap amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `notary_commission_number` STRING COMMENT 'The commission number or registration number of the notary public who notarized the signature, if applicable.',
    `notary_expiration_date` DATE COMMENT 'The expiration date of the notary publics commission at the time of notarization, if applicable.',
    `notary_name` STRING COMMENT 'The name of the notary public who witnessed and notarized the partys signature, if applicable.',
    `on_agreement` BIGINT COMMENT 'FK to contract.agreement.agreement_id — contract_party is a junction/detail record linking parties to agreements. Without this FK, party records are orphaned with no agreement context.',
    `parent_entity_name` STRING COMMENT 'The name of the parent company or controlling entity of this party, if applicable (used for corporate hierarchy tracking).',
    `party_role` STRING COMMENT 'The legal or functional role this party plays in the contract (e.g., offeror, offeree, guarantor, witness, notary, authorized signatory).. Valid values are `offeror|offeree|guarantor|witness|notary|authorized_signatory`',
    `party_status` STRING COMMENT 'The current lifecycle status of this party in relation to the contract (active, inactive, terminated, suspended, deceased for individuals).. Valid values are `active|inactive|terminated|suspended|deceased`',
    `party_type` STRING COMMENT 'Classification of the party entity type (individual, corporation, partnership, government body, trust, non-profit organization).. Valid values are `individual|corporation|partnership|government|trust|non_profit`',
    `phone` STRING COMMENT 'The primary contact phone number for the party organization or individual.',
    `postal_code` STRING COMMENT 'The postal code or ZIP code of the partys registered or principal business address.',
    `registration_number` STRING COMMENT 'The official registration number, company number, or tax identifier (e.g., EIN, VAT number, CRN) assigned to the party by the relevant jurisdiction.',
    `sanctions_screening_date` DATE COMMENT 'The date on which sanctions screening was last performed for this party.',
    `sanctions_screening_status` STRING COMMENT 'The result of sanctions list screening for this party (cleared, flagged for review, pending, not screened).. Valid values are `cleared|flagged|pending|not_screened`',
    `signatory_capacity` STRING COMMENT 'The legal capacity in which the signatory is executing the contract (individual, corporate officer, attorney-in-fact under Power of Attorney (POA), trustee, executor, guardian).. Valid values are `individual|corporate_officer|attorney_in_fact|trustee|executor|guardian`',
    `signatory_email` STRING COMMENT 'The primary email address of the authorized signatory for contract-related communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `signatory_phone` STRING COMMENT 'The primary contact phone number for the authorized signatory.',
    `signatory_title` STRING COMMENT 'The job title or official position of the authorized signatory (e.g., Chief Executive Officer, General Counsel, Director).',
    `signature_location` STRING COMMENT 'The city, state, or country where the party executed the contract, as stated in the signature block.',
    `state_province` STRING COMMENT 'The state, province, or region of the partys registered or principal business address.',
    `to_agreement` BIGINT COMMENT 'FK to contract.agreement.agreement_id — Every contract_party record identifies a party TO a specific agreement. This is a mandatory associative relationship — parties are meaningless without their agreement context.',
    `ultimate_beneficial_owner` STRING COMMENT 'The name of the ultimate beneficial owner (UBO) of the party entity, as required for KYC and AML compliance.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this contract party record was last updated in the system.',
    CONSTRAINT pk_contract_party PRIMARY KEY(`contract_party_id`)
) COMMENT 'Records every counterparty, signatory, or named party to a specific agreement, including the firm itself, clients, opposing counsel entities, vendors, guarantors, and government bodies. Captures party role (offeror, offeree, guarantor, witness, notary), legal entity name, jurisdiction of incorporation, KYC/AML clearance status, authorized signatory name, and execution capacity. Supports multi-party M&A and syndicated transaction structures.';

CREATE OR REPLACE TABLE `legal_ecm`.`contract`.`obligation` (
    `obligation_id` BIGINT COMMENT 'Unique system identifier for the contractual obligation record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Reference to the parent executed agreement from which this obligation was extracted.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to ip.asset. Business justification: Contract obligations routinely reference specific IP assets (e.g., maintain patent registration, not infringe trademark, transfer copyright ownership). Essential for IP portfolio compliance moni',
    `clause_library_id` BIGINT COMMENT 'Foreign key linking to contract.clause_library. Business justification: obligation.clause_reference is a free-text string referencing the contractual clause from which the obligation was extracted. clause_library is the authoritative curated repository of approved clauses',
    `compliance_control_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_control. Business justification: Contractual obligations directly implement compliance controls (GDPR data breach notification obligations implement GDPR controls; SOX reporting obligations implement SOX controls). Compliance teams m',
    `order_id` BIGINT COMMENT 'Foreign key linking to court.order. Business justification: Court orders frequently impose contractual obligations (injunctions, specific performance, consent decrees). Legal teams must track which court order created or modified each obligation for compliance',
    `dependent_obligation_id` BIGINT COMMENT 'Reference to another obligation that must be fulfilled before this obligation becomes active. Null if no dependency exists.',
    `legal_document_id` BIGINT COMMENT 'Foreign key linking to document.legal_document. Business justification: Obligation compliance tracking requires linking each obligation to its evidencing legal document (court order, side letter, regulatory filing). The existing plain-text document_reference field is a de',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: Contractual obligations often represent service delivery commitments (SLA response times, deliverable deadlines). Essential for SLA monitoring, service performance tracking, and obligation-to-service ',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter under which this obligation is being tracked. Null if obligation is tracked at contract level only.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Contractual obligations that fail or are breached create professional indemnity exposure and client relationship risks. Risk registers track obligation-specific risks for breach risk assessment, PI cl',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Contractual obligations often implement regulatory requirements (data retention obligations from GDPR Article 17, reporting obligations from financial regulations, record-keeping from AML rules). Lega',
    `request_id` BIGINT COMMENT 'Foreign key linking to intake.intake_request. Business justification: Contract obligations can originate from intake commitments (conflict clearance obligations, KYC completion requirements, ethical wall maintenance, panel appointment conditions). Legal operations track',
    `contract_party_id` BIGINT COMMENT 'Foreign key linking to contract.contract_party. Business justification: obligation.responsible_party_name and responsible_party_type are denormalized string references to a party already registered in contract_party. Adding responsible_contract_party_id normalizes the res',
    `sla_template_id` BIGINT COMMENT 'Foreign key linking to service.sla_template. Business justification: Contractual obligations frequently mirror SLA commitments (response time obligations, turnaround obligations). Linking obligation to sla_template enables SLA breach monitoring at the obligation level ',
    `beneficiary_party_name` STRING COMMENT 'Legal name of the entity or individual entitled to receive the benefit or performance of the obligation.',
    `breach_consequence` STRING COMMENT 'Description of the contractual consequences if the obligation is breached (e.g., liquidated damages, termination right, indemnity trigger, regulatory penalty).',
    `breach_notice_required` BOOLEAN COMMENT 'Indicates whether the contract requires formal written notice before a breach is deemed to have occurred (True) or if breach is automatic upon deadline passage (False).',
    `condition_precedent_flag` BOOLEAN COMMENT 'Indicates whether this obligation is a condition precedent (True) that must be satisfied before other contract terms become effective, or a standard ongoing obligation (False).',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the obligation record was first created in the CLM system.',
    `cure_period_days` STRING COMMENT 'Number of days allowed to remedy a breach after notice is given, as specified in the contract. Null if no cure period is granted.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for monetary_value (e.g., USD, GBP, EUR). Null if obligation is non-monetary.. Valid values are `^[A-Z]{3}$`',
    `due_date` DATE COMMENT 'The date by which the obligation must be fulfilled. Null for obligations without a fixed deadline.',
    `escalation_threshold_days` STRING COMMENT 'Number of days before due_date when the obligation should be escalated to senior management or responsible partner for review.',
    `from_agreement` BIGINT COMMENT 'FK to contract.agreement.agreement_id — Obligations are extracted from executed agreements. This is the core parent-child relationship enabling obligation tracking per contract.',
    `fulfillment_percentage` DECIMAL(18,2) COMMENT 'Percentage completion of the obligation (0.00 to 100.00). Used for tracking partial fulfillment of multi-step or phased obligations.',
    `fulfillment_status` STRING COMMENT 'Current lifecycle state of the obligation: pending (not started), in_progress (work underway), fulfilled (completed), partially_fulfilled (incomplete), breached (deadline missed), waived (obligation released), terminated (contract ended). [ENUM-REF-CANDIDATE: pending|in_progress|fulfilled|partially_fulfilled|breached|waived|terminated — 7 candidates stripped; promote to reference product]',
    `is_active` BOOLEAN COMMENT 'Indicates whether this obligation record is currently active (True) or has been logically deleted/archived (False).',
    `last_modified_by` STRING COMMENT 'Username or identifier of the system user who last modified the obligation record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the obligation record was last updated.',
    `monetary_value` DECIMAL(18,2) COMMENT 'Financial value associated with the obligation (e.g., payment amount, penalty exposure, indemnity cap). Null for non-monetary obligations.',
    `notes` STRING COMMENT 'Free-text field for additional context, interpretation guidance, or operational notes related to the obligation.',
    `obligation_category` STRING COMMENT 'High-level classification of the obligation type: payment (financial settlement), delivery (goods/services), reporting (disclosure/notification), confidentiality (NDA terms), regulatory (compliance duty), IP assignment (intellectual property transfer).. Valid values are `payment|delivery|reporting|confidentiality|regulatory|ip_assignment`',
    `obligation_text` STRING COMMENT 'Full verbatim text of the contractual obligation, covenant, representation, warranty, or condition precedent as extracted from the source agreement.',
    `priority` STRING COMMENT 'Business priority level for fulfillment tracking and escalation: critical (regulatory/legal deadline), high (material contract term), medium (standard obligation), low (administrative).. Valid values are `critical|high|medium|low`',
    `recurrence_rule` STRING COMMENT 'Detailed recurrence pattern specification for custom schedules, expressed in iCalendar RRULE format or plain text description.',
    `recurrence_schedule` STRING COMMENT 'Frequency pattern for recurring obligations: one_time (single event), daily, weekly, monthly, quarterly, annually, custom (irregular pattern defined in recurrence_rule). [ENUM-REF-CANDIDATE: one_time|daily|weekly|monthly|quarterly|annually|custom — 7 candidates stripped; promote to reference product]',
    `reference_number` STRING COMMENT 'Business-readable unique identifier for the obligation, often derived from contract number and clause reference (e.g., SPA-2024-001-CL-5.3).',
    `regulatory_framework` STRING COMMENT 'Name of the governing regulation or statute if regulatory_obligation_flag is True (e.g., GDPR Article 28, SOX Section 404, CCPA Section 1798.100). [ENUM-REF-CANDIDATE: promote to reference product if more than 6 frameworks are tracked]',
    `regulatory_obligation_flag` BOOLEAN COMMENT 'Indicates whether this obligation is mandated by law or regulation (True) versus being a purely contractual commitment (False). Used for compliance reporting.',
    `subcategory` STRING COMMENT 'Granular classification within the obligation category (e.g., milestone payment, quarterly report, data protection compliance, patent assignment).',
    `to_agreement` BIGINT COMMENT 'FK to contract.agreement.agreement_id — Every obligation is extracted from a specific executed agreement. This is the fundamental parent-child relationship in CLM obligation tracking. Without this FK, obligations float without context and c',
    `version_number` STRING COMMENT 'Version number of the obligation record, incremented with each modification to support audit trail and change tracking.',
    `waiver_authority` STRING COMMENT 'Name and title of the individual who authorized the waiver of this obligation.',
    `waiver_date` DATE COMMENT 'Date on which the beneficiary party formally waived or released the obligation. Null if no waiver has been granted.',
    `waiver_reason` STRING COMMENT 'Business justification or legal rationale for waiving the obligation.',
    `created_by` STRING COMMENT 'Username or identifier of the system user who created the obligation record.',
    CONSTRAINT pk_obligation PRIMARY KEY(`obligation_id`)
) COMMENT 'Granular obligation register extracted from executed agreements, capturing each discrete contractual duty, covenant, representation, warranty, or condition precedent as a header record with associated lifecycle event lines. Header stores obligation text, category (payment, delivery, reporting, confidentiality, regulatory, IP assignment), responsible party, due date, recurrence schedule, priority, and fulfillment status. Line-level event records capture the full audit trail: creation, fulfillment, partial completion, breach notice, cure, waiver, and escalation events with actor, timestamp, event type, supporting document reference, and resulting status change. SSOT for all obligation data including lifecycle events. Core to CLM obligation tracking, dispute resolution evidence, and regulatory compliance reporting.';

CREATE OR REPLACE TABLE `legal_ecm`.`contract`.`obligation_event` (
    `obligation_event_id` BIGINT COMMENT 'Unique identifier for the obligation event record. Primary key for the obligation event entity.',
    `agreement_id` BIGINT COMMENT 'Reference to the contract under which this obligation event occurred. Provides context for the agreement governing the obligation.',
    `amendment_id` BIGINT COMMENT 'Foreign key linking to contract.amendment. Business justification: obligation_event records lifecycle events for obligations. When an amendment modifies an obligation (e.g., changes due date, waives a requirement, adds a new obligation), an obligation_event is genera',
    `legal_document_id` BIGINT COMMENT 'Structured identifier of the supporting document stored in the document management system. Links to the document entity for formal document tracking.',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter associated with this obligation event, if applicable. Links the event to the broader case or engagement context.',
    `obligation_id` BIGINT COMMENT 'Reference to the parent obligation that this event pertains to. Links the event to the specific contractual obligation being tracked.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.register. Business justification: Obligation breach events (breach_severity, dispute_flag, financial_impact_amount on obligation_event) are direct risk register triggers. Legal risk teams log breach events as risk incidents. Direct FK',
    `actor_type` STRING COMMENT 'The category of party or system that triggered or recorded the obligation event. Identifies whether the actor was an attorney, client, counterparty, automated system, or third party.. Valid values are `attorney|client|counterparty|system|third_party`',
    `breach_notice_date` DATE COMMENT 'The date on which formal notice of the breach was provided to the breaching party, if applicable. Critical for calculating cure periods and contractual remedies.',
    `breach_severity` STRING COMMENT 'The severity level of the breach, if the event type is breached. Classifies the impact and urgency of the breach for escalation and remediation purposes.. Valid values are `minor|moderate|major|critical`',
    `completion_percentage` DECIMAL(18,2) COMMENT 'The percentage of the obligation that has been completed as of this event. Used for tracking partial fulfillment (e.g., 50.00 indicates 50% completion). Range: 0.00 to 100.00.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether this obligation event has compliance or regulatory reporting implications. True if the event must be included in regulatory reports, False otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this obligation event record was first created in the data platform. System audit timestamp for record creation.',
    `cure_deadline` DATE COMMENT 'The deadline by which the breaching party must cure the breach to avoid further consequences. Derived from contract terms and breach notice date.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether this obligation event is currently under dispute by any party. True if disputed, False otherwise.',
    `dispute_reason` STRING COMMENT 'The reason or grounds for disputing this obligation event, if dispute_flag is True. Documents the nature of the disagreement.',
    `escalation_level` STRING COMMENT 'The organizational level to which the obligation event has been escalated for resolution or decision-making. Indicates the seniority of review required.. Valid values are `none|team_lead|partner|general_counsel|executive`',
    `escalation_reason` STRING COMMENT 'The reason why the obligation event was escalated to a higher authority. Documents the business or legal issue requiring senior review.',
    `event_description` STRING COMMENT 'Detailed narrative description of the obligation event. Captures context, circumstances, and any relevant details about what occurred and why.',
    `event_status` STRING COMMENT 'Current processing status of the obligation event. Indicates whether the event is pending review, confirmed as valid, disputed by a party, resolved after dispute, or cancelled.. Valid values are `pending|confirmed|disputed|resolved|cancelled`',
    `event_timestamp` TIMESTAMP COMMENT 'The precise date and time when the obligation event occurred in the real world. This is the business event time, distinct from system audit timestamps.',
    `event_type` STRING COMMENT 'The type of obligation lifecycle event. Indicates the nature of the event: created (obligation established), fulfilled (obligation completed), partially_completed (partial performance), breached (obligation not met), cured (breach remedied), waived (obligation forgiven), or escalated (elevated for resolution).. Valid values are `created|fulfilled|partially_completed|breached|cured|waived`',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'The monetary value associated with this obligation event, if applicable. May represent payment made, penalty incurred, or financial consequence of the event.',
    `financial_impact_currency` STRING COMMENT 'The three-letter ISO 4217 currency code for the financial impact amount (e.g., USD, GBP, EUR). Null if no financial impact.. Valid values are `^[A-Z]{3}$`',
    `modified_by` STRING COMMENT 'The user ID or system account that last modified this obligation event record in the data platform. Provides audit trail for record updates.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this obligation event record was last modified in the data platform. System audit timestamp for record updates.',
    `notification_recipient_list` STRING COMMENT 'Comma-separated list of email addresses or user identifiers who received notification of this obligation event. Provides audit trail of communication.',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether an automated notification was sent to relevant parties about this obligation event. True if notification was sent, False otherwise.',
    `notification_timestamp` TIMESTAMP COMMENT 'The date and time when the notification about this obligation event was sent to relevant parties. Null if no notification was sent.',
    `prior_obligation_status` STRING COMMENT 'The status of the parent obligation immediately before this event occurred. Enables tracking of status transitions and audit trail reconstruction.. Valid values are `pending|active|fulfilled|breached|waived|expired`',
    `regulatory_framework` STRING COMMENT 'The specific regulatory framework or compliance regime that governs this obligation event, if applicable (e.g., GDPR, SOX, AML, CCPA). [ENUM-REF-CANDIDATE: GDPR|SOX|AML|CCPA|FRAND|DPA|PCI_DSS|FATF — promote to reference product]',
    `resolution_notes` STRING COMMENT 'Detailed notes documenting how the obligation event was resolved, if applicable. Captures the outcome, actions taken, and any agreements reached.',
    `resolution_timestamp` TIMESTAMP COMMENT 'The date and time when the obligation event was formally resolved or closed. Null if the event is still open or pending.',
    `resulting_obligation_status` STRING COMMENT 'The status of the parent obligation immediately after this event was processed. Captures the state transition caused by the event (e.g., from active to fulfilled, or from active to breached).. Valid values are `pending|active|fulfilled|breached|waived|expired`',
    `source_system` STRING COMMENT 'The name of the operational system that originated or recorded this obligation event (e.g., Elite 3E, iManage Work, NetDocuments, internal CLM system).',
    `source_system_event_reference` STRING COMMENT 'The unique identifier of this obligation event in the source operational system. Enables traceability back to the originating system.',
    `supporting_document_reference` STRING COMMENT 'Reference identifier or URI to the document that evidences or supports this obligation event. May point to a document in the Document Management System (DMS) such as iManage Work or NetDocuments.',
    `waiver_authority` STRING COMMENT 'The name or title of the individual or body that authorized the waiver of the obligation. Provides accountability and governance for waiver decisions.',
    `waiver_reason` STRING COMMENT 'The business or legal rationale for waiving the obligation, if the event type is waived. Documents the justification for forgiving the obligation.',
    `created_by` STRING COMMENT 'The user ID or system account that created this obligation event record in the data platform. Provides audit trail for record creation.',
    CONSTRAINT pk_obligation_event PRIMARY KEY(`obligation_event_id`)
) COMMENT 'Transactional record of each obligation lifecycle event — creation, fulfillment, partial completion, breach notice, cure, waiver, or escalation. Captures event timestamp, actor (attorney, client, counterparty), event type, supporting document reference, and resulting obligation status change. Provides the full audit trail required for dispute resolution and regulatory compliance reporting.';

CREATE OR REPLACE TABLE `legal_ecm`.`contract`.`milestone` (
    `milestone_id` BIGINT COMMENT 'Unique identifier for the contract milestone record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Reference to the parent contract or agreement to which this milestone belongs. Links milestone to the governing contract record.',
    `amendment_id` BIGINT COMMENT 'Foreign key linking to contract.amendment. Business justification: Amendments frequently introduce new milestones or modify existing ones (e.g., extended deadline, new payment schedule). Adding amendment_id to milestone allows tracing which amendment created or last ',
    `clause_library_id` BIGINT COMMENT 'Foreign key linking to contract.clause_library. Business justification: milestone.contractual_clause_reference is a free-text string referencing the clause that mandates the milestone. clause_library is the authoritative clause repository. Adding clause_library_id normali',
    `deadline_id` BIGINT COMMENT 'Foreign key linking to matter.matter_deadline. Business justification: Contract milestones are formally docketed as matter deadlines for malpractice risk management — a standard legal ops workflow. Linking milestone to matter_deadline enables automated deadline creation ',
    `legal_document_id` BIGINT COMMENT 'Reference to the executed contract document or amendment in the Document Management System (DMS) that defines this milestone. Links milestone to source document for verification.',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: Milestones track service delivery progress against agreed scope. Supports project management dashboards, client status reporting, and service delivery analytics. Links milestone completion to specific',
    `matter_id` BIGINT COMMENT 'Reference to the associated matter or case record if the contract milestone is tied to active legal work. Links milestone tracking to matter management for integrated workflow.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to contract.obligation. Business justification: Milestones are scheduled key dates tied to an agreement. Many milestones directly track the due date or fulfillment deadline of a specific obligation (e.g., payment obligation due date, delivery oblig',
    `profile_id` BIGINT COMMENT 'Reference to the client organization or individual associated with this contract milestone. Supports client-centric reporting and relationship management.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Regulatory milestones (filing deadlines, certification renewals, reporting dates) are directly tied to specific regulatory obligations. The milestone already has is_regulatory_milestone_flag but no FK',
    `sla_template_id` BIGINT COMMENT 'Foreign key linking to service.sla_template. Business justification: Milestones represent delivery checkpoints governed by SLA commitments. Linking milestone to sla_template enables SLA compliance monitoring at the milestone level — a key legal project management and c',
    `actual_date` DATE COMMENT 'The date on which the milestone event actually occurred or was completed. Null if the milestone has not yet been completed. Used for performance tracking and compliance reporting.',
    `alert_lead_time_days` STRING COMMENT 'Number of days before the scheduled milestone date that an automated alert or notification should be triggered. Configurable per milestone to support proactive management.',
    `completion_notes` STRING COMMENT 'Free-text notes documenting how the milestone was satisfied, any issues encountered, or deviations from the scheduled plan. Captured at milestone completion for audit and knowledge management purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the milestone record was first created in the system. Supports audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the financial impact amount. Supports multi-currency contract portfolios.. Valid values are `^[A-Z]{3}$`',
    `escalation_date` DATE COMMENT 'Date on which the milestone was escalated to senior management or governance committee. Null if no escalation has occurred. Supports audit trail for high-risk milestones.',
    `escalation_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether the milestone requires escalation to senior management or General Counsel (GC) for approval or decision. Used for governance and risk management.',
    `external_system_reference` STRING COMMENT 'Reference identifier or key from an external Contract Lifecycle Management (CLM) system, practice management system, or client portal. Supports system integration and data lineage tracking.',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated financial impact or exposure associated with missing or completing this milestone (e.g., penalty amount, payment due, revenue recognition trigger). Used for financial risk assessment.',
    `is_active` BOOLEAN COMMENT 'Boolean indicator of whether the milestone record is currently active and should be included in operational workflows and reporting. Supports soft-delete and historical record retention.',
    `is_critical_path_flag` BOOLEAN COMMENT 'Boolean indicator of whether this milestone is on the critical path for transaction completion or contract effectiveness. Used for prioritization in Mergers and Acquisitions (M&A) and complex transactions.',
    `is_regulatory_milestone_flag` BOOLEAN COMMENT 'Boolean indicator of whether this milestone is driven by regulatory or statutory requirements (e.g., filing deadlines, compliance notice periods). Used for regulatory reporting and compliance tracking.',
    `milestone_description` STRING COMMENT 'Detailed textual description of the milestone event, including any specific contractual obligations, conditions precedent, or actions required to satisfy the milestone.',
    `milestone_name` STRING COMMENT 'Business-friendly name or label for the milestone event (e.g., Execution Date, Effective Date, First Renewal Notice, Termination Deadline).',
    `milestone_status` STRING COMMENT 'Current lifecycle status of the milestone. Tracks whether the milestone is pending, approaching its due date, completed, missed, or waived. [ENUM-REF-CANDIDATE: pending|approaching|due|completed|missed|waived|cancelled — 7 candidates stripped; promote to reference product]',
    `milestone_type` STRING COMMENT 'Classification of the milestone event type. Categorizes the nature of the contractual milestone for reporting and workflow automation. [ENUM-REF-CANDIDATE: execution|effective_date|condition_precedent|notice_period|option_exercise|renewal_decision|expiry|termination_window|payment_due|deliverable_due|regulatory_filing — 11 candidates stripped; promote to reference product]',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the milestone record was last modified or updated. Supports change tracking and audit trail for milestone lifecycle management.',
    `next_occurrence_date` DATE COMMENT 'For recurring milestones, the date of the next scheduled occurrence. Null for one-time milestones. Used to generate future milestone records automatically.',
    `notification_sent_timestamp` TIMESTAMP COMMENT 'Timestamp when the automated notification or alert was sent to the responsible party. Null if no notification has been sent. Supports audit trail for milestone management.',
    `notification_triggered_flag` BOOLEAN COMMENT 'Boolean indicator of whether an automated notification or alert has been triggered for this milestone. Used to track alert delivery and prevent duplicate notifications.',
    `priority_level` STRING COMMENT 'Business priority classification for the milestone. Used for workload prioritization and resource allocation in contract management workflows.. Valid values are `critical|high|medium|low`',
    `recurrence_pattern` STRING COMMENT 'Defines whether the milestone is a one-time event or recurs on a regular schedule (e.g., annual renewal notice, quarterly compliance review). Supports automated milestone generation for recurring obligations.. Valid values are `one_time|annual|semi_annual|quarterly|monthly|custom`',
    `responsible_party_name` STRING COMMENT 'Name of the individual, team, or external party responsible for satisfying the milestone obligation. May be internal attorney, client contact, or third-party vendor.',
    `scheduled_date` DATE COMMENT 'The planned or contractually agreed date on which the milestone event is scheduled to occur. Core date for milestone tracking and alerting.',
    CONSTRAINT pk_milestone PRIMARY KEY(`milestone_id`)
) COMMENT 'Scheduled key dates and milestone events tied to an agreement, including execution date, effective date, condition precedent satisfaction deadline, notice periods, option exercise windows, renewal decision dates, expiry date, and termination for convenience windows. Tracks milestone status, alert lead-time configuration, responsible attorney, and whether the milestone triggered an automated notification. Critical for renewal management and M&A transaction timetables.';

CREATE OR REPLACE TABLE `legal_ecm`.`contract`.`renewal` (
    `renewal_id` BIGINT COMMENT 'Unique identifier for the contract renewal record. Primary key.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to client.client_contact. Business justification: Renewal workflows require notifying and obtaining approval from a specific client contact. renewal has client_approval_required and client_approval_received_date attributes, indicating a named client ',
    `engagement_opportunity_id` BIGINT COMMENT 'Foreign key linking to intake.engagement_opportunity. Business justification: Contract renewals generate or are driven by engagement opportunities in the BD pipeline. Linking renewal to engagement_opportunity supports cross-sell/upsell revenue forecasting, BD pipeline reporting',
    `legal_document_id` BIGINT COMMENT 'Foreign key linking to document.legal_document. Business justification: Contract renewal processes produce a renewal instrument (legal document). Tracking which specific legal document evidences the renewal is required for contract lifecycle management, audit trails, and ',
    `letter_of_engagement_id` BIGINT COMMENT 'Foreign key linking to intake.letter_of_engagement. Business justification: Renewals require a new or updated LOE governing the renewed engagement period. Linking renewal to the LOE supports fee arrangement continuity tracking, scope confirmation, and billing compliance — leg',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to contract.obligation. Business justification: Renewal obligations are typically extracted from the agreement as discrete obligation records (e.g., provide renewal notice 90 days before expiry). Adding obligation_id to renewal links the renewal ',
    `package_id` BIGINT COMMENT 'Foreign key linking to service.package. Business justification: Renewed engagements may be structured around a different service package. Linking renewal to package enables package change tracking across renewal cycles and supports service scope management and cro',
    `pricing_model_id` BIGINT COMMENT 'Foreign key linking to service.pricing_model. Business justification: Renewals frequently involve pricing model changes (e.g., converting from hourly to fixed fee). Linking renewal to pricing_model enables AFA adoption tracking across renewal cycles and renewal pricing ',
    `rate_card_id` BIGINT COMMENT 'Foreign key linking to service.rate_card. Business justification: Renewals are negotiated against a new or updated rate card. Linking enables rate change tracking across renewal cycles, supporting client rate negotiation history and billing compliance audits — a sta',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.register. Business justification: Renewals require formal risk re-evaluation (changed market conditions, regulatory changes, counterparty credit risk). renewal.risk_level is a denormalized risk classification that should be normalized',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Renewal approval in regulated industries requires re-assessment against current regulatory obligations before sign-off. Compliance teams track which regulatory obligation governs the renewal review — ',
    `agreement_id` BIGINT COMMENT 'Reference to the parent contract subject to renewal. Links to the contract master record.',
    `renewal_successor_contract_agreement_id` BIGINT COMMENT 'Reference to the new contract record created as a result of this renewal. Null if renewal was declined or not yet executed.',
    `request_id` BIGINT COMMENT 'Foreign key linking to intake.request. Business justification: Contract renewals require a new intake request for conflict re-check, KYC refresh, and internal approval before the renewed engagement commences. This link supports compliance workflow tracking and en',
    `tier_id` BIGINT COMMENT 'Foreign key linking to service.tier. Business justification: Client tier may change at renewal (upgrade from Gold to Platinum). Linking renewal to tier enables tier change tracking across renewal cycles — a key account management and client relationship reporti',
    `auto_renew_flag` BOOLEAN COMMENT 'Indicates whether the contract is subject to automatic renewal unless notice to cancel is provided (true) or requires affirmative action to renew (false).',
    `client_approval_received_date` DATE COMMENT 'Date on which client approval for the renewal was formally received. Null if approval not yet received or not required.',
    `client_approval_required` BOOLEAN COMMENT 'Indicates whether explicit client approval is required for the renewal to proceed (true) or if the renewal is automatic per contract terms (false).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the renewal record was first created in the system.',
    `decision` STRING COMMENT 'Final decision outcome for the renewal: renew (proceed with renewal as-is or with minor adjustments), terminate (end the contract), renegotiate (material terms require negotiation), pending (decision not yet made).. Valid values are `renew|terminate|renegotiate|pending`',
    `decision_date` DATE COMMENT 'Date on which the renewal decision was formally made by the responsible partner or client.',
    `effective_date` DATE COMMENT 'Date on which the renewed contract term begins. Typically the day after the prior term expiration date.',
    `expiration_date` DATE COMMENT 'Date on which the renewed contract term ends, triggering the next renewal cycle or final termination.',
    `fee_adjustment_percentage` DECIMAL(18,2) COMMENT 'Percentage change in fees from the prior term to the renewal term. Positive values indicate fee increases; negative values indicate discounts or reductions.',
    `fee_adjustment_reason` STRING COMMENT 'Business rationale for any fee adjustment applied during renewal (e.g., inflation adjustment, scope expansion, client loyalty discount, competitive pressure).',
    `fee_amount` DECIMAL(18,2) COMMENT 'Total fee amount for the renewal term if a fixed or capped fee arrangement applies. Null for hourly arrangements without a cap.',
    `fee_arrangement_type` STRING COMMENT 'Fee structure applicable to the renewal term: hourly (standard time-based billing), fixed_fee (flat fee for scope), capped_fee (hourly with ceiling), contingency (success-based), blended_rate (averaged rate across timekeepers), afa_other (custom alternative fee arrangement).. Valid values are `hourly|fixed_fee|capped_fee|contingency|blended_rate|afa_other`',
    `fee_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the renewal fee amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `initiated_by` STRING COMMENT 'Party that initiated the renewal process: client (client requested renewal), firm (firm proactively proposed renewal), auto_trigger (system-generated based on contract terms).. Valid values are `client|firm|auto_trigger`',
    `notes` STRING COMMENT 'Free-text field for capturing additional context, negotiation details, client feedback, or special conditions related to the renewal.',
    `notice_period_days` STRING COMMENT 'Number of days prior to renewal effective date that notice to cancel must be provided, as stipulated in the contract terms (e.g., 30, 60, 90 days).',
    `notice_to_cancel_deadline` DATE COMMENT 'Last date by which either party must provide written notice to prevent automatic renewal or to terminate the agreement. Critical for proactive renewal pipeline management.',
    `notification_sent_date` DATE COMMENT 'Date on which the renewal notification or reminder was sent to the client or responsible partner.',
    `of_agreement` BIGINT COMMENT 'FK to contract.agreement.agreement_id — Renewals manage the continuation lifecycle of a specific agreement. The FK to agreement is mandatory for renewal pipeline management.',
    `priority` STRING COMMENT 'Business priority assigned to this renewal based on client strategic importance, revenue impact, or relationship risk: high (top-tier client or significant revenue), medium (standard renewal), low (routine or low-value).. Valid values are `high|medium|low`',
    `renewal_number` STRING COMMENT 'Business-facing identifier for the renewal event, typically formatted as contract number plus renewal sequence (e.g., LOE-2024-001-R2).',
    `renewal_status` STRING COMMENT 'Current lifecycle state of the renewal: pending (awaiting decision), under_review (partner evaluation in progress), approved (client/firm agreed to renew), declined (non-renewal decision made), executed (successor agreement signed), cancelled (renewal process aborted).. Valid values are `pending|under_review|approved|declined|executed|cancelled`',
    `renewal_type` STRING COMMENT 'Classification of the renewal mechanism: auto_renew (automatic rollover per contract terms), opt_in (requires affirmative client election), renegotiate (new terms required), extend (one-time extension without full renewal), terminate (non-renewal decision).. Valid values are `auto_renew|opt_in|renegotiate|extend|terminate`',
    `term_length` STRING COMMENT 'Duration of the renewal term in months. For example, a 12-month renewal or a 36-month multi-year extension.',
    `term_unit` STRING COMMENT 'Unit of measure for the renewal term length: month, year, or quarter.. Valid values are `month|year|quarter`',
    `to_agreement` BIGINT COMMENT 'FK to contract.agreement.agreement_id — Every renewal record manages the renewal lifecycle of a specific agreement. Without this FK, renewal pipeline management cannot function.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the renewal record was last modified.',
    CONSTRAINT pk_renewal PRIMARY KEY(`renewal_id`)
) COMMENT 'Manages the renewal lifecycle for agreements subject to auto-renewal, optional renewal, or renegotiation. Captures renewal type (auto-renew, opt-in, renegotiate), renewal term length, notice-to-cancel deadline, renewal decision (renew, terminate, renegotiate), decision date, responsible partner, AFA or fee adjustment for the renewal term, and the resulting successor agreement reference. Supports proactive renewal pipeline management.';

CREATE OR REPLACE TABLE `legal_ecm`.`contract`.`amendment` (
    `amendment_id` BIGINT COMMENT 'Unique identifier for the contract amendment record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Reference to the parent executed agreement being amended. Links to the master contract or engagement letter.',
    `legal_document_id` BIGINT COMMENT 'Reference identifier to the clean (final executed) version of the amendment document stored in the Document Management System (DMS).',
    `amendment_legal_document_id` BIGINT COMMENT 'Reference identifier to the redlined (track-changes) version of the amendment document stored in the Document Management System (DMS). Enables retrieval of the marked-up comparison showing changes from the original agreement.',
    `check_id` BIGINT COMMENT 'Reference to the conflict check record performed for this amendment, if the amendment introduced new parties or scope that required conflict clearance.',
    `clearance_id` BIGINT COMMENT 'Foreign key linking to conflict.clearance. Business justification: Contract amendments that add new parties, expand scope, or change matter context require a fresh conflict clearance. Linking amendment to the specific clearance that authorized it — distinct from the ',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Amendments are required when internal compliance policies are updated (e.g., updated data protection policy, revised AML policy). Compliance teams track which policy version triggered each amendment f',
    `contract_party_id` BIGINT COMMENT 'Foreign key linking to contract.contract_party. Business justification: amendment.counterparty_name is a denormalized string reference to the counterparty executing the amendment. contract_party is the authoritative registry of all parties to the agreement. Adding counter',
    `engagement_opportunity_id` BIGINT COMMENT 'Foreign key linking to intake.engagement_opportunity. Business justification: Amendments relate back to original engagement opportunities for scope creep analysis, fee arrangement renegotiation tracking, and estimated-vs-actual engagement value variance reporting. Supports clie',
    `letter_of_engagement_id` BIGINT COMMENT 'Foreign key linking to intake.letter_of_engagement. Business justification: Amendments frequently modify terms established in the LOE (fee arrangements, scope, governing law). Linking amendment to the relevant LOE supports fee arrangement change tracking, scope modification a',
    `matter_id` BIGINT COMMENT 'Reference to the matter or case under which this amendment was prepared and executed. Links amendment activity to billable work.',
    `package_id` BIGINT COMMENT 'Foreign key linking to service.package. Business justification: Amendments may expand or change the service package scope (e.g., adding IP services to an existing corporate advisory package). Linking amendment to package enables scope change tracking and package u',
    `parent_amendment_id` BIGINT COMMENT 'Self-referencing foreign key to a prior amendment that this amendment further modifies or supersedes. Enables tracking of amendment chains (e.g., Amendment 2.1 amends Amendment 2).',
    `pricing_model_id` BIGINT COMMENT 'Foreign key linking to service.pricing_model. Business justification: Amendments frequently change the pricing model (converting hourly to fixed fee mid-engagement). Linking amendment to pricing_model enables tracking of pricing model changes via amendment — a key AFA a',
    `primary_superseded_by_amendment_id` BIGINT COMMENT 'Reference to a later amendment that supersedes or replaces this amendment. Used to maintain the chain of agreement versions for audit and enforceability.',
    `profile_id` BIGINT COMMENT 'Reference to the client party to the agreement being amended. Enables client-level amendment tracking and reporting.',
    `rate_card_id` BIGINT COMMENT 'Foreign key linking to service.rate_card. Business justification: Amendments formalize annual rate increases or renegotiated rates. Linking amendment to rate_card creates an audit trail of rate changes via amendment — a regulatory and billing compliance requirement ',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.register. Business justification: Material amendments (changed liability, new jurisdiction, expanded scope) trigger new risk register entries. Legal risk teams formally log amendment-driven risks separately from the base contract risk',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Amendments are frequently triggered by regulatory changes (GDPR updates, SRA rule changes, FCA guidance). Compliance teams track which regulatory obligation mandated each amendment for audit trails an',
    `request_id` BIGINT COMMENT 'Foreign key linking to intake.request. Business justification: Contract amendments (scope expansions, fee changes) require a new intake request for conflict re-check and internal approval. Linking amendment to the triggering intake request supports change managem',
    `sla_template_id` BIGINT COMMENT 'Foreign key linking to service.sla_template. Business justification: Amendments may modify SLA commitments (e.g., upgrading response time targets). Linking amendment to sla_template enables tracking of SLA changes via amendment — a key contract performance management a',
    `amendment_description` STRING COMMENT 'Detailed narrative describing the changes introduced by this amendment, including clauses modified, obligations added or removed, and business rationale.',
    `amendment_number` STRING COMMENT 'Sequential or hierarchical amendment identifier (e.g., Amendment 1, Amendment 2.1). Business-facing reference number for the amendment.',
    `amendment_type` STRING COMMENT 'Classification of the amendment instrument: amendment (formal modification), addendum (supplemental terms), side letter (ancillary agreement), variation (scope change), waiver (temporary relief), novation (party substitution).. Valid values are `amendment|addendum|side_letter|variation|waiver|novation`',
    `approval_date` DATE COMMENT 'Date on which internal approval was granted for the amendment. Null if no approval was required or approval is still pending.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this amendment required formal internal approval (e.g., management committee, conflicts committee) before execution. True if approval was required, False otherwise.',
    `clauses_modified` STRING COMMENT 'Comma-separated list or structured reference to the specific clauses, sections, or articles of the parent agreement that are modified by this amendment (e.g., Section 3.2, Exhibit A, Schedule 1).',
    `confidentiality_level` STRING COMMENT 'Classification of the amendment documents confidentiality: standard (normal business confidential), highly_confidential (restricted distribution), attorney_client_privileged (protected by Legal Professional Privilege - LPP), work_product (attorney work product doctrine protection).. Valid values are `standard|highly_confidential|attorney_client_privileged|work_product`',
    `counterparty_signatory_name` STRING COMMENT 'Name of the individual who signed the amendment on behalf of the counterparty.',
    `counterparty_signatory_title` STRING COMMENT 'Job title or role of the counterparty signatory (e.g., Chief Legal Officer, General Counsel, Authorized Signatory).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this amendment record was first created in the system. Audit trail for data lineage.',
    `effective_date` DATE COMMENT 'Date on which the amendment becomes legally binding and enforceable. May differ from execution date if amendment specifies retroactive or future effectiveness.',
    `execution_date` DATE COMMENT 'Date on which all required parties signed the amendment, completing the execution process.',
    `execution_status` STRING COMMENT 'Current lifecycle state of the amendment: draft (being prepared), pending_review (under legal review), pending_approval (awaiting internal approval), pending_signature (awaiting party signatures), fully_executed (all parties signed), superseded (replaced by later amendment), void (cancelled before execution). [ENUM-REF-CANDIDATE: draft|pending_review|pending_approval|pending_signature|fully_executed|superseded|void — 7 candidates stripped; promote to reference product]',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Monetary value of the financial change introduced by the amendment (e.g., fee increase, discount, additional retainer). Positive for revenue increases, negative for reductions.',
    `financial_impact_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the financial impact amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `firm_signatory_name` STRING COMMENT 'Name of the individual who signed the amendment on behalf of the law firm.',
    `firm_signatory_title` STRING COMMENT 'Job title or role of the firm signatory (e.g., Managing Partner, Practice Group Leader).',
    `governing_law` STRING COMMENT 'Jurisdiction whose laws govern the interpretation and enforcement of the amendment (e.g., New York, England and Wales, Delaware). May differ from the parent agreement if explicitly stated.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this amendment is currently active and enforceable. False if the amendment has been superseded, voided, or the parent agreement has been terminated.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this amendment record was last modified. Audit trail for data lineage and change tracking.',
    `new_expiration_date` DATE COMMENT 'Revised expiration or termination date of the agreement as a result of this amendment. Null if amendment does not change the expiration date.',
    `notes` STRING COMMENT 'Free-text field for internal notes, comments, or special instructions related to the amendment. May include negotiation history, special handling requirements, or follow-up actions.',
    `notice_period_days` STRING COMMENT 'Number of days advance notice required for termination or modification as revised by this amendment. Null if amendment does not affect notice provisions.',
    `reason` STRING COMMENT 'Primary business driver for the amendment: scope_change (work scope modification), fee_adjustment (rate or billing changes), term_extension (duration change), party_change (novation or assignment), compliance_update (regulatory requirement), error_correction (fix to original agreement), commercial_renegotiation (business terms revision), force_majeure (unforeseen event accommodation), other. [ENUM-REF-CANDIDATE: scope_change|fee_adjustment|term_extension|party_change|compliance_update|error_correction|commercial_renegotiation|force_majeure|other — 9 candidates stripped; promote to reference product]',
    `retention_end_date` DATE COMMENT 'Date after which the amendment record may be eligible for archival or destruction per the firms records retention policy and applicable regulatory requirements.',
    `term_extension_months` STRING COMMENT 'Number of months by which the agreement term is extended by this amendment. Null if amendment does not affect term duration.',
    `title` STRING COMMENT 'Short descriptive title or subject of the amendment (e.g., Fee Schedule Adjustment, Scope Extension for IP Portfolio Work).',
    `to_agreement` BIGINT COMMENT 'FK to contract.agreement.agreement_id — Every amendment modifies a specific parent agreement. This is a core parent-child FK required for maintaining the chain of agreement versions.',
    `version_number` STRING COMMENT 'Internal version number tracking iterations of the amendment document during drafting and negotiation. Increments with each revision before final execution.',
    CONSTRAINT pk_amendment PRIMARY KEY(`amendment_id`)
) COMMENT 'Records every formal amendment, addendum, side letter, or variation to an executed agreement. Stores amendment number, amendment type, description of changes, effective date of amendment, parties consenting, execution status, and reference to the redlined document version in the DMS. Maintains the chain of agreement versions for legal enforceability and audit purposes.';

CREATE OR REPLACE TABLE `legal_ecm`.`contract`.`execution_record` (
    `execution_record_id` BIGINT COMMENT 'Unique identifier for the execution record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Reference to the contract or agreement that was executed. Links this execution event to the parent contract entity.',
    `amendment_id` BIGINT COMMENT 'Foreign key linking to contract.amendment. Business justification: An execution_record captures the formal signing event for an agreement artifact. When an amendment is executed (signed), a corresponding execution_record is created. Adding amendment_id to execution_r',
    `doc_version_id` BIGINT COMMENT 'Foreign key linking to document.doc_version. Business justification: Execution records must reference the exact document version that was signed for legal enforceability and audit purposes. The existing executed_document_version plain-text field is a denormalization of',
    `legal_document_id` BIGINT COMMENT 'Reference identifier or URI to the executed document stored in the Document Management System (DMS). Links this execution record to the authoritative signed document artifact.',
    `letter_of_engagement_id` BIGINT COMMENT 'Foreign key linking to intake.letter_of_engagement. Business justification: The LOE is the pre-execution authorization document; the execution_record is the post-execution record. Linking them provides execution authorization audit trail — legal risk and compliance teams requ',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter under which this execution was performed, linking the execution event to the broader legal engagement or case.',
    `profile_id` BIGINT COMMENT 'Reference to the client on whose behalf the agreement was executed, linking the execution record to the client entity.',
    `contract_party_id` BIGINT COMMENT 'Foreign key linking to contract.contract_party. Business justification: execution_record captures signatory details (signatory_name, signatory_title, counterparty_signatory_name) as free-text strings. contract_party is the authoritative registry of all parties and signato',
    `audit_trail_reference` STRING COMMENT 'Reference identifier to the detailed audit trail or log file capturing the complete execution workflow, particularly for electronic signatures and compliance-sensitive executions.',
    `binding_effective_date` DATE COMMENT 'The date on which the executed agreement became legally effective and binding. May differ from execution date if the agreement specifies a delayed effective date.',
    `board_resolution_reference` STRING COMMENT 'Reference to the board resolution or corporate authorization that empowered the signatory to execute the agreement on behalf of the organization, if applicable.',
    `counterparty_execution_date` DATE COMMENT 'The date on which the counterparty executed the agreement. May differ from the primary execution date in counterpart execution scenarios.',
    `counterparty_signatory_name` STRING COMMENT 'Full legal name of the individual who signed on behalf of the counterparty.',
    `counterparty_signatory_title` STRING COMMENT 'Official title or role of the counterparty signatory at the time of execution.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this execution record was first created in the system.',
    `electronic_signature_certificate_reference` STRING COMMENT 'Digital certificate identifier associated with the electronic signature, providing cryptographic proof of authenticity.',
    `electronic_signature_platform` STRING COMMENT 'Name of the electronic signature platform or service used for execution (e.g., DocuSign, Adobe Sign, HelloSign), if applicable.',
    `electronic_signature_transaction_reference` STRING COMMENT 'Unique transaction or envelope identifier assigned by the electronic signature platform, used for audit trail and verification.',
    `executing_party_name` STRING COMMENT 'Legal name of the party (organization or individual) on whose behalf the agreement was executed.',
    `execution_date` DATE COMMENT 'The date on which the agreement was formally executed and became legally binding. This is the principal business event timestamp for the execution record.',
    `execution_location` STRING COMMENT 'Physical location (city, office, venue) where the execution took place, if applicable.',
    `execution_method` STRING COMMENT 'The method by which the agreement was executed: wet ink (physical signature), electronic signature (e.g., DocuSign), notarized, deed, counterpart execution, or escrow.. Valid values are `wet_ink|electronic_signature|notarized|deed|counterpart|escrow`',
    `execution_notes` STRING COMMENT 'Free-text notes or comments regarding the execution event, including any special circumstances, conditions, or observations recorded by the responsible attorney or legal operations team.',
    `execution_of_agreement` BIGINT COMMENT 'FK to contract.agreement.agreement_id — The execution record captures when and how a specific agreement became binding. This is the legally authoritative link between the execution event and the agreement.',
    `execution_reference_number` STRING COMMENT 'Business-facing reference number or code assigned to this execution event for tracking and audit purposes.',
    `execution_sequence_number` STRING COMMENT 'Sequential number indicating the order of execution events for the same contract, used to track amendments, renewals, and counterpart executions.',
    `execution_status` STRING COMMENT 'Current lifecycle status of the execution record: pending (awaiting signatures), partially executed (some but not all parties have signed), fully executed (all parties have signed), voided (execution invalidated), or superseded (replaced by a new execution).. Valid values are `pending|partially_executed|fully_executed|voided|superseded`',
    `execution_timestamp` TIMESTAMP COMMENT 'Precise timestamp (including time of day) when the execution event occurred, particularly relevant for electronic signatures and time-sensitive agreements.',
    `execution_to_agreement` BIGINT COMMENT 'FK to contract.agreement.agreement_id — Each execution record captures the formal execution event for a specific agreement. One-to-one or one-to-many (multi-party sequential execution) relationship.',
    `execution_type` STRING COMMENT 'Classification of the execution event: original (first execution of the agreement), amendment (execution of an amendment), renewal (execution of a renewal), counterpart (execution of a counterpart copy), or duplicate (duplicate execution for record purposes).. Valid values are `original|amendment|renewal|counterpart|duplicate`',
    `is_active` BOOLEAN COMMENT 'Indicates whether this execution record is currently active and valid. False if the execution has been voided, superseded, or archived.',
    `is_binding_flag` BOOLEAN COMMENT 'Indicates whether this execution event resulted in a legally binding agreement. False if execution was conditional, incomplete, or subsequently invalidated.',
    `is_original_execution_flag` BOOLEAN COMMENT 'Indicates whether this is the original execution record for the agreement (true) or a subsequent execution event such as an amendment or counterpart (false).',
    `jurisdiction_of_execution` STRING COMMENT 'The legal jurisdiction (state, province, country) in which the execution took place. Relevant for determining applicable execution formalities and legal validity.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this execution record was last modified or updated.',
    `notary_commission_expiry_date` DATE COMMENT 'Expiration date of the notary publics commission at the time of notarization.',
    `notary_commission_number` STRING COMMENT 'Official commission or registration number of the notary public, as issued by the relevant state or jurisdiction.',
    `notary_name` STRING COMMENT 'Full legal name of the notary public who notarized the execution, if applicable.',
    `notary_seal_affixed_flag` BOOLEAN COMMENT 'Indicates whether the notary publics official seal was affixed to the executed document.',
    `power_of_attorney_reference` STRING COMMENT 'Reference to the Power of Attorney document or authorization under which the signatory executed the agreement, if applicable.',
    `signatory_capacity` STRING COMMENT 'The legal capacity in which the signatory executed the agreement (e.g., individual, corporate officer, attorney-in-fact, trustee, executor).',
    `signatory_name` STRING COMMENT 'Full legal name of the individual who signed the agreement on behalf of the executing party.',
    `signatory_title` STRING COMMENT 'Official title or role of the signatory at the time of execution (e.g., Chief Executive Officer, General Counsel, Authorized Signatory).',
    `witness_address` STRING COMMENT 'Address of the witness, required in certain jurisdictions for deed execution and notarization.',
    `witness_name` STRING COMMENT 'Full legal name of the witness who attested to the execution, if applicable. Required for certain deed and notarized executions.',
    CONSTRAINT pk_execution_record PRIMARY KEY(`execution_record_id`)
) COMMENT 'Captures the formal execution event for an agreement, recording execution method (wet ink, electronic signature, notarized, deed), execution date per party, signatory name and title, witness details, notary details where applicable, jurisdiction of execution, and the executed document reference in the DMS. Provides the legally authoritative record of when and how an agreement became binding.';

CREATE OR REPLACE TABLE `legal_ecm`.`contract`.`termination` (
    `termination_id` BIGINT COMMENT 'Unique identifier for the contract termination record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Reference to the contract or agreement that has been terminated. Links to the parent contract record in the contract domain.',
    `check_id` BIGINT COMMENT 'Foreign key linking to conflict.conflict_check. Business justification: Contract terminations, especially disputed ones, may require conflict re-assessment when the firm considers representing a party in termination disputes or when adverse relationships emerge. The exist',
    `clause_library_id` BIGINT COMMENT 'Foreign key linking to contract.clause_library. Business justification: termination.contractual_clause_reference is a free-text string referencing the clause that grants the termination right. clause_library is the authoritative clause repository. Adding clause_library_id',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Terminations driven by internal compliance policy breaches (AML/KYC policy, conflicts policy, data protection policy) must reference the specific policy breached. SRA compliance and internal audit req',
    `contact_id` BIGINT COMMENT 'Reference to the contact record of the individual who formally issued the termination notice on behalf of the terminating party.',
    `docket_id` BIGINT COMMENT 'Foreign key linking to court.docket. Business justification: Breach-based contract terminations frequently trigger litigation. Legal teams must link terminations to resulting court proceedings for dispute tracking, damages calculation, and litigation strategy. ',
    `judgment_id` BIGINT COMMENT 'Foreign key linking to matter.judgment. Business justification: Court-ordered contract termination is a named legal process — a judgment may order or confirm termination of a contract. termination has dispute_flag and dispute_resolution_method; when litigation res',
    `legal_document_id` BIGINT COMMENT 'Reference to the termination notice document, settlement agreement, or related correspondence stored in the Document Management System (DMS - iManage Work or NetDocuments).',
    `matter_id` BIGINT COMMENT 'Reference to the matter under which the termination was processed, if applicable. Links termination to the legal work performed.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to contract.obligation. Business justification: Terminations are often triggered by a specific obligation breach or a termination-for-cause obligation in the agreement. Adding obligation_id to termination links the termination event to the specific',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.register. Business justification: Terminations — especially disputed ones with penalties and regulatory reporting obligations — generate standalone risk register entries. termination.risk_category is a denormalized risk classification',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Contract terminations can be mandated by regulatory obligations — sanctions screening failures, AML red flags, or regulatory prohibitions on continuing a client relationship. Compliance and MLRO teams',
    `contract_party_id` BIGINT COMMENT 'Foreign key linking to contract.contract_party. Business justification: termination.terminating_party_name and terminating_party_type are denormalized string references to the party exercising the termination right. contract_party is the authoritative registry of all part',
    `approval_date` DATE COMMENT 'The date on which the termination was formally approved by the required authority.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether the termination required internal approval (e.g., from General Counsel, Chief Legal Officer, or management committee). True if approval was required; False otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the termination record was first created in the system. Audit trail field.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the financial impact amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `dispute_description` STRING COMMENT 'Narrative description of the nature of the dispute, including the disputing partys objections, claims, or counterclaims related to the termination.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the termination is disputed or contested by any party. True if the termination is under dispute; False otherwise.',
    `dispute_resolution_method` STRING COMMENT 'The method being used or planned to resolve the termination dispute: negotiation, mediation, arbitration (ADR - Alternative Dispute Resolution), litigation, or none if no dispute exists.. Valid values are `negotiation|mediation|arbitration|litigation|none`',
    `effective_termination_date` DATE COMMENT 'The date on which the contract termination becomes legally effective and the agreement ceases to bind the parties (except for surviving obligations).',
    `external_system_reference` STRING COMMENT 'External identifier or reference number from the source system of record (e.g., Elite 3E termination record ID, contract management system reference).',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'The estimated or actual financial impact of the termination on the firm, including lost revenue, penalties, settlement costs, or write-offs.',
    `grounds_for_termination` STRING COMMENT 'Detailed narrative explanation of the legal, contractual, or business grounds cited for the termination, including reference to specific contract clauses or breaches.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this termination record is currently active and valid. True if active; False if superseded, withdrawn, or archived.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when the termination record was last modified or updated. Audit trail field.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the termination, including internal observations, lessons learned, or special handling instructions.',
    `notice_date` DATE COMMENT 'The date on which formal notice of termination was given to the counterparty, triggering any contractual notice period.',
    `notice_period_days` STRING COMMENT 'The number of days of advance notice required by the contract before termination becomes effective, as specified in the termination clause.',
    `of_agreement` BIGINT COMMENT 'FK to contract.agreement.agreement_id — Termination records the end-of-life event for a specific agreement. FK required for compliance reporting and PI risk registers.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Any contractual penalty, liquidated damages, or early termination fee payable as a result of the termination.',
    `post_termination_obligations` STRING COMMENT 'Description of contractual obligations that survive termination, such as confidentiality, non-compete, indemnity, data return, or wind-down duties.',
    `refund_amount` DECIMAL(18,2) COMMENT 'Any refund or reimbursement due to the client or counterparty as a result of the termination (e.g., unused retainer, prepaid fees).',
    `regulatory_report_date` DATE COMMENT 'The date on which the termination was reported to the relevant regulatory or oversight body, if required.',
    `regulatory_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether the termination must be reported to a regulatory body, bar association, or oversight authority (e.g., SRA, State Bar). True if reporting is required; False otherwise.',
    `settlement_date` DATE COMMENT 'The date on which the termination dispute was formally settled or resolved between the parties.',
    `settlement_reached_flag` BOOLEAN COMMENT 'Indicates whether a settlement or resolution has been reached regarding the termination dispute. True if settled; False otherwise.',
    `settlement_terms` STRING COMMENT 'Summary of the key terms and conditions agreed upon in the settlement of the termination dispute, including any financial or performance obligations.',
    `surviving_clauses` STRING COMMENT 'List or citation of specific contract clauses that expressly survive termination (e.g., Sections 8 (Confidentiality), 10 (Indemnity), 14 (Governing Law)).',
    `termination_status` STRING COMMENT 'Current lifecycle status of the termination: pending (notice given but not yet effective), effective (termination complete), disputed (contested by one or more parties), settled (dispute resolved), withdrawn (termination notice retracted).. Valid values are `pending|effective|disputed|settled|withdrawn`',
    `termination_type` STRING COMMENT 'Classification of the termination event: expiry (natural end of term), termination for convenience (voluntary exit without cause), termination for cause (breach or default), mutual rescission (agreed cancellation), frustration (impossibility of performance), or breach (material violation).. Valid values are `expiry|termination_for_convenience|termination_for_cause|mutual_rescission|frustration|breach`',
    `to_agreement` BIGINT COMMENT 'FK to contract.agreement.agreement_id — Each termination record documents the end of a specific agreement. Critical for compliance reporting and PI risk registers.',
    `wind_down_completion_date` DATE COMMENT 'The date by which all wind-down activities, handovers, and post-termination obligations are expected to be completed.',
    `wind_down_period_days` STRING COMMENT 'The number of days allowed or required for orderly wind-down of services, handover of work product, or transition activities following the effective termination date.',
    CONSTRAINT pk_termination PRIMARY KEY(`termination_id`)
) COMMENT 'Records the termination or expiry of an agreement, capturing termination type (expiry, termination for convenience, termination for cause, mutual rescission, frustration), effective termination date, notice date, terminating party, grounds for termination, dispute flag, post-termination obligations surviving, and settlement or wind-down terms. Feeds compliance reporting and professional indemnity risk registers.';

CREATE OR REPLACE TABLE `legal_ecm`.`contract`.`clause_library` (
    `clause_library_id` BIGINT COMMENT 'Primary key for clause_library',
    `agreement_type_id` BIGINT COMMENT 'Foreign key linking to contract.agreement_type. Business justification: clause_library contains approved clauses that are specific to certain agreement types (e.g., NDA confidentiality clauses, SPA warranty clauses, LOE scope-of-work clauses). Adding agreement_type_id to ',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Standard clauses implement firm compliance policies (indemnity clause per risk policy, data protection clause per privacy policy, payment terms per finance policy). Clause approval workflows verify po',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to matter.jurisdiction. Business justification: clause_library has plain text jurisdiction_applicability (denormalized). Normalizing to matter.jurisdiction enables jurisdiction-filtered clause retrieval during contract drafting — a core legal kno',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Clause library entries are scoped to specific practice areas (IP indemnity clauses, employment non-compete clauses, M&A representations). Linking enables practice-area-specific clause retrieval during',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Clauses are drafted specifically to satisfy regulatory obligations (GDPR data processing clauses, AML representation clauses, sanctions clauses). Compliance teams maintain clause-to-obligation mapping',
    `superseded_by_clause_clause_library_id` BIGINT COMMENT 'Identifier of the clause that supersedes this one when this clause is deprecated or replaced. Maintains version lineage and ensures users are directed to the current approved version.',
    `aml_kyc_required_flag` BOOLEAN COMMENT 'Indicates whether the clause includes or requires Anti-Money Laundering (AML) and Know Your Client (KYC) provisions for client identification and due diligence.',
    `approval_date` DATE COMMENT 'Date when the clause text was formally approved by the knowledge management committee or authorized practice group leader for inclusion in the clause library.',
    `approved_text` STRING COMMENT 'The full approved legal text of the clause as vetted and authorized by the knowledge management team, practice group leaders, and General Counsel (GC). This is the primary version for use in client-facing agreements.',
    `clause_category` STRING COMMENT 'High-level business category grouping clauses by strategic purpose: risk allocation, compliance, operational, commercial, dispute resolution, or termination provisions.. Valid values are `risk_allocation|compliance|operational|commercial|dispute_resolution|termination`',
    `clause_library_description` STRING COMMENT 'Detailed description of the clause purpose, legal effect, and guidance on when and how to use it. Includes notes on negotiation strategy and common counterparty objections.',
    `clause_library_status` STRING COMMENT 'Current lifecycle status of the clause: active (approved for use), under review (being evaluated), deprecated (no longer recommended), archived (historical reference only), or draft (not yet approved).. Valid values are `active|under_review|deprecated|archived|draft`',
    `clause_type` STRING COMMENT 'Classification of the clause by legal function. Common types include indemnity, limitation of liability, governing law, force majeure, Intellectual Property (IP) assignment, confidentiality, Fair Reasonable and Non-Discriminatory (FRAND), and Alternative Dispute Resolution (ADR) arbitration provisions. [ENUM-REF-CANDIDATE: indemnity|limitation_of_liability|governing_law|force_majeure|ip_assignment|confidentiality|frand|arbitration|termination|warranty|data_protection|audit_rights|insurance|severability|entire_agreement|amendment|waiver|notice|assignment|subcontracting — promote to reference product]. Valid values are `indemnity|limitation_of_liability|governing_law|force_majeure|ip_assignment|confidentiality`',
    `confidentiality_level` STRING COMMENT 'Data classification level of the clause content itself: public (can be shared externally), internal (firm use only), confidential (restricted to authorized personnel), or restricted (highly sensitive, limited access).. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this clause library entry was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when this clause version is no longer valid for use in new contracts. Null indicates the clause is currently effective with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date from which this clause version becomes effective and available for use in new contracts.',
    `external_source_reference` STRING COMMENT 'Reference to external standard clause guidance sources such as Thomson Reuters Practical Law, LexisNexis, American Bar Association (ABA) model clauses, or International Chamber of Commerce (ICC) standard terms.',
    `fallback_text` STRING COMMENT 'Alternative or fallback clause text to be used when the approved text is not acceptable to the counterparty or when negotiation requires a softer position. Provides flexibility during contract negotiation.',
    `frand_applicable_flag` BOOLEAN COMMENT 'Indicates whether the clause is designed for or applicable to Fair Reasonable and Non-Discriminatory (FRAND) licensing scenarios common in Intellectual Property (IP) and standards-essential patent agreements.',
    `gdpr_compliant_flag` BOOLEAN COMMENT 'Indicates whether the clause has been reviewed and approved for compliance with General Data Protection Regulation (GDPR) requirements for data protection and privacy.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this clause library entry is currently active and available for use. False indicates the clause has been archived or soft-deleted.',
    `keywords` STRING COMMENT 'Comma-separated list of keywords and tags for search and discovery within the clause library. Facilitates Natural Language Processing (NLP) and search functionality in Contract Lifecycle Management (CLM) systems.',
    `language_code` STRING COMMENT 'ISO 639-1 or ISO 639-2 language code indicating the language in which the clause text is written (e.g., en for English, en-US for US English, fr for French, de for German).. Valid values are `^[a-z]{2,3}(-[A-Z]{2})?$`',
    `last_review_date` DATE COMMENT 'Date of the most recent periodic review of the clause for legal accuracy, regulatory compliance, and alignment with current firm standards.',
    `last_used_date` DATE COMMENT 'Date when this clause was most recently included in a contract. Helps identify obsolete or underutilized clauses.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this clause library entry was last modified or updated.',
    `negotiation_notes` STRING COMMENT 'Internal notes and best practices for negotiating this clause with counterparties, including common objections, acceptable modifications, and red lines that should not be crossed.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next mandatory review of the clause to ensure ongoing compliance and relevance.',
    `regulatory_framework` STRING COMMENT 'Comma-separated list of regulatory frameworks or compliance standards that this clause addresses, such as General Data Protection Regulation (GDPR), Sarbanes-Oxley Act (SOX), California Consumer Privacy Act (CCPA), Anti-Money Laundering (AML), Know Your Client (KYC), or Fair Reasonable and Non-Discriminatory (FRAND) licensing requirements.',
    `sox_compliant_flag` BOOLEAN COMMENT 'Indicates whether the clause meets Sarbanes-Oxley Act (SOX) requirements for financial controls, audit rights, and corporate governance in contracts with public companies.',
    `usage_count` STRING COMMENT 'Total number of times this clause has been used in executed contracts. Provides insight into clause popularity and effectiveness.',
    `usage_guidance` STRING COMMENT 'Practical guidance for attorneys on when to use this clause, including recommended matter types, client profiles, transaction structures, and risk scenarios where the clause is most appropriate.',
    `usage_tier` STRING COMMENT 'Designation of the clause usage priority within the firm: mandatory (must be included), preferred (strongly recommended), fallback (use when primary is rejected), optional (discretionary), or deprecated (no longer recommended).. Valid values are `mandatory|preferred|fallback|optional|deprecated`',
    `version_number` STRING COMMENT 'Semantic version number of the clause text following major.minor.patch convention to track revisions and updates over time.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    `word_count` STRING COMMENT 'Total word count of the approved clause text. Used for document assembly planning and readability analysis.',
    CONSTRAINT pk_clause_library PRIMARY KEY(`clause_library_id`)
) COMMENT 'Curated repository of approved standard and fallback clauses maintained by knowledge management and CLM teams. Each clause stores type (indemnity, limitation of liability, governing law, force majeure, IP assignment, confidentiality, FRAND, arbitration), approved text, fallback text, jurisdiction applicability, practice group owner, approval date, and usage tier (mandatory, preferred, fallback). Integrates with external standard clause guidance sources.';

CREATE OR REPLACE TABLE `legal_ecm`.`contract`.`template_clause_assignment` (
    `template_clause_assignment_id` BIGINT COMMENT 'Primary key for the template_clause_assignment association',
    `clause_library_id` BIGINT COMMENT 'Foreign key linking to the clause library entry assigned to this template.',
    `template_id` BIGINT COMMENT 'Foreign key linking to the contract template that contains this clause assignment.',
    `clause_position` STRING COMMENT 'Structural placement descriptor for the clause within the template (e.g., Section 4, Schedule 2, Recital C). Provides human-readable positional context beyond numeric sort order.',
    `effective_date` DATE COMMENT 'Date from which this clause-template pairing became active and operative. Supports versioning of template composition over time — a clause may be added to or removed from a template at a specific date.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this clause is mandatory within this specific template. A clause may be mandatory in one template (e.g., confidentiality in an NDA) but optional in another (e.g., confidentiality in an MSA). Cannot live on either parent entity alone.',
    `override_allowed_flag` BOOLEAN COMMENT 'Indicates whether negotiators are permitted to deviate from or modify this clause when using this template. Override permissions may differ per template — a clause may be locked in a high-risk template but negotiable in a standard commercial template.',
    `sort_order` BIGINT COMMENT 'Numeric sequence position of this clause within the template structure. Determines the order in which clauses appear in the assembled document. Meaningless without the template context.',
    `template_integration_flag` BOOLEAN COMMENT 'Indicates whether this clause is integrated into automated contract templates within the Contract Lifecycle Management (CLM) or Document Management System (DMS) for automated document assembly. [Moved from clause_library: This boolean on clause_library indicates whether a clause is integrated into automated templates, but this is a derived/aggregate property. The ground truth is captured at the assignment level — if any active template_clause_assignment record exists for a clause, it is template-integrated. The flag on clause_library becomes redundant and potentially stale once the association table exists. Consider deprecating it in favour of a computed view over the association table.]',
    CONSTRAINT pk_template_clause_assignment PRIMARY KEY(`template_clause_assignment_id`)
) COMMENT 'This association product represents the deliberate composition relationship between a contract template and a clause from the approved clause library. It captures the operational act of a knowledge management or CLM team assigning a specific clause to a specific template, including whether the clause is mandatory in that template context, its structural position, and whether negotiators may override it. Each record links one template to one clause_library entry with attributes that exist only in the context of this specific template-clause pairing.. Existence Justification: In legal contract lifecycle management, templates are explicitly assembled from a curated library of approved clauses — a template contains many clauses, and a clause is reused across many templates. This is a core operational process actively managed by knowledge management and CLM teams: they assign specific clauses to templates, configure whether each clause is mandatory or optional in that template context, set its position/order, and control override permissions. The relationship is a recognized business concept in CLM systems (iManage, Ironclad, Conga all model this as an explicit junction entity called template clause assignment or similar).';

-- ========= FOREIGN KEYS =========
ALTER TABLE `legal_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_agreement_type_id` FOREIGN KEY (`agreement_type_id`) REFERENCES `legal_ecm`.`contract`.`agreement_type`(`agreement_type_id`);
ALTER TABLE `legal_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_parent_agreement_contract_agreement_id` FOREIGN KEY (`parent_agreement_contract_agreement_id`) REFERENCES `legal_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `legal_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_template_id` FOREIGN KEY (`template_id`) REFERENCES `legal_ecm`.`contract`.`template`(`template_id`);
ALTER TABLE `legal_ecm`.`contract`.`template` ADD CONSTRAINT `fk_contract_template_agreement_type_id` FOREIGN KEY (`agreement_type_id`) REFERENCES `legal_ecm`.`contract`.`agreement_type`(`agreement_type_id`);
ALTER TABLE `legal_ecm`.`contract`.`template` ADD CONSTRAINT `fk_contract_template_superseded_by_template_id` FOREIGN KEY (`superseded_by_template_id`) REFERENCES `legal_ecm`.`contract`.`template`(`template_id`);
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ADD CONSTRAINT `fk_contract_contract_party_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `legal_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `legal_ecm`.`contract`.`obligation` ADD CONSTRAINT `fk_contract_obligation_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `legal_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `legal_ecm`.`contract`.`obligation` ADD CONSTRAINT `fk_contract_obligation_clause_library_id` FOREIGN KEY (`clause_library_id`) REFERENCES `legal_ecm`.`contract`.`clause_library`(`clause_library_id`);
ALTER TABLE `legal_ecm`.`contract`.`obligation` ADD CONSTRAINT `fk_contract_obligation_dependent_obligation_id` FOREIGN KEY (`dependent_obligation_id`) REFERENCES `legal_ecm`.`contract`.`obligation`(`obligation_id`);
ALTER TABLE `legal_ecm`.`contract`.`obligation` ADD CONSTRAINT `fk_contract_obligation_contract_party_id` FOREIGN KEY (`contract_party_id`) REFERENCES `legal_ecm`.`contract`.`contract_party`(`contract_party_id`);
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ADD CONSTRAINT `fk_contract_obligation_event_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `legal_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ADD CONSTRAINT `fk_contract_obligation_event_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `legal_ecm`.`contract`.`amendment`(`amendment_id`);
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ADD CONSTRAINT `fk_contract_obligation_event_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `legal_ecm`.`contract`.`obligation`(`obligation_id`);
ALTER TABLE `legal_ecm`.`contract`.`milestone` ADD CONSTRAINT `fk_contract_milestone_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `legal_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `legal_ecm`.`contract`.`milestone` ADD CONSTRAINT `fk_contract_milestone_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `legal_ecm`.`contract`.`amendment`(`amendment_id`);
ALTER TABLE `legal_ecm`.`contract`.`milestone` ADD CONSTRAINT `fk_contract_milestone_clause_library_id` FOREIGN KEY (`clause_library_id`) REFERENCES `legal_ecm`.`contract`.`clause_library`(`clause_library_id`);
ALTER TABLE `legal_ecm`.`contract`.`milestone` ADD CONSTRAINT `fk_contract_milestone_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `legal_ecm`.`contract`.`obligation`(`obligation_id`);
ALTER TABLE `legal_ecm`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `legal_ecm`.`contract`.`obligation`(`obligation_id`);
ALTER TABLE `legal_ecm`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `legal_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `legal_ecm`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_renewal_successor_contract_agreement_id` FOREIGN KEY (`renewal_successor_contract_agreement_id`) REFERENCES `legal_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `legal_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `legal_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `legal_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_contract_party_id` FOREIGN KEY (`contract_party_id`) REFERENCES `legal_ecm`.`contract`.`contract_party`(`contract_party_id`);
ALTER TABLE `legal_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_parent_amendment_id` FOREIGN KEY (`parent_amendment_id`) REFERENCES `legal_ecm`.`contract`.`amendment`(`amendment_id`);
ALTER TABLE `legal_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_primary_superseded_by_amendment_id` FOREIGN KEY (`primary_superseded_by_amendment_id`) REFERENCES `legal_ecm`.`contract`.`amendment`(`amendment_id`);
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ADD CONSTRAINT `fk_contract_execution_record_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `legal_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ADD CONSTRAINT `fk_contract_execution_record_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `legal_ecm`.`contract`.`amendment`(`amendment_id`);
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ADD CONSTRAINT `fk_contract_execution_record_contract_party_id` FOREIGN KEY (`contract_party_id`) REFERENCES `legal_ecm`.`contract`.`contract_party`(`contract_party_id`);
ALTER TABLE `legal_ecm`.`contract`.`termination` ADD CONSTRAINT `fk_contract_termination_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `legal_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `legal_ecm`.`contract`.`termination` ADD CONSTRAINT `fk_contract_termination_clause_library_id` FOREIGN KEY (`clause_library_id`) REFERENCES `legal_ecm`.`contract`.`clause_library`(`clause_library_id`);
ALTER TABLE `legal_ecm`.`contract`.`termination` ADD CONSTRAINT `fk_contract_termination_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `legal_ecm`.`contract`.`obligation`(`obligation_id`);
ALTER TABLE `legal_ecm`.`contract`.`termination` ADD CONSTRAINT `fk_contract_termination_contract_party_id` FOREIGN KEY (`contract_party_id`) REFERENCES `legal_ecm`.`contract`.`contract_party`(`contract_party_id`);
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ADD CONSTRAINT `fk_contract_clause_library_agreement_type_id` FOREIGN KEY (`agreement_type_id`) REFERENCES `legal_ecm`.`contract`.`agreement_type`(`agreement_type_id`);
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ADD CONSTRAINT `fk_contract_clause_library_superseded_by_clause_clause_library_id` FOREIGN KEY (`superseded_by_clause_clause_library_id`) REFERENCES `legal_ecm`.`contract`.`clause_library`(`clause_library_id`);
ALTER TABLE `legal_ecm`.`contract`.`template_clause_assignment` ADD CONSTRAINT `fk_contract_template_clause_assignment_clause_library_id` FOREIGN KEY (`clause_library_id`) REFERENCES `legal_ecm`.`contract`.`clause_library`(`clause_library_id`);
ALTER TABLE `legal_ecm`.`contract`.`template_clause_assignment` ADD CONSTRAINT `fk_contract_template_clause_assignment_template_id` FOREIGN KEY (`template_id`) REFERENCES `legal_ecm`.`contract`.`template`(`template_id`);

-- ========= TAGS =========
ALTER SCHEMA `legal_ecm`.`contract` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `legal_ecm`.`contract` SET TAGS ('dbx_domain' = 'contract');
ALTER TABLE `legal_ecm`.`contract`.`agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`contract`.`agreement` SET TAGS ('dbx_subdomain' = 'agreement_management');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement ID');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `agreement_type_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `aml_kyc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Kyc Program Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Client Contact Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `data_privacy_register_id` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `delivery_model_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Model Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `engagement_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Opportunity Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `kyc_record_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Record Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `outside_counsel_guideline_id` SET TAGS ('dbx_business_glossary_term' = 'Outside Counsel Guideline Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `parent_agreement_contract_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Agreement ID');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `pricing_model_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `rfp_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Rfp Submission Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `sla_template_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Template Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `template_id` SET TAGS ('dbx_business_glossary_term' = 'Template ID');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `aml_kyc_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Know Your Client (KYC) Verified Flag');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'Pending Approval|Approved|Rejected|Conditional Approval');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `confidentiality_classification` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Classification');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `confidentiality_classification` SET TAGS ('dbx_value_regex' = 'Public|Internal|Confidential|Restricted|Highly Restricted');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `contract_value` SET TAGS ('dbx_business_glossary_term' = 'Contract Value');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `contract_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `counterparty_name` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Name');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `counterparty_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `counterparty_type` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Type');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `document_storage_path` SET TAGS ('dbx_business_glossary_term' = 'Document Storage Path');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `gdpr_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Compliant Flag');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `indemnity_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Indemnity Clause Flag');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `limitation_of_liability_flag` SET TAGS ('dbx_business_glossary_term' = 'Limitation of Liability Flag');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `lpp_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Professional Privilege (LPP) Flag');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `originating_office` SET TAGS ('dbx_business_glossary_term' = 'Originating Office');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Agreement Title');
ALTER TABLE `legal_ecm`.`contract`.`agreement` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `legal_ecm`.`contract`.`agreement_type` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `legal_ecm`.`contract`.`agreement_type` SET TAGS ('dbx_subdomain' = 'agreement_management');
ALTER TABLE `legal_ecm`.`contract`.`agreement_type` ALTER COLUMN `agreement_type_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type Identifier (ID)');
ALTER TABLE `legal_ecm`.`contract`.`agreement_type` ALTER COLUMN `pricing_model_id` SET TAGS ('dbx_business_glossary_term' = 'Default Pricing Model Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`agreement_type` ALTER COLUMN `sla_template_id` SET TAGS ('dbx_business_glossary_term' = 'Default Sla Template Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`agreement_type` ALTER COLUMN `agreement_type_category` SET TAGS ('dbx_business_glossary_term' = 'Agreement Category');
ALTER TABLE `legal_ecm`.`contract`.`agreement_type` ALTER COLUMN `agreement_type_category` SET TAGS ('dbx_value_regex' = 'client_engagement|vendor_supplier|internal_administrative|regulatory_compliance|intellectual_property|dispute_resolution');
ALTER TABLE `legal_ecm`.`contract`.`agreement_type` ALTER COLUMN `aml_kyc_required` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) and Know Your Client (KYC) Required Flag');
ALTER TABLE `legal_ecm`.`contract`.`agreement_type` ALTER COLUMN `approval_workflow_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow Required Flag');
ALTER TABLE `legal_ecm`.`contract`.`agreement_type` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `legal_ecm`.`contract`.`agreement_type` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `legal_ecm`.`contract`.`agreement_type` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|highly_confidential|attorney_client_privileged');
ALTER TABLE `legal_ecm`.`contract`.`agreement_type` ALTER COLUMN `conflict_check_required` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Required Flag');
ALTER TABLE `legal_ecm`.`contract`.`agreement_type` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm`.`contract`.`agreement_type` ALTER COLUMN `default_dispute_resolution` SET TAGS ('dbx_business_glossary_term' = 'Default Dispute Resolution Method');
ALTER TABLE `legal_ecm`.`contract`.`agreement_type` ALTER COLUMN `default_dispute_resolution` SET TAGS ('dbx_value_regex' = 'litigation|arbitration|mediation|negotiation');
ALTER TABLE `legal_ecm`.`contract`.`agreement_type` ALTER COLUMN `default_governing_law` SET TAGS ('dbx_business_glossary_term' = 'Default Governing Law Jurisdiction');
ALTER TABLE `legal_ecm`.`contract`.`agreement_type` ALTER COLUMN `default_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Default Notice Period in Days');
ALTER TABLE `legal_ecm`.`contract`.`agreement_type` ALTER COLUMN `default_term_months` SET TAGS ('dbx_business_glossary_term' = 'Default Term in Months');
ALTER TABLE `legal_ecm`.`contract`.`agreement_type` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `legal_ecm`.`contract`.`agreement_type` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `legal_ecm`.`contract`.`agreement_type` ALTER COLUMN `electronic_signature_allowed` SET TAGS ('dbx_business_glossary_term' = 'Electronic Signature Allowed Flag');
ALTER TABLE `legal_ecm`.`contract`.`agreement_type` ALTER COLUMN `financial_threshold_usd` SET TAGS ('dbx_business_glossary_term' = 'Financial Threshold in United States Dollars (USD)');
ALTER TABLE `legal_ecm`.`contract`.`agreement_type` ALTER COLUMN `frand_applicable` SET TAGS ('dbx_business_glossary_term' = 'Fair Reasonable and Non-Discriminatory (FRAND) Applicable Flag');
ALTER TABLE `legal_ecm`.`contract`.`agreement_type` ALTER COLUMN `gdpr_applicable` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Applicable Flag');
ALTER TABLE `legal_ecm`.`contract`.`agreement_type` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Status Flag');
ALTER TABLE `legal_ecm`.`contract`.`agreement_type` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`contract`.`agreement_type` ALTER COLUMN `ledes_billing_code` SET TAGS ('dbx_business_glossary_term' = 'Legal Electronic Data Exchange Standard (LEDES) Billing Code');
ALTER TABLE `legal_ecm`.`contract`.`agreement_type` ALTER COLUMN `ledes_billing_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `legal_ecm`.`contract`.`agreement_type` ALTER COLUMN `milestone_tracking_required` SET TAGS ('dbx_business_glossary_term' = 'Milestone Tracking Required Flag');
ALTER TABLE `legal_ecm`.`contract`.`agreement_type` ALTER COLUMN `party_type` SET TAGS ('dbx_business_glossary_term' = 'Party Type');
ALTER TABLE `legal_ecm`.`contract`.`agreement_type` ALTER COLUMN `party_type` SET TAGS ('dbx_value_regex' = 'bilateral|multilateral|unilateral');
ALTER TABLE `legal_ecm`.`contract`.`agreement_type` ALTER COLUMN `requires_countersignature` SET TAGS ('dbx_business_glossary_term' = 'Requires Countersignature Flag');
ALTER TABLE `legal_ecm`.`contract`.`agreement_type` ALTER COLUMN `requires_notarization` SET TAGS ('dbx_business_glossary_term' = 'Requires Notarization Flag');
ALTER TABLE `legal_ecm`.`contract`.`agreement_type` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period in Years');
ALTER TABLE `legal_ecm`.`contract`.`agreement_type` ALTER COLUMN `sort_order` SET TAGS ('dbx_business_glossary_term' = 'Display Sort Order');
ALTER TABLE `legal_ecm`.`contract`.`agreement_type` ALTER COLUMN `sox_applicable` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley Act (SOX) Applicable Flag');
ALTER TABLE `legal_ecm`.`contract`.`agreement_type` ALTER COLUMN `template_available` SET TAGS ('dbx_business_glossary_term' = 'Template Available Flag');
ALTER TABLE `legal_ecm`.`contract`.`agreement_type` ALTER COLUMN `type_code` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type Code');
ALTER TABLE `legal_ecm`.`contract`.`agreement_type` ALTER COLUMN `type_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `legal_ecm`.`contract`.`agreement_type` ALTER COLUMN `type_description` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type Description');
ALTER TABLE `legal_ecm`.`contract`.`agreement_type` ALTER COLUMN `type_name` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type Name');
ALTER TABLE `legal_ecm`.`contract`.`agreement_type` ALTER COLUMN `utbms_task_code` SET TAGS ('dbx_business_glossary_term' = 'Uniform Task-Based Management System (UTBMS) Task Code');
ALTER TABLE `legal_ecm`.`contract`.`agreement_type` ALTER COLUMN `utbms_task_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{3}$');
ALTER TABLE `legal_ecm`.`contract`.`template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`contract`.`template` SET TAGS ('dbx_subdomain' = 'agreement_management');
ALTER TABLE `legal_ecm`.`contract`.`template` ALTER COLUMN `template_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Template ID');
ALTER TABLE `legal_ecm`.`contract`.`template` ALTER COLUMN `agreement_type_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`template` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`template` ALTER COLUMN `doc_template_id` SET TAGS ('dbx_business_glossary_term' = 'Doc Template Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`template` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`template` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`template` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`template` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`template` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`template` ALTER COLUMN `sla_template_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Template Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`template` ALTER COLUMN `superseded_by_template_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Template ID');
ALTER TABLE `legal_ecm`.`contract`.`template` ALTER COLUMN `access_control_level` SET TAGS ('dbx_business_glossary_term' = 'Access Control Level');
ALTER TABLE `legal_ecm`.`contract`.`template` ALTER COLUMN `access_control_level` SET TAGS ('dbx_value_regex' = 'public|practice_group|partner_only|restricted');
ALTER TABLE `legal_ecm`.`contract`.`template` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm`.`contract`.`template` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `legal_ecm`.`contract`.`template` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional');
ALTER TABLE `legal_ecm`.`contract`.`template` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `legal_ecm`.`contract`.`template` ALTER COLUMN `client_facing_flag` SET TAGS ('dbx_business_glossary_term' = 'Client Facing Flag');
ALTER TABLE `legal_ecm`.`contract`.`template` ALTER COLUMN `compliance_tags` SET TAGS ('dbx_business_glossary_term' = 'Compliance Tags');
ALTER TABLE `legal_ecm`.`contract`.`template` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`contract`.`template` ALTER COLUMN `dms_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Management System (DMS) Document ID');
ALTER TABLE `legal_ecm`.`contract`.`template` ALTER COLUMN `dms_folder_path` SET TAGS ('dbx_business_glossary_term' = 'Document Management System (DMS) Folder Path');
ALTER TABLE `legal_ecm`.`contract`.`template` ALTER COLUMN `document_format` SET TAGS ('dbx_business_glossary_term' = 'Document Format');
ALTER TABLE `legal_ecm`.`contract`.`template` ALTER COLUMN `document_format` SET TAGS ('dbx_value_regex' = 'docx|pdf|rtf|odt|html');
ALTER TABLE `legal_ecm`.`contract`.`template` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `legal_ecm`.`contract`.`template` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `legal_ecm`.`contract`.`template` ALTER COLUMN `industry_sector` SET TAGS ('dbx_business_glossary_term' = 'Industry Sector');
ALTER TABLE `legal_ecm`.`contract`.`template` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Keywords');
ALTER TABLE `legal_ecm`.`contract`.`template` ALTER COLUMN `language_locale` SET TAGS ('dbx_business_glossary_term' = 'Language Locale');
ALTER TABLE `legal_ecm`.`contract`.`template` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `legal_ecm`.`contract`.`template` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`contract`.`template` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `legal_ecm`.`contract`.`template` ALTER COLUMN `mandatory_use_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Use Flag');
ALTER TABLE `legal_ecm`.`contract`.`template` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `legal_ecm`.`contract`.`template` ALTER COLUMN `optional_clauses_count` SET TAGS ('dbx_business_glossary_term' = 'Optional Clauses Count');
ALTER TABLE `legal_ecm`.`contract`.`template` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Page Count');
ALTER TABLE `legal_ecm`.`contract`.`template` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency Months');
ALTER TABLE `legal_ecm`.`contract`.`template` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `legal_ecm`.`contract`.`template` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `legal_ecm`.`contract`.`template` ALTER COLUMN `template_code` SET TAGS ('dbx_business_glossary_term' = 'Template Code');
ALTER TABLE `legal_ecm`.`contract`.`template` ALTER COLUMN `template_description` SET TAGS ('dbx_business_glossary_term' = 'Template Description');
ALTER TABLE `legal_ecm`.`contract`.`template` ALTER COLUMN `template_name` SET TAGS ('dbx_business_glossary_term' = 'Template Name');
ALTER TABLE `legal_ecm`.`contract`.`template` ALTER COLUMN `template_status` SET TAGS ('dbx_business_glossary_term' = 'Template Status');
ALTER TABLE `legal_ecm`.`contract`.`template` ALTER COLUMN `template_status` SET TAGS ('dbx_value_regex' = 'draft|active|deprecated|archived|under_review|suspended');
ALTER TABLE `legal_ecm`.`contract`.`template` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `legal_ecm`.`contract`.`template` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `legal_ecm`.`contract`.`template` ALTER COLUMN `usage_instructions` SET TAGS ('dbx_business_glossary_term' = 'Usage Instructions');
ALTER TABLE `legal_ecm`.`contract`.`template` ALTER COLUMN `variable_fields_count` SET TAGS ('dbx_business_glossary_term' = 'Variable Fields Count');
ALTER TABLE `legal_ecm`.`contract`.`template` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `legal_ecm`.`contract`.`template` ALTER COLUMN `word_count` SET TAGS ('dbx_business_glossary_term' = 'Word Count');
ALTER TABLE `legal_ecm`.`contract`.`template` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` SET TAGS ('dbx_subdomain' = 'agreement_management');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `contract_party_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Party Identifier (ID)');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `aml_kyc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Kyc Program Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `conflict_party_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Party Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Client Contact Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `individual_id` SET TAGS ('dbx_business_glossary_term' = 'Individual Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `kyc_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Screening Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `organisation_id` SET TAGS ('dbx_business_glossary_term' = 'Organisation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Profile Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Party Address Line 1');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Party Address Line 2');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `authorized_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Authorized Signatory Name');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `authorized_signatory_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `authorized_signatory_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Party City');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `confidentiality_obligation_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Obligation Flag');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Party Country Code');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Party Email Address');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `execution_method` SET TAGS ('dbx_business_glossary_term' = 'Execution Method');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `execution_method` SET TAGS ('dbx_value_regex' = 'wet_signature|electronic_signature|digital_signature|seal|notarized');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `indemnity_obligation_flag` SET TAGS ('dbx_business_glossary_term' = 'Indemnity Obligation Flag');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `is_client` SET TAGS ('dbx_business_glossary_term' = 'Is Client Flag');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `is_firm_entity` SET TAGS ('dbx_business_glossary_term' = 'Is Firm Entity Flag');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `is_opposing_counsel` SET TAGS ('dbx_business_glossary_term' = 'Is Opposing Counsel Flag');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `is_vendor` SET TAGS ('dbx_business_glossary_term' = 'Is Vendor or Supplier Flag');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `liability_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Liability Cap Amount');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `liability_cap_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `liability_cap_currency` SET TAGS ('dbx_business_glossary_term' = 'Liability Cap Currency Code');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `liability_cap_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `notary_commission_number` SET TAGS ('dbx_business_glossary_term' = 'Notary Commission Number');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `notary_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Notary Commission Expiration Date');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `notary_name` SET TAGS ('dbx_business_glossary_term' = 'Notary Public Name');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `parent_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Parent Entity Name');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `party_role` SET TAGS ('dbx_business_glossary_term' = 'Party Role');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `party_role` SET TAGS ('dbx_value_regex' = 'offeror|offeree|guarantor|witness|notary|authorized_signatory');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `party_status` SET TAGS ('dbx_business_glossary_term' = 'Party Status');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `party_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|suspended|deceased');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `party_type` SET TAGS ('dbx_business_glossary_term' = 'Party Type');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `party_type` SET TAGS ('dbx_value_regex' = 'individual|corporation|partnership|government|trust|non_profit');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `phone` SET TAGS ('dbx_business_glossary_term' = 'Party Phone Number');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Party Postal Code');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Number or Tax Identifier');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `sanctions_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Date');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Status');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_value_regex' = 'cleared|flagged|pending|not_screened');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `signatory_capacity` SET TAGS ('dbx_business_glossary_term' = 'Signatory Capacity');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `signatory_capacity` SET TAGS ('dbx_value_regex' = 'individual|corporate_officer|attorney_in_fact|trustee|executor|guardian');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `signatory_email` SET TAGS ('dbx_business_glossary_term' = 'Signatory Email Address');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `signatory_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `signatory_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `signatory_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `signatory_phone` SET TAGS ('dbx_business_glossary_term' = 'Signatory Phone Number');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `signatory_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `signatory_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Signatory Title or Position');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `signature_location` SET TAGS ('dbx_business_glossary_term' = 'Signature Location');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'Party State or Province');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `ultimate_beneficial_owner` SET TAGS ('dbx_business_glossary_term' = 'Ultimate Beneficial Owner (UBO)');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `ultimate_beneficial_owner` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `ultimate_beneficial_owner` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `legal_ecm`.`contract`.`obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`contract`.`obligation` SET TAGS ('dbx_subdomain' = 'obligation_lifecycle');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Identifier');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Asset Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `clause_library_id` SET TAGS ('dbx_business_glossary_term' = 'Clause Library Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `compliance_control_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Control Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Court Order Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `dependent_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Dependent Obligation Identifier');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Document Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Intake Request Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `contract_party_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Contract Party Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `sla_template_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Template Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `beneficiary_party_name` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Party Name');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `beneficiary_party_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `breach_consequence` SET TAGS ('dbx_business_glossary_term' = 'Breach Consequence');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `breach_consequence` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `breach_notice_required` SET TAGS ('dbx_business_glossary_term' = 'Breach Notice Required Flag');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `condition_precedent_flag` SET TAGS ('dbx_business_glossary_term' = 'Condition Precedent Flag');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `cure_period_days` SET TAGS ('dbx_business_glossary_term' = 'Cure Period Days');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Obligation Due Date');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `escalation_threshold_days` SET TAGS ('dbx_business_glossary_term' = 'Escalation Threshold Days');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `fulfillment_percentage` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Percentage');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Status');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Record Flag');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `monetary_value` SET TAGS ('dbx_business_glossary_term' = 'Monetary Value');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `monetary_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Obligation Notes');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `obligation_category` SET TAGS ('dbx_business_glossary_term' = 'Obligation Category');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `obligation_category` SET TAGS ('dbx_value_regex' = 'payment|delivery|reporting|confidentiality|regulatory|ip_assignment');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `obligation_text` SET TAGS ('dbx_business_glossary_term' = 'Obligation Text');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `obligation_text` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Obligation Priority');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `recurrence_rule` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Rule');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `recurrence_schedule` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Schedule');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Obligation Reference Number');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `regulatory_obligation_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Flag');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Obligation Subcategory');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Record Version Number');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `waiver_authority` SET TAGS ('dbx_business_glossary_term' = 'Waiver Authority');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `waiver_authority` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `waiver_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Date');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`obligation` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` SET TAGS ('dbx_subdomain' = 'obligation_lifecycle');
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ALTER COLUMN `obligation_event_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Event ID');
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Amendment Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Document ID');
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation ID');
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ALTER COLUMN `actor_type` SET TAGS ('dbx_business_glossary_term' = 'Actor Type');
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ALTER COLUMN `actor_type` SET TAGS ('dbx_value_regex' = 'attorney|client|counterparty|system|third_party');
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ALTER COLUMN `breach_notice_date` SET TAGS ('dbx_business_glossary_term' = 'Breach Notice Date');
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ALTER COLUMN `breach_severity` SET TAGS ('dbx_business_glossary_term' = 'Breach Severity');
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ALTER COLUMN `breach_severity` SET TAGS ('dbx_value_regex' = 'minor|moderate|major|critical');
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completion Percentage');
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ALTER COLUMN `cure_deadline` SET TAGS ('dbx_business_glossary_term' = 'Cure Deadline');
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'none|team_lead|partner|general_counsel|executive');
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ALTER COLUMN `event_description` SET TAGS ('dbx_business_glossary_term' = 'Event Description');
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|disputed|resolved|cancelled');
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'created|fulfilled|partially_completed|breached|cured|waived');
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ALTER COLUMN `financial_impact_currency` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Currency');
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ALTER COLUMN `financial_impact_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ALTER COLUMN `notification_recipient_list` SET TAGS ('dbx_business_glossary_term' = 'Notification Recipient List');
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ALTER COLUMN `notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Timestamp');
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ALTER COLUMN `prior_obligation_status` SET TAGS ('dbx_business_glossary_term' = 'Prior Obligation Status');
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ALTER COLUMN `prior_obligation_status` SET TAGS ('dbx_value_regex' = 'pending|active|fulfilled|breached|waived|expired');
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ALTER COLUMN `resulting_obligation_status` SET TAGS ('dbx_business_glossary_term' = 'Resulting Obligation Status');
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ALTER COLUMN `resulting_obligation_status` SET TAGS ('dbx_value_regex' = 'pending|active|fulfilled|breached|waived|expired');
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ALTER COLUMN `source_system_event_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Event ID');
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ALTER COLUMN `waiver_authority` SET TAGS ('dbx_business_glossary_term' = 'Waiver Authority');
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `legal_ecm`.`contract`.`milestone` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`contract`.`milestone` SET TAGS ('dbx_subdomain' = 'obligation_lifecycle');
ALTER TABLE `legal_ecm`.`contract`.`milestone` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Milestone Identifier (ID)');
ALTER TABLE `legal_ecm`.`contract`.`milestone` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `legal_ecm`.`contract`.`milestone` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Amendment Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`milestone` ALTER COLUMN `clause_library_id` SET TAGS ('dbx_business_glossary_term' = 'Clause Library Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`milestone` ALTER COLUMN `deadline_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Deadline Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`milestone` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Document Reference Identifier (ID)');
ALTER TABLE `legal_ecm`.`contract`.`milestone` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`milestone` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier (ID)');
ALTER TABLE `legal_ecm`.`contract`.`milestone` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`milestone` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `legal_ecm`.`contract`.`milestone` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`milestone` ALTER COLUMN `sla_template_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Template Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`milestone` ALTER COLUMN `actual_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Milestone Date');
ALTER TABLE `legal_ecm`.`contract`.`milestone` ALTER COLUMN `alert_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Alert Lead Time (Days)');
ALTER TABLE `legal_ecm`.`contract`.`milestone` ALTER COLUMN `completion_notes` SET TAGS ('dbx_business_glossary_term' = 'Completion Notes');
ALTER TABLE `legal_ecm`.`contract`.`milestone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`contract`.`milestone` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm`.`contract`.`milestone` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`contract`.`milestone` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `legal_ecm`.`contract`.`milestone` ALTER COLUMN `escalation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `legal_ecm`.`contract`.`milestone` ALTER COLUMN `external_system_reference` SET TAGS ('dbx_business_glossary_term' = 'External System Reference');
ALTER TABLE `legal_ecm`.`contract`.`milestone` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `legal_ecm`.`contract`.`milestone` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`milestone` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Status Flag');
ALTER TABLE `legal_ecm`.`contract`.`milestone` ALTER COLUMN `is_critical_path_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Flag');
ALTER TABLE `legal_ecm`.`contract`.`milestone` ALTER COLUMN `is_regulatory_milestone_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Milestone Flag');
ALTER TABLE `legal_ecm`.`contract`.`milestone` ALTER COLUMN `milestone_description` SET TAGS ('dbx_business_glossary_term' = 'Milestone Description');
ALTER TABLE `legal_ecm`.`contract`.`milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_business_glossary_term' = 'Milestone Name');
ALTER TABLE `legal_ecm`.`contract`.`milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_business_glossary_term' = 'Milestone Status');
ALTER TABLE `legal_ecm`.`contract`.`milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_business_glossary_term' = 'Milestone Type');
ALTER TABLE `legal_ecm`.`contract`.`milestone` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm`.`contract`.`milestone` ALTER COLUMN `next_occurrence_date` SET TAGS ('dbx_business_glossary_term' = 'Next Occurrence Date');
ALTER TABLE `legal_ecm`.`contract`.`milestone` ALTER COLUMN `notification_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Timestamp');
ALTER TABLE `legal_ecm`.`contract`.`milestone` ALTER COLUMN `notification_triggered_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Triggered Flag');
ALTER TABLE `legal_ecm`.`contract`.`milestone` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `legal_ecm`.`contract`.`milestone` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `legal_ecm`.`contract`.`milestone` ALTER COLUMN `recurrence_pattern` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Pattern');
ALTER TABLE `legal_ecm`.`contract`.`milestone` ALTER COLUMN `recurrence_pattern` SET TAGS ('dbx_value_regex' = 'one_time|annual|semi_annual|quarterly|monthly|custom');
ALTER TABLE `legal_ecm`.`contract`.`milestone` ALTER COLUMN `responsible_party_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Name');
ALTER TABLE `legal_ecm`.`contract`.`milestone` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Milestone Date');
ALTER TABLE `legal_ecm`.`contract`.`renewal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`contract`.`renewal` SET TAGS ('dbx_subdomain' = 'obligation_lifecycle');
ALTER TABLE `legal_ecm`.`contract`.`renewal` ALTER COLUMN `renewal_id` SET TAGS ('dbx_business_glossary_term' = 'Renewal Identifier (ID)');
ALTER TABLE `legal_ecm`.`contract`.`renewal` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Client Contact Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`renewal` ALTER COLUMN `engagement_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Opportunity Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`renewal` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Document Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`renewal` ALTER COLUMN `letter_of_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Letter Of Engagement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`renewal` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`renewal` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`renewal` ALTER COLUMN `pricing_model_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`renewal` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`renewal` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`renewal` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`renewal` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `legal_ecm`.`contract`.`renewal` ALTER COLUMN `renewal_successor_contract_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Successor Contract Identifier (ID)');
ALTER TABLE `legal_ecm`.`contract`.`renewal` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Request Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`renewal` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`renewal` ALTER COLUMN `auto_renew_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renew Flag');
ALTER TABLE `legal_ecm`.`contract`.`renewal` ALTER COLUMN `client_approval_received_date` SET TAGS ('dbx_business_glossary_term' = 'Client Approval Received Date');
ALTER TABLE `legal_ecm`.`contract`.`renewal` ALTER COLUMN `client_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Client Approval Required');
ALTER TABLE `legal_ecm`.`contract`.`renewal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`contract`.`renewal` ALTER COLUMN `decision` SET TAGS ('dbx_business_glossary_term' = 'Renewal Decision');
ALTER TABLE `legal_ecm`.`contract`.`renewal` ALTER COLUMN `decision` SET TAGS ('dbx_value_regex' = 'renew|terminate|renegotiate|pending');
ALTER TABLE `legal_ecm`.`contract`.`renewal` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Decision Date');
ALTER TABLE `legal_ecm`.`contract`.`renewal` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Effective Date');
ALTER TABLE `legal_ecm`.`contract`.`renewal` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Expiration Date');
ALTER TABLE `legal_ecm`.`contract`.`renewal` ALTER COLUMN `fee_adjustment_percentage` SET TAGS ('dbx_business_glossary_term' = 'Fee Adjustment Percentage');
ALTER TABLE `legal_ecm`.`contract`.`renewal` ALTER COLUMN `fee_adjustment_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`renewal` ALTER COLUMN `fee_adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Fee Adjustment Reason');
ALTER TABLE `legal_ecm`.`contract`.`renewal` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Renewal Fee Amount');
ALTER TABLE `legal_ecm`.`contract`.`renewal` ALTER COLUMN `fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`renewal` ALTER COLUMN `fee_arrangement_type` SET TAGS ('dbx_business_glossary_term' = 'Renewal Fee Arrangement Type (Alternative Fee Arrangement - AFA)');
ALTER TABLE `legal_ecm`.`contract`.`renewal` ALTER COLUMN `fee_arrangement_type` SET TAGS ('dbx_value_regex' = 'hourly|fixed_fee|capped_fee|contingency|blended_rate|afa_other');
ALTER TABLE `legal_ecm`.`contract`.`renewal` ALTER COLUMN `fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Renewal Fee Currency');
ALTER TABLE `legal_ecm`.`contract`.`renewal` ALTER COLUMN `fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`contract`.`renewal` ALTER COLUMN `initiated_by` SET TAGS ('dbx_business_glossary_term' = 'Renewal Initiated By');
ALTER TABLE `legal_ecm`.`contract`.`renewal` ALTER COLUMN `initiated_by` SET TAGS ('dbx_value_regex' = 'client|firm|auto_trigger');
ALTER TABLE `legal_ecm`.`contract`.`renewal` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notes');
ALTER TABLE `legal_ecm`.`contract`.`renewal` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period Days');
ALTER TABLE `legal_ecm`.`contract`.`renewal` ALTER COLUMN `notice_to_cancel_deadline` SET TAGS ('dbx_business_glossary_term' = 'Notice to Cancel Deadline');
ALTER TABLE `legal_ecm`.`contract`.`renewal` ALTER COLUMN `notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notification Sent Date');
ALTER TABLE `legal_ecm`.`contract`.`renewal` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Renewal Priority');
ALTER TABLE `legal_ecm`.`contract`.`renewal` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `legal_ecm`.`contract`.`renewal` ALTER COLUMN `renewal_number` SET TAGS ('dbx_business_glossary_term' = 'Renewal Number');
ALTER TABLE `legal_ecm`.`contract`.`renewal` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status');
ALTER TABLE `legal_ecm`.`contract`.`renewal` ALTER COLUMN `renewal_status` SET TAGS ('dbx_value_regex' = 'pending|under_review|approved|declined|executed|cancelled');
ALTER TABLE `legal_ecm`.`contract`.`renewal` ALTER COLUMN `renewal_type` SET TAGS ('dbx_business_glossary_term' = 'Renewal Type');
ALTER TABLE `legal_ecm`.`contract`.`renewal` ALTER COLUMN `renewal_type` SET TAGS ('dbx_value_regex' = 'auto_renew|opt_in|renegotiate|extend|terminate');
ALTER TABLE `legal_ecm`.`contract`.`renewal` ALTER COLUMN `term_length` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term Length');
ALTER TABLE `legal_ecm`.`contract`.`renewal` ALTER COLUMN `term_unit` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term Unit');
ALTER TABLE `legal_ecm`.`contract`.`renewal` ALTER COLUMN `term_unit` SET TAGS ('dbx_value_regex' = 'month|year|quarter');
ALTER TABLE `legal_ecm`.`contract`.`renewal` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `legal_ecm`.`contract`.`amendment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`contract`.`amendment` SET TAGS ('dbx_subdomain' = 'obligation_lifecycle');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Amendment Identifier');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Identifier');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Clean Document Identifier');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `amendment_legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Redline Document Identifier');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `check_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Identifier');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `clearance_id` SET TAGS ('dbx_business_glossary_term' = 'Clearance Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `contract_party_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Contract Party Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `engagement_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Opportunity Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `letter_of_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Letter Of Engagement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `parent_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Amendment Identifier');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `pricing_model_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `primary_superseded_by_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Amendment Identifier');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Amendment Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Request Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `sla_template_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Template Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `amendment_description` SET TAGS ('dbx_business_glossary_term' = 'Amendment Description');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_business_glossary_term' = 'Amendment Type');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_value_regex' = 'amendment|addendum|side_letter|variation|waiver|novation');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `clauses_modified` SET TAGS ('dbx_business_glossary_term' = 'Clauses Modified');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'standard|highly_confidential|attorney_client_privileged|work_product');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `counterparty_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Signatory Name');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `counterparty_signatory_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `counterparty_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Signatory Title');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Effective Date');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Execution Date');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `execution_status` SET TAGS ('dbx_business_glossary_term' = 'Amendment Execution Status');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `financial_impact_currency` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Currency');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `financial_impact_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `firm_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Firm Signatory Name');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `firm_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Firm Signatory Title');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `new_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'New Expiration Date');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Amendment Notes');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period Days');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `retention_end_date` SET TAGS ('dbx_business_glossary_term' = 'Retention End Date');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `term_extension_months` SET TAGS ('dbx_business_glossary_term' = 'Term Extension Months');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Amendment Title');
ALTER TABLE `legal_ecm`.`contract`.`amendment` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Version Number');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` SET TAGS ('dbx_subdomain' = 'obligation_lifecycle');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `execution_record_id` SET TAGS ('dbx_business_glossary_term' = 'Execution Record Identifier (ID)');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Amendment Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `doc_version_id` SET TAGS ('dbx_business_glossary_term' = 'Doc Version Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Executed Document Reference Identifier (ID)');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `letter_of_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Letter Of Engagement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier (ID)');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `contract_party_id` SET TAGS ('dbx_business_glossary_term' = 'Signing Contract Party Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `binding_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Binding Effective Date');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `board_resolution_reference` SET TAGS ('dbx_business_glossary_term' = 'Board Resolution Reference');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `counterparty_execution_date` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Execution Date');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `counterparty_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Signatory Name');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `counterparty_signatory_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `counterparty_signatory_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `counterparty_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Signatory Title');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `electronic_signature_certificate_reference` SET TAGS ('dbx_business_glossary_term' = 'Electronic Signature Certificate Identifier (ID)');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `electronic_signature_platform` SET TAGS ('dbx_business_glossary_term' = 'Electronic Signature Platform');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `electronic_signature_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Electronic Signature Transaction Identifier (ID)');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `executing_party_name` SET TAGS ('dbx_business_glossary_term' = 'Executing Party Name');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `execution_location` SET TAGS ('dbx_business_glossary_term' = 'Execution Location');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `execution_method` SET TAGS ('dbx_business_glossary_term' = 'Execution Method');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `execution_method` SET TAGS ('dbx_value_regex' = 'wet_ink|electronic_signature|notarized|deed|counterpart|escrow');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `execution_notes` SET TAGS ('dbx_business_glossary_term' = 'Execution Notes');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `execution_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Execution Reference Number');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `execution_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Execution Sequence Number');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `execution_status` SET TAGS ('dbx_business_glossary_term' = 'Execution Status');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `execution_status` SET TAGS ('dbx_value_regex' = 'pending|partially_executed|fully_executed|voided|superseded');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Execution Timestamp');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `execution_type` SET TAGS ('dbx_business_glossary_term' = 'Execution Type');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `execution_type` SET TAGS ('dbx_value_regex' = 'original|amendment|renewal|counterpart|duplicate');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `is_binding_flag` SET TAGS ('dbx_business_glossary_term' = 'Is Binding Flag');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `is_original_execution_flag` SET TAGS ('dbx_business_glossary_term' = 'Is Original Execution Flag');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `jurisdiction_of_execution` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction of Execution');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `notary_commission_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Notary Commission Expiry Date');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `notary_commission_number` SET TAGS ('dbx_business_glossary_term' = 'Notary Commission Number');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `notary_name` SET TAGS ('dbx_business_glossary_term' = 'Notary Public Name');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `notary_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `notary_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `notary_seal_affixed_flag` SET TAGS ('dbx_business_glossary_term' = 'Notary Seal Affixed Flag');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `power_of_attorney_reference` SET TAGS ('dbx_business_glossary_term' = 'Power of Attorney (POA) Reference');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `signatory_capacity` SET TAGS ('dbx_business_glossary_term' = 'Signatory Capacity');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Signatory Name');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `signatory_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `signatory_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Signatory Title');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `witness_address` SET TAGS ('dbx_business_glossary_term' = 'Witness Address');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `witness_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `witness_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `witness_name` SET TAGS ('dbx_business_glossary_term' = 'Witness Name');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `witness_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ALTER COLUMN `witness_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`termination` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`contract`.`termination` SET TAGS ('dbx_subdomain' = 'obligation_lifecycle');
ALTER TABLE `legal_ecm`.`contract`.`termination` ALTER COLUMN `termination_id` SET TAGS ('dbx_business_glossary_term' = 'Termination ID');
ALTER TABLE `legal_ecm`.`contract`.`termination` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `legal_ecm`.`contract`.`termination` ALTER COLUMN `check_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`termination` ALTER COLUMN `clause_library_id` SET TAGS ('dbx_business_glossary_term' = 'Clause Library Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`termination` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`termination` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Terminating Party Contact ID');
ALTER TABLE `legal_ecm`.`contract`.`termination` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`termination` ALTER COLUMN `judgment_id` SET TAGS ('dbx_business_glossary_term' = 'Judgment Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`termination` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Document Reference ID');
ALTER TABLE `legal_ecm`.`contract`.`termination` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`contract`.`termination` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`termination` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`termination` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`termination` ALTER COLUMN `contract_party_id` SET TAGS ('dbx_business_glossary_term' = 'Terminating Contract Party Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`termination` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm`.`contract`.`termination` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `legal_ecm`.`contract`.`termination` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`contract`.`termination` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm`.`contract`.`termination` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`contract`.`termination` ALTER COLUMN `dispute_description` SET TAGS ('dbx_business_glossary_term' = 'Dispute Description');
ALTER TABLE `legal_ecm`.`contract`.`termination` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `legal_ecm`.`contract`.`termination` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `legal_ecm`.`contract`.`termination` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_value_regex' = 'negotiation|mediation|arbitration|litigation|none');
ALTER TABLE `legal_ecm`.`contract`.`termination` ALTER COLUMN `effective_termination_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Termination Date');
ALTER TABLE `legal_ecm`.`contract`.`termination` ALTER COLUMN `external_system_reference` SET TAGS ('dbx_business_glossary_term' = 'External System Reference');
ALTER TABLE `legal_ecm`.`contract`.`termination` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `legal_ecm`.`contract`.`termination` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`termination` ALTER COLUMN `grounds_for_termination` SET TAGS ('dbx_business_glossary_term' = 'Grounds for Termination');
ALTER TABLE `legal_ecm`.`contract`.`termination` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `legal_ecm`.`contract`.`termination` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm`.`contract`.`termination` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm`.`contract`.`termination` ALTER COLUMN `notice_date` SET TAGS ('dbx_business_glossary_term' = 'Notice Date');
ALTER TABLE `legal_ecm`.`contract`.`termination` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period Days');
ALTER TABLE `legal_ecm`.`contract`.`termination` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `legal_ecm`.`contract`.`termination` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`termination` ALTER COLUMN `post_termination_obligations` SET TAGS ('dbx_business_glossary_term' = 'Post-Termination Obligations');
ALTER TABLE `legal_ecm`.`contract`.`termination` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `legal_ecm`.`contract`.`termination` ALTER COLUMN `refund_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`termination` ALTER COLUMN `regulatory_report_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Date');
ALTER TABLE `legal_ecm`.`contract`.`termination` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `legal_ecm`.`contract`.`termination` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `legal_ecm`.`contract`.`termination` ALTER COLUMN `settlement_reached_flag` SET TAGS ('dbx_business_glossary_term' = 'Settlement Reached Flag');
ALTER TABLE `legal_ecm`.`contract`.`termination` ALTER COLUMN `settlement_terms` SET TAGS ('dbx_business_glossary_term' = 'Settlement Terms');
ALTER TABLE `legal_ecm`.`contract`.`termination` ALTER COLUMN `settlement_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`termination` ALTER COLUMN `surviving_clauses` SET TAGS ('dbx_business_glossary_term' = 'Surviving Clauses');
ALTER TABLE `legal_ecm`.`contract`.`termination` ALTER COLUMN `termination_status` SET TAGS ('dbx_business_glossary_term' = 'Termination Status');
ALTER TABLE `legal_ecm`.`contract`.`termination` ALTER COLUMN `termination_status` SET TAGS ('dbx_value_regex' = 'pending|effective|disputed|settled|withdrawn');
ALTER TABLE `legal_ecm`.`contract`.`termination` ALTER COLUMN `termination_type` SET TAGS ('dbx_business_glossary_term' = 'Termination Type');
ALTER TABLE `legal_ecm`.`contract`.`termination` ALTER COLUMN `termination_type` SET TAGS ('dbx_value_regex' = 'expiry|termination_for_convenience|termination_for_cause|mutual_rescission|frustration|breach');
ALTER TABLE `legal_ecm`.`contract`.`termination` ALTER COLUMN `wind_down_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Wind-Down Completion Date');
ALTER TABLE `legal_ecm`.`contract`.`termination` ALTER COLUMN `wind_down_period_days` SET TAGS ('dbx_business_glossary_term' = 'Wind-Down Period Days');
ALTER TABLE `legal_ecm`.`contract`.`clause_library` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`contract`.`clause_library` SET TAGS ('dbx_subdomain' = 'agreement_management');
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ALTER COLUMN `clause_library_id` SET TAGS ('dbx_business_glossary_term' = 'Clause Library Identifier');
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ALTER COLUMN `agreement_type_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ALTER COLUMN `superseded_by_clause_clause_library_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Clause ID');
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ALTER COLUMN `aml_kyc_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Know Your Client (KYC) Required Flag');
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ALTER COLUMN `approved_text` SET TAGS ('dbx_business_glossary_term' = 'Approved Clause Text');
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ALTER COLUMN `approved_text` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ALTER COLUMN `clause_category` SET TAGS ('dbx_business_glossary_term' = 'Clause Category');
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ALTER COLUMN `clause_category` SET TAGS ('dbx_value_regex' = 'risk_allocation|compliance|operational|commercial|dispute_resolution|termination');
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ALTER COLUMN `clause_library_description` SET TAGS ('dbx_business_glossary_term' = 'Clause Description');
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ALTER COLUMN `clause_library_status` SET TAGS ('dbx_business_glossary_term' = 'Clause Status');
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ALTER COLUMN `clause_library_status` SET TAGS ('dbx_value_regex' = 'active|under_review|deprecated|archived|draft');
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ALTER COLUMN `clause_type` SET TAGS ('dbx_business_glossary_term' = 'Clause Type');
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ALTER COLUMN `clause_type` SET TAGS ('dbx_value_regex' = 'indemnity|limitation_of_liability|governing_law|force_majeure|ip_assignment|confidentiality');
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ALTER COLUMN `external_source_reference` SET TAGS ('dbx_business_glossary_term' = 'External Source Reference');
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ALTER COLUMN `fallback_text` SET TAGS ('dbx_business_glossary_term' = 'Fallback Clause Text');
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ALTER COLUMN `fallback_text` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ALTER COLUMN `frand_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Fair Reasonable and Non-Discriminatory (FRAND) Applicable Flag');
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ALTER COLUMN `gdpr_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Compliant Flag');
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Keywords');
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}(-[A-Z]{2})?$');
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ALTER COLUMN `last_used_date` SET TAGS ('dbx_business_glossary_term' = 'Last Used Date');
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ALTER COLUMN `negotiation_notes` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Notes');
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ALTER COLUMN `negotiation_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ALTER COLUMN `sox_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley Act (SOX) Compliant Flag');
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ALTER COLUMN `usage_guidance` SET TAGS ('dbx_business_glossary_term' = 'Usage Guidance');
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ALTER COLUMN `usage_tier` SET TAGS ('dbx_business_glossary_term' = 'Usage Tier');
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ALTER COLUMN `usage_tier` SET TAGS ('dbx_value_regex' = 'mandatory|preferred|fallback|optional|deprecated');
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ALTER COLUMN `word_count` SET TAGS ('dbx_business_glossary_term' = 'Word Count');
ALTER TABLE `legal_ecm`.`contract`.`template_clause_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `legal_ecm`.`contract`.`template_clause_assignment` SET TAGS ('dbx_subdomain' = 'agreement_management');
ALTER TABLE `legal_ecm`.`contract`.`template_clause_assignment` SET TAGS ('dbx_association_edges' = 'contract.template,contract.clause_library');
ALTER TABLE `legal_ecm`.`contract`.`template_clause_assignment` ALTER COLUMN `template_clause_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Template Clause Assignment - Template Clause Assignment Id');
ALTER TABLE `legal_ecm`.`contract`.`template_clause_assignment` ALTER COLUMN `clause_library_id` SET TAGS ('dbx_business_glossary_term' = 'Template Clause Assignment - Clause Library Id');
ALTER TABLE `legal_ecm`.`contract`.`template_clause_assignment` ALTER COLUMN `template_id` SET TAGS ('dbx_business_glossary_term' = 'Template Clause Assignment - Template Id');
ALTER TABLE `legal_ecm`.`contract`.`template_clause_assignment` ALTER COLUMN `clause_position` SET TAGS ('dbx_business_glossary_term' = 'Clause Position');
ALTER TABLE `legal_ecm`.`contract`.`template_clause_assignment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Effective Date');
ALTER TABLE `legal_ecm`.`contract`.`template_clause_assignment` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Clause Flag');
ALTER TABLE `legal_ecm`.`contract`.`template_clause_assignment` ALTER COLUMN `override_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Override Allowed Flag');
ALTER TABLE `legal_ecm`.`contract`.`template_clause_assignment` ALTER COLUMN `sort_order` SET TAGS ('dbx_business_glossary_term' = 'Clause Sort Order');
ALTER TABLE `legal_ecm`.`contract`.`template_clause_assignment` ALTER COLUMN `template_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Template Integration Flag');
