-- Schema for Domain: brand | Business: Advertising | Version: v1_ecm
-- Generated on: 2026-05-08 02:28:04

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `advertising_ecm`.`brand` COMMENT 'Manages brand strategy, positioning, and identity assets for clients. Owns brand guidelines, messaging frameworks, competitive SOV tracking, brand health metrics (NPS, awareness, sentiment), and public relations communications. Supports Brand Strategy and Positioning and Public Relations and Communications processes. Integrates with Nielsen Ad Intel for competitive monitoring.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `advertising_ecm`.`brand`.`brand_profile` (
    `brand_profile_id` BIGINT COMMENT 'Unique surrogate identifier for the brand profile record. Serves as the primary key and system-of-record anchor for all brand-level entities within the brand domain.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Brand profiles maintain approved media supplier lists for brand safety compliance and media buying operations. Critical for vendor approval workflows and ensuring brand-safe media placements across ca',
    `active_markets` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes representing the markets where the brand is currently active and running campaigns. Supports geo-targeting in The Trade Desk, media planning in Mediaocean Prisma, and multi-market reporting.',
    `agency_onboard_date` DATE COMMENT 'Date on which the brand was formally onboarded to the agency and the brand profile record was activated in the system of record. Marks the start of the agency-client brand management relationship.',
    `asa_compliant` BOOLEAN COMMENT 'Indicates whether the brands advertising materials and practices are compliant with Advertising Standards Authority (ASA) regulations. Required for UK and international market campaign approvals.',
    `brand_archetype` STRING COMMENT 'Jungian brand archetype classification (e.g., Hero, Caregiver, Explorer, Sage, Outlaw, Creator, Ruler, Magician, Innocent, Everyman, Lover, Jester) that defines the brands personality framework. Anchors tone of voice, creative direction, and brand strategy positioning. [ENUM-REF-CANDIDATE: Hero|Caregiver|Explorer|Sage|Outlaw|Creator|Ruler|Magician|Innocent|Everyman|Lover|Jester — promote to reference product]',
    `brand_awareness_baseline_pct` DECIMAL(18,2) COMMENT 'Baseline unaided brand awareness percentage among the target audience at the time of agency engagement or last formal brand health study. Used as the benchmark for measuring awareness lift from campaign activity. Range: 0.00 to 100.00.',
    `brand_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the brand across agency systems, including Mediaocean Prisma and Google Campaign Manager 360. Used as the business key for cross-system reconciliation and reporting.. Valid values are `^[A-Z0-9_-]{2,30}$`',
    `brand_guidelines_url` STRING COMMENT 'URL reference to the master brand guidelines document stored in Workfront DAM. Serves as the authoritative source for all brand identity standards including logo usage, color palette, typography, and tone of voice rules.. Valid values are `^https?://.+`',
    `brand_name` STRING COMMENT 'The primary commercial name of the brand as it appears in market-facing communications, campaign briefs, and agency deliverables. Serves as the human-readable identity label for the brand profile.',
    `brand_safety_category` STRING COMMENT 'Classification of the brands content adjacency sensitivity level for programmatic media buying. Determines the brand safety targeting parameters applied in The Trade Desk and Google Campaign Manager 360 to prevent ad placement near inappropriate content.. Valid values are `standard|sensitive|restricted|custom`',
    `brand_status` STRING COMMENT 'Current operational lifecycle status of the brand profile record within the agencys system of record. Controls whether the brand is eligible for new campaign assignments, media planning, and creative production activities.. Valid values are `active|inactive|suspended|archived`',
    `brand_tier` STRING COMMENT 'Market positioning tier of the brand reflecting its price-point and competitive positioning strategy. Informs media planning, creative tone, and channel selection within campaign strategy and planning processes.. Valid values are `premium|mid-market|value|challenger|luxury`',
    `ccpa_opt_out` BOOLEAN COMMENT 'Indicates whether the brand has opted out of the sale of consumer personal information under the California Consumer Privacy Act (CCPA). Restricts certain data sharing and targeting activities for California audiences.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the brand profile record was first created in the system. Provides the audit trail creation marker for data lineage, compliance reporting, and record lifecycle management.',
    `easa_compliant` BOOLEAN COMMENT 'Indicates whether the brands advertising practices comply with European Advertising Standards Alliance (EASA) cross-border complaint handling and self-regulatory standards. Required for European market campaign activation.',
    `ftc_compliant` BOOLEAN COMMENT 'Indicates whether the brands advertising disclosures, endorsements, and claims comply with Federal Trade Commission (FTC) Advertising Practices Division guidelines. Required for US market campaign activation.',
    `gdpr_data_use_consent` BOOLEAN COMMENT 'Indicates whether the brand has provided consent for audience data usage in programmatic targeting and analytics under GDPR Article 6 lawful basis requirements. Governs data activation in The Trade Desk and DMP/CDP integrations.',
    `industry_vertical` STRING COMMENT 'The primary industry sector classification of the brand per IAB Content Taxonomy (e.g., Automotive, Consumer Packaged Goods, Financial Services, Retail, Technology). Used for competitive conflict detection, audience segmentation, and Nielsen Ad Intel competitive monitoring alignment. [ENUM-REF-CANDIDATE: Automotive|Consumer Packaged Goods|Financial Services|Retail|Technology|Healthcare|Entertainment|Travel|Telecommunications|Food & Beverage — promote to reference product]',
    `launch_date` DATE COMMENT 'The date on which the brand was officially launched in its primary market. Used for brand age calculations, lifecycle stage validation, and historical competitive Share of Voice (SOV) analysis via Nielsen Ad Intel.',
    `lifecycle_stage` STRING COMMENT 'Current stage in the brands commercial lifecycle. Drives investment strategy, media mix recommendations, and KPI benchmarking. Aligned with brand health monitoring and Nielsen Ad Intel competitive tracking.. Valid values are `emerging|established|mature|declining`',
    `local_brand_name` STRING COMMENT 'Market-specific or locale-specific variant of the brand name used in regional campaigns, translations, or co-branded executions. Supports multi-market brand management and localization workflows.',
    `logo_asset_url` STRING COMMENT 'URL reference to the master brand logo file stored in the Workfront Digital Asset Management (DAM) system. Provides a canonical pointer to the approved logo for use in campaign trafficking, ad serving via Google Campaign Manager 360, and creative production.. Valid values are `^https?://.+`',
    `market_tier` STRING COMMENT 'Classification of the brands market investment tier indicating the scale and priority of media investment. Tier 1 represents highest-investment markets; Tier 3 represents emerging or test markets. Drives media budget allocation in Mediaocean Prisma.. Valid values are `tier_1|tier_2|tier_3|global`',
    `messaging_framework_url` STRING COMMENT 'URL reference to the brands approved messaging framework document in Workfront DAM. Defines key messages, proof points, and value propositions used across campaign strategy, PR communications, and creative development.. Valid values are `^https?://.+`',
    `nielsen_brand_code` STRING COMMENT 'External brand identifier assigned by Nielsen Ad Intel for competitive monitoring, audience measurement, and Gross Rating Point (GRP) tracking. Used to reconcile agency brand records with Nielsens competitive intelligence database.',
    `nps_baseline_score` DECIMAL(18,2) COMMENT 'Baseline Net Promoter Score (NPS) for the brand at the time of agency engagement or last formal brand health assessment. Serves as the reference benchmark for measuring brand health improvement over the engagement period. Range: -100.00 to 100.00.',
    `parent_company_name` STRING COMMENT 'Legal name of the parent organization that owns or controls the brand. Used for competitive conflict checks, client hierarchy management, and consolidated reporting across brand portfolios.',
    `primary_color_hex` STRING COMMENT 'Hexadecimal color code for the brands primary color as defined in the brand guidelines. Used by Adobe Creative Cloud (Photoshop, Illustrator, InDesign) for asset production and Workfront DAM for brand compliance checks.. Valid values are `^#([A-Fa-f0-9]{6})$`',
    `primary_market` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the brands primary or home market. Used as the default market context for brand health benchmarking, SOV tracking via Nielsen Ad Intel, and regulatory compliance flag evaluation.. Valid values are `^[A-Z]{3}$`',
    `primary_typeface` STRING COMMENT 'Name of the primary typeface (font family) specified in the brands typography standards. Governs headline and body copy font usage across all creative executions produced in Adobe Creative Cloud.',
    `secondary_color_hex` STRING COMMENT 'Hexadecimal color code for the brands secondary color as defined in the brand guidelines. Supports multi-color palette management in Adobe Creative Cloud and Workfront DAM for creative production workflows.. Valid values are `^#([A-Fa-f0-9]{6})$`',
    `secondary_typeface` STRING COMMENT 'Name of the secondary or supporting typeface specified in the brands typography standards. Used for subheadings, captions, and supporting copy in creative executions.',
    `sentiment_baseline` STRING COMMENT 'Baseline brand sentiment classification derived from social listening, PR monitoring, and consumer research at the time of agency engagement. Anchors sentiment tracking and PR communications strategy.. Valid values are `very_positive|positive|neutral|negative|very_negative`',
    `sov_tracking_enabled` BOOLEAN COMMENT 'Indicates whether competitive Share of Voice (SOV) tracking is active for this brand via Nielsen Ad Intel. When enabled, competitive monitoring data is ingested and linked to brand health metrics.',
    `tag_certified` BOOLEAN COMMENT 'Indicates whether the brand holds Trustworthy Accountability Group (TAG) certification for brand safety, anti-fraud, and malware protection in digital advertising. Influences publisher allowlist/blocklist configuration in The Trade Desk and Google Campaign Manager 360.',
    `tone_of_voice` STRING COMMENT 'Standardized classification of the brands communication style and personality expression across all channels. Governs copywriting, creative briefs, and PR communications to ensure brand consistency. [ENUM-REF-CANDIDATE: authoritative|playful|inspirational|empathetic|bold|sophisticated|conversational — 7 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the brand profile record was most recently modified. Supports change detection, incremental ETL processing in the Databricks Lakehouse Silver Layer, and audit trail requirements.',
    CONSTRAINT pk_brand_profile PRIMARY KEY(`brand_profile_id`)
) COMMENT 'Master record for a client brand managed by the agency. Captures brand identity essentials including brand name, parent company, industry vertical, brand tier, logo references, brand color palette codes, typography standards, tone of voice classification, brand archetype, launch date, brand lifecycle stage (emerging, established, mature, declining), active markets and geographies, local brand name variants, regulatory compliance flags (ASA, FTC, EASA), and market tier classifications. Serves as the SSOT for brand identity within the brand domain — distinct from the client master in the client domain. Anchors all brand-level entities including guidelines, positioning, assets, health metrics, and PR activities.';

CREATE OR REPLACE TABLE `advertising_ecm`.`brand`.`guideline` (
    `guideline_id` BIGINT COMMENT 'Unique surrogate identifier for the brand guideline record. Primary key for the brand_guideline data product in the Silver Layer lakehouse.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Brand guidelines specify approved production vendors (design agencies, production houses) for asset creation. Essential for vendor compliance in creative production and ensuring brand consistency acro',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Brand guidelines govern the visual identity and messaging architecture for a specific brand profile. While client_brand_id tracks client ownership, brand_profile_id links to the operational brand enti',
    `client_brand_id` BIGINT COMMENT 'Reference to the client brand entity that this guideline governs. Links the guideline to its owning brand within the client portfolio.',
    `previous_version_guideline_id` BIGINT COMMENT 'Self-referencing identifier pointing to the immediately preceding version of this guideline. Enables version chain traversal and supports messaging framework evolution auditing.',
    `worker_id` BIGINT COMMENT 'Reference to the talent profile of the brand strategist who owns and is accountable for this guideline document.',
    `applicable_markets` STRING COMMENT 'Pipe-delimited list of ISO 3166-1 alpha-3 country codes identifying the geographic markets to which this guideline applies (e.g., USA|GBR|DEU). Supports multi-market brand governance and regional variant management.',
    `approval_status` STRING COMMENT 'Current lifecycle state of the guideline document within the Workfront proofing and approval workflow. Draft indicates work-in-progress; In Review indicates active UAT/stakeholder review; Approved indicates ratified and in force; Superseded indicates replaced by a newer version; Retired indicates no longer applicable.. Valid values are `draft|in_review|approved|superseded|retired`',
    `approved_date` DATE COMMENT 'Calendar date on which the guideline received final client or internal approval, as recorded in the Workfront proofing workflow.',
    `approved_typefaces` STRING COMMENT 'Pipe-delimited list of approved font family names for use in brand communications (e.g., Helvetica Neue|Georgia|Arial). Populated for visual_identity guideline types. Sourced from Adobe Creative Cloud font libraries.',
    `audience_message_map` STRING COMMENT 'Structured JSON-serialised string capturing audience segment-to-message mappings (e.g., segment name, primary message, secondary message, call-to-action). Populated for messaging_framework guideline types to support audience-targeted communications.',
    `brand_pillars` STRING COMMENT 'Pipe-delimited list of the brands strategic pillars (e.g., Innovation|Trust|Sustainability). Populated for messaging_framework guideline types. Confidential as it represents proprietary brand positioning strategy.',
    `brand_promise` STRING COMMENT 'The core brand promise statement articulating the fundamental value the brand commits to delivering to its audience. Populated for messaging_framework guideline types. Confidential as it represents proprietary brand strategy.',
    `change_summary` STRING COMMENT 'Free-text summary of the key changes introduced in this version relative to the previous version. Supports change communication to creative, media, and PR teams.',
    `channel_scope` STRING COMMENT 'Pipe-delimited list of media channels to which this guideline applies (e.g., digital|ooh|ctv|print|social). Aligns with IAB channel taxonomy and supports channel-specific creative governance. [ENUM-REF-CANDIDATE: digital|ooh|ctv|print|social|radio|dooh|ott|email|search — promote to reference product]',
    `co_brand_partner_name` STRING COMMENT 'Name of the partner brand involved in a co-branding arrangement governed by this guideline. Populated only for co_branding guideline types. Supports competitive conflict checks and partner brand governance.',
    `confidentiality_level` STRING COMMENT 'Data classification level assigned to this guideline document governing its distribution and access permissions. Public guidelines may be shared externally; Restricted guidelines contain unreleased brand strategy.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'ISO 8601 timestamp recording when this brand guideline record was first created in the system. Supports audit trail and data lineage requirements.',
    `dam_uri` STRING COMMENT 'Fully-qualified URI pointing to the master guideline document stored in the Adobe Creative Cloud Digital Asset Management (DAM) system. Serves as the authoritative source-of-record reference for creative teams.',
    `effective_date` DATE COMMENT 'Calendar date from which this version of the guideline becomes binding for all creative production, media planning, and communications activities.',
    `elevator_pitch` STRING COMMENT 'Concise 30–60 second verbal description of the brands value proposition for use in sales, PR, and client-facing communications. Populated for messaging_framework guideline types.',
    `expiry_date` DATE COMMENT 'Calendar date after which this version of the guideline is no longer valid and must be superseded or retired. Nullable for open-ended guidelines with no planned expiry.',
    `forbidden_language` STRING COMMENT 'Pipe-delimited list of words, phrases, or claims that are explicitly prohibited in all brand communications under this guideline. Supports compliance with ASA, FTC, and client brand safety requirements.',
    `guideline_code` STRING COMMENT 'Externally-known alphanumeric business identifier for the guideline document, used in Workfront project references and Adobe Creative Cloud DAM asset tagging. Format: BG- followed by 4–12 uppercase alphanumeric characters.. Valid values are `^BG-[A-Z0-9]{4,12}$`',
    `guideline_type` STRING COMMENT 'Categorical classification of the guideline document by its primary subject matter. Visual Identity covers logos, colour palettes, typography; Tone of Voice covers language style; Messaging Framework covers brand promise and pillars; Digital covers web/social/app standards; Out-of-Home (OOH) covers outdoor/transit formats; Co-Branding covers partner brand usage rules.. Valid values are `visual_identity|tone_of_voice|messaging_framework|digital|ooh|co_branding`',
    `is_global` BOOLEAN COMMENT 'Indicates whether this guideline applies globally across all markets (True) or is restricted to the markets specified in applicable_markets (False). Supports multi-market brand governance hierarchies.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether compliance with this guideline is mandatory (True) for all creative and communications outputs, or advisory/recommended (False). Supports brand compliance enforcement workflows.',
    `key_proof_points` STRING COMMENT 'Pipe-delimited list of substantiated claims or evidence statements that support the brand promise and pillars. Used by copywriters and PR teams to ensure message consistency. Populated for messaging_framework guideline types.',
    `language_variants` STRING COMMENT 'Pipe-delimited list of BCP-47 language tags identifying the language versions covered by this guideline (e.g., en-US|fr-FR|de-DE). Supports localisation of tone-of-voice and messaging framework guidelines.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'ISO 8601 timestamp recording when this brand guideline record was most recently updated. Supports change detection, audit trail, and Silver Layer incremental processing.',
    `logo_usage_rules` STRING COMMENT 'Free-text description of approved and prohibited logo usage rules including minimum size, clear space, colour variants, and placement restrictions. Populated for visual_identity and co_branding guideline types.',
    `next_review_date` DATE COMMENT 'Scheduled calendar date for the next mandatory review of this guideline. Derived operationally from effective_date plus review_cycle_days but stored explicitly to support governance workflow triggers.',
    `primary_colour_palette` STRING COMMENT 'Pipe-delimited list of approved primary brand colours expressed as HEX codes (e.g., #FF0000|#FFFFFF|#000000). Populated for visual_identity guideline types. Sourced from Adobe Creative Cloud brand libraries.',
    `review_cycle_days` STRING COMMENT 'Scheduled review frequency for this guideline expressed in calendar days (e.g., 365 for annual review). Drives automated review reminders and governance calendar planning.',
    `secondary_colour_palette` STRING COMMENT 'Pipe-delimited list of approved secondary/accent brand colours expressed as HEX codes. Populated for visual_identity guideline types. Supports extended creative palette governance.',
    `tagline` STRING COMMENT 'The primary approved tagline for the brand as defined in this guideline version. Confidential as it may represent unreleased creative strategy prior to campaign launch.',
    `title` STRING COMMENT 'Human-readable title of the brand guideline document (e.g., Acme Corp Global Visual Identity Standards v3.2). Used as the primary display label in DAM and Workfront.',
    `tone_descriptors` STRING COMMENT 'Pipe-delimited list of adjectives describing the brands approved tone of voice (e.g., Authoritative|Warm|Witty|Direct). Populated for tone_of_voice and messaging_framework guideline types.',
    `version_number` STRING COMMENT 'Semantic version identifier for this iteration of the guideline (e.g., 1.0, 2.3, 3.1.2). Supports versioned evolution of messaging frameworks alongside visual identity updates.. Valid values are `^d+.d+(.d+)?$`',
    CONSTRAINT pk_guideline PRIMARY KEY(`guideline_id`)
) COMMENT 'Authoritative brand guideline document record governing visual identity, messaging architecture, and usage standards for a brand. Tracks guideline version, effective date, expiry date, approval status, owning brand strategist, document storage URI (DAM reference), applicable markets/regions, language variants, and guideline type (visual identity, tone of voice, messaging framework, digital, OOH, co-branding). For messaging-type guidelines, captures structured messaging architecture including brand promise, brand pillars, key proof points, elevator pitch, tagline variants, audience-specific message maps, tone descriptors, and forbidden language lists. Integrates with Adobe Creative Cloud DAM and Workfront for proofing workflows. Versioned to support messaging framework evolution alongside visual identity updates.';

CREATE OR REPLACE TABLE `advertising_ecm`.`brand`.`positioning` (
    `positioning_id` BIGINT COMMENT 'Unique surrogate identifier for the brand positioning record. Primary key for this entity. Entity role: MASTER_RESOURCE — represents a strategic positioning document/asset owned and managed by the agency on behalf of a client brand.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser (client organisation) that owns the brand being positioned. Enables cross-brand and cross-client reporting.',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Brand positioning statements define the strategic positioning for a specific brand profile. Similar to brand_guideline, client_brand_id tracks ownership while brand_profile_id links to the operational',
    `client_brand_id` BIGINT COMMENT 'Reference to the client brand entity for which this positioning strategy is defined. Links the positioning record to the brand master in the client domain.',
    `parent_positioning_id` BIGINT COMMENT 'Reference to the global master brand_positioning_id from which this regional or market-specific positioning is derived. Null if this record is itself the global master or a standalone positioning.',
    `primary_superseded_by_positioning_id` BIGINT COMMENT 'Reference to the brand_positioning_id of the newer record that replaced this one. Null if this is the current active version. Enables navigation of the positioning version chain.',
    `approval_status` STRING COMMENT 'The approval workflow status of this positioning record. pending = awaiting internal review; approved = signed off internally; rejected = returned for revision; pending_client = awaiting client sign-off.. Valid values are `pending|approved|rejected|pending_client`',
    `approved_by` STRING COMMENT 'Name or identifier of the individual (internal lead or client stakeholder) who granted final approval for this positioning record. Supports audit trail and accountability tracking.',
    `approved_date` DATE COMMENT 'The date on which this positioning record received final approval (internal and/or client). Null if not yet approved. Used for audit trail and compliance with client SOW deliverable timelines.',
    `awareness_type` STRING COMMENT 'Specifies the methodology used to measure the brand awareness baseline: unaided = spontaneous recall without prompting; aided = recognition when brand name is provided; top_of_mind = first brand recalled in category.. Valid values are `unaided|aided|top_of_mind`',
    `brand_awareness_baseline_pct` DECIMAL(18,2) COMMENT 'The unaided or aided brand awareness percentage recorded at the time this positioning was established or last reviewed. Used as a benchmark to measure the effectiveness of the positioning strategy over time.',
    `brand_essence` STRING COMMENT 'A concise distillation of the brands fundamental nature and core value — typically a short phrase or single sentence that captures the brands soul and guides all brand expression (e.g., Empowering human potential).',
    `brand_personality` STRING COMMENT 'Description of the human characteristics and traits attributed to the brand (e.g., bold, innovative, approachable). Guides tone of voice, creative direction, and communications style across all channels.',
    `brand_promise` STRING COMMENT 'The explicit commitment the brand makes to its target audience — the experience or value customers can consistently expect. Distinct from brand essence in that it is outward-facing and customer-centric.',
    `brand_sentiment_baseline` DECIMAL(18,2) COMMENT 'The baseline brand sentiment score (e.g., on a -100 to +100 scale) recorded at the time this positioning was established or last reviewed. Tracks consumer perception and emotional affinity toward the brand.',
    `competitive_set_ids` STRING COMMENT 'Comma-separated list of competitor brand or advertiser identifiers that constitute the defined competitive set for this positioning. Used to scope Share of Voice (SOV) tracking and competitive monitoring via Nielsen Ad Intel.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this brand positioning record was first created in the system. Supports audit trail, data lineage, and compliance requirements. Satisfies MASTER_RESOURCE RECORD_AUDIT_CREATED category.',
    `effective_from_date` DATE COMMENT 'The date from which this positioning record is considered active and authoritative. Supports temporal tracking of positioning history and enables point-in-time analysis of brand strategy.',
    `frame_of_reference` STRING COMMENT 'The competitive category or context within which the brand competes and against which consumers evaluate it (e.g., premium athletic footwear, cloud-based HR software). Defines the competitive set boundary for the positioning.',
    `geographic_scope` STRING COMMENT 'The geographic market(s) for which this positioning applies, expressed as ISO 3166-1 alpha-3 country codes or regional descriptors (e.g., USA, GBR, GLOBAL). Supports multi-market brand strategy management.',
    `is_global_master` BOOLEAN COMMENT 'Indicates whether this positioning record is the global master version from which regional adaptations are derived. True = global master; False = regional or market-specific adaptation.',
    `language_code` STRING COMMENT 'The IETF BCP 47 language code for the language in which this positioning record is authored (e.g., en, en-US, fr-FR). Supports multi-language brand strategy management for global clients.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `last_review_date` DATE COMMENT 'The date on which this positioning record was most recently formally reviewed and validated by the brand strategy team and client stakeholders.',
    `messaging_framework` STRING COMMENT 'Structured narrative framework defining the hierarchy of brand messages — from core proposition through supporting messages to proof points — used to ensure consistency across campaigns and communications.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next formal review of this positioning record. Calculated based on the review cycle and last review date. Used to trigger review workflows and client QBR preparation.',
    `nielsen_brand_code` STRING COMMENT 'The brand identifier assigned by Nielsen Ad Intel for competitive monitoring and SOV tracking. Used to link this positioning record to Nielsen competitive intelligence data and GRP/TRP measurement reports.',
    `nps_baseline` DECIMAL(18,2) COMMENT 'The Net Promoter Score (NPS) baseline value recorded at the time this positioning was established or last reviewed. Provides a benchmark for measuring brand health improvement attributable to the positioning strategy.',
    `point_of_difference` STRING COMMENT 'The key attribute, benefit, or association that differentiates the brand from competitors within the frame of reference. Represents the core competitive advantage articulated in the positioning strategy.',
    `positioning_code` STRING COMMENT 'Externally-known alphanumeric business identifier for the positioning record, used in cross-system references, client deliverables, and brand strategy documents (e.g., BP-ACME2024). Satisfies MASTER_RESOURCE BUSINESS_IDENTIFIER category.. Valid values are `^BP-[A-Z0-9]{4,12}$`',
    `positioning_name` STRING COMMENT 'Human-readable title or label for this positioning record (e.g., FY2024 Premium Repositioning — ACME Corp). Used in reports, presentations, and brand strategy documents. Satisfies MASTER_RESOURCE IDENTITY_LABEL category.',
    `positioning_status` STRING COMMENT 'Current lifecycle state of the positioning record. draft = in development; active = approved and in use; under_review = scheduled review cycle in progress; superseded = replaced by a newer version; archived = retired. Satisfies MASTER_RESOURCE LIFECYCLE_STATUS category.. Valid values are `draft|active|under_review|superseded|archived`',
    `reason_to_believe` STRING COMMENT 'The substantiation or proof points that support the brands point of difference and make the positioning credible to the target audience. May include product features, certifications, heritage, or third-party endorsements.',
    `review_cycle` STRING COMMENT 'The scheduled frequency at which this positioning record is formally reviewed and validated by the brand strategy team and client. Drives workflow scheduling in Workfront and QBR agenda planning.. Valid values are `quarterly|semi_annual|annual|ad_hoc`',
    `sov_target_pct` DECIMAL(18,2) COMMENT 'The target Share of Voice (SOV) percentage the brand aims to achieve within its competitive set and frame of reference. Used as a KPI benchmark for media planning and campaign performance evaluation. Satisfies MASTER_RESOURCE MEASUREMENT_OR_VALUE category.',
    `statement` STRING COMMENT 'The formal, approved positioning statement articulating the brands unique place in the market. Typically follows the structure: For [target audience], [brand] is the [frame of reference] that [point of difference] because [reason to believe]. Classified confidential as it represents proprietary brand strategy.',
    `superseded_date` DATE COMMENT 'The date on which this positioning record was superseded by a newer version. Null if the record is currently active. Enables full positioning history tracking and audit trail.',
    `target_audience_definition` STRING COMMENT 'Narrative description of the primary target audience for the brand, including demographic, psychographic, and behavioural characteristics. Used to align media planning, creative development, and campaign strategy.',
    `territory` STRING COMMENT 'The primary strategic territory in which the brand is positioned. functional = product/service performance benefits; emotional = feelings and personal identity; societal = broader social, environmental, or cultural purpose. Satisfies MASTER_RESOURCE CLASSIFICATION_OR_TYPE category.. Valid values are `functional|emotional|societal`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this brand positioning record was most recently modified. Supports audit trail, change tracking, and Silver layer incremental processing in the Databricks Lakehouse.',
    `version_number` STRING COMMENT 'Sequential version number of this positioning record for the associated brand. Increments with each approved revision. Enables version history tracking and comparison of positioning evolution over time.',
    `workfront_project_code` STRING COMMENT 'The identifier of the corresponding brand strategy project in Workfront (Project Management system). Enables traceability between the positioning record and the project deliverable, resource plan, and approval workflow.',
    CONSTRAINT pk_positioning PRIMARY KEY(`positioning_id`)
) COMMENT 'Strategic positioning statement and competitive differentiation record for a brand. Stores the formal positioning statement, target audience definition, frame of reference (competitive category), point of difference, reason to believe, brand essence, competitive set identifiers, positioning territory (functional, emotional, societal), and positioning review cycle. Tracks positioning history with effective and superseded dates. Supports Brand Strategy and Positioning process.';

