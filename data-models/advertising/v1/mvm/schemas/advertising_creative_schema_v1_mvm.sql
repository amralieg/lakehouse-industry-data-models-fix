-- Schema for Domain: creative | Business: Advertising | Version: v1_mvm
-- Generated on: 2026-05-08 03:52:17

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `advertising_ecm`.`creative` COMMENT 'Manages the full creative development and production lifecycle — from brief and concept through asset production, versioning, proofing, and final delivery. Serves as the SSOT for creative assets, DAM metadata, WIP status, format compliance, creative specifications, and brand compliance. Integrates with Adobe Creative Cloud and Workfront DAM.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `advertising_ecm`.`creative`.`creative_brief` (
    `creative_brief_id` BIGINT COMMENT 'Unique identifier for the creative brief record. Primary key.',
    `agency_relationship_id` BIGINT COMMENT 'Foreign key linking to client.agency_relationship. Business justification: Creative briefs are issued within a specific agency relationship (AOR or project engagement). Agency billing, scope-of-services compliance, and fee reconciliation all require knowing which agency rela',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Briefs execute under master service agreements (MSAs) that define scope, pricing, and deliverables. Agencies track which agreement governs each brief for billing validation, scope compliance, and cont',
    `brand_guideline_id` BIGINT COMMENT 'Foreign key linking to creative.brand_guideline. Business justification: creative_brief currently stores brand guideline information as a free-text STRING column `brand_guidelines_reference`. This should be normalized to a proper FK to brand_guideline, which is the authori',
    `brand_id` BIGINT COMMENT 'Reference to the specific client brand for which this creative is being developed.',
    `campaign_id` BIGINT COMMENT 'Reference to the parent campaign that this creative brief supports. Links the brief to the broader campaign strategy.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Creative briefs are initiated by departments/practice groups tracked as cost centers for budget ownership and chargeback accounting. Agency finance teams allocate brief costs to originating cost cente',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Briefs reference approved budgets for scope and cost constraints. Links brief requirements to formal budget allocations for financial planning, approval workflows, and spend tracking against allocated',
    `initiative_id` BIGINT COMMENT 'Reference to the Workfront project that initiated this creative brief. Links to project intake and resource planning.',
    `project_brief_id` BIGINT COMMENT 'Foreign key linking to project.project_brief. Business justification: Creative briefs are execution-level briefs derived from project briefs. Linking enables strategic alignment validation, requirements traceability, scope verification, and brief-to-execution tracking. ',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Briefs are scoped and budgeted within specific SOWs. Agencies track this to ensure creative work stays within contracted scope, allocate costs to correct SOW line items, and validate budget availabili',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Creative briefs specify preferred production vendors (studios, post-production houses, animation vendors) for execution. Essential for production planning, vendor assignment workflows, and budget allo',
    `persona_id` BIGINT COMMENT 'Foreign key linking to audience.persona. Business justification: Briefs define creative strategy against structured personas; target_audience_description is prose, but campaigns require linking to defined persona profiles for consistent targeting and measurement ac',
    `approved_by_name` STRING COMMENT 'Name of the individual who provided final approval for the creative brief.',
    `approved_date` DATE COMMENT 'Date when the creative brief received final approval and was authorized to proceed to production.',
    `art_director_assigned` STRING COMMENT 'Name of the art director assigned to develop visual concepts and design for this creative brief.',
    `brief_name` STRING COMMENT 'Descriptive name or title of the creative brief, typically reflecting the campaign or project name.',
    `brief_number` STRING COMMENT 'Human-readable business identifier for the creative brief, typically following format CB-NNNNNN. Used for external communication and tracking.. Valid values are `^CB-[0-9]{6,10}$`',
    `brief_type` STRING COMMENT 'Classification of the creative brief based on its strategic purpose and scope.. Valid values are `campaign|tactical|evergreen|seasonal|product_launch|rebranding`',
    `business_objective` STRING COMMENT 'High-level business goal that this creative work is intended to achieve, such as brand awareness, lead generation, or product launch support.',
    `call_to_action` STRING COMMENT 'Desired audience action or response that the creative should drive, such as visit website, call now, or download app.',
    `channel_distribution` STRING COMMENT 'Media channels and platforms where the creative assets will be deployed, such as television, digital display, social media, OOH (Out-of-Home), or print.',
    `competitive_context` STRING COMMENT 'Analysis of competitive landscape and positioning considerations that should inform the creative approach.',
    `copywriter_assigned` STRING COMMENT 'Name of the copywriter assigned to develop written content for this creative brief.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the creative brief record was first created in the system. Audit trail field.',
    `creative_brief_status` STRING COMMENT 'Current lifecycle status of the creative brief in the approval and production workflow.. Valid values are `draft|submitted|approved|in_production|completed|cancelled`',
    `creative_director_assigned` STRING COMMENT 'Name of the creative director assigned to oversee and approve the creative development for this brief.',
    `deliverable_formats` STRING COMMENT 'List of required creative asset formats and specifications, such as video lengths, display ad dimensions, print sizes, or social media formats.',
    `due_date` DATE COMMENT 'Target date by which the creative assets must be completed and delivered, driving production scheduling and resource allocation.',
    `key_message` STRING COMMENT 'Primary message or value proposition that the creative must communicate to the target audience.',
    `legal_regulatory_requirements` STRING COMMENT 'Specific legal disclaimers, regulatory compliance requirements, or industry standards that must be adhered to in the creative execution.',
    `mandatories` STRING COMMENT 'Required elements that must be included in the creative execution, such as logos, legal disclaimers, regulatory statements, or specific product features.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the creative brief record was last modified. Audit trail field for tracking changes.',
    `notes` STRING COMMENT 'Additional notes, comments, or context that provide supplementary information for the creative team.',
    `priority` STRING COMMENT 'Business priority level assigned to this creative brief, influencing resource allocation and scheduling.. Valid values are `low|medium|high|urgent`',
    `submitted_date` DATE COMMENT 'Date when the creative brief was formally submitted for review and approval.',
    `success_metrics` STRING COMMENT 'Key Performance Indicators (KPI) and measurement criteria that will be used to evaluate the effectiveness of the creative execution.',
    `supporting_messages` STRING COMMENT 'Secondary messages or proof points that reinforce the key message and provide additional context.',
    `target_audience_description` STRING COMMENT 'Detailed description of the intended audience for the creative, including demographic, psychographic, and behavioral characteristics.',
    `tone_of_voice` STRING COMMENT 'Desired communication style and personality for the creative execution, such as professional, playful, authoritative, or empathetic.',
    `version_number` STRING COMMENT 'Version number of the creative brief, incremented with each revision or update to track changes over time.',
    CONSTRAINT pk_creative_brief PRIMARY KEY(`creative_brief_id`)
) COMMENT 'Master record for the creative brief — the foundational document that initiates creative development. Captures client objectives, target audience, key messaging, tone of voice, deliverable formats, mandatories, budget envelope, and approval chain. Serves as the SSOT for all creative work initiated within a campaign or project. Originates from Workfront project intake and links to campaign strategy.';

CREATE OR REPLACE TABLE `advertising_ecm`.`creative`.`asset` (
    `asset_id` BIGINT COMMENT 'Unique identifier for the creative asset in the Digital Asset Management (DAM) system. Primary key.',
    `advertiser_id` BIGINT COMMENT 'FK to client.advertiser.advertiser_id — MUST-HAVE: Cannot determine asset ownership. Required for rights management, brand compliance, and client asset libraries.',
    `brand_id` BIGINT COMMENT 'Reference to the client brand that owns or is represented by this asset. Enables brand-level asset organization and reporting.',
    `creative_brief_id` BIGINT COMMENT 'Foreign key linking to creative.creative_brief. Business justification: A creative asset is produced in direct response to a creative brief — the brief defines the key message, tone, mandatories, deliverable formats, and brand direction that govern the asset. Adding creat',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Assets are deliverables within initiatives. Linking enables asset inventory management, reuse tracking across projects, ROI analysis, and portfolio reporting. Essential for digital asset management an',
    `parent_asset_creative_asset_id` BIGINT COMMENT 'Reference to the parent or original asset from which this version was derived. Establishes version lineage and asset family relationships.',
    `persona_id` BIGINT COMMENT 'Foreign key linking to audience.persona. Business justification: Dynamic Creative Optimization (DCO) and personalization workflows require assets to be mapped to specific personas. Creative performance reporting by persona (e.g., which assets performed best for th',
    `production_job_id` BIGINT COMMENT 'Foreign key linking to creative.production_job. Business justification: A creative asset is the output artifact of a production job. Linking creative_asset to the production_job that produced it provides operational traceability — enabling job-level asset inventory, cost ',
    `segment_id` BIGINT COMMENT 'Foreign key linking to audience.segment. Business justification: Assets are optimized for specific audience segments; personalization and dynamic creative optimization require segment-level asset assignment to deliver relevant creative to each audience, core to mod',
    `spec_id` BIGINT COMMENT 'Foreign key linking to creative.creative_spec. Business justification: Creative assets are produced to meet specific creative specifications (format, dimensions, file size, codec, etc.). This link tracks which spec an asset was produced to, supporting validation and comp',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Assets created by external vendors (stock media providers, production companies, freelance studios) require vendor attribution for rights management, usage tracking, invoice reconciliation, and qualit',
    `task_id` BIGINT COMMENT 'Foreign key linking to project.task. Business justification: Assets are outputs of specific tasks. Linking enables granular effort tracking, resource utilization analysis, task completion validation, and productivity measurement. Essential for time tracking and',
    `work_package_id` BIGINT COMMENT 'Foreign key linking to project.work_package. Business justification: Creative assets are produced within specific work packages (e.g., Digital Asset Production WP). Direct work_package_id on creative_asset enables work-package-level asset inventory and cost reporting',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the asset was approved for use. Establishes the point at which the asset became available for trafficking and deployment.',
    `archived_timestamp` TIMESTAMP COMMENT 'Date and time when the asset was archived or retired from active use. Supports lifecycle management and storage optimization.',
    `aspect_ratio` STRING COMMENT 'Proportional relationship between width and height (e.g., 16:9, 4:3, 1:1, 9:16). Determines display format and channel suitability.',
    `asset_name` STRING COMMENT 'Human-readable name or title of the creative asset. Primary label used for search and identification.',
    `asset_type` STRING COMMENT 'High-level classification of the creative asset format. Determines handling, rendering, and distribution workflows. [ENUM-REF-CANDIDATE: image|video|audio|copy_document|design_file|motion_graphics|html5_rich_media|3d_ar_asset — 8 candidates stripped; promote to reference product]',
    `brand_compliance_status` STRING COMMENT 'Indicates whether the asset adheres to brand guidelines and standards. Critical for brand integrity and legal risk management.. Valid values are `compliant|non_compliant|pending_review|not_applicable`',
    `campaign_theme` STRING COMMENT 'Overarching creative theme or concept associated with the asset (e.g., Summer Sale, Back to School, Holiday 2024). Links asset to strategic messaging.',
    `channel_suitability` STRING COMMENT 'Comma-separated list of media channels for which this asset is optimized or approved (e.g., TV, Digital, OOH, Social, CTV). Guides media planning and trafficking.',
    `codec` STRING COMMENT 'Video or audio codec used for encoding (e.g., H.264, H.265, AAC, MP3). Critical for playback compatibility and quality.',
    `color_profile` STRING COMMENT 'Color space or profile used in the asset (e.g., sRGB, Adobe RGB, CMYK). Ensures color accuracy across media and devices.',
    `copyright_holder` STRING COMMENT 'Name of the individual or organization that holds copyright to the asset. Critical for legal compliance and rights management.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the asset record was first created in the DAM system. Audit and lifecycle tracking.',
    `creative_asset_description` STRING COMMENT 'Free-text description of the asset content, purpose, and usage notes. Provides context for search, reuse, and creative briefing.',
    `dam_asset_ref` STRING COMMENT 'External unique identifier from the source DAM system (Workfront DAM or Adobe AEM). Used for cross-system reconciliation and asset retrieval.',
    `duration_seconds` DECIMAL(18,2) COMMENT 'Length of the asset in seconds. Applicable to video, audio, and motion graphics assets.',
    `file_format` STRING COMMENT 'Specific file format or extension of the asset (e.g., PSD, AI, INDD, MP4, PNG, JPG, HTML5). Critical for compatibility and production workflows.',
    `file_size_bytes` BIGINT COMMENT 'Size of the asset file in bytes. Used for storage management, bandwidth planning, and delivery optimization.',
    `file_storage_path` STRING COMMENT 'Full path or URI to the asset file in the storage system (cloud storage, DAM repository, CDN). Used for retrieval and delivery.',
    `geographic_market` STRING COMMENT 'Target geographic market or region for which the asset was created (e.g., USA, GBR, CAN). Supports regional campaign management and compliance.',
    `is_master_asset` BOOLEAN COMMENT 'Flag indicating whether this asset is the master or source-of-truth version from which other versions are derived. True for master assets, false for derivatives.',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code indicating the primary language of the asset (e.g., EN, ES, FR). Critical for localization and regional targeting.',
    `license_type` STRING COMMENT 'Type of license under which the asset is used (e.g., royalty-free, rights-managed, exclusive, non-exclusive). Governs usage terms and restrictions.',
    `lifecycle_stage` STRING COMMENT 'Current stage in the creative asset lifecycle. Governs access, usage rights, and workflow routing.. Valid values are `wip|in_review|approved|published|archived|expired`',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the asset record or file was last modified. Supports version control and change tracking.',
    `mood_tags` STRING COMMENT 'Comma-separated keywords describing the emotional tone or mood of the asset (e.g., energetic, calm, humorous, inspirational). Aids in creative selection and reuse.',
    `resolution` STRING COMMENT 'Pixel dimensions or resolution of the asset (e.g., 1920x1080, 300 DPI). Applicable to images and videos.',
    `rights_clearance_status` STRING COMMENT 'Status of legal rights and usage permissions for the asset (talent, music, stock imagery, etc.). Determines where and how the asset can be used.. Valid values are `cleared|pending|restricted|expired`',
    `rights_expiry_date` DATE COMMENT 'Date when usage rights for the asset expire. After this date, the asset may no longer be legally used without renewal.',
    `subject_tags` STRING COMMENT 'Comma-separated descriptive keywords describing the subject matter or content of the asset (e.g., product, lifestyle, testimonial). Supports search and discovery.',
    `thumbnail_url` STRING COMMENT 'URL to a thumbnail or preview image of the asset. Enables quick visual identification in DAM interfaces and reporting tools.',
    `usage_count` STRING COMMENT 'Number of times this asset has been used in campaigns, ads, or other placements. Indicates asset popularity and reuse value.',
    `version_number` STRING COMMENT 'Version identifier for the asset (e.g., v1.0, v2.3, final). Tracks iteration and revision history.',
    CONSTRAINT pk_asset PRIMARY KEY(`asset_id`)
) COMMENT 'Core master entity representing a single creative asset in the Digital Asset Management system — including images, videos, audio files, copy documents, design files (PSD, AI, INDD), motion graphics, HTML5 rich media, and 3D/AR assets. Tracks asset type, format, file size, resolution, duration, codec, color profile, aspect ratio, DAM asset ID (Workfront DAM/Adobe AEM), version lineage, brand compliance status, rights clearance status, lifecycle stage (WIP, in-review, approved, archived, expired), expiry date, and descriptive metadata tags (subject, mood, channel, campaign theme). This is the SSOT for all creative asset metadata and taxonomy across the agency, supporting search, retrieval, reuse discovery, and rights monitoring.';

