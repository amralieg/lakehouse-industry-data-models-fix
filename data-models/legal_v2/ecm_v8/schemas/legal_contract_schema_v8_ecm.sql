-- Schema for Domain: contract | Business: Legal | Version: v8_ecm
-- Generated on: 2026-05-21 01:11:35

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `legal_ecm_v1`.`contract` COMMENT 'Governs the full Contract Lifecycle Management (CLM) pipeline for both client-facing engagement letters (LOE, POA, SPA, NDA) and firm vendor/supplier agreements. Owns contract templates, obligation tracking, milestone alerts, renewal management, and executed agreement metadata. Distinct from the matter domain — contract owns the agreement artifact; matter owns the work performed under it.';

-- ========= TABLES =========
CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`contract`.`contract_agreement` (
    `contract_agreement_id` BIGINT COMMENT 'Unique identifier for the agreement record. Primary key for the agreement entity.',
    `agreement_type_id` BIGINT COMMENT 'Foreign key linking to contract.agreement_type. Business justification: Agreement has a STRING column agreement_type that should be normalized to FK to the agreement_type reference table. This is a standard reference data normalization pattern. The agreement_type refere',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the partner or senior lawyer responsible for oversight of this agreement.',
    `check_id` BIGINT COMMENT 'Foreign key linking to conflict.conflict_check. Business justification: Every contract engagement requires conflict clearance before execution per legal ethics rules (ABA Model Rules 1.7, 1.9). The existing conflict_check_cleared_flag on agreement indicates this business ',
    `clause_id` BIGINT COMMENT 'Foreign key linking to knowledge.clause. Business justification: Agreements incorporate approved clauses from the knowledge clause library. Tracking which knowledge clauses were used enables clause performance analysis, compliance verification, and knowledge asset ',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Agreements must conform to firm compliance policies (conflicts policy, client acceptance policy, fee arrangement policy). Contract approval workflows verify policy compliance before execution. Essenti',
    `docket_id` BIGINT COMMENT 'Foreign key linking to court.docket. Business justification: Settlement agreements, consent decrees, and litigation-related contracts must reference their underlying court dockets. Legal practice requires tracking which litigation produced or relates to each ag',
    `engagement_opportunity_id` BIGINT COMMENT 'Foreign key linking to intake.engagement_opportunity. Business justification: Executed agreements link back to originating business development opportunities for win/loss analysis, origination credit allocation, pipeline conversion metrics, and estimated-vs-actual value trackin',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: Agreements implement specific legal service offerings from the firms service catalog. Essential for revenue attribution by service line, service performance analytics, and cross-sell analysis. Legal ',
    `letter_of_engagement_id` BIGINT COMMENT 'Foreign key linking to intake.letter_of_engagement. Business justification: Agreements originate from letters of engagement during client intake. Legal operations track this for origination credit allocation, fee arrangement validation, scope compliance auditing, and pipeline',
    `matter_id` BIGINT COMMENT 'Reference to the matter under which this agreement is executed or managed. Nullable for firm vendor agreements not tied to client matters.',
    `parent_agreement_contract_agreement_id` BIGINT COMMENT 'Reference to the parent or master agreement if this is a subsidiary agreement, amendment, or SOW. Nullable for standalone agreements.',
    `practice_group_id` BIGINT COMMENT 'Foreign key linking to workforce.practice_group. Business justification: Agreements belong to practice areas for revenue tracking, conflict checking, resource allocation, and practice group performance reporting. Practice_area text field should be replaced with proper FK t',
    `precedent_id` BIGINT COMMENT 'Foreign key linking to knowledge.precedent. Business justification: Agreements are drafted from precedent templates. Legal operations track which precedent was used as the starting point to measure precedent effectiveness, maintain audit trail, and enable precedent us',
    `pricing_model_id` BIGINT COMMENT 'Foreign key linking to service.pricing_model. Business justification: Agreements must reference their governing pricing model (hourly, fixed-fee, contingency, blended rate) for billing system integration, fee arrangement compliance audits, and financial reporting. Core ',
    `profile_id` BIGINT COMMENT 'Reference to the client party who is a counterparty to this agreement.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Contracts inherently carry risks (indemnity exposure, liability caps, regulatory compliance) tracked in risk registers for PI insurance underwriting, matter risk profiling, and breach prevention. Esse',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Agreements must comply with specific regulatory obligations (GDPR data processing requirements, AML client acceptance rules, SRA engagement terms). Legal teams track which regulatory obligations each ',
    `template_id` BIGINT COMMENT 'Reference to the contract template from which this agreement was generated. Nullable for bespoke agreements.',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the agreement, used in correspondence and filings.',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the agreement within the CLM pipeline. [ENUM-REF-CANDIDATE: Draft|Under Review|Pending Execution|Executed|Active|Suspended|Terminated|Expired|Cancelled — 9 candidates stripped; promote to reference product]',
    `amendment_count` STRING COMMENT 'Total number of formal amendments executed against this agreement.',
    `aml_kyc_verified_flag` BOOLEAN COMMENT 'Indicates whether AML and KYC checks have been completed and verified for the counterparty prior to agreement execution.',
    `approval_date` DATE COMMENT 'Date on which the agreement received final internal approval.',
    `approval_status` STRING COMMENT 'Current approval status of the agreement within the internal review and authorization workflow.. Valid values are `Pending Approval|Approved|Rejected|Conditional Approval`',
    `approved_by` STRING COMMENT 'Name or identifier of the individual who provided final approval for the agreement.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the agreement automatically renews upon expiry unless terminated.',
    `confidentiality_classification` STRING COMMENT 'Data classification level assigned to the agreement document and its contents.. Valid values are `Public|Internal|Confidential|Restricted|Highly Restricted`',
    `conflict_check_cleared_flag` BOOLEAN COMMENT 'Indicates whether conflict of interest checks have been completed and cleared for this agreement.',
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
    `jurisdiction` STRING COMMENT 'Legal jurisdiction or venue for dispute resolution as specified in the agreement.',
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
    CONSTRAINT pk_contract_agreement PRIMARY KEY(`contract_agreement_id`)
) COMMENT 'Master record for every executed or in-progress contract artifact owned by the firm, covering client-facing instruments (LOE, NDA, SPA, POA) and firm vendor/supplier agreements. SSOT for agreement identity, counterparty references, effective/expiry dates, governing law, jurisdiction, contract value, currency, confidentiality classification, LPP flag, execution status, and CLM stage.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`contract`.`agreement_type` (
    `agreement_type_id` BIGINT COMMENT 'Unique identifier for the agreement type. Primary key for the agreement type reference table.',
    `pricing_model_id` BIGINT COMMENT 'Foreign key linking to service.pricing_model. Business justification: Agreement types have default pricing models that auto-populate during engagement letter generation. Supports template configuration, new matter intake automation, and ensures consistent fee arrangemen',
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

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`contract`.`template` (
    `template_id` BIGINT COMMENT 'Unique identifier for the contract template record. Primary key.',
    `agreement_type_id` BIGINT COMMENT 'Foreign key linking to contract.agreement_type. Business justification: Contract_template has a STRING column agreement_type that should be normalized to FK to the agreement_type reference table. Templates are designed for specific agreement types, and this FK establish',
    `clause_id` BIGINT COMMENT 'Foreign key linking to knowledge.clause. Business justification: Templates incorporate standard clauses from the knowledge library. Tracking this relationship enables automated template updates when clauses are revised, ensures consistency across templates, and sup',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Templates embed compliance policy requirements (standard confidentiality terms per information security policy, limitation of liability per risk policy). Template approval processes verify policy alig',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Contract templates are organized by practice area for knowledge management, template library navigation, and precedent retrieval. Replaces denormalized practice_group string with structured FK. Essent',
    `practice_group_id` BIGINT COMMENT 'Foreign key linking to workforce.practice_group. Business justification: Templates are owned and maintained by practice groups. Essential for template governance, version control, practice area standardization, and knowledge management. Practice_group text field should be ',
    `precedent_id` BIGINT COMMENT 'Foreign key linking to knowledge.precedent. Business justification: Contract templates are derived from or reference precedents. Legal operations track this lineage for version control, to propagate updates when precedents change, and to maintain template-precedent co',
    `rfp_submission_id` BIGINT COMMENT 'Foreign key linking to intake.rfp_submission. Business justification: RFP responses reference standard contract templates as part of proposals. Legal operations track which templates were proposed in which RFPs for template usage analytics, client preference tracking, a',
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
    `jurisdiction` STRING COMMENT 'Legal jurisdiction or jurisdictions for which this template is designed and approved (e.g., New York, England and Wales, Delaware, California, multi-jurisdictional).',
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

CREATE OR REPLACE TABLE `legal_ecm_v1`.`contract`.`contract_party` (
    `contract_party_id` BIGINT COMMENT 'Unique identifier for the contract party record. Primary key.',
    `conflict_party_id` BIGINT COMMENT 'Foreign key linking to conflict.conflict_party. Business justification: Contract parties must be conflict-checked entities in legal practice. Links the partys role in a specific contract to their master conflict record for KYC/AML verification, sanctions screening, and r',
    `contract_agreement_id` BIGINT COMMENT 'Reference to the parent contract or agreement to which this party is bound.',
    `individual_id` BIGINT COMMENT 'Foreign key linking to client.individual. Business justification: Contract parties can be individuals (personal service agreements, settlement agreements with individuals). This FK links contract parties to the individual master when party_type is individual. is_new',
    `organisation_id` BIGINT COMMENT 'Foreign key linking to client.organisation. Business justification: Contract parties are often existing client organisations (engagement letters, retainer agreements, etc.). This FK normalizes party data by linking to the organisation master. is_new_attribute=true bec',
    `profile_id` BIGINT COMMENT 'Foreign key linking to client.client_profile. Business justification: Contract parties need direct link to client_profile for conflict checking, billing consolidation, and relationship reporting. When a contract party is a firm client (is_client flag), this link enables',
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
    `kyc_aml_clearance_date` DATE COMMENT 'The date on which KYC and AML clearance was obtained or last verified for this party.',
    `kyc_aml_clearance_status` STRING COMMENT 'The current status of KYC and AML compliance checks for this party (cleared, pending review, failed, not required, expired).. Valid values are `cleared|pending|failed|not_required|expired`',
    `liability_cap_amount` DECIMAL(18,2) COMMENT 'The maximum liability amount applicable to this party under the contract terms, if specified.',
    `liability_cap_currency` STRING COMMENT 'The ISO 4217 three-letter currency code for the liability cap amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `notary_commission_number` STRING COMMENT 'The commission number or registration number of the notary public who notarized the signature, if applicable.',
    `notary_expiration_date` DATE COMMENT 'The expiration date of the notary publics commission at the time of notarization, if applicable.',
    `notary_name` STRING COMMENT 'The name of the notary public who witnessed and notarized the partys signature, if applicable.',
    `parent_entity_name` STRING COMMENT 'The name of the parent company or controlling entity of this party, if applicable (used for corporate hierarchy tracking).',
    `party_on_agreement` BIGINT COMMENT 'FK to contract.agreement.agreement_id — contract_party is a junction/detail record linking parties to agreements. Without this FK, party records are orphaned with no agreement context.',
    `party_role` STRING COMMENT 'The legal or functional role this party plays in the contract (e.g., offeror, offeree, guarantor, witness, notary, authorized signatory).. Valid values are `offeror|offeree|guarantor|witness|notary|authorized_signatory`',
    `party_status` STRING COMMENT 'The current lifecycle status of this party in relation to the contract (active, inactive, terminated, suspended, deceased for individuals).. Valid values are `active|inactive|terminated|suspended|deceased`',
    `party_to_agreement` BIGINT COMMENT 'FK to contract.agreement.agreement_id — Every contract_party record identifies a party TO a specific agreement. This is a mandatory associative relationship — parties are meaningless without their agreement context.',
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
    `ultimate_beneficial_owner` STRING COMMENT 'The name of the ultimate beneficial owner (UBO) of the party entity, as required for KYC and AML compliance.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this contract party record was last updated in the system.',
    CONSTRAINT pk_contract_party PRIMARY KEY(`contract_party_id`)
) COMMENT 'Records every counterparty, signatory, or named party to a specific agreement, including the firm itself, clients, opposing counsel entities, vendors, guarantors, and government bodies. Captures party role (offeror, offeree, guarantor, witness, notary), legal entity name, jurisdiction of incorporation, KYC/AML clearance status, authorized signatory name, and execution capacity. Supports multi-party M&A and syndicated transaction structures.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`contract`.`obligation` (
    `obligation_id` BIGINT COMMENT 'Unique system identifier for the contractual obligation record. Primary key.',
    `check_id` BIGINT COMMENT 'Foreign key linking to conflict.conflict_check. Business justification: Contractual obligations may introduce new counterparties or adverse relationships requiring separate conflict screening (e.g., subcontractor obligations, assignment clauses, third-party beneficiary ri',
    `contract_agreement_id` BIGINT COMMENT 'Reference to the parent executed agreement from which this obligation was extracted.',
    `dependent_obligation_id` BIGINT COMMENT 'Reference to another obligation that must be fulfilled before this obligation becomes active. Null if no dependency exists.',
    `ip_asset_id` BIGINT COMMENT 'Foreign key linking to ip.asset. Business justification: Contract obligations routinely reference specific IP assets (e.g., maintain patent registration, not infringe trademark, transfer copyright ownership). Essential for IP portfolio compliance moni',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: Contractual obligations often represent service delivery commitments (SLA response times, deliverable deadlines). Essential for SLA monitoring, service performance tracking, and obligation-to-service ',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter under which this obligation is being tracked. Null if obligation is tracked at contract level only.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Contractual obligations that fail or are breached create professional indemnity exposure and client relationship risks. Risk registers track obligation-specific risks for breach risk assessment, PI cl',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Contractual obligations often implement regulatory requirements (data retention obligations from GDPR Article 17, reporting obligations from financial regulations, record-keeping from AML rules). Lega',
    `request_id` BIGINT COMMENT 'Foreign key linking to intake.intake_request. Business justification: Contract obligations can originate from intake commitments (conflict clearance obligations, KYC completion requirements, ethical wall maintenance, panel appointment conditions). Legal operations track',
    `timekeeper_id` BIGINT COMMENT 'Reference to the attorney or legal professional assigned to monitor and ensure fulfillment of this obligation.',
    `beneficiary_party_name` STRING COMMENT 'Legal name of the entity or individual entitled to receive the benefit or performance of the obligation.',
    `breach_consequence` STRING COMMENT 'Description of the contractual consequences if the obligation is breached (e.g., liquidated damages, termination right, indemnity trigger, regulatory penalty).',
    `breach_notice_required` BOOLEAN COMMENT 'Indicates whether the contract requires formal written notice before a breach is deemed to have occurred (True) or if breach is automatic upon deadline passage (False).',
    `clause_reference` STRING COMMENT 'Section, clause, or paragraph reference in the source contract where this obligation is defined (e.g., Section 5.3, Clause 12(a), Schedule B Item 4).',
    `condition_precedent_flag` BOOLEAN COMMENT 'Indicates whether this obligation is a condition precedent (True) that must be satisfied before other contract terms become effective, or a standard ongoing obligation (False).',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the obligation record was first created in the CLM system.',
    `cure_period_days` STRING COMMENT 'Number of days allowed to remedy a breach after notice is given, as specified in the contract. Null if no cure period is granted.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for monetary_value (e.g., USD, GBP, EUR). Null if obligation is non-monetary.. Valid values are `^[A-Z]{3}$`',
    `document_reference` STRING COMMENT 'Reference to the supporting document or evidence artifact in the Document Management System (DMS) that contains the obligation text (e.g., iManage document ID, NetDocuments URI).',
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
    `responsible_party_name` STRING COMMENT 'Legal name of the entity or individual responsible for fulfilling the obligation.',
    `responsible_party_type` STRING COMMENT 'Indicates which party bears the obligation: client (counterparty), firm (law firm), third_party (external vendor/agent), joint (shared responsibility).. Valid values are `client|firm|third_party|joint`',
    `subcategory` STRING COMMENT 'Granular classification within the obligation category (e.g., milestone payment, quarterly report, data protection compliance, patent assignment).',
    `to_agreement` BIGINT COMMENT 'FK to contract.agreement.agreement_id — Every obligation is extracted from a specific executed agreement. This is the fundamental parent-child relationship in CLM obligation tracking. Without this FK, obligations float without context and c',
    `version_number` STRING COMMENT 'Version number of the obligation record, incremented with each modification to support audit trail and change tracking.',
    `waiver_authority` STRING COMMENT 'Name and title of the individual who authorized the waiver of this obligation.',
    `waiver_date` DATE COMMENT 'Date on which the beneficiary party formally waived or released the obligation. Null if no waiver has been granted.',
    `waiver_reason` STRING COMMENT 'Business justification or legal rationale for waiving the obligation.',
    `created_by` STRING COMMENT 'Username or identifier of the system user who created the obligation record.',
    CONSTRAINT pk_obligation PRIMARY KEY(`obligation_id`)
) COMMENT 'Granular obligation register extracted from executed agreements, capturing each discrete contractual duty, covenant, representation, warranty, or condition precedent as a header record with associated lifecycle event lines. Header stores obligation text, category (payment, delivery, reporting, confidentiality, regulatory, IP assignment), responsible party, due date, recurrence schedule, priority, and fulfillment status. Line-level event records capture the full audit trail: creation, fulfillment, partial completion, breach notice, cure, waiver, and escalation events with actor, timestamp, event type, supporting document reference, and resulting status change. SSOT for all obligation data including lifecycle events. Core to CLM obligation tracking, dispute resolution evidence, and regulatory compliance reporting.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`contract`.`obligation_event` (
    `obligation_event_id` BIGINT COMMENT 'Unique identifier for the obligation event record. Primary key for the obligation event entity.',
    `contract_agreement_id` BIGINT COMMENT 'Reference to the contract under which this obligation event occurred. Provides context for the agreement governing the obligation.',
    `timekeeper_id` BIGINT COMMENT 'Identifier of the specific individual, organization, or system that performed or triggered the obligation event. The interpretation depends on actor_type (e.g., attorney ID, client ID, counterparty ID).',
    `legal_document_id` BIGINT COMMENT 'Structured identifier of the supporting document stored in the document management system. Links to the document entity for formal document tracking.',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter associated with this obligation event, if applicable. Links the event to the broader case or engagement context.',
    `obligation_actor_timekeeper_id` BIGINT COMMENT 'Foreign key linking to workforce.timekeeper. Business justification: Tracks which timekeeper performed obligation fulfillment, breach notification, or waiver actions. Essential for performance reviews, matter staffing decisions, and client service quality tracking. Act',
    `obligation_id` BIGINT COMMENT 'Reference to the parent obligation that this event pertains to. Links the event to the specific contractual obligation being tracked.',
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

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`contract`.`milestone` (
    `milestone_id` BIGINT COMMENT 'Unique identifier for the contract milestone record. Primary key.',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the attorney or legal professional responsible for managing and completing this milestone. Links to workforce or timekeeper records.',
    `contract_agreement_id` BIGINT COMMENT 'Reference to the parent contract or agreement to which this milestone belongs. Links milestone to the governing contract record.',
    `legal_document_id` BIGINT COMMENT 'Reference to the executed contract document or amendment in the Document Management System (DMS) that defines this milestone. Links milestone to source document for verification.',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: Milestones track service delivery progress against agreed scope. Supports project management dashboards, client status reporting, and service delivery analytics. Links milestone completion to specific',
    `matter_id` BIGINT COMMENT 'Reference to the associated matter or case record if the contract milestone is tied to active legal work. Links milestone tracking to matter management for integrated workflow.',
    `profile_id` BIGINT COMMENT 'Reference to the client organization or individual associated with this contract milestone. Supports client-centric reporting and relationship management.',
    `timekeeper_id` BIGINT COMMENT 'Reference to the user or system account that marked the milestone as completed. Supports audit trail and accountability tracking.',
    `actual_date` DATE COMMENT 'The date on which the milestone event actually occurred or was completed. Null if the milestone has not yet been completed. Used for performance tracking and compliance reporting.',
    `alert_lead_time_days` STRING COMMENT 'Number of days before the scheduled milestone date that an automated alert or notification should be triggered. Configurable per milestone to support proactive management.',
    `completion_notes` STRING COMMENT 'Free-text notes documenting how the milestone was satisfied, any issues encountered, or deviations from the scheduled plan. Captured at milestone completion for audit and knowledge management purposes.',
    `contractual_clause_reference` STRING COMMENT 'Reference to the specific clause, section, or article number in the contract document that defines this milestone obligation. Supports traceability to source agreement.',
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

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`contract`.`renewal` (
    `renewal_id` BIGINT COMMENT 'Unique identifier for the contract renewal record. Primary key.',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the partner responsible for managing the renewal decision and client communication. Links to the workforce or timekeeper master record.',
    `precedent_id` BIGINT COMMENT 'Foreign key linking to knowledge.precedent. Business justification: Renewal terms reference precedent renewal language and structures. Tracking this relationship ensures consistency across renewals, enables analysis of renewal patterns, and supports development of ren',
    `contract_agreement_id` BIGINT COMMENT 'Reference to the parent contract subject to renewal. Links to the contract master record.',
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
    `risk_level` STRING COMMENT 'Assessment of risk that the client may not renew: high (client dissatisfaction or competitive threat), medium (uncertain renewal), low (strong relationship and renewal expected).. Valid values are `high|medium|low`',
    `term_length` STRING COMMENT 'Duration of the renewal term in months. For example, a 12-month renewal or a 36-month multi-year extension.',
    `term_unit` STRING COMMENT 'Unit of measure for the renewal term length: month, year, or quarter.. Valid values are `month|year|quarter`',
    `to_agreement` BIGINT COMMENT 'FK to contract.agreement.agreement_id — Every renewal record manages the renewal lifecycle of a specific agreement. Without this FK, renewal pipeline management cannot function.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the renewal record was last modified.',
    CONSTRAINT pk_renewal PRIMARY KEY(`renewal_id`)
) COMMENT 'Manages the renewal lifecycle for agreements subject to auto-renewal, optional renewal, or renegotiation. Captures renewal type (auto-renew, opt-in, renegotiate), renewal term length, notice-to-cancel deadline, renewal decision (renew, terminate, renegotiate), decision date, responsible partner, AFA or fee adjustment for the renewal term, and the resulting successor agreement reference. Supports proactive renewal pipeline management.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`contract`.`amendment` (
    `amendment_id` BIGINT COMMENT 'Unique identifier for the contract amendment record. Primary key.',
    `check_id` BIGINT COMMENT 'Reference to the conflict check record performed for this amendment, if the amendment introduced new parties or scope that required conflict clearance.',
    `contract_agreement_id` BIGINT COMMENT 'Reference to the parent executed agreement being amended. Links to the master contract or engagement letter.',
    `dpia_id` BIGINT COMMENT 'Foreign key linking to compliance.dpia. Business justification: Contract amendments changing data processing scope, purposes, or recipients trigger GDPR DPIA requirements (Article 35). Legal teams link amendments to completed DPIAs for regulatory compliance audit ',
    `engagement_opportunity_id` BIGINT COMMENT 'Foreign key linking to intake.engagement_opportunity. Business justification: Amendments relate back to original engagement opportunities for scope creep analysis, fee arrangement renegotiation tracking, and estimated-vs-actual engagement value variance reporting. Supports clie',
    `matter_id` BIGINT COMMENT 'Reference to the matter or case under which this amendment was prepared and executed. Links amendment activity to billable work.',
    `parent_amendment_id` BIGINT COMMENT 'Self-referencing foreign key to a prior amendment that this amendment further modifies or supersedes. Enables tracking of amendment chains (e.g., Amendment 2.1 amends Amendment 2).',
    `precedent_id` BIGINT COMMENT 'Foreign key linking to knowledge.precedent. Business justification: Amendments reference precedent amendment language or are drafted using precedent templates. Tracking this relationship ensures consistency, quality control, and enables analysis of amendment patterns ',
    `timekeeper_id` BIGINT COMMENT 'Reference to the timekeeper (typically partner or senior counsel) who approved the amendment for execution.',
    `legal_document_id` BIGINT COMMENT 'Reference identifier to the clean (final executed) version of the amendment document stored in the Document Management System (DMS).',
    `primary_superseded_by_amendment_id` BIGINT COMMENT 'Reference to a later amendment that supersedes or replaces this amendment. Used to maintain the chain of agreement versions for audit and enforceability.',
    `profile_id` BIGINT COMMENT 'Reference to the client party to the agreement being amended. Enables client-level amendment tracking and reporting.',
    `amendment_description` STRING COMMENT 'Detailed narrative describing the changes introduced by this amendment, including clauses modified, obligations added or removed, and business rationale.',
    `amendment_number` STRING COMMENT 'Sequential or hierarchical amendment identifier (e.g., Amendment 1, Amendment 2.1). Business-facing reference number for the amendment.',
    `amendment_type` STRING COMMENT 'Classification of the amendment instrument: amendment (formal modification), addendum (supplemental terms), side letter (ancillary agreement), variation (scope change), waiver (temporary relief), novation (party substitution).. Valid values are `amendment|addendum|side_letter|variation|waiver|novation`',
    `approval_date` DATE COMMENT 'Date on which internal approval was granted for the amendment. Null if no approval was required or approval is still pending.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this amendment required formal internal approval (e.g., management committee, conflicts committee) before execution. True if approval was required, False otherwise.',
    `clauses_modified` STRING COMMENT 'Comma-separated list or structured reference to the specific clauses, sections, or articles of the parent agreement that are modified by this amendment (e.g., Section 3.2, Exhibit A, Schedule 1).',
    `confidentiality_level` STRING COMMENT 'Classification of the amendment documents confidentiality: standard (normal business confidential), highly_confidential (restricted distribution), attorney_client_privileged (protected by Legal Professional Privilege - LPP), work_product (attorney work product doctrine protection).. Valid values are `standard|highly_confidential|attorney_client_privileged|work_product`',
    `counterparty_name` STRING COMMENT 'Name of the other party (or parties) consenting to the amendment. May be the client (for engagement letters) or a third party (for vendor agreements).',
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

CREATE OR REPLACE TABLE `legal_ecm_v1`.`contract`.`negotiation_round` (
    `negotiation_round_id` BIGINT COMMENT 'Unique identifier for the negotiation round. Primary key for this entity.',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the attorney or timekeeper responsible for conducting this negotiation round on behalf of the firm. Links to workforce/timekeeper entity.',
    `contract_agreement_id` BIGINT COMMENT 'Reference to the contract being negotiated. Links this negotiation round to the parent contract entity.',
    `legal_document_id` BIGINT COMMENT 'Reference to the primary document entity for this negotiation round redline. Links to the document domain for full version control and metadata.',
    `matter_id` BIGINT COMMENT 'Reference to the matter under which this contract negotiation is being conducted. Enables tracking of negotiation work within the broader legal matter context.',
    `timekeeper_id` BIGINT COMMENT 'Reference to the user who last modified this negotiation round record. Links to workforce or user management entity for audit purposes.',
    `negotiation_owner_timekeeper_id` BIGINT COMMENT 'Reference to the user who created this negotiation round record. Links to workforce or user management entity for audit purposes.',
    `research_memo_id` BIGINT COMMENT 'Foreign key linking to knowledge.research_memo. Business justification: Negotiation positions are supported by legal research. Tracking which research memos inform negotiation strategy provides audit trail, supports position justification to clients, and enables reuse of ',
    `actual_completion_date` DATE COMMENT 'Actual date when this negotiation round was completed or closed. Used to measure performance against target and calculate cycle time.',
    `agreed_issues_count` STRING COMMENT 'Number of negotiation points or issues that were resolved and agreed upon during this round. Indicates progress toward final agreement.',
    `client_approval_date` DATE COMMENT 'Date when the client provided approval for this negotiation round or its outcome. Null if approval not required or not yet received.',
    `client_approval_received_flag` BOOLEAN COMMENT 'Indicates whether client approval has been obtained for this negotiation round. True if approved, False if pending or not required.',
    `client_approval_required_flag` BOOLEAN COMMENT 'Indicates whether client approval is required before proceeding with the next negotiation round. True if client sign-off is needed, False otherwise.',
    `communication_method` STRING COMMENT 'Primary method of communication used for this negotiation round. Tracks how the negotiation was conducted.. Valid values are `email|video_conference|phone|in_person|portal`',
    `counterparty_negotiator_email` STRING COMMENT 'Email address of the counterparty negotiator for this round. Used for communication tracking and audit trail.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `counterparty_negotiator_name` STRING COMMENT 'Name of the individual representing the counterparty in this negotiation round. May be external counsel, in-house counsel, or business representative.',
    `counterparty_organization_name` STRING COMMENT 'Name of the organization the counterparty negotiator represents. May be the client, vendor, or opposing party depending on contract type.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this negotiation round record was first created in the system. Audit trail for data lineage.',
    `cycle_time_days` DECIMAL(18,2) COMMENT 'Calculated duration in days from when the round was sent to when the counterparty response was returned. Critical metric for Legal Project Management (LPM) and Alternative Fee Arrangement (AFA) scoping.',
    `escalated_issues_count` STRING COMMENT 'Number of issues that required escalation to senior attorneys, partners, or client stakeholders during this round. Indicates negotiation difficulty.',
    `escalation_date` DATE COMMENT 'Date when the negotiation round was escalated to senior stakeholders. Null if no escalation occurred.',
    `escalation_reason` STRING COMMENT 'Explanation of why this negotiation round required escalation. May reference specific contentious terms, risk thresholds, or client authorization requirements.',
    `escalation_required_flag` BOOLEAN COMMENT 'Indicates whether this negotiation round requires or required escalation to senior attorneys, partners, or client decision-makers. True if escalation is needed, False otherwise.',
    `external_system_reference` STRING COMMENT 'Reference identifier from an external system such as Elite 3E, iManage Work, or client Contract Lifecycle Management (CLM) platform. Enables cross-system traceability.',
    `internal_review_duration_hours` DECIMAL(18,2) COMMENT 'Time spent by the firm in internal review and preparation before sending this round to the counterparty. Used for time tracking and efficiency analysis.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this negotiation round record is currently active. True for active records, False for archived or superseded rounds.',
    `key_terms_summary` STRING COMMENT 'Summary of the key contractual terms under negotiation in this round. May include pricing, liability caps, indemnification, termination rights, and other material provisions.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this negotiation round record was last modified. Audit trail for change tracking and data governance.',
    `negotiation_for_agreement` BIGINT COMMENT 'FK to contract.agreement.agreement_id — Negotiation rounds track the back-and-forth for a specific agreement under drafting. FK required for cycle time analytics and LPM reporting.',
    `negotiation_strategy` STRING COMMENT 'Description of the negotiation approach or strategy employed for this round. May include tactics, priorities, and fallback positions. Confidential attorney work product.',
    `negotiation_to_agreement` BIGINT COMMENT 'FK to contract.agreement.agreement_id — Each negotiation round tracks a cycle for a specific agreement under drafting or renegotiation.',
    `new_issues_count` STRING COMMENT 'Number of new negotiation points or issues raised by either party during this round. Tracks scope expansion or complexity increase.',
    `open_issues_count` STRING COMMENT 'Number of unresolved negotiation points or issues remaining at the conclusion of this round. Key metric for tracking negotiation progress and complexity.',
    `priority_level` STRING COMMENT 'Business priority assigned to this negotiation round. Influences resource allocation and response time targets.. Valid values are `low|medium|high|urgent`',
    `redline_version_reference` STRING COMMENT 'Reference identifier or version number for the redlined document associated with this negotiation round. Links to Document Management System (DMS) such as iManage Work or NetDocuments.',
    `returned_date` DATE COMMENT 'Date when the counterparty returned their response or redline for this negotiation round. Used to calculate turnaround time.',
    `returned_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the counterparty response was received. Enables granular cycle time measurement for Alternative Fee Arrangement (AFA) scoping.',
    `risk_level` STRING COMMENT 'Assessment of the risk level associated with the open issues and positions in this negotiation round. Used for prioritization and escalation decisions.. Valid values are `low|medium|high|critical`',
    `round_notes` STRING COMMENT 'Free-text notes capturing observations, counterparty positions, internal discussions, and other contextual information for this negotiation round. Attorney work product.',
    `round_number` STRING COMMENT 'Sequential number identifying this negotiation cycle within the contract negotiation process. Starts at 1 for the initial round and increments with each subsequent round.',
    `round_outcome` STRING COMMENT 'Final outcome classification for this negotiation round. Indicates whether the round resulted in agreement, required escalation, reached impasse, or was withdrawn.. Valid values are `agreed|escalated|impasse|withdrawn|pending`',
    `round_status` STRING COMMENT 'Current lifecycle status of this negotiation round. Tracks progression from draft through to final outcome. [ENUM-REF-CANDIDATE: draft|sent|under_review|agreed|escalated|impasse|withdrawn|superseded — 8 candidates stripped; promote to reference product]',
    `sent_date` DATE COMMENT 'Date when the negotiation draft or redline was sent to the counterparty for this round. Key milestone for cycle time tracking.',
    `sent_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the negotiation draft was transmitted to the counterparty. Enables detailed velocity analysis for Legal Project Management (LPM).',
    `target_completion_date` DATE COMMENT 'Target date by which this negotiation round is expected to be completed. Used for Legal Project Management (LPM) scheduling and client reporting.',
    CONSTRAINT pk_negotiation_round PRIMARY KEY(`negotiation_round_id`)
) COMMENT 'Tracks each discrete negotiation cycle for a contract under drafting or renegotiation. Records round number, dates sent/returned, negotiating attorney, counterparty negotiator, redline version reference, open/agreed issues count, and round outcome (agreed, escalated, impasse). Enables LPM tracking of negotiation velocity and cycle time for AFA scoping and client reporting.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`contract`.`execution_record` (
    `execution_record_id` BIGINT COMMENT 'Unique identifier for the execution record. Primary key.',
    `attorney_profile_id` BIGINT COMMENT 'Identifier of the attorney or legal professional responsible for overseeing and validating the execution process.',
    `contract_agreement_id` BIGINT COMMENT 'Reference to the contract or agreement that was executed. Links this execution event to the parent contract entity.',
    `legal_document_id` BIGINT COMMENT 'Reference identifier or URI to the executed document stored in the Document Management System (DMS). Links this execution record to the authoritative signed document artifact.',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter under which this execution was performed, linking the execution event to the broader legal engagement or case.',
    `profile_id` BIGINT COMMENT 'Reference to the client on whose behalf the agreement was executed, linking the execution record to the client entity.',
    `sanctions_check_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_check. Business justification: Contract execution requires sanctions screening of signatories and counterparties per AML regulations and OFAC requirements. Legal operations link execution records to screening results for regulatory',
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
    `executed_document_version` STRING COMMENT 'Version number or identifier of the executed document in the DMS, ensuring traceability to the exact document version that was signed.',
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

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`contract`.`termination` (
    `termination_id` BIGINT COMMENT 'Unique identifier for the contract termination record. Primary key.',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the attorney or legal professional responsible for managing the termination process, including notice, negotiation, and compliance.',
    `check_id` BIGINT COMMENT 'Foreign key linking to conflict.conflict_check. Business justification: Contract terminations, especially disputed ones, may require conflict re-assessment when the firm considers representing a party in termination disputes or when adverse relationships emerge. The exist',
    `client_contact_id` BIGINT COMMENT 'Reference to the contact record of the individual who formally issued the termination notice on behalf of the terminating party.',
    `contract_agreement_id` BIGINT COMMENT 'Reference to the contract or agreement that has been terminated. Links to the parent contract record in the contract domain.',
    `docket_id` BIGINT COMMENT 'Foreign key linking to court.docket. Business justification: Breach-based contract terminations frequently trigger litigation. Legal teams must link terminations to resulting court proceedings for dispute tracking, damages calculation, and litigation strategy. ',
    `legal_document_id` BIGINT COMMENT 'Reference to the termination notice document, settlement agreement, or related correspondence stored in the Document Management System (DMS - iManage Work or NetDocuments).',
    `matter_id` BIGINT COMMENT 'Reference to the matter under which the termination was processed, if applicable. Links termination to the legal work performed.',
    `regulatory_breach_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_breach. Business justification: Contract terminations may result from regulatory breaches (terminating client relationship due to AML concerns, ending engagement after conflicts breach). Compliance teams track terminations linked to',
    `timekeeper_id` BIGINT COMMENT 'Reference to the user or authority who approved the termination decision, if approval was required.',
    `approval_date` DATE COMMENT 'The date on which the termination was formally approved by the required authority.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether the termination required internal approval (e.g., from General Counsel, Chief Legal Officer, or management committee). True if approval was required; False otherwise.',
    `contractual_clause_reference` STRING COMMENT 'Citation to the specific termination clause, section, or article in the contract that authorizes or governs the termination (e.g., Section 12.3 - Termination for Cause).',
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
    `risk_category` STRING COMMENT 'Assessment of the professional indemnity, reputational, or financial risk associated with this termination: low, medium, high, or critical. Feeds risk registers and compliance reporting.. Valid values are `low|medium|high|critical`',
    `settlement_date` DATE COMMENT 'The date on which the termination dispute was formally settled or resolved between the parties.',
    `settlement_reached_flag` BOOLEAN COMMENT 'Indicates whether a settlement or resolution has been reached regarding the termination dispute. True if settled; False otherwise.',
    `settlement_terms` STRING COMMENT 'Summary of the key terms and conditions agreed upon in the settlement of the termination dispute, including any financial or performance obligations.',
    `surviving_clauses` STRING COMMENT 'List or citation of specific contract clauses that expressly survive termination (e.g., Sections 8 (Confidentiality), 10 (Indemnity), 14 (Governing Law)).',
    `terminating_party_name` STRING COMMENT 'The legal name of the party or entity that initiated or triggered the termination.',
    `terminating_party_type` STRING COMMENT 'Classification of the party that initiated the termination: client (client-initiated), firm (law firm-initiated), vendor (supplier-initiated), mutual (both parties agreed), third_party (external event or regulator).. Valid values are `client|firm|vendor|mutual|third_party`',
    `termination_status` STRING COMMENT 'Current lifecycle status of the termination: pending (notice given but not yet effective), effective (termination complete), disputed (contested by one or more parties), settled (dispute resolved), withdrawn (termination notice retracted).. Valid values are `pending|effective|disputed|settled|withdrawn`',
    `termination_type` STRING COMMENT 'Classification of the termination event: expiry (natural end of term), termination for convenience (voluntary exit without cause), termination for cause (breach or default), mutual rescission (agreed cancellation), frustration (impossibility of performance), or breach (material violation).. Valid values are `expiry|termination_for_convenience|termination_for_cause|mutual_rescission|frustration|breach`',
    `to_agreement` BIGINT COMMENT 'FK to contract.agreement.agreement_id — Each termination record documents the end of a specific agreement. Critical for compliance reporting and PI risk registers.',
    `wind_down_completion_date` DATE COMMENT 'The date by which all wind-down activities, handovers, and post-termination obligations are expected to be completed.',
    `wind_down_period_days` STRING COMMENT 'The number of days allowed or required for orderly wind-down of services, handover of work product, or transition activities following the effective termination date.',
    CONSTRAINT pk_termination PRIMARY KEY(`termination_id`)
) COMMENT 'Records the termination or expiry of an agreement, capturing termination type (expiry, termination for convenience, termination for cause, mutual rescission, frustration), effective termination date, notice date, terminating party, grounds for termination, dispute flag, post-termination obligations surviving, and settlement or wind-down terms. Feeds compliance reporting and professional indemnity risk registers.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`contract`.`clause_library` (
    `clause_library_id` BIGINT COMMENT 'Primary key for clause_library',
    `clause_id` BIGINT COMMENT 'Foreign key linking to knowledge.clause. Business justification: Contract clause library entries are sourced from or synchronized with the central knowledge clause library. Tracking this relationship prevents duplication, ensures consistency between contract and kn',
    `timekeeper_id` BIGINT COMMENT 'Identifier of the user who last modified this clause library entry.',
    `clause_owner_timekeeper_id` BIGINT COMMENT 'Identifier of the user or knowledge management professional who created this clause library entry.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Standard clauses implement firm compliance policies (indemnity clause per risk policy, data protection clause per privacy policy, payment terms per finance policy). Clause approval workflows verify po',
    `practice_group_id` BIGINT COMMENT 'Foreign key linking to workforce.practice_group. Business justification: Clause libraries are organized by practice area for knowledge management, template assembly, and practice-specific clause approval workflows. Practice_group text field should be replaced with proper F',
    `attorney_profile_id` BIGINT COMMENT 'Identifier of the attorney or knowledge management professional who is the designated owner and subject matter expert for this clause. Responsible for updates, approvals, and guidance.',
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
    `jurisdiction_applicability` STRING COMMENT 'Comma-separated list of jurisdictions or legal systems where this clause is applicable and enforceable. Uses ISO 3166-1 alpha-3 country codes (e.g., USA, GBR, DEU) or legal system identifiers (e.g., Common Law, Civil Law, Sharia).',
    `keywords` STRING COMMENT 'Comma-separated list of keywords and tags for search and discovery within the clause library. Facilitates Natural Language Processing (NLP) and search functionality in Contract Lifecycle Management (CLM) systems.',
    `language_code` STRING COMMENT 'ISO 639-1 or ISO 639-2 language code indicating the language in which the clause text is written (e.g., en for English, en-US for US English, fr for French, de for German).. Valid values are `^[a-z]{2,3}(-[A-Z]{2})?$`',
    `last_review_date` DATE COMMENT 'Date of the most recent periodic review of the clause for legal accuracy, regulatory compliance, and alignment with current firm standards.',
    `last_used_date` DATE COMMENT 'Date when this clause was most recently included in a contract. Helps identify obsolete or underutilized clauses.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this clause library entry was last modified or updated.',
    `negotiation_notes` STRING COMMENT 'Internal notes and best practices for negotiating this clause with counterparties, including common objections, acceptable modifications, and red lines that should not be crossed.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next mandatory review of the clause to ensure ongoing compliance and relevance.',
    `regulatory_framework` STRING COMMENT 'Comma-separated list of regulatory frameworks or compliance standards that this clause addresses, such as General Data Protection Regulation (GDPR), Sarbanes-Oxley Act (SOX), California Consumer Privacy Act (CCPA), Anti-Money Laundering (AML), Know Your Client (KYC), or Fair Reasonable and Non-Discriminatory (FRAND) licensing requirements.',
    `related_clause_ids` STRING COMMENT 'Comma-separated list of contract_clause_library_id values for related or complementary clauses that are often used together or serve similar purposes. Supports clause recommendation and bundling.',
    `sox_compliant_flag` BOOLEAN COMMENT 'Indicates whether the clause meets Sarbanes-Oxley Act (SOX) requirements for financial controls, audit rights, and corporate governance in contracts with public companies.',
    `template_integration_flag` BOOLEAN COMMENT 'Indicates whether this clause is integrated into automated contract templates within the Contract Lifecycle Management (CLM) or Document Management System (DMS) for automated document assembly.',
    `usage_count` STRING COMMENT 'Total number of times this clause has been used in executed contracts. Provides insight into clause popularity and effectiveness.',
    `usage_guidance` STRING COMMENT 'Practical guidance for attorneys on when to use this clause, including recommended matter types, client profiles, transaction structures, and risk scenarios where the clause is most appropriate.',
    `usage_tier` STRING COMMENT 'Designation of the clause usage priority within the firm: mandatory (must be included), preferred (strongly recommended), fallback (use when primary is rejected), optional (discretionary), or deprecated (no longer recommended).. Valid values are `mandatory|preferred|fallback|optional|deprecated`',
    `version_number` STRING COMMENT 'Semantic version number of the clause text following major.minor.patch convention to track revisions and updates over time.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    `word_count` STRING COMMENT 'Total word count of the approved clause text. Used for document assembly planning and readability analysis.',
    CONSTRAINT pk_clause_library PRIMARY KEY(`clause_library_id`)
) COMMENT 'Curated repository of approved standard and fallback clauses maintained by knowledge management and CLM teams. Each clause stores type (indemnity, limitation of liability, governing law, force majeure, IP assignment, confidentiality, FRAND, arbitration), approved text, fallback text, jurisdiction applicability, practice group owner, approval date, and usage tier (mandatory, preferred, fallback). Integrates with external standard clause guidance sources.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`contract`.`clause_deviation` (
    `clause_deviation_id` BIGINT COMMENT 'Unique identifier for the clause deviation record. Primary key.',
    `clause_id` BIGINT COMMENT 'Foreign key linking to knowledge.clause. Business justification: Deviations reference the approved knowledge clause that was modified. Essential for risk management, tracking negotiation patterns, measuring clause negotiability, and identifying clauses requiring pl',
    `timekeeper_id` BIGINT COMMENT 'Identifier of the user who last modified this clause deviation record.',
    `contract_agreement_id` BIGINT COMMENT 'Reference to the contract or agreement in which this clause deviation occurred.',
    `deviation_owner_timekeeper_id` BIGINT COMMENT 'Identifier of the user who created this clause deviation record.',
    `legal_document_id` BIGINT COMMENT 'Reference identifier to the executed contract document in the Document Management System (DMS) where this deviation is recorded.',
    `matter_id` BIGINT COMMENT 'Reference to the matter under which the contract negotiation was conducted, if applicable.',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Clause deviations are analyzed by practice area for risk management, playbook updates, and precedent tracking. Replaces denormalized practice_area string with structured FK. Essential for risk analyti',
    `precedent_id` BIGINT COMMENT 'Foreign key linking to knowledge.precedent. Business justification: Clause deviations are evaluated against approved precedent positions. Tracking which precedent was deviated from enables risk assessment, supports professional indemnity analysis, and informs playbook',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the partner who approved the deviation from the standard clause position.',
    `clause_library_id` BIGINT COMMENT 'FK to contract.contract_clause_library.contract_clause_library_id — Each deviation references the approved standard clause it departs from. This FK enables tracking which clauses are most frequently deviated from.',
    `profile_id` BIGINT COMMENT 'Reference to the client for whom the contract was negotiated.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Deviations from approved clause positions create professional indemnity exposure and precedent risks tracked for PI underwriting, deviation approval workflow, and playbook risk management. Essential f',
    `regulatory_breach_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_breach. Business justification: Clause deviations from approved positions may constitute or lead to regulatory breaches (accepting unlimited liability breaches risk policy, waiving AML checks breaches regulatory obligations). Risk m',
    `approval_date` DATE COMMENT 'Date on which the clause deviation was formally approved by the responsible partner.',
    `approved_position` STRING COMMENT 'The firms approved standard or fallback clause language or position as documented in the clause library or playbook.',
    `approving_partner_name` STRING COMMENT 'Full name of the partner who approved the clause deviation.',
    `clause_section_reference` STRING COMMENT 'Specific section, article, or clause number within the contract document where the deviation appears.',
    `clause_type_code` STRING COMMENT 'Standardized code identifying the type of clause that was deviated from (e.g., indemnity, limitation of liability, confidentiality, termination, governing law, dispute resolution, intellectual property, warranty, force majeure).',
    `clause_type_name` STRING COMMENT 'Human-readable name of the clause type that was deviated from.',
    `counterparty_name` STRING COMMENT 'Name of the counterparty organization or individual with whom the clause was negotiated.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this clause deviation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for any financial amounts associated with this deviation.. Valid values are `^[A-Z]{3}$`',
    `deviation_category` STRING COMMENT 'Classification of the deviation based on its materiality and impact on the firms risk profile.. Valid values are `material|non_material|technical|substantive`',
    `deviation_in_agreement` BIGINT COMMENT 'FK to contract.agreement.agreement_id — Clause deviations track departures from standard positions in a specific negotiated agreement. FK required for risk aggregation per contract.',
    `deviation_rationale` STRING COMMENT 'Detailed business and legal rationale explaining why the deviation from the approved clause position was necessary or acceptable.',
    `deviation_summary` STRING COMMENT 'Brief summary of the nature and extent of the deviation from the approved clause position.',
    `deviation_to_agreement` BIGINT COMMENT 'FK to contract.agreement.agreement_id — Each clause deviation records a departure from standard position in a specific negotiated agreement.',
    `escalation_date` DATE COMMENT 'Date on which the deviation was escalated to higher authority for review and decision.',
    `escalation_required_flag` BOOLEAN COMMENT 'Indicates whether this deviation requires escalation to senior management, risk committee, or General Counsel (GC) for review.',
    `external_counsel_involved_flag` BOOLEAN COMMENT 'Indicates whether external counsel or Alternative Legal Service Provider (ALSP) was involved in negotiating or approving this deviation.',
    `external_counsel_name` STRING COMMENT 'Name of the external law firm or ALSP involved in this clause deviation, if applicable.',
    `indemnity_exposure_amount` DECIMAL(18,2) COMMENT 'Estimated financial exposure amount associated with this clause deviation for professional indemnity purposes.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this clause deviation record is currently active and relevant, or has been superseded or archived.',
    `jurisdiction` STRING COMMENT 'Legal jurisdiction or governing law context relevant to this clause deviation.',
    `lessons_learned` STRING COMMENT 'Knowledge management notes capturing lessons learned from this deviation for future negotiations and continuous improvement of the clause library.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this clause deviation record was last modified.',
    `negotiated_position` STRING COMMENT 'The actual clause language or position agreed upon in the negotiated contract, representing the deviation from the approved position.',
    `negotiating_attorney_name` STRING COMMENT 'Full name of the attorney who negotiated the clause deviation.',
    `playbook_update_required_flag` BOOLEAN COMMENT 'Indicates whether this deviation requires an update to the firms clause playbook or negotiation guidelines.',
    `playbook_update_status` STRING COMMENT 'Current status of any required playbook or clause library update resulting from this deviation.. Valid values are `not_required|pending|in_progress|completed`',
    `precedent_flag` BOOLEAN COMMENT 'Indicates whether this deviation sets a precedent that should be considered for incorporation into the firms standard clause library or playbook.',
    `professional_indemnity_exposure_flag` BOOLEAN COMMENT 'Indicates whether this clause deviation creates potential professional indemnity insurance exposure for the firm.',
    `regulatory_framework` STRING COMMENT 'Specific regulatory framework or compliance requirement impacted by this clause deviation (e.g., GDPR, SOX, AML, FRAND, CCPA).',
    `regulatory_impact_flag` BOOLEAN COMMENT 'Indicates whether this clause deviation has implications for regulatory compliance (e.g., GDPR, AML, SOX, FRAND).',
    `review_status` STRING COMMENT 'Current status of the deviation review and approval workflow.. Valid values are `pending_review|under_review|approved|rejected|escalated`',
    `risk_rating` STRING COMMENT 'Assessment of the risk level associated with this clause deviation, considering potential exposure to professional indemnity claims, client disputes, or regulatory issues.. Valid values are `low|medium|high|critical`',
    CONSTRAINT pk_clause_deviation PRIMARY KEY(`clause_deviation_id`)
) COMMENT 'Tracks every instance where a negotiated agreement departs from the firms approved standard or fallback clause position. Records the agreement, clause type, approved position, negotiated position, deviation rationale, approving partner, approval date, risk rating, and whether the deviation sets a precedent requiring playbook update. Supports risk management, professional indemnity exposure tracking, and continuous improvement of the clause library.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`contract`.`afa_arrangement` (
    `afa_arrangement_id` BIGINT COMMENT 'Unique identifier for the Alternative Fee Arrangement record. Primary key.',
    `check_id` BIGINT COMMENT 'Foreign key linking to conflict.conflict_check. Business justification: Alternative fee arrangements establish or modify client relationships and require independent conflict clearance, especially for contingency or success-fee structures where the firms financial intere',
    `contract_agreement_id` BIGINT COMMENT 'Reference to the parent engagement letter, retainer agreement, or Letter of Engagement (LOE) that contains this AFA arrangement.',
    `docket_id` BIGINT COMMENT 'Foreign key linking to court.docket. Business justification: Alternative fee arrangements are matter-specific billing agreements tied to specific litigation dockets. Firms need to track which AFA applies to each docket for budget management, variance analysis, ',
    `indemnity_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.indemnity_policy. Business justification: Alternative fee arrangements (contingency fees, success fees, budget caps) are underwritten against professional indemnity coverage. Finance and risk teams verify arrangements fall within policy limit',
    `intake_fee_arrangement_id` BIGINT COMMENT 'Foreign key linking to intake.intake_fee_arrangement. Business justification: Alternative fee arrangements in executed contracts originate from fee arrangements proposed during intake. Legal operations link these for variance analysis between proposed and final terms, discount ',
    `letter_of_engagement_id` BIGINT COMMENT 'Foreign key linking to intake.letter_of_engagement. Business justification: AFA arrangements reference fee terms specified in letters of engagement. Legal operations validate executed AFA terms against LOE commitments for billing compliance, client expectation management, and',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter or case to which this AFA arrangement applies, if the arrangement is matter-specific rather than client-wide.',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the attorney who originated the client relationship or matter that led to this AFA arrangement, relevant for origination credit and Revenue Per Equity Partner (RPE) calculations.',
    `precedent_id` BIGINT COMMENT 'Foreign key linking to knowledge.precedent. Business justification: Alternative fee arrangements reference precedent AFA structures and terms. Tracking this relationship enables benchmarking, helps attorneys propose competitive arrangements based on proven models, and',
    `pricing_model_id` BIGINT COMMENT 'Foreign key linking to service.pricing_model. Business justification: AFA arrangements are instances of pricing models. Links enable alternative fee tracking, realization rate analysis by pricing model, and AFA performance benchmarking. Replaces denormalized afa_type st',
    `primary_afa_attorney_profile_id` BIGINT COMMENT 'Reference to the equity partner or relationship partner responsible for managing this AFA arrangement and ensuring compliance with its terms.',
    `profile_id` BIGINT COMMENT 'Reference to the client organization or individual who is party to this Alternative Fee Arrangement.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Alternative fee arrangements carry financial risk (budget overruns, scope creep, collection risk) tracked in risk registers for AFA risk assessment, budget monitoring, and profitability management. Es',
    `timekeeper_id` BIGINT COMMENT 'Reference to the user (typically a partner, pricing committee member, or Chief Legal Officer) who approved this AFA arrangement. Null if no approval required or not yet approved.',
    `actual_hours_to_date` DECIMAL(18,2) COMMENT 'The cumulative number of billable hours recorded against this AFA arrangement to date. Used for tracking progress against estimated hours and identifying potential overruns.',
    `afa_in_agreement` BIGINT COMMENT 'FK to contract.agreement.agreement_id — AFA terms are embedded in specific engagement letters/retainer agreements. FK required to link fee commitments to their governing contract.',
    `afa_to_agreement` BIGINT COMMENT 'FK to contract.agreement.agreement_id — Each AFA arrangement is defined within a specific engagement letter or retainer agreement. The fee terms are contractual commitments embedded in the agreement.',
    `agreed_fee_amount` DECIMAL(18,2) COMMENT 'The total fee amount agreed under this AFA arrangement. For fixed fee arrangements, this is the total fee. For capped fee, this is the maximum cap. For subscription retainers, this is the periodic fee amount. Null for contingency arrangements where fee is percentage-based.',
    `approval_date` DATE COMMENT 'The date on which this AFA arrangement was formally approved by the designated authority. Null if not yet approved or no approval required.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this AFA arrangement required formal approval by firm management, pricing committee, or conflicts committee before activation. True: approval was required. False: no approval required.',
    `arrangement_name` STRING COMMENT 'Descriptive name or title for this AFA arrangement, often reflecting the scope or project name (e.g., M&A Transaction Fixed Fee, IP Portfolio Subscription).',
    `arrangement_number` STRING COMMENT 'Business-facing unique identifier or reference number for this AFA arrangement, used in client communications and billing documentation.',
    `arrangement_status` STRING COMMENT 'Current lifecycle status of the AFA arrangement. Draft: being prepared. Proposed: submitted to client. Negotiation: under discussion. Approved: accepted by all parties. Active: currently in effect. Suspended: temporarily paused. Completed: scope fulfilled. Terminated: ended early. Expired: term ended. [ENUM-REF-CANDIDATE: draft|proposed|negotiation|approved|active|suspended|completed|terminated|expired — 9 candidates stripped; promote to reference product]',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether this AFA arrangement automatically renews at the end of its term. True: arrangement renews automatically unless terminated. False: arrangement ends at effective end date.',
    `billing_frequency` STRING COMMENT 'The frequency at which invoices are issued under this AFA arrangement. One-time: single invoice. Monthly/Quarterly/Annual: recurring subscription. Milestone-based: invoice upon achieving milestones. Upon completion: invoice at end of matter. As incurred: invoice as work is performed (for capped fee). [ENUM-REF-CANDIDATE: one_time|monthly|quarterly|semi_annual|annual|milestone_based|upon_completion|as_incurred — 8 candidates stripped; promote to reference product]',
    `blended_rate_amount` DECIMAL(18,2) COMMENT 'The single hourly rate applied to all timekeepers under a blended rate AFA arrangement. Null for non-blended-rate arrangements.',
    `budget_cap_amount` DECIMAL(18,2) COMMENT 'The maximum budget or spending limit for this AFA arrangement. For capped fee arrangements, this is the ceiling. For fixed fee, may represent the not-to-exceed amount including disbursements.',
    `collected_amount_to_date` DECIMAL(18,2) COMMENT 'The cumulative amount collected (cash received) under this AFA arrangement to date. Used for tracking cash realization and outstanding Accounts Receivable (AR).',
    `contingency_percentage` DECIMAL(18,2) COMMENT 'The percentage of recovery or settlement amount that constitutes the firms fee under a contingency arrangement. Typically ranges from 10% to 40%. Null for non-contingency arrangements.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this AFA arrangement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the agreed fee amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `disbursement_cap_amount` DECIMAL(18,2) COMMENT 'The maximum amount of disbursements that can be billed under this AFA arrangement, if a disbursement cap applies. Null if no cap or disbursements are included in fee.',
    `disbursement_handling` STRING COMMENT 'Defines how disbursements (out-of-pocket expenses such as court fees, filing fees, expert witness fees) are treated under this AFA. Included in fee: covered by fixed fee. Billed separately at cost: passed through at actual cost. Billed separately with markup: passed through with percentage markup. Capped: subject to separate cap. Excluded: not covered.. Valid values are `included_in_fee|billed_separately_at_cost|billed_separately_with_markup|capped|excluded`',
    `discount_percentage` DECIMAL(18,2) COMMENT 'The percentage discount applied to standard hourly rates under this AFA arrangement, if applicable. Used for volume discount or relationship-based pricing. Null if no discount or fixed fee arrangement.',
    `effective_end_date` DATE COMMENT 'The date on which this AFA arrangement expires or is scheduled to end. Null for open-ended arrangements or those tied to matter completion.',
    `effective_start_date` DATE COMMENT 'The date on which this AFA arrangement becomes effective and billing under these terms begins.',
    `estimated_hours` DECIMAL(18,2) COMMENT 'The estimated total number of billable hours required to complete the scope of services under this AFA arrangement. Used for budgeting and resource planning. Null for non-hourly arrangements.',
    `invoiced_amount_to_date` DECIMAL(18,2) COMMENT 'The cumulative amount invoiced under this AFA arrangement to date, across all invoices. Used for tracking revenue recognition and remaining balance.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this AFA arrangement record is currently active and in use. True: active. False: inactive or archived.',
    `ledes_billing_code` STRING COMMENT 'The LEDES billing code associated with this AFA arrangement, used for electronic invoice submission and compliance with client billing guidelines.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this AFA arrangement record was last modified or updated.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special terms, or internal comments regarding this AFA arrangement (e.g., negotiation history, client preferences, special billing instructions).',
    `overage_handling_method` STRING COMMENT 'Defines how work exceeding the agreed scope or budget cap is handled. No overage: firm absorbs excess. Client approval required: additional work requires written approval. Automatic billing: overage billed at standard rates. Write-off: firm writes off excess. Renegotiate: parties renegotiate terms.. Valid values are `no_overage|client_approval_required|automatic_billing|write_off|renegotiate`',
    `overage_rate_amount` DECIMAL(18,2) COMMENT 'The hourly rate or fee rate applied to work that exceeds the agreed scope or budget cap, if overage billing is permitted. Null if no overage billing allowed.',
    `payment_terms_days` STRING COMMENT 'Number of days from invoice date within which payment is due under this AFA arrangement (e.g., 30 days, 60 days).',
    `performance_metrics` STRING COMMENT 'Description of the key performance indicators (KPIs) or success criteria used to measure performance under this AFA arrangement (e.g., matter outcome, time to resolution, client satisfaction score, cost savings achieved).',
    `renewal_notice_period_days` STRING COMMENT 'Number of days prior to effective end date by which either party must provide notice to prevent auto-renewal or to terminate the arrangement. Null if no auto-renewal or no notice requirement.',
    `risk_allocation_notes` STRING COMMENT 'Narrative description of how financial and performance risk is allocated between the firm and client under this AFA arrangement (e.g., firm bears risk of scope creep, client bears risk of third-party costs).',
    `scope_of_services` STRING COMMENT 'Detailed description of the legal services, deliverables, and work scope covered under this AFA arrangement. Defines what is included and excluded from the agreed fee.',
    `success_fee_percentage` DECIMAL(18,2) COMMENT 'The percentage uplift or bonus fee applied upon achieving defined success criteria (e.g., winning case, closing transaction). Null for non-success-fee arrangements.',
    `utbms_task_code` STRING COMMENT 'The UTBMS task code(s) that define the categories of legal work covered under this AFA arrangement, used for standardized activity-based billing and reporting.',
    CONSTRAINT pk_afa_arrangement PRIMARY KEY(`afa_arrangement_id`)
) COMMENT 'Records the Alternative Fee Arrangement (AFA) terms agreed in client-facing engagement letters and retainer agreements, including AFA type (fixed fee, capped fee, blended rate, success fee, contingency, subscription retainer), agreed fee amount or rate, scope of services covered, billing frequency, budget cap, overage handling, and currency. Distinct from billing domain invoices — this is the contractual fee commitment that governs how billing is calculated.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`contract`.`agreement_type_clause_policy` (
    `agreement_type_clause_policy_id` BIGINT COMMENT 'Primary key for the agreement_type_clause_policy association',
    `attorney_profile_id` BIGINT COMMENT 'Identifier of the attorney or knowledge management professional who created this clause policy rule.',
    `agreement_last_modified_by_attorney_profile_id` BIGINT COMMENT 'Identifier of the attorney or knowledge management professional who last modified this clause policy rule.',
    `agreement_type_id` BIGINT COMMENT 'Foreign key linking to the agreement type for which this clause policy applies',
    `clause_library_id` BIGINT COMMENT 'Foreign key linking to the clause library entry governed by this policy',
    `clause_id` BIGINT COMMENT 'Reference to an alternative clause from the clause library to use if this clause is rejected during negotiation. Null if no fallback is defined.',
    `agreement_type_clause_policy_status` STRING COMMENT 'Current lifecycle status of this clause policy rule: active (in use), under_review (being evaluated), deprecated (phasing out), superseded (replaced by newer policy).',
    `approval_authority_required` STRING COMMENT 'Level of approval authority required to deviate from this clause policy (omit mandatory clause or modify non-negotiable clause): none, partner, practice_group_lead, general_counsel, clo.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this clause policy rule was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when this clause policy rule was retired or superseded. Null if the policy is currently active.',
    `effective_start_date` DATE COMMENT 'Date from which this clause policy rule became effective and should be applied to new agreements of this type.',
    `is_default_flag` BOOLEAN COMMENT 'Indicates whether this clause should be pre-populated by default when creating a new agreement of this type in the CLM system.',
    `is_mandatory_flag` BOOLEAN COMMENT 'Indicates whether this clause must be included in all agreements of this type. Mandatory clauses cannot be omitted during contract drafting.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this clause policy rule.',
    `last_reviewed_date` DATE COMMENT 'Date when this specific clause policy rule was last reviewed by the knowledge management team for continued applicability and accuracy.',
    `negotiation_flexibility_level` STRING COMMENT 'Guidance on how much flexibility attorneys have to modify or remove this clause during negotiation for this agreement type: non-negotiable, low, medium, high.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next mandatory review of this clause policy rule to ensure ongoing compliance and business alignment.',
    `policy_rationale` STRING COMMENT 'Business or legal justification for why this clause is required, recommended, or optional for this agreement type. May reference regulatory requirements, risk management policies, or court precedents.',
    `usage_tier` STRING COMMENT 'Policy designation for clause usage priority within this agreement type: mandatory (must include), preferred (recommended), optional (available), fallback (use if preferred unavailable), deprecated (phase out).',
    CONSTRAINT pk_agreement_type_clause_policy PRIMARY KEY(`agreement_type_clause_policy_id`)
) COMMENT 'This association product represents the clause playbook policy between agreement types and clause library entries. It captures the knowledge management rules that define which clauses are mandatory, recommended, or optional for each agreement type. Each record links one agreement type to one clause with policy attributes that govern clause selection and usage during contract drafting and negotiation.. Existence Justification: This is a genuine operational M:N relationship representing the Agreement Type Clause Playbook, a core knowledge management concept in legal contract lifecycle management. Law firms actively maintain policy rules that define which clauses are mandatory, recommended, or optional for each agreement type. Knowledge management teams update these playbooks when regulations change (e.g., requiring specific clauses in all NDAs) or when court rulings affect clause risk profiles. This is distinct from template composition—it is the policy layer that governs clause selection during contract drafting.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`contract`.`template_clause` (
    `template_clause_id` BIGINT COMMENT 'Unique identifier for this template-clause composition record. Primary key.',
    `timekeeper_id` BIGINT COMMENT 'Foreign key to workforce.timekeeper.timekeeper_id',
    `clause_library_id` BIGINT COMMENT 'Foreign key linking to the clause library entry included in this template',
    `template_id` BIGINT COMMENT 'Foreign key linking to the contract template that includes this clause',
    `approved_by_attorney` STRING COMMENT 'Name or identifier of the attorney or knowledge management professional who approved the inclusion of this clause in this template.',
    `clause_library_references` STRING COMMENT 'Comma-separated list of clause library identifiers or standard clause references incorporated into this template for modular clause management. [Moved from contract_template: This denormalized STRING attribute on contract_template stores comma-separated clause library identifiers, which is the exact relationship now being properly normalized into the template_clause association. This attribute becomes redundant once the M:N association is established and should be deprecated.]',
    `clause_sequence_order` STRING COMMENT 'Ordinal position of this clause within the template document structure. Determines the sequence in which clauses appear in contracts generated from this template.',
    `customization_notes` STRING COMMENT 'Template-specific guidance for attorneys on how to customize or negotiate this clause when using this particular template.',
    `effective_end_date` DATE COMMENT 'Date when this clause is no longer included in this template. Null indicates the clause is currently active in the template.',
    `effective_start_date` DATE COMMENT 'Date from which this clause becomes active in this template for new contract generation.',
    `inclusion_date` DATE COMMENT 'Date when this clause was added to this template composition.',
    `is_mandatory_flag` BOOLEAN COMMENT 'Indicates whether this clause must be included when generating a contract from this template. Mandatory clauses cannot be removed during contract customization.',
    `is_optional_flag` BOOLEAN COMMENT 'Indicates whether this clause is optional and may be included or excluded by the attorney during contract generation based on deal-specific requirements.',
    `jurisdiction_specific_flag` BOOLEAN COMMENT 'Indicates whether this clause inclusion is specific to certain jurisdictions covered by the template. Used when templates support multiple jurisdictions with jurisdiction-conditional clauses.',
    `last_reviewed_date` DATE COMMENT 'Date when the inclusion of this specific clause in this specific template was last reviewed by knowledge management or the practice group owner for continued appropriateness.',
    `usage_tier_override` STRING COMMENT 'Template-specific override of the clause library usage tier. Allows a clause marked as preferred in the library to be mandatory in a specific template context.',
    CONSTRAINT pk_template_clause PRIMARY KEY(`template_clause_id`)
) COMMENT 'This association product represents the composition relationship between contract templates and clause library entries. It captures which approved clauses are included in which contract templates, along with sequencing, optionality, and jurisdiction-specific overrides. Each record links one contract template to one clause with attributes that govern how that clause is used within that specific template context.. Existence Justification: Law firms actively manage template composition as a core knowledge management process. Knowledge management teams curate which approved clauses belong in which contract templates, attorneys review and approve clause selections for specific template types, and compliance teams audit template composition for regulatory adherence. This is not a derived correlation but an operational business process where the firm maintains explicit clause-to-template assignments with sequencing, optionality rules, and jurisdiction-specific overrides.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ADD CONSTRAINT `fk_contract_contract_agreement_agreement_type_id` FOREIGN KEY (`agreement_type_id`) REFERENCES `legal_ecm_v1`.`contract`.`agreement_type`(`agreement_type_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ADD CONSTRAINT `fk_contract_contract_agreement_parent_agreement_contract_agreement_id` FOREIGN KEY (`parent_agreement_contract_agreement_id`) REFERENCES `legal_ecm_v1`.`contract`.`contract_agreement`(`contract_agreement_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ADD CONSTRAINT `fk_contract_contract_agreement_template_id` FOREIGN KEY (`template_id`) REFERENCES `legal_ecm_v1`.`contract`.`template`(`template_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ADD CONSTRAINT `fk_contract_template_agreement_type_id` FOREIGN KEY (`agreement_type_id`) REFERENCES `legal_ecm_v1`.`contract`.`agreement_type`(`agreement_type_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ADD CONSTRAINT `fk_contract_template_superseded_by_template_id` FOREIGN KEY (`superseded_by_template_id`) REFERENCES `legal_ecm_v1`.`contract`.`template`(`template_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ADD CONSTRAINT `fk_contract_contract_party_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm_v1`.`contract`.`contract_agreement`(`contract_agreement_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ADD CONSTRAINT `fk_contract_obligation_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm_v1`.`contract`.`contract_agreement`(`contract_agreement_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ADD CONSTRAINT `fk_contract_obligation_dependent_obligation_id` FOREIGN KEY (`dependent_obligation_id`) REFERENCES `legal_ecm_v1`.`contract`.`obligation`(`obligation_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ADD CONSTRAINT `fk_contract_obligation_event_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm_v1`.`contract`.`contract_agreement`(`contract_agreement_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ADD CONSTRAINT `fk_contract_obligation_event_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `legal_ecm_v1`.`contract`.`obligation`(`obligation_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`milestone` ADD CONSTRAINT `fk_contract_milestone_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm_v1`.`contract`.`contract_agreement`(`contract_agreement_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm_v1`.`contract`.`contract_agreement`(`contract_agreement_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm_v1`.`contract`.`contract_agreement`(`contract_agreement_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_parent_amendment_id` FOREIGN KEY (`parent_amendment_id`) REFERENCES `legal_ecm_v1`.`contract`.`amendment`(`amendment_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_primary_superseded_by_amendment_id` FOREIGN KEY (`primary_superseded_by_amendment_id`) REFERENCES `legal_ecm_v1`.`contract`.`amendment`(`amendment_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ADD CONSTRAINT `fk_contract_negotiation_round_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm_v1`.`contract`.`contract_agreement`(`contract_agreement_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ADD CONSTRAINT `fk_contract_execution_record_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm_v1`.`contract`.`contract_agreement`(`contract_agreement_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ADD CONSTRAINT `fk_contract_termination_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm_v1`.`contract`.`contract_agreement`(`contract_agreement_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ADD CONSTRAINT `fk_contract_clause_library_superseded_by_clause_clause_library_id` FOREIGN KEY (`superseded_by_clause_clause_library_id`) REFERENCES `legal_ecm_v1`.`contract`.`clause_library`(`clause_library_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ADD CONSTRAINT `fk_contract_clause_deviation_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm_v1`.`contract`.`contract_agreement`(`contract_agreement_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ADD CONSTRAINT `fk_contract_clause_deviation_clause_library_id` FOREIGN KEY (`clause_library_id`) REFERENCES `legal_ecm_v1`.`contract`.`clause_library`(`clause_library_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ADD CONSTRAINT `fk_contract_afa_arrangement_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm_v1`.`contract`.`contract_agreement`(`contract_agreement_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type_clause_policy` ADD CONSTRAINT `fk_contract_agreement_type_clause_policy_agreement_type_id` FOREIGN KEY (`agreement_type_id`) REFERENCES `legal_ecm_v1`.`contract`.`agreement_type`(`agreement_type_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type_clause_policy` ADD CONSTRAINT `fk_contract_agreement_type_clause_policy_clause_library_id` FOREIGN KEY (`clause_library_id`) REFERENCES `legal_ecm_v1`.`contract`.`clause_library`(`clause_library_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`template_clause` ADD CONSTRAINT `fk_contract_template_clause_clause_library_id` FOREIGN KEY (`clause_library_id`) REFERENCES `legal_ecm_v1`.`contract`.`clause_library`(`clause_library_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`template_clause` ADD CONSTRAINT `fk_contract_template_clause_template_id` FOREIGN KEY (`template_id`) REFERENCES `legal_ecm_v1`.`contract`.`template`(`template_id`);

