-- Schema for Domain: design | Business: Construction | Version: v1_mvm
-- Generated on: 2026-05-07 09:27:05

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `construction_ecm`.`design` COMMENT 'Engineering and design domain owning BIM models, CAD drawings, technical specifications, design packages, RFIs, submittals, clash detection, document control registers, transmittals, correspondence, workflow approvals, and handover documentation for construction projects';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `construction_ecm`.`design`.`correspondence` (
    `correspondence_id` BIGINT COMMENT 'Unique identifier for the correspondence record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Needed for Contract Correspondence Register report linking each correspondence to its governing agreement for audit and legal compliance.',
    `authority_notice_id` BIGINT COMMENT 'Foreign key linking to compliance.authority_notice. Business justification: Correspondence is generated in response to authority notices (responding to stop-work orders, replying to compliance notices, appealing enforcement actions). Linking correspondence to authority_notice',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project this correspondence belongs to.',
    `parent_correspondence_id` BIGINT COMMENT 'Reference to the parent correspondence record if this item is part of a threaded response chain. Nullable for root correspondence items.',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Construction correspondence is phase-tagged for document management and claim analysis. A contract administrator reports correspondence volume and response compliance by phase for project control. No ',
    `contact_id` BIGINT COMMENT 'Foreign key linking to client.contact. Business justification: Client-directed correspondence is formally addressed to a specific client contact. recipient_name and recipient_email are plain-text denormalizations of client.contact. A FK supports correspondence tr',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Correspondence with regulatory authorities is tied to specific regulatory obligations (responding to notices, providing compliance evidence, clarifying obligation scope). Linking correspondence to reg',
    `rfi_id` BIGINT COMMENT 'Foreign key linking to design.rfi. Business justification: Formal project correspondence is frequently raised in response to or in connection with an RFI. Adding rfi_id FK to correspondence enables traceability between correspondence items and the RFIs they r',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Required for client communication log linking each sent correspondence to the originating client account.',
    `transmittal_id` BIGINT COMMENT 'Foreign key linking to design.transmittal. Business justification: Formal project correspondence is dispatched via transmittals in construction document management systems (e.g., Aconex). The correspondence table carries transmittal_number as a STRING field. Adding t',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Construction correspondence (formal letters, notices) is tagged to WBS elements for cost and claim management. A contract administrator tracks correspondence by WBS scope for variation and dispute res',
    `attachment_count` STRING COMMENT 'Number of document attachments associated with this correspondence item (drawings, specifications, photos, reports).',
    `body_text` STRING COMMENT 'Full text content of the correspondence message or letter body.',
    `closure_date` DATE COMMENT 'The date the correspondence thread was formally closed. Nullable if still open.',
    `closure_status` STRING COMMENT 'Final closure status indicating whether the correspondence thread was accepted, rejected, or superseded by subsequent correspondence.. Valid values are `open|closed_accepted|closed_rejected|closed_superseded`',
    `confidential_flag` BOOLEAN COMMENT 'Boolean indicator whether this correspondence is marked as confidential and subject to restricted access controls.',
    `correspondence_date` DATE COMMENT 'The date the correspondence was officially issued or sent. This is the principal business event timestamp for the correspondence lifecycle.',
    `correspondence_number` STRING COMMENT 'Externally-known unique business identifier for the correspondence item as registered in the Aconex mail register. This is the official reference number used in contractual communications.. Valid values are `^[A-Z0-9-]+$`',
    `correspondence_status` STRING COMMENT 'Current lifecycle status of the correspondence item tracking its workflow state from draft through closure.. Valid values are `draft|issued|acknowledged|responded|closed|cancelled`',
    `correspondence_type` STRING COMMENT 'Classification of the correspondence item. RFI (Request for Information), instruction, notice, claim, letter, or memo.. Valid values are `rfi|instruction|notice|claim|letter|memo`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this correspondence record was first created in the document management system.',
    `discipline` STRING COMMENT 'Engineering or construction discipline to which this correspondence relates (civil, structural, MEP, architectural, etc.). [ENUM-REF-CANDIDATE: civil|structural|mechanical|electrical|architectural|plumbing|general — 7 candidates stripped; promote to reference product]',
    `distribution_list` STRING COMMENT 'Comma-separated list of additional parties or roles who were copied on this correspondence for information or action.',
    `modified_by` STRING COMMENT 'Username or identifier of the system user who last modified this correspondence record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this correspondence record was last modified or updated.',
    `priority` STRING COMMENT 'Priority level assigned to the correspondence indicating urgency of response or action required.. Valid values are `urgent|high|normal|low`',
    `received_date` DATE COMMENT 'The date the correspondence was received and registered in the document management system.',
    `recipient_organization` STRING COMMENT 'Name of the organization receiving the correspondence (contractor, client, consultant, subcontractor, or authority).',
    `response_date` DATE COMMENT 'The date a formal response was issued for this correspondence. Nullable if no response has been provided.',
    `response_due_date` DATE COMMENT 'The contractual or agreed date by which a response to this correspondence must be provided. Nullable if no response is required.',
    `response_method` STRING COMMENT 'The method or channel through which the response was delivered (email, formal letter, transmittal, meeting minutes, phone call).. Valid values are `email|letter|transmittal|meeting|phone`',
    `response_required_flag` BOOLEAN COMMENT 'Boolean indicator whether a formal response is required for this correspondence.',
    `response_text` STRING COMMENT 'Full text content of the response provided to this correspondence. Nullable if no response has been issued.',
    `sender_email` STRING COMMENT 'Email address of the sender for correspondence tracking and response routing.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `sender_name` STRING COMMENT 'Full name of the individual who authored or sent the correspondence.',
    `subject` STRING COMMENT 'Subject line or title of the correspondence describing the topic or issue being communicated.',
    `created_by` STRING COMMENT 'Username or identifier of the system user who created this correspondence record.',
    CONSTRAINT pk_correspondence PRIMARY KEY(`correspondence_id`)
) COMMENT 'Master register of all formal project correspondence including letters, emails, notices, and official communications managed through Aconex mail register. Tracks sender, recipient, subject, correspondence type (RFI, instruction, notice, claim), priority, response required flag, response due date, current status, response thread history with full response chain (response date, content, method, closure status), and parent-child threading. Serves as the authoritative SSOT for all project correspondence and response chains across contractors, clients, consultants, and authorities, providing the contractual audit trail required under FIDIC and NEC contract forms.';