CREATE OR REPLACE TABLE `advertising_ecm`.`creative`.`asset_version` (
    `asset_version_id` BIGINT COMMENT 'Unique identifier for the asset version record. Primary key.',
    `asset_id` BIGINT COMMENT 'Reference to the parent creative asset for which this version was created.',
    `creative_deliverable_id` BIGINT COMMENT 'Foreign key linking to creative.creative_deliverable. Business justification: Asset versions represent iterative development states of deliverables. Production tracking requires linking each version to its parent deliverable to manage revision history, track which version was a',
    `deliverable_tracker_id` BIGINT COMMENT 'Foreign key linking to project.deliverable_tracker. Business justification: Specific asset versions are submitted as deliverables and tracked in deliverable_tracker (which stores file_reference and version_number as plain text). A proper FK normalizes this and enables version',
    `production_job_id` BIGINT COMMENT 'Foreign key linking to creative.production_job. Business justification: Each asset version is produced within the context of a specific production job — revisions, re-renders, and format adaptations are all tracked as versions tied to the job that commissioned them. Addin',
    `spec_id` BIGINT COMMENT 'Foreign key linking to creative.creative_spec. Business justification: Each asset version should track which creative specification it conforms to. As assets are revised through the version history, they may be adjusted to meet different specs or updated spec versions. T',
    `task_id` BIGINT COMMENT 'Foreign key linking to project.task. Business justification: In advertising production, each asset version is created during a specific revision or QA task. Linking asset_version to task enables task-level version history reporting and effort-to-version traceab',
    `adobe_cc_document_version_ref` STRING COMMENT 'External version identifier from Adobe Creative Cloud system. Enables traceability to source Adobe application (Photoshop, Illustrator, InDesign, Premiere Pro).',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when this version received formal approval. Null if not yet approved.',
    `approved_by_name` STRING COMMENT 'Name of the individual who approved this version for promotion or final delivery. Null if not yet approved.',
    `archive_timestamp` TIMESTAMP COMMENT 'Date and time when this version was archived. Null if not yet archived.',
    `brand_compliance_status` STRING COMMENT 'Indicates whether this version adheres to brand guidelines and standards. Used for brand governance and quality control.. Valid values are `compliant|non_compliant|pending_review|not_applicable`',
    `change_summary` STRING COMMENT 'Brief description of changes made in this version compared to the previous iteration. Captures rationale for the revision.',
    `checksum_hash` STRING COMMENT 'Cryptographic hash (e.g., MD5, SHA-256) of the file for integrity verification and duplicate detection.',
    `color_profile` STRING COMMENT 'Color space or profile used in this version (e.g., sRGB, Adobe RGB, CMYK). Critical for print and digital color accuracy.',
    `compliance_check_timestamp` TIMESTAMP COMMENT 'Date and time when brand compliance review was last performed on this version. Null if not yet reviewed.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this version record was first created in the system. Audit trail for version creation.',
    `duration_seconds` DECIMAL(18,2) COMMENT 'Duration of video or audio creative in seconds. Null for static assets.',
    `file_format` STRING COMMENT 'File format or extension of this version (e.g., PSD, AI, INDD, PDF, JPG, PNG, MP4, MOV). Indicates the Adobe Creative Cloud or export format. [ENUM-REF-CANDIDATE: psd|ai|indd|pdf|jpg|png|mp4|mov|gif — 9 candidates stripped; promote to reference product]',
    `file_name` STRING COMMENT 'Original file name of this version as stored in the system.',
    `file_path` STRING COMMENT 'Storage location or URI reference to the physical file for this version in the Digital Asset Management (DAM) system or cloud storage.',
    `file_size_bytes` BIGINT COMMENT 'Size of the version file in bytes. Used for storage management and delivery optimization.',
    `height_pixels` STRING COMMENT 'Height dimension of the creative asset in pixels. Applicable to image and video formats.',
    `is_archived` BOOLEAN COMMENT 'Indicates whether this version has been archived and moved to long-term storage. True if archived, False if active.',
    `is_promoted` BOOLEAN COMMENT 'Indicates whether this version has been promoted to production or final delivery status. True if promoted, False otherwise.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this version record was last modified. Audit trail for version updates.',
    `promotion_timestamp` TIMESTAMP COMMENT 'Date and time when this version was promoted to production or approved for final delivery. Null if not yet promoted.',
    `rejection_reason` STRING COMMENT 'Explanation or rationale for rejection if this version was not approved. Null if approved or pending.',
    `resolution_dpi` STRING COMMENT 'Resolution of the asset in dots per inch. Typically 72 for digital, 300+ for print. Null for video assets.',
    `version_label` STRING COMMENT 'Human-readable version label or tag (e.g., v1, v2_client_feedback, v3_final, draft_A). Used for identification and communication.',
    `version_number` STRING COMMENT 'Sequential numeric version number indicating the iteration sequence (1, 2, 3, etc.).',
    `version_status` STRING COMMENT 'Current lifecycle status of this version. Tracks progression through creative approval workflow.. Valid values are `draft|in_review|approved|rejected|superseded|archived`',
    `width_pixels` STRING COMMENT 'Width dimension of the creative asset in pixels. Applicable to image and video formats.',
    `workfront_proof_version_ref` STRING COMMENT 'External proof version identifier from Workfront proofing system. Links to approval and feedback workflow.',
    CONSTRAINT pk_asset_version PRIMARY KEY(`asset_version_id`)
) COMMENT 'Tracks the full version history of a creative asset — capturing each iteration produced during the creative development lifecycle. Records version number, version label (e.g., v1, v2_client_feedback), file reference, change summary, author, Adobe CC document version ID, Workfront proof version ID, and promotion status (draft, in-review, approved, superseded). Enables rollback, audit, and compliance traceability for all creative deliverables.';

CREATE OR REPLACE TABLE `advertising_ecm`.`creative`.`concept` (
    `concept_id` BIGINT COMMENT 'Unique identifier for the creative concept. Primary key.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to client.client_brand. Business justification: Creative concepts are developed for a specific brand. Brand-level concept portfolio reporting, brand guideline compliance validation, and brand-level creative strategy reviews all require knowing whic',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Concepts are strategic outputs within initiatives. Linking enables ideation-to-execution traceability, concept testing tracking, and strategic alignment validation. Critical for creative development p',
    `milestone_id` BIGINT COMMENT 'Foreign key linking to project.project_milestone. Business justification: Concept presentations and approvals are formal project milestones in advertising (e.g., Concept Approval Gate). Linking concept to project_milestone enables milestone-based concept approval tracking',
    `parent_concept_id` BIGINT COMMENT 'Reference to the parent concept if this is a revision or variation. Enables tracking of concept evolution and iteration history.',
    `project_brief_id` BIGINT COMMENT 'Foreign key linking to project.project_brief. Business justification: Concept development is directly scoped by the project brief in advertising. Agencies track which concepts respond to which project brief for brief-compliance review and concept evaluation. concept→cre',
    `persona_id` BIGINT COMMENT 'Foreign key linking to audience.persona. Business justification: Concepts are developed against persona profiles; creative strategy workshops and concept testing require linking concepts to target personas to validate strategic fit and ensure messaging resonates wi',
    `work_package_id` BIGINT COMMENT 'Foreign key linking to project.work_package. Business justification: Concept development is a discrete work package in advertising project plans (e.g., Concepting WP). Linking concept to work_package enables project managers to track planned vs. actual effort for con',
    `approval_date` DATE COMMENT 'The date when the concept received final approval to proceed to production. Marks the transition from concept to execution phase.',
    `approval_status` STRING COMMENT 'Specific approval state indicating whether the concept has been approved by internal stakeholders and/or client. Tracks formal sign-off milestones. [ENUM-REF-CANDIDATE: not_submitted|pending_internal|pending_client|approved_internal|approved_client|rejected|conditional — 7 candidates stripped; promote to reference product]',
    `brand_compliance_flag` BOOLEAN COMMENT 'Indicates whether the concept has been reviewed and confirmed to comply with brand guidelines and standards. True if compliant, false if non-compliant or not yet reviewed.',
    `channel_applicability` STRING COMMENT 'Description of which media channels and platforms this concept is designed for or can be adapted to (e.g., TV, digital, OOH, social, print).',
    `competitive_differentiation` STRING COMMENT 'Description of how this concept differentiates the brand from competitors. Explains the unique positioning and competitive advantage.',
    `concept_code` STRING COMMENT 'Unique business identifier or code assigned to the concept for tracking and reference across systems. Often used in project management and DAM systems.',
    `concept_description` STRING COMMENT 'Detailed narrative description of the creative concept. Explains the big idea, execution approach, and how the concept will come to life across touchpoints.',
    `concept_status` STRING COMMENT 'Current lifecycle status of the concept. Tracks progression through internal review, client presentation, and approval stages. [ENUM-REF-CANDIDATE: draft|in_review|pending_approval|approved|rejected|on_hold|archived — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this concept record was first created in the system. Marks the beginning of the concept development lifecycle.',
    `creative_territory` STRING COMMENT 'The overarching creative theme, space, or territory that this concept occupies. Defines the broad strategic positioning and thematic direction.',
    `estimated_production_cost` DECIMAL(18,2) COMMENT 'Estimated cost to produce and execute this concept if approved. Used for budget planning and concept selection decisions.',
    `headline` STRING COMMENT 'The primary headline or main message of the concept. The key communication element that captures attention and conveys the core idea.',
    `key_message` STRING COMMENT 'The core message or takeaway that the concept aims to communicate to the target audience. The single most important thing the audience should remember.',
    `legal_review_required` BOOLEAN COMMENT 'Indicates whether this concept requires legal review before approval. True if legal clearance is needed, false otherwise.',
    `legal_review_status` STRING COMMENT 'Status of legal review process for this concept. Tracks whether legal has cleared the concept for use in advertising.. Valid values are `not_required|pending|approved|rejected|conditional`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this concept record was last modified. Tracks the most recent update to any concept attribute.',
    `mood_board_reference` STRING COMMENT 'Reference to mood board assets or inspiration materials that illustrate the visual and emotional tone of the concept. May include links to DAM assets or external references.',
    `presentation_date` DATE COMMENT 'The date when this concept was or will be presented to the client or internal stakeholders for review and feedback.',
    `production_complexity` STRING COMMENT 'Assessment of the production complexity and resource requirements for this concept. Influences feasibility and timeline planning.. Valid values are `low|medium|high|very_high`',
    `rejection_reason` STRING COMMENT 'Explanation or feedback provided when a concept is rejected. Captures stakeholder concerns and rationale for non-approval.',
    `strategic_rationale` STRING COMMENT 'The strategic reasoning and business justification for this concept. Explains how the concept addresses the brief objectives and target audience insights.',
    `tagline` STRING COMMENT 'The tagline or supporting message that reinforces the concept. Often used as a memorable phrase that encapsulates the brand promise or campaign theme.',
    `target_audience` STRING COMMENT 'Description of the primary target audience this concept is designed to reach and resonate with. May reference audience segments or personas.',
    `testing_recommendation` STRING COMMENT 'Recommendation for whether and how this concept should be tested with target audiences before full production (e.g., focus groups, A/B testing, concept testing).',
    `title` STRING COMMENT 'The working title or name of the creative concept. Used to identify and reference the concept throughout the development lifecycle.',
    `tone_of_voice` STRING COMMENT 'The communication style and personality of the concept. Describes how the brand should sound when expressing this idea (e.g., playful, authoritative, empathetic).',
    `version` STRING COMMENT 'Version number of this concept iteration. Increments when significant revisions are made based on feedback.',
    `visual_direction` STRING COMMENT 'Description of the visual style, aesthetic, and design direction for the concept. Includes guidance on imagery, color palette, typography, and overall look and feel.',
    CONSTRAINT pk_concept PRIMARY KEY(`concept_id`)
) COMMENT 'Represents a creative concept or big idea developed in response to a creative brief. Captures concept title, creative territory, strategic rationale, mood board references, headline, tagline, visual direction, and approval status. A single brief may spawn multiple competing concepts; this entity tracks each concept through internal review and client presentation stages. Integrates with Workfront creative project milestones.';

