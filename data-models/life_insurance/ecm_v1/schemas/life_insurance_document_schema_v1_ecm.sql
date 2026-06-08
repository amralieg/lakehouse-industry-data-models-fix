-- Schema for Domain: document | Business: Life Insurance | Version: v1_ecm
-- Generated on: 2026-05-04 03:46:13

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `life_insurance_ecm`.`document` COMMENT 'Manages the full lifecycle of insurance documents — policy contracts, illustrations, applications, APS records, beneficiary change forms, endorsements, rider documents, regulatory filings, claim correspondence, and disclosure documents. Owns document metadata, version control, e-delivery consent, NIGO tracking for incomplete applications, document imaging, retention schedules aligned with state DOI requirements, and ACORD forms management.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `life_insurance_ecm`.`document`.`document` (
    `document_id` BIGINT COMMENT 'Primary key for document',
    `acord_form_id` BIGINT COMMENT 'Foreign key linking to document.acord_form. Business justification: Document currently has acord_form_number (STRING) which should be normalized to FK to acord_form reference table. Many documents can reference one ACORD form (N:1). Classic normalization pattern - rem',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to investment.counterparty. Business justification: Counterparties require ISDA master agreements, KYC documentation, credit agreements, W-8/W-9 tax forms, AML verification, and custodial agreements. Critical for counterparty onboarding, regulatory com',
    `document_type_id` BIGINT COMMENT 'Foreign key linking to document.document_type. Business justification: Document has type_code (STRING) attribute but no FK to the document_type reference table. This is a missing normalization. The document_type table exists with document_type_id PK and contains code, na',
    `portfolio_id` BIGINT COMMENT 'Foreign key linking to investment.portfolio. Business justification: Investment portfolios generate regulatory filings (Schedule D, annual statements), investment policy statements, ALM committee reports, and compliance documentation required for NAIC reporting and inv',
    `producer_id` BIGINT COMMENT 'Reference to the agent or producer who submitted or is associated with this document. Relevant for applications, illustrations, and agent correspondence.',
    `retention_schedule_id` BIGINT COMMENT 'Foreign key linking to document.retention_schedule. Business justification: Documents should link to their governing retention schedule. The retention_schedule table defines retention rules by document_type_code and jurisdiction. Many documents follow one retention schedule (',
    `template_id` BIGINT COMMENT 'Foreign key linking to document.document_template. Business justification: Documents are generated from templates. A policy contract document is created from a policy_contract_template. Many documents can be generated from one template (N:1). No bidirectional conflict. Stron',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Insurance documents frequently originate from vendors (exam vendors, TPAs, medical records providers, appraisal services). Critical for audit trail, vendor performance tracking, invoice reconciliation',
    `archived_timestamp` TIMESTAMP COMMENT 'Date and time when the document was moved to archive storage. Tracks transition from active to archived state per retention policy.',
    `confidentiality_level` STRING COMMENT 'Data classification level indicating the sensitivity of the document content. Determines access controls and handling requirements.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the document record was first created in the system. Audit trail for document lifecycle tracking.',
    `destroyed_timestamp` TIMESTAMP COMMENT 'Date and time when the document was destroyed per retention policy. Audit trail for compliance with record destruction requirements.',
    `document_category` STRING COMMENT 'High-level category grouping for the document type. Used for broad classification and filtering of document inventory. [ENUM-REF-CANDIDATE: policy|application|illustration|underwriting|claim|annuity|regulatory|disclosure|correspondence|form — 10 candidates stripped; promote to reference product]',
    `document_description` STRING COMMENT 'Detailed description of the document content, purpose, and context. Provides additional metadata for search and classification.',
    `document_number` STRING COMMENT 'Business identifier for the document. Human-readable unique number assigned to the document for tracking and reference purposes.',
    `e_delivery_consent_flag` BOOLEAN COMMENT 'Indicates whether the policyholder has consented to electronic delivery of this document type. True if e-delivery is authorized, false if paper delivery required.',
    `effective_date` DATE COMMENT 'Date when the document becomes effective or enforceable. Relevant for policy contracts, endorsements, riders, and regulatory filings.',
    `expiration_date` DATE COMMENT 'Date when the document expires or is no longer valid. Relevant for time-limited documents such as illustrations, quotes, and temporary authorizations.',
    `file_format` STRING COMMENT 'Technical file format of the stored document. Identifies the MIME type or file extension for retrieval and rendering. [ENUM-REF-CANDIDATE: pdf|docx|tiff|jpeg|png|xml|html|txt — 8 candidates stripped; promote to reference product]',
    `file_size_bytes` BIGINT COMMENT 'Size of the document file in bytes. Used for storage management and transmission planning.',
    `hash` STRING COMMENT 'Cryptographic hash of the document content. Used for integrity verification, tamper detection, and duplicate detection.',
    `indexed_timestamp` TIMESTAMP COMMENT 'Date and time when the document was indexed for search and retrieval. Tracks completion of document imaging and metadata extraction processes.',
    `is_latest_version` BOOLEAN COMMENT 'Indicates whether this document record represents the most current version. True if this is the active version, false if superseded.',
    `jurisdiction_code` STRING COMMENT 'State or jurisdiction code where this document applies or was filed. Two-letter state abbreviation or country code for regulatory and compliance tracking.',
    `legal_hold_flag` BOOLEAN COMMENT 'Indicates whether this document is subject to a legal hold and must be preserved beyond normal retention schedules. True if under legal hold, false otherwise.',
    `lifecycle_status` STRING COMMENT 'Current state of the document in its lifecycle. Tracks progression from draft through active use to archival or destruction per retention policy.. Valid values are `draft|active|superseded|archived|destroyed|pending`',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the document record was last modified. Audit trail for tracking changes to document metadata.',
    `nigo_flag` BOOLEAN COMMENT 'Indicates whether the document is incomplete or missing required information. True if NIGO, false if complete and acceptable.',
    `nigo_reason` STRING COMMENT 'Description of why the document was flagged as NIGO. Details missing information, incomplete sections, or quality issues that prevent processing.',
    `origination_channel` STRING COMMENT 'Channel or method through which the document was received or created. Identifies the source interface for document intake. [ENUM-REF-CANDIDATE: web|mobile|email|fax|mail|agent_portal|customer_portal|call_center|branch — 9 candidates stripped; promote to reference product]',
    `page_count` STRING COMMENT 'Number of pages in the document. Relevant for printed documents and multi-page electronic files.',
    `received_date` DATE COMMENT 'Date when the document was received by the insurance company. Relevant for inbound documents such as applications, claim forms, and correspondence.',
    `regulatory_body` STRING COMMENT 'Name of the regulatory body associated with this document. Examples include state Department of Insurance, NAIC, SEC, FINRA, IRS.',
    `regulatory_filing_flag` BOOLEAN COMMENT 'Indicates whether this document is a regulatory filing submitted to or received from a regulatory body. True if regulatory filing, false otherwise.',
    `retention_end_date` DATE COMMENT 'Date when the document retention period expires and the document becomes eligible for destruction. Calculated based on retention category and applicable regulations.',
    `signature_required_flag` BOOLEAN COMMENT 'Indicates whether this document requires a signature for validity. True if signature is mandatory, false otherwise.',
    `signature_status` STRING COMMENT 'Current status of signature collection for this document. Tracks progression through signature workflow.. Valid values are `not_required|pending|signed|rejected|expired`',
    `source_system` STRING COMMENT 'Name of the operational system that created or manages this document. Examples include policy administration system, claims system, underwriting workbench, document management system.',
    `storage_location_uri` STRING COMMENT 'Uniform Resource Identifier pointing to the physical or logical storage location of the document file. May reference cloud storage, content management system, or file system path.',
    `title` STRING COMMENT 'Descriptive title or name of the document. Human-readable label that summarizes the document content or purpose.',
    `version_number` STRING COMMENT 'Version identifier for the document. Tracks revisions and updates to the document over time.',
    CONSTRAINT pk_document PRIMARY KEY(`document_id`)
) COMMENT 'Master registry of all insurance documents managed across the enterprise — policy contracts, applications, illustrations, endorsements, rider documents, claim correspondence, regulatory filings, and disclosure documents. Serves as the authoritative catalog entry for every document object with metadata including document type classification (FK to type), origination channel, source system, retention category, confidentiality level, and lifecycle status (draft, active, superseded, archived, destroyed). This is the SSOT for document identity and metadata within the document domain. All other domain entities (version, signature, access_log, workflow, delivery_event, legal_hold) reference this master record.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`document`.`version` (
    `version_id` BIGINT COMMENT 'Unique identifier for each document version record. Primary key for the document version entity.',
    `document_id` BIGINT COMMENT 'Reference to the parent document entity for which this version record exists. Links to the master document record.',
    `superseded_by_version_id` BIGINT COMMENT 'Reference to the document_version_id that supersedes this version. Null if this is the current active version. Enables version chain navigation.',
    `approval_date` DATE COMMENT 'Date when this document version received formal approval to transition from draft or pending status to approved status.',
    `approver_name` STRING COMMENT 'Name of the individual who approved this document version for release or publication. Required for versions that require formal approval workflow.',
    `author_name` STRING COMMENT 'Name of the individual or system user who created or authored this document version. Used for audit trail and accountability.',
    `author_role` STRING COMMENT 'Organizational role or job function of the author at the time of version creation (e.g., Underwriter, Policy Services Representative, Compliance Officer, Actuarial Analyst).',
    `change_reason` STRING COMMENT 'Business justification or trigger for creating this new version. Examples include regulatory update, policyholder request, error correction, product enhancement, or compliance remediation.',
    `checksum_hash` STRING COMMENT 'Cryptographic hash (e.g., SHA-256, MD5) of the document file content. Used for integrity verification, tamper detection, and duplicate detection. Critical for regulatory audit and litigation hold.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this document version record was first created in the system. Used for audit trail and lifecycle tracking.',
    `effective_date` DATE COMMENT 'Date when this document version becomes legally binding or operationally effective. Critical for regulatory compliance and policy servicing.',
    `eligible_for_purge_date` DATE COMMENT 'Calculated date when this document version becomes eligible for deletion or purge based on retention_period_years and retention_trigger_date. Used for automated archival and compliance-driven purge processes.',
    `encryption_method` STRING COMMENT 'Encryption algorithm or method applied to the document file (e.g., AES-256, RSA-2048). Null if is_encrypted is false.',
    `expiration_date` DATE COMMENT 'Date when this document version is no longer valid or has been superseded by a newer version. Null for currently active versions.',
    `extracted_text_available` BOOLEAN COMMENT 'Indicates whether searchable text content has been extracted and indexed for this document version. True if text is available for full-text search; false otherwise.',
    `file_format` STRING COMMENT 'Technical file format of the stored document version. Common formats include PDF for policy contracts, TIFF for scanned images, XML for ACORD forms, and DOCX for editable templates. [ENUM-REF-CANDIDATE: PDF|TIFF|XML|DOCX|HTML|JPEG|PNG — 7 candidates stripped; promote to reference product]',
    `file_size_bytes` BIGINT COMMENT 'Size of the document file in bytes. Used for storage capacity planning, transmission optimization, and system performance monitoring.',
    `hash_algorithm` STRING COMMENT 'Cryptographic algorithm used to generate the checksum hash. Identifies the hashing method for verification and compliance purposes.. Valid values are `SHA-256|SHA-512|MD5|SHA-1`',
    `is_digitally_signed` BOOLEAN COMMENT 'Indicates whether this document version carries a digital signature for authenticity and non-repudiation. True if digitally signed; false otherwise.',
    `is_encrypted` BOOLEAN COMMENT 'Indicates whether this document version is stored in encrypted format. True if encryption is applied at rest; false otherwise. Critical for HIPAA and data privacy compliance.',
    `is_under_litigation_hold` BOOLEAN COMMENT 'Indicates whether this document version is subject to a legal hold or litigation preservation order. True if hold is active; false otherwise. Prevents deletion or modification during legal proceedings.',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code indicating the primary language of the document content (e.g., EN for English, ES for Spanish, FR for French). Supports multilingual policy administration.',
    `last_accessed_timestamp` TIMESTAMP COMMENT 'Date and time when this document version was last retrieved or viewed by a user or system. Used for usage analytics and compliance monitoring.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this document version record was last updated or modified. Used for audit trail and change tracking.',
    `litigation_hold_date` DATE COMMENT 'Date when the litigation hold was placed on this document version. Null if is_under_litigation_hold is false.',
    `mime_type` STRING COMMENT 'Standard MIME type identifier for the document file (e.g., application/pdf, image/tiff, application/xml). Used for content type validation and browser rendering.',
    `notes` STRING COMMENT 'Free-text notes or comments describing the changes, updates, or context for this document version. Used for internal documentation and audit trail.',
    `ocr_confidence_score` DECIMAL(18,2) COMMENT 'Average confidence score (0.00 to 100.00) of the OCR text extraction process. Higher scores indicate greater accuracy. Null if ocr_processed_flag is false.',
    `ocr_processed_flag` BOOLEAN COMMENT 'Indicates whether this document version has been processed through optical character recognition to extract text content. True if OCR has been applied; false otherwise.',
    `page_count` STRING COMMENT 'Total number of pages in this document version. Applicable to paginated formats such as PDF and TIFF. Used for printing cost estimation and completeness verification.',
    `retention_period_years` STRING COMMENT 'Number of years this document version must be retained per regulatory or business policy requirements. Drives archival and purge schedules aligned with state Department of Insurance (DOI) requirements.',
    `retention_trigger_date` DATE COMMENT 'Date from which the retention period begins counting. Typically the effective date, approval date, or policy termination date depending on document type and regulatory requirements.',
    `signature_timestamp` TIMESTAMP COMMENT 'Date and time when the digital signature was applied to this document version. Null if is_digitally_signed is false.',
    `signer_name` STRING COMMENT 'Name of the individual or entity whose digital signature is applied to this document version. Used for legal authenticity and audit trail.',
    `source_system` STRING COMMENT 'Name of the operational system or application that generated or uploaded this document version (e.g., Policy Administration System, Underwriting Workbench, Claims Management System, Document Imaging System).',
    `source_system_version_code` STRING COMMENT 'Original version identifier or document key from the source system. Used for traceability and reconciliation with upstream systems.',
    `storage_uri` STRING COMMENT 'Full path or URI to the physical storage location of this document version in the document management system, content repository, or cloud storage (e.g., S3 bucket path, Azure Blob URI, file system path).',
    `version_number` STRING COMMENT 'Sequential or semantic version identifier for this document revision (e.g., 1.0, 2.1, 3.0-draft). Supports both numeric and alphanumeric versioning schemes.',
    `version_status` STRING COMMENT 'Current lifecycle status of this document version. Tracks progression from draft through approval to active use and eventual archival or supersession. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|active|superseded|archived|withdrawn — 7 candidates stripped; promote to reference product]',
    `version_type` STRING COMMENT 'Classification of the version change event. Distinguishes between original issuance, amendments, corrections, reissues, and endorsement attachments.. Valid values are `original|amendment|correction|reissue|endorsement|rider_attachment`',
    CONSTRAINT pk_version PRIMARY KEY(`version_id`)
) COMMENT 'Tracks the full version history of each insurance document, capturing every revision, amendment, re-issue, or correction event. Stores version number, effective date, author, change reason, checksum/hash for integrity verification, storage URI, file format (PDF, TIFF, XML), page count, and version status (draft, pending approval, approved, superseded, archived). Enables point-in-time retrieval of any document version for regulatory audit, litigation hold, or policyholder inquiry.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`document`.`package` (
    `package_id` BIGINT COMMENT 'Unique identifier for the document package. Primary key.',
    `annuitant_id` BIGINT COMMENT 'Foreign key linking to policyholder.annuitant. Business justification: Annuity document packages (payout election kits, RMD notices, beneficiary forms) are assembled at annuitant level for contract administration and regulatory compliance (IRS RMD rules).',
    `application_id` BIGINT COMMENT 'Foreign key reference to the new business application for application-related document packages.',
    `claim_id` BIGINT COMMENT 'Foreign key reference to the associated claim for claim-related document packages (submission, adjudication, appeal).',
    `group_sponsor_id` BIGINT COMMENT 'Foreign key linking to policyholder.group_sponsor. Business justification: Group document packages (enrollment kits, SPDs, ERISA disclosures) are assembled and tracked at sponsor level for group administration, open enrollment, and DOL/ERISA compliance.',
    `in_force_policy_id` BIGINT COMMENT 'Foreign key reference to the associated insurance policy for policy-related document packages (issuance, servicing, endorsements).',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system process that created the document package record.',
    `package_employee_id` BIGINT COMMENT 'Identifier of the user or processor currently assigned to review, validate, or complete the document package.',
    `package_updated_by_user_employee_id` BIGINT COMMENT 'Identifier of the user or system process that last updated the document package record.',
    `party_id` BIGINT COMMENT 'Foreign key reference to the policyholder or customer associated with this document package.',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: A package may have a primary or lead document (e.g., the application form in a new business package, the policy contract in an issue package). One package has one primary document (1:1 or N:1). Id',
    `producer_id` BIGINT COMMENT 'Foreign key reference to the agent or producer who submitted or is associated with the document package.',
    `statutory_filing_id` BIGINT COMMENT 'Foreign key linking to reporting.statutory_filing. Business justification: Document packages (annual statement exhibits, actuarial memoranda, audit workpapers) are assembled for statutory filings. Real business process: NAIC annual statement filing to state DOI requires subm',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Document packages often assembled or provided by vendors (exam vendors submit complete exam packages, imaging vendors submit scanned application packages, TPAs submit claims documentation packages). B',
    `assembly_date` DATE COMMENT 'The date when the document package was initially assembled or created for the associated business transaction.',
    `assigned_date` DATE COMMENT 'The date when the document package was assigned to the current user or work queue for processing.',
    `completeness_percentage` DECIMAL(18,2) COMMENT 'Calculated percentage representing the ratio of received required documents to total required documents, expressed as a value between 0.00 and 100.00.',
    `completion_date` DATE COMMENT 'The date when the document package was marked as complete with all required documents received and validated.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the document package record was first created in the system.',
    `delivery_method` STRING COMMENT 'The method by which the document package was delivered or submitted. Options include electronic delivery, postal mail, fax, in-person submission, web portal upload, email, or courier service. [ENUM-REF-CANDIDATE: electronic|mail|fax|in_person|portal|email|courier — 7 candidates stripped; promote to reference product]',
    `e_delivery_consent_date` DATE COMMENT 'The date when electronic delivery consent was obtained from the policyholder.',
    `e_delivery_consent_flag` BOOLEAN COMMENT 'Boolean indicator of whether the policyholder has provided consent for electronic delivery of documents in this package. True indicates consent has been obtained.',
    `external_reference_number` STRING COMMENT 'External tracking number or reference identifier provided by the submitter, agent, or third party for cross-system reconciliation.',
    `imaging_batch_number` STRING COMMENT 'Identifier for the document imaging batch in which the physical documents in this package were scanned and digitized.',
    `imaging_date` DATE COMMENT 'The date when the documents in this package were scanned and imaged into the document management system.',
    `nigo_date` DATE COMMENT 'The date when the package was first identified and flagged as NIGO (Not In Good Order).',
    `nigo_flag` BOOLEAN COMMENT 'Boolean indicator that identifies whether the package is flagged as NIGO (Not In Good Order) due to missing, incomplete, or invalid documents. True indicates NIGO status requiring remediation.',
    `nigo_reason` STRING COMMENT 'Detailed explanation of why the package was flagged as NIGO, including specific missing documents, incomplete forms, signature issues, or validation failures.',
    `notes` STRING COMMENT 'Free-form text field for internal notes, comments, or special instructions related to the document package processing.',
    `optional_document_count` STRING COMMENT 'Total number of optional or supplemental documents included in the package beyond the required set.',
    `package_description` STRING COMMENT 'Free-text description providing additional context about the document package, its purpose, or special handling instructions.',
    `package_number` STRING COMMENT 'Business-facing unique identifier or reference number for the document package, used for tracking and communication purposes.',
    `package_status` STRING COMMENT 'Current lifecycle status of the document package. Tracks progression through workflow stages including draft, submitted, in review, complete, incomplete, NIGO (Not In Good Order), approved, rejected, or archived. [ENUM-REF-CANDIDATE: draft|submitted|in_review|complete|incomplete|nigo|approved|rejected|archived — 9 candidates stripped; promote to reference product]',
    `package_type` STRING COMMENT 'Classification of the document package based on its business purpose. Examples include new business (NB) application package, policy issuance kit, claim submission package, annual statement package, regulatory filing bundle, underwriting submission, policy servicing request, reinstatement package, 1035 exchange documentation, or beneficiary change package. [ENUM-REF-CANDIDATE: new_business_application|policy_issuance_kit|claim_submission|annual_statement|regulatory_filing|underwriting_submission|policy_servicing|reinstatement|1035_exchange|beneficiary_change — 10 candidates stripped; promote to reference product]',
    `priority_level` STRING COMMENT 'Processing priority assigned to the document package based on business rules, service level agreements (SLAs), or special handling requirements.. Valid values are `low|normal|high|urgent|expedited`',
    `received_document_count` STRING COMMENT 'Total number of required documents that have been received and logged into the package.',
    `regulatory_jurisdiction` STRING COMMENT 'The state or jurisdiction whose regulatory requirements govern this document package, typically the state of policy issuance or claim filing.',
    `required_document_count` STRING COMMENT 'Total number of documents designated as required for this package type and business transaction.',
    `retention_expiration_date` DATE COMMENT 'The calculated date when the retention period expires and the document package becomes eligible for archival or destruction per records management policy.',
    `retention_period_years` STRING COMMENT 'The number of years this document package must be retained per regulatory requirements and company policy, aligned with state Department of Insurance (DOI) retention schedules.',
    `sla_due_date` DATE COMMENT 'The target date by which the document package must be processed to meet service level agreement commitments.',
    `source_system` STRING COMMENT 'The originating system or platform from which the document package was created or submitted (e.g., Policy Administration System, Agent Portal, Customer Portal, Claims System).',
    `submission_date` DATE COMMENT 'The date when the document package was formally submitted for processing or review.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when the document package record was last modified or updated.',
    `version` STRING COMMENT 'Version number of the document package, incremented when documents are added, removed, or replaced to maintain version control and audit trail.',
    CONSTRAINT pk_package PRIMARY KEY(`package_id`)
) COMMENT 'Represents a logical grouping of related documents assembled for a specific business purpose — new business (NB) application package, policy issuance kit, claim submission package, annual statement package, or regulatory filing bundle. Tracks package type, associated business transaction (application, policy, claim), assembly date, completeness status, NIGO flag, and the list of required versus received document types with their receipt status, receipt date, and NIGO reason if incomplete. Includes line-item detail for each document within the package (role: required/optional/supplemental, specific ACORD form number, receipt tracking). Critical for NB processing workflows, NIGO tracking, and package completeness validation.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`document`.`nigo_record` (
    `nigo_record_id` BIGINT COMMENT 'Unique identifier for the NIGO record. Primary key for tracking deficient application or document submissions throughout their lifecycle.',
    `annuitant_id` BIGINT COMMENT 'Foreign key linking to policyholder.annuitant. Business justification: Annuitant-specific NIGO deficiencies (incomplete payout elections, missing RMD acknowledgments) are tracked for contract servicing, payout processing, and IRS compliance reporting.',
    `annuity_contract_id` BIGINT COMMENT 'Foreign key linking to annuity.annuity_contract. Business justification: NIGO deficiency tracking for annuity applications, changes, and servicing transactions requires linking deficiency records to contracts for resolution workflow and SLA monitoring. Distinct from docume',
    `application_id` BIGINT COMMENT 'Reference to the new business application that contains the NIGO condition. Links to the policy application undergoing processing.',
    `contract_owner_id` BIGINT COMMENT 'Foreign key linking to policyholder.contract_owner. Business justification: Owner-specific NIGO deficiencies (ownership transfer forms, tax certifications, KYC documents) are tracked for policy servicing and ownership change workflows. Business uses for aging and resolution t',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: NIGO records track deficiencies on specific documents. A NIGO can be raised against a missing APS document, incomplete application form, unsigned beneficiary form, etc. Many NIGO records can reference',
    `document_type_id` BIGINT COMMENT 'Reference to the specific document type that has the NIGO condition (e.g., APS, beneficiary form, illustration, medical questionnaire).',
    `group_member_id` BIGINT COMMENT 'Foreign key linking to policyholder.group_member. Business justification: Group member NIGO deficiencies (incomplete EOI, missing beneficiary forms) are tracked at member level for enrollment completion, coverage activation, and billing reconciliation.',
    `group_sponsor_id` BIGINT COMMENT 'Foreign key linking to policyholder.group_sponsor. Business justification: Group enrollment NIGO deficiencies (missing employer attestations, incomplete census files) are tracked at sponsor level for resolution and billing hold management in group operations.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: NIGO deficiency tracking requires employee accountability for quality control. Business process: NIGO aging reports by processor, individual performance metrics, workload distribution in new business ',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the policy associated with this NIGO record, if the application has progressed to policy issuance stage.',
    `package_id` BIGINT COMMENT 'Reference to the document package containing the deficient documents. Links to the collection of documents submitted together.',
    `party_id` BIGINT COMMENT 'Foreign key linking to policyholder.party. Business justification: NIGO deficiencies often relate to party-level documentation (KYC, identity verification, tax forms). Business tracks responsible party for deficiency resolution workflows and aging reports.',
    `policyholder_beneficiary_id` BIGINT COMMENT 'Foreign key linking to policyholder.policyholder_beneficiary. Business justification: Beneficiary designation NIGO deficiencies (missing signatures, invalid percentages, minor guardian documentation) are tracked at beneficiary level for resolution workflows and policy issue clearance.',
    `producer_id` BIGINT COMMENT 'Reference to the agent or broker who submitted the application with the NIGO condition. Used for agent quality scorecards and training.',
    `premium_bill_id` BIGINT COMMENT 'Foreign key linking to billing.premium_bill. Business justification: NIGO records can flag missing payment documentation or billing discrepancies during new business processing that must be cleared before policy issue. Real business process: underwriting clearance work',
    `request_id` BIGINT COMMENT 'Foreign key linking to document.document_request. Business justification: NIGO can be raised when a requested document is not received, is incomplete, or fails quality checks. Links the deficiency to the original outbound request. Many NIGOs can relate to one request (N:1).',
    `underwriting_workbench_case_application_id` BIGINT COMMENT 'External case identifier from the underwriting workbench system (e.g., RGAX AURA, Swiss Re Magnum) where the NIGO condition was identified.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: NIGO deficiencies frequently caused by vendor delays or errors (exam vendor missed appointment, medical records provider incomplete submission, TPA documentation gaps). Critical for root cause analysi',
    `aging_days` STRING COMMENT 'Number of calendar days the NIGO condition has been open since identification. Key metric for SLA monitoring and agent performance tracking.',
    `compliance_notes` STRING COMMENT 'Free-text field for documenting compliance-related considerations, state-specific requirements, or regulatory handling notes for the NIGO condition.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the NIGO record was first created in the document management system. Audit trail for record lifecycle.',
    `deficiency_description` STRING COMMENT 'Detailed free-text description of the specific deficiency or missing information that caused the NIGO condition. Provides context beyond the reason code.',
    `distribution_channel` STRING COMMENT 'Sales channel through which the application was submitted. Enables NIGO rate trending and quality analysis by distribution channel. [ENUM-REF-CANDIDATE: career_agent|independent_agent|bga|mga|bank|worksite|direct — 7 candidates stripped; promote to reference product]',
    `due_date` DATE COMMENT 'Target date by which the NIGO condition must be resolved to meet new business processing SLAs and state DOI timeliness requirements.',
    `escalation_date` DATE COMMENT 'Date when the NIGO condition was escalated to higher authority. Null if never escalated.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the NIGO condition has been escalated to management or senior underwriting due to aging, complexity, or business impact.',
    `escalation_reason` STRING COMMENT 'Free-text explanation of why the NIGO condition was escalated (e.g., exceeded SLA, unresponsive agent, complex resolution required).',
    `estimated_delay_days` STRING COMMENT 'Estimated number of days the NIGO condition will delay policy issuance. Used for customer expectation management and SLA forecasting.',
    `follow_up_count` STRING COMMENT 'Number of follow-up attempts made to resolve the NIGO condition. Indicates persistence required and potential agent quality issues.',
    `identified_date` DATE COMMENT 'Date when the NIGO condition was first identified during application processing or document review. Key metric for SLA tracking.',
    `impact_on_issue_date` BOOLEAN COMMENT 'Indicates whether the NIGO condition is expected to delay the policy issue date beyond the original target.',
    `last_follow_up_date` DATE COMMENT 'Date of the most recent follow-up communication regarding the NIGO condition. Used to determine next action timing.',
    `last_modified_by` STRING COMMENT 'User identifier or system process that last modified the NIGO record. Supports audit trail and change tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent update to the NIGO record. Tracks record currency and change frequency.',
    `next_follow_up_date` DATE COMMENT 'Scheduled date for the next follow-up action on the NIGO condition. Supports proactive case management.',
    `nigo_reason_code` STRING COMMENT 'Standardized code identifying the type of deficiency. Examples: MISS_SIG (missing signature), INCOMP_FORM (incomplete form), MISS_DOC (missing required document), ILLEG_ENTRY (illegible entry), MISS_MED (missing medical information), INVAL_DATE (invalid date), MISS_BENE (missing beneficiary information), INCONS_DATA (inconsistent data across forms). [ENUM-REF-CANDIDATE: MISS_SIG|INCOMP_FORM|MISS_DOC|ILLEG_ENTRY|MISS_MED|INVAL_DATE|MISS_BENE|INCONS_DATA — 8 candidates stripped; promote to reference product]',
    `nigo_status` STRING COMMENT 'Current lifecycle status of the NIGO record. Tracks whether the deficiency is open, awaiting response from agent or applicant, escalated to management, resolved, or application withdrawn.. Valid values are `open|pending_agent|pending_applicant|escalated|resolved|withdrawn`',
    `notification_method` STRING COMMENT 'Channel used to notify the responsible party of the NIGO condition. Supports compliance documentation and communication preference tracking.. Valid values are `email|postal_mail|phone|portal|fax`',
    `notification_sent_date` DATE COMMENT 'Date when notification of the NIGO condition was sent to the responsible party (agent or applicant). Required for state DOI compliance on timely communication.',
    `product_type` STRING COMMENT 'Type of insurance product associated with the NIGO application (e.g., Term Life, Whole Life, Universal Life, Variable Universal Life, Fixed Annuity, Variable Annuity). Used for NIGO trending by product line. [ENUM-REF-CANDIDATE: term_life|whole_life|universal_life|indexed_universal_life|variable_universal_life|term_certain_annuity|fixed_annuity|variable_annuity|fixed_indexed_annuity|spia|disability_income — promote to reference product]',
    `resolution_method` STRING COMMENT 'Method by which the NIGO condition was resolved. Examples: corrected_form (resubmitted corrected document), waiver_granted (underwriter waived requirement), additional_doc (supplemental documentation provided), phone_verification (verbal confirmation obtained), withdrawn (application withdrawn).. Valid values are `corrected_form|waiver_granted|additional_doc|phone_verification|withdrawn`',
    `resolved_by` STRING COMMENT 'Name or identifier of the person or system that resolved the NIGO condition and returned the application to good order.',
    `resolved_date` DATE COMMENT 'Date when the NIGO condition was fully resolved and the application returned to good order status. Null if still open.',
    `responsible_party_contact` STRING COMMENT 'Email address or phone number of the responsible party for follow-up communication regarding the NIGO condition.',
    `responsible_party_name` STRING COMMENT 'Name of the specific individual or organization responsible for resolving the NIGO condition.',
    `responsible_party_type` STRING COMMENT 'Category of party responsible for correcting the NIGO condition. Determines routing and follow-up workflow.. Valid values are `agent|applicant|tpa|carrier|medical_provider`',
    `severity_level` STRING COMMENT 'Business impact severity of the NIGO condition. Critical deficiencies block underwriting; low severity items may be resolved post-issue.. Valid values are `critical|high|medium|low`',
    `source_system` STRING COMMENT 'Name of the operational system that originated the NIGO record (e.g., Policy Administration System, Underwriting Workbench, Document Management System).',
    `source_system_record_reference` STRING COMMENT 'Primary key or unique identifier of the NIGO record in the source operational system. Enables traceability and reconciliation.',
    `state_jurisdiction` STRING COMMENT 'Two-letter US state code or jurisdiction where the policy will be issued. Determines applicable state DOI timeliness and communication requirements.',
    `created_by` STRING COMMENT 'User identifier or system process that created the NIGO record. Supports audit trail and accountability.',
    CONSTRAINT pk_nigo_record PRIMARY KEY(`nigo_record_id`)
) COMMENT 'Operational record of a Not-In-Good-Order (NIGO) condition identified on an insurance application or document submission. Captures NIGO reason code, deficiency description, affected document type (FK to type), associated document package (FK to package), date identified, date resolved, resolution method (corrected form resubmitted, waiver granted, application withdrawn), responsible party (agent, applicant, TPA), escalation status, follow-up action history, and aging metrics. Directly supports NB application processing SLAs, state DOI compliance for application handling timelines, agent quality scorecards, and NIGO rate trending by agent, product, and distribution channel.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`document`.`delivery_consent` (
    `delivery_consent_id` BIGINT COMMENT 'Primary key for delivery_consent',
    `document_id` BIGINT COMMENT 'Reference to the stored consent form or agreement document signed by the policyholder.',
    `signature_id` BIGINT COMMENT 'Unique identifier from the e-signature platform (e.g., DocuSign, Adobe Sign) linking to the electronic signature event for this consent.',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the policy associated with this consent record.',
    `party_id` BIGINT COMMENT 'Reference to the policyholder or applicant who provided the consent.',
    `producer_id` BIGINT COMMENT 'Reference to the insurance agent or producer who assisted with or witnessed the consent capture, if applicable.',
    `alternate_email_address` STRING COMMENT 'Secondary or backup email address for electronic document delivery if primary email fails.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `bounce_count` STRING COMMENT 'Number of times electronic document delivery has failed (bounced) to the provided email address, used to trigger consent re-verification or revocation.',
    `consent_date` DATE COMMENT 'Date when the policyholder provided or last modified their electronic delivery consent.',
    `consent_device_type` STRING COMMENT 'Type of device used by the policyholder to provide electronic delivery consent.. Valid values are `desktop|mobile|tablet|kiosk|phone_ivr|unknown`',
    `consent_ip_address` STRING COMMENT 'IP address from which the electronic consent was submitted, captured for audit trail and fraud prevention purposes.. Valid values are `^(?:[0-9]{1,3}.){3}[0-9]{1,3}$|^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$`',
    `consent_language` STRING COMMENT 'Two-letter ISO 639-1 language code indicating the language in which the consent was provided and in which documents should be delivered.. Valid values are `^[a-z]{2}$`',
    `consent_method` STRING COMMENT 'Method by which the policyholder provided their electronic delivery consent, such as through web portal, mobile app, e-signature platform, or traditional wet signature.. Valid values are `web_portal|mobile_app|email_link|wet_signature|e_signature|phone_ivr`',
    `consent_scope` STRING COMMENT 'Scope of documents covered by the electronic delivery consent, indicating whether consent applies to all documents or specific categories such as policy documents, billing statements, or claims correspondence.. Valid values are `all_documents|policy_documents_only|billing_only|claims_only|tax_documents_only|regulatory_notices_only`',
    `consent_status` STRING COMMENT 'Current status of the electronic delivery consent indicating whether the policyholder has granted, revoked, or is pending consent for electronic document delivery.. Valid values are `granted|revoked|pending|expired|suspended`',
    `consent_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the consent was captured or last modified, including time zone information.',
    `consent_user_agent` STRING COMMENT 'Browser or application user agent string captured at the time of consent submission for technical audit trail.',
    `consent_version` STRING COMMENT 'Version identifier of the consent form or terms and conditions that the policyholder agreed to, used to track changes in consent language over time.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this consent record was first created in the system.',
    `data_classification` STRING COMMENT 'Classification level of the consent record indicating the sensitivity and handling requirements of the data.. Valid values are `restricted|confidential|internal|public`',
    `effective_date` DATE COMMENT 'Date when the electronic delivery consent becomes effective and the company may begin delivering documents electronically.',
    `email_address` STRING COMMENT 'Primary email address on file for electronic document delivery to the policyholder.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `expiration_date` DATE COMMENT 'Date when the electronic delivery consent expires and requires renewal, if applicable per state regulations.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this consent record is currently active and in effect for electronic document delivery.',
    `last_bounce_date` DATE COMMENT 'Date of the most recent electronic delivery failure (bounce) for this consent record.',
    `last_verification_date` DATE COMMENT 'Date when the email address or delivery channel was last verified as valid and deliverable.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the consent record, including special handling instructions or customer service interactions.',
    `opt_in_marketing_flag` BOOLEAN COMMENT 'Indicates whether the policyholder has opted in to receive marketing communications via electronic delivery channels.',
    `preferred_delivery_channel` STRING COMMENT 'Policyholders preferred channel for receiving insurance documents, including electronic options (email, portal, mobile app) or traditional mail.. Valid values are `email|portal|mobile_app|mail|fax`',
    `record_version` STRING COMMENT 'Version number of this consent record, incremented with each modification for audit trail and concurrency control.',
    `renewal_required_flag` BOOLEAN COMMENT 'Indicates whether the consent requires periodic renewal per state-specific e-delivery regulations.',
    `revocation_date` DATE COMMENT 'Date when the policyholder revoked their electronic delivery consent, if applicable.',
    `revocation_method` STRING COMMENT 'Method by which the policyholder revoked their electronic delivery consent.. Valid values are `web_portal|mobile_app|phone|email|mail|agent_assisted`',
    `revocation_reason` STRING COMMENT 'Free-text explanation or reason code provided by the policyholder for revoking electronic delivery consent.',
    `source_system` STRING COMMENT 'Name of the source system or application from which the consent record originated (e.g., policy administration system, customer portal, CRM).',
    `source_system_code` STRING COMMENT 'Unique identifier of this consent record in the source system, used for data lineage and reconciliation.',
    `state_compliance_flag` BOOLEAN COMMENT 'Indicates whether this consent record meets the specific e-delivery compliance requirements of the applicable state jurisdiction per NAIC model regulation and state-specific DOI rules.',
    `state_jurisdiction` STRING COMMENT 'Two-letter state code representing the jurisdiction whose e-delivery regulations apply to this consent record, as e-delivery requirements vary by state Department of Insurance.. Valid values are `^[A-Z]{2}$`',
    `termination_date` DATE COMMENT 'Date when the electronic delivery consent was terminated, either through revocation, expiration, or policy termination.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this consent record was last updated or modified.',
    `verification_status` STRING COMMENT 'Status of email address or delivery channel verification indicating whether the contact information has been confirmed as valid.. Valid values are `verified|unverified|bounced|invalid|pending_verification`',
    CONSTRAINT pk_delivery_consent PRIMARY KEY(`delivery_consent_id`)
) COMMENT 'Master record of a policyholders or applicants electronic delivery consent preferences, capturing consent status (granted, revoked, pending), consent date, consent method (web portal, wet signature, e-signature), email address on file, preferred document delivery channel (email, portal, mail), consent scope (all documents, policy documents only, billing only), and state-specific e-delivery compliance flags per NAIC e-delivery model regulation. SSOT for e-delivery eligibility decisions.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`document`.`delivery_event` (
    `delivery_event_id` BIGINT COMMENT 'Primary key for delivery_event',
    `delivery_consent_id` BIGINT COMMENT 'Foreign key linking to document.delivery_consent. Business justification: Each delivery event should reference the consent record that authorized it. Delivery_event currently has edelivery_consent_flag and consent_date which should be normalized. Many delivery events operat',
    `document_id` BIGINT COMMENT 'Reference to the specific document being delivered in this event. Links to the document master record.',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the insurance policy associated with this document delivery event, if applicable.',
    `package_id` BIGINT COMMENT 'Foreign key linking to document.document_package. Business justification: E-delivery can send entire packages (e.g., annual statement package with policy summary + tax forms + disclosure documents). Many delivery events for one package (N:1). Tracks package-level delivery f',
    `party_id` BIGINT COMMENT 'Reference to the policyholder who is the intended recipient of the document delivery.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking this delivery event to the comprehensive audit trail system for regulatory examination purposes.',
    `confirmation_receipt_timestamp` TIMESTAMP COMMENT 'Date and time when the recipient explicitly acknowledged receipt of the document through a confirmation mechanism.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this delivery event record was first created in the system.',
    `delivery_batch_number` STRING COMMENT 'Identifier for the batch job or campaign that initiated this delivery event. Groups related delivery events for operational tracking.',
    `delivery_channel` STRING COMMENT 'The electronic or physical channel through which the document delivery was attempted. Tracks the method used to reach the recipient.. Valid values are `email|secure_portal|sms_notification|mobile_app|fax|paper_fallback`',
    `delivery_method_preference` STRING COMMENT 'Recipients stated preference for document delivery method. Used to route delivery attempts to preferred channels.. Valid values are `email_only|portal_only|sms_notification|any_electronic|paper_required`',
    `delivery_priority` STRING COMMENT 'Priority level assigned to this delivery event. Determines processing order and SLA requirements.. Valid values are `urgent|high|normal|low`',
    `delivery_status` STRING COMMENT 'Current status of the document delivery attempt. Tracks the outcome of the delivery event through its lifecycle. [ENUM-REF-CANDIDATE: sent|delivered|opened|failed|bounced|undeliverable|pending_retry — 7 candidates stripped; promote to reference product]',
    `delivery_timestamp` TIMESTAMP COMMENT 'Date and time when the document was successfully delivered to the recipients channel (e.g., email server accepted, portal upload completed).',
    `document_type` STRING COMMENT 'Classification of the document being delivered (e.g., policy contract, illustration, APS, beneficiary form, claim correspondence, disclosure).',
    `document_version` STRING COMMENT 'Version identifier of the document being delivered. Tracks document revisions and ensures correct version delivery.',
    `encryption_flag` BOOLEAN COMMENT 'Indicates whether the document was encrypted during transmission and storage for this delivery event.',
    `failure_code` STRING COMMENT 'Standardized code representing the category of delivery failure (e.g., invalid address, mailbox full, recipient blocked).',
    `failure_reason` STRING COMMENT 'Detailed explanation of why the delivery attempt failed. Captures technical error messages, bounce reasons, or recipient unavailability details.',
    `fallback_to_paper_flag` BOOLEAN COMMENT 'Indicates whether the system has triggered a fallback to physical paper delivery due to repeated electronic delivery failures.',
    `ip_address` STRING COMMENT 'IP address from which the recipient accessed or opened the document. Used for security audit and fraud detection.',
    `max_retry_attempts` STRING COMMENT 'Maximum number of retry attempts configured for this delivery event before escalation or fallback to paper.',
    `next_retry_timestamp` TIMESTAMP COMMENT 'Scheduled date and time for the next delivery retry attempt, if the current attempt failed.',
    `opened_timestamp` TIMESTAMP COMMENT 'Date and time when the recipient opened or accessed the delivered document. Provides confirmation of receipt and engagement.',
    `paper_fallback_timestamp` TIMESTAMP COMMENT 'Date and time when the fallback to paper delivery was initiated after electronic delivery failures.',
    `recipient_email` STRING COMMENT 'Email address to which the document was delivered. Primary contact channel for electronic delivery.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `recipient_phone` STRING COMMENT 'Phone number used for SMS notification of document delivery, if applicable.',
    `regulatory_jurisdiction` STRING COMMENT 'State or jurisdiction whose e-delivery regulations govern this delivery event. Determines compliance requirements and retention rules.',
    `retention_end_date` DATE COMMENT 'Date when this delivery event record may be purged according to state DOI retention schedule requirements.',
    `retry_count` STRING COMMENT 'Number of times the system has attempted to redeliver the document after initial failure. Tracks persistence of delivery efforts.',
    `sent_timestamp` TIMESTAMP COMMENT 'Date and time when the delivery attempt was initiated by the system. Represents the start of the delivery event.',
    `sla_met_flag` BOOLEAN COMMENT 'Indicates whether the delivery event met the defined SLA target for delivery time.',
    `sla_target_hours` DECIMAL(18,2) COMMENT 'Target number of hours within which the document must be delivered to meet service level agreement commitments.',
    `tracking_number` STRING COMMENT 'External tracking identifier provided by the delivery service provider (e.g., email service tracking ID, portal session ID).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this delivery event record was last modified. Tracks changes to delivery status and outcomes.',
    `user_agent` STRING COMMENT 'Browser or application user agent string captured when the recipient accessed the document. Provides device and platform context.',
    CONSTRAINT pk_delivery_event PRIMARY KEY(`delivery_event_id`)
) COMMENT 'Transactional log of each electronic document delivery attempt and outcome for a specific document and recipient. Captures delivery channel (email, secure portal, SMS notification), delivery timestamp, delivery status (sent, delivered, opened, failed, bounced), failure reason, retry count, fallback to paper flag, and confirmation receipt timestamp. Provides the audit trail required by state DOI e-delivery regulations and supports SLA monitoring for document delivery.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`document`.`retention_schedule` (
    `retention_schedule_id` BIGINT COMMENT 'Primary key for retention_schedule',
    `document_type_id` BIGINT COMMENT 'FK to document.document_type',
    `superseded_by_schedule_retention_schedule_id` BIGINT COMMENT 'Reference to the retention schedule record that supersedes this rule, enabling version history tracking.',
    `acord_form_indicator` BOOLEAN COMMENT 'Indicates whether this document type is a standardized ACORD form used across the insurance industry.',
    `approval_authority` STRING COMMENT 'Role or department responsible for approving this retention schedule rule (e.g., Chief Compliance Officer, Legal Department, Records Manager).',
    `approval_date` DATE COMMENT 'Date when this retention schedule rule was formally approved by the designated authority.',
    `audit_trail_required` BOOLEAN COMMENT 'Indicates whether an audit trail of document access, modifications, and destruction must be maintained for compliance purposes.',
    `business_justification` STRING COMMENT 'Business rationale for the retention period beyond regulatory minimum, such as operational need, litigation risk, or customer service requirements.',
    `destruction_authorization_required` BOOLEAN COMMENT 'Indicates whether formal authorization from legal, compliance, or records management is required before document destruction.',
    `destruction_method` STRING COMMENT 'Required method for destroying documents at end of retention period (secure shred, electronic purge, degaussing, incineration, certified destruction).. Valid values are `secure_shred|electronic_purge|degaussing|incineration|certified_destruction`',
    `document_type_code` STRING COMMENT 'Standardized code identifying the document type (e.g., POLICY_CONTRACT, APS, ILLUSTRATION, CLAIM_FORM, BENEFICIARY_CHANGE, RIDER_DOC, ACORD_FORM, NIGO_APP, DISCLOSURE_DOC, REGULATORY_FILING).. Valid values are `^[A-Z0-9_]{2,20}$`',
    `e_delivery_eligible` BOOLEAN COMMENT 'Indicates whether this document type is eligible for electronic delivery to policyholders or beneficiaries, subject to consent requirements.',
    `effective_end_date` DATE COMMENT 'Date when this retention schedule rule is superseded or no longer applicable. Null indicates currently active rule.',
    `effective_start_date` DATE COMMENT 'Date when this retention schedule rule becomes effective and enforceable.',
    `exception_process_available` BOOLEAN COMMENT 'Indicates whether a formal exception process exists to deviate from this retention schedule under specific business or legal circumstances.',
    `jurisdiction_code` STRING COMMENT 'Two-letter state or territory code where the retention requirement applies (e.g., CA, NY, TX). Aligns with State Departments of Insurance jurisdictions.. Valid values are `^[A-Z]{2}$`',
    `last_review_date` DATE COMMENT 'Date when this retention schedule rule was last reviewed for continued accuracy and regulatory compliance.',
    `legal_hold_override_allowed` BOOLEAN COMMENT 'Indicates whether this document type can be subject to legal hold that overrides the standard retention schedule during litigation or regulatory investigation.',
    `line_of_business` STRING COMMENT 'Insurance product line to which this retention schedule applies. [ENUM-REF-CANDIDATE: life|annuity|disability|long_term_care|variable_products|group_life|group_annuity — 7 candidates stripped; promote to reference product]',
    `maximum_retention_years` STRING COMMENT 'Maximum recommended number of years the document should be retained before authorized destruction. Null indicates indefinite retention.',
    `minimum_retention_years` STRING COMMENT 'Minimum number of years the document must be retained from the retention trigger event to comply with regulatory requirements.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this retention schedule rule to ensure ongoing compliance.',
    `nigo_tracking_applicable` BOOLEAN COMMENT 'Indicates whether NIGO tracking (incomplete or deficient document submissions) applies to this document type during new business processing.',
    `pii_phi_indicator` BOOLEAN COMMENT 'Indicates whether documents of this type typically contain PII or PHI, requiring enhanced privacy and security controls.',
    `privacy_classification` STRING COMMENT 'Data classification level for documents of this type, determining access controls and handling requirements.. Valid values are `public|internal|confidential|restricted`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this retention schedule record was first created in the system.',
    `record_updated_by` STRING COMMENT 'User ID or system identifier of the person or process that last updated this retention schedule record.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this retention schedule record was last modified.',
    `regulatory_citation` STRING COMMENT 'Specific regulatory statute, code section, or rule citation that mandates this retention requirement (e.g., NAIC Model Regulation 22, IRC Section 6001, HIPAA 45 CFR 164.530, SOX Section 802).',
    `regulatory_framework` STRING COMMENT 'Primary regulatory framework governing the retention requirement (e.g., NAIC, HIPAA, SOX, IRS, FINRA, SEC, State DOI, ERISA, ACORD). [ENUM-REF-CANDIDATE: naic|hipaa|sox|irs|finra|sec|state_doi|erisa|acord — 9 candidates stripped; promote to reference product]',
    `retention_medium` STRING COMMENT 'Acceptable storage medium for retaining the document (electronic, paper, microfilm, optical, any).. Valid values are `electronic|paper|microfilm|optical|any`',
    `retention_schedule_status` STRING COMMENT 'Current status of this retention schedule rule (active, superseded, pending approval, archived).. Valid values are `active|superseded|pending_approval|archived`',
    `retention_trigger_event` STRING COMMENT 'The business event that starts the retention period clock (e.g., policy issue date, policy termination date, claim settlement date, contract expiration date, last activity date, document creation date, regulatory filing date, audit completion date). [ENUM-REF-CANDIDATE: policy_issue_date|policy_termination_date|claim_settlement_date|contract_expiration_date|last_activity_date|document_creation_date|regulatory_filing_date|audit_completion_date — 8 candidates stripped; promote to reference product]',
    `special_handling_instructions` STRING COMMENT 'Additional instructions for handling, storing, or destroying documents of this type that go beyond standard procedures (e.g., witness required for destruction, off-site storage mandated, encryption required).',
    `version_control_required` BOOLEAN COMMENT 'Indicates whether version history must be maintained for documents of this type throughout the retention period.',
    CONSTRAINT pk_retention_schedule PRIMARY KEY(`retention_schedule_id`)
) COMMENT 'Reference table defining the mandatory and recommended retention periods for each document type by jurisdiction (state DOI), line of business, and regulatory framework (NAIC, HIPAA, SOX, IRS). Captures minimum retention years, maximum retention years, retention trigger event (policy issue date, policy termination date, claim settlement date), destruction authorization requirements, legal hold override rules, and applicable regulatory citation. Governs the document lifecycle from creation through authorized destruction.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`document`.`acord_form` (
    `acord_form_id` BIGINT COMMENT 'Unique identifier for the ACORD form record in the reference catalog.',
    `aml_kyc_required_flag` BOOLEAN COMMENT 'Indicates whether this ACORD form is used for Anti-Money Laundering (AML) and Know Your Customer (KYC) compliance purposes, requiring enhanced due diligence and verification.',
    `applicable_states` STRING COMMENT 'Comma-separated list of two-letter state codes where this form version is approved and applicable. Empty if the form is universally applicable across all states.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this ACORD form record was first created in the reference catalog system.',
    `e_delivery_eligible_flag` BOOLEAN COMMENT 'Indicates whether this ACORD form is eligible for electronic delivery to policyholders or agents, subject to e-delivery consent requirements.',
    `effective_date` DATE COMMENT 'The date on which this version of the ACORD form became effective and approved for use in insurance operations.',
    `electronic_signature_allowed_flag` BOOLEAN COMMENT 'Indicates whether electronic signatures are permitted on this ACORD form per regulatory requirements and ACORD standards. True if e-signatures are allowed, False if wet signatures are required.',
    `expiration_date` DATE COMMENT 'The date on which this version of the ACORD form expires or is superseded by a newer version. Null if the form is currently active with no planned expiration.',
    `form_category` STRING COMMENT 'The high-level category or classification of the form within the document management taxonomy (e.g., application, endorsement, disclosure, medical, financial). [ENUM-REF-CANDIDATE: application|endorsement|disclosure|medical|financial|claim|service_request|regulatory_filing — 8 candidates stripped; promote to reference product]',
    `form_description` STRING COMMENT 'Detailed description of the ACORD forms purpose, content, and usage instructions. Provides context for document indexing and form selection during business processes.',
    `form_language` STRING COMMENT 'The language in which the ACORD form is published, using three-letter ISO 639-2 language codes (e.g., ENG for English, SPA for Spanish, FRA for French).. Valid values are `ENG|SPA|FRA`',
    `form_name` STRING COMMENT 'The official descriptive name of the ACORD form (e.g., Application for Life Insurance, Beneficiary Designation Form, Attending Physician Statement).',
    `form_number` STRING COMMENT 'The official ACORD form number designation (e.g., ACORD 103, ACORD 301, ACORD 1). This is the industry-standard identifier for the form.. Valid values are `^ACORDs[0-9]{1,4}[A-Z]?$`',
    `form_purpose` STRING COMMENT 'The primary business purpose or use case for the ACORD form within the insurance lifecycle (e.g., application, change request, claim submission, beneficiary designation). [ENUM-REF-CANDIDATE: application|change_request|claim|beneficiary_designation|underwriting|policy_service|reinsurance — 7 candidates stripped; promote to reference product]',
    `form_status` STRING COMMENT 'The current lifecycle status of the ACORD form version in the reference catalog (e.g., active, superseded, deprecated, pending approval, withdrawn).. Valid values are `active|superseded|deprecated|pending_approval|withdrawn`',
    `form_template_url` STRING COMMENT 'The URL or file path to the digital template of the ACORD form in the document management system. Used for form retrieval and printing.',
    `form_version` STRING COMMENT 'The version identifier of the ACORD form, typically in YYYY/MM format indicating the publication date of the form version.. Valid values are `^[0-9]{4}/[0-9]{2}$`',
    `hipaa_protected_flag` BOOLEAN COMMENT 'Indicates whether this ACORD form contains Protected Health Information (PHI) subject to HIPAA privacy and security requirements. True if the form collects or displays PHI.',
    `last_reviewed_date` DATE COMMENT 'The date on which this ACORD form record was last reviewed for accuracy, compliance, and currency by the document management or compliance team.',
    `line_of_business` STRING COMMENT 'The insurance product line or lines to which this ACORD form applies (e.g., life, annuity, disability income, long-term care). [ENUM-REF-CANDIDATE: life|annuity|disability_income|long_term_care|universal_life|variable_universal_life|whole_life — 7 candidates stripped; promote to reference product]',
    `mandatory_fields_list` STRING COMMENT 'Comma-separated list of field names or identifiers that are mandatory for completion on this ACORD form. Used for validation during New Business (NB) processing and Not In Good Order (NIGO) tracking.',
    `nigo_tracking_enabled_flag` BOOLEAN COMMENT 'Indicates whether this ACORD form is subject to Not In Good Order (NIGO) tracking during New Business (NB) application processing. True if incomplete or incorrect submissions should be flagged for follow-up.',
    `page_count` STRING COMMENT 'The number of pages in the standard ACORD form template. Used for document imaging validation and completeness checks.',
    `regulatory_approval_number` STRING COMMENT 'The approval or filing number assigned by the state Department of Insurance (DOI) or regulatory body for this ACORD form version. Used for regulatory compliance tracking.',
    `retention_period_years` STRING COMMENT 'The number of years this ACORD form must be retained per state Department of Insurance (DOI) requirements and company retention policies. Used for document lifecycle management and compliance.',
    `state_specific_flag` BOOLEAN COMMENT 'Indicates whether this ACORD form has state-specific variants or modifications required by individual state Departments of Insurance. True if state-specific versions exist, False if the form is uniform across all jurisdictions.',
    `superseded_by_form_number` STRING COMMENT 'The ACORD form number that supersedes or replaces this form version. Populated when a form is deprecated or superseded by a newer version.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this ACORD form record was last updated or modified in the reference catalog system.',
    CONSTRAINT pk_acord_form PRIMARY KEY(`acord_form_id`)
) COMMENT 'Reference catalog of all ACORD standard forms applicable to life and annuity insurance operations. Captures ACORD form number (e.g., ACORD 103, ACORD 301), form name, form version, applicable line of business (life, annuity, DI, LTC), form purpose (application, change request, claim, beneficiary designation), state-specific variant flag, mandatory fields list, and effective/expiration dates. Serves as the authoritative reference for form validation during NB processing and document indexing.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`document`.`signature` (
    `signature_id` BIGINT COMMENT 'Unique identifier for the document signature event. Primary key.',
    `annuitant_id` BIGINT COMMENT 'Foreign key linking to policyholder.annuitant. Business justification: Annuitants sign annuity-specific documents (payout elections, beneficiary designations, RMD acknowledgments). Business tracks annuitant signatures for contract administration and regulatory compliance',
    `annuity_contract_id` BIGINT COMMENT 'Foreign key linking to annuity.annuity_contract. Business justification: Signature tracking for annuity-specific documents (applications, rider elections, beneficiary designations, annuitization forms) requires contract context for compliance reporting, e-signature audit t',
    `claim_id` BIGINT COMMENT 'Foreign key linking to claims.claim. Business justification: Claim settlement documents, releases, and payment authorizations require signatures. Claim payment cannot be issued without signed release forms. Links signature records to specific claims for payment',
    `claimant_id` BIGINT COMMENT 'Foreign key linking to claims.claimant. Business justification: Claimants must sign claim forms, beneficiary verification documents, and settlement agreements. Required for tracking which specific claimant signed payment authorization and release forms for multi-b',
    `document_id` BIGINT COMMENT 'Reference to the insurance document being signed (policy contract, application, APS, beneficiary change form, rider document, etc.).',
    `employee_id` BIGINT COMMENT 'Reference to the internal user who voided the signature. Null if signature was not voided.',
    `group_member_id` BIGINT COMMENT 'Foreign key linking to policyholder.group_member. Business justification: Group members sign member-specific documents (enrollment forms, EOI applications, beneficiary designations). Business tracks signatures by member for group policy administration and guaranteed issue l',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the policy associated with this signature event, if applicable.',
    `party_id` BIGINT COMMENT 'Reference to the party (person or organization) who executed the signature.',
    `audit_trail_url` STRING COMMENT 'The URL or file path to the complete audit trail document generated by the e-signature platform, containing all signature events, timestamps, and authentication details.',
    `authentication_method` STRING COMMENT 'The method used to authenticate the signers identity before signature execution (email verification, SMS code, knowledge-based authentication, biometric, multi-factor authentication, or none for wet ink).. Valid values are `email|sms|knowledge_based|biometric|multi_factor|none`',
    `certificate_reference` STRING COMMENT 'The unique identifier of the digital certificate used for certificate-based digital signatures. Null for non-certificate-based signatures.',
    `consent_timestamp` TIMESTAMP COMMENT 'The date and time when the signer provided consent to use electronic signatures.',
    `consent_to_electronic_signature` BOOLEAN COMMENT 'Indicates whether the signer provided explicit consent to use electronic signatures as required by ESIGN Act Section 101(c). True if consent was given, False otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this signature record was first created in the system.',
    `decline_reason` STRING COMMENT 'The reason provided by the signer for declining to sign the document. Null if signature was not declined.',
    `device_type` STRING COMMENT 'The type of device used to execute the e-signature (e.g., desktop, mobile, tablet, signature pad). Null for wet ink signatures.',
    `esignature_platform` STRING COMMENT 'The e-signature platform or vendor used to capture the electronic signature (e.g., DocuSign, Adobe Sign, OneSpan, Silanis, internal platform). Null for wet ink signatures.',
    `expiration_timestamp` TIMESTAMP COMMENT 'The date and time when the signature request expires if not completed. Used to enforce time-bound signature workflows.',
    `geolocation_latitude` DECIMAL(18,2) COMMENT 'The latitude coordinate where the e-signature was executed, if captured by the platform. Used for compliance and fraud detection.',
    `geolocation_longitude` DECIMAL(18,2) COMMENT 'The longitude coordinate where the e-signature was executed, if captured by the platform. Used for compliance and fraud detection.',
    `image_url` STRING COMMENT 'The URL or file path to the stored signature image (scanned wet ink or captured electronic signature graphic). Used for document imaging and audit purposes.',
    `ip_address` STRING COMMENT 'The IP address from which the e-signature was executed. Used for audit trail and fraud detection. Null for wet ink signatures.',
    `legal_validity_flag` BOOLEAN COMMENT 'Indicates whether the signature meets legal validity requirements per applicable state e-signature laws (ESIGN Act, UETA) and internal compliance rules. True if valid, False if deficient.',
    `notary_commission_number` STRING COMMENT 'The commission number of the notary public who notarized the signature, if applicable. Required for certain policy types and beneficiary changes.',
    `notary_expiration_date` DATE COMMENT 'The expiration date of the notary publics commission. Used to validate that the notarization was performed by a currently commissioned notary.',
    `notary_state` STRING COMMENT 'The two-letter US state code where the notary public is commissioned (e.g., CA, NY, TX). Null if signature was not notarized.',
    `reminder_count` STRING COMMENT 'The number of reminder notifications sent to the signer before the signature was completed or expired. Used for workflow analytics.',
    `request_sent_timestamp` TIMESTAMP COMMENT 'The date and time when the signature request was sent to the signer (for e-signature workflows). Null for wet ink signatures.',
    `sequence` STRING COMMENT 'The order in which this signature was required or executed within a multi-party signing workflow (e.g., 1 for applicant, 2 for agent, 3 for witness).',
    `signature_method` STRING COMMENT 'The method used to capture the signature: wet ink (physical), electronic (e-signature platform), digital (certificate-based), biometric (fingerprint/retina), or voice.. Valid values are `wet_ink|electronic|digital|biometric|voice`',
    `signature_status` STRING COMMENT 'Current status of the signature event: pending (awaiting signature), completed (signed), declined (signer refused), expired (signature request timed out), voided (signature invalidated), or revoked (signature withdrawn).. Valid values are `pending|completed|declined|expired|voided|revoked`',
    `signature_timestamp` TIMESTAMP COMMENT 'The date and time when the signature was executed. For e-signatures, this is the platform-recorded timestamp. For wet ink, this is the date written on the document or the date received.',
    `signer_full_name` STRING COMMENT 'The full legal name of the individual or authorized representative who signed the document.',
    `signer_role` STRING COMMENT 'The capacity in which the signer executed the signature (applicant, policy owner, insured, beneficiary, agent, witness, notary, guardian, trustee, or power of attorney). [ENUM-REF-CANDIDATE: applicant|owner|insured|beneficiary|agent|witness|notary|guardian|trustee|power_of_attorney — 10 candidates stripped; promote to reference product]',
    `state_jurisdiction` STRING COMMENT 'The two-letter US state code representing the jurisdiction whose e-signature laws govern this signature event (e.g., CA, NY, TX). Critical for compliance with state-specific UETA adoptions.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this signature record was last modified.',
    `user_agent` STRING COMMENT 'The browser or application user agent string captured during e-signature execution. Used for audit and security analysis.',
    `voided_reason` STRING COMMENT 'The reason why the signature was voided or invalidated after execution. Null if signature was not voided.',
    `voided_timestamp` TIMESTAMP COMMENT 'The date and time when the signature was voided. Null if signature was not voided.',
    `witness_name` STRING COMMENT 'The full name of the witness who observed the signature execution, if a witness was required. Null if no witness was present.',
    `witness_signature_timestamp` TIMESTAMP COMMENT 'The date and time when the witness signed to attest to the signature execution. Null if no witness was present.',
    CONSTRAINT pk_signature PRIMARY KEY(`signature_id`)
) COMMENT 'Tracks all signature events associated with insurance documents, supporting both wet ink and electronic signatures (e-signature). Captures signer identity, signer role (applicant, owner, insured, agent, witness, notary), signature method (wet, DocuSign, Adobe Sign, in-person electronic), signature timestamp, IP address for e-signatures, geographic location, signature status (pending, completed, declined, expired), and legal validity flags per state e-signature laws (ESIGN Act, UETA). Critical for policy issuance and beneficiary change compliance.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`document`.`access_log` (
    `access_log_id` BIGINT COMMENT 'Primary key for access_log',
    `claim_investigation_id` BIGINT COMMENT 'Foreign key linking to claims.claim_investigation. Business justification: SIU and fraud investigations require audit trails of who accessed investigation documents. Regulatory and legal requirement for documenting investigation document access, especially for contested clai',
    `contestability_review_id` BIGINT COMMENT 'Foreign key linking to claims.contestability_review. Business justification: Contestability reviews involve sensitive medical and application documents requiring access audit trails. Compliance requirement to track who reviewed contestability evidence, especially for rescissio',
    `document_id` BIGINT COMMENT 'Identifier of the insurance document that was accessed. Links to the document master record.',
    `employee_id` BIGINT COMMENT 'System user identifier of the individual who accessed the document. May be employee ID, agent ID, or policyholder ID depending on access channel.',
    `incident_id` BIGINT COMMENT 'Identifier of the security incident record if this access was part of an investigated incident. Null if no incident was created.',
    `legal_hold_id` BIGINT COMMENT 'Foreign key linking to document.legal_hold. Business justification: Access to documents under legal hold should be tracked with reference to the hold order for audit trail and compliance. Many access events can relate to one legal hold (N:1). Critical for legal hold c',
    `package_id` BIGINT COMMENT 'Foreign key linking to document.document_package. Business justification: Access logs can track access to entire packages (e.g., viewing a new business package in a workflow system, downloading an annual statement package). Many access events for one package (N:1). Extends ',
    `party_id` BIGINT COMMENT 'Foreign key linking to policyholder.party. Business justification: HIPAA and state privacy regulations require tracking which partys PHI/PII was accessed. Business uses for audit trails, breach investigations, and regulatory reporting to DOI/HHS.',
    `access_authorized_flag` BOOLEAN COMMENT 'Indicates whether the access was authorized based on role-based access control rules. False indicates potential security violation requiring investigation.',
    `access_channel` STRING COMMENT 'Channel or interface through which the document was accessed. Identifies the system or platform used for the access event. [ENUM-REF-CANDIDATE: agent_portal|policyholder_portal|internal_system|mobile_app|api|email|fax|mail — 8 candidates stripped; promote to reference product]',
    `access_denied_reason` STRING COMMENT 'Reason code or description if access was denied. Null if access was granted. Used for security monitoring and access control tuning.',
    `access_device_type` STRING COMMENT 'Type of device used to access the document. Supports device-based security policies and fraud detection.. Valid values are `desktop|laptop|tablet|mobile|server|automated_system`',
    `access_duration_seconds` STRING COMMENT 'Duration in seconds that the document was accessed or viewed. Used to distinguish between meaningful review and cursory access.',
    `access_timestamp` TIMESTAMP COMMENT 'Precise date and time when the document access event occurred. Critical for audit trail and compliance reporting.',
    `access_type` STRING COMMENT 'Type of access action performed on the document. Distinguishes between read-only and modification operations for security and compliance tracking.. Valid values are `view|download|print|share|edit|delete`',
    `accessor_name` STRING COMMENT 'Full name of the individual who accessed the document. Used for human-readable audit reports and compliance investigations.',
    `accessor_role` STRING COMMENT 'Business role or function of the individual accessing the document. Used to validate access authorization and segregation of duties. [ENUM-REF-CANDIDATE: underwriter|claims_adjuster|agent|broker|policyholder|beneficiary|customer_service_rep|compliance_officer|actuary|auditor|system_admin|third_party_administrator — 12 candidates stripped; promote to reference product]',
    `anomaly_score` DECIMAL(18,2) COMMENT 'Machine learning-derived anomaly score (0-100) indicating likelihood that access represents unusual or suspicious behavior. Higher scores trigger security review.',
    `audit_trail_retention_years` STRING COMMENT 'Number of years this access log record must be retained per regulatory requirements. Varies by document type and jurisdiction.',
    `business_justification_code` STRING COMMENT 'Standardized code indicating the business reason for accessing the document. Required for HIPAA minimum necessary standard and SOX access control compliance. [ENUM-REF-CANDIDATE: policy_servicing|claims_processing|underwriting_review|compliance_audit|customer_inquiry|regulatory_examination|litigation_support|actuarial_analysis|reinsurance_reporting|quality_assurance — 10 candidates stripped; promote to reference product]',
    `claim_number` STRING COMMENT 'Claim number associated with the accessed document, if applicable. Used for claims-specific audit trails and fraud investigation.',
    `consent_date` DATE COMMENT 'Date when consent or authorization for access was obtained. Used to validate that consent was current at time of access.',
    `consent_on_file_flag` BOOLEAN COMMENT 'Indicates whether valid consent or authorization was on file at the time of access. Critical for HIPAA compliance when accessing PHI.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where access originated. Used for international data transfer compliance and sanctions screening.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this access log record was created in the data warehouse. Used for data lineage and audit trail integrity.',
    `document_classification` STRING COMMENT 'Data classification level of the accessed document. Used to validate that accessor has appropriate clearance level.. Valid values are `public|internal|confidential|restricted`',
    `document_type` STRING COMMENT 'Classification of the document accessed (e.g., policy contract, APS, application, illustration, beneficiary form). Denormalized for reporting efficiency.',
    `download_flag` BOOLEAN COMMENT 'Indicates whether the document was downloaded to local storage. True indicates higher risk event requiring enhanced monitoring.',
    `geographic_location` STRING COMMENT 'Geographic location (city, state, country) derived from IP address. Used for cross-border data transfer compliance and fraud detection.',
    `hipaa_protected_flag` BOOLEAN COMMENT 'Indicates whether the accessed document contains Protected Health Information (PHI) subject to HIPAA privacy and security rules. True if document is APS, medical records, or disability claim documentation.',
    `ip_address` STRING COMMENT 'IP address from which the document access originated. Used for security monitoring, fraud detection, and geographic access analysis.',
    `pages_accessed` STRING COMMENT 'Number of pages accessed or viewed within the document. Used for usage analytics and to detect anomalous access patterns.',
    `policy_number` STRING COMMENT 'Insurance policy number associated with the accessed document. Enables policy-level access pattern analysis and audit reporting.',
    `print_flag` BOOLEAN COMMENT 'Indicates whether the document was printed. Used to track physical document distribution and data loss prevention.',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Indicates whether this access event must be included in regulatory audit reports or breach notifications. True for unauthorized PHI access or data breach events.',
    `security_incident_flag` BOOLEAN COMMENT 'Indicates whether this access event was flagged as a potential security incident requiring investigation. True triggers incident response workflow.',
    `session_code` STRING COMMENT 'Unique identifier for the user session during which the access occurred. Enables correlation of multiple access events within a single session.',
    `share_recipient_email` STRING COMMENT 'Email address of recipient if document was shared electronically. Null if not shared. Used for data distribution tracking and breach investigation.',
    `state_code` STRING COMMENT 'Two-letter US state code where access originated. Used for state-specific regulatory reporting and compliance monitoring.',
    CONSTRAINT pk_access_log PRIMARY KEY(`access_log_id`)
) COMMENT 'Business audit record of every access, view, download, or print event for a controlled insurance document. Captures accessor identity, accessor role, access type (view, download, print, share, edit), access timestamp, access channel (agent portal, policyholder portal, internal system, API), business justification code, and IP address. Supports HIPAA access audit requirements for APS and medical records, SOX document control requirements, and state DOI examination readiness.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`document`.`workflow` (
    `workflow_id` BIGINT COMMENT 'Unique identifier for the document workflow instance. Primary key.',
    `appeal_id` BIGINT COMMENT 'Foreign key linking to claims.appeal. Business justification: Appeal documents have specific workflow requirements including appeal deadlines and review committee routing. Appeal document processing has regulatory SLA requirements distinct from standard claim wo',
    `application_id` BIGINT COMMENT 'Reference to the new business application associated with this document workflow, if applicable.',
    `claim_id` BIGINT COMMENT 'Reference to the insurance claim associated with this document workflow, if applicable.',
    `claim_investigation_id` BIGINT COMMENT 'Foreign key linking to claims.claim_investigation. Business justification: Investigation documents (APS, field reports, SIU findings) require workflow tracking separate from general claim workflow. SIU document processing has distinct SLA and routing requirements for fraud i',
    `close_task_id` BIGINT COMMENT 'Foreign key linking to reporting.close_task. Business justification: Document processing workflows (imaging, indexing, quality control of policy files) are tracked as close tasks during financial close. Real business process: quarter-end close requires completion of do',
    `document_id` BIGINT COMMENT 'Reference to the document being processed through this workflow.',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the insurance policy associated with this document workflow, if applicable.',
    `org_unit_id` BIGINT COMMENT 'Reference to the team or department currently responsible for this workflow instance.',
    `package_id` BIGINT COMMENT 'Foreign key linking to document.document_package. Business justification: Workflows can process entire packages (e.g., new business package workflow, annual review package workflow). Document_workflow currently only links to individual documents. Many workflows can process ',
    `party_id` BIGINT COMMENT 'Reference to the policyholder or customer associated with this document workflow.',
    `producer_id` BIGINT COMMENT 'Reference to the agent or producer who submitted or is associated with this document workflow.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Document workflows often involve vendor-provided documents requiring special routing, quality control, or SLA tracking (exam results workflow, TPA claims documentation workflow, vendor imaging batch w',
    `employee_id` BIGINT COMMENT 'Reference to the user who created this workflow record in the system.',
    `workflow_employee_id` BIGINT COMMENT 'Reference to the user currently responsible for processing this workflow instance.',
    `workflow_operator_employee_id` BIGINT COMMENT 'Reference to the operator or technician who performed imaging or scanning operations for this workflow.',
    `workflow_quality_control_reviewer_employee_id` BIGINT COMMENT 'Reference to the user who performed the quality control review of this workflow instance.',
    `workflow_updated_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last updated this workflow record.',
    `assigned_queue` STRING COMMENT 'The work queue to which this workflow instance is currently assigned for processing (e.g., underwriting queue, claims review queue, imaging queue).',
    `completed_timestamp` TIMESTAMP COMMENT 'The date and time when the workflow instance reached its final completion state.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this workflow record was first created in the system.',
    `current_stage` STRING COMMENT 'The specific stage or step within the workflow where the document currently resides (e.g., initial review, medical underwriting, final approval, imaging, indexing).',
    `entry_timestamp` TIMESTAMP COMMENT 'The date and time when the document entered the current workflow stage.',
    `error_count` STRING COMMENT 'The number of errors encountered during the processing of this workflow instance, including imaging errors, validation errors, and system errors.',
    `escalation_level` STRING COMMENT 'Numeric indicator of how many times this workflow has been escalated to higher authority or priority (0 = no escalation, 1+ = escalated).',
    `escalation_reason` STRING COMMENT 'Business reason or justification for the most recent escalation of this workflow instance.',
    `external_reference_number` STRING COMMENT 'Reference identifier from an external system or third party associated with this workflow (e.g., vendor tracking number, regulatory filing number).',
    `imaging_batch_number` BIGINT COMMENT 'Reference to the imaging batch in which this document was scanned and processed, if applicable to imaging workflows.',
    `imaging_system_reference` STRING COMMENT 'External reference identifier from the document imaging system (e.g., OnBase, FileNet) used for cross-system reconciliation.',
    `initiated_timestamp` TIMESTAMP COMMENT 'The date and time when the workflow instance was first created and initiated.',
    `nigo_date` DATE COMMENT 'The date when the document was identified as NIGO and processing was suspended pending additional information.',
    `nigo_flag` BOOLEAN COMMENT 'Indicator that the document or application is incomplete or missing required information, preventing further processing.',
    `nigo_reason` STRING COMMENT 'Detailed explanation of why the document was flagged as NIGO, including specific missing items or deficiencies.',
    `notes` STRING COMMENT 'Free-text notes and comments added by processors, reviewers, or system users regarding this workflow instance.',
    `prior_stage` STRING COMMENT 'The immediately preceding stage in the workflow, used for tracking progression and enabling rollback if needed.',
    `priority_level` STRING COMMENT 'The business priority assigned to this workflow instance, determining processing sequence and resource allocation.. Valid values are `low|normal|high|urgent|critical`',
    `quality_control_status` STRING COMMENT 'The outcome of quality control review for imaging and indexing accuracy, indicating whether the work meets quality standards.. Valid values are `pending|passed|failed|waived|not_required`',
    `quality_control_timestamp` TIMESTAMP COMMENT 'The date and time when quality control review was completed for this workflow instance.',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicator of whether the workflow has exceeded its SLA due date without completion.',
    `sla_breach_timestamp` TIMESTAMP COMMENT 'The date and time when the SLA breach occurred (when the workflow exceeded its due date).',
    `sla_due_date` DATE COMMENT 'The target date by which this workflow instance must be completed to meet service level agreement commitments.',
    `source_channel` STRING COMMENT 'The origination channel through which the document entered the system (e.g., mail room, fax, scan station, digital upload, email). [ENUM-REF-CANDIDATE: mail_room|fax|scan_station|digital_upload|email|portal|mobile_app|api|edi — 9 candidates stripped; promote to reference product]',
    `total_documents_indexed` STRING COMMENT 'The total number of individual documents indexed within this workflow instance (a single workflow may contain multiple documents).',
    `total_pages_scanned` STRING COMMENT 'The total number of pages scanned during the imaging process for this document workflow.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this workflow record was last modified or updated.',
    `workflow_number` STRING COMMENT 'Business-facing unique identifier for the workflow instance, used for tracking and reference.',
    `workflow_status` STRING COMMENT 'Current lifecycle status of the workflow instance indicating its position in the processing pipeline. [ENUM-REF-CANDIDATE: initiated|in_progress|pending_review|approved|rejected|on_hold|escalated|completed|cancelled|archived — 10 candidates stripped; promote to reference product]',
    `workflow_type` STRING COMMENT 'Classification of the workflow based on the business process it supports (e.g., new business processing, claims document review, policy servicing, regulatory filing). [ENUM-REF-CANDIDATE: new_business_processing|claims_document_review|policy_servicing|regulatory_filing|underwriting_review|annuity_processing|reinsurance_submission|imaging_indexing|quality_control|exception_handling — 10 candidates stripped; promote to reference product]',
    CONSTRAINT pk_workflow PRIMARY KEY(`workflow_id`)
) COMMENT 'Operational record tracking the routing, approval, and processing workflow state of a document through its business lifecycle — from receipt or generation through review, approval, issuance, and archival. Captures current workflow stage, workflow type (NB processing, claims document review, policy servicing, regulatory filing), assigned queue, assigned user/team, entry timestamp, SLA due date, SLA breach flag, escalation level, prior stage history, and workflow completion status. For imaging/indexing workflows, additionally captures source channel (mail room, fax, scan station, digital upload, email), imaging batch reference, total pages scanned, total documents indexed, error count, operator ID, imaging system reference (e.g., OnBase, FileNet), quality control status, and batch completion timestamp. Unifies all document processing workflow tracking including imaging operations into a single operational entity.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`document`.`legal_hold` (
    `legal_hold_id` BIGINT COMMENT 'Unique identifier for the legal hold order. Primary key.',
    `claim_id` BIGINT COMMENT 'Foreign key linking to claims.claim. Business justification: Claims under litigation require legal holds on all related documents. Litigation hold management for claim-related documents prevents destruction during discovery and ensures regulatory compliance for',
    `claim_investigation_id` BIGINT COMMENT 'Foreign key linking to claims.claim_investigation. Business justification: Fraud investigations and SIU cases often trigger legal holds. Preservation of investigation documents required for potential criminal referrals, rescission litigation, or state DOI investigations ensu',
    `employee_id` BIGINT COMMENT 'User identifier of the individual who created the legal hold record in the system.',
    `report_definition_id` BIGINT COMMENT 'Foreign key linking to reporting.report_definition. Business justification: Legal holds suspend automated purging of specific report types. Real business process: litigation discovery or regulatory examination requires preserving all instances of specific financial reports (e',
    `superseded_by_hold_legal_hold_id` BIGINT COMMENT 'Reference to a subsequent legal hold order that supersedes this hold, used when scope or requirements are modified.',
    `acknowledgment_count` STRING COMMENT 'Number of custodians and business units who have acknowledged receipt and understanding of the legal hold order.',
    `acknowledgment_required_flag` BOOLEAN COMMENT 'Indicator that custodians and business units must formally acknowledge receipt and understanding of the legal hold order.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual total cost in USD incurred for implementing and maintaining the legal hold through release date.',
    `affected_claim_count` STRING COMMENT 'Number of insurance claims whose related documents and records are subject to the legal hold.',
    `affected_document_count` STRING COMMENT 'Total number of documents, records, and data objects identified as subject to the legal hold preservation requirements.',
    `affected_policy_count` STRING COMMENT 'Number of insurance policies whose related documents and records are subject to the legal hold.',
    `automated_purge_suspended_flag` BOOLEAN COMMENT 'Indicator that automated document destruction and purge jobs have been suspended for all records within the legal hold scope.',
    `chain_of_custody_log` STRING COMMENT 'Chronological record of all transfers, access events, and custody changes for documents subject to the legal hold to maintain evidentiary integrity.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the legal hold record was first created in the system.',
    `custodian_of_record` STRING COMMENT 'Name and department of the individual or business unit responsible for maintaining custody and chain of custody for documents subject to the legal hold.',
    `date_range_end` DATE COMMENT 'Ending date of the time period for which documents and records are subject to preservation under the legal hold, nullable for ongoing matters.',
    `date_range_start` DATE COMMENT 'Beginning date of the time period for which documents and records are subject to preservation under the legal hold.',
    `document_type_scope` STRING COMMENT 'Comma-separated list of document types subject to the legal hold, such as policy contracts, applications, APS records, claim correspondence, underwriting files, emails, and internal memoranda.',
    `effective_date` DATE COMMENT 'Date when the legal hold order becomes effective and preservation requirements begin, overriding standard retention schedules.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Estimated total cost in USD for implementing and maintaining the legal hold, including storage, labor, and technology costs.',
    `expiration_date` DATE COMMENT 'Scheduled date for legal hold review or automatic expiration if not renewed, nullable for indefinite holds pending litigation resolution.',
    `external_counsel_firm` STRING COMMENT 'Name of the external law firm representing the company in the matter that triggered the legal hold.',
    `hold_number` STRING COMMENT 'Business identifier for the legal hold order, formatted as LH-YYYYMMDD followed by sequence number for external reference and tracking.. Valid values are `^LH-[0-9]{8}$`',
    `hold_status` STRING COMMENT 'Current lifecycle status of the legal hold order indicating whether preservation requirements are in effect.. Valid values are `active|pending review|released|expired|superseded`',
    `hold_type` STRING COMMENT 'Classification of the legal hold based on the triggering event or investigation type.. Valid values are `litigation|regulatory examination|market conduct investigation|fraud investigation|internal audit|compliance review`',
    `issuing_authority` STRING COMMENT 'Name and title of the individual or entity that issued the legal hold order, typically general counsel, compliance officer, or external regulator.',
    `issuing_authority_type` STRING COMMENT 'Classification of the entity that issued the legal hold to determine authority level and response protocols.. Valid values are `internal legal counsel|external legal counsel|compliance officer|state regulator|federal regulator|court order`',
    `last_review_date` DATE COMMENT 'Date of the most recent periodic review of the legal hold order to confirm continued necessity and scope accuracy.',
    `matter_name` STRING COMMENT 'Name or title of the litigation, regulatory examination, or investigation that triggered the legal hold for tracking and reference purposes.',
    `matter_number` STRING COMMENT 'External case number, docket number, or examination reference number assigned by court, regulator, or internal legal department.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of the legal hold order.',
    `notes` STRING COMMENT 'Free-form notes and comments regarding the legal hold, including special instructions, scope clarifications, and status updates.',
    `notification_sent_date` DATE COMMENT 'Date when legal hold notification was sent to custodians, business units, and IT systems to initiate preservation protocols.',
    `priority_level` STRING COMMENT 'Priority classification for the legal hold indicating urgency and resource allocation requirements for preservation and response activities.. Valid values are `critical|high|medium|low`',
    `regulatory_jurisdiction` STRING COMMENT 'State or federal jurisdiction under whose authority the legal hold was issued, relevant for multi-state regulatory examinations.',
    `release_authorized_by` STRING COMMENT 'Name and title of the individual who authorized the release of the legal hold, typically general counsel or compliance officer confirming litigation or investigation closure.',
    `release_date` DATE COMMENT 'Actual date when the legal hold was formally released and standard retention schedules resume, populated only when hold_status transitions to released.',
    `retention_override_flag` BOOLEAN COMMENT 'Indicator that this legal hold overrides standard retention schedules and suspends automated purge jobs for affected documents.',
    `review_frequency_days` STRING COMMENT 'Number of days between periodic reviews of the legal hold to assess continued necessity and scope accuracy.',
    `scope_description` STRING COMMENT 'Detailed narrative describing the scope of documents and records subject to the legal hold, including date ranges, policy numbers, claim numbers, parties involved, and document types.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the legal hold record was last modified.',
    CONSTRAINT pk_legal_hold PRIMARY KEY(`legal_hold_id`)
) COMMENT 'Master record of legal hold orders placed on documents and records to preserve them beyond their standard retention schedule in anticipation of litigation, regulatory examination, or market conduct investigation. Captures hold type (litigation, regulatory, market conduct, fraud investigation), issuing authority (legal counsel, compliance officer, regulator), hold effective date, hold expiration or review date, scope description, affected document references, custodian of record, hold release authorization, and chain of custody log. Overrides retention_schedule destruction rules for all affected records and triggers suspension of automated purge jobs. Required for litigation readiness and regulatory examination response.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`document`.`template` (
    `template_id` BIGINT COMMENT 'Unique identifier for the document template record. Primary key.',
    `acord_form_id` BIGINT COMMENT 'Foreign key linking to document.acord_form. Business justification: Some document templates are based on ACORD standard forms. The template implements the ACORD form specification. Many templates can implement one ACORD form (N:1). Links operational template library t',
    `superseded_by_template_id` BIGINT COMMENT 'Reference to the newer template version that replaces this template when it becomes deprecated.',
    `acord_form_indicator` BOOLEAN COMMENT 'Indicates whether this template is based on or complies with an ACORD standard form.',
    `aml_kyc_required_flag` BOOLEAN COMMENT 'Indicates whether documents generated from this template are used for AML/KYC compliance verification processes.',
    `applicable_jurisdictions` STRING COMMENT 'Comma-separated list of state or jurisdiction codes (two-letter abbreviations) where this template is approved for use.',
    `approval_authority` STRING COMMENT 'Name or role of the business unit or individual authorized to approve this template for production use.',
    `approval_date` DATE COMMENT 'Date on which internal business approval was granted for this template version.',
    `authoring_system` STRING COMMENT 'Name of the system or platform used to create and maintain this template (e.g., Policy Administration System, Document Composition Engine).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this template record was first created in the system.',
    `doi_approval_date` DATE COMMENT 'Date on which the Department of Insurance granted approval for this template.',
    `doi_approval_number` STRING COMMENT 'Official approval or filing number assigned by the Department of Insurance for tracking regulatory compliance.',
    `doi_approval_status` STRING COMMENT 'Current regulatory approval status from the Department of Insurance for jurisdictions requiring pre-approval.. Valid values are `not_required|pending|approved|conditionally_approved|rejected|withdrawn`',
    `e_delivery_eligible_flag` BOOLEAN COMMENT 'Indicates whether documents generated from this template are eligible for electronic delivery to policyholders.',
    `effective_date` DATE COMMENT 'Date from which this template version becomes active and available for document generation.',
    `electronic_signature_allowed_flag` BOOLEAN COMMENT 'Indicates whether documents generated from this template support electronic signature capture and validation.',
    `expiration_date` DATE COMMENT 'Date after which this template version is no longer valid for new document generation.',
    `file_path` STRING COMMENT 'Storage location or URL reference to the physical template file in the document management system.',
    `format` STRING COMMENT 'Technical file format of the template used for document generation and rendering.. Valid values are `word|pdf|xml|xslt|html|rtf`',
    `generation_engine` STRING COMMENT 'Name of the document generation engine or service that processes this template to produce final documents.',
    `language_code` STRING COMMENT 'ISO 639-1 language code (with optional ISO 3166-1 country code) indicating the primary language of the template content.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `last_review_date` DATE COMMENT 'Date of the most recent periodic review of this template for accuracy, compliance, and relevance.',
    `line_of_business` STRING COMMENT 'Insurance product line for which this template is designed and approved. [ENUM-REF-CANDIDATE: life|annuity|disability|long_term_care|variable_life|variable_annuity|group_life — 7 candidates stripped; promote to reference product]',
    `mandatory_fields_list` STRING COMMENT 'Comma-separated list of data field names that must be populated for successful document generation from this template.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this template.',
    `nigo_tracking_enabled_flag` BOOLEAN COMMENT 'Indicates whether documents generated from this template are subject to NIGO tracking for incomplete or deficient submissions.',
    `page_count` STRING COMMENT 'Typical or maximum number of pages in documents generated from this template.',
    `pii_phi_indicator` BOOLEAN COMMENT 'Indicates whether documents generated from this template contain PII or PHI requiring special handling and protection.',
    `privacy_classification` STRING COMMENT 'Data classification level of documents generated from this template based on sensitivity of content.. Valid values are `public|internal|confidential|restricted`',
    `product_type_applicability` STRING COMMENT 'Comma-separated list of specific product types (WL, UL, IUL, VUL, Term, SPIA, FIA) for which this template is applicable.',
    `regulatory_approval_required_flag` BOOLEAN COMMENT 'Indicates whether this template requires explicit Department of Insurance (DOI) approval before use.',
    `retention_period_years` STRING COMMENT 'Number of years that documents generated from this template must be retained per regulatory and business requirements.',
    `state_specific_flag` BOOLEAN COMMENT 'Indicates whether this template contains state-specific regulatory language or requirements.',
    `template_category` STRING COMMENT 'High-level classification of the template type indicating its primary business function. [ENUM-REF-CANDIDATE: policy_contract|illustration|disclosure|correspondence|application|claim_form|rider|endorsement — 8 candidates stripped; promote to reference product]',
    `template_code` STRING COMMENT 'Business identifier code for the template used for external reference and system integration.. Valid values are `^[A-Z0-9_-]{4,20}$`',
    `template_description` STRING COMMENT 'Detailed description of the templates purpose, usage context, and content structure.',
    `template_name` STRING COMMENT 'Human-readable name of the document template describing its purpose and content.',
    `template_status` STRING COMMENT 'Current lifecycle status of the template indicating its approval state and usability. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|active|inactive|deprecated|superseded — 7 candidates stripped; promote to reference product]',
    `template_type` STRING COMMENT 'Specific sub-classification within the template category providing granular template purpose identification. [ENUM-REF-CANDIDATE: policy_declaration|policy_schedule|benefit_summary|premium_notice|lapse_notice|reinstatement_form|beneficiary_change|APS_request|claim_proof|death_claim|surrender_form|1035_exchange|annual_statement|tax_reporting|compliance_disclosure — promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this template record was last modified.',
    `usage_count` BIGINT COMMENT 'Total number of documents generated from this template since its effective date, used for tracking template utilization.',
    `variable_data_fields_list` STRING COMMENT 'Comma-separated list of all variable data field placeholders embedded in the template that are dynamically populated during generation.',
    `version` STRING COMMENT 'Version number of the template following semantic versioning to track template evolution and changes.. Valid values are `^[0-9]{1,3}.[0-9]{1,3}(.[0-9]{1,3})?$`',
    CONSTRAINT pk_template PRIMARY KEY(`template_id`)
) COMMENT 'Master catalog of approved document templates used to generate standardized insurance documents — policy contract templates, illustration templates, disclosure templates, correspondence templates, and ACORD form templates. Captures template name, template version, applicable product types, state-specific variant flag, DOI approval status, effective date, expiration date, template format (Word, PDF, XML/XSLT), and the authoring system reference. Governs document generation consistency and regulatory form approval compliance.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`document`.`request` (
    `request_id` BIGINT COMMENT 'Unique identifier for the document request record. Primary key.',
    `acord_form_id` BIGINT COMMENT 'Foreign key linking to document.acord_form. Business justification: Document requests can specify a particular ACORD form needed (e.g., request ACORD 101 application). Many requests for one ACORD form (N:1). Specifies the exact form type requested. Document_request ',
    `annuitant_id` BIGINT COMMENT 'Foreign key linking to policyholder.annuitant. Business justification: Annuity operations request annuitant-specific documents (payout election forms, RMD certifications, beneficiary designations). Business tracks by annuitant for contract servicing and IRS compliance.',
    `annuity_contract_id` BIGINT COMMENT 'Foreign key linking to annuity.annuity_contract. Business justification: Document requests for annuity servicing (beneficiary changes, systematic withdrawals, annuitization elections, rider additions) must link to contract for fulfillment tracking, aging reports, and servi',
    `application_id` BIGINT COMMENT 'Reference to the new business application associated with this document request, if applicable.',
    `claim_id` BIGINT COMMENT 'Reference to the insurance claim associated with this document request, if applicable.',
    `evidence_requirement_id` BIGINT COMMENT 'Foreign key linking to underwriting.evidence_requirement. Business justification: Document requests are often triggered by specific evidence requirements (APS orders, exam scheduling, financial statement requests). Business process: evidence fulfillment tracking and NIGO resolution',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: When a document request is fulfilled, the resulting received document should be linked. E.g., APS request → received APS document. Tracks the fulfillment relationship. One request results in one docum',
    `group_member_id` BIGINT COMMENT 'Foreign key linking to policyholder.group_member. Business justification: Group operations request member-specific documents (EOI forms, beneficiary designations, portability elections). Business tracks by member certificate for group administration and coverage activation.',
    `group_sponsor_id` BIGINT COMMENT 'Foreign key linking to policyholder.group_sponsor. Business justification: Group operations request sponsor-specific documents (enrollment files, billing reconciliation, plan amendments, ERISA annual filings). Business tracks by sponsor for group administration and DOL compl',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the insurance policy associated with this document request, if applicable.',
    `insured_id` BIGINT COMMENT 'Foreign key linking to policyholder.insured. Business justification: Underwriting and policy administration request insured-specific documents (APS, medical records, attending physician statements). Business tracks by insured for multi-life policies and reinsurance rep',
    `package_id` BIGINT COMMENT 'Foreign key linking to document.document_package. Business justification: Document requests can be for entire packages (e.g., send me the full new business package, request annual statement package). Currently document_request only links to individual documents via busi',
    `party_id` BIGINT COMMENT 'Reference to the policyholder associated with this document request.',
    `policyholder_beneficiary_id` BIGINT COMMENT 'Foreign key linking to policyholder.policyholder_beneficiary. Business justification: Business requests beneficiary-specific documents (designation forms, tax forms W-9, payment instructions) for beneficiary administration and claims processing. Tracked by beneficiary for multi-benefic',
    `premium_bill_id` BIGINT COMMENT 'Foreign key linking to billing.premium_bill. Business justification: Document requests frequently ask for copies of specific billing statements or payment history for loan applications, divorce proceedings, tax purposes. Real business process: customer service fulfillm',
    `producer_id` BIGINT COMMENT 'Reference to the agent or broker associated with this document request, typically when requesting missing application materials from distribution.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Document requests frequently sent to vendors (medical records from attending physicians, exam scheduling with exam vendors, appraisal orders to appraisal vendors, claims documentation from TPAs). Core',
    `resubmitted_request_id` BIGINT COMMENT 'Self-referencing FK on request (resubmitted_request_id)',
    `acknowledgment_date` DATE COMMENT 'Date the recipient acknowledged receipt of the document request.',
    `aging_days` STRING COMMENT 'Number of calendar days elapsed since the request was sent, used for tracking outstanding requests and escalation triggers.',
    `business_transaction_type` STRING COMMENT 'Type of business transaction driving the document request. New_business = application processing, claim = claims adjudication, policy_service = policy maintenance, underwriting = risk assessment, annuity_service = annuity contract administration, reinsurance = reinsurance treaty management.. Valid values are `new_business|claim|policy_service|underwriting|annuity_service|reinsurance`',
    `cancellation_date` DATE COMMENT 'Date the document request was cancelled and removed from active tracking.',
    `cancellation_reason` STRING COMMENT 'Business reason for cancelling the document request, such as application withdrawn, claim denied, or document obtained through alternate channel.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time this document request record was first created in the system.',
    `delivery_method` STRING COMMENT 'Channel through which the document request was transmitted to the recipient.. Valid values are `email|fax|postal_mail|secure_portal|phone|in_person`',
    `due_date` DATE COMMENT 'Target date by which the requested document should be received to meet business processing Service Level Agreements (SLAs).',
    `external_reference_number` STRING COMMENT 'Reference identifier from an external system or third party, such as a Medical Information Bureau (MIB) request number or vendor tracking number.',
    `follow_up_count` STRING COMMENT 'Number of follow-up communications sent to the recipient regarding this document request.',
    `follow_up_schedule` STRING COMMENT 'Planned schedule for follow-up communications if the document is not received by the due date, typically expressed as intervals (e.g., 7 days, 14 days, 21 days).',
    `last_follow_up_date` DATE COMMENT 'Date of the most recent follow-up communication sent to the recipient regarding the outstanding document request.',
    `next_follow_up_date` DATE COMMENT 'Scheduled date for the next follow-up communication if the document remains outstanding.',
    `nigo_flag` BOOLEAN COMMENT 'Indicator that this document request is associated with a Not In Good Order (NIGO) case where the application or transaction cannot proceed due to missing or incomplete documentation. True = NIGO case, False = not NIGO.',
    `notes` STRING COMMENT 'Free-text field for additional context, special instructions, or communication history related to the document request.',
    `priority_level` STRING COMMENT 'Business priority assigned to the document request, influencing SLA targets and follow-up frequency. Urgent = same-day processing required, high = expedited processing, normal = standard processing, low = routine processing.. Valid values are `urgent|high|normal|low`',
    `received_date` DATE COMMENT 'Date the requested document was received by the company, completing the request lifecycle.',
    `recipient_address_line1` STRING COMMENT 'First line of the recipients mailing address for postal delivery of the document request.',
    `recipient_address_line2` STRING COMMENT 'Second line of the recipients mailing address, typically suite or department information.',
    `recipient_city` STRING COMMENT 'City of the recipients mailing address.',
    `recipient_email` STRING COMMENT 'Email address of the recipient for electronic delivery of the document request.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `recipient_fax` STRING COMMENT 'Fax number of the recipient for transmission of the document request, commonly used for APS requests to physicians.',
    `recipient_name` STRING COMMENT 'Name of the individual or organization to whom the document request is directed, such as a physician, agent, beneficiary, or third-party administrator.',
    `recipient_phone` STRING COMMENT 'Phone number of the recipient for follow-up communications regarding the document request.',
    `recipient_postal_code` STRING COMMENT 'Postal or ZIP code of the recipients mailing address.',
    `recipient_state` STRING COMMENT 'State or province code of the recipients mailing address, using standard two-letter abbreviations.',
    `recipient_type` STRING COMMENT 'Category of recipient to whom the document request is sent. TPA = Third Party Administrator. [ENUM-REF-CANDIDATE: physician|agent|beneficiary|policyholder|TPA|medical_facility|financial_institution — 7 candidates stripped; promote to reference product]',
    `request_date` DATE COMMENT 'Date the document request was initiated and prepared for transmission.',
    `request_number` STRING COMMENT 'Business-facing unique identifier for the document request, used for tracking and reference in communications with agents, physicians, and beneficiaries.',
    `request_status` STRING COMMENT 'Current status of the document request in its lifecycle. Sent = request transmitted to recipient, acknowledged = recipient confirmed receipt, received = requested document delivered, overdue = past due date without receipt, cancelled = request voided, pending = request prepared but not yet sent.. Valid values are `sent|acknowledged|received|overdue|cancelled|pending`',
    `request_type` STRING COMMENT 'Category of document being requested. APS = Attending Physician Statement, application_form = missing new business application forms, proof_of_loss = claim documentation, policy_replacement = replacement policy documents, beneficiary_form = beneficiary change forms, medical_records = additional medical documentation, financial_statement = financial underwriting documentation. [ENUM-REF-CANDIDATE: APS|application_form|proof_of_loss|policy_replacement|beneficiary_form|medical_records|financial_statement — 7 candidates stripped; promote to reference product]',
    `requested_document_type_code` STRING COMMENT 'Standardized code identifying the specific document type being requested, aligned with the document management taxonomy and ACORD form numbering where applicable.',
    `requestor_name` STRING COMMENT 'Name of the individual or department initiating the document request, typically an underwriter, claims examiner, or service representative.',
    `requestor_role` STRING COMMENT 'Business role of the individual initiating the document request.. Valid values are `underwriter|claims_examiner|service_representative|case_manager|compliance_officer|actuarial_analyst`',
    `sent_timestamp` TIMESTAMP COMMENT 'Date and time the document request was transmitted to the recipient via the selected delivery channel.',
    `sla_met_flag` BOOLEAN COMMENT 'Indicator of whether the document was received within the SLA target timeframe. True = SLA met, False = SLA breached.',
    `sla_target_days` STRING COMMENT 'Number of business days allocated for receipt of the requested document based on request type and priority level.',
    `source_system` STRING COMMENT 'Name of the operational system that originated the document request, such as Policy Administration System, Claims Management System, or Underwriting Workbench.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time this document request record was last modified.',
    CONSTRAINT pk_request PRIMARY KEY(`request_id`)
) COMMENT 'Operational record of outbound requests for documents needed to complete a business transaction — APS orders to physicians, requests for missing application forms from agents, requests for proof of loss from beneficiaries, and requests for replacement policy documents. Captures request type, requestor, recipient, requested document type, request date, due date, follow-up schedule, request status (sent, acknowledged, received, overdue, cancelled), and the business transaction driving the request (application, claim, policy service). Supports SLA tracking for outstanding document requests across NB, claims, and servicing workflows.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`document`.`correspondence_link` (
    `correspondence_link_id` BIGINT COMMENT 'Unique identifier for the correspondence-to-document association record. Primary key.',
    `annuity_contract_id` BIGINT COMMENT 'Foreign key reference to the annuity contract associated with this correspondence-document link. Enables direct navigation to the annuity context when the correspondence and document relate to a specific annuity contract.',
    `application_id` BIGINT COMMENT 'Foreign key reference to the new business application associated with this correspondence-document link. Enables direct navigation to the application context when the correspondence and document relate to a specific underwriting case.',
    `claim_id` BIGINT COMMENT 'Foreign key reference to the insurance claim associated with this correspondence-document link. Enables direct navigation to the claim context when the correspondence and document relate to a specific claim.',
    `communication_id` BIGINT COMMENT 'Foreign key reference to the originating correspondence communication record in the correspondence domain. Links this document artifact back to the communication event that generated or received it.',
    `document_id` BIGINT COMMENT 'Foreign key reference to the document record in the document domain. Identifies the specific document artifact associated with this correspondence event.',
    `in_force_policy_id` BIGINT COMMENT 'Foreign key reference to the insurance policy associated with this correspondence-document link. Enables direct navigation to the policy context when the correspondence and document relate to a specific policy.',
    `legal_hold_id` BIGINT COMMENT 'Foreign key reference to the legal hold record if this correspondence-document link is subject to litigation hold. Null if no legal hold applies.',
    `party_id` BIGINT COMMENT 'Foreign key reference to the policyholder or customer associated with this correspondence-document link. Enables direct navigation to the customer context when the correspondence and document relate to a specific individual or entity.',
    `employee_id` BIGINT COMMENT 'Identifier of the system user or automated process that created the correspondence-document association. Supports audit trail and accountability for link creation.',
    `producer_id` BIGINT COMMENT 'Foreign key reference to the insurance agent or producer associated with this correspondence-document link. Enables tracking of agent-related correspondence and documents for commission, compliance, and servicing purposes.',
    `superseded_correspondence_link_id` BIGINT COMMENT 'Self-referencing FK on correspondence_link (superseded_correspondence_link_id)',
    `attachment_flag` BOOLEAN COMMENT 'Indicates whether the document was physically attached to or embedded within the correspondence communication. True if the document was an attachment; false if the document is referenced or generated separately.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier or URL to the detailed audit trail log for this correspondence-document link. Supports compliance and forensic investigation by providing access to the complete history of actions taken on this association record.',
    `business_context` STRING COMMENT 'Free-text description of the business reason or context for the correspondence-document association. Provides additional narrative detail about why this document is linked to this correspondence event.',
    `confidentiality_level` STRING COMMENT 'Data classification level for this correspondence-document association. Public indicates no restrictions; internal indicates company-internal use only; confidential indicates sensitive business information; restricted indicates highly sensitive data requiring special handling.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this correspondence-document link record was first created in the system. Provides audit trail for record creation.',
    `direction` STRING COMMENT 'Indicates the direction of the correspondence flow. Inbound indicates the correspondence and document were received from an external party; outbound indicates the correspondence and document were sent to an external party.. Valid values are `inbound|outbound`',
    `legal_hold_flag` BOOLEAN COMMENT 'Indicates whether this correspondence-document link is subject to a legal hold order that prevents destruction or modification. True if under legal hold; false if normal retention rules apply.',
    `link_method` STRING COMMENT 'Describes how the correspondence-document association was established. Manual indicates user-initiated linking; automatic indicates system-generated linking based on business rules; batch indicates bulk linking process; API indicates linking via external system integration; workflow indicates linking as part of a business process workflow.. Valid values are `manual|automatic|batch|api|workflow`',
    `link_status` STRING COMMENT 'Current lifecycle status of the correspondence-document association. Active indicates the link is current and valid; inactive indicates the link has been deactivated; archived indicates the link is retained for historical purposes; deleted indicates the link has been logically removed; pending indicates the link is awaiting validation or approval.. Valid values are `active|inactive|archived|deleted|pending`',
    `link_type` STRING COMMENT 'Categorizes the nature of the relationship between the correspondence and the document. Generated indicates the correspondence produced the document; received indicates the document was received via the correspondence; attached indicates the document was included with the correspondence; referenced indicates the correspondence mentions the document; superseded indicates the correspondence replaces the document; related indicates a general association.. Valid values are `generated|received|attached|referenced|superseded|related`',
    `linked_by_system` STRING COMMENT 'Name or identifier of the source system or application that created the correspondence-document link. Examples include Policy Administration System, Claims Management System, CRM Platform, or Document Management System.',
    `linked_date` DATE COMMENT 'The business date when the document was associated with the correspondence event. May differ from the correspondence date or document creation date if the link was established retroactively.',
    `linked_timestamp` TIMESTAMP COMMENT 'The precise date and time when the document-correspondence association record was created in the system. Provides audit trail for when the linkage was established.',
    `notes` STRING COMMENT 'Free-form text field for additional comments, annotations, or contextual information about the correspondence-document association. Used by business users to capture details not covered by structured fields.',
    `primary_document_flag` BOOLEAN COMMENT 'Indicates whether this document is the primary or main document associated with the correspondence event. True if this is the principal document; false if this is a supporting or secondary document.',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Indicates whether this correspondence-document link represents a communication or document that must be reported to regulatory authorities such as state Departments of Insurance (DOI), Securities and Exchange Commission (SEC), or Financial Industry Regulatory Authority (FINRA). True if reportable; false otherwise.',
    `retention_end_date` DATE COMMENT 'The date when this correspondence-document link and its associated records are eligible for purging or archival based on retention policies. Calculated from the linked date plus applicable retention period, unless overridden by legal hold.',
    `retention_override_flag` BOOLEAN COMMENT 'Indicates whether the standard document retention schedule has been overridden for this correspondence-document link due to legal hold, regulatory investigation, or other special circumstances. True if retention rules are overridden; false if standard retention applies.',
    `sequence_number` STRING COMMENT 'Ordinal position of this document within the correspondence event when multiple documents are associated with a single correspondence. Used to maintain the order of attachments or generated documents.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this correspondence-document link record was last modified. Provides audit trail for record changes.',
    CONSTRAINT pk_correspondence_link PRIMARY KEY(`correspondence_link_id`)
) COMMENT 'Association record linking a document to its originating correspondence communication record in the correspondence domain. Enables traceability from document artifacts back to the communication event that generated or received them.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`document`.`document_type` (
    `document_type_id` BIGINT COMMENT 'Primary key for document_type',
    `parent_document_type_id` BIGINT COMMENT 'Self-referencing FK on document_type (parent_document_type_id)',
    `acord_form_number` STRING COMMENT 'Standard ACORD form number if this document type corresponds to an industry-standard ACORD form (e.g., 101 for life insurance application).',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether documents of this type require formal approval workflow before being finalized or distributed.',
    `document_type_category` STRING COMMENT 'High-level classification of the document type grouping similar documents together for organizational and retrieval purposes.',
    `document_type_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the document type (e.g., POL_APP for policy application, ILLUS for illustration, APS for attending physician statement). Used as business identifier in operational systems.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this document type record was first created in the system.',
    `customer_facing_flag` BOOLEAN COMMENT 'Indicates whether this document type is typically sent to or received from customers, agents, or external parties.',
    `default_mime_type` STRING COMMENT 'Standard MIME type for the typical file format used for this document type (e.g., application/pdf for PDF documents).',
    `document_type_description` STRING COMMENT 'Detailed business description explaining the purpose, usage, and context of the document type.',
    `disclosure_type` STRING COMMENT 'Classification of disclosure requirements associated with this document type for regulatory compliance tracking.',
    `e_delivery_eligible_flag` BOOLEAN COMMENT 'Indicates whether this document type can be delivered electronically to policyholders subject to consent requirements.',
    `e_signature_allowed_flag` BOOLEAN COMMENT 'Indicates whether electronic signatures are legally acceptable for this document type under ESIGN Act and state regulations.',
    `effective_date` DATE COMMENT 'Date when this document type became or will become active and available for use in business operations.',
    `expiration_date` DATE COMMENT 'Date when this document type is no longer valid for use, typically due to regulatory changes or business process updates. Null if no expiration planned.',
    `imaging_required_flag` BOOLEAN COMMENT 'Indicates whether physical copies of this document type must be scanned and stored in the document imaging system.',
    `document_type_name` STRING COMMENT 'Full descriptive name of the document type (e.g., Policy Application, Beneficiary Change Form, Annual Statement).',
    `nigo_tracking_enabled_flag` BOOLEAN COMMENT 'Indicates whether incomplete or deficient submissions of this document type should be tracked in NIGO workflow for follow-up.',
    `regulatory_required_flag` BOOLEAN COMMENT 'Indicates whether this document type is mandated by state Department of Insurance (DOI) or federal regulations.',
    `retention_period_years` STRING COMMENT 'Number of years the document must be retained per regulatory and internal policy requirements before eligible for destruction.',
    `retention_trigger` STRING COMMENT 'The business event that starts the retention period clock (e.g., policy termination date, claim closure date).',
    `sort_order` STRING COMMENT 'Numeric value controlling the display order of document types in user interfaces and reports.',
    `state_filing_required_flag` BOOLEAN COMMENT 'Indicates whether this document type must be filed with state Department of Insurance for approval before use.',
    `document_type_status` STRING COMMENT 'Current lifecycle status of the document type indicating whether it is actively used in business operations.',
    `template_available_flag` BOOLEAN COMMENT 'Indicates whether a standard template exists for generating this document type in document composition systems.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this document type record was last modified.',
    `version_control_required_flag` BOOLEAN COMMENT 'Indicates whether this document type requires formal version tracking and audit trail of changes.',
    CONSTRAINT pk_document_type PRIMARY KEY(`document_type_id`)
) COMMENT 'Master reference table for document_type. Referenced by document_type_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `life_insurance_ecm`.`document`.`document` ADD CONSTRAINT `fk_document_document_acord_form_id` FOREIGN KEY (`acord_form_id`) REFERENCES `life_insurance_ecm`.`document`.`acord_form`(`acord_form_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`document` ADD CONSTRAINT `fk_document_document_document_type_id` FOREIGN KEY (`document_type_id`) REFERENCES `life_insurance_ecm`.`document`.`document_type`(`document_type_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`document` ADD CONSTRAINT `fk_document_document_retention_schedule_id` FOREIGN KEY (`retention_schedule_id`) REFERENCES `life_insurance_ecm`.`document`.`retention_schedule`(`retention_schedule_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`document` ADD CONSTRAINT `fk_document_document_template_id` FOREIGN KEY (`template_id`) REFERENCES `life_insurance_ecm`.`document`.`template`(`template_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`version` ADD CONSTRAINT `fk_document_version_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`version` ADD CONSTRAINT `fk_document_version_superseded_by_version_id` FOREIGN KEY (`superseded_by_version_id`) REFERENCES `life_insurance_ecm`.`document`.`version`(`version_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`package` ADD CONSTRAINT `fk_document_package_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ADD CONSTRAINT `fk_document_nigo_record_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ADD CONSTRAINT `fk_document_nigo_record_document_type_id` FOREIGN KEY (`document_type_id`) REFERENCES `life_insurance_ecm`.`document`.`document_type`(`document_type_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ADD CONSTRAINT `fk_document_nigo_record_package_id` FOREIGN KEY (`package_id`) REFERENCES `life_insurance_ecm`.`document`.`package`(`package_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ADD CONSTRAINT `fk_document_nigo_record_request_id` FOREIGN KEY (`request_id`) REFERENCES `life_insurance_ecm`.`document`.`request`(`request_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ADD CONSTRAINT `fk_document_delivery_consent_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ADD CONSTRAINT `fk_document_delivery_consent_signature_id` FOREIGN KEY (`signature_id`) REFERENCES `life_insurance_ecm`.`document`.`signature`(`signature_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ADD CONSTRAINT `fk_document_delivery_event_delivery_consent_id` FOREIGN KEY (`delivery_consent_id`) REFERENCES `life_insurance_ecm`.`document`.`delivery_consent`(`delivery_consent_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ADD CONSTRAINT `fk_document_delivery_event_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ADD CONSTRAINT `fk_document_delivery_event_package_id` FOREIGN KEY (`package_id`) REFERENCES `life_insurance_ecm`.`document`.`package`(`package_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`retention_schedule` ADD CONSTRAINT `fk_document_retention_schedule_document_type_id` FOREIGN KEY (`document_type_id`) REFERENCES `life_insurance_ecm`.`document`.`document_type`(`document_type_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`retention_schedule` ADD CONSTRAINT `fk_document_retention_schedule_superseded_by_schedule_retention_schedule_id` FOREIGN KEY (`superseded_by_schedule_retention_schedule_id`) REFERENCES `life_insurance_ecm`.`document`.`retention_schedule`(`retention_schedule_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ADD CONSTRAINT `fk_document_signature_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ADD CONSTRAINT `fk_document_access_log_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ADD CONSTRAINT `fk_document_access_log_legal_hold_id` FOREIGN KEY (`legal_hold_id`) REFERENCES `life_insurance_ecm`.`document`.`legal_hold`(`legal_hold_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ADD CONSTRAINT `fk_document_access_log_package_id` FOREIGN KEY (`package_id`) REFERENCES `life_insurance_ecm`.`document`.`package`(`package_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ADD CONSTRAINT `fk_document_workflow_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ADD CONSTRAINT `fk_document_workflow_package_id` FOREIGN KEY (`package_id`) REFERENCES `life_insurance_ecm`.`document`.`package`(`package_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_superseded_by_hold_legal_hold_id` FOREIGN KEY (`superseded_by_hold_legal_hold_id`) REFERENCES `life_insurance_ecm`.`document`.`legal_hold`(`legal_hold_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`template` ADD CONSTRAINT `fk_document_template_acord_form_id` FOREIGN KEY (`acord_form_id`) REFERENCES `life_insurance_ecm`.`document`.`acord_form`(`acord_form_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`template` ADD CONSTRAINT `fk_document_template_superseded_by_template_id` FOREIGN KEY (`superseded_by_template_id`) REFERENCES `life_insurance_ecm`.`document`.`template`(`template_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`request` ADD CONSTRAINT `fk_document_request_acord_form_id` FOREIGN KEY (`acord_form_id`) REFERENCES `life_insurance_ecm`.`document`.`acord_form`(`acord_form_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`request` ADD CONSTRAINT `fk_document_request_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`request` ADD CONSTRAINT `fk_document_request_package_id` FOREIGN KEY (`package_id`) REFERENCES `life_insurance_ecm`.`document`.`package`(`package_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`request` ADD CONSTRAINT `fk_document_request_resubmitted_request_id` FOREIGN KEY (`resubmitted_request_id`) REFERENCES `life_insurance_ecm`.`document`.`request`(`request_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` ADD CONSTRAINT `fk_document_correspondence_link_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` ADD CONSTRAINT `fk_document_correspondence_link_legal_hold_id` FOREIGN KEY (`legal_hold_id`) REFERENCES `life_insurance_ecm`.`document`.`legal_hold`(`legal_hold_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` ADD CONSTRAINT `fk_document_correspondence_link_superseded_correspondence_link_id` FOREIGN KEY (`superseded_correspondence_link_id`) REFERENCES `life_insurance_ecm`.`document`.`correspondence_link`(`correspondence_link_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`document_type` ADD CONSTRAINT `fk_document_document_type_parent_document_type_id` FOREIGN KEY (`parent_document_type_id`) REFERENCES `life_insurance_ecm`.`document`.`document_type`(`document_type_id`);

-- ========= TAGS =========
ALTER SCHEMA `life_insurance_ecm`.`document` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `life_insurance_ecm`.`document` SET TAGS ('dbx_domain' = 'document');
ALTER TABLE `life_insurance_ecm`.`document`.`document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`document`.`document` SET TAGS ('dbx_subdomain' = 'content_management');
ALTER TABLE `life_insurance_ecm`.`document`.`document` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Document Identifier');
ALTER TABLE `life_insurance_ecm`.`document`.`document` ALTER COLUMN `acord_form_id` SET TAGS ('dbx_business_glossary_term' = 'Acord Form Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`document` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`document` ALTER COLUMN `document_type_id` SET TAGS ('dbx_business_glossary_term' = 'Document Type Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`document` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`document` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Producer ID');
ALTER TABLE `life_insurance_ecm`.`document`.`document` ALTER COLUMN `retention_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Document Retention Schedule Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`document` ALTER COLUMN `template_id` SET TAGS ('dbx_business_glossary_term' = 'Template Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`document` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`document` ALTER COLUMN `archived_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Archived Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `life_insurance_ecm`.`document`.`document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `life_insurance_ecm`.`document`.`document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`document` ALTER COLUMN `destroyed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Destroyed Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`document` ALTER COLUMN `document_category` SET TAGS ('dbx_business_glossary_term' = 'Document Category');
ALTER TABLE `life_insurance_ecm`.`document`.`document` ALTER COLUMN `document_description` SET TAGS ('dbx_business_glossary_term' = 'Document Description');
ALTER TABLE `life_insurance_ecm`.`document`.`document` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `life_insurance_ecm`.`document`.`document` ALTER COLUMN `e_delivery_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Delivery Consent Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`document` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`document`.`document` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `life_insurance_ecm`.`document`.`document` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `life_insurance_ecm`.`document`.`document` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size (Bytes)');
ALTER TABLE `life_insurance_ecm`.`document`.`document` ALTER COLUMN `hash` SET TAGS ('dbx_business_glossary_term' = 'Document Hash');
ALTER TABLE `life_insurance_ecm`.`document`.`document` ALTER COLUMN `indexed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Indexed Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`document` ALTER COLUMN `is_latest_version` SET TAGS ('dbx_business_glossary_term' = 'Is Latest Version Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`document` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `life_insurance_ecm`.`document`.`document` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`document` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `life_insurance_ecm`.`document`.`document` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'draft|active|superseded|archived|destroyed|pending');
ALTER TABLE `life_insurance_ecm`.`document`.`document` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`document` ALTER COLUMN `nigo_flag` SET TAGS ('dbx_business_glossary_term' = 'Not In Good Order (NIGO) Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`document` ALTER COLUMN `nigo_reason` SET TAGS ('dbx_business_glossary_term' = 'Not In Good Order (NIGO) Reason');
ALTER TABLE `life_insurance_ecm`.`document`.`document` ALTER COLUMN `origination_channel` SET TAGS ('dbx_business_glossary_term' = 'Origination Channel');
ALTER TABLE `life_insurance_ecm`.`document`.`document` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Page Count');
ALTER TABLE `life_insurance_ecm`.`document`.`document` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Received Date');
ALTER TABLE `life_insurance_ecm`.`document`.`document` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `life_insurance_ecm`.`document`.`document` ALTER COLUMN `regulatory_filing_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`document` ALTER COLUMN `retention_end_date` SET TAGS ('dbx_business_glossary_term' = 'Retention End Date');
ALTER TABLE `life_insurance_ecm`.`document`.`document` ALTER COLUMN `signature_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Signature Required Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`document` ALTER COLUMN `signature_status` SET TAGS ('dbx_business_glossary_term' = 'Signature Status');
ALTER TABLE `life_insurance_ecm`.`document`.`document` ALTER COLUMN `signature_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|signed|rejected|expired');
ALTER TABLE `life_insurance_ecm`.`document`.`document` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `life_insurance_ecm`.`document`.`document` ALTER COLUMN `storage_location_uri` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Uniform Resource Identifier (URI)');
ALTER TABLE `life_insurance_ecm`.`document`.`document` ALTER COLUMN `storage_location_uri` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`document` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Document Title');
ALTER TABLE `life_insurance_ecm`.`document`.`document` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `life_insurance_ecm`.`document`.`version` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`document`.`version` SET TAGS ('dbx_subdomain' = 'content_management');
ALTER TABLE `life_insurance_ecm`.`document`.`version` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Document Version Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`version` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Document Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`version` ALTER COLUMN `superseded_by_version_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Version Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`version` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `life_insurance_ecm`.`document`.`version` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `life_insurance_ecm`.`document`.`version` ALTER COLUMN `approver_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`version` ALTER COLUMN `author_name` SET TAGS ('dbx_business_glossary_term' = 'Author Name');
ALTER TABLE `life_insurance_ecm`.`document`.`version` ALTER COLUMN `author_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`version` ALTER COLUMN `author_role` SET TAGS ('dbx_business_glossary_term' = 'Author Role');
ALTER TABLE `life_insurance_ecm`.`document`.`version` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `life_insurance_ecm`.`document`.`version` ALTER COLUMN `checksum_hash` SET TAGS ('dbx_business_glossary_term' = 'Checksum Hash');
ALTER TABLE `life_insurance_ecm`.`document`.`version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`version` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`document`.`version` ALTER COLUMN `eligible_for_purge_date` SET TAGS ('dbx_business_glossary_term' = 'Eligible for Purge Date');
ALTER TABLE `life_insurance_ecm`.`document`.`version` ALTER COLUMN `encryption_method` SET TAGS ('dbx_business_glossary_term' = 'Encryption Method');
ALTER TABLE `life_insurance_ecm`.`document`.`version` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `life_insurance_ecm`.`document`.`version` ALTER COLUMN `extracted_text_available` SET TAGS ('dbx_business_glossary_term' = 'Extracted Text Available Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`version` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `life_insurance_ecm`.`document`.`version` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size in Bytes');
ALTER TABLE `life_insurance_ecm`.`document`.`version` ALTER COLUMN `hash_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Hash Algorithm');
ALTER TABLE `life_insurance_ecm`.`document`.`version` ALTER COLUMN `hash_algorithm` SET TAGS ('dbx_value_regex' = 'SHA-256|SHA-512|MD5|SHA-1');
ALTER TABLE `life_insurance_ecm`.`document`.`version` ALTER COLUMN `is_digitally_signed` SET TAGS ('dbx_business_glossary_term' = 'Is Digitally Signed Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`version` ALTER COLUMN `is_encrypted` SET TAGS ('dbx_business_glossary_term' = 'Is Encrypted Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`version` ALTER COLUMN `is_under_litigation_hold` SET TAGS ('dbx_business_glossary_term' = 'Is Under Litigation Hold Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`version` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `life_insurance_ecm`.`document`.`version` ALTER COLUMN `last_accessed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Accessed Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`version` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`version` ALTER COLUMN `litigation_hold_date` SET TAGS ('dbx_business_glossary_term' = 'Litigation Hold Date');
ALTER TABLE `life_insurance_ecm`.`document`.`version` ALTER COLUMN `mime_type` SET TAGS ('dbx_business_glossary_term' = 'Multipurpose Internet Mail Extensions (MIME) Type');
ALTER TABLE `life_insurance_ecm`.`document`.`version` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Version Notes');
ALTER TABLE `life_insurance_ecm`.`document`.`version` ALTER COLUMN `ocr_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Optical Character Recognition (OCR) Confidence Score');
ALTER TABLE `life_insurance_ecm`.`document`.`version` ALTER COLUMN `ocr_processed_flag` SET TAGS ('dbx_business_glossary_term' = 'Optical Character Recognition (OCR) Processed Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`version` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Page Count');
ALTER TABLE `life_insurance_ecm`.`document`.`version` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period in Years');
ALTER TABLE `life_insurance_ecm`.`document`.`version` ALTER COLUMN `retention_trigger_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Trigger Date');
ALTER TABLE `life_insurance_ecm`.`document`.`version` ALTER COLUMN `signature_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Signature Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`version` ALTER COLUMN `signer_name` SET TAGS ('dbx_business_glossary_term' = 'Signer Name');
ALTER TABLE `life_insurance_ecm`.`document`.`version` ALTER COLUMN `signer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`version` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `life_insurance_ecm`.`document`.`version` ALTER COLUMN `source_system_version_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Version Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`version` ALTER COLUMN `storage_uri` SET TAGS ('dbx_business_glossary_term' = 'Storage Uniform Resource Identifier (URI)');
ALTER TABLE `life_insurance_ecm`.`document`.`version` ALTER COLUMN `storage_uri` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`version` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `life_insurance_ecm`.`document`.`version` ALTER COLUMN `version_status` SET TAGS ('dbx_business_glossary_term' = 'Version Status');
ALTER TABLE `life_insurance_ecm`.`document`.`version` ALTER COLUMN `version_type` SET TAGS ('dbx_business_glossary_term' = 'Version Type');
ALTER TABLE `life_insurance_ecm`.`document`.`version` ALTER COLUMN `version_type` SET TAGS ('dbx_value_regex' = 'original|amendment|correction|reissue|endorsement|rider_attachment');
ALTER TABLE `life_insurance_ecm`.`document`.`package` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`document`.`package` SET TAGS ('dbx_subdomain' = 'content_management');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Document Package Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `annuitant_id` SET TAGS ('dbx_business_glossary_term' = 'Annuitant Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Application Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `group_sponsor_id` SET TAGS ('dbx_business_glossary_term' = 'Group Sponsor Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `package_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned To User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `package_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `package_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `package_updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `package_updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `package_updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Policyholder Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Producer Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `statutory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Statutory Filing Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `assembly_date` SET TAGS ('dbx_business_glossary_term' = 'Assembly Date');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `assigned_date` SET TAGS ('dbx_business_glossary_term' = 'Assigned Date');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `completeness_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completeness Percentage');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `e_delivery_consent_date` SET TAGS ('dbx_business_glossary_term' = 'Electronic Delivery (E-Delivery) Consent Date');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `e_delivery_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Delivery (E-Delivery) Consent Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `external_reference_number` SET TAGS ('dbx_business_glossary_term' = 'External Reference Number');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `imaging_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Imaging Batch Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `imaging_date` SET TAGS ('dbx_business_glossary_term' = 'Imaging Date');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `nigo_date` SET TAGS ('dbx_business_glossary_term' = 'Not In Good Order (NIGO) Date');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `nigo_flag` SET TAGS ('dbx_business_glossary_term' = 'Not In Good Order (NIGO) Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `nigo_reason` SET TAGS ('dbx_business_glossary_term' = 'Not In Good Order (NIGO) Reason');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `optional_document_count` SET TAGS ('dbx_business_glossary_term' = 'Optional Document Count');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `package_description` SET TAGS ('dbx_business_glossary_term' = 'Package Description');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `package_number` SET TAGS ('dbx_business_glossary_term' = 'Package Number');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `package_status` SET TAGS ('dbx_business_glossary_term' = 'Package Status');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent|expedited');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `received_document_count` SET TAGS ('dbx_business_glossary_term' = 'Received Document Count');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `required_document_count` SET TAGS ('dbx_business_glossary_term' = 'Required Document Count');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `retention_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiration Date');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period Years');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `sla_due_date` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Due Date');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`package` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Package Version');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` SET TAGS ('dbx_subdomain' = 'workflow_processing');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `nigo_record_id` SET TAGS ('dbx_business_glossary_term' = 'Not In Good Order (NIGO) Record Identifier');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `annuitant_id` SET TAGS ('dbx_business_glossary_term' = 'Annuitant Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `annuity_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Annuity Contract Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Application Identifier');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `contract_owner_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `document_type_id` SET TAGS ('dbx_business_glossary_term' = 'Document Type Identifier');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `group_member_id` SET TAGS ('dbx_business_glossary_term' = 'Group Member Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `group_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `group_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `group_sponsor_id` SET TAGS ('dbx_business_glossary_term' = 'Group Sponsor Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Identified By Employee Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Document Package Identifier');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `policyholder_beneficiary_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Producer Identifier');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `premium_bill_id` SET TAGS ('dbx_business_glossary_term' = 'Related Bill Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Document Request Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `underwriting_workbench_case_application_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Workbench Case Identifier');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `aging_days` SET TAGS ('dbx_business_glossary_term' = 'Aging Days');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `deficiency_description` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Description');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `estimated_delay_days` SET TAGS ('dbx_business_glossary_term' = 'Estimated Delay Days');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `follow_up_count` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Count');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `identified_date` SET TAGS ('dbx_business_glossary_term' = 'Identified Date');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `impact_on_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Impact on Issue Date Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `last_follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Last Follow-Up Date');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `next_follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Next Follow-Up Date');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `nigo_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Not In Good Order (NIGO) Reason Code');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `nigo_status` SET TAGS ('dbx_business_glossary_term' = 'Not In Good Order (NIGO) Status');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `nigo_status` SET TAGS ('dbx_value_regex' = 'open|pending_agent|pending_applicant|escalated|resolved|withdrawn');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Notification Method');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `notification_method` SET TAGS ('dbx_value_regex' = 'email|postal_mail|phone|portal|fax');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Date');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Resolution Method');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `resolution_method` SET TAGS ('dbx_value_regex' = 'corrected_form|waiver_granted|additional_doc|phone_verification|withdrawn');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `resolved_by` SET TAGS ('dbx_business_glossary_term' = 'Resolved By');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `resolved_date` SET TAGS ('dbx_business_glossary_term' = 'Resolved Date');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `responsible_party_contact` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Contact');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `responsible_party_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `responsible_party_contact` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `responsible_party_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Name');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `responsible_party_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `responsible_party_type` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Type');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `responsible_party_type` SET TAGS ('dbx_value_regex' = 'agent|applicant|tpa|carrier|medical_provider');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `source_system_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Record Identifier');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `state_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'State Jurisdiction');
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` SET TAGS ('dbx_subdomain' = 'distribution_control');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `delivery_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Consent Identifier');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Document ID');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `signature_id` SET TAGS ('dbx_business_glossary_term' = 'Electronic Signature (E-Signature) ID');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Policyholder ID');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Agent ID');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `alternate_email_address` SET TAGS ('dbx_business_glossary_term' = 'Alternate Email Address');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `alternate_email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `alternate_email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `alternate_email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `bounce_count` SET TAGS ('dbx_business_glossary_term' = 'Bounce Count');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `consent_device_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Device Type');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `consent_device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet|kiosk|phone_ivr|unknown');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `consent_ip_address` SET TAGS ('dbx_business_glossary_term' = 'Consent Internet Protocol (IP) Address');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `consent_ip_address` SET TAGS ('dbx_value_regex' = '^(?:[0-9]{1,3}.){3}[0-9]{1,3}$|^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `consent_ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `consent_ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `consent_language` SET TAGS ('dbx_business_glossary_term' = 'Consent Language');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `consent_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `consent_method` SET TAGS ('dbx_business_glossary_term' = 'Consent Method');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `consent_method` SET TAGS ('dbx_value_regex' = 'web_portal|mobile_app|email_link|wet_signature|e_signature|phone_ivr');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `consent_scope` SET TAGS ('dbx_business_glossary_term' = 'Consent Scope');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `consent_scope` SET TAGS ('dbx_value_regex' = 'all_documents|policy_documents_only|billing_only|claims_only|tax_documents_only|regulatory_notices_only');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'granted|revoked|pending|expired|suspended');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `consent_user_agent` SET TAGS ('dbx_business_glossary_term' = 'Consent User Agent');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `consent_user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `consent_user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `consent_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Version');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `data_classification` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `last_bounce_date` SET TAGS ('dbx_business_glossary_term' = 'Last Bounce Date');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `last_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verification Date');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `opt_in_marketing_flag` SET TAGS ('dbx_business_glossary_term' = 'Opt-In Marketing Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `preferred_delivery_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Delivery Channel');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `preferred_delivery_channel` SET TAGS ('dbx_value_regex' = 'email|portal|mobile_app|mail|fax');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `renewal_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Revocation Date');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `revocation_method` SET TAGS ('dbx_business_glossary_term' = 'Revocation Method');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `revocation_method` SET TAGS ('dbx_value_regex' = 'web_portal|mobile_app|phone|email|mail|agent_assisted');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `state_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'State Compliance Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `state_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'State Jurisdiction');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `state_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|bounced|invalid|pending_verification');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` SET TAGS ('dbx_subdomain' = 'distribution_control');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ALTER COLUMN `delivery_event_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Event Identifier');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ALTER COLUMN `delivery_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Edelivery Consent Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Document Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Document Package Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Policyholder Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ALTER COLUMN `confirmation_receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Receipt Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ALTER COLUMN `delivery_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Batch Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ALTER COLUMN `delivery_channel` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ALTER COLUMN `delivery_channel` SET TAGS ('dbx_value_regex' = 'email|secure_portal|sms_notification|mobile_app|fax|paper_fallback');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ALTER COLUMN `delivery_method_preference` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method Preference');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ALTER COLUMN `delivery_method_preference` SET TAGS ('dbx_value_regex' = 'email_only|portal_only|sms_notification|any_electronic|paper_required');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ALTER COLUMN `delivery_priority` SET TAGS ('dbx_business_glossary_term' = 'Delivery Priority');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ALTER COLUMN `delivery_priority` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ALTER COLUMN `document_version` SET TAGS ('dbx_business_glossary_term' = 'Document Version');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ALTER COLUMN `encryption_flag` SET TAGS ('dbx_business_glossary_term' = 'Encryption Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ALTER COLUMN `failure_code` SET TAGS ('dbx_business_glossary_term' = 'Failure Code');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ALTER COLUMN `failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Failure Reason');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ALTER COLUMN `fallback_to_paper_flag` SET TAGS ('dbx_business_glossary_term' = 'Fallback to Paper Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ALTER COLUMN `max_retry_attempts` SET TAGS ('dbx_business_glossary_term' = 'Maximum Retry Attempts');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ALTER COLUMN `next_retry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Next Retry Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ALTER COLUMN `opened_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Opened Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ALTER COLUMN `paper_fallback_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Paper Fallback Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ALTER COLUMN `recipient_email` SET TAGS ('dbx_business_glossary_term' = 'Recipient Email Address');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ALTER COLUMN `recipient_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ALTER COLUMN `recipient_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ALTER COLUMN `recipient_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ALTER COLUMN `recipient_phone` SET TAGS ('dbx_business_glossary_term' = 'Recipient Phone Number');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ALTER COLUMN `recipient_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ALTER COLUMN `recipient_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ALTER COLUMN `retention_end_date` SET TAGS ('dbx_business_glossary_term' = 'Retention End Date');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Retry Count');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ALTER COLUMN `sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Sent Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ALTER COLUMN `sla_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Met Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Hours');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`retention_schedule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `life_insurance_ecm`.`document`.`retention_schedule` SET TAGS ('dbx_subdomain' = 'compliance_governance');
ALTER TABLE `life_insurance_ecm`.`document`.`retention_schedule` ALTER COLUMN `retention_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Schedule Identifier');
ALTER TABLE `life_insurance_ecm`.`document`.`retention_schedule` ALTER COLUMN `document_type_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`retention_schedule` ALTER COLUMN `superseded_by_schedule_retention_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Schedule ID');
ALTER TABLE `life_insurance_ecm`.`document`.`retention_schedule` ALTER COLUMN `acord_form_indicator` SET TAGS ('dbx_business_glossary_term' = 'Association for Cooperative Operations Research and Development (ACORD) Form Indicator');
ALTER TABLE `life_insurance_ecm`.`document`.`retention_schedule` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `life_insurance_ecm`.`document`.`retention_schedule` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `life_insurance_ecm`.`document`.`retention_schedule` ALTER COLUMN `audit_trail_required` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Required');
ALTER TABLE `life_insurance_ecm`.`document`.`retention_schedule` ALTER COLUMN `business_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `life_insurance_ecm`.`document`.`retention_schedule` ALTER COLUMN `destruction_authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Destruction Authorization Required');
ALTER TABLE `life_insurance_ecm`.`document`.`retention_schedule` ALTER COLUMN `destruction_method` SET TAGS ('dbx_business_glossary_term' = 'Destruction Method');
ALTER TABLE `life_insurance_ecm`.`document`.`retention_schedule` ALTER COLUMN `destruction_method` SET TAGS ('dbx_value_regex' = 'secure_shred|electronic_purge|degaussing|incineration|certified_destruction');
ALTER TABLE `life_insurance_ecm`.`document`.`retention_schedule` ALTER COLUMN `document_type_code` SET TAGS ('dbx_business_glossary_term' = 'Document Type Code');
ALTER TABLE `life_insurance_ecm`.`document`.`retention_schedule` ALTER COLUMN `document_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `life_insurance_ecm`.`document`.`retention_schedule` ALTER COLUMN `e_delivery_eligible` SET TAGS ('dbx_business_glossary_term' = 'Electronic Delivery (E-Delivery) Eligible');
ALTER TABLE `life_insurance_ecm`.`document`.`retention_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `life_insurance_ecm`.`document`.`retention_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `life_insurance_ecm`.`document`.`retention_schedule` ALTER COLUMN `exception_process_available` SET TAGS ('dbx_business_glossary_term' = 'Exception Process Available');
ALTER TABLE `life_insurance_ecm`.`document`.`retention_schedule` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `life_insurance_ecm`.`document`.`retention_schedule` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `life_insurance_ecm`.`document`.`retention_schedule` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `life_insurance_ecm`.`document`.`retention_schedule` ALTER COLUMN `legal_hold_override_allowed` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Override Allowed');
ALTER TABLE `life_insurance_ecm`.`document`.`retention_schedule` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `life_insurance_ecm`.`document`.`retention_schedule` ALTER COLUMN `maximum_retention_years` SET TAGS ('dbx_business_glossary_term' = 'Maximum Retention Years');
ALTER TABLE `life_insurance_ecm`.`document`.`retention_schedule` ALTER COLUMN `minimum_retention_years` SET TAGS ('dbx_business_glossary_term' = 'Minimum Retention Years');
ALTER TABLE `life_insurance_ecm`.`document`.`retention_schedule` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `life_insurance_ecm`.`document`.`retention_schedule` ALTER COLUMN `nigo_tracking_applicable` SET TAGS ('dbx_business_glossary_term' = 'Not In Good Order (NIGO) Tracking Applicable');
ALTER TABLE `life_insurance_ecm`.`document`.`retention_schedule` ALTER COLUMN `pii_phi_indicator` SET TAGS ('dbx_business_glossary_term' = 'Personally Identifiable Information (PII) / Protected Health Information (PHI) Indicator');
ALTER TABLE `life_insurance_ecm`.`document`.`retention_schedule` ALTER COLUMN `privacy_classification` SET TAGS ('dbx_business_glossary_term' = 'Privacy Classification');
ALTER TABLE `life_insurance_ecm`.`document`.`retention_schedule` ALTER COLUMN `privacy_classification` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `life_insurance_ecm`.`document`.`retention_schedule` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`retention_schedule` ALTER COLUMN `record_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By');
ALTER TABLE `life_insurance_ecm`.`document`.`retention_schedule` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`retention_schedule` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `life_insurance_ecm`.`document`.`retention_schedule` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `life_insurance_ecm`.`document`.`retention_schedule` ALTER COLUMN `retention_medium` SET TAGS ('dbx_business_glossary_term' = 'Retention Medium');
ALTER TABLE `life_insurance_ecm`.`document`.`retention_schedule` ALTER COLUMN `retention_medium` SET TAGS ('dbx_value_regex' = 'electronic|paper|microfilm|optical|any');
ALTER TABLE `life_insurance_ecm`.`document`.`retention_schedule` ALTER COLUMN `retention_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Retention Schedule Status');
ALTER TABLE `life_insurance_ecm`.`document`.`retention_schedule` ALTER COLUMN `retention_schedule_status` SET TAGS ('dbx_value_regex' = 'active|superseded|pending_approval|archived');
ALTER TABLE `life_insurance_ecm`.`document`.`retention_schedule` ALTER COLUMN `retention_trigger_event` SET TAGS ('dbx_business_glossary_term' = 'Retention Trigger Event');
ALTER TABLE `life_insurance_ecm`.`document`.`retention_schedule` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `life_insurance_ecm`.`document`.`retention_schedule` ALTER COLUMN `version_control_required` SET TAGS ('dbx_business_glossary_term' = 'Version Control Required');
ALTER TABLE `life_insurance_ecm`.`document`.`acord_form` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `life_insurance_ecm`.`document`.`acord_form` SET TAGS ('dbx_subdomain' = 'compliance_governance');
ALTER TABLE `life_insurance_ecm`.`document`.`acord_form` ALTER COLUMN `acord_form_id` SET TAGS ('dbx_business_glossary_term' = 'ACORD Form Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`acord_form` ALTER COLUMN `aml_kyc_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Know Your Customer (KYC) Required Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`acord_form` ALTER COLUMN `applicable_states` SET TAGS ('dbx_business_glossary_term' = 'Applicable States');
ALTER TABLE `life_insurance_ecm`.`document`.`acord_form` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`acord_form` ALTER COLUMN `e_delivery_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Delivery (E-Delivery) Eligible Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`acord_form` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Form Effective Date');
ALTER TABLE `life_insurance_ecm`.`document`.`acord_form` ALTER COLUMN `electronic_signature_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Signature Allowed Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`acord_form` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Form Expiration Date');
ALTER TABLE `life_insurance_ecm`.`document`.`acord_form` ALTER COLUMN `form_category` SET TAGS ('dbx_business_glossary_term' = 'Form Category');
ALTER TABLE `life_insurance_ecm`.`document`.`acord_form` ALTER COLUMN `form_description` SET TAGS ('dbx_business_glossary_term' = 'Form Description');
ALTER TABLE `life_insurance_ecm`.`document`.`acord_form` ALTER COLUMN `form_language` SET TAGS ('dbx_business_glossary_term' = 'Form Language');
ALTER TABLE `life_insurance_ecm`.`document`.`acord_form` ALTER COLUMN `form_language` SET TAGS ('dbx_value_regex' = 'ENG|SPA|FRA');
ALTER TABLE `life_insurance_ecm`.`document`.`acord_form` ALTER COLUMN `form_name` SET TAGS ('dbx_business_glossary_term' = 'ACORD Form Name');
ALTER TABLE `life_insurance_ecm`.`document`.`acord_form` ALTER COLUMN `form_number` SET TAGS ('dbx_business_glossary_term' = 'ACORD Form Number');
ALTER TABLE `life_insurance_ecm`.`document`.`acord_form` ALTER COLUMN `form_number` SET TAGS ('dbx_value_regex' = '^ACORDs[0-9]{1,4}[A-Z]?$');
ALTER TABLE `life_insurance_ecm`.`document`.`acord_form` ALTER COLUMN `form_purpose` SET TAGS ('dbx_business_glossary_term' = 'Form Purpose');
ALTER TABLE `life_insurance_ecm`.`document`.`acord_form` ALTER COLUMN `form_status` SET TAGS ('dbx_business_glossary_term' = 'Form Status');
ALTER TABLE `life_insurance_ecm`.`document`.`acord_form` ALTER COLUMN `form_status` SET TAGS ('dbx_value_regex' = 'active|superseded|deprecated|pending_approval|withdrawn');
ALTER TABLE `life_insurance_ecm`.`document`.`acord_form` ALTER COLUMN `form_template_url` SET TAGS ('dbx_business_glossary_term' = 'Form Template Uniform Resource Locator (URL)');
ALTER TABLE `life_insurance_ecm`.`document`.`acord_form` ALTER COLUMN `form_version` SET TAGS ('dbx_business_glossary_term' = 'ACORD Form Version');
ALTER TABLE `life_insurance_ecm`.`document`.`acord_form` ALTER COLUMN `form_version` SET TAGS ('dbx_value_regex' = '^[0-9]{4}/[0-9]{2}$');
ALTER TABLE `life_insurance_ecm`.`document`.`acord_form` ALTER COLUMN `hipaa_protected_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Portability and Accountability Act (HIPAA) Protected Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`acord_form` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `life_insurance_ecm`.`document`.`acord_form` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `life_insurance_ecm`.`document`.`acord_form` ALTER COLUMN `mandatory_fields_list` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Fields List');
ALTER TABLE `life_insurance_ecm`.`document`.`acord_form` ALTER COLUMN `nigo_tracking_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Not In Good Order (NIGO) Tracking Enabled Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`acord_form` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Form Page Count');
ALTER TABLE `life_insurance_ecm`.`document`.`acord_form` ALTER COLUMN `regulatory_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Number');
ALTER TABLE `life_insurance_ecm`.`document`.`acord_form` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Document Retention Period (Years)');
ALTER TABLE `life_insurance_ecm`.`document`.`acord_form` ALTER COLUMN `state_specific_flag` SET TAGS ('dbx_business_glossary_term' = 'State-Specific Variant Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`acord_form` ALTER COLUMN `superseded_by_form_number` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Form Number');
ALTER TABLE `life_insurance_ecm`.`document`.`acord_form` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` SET TAGS ('dbx_subdomain' = 'distribution_control');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `signature_id` SET TAGS ('dbx_business_glossary_term' = 'Document Signature Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `annuitant_id` SET TAGS ('dbx_business_glossary_term' = 'Annuitant Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `annuity_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Annuity Contract Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `claimant_id` SET TAGS ('dbx_business_glossary_term' = 'Claimant Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Document Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Voided By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `group_member_id` SET TAGS ('dbx_business_glossary_term' = 'Group Member Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `group_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `group_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Signer Party Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `audit_trail_url` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Uniform Resource Locator (URL)');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `audit_trail_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `authentication_method` SET TAGS ('dbx_business_glossary_term' = 'Authentication Method');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `authentication_method` SET TAGS ('dbx_value_regex' = 'email|sms|knowledge_based|biometric|multi_factor|none');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `certificate_reference` SET TAGS ('dbx_business_glossary_term' = 'Digital Certificate Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `consent_to_electronic_signature` SET TAGS ('dbx_business_glossary_term' = 'Consent to Electronic Signature Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `decline_reason` SET TAGS ('dbx_business_glossary_term' = 'Signature Decline Reason');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `esignature_platform` SET TAGS ('dbx_business_glossary_term' = 'Electronic Signature (E-Signature) Platform');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `expiration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Signature Expiration Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Latitude');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Longitude');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `image_url` SET TAGS ('dbx_business_glossary_term' = 'Signature Image Uniform Resource Locator (URL)');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `image_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `legal_validity_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Validity Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `notary_commission_number` SET TAGS ('dbx_business_glossary_term' = 'Notary Commission Number');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `notary_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Notary Commission Expiration Date');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `notary_state` SET TAGS ('dbx_business_glossary_term' = 'Notary State Code');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `reminder_count` SET TAGS ('dbx_business_glossary_term' = 'Signature Reminder Count');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `request_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Signature Request Sent Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `sequence` SET TAGS ('dbx_business_glossary_term' = 'Signature Sequence Number');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `signature_method` SET TAGS ('dbx_business_glossary_term' = 'Signature Method');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `signature_method` SET TAGS ('dbx_value_regex' = 'wet_ink|electronic|digital|biometric|voice');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `signature_status` SET TAGS ('dbx_business_glossary_term' = 'Signature Status');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `signature_status` SET TAGS ('dbx_value_regex' = 'pending|completed|declined|expired|voided|revoked');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `signature_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Signature Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `signer_full_name` SET TAGS ('dbx_business_glossary_term' = 'Signer Full Legal Name');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `signer_full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `signer_full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `signer_role` SET TAGS ('dbx_business_glossary_term' = 'Signer Role');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `state_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'State Jurisdiction Code');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent String');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `voided_reason` SET TAGS ('dbx_business_glossary_term' = 'Signature Voided Reason');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `voided_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Voided Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `witness_name` SET TAGS ('dbx_business_glossary_term' = 'Witness Full Name');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `witness_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `witness_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ALTER COLUMN `witness_signature_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Witness Signature Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` SET TAGS ('dbx_subdomain' = 'distribution_control');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `access_log_id` SET TAGS ('dbx_business_glossary_term' = 'Access Log Identifier');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `claim_investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Investigation Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `contestability_review_id` SET TAGS ('dbx_business_glossary_term' = 'Contestability Review Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Document ID');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Accessor User ID');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Security Incident ID');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `legal_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Document Package Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `access_authorized_flag` SET TAGS ('dbx_business_glossary_term' = 'Access Authorized Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `access_channel` SET TAGS ('dbx_business_glossary_term' = 'Access Channel');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `access_denied_reason` SET TAGS ('dbx_business_glossary_term' = 'Access Denied Reason');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `access_device_type` SET TAGS ('dbx_business_glossary_term' = 'Access Device Type');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `access_device_type` SET TAGS ('dbx_value_regex' = 'desktop|laptop|tablet|mobile|server|automated_system');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `access_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Access Duration in Seconds');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `access_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Access Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `access_type` SET TAGS ('dbx_business_glossary_term' = 'Access Type');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `access_type` SET TAGS ('dbx_value_regex' = 'view|download|print|share|edit|delete');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `accessor_name` SET TAGS ('dbx_business_glossary_term' = 'Accessor Full Name');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `accessor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `accessor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `accessor_role` SET TAGS ('dbx_business_glossary_term' = 'Accessor Role');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `anomaly_score` SET TAGS ('dbx_business_glossary_term' = 'Anomaly Score');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `audit_trail_retention_years` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Retention Period in Years');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `business_justification_code` SET TAGS ('dbx_business_glossary_term' = 'Business Justification Code');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `claim_number` SET TAGS ('dbx_business_glossary_term' = 'Claim Number');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `claim_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `claim_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `consent_on_file_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent On File Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `document_classification` SET TAGS ('dbx_business_glossary_term' = 'Document Classification Level');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `document_classification` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `download_flag` SET TAGS ('dbx_business_glossary_term' = 'Download Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `geographic_location` SET TAGS ('dbx_business_glossary_term' = 'Geographic Location');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `hipaa_protected_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Portability and Accountability Act (HIPAA) Protected Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `pages_accessed` SET TAGS ('dbx_business_glossary_term' = 'Pages Accessed Count');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `policy_number` SET TAGS ('dbx_business_glossary_term' = 'Policy Number');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `policy_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `print_flag` SET TAGS ('dbx_business_glossary_term' = 'Print Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `security_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Security Incident Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `session_code` SET TAGS ('dbx_business_glossary_term' = 'Session ID');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `share_recipient_email` SET TAGS ('dbx_business_glossary_term' = 'Share Recipient Email Address');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `share_recipient_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `share_recipient_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` SET TAGS ('dbx_subdomain' = 'workflow_processing');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `workflow_id` SET TAGS ('dbx_business_glossary_term' = 'Document Workflow Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `appeal_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Application Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `claim_investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Investigation Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `close_task_id` SET TAGS ('dbx_business_glossary_term' = 'Close Task Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Document Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Team Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Document Package Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Policyholder Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Producer Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `workflow_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `workflow_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `workflow_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `workflow_operator_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `workflow_operator_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `workflow_operator_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `workflow_quality_control_reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Reviewer Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `workflow_quality_control_reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `workflow_quality_control_reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `workflow_updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `workflow_updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `workflow_updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `assigned_queue` SET TAGS ('dbx_business_glossary_term' = 'Assigned Queue');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Workflow Completed Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `current_stage` SET TAGS ('dbx_business_glossary_term' = 'Current Workflow Stage');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `entry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Workflow Entry Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `error_count` SET TAGS ('dbx_business_glossary_term' = 'Error Count');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `external_reference_number` SET TAGS ('dbx_business_glossary_term' = 'External Reference Number');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `imaging_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Imaging Batch Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `imaging_system_reference` SET TAGS ('dbx_business_glossary_term' = 'Imaging System Reference');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `initiated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Workflow Initiated Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `nigo_date` SET TAGS ('dbx_business_glossary_term' = 'Not In Good Order (NIGO) Date');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `nigo_flag` SET TAGS ('dbx_business_glossary_term' = 'Not In Good Order (NIGO) Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `nigo_reason` SET TAGS ('dbx_business_glossary_term' = 'Not In Good Order (NIGO) Reason');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Workflow Notes');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `prior_stage` SET TAGS ('dbx_business_glossary_term' = 'Prior Workflow Stage');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent|critical');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `quality_control_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Status');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `quality_control_status` SET TAGS ('dbx_value_regex' = 'pending|passed|failed|waived|not_required');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `quality_control_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `sla_breach_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `sla_due_date` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Due Date');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Source Channel');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `total_documents_indexed` SET TAGS ('dbx_business_glossary_term' = 'Total Documents Indexed');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `total_pages_scanned` SET TAGS ('dbx_business_glossary_term' = 'Total Pages Scanned');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `workflow_number` SET TAGS ('dbx_business_glossary_term' = 'Workflow Number');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `workflow_status` SET TAGS ('dbx_business_glossary_term' = 'Workflow Status');
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ALTER COLUMN `workflow_type` SET TAGS ('dbx_business_glossary_term' = 'Workflow Type');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` SET TAGS ('dbx_subdomain' = 'compliance_governance');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `legal_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold ID');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `claim_investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Investigation Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `report_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Report Definition Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `superseded_by_hold_legal_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Legal Hold ID');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `acknowledgment_count` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Count');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `acknowledgment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Required Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Legal Hold Cost');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `actual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `affected_claim_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Claim Count');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `affected_document_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Document Count');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `affected_policy_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Policy Count');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `automated_purge_suspended_flag` SET TAGS ('dbx_business_glossary_term' = 'Automated Purge Suspended Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `chain_of_custody_log` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody Log');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `chain_of_custody_log` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `custodian_of_record` SET TAGS ('dbx_business_glossary_term' = 'Custodian of Record');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `custodian_of_record` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `date_range_end` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Date Range End');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `date_range_start` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Date Range Start');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `document_type_scope` SET TAGS ('dbx_business_glossary_term' = 'Document Type Scope');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Effective Date');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Legal Hold Cost');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Expiration Date');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `external_counsel_firm` SET TAGS ('dbx_business_glossary_term' = 'External Counsel Firm');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `external_counsel_firm` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `hold_number` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Number');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `hold_number` SET TAGS ('dbx_value_regex' = '^LH-[0-9]{8}$');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Status');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_value_regex' = 'active|pending review|released|expired|superseded');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Type');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_value_regex' = 'litigation|regulatory examination|market conduct investigation|fraud investigation|internal audit|compliance review');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `issuing_authority_type` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority Type');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `issuing_authority_type` SET TAGS ('dbx_value_regex' = 'internal legal counsel|external legal counsel|compliance officer|state regulator|federal regulator|court order');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `matter_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Matter Name');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `matter_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `matter_number` SET TAGS ('dbx_business_glossary_term' = 'Legal Matter Number');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `matter_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Notes');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Notification Sent Date');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Priority Level');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `release_authorized_by` SET TAGS ('dbx_business_glossary_term' = 'Release Authorized By');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `release_authorized_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Release Date');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `retention_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Retention Override Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `review_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Review Frequency Days');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Scope Description');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `scope_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`document`.`template` SET TAGS ('dbx_subdomain' = 'content_management');
ALTER TABLE `life_insurance_ecm`.`document`.`template` ALTER COLUMN `template_id` SET TAGS ('dbx_business_glossary_term' = 'Document Template Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`template` ALTER COLUMN `acord_form_id` SET TAGS ('dbx_business_glossary_term' = 'Acord Form Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`template` ALTER COLUMN `superseded_by_template_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Template Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`template` ALTER COLUMN `acord_form_indicator` SET TAGS ('dbx_business_glossary_term' = 'Association for Cooperative Operations Research and Development (ACORD) Form Indicator');
ALTER TABLE `life_insurance_ecm`.`document`.`template` ALTER COLUMN `aml_kyc_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) / Know Your Customer (KYC) Required Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`template` ALTER COLUMN `applicable_jurisdictions` SET TAGS ('dbx_business_glossary_term' = 'Applicable Jurisdictions');
ALTER TABLE `life_insurance_ecm`.`document`.`template` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `life_insurance_ecm`.`document`.`template` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `life_insurance_ecm`.`document`.`template` ALTER COLUMN `authoring_system` SET TAGS ('dbx_business_glossary_term' = 'Authoring System');
ALTER TABLE `life_insurance_ecm`.`document`.`template` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`template` ALTER COLUMN `doi_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Department of Insurance (DOI) Approval Date');
ALTER TABLE `life_insurance_ecm`.`document`.`template` ALTER COLUMN `doi_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Department of Insurance (DOI) Approval Number');
ALTER TABLE `life_insurance_ecm`.`document`.`template` ALTER COLUMN `doi_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Department of Insurance (DOI) Approval Status');
ALTER TABLE `life_insurance_ecm`.`document`.`template` ALTER COLUMN `doi_approval_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|conditionally_approved|rejected|withdrawn');
ALTER TABLE `life_insurance_ecm`.`document`.`template` ALTER COLUMN `e_delivery_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Delivery (E-Delivery) Eligible Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`template` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`document`.`template` ALTER COLUMN `electronic_signature_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Signature Allowed Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`template` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `life_insurance_ecm`.`document`.`template` ALTER COLUMN `file_path` SET TAGS ('dbx_business_glossary_term' = 'Template File Path');
ALTER TABLE `life_insurance_ecm`.`document`.`template` ALTER COLUMN `file_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`template` ALTER COLUMN `format` SET TAGS ('dbx_business_glossary_term' = 'Template Format');
ALTER TABLE `life_insurance_ecm`.`document`.`template` ALTER COLUMN `format` SET TAGS ('dbx_value_regex' = 'word|pdf|xml|xslt|html|rtf');
ALTER TABLE `life_insurance_ecm`.`document`.`template` ALTER COLUMN `generation_engine` SET TAGS ('dbx_business_glossary_term' = 'Generation Engine');
ALTER TABLE `life_insurance_ecm`.`document`.`template` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `life_insurance_ecm`.`document`.`template` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `life_insurance_ecm`.`document`.`template` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `life_insurance_ecm`.`document`.`template` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `life_insurance_ecm`.`document`.`template` ALTER COLUMN `mandatory_fields_list` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Fields List');
ALTER TABLE `life_insurance_ecm`.`document`.`template` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `life_insurance_ecm`.`document`.`template` ALTER COLUMN `nigo_tracking_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Not In Good Order (NIGO) Tracking Enabled Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`template` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Page Count');
ALTER TABLE `life_insurance_ecm`.`document`.`template` ALTER COLUMN `pii_phi_indicator` SET TAGS ('dbx_business_glossary_term' = 'Personally Identifiable Information (PII) / Protected Health Information (PHI) Indicator');
ALTER TABLE `life_insurance_ecm`.`document`.`template` ALTER COLUMN `privacy_classification` SET TAGS ('dbx_business_glossary_term' = 'Privacy Classification');
ALTER TABLE `life_insurance_ecm`.`document`.`template` ALTER COLUMN `privacy_classification` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `life_insurance_ecm`.`document`.`template` ALTER COLUMN `product_type_applicability` SET TAGS ('dbx_business_glossary_term' = 'Product Type Applicability');
ALTER TABLE `life_insurance_ecm`.`document`.`template` ALTER COLUMN `regulatory_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Required Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`template` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period Years');
ALTER TABLE `life_insurance_ecm`.`document`.`template` ALTER COLUMN `state_specific_flag` SET TAGS ('dbx_business_glossary_term' = 'State-Specific Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`template` ALTER COLUMN `template_category` SET TAGS ('dbx_business_glossary_term' = 'Template Category');
ALTER TABLE `life_insurance_ecm`.`document`.`template` ALTER COLUMN `template_code` SET TAGS ('dbx_business_glossary_term' = 'Template Code');
ALTER TABLE `life_insurance_ecm`.`document`.`template` ALTER COLUMN `template_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,20}$');
ALTER TABLE `life_insurance_ecm`.`document`.`template` ALTER COLUMN `template_description` SET TAGS ('dbx_business_glossary_term' = 'Template Description');
ALTER TABLE `life_insurance_ecm`.`document`.`template` ALTER COLUMN `template_name` SET TAGS ('dbx_business_glossary_term' = 'Template Name');
ALTER TABLE `life_insurance_ecm`.`document`.`template` ALTER COLUMN `template_status` SET TAGS ('dbx_business_glossary_term' = 'Template Status');
ALTER TABLE `life_insurance_ecm`.`document`.`template` ALTER COLUMN `template_type` SET TAGS ('dbx_business_glossary_term' = 'Template Type');
ALTER TABLE `life_insurance_ecm`.`document`.`template` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`template` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `life_insurance_ecm`.`document`.`template` ALTER COLUMN `variable_data_fields_list` SET TAGS ('dbx_business_glossary_term' = 'Variable Data Fields List');
ALTER TABLE `life_insurance_ecm`.`document`.`template` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Template Version');
ALTER TABLE `life_insurance_ecm`.`document`.`template` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}.[0-9]{1,3}(.[0-9]{1,3})?$');
ALTER TABLE `life_insurance_ecm`.`document`.`request` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`document`.`request` SET TAGS ('dbx_subdomain' = 'workflow_processing');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Document Request Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `acord_form_id` SET TAGS ('dbx_business_glossary_term' = 'Acord Form Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `annuitant_id` SET TAGS ('dbx_business_glossary_term' = 'Annuitant Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `annuity_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Annuity Contract Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Application Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `evidence_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Evidence Requirement Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfilled Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `group_member_id` SET TAGS ('dbx_business_glossary_term' = 'Group Member Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `group_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `group_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `group_sponsor_id` SET TAGS ('dbx_business_glossary_term' = 'Group Sponsor Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `insured_id` SET TAGS ('dbx_business_glossary_term' = 'Insured Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Document Package Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Policyholder Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `policyholder_beneficiary_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `premium_bill_id` SET TAGS ('dbx_business_glossary_term' = 'Requested Bill Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Producer Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `resubmitted_request_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Request Acknowledgment Date');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `aging_days` SET TAGS ('dbx_business_glossary_term' = 'Request Aging Days');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `business_transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Business Transaction Type');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `business_transaction_type` SET TAGS ('dbx_value_regex' = 'new_business|claim|policy_service|underwriting|annuity_service|reinsurance');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Request Cancellation Date');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Request Cancellation Reason');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'email|fax|postal_mail|secure_portal|phone|in_person');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Document Due Date');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `external_reference_number` SET TAGS ('dbx_business_glossary_term' = 'External Reference Number');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `follow_up_count` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Count');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `follow_up_schedule` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Schedule');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `last_follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Last Follow-Up Date');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `next_follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Next Follow-Up Date');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `nigo_flag` SET TAGS ('dbx_business_glossary_term' = 'Not In Good Order (NIGO) Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Request Notes');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Request Priority Level');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Document Received Date');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `recipient_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Recipient Address Line 1');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `recipient_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `recipient_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `recipient_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Recipient Address Line 2');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `recipient_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `recipient_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `recipient_city` SET TAGS ('dbx_business_glossary_term' = 'Recipient City');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `recipient_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `recipient_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `recipient_email` SET TAGS ('dbx_business_glossary_term' = 'Recipient Email Address');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `recipient_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `recipient_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `recipient_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `recipient_fax` SET TAGS ('dbx_business_glossary_term' = 'Recipient Fax Number');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `recipient_fax` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `recipient_fax` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `recipient_name` SET TAGS ('dbx_business_glossary_term' = 'Recipient Name');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `recipient_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `recipient_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `recipient_phone` SET TAGS ('dbx_business_glossary_term' = 'Recipient Phone Number');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `recipient_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `recipient_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `recipient_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Recipient Postal Code');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `recipient_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `recipient_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `recipient_state` SET TAGS ('dbx_business_glossary_term' = 'Recipient State');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `recipient_type` SET TAGS ('dbx_business_glossary_term' = 'Recipient Type');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Document Request Date');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Document Request Number');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Document Request Status');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `request_status` SET TAGS ('dbx_value_regex' = 'sent|acknowledged|received|overdue|cancelled|pending');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `request_type` SET TAGS ('dbx_business_glossary_term' = 'Document Request Type');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `requested_document_type_code` SET TAGS ('dbx_business_glossary_term' = 'Requested Document Type Code');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `requestor_name` SET TAGS ('dbx_business_glossary_term' = 'Requestor Name');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `requestor_role` SET TAGS ('dbx_business_glossary_term' = 'Requestor Role');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `requestor_role` SET TAGS ('dbx_value_regex' = 'underwriter|claims_examiner|service_representative|case_manager|compliance_officer|actuarial_analyst');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Sent Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `sla_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Met Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `sla_target_days` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Days');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `life_insurance_ecm`.`document`.`request` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` SET TAGS ('dbx_subdomain' = 'workflow_processing');
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` ALTER COLUMN `correspondence_link_id` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Link Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` ALTER COLUMN `annuity_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Annuity Contract Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Application Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` ALTER COLUMN `communication_id` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Document Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` ALTER COLUMN `legal_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Policyholder Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Linked By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Producer Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` ALTER COLUMN `superseded_correspondence_link_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` ALTER COLUMN `attachment_flag` SET TAGS ('dbx_business_glossary_term' = 'Attachment Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` ALTER COLUMN `business_context` SET TAGS ('dbx_business_glossary_term' = 'Business Context');
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Direction');
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` ALTER COLUMN `direction` SET TAGS ('dbx_value_regex' = 'inbound|outbound');
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` ALTER COLUMN `link_method` SET TAGS ('dbx_business_glossary_term' = 'Link Method');
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` ALTER COLUMN `link_method` SET TAGS ('dbx_value_regex' = 'manual|automatic|batch|api|workflow');
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` ALTER COLUMN `link_status` SET TAGS ('dbx_business_glossary_term' = 'Link Status');
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` ALTER COLUMN `link_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived|deleted|pending');
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` ALTER COLUMN `link_type` SET TAGS ('dbx_business_glossary_term' = 'Link Type');
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` ALTER COLUMN `link_type` SET TAGS ('dbx_value_regex' = 'generated|received|attached|referenced|superseded|related');
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` ALTER COLUMN `linked_by_system` SET TAGS ('dbx_business_glossary_term' = 'Linked By System');
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` ALTER COLUMN `linked_date` SET TAGS ('dbx_business_glossary_term' = 'Linked Date');
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` ALTER COLUMN `linked_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Linked Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` ALTER COLUMN `primary_document_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Document Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` ALTER COLUMN `retention_end_date` SET TAGS ('dbx_business_glossary_term' = 'Retention End Date');
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` ALTER COLUMN `retention_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Retention Override Flag');
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Sequence Number');
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`document`.`document_type` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`document`.`document_type` SET TAGS ('dbx_subdomain' = 'content_management');
ALTER TABLE `life_insurance_ecm`.`document`.`document_type` ALTER COLUMN `document_type_id` SET TAGS ('dbx_business_glossary_term' = 'Document Type Identifier');
ALTER TABLE `life_insurance_ecm`.`document`.`document_type` ALTER COLUMN `parent_document_type_id` SET TAGS ('dbx_self_ref_fk' = 'true');