CREATE OR REPLACE TABLE `construction_ecm`.`design`.`transmittal` (
    `transmittal_id` BIGINT COMMENT 'Unique identifier for the transmittal record. Primary key for the transmittal entity.',
    `agreement_id` BIGINT COMMENT 'Reference to the contract or agreement under which this transmittal is issued. Links document distribution to contractual obligations and scope.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project for which this transmittal is issued. Links transmittal to the parent project context.',
    `project_milestone_id` BIGINT COMMENT 'Foreign key linking to project.project_milestone. Business justification: Transmittals are issued to satisfy contractual milestone document submission requirements (e.g., transmittal of IFC drawings triggers a milestone). A construction PM tracks transmittal issuance agains',
    `contact_id` BIGINT COMMENT 'Foreign key linking to client.contact. Business justification: Transmittals in construction document control are formally addressed to a named client contact. recipient_contact_name and recipient_email are plain-text denormalizations of client.contact. A FK enabl',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: Transmittals are the formal mechanism for submitting design documents to regulatory authorities as part of regulatory submissions. Linking transmittal to regulatory_submission enables tracking of whic',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Transmittal origin must be linked to the client account for contract document tracking and regulatory filing.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Transmittals are issued against specific WBS elements in construction document management for scope traceability. A document controller tracks which WBS scope each transmittal covers for contract comp',
    `acknowledgement_by` STRING COMMENT 'Full name of the individual who provided formal acknowledgement on behalf of the recipient organization. Establishes personal accountability for receipt confirmation.',
    `acknowledgement_date` DATE COMMENT 'The date when the recipient formally acknowledged receipt of the transmittal. Null if not yet acknowledged. Provides legally defensible proof of document delivery.',
    `acknowledgement_required_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether the recipient is required to formally acknowledge receipt of the transmittal. True indicates acknowledgement is mandatory.',
    `acknowledgement_status` STRING COMMENT 'Current status of recipient acknowledgement tracking. Indicates whether the transmittal has been formally acknowledged by the recipient organization.. Valid values are `pending|acknowledged|overdue|not_required`',
    `confidentiality_level` STRING COMMENT 'Data classification level indicating the sensitivity and access restrictions applicable to the transmittal and its enclosed documents.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the transmittal record was first created in the system. Provides audit trail for record origination.',
    `delivery_method` STRING COMMENT 'The method or channel used to physically or electronically deliver the transmittal to the recipient. Tracks distribution logistics.. Valid values are `electronic|courier|hand_delivery|postal_mail|ftp|portal`',
    `discipline` STRING COMMENT 'The primary engineering or design discipline to which the transmittal documents belong. Categorizes transmittals by technical specialization for routing and review. [ENUM-REF-CANDIDATE: architectural|structural|mechanical|electrical|plumbing|civil|geotechnical|environmental — 8 candidates stripped; promote to reference product]',
    `document_count` STRING COMMENT 'Total number of individual documents or drawings included in this transmittal package. Used for completeness verification and audit trail.',
    `due_date` DATE COMMENT 'The date by which the recipient is expected to respond or take action on the transmittal, particularly relevant for approval or review purposes. Null if no response deadline applies.',
    `issue_date` DATE COMMENT 'The date when the transmittal was formally issued and dispatched to the recipient organization. Represents the principal business event timestamp for document distribution.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the transmittal record was last modified or updated. Tracks the most recent change to the record for audit and version control purposes.',
    `priority` STRING COMMENT 'Priority level assigned to the transmittal indicating the urgency of review or response required from the recipient. Guides workflow prioritization.. Valid values are `urgent|high|normal|low`',
    `purpose_of_issue` STRING COMMENT 'The intended purpose or action required from the recipient upon receiving the transmittal. Defines the business intent behind the document distribution and guides recipient response obligations.. Valid values are `for_approval|for_information|for_construction|for_record|for_review|for_comment`',
    `recipient_organization` STRING COMMENT 'Name of the organization or company receiving the transmittal. Identifies the party to whom the documents are being dispatched.',
    `reference_transmittal_number` STRING COMMENT 'Transmittal number of a previous or related transmittal that this transmittal references, supersedes, or responds to. Establishes document lineage and traceability.',
    `remarks` STRING COMMENT 'Additional notes, comments, or special instructions related to the transmittal that do not fit in other structured fields. Provides supplementary context.',
    `revision_number` STRING COMMENT 'Revision identifier for the transmittal itself if it has been reissued or updated. Tracks version history of the transmittal record.. Valid values are `^[A-Z0-9.]+$`',
    `sender_contact_name` STRING COMMENT 'Full name of the individual within the sender organization who prepared and issued the transmittal. Provides personal accountability for document distribution.',
    `sender_email` STRING COMMENT 'Email address of the sender contact for correspondence and queries related to the transmittal.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `subject` STRING COMMENT 'Brief descriptive title or subject line summarizing the content and purpose of the transmittal. Provides quick context for document package identification.',
    `transmittal_description` STRING COMMENT 'Detailed narrative description of the transmittal contents, context, and any special instructions or notes for the recipient. Provides comprehensive background information.',
    `transmittal_number` STRING COMMENT 'Unique business identifier for the transmittal as recognized by all project parties. Typically follows project-specific numbering conventions and serves as the externally-known reference for document distribution tracking.. Valid values are `^[A-Z0-9-]+$`',
    `transmittal_status` STRING COMMENT 'Current lifecycle status of the transmittal indicating its position in the document distribution workflow. Tracks progression from draft through issuance to acknowledgement or closure.. Valid values are `draft|issued|acknowledged|rejected|superseded|closed`',
    CONSTRAINT pk_transmittal PRIMARY KEY(`transmittal_id`)
) COMMENT 'Records the formal dispatch of documents, drawings, and submittals between project parties via Aconex transmittals. Captures transmittal number, issue date, sender organization, recipient organization, purpose of issue (for approval, for information, for construction, for record), document list, and acknowledgement status. Provides a legally defensible audit trail of document distribution throughout the project lifecycle.';

CREATE OR REPLACE TABLE `construction_ecm`.`design`.`rfi` (
    `rfi_id` BIGINT COMMENT 'Primary key for rfi',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Supports RFI‑to‑Agreement traceability required in the RFI Management Process and impact assessment on contract scope.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Equipment-related RFIs are a named construction process — queries about a specific assets load capacity, installation specs, or operational parameters. A construction engineer expects rfi to referenc',
    `contact_id` BIGINT COMMENT 'Foreign key linking to client.contact. Business justification: RFIs in construction are formally directed to a specific client contact (e.g., clients design manager or engineer) who is contractually responsible for responding. Tracking the client contact on an R',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project to which this RFI belongs.',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: RFI is raised by a craft worker on site to request clarification; linking captures who raised it (RFI Management Process).',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: RFIs in construction are most commonly raised about specific drawings where clarification is needed on design intent. Adding drawing_id FK to rfi enables direct linkage between an RFI and the drawing ',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: RFIs may result in cost changes; linking each RFI to the relevant cost code enables cost impact analysis.',
    `package_id` BIGINT COMMENT 'Foreign key linking to design.package. Business justification: RFIs are raised against specific design packages, seeking clarification on the content of a package issued at a project milestone. Adding package_id FK to rfi establishes this relationship, enabling a',
    `permit_condition_id` BIGINT COMMENT 'Foreign key linking to compliance.permit_condition. Business justification: RFIs often seek clarification of specific permit conditions; linking RFI to the condition it addresses enables compliance tracking.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: RFIs are raised to clarify regulatory obligations affecting design (which standard applies, what evidence is required, how an obligation is interpreted). Linking RFI to regulatory_obligation enables c',
    `specification_id` BIGINT COMMENT 'Foreign key linking to material.specification. Business justification: RFIs in construction are frequently raised to clarify or challenge material specifications (substitution requests, grade clarifications). Linking an RFI to the specific material specification being qu',
    `technical_specification_id` BIGINT COMMENT 'Foreign key linking to design.technical_specification. Business justification: RFIs are frequently raised to seek clarification on technical specifications — material requirements, workmanship standards, testing requirements. Adding technical_specification_id FK to rfi enables d',
    `wbs_element_id` BIGINT COMMENT 'Reference to the WBS element or work package to which this RFI is associated for cost and schedule tracking.',
    `work_front_id` BIGINT COMMENT 'Foreign key linking to site.work_front. Business justification: RFIs are raised from specific work fronts where a design clarification is needed to proceed. RFI management reports and site instruction workflows require knowing which work front generated the RFI to',
    `actual_response_date` DATE COMMENT 'The actual date on which the RFI response was provided and recorded in the system.',
    `closure_date` DATE COMMENT 'The date on which the RFI was formally closed after response acceptance and any required follow-up actions were completed.',
    `closure_notes` STRING COMMENT 'Additional notes or comments recorded at the time of RFI closure, documenting final resolution or outstanding items.',
    `cost_impact_amount` DECIMAL(18,2) COMMENT 'Estimated financial impact (in project currency) resulting from the RFI clarification, if applicable.',
    `cost_impact_flag` BOOLEAN COMMENT 'Indicates whether the RFI response has identified a potential cost impact to the project, triggering change order evaluation.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this RFI record was first created in the data platform.',
    `date_raised` DATE COMMENT 'The date on which the RFI was formally submitted or raised in the project management system.',
    `discipline` STRING COMMENT 'The engineering or design discipline to which this RFI pertains (e.g., architectural, structural, MEP). [ENUM-REF-CANDIDATE: architectural|structural|mechanical|electrical|plumbing|civil|geotechnical — 7 candidates stripped; promote to reference product]',
    `external_reference_code` STRING COMMENT 'The unique identifier of this RFI in the source system, used for traceability and reconciliation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this RFI record was last updated in the data platform, supporting audit trail and change tracking.',
    `priority` STRING COMMENT 'Priority level assigned to the RFI indicating urgency and impact on project schedule or critical path.. Valid values are `low|medium|high|critical`',
    `response_content` STRING COMMENT 'Detailed text of the response provided by the addressee, including clarifications, instructions, or references to supporting documentation.',
    `response_due_date` DATE COMMENT 'The contractual or agreed-upon date by which a response to the RFI is required, often tied to project schedule milestones.',
    `response_time_days` STRING COMMENT 'Calculated number of calendar days between date raised and actual response date, used for performance tracking and SLA compliance.',
    `rfi_description` STRING COMMENT 'Detailed description of the question, issue, or clarification being requested, including context and specific areas of concern.',
    `rfi_number` STRING COMMENT 'Business identifier for the RFI, typically a sequential or structured code used for tracking and reference in project documentation and correspondence.',
    `rfi_status` STRING COMMENT 'Current lifecycle status of the RFI indicating its position in the review and response workflow.. Valid values are `draft|open|pending_response|responded|closed|cancelled`',
    `schedule_impact_days` STRING COMMENT 'Estimated number of calendar days of schedule delay resulting from the RFI clarification, if applicable.',
    `schedule_impact_flag` BOOLEAN COMMENT 'Indicates whether the RFI response has identified a potential schedule impact, potentially triggering an Extension of Time (EOT) request.',
    `source_system` STRING COMMENT 'The operational system from which this RFI record was sourced (e.g., Procore RFI module, Aconex correspondence).. Valid values are `procore|aconex|bim360|other`',
    `subject` STRING COMMENT 'Brief title or subject line summarizing the nature of the clarification request.',
    CONSTRAINT pk_rfi PRIMARY KEY(`rfi_id`)
) COMMENT 'Request for Information records capturing formal queries raised by contractors seeking clarification on design intent, specifications, or contract documents. Tracks RFI number, subject, discipline, originator, addressee, date raised, response due date, actual response date, response content, cost/schedule impact assessment, linked drawing or specification reference, and closure status. High-volume transactional entity critical for design coordination and contractual record-keeping. Sourced from Procore RFI module and Aconex.';

CREATE OR REPLACE TABLE `construction_ecm`.`design`.`document_register` (
    `document_register_id` BIGINT COMMENT 'Unique identifier for the document register entry. Primary key for the document register product.',
    `agreement_id` BIGINT COMMENT 'Reference to the contract under which this document was produced or to which it is a deliverable.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project this document belongs to.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Permit Application requires linking each design document to the specific permit it satisfies for regulatory approval.',
    `rfi_id` BIGINT COMMENT 'Foreign key linking to design.rfi. Business justification: RFI is currently siloed; adding a foreign key from document_register to rfi creates an inbound link and removes the redundant string reference column.',
    `transmittal_id` BIGINT COMMENT 'Foreign key linking to design.transmittal. Business justification: Documents in the document register are issued and distributed via transmittals. The document_register table carries transmittal_number as a STRING field. Adding transmittal_id FK normalizes this to a ',
    `wbs_element_id` BIGINT COMMENT 'Reference to the WBS element or work package this document supports or relates to.',
    `approval_date` DATE COMMENT 'Date when the document received formal approval from the designated approver.',
    `approver_name` STRING COMMENT 'Name of the individual who provided final approval for the document to be issued.',
    `confidentiality_classification` STRING COMMENT 'Security classification level of the document content determining access rights and distribution restrictions.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this document register record was first created in the system.',
    `discipline` STRING COMMENT 'Engineering or construction discipline responsible for the document. [ENUM-REF-CANDIDATE: civil|structural|architectural|mechanical|electrical|plumbing|instrumentation|controls|process|geotechnical|environmental|HSE|quality|project_management — promote to reference product]',
    `distribution_list` STRING COMMENT 'Comma-separated list of parties, roles, or organizations to whom this document should be distributed.',
    `document_number` STRING COMMENT 'Unique business identifier for the document following project numbering convention. This is the externally-known document reference used across all project communications and systems.',
    `document_purpose` STRING COMMENT 'Brief statement describing the intended use and purpose of the document within the project context.',
    `document_register_status` STRING COMMENT 'Current lifecycle status of the document in the approval and distribution workflow. [ENUM-REF-CANDIDATE: draft|in_review|approved|issued_for_construction|issued_for_information|issued_for_tender|superseded|archived|void|cancelled — promote to reference product]',
    `document_title` STRING COMMENT 'Full descriptive title of the document as it appears on the document itself.',
    `document_type` STRING COMMENT 'Classification of the document by its primary purpose and content type. [ENUM-REF-CANDIDATE: specification|report|procedure|method_statement|manual|certificate|correspondence|transmittal|inspection_plan|quality_plan|test_report|safety_plan|environmental_plan|commissioning_plan|handover_document|as_built_record|warranty|permit — promote to reference product]',
    `file_format` STRING COMMENT 'Digital file format of the document (e.g., PDF for specifications, DWG for CAD drawings, RVT for Revit models). [ENUM-REF-CANDIDATE: PDF|DOCX|XLSX|DWG|RVT|IFC|XML — 7 candidates stripped; promote to reference product]',
    `file_size_mb` DECIMAL(18,2) COMMENT 'Size of the document file in megabytes for storage and transmission planning.',
    `is_client_deliverable` BOOLEAN COMMENT 'Flag indicating whether this document is a contractual deliverable to the client requiring formal acceptance.',
    `is_controlled_document` BOOLEAN COMMENT 'Flag indicating whether this document is subject to formal change control procedures and requires approval for any modifications.',
    `issue_date` DATE COMMENT 'Date when the current revision of the document was formally issued or published.',
    `keywords` STRING COMMENT 'Comma-separated list of keywords or tags for document search and categorization purposes.',
    `language_code` STRING COMMENT 'Three-letter ISO 639-2 code representing the primary language of the document content. [ENUM-REF-CANDIDATE: ENG|SPA|FRA|DEU|ARA|CHI|POR — 7 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this document register record was last updated or modified.',
    `originator` STRING COMMENT 'Organization or party responsible for creating and issuing the document (e.g., design consultant, contractor, subcontractor, client).',
    `page_count` STRING COMMENT 'Total number of pages in the document for printing and review planning purposes.',
    `retention_period_years` STRING COMMENT 'Number of years the document must be retained per regulatory, contractual, or organizational requirements before eligible for disposal.',
    `review_due_date` DATE COMMENT 'Target date by which the document review must be completed to maintain project schedule.',
    `reviewer_name` STRING COMMENT 'Name of the individual who reviewed the document for technical accuracy and completeness.',
    `revision_description` STRING COMMENT 'Brief description of the changes made in the current revision compared to the previous version.',
    `revision_number` STRING COMMENT 'Current revision identifier of the document following project revision convention (e.g., A, B, C or 01, 02, 03 or R0, R1, R2).',
    `storage_location` STRING COMMENT 'Physical or digital location where the document is stored (e.g., Aconex folder path, SharePoint site, physical archive location).',
    `superseded_by_document_number` STRING COMMENT 'Document number of the newer document that supersedes this document, if applicable. Used to maintain document lineage and version control.',
    `supersedes_document_number` STRING COMMENT 'Document number of the older document that this document supersedes or replaces.',
    CONSTRAINT pk_document_register PRIMARY KEY(`document_register_id`)
) COMMENT 'Central master register of all project documents beyond drawings — including specifications, reports, procedures, method statements, O&M manuals, certificates, and correspondence — managed in Aconex CDE (Common Data Environment). Captures document number, title, document type, discipline, revision, status, originator, issue date, confidentiality classification, retention period, and numbering convention. Provides the authoritative catalog of all project documentation per ISO 19650 information container requirements.';

CREATE OR REPLACE TABLE `construction_ecm`.`design`.`revision` (
    `revision_id` BIGINT COMMENT 'Primary key for revision',
    `document_register_id` BIGINT COMMENT 'Reference to the parent document in the document register. Links this revision to its master document record.',
    `ncr_id` BIGINT COMMENT 'Foreign key linking to quality.ncr. Business justification: Drawing and document revisions are frequently issued specifically to address NCRs requiring design correction. Linking revision to the triggering NCR enables NCR closure tracking and demonstrates desi',
    `superseded_revision_id` BIGINT COMMENT 'Reference to the previous revision that this version replaces. Maintains the revision chain and version history.',
    `transmittal_id` BIGINT COMMENT 'Foreign key linking to design.transmittal. Business justification: Each document revision is distributed to project parties via a formal transmittal. The revision table carries transmittal_number as a STRING field. Adding transmittal_id FK normalizes this to a proper',
    `approval_date` DATE COMMENT 'Date when this revision was officially approved for issuance. Represents a distinct lifecycle event in the approval workflow.',
    `approver_name` STRING COMMENT 'Full name of the individual who approved this revision for release. Authorized signatory for document issuance.',
    `author_name` STRING COMMENT 'Full name of the individual who authored or prepared this revision. Responsible party for the content creation.',
    `change_reason` STRING COMMENT 'Primary reason or trigger for this revision. Categorizes the business driver behind the document update.. Valid values are `design_change|client_request|rfi_response|regulatory_update|error_correction|clarification`',
    `change_summary` STRING COMMENT 'Concise summary of the specific changes made in this revision compared to the previous version. Highlights key modifications, additions, or deletions.',
    `checksum_hash` STRING COMMENT 'Cryptographic hash (e.g., SHA-256) of the file content. Ensures file integrity and detects unauthorized modifications.',
    `comments` STRING COMMENT 'Additional notes, remarks, or instructions related to this revision. Captures supplementary information not covered by other fields.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this revision record was first created in the system. Audit trail for record creation.',
    `distribution_list` STRING COMMENT 'Comma-separated list of recipients or distribution groups who should receive this revision. Tracks who needs to be notified of the update.',
    `file_format` STRING COMMENT 'File type or format of the document (e.g., PDF, DWG for CAD, RVT for BIM). Indicates the software required to open the file. [ENUM-REF-CANDIDATE: pdf|dwg|dxf|rvt|ifc|docx|xlsx|pptx — 8 candidates stripped; promote to reference product]',
    `file_name` STRING COMMENT 'Name of the physical file associated with this revision, including extension (e.g., Drawing_A101_RevB.pdf).',
    `file_size_bytes` BIGINT COMMENT 'Size of the document file in bytes. Used for storage management and download estimation.',
    `file_storage_path` STRING COMMENT 'Full path or URI to the physical file location in the document management system or cloud storage. Enables retrieval of the actual document file.',
    `is_controlled_copy` BOOLEAN COMMENT 'Indicates whether this revision is a controlled copy subject to formal change management. True for official project copies, false for reference or uncontrolled copies.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this revision record was last updated in the system. Audit trail for record modifications.',
    `page_count` STRING COMMENT 'Total number of pages in this revision. Used for printing, archiving, and completeness verification.',
    `review_date` DATE COMMENT 'Date when the review of this revision was completed. Represents a distinct lifecycle event in the approval workflow.',
    `reviewer_name` STRING COMMENT 'Full name of the individual who reviewed this revision for technical accuracy and completeness.',
    `revision_date` DATE COMMENT 'Date when this revision was officially issued or published. Represents the business event timestamp for the revision release.',
    `revision_description` STRING COMMENT 'Detailed narrative describing the purpose and scope of this revision. Explains what changed and why.',
    `revision_number` STRING COMMENT 'Sequential or alphanumeric identifier for this revision (e.g., Rev A, Rev 01, R1.2). Represents the version sequence within the document lifecycle.',
    `revision_status` STRING COMMENT 'Current lifecycle status of this revision. Tracks the approval and publication workflow state.. Valid values are `draft|in_review|approved|issued|superseded|obsolete`',
    `revision_type` STRING COMMENT 'Classification of the revision based on the nature and impact of changes. Distinguishes between routine updates and significant modifications.. Valid values are `initial|minor|major|emergency|regulatory`',
    `sheet_count` STRING COMMENT 'Total number of sheets or drawings in this revision (applicable for CAD and BIM documents). Used for drawing set completeness checks.',
    CONSTRAINT pk_revision PRIMARY KEY(`revision_id`)
) COMMENT 'Version control record for each document in the document register, capturing revision identifier, revision date, revision description, author, reviewer, approver, change summary, superseded revision reference, and file storage path. Maintains a complete and auditable version history for all project documents to support regulatory compliance, handover, and DLP (Defects Liability Period) obligations.';

CREATE OR REPLACE TABLE `construction_ecm`.`design`.`workflow_approval` (
    `workflow_approval_id` BIGINT COMMENT 'Unique identifier for the workflow approval instance. Primary key for the workflow approval entity.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Enables linking workflow approvals to the specific contract for regulatory compliance and audit trails.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project to which this workflow approval belongs. Enables project-level reporting and audit trails.',
    `document_register_id` BIGINT COMMENT 'Reference to the document or deliverable under review in this workflow. Links to the document management system record.',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Approval workflows in construction are phase-specific (FEED approval workflows vs. IFC approval workflows). A project manager reports approval SLA compliance and bottlenecks by phase for gate review d',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Workflow approvals are frequently triggered by regulatory obligations requiring mandatory third-party or authority review of design documents. Compliance teams must verify all obligatory approval work',
    `revision_id` BIGINT COMMENT 'Foreign key linking to design.revision. Business justification: A workflow approval instance is initiated for a specific document revision in the document control system. The workflow_approval table carries revision_number as a STRING field. Adding revision_id FK ',
    `action_date` TIMESTAMP COMMENT 'Date and time when the reviewer recorded their approval decision or action. Used for SLA compliance tracking and audit trail.',
    `action_taken` STRING COMMENT 'The decision or action recorded by the reviewer at the current workflow step. Determines routing to next step or workflow termination. [ENUM-REF-CANDIDATE: approved|approved_with_comments|rejected|no_objection|commented|delegated|returned_for_revision|acknowledged|pending — 9 candidates stripped; promote to reference product]',
    `approval_authority_level` STRING COMMENT 'The organizational or contractual authority level required to approve this workflow. Determines who has final sign-off rights per delegation of authority matrix. [ENUM-REF-CANDIDATE: project_team|discipline_lead|project_manager|design_manager|technical_director|client_representative|regulatory_authority — 7 candidates stripped; promote to reference product]',
    `assigned_reviewer_role` STRING COMMENT 'The functional role or position assigned to review the current step (e.g., Lead Engineer, Design Manager, QA/QC Manager, Project Director). Defines approval authority.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking this workflow approval to the complete audit trail log in the document management system. Supports ISO 9001 and ISO 19650 compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this workflow approval record was first created in the data platform. Audit field for data lineage and record lifecycle tracking.',
    `current_step_sequence` STRING COMMENT 'The ordinal position of the current approval step in the workflow chain. Used to track progress and determine next routing action.',
    `delegation_reason` STRING COMMENT 'Explanation provided by the original reviewer for delegating the approval to another individual (e.g., absence, conflict of interest, technical expertise).',
    `due_date` DATE COMMENT 'Target completion date for the entire workflow approval process. Derived from project schedule, contractual milestones, or regulatory deadlines.',
    `escalation_date` TIMESTAMP COMMENT 'Date and time when the workflow was escalated to higher approval authority or management attention due to delay or complexity.',
    `escalation_flag` BOOLEAN COMMENT 'Indicator of whether this workflow step was escalated to higher authority due to SLA breach, complexity, or policy requirements. True if escalated.',
    `external_reference_code` STRING COMMENT 'The unique identifier of this workflow approval in the source system (Aconex workflow ID, BIM 360 review ID). Enables bi-directional traceability.',
    `initiated_date` TIMESTAMP COMMENT 'Date and time when the workflow approval was initiated and entered the approval chain. Marks the start of the approval lifecycle and SLA clock.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this workflow approval record was last updated in the data platform. Audit field for change tracking and data freshness monitoring.',
    `last_reminder_date` TIMESTAMP COMMENT 'Date and time when the most recent reminder notification was sent to the assigned reviewer. Used to schedule next reminder per escalation policy.',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicator of whether automated notification was sent to the assigned reviewer when the workflow step was routed to them. True if notification sent.',
    `outcome_date` TIMESTAMP COMMENT 'Date and time when the final workflow outcome was determined and the approval process was closed. Marks the end of the approval lifecycle.',
    `overall_outcome` STRING COMMENT 'Final outcome of the complete workflow approval process after all steps are completed. Determines document status and next business actions.. Valid values are `approved|rejected|withdrawn|superseded|closed`',
    `priority` STRING COMMENT 'Business priority level assigned to the workflow approval. Influences SLA targets, routing urgency, and reviewer notification frequency.. Valid values are `critical|high|medium|low`',
    `regulatory_requirement_flag` BOOLEAN COMMENT 'Indicator of whether this workflow approval is required to satisfy regulatory, statutory, or building code compliance obligations. True if regulatory-driven.',
    `reminder_count` STRING COMMENT 'Number of automated reminder notifications sent to the assigned reviewer for pending action. Used to track follow-up frequency and SLA risk.',
    `reviewer_comments` STRING COMMENT 'Free-text comments, observations, or conditions recorded by the reviewer. Captures technical feedback, approval conditions, or reasons for rejection.',
    `sla_actual_hours` DECIMAL(18,2) COMMENT 'The actual elapsed time in hours from workflow step assignment to action completion. Used to calculate SLA compliance and identify bottlenecks.',
    `sla_compliance_flag` BOOLEAN COMMENT 'Indicator of whether the workflow step was completed within the SLA target duration. True if compliant, False if breached.',
    `sla_target_hours` STRING COMMENT 'The contractual or policy-defined target duration in hours for completing this workflow step. Used to measure compliance with approval turnaround commitments.',
    `source_system` STRING COMMENT 'The operational system of record from which this workflow approval instance originated (Aconex, BIM 360, Procore). Enables system-specific integration and audit.. Valid values are `aconex|bim_360|procore|other`',
    `total_steps` STRING COMMENT 'Total number of approval steps defined in the workflow template. Used to calculate completion percentage and remaining steps.',
    `workflow_name` STRING COMMENT 'Descriptive name of the workflow approval instance, typically derived from the document title or approval purpose.',
    `workflow_number` STRING COMMENT 'Business identifier for the workflow approval instance. Externally visible reference number used in correspondence and audit trails.',
    `workflow_status` STRING COMMENT 'Current lifecycle state of the workflow approval. Tracks progression through the approval chain from initiation to final outcome. [ENUM-REF-CANDIDATE: initiated|in_progress|pending_review|approved|rejected|on_hold|cancelled|completed — 8 candidates stripped; promote to reference product]',
    `workflow_type` STRING COMMENT 'Classification of the workflow approval by business purpose. Determines routing rules, SLA targets, and approval authority requirements. [ENUM-REF-CANDIDATE: design_review|submittal_approval|rfi_response|change_order_approval|drawing_approval|specification_review|technical_query|document_transmittal|noncompliance_review|method_statement_approval — 10 candidates stripped; promote to reference product]',
    CONSTRAINT pk_workflow_approval PRIMARY KEY(`workflow_approval_id`)
) COMMENT 'Formal document review and approval workflow instances tracking multi-step approval chains in Aconex and BIM 360 CDE. Captures workflow template, document under review, step sequence, assigned reviewer (role and individual), action taken (approved, rejected, commented, delegated, no objection), action date, reviewer comments, SLA target vs actual duration, and overall workflow outcome. Provides the legally required audit trail of all document approval decisions for ISO 9001 quality management, ISO 19650 information management, and contractual compliance under FIDIC/NEC.';

CREATE OR REPLACE TABLE `construction_ecm`.`design`.`handover_package` (
    `handover_package_id` BIGINT COMMENT 'Unique identifier for the handover package record. Primary key. Role: MASTER_RESOURCE.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Required for Handover Package Acceptance report that ties each package to the governing agreement.',
    `bim_model_id` BIGINT COMMENT 'Foreign key linking to design.bim_model. Business justification: Handover packages in modern construction include BIM model deliverables (ISO 19650 compliance). The handover_package table carries bim_model_reference as a STRING field. Adding bim_model_id FK normali',
    `contact_id` BIGINT COMMENT 'Foreign key linking to client.contact. Business justification: Handover packages require a sign‑off by a specific client contact; linking enables handover acceptance reports.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project for which this handover package is compiled.',
    `contract_milestone_id` BIGINT COMMENT 'Foreign key linking to contract.contract_milestone. Business justification: Handover packages are contractually tied to specific milestones (Practical Completion, DLP start). Closeout and retention release reporting requires linking each handover package to the contract miles',
    `handover_certificate_id` BIGINT COMMENT 'Foreign key linking to project.handover_certificate. Business justification: A design handover_package is the document bundle submitted to support a project handover_certificate. Construction closeout managers track which package supports each formal certificate for client acc',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Client acceptance of handover packages is contingent on permit compliance demonstration. Handover packages must reference the permits under which works were constructed. Occupation certificates and fi',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Handover packages are phase-specific in construction (mechanical completion phase, final handover phase). A project manager organizes and reports handover completeness by phase. No existing phase_id o',
    `project_budget_id` BIGINT COMMENT 'Foreign key linking to finance.project_budget. Business justification: Handover package completion triggers milestone payment certification and budget closeout in construction contracts. Linking to project_budget enables direct budget reconciliation at practical completi',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: Handover packages trigger or include regulatory submissions (as-built submissions, occupation certificate applications). Linking handover_package to regulatory_submission enables tracking of which sub',
    `site_id` BIGINT COMMENT 'Foreign key linking to site.site. Business justification: Handover packages are compiled for a specific site/facility being handed over to the client (e.g., a substation, a road section). Client acceptance, DLP tracking, and O&M documentation require linking',
    `wbs_element_id` BIGINT COMMENT 'Reference to the WBS element that this handover package is associated with, enabling alignment with project planning and cost control structures.',
    `aconex_document_reference` STRING COMMENT 'Unique document identifier in the Aconex document management system for this handover package, enabling traceability to source system.',
    `approved_by` STRING COMMENT 'Name of the individual or role who approved the handover package for submission to the client.',
    `client_acceptance_date` DATE COMMENT 'Date on which the client formally accepted the handover package, triggering DLP commencement and warranty periods.',
    `client_acceptance_status` STRING COMMENT 'Status of client acceptance for this handover package: pending, accepted, conditionally accepted, rejected, or under review.. Valid values are `pending|accepted|conditionally_accepted|rejected|under_review`',
    `comments` STRING COMMENT 'Free-text comments or notes regarding the handover package, including client feedback, revision requests, or special instructions.',
    `completeness_percentage` DECIMAL(18,2) COMMENT 'Percentage of required documents and deliverables that have been compiled and included in the handover package (0.00 to 100.00).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this handover package record was first created in the system.',
    `dlp_duration_days` STRING COMMENT 'Duration of the Defects Liability Period in days as specified in the contract for this handover package scope (commonly 365 days).',
    `dlp_end_date` DATE COMMENT 'Date on which the Defects Liability Period expires for the scope covered by this handover package, after which final release of retention may occur.',
    `dlp_start_date` DATE COMMENT 'Date on which the Defects Liability Period commences for the scope covered by this handover package, typically aligned with client acceptance or practical completion.',
    `iso_19650_compliance_flag` BOOLEAN COMMENT 'Indicates whether this handover package complies with ISO 19650-3 operational phase information requirements (True/False).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this handover package record was last updated or modified.',
    `legal_hold_flag` BOOLEAN COMMENT 'Indicates whether this handover package is subject to a legal hold for litigation support, dispute resolution, or regulatory investigation (True/False).',
    `legal_hold_reason` STRING COMMENT 'Description of the reason for the legal hold, including case reference or dispute identifier if applicable.',
    `legal_hold_start_date` DATE COMMENT 'Date on which the legal hold was placed on this handover package.',
    `package_number` STRING COMMENT 'Business identifier for the handover package, typically following project-specific numbering convention (e.g., PRJ-HP-001234). Externally-known unique code.. Valid values are `^[A-Z0-9]{2,4}-HP-[0-9]{4,6}$`',
    `package_status` STRING COMMENT 'Current lifecycle status of the handover package: draft, in preparation, under review, submitted to client, accepted, rejected, or revision required. [ENUM-REF-CANDIDATE: draft|in_preparation|under_review|submitted_to_client|accepted|rejected|revision_required — 7 candidates stripped; promote to reference product]',
    `package_title` STRING COMMENT 'Descriptive title of the handover package indicating the scope or system covered (e.g., HVAC System O&M Documentation, Structural As-Built Drawings).',
    `package_type` STRING COMMENT 'Classification of the handover package by document category: operations and maintenance manuals, as-built drawings, test and commissioning records, warranties and guarantees, certificates and approvals, or training materials.. Valid values are `operations_and_maintenance_manual|as_built_drawings|test_and_commissioning_records|warranties_and_guarantees|certificates_and_approvals|training_materials`',
    `planned_submission_date` DATE COMMENT 'Target date for submission of the handover package as per the project handover schedule and contract requirements.',
    `required_document_count` STRING COMMENT 'Total number of documents required to be included in this handover package per the contract and handover plan.',
    `retention_period_years` STRING COMMENT 'Number of years this handover package must be retained per contractual, regulatory, or organizational policy requirements.',
    `reviewed_by` STRING COMMENT 'Name of the individual or role who reviewed the handover package for completeness and compliance before submission.',
    `scope_of_works` STRING COMMENT 'Detailed description of the scope of works, systems, or areas covered by this handover package (e.g., Mechanical systems for Building A floors 1-5).',
    `storage_location` STRING COMMENT 'Physical or digital storage location where the handover package is archived (e.g., document management system path, archive facility).',
    `submission_date` DATE COMMENT 'Date on which the handover package was submitted to the client or owner for review and acceptance.',
    `submitted_document_count` STRING COMMENT 'Number of documents that have been submitted and included in the handover package to date.',
    CONSTRAINT pk_handover_package PRIMARY KEY(`handover_package_id`)
) COMMENT 'Master record for project handover and commissioning documentation packages compiled for client/owner delivery at practical completion per ISO 19650-3 operational phase requirements. Captures package number, title, scope of works covered, handover milestone, package type (O&M manuals, as-built drawings, certificates, warranties, test records), completeness percentage, client acceptance status, DLP (Defects Liability Period) start date, and legal hold flag for litigation support. Sourced from Aconex handover module.';

CREATE OR REPLACE TABLE `construction_ecm`.`design`.`handover_item` (
    `handover_item_id` BIGINT COMMENT 'Unique identifier for the handover item within the handover package tracking system.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Provides item‑level contract linkage for punch‑list tracking and final acceptance verification.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Required for Handover Package Acceptance Checklist linking each handover item to the specific equipment asset being transferred to client.',
    `bim_model_id` BIGINT COMMENT 'Foreign key linking to design.bim_model. Business justification: BIM models are a key deliverable in modern construction project handovers (ISO 19650 compliance). Adding bim_model_id FK to handover_item enables direct linkage between a handover deliverable and the ',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project for which this handover item is being delivered.',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: Handover items are assigned to a craft worker who ensures client review and acceptance (Handover Management Process).',
    `document_register_id` BIGINT COMMENT 'Foreign key linking to design.document_register. Business justification: Handover item references a master document; replace free‑text reference with FK to document_register for consistency.',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: Individual handover items frequently consist of engineering drawings (as-built drawings, record drawings). Adding drawing_id FK to handover_item enables direct linkage between a handover deliverable a',
    `handover_certificate_id` BIGINT COMMENT 'Foreign key linking to project.handover_certificate. Business justification: Individual handover items (O&M manuals, as-built drawings, warranties) are submitted as part of a formal handover certificate. Construction closeout managers track item completeness against each certi',
    `handover_package_id` BIGINT COMMENT 'Reference to the parent handover package that contains this item.',
    `inspection_record_id` BIGINT COMMENT 'Foreign key linking to equipment.inspection_record. Business justification: Pre-handover inspection certificates are mandatory handover deliverables in construction. A handover item directly references the inspection record certifying equipment readiness for client acceptance',
    `maintenance_plan_id` BIGINT COMMENT 'Foreign key linking to equipment.maintenance_plan. Business justification: Maintenance plans and O&M documentation are contractual handover deliverables in construction. A handover item references the specific maintenance plan being handed over to the client/operator — a sta',
    `permit_condition_id` BIGINT COMMENT 'Foreign key linking to compliance.permit_condition. Business justification: Specific handover items (as-built drawings, test certificates, commissioning records) are required to close out specific permit conditions. Permit condition closure tracking requires knowing which han',
    `contact_id` BIGINT COMMENT 'Foreign key linking to client.contact. Business justification: Assigns each handover item to a client contact for issue tracking and responsibility matrix.',
    `revision_id` BIGINT COMMENT 'Foreign key linking to design.revision. Business justification: A handover item references a specific approved revision of a document. The handover_item table carries revision_number as a STRING field. Adding revision_id FK normalizes this to a proper relational l',
    `specification_id` BIGINT COMMENT 'Foreign key linking to material.specification. Business justification: Handover items include material certificates and compliance evidence tied to specific material specifications. O&M manuals and as-built documentation require traceability from handover items to the ma',
    `technical_specification_id` BIGINT COMMENT 'Foreign key linking to design.technical_specification. Business justification: Handover packages in construction include technical specifications (O&M manuals, commissioning specs). Adding technical_specification_id FK to handover_item enables direct linkage between a handover d',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Handover items are traceable to WBS elements for completeness tracking and earned value reporting at closeout. A construction document controller tracks which WBS scope each handover item covers. hand',
    `actual_submission_date` DATE COMMENT 'Actual date on which the handover item was submitted to the client or project team, used to track schedule performance.',
    `approval_date` DATE COMMENT 'Date on which the handover item received final approval and was accepted as complete and compliant.',
    `certification_date` DATE COMMENT 'Date on which the handover item was certified or verified by the certifying authority.',
    `certification_required` BOOLEAN COMMENT 'Flag indicating whether this handover item requires professional certification, third-party verification, or authorized signoff.',
    `certifying_authority` STRING COMMENT 'Name of the professional engineer, inspector, or third-party organization that certified or verified this handover item.',
    `client_review_date` DATE COMMENT 'Date on which the client completed their review and provided feedback or approval decision for this handover item.',
    `client_review_status` STRING COMMENT 'Status of the client or owner review process indicating whether the handover item has been accepted, requires revision, or is pending review. [ENUM-REF-CANDIDATE: not_submitted|pending_review|under_review|approved|approved_with_comments|rejected|resubmit_required — 7 candidates stripped; promote to reference product]',
    `client_reviewer_name` STRING COMMENT 'Name of the client representative who reviewed and approved or rejected this handover item.',
    `comments` STRING COMMENT 'Additional notes, observations, or contextual information related to this handover item that do not fit other structured fields.',
    `completed_timestamp` TIMESTAMP COMMENT 'Date and time when this handover item was marked as completed and fully closed out with all requirements satisfied.',
    `contractual_requirement` BOOLEAN COMMENT 'Flag indicating whether this handover item is a mandatory contractual deliverable required by the project contract or client agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this handover item record was first created in the system.',
    `discipline` STRING COMMENT 'Engineering or construction discipline category to which this handover item belongs for organizational and filtering purposes. [ENUM-REF-CANDIDATE: civil|structural|architectural|mechanical|electrical|plumbing|hvac|instrumentation|process|general — 10 candidates stripped; promote to reference product]',
    `file_location` STRING COMMENT 'Network path, cloud storage location, or document management system reference where the electronic version of this handover item is stored.',
    `format_type` STRING COMMENT 'Delivery format required for this handover item indicating whether it must be provided as physical hard copy, electronic file, or both.. Valid values are `hard_copy|electronic|both`',
    `item_description` STRING COMMENT 'Detailed description of the handover item including scope, content, and any special requirements or conditions.',
    `item_number` STRING COMMENT 'Sequential or hierarchical numbering of the item within the handover package for tracking and reference purposes.',
    `item_status` STRING COMMENT 'Current lifecycle status of the handover item tracking its progress through preparation, submission, review, and approval stages. [ENUM-REF-CANDIDATE: not_started|in_preparation|submitted|under_review|approved|rejected|resubmitted|completed — 8 candidates stripped; promote to reference product]',
    `item_title` STRING COMMENT 'Descriptive title or name of the handover item that clearly identifies the deliverable.',
    `item_type` STRING COMMENT 'Classification of the handover deliverable item. [ENUM-REF-CANDIDATE: om_manual|as_built_drawing|fat_certificate|sat_record|warranty_certificate|commissioning_record|spare_parts_list|training_material|maintenance_schedule|test_certificate|inspection_report|compliance_certificate — promote to reference product]',
    `language` STRING COMMENT 'Primary language in which the handover item document is prepared, using ISO 639-1 two-letter language codes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this handover item record was last updated or modified in the system.',
    `outstanding_action_notes` STRING COMMENT 'Description of any outstanding actions, corrections, or additional information required to complete or close out this handover item.',
    `page_count` STRING COMMENT 'Total number of pages in the handover item document for tracking completeness and printing requirements.',
    `planned_submission_date` DATE COMMENT 'Target date by which the handover item is scheduled to be submitted to the client or project team for review.',
    `priority` STRING COMMENT 'Priority level assigned to this handover item indicating its importance and urgency for project completion and client acceptance.. Valid values are `critical|high|medium|low`',
    `rejection_reason` STRING COMMENT 'Detailed explanation of why the handover item was rejected by the client or reviewing authority, including specific deficiencies or non-conformances.',
    `responsible_party` STRING COMMENT 'Name of the organization, contractor, subcontractor, or vendor responsible for preparing and submitting this handover item.',
    `system_reference` STRING COMMENT 'Reference to the specific building system, equipment system, or facility system that this handover item documents.',
    `warranty_period_months` STRING COMMENT 'Duration of the warranty or defects liability period in months applicable to the system or equipment documented in this handover item.',
    CONSTRAINT pk_handover_item PRIMARY KEY(`handover_item_id`)
) COMMENT 'Individual document or deliverable item within a handover package, tracking item type (O&M manual, as-built drawing, FAT certificate, SAT record, warranty certificate, commissioning record, spare parts list), item status, responsible party, planned submission date, actual submission date, client review status, and outstanding action notes. Enables granular tracking of handover completeness at item level.';

CREATE OR REPLACE TABLE `construction_ecm`.`design`.`bim_model` (
    `bim_model_id` BIGINT COMMENT 'Unique identifier for the BIM model record. Primary key for the BIM model entity.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project this BIM model belongs to. Links the model to its parent project context.',
    `env_impact_assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.env_impact_assessment. Business justification: BIM models are scoped to EIA findings — design zones, lifecycle stages, and mitigation measures must align with EIA requirements. Compliance teams use BIM to verify EIA mitigation is reflected in desi',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: BIM models are produced under specific building or environmental permits. ISO 19650 compliance reporting requires linking BIM models to the permits governing the works. Permit scope verification uses ',
    `superseded_by_model_bim_model_id` BIGINT COMMENT 'Reference to the newer BIM model version that replaces this one. Null if this is the current version.',
    `author_organization` STRING COMMENT 'Organization or company responsible for authoring the BIM model (e.g., design consultant, contractor).',
    `authoring_software` STRING COMMENT 'Software application used to create and edit the BIM model (e.g., Autodesk Revit, Bentley MicroStation, ArchiCAD, Tekla Structures).',
    `building_zone` STRING COMMENT 'Specific building, zone, or facility area that this BIM model represents (e.g., Tower A, Basement Level 2, North Wing).',
    `clash_count` STRING COMMENT 'Number of unresolved clashes identified in the latest clash detection run. Zero indicates coordination clearance.',
    `clash_detection_status` STRING COMMENT 'Status of clash detection analysis for this model against other discipline models. Critical for coordination.. Valid values are `not_started|in_progress|completed|issues_identified|resolved`',
    `comments` STRING COMMENT 'Additional notes, remarks, or special instructions related to the BIM model version.',
    `confidentiality_classification` STRING COMMENT 'Data classification level for the BIM model determining access controls and distribution restrictions.. Valid values are `public|internal|confidential|restricted`',
    `coordinate_system` STRING COMMENT 'Coordinate reference system used for model positioning (e.g., WGS84, NAD83, local grid). Ensures spatial alignment across disciplines.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this BIM model record was first created in the system.',
    `discipline` STRING COMMENT 'Engineering or design discipline that owns this BIM model. Determines the technical domain and responsible team. [ENUM-REF-CANDIDATE: architectural|structural|mechanical|electrical|plumbing|civil|geotechnical|landscape|interior_design|fire_protection|telecommunications|environmental — 12 candidates stripped; promote to reference product]',
    `element_count` STRING COMMENT 'Total number of BIM elements (objects) contained in the model. Indicator of model complexity.',
    `external_reference_code` STRING COMMENT 'Identifier from the source system (Autodesk BIM 360, Bentley ProjectWise) for integration and synchronization.',
    `federation_role` STRING COMMENT 'Role of this model in federated model assembly. Determines how it integrates with other discipline models.. Valid values are `host|linked|standalone|reference`',
    `file_format` STRING COMMENT 'Native or exchange file format of the BIM model. Determines interoperability and viewing requirements. [ENUM-REF-CANDIDATE: RVT|NWD|NWC|IFC|DWG|DGN|SKP|RFA|DXF — 9 candidates stripped; promote to reference product]',
    `file_size_mb` DECIMAL(18,2) COMMENT 'Size of the BIM model file in megabytes. Used for storage planning and performance optimization.',
    `iso_19650_compliance_flag` BOOLEAN COMMENT 'Indicates whether the BIM model meets ISO 19650 information management requirements and standards.',
    `issue_date` DATE COMMENT 'Date when this version of the BIM model was formally issued or published to the project team.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this BIM model record was last updated in the system.',
    `lifecycle_stage` STRING COMMENT 'Stage of the project lifecycle this model version represents. Aligns with ISO 19650 delivery phases. [ENUM-REF-CANDIDATE: concept|design_development|construction_documentation|construction|commissioning|operations|decommissioning — 7 candidates stripped; promote to reference product]',
    `lod_classification` STRING COMMENT 'Level of Development per AIA E202 and BIMForum LOD Specification. Defines the degree of geometric detail and information richness in the model elements.. Valid values are `LOD_100|LOD_200|LOD_300|LOD_350|LOD_400|LOD_500`',
    `model_name` STRING COMMENT 'Human-readable name of the BIM model describing its content and scope (e.g., Terminal Building Level 1 Architecture, Bridge Deck Structural Model).',
    `model_number` STRING COMMENT 'Business identifier for the BIM model, typically following project naming conventions (e.g., ARC-L01-001, STR-F02-005). Used for external reference and communication.',
    `model_status` STRING COMMENT 'Current lifecycle status of the BIM model. Controls access, usage, and workflow progression.. Valid values are `wip|shared|published|archived|superseded`',
    `model_type` STRING COMMENT 'Classification of the model purpose and usage context within the project lifecycle.. Valid values are `design|coordination|construction|as_built|facility_management`',
    `model_version` STRING COMMENT 'Version identifier for this iteration of the BIM model. Tracks evolution and change history.',
    `origin_elevation_m` DECIMAL(18,2) COMMENT 'Elevation of the model origin point in meters above sea level. Provides vertical datum reference.',
    `origin_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the model origin point in decimal degrees. Establishes geolocation reference.',
    `origin_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the model origin point in decimal degrees. Establishes geolocation reference.',
    `review_date` DATE COMMENT 'Date when the BIM model review was completed and approved for issue.',
    `reviewer_name` STRING COMMENT 'Name of the individual who performed technical review of the BIM model before publication.',
    `revision_number` STRING COMMENT 'Formal revision number following project document control conventions (e.g., P01, C02, A03).',
    `software_version` STRING COMMENT 'Version number of the authoring software used to create the model. Critical for compatibility and file exchange.',
    `storage_location` STRING COMMENT 'File path or cloud storage location where the BIM model file is stored (e.g., BIM 360 project folder, SharePoint path).',
    `wbs_code` STRING COMMENT 'Work Breakdown Structure code linking the BIM model to specific project scope and cost accounts.',
    CONSTRAINT pk_bim_model PRIMARY KEY(`bim_model_id`)
) COMMENT 'Master record for each Building Information Model (BIM) asset managed in Autodesk BIM 360, Bentley ProjectWise, or equivalent platform. Captures model identity, discipline (architectural, structural, MEP, civil), authoring software and version, file format (RVT, IFC, NWD), project coordinate system, geolocation reference point, LOD (Level of Development) classification per AIA E202/BIMForum LOD Specification, model status (WIP, shared, published, archived), lifecycle stage, federation role (host/linked), and file size. SSOT for all 3D model metadata across the project portfolio, enabling federated model assembly, clash detection workflows, 4D/5D BIM integration, and ISO 19650 information management compliance.';

