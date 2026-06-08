-- Schema for Domain: knowledge | Business: Legal | Version: v8_ecm
-- Generated on: 2026-05-21 01:11:37

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `legal_ecm_v1`.`knowledge` COMMENT 'Curates and governs the firms institutional knowledge assets including precedent documents, practice notes, legal research memoranda, standard clause libraries, form libraries, checklists, and expertise directories. Integrates Thomson Reuters Practical Law and LexisNexis as primary knowledge platforms. Supports knowledge capture, taxonomy management, and NLP-driven retrieval.';

-- ========= TABLES =========
CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`knowledge`.`expertise_directory` (
    `expertise_directory_id` BIGINT COMMENT 'Unique identifier for the expertise directory record. Primary key for the expertise directory product.',
    `attorney_profile_id` BIGINT COMMENT 'Foreign key linking to workforce.attorney_profile. Business justification: Expertise directories support client pitch materials, matter staffing, and lateral hiring decisions that require verified bar admissions, practice area certifications, and professional credentials sto',
    `timekeeper_id` BIGINT COMMENT 'Reference to the attorney or professional staff member whose expertise is profiled. Links to the workforce domain timekeeper master data.',
    `cle_hours_completed` DECIMAL(18,2) COMMENT 'Total number of Continuing Legal Education hours completed by the timekeeper, demonstrating ongoing professional development and knowledge currency.',
    `client_feedback_score` DECIMAL(18,2) COMMENT 'Average client satisfaction or feedback score for the timekeepers work, used to assess quality and client service excellence. Scale typically 0-10 or 0-5.',
    `cpd_hours_completed` DECIMAL(18,2) COMMENT 'Total number of Continuing Professional Development hours completed, used in jurisdictions outside the US such as UK and Commonwealth countries.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the expertise directory record was first created in the system, supporting audit trail and data lineage requirements.',
    `expert_identification_rank` STRING COMMENT 'Ranking of the timekeeper within their practice area or expertise domain for expert identification and knowledge routing purposes. Lower numbers indicate higher expertise.',
    `expertise_level` STRING COMMENT 'Classification of the timekeepers expertise level based on experience, credentials, and recognition within their practice area.. Valid values are `junior|mid_level|senior|expert|thought_leader`',
    `expertise_taxonomy_alignment` BIGINT COMMENT 'FK to knowledge.knowledge_taxonomy.knowledge_taxonomy_id — Expertise profiles must align to taxonomy nodes so that knowledge routing (matching questions to experts) works via the same classification scheme used for assets.',
    `expertise_to_taxonomy` BIGINT COMMENT 'FK to knowledge.knowledge_taxonomy.knowledge_taxonomy_id — Expertise profiles reference taxonomy nodes (practice areas, jurisdictions) for consistent classification and knowledge routing.',
    `industry_sector_expertise` STRING COMMENT 'Industry sectors in which the timekeeper has specialized knowledge and experience, such as Financial Services, Healthcare, Technology, Energy, Manufacturing, or Government. Stored as delimited list.',
    `jurisdiction_admissions` STRING COMMENT 'List of jurisdictions where the timekeeper is admitted to practice law, including state bars, federal courts, and international jurisdictions. Stored as delimited string of jurisdiction codes.',
    `knowledge_asset_count` STRING COMMENT 'Total number of knowledge assets (precedent documents, practice notes, legal research memoranda, standard clauses) authored or contributed to by the timekeeper.',
    `language_capabilities` STRING COMMENT 'Languages in which the timekeeper is proficient for legal work, stored as delimited list of ISO 639-1 language codes or language names.',
    `last_cle_completion_date` DATE COMMENT 'Date when the timekeeper most recently completed a CLE or CPD course, indicating currency of professional development.',
    `last_profile_update_date` DATE COMMENT 'Date when the expertise profile was last updated or reviewed, indicating currency of the information.',
    `matter_staffing_score` DECIMAL(18,2) COMMENT 'Calculated score used for intelligent matter staffing recommendations, based on expertise match, availability, and historical performance. Scale typically 0-100.',
    `matter_type_expertise` STRING COMMENT 'Specific types of legal matters in which the timekeeper has specialized experience, such as M&A transactions, patent prosecution, employment disputes, or regulatory investigations. Stored as delimited list.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the expertise directory record was last modified, supporting change tracking and data quality monitoring.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review or update of the expertise profile to ensure ongoing accuracy and completeness.',
    `nlp_expertise_tags` STRING COMMENT 'Machine-generated expertise tags extracted from the timekeepers authored knowledge assets, documents, and research memoranda using Natural Language Processing and text analytics. Stored as delimited keyword list.',
    `notable_matters` STRING COMMENT 'Summary or list of significant matters, cases, or transactions the timekeeper has worked on, demonstrating expertise and experience. Stored as concatenated text.',
    `peer_recognition_score` DECIMAL(18,2) COMMENT 'Score reflecting recognition by peers within the firm or legal community, based on internal reviews, peer nominations, or external rankings.',
    `primary_practice_area` STRING COMMENT 'The main legal practice area in which the timekeeper has expertise, such as Corporate Transactions, Litigation, Intellectual Property, Employment Law, or Regulatory Compliance.',
    `professional_certifications` STRING COMMENT 'Specialized legal certifications, board certifications, or professional designations held by the timekeeper, such as Certified Specialist in Intellectual Property Law or Chartered Legal Executive.',
    `profile_completeness_percentage` DECIMAL(18,2) COMMENT 'Percentage indicating how complete the expertise profile is, based on the presence of key fields and data quality. Used to prioritize profile maintenance.',
    `profile_description` STRING COMMENT 'Free-text narrative describing the timekeepers expertise, background, notable achievements, and areas of specialization in detail.',
    `profile_name` STRING COMMENT 'Display name for the expertise profile, typically the timekeepers full name or professional designation.',
    `profile_status` STRING COMMENT 'Current lifecycle status of the expertise profile indicating whether it is actively maintained and available for knowledge routing.. Valid values are `active|inactive|pending_review|archived`',
    `profile_visibility` STRING COMMENT 'Access level controlling who can view the expertise profile, supporting confidentiality and information governance requirements.. Valid values are `public|internal|restricted|private`',
    `publication_count` STRING COMMENT 'Total number of legal publications, articles, white papers, or treatises authored or co-authored by the timekeeper, indicating thought leadership.',
    `recent_publications` STRING COMMENT 'List or summary of the timekeepers most recent or notable publications, stored as delimited text or concatenated string.',
    `secondary_practice_areas` STRING COMMENT 'Additional legal practice areas in which the timekeeper has demonstrable expertise, stored as a delimited list or concatenated string.',
    `source_reference_code` STRING COMMENT 'Unique identifier of the expertise profile record in the source system, enabling traceability and reconciliation.',
    `source_system` STRING COMMENT 'Name of the operational system from which the expertise profile data originated, such as Elite 3E, SAP SuccessFactors, or Thomson Reuters Practical Law.',
    `speaking_engagement_count` STRING COMMENT 'Total number of professional speaking engagements, conferences, seminars, or webinars where the timekeeper has presented, indicating external recognition.',
    `transaction_type_expertise` STRING COMMENT 'Specific transaction types the timekeeper has handled, such as Share Purchase Agreements (SPA), Mergers and Acquisitions (M&A), joint ventures, or debt financing. Stored as delimited list.',
    `years_of_experience` STRING COMMENT 'Total number of years the timekeeper has practiced law or provided professional legal services.',
    CONSTRAINT pk_expertise_directory PRIMARY KEY(`expertise_directory_id`)
) COMMENT 'Directory of attorney and professional staff expertise profiles enabling knowledge routing, matter staffing recommendations, and expert identification. Each record captures timekeeper reference, practice area specializations, jurisdiction admissions, industry sector expertise, language capabilities, CPD/CLE completion records, publication history, and NLP-derived expertise tags extracted from authored knowledge assets. Complements the workforce domain attorney master data by adding knowledge-specific expertise dimensions used for intelligent work allocation.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` (
    `knowledge_asset_id` BIGINT COMMENT 'Unique identifier for the knowledge asset. Primary key for the knowledge asset catalog.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Knowledge assets must be tagged to relevant compliance policies for governance, access control, and policy adherence verification. Essential for information governance audits and demonstrating policy ',
    `external_source_id` BIGINT COMMENT 'FK to knowledge.external_source.external_source_id — Knowledge assets sourced from external platforms (Practical Law, LexisNexis) must reference their source for licensing compliance, update tracking, and provenance governance.',
    `parent_knowledge_asset_id` BIGINT COMMENT 'Reference to the parent knowledge asset if this asset is a derivative, version, or child of another asset. Supports hierarchical asset relationships. Nullable for root assets.',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: All knowledge assets are taxonomized by practice area for organization and discovery. Used in knowledge management, asset search, and CPD tracking. Normalizes practice_area text field to enable enterp',
    `timekeeper_id` BIGINT COMMENT 'Reference to the timekeeper assigned to review and approve this knowledge asset before publication.',
    `taxonomy_id` BIGINT COMMENT 'Foreign key linking to knowledge.knowledge_taxonomy. Business justification: Knowledge assets should have a primary taxonomy classification for governance and retrieval. Currently has taxonomy_tags STRING for multi-valued tags, but needs FK for primary classification node. One',
    `access_classification` STRING COMMENT 'Data classification level governing who may access this knowledge asset. Aligns with firm information security policy.. Valid values are `restricted|confidential|internal|public`',
    `approval_outcome` STRING COMMENT 'Final outcome of the review process indicating whether the knowledge asset was approved for publication, rejected, or conditionally approved pending revisions.. Valid values are `approved|rejected|conditional_approval`',
    `asset_code` STRING COMMENT 'Business-readable unique code for the knowledge asset, typically formatted as KA-{TYPE}-{SEQUENCE}. Used for cross-system referencing and citation.. Valid values are `^KA-[A-Z]{2,4}-[0-9]{6}$`',
    `asset_name` STRING COMMENT 'The title or name of the knowledge asset as it appears in the knowledge management system and search results.',
    `asset_taxonomy_node` BIGINT COMMENT 'FK to knowledge.knowledge_taxonomy.knowledge_taxonomy_id — All knowledge assets must be classifiable under the taxonomy. This is the universal classification FK that enables cross-asset-type search and retrieval.',
    `asset_type` STRING COMMENT 'Classification of the knowledge asset by its structural type. Determines which type-specific product table holds detailed attributes. [ENUM-REF-CANDIDATE: precedent|practice_note|clause_library|form_template|checklist|research_memo|expertise_directory|training_material|legal_opinion|briefing_note — 10 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this knowledge asset record was first created in the knowledge management system. Audit trail field.',
    `effective_date` DATE COMMENT 'Date from which this version of the knowledge asset is considered current and applicable for use.',
    `expiration_date` DATE COMMENT 'Date after which this knowledge asset is no longer considered current and should be reviewed or retired. Nullable for assets without scheduled expiration.',
    `is_lpp_protected` BOOLEAN COMMENT 'Indicates whether this knowledge asset is subject to legal professional privilege and must be protected from disclosure. Critical for eDiscovery and regulatory requests.',
    `is_template` BOOLEAN COMMENT 'Indicates whether this knowledge asset is intended to be used as a reusable template for creating new documents or work products.',
    `is_work_product` BOOLEAN COMMENT 'Indicates whether this asset qualifies as attorney work product, providing additional protection from discovery under work product doctrine.',
    `jurisdiction` STRING COMMENT 'Primary legal jurisdiction for which this knowledge asset is applicable, using ISO 3166-1 alpha-3 country codes (e.g., USA, GBR, DEU). Multi-jurisdictional assets use the primary or most relevant jurisdiction.. Valid values are `^[A-Z]{3}$`',
    `knowledge_asset_description` STRING COMMENT 'Detailed business description of the knowledge asset, its purpose, scope, and intended use cases. Used for search and discovery.',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code indicating the primary language of the knowledge asset content (e.g., en, fr, de, es).. Valid values are `^[a-z]{2}$`',
    `last_used_date` DATE COMMENT 'Most recent date on which this knowledge asset was accessed or applied in a client matter. Used to identify stale or obsolete assets.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the knowledge asset within the knowledge management workflow. [ENUM-REF-CANDIDATE: draft|under_review|approved|published|archived|deprecated|withdrawn — 7 candidates stripped; promote to reference product]',
    `matter_type` STRING COMMENT 'Type of legal matter or transaction for which this knowledge asset is most relevant (e.g., SPA, NDA, litigation discovery, patent prosecution).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this knowledge asset record was last modified. Audit trail field.',
    `next_review_date` DATE COMMENT 'Date on which this knowledge asset is scheduled for its next periodic review to ensure currency and accuracy.',
    `nlp_embedding_version` STRING COMMENT 'Version identifier of the NLP model used to generate semantic embeddings for this knowledge asset, enabling AI-driven search and retrieval.',
    `regulatory_framework` STRING COMMENT 'Comma-separated list of regulatory frameworks, statutes, or compliance regimes to which this knowledge asset relates (e.g., GDPR, SOX, CCPA, FRAND, AML).',
    `rejection_reason` STRING COMMENT 'Explanation provided by the reviewer if the knowledge asset was rejected or revision was requested. Nullable if approved.',
    `retention_schedule` STRING COMMENT 'Records retention schedule applicable to this knowledge asset, determining minimum retention period before eligible for destruction.. Valid values are `permanent|7_years|10_years|matter_plus_7|regulatory_hold|custom`',
    `review_status` STRING COMMENT 'Current status of the knowledge asset within the review and approval workflow.. Valid values are `pending|in_review|approved|rejected|revision_requested`',
    `source_reference_code` STRING COMMENT 'The unique identifier or document ID of this asset in the source system (e.g., iManage document number, NetDocuments GUID, Practical Law resource ID).',
    `source_system` STRING COMMENT 'The operational system of record from which this knowledge asset originates or is primarily managed. [ENUM-REF-CANDIDATE: imanage|netdocuments|practical_law|lexisnexis|internal_km|relativity|elite_3e — 7 candidates stripped; promote to reference product]',
    `submission_date` DATE COMMENT 'Date on which the knowledge asset was submitted to the knowledge management system for review and approval.',
    `taxonomy_tags` STRING COMMENT 'Comma-separated list of taxonomy terms and keywords applied to this asset for classification, search, and NLP-driven retrieval. Supports multi-dimensional tagging.',
    `usage_count` STRING COMMENT 'Total number of times this knowledge asset has been accessed, downloaded, or applied in client matters. Used for popularity and value analytics.',
    `usage_notes` STRING COMMENT 'Guidance and instructions for timekeepers on how to properly use, adapt, or apply this knowledge asset in client matters.',
    `version_number` STRING COMMENT 'Semantic version number of the knowledge asset (e.g., 1.0, 2.1, 3.0.1). Incremented with each substantive revision.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    CONSTRAINT pk_knowledge_asset PRIMARY KEY(`knowledge_asset_id`)
) COMMENT 'Unified master catalog and registry of all knowledge assets managed within the knowledge domain, serving as the single entry point for cross-asset search, governance, analytics, and contribution tracking regardless of asset type. Each type-specific product (precedent, practice_note, clause, form_template, checklist, research_memo) holds a foreign key to this catalog. Captures asset type, source system (iManage, NetDocuments, Practical Law, LexisNexis), access classification (restricted/confidential/internal/public), LPP flag, retention schedule, lifecycle status, and full contribution workflow (contributor timekeeper reference, asset type submitted, submission date, reviewer assignment, review status, approval/rejection outcome, CPD/CLE credit eligibility, contribution history). Enables NLP-driven retrieval, knowledge contribution governance, and portfolio-level analytics.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`knowledge`.`asset_usage` (
    `asset_usage_id` BIGINT COMMENT 'Unique identifier for the knowledge asset usage transaction. Primary key for the asset usage record.',
    `legal_document_id` BIGINT COMMENT 'Reference to the document in which the knowledge asset was cited, linked, or applied. Nullable for usage types that do not involve document integration (e.g., view-only access).',
    `matter_id` BIGINT COMMENT 'Reference to the matter in which the knowledge asset was used. Enables matter-level knowledge reuse tracking and post-matter knowledge harvesting.',
    `knowledge_asset_id` BIGINT COMMENT 'Reference to the knowledge asset that was accessed or used. Links to the knowledge asset master record.',
    `profile_id` BIGINT COMMENT 'Reference to the client for whom the matter work was performed. Enables client-level knowledge reuse tracking and cross-matter knowledge pattern analysis for specific clients.',
    `tertiary_knowledge_asset_id` BIGINT COMMENT 'FK to knowledge.knowledge_asset.knowledge_asset_id — Every usage event must reference the knowledge_asset it pertains to. This is the core transactional FK enabling usage analytics.',
    `timekeeper_id` BIGINT COMMENT 'Reference to the timekeeper (attorney, paralegal, or legal professional) who accessed or used the knowledge asset. Enables usage analytics by individual and expertise tracking.',
    `access_method` STRING COMMENT 'The method or channel through which the knowledge asset was accessed. Distinguishes between search-driven discovery, recommendation engine, direct link, Application Programming Interface (API) integration, or other access paths. [ENUM-REF-CANDIDATE: web_portal|mobile_app|api|email_link|search|recommendation|direct_link — 7 candidates stripped; promote to reference product]',
    `adaptation_type` STRING COMMENT 'The type of adaptation or modification made to the knowledge asset, if applicable. Relevant for usage_type of adapt. Supports understanding of how assets are customized and identifies candidates for new precedent creation.. Valid values are `minor_edit|substantial_revision|clause_extraction|template_customization|translation|none`',
    `billable_flag` BOOLEAN COMMENT 'Indicates whether the time spent accessing or using the knowledge asset was billable to the client. Supports Return on Investment (ROI) analysis of knowledge management investments and efficiency tracking.',
    `citation_location` STRING COMMENT 'The specific location within a document where the knowledge asset was cited or referenced (e.g., section number, page number, paragraph identifier). Relevant for usage_type of cite or link.',
    `cost_savings_amount` DECIMAL(18,2) COMMENT 'Estimated cost savings achieved by using the knowledge asset, calculated based on time saved and timekeeper billing rates. Supports financial justification of knowledge management programs.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the usage record was first created in the system. Audit trail for data lineage and compliance.',
    `currency_code` STRING COMMENT 'The currency in which cost savings are measured. Uses 3-letter ISO 4217 currency codes. Relevant when cost_savings_amount is populated. [ENUM-REF-CANDIDATE: USD|GBP|EUR|CAD|AUD|JPY|CHF — 7 candidates stripped; promote to reference product]',
    `device_type` STRING COMMENT 'The type of device from which the knowledge asset was accessed. Supports user experience optimization and mobile-first knowledge delivery strategies.. Valid values are `desktop|laptop|tablet|mobile|other`',
    `duration_seconds` STRING COMMENT 'The duration of the usage session in seconds. Applicable primarily to view and download usage types. Provides insight into engagement depth and asset complexity.',
    `error_code` STRING COMMENT 'System error code if the usage event failed or encountered an issue. Supports troubleshooting and knowledge platform reliability monitoring.',
    `error_message` STRING COMMENT 'Human-readable error message describing the failure or issue encountered during the usage event. Supports user support and system diagnostics.',
    `feedback_comment` STRING COMMENT 'Optional free-text feedback provided by the user regarding the knowledge assets quality, applicability, or suggested improvements. Supports continuous knowledge asset refinement.',
    `ip_address` STRING COMMENT 'The Internet Protocol (IP) address from which the usage event originated. Used for security audit, access control verification, and geographic usage pattern analysis. May be considered Personally Identifiable Information (PII) in some jurisdictions.',
    `jurisdiction` STRING COMMENT 'The legal jurisdiction relevant to the usage context (e.g., USA, GBR, DEU). Uses 3-letter ISO country codes. Supports jurisdiction-specific knowledge reuse analysis.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when the usage record was last modified. Audit trail for data lineage and compliance.',
    `practice_area` STRING COMMENT 'The legal practice area in which the knowledge asset was used (e.g., Corporate, Litigation, Intellectual Property (IP), Employment, Regulatory Compliance). Enables practice-specific usage analytics and knowledge investment prioritization.',
    `relevance_rating` STRING COMMENT 'User-provided rating of the knowledge assets relevance to the task or matter, typically on a scale of 1 to 5. Enables feedback-driven curation and quality assessment of knowledge assets.',
    `search_query` STRING COMMENT 'The search query or keywords used to discover the knowledge asset, if applicable. Supports Natural Language Processing (NLP)-driven search optimization and taxonomy refinement.',
    `session_code` STRING COMMENT 'Unique identifier for the user session during which the usage event occurred. Enables grouping of multiple usage events within a single work session for behavioral analysis.',
    `source_reference_code` STRING COMMENT 'The unique identifier of the usage event in the source system. Enables traceability back to the originating system for audit and reconciliation purposes.',
    `source_system` STRING COMMENT 'The system or platform from which the usage event was captured. Identifies whether the asset was accessed from Thomson Reuters Practical Law, LexisNexis, document management system (DMS), or other knowledge repository. [ENUM-REF-CANDIDATE: thomson_reuters_practical_law|lexisnexis|imanage_work|netdocuments|elite_3e|relativity|other — 7 candidates stripped; promote to reference product]',
    `time_saved_minutes` STRING COMMENT 'Estimated time saved by using the knowledge asset instead of creating content from scratch, measured in minutes. User-provided or system-calculated estimate. Supports knowledge management Return on Investment (ROI) measurement.',
    `usage_context` STRING COMMENT 'Free-text description of the context in which the knowledge asset was used. Captures the business purpose, matter phase, or specific task for which the asset was accessed. Supports qualitative analysis of knowledge reuse patterns.',
    `usage_status` STRING COMMENT 'The status of the usage event. Completed indicates successful access and use, in_progress indicates an ongoing session, abandoned indicates the user left without completing the action, failed indicates a technical or access error.. Valid values are `completed|in_progress|abandoned|failed`',
    `usage_timestamp` TIMESTAMP COMMENT 'The precise date and time when the knowledge asset was accessed or used. Principal business event timestamp for usage analytics and temporal pattern analysis.',
    `usage_type` STRING COMMENT 'The type of interaction with the knowledge asset. View indicates read-only access, download indicates local copy, adapt indicates modification or customization, cite indicates reference in a document, apply indicates direct use in matter work, link indicates hyperlink or cross-reference.. Valid values are `view|download|adapt|cite|apply|link`',
    CONSTRAINT pk_asset_usage PRIMARY KEY(`asset_usage_id`)
) COMMENT 'Transactional record capturing every instance a knowledge asset is accessed, downloaded, adapted, cited, or linked within a matter or document. Tracks timekeeper, matter reference, asset reference, usage type (view, download, adapt, cite, apply), timestamp, source system, relevance rating, and linking context. Enables usage analytics for knowledge asset curation prioritization, matter-level knowledge reuse tracking, post-matter knowledge harvesting, and ROI measurement of knowledge investments.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`knowledge`.`precedent_update` (
    `precedent_update_id` BIGINT COMMENT 'Unique identifier for the precedent update event. Primary key for this entity.',
    `timekeeper_id` BIGINT COMMENT 'Identifier of the senior lawyer or knowledge management partner responsible for approving the precedent update.',
    `legal_document_id` BIGINT COMMENT 'Foreign key linking to document.legal_document. Business justification: Precedent updates are triggered by new legislation, case law, or regulatory guidance stored as legal_documents in DMS. Tracking the triggering document provides audit trail, enables direct access to s',
    `legal_update_id` BIGINT COMMENT 'Foreign key linking to knowledge.legal_update. Business justification: Precedent updates are triggered by legal developments (legislation changes, case law, regulatory updates). This FK links the precedent review event to the specific legal update that triggered it. One ',
    `precedent_id` BIGINT COMMENT 'Reference to the precedent document or knowledge asset that was updated. Links to the precedent master record in the knowledge management system.',
    `primary_precedent_timekeeper_id` BIGINT COMMENT 'Identifier of the legal professional or knowledge management specialist assigned to review and update the precedent.',
    `regulatory_change_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_change. Business justification: Precedent updates are triggered by regulatory changes. This is the operational link between regulatory monitoring and knowledge maintenance, enabling impact analysis and demonstrating knowledge curren',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Precedent updates are often triggered by risk events (PI claims, regulatory breaches, client complaints). When a risk materializes, firms update precedents to prevent recurrence. This link captures wh',
    `approval_date` DATE COMMENT 'Date when the precedent update was formally approved for publication and use.',
    `approver_name` STRING COMMENT 'Full name of the senior lawyer or knowledge management partner who approved the precedent update.',
    `change_detail` STRING COMMENT 'Detailed description of all changes made to the precedent, including clause-by-clause modifications, rationale for changes, and references to supporting legal authorities.',
    `change_summary` STRING COMMENT 'High-level summary of the changes made to the precedent during this update, including key modifications, additions, or deletions.',
    `comments` STRING COMMENT 'Additional comments, notes, or observations recorded during the precedent update process, including reviewer feedback, approver guidance, or implementation notes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this precedent update record was first created in the system.',
    `effective_date` DATE COMMENT 'Date from which the updated precedent version becomes the current, authoritative version for use in client matters and knowledge management.',
    `impact_assessment` STRING COMMENT 'Assessment of the business impact of this precedent update. High impact indicates significant legal or operational changes requiring immediate attention; medium indicates moderate changes; low indicates minor editorial or technical corrections.. Valid values are `high|medium|low`',
    `jurisdiction` STRING COMMENT 'Legal jurisdiction(s) to which the updated precedent applies, such as England and Wales, New York, Delaware, or multi-jurisdictional.',
    `matter_type` STRING COMMENT 'Type of legal matter for which the precedent is typically used, such as Mergers and Acquisitions (M&A), Share Purchase Agreement (SPA), Non-Disclosure Agreement (NDA), or litigation pleading.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this precedent update record was last modified, supporting audit trail and change tracking.',
    `new_version_number` STRING COMMENT 'Version number assigned to the precedent after this update was applied and approved.',
    `notification_date` DATE COMMENT 'Date when notification of the precedent update was distributed to stakeholders.',
    `notification_method` STRING COMMENT 'Method or channel used to notify stakeholders of the precedent update, such as email, intranet posting, knowledge portal alert, or practice group meeting.. Valid values are `email|intranet|knowledge_portal|practice_group_meeting|all_hands`',
    `notification_sent` BOOLEAN COMMENT 'Indicates whether notification of the precedent update was sent to relevant stakeholders, practice groups, or the broader firm.',
    `practice_area` STRING COMMENT 'Practice area or legal domain to which the precedent belongs, such as Corporate, Litigation, Intellectual Property (IP), Employment, or Regulatory Compliance.',
    `previous_version_number` STRING COMMENT 'Version number of the precedent immediately prior to this update, enabling version history tracking.',
    `publication_date` DATE COMMENT 'Date when the updated precedent was published to the firms document management system (DMS) or knowledge management platform and made available to users.',
    `regulatory_framework` STRING COMMENT 'Regulatory or compliance framework that the precedent addresses, such as General Data Protection Regulation (GDPR), Sarbanes-Oxley Act (SOX), California Consumer Privacy Act (CCPA), or Anti-Money Laundering (AML) regulations.',
    `rejection_date` DATE COMMENT 'Date when the precedent update was rejected during the approval workflow, if applicable.',
    `rejection_reason` STRING COMMENT 'Explanation provided by the approver for rejecting the precedent update, including guidance for remediation.',
    `review_completed_date` DATE COMMENT 'Date when the reviewer completed their review and submitted the updated precedent for approval.',
    `review_initiated_by` STRING COMMENT 'Name or identifier of the person who initiated the precedent review process.',
    `review_initiated_date` DATE COMMENT 'Date when the precedent review process was formally initiated in response to the triggering event.',
    `reviewer_name` STRING COMMENT 'Full name of the legal professional or knowledge management specialist who performed the precedent review and update.',
    `reviewer_practice_area` STRING COMMENT 'Practice area or department of the reviewer, ensuring subject matter expertise alignment with the precedent content.',
    `sections_modified` STRING COMMENT 'List or description of specific sections, clauses, or paragraphs within the precedent that were modified during this update.',
    `source_reference_code` STRING COMMENT 'Unique identifier or reference number for this precedent update event in the source system, enabling traceability and reconciliation.',
    `source_system` STRING COMMENT 'Name of the source system or knowledge management platform where the precedent update was recorded, such as Thomson Reuters Practical Law, iManage Work, or NetDocuments.',
    `superseded_date` DATE COMMENT 'Date when this precedent update was itself superseded by a subsequent update, marking the end of its active lifecycle.',
    `triggering_event` STRING COMMENT 'Description of the event or reason that triggered the need for this precedent update, such as a new statute, landmark case decision, regulatory guidance, or internal quality review finding.',
    `triggering_event_date` DATE COMMENT 'Date when the triggering event occurred (e.g., date of court judgment, date of statute enactment, date of regulatory guidance publication).',
    `triggering_event_type` STRING COMMENT 'Categorical classification of the triggering event that necessitated the precedent update.. Valid values are `legislative_change|case_law_development|regulatory_update|client_feedback|internal_review|market_practice_change`',
    `update_reference_number` STRING COMMENT 'Business-facing reference number or code assigned to this precedent update event for tracking and audit purposes.',
    `update_status` STRING COMMENT 'Current lifecycle status of the precedent update. Tracks the approval workflow from initial draft through review, approval, publication, or rejection.. Valid values are `draft|under_review|approved|published|rejected|superseded`',
    `update_type` STRING COMMENT 'Classification of the type of update performed on the precedent. Major revisions involve substantive legal changes, minor revisions are editorial improvements, technical corrections fix errors, and regulatory/case law/legislative updates reflect external legal developments.. Valid values are `major_revision|minor_revision|technical_correction|regulatory_update|case_law_update|legislative_change`',
    CONSTRAINT pk_precedent_update PRIMARY KEY(`precedent_update_id`)
) COMMENT 'Tracks the lifecycle of precedent review and update events, capturing when a precedent was flagged for review, who reviewed it, what changes were made, the triggering event (legislative change, case law development, regulatory update), approval workflow status, and effective date of the updated version. Supports the firms precedent governance and currency management obligations.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`knowledge`.`contribution` (
    `contribution_id` BIGINT COMMENT 'Unique identifier for the knowledge contribution record. Primary key.',
    `timekeeper_id` BIGINT COMMENT 'Reference to the attorney or staff member who submitted the contribution.',
    `knowledge_asset_id` BIGINT COMMENT 'Reference to the knowledge asset that was contributed (precedent, practice note, research memo, clause library entry, form, checklist).',
    `profile_id` BIGINT COMMENT 'Reference to the client whose work generated the contribution, if applicable.',
    `reviewer_timekeeper_id` BIGINT COMMENT 'Reference to the senior attorney or knowledge manager assigned to review the contribution.',
    `matter_id` BIGINT COMMENT 'Reference to the client matter from which the contribution originated, if applicable.',
    `supersedes_contribution_id` BIGINT COMMENT 'Reference to a prior contribution that this submission replaces or updates.',
    `approval_outcome` STRING COMMENT 'Final decision on whether the contribution was accepted into the firms knowledge base.. Valid values are `approved|rejected|conditional_approval`',
    `cle_credit_eligible` BOOLEAN COMMENT 'Indicates whether the contribution qualifies the contributor for CLE or CPD credit hours.',
    `cle_credit_hours` DECIMAL(18,2) COMMENT 'Number of CLE or CPD credit hours awarded for the contribution, if eligible.',
    `confidentiality_level` STRING COMMENT 'Data classification level governing access to the contribution within the firm.. Valid values are `public|internal|confidential|restricted`',
    `contribution_type` STRING COMMENT 'Type of knowledge asset contributed to the firms knowledge base.. Valid values are `precedent|practice_note|research_memo|clause_variant|form_template|checklist`',
    `contributor_notes` STRING COMMENT 'Notes or context provided by the contributor at the time of submission explaining the contributions purpose and applicability.',
    `cpd_credit_eligible` BOOLEAN COMMENT 'Indicates whether the contribution qualifies the contributor for CPD credit under UK or international standards.',
    `cpd_credit_hours` DECIMAL(18,2) COMMENT 'Number of CPD or CLE credit hours awarded for contributing or completing training on this knowledge asset. Nullable if not CPD-eligible. [Moved from knowledge_asset: CPD credit hours are awarded to individual contributors for their specific contributions, not to the knowledge asset itself. Different contributors receive different credit amounts.]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the contribution record was first created in the system.',
    `document_reference_code` STRING COMMENT 'External reference identifier linking the contribution to the source document in the Document Management System (DMS) such as iManage Work or NetDocuments.',
    `expiration_date` DATE COMMENT 'Date when the contribution is scheduled for review or retirement due to potential obsolescence.',
    `innovation_flag` BOOLEAN COMMENT 'Indicates whether the contribution represents a novel approach, innovative solution, or best practice worthy of special recognition.',
    `is_cpd_eligible` BOOLEAN COMMENT 'Indicates whether contribution or use of this knowledge asset qualifies for CPD or CLE credit hours under applicable bar association requirements. [Moved from knowledge_asset: CPD eligibility may vary by contribution type and individual contributor circumstances, so it belongs to the contribution record rather than the asset itself.]',
    `jurisdiction` STRING COMMENT 'Legal jurisdiction or geographic scope of the contributed knowledge asset.',
    `language_code` STRING COMMENT 'ISO 639-2 three-letter language code of the contribution content.. Valid values are `^[A-Z]{3}$`',
    `last_used_date` DATE COMMENT 'Most recent date when the approved contribution was accessed or reused.',
    `matter_type` STRING COMMENT 'Type of legal matter or transaction to which the contribution is relevant (e.g., M&A, Litigation, Contract Negotiation).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the contribution record was last modified or updated.',
    `practice_area` STRING COMMENT 'Legal practice area to which the contribution applies (e.g., Corporate, Litigation, IP, Employment, Tax).',
    `published_date` DATE COMMENT 'Date when the approved contribution was published and made available in the firms knowledge base.',
    `quality_score` DECIMAL(18,2) COMMENT 'Numerical quality rating assigned by the reviewer (scale 0.00 to 5.00).',
    `rejection_reason` STRING COMMENT 'Explanation provided by the reviewer if the contribution was rejected or revision was requested.',
    `review_assigned_date` DATE COMMENT 'Date when the contribution was assigned to a reviewer.',
    `review_completed_date` DATE COMMENT 'Date when the review process was completed and a decision was made.',
    `review_date` DATE COMMENT 'Date on which the review of this knowledge asset was completed and a decision (approval or rejection) was made. [Moved from knowledge_asset: Review date belongs to each specific review contribution, not to the knowledge asset itself. Multiple reviews occur at different times.]',
    `review_status` STRING COMMENT 'Current status of the contribution in the peer review and approval workflow.. Valid values are `pending|under_review|approved|rejected|revision_requested|withdrawn`',
    `reviewer_comments` STRING COMMENT 'Detailed feedback and comments provided by the reviewer during the review process.',
    `source_reference_code` STRING COMMENT 'Unique identifier of the contribution record in the source system for traceability and reconciliation.',
    `source_system` STRING COMMENT 'Name of the operational system from which the contribution record originated (e.g., Thomson Reuters Practical Law, iManage Work, internal KM portal).',
    `submission_date` DATE COMMENT 'Date when the contribution was submitted for review.',
    `submission_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the contribution was submitted to the knowledge management system.',
    `taxonomy_tags` STRING COMMENT 'Comma-separated list of taxonomy tags or keywords applied to the contribution for Natural Language Processing (NLP) driven retrieval and classification.',
    `usage_count` STRING COMMENT 'Number of times the approved contribution has been accessed or reused by other timekeepers.',
    `version_number` STRING COMMENT 'Version identifier of the contributed asset, supporting iterative improvements and version control.',
    CONSTRAINT pk_contribution PRIMARY KEY(`contribution_id`)
) COMMENT 'Records individual attorney and staff contributions to the firms knowledge base including submission of new precedents, practice notes, research memos, and clause variants for peer review and approval. Captures contributor timekeeper reference, asset type submitted, submission date, review status, reviewer assignment, approval or rejection outcome, and CPD/CLE credit eligibility. Supports Knowledge Management and Precedent Tracking and attorney development programs.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`knowledge`.`research_request` (
    `research_request_id` BIGINT COMMENT 'Unique identifier for the legal research request. Primary key.',
    `external_source_id` BIGINT COMMENT 'Foreign key linking to knowledge.external_source. Business justification: Research requests specify which external platform to use (LexisNexis, Westlaw, Practical Law, etc.). Currently has research_platform STRING which should be FK to external_source master. This enables p',
    `precedent_id` BIGINT COMMENT 'Foreign key linking to knowledge.precedent. Business justification: Research requests often identify relevant firm precedents as research output. Tracking identified precedents enables research effectiveness measurement, precedent discovery analytics, and researcher p',
    `knowledge_asset_id` BIGINT COMMENT 'Reference to the knowledge asset record if the research output was catalogued as a reusable knowledge asset in the firms knowledge management system.',
    `matter_id` BIGINT COMMENT 'Reference to the matter or case for which this research is being conducted. Links the research request to the client matter context.',
    `timekeeper_id` BIGINT COMMENT 'Identifier of the research professional or librarian assigned to fulfill this request.',
    `research_memo_id` BIGINT COMMENT 'FK to knowledge.research_memo.research_memo_id — A research request produces a research memo as its deliverable. This FK links the request to its output for workflow completion tracking.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Research requests often seek guidance on specific regulatory obligations for client matters. This link enables compliance advisory workflow tracking and supports knowledge gap analysis for regulatory ',
    `resulting_research_memo_id` BIGINT COMMENT 'FK to knowledge.research_memo.research_memo_id — Research requests produce research memos as deliverables. This FK links the request to its output for workflow completion tracking.',
    `reviewer_timekeeper_id` BIGINT COMMENT 'Identifier of the senior researcher or attorney who conducted quality review of the research output, if applicable.',
    `actual_hours` DECIMAL(18,2) COMMENT 'Actual number of hours spent completing the research request, tracked for billing and productivity analysis.',
    `assigned_date` DATE COMMENT 'Date when the research request was assigned to a researcher or research team.',
    `client_billable_flag` BOOLEAN COMMENT 'Indicates whether the research time and costs are billable to the client or absorbed as internal overhead.',
    `completed_date` DATE COMMENT 'Date when the research request was completed and delivered to the requesting attorney.',
    `confidentiality_level` STRING COMMENT 'Data classification level of the research request and its results, governing access and handling requirements.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this research request record was first created in the system.',
    `due_date` DATE COMMENT 'Deadline by which the research results must be delivered to the requesting attorney.',
    `estimated_hours` DECIMAL(18,2) COMMENT 'Estimated number of hours required to complete the research request, used for resource planning and billing.',
    `jurisdiction` STRING COMMENT 'Legal jurisdiction(s) relevant to the research question (e.g., federal, state, country, or multi-jurisdictional).',
    `key_terms` STRING COMMENT 'Comma-separated list of key legal terms, concepts, or search terms relevant to the research question, used for indexing and retrieval.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this research request record was last modified or updated.',
    `practice_area` STRING COMMENT 'Primary practice area or legal domain to which this research request pertains.. Valid values are `corporate|litigation|intellectual_property|employment|regulatory_compliance|real_estate`',
    `quality_review_flag` BOOLEAN COMMENT 'Indicates whether the research output underwent a formal quality review or peer review process before delivery.',
    `related_case_law` STRING COMMENT 'References to relevant case law or precedents identified during the research process.',
    `related_statutes` STRING COMMENT 'References to relevant statutes, regulations, or legislative provisions identified during the research process.',
    `request_number` STRING COMMENT 'Business-facing unique identifier or tracking number for the research request, used for reference and communication.',
    `request_status` STRING COMMENT 'Current lifecycle status of the research request, tracking its progress from submission to completion.. Valid values are `submitted|assigned|in_progress|completed|cancelled|on_hold`',
    `request_title` STRING COMMENT 'Brief title or subject line summarizing the research request topic.',
    `request_type` STRING COMMENT 'Classification of the type of legal research being requested (e.g., case law analysis, statutory interpretation, regulatory guidance).. Valid values are `case_law|statutory|regulatory|transactional|comparative|memorandum`',
    `requested_date` DATE COMMENT 'Date when the research request was submitted by the requesting attorney.',
    `requesting_department` STRING COMMENT 'Department or practice group of the requesting attorney, used for cost allocation and workload analysis.',
    `research_notes` STRING COMMENT 'Internal notes or comments from the researcher regarding the research process, findings, or challenges encountered.',
    `research_question` STRING COMMENT 'Detailed description of the legal research question or issue to be investigated. May contain confidential matter details.',
    `research_scope` STRING COMMENT 'Detailed description of the scope and boundaries of the research to be conducted, including any specific sources, time periods, or constraints.',
    `review_date` DATE COMMENT 'Date when the quality review of the research output was completed.',
    `source_reference_code` STRING COMMENT 'Unique identifier of this research request in the source operational system, used for traceability and reconciliation.',
    `source_system` STRING COMMENT 'Name of the operational system from which this research request record originated (e.g., Thomson Reuters Practical Law, internal research portal).',
    `urgency_level` STRING COMMENT 'Priority or urgency classification of the research request, indicating how quickly the research is needed.. Valid values are `routine|standard|urgent|critical`',
    CONSTRAINT pk_research_request PRIMARY KEY(`research_request_id`)
) COMMENT 'Formal legal research requests submitted by attorneys or clients to the research services team or library. Captures requesting attorney, matter reference, research question, jurisdiction, urgency level, assigned researcher, LexisNexis or Practical Law platform used, delivery deadline, completion status, and resulting research memo reference. Supports Legal Research and Analysis and Matter Management processes.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`knowledge`.`external_source` (
    `external_source_id` BIGINT COMMENT 'Unique identifier for the external knowledge source. Primary key.',
    `practice_area_id` BIGINT COMMENT 'Foreign key to service.practice_area.practice_area_id',
    `access_url` STRING COMMENT 'Primary web URL used by firm personnel to access the external source platform.',
    `annual_cost` DECIMAL(18,2) COMMENT 'Total annual subscription cost for this external source in the firms base currency. Used for cost center allocation and vendor spend analysis.',
    `api_endpoint_url` STRING COMMENT 'Base URL for the external sources API endpoint used for programmatic access and data retrieval.',
    `api_integration_status` STRING COMMENT 'Status of technical integration between the firms knowledge management system and the external sources API.. Valid values are `integrated|not_integrated|in_progress|deprecated|planned`',
    `authentication_method` STRING COMMENT 'Method used to authenticate access to the external source (OAuth, API Key, SAML Single Sign-On, Basic Authentication, Certificate-based, or None for public sources).. Valid values are `oauth|api_key|saml|basic_auth|certificate|none`',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the subscription is configured to renew automatically upon expiration.',
    `compliance_review_date` DATE COMMENT 'Date when the external source was last reviewed for compliance with firm policies, data protection regulations (GDPR, CCPA), and ethical guidelines.',
    `content_categories` STRING COMMENT 'Comma-separated list of content types or practice areas covered by the source (e.g., Case Law, Statutes, Secondary Sources, Corporate, Litigation, IP, Employment).',
    `contract_end_date` DATE COMMENT 'Date when the current subscription contract or license agreement expires. Null for perpetual licenses.',
    `contract_start_date` DATE COMMENT 'Date when the subscription contract or license agreement became effective.',
    `cost_centre_code` STRING COMMENT 'Internal cost center or department code to which the subscription expense is allocated for financial reporting and budgeting.',
    `coverage_jurisdictions` STRING COMMENT 'Comma-separated list of jurisdictions or countries covered by this external source (e.g., USA, GBR, CAN, AUS). Uses ISO 3166-1 alpha-3 country codes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this external source record was first created in the knowledge management system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the annual cost (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `data_classification_level` STRING COMMENT 'Highest data classification level of content accessible through this external source, governing access controls and usage policies.. Valid values are `public|internal|confidential|restricted`',
    `external_source_description` STRING COMMENT 'Detailed description of the external sources purpose, content scope, and primary use cases within the firms knowledge management ecosystem.',
    `gdpr_compliant_flag` BOOLEAN COMMENT 'Indicates whether the external source vendor has been verified as compliant with GDPR requirements for data processing and privacy.',
    `last_usage_audit_date` DATE COMMENT 'Date when usage statistics for this external source were last reviewed or audited by the knowledge management team.',
    `licensed_user_count` STRING COMMENT 'Number of concurrent or named user licenses purchased under the current subscription agreement.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this external source record was last modified or updated.',
    `next_compliance_review_date` DATE COMMENT 'Scheduled date for the next compliance review of this external source.',
    `primary_contact_email` STRING COMMENT 'Email address of the internal primary contact responsible for this external source.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Name of the internal firm contact or knowledge manager responsible for managing the relationship with this external source.',
    `renewal_date` DATE COMMENT 'Scheduled date for contract renewal or subscription extension. Used for vendor management and budget planning.',
    `sla_uptime_percentage` DECIMAL(18,2) COMMENT 'Contractually guaranteed uptime percentage for the external source platform as specified in the service level agreement (e.g., 99.9%).',
    `source_code` STRING COMMENT 'Short alphanumeric code or abbreviation used internally to reference the external source (e.g., LEXIS, TRPL, WLAW, PACER).',
    `source_name` STRING COMMENT 'Official name of the external knowledge platform or database (e.g., LexisNexis, Thomson Reuters Practical Law, Westlaw, PACER, Bloomberg Law, ICC, LCIA).',
    `source_reference_code` STRING COMMENT 'Unique identifier for this external source record in the originating source system, used for data lineage and reconciliation.',
    `source_system` STRING COMMENT 'Name of the internal system or platform from which this external source registry record originates (e.g., Thomson Reuters Practical Law, iManage Work, internal vendor management system).',
    `source_type` STRING COMMENT 'Classification of the external source by its primary function: legal research platform, practice management tool, court records system, arbitration body, regulatory database, news service, or business intelligence provider. [ENUM-REF-CANDIDATE: legal_research|practice_management|court_records|arbitration|regulatory|news|business_intelligence — 7 candidates stripped; promote to reference product]',
    `subscription_status` STRING COMMENT 'Current lifecycle status of the subscription to this external source.. Valid values are `active|suspended|expired|trial|pending_renewal|cancelled`',
    `subscription_tier` STRING COMMENT 'Level or tier of subscription purchased (e.g., Basic, Professional, Enterprise, Premium). Determines feature access and user limits.',
    `usage_notes` STRING COMMENT 'Internal notes or guidance for firm personnel on best practices, limitations, or special considerations when using this external source.',
    `usage_tracking_enabled` BOOLEAN COMMENT 'Indicates whether the firm tracks usage metrics and analytics for this external source to measure return on investment and user adoption.',
    `vendor_account_manager` STRING COMMENT 'Name of the account manager or sales representative at the vendor organization assigned to the firms account.',
    `vendor_name` STRING COMMENT 'Name of the vendor or provider organization that operates the external source (e.g., LexisNexis, Thomson Reuters, Bloomberg).',
    `vendor_support_email` STRING COMMENT 'Email address for technical support or customer service inquiries to the vendor.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `vendor_support_phone` STRING COMMENT 'Phone number for technical support or customer service inquiries to the vendor.',
    CONSTRAINT pk_external_source PRIMARY KEY(`external_source_id`)
) COMMENT 'Master registry of external knowledge platforms, databases, and subscription services integrated into the firms knowledge ecosystem. Captures source name (LexisNexis, Thomson Reuters Practical Law, Westlaw, PACER, ICC, LCIA), source type, subscription tier, coverage jurisdictions, content categories, API integration status, contract renewal date, and cost centre allocation. Supports knowledge sourcing governance and vendor management.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`knowledge`.`legal_update` (
    `legal_update_id` BIGINT COMMENT 'Unique identifier for the legal update record. Primary key.',
    `timekeeper_id` BIGINT COMMENT 'Foreign key linking to workforce.timekeeper. Business justification: Legal updates require explicit timekeeper assignment for regulatory change monitoring and precedent update workflows. Normalizes assigned_knowledge_manager text field to enable workload tracking, CPD ',
    `external_source_id` BIGINT COMMENT 'Foreign key linking to knowledge.external_source. Business justification: Legal updates often originate from external knowledge platforms (LexisNexis, Thomson Reuters Practical Law, etc.). Tracking the source platform enables usage analytics, subscription ROI analysis, and ',
    `knowledge_asset_id` BIGINT COMMENT 'Reference to the parent knowledge asset container that this legal update belongs to, enabling grouping of updates under a common knowledge management structure.',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Legal updates impact specific practice areas and trigger precedent reviews and client alerts. Used in regulatory monitoring and knowledge maintenance workflows. Normalizes practice_area text field to ',
    `precedent_id` BIGINT COMMENT 'FK to knowledge.precedent.precedent_id — Legal updates trigger precedent reviews. The link from a legal development to the precedents it impacts is critical for currency management - the core KM governance obligation.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Legal/regulatory updates trigger risk identification and register updates. When new legislation or case law emerges, risk managers create or update risk register entries. This link enables tracking wh',
    `regulatory_change_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_change. Business justification: Legal updates document regulatory changes for knowledge base users. This link connects regulatory intelligence to knowledge dissemination, enabling impact tracking and supporting compliance change man',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Legal updates (new regulations, case law changes) often relate to specific regulatory obligations that the firm must comply with. This FK links the knowledge asset to the affected regulatory obligatio',
    `taxonomy_id` BIGINT COMMENT 'Foreign key linking to knowledge.knowledge_taxonomy. Business justification: Legal updates should be classified in the knowledge taxonomy for governance and retrieval. Currently has taxonomy_tags STRING for multi-valued tags, but needs FK for primary classification. One legal ',
    `access_level` STRING COMMENT 'The information security classification governing who within the firm may access this legal update, reflecting sensitivity and client confidentiality considerations.. Valid values are `public|internal|confidential|restricted`',
    `client_notification_required` BOOLEAN COMMENT 'Indicates whether this legal update is material enough to warrant proactive client notification or advisory communication, triggering business development and client relationship management workflows.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this legal update record was first created in the knowledge management system, supporting audit trails and data lineage tracking.',
    `effective_date` DATE COMMENT 'The date on which the legal change becomes effective and enforceable, triggering the need for knowledge asset updates and client advisories.',
    `impact_assessment` STRING COMMENT 'A detailed analysis of the business and legal impact of this update on the firms knowledge assets, client matters, and practice operations, including risk exposure and opportunity identification.',
    `impacted_checklists` STRING COMMENT 'A comma-separated list or structured reference to the procedural checklists or workflow templates that require modification to incorporate this legal update.',
    `impacted_practice_notes` STRING COMMENT 'A comma-separated list or structured reference to the practice notes, guidance documents, or internal memoranda that require revision to reflect this legal update.',
    `impacted_precedents` STRING COMMENT 'A comma-separated list or structured reference to the precedent documents, standard forms, or template agreements that require review or amendment as a result of this legal update.',
    `jurisdiction` STRING COMMENT 'The legal jurisdiction or geographic territory to which this legal update applies, using three-letter ISO country codes or jurisdiction-specific identifiers (e.g., USA, GBR, EUR for EU-wide, or state/province codes).',
    `keywords` STRING COMMENT 'A comma-separated list of searchable keywords and taxonomy tags that facilitate Natural Language Processing (NLP)-driven retrieval and categorization of this legal update within the knowledge management system.',
    `language_code` STRING COMMENT 'The ISO 639-1 two-letter language code indicating the primary language in which this legal update is documented and published.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this legal update record was last modified or updated, enabling change tracking and version control within the knowledge management system.',
    `multi_jurisdiction_flag` BOOLEAN COMMENT 'Indicates whether this legal update applies to multiple jurisdictions simultaneously, requiring coordinated review across practice areas.',
    `notification_sent_date` DATE COMMENT 'The date on which client notifications or advisory communications regarding this legal update were distributed, supporting audit trails for client service and risk management.',
    `publication_date` DATE COMMENT 'The date on which the legal update was officially published or announced by the legislative, regulatory, or judicial body.',
    `regulatory_framework` STRING COMMENT 'The overarching regulatory or compliance framework to which this legal update relates, such as General Data Protection Regulation (GDPR), Sarbanes-Oxley Act (SOX), Anti-Money Laundering (AML), or industry-specific regulations.',
    `related_matters` STRING COMMENT 'A comma-separated list or structured reference to active client matters that may be affected by this legal update, enabling proactive matter management and client advisory.',
    `review_completion_date` DATE COMMENT 'The date on which the knowledge management review was completed and all necessary knowledge asset updates were finalized and published.',
    `review_priority` STRING COMMENT 'The urgency level assigned to this legal update review, reflecting the materiality of the change and the time sensitivity of required knowledge asset updates.. Valid values are `critical|high|medium|low`',
    `review_start_date` DATE COMMENT 'The date on which the knowledge management team commenced formal review of this legal update and its implications for the firms knowledge assets.',
    `review_status` STRING COMMENT 'The current workflow status of the legal update review process, tracking progression from initial identification through knowledge asset revision and publication.. Valid values are `pending|in_review|approved|published|archived`',
    `source_citation` STRING COMMENT 'The full bibliographic citation or reference to the original source document, including case name, statute number, regulation identifier, or publication reference for traceability and verification.',
    `source_reference_code` STRING COMMENT 'The unique identifier or reference number assigned to this legal update in the originating source system, enabling traceability and reconciliation across platforms.',
    `source_system` STRING COMMENT 'The operational system or platform from which this legal update record was ingested, such as Thomson Reuters Practical Law, LexisNexis, or the firms internal knowledge management system.',
    `source_type` STRING COMMENT 'The category of source from which this legal update was identified, such as LexisNexis, Thomson Reuters Practical Law, official government gazette, court registry, regulatory agency publication, or industry-specific legal publication.. Valid values are `lexisnexis|practical_law|official_gazette|court_registry|regulatory_agency|industry_publication`',
    `source_url` STRING COMMENT 'The web address or hyperlink to the original source document or official publication where the legal update can be accessed for detailed review.',
    `summary` STRING COMMENT 'A concise executive summary of the legal development, highlighting the key changes, implications, and action items for the firms knowledge assets and client advisory services.',
    `target_completion_date` DATE COMMENT 'The planned or deadline date by which the knowledge asset updates triggered by this legal update should be completed, often driven by the effective date of the legal change.',
    `taxonomy_tags` STRING COMMENT 'Structured metadata tags aligned with the firms knowledge taxonomy, enabling hierarchical classification and cross-referencing of this legal update across practice areas, industries, and legal topics.',
    `to_taxonomy` BIGINT COMMENT 'FK to knowledge.knowledge_taxonomy.knowledge_taxonomy_id — Legal updates must reference impacted taxonomy nodes (practice areas, jurisdictions) to enable automated identification of affected knowledge assets.',
    `update_number` STRING COMMENT 'The business identifier or reference number assigned to this legal update for tracking and citation purposes within the firms knowledge management system.',
    `update_title` STRING COMMENT 'The descriptive title or headline of the legal update, summarizing the legislative, regulatory, or case law development.',
    `update_to_taxonomy` BIGINT COMMENT 'FK to knowledge.knowledge_taxonomy.knowledge_taxonomy_id — Legal updates must reference taxonomy nodes (practice area, jurisdiction) to enable automated routing to impacted knowledge assets and responsible knowledge managers.',
    `update_type` STRING COMMENT 'The category of legal development that triggered this update, distinguishing between statutory amendments, new regulations, landmark court judgments, regulatory guidance, case law developments, and legislative changes.. Valid values are `statute_amendment|new_regulation|landmark_judgment|regulatory_guidance|case_law_development|legislative_change`',
    CONSTRAINT pk_legal_update PRIMARY KEY(`legal_update_id`)
) COMMENT 'Tracks legislative, regulatory, and case law developments that trigger review or amendment of the firms knowledge assets. Captures update type (statute amendment, new regulation, landmark judgment, regulatory guidance), jurisdiction, effective date, impacted practice areas, source citation (LexisNexis, Practical Law, official gazette), assigned knowledge manager, review status, and linked precedents or practice notes requiring update. Supports proactive knowledge currency management.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`knowledge`.`impact_assessment` (
    `impact_assessment_id` BIGINT COMMENT 'Unique identifier for this impact assessment record. Primary key.',
    `timekeeper_id` BIGINT COMMENT 'Foreign key to workforce.timekeeper.timekeeper_id',
    `legal_update_id` BIGINT COMMENT 'Foreign key linking to the legal update triggering the impact assessment',
    `practice_area_id` BIGINT COMMENT 'Foreign key to service.practice_area.practice_area_id',
    `practice_note_id` BIGINT COMMENT 'Foreign key linking to the practice note being assessed for impact',
    `action_taken` STRING COMMENT 'The specific remediation action taken on this practice note in response to this legal update.',
    `assigned_knowledge_manager` STRING COMMENT 'The name or identifier of the knowledge manager assigned to review and update this specific practice note in response to this legal update.',
    `content_sections_modified` STRING COMMENT 'A comma-separated list or structured reference to the specific sections, paragraphs, or content blocks within the practice note that were modified as a result of this legal update.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this impact assessment record was created in the system.',
    `impact_assessment_text` STRING COMMENT 'A detailed analysis of how this specific legal update impacts this specific practice note, including the nature and extent of changes required.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this impact assessment record was last modified.',
    `review_completion_date` DATE COMMENT 'The date on which the review of this specific practice note was completed and all necessary updates were finalized in response to this legal update.',
    `review_priority` STRING COMMENT 'The urgency level assigned to this specific practice note review in response to the legal update, reflecting the materiality of impact on this particular practice note.',
    `review_start_date` DATE COMMENT 'The date on which the knowledge management team commenced review of this specific practice note in response to this legal update.',
    `review_status` STRING COMMENT 'The current workflow status of this specific practice note impact assessment, tracking progression through the knowledge management review process.',
    CONSTRAINT pk_impact_assessment PRIMARY KEY(`impact_assessment_id`)
) COMMENT 'This association product represents the impact assessment workflow between legal_update and practice_note. It captures the knowledge management process of evaluating and tracking how legislative, regulatory, and case law developments affect specific practice notes. Each record links one legal_update to one practice_note with workflow attributes that exist only in the context of this impact relationship, including review priority, status tracking, and action documentation.. Existence Justification: In legal knowledge management operations, a single legal update (statute amendment, new regulation, landmark judgment) routinely impacts multiple practice notes across different practice areas and jurisdictions, and conversely, a single practice note may require review and amendment in response to multiple legal developments over time. The firm actively manages this many-to-many relationship through a formal impact assessment workflow where knowledge managers evaluate each legal_update-practice_note pair, assign review priorities, track review status, document specific actions taken, and record which content sections were modified.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`knowledge`.`precedent_impact_assessment` (
    `precedent_impact_assessment_id` BIGINT COMMENT 'Unique identifier for this precedent impact assessment record. Primary key.',
    `legal_update_id` BIGINT COMMENT 'Foreign key linking to the legal update (legislative, regulatory, or case law development) that triggered the precedent review.',
    `precedent_id` BIGINT COMMENT 'Foreign key linking to the precedent document that is impacted by the legal update and requires review or amendment.',
    `action_taken` STRING COMMENT 'The specific remediation action taken by the knowledge team in response to the legal update, documenting whether the precedent was amended, retired, or determined to require no changes.',
    `assigned_knowledge_manager` STRING COMMENT 'The name or identifier of the knowledge manager responsible for conducting this impact assessment and implementing any required precedent amendments.',
    `created_timestamp` TIMESTAMP COMMENT 'The system timestamp when this impact assessment record was initially created, typically when the legal update was first identified as potentially affecting this precedent.',
    `impact_assessment` STRING COMMENT 'The knowledge managers evaluation of the severity and materiality of the legal updates impact on this specific precedent document. Determines the urgency and scope of required amendments.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The system timestamp of the most recent update to this impact assessment record, tracking workflow progression and status changes.',
    `review_completion_date` DATE COMMENT 'The date on which the knowledge management review was completed and all necessary amendments to the precedent were finalized and approved.',
    `review_priority` STRING COMMENT 'The urgency level assigned to this precedent review task, reflecting the materiality of the legal change and business risk of using an outdated precedent.',
    `review_start_date` DATE COMMENT 'The date on which the knowledge management team commenced formal review of this precedent in response to the legal update.',
    `review_status` STRING COMMENT 'The current workflow status of this precedent impact assessment, tracking progression from initial identification through knowledge manager review to completion or archival.',
    `reviewer_notes` STRING COMMENT 'Free-text notes and commentary from the knowledge manager documenting their analysis, rationale for actions taken, and any considerations for future reviews.',
    `sections_modified` STRING COMMENT 'A comma-separated list or structured reference to the specific sections, clauses, or provisions within the precedent document that were modified as a result of this legal update.',
    CONSTRAINT pk_precedent_impact_assessment PRIMARY KEY(`precedent_impact_assessment_id`)
) COMMENT 'This association product represents the impact assessment and review workflow triggered when a legal update (legislative change, regulatory amendment, or case law development) affects one or more precedent documents. It captures the knowledge management teams evaluation of each precedent-update pair, including impact severity, review priority, workflow status, actions taken, and completion tracking. Each record links one precedent to one legal update with attributes that exist only in the context of this specific impact relationship.. Existence Justification: In legal knowledge management operations, a single legal update (legislative change, new regulation, or case law development) routinely impacts multiple precedent documents across different practice areas, and conversely, a single precedent document is impacted by multiple legal updates over its lifecycle. The knowledge management team actively manages each precedent-update pair through a formal impact assessment workflow with distinct status tracking, priority assignment, and remediation actions.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`knowledge`.`control_mapping` (
    `control_mapping_id` BIGINT COMMENT 'Unique surrogate identifier for each control mapping record in the knowledge-risk control matrix',
    `category_id` BIGINT COMMENT 'Foreign key linking to the risk category being mitigated or controlled by the associated knowledge asset',
    `knowledge_asset_id` BIGINT COMMENT 'Foreign key linking to the knowledge asset serving as a control or mitigation for the associated risk category',
    `timekeeper_id` BIGINT COMMENT 'Reference to the risk owner, compliance officer, or knowledge professional who established this control mapping',
    `applicability_scope` STRING COMMENT 'Defines the organizational or operational scope within which this knowledge asset serves as a control for the risk category (e.g., firm-wide DPA template vs. jurisdiction-specific conflicts checklist)',
    `control_mapping_status` STRING COMMENT 'Current lifecycle status of this control mapping within the risk management framework. Active mappings contribute to residual risk calculations; deprecated mappings indicate control gaps requiring remediation.',
    `control_type` STRING COMMENT 'Classification of the control mechanism provided by this knowledge asset in relation to the risk category (e.g., conflicts checklist is preventive, breach response playbook is corrective)',
    `deployment_frequency` STRING COMMENT 'Frequency with which this knowledge asset is deployed or applied as a control measure for the risk category (e.g., conflicts checklist deployed per-matter, AML policy reviewed annually)',
    `effectiveness_rating` STRING COMMENT 'Assessment of how effectively this knowledge asset mitigates the associated risk category, based on incident history, audit findings, and risk owner evaluation. Used in residual risk scoring and control gap analysis.',
    `last_deployment_date` DATE COMMENT 'Most recent date on which this knowledge asset was actively deployed or applied as a control for the risk category, used to monitor control currency and identify dormant controls',
    `last_effectiveness_review_date` DATE COMMENT 'Date on which the effectiveness rating of this control mapping was most recently assessed or validated by the risk owner or auditor',
    `mapped_date` DATE COMMENT 'Date on which this knowledge asset was formally mapped to the risk category in the control matrix, establishing the control relationship',
    `next_effectiveness_review_date` DATE COMMENT 'Scheduled date for the next formal review of this control mappings effectiveness, driven by the risk categorys review frequency and regulatory requirements',
    `notes` STRING COMMENT 'Free-text notes documenting the rationale for this control mapping, limitations, dependencies, or special deployment instructions',
    `regulatory_mapping_reference` STRING COMMENT 'Reference to the specific regulatory requirement, ISO 27001 control, or professional indemnity condition that this control mapping satisfies (e.g., ISO 27001 A.18.1.4, SRA Code para 6.3)',
    CONSTRAINT pk_control_mapping PRIMARY KEY(`control_mapping_id`)
) COMMENT 'This association product represents the control relationship between knowledge assets and risk categories in the firms integrated risk management and knowledge governance framework. It captures which knowledge assets (precedents, templates, checklists, practice notes) serve as controls or mitigations for specific risk categories (professional indemnity, data privacy, conflicts, AML). Each record links one knowledge asset to one risk category with attributes that document control effectiveness, deployment patterns, and compliance mapping required for ISO 27001, professional indemnity audits, and regulatory risk reporting.. Existence Justification: In legal risk management, a single knowledge asset (e.g., conflicts of interest checklist) serves as a control for multiple risk categories (conflict of interest risk, reputational risk, regulatory breach risk), and conversely, a single risk category (e.g., data breach risk) is mitigated by multiple knowledge assets (data processing agreement template, data retention checklist, breach response playbook, encryption policy). Risk managers actively maintain a control matrix mapping which assets control which risks, with effectiveness ratings, deployment patterns, and compliance references required for ISO 27001 certification and professional indemnity audits.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`knowledge`.`precedent_risk_mitigation` (
    `precedent_risk_mitigation_id` BIGINT COMMENT 'Unique surrogate identifier for each precedent-risk mitigation mapping record. Primary key for the association.',
    `precedent_id` BIGINT COMMENT 'Foreign key linking to the precedent document that provides risk mitigation through its clauses, terms, or structure',
    `category_id` BIGINT COMMENT 'Foreign key linking to the risk category that this precedent is designed to mitigate or control',
    `clause_coverage_percentage` DECIMAL(18,2) COMMENT 'Percentage of the precedent documents clauses that directly address or mitigate the associated risk category. Calculated during precedent review and used to assess comprehensiveness of risk coverage.',
    `key_mitigating_clauses` STRING COMMENT 'Comma-separated list or narrative description of the specific clauses, sections, or provisions within the precedent document that directly mitigate the associated risk category. Used for clause-level risk analysis.',
    `last_risk_review_date` DATE COMMENT 'Date on which the risk mitigation effectiveness of this precedent-risk mapping was most recently reviewed and validated by the knowledge management or risk team. Drives review cycle governance.',
    `mapped_by` STRING COMMENT 'Name or identifier of the knowledge manager, risk officer, or attorney who created or last validated this precedent-risk mitigation mapping. Supports audit and accountability.',
    `mapped_date` DATE COMMENT 'Date on which this precedent-risk mitigation mapping was originally created in the knowledge management system.',
    `mapping_status` STRING COMMENT 'Lifecycle status of this precedent-risk mitigation mapping. Active mappings are used in matter risk profiling; Deprecated or Superseded mappings indicate the precedent no longer adequately addresses the risk.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal review of this precedent-risk mitigation mapping to ensure continued relevance and effectiveness.',
    `notes` STRING COMMENT 'Free-text notes providing additional context about this precedent-risk mitigation relationship, including usage guidance, limitations, or special considerations for attorneys.',
    `risk_mitigation_effectiveness` STRING COMMENT 'Qualitative assessment of how effectively this precedent document mitigates the associated risk category, as determined by risk and knowledge management review. Used in precedent selection and matter risk profiling.',
    `risk_rating_when_used` STRING COMMENT 'The typical risk severity rating (Critical, High, Medium, Low) of the associated risk category in matters where this precedent is deployed. Contextualizes the precedents role in high-stakes vs. routine risk scenarios.',
    `usage_in_risk_context_count` BIGINT COMMENT 'Number of times this precedent has been selected or used in matters where the associated risk category was flagged as relevant. Tracks operational usage patterns for precedent effectiveness analysis.',
    CONSTRAINT pk_precedent_risk_mitigation PRIMARY KEY(`precedent_risk_mitigation_id`)
) COMMENT 'This association product represents the risk mitigation relationship between precedent documents and risk categories. It captures which precedent documents (templates, clauses, agreements) are designed to mitigate which specific risk categories, along with the effectiveness of that mitigation, clause coverage metrics, and usage tracking. Each record links one precedent to one risk category with attributes that exist only in the context of this mitigation relationship. This mapping is actively used in matter risk profiling workflows, precedent approval processes, and knowledge management governance to ensure precedents adequately address firm risk exposure.. Existence Justification: In legal services firms, precedent documents (templates, agreements, clauses) are explicitly designed to mitigate multiple risk categories (e.g., a SaaS agreement addresses IP infringement, data breach, and payment default risks), and each risk category is addressed by multiple precedents (e.g., data breach risk is mitigated by DPAs, SaaS agreements, and vendor contracts). Knowledge management teams actively maintain precedent-risk mappings with effectiveness ratings, clause coverage metrics, and usage tracking to support matter risk profiling and precedent approval workflows. This is an operational relationship managed as part of knowledge governance, not an analytical correlation.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`knowledge`.`precedent` (
    `precedent_id` BIGINT COMMENT 'Unique identifier for the precedent document. Primary key for the precedent repository.',
    `parent_precedent_id` BIGINT COMMENT 'Foreign key reference to the previous version of this precedent, establishing version lineage and amendment history.',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Precedents are organized by practice area for retrieval during matter staffing and service delivery. Attorneys search precedent libraries by practice area when preparing client deliverables. Normalize',
    `knowledge_asset_id` BIGINT COMMENT 'Foreign key reference to the parent knowledge asset for unified cross-asset catalog governance.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Legal precedents must track which regulatory obligations they satisfy for compliance reporting, matter risk assessment, and regulatory audit trails. Essential for demonstrating compliance coverage acr',
    `legal_document_id` BIGINT COMMENT 'The unique identifier of this document in the source system (e.g., iManage document ID, Practical Law resource ID).',
    `taxonomy_id` BIGINT COMMENT 'Foreign key linking to knowledge.knowledge_taxonomy. Business justification: Precedents should be classified in the knowledge taxonomy for governance and retrieval. Currently has keywords STRING for multi-valued tags, but needs FK for primary classification. One precedent has ',
    `to_knowledge_asset_id` BIGINT COMMENT 'FK to knowledge.knowledge_asset.knowledge_asset_id — Every precedent must have a corresponding knowledge_asset catalog entry for cross-asset search, access classification, and lifecycle governance. This is the core catalog-detail FK that implements the ',
    `access_restriction` STRING COMMENT 'Specific access control rules or restrictions limiting which practice groups, offices, or individuals may use this precedent.',
    `amendment_summary` STRING COMMENT 'A summary of the changes, updates, or amendments made in this version compared to the previous version.',
    `approval_date` DATE COMMENT 'The date on which this precedent version was formally approved for use by the designated reviewer or knowledge committee.',
    `approval_status` STRING COMMENT 'The current approval and lifecycle status of the precedent document within the knowledge management workflow.. Valid values are `draft|under_review|approved|archived|deprecated|withdrawn`',
    `author_name` STRING COMMENT 'The name of the attorney or knowledge professional who originally authored or curated this precedent.',
    `author_practice_group` STRING COMMENT 'The practice group or department of the original author at the time of creation.',
    `confidentiality_level` STRING COMMENT 'The data classification level governing access and distribution of this precedent within and outside the firm.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this precedent record was first created in the knowledge repository.',
    `document_number` STRING COMMENT 'The unique business identifier or reference number assigned to this precedent document for external citation and retrieval.',
    `document_title` STRING COMMENT 'The official title or name of the precedent document as it appears in the knowledge repository.',
    `document_type` STRING COMMENT 'The classification of the precedent document by its legal function and format. [ENUM-REF-CANDIDATE: agreement|memorandum|letter|notice|pleading|contract|template|form|checklist|clause_library — 10 candidates stripped; promote to reference product]',
    `effective_date` DATE COMMENT 'The date on which this version of the precedent became effective and available for use by the firm.',
    `expiry_date` DATE COMMENT 'The date on which this precedent version is scheduled to expire or be reviewed for currency, nullable for evergreen documents.',
    `file_format` STRING COMMENT 'The digital file format in which this precedent document is stored and distributed.. Valid values are `docx|pdf|doc|rtf|txt|html`',
    `file_size_kb` DECIMAL(18,2) COMMENT 'The size of the precedent document file in kilobytes for storage and retrieval management.',
    `jurisdiction` STRING COMMENT 'The primary legal jurisdiction or governing law for which this precedent is designed (e.g., New York, Delaware, England and Wales, Ontario).',
    `key_clauses` STRING COMMENT 'A summary or list of the critical legal clauses, provisions, or sections contained in this precedent document.',
    `keywords` STRING COMMENT 'A comma-separated list of keywords and tags for search, discovery, and taxonomy classification of this precedent.',
    `language` STRING COMMENT 'The primary language in which this precedent document is written, using ISO 639-1 two-letter language codes.',
    `last_review_date` DATE COMMENT 'The most recent date on which this precedent was formally reviewed for accuracy, currency, and compliance.',
    `last_used_date` DATE COMMENT 'The most recent date on which this precedent was accessed or used by an attorney in a client matter.',
    `lpp_flag` BOOLEAN COMMENT 'Indicates whether this precedent document is subject to legal professional privilege and requires special handling for confidentiality.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this precedent record was last modified or updated in the knowledge repository.',
    `multi_jurisdiction_flag` BOOLEAN COMMENT 'Indicates whether this precedent is applicable across multiple jurisdictions or is jurisdiction-agnostic.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next formal review of this precedent to ensure ongoing relevance and compliance.',
    `page_count` STRING COMMENT 'The total number of pages in the precedent document for reference and complexity assessment.',
    `precedent_description` STRING COMMENT 'A detailed narrative description of the precedent document, its purpose, scope, and recommended use cases.',
    `related_case_law` STRING COMMENT 'Citations to key judicial decisions, precedents, or case law that inform or support the legal positions in this document.',
    `related_legislation` STRING COMMENT 'References to statutes, regulations, or legislative frameworks that are relevant to or govern the use of this precedent.',
    `reviewer_name` STRING COMMENT 'The name of the attorney or knowledge manager who most recently reviewed and approved this precedent version.',
    `source_system` STRING COMMENT 'The originating system or platform from which this precedent was sourced or curated.. Valid values are `imanage_work|thomson_reuters_practical_law|lexisnexis|netdocuments|internal_repository`',
    `taxonomy_classification` BIGINT COMMENT 'FK to knowledge.knowledge_taxonomy.knowledge_taxonomy_id — Every precedent must be classified under the firms taxonomy for retrieval. This is a production-critical FK - without it, precedents cannot be found via taxonomy navigation which is the primary disco',
    `transaction_type` STRING COMMENT 'The specific type of legal transaction or matter this precedent supports (e.g., M&A, SPA, NDA, LOE, Financing, Restructuring).',
    `triggering_event` STRING COMMENT 'The business or legal event that prompted the creation or update of this precedent version (e.g., regulatory change, case law update, client feedback).',
    `usage_count` STRING COMMENT 'The cumulative number of times this precedent has been accessed, downloaded, or used in client matters.',
    `usage_notes` STRING COMMENT 'Practical guidance and instructions for attorneys on how to properly use, customize, and apply this precedent in client matters.',
    `version_number` STRING COMMENT 'The version identifier of this precedent document, tracking its evolution through amendments and updates.',
    `word_count` STRING COMMENT 'The total number of words in the precedent document for complexity and scope assessment.',
    CONSTRAINT pk_precedent PRIMARY KEY(`precedent_id`)
) COMMENT 'Master repository of approved precedent documents curated by the firms knowledge management team. Captures the canonical version of standard legal documents (e.g., SPA, NDA, LOE templates) sourced from iManage Work and Thomson Reuters Practical Law, including practice area classification, jurisdiction applicability, approval status, LPP flags, version lineage, and full update/review history (triggering events, reviewer, changes made, approval workflow status, effective dates of updated versions). Each precedent holds a foreign key to knowledge_asset for unified cross-asset catalog governance. Serves as the SSOT for reusable document templates, their currency governance, and their complete amendment lifecycle across all practice groups.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`knowledge`.`practice_note` (
    `practice_note_id` BIGINT COMMENT 'Unique identifier for the practice note. Primary key for the practice note entity.',
    `category_id` BIGINT COMMENT 'Foreign key linking to risk.risk_category. Business justification: Practice notes provide operational guidance for managing specific risk categories (e.g., Managing Conflicts of Interest, GDPR Compliance in M&A). This link enables risk-driven knowledge retrieval ',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Practice notes provide authoritative guidance for service delivery within specific practice areas. Used in attorney training, matter preparation, and quality assurance. Normalizes practice_area text f',
    `knowledge_asset_id` BIGINT COMMENT 'Foreign key reference to the knowledge asset catalog entry for unified cross-asset governance and taxonomy management.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Practice notes document how to comply with specific regulatory obligations. This link enables compliance officers to find guidance for each obligation and supports regulatory audit evidence of firm kn',
    `superseded_by_practice_note_id` BIGINT COMMENT 'Foreign key reference to the newer practice note that supersedes this one, supporting version lineage and ensuring users are directed to the most current guidance.',
    `taxonomy_id` BIGINT COMMENT 'Foreign key linking to knowledge.knowledge_taxonomy. Business justification: Practice notes should be classified in the knowledge taxonomy for governance and retrieval. Currently has topic_tags STRING for multi-valued tags, but needs FK for primary classification. One practice',
    `to_knowledge_asset_id` BIGINT COMMENT 'FK to knowledge.knowledge_asset.knowledge_asset_id — Every practice note must register in the knowledge_asset catalog for unified retrieval, access control, and lifecycle management.',
    `abstract` STRING COMMENT 'A concise summary or abstract of the practice note content, providing users with a quick overview of the key legal points and guidance covered.',
    `access_level` STRING COMMENT 'The access control classification for this practice note, determining which users or groups within the firm or externally are authorized to view and use the content.. Valid values are `public|internal|restricted|confidential`',
    `archived_timestamp` TIMESTAMP COMMENT 'The timestamp when this practice note was archived or removed from active use, supporting lifecycle management and historical record retention.',
    `author_email` STRING COMMENT 'The email address of the primary author for contact and collaboration purposes.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `author_name` STRING COMMENT 'The name of the primary author or legal expert who created or contributed this practice note, supporting expertise tracking and attribution.',
    `average_rating` DECIMAL(18,2) COMMENT 'The average user rating for this practice note on a scale of 0.00 to 5.00, reflecting user satisfaction and content quality.',
    `case_law_references` STRING COMMENT 'A list of judicial decisions, case citations, or precedents referenced in this practice note, supporting litigation and dispute resolution processes.',
    `compliance_framework` STRING COMMENT 'The regulatory compliance framework or standard to which this practice note relates, such as General Data Protection Regulation (GDPR), Sarbanes-Oxley Act (SOX), California Consumer Privacy Act (CCPA), or Anti-Money Laundering (AML) regulations.',
    `content_type` STRING COMMENT 'The classification of the practice note content type, distinguishing between guidance notes, procedural checklists, statute summaries, case law analyses, regulatory updates, and standard clauses.. Valid values are `guidance_note|procedural_checklist|statute_summary|case_law_analysis|regulatory_update|standard_clause`',
    `contributing_authors` STRING COMMENT 'A comma-separated list of additional authors or contributors who participated in the creation or review of this practice note.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this practice note record was first created in the knowledge management system, supporting audit trails and data lineage.',
    `currency_date` DATE COMMENT 'The date as of which the legal content in this practice note is current and accurate, critical for ensuring users rely on up-to-date legal guidance.',
    `document_format` STRING COMMENT 'The file format or content format in which this practice note is stored and delivered, supporting diverse document management and retrieval systems.. Valid values are `pdf|docx|html|markdown|plain_text`',
    `document_number` STRING COMMENT 'The externally-known unique document identifier or reference number assigned to this practice note for cataloging and retrieval purposes.',
    `download_count` STRING COMMENT 'The cumulative number of times this practice note has been downloaded or accessed by users, supporting usage analytics and knowledge asset valuation.',
    `external_url` STRING COMMENT 'The external URL or hyperlink to the original source of this practice note if sourced from Thomson Reuters Practical Law, LexisNexis, or another external platform.',
    `file_size_kb` STRING COMMENT 'The size of the practice note document file in kilobytes, supporting storage management and performance optimization.',
    `full_text_content` STRING COMMENT 'The complete text content of the practice note, including detailed legal analysis, guidance, procedural steps, and references to statutes, regulations, and case law.',
    `is_billable_reference` BOOLEAN COMMENT 'Boolean flag indicating whether time spent reviewing or using this practice note can be billed to client matters under Alternative Fee Arrangement (AFA) or standard billing arrangements.',
    `jurisdiction` STRING COMMENT 'The legal jurisdiction(s) to which this practice note applies, using ISO 3166-1 alpha-3 country codes or jurisdiction-specific identifiers for state/provincial law.',
    `language_code` STRING COMMENT 'The ISO 639-1 two-letter language code indicating the language in which this practice note is written, supporting multilingual knowledge management.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this practice note record was last modified or updated, supporting change tracking and audit compliance.',
    `last_review_date` DATE COMMENT 'The date on which this practice note was last reviewed for accuracy, currency, and relevance by a legal expert or knowledge management team.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next review of this practice note to ensure ongoing accuracy and compliance with current law and regulations.',
    `practice_note_status` STRING COMMENT 'The current lifecycle status of the practice note, indicating whether it is in draft, under review, approved, published, archived, or superseded by a newer version.. Valid values are `draft|under_review|approved|published|archived|superseded`',
    `publication_date` DATE COMMENT 'The date on which this practice note was officially published and made available to users within the firm or externally.',
    `rating_count` STRING COMMENT 'The total number of user ratings submitted for this practice note, supporting statistical confidence in the average rating.',
    `regulation_references` STRING COMMENT 'A list of regulations, rules, or administrative codes referenced in this practice note, supporting regulatory compliance counseling.',
    `related_practice_notes` STRING COMMENT 'A comma-separated list of related practice note identifiers that provide complementary or supplementary guidance on related legal topics.',
    `review_cycle_months` STRING COMMENT 'The frequency in months at which this practice note should be reviewed and updated, based on the volatility of the legal topic and regulatory environment.',
    `source_system` STRING COMMENT 'The originating system or platform from which this practice note was sourced, including Thomson Reuters Practical Law, LexisNexis, internal authoring, or external counsel contributions.. Valid values are `thomson_reuters_practical_law|lexisnexis|internal_authoring|external_counsel`',
    `statute_references` STRING COMMENT 'A list of statutes, acts, or legislative provisions referenced in this practice note, supporting legal research and cross-referencing.',
    `taxonomy_classification` BIGINT COMMENT 'FK to knowledge.knowledge_taxonomy.knowledge_taxonomy_id — Practice notes must be classified under taxonomy nodes for topic-based retrieval. This is how attorneys find relevant guidance - by navigating practice area > sub-topic > jurisdiction in the taxonomy.',
    `title` STRING COMMENT 'The full title of the practice note providing a clear description of the legal topic, statute, regulation, or procedural requirement covered.',
    `topic_tags` STRING COMMENT 'A comma-separated list of topic tags or keywords extracted via Natural Language Processing (NLP) or manually assigned, enabling semantic search and topic-based retrieval.',
    `version_number` STRING COMMENT 'The version identifier for this practice note, supporting version control and tracking of updates over time.',
    `view_count` STRING COMMENT 'The cumulative number of times this practice note has been viewed online by users, supporting usage analytics and content effectiveness measurement.',
    CONSTRAINT pk_practice_note PRIMARY KEY(`practice_note_id`)
) COMMENT 'Authoritative internal and externally sourced practice notes providing legal guidance on specific topics, statutes, regulations, and procedural requirements. Integrates content from Thomson Reuters Practical Law and LexisNexis. Tracks authorship, practice area, jurisdiction, currency date, review cycle, and NLP-extracted topic tags. Each practice note links to a knowledge_asset catalog entry for unified cross-asset governance. Supports Legal Research and Analysis and Regulatory Compliance Counseling processes.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`knowledge`.`clause` (
    `clause_id` BIGINT COMMENT 'Primary key for clause',
    `timekeeper_id` BIGINT COMMENT 'Reference to the senior timekeeper or knowledge management partner who approved this clause for inclusion in the library.',
    `clause_author_timekeeper_id` BIGINT COMMENT 'Reference to the timekeeper (attorney or knowledge management professional) who authored or contributed this clause to the library.',
    `knowledge_asset_id` BIGINT COMMENT 'Reference to the parent knowledge asset catalog entry for unified cross-asset governance and taxonomy management.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Standard clauses must comply with firm policies (e.g., data privacy clauses align with GDPR policy). This link enables policy compliance verification in contract assembly and supports clause library g',
    `legal_document_id` BIGINT COMMENT 'Reference identifier linking this clause to its source document or template stored in the firms DMS (iManage Work or NetDocuments).',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Clause library is organized by practice area for contract drafting and document automation. Attorneys filter clauses by practice area during contract assembly. Normalizes practice_area text field to e',
    `category_id` BIGINT COMMENT 'Foreign key linking to risk.risk_category. Business justification: Clause types map to risk categories: indemnity clauses mitigate PI risk, data processing clauses address data breach risk, limitation clauses manage financial exposure. This link enables risk-aware dr',
    `taxonomy_id` BIGINT COMMENT 'Foreign key linking to knowledge.knowledge_taxonomy. Business justification: Clauses should be classified in the knowledge taxonomy for governance and retrieval. Currently has semantic_tags STRING for multi-valued tags, but needs FK for primary classification. One clause has o',
    `to_knowledge_asset_id` BIGINT COMMENT 'FK to knowledge.knowledge_asset.knowledge_asset_id — Every clause must register in the knowledge_asset catalog for unified retrieval and governance.',
    `approval_status` STRING COMMENT 'Current approval and lifecycle status of the clause within the knowledge management governance process.. Valid values are `draft|under_review|approved|deprecated|archived`',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this clause was formally approved for use by the knowledge management governance committee.',
    `clause_category` STRING COMMENT 'Broader business category grouping for the clause (e.g., boilerplate, commercial terms, risk allocation, compliance, operational, relationship management).. Valid values are `boilerplate|commercial|risk_allocation|compliance|operational|relationship`',
    `clause_text` STRING COMMENT 'Full text of the clause as approved by the knowledge management team. May include placeholders for variable terms (e.g., [PARTY_NAME], [AMOUNT], [DATE]).',
    `clause_type` STRING COMMENT 'Primary classification of the clause by legal function. [ENUM-REF-CANDIDATE: indemnity|limitation_of_liability|governing_law|dispute_resolution|confidentiality|termination|intellectual_property|warranty|force_majeure|assignment|severability|entire_agreement|amendment|notice|waiver — promote to reference product]. Valid values are `indemnity|limitation_of_liability|governing_law|dispute_resolution|confidentiality|termination`',
    `clm_system_reference` STRING COMMENT 'External reference identifier or URL linking this clause to its representation in the firms CLM system for document assembly and contract automation.',
    `contract_type_applicability` STRING COMMENT 'Comma-separated list of contract types where this clause is commonly applicable (e.g., NDA, SPA, MSA, SOW, License Agreement, Employment Agreement).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this clause record was first created in the knowledge management system.',
    `deprecated_timestamp` TIMESTAMP COMMENT 'Timestamp when this clause was deprecated or archived, indicating it is no longer recommended for use in new contracts.',
    `effective_date` DATE COMMENT 'Date from which this clause version became effective and available for use in document drafting and contract lifecycle management.',
    `expiration_date` DATE COMMENT 'Date on which this clause version is scheduled to expire or be deprecated. Null if the clause remains active indefinitely.',
    `fallback_position_text` STRING COMMENT 'Alternative clause text representing the firms fallback negotiating position if the primary clause is rejected by the counterparty.',
    `governing_law_reference` STRING COMMENT 'Specific legal framework, statute, or body of law that governs the interpretation of this clause (e.g., New York UCC, English Contract Law, CISG).',
    `identifier` STRING COMMENT 'Business-readable unique identifier or code for the clause (e.g., INDEM-001, GOV-LAW-UK-STD). Used for cross-referencing in document assembly and CLM systems.',
    `industry_applicability` STRING COMMENT 'Comma-separated list of industries or sectors where this clause is particularly relevant (e.g., technology, healthcare, financial_services, manufacturing, energy).',
    `is_standard_form` BOOLEAN COMMENT 'Indicates whether this clause is part of the firms standard form library (True) or a custom/negotiated variant (False).',
    `jurisdiction` STRING COMMENT 'Three-letter ISO country code representing the primary legal jurisdiction for which this clause is drafted (e.g., USA, GBR, DEU). Multi-jurisdictional clauses may reference a neutral or common jurisdiction.. Valid values are `^[A-Z]{3}$`',
    `language_code` STRING COMMENT 'Two-letter ISO 639-1 language code indicating the language in which the clause is drafted (e.g., en for English, fr for French, de for German).. Valid values are `^[a-z]{2}$`',
    `last_reviewed_date` DATE COMMENT 'Date when this clause was last reviewed by the knowledge management team for accuracy, relevance, and compliance with current legal standards.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this clause record was last modified or updated.',
    `negotiability_flag` BOOLEAN COMMENT 'Indicates whether this clause is typically negotiable (True) or non-negotiable (False) in standard engagements.',
    `notes` STRING COMMENT 'Free-text field for additional internal notes, comments, or annotations related to the clause, including historical context or special considerations.',
    `precedent_source` STRING COMMENT 'Source or origin of the clause precedent (e.g., internal template, Thomson Reuters Practical Law, client-provided, opposing counsel, industry standard form).',
    `regulatory_compliance_tags` STRING COMMENT 'Comma-separated list of regulatory frameworks or compliance requirements addressed by this clause (e.g., GDPR, SOX, HIPAA, CCPA, FRAND, AML).',
    `related_clauses` STRING COMMENT 'Comma-separated list of clause identifiers for related or dependent clauses that are commonly used together (e.g., indemnity clauses paired with limitation of liability).',
    `risk_rating` STRING COMMENT 'Risk assessment rating assigned by the legal team indicating the level of legal or business risk associated with this clause (e.g., low, medium, high, critical).. Valid values are `low|medium|high|critical`',
    `semantic_tags` STRING COMMENT 'Comma-separated list of NLP-extracted semantic tags and keywords for advanced search and retrieval (e.g., liability_cap, mutual_obligation, unilateral, time_limit).',
    `title` STRING COMMENT 'Human-readable title or name of the clause (e.g., Mutual Indemnification, Limitation of Liability, Governing Law).',
    `usage_count` STRING COMMENT 'Number of times this clause has been used in executed contracts or document assembly workflows, tracked for popularity and effectiveness analysis.',
    `usage_guidance` STRING COMMENT 'Internal guidance notes for attorneys on when and how to use this clause, including contextual considerations, common pitfalls, and best practices.',
    `variant_label` STRING COMMENT 'Label identifying the specific variant or version of the clause (e.g., Standard, Client-Favorable, Vendor-Favorable, Fallback Position, Aggressive, Conservative).',
    `version_number` STRING COMMENT 'Version identifier for the clause (e.g., 1.0, 2.1, 3.0) to track revisions and updates over time.',
    `word_count` STRING COMMENT 'Total word count of the clause text, used for document assembly estimation and billing purposes.',
    CONSTRAINT pk_clause PRIMARY KEY(`clause_id`)
) COMMENT 'Structured repository of standard and negotiated contract clauses maintained by the firms knowledge management and CLM teams. Each clause record captures clause type (e.g., indemnity, limitation of liability, governing law), jurisdiction, practice area, approved variants, fallback positions, and NLP-extracted semantic tags. Each clause links to a knowledge_asset catalog entry for unified cross-asset governance. Supports Document Drafting and Review and Contract Lifecycle Management processes.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`knowledge`.`form_template` (
    `form_template_id` BIGINT COMMENT 'Unique identifier for the form template record. Primary key.',
    `category_id` BIGINT COMMENT 'Foreign key linking to risk.risk_category. Business justification: Court/regulatory forms map to compliance risk categories - filing the correct form on time mitigates regulatory breach risk. This link enables risk-aware form management: risk teams track whether requ',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Court forms and regulatory templates are practice-area specific. Used in filing preparation and procedural compliance workflows. Normalizes practice_group text field (no exact practice_area column vis',
    `knowledge_asset_id` BIGINT COMMENT 'FK to knowledge.knowledge_asset.knowledge_asset_id — Every form template must register in the knowledge_asset catalog for unified retrieval and lifecycle governance.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Court and regulatory forms directly implement specific regulatory filing obligations. This link enables compliance tracking of filing requirements and supports regulatory return preparation and deadli',
    `taxonomy_id` BIGINT COMMENT 'Foreign key linking to knowledge.knowledge_taxonomy. Business justification: Form templates should be classified in the knowledge taxonomy for governance and retrieval. One form has one primary taxonomy classification; one taxonomy node classifies many forms. This enables cons',
    `to_knowledge_asset_id` BIGINT COMMENT 'FK to knowledge.knowledge_asset.knowledge_asset_id — Every form template must FK to its knowledge_asset catalog entry. Required for unified asset governance.',
    `applicable_statute` STRING COMMENT 'Citation of the statute, regulation, or rule that mandates or governs the use of this form (e.g., Federal Rule of Civil Procedure 26, 17 CFR § 240.14a-101).',
    `approval_date` DATE COMMENT 'Date on which this form template was formally approved for inclusion in the knowledge management library.',
    `author_name` STRING COMMENT 'Name of the attorney, paralegal, or knowledge management professional who created or last updated this form template.',
    `court_tribunal_name` STRING COMMENT 'Name of the specific court, tribunal, or adjudicative body for which this form is designed (e.g., U.S. District Court Southern District of New York, International Chamber of Commerce).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this form template record was first created in the knowledge management system.',
    `document_format` STRING COMMENT 'File format of the form template (PDF, DOCX, DOC, RTF, HTML, XML, fillable PDF). [ENUM-REF-CANDIDATE: pdf|docx|doc|rtf|html|xml|fillable_pdf — 7 candidates stripped; promote to reference product]',
    `effective_date` DATE COMMENT 'Date from which this form template version becomes valid and available for use in legal matters.',
    `expiry_date` DATE COMMENT 'Date on which this form template version is no longer valid or superseded by a newer version. Null if the form remains current indefinitely.',
    `external_reference_url` STRING COMMENT 'URL or hyperlink to the official source, court website, or regulatory portal where the authoritative version of this form is published.',
    `file_path` STRING COMMENT 'Storage location or URI of the form template file within the Document Management System (DMS) (iManage Work or NetDocuments).',
    `filing_fee_amount` DECIMAL(18,2) COMMENT 'Standard fee amount required for filing or submitting this form to the court, tribunal, or regulatory body.',
    `filing_fee_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the filing fee (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `filing_instructions` STRING COMMENT 'Detailed procedural instructions for completing, submitting, or filing the form, including deadlines, required attachments, and submission channels.',
    `form_category` STRING COMMENT 'Secondary classification or practice area grouping (e.g., civil litigation, criminal defense, corporate transactions, intellectual property, employment law, family law).',
    `form_code` STRING COMMENT 'Unique business identifier or code for the form template (e.g., court form number, regulatory form designation, internal reference code).',
    `form_template_status` STRING COMMENT 'Current lifecycle status of the form template (active, draft, archived, superseded, under review, deprecated).. Valid values are `active|draft|archived|superseded|under_review|deprecated`',
    `form_title` STRING COMMENT 'Full official title or name of the form template as recognized by the issuing authority or internal practice group.',
    `form_type` STRING COMMENT 'Classification of the form template by its primary business purpose (court filing, regulatory submission, transactional document, internal administrative, client intake, discovery, motion, pleading). [ENUM-REF-CANDIDATE: court_filing|regulatory_submission|transactional|internal_administrative|client_intake|discovery|motion|pleading — 8 candidates stripped; promote to reference product]',
    `is_client_facing` BOOLEAN COMMENT 'Flag indicating whether this form template is intended for direct use by clients or is for internal attorney use only.',
    `is_confidential` BOOLEAN COMMENT 'Flag indicating whether this form template contains confidential or privileged content subject to Legal Professional Privilege (LPP) or attorney work product protections.',
    `jurisdiction` STRING COMMENT 'Legal jurisdiction or geographic scope where this form template is applicable (e.g., federal, state-specific, international treaty jurisdiction).',
    `keywords` STRING COMMENT 'Comma-separated list of keywords or tags for Natural Language Processing (NLP)-driven retrieval and taxonomy management.',
    `last_used_date` DATE COMMENT 'Most recent date on which this form template was accessed or used in a legal matter.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this form template record was last modified or updated.',
    `notes` STRING COMMENT 'Free-text field for additional comments, usage tips, or special instructions related to the form template.',
    `practice_group` STRING COMMENT 'Internal practice group or department that primarily uses or maintains this form template (e.g., Litigation, Corporate, Intellectual Property (IP), Employment, Regulatory Compliance).',
    `procedural_requirements` STRING COMMENT 'Summary of procedural rules, deadlines, service requirements, or compliance obligations associated with the use of this form.',
    `regulatory_body` STRING COMMENT 'Name of the regulatory authority or government agency that mandates or governs the use of this form (e.g., SEC, USPTO, FTC, state licensing boards).',
    `required_attachments` STRING COMMENT 'List or description of mandatory supporting documents or exhibits that must accompany this form when filed or submitted.',
    `retention_period_years` STRING COMMENT 'Number of years this form template and its usage records must be retained per records management and regulatory compliance policies.',
    `reviewer_name` STRING COMMENT 'Name of the senior attorney or practice group leader who reviewed and approved this form template for use.',
    `source_system` STRING COMMENT 'Operational system from which this form template was sourced (iManage Work, NetDocuments, ECF/PACER, Thomson Reuters Practical Law, internal DMS, LexisNexis).. Valid values are `imanage_work|netdocuments|ecf_pacer|thomson_reuters_practical_law|internal_dms|lexisnexis`',
    `usage_count` STRING COMMENT 'Number of times this form template has been accessed, downloaded, or used in matters, supporting knowledge management analytics.',
    `version_number` STRING COMMENT 'Version identifier for the form template to track revisions and updates over time (e.g., 1.0, 2.3, 2023-Q4).',
    CONSTRAINT pk_form_template PRIMARY KEY(`form_template_id`)
) COMMENT 'Library of standardized legal forms, court filing templates, regulatory submission forms, and transactional forms used across practice groups. Each record represents a specific form capturing form type, applicable jurisdiction, court or tribunal, regulatory body, version, effective date, expiry date, filing instructions, and associated procedural requirements. Sourced from ECF/PACER integrations and internal DMS (iManage Work / NetDocuments). Each form links to a knowledge_asset catalog entry for unified cross-asset governance. Supports litigation filing, regulatory submissions, and transactional document assembly.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`knowledge`.`checklist` (
    `checklist_id` BIGINT COMMENT 'Unique identifier for the checklist record. Primary key.',
    `mitigation_action_id` BIGINT COMMENT 'Foreign key linking to risk.risk_mitigation_action. Business justification: Checklists are procedural controls deployed as risk mitigation actions. When a mitigation plan requires implement enhanced due diligence checklist or enforce conflict check procedure, the checklis',
    `parent_checklist_id` BIGINT COMMENT 'Foreign key reference to a parent checklist if this checklist is a derived or specialized version of another checklist. Nullable for root-level checklists.',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Checklists guide service delivery workflows and quality control by practice area. Used in matter management and regulatory compliance processes. Normalizes practice_area text field to enable checklist',
    `knowledge_asset_id` BIGINT COMMENT 'Foreign key linking this checklist to the unified knowledge asset catalog for cross-asset governance and retrieval.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Compliance checklists are explicitly designed to ensure regulatory obligations are met. This is fundamental to compliance workflow management, audit trails, and demonstrating systematic compliance pro',
    `taxonomy_id` BIGINT COMMENT 'Foreign key linking to knowledge.knowledge_taxonomy. Business justification: Checklists should be classified in the knowledge taxonomy for governance and retrieval. Currently has taxonomy_tags STRING for multi-valued tags, but needs FK for primary classification. One checklist',
    `to_knowledge_asset_id` BIGINT COMMENT 'FK to knowledge.knowledge_asset.knowledge_asset_id — Every checklist must register in the knowledge_asset catalog for unified retrieval and governance.',
    `access_level` STRING COMMENT 'The access control classification for this checklist, determining who can view and use it (e.g., public, internal, confidential, restricted).. Valid values are `public|internal|confidential|restricted`',
    `author_name` STRING COMMENT 'The name of the individual or team who authored or created this checklist.',
    `checklist_code` STRING COMMENT 'Unique business identifier or reference code for the checklist, used for cataloging and retrieval within the knowledge management system.',
    `checklist_description` STRING COMMENT 'A detailed textual description of the checklists purpose, scope, and intended use cases.',
    `checklist_name` STRING COMMENT 'The business-friendly name or title of the checklist (e.g., M&A Due Diligence Checklist, IP Prosecution Checklist).',
    `checklist_status` STRING COMMENT 'Current lifecycle status of the checklist (e.g., draft, active, archived, under review, deprecated).. Valid values are `draft|active|archived|under_review|deprecated`',
    `checklist_type` STRING COMMENT 'The category or type of checklist, indicating its primary business purpose (e.g., due diligence, compliance, prosecution, litigation readiness). [ENUM-REF-CANDIDATE: due_diligence|compliance|prosecution|litigation_readiness|transaction|regulatory|risk_assessment — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this checklist record was first created in the knowledge management system.',
    `effective_date` DATE COMMENT 'The date from which this version of the checklist becomes effective and available for use.',
    `expiration_date` DATE COMMENT 'The date on which this checklist version is scheduled to expire or be reviewed for currency. Nullable for checklists without a defined expiration.',
    `is_template` BOOLEAN COMMENT 'Boolean flag indicating whether this checklist is a reusable template (True) or a specific instance (False).',
    `jurisdiction` STRING COMMENT 'The legal jurisdiction or geographic region for which this checklist is designed (e.g., USA, GBR, DEU, multi-jurisdictional). Uses ISO 3166-1 alpha-3 country codes where applicable.',
    `language_code` STRING COMMENT 'The ISO 639-1 two-letter language code indicating the language in which this checklist is written (e.g., EN for English, FR for French, DE for German).',
    `last_used_date` DATE COMMENT 'The most recent date on which this checklist was accessed or applied to a matter.',
    `mandatory_steps_count` STRING COMMENT 'The number of steps in this checklist that are marked as mandatory or required.',
    `matter_type` STRING COMMENT 'The type of legal matter or engagement for which this checklist is typically used (e.g., Mergers and Acquisitions (M&A), Share Purchase Agreement (SPA), Patent Prosecution, Regulatory Audit).',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this checklist record was last modified or updated.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next review of this checklist to ensure it remains current and accurate.',
    `optional_steps_count` STRING COMMENT 'The number of steps in this checklist that are marked as optional or discretionary.',
    `regulatory_framework` STRING COMMENT 'The regulatory or compliance framework to which this checklist is aligned (e.g., General Data Protection Regulation (GDPR), Sarbanes-Oxley Act (SOX), Anti-Money Laundering (AML), Know Your Client (KYC)).',
    `review_date` DATE COMMENT 'The date on which this checklist was last reviewed for accuracy and currency.',
    `reviewer_name` STRING COMMENT 'The name of the individual or team who reviewed and approved this checklist for publication.',
    `source_reference_code` STRING COMMENT 'The unique identifier or reference code from the source system (e.g., Thomson Reuters Practical Law document ID, LexisNexis resource ID).',
    `source_system` STRING COMMENT 'The originating system or platform from which this checklist was sourced (e.g., Thomson Reuters Practical Law, LexisNexis, internal knowledge base, iManage Work, custom-built).. Valid values are `thomson_reuters_practical_law|lexisnexis|internal|imanage|custom`',
    `taxonomy_tags` STRING COMMENT 'Comma-separated or pipe-separated taxonomy tags used for classification, search, and Natural Language Processing (NLP)-driven retrieval within the knowledge management system.',
    `total_steps` STRING COMMENT 'The total number of steps or tasks included in this checklist.',
    `usage_count` STRING COMMENT 'The number of times this checklist has been accessed, downloaded, or applied to matters, used for analytics and knowledge asset performance tracking.',
    `usage_notes` STRING COMMENT 'Guidance and best practices for using this checklist, including any special considerations, prerequisites, or contextual information.',
    `version_number` STRING COMMENT 'The version identifier of the checklist, used to track revisions and updates over time (e.g., 1.0, 2.1, 3.0).',
    CONSTRAINT pk_checklist PRIMARY KEY(`checklist_id`)
) COMMENT 'Structured task and due-diligence checklists used across practice areas including M&A due diligence, regulatory compliance, IP prosecution, and litigation readiness. Each checklist record captures the checklist type, practice area, jurisdiction, associated matter type, step sequence, mandatory vs. optional flags, and Thomson Reuters Practical Law source reference. Each checklist links to a knowledge_asset catalog entry for unified cross-asset governance. Supports Matter Management and Case Administration.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`knowledge`.`research_memo` (
    `research_memo_id` BIGINT COMMENT 'Unique identifier for the legal research memorandum. Primary key.',
    `assessment_id` BIGINT COMMENT 'Foreign key linking to risk.risk_assessment. Business justification: Legal research memos inform risk assessments, especially for novel legal risks, regulatory interpretation, or jurisdictional uncertainty. Risk assessors commission research to quantify legal exposure.',
    `legal_document_id` BIGINT COMMENT 'Unique identifier for this research memo in the Document Management System (iManage Work or NetDocuments). Supports cross-system integration.',
    `matter_id` BIGINT COMMENT 'Foreign key to the matter or case for which this research memo was prepared. Supports matter-specific knowledge retrieval.',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Research memos are categorized by practice area for knowledge reuse and research request routing. Used in precedent research and billing allocation. Normalizes practice_area text field to enable resea',
    `knowledge_asset_id` BIGINT COMMENT 'FK to knowledge.knowledge_asset.knowledge_asset_id — Every research memo must register in the knowledge_asset catalog for unified retrieval, access classification, and lifecycle governance.',
    `timekeeper_id` BIGINT COMMENT 'Foreign key to the attorney or paralegal who authored this research memorandum. Tracks authorship for expertise directories and knowledge attribution.',
    `profile_id` BIGINT COMMENT 'Foreign key to the client for whom this research memo was prepared. Supports client-specific knowledge retrieval and conflict checking.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Research memos frequently analyze specific regulatory obligations for client matters. Tracking this enables knowledge reuse when similar regulatory questions arise and supports compliance advisory ser',
    `taxonomy_id` BIGINT COMMENT 'Foreign key linking to knowledge.knowledge_taxonomy. Business justification: Research memos should be classified in the knowledge taxonomy for governance and retrieval. Currently has tags STRING for multi-valued tags, but needs FK for primary classification. One memo has one p',
    `to_knowledge_asset_id` BIGINT COMMENT 'FK to knowledge.knowledge_asset.knowledge_asset_id — Every research memo must FK to its knowledge_asset catalog entry. Required for unified asset governance.',
    `access_control_list` STRING COMMENT 'Comma-separated list of user IDs or group IDs with access to this research memo. Supports granular access control and ethical walls.',
    `approval_date` DATE COMMENT 'Date when the supervising attorney approved this research memo for use. Marks the transition to approved status.',
    `archived_date` DATE COMMENT 'Date when this research memo was archived or marked as superseded. Supports records retention and lifecycle management.',
    `case_law_citations` STRING COMMENT 'List of case law citations analyzed in this research memo. Supports precedent tracking and legal reasoning analysis.',
    `conclusion` STRING COMMENT 'The legal conclusion or recommendation provided in this research memo. Captures the attorneys professional judgment on the issue.',
    `confidentiality_level` STRING COMMENT 'Data classification level indicating the sensitivity and access restrictions for this research memo.. Valid values are `public|internal|confidential|restricted`',
    `created_date` DATE COMMENT 'Date when this research memo record was first created in the system. Supports lifecycle tracking and audit trails.',
    `document_storage_path` STRING COMMENT 'File path or URI to the full-text document stored in the DMS (iManage Work or NetDocuments). Enables retrieval of the complete memo.',
    `is_precedent` BOOLEAN COMMENT 'Boolean flag indicating whether this research memo has been designated as a precedent document for reuse in future matters.',
    `is_published_to_knowledge_base` BOOLEAN COMMENT 'Boolean flag indicating whether this research memo has been published to the firm-wide knowledge base for broader access and reuse.',
    `jurisdiction` STRING COMMENT 'The legal jurisdiction(s) relevant to this research memo (e.g., federal, state, international). Critical for applicability and precedent analysis.',
    `key_legal_concepts` STRING COMMENT 'NLP-extracted key legal concepts, doctrines, and principles identified in this research memo. Supports semantic search and knowledge graph construction.',
    `language_code` STRING COMMENT 'ISO 639-2 three-letter language code indicating the language in which this research memo is written. Supports multilingual knowledge management.. Valid values are `^[A-Z]{3}$`',
    `last_modified_date` DATE COMMENT 'Date when this research memo record was last updated. Tracks the most recent revision or metadata change.',
    `lexisnexis_source_citations` STRING COMMENT 'Structured list of LexisNexis source citations referenced in this research memo. Supports provenance tracking and citation analysis.',
    `lpp_classification` STRING COMMENT 'Classification indicating whether this memo is protected by attorney-client privilege or work product doctrine. Critical for eDiscovery and disclosure decisions.. Valid values are `privileged|work_product|not_privileged`',
    `memo_status` STRING COMMENT 'Current lifecycle status of the research memorandum. Tracks progression from draft through approval to archival.. Valid values are `draft|under_review|approved|archived|superseded`',
    `memo_summary` STRING COMMENT 'Executive summary or abstract of the research memo, providing a high-level overview of the analysis and conclusions.',
    `memo_title` STRING COMMENT 'The title or subject line of the research memorandum, providing a concise summary of the legal issue addressed.',
    `nlp_processing_date` TIMESTAMP COMMENT 'Timestamp when NLP processing was last executed on this research memo. Tracks currency of semantic metadata.',
    `nlp_processing_status` STRING COMMENT 'Status of NLP processing for key concept extraction and semantic indexing. Supports AI-driven knowledge retrieval.. Valid values are `pending|in_progress|completed|failed`',
    `quality_rating` DECIMAL(18,2) COMMENT 'Peer or supervisor quality rating for this research memo on a scale of 0.00 to 5.00. Supports knowledge asset curation and best-practice identification.',
    `regulation_citations` STRING COMMENT 'List of regulatory provisions cited in this research memo. Supports regulatory compliance and administrative law analysis.',
    `related_memo_ids` STRING COMMENT 'Comma-separated list of related research memo IDs. Supports knowledge graph construction and cross-referencing.',
    `research_hours` DECIMAL(18,2) COMMENT 'Total billable hours spent on researching and drafting this memo. Supports cost tracking and matter budgeting.',
    `research_question` STRING COMMENT 'The specific legal question or issue that the research memo addresses. Supports NLP-driven retrieval and knowledge reuse.',
    `retention_period_years` STRING COMMENT 'Number of years this research memo must be retained per firm policy or regulatory requirements. Supports records management and compliance.',
    `reuse_count` STRING COMMENT 'Number of times this research memo has been referenced or reused in subsequent matters. Tracks knowledge asset value.',
    `secondary_source_citations` STRING COMMENT 'List of secondary sources (treatises, law review articles, practice guides) cited in this research memo. Supports comprehensive legal analysis.',
    `statute_citations` STRING COMMENT 'List of statutory provisions cited in this research memo. Supports legislative analysis and compliance tracking.',
    `tags` STRING COMMENT 'User-defined tags or keywords for flexible categorization and retrieval. Supports folksonomy-based knowledge organization.',
    `version_number` STRING COMMENT 'Version number of this research memo. Tracks revisions and updates over time.',
    `westlaw_source_citations` STRING COMMENT 'Structured list of Westlaw source citations referenced in this research memo. Supports provenance tracking and citation analysis.',
    CONSTRAINT pk_research_memo PRIMARY KEY(`research_memo_id`)
) COMMENT 'Legal research memoranda produced by attorneys and paralegals capturing analysis of case law, statutes, regulations, and secondary sources. Tracks author, supervising attorney, matter association, research question, jurisdiction, LexisNexis and Westlaw source citations, LPP classification, confidentiality level, and NLP-extracted key legal concepts. Each memo links to a knowledge_asset catalog entry for unified cross-asset governance. Supports Legal Research and Analysis and Knowledge Management and Precedent Tracking processes.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` (
    `taxonomy_id` BIGINT COMMENT 'Unique identifier for the knowledge taxonomy node. Primary key for the taxonomy hierarchy.',
    `parent_taxonomy_id` BIGINT COMMENT 'Reference to the parent node in the taxonomy hierarchy. Null for root-level nodes. Enables hierarchical navigation from practice areas to sub-practices to topics.',
    `practice_area_id` BIGINT COMMENT 'Foreign key to service.practice_area.practice_area_id',
    `primary_replacement_taxonomy_id` BIGINT COMMENT 'Reference to the taxonomy node that replaces this deprecated node. Used for automated migration of knowledge asset classifications and user query redirection.',
    `access_level` STRING COMMENT 'Data classification level governing who can view and use this taxonomy node. Public nodes are visible to all, internal to firm staff, confidential to authorized practice groups, restricted to specific matter teams.. Valid values are `public|internal|confidential|restricted`',
    `alternate_terms` STRING COMMENT 'Comma-separated list of synonyms, abbreviations, and alternative names for this taxonomy node. Used for Natural Language Processing (NLP) search expansion and query matching. Example: M&A, Mergers & Acquisitions, Corporate Combinations.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this taxonomy node record was first created in the system. Used for audit trail and taxonomy evolution analysis.',
    `display_order` STRING COMMENT 'Sequence number for ordering sibling nodes within the same parent. Used for consistent presentation in user interfaces and knowledge portals.',
    `effective_date` DATE COMMENT 'Date when this taxonomy node became active and available for classification. Used for temporal queries and historical analysis of taxonomy evolution.',
    `expiration_date` DATE COMMENT 'Date when this taxonomy node was deprecated or retired. Null for active nodes. Knowledge assets classified under expired nodes remain linked for historical integrity.',
    `external_taxonomy_mapping` STRING COMMENT 'Mapping to external taxonomy systems such as Thomson Reuters Practical Law, LexisNexis Practice Areas, or UTBMS codes. Format: system_name:code. Example: PracticalLaw:CORP-MA, UTBMS:C101.',
    `hierarchy_level` STRING COMMENT 'Depth of this node in the taxonomy tree. Root nodes are level 1, their children are level 2, etc. Used for navigation and display rendering.',
    `hierarchy_path` STRING COMMENT 'Full path from root to this node using taxonomy codes separated by forward slashes. Example: CORP/CORP-MA/CORP-MA-DUE. Enables efficient ancestor and descendant queries.',
    `is_deprecated` BOOLEAN COMMENT 'Indicates whether this taxonomy node has been deprecated and replaced by a newer node. Deprecated nodes are retained for historical classification but hidden from new asset tagging.',
    `is_leaf_node` BOOLEAN COMMENT 'Indicates whether this taxonomy node is a terminal leaf (true) or has child nodes (false). Leaf nodes are the most granular classification level and are directly assigned to knowledge assets.',
    `jurisdiction` STRING COMMENT 'Legal jurisdiction or geographic scope this taxonomy node applies to. Examples: USA, GBR, DEU, EU, International. Uses ISO 3166-1 alpha-3 country codes or recognized legal system identifiers.',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code for this taxonomy node. Supports multilingual knowledge management for global firms. Example: en for English, fr for French, de for German.. Valid values are `^[a-z]{2}$`',
    `last_used_date` DATE COMMENT 'Most recent date a knowledge asset was classified under this taxonomy node. Used to identify stale or obsolete taxonomy branches for review.',
    `matter_type` STRING COMMENT 'Type of legal matter this taxonomy node relates to. Examples: Transactional, Advisory, Litigation, Regulatory, Compliance. Aligns with firm matter management categories.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this taxonomy node record was last modified. Tracks changes to name, scope, hierarchy, or metadata. Updated on every edit.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this taxonomy node. Ensures taxonomy remains current with evolving legal practice and regulatory changes.',
    `nlp_keywords` STRING COMMENT 'Comma-separated list of keywords and phrases used by NLP-driven retrieval engines to match user queries to this taxonomy node. Includes legal terminology, common misspellings, and colloquial terms.',
    `owner_email` STRING COMMENT 'Email address of the taxonomy owner. Used for governance workflows, change requests, and taxonomy review notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `owner_name` STRING COMMENT 'Name of the Knowledge Management team member or practice group leader responsible for maintaining this taxonomy node. Accountable for scope definition, updates, and quality.',
    `practice_area` STRING COMMENT 'Top-level practice area this taxonomy node belongs to. Examples: Corporate, Litigation, Intellectual Property, Employment, Real Estate, Tax, Regulatory Compliance. Denormalized for efficient filtering.',
    `preferred_term` STRING COMMENT 'The authoritative term to use when referring to this taxonomy concept. Standardizes vocabulary across the firm and ensures consistent knowledge asset tagging.',
    `regulatory_framework` STRING COMMENT 'Applicable regulatory or compliance framework this taxonomy node relates to. Examples: GDPR, SOX, CCPA, AML, FRAND. Used to classify compliance-related knowledge assets.',
    `related_taxonomy_ids` STRING COMMENT 'Comma-separated list of knowledge_taxonomy_id values for related or cross-referenced taxonomy nodes. Supports lateral navigation and knowledge graph traversal. Example: linking Corporate Governance to both Corporate and Compliance practice areas.',
    `review_date` DATE COMMENT 'Date when this taxonomy node was last reviewed for accuracy, scope, and alignment with current practice. Part of the taxonomy governance cycle.',
    `reviewer_name` STRING COMMENT 'Name of the subject matter expert who last reviewed this taxonomy node for accuracy and relevance. Typically a senior partner or practice group leader.',
    `scope_notes` STRING COMMENT 'Guidance on what content should and should not be classified under this node. Includes examples of in-scope and out-of-scope matters to reduce misclassification.',
    `source_reference_code` STRING COMMENT 'Unique identifier of this taxonomy node in the source system. Used for synchronization and cross-system mapping. Example: PracticalLaw taxonomy ID or LexisNexis practice area code.',
    `source_system` STRING COMMENT 'System of record where this taxonomy node was originally defined. Examples: Thomson Reuters Practical Law, LexisNexis, Internal KM System. Supports taxonomy integration and provenance tracking.',
    `taxonomy_code` STRING COMMENT 'Unique alphanumeric code identifying this taxonomy node. Used for system integration and knowledge asset tagging. Example: CORP-MA for Corporate Mergers and Acquisitions.. Valid values are `^[A-Z0-9]{2,20}$`',
    `taxonomy_description` STRING COMMENT 'Detailed explanation of the taxonomy node scope, coverage, and usage guidelines. Helps knowledge contributors classify assets correctly and users understand search results.',
    `taxonomy_name` STRING COMMENT 'Human-readable name of the taxonomy node. Example: Mergers and Acquisitions, Employment Law, Intellectual Property Prosecution.',
    `taxonomy_status` STRING COMMENT 'Current lifecycle status of the taxonomy node. Active nodes are in use, inactive are hidden but retained for historical classification, deprecated are replaced by newer nodes, under review are being evaluated, proposed are pending approval.. Valid values are `active|inactive|deprecated|under_review|proposed`',
    `taxonomy_type` STRING COMMENT 'Classification of the taxonomy node type. Practice areas are top-level categories, sub-practices are specializations, jurisdictions are geographic/legal systems, matter types are case categories, topic tags are granular subjects, and document types classify knowledge asset formats.. Valid values are `practice_area|sub_practice|jurisdiction|matter_type|topic_tag|document_type`',
    `usage_count` STRING COMMENT 'Number of knowledge assets currently classified under this taxonomy node. Updated periodically to support taxonomy governance and identify underutilized or overloaded nodes.',
    `version_number` STRING COMMENT 'Version identifier for this taxonomy node definition. Follows semantic versioning (major.minor). Incremented when scope, name, or hierarchy changes.. Valid values are `^[0-9]+.[0-9]+$`',
    CONSTRAINT pk_taxonomy PRIMARY KEY(`taxonomy_id`)
) COMMENT 'Hierarchical taxonomy governing the classification of all knowledge assets within the firm. Defines practice area nodes, sub-practice nodes, jurisdiction nodes, matter type nodes, and topic tags used for NLP-driven retrieval and knowledge graph navigation. Managed by the Knowledge Management team and applied consistently across precedents, practice notes, clause libraries, and research memos.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ADD CONSTRAINT `fk_knowledge_knowledge_asset_external_source_id` FOREIGN KEY (`external_source_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`external_source`(`external_source_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ADD CONSTRAINT `fk_knowledge_knowledge_asset_parent_knowledge_asset_id` FOREIGN KEY (`parent_knowledge_asset_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`knowledge_asset`(`knowledge_asset_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ADD CONSTRAINT `fk_knowledge_knowledge_asset_taxonomy_id` FOREIGN KEY (`taxonomy_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`taxonomy`(`taxonomy_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`asset_usage` ADD CONSTRAINT `fk_knowledge_asset_usage_knowledge_asset_id` FOREIGN KEY (`knowledge_asset_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`knowledge_asset`(`knowledge_asset_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`asset_usage` ADD CONSTRAINT `fk_knowledge_asset_usage_tertiary_knowledge_asset_id` FOREIGN KEY (`tertiary_knowledge_asset_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`knowledge_asset`(`knowledge_asset_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ADD CONSTRAINT `fk_knowledge_precedent_update_legal_update_id` FOREIGN KEY (`legal_update_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`legal_update`(`legal_update_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ADD CONSTRAINT `fk_knowledge_precedent_update_precedent_id` FOREIGN KEY (`precedent_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`precedent`(`precedent_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ADD CONSTRAINT `fk_knowledge_contribution_knowledge_asset_id` FOREIGN KEY (`knowledge_asset_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`knowledge_asset`(`knowledge_asset_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ADD CONSTRAINT `fk_knowledge_contribution_supersedes_contribution_id` FOREIGN KEY (`supersedes_contribution_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`contribution`(`contribution_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ADD CONSTRAINT `fk_knowledge_research_request_external_source_id` FOREIGN KEY (`external_source_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`external_source`(`external_source_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ADD CONSTRAINT `fk_knowledge_research_request_precedent_id` FOREIGN KEY (`precedent_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`precedent`(`precedent_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ADD CONSTRAINT `fk_knowledge_research_request_knowledge_asset_id` FOREIGN KEY (`knowledge_asset_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`knowledge_asset`(`knowledge_asset_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ADD CONSTRAINT `fk_knowledge_research_request_research_memo_id` FOREIGN KEY (`research_memo_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`research_memo`(`research_memo_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ADD CONSTRAINT `fk_knowledge_research_request_resulting_research_memo_id` FOREIGN KEY (`resulting_research_memo_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`research_memo`(`research_memo_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ADD CONSTRAINT `fk_knowledge_legal_update_external_source_id` FOREIGN KEY (`external_source_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`external_source`(`external_source_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ADD CONSTRAINT `fk_knowledge_legal_update_knowledge_asset_id` FOREIGN KEY (`knowledge_asset_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`knowledge_asset`(`knowledge_asset_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ADD CONSTRAINT `fk_knowledge_legal_update_precedent_id` FOREIGN KEY (`precedent_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`precedent`(`precedent_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ADD CONSTRAINT `fk_knowledge_legal_update_taxonomy_id` FOREIGN KEY (`taxonomy_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`taxonomy`(`taxonomy_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`impact_assessment` ADD CONSTRAINT `fk_knowledge_impact_assessment_legal_update_id` FOREIGN KEY (`legal_update_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`legal_update`(`legal_update_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`impact_assessment` ADD CONSTRAINT `fk_knowledge_impact_assessment_practice_note_id` FOREIGN KEY (`practice_note_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`practice_note`(`practice_note_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_impact_assessment` ADD CONSTRAINT `fk_knowledge_precedent_impact_assessment_legal_update_id` FOREIGN KEY (`legal_update_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`legal_update`(`legal_update_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_impact_assessment` ADD CONSTRAINT `fk_knowledge_precedent_impact_assessment_precedent_id` FOREIGN KEY (`precedent_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`precedent`(`precedent_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`control_mapping` ADD CONSTRAINT `fk_knowledge_control_mapping_knowledge_asset_id` FOREIGN KEY (`knowledge_asset_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`knowledge_asset`(`knowledge_asset_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_risk_mitigation` ADD CONSTRAINT `fk_knowledge_precedent_risk_mitigation_precedent_id` FOREIGN KEY (`precedent_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`precedent`(`precedent_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ADD CONSTRAINT `fk_knowledge_precedent_parent_precedent_id` FOREIGN KEY (`parent_precedent_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`precedent`(`precedent_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ADD CONSTRAINT `fk_knowledge_precedent_knowledge_asset_id` FOREIGN KEY (`knowledge_asset_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`knowledge_asset`(`knowledge_asset_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ADD CONSTRAINT `fk_knowledge_precedent_taxonomy_id` FOREIGN KEY (`taxonomy_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`taxonomy`(`taxonomy_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ADD CONSTRAINT `fk_knowledge_precedent_to_knowledge_asset_id` FOREIGN KEY (`to_knowledge_asset_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`knowledge_asset`(`knowledge_asset_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ADD CONSTRAINT `fk_knowledge_practice_note_knowledge_asset_id` FOREIGN KEY (`knowledge_asset_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`knowledge_asset`(`knowledge_asset_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ADD CONSTRAINT `fk_knowledge_practice_note_superseded_by_practice_note_id` FOREIGN KEY (`superseded_by_practice_note_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`practice_note`(`practice_note_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ADD CONSTRAINT `fk_knowledge_practice_note_taxonomy_id` FOREIGN KEY (`taxonomy_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`taxonomy`(`taxonomy_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ADD CONSTRAINT `fk_knowledge_practice_note_to_knowledge_asset_id` FOREIGN KEY (`to_knowledge_asset_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`knowledge_asset`(`knowledge_asset_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ADD CONSTRAINT `fk_knowledge_clause_knowledge_asset_id` FOREIGN KEY (`knowledge_asset_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`knowledge_asset`(`knowledge_asset_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ADD CONSTRAINT `fk_knowledge_clause_taxonomy_id` FOREIGN KEY (`taxonomy_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`taxonomy`(`taxonomy_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ADD CONSTRAINT `fk_knowledge_clause_to_knowledge_asset_id` FOREIGN KEY (`to_knowledge_asset_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`knowledge_asset`(`knowledge_asset_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` ADD CONSTRAINT `fk_knowledge_form_template_knowledge_asset_id` FOREIGN KEY (`knowledge_asset_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`knowledge_asset`(`knowledge_asset_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` ADD CONSTRAINT `fk_knowledge_form_template_taxonomy_id` FOREIGN KEY (`taxonomy_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`taxonomy`(`taxonomy_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` ADD CONSTRAINT `fk_knowledge_form_template_to_knowledge_asset_id` FOREIGN KEY (`to_knowledge_asset_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`knowledge_asset`(`knowledge_asset_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`checklist` ADD CONSTRAINT `fk_knowledge_checklist_parent_checklist_id` FOREIGN KEY (`parent_checklist_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`checklist`(`checklist_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`checklist` ADD CONSTRAINT `fk_knowledge_checklist_knowledge_asset_id` FOREIGN KEY (`knowledge_asset_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`knowledge_asset`(`knowledge_asset_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`checklist` ADD CONSTRAINT `fk_knowledge_checklist_taxonomy_id` FOREIGN KEY (`taxonomy_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`taxonomy`(`taxonomy_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`checklist` ADD CONSTRAINT `fk_knowledge_checklist_to_knowledge_asset_id` FOREIGN KEY (`to_knowledge_asset_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`knowledge_asset`(`knowledge_asset_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ADD CONSTRAINT `fk_knowledge_research_memo_knowledge_asset_id` FOREIGN KEY (`knowledge_asset_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`knowledge_asset`(`knowledge_asset_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ADD CONSTRAINT `fk_knowledge_research_memo_taxonomy_id` FOREIGN KEY (`taxonomy_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`taxonomy`(`taxonomy_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ADD CONSTRAINT `fk_knowledge_research_memo_to_knowledge_asset_id` FOREIGN KEY (`to_knowledge_asset_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`knowledge_asset`(`knowledge_asset_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` ADD CONSTRAINT `fk_knowledge_taxonomy_parent_taxonomy_id` FOREIGN KEY (`parent_taxonomy_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`taxonomy`(`taxonomy_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` ADD CONSTRAINT `fk_knowledge_taxonomy_primary_replacement_taxonomy_id` FOREIGN KEY (`primary_replacement_taxonomy_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`taxonomy`(`taxonomy_id`);