CREATE OR REPLACE TABLE `advertising_ecm`.`brand`.`brand_asset` (
    `brand_asset_id` BIGINT COMMENT 'Unique system-generated identifier for each brand asset record in the DAM. Primary key for the brand_asset product.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser or client who owns this brand asset. Supports client-level brand compliance auditing.',
    `brand_profile_id` BIGINT COMMENT 'Reference to the parent brand under which this asset is managed. Links the asset to its owning brand entity.',
    `campaign_id` BIGINT COMMENT 'Reference to the campaign for which this asset was originally created or first deployed. Supports campaign-level asset utilization reporting and creative lineage tracking.',
    `creative_asset_id` BIGINT COMMENT 'External reference identifier for this asset in the Digital Asset Management (DAM) system — Adobe Creative Cloud or Workfront DAM. Used to cross-reference and retrieve the physical file from the DAM platform.',
    `guideline_id` BIGINT COMMENT 'Foreign key linking to brand.brand_guideline. Business justification: Brand assets must comply with specific brand guidelines. Currently brand_guideline_ref is a STRING reference - converting to FK enables validation that assets meet guideline requirements and allows jo',
    `parent_asset_brand_asset_id` BIGINT COMMENT 'Self-referencing identifier pointing to the master or parent asset from which this variant or localized version was derived. Enables asset hierarchy and lineage tracking.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Brand assets track production vendor (design agencies, production houses, photographers) for asset provenance, rights management, and vendor performance evaluation. Critical for usage rights tracking ',
    `approval_date` DATE COMMENT 'Date on which the asset received its current approval status. Used for compliance auditing and to determine the start of the approved usage window.',
    `approval_status` STRING COMMENT 'Current approval status of the brand asset as determined by the brand governance review process. Only assets with approved status may be deployed in client-facing campaigns.. Valid values are `pending|approved|rejected|conditionally_approved`',
    `approved_by` STRING COMMENT 'Name or identifier of the brand manager or creative director who granted final approval for this asset. Supports brand compliance audit trails.',
    `approved_channels` STRING COMMENT 'Comma-separated list of channels for which this asset has been approved for deployment (e.g., digital,print,OOH,broadcast,social). Enforces brand compliance by restricting asset use to authorized channels only.',
    `asset_description` STRING COMMENT 'Detailed narrative description of the brand asset including its intended use, visual characteristics, and any special handling instructions for creative teams.',
    `asset_name` STRING COMMENT 'Human-readable name or title of the brand asset as catalogued in the DAM (e.g., Primary Logo RGB, Brand Typeface Regular, Hero Photography Q1 2024).',
    `asset_type` STRING COMMENT 'Classification of the brand asset by its creative or identity function. Drives usage rights enforcement and channel eligibility rules. [ENUM-REF-CANDIDATE: logo|icon|typeface|brand_video|photography|illustration|template|motion_graphic|brand_guideline|color_palette — promote to reference product]',
    `cobranding_partner` STRING COMMENT 'Name of the co-branding partner organization whose brand identity is incorporated in this asset (e.g., for co-branded campaigns or partnership activations). Null if no co-branding applies.',
    `color_mode` STRING COMMENT 'Color space or mode of the asset (RGB for digital, CMYK for print, Pantone for brand-matched spot colors). Critical for ensuring correct reproduction across digital and print channels.. Valid values are `RGB|CMYK|Pantone|Grayscale|Black_and_White`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this brand asset record was first created in the system. Supports audit trail and data lineage requirements.',
    `deployment_count` STRING COMMENT 'Total number of times this asset has been deployed across campaigns, channels, or markets. Supports asset utilization reporting and ROI analysis for brand asset investment.',
    `file_format` STRING COMMENT 'File format or extension of the brand asset (e.g., AI, EPS, SVG, PNG, PDF, MP4). Determines rendering compatibility across channels and platforms. [ENUM-REF-CANDIDATE: AI|EPS|SVG|PNG|JPG|PDF|MP4|MOV|OTF|TTF|PSD|INDD|GIF|WEBP — promote to reference product]',
    `file_size_kb` DECIMAL(18,2) COMMENT 'File size of the asset in kilobytes. Used to validate compliance with channel-specific file weight limits (e.g., IAB ad unit max file sizes for digital placements).',
    `height_px` STRING COMMENT 'Height dimension of the asset in pixels. Used alongside width for aspect ratio validation and channel placement eligibility.',
    `is_master_asset` BOOLEAN COMMENT 'Indicates whether this asset is the master/canonical version of the asset type for the brand (True) or a derivative/localized variant (False). Supports brand governance by identifying the authoritative source asset.',
    `language_code` STRING COMMENT 'ISO 639-1 language code (optionally with ISO 3166-1 region subtag) indicating the language of any text or copy embedded in the asset (e.g., en, en-US, fr-FR). Supports multi-market localization management.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `last_deployed_date` DATE COMMENT 'Date on which this asset was most recently deployed in a campaign, channel, or market activation. Used for asset utilization reporting and identifying dormant assets.',
    `lifecycle_stage` STRING COMMENT 'Current stage in the brand assets lifecycle from creation through retirement. Governs whether the asset may be deployed in campaigns or channels. Aligns with Workfront proofing workflow stages.. Valid values are `draft|in_review|approved|active|retired|archived`',
    `market_applicability` STRING COMMENT 'Comma-separated list of markets or regions where this asset is approved for use (e.g., USA,CAN,GBR). Supports multi-market brand governance and localization compliance.',
    `resolution_dpi` STRING COMMENT 'Resolution of the asset expressed in dots per inch (DPI). Determines print and digital quality suitability (e.g., 72 DPI for web, 300 DPI for print).',
    `restriction_notes` STRING COMMENT 'Free-text field capturing any specific restrictions, caveats, or conditions on the use of this asset (e.g., Not for use in alcohol advertising, Minimum size 100px, Do not alter color values). Supports brand compliance enforcement.',
    `rights_expiry_date` DATE COMMENT 'Date on which the usage rights for this asset expire. After this date, the asset must not be deployed without rights renewal. Critical for rights management compliance and avoiding unauthorized use.',
    `rights_territory` STRING COMMENT 'Geographic territory or market scope in which the usage rights for this asset are valid (e.g., USA, GBR, Global, EMEA). Restricts deployment to authorized markets only.',
    `source_system` STRING COMMENT 'Operational system of record from which this brand asset record originated (e.g., Adobe Creative Cloud, Workfront DAM). Supports data lineage and ETL traceability in the Databricks Silver layer.. Valid values are `Adobe_Creative_Cloud|Workfront_DAM|Manual`',
    `tags` STRING COMMENT 'Comma-separated taxonomy or keyword tags applied to the asset for searchability and categorization within the DAM (e.g., hero,summer-2024,product-launch). Facilitates asset discovery and reuse.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this brand asset record was last modified. Supports change tracking, audit compliance, and Silver layer incremental processing.',
    `usage_rights_type` STRING COMMENT 'Classification of the intellectual property rights governing this assets use (e.g., owned outright, licensed, royalty-free, rights-managed). Determines permissible deployment scope and commercial use restrictions.. Valid values are `owned|licensed|royalty_free|rights_managed|creative_commons`',
    `version_number` STRING COMMENT 'Version identifier for the asset following semantic versioning convention (e.g., 1.0, 2.1, 3.0.1). Tracks iterative revisions and ensures the correct version is deployed across campaigns.. Valid values are `^d+.d+(.d+)?$`',
    `width_px` STRING COMMENT 'Width dimension of the asset in pixels. Used for channel eligibility validation and ad serving compatibility checks.',
    CONSTRAINT pk_brand_asset PRIMARY KEY(`brand_asset_id`)
) COMMENT 'Individual brand asset record representing a discrete creative or identity asset (logo, icon, typeface file, brand video, photography, illustration, template) managed under a brand, including its deployment and usage history. Captures asset name, asset type, file format, resolution/dimensions, color mode, usage rights, rights expiry date, approved channels (digital, print, OOH, broadcast), market applicability, DAM asset ID (Adobe Creative Cloud / Workfront DAM reference), version number, approval status, and asset lifecycle stage. Also tracks usage events: each approved deployment across campaigns, channels, or markets with usage context, start/end dates, approver, rights confirmation, co-branding partner references, and restriction notes. Enables brand compliance auditing, rights management tracking, and asset utilization reporting. Distinct from campaign creative assets owned by the creative domain.';

CREATE OR REPLACE TABLE `advertising_ecm`.`brand`.`share_of_voice` (
    `share_of_voice_id` BIGINT COMMENT 'Primary key for share_of_voice',
    `brand_profile_id` BIGINT COMMENT 'Identifier of the client brand being tracked for share of voice analysis.',
    `competitive_brand_id` BIGINT COMMENT 'Identifier of the competitor brand being compared in the share of voice analysis.',
    `competitive_intelligence_id` BIGINT COMMENT 'Foreign key linking to analytics.competitive_intelligence. Business justification: Share of voice tracking data feeds competitive intelligence reports. Analysts aggregate SOV measurements across channels and periods to produce competitive intelligence deliverables. Direct operationa',
    `positioning_id` BIGINT COMMENT 'Foreign key linking to brand.brand_positioning. Business justification: Share of voice measurements track competitive performance of brand positioning strategies. Nullable FK links SOV metrics to the positioning being executed. Enables validation that positioning is achie',
    `brand_impression_count` BIGINT COMMENT 'Total number of advertising impressions delivered by the client brand during the measurement period. Used as an alternative numerator for share of voice calculations when impression data is available.',
    `brand_sov_percentage` DECIMAL(18,2) COMMENT 'Percentage of total category voice captured by the client brand during the measurement period. Calculated as brand impressions or spend divided by total category impressions or spend, expressed as a percentage (0.00 to 100.00).',
    `brand_spend_estimate` DECIMAL(18,2) COMMENT 'Estimated advertising spend by the client brand during the measurement period. Sourced from Nielsen Ad Intel competitive monitoring. Used as the numerator for share of voice calculations.',
    `competitive_rank` STRING COMMENT 'Rank of the client brand within the product category based on share of voice during the measurement period. Rank 1 indicates the highest share of voice in the category. Supports competitive positioning analysis.',
    `competitor_impression_count` BIGINT COMMENT 'Total number of advertising impressions delivered by the competitor brand during the measurement period. Used for competitive impression share analysis.',
    `competitor_sov_percentage` DECIMAL(18,2) COMMENT 'Percentage of total category voice captured by the competitor brand during the measurement period. Calculated as competitor impressions or spend divided by total category impressions or spend, expressed as a percentage (0.00 to 100.00).',
    `competitor_spend_estimate` DECIMAL(18,2) COMMENT 'Estimated advertising spend by the competitor brand during the measurement period. Sourced from Nielsen Ad Intel competitive monitoring.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this share of voice tracking record was first created in the system. Supports data lineage and audit trail requirements.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this record (e.g., USD, EUR, GBP). Ensures consistent financial reporting and cross-market comparison.. Valid values are `^[A-Z]{3}$`',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Quality score assigned to the share of voice data by the source system, ranging from 0.00 (low confidence) to 1.00 (high confidence). Reflects data completeness, accuracy, and reliability. Used to filter or weight competitive intelligence insights.',
    `data_source_reference` STRING COMMENT 'Reference identifier or citation for the source of the share of voice data. Typically references Nielsen Ad Intel competitive monitoring module, report ID, or data extract identifier. Supports data lineage and audit requirements.',
    `data_source_system` STRING COMMENT 'Name of the competitive intelligence system or platform that provided the share of voice data. Primary source is Nielsen Ad Intel; may include other competitive monitoring platforms.. Valid values are `nielsen_ad_intel|comscore|kantar|pathmatics|moat|other`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this share of voice tracking record was last modified. Supports data lineage, change tracking, and audit trail requirements.',
    `market_geography` STRING COMMENT 'Geographic market or region where the share of voice is being measured. Can be country, state, DMA (Designated Market Area), metro area, or custom geographic segment.',
    `market_geography_code` STRING COMMENT 'Standardized code for the geographic market (e.g., ISO country code, DMA code, Nielsen market code). Enables consistent geographic aggregation and comparison.',
    `measurement_methodology` STRING COMMENT 'Methodology used to calculate share of voice. Spend-based uses estimated advertising expenditure; impression-based uses delivered impressions; GRP-based uses gross rating points; hybrid combines multiple metrics.. Valid values are `spend_based|impression_based|grp_based|hybrid`',
    `measurement_period_end_date` DATE COMMENT 'End date of the measurement period for this share of voice tracking record. Supports weekly, monthly, or custom period analysis.',
    `measurement_period_start_date` DATE COMMENT 'Start date of the measurement period for this share of voice tracking record. Supports weekly, monthly, or custom period analysis.',
    `measurement_period_type` STRING COMMENT 'Type of measurement period for the share of voice tracking. Indicates whether the period is weekly, monthly, quarterly, or a custom date range.. Valid values are `weekly|monthly|quarterly|custom`',
    `media_channel` STRING COMMENT 'Media channel or platform where the share of voice is being measured. Includes traditional and digital channels such as TV, radio, print, digital display, social media, out-of-home, connected TV, over-the-top, search, and native advertising. [ENUM-REF-CANDIDATE: tv|radio|print|digital|social|ooh|dooh|ctv|ott|search|display|video|audio|native — 14 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Free-text notes or commentary about the share of voice tracking record. May include insights about competitive activity, data anomalies, market events, or strategic observations. Supports qualitative context for quantitative metrics.',
    `product_category` STRING COMMENT 'Product or service category being tracked for competitive share of voice analysis (e.g., automotive, consumer packaged goods, financial services, retail, telecommunications). Enables category-level aggregation and benchmarking.',
    `product_subcategory` STRING COMMENT 'Subcategory within the product category for more granular competitive analysis (e.g., within automotive: sedans, SUVs, electric vehicles). Enables detailed competitive positioning analysis.',
    `sov_index_vs_category_average` DECIMAL(18,2) COMMENT 'Index comparing the brands share of voice to the category average, where 100.00 represents parity with the average. Values above 100 indicate above-average share of voice; values below 100 indicate below-average share of voice. Calculated as (brand SOV / category average SOV) * 100.',
    `total_category_impression_count` BIGINT COMMENT 'Total number of advertising impressions delivered across all brands in the product category during the measurement period. Used as the denominator for impression-based share of voice calculations.',
    `total_category_spend_estimate` DECIMAL(18,2) COMMENT 'Estimated total advertising spend across all brands in the product category during the measurement period. Sourced from Nielsen Ad Intel competitive monitoring. Used as the denominator for share of voice calculations.',
    `total_competitors_tracked` STRING COMMENT 'Total number of competitor brands tracked in the product category during the measurement period. Provides context for the competitive rank and share of voice analysis.',
    `tracking_status` STRING COMMENT 'Current status of the share of voice tracking record. Active indicates ongoing monitoring; completed indicates the measurement period has ended and data is finalized; pending indicates data collection in progress; cancelled indicates tracking was discontinued; under_review indicates data quality validation in progress.. Valid values are `active|completed|pending|cancelled|under_review`',
    CONSTRAINT pk_share_of_voice PRIMARY KEY(`share_of_voice_id`)
) COMMENT 'Share of Voice (SOV) competitive monitoring record sourced from Nielsen Ad Intel. Captures brand, competitor brand, measurement period (weekly/monthly), media channel, market/geography, brand SOV percentage, competitor SOV percentage, total category spend estimate, brand spend estimate, SOV index vs category average, and data source reference. Supports competitive intelligence and brand strategy reviews. Integrates with Nielsen Ad Intel competitive monitoring module.';

CREATE OR REPLACE TABLE `advertising_ecm`.`brand`.`health_metric` (
    `health_metric_id` BIGINT COMMENT 'Unique identifier for the brand health metric record. Primary key for this entity.',
    `brand_lift_study_id` BIGINT COMMENT 'Foreign key linking to analytics.brand_lift_study. Business justification: Brand health metrics (NPS, awareness, sentiment) are frequently measured through brand lift studies. Agencies track which study generated which metric for validation, trend analysis, and client report',
    `brand_profile_id` BIGINT COMMENT 'Reference to the client brand being measured. Links to the brand master entity.',
    `positioning_id` BIGINT COMMENT 'Foreign key linking to brand.brand_positioning. Business justification: Brand health metrics measure the effectiveness of brand positioning strategies. Nullable FK links metrics (NPS, awareness, sentiment) to the positioning statement being validated. Enables analysis of ',
    `benchmark_value` DECIMAL(18,2) COMMENT 'Industry or competitive benchmark value for comparison. Enables performance assessment relative to category norms or key competitors. Sourced from Nielsen Ad Intel or commissioned research.',
    `collection_frequency` STRING COMMENT 'Frequency at which this metric is collected or updated. Real-time for social listening, daily for news monitoring, quarterly for surveys, annual for brand audits, ad-hoc for special research projects. [ENUM-REF-CANDIDATE: real_time|daily|weekly|monthly|quarterly|annual|ad_hoc — 7 candidates stripped; promote to reference product]',
    `confidence_level` DECIMAL(18,2) COMMENT 'Statistical confidence level for survey-based metrics, expressed as a percentage (e.g., 95.00 for 95% confidence). Indicates the reliability of the measurement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this brand health metric record was first created in the system. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Quality score for the measurement data on a scale of 0-100. Assesses completeness, accuracy, timeliness, and reliability of the data source. Used for data governance and quality monitoring.',
    `data_source` STRING COMMENT 'Specific data source or platform from which the metric was collected. Examples: Twitter, Facebook, Instagram, Google Reviews, commissioned survey, QBR workshop, annual brand audit.',
    `geography_code` STRING COMMENT 'Three-letter ISO country code representing the geographic market where the measurement was conducted. Examples: USA, GBR, CAN, AUS.. Valid values are `^[A-Z]{3}$`',
    `is_statistically_significant` BOOLEAN COMMENT 'Boolean flag indicating whether the metric change or difference is statistically significant based on the confidence level and margin of error. True if significant, False if not.',
    `margin_of_error` DECIMAL(18,2) COMMENT 'Margin of error for survey-based metrics, expressed as a percentage (e.g., 3.50 for ±3.5%). Indicates the precision of the measurement.',
    `market_segment` STRING COMMENT 'Geographic or demographic market segment for which this metric was measured. Examples: USA_18-34_Female, UK_All_Adults, APAC_Premium_Segment. Enables segmented brand health analysis.',
    `measurement_date` DATE COMMENT 'Date when the brand health metric was measured or collected. For surveys: fieldwork completion date. For sentiment: observation date. For reviews: review event date.',
    `measurement_period_end` DATE COMMENT 'End date of the measurement period for aggregated metrics. For sentiment signals collected over a time window, this marks the end of the observation period.',
    `measurement_period_start` DATE COMMENT 'Start date of the measurement period for aggregated metrics. For sentiment signals collected over a time window, this marks the beginning of the observation period.',
    `measurement_type` STRING COMMENT 'Type of brand health measurement. Survey-based metrics (NPS, awareness, consideration), sentiment signals (social listening, news monitoring), or brand review events (QBR, annual audit).. Valid values are `survey|sentiment|review`',
    `mention_volume` STRING COMMENT 'Total number of brand mentions captured during the measurement period for sentiment-based metrics. Sourced from social listening tools, news monitoring, or review platforms.',
    `methodology` STRING COMMENT 'Description of the research methodology used to collect the metric. For surveys: online panel, telephone, in-person. For sentiment: social listening algorithm, natural language processing model. For reviews: structured interview, workshop facilitation.',
    `metric_name` STRING COMMENT 'Specific brand health metric being captured. For surveys: NPS (Net Promoter Score), awareness, consideration, preference, purchase intent, loyalty index, equity score. For sentiment: sentiment score, review rating. [ENUM-REF-CANDIDATE: nps|awareness|consideration|preference|purchase_intent|loyalty_index|equity_score|sentiment_score|review_rating — 9 candidates stripped; promote to reference product]',
    `metric_value` DECIMAL(18,2) COMMENT 'Quantitative value of the brand health metric. For NPS: -100 to +100. For awareness/consideration: percentage 0-100. For sentiment: -1 to +1 or 0-100 scale depending on methodology.',
    `notes` STRING COMMENT 'Free-text notes or comments about the measurement. Captures contextual information, anomalies, data quality issues, or special circumstances affecting the metric.',
    `prior_period_value` DECIMAL(18,2) COMMENT 'Metric value from the previous measurement period. Enables period-over-period trend analysis and tracking of brand health trajectory.',
    `research_vendor` STRING COMMENT 'Name of the research vendor or data provider who conducted the measurement or supplied the data. Examples: Nielsen, Comscore, Brandwatch, Sprinklr, internal research team.',
    `review_event_type` STRING COMMENT 'Type of brand review event for review-based measurements. QBR (Quarterly Business Review), annual brand audit, mid-year review, or campaign debrief.. Valid values are `qbr|annual_audit|mid_year_review|campaign_debrief`',
    `review_findings` STRING COMMENT 'Summary of key findings from brand review events. Captures qualitative insights, strengths, weaknesses, opportunities, and threats identified during QBRs or brand audits.',
    `review_recommendations` STRING COMMENT 'Strategic recommendations resulting from brand review events. Action items and strategic guidance for brand positioning, messaging, or campaign adjustments.',
    `review_status` STRING COMMENT 'Current status of the brand review event. Scheduled, in progress, completed, or cancelled. Tracks the lifecycle of review activities.. Valid values are `scheduled|in_progress|completed|cancelled`',
    `sample_size` STRING COMMENT 'Number of respondents or data points included in the measurement. For surveys: number of completed interviews. For sentiment: number of mentions analyzed. Null for qualitative review events.',
    `sentiment_classification` STRING COMMENT 'Categorical sentiment classification for sentiment-based metrics. Positive, negative, neutral, or mixed sentiment derived from social listening, news monitoring, or review platforms.. Valid values are `positive|negative|neutral|mixed`',
    `sentiment_magnitude` DECIMAL(18,2) COMMENT 'Numerical magnitude or intensity of sentiment, typically on a scale of 0-1 or 0-100. Indicates the strength of positive or negative sentiment beyond the classification.',
    `share_of_voice_percentage` DECIMAL(18,2) COMMENT 'Brands share of voice as a percentage of total category mentions. Calculated as (brand mentions / total category mentions) × 100. Sourced from Nielsen Ad Intel or Comscore competitive monitoring.',
    `target_value` DECIMAL(18,2) COMMENT 'Target or goal value for this brand health metric as defined in the brand strategy or annual planning. Enables performance tracking against objectives.',
    `topic_tags` STRING COMMENT 'Comma-separated list of topic tags or themes associated with the sentiment data. Examples: product_quality, customer_service, pricing, sustainability. Enables thematic analysis of brand perception.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this brand health metric record was last updated in the system. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'Percentage change from prior period value. Calculated as ((current_value - prior_period_value) / prior_period_value) × 100. Positive indicates improvement, negative indicates decline.',
    CONSTRAINT pk_health_metric PRIMARY KEY(`health_metric_id`)
) COMMENT 'Brand health measurement record capturing quantitative brand equity indicators, consumer/media sentiment signals, and periodic brand review outcomes for a brand in a specific market and time period. Covers three measurement types: (1) Survey-based metrics — NPS, awareness, consideration, preference, purchase intent, loyalty index, equity score with methodology, sample size, and fieldwork dates; (2) Sentiment signals — social listening, news monitoring, and review platform data with sentiment classification, magnitude, mention volume, and topic tags collected in real-time or daily; (3) Brand review events — QBRs and annual brand audits with findings, recommendations, and action items. Stores research vendor, collection granularity, market segment, and review status. Aggregates from social listening tools, Comscore digital measurement feeds, and commissioned research. Supports brand health dashboards, QBR reporting, reputation monitoring, and strategy reviews.';