-- ========= TAGS =========
ALTER SCHEMA `legal_ecm_v1`.`contract` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `legal_ecm_v1`.`contract` SET TAGS ('dbx_domain' = 'contract');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `contract_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement ID');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `agreement_type_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Partner ID');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `check_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `clause_id` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Clause Library Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `docket_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `engagement_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Opportunity Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `letter_of_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Letter Of Engagement Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `parent_agreement_contract_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Agreement ID');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `practice_group_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Group Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `precedent_id` SET TAGS ('dbx_business_glossary_term' = 'Precedent Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `pricing_model_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `template_id` SET TAGS ('dbx_business_glossary_term' = 'Template ID');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `aml_kyc_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Know Your Client (KYC) Verified Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'Pending Approval|Approved|Rejected|Conditional Approval');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `confidentiality_classification` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Classification');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `confidentiality_classification` SET TAGS ('dbx_value_regex' = 'Public|Internal|Confidential|Restricted|Highly Restricted');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `conflict_check_cleared_flag` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Cleared Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `contract_value` SET TAGS ('dbx_business_glossary_term' = 'Contract Value');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `contract_value` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `counterparty_name` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Name');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `counterparty_name` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `counterparty_type` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Type');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `document_storage_path` SET TAGS ('dbx_business_glossary_term' = 'Document Storage Path');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `gdpr_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Compliant Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `indemnity_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Indemnity Clause Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `limitation_of_liability_flag` SET TAGS ('dbx_business_glossary_term' = 'Limitation of Liability Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `lpp_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Professional Privilege (LPP) Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `originating_office` SET TAGS ('dbx_business_glossary_term' = 'Originating Office');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Agreement Title');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type` ALTER COLUMN `agreement_type_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type` ALTER COLUMN `pricing_model_id` SET TAGS ('dbx_business_glossary_term' = 'Default Pricing Model Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type` ALTER COLUMN `agreement_type_category` SET TAGS ('dbx_business_glossary_term' = 'Agreement Category');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type` ALTER COLUMN `agreement_type_category` SET TAGS ('dbx_value_regex' = 'client_engagement|vendor_supplier|internal_administrative|regulatory_compliance|intellectual_property|dispute_resolution');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type` ALTER COLUMN `aml_kyc_required` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) and Know Your Client (KYC) Required Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type` ALTER COLUMN `approval_workflow_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow Required Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|highly_confidential|attorney_client_privileged');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type` ALTER COLUMN `conflict_check_required` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Required Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type` ALTER COLUMN `default_dispute_resolution` SET TAGS ('dbx_business_glossary_term' = 'Default Dispute Resolution Method');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type` ALTER COLUMN `default_dispute_resolution` SET TAGS ('dbx_value_regex' = 'litigation|arbitration|mediation|negotiation');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type` ALTER COLUMN `default_governing_law` SET TAGS ('dbx_business_glossary_term' = 'Default Governing Law Jurisdiction');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type` ALTER COLUMN `default_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Default Notice Period in Days');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type` ALTER COLUMN `default_term_months` SET TAGS ('dbx_business_glossary_term' = 'Default Term in Months');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type` ALTER COLUMN `electronic_signature_allowed` SET TAGS ('dbx_business_glossary_term' = 'Electronic Signature Allowed Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type` ALTER COLUMN `financial_threshold_usd` SET TAGS ('dbx_business_glossary_term' = 'Financial Threshold in United States Dollars (USD)');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type` ALTER COLUMN `frand_applicable` SET TAGS ('dbx_business_glossary_term' = 'Fair Reasonable and Non-Discriminatory (FRAND) Applicable Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type` ALTER COLUMN `gdpr_applicable` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Applicable Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Status Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type` ALTER COLUMN `ledes_billing_code` SET TAGS ('dbx_business_glossary_term' = 'Legal Electronic Data Exchange Standard (LEDES) Billing Code');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type` ALTER COLUMN `ledes_billing_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type` ALTER COLUMN `milestone_tracking_required` SET TAGS ('dbx_business_glossary_term' = 'Milestone Tracking Required Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type` ALTER COLUMN `party_type` SET TAGS ('dbx_business_glossary_term' = 'Party Type');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type` ALTER COLUMN `party_type` SET TAGS ('dbx_value_regex' = 'bilateral|multilateral|unilateral');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type` ALTER COLUMN `requires_countersignature` SET TAGS ('dbx_business_glossary_term' = 'Requires Countersignature Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type` ALTER COLUMN `requires_notarization` SET TAGS ('dbx_business_glossary_term' = 'Requires Notarization Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period in Years');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type` ALTER COLUMN `sort_order` SET TAGS ('dbx_business_glossary_term' = 'Display Sort Order');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type` ALTER COLUMN `sox_applicable` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley Act (SOX) Applicable Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type` ALTER COLUMN `template_available` SET TAGS ('dbx_business_glossary_term' = 'Template Available Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type` ALTER COLUMN `type_code` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type Code');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type` ALTER COLUMN `type_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type` ALTER COLUMN `type_description` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type Description');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type` ALTER COLUMN `type_name` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type Name');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type` ALTER COLUMN `utbms_task_code` SET TAGS ('dbx_business_glossary_term' = 'Uniform Task-Based Management System (UTBMS) Task Code');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type` ALTER COLUMN `utbms_task_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{3}$');
ALTER TABLE `legal_ecm_v1`.`contract`.`template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ALTER COLUMN `template_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Template ID');
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ALTER COLUMN `agreement_type_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ALTER COLUMN `clause_id` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Clause Library Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ALTER COLUMN `practice_group_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Group Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ALTER COLUMN `precedent_id` SET TAGS ('dbx_business_glossary_term' = 'Precedent Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ALTER COLUMN `rfp_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Rfp Submission Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ALTER COLUMN `superseded_by_template_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Template ID');
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ALTER COLUMN `access_control_level` SET TAGS ('dbx_business_glossary_term' = 'Access Control Level');
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ALTER COLUMN `access_control_level` SET TAGS ('dbx_value_regex' = 'public|practice_group|partner_only|restricted');
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional');
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ALTER COLUMN `client_facing_flag` SET TAGS ('dbx_business_glossary_term' = 'Client Facing Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ALTER COLUMN `compliance_tags` SET TAGS ('dbx_business_glossary_term' = 'Compliance Tags');
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ALTER COLUMN `dms_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Management System (DMS) Document ID');
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ALTER COLUMN `dms_folder_path` SET TAGS ('dbx_business_glossary_term' = 'Document Management System (DMS) Folder Path');
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ALTER COLUMN `document_format` SET TAGS ('dbx_business_glossary_term' = 'Document Format');
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ALTER COLUMN `document_format` SET TAGS ('dbx_value_regex' = 'docx|pdf|rtf|odt|html');
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ALTER COLUMN `industry_sector` SET TAGS ('dbx_business_glossary_term' = 'Industry Sector');
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Keywords');
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ALTER COLUMN `language_locale` SET TAGS ('dbx_business_glossary_term' = 'Language Locale');
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ALTER COLUMN `mandatory_use_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Use Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ALTER COLUMN `optional_clauses_count` SET TAGS ('dbx_business_glossary_term' = 'Optional Clauses Count');
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Page Count');
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency Months');
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ALTER COLUMN `template_code` SET TAGS ('dbx_business_glossary_term' = 'Template Code');
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ALTER COLUMN `template_description` SET TAGS ('dbx_business_glossary_term' = 'Template Description');
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ALTER COLUMN `template_name` SET TAGS ('dbx_business_glossary_term' = 'Template Name');
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ALTER COLUMN `template_status` SET TAGS ('dbx_business_glossary_term' = 'Template Status');
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ALTER COLUMN `template_status` SET TAGS ('dbx_value_regex' = 'draft|active|deprecated|archived|under_review|suspended');
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ALTER COLUMN `usage_instructions` SET TAGS ('dbx_business_glossary_term' = 'Usage Instructions');
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ALTER COLUMN `variable_fields_count` SET TAGS ('dbx_business_glossary_term' = 'Variable Fields Count');
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ALTER COLUMN `word_count` SET TAGS ('dbx_business_glossary_term' = 'Word Count');
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `contract_party_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Party Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `conflict_party_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Party Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `contract_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `individual_id` SET TAGS ('dbx_business_glossary_term' = 'Individual Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `organisation_id` SET TAGS ('dbx_business_glossary_term' = 'Organisation Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Profile Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Party Address Line 1');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `address_line1` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `address_line1` SET TAGS ('dbx_dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Party Address Line 2');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `address_line2` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `address_line2` SET TAGS ('dbx_dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `authorized_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Authorized Signatory Name');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `authorized_signatory_name` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `authorized_signatory_name` SET TAGS ('dbx_dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Party City');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `city` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `city` SET TAGS ('dbx_dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `confidentiality_obligation_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Obligation Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Party Country Code');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Party Email Address');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `email` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `email` SET TAGS ('dbx_dbx_pii_email' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `execution_method` SET TAGS ('dbx_business_glossary_term' = 'Execution Method');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `execution_method` SET TAGS ('dbx_value_regex' = 'wet_signature|electronic_signature|digital_signature|seal|notarized');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `indemnity_obligation_flag` SET TAGS ('dbx_business_glossary_term' = 'Indemnity Obligation Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `is_client` SET TAGS ('dbx_business_glossary_term' = 'Is Client Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `is_firm_entity` SET TAGS ('dbx_business_glossary_term' = 'Is Firm Entity Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `is_opposing_counsel` SET TAGS ('dbx_business_glossary_term' = 'Is Opposing Counsel Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `is_vendor` SET TAGS ('dbx_business_glossary_term' = 'Is Vendor or Supplier Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `kyc_aml_clearance_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Client (KYC) and Anti-Money Laundering (AML) Clearance Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `kyc_aml_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Client (KYC) and Anti-Money Laundering (AML) Clearance Status');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `kyc_aml_clearance_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|failed|not_required|expired');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `liability_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Liability Cap Amount');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `liability_cap_amount` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `liability_cap_currency` SET TAGS ('dbx_business_glossary_term' = 'Liability Cap Currency Code');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `liability_cap_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `notary_commission_number` SET TAGS ('dbx_business_glossary_term' = 'Notary Commission Number');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `notary_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Notary Commission Expiration Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `notary_name` SET TAGS ('dbx_business_glossary_term' = 'Notary Public Name');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `parent_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Parent Entity Name');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `party_on_agreement` SET TAGS ('dbx_business_glossary_term' = 'Party On Agreement');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `party_role` SET TAGS ('dbx_business_glossary_term' = 'Party Role');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `party_role` SET TAGS ('dbx_value_regex' = 'offeror|offeree|guarantor|witness|notary|authorized_signatory');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `party_status` SET TAGS ('dbx_business_glossary_term' = 'Party Status');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `party_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|suspended|deceased');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `party_to_agreement` SET TAGS ('dbx_business_glossary_term' = 'Party To Agreement');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `party_type` SET TAGS ('dbx_business_glossary_term' = 'Party Type');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `party_type` SET TAGS ('dbx_value_regex' = 'individual|corporation|partnership|government|trust|non_profit');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `phone` SET TAGS ('dbx_business_glossary_term' = 'Party Phone Number');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `phone` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `phone` SET TAGS ('dbx_dbx_pii_phone' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Party Postal Code');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `postal_code` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `postal_code` SET TAGS ('dbx_dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Number or Tax Identifier');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `registration_number` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `sanctions_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Status');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_value_regex' = 'cleared|flagged|pending|not_screened');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `signatory_capacity` SET TAGS ('dbx_business_glossary_term' = 'Signatory Capacity');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `signatory_capacity` SET TAGS ('dbx_value_regex' = 'individual|corporate_officer|attorney_in_fact|trustee|executor|guardian');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `signatory_email` SET TAGS ('dbx_business_glossary_term' = 'Signatory Email Address');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `signatory_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `signatory_email` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `signatory_email` SET TAGS ('dbx_dbx_pii_email' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `signatory_phone` SET TAGS ('dbx_business_glossary_term' = 'Signatory Phone Number');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `signatory_phone` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `signatory_phone` SET TAGS ('dbx_dbx_pii_phone' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Signatory Title or Position');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `signature_location` SET TAGS ('dbx_business_glossary_term' = 'Signature Location');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'Party State or Province');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `state_province` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `state_province` SET TAGS ('dbx_dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `ultimate_beneficial_owner` SET TAGS ('dbx_business_glossary_term' = 'Ultimate Beneficial Owner (UBO)');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `ultimate_beneficial_owner` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `ultimate_beneficial_owner` SET TAGS ('dbx_dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Identifier');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `check_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `contract_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `dependent_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Dependent Obligation Identifier');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `ip_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Asset Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Intake Request Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Timekeeper Identifier');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `beneficiary_party_name` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Party Name');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `beneficiary_party_name` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `breach_consequence` SET TAGS ('dbx_business_glossary_term' = 'Breach Consequence');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `breach_consequence` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `breach_notice_required` SET TAGS ('dbx_business_glossary_term' = 'Breach Notice Required Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `clause_reference` SET TAGS ('dbx_business_glossary_term' = 'Clause Reference');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `condition_precedent_flag` SET TAGS ('dbx_business_glossary_term' = 'Condition Precedent Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `cure_period_days` SET TAGS ('dbx_business_glossary_term' = 'Cure Period Days');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Obligation Due Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `escalation_threshold_days` SET TAGS ('dbx_business_glossary_term' = 'Escalation Threshold Days');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `from_agreement` SET TAGS ('dbx_business_glossary_term' = 'From Agreement');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `fulfillment_percentage` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Percentage');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Status');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Record Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `monetary_value` SET TAGS ('dbx_business_glossary_term' = 'Monetary Value');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `monetary_value` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Obligation Notes');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `obligation_category` SET TAGS ('dbx_business_glossary_term' = 'Obligation Category');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `obligation_category` SET TAGS ('dbx_value_regex' = 'payment|delivery|reporting|confidentiality|regulatory|ip_assignment');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `obligation_text` SET TAGS ('dbx_business_glossary_term' = 'Obligation Text');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `obligation_text` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Obligation Priority');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `recurrence_rule` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Rule');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `recurrence_schedule` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Schedule');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Obligation Reference Number');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `regulatory_obligation_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `responsible_party_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Name');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `responsible_party_name` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `responsible_party_type` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Type');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `responsible_party_type` SET TAGS ('dbx_value_regex' = 'client|firm|third_party|joint');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Obligation Subcategory');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `to_agreement` SET TAGS ('dbx_business_glossary_term' = 'To Agreement');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Record Version Number');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `waiver_authority` SET TAGS ('dbx_business_glossary_term' = 'Waiver Authority');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `waiver_authority` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `waiver_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ALTER COLUMN `obligation_event_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Event ID');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ALTER COLUMN `contract_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Actor ID');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Document ID');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ALTER COLUMN `obligation_actor_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Actor Timekeeper Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation ID');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ALTER COLUMN `actor_type` SET TAGS ('dbx_business_glossary_term' = 'Actor Type');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ALTER COLUMN `actor_type` SET TAGS ('dbx_value_regex' = 'attorney|client|counterparty|system|third_party');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ALTER COLUMN `breach_notice_date` SET TAGS ('dbx_business_glossary_term' = 'Breach Notice Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ALTER COLUMN `breach_severity` SET TAGS ('dbx_business_glossary_term' = 'Breach Severity');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ALTER COLUMN `breach_severity` SET TAGS ('dbx_value_regex' = 'minor|moderate|major|critical');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completion Percentage');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ALTER COLUMN `cure_deadline` SET TAGS ('dbx_business_glossary_term' = 'Cure Deadline');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'none|team_lead|partner|general_counsel|executive');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ALTER COLUMN `event_description` SET TAGS ('dbx_business_glossary_term' = 'Event Description');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|disputed|resolved|cancelled');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'created|fulfilled|partially_completed|breached|cured|waived');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ALTER COLUMN `financial_impact_currency` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Currency');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ALTER COLUMN `financial_impact_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ALTER COLUMN `notification_recipient_list` SET TAGS ('dbx_business_glossary_term' = 'Notification Recipient List');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ALTER COLUMN `notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Timestamp');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ALTER COLUMN `prior_obligation_status` SET TAGS ('dbx_business_glossary_term' = 'Prior Obligation Status');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ALTER COLUMN `prior_obligation_status` SET TAGS ('dbx_value_regex' = 'pending|active|fulfilled|breached|waived|expired');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ALTER COLUMN `resulting_obligation_status` SET TAGS ('dbx_business_glossary_term' = 'Resulting Obligation Status');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ALTER COLUMN `resulting_obligation_status` SET TAGS ('dbx_value_regex' = 'pending|active|fulfilled|breached|waived|expired');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ALTER COLUMN `source_system_event_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Event ID');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ALTER COLUMN `waiver_authority` SET TAGS ('dbx_business_glossary_term' = 'Waiver Authority');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `legal_ecm_v1`.`contract`.`milestone` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`contract`.`milestone` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Milestone Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`contract`.`milestone` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Attorney Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`contract`.`milestone` ALTER COLUMN `contract_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`contract`.`milestone` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Document Reference Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`contract`.`milestone` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`milestone` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`contract`.`milestone` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`contract`.`milestone` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Completed By User Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`contract`.`milestone` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`milestone` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`milestone` ALTER COLUMN `actual_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Milestone Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`milestone` ALTER COLUMN `alert_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Alert Lead Time (Days)');
ALTER TABLE `legal_ecm_v1`.`contract`.`milestone` ALTER COLUMN `completion_notes` SET TAGS ('dbx_business_glossary_term' = 'Completion Notes');
ALTER TABLE `legal_ecm_v1`.`contract`.`milestone` ALTER COLUMN `contractual_clause_reference` SET TAGS ('dbx_business_glossary_term' = 'Contractual Clause Reference');
ALTER TABLE `legal_ecm_v1`.`contract`.`milestone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`contract`.`milestone` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm_v1`.`contract`.`milestone` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`contract`.`milestone` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`milestone` ALTER COLUMN `escalation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`milestone` ALTER COLUMN `external_system_reference` SET TAGS ('dbx_business_glossary_term' = 'External System Reference');
ALTER TABLE `legal_ecm_v1`.`contract`.`milestone` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `legal_ecm_v1`.`contract`.`milestone` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`milestone` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Status Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`milestone` ALTER COLUMN `is_critical_path_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`milestone` ALTER COLUMN `is_regulatory_milestone_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Milestone Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`milestone` ALTER COLUMN `milestone_description` SET TAGS ('dbx_business_glossary_term' = 'Milestone Description');
ALTER TABLE `legal_ecm_v1`.`contract`.`milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_business_glossary_term' = 'Milestone Name');
ALTER TABLE `legal_ecm_v1`.`contract`.`milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_business_glossary_term' = 'Milestone Status');
ALTER TABLE `legal_ecm_v1`.`contract`.`milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_business_glossary_term' = 'Milestone Type');
ALTER TABLE `legal_ecm_v1`.`contract`.`milestone` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`contract`.`milestone` ALTER COLUMN `next_occurrence_date` SET TAGS ('dbx_business_glossary_term' = 'Next Occurrence Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`milestone` ALTER COLUMN `notification_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Timestamp');
ALTER TABLE `legal_ecm_v1`.`contract`.`milestone` ALTER COLUMN `notification_triggered_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Triggered Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`milestone` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `legal_ecm_v1`.`contract`.`milestone` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `legal_ecm_v1`.`contract`.`milestone` ALTER COLUMN `recurrence_pattern` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Pattern');
ALTER TABLE `legal_ecm_v1`.`contract`.`milestone` ALTER COLUMN `recurrence_pattern` SET TAGS ('dbx_value_regex' = 'one_time|annual|semi_annual|quarterly|monthly|custom');
ALTER TABLE `legal_ecm_v1`.`contract`.`milestone` ALTER COLUMN `responsible_party_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Name');
ALTER TABLE `legal_ecm_v1`.`contract`.`milestone` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Milestone Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`renewal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`contract`.`renewal` ALTER COLUMN `renewal_id` SET TAGS ('dbx_business_glossary_term' = 'Renewal Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`contract`.`renewal` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Partner Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`contract`.`renewal` ALTER COLUMN `precedent_id` SET TAGS ('dbx_business_glossary_term' = 'Precedent Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`renewal` ALTER COLUMN `contract_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`contract`.`renewal` ALTER COLUMN `auto_renew_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renew Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`renewal` ALTER COLUMN `client_approval_received_date` SET TAGS ('dbx_business_glossary_term' = 'Client Approval Received Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`renewal` ALTER COLUMN `client_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Client Approval Required');
ALTER TABLE `legal_ecm_v1`.`contract`.`renewal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`contract`.`renewal` ALTER COLUMN `decision` SET TAGS ('dbx_business_glossary_term' = 'Renewal Decision');
ALTER TABLE `legal_ecm_v1`.`contract`.`renewal` ALTER COLUMN `decision` SET TAGS ('dbx_value_regex' = 'renew|terminate|renegotiate|pending');
ALTER TABLE `legal_ecm_v1`.`contract`.`renewal` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Decision Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`renewal` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Effective Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`renewal` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Expiration Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`renewal` ALTER COLUMN `fee_adjustment_percentage` SET TAGS ('dbx_business_glossary_term' = 'Fee Adjustment Percentage');
ALTER TABLE `legal_ecm_v1`.`contract`.`renewal` ALTER COLUMN `fee_adjustment_percentage` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`renewal` ALTER COLUMN `fee_adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Fee Adjustment Reason');
ALTER TABLE `legal_ecm_v1`.`contract`.`renewal` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Renewal Fee Amount');
ALTER TABLE `legal_ecm_v1`.`contract`.`renewal` ALTER COLUMN `fee_amount` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`renewal` ALTER COLUMN `fee_arrangement_type` SET TAGS ('dbx_business_glossary_term' = 'Renewal Fee Arrangement Type (Alternative Fee Arrangement - AFA)');
ALTER TABLE `legal_ecm_v1`.`contract`.`renewal` ALTER COLUMN `fee_arrangement_type` SET TAGS ('dbx_value_regex' = 'hourly|fixed_fee|capped_fee|contingency|blended_rate|afa_other');
ALTER TABLE `legal_ecm_v1`.`contract`.`renewal` ALTER COLUMN `fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Renewal Fee Currency');
ALTER TABLE `legal_ecm_v1`.`contract`.`renewal` ALTER COLUMN `fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`contract`.`renewal` ALTER COLUMN `initiated_by` SET TAGS ('dbx_business_glossary_term' = 'Renewal Initiated By');
ALTER TABLE `legal_ecm_v1`.`contract`.`renewal` ALTER COLUMN `initiated_by` SET TAGS ('dbx_value_regex' = 'client|firm|auto_trigger');
ALTER TABLE `legal_ecm_v1`.`contract`.`renewal` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notes');
ALTER TABLE `legal_ecm_v1`.`contract`.`renewal` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period Days');
ALTER TABLE `legal_ecm_v1`.`contract`.`renewal` ALTER COLUMN `notice_to_cancel_deadline` SET TAGS ('dbx_business_glossary_term' = 'Notice to Cancel Deadline');
ALTER TABLE `legal_ecm_v1`.`contract`.`renewal` ALTER COLUMN `notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notification Sent Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`renewal` ALTER COLUMN `of_agreement` SET TAGS ('dbx_business_glossary_term' = 'Of Agreement');
ALTER TABLE `legal_ecm_v1`.`contract`.`renewal` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Renewal Priority');
ALTER TABLE `legal_ecm_v1`.`contract`.`renewal` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `legal_ecm_v1`.`contract`.`renewal` ALTER COLUMN `renewal_number` SET TAGS ('dbx_business_glossary_term' = 'Renewal Number');
ALTER TABLE `legal_ecm_v1`.`contract`.`renewal` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status');
ALTER TABLE `legal_ecm_v1`.`contract`.`renewal` ALTER COLUMN `renewal_status` SET TAGS ('dbx_value_regex' = 'pending|under_review|approved|declined|executed|cancelled');
ALTER TABLE `legal_ecm_v1`.`contract`.`renewal` ALTER COLUMN `renewal_type` SET TAGS ('dbx_business_glossary_term' = 'Renewal Type');
ALTER TABLE `legal_ecm_v1`.`contract`.`renewal` ALTER COLUMN `renewal_type` SET TAGS ('dbx_value_regex' = 'auto_renew|opt_in|renegotiate|extend|terminate');
ALTER TABLE `legal_ecm_v1`.`contract`.`renewal` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Renewal Risk Level');
ALTER TABLE `legal_ecm_v1`.`contract`.`renewal` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `legal_ecm_v1`.`contract`.`renewal` ALTER COLUMN `term_length` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term Length');
ALTER TABLE `legal_ecm_v1`.`contract`.`renewal` ALTER COLUMN `term_unit` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term Unit');
ALTER TABLE `legal_ecm_v1`.`contract`.`renewal` ALTER COLUMN `term_unit` SET TAGS ('dbx_value_regex' = 'month|year|quarter');
ALTER TABLE `legal_ecm_v1`.`contract`.`renewal` ALTER COLUMN `to_agreement` SET TAGS ('dbx_business_glossary_term' = 'To Agreement');
ALTER TABLE `legal_ecm_v1`.`contract`.`renewal` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Amendment Identifier');
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ALTER COLUMN `check_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Identifier');
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ALTER COLUMN `contract_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Identifier');
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ALTER COLUMN `dpia_id` SET TAGS ('dbx_business_glossary_term' = 'Dpia Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ALTER COLUMN `engagement_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Opportunity Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier');
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ALTER COLUMN `parent_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Amendment Identifier');
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ALTER COLUMN `precedent_id` SET TAGS ('dbx_business_glossary_term' = 'Precedent Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Timekeeper Identifier');
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Clean Document Identifier');
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ALTER COLUMN `primary_superseded_by_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Amendment Identifier');
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier');
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ALTER COLUMN `amendment_description` SET TAGS ('dbx_business_glossary_term' = 'Amendment Description');
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_business_glossary_term' = 'Amendment Type');
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_value_regex' = 'amendment|addendum|side_letter|variation|waiver|novation');
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ALTER COLUMN `clauses_modified` SET TAGS ('dbx_business_glossary_term' = 'Clauses Modified');
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'standard|highly_confidential|attorney_client_privileged|work_product');
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ALTER COLUMN `counterparty_name` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Name');
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ALTER COLUMN `counterparty_name` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ALTER COLUMN `counterparty_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Signatory Name');
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ALTER COLUMN `counterparty_signatory_name` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ALTER COLUMN `counterparty_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Signatory Title');
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Effective Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Execution Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ALTER COLUMN `execution_status` SET TAGS ('dbx_business_glossary_term' = 'Amendment Execution Status');
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ALTER COLUMN `financial_impact_currency` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Currency');
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ALTER COLUMN `financial_impact_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ALTER COLUMN `firm_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Firm Signatory Name');
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ALTER COLUMN `firm_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Firm Signatory Title');
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law');
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ALTER COLUMN `new_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'New Expiration Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Amendment Notes');
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period Days');
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ALTER COLUMN `retention_end_date` SET TAGS ('dbx_business_glossary_term' = 'Retention End Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ALTER COLUMN `term_extension_months` SET TAGS ('dbx_business_glossary_term' = 'Term Extension Months');
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Amendment Title');
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ALTER COLUMN `to_agreement` SET TAGS ('dbx_business_glossary_term' = 'To Agreement');
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Version Number');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `negotiation_round_id` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Round Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Negotiating Attorney Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `contract_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Document Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `negotiation_owner_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `negotiation_owner_timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `negotiation_owner_timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `research_memo_id` SET TAGS ('dbx_business_glossary_term' = 'Research Memo Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `agreed_issues_count` SET TAGS ('dbx_business_glossary_term' = 'Agreed Issues Count');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `client_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Client Approval Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `client_approval_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Client Approval Received Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `client_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Client Approval Required Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `communication_method` SET TAGS ('dbx_business_glossary_term' = 'Communication Method');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `communication_method` SET TAGS ('dbx_value_regex' = 'email|video_conference|phone|in_person|portal');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `counterparty_negotiator_email` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Negotiator Email Address');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `counterparty_negotiator_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `counterparty_negotiator_email` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `counterparty_negotiator_email` SET TAGS ('dbx_dbx_pii_email' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `counterparty_negotiator_name` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Negotiator Name');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `counterparty_negotiator_name` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `counterparty_organization_name` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Organization Name');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `cycle_time_days` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Cycle Time in Days');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `escalated_issues_count` SET TAGS ('dbx_business_glossary_term' = 'Escalated Issues Count');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `escalation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `external_system_reference` SET TAGS ('dbx_business_glossary_term' = 'External System Reference');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `internal_review_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Internal Review Duration in Hours');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Record Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `key_terms_summary` SET TAGS ('dbx_business_glossary_term' = 'Key Terms Summary');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `key_terms_summary` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `negotiation_for_agreement` SET TAGS ('dbx_business_glossary_term' = 'Negotiation For Agreement');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `negotiation_strategy` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Strategy');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `negotiation_strategy` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `negotiation_to_agreement` SET TAGS ('dbx_business_glossary_term' = 'Negotiation To Agreement');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `new_issues_count` SET TAGS ('dbx_business_glossary_term' = 'New Issues Count');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `open_issues_count` SET TAGS ('dbx_business_glossary_term' = 'Open Issues Count');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Priority Level');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|urgent');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `redline_version_reference` SET TAGS ('dbx_business_glossary_term' = 'Redline Version Reference');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `returned_date` SET TAGS ('dbx_business_glossary_term' = 'Round Returned Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `returned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Round Returned Timestamp');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Risk Level');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `round_notes` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Round Notes');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `round_notes` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `round_number` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Round Number');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `round_outcome` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Round Outcome');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `round_outcome` SET TAGS ('dbx_value_regex' = 'agreed|escalated|impasse|withdrawn|pending');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `round_status` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Round Status');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `sent_date` SET TAGS ('dbx_business_glossary_term' = 'Round Sent Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Round Sent Timestamp');
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `execution_record_id` SET TAGS ('dbx_business_glossary_term' = 'Execution Record Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Attorney Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `contract_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Executed Document Reference Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `sanctions_check_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Sanctions Screening Result Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `binding_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Binding Effective Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `board_resolution_reference` SET TAGS ('dbx_business_glossary_term' = 'Board Resolution Reference');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `counterparty_execution_date` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Execution Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `counterparty_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Signatory Name');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `counterparty_signatory_name` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `counterparty_signatory_name` SET TAGS ('dbx_dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `counterparty_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Signatory Title');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `electronic_signature_certificate_reference` SET TAGS ('dbx_business_glossary_term' = 'Electronic Signature Certificate Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `electronic_signature_platform` SET TAGS ('dbx_business_glossary_term' = 'Electronic Signature Platform');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `electronic_signature_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Electronic Signature Transaction Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `executed_document_version` SET TAGS ('dbx_business_glossary_term' = 'Executed Document Version');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `executing_party_name` SET TAGS ('dbx_business_glossary_term' = 'Executing Party Name');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `execution_location` SET TAGS ('dbx_business_glossary_term' = 'Execution Location');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `execution_method` SET TAGS ('dbx_business_glossary_term' = 'Execution Method');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `execution_method` SET TAGS ('dbx_value_regex' = 'wet_ink|electronic_signature|notarized|deed|counterpart|escrow');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `execution_notes` SET TAGS ('dbx_business_glossary_term' = 'Execution Notes');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `execution_of_agreement` SET TAGS ('dbx_business_glossary_term' = 'Execution Of Agreement');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `execution_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Execution Reference Number');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `execution_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Execution Sequence Number');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `execution_status` SET TAGS ('dbx_business_glossary_term' = 'Execution Status');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `execution_status` SET TAGS ('dbx_value_regex' = 'pending|partially_executed|fully_executed|voided|superseded');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Execution Timestamp');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `execution_to_agreement` SET TAGS ('dbx_business_glossary_term' = 'Execution To Agreement');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `execution_type` SET TAGS ('dbx_business_glossary_term' = 'Execution Type');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `execution_type` SET TAGS ('dbx_value_regex' = 'original|amendment|renewal|counterpart|duplicate');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `is_binding_flag` SET TAGS ('dbx_business_glossary_term' = 'Is Binding Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `is_original_execution_flag` SET TAGS ('dbx_business_glossary_term' = 'Is Original Execution Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `jurisdiction_of_execution` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction of Execution');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `notary_commission_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Notary Commission Expiry Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `notary_commission_number` SET TAGS ('dbx_business_glossary_term' = 'Notary Commission Number');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `notary_name` SET TAGS ('dbx_business_glossary_term' = 'Notary Public Name');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `notary_name` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `notary_name` SET TAGS ('dbx_dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `notary_seal_affixed_flag` SET TAGS ('dbx_business_glossary_term' = 'Notary Seal Affixed Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `power_of_attorney_reference` SET TAGS ('dbx_business_glossary_term' = 'Power of Attorney (POA) Reference');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `signatory_capacity` SET TAGS ('dbx_business_glossary_term' = 'Signatory Capacity');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Signatory Name');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `signatory_name` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `signatory_name` SET TAGS ('dbx_dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Signatory Title');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `witness_address` SET TAGS ('dbx_business_glossary_term' = 'Witness Address');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `witness_address` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `witness_address` SET TAGS ('dbx_dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `witness_name` SET TAGS ('dbx_business_glossary_term' = 'Witness Name');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `witness_name` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ALTER COLUMN `witness_name` SET TAGS ('dbx_dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `termination_id` SET TAGS ('dbx_business_glossary_term' = 'Termination ID');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Attorney ID');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `check_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `client_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Terminating Party Contact ID');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `contract_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `docket_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Document Reference ID');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `regulatory_breach_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Breach Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `contractual_clause_reference` SET TAGS ('dbx_business_glossary_term' = 'Contractual Clause Reference');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `dispute_description` SET TAGS ('dbx_business_glossary_term' = 'Dispute Description');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_value_regex' = 'negotiation|mediation|arbitration|litigation|none');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `effective_termination_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Termination Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `external_system_reference` SET TAGS ('dbx_business_glossary_term' = 'External System Reference');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `grounds_for_termination` SET TAGS ('dbx_business_glossary_term' = 'Grounds for Termination');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `notice_date` SET TAGS ('dbx_business_glossary_term' = 'Notice Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period Days');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `of_agreement` SET TAGS ('dbx_business_glossary_term' = 'Of Agreement');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `post_termination_obligations` SET TAGS ('dbx_business_glossary_term' = 'Post-Termination Obligations');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `refund_amount` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `regulatory_report_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `settlement_reached_flag` SET TAGS ('dbx_business_glossary_term' = 'Settlement Reached Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `settlement_terms` SET TAGS ('dbx_business_glossary_term' = 'Settlement Terms');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `settlement_terms` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `surviving_clauses` SET TAGS ('dbx_business_glossary_term' = 'Surviving Clauses');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `terminating_party_name` SET TAGS ('dbx_business_glossary_term' = 'Terminating Party Name');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `terminating_party_type` SET TAGS ('dbx_business_glossary_term' = 'Terminating Party Type');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `terminating_party_type` SET TAGS ('dbx_value_regex' = 'client|firm|vendor|mutual|third_party');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `termination_status` SET TAGS ('dbx_business_glossary_term' = 'Termination Status');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `termination_status` SET TAGS ('dbx_value_regex' = 'pending|effective|disputed|settled|withdrawn');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `termination_type` SET TAGS ('dbx_business_glossary_term' = 'Termination Type');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `termination_type` SET TAGS ('dbx_value_regex' = 'expiry|termination_for_convenience|termination_for_cause|mutual_rescission|frustration|breach');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `to_agreement` SET TAGS ('dbx_business_glossary_term' = 'To Agreement');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `wind_down_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Wind-Down Completion Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ALTER COLUMN `wind_down_period_days` SET TAGS ('dbx_business_glossary_term' = 'Wind-Down Period Days');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `clause_library_id` SET TAGS ('dbx_business_glossary_term' = 'Clause Library Identifier');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `clause_id` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Clause Library Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `clause_owner_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `clause_owner_timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `clause_owner_timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `practice_group_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Group Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Group Owner ID');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `superseded_by_clause_clause_library_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Clause ID');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `aml_kyc_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Know Your Client (KYC) Required Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `approved_text` SET TAGS ('dbx_business_glossary_term' = 'Approved Clause Text');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `approved_text` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `clause_category` SET TAGS ('dbx_business_glossary_term' = 'Clause Category');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `clause_category` SET TAGS ('dbx_value_regex' = 'risk_allocation|compliance|operational|commercial|dispute_resolution|termination');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `clause_library_description` SET TAGS ('dbx_business_glossary_term' = 'Clause Description');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `clause_library_status` SET TAGS ('dbx_business_glossary_term' = 'Clause Status');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `clause_library_status` SET TAGS ('dbx_value_regex' = 'active|under_review|deprecated|archived|draft');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `clause_type` SET TAGS ('dbx_business_glossary_term' = 'Clause Type');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `clause_type` SET TAGS ('dbx_value_regex' = 'indemnity|limitation_of_liability|governing_law|force_majeure|ip_assignment|confidentiality');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `external_source_reference` SET TAGS ('dbx_business_glossary_term' = 'External Source Reference');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `fallback_text` SET TAGS ('dbx_business_glossary_term' = 'Fallback Clause Text');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `fallback_text` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `frand_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Fair Reasonable and Non-Discriminatory (FRAND) Applicable Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `gdpr_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Compliant Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `jurisdiction_applicability` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Applicability');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Keywords');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}(-[A-Z]{2})?$');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `last_used_date` SET TAGS ('dbx_business_glossary_term' = 'Last Used Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `negotiation_notes` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Notes');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `negotiation_notes` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `related_clause_ids` SET TAGS ('dbx_business_glossary_term' = 'Related Clause IDs');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `sox_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley Act (SOX) Compliant Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `template_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Template Integration Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `usage_guidance` SET TAGS ('dbx_business_glossary_term' = 'Usage Guidance');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `usage_tier` SET TAGS ('dbx_business_glossary_term' = 'Usage Tier');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `usage_tier` SET TAGS ('dbx_value_regex' = 'mandatory|preferred|fallback|optional|deprecated');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ALTER COLUMN `word_count` SET TAGS ('dbx_business_glossary_term' = 'Word Count');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `clause_deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Clause Deviation Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `clause_id` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Clause Library Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `contract_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `deviation_owner_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `deviation_owner_timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `deviation_owner_timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Document Reference Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `precedent_id` SET TAGS ('dbx_business_glossary_term' = 'Precedent Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Partner Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `clause_library_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Clause Library Id');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `regulatory_breach_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Breach Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `approved_position` SET TAGS ('dbx_business_glossary_term' = 'Approved Clause Position');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `approved_position` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `approving_partner_name` SET TAGS ('dbx_business_glossary_term' = 'Approving Partner Name');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `clause_section_reference` SET TAGS ('dbx_business_glossary_term' = 'Clause Section Reference');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `clause_type_code` SET TAGS ('dbx_business_glossary_term' = 'Clause Type Code');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `clause_type_name` SET TAGS ('dbx_business_glossary_term' = 'Clause Type Name');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `counterparty_name` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Name');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `deviation_category` SET TAGS ('dbx_business_glossary_term' = 'Deviation Category');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `deviation_category` SET TAGS ('dbx_value_regex' = 'material|non_material|technical|substantive');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `deviation_in_agreement` SET TAGS ('dbx_business_glossary_term' = 'Deviation In Agreement');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `deviation_rationale` SET TAGS ('dbx_business_glossary_term' = 'Deviation Rationale');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `deviation_summary` SET TAGS ('dbx_business_glossary_term' = 'Deviation Summary');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `deviation_to_agreement` SET TAGS ('dbx_business_glossary_term' = 'Deviation To Agreement');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `escalation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `external_counsel_involved_flag` SET TAGS ('dbx_business_glossary_term' = 'External Counsel Involved Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `external_counsel_name` SET TAGS ('dbx_business_glossary_term' = 'External Counsel Name');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `indemnity_exposure_amount` SET TAGS ('dbx_business_glossary_term' = 'Indemnity Exposure Amount');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `indemnity_exposure_amount` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `lessons_learned` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `negotiated_position` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Clause Position');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `negotiated_position` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `negotiating_attorney_name` SET TAGS ('dbx_business_glossary_term' = 'Negotiating Attorney Name');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `playbook_update_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Playbook Update Required Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `playbook_update_status` SET TAGS ('dbx_business_glossary_term' = 'Playbook Update Status');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `playbook_update_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|completed');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `precedent_flag` SET TAGS ('dbx_business_glossary_term' = 'Precedent Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `professional_indemnity_exposure_flag` SET TAGS ('dbx_business_glossary_term' = 'Professional Indemnity (PI) Exposure Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `regulatory_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Impact Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'pending_review|under_review|approved|rejected|escalated');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `afa_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Alternative Fee Arrangement (AFA) Arrangement ID');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `check_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `contract_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `docket_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `indemnity_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Indemnity Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `intake_fee_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Intake Fee Arrangement Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `letter_of_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Letter Of Engagement Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Attorney ID');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `precedent_id` SET TAGS ('dbx_business_glossary_term' = 'Precedent Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `pricing_model_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `primary_afa_attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Partner ID');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `actual_hours_to_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Hours To Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `afa_in_agreement` SET TAGS ('dbx_business_glossary_term' = 'Afa In Agreement');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `afa_to_agreement` SET TAGS ('dbx_business_glossary_term' = 'Afa To Agreement');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `agreed_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Agreed Fee Amount');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `arrangement_name` SET TAGS ('dbx_business_glossary_term' = 'Alternative Fee Arrangement (AFA) Name');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `arrangement_number` SET TAGS ('dbx_business_glossary_term' = 'Alternative Fee Arrangement (AFA) Number');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `arrangement_status` SET TAGS ('dbx_business_glossary_term' = 'Alternative Fee Arrangement (AFA) Status');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `blended_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Blended Rate Amount');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `budget_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Cap Amount');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `collected_amount_to_date` SET TAGS ('dbx_business_glossary_term' = 'Collected Amount To Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `contingency_percentage` SET TAGS ('dbx_business_glossary_term' = 'Contingency Fee Percentage');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `disbursement_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Cap Amount');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `disbursement_handling` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Handling');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `disbursement_handling` SET TAGS ('dbx_value_regex' = 'included_in_fee|billed_separately_at_cost|billed_separately_with_markup|capped|excluded');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `estimated_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Hours');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `invoiced_amount_to_date` SET TAGS ('dbx_business_glossary_term' = 'Invoiced Amount To Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `ledes_billing_code` SET TAGS ('dbx_business_glossary_term' = 'Legal Electronic Data Exchange Standard (LEDES) Billing Code');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Arrangement Notes');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `overage_handling_method` SET TAGS ('dbx_business_glossary_term' = 'Overage Handling Method');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `overage_handling_method` SET TAGS ('dbx_value_regex' = 'no_overage|client_approval_required|automatic_billing|write_off|renegotiate');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `overage_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Overage Rate Amount');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `performance_metrics` SET TAGS ('dbx_business_glossary_term' = 'Performance Metrics');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `renewal_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period Days');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `risk_allocation_notes` SET TAGS ('dbx_business_glossary_term' = 'Risk Allocation Notes');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `scope_of_services` SET TAGS ('dbx_business_glossary_term' = 'Scope of Services');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `success_fee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Success Fee Percentage');
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ALTER COLUMN `utbms_task_code` SET TAGS ('dbx_business_glossary_term' = 'Uniform Task-Based Management System (UTBMS) Task Code');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type_clause_policy` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type_clause_policy` ALTER COLUMN `agreement_type_clause_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type Clause Policy - Agreement Type Clause Policy Id');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type_clause_policy` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Attorney Profile ID');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type_clause_policy` ALTER COLUMN `agreement_last_modified_by_attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By Attorney Profile ID');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type_clause_policy` ALTER COLUMN `agreement_type_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type Clause Policy - Agreement Type Id');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type_clause_policy` ALTER COLUMN `clause_library_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type Clause Policy - Contract Clause Library Id');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type_clause_policy` ALTER COLUMN `clause_id` SET TAGS ('dbx_business_glossary_term' = 'Fallback Clause ID');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type_clause_policy` ALTER COLUMN `agreement_type_clause_policy_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type_clause_policy` ALTER COLUMN `approval_authority_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority Required');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type_clause_policy` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type_clause_policy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type_clause_policy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type_clause_policy` ALTER COLUMN `is_default_flag` SET TAGS ('dbx_business_glossary_term' = 'Is Default Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type_clause_policy` ALTER COLUMN `is_mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type_clause_policy` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type_clause_policy` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type_clause_policy` ALTER COLUMN `negotiation_flexibility_level` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Flexibility Level');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type_clause_policy` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type_clause_policy` ALTER COLUMN `policy_rationale` SET TAGS ('dbx_business_glossary_term' = 'Policy Rationale');
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type_clause_policy` ALTER COLUMN `usage_tier` SET TAGS ('dbx_business_glossary_term' = 'Usage Tier');
ALTER TABLE `legal_ecm_v1`.`contract`.`template_clause` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `legal_ecm_v1`.`contract`.`template_clause` ALTER COLUMN `template_clause_id` SET TAGS ('dbx_business_glossary_term' = 'Template Clause Identifier');
ALTER TABLE `legal_ecm_v1`.`contract`.`template_clause` ALTER COLUMN `clause_library_id` SET TAGS ('dbx_business_glossary_term' = 'Template Clause - Contract Clause Library Id');
ALTER TABLE `legal_ecm_v1`.`contract`.`template_clause` ALTER COLUMN `template_id` SET TAGS ('dbx_business_glossary_term' = 'Template Clause - Contract Template Id');
ALTER TABLE `legal_ecm_v1`.`contract`.`template_clause` ALTER COLUMN `approved_by_attorney` SET TAGS ('dbx_business_glossary_term' = 'Approved By Attorney');
ALTER TABLE `legal_ecm_v1`.`contract`.`template_clause` ALTER COLUMN `clause_library_references` SET TAGS ('dbx_business_glossary_term' = 'Clause Library References');
ALTER TABLE `legal_ecm_v1`.`contract`.`template_clause` ALTER COLUMN `clause_sequence_order` SET TAGS ('dbx_business_glossary_term' = 'Clause Sequence Order');
ALTER TABLE `legal_ecm_v1`.`contract`.`template_clause` ALTER COLUMN `customization_notes` SET TAGS ('dbx_business_glossary_term' = 'Customization Notes');
ALTER TABLE `legal_ecm_v1`.`contract`.`template_clause` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`template_clause` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`template_clause` ALTER COLUMN `inclusion_date` SET TAGS ('dbx_business_glossary_term' = 'Clause Inclusion Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`template_clause` ALTER COLUMN `is_mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Clause Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`template_clause` ALTER COLUMN `is_optional_flag` SET TAGS ('dbx_business_glossary_term' = 'Optional Clause Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`template_clause` ALTER COLUMN `jurisdiction_specific_flag` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Specific Flag');
ALTER TABLE `legal_ecm_v1`.`contract`.`template_clause` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `legal_ecm_v1`.`contract`.`template_clause` ALTER COLUMN `usage_tier_override` SET TAGS ('dbx_business_glossary_term' = 'Usage Tier Override');