CREATE OR REPLACE TABLE `advertising_ecm`.`creative`.`production_job` (
    `production_job_id` BIGINT COMMENT 'Unique identifier for the production job. Primary key.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to client.client_brand. Business justification: Production jobs are executed for a specific brand. Brand-level production cost reporting, brand compliance requirement enforcement, and brand-scoped production capacity planning all require this direc',
    `campaign_id` BIGINT COMMENT 'Reference to the campaign this production job supports.',
    `concept_id` BIGINT COMMENT 'Foreign key linking to creative.concept. Business justification: Production jobs execute approved concepts. Once a concept is approved, production jobs are created to produce the creative deliverables. This direct link allows tracking which concept a production job',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Production jobs are core cost-tracking units in agency operations. Jobs are allocated to cost centers (studio, creative department) for labor cost accounting, overhead allocation, and departmental P&L',
    `creative_brief_id` BIGINT COMMENT 'Reference to the creative brief that initiated this production job.',
    `milestone_id` BIGINT COMMENT 'Foreign key linking to project.project_milestone. Business justification: Production job delivery deadlines align with contractual project milestones (e.g., Final Delivery milestone that triggers client billing). Role-prefix delivery_ distinguishes this from other poten',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Production job costs post directly to GL accounts in agency accounting (SAP/NetSuite). production_job already has sap_wbs_element indicating ERP integration; GL account assignment is required for cost',
    `plan_id` BIGINT COMMENT 'Foreign key linking to media.media_plan. Business justification: Production jobs are initiated to create deliverables for media plans. Studios need plan context for format specifications, channel requirements, flight deadlines, and ensuring creative is ready before',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Production jobs are work execution units within initiatives. Linking enables project portfolio reporting, resource planning across initiatives, budget roll-ups, and timeline tracking. Essential for ag',
    `project_budget_id` BIGINT COMMENT 'Foreign key linking to project.project_budget. Business justification: Production jobs consume project budgets. Linking enables cost tracking, variance analysis, budget utilization reporting, and profitability analysis. Essential for financial management and project cont',
    `sla_id` BIGINT COMMENT 'Foreign key linking to contract.sla. Business justification: Production jobs are subject to contracted SLA commitments covering delivery timelines and revision turnaround. Agencies track whether production jobs meet contracted SLA terms for performance reportin',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Production jobs are delivered under SOW terms that define deliverables, timelines, and pricing. Agencies track which SOW governs each job for accurate billing, resource allocation, and contract compli',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Production jobs are frequently outsourced to external studios, post-production facilities, VFX houses, and freelance production companies. Critical for vendor billing reconciliation, quality managemen',
    `task_id` BIGINT COMMENT 'Foreign key linking to project.task. Business justification: Production jobs in advertising are executed through specific project tasks (e.g., Studio Production Task). Linking production_job to task enables time-entry reconciliation against production jobs an',
    `vendor_rate_card_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor_rate_card. Business justification: Production cost management: when a supplier is engaged for a production job, the agreed vendor rate card governs billing, cost estimation, and reconciliation. Production managers and finance teams nee',
    `work_package_id` BIGINT COMMENT 'Foreign key linking to project.work_package. Business justification: Production jobs are work packages in project plans. Linking enables task-level tracking, capacity planning, WBS-based reporting, and resource utilization analysis. Critical for studio operations manag',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual total cost incurred for this production job, reconciled from time tracking, vendor invoices, and expense reports.',
    `actual_hours` DECIMAL(18,2) COMMENT 'Actual total production hours spent on this job, tracked for cost reconciliation and future estimation accuracy.',
    `assigned_studio` STRING COMMENT 'Name of the internal studio team, freelancer, or external production vendor assigned to execute this job.',
    `brand_compliance_required` BOOLEAN COMMENT 'Indicates whether this production job requires formal brand guideline compliance review and approval.',
    `brand_compliance_status` STRING COMMENT 'Status of brand compliance review for this job. Values: not-required (compliance not needed), pending (review in progress), passed (compliant), failed (non-compliant), waived (compliance waived by client).. Valid values are `not-required|pending|passed|failed|waived`',
    `client_approval_date` DATE COMMENT 'Date when the client formally approved the final creative deliverables for this job.',
    `client_feedback` STRING COMMENT 'Feedback and comments received from the client during review cycles, captured for revision guidance and future reference.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this production job record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this production job (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `deliverable_count` STRING COMMENT 'Total number of distinct creative assets or deliverables produced as part of this production job.',
    `delivery_deadline` DATE COMMENT 'Target date by which final creative assets must be delivered to the client or campaign team.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Estimated total cost to complete this production job, including labor, vendor fees, and production expenses.',
    `estimated_hours` DECIMAL(18,2) COMMENT 'Estimated total production hours required to complete this job, used for resource planning and capacity management.',
    `final_delivery_date` DATE COMMENT 'Date when final approved creative assets were delivered to the client or campaign team.',
    `format_specifications` STRING COMMENT 'Technical format requirements for the deliverables (e.g., dimensions, file types, color space, resolution, duration). Free-text field capturing brief requirements from the creative brief.',
    `internal_notes` STRING COMMENT 'Internal notes and comments from the production team, not shared with the client. May include production challenges, resource constraints, or process observations.',
    `is_billable` BOOLEAN COMMENT 'Indicates whether this production job is billable to the client or is internal/non-billable work.',
    `job_description` STRING COMMENT 'Detailed description of the production job scope, objectives, and deliverables as defined in the creative brief or project plan.',
    `job_name` STRING COMMENT 'Human-readable name or title of the production job, typically describing the deliverable or campaign element.',
    `job_number` STRING COMMENT 'Externally-known unique job number assigned by the production management system (e.g., Workfront). Format typically includes prefix and sequential number.. Valid values are `^[A-Z]{2,4}-[0-9]{6,8}$`',
    `job_status` STRING COMMENT 'Current lifecycle status of the production job. Values: briefed (job briefed, not started), in-production (active production work), internal-review (internal creative review), qa (quality assurance check), client-review (submitted to client), revisions (rework requested), approved (client approved), delivered (final assets delivered), cancelled (job cancelled). [ENUM-REF-CANDIDATE: briefed|in-production|internal-review|qa|client-review|revisions|approved|delivered|cancelled — 9 candidates stripped; promote to reference product]',
    `job_type` STRING COMMENT 'Category of creative production work. Values: print (print advertising), digital (digital display/banner), video (video production), audio (radio/podcast), ooh (Out-of-Home static), dooh (Digital Out-of-Home), ctv (Connected TV), social (social media creative), experiential (event/activation), motion-graphics (animation/motion design). [ENUM-REF-CANDIDATE: print|digital|video|audio|ooh|dooh|ctv|social|experiential|motion-graphics — 10 candidates stripped; promote to reference product]',
    `legal_review_required` BOOLEAN COMMENT 'Indicates whether this production job requires legal or regulatory compliance review (e.g., for claims, disclosures, or regulated industries).',
    `legal_review_status` STRING COMMENT 'Status of legal compliance review for this job. Values: not-required (legal review not needed), pending (review in progress), approved (legally compliant), rejected (non-compliant), conditional (approved with modifications).. Valid values are `not-required|pending|approved|rejected|conditional`',
    `modified_by` STRING COMMENT 'User or system identifier of the person who last modified this production job record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this production job record was last modified.',
    `priority_level` STRING COMMENT 'Business priority assigned to this production job, determining resource allocation and scheduling urgency.. Valid values are `low|normal|high|urgent|critical`',
    `production_completion_date` DATE COMMENT 'Date when production work was completed and job moved to review or delivery status.',
    `production_start_date` DATE COMMENT 'Date when active production work began on this job.',
    `revision_count` STRING COMMENT 'Total number of revision rounds requested by internal reviewers or client during the production lifecycle.',
    `sap_wbs_element` STRING COMMENT 'SAP Project Systems WBS element code used for cost tracking and financial reconciliation of this production job.',
    `created_by` STRING COMMENT 'User or system identifier of the person who created this production job record.',
    CONSTRAINT pk_production_job PRIMARY KEY(`production_job_id`)
) COMMENT 'Operational record representing a discrete creative production job — the unit of work assigned to an internal studio team, freelancer, or external production vendor to produce one or more creative deliverables. Tracks job type (print, digital, video, audio, OOH, DOOH, CTV, social, experiential), job status (briefed, in-production, internal-review, QA, client-review, delivered), assigned studio or production house, estimated and actual production hours, cost estimate vs actual cost, delivery deadline, and priority level. Links to creative brief requirements and spawns creative assets upon completion. Sourced from Workfront project tasks and integrates with SAP PS for cost tracking.';

CREATE OR REPLACE TABLE `advertising_ecm`.`creative`.`proof` (
    `proof_id` BIGINT COMMENT 'Unique identifier for the proof record. Primary key.',
    `asset_version_id` BIGINT COMMENT 'Reference to the specific asset version being proofed in this review cycle.',
    `campaign_id` BIGINT COMMENT 'Reference to the campaign this proof is associated with, enabling campaign-level proof tracking and SLA reporting.',
    `creative_deliverable_id` BIGINT COMMENT 'Foreign key linking to creative.creative_deliverable. Business justification: A proof is submitted to validate a specific creative deliverable — the proof round is the formal approval mechanism for a named deliverable output. While proof already links to asset_version (the spec',
    `deliverable_tracker_id` BIGINT COMMENT 'Foreign key linking to project.deliverable_tracker. Business justification: A proof is the review/approval mechanism for a tracked deliverable. Linking proof to deliverable_tracker enables end-to-end delivery and approval workflow reporting — advertising agencies need to reco',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Proofs are approval artifacts within initiatives. Linking enables workflow tracking, approval cycle analysis, timeline management, and client satisfaction measurement at the initiative level. Essentia',
    `milestone_id` BIGINT COMMENT 'Foreign key linking to project.project_milestone. Business justification: Proofs are approval gates at milestones. Linking enables contractual compliance, payment release validation, client sign-off tracking, and milestone achievement verification. Critical for contract man',
    `production_job_id` BIGINT COMMENT 'Foreign key linking to creative.production_job. Business justification: Proofs are submitted during production jobs as part of the creative review workflow. This link provides operational context: which production job is this proof part of? Supports workflow tracking, SLA',
    `sla_id` BIGINT COMMENT 'Foreign key linking to contract.sla. Business justification: Proof review cycles are governed by contracted SLA turnaround commitments. proof.sla_met_flag and sla_target_hours are denormalized SLA data; linking to the governing SLA record enables breach reporti',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Proofing platforms (Workfront Proof, Ziflow, Aproove) are often external SaaS vendors. Required for vendor contract management, platform cost allocation, and tech stack governance in creative operatio',
    `task_id` BIGINT COMMENT 'Foreign key linking to project.task. Business justification: Proofs are approval tasks in project schedules. Linking enables dependency management, timeline tracking, task completion validation, and approval workflow automation. Critical for schedule management',
    `work_package_id` BIGINT COMMENT 'Foreign key linking to project.work_package. Business justification: Proofs are approval milestones within work packages. Linking enables critical path management, approval cycle tracking, and schedule impact analysis. Essential for timeline management and client coord',
    `approval_count` STRING COMMENT 'Number of reviewers who approved the proof (either approved or approved with changes). Used for consensus tracking.',
    `automated_check_flag` BOOLEAN COMMENT 'Indicates whether automated compliance checks (legal, accessibility, brand guidelines) were run on this proof. True = automated checks performed, False = manual review only.',
    `automated_check_result` STRING COMMENT 'Result of automated compliance checks if performed. Pass = all checks passed, Fail = critical issues found, Warning = minor issues flagged, Not Applicable = no automated checks run.. Valid values are `pass|fail|warning|not_applicable`',
    `comment_count` STRING COMMENT 'Total number of comments and annotations submitted by all reviewers on this proof. Indicator of feedback volume and creative iteration intensity.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the proof record was first created in the system. Audit trail for proof lifecycle tracking.',
    `decision_timestamp` TIMESTAMP COMMENT 'Date and time when the overall proof decision was finalized. Used as the end point for SLA turnaround time calculations.',
    `due_date` DATE COMMENT 'Target date by which all reviewers must complete their review and provide decisions. Used for SLA compliance tracking.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether this proof was escalated to senior stakeholders due to missed SLA, critical feedback, or client dissatisfaction. True = escalated, False = normal workflow.',
    `escalation_reason` STRING COMMENT 'Free-text explanation of why the proof was escalated (e.g., Client rejected 3 consecutive rounds, SLA missed by 48 hours).',
    `instructions` STRING COMMENT 'Free-text instructions or context provided to reviewers about what to focus on in this proof (e.g., Please review headline copy for brand voice compliance).',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the proof record was last modified. Audit trail for tracking updates to proof status, decisions, or metadata.',
    `overall_decision` STRING COMMENT 'Consolidated decision outcome across all assigned reviewers. Approved = all reviewers approved, Approved with Changes = approved but revisions requested, Rejected = requires major rework, Pending = awaiting reviewer decisions.. Valid values are `approved|approved_with_changes|rejected|pending`',
    `proof_name` STRING COMMENT 'Descriptive name of the proof, typically derived from the asset name and proof round (e.g., Q1 Campaign Hero Banner - Client Round 2).',
    `proof_number` STRING COMMENT 'Human-readable business identifier for the proof, typically auto-generated in format PRF-YYYYMMDD or similar.. Valid values are `^PRF-[0-9]{8}$`',
    `proof_status` STRING COMMENT 'Current lifecycle status of the proof. Draft = being prepared, Submitted = sent to reviewers, In Review = active review in progress, Approved = accepted as-is, Approved with Changes = accepted with minor revisions, Rejected = requires major rework, Cancelled = proof withdrawn. [ENUM-REF-CANDIDATE: draft|submitted|in_review|approved|approved_with_changes|rejected|cancelled — 7 candidates stripped; promote to reference product]',
    `proof_type` STRING COMMENT 'Type of proof being submitted for review. Concept = early ideation, Copy = text/messaging review, Layout = design structure, Final Art = production-ready creative, Legal = regulatory compliance review, Accessibility = WCAG/ADA compliance, Brand Compliance = brand guideline adherence. [ENUM-REF-CANDIDATE: concept|copy|layout|final_art|legal|accessibility|brand_compliance — 7 candidates stripped; promote to reference product]',
    `rejection_count` STRING COMMENT 'Number of reviewers who rejected the proof. Used for quality control and creative iteration analysis.',
    `reviewer_count` STRING COMMENT 'Total number of reviewers assigned to this proof. Used for workload and stakeholder engagement analysis.',
    `round_number` STRING COMMENT 'Sequential round number for this proof within the asset version lifecycle (1 = first proof, 2 = second proof after revisions, etc.).',
    `sla_met_flag` BOOLEAN COMMENT 'Boolean indicator of whether the proof review was completed within the SLA target hours. True = SLA met, False = SLA missed.',
    `stage` STRING COMMENT 'Stage of the proofing workflow. Internal = agency-only review, Client Round 1/2/3 = sequential client review cycles, Final = final approval before production.. Valid values are `internal|client_round_1|client_round_2|client_round_3|final`',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the proof was formally submitted to reviewers. Used as the start point for SLA turnaround time calculations.',
    `turnaround_time_hours` DECIMAL(18,2) COMMENT 'Calculated elapsed time in hours between submission_timestamp and decision_timestamp. Key metric for agency SLA compliance reporting on review cycle speed.',
    `url` STRING COMMENT 'Direct URL link to the proof in the Workfront Proofing system for reviewer access and audit trail.. Valid values are `^https?://.*$`',
    CONSTRAINT pk_proof PRIMARY KEY(`proof_id`)
) COMMENT 'Captures each formal proofing round submitted for client or internal review via Workfront Proofing. Records proof type (concept, copy, layout, final art, legal, accessibility), proof stage (internal, client round 1/2/3, final), reviewer assignments, due date, submission timestamp, overall proof decision (approved, approved-with-changes, rejected), and decision timestamp. Distinct from asset_version in that a proof is a formal review event with stakeholder decisions and SLA tracking, not merely a file iteration. Supports agency SLA compliance reporting on review turnaround times.';