CREATE OR REPLACE TABLE `advertising_ecm`.`brand`.`pr_campaign` (
    `pr_campaign_id` BIGINT COMMENT 'Unique identifier for the public relations campaign record. Primary key.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser or client organization sponsoring this PR campaign.',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: PR campaigns promote and protect specific brand profiles. While client_brand_id tracks client ownership, brand_profile_id links to the operational brand entity being promoted. Essential for connecting',
    `brand_spokesperson_id` BIGINT COMMENT 'Foreign key linking to brand.spokesperson. Business justification: PR campaigns designate specific authorized spokespersons for media interactions. Currently spokesperson_name is STRING - converting to FK ensures campaigns use approved spokespersons and enables joini',
    `client_brand_id` BIGINT COMMENT 'Reference to the client brand this PR campaign is supporting.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: PR campaigns contract with media distribution and monitoring suppliers (wire services, monitoring platforms). Core PR vendor management process for tracking distribution partners and earned media meas',
    `worker_id` BIGINT COMMENT 'Reference to the talent profile of the PR professional or account lead assigned primary responsibility for this campaign.',
    `actual_earned_media_value` DECIMAL(18,2) COMMENT 'The actual earned media value (EMV) achieved by the PR campaign, representing the estimated advertising equivalency value of PR coverage generated. Expressed in the organizations reporting currency.',
    `actual_media_impressions` BIGINT COMMENT 'The actual number of media impressions or reach achieved by the PR campaign across all earned media placements. Populated upon campaign completion or during active tracking.',
    `approval_status` STRING COMMENT 'The approval workflow status of the PR campaign plan and materials. Valid values: draft (initial creation), pending-review (submitted for approval), approved (client approved), rejected (client rejected), revision-required (changes requested).. Valid values are `draft|pending-review|approved|rejected|revision-required`',
    `approved_by` STRING COMMENT 'Name of the client stakeholder or executive who provided final approval for this PR campaign.',
    `approved_date` DATE COMMENT 'The date when the PR campaign received final client approval to proceed. Format: yyyy-MM-dd.',
    `budget_allocation` DECIMAL(18,2) COMMENT 'The total budget amount allocated to this PR campaign for all activities, resources, and expenses. Expressed in the organizations reporting currency.',
    `campaign_code` STRING COMMENT 'Unique business identifier or code assigned to the PR campaign for external reference and tracking across systems.',
    `campaign_name` STRING COMMENT 'The official name or title of the PR campaign used for identification and reporting purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this PR campaign record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `crisis_flag` BOOLEAN COMMENT 'Boolean indicator whether this PR campaign is related to crisis management or reputation protection activities. True indicates crisis-related campaign.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget allocation amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `earned_media_value_target` DECIMAL(18,2) COMMENT 'The target earned media value (EMV) representing the estimated advertising equivalency value of PR coverage this campaign aims to generate. Expressed in the organizations reporting currency.',
    `end_date` DATE COMMENT 'The planned or actual end date when the PR campaign activities conclude. Format: yyyy-MM-dd. Nullable for ongoing campaigns.',
    `geographic_scope` STRING COMMENT 'The geographic reach or scope of the PR campaign. Valid values: local (city/metro), regional (state/province), national (country-wide), international (multiple countries), global (worldwide).. Valid values are `local|regional|national|international|global`',
    `key_messages_reference` STRING COMMENT 'Reference identifier or location pointer to the approved key messaging framework and talking points document for this PR campaign.',
    `media_kit_reference` STRING COMMENT 'Reference identifier or location pointer to the media kit or press materials package associated with this PR campaign, typically stored in the Digital Asset Management (DAM) system.',
    `media_placements_count` STRING COMMENT 'The total number of earned media placements (articles, mentions, features) secured by this PR campaign.',
    `modified_by` STRING COMMENT 'Username or identifier of the system user who last modified this PR campaign record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this PR campaign record was last modified or updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, observations, or context about the PR campaign that do not fit into structured fields.',
    `objective_type` STRING COMMENT 'The primary strategic objective or purpose of the PR campaign. Valid values: product-launch (new product introduction), crisis-management (reputation protection), brand-awareness (visibility building), thought-leadership (industry positioning), event-pr (event promotion), csr (corporate social responsibility).. Valid values are `product-launch|crisis-management|brand-awareness|thought-leadership|event-pr|csr`',
    `pr_campaign_status` STRING COMMENT 'Current lifecycle status of the PR campaign. Valid values: planning (in development), active (currently running), completed (finished), on-hold (temporarily paused), cancelled (terminated before completion).. Valid values are `planning|active|completed|on-hold|cancelled`',
    `press_release_count` STRING COMMENT 'The total number of press releases issued as part of this PR campaign.',
    `primary_channel` STRING COMMENT 'The primary channel or medium through which this PR campaign is executed. Valid values: traditional-media (print/broadcast), digital-media (online news), social-media (social platforms), influencer (influencer partnerships), events (press events/conferences), mixed (multi-channel approach).. Valid values are `traditional-media|digital-media|social-media|influencer|events|mixed`',
    `sentiment_score` DECIMAL(18,2) COMMENT 'Aggregated sentiment score of media coverage for this PR campaign, typically ranging from -100 (very negative) to +100 (very positive), with 0 representing neutral sentiment.',
    `share_of_voice_percentage` DECIMAL(18,2) COMMENT 'The percentage of total media coverage or conversation this PR campaign captured relative to competitors or the overall category. Expressed as a percentage (0.00 to 100.00).',
    `start_date` DATE COMMENT 'The official start date when the PR campaign activities begin. Format: yyyy-MM-dd.',
    `target_audience` STRING COMMENT 'Detailed description of the intended audience or public segment this PR campaign aims to reach, including demographic and psychographic characteristics.',
    `target_media_impressions` BIGINT COMMENT 'The target number of media impressions or reach the PR campaign aims to achieve across all earned media placements.',
    `target_media_tier` STRING COMMENT 'The tier or category of media outlets targeted by this PR campaign. Valid values: tier-1 (top national/international outlets), tier-2 (regional/secondary outlets), trade (industry-specific publications), digital (online-only media), broadcast (TV/radio), print (newspapers/magazines).. Valid values are `tier-1|tier-2|trade|digital|broadcast|print`',
    `created_by` STRING COMMENT 'Username or identifier of the system user who created this PR campaign record.',
    CONSTRAINT pk_pr_campaign PRIMARY KEY(`pr_campaign_id`)
) COMMENT 'Public relations campaign or activation record managing PR-specific initiatives distinct from paid media campaigns. Captures PR campaign name, objective type (product launch, crisis management, brand awareness, thought leadership, event PR, CSR), target media tier (tier-1, tier-2, trade, digital), target audience, key messages reference, assigned PR lead, start and end dates, status (planning, active, completed, on-hold), budget allocation, target media impressions, and earned media value target. Supports Public Relations and Communications process.';

