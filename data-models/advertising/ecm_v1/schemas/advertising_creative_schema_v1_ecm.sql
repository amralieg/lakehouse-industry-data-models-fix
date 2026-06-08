-- Schema for Domain: creative | Business: Advertising | Version: v1_ecm
-- Generated on: 2026-05-08 02:28:05

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `advertising_ecm`.`creative` COMMENT 'Manages the full creative development and production lifecycle — from brief and concept through asset production, versioning, proofing, and final delivery. Serves as the SSOT for creative assets, DAM metadata, WIP status, format compliance, creative specifications, and brand compliance. Integrates with Adobe Creative Cloud and Workfront DAM.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `advertising_ecm`.`creative`.`creative_brief` (
    `creative_brief_id` BIGINT COMMENT 'Unique identifier for the creative brief record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Briefs execute under master service agreements (MSAs) that define scope, pricing, and deliverables. Agencies track which agreement governs each brief for billing validation, scope compliance, and cont',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Creative briefs must reference brand identity, tone, visual standards, and compliance requirements from the brand profile to ensure all creative work aligns with brand strategy and guidelines - fundam',
    `campaign_id` BIGINT COMMENT 'Reference to the parent campaign that this creative brief supports. Links the brief to the broader campaign strategy.',
    `client_brand_id` BIGINT COMMENT 'Reference to the specific client brand for which this creative is being developed.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Creative briefs are initiated by departments/practice groups tracked as cost centers for budget ownership and chargeback accounting. Agency finance teams allocate brief costs to originating cost cente',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Briefs reference approved budgets for scope and cost constraints. Links brief requirements to formal budget allocations for financial planning, approval workflows, and spend tracking against allocated',
    `initiative_id` BIGINT COMMENT 'Reference to the Workfront project that initiated this creative brief. Links to project intake and resource planning.',
    `positioning_id` BIGINT COMMENT 'Foreign key linking to brand.brand_positioning. Business justification: Briefs operationalize brand positioning strategy into executable creative direction. Creative teams need positioning statement, target audience definition, point of difference, and messaging framework',
    `project_brief_id` BIGINT COMMENT 'Foreign key linking to project.project_brief. Business justification: Creative briefs are execution-level briefs derived from project briefs. Linking enables strategic alignment validation, requirements traceability, scope verification, and brief-to-execution tracking. ',
    `worker_id` BIGINT COMMENT 'Foreign key linking to talent.worker. Business justification: Tracks which internal employee requested the creative brief. Essential for workload analysis, requestor accountability, and brief intake workflow management. Replaces denormalized name/email fields wi',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Briefs are scoped and budgeted within specific SOWs. Agencies track this to ensure creative work stays within contracted scope, allocate costs to correct SOW line items, and validate budget availabili',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Creative briefs specify preferred production vendors (studios, post-production houses, animation vendors) for execution. Essential for production planning, vendor assignment workflows, and budget allo',
    `persona_id` BIGINT COMMENT 'Foreign key linking to audience.persona. Business justification: Briefs define creative strategy against structured personas; target_audience_description is prose, but campaigns require linking to defined persona profiles for consistent targeting and measurement ac',
    `approved_by_name` STRING COMMENT 'Name of the individual who provided final approval for the creative brief.',
    `approved_date` DATE COMMENT 'Date when the creative brief received final approval and was authorized to proceed to production.',
    `art_director_assigned` STRING COMMENT 'Name of the art director assigned to develop visual concepts and design for this creative brief.',
    `brand_guidelines_reference` STRING COMMENT 'Reference to applicable brand guidelines, style guides, or Digital Asset Management (DAM) locations that creative teams must follow.',
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

CREATE OR REPLACE TABLE `advertising_ecm`.`creative`.`creative_asset` (
    `creative_asset_id` BIGINT COMMENT 'Unique identifier for the creative asset in the Digital Asset Management (DAM) system. Primary key.',
    `advertiser_id` BIGINT COMMENT 'FK to client.advertiser.advertiser_id — MUST-HAVE: Cannot determine asset ownership. Required for rights management, brand compliance, and client asset libraries.',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to audience.segment. Business justification: Assets are optimized for specific audience segments; personalization and dynamic creative optimization require segment-level asset assignment to deliver relevant creative to each audience, core to mod',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Assets must be tagged to brand profile for DAM organization, search/retrieval, rights management by brand, usage reporting, and brand safety compliance. Essential for multi-brand agency operations man',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Assets are deliverables within initiatives. Linking enables asset inventory management, reuse tracking across projects, ROI analysis, and portfolio reporting. Essential for digital asset management an',
    `parent_asset_creative_asset_id` BIGINT COMMENT 'Reference to the parent or original asset from which this version was derived. Establishes version lineage and asset family relationships.',
    `worker_id` BIGINT COMMENT 'Reference to the user or talent who created or uploaded the asset. Supports attribution, workflow tracking, and resource management.',
    `spec_id` BIGINT COMMENT 'Foreign key linking to creative.creative_spec. Business justification: Creative assets are produced to meet specific creative specifications (format, dimensions, file size, codec, etc.). This link tracks which spec an asset was produced to, supporting validation and comp',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Assets created by external vendors (stock media providers, production companies, freelance studios) require vendor attribution for rights management, usage tracking, invoice reconciliation, and qualit',
    `task_id` BIGINT COMMENT 'Foreign key linking to project.task. Business justification: Assets are outputs of specific tasks. Linking enables granular effort tracking, resource utilization analysis, task completion validation, and productivity measurement. Essential for time tracking and',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the asset was approved for use. Establishes the point at which the asset became available for trafficking and deployment.',
    `archived_timestamp` TIMESTAMP COMMENT 'Date and time when the asset was archived or retired from active use. Supports lifecycle management and storage optimization.',
    `aspect_ratio` STRING COMMENT 'Proportional relationship between width and height (e.g., 16:9, 4:3, 1:1, 9:16). Determines display format and channel suitability.',
    `asset_name` STRING COMMENT 'Human-readable name or title of the creative asset. Primary label used for search and identification.',
    `asset_type` STRING COMMENT 'High-level classification of the creative asset format. Determines handling, rendering, and distribution workflows. [ENUM-REF-CANDIDATE: image|video|audio|copy_document|design_file|motion_graphics|html5_rich_media|3d_ar_asset — 8 candidates stripped; promote to reference product]',
    `brand_compliance_status` STRING COMMENT 'Indicates whether the asset adheres to brand guidelines and standards. Critical for brand integrity and legal risk management.. Valid values are `compliant|non_compliant|pending_review|not_applicable`',
    `campaign_theme` STRING COMMENT 'Overarching creative theme or concept associated with the asset (e.g., Summer Sale, Back to School, Holiday 2024). Links asset to strategic messaging.',
    `channel_suitability` STRING COMMENT 'Comma-separated list of media channels for which this asset is optimized or approved (e.g., TV, Digital, OOH, Social, CTV). Guides media planning and trafficking.',
    `client_brand_id` BIGINT COMMENT 'Reference to the client brand that owns or is represented by this asset. Enables brand-level asset organization and reporting.',
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
    CONSTRAINT pk_creative_asset PRIMARY KEY(`creative_asset_id`)
) COMMENT 'Core master entity representing a single creative asset in the Digital Asset Management system — including images, videos, audio files, copy documents, design files (PSD, AI, INDD), motion graphics, HTML5 rich media, and 3D/AR assets. Tracks asset type, format, file size, resolution, duration, codec, color profile, aspect ratio, DAM asset ID (Workfront DAM/Adobe AEM), version lineage, brand compliance status, rights clearance status, lifecycle stage (WIP, in-review, approved, archived, expired), expiry date, and descriptive metadata tags (subject, mood, channel, campaign theme). This is the SSOT for all creative asset metadata and taxonomy across the agency, supporting search, retrieval, reuse discovery, and rights monitoring.';

CREATE OR REPLACE TABLE `advertising_ecm`.`creative`.`asset_version` (
    `asset_version_id` BIGINT COMMENT 'Unique identifier for the asset version record. Primary key.',
    `worker_id` BIGINT COMMENT 'Foreign key linking to talent.worker. Business justification: Tracks which employee created each asset version. Critical for version control audit trail, contributor tracking, and workload attribution. Replaces denormalized name/email fields with structured FK f',
    `creative_asset_id` BIGINT COMMENT 'Reference to the parent creative asset for which this version was created.',
    `creative_deliverable_id` BIGINT COMMENT 'Foreign key linking to creative.creative_deliverable. Business justification: Asset versions represent iterative development states of deliverables. Production tracking requires linking each version to its parent deliverable to manage revision history, track which version was a',
    `spec_id` BIGINT COMMENT 'Foreign key linking to creative.creative_spec. Business justification: Each asset version should track which creative specification it conforms to. As assets are revised through the version history, they may be adjusted to meet different specs or updated spec versions. T',
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
    `worker_id` BIGINT COMMENT 'Reference to the copywriter who developed the messaging and copy for this concept. Links to talent or employee record.',
    `concept_created_by_user_worker_id` BIGINT COMMENT 'Reference to the user who created this concept record. Links to employee or user management system.',
    `concept_modified_by_user_worker_id` BIGINT COMMENT 'Reference to the user who last modified this concept record. Links to employee or user management system.',
    `concept_worker_id` BIGINT COMMENT 'Reference to the creative lead or art director responsible for developing this concept. Links to talent or employee record.',
    `creative_brief_id` BIGINT COMMENT 'Reference to the creative brief that originated this concept. Links to the brief that defines the strategic requirements and objectives this concept addresses.',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Concepts are strategic outputs within initiatives. Linking enables ideation-to-execution traceability, concept testing tracking, and strategic alignment validation. Critical for creative development p',
    `parent_concept_id` BIGINT COMMENT 'Reference to the parent concept if this is a revision or variation. Enables tracking of concept evolution and iteration history.',
    `positioning_id` BIGINT COMMENT 'Foreign key linking to brand.brand_positioning. Business justification: Concepts must align with brand positioning strategy - creative development gate. Concepts are evaluated against positioning statement, target audience, point of difference, and messaging framework. Es',
    `persona_id` BIGINT COMMENT 'Foreign key linking to audience.persona. Business justification: Concepts are developed against persona profiles; creative strategy workshops and concept testing require linking concepts to target personas to validate strategic fit and ensure messaging resonates wi',
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
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Production jobs are executed for specific brands and require brand profile link for resource allocation, brand-level cost tracking, compliance requirements, and production portfolio reporting. Core pr',
    `campaign_id` BIGINT COMMENT 'Reference to the campaign this production job supports.',
    `concept_id` BIGINT COMMENT 'Foreign key linking to creative.concept. Business justification: Production jobs execute approved concepts. Once a concept is approved, production jobs are created to produce the creative deliverables. This direct link allows tracking which concept a production job',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Production jobs are core cost-tracking units in agency operations. Jobs are allocated to cost centers (studio, creative department) for labor cost accounting, overhead allocation, and departmental P&L',
    `creative_brief_id` BIGINT COMMENT 'Reference to the creative brief that initiated this production job.',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Production jobs are work execution units within initiatives. Linking enables project portfolio reporting, resource planning across initiatives, budget roll-ups, and timeline tracking. Essential for ag',
    `plan_id` BIGINT COMMENT 'Foreign key linking to media.media_plan. Business justification: Production jobs are initiated to create deliverables for media plans. Studios need plan context for format specifications, channel requirements, flight deadlines, and ensuring creative is ready before',
    `worker_id` BIGINT COMMENT 'Reference to the producer or project manager responsible for overseeing this production job.',
    `project_budget_id` BIGINT COMMENT 'Foreign key linking to project.project_budget. Business justification: Production jobs consume project budgets. Linking enables cost tracking, variance analysis, budget utilization reporting, and profitability analysis. Essential for financial management and project cont',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Production jobs are delivered under SOW terms that define deliverables, timelines, and pricing. Agencies track which SOW governs each job for accurate billing, resource allocation, and contract compli',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Production jobs are frequently outsourced to external studios, post-production facilities, VFX houses, and freelance production companies. Critical for vendor billing reconciliation, quality managemen',
    `work_package_id` BIGINT COMMENT 'Foreign key linking to project.work_package. Business justification: Production jobs are work packages in project plans. Linking enables task-level tracking, capacity planning, WBS-based reporting, and resource utilization analysis. Critical for studio operations manag',
    `workfront_project_initiative_id` BIGINT COMMENT 'External system identifier linking this production job to the corresponding project or task in Workfront project management system.',
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
    `approval_workflow_id` BIGINT COMMENT 'Foreign key linking to project.approval_workflow. Business justification: Proofs are artifacts in approval workflows. Linking enables workflow automation, SLA tracking, approval cycle analysis, and bottleneck identification. Essential for process optimization and client ser',
    `asset_version_id` BIGINT COMMENT 'Reference to the specific asset version being proofed in this review cycle.',
    `campaign_id` BIGINT COMMENT 'Reference to the campaign this proof is associated with, enabling campaign-level proof tracking and SLA reporting.',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Proofs are approval artifacts within initiatives. Linking enables workflow tracking, approval cycle analysis, timeline management, and client satisfaction measurement at the initiative level. Essentia',
    `production_job_id` BIGINT COMMENT 'Foreign key linking to creative.production_job. Business justification: Proofs are submitted during production jobs as part of the creative review workflow. This link provides operational context: which production job is this proof part of? Supports workflow tracking, SLA',
    `project_milestone_id` BIGINT COMMENT 'Foreign key linking to project.project_milestone. Business justification: Proofs are approval gates at milestones. Linking enables contractual compliance, payment release validation, client sign-off tracking, and milestone achievement verification. Critical for contract man',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Proofing platforms (Workfront Proof, Ziflow, Aproove) are often external SaaS vendors. Required for vendor contract management, platform cost allocation, and tech stack governance in creative operatio',
    `task_id` BIGINT COMMENT 'Foreign key linking to project.task. Business justification: Proofs are approval tasks in project schedules. Linking enables dependency management, timeline tracking, task completion validation, and approval workflow automation. Critical for schedule management',
    `work_package_id` BIGINT COMMENT 'Foreign key linking to project.work_package. Business justification: Proofs are approval milestones within work packages. Linking enables critical path management, approval cycle tracking, and schedule impact analysis. Essential for timeline management and client coord',
    `worker_id` BIGINT COMMENT 'Reference to the user (typically creative producer or project manager) who submitted the proof for review.',
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
    `sla_target_hours` DECIMAL(18,2) COMMENT 'Contractual or internal target turnaround time in hours for this proof type and stage. Used to calculate SLA compliance (actual vs. target).',
    `stage` STRING COMMENT 'Stage of the proofing workflow. Internal = agency-only review, Client Round 1/2/3 = sequential client review cycles, Final = final approval before production.. Valid values are `internal|client_round_1|client_round_2|client_round_3|final`',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the proof was formally submitted to reviewers. Used as the start point for SLA turnaround time calculations.',
    `turnaround_time_hours` DECIMAL(18,2) COMMENT 'Calculated elapsed time in hours between submission_timestamp and decision_timestamp. Key metric for agency SLA compliance reporting on review cycle speed.',
    `url` STRING COMMENT 'Direct URL link to the proof in the Workfront Proofing system for reviewer access and audit trail.. Valid values are `^https?://.*$`',
    CONSTRAINT pk_proof PRIMARY KEY(`proof_id`)
) COMMENT 'Captures each formal proofing round submitted for client or internal review via Workfront Proofing. Records proof type (concept, copy, layout, final art, legal, accessibility), proof stage (internal, client round 1/2/3, final), reviewer assignments, due date, submission timestamp, overall proof decision (approved, approved-with-changes, rejected), and decision timestamp. Distinct from asset_version in that a proof is a formal review event with stakeholder decisions and SLA tracking, not merely a file iteration. Supports agency SLA compliance reporting on review turnaround times.';