CREATE OR REPLACE TABLE `advertising_ecm`.`creative`.`spec` (
    `spec_id` BIGINT COMMENT 'Unique identifier for the creative specification record. Primary key.',
    `ad_format_id` BIGINT COMMENT 'Foreign key linking to media.ad_format. Business justification: Creative specs are defined to meet media ad format requirements (IAB standard units, dimensions, file constraints). Linking spec to ad_format enables cross-domain trafficking compatibility reporting, ',
    `publisher_id` BIGINT COMMENT 'Foreign key linking to vendor.publisher. Business justification: Ad ops spec management: creative specs are publisher-specific, defining acceptable formats, file sizes, and technical requirements per publisher inventory. Ad ops teams build and maintain spec librari',
    `ad_unit_type` STRING COMMENT 'The type of ad unit (e.g., Banner, Interstitial, Video, Native, Story, Carousel, Sponsored Post, Billboard, Transit Shelter).',
    `animation_loop_allowed` BOOLEAN COMMENT 'Indicates whether animated creatives (GIF, HTML5) are allowed to loop continuously (True) or must play once (False).',
    `aspect_ratio` STRING COMMENT 'The aspect ratio of the creative (e.g., 16:9, 9:16, 1:1, 4:5). Used for video and image formats.',
    `audio_channels` STRING COMMENT 'The required audio channel configuration (mono, stereo, surround). Null for non-audio formats.. Valid values are `mono|stereo|surround`',
    `audio_codec` STRING COMMENT 'The required audio codec for video or audio creatives (e.g., AAC, MP3, Vorbis). Null for non-audio formats.',
    `audio_sample_rate_hz` STRING COMMENT 'The required audio sample rate in Hertz (e.g., 44100, 48000). Null for non-audio formats.',
    `bit_rate_kbps` STRING COMMENT 'The required or recommended bit rate for video or audio creatives in kilobits per second (Kbps). Null for non-media formats.',
    `bleed_pixels` STRING COMMENT 'The bleed area in pixels extending beyond the trim edge for print creatives to ensure no white edges after cutting.',
    `brand_safety_level` STRING COMMENT 'The brand safety level required for creatives using this specification (standard, moderate, strict). Determines content restrictions and placement guidelines.. Valid values are `standard|moderate|strict`',
    `clickable_required` BOOLEAN COMMENT 'Indicates whether the creative must include a clickable call-to-action or link (True) or can be non-interactive (False).',
    `color_mode` STRING COMMENT 'The required color mode for the creative (RGB for digital, CMYK for print, Grayscale, Pantone for brand-specific print).. Valid values are `rgb|cmyk|grayscale|pantone`',
    `color_profile` STRING COMMENT 'The ICC color profile required for the creative (e.g., sRGB, Adobe RGB, CMYK US Web Coated SWOP v2).',
    `compliance_tags` STRING COMMENT 'Comma-separated list of compliance or regulatory tags applicable to this specification (e.g., GDPR, COPPA, Alcohol Restricted, Pharma Compliant).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this creative specification record was first created in the system.',
    `effective_date` DATE COMMENT 'The date from which this specification version becomes effective and should be used for new creative production.',
    `expiration_date` DATE COMMENT 'The date after which this specification version is no longer valid and should not be used for new creative production. Null for specifications without expiration.',
    `file_format` STRING COMMENT 'The required file format for the creative asset (e.g., JPG, PNG, GIF, MP4, MOV, WEBM, MP3, WAV, HTML5, PDF, EPS, AI, PSD). [ENUM-REF-CANDIDATE: jpg|png|gif|mp4|mov|webm|mp3|wav|html5|pdf|eps|ai|psd|other — 14 candidates stripped; promote to reference product]',
    `format_category` STRING COMMENT 'High-level category of the creative format (static image, animated image, video, audio, HTML5, rich media, native, interactive, print, physical). [ENUM-REF-CANDIDATE: static_image|animated_image|video|audio|html5|rich_media|native|interactive|print|physical — 10 candidates stripped; promote to reference product]',
    `frame_rate_fps` STRING COMMENT 'The required or recommended frame rate for video creatives in frames per second (e.g., 24, 30, 60). Null for non-video formats.',
    `height_pixels` STRING COMMENT 'The height dimension of the ad unit in pixels. Null for non-digital formats.',
    `iab_standard_unit` STRING COMMENT 'The IAB standard ad unit designation if this specification conforms to an IAB standard (e.g., Medium Rectangle, Leaderboard, Skyscraper).',
    `max_animation_loops` STRING COMMENT 'The maximum number of times an animated creative is allowed to loop. Null if unlimited or not applicable.',
    `max_duration_seconds` DECIMAL(18,2) COMMENT 'The maximum duration for video or audio creatives in seconds. Null for non-time-based formats.',
    `max_file_size_kb` STRING COMMENT 'The maximum allowed file size for the creative asset in kilobytes (KB).',
    `min_duration_seconds` DECIMAL(18,2) COMMENT 'The minimum duration for video or audio creatives in seconds. Null for non-time-based formats.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this creative specification record was last modified.',
    `notes` STRING COMMENT 'Additional notes, guidelines, or special instructions for creative teams regarding this specification (e.g., platform-specific quirks, best practices, known issues).',
    `platform` STRING COMMENT 'The advertising platform or channel for which this specification applies (e.g., Google CM360, Meta, TikTok, LinkedIn, OOH Print, DOOH Digital, CTV, OTT). [ENUM-REF-CANDIDATE: google_cm360|meta|tiktok|linkedin|twitter|snapchat|pinterest|amazon_dsp|the_trade_desk|dv360|youtube|ooh_print|dooh_digital|ctv|ott|email|display_network|native|audio|other — promote to reference product]',
    `platform_spec_version` STRING COMMENT 'The version of the platform-specific specification this record is based on (e.g., Meta Q1 2024, Google CM360 v3.2). Used to track spec changes as platforms update requirements.',
    `resolution_dpi` STRING COMMENT 'The required resolution for print or high-resolution digital creatives in dots per inch (DPI). Typically 300 DPI for print, 72 DPI for web.',
    `safe_zone_pixels` STRING COMMENT 'The safe zone margin in pixels where critical content (text, logos) must remain to avoid being cut off during display or printing.',
    `spec_code` STRING COMMENT 'Unique business identifier code for the specification, used for system integration and asset validation workflows.',
    `spec_name` STRING COMMENT 'Human-readable name for the creative specification (e.g., Facebook Feed Image Standard, Google Display 300x250, Instagram Story Video).',
    `spec_status` STRING COMMENT 'Current lifecycle status of the creative specification (active, deprecated, draft, archived, pending approval, retired).. Valid values are `active|deprecated|draft|archived|pending_approval|retired`',
    `transparency_allowed` BOOLEAN COMMENT 'Indicates whether the creative format supports transparency (alpha channel) in images (True) or requires opaque backgrounds (False).',
    `video_codec` STRING COMMENT 'The required video codec for video creatives (e.g., H.264, H.265, VP9). Null for non-video formats.',
    `width_pixels` STRING COMMENT 'The width dimension of the ad unit in pixels. Null for non-digital formats.',
    CONSTRAINT pk_spec PRIMARY KEY(`spec_id`)
) COMMENT 'Reference entity defining the technical and creative specifications for a deliverable format — including ad unit dimensions, file format, max file size, safe zones, bleed, color mode, frame rate, bit rate, audio specs, and platform-specific requirements (IAB standard units, Google CM360 specs, Meta ad specs, OOH print specs). Versioned to track spec changes as platforms update requirements (e.g., Meta quarterly spec updates, IAB new format releases). Acts as the specification template against which assets are validated for format compliance before trafficking. Maintained by the creative technology team with platform update monitoring.';