CREATE OR REPLACE TABLE `advertising_ecm`.`brand`.`media_coverage` (
    `media_coverage_id` BIGINT COMMENT 'Unique identifier for the earned media coverage record. Primary key.',
    `brand_spokesperson_id` BIGINT COMMENT 'Foreign key linking to brand.spokesperson. Business justification: Media coverage features specific authorized spokespersons. Currently spokesperson_featured is STRING - converting to FK enables validation that featured spokespersons are approved, and allows joining ',
    `client_brand_id` BIGINT COMMENT 'Reference to the client brand featured in this media coverage.',
    `pr_campaign_id` BIGINT COMMENT 'Reference to the PR campaign that secured this media coverage.',
    `publisher_id` BIGINT COMMENT 'Foreign key linking to vendor.publisher. Business justification: Media coverage records track which publisher/outlet published the story. Core PR measurement process for earned media value calculation, share of voice analysis, and outlet tier performance reporting.',
    `article_word_count` STRING COMMENT 'Total word count of the article or transcript. For broadcast, this represents the transcript word count.',
    `ave_amount` DECIMAL(18,2) COMMENT 'Estimated monetary value of the earned media coverage if it had been purchased as advertising space or airtime. Calculated based on outlet advertising rates and coverage size/duration.',
    `ave_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the AVE amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `brand_mention_count` STRING COMMENT 'Number of times the client brand name or product is mentioned in the coverage content.',
    `circulation_count` BIGINT COMMENT 'For print media, the verified circulation count of the publication. For broadcast, the average viewership or listenership. For digital, the monthly unique visitors.',
    `competitive_mention_flag` BOOLEAN COMMENT 'Boolean flag indicating whether competitor brands were mentioned in the same coverage. True if competitors are mentioned, False if only client brand is featured.',
    `coverage_date` DATE COMMENT 'The date the media coverage was published or aired. This is the principal business event timestamp for earned media tracking.',
    `coverage_prominence` STRING COMMENT 'Placement prominence of the coverage within the outlet. Front page/homepage indicates top-tier placement, section front indicates category lead placement, inside page/standard indicates regular placement, featured indicates highlighted or promoted content.. Valid values are `front_page|section_front|inside_page|homepage|featured|standard`',
    `coverage_reference_number` STRING COMMENT 'Business-facing unique reference number for this media coverage record, used for tracking and reporting.. Valid values are `^MCV-[0-9]{8}$`',
    `coverage_status` STRING COMMENT 'Current lifecycle status of the media coverage record. Published indicates live coverage, scheduled indicates confirmed future coverage, cancelled indicates coverage that did not run, retracted indicates coverage that was removed post-publication, updated indicates coverage that was modified after initial publication.. Valid values are `published|scheduled|cancelled|retracted|updated`',
    `coverage_timestamp` TIMESTAMP COMMENT 'Precise date and time the media coverage was published or aired, including timezone information for broadcast segments.',
    `coverage_type` STRING COMMENT 'The medium through which the coverage was delivered. Print includes newspapers and magazines, online includes digital publications and blogs, broadcast includes TV and radio, podcast includes audio streaming platforms, social media includes influencer and brand social posts, wire service includes AP, Reuters, and other syndication services.. Valid values are `print|online|broadcast|podcast|social_media|wire_service`',
    `coverage_url` STRING COMMENT 'Direct URL link to the online article, broadcast clip, or podcast episode. Null for print-only coverage.. Valid values are `^https?://.*$`',
    `created_by_user` STRING COMMENT 'Username or identifier of the user who created this media coverage record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this media coverage record was first created in the system.',
    `domain_authority_score` STRING COMMENT 'For digital outlets, the domain authority score (0-100) indicating the SEO strength and credibility of the publishing website. Higher scores indicate more authoritative domains.',
    `estimated_reach` BIGINT COMMENT 'Estimated number of individuals who were exposed to this media coverage, based on outlet circulation, viewership, listenership, or unique visitors.',
    `geographic_market` STRING COMMENT 'Primary geographic market or region where the coverage was distributed (e.g., National, New York DMA, United Kingdom, EMEA).',
    `headline` STRING COMMENT 'The headline, title, or subject line of the media coverage. For broadcast segments, this is the segment title or topic description.',
    `journalist_name` STRING COMMENT 'Name of the journalist, reporter, editor, or content creator who authored or produced the coverage.',
    `key_message_alignment_score` DECIMAL(18,2) COMMENT 'Percentage score (0-100) indicating how well the coverage aligns with the clients key messaging framework and campaign objectives. Higher scores indicate stronger message alignment.',
    `language_code` STRING COMMENT 'Two-letter ISO 639-1 language code indicating the language of the coverage content (e.g., en for English, es for Spanish, fr for French).. Valid values are `^[a-z]{2}$`',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this media coverage record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this media coverage record was last modified or updated.',
    `monitoring_source` STRING COMMENT 'Name of the media monitoring service or tool that captured this coverage record (e.g., Nielsen Ad Intel, Meltwater, Cision, Manual Entry).',
    `outlet_tier` STRING COMMENT 'Classification of the media outlet based on reach and influence. Tier 1 represents top-tier national/international outlets, Tier 2 represents major regional outlets, Tier 3 represents smaller regional outlets, niche represents specialized industry publications, local represents local community outlets, regional represents multi-market regional outlets.. Valid values are `tier_1|tier_2|tier_3|niche|local|regional`',
    `page_authority_score` STRING COMMENT 'For digital coverage, the page authority score (0-100) of the specific article or page where the coverage appears, indicating its ranking potential.',
    `segment_duration_seconds` STRING COMMENT 'For broadcast and podcast coverage, the duration of the segment in seconds. Null for print and online text coverage.',
    `sentiment_classification` STRING COMMENT 'Overall sentiment tone of the media coverage toward the client brand. Positive indicates favorable coverage, neutral indicates balanced or factual reporting, negative indicates critical or unfavorable coverage, mixed indicates both positive and negative elements.. Valid values are `positive|neutral|negative|mixed`',
    `sentiment_score` DECIMAL(18,2) COMMENT 'Quantitative sentiment score ranging from -100 (most negative) to +100 (most positive), with 0 representing neutral sentiment. Derived from natural language processing analysis of coverage content.',
    `share_of_voice_contribution` DECIMAL(18,2) COMMENT 'Percentage contribution of this coverage to the overall brand Share of Voice in the competitive media landscape during the measurement period.',
    `third_party_validation_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this coverage record has been validated by a third-party media monitoring service (e.g., Nielsen Ad Intel, Comscore). True if validated, False if internally tracked only.',
    CONSTRAINT pk_media_coverage PRIMARY KEY(`media_coverage_id`)
) COMMENT 'Earned media coverage record capturing individual press mentions, editorial placements, broadcast segments, podcast features, or online articles secured through PR activities. Stores publication/outlet name, outlet tier, journalist name, coverage date, headline, coverage type (print, online, broadcast, podcast), sentiment classification, estimated reach/circulation, advertising value equivalent (AVE), domain authority score for digital outlets, PR campaign reference, spokesperson featured, and key message alignment score. Integrates with Nielsen Ad Intel for competitive media monitoring.';

CREATE OR REPLACE TABLE `advertising_ecm`.`brand`.`press_release` (
    `press_release_id` BIGINT COMMENT 'Unique identifier for the press release record. Primary key.',
    `brand_profile_id` BIGINT COMMENT 'Reference to the client brand this press release is associated with.',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing or advertising campaign associated with this press release, if applicable.',
    `pr_campaign_id` BIGINT COMMENT 'Foreign key linking to brand.pr_campaign. Business justification: Press releases are tactical outputs of PR campaigns. Currently press_release.campaign_id links to paid campaign.campaign, but PR-specific releases should also link to pr_campaign to track PR campaign ',
    `approval_status` STRING COMMENT 'Current approval workflow status of the press release (draft, pending review, approved, rejected, published, archived).. Valid values are `draft|pending_review|approved|rejected|published|archived`',
    `approved_by` STRING COMMENT 'Name or identifier of the individual who approved the press release for distribution.',
    `boilerplate_text` STRING COMMENT 'Standard company or brand description paragraph included at the end of the press release.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the press release record was first created in the system.',
    `distribution_date` TIMESTAMP COMMENT 'Date and time when the press release was distributed to wire services and media contacts.',
    `distribution_geography` STRING COMMENT 'Geographic regions or markets targeted for press release distribution (e.g., USA, CAN, GBR, global).',
    `document_url` STRING COMMENT 'URL or file path to the final published press release document stored in the Digital Asset Management (DAM) system.',
    `draft_version` STRING COMMENT 'Version number of the press release draft, incremented with each revision.',
    `embargo_date` TIMESTAMP COMMENT 'Date and time before which the press release must not be published by media outlets. Null if no embargo applies.',
    `estimated_reach` BIGINT COMMENT 'Estimated total audience reach across all media outlets that published the press release.',
    `key_messages` STRING COMMENT 'Summary of the primary messaging themes and talking points covered in the press release.',
    `language_variants` STRING COMMENT 'Languages in which the press release has been translated and distributed (e.g., EN, ES, FR, DE).',
    `media_contact_email` STRING COMMENT 'Email address of the public relations contact person for media inquiries.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `media_contact_name` STRING COMMENT 'Name of the public relations contact person listed on the press release for media inquiries.',
    `media_contact_phone` STRING COMMENT 'Phone number of the public relations contact person for media inquiries.',
    `modified_by` STRING COMMENT 'Identifier or name of the user who last modified the press release record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the press release record was last modified.',
    `pickup_count` STRING COMMENT 'Number of media outlets, publications, or websites that picked up and published the press release after distribution.',
    `release_type` STRING COMMENT 'Category of press release indicating the nature of the announcement (product launch, financial results, partnership, crisis response, award, CSR, executive appointment). [ENUM-REF-CANDIDATE: product_launch|financial_results|partnership|crisis_response|award|csr|executive_appointment — 7 candidates stripped; promote to reference product]',
    `sentiment_score` DECIMAL(18,2) COMMENT 'Aggregated sentiment score from media coverage analysis, typically ranging from -100 (negative) to +100 (positive).',
    `sov_impact` DECIMAL(18,2) COMMENT 'Measured impact of the press release on the brands Share of Voice (SOV) in competitive media landscape, expressed as percentage point change.',
    `target_wire_service` STRING COMMENT 'Primary wire service used for press release distribution (PR Newswire, Business Wire, GlobeNewswire, other).. Valid values are `pr_newswire|business_wire|globenewswire|other`',
    `title` STRING COMMENT 'The headline or title of the press release document.',
    `word_count` STRING COMMENT 'Total number of words in the press release body text.',
    `created_by` STRING COMMENT 'Identifier or name of the user who created the press release record.',
    CONSTRAINT pk_press_release PRIMARY KEY(`press_release_id`)
) COMMENT 'Official press release document record managed by the PR team. Captures release title, brand reference, release type (product launch, financial results, partnership, crisis response, award, CSR, executive appointment), draft version, approval status, approved by, embargo date, distribution date, target wire service (PR Newswire, Business Wire, GlobeNewswire), distribution geography, language variants, word count, key messages covered, and post-distribution pickup count. Supports Public Relations and Communications process.';

CREATE OR REPLACE TABLE `advertising_ecm`.`brand`.`brand_spokesperson` (
    `brand_spokesperson_id` BIGINT COMMENT 'Unique identifier for the spokesperson record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Spokesperson contracts are formal legal agreements with talent. Currently contract_reference is stored as a string. Normalizing to agreement_id FK enables joining to contract terms, payment schedules,',
    `brand_profile_id` BIGINT COMMENT 'Reference to the brand this spokesperson represents.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Spokespersons contracted through talent agencies (supplier type: talent/casting agency). Real business process: spokesperson vendor management, contract negotiation, and talent agency relationship tra',
    `applicable_markets` STRING COMMENT 'Comma-separated list of geographic markets or regions where the spokesperson is authorized to represent the brand using three-letter ISO country codes (e.g., USA, GBR, CAN, AUS) or regional codes.',
    `approval_date` DATE COMMENT 'Date when the spokesperson was officially approved to represent the brand.',
    `approval_expiry_date` DATE COMMENT 'Date when the spokesperson authorization expires and requires renewal. Null for indefinite authorizations.',
    `approval_status` STRING COMMENT 'Current approval status of the spokesperson authorization: approved (active and authorized), pending (awaiting approval), suspended (temporarily inactive), revoked (permanently removed), or expired (authorization period ended).. Valid values are `approved|pending|suspended|revoked|expired`',
    `approved_topics` STRING COMMENT 'Comma-separated list of topics and subject areas the spokesperson is authorized to discuss in media and public communications (e.g., product innovation, sustainability, financial performance, industry trends).',
    `background_check_status` STRING COMMENT 'Status of background verification and reputational screening: completed (passed all checks), pending (in progress), not_required (waived for this spokesperson type), or failed (did not pass screening).. Valid values are `completed|pending|not_required|failed`',
    `biography` STRING COMMENT 'Official biography or background summary of the spokesperson for use in press releases, media kits, and public communications.',
    `compensation_type` STRING COMMENT 'Type of compensation arrangement for the spokesperson: salaried (regular employee), per_appearance (paid per engagement), retainer (ongoing fee), equity (stock/ownership), pro_bono (reduced fee), or volunteer (unpaid).. Valid values are `salaried|per_appearance|retainer|equity|pro_bono|volunteer`',
    `conflict_of_interest_check_date` DATE COMMENT 'Date when the most recent conflict of interest screening was performed to ensure the spokesperson has no competing brand affiliations or reputational risks.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this spokesperson record was first created in the system.',
    `crisis_contact_name` STRING COMMENT 'Name of the primary contact person (e.g., publicist, agent, manager) to reach in case of crisis or urgent media situation involving the spokesperson.',
    `crisis_contact_phone` STRING COMMENT 'Emergency phone number for the crisis contact person to reach in urgent situations.',
    `email_address` STRING COMMENT 'Primary email address for contacting the spokesperson.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the spokesperson has an exclusive agreement preventing them from representing competing brands. True if exclusive, False if non-exclusive.',
    `headshot_url` STRING COMMENT 'URL or Digital Asset Management (DAM) reference to the spokespersons official headshot photograph for media use.',
    `media_training_date` DATE COMMENT 'Date when the spokesperson completed their most recent media training session.',
    `media_training_status` STRING COMMENT 'Current status of the spokespersons media training certification: completed (training finished and current), in_progress (currently undergoing training), not_started (no training yet), or expired (training certification has lapsed).. Valid values are `completed|in_progress|not_started|expired`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this spokesperson record was last modified or updated.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or context about the spokesperson relationship (e.g., preferred communication style, scheduling constraints, special accommodations).',
    `organization` STRING COMMENT 'Organization or company the spokesperson is affiliated with.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the spokesperson.',
    `restricted_topics` STRING COMMENT 'Comma-separated list of topics and subject areas the spokesperson is NOT authorized to discuss or must avoid in media and public communications (e.g., pending litigation, confidential product launches, competitor strategies).',
    `social_media_handles` STRING COMMENT 'JSON or comma-separated list of the spokespersons official social media handles across platforms (e.g., Twitter: @handle, LinkedIn: profile-url, Instagram: @handle) for verification and monitoring purposes.',
    `spokesperson_name` STRING COMMENT 'Full legal name of the individual authorized to represent the brand.',
    `spokesperson_type` STRING COMMENT 'Classification of the spokesperson role: executive (company leadership), celebrity (public figure), influencer (social media personality), subject matter expert (industry specialist), brand ambassador (contracted representative), or employee (staff member).. Valid values are `executive|celebrity|influencer|subject_matter_expert|brand_ambassador|employee`',
    `title` STRING COMMENT 'Professional title or position of the spokesperson (e.g., Chief Executive Officer, Chief Marketing Officer, Director of Communications).',
    CONSTRAINT pk_brand_spokesperson PRIMARY KEY(`brand_spokesperson_id`)
) COMMENT 'Authorized brand spokesperson record identifying individuals approved to represent a brand in media, PR, and public communications. Captures spokesperson name, title, organization, spokesperson type (executive, celebrity, influencer, subject matter expert, brand ambassador), approved topics list, restricted topics list, media training status, media training date, approval status, approval expiry date, applicable markets, and associated brand references. Distinct from talent domain records which cover production crew and influencer contracts.';

CREATE OR REPLACE TABLE `advertising_ecm`.`brand`.`competitive_brand` (
    `competitive_brand_id` BIGINT COMMENT 'Unique identifier for the competitor brand record in the agencys competitive intelligence program.',
    `brand_archetype` STRING COMMENT 'The primary brand archetype classification based on Carl Jungs archetypal framework, used for competitive positioning and messaging strategy analysis. [ENUM-REF-CANDIDATE: hero|outlaw|magician|lover|jester|everyman|caregiver|ruler|creator|innocent|sage|explorer — 12 candidates stripped; promote to reference product]',
    `brand_name` STRING COMMENT 'The official name of the competitor brand being tracked for competitive intelligence and Share of Voice (SOV) analysis.',
    `brand_positioning_statement` STRING COMMENT 'The observed or inferred brand positioning statement that articulates the competitor brands unique value proposition and target audience.',
    `brand_sentiment_score` DECIMAL(18,2) COMMENT 'Aggregated brand sentiment score ranging from -100 (very negative) to +100 (very positive) based on social listening and media monitoring data.',
    `brand_website_url` STRING COMMENT 'The primary website URL for the competitor brand, used for digital presence monitoring and competitive analysis.',
    `competitive_differentiation_factors` STRING COMMENT 'Comma-separated list of key factors that differentiate this competitor brand from others in the category (e.g., price leadership, innovation, customer service, sustainability).',
    `competitive_threat_level` STRING COMMENT 'Assessment of the competitive threat level this brand poses to the agencys clients based on market overlap, Share of Voice (SOV), and strategic positioning.. Valid values are `critical|high|medium|low|minimal`',
    `comscore_entity_code` STRING COMMENT 'The unique entity identifier assigned by Comscore for tracking digital audience measurement and cross-platform analytics for the competitor brand.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this competitive brand record was first created in the system.',
    `data_source_systems` STRING COMMENT 'Comma-separated list of source systems providing competitive intelligence data for this brand (e.g., Nielsen Ad Intel, Comscore, social listening platforms, manual research).',
    `estimated_annual_ad_spend_tier` STRING COMMENT 'Estimated tier classification of the competitor brands annual advertising spend based on competitive intelligence and media monitoring data.. Valid values are `tier_1_10m_plus|tier_2_5m_to_10m|tier_3_1m_to_5m|tier_4_500k_to_1m|tier_5_under_500k|unknown`',
    `estimated_brand_awareness_percentage` DECIMAL(18,2) COMMENT 'Estimated percentage of target audience with aided or unaided brand awareness, derived from competitive benchmarking studies and market research.',
    `industry_vertical` STRING COMMENT 'The primary industry vertical or sector in which the competitor brand operates (e.g., automotive, consumer packaged goods, financial services, technology).',
    `key_messaging_themes` STRING COMMENT 'Comma-separated list of key messaging themes and value propositions consistently used by the competitor brand in their advertising and communications.',
    `known_agency_relationships` STRING COMMENT 'Comma-separated list of known advertising agencies, media buying agencies, or creative agencies that the competitor brand works with, based on public announcements and competitive intelligence.',
    `last_intelligence_update_date` DATE COMMENT 'The date when competitive intelligence data for this brand was last updated from Nielsen Ad Intel, Comscore, or other monitoring sources.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this competitive brand record was last modified or updated.',
    `media_mix_strategy` STRING COMMENT 'Observed media mix strategy employed by the competitor brand, describing the allocation approach across traditional, digital, and emerging media channels.',
    `monitoring_start_date` DATE COMMENT 'The date when competitive monitoring for this brand was initiated in the agencys intelligence program.',
    `monitoring_status` STRING COMMENT 'Current status of competitive monitoring for this brand in the agencys intelligence program.. Valid values are `active|paused|archived|pending_activation`',
    `nielsen_ad_intel_competitor_code` STRING COMMENT 'The unique competitor identifier assigned by Nielsen Ad Intel for tracking competitive advertising activity, Gross Rating Points (GRP), and Share of Voice (SOV).',
    `notes` STRING COMMENT 'Free-text field for additional competitive intelligence notes, observations, or strategic insights about the competitor brand.',
    `nps_benchmark_score` STRING COMMENT 'Net Promoter Score (NPS) benchmark for the competitor brand, ranging from -100 to +100, used for brand health comparison and competitive positioning analysis.',
    `parent_company_name` STRING COMMENT 'The name of the parent company or holding organization that owns the competitor brand.',
    `primary_markets` STRING COMMENT 'Comma-separated list of primary geographic markets where the competitor brand has significant presence and advertising activity.',
    `primary_media_channels` STRING COMMENT 'Comma-separated list of primary media channels used by the competitor brand (e.g., television, digital display, social media, search, Out-of-Home (OOH), Connected TV (CTV), radio).',
    `product_category` STRING COMMENT 'The primary product or service category that the competitor brand represents within their industry vertical.',
    `recent_campaign_themes` STRING COMMENT 'Comma-separated list of recent major campaign themes or creative concepts launched by the competitor brand in the past 12 months.',
    `social_media_handles` STRING COMMENT 'Comma-separated list of primary social media handles for the competitor brand across major platforms (e.g., @brand on Twitter, @brand on Instagram).',
    `target_audience_segments` STRING COMMENT 'Comma-separated list of primary target audience segments the competitor brand focuses on based on demographic, psychographic, and behavioral analysis.',
    CONSTRAINT pk_competitive_brand PRIMARY KEY(`competitive_brand_id`)
) COMMENT 'Reference master record for competitor brands tracked in the agencys competitive intelligence program. Captures competitor brand name, parent company, industry vertical, primary markets, estimated annual ad spend tier, primary media channels used, known agency relationships, Nielsen Ad Intel competitor ID, Comscore entity ID, brand archetype classification, competitive threat level, and monitoring status. Used as a reference dimension in SOV tracking, brand health benchmarking, and competitive positioning analysis.';

CREATE OR REPLACE TABLE `advertising_ecm`.`brand`.`crisis_event` (
    `crisis_event_id` BIGINT COMMENT 'Unique identifier for the brand crisis event record. Primary key.',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Crisis events affect specific brand profiles and their health metrics. While client_brand_id tracks client ownership, brand_profile_id links to the operational brand entity experiencing the crisis. Cr',
    `client_brand_id` BIGINT COMMENT 'Identifier of the client brand affected by this crisis event.',
    `insight_report_id` BIGINT COMMENT 'Foreign key linking to analytics.insight_report. Business justification: Crisis events trigger dedicated insight reports for impact assessment, sentiment analysis, and recovery tracking. Standard crisis management workflow requires linking crisis records to analytical deli',
    `pr_campaign_id` BIGINT COMMENT 'Foreign key linking to brand.pr_campaign. Business justification: Crisis events often trigger dedicated PR response campaigns. Nullable FK populated when PR response is launched. Links crisis management to PR campaign execution, enabling tracking of response effecti',
    `worker_id` BIGINT COMMENT 'Identifier of the talent or worker assigned as the primary crisis response lead responsible for coordinating the response strategy and communications.',
    `affected_markets` STRING COMMENT 'Geographic markets or regions impacted by the crisis event, stored as comma-separated three-letter ISO country codes (e.g., USA, GBR, DEU).',
    `brand_awareness_impact_pct` DECIMAL(18,2) COMMENT 'Percentage change in brand awareness metrics (aided or unaided recall) measured post-crisis compared to pre-crisis baseline.',
    `communication_channels_used` STRING COMMENT 'Comma-separated list of communication channels employed in the crisis response (e.g., press release, social media, email, website statement, media interview).',
    `corrective_action_plan` STRING COMMENT 'Description of corrective actions and preventive measures implemented to address the root cause and prevent recurrence.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this crisis event record was first created in the system.',
    `crisis_name` STRING COMMENT 'Business-friendly name or title assigned to the crisis event for internal reference and tracking.',
    `crisis_status` STRING COMMENT 'Current lifecycle state of the crisis event: monitoring (watching for escalation), active (response underway), contained (impact limited), or resolved (closed).. Valid values are `monitoring|active|contained|resolved`',
    `crisis_type` STRING COMMENT 'Classification of the crisis event by nature: product recall, executive misconduct, social media backlash, regulatory action, data breach, or competitive attack.. Valid values are `product_recall|executive_misconduct|social_media_backlash|regulatory_action|data_breach|competitive_attack`',
    `detection_source` STRING COMMENT 'Channel or system through which the crisis was first identified (e.g., social media monitoring, news alert, customer complaint, internal audit, regulatory notice).',
    `detection_timestamp` TIMESTAMP COMMENT 'Date and time when the crisis event was first detected or identified by monitoring systems or personnel.',
    `escalation_timestamp` TIMESTAMP COMMENT 'Date and time when the crisis was escalated to senior leadership or executive crisis management team. Null if no escalation occurred.',
    `estimated_reach` BIGINT COMMENT 'Estimated number of individuals or impressions exposed to the crisis event through media coverage, social media, and other channels.',
    `financial_impact_estimate` DECIMAL(18,2) COMMENT 'Estimated financial impact of the crisis event in USD, including direct costs (legal fees, settlements, remediation) and indirect costs (lost revenue, brand damage).',
    `holding_statement_reference` STRING COMMENT 'Reference identifier or document link to the initial holding statement or public communication issued in response to the crisis.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this crisis event record was last updated or modified.',
    `legal_action_flag` BOOLEAN COMMENT 'Indicates whether legal action (lawsuit, regulatory fine, cease-and-desist) was initiated as a result of the crisis event.',
    `media_mentions_count` STRING COMMENT 'Total count of media mentions (news articles, broadcast segments, online publications) referencing the crisis event.',
    `nps_impact_score` DECIMAL(18,2) COMMENT 'Measured change in Net Promoter Score (NPS) for the affected brand following the crisis event, indicating impact on customer loyalty and advocacy.',
    `post_crisis_impact_assessment_flag` BOOLEAN COMMENT 'Indicates whether a formal post-crisis brand impact assessment has been completed to measure reputational damage and recovery metrics.',
    `regulatory_body_involved` STRING COMMENT 'Name of the regulatory or governing body involved in the crisis (e.g., FTC, ASA, GDPR authority). Null if no regulatory involvement.',
    `resolution_date` DATE COMMENT 'Date when the crisis was officially declared resolved and closed. Null if crisis is still active or contained.',
    `response_strategy_type` STRING COMMENT 'Classification of the crisis response approach being employed (e.g., proactive disclosure, defensive positioning, apology and remediation, legal defense, silence strategy).',
    `response_team_size` STRING COMMENT 'Number of internal and external personnel mobilized as part of the crisis response team.',
    `root_cause_summary` STRING COMMENT 'Brief summary of the identified root cause or contributing factors that led to the crisis event, documented after investigation.',
    `sentiment_score` DECIMAL(18,2) COMMENT 'Aggregated sentiment score reflecting public perception during the crisis, typically ranging from -100 (highly negative) to +100 (highly positive).',
    `severity_level` STRING COMMENT 'Priority classification of the crisis event indicating urgency and impact: P1 (critical), P2 (high), P3 (medium), P4 (low).. Valid values are `P1|P2|P3|P4`',
    `social_media_volume` BIGINT COMMENT 'Total volume of social media posts, comments, and shares related to the crisis event across monitored platforms.',
    `stakeholder_notification_timestamp` TIMESTAMP COMMENT 'Date and time when key stakeholders (clients, partners, investors) were formally notified of the crisis event.',
    CONSTRAINT pk_crisis_event PRIMARY KEY(`crisis_event_id`)
) COMMENT 'Operational record capturing a brand crisis or reputational risk event requiring PR and brand management response. Stores crisis name, crisis type (product recall, executive misconduct, social media backlash, regulatory action, data breach, competitive attack), severity level (P1–P4), detection date and time, detection source, affected markets, crisis status (monitoring, active, contained, resolved), crisis lead, response strategy type, holding statement reference, resolution date, and post-crisis brand impact assessment flag. Supports crisis management workflows.';

CREATE OR REPLACE TABLE `advertising_ecm`.`brand`.`brand_compliance_check` (
    `brand_compliance_check_id` BIGINT COMMENT 'Unique identifier for the brand compliance check record. Primary key for this transactional compliance review entity.',
    `worker_id` BIGINT COMMENT 'Identifier of the authorized individual who provided final sign-off on the compliance check. May differ from reviewer for escalated or senior-level approvals.',
    `brand_asset_id` BIGINT COMMENT 'Foreign key linking to brand.brand_asset. Business justification: Compliance checks review specific brand assets for guideline adherence. Currently item_type and item_identifier provide polymorphic reference - adding brand_asset_id FK (nullable, populated when item_',
    `campaign_id` BIGINT COMMENT 'Identifier of the advertising campaign associated with this compliance check, if applicable. Links to campaign master data for context and reporting.',
    `client_brand_id` BIGINT COMMENT 'Identifier of the client brand whose guidelines are being applied in this compliance check. Links to the client brand master entity.',
    `guideline_id` BIGINT COMMENT 'Foreign key linking to brand.brand_guideline. Business justification: Compliance checks validate creative work against specific brand guidelines. Currently guideline_reference and guideline_version are STRING fields - normalizing to FK allows joining to get authoritativ',
    `partnership_id` BIGINT COMMENT 'Foreign key linking to brand.brand_partnership. Business justification: Compliance checks validate co-branded materials from brand partnerships. Nullable FK populated when reviewing partnership-related assets. Currently partnership_type and partner_brand_name are descript',
    `pr_campaign_id` BIGINT COMMENT 'Foreign key linking to brand.pr_campaign. Business justification: Compliance checks validate PR campaign materials for brand guideline adherence. Nullable FK populated when item_type=pr_campaign. Enables tracking compliance across PR activities and linking to camp',
    `previous_check_brand_compliance_check_id` BIGINT COMMENT 'Identifier of the prior compliance check record for this item, if this is a resubmission. Supports version history and remediation tracking.',
    `primary_brand_worker_id` BIGINT COMMENT 'Identifier of the talent resource who performed the compliance review. Links to the talent domain for reviewer identity and credentials.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Compliance checks verify vendor adherence to brand safety, regulatory standards, and contractual obligations. Essential for vendor compliance audits, TAG certification verification, and brand safety i',
    `approver_name` STRING COMMENT 'Full name of the individual who granted final compliance approval, supporting audit trail and accountability requirements.',
    `check_number` STRING COMMENT 'Business identifier for the compliance check, formatted as BCC-YYYYMMDD sequence for external reference and audit trail purposes.. Valid values are `^BCC-[0-9]{8}$`',
    `compliance_outcome` STRING COMMENT 'Final determination of whether the reviewed item meets brand guideline requirements. Drives remediation workflow and approval routing.. Valid values are `compliant|non_compliant|conditionally_approved|requires_revision|approved_with_notes`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this compliance check record was first created in the system. Supports audit trail and data lineage requirements.',
    `item_identifier` STRING COMMENT 'Business reference code or identifier of the specific asset, campaign, press release, or partnership material under review. May reference DAM asset ID, campaign code, or PR document number.',
    `item_title` STRING COMMENT 'Human-readable title or name of the item under compliance review, supporting quick identification and reporting.',
    `item_type` STRING COMMENT 'Classification of the deliverable or material being reviewed for brand compliance. Determines applicable guideline sets and review criteria. [ENUM-REF-CANDIDATE: creative_asset|campaign_execution|press_release|partnership_material|social_media_post|ooh_creative|digital_banner|video_ad|landing_page — 9 candidates stripped; promote to reference product]',
    `jurisdiction` STRING COMMENT 'Three-letter ISO country code representing the primary regulatory jurisdiction for this compliance check. Determines applicable advertising standards and consumer protection laws.. Valid values are `^[A-Z]{3}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this compliance check record was last updated. Tracks changes throughout the review lifecycle for audit and compliance purposes.',
    `partner_brand_name` STRING COMMENT 'Name of the partner brand involved in co-branded materials or partnership deliverables. Supports co-branding approval workflows and conflict checking.',
    `partnership_type` STRING COMMENT 'Classification of co-branding or partnership arrangement requiring compliance review. Determines additional approval requirements and guideline sets.. Valid values are `co_branding|sponsorship|influencer|affiliate|none`',
    `regulatory_framework` STRING COMMENT 'Primary regulatory or industry standard framework applied during this compliance check. Supports multi-jurisdiction compliance tracking and regulatory reporting. [ENUM-REF-CANDIDATE: ASA|FTC|EASA|IAB|GDPR|CCPA|TAG|MRC|internal — 9 candidates stripped; promote to reference product]',
    `remediation_deadline` DATE COMMENT 'Target date by which identified violations must be corrected and the item resubmitted for compliance review. Supports SLA tracking and escalation workflows.',
    `remediation_notes` STRING COMMENT 'Detailed instructions and recommendations for correcting identified violations. Provides actionable guidance to creative teams and account managers.',
    `remediation_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether corrective action is required before the item can be approved for use. Drives workflow routing and deadline tracking.',
    `resubmission_count` STRING COMMENT 'Number of times the item has been resubmitted for compliance review after remediation. Tracks rework cycles and quality metrics.',
    `review_date` DATE COMMENT 'The date when the compliance review was performed. Principal business event timestamp for this compliance check transaction.',
    `review_duration_minutes` STRING COMMENT 'Total time in minutes spent conducting the compliance review. Supports resource planning, capacity management, and process efficiency analysis.',
    `review_priority` STRING COMMENT 'Priority level assigned to this compliance check, driving SLA targets and resource allocation. Urgent reviews support time-sensitive campaign launches.. Valid values are `urgent|high|normal|low`',
    `review_status` STRING COMMENT 'Current lifecycle status of the compliance check workflow. Tracks progression from initial submission through final approval or rejection.. Valid values are `pending|in_review|compliant|non_compliant|conditionally_approved|rejected`',
    `review_timestamp` TIMESTAMP COMMENT 'Precise date and time when the compliance review was initiated, supporting detailed audit trail and SLA tracking.',
    `reviewer_comments` STRING COMMENT 'Free-text comments and observations from the compliance reviewer. Provides context, rationale, and additional guidance beyond structured violation fields.',
    `reviewer_name` STRING COMMENT 'Full name of the individual who conducted the compliance review, supporting audit trail and accountability requirements.',
    `sign_off_date` DATE COMMENT 'Date when final approval was granted and the compliance check was closed. Null for checks still in progress or requiring remediation.',
    `sign_off_timestamp` TIMESTAMP COMMENT 'Precise date and time of final compliance approval, supporting detailed audit trail and regulatory reporting requirements.',
    `violation_severity` STRING COMMENT 'Classification of the severity level of identified violations. Critical violations block approval; major violations require remediation; minor violations may be conditionally approved.. Valid values are `critical|major|minor|advisory`',
    `violations_identified` STRING COMMENT 'Detailed list of specific guideline clauses or requirements that were breached, including clause numbers and brief descriptions. Supports remediation planning and regulatory reporting.',
    CONSTRAINT pk_brand_compliance_check PRIMARY KEY(`brand_compliance_check_id`)
) COMMENT 'Transactional record of a brand compliance review performed against brand guidelines for a specific creative asset, campaign execution, PR material, or co-branded partnership deliverable. Captures the item under review (asset, campaign, press release, partnership material), applicable guideline reference, review date, reviewer identity, compliance status (compliant, non-compliant, conditionally approved), violations identified (list of guideline clauses breached), remediation required flag, remediation deadline, and final sign-off date. Supports ASA, FTC, EASA, and IAB regulatory compliance requirements, brand governance workflows, and co-branding approval processes.';

CREATE OR REPLACE TABLE `advertising_ecm`.`brand`.`architecture` (
    `architecture_id` BIGINT COMMENT 'Unique identifier for the brand architecture record.',
    `brand_profile_id` BIGINT COMMENT 'Reference to the parent brand in the hierarchy. Null for master/root brands.',
    `client_brand_id` BIGINT COMMENT 'Reference to the primary client brand that owns this architecture structure.',
    `guideline_id` BIGINT COMMENT 'Foreign key linking to brand.brand_guideline. Business justification: Brand architecture decisions reference specific brand guidelines that govern the portfolio structure. Currently architecture_code and architecture_name exist, but the guideline reference should be a f',
    `initiative_id` BIGINT COMMENT 'Reference identifier to the Workfront project managing this brand architecture initiative.',
    `superseded_by_architecture_id` BIGINT COMMENT 'Reference to the brand architecture record that replaced this configuration. Null if current.',
    `worker_id` BIGINT COMMENT 'Reference to the agency brand strategist responsible for this architecture design.',
    `parent_architecture_id` BIGINT COMMENT 'Self-referencing FK on architecture (parent_architecture_id)',
    `approval_status` STRING COMMENT 'Current approval workflow state for this brand architecture configuration.. Valid values are `draft|pending_approval|approved|rejected|revision_required`',
    `approved_by` STRING COMMENT 'Name or identifier of the individual who approved this brand architecture configuration.',
    `approved_date` DATE COMMENT 'Date when this brand architecture configuration received formal approval.',
    `architecture_code` STRING COMMENT 'Unique business identifier for this brand architecture configuration.',
    `architecture_name` STRING COMMENT 'Descriptive name for this brand architecture structure.',
    `architecture_status` STRING COMMENT 'Current lifecycle status of this brand architecture configuration.. Valid values are `active|planned|deprecated|archived|under_review`',
    `architecture_type` STRING COMMENT 'Classification of the brand architecture strategy model used by the client.. Valid values are `branded_house|house_of_brands|endorsed|hybrid|sub_brand|monolithic`',
    `brand_equity_contribution_score` DECIMAL(18,2) COMMENT 'Quantitative assessment of this brands contribution to overall portfolio brand equity.',
    `brand_role` STRING COMMENT 'Functional role this brand plays within the portfolio architecture.. Valid values are `master_brand|sub_brand|endorsed_brand|ingredient_brand|flanker_brand|product_brand`',
    `channel_applicability` STRING COMMENT 'Media channels and touchpoints where this brand architecture structure is applied.',
    `co_branding_allowed` BOOLEAN COMMENT 'Indicates whether this brand is permitted to participate in co-branding partnerships.',
    `confidentiality_level` STRING COMMENT 'Data classification level governing access and distribution of this brand architecture information.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this brand architecture record was first created in the system.',
    `effective_date` DATE COMMENT 'Date when this brand architecture configuration became or will become active in market.',
    `endorsement_strength` STRING COMMENT 'Degree to which the parent brand visibly endorses or supports this brand in market communications.. Valid values are `strong|moderate|weak|none`',
    `expiry_date` DATE COMMENT 'Date when this brand architecture configuration is scheduled to be retired or replaced. Null for ongoing structures.',
    `geographic_scope` STRING COMMENT 'Markets and geographic territories where this brand architecture applies.',
    `hierarchy_level` STRING COMMENT 'Numeric depth level in the brand hierarchy tree. Level 1 is master brand, increasing numbers represent deeper nesting.',
    `is_global_master` BOOLEAN COMMENT 'Indicates whether this architecture serves as the global master template for regional adaptations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this brand architecture record was most recently updated.',
    `last_review_date` DATE COMMENT 'Date of the most recent formal review of this brand architecture.',
    `market_positioning_differentiation` STRING COMMENT 'Description of how this brand is differentiated from other brands in the portfolio within the market.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal review of this brand architecture configuration.',
    `notes` STRING COMMENT 'Additional context, observations, or special considerations regarding this brand architecture configuration.',
    `portfolio_strategy_rationale` STRING COMMENT 'Business justification and strategic reasoning for this brand architecture configuration.',
    `product_category_scope` STRING COMMENT 'Product categories or segments this brand covers within the portfolio.',
    `relationship_type` STRING COMMENT 'Nature of the relationship between this brand and related brands in the portfolio.. Valid values are `parent_child|sibling|endorsed|ingredient|extension`',
    `review_cycle_months` STRING COMMENT 'Frequency in months at which this brand architecture is formally reviewed and validated.',
    `target_audience_overlap_pct` DECIMAL(18,2) COMMENT 'Estimated percentage of target audience overlap with parent or sibling brands in the portfolio.',
    `version_number` STRING COMMENT 'Version identifier for this brand architecture configuration, supporting change tracking.',
    `visual_connection_level` STRING COMMENT 'Degree of visual identity alignment between this brand and its parent or sibling brands.. Valid values are `identical|strong|moderate|minimal|independent`',
    CONSTRAINT pk_architecture PRIMARY KEY(`architecture_id`)
) COMMENT 'Hierarchical brand portfolio structure record defining the relationship between parent brands, sub-brands, endorsed brands, and product brands within a clients brand portfolio. Captures architecture type (branded house, house of brands, endorsed, hybrid), hierarchy level, parent-child brand relationships, brand role (master brand, sub-brand, ingredient brand, flanker), portfolio strategy rationale, architecture effective date, and review cycle. Essential for multi-brand clients (CPG, automotive, luxury) where agency manages multiple brands under one parent and must maintain distinct yet coordinated positioning.';

CREATE OR REPLACE TABLE `advertising_ecm`.`brand`.`partnership` (
    `partnership_id` BIGINT COMMENT 'Unique identifier for the brand partnership record. Primary key.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser account associated with this partnership.',
    `audience_insight_id` BIGINT COMMENT 'Foreign key linking to analytics.audience_insight. Business justification: Partnership performance analysis requires audience insights for co-branded targeting, overlap assessment, and activation recommendations. Agencies link partnerships to audience research to optimize pa',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Brand partnerships involve specific brand profiles in co-branding or collaboration arrangements. Links partnership strategy to the operational brand entity, enabling analysis of partnership impact on ',
    `client_brand_id` BIGINT COMMENT 'Reference to the client brand entering into this partnership.',
    `worker_id` BIGINT COMMENT 'Reference to the internal team member or account manager responsible for managing this partnership.',
    `reciprocal_partnership_id` BIGINT COMMENT 'Self-referencing FK on partnership (reciprocal_partnership_id)',
    `actual_brand_awareness_lift_pct` DECIMAL(18,2) COMMENT 'The measured percentage increase in brand awareness achieved through the partnership.',
    `actual_roi_percentage` DECIMAL(18,2) COMMENT 'The realized Return on Investment (ROI) percentage achieved by the partnership, calculated post-campaign or at measurement intervals.',
    `approval_date` DATE COMMENT 'The date when the partnership was officially approved by internal stakeholders.',
    `approval_status` STRING COMMENT 'Internal approval workflow status for the partnership proposal: draft (initial creation), pending review (awaiting stakeholder approval), approved (authorized to proceed), or rejected (not approved).. Valid values are `draft|pending review|approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the individual who granted final approval for the partnership.',
    `approved_cobranded_asset_references` STRING COMMENT 'Comma-separated list of Digital Asset Management (DAM) URIs or asset identifiers for approved co-branded creative materials.',
    `brand_fit_score` DECIMAL(18,2) COMMENT 'Quantitative assessment of strategic alignment and compatibility between the two brands, typically on a 0-100 scale. Higher scores indicate stronger brand synergy.',
    `channel_scope` STRING COMMENT 'Media channels or platforms where co-branded assets may be deployed (e.g., digital, television, Out-of-Home (OOH), social media, retail).',
    `compliance_check_required_flag` BOOLEAN COMMENT 'Indicates whether co-branded assets and partnership activities require formal compliance review per brand guidelines and regulatory standards.',
    `contract_end_date` DATE COMMENT 'The date when the partnership agreement expires or terminates. Nullable for open-ended partnerships.',
    `contract_reference` STRING COMMENT 'Reference identifier or document locator for the legal partnership agreement or Statement of Work (SOW).',
    `contract_start_date` DATE COMMENT 'The date when the partnership agreement becomes effective and binding.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this partnership record was first created in the system.',
    `exclusivity_category` STRING COMMENT 'The product category or market segment to which exclusivity restrictions apply, if applicable.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the partnership includes exclusivity provisions preventing either brand from entering similar partnerships with competitors during the contract period.',
    `last_compliance_check_date` DATE COMMENT 'The date of the most recent compliance review conducted for this partnership.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this partnership record was most recently updated.',
    `market_scope` STRING COMMENT 'Geographic markets or regions where the partnership is active, expressed as comma-separated ISO 3-letter country codes or region descriptors.',
    `modified_by` STRING COMMENT 'Name or identifier of the user who last modified this partnership record.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next partnership performance review or contract renewal discussion.',
    `notes` STRING COMMENT 'Free-text field for additional context, observations, or special instructions related to the partnership.',
    `objective` STRING COMMENT 'The primary business goal or strategic objective of the partnership (e.g., market expansion, audience reach, brand equity enhancement, revenue growth).',
    `partner_brand_name` STRING COMMENT 'The name of the external partner brand collaborating in this partnership.',
    `partner_company_name` STRING COMMENT 'The legal name of the company owning the partner brand.',
    `partnership_code` STRING COMMENT 'Unique business identifier code for the partnership, used for external reference and tracking.. Valid values are `^[A-Z0-9]{6,20}$`',
    `partnership_name` STRING COMMENT 'The official name or title of the brand partnership initiative.',
    `partnership_status` STRING COMMENT 'Current lifecycle status of the partnership: proposed (initial concept), negotiation (terms being finalized), active (live and operational), paused (temporarily suspended), terminated (ended before expiry), or expired (reached natural end date).. Valid values are `proposed|negotiation|active|paused|terminated|expired`',
    `partnership_type` STRING COMMENT 'The category of brand partnership arrangement: co-branding (joint product/campaign), licensing (brand usage rights), sponsorship (event/property association), ingredient branding (component brand visibility), brand alliance (strategic collaboration), or joint venture (shared business entity).. Valid values are `co-branding|licensing|sponsorship|ingredient branding|brand alliance|joint venture`',
    `revenue_share_model` STRING COMMENT 'The financial arrangement for revenue distribution between partners: fixed fee (flat payment), percentage split (proportional revenue sharing), tiered (performance-based brackets), hybrid (combination model), or none (no direct revenue sharing).. Valid values are `fixed fee|percentage split|tiered|hybrid|none`',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'The percentage of revenue allocated to the partner brand, if applicable. Expressed as a decimal (e.g., 25.00 for 25%).',
    `target_audience_overlap_pct` DECIMAL(18,2) COMMENT 'Estimated percentage of audience overlap between the client brand and partner brand, used to assess reach efficiency.',
    `target_brand_awareness_lift_pct` DECIMAL(18,2) COMMENT 'The target percentage increase in brand awareness expected from the partnership.',
    `target_roi_percentage` DECIMAL(18,2) COMMENT 'The target Return on Investment (ROI) percentage goal for the partnership, used to measure financial performance.',
    `termination_reason` STRING COMMENT 'Explanation or rationale for partnership termination, if applicable. Captures business context for ended partnerships.',
    CONSTRAINT pk_partnership PRIMARY KEY(`partnership_id`)
) COMMENT 'Record of a formal co-branding, brand collaboration, or strategic brand partnership between a client brand and an external partner brand. Captures partnership name, partner brand reference, partnership type (co-branding, licensing, sponsorship, ingredient branding, brand alliance), partnership objective, contractual start and end dates, approved co-branded asset references, market scope, revenue share model indicator, partnership status (proposed, active, paused, terminated), brand fit score, and performance KPIs. Supports co-branding compliance checks and partnership ROI reporting.';