CREATE OR REPLACE TABLE `advertising_ecm`.`creative`.`proof_comment` (
    `proof_comment_id` BIGINT COMMENT 'Unique identifier for the proof comment record. Primary key.',
    `parent_comment_proof_comment_id` BIGINT COMMENT 'Reference to the parent comment if this is a reply or threaded response. Null for top-level comments. Supports nested conversation threads within proof reviews.',
    `worker_id` BIGINT COMMENT 'Reference to the user or stakeholder who authored this comment. May be internal team member, client contact, or external reviewer.',
    `proof_id` BIGINT COMMENT 'Reference to the parent proof document or asset version being reviewed. Links this comment to the specific proof instance in the review workflow.',
    `review_cycle_id` BIGINT COMMENT 'Reference to the review cycle or approval stage during which this comment was made. Supports multi-stage approval workflows.',
    `tertiary_proof_deleted_by_worker_id` BIGINT COMMENT 'Reference to the user who deleted the comment. Null if the comment has not been deleted. Supports audit trail and accountability.',
    `annotation_page_number` STRING COMMENT 'Page or frame number within a multi-page proof document (e.g., PDF, presentation deck, video timeline) where the annotation is placed. Null for single-page assets or general comments.',
    `annotation_timestamp_seconds` DECIMAL(18,2) COMMENT 'Timestamp in seconds for video or audio proof assets, indicating the exact moment in the timeline where the comment applies. Null for static image or document proofs.',
    `annotation_x_coordinate` DECIMAL(18,2) COMMENT 'Horizontal position coordinate of the visual markup or annotation on the proof asset. Null for general comments not tied to a specific location. Expressed as normalized coordinate (0.0 to 1.0) or pixel position depending on system configuration.',
    `annotation_y_coordinate` DECIMAL(18,2) COMMENT 'Vertical position coordinate of the visual markup or annotation on the proof asset. Null for general comments not tied to a specific location. Expressed as normalized coordinate (0.0 to 1.0) or pixel position depending on system configuration.',
    `attachment_file_name` STRING COMMENT 'Original file name of the attachment, if provided. Used for display and audit purposes.',
    `attachment_url` STRING COMMENT 'URL or file path to any supporting document, reference image, or file attached to the comment. Null if no attachment is provided.',
    `comment_priority` STRING COMMENT 'Priority or severity level assigned to the comment, indicating urgency of resolution. Critical issues may block approval; low priority may be optional enhancements.. Valid values are `critical|high|medium|low`',
    `comment_source` STRING COMMENT 'The channel or interface through which the comment was submitted. Tracks whether feedback came from the proofing web app, mobile app, email integration, or external API.. Valid values are `web_app|mobile_app|email|api|integration`',
    `comment_text` STRING COMMENT 'The full text content of the feedback or annotation provided by the reviewer. Captures the detailed feedback, suggestion, or approval note.',
    `comment_type` STRING COMMENT 'Categorical classification of the comment based on the nature of feedback. Enables filtering and routing of comments to appropriate resolution teams. [ENUM-REF-CANDIDATE: general|legal|brand|copy|design|technical|compliance|approval|rejection — 9 candidates stripped; promote to reference product]',
    `commenter_name` STRING COMMENT 'Full name of the person who made the comment, captured at the time of comment creation for audit trail purposes.',
    `commenter_role` STRING COMMENT 'The functional role or responsibility of the commenter in the review process. Used to categorize feedback by stakeholder type and prioritize resolution. [ENUM-REF-CANDIDATE: creative_director|copywriter|art_director|account_manager|client_stakeholder|legal_reviewer|brand_manager|producer|external_reviewer|other — 10 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the comment was originally created. Represents the business event time when the reviewer submitted the feedback.',
    `deleted_timestamp` TIMESTAMP COMMENT 'Date and time when the comment was marked as deleted. Null if the comment has not been deleted.',
    `is_client_visible` BOOLEAN COMMENT 'Indicates whether this comment is visible to external client stakeholders or is internal-only feedback. Supports internal team collaboration without exposing all feedback to clients.',
    `is_deleted` BOOLEAN COMMENT 'Indicates whether the comment has been soft-deleted. Supports audit trail retention while removing comments from active review workflows.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the comment was last edited or updated. Null if the comment has never been modified after creation.',
    `requires_client_approval` BOOLEAN COMMENT 'Indicates whether this comment requires explicit client sign-off or approval before the proof can proceed to the next stage. Used to enforce mandatory approval checkpoints.',
    `resolution_notes` STRING COMMENT 'Free-text explanation of how the comment was resolved, why it was rejected, or additional context on the resolution decision. Provides audit trail for client approval workflows.',
    `resolution_status` STRING COMMENT 'Current resolution state of the comment in the approval workflow. Tracks whether feedback has been addressed, rejected, or is still pending action.. Valid values are `open|in_progress|resolved|rejected|deferred`',
    `resolved_timestamp` TIMESTAMP COMMENT 'Date and time when the comment was marked as resolved or closed. Null if comment is still open. Used to calculate resolution turnaround time.',
    CONSTRAINT pk_proof_comment PRIMARY KEY(`proof_comment_id`)
) COMMENT 'Individual annotation or feedback comment recorded against a proof during a review cycle. Captures commenter identity, comment text, annotation coordinates (for visual markup), comment type (general, legal, brand, copy), resolution status (open, resolved, rejected), and resolution notes. Provides a complete audit trail of all stakeholder feedback on creative work, supporting compliance with client approval workflows.';

CREATE OR REPLACE TABLE `advertising_ecm`.`creative`.`spec` (
    `spec_id` BIGINT COMMENT 'Unique identifier for the creative specification record. Primary key.',
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
    `client_brand_id` BIGINT COMMENT 'Reference to the client brand that this guideline governs. Links to the client brand master.',
    `guideline_id` BIGINT COMMENT 'Foreign key linking to brand.brand_guideline. Business justification: Creative domain maintains operational guideline copies for production use; should reference authoritative brand guideline master for version control, updates, and ensuring creative teams work from cur',
    `worker_id` BIGINT COMMENT 'Foreign key linking to talent.worker. Business justification: Tracks which employee maintains brand guidelines. Essential for guideline ownership, update accountability, and brand governance. Replaces denormalized text field with structured FK for stewardship re',
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
    `secondary_color_palette` STRING COMMENT 'Approved secondary or accent brand colors in multiple formats (hex, Pantone, CMYK, RGB). Used for supporting visual elements.',
    `secondary_typeface` STRING COMMENT 'The secondary or alternative approved typeface for brand communications, used when primary is unavailable or for specific contexts.',
    `source_system` STRING COMMENT 'The system or platform from which this brand guideline was sourced (e.g., Client Brand Portal, Workfront DAM, Adobe Creative Cloud).',
    `tone_of_voice` STRING COMMENT 'Defined brand voice and tone characteristics for written communications (e.g., friendly and approachable, authoritative and professional).',
    `typography_rules` STRING COMMENT 'Detailed rules governing typography usage including font weights, sizes, line spacing, letter spacing, and hierarchy. Stored as structured text or JSON.',
    CONSTRAINT pk_brand_guideline PRIMARY KEY(`brand_guideline_id`)
) COMMENT 'Reference master for client brand guidelines governing creative production — including approved color palettes (hex, Pantone, CMYK, RGB), typography (typefaces, weights, sizes), logo usage rules, imagery style, tone of voice, do/dont examples, and brand compliance thresholds. Serves as the SSOT for brand compliance validation during creative review and production QA. Scope boundary: this entity owns the operational production ruleset (visual specs, typography rules, logo placement constraints) used by creative teams in day-to-day asset production. It does NOT own brand strategy, positioning, architecture, or competitive intelligence — those belong to the brand domain. Sourced from client brand portals and maintained by the creative services team.';

CREATE OR REPLACE TABLE `advertising_ecm`.`creative`.`creative_compliance_check` (
    `creative_compliance_check_id` BIGINT COMMENT 'Unique identifier for the creative compliance check record. Primary key.',
    `advertiser_id` BIGINT COMMENT 'Reference to the client or advertiser whose creative asset is being reviewed, enabling client-specific compliance reporting.',
    `approval_workflow_id` BIGINT COMMENT 'Foreign key linking to project.approval_workflow. Business justification: Compliance checks require approval workflows. Linking enables multi-stage review, sign-off tracking, audit trail maintenance, and regulatory compliance verification. Critical for brand safety and lega',
    `brand_guideline_id` BIGINT COMMENT 'Foreign key linking to creative.creative_brand_guideline. Business justification: Compliance checks validate creative work against specific brand guidelines. This link identifies which guideline version was used for validation, supporting audit trails and ensuring checks reference ',
    `campaign_id` BIGINT COMMENT 'Reference to the campaign for which this creative asset is intended, providing campaign-level compliance tracking.',
    `change_request_id` BIGINT COMMENT 'Foreign key linking to project.change_request. Business justification: Compliance failures trigger change requests. Linking enables remediation tracking, client communication, timeline impact analysis, and cost recovery. Critical for risk management and client relationsh',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Compliance review activities (legal, brand, platform policy) are performed by specialized departments tracked as cost centers. Enables cost allocation for compliance overhead and departmental resource',
    `creative_asset_id` BIGINT COMMENT 'Reference to the creative asset or proof being reviewed in this compliance check.',
    `creative_deliverable_id` BIGINT COMMENT 'Foreign key linking to creative.creative_deliverable. Business justification: Deliverables require compliance sign-off before final delivery to client. This link tracks which deliverable a compliance check is validating. Cardinality: N:1 (one deliverable can have multiple compl',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Compliance checks are quality gates within initiatives. Linking enables risk management, audit trail maintenance, regulatory reporting, and initiative health assessment. Critical for brand safety and ',
    `previous_check_creative_compliance_check_id` BIGINT COMMENT 'Reference to a prior compliance check record for this asset, enabling version tracking and remediation history.',
    `proof_id` BIGINT COMMENT 'Foreign key linking to creative.proof. Business justification: Compliance checks can be performed on proofs during the review cycle, not just on final assets. This allows early-stage compliance validation before final production. Cardinality: N:1 (one proof can h',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Third-party compliance verification services (brand safety vendors, legal review firms, TAG certification providers) perform compliance checks. Required for vendor performance tracking, audit trails, ',
    `worker_id` BIGINT COMMENT 'Reference to the person or team member who performed the compliance review.',
    `brand_compliance_pass` BOOLEAN COMMENT 'Boolean flag indicating whether the asset passed brand compliance checks (logo usage, color palette, typography, tone of voice, brand guidelines adherence).',
    `check_date` DATE COMMENT 'Date when the compliance check was performed or initiated. Principal business event timestamp for this review.',
    `check_duration_minutes` STRING COMMENT 'Total time spent performing the compliance check, measured in minutes. Used for resource planning and efficiency analysis.',
    `check_number` STRING COMMENT 'Business identifier for the compliance check, formatted as CC-YYYYMMDD-XXXXXX for external reference and audit trail.. Valid values are `^CC-[0-9]{8}-[A-Z0-9]{6}$`',
    `check_status` STRING COMMENT 'Current lifecycle status of the compliance check: pending (queued), in_progress (under review), completed (review finished), approved (passed all checks), rejected (failed), remediation_required (conditional pass with required fixes).. Valid values are `pending|in_progress|completed|approved|rejected|remediation_required`',
    `check_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the compliance check was initiated, providing audit-level granularity for regulatory reporting.',
    `check_type` STRING COMMENT 'Category of compliance review performed: brand compliance (brand guidelines adherence), legal/regulatory (FTC, ASA, GDPR, CCPA disclosures), platform policy (IAB, TAG, MRC standards), or full review (all categories).. Valid values are `brand_compliance|legal_regulatory|platform_policy|full_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance check record was first created in the system. Audit trail field for data lineage.',
    `legal_compliance_pass` BOOLEAN COMMENT 'Boolean flag indicating whether the asset passed legal and regulatory compliance checks (FTC disclosures, ASA code, GDPR consent language, CCPA privacy notices, truth in advertising).',
    `notes` STRING COMMENT 'Additional free-text notes, observations, or context provided by the reviewer during the compliance check. Captures nuanced details not covered by structured fields.',
    `outcome` STRING COMMENT 'Final pass/fail result of the compliance check: pass (fully compliant), fail (non-compliant), conditional_pass (compliant with required remediation), not_applicable (check not relevant to this asset).. Valid values are `pass|fail|conditional_pass|not_applicable`',
    `platform_policy_pass` BOOLEAN COMMENT 'Boolean flag indicating whether the asset passed platform-specific policy compliance checks (IAB standards, TAG certification, MRC measurement guidelines, VAST/VPAID specifications, social media ad policies).',
    `platform_target` STRING COMMENT 'Target advertising platform or channel for which compliance is being checked (e.g., Google Ads, Facebook, Instagram, YouTube, LinkedIn, TikTok, OOH, CTV). Platform-specific policies may apply. [ENUM-REF-CANDIDATE: Google_Ads|Facebook|Instagram|YouTube|LinkedIn|TikTok|Twitter|Snapchat|Pinterest|OOH|DOOH|CTV|OTT|Display|Native|Email — promote to reference product]',
    `recheck_required` BOOLEAN COMMENT 'Boolean flag indicating whether a follow-up compliance check is required after remediation actions are completed.',
    `regulatory_framework` STRING COMMENT 'Specific regulatory frameworks or standards applied during this compliance check (e.g., FTC Section 5, ASA CAP Code, GDPR Article 7, CCPA 1798.115, IAB Standard 2.0). Pipe-separated list for multi-framework checks. [ENUM-REF-CANDIDATE: FTC_Section_5|ASA_CAP_Code|GDPR_Article_7|CCPA_1798_115|IAB_Standard_2_0|TAG_Certified_Against_Fraud|MRC_Measurement_Standard|VAST_4_2|VPAID_2_0 — promote to reference product]',
    `remediation_actions` STRING COMMENT 'Detailed description of specific remediation actions required to bring the asset into compliance. Free-text field providing actionable guidance to creative teams.',
    `remediation_deadline` DATE COMMENT 'Target date by which remediation actions must be completed to meet campaign launch timelines or regulatory requirements.',
    `remediation_required` BOOLEAN COMMENT 'Boolean flag indicating whether remediation actions are required before the asset can be approved for use.',
    `reviewer_name` STRING COMMENT 'Full name of the compliance reviewer for audit trail and accountability purposes.',
    `reviewer_role` STRING COMMENT 'Functional role of the reviewer performing the compliance check, indicating their area of expertise and authority.. Valid values are `brand_manager|legal_counsel|compliance_officer|creative_director|account_manager|platform_specialist`',
    `sign_off_by` STRING COMMENT 'Name of the person who provided formal sign-off or approval, establishing accountability for compliance decisions.',
    `sign_off_date` DATE COMMENT 'Date when formal sign-off or approval was granted following the compliance check.',
    `sign_off_status` STRING COMMENT 'Status of formal sign-off or approval following the compliance check: not_required (auto-approved), pending (awaiting sign-off), approved (formally signed off), rejected (sign-off denied).. Valid values are `not_required|pending|approved|rejected`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance check record was last modified. Audit trail field for change tracking.',
    `violation_count` STRING COMMENT 'Total number of distinct compliance violations identified in this check, used for severity assessment and prioritization.',
    `violation_severity` STRING COMMENT 'Highest severity level among all identified violations: critical (legal/regulatory risk, must fix before launch), high (brand risk, should fix), medium (best practice deviation), low (minor issue), none (no violations).. Valid values are `critical|high|medium|low|none`',
    `violations_identified` STRING COMMENT 'Detailed description of specific compliance violations or issues identified during the review. Free-text field capturing all non-compliant elements for remediation tracking.',
    CONSTRAINT pk_creative_compliance_check PRIMARY KEY(`creative_compliance_check_id`)
) COMMENT 'Transactional record of a formal compliance review performed on a creative asset or proof — covering brand compliance, legal/regulatory compliance (FTC, ASA, GDPR, CCPA disclosures), and platform policy compliance (IAB, TAG). Captures check type, reviewer, check date, pass/fail outcome, specific violations identified, required remediation actions, and sign-off status. Provides the audit trail required for regulatory and client approval governance.';

