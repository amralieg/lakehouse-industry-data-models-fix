-- Schema for Domain: document | Business: Legal | Version: v1_mvm
-- Generated on: 2026-05-07 14:36:18

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `legal_ecm`.`document` COMMENT 'Manages the full lifecycle of all legal documents including drafting, versioning, review, execution, and records retention. Encompasses DMS metadata from iManage Work and NetDocuments, eDiscovery ESI collections via Relativity, TAR/CAL review workflows, OCR/NLP processing outputs, privilege designations, and LPP classification. Authoritative source for document provenance and chain of custody.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `legal_ecm`.`document`.`legal_document` (
    `legal_document_id` BIGINT COMMENT 'Unique identifier for the legal document. Primary key for the legal_document product.',
    `account_id` BIGINT COMMENT 'Foreign key linking to trust.trust_account. Business justification: Retainer agreements, escrow agreements, trust account opening documentation, and authorization letters are legal documents that establish or govern specific trust accounts. Required for regulatory com',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Documents operationalize firm policies: conflict check memos implement conflict of interest policy, data processing agreements implement privacy policy, fee agreements implement pricing policy. Requir',
    `contact_id` BIGINT COMMENT 'Foreign key linking to client.client_contact. Business justification: Legal correspondence, formal notices, and opinion letters are addressed to specific client contacts. DMS routing and correspondence tracking require knowing which client contact a document is directed',
    `doc_template_id` BIGINT COMMENT 'FK to document.doc_template.doc_template_id — Documents drafted from templates should reference their source template for precedent tracking, template effectiveness analytics, and knowledge management governance.',
    `indemnity_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.indemnity_policy. Business justification: Professional indemnity policy document management: the indemnity_policy record has a plain-text policy_document_reference field. The authoritative policy document stored in the DMS should be linked vi',
    `doc_folder_id` BIGINT COMMENT 'FK to document.doc_folder.doc_folder_id — Documents are organized into DMS folders/workspaces. This FK enables workspace-based retrieval, access control inheritance, and matter-workspace association.',
    `doc_type_id` BIGINT COMMENT 'FK to document.doc_type.doc_type_id — Every document has a type classification. This FK enables filtering by document type, applying retention rules, and enforcing naming conventions. Core to DMS taxonomy and retention governance.',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: Documents are work product/deliverables of specific legal services. Critical for service delivery tracking, matter costing, deliverable verification against engagement scope, and billing reconciliatio',
    `matter_id` BIGINT COMMENT 'Identifier of the matter or case to which this document is associated.',
    `organisation_id` BIGINT COMMENT 'Foreign key linking to client.organisation. Business justification: Framework agreements, master service agreements, and group-level corporate documents belong to the organisation entity directly, not a single client profile. Organisation-level document management is ',
    `primary_legal_doc_folder_id` BIGINT COMMENT 'Foreign key linking to document.doc_folder. Business justification: legal_document has folder_path: STRING and workspace_id: STRING. doc_folder represents the DMS folder hierarchy. Documents are stored IN folders (1:N relationship). Adding doc_folder_id FK normalizes ',
    `primary_legal_doc_type_id` BIGINT COMMENT 'Foreign key linking to document.doc_type. Business justification: legal_document has document_type: STRING (not an FK). doc_type is the authoritative reference table for document type classifications. This is a standard lookup relationship. Adding doc_type_id FK all',
    `retention_schedule_id` BIGINT COMMENT 'Foreign key linking to document.retention_schedule. Business justification: legal_document has retention_schedule: STRING (not an FK). retention_schedule is the authoritative reference table defining retention policies. Each document is governed by one retention schedule. Add',
    `profile_id` BIGINT COMMENT 'Identifier of the client for whom this document was created or to whom it relates.',
    `prospect_id` BIGINT COMMENT 'Foreign key linking to intake.prospect. Business justification: Pre-engagement documents (NDAs, conflict waivers, pitch materials) are executed for prospects before matter opening. legal_document.prospect_id→intake.prospect supports BD pipeline document tracking, ',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Documents are primary evidence artifacts substantiating identified risks (litigation filings, breach notices, regulatory correspondence). Risk registers require document references for audit trails, r',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Legal documents frequently implement or evidence compliance with specific regulatory obligations: engagement letters cite SRA Codes of Conduct, retainer agreements reference GDPR Article 6 lawful basi',
    `rfp_submission_id` BIGINT COMMENT 'Foreign key linking to intake.rfp_submission. Business justification: RFP response proposal documents must reference the rfp_submission they were created for, enabling proposal document version control, win/loss document analysis, and panel appointment compliance tracki',
    `to_doc_folder_id` BIGINT COMMENT 'FK to document.doc_folder.doc_folder_id — Documents are stored within DMS folder/workspace hierarchy. This FK enables the organizational container structure described in doc_folder and is essential for workspace-based access control and matte',
    `to_doc_type_id` BIGINT COMMENT 'FK to document.doc_type.doc_type_id — Every document must be classified by type. The doc_type reference table exists specifically to classify legal_document records. Without this FK, document classification, retention policy assignment, a',
    `to_retention_schedule_id` BIGINT COMMENT 'FK to document.retention_schedule.retention_schedule_id — Documents must be linked to their applicable retention policy for automated retention enforcement. Without this FK, the retention_schedule cannot govern document lifecycle as described.',
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
    `storage_location` STRING COMMENT 'Physical or logical storage path or URI where the document is stored in the DMS (e.g., iManage workspace path, NetDocuments cabinet/folder path, cloud storage URI).',
    `title` STRING COMMENT 'The title or name of the legal document as displayed in the DMS and used for identification by legal professionals.',
    `version_number` STRING COMMENT 'Version identifier for the document, tracking revisions and iterations (e.g., 1.0, 2.1, 3.0).',
    `workspace_code` STRING COMMENT 'Identifier of the DMS workspace, cabinet, or container where the document resides, used for organizational hierarchy and access control.',
    CONSTRAINT pk_legal_document PRIMARY KEY(`legal_document_id`)
) COMMENT 'Master record for every legal document managed within the firms DMS (iManage Work, NetDocuments). Captures document identity, classification, matter association, author, version lineage, LPP/privilege status, retention schedule, and chain-of-custody provenance. Serves as the authoritative SSOT for all document metadata across the document lifecycle from drafting through archival.';

CREATE OR REPLACE TABLE `legal_ecm`.`document`.`doc_version` (
    `doc_version_id` BIGINT COMMENT 'Unique identifier for this specific version of a legal document. Primary key for the document version entity. Serves as the authoritative reference for version-level tracking in Document Management System (DMS) and eDiscovery platforms.',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: Document version management is performed within a specific legal service engagement. Linking enables service-level version reporting, billing reconciliation, and privilege tracking by service type — a',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter or case to which this document version belongs. Enables matter-level document organization and retrieval for litigation, transactions, and advisory work.',
    `legal_document_id` BIGINT COMMENT 'Reference to the parent document entity. Links this version to the master document record that spans all versions. Essential for version lineage and rollback capability.',
    `to_legal_document_id` BIGINT COMMENT 'FK to document.legal_document.legal_document_id — Every version must reference its parent document. This is the most fundamental FK in the domain — without it, versions are orphaned and the version lineage described in both product descriptions canno',
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

CREATE OR REPLACE TABLE `legal_ecm`.`document`.`doc_type` (
    `doc_type_id` BIGINT COMMENT 'Unique identifier for the document type. Primary key.',
    `doc_template_id` BIGINT COMMENT 'Reference to the default document template or precedent for this document type in the knowledge management system (e.g., Thomson Reuters Practical Law template ID). Enables automated document generation.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to matter.jurisdiction. Business justification: Document types have jurisdiction-specific requirements (notarization, filing eligibility, privilege rules). doc_type.jurisdiction_scope is a plain-text denormalization. A proper FK enables automated c',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Document types are inherently scoped to practice areas (pleadings→litigation, patent filings→IP). This link drives document classification, template selection, and knowledge management by practice are',
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

CREATE OR REPLACE TABLE `legal_ecm`.`document`.`doc_folder` (
    `doc_folder_id` BIGINT COMMENT 'Unique identifier for the document folder within the Document Management System (DMS). Primary key for the doc_folder entity.',
    `data_privacy_register_id` BIGINT COMMENT 'Foreign key linking to compliance.data_privacy_register. Business justification: GDPR Article 30 records of processing: folders containing personal data must reference the data privacy register entry for that processing activity. Data privacy officers expect folders holding client',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: Document folders are organized by service engagement for access control, billing, and knowledge management. Linking enables service-level folder governance and ethical wall enforcement — a standard DM',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter this folder is associated with. Links the folder to a specific case or engagement for matter-centric document organization.',
    `organisation_id` BIGINT COMMENT 'Foreign key linking to client.organisation. Business justification: Corporate client DMS organisation requires folders at the organisation level for group-wide matters spanning multiple profiles. Large corporate clients need a single folder hierarchy across all affili',
    `parent_folder_doc_folder_id` BIGINT COMMENT 'Reference to the parent folder in the DMS hierarchy. Enables hierarchical folder structure traversal and nested workspace organization. Null for root-level folders.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Folder-level compliance policy enforcement: doc_folder has ethical_wall_flag and confidentiality_agreement_required attributes governed by specific compliance policies. Legal operations configures fol',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Workspace/folder structures align to practice areas for access control, security classification, and knowledge organization. Essential for workspace provisioning, ethical walls, and taxonomy managemen',
    `profile_id` BIGINT COMMENT 'Reference to the client this folder is associated with. Enables client-level document organization and access control.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Matter workspaces/folders are flagged for specific risks (ethical walls, sanctions exposure, high-value matters, conflict risks). Risk registers track workspace-level risk classifications to enforce a',
    `retention_schedule_id` BIGINT COMMENT 'Foreign key linking to document.retention_schedule. Business justification: DMS folders in iManage Work and NetDocuments are configured with retention policies that govern all documents within them. doc_folder has retention_policy_code (STRING) and retention_end_date, retenti',
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
    `retention_start_date` DATE COMMENT 'Date from which the retention period begins, typically the matter close date or document finalization date. Used to calculate disposition eligibility.',
    `security_classification` STRING COMMENT 'Data classification level governing access and handling requirements for all documents within this folder. Privileged designation indicates Legal Professional Privilege (LPP) protection.. Valid values are `public|internal|confidential|restricted|privileged`',
    `subfolder_count` STRING COMMENT 'Total number of immediate child folders within this folder. Used for hierarchy depth analysis and navigation optimization.',
    `sync_enabled` BOOLEAN COMMENT 'Indicates whether this folder is enabled for offline synchronization or desktop sync in the DMS client application. True when sync is enabled.',
    `total_storage_bytes` BIGINT COMMENT 'Total storage size in bytes consumed by all documents within this folder, excluding subfolders. Used for storage capacity management and billing allocation.',
    `version_control_enabled` BOOLEAN COMMENT 'Indicates whether document version control and check-in/check-out workflows are enforced for documents in this folder. True when version control is active.',
    `workspace_template_code` STRING COMMENT 'Code identifying the template used to provision this workspace or folder structure. Enables standardized folder hierarchies for matter types (e.g., M&A, Litigation, IP).',
    CONSTRAINT pk_doc_folder PRIMARY KEY(`doc_folder_id`)
) COMMENT 'Represents the DMS folder and workspace hierarchy within iManage Work and NetDocuments. Captures workspace name, matter or client association, folder path, parent folder reference for hierarchy traversal, access control group, security classification, and governance policy. Provides the organizational container structure for document storage and retrieval aligned to matter workspaces. Supports workspace provisioning automation and access inheritance rules.';

CREATE OR REPLACE TABLE `legal_ecm`.`document`.`doc_review_assignment` (
    `doc_review_assignment_id` BIGINT COMMENT 'Unique identifier for the document review assignment record. Primary key for this entity.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Document review projects assign reviewers to analyze specific agreements in M&A due diligence, contract portfolio reviews, and compliance audits. Reviewer assigned to review all amendments to Master ',
    `asset_id` BIGINT COMMENT 'Foreign key linking to ip.ip_asset. Business justification: Document review assignments in IP matters (copyright infringement, trade secret misappropriation) require direct ip_asset linkage. Existing FKs cover only patent and trademark subtypes. New ip_asset_i',
    `data_breach_incident_id` BIGINT COMMENT 'Foreign key linking to risk.data_breach_incident. Business justification: Breach response eDiscovery: when a data breach occurs, document review assignments are initiated to identify affected/privileged documents. Legal ops teams track which review batches belong to which b',
    `doc_version_id` BIGINT COMMENT 'Foreign key linking to document.doc_version. Business justification: doc_review_assignment currently has document_id FK to legal_document. Review assignments are for SPECIFIC VERSIONS (reviewer is assigned to review version 5, not the document). Adding doc_version_id',
    `esi_collection_id` BIGINT COMMENT 'Foreign key linking to document.esi_collection. Business justification: Review assignments in eDiscovery workflows (Relativity) are scoped to specific ESI collection events. A doc_review_assignment is the work product of reviewing documents gathered in an esi_collection. ',
    `ethical_wall_id` BIGINT COMMENT 'Foreign key linking to conflict.ethical_wall. Business justification: Reviewer assignments in eDiscovery must enforce ethical wall restrictions — a reviewer cannot be assigned documents from a matter where an ethical wall bars their access. Legal ops teams audit reviewe',
    `legal_hold_id` BIGINT COMMENT 'Foreign key linking to document.legal_hold. Business justification: In litigation eDiscovery workflows, review assignments are triggered by and scoped to specific legal holds. Knowing which legal hold initiated a review assignment is operationally critical for complia',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: Document review is a distinct legal service offering (first-level review, privilege review, second-level QC). Critical for service delivery tracking, resource allocation, cost management, and billing.',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to ip.license_agreement. Business justification: IP licensing dispute document review assignments must reference the specific license agreement to scope review for royalty, sublicensing, and termination issues. New license_agreement_id column enable',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter or case to which this document review assignment is associated.',
    `patent_family_id` BIGINT COMMENT 'Foreign key linking to ip.patent_family. Business justification: Patent portfolio litigation requires document review assignments at the patent family level to manage review across related patents efficiently. TAR models and review batches are often organized by pa',
    `patent_id` BIGINT COMMENT 'Foreign key linking to ip.patent. Business justification: Document review in patent litigation assigns reviewers to review documents related to specific patents in suit. Review workflow requires tracking which patent each document batch relates to for releva',
    `legal_document_id` BIGINT COMMENT 'Reference to the document being reviewed within the eDiscovery or collaborative review workflow.',
    `sla_template_id` BIGINT COMMENT 'Foreign key linking to service.sla_template. Business justification: SLA templates define turnaround commitments for document review. Linking enables SLA breach detection and reporting at the assignment level — a core legal operations KPI in managed review and eDiscove',
    `to_legal_document_id` BIGINT COMMENT 'FK to document.legal_document.legal_document_id — Review assignments must reference the document being reviewed. Without this link, the entire eDiscovery review workflow cannot function — reviewers cannot be assigned to documents.',
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

CREATE OR REPLACE TABLE `legal_ecm`.`document`.`privilege_log` (
    `privilege_log_id` BIGINT COMMENT 'Unique identifier for the privilege log entry. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Privilege logs track attorney-client communications about specific agreements during litigation or regulatory review. Log entry describes Email re: negotiation strategy for Agreement #2020-123. Esse',
    `asset_id` BIGINT COMMENT 'Foreign key linking to ip.asset. Business justification: Privilege logs in IP litigation track attorney-client communications about specific IP assets (patents in suit, trade secrets at issue). Discovery compliance requires identifying which asset each priv',
    `data_breach_incident_id` BIGINT COMMENT 'Foreign key linking to risk.data_breach_incident. Business justification: Breach investigations generate privileged communications (legal advice on breach response, remediation strategy) that must be logged in a privilege log tied to the specific incident. Regulators and op',
    `doc_review_assignment_id` BIGINT COMMENT 'Foreign key linking to document.doc_review_assignment. Business justification: A privilege designation recorded in privilege_log is the direct output of a specific doc_review_assignment. Linking privilege_log to the review assignment that generated the privilege designation prov',
    `doc_version_id` BIGINT COMMENT 'Foreign key linking to document.doc_version. Business justification: privilege_log currently has document_id FK to legal_document. Privilege designations apply to SPECIFIC VERSIONS (version 1 might be privileged, version 2 redacted and not privileged). Adding doc_versi',
    `docket_id` BIGINT COMMENT 'Foreign key linking to court.docket. Business justification: Privilege logs submitted to courts in discovery disputes require docket reference for privilege assertion tracking, challenge management, and coordination with protective orders and in camera review p',
    `esi_collection_id` BIGINT COMMENT 'Foreign key linking to document.esi_collection. Business justification: Privilege log entries in eDiscovery are generated during the review of ESI collected from custodians. Linking privilege_log to the originating esi_collection provides full chain-of-custody traceabilit',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: Privilege logs are service deliverables in discovery/litigation services. Essential for deliverable tracking, quality control, billing, and compliance with court orders. New attribute needed to link p',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to ip.license_agreement. Business justification: Privilege logs in IP licensing disputes must identify the specific license agreement at issue (attorney-client communications about royalty disputes, termination, sublicensing). Required for privilege',
    `matter_id` BIGINT COMMENT 'Reference to the matter or case to which this privilege designation applies. Links to Elite 3E matter management.',
    `legal_document_id` BIGINT COMMENT 'Reference to the document for which privilege is being asserted. Links to the document master record in the DMS (iManage Work or NetDocuments).',
    `privilege_legal_document_id` BIGINT COMMENT 'FK to document.legal_document.legal_document_id — Privilege designations are applied to specific documents. This FK enables privilege status lookup per document and privilege log generation for productions.',
    `prosecution_event_id` BIGINT COMMENT 'Foreign key linking to ip.prosecution_event. Business justification: Privilege logs in IP prosecution must reference specific prosecution events (office action responses, interviews) to support privilege assertions in inter partes reviews and patent litigation. New col',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Privilege assertions cite regulatory frameworks: LPP under PACE 1984 s.10, attorney-client privilege under state bar rules, litigation privilege under CPR Part 31. Essential for privilege log preparat',
    `to_legal_document_id` BIGINT COMMENT 'FK to document.legal_document.legal_document_id — Privilege designations must reference the document they protect. This is legally required for privilege log compilation and court submissions.',
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

CREATE OR REPLACE TABLE `legal_ecm`.`document`.`esi_collection` (
    `esi_collection_id` BIGINT COMMENT 'Unique identifier for the ESI collection event. Primary key.',
    `account_id` BIGINT COMMENT 'Foreign key linking to trust.trust_account. Business justification: eDiscovery collections in legal malpractice, fee dispute, or trust account misappropriation matters must collect trust account records as ESI. Direct link required for chain of custody documentation, ',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: eDiscovery collections in contract disputes target all ESI related to specific agreements. Collection scope defined as all documents concerning Agreement #2019-045 between Acme and Vendor X. Require',
    `assessment_id` BIGINT COMMENT 'Foreign key linking to risk.assessment. Business justification: Risk assessments determine the scope and priority of ESI collections in litigation and regulatory investigations. The assessment identifies which data sources and custodians are in scope — linking col',
    `asset_id` BIGINT COMMENT 'Foreign key linking to ip.asset. Business justification: ESI collections in IP disputes preserve documents related to specific IP assets (trade secret misappropriation evidence, patent prosecution history, trademark use evidence). Ediscovery scoping and rel',
    `data_breach_incident_id` BIGINT COMMENT 'Foreign key linking to risk.data_breach_incident. Business justification: Data breach incidents trigger forensic ESI collections of affected systems and custodians. Breach response workflows require direct linkage between the collection and the incident for ICO/regulatory n',
    `data_privacy_register_id` BIGINT COMMENT 'Foreign key linking to compliance.data_privacy_register. Business justification: GDPR Article 30 eDiscovery processing documentation: ESI collections involve systematic processing of personal data from custodians. This processing activity must be documented in the data privacy reg',
    `delivery_model_id` BIGINT COMMENT 'Foreign key linking to service.delivery_model. Business justification: ESI collections are executed under specific delivery models (in-house, LPO, vendor). Linking enables cost efficiency analysis and vendor performance reporting by delivery model — a standard legal oper',
    `docket_id` BIGINT COMMENT 'Foreign key linking to court.docket. Business justification: ESI collections performed for specific litigation matters must link to docket for discovery obligation tracking, production scope management, and chain of custody documentation required in court proce',
    `esi_custodian_id` BIGINT COMMENT 'FK to document.esi_custodian.esi_custodian_id — Collections are executed against specific custodians. This FK enables custodian-level collection tracking, volume reporting, and defensibility documentation.',
    `hold_id` BIGINT COMMENT 'Foreign key linking to matter.hold. Business justification: ESI collections are executed under specific litigation holds. Linking collection to the originating matter hold demonstrates preservation compliance and chain of custody required in discovery. esi_col',
    `legal_hold_id` BIGINT COMMENT 'Foreign key linking to document.legal_hold. Business justification: esi_collection has preservation_notice_issued: BOOLEAN and preservation_notice_date: DATE. Collections are executed in response to legal holds. One collection is triggered by one legal hold (1:N relat',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: ESI collections are billable service activities in ediscovery/litigation services. Essential for service delivery tracking, cost recovery, scope management, and vendor billing reconciliation. New attr',
    `matter_id` BIGINT COMMENT 'Identifier of the legal matter for which this ESI collection was executed.',
    `organisation_id` BIGINT COMMENT 'Foreign key linking to client.organisation. Business justification: ESI collection authorisation and chain-of-custody require identifying the client organisation whose data is being collected. collector_organization is a denormalized text field; a proper FK enables co',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: ESI collection protocols, privilege rules, and custodian scope differ by practice area (litigation vs. regulatory investigation). Practice area drives collection methodology selection and cost allocat',
    `primary_esi_custodian_id` BIGINT COMMENT 'Foreign key linking to document.esi_custodian. Business justification: esi_collection has custodian_name, custodian_email, custodian_employee_id, custodian_department (all strings, denormalized). esi_custodian is the master custodian record. One collection is FROM one cu',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: ESI collections are executed in response to litigation/investigation risks. Risk registers track collection scope, costs, and chain-of-custody risks as part of matter risk exposure assessment. Essenti',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: eDiscovery collections responding to regulatory inquiries: SRA Section 44B notice collection, ICO information notice collection, FCA skilled person review collection. Required for regulatory response ',
    `to_esi_custodian_id` BIGINT COMMENT 'FK to document.esi_custodian.esi_custodian_id — Collections are executed against specific custodians. The esi_collection description explicitly references custodian identity as a core attribute. This FK is essential for defensible collection tracki',
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

CREATE OR REPLACE TABLE `legal_ecm`.`document`.`esi_custodian` (
    `esi_custodian_id` BIGINT COMMENT 'Unique identifier for the ESI custodian record. Primary key.',
    `organisation_id` BIGINT COMMENT 'Foreign key linking to client.organisation. Business justification: E-discovery collection scoping requires identifying which client organisation the custodian belongs to. custodian_organization is a denormalized text field; a proper FK enables collection authorisatio',
    `data_breach_incident_id` BIGINT COMMENT 'Foreign key linking to risk.data_breach_incident. Business justification: In breach investigations, specific custodians are identified as data subjects or involved parties whose data was compromised. Linking custodians directly to the breach incident supports data subject n',
    `hold_id` BIGINT COMMENT 'Foreign key linking to matter.hold. Business justification: ESI custodians are identified and managed per litigation hold. Linking esi_custodian to matter.hold enables hold-specific custodian acknowledgment tracking, reminder management, and hold release proce',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: ESI custodians are identified and managed within specific legal service engagements (litigation, regulatory investigation). Linking enables service-level custodian management, cost tracking, and colle',
    `matter_id` BIGINT COMMENT 'Reference to the litigation or investigation matter for which this custodians ESI is subject to legal hold and collection.',
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

CREATE OR REPLACE TABLE `legal_ecm`.`document`.`legal_hold` (
    `legal_hold_id` BIGINT COMMENT 'Unique identifier for the legal hold notice. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Legal holds frequently target specific agreements for preservation in contract disputes, regulatory investigations, or breach litigation. Counsel must preserve all documents related to Agreement #XYZ ',
    `assessment_id` BIGINT COMMENT 'Foreign key linking to risk.assessment. Business justification: Risk assessments formally trigger legal hold decisions in litigation readiness workflows. A legal hold is issued when a risk assessment identifies litigation or regulatory exposure requiring preservat',
    `asset_id` BIGINT COMMENT 'Foreign key linking to ip.asset. Business justification: Legal holds in IP matters preserve documents related to specific IP assets (patents in suit, trade secrets at issue, trademarks in opposition). Litigation preservation obligations require asset-specif',
    `contact_id` BIGINT COMMENT 'Foreign key linking to client.client_contact. Business justification: Legal hold notices are issued to and acknowledged by specific client contacts. Hold management and compliance monitoring require tracking which client contact received the hold notice; acknowledged_co',
    `data_breach_incident_id` BIGINT COMMENT 'Foreign key linking to risk.data_breach_incident. Business justification: Data breach incidents directly trigger legal holds to preserve all breach-related communications and evidence. GDPR/regulatory breach response protocols require immediate preservation; linking the hol',
    `data_privacy_register_id` BIGINT COMMENT 'Foreign key linking to compliance.data_privacy_register. Business justification: GDPR Article 17 legal hold exemption: legal holds preserving personal data beyond retention periods require a documented lawful basis in the data privacy register. Data privacy officers must reconcile',
    `doc_template_id` BIGINT COMMENT 'Identifier of the standard legal hold notice template used to generate custodian communications for this hold. Links to knowledge management or document template repository.',
    `docket_id` BIGINT COMMENT 'Foreign key linking to court.docket. Business justification: Legal holds triggered by litigation must reference the originating docket for preservation scope definition, spoliation risk tracking, and hold release timing tied to case resolution or appeal deadlin',
    `legal_document_id` BIGINT COMMENT 'Foreign key linking to document.legal_document. Business justification: A legal hold notice is itself a legal document (the formal written notice issued to custodians). Linking legal_hold to the legal_document that represents the hold notice establishes document provenanc',
    `esi_custodian_id` BIGINT COMMENT 'FK to document.esi_custodian.esi_custodian_id — Legal holds are issued to specific custodians. This FK enables hold compliance tracking per custodian and defensible preservation documentation.',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to ip.license_agreement. Business justification: Legal holds triggered by IP licensing disputes must reference the specific license agreement to define hold scope and identify custodians with relevant communications. New column license_agreement_id ',
    `matter_id` BIGINT COMMENT 'Identifier of the matter or case for which this legal hold was issued. Links to the underlying litigation, investigation, or regulatory proceeding.',
    `organisation_id` BIGINT COMMENT 'Identifier of the external law firm managing the litigation or investigation for which this legal hold was issued. Nullable if matter is handled in-house.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Legal hold policy compliance: legal hold issuance and management is governed by the firms litigation hold compliance policy. Legal operations and risk teams require holds to reference the governing p',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Legal hold protocols, custodian scope, and regulatory requirements differ by practice area (litigation vs. regulatory vs. employment). Practice area determines hold procedures and compliance obligatio',
    `primary_legal_esi_custodian_id` BIGINT COMMENT 'FK to document.esi_custodian.esi_custodian_id — Legal holds are issued to custodians. The hold-custodian relationship is the core operational link for preservation obligations. Without it, hold compliance tracking is impossible.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Legal holds are triggered by litigation/regulatory risks and must be tracked in risk registers for compliance monitoring, spoliation risk assessment, and preservation obligation management. Critical f',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Legal holds triggered by regulatory investigations or compliance requirements: SRA investigation hold, ICO enforcement inquiry hold, FCA market abuse investigation hold. Essential for demonstrating to',
    `request_id` BIGINT COMMENT 'Foreign key linking to intake.request. Business justification: Litigation intake requests trigger legal holds (preservation obligations). Linking legal_hold.request_id→intake.request enables tracking which intake request initiated the hold, supporting spoliation ',
    `sla_template_id` BIGINT COMMENT 'Foreign key linking to service.sla_template. Business justification: SLA templates define acknowledgment response time commitments for legal holds. Linking enables SLA compliance tracking for hold acknowledgment workflows — a standard legal hold management and regulato',
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

CREATE OR REPLACE TABLE `legal_ecm`.`document`.`doc_production` (
    `doc_production_id` BIGINT COMMENT 'Unique identifier for the eDiscovery production set. Primary key for the document production record.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Document productions in contract disputes organize by agreement. Production set defined as all responsive documents related to Supply Agreement #2017-089. Required for discovery responses, regulator',
    `asset_id` BIGINT COMMENT 'Foreign key linking to ip.asset. Business justification: Document productions in IP litigation produce documents related to specific IP assets in dispute (patents asserted, trade secrets claimed, trademarks at issue). Discovery management requires tracking ',
    `billing_disbursement_id` BIGINT COMMENT 'Foreign key linking to billing.disbursement. Business justification: Document productions incur vendor costs (hosting, processing, delivery) that become billable disbursements. Essential for ediscovery cost recovery and client expense reporting in litigation matters.',
    `data_breach_incident_id` BIGINT COMMENT 'Foreign key linking to risk.data_breach_incident. Business justification: Regulatory investigations following data breaches require formal document productions to the ICO, FCA, or other authorities. Linking the production directly to the breach incident enables breach-speci',
    `data_privacy_register_id` BIGINT COMMENT 'Foreign key linking to compliance.data_privacy_register. Business justification: GDPR cross-border data transfer documentation: document productions transferring personal data to third parties (opposing counsel, regulators) require documentation in the data privacy register, espec',
    `doc_review_assignment_id` BIGINT COMMENT 'Foreign key linking to the document review assignment record representing the reviewed document being included in the production set.',
    `docket_id` BIGINT COMMENT 'Foreign key linking to court.docket. Business justification: Document productions respond to discovery requests in specific cases; docket link is mandatory for production tracking, privilege log coordination, and compliance with court-ordered discovery deadline',
    `ethical_wall_id` BIGINT COMMENT 'Foreign key linking to conflict.ethical_wall. Business justification: The actual production delivery event must independently reference the governing ethical wall for compliance audit purposes — confirming no restricted documents were produced. This is distinct from the',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Document productions are billed to clients via invoices. Linking doc_production to the invoice that covers it enables production cost reconciliation, supports invoice dispute resolution referencing sp',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to ip.license_agreement. Business justification: Document productions in IP licensing litigation/arbitration must reference the specific license agreement to scope production and prepare the privilege log. New column license_agreement_id fills the g',
    `matter_id` BIGINT COMMENT 'Reference to the litigation or regulatory matter for which this production was created.',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Production format requirements, privilege rules, and protective order templates differ by practice area (litigation vs. regulatory). Practice area drives production protocol selection — a standard lit',
    `esi_collection_id` BIGINT COMMENT 'FK to document.esi_collection.esi_collection_id — Productions are derived from collected ESI. This link provides the chain-of-custody from collection through production that is legally required for defensible eDiscovery.',
    `privilege_log_id` BIGINT COMMENT 'Foreign key linking to document.privilege_log. Business justification: doc_production already has privilege_log_included (BOOLEAN) and privilege_log_reference (STRING) attributes indicating that a privilege log accompanies the production. Replacing the string privilege_l',
    `production_set_id` BIGINT COMMENT 'Internal identifier of the production set within the eDiscovery platform (e.g., Relativity Production Set ID).',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Document productions to regulators: SRA investigation productions, ICO audit productions, FCA enforcement productions. Essential for regulatory compliance tracking, demonstrating timely response to re',
    `sla_template_id` BIGINT COMMENT 'Foreign key linking to service.sla_template. Business justification: SLA templates define production turnaround commitments and deadline obligations. Linking enables SLA compliance tracking and breach reporting for document productions — a core litigation operations an',
    `acknowledgment_date` DATE COMMENT 'Date on which the receiving party acknowledged receipt of the production.',
    `acknowledgment_received` BOOLEAN COMMENT 'Indicates whether the receiving party has acknowledged receipt of the production.',
    `bates_end_number` STRING COMMENT 'Last Bates number in the production range (e.g., DEF00012500). Marks the end of the sequential numbering for this production.. Valid values are `^[A-Z0-9_-]{1,50}$`',
    `bates_number` STRING COMMENT 'Unique Bates stamp or control number assigned to this document within this specific production set. Bates numbers are production-set-specific and belong to the inclusion relationship, not to the review assignment or production set alone.',
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
    `producing_counsel_name` STRING COMMENT 'Name of the law firm or attorney responsible for preparing and delivering this production.',
    `producing_party_name` STRING COMMENT 'Name of the party or organization producing the documents (typically the client or the law firm on behalf of the client).',
    `production_date` DATE COMMENT 'Date on which the production set was delivered to the receiving party. This is the authoritative business event timestamp for the production.',
    `production_flag` BOOLEAN COMMENT 'Indicates whether this reviewed document has been marked for inclusion and delivery in this specific production set. Belongs to the inclusion relationship because the same document may be flagged for one production but not another.',
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
    `redaction_required_flag` BOOLEAN COMMENT 'Indicates whether redaction of sensitive information is required for this document as produced in this specific production set. Redaction requirements can vary by production set depending on the receiving party and protective order terms.',
    `relativity_workspace_reference` STRING COMMENT 'Identifier of the Relativity workspace from which this production was generated. Links to the source eDiscovery platform.',
    `created_by` STRING COMMENT 'Username or identifier of the person who created this production record. Audit trail for accountability.',
    CONSTRAINT pk_doc_production PRIMARY KEY(`doc_production_id`)
) COMMENT 'Records each eDiscovery production set delivered to opposing counsel or a regulatory body via Relativity. Captures production volume, Bates number range, production format (TIFF, native, PDF), redaction applied, privilege log reference, delivery method, and receiving party. Provides the authoritative audit trail for all productions in litigation and regulatory matters.';

CREATE OR REPLACE TABLE `legal_ecm`.`document`.`retention_schedule` (
    `retention_schedule_id` BIGINT COMMENT 'Unique identifier for the retention schedule rule. Primary key.',
    `agreement_type_id` BIGINT COMMENT 'Foreign key linking to contract.agreement_type. Business justification: Retention policies are defined by agreement type per regulatory and business requirements. Employment agreements retain 7 years post-termination, NDAs 3 years post-expiration, vendor contracts 6 years',
    `doc_type_id` BIGINT COMMENT 'Foreign key linking to document.doc_type. Business justification: retention_schedule has document_type_code: STRING and document_type_name: STRING (denormalized). Retention policies are defined BY document type. One retention schedule applies to one document type (1',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to matter.jurisdiction. Business justification: Retention schedules are jurisdiction-specific regulatory requirements (GDPR, state bar rules, sector regulations). retention_schedule.jurisdiction_code is a plain-text denormalization. A proper FK ena',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Records management policy enforcement: retention schedules are approved and governed by the firms records management compliance policy. Records managers and compliance officers require this link to d',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Retention rules vary by practice area due to regulatory frameworks (litigation 7 years, tax 10 years, IP indefinite). Essential for compliance, records management, risk mitigation. New attribute neede',
    `profile_id` BIGINT COMMENT 'Foreign key linking to client.profile. Business justification: Client-specific retention overrides are an explicit modelled concept (client_specific_override attribute). Outside counsel guidelines and client agreements often specify bespoke retention periods; lin',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Retention rules directly implement regulatory mandates: SRA Code of Conduct 8.3 six-year client file retention, GDPR Article 5(1)(e) storage limitation, Limitation Act 1980 six-year limitation period.',
    `superseded_by_schedule_retention_schedule_id` BIGINT COMMENT 'Reference to the retention_schedule_id of the newer rule that replaces this one, if this schedule has been superseded. Null if still active or archived without replacement.',
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

CREATE OR REPLACE TABLE `legal_ecm`.`document`.`doc_execution` (
    `doc_execution_id` BIGINT COMMENT 'Unique identifier for the document execution record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Document execution records track signing workflow for agreements. While execution_record exists in contract domain, doc_execution tracks document-side execution events (routing, signing, notarization)',
    `asset_id` BIGINT COMMENT 'Foreign key linking to ip.asset. Business justification: Executed IP agreements (assignments, licenses, security interests) transfer or encumber specific IP assets. Transactional IP work requires tracking which assets are covered by each executed agreement ',
    `clearance_id` BIGINT COMMENT 'Foreign key linking to conflict.clearance. Business justification: Engagement letters and retainer agreements cannot be executed without prior conflict clearance. Legal operations require executed documents to be traceable to the specific clearance that authorized th',
    `contact_id` BIGINT COMMENT 'Foreign key linking to client.client_contact. Business justification: Document execution requires tracking which client contact is the authorised signatory. Contract management and execution audit trails depend on identifying the specific client contact who signed; sign',
    `disbursement_authorization_id` BIGINT COMMENT 'Foreign key linking to trust.disbursement_authorization. Business justification: Disbursement authorizations require client-signed documents. Linking doc_execution to disbursement_authorization normalizes the authorization audit trail, enabling bar regulators and internal complian',
    `doc_version_id` BIGINT COMMENT 'Foreign key linking to document.doc_version. Business justification: doc_execution has executed_document_version: STRING. Execution is tied to a SPECIFIC VERSION (parties execute version 2.0 of the contract, not the document). Adding doc_version_id FK normalizes away',
    `escrow_arrangement_id` BIGINT COMMENT 'Foreign key linking to trust.escrow_arrangement. Business justification: Escrow agreements are formally executed documents. Linking doc_execution to escrow_arrangement allows counsel and escrow agents to locate the signed escrow agreement for any arrangement, supporting cl',
    `inventor_id` BIGINT COMMENT 'Foreign key linking to ip.inventor. Business justification: Inventor declarations, oaths, and assignment documents are executed by specific inventors — a USPTO-mandated requirement. doc_execution must reference the inventor who executed the document for prosec',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: Document executions are service milestones (closing, signing ceremony, contract finalization). Required for service completion tracking, milestone billing, deliverable verification, and matter lifecyc',
    `letter_of_engagement_id` BIGINT COMMENT 'Foreign key linking to intake.letter_of_engagement. Business justification: A doc_execution record captures the formal signing of a letter of engagement. Linking doc_execution.letter_of_engagement_id→intake.letter_of_engagement directly ties execution events (date, method, si',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to ip.license_agreement. Business justification: License execution events track the signing and effectiveness of specific license agreements. Contract lifecycle management requires linking execution records to the license agreement being executed fo',
    `matter_id` BIGINT COMMENT 'Reference to the matter or case under which this document execution is performed. Links to Elite 3E matter management.',
    `order_id` BIGINT COMMENT 'Foreign key linking to matter.order. Business justification: Execution of consent orders and court-mandated agreements must be traceable to the originating court order for enforcement monitoring and compliance reporting. doc_execution has matter_id but no order',
    `ownership_id` BIGINT COMMENT 'Foreign key linking to ip.ownership. Business justification: IP assignment execution directly produces an ownership recordal. The executed assignment deed (doc_execution) must reference the resulting ownership record for USPTO/IP office recordal tracking. New c',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Execution requirements (notarization, board resolution, witness) vary by practice area (M&A vs. employment vs. IP licensing). Practice area drives execution protocol selection and compliance verificat',
    `legal_document_id` BIGINT COMMENT 'Reference to the legal document being executed. Links to the document master record in the Document Management System (DMS).',
    `profile_id` BIGINT COMMENT 'Reference to the client for whom this document is being executed.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Execution formalities satisfy regulatory requirements: notarization for Land Registry filings, witness requirements for Wills Act 1837, electronic signature compliance with eIDAS Regulation. Required ',
    `retainer_agreement_id` BIGINT COMMENT 'Foreign key linking to trust.retainer_agreement. Business justification: Law firms formally execute retainer agreements as signed documents. The doc_execution record captures the signing event; linking to retainer_agreement enables the firm to retrieve the executed retaine',
    `sla_template_id` BIGINT COMMENT 'Foreign key linking to service.sla_template. Business justification: SLA templates define turnaround commitments for document execution (e.g., 24-hour execution SLA for urgent closings). Linking enables SLA breach tracking for execution workflows — a standard transacti',
    `to_legal_document_id` BIGINT COMMENT 'FK to document.legal_document.legal_document_id — Execution events must reference the document being executed. This is the fundamental link between the signing ceremony and the document artifact.',
    `trust_disbursement_id` BIGINT COMMENT 'Foreign key linking to trust.trust_disbursement. Business justification: Executed settlement agreements, court orders, and client authorization letters directly authorize specific trust disbursements. Required for disbursement authorization audit trail, regulatory complian',
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

CREATE OR REPLACE TABLE `legal_ecm`.`document`.`doc_template` (
    `doc_template_id` BIGINT COMMENT 'Unique identifier for the document template record. Primary key.',
    `agreement_type_id` BIGINT COMMENT 'Foreign key linking to contract.agreement_type. Business justification: Document templates are designed for specific agreement types. NDA template maps to NDA agreement_type, employment agreement template to employment agreement_type. Required for template library organiz',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to matter.jurisdiction. Business justification: Legal document templates are jurisdiction-specific (governing law clauses, mandatory disclosures, filing formats). doc_template.jurisdiction is a plain-text denormalization. A proper FK enables attorn',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: Templates are created for specific service offerings (M&A closing checklist, employment termination letter). Essential for service standardization, automation, quality control, and service catalog man',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Template governance process: legal document templates must comply with firm compliance policies (e.g., AML client onboarding letter templates governed by AML policy). Legal operations managers expect ',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Templates are organized and searched by practice area in every legal knowledge management system. The denormalized practice_area plain attribute on doc_template should be replaced by this FK. Enables ',
    `tier_id` BIGINT COMMENT 'Foreign key linking to service.tier. Business justification: Service tiers govern which document templates are available to which client segments (e.g., premium tier clients access bespoke templates). Linking enables tier-based template access control and knowl',
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
    `language` STRING COMMENT 'The primary language in which the template is drafted. Critical for multi-jurisdictional firms serving clients across language boundaries.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the template record or content. Tracks template evolution and supports version control integration.',
    `last_review_date` DATE COMMENT 'Date of the most recent substantive review of the template content for legal accuracy, regulatory compliance, and alignment with current firm standards. Critical for maintaining template quality and mitigating risk.',
    `last_used_date` DATE COMMENT 'Date on which the template was most recently used to create a document. Helps identify obsolete or underutilized templates for archival.',
    `modified_by_user_code` BIGINT COMMENT 'Identifier of the user who last modified the template. Provides accountability and a contact for questions about recent changes.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next mandatory review of the template. Triggers workflow notifications to the responsible practice group to ensure templates remain current with legal and regulatory changes.',
    `owner_practice_group` STRING COMMENT 'The practice group or department responsible for maintaining, updating, and governing this template. Determines accountability for template quality and currency.',
    `page_count` STRING COMMENT 'Approximate page count of the template when rendered in standard formatting. Assists with printing, filing, and complexity assessment.',
    `precedent_references` STRING COMMENT 'References to related precedent documents, prior transactions, or exemplar work product that informed the development of this template. Supports knowledge reuse and maintains institutional memory.',
    `regulatory_compliance_notes` STRING COMMENT 'Notes on specific regulatory requirements, court rules, or compliance frameworks that this template addresses (e.g., GDPR (General Data Protection Regulation), SOX (Sarbanes-Oxley Act), FRAND (Fair Reasonable and Non-Discriminatory) terms). Critical for risk management and audit trails.',
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

CREATE OR REPLACE TABLE `legal_ecm`.`document`.`production_set` (
    `production_set_id` BIGINT COMMENT 'Primary key for production_set',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.contract_agreement. Business justification: Document production sets in contract disputes must be linked to the specific contract agreement at issue. This supports contract-specific eDiscovery reporting, privilege log generation, and production',
    `asset_id` BIGINT COMMENT 'Foreign key linking to ip.ip_asset. Business justification: IP litigation production sets are scoped to specific IP assets for proportionality and privilege log preparation. production_set currently only links to matter. New ip_asset_id column enables asset-le',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to ip.license_agreement. Business justification: Production sets in IP licensing arbitration/litigation must reference the specific license agreement to ensure complete and proportionate production. New license_agreement_id column enables licensing ',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter or case to which this production set belongs.',
    `parent_production_set_id` BIGINT COMMENT 'Self-referencing FK on production_set (parent_production_set_id)',
    `sla_template_id` BIGINT COMMENT 'Foreign key linking to service.sla_template. Business justification: SLA templates define production deadline commitments and quality control turnaround. Linking enables SLA compliance tracking for production sets — a core litigation operations and opposing counsel com',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `legal_ecm`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_doc_template_id` FOREIGN KEY (`doc_template_id`) REFERENCES `legal_ecm`.`document`.`doc_template`(`doc_template_id`);