CREATE OR REPLACE TABLE `construction_ecm`.`design`.`drawing` (
    `drawing_id` BIGINT COMMENT 'Unique identifier for the engineering or construction drawing record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Critical for Drawing Register to associate each drawing with its contract for scope control and change management.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Equipment arrangement, installation, and as-built drawings are produced for specific assets in construction. Linking drawing to asset enables equipment drawing registers, as-built documentation retrie',
    `bim_model_id` BIGINT COMMENT 'Foreign key linking to design.bim_model. Business justification: Drawing belongs to a BIM model; replace string reference with proper FK to BIM model for traceability.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project to which this drawing belongs.',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: Installation coordination assigns a lead craft worker to each drawing for field installation oversight (Installation Coordination Process).',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Drawing production is tracked against design cost codes for earned value management and design cost control. The established model pattern (rfi, design_submittal, change_notice all carry finance_cost_',
    `package_id` BIGINT COMMENT 'Foreign key linking to design.package. Business justification: Engineering drawings are issued as part of formal design deliverable packages at project milestones. Adding package_id FK to drawing establishes this parent-child relationship. The package tables dra',
    `permit_condition_id` BIGINT COMMENT 'Foreign key linking to compliance.permit_condition. Business justification: Specific permit conditions (setback distances, noise barriers, environmental buffers) directly constrain drawing content. Design engineers must reference the condition driving each design requirement.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Issued-for-construction drawings must cite the applicable permit. Regulatory authorities require drawings to reference the permit under which works are authorized. Compliance audits trace which drawin',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Drawings are produced against WBS work packages (e.g., structural drawings for a specific WBS element). A construction engineer tracks drawing completeness by WBS scope for progress measurement and ea',
    `approval_date` DATE COMMENT 'Date when the drawing was formally approved for issue.',
    `approver_name` STRING COMMENT 'Name of the individual who approved the drawing for issue.',
    `cad_file_name` STRING COMMENT 'Name of the CAD source file from which the drawing was generated.',
    `checker_name` STRING COMMENT 'Name of the individual who performed technical checking or peer review of the drawing.',
    `clash_detection_status` STRING COMMENT 'Status of BIM clash detection analysis for this drawing (e.g., not checked, passed, clashes detected, resolved).. Valid values are `not_checked|passed|clashes_detected|resolved`',
    `comments` STRING COMMENT 'Free-text field for additional notes, remarks, or context about the drawing.',
    `confidentiality_classification` STRING COMMENT 'Data classification level indicating the sensitivity and access restrictions for the drawing.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the drawing record was first created in the system.',
    `discipline` STRING COMMENT 'Engineering discipline or trade responsible for the drawing (e.g., architectural, structural, MEP). [ENUM-REF-CANDIDATE: architectural|structural|mechanical|electrical|plumbing|civil|geotechnical|environmental — 8 candidates stripped; promote to reference product]',
    `distribution_list` STRING COMMENT 'Comma-separated list of roles, organizations, or individuals to whom the drawing was distributed.',
    `drawing_number` STRING COMMENT 'Unique alphanumeric identifier assigned to the drawing per project drawing numbering convention. Serves as the business key for the drawing register.',
    `drawing_status` STRING COMMENT 'Current lifecycle status of the drawing (e.g., draft, issued for review, issued for construction, approved, superseded, archived). [ENUM-REF-CANDIDATE: draft|issued_for_review|issued_for_approval|issued_for_construction|approved|superseded|archived — 7 candidates stripped; promote to reference product]',
    `drawing_type` STRING COMMENT 'Classification of the drawing by its representation type (e.g., plan, elevation, section, detail, schedule, isometric).. Valid values are `plan|elevation|section|detail|schedule|isometric`',
    `file_format` STRING COMMENT 'Digital file format of the drawing (e.g., PDF, DWG, DXF, RVT, IFC, DGN).. Valid values are `PDF|DWG|DXF|RVT|IFC|DGN`',
    `file_size_mb` DECIMAL(18,2) COMMENT 'Size of the drawing file in megabytes.',
    `is_client_deliverable` BOOLEAN COMMENT 'Boolean flag indicating whether the drawing is a contractual deliverable to the client.',
    `is_controlled_document` BOOLEAN COMMENT 'Boolean flag indicating whether the drawing is subject to formal document control procedures.',
    `issue_purpose` STRING COMMENT 'Purpose for which the drawing was issued (e.g., for information, for review, for approval, for construction, for tender, as-built).. Valid values are `information|review|approval|construction|tender|as_built`',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code indicating the language in which the drawing annotations are written.',
    `modified_by` STRING COMMENT 'Username or identifier of the user who last modified the drawing record in the system.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the drawing record was last modified in the system.',
    `originator` STRING COMMENT 'Name of the organization or firm that created the drawing (e.g., design consultant, engineering firm).',
    `page_count` STRING COMMENT 'Number of pages or sheets in the drawing document.',
    `retention_period_years` STRING COMMENT 'Number of years the drawing must be retained per contractual, regulatory, or organizational policy.',
    `revision_date` DATE COMMENT 'Date when the current revision of the drawing was issued.',
    `revision_number` STRING COMMENT 'Current revision identifier of the drawing (e.g., A, B, C, 01, 02). Tracks version history.',
    `scale` STRING COMMENT 'Scale ratio of the drawing (e.g., 1:100, 1:50, NTS for not to scale).',
    `sheet_size` STRING COMMENT 'Standard paper or sheet size of the drawing (e.g., A0, A1, ARCH D, ARCH E). [ENUM-REF-CANDIDATE: A0|A1|A2|A3|A4|ARCH_D|ARCH_E — 7 candidates stripped; promote to reference product]',
    `storage_location` STRING COMMENT 'File path or URI indicating where the drawing file is stored in the document management system.',
    `superseded_by_drawing_number` STRING COMMENT 'Drawing number of the newer version that supersedes this drawing.',
    `supersedes_drawing_number` STRING COMMENT 'Drawing number of the previous version that this drawing supersedes or replaces.',
    `title` STRING COMMENT 'Descriptive title of the drawing indicating the scope, location, or system depicted.',
    `zone_location` STRING COMMENT 'Physical zone, building, or location within the project site that the drawing depicts.',
    `created_by` STRING COMMENT 'Username or identifier of the user who created the drawing record in the system.',
    CONSTRAINT pk_drawing PRIMARY KEY(`drawing_id`)
) COMMENT 'Master record for each engineering and construction drawing (CAD/BIM-derived) managed across the project. Tracks drawing number, title, discipline, sheet size, scale, revision number, current status (issued for construction, issued for review, superseded), originator, and approval state. Serves as the SSOT for the drawing register aligned with Autodesk BIM 360 document control.';

CREATE OR REPLACE TABLE `construction_ecm`.`design`.`drawing_revision` (
    `drawing_revision_id` BIGINT COMMENT 'Unique identifier for each drawing revision event. Primary key for the drawing revision record.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Supports revision history linking to contract for audit of design changes against contractual scope.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project this drawing revision is associated with. Enables project-level filtering and reporting.',
    `drawing_id` BIGINT COMMENT 'Reference to the parent drawing document that this revision belongs to. Links to the master drawing record in the document management system.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Drawing revisions represent design rework events with direct cost implications tracked against design cost codes. In construction, revision costs are a key design management KPI; linking drawing_revis',
    `superseded_revision_drawing_revision_id` BIGINT COMMENT 'Reference to the previous revision that this revision replaces or supersedes. Maintains the version control chain and audit trail.',
    `transmittal_id` BIGINT COMMENT 'Foreign key linking to design.transmittal. Business justification: Each drawing revision is distributed via a formal transmittal in construction document management. The drawing_revision table carries transmittal_number as a STRING field. Adding transmittal_id FK nor',
    `acknowledgment_required_flag` BOOLEAN COMMENT 'Indicates whether recipients are required to formally acknowledge receipt and review of this revision. Used for critical or contractual revisions.',
    `acknowledgment_status` STRING COMMENT 'Current status of acknowledgment from recipients. Tracks whether required acknowledgments have been received.. Valid values are `not_required|pending|acknowledged|overdue`',
    `approval_date` DATE COMMENT 'Date when this revision received formal approval for issuance. Marks the transition from draft to approved status.',
    `approver_name` STRING COMMENT 'Full name of the individual who approved this revision. Provides human-readable identification for the approval authority.',
    `bim_model_reference` STRING COMMENT 'Reference identifier to the BIM model or IFC file that this 2D drawing revision is derived from or coordinated with. Maintains linkage between 3D models and 2D deliverables.',
    `change_summary` STRING COMMENT 'Brief summary of the key changes introduced in this revision. Provides quick reference for stakeholders reviewing revision history.',
    `clash_detection_status` STRING COMMENT 'Status of clash detection analysis for this revision. Indicates whether the design has been checked for spatial conflicts with other disciplines and the outcome.. Valid values are `not_required|pending|in_progress|passed|failed|resolved`',
    `comments` STRING COMMENT 'Additional notes, remarks, or contextual information about this revision. Provides space for supplementary details not captured in structured fields.',
    `confidentiality_level` STRING COMMENT 'Security classification level of this drawing revision. Controls access permissions and distribution restrictions.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this revision record was first created in the data management system. Audit trail for data lineage.',
    `discipline` STRING COMMENT 'The engineering or design discipline responsible for this drawing revision. Enables discipline-based filtering and workflow routing. [ENUM-REF-CANDIDATE: architectural|structural|mechanical|electrical|plumbing|civil|geotechnical|environmental|surveying|landscape — 10 candidates stripped; promote to reference product]',
    `distribution_date` DATE COMMENT 'Date when this revision was distributed to project stakeholders. Marks the formal communication of the revision to the project team.',
    `distribution_method` STRING COMMENT 'The method or channel used to distribute this revision to stakeholders. Tracks whether distribution was electronic, physical, or both.. Valid values are `electronic|hard_copy|both|portal|email`',
    `distribution_status` STRING COMMENT 'Current state of the distribution process for this revision. Tracks whether the revision has been sent to stakeholders and their acknowledgment status.. Valid values are `pending|distributed|acknowledged|rejected|superseded`',
    `file_format` STRING COMMENT 'The digital file format of this revision (e.g., PDF for distribution, DWG for CAD native, IFC for BIM exchange). Supports format-based filtering and compatibility checks. [ENUM-REF-CANDIDATE: PDF|DWG|DXF|IFC|RVT|DGN|TIFF — 7 candidates stripped; promote to reference product]',
    `file_size_mb` DECIMAL(18,2) COMMENT 'Size of the revision file in megabytes. Used for storage management and transmission planning.',
    `issuing_engineer_name` STRING COMMENT 'Full name of the engineer who prepared and issued this revision. Provides human-readable identification for audit and communication purposes.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this revision record was last updated. Tracks the most recent change to the record for audit and synchronization purposes.',
    `review_date` DATE COMMENT 'Date when the technical review of this revision was completed. Tracks the review milestone in the approval workflow.',
    `reviewer_name` STRING COMMENT 'Full name of the individual who reviewed this revision. Provides human-readable identification for the review step in the approval workflow.',
    `revision_code` STRING COMMENT 'Alphanumeric code identifying the specific revision version (e.g., A, B, C, P01, P02 for preliminary, C01 for construction issue). Follows project-specific or organizational revision coding standards.. Valid values are `^[A-Z0-9]{1,10}$`',
    `revision_date` DATE COMMENT 'The date when this revision was officially issued or released. Represents the business event timestamp for the revision lifecycle.',
    `revision_description` STRING COMMENT 'Detailed narrative describing the specific changes, modifications, or updates made in this revision. Provides context for what was altered from the previous version.',
    `revision_number` STRING COMMENT 'Sequential numeric identifier for the revision within the drawing lifecycle. Increments with each new revision to maintain chronological order.',
    `revision_reason` STRING COMMENT 'Categorical classification of the business driver or trigger that necessitated this revision. Enables analysis of revision patterns and root causes. [ENUM-REF-CANDIDATE: rfi_response|design_change|client_instruction|coordination_issue|code_compliance|value_engineering|constructability_review|error_correction|scope_change|material_substitution|site_condition|regulatory_requirement — 12 candidates stripped; promote to reference product]',
    `revision_status` STRING COMMENT 'Current state of the revision in its approval and distribution workflow. Tracks progression from draft through review, approval, issuance, and eventual supersession. [ENUM-REF-CANDIDATE: draft|in_review|approved|issued|superseded|void|archived — 7 candidates stripped; promote to reference product]',
    `revision_type` STRING COMMENT 'Classification of the intended purpose or stage of the revision within the project lifecycle. Distinguishes between preliminary design, construction issue, as-built documentation, etc. [ENUM-REF-CANDIDATE: preliminary|for_approval|for_construction|for_tender|as_built|record|coordination — 7 candidates stripped; promote to reference product]',
    `sheet_count` STRING COMMENT 'Number of sheets or pages in this drawing revision. Relevant for multi-sheet drawings and printing logistics.',
    `wbs_code` STRING COMMENT 'The WBS element or work package code that this drawing revision is associated with. Enables project structure-based reporting and cost allocation.',
    CONSTRAINT pk_drawing_revision PRIMARY KEY(`drawing_revision_id`)
) COMMENT 'Transactional record capturing each revision event for a drawing. Stores revision code, revision date, description of changes, reason for revision (RFI-driven, design change, client instruction), issuing engineer, reviewer, approver, and distribution status. Enables full version-control audit trail for IFC/CAD drawing lifecycle.';