CREATE OR REPLACE TABLE `advertising_ecm`.`creative`.`brand_guideline` (
    `brand_guideline_id` BIGINT COMMENT 'Unique identifier for the creative brand guideline record. Primary key.',
    `brand_id` BIGINT COMMENT 'Reference to the client brand that this guideline governs. Links to the client brand master.',
    `approval_authority` STRING COMMENT 'The person or role with authority to approve changes to this brand guideline (e.g., Chief Brand Officer, Client CMO).',
    `compliance_threshold_score` DECIMAL(18,2) COMMENT 'Minimum compliance score (0-100) required for creative assets to pass brand compliance validation during review and production QA.',
    `compliance_validation_enabled` BOOLEAN COMMENT 'Flag indicating whether automated brand compliance validation is enabled for creative assets produced under this guideline.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this brand guideline record was first created in the system.',
    `digital_asset_management_url` STRING COMMENT 'URL or reference to the location of the full brand guideline document in the Digital Asset Management system (e.g., Workfront DAM, Adobe Experience Manager).',
    `do_examples` STRING COMMENT 'Positive examples demonstrating correct application of brand guidelines. Used for training and reference during creative production.',
    `dont_examples` STRING COMMENT 'Negative examples showing incorrect or prohibited uses of brand elements. Critical for compliance validation and creative QA.',
    `effective_date` DATE COMMENT 'The date from which this brand guideline becomes active and enforceable for creative production.',
    `expiration_date` DATE COMMENT 'The date on which this brand guideline is no longer valid or has been superseded. Nullable for guidelines with no planned end date.',
    `format_specifications` STRING COMMENT 'Technical specifications for creative asset formats including file types, dimensions, resolution, color space, and compression standards for different channels (digital, print, OOH, OTT, CTV).',
    `guideline_description` STRING COMMENT 'Detailed description of the scope, purpose, and coverage of this brand guideline document.',
    `guideline_status` STRING COMMENT 'Current lifecycle status of the brand guideline. Indicates whether the guideline is in draft, actively used, archived, superseded by a newer version, or under review.. Valid values are `draft|active|archived|superseded|under_review`',
    `guideline_version` STRING COMMENT 'Version identifier for this brand guideline (e.g., v3.2, 2024.1). Supports version control and change tracking.',
    `imagery_style_guidelines` STRING COMMENT 'Guidelines governing photography and imagery style including subject matter, composition, lighting, color treatment, and mood. Ensures visual consistency.',
    `last_reviewed_date` DATE COMMENT 'The date when this brand guideline was last reviewed for accuracy and relevance.',
    `logo_clear_space_minimum` STRING COMMENT 'Minimum clear space required around the logo, typically expressed as a multiple of a logo element (e.g., 2x height of logo mark).',
    `logo_minimum_size` STRING COMMENT 'Minimum allowable size for logo reproduction across different media (print, digital, OOH), ensuring legibility and brand integrity.',
    `logo_usage_rules` STRING COMMENT 'Comprehensive rules for logo placement, sizing, clear space, minimum size, color variations, and prohibited uses. Critical for brand compliance validation.',
    `messaging_guidelines` STRING COMMENT 'Key messaging pillars, brand promises, value propositions, and approved language for brand communications.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this brand guideline record was last modified or updated.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next review of this brand guideline to ensure it remains current and aligned with brand strategy.',
    `primary_color_palette` STRING COMMENT 'Approved primary brand colors in multiple formats (hex, Pantone, CMYK, RGB). Stored as structured text or JSON for parsing by creative tools.',
    `primary_typeface` STRING COMMENT 'The primary approved typeface or font family for brand communications (e.g., Helvetica Neue, Gotham).',
    `source_system` STRING COMMENT 'The system or platform from which this brand guideline was sourced (e.g., Client Brand Portal, Workfront DAM, Adobe Creative Cloud).',
    `tone_of_voice` STRING COMMENT 'Defined brand voice and tone characteristics for written communications (e.g., friendly and approachable, authoritative and professional).',
    `typography_rules` STRING COMMENT 'Detailed rules governing typography usage including font weights, sizes, line spacing, letter spacing, and hierarchy. Stored as structured text or JSON.',
    CONSTRAINT pk_brand_guideline PRIMARY KEY(`brand_guideline_id`)
) COMMENT 'Reference master for client brand guidelines governing creative production — including approved color palettes (hex, Pantone, CMYK, RGB), typography (typefaces, weights, sizes), logo usage rules, imagery style, tone of voice, do/dont examples, and brand compliance thresholds. Serves as the SSOT for brand compliance validation during creative review and production QA. Scope boundary: this entity owns the operational production ruleset (visual specs, typography rules, logo placement constraints) used by creative teams in day-to-day asset production. It does NOT own brand strategy, positioning, architecture, or competitive intelligence — those belong to the brand domain. Sourced from client brand portals and maintained by the creative services team.';