ALTER TABLE `legal_ecm`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_doc_folder_id` FOREIGN KEY (`doc_folder_id`) REFERENCES `legal_ecm`.`document`.`doc_folder`(`doc_folder_id`);
ALTER TABLE `legal_ecm`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_doc_type_id` FOREIGN KEY (`doc_type_id`) REFERENCES `legal_ecm`.`document`.`doc_type`(`doc_type_id`);
ALTER TABLE `legal_ecm`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_primary_legal_doc_folder_id` FOREIGN KEY (`primary_legal_doc_folder_id`) REFERENCES `legal_ecm`.`document`.`doc_folder`(`doc_folder_id`);
ALTER TABLE `legal_ecm`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_primary_legal_doc_type_id` FOREIGN KEY (`primary_legal_doc_type_id`) REFERENCES `legal_ecm`.`document`.`doc_type`(`doc_type_id`);
ALTER TABLE `legal_ecm`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_retention_schedule_id` FOREIGN KEY (`retention_schedule_id`) REFERENCES `legal_ecm`.`document`.`retention_schedule`(`retention_schedule_id`);
ALTER TABLE `legal_ecm`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_to_doc_folder_id` FOREIGN KEY (`to_doc_folder_id`) REFERENCES `legal_ecm`.`document`.`doc_folder`(`doc_folder_id`);
ALTER TABLE `legal_ecm`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_to_doc_type_id` FOREIGN KEY (`to_doc_type_id`) REFERENCES `legal_ecm`.`document`.`doc_type`(`doc_type_id`);
ALTER TABLE `legal_ecm`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_to_retention_schedule_id` FOREIGN KEY (`to_retention_schedule_id`) REFERENCES `legal_ecm`.`document`.`retention_schedule`(`retention_schedule_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_version` ADD CONSTRAINT `fk_document_doc_version_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_version` ADD CONSTRAINT `fk_document_doc_version_to_legal_document_id` FOREIGN KEY (`to_legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_type` ADD CONSTRAINT `fk_document_doc_type_doc_template_id` FOREIGN KEY (`doc_template_id`) REFERENCES `legal_ecm`.`document`.`doc_template`(`doc_template_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ADD CONSTRAINT `fk_document_doc_folder_parent_folder_doc_folder_id` FOREIGN KEY (`parent_folder_doc_folder_id`) REFERENCES `legal_ecm`.`document`.`doc_folder`(`doc_folder_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ADD CONSTRAINT `fk_document_doc_folder_retention_schedule_id` FOREIGN KEY (`retention_schedule_id`) REFERENCES `legal_ecm`.`document`.`retention_schedule`(`retention_schedule_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ADD CONSTRAINT `fk_document_doc_review_assignment_doc_version_id` FOREIGN KEY (`doc_version_id`) REFERENCES `legal_ecm`.`document`.`doc_version`(`doc_version_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ADD CONSTRAINT `fk_document_doc_review_assignment_esi_collection_id` FOREIGN KEY (`esi_collection_id`) REFERENCES `legal_ecm`.`document`.`esi_collection`(`esi_collection_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ADD CONSTRAINT `fk_document_doc_review_assignment_legal_hold_id` FOREIGN KEY (`legal_hold_id`) REFERENCES `legal_ecm`.`document`.`legal_hold`(`legal_hold_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ADD CONSTRAINT `fk_document_doc_review_assignment_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ADD CONSTRAINT `fk_document_doc_review_assignment_to_legal_document_id` FOREIGN KEY (`to_legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ADD CONSTRAINT `fk_document_privilege_log_doc_review_assignment_id` FOREIGN KEY (`doc_review_assignment_id`) REFERENCES `legal_ecm`.`document`.`doc_review_assignment`(`doc_review_assignment_id`);
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ADD CONSTRAINT `fk_document_privilege_log_doc_version_id` FOREIGN KEY (`doc_version_id`) REFERENCES `legal_ecm`.`document`.`doc_version`(`doc_version_id`);
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ADD CONSTRAINT `fk_document_privilege_log_esi_collection_id` FOREIGN KEY (`esi_collection_id`) REFERENCES `legal_ecm`.`document`.`esi_collection`(`esi_collection_id`);
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ADD CONSTRAINT `fk_document_privilege_log_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ADD CONSTRAINT `fk_document_privilege_log_privilege_legal_document_id` FOREIGN KEY (`privilege_legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ADD CONSTRAINT `fk_document_privilege_log_to_legal_document_id` FOREIGN KEY (`to_legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ADD CONSTRAINT `fk_document_esi_collection_esi_custodian_id` FOREIGN KEY (`esi_custodian_id`) REFERENCES `legal_ecm`.`document`.`esi_custodian`(`esi_custodian_id`);
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ADD CONSTRAINT `fk_document_esi_collection_legal_hold_id` FOREIGN KEY (`legal_hold_id`) REFERENCES `legal_ecm`.`document`.`legal_hold`(`legal_hold_id`);
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ADD CONSTRAINT `fk_document_esi_collection_primary_esi_custodian_id` FOREIGN KEY (`primary_esi_custodian_id`) REFERENCES `legal_ecm`.`document`.`esi_custodian`(`esi_custodian_id`);
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ADD CONSTRAINT `fk_document_esi_collection_to_esi_custodian_id` FOREIGN KEY (`to_esi_custodian_id`) REFERENCES `legal_ecm`.`document`.`esi_custodian`(`esi_custodian_id`);
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_doc_template_id` FOREIGN KEY (`doc_template_id`) REFERENCES `legal_ecm`.`document`.`doc_template`(`doc_template_id`);
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_esi_custodian_id` FOREIGN KEY (`esi_custodian_id`) REFERENCES `legal_ecm`.`document`.`esi_custodian`(`esi_custodian_id`);
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_primary_legal_esi_custodian_id` FOREIGN KEY (`primary_legal_esi_custodian_id`) REFERENCES `legal_ecm`.`document`.`esi_custodian`(`esi_custodian_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_production` ADD CONSTRAINT `fk_document_doc_production_doc_review_assignment_id` FOREIGN KEY (`doc_review_assignment_id`) REFERENCES `legal_ecm`.`document`.`doc_review_assignment`(`doc_review_assignment_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_production` ADD CONSTRAINT `fk_document_doc_production_esi_collection_id` FOREIGN KEY (`esi_collection_id`) REFERENCES `legal_ecm`.`document`.`esi_collection`(`esi_collection_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_production` ADD CONSTRAINT `fk_document_doc_production_privilege_log_id` FOREIGN KEY (`privilege_log_id`) REFERENCES `legal_ecm`.`document`.`privilege_log`(`privilege_log_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_production` ADD CONSTRAINT `fk_document_doc_production_production_set_id` FOREIGN KEY (`production_set_id`) REFERENCES `legal_ecm`.`document`.`production_set`(`production_set_id`);
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ADD CONSTRAINT `fk_document_retention_schedule_doc_type_id` FOREIGN KEY (`doc_type_id`) REFERENCES `legal_ecm`.`document`.`doc_type`(`doc_type_id`);
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ADD CONSTRAINT `fk_document_retention_schedule_superseded_by_schedule_retention_schedule_id` FOREIGN KEY (`superseded_by_schedule_retention_schedule_id`) REFERENCES `legal_ecm`.`document`.`retention_schedule`(`retention_schedule_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ADD CONSTRAINT `fk_document_doc_execution_doc_version_id` FOREIGN KEY (`doc_version_id`) REFERENCES `legal_ecm`.`document`.`doc_version`(`doc_version_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ADD CONSTRAINT `fk_document_doc_execution_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ADD CONSTRAINT `fk_document_doc_execution_to_legal_document_id` FOREIGN KEY (`to_legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`document`.`production_set` ADD CONSTRAINT `fk_document_production_set_parent_production_set_id` FOREIGN KEY (`parent_production_set_id`) REFERENCES `legal_ecm`.`document`.`production_set`(`production_set_id`);

-- ========= TAGS =========
ALTER SCHEMA `legal_ecm`.`document` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `legal_ecm`.`document` SET TAGS ('dbx_domain' = 'document');
ALTER TABLE `legal_ecm`.`document`.`legal_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`document`.`legal_document` SET TAGS ('dbx_subdomain' = 'document_management');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Document ID');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Client Contact Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `indemnity_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Indemnity Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `organisation_id` SET TAGS ('dbx_business_glossary_term' = 'Organisation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `primary_legal_doc_folder_id` SET TAGS ('dbx_business_glossary_term' = 'Doc Folder Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `primary_legal_doc_type_id` SET TAGS ('dbx_business_glossary_term' = 'Doc Type Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `retention_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Schedule Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `rfp_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Rfp Submission Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `tribunal_id` SET TAGS ('dbx_business_glossary_term' = 'Tribunal Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|highly_confidential|restricted');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `contains_pii` SET TAGS ('dbx_business_glossary_term' = 'Contains Personally Identifiable Information (PII) Flag');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Document Created Date');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Document Created Timestamp');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `dms_document_reference` SET TAGS ('dbx_business_glossary_term' = 'DMS Document ID');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `dms_system` SET TAGS ('dbx_business_glossary_term' = 'Document Management System (DMS)');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `dms_system` SET TAGS ('dbx_value_regex' = 'imanage_work|netdocuments|relativity|sharepoint|other');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `document_category` SET TAGS ('dbx_business_glossary_term' = 'Document Category');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `executed_date` SET TAGS ('dbx_business_glossary_term' = 'Document Executed Date');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Document Expiration Date');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `file_extension` SET TAGS ('dbx_business_glossary_term' = 'File Extension');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `file_name` SET TAGS ('dbx_business_glossary_term' = 'File Name');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size in Bytes');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `hash_value` SET TAGS ('dbx_business_glossary_term' = 'Document Hash Value');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `is_current_version` SET TAGS ('dbx_business_glossary_term' = 'Is Current Version Flag');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Document Keywords');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `legal_document_description` SET TAGS ('dbx_business_glossary_term' = 'Document Description');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Flag');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `mime_type` SET TAGS ('dbx_business_glossary_term' = 'MIME Type');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `modified_date` SET TAGS ('dbx_business_glossary_term' = 'Document Modified Date');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Document Modified Timestamp');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `nlp_processed` SET TAGS ('dbx_business_glossary_term' = 'Natural Language Processing (NLP) Processed Flag');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `ocr_processed` SET TAGS ('dbx_business_glossary_term' = 'Optical Character Recognition (OCR) Processed Flag');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Page Count');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `privilege_status` SET TAGS ('dbx_business_glossary_term' = 'Legal Professional Privilege (LPP) Status');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `privilege_status` SET TAGS ('dbx_value_regex' = 'privileged|non_privileged|work_product|attorney_client|pending_review');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `retention_end_date` SET TAGS ('dbx_business_glossary_term' = 'Retention End Date');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'eDiscovery Review Status');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Document Title');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `legal_ecm`.`document`.`legal_document` ALTER COLUMN `workspace_code` SET TAGS ('dbx_business_glossary_term' = 'Workspace ID');
ALTER TABLE `legal_ecm`.`document`.`doc_version` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`document`.`doc_version` SET TAGS ('dbx_subdomain' = 'document_management');
ALTER TABLE `legal_ecm`.`document`.`doc_version` ALTER COLUMN `doc_version_id` SET TAGS ('dbx_business_glossary_term' = 'Document Version Identifier (ID)');
ALTER TABLE `legal_ecm`.`document`.`doc_version` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_version` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier (ID)');
ALTER TABLE `legal_ecm`.`document`.`doc_version` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Document Identifier (ID)');
ALTER TABLE `legal_ecm`.`document`.`doc_version` ALTER COLUMN `bates_number` SET TAGS ('dbx_business_glossary_term' = 'Bates Number');
ALTER TABLE `legal_ecm`.`document`.`doc_version` ALTER COLUMN `change_summary` SET TAGS ('dbx_business_glossary_term' = 'Change Summary');
ALTER TABLE `legal_ecm`.`document`.`doc_version` ALTER COLUMN `checked_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Checked In Timestamp');
ALTER TABLE `legal_ecm`.`document`.`doc_version` ALTER COLUMN `checked_out_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Checked Out Timestamp');
ALTER TABLE `legal_ecm`.`document`.`doc_version` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `legal_ecm`.`document`.`doc_version` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|highly_confidential|restricted');
ALTER TABLE `legal_ecm`.`document`.`doc_version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Version Created Timestamp');
ALTER TABLE `legal_ecm`.`document`.`doc_version` ALTER COLUMN `extracted_text` SET TAGS ('dbx_business_glossary_term' = 'Extracted Text');
ALTER TABLE `legal_ecm`.`document`.`doc_version` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `legal_ecm`.`document`.`doc_version` ALTER COLUMN `file_hash` SET TAGS ('dbx_business_glossary_term' = 'File Hash');
ALTER TABLE `legal_ecm`.`document`.`doc_version` ALTER COLUMN `file_name` SET TAGS ('dbx_business_glossary_term' = 'File Name');
ALTER TABLE `legal_ecm`.`document`.`doc_version` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size in Bytes');
ALTER TABLE `legal_ecm`.`document`.`doc_version` ALTER COLUMN `is_current_version` SET TAGS ('dbx_business_glossary_term' = 'Is Current Version Flag');
ALTER TABLE `legal_ecm`.`document`.`doc_version` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `legal_ecm`.`document`.`doc_version` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Flag');
ALTER TABLE `legal_ecm`.`document`.`doc_version` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Version Modified Timestamp');
ALTER TABLE `legal_ecm`.`document`.`doc_version` ALTER COLUMN `nlp_entities_extracted` SET TAGS ('dbx_business_glossary_term' = 'Natural Language Processing (NLP) Entities Extracted');
ALTER TABLE `legal_ecm`.`document`.`doc_version` ALTER COLUMN `ocr_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Optical Character Recognition (OCR) Confidence Score');
ALTER TABLE `legal_ecm`.`document`.`doc_version` ALTER COLUMN `ocr_engine` SET TAGS ('dbx_business_glossary_term' = 'Optical Character Recognition (OCR) Engine');
ALTER TABLE `legal_ecm`.`document`.`doc_version` ALTER COLUMN `ocr_processed_flag` SET TAGS ('dbx_business_glossary_term' = 'Optical Character Recognition (OCR) Processed Flag');
ALTER TABLE `legal_ecm`.`document`.`doc_version` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Page Count');
ALTER TABLE `legal_ecm`.`document`.`doc_version` ALTER COLUMN `privilege_designation` SET TAGS ('dbx_business_glossary_term' = 'Legal Professional Privilege (LPP) Designation');
ALTER TABLE `legal_ecm`.`document`.`doc_version` ALTER COLUMN `privilege_designation` SET TAGS ('dbx_value_regex' = 'privileged|non_privileged|work_product|pending_review');
ALTER TABLE `legal_ecm`.`document`.`doc_version` ALTER COLUMN `production_date` SET TAGS ('dbx_business_glossary_term' = 'Production Date');
ALTER TABLE `legal_ecm`.`document`.`doc_version` ALTER COLUMN `production_flag` SET TAGS ('dbx_business_glossary_term' = 'Production Flag');
ALTER TABLE `legal_ecm`.`document`.`doc_version` ALTER COLUMN `redacted_flag` SET TAGS ('dbx_business_glossary_term' = 'Redacted Flag');
ALTER TABLE `legal_ecm`.`document`.`doc_version` ALTER COLUMN `redaction_reason` SET TAGS ('dbx_business_glossary_term' = 'Redaction Reason');
ALTER TABLE `legal_ecm`.`document`.`doc_version` ALTER COLUMN `retention_category` SET TAGS ('dbx_business_glossary_term' = 'Retention Category');
ALTER TABLE `legal_ecm`.`document`.`doc_version` ALTER COLUMN `retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiry Date');
ALTER TABLE `legal_ecm`.`document`.`doc_version` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'eDiscovery Review Status');
ALTER TABLE `legal_ecm`.`document`.`doc_version` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'not_reviewed|in_review|responsive|non_responsive|privileged');
ALTER TABLE `legal_ecm`.`document`.`doc_version` ALTER COLUMN `review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Timestamp');
ALTER TABLE `legal_ecm`.`document`.`doc_version` ALTER COLUMN `storage_path` SET TAGS ('dbx_business_glossary_term' = 'Storage Path');
ALTER TABLE `legal_ecm`.`document`.`doc_version` ALTER COLUMN `storage_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`document`.`doc_version` ALTER COLUMN `tar_relevance_score` SET TAGS ('dbx_business_glossary_term' = 'Technology-Assisted Review (TAR) Relevance Score');
ALTER TABLE `legal_ecm`.`document`.`doc_version` ALTER COLUMN `version_label` SET TAGS ('dbx_business_glossary_term' = 'Version Label');
ALTER TABLE `legal_ecm`.`document`.`doc_version` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `legal_ecm`.`document`.`doc_version` ALTER COLUMN `version_status` SET TAGS ('dbx_business_glossary_term' = 'Version Status');
ALTER TABLE `legal_ecm`.`document`.`doc_version` ALTER COLUMN `word_count` SET TAGS ('dbx_business_glossary_term' = 'Word Count');
ALTER TABLE `legal_ecm`.`document`.`doc_type` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `legal_ecm`.`document`.`doc_type` SET TAGS ('dbx_subdomain' = 'document_management');
ALTER TABLE `legal_ecm`.`document`.`doc_type` ALTER COLUMN `doc_type_id` SET TAGS ('dbx_business_glossary_term' = 'Document Type Identifier (ID)');
ALTER TABLE `legal_ecm`.`document`.`doc_type` ALTER COLUMN `doc_template_id` SET TAGS ('dbx_business_glossary_term' = 'Default Template Identifier (ID)');
ALTER TABLE `legal_ecm`.`document`.`doc_type` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_type` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_type` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_type` ALTER COLUMN `approval_workflow_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow Required Flag');
ALTER TABLE `legal_ecm`.`document`.`doc_type` ALTER COLUMN `billable_activity` SET TAGS ('dbx_business_glossary_term' = 'Billable Activity Flag');
ALTER TABLE `legal_ecm`.`document`.`doc_type` ALTER COLUMN `chain_of_custody_tracking` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody Tracking Flag');
ALTER TABLE `legal_ecm`.`document`.`doc_type` ALTER COLUMN `court_filing_eligible` SET TAGS ('dbx_business_glossary_term' = 'Court Filing Eligible Flag');
ALTER TABLE `legal_ecm`.`document`.`doc_type` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`document`.`doc_type` ALTER COLUMN `default_privilege_classification` SET TAGS ('dbx_business_glossary_term' = 'Default Legal Professional Privilege (LPP) Classification');
ALTER TABLE `legal_ecm`.`document`.`doc_type` ALTER COLUMN `default_privilege_classification` SET TAGS ('dbx_value_regex' = 'privileged|work_product|confidential|public');
ALTER TABLE `legal_ecm`.`document`.`doc_type` ALTER COLUMN `dms_folder_path_template` SET TAGS ('dbx_business_glossary_term' = 'Document Management System (DMS) Folder Path Template');
ALTER TABLE `legal_ecm`.`document`.`doc_type` ALTER COLUMN `doc_type_category` SET TAGS ('dbx_business_glossary_term' = 'Document Category');
ALTER TABLE `legal_ecm`.`document`.`doc_type` ALTER COLUMN `doc_type_code` SET TAGS ('dbx_business_glossary_term' = 'Document Type Code');
ALTER TABLE `legal_ecm`.`document`.`doc_type` ALTER COLUMN `doc_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `legal_ecm`.`document`.`doc_type` ALTER COLUMN `doc_type_description` SET TAGS ('dbx_business_glossary_term' = 'Document Type Description');
ALTER TABLE `legal_ecm`.`document`.`doc_type` ALTER COLUMN `doc_type_name` SET TAGS ('dbx_business_glossary_term' = 'Document Type Name');
ALTER TABLE `legal_ecm`.`document`.`doc_type` ALTER COLUMN `doc_type_status` SET TAGS ('dbx_business_glossary_term' = 'Document Type Status');
ALTER TABLE `legal_ecm`.`document`.`doc_type` ALTER COLUMN `doc_type_status` SET TAGS ('dbx_value_regex' = 'active|deprecated|archived|under_review');
ALTER TABLE `legal_ecm`.`document`.`doc_type` ALTER COLUMN `ediscovery_reviewable` SET TAGS ('dbx_business_glossary_term' = 'eDiscovery Reviewable Flag');
ALTER TABLE `legal_ecm`.`document`.`doc_type` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `legal_ecm`.`document`.`doc_type` ALTER COLUMN `encryption_required` SET TAGS ('dbx_business_glossary_term' = 'Encryption Required Flag');
ALTER TABLE `legal_ecm`.`document`.`doc_type` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `legal_ecm`.`document`.`doc_type` ALTER COLUMN `external_sharing_allowed` SET TAGS ('dbx_business_glossary_term' = 'External Sharing Allowed Flag');
ALTER TABLE `legal_ecm`.`document`.`doc_type` ALTER COLUMN `matter_association_required` SET TAGS ('dbx_business_glossary_term' = 'Matter Association Required Flag');
ALTER TABLE `legal_ecm`.`document`.`doc_type` ALTER COLUMN `metadata_preservation_critical` SET TAGS ('dbx_business_glossary_term' = 'Metadata Preservation Critical Flag');
ALTER TABLE `legal_ecm`.`document`.`doc_type` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `legal_ecm`.`document`.`doc_type` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm`.`document`.`doc_type` ALTER COLUMN `naming_convention_pattern` SET TAGS ('dbx_business_glossary_term' = 'Document Naming Convention Pattern');
ALTER TABLE `legal_ecm`.`document`.`doc_type` ALTER COLUMN `nlp_extraction_enabled` SET TAGS ('dbx_business_glossary_term' = 'Natural Language Processing (NLP) Extraction Enabled Flag');
ALTER TABLE `legal_ecm`.`document`.`doc_type` ALTER COLUMN `ocr_required` SET TAGS ('dbx_business_glossary_term' = 'Optical Character Recognition (OCR) Required Flag');
ALTER TABLE `legal_ecm`.`document`.`doc_type` ALTER COLUMN `pii_likely` SET TAGS ('dbx_business_glossary_term' = 'Personally Identifiable Information (PII) Likely Flag');
ALTER TABLE `legal_ecm`.`document`.`doc_type` ALTER COLUMN `redaction_protocol` SET TAGS ('dbx_business_glossary_term' = 'Redaction Protocol');
ALTER TABLE `legal_ecm`.`document`.`doc_type` ALTER COLUMN `redaction_protocol` SET TAGS ('dbx_value_regex' = 'none|standard|enhanced|custom');
ALTER TABLE `legal_ecm`.`document`.`doc_type` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `legal_ecm`.`document`.`doc_type` ALTER COLUMN `requires_conflict_check` SET TAGS ('dbx_business_glossary_term' = 'Requires Conflict Check Flag');
ALTER TABLE `legal_ecm`.`document`.`doc_type` ALTER COLUMN `requires_execution` SET TAGS ('dbx_business_glossary_term' = 'Requires Execution Flag');
ALTER TABLE `legal_ecm`.`document`.`doc_type` ALTER COLUMN `requires_notarization` SET TAGS ('dbx_business_glossary_term' = 'Requires Notarization Flag');
ALTER TABLE `legal_ecm`.`document`.`doc_type` ALTER COLUMN `requires_witness` SET TAGS ('dbx_business_glossary_term' = 'Requires Witness Flag');
ALTER TABLE `legal_ecm`.`document`.`doc_type` ALTER COLUMN `retention_category` SET TAGS ('dbx_business_glossary_term' = 'Retention Category');
ALTER TABLE `legal_ecm`.`document`.`doc_type` ALTER COLUMN `retention_category` SET TAGS ('dbx_value_regex' = 'permanent|long_term|medium_term|short_term|event_based');
ALTER TABLE `legal_ecm`.`document`.`doc_type` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period in Years');
ALTER TABLE `legal_ecm`.`document`.`doc_type` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Document Subcategory');
ALTER TABLE `legal_ecm`.`document`.`doc_type` ALTER COLUMN `usage_guidance` SET TAGS ('dbx_business_glossary_term' = 'Usage Guidance');
ALTER TABLE `legal_ecm`.`document`.`doc_type` ALTER COLUMN `utbms_task_code` SET TAGS ('dbx_business_glossary_term' = 'Uniform Task-Based Management System (UTBMS) Task Code');
ALTER TABLE `legal_ecm`.`document`.`doc_type` ALTER COLUMN `utbms_task_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{3}$');
ALTER TABLE `legal_ecm`.`document`.`doc_type` ALTER COLUMN `version_control_required` SET TAGS ('dbx_business_glossary_term' = 'Version Control Required Flag');
ALTER TABLE `legal_ecm`.`document`.`doc_type` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` SET TAGS ('dbx_subdomain' = 'document_management');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `doc_folder_id` SET TAGS ('dbx_business_glossary_term' = 'Document Folder ID');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `data_privacy_register_id` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `organisation_id` SET TAGS ('dbx_business_glossary_term' = 'Organisation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `parent_folder_doc_folder_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Folder ID');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `retention_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Schedule Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `access_control_group` SET TAGS ('dbx_business_glossary_term' = 'Access Control Group');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `archived_date` SET TAGS ('dbx_business_glossary_term' = 'Archived Date');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `audit_log_enabled` SET TAGS ('dbx_business_glossary_term' = 'Audit Log Enabled');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Closed Date');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `collaboration_enabled` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Enabled');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `confidentiality_agreement_required` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Agreement Required');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `created_by_user_code` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `created_by_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `created_by_user_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `dms_source_system` SET TAGS ('dbx_business_glossary_term' = 'Document Management System (DMS) Source System');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `dms_source_system` SET TAGS ('dbx_value_regex' = 'imanage_work|netdocuments|relativity|sharepoint|other');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `doc_folder_description` SET TAGS ('dbx_business_glossary_term' = 'Folder Description');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `document_count` SET TAGS ('dbx_business_glossary_term' = 'Document Count');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `encryption_enabled` SET TAGS ('dbx_business_glossary_term' = 'Encryption Enabled');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `ethical_wall_flag` SET TAGS ('dbx_business_glossary_term' = 'Ethical Wall Flag');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `external_reference_number` SET TAGS ('dbx_business_glossary_term' = 'External Reference Number');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `external_sharing_allowed` SET TAGS ('dbx_business_glossary_term' = 'External Sharing Allowed');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `folder_name` SET TAGS ('dbx_business_glossary_term' = 'Folder Name');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `folder_path` SET TAGS ('dbx_business_glossary_term' = 'Folder Path');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `folder_status` SET TAGS ('dbx_business_glossary_term' = 'Folder Status');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `folder_status` SET TAGS ('dbx_value_regex' = 'active|closed|archived|suspended|pending_deletion');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `folder_type` SET TAGS ('dbx_business_glossary_term' = 'Folder Type');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `folder_type` SET TAGS ('dbx_value_regex' = 'matter_workspace|client_workspace|project_workspace|administrative|template|archive');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `last_accessed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Accessed Timestamp');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Flag');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `legal_hold_reference` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Reference');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `modified_by_user_code` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `modified_by_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `modified_by_user_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `owner_user_code` SET TAGS ('dbx_business_glossary_term' = 'Owner User ID');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `owner_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `owner_user_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `privilege_designation` SET TAGS ('dbx_business_glossary_term' = 'Privilege Designation');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `privilege_designation` SET TAGS ('dbx_value_regex' = 'none|attorney_client|work_product|joint_defense|settlement');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `retention_end_date` SET TAGS ('dbx_business_glossary_term' = 'Retention End Date');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `retention_start_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Start Date');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `security_classification` SET TAGS ('dbx_business_glossary_term' = 'Security Classification');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `security_classification` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted|privileged');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `subfolder_count` SET TAGS ('dbx_business_glossary_term' = 'Subfolder Count');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `sync_enabled` SET TAGS ('dbx_business_glossary_term' = 'Synchronization Enabled');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `total_storage_bytes` SET TAGS ('dbx_business_glossary_term' = 'Total Storage Bytes');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `version_control_enabled` SET TAGS ('dbx_business_glossary_term' = 'Version Control Enabled');
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ALTER COLUMN `workspace_template_code` SET TAGS ('dbx_business_glossary_term' = 'Workspace Template Code');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` SET TAGS ('dbx_subdomain' = 'discovery_review');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `doc_review_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Document Review Assignment ID');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Asset Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `data_breach_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Data Breach Incident Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `doc_version_id` SET TAGS ('dbx_business_glossary_term' = 'Doc Version Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `esi_collection_id` SET TAGS ('dbx_business_glossary_term' = 'Esi Collection Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `ethical_wall_id` SET TAGS ('dbx_business_glossary_term' = 'Ethical Wall Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `legal_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `patent_family_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Family Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Document ID');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `sla_template_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Template Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `trademark_id` SET TAGS ('dbx_business_glossary_term' = 'Trademark Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `annotation_count` SET TAGS ('dbx_business_glossary_term' = 'Annotation Count');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `assignment_method` SET TAGS ('dbx_business_glossary_term' = 'Assignment Method');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `assignment_method` SET TAGS ('dbx_value_regex' = 'manual|automated|round_robin|workload_balanced');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `assignment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Timestamp');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `bates_number` SET TAGS ('dbx_business_glossary_term' = 'Bates Number');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `cal_feedback_flag` SET TAGS ('dbx_business_glossary_term' = 'Continuous Active Learning (CAL) Feedback Flag');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `confidentiality_designation` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Designation');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `confidentiality_designation` SET TAGS ('dbx_value_regex' = 'public|confidential|highly_confidential|attorneys_eyes_only');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `custodian_name` SET TAGS ('dbx_business_glossary_term' = 'Custodian Name');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `custodian_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `issue_tags` SET TAGS ('dbx_business_glossary_term' = 'Issue Tags');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `modified_by_user_code` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `modified_by_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `modified_by_user_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `privilege_type` SET TAGS ('dbx_business_glossary_term' = 'Privilege Type');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `privilege_type` SET TAGS ('dbx_value_regex' = 'attorney_client|work_product|joint_defense|settlement|none');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `production_flag` SET TAGS ('dbx_business_glossary_term' = 'Production Flag');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `redaction_count` SET TAGS ('dbx_business_glossary_term' = 'Redaction Count');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `redaction_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Redaction Required Flag');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `relevance_score` SET TAGS ('dbx_business_glossary_term' = 'Relevance Score');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `review_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Timestamp');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `review_decision` SET TAGS ('dbx_business_glossary_term' = 'Review Decision');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `review_decision` SET TAGS ('dbx_value_regex' = 'responsive|non_responsive|privilege|not_reviewed');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `review_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Review Duration (Minutes)');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `review_priority` SET TAGS ('dbx_business_glossary_term' = 'Review Priority');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `review_priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|urgent');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `review_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Start Timestamp');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'assigned|in_progress|completed|skipped|escalated|on_hold');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Review Type');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = 'first_pass|quality_control|privilege_review|hot_document|ad_hoc');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `reviewer_comments` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Comments');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `second_level_review_decision` SET TAGS ('dbx_business_glossary_term' = 'Second-Level Review Decision');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `second_level_review_decision` SET TAGS ('dbx_value_regex' = 'confirmed|overridden|escalated');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `second_level_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Second-Level Review Required Flag');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `second_level_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Second-Level Review Timestamp');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ALTER COLUMN `tar_model_round` SET TAGS ('dbx_business_glossary_term' = 'Technology-Assisted Review (TAR) Model Round');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` SET TAGS ('dbx_subdomain' = 'discovery_review');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `privilege_log_id` SET TAGS ('dbx_business_glossary_term' = 'Privilege Log Identifier (ID)');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Asset Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `data_breach_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Data Breach Incident Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `doc_review_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Doc Review Assignment Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `doc_version_id` SET TAGS ('dbx_business_glossary_term' = 'Doc Version Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `esi_collection_id` SET TAGS ('dbx_business_glossary_term' = 'Esi Collection Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier (ID)');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Document Identifier (ID)');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `prosecution_event_id` SET TAGS ('dbx_business_glossary_term' = 'Prosecution Event Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `author_name` SET TAGS ('dbx_business_glossary_term' = 'Author Name');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `author_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `bates_number` SET TAGS ('dbx_business_glossary_term' = 'Bates Number');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `challenge_date` SET TAGS ('dbx_business_glossary_term' = 'Challenge Date');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `challenge_notes` SET TAGS ('dbx_business_glossary_term' = 'Challenge Notes');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `challenge_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Challenge Resolution Date');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `challenge_status` SET TAGS ('dbx_business_glossary_term' = 'Challenge Status');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `challenge_status` SET TAGS ('dbx_value_regex' = 'unchallenged|challenged|upheld|overruled|pending');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `clawback_date` SET TAGS ('dbx_business_glossary_term' = 'Clawback Request Date');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `clawback_requested` SET TAGS ('dbx_business_glossary_term' = 'Clawback Requested');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `clawback_status` SET TAGS ('dbx_business_glossary_term' = 'Clawback Status');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `clawback_status` SET TAGS ('dbx_value_regex' = 'not_applicable|requested|granted|denied|pending');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|highly_confidential|attorneys_eyes_only');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `court_case_number` SET TAGS ('dbx_business_glossary_term' = 'Court Case Number');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `custodian_name` SET TAGS ('dbx_business_glossary_term' = 'Custodian Name');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `custodian_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `designation_date` SET TAGS ('dbx_business_glossary_term' = 'Designation Date');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `designation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Designation Timestamp');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `document_description` SET TAGS ('dbx_business_glossary_term' = 'Document Description');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `document_title` SET TAGS ('dbx_business_glossary_term' = 'Document Title');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `entry_number` SET TAGS ('dbx_business_glossary_term' = 'Privilege Log Entry Number');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `lpp_classification` SET TAGS ('dbx_business_glossary_term' = 'Legal Professional Privilege (LPP) Classification');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `lpp_classification` SET TAGS ('dbx_value_regex' = 'legal_advice|litigation|contentious|non_contentious|not_applicable');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `privilege_basis` SET TAGS ('dbx_business_glossary_term' = 'Privilege Basis');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `privilege_type` SET TAGS ('dbx_business_glossary_term' = 'Privilege Type');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `privilege_type` SET TAGS ('dbx_value_regex' = 'attorney_client|work_product|common_interest|joint_defense|settlement|other');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `production_status` SET TAGS ('dbx_business_glossary_term' = 'Production Status');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `production_status` SET TAGS ('dbx_value_regex' = 'withheld|produced_redacted|produced_unredacted|pending_review');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `recipient_names` SET TAGS ('dbx_business_glossary_term' = 'Recipient Names');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `recipient_names` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `redaction_status` SET TAGS ('dbx_business_glossary_term' = 'Redaction Status');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `redaction_status` SET TAGS ('dbx_value_regex' = 'not_redacted|partially_redacted|fully_redacted|withheld');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `retention_hold` SET TAGS ('dbx_business_glossary_term' = 'Retention Hold');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `waiver_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Date');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `waiver_status` SET TAGS ('dbx_business_glossary_term' = 'Waiver Status');
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ALTER COLUMN `waiver_status` SET TAGS ('dbx_value_regex' = 'not_waived|inadvertent_disclosure|intentional_waiver|subject_matter_waiver|pending_determination');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` SET TAGS ('dbx_subdomain' = 'discovery_review');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `esi_collection_id` SET TAGS ('dbx_business_glossary_term' = 'Electronically Stored Information (ESI) Collection ID');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Assessment Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Asset Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `data_breach_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Data Breach Incident Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `data_privacy_register_id` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `delivery_model_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Model Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `hold_id` SET TAGS ('dbx_business_glossary_term' = 'Hold Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `legal_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `organisation_id` SET TAGS ('dbx_business_glossary_term' = 'Organisation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `primary_esi_custodian_id` SET TAGS ('dbx_business_glossary_term' = 'Esi Custodian Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `chain_of_custody_hash` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody Hash Value');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `collection_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Collection Cost Amount');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `collection_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `collection_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Collection Cost Currency');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `collection_cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `collection_end_date` SET TAGS ('dbx_business_glossary_term' = 'Collection End Date');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `collection_method` SET TAGS ('dbx_business_glossary_term' = 'Collection Method');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `collection_name` SET TAGS ('dbx_business_glossary_term' = 'Collection Name');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `collection_notes` SET TAGS ('dbx_business_glossary_term' = 'Collection Notes');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `collection_number` SET TAGS ('dbx_business_glossary_term' = 'Collection Number');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `collection_scope_description` SET TAGS ('dbx_business_glossary_term' = 'Collection Scope Description');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `collection_start_date` SET TAGS ('dbx_business_glossary_term' = 'Collection Start Date');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Status');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `collection_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|failed|cancelled|on_hold');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `collection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Collection Timestamp');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `collection_tool_name` SET TAGS ('dbx_business_glossary_term' = 'Collection Tool Name');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `collection_tool_version` SET TAGS ('dbx_business_glossary_term' = 'Collection Tool Version');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `collection_type` SET TAGS ('dbx_business_glossary_term' = 'Collection Type');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `collection_type` SET TAGS ('dbx_value_regex' = 'targeted|forensic|remote|onsite|self_collection');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `collector_name` SET TAGS ('dbx_business_glossary_term' = 'Collector Name');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `data_source_location` SET TAGS ('dbx_business_glossary_term' = 'Data Source Location');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `data_source_type` SET TAGS ('dbx_business_glossary_term' = 'Data Source Type');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `date_range_end` SET TAGS ('dbx_business_glossary_term' = 'Date Range End');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `date_range_start` SET TAGS ('dbx_business_glossary_term' = 'Date Range Start');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `deduplication_applied` SET TAGS ('dbx_business_glossary_term' = 'Deduplication Applied');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `encryption_detected` SET TAGS ('dbx_business_glossary_term' = 'Encryption Detected');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `hash_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Hash Algorithm');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `hash_algorithm` SET TAGS ('dbx_value_regex' = 'MD5|SHA1|SHA256|SHA512');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `password_protected_items_count` SET TAGS ('dbx_business_glossary_term' = 'Password Protected Items Count');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `preservation_notice_date` SET TAGS ('dbx_business_glossary_term' = 'Preservation Notice Date');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `preservation_notice_issued` SET TAGS ('dbx_business_glossary_term' = 'Preservation Notice Issued');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `privilege_review_required` SET TAGS ('dbx_business_glossary_term' = 'Privilege Review Required');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `production_eligible` SET TAGS ('dbx_business_glossary_term' = 'Production Eligible');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `relativity_workspace_reference` SET TAGS ('dbx_business_glossary_term' = 'Relativity Workspace ID');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `total_items_collected` SET TAGS ('dbx_business_glossary_term' = 'Total Items Collected');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `total_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Total Size in Bytes');
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ALTER COLUMN `total_size_gb` SET TAGS ('dbx_business_glossary_term' = 'Total Size in Gigabytes (GB)');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` SET TAGS ('dbx_subdomain' = 'discovery_review');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ALTER COLUMN `esi_custodian_id` SET TAGS ('dbx_business_glossary_term' = 'Electronically Stored Information (ESI) Custodian ID');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ALTER COLUMN `organisation_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Organisation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ALTER COLUMN `data_breach_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Data Breach Incident Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ALTER COLUMN `hold_id` SET TAGS ('dbx_business_glossary_term' = 'Hold Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ALTER COLUMN `chain_of_custody_verified` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody Verified');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ALTER COLUMN `collection_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Collection Completion Date');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ALTER COLUMN `collection_file_count` SET TAGS ('dbx_business_glossary_term' = 'Collection File Count');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ALTER COLUMN `collection_method` SET TAGS ('dbx_business_glossary_term' = 'Collection Method');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ALTER COLUMN `collection_method` SET TAGS ('dbx_value_regex' = 'forensic_imaging|targeted_collection|self_collection|remote_collection|on_site_collection');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ALTER COLUMN `collection_start_date` SET TAGS ('dbx_business_glossary_term' = 'Collection Start Date');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Status');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ALTER COLUMN `collection_status` SET TAGS ('dbx_value_regex' = 'not_started|scheduled|in_progress|completed|failed|on_hold');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ALTER COLUMN `collection_volume_gb` SET TAGS ('dbx_business_glossary_term' = 'Collection Volume (GB)');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ALTER COLUMN `custodian_active_flag` SET TAGS ('dbx_business_glossary_term' = 'Custodian Active Flag');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ALTER COLUMN `custodian_department` SET TAGS ('dbx_business_glossary_term' = 'Custodian Department');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ALTER COLUMN `custodian_departure_date` SET TAGS ('dbx_business_glossary_term' = 'Custodian Departure Date');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ALTER COLUMN `custodian_email` SET TAGS ('dbx_business_glossary_term' = 'Custodian Email Address');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ALTER COLUMN `custodian_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ALTER COLUMN `custodian_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ALTER COLUMN `custodian_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ALTER COLUMN `custodian_full_name` SET TAGS ('dbx_business_glossary_term' = 'Custodian Full Name');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ALTER COLUMN `custodian_full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ALTER COLUMN `custodian_full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ALTER COLUMN `custodian_role` SET TAGS ('dbx_business_glossary_term' = 'Custodian Role');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ALTER COLUMN `custodian_status` SET TAGS ('dbx_business_glossary_term' = 'Custodian Status');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ALTER COLUMN `custodian_type` SET TAGS ('dbx_business_glossary_term' = 'Custodian Type');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ALTER COLUMN `custodian_type` SET TAGS ('dbx_value_regex' = 'key|standard|peripheral|third_party|non_employee');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ALTER COLUMN `data_residency_country` SET TAGS ('dbx_business_glossary_term' = 'Data Residency Country');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ALTER COLUMN `data_residency_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ALTER COLUMN `data_sources_cloud_storage` SET TAGS ('dbx_business_glossary_term' = 'Data Sources - Cloud Storage');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ALTER COLUMN `data_sources_collaboration_tools` SET TAGS ('dbx_business_glossary_term' = 'Data Sources - Collaboration Tools');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ALTER COLUMN `data_sources_email` SET TAGS ('dbx_business_glossary_term' = 'Data Sources - Email Systems');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ALTER COLUMN `data_sources_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ALTER COLUMN `data_sources_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ALTER COLUMN `data_sources_file_shares` SET TAGS ('dbx_business_glossary_term' = 'Data Sources - File Shares');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ALTER COLUMN `data_sources_local_drives` SET TAGS ('dbx_business_glossary_term' = 'Data Sources - Local Drives');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ALTER COLUMN `data_sources_mobile_devices` SET TAGS ('dbx_business_glossary_term' = 'Data Sources - Mobile Devices');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ALTER COLUMN `data_sources_mobile_devices` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ALTER COLUMN `data_sources_mobile_devices` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ALTER COLUMN `data_sources_other` SET TAGS ('dbx_business_glossary_term' = 'Data Sources - Other');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ALTER COLUMN `gdpr_data_subject_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Data Subject Flag');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ALTER COLUMN `lpp_classification` SET TAGS ('dbx_business_glossary_term' = 'Legal Professional Privilege (LPP) Classification');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ALTER COLUMN `lpp_classification` SET TAGS ('dbx_value_regex' = 'not_applicable|legal_advice|litigation_privilege|without_prejudice');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ALTER COLUMN `privilege_designation` SET TAGS ('dbx_business_glossary_term' = 'Privilege Designation');
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ALTER COLUMN `privilege_designation` SET TAGS ('dbx_value_regex' = 'none|attorney_client|work_product|joint_defense|settlement');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` SET TAGS ('dbx_subdomain' = 'discovery_review');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ALTER COLUMN `legal_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold ID');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ALTER COLUMN `assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Assessment Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Asset Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Client Contact Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ALTER COLUMN `data_breach_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Data Breach Incident Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ALTER COLUMN `data_privacy_register_id` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ALTER COLUMN `doc_template_id` SET TAGS ('dbx_business_glossary_term' = 'Hold Notice Template ID');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Document Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ALTER COLUMN `organisation_id` SET TAGS ('dbx_business_glossary_term' = 'Outside Counsel Firm ID');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Request Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ALTER COLUMN `sla_template_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Template Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ALTER COLUMN `acknowledged_count` SET TAGS ('dbx_business_glossary_term' = 'Acknowledged Count');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ALTER COLUMN `compliance_monitoring_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Monitoring Flag');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ALTER COLUMN `custodian_count` SET TAGS ('dbx_business_glossary_term' = 'Custodian Count');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ALTER COLUMN `data_sources_in_scope` SET TAGS ('dbx_business_glossary_term' = 'Data Sources In Scope');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ALTER COLUMN `document_types_in_scope` SET TAGS ('dbx_business_glossary_term' = 'Document Types In Scope');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ALTER COLUMN `ediscovery_collection_initiated_flag` SET TAGS ('dbx_business_glossary_term' = 'eDiscovery (Electronic Discovery) Collection Initiated Flag');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ALTER COLUMN `escalation_count` SET TAGS ('dbx_business_glossary_term' = 'Escalation Count');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ALTER COLUMN `hold_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Name');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ALTER COLUMN `hold_number` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Number');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Status');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|released|expired');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ALTER COLUMN `issued_date` SET TAGS ('dbx_business_glossary_term' = 'Issued Date');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ALTER COLUMN `last_reminder_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reminder Sent Date');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ALTER COLUMN `preservation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Preservation End Date');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ALTER COLUMN `preservation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Preservation Start Date');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ALTER COLUMN `privilege_designation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Professional Privilege (LPP) Designation Required Flag');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ALTER COLUMN `release_reason` SET TAGS ('dbx_business_glossary_term' = 'Release Reason');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ALTER COLUMN `reminder_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Reminder Frequency Days');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ALTER COLUMN `spoliation_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Spoliation Risk Level');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ALTER COLUMN `spoliation_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ALTER COLUMN `suspension_of_destruction_flag` SET TAGS ('dbx_business_glossary_term' = 'Suspension of Destruction Flag');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ALTER COLUMN `trigger_date` SET TAGS ('dbx_business_glossary_term' = 'Trigger Date');
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ALTER COLUMN `trigger_event` SET TAGS ('dbx_business_glossary_term' = 'Trigger Event');
ALTER TABLE `legal_ecm`.`document`.`doc_production` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`document`.`doc_production` SET TAGS ('dbx_subdomain' = 'discovery_review');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `doc_production_id` SET TAGS ('dbx_business_glossary_term' = 'Document Production Identifier (ID)');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Asset Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `billing_disbursement_id` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `data_breach_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Data Breach Incident Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `data_privacy_register_id` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `doc_review_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Production Inclusion - Doc Review Assignment Id');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `ethical_wall_id` SET TAGS ('dbx_business_glossary_term' = 'Ethical Wall Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier (ID)');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `privilege_log_id` SET TAGS ('dbx_business_glossary_term' = 'Privilege Log Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `production_set_id` SET TAGS ('dbx_business_glossary_term' = 'Production Set Identifier (ID)');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `sla_template_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Template Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `acknowledgment_received` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Received Flag');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `bates_end_number` SET TAGS ('dbx_business_glossary_term' = 'Bates End Number');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `bates_end_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,50}$');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `bates_number` SET TAGS ('dbx_business_glossary_term' = 'Bates Number');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `bates_number` SET TAGS ('dbx_legal_identifier' = 'true');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `bates_prefix` SET TAGS ('dbx_business_glossary_term' = 'Bates Prefix');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `bates_prefix` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,20}$');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `bates_start_number` SET TAGS ('dbx_business_glossary_term' = 'Bates Start Number');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `bates_start_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,50}$');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `clawback_date` SET TAGS ('dbx_business_glossary_term' = 'Clawback Date');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `clawback_invoked` SET TAGS ('dbx_business_glossary_term' = 'Clawback Invoked Flag');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `confidentiality_designation` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Designation');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `confidentiality_designation` SET TAGS ('dbx_value_regex' = 'none|confidential|highly_confidential|attorneys_eyes_only|source_code');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'secure_file_transfer|physical_media|cloud_platform|email|courier|relativity_transfer');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `dispute_description` SET TAGS ('dbx_business_glossary_term' = 'Dispute Description');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `dispute_raised` SET TAGS ('dbx_business_glossary_term' = 'Dispute Raised Flag');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `document_count` SET TAGS ('dbx_business_glossary_term' = 'Document Count');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `hash_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Hash Verification Method');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `hash_verification_method` SET TAGS ('dbx_value_regex' = 'md5|sha1|sha256|none');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `load_file_format` SET TAGS ('dbx_business_glossary_term' = 'Load File Format');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `metadata_fields_included` SET TAGS ('dbx_business_glossary_term' = 'Metadata Fields Included');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `native_file_count` SET TAGS ('dbx_business_glossary_term' = 'Native File Count');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Page Count');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `privilege_log_included` SET TAGS ('dbx_business_glossary_term' = 'Privilege Log Included Flag');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `producing_counsel_name` SET TAGS ('dbx_business_glossary_term' = 'Producing Counsel Name');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `producing_party_name` SET TAGS ('dbx_business_glossary_term' = 'Producing Party Name');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `production_date` SET TAGS ('dbx_business_glossary_term' = 'Production Date');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `production_flag` SET TAGS ('dbx_business_glossary_term' = 'Production Flag');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `production_format` SET TAGS ('dbx_business_glossary_term' = 'Production Format');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `production_format` SET TAGS ('dbx_value_regex' = 'native|tiff|pdf|mixed|load_file');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `production_name` SET TAGS ('dbx_business_glossary_term' = 'Production Name');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `production_notes` SET TAGS ('dbx_business_glossary_term' = 'Production Notes');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `production_number` SET TAGS ('dbx_business_glossary_term' = 'Production Number');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `production_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,50}$');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `production_status` SET TAGS ('dbx_business_glossary_term' = 'Production Status');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `production_type` SET TAGS ('dbx_business_glossary_term' = 'Production Type');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `production_type` SET TAGS ('dbx_value_regex' = 'initial|supplemental|rolling|privilege_log|clawback|corrective');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `protective_order_reference` SET TAGS ('dbx_business_glossary_term' = 'Protective Order Reference');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `receiving_party_contact` SET TAGS ('dbx_business_glossary_term' = 'Receiving Party Contact');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `receiving_party_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `receiving_party_contact` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `receiving_party_name` SET TAGS ('dbx_business_glossary_term' = 'Receiving Party Name');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `redaction_applied` SET TAGS ('dbx_business_glossary_term' = 'Redaction Applied Flag');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `redaction_count` SET TAGS ('dbx_business_glossary_term' = 'Redaction Count');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `redaction_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Redaction Required Flag');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `relativity_workspace_reference` SET TAGS ('dbx_business_glossary_term' = 'Relativity Workspace Identifier (ID)');
ALTER TABLE `legal_ecm`.`document`.`doc_production` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` SET TAGS ('dbx_subdomain' = 'document_management');
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ALTER COLUMN `retention_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Schedule ID');
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ALTER COLUMN `agreement_type_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ALTER COLUMN `doc_type_id` SET TAGS ('dbx_business_glossary_term' = 'Doc Type Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Profile Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ALTER COLUMN `superseded_by_schedule_retention_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Schedule ID');
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ALTER COLUMN `audit_trail_retention_years` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Retention (Years)');
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ALTER COLUMN `certificate_of_destruction_required` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Destruction Required');
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ALTER COLUMN `client_specific_override` SET TAGS ('dbx_business_glossary_term' = 'Client-Specific Override');
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ALTER COLUMN `cross_border_transfer_restriction` SET TAGS ('dbx_business_glossary_term' = 'Cross-Border Transfer Restriction');
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ALTER COLUMN `destruction_authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Destruction Authorization Required');
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ALTER COLUMN `destruction_method` SET TAGS ('dbx_business_glossary_term' = 'Destruction Method');
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ALTER COLUMN `dms_system_enforcement` SET TAGS ('dbx_business_glossary_term' = 'Document Management System (DMS) Enforcement');
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ALTER COLUMN `dms_system_enforcement` SET TAGS ('dbx_value_regex' = 'imanage|netdocuments|both|manual|none');
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ALTER COLUMN `ediscovery_relevance_flag` SET TAGS ('dbx_business_glossary_term' = 'eDiscovery Relevance Flag');
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ALTER COLUMN `effective_until_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ALTER COLUMN `legal_hold_exemption` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Exemption');
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ALTER COLUMN `lpp_classification` SET TAGS ('dbx_business_glossary_term' = 'Legal Professional Privilege (LPP) Classification');
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ALTER COLUMN `lpp_classification` SET TAGS ('dbx_value_regex' = 'privileged|non_privileged|work_product|mixed|unknown');
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ALTER COLUMN `matter_type` SET TAGS ('dbx_business_glossary_term' = 'Matter Type');
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ALTER COLUMN `maximum_retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Maximum Retention Period (Years)');
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ALTER COLUMN `minimum_retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Minimum Retention Period (Years)');
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Retention Schedule Notes');
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ALTER COLUMN `privacy_impact_classification` SET TAGS ('dbx_business_glossary_term' = 'Privacy Impact Classification');
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ALTER COLUMN `privacy_impact_classification` SET TAGS ('dbx_value_regex' = 'high|medium|low|none');
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ALTER COLUMN `records_classification_code` SET TAGS ('dbx_business_glossary_term' = 'Records Classification Code');
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ALTER COLUMN `records_classification_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ALTER COLUMN `responsible_records_manager` SET TAGS ('dbx_business_glossary_term' = 'Responsible Records Manager');
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ALTER COLUMN `retention_basis` SET TAGS ('dbx_business_glossary_term' = 'Retention Basis');
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ALTER COLUMN `retention_review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Retention Review Frequency (Months)');
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ALTER COLUMN `retention_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Retention Schedule Status');
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ALTER COLUMN `retention_schedule_status` SET TAGS ('dbx_value_regex' = 'active|draft|superseded|archived|under_review');
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ALTER COLUMN `retention_trigger_event` SET TAGS ('dbx_business_glossary_term' = 'Retention Trigger Event');
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ALTER COLUMN `version_control_policy` SET TAGS ('dbx_business_glossary_term' = 'Version Control Policy');
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ALTER COLUMN `version_control_policy` SET TAGS ('dbx_value_regex' = 'retain_all_versions|retain_final_only|retain_major_versions|retain_last_n_versions');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` SET TAGS ('dbx_subdomain' = 'document_management');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `doc_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Document Execution Identifier (ID)');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Asset Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `clearance_id` SET TAGS ('dbx_business_glossary_term' = 'Clearance Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Client Contact Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `disbursement_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Authorization Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `doc_version_id` SET TAGS ('dbx_business_glossary_term' = 'Doc Version Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `escrow_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Escrow Arrangement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `inventor_id` SET TAGS ('dbx_business_glossary_term' = 'Inventor Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `letter_of_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Letter Of Engagement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip License Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier (ID)');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `ownership_id` SET TAGS ('dbx_business_glossary_term' = 'Ownership Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Document Identifier (ID)');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `retainer_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Retainer Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `sla_template_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Template Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `trust_disbursement_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Disbursement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `board_resolution_reference` SET TAGS ('dbx_business_glossary_term' = 'Board Resolution Reference');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `board_resolution_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `board_resolution_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Board Resolution Required Flag');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `compliance_review_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Completed Flag');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `counterpart_count` SET TAGS ('dbx_business_glossary_term' = 'Counterpart Count');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `counterpart_indicator` SET TAGS ('dbx_business_glossary_term' = 'Counterpart Indicator');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `executed_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Executed Document Reference');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `execution_language` SET TAGS ('dbx_business_glossary_term' = 'Execution Language');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `execution_location` SET TAGS ('dbx_business_glossary_term' = 'Execution Location');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `execution_method` SET TAGS ('dbx_business_glossary_term' = 'Execution Method');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `execution_notes` SET TAGS ('dbx_business_glossary_term' = 'Execution Notes');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `execution_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Execution Reference Number');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `execution_status` SET TAGS ('dbx_business_glossary_term' = 'Execution Status');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Execution Timestamp');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `execution_type` SET TAGS ('dbx_business_glossary_term' = 'Execution Type');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `notarization_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Notarization Completed Flag');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `notarization_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Notarization Required Flag');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `notary_commission_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Notary Commission Expiry Date');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `notary_commission_number` SET TAGS ('dbx_business_glossary_term' = 'Notary Commission Number');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `notary_commission_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `notary_name` SET TAGS ('dbx_business_glossary_term' = 'Notary Name');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `notary_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `power_of_attorney_used_flag` SET TAGS ('dbx_business_glossary_term' = 'Power of Attorney (POA) Used Flag');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `seal_applied_flag` SET TAGS ('dbx_business_glossary_term' = 'Seal Applied Flag');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `seal_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Seal Required Flag');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `signatures_completed_count` SET TAGS ('dbx_business_glossary_term' = 'Signatures Completed Count');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `signing_party_count` SET TAGS ('dbx_business_glossary_term' = 'Signing Party Count');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `witness_count_obtained` SET TAGS ('dbx_business_glossary_term' = 'Witness Count Obtained');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `witness_count_required` SET TAGS ('dbx_business_glossary_term' = 'Witness Count Required');
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ALTER COLUMN `witness_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Witness Required Flag');
ALTER TABLE `legal_ecm`.`document`.`doc_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`document`.`doc_template` SET TAGS ('dbx_subdomain' = 'document_management');
ALTER TABLE `legal_ecm`.`document`.`doc_template` ALTER COLUMN `doc_template_id` SET TAGS ('dbx_business_glossary_term' = 'Document Template ID');
ALTER TABLE `legal_ecm`.`document`.`doc_template` ALTER COLUMN `agreement_type_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_template` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_template` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_template` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_template` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_template` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`doc_template` ALTER COLUMN `access_level` SET TAGS ('dbx_business_glossary_term' = 'Access Level');
ALTER TABLE `legal_ecm`.`document`.`doc_template` ALTER COLUMN `access_level` SET TAGS ('dbx_value_regex' = 'public|practice_group|partner_only|restricted');
ALTER TABLE `legal_ecm`.`document`.`doc_template` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm`.`document`.`doc_template` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `legal_ecm`.`document`.`doc_template` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|archived|deprecated|withdrawn');
ALTER TABLE `legal_ecm`.`document`.`doc_template` ALTER COLUMN `automation_platform` SET TAGS ('dbx_business_glossary_term' = 'Automation Platform');
ALTER TABLE `legal_ecm`.`document`.`doc_template` ALTER COLUMN `contains_automation` SET TAGS ('dbx_business_glossary_term' = 'Contains Automation');
ALTER TABLE `legal_ecm`.`document`.`doc_template` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`document`.`doc_template` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `legal_ecm`.`document`.`doc_template` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `legal_ecm`.`document`.`doc_template` ALTER COLUMN `file_format` SET TAGS ('dbx_value_regex' = 'docx|pdf|rtf|odt|html');
ALTER TABLE `legal_ecm`.`document`.`doc_template` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law');
ALTER TABLE `legal_ecm`.`document`.`doc_template` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `legal_ecm`.`document`.`doc_template` ALTER COLUMN `is_client_facing` SET TAGS ('dbx_business_glossary_term' = 'Is Client Facing');
ALTER TABLE `legal_ecm`.`document`.`doc_template` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Language');
ALTER TABLE `legal_ecm`.`document`.`doc_template` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`document`.`doc_template` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `legal_ecm`.`document`.`doc_template` ALTER COLUMN `last_used_date` SET TAGS ('dbx_business_glossary_term' = 'Last Used Date');
ALTER TABLE `legal_ecm`.`document`.`doc_template` ALTER COLUMN `modified_by_user_code` SET TAGS ('dbx_business_glossary_term' = 'Modified By ID');
ALTER TABLE `legal_ecm`.`document`.`doc_template` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `legal_ecm`.`document`.`doc_template` ALTER COLUMN `owner_practice_group` SET TAGS ('dbx_business_glossary_term' = 'Owner Practice Group');
ALTER TABLE `legal_ecm`.`document`.`doc_template` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Page Count');
ALTER TABLE `legal_ecm`.`document`.`doc_template` ALTER COLUMN `precedent_references` SET TAGS ('dbx_business_glossary_term' = 'Precedent References');
ALTER TABLE `legal_ecm`.`document`.`doc_template` ALTER COLUMN `regulatory_compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Notes');
ALTER TABLE `legal_ecm`.`document`.`doc_template` ALTER COLUMN `requires_partner_review` SET TAGS ('dbx_business_glossary_term' = 'Requires Partner Review');
ALTER TABLE `legal_ecm`.`document`.`doc_template` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period Years');
ALTER TABLE `legal_ecm`.`document`.`doc_template` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `legal_ecm`.`document`.`doc_template` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Template Tags');
ALTER TABLE `legal_ecm`.`document`.`doc_template` ALTER COLUMN `template_code` SET TAGS ('dbx_business_glossary_term' = 'Template Code');
ALTER TABLE `legal_ecm`.`document`.`doc_template` ALTER COLUMN `template_description` SET TAGS ('dbx_business_glossary_term' = 'Template Description');
ALTER TABLE `legal_ecm`.`document`.`doc_template` ALTER COLUMN `template_name` SET TAGS ('dbx_business_glossary_term' = 'Template Name');
ALTER TABLE `legal_ecm`.`document`.`doc_template` ALTER COLUMN `template_version` SET TAGS ('dbx_business_glossary_term' = 'Template Version');
ALTER TABLE `legal_ecm`.`document`.`doc_template` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `legal_ecm`.`document`.`doc_template` ALTER COLUMN `usage_instructions` SET TAGS ('dbx_business_glossary_term' = 'Usage Instructions');
ALTER TABLE `legal_ecm`.`document`.`doc_template` ALTER COLUMN `word_count` SET TAGS ('dbx_business_glossary_term' = 'Word Count');
ALTER TABLE `legal_ecm`.`document`.`production_set` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`document`.`production_set` SET TAGS ('dbx_subdomain' = 'discovery_review');
ALTER TABLE `legal_ecm`.`document`.`production_set` ALTER COLUMN `production_set_id` SET TAGS ('dbx_business_glossary_term' = 'Production Set Identifier');
ALTER TABLE `legal_ecm`.`document`.`production_set` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`production_set` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Asset Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`production_set` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`production_set` ALTER COLUMN `parent_production_set_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `legal_ecm`.`document`.`production_set` ALTER COLUMN `sla_template_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Template Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`document`.`production_set` ALTER COLUMN `approving_attorney_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`document`.`production_set` ALTER COLUMN `created_by_user` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`document`.`production_set` ALTER COLUMN `delivery_location` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`document`.`production_set` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`document`.`production_set` ALTER COLUMN `producing_party_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`document`.`production_set` ALTER COLUMN `quality_control_reviewer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`document`.`production_set` ALTER COLUMN `recipient_party_name` SET TAGS ('dbx_confidential' = 'true');