CREATE OR REPLACE TABLE `construction_ecm`.`design`.`technical_specification` (
    `technical_specification_id` BIGINT COMMENT 'Unique identifier for the technical specification document. Primary key for this entity.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Enables Specification‑to‑Contract mapping required for compliance verification and cost control.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project this technical specification belongs to. Links specification to project scope and WBS (Work Breakdown Structure).',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Technical specifications are design deliverables with production costs tracked against cost codes. In construction design management, specification authoring is a billable activity assigned to cost co',
    `labor_cost_code_id` BIGINT COMMENT 'Foreign key linking to workforce.labor_cost_code. Business justification: Cost estimating and budget control: technical specification sections are mapped to labor cost codes during project setup. This enables labor budget tracking by spec section and supports certified payr',
    `master_id` BIGINT COMMENT 'Foreign key linking to material.material_master. Business justification: Technical specifications list required materials; FK to material_master supports compliance checks and sourcing.',
    `package_id` BIGINT COMMENT 'Foreign key linking to design.package. Business justification: Technical specifications are issued as part of formal design deliverable packages at project milestones (30%, 60%, 90%, IFC). Adding package_id FK to technical_specification establishes this parent-ch',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Technical specifications (environmental, noise, dust control) are written under specific permits. Compliance audits require traceability from permit to specification. Permit scope verification depends',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Technical specifications are issued per project phase (FEED specs, detailed design specs, IFC specs). A specification manager tracks specification completeness and approval status by phase for gate re',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Technical specifications encode regulatory obligations (EPA discharge limits, noise standards, heritage requirements). Compliance gap analysis requires tracing which obligations are addressed by which',
    `skill_trade_id` BIGINT COMMENT 'Foreign key linking to workforce.skill_trade. Business justification: Workforce planning and estimating: technical specifications define the required trade discipline (ironworker, electrician, pipefitter) for executing each spec section. Estimators and planners map spec',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Technical specifications are written for specific WBS work packages (e.g., concrete spec for structural WBS). A construction engineer tracks which specifications govern each WBS scope for quality and ',
    `applicable_standards` STRING COMMENT 'Comma-separated list of industry standards, codes, and regulations that govern this specification (e.g., ACI 318, AISC 360, NFPA 70, ASTM C150, BS EN 1992).',
    `approval_date` DATE COMMENT 'Date when the specification received formal approval from the designated approval authority (client, design manager, or regulatory body).',
    `approval_status` STRING COMMENT 'Formal approval state indicating whether the specification has received necessary sign-offs from design authority, client, or regulatory bodies.. Valid values are `pending|approved|rejected|conditional|not_required`',
    `approver_name` STRING COMMENT 'Name of the individual with authority who formally approved this specification for issue and use in construction.',
    `approver_role` STRING COMMENT 'Role or position of the approver (e.g., Lead Structural Engineer, Design Manager, Client Representative, QA/QC Manager).',
    `author_name` STRING COMMENT 'Name of the engineer or technical specialist who authored or prepared this specification document.',
    `author_organization` STRING COMMENT 'Organization or company responsible for authoring the specification (e.g., design consultant, engineering firm, EPC contractor).',
    `boq_reference` STRING COMMENT 'Reference to BOQ line items or sections that are governed by this technical specification, linking design requirements to cost estimation and procurement.',
    `comments` STRING COMMENT 'Additional notes, clarifications, or context regarding this specification, including change reasons, special instructions, or coordination notes.',
    `confidentiality_classification` STRING COMMENT 'Data classification level indicating the sensitivity and access restrictions for this specification document.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this specification record was first created in the system, supporting audit trail and data lineage.',
    `csi_division` STRING COMMENT 'CSI MasterFormat division number (e.g., Division 03 - Concrete, Division 23 - HVAC) organizing specifications by construction work results.',
    `discipline` STRING COMMENT 'Engineering discipline or trade category to which this specification applies. Used for organizing specifications by technical domain within MEP (Mechanical Electrical and Plumbing) and other construction disciplines. [ENUM-REF-CANDIDATE: civil|structural|architectural|mechanical|electrical|plumbing|hvac|instrumentation|process|geotechnical|environmental — 11 candidates stripped; promote to reference product]',
    `effective_date` DATE COMMENT 'Date from which this specification becomes binding and applicable to construction activities, procurement, and quality control.',
    `environmental_requirements` STRING COMMENT 'Environmental compliance requirements including LEED (Leadership in Energy and Environmental Design) criteria, sustainability standards, emissions limits, and waste management provisions.',
    `file_format` STRING COMMENT 'Digital file format of the specification document (e.g., PDF, DOCX, native CAD format). [ENUM-REF-CANDIDATE: pdf|docx|doc|xlsx|dwg|ifc|native — 7 candidates stripped; promote to reference product]',
    `file_storage_path` STRING COMMENT 'Network path, document management system location, or cloud storage URI where the specification document file is stored (e.g., Aconex document ID, BIM 360 path).',
    `hse_requirements` STRING COMMENT 'Health, safety, and environmental requirements specific to this specification including PPE (Personal Protective Equipment), hazard controls, and OSHA compliance.',
    `is_client_deliverable` BOOLEAN COMMENT 'Flag indicating whether this specification is a contractual deliverable to the client or owner, requiring formal submission and acceptance.',
    `issue_date` DATE COMMENT 'Date when the current revision of the technical specification was formally issued or published to the project team.',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code indicating the language in which the specification is written (e.g., EN for English, FR for French, AR for Arabic).',
    `material_requirements` STRING COMMENT 'Detailed requirements for materials including grades, properties, certifications, and acceptance criteria (e.g., concrete strength class C30/37, steel grade S355, ASTM A615 Grade 60 rebar).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this specification record, tracking change history and currency of information.',
    `page_count` STRING COMMENT 'Total number of pages in the specification document, used for document management and completeness verification.',
    `reviewer_name` STRING COMMENT 'Name of the individual who performed technical review or quality check of the specification before approval.',
    `revision_number` STRING COMMENT 'Current revision identifier for the specification document, tracking version history and change control (e.g., Rev 0, Rev A, Rev 1.2).',
    `scope_of_work` STRING COMMENT 'Detailed description of the work, materials, equipment, or systems covered by this technical specification, defining boundaries and inclusions.',
    `section_number` STRING COMMENT 'Detailed section number within CSI MasterFormat or project specification structure (e.g., 03 30 00 for Cast-in-Place Concrete, 23 05 13 for Common Motor Requirements for HVAC Equipment).',
    `specification_number` STRING COMMENT 'Unique business identifier for the technical specification document, typically following organizational or project numbering conventions (e.g., SPEC-MEP-001, TS-2024-HVAC-05).',
    `specification_title` STRING COMMENT 'Full descriptive title of the technical specification document, clearly identifying the scope of work, materials, or systems covered.',
    `specification_type` STRING COMMENT 'Classification of specification approach: performance-based (outcome-focused), prescriptive (method-focused), proprietary (brand-specific), reference (standard-based), or master (template).. Valid values are `performance|prescriptive|proprietary|reference|master`',
    `submittal_requirements` STRING COMMENT 'List of required submittals including shop drawings, product data, samples, test reports, and certifications that must be provided for approval.',
    `superseded_date` DATE COMMENT 'Date when this specification was replaced by a newer revision or cancelled, marking the end of its active lifecycle.',
    `supersedes_specification_number` STRING COMMENT 'Specification number of the previous version that this revision replaces, maintaining document lineage and change history.',
    `technical_specification_status` STRING COMMENT 'Current lifecycle status of the technical specification document within the document control workflow. [ENUM-REF-CANDIDATE: draft|in_review|approved|issued_for_construction|superseded|archived|cancelled — 7 candidates stripped; promote to reference product]',
    `testing_requirements` STRING COMMENT 'Required tests, inspections, and acceptance criteria including FAT (Factory Acceptance Test), SAT (Site Acceptance Test), and ITP (Inspection and Test Plan) references.',
    `warranty_period_months` STRING COMMENT 'Duration in months for which materials, equipment, or workmanship covered by this specification must be warranted, typically aligned with DLP (Defects Liability Period).',
    `workmanship_standards` STRING COMMENT 'Standards and requirements for execution, installation, fabrication, and construction methods to ensure quality workmanship.',
    CONSTRAINT pk_technical_specification PRIMARY KEY(`technical_specification_id`)
) COMMENT 'Master record for each technical specification document governing materials, workmanship, and construction methods. Captures spec number, title, discipline, applicable standards (ACI, AISC, NFPA), revision status, approval state, and scope of work section reference. Linked to WBS elements and BOQ line items for design-build scope management.';