CREATE OR REPLACE TABLE `advertising_ecm`.`creative`.`creative_deliverable` (
    `creative_deliverable_id` BIGINT COMMENT 'Unique identifier for the creative deliverable. Primary key.',
    `ad_format_id` BIGINT COMMENT 'Foreign key linking to media.ad_format. Business justification: Creative deliverables are produced for specific ad formats defined in the media plan. Linking deliverables to the media ad_format taxonomy enables trafficking teams to validate format compliance, supp',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser client for whom this deliverable is being produced.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to creative.creative_asset. Business justification: A deliverable is fulfilled by a creative asset (the actual digital file in the DAM). The creative_deliverable table currently has dam_asset_id as a STRING, which should be normalized to a proper FK to',
    `brand_id` BIGINT COMMENT 'Foreign key linking to client.client_brand. Business justification: Creative deliverables are brand-specific assets. Brand compliance status tracking, brand-level delivery reporting, and brand guideline adherence checks on deliverables all require a direct brand FK. c',
    `campaign_id` BIGINT COMMENT 'Reference to the campaign this deliverable supports.',
    `contract_deliverable_id` BIGINT COMMENT 'Foreign key linking to contract.deliverable. Business justification: Contract deliverables define what must be produced per agreement; creative_deliverable tracks actual creative execution. Linking these enables acceptance tracking, milestone completion validation, bil',
    `contract_insertion_order_id` BIGINT COMMENT 'Foreign key linking to contract.contract_insertion_order. Business justification: Creative deliverables fulfill specific contract insertion orders — the IO specifies placement, format, and flight that the deliverable must satisfy for trafficking. Named process: deliverable fulfill',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Deliverables are produced by specific departments/studios tracked as cost centers. Enables cost allocation, departmental utilization reporting, and chargeback accounting for deliverable production cos',
    `creative_brief_id` BIGINT COMMENT 'Reference to the creative brief that defines the requirements for this deliverable.',
    `deliverable_tracker_id` BIGINT COMMENT 'Foreign key linking to project.deliverable_tracker. Business justification: The creative_deliverable (creative domain record) must reconcile with the deliverable_tracker (project domain record) for unified delivery status reporting. Advertising agencies track deliverables in ',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Deliverables are outputs of initiatives. Linking enables scope validation, milestone tracking, client reporting, and deliverable inventory management across the initiative lifecycle. Critical for proj',
    `media_placement_id` BIGINT COMMENT 'Foreign key linking to media.media_placement. Business justification: Creative deliverables are produced for specific media placements. Trafficking teams must know which deliverable is assigned to which placement to execute ad serving. This placement-to-deliverable assi',
    `milestone_id` BIGINT COMMENT 'Foreign key linking to project.project_milestone. Business justification: Deliverables are tied to contractual milestones. Linking enables billing trigger validation, client acceptance tracking, payment release management, and SOW compliance verification. Essential for reve',
    `persona_id` BIGINT COMMENT 'Foreign key linking to audience.persona. Business justification: Persona-based creative strategy requires deliverables to be assigned to specific personas (e.g., produce a 30s video for the Urban Millennial persona). Persona-level deliverable tracking drives pers',
    `plan_id` BIGINT COMMENT 'Foreign key linking to media.media_plan. Business justification: Deliverables are produced to fulfill media plan requirements. Creative teams need to know which plan drives each deliverable to ensure formats, specs, and deadlines align with media flight dates and c',
    `production_job_id` BIGINT COMMENT 'Foreign key linking to creative.production_job. Business justification: A creative deliverable is the output produced by a production job. This is a direct operational relationship: the production job is the unit of work that creates the deliverable. Cardinality: N:1 (one',
    `project_budget_id` BIGINT COMMENT 'Foreign key linking to project.project_budget. Business justification: Deliverables have budget allocations. Linking enables cost-to-deliver tracking, profitability analysis, budget forecasting, and financial reporting. Critical for project financial management and prici',
    `rate_card_line_id` BIGINT COMMENT 'Foreign key linking to contract.rate_card_line. Business justification: Creative deliverables are billed at rates defined by contract rate card lines (e.g., per-asset production fee, per-format creative rate). Linking deliverable to rate_card_line enables accurate billing',
    `segment_id` BIGINT COMMENT 'Foreign key linking to audience.segment. Business justification: Deliverables are tailored to audience segments; trafficking workflows and media plan execution require segment-level creative mapping to ensure correct creative serves to each audience, essential for ',
    `sla_id` BIGINT COMMENT 'Foreign key linking to contract.sla. Business justification: Creative deliverables are subject to contracted SLA terms governing turnaround times, revision cycles, and delivery standards. Agencies track SLA compliance per deliverable for performance reporting a',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Creative deliverables fulfill contractual obligations defined in SOWs. Tracking this link enables acceptance criteria validation, milestone-based invoicing, client sign-off workflows, and ensures deli',
    `spec_id` BIGINT COMMENT 'Foreign key linking to creative.creative_spec. Business justification: Deliverables must conform to creative specifications (platform requirements, format constraints, technical specs). The creative_deliverable table has format_specification as a STRING, which should be ',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Deliverables produced by external vendors need vendor tracking for invoice reconciliation, quality management, SLA monitoring, and vendor performance evaluation. Essential for production operations an',
    `task_id` BIGINT COMMENT 'Foreign key linking to project.task. Business justification: Creative deliverables are produced by specific project tasks (e.g., Copywriting Task, Design Task). Linking creative_deliverable to task enables task-level deliverable attribution, effort-to-deliv',
    `work_package_id` BIGINT COMMENT 'Foreign key linking to project.work_package. Business justification: Deliverables map to specific work packages in WBS. Linking enables granular schedule tracking, resource allocation, earned value management, and deliverable-level progress reporting. Essential for pro',
    `accepted_date` DATE COMMENT 'Date when the client formally accepted the deliverable and signed off on completion.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual total production cost incurred for this deliverable, used for financial reconciliation and profitability analysis.',
    `actual_hours` DECIMAL(18,2) COMMENT 'Actual number of labor hours spent producing this deliverable, tracked for billing and performance analysis.',
    `assigned_copywriter` STRING COMMENT 'Name of the copywriter assigned to develop copy and messaging for this deliverable.',
    `assigned_creative_team` STRING COMMENT 'Name or identifier of the creative team or studio responsible for producing this deliverable.',
    `brand_compliance_status` STRING COMMENT 'Indicates whether the deliverable meets brand guideline requirements and has passed brand compliance review.. Valid values are `compliant|non_compliant|pending_review|not_applicable`',
    `channel` STRING COMMENT 'Media channel where the deliverable will be deployed. [ENUM-REF-CANDIDATE: tv|ctv|ott|radio|print|ooh|dooh|display|social|search|email|website — 12 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this deliverable record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for cost and billing amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `deliverable_code` STRING COMMENT 'Unique business identifier or tracking code for the deliverable used across systems (e.g., SUMR-2024-TV-30S-001).',
    `deliverable_name` STRING COMMENT 'Human-readable name of the creative deliverable (e.g., 30s TV Spot - Summer Campaign, MPU 300x250 HTML5 Banner).',
    `deliverable_status` STRING COMMENT 'Current lifecycle status of the creative deliverable in the production and approval workflow. [ENUM-REF-CANDIDATE: not_started|in_production|in_review|revisions_requested|approved|delivered|accepted|rejected|on_hold|cancelled — 10 candidates stripped; promote to reference product]',
    `deliverable_type` STRING COMMENT 'Category of creative deliverable based on media format and channel. [ENUM-REF-CANDIDATE: video|display_banner|social_media_post|print_ad|audio_spot|ooh_creative|dooh_creative|email_creative|landing_page — 9 candidates stripped; promote to reference product]',
    `delivered_date` DATE COMMENT 'Date when the deliverable was delivered to the client or uploaded to the delivery platform.',
    `delivery_method` STRING COMMENT 'Method by which the deliverable was or will be delivered to the client or trafficking system.. Valid values are `email|ftp|cloud_storage|dam_portal|physical_media|api`',
    `dimensions` STRING COMMENT 'Physical or pixel dimensions of the deliverable (e.g., 300x250, 1920x1080, 8.5x11 inches).',
    `due_date` DATE COMMENT 'Contractual deadline by which the deliverable must be completed and delivered to the client.',
    `duration_seconds` STRING COMMENT 'Duration of the creative deliverable in seconds, applicable to video and audio formats (e.g., 15, 30, 60).',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Estimated total production cost for this deliverable including labor, materials, and third-party services.',
    `estimated_hours` DECIMAL(18,2) COMMENT 'Estimated number of labor hours required to complete this deliverable, used for resource planning and costing.',
    `file_format` STRING COMMENT 'File format of the final deliverable asset (e.g., MP4, HTML5, PDF, JPEG). [ENUM-REF-CANDIDATE: mp4|mov|avi|jpg|png|gif|html5|pdf|psd|ai|indd|wav|mp3 — 13 candidates stripped; promote to reference product]',
    `file_size_mb` DECIMAL(18,2) COMMENT 'Size of the final deliverable file in megabytes, used for storage planning and delivery validation.',
    `legal_approval_required` BOOLEAN COMMENT 'Flag indicating whether this deliverable requires legal review and approval before delivery (e.g., for claims, disclaimers, regulatory compliance).',
    `legal_approval_status` STRING COMMENT 'Current status of legal review and approval for this deliverable.. Valid values are `not_required|pending|approved|rejected|conditional`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this deliverable record was last modified.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or context about the deliverable.',
    `priority` STRING COMMENT 'Business priority level assigned to this deliverable for resource allocation and scheduling.. Valid values are `critical|high|medium|low`',
    `production_start_date` DATE COMMENT 'Date when production work on this deliverable began.',
    `quantity_required` STRING COMMENT 'Number of units or versions of this deliverable required (e.g., 3 language versions, 5 size variations).',
    `requested_date` DATE COMMENT 'Date when the deliverable was originally requested by the client or account team.',
    `revision_count` STRING COMMENT 'Number of revision cycles this deliverable has undergone since initial submission.',
    `version_number` STRING COMMENT 'Version identifier for the deliverable to track iterations and revisions (e.g., v1.0, v2.3, Final).',
    CONSTRAINT pk_creative_deliverable PRIMARY KEY(`creative_deliverable_id`)
) COMMENT 'Represents a specific creative deliverable committed to a client or campaign — a named output (e.g., 30s TV spot :30, MPU 300x250 HTML5 banner, Full-page print ad) with defined format, channel, quantity, and delivery deadline. Links the creative brief requirement to the production job and final approved asset. Tracks deliverable status (not-started, in-production, delivered, accepted) and client acceptance sign-off. Serves as the contractual unit of creative output.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ADD CONSTRAINT `fk_creative_creative_brief_brand_guideline_id` FOREIGN KEY (`brand_guideline_id`) REFERENCES `advertising_ecm`.`creative`.`brand_guideline`(`brand_guideline_id`);
ALTER TABLE `advertising_ecm`.`creative`.`asset` ADD CONSTRAINT `fk_creative_asset_creative_brief_id` FOREIGN KEY (`creative_brief_id`) REFERENCES `advertising_ecm`.`creative`.`creative_brief`(`creative_brief_id`);
ALTER TABLE `advertising_ecm`.`creative`.`asset` ADD CONSTRAINT `fk_creative_asset_parent_asset_creative_asset_id` FOREIGN KEY (`parent_asset_creative_asset_id`) REFERENCES `advertising_ecm`.`creative`.`asset`(`asset_id`);
ALTER TABLE `advertising_ecm`.`creative`.`asset` ADD CONSTRAINT `fk_creative_asset_production_job_id` FOREIGN KEY (`production_job_id`) REFERENCES `advertising_ecm`.`creative`.`production_job`(`production_job_id`);
ALTER TABLE `advertising_ecm`.`creative`.`asset` ADD CONSTRAINT `fk_creative_asset_spec_id` FOREIGN KEY (`spec_id`) REFERENCES `advertising_ecm`.`creative`.`spec`(`spec_id`);
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ADD CONSTRAINT `fk_creative_asset_version_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `advertising_ecm`.`creative`.`asset`(`asset_id`);
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ADD CONSTRAINT `fk_creative_asset_version_creative_deliverable_id` FOREIGN KEY (`creative_deliverable_id`) REFERENCES `advertising_ecm`.`creative`.`creative_deliverable`(`creative_deliverable_id`);
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ADD CONSTRAINT `fk_creative_asset_version_production_job_id` FOREIGN KEY (`production_job_id`) REFERENCES `advertising_ecm`.`creative`.`production_job`(`production_job_id`);
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ADD CONSTRAINT `fk_creative_asset_version_spec_id` FOREIGN KEY (`spec_id`) REFERENCES `advertising_ecm`.`creative`.`spec`(`spec_id`);
ALTER TABLE `advertising_ecm`.`creative`.`concept` ADD CONSTRAINT `fk_creative_concept_parent_concept_id` FOREIGN KEY (`parent_concept_id`) REFERENCES `advertising_ecm`.`creative`.`concept`(`concept_id`);
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ADD CONSTRAINT `fk_creative_production_job_concept_id` FOREIGN KEY (`concept_id`) REFERENCES `advertising_ecm`.`creative`.`concept`(`concept_id`);
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ADD CONSTRAINT `fk_creative_production_job_creative_brief_id` FOREIGN KEY (`creative_brief_id`) REFERENCES `advertising_ecm`.`creative`.`creative_brief`(`creative_brief_id`);
ALTER TABLE `advertising_ecm`.`creative`.`proof` ADD CONSTRAINT `fk_creative_proof_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `advertising_ecm`.`creative`.`asset_version`(`asset_version_id`);
ALTER TABLE `advertising_ecm`.`creative`.`proof` ADD CONSTRAINT `fk_creative_proof_creative_deliverable_id` FOREIGN KEY (`creative_deliverable_id`) REFERENCES `advertising_ecm`.`creative`.`creative_deliverable`(`creative_deliverable_id`);
ALTER TABLE `advertising_ecm`.`creative`.`proof` ADD CONSTRAINT `fk_creative_proof_production_job_id` FOREIGN KEY (`production_job_id`) REFERENCES `advertising_ecm`.`creative`.`production_job`(`production_job_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ADD CONSTRAINT `fk_creative_creative_deliverable_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `advertising_ecm`.`creative`.`asset`(`asset_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ADD CONSTRAINT `fk_creative_creative_deliverable_creative_brief_id` FOREIGN KEY (`creative_brief_id`) REFERENCES `advertising_ecm`.`creative`.`creative_brief`(`creative_brief_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ADD CONSTRAINT `fk_creative_creative_deliverable_production_job_id` FOREIGN KEY (`production_job_id`) REFERENCES `advertising_ecm`.`creative`.`production_job`(`production_job_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ADD CONSTRAINT `fk_creative_creative_deliverable_spec_id` FOREIGN KEY (`spec_id`) REFERENCES `advertising_ecm`.`creative`.`spec`(`spec_id`);

-- ========= TAGS =========
ALTER SCHEMA `advertising_ecm`.`creative` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `advertising_ecm`.`creative` SET TAGS ('dbx_domain' = 'creative');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` SET TAGS ('dbx_subdomain' = 'brief_strategy');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `creative_brief_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Brief ID');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `agency_relationship_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Relationship Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `brand_guideline_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Guideline Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brand ID');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `project_brief_id` SET TAGS ('dbx_business_glossary_term' = 'Project Brief Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `persona_id` SET TAGS ('dbx_business_glossary_term' = 'Target Persona Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Brief Approved Date');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `art_director_assigned` SET TAGS ('dbx_business_glossary_term' = 'Art Director Assigned');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `brief_name` SET TAGS ('dbx_business_glossary_term' = 'Creative Brief Name');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `brief_number` SET TAGS ('dbx_business_glossary_term' = 'Creative Brief Number');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `brief_number` SET TAGS ('dbx_value_regex' = '^CB-[0-9]{6,10}$');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `brief_type` SET TAGS ('dbx_business_glossary_term' = 'Creative Brief Type');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `brief_type` SET TAGS ('dbx_value_regex' = 'campaign|tactical|evergreen|seasonal|product_launch|rebranding');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `business_objective` SET TAGS ('dbx_business_glossary_term' = 'Business Objective');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `call_to_action` SET TAGS ('dbx_business_glossary_term' = 'Call to Action (CTA)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `channel_distribution` SET TAGS ('dbx_business_glossary_term' = 'Channel Distribution');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `competitive_context` SET TAGS ('dbx_business_glossary_term' = 'Competitive Context');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `copywriter_assigned` SET TAGS ('dbx_business_glossary_term' = 'Copywriter Assigned');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `creative_brief_status` SET TAGS ('dbx_business_glossary_term' = 'Creative Brief Status');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `creative_brief_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|in_production|completed|cancelled');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `creative_director_assigned` SET TAGS ('dbx_business_glossary_term' = 'Creative Director Assigned');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `deliverable_formats` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Formats');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Creative Brief Due Date');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `key_message` SET TAGS ('dbx_business_glossary_term' = 'Key Message');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `legal_regulatory_requirements` SET TAGS ('dbx_business_glossary_term' = 'Legal and Regulatory Requirements');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `mandatories` SET TAGS ('dbx_business_glossary_term' = 'Mandatories');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Creative Brief Notes');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Creative Brief Priority');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|urgent');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Brief Submitted Date');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `success_metrics` SET TAGS ('dbx_business_glossary_term' = 'Success Metrics');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `supporting_messages` SET TAGS ('dbx_business_glossary_term' = 'Supporting Messages');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `target_audience_description` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Description');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `tone_of_voice` SET TAGS ('dbx_business_glossary_term' = 'Tone of Voice');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Creative Brief Version Number');
ALTER TABLE `advertising_ecm`.`creative`.`asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`creative`.`asset` SET TAGS ('dbx_subdomain' = 'production_delivery');
ALTER TABLE `advertising_ecm`.`creative`.`asset` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset ID');
ALTER TABLE `advertising_ecm`.`creative`.`asset` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brand ID');
ALTER TABLE `advertising_ecm`.`creative`.`asset` ALTER COLUMN `creative_brief_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Brief Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`asset` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`asset` ALTER COLUMN `parent_asset_creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Asset ID');
ALTER TABLE `advertising_ecm`.`creative`.`asset` ALTER COLUMN `persona_id` SET TAGS ('dbx_business_glossary_term' = 'Persona Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`asset` ALTER COLUMN `production_job_id` SET TAGS ('dbx_business_glossary_term' = 'Production Job Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`asset` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Segment Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`asset` ALTER COLUMN `spec_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Spec Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`asset` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`asset` ALTER COLUMN `task_id` SET TAGS ('dbx_business_glossary_term' = 'Task Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`asset` ALTER COLUMN `work_package_id` SET TAGS ('dbx_business_glossary_term' = 'Work Package Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`asset` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`asset` ALTER COLUMN `archived_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Archived Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`asset` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `advertising_ecm`.`creative`.`asset` ALTER COLUMN `asset_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Name');
ALTER TABLE `advertising_ecm`.`creative`.`asset` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Type');
ALTER TABLE `advertising_ecm`.`creative`.`asset` ALTER COLUMN `brand_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Brand Compliance Status');
ALTER TABLE `advertising_ecm`.`creative`.`asset` ALTER COLUMN `brand_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review|not_applicable');
ALTER TABLE `advertising_ecm`.`creative`.`asset` ALTER COLUMN `campaign_theme` SET TAGS ('dbx_business_glossary_term' = 'Campaign Theme');
ALTER TABLE `advertising_ecm`.`creative`.`asset` ALTER COLUMN `channel_suitability` SET TAGS ('dbx_business_glossary_term' = 'Channel Suitability');
ALTER TABLE `advertising_ecm`.`creative`.`asset` ALTER COLUMN `codec` SET TAGS ('dbx_business_glossary_term' = 'Codec');
ALTER TABLE `advertising_ecm`.`creative`.`asset` ALTER COLUMN `color_profile` SET TAGS ('dbx_business_glossary_term' = 'Color Profile');
ALTER TABLE `advertising_ecm`.`creative`.`asset` ALTER COLUMN `copyright_holder` SET TAGS ('dbx_business_glossary_term' = 'Copyright Holder');
ALTER TABLE `advertising_ecm`.`creative`.`asset` ALTER COLUMN `copyright_holder` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`creative`.`asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`asset` ALTER COLUMN `creative_asset_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Description');
ALTER TABLE `advertising_ecm`.`creative`.`asset` ALTER COLUMN `dam_asset_ref` SET TAGS ('dbx_business_glossary_term' = 'Digital Asset Management (DAM) Asset ID');
ALTER TABLE `advertising_ecm`.`creative`.`asset` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Duration (Seconds)');
ALTER TABLE `advertising_ecm`.`creative`.`asset` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `advertising_ecm`.`creative`.`asset` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size (Bytes)');
ALTER TABLE `advertising_ecm`.`creative`.`asset` ALTER COLUMN `file_storage_path` SET TAGS ('dbx_business_glossary_term' = 'File Storage Path');
ALTER TABLE `advertising_ecm`.`creative`.`asset` ALTER COLUMN `file_storage_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`creative`.`asset` ALTER COLUMN `geographic_market` SET TAGS ('dbx_business_glossary_term' = 'Geographic Market');
ALTER TABLE `advertising_ecm`.`creative`.`asset` ALTER COLUMN `is_master_asset` SET TAGS ('dbx_business_glossary_term' = 'Is Master Asset');
ALTER TABLE `advertising_ecm`.`creative`.`asset` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `advertising_ecm`.`creative`.`asset` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'License Type');
ALTER TABLE `advertising_ecm`.`creative`.`asset` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Stage');
ALTER TABLE `advertising_ecm`.`creative`.`asset` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_value_regex' = 'wip|in_review|approved|published|archived|expired');
ALTER TABLE `advertising_ecm`.`creative`.`asset` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`asset` ALTER COLUMN `mood_tags` SET TAGS ('dbx_business_glossary_term' = 'Mood Tags');
ALTER TABLE `advertising_ecm`.`creative`.`asset` ALTER COLUMN `resolution` SET TAGS ('dbx_business_glossary_term' = 'Resolution');
ALTER TABLE `advertising_ecm`.`creative`.`asset` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Rights Clearance Status');
ALTER TABLE `advertising_ecm`.`creative`.`asset` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|restricted|expired');
ALTER TABLE `advertising_ecm`.`creative`.`asset` ALTER COLUMN `rights_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Rights Expiry Date');
ALTER TABLE `advertising_ecm`.`creative`.`asset` ALTER COLUMN `subject_tags` SET TAGS ('dbx_business_glossary_term' = 'Subject Tags');
ALTER TABLE `advertising_ecm`.`creative`.`asset` ALTER COLUMN `thumbnail_url` SET TAGS ('dbx_business_glossary_term' = 'Thumbnail URL');
ALTER TABLE `advertising_ecm`.`creative`.`asset` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `advertising_ecm`.`creative`.`asset` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` SET TAGS ('dbx_subdomain' = 'production_delivery');
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Version Identifier (ID)');
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ALTER COLUMN `creative_deliverable_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Deliverable Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ALTER COLUMN `deliverable_tracker_id` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Tracker Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ALTER COLUMN `production_job_id` SET TAGS ('dbx_business_glossary_term' = 'Production Job Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ALTER COLUMN `spec_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Spec Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ALTER COLUMN `task_id` SET TAGS ('dbx_business_glossary_term' = 'Task Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ALTER COLUMN `adobe_cc_document_version_ref` SET TAGS ('dbx_business_glossary_term' = 'Adobe Creative Cloud (CC) Document Version Identifier (ID)');
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ALTER COLUMN `archive_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Archive Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ALTER COLUMN `brand_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Brand Compliance Status');
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ALTER COLUMN `brand_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review|not_applicable');
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ALTER COLUMN `change_summary` SET TAGS ('dbx_business_glossary_term' = 'Change Summary');
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ALTER COLUMN `checksum_hash` SET TAGS ('dbx_business_glossary_term' = 'Checksum Hash');
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ALTER COLUMN `color_profile` SET TAGS ('dbx_business_glossary_term' = 'Color Profile');
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ALTER COLUMN `compliance_check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Duration in Seconds');
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ALTER COLUMN `file_name` SET TAGS ('dbx_business_glossary_term' = 'File Name');
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ALTER COLUMN `file_path` SET TAGS ('dbx_business_glossary_term' = 'File Path');
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size in Bytes');
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ALTER COLUMN `height_pixels` SET TAGS ('dbx_business_glossary_term' = 'Height in Pixels');
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ALTER COLUMN `is_archived` SET TAGS ('dbx_business_glossary_term' = 'Is Archived Flag');
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ALTER COLUMN `is_promoted` SET TAGS ('dbx_business_glossary_term' = 'Is Promoted Flag');
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ALTER COLUMN `promotion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Promotion Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ALTER COLUMN `resolution_dpi` SET TAGS ('dbx_business_glossary_term' = 'Resolution in Dots Per Inch (DPI)');
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ALTER COLUMN `version_label` SET TAGS ('dbx_business_glossary_term' = 'Version Label');
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ALTER COLUMN `version_status` SET TAGS ('dbx_business_glossary_term' = 'Version Status');
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ALTER COLUMN `version_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|rejected|superseded|archived');
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ALTER COLUMN `width_pixels` SET TAGS ('dbx_business_glossary_term' = 'Width in Pixels');
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ALTER COLUMN `workfront_proof_version_ref` SET TAGS ('dbx_business_glossary_term' = 'Workfront Proof Version Identifier (ID)');
ALTER TABLE `advertising_ecm`.`creative`.`concept` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`creative`.`concept` SET TAGS ('dbx_subdomain' = 'brief_strategy');
ALTER TABLE `advertising_ecm`.`creative`.`concept` ALTER COLUMN `concept_id` SET TAGS ('dbx_business_glossary_term' = 'Concept ID');
ALTER TABLE `advertising_ecm`.`creative`.`concept` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brand Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`concept` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`concept` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Project Milestone Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`concept` ALTER COLUMN `parent_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Concept ID');
ALTER TABLE `advertising_ecm`.`creative`.`concept` ALTER COLUMN `project_brief_id` SET TAGS ('dbx_business_glossary_term' = 'Project Brief Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`concept` ALTER COLUMN `persona_id` SET TAGS ('dbx_business_glossary_term' = 'Target Persona Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`concept` ALTER COLUMN `work_package_id` SET TAGS ('dbx_business_glossary_term' = 'Work Package Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`concept` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `advertising_ecm`.`creative`.`concept` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `advertising_ecm`.`creative`.`concept` ALTER COLUMN `brand_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Brand Compliance Flag');
ALTER TABLE `advertising_ecm`.`creative`.`concept` ALTER COLUMN `channel_applicability` SET TAGS ('dbx_business_glossary_term' = 'Channel Applicability');
ALTER TABLE `advertising_ecm`.`creative`.`concept` ALTER COLUMN `competitive_differentiation` SET TAGS ('dbx_business_glossary_term' = 'Competitive Differentiation');
ALTER TABLE `advertising_ecm`.`creative`.`concept` ALTER COLUMN `concept_code` SET TAGS ('dbx_business_glossary_term' = 'Concept Code');
ALTER TABLE `advertising_ecm`.`creative`.`concept` ALTER COLUMN `concept_description` SET TAGS ('dbx_business_glossary_term' = 'Concept Description');
ALTER TABLE `advertising_ecm`.`creative`.`concept` ALTER COLUMN `concept_status` SET TAGS ('dbx_business_glossary_term' = 'Concept Status');
ALTER TABLE `advertising_ecm`.`creative`.`concept` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`concept` ALTER COLUMN `creative_territory` SET TAGS ('dbx_business_glossary_term' = 'Creative Territory');
ALTER TABLE `advertising_ecm`.`creative`.`concept` ALTER COLUMN `estimated_production_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Production Cost');
ALTER TABLE `advertising_ecm`.`creative`.`concept` ALTER COLUMN `estimated_production_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`creative`.`concept` ALTER COLUMN `headline` SET TAGS ('dbx_business_glossary_term' = 'Concept Headline');
ALTER TABLE `advertising_ecm`.`creative`.`concept` ALTER COLUMN `key_message` SET TAGS ('dbx_business_glossary_term' = 'Key Message');
ALTER TABLE `advertising_ecm`.`creative`.`concept` ALTER COLUMN `legal_review_required` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Required Flag');
ALTER TABLE `advertising_ecm`.`creative`.`concept` ALTER COLUMN `legal_review_status` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Status');
ALTER TABLE `advertising_ecm`.`creative`.`concept` ALTER COLUMN `legal_review_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|rejected|conditional');
ALTER TABLE `advertising_ecm`.`creative`.`concept` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`concept` ALTER COLUMN `mood_board_reference` SET TAGS ('dbx_business_glossary_term' = 'Mood Board Reference');
ALTER TABLE `advertising_ecm`.`creative`.`concept` ALTER COLUMN `presentation_date` SET TAGS ('dbx_business_glossary_term' = 'Presentation Date');
ALTER TABLE `advertising_ecm`.`creative`.`concept` ALTER COLUMN `production_complexity` SET TAGS ('dbx_business_glossary_term' = 'Production Complexity');
ALTER TABLE `advertising_ecm`.`creative`.`concept` ALTER COLUMN `production_complexity` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `advertising_ecm`.`creative`.`concept` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `advertising_ecm`.`creative`.`concept` ALTER COLUMN `strategic_rationale` SET TAGS ('dbx_business_glossary_term' = 'Strategic Rationale');
ALTER TABLE `advertising_ecm`.`creative`.`concept` ALTER COLUMN `tagline` SET TAGS ('dbx_business_glossary_term' = 'Concept Tagline');
ALTER TABLE `advertising_ecm`.`creative`.`concept` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience');
ALTER TABLE `advertising_ecm`.`creative`.`concept` ALTER COLUMN `testing_recommendation` SET TAGS ('dbx_business_glossary_term' = 'Testing Recommendation');
ALTER TABLE `advertising_ecm`.`creative`.`concept` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Concept Title');
ALTER TABLE `advertising_ecm`.`creative`.`concept` ALTER COLUMN `tone_of_voice` SET TAGS ('dbx_business_glossary_term' = 'Tone of Voice');
ALTER TABLE `advertising_ecm`.`creative`.`concept` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Concept Version');
ALTER TABLE `advertising_ecm`.`creative`.`concept` ALTER COLUMN `visual_direction` SET TAGS ('dbx_business_glossary_term' = 'Visual Direction');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` SET TAGS ('dbx_subdomain' = 'production_delivery');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `production_job_id` SET TAGS ('dbx_business_glossary_term' = 'Production Job Identifier (ID)');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brand Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `concept_id` SET TAGS ('dbx_business_glossary_term' = 'Concept Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `creative_brief_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Brief Identifier (ID)');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Project Milestone Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `project_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Project Budget Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `sla_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `task_id` SET TAGS ('dbx_business_glossary_term' = 'Task Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `vendor_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Rate Card Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `work_package_id` SET TAGS ('dbx_business_glossary_term' = 'Work Package Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Production Cost');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `actual_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Production Hours');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `assigned_studio` SET TAGS ('dbx_business_glossary_term' = 'Assigned Studio or Production House');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `brand_compliance_required` SET TAGS ('dbx_business_glossary_term' = 'Brand Compliance Required Flag');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `brand_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Brand Compliance Status');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `brand_compliance_status` SET TAGS ('dbx_value_regex' = 'not-required|pending|passed|failed|waived');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `client_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Client Approval Date');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `client_feedback` SET TAGS ('dbx_business_glossary_term' = 'Client Feedback');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `client_feedback` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `deliverable_count` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Count');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `delivery_deadline` SET TAGS ('dbx_business_glossary_term' = 'Delivery Deadline Date');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Production Cost');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `estimated_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Production Hours');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `final_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Final Delivery Date');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `format_specifications` SET TAGS ('dbx_business_glossary_term' = 'Format Specifications');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Production Notes');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `internal_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `is_billable` SET TAGS ('dbx_business_glossary_term' = 'Billable Job Flag');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `job_description` SET TAGS ('dbx_business_glossary_term' = 'Production Job Description');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `job_name` SET TAGS ('dbx_business_glossary_term' = 'Production Job Name');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `job_number` SET TAGS ('dbx_business_glossary_term' = 'Production Job Number');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `job_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{6,8}$');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `job_status` SET TAGS ('dbx_business_glossary_term' = 'Production Job Status');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `job_type` SET TAGS ('dbx_business_glossary_term' = 'Production Job Type');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `legal_review_required` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Required Flag');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `legal_review_status` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Status');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `legal_review_status` SET TAGS ('dbx_value_regex' = 'not-required|pending|approved|rejected|conditional');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Production Priority Level');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent|critical');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `production_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Production Completion Date');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `production_start_date` SET TAGS ('dbx_business_glossary_term' = 'Production Start Date');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `revision_count` SET TAGS ('dbx_business_glossary_term' = 'Revision Count');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `sap_wbs_element` SET TAGS ('dbx_business_glossary_term' = 'SAP Work Breakdown Structure (WBS) Element');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `advertising_ecm`.`creative`.`proof` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`creative`.`proof` SET TAGS ('dbx_subdomain' = 'production_delivery');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `proof_id` SET TAGS ('dbx_business_glossary_term' = 'Proof Identifier (ID)');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Version Identifier (ID)');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `creative_deliverable_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Deliverable Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `deliverable_tracker_id` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Tracker Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Project Milestone Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `production_job_id` SET TAGS ('dbx_business_glossary_term' = 'Production Job Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `sla_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `task_id` SET TAGS ('dbx_business_glossary_term' = 'Task Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `work_package_id` SET TAGS ('dbx_business_glossary_term' = 'Work Package Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `approval_count` SET TAGS ('dbx_business_glossary_term' = 'Approval Count');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `automated_check_flag` SET TAGS ('dbx_business_glossary_term' = 'Automated Check Flag');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `automated_check_result` SET TAGS ('dbx_business_glossary_term' = 'Automated Check Result');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `automated_check_result` SET TAGS ('dbx_value_regex' = 'pass|fail|warning|not_applicable');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `comment_count` SET TAGS ('dbx_business_glossary_term' = 'Comment Count');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `decision_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Decision Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `instructions` SET TAGS ('dbx_business_glossary_term' = 'Proof Instructions');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `overall_decision` SET TAGS ('dbx_business_glossary_term' = 'Overall Decision');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `overall_decision` SET TAGS ('dbx_value_regex' = 'approved|approved_with_changes|rejected|pending');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `proof_name` SET TAGS ('dbx_business_glossary_term' = 'Proof Name');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `proof_number` SET TAGS ('dbx_business_glossary_term' = 'Proof Number');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `proof_number` SET TAGS ('dbx_value_regex' = '^PRF-[0-9]{8}$');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `proof_status` SET TAGS ('dbx_business_glossary_term' = 'Proof Status');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `proof_type` SET TAGS ('dbx_business_glossary_term' = 'Proof Type');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `rejection_count` SET TAGS ('dbx_business_glossary_term' = 'Rejection Count');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `reviewer_count` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Count');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `round_number` SET TAGS ('dbx_business_glossary_term' = 'Round Number');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `sla_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Met Flag');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `stage` SET TAGS ('dbx_business_glossary_term' = 'Proof Stage');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `stage` SET TAGS ('dbx_value_regex' = 'internal|client_round_1|client_round_2|client_round_3|final');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `turnaround_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Time (Hours)');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `url` SET TAGS ('dbx_business_glossary_term' = 'Proof Uniform Resource Locator (URL)');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `advertising_ecm`.`creative`.`spec` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `advertising_ecm`.`creative`.`spec` SET TAGS ('dbx_subdomain' = 'brief_strategy');
ALTER TABLE `advertising_ecm`.`creative`.`spec` ALTER COLUMN `spec_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Specification ID');
ALTER TABLE `advertising_ecm`.`creative`.`spec` ALTER COLUMN `ad_format_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Format Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`spec` ALTER COLUMN `publisher_id` SET TAGS ('dbx_business_glossary_term' = 'Publisher Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`spec` ALTER COLUMN `ad_unit_type` SET TAGS ('dbx_business_glossary_term' = 'Ad Unit Type');
ALTER TABLE `advertising_ecm`.`creative`.`spec` ALTER COLUMN `animation_loop_allowed` SET TAGS ('dbx_business_glossary_term' = 'Animation Loop Allowed');
ALTER TABLE `advertising_ecm`.`creative`.`spec` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `advertising_ecm`.`creative`.`spec` ALTER COLUMN `audio_channels` SET TAGS ('dbx_business_glossary_term' = 'Audio Channels');
ALTER TABLE `advertising_ecm`.`creative`.`spec` ALTER COLUMN `audio_channels` SET TAGS ('dbx_value_regex' = 'mono|stereo|surround');
ALTER TABLE `advertising_ecm`.`creative`.`spec` ALTER COLUMN `audio_codec` SET TAGS ('dbx_business_glossary_term' = 'Audio Codec');
ALTER TABLE `advertising_ecm`.`creative`.`spec` ALTER COLUMN `audio_sample_rate_hz` SET TAGS ('dbx_business_glossary_term' = 'Audio Sample Rate in Hertz (Hz)');
ALTER TABLE `advertising_ecm`.`creative`.`spec` ALTER COLUMN `bit_rate_kbps` SET TAGS ('dbx_business_glossary_term' = 'Bit Rate in Kilobits Per Second (Kbps)');
ALTER TABLE `advertising_ecm`.`creative`.`spec` ALTER COLUMN `bleed_pixels` SET TAGS ('dbx_business_glossary_term' = 'Bleed in Pixels');
ALTER TABLE `advertising_ecm`.`creative`.`spec` ALTER COLUMN `brand_safety_level` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Level');
ALTER TABLE `advertising_ecm`.`creative`.`spec` ALTER COLUMN `brand_safety_level` SET TAGS ('dbx_value_regex' = 'standard|moderate|strict');
ALTER TABLE `advertising_ecm`.`creative`.`spec` ALTER COLUMN `clickable_required` SET TAGS ('dbx_business_glossary_term' = 'Clickable Required');
ALTER TABLE `advertising_ecm`.`creative`.`spec` ALTER COLUMN `color_mode` SET TAGS ('dbx_business_glossary_term' = 'Color Mode');
ALTER TABLE `advertising_ecm`.`creative`.`spec` ALTER COLUMN `color_mode` SET TAGS ('dbx_value_regex' = 'rgb|cmyk|grayscale|pantone');
ALTER TABLE `advertising_ecm`.`creative`.`spec` ALTER COLUMN `color_profile` SET TAGS ('dbx_business_glossary_term' = 'Color Profile');
ALTER TABLE `advertising_ecm`.`creative`.`spec` ALTER COLUMN `compliance_tags` SET TAGS ('dbx_business_glossary_term' = 'Compliance Tags');
ALTER TABLE `advertising_ecm`.`creative`.`spec` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`spec` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `advertising_ecm`.`creative`.`spec` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `advertising_ecm`.`creative`.`spec` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `advertising_ecm`.`creative`.`spec` ALTER COLUMN `format_category` SET TAGS ('dbx_business_glossary_term' = 'Format Category');
ALTER TABLE `advertising_ecm`.`creative`.`spec` ALTER COLUMN `frame_rate_fps` SET TAGS ('dbx_business_glossary_term' = 'Frame Rate in Frames Per Second (FPS)');
ALTER TABLE `advertising_ecm`.`creative`.`spec` ALTER COLUMN `height_pixels` SET TAGS ('dbx_business_glossary_term' = 'Height in Pixels');
ALTER TABLE `advertising_ecm`.`creative`.`spec` ALTER COLUMN `iab_standard_unit` SET TAGS ('dbx_business_glossary_term' = 'Interactive Advertising Bureau (IAB) Standard Unit');
ALTER TABLE `advertising_ecm`.`creative`.`spec` ALTER COLUMN `max_animation_loops` SET TAGS ('dbx_business_glossary_term' = 'Maximum Animation Loops');
ALTER TABLE `advertising_ecm`.`creative`.`spec` ALTER COLUMN `max_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Maximum Duration in Seconds');
ALTER TABLE `advertising_ecm`.`creative`.`spec` ALTER COLUMN `max_file_size_kb` SET TAGS ('dbx_business_glossary_term' = 'Maximum File Size in Kilobytes (KB)');
ALTER TABLE `advertising_ecm`.`creative`.`spec` ALTER COLUMN `min_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Minimum Duration in Seconds');
ALTER TABLE `advertising_ecm`.`creative`.`spec` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`spec` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Specification Notes');
ALTER TABLE `advertising_ecm`.`creative`.`spec` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Platform');
ALTER TABLE `advertising_ecm`.`creative`.`spec` ALTER COLUMN `platform_spec_version` SET TAGS ('dbx_business_glossary_term' = 'Platform Specification Version');
ALTER TABLE `advertising_ecm`.`creative`.`spec` ALTER COLUMN `resolution_dpi` SET TAGS ('dbx_business_glossary_term' = 'Resolution in Dots Per Inch (DPI)');
ALTER TABLE `advertising_ecm`.`creative`.`spec` ALTER COLUMN `safe_zone_pixels` SET TAGS ('dbx_business_glossary_term' = 'Safe Zone in Pixels');
ALTER TABLE `advertising_ecm`.`creative`.`spec` ALTER COLUMN `spec_code` SET TAGS ('dbx_business_glossary_term' = 'Specification Code');
ALTER TABLE `advertising_ecm`.`creative`.`spec` ALTER COLUMN `spec_name` SET TAGS ('dbx_business_glossary_term' = 'Specification Name');
ALTER TABLE `advertising_ecm`.`creative`.`spec` ALTER COLUMN `spec_status` SET TAGS ('dbx_business_glossary_term' = 'Specification Status');
ALTER TABLE `advertising_ecm`.`creative`.`spec` ALTER COLUMN `spec_status` SET TAGS ('dbx_value_regex' = 'active|deprecated|draft|archived|pending_approval|retired');
ALTER TABLE `advertising_ecm`.`creative`.`spec` ALTER COLUMN `transparency_allowed` SET TAGS ('dbx_business_glossary_term' = 'Transparency Allowed');
ALTER TABLE `advertising_ecm`.`creative`.`spec` ALTER COLUMN `video_codec` SET TAGS ('dbx_business_glossary_term' = 'Video Codec');
ALTER TABLE `advertising_ecm`.`creative`.`spec` ALTER COLUMN `width_pixels` SET TAGS ('dbx_business_glossary_term' = 'Width in Pixels');
ALTER TABLE `advertising_ecm`.`creative`.`brand_guideline` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `advertising_ecm`.`creative`.`brand_guideline` SET TAGS ('dbx_subdomain' = 'brief_strategy');
ALTER TABLE `advertising_ecm`.`creative`.`brand_guideline` ALTER COLUMN `brand_guideline_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Brand Guideline Identifier (ID)');
ALTER TABLE `advertising_ecm`.`creative`.`brand_guideline` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brand Identifier (ID)');
ALTER TABLE `advertising_ecm`.`creative`.`brand_guideline` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `advertising_ecm`.`creative`.`brand_guideline` ALTER COLUMN `compliance_threshold_score` SET TAGS ('dbx_business_glossary_term' = 'Compliance Threshold Score');
ALTER TABLE `advertising_ecm`.`creative`.`brand_guideline` ALTER COLUMN `compliance_validation_enabled` SET TAGS ('dbx_business_glossary_term' = 'Compliance Validation Enabled');
ALTER TABLE `advertising_ecm`.`creative`.`brand_guideline` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`brand_guideline` ALTER COLUMN `digital_asset_management_url` SET TAGS ('dbx_business_glossary_term' = 'Digital Asset Management (DAM) URL');
ALTER TABLE `advertising_ecm`.`creative`.`brand_guideline` ALTER COLUMN `do_examples` SET TAGS ('dbx_business_glossary_term' = 'Do Examples');
ALTER TABLE `advertising_ecm`.`creative`.`brand_guideline` ALTER COLUMN `dont_examples` SET TAGS ('dbx_business_glossary_term' = 'Dont Examples');
ALTER TABLE `advertising_ecm`.`creative`.`brand_guideline` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `advertising_ecm`.`creative`.`brand_guideline` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `advertising_ecm`.`creative`.`brand_guideline` ALTER COLUMN `format_specifications` SET TAGS ('dbx_business_glossary_term' = 'Format Specifications');
ALTER TABLE `advertising_ecm`.`creative`.`brand_guideline` ALTER COLUMN `guideline_description` SET TAGS ('dbx_business_glossary_term' = 'Guideline Description');
ALTER TABLE `advertising_ecm`.`creative`.`brand_guideline` ALTER COLUMN `guideline_status` SET TAGS ('dbx_business_glossary_term' = 'Guideline Status');
ALTER TABLE `advertising_ecm`.`creative`.`brand_guideline` ALTER COLUMN `guideline_status` SET TAGS ('dbx_value_regex' = 'draft|active|archived|superseded|under_review');
ALTER TABLE `advertising_ecm`.`creative`.`brand_guideline` ALTER COLUMN `guideline_version` SET TAGS ('dbx_business_glossary_term' = 'Guideline Version');
ALTER TABLE `advertising_ecm`.`creative`.`brand_guideline` ALTER COLUMN `imagery_style_guidelines` SET TAGS ('dbx_business_glossary_term' = 'Imagery Style Guidelines');
ALTER TABLE `advertising_ecm`.`creative`.`brand_guideline` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `advertising_ecm`.`creative`.`brand_guideline` ALTER COLUMN `logo_clear_space_minimum` SET TAGS ('dbx_business_glossary_term' = 'Logo Clear Space Minimum');
ALTER TABLE `advertising_ecm`.`creative`.`brand_guideline` ALTER COLUMN `logo_minimum_size` SET TAGS ('dbx_business_glossary_term' = 'Logo Minimum Size');
ALTER TABLE `advertising_ecm`.`creative`.`brand_guideline` ALTER COLUMN `logo_usage_rules` SET TAGS ('dbx_business_glossary_term' = 'Logo Usage Rules');
ALTER TABLE `advertising_ecm`.`creative`.`brand_guideline` ALTER COLUMN `messaging_guidelines` SET TAGS ('dbx_business_glossary_term' = 'Messaging Guidelines');
ALTER TABLE `advertising_ecm`.`creative`.`brand_guideline` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`brand_guideline` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `advertising_ecm`.`creative`.`brand_guideline` ALTER COLUMN `primary_color_palette` SET TAGS ('dbx_business_glossary_term' = 'Primary Color Palette');
ALTER TABLE `advertising_ecm`.`creative`.`brand_guideline` ALTER COLUMN `primary_typeface` SET TAGS ('dbx_business_glossary_term' = 'Primary Typeface');
ALTER TABLE `advertising_ecm`.`creative`.`brand_guideline` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `advertising_ecm`.`creative`.`brand_guideline` ALTER COLUMN `tone_of_voice` SET TAGS ('dbx_business_glossary_term' = 'Tone of Voice');
ALTER TABLE `advertising_ecm`.`creative`.`brand_guideline` ALTER COLUMN `typography_rules` SET TAGS ('dbx_business_glossary_term' = 'Typography Rules');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` SET TAGS ('dbx_subdomain' = 'production_delivery');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `creative_deliverable_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Deliverable ID');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `ad_format_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Format Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser ID');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brand Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `contract_deliverable_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Deliverable Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `contract_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Insertion Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `creative_brief_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Brief ID');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `deliverable_tracker_id` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Tracker Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `media_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Media Placement Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Project Milestone Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `persona_id` SET TAGS ('dbx_business_glossary_term' = 'Persona Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `production_job_id` SET TAGS ('dbx_business_glossary_term' = 'Production Job Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `project_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Project Budget Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `rate_card_line_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Line Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Segment Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `sla_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `spec_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Spec Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `task_id` SET TAGS ('dbx_business_glossary_term' = 'Task Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `work_package_id` SET TAGS ('dbx_business_glossary_term' = 'Work Package Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `accepted_date` SET TAGS ('dbx_business_glossary_term' = 'Accepted Date');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `actual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `actual_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Hours');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `assigned_copywriter` SET TAGS ('dbx_business_glossary_term' = 'Assigned Copywriter');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `assigned_creative_team` SET TAGS ('dbx_business_glossary_term' = 'Assigned Creative Team');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `brand_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Brand Compliance Status');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `brand_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review|not_applicable');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Channel');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `deliverable_code` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Code');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `deliverable_name` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Name');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `deliverable_status` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Status');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `deliverable_type` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Type');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `delivered_date` SET TAGS ('dbx_business_glossary_term' = 'Delivered Date');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'email|ftp|cloud_storage|dam_portal|physical_media|api');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `dimensions` SET TAGS ('dbx_business_glossary_term' = 'Dimensions');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Duration (Seconds)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `estimated_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Hours');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `file_size_mb` SET TAGS ('dbx_business_glossary_term' = 'File Size (Megabytes)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `legal_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Legal Approval Required');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `legal_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Legal Approval Status');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `legal_approval_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|rejected|conditional');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `production_start_date` SET TAGS ('dbx_business_glossary_term' = 'Production Start Date');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `quantity_required` SET TAGS ('dbx_business_glossary_term' = 'Quantity Required');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `requested_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Date');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `revision_count` SET TAGS ('dbx_business_glossary_term' = 'Revision Count');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