CREATE OR REPLACE TABLE `advertising_ecm`.`brand`.`competitive_monitoring` (
    `competitive_monitoring_id` BIGINT COMMENT 'Unique surrogate identifier for the competitive monitoring assignment record. Serves as the primary key.',
    `brand_profile_id` BIGINT COMMENT 'Foreign key to brand_profile representing the client brand for which competitive monitoring is being performed',
    `competitive_brand_id` BIGINT COMMENT 'Foreign key linking to the competitor brand being tracked against the client brand',
    `profile_brand_profile_id` BIGINT COMMENT 'Foreign key linking to the client brand being monitored in the competitive intelligence program',
    `competitive_rank` STRING COMMENT 'Numerical ranking of this competitor relative to other competitors being monitored for this client brand, indicating monitoring priority. Explicitly identified in detection phase relationship data.',
    `competitive_threat_level` STRING COMMENT 'Assessment of the competitive threat level this competitor brand poses specifically to this client brand in the context of this monitoring assignment. Explicitly identified in detection phase relationship data.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this competitive monitoring assignment record was first created in the system',
    `last_intelligence_update_date` DATE COMMENT 'The date when competitive intelligence data for this specific brand-competitor monitoring assignment was last updated. Explicitly identified in detection phase relationship data.',
    `monitoring_cadence` STRING COMMENT 'The frequency at which competitive intelligence is collected and updated for this specific monitoring assignment',
    `monitoring_start_date` DATE COMMENT 'The date when competitive monitoring for this specific brand-competitor pairing was initiated. Explicitly identified in detection phase relationship data.',
    `monitoring_status` STRING COMMENT 'Current operational status of this competitive monitoring assignment. Explicitly identified in detection phase relationship data.',
    `notes` STRING COMMENT 'Free-text field for competitive intelligence notes, observations, and strategic insights specific to this brand-competitor monitoring relationship. Explicitly identified in detection phase relationship data.',
    `sov_comparison_enabled` BOOLEAN COMMENT 'Indicates whether Share of Voice (SOV) comparative tracking is enabled for this brand-competitor pairing',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this competitive monitoring assignment record was last modified',
    CONSTRAINT pk_competitive_monitoring PRIMARY KEY(`competitive_monitoring_id`)
) COMMENT 'This association product represents the active monitoring assignment between a client brand and a competitor brand tracked in the agencys competitive intelligence program. It captures the monitoring relationship including threat assessment, monitoring cadence, intelligence update history, and competitive positioning data. Each record links one brand_profile to one competitive_brand with attributes that exist only in the context of this monitoring relationship.. Existence Justification: In advertising agency operations, competitive monitoring is an active business process where each client brand (brand_profile) is monitored against multiple competitor brands simultaneously, and each competitor brand is tracked in relation to multiple client brands. The agency actively manages these monitoring assignments with specific threat assessments, monitoring cadences, and intelligence update schedules that are unique to each brand-competitor pairing.';

CREATE OR REPLACE TABLE `advertising_ecm`.`brand`.`asset_deployment` (
    `asset_deployment_id` BIGINT COMMENT 'Unique system-generated identifier for each asset deployment record. Primary key.',
    `brand_asset_id` BIGINT COMMENT 'Foreign key linking to the brand asset being deployed in the PR campaign',
    `pr_campaign_id` BIGINT COMMENT 'Foreign key linking to the PR campaign in which the asset is deployed',
    `approval_status` STRING COMMENT 'Approval status specific to this deployment instance, tracking whether this particular asset-campaign pairing has been approved for use. Explicitly identified in detection phase relationship data.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved this specific asset deployment in this PR campaign.',
    `asset_performance_score` DECIMAL(18,2) COMMENT 'Performance score measuring the effectiveness of this specific asset within this specific PR campaign context. Explicitly identified in detection phase relationship data.',
    `deployment_date` DATE COMMENT 'The date when the brand asset was deployed or activated within the PR campaign. Explicitly identified in detection phase relationship data.',
    `deployment_end_date` DATE COMMENT 'The date when the asset deployment concluded or was deactivated from the PR campaign.',
    `media_placement_count` STRING COMMENT 'The number of media placements or appearances this specific asset achieved within this PR campaign. Explicitly identified in detection phase relationship data.',
    `usage_context` STRING COMMENT 'Descriptive context of how and where the asset is being used within the PR campaign (e.g., press kit header, media release logo, event backdrop). Explicitly identified in detection phase relationship data.',
    `usage_notes` STRING COMMENT 'Free-text notes capturing specific details, restrictions, or observations about this asset deployment instance.',
    CONSTRAINT pk_asset_deployment PRIMARY KEY(`asset_deployment_id`)
) COMMENT 'This association product represents the deployment event between brand_asset and pr_campaign. It captures the operational process of deploying specific brand assets within PR campaigns, including approval workflow, usage context, and performance tracking. Each record links one brand asset to one pr_campaign with attributes that exist only in the context of this deployment relationship.. Existence Justification: In advertising brand management, brand assets (logos, videos, templates) are actively deployed across multiple PR campaigns throughout their lifecycle, and each PR campaign utilizes multiple brand assets for different purposes (press kits, media releases, event materials). The deployment process is a managed business activity with approval workflows, usage tracking, and performance measurement specific to each asset-campaign pairing.';