CREATE OR REPLACE TABLE `construction_ecm`.`design`.`package` (
    `package_id` BIGINT COMMENT 'Unique identifier for the design deliverable package. Primary key.',
    `agreement_id` BIGINT COMMENT 'Reference to the contract under which this deliverable package is required.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Design packages are formally issued to a specific client organisation for review and acceptance. Client deliverable reporting, package status dashboards by client, and contractual submission tracking ',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project this package belongs to.',
    `env_impact_assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.env_impact_assessment. Business justification: Design packages (environmental management, drainage, noise) are directly scoped to EIA findings and mitigation measures. Linking package to EIA enables verification that all design packages address EI',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Design packages are key deliverables in construction EVM; their production cost is tracked against cost codes for design budget management. Package submission milestones are cost-bearing events requir',
    `hse_plan_id` BIGINT COMMENT 'Foreign key linking to safety.hse_plan. Business justification: Each design/work package issued for construction must reference its governing HSE plan before work commences — a standard construction project control gate. HSE managers and package engineers use this',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Design packages are issued under specific permits (civil works package under earthworks permit, structural package under building permit). Compliance audits require tracing which packages are covered ',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Design packages are organized by project phase (concept, FEED, detailed design, IFC). A design manager reports package completeness and submission status by phase for gate review decisions. No existin',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Design packages are produced for specific WBS work packages. A design manager tracks which WBS scope each package covers for completeness reporting and earned value calculation. package.wbs_code is a ',
    `actual_submission_date` DATE COMMENT 'Actual date when the package was submitted to the client or reviewing authority.',
    `approval_date` DATE COMMENT 'Date when the package received final internal approval for issuance.',
    `approval_workflow_state` STRING COMMENT 'Current state of the internal approval workflow for this package before external submission. [ENUM-REF-CANDIDATE: not_started|in_progress|pending_review|pending_approval|approved|rejected|on_hold — 7 candidates stripped; promote to reference product]',
    `approved_by` STRING COMMENT 'Name of the individual with authority who approved the package for issuance.',
    `client_acceptance_date` DATE COMMENT 'Date when the client formally accepted the package.',
    `client_acceptance_status` STRING COMMENT 'Client or authority acceptance decision status for the submitted package.. Valid values are `pending|accepted|accepted_with_comments|rejected|conditionally_accepted|superseded`',
    `comments` STRING COMMENT 'Additional notes, remarks, or instructions related to this package.',
    `completeness_percentage` DECIMAL(18,2) COMMENT 'Percentage of required deliverable items completed within this package (0.00 to 100.00).',
    `confidentiality_classification` STRING COMMENT 'Data classification level indicating the sensitivity and access restrictions for this package.. Valid values are `public|internal|confidential|restricted`',
    `contractual_due_date` DATE COMMENT 'Contractually mandated deadline for package submission to client or authority.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this package record was first created in the system.',
    `discipline` STRING COMMENT 'Primary engineering or design discipline responsible for this package. [ENUM-REF-CANDIDATE: architectural|structural|mechanical|electrical|plumbing|civil|geotechnical|environmental|multidisciplinary — 9 candidates stripped; promote to reference product]',
    `document_count` STRING COMMENT 'Total number of documents (drawings, specifications, reports, models) included in this package.',
    `drawing_count` STRING COMMENT 'Number of CAD drawings included in this package.',
    `iso_19650_compliance_flag` BOOLEAN COMMENT 'Indicates whether this package complies with ISO 19650 information management standards.',
    `issue_date` DATE COMMENT 'Date when the package was formally issued to recipients or stakeholders.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this package record was last updated or modified.',
    `package_number` STRING COMMENT 'Business identifier for the design deliverable package, typically following project numbering conventions (e.g., PKG-001, DP-2023-045).',
    `package_status` STRING COMMENT 'Current lifecycle status of the design deliverable package in the approval and submission workflow. [ENUM-REF-CANDIDATE: draft|in_review|approved|issued|submitted|accepted|rejected|superseded|cancelled — 9 candidates stripped; promote to reference product]',
    `package_type` STRING COMMENT 'Classification of the package based on its purpose and content type within the project lifecycle.. Valid values are `design_package|deliverable_package|submittal_package|handover_package|as_built_package|coordination_package`',
    `planned_issue_date` DATE COMMENT 'Originally scheduled date for package issuance as per project baseline schedule.',
    `recipient_distribution_list` STRING COMMENT 'Comma-separated list of organizations or individuals to whom this package is distributed.',
    `rejection_reason` STRING COMMENT 'Explanation provided by client or reviewer for package rejection or conditional acceptance.',
    `responsible_organization` STRING COMMENT 'Name of the organization (contractor, consultant, JV partner) responsible for preparing this package.',
    `reviewed_by` STRING COMMENT 'Name of the individual or team who performed technical review of the package.',
    `revision_number` STRING COMMENT 'Revision identifier for this package version (e.g., Rev 0, Rev A, Rev 1).',
    `specification_count` STRING COMMENT 'Number of technical specifications included in this package.',
    `storage_location` STRING COMMENT 'File system path, document management system location, or cloud storage URI where the package files are stored.',
    `submission_status` STRING COMMENT 'Current status of the package submission to client or reviewing authority.. Valid values are `not_submitted|submitted|under_review|resubmission_required|accepted|rejected`',
    `supersedes_package_number` STRING COMMENT 'Package number of the previous version that this package replaces or supersedes.',
    `title` STRING COMMENT 'Descriptive title of the design deliverable package indicating its scope and content.',
    `transmittal_number` STRING COMMENT 'Reference number of the transmittal document used to formally issue this package.',
    CONSTRAINT pk_package PRIMARY KEY(`package_id`)
) COMMENT 'Master record representing a formal design deliverable package issued at a project milestone (30%, 60%, 90%, IFC, As-Built). Groups related drawings, specifications, calculations, and BIM models into a contractual issuance unit. Tracks package number, milestone stage, discipline, issue date, contractual due date, recipient distribution list, submission status, client acceptance status, and approval workflow state. Also serves as the contractual deliverable register (DDR), tracking each required deliverable item with its type (drawing, specification, report, model, calculation), responsible discipline, milestone linkage, planned vs. actual submission dates, and client acceptance status. SSOT for design deliverable scheduling, contractual compliance monitoring, and milestone gate readiness assessment.';

CREATE OR REPLACE TABLE `construction_ecm`.`design`.`submittal` (
    `submittal_id` BIGINT COMMENT 'Unique identifier for the design submittal record. Primary key for the design submittal entity.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Links each submittal to its contract for tracking submission deadlines and contractual obligations.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to client.contact. Business justification: Design submittals require formal client approval by a named client contact (e.g., clients engineer or project manager). Tracking the approving client contact enables submittal approval cycle-time rep',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Equipment Submittal Review requires associating each design submittal with the specific equipment asset it documents.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project to which this submittal belongs.',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: Design submittal is generated from a specific drawing, may be triggered by an RFI and sent via a transmittal; replace free‑text references with FKs.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Submittals are associated with cost items; linking to cost code supports cost allocation and audit of submitted items.',
    `master_id` BIGINT COMMENT 'Foreign key linking to material.material_master. Business justification: Material submittals reference specific material master records for approval and traceability.',
    `package_id` BIGINT COMMENT 'Foreign key linking to design.package. Business justification: A design submittal is part of a formal design deliverable package. Design submittals are issued as part of package submissions at project milestones. Adding package_id FK to design_submittal establish',
    `permit_condition_id` BIGINT COMMENT 'Foreign key linking to compliance.permit_condition. Business justification: Design submittals are frequently required to close out specific permit conditions (e.g., a condition requiring submission of traffic management plans, noise management plans). Permit condition closure',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Design submittals are submitted for permit approval; associating each submittal with its permit tracks compliance status.',
    `project_budget_id` BIGINT COMMENT 'Foreign key linking to finance.project_budget. Business justification: Design submittals with cost_impact_flag=true must be reconciled against a specific project budget line. Construction project controls require submittal cost impacts to be tracked against the budget fo',
    `project_milestone_id` BIGINT COMMENT 'Foreign key linking to project.project_milestone. Business justification: Design submittals are contractually tied to milestones (e.g., IFC drawing submission milestone). A construction PM tracks submittal status against milestone dates for LD exposure and contract complian',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Design submittals are made to satisfy specific regulatory obligations (mandatory submission of structural calculations to building authority, fire engineering reports to fire authority). Linking submi',
    `rfi_id` BIGINT COMMENT 'Foreign key linking to design.rfi. Business justification: Link submittal to the originating RFI for clear traceability of query‑response flow.',
    `specification_id` BIGINT COMMENT 'Foreign key linking to material.specification. Business justification: Material submittals (a primary use of design_submittal) require the contractor to demonstrate that proposed materials meet the material specification. Linking design_submittal to material.specificatio',
    `technical_specification_id` BIGINT COMMENT 'Foreign key linking to design.technical_specification. Business justification: A design submittal is submitted in compliance with a specific technical specification section. The design_submittal table carries specification_section as a STRING field. Adding technical_specificatio',
    `trade_package_id` BIGINT COMMENT 'Foreign key linking to subcontractor.trade_package. Business justification: Submittal process is tied to a specific trade package; linking enables verification of subcontractor responsibility and audit of submission compliance.',
    `transmittal_id` BIGINT COMMENT 'Foreign key linking to design.transmittal. Business justification: Link submittal to the transmittal that delivered it, enabling end‑to‑end document flow tracking.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Design submittals are submitted against specific WBS work packages for scope traceability. A document controller tracks which WBS scope each submittal covers for contract compliance and progress measu',
    `work_front_id` BIGINT COMMENT 'Foreign key linking to site.work_front. Business justification: Design submittals (shop drawings, material submittals) are submitted for approval before work proceeds on a specific work front. Submittal tracking dashboards require this link to confirm all required',
    `actual_review_date` DATE COMMENT 'Actual date on which the review was completed and the submittal disposition was communicated back to the submitting party.',
    `actual_submission_date` DATE COMMENT 'Actual date on which the submittal was formally submitted to the reviewing authority, used for schedule performance tracking and SLA compliance.',
    `approval_authority_level` STRING COMMENT 'Classification of the approval authority indicating the organizational level or role responsible for final disposition: contractor for internal review, design_consultant for technical design review, client for owner acceptance, regulatory_authority for statutory compliance, independent_verifier for third-party certification.. Valid values are `contractor|design_consultant|client|regulatory_authority|independent_verifier`',
    `approval_disposition` STRING COMMENT 'Final disposition code assigned by the reviewing authority indicating the outcome of the review: approved for full acceptance without changes, approved_as_noted for conditional acceptance with minor comments that do not require resubmission, revise_and_resubmit for rework and formal resubmission required, rejected for non-compliance requiring major revision, no_exception_taken for acknowledgment without formal approval, reviewed_for_information for informational submittals not requiring approval.. Valid values are `approved|approved_as_noted|revise_and_resubmit|rejected|no_exception_taken|reviewed_for_information`',
    `approver_name` STRING COMMENT 'Full name of the individual with approval authority who formally authorized the submittal disposition, may be the same as reviewer or a senior authority depending on approval matrix.',
    `attachment_count` STRING COMMENT 'Number of supporting documents, drawings, data sheets, or files attached to this submittal, used for completeness verification and document control.',
    `bim_model_reference` STRING COMMENT 'Reference to the BIM model element, object identifier, or model file that this submittal relates to, enabling integration between physical submittals and digital BIM coordination.',
    `closure_date` DATE COMMENT 'Date on which the submittal was formally closed, indicating that all review cycles are complete, all comments are addressed, and the item is approved for construction or procurement.',
    `confidentiality_level` STRING COMMENT 'Data classification level indicating the sensitivity and access restrictions for this submittal: public for unrestricted information, internal for company-internal use, confidential for business-sensitive information, restricted for highly sensitive or proprietary data.. Valid values are `public|internal|confidential|restricted`',
    `cost_impact_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this submittal has potential cost implications, such as value engineering proposals, material substitutions, or design changes affecting project budget.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp recording when this submittal record was first created in the document management system, used for audit trail and record lifecycle tracking.',
    `discipline` STRING COMMENT 'Engineering or design discipline responsible for this submittal, used for routing and review assignment. [ENUM-REF-CANDIDATE: architectural|structural|mechanical|electrical|plumbing|civil|geotechnical|environmental — 8 candidates stripped; promote to reference product]',
    `estimated_cost_impact_amount` DECIMAL(18,2) COMMENT 'Estimated financial impact (positive or negative) associated with this submittal, expressed in the project base currency. Positive values indicate cost increases, negative values indicate savings.',
    `file_format` STRING COMMENT 'Primary file format of the submittal package, indicating the digital format used for submission (PDF for documents, DWG/DXF for CAD drawings, RVT for Revit models, IFC for BIM exchange, XLSX for spreadsheets, DOCX for text documents, ZIP for compressed packages). [ENUM-REF-CANDIDATE: PDF|DWG|DXF|RVT|IFC|XLSX|DOCX|ZIP — 8 candidates stripped; promote to reference product]',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp recording the most recent update to this submittal record, used for change tracking and audit trail purposes.',
    `priority` STRING COMMENT 'Priority classification indicating the urgency and schedule impact of this submittal: critical for items on the critical path requiring immediate review, high for near-term procurement or construction activities, medium for standard schedule items, low for long-lead or informational items.. Valid values are `critical|high|medium|low`',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory body or statutory authority whose approval or compliance verification is required for this submittal (e.g., local building department, fire marshal, environmental agency).',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this submittal requires verification of compliance with statutory regulations, building codes, or regulatory authority approvals (e.g., OSHA, EPA, local building department).',
    `required_submission_date` DATE COMMENT 'Contractually mandated or schedule-driven date by which the submittal must be submitted to the design team or client for review, typically derived from the project schedule and procurement lead times.',
    `response_notes` STRING COMMENT 'Response notes provided by the submitting party addressing reviewer comments, documenting how comments were incorporated or providing justification for alternative approaches.',
    `review_comments` STRING COMMENT 'Detailed technical comments, observations, and instructions provided by the reviewing authority during the review process, documenting required corrections, clarifications, or conditions of approval.',
    `review_due_date` DATE COMMENT 'Target date by which the reviewing authority (design consultant, client representative) is expected to complete their review and return the submittal with disposition, typically governed by contract SLA terms.',
    `reviewer_name` STRING COMMENT 'Full name of the individual who performed the technical review and assigned the disposition for this submittal.',
    `reviewing_organization` STRING COMMENT 'Name of the organization responsible for reviewing and approving this submittal, typically the design consultant, architect, or client representative.',
    `revision_number` STRING COMMENT 'Revision identifier for this submittal, incremented with each resubmission following review comments or rejection, typically using alphanumeric convention (e.g., A, B, C or 01, 02, 03).',
    `schedule_impact_days` STRING COMMENT 'Number of calendar days by which the project schedule would be delayed if this submittal is not approved by the review due date, used for schedule risk analysis.',
    `schedule_impact_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether delays in reviewing or approving this submittal will impact the project critical path or key milestone dates.',
    `submittal_number` STRING COMMENT 'Unique business identifier for the submittal within the project, typically following a project-specific numbering convention (e.g., S-001, SUB-MEP-001).',
    `submittal_status` STRING COMMENT 'Current lifecycle status of the submittal in the review and approval workflow. Draft indicates preparation phase, submitted indicates formal lodgment, under_review indicates active evaluation, approved indicates full acceptance, approved_as_noted indicates conditional acceptance with minor comments, revise_and_resubmit indicates rework required, rejected indicates non-compliance, withdrawn indicates contractor cancellation, superseded indicates replacement by newer revision. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|approved_as_noted|revise_and_resubmit|rejected|withdrawn|superseded — 9 candidates stripped; promote to reference product]',
    `submittal_type` STRING COMMENT 'Classification of the submittal item indicating the nature of the submission: shop drawings for fabrication details, product data sheets for material specifications, physical samples for approval, method statements for construction procedures, mix designs for concrete/asphalt, calculations for structural/MEP systems, or test reports for quality verification. [ENUM-REF-CANDIDATE: shop_drawing|product_data|sample|method_statement|mix_design|calculation|test_report — 7 candidates stripped; promote to reference product]',
    `submitting_organization` STRING COMMENT 'Name of the contractor, subcontractor, or supplier organization responsible for preparing and submitting this submittal.',
    `supersedes_submittal_number` STRING COMMENT 'Reference to the previous submittal number that this revision supersedes, establishing the revision chain and audit trail.',
    `title` STRING COMMENT 'Descriptive title of the submittal item identifying the material, product, or system being submitted for review.',
    CONSTRAINT pk_submittal PRIMARY KEY(`submittal_id`)
) COMMENT 'Transactional record for each design-phase submittal item tracking contractor-submitted shop drawings, material data sheets, product samples, and method statements through the review and approval lifecycle. Includes register-level metadata (specification section, required submission date, contractual obligation) and item-level tracking (submission date, review status, approval authority, disposition).';

CREATE OR REPLACE TABLE `construction_ecm`.`design`.`review` (
    `review_id` BIGINT COMMENT 'Unique identifier for the design review event. Primary key for the review product.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Needed for Review Minutes linking to the contract that defines review scope and client approval requirements.',
    `bim_model_id` BIGINT COMMENT 'Foreign key linking to design.bim_model. Business justification: Design reviews in construction frequently involve BIM model clash detection and model-based reviews. The review table carries bim_model_reference as a STRING field. Adding bim_model_id FK normalizes t',
    `contact_id` BIGINT COMMENT 'Foreign key linking to client.contact. Business justification: Design reviews require formal client representative sign-off. The review product has client_approval_required and client_approval_date fields, and client_representative_name as a plain-text denormaliz',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project to which this design review belongs.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Formal design reviews (IDR, IFC, regulatory) incur costs — internal reviewer time and external review fees — tracked against design cost codes. Construction project controls require review costs to be',
    `package_id` BIGINT COMMENT 'Foreign key linking to design.package. Business justification: A formal design review is conducted against a specific design deliverable package. The review table carries design_package_reference as a STRING field — a denormalized reference. Adding package_id FK ',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Design reviews are scoped to verify compliance with specific permits (e.g., permit-required independent design review by a regulatory authority). The review record must reference the permit it satisfi',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Design reviews are phase-specific (FEED review, detailed design review, IFC review). A design manager reports review completion and comment resolution rates by phase for gate review decisions. No exis',
    `project_milestone_id` BIGINT COMMENT 'Foreign key linking to project.project_milestone. Business justification: Design gate reviews (IFR, IFA, IFC) are contractual milestones. A construction PM tracks review completion against milestone dates for gate approval and schedule compliance. No existing project_milest',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Design reviews are conducted to satisfy specific regulatory obligations (mandatory independent structural review, heritage impact review). Linking review to regulatory_obligation enables compliance tr',
    `submittal_id` BIGINT COMMENT 'Foreign key linking to design.design_submittal. Business justification: A formal design review is conducted on a specific design submittal. In construction, submittals undergo formal review processes. Adding design_submittal_id FK to review enables direct linkage between ',
    `trade_package_id` BIGINT COMMENT 'Foreign key linking to bid.trade_package. Business justification: Design reviews are scoped to specific trade packages — subcontractor design reviews and IFC reviews are conducted per trade package. Named process: trade package design review. Construction engineer',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Design reviews are conducted against specific WBS work packages. A design manager tracks review status by WBS scope for completeness reporting and earned value. review.wbs_code is a denormalized WBS r',
    `work_front_id` BIGINT COMMENT 'Foreign key linking to site.work_front. Business justification: Design reviews (constructability reviews, IFC reviews, hold-point inspections) are conducted for specific work fronts before construction proceeds. Quality management and ITP compliance require linkin',
    `action_items_count` STRING COMMENT 'Number of action items or follow-up tasks assigned as a result of this design review.',
    `attendee_count` STRING COMMENT 'Total number of participants who attended the design review event.',
    `attendee_list` STRING COMMENT 'Comma-separated or structured list of names and roles of all participants in the design review event.',
    `chairperson_name` STRING COMMENT 'Name of the individual who chaired or led the design review meeting.',
    `clash_detection_performed` BOOLEAN COMMENT 'Indicates whether automated clash detection analysis was performed as part of this design review.',
    `clashes_identified_count` STRING COMMENT 'Number of design clashes or conflicts identified during clash detection analysis.',
    `client_approval_date` DATE COMMENT 'Date on which the client formally approved the design following this review.',
    `client_approval_required` BOOLEAN COMMENT 'Indicates whether formal client approval is required as an outcome of this design review.',
    `comments_closed_count` STRING COMMENT 'Number of review comments that have been resolved and closed.',
    `comments_open_count` STRING COMMENT 'Number of review comments that remain open and require action.',
    `confidentiality_level` STRING COMMENT 'Data classification level for the design review record and associated documentation.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this design review record was first created in the system.',
    `discipline` STRING COMMENT 'Primary engineering or design discipline that is the focus of this review. [ENUM-REF-CANDIDATE: architectural|structural|mechanical|electrical|plumbing|civil|geotechnical|environmental|multidisciplinary — 9 candidates stripped; promote to reference product]',
    `disposition` STRING COMMENT 'Overall outcome or decision of the design review. Accepted means approved without changes; conditionally accepted requires minor revisions; rejected requires major rework; revise and resubmit requires resubmission after changes.. Valid values are `accepted|conditionally_accepted|rejected|revise_and_resubmit`',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the design review meeting or event in hours.',
    `external_reference_code` STRING COMMENT 'Unique identifier for this design review in the source operational system.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this design review record was last updated or modified.',
    `major_comments_count` STRING COMMENT 'Number of major or critical comments raised that require mandatory resolution before approval.',
    `meeting_location` STRING COMMENT 'Physical or virtual location where the design review meeting was held (e.g., site office, video conference platform).',
    `minor_comments_count` STRING COMMENT 'Number of minor comments raised that are recommended but not mandatory for approval.',
    `minutes_document_reference` STRING COMMENT 'Reference to the formal meeting minutes or record document for this design review event.',
    `next_review_scheduled_date` DATE COMMENT 'Planned date for the next design review or follow-up review event.',
    `recommendations` STRING COMMENT 'Key recommendations or improvement suggestions arising from the design review.',
    `review_date` DATE COMMENT 'The date on which the formal design review event took place.',
    `review_number` STRING COMMENT 'Business identifier for the design review event, typically following project numbering conventions (e.g., DR-001, IDC-2024-05).',
    `review_status` STRING COMMENT 'Current lifecycle status of the design review event.. Valid values are `scheduled|in_progress|completed|cancelled|deferred`',
    `review_type` STRING COMMENT 'Classification of the design review event. Internal peer review is conducted within the design team; Interdisciplinary Check (IDC) validates coordination across disciplines; client milestone review is a formal client gate review; third-party review involves external consultants; authority review is conducted by regulatory bodies; constructability review assesses buildability.. Valid values are `internal_peer_review|interdisciplinary_check|client_milestone_review|third_party_review|authority_review|constructability_review`',
    `scheduled_date` DATE COMMENT 'The originally planned date for the design review event.',
    `sign_off_authority` STRING COMMENT 'Name or role of the individual or body with authority to approve or reject the design at this review stage (e.g., Chief Engineer, Client Representative, Regulatory Authority).',
    `sign_off_date` DATE COMMENT 'Date on which the sign-off authority formally approved or rejected the design package.',
    `source_system` STRING COMMENT 'Name of the operational system from which this design review record originated (e.g., Aconex, BIM 360, Procore).',
    `stage` STRING COMMENT 'Design completion stage at which the review is conducted. IFC = Issued for Construction; IFD = Issued for Design; stages represent percentage completion milestones. [ENUM-REF-CANDIDATE: concept|30_percent|60_percent|90_percent|ifc|ifd|as_built — 7 candidates stripped; promote to reference product]',
    `summary` STRING COMMENT 'Executive summary or key findings from the design review event.',
    `total_comments_raised` STRING COMMENT 'Total number of review comments or issues raised during this design review event.',
    CONSTRAINT pk_review PRIMARY KEY(`review_id`)
) COMMENT 'Transactional record for each formal design review event including internal peer reviews, interdisciplinary checks (IDC), client milestone reviews, and third-party/authority reviews. Captures review type, review date, attendees, design package under review, review stage (30%/60%/90%/IFC), disposition (accepted, conditionally accepted, rejected), and sign-off authority. Contains individual review comments as child records with sequential comment number, category (major/minor/informational), comment text, marked-up reference location, design team response, disposition (accepted, rejected, partially accepted), action owner, and closure status. SSOT for all design review and comment resolution data, supporting design approval workflows, client milestone gate management, and regulatory submission readiness.';

CREATE OR REPLACE TABLE `construction_ecm`.`design`.`change_notice` (
    `change_notice_id` BIGINT COMMENT 'Unique identifier for the engineering change notice (ECN) or design change notice. Primary key for the change_notice product.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Ensures each change notice is tied to the governing agreement for impact analysis and contractual approval workflow.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Design change notices in construction are frequently raised against specific equipment assets (e.g., foundation redesign for a turbine, revised electrical specs for a generator). Linking change_notice',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Change notices in construction are formally raised against or directed to the client organisation for approval and cost/schedule impact agreement. Client-level change notice reporting (total change va',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project to which this change notice applies.',
    `contract_change_order_id` BIGINT COMMENT 'Foreign key linking to contract.contract_change_order. Business justification: Design Change Notices trigger Contract Change Orders in construction. The CCO cost/schedule impact assessment process requires tracing back to the originating design change notice. `change_order_refer',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: Change notice originator is typically a site foreman (craft worker) who identifies the need for a design change (Change Management Process).',
    `env_impact_assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.env_impact_assessment. Business justification: Significant design changes may require EIA re-assessment or trigger EIA amendment obligations. Linking change_notice to env_impact_assessment enables compliance teams to track which design changes tri',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Change Notice Cost Impact Report requires linking each notice to the specific cost code impacted for budgeting and variance analysis.',
    `master_id` BIGINT COMMENT 'Foreign key linking to material.material_master. Business justification: Change notices often affect material selections; linking to material_master records the impacted material.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to client.contact. Business justification: Change notices are originated by a client contact; linking enables change log reporting and responsibility tracking.',
    `package_id` BIGINT COMMENT 'Foreign key linking to design.package. Business justification: Engineering change notices are raised against specific design packages. A change notice modifies the scope or content of a design package. Adding package_id FK to change_notice establishes this relati',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Change notices may require amendment of a permit; linking ensures the impacted permit is identified for regulatory follow‑up.',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Design change notices are phase-specific (FEED changes vs. detailed design changes). A design manager reports change notice volume and cost impact by phase for project control. No existing phase_id on',
    `project_budget_id` BIGINT COMMENT 'Foreign key linking to finance.project_budget. Business justification: Change notices carry actual_cost_impact_amount and estimated_cost_impact_amount. In construction, every approved change notice must reference the specific project budget line it impacts to drive budge',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Change notices frequently arise from regulatory obligation changes (updated environmental standards, new permit conditions). Linking change_notice to regulatory_obligation enables traceability from re',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safety.risk_assessment. Business justification: Construction change management requires a risk assessment before implementing any design change. The change notice formally triggers a safety re-evaluation; project managers and HSE teams use this lin',
    `specification_id` BIGINT COMMENT 'Foreign key linking to material.specification. Business justification: Design change notices frequently involve material specification changes (substitutions, upgraded grades). Linking a change notice to the affected material specification enables change impact tracking ',
    `trade_package_id` BIGINT COMMENT 'Foreign key linking to bid.trade_package. Business justification: Design change notices affect specific trade packages — scope changes trigger trade package amendments and commercial impact assessments. Named process: change notice commercial impact on trade packag',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Design change notices affect specific WBS work packages. A change manager tracks which WBS scope is impacted for budget reallocation and earned value recalculation. change_notice.wbs_code is a denorma',
    `work_front_id` BIGINT COMMENT 'Foreign key linking to site.work_front. Business justification: Change notices affect specific work fronts (scope changes, design revisions). Change management and cost impact assessment require tracing which work fronts are impacted by a design change for variati',
    `actual_cost_impact_amount` DECIMAL(18,2) COMMENT 'Actual realized financial impact of the change notice after implementation, expressed in the project base currency.',
    `actual_schedule_impact_days` STRING COMMENT 'Actual realized schedule impact in calendar days after implementation of the change notice.',
    `affected_disciplines` STRING COMMENT 'Comma-separated list of all engineering disciplines impacted by this change notice, enabling cross-functional coordination.',
    `approval_authority` STRING COMMENT 'Name or role of the individual or committee with authority to approve or reject this change notice (e.g., Project Manager, Chief Engineer, Change Control Board).',
    `approval_date` DATE COMMENT 'Date on which the change notice was formally approved by the designated approval authority.',
    `bim_model_reference` STRING COMMENT 'Reference to the BIM model file or version that incorporates or is affected by this change notice.',
    `change_notice_description` STRING COMMENT 'Detailed narrative describing the design change, including technical rationale, scope of work affected, and justification for the modification.',
    `change_notice_number` STRING COMMENT 'The externally-known unique business identifier for this change notice, typically following a project-specific numbering convention (e.g., ECN-2024-001).',
    `change_notice_status` STRING COMMENT 'Current lifecycle status of the change notice in the approval and implementation workflow. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|rejected|implemented|closed|cancelled — 8 candidates stripped; promote to reference product]',
    `change_notice_type` STRING COMMENT 'Classification of the change notice by its nature (design change, engineering change, specification change, material substitution, scope change, regulatory change).. Valid values are `design_change|engineering_change|specification_change|material_substitution|scope_change|regulatory_change`',
    `clash_detection_impact` STRING COMMENT 'Description of any clash detection issues identified or resolved as a result of this change notice in the BIM coordination process.',
    `client_approval_date` DATE COMMENT 'Date on which the client formally approved this change notice, if client approval was required.',
    `client_approval_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether formal client approval is contractually required for this change notice before implementation.',
    `comments` STRING COMMENT 'Additional notes, remarks, or commentary related to the change notice, including review feedback and coordination notes.',
    `cost_impact_flag` BOOLEAN COMMENT 'Boolean indicator of whether this change notice has a financial cost impact on the project budget.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this change notice record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for cost impact amounts (e.g., USD, EUR, GBP).',
    `date_raised` DATE COMMENT 'Date on which the change notice was formally raised or submitted into the change management system.',
    `discipline` STRING COMMENT 'Primary engineering discipline impacted by this change notice (e.g., civil, structural, mechanical, electrical, plumbing, architectural).',
    `estimated_cost_impact_amount` DECIMAL(18,2) COMMENT 'Estimated financial impact of the change notice on project cost, expressed in the project base currency. Positive values indicate cost increases; negative values indicate savings.',
    `estimated_schedule_impact_days` STRING COMMENT 'Estimated number of calendar days by which the project schedule will be extended or accelerated due to this change notice. Positive values indicate delays; negative values indicate acceleration.',
    `implementation_completion_date` DATE COMMENT 'Date on which implementation of the change notice was fully completed and verified.',
    `implementation_start_date` DATE COMMENT 'Date on which implementation of the approved change notice commenced on site or in design documentation.',
    `implementation_status` STRING COMMENT 'Current status of the physical implementation of the approved change notice in the field or design deliverables.. Valid values are `not_started|in_progress|completed|on_hold|cancelled`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this change notice record was last updated or modified in the system.',
    `originating_cause` STRING COMMENT 'Root cause or trigger that necessitated the change notice (client instruction, unforeseen site condition, design error, regulatory requirement, value engineering, constructability improvement).. Valid values are `client_instruction|site_condition|design_error|regulatory_requirement|value_engineering|constructability_improvement`',
    `originator_organization` STRING COMMENT 'Organization or company of the individual who initiated the change notice (e.g., client, contractor, subcontractor, consultant).',
    `priority` STRING COMMENT 'Business priority level indicating urgency and impact of the change notice on project schedule and operations.. Valid values are `critical|high|medium|low`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Boolean indicator of whether this change notice is driven by or impacts regulatory compliance requirements (building codes, safety standards, environmental regulations).',
    `regulatory_reference` STRING COMMENT 'Citation of the specific regulatory code, standard, or requirement that necessitates or is impacted by this change notice.',
    `rejection_date` DATE COMMENT 'Date on which the change notice was formally rejected by the approval authority, if applicable.',
    `rejection_reason` STRING COMMENT 'Detailed explanation of why the change notice was rejected, including technical, commercial, or procedural justifications.',
    `schedule_impact_flag` BOOLEAN COMMENT 'Boolean indicator of whether this change notice has an impact on the project schedule or critical path.',
    `title` STRING COMMENT 'Brief descriptive title summarizing the nature of the design or engineering change.',
    CONSTRAINT pk_change_notice PRIMARY KEY(`change_notice_id`)
) COMMENT 'Transactional record capturing each formal design change or engineering change notice (ECN) issued during the project. Tracks change number, originating cause (client instruction, site condition, regulatory requirement, value engineering), affected drawings and specifications, design disciplines impacted, cost and schedule impact assessment, approval authority, and implementation status. Feeds into the CO (Change Order) process.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `construction_ecm`.`design`.`correspondence` ADD CONSTRAINT `fk_design_correspondence_parent_correspondence_id` FOREIGN KEY (`parent_correspondence_id`) REFERENCES `construction_ecm`.`design`.`correspondence`(`correspondence_id`);
ALTER TABLE `construction_ecm`.`design`.`correspondence` ADD CONSTRAINT `fk_design_correspondence_rfi_id` FOREIGN KEY (`rfi_id`) REFERENCES `construction_ecm`.`design`.`rfi`(`rfi_id`);
ALTER TABLE `construction_ecm`.`design`.`correspondence` ADD CONSTRAINT `fk_design_correspondence_transmittal_id` FOREIGN KEY (`transmittal_id`) REFERENCES `construction_ecm`.`design`.`transmittal`(`transmittal_id`);
ALTER TABLE `construction_ecm`.`design`.`rfi` ADD CONSTRAINT `fk_design_rfi_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `construction_ecm`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `construction_ecm`.`design`.`rfi` ADD CONSTRAINT `fk_design_rfi_package_id` FOREIGN KEY (`package_id`) REFERENCES `construction_ecm`.`design`.`package`(`package_id`);
ALTER TABLE `construction_ecm`.`design`.`rfi` ADD CONSTRAINT `fk_design_rfi_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `construction_ecm`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `construction_ecm`.`design`.`document_register` ADD CONSTRAINT `fk_design_document_register_rfi_id` FOREIGN KEY (`rfi_id`) REFERENCES `construction_ecm`.`design`.`rfi`(`rfi_id`);
ALTER TABLE `construction_ecm`.`design`.`document_register` ADD CONSTRAINT `fk_design_document_register_transmittal_id` FOREIGN KEY (`transmittal_id`) REFERENCES `construction_ecm`.`design`.`transmittal`(`transmittal_id`);
ALTER TABLE `construction_ecm`.`design`.`revision` ADD CONSTRAINT `fk_design_revision_document_register_id` FOREIGN KEY (`document_register_id`) REFERENCES `construction_ecm`.`design`.`document_register`(`document_register_id`);
ALTER TABLE `construction_ecm`.`design`.`revision` ADD CONSTRAINT `fk_design_revision_superseded_revision_id` FOREIGN KEY (`superseded_revision_id`) REFERENCES `construction_ecm`.`design`.`revision`(`revision_id`);
ALTER TABLE `construction_ecm`.`design`.`revision` ADD CONSTRAINT `fk_design_revision_transmittal_id` FOREIGN KEY (`transmittal_id`) REFERENCES `construction_ecm`.`design`.`transmittal`(`transmittal_id`);
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ADD CONSTRAINT `fk_design_workflow_approval_document_register_id` FOREIGN KEY (`document_register_id`) REFERENCES `construction_ecm`.`design`.`document_register`(`document_register_id`);
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ADD CONSTRAINT `fk_design_workflow_approval_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `construction_ecm`.`design`.`revision`(`revision_id`);
ALTER TABLE `construction_ecm`.`design`.`handover_package` ADD CONSTRAINT `fk_design_handover_package_bim_model_id` FOREIGN KEY (`bim_model_id`) REFERENCES `construction_ecm`.`design`.`bim_model`(`bim_model_id`);
ALTER TABLE `construction_ecm`.`design`.`handover_item` ADD CONSTRAINT `fk_design_handover_item_bim_model_id` FOREIGN KEY (`bim_model_id`) REFERENCES `construction_ecm`.`design`.`bim_model`(`bim_model_id`);
ALTER TABLE `construction_ecm`.`design`.`handover_item` ADD CONSTRAINT `fk_design_handover_item_document_register_id` FOREIGN KEY (`document_register_id`) REFERENCES `construction_ecm`.`design`.`document_register`(`document_register_id`);
ALTER TABLE `construction_ecm`.`design`.`handover_item` ADD CONSTRAINT `fk_design_handover_item_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `construction_ecm`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `construction_ecm`.`design`.`handover_item` ADD CONSTRAINT `fk_design_handover_item_handover_package_id` FOREIGN KEY (`handover_package_id`) REFERENCES `construction_ecm`.`design`.`handover_package`(`handover_package_id`);
ALTER TABLE `construction_ecm`.`design`.`handover_item` ADD CONSTRAINT `fk_design_handover_item_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `construction_ecm`.`design`.`revision`(`revision_id`);
ALTER TABLE `construction_ecm`.`design`.`handover_item` ADD CONSTRAINT `fk_design_handover_item_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `construction_ecm`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `construction_ecm`.`design`.`bim_model` ADD CONSTRAINT `fk_design_bim_model_superseded_by_model_bim_model_id` FOREIGN KEY (`superseded_by_model_bim_model_id`) REFERENCES `construction_ecm`.`design`.`bim_model`(`bim_model_id`);
ALTER TABLE `construction_ecm`.`design`.`drawing` ADD CONSTRAINT `fk_design_drawing_bim_model_id` FOREIGN KEY (`bim_model_id`) REFERENCES `construction_ecm`.`design`.`bim_model`(`bim_model_id`);
ALTER TABLE `construction_ecm`.`design`.`drawing` ADD CONSTRAINT `fk_design_drawing_package_id` FOREIGN KEY (`package_id`) REFERENCES `construction_ecm`.`design`.`package`(`package_id`);
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ADD CONSTRAINT `fk_design_drawing_revision_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `construction_ecm`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ADD CONSTRAINT `fk_design_drawing_revision_superseded_revision_drawing_revision_id` FOREIGN KEY (`superseded_revision_drawing_revision_id`) REFERENCES `construction_ecm`.`design`.`drawing_revision`(`drawing_revision_id`);
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ADD CONSTRAINT `fk_design_drawing_revision_transmittal_id` FOREIGN KEY (`transmittal_id`) REFERENCES `construction_ecm`.`design`.`transmittal`(`transmittal_id`);
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ADD CONSTRAINT `fk_design_technical_specification_package_id` FOREIGN KEY (`package_id`) REFERENCES `construction_ecm`.`design`.`package`(`package_id`);
ALTER TABLE `construction_ecm`.`design`.`submittal` ADD CONSTRAINT `fk_design_submittal_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `construction_ecm`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `construction_ecm`.`design`.`submittal` ADD CONSTRAINT `fk_design_submittal_package_id` FOREIGN KEY (`package_id`) REFERENCES `construction_ecm`.`design`.`package`(`package_id`);
ALTER TABLE `construction_ecm`.`design`.`submittal` ADD CONSTRAINT `fk_design_submittal_rfi_id` FOREIGN KEY (`rfi_id`) REFERENCES `construction_ecm`.`design`.`rfi`(`rfi_id`);
ALTER TABLE `construction_ecm`.`design`.`submittal` ADD CONSTRAINT `fk_design_submittal_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `construction_ecm`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `construction_ecm`.`design`.`submittal` ADD CONSTRAINT `fk_design_submittal_transmittal_id` FOREIGN KEY (`transmittal_id`) REFERENCES `construction_ecm`.`design`.`transmittal`(`transmittal_id`);
ALTER TABLE `construction_ecm`.`design`.`review` ADD CONSTRAINT `fk_design_review_bim_model_id` FOREIGN KEY (`bim_model_id`) REFERENCES `construction_ecm`.`design`.`bim_model`(`bim_model_id`);
ALTER TABLE `construction_ecm`.`design`.`review` ADD CONSTRAINT `fk_design_review_package_id` FOREIGN KEY (`package_id`) REFERENCES `construction_ecm`.`design`.`package`(`package_id`);
ALTER TABLE `construction_ecm`.`design`.`review` ADD CONSTRAINT `fk_design_review_submittal_id` FOREIGN KEY (`submittal_id`) REFERENCES `construction_ecm`.`design`.`submittal`(`submittal_id`);
ALTER TABLE `construction_ecm`.`design`.`change_notice` ADD CONSTRAINT `fk_design_change_notice_package_id` FOREIGN KEY (`package_id`) REFERENCES `construction_ecm`.`design`.`package`(`package_id`);

-- ========= TAGS =========
ALTER SCHEMA `construction_ecm`.`design` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `construction_ecm`.`design` SET TAGS ('dbx_domain' = 'design');
ALTER TABLE `construction_ecm`.`design`.`correspondence` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`design`.`correspondence` SET TAGS ('dbx_subdomain' = 'project_communications');
ALTER TABLE `construction_ecm`.`design`.`correspondence` ALTER COLUMN `correspondence_id` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Identifier (ID)');
ALTER TABLE `construction_ecm`.`design`.`correspondence` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`correspondence` ALTER COLUMN `authority_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Authority Notice Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`correspondence` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `construction_ecm`.`design`.`correspondence` ALTER COLUMN `parent_correspondence_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Correspondence Identifier (ID)');
ALTER TABLE `construction_ecm`.`design`.`correspondence` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`correspondence` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Recipient Contact Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`correspondence` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`correspondence` ALTER COLUMN `rfi_id` SET TAGS ('dbx_business_glossary_term' = 'Rfi Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`correspondence` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Sender Account Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`correspondence` ALTER COLUMN `transmittal_id` SET TAGS ('dbx_business_glossary_term' = 'Transmittal Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`correspondence` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`correspondence` ALTER COLUMN `attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Attachment Count');
ALTER TABLE `construction_ecm`.`design`.`correspondence` ALTER COLUMN `body_text` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Body Text');
ALTER TABLE `construction_ecm`.`design`.`correspondence` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `construction_ecm`.`design`.`correspondence` ALTER COLUMN `closure_status` SET TAGS ('dbx_business_glossary_term' = 'Closure Status');
ALTER TABLE `construction_ecm`.`design`.`correspondence` ALTER COLUMN `closure_status` SET TAGS ('dbx_value_regex' = 'open|closed_accepted|closed_rejected|closed_superseded');
ALTER TABLE `construction_ecm`.`design`.`correspondence` ALTER COLUMN `confidential_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidential Flag');
ALTER TABLE `construction_ecm`.`design`.`correspondence` ALTER COLUMN `correspondence_date` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Date');
ALTER TABLE `construction_ecm`.`design`.`correspondence` ALTER COLUMN `correspondence_number` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Number');
ALTER TABLE `construction_ecm`.`design`.`correspondence` ALTER COLUMN `correspondence_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]+$');
ALTER TABLE `construction_ecm`.`design`.`correspondence` ALTER COLUMN `correspondence_status` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Status');
ALTER TABLE `construction_ecm`.`design`.`correspondence` ALTER COLUMN `correspondence_status` SET TAGS ('dbx_value_regex' = 'draft|issued|acknowledged|responded|closed|cancelled');
ALTER TABLE `construction_ecm`.`design`.`correspondence` ALTER COLUMN `correspondence_type` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Type');
ALTER TABLE `construction_ecm`.`design`.`correspondence` ALTER COLUMN `correspondence_type` SET TAGS ('dbx_value_regex' = 'rfi|instruction|notice|claim|letter|memo');
ALTER TABLE `construction_ecm`.`design`.`correspondence` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `construction_ecm`.`design`.`correspondence` ALTER COLUMN `discipline` SET TAGS ('dbx_business_glossary_term' = 'Engineering Discipline');
ALTER TABLE `construction_ecm`.`design`.`correspondence` ALTER COLUMN `distribution_list` SET TAGS ('dbx_business_glossary_term' = 'Distribution List');
ALTER TABLE `construction_ecm`.`design`.`correspondence` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `construction_ecm`.`design`.`correspondence` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `construction_ecm`.`design`.`correspondence` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Priority');
ALTER TABLE `construction_ecm`.`design`.`correspondence` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `construction_ecm`.`design`.`correspondence` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Received Date');
ALTER TABLE `construction_ecm`.`design`.`correspondence` ALTER COLUMN `recipient_organization` SET TAGS ('dbx_business_glossary_term' = 'Recipient Organization');
ALTER TABLE `construction_ecm`.`design`.`correspondence` ALTER COLUMN `response_date` SET TAGS ('dbx_business_glossary_term' = 'Response Date');
ALTER TABLE `construction_ecm`.`design`.`correspondence` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `construction_ecm`.`design`.`correspondence` ALTER COLUMN `response_method` SET TAGS ('dbx_business_glossary_term' = 'Response Method');
ALTER TABLE `construction_ecm`.`design`.`correspondence` ALTER COLUMN `response_method` SET TAGS ('dbx_value_regex' = 'email|letter|transmittal|meeting|phone');
ALTER TABLE `construction_ecm`.`design`.`correspondence` ALTER COLUMN `response_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Response Required Flag');
ALTER TABLE `construction_ecm`.`design`.`correspondence` ALTER COLUMN `response_text` SET TAGS ('dbx_business_glossary_term' = 'Response Text');
ALTER TABLE `construction_ecm`.`design`.`correspondence` ALTER COLUMN `sender_email` SET TAGS ('dbx_business_glossary_term' = 'Sender Email Address');
ALTER TABLE `construction_ecm`.`design`.`correspondence` ALTER COLUMN `sender_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `construction_ecm`.`design`.`correspondence` ALTER COLUMN `sender_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`design`.`correspondence` ALTER COLUMN `sender_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `construction_ecm`.`design`.`correspondence` ALTER COLUMN `sender_name` SET TAGS ('dbx_business_glossary_term' = 'Sender Name');
ALTER TABLE `construction_ecm`.`design`.`correspondence` ALTER COLUMN `sender_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`design`.`correspondence` ALTER COLUMN `sender_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `construction_ecm`.`design`.`correspondence` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Subject');
ALTER TABLE `construction_ecm`.`design`.`correspondence` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `construction_ecm`.`design`.`transmittal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`design`.`transmittal` SET TAGS ('dbx_subdomain' = 'project_communications');
ALTER TABLE `construction_ecm`.`design`.`transmittal` ALTER COLUMN `transmittal_id` SET TAGS ('dbx_business_glossary_term' = 'Transmittal Identifier (ID)');
ALTER TABLE `construction_ecm`.`design`.`transmittal` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `construction_ecm`.`design`.`transmittal` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `construction_ecm`.`design`.`transmittal` ALTER COLUMN `project_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Project Milestone Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`transmittal` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Recipient Contact Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`transmittal` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`transmittal` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Sender Account Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`transmittal` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`transmittal` ALTER COLUMN `acknowledgement_by` SET TAGS ('dbx_business_glossary_term' = 'Acknowledged By');
ALTER TABLE `construction_ecm`.`design`.`transmittal` ALTER COLUMN `acknowledgement_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`design`.`transmittal` ALTER COLUMN `acknowledgement_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `construction_ecm`.`design`.`transmittal` ALTER COLUMN `acknowledgement_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Date');
ALTER TABLE `construction_ecm`.`design`.`transmittal` ALTER COLUMN `acknowledgement_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Required Flag');
ALTER TABLE `construction_ecm`.`design`.`transmittal` ALTER COLUMN `acknowledgement_status` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Status');
ALTER TABLE `construction_ecm`.`design`.`transmittal` ALTER COLUMN `acknowledgement_status` SET TAGS ('dbx_value_regex' = 'pending|acknowledged|overdue|not_required');
ALTER TABLE `construction_ecm`.`design`.`transmittal` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `construction_ecm`.`design`.`transmittal` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `construction_ecm`.`design`.`transmittal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `construction_ecm`.`design`.`transmittal` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `construction_ecm`.`design`.`transmittal` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'electronic|courier|hand_delivery|postal_mail|ftp|portal');
ALTER TABLE `construction_ecm`.`design`.`transmittal` ALTER COLUMN `discipline` SET TAGS ('dbx_business_glossary_term' = 'Engineering Discipline');
ALTER TABLE `construction_ecm`.`design`.`transmittal` ALTER COLUMN `document_count` SET TAGS ('dbx_business_glossary_term' = 'Document Count');
ALTER TABLE `construction_ecm`.`design`.`transmittal` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `construction_ecm`.`design`.`transmittal` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `construction_ecm`.`design`.`transmittal` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `construction_ecm`.`design`.`transmittal` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Transmittal Priority');
ALTER TABLE `construction_ecm`.`design`.`transmittal` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `construction_ecm`.`design`.`transmittal` ALTER COLUMN `purpose_of_issue` SET TAGS ('dbx_business_glossary_term' = 'Purpose of Issue');
ALTER TABLE `construction_ecm`.`design`.`transmittal` ALTER COLUMN `purpose_of_issue` SET TAGS ('dbx_value_regex' = 'for_approval|for_information|for_construction|for_record|for_review|for_comment');
ALTER TABLE `construction_ecm`.`design`.`transmittal` ALTER COLUMN `recipient_organization` SET TAGS ('dbx_business_glossary_term' = 'Recipient Organization');
ALTER TABLE `construction_ecm`.`design`.`transmittal` ALTER COLUMN `reference_transmittal_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Transmittal Number');
ALTER TABLE `construction_ecm`.`design`.`transmittal` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Transmittal Remarks');
ALTER TABLE `construction_ecm`.`design`.`transmittal` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `construction_ecm`.`design`.`transmittal` ALTER COLUMN `revision_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9.]+$');
ALTER TABLE `construction_ecm`.`design`.`transmittal` ALTER COLUMN `sender_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Sender Contact Name');
ALTER TABLE `construction_ecm`.`design`.`transmittal` ALTER COLUMN `sender_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`design`.`transmittal` ALTER COLUMN `sender_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `construction_ecm`.`design`.`transmittal` ALTER COLUMN `sender_email` SET TAGS ('dbx_business_glossary_term' = 'Sender Email Address');
ALTER TABLE `construction_ecm`.`design`.`transmittal` ALTER COLUMN `sender_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `construction_ecm`.`design`.`transmittal` ALTER COLUMN `sender_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`design`.`transmittal` ALTER COLUMN `sender_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `construction_ecm`.`design`.`transmittal` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Transmittal Subject');
ALTER TABLE `construction_ecm`.`design`.`transmittal` ALTER COLUMN `transmittal_description` SET TAGS ('dbx_business_glossary_term' = 'Transmittal Description');
ALTER TABLE `construction_ecm`.`design`.`transmittal` ALTER COLUMN `transmittal_number` SET TAGS ('dbx_business_glossary_term' = 'Transmittal Number');
ALTER TABLE `construction_ecm`.`design`.`transmittal` ALTER COLUMN `transmittal_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]+$');
ALTER TABLE `construction_ecm`.`design`.`transmittal` ALTER COLUMN `transmittal_status` SET TAGS ('dbx_business_glossary_term' = 'Transmittal Status');
ALTER TABLE `construction_ecm`.`design`.`transmittal` ALTER COLUMN `transmittal_status` SET TAGS ('dbx_value_regex' = 'draft|issued|acknowledged|rejected|superseded|closed');
ALTER TABLE `construction_ecm`.`design`.`rfi` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`design`.`rfi` SET TAGS ('dbx_subdomain' = 'project_communications');
ALTER TABLE `construction_ecm`.`design`.`rfi` ALTER COLUMN `rfi_id` SET TAGS ('dbx_business_glossary_term' = 'Rfi Identifier');
ALTER TABLE `construction_ecm`.`design`.`rfi` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`rfi` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`rfi` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Client Contact Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`rfi` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `construction_ecm`.`design`.`rfi` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Originator Worker Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`rfi` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`rfi` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`rfi` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`rfi` ALTER COLUMN `permit_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Condition Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`rfi` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`rfi` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`rfi` ALTER COLUMN `technical_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`rfi` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `construction_ecm`.`design`.`rfi` ALTER COLUMN `work_front_id` SET TAGS ('dbx_business_glossary_term' = 'Work Front Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`rfi` ALTER COLUMN `actual_response_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Response Date');
ALTER TABLE `construction_ecm`.`design`.`rfi` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `construction_ecm`.`design`.`rfi` ALTER COLUMN `closure_notes` SET TAGS ('dbx_business_glossary_term' = 'Closure Notes');
ALTER TABLE `construction_ecm`.`design`.`rfi` ALTER COLUMN `cost_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Amount');
ALTER TABLE `construction_ecm`.`design`.`rfi` ALTER COLUMN `cost_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Flag');
ALTER TABLE `construction_ecm`.`design`.`rfi` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `construction_ecm`.`design`.`rfi` ALTER COLUMN `date_raised` SET TAGS ('dbx_business_glossary_term' = 'Date Raised');
ALTER TABLE `construction_ecm`.`design`.`rfi` ALTER COLUMN `discipline` SET TAGS ('dbx_business_glossary_term' = 'Engineering Discipline');
ALTER TABLE `construction_ecm`.`design`.`rfi` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference ID');
ALTER TABLE `construction_ecm`.`design`.`rfi` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `construction_ecm`.`design`.`rfi` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Request for Information (RFI) Priority');
ALTER TABLE `construction_ecm`.`design`.`rfi` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `construction_ecm`.`design`.`rfi` ALTER COLUMN `response_content` SET TAGS ('dbx_business_glossary_term' = 'Response Content');
ALTER TABLE `construction_ecm`.`design`.`rfi` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `construction_ecm`.`design`.`rfi` ALTER COLUMN `response_time_days` SET TAGS ('dbx_business_glossary_term' = 'Response Time Days');
ALTER TABLE `construction_ecm`.`design`.`rfi` ALTER COLUMN `rfi_description` SET TAGS ('dbx_business_glossary_term' = 'Request for Information (RFI) Description');
ALTER TABLE `construction_ecm`.`design`.`rfi` ALTER COLUMN `rfi_number` SET TAGS ('dbx_business_glossary_term' = 'Request for Information (RFI) Number');
ALTER TABLE `construction_ecm`.`design`.`rfi` ALTER COLUMN `rfi_status` SET TAGS ('dbx_business_glossary_term' = 'Request for Information (RFI) Status');
ALTER TABLE `construction_ecm`.`design`.`rfi` ALTER COLUMN `rfi_status` SET TAGS ('dbx_value_regex' = 'draft|open|pending_response|responded|closed|cancelled');
ALTER TABLE `construction_ecm`.`design`.`rfi` ALTER COLUMN `schedule_impact_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Impact Days');
ALTER TABLE `construction_ecm`.`design`.`rfi` ALTER COLUMN `schedule_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Schedule Impact Flag');
ALTER TABLE `construction_ecm`.`design`.`rfi` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `construction_ecm`.`design`.`rfi` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'procore|aconex|bim360|other');
ALTER TABLE `construction_ecm`.`design`.`rfi` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Request for Information (RFI) Subject');
ALTER TABLE `construction_ecm`.`design`.`document_register` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`design`.`document_register` SET TAGS ('dbx_subdomain' = 'document_control');
ALTER TABLE `construction_ecm`.`design`.`document_register` ALTER COLUMN `document_register_id` SET TAGS ('dbx_business_glossary_term' = 'Document Register ID');
ALTER TABLE `construction_ecm`.`design`.`document_register` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `construction_ecm`.`design`.`document_register` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `construction_ecm`.`design`.`document_register` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`document_register` ALTER COLUMN `rfi_id` SET TAGS ('dbx_business_glossary_term' = 'Rfi Document Rfi Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`document_register` ALTER COLUMN `transmittal_id` SET TAGS ('dbx_business_glossary_term' = 'Transmittal Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`document_register` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `construction_ecm`.`design`.`document_register` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `construction_ecm`.`design`.`document_register` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `construction_ecm`.`design`.`document_register` ALTER COLUMN `confidentiality_classification` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Classification');
ALTER TABLE `construction_ecm`.`design`.`document_register` ALTER COLUMN `confidentiality_classification` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `construction_ecm`.`design`.`document_register` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `construction_ecm`.`design`.`document_register` ALTER COLUMN `discipline` SET TAGS ('dbx_business_glossary_term' = 'Discipline');
ALTER TABLE `construction_ecm`.`design`.`document_register` ALTER COLUMN `distribution_list` SET TAGS ('dbx_business_glossary_term' = 'Distribution List');
ALTER TABLE `construction_ecm`.`design`.`document_register` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `construction_ecm`.`design`.`document_register` ALTER COLUMN `document_purpose` SET TAGS ('dbx_business_glossary_term' = 'Document Purpose');
ALTER TABLE `construction_ecm`.`design`.`document_register` ALTER COLUMN `document_register_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status');
ALTER TABLE `construction_ecm`.`design`.`document_register` ALTER COLUMN `document_title` SET TAGS ('dbx_business_glossary_term' = 'Document Title');
ALTER TABLE `construction_ecm`.`design`.`document_register` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `construction_ecm`.`design`.`document_register` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `construction_ecm`.`design`.`document_register` ALTER COLUMN `file_size_mb` SET TAGS ('dbx_business_glossary_term' = 'File Size (Megabytes)');
ALTER TABLE `construction_ecm`.`design`.`document_register` ALTER COLUMN `is_client_deliverable` SET TAGS ('dbx_business_glossary_term' = 'Is Client Deliverable');
ALTER TABLE `construction_ecm`.`design`.`document_register` ALTER COLUMN `is_controlled_document` SET TAGS ('dbx_business_glossary_term' = 'Is Controlled Document');
ALTER TABLE `construction_ecm`.`design`.`document_register` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `construction_ecm`.`design`.`document_register` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Keywords');
ALTER TABLE `construction_ecm`.`design`.`document_register` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `construction_ecm`.`design`.`document_register` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `construction_ecm`.`design`.`document_register` ALTER COLUMN `originator` SET TAGS ('dbx_business_glossary_term' = 'Document Originator');
ALTER TABLE `construction_ecm`.`design`.`document_register` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Page Count');
ALTER TABLE `construction_ecm`.`design`.`document_register` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (Years)');
ALTER TABLE `construction_ecm`.`design`.`document_register` ALTER COLUMN `review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Review Due Date');
ALTER TABLE `construction_ecm`.`design`.`document_register` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `construction_ecm`.`design`.`document_register` ALTER COLUMN `revision_description` SET TAGS ('dbx_business_glossary_term' = 'Revision Description');
ALTER TABLE `construction_ecm`.`design`.`document_register` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `construction_ecm`.`design`.`document_register` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `construction_ecm`.`design`.`document_register` ALTER COLUMN `superseded_by_document_number` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Document Number');
ALTER TABLE `construction_ecm`.`design`.`document_register` ALTER COLUMN `supersedes_document_number` SET TAGS ('dbx_business_glossary_term' = 'Supersedes Document Number');
ALTER TABLE `construction_ecm`.`design`.`revision` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`design`.`revision` SET TAGS ('dbx_subdomain' = 'document_control');
ALTER TABLE `construction_ecm`.`design`.`revision` ALTER COLUMN `revision_id` SET TAGS ('dbx_business_glossary_term' = 'Revision Identifier');
ALTER TABLE `construction_ecm`.`design`.`revision` ALTER COLUMN `document_register_id` SET TAGS ('dbx_business_glossary_term' = 'Document ID');
ALTER TABLE `construction_ecm`.`design`.`revision` ALTER COLUMN `ncr_id` SET TAGS ('dbx_business_glossary_term' = 'Ncr Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`revision` ALTER COLUMN `superseded_revision_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Revision ID');
ALTER TABLE `construction_ecm`.`design`.`revision` ALTER COLUMN `transmittal_id` SET TAGS ('dbx_business_glossary_term' = 'Transmittal Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`revision` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `construction_ecm`.`design`.`revision` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `construction_ecm`.`design`.`revision` ALTER COLUMN `approver_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`design`.`revision` ALTER COLUMN `author_name` SET TAGS ('dbx_business_glossary_term' = 'Author Name');
ALTER TABLE `construction_ecm`.`design`.`revision` ALTER COLUMN `author_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`design`.`revision` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `construction_ecm`.`design`.`revision` ALTER COLUMN `change_reason` SET TAGS ('dbx_value_regex' = 'design_change|client_request|rfi_response|regulatory_update|error_correction|clarification');
ALTER TABLE `construction_ecm`.`design`.`revision` ALTER COLUMN `change_summary` SET TAGS ('dbx_business_glossary_term' = 'Change Summary');
ALTER TABLE `construction_ecm`.`design`.`revision` ALTER COLUMN `checksum_hash` SET TAGS ('dbx_business_glossary_term' = 'Checksum Hash');
ALTER TABLE `construction_ecm`.`design`.`revision` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `construction_ecm`.`design`.`revision` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `construction_ecm`.`design`.`revision` ALTER COLUMN `distribution_list` SET TAGS ('dbx_business_glossary_term' = 'Distribution List');
ALTER TABLE `construction_ecm`.`design`.`revision` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `construction_ecm`.`design`.`revision` ALTER COLUMN `file_name` SET TAGS ('dbx_business_glossary_term' = 'File Name');
ALTER TABLE `construction_ecm`.`design`.`revision` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size (Bytes)');
ALTER TABLE `construction_ecm`.`design`.`revision` ALTER COLUMN `file_storage_path` SET TAGS ('dbx_business_glossary_term' = 'File Storage Path');
ALTER TABLE `construction_ecm`.`design`.`revision` ALTER COLUMN `is_controlled_copy` SET TAGS ('dbx_business_glossary_term' = 'Is Controlled Copy');
ALTER TABLE `construction_ecm`.`design`.`revision` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `construction_ecm`.`design`.`revision` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Page Count');
ALTER TABLE `construction_ecm`.`design`.`revision` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `construction_ecm`.`design`.`revision` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `construction_ecm`.`design`.`revision` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`design`.`revision` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Revision Date');
ALTER TABLE `construction_ecm`.`design`.`revision` ALTER COLUMN `revision_description` SET TAGS ('dbx_business_glossary_term' = 'Revision Description');
ALTER TABLE `construction_ecm`.`design`.`revision` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `construction_ecm`.`design`.`revision` ALTER COLUMN `revision_status` SET TAGS ('dbx_business_glossary_term' = 'Revision Status');
ALTER TABLE `construction_ecm`.`design`.`revision` ALTER COLUMN `revision_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|issued|superseded|obsolete');
ALTER TABLE `construction_ecm`.`design`.`revision` ALTER COLUMN `revision_type` SET TAGS ('dbx_business_glossary_term' = 'Revision Type');
ALTER TABLE `construction_ecm`.`design`.`revision` ALTER COLUMN `revision_type` SET TAGS ('dbx_value_regex' = 'initial|minor|major|emergency|regulatory');
ALTER TABLE `construction_ecm`.`design`.`revision` ALTER COLUMN `sheet_count` SET TAGS ('dbx_business_glossary_term' = 'Sheet Count');
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` SET TAGS ('dbx_subdomain' = 'project_communications');
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ALTER COLUMN `workflow_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Workflow Approval ID');
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ALTER COLUMN `document_register_id` SET TAGS ('dbx_business_glossary_term' = 'Document ID');
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ALTER COLUMN `revision_id` SET TAGS ('dbx_business_glossary_term' = 'Revision Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ALTER COLUMN `action_date` SET TAGS ('dbx_business_glossary_term' = 'Action Date');
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ALTER COLUMN `action_taken` SET TAGS ('dbx_business_glossary_term' = 'Action Taken');
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ALTER COLUMN `approval_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority Level');
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ALTER COLUMN `assigned_reviewer_role` SET TAGS ('dbx_business_glossary_term' = 'Assigned Reviewer Role');
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ALTER COLUMN `current_step_sequence` SET TAGS ('dbx_business_glossary_term' = 'Current Step Sequence');
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ALTER COLUMN `delegation_reason` SET TAGS ('dbx_business_glossary_term' = 'Delegation Reason');
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference ID');
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ALTER COLUMN `initiated_date` SET TAGS ('dbx_business_glossary_term' = 'Initiated Date');
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ALTER COLUMN `last_reminder_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reminder Date');
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ALTER COLUMN `outcome_date` SET TAGS ('dbx_business_glossary_term' = 'Outcome Date');
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ALTER COLUMN `overall_outcome` SET TAGS ('dbx_business_glossary_term' = 'Overall Outcome');
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ALTER COLUMN `overall_outcome` SET TAGS ('dbx_value_regex' = 'approved|rejected|withdrawn|superseded|closed');
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ALTER COLUMN `regulatory_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Flag');
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ALTER COLUMN `reminder_count` SET TAGS ('dbx_business_glossary_term' = 'Reminder Count');
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ALTER COLUMN `reviewer_comments` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Comments');
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ALTER COLUMN `sla_actual_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Actual Hours');
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ALTER COLUMN `sla_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Flag');
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Hours');
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'aconex|bim_360|procore|other');
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ALTER COLUMN `total_steps` SET TAGS ('dbx_business_glossary_term' = 'Total Steps');
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ALTER COLUMN `workflow_name` SET TAGS ('dbx_business_glossary_term' = 'Workflow Name');
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ALTER COLUMN `workflow_number` SET TAGS ('dbx_business_glossary_term' = 'Workflow Number');
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ALTER COLUMN `workflow_status` SET TAGS ('dbx_business_glossary_term' = 'Workflow Status');
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ALTER COLUMN `workflow_type` SET TAGS ('dbx_business_glossary_term' = 'Workflow Type');
ALTER TABLE `construction_ecm`.`design`.`handover_package` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`design`.`handover_package` SET TAGS ('dbx_subdomain' = 'drawing_management');
ALTER TABLE `construction_ecm`.`design`.`handover_package` ALTER COLUMN `handover_package_id` SET TAGS ('dbx_business_glossary_term' = 'Handover Package ID');
ALTER TABLE `construction_ecm`.`design`.`handover_package` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`handover_package` ALTER COLUMN `bim_model_id` SET TAGS ('dbx_business_glossary_term' = 'Bim Model Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`handover_package` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Client Representative Contact Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`handover_package` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `construction_ecm`.`design`.`handover_package` ALTER COLUMN `contract_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Milestone Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`handover_package` ALTER COLUMN `handover_certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Handover Certificate Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`handover_package` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`handover_package` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`handover_package` ALTER COLUMN `project_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Project Budget Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`handover_package` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`handover_package` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`handover_package` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `construction_ecm`.`design`.`handover_package` ALTER COLUMN `aconex_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Aconex Document ID');
ALTER TABLE `construction_ecm`.`design`.`handover_package` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `construction_ecm`.`design`.`handover_package` ALTER COLUMN `client_acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Client Acceptance Date');
ALTER TABLE `construction_ecm`.`design`.`handover_package` ALTER COLUMN `client_acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Client Acceptance Status');
ALTER TABLE `construction_ecm`.`design`.`handover_package` ALTER COLUMN `client_acceptance_status` SET TAGS ('dbx_value_regex' = 'pending|accepted|conditionally_accepted|rejected|under_review');
ALTER TABLE `construction_ecm`.`design`.`handover_package` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `construction_ecm`.`design`.`handover_package` ALTER COLUMN `completeness_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completeness Percentage');
ALTER TABLE `construction_ecm`.`design`.`handover_package` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `construction_ecm`.`design`.`handover_package` ALTER COLUMN `dlp_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Defects Liability Period (DLP) Duration Days');
ALTER TABLE `construction_ecm`.`design`.`handover_package` ALTER COLUMN `dlp_end_date` SET TAGS ('dbx_business_glossary_term' = 'Defects Liability Period (DLP) End Date');
ALTER TABLE `construction_ecm`.`design`.`handover_package` ALTER COLUMN `dlp_start_date` SET TAGS ('dbx_business_glossary_term' = 'Defects Liability Period (DLP) Start Date');
ALTER TABLE `construction_ecm`.`design`.`handover_package` ALTER COLUMN `iso_19650_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'ISO 19650 Compliance Flag');
ALTER TABLE `construction_ecm`.`design`.`handover_package` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `construction_ecm`.`design`.`handover_package` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Flag');
ALTER TABLE `construction_ecm`.`design`.`handover_package` ALTER COLUMN `legal_hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Reason');
ALTER TABLE `construction_ecm`.`design`.`handover_package` ALTER COLUMN `legal_hold_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`design`.`handover_package` ALTER COLUMN `legal_hold_start_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Start Date');
ALTER TABLE `construction_ecm`.`design`.`handover_package` ALTER COLUMN `package_number` SET TAGS ('dbx_business_glossary_term' = 'Handover Package Number');
ALTER TABLE `construction_ecm`.`design`.`handover_package` ALTER COLUMN `package_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}-HP-[0-9]{4,6}$');
ALTER TABLE `construction_ecm`.`design`.`handover_package` ALTER COLUMN `package_status` SET TAGS ('dbx_business_glossary_term' = 'Package Status');
ALTER TABLE `construction_ecm`.`design`.`handover_package` ALTER COLUMN `package_title` SET TAGS ('dbx_business_glossary_term' = 'Handover Package Title');
ALTER TABLE `construction_ecm`.`design`.`handover_package` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Handover Package Type');
ALTER TABLE `construction_ecm`.`design`.`handover_package` ALTER COLUMN `package_type` SET TAGS ('dbx_value_regex' = 'operations_and_maintenance_manual|as_built_drawings|test_and_commissioning_records|warranties_and_guarantees|certificates_and_approvals|training_materials');
ALTER TABLE `construction_ecm`.`design`.`handover_package` ALTER COLUMN `planned_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Submission Date');
ALTER TABLE `construction_ecm`.`design`.`handover_package` ALTER COLUMN `required_document_count` SET TAGS ('dbx_business_glossary_term' = 'Required Document Count');
ALTER TABLE `construction_ecm`.`design`.`handover_package` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period Years');
ALTER TABLE `construction_ecm`.`design`.`handover_package` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By');
ALTER TABLE `construction_ecm`.`design`.`handover_package` ALTER COLUMN `scope_of_works` SET TAGS ('dbx_business_glossary_term' = 'Scope of Works');
ALTER TABLE `construction_ecm`.`design`.`handover_package` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `construction_ecm`.`design`.`handover_package` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `construction_ecm`.`design`.`handover_package` ALTER COLUMN `submitted_document_count` SET TAGS ('dbx_business_glossary_term' = 'Submitted Document Count');
ALTER TABLE `construction_ecm`.`design`.`handover_item` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`design`.`handover_item` SET TAGS ('dbx_subdomain' = 'drawing_management');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `handover_item_id` SET TAGS ('dbx_business_glossary_term' = 'Handover Item ID');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `bim_model_id` SET TAGS ('dbx_business_glossary_term' = 'Bim Model Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Worker Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `document_register_id` SET TAGS ('dbx_business_glossary_term' = 'Document Register Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `handover_certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Handover Certificate Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `handover_package_id` SET TAGS ('dbx_business_glossary_term' = 'Handover Package ID');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `inspection_record_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Record Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `maintenance_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Plan Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `permit_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Condition Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Contact Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `revision_id` SET TAGS ('dbx_business_glossary_term' = 'Revision Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `technical_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `actual_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Submission Date');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `certification_required` SET TAGS ('dbx_business_glossary_term' = 'Certification Required');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `certifying_authority` SET TAGS ('dbx_business_glossary_term' = 'Certifying Authority');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `client_review_date` SET TAGS ('dbx_business_glossary_term' = 'Client Review Date');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `client_review_status` SET TAGS ('dbx_business_glossary_term' = 'Client Review Status');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `client_reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Client Reviewer Name');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `client_reviewer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `client_reviewer_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completed Timestamp');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `contractual_requirement` SET TAGS ('dbx_business_glossary_term' = 'Contractual Requirement');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `discipline` SET TAGS ('dbx_business_glossary_term' = 'Engineering Discipline');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `file_location` SET TAGS ('dbx_business_glossary_term' = 'File Location');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `format_type` SET TAGS ('dbx_business_glossary_term' = 'Format Type');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `format_type` SET TAGS ('dbx_value_regex' = 'hard_copy|electronic|both');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'Item Description');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `item_number` SET TAGS ('dbx_business_glossary_term' = 'Item Number');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `item_status` SET TAGS ('dbx_business_glossary_term' = 'Item Status');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `item_title` SET TAGS ('dbx_business_glossary_term' = 'Item Title');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `item_type` SET TAGS ('dbx_business_glossary_term' = 'Item Type');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Language');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `outstanding_action_notes` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Action Notes');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Page Count');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `planned_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Submission Date');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `system_reference` SET TAGS ('dbx_business_glossary_term' = 'System Reference');
ALTER TABLE `construction_ecm`.`design`.`handover_item` ALTER COLUMN `warranty_period_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Period Months');
ALTER TABLE `construction_ecm`.`design`.`bim_model` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`design`.`bim_model` SET TAGS ('dbx_subdomain' = 'drawing_management');
ALTER TABLE `construction_ecm`.`design`.`bim_model` ALTER COLUMN `bim_model_id` SET TAGS ('dbx_business_glossary_term' = 'Building Information Model (BIM) Model ID');
ALTER TABLE `construction_ecm`.`design`.`bim_model` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `construction_ecm`.`design`.`bim_model` ALTER COLUMN `env_impact_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Env Impact Assessment Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`bim_model` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`bim_model` ALTER COLUMN `superseded_by_model_bim_model_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Model ID');
ALTER TABLE `construction_ecm`.`design`.`bim_model` ALTER COLUMN `author_organization` SET TAGS ('dbx_business_glossary_term' = 'Author Organization');
ALTER TABLE `construction_ecm`.`design`.`bim_model` ALTER COLUMN `authoring_software` SET TAGS ('dbx_business_glossary_term' = 'Authoring Software');
ALTER TABLE `construction_ecm`.`design`.`bim_model` ALTER COLUMN `building_zone` SET TAGS ('dbx_business_glossary_term' = 'Building Zone');
ALTER TABLE `construction_ecm`.`design`.`bim_model` ALTER COLUMN `clash_count` SET TAGS ('dbx_business_glossary_term' = 'Clash Count');
ALTER TABLE `construction_ecm`.`design`.`bim_model` ALTER COLUMN `clash_detection_status` SET TAGS ('dbx_business_glossary_term' = 'Clash Detection Status');
ALTER TABLE `construction_ecm`.`design`.`bim_model` ALTER COLUMN `clash_detection_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|issues_identified|resolved');
ALTER TABLE `construction_ecm`.`design`.`bim_model` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `construction_ecm`.`design`.`bim_model` ALTER COLUMN `confidentiality_classification` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Classification');
ALTER TABLE `construction_ecm`.`design`.`bim_model` ALTER COLUMN `confidentiality_classification` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `construction_ecm`.`design`.`bim_model` ALTER COLUMN `coordinate_system` SET TAGS ('dbx_business_glossary_term' = 'Project Coordinate System');
ALTER TABLE `construction_ecm`.`design`.`bim_model` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `construction_ecm`.`design`.`bim_model` ALTER COLUMN `discipline` SET TAGS ('dbx_business_glossary_term' = 'BIM Discipline');
ALTER TABLE `construction_ecm`.`design`.`bim_model` ALTER COLUMN `element_count` SET TAGS ('dbx_business_glossary_term' = 'Element Count');
ALTER TABLE `construction_ecm`.`design`.`bim_model` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference ID');
ALTER TABLE `construction_ecm`.`design`.`bim_model` ALTER COLUMN `federation_role` SET TAGS ('dbx_business_glossary_term' = 'Federation Role');
ALTER TABLE `construction_ecm`.`design`.`bim_model` ALTER COLUMN `federation_role` SET TAGS ('dbx_value_regex' = 'host|linked|standalone|reference');
ALTER TABLE `construction_ecm`.`design`.`bim_model` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `construction_ecm`.`design`.`bim_model` ALTER COLUMN `file_size_mb` SET TAGS ('dbx_business_glossary_term' = 'File Size (MB)');
ALTER TABLE `construction_ecm`.`design`.`bim_model` ALTER COLUMN `iso_19650_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'ISO 19650 Compliance Flag');
ALTER TABLE `construction_ecm`.`design`.`bim_model` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `construction_ecm`.`design`.`bim_model` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `construction_ecm`.`design`.`bim_model` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Project Lifecycle Stage');
ALTER TABLE `construction_ecm`.`design`.`bim_model` ALTER COLUMN `lod_classification` SET TAGS ('dbx_business_glossary_term' = 'Level of Development (LOD) Classification');
ALTER TABLE `construction_ecm`.`design`.`bim_model` ALTER COLUMN `lod_classification` SET TAGS ('dbx_value_regex' = 'LOD_100|LOD_200|LOD_300|LOD_350|LOD_400|LOD_500');
ALTER TABLE `construction_ecm`.`design`.`bim_model` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'BIM Model Name');
ALTER TABLE `construction_ecm`.`design`.`bim_model` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'BIM Model Number');
ALTER TABLE `construction_ecm`.`design`.`bim_model` ALTER COLUMN `model_status` SET TAGS ('dbx_business_glossary_term' = 'BIM Model Status');
ALTER TABLE `construction_ecm`.`design`.`bim_model` ALTER COLUMN `model_status` SET TAGS ('dbx_value_regex' = 'wip|shared|published|archived|superseded');
ALTER TABLE `construction_ecm`.`design`.`bim_model` ALTER COLUMN `model_type` SET TAGS ('dbx_business_glossary_term' = 'BIM Model Type');
ALTER TABLE `construction_ecm`.`design`.`bim_model` ALTER COLUMN `model_type` SET TAGS ('dbx_value_regex' = 'design|coordination|construction|as_built|facility_management');
ALTER TABLE `construction_ecm`.`design`.`bim_model` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `construction_ecm`.`design`.`bim_model` ALTER COLUMN `origin_elevation_m` SET TAGS ('dbx_business_glossary_term' = 'Origin Elevation (Meters)');
ALTER TABLE `construction_ecm`.`design`.`bim_model` ALTER COLUMN `origin_latitude` SET TAGS ('dbx_business_glossary_term' = 'Origin Latitude');
ALTER TABLE `construction_ecm`.`design`.`bim_model` ALTER COLUMN `origin_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`design`.`bim_model` ALTER COLUMN `origin_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `construction_ecm`.`design`.`bim_model` ALTER COLUMN `origin_longitude` SET TAGS ('dbx_business_glossary_term' = 'Origin Longitude');
ALTER TABLE `construction_ecm`.`design`.`bim_model` ALTER COLUMN `origin_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`design`.`bim_model` ALTER COLUMN `origin_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `construction_ecm`.`design`.`bim_model` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `construction_ecm`.`design`.`bim_model` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `construction_ecm`.`design`.`bim_model` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `construction_ecm`.`design`.`bim_model` ALTER COLUMN `software_version` SET TAGS ('dbx_business_glossary_term' = 'Software Version');
ALTER TABLE `construction_ecm`.`design`.`bim_model` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `construction_ecm`.`design`.`bim_model` ALTER COLUMN `wbs_code` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `construction_ecm`.`design`.`drawing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`design`.`drawing` SET TAGS ('dbx_subdomain' = 'drawing_management');
ALTER TABLE `construction_ecm`.`design`.`drawing` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Identifier');
ALTER TABLE `construction_ecm`.`design`.`drawing` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`drawing` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`drawing` ALTER COLUMN `bim_model_id` SET TAGS ('dbx_business_glossary_term' = 'Bim Model Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`drawing` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier');
ALTER TABLE `construction_ecm`.`design`.`drawing` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Worker Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`drawing` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`drawing` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`drawing` ALTER COLUMN `permit_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Condition Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`drawing` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`drawing` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`drawing` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `construction_ecm`.`design`.`drawing` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `construction_ecm`.`design`.`drawing` ALTER COLUMN `cad_file_name` SET TAGS ('dbx_business_glossary_term' = 'Computer-Aided Design (CAD) File Name');
ALTER TABLE `construction_ecm`.`design`.`drawing` ALTER COLUMN `checker_name` SET TAGS ('dbx_business_glossary_term' = 'Checker Name');
ALTER TABLE `construction_ecm`.`design`.`drawing` ALTER COLUMN `clash_detection_status` SET TAGS ('dbx_business_glossary_term' = 'Clash Detection Status');
ALTER TABLE `construction_ecm`.`design`.`drawing` ALTER COLUMN `clash_detection_status` SET TAGS ('dbx_value_regex' = 'not_checked|passed|clashes_detected|resolved');
ALTER TABLE `construction_ecm`.`design`.`drawing` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `construction_ecm`.`design`.`drawing` ALTER COLUMN `confidentiality_classification` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Classification');
ALTER TABLE `construction_ecm`.`design`.`drawing` ALTER COLUMN `confidentiality_classification` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `construction_ecm`.`design`.`drawing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `construction_ecm`.`design`.`drawing` ALTER COLUMN `discipline` SET TAGS ('dbx_business_glossary_term' = 'Engineering Discipline');
ALTER TABLE `construction_ecm`.`design`.`drawing` ALTER COLUMN `distribution_list` SET TAGS ('dbx_business_glossary_term' = 'Distribution List');
ALTER TABLE `construction_ecm`.`design`.`drawing` ALTER COLUMN `drawing_number` SET TAGS ('dbx_business_glossary_term' = 'Drawing Number');
ALTER TABLE `construction_ecm`.`design`.`drawing` ALTER COLUMN `drawing_status` SET TAGS ('dbx_business_glossary_term' = 'Drawing Status');
ALTER TABLE `construction_ecm`.`design`.`drawing` ALTER COLUMN `drawing_type` SET TAGS ('dbx_business_glossary_term' = 'Drawing Type');
ALTER TABLE `construction_ecm`.`design`.`drawing` ALTER COLUMN `drawing_type` SET TAGS ('dbx_value_regex' = 'plan|elevation|section|detail|schedule|isometric');
ALTER TABLE `construction_ecm`.`design`.`drawing` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `construction_ecm`.`design`.`drawing` ALTER COLUMN `file_format` SET TAGS ('dbx_value_regex' = 'PDF|DWG|DXF|RVT|IFC|DGN');
ALTER TABLE `construction_ecm`.`design`.`drawing` ALTER COLUMN `file_size_mb` SET TAGS ('dbx_business_glossary_term' = 'File Size in Megabytes (MB)');
ALTER TABLE `construction_ecm`.`design`.`drawing` ALTER COLUMN `is_client_deliverable` SET TAGS ('dbx_business_glossary_term' = 'Is Client Deliverable Flag');
ALTER TABLE `construction_ecm`.`design`.`drawing` ALTER COLUMN `is_controlled_document` SET TAGS ('dbx_business_glossary_term' = 'Is Controlled Document Flag');
ALTER TABLE `construction_ecm`.`design`.`drawing` ALTER COLUMN `issue_purpose` SET TAGS ('dbx_business_glossary_term' = 'Issue Purpose');
ALTER TABLE `construction_ecm`.`design`.`drawing` ALTER COLUMN `issue_purpose` SET TAGS ('dbx_value_regex' = 'information|review|approval|construction|tender|as_built');
ALTER TABLE `construction_ecm`.`design`.`drawing` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `construction_ecm`.`design`.`drawing` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `construction_ecm`.`design`.`drawing` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `construction_ecm`.`design`.`drawing` ALTER COLUMN `originator` SET TAGS ('dbx_business_glossary_term' = 'Originator Organization');
ALTER TABLE `construction_ecm`.`design`.`drawing` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Page Count');
ALTER TABLE `construction_ecm`.`design`.`drawing` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period in Years');
ALTER TABLE `construction_ecm`.`design`.`drawing` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Revision Date');
ALTER TABLE `construction_ecm`.`design`.`drawing` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `construction_ecm`.`design`.`drawing` ALTER COLUMN `scale` SET TAGS ('dbx_business_glossary_term' = 'Drawing Scale');
ALTER TABLE `construction_ecm`.`design`.`drawing` ALTER COLUMN `sheet_size` SET TAGS ('dbx_business_glossary_term' = 'Sheet Size');
ALTER TABLE `construction_ecm`.`design`.`drawing` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `construction_ecm`.`design`.`drawing` ALTER COLUMN `superseded_by_drawing_number` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Drawing Number');
ALTER TABLE `construction_ecm`.`design`.`drawing` ALTER COLUMN `supersedes_drawing_number` SET TAGS ('dbx_business_glossary_term' = 'Supersedes Drawing Number');
ALTER TABLE `construction_ecm`.`design`.`drawing` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Drawing Title');
ALTER TABLE `construction_ecm`.`design`.`drawing` ALTER COLUMN `zone_location` SET TAGS ('dbx_business_glossary_term' = 'Zone or Location');
ALTER TABLE `construction_ecm`.`design`.`drawing` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` SET TAGS ('dbx_subdomain' = 'drawing_management');
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ALTER COLUMN `drawing_revision_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Revision Identifier (ID)');
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Project Identifier (ID)');
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Identifier (ID)');
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ALTER COLUMN `superseded_revision_drawing_revision_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Revision Identifier (ID)');
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ALTER COLUMN `transmittal_id` SET TAGS ('dbx_business_glossary_term' = 'Transmittal Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ALTER COLUMN `acknowledgment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Required Flag');
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ALTER COLUMN `acknowledgment_status` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Status');
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ALTER COLUMN `acknowledgment_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|acknowledged|overdue');
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Full Name');
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ALTER COLUMN `bim_model_reference` SET TAGS ('dbx_business_glossary_term' = 'Building Information Modeling (BIM) Model Reference');
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ALTER COLUMN `change_summary` SET TAGS ('dbx_business_glossary_term' = 'Revision Change Summary');
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ALTER COLUMN `clash_detection_status` SET TAGS ('dbx_business_glossary_term' = 'Clash Detection Status');
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ALTER COLUMN `clash_detection_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|passed|failed|resolved');
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Revision Comments');
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Classification Level');
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ALTER COLUMN `discipline` SET TAGS ('dbx_business_glossary_term' = 'Engineering Discipline');
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ALTER COLUMN `distribution_date` SET TAGS ('dbx_business_glossary_term' = 'Distribution Date');
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ALTER COLUMN `distribution_method` SET TAGS ('dbx_business_glossary_term' = 'Distribution Method');
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ALTER COLUMN `distribution_method` SET TAGS ('dbx_value_regex' = 'electronic|hard_copy|both|portal|email');
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ALTER COLUMN `distribution_status` SET TAGS ('dbx_business_glossary_term' = 'Distribution Status');
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ALTER COLUMN `distribution_status` SET TAGS ('dbx_value_regex' = 'pending|distributed|acknowledged|rejected|superseded');
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format Type');
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ALTER COLUMN `file_size_mb` SET TAGS ('dbx_business_glossary_term' = 'File Size in Megabytes (MB)');
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ALTER COLUMN `issuing_engineer_name` SET TAGS ('dbx_business_glossary_term' = 'Issuing Engineer Full Name');
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Full Name');
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ALTER COLUMN `revision_code` SET TAGS ('dbx_business_glossary_term' = 'Revision Code');
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ALTER COLUMN `revision_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Revision Issue Date');
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ALTER COLUMN `revision_description` SET TAGS ('dbx_business_glossary_term' = 'Revision Change Description');
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Sequence Number');
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Reason for Revision');
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ALTER COLUMN `revision_status` SET TAGS ('dbx_business_glossary_term' = 'Revision Lifecycle Status');
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ALTER COLUMN `revision_type` SET TAGS ('dbx_business_glossary_term' = 'Revision Purpose Type');
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ALTER COLUMN `sheet_count` SET TAGS ('dbx_business_glossary_term' = 'Sheet Count');
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ALTER COLUMN `wbs_code` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` SET TAGS ('dbx_subdomain' = 'document_control');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `technical_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification ID');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `labor_cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Material Master Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `skill_trade_id` SET TAGS ('dbx_business_glossary_term' = 'Skill Trade Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `applicable_standards` SET TAGS ('dbx_business_glossary_term' = 'Applicable Standards');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional|not_required');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `approver_role` SET TAGS ('dbx_business_glossary_term' = 'Approver Role');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `author_name` SET TAGS ('dbx_business_glossary_term' = 'Author Name');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `author_organization` SET TAGS ('dbx_business_glossary_term' = 'Author Organization');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `boq_reference` SET TAGS ('dbx_business_glossary_term' = 'Bill of Quantities (BOQ) Reference');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `confidentiality_classification` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Classification');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `confidentiality_classification` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `csi_division` SET TAGS ('dbx_business_glossary_term' = 'Construction Specifications Institute (CSI) Division');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `discipline` SET TAGS ('dbx_business_glossary_term' = 'Engineering Discipline');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `environmental_requirements` SET TAGS ('dbx_business_glossary_term' = 'Environmental Requirements');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `file_storage_path` SET TAGS ('dbx_business_glossary_term' = 'File Storage Path');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `hse_requirements` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Requirements');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `is_client_deliverable` SET TAGS ('dbx_business_glossary_term' = 'Is Client Deliverable');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `material_requirements` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Page Count');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `scope_of_work` SET TAGS ('dbx_business_glossary_term' = 'Scope of Work (SOW)');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `section_number` SET TAGS ('dbx_business_glossary_term' = 'Section Number');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `specification_number` SET TAGS ('dbx_business_glossary_term' = 'Specification Number');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `specification_title` SET TAGS ('dbx_business_glossary_term' = 'Specification Title');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `specification_type` SET TAGS ('dbx_business_glossary_term' = 'Specification Type');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `specification_type` SET TAGS ('dbx_value_regex' = 'performance|prescriptive|proprietary|reference|master');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `submittal_requirements` SET TAGS ('dbx_business_glossary_term' = 'Submittal Requirements');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `superseded_date` SET TAGS ('dbx_business_glossary_term' = 'Superseded Date');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `supersedes_specification_number` SET TAGS ('dbx_business_glossary_term' = 'Supersedes Specification Number');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `technical_specification_status` SET TAGS ('dbx_business_glossary_term' = 'Specification Status');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `testing_requirements` SET TAGS ('dbx_business_glossary_term' = 'Testing Requirements');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `warranty_period_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Period (Months)');
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ALTER COLUMN `workmanship_standards` SET TAGS ('dbx_business_glossary_term' = 'Workmanship Standards');
ALTER TABLE `construction_ecm`.`design`.`package` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`design`.`package` SET TAGS ('dbx_subdomain' = 'document_control');
ALTER TABLE `construction_ecm`.`design`.`package` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package ID');
ALTER TABLE `construction_ecm`.`design`.`package` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `construction_ecm`.`design`.`package` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`package` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `construction_ecm`.`design`.`package` ALTER COLUMN `env_impact_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Env Impact Assessment Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`package` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`package` ALTER COLUMN `hse_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Plan Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`package` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`package` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`package` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`package` ALTER COLUMN `actual_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Submission Date');
ALTER TABLE `construction_ecm`.`design`.`package` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `construction_ecm`.`design`.`package` ALTER COLUMN `approval_workflow_state` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow State');
ALTER TABLE `construction_ecm`.`design`.`package` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `construction_ecm`.`design`.`package` ALTER COLUMN `client_acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Client Acceptance Date');
ALTER TABLE `construction_ecm`.`design`.`package` ALTER COLUMN `client_acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Client Acceptance Status');
ALTER TABLE `construction_ecm`.`design`.`package` ALTER COLUMN `client_acceptance_status` SET TAGS ('dbx_value_regex' = 'pending|accepted|accepted_with_comments|rejected|conditionally_accepted|superseded');
ALTER TABLE `construction_ecm`.`design`.`package` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `construction_ecm`.`design`.`package` ALTER COLUMN `completeness_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completeness Percentage');
ALTER TABLE `construction_ecm`.`design`.`package` ALTER COLUMN `confidentiality_classification` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Classification');
ALTER TABLE `construction_ecm`.`design`.`package` ALTER COLUMN `confidentiality_classification` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `construction_ecm`.`design`.`package` ALTER COLUMN `contractual_due_date` SET TAGS ('dbx_business_glossary_term' = 'Contractual Due Date');
ALTER TABLE `construction_ecm`.`design`.`package` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `construction_ecm`.`design`.`package` ALTER COLUMN `discipline` SET TAGS ('dbx_business_glossary_term' = 'Discipline');
ALTER TABLE `construction_ecm`.`design`.`package` ALTER COLUMN `document_count` SET TAGS ('dbx_business_glossary_term' = 'Document Count');
ALTER TABLE `construction_ecm`.`design`.`package` ALTER COLUMN `drawing_count` SET TAGS ('dbx_business_glossary_term' = 'Drawing Count');
ALTER TABLE `construction_ecm`.`design`.`package` ALTER COLUMN `iso_19650_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'ISO 19650 Compliance Flag');
ALTER TABLE `construction_ecm`.`design`.`package` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `construction_ecm`.`design`.`package` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `construction_ecm`.`design`.`package` ALTER COLUMN `package_number` SET TAGS ('dbx_business_glossary_term' = 'Package Number');
ALTER TABLE `construction_ecm`.`design`.`package` ALTER COLUMN `package_status` SET TAGS ('dbx_business_glossary_term' = 'Package Status');
ALTER TABLE `construction_ecm`.`design`.`package` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `construction_ecm`.`design`.`package` ALTER COLUMN `package_type` SET TAGS ('dbx_value_regex' = 'design_package|deliverable_package|submittal_package|handover_package|as_built_package|coordination_package');
ALTER TABLE `construction_ecm`.`design`.`package` ALTER COLUMN `planned_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Issue Date');
ALTER TABLE `construction_ecm`.`design`.`package` ALTER COLUMN `recipient_distribution_list` SET TAGS ('dbx_business_glossary_term' = 'Recipient Distribution List');
ALTER TABLE `construction_ecm`.`design`.`package` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `construction_ecm`.`design`.`package` ALTER COLUMN `responsible_organization` SET TAGS ('dbx_business_glossary_term' = 'Responsible Organization');
ALTER TABLE `construction_ecm`.`design`.`package` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By');
ALTER TABLE `construction_ecm`.`design`.`package` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `construction_ecm`.`design`.`package` ALTER COLUMN `specification_count` SET TAGS ('dbx_business_glossary_term' = 'Specification Count');
ALTER TABLE `construction_ecm`.`design`.`package` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `construction_ecm`.`design`.`package` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `construction_ecm`.`design`.`package` ALTER COLUMN `submission_status` SET TAGS ('dbx_value_regex' = 'not_submitted|submitted|under_review|resubmission_required|accepted|rejected');
ALTER TABLE `construction_ecm`.`design`.`package` ALTER COLUMN `supersedes_package_number` SET TAGS ('dbx_business_glossary_term' = 'Supersedes Package Number');
ALTER TABLE `construction_ecm`.`design`.`package` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Package Title');
ALTER TABLE `construction_ecm`.`design`.`package` ALTER COLUMN `transmittal_number` SET TAGS ('dbx_business_glossary_term' = 'Transmittal Number');
ALTER TABLE `construction_ecm`.`design`.`submittal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`design`.`submittal` SET TAGS ('dbx_subdomain' = 'document_control');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `submittal_id` SET TAGS ('dbx_business_glossary_term' = 'Design Submittal Identifier (ID)');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Client Contact Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Project Identifier (ID)');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Material Master Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `permit_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Condition Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `project_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Project Budget Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `project_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Project Milestone Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `rfi_id` SET TAGS ('dbx_business_glossary_term' = 'Rfi Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `technical_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `trade_package_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Package Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `transmittal_id` SET TAGS ('dbx_business_glossary_term' = 'Transmittal Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `work_front_id` SET TAGS ('dbx_business_glossary_term' = 'Work Front Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `actual_review_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Review Completion Date');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `actual_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Submission Date');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `approval_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority Level');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `approval_authority_level` SET TAGS ('dbx_value_regex' = 'contractor|design_consultant|client|regulatory_authority|independent_verifier');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `approval_disposition` SET TAGS ('dbx_business_glossary_term' = 'Approval Disposition Code');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `approval_disposition` SET TAGS ('dbx_value_regex' = 'approved|approved_as_noted|revise_and_resubmit|rejected|no_exception_taken|reviewed_for_information');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `approver_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `approver_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Attachment File Count');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `bim_model_reference` SET TAGS ('dbx_business_glossary_term' = 'Building Information Modeling (BIM) Model Reference');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Submittal Closure Date');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Classification Level');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `cost_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Flag');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `discipline` SET TAGS ('dbx_business_glossary_term' = 'Engineering Discipline');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `estimated_cost_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Impact Amount');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `estimated_cost_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'Primary File Format');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Submittal Priority Level');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Name');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Required Flag');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `required_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Required Submission Date');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `response_notes` SET TAGS ('dbx_business_glossary_term' = 'Submitter Response Notes');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `review_comments` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Comments');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Review Due Date');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `reviewing_organization` SET TAGS ('dbx_business_glossary_term' = 'Reviewing Organization Name');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Submittal Revision Number');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `schedule_impact_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Impact Days');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `schedule_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Schedule Impact Flag');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `submittal_number` SET TAGS ('dbx_business_glossary_term' = 'Submittal Number');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `submittal_status` SET TAGS ('dbx_business_glossary_term' = 'Submittal Review Status');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `submittal_type` SET TAGS ('dbx_business_glossary_term' = 'Submittal Type');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `submitting_organization` SET TAGS ('dbx_business_glossary_term' = 'Submitting Organization Name');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `supersedes_submittal_number` SET TAGS ('dbx_business_glossary_term' = 'Supersedes Submittal Number');
ALTER TABLE `construction_ecm`.`design`.`submittal` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Submittal Title');
ALTER TABLE `construction_ecm`.`design`.`review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`design`.`review` SET TAGS ('dbx_subdomain' = 'document_control');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `review_id` SET TAGS ('dbx_business_glossary_term' = 'Review ID');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `bim_model_id` SET TAGS ('dbx_business_glossary_term' = 'Bim Model Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Client Representative Contact Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `project_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Project Milestone Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `submittal_id` SET TAGS ('dbx_business_glossary_term' = 'Design Submittal Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `trade_package_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Package Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `work_front_id` SET TAGS ('dbx_business_glossary_term' = 'Work Front Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `action_items_count` SET TAGS ('dbx_business_glossary_term' = 'Action Items Count');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `attendee_count` SET TAGS ('dbx_business_glossary_term' = 'Attendee Count');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `attendee_list` SET TAGS ('dbx_business_glossary_term' = 'Attendee List');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `chairperson_name` SET TAGS ('dbx_business_glossary_term' = 'Chairperson Name');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `clash_detection_performed` SET TAGS ('dbx_business_glossary_term' = 'Clash Detection Performed Flag');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `clashes_identified_count` SET TAGS ('dbx_business_glossary_term' = 'Clashes Identified Count');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `client_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Client Approval Date');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `client_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Client Approval Required Flag');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `comments_closed_count` SET TAGS ('dbx_business_glossary_term' = 'Comments Closed Count');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `comments_open_count` SET TAGS ('dbx_business_glossary_term' = 'Comments Open Count');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `discipline` SET TAGS ('dbx_business_glossary_term' = 'Discipline');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Review Disposition');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `disposition` SET TAGS ('dbx_value_regex' = 'accepted|conditionally_accepted|rejected|revise_and_resubmit');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Review Duration Hours');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference ID');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `major_comments_count` SET TAGS ('dbx_business_glossary_term' = 'Major Comments Count');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `meeting_location` SET TAGS ('dbx_business_glossary_term' = 'Meeting Location');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `minor_comments_count` SET TAGS ('dbx_business_glossary_term' = 'Minor Comments Count');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `minutes_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Minutes Document Reference');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `next_review_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Scheduled Date');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `recommendations` SET TAGS ('dbx_business_glossary_term' = 'Recommendations');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `review_number` SET TAGS ('dbx_business_glossary_term' = 'Review Number');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|deferred');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Review Type');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = 'internal_peer_review|interdisciplinary_check|client_milestone_review|third_party_review|authority_review|constructability_review');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Date');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `sign_off_authority` SET TAGS ('dbx_business_glossary_term' = 'Sign-Off Authority');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `sign_off_date` SET TAGS ('dbx_business_glossary_term' = 'Sign-Off Date');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `stage` SET TAGS ('dbx_business_glossary_term' = 'Review Stage');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `summary` SET TAGS ('dbx_business_glossary_term' = 'Review Summary');
ALTER TABLE `construction_ecm`.`design`.`review` ALTER COLUMN `total_comments_raised` SET TAGS ('dbx_business_glossary_term' = 'Total Comments Raised');
ALTER TABLE `construction_ecm`.`design`.`change_notice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`design`.`change_notice` SET TAGS ('dbx_subdomain' = 'document_control');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `change_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Change Notice ID');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `contract_change_order_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Change Order Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Originator Worker Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `env_impact_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Env Impact Assessment Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Material Master Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Originator Contact Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `project_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Project Budget Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `trade_package_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Package Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `work_front_id` SET TAGS ('dbx_business_glossary_term' = 'Work Front Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `actual_cost_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Impact Amount');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `actual_schedule_impact_days` SET TAGS ('dbx_business_glossary_term' = 'Actual Schedule Impact Days');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `affected_disciplines` SET TAGS ('dbx_business_glossary_term' = 'Affected Disciplines');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `bim_model_reference` SET TAGS ('dbx_business_glossary_term' = 'Building Information Modeling (BIM) Model Reference');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `change_notice_description` SET TAGS ('dbx_business_glossary_term' = 'Change Notice Description');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `change_notice_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Notice (ECN) Number');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `change_notice_status` SET TAGS ('dbx_business_glossary_term' = 'Change Notice Status');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `change_notice_type` SET TAGS ('dbx_business_glossary_term' = 'Change Notice Type');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `change_notice_type` SET TAGS ('dbx_value_regex' = 'design_change|engineering_change|specification_change|material_substitution|scope_change|regulatory_change');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `clash_detection_impact` SET TAGS ('dbx_business_glossary_term' = 'Clash Detection Impact');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `client_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Client Approval Date');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `client_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Client Approval Required Flag');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `cost_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Flag');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `date_raised` SET TAGS ('dbx_business_glossary_term' = 'Date Raised');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `discipline` SET TAGS ('dbx_business_glossary_term' = 'Engineering Discipline');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `estimated_cost_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Impact Amount');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `estimated_schedule_impact_days` SET TAGS ('dbx_business_glossary_term' = 'Estimated Schedule Impact Days');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `implementation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Implementation Completion Date');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `implementation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Implementation Start Date');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `implementation_status` SET TAGS ('dbx_business_glossary_term' = 'Implementation Status');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `implementation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|on_hold|cancelled');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `originating_cause` SET TAGS ('dbx_business_glossary_term' = 'Originating Cause');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `originating_cause` SET TAGS ('dbx_value_regex' = 'client_instruction|site_condition|design_error|regulatory_requirement|value_engineering|constructability_improvement');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `originator_organization` SET TAGS ('dbx_business_glossary_term' = 'Originator Organization');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Change Notice Priority');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `rejection_date` SET TAGS ('dbx_business_glossary_term' = 'Rejection Date');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `schedule_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Schedule Impact Flag');
ALTER TABLE `construction_ecm`.`design`.`change_notice` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Change Notice Title');