-- ========= TAGS =========
ALTER SCHEMA `legal_ecm_v1`.`knowledge` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `legal_ecm_v1`.`knowledge` SET TAGS ('dbx_domain' = 'knowledge');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`expertise_directory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`expertise_directory` ALTER COLUMN `expertise_directory_id` SET TAGS ('dbx_business_glossary_term' = 'Expertise Directory ID');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`expertise_directory` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Attorney Profile Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`expertise_directory` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper ID');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`expertise_directory` ALTER COLUMN `cle_hours_completed` SET TAGS ('dbx_business_glossary_term' = 'Continuing Legal Education (CLE) Hours Completed');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`expertise_directory` ALTER COLUMN `client_feedback_score` SET TAGS ('dbx_business_glossary_term' = 'Client Feedback Score');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`expertise_directory` ALTER COLUMN `cpd_hours_completed` SET TAGS ('dbx_business_glossary_term' = 'Continuing Professional Development (CPD) Hours Completed');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`expertise_directory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`expertise_directory` ALTER COLUMN `expert_identification_rank` SET TAGS ('dbx_business_glossary_term' = 'Expert Identification Rank');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`expertise_directory` ALTER COLUMN `expertise_level` SET TAGS ('dbx_business_glossary_term' = 'Expertise Level');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`expertise_directory` ALTER COLUMN `expertise_level` SET TAGS ('dbx_value_regex' = 'junior|mid_level|senior|expert|thought_leader');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`expertise_directory` ALTER COLUMN `expertise_taxonomy_alignment` SET TAGS ('dbx_business_glossary_term' = 'Expertise Taxonomy Alignment');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`expertise_directory` ALTER COLUMN `expertise_to_taxonomy` SET TAGS ('dbx_business_glossary_term' = 'Expertise To Taxonomy');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`expertise_directory` ALTER COLUMN `industry_sector_expertise` SET TAGS ('dbx_business_glossary_term' = 'Industry Sector Expertise');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`expertise_directory` ALTER COLUMN `jurisdiction_admissions` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Admissions');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`expertise_directory` ALTER COLUMN `knowledge_asset_count` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Asset Count');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`expertise_directory` ALTER COLUMN `language_capabilities` SET TAGS ('dbx_business_glossary_term' = 'Language Capabilities');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`expertise_directory` ALTER COLUMN `last_cle_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Last Continuing Legal Education (CLE) Completion Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`expertise_directory` ALTER COLUMN `last_profile_update_date` SET TAGS ('dbx_business_glossary_term' = 'Last Profile Update Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`expertise_directory` ALTER COLUMN `matter_staffing_score` SET TAGS ('dbx_business_glossary_term' = 'Matter Staffing Score');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`expertise_directory` ALTER COLUMN `matter_type_expertise` SET TAGS ('dbx_business_glossary_term' = 'Matter Type Expertise');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`expertise_directory` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`expertise_directory` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`expertise_directory` ALTER COLUMN `nlp_expertise_tags` SET TAGS ('dbx_business_glossary_term' = 'Natural Language Processing (NLP) Expertise Tags');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`expertise_directory` ALTER COLUMN `notable_matters` SET TAGS ('dbx_business_glossary_term' = 'Notable Matters');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`expertise_directory` ALTER COLUMN `peer_recognition_score` SET TAGS ('dbx_business_glossary_term' = 'Peer Recognition Score');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`expertise_directory` ALTER COLUMN `primary_practice_area` SET TAGS ('dbx_business_glossary_term' = 'Primary Practice Area');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`expertise_directory` ALTER COLUMN `professional_certifications` SET TAGS ('dbx_business_glossary_term' = 'Professional Certifications');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`expertise_directory` ALTER COLUMN `profile_completeness_percentage` SET TAGS ('dbx_business_glossary_term' = 'Profile Completeness Percentage');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`expertise_directory` ALTER COLUMN `profile_description` SET TAGS ('dbx_business_glossary_term' = 'Profile Description');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`expertise_directory` ALTER COLUMN `profile_name` SET TAGS ('dbx_business_glossary_term' = 'Expertise Profile Name');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`expertise_directory` ALTER COLUMN `profile_status` SET TAGS ('dbx_business_glossary_term' = 'Profile Status');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`expertise_directory` ALTER COLUMN `profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_review|archived');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`expertise_directory` ALTER COLUMN `profile_visibility` SET TAGS ('dbx_business_glossary_term' = 'Profile Visibility');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`expertise_directory` ALTER COLUMN `profile_visibility` SET TAGS ('dbx_value_regex' = 'public|internal|restricted|private');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`expertise_directory` ALTER COLUMN `publication_count` SET TAGS ('dbx_business_glossary_term' = 'Publication Count');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`expertise_directory` ALTER COLUMN `recent_publications` SET TAGS ('dbx_business_glossary_term' = 'Recent Publications');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`expertise_directory` ALTER COLUMN `secondary_practice_areas` SET TAGS ('dbx_business_glossary_term' = 'Secondary Practice Areas');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`expertise_directory` ALTER COLUMN `source_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Source Reference ID');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`expertise_directory` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`expertise_directory` ALTER COLUMN `speaking_engagement_count` SET TAGS ('dbx_business_glossary_term' = 'Speaking Engagement Count');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`expertise_directory` ALTER COLUMN `transaction_type_expertise` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type Expertise');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`expertise_directory` ALTER COLUMN `years_of_experience` SET TAGS ('dbx_business_glossary_term' = 'Years of Legal Experience');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ALTER COLUMN `knowledge_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Asset ID');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ALTER COLUMN `external_source_id` SET TAGS ('dbx_business_glossary_term' = 'External Source Id');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ALTER COLUMN `parent_knowledge_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Knowledge Asset ID');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Timekeeper ID');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ALTER COLUMN `taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Taxonomy Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ALTER COLUMN `access_classification` SET TAGS ('dbx_business_glossary_term' = 'Access Classification Level');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ALTER COLUMN `access_classification` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ALTER COLUMN `approval_outcome` SET TAGS ('dbx_business_glossary_term' = 'Approval Outcome');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ALTER COLUMN `approval_outcome` SET TAGS ('dbx_value_regex' = 'approved|rejected|conditional_approval');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ALTER COLUMN `asset_code` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Asset Code');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ALTER COLUMN `asset_code` SET TAGS ('dbx_value_regex' = '^KA-[A-Z]{2,4}-[0-9]{6}$');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ALTER COLUMN `asset_name` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Asset Name');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ALTER COLUMN `asset_taxonomy_node` SET TAGS ('dbx_business_glossary_term' = 'Asset Taxonomy Node');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Asset Type');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ALTER COLUMN `is_lpp_protected` SET TAGS ('dbx_business_glossary_term' = 'Legal Professional Privilege (LPP) Protected Flag');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ALTER COLUMN `is_template` SET TAGS ('dbx_business_glossary_term' = 'Template Flag');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ALTER COLUMN `is_work_product` SET TAGS ('dbx_business_glossary_term' = 'Attorney Work Product Flag');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ALTER COLUMN `knowledge_asset_description` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Asset Description');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ALTER COLUMN `last_used_date` SET TAGS ('dbx_business_glossary_term' = 'Last Used Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ALTER COLUMN `matter_type` SET TAGS ('dbx_business_glossary_term' = 'Matter Type');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Review Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ALTER COLUMN `nlp_embedding_version` SET TAGS ('dbx_business_glossary_term' = 'Natural Language Processing (NLP) Embedding Version');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ALTER COLUMN `retention_schedule` SET TAGS ('dbx_business_glossary_term' = 'Retention Schedule');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ALTER COLUMN `retention_schedule` SET TAGS ('dbx_value_regex' = 'permanent|7_years|10_years|matter_plus_7|regulatory_hold|custom');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'pending|in_review|approved|rejected|revision_requested');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ALTER COLUMN `source_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Reference ID');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ALTER COLUMN `taxonomy_tags` SET TAGS ('dbx_business_glossary_term' = 'Taxonomy Tags');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ALTER COLUMN `usage_notes` SET TAGS ('dbx_business_glossary_term' = 'Usage Notes');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`asset_usage` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`asset_usage` ALTER COLUMN `asset_usage_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Usage ID');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`asset_usage` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Document ID');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`asset_usage` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`asset_usage` ALTER COLUMN `knowledge_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Asset ID');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`asset_usage` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`asset_usage` ALTER COLUMN `tertiary_knowledge_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Tertiary Knowledge Asset Id');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`asset_usage` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper ID');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`asset_usage` ALTER COLUMN `access_method` SET TAGS ('dbx_business_glossary_term' = 'Access Method');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`asset_usage` ALTER COLUMN `adaptation_type` SET TAGS ('dbx_business_glossary_term' = 'Adaptation Type');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`asset_usage` ALTER COLUMN `adaptation_type` SET TAGS ('dbx_value_regex' = 'minor_edit|substantial_revision|clause_extraction|template_customization|translation|none');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`asset_usage` ALTER COLUMN `billable_flag` SET TAGS ('dbx_business_glossary_term' = 'Billable Flag');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`asset_usage` ALTER COLUMN `citation_location` SET TAGS ('dbx_business_glossary_term' = 'Citation Location');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`asset_usage` ALTER COLUMN `cost_savings_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Savings Amount');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`asset_usage` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`asset_usage` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`asset_usage` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`asset_usage` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|laptop|tablet|mobile|other');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`asset_usage` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Duration Seconds');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`asset_usage` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`asset_usage` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`asset_usage` ALTER COLUMN `feedback_comment` SET TAGS ('dbx_business_glossary_term' = 'Feedback Comment');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`asset_usage` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`asset_usage` ALTER COLUMN `ip_address` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`asset_usage` ALTER COLUMN `ip_address` SET TAGS ('dbx_dbx_pii_ip' = 'true');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`asset_usage` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`asset_usage` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`asset_usage` ALTER COLUMN `practice_area` SET TAGS ('dbx_business_glossary_term' = 'Practice Area');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`asset_usage` ALTER COLUMN `relevance_rating` SET TAGS ('dbx_business_glossary_term' = 'Relevance Rating');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`asset_usage` ALTER COLUMN `search_query` SET TAGS ('dbx_business_glossary_term' = 'Search Query');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`asset_usage` ALTER COLUMN `session_code` SET TAGS ('dbx_business_glossary_term' = 'Session ID');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`asset_usage` ALTER COLUMN `source_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Source Reference ID');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`asset_usage` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`asset_usage` ALTER COLUMN `time_saved_minutes` SET TAGS ('dbx_business_glossary_term' = 'Time Saved Minutes');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`asset_usage` ALTER COLUMN `usage_context` SET TAGS ('dbx_business_glossary_term' = 'Usage Context');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`asset_usage` ALTER COLUMN `usage_status` SET TAGS ('dbx_business_glossary_term' = 'Usage Status');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`asset_usage` ALTER COLUMN `usage_status` SET TAGS ('dbx_value_regex' = 'completed|in_progress|abandoned|failed');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`asset_usage` ALTER COLUMN `usage_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Usage Timestamp');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`asset_usage` ALTER COLUMN `usage_type` SET TAGS ('dbx_business_glossary_term' = 'Usage Type');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`asset_usage` ALTER COLUMN `usage_type` SET TAGS ('dbx_value_regex' = 'view|download|adapt|cite|apply|link');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ALTER COLUMN `precedent_update_id` SET TAGS ('dbx_business_glossary_term' = 'Precedent Update ID');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Document Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ALTER COLUMN `legal_update_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Update Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ALTER COLUMN `precedent_id` SET TAGS ('dbx_business_glossary_term' = 'Precedent ID');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ALTER COLUMN `primary_precedent_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer ID');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ALTER COLUMN `regulatory_change_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ALTER COLUMN `change_detail` SET TAGS ('dbx_business_glossary_term' = 'Change Detail');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ALTER COLUMN `change_summary` SET TAGS ('dbx_business_glossary_term' = 'Change Summary');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ALTER COLUMN `impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ALTER COLUMN `impact_assessment` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ALTER COLUMN `matter_type` SET TAGS ('dbx_business_glossary_term' = 'Matter Type');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ALTER COLUMN `new_version_number` SET TAGS ('dbx_business_glossary_term' = 'New Version Number');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Notification Method');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ALTER COLUMN `notification_method` SET TAGS ('dbx_value_regex' = 'email|intranet|knowledge_portal|practice_group_meeting|all_hands');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ALTER COLUMN `notification_sent` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ALTER COLUMN `practice_area` SET TAGS ('dbx_business_glossary_term' = 'Practice Area');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ALTER COLUMN `previous_version_number` SET TAGS ('dbx_business_glossary_term' = 'Previous Version Number');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ALTER COLUMN `rejection_date` SET TAGS ('dbx_business_glossary_term' = 'Rejection Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ALTER COLUMN `review_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completed Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ALTER COLUMN `review_initiated_by` SET TAGS ('dbx_business_glossary_term' = 'Review Initiated By');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ALTER COLUMN `review_initiated_date` SET TAGS ('dbx_business_glossary_term' = 'Review Initiated Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ALTER COLUMN `reviewer_practice_area` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Practice Area');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ALTER COLUMN `sections_modified` SET TAGS ('dbx_business_glossary_term' = 'Sections Modified');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ALTER COLUMN `source_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Source Reference ID');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ALTER COLUMN `superseded_date` SET TAGS ('dbx_business_glossary_term' = 'Superseded Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ALTER COLUMN `triggering_event` SET TAGS ('dbx_business_glossary_term' = 'Triggering Event');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ALTER COLUMN `triggering_event_date` SET TAGS ('dbx_business_glossary_term' = 'Triggering Event Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ALTER COLUMN `triggering_event_type` SET TAGS ('dbx_business_glossary_term' = 'Triggering Event Type');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ALTER COLUMN `triggering_event_type` SET TAGS ('dbx_value_regex' = 'legislative_change|case_law_development|regulatory_update|client_feedback|internal_review|market_practice_change');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ALTER COLUMN `update_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Update Reference Number');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ALTER COLUMN `update_status` SET TAGS ('dbx_business_glossary_term' = 'Update Status');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ALTER COLUMN `update_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|published|rejected|superseded');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ALTER COLUMN `update_type` SET TAGS ('dbx_business_glossary_term' = 'Update Type');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ALTER COLUMN `update_type` SET TAGS ('dbx_value_regex' = 'major_revision|minor_revision|technical_correction|regulatory_update|case_law_update|legislative_change');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ALTER COLUMN `contribution_id` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Contribution Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Contributor Timekeeper Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ALTER COLUMN `knowledge_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Asset Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Source Client Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ALTER COLUMN `reviewer_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Timekeeper Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Source Matter Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ALTER COLUMN `supersedes_contribution_id` SET TAGS ('dbx_business_glossary_term' = 'Supersedes Contribution Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ALTER COLUMN `approval_outcome` SET TAGS ('dbx_business_glossary_term' = 'Approval Outcome');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ALTER COLUMN `approval_outcome` SET TAGS ('dbx_value_regex' = 'approved|rejected|conditional_approval');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ALTER COLUMN `cle_credit_eligible` SET TAGS ('dbx_business_glossary_term' = 'Continuing Legal Education (CLE) Credit Eligible');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ALTER COLUMN `cle_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Continuing Legal Education (CLE) Credit Hours');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ALTER COLUMN `contribution_type` SET TAGS ('dbx_business_glossary_term' = 'Contribution Type');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ALTER COLUMN `contribution_type` SET TAGS ('dbx_value_regex' = 'precedent|practice_note|research_memo|clause_variant|form_template|checklist');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ALTER COLUMN `contributor_notes` SET TAGS ('dbx_business_glossary_term' = 'Contributor Notes');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ALTER COLUMN `cpd_credit_eligible` SET TAGS ('dbx_business_glossary_term' = 'Continuing Professional Development (CPD) Credit Eligible');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ALTER COLUMN `cpd_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Continuing Professional Development (CPD) Credit Hours');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ALTER COLUMN `document_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Document Reference Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ALTER COLUMN `innovation_flag` SET TAGS ('dbx_business_glossary_term' = 'Innovation Flag');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ALTER COLUMN `is_cpd_eligible` SET TAGS ('dbx_business_glossary_term' = 'Continuing Professional Development (CPD) Eligible Flag');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ALTER COLUMN `last_used_date` SET TAGS ('dbx_business_glossary_term' = 'Last Used Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ALTER COLUMN `matter_type` SET TAGS ('dbx_business_glossary_term' = 'Matter Type');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ALTER COLUMN `practice_area` SET TAGS ('dbx_business_glossary_term' = 'Practice Area');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ALTER COLUMN `published_date` SET TAGS ('dbx_business_glossary_term' = 'Published Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ALTER COLUMN `quality_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Score');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ALTER COLUMN `review_assigned_date` SET TAGS ('dbx_business_glossary_term' = 'Review Assigned Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ALTER COLUMN `review_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completed Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'pending|under_review|approved|rejected|revision_requested|withdrawn');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ALTER COLUMN `reviewer_comments` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Comments');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ALTER COLUMN `source_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Source Reference Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ALTER COLUMN `taxonomy_tags` SET TAGS ('dbx_business_glossary_term' = 'Taxonomy Tags');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ALTER COLUMN `research_request_id` SET TAGS ('dbx_business_glossary_term' = 'Research Request ID');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ALTER COLUMN `external_source_id` SET TAGS ('dbx_business_glossary_term' = 'External Source Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ALTER COLUMN `precedent_id` SET TAGS ('dbx_business_glossary_term' = 'Identified Precedent Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ALTER COLUMN `knowledge_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Asset ID');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Researcher ID');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ALTER COLUMN `research_memo_id` SET TAGS ('dbx_business_glossary_term' = 'Research Memo Id');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ALTER COLUMN `research_memo_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ALTER COLUMN `resulting_research_memo_id` SET TAGS ('dbx_business_glossary_term' = 'Research Request To Resulting Memo');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ALTER COLUMN `reviewer_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer ID');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ALTER COLUMN `actual_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Hours');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ALTER COLUMN `assigned_date` SET TAGS ('dbx_business_glossary_term' = 'Assigned Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ALTER COLUMN `client_billable_flag` SET TAGS ('dbx_business_glossary_term' = 'Client Billable Flag');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ALTER COLUMN `completed_date` SET TAGS ('dbx_business_glossary_term' = 'Completed Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ALTER COLUMN `estimated_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Hours');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ALTER COLUMN `key_terms` SET TAGS ('dbx_business_glossary_term' = 'Key Terms');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ALTER COLUMN `practice_area` SET TAGS ('dbx_business_glossary_term' = 'Practice Area');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ALTER COLUMN `practice_area` SET TAGS ('dbx_value_regex' = 'corporate|litigation|intellectual_property|employment|regulatory_compliance|real_estate');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ALTER COLUMN `quality_review_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Review Flag');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ALTER COLUMN `related_case_law` SET TAGS ('dbx_business_glossary_term' = 'Related Case Law');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ALTER COLUMN `related_statutes` SET TAGS ('dbx_business_glossary_term' = 'Related Statutes');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Research Request Number');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Request Status');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ALTER COLUMN `request_status` SET TAGS ('dbx_value_regex' = 'submitted|assigned|in_progress|completed|cancelled|on_hold');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ALTER COLUMN `request_title` SET TAGS ('dbx_business_glossary_term' = 'Research Request Title');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ALTER COLUMN `request_type` SET TAGS ('dbx_business_glossary_term' = 'Request Type');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ALTER COLUMN `request_type` SET TAGS ('dbx_value_regex' = 'case_law|statutory|regulatory|transactional|comparative|memorandum');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ALTER COLUMN `requested_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ALTER COLUMN `requesting_department` SET TAGS ('dbx_business_glossary_term' = 'Requesting Department');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ALTER COLUMN `research_notes` SET TAGS ('dbx_business_glossary_term' = 'Research Notes');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ALTER COLUMN `research_question` SET TAGS ('dbx_business_glossary_term' = 'Research Question');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ALTER COLUMN `research_question` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ALTER COLUMN `research_scope` SET TAGS ('dbx_business_glossary_term' = 'Research Scope');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ALTER COLUMN `source_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Source Reference ID');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ALTER COLUMN `urgency_level` SET TAGS ('dbx_business_glossary_term' = 'Urgency Level');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ALTER COLUMN `urgency_level` SET TAGS ('dbx_value_regex' = 'routine|standard|urgent|critical');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `external_source_id` SET TAGS ('dbx_business_glossary_term' = 'External Source Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `access_url` SET TAGS ('dbx_business_glossary_term' = 'Access Uniform Resource Locator (URL)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `annual_cost` SET TAGS ('dbx_business_glossary_term' = 'Annual Cost');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `annual_cost` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `api_endpoint_url` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Endpoint Uniform Resource Locator (URL)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `api_endpoint_url` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `api_integration_status` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Integration Status');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `api_integration_status` SET TAGS ('dbx_value_regex' = 'integrated|not_integrated|in_progress|deprecated|planned');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `authentication_method` SET TAGS ('dbx_business_glossary_term' = 'Authentication Method');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `authentication_method` SET TAGS ('dbx_value_regex' = 'oauth|api_key|saml|basic_auth|certificate|none');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `content_categories` SET TAGS ('dbx_business_glossary_term' = 'Content Categories');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `cost_centre_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Code');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `coverage_jurisdictions` SET TAGS ('dbx_business_glossary_term' = 'Coverage Jurisdictions');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `data_classification_level` SET TAGS ('dbx_business_glossary_term' = 'Data Classification Level');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `data_classification_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `external_source_description` SET TAGS ('dbx_business_glossary_term' = 'Source Description');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `gdpr_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Compliant Flag');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `last_usage_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Usage Audit Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `licensed_user_count` SET TAGS ('dbx_business_glossary_term' = 'Licensed User Count');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `next_compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Compliance Review Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_dbx_pii_email' = 'true');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_dbx_pii_identifier' = 'true');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `sla_uptime_percentage` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Uptime Percentage');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `source_code` SET TAGS ('dbx_business_glossary_term' = 'Source Code');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `source_name` SET TAGS ('dbx_business_glossary_term' = 'Source Name');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `source_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Source Reference Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `source_type` SET TAGS ('dbx_business_glossary_term' = 'Source Type');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `subscription_status` SET TAGS ('dbx_business_glossary_term' = 'Subscription Status');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `subscription_status` SET TAGS ('dbx_value_regex' = 'active|suspended|expired|trial|pending_renewal|cancelled');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `subscription_tier` SET TAGS ('dbx_business_glossary_term' = 'Subscription Tier');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `usage_notes` SET TAGS ('dbx_business_glossary_term' = 'Usage Notes');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `usage_tracking_enabled` SET TAGS ('dbx_business_glossary_term' = 'Usage Tracking Enabled Flag');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `vendor_account_manager` SET TAGS ('dbx_business_glossary_term' = 'Vendor Account Manager');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `vendor_support_email` SET TAGS ('dbx_business_glossary_term' = 'Vendor Support Email Address');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `vendor_support_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `vendor_support_email` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `vendor_support_email` SET TAGS ('dbx_dbx_pii_email' = 'true');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `vendor_support_phone` SET TAGS ('dbx_business_glossary_term' = 'Vendor Support Phone Number');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `vendor_support_phone` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ALTER COLUMN `vendor_support_phone` SET TAGS ('dbx_dbx_pii_phone' = 'true');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ALTER COLUMN `legal_update_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Update Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Knowledge Manager Timekeeper Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ALTER COLUMN `external_source_id` SET TAGS ('dbx_business_glossary_term' = 'External Source Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ALTER COLUMN `knowledge_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Asset Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ALTER COLUMN `precedent_id` SET TAGS ('dbx_business_glossary_term' = 'Precedent Id');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ALTER COLUMN `regulatory_change_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ALTER COLUMN `taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Taxonomy Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ALTER COLUMN `access_level` SET TAGS ('dbx_business_glossary_term' = 'Access Level');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ALTER COLUMN `access_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ALTER COLUMN `client_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Client Notification Required Flag');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ALTER COLUMN `impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ALTER COLUMN `impacted_checklists` SET TAGS ('dbx_business_glossary_term' = 'Impacted Checklists');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ALTER COLUMN `impacted_practice_notes` SET TAGS ('dbx_business_glossary_term' = 'Impacted Practice Notes');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ALTER COLUMN `impacted_precedents` SET TAGS ('dbx_business_glossary_term' = 'Impacted Precedents');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Keywords');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ALTER COLUMN `multi_jurisdiction_flag` SET TAGS ('dbx_business_glossary_term' = 'Multi-Jurisdiction Flag');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ALTER COLUMN `notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ALTER COLUMN `related_matters` SET TAGS ('dbx_business_glossary_term' = 'Related Matters');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ALTER COLUMN `review_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ALTER COLUMN `review_priority` SET TAGS ('dbx_business_glossary_term' = 'Review Priority');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ALTER COLUMN `review_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ALTER COLUMN `review_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Start Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'pending|in_review|approved|published|archived');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ALTER COLUMN `source_citation` SET TAGS ('dbx_business_glossary_term' = 'Source Citation');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ALTER COLUMN `source_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Source Reference Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ALTER COLUMN `source_type` SET TAGS ('dbx_business_glossary_term' = 'Source Type');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ALTER COLUMN `source_type` SET TAGS ('dbx_value_regex' = 'lexisnexis|practical_law|official_gazette|court_registry|regulatory_agency|industry_publication');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ALTER COLUMN `source_url` SET TAGS ('dbx_business_glossary_term' = 'Source Uniform Resource Locator (URL)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ALTER COLUMN `summary` SET TAGS ('dbx_business_glossary_term' = 'Legal Update Summary');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ALTER COLUMN `taxonomy_tags` SET TAGS ('dbx_business_glossary_term' = 'Taxonomy Tags');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ALTER COLUMN `to_taxonomy` SET TAGS ('dbx_business_glossary_term' = 'To Taxonomy');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ALTER COLUMN `update_number` SET TAGS ('dbx_business_glossary_term' = 'Legal Update Number');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ALTER COLUMN `update_title` SET TAGS ('dbx_business_glossary_term' = 'Legal Update Title');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ALTER COLUMN `update_to_taxonomy` SET TAGS ('dbx_business_glossary_term' = 'Update To Taxonomy');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ALTER COLUMN `update_type` SET TAGS ('dbx_business_glossary_term' = 'Legal Update Type');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ALTER COLUMN `update_type` SET TAGS ('dbx_value_regex' = 'statute_amendment|new_regulation|landmark_judgment|regulatory_guidance|case_law_development|legislative_change');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`impact_assessment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`impact_assessment` ALTER COLUMN `impact_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment Identifier');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`impact_assessment` ALTER COLUMN `legal_update_id` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment - Legal Update Id');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`impact_assessment` ALTER COLUMN `practice_note_id` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment - Practice Note Id');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`impact_assessment` ALTER COLUMN `action_taken` SET TAGS ('dbx_business_glossary_term' = 'Action Taken');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`impact_assessment` ALTER COLUMN `assigned_knowledge_manager` SET TAGS ('dbx_business_glossary_term' = 'Assigned Knowledge Manager');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`impact_assessment` ALTER COLUMN `content_sections_modified` SET TAGS ('dbx_business_glossary_term' = 'Content Sections Modified');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`impact_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`impact_assessment` ALTER COLUMN `impact_assessment_text` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`impact_assessment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`impact_assessment` ALTER COLUMN `review_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`impact_assessment` ALTER COLUMN `review_priority` SET TAGS ('dbx_business_glossary_term' = 'Review Priority');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`impact_assessment` ALTER COLUMN `review_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Start Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`impact_assessment` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_impact_assessment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_impact_assessment` ALTER COLUMN `precedent_impact_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Precedent Impact Assessment ID');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_impact_assessment` ALTER COLUMN `legal_update_id` SET TAGS ('dbx_business_glossary_term' = 'Precedent Impact Assessment - Legal Update Id');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_impact_assessment` ALTER COLUMN `precedent_id` SET TAGS ('dbx_business_glossary_term' = 'Precedent Impact Assessment - Precedent Id');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_impact_assessment` ALTER COLUMN `action_taken` SET TAGS ('dbx_business_glossary_term' = 'Action Taken');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_impact_assessment` ALTER COLUMN `assigned_knowledge_manager` SET TAGS ('dbx_business_glossary_term' = 'Assigned Knowledge Manager');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_impact_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_impact_assessment` ALTER COLUMN `impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_impact_assessment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_impact_assessment` ALTER COLUMN `review_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_impact_assessment` ALTER COLUMN `review_priority` SET TAGS ('dbx_business_glossary_term' = 'Review Priority');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_impact_assessment` ALTER COLUMN `review_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Start Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_impact_assessment` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_impact_assessment` ALTER COLUMN `reviewer_notes` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Notes');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_impact_assessment` ALTER COLUMN `sections_modified` SET TAGS ('dbx_business_glossary_term' = 'Sections Modified');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`control_mapping` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`control_mapping` ALTER COLUMN `control_mapping_id` SET TAGS ('dbx_business_glossary_term' = 'Control Mapping Identifier');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`control_mapping` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Control Mapping - Risk Category Id');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`control_mapping` ALTER COLUMN `knowledge_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Control Mapping - Knowledge Asset Id');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`control_mapping` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Mapping Author Timekeeper');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`control_mapping` ALTER COLUMN `applicability_scope` SET TAGS ('dbx_business_glossary_term' = 'Control Applicability Scope');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`control_mapping` ALTER COLUMN `control_mapping_status` SET TAGS ('dbx_business_glossary_term' = 'Control Mapping Status');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`control_mapping` ALTER COLUMN `control_type` SET TAGS ('dbx_business_glossary_term' = 'Control Type Classification');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`control_mapping` ALTER COLUMN `deployment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Control Deployment Frequency');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`control_mapping` ALTER COLUMN `effectiveness_rating` SET TAGS ('dbx_business_glossary_term' = 'Control Effectiveness Rating');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`control_mapping` ALTER COLUMN `last_deployment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Control Deployment Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`control_mapping` ALTER COLUMN `last_effectiveness_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Effectiveness Review Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`control_mapping` ALTER COLUMN `mapped_date` SET TAGS ('dbx_business_glossary_term' = 'Control Mapping Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`control_mapping` ALTER COLUMN `next_effectiveness_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Effectiveness Review Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`control_mapping` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Control Mapping Notes');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`control_mapping` ALTER COLUMN `regulatory_mapping_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Control Mapping Reference');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_risk_mitigation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_risk_mitigation` ALTER COLUMN `precedent_risk_mitigation_id` SET TAGS ('dbx_business_glossary_term' = 'Precedent Risk Mitigation Identifier');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_risk_mitigation` ALTER COLUMN `precedent_id` SET TAGS ('dbx_business_glossary_term' = 'Precedent Risk Mitigation - Precedent Id');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_risk_mitigation` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Precedent Risk Mitigation - Risk Category Id');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_risk_mitigation` ALTER COLUMN `clause_coverage_percentage` SET TAGS ('dbx_business_glossary_term' = 'Clause Coverage Percentage');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_risk_mitigation` ALTER COLUMN `key_mitigating_clauses` SET TAGS ('dbx_business_glossary_term' = 'Key Mitigating Clauses');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_risk_mitigation` ALTER COLUMN `last_risk_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Risk Review Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_risk_mitigation` ALTER COLUMN `mapped_by` SET TAGS ('dbx_business_glossary_term' = 'Mapped By');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_risk_mitigation` ALTER COLUMN `mapped_date` SET TAGS ('dbx_business_glossary_term' = 'Mapped Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_risk_mitigation` ALTER COLUMN `mapping_status` SET TAGS ('dbx_business_glossary_term' = 'Mapping Status');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_risk_mitigation` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_risk_mitigation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Mapping Notes');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_risk_mitigation` ALTER COLUMN `risk_mitigation_effectiveness` SET TAGS ('dbx_business_glossary_term' = 'Risk Mitigation Effectiveness Rating');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_risk_mitigation` ALTER COLUMN `risk_rating_when_used` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating When Used');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_risk_mitigation` ALTER COLUMN `usage_in_risk_context_count` SET TAGS ('dbx_business_glossary_term' = 'Usage in Risk Context Count');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `precedent_id` SET TAGS ('dbx_business_glossary_term' = 'Precedent Identifier');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `parent_precedent_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Precedent Identifier');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `knowledge_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Asset Identifier');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Source Document Identifier');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Taxonomy Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `to_knowledge_asset_id` SET TAGS ('dbx_business_glossary_term' = 'To Knowledge Asset Id');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `access_restriction` SET TAGS ('dbx_business_glossary_term' = 'Access Restriction');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `amendment_summary` SET TAGS ('dbx_business_glossary_term' = 'Amendment Summary');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|archived|deprecated|withdrawn');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `author_name` SET TAGS ('dbx_business_glossary_term' = 'Author Name');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `author_name` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `author_practice_group` SET TAGS ('dbx_business_glossary_term' = 'Author Practice Group');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `document_title` SET TAGS ('dbx_business_glossary_term' = 'Document Title');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `file_format` SET TAGS ('dbx_value_regex' = 'docx|pdf|doc|rtf|txt|html');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `file_size_kb` SET TAGS ('dbx_business_glossary_term' = 'File Size in Kilobytes');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `key_clauses` SET TAGS ('dbx_business_glossary_term' = 'Key Clauses');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Keywords');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Language');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `last_used_date` SET TAGS ('dbx_business_glossary_term' = 'Last Used Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `lpp_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Professional Privilege (LPP) Flag');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `multi_jurisdiction_flag` SET TAGS ('dbx_business_glossary_term' = 'Multi-Jurisdiction Flag');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Page Count');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `precedent_description` SET TAGS ('dbx_business_glossary_term' = 'Precedent Description');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `related_case_law` SET TAGS ('dbx_business_glossary_term' = 'Related Case Law');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `related_legislation` SET TAGS ('dbx_business_glossary_term' = 'Related Legislation');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'imanage_work|thomson_reuters_practical_law|lexisnexis|netdocuments|internal_repository');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `taxonomy_classification` SET TAGS ('dbx_business_glossary_term' = 'Taxonomy Classification');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `triggering_event` SET TAGS ('dbx_business_glossary_term' = 'Triggering Event');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `usage_notes` SET TAGS ('dbx_business_glossary_term' = 'Usage Notes');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ALTER COLUMN `word_count` SET TAGS ('dbx_business_glossary_term' = 'Word Count');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `practice_note_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Note Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Addresses Risk Category Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `knowledge_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Asset Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `superseded_by_practice_note_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Practice Note Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Taxonomy Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `to_knowledge_asset_id` SET TAGS ('dbx_business_glossary_term' = 'To Knowledge Asset Id');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `abstract` SET TAGS ('dbx_business_glossary_term' = 'Abstract Summary');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `access_level` SET TAGS ('dbx_business_glossary_term' = 'Access Level');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `access_level` SET TAGS ('dbx_value_regex' = 'public|internal|restricted|confidential');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `archived_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Archived Timestamp');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `author_email` SET TAGS ('dbx_business_glossary_term' = 'Author Email Address');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `author_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `author_email` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `author_email` SET TAGS ('dbx_dbx_pii_email' = 'true');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `author_name` SET TAGS ('dbx_business_glossary_term' = 'Author Name');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `author_name` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `average_rating` SET TAGS ('dbx_business_glossary_term' = 'Average User Rating');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `case_law_references` SET TAGS ('dbx_business_glossary_term' = 'Case Law References');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `content_type` SET TAGS ('dbx_business_glossary_term' = 'Content Type');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `content_type` SET TAGS ('dbx_value_regex' = 'guidance_note|procedural_checklist|statute_summary|case_law_analysis|regulatory_update|standard_clause');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `contributing_authors` SET TAGS ('dbx_business_glossary_term' = 'Contributing Authors');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `contributing_authors` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `currency_date` SET TAGS ('dbx_business_glossary_term' = 'Currency Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `document_format` SET TAGS ('dbx_business_glossary_term' = 'Document Format');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `document_format` SET TAGS ('dbx_value_regex' = 'pdf|docx|html|markdown|plain_text');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `download_count` SET TAGS ('dbx_business_glossary_term' = 'Download Count');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `external_url` SET TAGS ('dbx_business_glossary_term' = 'External Uniform Resource Locator (URL)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `file_size_kb` SET TAGS ('dbx_business_glossary_term' = 'File Size in Kilobytes (KB)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `full_text_content` SET TAGS ('dbx_business_glossary_term' = 'Full Text Content');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `is_billable_reference` SET TAGS ('dbx_business_glossary_term' = 'Is Billable Reference Flag');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `practice_note_status` SET TAGS ('dbx_business_glossary_term' = 'Practice Note Status');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `practice_note_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|published|archived|superseded');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `rating_count` SET TAGS ('dbx_business_glossary_term' = 'Rating Count');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `regulation_references` SET TAGS ('dbx_business_glossary_term' = 'Regulation References');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `related_practice_notes` SET TAGS ('dbx_business_glossary_term' = 'Related Practice Notes');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `review_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle in Months');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'thomson_reuters_practical_law|lexisnexis|internal_authoring|external_counsel');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `statute_references` SET TAGS ('dbx_business_glossary_term' = 'Statute References');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `taxonomy_classification` SET TAGS ('dbx_business_glossary_term' = 'Taxonomy Classification');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Practice Note Title');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `topic_tags` SET TAGS ('dbx_business_glossary_term' = 'Topic Tags');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ALTER COLUMN `view_count` SET TAGS ('dbx_business_glossary_term' = 'View Count');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ALTER COLUMN `clause_id` SET TAGS ('dbx_business_glossary_term' = 'Clause Identifier');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Timekeeper ID');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ALTER COLUMN `clause_author_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Author Timekeeper ID');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ALTER COLUMN `knowledge_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Asset ID');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Document Management System (DMS) Document ID');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Risk Category Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ALTER COLUMN `taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Taxonomy Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ALTER COLUMN `to_knowledge_asset_id` SET TAGS ('dbx_business_glossary_term' = 'To Knowledge Asset Id');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|deprecated|archived');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ALTER COLUMN `clause_category` SET TAGS ('dbx_business_glossary_term' = 'Clause Category');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ALTER COLUMN `clause_category` SET TAGS ('dbx_value_regex' = 'boilerplate|commercial|risk_allocation|compliance|operational|relationship');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ALTER COLUMN `clause_text` SET TAGS ('dbx_business_glossary_term' = 'Clause Text');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ALTER COLUMN `clause_text` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ALTER COLUMN `clause_type` SET TAGS ('dbx_business_glossary_term' = 'Clause Type');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ALTER COLUMN `clause_type` SET TAGS ('dbx_value_regex' = 'indemnity|limitation_of_liability|governing_law|dispute_resolution|confidentiality|termination');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ALTER COLUMN `clm_system_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Lifecycle Management (CLM) System Reference');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ALTER COLUMN `contract_type_applicability` SET TAGS ('dbx_business_glossary_term' = 'Contract Type Applicability');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ALTER COLUMN `deprecated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deprecated Timestamp');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ALTER COLUMN `fallback_position_text` SET TAGS ('dbx_business_glossary_term' = 'Fallback Position Text');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ALTER COLUMN `fallback_position_text` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ALTER COLUMN `governing_law_reference` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Reference');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ALTER COLUMN `identifier` SET TAGS ('dbx_business_glossary_term' = 'Clause Identifier');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ALTER COLUMN `industry_applicability` SET TAGS ('dbx_business_glossary_term' = 'Industry Applicability');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ALTER COLUMN `is_standard_form` SET TAGS ('dbx_business_glossary_term' = 'Is Standard Form Flag');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ALTER COLUMN `negotiability_flag` SET TAGS ('dbx_business_glossary_term' = 'Negotiability Flag');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ALTER COLUMN `precedent_source` SET TAGS ('dbx_business_glossary_term' = 'Precedent Source');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ALTER COLUMN `regulatory_compliance_tags` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Tags');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ALTER COLUMN `related_clauses` SET TAGS ('dbx_business_glossary_term' = 'Related Clauses');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ALTER COLUMN `semantic_tags` SET TAGS ('dbx_business_glossary_term' = 'Semantic Tags');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Clause Title');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ALTER COLUMN `usage_guidance` SET TAGS ('dbx_business_glossary_term' = 'Usage Guidance');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ALTER COLUMN `variant_label` SET TAGS ('dbx_business_glossary_term' = 'Variant Label');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ALTER COLUMN `word_count` SET TAGS ('dbx_business_glossary_term' = 'Word Count');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` ALTER COLUMN `form_template_id` SET TAGS ('dbx_business_glossary_term' = 'Form Template ID');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Mitigates Risk Category Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` ALTER COLUMN `knowledge_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Knowledge Asset Id');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` ALTER COLUMN `taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Taxonomy Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` ALTER COLUMN `to_knowledge_asset_id` SET TAGS ('dbx_business_glossary_term' = 'To Knowledge Asset Id');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` ALTER COLUMN `applicable_statute` SET TAGS ('dbx_business_glossary_term' = 'Applicable Statute');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` ALTER COLUMN `author_name` SET TAGS ('dbx_business_glossary_term' = 'Author Name');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` ALTER COLUMN `court_tribunal_name` SET TAGS ('dbx_business_glossary_term' = 'Court or Tribunal Name');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` ALTER COLUMN `document_format` SET TAGS ('dbx_business_glossary_term' = 'Document Format');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` ALTER COLUMN `external_reference_url` SET TAGS ('dbx_business_glossary_term' = 'External Reference Uniform Resource Locator (URL)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` ALTER COLUMN `file_path` SET TAGS ('dbx_business_glossary_term' = 'File Path');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` ALTER COLUMN `file_path` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` ALTER COLUMN `filing_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Filing Fee Amount');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` ALTER COLUMN `filing_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Filing Fee Currency');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` ALTER COLUMN `filing_fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` ALTER COLUMN `filing_instructions` SET TAGS ('dbx_business_glossary_term' = 'Filing Instructions');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` ALTER COLUMN `form_category` SET TAGS ('dbx_business_glossary_term' = 'Form Category');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` ALTER COLUMN `form_code` SET TAGS ('dbx_business_glossary_term' = 'Form Code');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` ALTER COLUMN `form_template_status` SET TAGS ('dbx_business_glossary_term' = 'Form Template Status');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` ALTER COLUMN `form_template_status` SET TAGS ('dbx_value_regex' = 'active|draft|archived|superseded|under_review|deprecated');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` ALTER COLUMN `form_title` SET TAGS ('dbx_business_glossary_term' = 'Form Title');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` ALTER COLUMN `form_type` SET TAGS ('dbx_business_glossary_term' = 'Form Type');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` ALTER COLUMN `is_client_facing` SET TAGS ('dbx_business_glossary_term' = 'Is Client Facing');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Is Confidential');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Keywords');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` ALTER COLUMN `last_used_date` SET TAGS ('dbx_business_glossary_term' = 'Last Used Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` ALTER COLUMN `practice_group` SET TAGS ('dbx_business_glossary_term' = 'Practice Group');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` ALTER COLUMN `procedural_requirements` SET TAGS ('dbx_business_glossary_term' = 'Procedural Requirements');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` ALTER COLUMN `required_attachments` SET TAGS ('dbx_business_glossary_term' = 'Required Attachments');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period Years');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'imanage_work|netdocuments|ecf_pacer|thomson_reuters_practical_law|internal_dms|lexisnexis');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`checklist` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`checklist` ALTER COLUMN `checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Checklist Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`checklist` ALTER COLUMN `mitigation_action_id` SET TAGS ('dbx_business_glossary_term' = 'Implements Risk Mitigation Action Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`checklist` ALTER COLUMN `parent_checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Checklist Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`checklist` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`checklist` ALTER COLUMN `knowledge_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Asset Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`checklist` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`checklist` ALTER COLUMN `taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Taxonomy Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`checklist` ALTER COLUMN `to_knowledge_asset_id` SET TAGS ('dbx_business_glossary_term' = 'To Knowledge Asset Id');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`checklist` ALTER COLUMN `access_level` SET TAGS ('dbx_business_glossary_term' = 'Access Level');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`checklist` ALTER COLUMN `access_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`checklist` ALTER COLUMN `author_name` SET TAGS ('dbx_business_glossary_term' = 'Author Name');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`checklist` ALTER COLUMN `checklist_code` SET TAGS ('dbx_business_glossary_term' = 'Checklist Code');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`checklist` ALTER COLUMN `checklist_description` SET TAGS ('dbx_business_glossary_term' = 'Checklist Description');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`checklist` ALTER COLUMN `checklist_name` SET TAGS ('dbx_business_glossary_term' = 'Checklist Name');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`checklist` ALTER COLUMN `checklist_status` SET TAGS ('dbx_business_glossary_term' = 'Checklist Status');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`checklist` ALTER COLUMN `checklist_status` SET TAGS ('dbx_value_regex' = 'draft|active|archived|under_review|deprecated');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`checklist` ALTER COLUMN `checklist_type` SET TAGS ('dbx_business_glossary_term' = 'Checklist Type');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`checklist` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`checklist` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`checklist` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`checklist` ALTER COLUMN `is_template` SET TAGS ('dbx_business_glossary_term' = 'Is Template Flag');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`checklist` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`checklist` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`checklist` ALTER COLUMN `last_used_date` SET TAGS ('dbx_business_glossary_term' = 'Last Used Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`checklist` ALTER COLUMN `mandatory_steps_count` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Steps Count');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`checklist` ALTER COLUMN `matter_type` SET TAGS ('dbx_business_glossary_term' = 'Matter Type');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`checklist` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`checklist` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`checklist` ALTER COLUMN `optional_steps_count` SET TAGS ('dbx_business_glossary_term' = 'Optional Steps Count');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`checklist` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`checklist` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`checklist` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`checklist` ALTER COLUMN `source_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Source Reference Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`checklist` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`checklist` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'thomson_reuters_practical_law|lexisnexis|internal|imanage|custom');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`checklist` ALTER COLUMN `taxonomy_tags` SET TAGS ('dbx_business_glossary_term' = 'Taxonomy Tags');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`checklist` ALTER COLUMN `total_steps` SET TAGS ('dbx_business_glossary_term' = 'Total Steps');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`checklist` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`checklist` ALTER COLUMN `usage_notes` SET TAGS ('dbx_business_glossary_term' = 'Usage Notes');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`checklist` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ALTER COLUMN `research_memo_id` SET TAGS ('dbx_business_glossary_term' = 'Research Memo ID');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ALTER COLUMN `assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Document Management System (DMS) Document ID');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ALTER COLUMN `knowledge_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Asset Id');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Author Timekeeper ID');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ALTER COLUMN `taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Taxonomy Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ALTER COLUMN `to_knowledge_asset_id` SET TAGS ('dbx_business_glossary_term' = 'To Knowledge Asset Id');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ALTER COLUMN `access_control_list` SET TAGS ('dbx_business_glossary_term' = 'Access Control List (ACL)');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ALTER COLUMN `archived_date` SET TAGS ('dbx_business_glossary_term' = 'Archived Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ALTER COLUMN `case_law_citations` SET TAGS ('dbx_business_glossary_term' = 'Case Law Citations');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ALTER COLUMN `conclusion` SET TAGS ('dbx_business_glossary_term' = 'Conclusion');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ALTER COLUMN `document_storage_path` SET TAGS ('dbx_business_glossary_term' = 'Document Storage Path');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ALTER COLUMN `is_precedent` SET TAGS ('dbx_business_glossary_term' = 'Is Precedent');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ALTER COLUMN `is_published_to_knowledge_base` SET TAGS ('dbx_business_glossary_term' = 'Is Published to Knowledge Base');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ALTER COLUMN `key_legal_concepts` SET TAGS ('dbx_business_glossary_term' = 'Key Legal Concepts');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ALTER COLUMN `lexisnexis_source_citations` SET TAGS ('dbx_business_glossary_term' = 'LexisNexis Source Citations');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ALTER COLUMN `lpp_classification` SET TAGS ('dbx_business_glossary_term' = 'Legal Professional Privilege (LPP) Classification');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ALTER COLUMN `lpp_classification` SET TAGS ('dbx_value_regex' = 'privileged|work_product|not_privileged');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ALTER COLUMN `memo_status` SET TAGS ('dbx_business_glossary_term' = 'Memo Status');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ALTER COLUMN `memo_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|archived|superseded');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ALTER COLUMN `memo_summary` SET TAGS ('dbx_business_glossary_term' = 'Memo Summary');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ALTER COLUMN `memo_title` SET TAGS ('dbx_business_glossary_term' = 'Memo Title');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ALTER COLUMN `nlp_processing_date` SET TAGS ('dbx_business_glossary_term' = 'Natural Language Processing (NLP) Processing Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ALTER COLUMN `nlp_processing_status` SET TAGS ('dbx_business_glossary_term' = 'Natural Language Processing (NLP) Processing Status');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ALTER COLUMN `nlp_processing_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|failed');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ALTER COLUMN `quality_rating` SET TAGS ('dbx_business_glossary_term' = 'Quality Rating');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ALTER COLUMN `regulation_citations` SET TAGS ('dbx_business_glossary_term' = 'Regulation Citations');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ALTER COLUMN `related_memo_ids` SET TAGS ('dbx_business_glossary_term' = 'Related Memo IDs');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ALTER COLUMN `research_hours` SET TAGS ('dbx_business_glossary_term' = 'Research Hours');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ALTER COLUMN `research_question` SET TAGS ('dbx_business_glossary_term' = 'Research Question');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period Years');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ALTER COLUMN `reuse_count` SET TAGS ('dbx_business_glossary_term' = 'Reuse Count');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ALTER COLUMN `secondary_source_citations` SET TAGS ('dbx_business_glossary_term' = 'Secondary Source Citations');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ALTER COLUMN `statute_citations` SET TAGS ('dbx_business_glossary_term' = 'Statute Citations');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Tags');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ALTER COLUMN `westlaw_source_citations` SET TAGS ('dbx_business_glossary_term' = 'Westlaw Source Citations');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` ALTER COLUMN `taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Taxonomy ID');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` ALTER COLUMN `parent_taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Taxonomy ID');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` ALTER COLUMN `primary_replacement_taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Taxonomy ID');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` ALTER COLUMN `access_level` SET TAGS ('dbx_business_glossary_term' = 'Access Level');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` ALTER COLUMN `access_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` ALTER COLUMN `alternate_terms` SET TAGS ('dbx_business_glossary_term' = 'Alternate Terms');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` ALTER COLUMN `display_order` SET TAGS ('dbx_business_glossary_term' = 'Display Order');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` ALTER COLUMN `external_taxonomy_mapping` SET TAGS ('dbx_business_glossary_term' = 'External Taxonomy Mapping');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` ALTER COLUMN `hierarchy_path` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Path');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` ALTER COLUMN `is_deprecated` SET TAGS ('dbx_business_glossary_term' = 'Is Deprecated');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` ALTER COLUMN `is_leaf_node` SET TAGS ('dbx_business_glossary_term' = 'Is Leaf Node');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` ALTER COLUMN `last_used_date` SET TAGS ('dbx_business_glossary_term' = 'Last Used Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` ALTER COLUMN `matter_type` SET TAGS ('dbx_business_glossary_term' = 'Matter Type');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` ALTER COLUMN `nlp_keywords` SET TAGS ('dbx_business_glossary_term' = 'Natural Language Processing (NLP) Keywords');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` ALTER COLUMN `owner_email` SET TAGS ('dbx_business_glossary_term' = 'Taxonomy Owner Email');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` ALTER COLUMN `owner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` ALTER COLUMN `owner_email` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` ALTER COLUMN `owner_name` SET TAGS ('dbx_business_glossary_term' = 'Taxonomy Owner Name');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` ALTER COLUMN `practice_area` SET TAGS ('dbx_business_glossary_term' = 'Practice Area');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` ALTER COLUMN `preferred_term` SET TAGS ('dbx_business_glossary_term' = 'Preferred Term');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` ALTER COLUMN `related_taxonomy_ids` SET TAGS ('dbx_business_glossary_term' = 'Related Taxonomy IDs');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Taxonomy Reviewer Name');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` ALTER COLUMN `scope_notes` SET TAGS ('dbx_business_glossary_term' = 'Scope Notes');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` ALTER COLUMN `source_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Source Reference ID');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` ALTER COLUMN `taxonomy_code` SET TAGS ('dbx_business_glossary_term' = 'Taxonomy Code');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` ALTER COLUMN `taxonomy_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,20}$');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` ALTER COLUMN `taxonomy_description` SET TAGS ('dbx_business_glossary_term' = 'Taxonomy Description');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` ALTER COLUMN `taxonomy_name` SET TAGS ('dbx_business_glossary_term' = 'Taxonomy Name');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` ALTER COLUMN `taxonomy_status` SET TAGS ('dbx_business_glossary_term' = 'Taxonomy Status');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` ALTER COLUMN `taxonomy_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|under_review|proposed');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` ALTER COLUMN `taxonomy_type` SET TAGS ('dbx_business_glossary_term' = 'Taxonomy Type');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` ALTER COLUMN `taxonomy_type` SET TAGS ('dbx_value_regex' = 'practice_area|sub_practice|jurisdiction|matter_type|topic_tag|document_type');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