CREATE OR REPLACE TABLE `advertising_ecm`.`creative`.`rights_clearance` (
    `rights_clearance_id` BIGINT COMMENT 'Unique identifier for the rights clearance record. Primary key for tracking intellectual property and usage rights clearance throughout the creative asset lifecycle.',
    `adaptation_id` BIGINT COMMENT 'Foreign key linking to creative.adaptation. Business justification: Adaptations for different territories, channels, or markets may require separate rights clearances (e.g., talent rights for broadcast vs. digital, music rights for different territories). This link tr',
    `worker_id` BIGINT COMMENT 'Foreign key linking to talent.worker. Business justification: Tracks which employee approved rights clearance. Critical for legal compliance audit trail, rights management accountability, and risk mitigation. Replaces denormalized text field with structured FK.',
    `budget_line_id` BIGINT COMMENT 'Foreign key linking to finance.budget_line. Business justification: Rights clearance fees (talent, music, stock media) are discrete budget line items with specific cost allocations. Links clearance costs to budget lines for rights fee tracking, payment scheduling, and',
    `creative_asset_id` BIGINT COMMENT 'Reference to the creative asset for which rights are being cleared. Links to the creative asset in the Digital Asset Management (DAM) system.',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Rights clearances are legal prerequisites within initiatives. Linking enables dependency tracking, risk management, budget tracking for licensing costs, and timeline impact analysis. Essential for pro',
    `stock_media_asset_id` BIGINT COMMENT 'Unique identifier assigned by the stock media provider to the licensed asset. Required for license verification and audit trail.',
    `approval_date` DATE COMMENT 'Date when the rights clearance was approved by the legal or rights management team. Marks the point when the asset becomes available for trafficking.',
    `clearance_documentation_url` STRING COMMENT 'URL to the signed clearance documentation, talent release, or license agreement stored in the Digital Asset Management (DAM) system or document repository.. Valid values are `^https?://.*$`',
    `clearance_number` STRING COMMENT 'Business identifier for the rights clearance record, formatted as RC- followed by 8 digits. Used for external communication and tracking with legal teams and licensors.. Valid values are `^RC-[0-9]{8}$`',
    `clearance_status` STRING COMMENT 'Current lifecycle status of the rights clearance process. Critical for trafficking approval workflow and preventing rights violations in campaign execution.. Valid values are `pending|in_review|approved|rejected|expired|renewed`',
    `competitive_category_restrictions` STRING COMMENT 'Description of competitive categories or brands that are restricted from using the same licensed content. Common in talent releases and music licensing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the rights clearance record was first created in the system. Used for audit trail and process timeline tracking.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the rights grant exclusive usage to the advertiser, preventing the licensor from granting similar rights to competitors during the license period.',
    `legal_review_notes` STRING COMMENT 'Internal notes from legal review process documenting any concerns, special conditions, or clarifications regarding the rights clearance.',
    `license_end_date` DATE COMMENT 'Date when the usage rights expire. Critical for campaign trafficking systems to prevent rights violations. Null indicates perpetual rights.',
    `license_fee_amount` DECIMAL(18,2) COMMENT 'Total fee paid for the usage rights. Used for budget reconciliation and cost allocation to campaigns. Does not include taxes or additional fees.',
    `license_fee_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the license fee (e.g., USD, EUR, GBP). Required for multi-currency financial reporting and reconciliation.. Valid values are `^[A-Z]{3}$`',
    `license_start_date` DATE COMMENT 'Date when the usage rights become effective. Assets cannot be used in campaigns before this date without violating license terms.',
    `licensor_contact_email` STRING COMMENT 'Primary email address for the licensor or their representative. Used for rights negotiation, renewal notifications, and clearance documentation.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `licensor_contact_phone` STRING COMMENT 'Primary phone number for the licensor or their representative for urgent clearance matters and contract negotiations.',
    `licensor_name` STRING COMMENT 'Name of the entity or individual granting the usage rights. May be a talent agency, stock media provider, music publisher, or rights holder.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the rights clearance record was last updated. Tracks changes to clearance status, license terms, or documentation throughout the lifecycle.',
    `music_artist` STRING COMMENT 'Name of the recording artist or composer of the licensed music. Used for rights attribution and royalty reporting to performance rights organizations.',
    `music_isrc_code` STRING COMMENT 'International Standard Recording Code uniquely identifying the music recording. Standard identifier for music rights tracking and royalty distribution.. Valid values are `^[A-Z]{2}[A-Z0-9]{3}[0-9]{7}$`',
    `music_title` STRING COMMENT 'Title of the licensed music track used in the creative asset. Required for music rights tracking and performance rights organization (PRO) reporting.',
    `payment_terms` STRING COMMENT 'Payment schedule and terms for the license fee. Determines accounts payable processing and cash flow planning.. Valid values are `net_30|net_60|net_90|due_on_receipt|advance|milestone_based`',
    `permitted_channels` STRING COMMENT 'Comma-separated list of media channels where the asset may be used (e.g., TV, digital, OOH, social, radio, print, CTV, OTT, DOOH). Channel restrictions are critical for trafficking compliance. [ENUM-REF-CANDIDATE: tv|digital|social|ooh|dooh|radio|print|ctv|ott|cinema|podcast|email|sms — promote to reference product]',
    `permitted_territories` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes where the asset may be used (e.g., USA, CAN, GBR, DEU). Geographic restrictions are enforced in campaign geo-targeting to prevent rights violations.',
    `renewal_notification_days` STRING COMMENT 'Number of days before license expiration that renewal notification must be sent to the licensor. Used for automated renewal workflow triggers.',
    `renewal_option_available` BOOLEAN COMMENT 'Indicates whether the license includes an option to renew upon expiration. Used for proactive rights management and campaign continuity planning.',
    `rights_type` STRING COMMENT 'Category of intellectual property rights being cleared. Determines the specific clearance requirements and documentation needed for legal compliance. [ENUM-REF-CANDIDATE: talent_release|music_license|stock_image|stock_video|third_party_ip|trademark|copyright|publicity_rights — 8 candidates stripped; promote to reference product]',
    `risk_assessment` STRING COMMENT 'Legal teams assessment of the risk level associated with using this asset. High or critical risk assets require additional approval layers before trafficking.. Valid values are `low|medium|high|critical`',
    `royalty_structure` STRING COMMENT 'Description of any performance-based royalty or usage-based fee structure beyond the base license fee. May include per-impression fees, revenue share, or tiered pricing.',
    `stock_media_provider` STRING COMMENT 'Name of the stock media library or provider from which the image or video was licensed. Used for license compliance audits and vendor management.. Valid values are `getty_images|shutterstock|adobe_stock|istock|pond5|other`',
    `talent_name` STRING COMMENT 'Full name of the talent (actor, model, voice artist, influencer) appearing in the creative asset. Required for talent release tracking and union compliance reporting.',
    `talent_union_affiliation` STRING COMMENT 'Union membership status of the talent. Determines residual payment requirements, usage reporting obligations, and contract terms.. Valid values are `sag_aftra|non_union|afm|equity|other`',
    `usage_limitations` STRING COMMENT 'Free-text description of any additional usage restrictions not captured in structured fields. May include impression caps, exclusivity clauses, competitive restrictions, or content adjacency requirements.',
    `usage_report_frequency` STRING COMMENT 'Frequency at which usage reports must be submitted to the licensor. Determines reporting workflow and compliance monitoring schedule.. Valid values are `monthly|quarterly|annually|campaign_end|not_required`',
    `usage_tracking_required` BOOLEAN COMMENT 'Indicates whether detailed usage tracking and reporting is required by the license terms. When true, impression counts and placement details must be reported to the licensor.',
    CONSTRAINT pk_rights_clearance PRIMARY KEY(`rights_clearance_id`)
) COMMENT 'Tracks intellectual property and usage rights clearance for creative assets — including talent releases, music licensing, stock image/video licenses, third-party IP permissions, and usage territory/channel restrictions. Captures rights type, licensor, license start and expiry dates, permitted channels (TV, digital, OOH, social), geographic territories, usage limitations, license fee, and clearance status. Critical for preventing rights violations in campaign trafficking.';

CREATE OR REPLACE TABLE `advertising_ecm`.`creative`.`creative_deliverable` (
    `creative_deliverable_id` BIGINT COMMENT 'Unique identifier for the creative deliverable. Primary key.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser client for whom this deliverable is being produced.',
    `approval_workflow_id` BIGINT COMMENT 'Foreign key linking to project.approval_workflow. Business justification: Deliverables require approval workflows. Linking enables client acceptance tracking, contractual sign-off management, approval cycle analysis, and delivery validation. Essential for contract fulfillme',
    `worker_id` BIGINT COMMENT 'Foreign key linking to talent.worker. Business justification: Tracks art director assigned to deliverable. Essential for resource allocation, workload management, and creative team accountability. Replaces denormalized text field with structured FK for capacity ',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to audience.segment. Business justification: Deliverables are tailored to audience segments; trafficking workflows and media plan execution require segment-level creative mapping to ensure correct creative serves to each audience, essential for ',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Deliverables are produced for specific brands and must track brand association for portfolio reporting, brand-level budget tracking, compliance validation, and rights management. Fundamental project t',
    `budget_line_id` BIGINT COMMENT 'Foreign key linking to finance.budget_line. Business justification: Deliverables are discrete line items in campaign budgets (e.g., 3x 30s TV spots). Links creative output to specific budget line allocations for cost tracking, billing, and deliverable-level financia',
    `campaign_id` BIGINT COMMENT 'Reference to the campaign this deliverable supports.',
    `contract_deliverable_id` BIGINT COMMENT 'Foreign key linking to contract.deliverable. Business justification: Contract deliverables define what must be produced per agreement; creative_deliverable tracks actual creative execution. Linking these enables acceptance tracking, milestone completion validation, bil',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Deliverables are produced by specific departments/studios tracked as cost centers. Enables cost allocation, departmental utilization reporting, and chargeback accounting for deliverable production cos',
    `creative_asset_id` BIGINT COMMENT 'Foreign key linking to creative.creative_asset. Business justification: A deliverable is fulfilled by a creative asset (the actual digital file in the DAM). The creative_deliverable table currently has dam_asset_id as a STRING, which should be normalized to a proper FK to',
    `creative_brief_id` BIGINT COMMENT 'Reference to the creative brief that defines the requirements for this deliverable.',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Deliverables are outputs of initiatives. Linking enables scope validation, milestone tracking, client reporting, and deliverable inventory management across the initiative lifecycle. Critical for proj',
    `media_insertion_order_id` BIGINT COMMENT 'Foreign key linking to media.media_insertion_order. Business justification: Deliverables are trafficked against specific IOs. Production teams track which IO each deliverable supports for billing reconciliation, delivery verification, and ensuring creative is ready before IO ',
    `plan_id` BIGINT COMMENT 'Foreign key linking to media.media_plan. Business justification: Deliverables are produced to fulfill media plan requirements. Creative teams need to know which plan drives each deliverable to ensure formats, specs, and deadlines align with media flight dates and c',
    `production_job_id` BIGINT COMMENT 'Foreign key linking to creative.production_job. Business justification: A creative deliverable is the output produced by a production job. This is a direct operational relationship: the production job is the unit of work that creates the deliverable. Cardinality: N:1 (one',
    `project_budget_id` BIGINT COMMENT 'Foreign key linking to project.project_budget. Business justification: Deliverables have budget allocations. Linking enables cost-to-deliver tracking, profitability analysis, budget forecasting, and financial reporting. Critical for project financial management and prici',
    `project_milestone_id` BIGINT COMMENT 'Foreign key linking to project.project_milestone. Business justification: Deliverables are tied to contractual milestones. Linking enables billing trigger validation, client acceptance tracking, payment release management, and SOW compliance verification. Essential for reve',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Creative deliverables fulfill contractual obligations defined in SOWs. Tracking this link enables acceptance criteria validation, milestone-based invoicing, client sign-off workflows, and ensures deli',
    `spec_id` BIGINT COMMENT 'Foreign key linking to creative.creative_spec. Business justification: Deliverables must conform to creative specifications (platform requirements, format constraints, technical specs). The creative_deliverable table has format_specification as a STRING, which should be ',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Deliverables produced by external vendors need vendor tracking for invoice reconciliation, quality management, SLA monitoring, and vendor performance evaluation. Essential for production operations an',
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

CREATE OR REPLACE TABLE `advertising_ecm`.`creative`.`adaptation` (
    `adaptation_id` BIGINT COMMENT 'Unique identifier for the creative adaptation record. Primary key.',
    `worker_id` BIGINT COMMENT 'Reference to the user who initiated or created this adaptation record.',
    `adaptation_modified_by_user_worker_id` BIGINT COMMENT 'Reference to the user who last modified this adaptation record.',
    `adaptation_worker_id` BIGINT COMMENT 'Reference to the user or stakeholder who granted final approval for this adaptation.',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to audience.segment. Business justification: Adaptations are created for specific audience segments (locale, demographic, behavioral); localization and personalization workflows require linking adaptations to target segments to manage versioning',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Adaptations are brand-specific localized versions requiring brand profile reference for market-specific guidelines, tone, regulatory requirements, and brand architecture rules. Essential for global br',
    `budget_line_id` BIGINT COMMENT 'Foreign key linking to finance.budget_line. Business justification: Adaptations (localization, versioning, format changes) are discrete budget line items with separate cost allocations. Links adaptation work to specific budget lines for localization cost tracking and ',
    `campaign_id` BIGINT COMMENT 'Reference to the campaign for which this adaptation was created. Links the adaptation to its business context.',
    `creative_asset_id` BIGINT COMMENT 'Reference to the source master creative asset from which this adaptation was derived.',
    `creative_deliverable_id` BIGINT COMMENT 'Foreign key linking to creative.creative_deliverable. Business justification: Adaptations are derivative versions created to fulfill specific deliverable requirements for different markets, channels, or formats. This link tracks which deliverable an adaptation was created to fu',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Adaptations are localization work packages within initiatives. Linking enables multi-market project tracking, budget allocation across markets, and global campaign coordination. Essential for internat',
    `plan_id` BIGINT COMMENT 'Foreign key linking to media.media_plan. Business justification: Adaptations are created for specific markets and channels defined in media plans. Localization teams need plan context to ensure adaptations match target markets, languages, and channel specs in the m',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Localization and adaptation work is often separately scoped in SOWs with specific pricing for translation, cultural review, and market-specific production. Agencies track this for billing, resource pl',
    `spec_id` BIGINT COMMENT 'Foreign key linking to creative.creative_spec. Business justification: Adaptations are created to meet target format specifications for specific platforms or channels. The adaptation table has target_format as a STRING, which should be normalized to creative_spec_id FK. ',
    `supplier_id` BIGINT COMMENT 'Reference to the external vendor or internal resource responsible for translation or localization work.',
    `accessibility_compliance_flag` BOOLEAN COMMENT 'Indicates whether this adaptation includes accessibility features such as closed captions, audio descriptions, or screen reader compatibility. True if accessibility features are present.',
    `adaptation_name` STRING COMMENT 'Human-readable name or title assigned to this creative adaptation for identification and tracking purposes.',
    `adaptation_type` STRING COMMENT 'Classification of the adaptation method applied to the master asset. Defines the nature of the derivative work.. Valid values are `resize|reformat|localization|language_dub|market_variant|accessibility_variant`',
    `approval_status` STRING COMMENT 'Overall approval status of the adaptation in the creative workflow. Represents the current lifecycle state of the adaptation deliverable.. Valid values are `draft|pending_review|approved|rejected|revision_required|final`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the adaptation received final approval. Follows ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `aspect_ratio` STRING COMMENT 'Display aspect ratio of the adapted visual asset (e.g., 16:9, 4:3, 1:1, 9:16). Defines the proportional relationship between width and height.',
    `brand_compliance_score` DECIMAL(18,2) COMMENT 'Quantitative score (0-100) representing adherence to brand guidelines in this adaptation. Higher scores indicate stronger brand alignment.',
    `color_space` STRING COMMENT 'Color space standard used in the adapted asset. Critical for print vs digital delivery and color accuracy across platforms.. Valid values are `RGB|CMYK|sRGB|Adobe_RGB|Rec_709|Rec_2020`',
    `completion_date` DATE COMMENT 'Date when adaptation work was completed and the asset was delivered. Follows ISO 8601 date format (yyyy-MM-dd).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this adaptation record was first created in the system. Follows ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `cultural_review_status` STRING COMMENT 'Current status of cultural sensitivity and appropriateness review for the target market. Ensures brand safety and cultural compliance.. Valid values are `not_required|pending|in_review|approved|rejected|conditional`',
    `dam_asset_url` STRING COMMENT 'Direct URL or path to the adapted asset file stored in the Digital Asset Management system (e.g., Workfront DAM, Adobe Creative Cloud).',
    `duration_seconds` DECIMAL(18,2) COMMENT 'Duration of the adapted video or audio asset in seconds. Applicable to time-based media formats.',
    `file_size_kb` DECIMAL(18,2) COMMENT 'File size of the adapted creative asset in kilobytes. Used for delivery optimization and platform compliance checks.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this adaptation is currently active and available for use in campaigns. True if active, False if retired or archived.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this adaptation record was last modified. Follows ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `notes` STRING COMMENT 'Free-text field capturing additional context, special instructions, or technical notes related to the adaptation process.',
    `rationale` STRING COMMENT 'Business justification or reason for creating this adaptation. Captures strategic context such as regulatory compliance, cultural sensitivity, platform requirements, or audience targeting needs.',
    `regulatory_review_status` STRING COMMENT 'Current status of regulatory and legal compliance review for the target market. Ensures adherence to local advertising standards and regulations.. Valid values are `not_required|pending|in_review|approved|rejected|conditional`',
    `resolution` STRING COMMENT 'Pixel resolution of the adapted visual asset (e.g., 1920x1080, 1080x1920, 300x250). Defines the dimensions in pixels.',
    `source_language` STRING COMMENT 'ISO 639-1 two-letter language code of the original master asset before adaptation.. Valid values are `^[a-z]{2}$`',
    `start_date` DATE COMMENT 'Date when adaptation work commenced. Follows ISO 8601 date format (yyyy-MM-dd).',
    `target_audience_segment` STRING COMMENT 'Specific audience segment or demographic group for which this adaptation is optimized. Supports audience-specific creative variations.',
    `target_channel` STRING COMMENT 'Media channel or platform for which this adaptation is intended (e.g., Facebook, Instagram, YouTube, CTV, DOOH, Print).',
    `target_language` STRING COMMENT 'ISO 639-1 two-letter language code of the adapted asset. Used for language dub and localization tracking.. Valid values are `^[a-z]{2}$`',
    `target_locale` STRING COMMENT 'ISO locale code representing the target language and region for this adaptation (e.g., en_US, fr_FR, es_MX). Used for localization tracking.. Valid values are `^[a-z]{2}_[A-Z]{2}$`',
    `target_market` STRING COMMENT 'Three-letter ISO country code representing the geographic market for which this adaptation is intended.. Valid values are `^[A-Z]{3}$`',
    `version_number` STRING COMMENT 'Version identifier for this adaptation. Tracks iterative changes within the adaptation itself (distinct from master asset versioning).',
    CONSTRAINT pk_adaptation PRIMARY KEY(`adaptation_id`)
) COMMENT 'Tracks creative adaptations — derivative versions of a master creative asset adapted for different formats, channels, languages, markets, or audience segments. Captures adaptation type (resize, reformat, localization, language dub, market variant, accessibility variant), source master asset reference, target spec, target locale/market, adaptation rationale, translator/localizer reference, cultural review status, and approval status. Supports multi-market campaign rollouts where a single master creative is adapted across 10-50+ markets with local language, regulatory, and cultural requirements. Distinct from asset_version (which tracks iterative edits to the same deliverable) — an adaptation is a purposeful derivative for a different deployment context, channel, or market.';

CREATE OR REPLACE TABLE `advertising_ecm`.`creative`.`creative_request` (
    `creative_request_id` BIGINT COMMENT 'Unique identifier for the creative request. Primary key.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser (client) for whom the creative request is being executed.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Change requests and scope additions reference the governing agreement to validate whether work is in-scope or requires a change order/amendment. Essential for scope management, change order workflows,',
    `campaign_id` BIGINT COMMENT 'Reference to the campaign this creative request is associated with.',
    `change_request_id` BIGINT COMMENT 'Foreign key linking to project.change_request. Business justification: Creative requests often trigger formal change requests. Linking enables scope change management, SOW amendment tracking, budget impact analysis, and client approval workflow. Essential for change cont',
    `client_brand_id` BIGINT COMMENT 'Reference to the specific client brand associated with this creative request.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Change requests are fulfilled by departments tracked as cost centers. Enables chargeback accounting for unplanned work, tracks cost center utilization for change management, and supports departmental ',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Creative requests trigger work within initiatives. Linking enables intake management, scope control, change tracking, and workload forecasting. Critical for demand management and resource allocation p',
    `media_insertion_order_id` BIGINT COMMENT 'Foreign key linking to media.media_insertion_order. Business justification: Creative change requests often originate from IO-level issues: publisher rejections, spec changes, or trafficking problems. Tracking the triggering IO is essential for root cause analysis, billing adj',
    `client_contact_id` BIGINT COMMENT 'Reference to the client contact or internal stakeholder who initiated the creative request.',
    `production_job_id` BIGINT COMMENT 'Reference to the original production job if this request is a modification or amendment to existing creative work.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Change requests may be routed to external production vendors for execution. Enables vendor workload tracking, cost estimation, and vendor assignment workflows in production management systems.',
    `worker_id` BIGINT COMMENT 'Reference to the creative team member or studio resource assigned to execute this request.',
    `actual_completion_timestamp` TIMESTAMP COMMENT 'Date and time when the creative request was actually completed and delivered.',
    `actual_effort_hours` DECIMAL(18,2) COMMENT 'Actual number of hours spent completing the creative request, tracked for billing and performance analysis.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether formal client or internal approval is required before the request can be marked as complete.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the creative request was formally approved.',
    `assigned_studio` STRING COMMENT 'Name or identifier of the creative studio, production unit, or external vendor assigned to fulfill the request.',
    `assigned_team_member_name` STRING COMMENT 'Name of the creative professional or studio assigned to the request for quick reference.',
    `business_justification` STRING COMMENT 'Rationale or business reason for the creative request, explaining why the change is necessary.',
    `change_description` STRING COMMENT 'Detailed narrative describing the requested changes, amendments, or new creative work required.',
    `created_timestamp` TIMESTAMP COMMENT 'Audit timestamp indicating when this record was first created in the data platform.',
    `estimated_effort_hours` DECIMAL(18,2) COMMENT 'Estimated number of hours required to complete the creative request, used for resource planning and capacity management.',
    `impacted_asset_count` STRING COMMENT 'Number of creative assets that will be affected or modified by this request.',
    `impacted_asset_list` STRING COMMENT 'Comma-separated list or description of specific creative asset IDs or names that are impacted by this request.',
    `language_code` STRING COMMENT 'ISO language code indicating the language for which creative assets are being requested or adapted.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `legal_review_required_flag` BOOLEAN COMMENT 'Indicates whether the creative request requires legal or compliance review before completion.',
    `market_code` STRING COMMENT 'Three-letter ISO country code representing the target market or geography for which the creative request is intended.. Valid values are `^[A-Z]{3}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Audit timestamp indicating when this record was last updated in the data platform.',
    `priority_level` STRING COMMENT 'Business priority assigned to the creative request, determining SLA (Service Level Agreement) and resource allocation urgency.. Valid values are `standard|high|urgent|emergency`',
    `regulatory_compliance_notes` STRING COMMENT 'Notes or documentation related to regulatory compliance requirements that must be addressed in the creative request.',
    `rejection_reason` STRING COMMENT 'Explanation or rationale provided when a creative request is rejected or cancelled.',
    `request_number` STRING COMMENT 'Business-facing unique identifier for the creative request, typically generated by Workfront request queue system.. Valid values are `^CR-[0-9]{6,10}$`',
    `request_status` STRING COMMENT 'Current lifecycle status of the creative request in the workflow. [ENUM-REF-CANDIDATE: submitted|under_review|assigned|in_progress|on_hold|awaiting_approval|approved|completed|cancelled|rejected — 10 candidates stripped; promote to reference product]',
    `request_type` STRING COMMENT 'Classification of the creative request indicating the nature of the change or work required. [ENUM-REF-CANDIDATE: amend|resize|copy_change|legal_update|regulatory_update|versioning|market_adaptation|emergency_revision|format_conversion|asset_refresh — 10 candidates stripped; promote to reference product]',
    `requestor_email` STRING COMMENT 'Email address of the requestor for communication and notification purposes.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `requestor_name` STRING COMMENT 'Full name of the individual who submitted the creative request.',
    `sla_deadline_timestamp` TIMESTAMP COMMENT 'Service Level Agreement deadline timestamp by which the request must be completed to meet contractual obligations.',
    `sla_met_flag` BOOLEAN COMMENT 'Boolean indicator of whether the creative request was completed within the agreed SLA timeframe.',
    `submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the creative request was originally submitted into the system.',
    `target_completion_date` DATE COMMENT 'Requested or agreed-upon date by which the creative request must be completed.',
    `workfront_request_ref` STRING COMMENT 'External system identifier from Workfront request queue, used for integration and cross-system tracking.',
    CONSTRAINT pk_creative_request PRIMARY KEY(`creative_request_id`)
) COMMENT 'Captures ad-hoc, reactive, or change-request creative work orders raised during a campaign lifecycle — including client amends, format resizes, copy changes, legal/regulatory updates, versioning for new markets, and emergency revisions under tight deadlines. Tracks request type, requestor (client contact or internal stakeholder), priority level (standard, urgent, emergency), change description, impacted assets, estimated effort hours, assigned team member or studio, target completion date, and completion status. Distinct from production_job (which covers planned, brief-driven production) — a creative_request is reactive, change-driven work initiated post-brief, often with compressed timelines. Sourced from Workfront request queues and integrated with agency SLA tracking.';

CREATE OR REPLACE TABLE `advertising_ecm`.`creative`.`asset_usage` (
    `asset_usage_id` BIGINT COMMENT 'Unique identifier for each instance of creative asset deployment or trafficking. Primary key.',
    `ad_id` BIGINT COMMENT 'Reference to the specific ad unit or creative execution that contains this asset.',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to audience.segment. Business justification: Usage tracking must tie creative to segment for attribution; performance reporting and optimization require segment-level creative analysis to identify which assets resonate with which audiences and i',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Asset usage must be tracked by brand for rights compliance reporting, brand-level performance analytics, share-of-voice measurement, and usage rights validation. Operational necessity for multi-brand ',
    `buy_id` BIGINT COMMENT 'Foreign key linking to media.media_buy. Business justification: Usage records link assets to specific buys for delivery verification, makegood tracking, and reconciliation. Ensures creative ran as contracted and supports billing disputes and performance analysis b',
    `campaign_id` BIGINT COMMENT 'Reference to the campaign in which this asset is being used. Enables cross-campaign creative performance attribution.',
    `creative_asset_id` BIGINT COMMENT 'Reference to the creative asset being deployed. Links to the master creative asset record in the DAM system.',
    `flight_id` BIGINT COMMENT 'Reference to the specific campaign flight or time-bound execution period during which the asset is deployed.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Asset usage events can trigger accrual or revenue journal entries (e.g., usage-based royalties, performance fees). Links usage to financial postings for automated accrual generation and audit trail.',
    `line_item_id` BIGINT COMMENT 'Reference to the media line item or insertion order line associated with this asset usage.',
    `media_insertion_order_id` BIGINT COMMENT 'Foreign key linking to media.media_insertion_order. Business justification: Usage tracking ties assets to IOs for billing reconciliation, rights compliance verification, and ensuring asset usage stays within authorized spend and contracted terms. Critical for financial close ',
    `media_placement_id` BIGINT COMMENT 'Foreign key linking to media.media_placement. Business justification: Usage records track which placements each asset ran in. Essential for rights management (ensuring usage stays within licensed territories/channels), performance attribution, and billing reconciliation',
    `spec_id` BIGINT COMMENT 'Foreign key linking to creative.creative_spec. Business justification: When an asset is trafficked and deployed (usage instance), it must conform to the platform/placement specifications. The creative_asset_usage table has format as a STRING, which should be normalized t',
    `trafficking_order_id` BIGINT COMMENT 'Reference to the trafficking order or insertion order under which this asset was deployed to the ad server.',
    `ad_server_ref` STRING COMMENT 'The unique identifier assigned by the ad server (e.g., Google Campaign Manager 360) for this creative deployment. Enables reconciliation with ad server reporting.',
    `asset_version` STRING COMMENT 'The version identifier of the creative asset used in this deployment. Tracks which iteration or variant of the asset was trafficked.',
    `channel` STRING COMMENT 'The media channel through which the creative asset is being delivered. Supports channel-specific creative performance analysis. [ENUM-REF-CANDIDATE: display|video|social|search|email|mobile|ctv|ooh|dooh|audio — 10 candidates stripped; promote to reference product]',
    `click_count` BIGINT COMMENT 'The total number of clicks recorded for this asset usage instance. Captured from ad server reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this usage record was first created in the system. Audit trail field.',
    `creative_rotation_weight` STRING COMMENT 'The rotation weight or priority assigned to this asset within a multi-creative rotation. Higher values indicate higher priority or frequency.',
    `ctr` DECIMAL(18,2) COMMENT 'The click-through rate for this asset usage instance, expressed as a decimal (e.g., 0.025 for 2.5%). Enables creative performance benchmarking.',
    `duration_seconds` STRING COMMENT 'The duration of the creative asset in seconds. Applicable to video and audio assets. Null for static formats.',
    `file_size_kb` DECIMAL(18,2) COMMENT 'The file size of the creative asset in kilobytes as deployed. Used for load time analysis and format compliance verification.',
    `impression_count` BIGINT COMMENT 'The total number of impressions delivered for this asset usage instance. Captured from ad server reporting.',
    `is_rights_compliant` BOOLEAN COMMENT 'Boolean flag indicating whether this asset usage is within the approved rights period and territory. True if compliant, False if expired or out of territory.',
    `language` STRING COMMENT 'The language of the creative asset used in this deployment. ISO 639-1 two-letter language code (e.g., EN, ES, FR).',
    `market` STRING COMMENT 'The market or geographic region where the asset is being deployed. Enables market-specific creative performance analysis.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this usage record was last modified. Audit trail field for tracking changes to usage details.',
    `platform` STRING COMMENT 'The specific platform or publisher where the asset is deployed (e.g., Google Display Network, Facebook, YouTube, Hulu, Spotify). Free-text field to accommodate diverse platform ecosystem.',
    `rights_end_date` DATE COMMENT 'The end date of the usage rights period for this asset. Critical for rights expiry monitoring and compliance. Nullable for perpetual rights.',
    `rights_start_date` DATE COMMENT 'The start date of the usage rights period for this asset. Defines when the legal right to use the asset begins.',
    `rights_territory` STRING COMMENT 'The geographic territory or market for which usage rights apply. May be a country code, region, or global designation. Supports multi-market rights management.',
    `trafficked_by` STRING COMMENT 'The name or identifier of the user or system that trafficked this asset into the ad server or media channel. Supports audit trail and accountability.',
    `trafficking_date` DATE COMMENT 'The date when the creative asset was trafficked or deployed into the ad server or media channel. Principal business event timestamp for this usage record.',
    `usage_end_date` DATE COMMENT 'The date when the creative asset usage period ends. Marks the conclusion of the active deployment window.',
    `usage_notes` STRING COMMENT 'Free-text notes or comments about this specific asset usage instance. May include trafficking instructions, special handling notes, or performance observations.',
    `usage_start_date` DATE COMMENT 'The date when the creative asset usage period begins. Marks the start of the active deployment window.',
    `usage_status` STRING COMMENT 'The current lifecycle status of this asset usage instance. Tracks whether the deployment is active, paused, completed, cancelled, or expired.. Valid values are `active|paused|completed|cancelled|expired`',
    `usage_type` STRING COMMENT 'The type of deployment or usage context for this asset instance. Distinguishes between campaign trafficking, ad server deployment, social media posting, email marketing, website placement, mobile app integration, or out-of-home display. [ENUM-REF-CANDIDATE: campaign|ad_server|social_media|email|website|mobile_app|ooh — 7 candidates stripped; promote to reference product]',
    `video_completion_rate` DECIMAL(18,2) COMMENT 'The video completion rate for video asset usage, expressed as a decimal. Percentage of video views that reached 100% completion. Null for non-video assets.',
    CONSTRAINT pk_asset_usage PRIMARY KEY(`asset_usage_id`)
) COMMENT 'Transactional record capturing each instance where a creative asset is deployed or trafficked into a campaign, ad server (Google CM360), or media channel. Records usage context (campaign, flight, placement, channel, market), trafficking date, asset version used, and usage rights period consumed. Enables rights expiry monitoring, asset reuse tracking, and cross-campaign creative performance attribution. Bridges the creative domain with the campaign and media domains.';

CREATE OR REPLACE TABLE `advertising_ecm`.`creative`.`proof_review` (
    `proof_review_id` BIGINT COMMENT 'Unique identifier for this proof review record. Primary key.',
    `client_contact_id` BIGINT COMMENT 'Foreign key to client.client_contact. Identifies which client stakeholder participated in this review.',
    `contact_client_contact_id` BIGINT COMMENT 'Foreign key linking to the client contact who participated in this proof review',
    `proof_id` BIGINT COMMENT 'Foreign key to creative.proof. Identifies which proof was reviewed.',
    `assigned_timestamp` TIMESTAMP COMMENT 'Date and time when this reviewer was assigned to this proof. Used to calculate time-to-review and track when stakeholders were notified.',
    `comments_count` STRING COMMENT 'Number of comments and annotations this specific reviewer submitted on this proof. Explicitly identified in detection reasoning as relationship data.',
    `decision` STRING COMMENT 'This individual reviewers decision on the proof. Explicitly identified in detection reasoning as relationship data. Distinct from proof.overall_decision which aggregates all reviewers.',
    `decision_timestamp` TIMESTAMP COMMENT 'Date and time when this specific reviewer submitted their decision. Explicitly identified in detection reasoning as relationship data. Used to track individual reviewer turnaround times.',
    `is_required_reviewer` BOOLEAN COMMENT 'Indicates whether this reviewers approval was mandatory for the proof to proceed (true) or if they were an optional/informational reviewer (false). Used for approval workflow logic.',
    `review_duration_hours` DECIMAL(18,2) COMMENT 'Calculated time in hours this reviewer took to complete their review, from proof submission to their decision timestamp. Used for stakeholder engagement analytics.',
    `review_round` STRING COMMENT 'The review round number in which this contact participated for this proof (1 = first client review, 2 = second round after revisions, etc.). Explicitly identified in detection reasoning as relationship data.',
    `reviewer_role` STRING COMMENT 'The functional role this client contact played in reviewing this specific proof (e.g., Brand Manager, Legal Reviewer, Marketing Director). Explicitly identified in detection reasoning as relationship data.',
    CONSTRAINT pk_proof_review PRIMARY KEY(`proof_review_id`)
) COMMENT 'This association product represents the formal review event between a client contact and a creative proof. It captures each stakeholders individual review decision, role in the approval process, and feedback contribution. Each record links one client contact to one proof with attributes that exist only in the context of this specific review participation.. Existence Justification: In advertising creative approval workflows, proofs are reviewed by multiple client stakeholders across different functional roles (brand managers, legal reviewers, product managers, finance approvers) and across multiple review rounds. Each client contact reviews many proofs over time as campaigns progress. The business actively manages these review assignments, tracks individual reviewer decisions and turnaround times, and reports on approval bottlenecks by stakeholder role.';

CREATE OR REPLACE TABLE `advertising_ecm`.`creative`.`asset_budget_allocation` (
    `asset_budget_allocation_id` BIGINT COMMENT 'Unique identifier for this asset-budget allocation record. Primary key for the association.',
    `budget_line_id` BIGINT COMMENT 'Foreign key linking to the budget line funding or utilizing this creative asset',
    `creative_asset_id` BIGINT COMMENT 'Foreign key linking to the creative asset being allocated to this budget line',
    `actual_spend` DECIMAL(18,2) COMMENT 'The actual amount spent on this creative asset charged to this specific budget line. Tracks realized costs for variance analysis and margin calculation.',
    `allocated_amount` DECIMAL(18,2) COMMENT 'The portion of the budget line amount allocated to this specific creative asset. Used for multi-asset cost distribution and asset-level profitability analysis.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'The percentage of the assets total production cost allocated to this budget line. Used when a single assets cost is split across multiple budget lines based on usage intensity or media weight.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this allocation record was created. Audit trail for financial tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this allocation record was last modified. Change tracking for financial audit.',
    `notes` STRING COMMENT 'Free-form notes about this specific asset-budget allocation. Captures rationale for allocation decisions, usage constraints, or special circumstances.',
    `usage_end_date` DATE COMMENT 'The date when this creative asset stopped being used under this specific budget line. Defines the end of the usage period for cost allocation and rights tracking.',
    `usage_start_date` DATE COMMENT 'The date when this creative asset began being used under this specific budget line. Defines the start of the usage period for cost allocation and rights tracking.',
    `usage_type` STRING COMMENT 'Classification of how this asset is being used under this budget line. Values: primary (original production), reuse (asset repurposed from another campaign), adaptation (modified version), localization (market-specific version), extension (campaign extension). Critical for understanding cost efficiency and asset reuse ROI.',
    `created_by` STRING COMMENT 'Identifier of the user who created this allocation record. Accountability for financial decisions.',
    CONSTRAINT pk_asset_budget_allocation PRIMARY KEY(`asset_budget_allocation_id`)
) COMMENT 'This association product represents the allocation relationship between creative assets and budget lines in advertising campaign financial management. It captures the multi-use cost allocation model where a single creative asset (hero video, key visual) is reused across multiple budget lines (TV flight, digital campaign, social media phase) and where a single budget line funds production of multiple assets in batch. Each record links one creative asset to one budget line with usage period, allocated spend, actual spend, and usage type that exist only in the context of this specific asset-budget pairing.. Existence Justification: In advertising operations, creative assets are routinely reused across multiple budget lines to maximize production ROI—a hero video produced for TV may be repurposed for digital, social, and OOH campaigns, each with separate budget lines and usage periods. Conversely, a single budget line (e.g., Q2 Social Media Production) often funds batch production of multiple assets (carousel ads, stories, reels). The business actively manages these allocations to track per-asset-per-budget-line spend attribution, usage periods, and cost efficiency metrics for margin analysis and P&L reporting.';

CREATE OR REPLACE TABLE `advertising_ecm`.`creative`.`review_cycle` (
    `review_cycle_id` BIGINT COMMENT 'Primary key for review_cycle',
    `assigned_to_user_worker_id` BIGINT COMMENT 'Reference to the user or reviewer currently assigned to complete this review cycle.',
    `creative_asset_id` BIGINT COMMENT 'Reference to the creative asset being reviewed in this cycle.',
    `escalated_to_user_worker_id` BIGINT COMMENT 'Reference to the user or manager to whom this review cycle has been escalated. Null if not escalated.',
    `initiative_id` BIGINT COMMENT 'Reference to the parent project or campaign this review cycle belongs to.',
    `review_group_id` BIGINT COMMENT 'Reference to the review group or team responsible for this cycle (e.g., Creative Team, Legal Department, Client Stakeholders).',
    `worker_id` BIGINT COMMENT 'Reference to the user who initiated or requested this review cycle.',
    `previous_review_cycle_id` BIGINT COMMENT 'Self-referencing FK on review_cycle (previous_review_cycle_id)',
    `approval_required` BOOLEAN COMMENT 'Indicates whether formal approval is required to complete this review cycle (true) or if it is informational only (false).',
    `approval_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the review cycle was approved. Null if not yet approved or if rejected.',
    `completed_date` DATE COMMENT 'Actual date when the review cycle was completed or closed. Null if still in progress.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this review cycle record was first created in the system.',
    `cycle_name` STRING COMMENT 'Human-readable name or label for this review cycle (e.g., Initial Brand Review, Legal Compliance Check).',
    `cycle_number` STRING COMMENT 'Sequential number of this review cycle within the assets review history (e.g., 1st review, 2nd review).',
    `decision_summary` STRING COMMENT 'Summary of the final decision or outcome of the review cycle (e.g., Approved with minor changes, Rejected due to brand non-compliance).',
    `due_date` DATE COMMENT 'Target date by which the review cycle should be completed.',
    `escalation_required` BOOLEAN COMMENT 'Indicates whether this review cycle requires escalation to higher authority or management (true) or can be resolved at current level (false).',
    `escalation_timestamp` TIMESTAMP COMMENT 'Timestamp when the review cycle was escalated. Null if not escalated.',
    `external_review_url` STRING COMMENT 'URL link to external review platform or proofing tool where this review cycle is being conducted (e.g., Adobe Workfront Proof link).',
    `external_system_code` STRING COMMENT 'Identifier of this review cycle in the external integrated system for cross-system tracking and synchronization.',
    `integration_system` STRING COMMENT 'Name of the external system integrated for this review cycle (e.g., Adobe Workfront, Frame.io, Wrike Proof).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this review cycle record was last modified or updated.',
    `notification_sent` BOOLEAN COMMENT 'Indicates whether notification has been sent to reviewers about this review cycle (true) or not (false).',
    `priority` STRING COMMENT 'Priority level assigned to this review cycle indicating urgency (low, medium, high, urgent).',
    `rejection_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the review cycle was rejected. Null if not rejected.',
    `reminder_sent_count` STRING COMMENT 'Number of reminder notifications sent to reviewers for this review cycle.',
    `review_instructions` STRING COMMENT 'Specific instructions or guidance provided to reviewers for this cycle (e.g., focus areas, checklist items, brand guidelines to verify).',
    `review_type` STRING COMMENT 'Category of review being conducted (internal team review, client approval, legal compliance, brand guidelines, technical QA, or final sign-off).',
    `reviewers_completed` STRING COMMENT 'Count of reviewers who have completed their review within this cycle.',
    `sla_actual_hours` DECIMAL(18,2) COMMENT 'Actual number of hours taken to complete this review cycle. Null if not yet completed.',
    `sla_met` BOOLEAN COMMENT 'Indicates whether the review cycle was completed within the SLA target hours (true) or exceeded the target (false). Null if not yet completed.',
    `sla_target_hours` STRING COMMENT 'Target number of hours within which this review cycle should be completed per service level agreement.',
    `start_date` DATE COMMENT 'Date when the review cycle was initiated or opened.',
    `review_cycle_status` STRING COMMENT 'Current lifecycle status of the review cycle (draft, in review, pending feedback, approved, rejected, on hold).',
    `total_comments` STRING COMMENT 'Total number of comments or feedback items submitted during this review cycle.',
    `total_reviewers` STRING COMMENT 'Total count of reviewers assigned to participate in this review cycle.',
    `unanimous_approval_required` BOOLEAN COMMENT 'Indicates whether all assigned reviewers must approve (true) or if majority/single approval is sufficient (false).',
    `unresolved_comments` STRING COMMENT 'Count of comments or feedback items that remain unresolved or unaddressed.',
    `version_reviewed` STRING COMMENT 'Version identifier of the creative asset that was reviewed in this cycle (e.g., v1.2, Draft 3).',
    CONSTRAINT pk_review_cycle PRIMARY KEY(`review_cycle_id`)
) COMMENT 'Master reference table for review_cycle. Referenced by review_cycle_id.';

CREATE OR REPLACE TABLE `advertising_ecm`.`creative`.`review_group` (
    `review_group_id` BIGINT COMMENT 'Primary key for review_group',
    `applicable_asset_types` STRING COMMENT 'Comma-separated list of creative asset types this review group is qualified and authorized to review (e.g., video, display, print, social).',
    `applicable_brands` STRING COMMENT 'Comma-separated list of brand identifiers or names for which this review group has review authority.',
    `applicable_regions` STRING COMMENT 'Comma-separated list of geographic regions or markets for which this review group has jurisdiction and expertise.',
    `approval_authority_level` STRING COMMENT 'The level of decision-making authority this review group holds in the creative approval process.',
    `archived_by_user_id` BIGINT COMMENT 'Identifier of the user who archived this review group.',
    `archived_timestamp` TIMESTAMP COMMENT 'The date and time when this review group was archived and removed from active use.',
    `auto_assign_enabled` BOOLEAN COMMENT 'Indicates whether this review group is automatically assigned to creative reviews based on predefined rules and criteria.',
    `auto_assign_rules` STRING COMMENT 'JSON or text representation of the business rules that trigger automatic assignment of this review group to creative projects.',
    `review_group_code` STRING COMMENT 'Short alphanumeric code used as a business identifier for the review group in workflows and integrations.',
    `created_by_user_id` BIGINT COMMENT 'Identifier of the user who created this review group record.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this review group record was first created in the system.',
    `default_sla_hours` STRING COMMENT 'The standard number of hours allocated for this review group to complete their review and provide feedback or approval.',
    `review_group_description` STRING COMMENT 'Detailed description of the review groups purpose, responsibilities, and scope within the creative approval workflow.',
    `effective_end_date` DATE COMMENT 'The date on which this review group ceases to be active and is no longer available for new review assignments.',
    `effective_start_date` DATE COMMENT 'The date from which this review group becomes active and available for assignment to creative reviews.',
    `escalation_sla_hours` STRING COMMENT 'The number of hours after which an unresolved review is escalated to higher authority or alternate reviewers.',
    `integration_system_id` STRING COMMENT 'External system identifier used for integration with Adobe Workfront, Creative Cloud, or other Digital Asset Management (DAM) platforms.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether review by this group is mandatory for creative asset approval or optional based on project requirements.',
    `minimum_approvers_required` STRING COMMENT 'The minimum number of individual approvers from this group required to grant group-level approval.',
    `modified_by_user_id` BIGINT COMMENT 'Identifier of the user who last modified this review group record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this review group record was last modified.',
    `review_group_name` STRING COMMENT 'The human-readable name of the review group used for identification and display purposes.',
    `notes` STRING COMMENT 'Free-text field for capturing additional notes, instructions, or context about the review groups purpose and usage.',
    `notification_channel` STRING COMMENT 'The preferred communication channel for delivering review notifications and updates to this group.',
    `notification_email` STRING COMMENT 'Primary email address used for sending review notifications, reminders, and escalations to the review group.',
    `owner_user_id` BIGINT COMMENT 'Identifier of the user who owns and manages this review group, responsible for membership and configuration.',
    `parent_review_group_id` BIGINT COMMENT 'Identifier of the parent review group in a hierarchical review structure, enabling nested or tiered approval workflows.',
    `requires_unanimous_approval` BOOLEAN COMMENT 'Indicates whether all members of this review group must approve for the groups approval to be granted, or if majority/single approval is sufficient.',
    `review_scope` STRING COMMENT 'Description of the specific aspects of creative assets this group is responsible for reviewing (e.g., brand compliance, legal compliance, technical specifications).',
    `review_sequence_order` STRING COMMENT 'The numeric order in which this review group should be engaged in a sequential approval workflow.',
    `review_group_status` STRING COMMENT 'Current lifecycle status of the review group indicating whether it is available for assignment to creative reviews.',
    `review_group_type` STRING COMMENT 'Classification of the review group based on its organizational role and purpose in the creative review process.',
    CONSTRAINT pk_review_group PRIMARY KEY(`review_group_id`)
) COMMENT 'Master reference table for review_group. Referenced by review_group_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ADD CONSTRAINT `fk_creative_creative_asset_parent_asset_creative_asset_id` FOREIGN KEY (`parent_asset_creative_asset_id`) REFERENCES `advertising_ecm`.`creative`.`creative_asset`(`creative_asset_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ADD CONSTRAINT `fk_creative_creative_asset_spec_id` FOREIGN KEY (`spec_id`) REFERENCES `advertising_ecm`.`creative`.`spec`(`spec_id`);
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ADD CONSTRAINT `fk_creative_asset_version_creative_asset_id` FOREIGN KEY (`creative_asset_id`) REFERENCES `advertising_ecm`.`creative`.`creative_asset`(`creative_asset_id`);
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ADD CONSTRAINT `fk_creative_asset_version_creative_deliverable_id` FOREIGN KEY (`creative_deliverable_id`) REFERENCES `advertising_ecm`.`creative`.`creative_deliverable`(`creative_deliverable_id`);
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ADD CONSTRAINT `fk_creative_asset_version_spec_id` FOREIGN KEY (`spec_id`) REFERENCES `advertising_ecm`.`creative`.`spec`(`spec_id`);
ALTER TABLE `advertising_ecm`.`creative`.`concept` ADD CONSTRAINT `fk_creative_concept_creative_brief_id` FOREIGN KEY (`creative_brief_id`) REFERENCES `advertising_ecm`.`creative`.`creative_brief`(`creative_brief_id`);
ALTER TABLE `advertising_ecm`.`creative`.`concept` ADD CONSTRAINT `fk_creative_concept_parent_concept_id` FOREIGN KEY (`parent_concept_id`) REFERENCES `advertising_ecm`.`creative`.`concept`(`concept_id`);
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ADD CONSTRAINT `fk_creative_production_job_concept_id` FOREIGN KEY (`concept_id`) REFERENCES `advertising_ecm`.`creative`.`concept`(`concept_id`);
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ADD CONSTRAINT `fk_creative_production_job_creative_brief_id` FOREIGN KEY (`creative_brief_id`) REFERENCES `advertising_ecm`.`creative`.`creative_brief`(`creative_brief_id`);
ALTER TABLE `advertising_ecm`.`creative`.`proof` ADD CONSTRAINT `fk_creative_proof_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `advertising_ecm`.`creative`.`asset_version`(`asset_version_id`);
ALTER TABLE `advertising_ecm`.`creative`.`proof` ADD CONSTRAINT `fk_creative_proof_production_job_id` FOREIGN KEY (`production_job_id`) REFERENCES `advertising_ecm`.`creative`.`production_job`(`production_job_id`);
ALTER TABLE `advertising_ecm`.`creative`.`proof_comment` ADD CONSTRAINT `fk_creative_proof_comment_parent_comment_proof_comment_id` FOREIGN KEY (`parent_comment_proof_comment_id`) REFERENCES `advertising_ecm`.`creative`.`proof_comment`(`proof_comment_id`);
ALTER TABLE `advertising_ecm`.`creative`.`proof_comment` ADD CONSTRAINT `fk_creative_proof_comment_proof_id` FOREIGN KEY (`proof_id`) REFERENCES `advertising_ecm`.`creative`.`proof`(`proof_id`);
ALTER TABLE `advertising_ecm`.`creative`.`proof_comment` ADD CONSTRAINT `fk_creative_proof_comment_review_cycle_id` FOREIGN KEY (`review_cycle_id`) REFERENCES `advertising_ecm`.`creative`.`review_cycle`(`review_cycle_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ADD CONSTRAINT `fk_creative_creative_compliance_check_brand_guideline_id` FOREIGN KEY (`brand_guideline_id`) REFERENCES `advertising_ecm`.`creative`.`brand_guideline`(`brand_guideline_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ADD CONSTRAINT `fk_creative_creative_compliance_check_creative_asset_id` FOREIGN KEY (`creative_asset_id`) REFERENCES `advertising_ecm`.`creative`.`creative_asset`(`creative_asset_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ADD CONSTRAINT `fk_creative_creative_compliance_check_creative_deliverable_id` FOREIGN KEY (`creative_deliverable_id`) REFERENCES `advertising_ecm`.`creative`.`creative_deliverable`(`creative_deliverable_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ADD CONSTRAINT `fk_creative_creative_compliance_check_previous_check_creative_compliance_check_id` FOREIGN KEY (`previous_check_creative_compliance_check_id`) REFERENCES `advertising_ecm`.`creative`.`creative_compliance_check`(`creative_compliance_check_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ADD CONSTRAINT `fk_creative_creative_compliance_check_proof_id` FOREIGN KEY (`proof_id`) REFERENCES `advertising_ecm`.`creative`.`proof`(`proof_id`);
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ADD CONSTRAINT `fk_creative_rights_clearance_adaptation_id` FOREIGN KEY (`adaptation_id`) REFERENCES `advertising_ecm`.`creative`.`adaptation`(`adaptation_id`);
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ADD CONSTRAINT `fk_creative_rights_clearance_creative_asset_id` FOREIGN KEY (`creative_asset_id`) REFERENCES `advertising_ecm`.`creative`.`creative_asset`(`creative_asset_id`);
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ADD CONSTRAINT `fk_creative_rights_clearance_stock_media_asset_id` FOREIGN KEY (`stock_media_asset_id`) REFERENCES `advertising_ecm`.`creative`.`creative_asset`(`creative_asset_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ADD CONSTRAINT `fk_creative_creative_deliverable_creative_asset_id` FOREIGN KEY (`creative_asset_id`) REFERENCES `advertising_ecm`.`creative`.`creative_asset`(`creative_asset_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ADD CONSTRAINT `fk_creative_creative_deliverable_creative_brief_id` FOREIGN KEY (`creative_brief_id`) REFERENCES `advertising_ecm`.`creative`.`creative_brief`(`creative_brief_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ADD CONSTRAINT `fk_creative_creative_deliverable_production_job_id` FOREIGN KEY (`production_job_id`) REFERENCES `advertising_ecm`.`creative`.`production_job`(`production_job_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ADD CONSTRAINT `fk_creative_creative_deliverable_spec_id` FOREIGN KEY (`spec_id`) REFERENCES `advertising_ecm`.`creative`.`spec`(`spec_id`);
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ADD CONSTRAINT `fk_creative_adaptation_creative_asset_id` FOREIGN KEY (`creative_asset_id`) REFERENCES `advertising_ecm`.`creative`.`creative_asset`(`creative_asset_id`);
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ADD CONSTRAINT `fk_creative_adaptation_creative_deliverable_id` FOREIGN KEY (`creative_deliverable_id`) REFERENCES `advertising_ecm`.`creative`.`creative_deliverable`(`creative_deliverable_id`);
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ADD CONSTRAINT `fk_creative_adaptation_spec_id` FOREIGN KEY (`spec_id`) REFERENCES `advertising_ecm`.`creative`.`spec`(`spec_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ADD CONSTRAINT `fk_creative_creative_request_production_job_id` FOREIGN KEY (`production_job_id`) REFERENCES `advertising_ecm`.`creative`.`production_job`(`production_job_id`);
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ADD CONSTRAINT `fk_creative_asset_usage_creative_asset_id` FOREIGN KEY (`creative_asset_id`) REFERENCES `advertising_ecm`.`creative`.`creative_asset`(`creative_asset_id`);
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ADD CONSTRAINT `fk_creative_asset_usage_spec_id` FOREIGN KEY (`spec_id`) REFERENCES `advertising_ecm`.`creative`.`spec`(`spec_id`);
ALTER TABLE `advertising_ecm`.`creative`.`proof_review` ADD CONSTRAINT `fk_creative_proof_review_proof_id` FOREIGN KEY (`proof_id`) REFERENCES `advertising_ecm`.`creative`.`proof`(`proof_id`);
ALTER TABLE `advertising_ecm`.`creative`.`asset_budget_allocation` ADD CONSTRAINT `fk_creative_asset_budget_allocation_creative_asset_id` FOREIGN KEY (`creative_asset_id`) REFERENCES `advertising_ecm`.`creative`.`creative_asset`(`creative_asset_id`);
ALTER TABLE `advertising_ecm`.`creative`.`review_cycle` ADD CONSTRAINT `fk_creative_review_cycle_creative_asset_id` FOREIGN KEY (`creative_asset_id`) REFERENCES `advertising_ecm`.`creative`.`creative_asset`(`creative_asset_id`);
ALTER TABLE `advertising_ecm`.`creative`.`review_cycle` ADD CONSTRAINT `fk_creative_review_cycle_review_group_id` FOREIGN KEY (`review_group_id`) REFERENCES `advertising_ecm`.`creative`.`review_group`(`review_group_id`);
ALTER TABLE `advertising_ecm`.`creative`.`review_cycle` ADD CONSTRAINT `fk_creative_review_cycle_previous_review_cycle_id` FOREIGN KEY (`previous_review_cycle_id`) REFERENCES `advertising_ecm`.`creative`.`review_cycle`(`review_cycle_id`);

-- ========= TAGS =========
ALTER SCHEMA `advertising_ecm`.`creative` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `advertising_ecm`.`creative` SET TAGS ('dbx_domain' = 'creative');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` SET TAGS ('dbx_subdomain' = 'campaign_planning');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `creative_brief_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Brief ID');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `client_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brand ID');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `positioning_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Positioning Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `project_brief_id` SET TAGS ('dbx_business_glossary_term' = 'Project Brief Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Requested By Worker Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `persona_id` SET TAGS ('dbx_business_glossary_term' = 'Target Persona Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Brief Approved Date');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `art_director_assigned` SET TAGS ('dbx_business_glossary_term' = 'Art Director Assigned');
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ALTER COLUMN `brand_guidelines_reference` SET TAGS ('dbx_business_glossary_term' = 'Brand Guidelines Reference');
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
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset ID');
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Segment Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ALTER COLUMN `parent_asset_creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Asset ID');
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ALTER COLUMN `spec_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Spec Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ALTER COLUMN `task_id` SET TAGS ('dbx_business_glossary_term' = 'Task Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ALTER COLUMN `archived_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Archived Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ALTER COLUMN `asset_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Name');
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Type');
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ALTER COLUMN `brand_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Brand Compliance Status');
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ALTER COLUMN `brand_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review|not_applicable');
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ALTER COLUMN `campaign_theme` SET TAGS ('dbx_business_glossary_term' = 'Campaign Theme');
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ALTER COLUMN `channel_suitability` SET TAGS ('dbx_business_glossary_term' = 'Channel Suitability');
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ALTER COLUMN `client_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brand ID');
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ALTER COLUMN `codec` SET TAGS ('dbx_business_glossary_term' = 'Codec');
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ALTER COLUMN `color_profile` SET TAGS ('dbx_business_glossary_term' = 'Color Profile');
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ALTER COLUMN `copyright_holder` SET TAGS ('dbx_business_glossary_term' = 'Copyright Holder');
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ALTER COLUMN `copyright_holder` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ALTER COLUMN `creative_asset_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Description');
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ALTER COLUMN `dam_asset_ref` SET TAGS ('dbx_business_glossary_term' = 'Digital Asset Management (DAM) Asset ID');
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Duration (Seconds)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size (Bytes)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ALTER COLUMN `file_storage_path` SET TAGS ('dbx_business_glossary_term' = 'File Storage Path');
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ALTER COLUMN `file_storage_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ALTER COLUMN `geographic_market` SET TAGS ('dbx_business_glossary_term' = 'Geographic Market');
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ALTER COLUMN `is_master_asset` SET TAGS ('dbx_business_glossary_term' = 'Is Master Asset');
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'License Type');
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Stage');
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_value_regex' = 'wip|in_review|approved|published|archived|expired');
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ALTER COLUMN `mood_tags` SET TAGS ('dbx_business_glossary_term' = 'Mood Tags');
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ALTER COLUMN `resolution` SET TAGS ('dbx_business_glossary_term' = 'Resolution');
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Rights Clearance Status');
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|restricted|expired');
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ALTER COLUMN `rights_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Rights Expiry Date');
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ALTER COLUMN `subject_tags` SET TAGS ('dbx_business_glossary_term' = 'Subject Tags');
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ALTER COLUMN `thumbnail_url` SET TAGS ('dbx_business_glossary_term' = 'Thumbnail URL');
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Version Identifier (ID)');
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Author Worker Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ALTER COLUMN `creative_deliverable_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Deliverable Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ALTER COLUMN `spec_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Spec Id (Foreign Key)');
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
ALTER TABLE `advertising_ecm`.`creative`.`concept` SET TAGS ('dbx_subdomain' = 'campaign_planning');
ALTER TABLE `advertising_ecm`.`creative`.`concept` ALTER COLUMN `concept_id` SET TAGS ('dbx_business_glossary_term' = 'Concept ID');
ALTER TABLE `advertising_ecm`.`creative`.`concept` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Copywriter ID');
ALTER TABLE `advertising_ecm`.`creative`.`concept` ALTER COLUMN `concept_created_by_user_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `advertising_ecm`.`creative`.`concept` ALTER COLUMN `concept_modified_by_user_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `advertising_ecm`.`creative`.`concept` ALTER COLUMN `concept_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Lead ID');
ALTER TABLE `advertising_ecm`.`creative`.`concept` ALTER COLUMN `creative_brief_id` SET TAGS ('dbx_business_glossary_term' = 'Brief ID');
ALTER TABLE `advertising_ecm`.`creative`.`concept` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`concept` ALTER COLUMN `parent_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Concept ID');
ALTER TABLE `advertising_ecm`.`creative`.`concept` ALTER COLUMN `positioning_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Positioning Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`concept` ALTER COLUMN `persona_id` SET TAGS ('dbx_business_glossary_term' = 'Target Persona Id (Foreign Key)');
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
ALTER TABLE `advertising_ecm`.`creative`.`production_job` SET TAGS ('dbx_subdomain' = 'production_operations');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `production_job_id` SET TAGS ('dbx_business_glossary_term' = 'Production Job Identifier (ID)');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `concept_id` SET TAGS ('dbx_business_glossary_term' = 'Concept Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `creative_brief_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Brief Identifier (ID)');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Producer Identifier (ID)');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `project_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Project Budget Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `work_package_id` SET TAGS ('dbx_business_glossary_term' = 'Work Package Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ALTER COLUMN `workfront_project_initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Workfront Project Identifier (ID)');
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
ALTER TABLE `advertising_ecm`.`creative`.`proof` SET TAGS ('dbx_subdomain' = 'review_workflow');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `proof_id` SET TAGS ('dbx_business_glossary_term' = 'Proof Identifier (ID)');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `approval_workflow_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Version Identifier (ID)');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `production_job_id` SET TAGS ('dbx_business_glossary_term' = 'Production Job Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `project_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Project Milestone Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `task_id` SET TAGS ('dbx_business_glossary_term' = 'Task Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `work_package_id` SET TAGS ('dbx_business_glossary_term' = 'Work Package Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Submitter User Identifier (ID)');
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
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Hours');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `stage` SET TAGS ('dbx_business_glossary_term' = 'Proof Stage');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `stage` SET TAGS ('dbx_value_regex' = 'internal|client_round_1|client_round_2|client_round_3|final');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `turnaround_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Time (Hours)');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `url` SET TAGS ('dbx_business_glossary_term' = 'Proof Uniform Resource Locator (URL)');
ALTER TABLE `advertising_ecm`.`creative`.`proof` ALTER COLUMN `url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `advertising_ecm`.`creative`.`proof_comment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`creative`.`proof_comment` SET TAGS ('dbx_subdomain' = 'review_workflow');
ALTER TABLE `advertising_ecm`.`creative`.`proof_comment` ALTER COLUMN `proof_comment_id` SET TAGS ('dbx_business_glossary_term' = 'Proof Comment Identifier (ID)');
ALTER TABLE `advertising_ecm`.`creative`.`proof_comment` ALTER COLUMN `parent_comment_proof_comment_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Comment Identifier (ID)');
ALTER TABLE `advertising_ecm`.`creative`.`proof_comment` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Commenter Identifier (ID)');
ALTER TABLE `advertising_ecm`.`creative`.`proof_comment` ALTER COLUMN `proof_id` SET TAGS ('dbx_business_glossary_term' = 'Proof Identifier (ID)');
ALTER TABLE `advertising_ecm`.`creative`.`proof_comment` ALTER COLUMN `review_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle Identifier (ID)');
ALTER TABLE `advertising_ecm`.`creative`.`proof_comment` ALTER COLUMN `tertiary_proof_deleted_by_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Deleted By User Identifier (ID)');
ALTER TABLE `advertising_ecm`.`creative`.`proof_comment` ALTER COLUMN `annotation_page_number` SET TAGS ('dbx_business_glossary_term' = 'Annotation Page Number');
ALTER TABLE `advertising_ecm`.`creative`.`proof_comment` ALTER COLUMN `annotation_timestamp_seconds` SET TAGS ('dbx_business_glossary_term' = 'Annotation Video Timestamp (Seconds)');
ALTER TABLE `advertising_ecm`.`creative`.`proof_comment` ALTER COLUMN `annotation_x_coordinate` SET TAGS ('dbx_business_glossary_term' = 'Annotation X-Axis Coordinate');
ALTER TABLE `advertising_ecm`.`creative`.`proof_comment` ALTER COLUMN `annotation_y_coordinate` SET TAGS ('dbx_business_glossary_term' = 'Annotation Y-Axis Coordinate');
ALTER TABLE `advertising_ecm`.`creative`.`proof_comment` ALTER COLUMN `attachment_file_name` SET TAGS ('dbx_business_glossary_term' = 'Attachment File Name');
ALTER TABLE `advertising_ecm`.`creative`.`proof_comment` ALTER COLUMN `attachment_url` SET TAGS ('dbx_business_glossary_term' = 'Comment Attachment Uniform Resource Locator (URL)');
ALTER TABLE `advertising_ecm`.`creative`.`proof_comment` ALTER COLUMN `comment_priority` SET TAGS ('dbx_business_glossary_term' = 'Comment Priority Level');
ALTER TABLE `advertising_ecm`.`creative`.`proof_comment` ALTER COLUMN `comment_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `advertising_ecm`.`creative`.`proof_comment` ALTER COLUMN `comment_source` SET TAGS ('dbx_business_glossary_term' = 'Comment Source Channel');
ALTER TABLE `advertising_ecm`.`creative`.`proof_comment` ALTER COLUMN `comment_source` SET TAGS ('dbx_value_regex' = 'web_app|mobile_app|email|api|integration');
ALTER TABLE `advertising_ecm`.`creative`.`proof_comment` ALTER COLUMN `comment_text` SET TAGS ('dbx_business_glossary_term' = 'Comment Text Content');
ALTER TABLE `advertising_ecm`.`creative`.`proof_comment` ALTER COLUMN `comment_type` SET TAGS ('dbx_business_glossary_term' = 'Comment Type Classification');
ALTER TABLE `advertising_ecm`.`creative`.`proof_comment` ALTER COLUMN `commenter_name` SET TAGS ('dbx_business_glossary_term' = 'Commenter Full Name');
ALTER TABLE `advertising_ecm`.`creative`.`proof_comment` ALTER COLUMN `commenter_role` SET TAGS ('dbx_business_glossary_term' = 'Commenter Role');
ALTER TABLE `advertising_ecm`.`creative`.`proof_comment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Comment Created Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`proof_comment` ALTER COLUMN `deleted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deletion Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`proof_comment` ALTER COLUMN `is_client_visible` SET TAGS ('dbx_business_glossary_term' = 'Client Visibility Flag');
ALTER TABLE `advertising_ecm`.`creative`.`proof_comment` ALTER COLUMN `is_deleted` SET TAGS ('dbx_business_glossary_term' = 'Deletion Flag');
ALTER TABLE `advertising_ecm`.`creative`.`proof_comment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Comment Modified Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`proof_comment` ALTER COLUMN `requires_client_approval` SET TAGS ('dbx_business_glossary_term' = 'Client Approval Required Flag');
ALTER TABLE `advertising_ecm`.`creative`.`proof_comment` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `advertising_ecm`.`creative`.`proof_comment` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Comment Resolution Status');
ALTER TABLE `advertising_ecm`.`creative`.`proof_comment` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|resolved|rejected|deferred');
ALTER TABLE `advertising_ecm`.`creative`.`proof_comment` ALTER COLUMN `resolved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`spec` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `advertising_ecm`.`creative`.`spec` SET TAGS ('dbx_subdomain' = 'production_operations');
ALTER TABLE `advertising_ecm`.`creative`.`spec` ALTER COLUMN `spec_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Specification ID');
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
ALTER TABLE `advertising_ecm`.`creative`.`brand_guideline` SET TAGS ('dbx_subdomain' = 'production_operations');
ALTER TABLE `advertising_ecm`.`creative`.`brand_guideline` ALTER COLUMN `brand_guideline_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Brand Guideline Identifier (ID)');
ALTER TABLE `advertising_ecm`.`creative`.`brand_guideline` ALTER COLUMN `client_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brand Identifier (ID)');
ALTER TABLE `advertising_ecm`.`creative`.`brand_guideline` ALTER COLUMN `guideline_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Guideline Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`brand_guideline` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Maintained By Worker Id (Foreign Key)');
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
ALTER TABLE `advertising_ecm`.`creative`.`brand_guideline` ALTER COLUMN `secondary_color_palette` SET TAGS ('dbx_business_glossary_term' = 'Secondary Color Palette');
ALTER TABLE `advertising_ecm`.`creative`.`brand_guideline` ALTER COLUMN `secondary_typeface` SET TAGS ('dbx_business_glossary_term' = 'Secondary Typeface');
ALTER TABLE `advertising_ecm`.`creative`.`brand_guideline` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `advertising_ecm`.`creative`.`brand_guideline` ALTER COLUMN `tone_of_voice` SET TAGS ('dbx_business_glossary_term' = 'Tone of Voice');
ALTER TABLE `advertising_ecm`.`creative`.`brand_guideline` ALTER COLUMN `typography_rules` SET TAGS ('dbx_business_glossary_term' = 'Typography Rules');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` SET TAGS ('dbx_subdomain' = 'review_workflow');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ALTER COLUMN `creative_compliance_check_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Compliance Check Identifier (ID)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ALTER COLUMN `approval_workflow_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ALTER COLUMN `brand_guideline_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Brand Guideline Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ALTER COLUMN `change_request_id` SET TAGS ('dbx_business_glossary_term' = 'Change Request Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset Identifier (ID)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ALTER COLUMN `creative_deliverable_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Deliverable Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ALTER COLUMN `previous_check_creative_compliance_check_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Compliance Check Identifier (ID)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ALTER COLUMN `proof_id` SET TAGS ('dbx_business_glossary_term' = 'Proof Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Identifier (ID)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ALTER COLUMN `brand_compliance_pass` SET TAGS ('dbx_business_glossary_term' = 'Brand Compliance Pass Flag');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ALTER COLUMN `check_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Date');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ALTER COLUMN `check_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Check Duration in Minutes');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Number');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ALTER COLUMN `check_number` SET TAGS ('dbx_value_regex' = '^CC-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ALTER COLUMN `check_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Status');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ALTER COLUMN `check_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|approved|rejected|remediation_required');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ALTER COLUMN `check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ALTER COLUMN `check_type` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Type');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ALTER COLUMN `check_type` SET TAGS ('dbx_value_regex' = 'brand_compliance|legal_regulatory|platform_policy|full_review');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ALTER COLUMN `legal_compliance_pass` SET TAGS ('dbx_business_glossary_term' = 'Legal Compliance Pass Flag');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Notes');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Outcome');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass|not_applicable');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ALTER COLUMN `platform_policy_pass` SET TAGS ('dbx_business_glossary_term' = 'Platform Policy Compliance Pass Flag');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ALTER COLUMN `platform_target` SET TAGS ('dbx_business_glossary_term' = 'Platform Target');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ALTER COLUMN `recheck_required` SET TAGS ('dbx_business_glossary_term' = 'Recheck Required Flag');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework Applied');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ALTER COLUMN `remediation_actions` SET TAGS ('dbx_business_glossary_term' = 'Remediation Actions Required');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ALTER COLUMN `remediation_deadline` SET TAGS ('dbx_business_glossary_term' = 'Remediation Deadline Date');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ALTER COLUMN `remediation_required` SET TAGS ('dbx_business_glossary_term' = 'Remediation Required Flag');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Full Name');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ALTER COLUMN `reviewer_role` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Role');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ALTER COLUMN `reviewer_role` SET TAGS ('dbx_value_regex' = 'brand_manager|legal_counsel|compliance_officer|creative_director|account_manager|platform_specialist');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ALTER COLUMN `sign_off_by` SET TAGS ('dbx_business_glossary_term' = 'Sign-Off Approver Name');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ALTER COLUMN `sign_off_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ALTER COLUMN `sign_off_date` SET TAGS ('dbx_business_glossary_term' = 'Sign-Off Date');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ALTER COLUMN `sign_off_status` SET TAGS ('dbx_business_glossary_term' = 'Sign-Off Status');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ALTER COLUMN `sign_off_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|rejected');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ALTER COLUMN `violation_count` SET TAGS ('dbx_business_glossary_term' = 'Violation Count');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ALTER COLUMN `violation_severity` SET TAGS ('dbx_business_glossary_term' = 'Violation Severity Level');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ALTER COLUMN `violation_severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|none');
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ALTER COLUMN `violations_identified` SET TAGS ('dbx_business_glossary_term' = 'Violations Identified');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `rights_clearance_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Clearance Identifier (ID)');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `adaptation_id` SET TAGS ('dbx_business_glossary_term' = 'Adaptation Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Worker Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset Identifier (ID)');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `stock_media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Media Asset Identifier (ID)');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `clearance_documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Clearance Documentation Uniform Resource Locator (URL)');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `clearance_documentation_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `clearance_number` SET TAGS ('dbx_business_glossary_term' = 'Rights Clearance Number');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `clearance_number` SET TAGS ('dbx_value_regex' = '^RC-[0-9]{8}$');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Rights Clearance Status');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `clearance_status` SET TAGS ('dbx_value_regex' = 'pending|in_review|approved|rejected|expired|renewed');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `competitive_category_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Competitive Category Restrictions');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `legal_review_notes` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Notes');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `legal_review_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `license_end_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiration End Date');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `license_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'License Fee Amount');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `license_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `license_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'License Fee Currency Code');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `license_fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `license_start_date` SET TAGS ('dbx_business_glossary_term' = 'License Effective Start Date');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `licensor_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Licensor Contact Email Address');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `licensor_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `licensor_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `licensor_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `licensor_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Licensor Contact Phone Number');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `licensor_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `licensor_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `licensor_name` SET TAGS ('dbx_business_glossary_term' = 'Licensor Name');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `licensor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `music_artist` SET TAGS ('dbx_business_glossary_term' = 'Music Artist Name');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `music_isrc_code` SET TAGS ('dbx_business_glossary_term' = 'International Standard Recording Code (ISRC)');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `music_isrc_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[A-Z0-9]{3}[0-9]{7}$');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `music_title` SET TAGS ('dbx_business_glossary_term' = 'Music Title');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_30|net_60|net_90|due_on_receipt|advance|milestone_based');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `permitted_channels` SET TAGS ('dbx_business_glossary_term' = 'Permitted Media Channels');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `permitted_territories` SET TAGS ('dbx_business_glossary_term' = 'Permitted Geographic Territories');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `renewal_notification_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notification Days');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `renewal_option_available` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Available Flag');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `rights_type` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Rights Type');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `risk_assessment` SET TAGS ('dbx_business_glossary_term' = 'Rights Risk Assessment Level');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `risk_assessment` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `royalty_structure` SET TAGS ('dbx_business_glossary_term' = 'Royalty Structure');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `royalty_structure` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `stock_media_provider` SET TAGS ('dbx_business_glossary_term' = 'Stock Media Provider');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `stock_media_provider` SET TAGS ('dbx_value_regex' = 'getty_images|shutterstock|adobe_stock|istock|pond5|other');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `talent_name` SET TAGS ('dbx_business_glossary_term' = 'Talent Name');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `talent_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `talent_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `talent_union_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Talent Union Affiliation');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `talent_union_affiliation` SET TAGS ('dbx_value_regex' = 'sag_aftra|non_union|afm|equity|other');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `usage_limitations` SET TAGS ('dbx_business_glossary_term' = 'Usage Limitations and Restrictions');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `usage_report_frequency` SET TAGS ('dbx_business_glossary_term' = 'Usage Report Frequency');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `usage_report_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually|campaign_end|not_required');
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ALTER COLUMN `usage_tracking_required` SET TAGS ('dbx_business_glossary_term' = 'Usage Tracking Required Flag');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` SET TAGS ('dbx_subdomain' = 'campaign_planning');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `creative_deliverable_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Deliverable ID');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser ID');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `approval_workflow_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Art Director Worker Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Segment Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `contract_deliverable_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Deliverable Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `creative_brief_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Brief ID');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `media_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Media Insertion Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `production_job_id` SET TAGS ('dbx_business_glossary_term' = 'Production Job Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `project_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Project Budget Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `project_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Project Milestone Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `spec_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Spec Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
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
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `adaptation_id` SET TAGS ('dbx_business_glossary_term' = 'Adaptation Identifier (ID)');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `adaptation_modified_by_user_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `adaptation_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Segment Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Master Asset Identifier (ID)');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `creative_deliverable_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Deliverable Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `spec_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Spec Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Translator or Localizer Vendor Identifier (ID)');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `accessibility_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Compliance Flag');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `adaptation_name` SET TAGS ('dbx_business_glossary_term' = 'Adaptation Name');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `adaptation_type` SET TAGS ('dbx_business_glossary_term' = 'Adaptation Type');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `adaptation_type` SET TAGS ('dbx_value_regex' = 'resize|reformat|localization|language_dub|market_variant|accessibility_variant');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|rejected|revision_required|final');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `brand_compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Brand Compliance Score');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `color_space` SET TAGS ('dbx_business_glossary_term' = 'Color Space');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `color_space` SET TAGS ('dbx_value_regex' = 'RGB|CMYK|sRGB|Adobe_RGB|Rec_709|Rec_2020');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Adaptation Completion Date');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `cultural_review_status` SET TAGS ('dbx_business_glossary_term' = 'Cultural Review Status');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `cultural_review_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_review|approved|rejected|conditional');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `dam_asset_url` SET TAGS ('dbx_business_glossary_term' = 'Digital Asset Management (DAM) Asset Uniform Resource Locator (URL)');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Duration in Seconds');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `file_size_kb` SET TAGS ('dbx_business_glossary_term' = 'File Size in Kilobytes (KB)');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Adaptation Notes');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `rationale` SET TAGS ('dbx_business_glossary_term' = 'Adaptation Rationale');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `regulatory_review_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Review Status');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `regulatory_review_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_review|approved|rejected|conditional');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `resolution` SET TAGS ('dbx_business_glossary_term' = 'Resolution');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `source_language` SET TAGS ('dbx_business_glossary_term' = 'Source Language Code');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `source_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Adaptation Start Date');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `target_audience_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Segment');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `target_channel` SET TAGS ('dbx_business_glossary_term' = 'Target Channel');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `target_language` SET TAGS ('dbx_business_glossary_term' = 'Target Language Code');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `target_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `target_locale` SET TAGS ('dbx_business_glossary_term' = 'Target Locale Code');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `target_locale` SET TAGS ('dbx_value_regex' = '^[a-z]{2}_[A-Z]{2}$');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `target_market` SET TAGS ('dbx_business_glossary_term' = 'Target Market Code');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `target_market` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` SET TAGS ('dbx_subdomain' = 'campaign_planning');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `creative_request_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Request ID');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser ID');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `change_request_id` SET TAGS ('dbx_business_glossary_term' = 'Change Request Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `client_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brand ID');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `media_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Media Insertion Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `client_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Requestor Contact ID');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `production_job_id` SET TAGS ('dbx_business_glossary_term' = 'Production Job ID');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Team Member ID');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `actual_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `actual_effort_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Effort Hours');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `assigned_studio` SET TAGS ('dbx_business_glossary_term' = 'Assigned Studio');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `assigned_team_member_name` SET TAGS ('dbx_business_glossary_term' = 'Assigned Team Member Name');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `assigned_team_member_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `assigned_team_member_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `business_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `change_description` SET TAGS ('dbx_business_glossary_term' = 'Change Description');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `estimated_effort_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Effort Hours');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `impacted_asset_count` SET TAGS ('dbx_business_glossary_term' = 'Impacted Asset Count');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `impacted_asset_list` SET TAGS ('dbx_business_glossary_term' = 'Impacted Asset List');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `legal_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Required Flag');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `market_code` SET TAGS ('dbx_business_glossary_term' = 'Market Code');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `market_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'standard|high|urgent|emergency');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `regulatory_compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Notes');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Creative Request Number');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `request_number` SET TAGS ('dbx_value_regex' = '^CR-[0-9]{6,10}$');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Request Status');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `request_type` SET TAGS ('dbx_business_glossary_term' = 'Request Type');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `requestor_email` SET TAGS ('dbx_business_glossary_term' = 'Requestor Email Address');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `requestor_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `requestor_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `requestor_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `requestor_name` SET TAGS ('dbx_business_glossary_term' = 'Requestor Name');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `requestor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `requestor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `sla_deadline_timestamp` SET TAGS ('dbx_business_glossary_term' = 'SLA (Service Level Agreement) Deadline Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `sla_met_flag` SET TAGS ('dbx_business_glossary_term' = 'SLA (Service Level Agreement) Met Flag');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Submitted Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ALTER COLUMN `workfront_request_ref` SET TAGS ('dbx_business_glossary_term' = 'Workfront Request ID');
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ALTER COLUMN `asset_usage_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset Usage ID');
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ALTER COLUMN `ad_id` SET TAGS ('dbx_business_glossary_term' = 'Ad ID');
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ALTER COLUMN `buy_id` SET TAGS ('dbx_business_glossary_term' = 'Media Buy Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset ID');
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ALTER COLUMN `flight_id` SET TAGS ('dbx_business_glossary_term' = 'Flight ID');
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ALTER COLUMN `line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Line Item ID');
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ALTER COLUMN `media_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Media Insertion Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ALTER COLUMN `media_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Media Placement Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ALTER COLUMN `spec_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Spec Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ALTER COLUMN `trafficking_order_id` SET TAGS ('dbx_business_glossary_term' = 'Trafficking Order ID');
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ALTER COLUMN `ad_server_ref` SET TAGS ('dbx_business_glossary_term' = 'Ad Server ID');
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ALTER COLUMN `asset_version` SET TAGS ('dbx_business_glossary_term' = 'Asset Version');
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Media Channel');
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ALTER COLUMN `click_count` SET TAGS ('dbx_business_glossary_term' = 'Click Count');
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ALTER COLUMN `creative_rotation_weight` SET TAGS ('dbx_business_glossary_term' = 'Creative Rotation Weight');
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ALTER COLUMN `ctr` SET TAGS ('dbx_business_glossary_term' = 'Click-Through Rate (CTR)');
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Duration (Seconds)');
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ALTER COLUMN `file_size_kb` SET TAGS ('dbx_business_glossary_term' = 'File Size (KB)');
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ALTER COLUMN `impression_count` SET TAGS ('dbx_business_glossary_term' = 'Impression Count');
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ALTER COLUMN `is_rights_compliant` SET TAGS ('dbx_business_glossary_term' = 'Rights Compliance Flag');
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ALTER COLUMN `market` SET TAGS ('dbx_business_glossary_term' = 'Market');
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Platform Name');
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ALTER COLUMN `rights_end_date` SET TAGS ('dbx_business_glossary_term' = 'Rights End Date');
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ALTER COLUMN `rights_start_date` SET TAGS ('dbx_business_glossary_term' = 'Rights Start Date');
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ALTER COLUMN `rights_territory` SET TAGS ('dbx_business_glossary_term' = 'Rights Territory');
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ALTER COLUMN `trafficked_by` SET TAGS ('dbx_business_glossary_term' = 'Trafficked By');
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ALTER COLUMN `trafficking_date` SET TAGS ('dbx_business_glossary_term' = 'Trafficking Date');
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ALTER COLUMN `usage_end_date` SET TAGS ('dbx_business_glossary_term' = 'Usage End Date');
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ALTER COLUMN `usage_notes` SET TAGS ('dbx_business_glossary_term' = 'Usage Notes');
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ALTER COLUMN `usage_start_date` SET TAGS ('dbx_business_glossary_term' = 'Usage Start Date');
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ALTER COLUMN `usage_status` SET TAGS ('dbx_business_glossary_term' = 'Usage Status');
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ALTER COLUMN `usage_status` SET TAGS ('dbx_value_regex' = 'active|paused|completed|cancelled|expired');
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ALTER COLUMN `usage_type` SET TAGS ('dbx_business_glossary_term' = 'Usage Type');
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ALTER COLUMN `video_completion_rate` SET TAGS ('dbx_business_glossary_term' = 'Video Completion Rate (VTR)');
ALTER TABLE `advertising_ecm`.`creative`.`proof_review` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `advertising_ecm`.`creative`.`proof_review` SET TAGS ('dbx_subdomain' = 'review_workflow');
ALTER TABLE `advertising_ecm`.`creative`.`proof_review` SET TAGS ('dbx_association_edges' = 'client.client_contact,creative.proof');
ALTER TABLE `advertising_ecm`.`creative`.`proof_review` ALTER COLUMN `proof_review_id` SET TAGS ('dbx_business_glossary_term' = 'Proof Review ID');
ALTER TABLE `advertising_ecm`.`creative`.`proof_review` ALTER COLUMN `client_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Client Contact ID');
ALTER TABLE `advertising_ecm`.`creative`.`proof_review` ALTER COLUMN `contact_client_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Proof Review - Client Contact Id');
ALTER TABLE `advertising_ecm`.`creative`.`proof_review` ALTER COLUMN `proof_id` SET TAGS ('dbx_business_glossary_term' = 'Proof ID');
ALTER TABLE `advertising_ecm`.`creative`.`proof_review` ALTER COLUMN `assigned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assigned Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`proof_review` ALTER COLUMN `comments_count` SET TAGS ('dbx_business_glossary_term' = 'Comments Count');
ALTER TABLE `advertising_ecm`.`creative`.`proof_review` ALTER COLUMN `decision` SET TAGS ('dbx_business_glossary_term' = 'Review Decision');
ALTER TABLE `advertising_ecm`.`creative`.`proof_review` ALTER COLUMN `decision_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Decision Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`proof_review` ALTER COLUMN `is_required_reviewer` SET TAGS ('dbx_business_glossary_term' = 'Is Required Reviewer');
ALTER TABLE `advertising_ecm`.`creative`.`proof_review` ALTER COLUMN `review_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Review Duration Hours');
ALTER TABLE `advertising_ecm`.`creative`.`proof_review` ALTER COLUMN `review_round` SET TAGS ('dbx_business_glossary_term' = 'Review Round');
ALTER TABLE `advertising_ecm`.`creative`.`proof_review` ALTER COLUMN `reviewer_role` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Role');
ALTER TABLE `advertising_ecm`.`creative`.`asset_budget_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `advertising_ecm`.`creative`.`asset_budget_allocation` SET TAGS ('dbx_subdomain' = 'campaign_planning');
ALTER TABLE `advertising_ecm`.`creative`.`asset_budget_allocation` SET TAGS ('dbx_association_edges' = 'creative.creative_asset,finance.budget_line');
ALTER TABLE `advertising_ecm`.`creative`.`asset_budget_allocation` ALTER COLUMN `asset_budget_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Budget Allocation ID');
ALTER TABLE `advertising_ecm`.`creative`.`asset_budget_allocation` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Budget Allocation - Budget Line Id');
ALTER TABLE `advertising_ecm`.`creative`.`asset_budget_allocation` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Budget Allocation - Creative Asset Id');
ALTER TABLE `advertising_ecm`.`creative`.`asset_budget_allocation` ALTER COLUMN `actual_spend` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend');
ALTER TABLE `advertising_ecm`.`creative`.`asset_budget_allocation` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount');
ALTER TABLE `advertising_ecm`.`creative`.`asset_budget_allocation` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `advertising_ecm`.`creative`.`asset_budget_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`asset_budget_allocation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`creative`.`asset_budget_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `advertising_ecm`.`creative`.`asset_budget_allocation` ALTER COLUMN `usage_end_date` SET TAGS ('dbx_business_glossary_term' = 'Usage End Date');
ALTER TABLE `advertising_ecm`.`creative`.`asset_budget_allocation` ALTER COLUMN `usage_start_date` SET TAGS ('dbx_business_glossary_term' = 'Usage Start Date');
ALTER TABLE `advertising_ecm`.`creative`.`asset_budget_allocation` ALTER COLUMN `usage_type` SET TAGS ('dbx_business_glossary_term' = 'Usage Type');
ALTER TABLE `advertising_ecm`.`creative`.`asset_budget_allocation` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `advertising_ecm`.`creative`.`review_cycle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`creative`.`review_cycle` SET TAGS ('dbx_subdomain' = 'review_workflow');
ALTER TABLE `advertising_ecm`.`creative`.`review_cycle` ALTER COLUMN `review_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle Identifier');
ALTER TABLE `advertising_ecm`.`creative`.`review_cycle` ALTER COLUMN `previous_review_cycle_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`creative`.`review_group` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`creative`.`review_group` SET TAGS ('dbx_subdomain' = 'review_workflow');
ALTER TABLE `advertising_ecm`.`creative`.`review_group` ALTER COLUMN `review_group_id` SET TAGS ('dbx_business_glossary_term' = 'Review Group Identifier');
ALTER TABLE `advertising_ecm`.`creative`.`review_group` ALTER COLUMN `notification_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`creative`.`review_group` ALTER COLUMN `notification_email` SET TAGS ('dbx_pii_email' = 'true');