CREATE OR REPLACE TABLE `advertising_ecm`.`brand`.`advertiser_policy` (
    `advertiser_policy_id` BIGINT COMMENT 'Primary key for advertiser_policy',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser organization to which this policy applies.',
    `approved_by_user_worker_id` BIGINT COMMENT 'Reference to the user who formally approved this policy for activation and enforcement.',
    `supersedes_policy_id` BIGINT COMMENT 'Reference to the previous version of the policy that this version replaces, enabling policy lineage tracking.',
    `worker_id` BIGINT COMMENT 'Reference to the internal user or team responsible for maintaining and enforcing this policy.',
    `superseded_advertiser_policy_id` BIGINT COMMENT 'Self-referencing FK on advertiser_policy (superseded_advertiser_policy_id)',
    `allowed_content_categories` STRING COMMENT 'Comma-separated list of content categories that are explicitly permitted under this policy for targeted placements.',
    `applies_to_channels` STRING COMMENT 'Comma-separated list of media channels to which this policy applies, such as display, video, social, search, or broadcast.',
    `approval_date` DATE COMMENT 'Date when the policy was officially approved for implementation.',
    `auto_enforcement_enabled` BOOLEAN COMMENT 'Indicates whether the policy is automatically enforced by system rules and algorithms or requires manual review.',
    `compliance_framework` STRING COMMENT 'Name of the regulatory or industry compliance framework that this policy is designed to satisfy, such as GDPR, CCPA, or COPPA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the advertiser policy record was first created in the system.',
    `documentation_url` STRING COMMENT 'Web link to the full policy documentation, guidelines, and supporting materials for reference.',
    `effective_date` DATE COMMENT 'Date when the advertiser policy becomes binding and enforceable for campaigns and media placements.',
    `enforcement_level` STRING COMMENT 'Degree of strictness with which the policy must be applied to campaigns and media placements.',
    `expiration_date` DATE COMMENT 'Date when the advertiser policy ceases to be active and enforceable, nullable for policies without a defined end date.',
    `geographic_restrictions` STRING COMMENT 'Comma-separated list of countries or regions where the policy imposes specific restrictions or prohibitions on advertising activities.',
    `last_review_date` DATE COMMENT 'Date when the policy was most recently reviewed and validated by the governance team.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the advertiser policy record was most recently updated or modified.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal review and update of the policy.',
    `notes` STRING COMMENT 'Additional free-form notes, comments, or context about the policy for internal reference and collaboration.',
    `notification_recipients` STRING COMMENT 'Comma-separated list of email addresses or user identifiers who should receive notifications related to this policy.',
    `notification_required` BOOLEAN COMMENT 'Indicates whether stakeholders must be notified when this policy is triggered or violated.',
    `policy_category` STRING COMMENT 'High-level categorization of the policy for organizational and governance purposes.',
    `policy_description` STRING COMMENT 'Detailed narrative explanation of the policy terms, conditions, restrictions, and requirements that govern advertiser activities.',
    `policy_name` STRING COMMENT 'Human-readable name or title of the advertiser policy for identification and reporting purposes.',
    `policy_number` STRING COMMENT 'Externally-known unique business identifier for the advertiser policy, typically used in client communications and contracts.',
    `policy_type` STRING COMMENT 'Classification of the policy indicating its primary purpose and scope within the advertising operations framework.',
    `priority_level` STRING COMMENT 'Relative importance of the policy in the hierarchy of advertiser governance rules, used for conflict resolution.',
    `restricted_content_categories` STRING COMMENT 'Comma-separated list of content categories that are prohibited or restricted under this policy for brand safety purposes.',
    `review_frequency` STRING COMMENT 'Scheduled interval at which the policy is reviewed and updated to ensure continued relevance and compliance.',
    `scope` STRING COMMENT 'Geographic, channel, or operational boundary within which the policy applies.',
    `advertiser_policy_status` STRING COMMENT 'Current lifecycle state of the advertiser policy indicating its operational validity and enforcement status.',
    `version_number` STRING COMMENT 'Semantic version identifier tracking revisions and updates to the policy over time.',
    `violation_consequence` STRING COMMENT 'Action or penalty that will be applied if the policy is violated by campaigns or media placements.',
    CONSTRAINT pk_advertiser_policy PRIMARY KEY(`advertiser_policy_id`)
) COMMENT 'Master reference table for advertiser_policy. Referenced by advertiser_policy_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ADD CONSTRAINT `fk_brand_guideline_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ADD CONSTRAINT `fk_brand_guideline_previous_version_guideline_id` FOREIGN KEY (`previous_version_guideline_id`) REFERENCES `advertising_ecm`.`brand`.`guideline`(`guideline_id`);
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ADD CONSTRAINT `fk_brand_positioning_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ADD CONSTRAINT `fk_brand_positioning_parent_positioning_id` FOREIGN KEY (`parent_positioning_id`) REFERENCES `advertising_ecm`.`brand`.`positioning`(`positioning_id`);
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ADD CONSTRAINT `fk_brand_positioning_primary_superseded_by_positioning_id` FOREIGN KEY (`primary_superseded_by_positioning_id`) REFERENCES `advertising_ecm`.`brand`.`positioning`(`positioning_id`);
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` ADD CONSTRAINT `fk_brand_brand_asset_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` ADD CONSTRAINT `fk_brand_brand_asset_guideline_id` FOREIGN KEY (`guideline_id`) REFERENCES `advertising_ecm`.`brand`.`guideline`(`guideline_id`);
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` ADD CONSTRAINT `fk_brand_brand_asset_parent_asset_brand_asset_id` FOREIGN KEY (`parent_asset_brand_asset_id`) REFERENCES `advertising_ecm`.`brand`.`brand_asset`(`brand_asset_id`);
ALTER TABLE `advertising_ecm`.`brand`.`share_of_voice` ADD CONSTRAINT `fk_brand_share_of_voice_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`brand`.`share_of_voice` ADD CONSTRAINT `fk_brand_share_of_voice_competitive_brand_id` FOREIGN KEY (`competitive_brand_id`) REFERENCES `advertising_ecm`.`brand`.`competitive_brand`(`competitive_brand_id`);
ALTER TABLE `advertising_ecm`.`brand`.`share_of_voice` ADD CONSTRAINT `fk_brand_share_of_voice_positioning_id` FOREIGN KEY (`positioning_id`) REFERENCES `advertising_ecm`.`brand`.`positioning`(`positioning_id`);
ALTER TABLE `advertising_ecm`.`brand`.`health_metric` ADD CONSTRAINT `fk_brand_health_metric_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`brand`.`health_metric` ADD CONSTRAINT `fk_brand_health_metric_positioning_id` FOREIGN KEY (`positioning_id`) REFERENCES `advertising_ecm`.`brand`.`positioning`(`positioning_id`);
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ADD CONSTRAINT `fk_brand_pr_campaign_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ADD CONSTRAINT `fk_brand_pr_campaign_brand_spokesperson_id` FOREIGN KEY (`brand_spokesperson_id`) REFERENCES `advertising_ecm`.`brand`.`brand_spokesperson`(`brand_spokesperson_id`);
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` ADD CONSTRAINT `fk_brand_media_coverage_brand_spokesperson_id` FOREIGN KEY (`brand_spokesperson_id`) REFERENCES `advertising_ecm`.`brand`.`brand_spokesperson`(`brand_spokesperson_id`);
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` ADD CONSTRAINT `fk_brand_media_coverage_pr_campaign_id` FOREIGN KEY (`pr_campaign_id`) REFERENCES `advertising_ecm`.`brand`.`pr_campaign`(`pr_campaign_id`);
ALTER TABLE `advertising_ecm`.`brand`.`press_release` ADD CONSTRAINT `fk_brand_press_release_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`brand`.`press_release` ADD CONSTRAINT `fk_brand_press_release_pr_campaign_id` FOREIGN KEY (`pr_campaign_id`) REFERENCES `advertising_ecm`.`brand`.`pr_campaign`(`pr_campaign_id`);
ALTER TABLE `advertising_ecm`.`brand`.`brand_spokesperson` ADD CONSTRAINT `fk_brand_brand_spokesperson_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`brand`.`crisis_event` ADD CONSTRAINT `fk_brand_crisis_event_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`brand`.`crisis_event` ADD CONSTRAINT `fk_brand_crisis_event_pr_campaign_id` FOREIGN KEY (`pr_campaign_id`) REFERENCES `advertising_ecm`.`brand`.`pr_campaign`(`pr_campaign_id`);
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ADD CONSTRAINT `fk_brand_brand_compliance_check_brand_asset_id` FOREIGN KEY (`brand_asset_id`) REFERENCES `advertising_ecm`.`brand`.`brand_asset`(`brand_asset_id`);
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ADD CONSTRAINT `fk_brand_brand_compliance_check_guideline_id` FOREIGN KEY (`guideline_id`) REFERENCES `advertising_ecm`.`brand`.`guideline`(`guideline_id`);
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ADD CONSTRAINT `fk_brand_brand_compliance_check_partnership_id` FOREIGN KEY (`partnership_id`) REFERENCES `advertising_ecm`.`brand`.`partnership`(`partnership_id`);
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ADD CONSTRAINT `fk_brand_brand_compliance_check_pr_campaign_id` FOREIGN KEY (`pr_campaign_id`) REFERENCES `advertising_ecm`.`brand`.`pr_campaign`(`pr_campaign_id`);
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ADD CONSTRAINT `fk_brand_brand_compliance_check_previous_check_brand_compliance_check_id` FOREIGN KEY (`previous_check_brand_compliance_check_id`) REFERENCES `advertising_ecm`.`brand`.`brand_compliance_check`(`brand_compliance_check_id`);
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ADD CONSTRAINT `fk_brand_architecture_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ADD CONSTRAINT `fk_brand_architecture_guideline_id` FOREIGN KEY (`guideline_id`) REFERENCES `advertising_ecm`.`brand`.`guideline`(`guideline_id`);
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ADD CONSTRAINT `fk_brand_architecture_superseded_by_architecture_id` FOREIGN KEY (`superseded_by_architecture_id`) REFERENCES `advertising_ecm`.`brand`.`architecture`(`architecture_id`);
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ADD CONSTRAINT `fk_brand_architecture_parent_architecture_id` FOREIGN KEY (`parent_architecture_id`) REFERENCES `advertising_ecm`.`brand`.`architecture`(`architecture_id`);
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ADD CONSTRAINT `fk_brand_partnership_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ADD CONSTRAINT `fk_brand_partnership_reciprocal_partnership_id` FOREIGN KEY (`reciprocal_partnership_id`) REFERENCES `advertising_ecm`.`brand`.`partnership`(`partnership_id`);
ALTER TABLE `advertising_ecm`.`brand`.`competitive_monitoring` ADD CONSTRAINT `fk_brand_competitive_monitoring_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`brand`.`competitive_monitoring` ADD CONSTRAINT `fk_brand_competitive_monitoring_competitive_brand_id` FOREIGN KEY (`competitive_brand_id`) REFERENCES `advertising_ecm`.`brand`.`competitive_brand`(`competitive_brand_id`);
ALTER TABLE `advertising_ecm`.`brand`.`competitive_monitoring` ADD CONSTRAINT `fk_brand_competitive_monitoring_profile_brand_profile_id` FOREIGN KEY (`profile_brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`brand`.`asset_deployment` ADD CONSTRAINT `fk_brand_asset_deployment_brand_asset_id` FOREIGN KEY (`brand_asset_id`) REFERENCES `advertising_ecm`.`brand`.`brand_asset`(`brand_asset_id`);
ALTER TABLE `advertising_ecm`.`brand`.`asset_deployment` ADD CONSTRAINT `fk_brand_asset_deployment_pr_campaign_id` FOREIGN KEY (`pr_campaign_id`) REFERENCES `advertising_ecm`.`brand`.`pr_campaign`(`pr_campaign_id`);
ALTER TABLE `advertising_ecm`.`brand`.`advertiser_policy` ADD CONSTRAINT `fk_brand_advertiser_policy_supersedes_policy_id` FOREIGN KEY (`supersedes_policy_id`) REFERENCES `advertising_ecm`.`brand`.`advertiser_policy`(`advertiser_policy_id`);
ALTER TABLE `advertising_ecm`.`brand`.`advertiser_policy` ADD CONSTRAINT `fk_brand_advertiser_policy_superseded_advertiser_policy_id` FOREIGN KEY (`superseded_advertiser_policy_id`) REFERENCES `advertising_ecm`.`brand`.`advertiser_policy`(`advertiser_policy_id`);

-- ========= TAGS =========
ALTER SCHEMA `advertising_ecm`.`brand` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `advertising_ecm`.`brand` SET TAGS ('dbx_domain' = 'brand');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile ID');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Media Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ALTER COLUMN `active_markets` SET TAGS ('dbx_business_glossary_term' = 'Active Markets');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ALTER COLUMN `agency_onboard_date` SET TAGS ('dbx_business_glossary_term' = 'Agency Onboarding Date');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ALTER COLUMN `asa_compliant` SET TAGS ('dbx_business_glossary_term' = 'Advertising Standards Authority (ASA) Compliance Flag');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ALTER COLUMN `brand_archetype` SET TAGS ('dbx_business_glossary_term' = 'Brand Archetype');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ALTER COLUMN `brand_awareness_baseline_pct` SET TAGS ('dbx_business_glossary_term' = 'Brand Awareness Baseline Percentage');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ALTER COLUMN `brand_code` SET TAGS ('dbx_business_glossary_term' = 'Brand Code');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ALTER COLUMN `brand_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,30}$');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ALTER COLUMN `brand_guidelines_url` SET TAGS ('dbx_business_glossary_term' = 'Brand Guidelines Document URL');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ALTER COLUMN `brand_guidelines_url` SET TAGS ('dbx_value_regex' = '^https?://.+');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Name');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ALTER COLUMN `brand_safety_category` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Category');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ALTER COLUMN `brand_safety_category` SET TAGS ('dbx_value_regex' = 'standard|sensitive|restricted|custom');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ALTER COLUMN `brand_status` SET TAGS ('dbx_business_glossary_term' = 'Brand Status');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ALTER COLUMN `brand_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|archived');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ALTER COLUMN `brand_tier` SET TAGS ('dbx_business_glossary_term' = 'Brand Tier');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ALTER COLUMN `brand_tier` SET TAGS ('dbx_value_regex' = 'premium|mid-market|value|challenger|luxury');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ALTER COLUMN `ccpa_opt_out` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Opt-Out Flag');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ALTER COLUMN `easa_compliant` SET TAGS ('dbx_business_glossary_term' = 'European Advertising Standards Alliance (EASA) Compliance Flag');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ALTER COLUMN `ftc_compliant` SET TAGS ('dbx_business_glossary_term' = 'Federal Trade Commission (FTC) Compliance Flag');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ALTER COLUMN `gdpr_data_use_consent` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Data Use Consent Flag');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ALTER COLUMN `industry_vertical` SET TAGS ('dbx_business_glossary_term' = 'Industry Vertical');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Brand Launch Date');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Brand Lifecycle Stage');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_value_regex' = 'emerging|established|mature|declining');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ALTER COLUMN `local_brand_name` SET TAGS ('dbx_business_glossary_term' = 'Local Brand Name Variant');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ALTER COLUMN `logo_asset_url` SET TAGS ('dbx_business_glossary_term' = 'Logo Asset URL');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ALTER COLUMN `logo_asset_url` SET TAGS ('dbx_value_regex' = '^https?://.+');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ALTER COLUMN `market_tier` SET TAGS ('dbx_business_glossary_term' = 'Market Tier Classification');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ALTER COLUMN `market_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|global');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ALTER COLUMN `messaging_framework_url` SET TAGS ('dbx_business_glossary_term' = 'Messaging Framework Document URL');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ALTER COLUMN `messaging_framework_url` SET TAGS ('dbx_value_regex' = '^https?://.+');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ALTER COLUMN `nielsen_brand_code` SET TAGS ('dbx_business_glossary_term' = 'Nielsen Ad Intel Brand ID');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ALTER COLUMN `nps_baseline_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Baseline');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ALTER COLUMN `parent_company_name` SET TAGS ('dbx_business_glossary_term' = 'Parent Company Name');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ALTER COLUMN `primary_color_hex` SET TAGS ('dbx_business_glossary_term' = 'Primary Brand Color Hex Code');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ALTER COLUMN `primary_color_hex` SET TAGS ('dbx_value_regex' = '^#([A-Fa-f0-9]{6})$');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ALTER COLUMN `primary_market` SET TAGS ('dbx_business_glossary_term' = 'Primary Market Country Code');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ALTER COLUMN `primary_market` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ALTER COLUMN `primary_typeface` SET TAGS ('dbx_business_glossary_term' = 'Primary Typeface');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ALTER COLUMN `secondary_color_hex` SET TAGS ('dbx_business_glossary_term' = 'Secondary Brand Color Hex Code');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ALTER COLUMN `secondary_color_hex` SET TAGS ('dbx_value_regex' = '^#([A-Fa-f0-9]{6})$');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ALTER COLUMN `secondary_typeface` SET TAGS ('dbx_business_glossary_term' = 'Secondary Typeface');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ALTER COLUMN `sentiment_baseline` SET TAGS ('dbx_business_glossary_term' = 'Brand Sentiment Baseline');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ALTER COLUMN `sentiment_baseline` SET TAGS ('dbx_value_regex' = 'very_positive|positive|neutral|negative|very_negative');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ALTER COLUMN `sov_tracking_enabled` SET TAGS ('dbx_business_glossary_term' = 'Share of Voice (SOV) Tracking Enabled Flag');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ALTER COLUMN `tag_certified` SET TAGS ('dbx_business_glossary_term' = 'Trustworthy Accountability Group (TAG) Certification Flag');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ALTER COLUMN `tone_of_voice` SET TAGS ('dbx_business_glossary_term' = 'Tone of Voice Classification');
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `guideline_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Guideline ID');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Production Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `client_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brand ID');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `previous_version_guideline_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Brand Guideline Version ID');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Strategist ID');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `applicable_markets` SET TAGS ('dbx_business_glossary_term' = 'Brand Guideline Applicable Markets');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Brand Guideline Approval Status');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|superseded|retired');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Brand Guideline Approved Date');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `approved_typefaces` SET TAGS ('dbx_business_glossary_term' = 'Brand Approved Typefaces');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `audience_message_map` SET TAGS ('dbx_business_glossary_term' = 'Audience-Specific Message Map');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `audience_message_map` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `brand_pillars` SET TAGS ('dbx_business_glossary_term' = 'Brand Pillars');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `brand_pillars` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `brand_promise` SET TAGS ('dbx_business_glossary_term' = 'Brand Promise Statement');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `brand_promise` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `change_summary` SET TAGS ('dbx_business_glossary_term' = 'Brand Guideline Change Summary');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `channel_scope` SET TAGS ('dbx_business_glossary_term' = 'Brand Guideline Channel Scope');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `co_brand_partner_name` SET TAGS ('dbx_business_glossary_term' = 'Co-Branding Partner Name');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Brand Guideline Confidentiality Level');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Brand Guideline Created Timestamp');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `dam_uri` SET TAGS ('dbx_business_glossary_term' = 'Digital Asset Management (DAM) Uniform Resource Identifier (URI)');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `dam_uri` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Brand Guideline Effective Date');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `elevator_pitch` SET TAGS ('dbx_business_glossary_term' = 'Brand Elevator Pitch');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `elevator_pitch` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Brand Guideline Expiry Date');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `forbidden_language` SET TAGS ('dbx_business_glossary_term' = 'Brand Forbidden Language List');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `forbidden_language` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `guideline_code` SET TAGS ('dbx_business_glossary_term' = 'Brand Guideline Code');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `guideline_code` SET TAGS ('dbx_value_regex' = '^BG-[A-Z0-9]{4,12}$');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `guideline_type` SET TAGS ('dbx_business_glossary_term' = 'Brand Guideline Type');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `guideline_type` SET TAGS ('dbx_value_regex' = 'visual_identity|tone_of_voice|messaging_framework|digital|ooh|co_branding');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `is_global` SET TAGS ('dbx_business_glossary_term' = 'Brand Guideline Global Flag');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Brand Guideline Mandatory Flag');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `key_proof_points` SET TAGS ('dbx_business_glossary_term' = 'Brand Key Proof Points');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `key_proof_points` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `language_variants` SET TAGS ('dbx_business_glossary_term' = 'Brand Guideline Language Variants');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Brand Guideline Last Modified Timestamp');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `logo_usage_rules` SET TAGS ('dbx_business_glossary_term' = 'Brand Logo Usage Rules');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Brand Guideline Next Review Date');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `primary_colour_palette` SET TAGS ('dbx_business_glossary_term' = 'Brand Primary Colour Palette');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `review_cycle_days` SET TAGS ('dbx_business_glossary_term' = 'Brand Guideline Review Cycle (Days)');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `secondary_colour_palette` SET TAGS ('dbx_business_glossary_term' = 'Brand Secondary Colour Palette');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `tagline` SET TAGS ('dbx_business_glossary_term' = 'Brand Tagline');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `tagline` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Brand Guideline Title');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `tone_descriptors` SET TAGS ('dbx_business_glossary_term' = 'Brand Tone Descriptors');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `tone_descriptors` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Brand Guideline Version Number');
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^d+.d+(.d+)?$');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `positioning_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Positioning ID');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser ID');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `client_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brand ID');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `parent_positioning_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Positioning ID');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `primary_superseded_by_positioning_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Positioning ID');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Positioning Approval Status');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|pending_client');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Positioning Approved By');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Positioning Approved Date');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `awareness_type` SET TAGS ('dbx_business_glossary_term' = 'Brand Awareness Measurement Type');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `awareness_type` SET TAGS ('dbx_value_regex' = 'unaided|aided|top_of_mind');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `brand_awareness_baseline_pct` SET TAGS ('dbx_business_glossary_term' = 'Brand Awareness Baseline Percentage');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `brand_awareness_baseline_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `brand_essence` SET TAGS ('dbx_business_glossary_term' = 'Brand Essence');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `brand_essence` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `brand_personality` SET TAGS ('dbx_business_glossary_term' = 'Brand Personality');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `brand_personality` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `brand_promise` SET TAGS ('dbx_business_glossary_term' = 'Brand Promise');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `brand_promise` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `brand_sentiment_baseline` SET TAGS ('dbx_business_glossary_term' = 'Brand Sentiment Baseline Score');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `brand_sentiment_baseline` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `competitive_set_ids` SET TAGS ('dbx_business_glossary_term' = 'Competitive Set Identifiers');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `competitive_set_ids` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Positioning Effective From Date');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `frame_of_reference` SET TAGS ('dbx_business_glossary_term' = 'Frame of Reference');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `frame_of_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Positioning Geographic Scope');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `is_global_master` SET TAGS ('dbx_business_glossary_term' = 'Is Global Master Positioning Flag');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Positioning Language Code');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Positioning Review Date');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `messaging_framework` SET TAGS ('dbx_business_glossary_term' = 'Brand Messaging Framework');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `messaging_framework` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Positioning Review Date');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `nielsen_brand_code` SET TAGS ('dbx_business_glossary_term' = 'Nielsen Brand Code');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `nps_baseline` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Baseline');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `nps_baseline` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `point_of_difference` SET TAGS ('dbx_business_glossary_term' = 'Point of Difference (POD)');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `point_of_difference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `positioning_code` SET TAGS ('dbx_business_glossary_term' = 'Brand Positioning Code');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `positioning_code` SET TAGS ('dbx_value_regex' = '^BP-[A-Z0-9]{4,12}$');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `positioning_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Positioning Name');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `positioning_status` SET TAGS ('dbx_business_glossary_term' = 'Brand Positioning Status');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `positioning_status` SET TAGS ('dbx_value_regex' = 'draft|active|under_review|superseded|archived');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `reason_to_believe` SET TAGS ('dbx_business_glossary_term' = 'Reason to Believe (RTB)');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `reason_to_believe` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `review_cycle` SET TAGS ('dbx_business_glossary_term' = 'Positioning Review Cycle');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `review_cycle` SET TAGS ('dbx_value_regex' = 'quarterly|semi_annual|annual|ad_hoc');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `sov_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Share of Voice (SOV) Target Percentage');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `sov_target_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `statement` SET TAGS ('dbx_business_glossary_term' = 'Brand Positioning Statement');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `statement` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `superseded_date` SET TAGS ('dbx_business_glossary_term' = 'Positioning Superseded Date');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `target_audience_definition` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Definition');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `target_audience_definition` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `territory` SET TAGS ('dbx_business_glossary_term' = 'Brand Positioning Territory');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `territory` SET TAGS ('dbx_value_regex' = 'functional|emotional|societal');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Positioning Version Number');
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ALTER COLUMN `workfront_project_code` SET TAGS ('dbx_business_glossary_term' = 'Workfront Project ID');
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` ALTER COLUMN `brand_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Asset ID');
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Asset Management (DAM) Asset ID');
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` ALTER COLUMN `guideline_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Guideline Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` ALTER COLUMN `parent_asset_brand_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Asset ID');
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Production Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Asset Approval Date');
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Approval Status');
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditionally_approved');
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Asset Approver Name');
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` ALTER COLUMN `approved_channels` SET TAGS ('dbx_business_glossary_term' = 'Approved Deployment Channels');
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` ALTER COLUMN `asset_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Description');
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` ALTER COLUMN `asset_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Asset Name');
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'Brand Asset Type');
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` ALTER COLUMN `cobranding_partner` SET TAGS ('dbx_business_glossary_term' = 'Co-Branding Partner Name');
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` ALTER COLUMN `color_mode` SET TAGS ('dbx_business_glossary_term' = 'Asset Color Mode');
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` ALTER COLUMN `color_mode` SET TAGS ('dbx_value_regex' = 'RGB|CMYK|Pantone|Grayscale|Black_and_White');
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` ALTER COLUMN `deployment_count` SET TAGS ('dbx_business_glossary_term' = 'Asset Deployment Count');
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'Asset File Format');
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` ALTER COLUMN `file_size_kb` SET TAGS ('dbx_business_glossary_term' = 'Asset File Size (Kilobytes)');
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` ALTER COLUMN `height_px` SET TAGS ('dbx_business_glossary_term' = 'Asset Height (Pixels)');
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` ALTER COLUMN `is_master_asset` SET TAGS ('dbx_business_glossary_term' = 'Is Master Asset Flag');
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Language Code');
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` ALTER COLUMN `last_deployed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Deployed Date');
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Asset Lifecycle Stage');
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|active|retired|archived');
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` ALTER COLUMN `market_applicability` SET TAGS ('dbx_business_glossary_term' = 'Market Applicability');
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` ALTER COLUMN `resolution_dpi` SET TAGS ('dbx_business_glossary_term' = 'Asset Resolution (DPI)');
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` ALTER COLUMN `restriction_notes` SET TAGS ('dbx_business_glossary_term' = 'Asset Restriction Notes');
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` ALTER COLUMN `rights_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights Expiry Date');
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` ALTER COLUMN `rights_territory` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights Territory');
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Adobe_Creative_Cloud|Workfront_DAM|Manual');
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Asset Taxonomy Tags');
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` ALTER COLUMN `usage_rights_type` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights Type');
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` ALTER COLUMN `usage_rights_type` SET TAGS ('dbx_value_regex' = 'owned|licensed|royalty_free|rights_managed|creative_commons');
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Version Number');
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^d+.d+(.d+)?$');
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` ALTER COLUMN `width_px` SET TAGS ('dbx_business_glossary_term' = 'Asset Width (Pixels)');
ALTER TABLE `advertising_ecm`.`brand`.`share_of_voice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`brand`.`share_of_voice` SET TAGS ('dbx_subdomain' = 'competitive_intelligence');
ALTER TABLE `advertising_ecm`.`brand`.`share_of_voice` ALTER COLUMN `share_of_voice_id` SET TAGS ('dbx_business_glossary_term' = 'Share Of Voice Identifier');
ALTER TABLE `advertising_ecm`.`brand`.`share_of_voice` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `advertising_ecm`.`brand`.`share_of_voice` ALTER COLUMN `competitive_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Competitor Brand ID');
ALTER TABLE `advertising_ecm`.`brand`.`share_of_voice` ALTER COLUMN `competitive_intelligence_id` SET TAGS ('dbx_business_glossary_term' = 'Competitive Intelligence Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`brand`.`share_of_voice` ALTER COLUMN `positioning_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Positioning Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`brand`.`share_of_voice` ALTER COLUMN `brand_impression_count` SET TAGS ('dbx_business_glossary_term' = 'Brand Impression Count');
ALTER TABLE `advertising_ecm`.`brand`.`share_of_voice` ALTER COLUMN `brand_sov_percentage` SET TAGS ('dbx_business_glossary_term' = 'Brand Share of Voice (SOV) Percentage');
ALTER TABLE `advertising_ecm`.`brand`.`share_of_voice` ALTER COLUMN `brand_spend_estimate` SET TAGS ('dbx_business_glossary_term' = 'Brand Spend Estimate');
ALTER TABLE `advertising_ecm`.`brand`.`share_of_voice` ALTER COLUMN `brand_spend_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`share_of_voice` ALTER COLUMN `competitive_rank` SET TAGS ('dbx_business_glossary_term' = 'Competitive Rank');
ALTER TABLE `advertising_ecm`.`brand`.`share_of_voice` ALTER COLUMN `competitor_impression_count` SET TAGS ('dbx_business_glossary_term' = 'Competitor Impression Count');
ALTER TABLE `advertising_ecm`.`brand`.`share_of_voice` ALTER COLUMN `competitor_sov_percentage` SET TAGS ('dbx_business_glossary_term' = 'Competitor Share of Voice (SOV) Percentage');
ALTER TABLE `advertising_ecm`.`brand`.`share_of_voice` ALTER COLUMN `competitor_spend_estimate` SET TAGS ('dbx_business_glossary_term' = 'Competitor Spend Estimate');
ALTER TABLE `advertising_ecm`.`brand`.`share_of_voice` ALTER COLUMN `competitor_spend_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`share_of_voice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`brand`.`share_of_voice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`brand`.`share_of_voice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`brand`.`share_of_voice` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `advertising_ecm`.`brand`.`share_of_voice` ALTER COLUMN `data_source_reference` SET TAGS ('dbx_business_glossary_term' = 'Data Source Reference');
ALTER TABLE `advertising_ecm`.`brand`.`share_of_voice` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `advertising_ecm`.`brand`.`share_of_voice` ALTER COLUMN `data_source_system` SET TAGS ('dbx_value_regex' = 'nielsen_ad_intel|comscore|kantar|pathmatics|moat|other');
ALTER TABLE `advertising_ecm`.`brand`.`share_of_voice` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `advertising_ecm`.`brand`.`share_of_voice` ALTER COLUMN `market_geography` SET TAGS ('dbx_business_glossary_term' = 'Market Geography');
ALTER TABLE `advertising_ecm`.`brand`.`share_of_voice` ALTER COLUMN `market_geography_code` SET TAGS ('dbx_business_glossary_term' = 'Market Geography Code');
ALTER TABLE `advertising_ecm`.`brand`.`share_of_voice` ALTER COLUMN `measurement_methodology` SET TAGS ('dbx_business_glossary_term' = 'Measurement Methodology');
ALTER TABLE `advertising_ecm`.`brand`.`share_of_voice` ALTER COLUMN `measurement_methodology` SET TAGS ('dbx_value_regex' = 'spend_based|impression_based|grp_based|hybrid');
ALTER TABLE `advertising_ecm`.`brand`.`share_of_voice` ALTER COLUMN `measurement_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period End Date');
ALTER TABLE `advertising_ecm`.`brand`.`share_of_voice` ALTER COLUMN `measurement_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Start Date');
ALTER TABLE `advertising_ecm`.`brand`.`share_of_voice` ALTER COLUMN `measurement_period_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Type');
ALTER TABLE `advertising_ecm`.`brand`.`share_of_voice` ALTER COLUMN `measurement_period_type` SET TAGS ('dbx_value_regex' = 'weekly|monthly|quarterly|custom');
ALTER TABLE `advertising_ecm`.`brand`.`share_of_voice` ALTER COLUMN `media_channel` SET TAGS ('dbx_business_glossary_term' = 'Media Channel');
ALTER TABLE `advertising_ecm`.`brand`.`share_of_voice` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `advertising_ecm`.`brand`.`share_of_voice` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `advertising_ecm`.`brand`.`share_of_voice` ALTER COLUMN `product_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Product Subcategory');
ALTER TABLE `advertising_ecm`.`brand`.`share_of_voice` ALTER COLUMN `sov_index_vs_category_average` SET TAGS ('dbx_business_glossary_term' = 'Share of Voice (SOV) Index vs Category Average');
ALTER TABLE `advertising_ecm`.`brand`.`share_of_voice` ALTER COLUMN `total_category_impression_count` SET TAGS ('dbx_business_glossary_term' = 'Total Category Impression Count');
ALTER TABLE `advertising_ecm`.`brand`.`share_of_voice` ALTER COLUMN `total_category_spend_estimate` SET TAGS ('dbx_business_glossary_term' = 'Total Category Spend Estimate');
ALTER TABLE `advertising_ecm`.`brand`.`share_of_voice` ALTER COLUMN `total_category_spend_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`share_of_voice` ALTER COLUMN `total_competitors_tracked` SET TAGS ('dbx_business_glossary_term' = 'Total Competitors Tracked');
ALTER TABLE `advertising_ecm`.`brand`.`share_of_voice` ALTER COLUMN `tracking_status` SET TAGS ('dbx_business_glossary_term' = 'Tracking Status');
ALTER TABLE `advertising_ecm`.`brand`.`share_of_voice` ALTER COLUMN `tracking_status` SET TAGS ('dbx_value_regex' = 'active|completed|pending|cancelled|under_review');
ALTER TABLE `advertising_ecm`.`brand`.`health_metric` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`brand`.`health_metric` SET TAGS ('dbx_subdomain' = 'competitive_intelligence');
ALTER TABLE `advertising_ecm`.`brand`.`health_metric` ALTER COLUMN `health_metric_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Health Metric Identifier (ID)');
ALTER TABLE `advertising_ecm`.`brand`.`health_metric` ALTER COLUMN `health_metric_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`health_metric` ALTER COLUMN `health_metric_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`health_metric` ALTER COLUMN `brand_lift_study_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Lift Study Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`brand`.`health_metric` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Identifier (ID)');
ALTER TABLE `advertising_ecm`.`brand`.`health_metric` ALTER COLUMN `positioning_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Positioning Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`brand`.`health_metric` ALTER COLUMN `benchmark_value` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Value');
ALTER TABLE `advertising_ecm`.`brand`.`health_metric` ALTER COLUMN `collection_frequency` SET TAGS ('dbx_business_glossary_term' = 'Collection Frequency');
ALTER TABLE `advertising_ecm`.`brand`.`health_metric` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level');
ALTER TABLE `advertising_ecm`.`brand`.`health_metric` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`brand`.`health_metric` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `advertising_ecm`.`brand`.`health_metric` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `advertising_ecm`.`brand`.`health_metric` ALTER COLUMN `geography_code` SET TAGS ('dbx_business_glossary_term' = 'Geography Code');
ALTER TABLE `advertising_ecm`.`brand`.`health_metric` ALTER COLUMN `geography_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`brand`.`health_metric` ALTER COLUMN `is_statistically_significant` SET TAGS ('dbx_business_glossary_term' = 'Is Statistically Significant');
ALTER TABLE `advertising_ecm`.`brand`.`health_metric` ALTER COLUMN `margin_of_error` SET TAGS ('dbx_business_glossary_term' = 'Margin of Error');
ALTER TABLE `advertising_ecm`.`brand`.`health_metric` ALTER COLUMN `market_segment` SET TAGS ('dbx_business_glossary_term' = 'Market Segment');
ALTER TABLE `advertising_ecm`.`brand`.`health_metric` ALTER COLUMN `measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Date');
ALTER TABLE `advertising_ecm`.`brand`.`health_metric` ALTER COLUMN `measurement_period_end` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period End Date');
ALTER TABLE `advertising_ecm`.`brand`.`health_metric` ALTER COLUMN `measurement_period_start` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Start Date');
ALTER TABLE `advertising_ecm`.`brand`.`health_metric` ALTER COLUMN `measurement_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Type');
ALTER TABLE `advertising_ecm`.`brand`.`health_metric` ALTER COLUMN `measurement_type` SET TAGS ('dbx_value_regex' = 'survey|sentiment|review');
ALTER TABLE `advertising_ecm`.`brand`.`health_metric` ALTER COLUMN `mention_volume` SET TAGS ('dbx_business_glossary_term' = 'Mention Volume');
ALTER TABLE `advertising_ecm`.`brand`.`health_metric` ALTER COLUMN `methodology` SET TAGS ('dbx_business_glossary_term' = 'Research Methodology');
ALTER TABLE `advertising_ecm`.`brand`.`health_metric` ALTER COLUMN `metric_name` SET TAGS ('dbx_business_glossary_term' = 'Metric Name');
ALTER TABLE `advertising_ecm`.`brand`.`health_metric` ALTER COLUMN `metric_value` SET TAGS ('dbx_business_glossary_term' = 'Metric Value');
ALTER TABLE `advertising_ecm`.`brand`.`health_metric` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `advertising_ecm`.`brand`.`health_metric` ALTER COLUMN `prior_period_value` SET TAGS ('dbx_business_glossary_term' = 'Prior Period Value');
ALTER TABLE `advertising_ecm`.`brand`.`health_metric` ALTER COLUMN `research_vendor` SET TAGS ('dbx_business_glossary_term' = 'Research Vendor');
ALTER TABLE `advertising_ecm`.`brand`.`health_metric` ALTER COLUMN `review_event_type` SET TAGS ('dbx_business_glossary_term' = 'Review Event Type');
ALTER TABLE `advertising_ecm`.`brand`.`health_metric` ALTER COLUMN `review_event_type` SET TAGS ('dbx_value_regex' = 'qbr|annual_audit|mid_year_review|campaign_debrief');
ALTER TABLE `advertising_ecm`.`brand`.`health_metric` ALTER COLUMN `review_findings` SET TAGS ('dbx_business_glossary_term' = 'Review Findings');
ALTER TABLE `advertising_ecm`.`brand`.`health_metric` ALTER COLUMN `review_recommendations` SET TAGS ('dbx_business_glossary_term' = 'Review Recommendations');
ALTER TABLE `advertising_ecm`.`brand`.`health_metric` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `advertising_ecm`.`brand`.`health_metric` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled');
ALTER TABLE `advertising_ecm`.`brand`.`health_metric` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `advertising_ecm`.`brand`.`health_metric` ALTER COLUMN `sentiment_classification` SET TAGS ('dbx_business_glossary_term' = 'Sentiment Classification');
ALTER TABLE `advertising_ecm`.`brand`.`health_metric` ALTER COLUMN `sentiment_classification` SET TAGS ('dbx_value_regex' = 'positive|negative|neutral|mixed');
ALTER TABLE `advertising_ecm`.`brand`.`health_metric` ALTER COLUMN `sentiment_magnitude` SET TAGS ('dbx_business_glossary_term' = 'Sentiment Magnitude');
ALTER TABLE `advertising_ecm`.`brand`.`health_metric` ALTER COLUMN `share_of_voice_percentage` SET TAGS ('dbx_business_glossary_term' = 'Share of Voice (SOV) Percentage');
ALTER TABLE `advertising_ecm`.`brand`.`health_metric` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `advertising_ecm`.`brand`.`health_metric` ALTER COLUMN `topic_tags` SET TAGS ('dbx_business_glossary_term' = 'Topic Tags');
ALTER TABLE `advertising_ecm`.`brand`.`health_metric` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `advertising_ecm`.`brand`.`health_metric` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` SET TAGS ('dbx_subdomain' = 'public_relations');
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ALTER COLUMN `pr_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Public Relations (PR) Campaign ID');
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser ID');
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ALTER COLUMN `brand_spokesperson_id` SET TAGS ('dbx_business_glossary_term' = 'Spokesperson Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ALTER COLUMN `client_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brand ID');
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Media Distribution Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Public Relations (PR) Lead ID');
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ALTER COLUMN `actual_earned_media_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Earned Media Value (EMV)');
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ALTER COLUMN `actual_media_impressions` SET TAGS ('dbx_business_glossary_term' = 'Actual Media Impressions');
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Campaign Approval Status');
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending-review|approved|rejected|revision-required');
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign Approval Date');
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ALTER COLUMN `budget_allocation` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocation Amount');
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ALTER COLUMN `budget_allocation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ALTER COLUMN `campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Public Relations (PR) Campaign Code');
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_business_glossary_term' = 'Public Relations (PR) Campaign Name');
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ALTER COLUMN `crisis_flag` SET TAGS ('dbx_business_glossary_term' = 'Crisis Management Flag');
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ALTER COLUMN `earned_media_value_target` SET TAGS ('dbx_business_glossary_term' = 'Earned Media Value (EMV) Target');
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign End Date');
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'local|regional|national|international|global');
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ALTER COLUMN `key_messages_reference` SET TAGS ('dbx_business_glossary_term' = 'Key Messages Reference');
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ALTER COLUMN `media_kit_reference` SET TAGS ('dbx_business_glossary_term' = 'Media Kit Reference');
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ALTER COLUMN `media_placements_count` SET TAGS ('dbx_business_glossary_term' = 'Media Placements Count');
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Campaign Notes');
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ALTER COLUMN `objective_type` SET TAGS ('dbx_business_glossary_term' = 'Public Relations (PR) Campaign Objective Type');
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ALTER COLUMN `objective_type` SET TAGS ('dbx_value_regex' = 'product-launch|crisis-management|brand-awareness|thought-leadership|event-pr|csr');
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ALTER COLUMN `pr_campaign_status` SET TAGS ('dbx_business_glossary_term' = 'Public Relations (PR) Campaign Status');
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ALTER COLUMN `pr_campaign_status` SET TAGS ('dbx_value_regex' = 'planning|active|completed|on-hold|cancelled');
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ALTER COLUMN `press_release_count` SET TAGS ('dbx_business_glossary_term' = 'Press Release Count');
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ALTER COLUMN `primary_channel` SET TAGS ('dbx_business_glossary_term' = 'Primary Public Relations (PR) Channel');
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ALTER COLUMN `primary_channel` SET TAGS ('dbx_value_regex' = 'traditional-media|digital-media|social-media|influencer|events|mixed');
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ALTER COLUMN `sentiment_score` SET TAGS ('dbx_business_glossary_term' = 'Media Sentiment Score');
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ALTER COLUMN `share_of_voice_percentage` SET TAGS ('dbx_business_glossary_term' = 'Share of Voice (SOV) Percentage');
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign Start Date');
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Description');
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ALTER COLUMN `target_media_impressions` SET TAGS ('dbx_business_glossary_term' = 'Target Media Impressions');
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ALTER COLUMN `target_media_tier` SET TAGS ('dbx_business_glossary_term' = 'Target Media Tier');
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ALTER COLUMN `target_media_tier` SET TAGS ('dbx_value_regex' = 'tier-1|tier-2|trade|digital|broadcast|print');
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` SET TAGS ('dbx_subdomain' = 'public_relations');
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` ALTER COLUMN `media_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Media Coverage ID');
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` ALTER COLUMN `brand_spokesperson_id` SET TAGS ('dbx_business_glossary_term' = 'Spokesperson Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` ALTER COLUMN `client_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brand ID');
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` ALTER COLUMN `pr_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Public Relations (PR) Campaign ID');
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` ALTER COLUMN `publisher_id` SET TAGS ('dbx_business_glossary_term' = 'Publisher Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` ALTER COLUMN `article_word_count` SET TAGS ('dbx_business_glossary_term' = 'Article Word Count');
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` ALTER COLUMN `ave_amount` SET TAGS ('dbx_business_glossary_term' = 'Advertising Value Equivalent (AVE) Amount');
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` ALTER COLUMN `ave_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Advertising Value Equivalent (AVE) Currency Code');
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` ALTER COLUMN `ave_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` ALTER COLUMN `brand_mention_count` SET TAGS ('dbx_business_glossary_term' = 'Brand Mention Count');
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` ALTER COLUMN `circulation_count` SET TAGS ('dbx_business_glossary_term' = 'Circulation Count');
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` ALTER COLUMN `competitive_mention_flag` SET TAGS ('dbx_business_glossary_term' = 'Competitive Mention Flag');
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` ALTER COLUMN `coverage_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Date');
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` ALTER COLUMN `coverage_prominence` SET TAGS ('dbx_business_glossary_term' = 'Coverage Prominence');
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` ALTER COLUMN `coverage_prominence` SET TAGS ('dbx_value_regex' = 'front_page|section_front|inside_page|homepage|featured|standard');
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` ALTER COLUMN `coverage_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Coverage Reference Number');
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` ALTER COLUMN `coverage_reference_number` SET TAGS ('dbx_value_regex' = '^MCV-[0-9]{8}$');
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` ALTER COLUMN `coverage_status` SET TAGS ('dbx_business_glossary_term' = 'Coverage Status');
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` ALTER COLUMN `coverage_status` SET TAGS ('dbx_value_regex' = 'published|scheduled|cancelled|retracted|updated');
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` ALTER COLUMN `coverage_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Coverage Timestamp');
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type');
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` ALTER COLUMN `coverage_type` SET TAGS ('dbx_value_regex' = 'print|online|broadcast|podcast|social_media|wire_service');
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` ALTER COLUMN `coverage_url` SET TAGS ('dbx_business_glossary_term' = 'Coverage Uniform Resource Locator (URL)');
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` ALTER COLUMN `coverage_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` ALTER COLUMN `domain_authority_score` SET TAGS ('dbx_business_glossary_term' = 'Domain Authority Score');
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` ALTER COLUMN `estimated_reach` SET TAGS ('dbx_business_glossary_term' = 'Estimated Reach');
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` ALTER COLUMN `geographic_market` SET TAGS ('dbx_business_glossary_term' = 'Geographic Market');
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` ALTER COLUMN `headline` SET TAGS ('dbx_business_glossary_term' = 'Coverage Headline');
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` ALTER COLUMN `journalist_name` SET TAGS ('dbx_business_glossary_term' = 'Journalist Name');
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` ALTER COLUMN `key_message_alignment_score` SET TAGS ('dbx_business_glossary_term' = 'Key Message Alignment Score');
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` ALTER COLUMN `monitoring_source` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Source');
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` ALTER COLUMN `outlet_tier` SET TAGS ('dbx_business_glossary_term' = 'Media Outlet Tier');
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` ALTER COLUMN `outlet_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|niche|local|regional');
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` ALTER COLUMN `page_authority_score` SET TAGS ('dbx_business_glossary_term' = 'Page Authority Score');
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` ALTER COLUMN `segment_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Segment Duration Seconds');
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` ALTER COLUMN `sentiment_classification` SET TAGS ('dbx_business_glossary_term' = 'Sentiment Classification');
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` ALTER COLUMN `sentiment_classification` SET TAGS ('dbx_value_regex' = 'positive|neutral|negative|mixed');
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` ALTER COLUMN `sentiment_score` SET TAGS ('dbx_business_glossary_term' = 'Sentiment Score');
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` ALTER COLUMN `share_of_voice_contribution` SET TAGS ('dbx_business_glossary_term' = 'Share of Voice (SOV) Contribution');
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` ALTER COLUMN `third_party_validation_flag` SET TAGS ('dbx_business_glossary_term' = 'Third Party Validation Flag');
ALTER TABLE `advertising_ecm`.`brand`.`press_release` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`brand`.`press_release` SET TAGS ('dbx_subdomain' = 'public_relations');
ALTER TABLE `advertising_ecm`.`brand`.`press_release` ALTER COLUMN `press_release_id` SET TAGS ('dbx_business_glossary_term' = 'Press Release ID');
ALTER TABLE `advertising_ecm`.`brand`.`press_release` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `advertising_ecm`.`brand`.`press_release` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Related Campaign ID');
ALTER TABLE `advertising_ecm`.`brand`.`press_release` ALTER COLUMN `pr_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Pr Campaign Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`brand`.`press_release` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `advertising_ecm`.`brand`.`press_release` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|rejected|published|archived');
ALTER TABLE `advertising_ecm`.`brand`.`press_release` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `advertising_ecm`.`brand`.`press_release` ALTER COLUMN `approved_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`press_release` ALTER COLUMN `boilerplate_text` SET TAGS ('dbx_business_glossary_term' = 'Boilerplate Text');
ALTER TABLE `advertising_ecm`.`brand`.`press_release` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`brand`.`press_release` ALTER COLUMN `distribution_date` SET TAGS ('dbx_business_glossary_term' = 'Distribution Date');
ALTER TABLE `advertising_ecm`.`brand`.`press_release` ALTER COLUMN `distribution_geography` SET TAGS ('dbx_business_glossary_term' = 'Distribution Geography');
ALTER TABLE `advertising_ecm`.`brand`.`press_release` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document URL');
ALTER TABLE `advertising_ecm`.`brand`.`press_release` ALTER COLUMN `draft_version` SET TAGS ('dbx_business_glossary_term' = 'Draft Version Number');
ALTER TABLE `advertising_ecm`.`brand`.`press_release` ALTER COLUMN `embargo_date` SET TAGS ('dbx_business_glossary_term' = 'Embargo Date');
ALTER TABLE `advertising_ecm`.`brand`.`press_release` ALTER COLUMN `estimated_reach` SET TAGS ('dbx_business_glossary_term' = 'Estimated Audience Reach');
ALTER TABLE `advertising_ecm`.`brand`.`press_release` ALTER COLUMN `key_messages` SET TAGS ('dbx_business_glossary_term' = 'Key Messages Covered');
ALTER TABLE `advertising_ecm`.`brand`.`press_release` ALTER COLUMN `language_variants` SET TAGS ('dbx_business_glossary_term' = 'Language Variants');
ALTER TABLE `advertising_ecm`.`brand`.`press_release` ALTER COLUMN `media_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Media Contact Email Address');
ALTER TABLE `advertising_ecm`.`brand`.`press_release` ALTER COLUMN `media_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `advertising_ecm`.`brand`.`press_release` ALTER COLUMN `media_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`press_release` ALTER COLUMN `media_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`press_release` ALTER COLUMN `media_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Media Contact Name');
ALTER TABLE `advertising_ecm`.`brand`.`press_release` ALTER COLUMN `media_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`press_release` ALTER COLUMN `media_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Media Contact Phone Number');
ALTER TABLE `advertising_ecm`.`brand`.`press_release` ALTER COLUMN `media_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`press_release` ALTER COLUMN `media_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`press_release` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `advertising_ecm`.`brand`.`press_release` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`brand`.`press_release` ALTER COLUMN `pickup_count` SET TAGS ('dbx_business_glossary_term' = 'Post-Distribution Pickup Count');
ALTER TABLE `advertising_ecm`.`brand`.`press_release` ALTER COLUMN `release_type` SET TAGS ('dbx_business_glossary_term' = 'Release Type');
ALTER TABLE `advertising_ecm`.`brand`.`press_release` ALTER COLUMN `sentiment_score` SET TAGS ('dbx_business_glossary_term' = 'Media Sentiment Score');
ALTER TABLE `advertising_ecm`.`brand`.`press_release` ALTER COLUMN `sov_impact` SET TAGS ('dbx_business_glossary_term' = 'Share of Voice (SOV) Impact');
ALTER TABLE `advertising_ecm`.`brand`.`press_release` ALTER COLUMN `target_wire_service` SET TAGS ('dbx_business_glossary_term' = 'Target Wire Service');
ALTER TABLE `advertising_ecm`.`brand`.`press_release` ALTER COLUMN `target_wire_service` SET TAGS ('dbx_value_regex' = 'pr_newswire|business_wire|globenewswire|other');
ALTER TABLE `advertising_ecm`.`brand`.`press_release` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Press Release Title');
ALTER TABLE `advertising_ecm`.`brand`.`press_release` ALTER COLUMN `word_count` SET TAGS ('dbx_business_glossary_term' = 'Word Count');
ALTER TABLE `advertising_ecm`.`brand`.`press_release` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `advertising_ecm`.`brand`.`brand_spokesperson` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`brand`.`brand_spokesperson` SET TAGS ('dbx_subdomain' = 'public_relations');
ALTER TABLE `advertising_ecm`.`brand`.`brand_spokesperson` ALTER COLUMN `brand_spokesperson_id` SET TAGS ('dbx_business_glossary_term' = 'Spokesperson Identifier (ID)');
ALTER TABLE `advertising_ecm`.`brand`.`brand_spokesperson` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`brand`.`brand_spokesperson` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Identifier (ID)');
ALTER TABLE `advertising_ecm`.`brand`.`brand_spokesperson` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Agency Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`brand`.`brand_spokesperson` ALTER COLUMN `applicable_markets` SET TAGS ('dbx_business_glossary_term' = 'Applicable Markets');
ALTER TABLE `advertising_ecm`.`brand`.`brand_spokesperson` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Spokesperson Approval Date');
ALTER TABLE `advertising_ecm`.`brand`.`brand_spokesperson` ALTER COLUMN `approval_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Spokesperson Approval Expiry Date');
ALTER TABLE `advertising_ecm`.`brand`.`brand_spokesperson` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Spokesperson Approval Status');
ALTER TABLE `advertising_ecm`.`brand`.`brand_spokesperson` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|suspended|revoked|expired');
ALTER TABLE `advertising_ecm`.`brand`.`brand_spokesperson` ALTER COLUMN `approved_topics` SET TAGS ('dbx_business_glossary_term' = 'Approved Topics List');
ALTER TABLE `advertising_ecm`.`brand`.`brand_spokesperson` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `advertising_ecm`.`brand`.`brand_spokesperson` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'completed|pending|not_required|failed');
ALTER TABLE `advertising_ecm`.`brand`.`brand_spokesperson` ALTER COLUMN `biography` SET TAGS ('dbx_business_glossary_term' = 'Spokesperson Biography');
ALTER TABLE `advertising_ecm`.`brand`.`brand_spokesperson` ALTER COLUMN `compensation_type` SET TAGS ('dbx_business_glossary_term' = 'Compensation Type');
ALTER TABLE `advertising_ecm`.`brand`.`brand_spokesperson` ALTER COLUMN `compensation_type` SET TAGS ('dbx_value_regex' = 'salaried|per_appearance|retainer|equity|pro_bono|volunteer');
ALTER TABLE `advertising_ecm`.`brand`.`brand_spokesperson` ALTER COLUMN `compensation_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`brand_spokesperson` ALTER COLUMN `conflict_of_interest_check_date` SET TAGS ('dbx_business_glossary_term' = 'Conflict of Interest Check Date');
ALTER TABLE `advertising_ecm`.`brand`.`brand_spokesperson` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`brand`.`brand_spokesperson` ALTER COLUMN `crisis_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Crisis Contact Name');
ALTER TABLE `advertising_ecm`.`brand`.`brand_spokesperson` ALTER COLUMN `crisis_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`brand_spokesperson` ALTER COLUMN `crisis_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Crisis Contact Phone Number');
ALTER TABLE `advertising_ecm`.`brand`.`brand_spokesperson` ALTER COLUMN `crisis_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`brand_spokesperson` ALTER COLUMN `crisis_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`brand_spokesperson` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Spokesperson Email Address');
ALTER TABLE `advertising_ecm`.`brand`.`brand_spokesperson` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `advertising_ecm`.`brand`.`brand_spokesperson` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`brand_spokesperson` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`brand_spokesperson` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `advertising_ecm`.`brand`.`brand_spokesperson` ALTER COLUMN `headshot_url` SET TAGS ('dbx_business_glossary_term' = 'Headshot Image Uniform Resource Locator (URL)');
ALTER TABLE `advertising_ecm`.`brand`.`brand_spokesperson` ALTER COLUMN `media_training_date` SET TAGS ('dbx_business_glossary_term' = 'Media Training Completion Date');
ALTER TABLE `advertising_ecm`.`brand`.`brand_spokesperson` ALTER COLUMN `media_training_status` SET TAGS ('dbx_business_glossary_term' = 'Media Training Status');
ALTER TABLE `advertising_ecm`.`brand`.`brand_spokesperson` ALTER COLUMN `media_training_status` SET TAGS ('dbx_value_regex' = 'completed|in_progress|not_started|expired');
ALTER TABLE `advertising_ecm`.`brand`.`brand_spokesperson` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `advertising_ecm`.`brand`.`brand_spokesperson` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Spokesperson Notes');
ALTER TABLE `advertising_ecm`.`brand`.`brand_spokesperson` ALTER COLUMN `organization` SET TAGS ('dbx_business_glossary_term' = 'Spokesperson Organization');
ALTER TABLE `advertising_ecm`.`brand`.`brand_spokesperson` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Spokesperson Phone Number');
ALTER TABLE `advertising_ecm`.`brand`.`brand_spokesperson` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`brand_spokesperson` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`brand_spokesperson` ALTER COLUMN `restricted_topics` SET TAGS ('dbx_business_glossary_term' = 'Restricted Topics List');
ALTER TABLE `advertising_ecm`.`brand`.`brand_spokesperson` ALTER COLUMN `social_media_handles` SET TAGS ('dbx_business_glossary_term' = 'Social Media Handles');
ALTER TABLE `advertising_ecm`.`brand`.`brand_spokesperson` ALTER COLUMN `spokesperson_name` SET TAGS ('dbx_business_glossary_term' = 'Spokesperson Full Name');
ALTER TABLE `advertising_ecm`.`brand`.`brand_spokesperson` ALTER COLUMN `spokesperson_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`brand_spokesperson` ALTER COLUMN `spokesperson_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`brand_spokesperson` ALTER COLUMN `spokesperson_type` SET TAGS ('dbx_business_glossary_term' = 'Spokesperson Type');
ALTER TABLE `advertising_ecm`.`brand`.`brand_spokesperson` ALTER COLUMN `spokesperson_type` SET TAGS ('dbx_value_regex' = 'executive|celebrity|influencer|subject_matter_expert|brand_ambassador|employee');
ALTER TABLE `advertising_ecm`.`brand`.`brand_spokesperson` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Spokesperson Title');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_brand` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_brand` SET TAGS ('dbx_subdomain' = 'competitive_intelligence');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_brand` ALTER COLUMN `competitive_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Competitive Brand Identifier (ID)');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_brand` ALTER COLUMN `brand_archetype` SET TAGS ('dbx_business_glossary_term' = 'Brand Archetype Classification');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_brand` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Competitor Brand Name');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_brand` ALTER COLUMN `brand_positioning_statement` SET TAGS ('dbx_business_glossary_term' = 'Brand Positioning Statement');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_brand` ALTER COLUMN `brand_positioning_statement` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_brand` ALTER COLUMN `brand_sentiment_score` SET TAGS ('dbx_business_glossary_term' = 'Brand Sentiment Score');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_brand` ALTER COLUMN `brand_website_url` SET TAGS ('dbx_business_glossary_term' = 'Brand Website Uniform Resource Locator (URL)');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_brand` ALTER COLUMN `competitive_differentiation_factors` SET TAGS ('dbx_business_glossary_term' = 'Competitive Differentiation Factors');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_brand` ALTER COLUMN `competitive_threat_level` SET TAGS ('dbx_business_glossary_term' = 'Competitive Threat Level');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_brand` ALTER COLUMN `competitive_threat_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|minimal');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_brand` ALTER COLUMN `comscore_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Comscore Entity Identifier (ID)');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_brand` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_brand` ALTER COLUMN `data_source_systems` SET TAGS ('dbx_business_glossary_term' = 'Data Source Systems');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_brand` ALTER COLUMN `estimated_annual_ad_spend_tier` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Advertising (Ad) Spend Tier');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_brand` ALTER COLUMN `estimated_annual_ad_spend_tier` SET TAGS ('dbx_value_regex' = 'tier_1_10m_plus|tier_2_5m_to_10m|tier_3_1m_to_5m|tier_4_500k_to_1m|tier_5_under_500k|unknown');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_brand` ALTER COLUMN `estimated_annual_ad_spend_tier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_brand` ALTER COLUMN `estimated_brand_awareness_percentage` SET TAGS ('dbx_business_glossary_term' = 'Estimated Brand Awareness Percentage');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_brand` ALTER COLUMN `estimated_brand_awareness_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_brand` ALTER COLUMN `industry_vertical` SET TAGS ('dbx_business_glossary_term' = 'Industry Vertical');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_brand` ALTER COLUMN `key_messaging_themes` SET TAGS ('dbx_business_glossary_term' = 'Key Messaging Themes');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_brand` ALTER COLUMN `known_agency_relationships` SET TAGS ('dbx_business_glossary_term' = 'Known Agency Relationships');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_brand` ALTER COLUMN `known_agency_relationships` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_brand` ALTER COLUMN `last_intelligence_update_date` SET TAGS ('dbx_business_glossary_term' = 'Last Intelligence Update Date');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_brand` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_brand` ALTER COLUMN `media_mix_strategy` SET TAGS ('dbx_business_glossary_term' = 'Media Mix Strategy');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_brand` ALTER COLUMN `media_mix_strategy` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_brand` ALTER COLUMN `monitoring_start_date` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Start Date');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_brand` ALTER COLUMN `monitoring_status` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Status');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_brand` ALTER COLUMN `monitoring_status` SET TAGS ('dbx_value_regex' = 'active|paused|archived|pending_activation');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_brand` ALTER COLUMN `nielsen_ad_intel_competitor_code` SET TAGS ('dbx_business_glossary_term' = 'Nielsen Ad Intel Competitor Identifier (ID)');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_brand` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Competitive Intelligence Notes');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_brand` ALTER COLUMN `nps_benchmark_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Benchmark');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_brand` ALTER COLUMN `nps_benchmark_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_brand` ALTER COLUMN `parent_company_name` SET TAGS ('dbx_business_glossary_term' = 'Parent Company Name');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_brand` ALTER COLUMN `primary_markets` SET TAGS ('dbx_business_glossary_term' = 'Primary Geographic Markets');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_brand` ALTER COLUMN `primary_media_channels` SET TAGS ('dbx_business_glossary_term' = 'Primary Media Channels');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_brand` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_brand` ALTER COLUMN `recent_campaign_themes` SET TAGS ('dbx_business_glossary_term' = 'Recent Campaign Themes');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_brand` ALTER COLUMN `social_media_handles` SET TAGS ('dbx_business_glossary_term' = 'Social Media Handles');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_brand` ALTER COLUMN `target_audience_segments` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Segments');
ALTER TABLE `advertising_ecm`.`brand`.`crisis_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`brand`.`crisis_event` SET TAGS ('dbx_subdomain' = 'public_relations');
ALTER TABLE `advertising_ecm`.`brand`.`crisis_event` ALTER COLUMN `crisis_event_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Crisis Event ID');
ALTER TABLE `advertising_ecm`.`brand`.`crisis_event` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`brand`.`crisis_event` ALTER COLUMN `client_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brand ID');
ALTER TABLE `advertising_ecm`.`brand`.`crisis_event` ALTER COLUMN `insight_report_id` SET TAGS ('dbx_business_glossary_term' = 'Insight Report Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`brand`.`crisis_event` ALTER COLUMN `pr_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Pr Campaign Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`brand`.`crisis_event` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Crisis Lead ID');
ALTER TABLE `advertising_ecm`.`brand`.`crisis_event` ALTER COLUMN `affected_markets` SET TAGS ('dbx_business_glossary_term' = 'Affected Markets');
ALTER TABLE `advertising_ecm`.`brand`.`crisis_event` ALTER COLUMN `brand_awareness_impact_pct` SET TAGS ('dbx_business_glossary_term' = 'Brand Awareness Impact Percentage');
ALTER TABLE `advertising_ecm`.`brand`.`crisis_event` ALTER COLUMN `communication_channels_used` SET TAGS ('dbx_business_glossary_term' = 'Communication Channels Used');
ALTER TABLE `advertising_ecm`.`brand`.`crisis_event` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan');
ALTER TABLE `advertising_ecm`.`brand`.`crisis_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`brand`.`crisis_event` ALTER COLUMN `crisis_name` SET TAGS ('dbx_business_glossary_term' = 'Crisis Name');
ALTER TABLE `advertising_ecm`.`brand`.`crisis_event` ALTER COLUMN `crisis_status` SET TAGS ('dbx_business_glossary_term' = 'Crisis Status');
ALTER TABLE `advertising_ecm`.`brand`.`crisis_event` ALTER COLUMN `crisis_status` SET TAGS ('dbx_value_regex' = 'monitoring|active|contained|resolved');
ALTER TABLE `advertising_ecm`.`brand`.`crisis_event` ALTER COLUMN `crisis_type` SET TAGS ('dbx_business_glossary_term' = 'Crisis Type');
ALTER TABLE `advertising_ecm`.`brand`.`crisis_event` ALTER COLUMN `crisis_type` SET TAGS ('dbx_value_regex' = 'product_recall|executive_misconduct|social_media_backlash|regulatory_action|data_breach|competitive_attack');
ALTER TABLE `advertising_ecm`.`brand`.`crisis_event` ALTER COLUMN `detection_source` SET TAGS ('dbx_business_glossary_term' = 'Detection Source');
ALTER TABLE `advertising_ecm`.`brand`.`crisis_event` ALTER COLUMN `detection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detection Timestamp');
ALTER TABLE `advertising_ecm`.`brand`.`crisis_event` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Escalation Timestamp');
ALTER TABLE `advertising_ecm`.`brand`.`crisis_event` ALTER COLUMN `estimated_reach` SET TAGS ('dbx_business_glossary_term' = 'Estimated Reach');
ALTER TABLE `advertising_ecm`.`brand`.`crisis_event` ALTER COLUMN `financial_impact_estimate` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Estimate');
ALTER TABLE `advertising_ecm`.`brand`.`crisis_event` ALTER COLUMN `financial_impact_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`crisis_event` ALTER COLUMN `holding_statement_reference` SET TAGS ('dbx_business_glossary_term' = 'Holding Statement Reference');
ALTER TABLE `advertising_ecm`.`brand`.`crisis_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `advertising_ecm`.`brand`.`crisis_event` ALTER COLUMN `legal_action_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Action Flag');
ALTER TABLE `advertising_ecm`.`brand`.`crisis_event` ALTER COLUMN `media_mentions_count` SET TAGS ('dbx_business_glossary_term' = 'Media Mentions Count');
ALTER TABLE `advertising_ecm`.`brand`.`crisis_event` ALTER COLUMN `nps_impact_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Impact Score');
ALTER TABLE `advertising_ecm`.`brand`.`crisis_event` ALTER COLUMN `post_crisis_impact_assessment_flag` SET TAGS ('dbx_business_glossary_term' = 'Post-Crisis Impact Assessment Flag');
ALTER TABLE `advertising_ecm`.`brand`.`crisis_event` ALTER COLUMN `regulatory_body_involved` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body Involved');
ALTER TABLE `advertising_ecm`.`brand`.`crisis_event` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `advertising_ecm`.`brand`.`crisis_event` ALTER COLUMN `response_strategy_type` SET TAGS ('dbx_business_glossary_term' = 'Response Strategy Type');
ALTER TABLE `advertising_ecm`.`brand`.`crisis_event` ALTER COLUMN `response_team_size` SET TAGS ('dbx_business_glossary_term' = 'Response Team Size');
ALTER TABLE `advertising_ecm`.`brand`.`crisis_event` ALTER COLUMN `root_cause_summary` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Summary');
ALTER TABLE `advertising_ecm`.`brand`.`crisis_event` ALTER COLUMN `sentiment_score` SET TAGS ('dbx_business_glossary_term' = 'Sentiment Score');
ALTER TABLE `advertising_ecm`.`brand`.`crisis_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `advertising_ecm`.`brand`.`crisis_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'P1|P2|P3|P4');
ALTER TABLE `advertising_ecm`.`brand`.`crisis_event` ALTER COLUMN `social_media_volume` SET TAGS ('dbx_business_glossary_term' = 'Social Media Volume');
ALTER TABLE `advertising_ecm`.`brand`.`crisis_event` ALTER COLUMN `stakeholder_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Notification Timestamp');
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` SET TAGS ('dbx_subdomain' = 'public_relations');
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ALTER COLUMN `brand_compliance_check_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Compliance Check ID');
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ALTER COLUMN `brand_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Asset Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ALTER COLUMN `client_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brand ID');
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ALTER COLUMN `guideline_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Guideline Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ALTER COLUMN `partnership_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Partnership Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ALTER COLUMN `pr_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Pr Campaign Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ALTER COLUMN `previous_check_brand_compliance_check_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Check ID');
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ALTER COLUMN `primary_brand_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer ID');
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Number');
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ALTER COLUMN `check_number` SET TAGS ('dbx_value_regex' = '^BCC-[0-9]{8}$');
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ALTER COLUMN `compliance_outcome` SET TAGS ('dbx_business_glossary_term' = 'Compliance Outcome');
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ALTER COLUMN `compliance_outcome` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|conditionally_approved|requires_revision|approved_with_notes');
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ALTER COLUMN `item_identifier` SET TAGS ('dbx_business_glossary_term' = 'Item Identifier');
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ALTER COLUMN `item_title` SET TAGS ('dbx_business_glossary_term' = 'Item Title');
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ALTER COLUMN `item_type` SET TAGS ('dbx_business_glossary_term' = 'Item Type Under Review');
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ALTER COLUMN `partner_brand_name` SET TAGS ('dbx_business_glossary_term' = 'Partner Brand Name');
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ALTER COLUMN `partnership_type` SET TAGS ('dbx_business_glossary_term' = 'Partnership Type');
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ALTER COLUMN `partnership_type` SET TAGS ('dbx_value_regex' = 'co_branding|sponsorship|influencer|affiliate|none');
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ALTER COLUMN `remediation_deadline` SET TAGS ('dbx_business_glossary_term' = 'Remediation Deadline');
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ALTER COLUMN `remediation_notes` SET TAGS ('dbx_business_glossary_term' = 'Remediation Notes');
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ALTER COLUMN `remediation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Remediation Required Flag');
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ALTER COLUMN `resubmission_count` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Count');
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ALTER COLUMN `review_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Review Duration (Minutes)');
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ALTER COLUMN `review_priority` SET TAGS ('dbx_business_glossary_term' = 'Review Priority');
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ALTER COLUMN `review_priority` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'pending|in_review|compliant|non_compliant|conditionally_approved|rejected');
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ALTER COLUMN `review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Timestamp');
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ALTER COLUMN `reviewer_comments` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Comments');
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ALTER COLUMN `sign_off_date` SET TAGS ('dbx_business_glossary_term' = 'Sign-Off Date');
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ALTER COLUMN `sign_off_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Sign-Off Timestamp');
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ALTER COLUMN `violation_severity` SET TAGS ('dbx_business_glossary_term' = 'Violation Severity');
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ALTER COLUMN `violation_severity` SET TAGS ('dbx_value_regex' = 'critical|major|minor|advisory');
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ALTER COLUMN `violations_identified` SET TAGS ('dbx_business_glossary_term' = 'Violations Identified');
ALTER TABLE `advertising_ecm`.`brand`.`architecture` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`brand`.`architecture` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ALTER COLUMN `architecture_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Architecture ID');
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Brand ID');
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ALTER COLUMN `client_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brand ID');
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ALTER COLUMN `guideline_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Guideline Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Workfront Project ID');
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ALTER COLUMN `superseded_by_architecture_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By ID');
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Strategist ID');
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ALTER COLUMN `parent_architecture_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|revision_required');
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ALTER COLUMN `architecture_code` SET TAGS ('dbx_business_glossary_term' = 'Brand Architecture Code');
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ALTER COLUMN `architecture_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Architecture Name');
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ALTER COLUMN `architecture_status` SET TAGS ('dbx_business_glossary_term' = 'Brand Architecture Status');
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ALTER COLUMN `architecture_status` SET TAGS ('dbx_value_regex' = 'active|planned|deprecated|archived|under_review');
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ALTER COLUMN `architecture_type` SET TAGS ('dbx_business_glossary_term' = 'Brand Architecture Type');
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ALTER COLUMN `architecture_type` SET TAGS ('dbx_value_regex' = 'branded_house|house_of_brands|endorsed|hybrid|sub_brand|monolithic');
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ALTER COLUMN `brand_equity_contribution_score` SET TAGS ('dbx_business_glossary_term' = 'Brand Equity Contribution Score');
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ALTER COLUMN `brand_role` SET TAGS ('dbx_business_glossary_term' = 'Brand Role');
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ALTER COLUMN `brand_role` SET TAGS ('dbx_value_regex' = 'master_brand|sub_brand|endorsed_brand|ingredient_brand|flanker_brand|product_brand');
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ALTER COLUMN `channel_applicability` SET TAGS ('dbx_business_glossary_term' = 'Channel Applicability');
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ALTER COLUMN `co_branding_allowed` SET TAGS ('dbx_business_glossary_term' = 'Co-Branding Allowed Flag');
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Architecture Effective Date');
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ALTER COLUMN `endorsement_strength` SET TAGS ('dbx_business_glossary_term' = 'Brand Endorsement Strength');
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ALTER COLUMN `endorsement_strength` SET TAGS ('dbx_value_regex' = 'strong|moderate|weak|none');
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Architecture Expiry Date');
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Brand Hierarchy Level');
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ALTER COLUMN `is_global_master` SET TAGS ('dbx_business_glossary_term' = 'Is Global Master Flag');
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ALTER COLUMN `market_positioning_differentiation` SET TAGS ('dbx_business_glossary_term' = 'Market Positioning Differentiation');
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Architecture Notes');
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ALTER COLUMN `portfolio_strategy_rationale` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Strategy Rationale');
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ALTER COLUMN `product_category_scope` SET TAGS ('dbx_business_glossary_term' = 'Product Category Scope');
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Brand Relationship Type');
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ALTER COLUMN `relationship_type` SET TAGS ('dbx_value_regex' = 'parent_child|sibling|endorsed|ingredient|extension');
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ALTER COLUMN `review_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle Months');
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ALTER COLUMN `target_audience_overlap_pct` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Overlap Percentage');
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ALTER COLUMN `visual_connection_level` SET TAGS ('dbx_business_glossary_term' = 'Visual Connection Level');
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ALTER COLUMN `visual_connection_level` SET TAGS ('dbx_value_regex' = 'identical|strong|moderate|minimal|independent');
ALTER TABLE `advertising_ecm`.`brand`.`partnership` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`brand`.`partnership` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ALTER COLUMN `partnership_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Partnership Identifier (ID)');
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Identifier (ID)');
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ALTER COLUMN `audience_insight_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Insight Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ALTER COLUMN `client_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brand Identifier (ID)');
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Lead Identifier (ID)');
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ALTER COLUMN `reciprocal_partnership_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ALTER COLUMN `actual_brand_awareness_lift_pct` SET TAGS ('dbx_business_glossary_term' = 'Actual Brand Awareness Lift Percentage');
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ALTER COLUMN `actual_roi_percentage` SET TAGS ('dbx_business_glossary_term' = 'Actual Return on Investment (ROI) Percentage');
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending review|approved|rejected');
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ALTER COLUMN `approved_cobranded_asset_references` SET TAGS ('dbx_business_glossary_term' = 'Approved Co-Branded Asset References');
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ALTER COLUMN `brand_fit_score` SET TAGS ('dbx_business_glossary_term' = 'Brand Fit Score');
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ALTER COLUMN `channel_scope` SET TAGS ('dbx_business_glossary_term' = 'Channel Scope');
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ALTER COLUMN `compliance_check_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Required Flag');
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference');
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ALTER COLUMN `contract_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ALTER COLUMN `exclusivity_category` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Category');
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ALTER COLUMN `last_compliance_check_date` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Check Date');
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ALTER COLUMN `market_scope` SET TAGS ('dbx_business_glossary_term' = 'Market Scope');
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ALTER COLUMN `objective` SET TAGS ('dbx_business_glossary_term' = 'Partnership Objective');
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ALTER COLUMN `partner_brand_name` SET TAGS ('dbx_business_glossary_term' = 'Partner Brand Name');
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ALTER COLUMN `partner_company_name` SET TAGS ('dbx_business_glossary_term' = 'Partner Company Name');
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ALTER COLUMN `partnership_code` SET TAGS ('dbx_business_glossary_term' = 'Partnership Code');
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ALTER COLUMN `partnership_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ALTER COLUMN `partnership_name` SET TAGS ('dbx_business_glossary_term' = 'Partnership Name');
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ALTER COLUMN `partnership_status` SET TAGS ('dbx_business_glossary_term' = 'Partnership Status');
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ALTER COLUMN `partnership_status` SET TAGS ('dbx_value_regex' = 'proposed|negotiation|active|paused|terminated|expired');
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ALTER COLUMN `partnership_type` SET TAGS ('dbx_business_glossary_term' = 'Partnership Type');
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ALTER COLUMN `partnership_type` SET TAGS ('dbx_value_regex' = 'co-branding|licensing|sponsorship|ingredient branding|brand alliance|joint venture');
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ALTER COLUMN `revenue_share_model` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Model');
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ALTER COLUMN `revenue_share_model` SET TAGS ('dbx_value_regex' = 'fixed fee|percentage split|tiered|hybrid|none');
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ALTER COLUMN `revenue_share_model` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ALTER COLUMN `target_audience_overlap_pct` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Overlap Percentage');
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ALTER COLUMN `target_brand_awareness_lift_pct` SET TAGS ('dbx_business_glossary_term' = 'Target Brand Awareness Lift Percentage');
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ALTER COLUMN `target_roi_percentage` SET TAGS ('dbx_business_glossary_term' = 'Target Return on Investment (ROI) Percentage');
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_monitoring` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_monitoring` SET TAGS ('dbx_subdomain' = 'competitive_intelligence');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_monitoring` SET TAGS ('dbx_association_edges' = 'brand.brand_profile,brand.competitive_brand');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_monitoring` ALTER COLUMN `competitive_monitoring_id` SET TAGS ('dbx_business_glossary_term' = 'Competitive Monitoring Assignment Identifier');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_monitoring` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brand Identifier');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_monitoring` ALTER COLUMN `competitive_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Competitive Monitoring - Competitive Brand Id');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_monitoring` ALTER COLUMN `profile_brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Competitive Monitoring - Brand Profile Id');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_monitoring` ALTER COLUMN `competitive_rank` SET TAGS ('dbx_business_glossary_term' = 'Competitive Priority Rank');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_monitoring` ALTER COLUMN `competitive_threat_level` SET TAGS ('dbx_business_glossary_term' = 'Competitive Threat Assessment Level');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_monitoring` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_monitoring` ALTER COLUMN `last_intelligence_update_date` SET TAGS ('dbx_business_glossary_term' = 'Last Intelligence Update Date');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_monitoring` ALTER COLUMN `monitoring_cadence` SET TAGS ('dbx_business_glossary_term' = 'Intelligence Update Cadence');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_monitoring` ALTER COLUMN `monitoring_start_date` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Assignment Start Date');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_monitoring` ALTER COLUMN `monitoring_status` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Assignment Status');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_monitoring` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Assignment Notes');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_monitoring` ALTER COLUMN `sov_comparison_enabled` SET TAGS ('dbx_business_glossary_term' = 'Share of Voice Comparison Flag');
ALTER TABLE `advertising_ecm`.`brand`.`competitive_monitoring` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `advertising_ecm`.`brand`.`asset_deployment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `advertising_ecm`.`brand`.`asset_deployment` SET TAGS ('dbx_subdomain' = 'public_relations');
ALTER TABLE `advertising_ecm`.`brand`.`asset_deployment` SET TAGS ('dbx_association_edges' = 'brand.brand_asset,brand.pr_campaign');
ALTER TABLE `advertising_ecm`.`brand`.`asset_deployment` ALTER COLUMN `asset_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Deployment Identifier');
ALTER TABLE `advertising_ecm`.`brand`.`asset_deployment` ALTER COLUMN `brand_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Deployment - Brand Asset Id');
ALTER TABLE `advertising_ecm`.`brand`.`asset_deployment` ALTER COLUMN `pr_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Deployment - Pr Campaign Id');
ALTER TABLE `advertising_ecm`.`brand`.`asset_deployment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Deployment Approval Status');
ALTER TABLE `advertising_ecm`.`brand`.`asset_deployment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Deployment Approver');
ALTER TABLE `advertising_ecm`.`brand`.`asset_deployment` ALTER COLUMN `asset_performance_score` SET TAGS ('dbx_business_glossary_term' = 'Asset Performance Score');
ALTER TABLE `advertising_ecm`.`brand`.`asset_deployment` ALTER COLUMN `deployment_date` SET TAGS ('dbx_business_glossary_term' = 'Deployment Date');
ALTER TABLE `advertising_ecm`.`brand`.`asset_deployment` ALTER COLUMN `deployment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Deployment End Date');
ALTER TABLE `advertising_ecm`.`brand`.`asset_deployment` ALTER COLUMN `media_placement_count` SET TAGS ('dbx_business_glossary_term' = 'Media Placement Count');
ALTER TABLE `advertising_ecm`.`brand`.`asset_deployment` ALTER COLUMN `usage_context` SET TAGS ('dbx_business_glossary_term' = 'Usage Context');
ALTER TABLE `advertising_ecm`.`brand`.`asset_deployment` ALTER COLUMN `usage_notes` SET TAGS ('dbx_business_glossary_term' = 'Deployment Usage Notes');
ALTER TABLE `advertising_ecm`.`brand`.`advertiser_policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`brand`.`advertiser_policy` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `advertising_ecm`.`brand`.`advertiser_policy` ALTER COLUMN `advertiser_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Policy Identifier');
ALTER TABLE `advertising_ecm`.`brand`.`advertiser_policy` ALTER COLUMN `superseded_advertiser_policy_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`advertiser_policy` ALTER COLUMN `notification_recipients` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`brand`.`advertiser_policy` ALTER COLUMN `notification_recipients` SET TAGS ('dbx_pii_email' = 'true');
