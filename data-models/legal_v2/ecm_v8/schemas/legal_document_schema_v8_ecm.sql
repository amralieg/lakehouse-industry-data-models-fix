-- Schema for Domain: document | Business: Legal | Version: v8_ecm
-- Generated on: 2026-05-21 01:11:36

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `legal_ecm_v1`.`document` COMMENT 'Manages the full lifecycle of all legal documents including drafting, versioning, review, execution, and records retention. Encompasses DMS metadata from iManage Work and NetDocuments, eDiscovery ESI collections via Relativity, TAR/CAL review workflows, OCR/NLP processing outputs, privilege designations, and LPP classification. Authoritative source for document provenance and chain of custody.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `legal_ecm_v1`.`document`.`legal_document` (
    `legal_document_id` BIGINT COMMENT 'Unique identifier for the legal document. Primary key for the legal_document product.',
    `account_id` BIGINT COMMENT 'Foreign key linking to trust.trust_account. Business justification: Retainer agreements, escrow agreements, trust account opening documentation, and authorization letters are legal documents that establish or govern specific trust accounts. Required for regulatory com',
    `doc_template_id` BIGINT COMMENT 'FK to document.doc_template.doc_template_id — Documents drafted from templates should reference their source template for precedent tracking, template effectiveness analytics, and knowledge management governance.',
    `docket_id` BIGINT COMMENT 'Foreign key linking to court.docket. Business justification: Litigation documents must track which court case/docket they belong to for filing compliance, case file organization, and docket entry reconciliation. Essential for court filing workflows and case man',
    `retention_schedule_id` BIGINT COMMENT 'FK to document.retention_schedule.retention_schedule_id — Documents are subject to retention policies. This FK enables automated retention enforcement, destruction scheduling, and compliance reporting.',
    `ip_asset_id` BIGINT COMMENT 'Foreign key linking to ip.asset. Business justification: IP legal documents (patent applications, trademark filings, assignment agreements, office action responses) directly relate to specific IP assets. Core IP practice workflow requires linking documents ',
    `doc_folder_id` BIGINT COMMENT 'Foreign key linking to document.doc_folder. Business justification: legal_document has folder_path: STRING and workspace_id: STRING. doc_folder represents the DMS folder hierarchy. Documents are stored IN folders (1:N relationship). Adding doc_folder_id FK normalizes ',
    `doc_type_id` BIGINT COMMENT 'Foreign key linking to document.doc_type. Business justification: legal_document has document_type: STRING (not an FK). doc_type is the authoritative reference table for document type classifications. This is a standard lookup relationship. Adding doc_type_id FK all',
    `legal_retention_schedule_id` BIGINT COMMENT 'Foreign key linking to document.retention_schedule. Business justification: legal_document has retention_schedule: STRING (not an FK). retention_schedule is the authoritative reference table defining retention policies. Each document is governed by one retention schedule. Add',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: Documents are work product/deliverables of specific legal services. Critical for service delivery tracking, matter costing, deliverable verification against engagement scope, and billing reconciliatio',
    `matter_id` BIGINT COMMENT 'Identifier of the matter or case to which this document is associated.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Documents operationalize firm policies: conflict check memos implement conflict of interest policy, data processing agreements implement privacy policy, fee agreements implement pricing policy. Requir',
    `primary_doc_folder_id` BIGINT COMMENT 'FK to document.doc_folder.doc_folder_id — Documents are organized into DMS folders/workspaces. This FK enables workspace-based retrieval, access control inheritance, and matter-workspace association.',
    `primary_doc_type_id` BIGINT COMMENT 'FK to document.doc_type.doc_type_id — Every document has a type classification. This FK enables filtering by document type, applying retention rules, and enforcing naming conventions. Core to DMS taxonomy and retention governance.',
    `timekeeper_id` BIGINT COMMENT 'Identifier of the legal professional (timekeeper, attorney, paralegal) who authored or created the document.',
    `profile_id` BIGINT COMMENT 'Identifier of the client for whom this document was created or to whom it relates.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Documents are primary evidence artifacts substantiating identified risks (litigation filings, breach notices, regulatory correspondence). Risk registers require document references for audit trails, r',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Legal documents frequently implement or evidence compliance with specific regulatory obligations: engagement letters cite SRA Codes of Conduct, retainer agreements reference GDPR Article 6 lawful basi',
    `form_template_id` BIGINT COMMENT 'Foreign key linking to knowledge.form_template. Business justification: Court filings, regulatory submissions, and procedural documents are created from standardized form templates. Tracking source form enables form usage analytics, compliance verification that correct fo',
    `to_doc_folder_id` BIGINT COMMENT 'FK to document.doc_folder.doc_folder_id — Documents are stored within DMS folder/workspace hierarchy. This FK enables the organizational container structure described in doc_folder and is essential for workspace-based access control and matte',
    `to_doc_type_id` BIGINT COMMENT 'FK to document.doc_type.doc_type_id — Every document must be classified by type. The doc_type reference table exists specifically to classify legal_document records. Without this FK, document classification, retention policy assignment, a',
    `trade_secret_id` BIGINT COMMENT 'Foreign key linking to ip.trade_secret. Business justification: Trade secret documents (NDAs, misappropriation evidence, reasonable measures documentation) relate to specific trade secrets. Trade secret protection programs require linking documents to the secrets ',
    `tribunal_id` BIGINT COMMENT 'Foreign key linking to court.tribunal. Business justification: Documents filed with courts need tribunal reference for jurisdictional tracking, filing protocol compliance (ECF systems, local rules), and venue-specific formatting requirements. Critical for multi-j',
    `confidentiality_level` STRING COMMENT 'Classification of the documents confidentiality and access restrictions (e.g., Public, Internal, Confidential, Highly Confidential, Restricted).. Valid values are `public|internal|confidential|highly_confidential|restricted`',
    `contains_pii` BOOLEAN COMMENT 'Boolean flag indicating whether the document contains Personally Identifiable Information (PII) subject to GDPR, CCPA, or other data privacy regulations.',
    `created_date` DATE COMMENT 'Date on which the document was originally created or authored.',
    `created_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the document was originally created in the DMS, capturing the business event time for audit and chain of custody.',
    `dms_document_reference` STRING COMMENT 'Native unique identifier assigned by the source DMS system (e.g., iManage document ID, NetDocuments ndID).',
    `dms_system` STRING COMMENT 'Name of the Document Management System where the document is stored (e.g., iManage Work, NetDocuments, Relativity, SharePoint, Other).. Valid values are `imanage_work|netdocuments|relativity|sharepoint|other`',
    `document_category` STRING COMMENT 'High-level business category of the document aligned with practice area (e.g., Transactional, Litigation, Advisory, Compliance, IP, Employment, Regulatory, Corporate Governance). [ENUM-REF-CANDIDATE: transactional|litigation|advisory|compliance|ip|employment|regulatory|corporate_governance — 8 candidates stripped; promote to reference product]',
    `document_number` STRING COMMENT 'Business-facing unique document number or identifier assigned by the Document Management System (DMS). Used for external reference and tracking.',
    `document_status` STRING COMMENT 'Current lifecycle status of the document (e.g., Draft, Under Review, Approved, Executed, Archived, Obsolete, Superseded). [ENUM-REF-CANDIDATE: draft|under_review|approved|executed|archived|obsolete|superseded — 7 candidates stripped; promote to reference product]',
    `executed_date` DATE COMMENT 'Date on which the document was executed, signed, or became legally effective (applicable to contracts, agreements, and other binding documents).',
    `expiration_date` DATE COMMENT 'Date on which the document expires or ceases to be effective (applicable to agreements, licenses, and time-bound documents).',
    `file_extension` STRING COMMENT 'File format extension indicating the document type (e.g., docx, pdf, xlsx, pptx, msg, eml, txt, rtf, html, xml). [ENUM-REF-CANDIDATE: docx|pdf|xlsx|pptx|msg|eml|txt|rtf|html|xml — 10 candidates stripped; promote to reference product]',
    `file_name` STRING COMMENT 'Original file name of the document as stored in the DMS, including file extension (e.g., Contract_Draft_v2.docx).',
    `file_size_bytes` BIGINT COMMENT 'Size of the document file in bytes, used for storage management and transfer tracking.',
    `hash_value` DECIMAL(18,2) COMMENT 'Cryptographic hash (e.g., MD5, SHA-256) of the document file, used for integrity verification, deduplication, and chain of custody in eDiscovery.',
    `is_current_version` BOOLEAN COMMENT 'Boolean flag indicating whether this version is the current active version of the document (True) or a historical version (False).',
    `keywords` STRING COMMENT 'Comma-separated list of keywords or tags associated with the document for search, categorization, and knowledge management.',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code indicating the primary language of the document (e.g., EN for English, FR for French, ES for Spanish).',
    `legal_document_description` STRING COMMENT 'Free-text description or summary of the documents content, purpose, and context, used for search and reference.',
    `legal_hold_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the document is subject to a legal hold (litigation hold, preservation order) preventing its destruction.',
    `mime_type` STRING COMMENT 'Multipurpose Internet Mail Extensions (MIME) type of the document file (e.g., application/pdf, application/vnd.openxmlformats-officedocument.wordprocessingml.document).',
    `modified_date` DATE COMMENT 'Date on which the document was last modified or updated.',
    `modified_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the document was last modified, used for version control and audit trail.',
    `nlp_processed` BOOLEAN COMMENT 'Boolean flag indicating whether the document has been processed through Natural Language Processing (NLP) for entity extraction, sentiment analysis, or other AI-driven analysis.',
    `ocr_processed` BOOLEAN COMMENT 'Boolean flag indicating whether the document has been processed through Optical Character Recognition (OCR) to extract text from images or scanned documents.',
    `page_count` STRING COMMENT 'Total number of pages in the document, used for billing, review planning, and document management.',
    `privilege_status` STRING COMMENT 'Designation indicating whether the document is protected by Legal Professional Privilege (LPP), attorney-client privilege, work product doctrine, or is non-privileged. Critical for eDiscovery and disclosure obligations.. Valid values are `privileged|non_privileged|work_product|attorney_client|pending_review`',
    `retention_end_date` DATE COMMENT 'Date on which the retention period expires and the document becomes eligible for destruction, unless subject to legal hold.',
    `review_status` STRING COMMENT 'Status of the document within the eDiscovery review workflow (e.g., Not Reviewed, Under Review, Reviewed, Responsive, Non-Responsive, Privileged, Redacted, Produced). [ENUM-REF-CANDIDATE: not_reviewed|under_review|reviewed|responsive|non_responsive|privileged|redacted|produced — 8 candidates stripped; promote to reference product]',
    `source_precedent_id` BIGINT COMMENT 'Foreign key linking to knowledge.precedent. Business justification: Documents are frequently drafted from firm precedents. Tracking source precedent enables precedent effectiveness analytics, usage metrics for knowledge management, and audit trail for document provena',
    `storage_location` STRING COMMENT 'Physical or logical storage path or URI where the document is stored in the DMS (e.g., iManage workspace path, NetDocuments cabinet/folder path, cloud storage URI).',
    `title` STRING COMMENT 'The title or name of the legal document as displayed in the DMS and used for identification by legal professionals.',
    `version_number` STRING COMMENT 'Version identifier for the document, tracking revisions and iterations (e.g., 1.0, 2.1, 3.0).',
    `workspace_code` STRING COMMENT 'Identifier of the DMS workspace, cabinet, or container where the document resides, used for organizational hierarchy and access control.',
    CONSTRAINT pk_legal_document PRIMARY KEY(`legal_document_id`)
) COMMENT 'Master record for every legal document managed within the firms DMS (iManage Work, NetDocuments). Captures document identity, classification, matter association, author, version lineage, LPP/privilege status, retention schedule, and chain-of-custody provenance. Serves as the authoritative SSOT for all document metadata across the document lifecycle from drafting through archival.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`document`.`doc_version` (
    `doc_version_id` BIGINT COMMENT 'Unique identifier for this specific version of a legal document. Primary key for the document version entity. Serves as the authoritative reference for version-level tracking in Document Management System (DMS) and eDiscovery platforms.',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter or case to which this document version belongs. Enables matter-level document organization and retrieval for litigation, transactions, and advisory work.',
    `legal_document_id` BIGINT COMMENT 'Reference to the parent document entity. Links this version to the master document record that spans all versions. Essential for version lineage and rollback capability.',
    `timekeeper_id` BIGINT COMMENT 'Reference to the timekeeper or user who created this version. Establishes authorship for attribution, billing, and chain of custody in eDiscovery.',
    `reviewer_timekeeper_id` BIGINT COMMENT 'Reference to the timekeeper or contract attorney who reviewed this version for responsiveness and privilege. Null if not yet reviewed. Supports quality control and billing for review work.',
    `bates_number` STRING COMMENT 'Unique Bates stamp or control number assigned to this version during eDiscovery production. Provides a permanent, sequential identifier for produced documents and facilitates citation in legal proceedings.',
    `change_summary` STRING COMMENT 'Brief description of changes made in this version compared to the previous version. Authored by the user during check-in. Supports version comparison and audit trails.',
    `checked_in_timestamp` TIMESTAMP COMMENT 'Timestamp when this version was checked back into the DMS after editing. Marks the completion of the edit session and availability for others to access.',
    `checked_out_timestamp` TIMESTAMP COMMENT 'Timestamp when this version was checked out for editing. Null if currently checked in. Used to track document lock duration and identify stale checkouts.',
    `confidentiality_level` STRING COMMENT 'Business confidentiality classification of this document version. Governs access controls, sharing restrictions, and handling procedures. Distinct from data classification tags which focus on PII/PHI/PCI.. Valid values are `public|internal|confidential|highly_confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this version was created in the Document Management System (DMS). Critical for establishing document provenance and chain of custody for eDiscovery and LPP compliance.',
    `extracted_text` STRING COMMENT 'Full text content extracted from the document via OCR or native text extraction. Enables full-text search, keyword analysis, and TAR/Continuous Active Learning (CAL) model training. May be very large; consider external storage for production systems.',
    `file_format` STRING COMMENT 'MIME type or file format of this version (e.g., application/pdf, application/vnd.openxmlformats-officedocument.wordprocessingml.document). Critical for rendering, conversion, and eDiscovery processing.',
    `file_hash` STRING COMMENT 'Cryptographic hash (e.g., SHA-256) of the file content. Ensures file integrity, detects tampering, and supports deduplication in eDiscovery collections. Critical for chain of custody.',
    `file_name` STRING COMMENT 'Original file name of this document version as stored in the DMS. Includes file extension. Essential for user recognition and file system integration.',
    `file_size_bytes` BIGINT COMMENT 'Size of the document version file in bytes. Used for storage management, transfer planning, and eDiscovery volume estimation.',
    `is_current_version` BOOLEAN COMMENT 'Boolean flag indicating whether this version is the current authoritative copy of the document. Only one version per document should be marked as current at any time.',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code of the document content (e.g., en, fr, de). Detected via Natural Language Processing (NLP) or set manually. Essential for multilingual matter management and translation workflows.',
    `legal_hold_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this version is subject to a legal hold (litigation hold) that suspends normal retention and disposition. Prevents destruction of potentially relevant evidence.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the last modification to this versions metadata or content. Distinct from created_timestamp; tracks subsequent updates to the version record.',
    `nlp_entities_extracted` STRING COMMENT 'JSON or delimited list of named entities extracted from the document via Natural Language Processing (NLP) (e.g., person names, organizations, dates, monetary amounts). Enables advanced search, analytics, and contract intelligence.',
    `ocr_confidence_score` DECIMAL(18,2) COMMENT 'Confidence score (0.00 to 100.00) indicating the OCR engines certainty in the accuracy of extracted text. Low scores flag documents requiring manual review. Critical for TAR model training quality.',
    `ocr_engine` STRING COMMENT 'Name and version of the OCR engine used to process this version (e.g., Tesseract 4.1, ABBYY FineReader 15, Adobe Acrobat DC). Documents processing provenance for eDiscovery defensibility.',
    `ocr_processed_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this version has been processed through Optical Character Recognition (OCR) to extract text from images or scanned documents. Required for full-text search and Technology-Assisted Review (TAR).',
    `page_count` STRING COMMENT 'Total number of pages in this document version. Used for billing (per-page review fees), eDiscovery volume metrics, and production planning.',
    `privilege_designation` STRING COMMENT 'Classification of this versions privilege status under Legal Professional Privilege (LPP) or attorney-client privilege. Critical for eDiscovery privilege logs and redaction workflows.. Valid values are `privileged|non_privileged|work_product|pending_review`',
    `production_date` DATE COMMENT 'Date when this version was produced to external parties. Null if never produced. Essential for tracking disclosure timelines and compliance with discovery deadlines.',
    `production_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this version has been produced (disclosed) to opposing parties or regulators in eDiscovery or regulatory response. Tracks disclosure history for privilege and confidentiality management.',
    `redacted_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this version contains redactions (e.g., for privilege, confidentiality, or Personally Identifiable Information (PII) protection). Signals special handling for productions and disclosures.',
    `redaction_reason` STRING COMMENT 'Explanation of why redactions were applied to this version (e.g., Attorney-client privilege, Trade secret, PII protection). Required for privilege logs and transparency in eDiscovery productions.',
    `retention_category` STRING COMMENT 'Records retention category assigned to this version based on document type and regulatory requirements. Determines retention period and disposition rules per the firms records retention schedule.',
    `retention_expiry_date` DATE COMMENT 'Date when this version becomes eligible for disposition (archival or destruction) per the retention schedule. Null if retention is indefinite. Critical for compliance with data protection regulations and storage cost management.',
    `review_status` STRING COMMENT 'Current review status of this version in the eDiscovery workflow. Tracks progression through document review, responsiveness determination, and privilege screening. Essential for Technology-Assisted Review (TAR) and Continuous Active Learning (CAL) workflows.. Valid values are `not_reviewed|in_review|responsive|non_responsive|privileged`',
    `review_timestamp` TIMESTAMP COMMENT 'Timestamp when this version was reviewed. Null if not yet reviewed. Used for productivity tracking, billing, and audit trails in eDiscovery projects.',
    `storage_path` STRING COMMENT 'Physical or logical storage path where this version is stored in the DMS or cloud repository (e.g., iManage workspace path, NetDocuments cabinet/folder path). Confidential for security reasons.',
    `tar_relevance_score` DECIMAL(18,2) COMMENT 'Relevance score (0.00 to 100.00) assigned by a Technology-Assisted Review (TAR) or Continuous Active Learning (CAL) model. Higher scores indicate greater predicted relevance to the matter. Supports prioritization of review efforts.',
    `version_label` STRING COMMENT 'Human-readable version label or tag assigned by the author (e.g., Draft 1, Final, Executed, Client Review). Provides business context beyond numeric versioning.',
    `version_number` STRING COMMENT 'Sequential version number for this document iteration. Increments with each new version. Critical for version control, audit trails, and Legal Professional Privilege (LPP) compliance.',
    `version_status` STRING COMMENT 'Current lifecycle status of this document version. Tracks progression through drafting, review, approval, execution, and archival stages. Essential for workflow management and compliance. [ENUM-REF-CANDIDATE: draft|in_review|approved|final|executed|superseded|archived — 7 candidates stripped; promote to reference product]',
    `word_count` STRING COMMENT 'Total word count extracted from the document content. Supports readability analysis, billing (per-word translation fees), and content complexity assessment.',
    CONSTRAINT pk_doc_version PRIMARY KEY(`doc_version_id`)
) COMMENT 'Tracks every version of a legal document stored in the DMS including full content metadata. Records version number, author, timestamp, change summary, check-in/check-out state, file format, file size, whether the version is the current authoritative copy, and any OCR/NLP processing outputs (extracted text, confidence score, extraction engine, language detected). Supports full version lineage, rollback capability, full-text search enablement, and TAR model training — all required for LPP compliance and eDiscovery chain-of-custody.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`document`.`doc_type` (
    `doc_type_id` BIGINT COMMENT 'Unique identifier for the document type. Primary key.',
    `agreement_type_id` BIGINT COMMENT 'Foreign key linking to contract.agreement_type. Business justification: Document types map to agreement types for template selection and automated classification. When creating an NDA document, the doc_type determines which agreement_type template to use. Essential for co',
    `doc_template_id` BIGINT COMMENT 'Reference to the default document template or precedent for this document type in the knowledge management system (e.g., Thomson Reuters Practical Law template ID). Enables automated document generation.',
    `practice_area_id` BIGINT COMMENT 'Foreign key to service.practice_area.practice_area_id',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Document type definitions encode regulatory requirements: SRA-mandated client care letters, GDPR-required privacy notices, court-mandated disclosure statements. Essential for document generation workf',
    `approval_workflow_required` BOOLEAN COMMENT 'Indicates whether documents of this type require formal approval workflow (partner review, client approval, compliance sign-off) before finalization or execution.',
    `billable_activity` BOOLEAN COMMENT 'Indicates whether time spent drafting, reviewing, or managing documents of this type is typically billable to clients (true for client-facing work product; false for internal administrative documents).',
    `chain_of_custody_tracking` BOOLEAN COMMENT 'Indicates whether documents of this type require formal chain of custody tracking for evidentiary purposes (e.g., exhibits, evidence, forensic documents require chain of custody; routine correspondence does not).',
    `court_filing_eligible` BOOLEAN COMMENT 'Indicates whether documents of this type can be filed with courts or tribunals via Electronic Case Filing (ECF) systems. True for pleadings, motions, briefs, exhibits; false for internal work product.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this document type classification record was first created in the system.',
    `default_privilege_classification` STRING COMMENT 'Default privilege designation for documents of this type: privileged (attorney-client privilege), work_product (attorney work product doctrine), confidential (business confidential but not privileged), public (no privilege or confidentiality). Used in eDiscovery and document review workflows.. Valid values are `privileged|work_product|confidential|public`',
    `dms_folder_path_template` STRING COMMENT 'Standard folder path template in the DMS for storing documents of this type (e.g., /Matters/{matter_id}/Agreements/{doc_type_code}, /Matters/{matter_id}/Pleadings/{doc_type_code}). Supports automated filing and retrieval.',
    `doc_type_category` STRING COMMENT 'High-level classification of the document type by legal practice area: transactional (contracts, agreements), litigation (pleadings, motions, briefs), intellectual property (patents, trademarks), corporate (resolutions, governance), regulatory (compliance filings), advisory (opinions, memos), administrative (engagement letters, billing). [ENUM-REF-CANDIDATE: transactional|litigation|ip|corporate|regulatory|advisory|administrative — 7 candidates stripped; promote to reference product]',
    `doc_type_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the document type (e.g., NDA, SPA, POA, LOE, BRIEF, AFFIDAVIT). Used for system integration and DMS folder taxonomy.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `doc_type_description` STRING COMMENT 'Detailed description of the document type, including its purpose, typical use cases, key characteristics, and any special handling requirements. Provides guidance to attorneys and staff on when to use this classification.',
    `doc_type_name` STRING COMMENT 'Full descriptive name of the document type (e.g., Non-Disclosure Agreement, Share Purchase Agreement, Power of Attorney, Letter of Engagement, Pleading, Brief, Affidavit, Court Order, Patent Application, Trademark Filing, Board Resolution, Engagement Letter).',
    `doc_type_status` STRING COMMENT 'Current lifecycle status of this document type classification: active (in current use), deprecated (phased out but historical documents exist), archived (no longer used, retained for records), under_review (being evaluated for changes).. Valid values are `active|deprecated|archived|under_review`',
    `ediscovery_reviewable` BOOLEAN COMMENT 'Indicates whether documents of this type are subject to eDiscovery review and production in litigation (e.g., emails, contracts, memos are reviewable; attorney work product may be withheld). Used in Relativity TAR/CAL workflows.',
    `effective_date` DATE COMMENT 'Date when this document type classification became effective and available for use in the DMS and practice management systems.',
    `encryption_required` BOOLEAN COMMENT 'Indicates whether documents of this type must be encrypted at rest and in transit due to sensitivity (e.g., documents containing trade secrets, M&A deal documents, client financial information).',
    `end_date` DATE COMMENT 'Date when this document type classification was deprecated or archived. Null for active document types.',
    `external_sharing_allowed` BOOLEAN COMMENT 'Indicates whether documents of this type can be shared with external parties (clients, opposing counsel, courts) or are restricted to internal use only (e.g., internal strategy memos, conflict check results are internal-only).',
    `jurisdiction_scope` STRING COMMENT 'Geographic or legal jurisdiction scope for documents of this type (e.g., US Federal, New York State, England and Wales, EU, International). Determines applicable law and filing requirements.',
    `matter_association_required` BOOLEAN COMMENT 'Indicates whether documents of this type must be associated with a specific client matter in the practice management system (Elite 3E). True for all client work product; false for firm-wide administrative documents.',
    `metadata_preservation_critical` BOOLEAN COMMENT 'Indicates whether preservation of document metadata (author, creation date, modification history, email headers) is critical for legal or evidentiary purposes. True for ESI in litigation; false for routine business documents.',
    `modified_by` STRING COMMENT 'Username or identifier of the user who last modified this document type classification record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this document type classification record was last modified.',
    `naming_convention_pattern` STRING COMMENT 'Standard naming pattern for documents of this type (e.g., {matter_number}_{doc_type_code}_{party_name}_{version}_{date}.docx). Ensures consistent document identification and version control.',
    `nlp_extraction_enabled` BOOLEAN COMMENT 'Indicates whether documents of this type are processed through NLP pipelines to extract entities, clauses, obligations, dates, parties, and other structured metadata for contract analytics and legal AI applications.',
    `ocr_required` BOOLEAN COMMENT 'Indicates whether documents of this type require OCR processing to extract text from scanned images or PDFs for full-text search and NLP analysis.',
    `pii_likely` BOOLEAN COMMENT 'Indicates whether documents of this type are likely to contain PII requiring GDPR, CCPA, or other data privacy compliance measures (e.g., employment agreements, client intake forms contain PII; corporate resolutions typically do not).',
    `redaction_protocol` STRING COMMENT 'Level of redaction protocol required for documents of this type when produced in discovery or released publicly: none (no redaction needed), standard (redact PII and confidential business information per standard rules), enhanced (additional redaction for trade secrets, privileged content), custom (case-specific redaction rules apply).. Valid values are `none|standard|enhanced|custom`',
    `regulatory_framework` STRING COMMENT 'Primary regulatory or legal framework governing documents of this type (e.g., Securities Act of 1933 for prospectuses, GDPR for data processing agreements, Patent Cooperation Treaty for PCT applications). Informs compliance requirements.',
    `requires_conflict_check` BOOLEAN COMMENT 'Indicates whether creation of documents of this type triggers a mandatory conflict check in Intapp Conflicts (e.g., engagement letters, new matter documents require conflict checks; routine correspondence does not).',
    `requires_execution` BOOLEAN COMMENT 'Indicates whether documents of this type require formal execution (signature, seal, notarization) to be legally binding. True for contracts, agreements, powers of attorney; false for internal memos, research notes, drafts.',
    `requires_notarization` BOOLEAN COMMENT 'Indicates whether documents of this type require notarization for legal validity (e.g., powers of attorney, affidavits, certain real estate documents).',
    `requires_witness` BOOLEAN COMMENT 'Indicates whether documents of this type require witness signatures for legal validity (e.g., wills, certain contracts).',
    `retention_category` STRING COMMENT 'Records retention classification determining how long documents of this type must be preserved: permanent (indefinite), long_term (10+ years), medium_term (5-10 years), short_term (1-5 years), event_based (retained until triggering event plus specified period).. Valid values are `permanent|long_term|medium_term|short_term|event_based`',
    `retention_period_years` STRING COMMENT 'Minimum number of years documents of this type must be retained after creation or matter closure. Null for permanent or event-based retention categories.',
    `subcategory` STRING COMMENT 'Detailed classification within the category (e.g., M&A agreement, employment contract, patent prosecution, trademark opposition, motion to dismiss, discovery request, board minutes, regulatory filing).',
    `usage_guidance` STRING COMMENT 'Instructions and best practices for using this document type, including when to apply this classification, required metadata, approval processes, and common pitfalls to avoid.',
    `utbms_task_code` STRING COMMENT 'UTBMS task code aligned with this document type for billing and matter management purposes (e.g., L110 for case assessment, L310 for pleadings, C100 for due diligence). Enables standardized legal billing and activity tracking.. Valid values are `^[A-Z][0-9]{3}$`',
    `version_control_required` BOOLEAN COMMENT 'Indicates whether documents of this type must be tracked with formal version control in the DMS (major/minor version numbering, change tracking, approval workflows). True for contracts, agreements, policies; false for one-off correspondence.',
    `created_by` STRING COMMENT 'Username or identifier of the user who created this document type classification record.',
    CONSTRAINT pk_doc_type PRIMARY KEY(`doc_type_id`)
) COMMENT 'Reference classification of legal document types used across the firm (e.g., NDA, SPA, POA, LOE, pleading, brief, affidavit, court order, patent application, trademark filing, board resolution, engagement letter). Includes UTBMS task code alignment, retention category, and default privilege classification. Governs document naming conventions and DMS folder taxonomy.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`document`.`doc_folder` (
    `doc_folder_id` BIGINT COMMENT 'Unique identifier for the document folder within the Document Management System (DMS). Primary key for the doc_folder entity.',
    `aml_kyc_program_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_kyc_program. Business justification: Matter workspaces segregate AML/KYC documentation by program version for audit trail: client due diligence folders organized under AML program v2.3, source of wealth documentation under enhanced due d',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter this folder is associated with. Links the folder to a specific case or engagement for matter-centric document organization.',
    `parent_doc_folder_id` BIGINT COMMENT 'Reference to the parent folder in the DMS hierarchy. Enables hierarchical folder structure traversal and nested workspace organization. Null for root-level folders.',
    `patent_family_id` BIGINT COMMENT 'Foreign key linking to ip.patent_family. Business justification: IP prosecution folders are often organized by patent family rather than individual patents, grouping all continuations, divisionals, and foreign counterparts. Standard prosecution workflow for managin',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Workspace/folder structures align to practice areas for access control, security classification, and knowledge organization. Essential for workspace provisioning, ethical walls, and taxonomy managemen',
    `profile_id` BIGINT COMMENT 'Reference to the client this folder is associated with. Enables client-level document organization and access control.',
    `workspace_id` BIGINT COMMENT 'External system identifier for the workspace in iManage Work or NetDocuments. Used for integration and synchronization with source DMS platforms.',
    `access_control_group` STRING COMMENT 'Name or identifier of the security group that governs read/write/delete permissions for this folder. Typically maps to Active Directory groups or DMS-native security groups.',
    `archived_date` DATE COMMENT 'Date when the folder was moved to archive storage tier. Indicates transition from active to long-term retention storage with reduced access frequency.',
    `audit_log_enabled` BOOLEAN COMMENT 'Indicates whether detailed access and modification audit logging is enabled for this folder. True when audit logging is active for compliance and security monitoring.',
    `closed_date` DATE COMMENT 'Date when the folder was closed, typically aligned with matter closure. Triggers retention period calculation and access restriction workflows.',
    `collaboration_enabled` BOOLEAN COMMENT 'Indicates whether real-time collaboration features (co-authoring, commenting, annotations) are enabled for documents in this folder. True when collaboration is active.',
    `confidentiality_agreement_required` BOOLEAN COMMENT 'Indicates whether users must acknowledge a Non-Disclosure Agreement (NDA) or confidentiality agreement before accessing this folder. True when NDA is required.',
    `created_by_user_code` STRING COMMENT 'User identifier of the person who created this folder in the DMS. Used for audit trail and provisioning accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this folder was first created in the DMS. Represents the workspace provisioning event.',
    `dms_source_system` STRING COMMENT 'Identifies the source DMS platform from which this folder metadata was ingested. Supports multi-DMS environments and data lineage tracking.. Valid values are `imanage_work|netdocuments|relativity|sharepoint|other`',
    `doc_folder_description` STRING COMMENT 'Free-text description of the folders purpose, scope, or contents. Provides additional context for workspace identification and search.',
    `document_count` STRING COMMENT 'Total number of documents currently stored within this folder, excluding subfolders. Used for capacity planning and workspace analytics.',
    `encryption_enabled` BOOLEAN COMMENT 'Indicates whether documents in this folder are encrypted at rest and in transit. True when encryption is enforced per security classification requirements.',
    `ethical_wall_flag` BOOLEAN COMMENT 'Indicates whether this folder is subject to an ethical wall (information barrier) to prevent conflicts of interest. True when ethical wall restrictions apply.',
    `external_reference_number` STRING COMMENT 'External identifier or reference number associated with this folder, such as a court case number, transaction code, or client project identifier. Enables cross-system correlation.',
    `external_sharing_allowed` BOOLEAN COMMENT 'Indicates whether documents in this folder may be shared with external parties (clients, opposing counsel, third parties). True when external sharing is permitted per security policy.',
    `folder_name` STRING COMMENT 'Human-readable name of the folder as displayed in the DMS. Typically reflects the matter name, document category, or organizational purpose.',
    `folder_path` STRING COMMENT 'Full hierarchical path from root to this folder, typically in forward-slash notation (e.g., /Client/Matter/Correspondence). Enables breadcrumb navigation and path-based search.',
    `folder_status` STRING COMMENT 'Current lifecycle status of the folder. Active folders are in use, closed folders are complete but retained, archived folders are moved to long-term storage, suspended folders are temporarily inactive, and pending_deletion folders are marked for removal.. Valid values are `active|closed|archived|suspended|pending_deletion`',
    `folder_type` STRING COMMENT 'Classification of the folder purpose within the DMS. Distinguishes between matter workspaces, client-level folders, project folders, administrative containers, templates, and archived workspaces.. Valid values are `matter_workspace|client_workspace|project_workspace|administrative|template|archive`',
    `jurisdiction_code` STRING COMMENT 'Legal jurisdiction code governing the matter or documents within this folder (e.g., US-NY, GB-ENG, EU). Determines applicable regulatory and retention requirements.',
    `last_accessed_timestamp` TIMESTAMP COMMENT 'Date and time when any document within this folder was last accessed by any user. Used for inactive workspace identification and archival candidate analysis.',
    `legal_hold_flag` BOOLEAN COMMENT 'Indicates whether this folder is subject to a legal hold or litigation hold, preventing deletion or modification regardless of retention policy. True when hold is active.',
    `legal_hold_reference` STRING COMMENT 'Reference number or identifier of the legal hold order or litigation matter requiring preservation of this folder. Populated when legal_hold_flag is true.',
    `modified_by_user_code` STRING COMMENT 'User identifier of the person who last modified folder metadata (name, permissions, classification). Used for change tracking and audit compliance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when folder metadata was last modified. Tracks the most recent change to folder properties, permissions, or classification.',
    `owner_user_code` STRING COMMENT 'User identifier of the folder owner or primary responsible attorney. Typically the matter partner or lead counsel with administrative rights over the workspace.',
    `parent_hierarchy` BIGINT COMMENT 'FK to document.doc_folder.doc_folder_id — Folders have a parent-child hierarchy (workspace > client > matter > subfolder). Self-referential FK required for hierarchy traversal and access inheritance.',
    `privilege_designation` STRING COMMENT 'Legal privilege classification applied to the folder and its contents. Attorney-client privilege protects confidential communications, work product protects litigation preparation materials, joint defense covers shared defense materials, and settlement covers negotiation documents.. Valid values are `none|attorney_client|work_product|joint_defense|settlement`',
    `retention_end_date` DATE COMMENT 'Calculated date when the retention period expires and the folder becomes eligible for disposition review or deletion per retention policy.',
    `retention_policy_code` STRING COMMENT 'Code identifying the records retention policy applied to this folder. Determines minimum retention period and disposition rules per regulatory and firm policy requirements.',
    `retention_start_date` DATE COMMENT 'Date from which the retention period begins, typically the matter close date or document finalization date. Used to calculate disposition eligibility.',
    `security_classification` STRING COMMENT 'Data classification level governing access and handling requirements for all documents within this folder. Privileged designation indicates Legal Professional Privilege (LPP) protection.. Valid values are `public|internal|confidential|restricted|privileged`',
    `subfolder_count` STRING COMMENT 'Total number of immediate child folders within this folder. Used for hierarchy depth analysis and navigation optimization.',
    `sync_enabled` BOOLEAN COMMENT 'Indicates whether this folder is enabled for offline synchronization or desktop sync in the DMS client application. True when sync is enabled.',
    `total_storage_bytes` BIGINT COMMENT 'Total storage size in bytes consumed by all documents within this folder, excluding subfolders. Used for storage capacity management and billing allocation.',
    `version_control_enabled` BOOLEAN COMMENT 'Indicates whether document version control and check-in/check-out workflows are enforced for documents in this folder. True when version control is active.',
    `workspace_template_code` STRING COMMENT 'Code identifying the template used to provision this workspace or folder structure. Enables standardized folder hierarchies for matter types (e.g., M&A, Litigation, IP).',
    CONSTRAINT pk_doc_folder PRIMARY KEY(`doc_folder_id`)
) COMMENT 'Represents the DMS folder and workspace hierarchy within iManage Work and NetDocuments. Captures workspace name, matter or client association, folder path, parent folder reference for hierarchy traversal, access control group, security classification, and governance policy. Provides the organizational container structure for document storage and retrieval aligned to matter workspaces. Supports workspace provisioning automation and access inheritance rules.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`document`.`doc_review_assignment` (
    `doc_review_assignment_id` BIGINT COMMENT 'Unique identifier for the document review assignment record. Primary key for this entity.',
    `contract_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Document review projects assign reviewers to analyze specific agreements in M&A due diligence, contract portfolio reviews, and compliance audits. Reviewer assigned to review all amendments to Master ',
    `doc_version_id` BIGINT COMMENT 'Foreign key linking to document.doc_version. Business justification: doc_review_assignment currently has document_id FK to legal_document. Review assignments are for SPECIFIC VERSIONS (reviewer is assigned to review version 5, not the document). Adding doc_version_id',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: Document review is a distinct legal service offering (first-level review, privilege review, second-level QC). Critical for service delivery tracking, resource allocation, cost management, and billing.',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter or case to which this document review assignment is associated.',
    `patent_id` BIGINT COMMENT 'Foreign key linking to ip.patent. Business justification: Document review in patent litigation assigns reviewers to review documents related to specific patents in suit. Review workflow requires tracking which patent each document batch relates to for releva',
    `legal_document_id` BIGINT COMMENT 'Reference to the document being reviewed within the eDiscovery or collaborative review workflow.',
    `timekeeper_id` BIGINT COMMENT 'Reference to the timekeeper or staff member assigned to review this document.',
    `production_batch_id` BIGINT COMMENT 'Reference to the production batch or set in which this document was included for delivery to the requesting party.',
    `review_batch_id` BIGINT COMMENT 'Reference to the batch or work queue to which this document review assignment belongs, used for throughput management and workload distribution.',
    `target_legal_document_id` BIGINT COMMENT 'FK to document.legal_document.legal_document_id — Review assignments must reference the document being reviewed. Without this link, the entire eDiscovery review workflow cannot function — reviewers cannot be assigned to documents.',
    `trademark_id` BIGINT COMMENT 'Foreign key linking to ip.trademark. Business justification: Document review in trademark litigation and opposition proceedings assigns reviewers to review documents related to specific trademarks. Review workflow requires tracking which trademark each document',
    `annotation_count` STRING COMMENT 'Total number of annotations (highlights, comments, notes) added by the reviewer to the document.',
    `assignment_date` DATE COMMENT 'Date when the document was assigned to the reviewer for review.',
    `assignment_method` STRING COMMENT 'Method by which the document was assigned to the reviewer, indicating whether assignment was manual, automated by workflow rules, or balanced by workload distribution algorithm.. Valid values are `manual|automated|round_robin|workload_balanced`',
    `assignment_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the document review assignment was created and assigned to the reviewer.',
    `bates_number` STRING COMMENT 'Unique Bates stamp or control number assigned to the document for production tracking and chain of custody.',
    `cal_feedback_flag` BOOLEAN COMMENT 'Indicates whether this review assignment was used as feedback to train or refine the CAL predictive coding model.',
    `confidentiality_designation` STRING COMMENT 'Confidentiality level assigned to the document during review, typically governed by protective order terms.. Valid values are `public|confidential|highly_confidential|attorneys_eyes_only`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this document review assignment record was first created in the system.',
    `custodian_name` STRING COMMENT 'Name of the document custodian (the individual or entity from whose files the document was collected), used for ESI provenance tracking.',
    `issue_tags` STRING COMMENT 'Comma-separated list of issue codes or tags applied by the reviewer to categorize the document by legal issue, topic, or relevance area.',
    `modified_by_user_code` BIGINT COMMENT 'Reference to the user or system account that last modified this document review assignment record, supporting audit trail and change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this document review assignment record was last modified or updated.',
    `privilege_type` STRING COMMENT 'Type of legal privilege asserted if the document is coded as privileged, used for privilege log compilation.. Valid values are `attorney_client|work_product|joint_defense|settlement|none`',
    `production_flag` BOOLEAN COMMENT 'Indicates whether the document has been marked for production to the opposing party or regulatory authority.',
    `redaction_count` STRING COMMENT 'Number of redactions applied to the document during review.',
    `redaction_required_flag` BOOLEAN COMMENT 'Indicates whether the document requires redaction of sensitive information (PII, trade secrets, privileged content) before production.',
    `relevance_score` DECIMAL(18,2) COMMENT 'Predictive coding relevance score assigned by the TAR or CAL model, ranging from 0 to 1, indicating the likelihood that the document is responsive.',
    `review_completion_timestamp` TIMESTAMP COMMENT 'Timestamp when the reviewer completed the review and submitted their coding decision.',
    `review_decision` STRING COMMENT 'Primary coding decision made by the reviewer indicating whether the document is responsive to the discovery request, non-responsive, or subject to privilege.. Valid values are `responsive|non_responsive|privilege|not_reviewed`',
    `review_duration_minutes` DECIMAL(18,2) COMMENT 'Total time in minutes spent by the reviewer on this document, used for throughput analysis and quality control.',
    `review_priority` STRING COMMENT 'Priority level assigned to the review assignment, used for workload management and deadline adherence.. Valid values are `low|medium|high|urgent`',
    `review_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the reviewer first opened or began reviewing the document.',
    `review_status` STRING COMMENT 'Current status of the document review assignment in the workflow lifecycle.. Valid values are `assigned|in_progress|completed|skipped|escalated|on_hold`',
    `review_type` STRING COMMENT 'Type or purpose of the review assignment, distinguishing between first-pass review, quality control, privilege review, hot document flagging, or ad-hoc collaborative annotation.. Valid values are `first_pass|quality_control|privilege_review|hot_document|ad_hoc`',
    `reviewer_comments` STRING COMMENT 'Free-text comments or notes entered by the reviewer to explain coding decisions, flag issues, or provide context for second-level review.',
    `second_level_review_decision` STRING COMMENT 'Decision made by the second-level reviewer, indicating whether the initial review decision was confirmed, overridden, or escalated for further review.. Valid values are `confirmed|overridden|escalated`',
    `second_level_review_required_flag` BOOLEAN COMMENT 'Indicates whether the document requires a second-level or senior attorney review for quality control or privilege validation.',
    `second_level_review_timestamp` TIMESTAMP COMMENT 'Timestamp when the second-level review was completed.',
    `source_system` STRING COMMENT 'Name of the source system or repository from which the document was collected (e.g., email server, file share, DMS, cloud storage).',
    `tar_model_round` STRING COMMENT 'The TAR or CAL model training round during which this document was reviewed, used to track continuous active learning feedback cycles.',
    CONSTRAINT pk_doc_review_assignment PRIMARY KEY(`doc_review_assignment_id`)
) COMMENT 'Complete record of document review work product within eDiscovery and collaborative review workflows. Captures reviewer identity, review batch, assignment and completion dates, review decisions (responsive/non-responsive/privilege), TAR/CAL model round, and all associated annotations including issue tags, redactions, coding decisions, highlights, comments, redlines, and annotation metadata (type, timestamp, review round, CAL feedback flag). Supports review throughput management, quality control, second-level review, continuous active learning feedback, privilege log compilation, ad-hoc collaborative annotation outside formal review batches, and annotation-level audit trail. Central operational entity for managing the entire review, annotation, and coding lifecycle from assignment through final production coding.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`document`.`privilege_log` (
    `privilege_log_id` BIGINT COMMENT 'Unique identifier for the privilege log entry. Primary key.',
    `contract_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Privilege logs track attorney-client communications about specific agreements during litigation or regulatory review. Log entry describes Email re: negotiation strategy for Agreement #2020-123. Esse',
    `doc_version_id` BIGINT COMMENT 'Foreign key linking to document.doc_version. Business justification: privilege_log currently has document_id FK to legal_document. Privilege designations apply to SPECIFIC VERSIONS (version 1 might be privileged, version 2 redacted and not privileged). Adding doc_versi',
    `docket_id` BIGINT COMMENT 'Foreign key linking to court.docket. Business justification: Privilege logs submitted to courts in discovery disputes require docket reference for privilege assertion tracking, challenge management, and coordination with protective orders and in camera review p',
    `ip_asset_id` BIGINT COMMENT 'Foreign key linking to ip.asset. Business justification: Privilege logs in IP litigation track attorney-client communications about specific IP assets (patents in suit, trade secrets at issue). Discovery compliance requires identifying which asset each priv',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: Privilege logs are service deliverables in discovery/litigation services. Essential for deliverable tracking, quality control, billing, and compliance with court orders. New attribute needed to link p',
    `matter_id` BIGINT COMMENT 'Reference to the matter or case to which this privilege designation applies. Links to Elite 3E matter management.',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the attorney who asserted the privilege designation. Links to the timekeeper or workforce record in Elite 3E or SAP SuccessFactors.',
    `legal_document_id` BIGINT COMMENT 'FK to document.legal_document.legal_document_id — Privilege designations are applied to specific documents. This FK enables privilege status lookup per document and privilege log generation for productions.',
    `privilege_produced_legal_document_id` BIGINT COMMENT 'FK to document.legal_document.legal_document_id — Privilege designations must reference the document they protect. This is legally required for privilege log compilation and court submissions.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Privilege assertions cite regulatory frameworks: LPP under PACE 1984 s.10, attorney-client privilege under state bar rules, litigation privilege under CPR Part 31. Essential for privilege log preparat',
    `timekeeper_id` BIGINT COMMENT 'Reference to the user or attorney who last modified this privilege log record. Supports audit trail and accountability.',
    `author_name` STRING COMMENT 'The name of the person who authored or created the privileged document. May be an attorney, client representative, or other party.',
    `bates_number` STRING COMMENT 'The Bates stamp or control number assigned to the document in the eDiscovery production. Used for unique identification and tracking in litigation.',
    `challenge_date` DATE COMMENT 'The date on which the privilege assertion was challenged by opposing counsel or the court. Null if unchallenged.',
    `challenge_notes` STRING COMMENT 'Free-text notes describing the nature of the privilege challenge, arguments made, and the outcome or current status.',
    `challenge_resolution_date` DATE COMMENT 'The date on which a privilege challenge was resolved by the court or through agreement. Null if challenge is pending or no challenge occurred.',
    `challenge_status` STRING COMMENT 'Indicates whether the privilege assertion has been challenged by opposing counsel or the court, and the outcome of any challenge.. Valid values are `unchallenged|challenged|upheld|overruled|pending`',
    `clawback_date` DATE COMMENT 'The date on which a clawback request was made to opposing counsel or the court. Null if no clawback has been requested.',
    `clawback_requested` BOOLEAN COMMENT 'Indicates whether a clawback (return of inadvertently disclosed privileged document) has been requested under Federal Rule of Evidence 502(b) or similar provisions.',
    `clawback_status` STRING COMMENT 'The current status of the clawback request. Indicates whether the request was granted, denied, or is still pending.. Valid values are `not_applicable|requested|granted|denied|pending`',
    `confidentiality_level` STRING COMMENT 'The confidentiality designation assigned to the document under the protective order or confidentiality agreement governing the litigation or matter.. Valid values are `public|internal|confidential|highly_confidential|attorneys_eyes_only`',
    `court_case_number` STRING COMMENT 'The court-assigned case number or docket number for the litigation in which this privilege log entry was submitted.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this privilege log record was first created in the system.',
    `custodian_name` STRING COMMENT 'The name of the custodian (person or department) who held or controlled the document at the time of collection for eDiscovery.',
    `designation_date` DATE COMMENT 'The date on which the privilege designation was applied to the document.',
    `designation_timestamp` TIMESTAMP COMMENT 'The precise timestamp when the privilege designation was recorded in the system.',
    `document_date` DATE COMMENT 'The date the privileged document was created or executed. Critical metadata for privilege log submissions.',
    `document_description` STRING COMMENT 'A brief, non-privileged description of the document sufficient to identify it without waiving privilege. Required for privilege log submissions to courts.',
    `document_title` STRING COMMENT 'The title or name of the privileged document as it appears in the DMS. Used for identification in privilege logs submitted to courts or opposing counsel.',
    `entry_number` STRING COMMENT 'Sequential entry number assigned to this privilege assertion in the formal privilege log submitted to the court or opposing counsel.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this privilege log entry is currently active and valid. Inactive entries may represent superseded or withdrawn privilege assertions.',
    `jurisdiction` STRING COMMENT 'The legal jurisdiction (court, tribunal, or arbitration body) in which the privilege assertion applies. Relevant because privilege rules vary by jurisdiction.',
    `lpp_classification` STRING COMMENT 'Classification of the document under Legal Professional Privilege (LPP) framework, primarily applicable in UK and Commonwealth jurisdictions. Distinguishes between advice privilege and litigation privilege.. Valid values are `legal_advice|litigation|contentious|non_contentious|not_applicable`',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this privilege log record was last modified or updated.',
    `notes` STRING COMMENT 'Additional free-text notes or comments regarding the privilege designation, review process, or special circumstances.',
    `privilege_basis` STRING COMMENT 'Detailed explanation of the legal basis and rationale for asserting privilege over this document. Describes why the document qualifies for the claimed privilege type.',
    `privilege_type` STRING COMMENT 'The type of privilege being asserted over the document. Attorney-client privilege protects confidential communications between attorney and client; work-product doctrine protects materials prepared in anticipation of litigation; common-interest and joint-defense privileges apply to shared defense strategies.. Valid values are `attorney_client|work_product|common_interest|joint_defense|settlement|other`',
    `production_status` STRING COMMENT 'The status of the document in the eDiscovery production workflow. Indicates whether the document was withheld on privilege grounds, produced with redactions, or produced without redactions.. Valid values are `withheld|produced_redacted|produced_unredacted|pending_review`',
    `recipient_names` STRING COMMENT 'Comma-separated list of recipients to whom the privileged document was sent or distributed. Used to establish the scope of confidential communication.',
    `redaction_status` STRING COMMENT 'Indicates whether the document has been redacted for production. Fully redacted or withheld documents are not produced; partially redacted documents are produced with privileged portions removed.. Valid values are `not_redacted|partially_redacted|fully_redacted|withheld`',
    `retention_hold` BOOLEAN COMMENT 'Indicates whether the document is subject to a litigation hold or records retention hold, preventing destruction or alteration.',
    `review_date` DATE COMMENT 'The date on which the document was reviewed for privilege during the eDiscovery workflow.',
    `submission_date` DATE COMMENT 'The date on which the privilege log containing this entry was submitted to the court or opposing counsel.',
    `waiver_date` DATE COMMENT 'The date on which privilege was waived or deemed waived. Null if privilege has not been waived.',
    `waiver_status` STRING COMMENT 'Indicates whether privilege has been waived, either intentionally or through inadvertent disclosure. Subject matter waiver extends waiver to related communications.. Valid values are `not_waived|inadvertent_disclosure|intentional_waiver|subject_matter_waiver|pending_determination`',
    CONSTRAINT pk_privilege_log PRIMARY KEY(`privilege_log_id`)
) COMMENT 'Authoritative record of privilege designations applied to documents, capturing LPP (Legal Professional Privilege), attorney-client privilege, work-product doctrine, and common-interest privilege claims. Records the basis for privilege assertion, asserting attorney, date of designation, redaction status, and challenge history. Required for eDiscovery productions and court submissions.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`document`.`esi_collection` (
    `esi_collection_id` BIGINT COMMENT 'Unique identifier for the ESI collection event. Primary key.',
    `account_id` BIGINT COMMENT 'Foreign key linking to trust.trust_account. Business justification: eDiscovery collections in legal malpractice, fee dispute, or trust account misappropriation matters must collect trust account records as ESI. Direct link required for chain of custody documentation, ',
    `contract_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: eDiscovery collections in contract disputes target all ESI related to specific agreements. Collection scope defined as all documents concerning Agreement #2019-045 between Acme and Vendor X. Require',
    `esi_custodian_id` BIGINT COMMENT 'FK to document.esi_custodian.esi_custodian_id — Collections are executed against specific custodians. The esi_collection description explicitly references custodian identity as a core attribute. This FK is essential for defensible collection tracki',
    `docket_id` BIGINT COMMENT 'Foreign key linking to court.docket. Business justification: ESI collections performed for specific litigation matters must link to docket for discovery obligation tracking, production scope management, and chain of custody documentation required in court proce',
    `ip_asset_id` BIGINT COMMENT 'Foreign key linking to ip.asset. Business justification: ESI collections in IP disputes preserve documents related to specific IP assets (trade secret misappropriation evidence, patent prosecution history, trademark use evidence). Ediscovery scoping and rel',
    `legal_hold_id` BIGINT COMMENT 'Foreign key linking to document.legal_hold. Business justification: esi_collection has preservation_notice_issued: BOOLEAN and preservation_notice_date: DATE. Collections are executed in response to legal holds. One collection is triggered by one legal hold (1:N relat',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: ESI collections are billable service activities in ediscovery/litigation services. Essential for service delivery tracking, cost recovery, scope management, and vendor billing reconciliation. New attr',
    `matter_id` BIGINT COMMENT 'Identifier of the legal matter for which this ESI collection was executed.',
    `primary_esi_custodian_id` BIGINT COMMENT 'Foreign key linking to document.esi_custodian. Business justification: esi_collection has custodian_name, custodian_email, custodian_employee_id, custodian_department (all strings, denormalized). esi_custodian is the master custodian record. One collection is FROM one cu',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: ESI collections are executed in response to litigation/investigation risks. Risk registers track collection scope, costs, and chain-of-custody risks as part of matter risk exposure assessment. Essenti',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: eDiscovery collections responding to regulatory inquiries: SRA Section 44B notice collection, ICO information notice collection, FCA skilled person review collection. Required for regulatory response ',
    `source_esi_custodian_id` BIGINT COMMENT 'FK to document.esi_custodian.esi_custodian_id — Collections are executed against specific custodians. This FK enables custodian-level collection tracking, volume reporting, and defensibility documentation.',
    `chain_of_custody_hash` STRING COMMENT 'Cryptographic hash value (e.g., MD5, SHA-256) computed at collection time to ensure data integrity and establish chain of custody.',
    `collection_cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred for this ESI collection event, including vendor fees, labor, and technology costs.',
    `collection_cost_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the collection cost amount.. Valid values are `^[A-Z]{3}$`',
    `collection_end_date` DATE COMMENT 'Date on which the ESI collection activity was completed or terminated.',
    `collection_method` STRING COMMENT 'Detailed description of the technical method or tool used to perform the collection (e.g., Relativity Collect, EnCase, FTK Imager).',
    `collection_name` STRING COMMENT 'Business-friendly name or label assigned to this ESI collection event for identification and tracking purposes.',
    `collection_notes` STRING COMMENT 'Free-text notes documenting any issues, observations, or special circumstances encountered during the collection process.',
    `collection_number` STRING COMMENT 'Externally-known unique identifier or reference number for this ESI collection, often used in legal filings and correspondence.',
    `collection_scope_description` STRING COMMENT 'Detailed narrative description of the scope, parameters, and boundaries of the ESI collection (e.g., search terms, file types, folders included/excluded).',
    `collection_start_date` DATE COMMENT 'Date on which the ESI collection activity commenced.',
    `collection_status` STRING COMMENT 'Current lifecycle status of the ESI collection event.. Valid values are `planned|in_progress|completed|failed|cancelled|on_hold`',
    `collection_timestamp` TIMESTAMP COMMENT 'Precise date and time when the ESI collection event was executed. Principal business event timestamp.',
    `collection_tool_name` STRING COMMENT 'Name of the software tool or platform used to perform the ESI collection (e.g., Relativity Collect, Nuix, Exterro).',
    `collection_tool_version` STRING COMMENT 'Version number of the collection tool used, important for reproducibility and defensibility.',
    `collection_type` STRING COMMENT 'Classification of the collection method used to acquire the ESI.. Valid values are `targeted|forensic|remote|onsite|self_collection`',
    `collector_name` STRING COMMENT 'Full name of the individual or team member who performed the ESI collection.',
    `collector_organization` STRING COMMENT 'Name of the organization or vendor that performed the collection (e.g., internal IT, external forensics firm, ALSP).',
    `created_by_user` STRING COMMENT 'Username or identifier of the system user who created this ESI collection record.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this ESI collection record was first created in the system.',
    `data_source_location` STRING COMMENT 'Physical or logical location of the data source (e.g., server name, file path, cloud tenant, device serial number).',
    `data_source_type` STRING COMMENT 'Category of data source from which ESI was collected (e.g., email, file share, cloud storage, mobile device, database, social media).',
    `date_range_end` DATE COMMENT 'End date of the custodial data date range targeted for collection (e.g., collect all emails up to this date).',
    `date_range_start` DATE COMMENT 'Start date of the custodial data date range targeted for collection (e.g., collect all emails from this date forward).',
    `deduplication_applied` BOOLEAN COMMENT 'Indicates whether deduplication was applied during or after the collection process to remove duplicate items.',
    `encryption_detected` BOOLEAN COMMENT 'Indicates whether encrypted files or data were detected during the collection process.',
    `hash_algorithm` STRING COMMENT 'Cryptographic hash algorithm used to generate the chain of custody hash value.. Valid values are `MD5|SHA1|SHA256|SHA512`',
    `modified_by_user` STRING COMMENT 'Username or identifier of the system user who last modified this ESI collection record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this ESI collection record was last modified or updated.',
    `password_protected_items_count` BIGINT COMMENT 'Count of items that were found to be password-protected or encrypted during collection.',
    `preservation_notice_date` DATE COMMENT 'Date on which the legal hold or preservation notice was issued to the custodian.',
    `preservation_notice_issued` BOOLEAN COMMENT 'Indicates whether a legal hold or preservation notice was issued to the custodian prior to collection.',
    `privilege_review_required` BOOLEAN COMMENT 'Indicates whether the collected ESI requires privilege review to identify and protect attorney-client privileged or work product materials.',
    `production_eligible` BOOLEAN COMMENT 'Indicates whether the collected ESI is eligible for production to opposing counsel or regulatory authorities.',
    `relativity_workspace_reference` STRING COMMENT 'Identifier of the Relativity workspace into which the collected ESI was loaded for review and analysis.',
    `total_items_collected` BIGINT COMMENT 'Total count of individual items (documents, emails, files, records) collected during this ESI collection event.',
    `total_size_bytes` BIGINT COMMENT 'Total size of all collected ESI measured in bytes.',
    `total_size_gb` DECIMAL(18,2) COMMENT 'Total size of all collected ESI measured in gigabytes for human-readable reporting.',
    CONSTRAINT pk_esi_collection PRIMARY KEY(`esi_collection_id`)
) COMMENT 'Master record for each ESI (Electronically Stored Information) collection event executed via Relativity or other collection tools. Captures custodian identity, collection date range, data sources (email, file share, cloud), collection method, chain-of-custody hash values, volume statistics, and matter linkage. Serves as the authoritative provenance record for all eDiscovery collections.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`document`.`esi_custodian` (
    `esi_custodian_id` BIGINT COMMENT 'Unique identifier for the ESI custodian record. Primary key.',
    `inventor_id` BIGINT COMMENT 'Foreign key linking to ip.inventor. Business justification: ESI custodians in patent litigation are often the inventors whose documents (lab notebooks, emails, conception evidence) are being collected. Patent litigation discovery workflow requires linking cust',
    `matter_id` BIGINT COMMENT 'Reference to the litigation or investigation matter for which this custodians ESI is subject to legal hold and collection.',
    `timekeeper_id` BIGINT COMMENT 'Internal employee or personnel identifier for the custodian within the organizations human resources system.',
    `chain_of_custody_verified` BOOLEAN COMMENT 'Indicates whether the chain of custody for the custodians ESI collection has been verified and documented to ensure defensibility and admissibility.',
    `collection_completion_date` DATE COMMENT 'Date on which ESI collection activities were completed for this custodian.',
    `collection_file_count` BIGINT COMMENT 'Total number of files and documents collected from this custodians data sources.',
    `collection_method` STRING COMMENT 'Method used to collect ESI from the custodians data sources (e.g., forensic imaging for full bit-by-bit copy, targeted collection for specific files, self-collection by custodian).. Valid values are `forensic_imaging|targeted_collection|self_collection|remote_collection|on_site_collection`',
    `collection_start_date` DATE COMMENT 'Date on which ESI collection activities commenced for this custodian.',
    `collection_status` STRING COMMENT 'Current status of ESI collection activities for this custodian.. Valid values are `not_started|scheduled|in_progress|completed|failed|on_hold`',
    `collection_volume_gb` DECIMAL(18,2) COMMENT 'Total volume of ESI collected from this custodian, measured in gigabytes.',
    `created_by_user` STRING COMMENT 'Username or identifier of the system user who created the ESI custodian record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the ESI custodian record was first created in the system.',
    `custodian_active_flag` BOOLEAN COMMENT 'Indicates whether the custodian is currently an active employee or affiliated party with the organization.',
    `custodian_department` STRING COMMENT 'Business unit or department to which the custodian belongs (e.g., Corporate Legal, Litigation, Compliance, Finance).',
    `custodian_departure_date` DATE COMMENT 'Date on which the custodian departed the organization (termination, resignation, retirement), triggering expedited collection requirements.',
    `custodian_email` STRING COMMENT 'Primary email address of the custodian, used for legal hold notifications and collection coordination.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `custodian_full_name` STRING COMMENT 'Full legal name of the individual or entity whose electronically stored information is subject to preservation and collection.',
    `custodian_organization` STRING COMMENT 'Legal entity or organizational affiliation of the custodian (e.g., parent company, subsidiary, external counsel, third-party vendor).',
    `custodian_role` STRING COMMENT 'Job title or functional role of the custodian at the time of legal hold issuance (e.g., Senior Associate, Paralegal, General Counsel, IT Administrator).',
    `custodian_status` STRING COMMENT 'Current lifecycle status of the custodian in the legal hold and collection workflow. [ENUM-REF-CANDIDATE: identified|notified|acknowledged|interviewed|collection_in_progress|collection_complete|released — 7 candidates stripped; promote to reference product]',
    `custodian_type` STRING COMMENT 'Classification of the custodian based on relevance and data volume: key (high relevance, decision-maker), standard (moderate relevance), peripheral (low relevance), third_party (external), non_employee (contractor, consultant).. Valid values are `key|standard|peripheral|third_party|non_employee`',
    `data_residency_country` STRING COMMENT 'Three-letter ISO country code indicating the primary geographic location where the custodians ESI resides (e.g., USA, GBR, DEU).. Valid values are `^[A-Z]{3}$`',
    `data_sources_cloud_storage` STRING COMMENT 'Comma-separated list of cloud storage platforms and accounts used by the custodian (e.g., OneDrive, SharePoint, Dropbox, Google Drive, Box).',
    `data_sources_collaboration_tools` STRING COMMENT 'Comma-separated list of collaboration and messaging platforms used by the custodian (e.g., Microsoft Teams, Slack, Zoom, WebEx).',
    `data_sources_email` STRING COMMENT 'Comma-separated list of email systems and accounts held by the custodian (e.g., Exchange, Gmail, Outlook PST files, archived mailboxes).',
    `data_sources_file_shares` STRING COMMENT 'Comma-separated list of network file shares, shared drives, and document repositories accessible to the custodian (e.g., departmental drives, project folders).',
    `data_sources_local_drives` STRING COMMENT 'Comma-separated list of local hard drives, laptops, desktops, and removable media held by the custodian (e.g., C: drive, external USB drives).',
    `data_sources_mobile_devices` STRING COMMENT 'Comma-separated list of mobile devices issued to or used by the custodian (e.g., iPhone, Android, tablet, device serial numbers).',
    `data_sources_other` STRING COMMENT 'Additional or specialized data sources not covered by standard categories (e.g., social media accounts, CRM systems, proprietary applications).',
    `gdpr_data_subject_flag` BOOLEAN COMMENT 'Indicates whether the custodian is an EU/EEA data subject whose personal data is subject to GDPR protections and cross-border transfer restrictions.',
    `lpp_classification` STRING COMMENT 'Legal Professional Privilege classification for custodian ESI under UK/Commonwealth jurisdictions (e.g., legal advice privilege, litigation privilege).. Valid values are `not_applicable|legal_advice|litigation_privilege|without_prejudice`',
    `modified_by_user` STRING COMMENT 'Username or identifier of the system user who last modified the ESI custodian record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the ESI custodian record was last modified or updated.',
    `privilege_designation` STRING COMMENT 'Privilege classification applied to the custodians ESI collection for review and production purposes (e.g., attorney-client privilege, work product doctrine).. Valid values are `none|attorney_client|work_product|joint_defense|settlement`',
    CONSTRAINT pk_esi_custodian PRIMARY KEY(`esi_custodian_id`)
) COMMENT 'Identifies individuals or entities whose ESI is subject to legal hold and collection in litigation or investigation matters. Records custodian name, role, organization, data sources held (email systems, file shares, cloud storage, mobile devices), legal hold acknowledgement status, collection status, and interview notes. This is the document-domain view of a person-as-custodian — the authoritative record of their preservation obligations, data map, and collection history. Supports custodian interview workflows and defensible collection planning under FRCP Rule 26, Practice Direction 31B, and GDPR obligations.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`document`.`legal_hold` (
    `legal_hold_id` BIGINT COMMENT 'Unique identifier for the legal hold notice. Primary key.',
    `checklist_id` BIGINT COMMENT 'Foreign key linking to knowledge.checklist. Business justification: Legal holds follow procedural checklists to ensure compliance with preservation obligations. Tracking which checklist was used enables hold quality assurance, process consistency auditing, and defensi',
    `contract_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Legal holds frequently target specific agreements for preservation in contract disputes, regulatory investigations, or breach litigation. Counsel must preserve all documents related to Agreement #XYZ ',
    `doc_template_id` BIGINT COMMENT 'Identifier of the standard legal hold notice template used to generate custodian communications for this hold. Links to knowledge management or document template repository.',
    `docket_id` BIGINT COMMENT 'Foreign key linking to court.docket. Business justification: Legal holds triggered by litigation must reference the originating docket for preservation scope definition, spoliation risk tracking, and hold release timing tied to case resolution or appeal deadlin',
    `ip_asset_id` BIGINT COMMENT 'Foreign key linking to ip.asset. Business justification: Legal holds in IP matters preserve documents related to specific IP assets (patents in suit, trade secrets at issue, trademarks in opposition). Litigation preservation obligations require asset-specif',
    `esi_custodian_id` BIGINT COMMENT 'FK to document.esi_custodian.esi_custodian_id — Legal holds are issued to custodians. The hold-custodian relationship is the core operational link for preservation obligations. Without it, hold compliance tracking is impossible.',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: Legal holds are triggered by specific service engagements (litigation, investigation, regulatory response). Required for service scope tracking, cost allocation, ediscovery budgeting, and billing. New',
    `matter_id` BIGINT COMMENT 'Identifier of the matter or case for which this legal hold was issued. Links to the underlying litigation, investigation, or regulatory proceeding.',
    `organisation_id` BIGINT COMMENT 'Identifier of the external law firm managing the litigation or investigation for which this legal hold was issued. Nullable if matter is handled in-house.',
    `attorney_profile_id` BIGINT COMMENT 'Identifier of the attorney or legal professional who authorized and issued the legal hold notice. Typically a partner, general counsel, or litigation manager.',
    `primary_esi_custodian_id` BIGINT COMMENT 'FK to document.esi_custodian.esi_custodian_id — Legal holds are issued to specific custodians. This FK enables hold compliance tracking per custodian and defensible preservation documentation.',
    `timekeeper_id` BIGINT COMMENT 'Identifier of the system user or legal professional who created the legal hold record. Supports audit trail and accountability.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Legal holds are triggered by litigation/regulatory risks and must be tracked in risk registers for compliance monitoring, spoliation risk assessment, and preservation obligation management. Critical f',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Legal holds triggered by regulatory investigations or compliance requirements: SRA investigation hold, ICO enforcement inquiry hold, FCA market abuse investigation hold. Essential for demonstrating to',
    `acknowledged_count` STRING COMMENT 'Number of custodians who have formally acknowledged receipt and understanding of the legal hold notice and their preservation obligations.',
    `compliance_monitoring_flag` BOOLEAN COMMENT 'Indicates whether active compliance monitoring and auditing is in place to verify custodians are adhering to preservation obligations. True means monitoring is active; False means passive hold only.',
    `confidentiality_level` STRING COMMENT 'Classification of the sensitivity and confidentiality of the legal hold itself and the matter it relates to. Restricted indicates highly sensitive litigation or investigation; Public indicates no confidentiality concerns.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the legal hold record was first created in the system. Represents the audit trail of when the hold was initially documented.',
    `custodian_count` STRING COMMENT 'Total number of custodians (individuals or entities) to whom the legal hold notice has been issued and who are under preservation obligation.',
    `data_sources_in_scope` STRING COMMENT 'Description of data sources and systems from which ESI must be preserved, including email servers, file shares, DMS repositories, collaboration platforms, mobile devices, cloud storage, and backup tapes.',
    `document_types_in_scope` STRING COMMENT 'Comma-separated or structured list of document types and ESI categories included in the preservation scope, such as emails, contracts, spreadsheets, presentations, instant messages, voicemails, databases, and physical files.',
    `ediscovery_collection_initiated_flag` BOOLEAN COMMENT 'Indicates whether forensic or eDiscovery collection of ESI has been initiated for custodians under this legal hold. True means collection has started; False means preservation only.',
    `escalation_count` STRING COMMENT 'Number of times the legal hold notice has been escalated or re-sent to non-responsive custodians or management for enforcement.',
    `hold_name` STRING COMMENT 'Descriptive name or title of the legal hold, typically referencing the matter name or subject of the litigation or investigation.',
    `hold_number` STRING COMMENT 'Business-facing unique identifier or reference number for the legal hold notice, often used in communications with custodians and counsel.',
    `hold_status` STRING COMMENT 'Current lifecycle status of the legal hold. Draft indicates preparation; Active indicates custodians are under preservation obligation; Suspended indicates temporary pause; Released indicates hold has been lifted; Expired indicates hold ended by time limit.. Valid values are `draft|active|suspended|released|expired`',
    `issued_date` DATE COMMENT 'Date on which the legal hold notice was formally issued to custodians and relevant parties.',
    `jurisdiction` STRING COMMENT 'Legal jurisdiction or court system governing the matter for which this legal hold was issued, such as Federal (US), State (specific state), UK High Court, or regulatory body.',
    `last_reminder_sent_date` DATE COMMENT 'Date on which the most recent reminder notice was sent to custodians under this legal hold.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the legal hold record was last modified or updated. Tracks changes to hold scope, status, or custodian list.',
    `notes` STRING COMMENT 'Free-text notes and comments regarding the legal hold, including special instructions, custodian issues, compliance challenges, or coordination with outside counsel.',
    `preservation_end_date` DATE COMMENT 'Latest date through which documents and ESI must be preserved under the legal hold. Defines the end of the temporal scope of preservation. Nullable for ongoing matters.',
    `preservation_start_date` DATE COMMENT 'Earliest date from which documents and ESI must be preserved under the legal hold. Defines the beginning of the temporal scope of preservation.',
    `privilege_designation_required_flag` BOOLEAN COMMENT 'Indicates whether documents preserved under this legal hold must be reviewed and designated for legal professional privilege (LPP) or attorney-client privilege before production. True means privilege review is required; False means no privilege review needed.',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory authority or government agency conducting the investigation or inquiry that triggered the legal hold, if applicable. Examples include SEC, DOJ, FTC, ICO, or industry-specific regulators.',
    `release_date` DATE COMMENT 'Date on which the legal hold was formally released and custodians were notified that preservation obligations have ended. Nullable if hold is still active.',
    `release_reason` STRING COMMENT 'Explanation or justification for releasing the legal hold, such as matter settlement, case dismissal, statute of limitations expiration, or completion of regulatory investigation.',
    `reminder_frequency_days` STRING COMMENT 'Number of days between automated reminder notices sent to custodians to reinforce their ongoing preservation obligations under the legal hold.',
    `scope_description` STRING COMMENT 'Detailed description of the scope of preservation required under the legal hold, including subject matter, date ranges, custodians, document types, and ESI categories to be preserved.',
    `spoliation_risk_level` STRING COMMENT 'Assessment of the risk that relevant ESI or documents may be destroyed, altered, or lost in violation of the legal hold, potentially resulting in sanctions or adverse inference. Low indicates strong compliance; Critical indicates imminent risk of spoliation.. Valid values are `low|medium|high|critical`',
    `suspension_of_destruction_flag` BOOLEAN COMMENT 'Indicates whether routine document destruction and retention policies have been suspended for the scope of this legal hold. True means destruction is suspended; False means normal retention applies outside hold scope.',
    `trigger_date` DATE COMMENT 'Date on which the triggering event occurred that gave rise to the duty to preserve electronically stored information (ESI) and physical documents.',
    `trigger_event` STRING COMMENT 'Description of the event or circumstance that triggered the issuance of the legal hold, such as receipt of complaint, regulatory inquiry, internal investigation initiation, or reasonably anticipated litigation.',
    CONSTRAINT pk_legal_hold PRIMARY KEY(`legal_hold_id`)
) COMMENT 'Records the issuance, scope, and lifecycle of legal hold notices sent to custodians to preserve ESI and physical documents in anticipation of litigation or regulatory investigation. Captures hold trigger event, issuing attorney, custodian acknowledgement status, scope of preservation, suspension of routine destruction, and release date. Critical for defensible litigation readiness and spoliation risk management.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`document`.`doc_production` (
    `doc_production_id` BIGINT COMMENT 'Unique identifier for the eDiscovery production set. Primary key for the document production record.',
    `contract_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Document productions in contract disputes organize by agreement. Production set defined as all responsive documents related to Supply Agreement #2017-089. Required for discovery responses, regulator',
    `esi_collection_id` BIGINT COMMENT 'FK to document.esi_collection.esi_collection_id — Productions are derived from collected ESI. This link provides the chain-of-custody from collection through production that is legally required for defensible eDiscovery.',
    `docket_id` BIGINT COMMENT 'Foreign key linking to court.docket. Business justification: Document productions respond to discovery requests in specific cases; docket link is mandatory for production tracking, privilege log coordination, and compliance with court-ordered discovery deadline',
    `ip_asset_id` BIGINT COMMENT 'Foreign key linking to ip.asset. Business justification: Document productions in IP litigation produce documents related to specific IP assets in dispute (patents asserted, trade secrets claimed, trademarks at issue). Discovery management requires tracking ',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: Document productions are service deliverables in litigation/investigation matters. Critical for deliverable tracking, milestone billing, service completion verification, and quality control. New attri',
    `matter_disbursement_id` BIGINT COMMENT 'Foreign key linking to billing.disbursement. Business justification: Document productions incur vendor costs (hosting, processing, delivery) that become billable disbursements. Essential for ediscovery cost recovery and client expense reporting in litigation matters.',
    `matter_id` BIGINT COMMENT 'Reference to the litigation or regulatory matter for which this production was created.',
    `production_set_id` BIGINT COMMENT 'Internal identifier of the production set within the eDiscovery platform (e.g., Relativity Production Set ID).',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Document productions carry privilege waiver risk, inadvertent disclosure risk, clawback exposure, and protective order breach risk. Risk registers track production-related risks for matter risk assess',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Document productions to regulators: SRA investigation productions, ICO audit productions, FCA enforcement productions. Essential for regulatory compliance tracking, demonstrating timely response to re',
    `source_esi_collection_id` BIGINT COMMENT 'FK to document.esi_collection.esi_collection_id — Productions are derived from collected ESI. This FK maintains chain of custody from collection through production — required for defensibility.',
    `acknowledgment_date` DATE COMMENT 'Date on which the receiving party acknowledged receipt of the production.',
    `acknowledgment_received` BOOLEAN COMMENT 'Indicates whether the receiving party has acknowledged receipt of the production.',
    `bates_end_number` STRING COMMENT 'Last Bates number in the production range (e.g., DEF00012500). Marks the end of the sequential numbering for this production.. Valid values are `^[A-Z0-9_-]{1,50}$`',
    `bates_prefix` STRING COMMENT 'Prefix applied to Bates numbering for this production set (e.g., DEF, PROD, ABC). Used to uniquely identify the producing party and production set.. Valid values are `^[A-Z0-9_-]{1,20}$`',
    `bates_start_number` STRING COMMENT 'First Bates number in the production range (e.g., DEF00000001). Marks the beginning of the sequential numbering for this production.. Valid values are `^[A-Z0-9_-]{1,50}$`',
    `clawback_date` DATE COMMENT 'Date on which clawback was invoked for inadvertently produced privileged documents.',
    `clawback_invoked` BOOLEAN COMMENT 'Indicates whether the producing party has invoked clawback provisions to retrieve inadvertently produced privileged documents.',
    `confidentiality_designation` STRING COMMENT 'Protective designation applied to the production under the governing protective order (e.g., Confidential, Attorneys Eyes Only).. Valid values are `none|confidential|highly_confidential|attorneys_eyes_only|source_code`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this production record was first created in the system. Audit trail for record creation.',
    `delivery_location` STRING COMMENT 'Physical or digital location where the production was delivered (e.g., FTP URL, workspace name, physical address).',
    `delivery_method` STRING COMMENT 'Method by which the production was delivered to the receiving party (e.g., secure FTP, encrypted hard drive, Relativity workspace transfer).. Valid values are `secure_file_transfer|physical_media|cloud_platform|email|courier|relativity_transfer`',
    `dispute_description` STRING COMMENT 'Description of any disputes or objections raised by the receiving party regarding this production.',
    `dispute_raised` BOOLEAN COMMENT 'Indicates whether the receiving party has raised any disputes or objections regarding this production (e.g., incomplete production, technical issues, privilege claims).',
    `document_count` STRING COMMENT 'Total number of documents included in this production set. Used for volume tracking and reconciliation.',
    `hash_verification_method` STRING COMMENT 'Cryptographic hash algorithm used to verify integrity of produced files (e.g., MD5, SHA-256). Ensures chain of custody.. Valid values are `md5|sha1|sha256|none`',
    `load_file_format` STRING COMMENT 'Format of the metadata load file accompanying the production (e.g., Concordance DAT, Relativity Load File, IPRO LFP). [ENUM-REF-CANDIDATE: dat|opt|lfp|csv|concordance|ipro|relativity — 7 candidates stripped; promote to reference product]',
    `metadata_fields_included` STRING COMMENT 'Comma-separated list or description of metadata fields included in the production load file (e.g., Author, Date Created, Subject, Custodian).',
    `modified_by` STRING COMMENT 'Username or identifier of the person who last modified this production record. Audit trail for accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this production record was last modified. Audit trail for record updates.',
    `native_file_count` STRING COMMENT 'Number of documents produced in native format (original application format such as .docx, .xlsx, .msg).',
    `page_count` STRING COMMENT 'Total number of pages produced across all documents in this production set. Critical for billing and volume metrics.',
    `privilege_log_included` BOOLEAN COMMENT 'Indicates whether a privilege log was included with this production to identify withheld documents and the basis for withholding.',
    `privilege_log_reference` STRING COMMENT 'Reference identifier or file name for the privilege log accompanying this production (e.g., PRIV_LOG_001.xlsx).',
    `producing_counsel_name` STRING COMMENT 'Name of the law firm or attorney responsible for preparing and delivering this production.',
    `producing_party_name` STRING COMMENT 'Name of the party or organization producing the documents (typically the client or the law firm on behalf of the client).',
    `production_date` DATE COMMENT 'Date on which the production set was delivered to the receiving party. This is the authoritative business event timestamp for the production.',
    `production_format` STRING COMMENT 'Format in which documents were produced (native files, TIFF images with load files, searchable PDFs, or mixed formats).. Valid values are `native|tiff|pdf|mixed|load_file`',
    `production_name` STRING COMMENT 'Descriptive name for the production set to aid identification and tracking (e.g., Initial Production - Custodian Smith, Supplemental Production Q2 2024).',
    `production_notes` STRING COMMENT 'Free-text notes regarding special circumstances, technical issues, or other relevant information about this production.',
    `production_number` STRING COMMENT 'Business identifier for the production set, typically assigned by the producing party or agreed upon by counsel (e.g., PROD001, DEF-PROD-2024-01).. Valid values are `^[A-Z0-9_-]{1,50}$`',
    `production_status` STRING COMMENT 'Current lifecycle status of the production set. Tracks progression from draft through delivery and acknowledgment. [ENUM-REF-CANDIDATE: draft|pending_review|approved|delivered|acknowledged|disputed|superseded|withdrawn — 8 candidates stripped; promote to reference product]',
    `production_type` STRING COMMENT 'Classification of the production based on its purpose and timing within the discovery process.. Valid values are `initial|supplemental|rolling|privilege_log|clawback|corrective`',
    `protective_order_reference` STRING COMMENT 'Reference to the court order or agreement governing confidentiality and use restrictions for this production.',
    `receiving_party_contact` STRING COMMENT 'Primary contact person and email address at the receiving party for production-related communications.',
    `receiving_party_name` STRING COMMENT 'Name of the party or organization receiving this production (e.g., opposing counsel, regulatory agency, co-defendant).',
    `redaction_applied` BOOLEAN COMMENT 'Indicates whether redactions were applied to any documents in this production to protect privileged, confidential, or sensitive information.',
    `redaction_count` STRING COMMENT 'Total number of redactions applied across all documents in this production. Used for quality control and privilege tracking.',
    `relativity_workspace_reference` STRING COMMENT 'Identifier of the Relativity workspace from which this production was generated. Links to the source eDiscovery platform.',
    `created_by` STRING COMMENT 'Username or identifier of the person who created this production record. Audit trail for accountability.',
    CONSTRAINT pk_doc_production PRIMARY KEY(`doc_production_id`)
) COMMENT 'Records each eDiscovery production set delivered to opposing counsel or a regulatory body via Relativity. Captures production volume, Bates number range, production format (TIFF, native, PDF), redaction applied, privilege log reference, delivery method, and receiving party. Provides the authoritative audit trail for all productions in litigation and regulatory matters.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`document`.`doc_annotation` (
    `doc_annotation_id` BIGINT COMMENT 'Unique identifier for the document annotation record. Primary key.',
    `doc_version_id` BIGINT COMMENT 'Foreign key linking to document.doc_version. Business justification: doc_annotation currently has document_id FK to legal_document. However, annotations are applied to SPECIFIC VERSIONS, not just documents in general. Business reality: reviewer annotates version 3 with',
    `ip_asset_id` BIGINT COMMENT 'Foreign key linking to ip.asset. Business justification: Annotations on IP documents (claim charts, prior art analysis, invalidity contentions, infringement theories) relate to specific IP assets. Prosecution and litigation review workflows require tagging ',
    `legal_document_id` BIGINT COMMENT 'Reference to the document being annotated. Links to the document product in the document domain.',
    `matter_id` BIGINT COMMENT 'Reference to the matter or case to which this annotation belongs. Links to the matter product in the matter domain.',
    `timekeeper_id` BIGINT COMMENT 'Reference to the legal professional or reviewer who created this annotation. Links to the workforce product.',
    `annotation_category` STRING COMMENT 'A broader categorization of the annotation beyond type, used for grouping and reporting (e.g., substantive review, procedural note, quality control feedback).',
    `annotation_length` STRING COMMENT 'The length of the annotation text in characters. Used for analytics and quality metrics.',
    `annotation_notes` STRING COMMENT 'Additional free-text notes or comments provided by the reviewer to provide context or rationale for the annotation.',
    `annotation_status` STRING COMMENT 'The current lifecycle status of the annotation, indicating whether it is in draft, submitted for review, approved, rejected, or under review.. Valid values are `draft|submitted|approved|rejected|under_review`',
    `annotation_text` STRING COMMENT 'The textual content of the annotation, such as a comment, note, or issue description provided by the reviewer.',
    `annotation_timestamp` TIMESTAMP COMMENT 'The date and time when the annotation was created by the reviewer. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `annotation_type` STRING COMMENT 'The type of annotation applied to the document. Categorizes the nature of the review action taken.. Valid values are `issue_tag|redaction|comment|highlight|privilege_designation|coding_decision`',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the annotation was approved by a senior reviewer or quality control lead. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `cal_training_set_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this annotation is part of the training set for a Continuous Active Learning (CAL) model.',
    `chain_of_custody_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this annotation is part of the chain of custody documentation for the document, ensuring provenance and integrity.',
    `coding_decision` STRING COMMENT 'The coding decision made by the reviewer regarding the documents relevance, privilege status, or production suitability. [ENUM-REF-CANDIDATE: responsive|non_responsive|privileged|confidential|hot|relevant|not_relevant — 7 candidates stripped; promote to reference product]',
    `confidence_score` DECIMAL(18,2) COMMENT 'A numerical score (0-100) representing the reviewers confidence level in the annotation or coding decision. Used for quality control and prioritization.',
    `highlight_color` STRING COMMENT 'The color used to highlight text or sections within the document, often used to denote different categories or levels of importance. [ENUM-REF-CANDIDATE: yellow|green|blue|red|orange|pink|none — 7 candidates stripped; promote to reference product]',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this annotation is currently active or has been superseded or deleted. Supports soft-delete and version control.',
    `issue_tag` STRING COMMENT 'The specific issue or topic tag assigned to the document during review (e.g., relevance, privilege, hot document, key evidence). Used for categorization and filtering in eDiscovery workflows.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when the annotation was last modified or updated. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `nlp_extracted_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this annotation was automatically extracted or suggested by Natural Language Processing (NLP) or Optical Character Recognition (OCR) processing.',
    `page_number` STRING COMMENT 'The specific page number within the document where the annotation was applied. Supports precise location tracking.',
    `paragraph_number` STRING COMMENT 'The specific paragraph number within the document where the annotation was applied. Supports granular location tracking.',
    `privilege_designation` STRING COMMENT 'Indicates whether the document is designated as privileged under attorney-client privilege, work product doctrine, or other privilege categories.. Valid values are `attorney_client|work_product|joint_defense|none`',
    `production_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this annotation is relevant to document production (e.g., redactions that must be applied before production).',
    `quality_control_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this annotation has been selected for quality control review or sampling.',
    `redaction_coordinates` STRING COMMENT 'The spatial coordinates or bounding box information indicating the location of the redaction within the document (e.g., page number, x/y coordinates). Stored as a structured string.',
    `redaction_type` STRING COMMENT 'The type of redaction applied to the document, categorizing the reason for information masking (e.g., Personally Identifiable Information (PII), confidential business information, privileged content).. Valid values are `pii|confidential|privileged|trade_secret|none`',
    `rejection_reason` STRING COMMENT 'The reason provided for rejecting the annotation during quality control or second-level review. Supports continuous improvement and training.',
    `review_round` STRING COMMENT 'The sequential round or pass number during which this annotation was created. Supports multi-level review and quality control workflows.',
    `review_stage` STRING COMMENT 'The stage of the review workflow during which this annotation was created (e.g., first-pass review, second-level review, quality control, privilege review).. Valid values are `first_pass|second_level|quality_control|privilege_review|production_review`',
    `source_system` STRING COMMENT 'The source system from which the annotation originated (e.g., Relativity for eDiscovery, iManage Work or NetDocuments for Document Management System (DMS) annotations).. Valid values are `relativity|imanage|netdocuments|other`',
    `source_system_annotation_reference` STRING COMMENT 'The unique identifier of the annotation in the source system (e.g., Relativity annotation ID, iManage annotation ID). Supports traceability and reconciliation.',
    `tar_model_feedback_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this annotation was used as feedback to train or refine a Technology-Assisted Review (TAR) or Continuous Active Learning (CAL) model.',
    CONSTRAINT pk_doc_annotation PRIMARY KEY(`doc_annotation_id`)
) COMMENT 'Captures reviewer annotations, issue tags, redlines, and coding decisions applied to documents during review workflows in Relativity or iManage. Records annotation type (issue tag, redaction, comment, highlight), annotating reviewer, timestamp, review round, and TAR/CAL model feedback flag. Supports quality control, second-level review, and continuous active learning workflows.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`document`.`retention_schedule` (
    `retention_schedule_id` BIGINT COMMENT 'Unique identifier for the retention schedule rule. Primary key.',
    `agreement_type_id` BIGINT COMMENT 'Foreign key linking to contract.agreement_type. Business justification: Retention policies are defined by agreement type per regulatory and business requirements. Employment agreements retain 7 years post-termination, NDAs 3 years post-expiration, vendor contracts 6 years',
    `doc_type_id` BIGINT COMMENT 'Foreign key linking to document.doc_type. Business justification: retention_schedule has document_type_code: STRING and document_type_name: STRING (denormalized). Retention policies are defined BY document type. One retention schedule applies to one document type (1',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Retention rules vary by practice area due to regulatory frameworks (litigation 7 years, tax 10 years, IP indefinite). Essential for compliance, records management, risk mitigation. New attribute neede',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Retention rules directly implement regulatory mandates: SRA Code of Conduct 8.3 six-year client file retention, GDPR Article 5(1)(e) storage limitation, Limitation Act 1980 six-year limitation period.',
    `superseding_retention_schedule_id` BIGINT COMMENT 'Reference to the retention_schedule_id of the newer rule that replaces this one, if this schedule has been superseded. Null if still active or archived without replacement.',
    `approval_date` DATE COMMENT 'Date on which this retention schedule rule was formally approved and authorized for enforcement.',
    `approved_by` STRING COMMENT 'Name or role of the individual who approved this retention schedule rule (e.g., General Counsel, Chief Legal Officer, Compliance Officer, Records Manager).',
    `audit_trail_retention_years` DECIMAL(18,2) COMMENT 'Number of years that audit logs and metadata tracking document access, modifications, and destruction events must be retained, often longer than the document itself.',
    `certificate_of_destruction_required` BOOLEAN COMMENT 'Indicates whether a formal Certificate of Destruction must be generated and retained as proof of compliant document destruction (True/False).',
    `client_specific_override` BOOLEAN COMMENT 'Indicates whether this retention schedule is a client-specific override of the firms standard retention policy, typically due to contractual obligations or client requests (True/False).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this retention schedule record was first created in the system.',
    `cross_border_transfer_restriction` BOOLEAN COMMENT 'Indicates whether documents under this retention schedule are subject to cross-border data transfer restrictions under GDPR, CCPA, or other data protection regulations (True/False).',
    `destruction_authorization_required` BOOLEAN COMMENT 'Indicates whether formal authorization from a records manager, partner, or compliance officer is required before destruction can proceed (True/False).',
    `destruction_method` STRING COMMENT 'Approved method for destroying documents at end of retention period (e.g., secure deletion for electronic records, shredding for paper, degaussing for magnetic media, cryptographic erasure, incineration, pulping, overwriting). [ENUM-REF-CANDIDATE: secure_deletion|shredding|degaussing|incineration|pulping|overwriting|crypto_erasure — 7 candidates stripped; promote to reference product]',
    `dms_system_enforcement` STRING COMMENT 'Indicates which Document Management System (DMS) automatically enforces this retention schedule (iManage Work Records Management, NetDocuments Governance, both, manual enforcement, or none).. Valid values are `imanage|netdocuments|both|manual|none`',
    `ediscovery_relevance_flag` BOOLEAN COMMENT 'Indicates whether documents under this retention schedule are typically relevant for eDiscovery and Electronic Case Filing (ECF) purposes, affecting preservation obligations during litigation (True/False).',
    `effective_from_date` DATE COMMENT 'Date from which this retention schedule rule becomes active and enforceable. Documents created or closed on or after this date are governed by this rule.',
    `effective_until_date` DATE COMMENT 'Date on which this retention schedule rule expires or is superseded. Null if the rule is open-ended and remains active until explicitly superseded.',
    `jurisdiction_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code or jurisdiction code where this retention rule applies (e.g., USA, GBR, DEU, FRA, AUS). Retention requirements vary by jurisdiction.. Valid values are `^[A-Z]{2,3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this retention schedule record was last updated or modified.',
    `last_review_date` DATE COMMENT 'Date on which this retention schedule rule was last reviewed and validated by the records manager or compliance team.',
    `legal_hold_exemption` BOOLEAN COMMENT 'Indicates whether documents subject to this retention schedule are exempt from automatic destruction when a legal hold or litigation hold is in place (True/False). True means destruction is suspended during holds.',
    `lpp_classification` STRING COMMENT 'Indicates whether documents under this schedule are typically subject to Legal Professional Privilege (LPP) or attorney-client privilege, affecting retention and disclosure obligations.. Valid values are `privileged|non_privileged|work_product|mixed|unknown`',
    `matter_type` STRING COMMENT 'Category of legal matter to which this retention schedule applies (e.g., litigation, corporate transaction, intellectual property portfolio, regulatory compliance, employment law, real estate, tax, general advisory). [ENUM-REF-CANDIDATE: litigation|corporate_transaction|ip_portfolio|regulatory_compliance|employment|real_estate|tax|general_advisory|other — 9 candidates stripped; promote to reference product]',
    `maximum_retention_period_years` DECIMAL(18,2) COMMENT 'Maximum number of years the document should be retained from the trigger date before mandatory destruction, if applicable. Null if no maximum limit. Supports fractional years.',
    `minimum_retention_period_years` DECIMAL(18,2) COMMENT 'Minimum number of years the document must be retained from the trigger date before destruction is permitted. Supports fractional years (e.g., 6.5 years).',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review of this retention schedule rule to ensure continued compliance and relevance.',
    `notes` STRING COMMENT 'Free-text field for additional context, exceptions, special instructions, or clarifications regarding the application of this retention schedule rule.',
    `privacy_impact_classification` STRING COMMENT 'Assessment of the privacy risk associated with documents under this retention schedule (high for documents containing extensive Personally Identifiable Information (PII), medium for limited PII, low for minimal PII, none for non-personal data).. Valid values are `high|medium|low|none`',
    `records_classification_code` STRING COMMENT 'Internal or industry-standard records classification code used for filing and retrieval (e.g., based on firm taxonomy or legal records classification schemes).. Valid values are `^[A-Z0-9]{2,10}$`',
    `regulatory_framework` STRING COMMENT 'Name of the regulatory or compliance framework mandating this retention rule (e.g., GDPR, DPA, SOX, SRA Code of Conduct, CCPA, AML regulations, IOLTA rules, State Bar retention requirements).',
    `responsible_records_manager` STRING COMMENT 'Name or role of the individual or department responsible for enforcing this retention schedule and authorizing destruction (e.g., Records Manager, Compliance Officer, Knowledge Management team).',
    `retention_basis` STRING COMMENT 'Legal or business justification for the retention period (e.g., statute of limitations, regulatory requirement, contractual obligation, business need, client request, professional conduct rules).',
    `retention_review_frequency_months` STRING COMMENT 'Frequency in months at which this retention schedule rule should be reviewed and updated to reflect changes in law, regulation, or business practice (e.g., 12 for annual review, 24 for biennial).',
    `retention_schedule_status` STRING COMMENT 'Current lifecycle status of this retention schedule rule (active and enforced, draft pending approval, superseded by newer rule, archived for historical reference, under review for updates).. Valid values are `active|draft|superseded|archived|under_review`',
    `retention_trigger_event` STRING COMMENT 'The business event that starts the retention clock (e.g., matter closure, document creation date, last access date, final billing, statute of limitations expiry, regulatory hold release, client relationship termination). [ENUM-REF-CANDIDATE: matter_closure|document_creation|last_access|final_billing|statute_of_limitations_expiry|regulatory_hold_release|client_termination|other — 8 candidates stripped; promote to reference product]',
    `version_control_policy` STRING COMMENT 'Policy for retaining document versions under this schedule (retain all versions, retain final executed version only, retain major versions only, retain last N versions).. Valid values are `retain_all_versions|retain_final_only|retain_major_versions|retain_last_n_versions`',
    CONSTRAINT pk_retention_schedule PRIMARY KEY(`retention_schedule_id`)
) COMMENT 'Reference table defining the firms document retention, destruction, and disposal policies by document type, matter type, jurisdiction, and regulatory framework (GDPR, DPA, SOX, SRA). Specifies minimum and maximum retention periods, destruction method (shredding, secure deletion, degaussing), destruction authorization requirements, legal basis for retention, responsible records manager, and certificate of destruction tracking. Governs automated retention enforcement in iManage Records Management and NetDocuments Governance, including end-of-life destruction event recording.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`document`.`doc_access_event` (
    `doc_access_event_id` BIGINT COMMENT 'Unique identifier for the document access event record. Primary key for the doc_access_event product.',
    `matter_id` BIGINT COMMENT 'Identifier of the matter associated with the accessed document. Provides matter context for access audit and billing reconciliation.',
    `timekeeper_id` BIGINT COMMENT 'Identifier of the compliance officer or DPO (Data Protection Officer) assigned to review this access event if compliance review is required. Links to the workforce/user master record.',
    `contract_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Access audits for contract documents track which agreement was accessed for compliance monitoring, ethical wall enforcement, and confidentiality breach detection. Security logs must identify User X a',
    `data_breach_incident_id` BIGINT COMMENT 'Foreign key linking to risk.data_breach_incident. Business justification: Unauthorized document access events are the raw audit trail for data breach incidents. Access logs provide forensic evidence for ICO reporting, breach scope determination, and affected data subject id',
    `data_subject_request_id` BIGINT COMMENT 'Identifier of the GDPR (General Data Protection Regulation) data subject access request (DSAR) if this access event is part of a DSAR response workflow. Links to the data subject request record.',
    `doc_ediscovery_matter_id` BIGINT COMMENT 'Identifier of the eDiscovery case if the document access occurred within an eDiscovery review workflow in Relativity. Links to the eDiscovery case master record.',
    `doc_user_timekeeper_id` BIGINT COMMENT 'Identifier of the user who accessed the document. Links to the workforce/user master record.',
    `doc_version_id` BIGINT COMMENT 'Foreign key linking to document.doc_version. Business justification: doc_access_event has document_version: STRING (not an FK). Access events track which VERSION was accessed (user downloaded version 2.0). Adding doc_version_id FK normalizes away the document_version s',
    `ip_asset_id` BIGINT COMMENT 'Foreign key linking to ip.asset. Business justification: Access tracking for IP documents logs which IP asset was accessed for trade secret confidentiality auditing, ethical wall compliance, and conflict checking. IP confidentiality compliance requires asse',
    `legal_document_id` BIGINT COMMENT 'Identifier of the document that was accessed. Links to the document master record in the DMS (Document Management System).',
    `profile_id` BIGINT COMMENT 'Identifier of the client associated with the accessed document. Provides client context for access audit and conflict checking.',
    `review_session_id` BIGINT COMMENT 'The session identifier for the users DMS (Document Management System) or application session at the time of access. Supports session-based access pattern analysis and anomaly detection.',
    `review_set_id` BIGINT COMMENT 'Identifier of the review set within an eDiscovery case if the document access occurred during TAR (Technology-Assisted Review) or CAL (Continuous Active Learning) workflow. Links to the review set record.',
    `access_anomaly_score` DECIMAL(18,2) COMMENT 'A calculated risk score (0.00 to 100.00) indicating the likelihood that the access event is anomalous based on user behavior patterns, time of access, location, and document sensitivity. Higher scores trigger security review.',
    `access_authorized_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the access was authorized based on user permissions and ethical wall rules at the time of access. False indicates a potential security or compliance breach.',
    `access_duration_seconds` STRING COMMENT 'The duration in seconds that the document was actively accessed or viewed. Helps distinguish between brief accidental access and substantive review.',
    `access_method` STRING COMMENT 'The interface or channel through which the document was accessed. Distinguishes between web portal, desktop DMS (Document Management System) client, mobile app, API access, email integration, and third-party integrations.. Valid values are `web_portal|desktop_client|mobile_app|api|email_integration|third_party_integration`',
    `access_reason` STRING COMMENT 'Optional free-text field capturing the business reason for accessing the document, if provided by the user or required by policy. Supports audit trail and justification for sensitive document access.',
    `access_source_system` STRING COMMENT 'The source system that generated the access event log (e.g., iManage Work, NetDocuments, Relativity). Supports multi-system audit consolidation and source-specific access policy enforcement.. Valid values are `imanage_work|netdocuments|relativity|elite_3e|other`',
    `access_timestamp` TIMESTAMP COMMENT 'The precise date and time when the document access event occurred. Recorded in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Critical for audit trail and LPP (Legal Professional Privilege) breach detection.',
    `access_type` STRING COMMENT 'The type of access action performed on the document. Distinguishes between read-only actions (view) and actions that create copies or modify the document (download, print, share, email, edit, delete, copy). [ENUM-REF-CANDIDATE: view|download|print|share|email|edit|delete|copy — 8 candidates stripped; promote to reference product]',
    `compliance_review_notes` STRING COMMENT 'Free-text notes from the compliance reviewer documenting the review outcome, remediation actions taken, and any follow-up required. Supports audit trail and regulatory reporting.',
    `compliance_review_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the access event requires manual compliance review based on ethical wall breach, LPP (Legal Professional Privilege) breach, or high anomaly score. Triggers workflow in compliance management system.',
    `compliance_review_status` STRING COMMENT 'The current status of compliance review for this access event if compliance_review_required_flag is true. Tracks the lifecycle of compliance investigation and remediation.. Valid values are `pending|in_review|cleared|breach_confirmed|remediation_required`',
    `compliance_review_timestamp` TIMESTAMP COMMENT 'The date and time when the compliance review was completed. Recorded in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used to measure compliance response time and SLA (Service Level Agreement) adherence.',
    `document_classification` STRING COMMENT 'The data classification level of the accessed document at the time of access. Includes LPP (Legal Professional Privilege) designation. Used to detect unauthorized access to privileged or restricted materials.. Valid values are `public|internal|confidential|restricted|lpp_privileged`',
    `document_title` STRING COMMENT 'The title or name of the accessed document at the time of access. Denormalized for audit log readability and to preserve historical context if the document is later renamed.',
    `document_type` STRING COMMENT 'The type or category of the accessed document (e.g., contract, memo, pleading, correspondence, research note). Denormalized for audit reporting and analytics.',
    `ethical_wall_status` STRING COMMENT 'Indicates whether the accessing user was within or outside an ethical wall (information barrier) at the time of access. Critical for conflict checking and SRA (Solicitors Regulation Authority) compliance.. Valid values are `within_wall|outside_wall|no_wall_applicable|wall_breach`',
    `lpp_breach_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the access event constitutes a potential LPP (Legal Professional Privilege) breach based on user permissions and ethical wall rules. Triggers immediate compliance review.',
    `pii_accessed_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the accessed document contains PII (Personally Identifiable Information) as tagged in the DMS (Document Management System). Supports GDPR (General Data Protection Regulation) data subject access request (DSAR) responses and privacy breach detection.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The date and time when this access event record was first created in the audit log system. Recorded in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Distinct from access_timestamp; represents system record creation time.',
    `record_source_file` STRING COMMENT 'The source file or batch identifier from which this access event record was ingested into the lakehouse. Supports data lineage tracking and troubleshooting.',
    `retention_expiry_date` DATE COMMENT 'The date on which this access event log record is eligible for deletion based on the firms records retention policy and regulatory requirements. Recorded in ISO 8601 date format (yyyy-MM-dd).',
    `share_recipient_email` STRING COMMENT 'The email address of the recipient if the access type was share or email. Critical for tracking document distribution outside the DMS (Document Management System) and detecting unauthorized disclosure. Contains PII (Personally Identifiable Information).. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `share_recipient_organization` STRING COMMENT 'The organization or domain of the share recipient, if the document was shared externally. Used to track third-party document distribution and assess data leakage risk.',
    `user_department` STRING COMMENT 'The department or practice group of the accessing user at the time of access (e.g., Corporate, Litigation, IP, Employment). Denormalized for cross-practice access monitoring and conflict detection.',
    `user_device_type` STRING COMMENT 'The type of device used to access the document. Supports device-based access policy enforcement and security risk assessment.. Valid values are `desktop|laptop|tablet|mobile|server|unknown`',
    `user_ip_address` STRING COMMENT 'The IP address from which the user accessed the document. Used for security monitoring, geographic access analysis, and breach investigation. May be considered PII (Personally Identifiable Information) under GDPR (General Data Protection Regulation).',
    `user_location` STRING COMMENT 'The geographic location or office from which the user accessed the document. May be derived from IP address or user profile. Supports cross-border data transfer compliance and ethical wall monitoring.',
    `user_role` STRING COMMENT 'The role or job function of the accessing user at the time of access (e.g., partner, associate, paralegal, secretary, external counsel). Denormalized for access pattern analysis and role-based audit reporting.',
    CONSTRAINT pk_doc_access_event PRIMARY KEY(`doc_access_event_id`)
) COMMENT 'Business-level audit log capturing document access, download, print, share, and email-out events from iManage Work and NetDocuments. Records the accessing user, access type, timestamp, client/matter context, and whether the access was within or outside an ethical wall. Supports LPP breach detection, PII access monitoring, and SRA/GDPR data subject access request responses.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`document`.`doc_execution` (
    `doc_execution_id` BIGINT COMMENT 'Unique identifier for the document execution record. Primary key.',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the attorney or legal professional responsible for overseeing this document execution. Links to workforce/timekeeper records.',
    `contract_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Document execution records track signing workflow for agreements. While execution_record exists in contract domain, doc_execution tracks document-side execution events (routing, signing, notarization)',
    `doc_version_id` BIGINT COMMENT 'Foreign key linking to document.doc_version. Business justification: doc_execution has executed_document_version: STRING. Execution is tied to a SPECIFIC VERSION (parties execute version 2.0 of the contract, not the document). Adding doc_version_id FK normalizes away',
    `escrow_release_id` BIGINT COMMENT 'Foreign key linking to trust.escrow_release. Business justification: Executed documents (closing documents, satisfaction of conditions certificates, court orders) satisfy escrow release conditions and authorize release of escrowed funds. Required for escrow agent compl',
    `execution_workflow_id` BIGINT COMMENT 'Identifier for the execution workflow instance in the electronic signature platform (DocuSign, Adobe Sign). Used for tracking and audit purposes.',
    `form_template_id` BIGINT COMMENT 'Foreign key linking to knowledge.form_template. Business justification: Executed documents (affidavits, declarations, notarized forms) are often based on standardized form templates. Tracking which form was used enables execution workflow automation, form effectiveness an',
    `ip_asset_id` BIGINT COMMENT 'Foreign key linking to ip.asset. Business justification: Executed IP agreements (assignments, licenses, security interests) transfer or encumber specific IP assets. Transactional IP work requires tracking which assets are covered by each executed agreement ',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: Document executions are service milestones (closing, signing ceremony, contract finalization). Required for service completion tracking, milestone billing, deliverable verification, and matter lifecyc',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to ip.license_agreement. Business justification: License execution events track the signing and effectiveness of specific license agreements. Contract lifecycle management requires linking execution records to the license agreement being executed fo',
    `matter_id` BIGINT COMMENT 'Reference to the matter or case under which this document execution is performed. Links to Elite 3E matter management.',
    `legal_document_id` BIGINT COMMENT 'Reference to the legal document being executed. Links to the document master record in the Document Management System (DMS).',
    `profile_id` BIGINT COMMENT 'Reference to the client for whom this document is being executed.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Execution formalities satisfy regulatory requirements: notarization for Land Registry filings, witness requirements for Wills Act 1837, electronic signature compliance with eIDAS Regulation. Required ',
    `timekeeper_id` BIGINT COMMENT 'Reference to the staff member or paralegal coordinating the execution workflow and tracking signature collection.',
    `audit_trail_reference` STRING COMMENT 'Reference to detailed audit trail or chain of custody documentation for this execution event. Critical for Legal Professional Privilege (LPP) and compliance.',
    `board_resolution_reference` STRING COMMENT 'Reference number or identifier of the board resolution authorizing this document execution, if applicable.',
    `board_resolution_required_flag` BOOLEAN COMMENT 'Indicates whether a board resolution or similar corporate authorization is required for valid execution of this document.',
    `compliance_review_completed_flag` BOOLEAN COMMENT 'Indicates whether required compliance review (Anti-Money Laundering (AML), Know Your Client (KYC), sanctions checks) has been completed prior to execution.',
    `counterpart_count` STRING COMMENT 'Number of counterpart copies executed if counterpart execution was used. Null if not executed in counterparts.',
    `counterpart_indicator` BOOLEAN COMMENT 'Indicates whether this document was executed in counterparts, allowing multiple identical copies to be signed separately by different parties.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this execution record was first created in the system. Part of audit trail.',
    `effective_date` DATE COMMENT 'The date from which the executed document becomes legally effective. May differ from execution date if the agreement specifies a future effective date.',
    `executed_document_reference` STRING COMMENT 'Reference or file path to the fully executed document stored in the Document Management System (DMS). Links to iManage Work or NetDocuments storage location.',
    `execution_date` DATE COMMENT 'The date on which the document was formally executed by all required parties. This is the legally binding execution date, distinct from signature dates of individual parties.',
    `execution_language` STRING COMMENT 'Primary language in which the executed document is written. ISO 639-1 two-letter language code.',
    `execution_location` STRING COMMENT 'Physical or virtual location where the document execution took place. May be relevant for jurisdictional or tax purposes.',
    `execution_method` STRING COMMENT 'Method by which the document was or will be executed. Includes traditional wet ink signatures and various electronic signature platforms. [ENUM-REF-CANDIDATE: wet_ink|electronic_signature|digital_signature|docusign|adobe_sign|clickwrap|email_acceptance — 7 candidates stripped; promote to reference product]',
    `execution_notes` STRING COMMENT 'Free-text notes regarding special circumstances, conditions, or observations related to this document execution event.',
    `execution_reference_number` STRING COMMENT 'Business identifier or reference number assigned to this execution event. May be used for tracking and audit purposes.',
    `execution_status` STRING COMMENT 'Current status of the document execution workflow. Tracks progression from draft through to fully executed or cancelled states. [ENUM-REF-CANDIDATE: draft|pending_signature|partially_executed|fully_executed|cancelled|voided|expired — 7 candidates stripped; promote to reference product]',
    `execution_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the document execution was completed, including time zone information. Used for audit trail and legal chain of custody.',
    `execution_type` STRING COMMENT 'Classification of the execution event type. Distinguishes between new agreements, amendments, renewals, assignments, and other execution scenarios. [ENUM-REF-CANDIDATE: new_agreement|amendment|renewal|assignment|novation|termination|waiver|consent|addendum|restatement — promote to reference product]',
    `expiration_date` DATE COMMENT 'The date on which the executed document expires or terminates, if applicable. Null for perpetual agreements or documents without expiration.',
    `governing_law_jurisdiction` STRING COMMENT 'The legal jurisdiction whose laws govern the interpretation and enforcement of this executed document. Typically specified as state/province and country.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this execution record was last modified. Part of audit trail for tracking changes to execution status and details.',
    `notarization_completed_flag` BOOLEAN COMMENT 'Indicates whether required notarization has been completed for this document execution.',
    `notarization_required_flag` BOOLEAN COMMENT 'Indicates whether notarization is required for this document execution to be legally valid.',
    `notary_commission_expiry_date` DATE COMMENT 'Expiration date of the notary publics commission at the time of notarization.',
    `notary_commission_number` STRING COMMENT 'Commission or registration number of the notary public who notarized the document.',
    `notary_name` STRING COMMENT 'Full name of the notary public who notarized the document execution, if applicable.',
    `power_of_attorney_used_flag` BOOLEAN COMMENT 'Indicates whether any signatory executed the document under a Power of Attorney (POA) rather than in their own capacity.',
    `seal_applied_flag` BOOLEAN COMMENT 'Indicates whether the required corporate or official seal has been applied to the executed document.',
    `seal_required_flag` BOOLEAN COMMENT 'Indicates whether a corporate seal or official seal is required for valid execution of this document.',
    `signatures_completed_count` STRING COMMENT 'Number of parties who have completed their signature to date. Used to track execution progress.',
    `signing_party_count` STRING COMMENT 'Total number of parties required to sign this document for full execution.',
    `witness_count_obtained` STRING COMMENT 'Number of witness signatures obtained to date. Used to track completion of witnessing requirements.',
    `witness_count_required` STRING COMMENT 'Number of witnesses required for valid execution, if witnessing is required. Null if no witnesses required.',
    `witness_required_flag` BOOLEAN COMMENT 'Indicates whether witness signatures are required for this document execution to be legally valid.',
    CONSTRAINT pk_doc_execution PRIMARY KEY(`doc_execution_id`)
) COMMENT 'Records the formal execution of legal documents including signing parties, execution method (wet ink, DocuSign, Adobe Sign), execution date, counterpart details, governing law, and notarization or witnessing requirements. Tracks execution status through the signing workflow and stores the executed document reference. Authoritative record for contract execution events across M&A, CLM, and engagement letter workflows.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`document`.`doc_template` (
    `doc_template_id` BIGINT COMMENT 'Unique identifier for the document template record. Primary key.',
    `agreement_type_id` BIGINT COMMENT 'Foreign key linking to contract.agreement_type. Business justification: Document templates are designed for specific agreement types. NDA template maps to NDA agreement_type, employment agreement template to employment agreement_type. Required for template library organiz',
    `attorney_profile_id` BIGINT COMMENT 'Identifier of the partner who approved this template for use. The approving partner is accountable for the legal accuracy and quality of the template content.',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: Templates are created for specific service offerings (M&A closing checklist, employment termination letter). Essential for service standardization, automation, quality control, and service catalog man',
    `timekeeper_id` BIGINT COMMENT 'Identifier of the lawyer or knowledge management professional who originally created or drafted this template. Provides attribution and a contact for questions.',
    `access_level` STRING COMMENT 'Security classification determining which users and groups can view and use this template. Enforces information barriers and protects sensitive or strategic template content.. Valid values are `public|practice_group|partner_only|restricted`',
    `approval_date` DATE COMMENT 'Date on which the template received formal approval for use. Used to track template currency and trigger periodic review cycles.',
    `approval_status` STRING COMMENT 'Current approval state of the template in the knowledge management workflow. Only approved templates are available for general use by fee earners.. Valid values are `draft|under_review|approved|archived|deprecated|withdrawn`',
    `automation_platform` STRING COMMENT 'The document automation or assembly platform for which this template is configured (e.g., HotDocs, Contract Express, Smokeball). Null if no automation is present.',
    `contains_automation` BOOLEAN COMMENT 'Indicates whether the template includes document automation features such as conditional logic, field merges, or calculation formulas. True if automation is present, False otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this template record was first created in the knowledge management system. Part of the audit trail for template lifecycle management.',
    `document_type` STRING COMMENT 'Classification of the document template by legal document category. Determines workflow, review requirements, and retention policies. [ENUM-REF-CANDIDATE: contract|agreement|memorandum|brief|motion|pleading|opinion_letter|advice_memo|disclosure_schedule|board_resolution|shareholder_resolution|notice|demand_letter|settlement_agreement|nda|engagement_letter — 16 candidates stripped; promote to reference product]',
    `file_format` STRING COMMENT 'The file format in which the template is stored and distributed. Determines compatibility with document assembly systems and editing tools.. Valid values are `docx|pdf|rtf|odt|html`',
    `governing_law` STRING COMMENT 'The body of law that governs the interpretation and enforcement of documents created from this template. May differ from jurisdiction in cross-border matters.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the template is currently active and available for use. True if active, False if archived or deprecated. Controls template visibility in user-facing systems.',
    `is_client_facing` BOOLEAN COMMENT 'Indicates whether documents generated from this template are typically shared with or delivered to clients. True if client-facing, False if internal work product. Affects quality assurance and review requirements.',
    `jurisdiction` STRING COMMENT 'The legal jurisdiction for which this template is designed and approved. May be a country, state, province, or multi-jurisdictional. Critical for ensuring compliance with local legal requirements and court rules.',
    `language` STRING COMMENT 'The primary language in which the template is drafted. Critical for multi-jurisdictional firms serving clients across language boundaries.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the template record or content. Tracks template evolution and supports version control integration.',
    `last_review_date` DATE COMMENT 'Date of the most recent substantive review of the template content for legal accuracy, regulatory compliance, and alignment with current firm standards. Critical for maintaining template quality and mitigating risk.',
    `last_used_date` DATE COMMENT 'Date on which the template was most recently used to create a document. Helps identify obsolete or underutilized templates for archival.',
    `modified_by_user_code` BIGINT COMMENT 'Identifier of the user who last modified the template. Provides accountability and a contact for questions about recent changes.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next mandatory review of the template. Triggers workflow notifications to the responsible practice group to ensure templates remain current with legal and regulatory changes.',
    `owner_practice_group` STRING COMMENT 'The practice group or department responsible for maintaining, updating, and governing this template. Determines accountability for template quality and currency.',
    `page_count` STRING COMMENT 'Approximate page count of the template when rendered in standard formatting. Assists with printing, filing, and complexity assessment.',
    `practice_area` STRING COMMENT 'The legal practice area or department to which this template belongs. Determines which practice group maintains and approves updates to the template. [ENUM-REF-CANDIDATE: corporate|litigation|intellectual_property|employment|real_estate|tax|regulatory_compliance|mergers_and_acquisitions|dispute_resolution|banking_and_finance — 10 candidates stripped; promote to reference product]',
    `precedent_references` STRING COMMENT 'References to related precedent documents, prior transactions, or exemplar work product that informed the development of this template. Supports knowledge reuse and maintains institutional memory.',
    `primary_doc_type_id` BIGINT COMMENT 'FK to document.doc_type.doc_type_id — Templates are created for specific document types. This FK enables template lookup by type and ensures template governance aligns with document classification.',
    `regulatory_compliance_notes` STRING COMMENT 'Notes on specific regulatory requirements, court rules, or compliance frameworks that this template addresses (e.g., GDPR (General Data Protection Regulation), SOX (Sarbanes-Oxley Act), FRAND (Fair Reasonable and Non-Discriminatory) terms). Critical for risk management and audit trails.',
    `related_matter_types` STRING COMMENT 'Comma-separated list of matter types or transaction categories for which this template is commonly used. Facilitates template discovery during matter intake and planning.',
    `requires_partner_review` BOOLEAN COMMENT 'Indicates whether documents generated from this template must be reviewed by a partner before finalization or delivery. True if partner review is mandatory, False otherwise. Enforces quality control and risk management protocols.',
    `retention_period_years` STRING COMMENT 'Number of years this template and its usage records must be retained per the firms records retention policy and applicable legal requirements. Drives archival and disposal workflows.',
    `storage_location` STRING COMMENT 'The file path or URI where the template master file is stored in the DMS (iManage Work or NetDocuments). Used for retrieval and version control integration.',
    `tags` STRING COMMENT 'Comma-separated list of keywords and tags for search, filtering, and categorization within the knowledge management system. Enhances template discoverability.',
    `template_code` STRING COMMENT 'Unique alphanumeric code assigned to the template for cataloging and reference purposes. Used for cross-system identification between iManage Work, NetDocuments, and Thomson Reuters Practical Law.',
    `template_description` STRING COMMENT 'Detailed description of the templates purpose, intended use cases, key provisions, and any special instructions for customization. Provides guidance to lawyers on when and how to use the template.',
    `template_name` STRING COMMENT 'The business name of the document template as it appears in the knowledge management system and DMS (Document Management System). Human-readable identifier used by legal professionals to locate and select the appropriate template.',
    `template_version` STRING COMMENT 'Version identifier for the template following the firms version control standards. Incremented with each substantive revision to track template evolution and ensure users access current forms.',
    `usage_count` STRING COMMENT 'Total number of times this template has been used to generate a document. Tracks template popularity and value to the practice.',
    `usage_instructions` STRING COMMENT 'Step-by-step guidance for completing and customizing the template, including required fields, optional clauses, and common variations. May reference related checklists and practice notes.',
    `word_count` STRING COMMENT 'Approximate word count of the template document. Used for scoping, time estimation, and document complexity assessment.',
    CONSTRAINT pk_doc_template PRIMARY KEY(`doc_template_id`)
) COMMENT 'Catalog of approved document templates and precedent forms maintained in Thomson Reuters Practical Law and the firms knowledge management system. Records template name, practice area, jurisdiction, version, approval status, approving partner, last review date, and associated clause library references. Serves as the authoritative source for standardized drafting starting points across all practice groups.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`document`.`doc_relationship` (
    `doc_relationship_id` BIGINT COMMENT 'Unique identifier for the document relationship record. Primary key.',
    `contract_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Document relationships group exhibits, attachments, and amendments by agreement for contract assembly and version control. Relationship defines Exhibit A is attached to Agreement #2020-078. Essentia',
    `doc_production_id` BIGINT COMMENT 'Identifier of the production batch in which this document relationship was produced. Links to eDiscovery production tracking.',
    `family_group_id` BIGINT COMMENT 'Identifier for the eDiscovery family grouping to which both documents belong. Used for family deduplication and production set management in Relativity.',
    `ip_asset_id` BIGINT COMMENT 'Foreign key linking to ip.asset. Business justification: Document relationships in IP practice (parent-child patent applications, related trademark applications, continuation chains) relate to IP assets. IP family management and prosecution workflow require',
    `matter_id` BIGINT COMMENT 'Identifier of the matter or case to which this document relationship belongs. Provides matter context for the relationship.',
    `parent_doc_relationship_id` BIGINT COMMENT 'Self-referencing FK on doc_relationship (parent_doc_relationship_id)',
    `legal_document_id` BIGINT COMMENT 'Identifier of the originating document in the relationship. The document from which the relationship originates.',
    `target_legal_document_id` BIGINT COMMENT 'Identifier of the destination document in the relationship. The document to which the relationship points.',
    `timekeeper_id` BIGINT COMMENT 'Identifier of the user or system process that created this document relationship record. Used for audit trail and accountability.',
    `attachment_type` STRING COMMENT 'Specific type of attachment relationship when relationship_type is attachment. Distinguishes between email attachments, embedded objects, and other attachment forms.. Valid values are `email_attachment|embedded_object|linked_file|exhibit_attachment`',
    `bates_range_end` STRING COMMENT 'The ending Bates number for the target document in the relationship context. Defines the complete Bates range for multi-page documents.',
    `bates_range_start` STRING COMMENT 'The starting Bates number for the target document in the relationship context. Used for production tracking and document identification in litigation.',
    `chain_of_custody_verified` BOOLEAN COMMENT 'Indicates whether the chain of custody for this document relationship has been verified and validated. Critical for eDiscovery and litigation integrity.',
    `confidentiality_level` STRING COMMENT 'Confidentiality classification for the document relationship. Determines access controls and handling requirements for the linked documents.. Valid values are `public|internal|confidential|restricted|highly_confidential`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this document relationship record was first created in the system. Used for audit trail and temporal tracking.',
    `effective_date` DATE COMMENT 'The date on which this document relationship became effective or was established. Used for temporal tracking of relationship validity.',
    `end_date` DATE COMMENT 'The date on which this document relationship ceased to be valid or was terminated. Null if the relationship is still active.',
    `exhibit_number` STRING COMMENT 'The exhibit number assigned to the target document when referenced in court filings or legal proceedings. Used for exhibit list generation and court bundle assembly.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this document relationship record is currently active and valid. Used for soft deletion and historical tracking.',
    `modified_by_user_code` STRING COMMENT 'Identifier of the user or system process that last modified this document relationship record. Used for audit trail and change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this document relationship record was last modified. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text notes or comments about this document relationship. Provides additional context or explanations for the relationship.',
    `privilege_designation` STRING COMMENT 'Privilege status designation for the document relationship. Indicates whether the relationship involves privileged communications or work product.. Valid values are `privileged|non_privileged|work_product|attorney_client|joint_defense`',
    `production_flag` BOOLEAN COMMENT 'Indicates whether this document relationship is included in eDiscovery production sets. Used for production planning and tracking.',
    `relationship_basis` STRING COMMENT 'Textual explanation of the business or legal basis for establishing this document relationship. Provides context for why the relationship exists.',
    `relationship_category` STRING COMMENT 'High-level category grouping the relationship type. Used for filtering and reporting across relationship classes.. Valid values are `versioning|discovery|litigation|transactional|workspace|correspondence`',
    `relationship_direction` STRING COMMENT 'Indicates whether the relationship is one-way (unidirectional) or two-way (bidirectional). Determines if the relationship implies a reciprocal link.. Valid values are `unidirectional|bidirectional`',
    `relationship_hash` STRING COMMENT 'Cryptographic hash of the relationship metadata to ensure integrity and detect tampering. Used for audit trail and chain of custody verification.',
    `relationship_source_system` STRING COMMENT 'The system or method that created this document relationship. Indicates whether the relationship was system-generated or manually established.. Valid values are `imanage|netdocuments|relativity|manual|automated`',
    `relationship_status` STRING COMMENT 'Current lifecycle status of the document relationship. Indicates whether the relationship is currently valid and active.. Valid values are `active|inactive|superseded|archived`',
    `relationship_type` STRING COMMENT 'The type of relationship between the source and target documents. Defines the semantic nature of the link (e.g., parent-child for email threads, exhibit for court filings, supersedes for contract versions, family_group for eDiscovery deduplication). [ENUM-REF-CANDIDATE: parent_child|attachment|exhibit|supersedes|amends|related|family_group|thread|bundle|reference — 10 candidates stripped; promote to reference product]',
    `sequence_number` STRING COMMENT 'Ordinal position of this relationship within a set of related documents. Used for ordering attachments, exhibits, or version chains.',
    `target_legal_document` BIGINT COMMENT 'FK to document.legal_document.legal_document_id — The target document in a relationship pair. Required for bidirectional relationship traversal — every relationship must have a target document reference.',
    `thread_position` STRING COMMENT 'Position of the document within an email thread or conversation chain. Used for reconstructing email correspondence sequences.',
    `version_sequence` STRING COMMENT 'Sequential version number in a supersedes or amends chain. Used for tracking contract amendment history and document evolution.',
    `workspace_code` STRING COMMENT 'Identifier of the DMS workspace or Relativity workspace where this relationship is maintained. Provides system context for the relationship.',
    CONSTRAINT pk_doc_relationship PRIMARY KEY(`doc_relationship_id`)
) COMMENT 'Models typed relationships between legal documents including parent-child (email thread to attachment), document family groupings for eDiscovery, exhibit references for court filings, supersedes/amends chains for contract versions, and related-document links for matter workspaces. Captures relationship type, source document, target document, relationship direction, effective date, and matter context. Essential for eDiscovery family deduplication, exhibit list generation, court bundle assembly, and amendment chain tracing.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`document`.`custodian_hold` (
    `custodian_hold_id` BIGINT COMMENT 'Unique identifier for this custodian-hold assignment record. Primary key.',
    `esi_custodian_id` BIGINT COMMENT 'Foreign key linking to the ESI custodian whose data is subject to preservation under this hold',
    `legal_hold_id` BIGINT COMMENT 'Foreign key linking to the legal hold notice issued for this custodian',
    `matter_id` BIGINT COMMENT 'Foreign key to matter.matter.matter_id',
    `acknowledgement_date` DATE COMMENT 'Date on which this custodian formally acknowledged receipt and understanding of the legal hold notice.',
    `acknowledgement_status` STRING COMMENT 'Current status of this custodians acknowledgement of the legal hold notice.',
    `collection_completion_date` DATE COMMENT 'Date on which ESI collection activities were completed for this custodian under this hold.',
    `collection_custodian_notes` STRING COMMENT 'Internal notes documenting collection activities, challenges, exceptions, and custodian cooperation for this custodian. [Moved from esi_custodian: These notes document collection activities specific to THIS custodian-hold assignment.]',
    `collection_file_count` BIGINT COMMENT 'Total number of files and documents collected from this custodian for this hold.',
    `collection_method` STRING COMMENT 'Method used to collect ESI from this custodians data sources for this hold.',
    `collection_notes` STRING COMMENT 'Internal notes documenting collection activities, challenges, exceptions, and custodian-specific considerations for this hold assignment.',
    `collection_start_date` DATE COMMENT 'Date on which ESI collection activities commenced for this custodian under this hold.',
    `collection_status` STRING COMMENT 'Current status of ESI collection activities for this custodian under this specific legal hold.',
    `collection_volume_gb` DECIMAL(18,2) COMMENT 'Total volume of ESI collected from this custodian for this hold, measured in gigabytes.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this custodian-hold assignment record was created.',
    `custodian_interview_date` DATE COMMENT 'Date on which the custodian interview was conducted to identify relevant data sources and custodial holdings. [Moved from esi_custodian: The interview is conducted in the context of a SPECIFIC hold to identify relevant data sources for that matter. The same custodian may be interviewed multiple times for different holds.]',
    `custodian_interview_notes` STRING COMMENT 'Summary notes from the custodian interview documenting data sources, file locations, communication patterns, and relevant ESI holdings. [Moved from esi_custodian: Interview notes are specific to the data sources and preservation scope relevant to THIS hold. Different holds may require different interview focus areas.]',
    `custodian_status` STRING COMMENT 'Current lifecycle status of this custodian within this specific legal hold workflow.',
    `escalation_count` STRING COMMENT 'Number of times this custodians non-compliance with this hold has been escalated to management or legal counsel.',
    `exemption_reason` STRING COMMENT 'Explanation for why this custodian was exempted from preservation or collection requirements under this hold (e.g., no relevant data, left organization before trigger date).',
    `interview_date` DATE COMMENT 'Date on which the custodian interview was conducted to identify relevant data sources and preservation scope for this hold.',
    `interview_notes` STRING COMMENT 'Summary notes from the custodian interview documenting data sources, file locations, and preservation scope specific to this hold assignment.',
    `issued_date` DATE COMMENT 'Date on which the legal hold notice was issued to this specific custodian, triggering preservation obligations.',
    `last_reminder_date` DATE COMMENT 'Date on which the most recent reminder notice was sent to this custodian for this hold.',
    `legal_hold_acknowledgement_status` STRING COMMENT 'Status of the custodians acknowledgement of the legal hold notice. [Moved from esi_custodian: This status is specific to THIS custodians acknowledgement of THIS hold. The same custodian may have different acknowledgement statuses for different holds.]. Valid values are `pending|acknowledged|declined|overdue`',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this custodian-hold assignment record was last modified.',
    `release_date` DATE COMMENT 'Date on which the legal hold was released for this specific custodian, ending their preservation obligations.',
    `reminder_count` STRING COMMENT 'Number of reminder notices sent to this custodian for this specific hold.',
    CONSTRAINT pk_custodian_hold PRIMARY KEY(`custodian_hold_id`)
) COMMENT 'This association product represents the assignment of legal hold notices to ESI custodians in litigation and investigation matters. It captures the issuance, acknowledgement, compliance monitoring, and release lifecycle for each custodian-hold pairing. Each record links one custodian to one legal hold with attributes that track the custodians specific preservation obligations, acknowledgement status, interview details, and collection activities under that hold. This is a core eDiscovery workflow entity managed actively throughout the litigation lifecycle.. Existence Justification: In legal eDiscovery practice, legal holds are issued to multiple custodians, and custodians are frequently subject to multiple concurrent legal holds across different matters. Law firms and legal departments actively manage custodian-hold assignments as a distinct workflow: issuing notices, tracking acknowledgements, conducting custodian interviews, monitoring collection progress, and releasing custodians when holds are lifted. This is not a reference relationship—it is an operational business process with its own lifecycle, compliance requirements, and risk management implications governed by FRCP Rule 26 and spoliation case law.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`document`.`production_source` (
    `production_source_id` BIGINT COMMENT 'Unique identifier for this production-collection source mapping. Primary key.',
    `doc_production_id` BIGINT COMMENT 'Foreign key linking to the eDiscovery production set that includes documents from this collection source.',
    `esi_collection_id` BIGINT COMMENT 'Foreign key linking to the ESI collection event that serves as a source for this production.',
    `matter_id` BIGINT COMMENT 'Foreign key to matter.matter.matter_id',
    `bates_range_end` STRING COMMENT 'Last Bates number assigned to documents from this collection within this production. Marks the end of the Bates range for this collection subset.',
    `bates_range_start` STRING COMMENT 'First Bates number assigned to documents from this collection within this production. Since a production may draw from multiple collections, each collection subset receives its own Bates range within the overall production numbering scheme.',
    `collection_subset_filter` STRING COMMENT 'Description of any filters, search terms, or date range restrictions applied to this collection when selecting documents for this production. For example, custodian emails 2019-2021 only or responsive documents tagged hot. This filter is specific to the production-collection pairing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this production-collection source mapping was created in the eDiscovery platform, typically during production assembly workflow.',
    `document_count_from_collection` STRING COMMENT 'Number of documents from this specific ESI collection that were included in the production set. This count is specific to the collection-production pairing and cannot live on either entity alone (a collection contributes different counts to different productions; a production draws different counts from different collections).',
    `inclusion_reason` STRING COMMENT 'Business reason or legal justification for including this collection in this production (e.g., responsive to RFP 001-005, supplemental production per court order, custodian added to scope).',
    `production_date` DATE COMMENT 'Date on which documents from this collection were included in the production delivery. In multi-phase productions, different collections may be produced on different dates, making this attribute specific to the collection-production relationship.',
    `created_by` STRING COMMENT 'User or system account that created this production-collection source mapping, important for audit trail and workflow tracking.',
    CONSTRAINT pk_production_source PRIMARY KEY(`production_source_id`)
) COMMENT 'This association product represents the sourcing relationship between eDiscovery production sets and the ESI collections from which they are derived. In eDiscovery workflows, a single production may draw documents from multiple collection events (e.g., combining custodian collections), and a single collection may contribute documents to multiple productions over time (initial production, supplemental production, different matters). Each record captures the subset of documents from a specific collection included in a specific production, along with the Bates numbering applied to that subset and any collection-specific filters or date ranges used during production assembly.. Existence Justification: In eDiscovery operations, production sets routinely draw documents from multiple ESI collection events (e.g., combining collections from different custodians, time periods, or data sources into a single production), and a single collection event commonly contributes documents to multiple productions over the lifecycle of a matter (initial production, supplemental productions, productions for different matters sharing custodians). Legal teams actively manage this many-to-many relationship in platforms like Relativity during production assembly, applying collection-specific Bates ranges, filters, and document counts that exist only in the context of each production-collection pairing.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`document`.`template_clause_usage` (
    `template_clause_usage_id` BIGINT COMMENT 'Unique identifier for this template-clause usage record. Primary key.',
    `timekeeper_id` BIGINT COMMENT 'Reference to the knowledge management professional or attorney who added this clause to the template. Provides accountability for template design decisions.',
    `clause_id` BIGINT COMMENT 'Foreign key linking to the clause library entry being used in the template',
    `doc_template_id` BIGINT COMMENT 'Foreign key linking to the document template that incorporates this clause',
    `added_date` DATE COMMENT 'Date when this clause was first incorporated into this template. Tracks the history of template evolution.',
    `clause_library_references` STRING COMMENT 'Comma-separated list of clause library identifiers for standard clauses incorporated into or available for use with this template. Enables lawyers to access pre-approved alternative language and optional provisions. [Moved from doc_template: This attribute in doc_template is a comma-separated list of clause identifiers, which is a denormalized representation of the many-to-many relationship. The proper normalized model is this association table, making this attribute redundant and a candidate for removal or deprecation.]',
    `clause_position_in_template` STRING COMMENT 'The ordinal position or sequence number of this clause within the template document structure. Determines the order in which clauses appear when the template is assembled.',
    `clause_variant_selected` STRING COMMENT 'The specific variant of the clause selected for use in this template (e.g., Standard, Aggressive, Conservative, Client-Favorable). Maps to the variant_label in the clause library.',
    `customization_notes` STRING COMMENT 'Template-specific notes describing any customizations, modifications, or special instructions for this clause when used in this particular template. Captures context that applies only to this template-clause combination.',
    `last_updated_date` DATE COMMENT 'Date when this template-clause usage record was last modified, including changes to position, variant, customization notes, or mandatory status. Tracks the evolution of template composition.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether this clause is mandatory (cannot be removed) or optional (can be excluded) when using this template. The same clause may be mandatory in one template and optional in another.',
    `section_heading` STRING COMMENT 'The section or heading under which this clause appears in the template (e.g., Representations and Warranties, Indemnification, General Provisions). Provides structural context.',
    CONSTRAINT pk_template_clause_usage PRIMARY KEY(`template_clause_usage_id`)
) COMMENT 'This association product represents the operational relationship between document templates and clause library entries in the firms knowledge management system. It captures which clauses are incorporated into which templates, including the clauses position within the template, the specific variant selected, customization notes, and whether the clause is mandatory or optional. Each record represents a deliberate design decision by knowledge management professionals about template composition and is actively managed as templates evolve.. Existence Justification: In legal knowledge management systems, document templates are assembled from multiple reusable clause library entries, and each clause is designed to be reused across multiple templates. Knowledge management teams actively manage these template-clause mappings, making deliberate decisions about which clause variant to use, where to position it, whether its mandatory, and any template-specific customizations. This is a core operational process in contract automation and template governance.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`document`.`review_set` (
    `review_set_id` BIGINT COMMENT 'Primary key for review_set',
    `employee_id` BIGINT COMMENT 'Reference to the attorney or legal professional responsible for overseeing this review set.',
    `legal_hold_id` BIGINT COMMENT 'Reference to the legal hold order under which this review set was preserved and collected.',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter or case to which this review set belongs.',
    `parent_review_set_id` BIGINT COMMENT 'Self-referencing FK on review_set (parent_review_set_id)',
    `policy_id` BIGINT COMMENT 'Reference to the records retention policy governing the lifecycle and disposal of this review set.',
    `production_set_id` BIGINT COMMENT 'Reference to the production set generated from this review set for disclosure to opposing counsel or regulatory authorities.',
    `user_id` BIGINT COMMENT 'Reference to the user who created the review set record.',
    `review_modified_by_user_id` BIGINT COMMENT 'Reference to the user who last modified the review set record.',
    `tar_model_id` BIGINT COMMENT 'Reference identifier for the TAR or predictive coding model applied to this review set, if applicable.',
    `assigned_reviewer_count` STRING COMMENT 'Number of reviewers assigned to work on this review set.',
    `chain_of_custody_verified` BOOLEAN COMMENT 'Indicates whether the chain of custody for all documents in the review set has been verified and documented for evidentiary purposes.',
    `completed_timestamp` TIMESTAMP COMMENT 'Date and time when the review set was marked as completed, indicating all review activities have concluded.',
    `confidentiality_designation` STRING COMMENT 'Protective designation assigned to the review set indicating the level of confidentiality and access restrictions.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the review set record was first created in the system.',
    `custodian_count` STRING COMMENT 'Number of distinct custodians (document owners or sources) represented in this review set.',
    `date_range_end` DATE COMMENT 'Latest document date included in the review set, defining the temporal scope of the collection.',
    `date_range_start` DATE COMMENT 'Earliest document date included in the review set, defining the temporal scope of the collection.',
    `deduplication_applied` BOOLEAN COMMENT 'Indicates whether deduplication processing was applied to remove duplicate documents from the review set.',
    `review_set_description` STRING COMMENT 'Detailed narrative description of the review set purpose, scope, and any special instructions or context.',
    `document_count` BIGINT COMMENT 'Total number of documents included in this review set at the time of measurement.',
    `email_threading_applied` BOOLEAN COMMENT 'Indicates whether email threading analysis was applied to organize email conversations within the review set.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the review set record was last modified.',
    `near_duplicate_identification_applied` BOOLEAN COMMENT 'Indicates whether near-duplicate detection algorithms were applied to identify substantially similar documents.',
    `nlp_processing_applied` BOOLEAN COMMENT 'Indicates whether Natural Language Processing techniques were applied for entity extraction, sentiment analysis, or other linguistic analysis.',
    `ocr_applied` BOOLEAN COMMENT 'Indicates whether Optical Character Recognition processing was applied to extract text from image-based documents.',
    `privileged_document_count` BIGINT COMMENT 'Number of documents designated as privileged (attorney-client privilege, work product, etc.) within this review set.',
    `quality_control_accuracy_rate` DECIMAL(18,2) COMMENT 'Measured accuracy rate from quality control sampling, expressed as a decimal proportion.',
    `quality_control_sample_size` STRING COMMENT 'Number of documents selected for quality control review to validate coding accuracy and consistency.',
    `responsive_document_count` BIGINT COMMENT 'Number of documents marked as responsive to the legal matter or discovery request within this review set.',
    `review_methodology` STRING COMMENT 'The review approach or methodology applied to this set, such as Technology Assisted Review (TAR), Continuous Active Learning (CAL), or linear review.',
    `review_platform` STRING COMMENT 'Name of the eDiscovery or document review platform where this review set is hosted and managed.',
    `review_set_code` STRING COMMENT 'Externally-known unique code or identifier for the review set, often used for cross-system reference and reporting.',
    `review_set_name` STRING COMMENT 'Human-readable name or title assigned to the review set for identification and organizational purposes.',
    `review_status` STRING COMMENT 'Current lifecycle status of the review set indicating its operational state.',
    `review_type` STRING COMMENT 'Classification of the review set indicating the purpose or stage of document review (e.g., first pass review, privilege review, quality control).',
    `reviewed_document_count` BIGINT COMMENT 'Number of documents that have been reviewed and coded within this review set.',
    `search_terms_applied` STRING COMMENT 'Summary or reference to the keyword search terms, Boolean queries, or filters applied to create this review set.',
    `tar_precision_score` DECIMAL(18,2) COMMENT 'Precision metric of the TAR model indicating the proportion of predicted responsive documents that are actually responsive.',
    `tar_recall_score` DECIMAL(18,2) COMMENT 'Recall metric of the TAR model indicating the proportion of all responsive documents that were correctly identified.',
    `total_page_count` BIGINT COMMENT 'Aggregate count of all pages across all documents in the review set.',
    `total_size_gb` DECIMAL(18,2) COMMENT 'Total data volume of all documents in the review set measured in gigabytes.',
    CONSTRAINT pk_review_set PRIMARY KEY(`review_set_id`)
) COMMENT 'Master reference table for review_set. Referenced by review_set_id.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`document`.`review_session` (
    `review_session_id` BIGINT COMMENT 'Primary key for review_session',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the supervising attorney who provides legal oversight and quality assurance for this review session.',
    `employee_id` BIGINT COMMENT 'Reference to the attorney or senior reviewer responsible for overseeing this review session.',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter or case to which this review session belongs.',
    `prior_review_session_id` BIGINT COMMENT 'Self-referencing FK on review_session (prior_review_session_id)',
    `user_id` BIGINT COMMENT 'Reference to the user who created this review session record.',
    `review_modified_by_user_id` BIGINT COMMENT 'Reference to the user who last modified this review session record.',
    `review_project_id` BIGINT COMMENT 'Reference to the eDiscovery or document review project under which this session is organized.',
    `review_set_id` BIGINT COMMENT 'Reference to the specific collection or batch of documents assigned to this review session.',
    `workspace_id` BIGINT COMMENT 'External identifier for the workspace or case environment within the review platform where this session was conducted.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual cost incurred for this review session, calculated from recorded hours and billing rates.',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual date and time when the review session was completed or terminated.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when the review session commenced, capturing the real-world event time.',
    `average_review_time_seconds` DECIMAL(18,2) COMMENT 'Mean time in seconds spent reviewing each document during this session, used for productivity and cost analysis.',
    `coding_layout_name` STRING COMMENT 'Name of the coding layout or form template used by reviewers to code documents during this session.',
    `confidentiality_level` STRING COMMENT 'Classification level indicating the sensitivity and access restrictions for documents and data within this review session.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this review session record was first created in the system.',
    `custodian_filter` STRING COMMENT 'Custodian or data source filter applied to scope the documents included in this review session.',
    `date_range_filter_end` DATE COMMENT 'End date of the date range filter applied to documents in this review session.',
    `date_range_filter_start` DATE COMMENT 'Start date of the date range filter applied to documents in this review session.',
    `documents_pending` STRING COMMENT 'Count of documents remaining to be reviewed in this session.',
    `documents_reviewed` STRING COMMENT 'Count of documents that have been reviewed and coded during this session.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Projected cost for completing this review session, based on estimated hours and billing rates.',
    `hot_document_count` STRING COMMENT 'Count of documents flagged as hot or key documents requiring special attention or escalation during this session.',
    `is_billable` BOOLEAN COMMENT 'Indicates whether the time and costs associated with this review session are billable to the client.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this review session record was last modified.',
    `non_responsive_document_count` STRING COMMENT 'Count of documents coded as non-responsive during this review session.',
    `privilege_designation_count` STRING COMMENT 'Count of documents designated as privileged during this review session.',
    `quality_control_error_rate` DECIMAL(18,2) COMMENT 'Percentage of documents in the QC sample that were found to have coding errors or inconsistencies.',
    `quality_control_sample_size` STRING COMMENT 'Number of documents selected for quality control review to validate coding accuracy and consistency.',
    `redaction_required_count` STRING COMMENT 'Count of documents identified as requiring redaction for privileged or confidential information during this session.',
    `responsive_document_count` STRING COMMENT 'Count of documents coded as responsive to the matter or discovery request during this session.',
    `review_completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of assigned documents that have been reviewed, calculated as (documents_reviewed / total_documents_assigned) * 100.',
    `review_platform` STRING COMMENT 'The eDiscovery or document review platform used to conduct this review session.',
    `review_protocol` STRING COMMENT 'The methodology or protocol applied during this review session, such as Technology Assisted Review (TAR), Continuous Active Learning (CAL), or traditional linear review.',
    `scheduled_end_timestamp` TIMESTAMP COMMENT 'Planned date and time when the review session is scheduled to conclude.',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'Planned date and time when the review session is scheduled to begin.',
    `search_terms_applied` STRING COMMENT 'Keyword search terms or queries applied to filter or prioritize documents for this review session.',
    `session_notes` STRING COMMENT 'Free-text notes or comments recorded by the lead reviewer or supervising attorney regarding this review session.',
    `session_number` STRING COMMENT 'Business-facing unique identifier for the review session, typically formatted as RS-YYYYMMDD-XXXXXX for external reference and tracking.',
    `session_type` STRING COMMENT 'Classification of the review session based on its purpose within the document review workflow.',
    `review_session_status` STRING COMMENT 'Current lifecycle status of the review session indicating its operational state.',
    `total_documents_assigned` STRING COMMENT 'Total count of documents allocated to this review session for review.',
    `total_review_hours` DECIMAL(18,2) COMMENT 'Cumulative hours spent by all reviewers during this review session.',
    CONSTRAINT pk_review_session PRIMARY KEY(`review_session_id`)
) COMMENT 'Master reference table for review_session. Referenced by session_id.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`document`.`execution_workflow` (
    `execution_workflow_id` BIGINT COMMENT 'Primary key for execution_workflow',
    `doc_template_id` BIGINT COMMENT 'Reference to the standard document template used in this execution workflow.',
    `doc_type_id` BIGINT COMMENT 'Reference to the type of legal document this workflow is designed for (e.g., contract, agreement, pleading, motion).',
    `user_id` BIGINT COMMENT 'Reference to the user who created this workflow definition.',
    `execution_modified_by_user_id` BIGINT COMMENT 'Reference to the user who last modified this workflow definition.',
    `owner_user_id` BIGINT COMMENT 'Reference to the user or attorney who owns and maintains this workflow definition.',
    `primary_superseding_execution_workflow_id` BIGINT COMMENT 'Reference to the newer workflow version that supersedes this one, if applicable.',
    `approval_authority_level` STRING COMMENT 'Level of authority required for approval (e.g., Partner, Senior Associate, General Counsel, Board).',
    `approval_required` BOOLEAN COMMENT 'Indicates whether formal approval is required before execution can proceed.',
    `audit_trail_required` BOOLEAN COMMENT 'Indicates whether a complete audit trail of all execution activities must be maintained for compliance.',
    `business_unit` STRING COMMENT 'Business unit or department that primarily uses this execution workflow.',
    `chain_of_custody_required` BOOLEAN COMMENT 'Indicates whether chain of custody documentation is required for evidentiary purposes.',
    `compliance_framework` STRING COMMENT 'Regulatory or compliance framework this workflow must adhere to (e.g., ESIGN Act, UETA, eIDAS, SOX, GDPR).',
    `confidentiality_level` STRING COMMENT 'Default confidentiality classification for documents executed through this workflow.',
    `cost_center` STRING COMMENT 'Cost center code for financial tracking of execution activities using this workflow.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this workflow record was first created in the system.',
    `effective_from_date` DATE COMMENT 'Date from which this workflow version becomes effective and available for use.',
    `effective_until_date` DATE COMMENT 'Date until which this workflow version remains effective; null for open-ended workflows.',
    `escalation_threshold_days` STRING COMMENT 'Number of days after which the workflow should be escalated if not completed.',
    `execution_method` STRING COMMENT 'Method by which documents are executed in this workflow (electronic signature, physical wet ink, hybrid, notarized, apostille).',
    `is_default_workflow` BOOLEAN COMMENT 'Indicates whether this is the default workflow for its document type and jurisdiction.',
    `jurisdiction_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code or jurisdiction code where this workflow is applicable (e.g., USA, GBR, CAN).',
    `last_used_timestamp` TIMESTAMP COMMENT 'Timestamp when this workflow was last used for a document execution.',
    `maximum_signatories` STRING COMMENT 'Maximum number of signatories allowed in this execution workflow.',
    `minimum_signatories` STRING COMMENT 'Minimum number of signatories required to complete this execution workflow.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this workflow record was last modified.',
    `practice_area` STRING COMMENT 'Legal practice area or domain this workflow applies to (e.g., Corporate, Litigation, Intellectual Property, Employment, Regulatory Compliance).',
    `privilege_designation` STRING COMMENT 'Legal privilege classification applicable to documents in this workflow (attorney-client, work product, joint defense, none).',
    `requires_notarization` BOOLEAN COMMENT 'Indicates whether this workflow requires notarization for legal validity.',
    `requires_witness` BOOLEAN COMMENT 'Indicates whether this workflow requires witness signatures for legal validity.',
    `retention_period_years` STRING COMMENT 'Number of years executed documents must be retained per legal and regulatory requirements.',
    `sequence_type` STRING COMMENT 'Defines how signatories are sequenced in the workflow (sequential order, parallel/simultaneous, hybrid, conditional routing).',
    `signature_platform` STRING COMMENT 'Electronic signature platform or system used for this workflow (e.g., DocuSign, Adobe Sign, HelloSign, internal system).',
    `special_instructions` STRING COMMENT 'Additional instructions or notes for users executing documents through this workflow.',
    `standard_turnaround_days` STRING COMMENT 'Expected number of business days for completion of this execution workflow under normal circumstances.',
    `usage_count` BIGINT COMMENT 'Total number of times this workflow has been used for document execution.',
    `version_number` STRING COMMENT 'Version number of this workflow definition (e.g., 1.0, 2.1, 3.0.1) for change tracking.',
    `workflow_code` STRING COMMENT 'Externally-known unique business identifier or code for the workflow (e.g., EXEC-STD-001, NDA-SIG-V2).',
    `workflow_description` STRING COMMENT 'Detailed description of the workflow purpose, steps, and business context.',
    `workflow_name` STRING COMMENT 'Human-readable name or title of the execution workflow (e.g., Contract Execution - Standard, NDA Signature Flow).',
    `workflow_status` STRING COMMENT 'Current lifecycle status of the execution workflow indicating whether it is available for use.',
    `workflow_type` STRING COMMENT 'Classification of the execution workflow by its primary purpose (signature, approval, review, attestation, notarization, filing).',
    CONSTRAINT pk_execution_workflow PRIMARY KEY(`execution_workflow_id`)
) COMMENT 'Master reference table for execution_workflow. Referenced by execution_workflow_id.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`document`.`workspace` (
    `workspace_id` BIGINT COMMENT 'Primary key for workspace',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter associated with this workspace, linking workspace to the underlying legal engagement.',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the attorney who originated or initiated the workspace, typically the relationship partner or business developer.',
    `owner_attorney_profile_id` BIGINT COMMENT 'Reference to the attorney who has primary responsibility and oversight for this workspace and its contents.',
    `user_id` BIGINT COMMENT 'Reference to the user who owns or administers this workspace, with full control and delegation rights.',
    `parent_workspace_id` BIGINT COMMENT 'Self-referencing FK on workspace (parent_workspace_id)',
    `profile_id` BIGINT COMMENT 'Reference to the client for whom this workspace is maintained, establishing client ownership and access rights.',
    `retention_schedule_id` BIGINT COMMENT 'Reference to the records retention policy governing document lifecycle and destruction schedules for this workspace.',
    `workspace_created_by_user_id` BIGINT COMMENT 'Reference to the user who created this workspace, providing audit trail and accountability.',
    `workspace_modified_by_user_id` BIGINT COMMENT 'Reference to the user who last modified this workspace metadata, supporting audit and compliance requirements.',
    `access_control_model` STRING COMMENT 'Security model governing how user permissions and access rights are assigned and enforced for this workspace.',
    `archived_date` DATE COMMENT 'Date when the workspace was moved to archival storage, typically following closure and retention policy requirements.',
    `billing_code` STRING COMMENT 'Code used to associate workspace activity and storage costs with client billing and matter accounting.',
    `closed_date` DATE COMMENT 'Business date when the workspace was officially closed and transitioned to inactive or archived status.',
    `conflict_check_date` DATE COMMENT 'Date when the most recent conflict of interest check was performed for this workspace.',
    `conflict_check_status` STRING COMMENT 'Current state of ethical conflict of interest review for this workspace and its associated parties.',
    `cost_center` STRING COMMENT 'Internal accounting code for allocating workspace infrastructure and operational costs to organizational units.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this workspace was initially created in the system, establishing the start of its lifecycle.',
    `workspace_description` STRING COMMENT 'Detailed narrative description of the workspace purpose, scope, and key objectives or deliverables.',
    `destruction_eligible_date` DATE COMMENT 'Calculated date when workspace contents become eligible for destruction per retention policy, subject to litigation hold overrides.',
    `document_management_system` STRING COMMENT 'Source document management system platform where this workspace is hosted or synchronized from.',
    `encryption_enabled` BOOLEAN COMMENT 'Indicator whether workspace contents are encrypted at rest and in transit, meeting security and compliance requirements.',
    `external_collaboration_enabled` BOOLEAN COMMENT 'Indicator whether external parties (clients, co-counsel, experts) are permitted to access and collaborate within this workspace.',
    `external_system_code` STRING COMMENT 'Unique identifier for this workspace in the source document management system, used for synchronization and integration.',
    `jurisdiction` STRING COMMENT 'Primary legal jurisdiction or governing law applicable to this workspace and its contents, influencing compliance requirements.',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter code representing the primary language of documents and communications within this workspace.',
    `last_accessed_timestamp` TIMESTAMP COMMENT 'Date and time when any user last accessed or viewed content within this workspace, used for activity monitoring.',
    `litigation_hold_flag` BOOLEAN COMMENT 'Indicator that workspace contents are subject to litigation hold, suspending normal retention and destruction processes.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this workspace metadata was last modified, used for change tracking and synchronization.',
    `workspace_name` STRING COMMENT 'Human-readable name or title of the workspace, typically representing a matter, client, or project.',
    `notes` STRING COMMENT 'Free-form text field for administrative notes, special instructions, or contextual information about the workspace.',
    `opened_date` DATE COMMENT 'Business date when the workspace was officially opened and made available for use, distinct from system creation timestamp.',
    `practice_area` STRING COMMENT 'Primary legal practice area or specialty domain that this workspace supports, used for resource allocation and expertise routing.',
    `privilege_designation` STRING COMMENT 'Legal privilege classification applied to the workspace, indicating protection from discovery and disclosure requirements.',
    `security_classification` STRING COMMENT 'Data classification level governing access controls, encryption requirements, and handling procedures for workspace contents.',
    `workspace_status` STRING COMMENT 'Current lifecycle state of the workspace indicating its operational availability and access permissions.',
    `storage_location` STRING COMMENT 'Physical or logical storage path or container where workspace documents are persisted, including cloud or on-premises designations.',
    `total_document_count` BIGINT COMMENT 'Current count of documents contained within this workspace, used for capacity planning and billing purposes.',
    `total_storage_size_mb` DECIMAL(18,2) COMMENT 'Total storage space consumed by all documents in this workspace, measured in megabytes.',
    `version_control_enabled` BOOLEAN COMMENT 'Indicator whether document versioning and change tracking are enabled for workspace contents, supporting audit trails.',
    `workspace_number` STRING COMMENT 'Business-facing unique identifier or code for the workspace, used for external reference and user navigation.',
    `workspace_type` STRING COMMENT 'Classification of the workspace by its primary purpose or organizational structure within the legal practice.',
    CONSTRAINT pk_workspace PRIMARY KEY(`workspace_id`)
) COMMENT 'Master reference table for workspace. Referenced by workspace_id.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`document`.`production_set` (
    `production_set_id` BIGINT COMMENT 'Primary key for production_set',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter or case to which this production set belongs.',
    `parent_production_set_id` BIGINT COMMENT 'Self-referencing FK on production_set (parent_production_set_id)',
    `approval_date` DATE COMMENT 'Date on which the production set was approved for delivery by the responsible attorney or case manager.',
    `approving_attorney_name` STRING COMMENT 'Name of the attorney who approved the production set for delivery.',
    `bates_range_end` STRING COMMENT 'Ending Bates number for the production set.',
    `bates_range_start` STRING COMMENT 'Starting Bates number for the production set, used for document identification and tracking.',
    `confidentiality_designation` STRING COMMENT 'Protective order designation applied to documents in this production set.',
    `created_by_user` STRING COMMENT 'Username or identifier of the user who created the production set record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the production set record was first created in the system.',
    `custodian_count` STRING COMMENT 'Number of distinct custodians whose documents are included in this production set.',
    `data_source_count` STRING COMMENT 'Number of distinct data sources from which documents in this production set were collected.',
    `delivery_location` STRING COMMENT 'Physical or digital location where the production set was delivered (e.g., FTP path, address, cloud link).',
    `delivery_method` STRING COMMENT 'Method used to deliver the production set to the recipient.',
    `document_count` STRING COMMENT 'Total number of documents included in the production set.',
    `hash` STRING COMMENT 'Cryptographic hash value for the entire production set, ensuring integrity and chain of custody.',
    `hash_algorithm` STRING COMMENT 'Cryptographic hash algorithm used to generate file integrity checksums for the production.',
    `load_file_format` STRING COMMENT 'Format of the load file accompanying the production set.',
    `metadata_fields_produced` STRING COMMENT 'Comma-separated list of metadata fields included in the production load file.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified the production set record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the production set record was last modified.',
    `native_files_included_flag` BOOLEAN COMMENT 'Indicates whether native file formats are included in the production.',
    `page_count` STRING COMMENT 'Total number of pages across all documents in the production set.',
    `privilege_log_required_flag` BOOLEAN COMMENT 'Indicates whether a privilege log must accompany this production set for withheld documents.',
    `producing_party_name` STRING COMMENT 'Name of the party or organization producing the documents.',
    `production_date` DATE COMMENT 'Date on which the production set was delivered or made available to the recipient.',
    `production_deadline_date` DATE COMMENT 'Court-ordered or agreed-upon deadline for delivering this production set.',
    `production_notes` STRING COMMENT 'Free-text notes regarding the production set, including special instructions, issues, or clarifications.',
    `production_protocol_version` STRING COMMENT 'Version identifier of the production protocol or agreement governing this production set.',
    `production_set_name` STRING COMMENT 'Descriptive name for the production set, typically reflecting the production phase, recipient, or content scope.',
    `production_set_number` STRING COMMENT 'Business identifier for the production set, typically assigned by the eDiscovery platform or case management system. Externally visible reference number.',
    `production_status` STRING COMMENT 'Current lifecycle status of the production set.',
    `production_type` STRING COMMENT 'Type of production format delivered to the requesting party.',
    `production_volume_number` STRING COMMENT 'Sequential volume number if the production is split across multiple deliveries.',
    `quality_control_completed_date` DATE COMMENT 'Date on which quality control review was completed.',
    `quality_control_reviewer_name` STRING COMMENT 'Name of the individual who performed the quality control review.',
    `quality_control_status` STRING COMMENT 'Status of quality control review for the production set.',
    `recipient_party_name` STRING COMMENT 'Name of the party or organization receiving the production set.',
    `redaction_applied_flag` BOOLEAN COMMENT 'Indicates whether redactions have been applied to documents in this production set.',
    `total_file_size_gb` DECIMAL(18,2) COMMENT 'Total file size of the production set in gigabytes.',
    `total_production_volumes` STRING COMMENT 'Total number of volumes planned for this production set.',
    CONSTRAINT pk_production_set PRIMARY KEY(`production_set_id`)
) COMMENT 'Master reference table for production_set. Referenced by production_set_id.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`document`.`family_group` (
    `family_group_id` BIGINT COMMENT 'Primary key for family_group',
    `esi_custodian_id` BIGINT COMMENT 'Reference to the primary custodian or document owner associated with this family group.',
    `legal_hold_id` BIGINT COMMENT 'Reference to the active legal hold order or preservation notice applicable to this family group.',
    `master_family_group_id` BIGINT COMMENT 'Reference to the master family group when this family group has been identified as a duplicate or near-duplicate.',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter or case to which this family group is associated.',
    `parent_family_group_id` BIGINT COMMENT 'Self-referencing FK on family_group (parent_family_group_id)',
    `legal_document_id` BIGINT COMMENT 'Reference to the primary or parent document within the family group, typically the root email or master document from which other family members derive.',
    `processing_batch_id` BIGINT COMMENT 'Identifier for the processing batch or ingestion run during which the family group was created or updated, supporting data lineage.',
    `production_set_id` BIGINT COMMENT 'Reference to the production set in which this family group was included for disclosure or production to opposing parties.',
    `attachment_count` STRING COMMENT 'Number of attachments within the family group, typically associated with email families.',
    `chain_of_custody_verified` BOOLEAN COMMENT 'Indicates whether the chain of custody for the family group has been verified and documented, ensuring forensic integrity.',
    `confidentiality_level` STRING COMMENT 'Classification level indicating the sensitivity and access restrictions for documents within the family group.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the family group record was first created in the system.',
    `deduplication_status` STRING COMMENT 'Indicates whether the family group has been identified as unique, duplicate, or near-duplicate during deduplication processing.',
    `discovery_status` STRING COMMENT 'Current status of the family group within the eDiscovery workflow, tracking review and production decisions.',
    `disposition_eligible_date` DATE COMMENT 'The calculated date on which the family group becomes eligible for disposition (archival or destruction) based on retention policy.',
    `earliest_document_date` DATE COMMENT 'The earliest creation or sent date among all documents within the family group, establishing the temporal origin of the family.',
    `family_group_code` STRING COMMENT 'Business-assigned unique code for the family group used for external reference and reporting.',
    `family_group_name` STRING COMMENT 'Human-readable name or label for the family group, used for identification and display purposes.',
    `family_group_type` STRING COMMENT 'Classification of the family group indicating the nature of the relationship between grouped documents (e.g., email thread, document family, attachment cluster, version set, related correspondence, discovery family).',
    `family_relationship_basis` STRING COMMENT 'The criterion or methodology used to establish the family grouping (e.g., attachment relationship, version lineage, email thread, custodian grouping, matter association, privilege log grouping, near-duplicate analysis, conceptual clustering).',
    `hash_algorithm` STRING COMMENT 'The cryptographic algorithm used to generate the hash value for the family group.',
    `hash_value` DECIMAL(18,2) COMMENT 'Cryptographic hash (MD5, SHA-1, or SHA-256) computed across the family group to ensure integrity and support deduplication.',
    `latest_document_date` DATE COMMENT 'The most recent creation or sent date among all documents within the family group, establishing the temporal endpoint of the family.',
    `legal_hold_status` STRING COMMENT 'Indicates whether the family group is currently subject to a legal hold, preventing disposition pending litigation or investigation.',
    `member_count` STRING COMMENT 'Total number of documents included in this family group.',
    `modified_by` STRING COMMENT 'Identifier of the user or system process that last modified the family group record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when the family group record was last modified.',
    `notes` STRING COMMENT 'Free-text field for capturing additional context, annotations, or special handling instructions related to the family group.',
    `privilege_designation` STRING COMMENT 'Legal privilege status assigned to the family group indicating whether documents are protected by attorney-client privilege, work product doctrine, or other legal protections.',
    `redaction_required` BOOLEAN COMMENT 'Indicates whether documents in the family group require redaction of privileged, confidential, or personally identifiable information prior to production.',
    `redaction_status` STRING COMMENT 'Current status of redaction processing for the family group.',
    `retention_category` STRING COMMENT 'Classification code indicating the records retention schedule applicable to this family group based on document type and regulatory requirements.',
    `retention_trigger_date` DATE COMMENT 'The date from which the retention period begins, typically the date of document creation, matter closure, or regulatory event.',
    `review_priority` STRING COMMENT 'Priority level assigned to the family group for review workflow sequencing, based on relevance scoring, custodian importance, or date range.',
    `source_system` STRING COMMENT 'The originating document management system or repository from which the family group was extracted (e.g., iManage Work, NetDocuments, Relativity, SharePoint).',
    `source_system_identifier` STRING COMMENT 'The native identifier or reference key for the family group in the source system, supporting traceability and reconciliation.',
    `family_group_status` STRING COMMENT 'Current lifecycle status of the family group record within the document management system.',
    `technology_assisted_review_score` DECIMAL(18,2) COMMENT 'Predictive coding or continuous active learning (CAL) relevance score assigned to the family group by machine learning algorithms, ranging from 0.0000 to 1.0000.',
    `version_count` STRING COMMENT 'Number of distinct versions of documents within the family group, tracking document evolution.',
    `created_by` STRING COMMENT 'Identifier of the user or system process that created the family group record.',
    CONSTRAINT pk_family_group PRIMARY KEY(`family_group_id`)
) COMMENT 'Master reference table for family_group. Referenced by family_group_id.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`document`.`review_batch` (
    `review_batch_id` BIGINT COMMENT 'Primary key for review_batch',
    `team_id` BIGINT COMMENT 'Reference to the review team responsible for this batch.',
    `employee_id` BIGINT COMMENT 'Reference to the legal professional or reviewer assigned to this batch.',
    `parent_review_batch_id` BIGINT COMMENT 'Self-referencing FK on review_batch (parent_review_batch_id)',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter this review batch is associated with.',
    `review_case_matter_id` BIGINT COMMENT 'Reference to the litigation case or investigation this review batch supports.',
    `user_id` BIGINT COMMENT 'Reference to the user who created this review batch.',
    `review_last_modified_by_user_id` BIGINT COMMENT 'Reference to the user who last modified this review batch record.',
    `review_protocol_id` BIGINT COMMENT 'Reference to the review protocol or guidelines governing how documents in this batch should be reviewed.',
    `tar_model_id` BIGINT COMMENT 'Reference to the TAR or predictive coding model used to prioritize or select documents for this batch.',
    `actual_completion_date` DATE COMMENT 'Actual date when review of this batch was completed.',
    `actual_hours` DECIMAL(18,2) COMMENT 'Actual number of hours spent reviewing this batch.',
    `assigned_date` DATE COMMENT 'Date when the batch was assigned to a reviewer or team.',
    `batch_name` STRING COMMENT 'Descriptive name for the review batch, often indicating the document set or review focus area.',
    `batch_number` STRING COMMENT 'Business-facing unique identifier for the review batch, typically used in communications and reporting.',
    `batch_type` STRING COMMENT 'Classification of the review batch indicating the review methodology or purpose (e.g., first pass review, quality control, Technology Assisted Review seed set, Continuous Active Learning training).',
    `cal_round_number` STRING COMMENT 'The CAL training round number this batch belongs to, if part of an iterative machine learning review workflow.',
    `completion_timestamp` TIMESTAMP COMMENT 'Precise date and time when the batch review was marked as complete.',
    `confidentiality_level` STRING COMMENT 'Data classification level assigned to this review batch based on the sensitivity of documents it contains.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the review batch was created in the system.',
    `custodian_list` STRING COMMENT 'Comma-separated list of custodians whose documents are included in this batch.',
    `date_range_end` DATE COMMENT 'Latest document date included in this review batch, defining the temporal scope.',
    `date_range_start` DATE COMMENT 'Earliest document date included in this review batch, defining the temporal scope.',
    `document_count` STRING COMMENT 'Total number of documents included in this review batch.',
    `estimated_hours` DECIMAL(18,2) COMMENT 'Estimated number of hours required to complete review of this batch.',
    `hot_document_count` STRING COMMENT 'Number of documents flagged as hot or key documents requiring special attention or escalation.',
    `is_billable` BOOLEAN COMMENT 'Indicates whether the review work on this batch is billable to the client.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the review batch record was last updated.',
    `notes` STRING COMMENT 'Free-text notes or comments about this review batch, including special instructions or observations.',
    `page_count` STRING COMMENT 'Total number of pages across all documents in this review batch.',
    `priority` STRING COMMENT 'Business priority assigned to this review batch, influencing resource allocation and scheduling.',
    `privileged_document_count` STRING COMMENT 'Number of documents designated as privileged (attorney-client privilege, work product, etc.) within this batch.',
    `quality_control_pass_count` STRING COMMENT 'Number of documents that passed quality control review without discrepancies.',
    `quality_control_sample_size` STRING COMMENT 'Number of documents selected for quality control review from this batch.',
    `responsive_document_count` STRING COMMENT 'Number of documents coded as responsive to the matter or case within this batch.',
    `review_platform` STRING COMMENT 'The eDiscovery or document review platform where this batch is hosted and reviewed.',
    `review_rate_documents_per_hour` DECIMAL(18,2) COMMENT 'Average number of documents reviewed per hour for this batch, used for productivity tracking.',
    `reviewed_document_count` STRING COMMENT 'Number of documents that have been reviewed within this batch.',
    `search_terms_applied` STRING COMMENT 'Search terms or queries used to identify and populate documents in this batch.',
    `start_date` DATE COMMENT 'Date when review work on this batch commenced.',
    `review_batch_status` STRING COMMENT 'Current lifecycle status of the review batch.',
    `target_completion_date` DATE COMMENT 'Planned or required date by which this batch review should be completed.',
    CONSTRAINT pk_review_batch PRIMARY KEY(`review_batch_id`)
) COMMENT 'Master reference table for review_batch. Referenced by review_batch_id.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`document`.`production_batch` (
    `production_batch_id` BIGINT COMMENT 'Primary key for production_batch',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter or case to which this production batch belongs.',
    `parent_production_batch_id` BIGINT COMMENT 'Self-referencing FK on production_batch (parent_production_batch_id)',
    `production_specification_id` BIGINT COMMENT 'Reference to the production specification or protocol document that defines the technical and legal requirements for this production batch.',
    `approval_date` DATE COMMENT 'Date on which this production batch received formal approval for delivery.',
    `approval_required` BOOLEAN COMMENT 'Indicates whether formal approval from counsel or client is required before this production batch can be delivered.',
    `approved_by` STRING COMMENT 'Name of the attorney or authorized individual who approved this production batch for delivery.',
    `batch_number` STRING COMMENT 'Business-facing unique identifier or reference number assigned to the production batch for external communication and tracking.',
    `bates_prefix` STRING COMMENT 'Alphanumeric prefix applied to Bates numbers in this production batch, typically identifying the producing party or matter.',
    `bates_range_end` STRING COMMENT 'The ending Bates number or document control number for this production batch, establishing the end of the sequential numbering range.',
    `bates_range_start` STRING COMMENT 'The starting Bates number or document control number for this production batch, establishing the beginning of the sequential numbering range.',
    `confidentiality_designation` STRING COMMENT 'Protective order designation applied to the production batch indicating the level of confidentiality and access restrictions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this production batch record was first created in the system.',
    `custodian_count` STRING COMMENT 'Number of distinct custodians whose documents are included in this production batch.',
    `date_range_end` DATE COMMENT 'Latest document date among all documents included in this production batch, defining the temporal scope of the production.',
    `date_range_start` DATE COMMENT 'Earliest document date among all documents included in this production batch, defining the temporal scope of the production.',
    `delivery_date` DATE COMMENT 'The date on which the production batch was delivered or transmitted to the requesting party or recipient.',
    `delivery_method` STRING COMMENT 'The mechanism or channel used to deliver the production batch to the recipient (secure FTP, USB drive, cloud link, email, API integration, or web portal).',
    `document_count` STRING COMMENT 'Total number of documents included in this production batch.',
    `encryption_applied` BOOLEAN COMMENT 'Indicates whether encryption was applied to the production batch files for secure transmission and storage.',
    `encryption_method` STRING COMMENT 'Cryptographic algorithm or method used to encrypt the production batch (e.g., AES-256, RSA, PGP).',
    `hash_algorithm` STRING COMMENT 'Cryptographic hash algorithm used to generate file integrity checksums for documents in this production batch.',
    `image_format` STRING COMMENT 'Image file format used for document renderings in this production batch (single-page TIFF, multi-page PDF, or other image formats).',
    `load_file_format` STRING COMMENT 'Format specification for the metadata load file accompanying this production batch (DAT, OPT, LFP, CSV, or platform-specific format).',
    `media_type` STRING COMMENT 'Physical or digital media type used to deliver the production batch.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this production batch record was last modified or updated.',
    `native_file_count` STRING COMMENT 'Number of documents produced in their native file format within this batch.',
    `page_count` STRING COMMENT 'Total number of pages across all documents in this production batch.',
    `privileged_document_count` STRING COMMENT 'Number of documents withheld from production due to attorney-client privilege, work product doctrine, or other legal privilege.',
    `producing_party` STRING COMMENT 'Name of the party or organization producing and delivering this batch of documents.',
    `production_date` DATE COMMENT 'The date on which the production batch was officially produced or finalized for delivery to the requesting party.',
    `production_notes` STRING COMMENT 'Free-text notes documenting special instructions, exceptions, issues, or other relevant information about this production batch.',
    `production_status` STRING COMMENT 'Current lifecycle status of the production batch indicating its stage in the production workflow.',
    `production_type` STRING COMMENT 'Classification of the production batch format and content type (native files, TIFF images, load file only, metadata extract, redacted set, or privilege log).',
    `quality_control_date` DATE COMMENT 'Date on which quality control validation was completed for this production batch.',
    `quality_control_notes` STRING COMMENT 'Free-text notes documenting quality control findings, issues identified, and remediation actions taken for this production batch.',
    `quality_control_performed` BOOLEAN COMMENT 'Indicates whether quality control validation was performed on this production batch prior to delivery.',
    `redacted_document_count` STRING COMMENT 'Number of documents in this batch that contain redactions for privilege, confidentiality, or privacy protection.',
    `requesting_party` STRING COMMENT 'Name of the party, organization, or entity that requested this production batch (opposing counsel, regulatory agency, or internal stakeholder).',
    `review_platform` STRING COMMENT 'Name of the eDiscovery or document review platform used to prepare and export this production batch (e.g., Relativity, Everlaw, Logikcull).',
    `text_extraction_method` STRING COMMENT 'Method used to extract searchable text from documents in this batch (native text extraction, OCR processing, hybrid approach, or no text extraction).',
    `total_size_bytes` BIGINT COMMENT 'Total storage size of all files in the production batch measured in bytes.',
    `tracking_number` STRING COMMENT 'Shipment or transmission tracking number for physical or electronic delivery of the production batch.',
    CONSTRAINT pk_production_batch PRIMARY KEY(`production_batch_id`)
) COMMENT 'Master reference table for production_batch. Referenced by production_batch_id.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`document`.`tar_model` (
    `tar_model_id` BIGINT COMMENT 'Primary key for tar_model',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter or case for which this TAR model was developed and is being applied.',
    `seed_tar_model_id` BIGINT COMMENT 'Self-referencing FK on tar_model (seed_tar_model_id)',
    `accuracy_score` DECIMAL(18,2) COMMENT 'Overall proportion of correct classifications (both relevant and non-relevant) made by the model, expressed as a decimal between 0 and 1.',
    `algorithm_type` STRING COMMENT 'The specific machine learning algorithm employed by the TAR model for document classification and relevance prediction.',
    `confidence_interval` DECIMAL(18,2) COMMENT 'Statistical confidence level for the models performance metrics, typically expressed as a percentage (e.g., 0.95 for 95% confidence).',
    `control_set_size` STRING COMMENT 'Number of documents in the control set used for ongoing validation and quality assurance of model performance.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the TAR model record was first created in the system.',
    `cutoff_threshold` DECIMAL(18,2) COMMENT 'The relevance score threshold above which documents are classified as relevant for review or production, expressed as a decimal between 0 and 1.',
    `defensibility_documentation_url` STRING COMMENT 'URL reference to the comprehensive defensibility documentation package supporting the TAR models methodology and results for potential court challenges.',
    `deployment_timestamp` TIMESTAMP COMMENT 'Date and time when the TAR model was deployed to production and made available for document classification.',
    `deprecation_timestamp` TIMESTAMP COMMENT 'Date and time when the TAR model was deprecated and removed from active use.',
    `documents_classified` BIGINT COMMENT 'Total number of documents that have been scored and classified by this TAR model during its operational use.',
    `documents_reviewed` BIGINT COMMENT 'Total number of documents that have undergone human review as part of the TAR workflow, including training and quality control.',
    `f1_score` DECIMAL(18,2) COMMENT 'Harmonic mean of precision and recall providing a single balanced measure of model performance, expressed as a decimal between 0 and 1.',
    `feature_engineering_approach` STRING COMMENT 'Description of the feature extraction and engineering methodology applied to prepare document data for model training.',
    `language_support` STRING COMMENT 'Comma-separated list of languages supported by the TAR model for multilingual document collections.',
    `last_modified_by` STRING COMMENT 'Name of the user who most recently modified the TAR model configuration or parameters.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the TAR model record was most recently updated or modified.',
    `last_training_timestamp` TIMESTAMP COMMENT 'Date and time when the most recent training round was completed for this TAR model.',
    `model_code` STRING COMMENT 'Unique business identifier code for the TAR model following the pattern TAR-XXXXXX for external reference and tracking.',
    `model_name` STRING COMMENT 'Human-readable name assigned to the TAR model for identification and reference purposes.',
    `model_type` STRING COMMENT 'Classification of the TAR methodology employed, distinguishing between TAR 1.0 (traditional predictive coding), TAR 2.0 (continuous active learning), and other machine learning approaches.',
    `model_version` STRING COMMENT 'Semantic version number of the TAR model following the pattern vX.Y.Z to track iterations and updates.',
    `notes` STRING COMMENT 'Free-text field for capturing additional context, observations, or special considerations related to the TAR models development and use.',
    `precision_score` DECIMAL(18,2) COMMENT 'Statistical measure of the proportion of documents classified as relevant by the model that are actually relevant, expressed as a decimal between 0 and 1.',
    `privilege_detection_enabled` BOOLEAN COMMENT 'Indicator of whether the TAR model includes specialized detection capabilities for attorney-client privilege and work product protection.',
    `recall_score` DECIMAL(18,2) COMMENT 'Statistical measure of the proportion of actually relevant documents that were correctly identified by the model, expressed as a decimal between 0 and 1.',
    `review_platform` STRING COMMENT 'The eDiscovery software platform in which the TAR model is deployed and executed for document review.',
    `richness_estimate` DECIMAL(18,2) COMMENT 'Estimated proportion of relevant documents within the entire document collection, used for sampling and review planning.',
    `seed_set_strategy` STRING COMMENT 'The methodology used to select the initial seed documents for model training, balancing representativeness and efficiency.',
    `stabilization_achieved` BOOLEAN COMMENT 'Indicator of whether the TAR model has reached a stable state where additional training produces minimal performance improvement.',
    `tar_model_status` STRING COMMENT 'Current lifecycle state of the TAR model indicating its operational readiness and usage authorization.',
    `training_rounds_completed` STRING COMMENT 'Number of iterative training cycles completed in the development and refinement of the TAR model.',
    `training_set_size` STRING COMMENT 'Total number of documents used in the training dataset to build and refine the TAR models classification capabilities.',
    `validated_by` STRING COMMENT 'Name of the senior attorney or eDiscovery expert who performed and certified the model validation.',
    `validation_date` DATE COMMENT 'Date on which the TAR model successfully completed validation testing and was certified for production use.',
    `validation_method` STRING COMMENT 'The statistical validation approach used to assess and verify the TAR models performance and reliability.',
    `created_by` STRING COMMENT 'Name of the eDiscovery specialist or data scientist who created and configured the TAR model.',
    CONSTRAINT pk_tar_model PRIMARY KEY(`tar_model_id`)
) COMMENT 'Master reference table for tar_model. Referenced by tar_model_id.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`document`.`review_project` (
    `review_project_id` BIGINT COMMENT 'Primary key for review_project',
    `matter_id` BIGINT COMMENT 'Reference to the parent legal matter or case to which this review project belongs.',
    `parent_review_project_id` BIGINT COMMENT 'Self-referencing FK on review_project (parent_review_project_id)',
    `actual_cost_amount` DECIMAL(18,2) COMMENT 'Cumulative actual costs incurred for the review project to date, including all labor and technology expenses.',
    `chain_of_custody_maintained` BOOLEAN COMMENT 'Indicates whether formal chain of custody documentation has been maintained for evidentiary integrity and admissibility.',
    `confidentiality_level` STRING COMMENT 'Classification of the sensitivity and access restrictions for the review project and its documents.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the review project record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this review project (e.g., USD, GBP, EUR).',
    `custodian_count` STRING COMMENT 'Number of data custodians (individuals whose documents are being reviewed) included in the project scope.',
    `data_source_count` STRING COMMENT 'Number of distinct data sources or repositories from which documents were collected for review (e.g., email servers, file shares, databases).',
    `deduplication_applied` BOOLEAN COMMENT 'Indicates whether deduplication processing was applied to remove exact duplicate documents from the review set.',
    `email_threading_applied` BOOLEAN COMMENT 'Indicates whether email threading analysis was applied to identify and group related email conversations.',
    `estimated_budget_amount` DECIMAL(18,2) COMMENT 'Projected total cost for completing the review project, including attorney time, technology costs, and vendor fees.',
    `jurisdiction` STRING COMMENT 'Primary legal jurisdiction or country code governing the review project and its legal obligations.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the review project record was last updated or modified.',
    `nlp_processing_applied` BOOLEAN COMMENT 'Indicates whether Natural Language Processing or advanced analytics were applied for concept extraction or sentiment analysis.',
    `ocr_processing_applied` BOOLEAN COMMENT 'Indicates whether Optical Character Recognition was applied to extract text from image-based documents.',
    `privilege_protocol_applied` BOOLEAN COMMENT 'Indicates whether a formal privilege review protocol or agreement has been applied to this project.',
    `privileged_document_count` BIGINT COMMENT 'Number of documents designated as privileged or protected under attorney-client privilege or work product doctrine.',
    `production_deadline_date` DATE COMMENT 'Court-ordered or agreed-upon deadline for producing responsive documents to opposing counsel or regulatory authority.',
    `production_format` STRING COMMENT 'Format in which responsive documents will be produced to requesting party (e.g., native files, TIFF images, PDF, or load files).',
    `project_description` STRING COMMENT 'Detailed narrative description of the review project scope, objectives, and special considerations.',
    `project_end_date` DATE COMMENT 'Date when the review project was completed or is scheduled to be completed. Nullable for ongoing projects.',
    `project_name` STRING COMMENT 'Human-readable name or title of the review project, typically reflecting the matter or case name.',
    `project_number` STRING COMMENT 'Externally-known unique business identifier for the review project, used for client communication and billing.',
    `project_start_date` DATE COMMENT 'Date when the review project officially commenced or was initiated.',
    `project_status` STRING COMMENT 'Current lifecycle status of the review project indicating its operational state.',
    `project_type` STRING COMMENT 'Classification of the review project based on its legal purpose and workflow requirements.',
    `quality_control_percentage` DECIMAL(18,2) COMMENT 'Percentage of reviewed documents subject to secondary quality control review, typically ranging from 5% to 100%.',
    `redaction_required` BOOLEAN COMMENT 'Indicates whether document redaction is required to protect privileged information or personally identifiable information (PII) before production.',
    `responsive_document_count` BIGINT COMMENT 'Number of documents identified as responsive to the discovery request or review criteria.',
    `review_methodology` STRING COMMENT 'Approach or technique used for document review, such as linear review, Technology Assisted Review (TAR), Continuous Active Learning (CAL), or hybrid methods.',
    `review_platform` STRING COMMENT 'Technology platform or system used to conduct the document review (e.g., Relativity, Nuix, Everlaw).',
    `reviewed_document_count` BIGINT COMMENT 'Number of documents that have been reviewed and coded by reviewers as of the current date.',
    `special_instructions` STRING COMMENT 'Additional instructions, protocols, or requirements specific to this review project that reviewers must follow.',
    `target_completion_date` DATE COMMENT 'Planned or contractual deadline for completing the review project, used for scheduling and resource planning.',
    `total_data_volume_gb` DECIMAL(18,2) COMMENT 'Total volume of electronically stored information (ESI) collected for the review project, measured in gigabytes.',
    `total_document_count` BIGINT COMMENT 'Total number of documents or electronically stored information (ESI) items included in the review project scope.',
    CONSTRAINT pk_review_project PRIMARY KEY(`review_project_id`)
) COMMENT 'Master reference table for review_project. Referenced by project_id.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`document`.`production_specification` (
    `production_specification_id` BIGINT COMMENT 'Primary key for production_specification',
    `user_id` BIGINT COMMENT 'Foreign key to workforce.user.user_id',
    `parent_production_specification_id` BIGINT COMMENT 'Self-referencing FK on production_specification (parent_production_specification_id)',
    `vendor_id` BIGINT COMMENT 'Reference to the eDiscovery vendor or service provider responsible for executing this production specification.',
    `approval_date` DATE COMMENT 'Date on which the production specification was formally approved by all parties or the court.',
    `approved_by` STRING COMMENT 'Name or identifier of the attorney, counsel, or court officer who approved this production specification.',
    `bates_numbering_required` BOOLEAN COMMENT 'Indicates whether Bates numbering (sequential document identification) is required for this production.',
    `bates_prefix` STRING COMMENT 'Prefix to be applied to Bates numbers for this production, typically identifying the producing party or matter.',
    `bates_starting_number` BIGINT COMMENT 'Starting sequential number for Bates numbering in this production specification.',
    `clawback_provision_applies` BOOLEAN COMMENT 'Indicates whether a clawback provision allowing retrieval of inadvertently produced privileged documents is in effect.',
    `confidentiality_designation` STRING COMMENT 'Default confidentiality designation to be applied to documents in this production per protective order terms.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this production specification record was first created in the system.',
    `custodian_scope` STRING COMMENT 'Comma-separated list of custodian names or identifiers whose documents are included in this production specification.',
    `date_range_end` DATE COMMENT 'End date of the temporal scope for documents included in this production specification.',
    `date_range_start` DATE COMMENT 'Start date of the temporal scope for documents included in this production specification.',
    `deduplication_scope` STRING COMMENT 'Scope of deduplication to be applied: global (across all custodians), per custodian, family-level (email threads), or none.',
    `delivery_method` STRING COMMENT 'Method by which the production will be delivered to the requesting party.',
    `encryption_required` BOOLEAN COMMENT 'Indicates whether encryption is required for production delivery to protect confidential information in transit.',
    `family_relationship_preserved` BOOLEAN COMMENT 'Indicates whether parent-child document relationships (e.g., email and attachments) must be preserved in the production.',
    `hash_validation_required` BOOLEAN COMMENT 'Indicates whether cryptographic hash values (MD5, SHA-256) must be provided for file integrity validation.',
    `load_file_format` STRING COMMENT 'Format of the load file to accompany the production, specifying how metadata and document references are structured.',
    `metadata_fields_included` STRING COMMENT 'Comma-separated list of metadata fields to be included in the production load file (e.g., author, created date, modified date, custodian).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this production specification record was last modified.',
    `notes` STRING COMMENT 'Free-text notes capturing additional instructions, special handling requirements, or context for this production specification.',
    `privilege_log_required` BOOLEAN COMMENT 'Indicates whether a privilege log documenting withheld privileged documents must be produced.',
    `producing_party` STRING COMMENT 'Name of the party or organization producing documents under this specification.',
    `production_cost_estimate` DECIMAL(18,2) COMMENT 'Estimated total cost in USD for completing the document production under this specification, including review, processing, and delivery.',
    `production_deadline` DATE COMMENT 'Court-ordered or agreed-upon deadline by which the production must be completed and delivered.',
    `production_format` STRING COMMENT 'Detailed format specification for document production delivery, including image type and text extraction requirements.',
    `production_type` STRING COMMENT 'Type of document production format specified: native files, TIFF images, PDF, load file only, paper, or hybrid combination.',
    `production_volume_estimate` BIGINT COMMENT 'Estimated number of document pages or files to be produced under this specification.',
    `quality_control_sampling_rate` DECIMAL(18,2) COMMENT 'Percentage of documents subject to quality control review to ensure production accuracy and completeness.',
    `redaction_required` BOOLEAN COMMENT 'Indicates whether document redaction for privileged or confidential information is required for this production.',
    `requesting_party` STRING COMMENT 'Name of the party or organization requesting the document production.',
    `rolling_production_allowed` BOOLEAN COMMENT 'Indicates whether documents may be produced in multiple batches over time (rolling production) rather than a single delivery.',
    `search_terms_applied` STRING COMMENT 'Search terms or queries applied to identify responsive documents for this production.',
    `specification_name` STRING COMMENT 'Human-readable name or title of the production specification, typically describing the matter or production scope.',
    `specification_number` STRING COMMENT 'Business-facing unique identifier for the production specification, used in legal discovery and document production workflows.',
    `specification_status` STRING COMMENT 'Current lifecycle status of the production specification.',
    `tar_protocol_used` STRING COMMENT 'Technology-Assisted Review protocol applied for document review and responsiveness determination (CAL, SPL, or none).',
    `text_extraction_method` STRING COMMENT 'Method used to extract searchable text from documents for this production (OCR, native extraction, embedded text, or manual transcription).',
    CONSTRAINT pk_production_specification PRIMARY KEY(`production_specification_id`)
) COMMENT 'Master reference table for production_specification. Referenced by production_specification_id.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`document`.`processing_batch` (
    `processing_batch_id` BIGINT COMMENT 'Primary key for processing_batch',
    `esi_custodian_id` BIGINT COMMENT 'BIGINT',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter or case to which this processing batch is associated.',
    `parent_processing_batch_id` BIGINT COMMENT 'Self-referencing FK on processing_batch (parent_processing_batch_id)',
    `user_id` BIGINT COMMENT 'BIGINT',
    `processing_esi_custodian_id` BIGINT COMMENT 'BIGINT',
    `processing_modified_by_user_id` BIGINT COMMENT 'BIGINT',
    `processing_retention_schedule_id` BIGINT COMMENT 'BIGINT',
    `retention_schedule_id` BIGINT COMMENT 'BIGINT',
    `tar_model_id` BIGINT COMMENT 'BIGINT',
    `actual_start_timestamp` TIMESTAMP COMMENT 'The date and time when processing for this batch actually commenced.',
    `batch_name` STRING COMMENT 'Descriptive name assigned to the processing batch for identification and reference purposes.',
    `batch_number` STRING COMMENT 'Human-readable business identifier for the processing batch, typically assigned by the document management system or eDiscovery platform.',
    `batch_status` STRING COMMENT 'Current lifecycle status of the processing batch indicating its state in the workflow.',
    `batch_type` STRING COMMENT 'Classification of the processing batch indicating the type of document processing workflow being executed.',
    `chain_of_custody_verified` BOOLEAN COMMENT 'Indicates whether the chain of custody for documents in this batch has been verified and documented.',
    `completion_timestamp` TIMESTAMP COMMENT 'The date and time when processing for this batch was completed.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this processing batch record was first created in the system.',
    `deduplication_enabled` BOOLEAN COMMENT 'Indicates whether deduplication logic was applied to identify and remove duplicate documents in this batch.',
    `document_count` STRING COMMENT 'Total number of documents included in this processing batch.',
    `error_message` STRING COMMENT 'Detailed error message or exception information if the batch processing failed or encountered issues.',
    `extraction_method` STRING COMMENT 'The method used to extract content from documents in this batch.',
    `failed_document_count` STRING COMMENT 'Number of documents that failed processing within this batch due to errors or exceptions.',
    `hash_algorithm` STRING COMMENT 'The cryptographic hash algorithm used to generate document fingerprints for integrity verification.',
    `language_detection_enabled` BOOLEAN COMMENT 'Indicates whether automatic language detection was performed on documents in this batch.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this processing batch record was last modified.',
    `nlp_enabled` BOOLEAN COMMENT 'Indicates whether natural language processing was applied to documents in this batch for entity extraction or classification.',
    `ocr_enabled` BOOLEAN COMMENT 'Indicates whether optical character recognition was applied to documents in this batch.',
    `primary_language` STRING COMMENT 'The predominant language of documents in this batch, represented as ISO 639-1 two-letter code.',
    `privilege_detection_enabled` BOOLEAN COMMENT 'Indicates whether automated privilege detection was applied to identify potentially privileged documents.',
    `processed_document_count` STRING COMMENT 'Number of documents that have been successfully processed within this batch.',
    `processing_duration_seconds` STRING COMMENT 'Total elapsed time in seconds from start to completion of batch processing.',
    `processing_engine` STRING COMMENT 'The software engine or tool used to execute the processing workflow for this batch.',
    `processing_notes` STRING COMMENT 'Free-text notes or comments regarding the processing batch, including special handling instructions or observations.',
    `processing_priority` STRING COMMENT 'Priority level assigned to this batch determining its position in the processing queue.',
    `processing_profile` STRING COMMENT 'The configuration profile or template applied to this batch defining processing parameters and rules.',
    `retry_count` STRING COMMENT 'Number of times this batch has been retried after initial processing failure.',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'The date and time when processing for this batch is scheduled to begin.',
    `source_system` STRING COMMENT 'The originating document management system or eDiscovery platform from which documents in this batch were sourced.',
    `total_file_size_bytes` BIGINT COMMENT 'Aggregate file size of all documents in the batch measured in bytes.',
    CONSTRAINT pk_processing_batch PRIMARY KEY(`processing_batch_id`)
) COMMENT 'Master reference table for processing_batch. Referenced by processing_batch_id.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`document`.`review_protocol` (
    `review_protocol_id` BIGINT COMMENT 'Primary key for review_protocol',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter or case to which this review protocol is associated.',
    `primary_superseded_review_protocol_id` BIGINT COMMENT 'Self-referencing FK on review_protocol (superseded_review_protocol_id)',
    `profile_id` BIGINT COMMENT 'Foreign key to client.profile.profile_id',
    `attorney_profile_id` BIGINT COMMENT 'Foreign key to workforce.attorney_profile.attorney_profile_id',
    `approval_date` DATE COMMENT 'Date when the review protocol was formally approved for execution.',
    `approval_status` STRING COMMENT 'Current approval status of the review protocol by responsible counsel or client stakeholders.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual who approved the review protocol.',
    `confidence_level_percent` DECIMAL(18,2) COMMENT 'Statistical confidence level target for the review protocol, expressed as a percentage (e.g., 95.00 for 95% confidence).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the review protocol record was first created in the system.',
    `custodian_scope` STRING COMMENT 'Description of the custodians (data owners or key personnel) whose documents are subject to this review protocol.',
    `date_range_end` DATE COMMENT 'End date of the temporal scope for documents covered by this review protocol.',
    `date_range_start` DATE COMMENT 'Start date of the temporal scope for documents covered by this review protocol.',
    `deduplication_method` STRING COMMENT 'Method used to identify and handle duplicate documents within the review protocol (hash-based, near-duplicate detection, email threading).',
    `review_protocol_description` STRING COMMENT 'Detailed narrative describing the purpose, scope, and methodology of the review protocol.',
    `effective_date` DATE COMMENT 'Date when the review protocol becomes active and binding for document review workflows.',
    `escalation_threshold_percent` DECIMAL(18,2) COMMENT 'Percentage threshold of disagreement or uncertainty that triggers escalation to senior reviewers or subject matter experts.',
    `expiration_date` DATE COMMENT 'Date when the review protocol ceases to be active. Nullable for protocols without a defined end date.',
    `margin_of_error_percent` DECIMAL(18,2) COMMENT 'Acceptable margin of error for the review protocol, expressed as a percentage (e.g., 2.50 for ±2.5%).',
    `modified_by` STRING COMMENT 'Identifier or name of the user who last modified the review protocol record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the review protocol record was last modified.',
    `nlp_processing_required` BOOLEAN COMMENT 'Indicates whether the protocol requires NLP techniques such as entity extraction, sentiment analysis, or topic modeling.',
    `notes` STRING COMMENT 'Additional free-text notes or comments regarding the review protocol, including special instructions or considerations.',
    `ocr_processing_required` BOOLEAN COMMENT 'Indicates whether the protocol requires OCR processing for image-based documents to enable text searchability.',
    `privilege_designation_required` BOOLEAN COMMENT 'Indicates whether the review protocol mandates explicit privilege designation (attorney-client privilege, work product) for documents.',
    `protocol_code` STRING COMMENT 'Externally-known unique alphanumeric code assigned to the review protocol for reference in legal systems and workflows.',
    `protocol_name` STRING COMMENT 'Human-readable name or title of the review protocol used to identify it in business operations.',
    `protocol_type` STRING COMMENT 'Classification of the review protocol methodology. TAR = Technology Assisted Review, CAL = Continuous Active Learning.',
    `quality_control_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of reviewed documents subject to secondary quality control review to ensure consistency and accuracy.',
    `redaction_required` BOOLEAN COMMENT 'Indicates whether the review protocol requires redaction of sensitive or privileged information prior to production.',
    `retention_period_years` STRING COMMENT 'Number of years the review protocol and associated metadata must be retained per legal or regulatory requirements.',
    `review_objective` STRING COMMENT 'Primary business or legal objective the review protocol is designed to achieve, such as privilege identification, responsiveness determination, or issue coding.',
    `review_platform` STRING COMMENT 'Name of the eDiscovery or document review platform where the protocol is executed (e.g., Relativity, Everlaw, Logikcull).',
    `review_rounds_planned` STRING COMMENT 'Number of iterative review rounds planned in the protocol, particularly relevant for TAR and CAL workflows.',
    `richness_assumption_percent` DECIMAL(18,2) COMMENT 'Estimated prevalence of responsive or relevant documents in the collection, expressed as a percentage, used for sample size calculation.',
    `sample_size` STRING COMMENT 'Number of documents included in the sample set for training, validation, or quality control purposes.',
    `sampling_method` STRING COMMENT 'Statistical or judgmental sampling approach used within the review protocol for quality control or training set selection.',
    `review_protocol_status` STRING COMMENT 'Current lifecycle status of the review protocol indicating its operational state.',
    `version_number` STRING COMMENT 'Version identifier for the review protocol, following semantic versioning (e.g., 1.0, 2.1).',
    `created_by` STRING COMMENT 'Identifier or name of the user who created the review protocol record.',
    CONSTRAINT pk_review_protocol PRIMARY KEY(`review_protocol_id`)
) COMMENT 'Master reference table for review_protocol. Referenced by review_protocol_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_doc_template_id` FOREIGN KEY (`doc_template_id`) REFERENCES `legal_ecm_v1`.`document`.`doc_template`(`doc_template_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_retention_schedule_id` FOREIGN KEY (`retention_schedule_id`) REFERENCES `legal_ecm_v1`.`document`.`retention_schedule`(`retention_schedule_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_doc_folder_id` FOREIGN KEY (`doc_folder_id`) REFERENCES `legal_ecm_v1`.`document`.`doc_folder`(`doc_folder_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_doc_type_id` FOREIGN KEY (`doc_type_id`) REFERENCES `legal_ecm_v1`.`document`.`doc_type`(`doc_type_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_legal_retention_schedule_id` FOREIGN KEY (`legal_retention_schedule_id`) REFERENCES `legal_ecm_v1`.`document`.`retention_schedule`(`retention_schedule_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_primary_doc_folder_id` FOREIGN KEY (`primary_doc_folder_id`) REFERENCES `legal_ecm_v1`.`document`.`doc_folder`(`doc_folder_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_primary_doc_type_id` FOREIGN KEY (`primary_doc_type_id`) REFERENCES `legal_ecm_v1`.`document`.`doc_type`(`doc_type_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_to_doc_folder_id` FOREIGN KEY (`to_doc_folder_id`) REFERENCES `legal_ecm_v1`.`document`.`doc_folder`(`doc_folder_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_to_doc_type_id` FOREIGN KEY (`to_doc_type_id`) REFERENCES `legal_ecm_v1`.`document`.`doc_type`(`doc_type_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_version` ADD CONSTRAINT `fk_document_doc_version_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ADD CONSTRAINT `fk_document_doc_type_doc_template_id` FOREIGN KEY (`doc_template_id`) REFERENCES `legal_ecm_v1`.`document`.`doc_template`(`doc_template_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ADD CONSTRAINT `fk_document_doc_folder_parent_doc_folder_id` FOREIGN KEY (`parent_doc_folder_id`) REFERENCES `legal_ecm_v1`.`document`.`doc_folder`(`doc_folder_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ADD CONSTRAINT `fk_document_doc_folder_workspace_id` FOREIGN KEY (`workspace_id`) REFERENCES `legal_ecm_v1`.`document`.`workspace`(`workspace_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ADD CONSTRAINT `fk_document_doc_review_assignment_doc_version_id` FOREIGN KEY (`doc_version_id`) REFERENCES `legal_ecm_v1`.`document`.`doc_version`(`doc_version_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ADD CONSTRAINT `fk_document_doc_review_assignment_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ADD CONSTRAINT `fk_document_doc_review_assignment_production_batch_id` FOREIGN KEY (`production_batch_id`) REFERENCES `legal_ecm_v1`.`document`.`production_batch`(`production_batch_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ADD CONSTRAINT `fk_document_doc_review_assignment_review_batch_id` FOREIGN KEY (`review_batch_id`) REFERENCES `legal_ecm_v1`.`document`.`review_batch`(`review_batch_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ADD CONSTRAINT `fk_document_doc_review_assignment_target_legal_document_id` FOREIGN KEY (`target_legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ADD CONSTRAINT `fk_document_privilege_log_doc_version_id` FOREIGN KEY (`doc_version_id`) REFERENCES `legal_ecm_v1`.`document`.`doc_version`(`doc_version_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ADD CONSTRAINT `fk_document_privilege_log_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ADD CONSTRAINT `fk_document_privilege_log_privilege_produced_legal_document_id` FOREIGN KEY (`privilege_produced_legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ADD CONSTRAINT `fk_document_esi_collection_esi_custodian_id` FOREIGN KEY (`esi_custodian_id`) REFERENCES `legal_ecm_v1`.`document`.`esi_custodian`(`esi_custodian_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ADD CONSTRAINT `fk_document_esi_collection_legal_hold_id` FOREIGN KEY (`legal_hold_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_hold`(`legal_hold_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ADD CONSTRAINT `fk_document_esi_collection_primary_esi_custodian_id` FOREIGN KEY (`primary_esi_custodian_id`) REFERENCES `legal_ecm_v1`.`document`.`esi_custodian`(`esi_custodian_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ADD CONSTRAINT `fk_document_esi_collection_source_esi_custodian_id` FOREIGN KEY (`source_esi_custodian_id`) REFERENCES `legal_ecm_v1`.`document`.`esi_custodian`(`esi_custodian_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_doc_template_id` FOREIGN KEY (`doc_template_id`) REFERENCES `legal_ecm_v1`.`document`.`doc_template`(`doc_template_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_esi_custodian_id` FOREIGN KEY (`esi_custodian_id`) REFERENCES `legal_ecm_v1`.`document`.`esi_custodian`(`esi_custodian_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_primary_esi_custodian_id` FOREIGN KEY (`primary_esi_custodian_id`) REFERENCES `legal_ecm_v1`.`document`.`esi_custodian`(`esi_custodian_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ADD CONSTRAINT `fk_document_doc_production_esi_collection_id` FOREIGN KEY (`esi_collection_id`) REFERENCES `legal_ecm_v1`.`document`.`esi_collection`(`esi_collection_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ADD CONSTRAINT `fk_document_doc_production_production_set_id` FOREIGN KEY (`production_set_id`) REFERENCES `legal_ecm_v1`.`document`.`production_set`(`production_set_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ADD CONSTRAINT `fk_document_doc_production_source_esi_collection_id` FOREIGN KEY (`source_esi_collection_id`) REFERENCES `legal_ecm_v1`.`document`.`esi_collection`(`esi_collection_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_annotation` ADD CONSTRAINT `fk_document_doc_annotation_doc_version_id` FOREIGN KEY (`doc_version_id`) REFERENCES `legal_ecm_v1`.`document`.`doc_version`(`doc_version_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_annotation` ADD CONSTRAINT `fk_document_doc_annotation_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`retention_schedule` ADD CONSTRAINT `fk_document_retention_schedule_doc_type_id` FOREIGN KEY (`doc_type_id`) REFERENCES `legal_ecm_v1`.`document`.`doc_type`(`doc_type_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`retention_schedule` ADD CONSTRAINT `fk_document_retention_schedule_superseding_retention_schedule_id` FOREIGN KEY (`superseding_retention_schedule_id`) REFERENCES `legal_ecm_v1`.`document`.`retention_schedule`(`retention_schedule_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ADD CONSTRAINT `fk_document_doc_access_event_doc_version_id` FOREIGN KEY (`doc_version_id`) REFERENCES `legal_ecm_v1`.`document`.`doc_version`(`doc_version_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ADD CONSTRAINT `fk_document_doc_access_event_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ADD CONSTRAINT `fk_document_doc_access_event_review_session_id` FOREIGN KEY (`review_session_id`) REFERENCES `legal_ecm_v1`.`document`.`review_session`(`review_session_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ADD CONSTRAINT `fk_document_doc_access_event_review_set_id` FOREIGN KEY (`review_set_id`) REFERENCES `legal_ecm_v1`.`document`.`review_set`(`review_set_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ADD CONSTRAINT `fk_document_doc_execution_doc_version_id` FOREIGN KEY (`doc_version_id`) REFERENCES `legal_ecm_v1`.`document`.`doc_version`(`doc_version_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ADD CONSTRAINT `fk_document_doc_execution_execution_workflow_id` FOREIGN KEY (`execution_workflow_id`) REFERENCES `legal_ecm_v1`.`document`.`execution_workflow`(`execution_workflow_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ADD CONSTRAINT `fk_document_doc_execution_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ADD CONSTRAINT `fk_document_doc_relationship_doc_production_id` FOREIGN KEY (`doc_production_id`) REFERENCES `legal_ecm_v1`.`document`.`doc_production`(`doc_production_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ADD CONSTRAINT `fk_document_doc_relationship_family_group_id` FOREIGN KEY (`family_group_id`) REFERENCES `legal_ecm_v1`.`document`.`family_group`(`family_group_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ADD CONSTRAINT `fk_document_doc_relationship_parent_doc_relationship_id` FOREIGN KEY (`parent_doc_relationship_id`) REFERENCES `legal_ecm_v1`.`document`.`doc_relationship`(`doc_relationship_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ADD CONSTRAINT `fk_document_doc_relationship_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ADD CONSTRAINT `fk_document_doc_relationship_target_legal_document_id` FOREIGN KEY (`target_legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`custodian_hold` ADD CONSTRAINT `fk_document_custodian_hold_esi_custodian_id` FOREIGN KEY (`esi_custodian_id`) REFERENCES `legal_ecm_v1`.`document`.`esi_custodian`(`esi_custodian_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`custodian_hold` ADD CONSTRAINT `fk_document_custodian_hold_legal_hold_id` FOREIGN KEY (`legal_hold_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_hold`(`legal_hold_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`production_source` ADD CONSTRAINT `fk_document_production_source_doc_production_id` FOREIGN KEY (`doc_production_id`) REFERENCES `legal_ecm_v1`.`document`.`doc_production`(`doc_production_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`production_source` ADD CONSTRAINT `fk_document_production_source_esi_collection_id` FOREIGN KEY (`esi_collection_id`) REFERENCES `legal_ecm_v1`.`document`.`esi_collection`(`esi_collection_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`template_clause_usage` ADD CONSTRAINT `fk_document_template_clause_usage_doc_template_id` FOREIGN KEY (`doc_template_id`) REFERENCES `legal_ecm_v1`.`document`.`doc_template`(`doc_template_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ADD CONSTRAINT `fk_document_review_set_legal_hold_id` FOREIGN KEY (`legal_hold_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_hold`(`legal_hold_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ADD CONSTRAINT `fk_document_review_set_parent_review_set_id` FOREIGN KEY (`parent_review_set_id`) REFERENCES `legal_ecm_v1`.`document`.`review_set`(`review_set_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ADD CONSTRAINT `fk_document_review_set_production_set_id` FOREIGN KEY (`production_set_id`) REFERENCES `legal_ecm_v1`.`document`.`production_set`(`production_set_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ADD CONSTRAINT `fk_document_review_set_tar_model_id` FOREIGN KEY (`tar_model_id`) REFERENCES `legal_ecm_v1`.`document`.`tar_model`(`tar_model_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ADD CONSTRAINT `fk_document_review_session_prior_review_session_id` FOREIGN KEY (`prior_review_session_id`) REFERENCES `legal_ecm_v1`.`document`.`review_session`(`review_session_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ADD CONSTRAINT `fk_document_review_session_review_project_id` FOREIGN KEY (`review_project_id`) REFERENCES `legal_ecm_v1`.`document`.`review_project`(`review_project_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ADD CONSTRAINT `fk_document_review_session_review_set_id` FOREIGN KEY (`review_set_id`) REFERENCES `legal_ecm_v1`.`document`.`review_set`(`review_set_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ADD CONSTRAINT `fk_document_review_session_workspace_id` FOREIGN KEY (`workspace_id`) REFERENCES `legal_ecm_v1`.`document`.`workspace`(`workspace_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ADD CONSTRAINT `fk_document_execution_workflow_doc_template_id` FOREIGN KEY (`doc_template_id`) REFERENCES `legal_ecm_v1`.`document`.`doc_template`(`doc_template_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ADD CONSTRAINT `fk_document_execution_workflow_doc_type_id` FOREIGN KEY (`doc_type_id`) REFERENCES `legal_ecm_v1`.`document`.`doc_type`(`doc_type_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ADD CONSTRAINT `fk_document_execution_workflow_primary_superseding_execution_workflow_id` FOREIGN KEY (`primary_superseding_execution_workflow_id`) REFERENCES `legal_ecm_v1`.`document`.`execution_workflow`(`execution_workflow_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ADD CONSTRAINT `fk_document_workspace_parent_workspace_id` FOREIGN KEY (`parent_workspace_id`) REFERENCES `legal_ecm_v1`.`document`.`workspace`(`workspace_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ADD CONSTRAINT `fk_document_workspace_retention_schedule_id` FOREIGN KEY (`retention_schedule_id`) REFERENCES `legal_ecm_v1`.`document`.`retention_schedule`(`retention_schedule_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` ADD CONSTRAINT `fk_document_production_set_parent_production_set_id` FOREIGN KEY (`parent_production_set_id`) REFERENCES `legal_ecm_v1`.`document`.`production_set`(`production_set_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`family_group` ADD CONSTRAINT `fk_document_family_group_esi_custodian_id` FOREIGN KEY (`esi_custodian_id`) REFERENCES `legal_ecm_v1`.`document`.`esi_custodian`(`esi_custodian_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`family_group` ADD CONSTRAINT `fk_document_family_group_legal_hold_id` FOREIGN KEY (`legal_hold_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_hold`(`legal_hold_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`family_group` ADD CONSTRAINT `fk_document_family_group_master_family_group_id` FOREIGN KEY (`master_family_group_id`) REFERENCES `legal_ecm_v1`.`document`.`family_group`(`family_group_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`family_group` ADD CONSTRAINT `fk_document_family_group_parent_family_group_id` FOREIGN KEY (`parent_family_group_id`) REFERENCES `legal_ecm_v1`.`document`.`family_group`(`family_group_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`family_group` ADD CONSTRAINT `fk_document_family_group_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`family_group` ADD CONSTRAINT `fk_document_family_group_processing_batch_id` FOREIGN KEY (`processing_batch_id`) REFERENCES `legal_ecm_v1`.`document`.`processing_batch`(`processing_batch_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`family_group` ADD CONSTRAINT `fk_document_family_group_production_set_id` FOREIGN KEY (`production_set_id`) REFERENCES `legal_ecm_v1`.`document`.`production_set`(`production_set_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ADD CONSTRAINT `fk_document_review_batch_parent_review_batch_id` FOREIGN KEY (`parent_review_batch_id`) REFERENCES `legal_ecm_v1`.`document`.`review_batch`(`review_batch_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ADD CONSTRAINT `fk_document_review_batch_review_protocol_id` FOREIGN KEY (`review_protocol_id`) REFERENCES `legal_ecm_v1`.`document`.`review_protocol`(`review_protocol_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ADD CONSTRAINT `fk_document_review_batch_tar_model_id` FOREIGN KEY (`tar_model_id`) REFERENCES `legal_ecm_v1`.`document`.`tar_model`(`tar_model_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`production_batch` ADD CONSTRAINT `fk_document_production_batch_parent_production_batch_id` FOREIGN KEY (`parent_production_batch_id`) REFERENCES `legal_ecm_v1`.`document`.`production_batch`(`production_batch_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`production_batch` ADD CONSTRAINT `fk_document_production_batch_production_specification_id` FOREIGN KEY (`production_specification_id`) REFERENCES `legal_ecm_v1`.`document`.`production_specification`(`production_specification_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`tar_model` ADD CONSTRAINT `fk_document_tar_model_seed_tar_model_id` FOREIGN KEY (`seed_tar_model_id`) REFERENCES `legal_ecm_v1`.`document`.`tar_model`(`tar_model_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`review_project` ADD CONSTRAINT `fk_document_review_project_parent_review_project_id` FOREIGN KEY (`parent_review_project_id`) REFERENCES `legal_ecm_v1`.`document`.`review_project`(`review_project_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`production_specification` ADD CONSTRAINT `fk_document_production_specification_parent_production_specification_id` FOREIGN KEY (`parent_production_specification_id`) REFERENCES `legal_ecm_v1`.`document`.`production_specification`(`production_specification_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` ADD CONSTRAINT `fk_document_processing_batch_esi_custodian_id` FOREIGN KEY (`esi_custodian_id`) REFERENCES `legal_ecm_v1`.`document`.`esi_custodian`(`esi_custodian_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` ADD CONSTRAINT `fk_document_processing_batch_parent_processing_batch_id` FOREIGN KEY (`parent_processing_batch_id`) REFERENCES `legal_ecm_v1`.`document`.`processing_batch`(`processing_batch_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` ADD CONSTRAINT `fk_document_processing_batch_processing_esi_custodian_id` FOREIGN KEY (`processing_esi_custodian_id`) REFERENCES `legal_ecm_v1`.`document`.`esi_custodian`(`esi_custodian_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` ADD CONSTRAINT `fk_document_processing_batch_processing_retention_schedule_id` FOREIGN KEY (`processing_retention_schedule_id`) REFERENCES `legal_ecm_v1`.`document`.`retention_schedule`(`retention_schedule_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` ADD CONSTRAINT `fk_document_processing_batch_retention_schedule_id` FOREIGN KEY (`retention_schedule_id`) REFERENCES `legal_ecm_v1`.`document`.`retention_schedule`(`retention_schedule_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` ADD CONSTRAINT `fk_document_processing_batch_tar_model_id` FOREIGN KEY (`tar_model_id`) REFERENCES `legal_ecm_v1`.`document`.`tar_model`(`tar_model_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`review_protocol` ADD CONSTRAINT `fk_document_review_protocol_primary_superseded_review_protocol_id` FOREIGN KEY (`primary_superseded_review_protocol_id`) REFERENCES `legal_ecm_v1`.`document`.`review_protocol`(`review_protocol_id`);

-- ========= TAGS =========
ALTER SCHEMA `legal_ecm_v1`.`document` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `legal_ecm_v1`.`document` SET TAGS ('dbx_domain' = 'document');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Document ID');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `doc_template_id` SET TAGS ('dbx_business_glossary_term' = 'Doc Template Id');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `docket_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `retention_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Schedule Id');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `ip_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Asset Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `doc_folder_id` SET TAGS ('dbx_business_glossary_term' = 'Doc Folder Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `doc_type_id` SET TAGS ('dbx_business_glossary_term' = 'Doc Type Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `legal_retention_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Schedule Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `primary_doc_folder_id` SET TAGS ('dbx_business_glossary_term' = 'Doc Folder Id');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `primary_doc_type_id` SET TAGS ('dbx_business_glossary_term' = 'Doc Type Id');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Author ID');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `form_template_id` SET TAGS ('dbx_business_glossary_term' = 'Source Form Template Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `to_doc_folder_id` SET TAGS ('dbx_business_glossary_term' = 'To Doc Folder Id');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `to_doc_type_id` SET TAGS ('dbx_business_glossary_term' = 'To Doc Type Id');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `trade_secret_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Secret Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `tribunal_id` SET TAGS ('dbx_business_glossary_term' = 'Tribunal Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `tribunal_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|highly_confidential|restricted');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `contains_pii` SET TAGS ('dbx_business_glossary_term' = 'Contains Personally Identifiable Information (PII) Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Document Created Date');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Document Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `dms_document_reference` SET TAGS ('dbx_business_glossary_term' = 'DMS Document ID');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `dms_system` SET TAGS ('dbx_business_glossary_term' = 'Document Management System (DMS)');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `dms_system` SET TAGS ('dbx_value_regex' = 'imanage_work|netdocuments|relativity|sharepoint|other');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `document_category` SET TAGS ('dbx_business_glossary_term' = 'Document Category');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `executed_date` SET TAGS ('dbx_business_glossary_term' = 'Document Executed Date');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Document Expiration Date');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `file_extension` SET TAGS ('dbx_business_glossary_term' = 'File Extension');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `file_name` SET TAGS ('dbx_business_glossary_term' = 'File Name');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size in Bytes');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `hash_value` SET TAGS ('dbx_business_glossary_term' = 'Document Hash Value');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `is_current_version` SET TAGS ('dbx_business_glossary_term' = 'Is Current Version Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Document Keywords');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `legal_document_description` SET TAGS ('dbx_business_glossary_term' = 'Document Description');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `mime_type` SET TAGS ('dbx_business_glossary_term' = 'MIME Type');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `modified_date` SET TAGS ('dbx_business_glossary_term' = 'Document Modified Date');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Document Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `nlp_processed` SET TAGS ('dbx_business_glossary_term' = 'Natural Language Processing (NLP) Processed Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `ocr_processed` SET TAGS ('dbx_business_glossary_term' = 'Optical Character Recognition (OCR) Processed Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Page Count');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `privilege_status` SET TAGS ('dbx_business_glossary_term' = 'Legal Professional Privilege (LPP) Status');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `privilege_status` SET TAGS ('dbx_value_regex' = 'privileged|non_privileged|work_product|attorney_client|pending_review');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `retention_end_date` SET TAGS ('dbx_business_glossary_term' = 'Retention End Date');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'eDiscovery Review Status');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `source_precedent_id` SET TAGS ('dbx_business_glossary_term' = 'Source Precedent Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Document Title');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ALTER COLUMN `workspace_code` SET TAGS ('dbx_business_glossary_term' = 'Workspace ID');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_version` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_version` ALTER COLUMN `doc_version_id` SET TAGS ('dbx_business_glossary_term' = 'Document Version Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_version` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_version` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Document Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_version` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Author Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_version` ALTER COLUMN `reviewer_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_version` ALTER COLUMN `bates_number` SET TAGS ('dbx_business_glossary_term' = 'Bates Number');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_version` ALTER COLUMN `change_summary` SET TAGS ('dbx_business_glossary_term' = 'Change Summary');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_version` ALTER COLUMN `checked_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Checked In Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_version` ALTER COLUMN `checked_out_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Checked Out Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_version` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_version` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|highly_confidential|restricted');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Version Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_version` ALTER COLUMN `extracted_text` SET TAGS ('dbx_business_glossary_term' = 'Extracted Text');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_version` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_version` ALTER COLUMN `file_hash` SET TAGS ('dbx_business_glossary_term' = 'File Hash');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_version` ALTER COLUMN `file_name` SET TAGS ('dbx_business_glossary_term' = 'File Name');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_version` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size in Bytes');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_version` ALTER COLUMN `is_current_version` SET TAGS ('dbx_business_glossary_term' = 'Is Current Version Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_version` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_version` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_version` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Version Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_version` ALTER COLUMN `nlp_entities_extracted` SET TAGS ('dbx_business_glossary_term' = 'Natural Language Processing (NLP) Entities Extracted');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_version` ALTER COLUMN `ocr_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Optical Character Recognition (OCR) Confidence Score');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_version` ALTER COLUMN `ocr_engine` SET TAGS ('dbx_business_glossary_term' = 'Optical Character Recognition (OCR) Engine');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_version` ALTER COLUMN `ocr_processed_flag` SET TAGS ('dbx_business_glossary_term' = 'Optical Character Recognition (OCR) Processed Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_version` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Page Count');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_version` ALTER COLUMN `privilege_designation` SET TAGS ('dbx_business_glossary_term' = 'Legal Professional Privilege (LPP) Designation');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_version` ALTER COLUMN `privilege_designation` SET TAGS ('dbx_value_regex' = 'privileged|non_privileged|work_product|pending_review');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_version` ALTER COLUMN `production_date` SET TAGS ('dbx_business_glossary_term' = 'Production Date');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_version` ALTER COLUMN `production_flag` SET TAGS ('dbx_business_glossary_term' = 'Production Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_version` ALTER COLUMN `redacted_flag` SET TAGS ('dbx_business_glossary_term' = 'Redacted Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_version` ALTER COLUMN `redaction_reason` SET TAGS ('dbx_business_glossary_term' = 'Redaction Reason');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_version` ALTER COLUMN `retention_category` SET TAGS ('dbx_business_glossary_term' = 'Retention Category');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_version` ALTER COLUMN `retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiry Date');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_version` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'eDiscovery Review Status');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_version` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'not_reviewed|in_review|responsive|non_responsive|privileged');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_version` ALTER COLUMN `review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_version` ALTER COLUMN `storage_path` SET TAGS ('dbx_business_glossary_term' = 'Storage Path');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_version` ALTER COLUMN `storage_path` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_version` ALTER COLUMN `tar_relevance_score` SET TAGS ('dbx_business_glossary_term' = 'Technology-Assisted Review (TAR) Relevance Score');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_version` ALTER COLUMN `version_label` SET TAGS ('dbx_business_glossary_term' = 'Version Label');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_version` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_version` ALTER COLUMN `version_status` SET TAGS ('dbx_business_glossary_term' = 'Version Status');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_version` ALTER COLUMN `word_count` SET TAGS ('dbx_business_glossary_term' = 'Word Count');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ALTER COLUMN `doc_type_id` SET TAGS ('dbx_business_glossary_term' = 'Document Type Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ALTER COLUMN `agreement_type_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ALTER COLUMN `doc_template_id` SET TAGS ('dbx_business_glossary_term' = 'Default Template Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ALTER COLUMN `approval_workflow_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow Required Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ALTER COLUMN `billable_activity` SET TAGS ('dbx_business_glossary_term' = 'Billable Activity Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ALTER COLUMN `chain_of_custody_tracking` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody Tracking Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ALTER COLUMN `court_filing_eligible` SET TAGS ('dbx_business_glossary_term' = 'Court Filing Eligible Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ALTER COLUMN `default_privilege_classification` SET TAGS ('dbx_business_glossary_term' = 'Default Legal Professional Privilege (LPP) Classification');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ALTER COLUMN `default_privilege_classification` SET TAGS ('dbx_value_regex' = 'privileged|work_product|confidential|public');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ALTER COLUMN `dms_folder_path_template` SET TAGS ('dbx_business_glossary_term' = 'Document Management System (DMS) Folder Path Template');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ALTER COLUMN `doc_type_category` SET TAGS ('dbx_business_glossary_term' = 'Document Category');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ALTER COLUMN `doc_type_code` SET TAGS ('dbx_business_glossary_term' = 'Document Type Code');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ALTER COLUMN `doc_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ALTER COLUMN `doc_type_description` SET TAGS ('dbx_business_glossary_term' = 'Document Type Description');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ALTER COLUMN `doc_type_name` SET TAGS ('dbx_business_glossary_term' = 'Document Type Name');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ALTER COLUMN `doc_type_status` SET TAGS ('dbx_business_glossary_term' = 'Document Type Status');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ALTER COLUMN `doc_type_status` SET TAGS ('dbx_value_regex' = 'active|deprecated|archived|under_review');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ALTER COLUMN `ediscovery_reviewable` SET TAGS ('dbx_business_glossary_term' = 'eDiscovery Reviewable Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ALTER COLUMN `encryption_required` SET TAGS ('dbx_business_glossary_term' = 'Encryption Required Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ALTER COLUMN `external_sharing_allowed` SET TAGS ('dbx_business_glossary_term' = 'External Sharing Allowed Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ALTER COLUMN `jurisdiction_scope` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Scope');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ALTER COLUMN `matter_association_required` SET TAGS ('dbx_business_glossary_term' = 'Matter Association Required Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ALTER COLUMN `metadata_preservation_critical` SET TAGS ('dbx_business_glossary_term' = 'Metadata Preservation Critical Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ALTER COLUMN `naming_convention_pattern` SET TAGS ('dbx_business_glossary_term' = 'Document Naming Convention Pattern');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ALTER COLUMN `nlp_extraction_enabled` SET TAGS ('dbx_business_glossary_term' = 'Natural Language Processing (NLP) Extraction Enabled Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ALTER COLUMN `ocr_required` SET TAGS ('dbx_business_glossary_term' = 'Optical Character Recognition (OCR) Required Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ALTER COLUMN `pii_likely` SET TAGS ('dbx_business_glossary_term' = 'Personally Identifiable Information (PII) Likely Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ALTER COLUMN `redaction_protocol` SET TAGS ('dbx_business_glossary_term' = 'Redaction Protocol');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ALTER COLUMN `redaction_protocol` SET TAGS ('dbx_value_regex' = 'none|standard|enhanced|custom');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ALTER COLUMN `requires_conflict_check` SET TAGS ('dbx_business_glossary_term' = 'Requires Conflict Check Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ALTER COLUMN `requires_execution` SET TAGS ('dbx_business_glossary_term' = 'Requires Execution Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ALTER COLUMN `requires_notarization` SET TAGS ('dbx_business_glossary_term' = 'Requires Notarization Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ALTER COLUMN `requires_witness` SET TAGS ('dbx_business_glossary_term' = 'Requires Witness Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ALTER COLUMN `retention_category` SET TAGS ('dbx_business_glossary_term' = 'Retention Category');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ALTER COLUMN `retention_category` SET TAGS ('dbx_value_regex' = 'permanent|long_term|medium_term|short_term|event_based');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period in Years');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Document Subcategory');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ALTER COLUMN `usage_guidance` SET TAGS ('dbx_business_glossary_term' = 'Usage Guidance');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ALTER COLUMN `utbms_task_code` SET TAGS ('dbx_business_glossary_term' = 'Uniform Task-Based Management System (UTBMS) Task Code');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ALTER COLUMN `utbms_task_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{3}$');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ALTER COLUMN `version_control_required` SET TAGS ('dbx_business_glossary_term' = 'Version Control Required Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `doc_folder_id` SET TAGS ('dbx_business_glossary_term' = 'Document Folder ID');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `aml_kyc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Kyc Program Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `parent_doc_folder_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Folder ID');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `patent_family_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Family Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `workspace_id` SET TAGS ('dbx_business_glossary_term' = 'Workspace ID');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `access_control_group` SET TAGS ('dbx_business_glossary_term' = 'Access Control Group');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `archived_date` SET TAGS ('dbx_business_glossary_term' = 'Archived Date');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `audit_log_enabled` SET TAGS ('dbx_business_glossary_term' = 'Audit Log Enabled');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Closed Date');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `collaboration_enabled` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Enabled');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `confidentiality_agreement_required` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Agreement Required');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `created_by_user_code` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `created_by_user_code` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `created_by_user_code` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `dms_source_system` SET TAGS ('dbx_business_glossary_term' = 'Document Management System (DMS) Source System');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `dms_source_system` SET TAGS ('dbx_value_regex' = 'imanage_work|netdocuments|relativity|sharepoint|other');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `doc_folder_description` SET TAGS ('dbx_business_glossary_term' = 'Folder Description');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `document_count` SET TAGS ('dbx_business_glossary_term' = 'Document Count');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `encryption_enabled` SET TAGS ('dbx_business_glossary_term' = 'Encryption Enabled');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `ethical_wall_flag` SET TAGS ('dbx_business_glossary_term' = 'Ethical Wall Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `external_reference_number` SET TAGS ('dbx_business_glossary_term' = 'External Reference Number');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `external_sharing_allowed` SET TAGS ('dbx_business_glossary_term' = 'External Sharing Allowed');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `folder_name` SET TAGS ('dbx_business_glossary_term' = 'Folder Name');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `folder_path` SET TAGS ('dbx_business_glossary_term' = 'Folder Path');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `folder_status` SET TAGS ('dbx_business_glossary_term' = 'Folder Status');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `folder_status` SET TAGS ('dbx_value_regex' = 'active|closed|archived|suspended|pending_deletion');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `folder_type` SET TAGS ('dbx_business_glossary_term' = 'Folder Type');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `folder_type` SET TAGS ('dbx_value_regex' = 'matter_workspace|client_workspace|project_workspace|administrative|template|archive');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `last_accessed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Accessed Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `legal_hold_reference` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Reference');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `modified_by_user_code` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `modified_by_user_code` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `modified_by_user_code` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `owner_user_code` SET TAGS ('dbx_business_glossary_term' = 'Owner User ID');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `owner_user_code` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `owner_user_code` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `parent_hierarchy` SET TAGS ('dbx_business_glossary_term' = 'Parent Hierarchy');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `privilege_designation` SET TAGS ('dbx_business_glossary_term' = 'Privilege Designation');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `privilege_designation` SET TAGS ('dbx_value_regex' = 'none|attorney_client|work_product|joint_defense|settlement');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `retention_end_date` SET TAGS ('dbx_business_glossary_term' = 'Retention End Date');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `retention_policy_code` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy Code');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `retention_start_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Start Date');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `security_classification` SET TAGS ('dbx_business_glossary_term' = 'Security Classification');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `security_classification` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted|privileged');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `subfolder_count` SET TAGS ('dbx_business_glossary_term' = 'Subfolder Count');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `sync_enabled` SET TAGS ('dbx_business_glossary_term' = 'Synchronization Enabled');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `total_storage_bytes` SET TAGS ('dbx_business_glossary_term' = 'Total Storage Bytes');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `version_control_enabled` SET TAGS ('dbx_business_glossary_term' = 'Version Control Enabled');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ALTER COLUMN `workspace_template_code` SET TAGS ('dbx_business_glossary_term' = 'Workspace Template Code');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `doc_review_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Document Review Assignment ID');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `contract_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `doc_version_id` SET TAGS ('dbx_business_glossary_term' = 'Doc Version Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Document ID');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer ID');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `production_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Production Batch ID');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `review_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Review Batch ID');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `target_legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'To Legal Document Id');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `trademark_id` SET TAGS ('dbx_business_glossary_term' = 'Trademark Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `annotation_count` SET TAGS ('dbx_business_glossary_term' = 'Annotation Count');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `assignment_method` SET TAGS ('dbx_business_glossary_term' = 'Assignment Method');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `assignment_method` SET TAGS ('dbx_value_regex' = 'manual|automated|round_robin|workload_balanced');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `assignment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `bates_number` SET TAGS ('dbx_business_glossary_term' = 'Bates Number');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `cal_feedback_flag` SET TAGS ('dbx_business_glossary_term' = 'Continuous Active Learning (CAL) Feedback Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `confidentiality_designation` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Designation');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `confidentiality_designation` SET TAGS ('dbx_value_regex' = 'public|confidential|highly_confidential|attorneys_eyes_only');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `custodian_name` SET TAGS ('dbx_business_glossary_term' = 'Custodian Name');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `custodian_name` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `issue_tags` SET TAGS ('dbx_business_glossary_term' = 'Issue Tags');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `modified_by_user_code` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `modified_by_user_code` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `modified_by_user_code` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `privilege_type` SET TAGS ('dbx_business_glossary_term' = 'Privilege Type');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `privilege_type` SET TAGS ('dbx_value_regex' = 'attorney_client|work_product|joint_defense|settlement|none');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `production_flag` SET TAGS ('dbx_business_glossary_term' = 'Production Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `redaction_count` SET TAGS ('dbx_business_glossary_term' = 'Redaction Count');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `redaction_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Redaction Required Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `relevance_score` SET TAGS ('dbx_business_glossary_term' = 'Relevance Score');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `review_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `review_decision` SET TAGS ('dbx_business_glossary_term' = 'Review Decision');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `review_decision` SET TAGS ('dbx_value_regex' = 'responsive|non_responsive|privilege|not_reviewed');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `review_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Review Duration (Minutes)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `review_priority` SET TAGS ('dbx_business_glossary_term' = 'Review Priority');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `review_priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|urgent');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `review_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Start Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'assigned|in_progress|completed|skipped|escalated|on_hold');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Review Type');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = 'first_pass|quality_control|privilege_review|hot_document|ad_hoc');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `reviewer_comments` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Comments');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `second_level_review_decision` SET TAGS ('dbx_business_glossary_term' = 'Second-Level Review Decision');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `second_level_review_decision` SET TAGS ('dbx_value_regex' = 'confirmed|overridden|escalated');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `second_level_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Second-Level Review Required Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `second_level_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Second-Level Review Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ALTER COLUMN `tar_model_round` SET TAGS ('dbx_business_glossary_term' = 'Technology-Assisted Review (TAR) Model Round');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `privilege_log_id` SET TAGS ('dbx_business_glossary_term' = 'Privilege Log Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `contract_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `doc_version_id` SET TAGS ('dbx_business_glossary_term' = 'Doc Version Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `docket_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `ip_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Asset Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Asserting Attorney Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Document Id');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `privilege_produced_legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'To Legal Document Id');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `author_name` SET TAGS ('dbx_business_glossary_term' = 'Author Name');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `author_name` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `bates_number` SET TAGS ('dbx_business_glossary_term' = 'Bates Number');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `challenge_date` SET TAGS ('dbx_business_glossary_term' = 'Challenge Date');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `challenge_notes` SET TAGS ('dbx_business_glossary_term' = 'Challenge Notes');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `challenge_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Challenge Resolution Date');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `challenge_status` SET TAGS ('dbx_business_glossary_term' = 'Challenge Status');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `challenge_status` SET TAGS ('dbx_value_regex' = 'unchallenged|challenged|upheld|overruled|pending');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `clawback_date` SET TAGS ('dbx_business_glossary_term' = 'Clawback Request Date');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `clawback_requested` SET TAGS ('dbx_business_glossary_term' = 'Clawback Requested');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `clawback_status` SET TAGS ('dbx_business_glossary_term' = 'Clawback Status');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `clawback_status` SET TAGS ('dbx_value_regex' = 'not_applicable|requested|granted|denied|pending');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|highly_confidential|attorneys_eyes_only');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `court_case_number` SET TAGS ('dbx_business_glossary_term' = 'Court Case Number');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `custodian_name` SET TAGS ('dbx_business_glossary_term' = 'Custodian Name');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `custodian_name` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `designation_date` SET TAGS ('dbx_business_glossary_term' = 'Designation Date');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `designation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Designation Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `document_description` SET TAGS ('dbx_business_glossary_term' = 'Document Description');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `document_title` SET TAGS ('dbx_business_glossary_term' = 'Document Title');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `entry_number` SET TAGS ('dbx_business_glossary_term' = 'Privilege Log Entry Number');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `lpp_classification` SET TAGS ('dbx_business_glossary_term' = 'Legal Professional Privilege (LPP) Classification');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `lpp_classification` SET TAGS ('dbx_value_regex' = 'legal_advice|litigation|contentious|non_contentious|not_applicable');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `privilege_basis` SET TAGS ('dbx_business_glossary_term' = 'Privilege Basis');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `privilege_type` SET TAGS ('dbx_business_glossary_term' = 'Privilege Type');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `privilege_type` SET TAGS ('dbx_value_regex' = 'attorney_client|work_product|common_interest|joint_defense|settlement|other');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `production_status` SET TAGS ('dbx_business_glossary_term' = 'Production Status');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `production_status` SET TAGS ('dbx_value_regex' = 'withheld|produced_redacted|produced_unredacted|pending_review');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `recipient_names` SET TAGS ('dbx_business_glossary_term' = 'Recipient Names');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `recipient_names` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `redaction_status` SET TAGS ('dbx_business_glossary_term' = 'Redaction Status');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `redaction_status` SET TAGS ('dbx_value_regex' = 'not_redacted|partially_redacted|fully_redacted|withheld');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `retention_hold` SET TAGS ('dbx_business_glossary_term' = 'Retention Hold');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `waiver_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Date');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `waiver_status` SET TAGS ('dbx_business_glossary_term' = 'Waiver Status');
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ALTER COLUMN `waiver_status` SET TAGS ('dbx_value_regex' = 'not_waived|inadvertent_disclosure|intentional_waiver|subject_matter_waiver|pending_determination');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `esi_collection_id` SET TAGS ('dbx_business_glossary_term' = 'Electronically Stored Information (ESI) Collection ID');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `contract_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `esi_custodian_id` SET TAGS ('dbx_business_glossary_term' = 'To Esi Custodian Id');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `docket_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `ip_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Asset Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `legal_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `primary_esi_custodian_id` SET TAGS ('dbx_business_glossary_term' = 'Esi Custodian Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `source_esi_custodian_id` SET TAGS ('dbx_business_glossary_term' = 'From Esi Custodian Id');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `chain_of_custody_hash` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody Hash Value');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `collection_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Collection Cost Amount');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `collection_cost_amount` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `collection_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Collection Cost Currency');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `collection_cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `collection_end_date` SET TAGS ('dbx_business_glossary_term' = 'Collection End Date');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `collection_method` SET TAGS ('dbx_business_glossary_term' = 'Collection Method');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `collection_name` SET TAGS ('dbx_business_glossary_term' = 'Collection Name');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `collection_notes` SET TAGS ('dbx_business_glossary_term' = 'Collection Notes');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `collection_number` SET TAGS ('dbx_business_glossary_term' = 'Collection Number');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `collection_scope_description` SET TAGS ('dbx_business_glossary_term' = 'Collection Scope Description');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `collection_start_date` SET TAGS ('dbx_business_glossary_term' = 'Collection Start Date');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Status');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `collection_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|failed|cancelled|on_hold');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `collection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Collection Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `collection_tool_name` SET TAGS ('dbx_business_glossary_term' = 'Collection Tool Name');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `collection_tool_version` SET TAGS ('dbx_business_glossary_term' = 'Collection Tool Version');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `collection_type` SET TAGS ('dbx_business_glossary_term' = 'Collection Type');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `collection_type` SET TAGS ('dbx_value_regex' = 'targeted|forensic|remote|onsite|self_collection');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `collector_name` SET TAGS ('dbx_business_glossary_term' = 'Collector Name');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `collector_organization` SET TAGS ('dbx_business_glossary_term' = 'Collector Organization');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `data_source_location` SET TAGS ('dbx_business_glossary_term' = 'Data Source Location');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `data_source_type` SET TAGS ('dbx_business_glossary_term' = 'Data Source Type');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `date_range_end` SET TAGS ('dbx_business_glossary_term' = 'Date Range End');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `date_range_start` SET TAGS ('dbx_business_glossary_term' = 'Date Range Start');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `deduplication_applied` SET TAGS ('dbx_business_glossary_term' = 'Deduplication Applied');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `encryption_detected` SET TAGS ('dbx_business_glossary_term' = 'Encryption Detected');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `hash_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Hash Algorithm');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `hash_algorithm` SET TAGS ('dbx_value_regex' = 'MD5|SHA1|SHA256|SHA512');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `password_protected_items_count` SET TAGS ('dbx_business_glossary_term' = 'Password Protected Items Count');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `preservation_notice_date` SET TAGS ('dbx_business_glossary_term' = 'Preservation Notice Date');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `preservation_notice_issued` SET TAGS ('dbx_business_glossary_term' = 'Preservation Notice Issued');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `privilege_review_required` SET TAGS ('dbx_business_glossary_term' = 'Privilege Review Required');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `production_eligible` SET TAGS ('dbx_business_glossary_term' = 'Production Eligible');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `relativity_workspace_reference` SET TAGS ('dbx_business_glossary_term' = 'Relativity Workspace ID');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `total_items_collected` SET TAGS ('dbx_business_glossary_term' = 'Total Items Collected');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `total_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Total Size in Bytes');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ALTER COLUMN `total_size_gb` SET TAGS ('dbx_business_glossary_term' = 'Total Size in Gigabytes (GB)');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `esi_custodian_id` SET TAGS ('dbx_business_glossary_term' = 'Electronically Stored Information (ESI) Custodian ID');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `inventor_id` SET TAGS ('dbx_business_glossary_term' = 'Inventor Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Employee ID');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_pii_identifier' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `chain_of_custody_verified` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody Verified');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `collection_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Collection Completion Date');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `collection_file_count` SET TAGS ('dbx_business_glossary_term' = 'Collection File Count');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `collection_method` SET TAGS ('dbx_business_glossary_term' = 'Collection Method');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `collection_method` SET TAGS ('dbx_value_regex' = 'forensic_imaging|targeted_collection|self_collection|remote_collection|on_site_collection');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `collection_start_date` SET TAGS ('dbx_business_glossary_term' = 'Collection Start Date');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Status');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `collection_status` SET TAGS ('dbx_value_regex' = 'not_started|scheduled|in_progress|completed|failed|on_hold');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `collection_volume_gb` SET TAGS ('dbx_business_glossary_term' = 'Collection Volume (GB)');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `custodian_active_flag` SET TAGS ('dbx_business_glossary_term' = 'Custodian Active Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `custodian_department` SET TAGS ('dbx_business_glossary_term' = 'Custodian Department');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `custodian_departure_date` SET TAGS ('dbx_business_glossary_term' = 'Custodian Departure Date');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `custodian_email` SET TAGS ('dbx_business_glossary_term' = 'Custodian Email Address');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `custodian_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `custodian_email` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `custodian_email` SET TAGS ('dbx_dbx_pii_email' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `custodian_full_name` SET TAGS ('dbx_business_glossary_term' = 'Custodian Full Name');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `custodian_full_name` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `custodian_full_name` SET TAGS ('dbx_dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `custodian_organization` SET TAGS ('dbx_business_glossary_term' = 'Custodian Organization');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `custodian_role` SET TAGS ('dbx_business_glossary_term' = 'Custodian Role');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `custodian_status` SET TAGS ('dbx_business_glossary_term' = 'Custodian Status');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `custodian_type` SET TAGS ('dbx_business_glossary_term' = 'Custodian Type');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `custodian_type` SET TAGS ('dbx_value_regex' = 'key|standard|peripheral|third_party|non_employee');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `data_residency_country` SET TAGS ('dbx_business_glossary_term' = 'Data Residency Country');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `data_residency_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `data_sources_cloud_storage` SET TAGS ('dbx_business_glossary_term' = 'Data Sources - Cloud Storage');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `data_sources_collaboration_tools` SET TAGS ('dbx_business_glossary_term' = 'Data Sources - Collaboration Tools');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `data_sources_email` SET TAGS ('dbx_business_glossary_term' = 'Data Sources - Email Systems');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `data_sources_email` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `data_sources_email` SET TAGS ('dbx_dbx_pii_email' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `data_sources_file_shares` SET TAGS ('dbx_business_glossary_term' = 'Data Sources - File Shares');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `data_sources_local_drives` SET TAGS ('dbx_business_glossary_term' = 'Data Sources - Local Drives');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `data_sources_mobile_devices` SET TAGS ('dbx_business_glossary_term' = 'Data Sources - Mobile Devices');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `data_sources_mobile_devices` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `data_sources_mobile_devices` SET TAGS ('dbx_dbx_pii_phone' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `data_sources_other` SET TAGS ('dbx_business_glossary_term' = 'Data Sources - Other');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `gdpr_data_subject_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Data Subject Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `lpp_classification` SET TAGS ('dbx_business_glossary_term' = 'Legal Professional Privilege (LPP) Classification');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `lpp_classification` SET TAGS ('dbx_value_regex' = 'not_applicable|legal_advice|litigation_privilege|without_prejudice');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `privilege_designation` SET TAGS ('dbx_business_glossary_term' = 'Privilege Designation');
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ALTER COLUMN `privilege_designation` SET TAGS ('dbx_value_regex' = 'none|attorney_client|work_product|joint_defense|settlement');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ALTER COLUMN `legal_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold ID');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ALTER COLUMN `checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Checklist Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ALTER COLUMN `contract_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ALTER COLUMN `doc_template_id` SET TAGS ('dbx_business_glossary_term' = 'Hold Notice Template ID');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ALTER COLUMN `docket_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ALTER COLUMN `ip_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Asset Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ALTER COLUMN `esi_custodian_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Esi Custodian Id');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ALTER COLUMN `organisation_id` SET TAGS ('dbx_business_glossary_term' = 'Outside Counsel Firm ID');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Issued By Attorney ID');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ALTER COLUMN `primary_esi_custodian_id` SET TAGS ('dbx_business_glossary_term' = 'Esi Custodian Id');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ALTER COLUMN `acknowledged_count` SET TAGS ('dbx_business_glossary_term' = 'Acknowledged Count');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ALTER COLUMN `compliance_monitoring_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Monitoring Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ALTER COLUMN `custodian_count` SET TAGS ('dbx_business_glossary_term' = 'Custodian Count');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ALTER COLUMN `data_sources_in_scope` SET TAGS ('dbx_business_glossary_term' = 'Data Sources In Scope');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ALTER COLUMN `document_types_in_scope` SET TAGS ('dbx_business_glossary_term' = 'Document Types In Scope');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ALTER COLUMN `ediscovery_collection_initiated_flag` SET TAGS ('dbx_business_glossary_term' = 'eDiscovery (Electronic Discovery) Collection Initiated Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ALTER COLUMN `escalation_count` SET TAGS ('dbx_business_glossary_term' = 'Escalation Count');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ALTER COLUMN `hold_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Name');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ALTER COLUMN `hold_number` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Number');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Status');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|released|expired');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ALTER COLUMN `issued_date` SET TAGS ('dbx_business_glossary_term' = 'Issued Date');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ALTER COLUMN `last_reminder_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reminder Sent Date');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ALTER COLUMN `preservation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Preservation End Date');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ALTER COLUMN `preservation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Preservation Start Date');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ALTER COLUMN `privilege_designation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Professional Privilege (LPP) Designation Required Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ALTER COLUMN `release_reason` SET TAGS ('dbx_business_glossary_term' = 'Release Reason');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ALTER COLUMN `reminder_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Reminder Frequency Days');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ALTER COLUMN `spoliation_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Spoliation Risk Level');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ALTER COLUMN `spoliation_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ALTER COLUMN `suspension_of_destruction_flag` SET TAGS ('dbx_business_glossary_term' = 'Suspension of Destruction Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ALTER COLUMN `trigger_date` SET TAGS ('dbx_business_glossary_term' = 'Trigger Date');
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ALTER COLUMN `trigger_event` SET TAGS ('dbx_business_glossary_term' = 'Trigger Event');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `doc_production_id` SET TAGS ('dbx_business_glossary_term' = 'Document Production Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `contract_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `esi_collection_id` SET TAGS ('dbx_business_glossary_term' = 'Doc Esi Collection Id');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `docket_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `ip_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Asset Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `matter_disbursement_id` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `production_set_id` SET TAGS ('dbx_business_glossary_term' = 'Production Set Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `source_esi_collection_id` SET TAGS ('dbx_business_glossary_term' = 'Esi Collection Id');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `acknowledgment_received` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Received Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `bates_end_number` SET TAGS ('dbx_business_glossary_term' = 'Bates End Number');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `bates_end_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,50}$');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `bates_prefix` SET TAGS ('dbx_business_glossary_term' = 'Bates Prefix');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `bates_prefix` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,20}$');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `bates_start_number` SET TAGS ('dbx_business_glossary_term' = 'Bates Start Number');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `bates_start_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,50}$');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `clawback_date` SET TAGS ('dbx_business_glossary_term' = 'Clawback Date');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `clawback_invoked` SET TAGS ('dbx_business_glossary_term' = 'Clawback Invoked Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `confidentiality_designation` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Designation');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `confidentiality_designation` SET TAGS ('dbx_value_regex' = 'none|confidential|highly_confidential|attorneys_eyes_only|source_code');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'secure_file_transfer|physical_media|cloud_platform|email|courier|relativity_transfer');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `dispute_description` SET TAGS ('dbx_business_glossary_term' = 'Dispute Description');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `dispute_raised` SET TAGS ('dbx_business_glossary_term' = 'Dispute Raised Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `document_count` SET TAGS ('dbx_business_glossary_term' = 'Document Count');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `hash_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Hash Verification Method');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `hash_verification_method` SET TAGS ('dbx_value_regex' = 'md5|sha1|sha256|none');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `load_file_format` SET TAGS ('dbx_business_glossary_term' = 'Load File Format');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `metadata_fields_included` SET TAGS ('dbx_business_glossary_term' = 'Metadata Fields Included');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `native_file_count` SET TAGS ('dbx_business_glossary_term' = 'Native File Count');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Page Count');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `privilege_log_included` SET TAGS ('dbx_business_glossary_term' = 'Privilege Log Included Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `privilege_log_reference` SET TAGS ('dbx_business_glossary_term' = 'Privilege Log Reference');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `producing_counsel_name` SET TAGS ('dbx_business_glossary_term' = 'Producing Counsel Name');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `producing_party_name` SET TAGS ('dbx_business_glossary_term' = 'Producing Party Name');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `production_date` SET TAGS ('dbx_business_glossary_term' = 'Production Date');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `production_format` SET TAGS ('dbx_business_glossary_term' = 'Production Format');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `production_format` SET TAGS ('dbx_value_regex' = 'native|tiff|pdf|mixed|load_file');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `production_name` SET TAGS ('dbx_business_glossary_term' = 'Production Name');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `production_notes` SET TAGS ('dbx_business_glossary_term' = 'Production Notes');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `production_number` SET TAGS ('dbx_business_glossary_term' = 'Production Number');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `production_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,50}$');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `production_status` SET TAGS ('dbx_business_glossary_term' = 'Production Status');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `production_type` SET TAGS ('dbx_business_glossary_term' = 'Production Type');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `production_type` SET TAGS ('dbx_value_regex' = 'initial|supplemental|rolling|privilege_log|clawback|corrective');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `protective_order_reference` SET TAGS ('dbx_business_glossary_term' = 'Protective Order Reference');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `receiving_party_contact` SET TAGS ('dbx_business_glossary_term' = 'Receiving Party Contact');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `receiving_party_contact` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `receiving_party_contact` SET TAGS ('dbx_dbx_pii_email' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `receiving_party_name` SET TAGS ('dbx_business_glossary_term' = 'Receiving Party Name');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `redaction_applied` SET TAGS ('dbx_business_glossary_term' = 'Redaction Applied Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `redaction_count` SET TAGS ('dbx_business_glossary_term' = 'Redaction Count');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `relativity_workspace_reference` SET TAGS ('dbx_business_glossary_term' = 'Relativity Workspace Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_annotation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_annotation` ALTER COLUMN `doc_annotation_id` SET TAGS ('dbx_business_glossary_term' = 'Document Annotation Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_annotation` ALTER COLUMN `doc_version_id` SET TAGS ('dbx_business_glossary_term' = 'Doc Version Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_annotation` ALTER COLUMN `ip_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Asset Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_annotation` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Document Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_annotation` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_annotation` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_annotation` ALTER COLUMN `annotation_category` SET TAGS ('dbx_business_glossary_term' = 'Annotation Category');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_annotation` ALTER COLUMN `annotation_length` SET TAGS ('dbx_business_glossary_term' = 'Annotation Length');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_annotation` ALTER COLUMN `annotation_notes` SET TAGS ('dbx_business_glossary_term' = 'Annotation Notes');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_annotation` ALTER COLUMN `annotation_status` SET TAGS ('dbx_business_glossary_term' = 'Annotation Status');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_annotation` ALTER COLUMN `annotation_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|under_review');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_annotation` ALTER COLUMN `annotation_text` SET TAGS ('dbx_business_glossary_term' = 'Annotation Text Content');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_annotation` ALTER COLUMN `annotation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Annotation Creation Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_annotation` ALTER COLUMN `annotation_type` SET TAGS ('dbx_business_glossary_term' = 'Annotation Type');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_annotation` ALTER COLUMN `annotation_type` SET TAGS ('dbx_value_regex' = 'issue_tag|redaction|comment|highlight|privilege_designation|coding_decision');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_annotation` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_annotation` ALTER COLUMN `cal_training_set_flag` SET TAGS ('dbx_business_glossary_term' = 'Continuous Active Learning (CAL) Training Set Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_annotation` ALTER COLUMN `chain_of_custody_flag` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_annotation` ALTER COLUMN `coding_decision` SET TAGS ('dbx_business_glossary_term' = 'Coding Decision');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_annotation` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Confidence Score');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_annotation` ALTER COLUMN `highlight_color` SET TAGS ('dbx_business_glossary_term' = 'Highlight Color');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_annotation` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Status Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_annotation` ALTER COLUMN `issue_tag` SET TAGS ('dbx_business_glossary_term' = 'Issue Tag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_annotation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_annotation` ALTER COLUMN `nlp_extracted_flag` SET TAGS ('dbx_business_glossary_term' = 'Natural Language Processing (NLP) Extracted Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_annotation` ALTER COLUMN `page_number` SET TAGS ('dbx_business_glossary_term' = 'Page Number');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_annotation` ALTER COLUMN `paragraph_number` SET TAGS ('dbx_business_glossary_term' = 'Paragraph Number');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_annotation` ALTER COLUMN `privilege_designation` SET TAGS ('dbx_business_glossary_term' = 'Legal Professional Privilege (LPP) Designation');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_annotation` ALTER COLUMN `privilege_designation` SET TAGS ('dbx_value_regex' = 'attorney_client|work_product|joint_defense|none');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_annotation` ALTER COLUMN `production_flag` SET TAGS ('dbx_business_glossary_term' = 'Production Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_annotation` ALTER COLUMN `quality_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_annotation` ALTER COLUMN `redaction_coordinates` SET TAGS ('dbx_business_glossary_term' = 'Redaction Coordinates');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_annotation` ALTER COLUMN `redaction_type` SET TAGS ('dbx_business_glossary_term' = 'Redaction Type');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_annotation` ALTER COLUMN `redaction_type` SET TAGS ('dbx_value_regex' = 'pii|confidential|privileged|trade_secret|none');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_annotation` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_annotation` ALTER COLUMN `review_round` SET TAGS ('dbx_business_glossary_term' = 'Review Round Number');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_annotation` ALTER COLUMN `review_stage` SET TAGS ('dbx_business_glossary_term' = 'Review Stage');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_annotation` ALTER COLUMN `review_stage` SET TAGS ('dbx_value_regex' = 'first_pass|second_level|quality_control|privilege_review|production_review');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_annotation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_annotation` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'relativity|imanage|netdocuments|other');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_annotation` ALTER COLUMN `source_system_annotation_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Annotation Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_annotation` ALTER COLUMN `tar_model_feedback_flag` SET TAGS ('dbx_business_glossary_term' = 'Technology-Assisted Review (TAR) Model Feedback Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`retention_schedule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `legal_ecm_v1`.`document`.`retention_schedule` ALTER COLUMN `retention_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Schedule ID');
ALTER TABLE `legal_ecm_v1`.`document`.`retention_schedule` ALTER COLUMN `agreement_type_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`retention_schedule` ALTER COLUMN `doc_type_id` SET TAGS ('dbx_business_glossary_term' = 'Doc Type Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`retention_schedule` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`retention_schedule` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`retention_schedule` ALTER COLUMN `superseding_retention_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Schedule ID');
ALTER TABLE `legal_ecm_v1`.`document`.`retention_schedule` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm_v1`.`document`.`retention_schedule` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `legal_ecm_v1`.`document`.`retention_schedule` ALTER COLUMN `audit_trail_retention_years` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Retention (Years)');
ALTER TABLE `legal_ecm_v1`.`document`.`retention_schedule` ALTER COLUMN `certificate_of_destruction_required` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Destruction Required');
ALTER TABLE `legal_ecm_v1`.`document`.`retention_schedule` ALTER COLUMN `client_specific_override` SET TAGS ('dbx_business_glossary_term' = 'Client-Specific Override');
ALTER TABLE `legal_ecm_v1`.`document`.`retention_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`retention_schedule` ALTER COLUMN `cross_border_transfer_restriction` SET TAGS ('dbx_business_glossary_term' = 'Cross-Border Transfer Restriction');
ALTER TABLE `legal_ecm_v1`.`document`.`retention_schedule` ALTER COLUMN `destruction_authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Destruction Authorization Required');
ALTER TABLE `legal_ecm_v1`.`document`.`retention_schedule` ALTER COLUMN `destruction_method` SET TAGS ('dbx_business_glossary_term' = 'Destruction Method');
ALTER TABLE `legal_ecm_v1`.`document`.`retention_schedule` ALTER COLUMN `dms_system_enforcement` SET TAGS ('dbx_business_glossary_term' = 'Document Management System (DMS) Enforcement');
ALTER TABLE `legal_ecm_v1`.`document`.`retention_schedule` ALTER COLUMN `dms_system_enforcement` SET TAGS ('dbx_value_regex' = 'imanage|netdocuments|both|manual|none');
ALTER TABLE `legal_ecm_v1`.`document`.`retention_schedule` ALTER COLUMN `ediscovery_relevance_flag` SET TAGS ('dbx_business_glossary_term' = 'eDiscovery Relevance Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`retention_schedule` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `legal_ecm_v1`.`document`.`retention_schedule` ALTER COLUMN `effective_until_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `legal_ecm_v1`.`document`.`retention_schedule` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm_v1`.`document`.`retention_schedule` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `legal_ecm_v1`.`document`.`retention_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`retention_schedule` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `legal_ecm_v1`.`document`.`retention_schedule` ALTER COLUMN `legal_hold_exemption` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Exemption');
ALTER TABLE `legal_ecm_v1`.`document`.`retention_schedule` ALTER COLUMN `lpp_classification` SET TAGS ('dbx_business_glossary_term' = 'Legal Professional Privilege (LPP) Classification');
ALTER TABLE `legal_ecm_v1`.`document`.`retention_schedule` ALTER COLUMN `lpp_classification` SET TAGS ('dbx_value_regex' = 'privileged|non_privileged|work_product|mixed|unknown');
ALTER TABLE `legal_ecm_v1`.`document`.`retention_schedule` ALTER COLUMN `matter_type` SET TAGS ('dbx_business_glossary_term' = 'Matter Type');
ALTER TABLE `legal_ecm_v1`.`document`.`retention_schedule` ALTER COLUMN `maximum_retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Maximum Retention Period (Years)');
ALTER TABLE `legal_ecm_v1`.`document`.`retention_schedule` ALTER COLUMN `minimum_retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Minimum Retention Period (Years)');
ALTER TABLE `legal_ecm_v1`.`document`.`retention_schedule` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `legal_ecm_v1`.`document`.`retention_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Retention Schedule Notes');
ALTER TABLE `legal_ecm_v1`.`document`.`retention_schedule` ALTER COLUMN `privacy_impact_classification` SET TAGS ('dbx_business_glossary_term' = 'Privacy Impact Classification');
ALTER TABLE `legal_ecm_v1`.`document`.`retention_schedule` ALTER COLUMN `privacy_impact_classification` SET TAGS ('dbx_value_regex' = 'high|medium|low|none');
ALTER TABLE `legal_ecm_v1`.`document`.`retention_schedule` ALTER COLUMN `records_classification_code` SET TAGS ('dbx_business_glossary_term' = 'Records Classification Code');
ALTER TABLE `legal_ecm_v1`.`document`.`retention_schedule` ALTER COLUMN `records_classification_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `legal_ecm_v1`.`document`.`retention_schedule` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `legal_ecm_v1`.`document`.`retention_schedule` ALTER COLUMN `responsible_records_manager` SET TAGS ('dbx_business_glossary_term' = 'Responsible Records Manager');
ALTER TABLE `legal_ecm_v1`.`document`.`retention_schedule` ALTER COLUMN `retention_basis` SET TAGS ('dbx_business_glossary_term' = 'Retention Basis');
ALTER TABLE `legal_ecm_v1`.`document`.`retention_schedule` ALTER COLUMN `retention_review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Retention Review Frequency (Months)');
ALTER TABLE `legal_ecm_v1`.`document`.`retention_schedule` ALTER COLUMN `retention_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Retention Schedule Status');
ALTER TABLE `legal_ecm_v1`.`document`.`retention_schedule` ALTER COLUMN `retention_schedule_status` SET TAGS ('dbx_value_regex' = 'active|draft|superseded|archived|under_review');
ALTER TABLE `legal_ecm_v1`.`document`.`retention_schedule` ALTER COLUMN `retention_trigger_event` SET TAGS ('dbx_business_glossary_term' = 'Retention Trigger Event');
ALTER TABLE `legal_ecm_v1`.`document`.`retention_schedule` ALTER COLUMN `version_control_policy` SET TAGS ('dbx_business_glossary_term' = 'Version Control Policy');
ALTER TABLE `legal_ecm_v1`.`document`.`retention_schedule` ALTER COLUMN `version_control_policy` SET TAGS ('dbx_value_regex' = 'retain_all_versions|retain_final_only|retain_major_versions|retain_last_n_versions');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `doc_access_event_id` SET TAGS ('dbx_business_glossary_term' = 'Document Access Event ID');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Reviewer ID');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `contract_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `data_breach_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Data Breach Incident Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `data_subject_request_id` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Request ID');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `doc_ediscovery_matter_id` SET TAGS ('dbx_business_glossary_term' = 'eDiscovery (Electronic Discovery) Case ID');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `doc_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'User ID');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `doc_user_timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `doc_user_timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `doc_version_id` SET TAGS ('dbx_business_glossary_term' = 'Doc Version Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `ip_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Asset Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Document ID');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `review_session_id` SET TAGS ('dbx_business_glossary_term' = 'Session ID');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `review_set_id` SET TAGS ('dbx_business_glossary_term' = 'Review Set ID');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `access_anomaly_score` SET TAGS ('dbx_business_glossary_term' = 'Access Anomaly Score');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `access_authorized_flag` SET TAGS ('dbx_business_glossary_term' = 'Access Authorized Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `access_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Access Duration (Seconds)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `access_method` SET TAGS ('dbx_business_glossary_term' = 'Access Method');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `access_method` SET TAGS ('dbx_value_regex' = 'web_portal|desktop_client|mobile_app|api|email_integration|third_party_integration');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `access_reason` SET TAGS ('dbx_business_glossary_term' = 'Access Reason');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `access_source_system` SET TAGS ('dbx_business_glossary_term' = 'Access Source System');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `access_source_system` SET TAGS ('dbx_value_regex' = 'imanage_work|netdocuments|relativity|elite_3e|other');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `access_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Access Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `access_type` SET TAGS ('dbx_business_glossary_term' = 'Access Type');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `compliance_review_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Notes');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `compliance_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Required Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Status');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_value_regex' = 'pending|in_review|cleared|breach_confirmed|remediation_required');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `compliance_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `document_classification` SET TAGS ('dbx_business_glossary_term' = 'Document Classification');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `document_classification` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted|lpp_privileged');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `document_title` SET TAGS ('dbx_business_glossary_term' = 'Document Title');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `ethical_wall_status` SET TAGS ('dbx_business_glossary_term' = 'Ethical Wall Status');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `ethical_wall_status` SET TAGS ('dbx_value_regex' = 'within_wall|outside_wall|no_wall_applicable|wall_breach');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `lpp_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'LPP (Legal Professional Privilege) Breach Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `pii_accessed_flag` SET TAGS ('dbx_business_glossary_term' = 'PII (Personally Identifiable Information) Accessed Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `record_source_file` SET TAGS ('dbx_business_glossary_term' = 'Record Source File');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiry Date');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `share_recipient_email` SET TAGS ('dbx_business_glossary_term' = 'Share Recipient Email Address');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `share_recipient_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `share_recipient_email` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `share_recipient_email` SET TAGS ('dbx_dbx_pii_email' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `share_recipient_organization` SET TAGS ('dbx_business_glossary_term' = 'Share Recipient Organization');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `user_department` SET TAGS ('dbx_business_glossary_term' = 'User Department');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `user_device_type` SET TAGS ('dbx_business_glossary_term' = 'User Device Type');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `user_device_type` SET TAGS ('dbx_value_regex' = 'desktop|laptop|tablet|mobile|server|unknown');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `user_ip_address` SET TAGS ('dbx_business_glossary_term' = 'User IP (Internet Protocol) Address');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `user_ip_address` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `user_ip_address` SET TAGS ('dbx_dbx_pii_ip' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `user_location` SET TAGS ('dbx_business_glossary_term' = 'User Location');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ALTER COLUMN `user_role` SET TAGS ('dbx_business_glossary_term' = 'User Role');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `doc_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Document Execution Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Attorney Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `contract_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `doc_version_id` SET TAGS ('dbx_business_glossary_term' = 'Doc Version Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `escrow_release_id` SET TAGS ('dbx_business_glossary_term' = 'Escrow Release Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `execution_workflow_id` SET TAGS ('dbx_business_glossary_term' = 'Execution Workflow Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `form_template_id` SET TAGS ('dbx_business_glossary_term' = 'Form Template Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `ip_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Asset Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip License Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Document Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Execution Coordinator Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `board_resolution_reference` SET TAGS ('dbx_business_glossary_term' = 'Board Resolution Reference');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `board_resolution_reference` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `board_resolution_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Board Resolution Required Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `compliance_review_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Completed Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `counterpart_count` SET TAGS ('dbx_business_glossary_term' = 'Counterpart Count');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `counterpart_indicator` SET TAGS ('dbx_business_glossary_term' = 'Counterpart Indicator');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `executed_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Executed Document Reference');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `execution_language` SET TAGS ('dbx_business_glossary_term' = 'Execution Language');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `execution_location` SET TAGS ('dbx_business_glossary_term' = 'Execution Location');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `execution_method` SET TAGS ('dbx_business_glossary_term' = 'Execution Method');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `execution_notes` SET TAGS ('dbx_business_glossary_term' = 'Execution Notes');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `execution_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Execution Reference Number');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `execution_status` SET TAGS ('dbx_business_glossary_term' = 'Execution Status');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Execution Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `execution_type` SET TAGS ('dbx_business_glossary_term' = 'Execution Type');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `notarization_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Notarization Completed Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `notarization_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Notarization Required Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `notary_commission_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Notary Commission Expiry Date');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `notary_commission_number` SET TAGS ('dbx_business_glossary_term' = 'Notary Commission Number');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `notary_commission_number` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `notary_name` SET TAGS ('dbx_business_glossary_term' = 'Notary Name');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `notary_name` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `power_of_attorney_used_flag` SET TAGS ('dbx_business_glossary_term' = 'Power of Attorney (POA) Used Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `seal_applied_flag` SET TAGS ('dbx_business_glossary_term' = 'Seal Applied Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `seal_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Seal Required Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `signatures_completed_count` SET TAGS ('dbx_business_glossary_term' = 'Signatures Completed Count');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `signing_party_count` SET TAGS ('dbx_business_glossary_term' = 'Signing Party Count');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `witness_count_obtained` SET TAGS ('dbx_business_glossary_term' = 'Witness Count Obtained');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `witness_count_required` SET TAGS ('dbx_business_glossary_term' = 'Witness Count Required');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ALTER COLUMN `witness_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Witness Required Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_template` ALTER COLUMN `doc_template_id` SET TAGS ('dbx_business_glossary_term' = 'Document Template ID');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_template` ALTER COLUMN `agreement_type_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_template` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Partner ID');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_template` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_template` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Author ID');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_template` ALTER COLUMN `access_level` SET TAGS ('dbx_business_glossary_term' = 'Access Level');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_template` ALTER COLUMN `access_level` SET TAGS ('dbx_value_regex' = 'public|practice_group|partner_only|restricted');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_template` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_template` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_template` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|archived|deprecated|withdrawn');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_template` ALTER COLUMN `automation_platform` SET TAGS ('dbx_business_glossary_term' = 'Automation Platform');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_template` ALTER COLUMN `contains_automation` SET TAGS ('dbx_business_glossary_term' = 'Contains Automation');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_template` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_template` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_template` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_template` ALTER COLUMN `file_format` SET TAGS ('dbx_value_regex' = 'docx|pdf|rtf|odt|html');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_template` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_template` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_template` ALTER COLUMN `is_client_facing` SET TAGS ('dbx_business_glossary_term' = 'Is Client Facing');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_template` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_template` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Language');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_template` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_template` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_template` ALTER COLUMN `last_used_date` SET TAGS ('dbx_business_glossary_term' = 'Last Used Date');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_template` ALTER COLUMN `modified_by_user_code` SET TAGS ('dbx_business_glossary_term' = 'Modified By ID');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_template` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_template` ALTER COLUMN `owner_practice_group` SET TAGS ('dbx_business_glossary_term' = 'Owner Practice Group');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_template` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Page Count');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_template` ALTER COLUMN `practice_area` SET TAGS ('dbx_business_glossary_term' = 'Practice Area');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_template` ALTER COLUMN `precedent_references` SET TAGS ('dbx_business_glossary_term' = 'Precedent References');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_template` ALTER COLUMN `primary_doc_type_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Doc Type Id');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_template` ALTER COLUMN `primary_doc_type_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_template` ALTER COLUMN `regulatory_compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Notes');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_template` ALTER COLUMN `related_matter_types` SET TAGS ('dbx_business_glossary_term' = 'Related Matter Types');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_template` ALTER COLUMN `requires_partner_review` SET TAGS ('dbx_business_glossary_term' = 'Requires Partner Review');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_template` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period Years');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_template` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_template` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Template Tags');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_template` ALTER COLUMN `template_code` SET TAGS ('dbx_business_glossary_term' = 'Template Code');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_template` ALTER COLUMN `template_description` SET TAGS ('dbx_business_glossary_term' = 'Template Description');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_template` ALTER COLUMN `template_name` SET TAGS ('dbx_business_glossary_term' = 'Template Name');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_template` ALTER COLUMN `template_version` SET TAGS ('dbx_business_glossary_term' = 'Template Version');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_template` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_template` ALTER COLUMN `usage_instructions` SET TAGS ('dbx_business_glossary_term' = 'Usage Instructions');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_template` ALTER COLUMN `word_count` SET TAGS ('dbx_business_glossary_term' = 'Word Count');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ALTER COLUMN `doc_relationship_id` SET TAGS ('dbx_business_glossary_term' = 'Document Relationship ID');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ALTER COLUMN `contract_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ALTER COLUMN `doc_production_id` SET TAGS ('dbx_business_glossary_term' = 'Production Batch ID');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ALTER COLUMN `family_group_id` SET TAGS ('dbx_business_glossary_term' = 'Electronic Discovery (eDiscovery) Family Group ID');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ALTER COLUMN `ip_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Asset Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ALTER COLUMN `parent_doc_relationship_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Doc Relationship Id');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ALTER COLUMN `parent_doc_relationship_id` SET TAGS ('dbx_dbx_self_ref_fk' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Source Document ID');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ALTER COLUMN `target_legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Target Document ID');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ALTER COLUMN `attachment_type` SET TAGS ('dbx_business_glossary_term' = 'Attachment Type');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ALTER COLUMN `attachment_type` SET TAGS ('dbx_value_regex' = 'email_attachment|embedded_object|linked_file|exhibit_attachment');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ALTER COLUMN `bates_range_end` SET TAGS ('dbx_business_glossary_term' = 'Bates Range End Number');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ALTER COLUMN `bates_range_start` SET TAGS ('dbx_business_glossary_term' = 'Bates Range Start Number');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ALTER COLUMN `chain_of_custody_verified` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody Verified Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted|highly_confidential');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Effective Date');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship End Date');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ALTER COLUMN `exhibit_number` SET TAGS ('dbx_business_glossary_term' = 'Exhibit Number');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ALTER COLUMN `modified_by_user_code` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ALTER COLUMN `modified_by_user_code` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ALTER COLUMN `modified_by_user_code` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Relationship Notes');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ALTER COLUMN `privilege_designation` SET TAGS ('dbx_business_glossary_term' = 'Legal Professional Privilege (LPP) Designation');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ALTER COLUMN `privilege_designation` SET TAGS ('dbx_value_regex' = 'privileged|non_privileged|work_product|attorney_client|joint_defense');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ALTER COLUMN `production_flag` SET TAGS ('dbx_business_glossary_term' = 'Production Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ALTER COLUMN `relationship_basis` SET TAGS ('dbx_business_glossary_term' = 'Relationship Basis');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ALTER COLUMN `relationship_category` SET TAGS ('dbx_business_glossary_term' = 'Relationship Category');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ALTER COLUMN `relationship_category` SET TAGS ('dbx_value_regex' = 'versioning|discovery|litigation|transactional|workspace|correspondence');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ALTER COLUMN `relationship_direction` SET TAGS ('dbx_business_glossary_term' = 'Relationship Direction');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ALTER COLUMN `relationship_direction` SET TAGS ('dbx_value_regex' = 'unidirectional|bidirectional');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ALTER COLUMN `relationship_hash` SET TAGS ('dbx_business_glossary_term' = 'Relationship Hash Value');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ALTER COLUMN `relationship_source_system` SET TAGS ('dbx_business_glossary_term' = 'Relationship Source System');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ALTER COLUMN `relationship_source_system` SET TAGS ('dbx_value_regex' = 'imanage|netdocuments|relativity|manual|automated');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ALTER COLUMN `relationship_status` SET TAGS ('dbx_business_glossary_term' = 'Relationship Status');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ALTER COLUMN `relationship_status` SET TAGS ('dbx_value_regex' = 'active|inactive|superseded|archived');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Relationship Type');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Relationship Sequence Number');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ALTER COLUMN `target_legal_document` SET TAGS ('dbx_business_glossary_term' = 'Target Legal Document');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ALTER COLUMN `thread_position` SET TAGS ('dbx_business_glossary_term' = 'Email Thread Position');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ALTER COLUMN `version_sequence` SET TAGS ('dbx_business_glossary_term' = 'Version Sequence Number');
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ALTER COLUMN `workspace_code` SET TAGS ('dbx_business_glossary_term' = 'Document Management System (DMS) Workspace ID');
ALTER TABLE `legal_ecm_v1`.`document`.`custodian_hold` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `legal_ecm_v1`.`document`.`custodian_hold` ALTER COLUMN `custodian_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Hold Assignment Identifier');
ALTER TABLE `legal_ecm_v1`.`document`.`custodian_hold` ALTER COLUMN `esi_custodian_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Hold - Esi Custodian Id');
ALTER TABLE `legal_ecm_v1`.`document`.`custodian_hold` ALTER COLUMN `legal_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Hold - Legal Hold Id');
ALTER TABLE `legal_ecm_v1`.`document`.`custodian_hold` ALTER COLUMN `acknowledgement_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Acknowledgement Date');
ALTER TABLE `legal_ecm_v1`.`document`.`custodian_hold` ALTER COLUMN `acknowledgement_status` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Status');
ALTER TABLE `legal_ecm_v1`.`document`.`custodian_hold` ALTER COLUMN `collection_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Collection Completion Date');
ALTER TABLE `legal_ecm_v1`.`document`.`custodian_hold` ALTER COLUMN `collection_custodian_notes` SET TAGS ('dbx_business_glossary_term' = 'Collection Custodian Notes');
ALTER TABLE `legal_ecm_v1`.`document`.`custodian_hold` ALTER COLUMN `collection_custodian_notes` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`custodian_hold` ALTER COLUMN `collection_file_count` SET TAGS ('dbx_business_glossary_term' = 'Collection File Count');
ALTER TABLE `legal_ecm_v1`.`document`.`custodian_hold` ALTER COLUMN `collection_method` SET TAGS ('dbx_business_glossary_term' = 'Collection Method');
ALTER TABLE `legal_ecm_v1`.`document`.`custodian_hold` ALTER COLUMN `collection_notes` SET TAGS ('dbx_business_glossary_term' = 'Collection Notes');
ALTER TABLE `legal_ecm_v1`.`document`.`custodian_hold` ALTER COLUMN `collection_start_date` SET TAGS ('dbx_business_glossary_term' = 'Collection Start Date');
ALTER TABLE `legal_ecm_v1`.`document`.`custodian_hold` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Status');
ALTER TABLE `legal_ecm_v1`.`document`.`custodian_hold` ALTER COLUMN `collection_volume_gb` SET TAGS ('dbx_business_glossary_term' = 'Collection Volume');
ALTER TABLE `legal_ecm_v1`.`document`.`custodian_hold` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`custodian_hold` ALTER COLUMN `custodian_interview_date` SET TAGS ('dbx_business_glossary_term' = 'Custodian Interview Date');
ALTER TABLE `legal_ecm_v1`.`document`.`custodian_hold` ALTER COLUMN `custodian_interview_notes` SET TAGS ('dbx_business_glossary_term' = 'Custodian Interview Notes');
ALTER TABLE `legal_ecm_v1`.`document`.`custodian_hold` ALTER COLUMN `custodian_interview_notes` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`custodian_hold` ALTER COLUMN `custodian_status` SET TAGS ('dbx_business_glossary_term' = 'Custodian Hold Status');
ALTER TABLE `legal_ecm_v1`.`document`.`custodian_hold` ALTER COLUMN `escalation_count` SET TAGS ('dbx_business_glossary_term' = 'Escalation Count');
ALTER TABLE `legal_ecm_v1`.`document`.`custodian_hold` ALTER COLUMN `exemption_reason` SET TAGS ('dbx_business_glossary_term' = 'Exemption Reason');
ALTER TABLE `legal_ecm_v1`.`document`.`custodian_hold` ALTER COLUMN `interview_date` SET TAGS ('dbx_business_glossary_term' = 'Custodian Interview Date');
ALTER TABLE `legal_ecm_v1`.`document`.`custodian_hold` ALTER COLUMN `interview_notes` SET TAGS ('dbx_business_glossary_term' = 'Custodian Interview Notes');
ALTER TABLE `legal_ecm_v1`.`document`.`custodian_hold` ALTER COLUMN `interview_notes` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`custodian_hold` ALTER COLUMN `issued_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Issued Date');
ALTER TABLE `legal_ecm_v1`.`document`.`custodian_hold` ALTER COLUMN `last_reminder_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reminder Date');
ALTER TABLE `legal_ecm_v1`.`document`.`custodian_hold` ALTER COLUMN `legal_hold_acknowledgement_status` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Acknowledgement Status');
ALTER TABLE `legal_ecm_v1`.`document`.`custodian_hold` ALTER COLUMN `legal_hold_acknowledgement_status` SET TAGS ('dbx_value_regex' = 'pending|acknowledged|declined|overdue');
ALTER TABLE `legal_ecm_v1`.`document`.`custodian_hold` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`custodian_hold` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Release Date');
ALTER TABLE `legal_ecm_v1`.`document`.`custodian_hold` ALTER COLUMN `reminder_count` SET TAGS ('dbx_business_glossary_term' = 'Reminder Count');
ALTER TABLE `legal_ecm_v1`.`document`.`production_source` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `legal_ecm_v1`.`document`.`production_source` ALTER COLUMN `production_source_id` SET TAGS ('dbx_business_glossary_term' = 'Production Source Identifier');
ALTER TABLE `legal_ecm_v1`.`document`.`production_source` ALTER COLUMN `doc_production_id` SET TAGS ('dbx_business_glossary_term' = 'Production Source - Doc Production Id');
ALTER TABLE `legal_ecm_v1`.`document`.`production_source` ALTER COLUMN `esi_collection_id` SET TAGS ('dbx_business_glossary_term' = 'Production Source - Esi Collection Id');
ALTER TABLE `legal_ecm_v1`.`document`.`production_source` ALTER COLUMN `bates_range_end` SET TAGS ('dbx_business_glossary_term' = 'Bates Range End for Collection Subset');
ALTER TABLE `legal_ecm_v1`.`document`.`production_source` ALTER COLUMN `bates_range_start` SET TAGS ('dbx_business_glossary_term' = 'Bates Range Start for Collection Subset');
ALTER TABLE `legal_ecm_v1`.`document`.`production_source` ALTER COLUMN `collection_subset_filter` SET TAGS ('dbx_business_glossary_term' = 'Collection Subset Filter Criteria');
ALTER TABLE `legal_ecm_v1`.`document`.`production_source` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Source Mapping Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`production_source` ALTER COLUMN `document_count_from_collection` SET TAGS ('dbx_business_glossary_term' = 'Document Count from Collection');
ALTER TABLE `legal_ecm_v1`.`document`.`production_source` ALTER COLUMN `inclusion_reason` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Reason');
ALTER TABLE `legal_ecm_v1`.`document`.`production_source` ALTER COLUMN `production_date` SET TAGS ('dbx_business_glossary_term' = 'Production Date for Collection Subset');
ALTER TABLE `legal_ecm_v1`.`document`.`production_source` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Source Mapping Created By');
ALTER TABLE `legal_ecm_v1`.`document`.`template_clause_usage` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `legal_ecm_v1`.`document`.`template_clause_usage` ALTER COLUMN `template_clause_usage_id` SET TAGS ('dbx_business_glossary_term' = 'Template Clause Usage Identifier');
ALTER TABLE `legal_ecm_v1`.`document`.`template_clause_usage` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Added By Timekeeper');
ALTER TABLE `legal_ecm_v1`.`document`.`template_clause_usage` ALTER COLUMN `clause_id` SET TAGS ('dbx_business_glossary_term' = 'Template Clause Usage - Knowledge Clause Library Id');
ALTER TABLE `legal_ecm_v1`.`document`.`template_clause_usage` ALTER COLUMN `doc_template_id` SET TAGS ('dbx_business_glossary_term' = 'Template Clause Usage - Doc Template Id');
ALTER TABLE `legal_ecm_v1`.`document`.`template_clause_usage` ALTER COLUMN `added_date` SET TAGS ('dbx_business_glossary_term' = 'Date Added');
ALTER TABLE `legal_ecm_v1`.`document`.`template_clause_usage` ALTER COLUMN `clause_library_references` SET TAGS ('dbx_business_glossary_term' = 'Clause Library References');
ALTER TABLE `legal_ecm_v1`.`document`.`template_clause_usage` ALTER COLUMN `clause_position_in_template` SET TAGS ('dbx_business_glossary_term' = 'Clause Position');
ALTER TABLE `legal_ecm_v1`.`document`.`template_clause_usage` ALTER COLUMN `clause_variant_selected` SET TAGS ('dbx_business_glossary_term' = 'Clause Variant');
ALTER TABLE `legal_ecm_v1`.`document`.`template_clause_usage` ALTER COLUMN `customization_notes` SET TAGS ('dbx_business_glossary_term' = 'Customization Notes');
ALTER TABLE `legal_ecm_v1`.`document`.`template_clause_usage` ALTER COLUMN `last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Date');
ALTER TABLE `legal_ecm_v1`.`document`.`template_clause_usage` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Clause Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`template_clause_usage` ALTER COLUMN `section_heading` SET TAGS ('dbx_business_glossary_term' = 'Section Heading');
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ALTER COLUMN `review_set_id` SET TAGS ('dbx_business_glossary_term' = 'Review Set Identifier');
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ALTER COLUMN `legal_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Id');
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Id');
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ALTER COLUMN `parent_review_set_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Review Set Id');
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ALTER COLUMN `parent_review_set_id` SET TAGS ('dbx_dbx_self_ref_fk' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy Id');
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ALTER COLUMN `production_set_id` SET TAGS ('dbx_business_glossary_term' = 'Production Set Id');
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ALTER COLUMN `user_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Id');
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ALTER COLUMN `user_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ALTER COLUMN `user_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ALTER COLUMN `review_modified_by_user_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Id');
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ALTER COLUMN `review_modified_by_user_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ALTER COLUMN `review_modified_by_user_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ALTER COLUMN `tar_model_id` SET TAGS ('dbx_business_glossary_term' = 'Tar Model Id');
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ALTER COLUMN `assigned_reviewer_count` SET TAGS ('dbx_business_glossary_term' = 'Assigned Reviewer Count');
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ALTER COLUMN `chain_of_custody_verified` SET TAGS ('dbx_business_glossary_term' = 'Chain Of Custody Verified');
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ALTER COLUMN `completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completed Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ALTER COLUMN `confidentiality_designation` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Designation');
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ALTER COLUMN `custodian_count` SET TAGS ('dbx_business_glossary_term' = 'Custodian Count');
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ALTER COLUMN `date_range_end` SET TAGS ('dbx_business_glossary_term' = 'Date Range End');
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ALTER COLUMN `date_range_start` SET TAGS ('dbx_business_glossary_term' = 'Date Range Start');
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ALTER COLUMN `deduplication_applied` SET TAGS ('dbx_business_glossary_term' = 'Deduplication Applied');
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ALTER COLUMN `review_set_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ALTER COLUMN `document_count` SET TAGS ('dbx_business_glossary_term' = 'Document Count');
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ALTER COLUMN `email_threading_applied` SET TAGS ('dbx_business_glossary_term' = 'Email Threading Applied');
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ALTER COLUMN `email_threading_applied` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ALTER COLUMN `near_duplicate_identification_applied` SET TAGS ('dbx_business_glossary_term' = 'Near Duplicate Identification Applied');
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ALTER COLUMN `nlp_processing_applied` SET TAGS ('dbx_business_glossary_term' = 'Nlp Processing Applied');
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ALTER COLUMN `ocr_applied` SET TAGS ('dbx_business_glossary_term' = 'Ocr Applied');
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ALTER COLUMN `privileged_document_count` SET TAGS ('dbx_business_glossary_term' = 'Privileged Document Count');
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ALTER COLUMN `quality_control_accuracy_rate` SET TAGS ('dbx_business_glossary_term' = 'Quality Control Accuracy Rate');
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ALTER COLUMN `quality_control_sample_size` SET TAGS ('dbx_business_glossary_term' = 'Quality Control Sample Size');
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ALTER COLUMN `responsive_document_count` SET TAGS ('dbx_business_glossary_term' = 'Responsive Document Count');
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ALTER COLUMN `review_methodology` SET TAGS ('dbx_business_glossary_term' = 'Review Methodology');
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ALTER COLUMN `review_platform` SET TAGS ('dbx_business_glossary_term' = 'Review Platform');
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ALTER COLUMN `review_set_code` SET TAGS ('dbx_business_glossary_term' = 'Review Set Code');
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ALTER COLUMN `review_set_name` SET TAGS ('dbx_business_glossary_term' = 'Review Set Name');
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Review Type');
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ALTER COLUMN `reviewed_document_count` SET TAGS ('dbx_business_glossary_term' = 'Reviewed Document Count');
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ALTER COLUMN `search_terms_applied` SET TAGS ('dbx_business_glossary_term' = 'Search Terms Applied');
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ALTER COLUMN `tar_precision_score` SET TAGS ('dbx_business_glossary_term' = 'Tar Precision Score');
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ALTER COLUMN `tar_recall_score` SET TAGS ('dbx_business_glossary_term' = 'Tar Recall Score');
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ALTER COLUMN `total_page_count` SET TAGS ('dbx_business_glossary_term' = 'Total Page Count');
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ALTER COLUMN `total_size_gb` SET TAGS ('dbx_business_glossary_term' = 'Total Size Gb');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `review_session_id` SET TAGS ('dbx_business_glossary_term' = 'Review Session Identifier');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Attorney Profile Id');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Id');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `prior_review_session_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Review Session Id');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `prior_review_session_id` SET TAGS ('dbx_dbx_self_ref_fk' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `user_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Id');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `user_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `user_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `review_modified_by_user_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Id');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `review_modified_by_user_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `review_modified_by_user_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `review_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `review_set_id` SET TAGS ('dbx_business_glossary_term' = 'Document Set Id');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `workspace_id` SET TAGS ('dbx_business_glossary_term' = 'Workspace Id');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `actual_cost` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `average_review_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Average Review Time Seconds');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `coding_layout_name` SET TAGS ('dbx_business_glossary_term' = 'Coding Layout Name');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `custodian_filter` SET TAGS ('dbx_business_glossary_term' = 'Custodian Filter');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `date_range_filter_end` SET TAGS ('dbx_business_glossary_term' = 'Date Range Filter End');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `date_range_filter_start` SET TAGS ('dbx_business_glossary_term' = 'Date Range Filter Start');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `documents_pending` SET TAGS ('dbx_business_glossary_term' = 'Documents Pending');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `documents_reviewed` SET TAGS ('dbx_business_glossary_term' = 'Documents Reviewed');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `hot_document_count` SET TAGS ('dbx_business_glossary_term' = 'Hot Document Count');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `is_billable` SET TAGS ('dbx_business_glossary_term' = 'Is Billable');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `non_responsive_document_count` SET TAGS ('dbx_business_glossary_term' = 'Non Responsive Document Count');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `privilege_designation_count` SET TAGS ('dbx_business_glossary_term' = 'Privilege Designation Count');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `quality_control_error_rate` SET TAGS ('dbx_business_glossary_term' = 'Quality Control Error Rate');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `quality_control_sample_size` SET TAGS ('dbx_business_glossary_term' = 'Quality Control Sample Size');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `redaction_required_count` SET TAGS ('dbx_business_glossary_term' = 'Redaction Required Count');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `responsive_document_count` SET TAGS ('dbx_business_glossary_term' = 'Responsive Document Count');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `review_completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Percentage');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `review_platform` SET TAGS ('dbx_business_glossary_term' = 'Review Platform');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `review_protocol` SET TAGS ('dbx_business_glossary_term' = 'Review Protocol');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `scheduled_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `scheduled_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `search_terms_applied` SET TAGS ('dbx_business_glossary_term' = 'Search Terms Applied');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `session_notes` SET TAGS ('dbx_business_glossary_term' = 'Session Notes');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `session_number` SET TAGS ('dbx_business_glossary_term' = 'Session Number');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `session_type` SET TAGS ('dbx_business_glossary_term' = 'Session Type');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `review_session_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `total_documents_assigned` SET TAGS ('dbx_business_glossary_term' = 'Total Documents Assigned');
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ALTER COLUMN `total_review_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Review Hours');
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ALTER COLUMN `execution_workflow_id` SET TAGS ('dbx_business_glossary_term' = 'Execution Workflow Identifier');
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ALTER COLUMN `doc_template_id` SET TAGS ('dbx_business_glossary_term' = 'Doc Template Id');
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ALTER COLUMN `doc_type_id` SET TAGS ('dbx_business_glossary_term' = 'Document Type Id');
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ALTER COLUMN `user_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Id');
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ALTER COLUMN `user_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ALTER COLUMN `user_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ALTER COLUMN `execution_modified_by_user_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Id');
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ALTER COLUMN `execution_modified_by_user_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ALTER COLUMN `execution_modified_by_user_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ALTER COLUMN `owner_user_id` SET TAGS ('dbx_business_glossary_term' = 'Owner User Id');
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ALTER COLUMN `owner_user_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ALTER COLUMN `owner_user_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ALTER COLUMN `primary_superseding_execution_workflow_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Workflow Id');
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ALTER COLUMN `approval_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority Level');
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ALTER COLUMN `approval_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Required');
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ALTER COLUMN `audit_trail_required` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Required');
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ALTER COLUMN `chain_of_custody_required` SET TAGS ('dbx_business_glossary_term' = 'Chain Of Custody Required');
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ALTER COLUMN `effective_until_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ALTER COLUMN `escalation_threshold_days` SET TAGS ('dbx_business_glossary_term' = 'Escalation Threshold Days');
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ALTER COLUMN `execution_method` SET TAGS ('dbx_business_glossary_term' = 'Execution Method');
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ALTER COLUMN `is_default_workflow` SET TAGS ('dbx_business_glossary_term' = 'Is Default Workflow');
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ALTER COLUMN `last_used_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Used Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ALTER COLUMN `maximum_signatories` SET TAGS ('dbx_business_glossary_term' = 'Maximum Signatories');
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ALTER COLUMN `minimum_signatories` SET TAGS ('dbx_business_glossary_term' = 'Minimum Signatories');
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ALTER COLUMN `practice_area` SET TAGS ('dbx_business_glossary_term' = 'Practice Area');
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ALTER COLUMN `privilege_designation` SET TAGS ('dbx_business_glossary_term' = 'Privilege Designation');
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ALTER COLUMN `requires_notarization` SET TAGS ('dbx_business_glossary_term' = 'Requires Notarization');
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ALTER COLUMN `requires_witness` SET TAGS ('dbx_business_glossary_term' = 'Requires Witness');
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period Years');
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ALTER COLUMN `sequence_type` SET TAGS ('dbx_business_glossary_term' = 'Sequence Type');
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ALTER COLUMN `signature_platform` SET TAGS ('dbx_business_glossary_term' = 'Signature Platform');
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ALTER COLUMN `standard_turnaround_days` SET TAGS ('dbx_business_glossary_term' = 'Standard Turnaround Days');
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ALTER COLUMN `workflow_code` SET TAGS ('dbx_business_glossary_term' = 'Workflow Code');
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ALTER COLUMN `workflow_description` SET TAGS ('dbx_business_glossary_term' = 'Workflow Description');
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ALTER COLUMN `workflow_name` SET TAGS ('dbx_business_glossary_term' = 'Workflow Name');
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ALTER COLUMN `workflow_status` SET TAGS ('dbx_business_glossary_term' = 'Workflow Status');
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ALTER COLUMN `workflow_type` SET TAGS ('dbx_business_glossary_term' = 'Workflow Type');
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ALTER COLUMN `workspace_id` SET TAGS ('dbx_business_glossary_term' = 'Workspace Identifier');
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Id');
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Attorney Attorney Profile Id');
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ALTER COLUMN `owner_attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Attorney Profile Id');
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ALTER COLUMN `user_id` SET TAGS ('dbx_business_glossary_term' = 'Owner User Id');
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ALTER COLUMN `user_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ALTER COLUMN `user_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ALTER COLUMN `parent_workspace_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Workspace Id');
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ALTER COLUMN `parent_workspace_id` SET TAGS ('dbx_dbx_self_ref_fk' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Profile Id');
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ALTER COLUMN `retention_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Schedule Id');
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ALTER COLUMN `workspace_created_by_user_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Id');
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ALTER COLUMN `workspace_created_by_user_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ALTER COLUMN `workspace_created_by_user_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ALTER COLUMN `workspace_modified_by_user_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Id');
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ALTER COLUMN `workspace_modified_by_user_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ALTER COLUMN `workspace_modified_by_user_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ALTER COLUMN `access_control_model` SET TAGS ('dbx_business_glossary_term' = 'Access Control Model');
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ALTER COLUMN `archived_date` SET TAGS ('dbx_business_glossary_term' = 'Archived Date');
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ALTER COLUMN `billing_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Code');
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Closed Date');
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ALTER COLUMN `conflict_check_date` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Date');
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ALTER COLUMN `conflict_check_status` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Status');
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ALTER COLUMN `workspace_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ALTER COLUMN `destruction_eligible_date` SET TAGS ('dbx_business_glossary_term' = 'Destruction Eligible Date');
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ALTER COLUMN `document_management_system` SET TAGS ('dbx_business_glossary_term' = 'Document Management System');
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ALTER COLUMN `encryption_enabled` SET TAGS ('dbx_business_glossary_term' = 'Encryption Enabled');
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ALTER COLUMN `external_collaboration_enabled` SET TAGS ('dbx_business_glossary_term' = 'External Collaboration Enabled');
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ALTER COLUMN `external_system_code` SET TAGS ('dbx_business_glossary_term' = 'External System Code');
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ALTER COLUMN `last_accessed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Accessed Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ALTER COLUMN `litigation_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Litigation Hold Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ALTER COLUMN `workspace_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ALTER COLUMN `opened_date` SET TAGS ('dbx_business_glossary_term' = 'Opened Date');
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ALTER COLUMN `practice_area` SET TAGS ('dbx_business_glossary_term' = 'Practice Area');
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ALTER COLUMN `privilege_designation` SET TAGS ('dbx_business_glossary_term' = 'Privilege Designation');
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ALTER COLUMN `security_classification` SET TAGS ('dbx_business_glossary_term' = 'Security Classification');
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ALTER COLUMN `workspace_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ALTER COLUMN `total_document_count` SET TAGS ('dbx_business_glossary_term' = 'Total Document Count');
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ALTER COLUMN `total_storage_size_mb` SET TAGS ('dbx_business_glossary_term' = 'Total Storage Size Mb');
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ALTER COLUMN `version_control_enabled` SET TAGS ('dbx_business_glossary_term' = 'Version Control Enabled');
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ALTER COLUMN `workspace_number` SET TAGS ('dbx_business_glossary_term' = 'Workspace Number');
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ALTER COLUMN `workspace_type` SET TAGS ('dbx_business_glossary_term' = 'Workspace Type');
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` ALTER COLUMN `production_set_id` SET TAGS ('dbx_business_glossary_term' = 'Production Set Identifier');
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Id');
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` ALTER COLUMN `parent_production_set_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Production Set Id');
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` ALTER COLUMN `parent_production_set_id` SET TAGS ('dbx_dbx_self_ref_fk' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` ALTER COLUMN `approving_attorney_name` SET TAGS ('dbx_business_glossary_term' = 'Approving Attorney Name');
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` ALTER COLUMN `approving_attorney_name` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` ALTER COLUMN `bates_range_end` SET TAGS ('dbx_business_glossary_term' = 'Bates Range End');
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` ALTER COLUMN `bates_range_start` SET TAGS ('dbx_business_glossary_term' = 'Bates Range Start');
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` ALTER COLUMN `confidentiality_designation` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Designation');
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` ALTER COLUMN `created_by_user` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` ALTER COLUMN `custodian_count` SET TAGS ('dbx_business_glossary_term' = 'Custodian Count');
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` ALTER COLUMN `data_source_count` SET TAGS ('dbx_business_glossary_term' = 'Data Source Count');
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` ALTER COLUMN `delivery_location` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` ALTER COLUMN `document_count` SET TAGS ('dbx_business_glossary_term' = 'Document Count');
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` ALTER COLUMN `hash` SET TAGS ('dbx_business_glossary_term' = 'Production Set Hash');
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` ALTER COLUMN `hash_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Hash Algorithm');
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` ALTER COLUMN `load_file_format` SET TAGS ('dbx_business_glossary_term' = 'Load File Format');
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` ALTER COLUMN `metadata_fields_produced` SET TAGS ('dbx_business_glossary_term' = 'Metadata Fields Produced');
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` ALTER COLUMN `native_files_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Native Files Included Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Page Count');
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` ALTER COLUMN `privilege_log_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Privilege Log Required Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` ALTER COLUMN `producing_party_name` SET TAGS ('dbx_business_glossary_term' = 'Producing Party Name');
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` ALTER COLUMN `producing_party_name` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` ALTER COLUMN `production_date` SET TAGS ('dbx_business_glossary_term' = 'Production Date');
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` ALTER COLUMN `production_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Production Deadline Date');
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` ALTER COLUMN `production_notes` SET TAGS ('dbx_business_glossary_term' = 'Production Notes');
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` ALTER COLUMN `production_protocol_version` SET TAGS ('dbx_business_glossary_term' = 'Production Protocol Version');
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` ALTER COLUMN `production_set_name` SET TAGS ('dbx_business_glossary_term' = 'Production Set Name');
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` ALTER COLUMN `production_set_number` SET TAGS ('dbx_business_glossary_term' = 'Production Set Number');
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` ALTER COLUMN `production_status` SET TAGS ('dbx_business_glossary_term' = 'Production Status');
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` ALTER COLUMN `production_type` SET TAGS ('dbx_business_glossary_term' = 'Production Type');
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` ALTER COLUMN `production_volume_number` SET TAGS ('dbx_business_glossary_term' = 'Production Volume Number');
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` ALTER COLUMN `quality_control_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Control Completed Date');
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` ALTER COLUMN `quality_control_reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Quality Control Reviewer Name');
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` ALTER COLUMN `quality_control_reviewer_name` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` ALTER COLUMN `quality_control_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Control Status');
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` ALTER COLUMN `recipient_party_name` SET TAGS ('dbx_business_glossary_term' = 'Recipient Party Name');
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` ALTER COLUMN `recipient_party_name` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` ALTER COLUMN `redaction_applied_flag` SET TAGS ('dbx_business_glossary_term' = 'Redaction Applied Flag');
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` ALTER COLUMN `total_file_size_gb` SET TAGS ('dbx_business_glossary_term' = 'Total File Size Gb');
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` ALTER COLUMN `total_production_volumes` SET TAGS ('dbx_business_glossary_term' = 'Total Production Volumes');
ALTER TABLE `legal_ecm_v1`.`document`.`family_group` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`document`.`family_group` ALTER COLUMN `family_group_id` SET TAGS ('dbx_business_glossary_term' = 'Family Group Identifier');
ALTER TABLE `legal_ecm_v1`.`document`.`family_group` ALTER COLUMN `esi_custodian_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Id');
ALTER TABLE `legal_ecm_v1`.`document`.`family_group` ALTER COLUMN `legal_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Id');
ALTER TABLE `legal_ecm_v1`.`document`.`family_group` ALTER COLUMN `master_family_group_id` SET TAGS ('dbx_business_glossary_term' = 'Master Family Group Id');
ALTER TABLE `legal_ecm_v1`.`document`.`family_group` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Id');
ALTER TABLE `legal_ecm_v1`.`document`.`family_group` ALTER COLUMN `parent_family_group_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Family Group Id');
ALTER TABLE `legal_ecm_v1`.`document`.`family_group` ALTER COLUMN `parent_family_group_id` SET TAGS ('dbx_dbx_self_ref_fk' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`family_group` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Document Id');
ALTER TABLE `legal_ecm_v1`.`document`.`family_group` ALTER COLUMN `processing_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Batch Id');
ALTER TABLE `legal_ecm_v1`.`document`.`family_group` ALTER COLUMN `production_set_id` SET TAGS ('dbx_business_glossary_term' = 'Production Set Id');
ALTER TABLE `legal_ecm_v1`.`document`.`family_group` ALTER COLUMN `attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Attachment Count');
ALTER TABLE `legal_ecm_v1`.`document`.`family_group` ALTER COLUMN `chain_of_custody_verified` SET TAGS ('dbx_business_glossary_term' = 'Chain Of Custody Verified');
ALTER TABLE `legal_ecm_v1`.`document`.`family_group` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `legal_ecm_v1`.`document`.`family_group` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`family_group` ALTER COLUMN `deduplication_status` SET TAGS ('dbx_business_glossary_term' = 'Deduplication Status');
ALTER TABLE `legal_ecm_v1`.`document`.`family_group` ALTER COLUMN `discovery_status` SET TAGS ('dbx_business_glossary_term' = 'Discovery Status');
ALTER TABLE `legal_ecm_v1`.`document`.`family_group` ALTER COLUMN `disposition_eligible_date` SET TAGS ('dbx_business_glossary_term' = 'Disposition Eligible Date');
ALTER TABLE `legal_ecm_v1`.`document`.`family_group` ALTER COLUMN `earliest_document_date` SET TAGS ('dbx_business_glossary_term' = 'Earliest Document Date');
ALTER TABLE `legal_ecm_v1`.`document`.`family_group` ALTER COLUMN `family_group_code` SET TAGS ('dbx_business_glossary_term' = 'Family Group Code');
ALTER TABLE `legal_ecm_v1`.`document`.`family_group` ALTER COLUMN `family_group_name` SET TAGS ('dbx_business_glossary_term' = 'Family Group Name');
ALTER TABLE `legal_ecm_v1`.`document`.`family_group` ALTER COLUMN `family_group_type` SET TAGS ('dbx_business_glossary_term' = 'Family Group Type');
ALTER TABLE `legal_ecm_v1`.`document`.`family_group` ALTER COLUMN `family_relationship_basis` SET TAGS ('dbx_business_glossary_term' = 'Family Relationship Basis');
ALTER TABLE `legal_ecm_v1`.`document`.`family_group` ALTER COLUMN `hash_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Hash Algorithm');
ALTER TABLE `legal_ecm_v1`.`document`.`family_group` ALTER COLUMN `hash_value` SET TAGS ('dbx_business_glossary_term' = 'Hash Value');
ALTER TABLE `legal_ecm_v1`.`document`.`family_group` ALTER COLUMN `latest_document_date` SET TAGS ('dbx_business_glossary_term' = 'Latest Document Date');
ALTER TABLE `legal_ecm_v1`.`document`.`family_group` ALTER COLUMN `legal_hold_status` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Status');
ALTER TABLE `legal_ecm_v1`.`document`.`family_group` ALTER COLUMN `member_count` SET TAGS ('dbx_business_glossary_term' = 'Member Count');
ALTER TABLE `legal_ecm_v1`.`document`.`family_group` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `legal_ecm_v1`.`document`.`family_group` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`family_group` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm_v1`.`document`.`family_group` ALTER COLUMN `privilege_designation` SET TAGS ('dbx_business_glossary_term' = 'Privilege Designation');
ALTER TABLE `legal_ecm_v1`.`document`.`family_group` ALTER COLUMN `redaction_required` SET TAGS ('dbx_business_glossary_term' = 'Redaction Required');
ALTER TABLE `legal_ecm_v1`.`document`.`family_group` ALTER COLUMN `redaction_status` SET TAGS ('dbx_business_glossary_term' = 'Redaction Status');
ALTER TABLE `legal_ecm_v1`.`document`.`family_group` ALTER COLUMN `retention_category` SET TAGS ('dbx_business_glossary_term' = 'Retention Category');
ALTER TABLE `legal_ecm_v1`.`document`.`family_group` ALTER COLUMN `retention_trigger_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Trigger Date');
ALTER TABLE `legal_ecm_v1`.`document`.`family_group` ALTER COLUMN `review_priority` SET TAGS ('dbx_business_glossary_term' = 'Review Priority');
ALTER TABLE `legal_ecm_v1`.`document`.`family_group` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `legal_ecm_v1`.`document`.`family_group` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `legal_ecm_v1`.`document`.`family_group` ALTER COLUMN `family_group_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `legal_ecm_v1`.`document`.`family_group` ALTER COLUMN `technology_assisted_review_score` SET TAGS ('dbx_business_glossary_term' = 'Technology Assisted Review Score');
ALTER TABLE `legal_ecm_v1`.`document`.`family_group` ALTER COLUMN `version_count` SET TAGS ('dbx_business_glossary_term' = 'Version Count');
ALTER TABLE `legal_ecm_v1`.`document`.`family_group` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ALTER COLUMN `review_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Review Batch Identifier');
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Team Id');
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ALTER COLUMN `parent_review_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Review Batch Id');
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ALTER COLUMN `parent_review_batch_id` SET TAGS ('dbx_dbx_self_ref_fk' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Id');
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ALTER COLUMN `review_case_matter_id` SET TAGS ('dbx_business_glossary_term' = 'Case Matter Id');
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ALTER COLUMN `user_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Id');
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ALTER COLUMN `user_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ALTER COLUMN `user_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ALTER COLUMN `review_last_modified_by_user_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Id');
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ALTER COLUMN `review_last_modified_by_user_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ALTER COLUMN `review_last_modified_by_user_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ALTER COLUMN `review_protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Review Protocol Id');
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ALTER COLUMN `tar_model_id` SET TAGS ('dbx_business_glossary_term' = 'Tar Model Id');
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ALTER COLUMN `actual_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Hours');
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ALTER COLUMN `assigned_date` SET TAGS ('dbx_business_glossary_term' = 'Assigned Date');
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ALTER COLUMN `batch_name` SET TAGS ('dbx_business_glossary_term' = 'Batch Name');
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ALTER COLUMN `batch_type` SET TAGS ('dbx_business_glossary_term' = 'Batch Type');
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ALTER COLUMN `cal_round_number` SET TAGS ('dbx_business_glossary_term' = 'Cal Round Number');
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ALTER COLUMN `custodian_list` SET TAGS ('dbx_business_glossary_term' = 'Custodian List');
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ALTER COLUMN `date_range_end` SET TAGS ('dbx_business_glossary_term' = 'Date Range End');
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ALTER COLUMN `date_range_start` SET TAGS ('dbx_business_glossary_term' = 'Date Range Start');
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ALTER COLUMN `document_count` SET TAGS ('dbx_business_glossary_term' = 'Document Count');
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ALTER COLUMN `estimated_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Hours');
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ALTER COLUMN `hot_document_count` SET TAGS ('dbx_business_glossary_term' = 'Hot Document Count');
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ALTER COLUMN `is_billable` SET TAGS ('dbx_business_glossary_term' = 'Is Billable');
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Page Count');
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ALTER COLUMN `privileged_document_count` SET TAGS ('dbx_business_glossary_term' = 'Privileged Document Count');
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ALTER COLUMN `quality_control_pass_count` SET TAGS ('dbx_business_glossary_term' = 'Quality Control Pass Count');
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ALTER COLUMN `quality_control_sample_size` SET TAGS ('dbx_business_glossary_term' = 'Quality Control Sample Size');
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ALTER COLUMN `responsive_document_count` SET TAGS ('dbx_business_glossary_term' = 'Responsive Document Count');
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ALTER COLUMN `review_platform` SET TAGS ('dbx_business_glossary_term' = 'Review Platform');
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ALTER COLUMN `review_rate_documents_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Review Rate Documents Per Hour');
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ALTER COLUMN `reviewed_document_count` SET TAGS ('dbx_business_glossary_term' = 'Reviewed Document Count');
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ALTER COLUMN `search_terms_applied` SET TAGS ('dbx_business_glossary_term' = 'Search Terms Applied');
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ALTER COLUMN `review_batch_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `legal_ecm_v1`.`document`.`production_batch` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`document`.`production_batch` ALTER COLUMN `production_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Production Batch Identifier');
ALTER TABLE `legal_ecm_v1`.`document`.`production_batch` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Id');
ALTER TABLE `legal_ecm_v1`.`document`.`production_batch` ALTER COLUMN `parent_production_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Production Batch Id');
ALTER TABLE `legal_ecm_v1`.`document`.`production_batch` ALTER COLUMN `parent_production_batch_id` SET TAGS ('dbx_dbx_self_ref_fk' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`production_batch` ALTER COLUMN `production_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Production Specification Id');
ALTER TABLE `legal_ecm_v1`.`document`.`production_batch` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm_v1`.`document`.`production_batch` ALTER COLUMN `approval_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Required');
ALTER TABLE `legal_ecm_v1`.`document`.`production_batch` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `legal_ecm_v1`.`document`.`production_batch` ALTER COLUMN `approved_by` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`production_batch` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `legal_ecm_v1`.`document`.`production_batch` ALTER COLUMN `bates_prefix` SET TAGS ('dbx_business_glossary_term' = 'Bates Prefix');
ALTER TABLE `legal_ecm_v1`.`document`.`production_batch` ALTER COLUMN `bates_range_end` SET TAGS ('dbx_business_glossary_term' = 'Bates Range End');
ALTER TABLE `legal_ecm_v1`.`document`.`production_batch` ALTER COLUMN `bates_range_start` SET TAGS ('dbx_business_glossary_term' = 'Bates Range Start');
ALTER TABLE `legal_ecm_v1`.`document`.`production_batch` ALTER COLUMN `confidentiality_designation` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Designation');
ALTER TABLE `legal_ecm_v1`.`document`.`production_batch` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`production_batch` ALTER COLUMN `custodian_count` SET TAGS ('dbx_business_glossary_term' = 'Custodian Count');
ALTER TABLE `legal_ecm_v1`.`document`.`production_batch` ALTER COLUMN `date_range_end` SET TAGS ('dbx_business_glossary_term' = 'Date Range End');
ALTER TABLE `legal_ecm_v1`.`document`.`production_batch` ALTER COLUMN `date_range_start` SET TAGS ('dbx_business_glossary_term' = 'Date Range Start');
ALTER TABLE `legal_ecm_v1`.`document`.`production_batch` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `legal_ecm_v1`.`document`.`production_batch` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `legal_ecm_v1`.`document`.`production_batch` ALTER COLUMN `document_count` SET TAGS ('dbx_business_glossary_term' = 'Document Count');
ALTER TABLE `legal_ecm_v1`.`document`.`production_batch` ALTER COLUMN `encryption_applied` SET TAGS ('dbx_business_glossary_term' = 'Encryption Applied');
ALTER TABLE `legal_ecm_v1`.`document`.`production_batch` ALTER COLUMN `encryption_method` SET TAGS ('dbx_business_glossary_term' = 'Encryption Method');
ALTER TABLE `legal_ecm_v1`.`document`.`production_batch` ALTER COLUMN `hash_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Hash Algorithm');
ALTER TABLE `legal_ecm_v1`.`document`.`production_batch` ALTER COLUMN `image_format` SET TAGS ('dbx_business_glossary_term' = 'Image Format');
ALTER TABLE `legal_ecm_v1`.`document`.`production_batch` ALTER COLUMN `load_file_format` SET TAGS ('dbx_business_glossary_term' = 'Load File Format');
ALTER TABLE `legal_ecm_v1`.`document`.`production_batch` ALTER COLUMN `media_type` SET TAGS ('dbx_business_glossary_term' = 'Media Type');
ALTER TABLE `legal_ecm_v1`.`document`.`production_batch` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`production_batch` ALTER COLUMN `native_file_count` SET TAGS ('dbx_business_glossary_term' = 'Native File Count');
ALTER TABLE `legal_ecm_v1`.`document`.`production_batch` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Page Count');
ALTER TABLE `legal_ecm_v1`.`document`.`production_batch` ALTER COLUMN `privileged_document_count` SET TAGS ('dbx_business_glossary_term' = 'Privileged Document Count');
ALTER TABLE `legal_ecm_v1`.`document`.`production_batch` ALTER COLUMN `producing_party` SET TAGS ('dbx_business_glossary_term' = 'Producing Party');
ALTER TABLE `legal_ecm_v1`.`document`.`production_batch` ALTER COLUMN `producing_party` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`production_batch` ALTER COLUMN `production_date` SET TAGS ('dbx_business_glossary_term' = 'Production Date');
ALTER TABLE `legal_ecm_v1`.`document`.`production_batch` ALTER COLUMN `production_notes` SET TAGS ('dbx_business_glossary_term' = 'Production Notes');
ALTER TABLE `legal_ecm_v1`.`document`.`production_batch` ALTER COLUMN `production_status` SET TAGS ('dbx_business_glossary_term' = 'Production Status');
ALTER TABLE `legal_ecm_v1`.`document`.`production_batch` ALTER COLUMN `production_type` SET TAGS ('dbx_business_glossary_term' = 'Production Type');
ALTER TABLE `legal_ecm_v1`.`document`.`production_batch` ALTER COLUMN `quality_control_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Control Date');
ALTER TABLE `legal_ecm_v1`.`document`.`production_batch` ALTER COLUMN `quality_control_notes` SET TAGS ('dbx_business_glossary_term' = 'Quality Control Notes');
ALTER TABLE `legal_ecm_v1`.`document`.`production_batch` ALTER COLUMN `quality_control_performed` SET TAGS ('dbx_business_glossary_term' = 'Quality Control Performed');
ALTER TABLE `legal_ecm_v1`.`document`.`production_batch` ALTER COLUMN `redacted_document_count` SET TAGS ('dbx_business_glossary_term' = 'Redacted Document Count');
ALTER TABLE `legal_ecm_v1`.`document`.`production_batch` ALTER COLUMN `requesting_party` SET TAGS ('dbx_business_glossary_term' = 'Requesting Party');
ALTER TABLE `legal_ecm_v1`.`document`.`production_batch` ALTER COLUMN `requesting_party` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`production_batch` ALTER COLUMN `review_platform` SET TAGS ('dbx_business_glossary_term' = 'Review Platform');
ALTER TABLE `legal_ecm_v1`.`document`.`production_batch` ALTER COLUMN `text_extraction_method` SET TAGS ('dbx_business_glossary_term' = 'Text Extraction Method');
ALTER TABLE `legal_ecm_v1`.`document`.`production_batch` ALTER COLUMN `total_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Total Size Bytes');
ALTER TABLE `legal_ecm_v1`.`document`.`production_batch` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `legal_ecm_v1`.`document`.`tar_model` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`document`.`tar_model` ALTER COLUMN `tar_model_id` SET TAGS ('dbx_business_glossary_term' = 'Tar Model Identifier');
ALTER TABLE `legal_ecm_v1`.`document`.`tar_model` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Id');
ALTER TABLE `legal_ecm_v1`.`document`.`tar_model` ALTER COLUMN `matter_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`tar_model` ALTER COLUMN `seed_tar_model_id` SET TAGS ('dbx_business_glossary_term' = 'Seed Tar Model Id');
ALTER TABLE `legal_ecm_v1`.`document`.`tar_model` ALTER COLUMN `seed_tar_model_id` SET TAGS ('dbx_dbx_self_ref_fk' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`tar_model` ALTER COLUMN `accuracy_score` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Score');
ALTER TABLE `legal_ecm_v1`.`document`.`tar_model` ALTER COLUMN `algorithm_type` SET TAGS ('dbx_business_glossary_term' = 'Algorithm Type');
ALTER TABLE `legal_ecm_v1`.`document`.`tar_model` ALTER COLUMN `confidence_interval` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval');
ALTER TABLE `legal_ecm_v1`.`document`.`tar_model` ALTER COLUMN `control_set_size` SET TAGS ('dbx_business_glossary_term' = 'Control Set Size');
ALTER TABLE `legal_ecm_v1`.`document`.`tar_model` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`tar_model` ALTER COLUMN `cutoff_threshold` SET TAGS ('dbx_business_glossary_term' = 'Cutoff Threshold');
ALTER TABLE `legal_ecm_v1`.`document`.`tar_model` ALTER COLUMN `defensibility_documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Defensibility Documentation Url');
ALTER TABLE `legal_ecm_v1`.`document`.`tar_model` ALTER COLUMN `defensibility_documentation_url` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`tar_model` ALTER COLUMN `deployment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deployment Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`tar_model` ALTER COLUMN `deprecation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deprecation Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`tar_model` ALTER COLUMN `documents_classified` SET TAGS ('dbx_business_glossary_term' = 'Documents Classified');
ALTER TABLE `legal_ecm_v1`.`document`.`tar_model` ALTER COLUMN `documents_reviewed` SET TAGS ('dbx_business_glossary_term' = 'Documents Reviewed');
ALTER TABLE `legal_ecm_v1`.`document`.`tar_model` ALTER COLUMN `f1_score` SET TAGS ('dbx_business_glossary_term' = 'F1 Score');
ALTER TABLE `legal_ecm_v1`.`document`.`tar_model` ALTER COLUMN `feature_engineering_approach` SET TAGS ('dbx_business_glossary_term' = 'Feature Engineering Approach');
ALTER TABLE `legal_ecm_v1`.`document`.`tar_model` ALTER COLUMN `language_support` SET TAGS ('dbx_business_glossary_term' = 'Language Support');
ALTER TABLE `legal_ecm_v1`.`document`.`tar_model` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `legal_ecm_v1`.`document`.`tar_model` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`tar_model` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`tar_model` ALTER COLUMN `last_training_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Training Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`tar_model` ALTER COLUMN `model_code` SET TAGS ('dbx_business_glossary_term' = 'Model Code');
ALTER TABLE `legal_ecm_v1`.`document`.`tar_model` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'Model Name');
ALTER TABLE `legal_ecm_v1`.`document`.`tar_model` ALTER COLUMN `model_type` SET TAGS ('dbx_business_glossary_term' = 'Model Type');
ALTER TABLE `legal_ecm_v1`.`document`.`tar_model` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `legal_ecm_v1`.`document`.`tar_model` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm_v1`.`document`.`tar_model` ALTER COLUMN `notes` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`tar_model` ALTER COLUMN `precision_score` SET TAGS ('dbx_business_glossary_term' = 'Precision Score');
ALTER TABLE `legal_ecm_v1`.`document`.`tar_model` ALTER COLUMN `privilege_detection_enabled` SET TAGS ('dbx_business_glossary_term' = 'Privilege Detection Enabled');
ALTER TABLE `legal_ecm_v1`.`document`.`tar_model` ALTER COLUMN `recall_score` SET TAGS ('dbx_business_glossary_term' = 'Recall Score');
ALTER TABLE `legal_ecm_v1`.`document`.`tar_model` ALTER COLUMN `review_platform` SET TAGS ('dbx_business_glossary_term' = 'Review Platform');
ALTER TABLE `legal_ecm_v1`.`document`.`tar_model` ALTER COLUMN `richness_estimate` SET TAGS ('dbx_business_glossary_term' = 'Richness Estimate');
ALTER TABLE `legal_ecm_v1`.`document`.`tar_model` ALTER COLUMN `seed_set_strategy` SET TAGS ('dbx_business_glossary_term' = 'Seed Set Strategy');
ALTER TABLE `legal_ecm_v1`.`document`.`tar_model` ALTER COLUMN `stabilization_achieved` SET TAGS ('dbx_business_glossary_term' = 'Stabilization Achieved');
ALTER TABLE `legal_ecm_v1`.`document`.`tar_model` ALTER COLUMN `tar_model_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `legal_ecm_v1`.`document`.`tar_model` ALTER COLUMN `training_rounds_completed` SET TAGS ('dbx_business_glossary_term' = 'Training Rounds Completed');
ALTER TABLE `legal_ecm_v1`.`document`.`tar_model` ALTER COLUMN `training_set_size` SET TAGS ('dbx_business_glossary_term' = 'Training Set Size');
ALTER TABLE `legal_ecm_v1`.`document`.`tar_model` ALTER COLUMN `validated_by` SET TAGS ('dbx_business_glossary_term' = 'Validated By');
ALTER TABLE `legal_ecm_v1`.`document`.`tar_model` ALTER COLUMN `validated_by` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`tar_model` ALTER COLUMN `validation_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Date');
ALTER TABLE `legal_ecm_v1`.`document`.`tar_model` ALTER COLUMN `validation_method` SET TAGS ('dbx_business_glossary_term' = 'Validation Method');
ALTER TABLE `legal_ecm_v1`.`document`.`tar_model` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `legal_ecm_v1`.`document`.`tar_model` ALTER COLUMN `created_by` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`review_project` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`document`.`review_project` ALTER COLUMN `review_project_id` SET TAGS ('dbx_business_glossary_term' = 'Review Project Identifier');
ALTER TABLE `legal_ecm_v1`.`document`.`review_project` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Id');
ALTER TABLE `legal_ecm_v1`.`document`.`review_project` ALTER COLUMN `matter_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`review_project` ALTER COLUMN `parent_review_project_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Review Project Id');
ALTER TABLE `legal_ecm_v1`.`document`.`review_project` ALTER COLUMN `parent_review_project_id` SET TAGS ('dbx_dbx_self_ref_fk' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`review_project` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Amount');
ALTER TABLE `legal_ecm_v1`.`document`.`review_project` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`review_project` ALTER COLUMN `chain_of_custody_maintained` SET TAGS ('dbx_business_glossary_term' = 'Chain Of Custody Maintained');
ALTER TABLE `legal_ecm_v1`.`document`.`review_project` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `legal_ecm_v1`.`document`.`review_project` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`review_project` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm_v1`.`document`.`review_project` ALTER COLUMN `custodian_count` SET TAGS ('dbx_business_glossary_term' = 'Custodian Count');
ALTER TABLE `legal_ecm_v1`.`document`.`review_project` ALTER COLUMN `data_source_count` SET TAGS ('dbx_business_glossary_term' = 'Data Source Count');
ALTER TABLE `legal_ecm_v1`.`document`.`review_project` ALTER COLUMN `deduplication_applied` SET TAGS ('dbx_business_glossary_term' = 'Deduplication Applied');
ALTER TABLE `legal_ecm_v1`.`document`.`review_project` ALTER COLUMN `email_threading_applied` SET TAGS ('dbx_business_glossary_term' = 'Email Threading Applied');
ALTER TABLE `legal_ecm_v1`.`document`.`review_project` ALTER COLUMN `email_threading_applied` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`review_project` ALTER COLUMN `estimated_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Budget Amount');
ALTER TABLE `legal_ecm_v1`.`document`.`review_project` ALTER COLUMN `estimated_budget_amount` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`review_project` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `legal_ecm_v1`.`document`.`review_project` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`review_project` ALTER COLUMN `nlp_processing_applied` SET TAGS ('dbx_business_glossary_term' = 'Nlp Processing Applied');
ALTER TABLE `legal_ecm_v1`.`document`.`review_project` ALTER COLUMN `ocr_processing_applied` SET TAGS ('dbx_business_glossary_term' = 'Ocr Processing Applied');
ALTER TABLE `legal_ecm_v1`.`document`.`review_project` ALTER COLUMN `privilege_protocol_applied` SET TAGS ('dbx_business_glossary_term' = 'Privilege Protocol Applied');
ALTER TABLE `legal_ecm_v1`.`document`.`review_project` ALTER COLUMN `privileged_document_count` SET TAGS ('dbx_business_glossary_term' = 'Privileged Document Count');
ALTER TABLE `legal_ecm_v1`.`document`.`review_project` ALTER COLUMN `production_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Production Deadline Date');
ALTER TABLE `legal_ecm_v1`.`document`.`review_project` ALTER COLUMN `production_format` SET TAGS ('dbx_business_glossary_term' = 'Production Format');
ALTER TABLE `legal_ecm_v1`.`document`.`review_project` ALTER COLUMN `project_description` SET TAGS ('dbx_business_glossary_term' = 'Project Description');
ALTER TABLE `legal_ecm_v1`.`document`.`review_project` ALTER COLUMN `project_end_date` SET TAGS ('dbx_business_glossary_term' = 'Project End Date');
ALTER TABLE `legal_ecm_v1`.`document`.`review_project` ALTER COLUMN `project_name` SET TAGS ('dbx_business_glossary_term' = 'Project Name');
ALTER TABLE `legal_ecm_v1`.`document`.`review_project` ALTER COLUMN `project_number` SET TAGS ('dbx_business_glossary_term' = 'Project Number');
ALTER TABLE `legal_ecm_v1`.`document`.`review_project` ALTER COLUMN `project_start_date` SET TAGS ('dbx_business_glossary_term' = 'Project Start Date');
ALTER TABLE `legal_ecm_v1`.`document`.`review_project` ALTER COLUMN `project_status` SET TAGS ('dbx_business_glossary_term' = 'Project Status');
ALTER TABLE `legal_ecm_v1`.`document`.`review_project` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Project Type');
ALTER TABLE `legal_ecm_v1`.`document`.`review_project` ALTER COLUMN `quality_control_percentage` SET TAGS ('dbx_business_glossary_term' = 'Quality Control Percentage');
ALTER TABLE `legal_ecm_v1`.`document`.`review_project` ALTER COLUMN `redaction_required` SET TAGS ('dbx_business_glossary_term' = 'Redaction Required');
ALTER TABLE `legal_ecm_v1`.`document`.`review_project` ALTER COLUMN `responsive_document_count` SET TAGS ('dbx_business_glossary_term' = 'Responsive Document Count');
ALTER TABLE `legal_ecm_v1`.`document`.`review_project` ALTER COLUMN `review_methodology` SET TAGS ('dbx_business_glossary_term' = 'Review Methodology');
ALTER TABLE `legal_ecm_v1`.`document`.`review_project` ALTER COLUMN `review_platform` SET TAGS ('dbx_business_glossary_term' = 'Review Platform');
ALTER TABLE `legal_ecm_v1`.`document`.`review_project` ALTER COLUMN `reviewed_document_count` SET TAGS ('dbx_business_glossary_term' = 'Reviewed Document Count');
ALTER TABLE `legal_ecm_v1`.`document`.`review_project` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `legal_ecm_v1`.`document`.`review_project` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `legal_ecm_v1`.`document`.`review_project` ALTER COLUMN `total_data_volume_gb` SET TAGS ('dbx_business_glossary_term' = 'Total Data Volume Gb');
ALTER TABLE `legal_ecm_v1`.`document`.`review_project` ALTER COLUMN `total_document_count` SET TAGS ('dbx_business_glossary_term' = 'Total Document Count');
ALTER TABLE `legal_ecm_v1`.`document`.`production_specification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`document`.`production_specification` ALTER COLUMN `production_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Production Specification Identifier');
ALTER TABLE `legal_ecm_v1`.`document`.`production_specification` ALTER COLUMN `user_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`production_specification` ALTER COLUMN `user_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`production_specification` ALTER COLUMN `parent_production_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Production Specification Id');
ALTER TABLE `legal_ecm_v1`.`document`.`production_specification` ALTER COLUMN `parent_production_specification_id` SET TAGS ('dbx_dbx_self_ref_fk' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`production_specification` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id');
ALTER TABLE `legal_ecm_v1`.`document`.`production_specification` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm_v1`.`document`.`production_specification` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `legal_ecm_v1`.`document`.`production_specification` ALTER COLUMN `bates_numbering_required` SET TAGS ('dbx_business_glossary_term' = 'Bates Numbering Required');
ALTER TABLE `legal_ecm_v1`.`document`.`production_specification` ALTER COLUMN `bates_prefix` SET TAGS ('dbx_business_glossary_term' = 'Bates Prefix');
ALTER TABLE `legal_ecm_v1`.`document`.`production_specification` ALTER COLUMN `bates_starting_number` SET TAGS ('dbx_business_glossary_term' = 'Bates Starting Number');
ALTER TABLE `legal_ecm_v1`.`document`.`production_specification` ALTER COLUMN `clawback_provision_applies` SET TAGS ('dbx_business_glossary_term' = 'Clawback Provision Applies');
ALTER TABLE `legal_ecm_v1`.`document`.`production_specification` ALTER COLUMN `confidentiality_designation` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Designation');
ALTER TABLE `legal_ecm_v1`.`document`.`production_specification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`production_specification` ALTER COLUMN `custodian_scope` SET TAGS ('dbx_business_glossary_term' = 'Custodian Scope');
ALTER TABLE `legal_ecm_v1`.`document`.`production_specification` ALTER COLUMN `date_range_end` SET TAGS ('dbx_business_glossary_term' = 'Date Range End');
ALTER TABLE `legal_ecm_v1`.`document`.`production_specification` ALTER COLUMN `date_range_start` SET TAGS ('dbx_business_glossary_term' = 'Date Range Start');
ALTER TABLE `legal_ecm_v1`.`document`.`production_specification` ALTER COLUMN `deduplication_scope` SET TAGS ('dbx_business_glossary_term' = 'Deduplication Scope');
ALTER TABLE `legal_ecm_v1`.`document`.`production_specification` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `legal_ecm_v1`.`document`.`production_specification` ALTER COLUMN `encryption_required` SET TAGS ('dbx_business_glossary_term' = 'Encryption Required');
ALTER TABLE `legal_ecm_v1`.`document`.`production_specification` ALTER COLUMN `family_relationship_preserved` SET TAGS ('dbx_business_glossary_term' = 'Family Relationship Preserved');
ALTER TABLE `legal_ecm_v1`.`document`.`production_specification` ALTER COLUMN `hash_validation_required` SET TAGS ('dbx_business_glossary_term' = 'Hash Validation Required');
ALTER TABLE `legal_ecm_v1`.`document`.`production_specification` ALTER COLUMN `load_file_format` SET TAGS ('dbx_business_glossary_term' = 'Load File Format');
ALTER TABLE `legal_ecm_v1`.`document`.`production_specification` ALTER COLUMN `metadata_fields_included` SET TAGS ('dbx_business_glossary_term' = 'Metadata Fields Included');
ALTER TABLE `legal_ecm_v1`.`document`.`production_specification` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`production_specification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm_v1`.`document`.`production_specification` ALTER COLUMN `privilege_log_required` SET TAGS ('dbx_business_glossary_term' = 'Privilege Log Required');
ALTER TABLE `legal_ecm_v1`.`document`.`production_specification` ALTER COLUMN `producing_party` SET TAGS ('dbx_business_glossary_term' = 'Producing Party');
ALTER TABLE `legal_ecm_v1`.`document`.`production_specification` ALTER COLUMN `production_cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Production Cost Estimate');
ALTER TABLE `legal_ecm_v1`.`document`.`production_specification` ALTER COLUMN `production_cost_estimate` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`production_specification` ALTER COLUMN `production_deadline` SET TAGS ('dbx_business_glossary_term' = 'Production Deadline');
ALTER TABLE `legal_ecm_v1`.`document`.`production_specification` ALTER COLUMN `production_format` SET TAGS ('dbx_business_glossary_term' = 'Production Format');
ALTER TABLE `legal_ecm_v1`.`document`.`production_specification` ALTER COLUMN `production_type` SET TAGS ('dbx_business_glossary_term' = 'Production Type');
ALTER TABLE `legal_ecm_v1`.`document`.`production_specification` ALTER COLUMN `production_volume_estimate` SET TAGS ('dbx_business_glossary_term' = 'Production Volume Estimate');
ALTER TABLE `legal_ecm_v1`.`document`.`production_specification` ALTER COLUMN `quality_control_sampling_rate` SET TAGS ('dbx_business_glossary_term' = 'Quality Control Sampling Rate');
ALTER TABLE `legal_ecm_v1`.`document`.`production_specification` ALTER COLUMN `redaction_required` SET TAGS ('dbx_business_glossary_term' = 'Redaction Required');
ALTER TABLE `legal_ecm_v1`.`document`.`production_specification` ALTER COLUMN `requesting_party` SET TAGS ('dbx_business_glossary_term' = 'Requesting Party');
ALTER TABLE `legal_ecm_v1`.`document`.`production_specification` ALTER COLUMN `rolling_production_allowed` SET TAGS ('dbx_business_glossary_term' = 'Rolling Production Allowed');
ALTER TABLE `legal_ecm_v1`.`document`.`production_specification` ALTER COLUMN `search_terms_applied` SET TAGS ('dbx_business_glossary_term' = 'Search Terms Applied');
ALTER TABLE `legal_ecm_v1`.`document`.`production_specification` ALTER COLUMN `specification_name` SET TAGS ('dbx_business_glossary_term' = 'Specification Name');
ALTER TABLE `legal_ecm_v1`.`document`.`production_specification` ALTER COLUMN `specification_number` SET TAGS ('dbx_business_glossary_term' = 'Specification Number');
ALTER TABLE `legal_ecm_v1`.`document`.`production_specification` ALTER COLUMN `specification_status` SET TAGS ('dbx_business_glossary_term' = 'Specification Status');
ALTER TABLE `legal_ecm_v1`.`document`.`production_specification` ALTER COLUMN `tar_protocol_used` SET TAGS ('dbx_business_glossary_term' = 'Tar Protocol Used');
ALTER TABLE `legal_ecm_v1`.`document`.`production_specification` ALTER COLUMN `text_extraction_method` SET TAGS ('dbx_business_glossary_term' = 'Text Extraction Method');
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` ALTER COLUMN `processing_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Batch Identifier');
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Id');
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` ALTER COLUMN `matter_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` ALTER COLUMN `parent_processing_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Processing Batch Id');
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` ALTER COLUMN `parent_processing_batch_id` SET TAGS ('dbx_dbx_self_ref_fk' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` ALTER COLUMN `user_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` ALTER COLUMN `user_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` ALTER COLUMN `processing_modified_by_user_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` ALTER COLUMN `processing_modified_by_user_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` ALTER COLUMN `processing_retention_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy Id');
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` ALTER COLUMN `tar_model_id` SET TAGS ('dbx_business_glossary_term' = 'Tar Model Id');
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` ALTER COLUMN `tar_model_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` ALTER COLUMN `batch_name` SET TAGS ('dbx_business_glossary_term' = 'Batch Name');
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` ALTER COLUMN `batch_status` SET TAGS ('dbx_business_glossary_term' = 'Batch Status');
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` ALTER COLUMN `batch_type` SET TAGS ('dbx_business_glossary_term' = 'Batch Type');
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` ALTER COLUMN `chain_of_custody_verified` SET TAGS ('dbx_business_glossary_term' = 'Chain Of Custody Verified');
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` ALTER COLUMN `deduplication_enabled` SET TAGS ('dbx_business_glossary_term' = 'Deduplication Enabled');
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` ALTER COLUMN `document_count` SET TAGS ('dbx_business_glossary_term' = 'Document Count');
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` ALTER COLUMN `extraction_method` SET TAGS ('dbx_business_glossary_term' = 'Extraction Method');
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` ALTER COLUMN `failed_document_count` SET TAGS ('dbx_business_glossary_term' = 'Failed Document Count');
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` ALTER COLUMN `hash_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Hash Algorithm');
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` ALTER COLUMN `language_detection_enabled` SET TAGS ('dbx_business_glossary_term' = 'Language Detection Enabled');
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` ALTER COLUMN `nlp_enabled` SET TAGS ('dbx_business_glossary_term' = 'Nlp Enabled');
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` ALTER COLUMN `ocr_enabled` SET TAGS ('dbx_business_glossary_term' = 'Ocr Enabled');
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` ALTER COLUMN `primary_language` SET TAGS ('dbx_business_glossary_term' = 'Primary Language');
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` ALTER COLUMN `privilege_detection_enabled` SET TAGS ('dbx_business_glossary_term' = 'Privilege Detection Enabled');
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` ALTER COLUMN `processed_document_count` SET TAGS ('dbx_business_glossary_term' = 'Processed Document Count');
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` ALTER COLUMN `processing_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Processing Duration Seconds');
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` ALTER COLUMN `processing_engine` SET TAGS ('dbx_business_glossary_term' = 'Processing Engine');
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` ALTER COLUMN `processing_notes` SET TAGS ('dbx_business_glossary_term' = 'Processing Notes');
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` ALTER COLUMN `processing_priority` SET TAGS ('dbx_business_glossary_term' = 'Processing Priority');
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` ALTER COLUMN `processing_profile` SET TAGS ('dbx_business_glossary_term' = 'Processing Profile');
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Retry Count');
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` ALTER COLUMN `scheduled_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` ALTER COLUMN `total_file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Total File Size Bytes');
ALTER TABLE `legal_ecm_v1`.`document`.`review_protocol` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`document`.`review_protocol` ALTER COLUMN `review_protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Review Protocol Identifier');
ALTER TABLE `legal_ecm_v1`.`document`.`review_protocol` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Id');
ALTER TABLE `legal_ecm_v1`.`document`.`review_protocol` ALTER COLUMN `matter_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`review_protocol` ALTER COLUMN `primary_superseded_review_protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Review Protocol Id');
ALTER TABLE `legal_ecm_v1`.`document`.`review_protocol` ALTER COLUMN `primary_superseded_review_protocol_id` SET TAGS ('dbx_dbx_self_ref_fk' = 'true');
ALTER TABLE `legal_ecm_v1`.`document`.`review_protocol` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm_v1`.`document`.`review_protocol` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `legal_ecm_v1`.`document`.`review_protocol` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `legal_ecm_v1`.`document`.`review_protocol` ALTER COLUMN `confidence_level_percent` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level Percent');
ALTER TABLE `legal_ecm_v1`.`document`.`review_protocol` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`review_protocol` ALTER COLUMN `custodian_scope` SET TAGS ('dbx_business_glossary_term' = 'Custodian Scope');
ALTER TABLE `legal_ecm_v1`.`document`.`review_protocol` ALTER COLUMN `date_range_end` SET TAGS ('dbx_business_glossary_term' = 'Date Range End');
ALTER TABLE `legal_ecm_v1`.`document`.`review_protocol` ALTER COLUMN `date_range_start` SET TAGS ('dbx_business_glossary_term' = 'Date Range Start');
ALTER TABLE `legal_ecm_v1`.`document`.`review_protocol` ALTER COLUMN `deduplication_method` SET TAGS ('dbx_business_glossary_term' = 'Deduplication Method');
ALTER TABLE `legal_ecm_v1`.`document`.`review_protocol` ALTER COLUMN `review_protocol_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `legal_ecm_v1`.`document`.`review_protocol` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `legal_ecm_v1`.`document`.`review_protocol` ALTER COLUMN `escalation_threshold_percent` SET TAGS ('dbx_business_glossary_term' = 'Escalation Threshold Percent');
ALTER TABLE `legal_ecm_v1`.`document`.`review_protocol` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `legal_ecm_v1`.`document`.`review_protocol` ALTER COLUMN `margin_of_error_percent` SET TAGS ('dbx_business_glossary_term' = 'Margin Of Error Percent');
ALTER TABLE `legal_ecm_v1`.`document`.`review_protocol` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `legal_ecm_v1`.`document`.`review_protocol` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`document`.`review_protocol` ALTER COLUMN `nlp_processing_required` SET TAGS ('dbx_business_glossary_term' = 'Nlp Processing Required');
ALTER TABLE `legal_ecm_v1`.`document`.`review_protocol` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm_v1`.`document`.`review_protocol` ALTER COLUMN `ocr_processing_required` SET TAGS ('dbx_business_glossary_term' = 'Ocr Processing Required');
ALTER TABLE `legal_ecm_v1`.`document`.`review_protocol` ALTER COLUMN `privilege_designation_required` SET TAGS ('dbx_business_glossary_term' = 'Privilege Designation Required');
ALTER TABLE `legal_ecm_v1`.`document`.`review_protocol` ALTER COLUMN `protocol_code` SET TAGS ('dbx_business_glossary_term' = 'Protocol Code');
ALTER TABLE `legal_ecm_v1`.`document`.`review_protocol` ALTER COLUMN `protocol_name` SET TAGS ('dbx_business_glossary_term' = 'Protocol Name');
ALTER TABLE `legal_ecm_v1`.`document`.`review_protocol` ALTER COLUMN `protocol_type` SET TAGS ('dbx_business_glossary_term' = 'Protocol Type');
ALTER TABLE `legal_ecm_v1`.`document`.`review_protocol` ALTER COLUMN `quality_control_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Quality Control Rate Percent');
ALTER TABLE `legal_ecm_v1`.`document`.`review_protocol` ALTER COLUMN `redaction_required` SET TAGS ('dbx_business_glossary_term' = 'Redaction Required');
ALTER TABLE `legal_ecm_v1`.`document`.`review_protocol` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period Years');
ALTER TABLE `legal_ecm_v1`.`document`.`review_protocol` ALTER COLUMN `review_objective` SET TAGS ('dbx_business_glossary_term' = 'Review Objective');
ALTER TABLE `legal_ecm_v1`.`document`.`review_protocol` ALTER COLUMN `review_platform` SET TAGS ('dbx_business_glossary_term' = 'Review Platform');
ALTER TABLE `legal_ecm_v1`.`document`.`review_protocol` ALTER COLUMN `review_rounds_planned` SET TAGS ('dbx_business_glossary_term' = 'Review Rounds Planned');
ALTER TABLE `legal_ecm_v1`.`document`.`review_protocol` ALTER COLUMN `richness_assumption_percent` SET TAGS ('dbx_business_glossary_term' = 'Richness Assumption Percent');
ALTER TABLE `legal_ecm_v1`.`document`.`review_protocol` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `legal_ecm_v1`.`document`.`review_protocol` ALTER COLUMN `sampling_method` SET TAGS ('dbx_business_glossary_term' = 'Sampling Method');
ALTER TABLE `legal_ecm_v1`.`document`.`review_protocol` ALTER COLUMN `review_protocol_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `legal_ecm_v1`.`document`.`review_protocol` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `legal_ecm_v1`.`document`.`review_protocol` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
