-- Schema for Domain: content | Business: Gaming | Version: v1_mvm
-- Generated on: 2026-05-08 09:46:25

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `gaming_ecm`.`content` COMMENT 'Owns the digital asset pipeline for all in-game content: art assets, audio, localization strings, level/map data, NPC definitions, textures, and UGC moderation queues. Manages LOD asset variants, content versioning in Perforce Helix Core, live-ops content drops (seasonal events, patches, hotfixes), and asset lifecycle from creation to deployment. Distinct from title: title owns the product catalog; content owns the asset and creative deliverable layer.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `gaming_ecm`.`content`.`asset` (
    `asset_id` BIGINT COMMENT 'Primary key for asset',
    `age_rating_cert_id` BIGINT COMMENT 'Foreign key linking to compliance.age_rating_cert. Business justification: Assets (textures, audio, models) are evaluated by rating authorities for content descriptors (violence, language, sexual content). Asset approval gates require rating impact assessment before producti',
    `game_server_id` BIGINT COMMENT 'Foreign key linking to infrastructure.game_server. Business justification: Game servers load specific asset versions at runtime. Operations teams track which assets are deployed to which servers for performance troubleshooting, rollback coordination, and version mismatch dia',
    `game_studio_id` BIGINT COMMENT 'Identifier of the game development studio or team that created or owns the asset. Links to the Studio domain for organizational tracking.',
    `game_title_id` BIGINT COMMENT 'Identifier of the game title or project for which the asset was created. Links to the Game Title domain for product-level tracking.',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: Game assets (textures, models, audio) frequently embed licensed IP (middleware SDKs, music tracks, brand logos). IP clearance tracking is mandatory for platform certification, rating board submissions',
    `parent_asset_id` BIGINT COMMENT 'Reference to the parent or base asset ID if this asset is a variant (LOD variant, locale variant, platform variant). Null for base assets.',
    `repo_id` BIGINT COMMENT 'Foreign key linking to studio.repo. Business justification: Assets are version-controlled in Perforce depots (repos). Asset pipeline management and IP audit trails require knowing which repo an asset originates from. asset.perforce_depot_path is a denormalized',
    `approval_date` DATE COMMENT 'Date when the asset was approved for production use by QA (Quality Assurance) or content review team.',
    `asset_code` STRING COMMENT 'Unique business identifier or SKU (Stock Keeping Unit) for the asset used across development tools and pipelines.',
    `asset_description` STRING COMMENT 'Detailed textual description of the asset including its purpose, visual or audio characteristics, and usage notes for developers and artists.',
    `asset_name` STRING COMMENT 'Human-readable name of the digital asset as it appears in the content management system and game engine.',
    `asset_type` STRING COMMENT 'Classification of the digital asset by its primary content type in the game development pipeline. [ENUM-REF-CANDIDATE: art|audio|texture|mesh|animation|shader|vfx|ui_element|video|script — 10 candidates stripped; promote to reference product]',
    `audio_bit_depth` STRING COMMENT 'Bit depth for audio assets (e.g., 16, 24). Applicable only to audio asset types. Affects dynamic range and audio fidelity.',
    `audio_channel_config` STRING COMMENT 'Channel configuration for audio assets (mono, stereo, 5.1 surround, 7.1 surround, Dolby Atmos). Applicable only to audio asset types.. Valid values are `mono|stereo|5.1|7.1|atmos`',
    `audio_middleware_format` STRING COMMENT 'Audio middleware system format for the asset (Wwise, FMOD, Unity Audio, Unreal Audio, proprietary). Applicable only to audio asset types.. Valid values are `wwise|fmod|unity_audio|unreal_audio|proprietary`',
    `audio_sample_rate_hz` STRING COMMENT 'Sample rate in Hertz for audio assets (e.g., 44100, 48000). Applicable only to audio asset types. Determines audio quality and file size.',
    `cdn_url` STRING COMMENT 'CDN (Content Delivery Network) URL or endpoint where the asset is hosted for distribution to players. Used for live-ops content delivery and patches.',
    `classification_tags` STRING COMMENT 'Comma-separated or pipe-separated tags for categorizing the asset by genre, art style, feature area, platform, sensitivity, or other business dimensions. Enables search and filtering.',
    `content_hash` STRING COMMENT 'Cryptographic hash (e.g., SHA-256) of the asset file content for integrity verification, deduplication, and change detection.',
    `deprecated_date` DATE COMMENT 'Date when the asset was marked as deprecated and scheduled for removal from active use.',
    `download_count` BIGINT COMMENT 'Total number of times the asset has been downloaded by players or distributed via CDN (Content Delivery Network). Applicable for DLC (Downloadable Content) and live-ops content drops.',
    `drm_protected` BOOLEAN COMMENT 'Boolean flag indicating whether the asset is protected by DRM (Digital Rights Management) technology (True) or is unprotected (False).',
    `engine_compatibility` STRING COMMENT 'Game engine(s) with which this asset is compatible (Unity, Unreal Engine, proprietary engine, or cross-engine).. Valid values are `unity|unreal|proprietary|cross_engine`',
    `feature_area` STRING COMMENT 'Game feature or system area where the asset is used (e.g., combat, UI, environment, character, vehicle). Aligns with game design documentation.',
    `file_size_bytes` BIGINT COMMENT 'Size of the asset file in bytes. Critical for build optimization, CDN (Content Delivery Network) distribution planning, and platform certification compliance.',
    `format` STRING COMMENT 'File format or extension of the asset (e.g., PNG, FBX, WAV, MP4, JSON). Determines compatibility with game engines and platforms.',
    `ip_rights_status` STRING COMMENT 'Intellectual Property (IP) rights status of the asset indicating ownership or licensing arrangement (owned, licensed, third-party, public domain, pending clearance).. Valid values are `owned|licensed|third_party|public_domain|pending`',
    `is_locale_variant` BOOLEAN COMMENT 'Boolean flag indicating whether this asset is a locale-specific variant (True) or a locale-agnostic base asset (False).',
    `last_modified_date` DATE COMMENT 'Date when the asset was last modified or updated in the content pipeline.',
    `license_expiry_date` DATE COMMENT 'Expiration date for licensed third-party assets. Null for owned or perpetual-license assets. Critical for compliance and content continuity.',
    `lifecycle_status` STRING COMMENT 'Current state of the asset in its content lifecycle from creation through deployment to retirement.. Valid values are `draft|review|approved|published|deprecated|archived`',
    `lod_tier` STRING COMMENT 'LOD (Level of Detail) tier indicating the quality/complexity variant of the asset for performance optimization across different hardware capabilities.. Valid values are `lod0|lod1|lod2|lod3|lod4|lod5`',
    `moderation_status` STRING COMMENT 'Moderation review status for UGC (User-Generated Content) assets. Tracks whether the asset has passed content moderation and compliance checks.. Valid values are `pending|approved|rejected|flagged|under_review`',
    `platform_target` STRING COMMENT 'Target platform(s) for which this asset variant is optimized (e.g., PC, PlayStation, Xbox, Nintendo Switch, iOS, Android). Multiple platforms may be pipe-separated. [ENUM-REF-CANDIDATE: pc|playstation|xbox|nintendo_switch|ios|android|web|vr|ar — promote to reference product]',
    `published_date` DATE COMMENT 'Date when the asset was published to live game builds or made available for deployment.',
    `resolution_spec` STRING COMMENT 'Resolution or quality specification for visual and audio assets (e.g., 1920x1080, 4K, 48kHz/16-bit). Used for LOD (Level of Detail) management and platform targeting.',
    `supported_locales` STRING COMMENT 'Comma-separated or pipe-separated list of locale codes (e.g., en-US, fr-FR, ja-JP) for which this asset has localized variants or is applicable. Used for localization targeting.',
    `ugc_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this asset is User-Generated Content (UGC) created by players (True) or first-party content created by the studio (False).',
    `usage_count` STRING COMMENT 'Number of times the asset is referenced or used across game builds, levels, or scenes. Used for impact analysis and optimization decisions.',
    `version_number` STRING COMMENT 'Version identifier for the asset following semantic versioning or internal versioning scheme. Tracks iterations and revisions.',
    `creation_date` DATE COMMENT 'Date when the asset was first created or ingested into the content management system.',
    CONSTRAINT pk_asset PRIMARY KEY(`asset_id`)
) COMMENT 'Master record for every digital asset in the game content pipeline — art, audio, texture, mesh, animation, shader, VFX, UI element, video, and scripted data. Tracks asset name, type, format, file size, resolution/bitrate specs, LOD tier, platform target, engine compatibility (Unity/Unreal), creation date, author, current lifecycle status (draft, review, approved, deprecated), Perforce depot path, content hash for integrity verification, classification tags (genre, art style, feature area, platform, sensitivity), audio-specific metadata (sample rate, bit depth, channel config, middleware format like Wwise/FMOD), supported locale list, and locale-specific variant flags. This is the authoritative SSOT for all creative deliverables managed in Perforce Helix Core, including locale reference data for asset-level localization targeting.';

CREATE OR REPLACE TABLE `gaming_ecm`.`content`.`asset_version` (
    `asset_version_id` BIGINT COMMENT 'Unique identifier for this immutable asset version record. Primary key.',
    `asset_id` BIGINT COMMENT 'Reference to the parent digital asset entity that this version belongs to. Links to the master asset record across all its revisions.',
    `content_release_id` BIGINT COMMENT 'Reference to the live-ops content drop, seasonal event, patch, or hotfix release that this asset version is part of. Null for non-scheduled commits.',
    `game_studio_id` BIGINT COMMENT 'Reference to the development studio that created this asset version. Used for attribution and cross-studio asset sharing governance.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title that this asset version belongs to. Links asset to the product catalog.',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: Version control systems must track which licensed IP components (middleware versions, music stems) are embedded in each asset revision to support compliance audits, royalty reconciliation, and license',
    `repo_id` BIGINT COMMENT 'Foreign key linking to studio.repo. Business justification: asset_version tracks Perforce-specific attributes (depot_path, stream_path, changelist_number, branch_name) that denormalize the repo. A FK to studio.repo normalizes source control provenance, enablin',
    `rollback_from_version_id` BIGINT COMMENT 'Reference to the asset version that this version rolled back from during a live-ops incident. Null for normal forward progression. Used for incident analysis.',
    `asset_category` STRING COMMENT 'High-level classification of the asset type. Used for pipeline routing and build system processing. [ENUM-REF-CANDIDATE: texture|model|audio|animation|level|script|localization|ui|vfx|shader — 10 candidates stripped; promote to reference product]',
    `audio_duration_seconds` DECIMAL(18,2) COMMENT 'Duration of audio assets in seconds. Null for non-audio assets. Used for memory and streaming bandwidth planning.',
    `branch_name` STRING COMMENT 'Name of the Perforce branch or stream where this version was committed. Examples: main, dev, release/1.5, feature/new-character.',
    `build_error_message` STRING COMMENT 'Error message from the build pipeline if processing failed. Null for successful builds. Used for troubleshooting and QA.',
    `build_pipeline_status` STRING COMMENT 'Current status of the automated build pipeline processing for this asset version. Tracks whether the asset has been successfully compiled, optimized, and packaged.. Valid values are `pending|processing|success|failed|skipped`',
    `build_pipeline_timestamp` TIMESTAMP COMMENT 'Date and time when the build pipeline last processed this asset version. Null if not yet processed.',
    `cdn_distribution_status` STRING COMMENT 'Status of this asset versions distribution to CDN edge nodes for player download. Tracks global content propagation.. Valid values are `not_distributed|distributing|distributed|failed`',
    `cdn_distribution_timestamp` TIMESTAMP COMMENT 'Date and time when this asset version was successfully distributed to all CDN regions. Null if not yet distributed.',
    `change_description` STRING COMMENT 'Commit message provided by the author describing what was changed in this version. May include Jira ticket references, bug fix notes, or feature descriptions.',
    `changelist_number` BIGINT COMMENT 'Perforce Helix Core changelist number representing the atomic commit that introduced this asset version. Unique identifier for the commit transaction.',
    `checksum_md5` STRING COMMENT 'MD5 hash of the asset file content for integrity verification and duplicate detection. Used to validate file transfers and detect corruption.. Valid values are `^[a-f0-9]{32}$`',
    `commit_timestamp` TIMESTAMP COMMENT 'Exact date and time when this asset version was committed to Perforce Helix Core. Represents the business event time of the version creation.',
    `compression_format` STRING COMMENT 'Compression algorithm or format applied to this asset version. Examples: BC7, ASTC, Vorbis, Opus, LZ4. Null for uncompressed assets.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this asset version record was first created in the data lakehouse. Audit trail for data lineage.',
    `deprecated_timestamp` TIMESTAMP COMMENT 'Date and time when this asset version was marked as deprecated. Null if not deprecated.',
    `drm_protected` BOOLEAN COMMENT 'Indicates whether this asset version is protected by DRM encryption. True for premium DLC and licensed content requiring protection.',
    `file_size_bytes` BIGINT COMMENT 'Size of the asset file in bytes for this specific version. Used for storage capacity planning and CDN optimization.',
    `file_size_delta_bytes` BIGINT COMMENT 'Change in file size compared to the previous revision in bytes. Positive for growth, negative for reduction. Null for first revision.',
    `file_type` STRING COMMENT 'Perforce file type classification indicating how the file is stored and merged. Examples: text, binary, binary+l (exclusive lock), utf16.',
    `is_deprecated` BOOLEAN COMMENT 'Indicates whether this asset version has been marked as deprecated and should no longer be used in new builds. Used for asset lifecycle management.',
    `localization_language_code` STRING COMMENT 'ISO 639-1 language code (with optional ISO 3166-1 region) for localized assets. Examples: en, en-US, ja, pt-BR. Null for non-localized assets.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `lod_level` STRING COMMENT 'LOD variant level for this asset version. LOD0 is highest quality, higher numbers are progressively lower detail for performance optimization. None for non-LOD assets. [ENUM-REF-CANDIDATE: lod0|lod1|lod2|lod3|lod4|lod5|none — 7 candidates stripped; promote to reference product]',
    `platform_target` STRING COMMENT 'Target gaming platform for this asset version. Assets may be optimized differently per platform. Multi indicates cross-platform asset. [ENUM-REF-CANDIDATE: pc|ps5|ps4|xbox_series|xbox_one|switch|ios|android|web|multi — 10 candidates stripped; promote to reference product]',
    `polygon_count` STRING COMMENT 'Number of polygons (triangles) in 3D model assets. Null for non-model assets. Used for performance budgeting and LOD validation.',
    `promoted_to_live_timestamp` TIMESTAMP COMMENT 'Date and time when this asset version was deployed to the live production environment and became visible to players. Null if not yet live.',
    `promoted_to_staging_timestamp` TIMESTAMP COMMENT 'Date and time when this asset version was promoted to the staging environment for UAT. Null if not yet promoted.',
    `promotion_stage` STRING COMMENT 'Current deployment stage of this asset version in the content delivery lifecycle. Tracks progression from development through to live production.. Valid values are `dev|qa|staging|live|archived`',
    `revision_number` STRING COMMENT 'Sequential revision number for this asset file within its depot path. Increments with each commit to the same file.',
    `texture_resolution` STRING COMMENT 'Resolution of texture assets in pixels (e.g., 2048x2048, 4096x4096). Null for non-texture assets. Used for memory budget tracking.',
    `ugc_moderation_status` STRING COMMENT 'Moderation review status for user-generated content assets. None for first-party studio assets. Used to enforce community standards and COPPA compliance.. Valid values are `pending|approved|rejected|flagged|none`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this asset version record was last modified in the data lakehouse. Audit trail for data lineage.',
    CONSTRAINT pk_asset_version PRIMARY KEY(`asset_version_id`)
) COMMENT 'Immutable version record for each committed revision of a digital asset in Perforce Helix Core. Captures changelist number, depot path, revision number, branch/stream, commit author, commit timestamp, change description, file size delta, checksum, build pipeline status, and promotion stage (dev, staging, live). Enables full asset lineage tracing from first creation through live deployment and supports rollback operations during live-ops incidents.';

CREATE OR REPLACE TABLE `gaming_ecm`.`content`.`asset_bundle` (
    `asset_bundle_id` BIGINT COMMENT 'Unique identifier for the asset bundle. Primary key.',
    `age_rating_cert_id` BIGINT COMMENT 'Foreign key linking to compliance.age_rating_cert. Business justification: Bundles are the unit submitted to rating authorities for platform certification. TRC/TCR workflows require linking bundle builds to ESRB/PEGI submission records for audit trail and deployment gating.',
    `cdn_node_id` BIGINT COMMENT 'Foreign key linking to infrastructure.cdn_node. Business justification: Asset bundles are distributed via CDN nodes for player downloads. CDN operators track which bundles are cached on which nodes to optimize cache hit ratios, plan bandwidth allocation, and diagnose down',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: Asset bundles are packaged for specific content releases (DLC packs, seasonal events, patches). This FK links the bundle to its parent release record. N:1 cardinality - many bundles can be part of one',
    `game_studio_id` BIGINT COMMENT 'Foreign key reference to the development studio responsible for creating this asset bundle. Used for attribution and resource tracking.',
    `game_title_id` BIGINT COMMENT 'Foreign key reference to the game title (product catalog) that this asset bundle belongs to. Links the content layer to the title domain.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Bundles are geo-restricted for regulatory compliance (China content審查, Germany violence restrictions, Japan gacha regulations). CDN distribution teams enforce jurisdiction-specific bundle variants; op',
    `server_fleet_id` BIGINT COMMENT 'Foreign key linking to infrastructure.server_fleet. Business justification: Asset bundles are deployed to server fleets as atomic content units. Fleet operators track which bundle versions are active on each fleet to coordinate staged rollouts, diagnose version conflicts, and',
    `build_configuration` STRING COMMENT 'Build configuration type for the bundle: debug (internal testing with symbols), development (QA testing), shipping (release candidate), gold_master (final approved build for distribution).. Valid values are `debug|development|shipping|gold_master`',
    `bundle_code` STRING COMMENT 'Unique business identifier or SKU (Stock Keeping Unit) for the asset bundle used in distribution and tracking systems.',
    `bundle_name` STRING COMMENT 'Human-readable name of the asset bundle (e.g., Winter Event 2024, Patch 1.5.3, Console Launch DLC).',
    `bundle_status` STRING COMMENT 'Current lifecycle state of the asset bundle: draft (initial creation), in_development (active work), qa_testing (quality assurance review), approved (ready for release), published (live in production), deprecated (retired from use).. Valid values are `draft|in_development|qa_testing|approved|published|deprecated`',
    `bundle_type` STRING COMMENT 'Classification of the asset bundle by delivery purpose: base game (initial release), DLC (Downloadable Content), hotfix (urgent fix), patch (scheduled update), seasonal event (limited-time content), or expansion (major content addition).. Valid values are `base_game|dlc|hotfix|patch|seasonal_event|expansion`',
    `cdn_distribution_path` STRING COMMENT 'URL or path on the CDN where the asset bundle is hosted for player download. Business-confidential to prevent unauthorized direct access.',
    `compressed_size_mb` DECIMAL(18,2) COMMENT 'Total size of the asset bundle in megabytes after compression, used for CDN (Content Delivery Network) bandwidth planning and player download estimates.',
    `compression_format` STRING COMMENT 'Compression algorithm used for the bundle (e.g., zip, gzip, lz4, zstd, proprietary engine format).. Valid values are `zip|gzip|lz4|zstd|proprietary`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the asset bundle record was first created in the content management system. Used for audit trail and lifecycle tracking.',
    `deprecated_timestamp` TIMESTAMP COMMENT 'Timestamp when the asset bundle was deprecated and removed from active distribution. Null if still active.',
    `download_count` BIGINT COMMENT 'Total number of times this asset bundle has been downloaded by players. Used for analytics and content performance tracking.',
    `encryption_enabled` BOOLEAN COMMENT 'Indicates whether the asset bundle is encrypted to protect intellectual property (IP) and prevent unauthorized access or piracy. Aligns with DRM (Digital Rights Management) requirements.',
    `error_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of failed download attempts for this bundle, used to monitor CDN health and content delivery quality.',
    `expiration_date` DATE COMMENT 'Date when the asset bundle is scheduled to be removed or deprecated, typically for seasonal events or limited-time content. Null for permanent content.',
    `localization_languages` STRING COMMENT 'Comma-separated list of language codes (ISO 639-1) for which localization strings are included in this bundle (e.g., en,es,fr,de,ja,zh).',
    `lod_variant_included` BOOLEAN COMMENT 'Indicates whether this bundle includes multiple LOD (Level of Detail) variants of assets for performance optimization across different hardware tiers.',
    `manifest_hash` STRING COMMENT 'Cryptographic hash (e.g., SHA-256) of the bundle manifest file, used for integrity verification and version control in Perforce Helix Core and distribution systems.',
    `minimum_engine_version` STRING COMMENT 'Minimum version of the game engine (Unity, Unreal Engine, or proprietary) required to load and run this asset bundle. Ensures compatibility with the game client.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the asset bundle record was last modified. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text field for additional notes, release notes, known issues, or special instructions related to this asset bundle. Used for internal communication and documentation.',
    `priority_level` STRING COMMENT 'Business priority for this bundle release: critical (urgent hotfix), high (major patch or DLC), medium (seasonal event), low (minor update). Used for resource allocation and scheduling.. Valid values are `critical|high|medium|low`',
    `published_timestamp` TIMESTAMP COMMENT 'Timestamp when the asset bundle was published to production CDN and made available to players. Null if not yet published.',
    `release_date` DATE COMMENT 'Planned or actual date when the asset bundle was or will be released to players. Used for live operations (live-ops) scheduling and content roadmap planning.',
    `requires_player_consent` BOOLEAN COMMENT 'Indicates whether downloading this bundle requires explicit player consent due to size, data usage, or content nature. Aligns with GDPR (General Data Protection Regulation) and COPPA (Childrens Online Privacy Protection Act) requirements.',
    `target_platform` STRING COMMENT 'Platform(s) this bundle is built for, pipe-separated if multi-platform (e.g., PC, PlayStation 5, Xbox Series X|S, Nintendo Switch, iOS, Android). Aligns with first-party console manufacturer and mobile platform requirements.',
    `ugc_content_included` BOOLEAN COMMENT 'Indicates whether this bundle includes UGC (User-Generated Content) that has passed moderation review. Important for content policy compliance and community management.',
    `uncompressed_size_mb` DECIMAL(18,2) COMMENT 'Total size of the asset bundle in megabytes after decompression on the players device, used for storage requirement planning.',
    `version_number` STRING COMMENT 'Semantic version number of the asset bundle (e.g., 1.5.3, 2.0.0) used for tracking iterations and compatibility in Perforce Helix Core and CI/CD (Continuous Integration/Continuous Deployment) pipelines.',
    CONSTRAINT pk_asset_bundle PRIMARY KEY(`asset_bundle_id`)
) COMMENT 'Logical grouping of assets packaged together for a specific delivery unit — a DLC pack, seasonal event drop, patch, or platform build. Stores bundle name, bundle type (base game, DLC, hotfix, seasonal event, patch), target platform(s), total compressed size, compression format, encryption flag, CDN distribution path, minimum engine version, and bundle manifest hash. Distinct from the title SKU catalog (owned by the title domain); this entity owns the physical content packaging layer.';

CREATE OR REPLACE TABLE `gaming_ecm`.`content`.`localization_string` (
    `localization_string_id` BIGINT COMMENT 'Unique identifier for the localization string record. Primary key.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to content.asset. Business justification: Localization strings with voice-over (audio_vo_required = true) reference an audio asset. This FK links the string to its recorded VO asset, enabling asset lifecycle tracking and referential integrity',
    `game_title_id` BIGINT COMMENT 'Reference to the game title that this localization string belongs to. Links to the game title master record.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Strings must comply with jurisdiction-specific content laws (China censorship, Germany violence restrictions). Localization QA validates jurisdiction compliance before deployment; this link enables co',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Specific strings implement regulatory obligations: loot box odds disclosures (Belgium/Netherlands law), age verification prompts (COPPA), data collection notices (GDPR Article 13). Compliance teams fl',
    `approved_by` STRING COMMENT 'Username or identifier of the localization manager or lead who approved this string for final use. Null if not yet approved.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this string was approved for final use. Null if not yet approved.',
    `audio_vo_required` BOOLEAN COMMENT 'Indicates whether this string requires voice-over audio recording for localization. True for dialogue and narrative strings; false for UI labels and system messages.',
    `character_limit` STRING COMMENT 'Maximum number of characters allowed for this string to fit within UI constraints or subtitle timing. Null if no limit applies.',
    `content_warning_flags` STRING COMMENT 'Comma-separated list of content warning categories applicable to this string (e.g., violence,profanity,drug_reference). Used for age rating and content filtering.',
    `context_notes` STRING COMMENT 'Contextual information for translators describing where and how the string is used in the game (e.g., Button label on main menu, NPC greeting when player enters village).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this localization string record was first created in the system.',
    `deployment_date` DATE COMMENT 'Date when this string was deployed to production. Null if not yet deployed.',
    `deployment_status` STRING COMMENT 'Current deployment lifecycle status: draft (in development), staged (ready for deployment), deployed (live in production), archived (deprecated and removed from active use).. Valid values are `draft|staged|deployed|archived`',
    `deprecation_date` DATE COMMENT 'Date when this string was marked as deprecated and scheduled for removal. Null if still active.',
    `esrb_rating_impact` STRING COMMENT 'Assessment of whether this string contains content that may impact the games ESRB rating (profanity, violence references, sexual content). Used for content compliance review.. Valid values are `none|mild|moderate|strong`',
    `feature_area` STRING COMMENT 'The specific game feature or module this string belongs to (e.g., Main Menu, Combat System, Inventory, Quest Log). Used for organizing and filtering strings by game area.',
    `gender_variant_required` BOOLEAN COMMENT 'Indicates whether this string requires gender-specific variants for languages with grammatical gender (e.g., French, Spanish, German).',
    `is_active` BOOLEAN COMMENT 'Indicates whether this string is currently active and available for use in the game (true) or has been deprecated/archived (false).',
    `is_placeholder` BOOLEAN COMMENT 'Indicates whether this string is a temporary placeholder (true) or final content (false). Placeholder strings are used during development and must be replaced before release.',
    `modified_by` STRING COMMENT 'Username or identifier of the user who last modified this string.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this localization string record was last modified.',
    `notes` STRING COMMENT 'Additional free-form notes or comments about this string for internal team reference.',
    `pegi_rating_impact` STRING COMMENT 'Assessment of whether this string contains content that may impact the games PEGI rating. Used for European market compliance.. Valid values are `none|mild|moderate|strong`',
    `perforce_changelist` STRING COMMENT 'Perforce changelist number associated with the most recent update to this string. Used for tracking version history and rollback.. Valid values are `^[0-9]+$`',
    `perforce_path` STRING COMMENT 'File path in Perforce Helix Core version control system where this string is stored (e.g., //depot/GameTitle/Localization/Strings/UI/MainMenu.json).',
    `plural_variant_required` BOOLEAN COMMENT 'Indicates whether this string requires plural form variants for languages with complex plural rules (e.g., Russian, Arabic, Polish).',
    `priority` STRING COMMENT 'Translation priority level indicating urgency and importance. Critical strings are required for core gameplay; low priority strings may be deferred to post-launch updates.. Valid values are `critical|high|medium|low`',
    `source_language_code` STRING COMMENT 'ISO 639-1 two-letter language code (with optional ISO 3166-1 alpha-2 country code) for the original language of the string (e.g., en, en-US, ja-JP).. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `source_text` STRING COMMENT 'The original text content in the source language. This is the master text from which all translations are derived.',
    `string_category` STRING COMMENT 'Classification of the string by functional area: UI (user interface labels), narrative (dialogue and story text), marketing (promotional copy), tutorial (instructional text), system (technical messages), achievement (achievement descriptions), store (in-game store copy), error (error messages). [ENUM-REF-CANDIDATE: ui|narrative|marketing|tutorial|system|achievement|store|error — 8 candidates stripped; promote to reference product]',
    `string_key` STRING COMMENT 'Unique programmatic identifier for the string used by the game engine to reference this text. Typically uppercase with underscores (e.g., UI_BUTTON_START, NPC_DIALOGUE_GREETING_01).. Valid values are `^[A-Z0-9_]{3,128}$`',
    `subtitle_timing_end` DECIMAL(18,2) COMMENT 'End time in seconds for subtitle display when this string is used as a subtitle. Null if not applicable.',
    `subtitle_timing_start` DECIMAL(18,2) COMMENT 'Start time in seconds for subtitle display when this string is used as a subtitle. Null if not applicable.',
    `supports_rich_text` BOOLEAN COMMENT 'Indicates whether this string supports rich text formatting (bold, italic, color tags) as defined by the game engines text rendering system.',
    `supports_variables` BOOLEAN COMMENT 'Indicates whether this string contains dynamic variables or placeholders that are replaced at runtime (e.g., {player_name}, {item_count}).',
    `translation_status` STRING COMMENT 'Current status of the string in the localization workflow: not_started (no translation work begun), in_progress (being translated), translated (initial translation complete), reviewed (reviewed by linguist), approved (approved for use), rejected (needs rework), final (locked for release). [ENUM-REF-CANDIDATE: not_started|in_progress|translated|reviewed|approved|rejected|final — 7 candidates stripped; promote to reference product]',
    `variable_list` STRING COMMENT 'Comma-separated list of variable names used in this string (e.g., player_name,item_count,gold_amount). Null if no variables are present.',
    `version_number` STRING COMMENT 'Semantic version number of this string (e.g., 1.0.0, 2.1.3). Incremented when the source text or translations are updated. Supports content versioning in Perforce Helix Core.. Valid values are `^[0-9]+.[0-9]+.[0-9]+$`',
    CONSTRAINT pk_localization_string PRIMARY KEY(`localization_string_id`)
) COMMENT 'Master record for every localizable text string used in-game — UI labels, dialogue, subtitles, tutorial text, NPC speech, achievement descriptions, and store copy. Stores string key, source language text, character limit, context notes for translators, string category (UI, narrative, marketing), game title reference, feature area, and current translation status per locale. The authoritative SSOT for all in-game text content managed across the localization pipeline.';

CREATE OR REPLACE TABLE `gaming_ecm`.`content`.`localization_translation` (
    `localization_translation_id` BIGINT COMMENT 'Unique identifier for the localization translation record. Primary key for the translation entity.',
    `age_rating_cert_id` BIGINT COMMENT 'Foreign key linking to compliance.age_rating_cert. Business justification: Translations can alter content descriptors (profanity, sexual references) triggering rating changes. Localization QA teams verify each translation maintains the certified rating; mismatches require re',
    `asset_id` BIGINT COMMENT 'Foreign key linking to content.asset. Business justification: Localization translations (locale-specific) may reference recorded audio assets for voice-over in that language. This FK links the translation to its recorded VO asset, enabling asset lifecycle tracki',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: Localization translations are versioned and deployed as part of content releases. One translation is deployed in ONE content release; one content release contains MANY translations. This FK enables tr',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Translations are jurisdiction-specific deliverables; each locale maps to regulatory territory. Translation vendors deliver per-jurisdiction compliance; this link supports regulatory audit of localized',
    `localization_string_id` BIGINT COMMENT 'Reference to the source localization string being translated. Links to the master string definition in the content management system.',
    `character_count` STRING COMMENT 'Total number of characters in the translated text. Used for translation billing, UI layout validation, and quality assurance checks to ensure text fits within UI constraints.',
    `context_notes` STRING COMMENT 'Additional context provided to translators about where and how this string is used in-game (e.g., UI button, NPC dialogue, tutorial text). Helps ensure accurate and contextually appropriate translation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this translation record was first created in the system. Used for audit trail and translation workflow analytics.',
    `cultural_adaptation_notes` STRING COMMENT 'Documentation of cultural localization decisions made for this translation, such as idiom adaptation, humor localization, or culturally sensitive content modifications to meet regional standards (ESRB, PEGI, CERO, GRAC).',
    `effective_date` DATE COMMENT 'Date when this translation version becomes active in production. Supports scheduled content drops, seasonal events, and live-ops patch deployment.',
    `expiration_date` DATE COMMENT 'Date when this translation version is retired or replaced. Nullable for evergreen content. Used for time-limited events and seasonal content lifecycle management.',
    `glossary_compliance_flag` BOOLEAN COMMENT 'Boolean indicator whether the translation adheres to the game-specific terminology glossary and style guide. True indicates compliance with brand and terminology standards.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this translation record was last updated. Tracks the most recent change to any field in the record for change tracking and audit purposes.',
    `locale_code` STRING COMMENT 'ISO 639-1 language code combined with ISO 3166-1 alpha-2 country code (e.g., en_US, ja_JP, de_DE, fr_FR, es_MX, pt_BR, ko_KR, zh_CN). Identifies the target locale for this translation.. Valid values are `^[a-z]{2}_[A-Z]{2}$`',
    `machine_translation_flag` BOOLEAN COMMENT 'Boolean indicator whether this translation was generated by machine translation (MT) engine. True indicates machine-generated content that may require human post-editing.',
    `platform_certification_status` STRING COMMENT 'Status of this translation in platform-specific certification processes (TRC/TCR for console manufacturers). Tracks compliance with first-party platform localization requirements.. Valid values are `not_submitted|pending_certification|certified|failed_certification`',
    `qa_flag` BOOLEAN COMMENT 'Boolean indicator for translations requiring additional quality assurance attention due to complexity, cultural sensitivity, or previous issues. True indicates QA escalation needed.',
    `rejection_reason` STRING COMMENT 'Detailed explanation for why a translation was rejected during QA review. Nullable for approved translations. Used for translator feedback and quality improvement.',
    `review_date` DATE COMMENT 'Date when the translation review was completed. Nullable for translations that have not yet been reviewed.',
    `review_status` STRING COMMENT 'Current state of the translation in the quality assurance workflow. Tracks progression from initial submission through review to final approval or rejection.. Valid values are `pending|in_review|approved|rejected|revision_requested`',
    `reviewer_identity` STRING COMMENT 'Identifier of the QA (Quality Assurance) reviewer or linguistic expert who evaluated this translation. Nullable until review is assigned.',
    `revision_count` STRING COMMENT 'Number of times this translation has been revised and resubmitted. Used to track translation complexity and identify problematic strings requiring additional localization guidance.',
    `source_text_hash` STRING COMMENT 'Hash of the original source string at the time of translation. Used to detect when source content has changed and translation needs updating.',
    `translated_text` STRING COMMENT 'The translated string content in the target locale. Contains the localized text that will be displayed to players in-game or in platform interfaces.',
    `translation_cost` DECIMAL(18,2) COMMENT 'Cost incurred for this translation in USD. Used for vendor billing, budget tracking, and localization ROI (Return on Investment) analysis. Nullable for internal or community translations.',
    `translation_date` DATE COMMENT 'Date when the translation was completed and submitted. Used for tracking translation velocity and vendor SLA (Service Level Agreement) compliance.',
    `translation_memory_match_score` DECIMAL(18,2) COMMENT 'Percentage match score from translation memory system (0-100). Indicates how closely this translation matched existing approved translations. Used for cost optimization and consistency.',
    `translator_identity` STRING COMMENT 'Identifier of the individual translator, vendor company name, or machine translation service that produced this translation. Used for quality tracking and vendor performance analysis.',
    `translator_type` STRING COMMENT 'Classification of the translation source: internal localization team, external vendor agency, machine translation engine, community contributor, or hybrid (machine + human review).. Valid values are `internal_team|external_vendor|machine_translation|community_contributor|hybrid`',
    `version_number` STRING COMMENT 'Version number of this translation. Increments with each approved revision. Supports content versioning in Perforce Helix Core and live-ops content update tracking.',
    `word_count` STRING COMMENT 'Total number of words in the translated text. Used for translation billing (many vendors charge per word), workload estimation, and linguistic complexity analysis.',
    CONSTRAINT pk_localization_translation PRIMARY KEY(`localization_translation_id`)
) COMMENT 'Translation record linking a localization string to a specific locale, capturing the translated text, translator identity (internal team or vendor), translation date, review status (pending, reviewed, approved, rejected), reviewer identity, QA flag, character count, and machine-translation flag. Supports multi-locale game releases across PEGI, ESRB, CERO, and GRAC regions. One record per string-locale pair, enabling per-locale translation workflow tracking.';

CREATE OR REPLACE TABLE `gaming_ecm`.`content`.`level_map` (
    `level_map_id` BIGINT COMMENT 'Unique identifier for the level, map, zone, or world area. Primary key.',
    `asset_bundle_id` BIGINT COMMENT 'Foreign key linking to content.asset_bundle. Business justification: level_map.asset_bundle_references is a denormalized STRING field holding asset bundle references for the level. Normalizing this to a proper FK asset_bundle_id → content.asset_bundle.asset_bundle_id e',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: Game levels and maps are released as part of content drops (new zones for DLC, seasonal event maps, expansion areas). This FK links the level to its release event. N:1 cardinality - many levels can be',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: Level maps using licensed middleware (Havok physics, Wwise audio) or brand partnerships (real-world locations, sponsored venues) must track IP dependencies for platform certification submissions, roya',
    `seasonal_event_id` BIGINT COMMENT 'Foreign key linking to content.seasonal_event. Business justification: level_map.seasonal_event_variant is a denormalized STRING field capturing which seasonal event variant applies to this level/map (e.g., winter_2024, halloween_event). Normalizing this to seasonal_',
    `accessibility_features` STRING COMMENT 'Comma-separated list of accessibility features implemented in this level (e.g., colorblind_mode,subtitle_support,reduced_motion,audio_cues).',
    `audio_ambience_profile` STRING COMMENT 'Identifier for the audio ambience profile used in this level (e.g., forest_day, urban_night, dungeon_echo). References audio asset configuration.',
    `build_status` STRING COMMENT 'Current production status of the level: blockout (initial layout/greybox), art_pass (art assets applied), optimization (performance tuning), gold (production-ready), deprecated (no longer in use).. Valid values are `blockout|art_pass|optimization|gold|deprecated`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this level record was first created in the content management system.',
    `day_night_cycle_enabled` BOOLEAN COMMENT 'Indicates whether the level supports a dynamic day-night cycle affecting lighting and gameplay.',
    `deprecated_timestamp` TIMESTAMP COMMENT 'Timestamp when this level was deprecated or removed from active rotation. Null if still active.',
    `difficulty_rating` STRING COMMENT 'Designed difficulty level of the level: easy (beginner-friendly), normal (standard challenge), hard (experienced players), expert (advanced), nightmare (maximum difficulty).. Valid values are `easy|normal|hard|expert|nightmare`',
    `estimated_play_duration_minutes` STRING COMMENT 'Expected average time in minutes for a player to complete or experience this level under normal gameplay conditions.',
    `game_mode_compatibility` STRING COMMENT 'Comma-separated list of game modes this level supports (e.g., deathmatch,capture_the_flag,team_deathmatch). Indicates which gameplay rulesets can be played on this map.',
    `geometry_complexity_tier` STRING COMMENT 'Classification of the levels geometric complexity and polygon count: low (simple geometry), medium (moderate detail), high (detailed environments), ultra (maximum fidelity).. Valid values are `low|medium|high|ultra`',
    `interactive_object_count` STRING COMMENT 'Total number of interactive objects (doors, switches, loot containers, destructible elements) placed in the level.',
    `known_bug_count` STRING COMMENT 'Current count of known open bugs or issues logged in Jira for this level. Used for quality tracking and release readiness.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this level record was last updated or modified.',
    `level_code` STRING COMMENT 'Unique alphanumeric code or identifier used in game engine and asset pipeline to reference this level (e.g., LVL_001, MAP_TUTORIAL_01).',
    `level_name` STRING COMMENT 'Human-readable name of the level, map, or zone (e.g., Crimson Fortress, Tutorial Island, Arena of Champions).',
    `level_type` STRING COMMENT 'Classification of the level based on gameplay purpose: tutorial (onboarding), PvP (Player versus Player) arena, PvE (Player versus Environment) dungeon, open world, hub (social space), lobby (matchmaking), boss arena, raid, or story mission. [ENUM-REF-CANDIDATE: tutorial|pvp_arena|pve_dungeon|open_world|hub|lobby|boss_arena|raid|story_mission — 9 candidates stripped; promote to reference product]',
    `lighting_model` STRING COMMENT 'Lighting technique used in the level: baked (pre-computed lightmaps), dynamic (real-time lighting), mixed (combination of baked and dynamic).. Valid values are `baked|dynamic|mixed`',
    `localization_string_count` STRING COMMENT 'Total number of localization strings (text, dialogue, UI labels) associated with this level across all supported languages.',
    `memory_budget_mb` STRING COMMENT 'Allocated memory budget in megabytes for this levels assets and runtime data. Used for performance optimization and platform compliance.',
    `minimum_fps_target` STRING COMMENT 'Minimum target frame rate (FPS - Frames Per Second) the level is optimized to maintain on supported platforms.',
    `navmesh_complexity` STRING COMMENT 'Complexity of the AI navigation mesh for NPC (Non-Player Character) pathfinding: simple (basic navigation), moderate (standard pathfinding), complex (advanced multi-layer navigation), none (no AI navigation).. Valid values are `simple|moderate|complex|none`',
    `npc_spawn_zones_count` STRING COMMENT 'Number of designated zones where NPCs (Non-Player Characters) can spawn or patrol within the level.',
    `objective_marker_count` STRING COMMENT 'Number of objective markers or mission waypoints placed in the level for gameplay guidance.',
    `physics_configuration` STRING COMMENT 'Physics simulation complexity for the level: standard (default physics), high_fidelity (advanced physics interactions), simplified (reduced physics for performance), disabled (no physics simulation).. Valid values are `standard|high_fidelity|simplified|disabled`',
    `published_timestamp` TIMESTAMP COMMENT 'Timestamp when this level was published to production and made available to players. Null if not yet published.',
    `qa_test_pass_count` STRING COMMENT 'Number of QA (Quality Assurance) test passes completed for this level. Indicates testing maturity and quality validation.',
    `spawn_point_count` STRING COMMENT 'Total number of player spawn points configured in the level for matchmaking and respawn mechanics.',
    `streaming_strategy` STRING COMMENT 'Memory and asset loading strategy for the level: full_load (entire level loaded at once), streaming_chunks (progressive streaming of level sections), hybrid (combination approach).. Valid values are `full_load|streaming_chunks|hybrid`',
    `supported_platforms` STRING COMMENT 'Comma-separated list of platforms this level is certified for (e.g., PC,PS5,Xbox_Series_X,Nintendo_Switch,iOS,Android). Indicates platform compatibility.',
    `target_player_count_max` STRING COMMENT 'Maximum number of players the level is designed to support for optimal gameplay experience.',
    `target_player_count_min` STRING COMMENT 'Minimum number of players the level is designed to support for optimal gameplay experience.',
    `ugc_enabled` BOOLEAN COMMENT 'Indicates whether this level supports user-generated content (UGC) modifications, custom maps, or player-created elements.',
    `version_number` STRING COMMENT 'Semantic version number of the level build (e.g., 1.0.0, 2.3.1). Tracks iterations and updates to the level design and assets.',
    `vertical_layers_count` STRING COMMENT 'Number of distinct vertical layers or floors in the level (e.g., multi-story buildings, underground sections). Indicates vertical complexity.',
    `weather_system_enabled` BOOLEAN COMMENT 'Indicates whether dynamic weather effects (rain, snow, fog) are enabled for this level.',
    `world_size_square_meters` DECIMAL(18,2) COMMENT 'Total playable area of the level measured in square meters. Indicates the physical scale of the game space.',
    CONSTRAINT pk_level_map PRIMARY KEY(`level_map_id`)
) COMMENT 'Master record for each game level, map, zone, or world area representing a discrete playable space. Captures level name, level type (tutorial, PvP arena, PvE dungeon, open world, hub, lobby), game mode compatibility, target player count, estimated play duration, geometry complexity tier, streaming strategy (full load vs. streaming chunks), lighting model, physics configuration, navmesh complexity, associated asset bundles, and current build status (blockout, art-pass, optimization, gold). Owned by the content domain as the authoritative creative deliverable definition; distinct from game mode configuration owned by platform/title domains.';

CREATE OR REPLACE TABLE `gaming_ecm`.`content`.`npc_definition` (
    `npc_definition_id` BIGINT COMMENT 'Unique identifier for the NPC definition record. Primary key for the NPC definition master data.',
    `asset_bundle_id` BIGINT COMMENT 'Foreign key linking to content.asset_bundle. Business justification: npc_definition.audio_asset_bundle is a denormalized STRING field referencing the asset bundle that contains the NPCs audio assets (voice lines, sound effects, ambient audio). Normalizing this to audi',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: NPC definitions (enemies, allies, quest NPCs) are released as part of content drops (new characters for seasonal events, DLC story NPCs, live-ops additions). This FK links the NPC to its release. N:1 ',
    `game_studio_id` BIGINT COMMENT 'Foreign key reference to the development studio that created this NPC definition. Used for attribution and cross-studio content sharing.',
    `game_title_id` BIGINT COMMENT 'Foreign key reference to the game title product catalog entry that this NPC definition belongs to. Links NPC content to specific game SKU.',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: NPCs using licensed character IP, voice actor performances under SAG-AFTRA agreements, or middleware animation systems (e.g., Euphoria) require IP tracking for royalty obligations, union residuals, an',
    `asset_id` BIGINT COMMENT 'Foreign key linking to content.asset. Business justification: NPC definitions reference a 3D model asset. Currently stored as model_asset_path (STRING path). Normalizing to FK enables referential integrity, asset lifecycle tracking, and JOIN-based queries. N:1 c',
    `repo_id` BIGINT COMMENT 'Foreign key linking to studio.repo. Business justification: NPC definitions are version-controlled in Perforce depots (npc_definition has perforce_changelist). A FK to studio.repo normalizes source control provenance for NPC design assets, enabling depot audit',
    `aggro_range` DECIMAL(18,2) COMMENT 'Distance in game units within which this NPC will detect and engage hostile targets. Critical for encounter design and difficulty balancing.',
    `ai_behavior_profile` STRING COMMENT 'Reference to the AI behavior script or profile that governs this NPCs decision-making, combat tactics, patrol patterns, and interaction logic. Links to game engine AI system configuration.',
    `animation_rig_reference` STRING COMMENT 'Reference to the skeletal animation rig asset used for this NPC. Links to the animation pipeline in Unity or Unreal Engine and defines available animation sequences.',
    `approved_by_user` STRING COMMENT 'Username or identifier of the lead designer or content director who approved this NPC definition for production deployment.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this NPC definition was approved for production deployment. Marks transition from draft to approved lifecycle status.',
    `archetype_type` STRING COMMENT 'Classification of the NPC by its primary gameplay role: enemy (hostile combatant), ally (friendly combatant), vendor (merchant), quest_giver (mission provider), boss (major encounter), or ambient (background character).. Valid values are `enemy|ally|vendor|quest_giver|boss|ambient`',
    `base_attack_power` STRING COMMENT 'The default attack damage value for this NPC archetype at base level. Used for combat balancing and player difficulty progression.',
    `base_defense_rating` STRING COMMENT 'The default defense or armor value for this NPC archetype at base level. Determines damage mitigation in combat encounters.',
    `base_health_points` STRING COMMENT 'The default health points value for this NPC archetype at base level. Part of the core stat block used for combat balancing and difficulty tuning.',
    `base_movement_speed` DECIMAL(18,2) COMMENT 'The default movement speed for this NPC archetype measured in game units per second. Affects chase mechanics, patrol behavior, and encounter pacing.',
    `collision_profile` STRING COMMENT 'Physics collision profile that defines the NPCs physical boundaries and interaction with the game world. Determines hitbox size and collision detection behavior.. Valid values are `small|medium|large|boss|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this NPC definition record was first created in the content management system. Follows ISO 8601 format.',
    `deployed_timestamp` TIMESTAMP COMMENT 'Date and time when this NPC definition was deployed to live game servers. Used for live operations tracking and content drop scheduling.',
    `deprecated_timestamp` TIMESTAMP COMMENT 'Date and time when this NPC definition was marked as deprecated and scheduled for removal from active content. Used for content lifecycle management.',
    `design_notes` STRING COMMENT 'Internal design notes and rationale for this NPCs creation, balancing decisions, and intended player experience. Used for knowledge transfer and iteration planning.',
    `dialogue_tree_reference` STRING COMMENT 'Reference identifier to the dialogue tree or conversation script asset used when players interact with this NPC. Links to narrative content and localization systems.',
    `experience_reward` STRING COMMENT 'Amount of experience points awarded to players upon defeating or completing interactions with this NPC. Used for player progression and leveling systems.',
    `faction` STRING COMMENT 'The faction or allegiance group to which this NPC belongs. Determines relationship dynamics with player and other NPCs in the game world.',
    `is_quest_critical` BOOLEAN COMMENT 'Indicates whether this NPC is essential to main story quest progression and cannot be permanently removed from the game world. Affects respawn logic and narrative continuity.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the NPC definition: draft (in development), approved (ready for deployment), active (live in game), deprecated (scheduled for removal), or retired (no longer in use).. Valid values are `draft|approved|active|deprecated|retired`',
    `localization_key_prefix` STRING COMMENT 'Prefix identifier used to look up localized strings for this NPC across all supported languages. Links to the localization string database for dialogue, names, and descriptions.. Valid values are `^[A-Z_]{3,30}$`',
    `lod_variant_count` STRING COMMENT 'Number of LOD mesh variants available for this NPC to optimize rendering performance at different camera distances. Critical for performance optimization in large-scale scenes.',
    `loot_table_reference` STRING COMMENT 'Reference identifier to the loot table configuration that defines item drops when this NPC is defeated or interacted with. Used for reward balancing and economy management.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this NPC definition record was last modified. Used for change tracking and audit trails.',
    `npc_code` STRING COMMENT 'Unique business identifier code for the NPC definition used across game engine, content management systems, and development tools. Typically used in Perforce Helix Core and Unity/Unreal Engine asset pipelines.. Valid values are `^[A-Z0-9_]{3,20}$`',
    `npc_definition_description` STRING COMMENT 'Detailed narrative description of the NPC including backstory, role in the game world, and design intent. Used for documentation and content review.',
    `npc_name` STRING COMMENT 'The display name of the NPC as shown to players in-game. This is the canonical identity label for the NPC archetype.',
    `perforce_changelist` STRING COMMENT 'Perforce Helix Core changelist number associated with the last commit of this NPC definition. Enables version control traceability and rollback capability.',
    `respawn_cooldown_seconds` STRING COMMENT 'Time in seconds before this NPC respawns after being defeated. Used for encounter pacing and resource farming balance.',
    `respawn_enabled` BOOLEAN COMMENT 'Indicates whether this NPC can respawn after being defeated or removed. Affects world population management and farming mechanics.',
    `spawn_rule_set` STRING COMMENT 'Reference to the spawn rule configuration that defines where, when, and under what conditions this NPC appears in the game world. Includes location constraints, time-of-day rules, and event triggers.',
    `texture_asset_path` STRING COMMENT 'File path or asset reference to the texture map(s) applied to the NPC model. Includes diffuse, normal, and material maps stored in the content pipeline.',
    `version_number` STRING COMMENT 'Semantic version number tracking iterations of this NPC definition through the content pipeline. Follows semantic versioning convention (vMAJOR.MINOR.PATCH).. Valid values are `^v[0-9]+.[0-9]+.[0-9]+$`',
    `voice_actor_credit` STRING COMMENT 'Name of the voice actor who provided voice-over performance for this NPC. Used for credits, royalty tracking, and talent management.',
    CONSTRAINT pk_npc_definition PRIMARY KEY(`npc_definition_id`)
) COMMENT 'Master definition record for every Non-Player Character (NPC) archetype in the game — enemies, allies, vendors, quest givers, bosses, and ambient characters. Stores NPC name, NPC archetype type, faction, base stat block, AI behavior profile reference, dialogue tree reference, loot table reference, spawn rules, animation rig reference, voice actor credit, localization key prefix, associated asset references (model, textures, animations), and lifecycle status (draft, approved, deprecated). The content domain owns NPC creative definitions as authored deliverables; runtime NPC instances and state are managed by game server infrastructure.';

CREATE OR REPLACE TABLE `gaming_ecm`.`content`.`content_release` (
    `content_release_id` BIGINT COMMENT 'Primary key for release',
    `age_rating_cert_id` BIGINT COMMENT 'Foreign key linking to compliance.age_rating_cert. Business justification: Each content drop may require rating re-evaluation if new content added (DLC, season pass). Platform certification workflow requires linking drops to ESRB/PEGI submissions for deployment approval.',
    `cdn_node_id` BIGINT COMMENT 'Foreign key linking to infrastructure.cdn_node. Business justification: Content releases are distributed through CDN infrastructure. Release teams coordinate with CDN operators to pre-warm caches before go-live, monitor distribution completion across nodes, and diagnose r',
    `game_studio_id` BIGINT COMMENT 'Foreign key reference to the development studio responsible for creating and delivering this content release. Used for accountability and resource planning.',
    `game_title_id` BIGINT COMMENT 'Foreign key reference to the game title this content release belongs to. Links the content drop to the specific game product in the catalog.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Live ops drops must comply with loot box disclosure laws, GDPR consent updates, age verification requirements. Release approval checklist includes regulatory compliance sign-off; this link enables obl',
    `server_fleet_id` BIGINT COMMENT 'Foreign key linking to infrastructure.server_fleet. Business justification: Content drops are deployed to specific server fleets in staged rollout patterns. Release managers track fleet-level deployment status for canary testing, rollback planning, and coordinating content av',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to platform.storefront. Business justification: Storefront-scoped content release management: content releases target specific storefronts for platform-specific cert status, regional availability, and distribution. Release managers use this for per',
    `actual_go_live_timestamp` TIMESTAMP COMMENT 'Actual date and time when the content release was deployed to production and became available to players. Null if not yet deployed.',
    `approval_status` STRING COMMENT 'Cross-functional approval status for the content release: pending (awaiting stakeholder sign-off), approved (greenlit for deployment), rejected (not approved, requires changes). Tracks executive and product leadership approval.. Valid values are `pending|approved|rejected`',
    `asset_bundle_references` STRING COMMENT 'Comma-separated list of asset bundle identifiers or Perforce Helix Core changelist numbers associated with this content release. Links the release to the underlying digital assets.',
    `cdn_distribution_status` STRING COMMENT 'Status of content distribution to CDN nodes: pending (awaiting distribution), distributing (in progress), completed (available on all CDN nodes), failed (distribution errors). Critical for global content availability.. Valid values are `pending|distributing|completed|failed`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this content release record was first created in the system. Audit trail for release planning lifecycle.',
    `critical_issues_count` STRING COMMENT 'Number of critical bugs or issues reported by players or QA after this content release went live. Used for quality monitoring and hotfix prioritization.',
    `deployment_status` STRING COMMENT 'Technical deployment status of the content release: not_started (scheduled but not yet deployed), in_progress (deployment underway), completed (successfully deployed to all target platforms), failed (deployment encountered errors).. Valid values are `not_started|in_progress|completed|failed`',
    `download_size_mb_console` DECIMAL(18,2) COMMENT 'Download package size in megabytes for console platforms (PlayStation, Xbox, Switch). Used for bandwidth planning and player communication.',
    `download_size_mb_mobile` DECIMAL(18,2) COMMENT 'Download package size in megabytes for mobile platforms (iOS, Android). Critical for mobile data usage and app store optimization.',
    `download_size_mb_pc` DECIMAL(18,2) COMMENT 'Download package size in megabytes for PC platform. Used for bandwidth planning and player communication.',
    `drop_name` STRING COMMENT 'Human-readable name or title of the content release (e.g., Winter Wonderland Event, Patch 2.4.1, Season 3 Battle Pass).',
    `eligibility_rules` STRING COMMENT 'Player eligibility criteria for accessing this content release (e.g., Level 10+, Premium subscribers only, All players). Used for access control and segmentation.',
    `event_end_timestamp` TIMESTAMP COMMENT 'Date and time when a seasonal or limited-time event concludes and is no longer available to players. Applicable for event-based releases.',
    `event_start_timestamp` TIMESTAMP COMMENT 'Date and time when a seasonal or limited-time event becomes active for players. Applicable for event-based releases.',
    `event_theme` STRING COMMENT 'Thematic description of seasonal or limited-time events (e.g., Winter Holiday, Halloween, Summer Festival). Applicable when release_type is seasonal_event or limited_time_event.',
    `exclusive_rewards` STRING COMMENT 'Description of exclusive rewards or items available only during this content release (e.g., Legendary Winter Sword,Exclusive Holiday Avatar). Used for player engagement and retention.',
    `featured_bundles` STRING COMMENT 'Comma-separated list of featured in-game bundles or offers associated with this content release (e.g., Winter Skin Pack,Holiday Emote Bundle). Used for monetization and marketing alignment.',
    `gold_master_date` DATE COMMENT 'Date when the content release reached gold master status (final, production-ready build). Marks the completion of development and testing.',
    `live_ops_owner` STRING COMMENT 'Name or identifier of the live operations team member or product owner responsible for this content release. Used for accountability and cross-functional coordination.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether players are required to download and install this content release to continue playing. True for mandatory updates (e.g., critical security patches, breaking changes), False for optional content.',
    `minimum_client_version` STRING COMMENT 'Minimum game client version required to support this content release. Players on older client versions may be blocked or prompted to update. Follows semver format.. Valid values are `^d+.d+.d+$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this content release record was last updated. Audit trail for tracking changes to release plans and status.',
    `notes_url` STRING COMMENT 'URL to the public-facing release notes or patch notes document for this content release. Used for player communication and transparency.. Valid values are `^https?://.*$`',
    `participation_mechanics` STRING COMMENT 'Description of gameplay mechanics or activities players must complete to participate in the event or unlock rewards (e.g., Complete 10 daily quests, Win 5 PvP matches).',
    `patch_type` STRING COMMENT 'Classification of patch releases: major (significant feature additions or breaking changes), minor (incremental features or improvements), hotfix (emergency bug fixes). Applicable only when release_type is patch or hotfix.. Valid values are `major|minor|hotfix`',
    `player_feedback_score` DECIMAL(18,2) COMMENT 'Aggregated player sentiment score for this content release, typically on a scale of 1.00 to 5.00. Derived from player surveys, reviews, and community feedback post-launch.',
    `qa_sign_off_date` DATE COMMENT 'Date when the QA team formally approved this content release for deployment. Indicates completion of quality assurance and playtesting.',
    `recurrence_pattern` STRING COMMENT 'Frequency pattern for recurring events: one_time (single occurrence), annual (yearly), quarterly (every 3 months), monthly, weekly. Applicable for seasonal events.. Valid values are `one_time|annual|quarterly|monthly|weekly`',
    `release_status` STRING COMMENT 'Current lifecycle status of the content release: planned (scheduled but not yet approved), approved (greenlit for development), in_qa (undergoing quality assurance testing), certified (passed platform TRC/TCR certification), live (deployed to production), rolled_back (reverted due to issues), cancelled (release aborted). [ENUM-REF-CANDIDATE: planned|approved|in_qa|certified|live|rolled_back|cancelled — 7 candidates stripped; promote to reference product]',
    `release_type` STRING COMMENT 'Type discriminator for the content release: seasonal_event (recurring themed events), patch (scheduled version updates), hotfix (emergency fixes), battle_pass_season (new battle pass tier progression), dlc_drop (downloadable content expansion), limited_time_event (one-off special events).. Valid values are `seasonal_event|patch|hotfix|battle_pass_season|dlc_drop|limited_time_event`',
    `rollback_timestamp` TIMESTAMP COMMENT 'Date and time when the content release was rolled back or reverted due to critical issues. Null if no rollback occurred.',
    `scheduled_go_live_timestamp` TIMESTAMP COMMENT 'Planned date and time when the content release is scheduled to go live to players. This is the target deployment timestamp set during release planning.',
    `target_platforms` STRING COMMENT 'Comma-separated list of platforms this content release targets (e.g., PC,PlayStation,Xbox,Mobile,Switch). Indicates which platforms will receive this content drop.',
    `trc_tcr_certification_status` STRING COMMENT 'Platform certification status for console releases: not_required (PC/mobile only), pending (submitted for certification), in_progress (under review by first party), passed (certified), failed (rejected, requires fixes). Required for PlayStation, Xbox, Switch releases.. Valid values are `not_required|pending|in_progress|passed|failed`',
    `version_string` STRING COMMENT 'Semantic versioning identifier for patches and hotfixes (e.g., 2.4.1, 3.0.0). Follows semver convention: major.minor.patch. Null for non-patch release types.. Valid values are `^d+.d+.d+$`',
    `window` STRING COMMENT 'Deployment strategy for the content release: soft_launch (limited geographic or player segment release for testing), hard_launch (full production release), phased_rollout (gradual deployment across regions or player cohorts), global_simultaneous (worldwide release at the same time).. Valid values are `soft_launch|hard_launch|phased_rollout|global_simultaneous`',
    CONSTRAINT pk_content_release PRIMARY KEY(`content_release_id`)
) COMMENT 'Unified live-ops content release record representing any scheduled or emergency delivery of new or updated content to live players. Covers all release types via type discrimination: seasonal events (with event theme, start/end timestamps, recurrence pattern, featured bundles, exclusive rewards, participation mechanics, eligibility rules), patches and hotfixes (with semver version string, patch type, mandatory flag, minimum client version, per-platform size, QA sign-off, gold master date, TRC/TCR certification status), battle pass seasons, DLC drops, and limited-time events. Also serves as the release calendar, capturing planned vs actual release dates, release window (soft/hard), marketing campaign alignment, and cross-functional approval status. Stores drop name, release type, scheduled go-live timestamp, actual go-live timestamp, rollback timestamp, target platforms, associated asset bundles, release notes reference, live-ops owner, and deployment status. The single operational heartbeat of GaaS content delivery — one entity to answer what is going live, when, and what does it contain.';

CREATE OR REPLACE TABLE `gaming_ecm`.`content`.`patch` (
    `patch_id` BIGINT COMMENT 'Primary key for patch',
    `age_rating_cert_id` BIGINT COMMENT 'Foreign key linking to compliance.age_rating_cert. Business justification: Patches modify game content (violence, language, mechanics) requiring re-certification in regulated jurisdictions. Platform certification teams track which age rating applies to each patch version for',
    `cdn_node_id` BIGINT COMMENT 'Foreign key linking to infrastructure.cdn_node. Business justification: Patch distribution pipelines push builds to CDN nodes for player downloads, ops teams monitor CDN bandwidth and cache hit ratios during patch rollout windows, and player support troubleshoots download',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: Patch is a specialization of content_release (release_type = patch). This FK links the patch detail record to its parent content_release record, enabling unified live-ops tracking. 1:1 or N:1 cardin',
    `game_title_id` BIGINT COMMENT 'Reference to the game title this patch applies to.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Patches may address regulatory violations (emergency patch to fix COPPA violation, loot box disclosure bug). Compliance incident remediation via patch deployment requires linking patches to obligation',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to platform.storefront. Business justification: Storefront-specific patch distribution: patches are distributed through specific storefronts with platform-specific cert and distribution requirements. Patch management teams need this link for per-st',
    `approved_by` STRING COMMENT 'Username or identifier of the team member who approved the patch for release (typically a lead producer, technical director, or QA manager).',
    `build_number` STRING COMMENT 'Internal build identifier assigned by the CI/CD (Continuous Integration/Continuous Deployment) pipeline for this patch.',
    `cdn_distribution_status` STRING COMMENT 'Status of the patch distribution to CDN nodes globally: pending (queued for distribution), in_progress (actively replicating), completed (available on all CDN nodes), failed (distribution error occurred).. Valid values are `pending|in_progress|completed|failed`',
    `content_drop_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this patch includes a live-ops content drop (seasonal event, new maps, new characters, limited-time content). True if content drop is included, false otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the patch record was first created in the system.',
    `deployment_date_console` DATE COMMENT 'The date when the patch was deployed live to console platforms (PlayStation, Xbox, Switch).',
    `deployment_date_mobile` DATE COMMENT 'The date when the patch was deployed live to mobile platforms (iOS App Store, Google Play).',
    `deployment_date_pc` DATE COMMENT 'The date when the patch was deployed live to PC platforms (Steam, Epic Games Store, etc.).',
    `dlc_included` STRING COMMENT 'Comma-separated list of DLC SKUs or identifiers that are bundled or enabled by this patch. Null if no DLC is associated.',
    `drm_version` STRING COMMENT 'Version identifier of the DRM protection applied to this patch, if applicable. Used to track anti-piracy measures and compatibility.',
    `esrb_rating_impact` STRING COMMENT 'Indicates whether this patch introduces content that may affect the games ESRB rating: none (no impact), content_descriptor_added (new content descriptor required), rating_change_pending (rating re-evaluation in progress).. Valid values are `none|content_descriptor_added|rating_change_pending`',
    `gold_master_date` DATE COMMENT 'The date when the patch build was finalized and locked as the gold master version ready for platform submission and deployment.',
    `internal_change_log` STRING COMMENT 'Internal technical change log detailing code commits, asset changes, and engineering notes not intended for public release. Used for development team reference and audit.',
    `is_mandatory` BOOLEAN COMMENT 'Boolean flag indicating whether players are required to install this patch to continue playing (true) or if it is optional (false).',
    `localization_languages` STRING COMMENT 'Comma-separated list of language codes (ISO 639-1) for which localized patch notes and in-game strings are provided (e.g., en,es,fr,de,ja,zh).',
    `minimum_client_version` STRING COMMENT 'The minimum game client version required for this patch to be applied successfully (semver format).. Valid values are `^d+.d+.d+$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the patch record was last modified.',
    `notes` STRING COMMENT 'Detailed release notes describing bug fixes, balance changes, new content, performance improvements, and known issues addressed in this patch. Intended for player-facing communication.',
    `patch_name` STRING COMMENT 'Human-readable name or codename for the patch (e.g., Winter Festival Update, Critical Stability Hotfix).',
    `patch_status` STRING COMMENT 'Current lifecycle status of the patch: draft (in development), qa_testing (undergoing QA), trc_submission (submitted for platform certification), approved (passed TRC/TCR), deployed (live on platforms), rolled_back (reverted due to issues), deprecated (superseded by newer patch). [ENUM-REF-CANDIDATE: draft|qa_testing|trc_submission|approved|deployed|rolled_back|deprecated — 7 candidates stripped; promote to reference product]',
    `patch_type` STRING COMMENT 'Classification of the patch by scope and purpose: hotfix (urgent bug fix), minor (incremental improvements), major (significant feature release), balance (gameplay tuning), content (new assets/levels), security (vulnerability fix).. Valid values are `hotfix|minor|major|balance|content|security`',
    `pegi_rating_impact` STRING COMMENT 'Indicates whether this patch introduces content that may affect the games PEGI rating: none (no impact), content_descriptor_added (new content descriptor required), rating_change_pending (rating re-evaluation in progress).. Valid values are `none|content_descriptor_added|rating_change_pending`',
    `performance_improvement_notes` STRING COMMENT 'Description of performance optimizations included in this patch, such as FPS (Frames Per Second) improvements, load time reductions, memory optimizations, or LOD (Level of Detail) enhancements.',
    `qa_sign_off_reference` STRING COMMENT 'Reference identifier to the QA test cycle or approval record that certified this patch as ready for release (e.g., Jira ticket, test plan ID).',
    `rollback_date` DATE COMMENT 'The date when the patch was rolled back or reverted due to critical issues discovered post-deployment. Null if no rollback occurred.',
    `rollback_reason` STRING COMMENT 'Explanation of why the patch was rolled back, including the nature of the critical issue (e.g., Server crashes on login, Game-breaking exploit discovered).',
    `security_fixes_included` BOOLEAN COMMENT 'Boolean flag indicating whether this patch includes security vulnerability fixes or anti-cheat improvements. True if security fixes are present, false otherwise.',
    `size_console_mb` DECIMAL(18,2) COMMENT 'Size of the patch download for console platforms (PlayStation, Xbox, Switch) in megabytes. May vary by specific console; this represents a typical or average size.',
    `size_mobile_mb` DECIMAL(18,2) COMMENT 'Size of the patch download for mobile platforms (iOS, Android) in megabytes.',
    `size_pc_mb` DECIMAL(18,2) COMMENT 'Size of the patch download for PC platform in megabytes.',
    `target_platforms` STRING COMMENT 'Comma-separated list of platforms this patch targets (e.g., PC,PlayStation5,XboxSeriesX,Switch,iOS,Android). Each platform may have separate certification and deployment workflows.',
    `trc_approval_date` DATE COMMENT 'The date when the patch received approval from platform certification, clearing it for deployment.',
    `trc_submission_date` DATE COMMENT 'The date when the patch was submitted to platform holders (Sony, Microsoft, Nintendo, Apple, Google) for technical certification review.',
    `version` STRING COMMENT 'Semantic version string for the patch following semver convention (e.g., 1.2.3, 2.0.0-hotfix1).. Valid values are `^d+.d+.d+(-[a-zA-Z0-9]+)?$`',
    CONSTRAINT pk_patch PRIMARY KEY(`patch_id`)
) COMMENT 'Patch record for a versioned software update delivered to players, covering bug fixes, balance changes, performance improvements, and content additions. Stores patch version string (semver), patch type (hotfix, minor, major, balance), target platforms, patch size per platform, mandatory flag, minimum client version required, patch notes, QA sign-off reference, gold master date, and deployment status per platform. Bridges the content pipeline with platform certification (TRC/TCR) requirements.';

CREATE OR REPLACE TABLE `gaming_ecm`.`content`.`seasonal_event` (
    `seasonal_event_id` BIGINT COMMENT 'Unique identifier for the seasonal event. Primary key.',
    `asset_bundle_id` BIGINT COMMENT 'Foreign key linking to content.asset_bundle. Business justification: seasonal_event.asset_bundle_path is a denormalized STRING path referencing the primary asset bundle for the seasonal event (cosmetics, event UI, themed content). Normalizing this to asset_bundle_id → ',
    `campaign_id` BIGINT COMMENT 'Reference to the associated marketing campaign driving player awareness and acquisition for this seasonal event.',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: Seasonal_event is a specialization of content_release (release_type = seasonal_event). This FK links the event detail record to its parent content_release record, enabling unified live-ops tracking.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title in which this seasonal event is deployed. Links to the game catalog.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Events may be region-locked due to regulatory restrictions (gambling laws, content censorship). Geo-blocking configuration for compliance requires linking events to jurisdictions for deployment rule e',
    `loot_box_disclosure_id` BIGINT COMMENT 'Foreign key linking to compliance.loot_box_disclosure. Business justification: Events often introduce limited-time gacha mechanics requiring odds disclosure (Belgium, Netherlands, Japan laws). Event launch checklist includes loot box probability publication; this link enables co',
    `matchmaking_pool_id` BIGINT COMMENT 'Foreign key linking to infrastructure.matchmaking_pool. Business justification: Seasonal events often have dedicated matchmaking pools with event-specific rules and player eligibility. Live ops teams configure event pools, track participation metrics, and coordinate pool activati',
    `network_region_id` BIGINT COMMENT 'Foreign key linking to infrastructure.network_region. Business justification: Live-ops teams schedule regional event launches with region-specific start times, compliance teams verify data residency requirements per region, and analytics track participation by network region. E',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Events must comply with gambling laws, advertising restrictions (Belgium loot box ban, UK advertising standards). Legal review of event monetization mechanics requires linking events to applicable obl',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to platform.storefront. Business justification: Storefront-specific event configuration: seasonal events are featured on specific storefronts for platform-specific eligibility and featured placement. Normalizes the denormalized platform_eligibility',
    `title_season_id` BIGINT COMMENT 'Foreign key linking to title.title_season. Business justification: Seasonal events align with title seasons (e.g., Season 3 Halloween Event). Live ops scheduling, marketing campaign alignment, and battle pass integration require linking events to their parent season ',
    `actual_participation_count` STRING COMMENT 'Actual number of unique players who participated in the event after completion. Null until event concludes and analytics are finalized.',
    `approved_by` STRING COMMENT 'Username or identifier of the executive producer, studio head, or approver who authorized the event for production and deployment.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the seasonal event was formally approved for scheduling and release.',
    `certification_status` STRING COMMENT 'Status of first-party platform certification review (TRC/TCR compliance for console manufacturers): not_submitted, submitted, in_review, approved, rejected.. Valid values are `not_submitted|submitted|in_review|approved|rejected`',
    `content_rating` STRING COMMENT 'Age-appropriateness rating assigned to event content by governing bodies (e.g., ESRB: E10+, PEGI: 12, CERO: B). May differ from base game rating if event introduces new content themes.',
    `content_version` STRING COMMENT 'Semantic version number of the event content package in Perforce Helix Core or content management system (e.g., v1.2.0). Tracks asset versioning and deployment history.. Valid values are `^v[0-9]+.[0-9]+.[0-9]+$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the seasonal event record was first created in the content management system.',
    `end_timestamp` TIMESTAMP COMMENT 'Date and time when the seasonal event concludes and is no longer accessible to players. Marks the official close of the event window.',
    `estimated_participation_count` STRING COMMENT 'Projected number of unique players expected to participate in the event, based on historical data, player base size, and marketing reach. Used for capacity planning.',
    `event_budget_amount` DECIMAL(18,2) COMMENT 'Total allocated budget for event development, marketing, and operations (in USD or base currency). Includes content creation, QA, localization, and promotional spend.',
    `event_code` STRING COMMENT 'Unique business identifier code for the seasonal event used across systems and marketing materials (e.g., WINTER_2024, HALLOWEEN_23, ANNIVERSARY_5YR).. Valid values are `^[A-Z0-9_]{4,20}$`',
    `event_name` STRING COMMENT 'Human-readable display name of the seasonal event shown to players in-game and in marketing channels.',
    `event_status` STRING COMMENT 'Current lifecycle state of the seasonal event: draft (in planning), scheduled (approved and queued), active (live in-game), paused (temporarily suspended), completed (ended successfully), cancelled (terminated before completion).. Valid values are `draft|scheduled|active|paused|completed|cancelled`',
    `event_theme` STRING COMMENT 'Creative theme or narrative concept for the event (e.g., Winter Wonderland, Spooky Halloween, Summer Beach Party, Lunar New Year).',
    `event_type` STRING COMMENT 'Classification of the seasonal event by business purpose: holiday (calendar-based celebrations), anniversary (game/studio milestones), esports_tie_in (tournament promotions), promotional (marketing campaigns), seasonal (quarterly/seasonal content drops), community (player-driven events), limited_time_offer (flash sales/special offers). [ENUM-REF-CANDIDATE: holiday|anniversary|esports_tie_in|promotional|seasonal|community|limited_time_offer — 7 candidates stripped; promote to reference product]',
    `exclusive_cosmetic_reward_ids` STRING COMMENT 'Comma-separated list of exclusive cosmetic item identifiers (skins, emotes, banners, avatars) available only during this event as participation rewards or purchasable items.',
    `featured_content_bundle_ids` STRING COMMENT 'Comma-separated list of content bundle identifiers associated with this event, including new maps, levels, missions, or story chapters released as part of the event.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the user who most recently updated the seasonal event record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the seasonal event record was most recently updated.',
    `localization_status` STRING COMMENT 'Current state of localization and translation work for event strings, UI text, and narrative content across supported languages.. Valid values are `not_started|in_progress|completed|approved`',
    `min_player_level` STRING COMMENT 'Minimum player level required to access and participate in the seasonal event. Null if no level restriction applies.',
    `notes` STRING COMMENT 'Free-text field for internal notes, special instructions, lessons learned, or operational context related to the event planning, execution, or post-mortem analysis.',
    `participation_mechanics` STRING COMMENT 'Description of how players engage with the event: gameplay modes, quest chains, challenges, leaderboards, or special activities required for participation and reward earning.',
    `player_eligibility_rules` STRING COMMENT 'Business rules defining which players can participate in the event, including level requirements, region restrictions, account age, previous event participation, or VIP status criteria.',
    `qa_status` STRING COMMENT 'Current state of quality assurance testing for the event: not_started, in_progress, passed (approved for release), failed (issues found), blocked (dependencies unmet).. Valid values are `not_started|in_progress|passed|failed|blocked`',
    `recurrence_pattern` STRING COMMENT 'Frequency pattern indicating if and how the event repeats: one_time (single occurrence), annual (yearly), quarterly (every 3 months), monthly, weekly, custom (irregular schedule defined separately).. Valid values are `one_time|annual|quarterly|monthly|weekly|custom`',
    `recurrence_schedule` STRING COMMENT 'Detailed schedule specification for recurring events, including specific dates, times, or calendar rules (e.g., Every December 15-31, First weekend of each quarter). Null for one-time events.',
    `reward_structure` STRING COMMENT 'Detailed description of the reward distribution model: milestone-based, leaderboard rankings, participation tiers, daily login bonuses, or completion-based rewards.',
    `start_timestamp` TIMESTAMP COMMENT 'Date and time when the seasonal event becomes active and visible to eligible players in-game. Represents the go-live moment for the event.',
    `supported_languages` STRING COMMENT 'Comma-separated list of ISO 639-1 language codes for which event content has been localized (e.g., en,es,fr,de,ja,zh,pt,ru).',
    `target_dau_lift_percent` DECIMAL(18,2) COMMENT 'Target percentage increase in Daily Active Users (DAU) expected during the event period compared to baseline. Key performance indicator for event success.',
    `target_revenue_amount` DECIMAL(18,2) COMMENT 'Target incremental revenue (in USD or base currency) expected from event-related in-app purchases (IAP), microtransactions (MTX), and battle pass sales during the event window.',
    CONSTRAINT pk_seasonal_event PRIMARY KEY(`seasonal_event_id`)
) COMMENT 'Seasonal or limited-time event definition record capturing the creative and operational parameters of a live-ops event — holiday events, anniversary events, esports tie-ins, and promotional events. Stores event name, event theme, start and end timestamps, recurrence pattern, featured content bundles, exclusive cosmetic rewards, participation mechanics, player eligibility rules, and marketing campaign reference. Owned by content as the creative deliverable layer; monetization domain owns the associated IAP/MTX pricing.';

CREATE OR REPLACE TABLE `gaming_ecm`.`content`.`content_deployment` (
    `content_deployment_id` BIGINT COMMENT 'Unique identifier for the content deployment event. Primary key.',
    `age_rating_cert_id` BIGINT COMMENT 'Foreign key linking to compliance.age_rating_cert. Business justification: Deployment gates require valid certification for target platform/region. Platform holder certification validation before CDN push requires linking deployments to ESRB/PEGI records for automated approv',
    `build_id` BIGINT COMMENT 'Foreign key linking to studio.build. Business justification: A content_deployment deploys a specific build artifact. content_deployment.build_number is a denormalized string; a FK to studio.build enables deployment pipeline traceability, rollback identification',
    `cdn_node_id` BIGINT COMMENT 'Foreign key linking to infrastructure.cdn_node. Business justification: Deployment pipelines target specific CDN nodes for asset distribution, ops teams monitor per-node cache warming and bandwidth utilization during rollouts, and rollback procedures revert CDN node confi',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to licensing.compliance_obligation. Business justification: Content deployments must pass compliance checks for territory restrictions, rating requirements, and platform certification mandated by licensing agreements to prevent distribution violations, regulat',
    `content_release_id` BIGINT COMMENT 'Reference to the content drop or asset bundle being deployed.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title receiving this deployment.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Deployments are jurisdiction-specific for data residency (GDPR), content restrictions (China server requirements), and regulatory windows (Korea shutdown law). Ops teams schedule deployments by jurisd',
    `network_region_id` BIGINT COMMENT 'Foreign key linking to infrastructure.network_region. Business justification: Content deployments are region-specific for data residency compliance and latency optimization. Release managers coordinate deployments by region to manage player impact windows, CDN pre-warming sched',
    `patch_id` BIGINT COMMENT 'Foreign key linking to content.patch. Business justification: Content deployments need to track which specific patch is being pushed to live environments. One deployment pushes ONE patch to a specific environment/region; one patch can have MANY deployments (mult',
    `platform_sku_id` BIGINT COMMENT 'Foreign key linking to platform.platform_sku. Business justification: SKU-level deployment tracking: content deployments update specific platform SKUs. Deployment teams track which platform_sku is being updated for version management, player update notification triggers',
    `seasonal_event_id` BIGINT COMMENT 'Foreign key linking to content.seasonal_event. Business justification: Content deployments need to track which seasonal event is being activated in live environments. One deployment activates ONE seasonal event in a specific region; one seasonal event can have MANY deplo',
    `server_fleet_id` BIGINT COMMENT 'Foreign key linking to infrastructure.server_fleet. Business justification: Content deployments target specific server fleets. This is the primary operational link between content release management and infrastructure capacity planning, enabling fleet-level deployment trackin',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to platform.storefront. Business justification: Platform-specific content deployment targeting: content deployments target specific storefronts for distribution. Deployment teams need this link for platform-specific rollout management, cert complia',
    `tournament_id` BIGINT COMMENT 'Foreign key linking to esports.tournament. Business justification: Content deployments are scheduled around esports tournaments to avoid disrupting competitive play (e.g., Riot freezing patches during Worlds). A tournament FK on content_deployment supports deployment',
    `approval_status` STRING COMMENT 'Approval status indicating whether the deployment was reviewed and authorized before execution.. Valid values are `pending|approved|rejected|auto_approved`',
    `approval_timestamp` TIMESTAMP COMMENT 'The exact date and time when the deployment was approved for execution.',
    `asset_bundle_size_mb` DECIMAL(18,2) COMMENT 'Total size of the deployed asset bundle in megabytes, representing the download size for players.',
    `asset_count` STRING COMMENT 'Total number of individual assets (textures, models, audio files, localization strings, etc.) included in this deployment.',
    `cdn_distribution_status` STRING COMMENT 'Status of the content distribution across the CDN (Content Delivery Network) nodes: not started, distributing (in progress), distributed (fully propagated), failed (distribution error), or partial (some nodes updated).. Valid values are `not_started|distributing|distributed|failed|partial`',
    `cdn_endpoint_url` STRING COMMENT 'The primary CDN (Content Delivery Network) endpoint URL where the deployed content is accessible to players.',
    `completed_timestamp` TIMESTAMP COMMENT 'The exact date and time when the deployment was successfully completed or failed.',
    `created_timestamp` TIMESTAMP COMMENT 'Audit timestamp indicating when this deployment record was first created in the system.',
    `deployment_method` STRING COMMENT 'The technical approach used to deploy the content: full push (complete asset bundle), delta patch (incremental changes), hotfix (emergency fix), rollback (revert to previous version), staged rollout (phased deployment), or canary (limited test deployment).. Valid values are `full_push|delta_patch|hotfix|rollback|staged_rollout|canary`',
    `deployment_number` STRING COMMENT 'Externally-known unique identifier for this deployment event, used for tracking and audit purposes.. Valid values are `^DEP-[0-9]{8}-[A-Z0-9]{6}$`',
    `deployment_status` STRING COMMENT 'Current lifecycle status of the deployment event.. Valid values are `pending|in_progress|completed|failed|rolled_back|cancelled`',
    `deployment_timestamp` TIMESTAMP COMMENT 'The exact date and time when the deployment was initiated to the live environment or CDN (Content Delivery Network) endpoint.',
    `deployment_type` STRING COMMENT 'Classification of the deployment by business purpose: content drop (scheduled release), patch (bug fix), hotfix (emergency fix), DLC (Downloadable Content), seasonal event (limited-time content), or live ops (ongoing service update).. Valid values are `content_drop|patch|hotfix|dlc|seasonal_event|live_ops`',
    `downtime_duration_minutes` STRING COMMENT 'Total duration in minutes that the game or service was offline for this deployment, if downtime was required.',
    `downtime_required_flag` BOOLEAN COMMENT 'Indicates whether the deployment required taking the game or service offline (True) or was deployed with zero downtime (False).',
    `duration_seconds` STRING COMMENT 'Total time in seconds from deployment initiation to completion or failure.',
    `error_message` STRING COMMENT 'Technical error message or stack trace if the deployment failed, used for troubleshooting and root cause analysis.',
    `modified_timestamp` TIMESTAMP COMMENT 'Audit timestamp indicating when this deployment record was last updated.',
    `notes` STRING COMMENT 'Free-text notes or comments from the deployer describing the deployment context, special instructions, or known issues.',
    `perforce_changelist_number` STRING COMMENT 'The Perforce Helix Core changelist number associated with this deployment, providing version control traceability.',
    `player_impact_level` STRING COMMENT 'Assessment of the expected impact on live players: none (backend only), low (minor changes), medium (noticeable changes), high (significant gameplay changes), or critical (major content update or fix).. Valid values are `none|low|medium|high|critical`',
    `post_deployment_validation_status` STRING COMMENT 'Status of automated or manual validation checks performed after deployment to verify content integrity and functionality.. Valid values are `not_started|in_progress|passed|failed|skipped`',
    `region_codes` STRING COMMENT 'Comma-separated list of geographic region codes where this deployment was pushed (e.g., NAM, EUR, APAC, LATAM). Used for geo-specific content rollouts.',
    `retry_count` STRING COMMENT 'Number of times the deployment was retried after initial failure before succeeding or being abandoned.',
    `rollback_flag` BOOLEAN COMMENT 'Indicates whether this deployment was subsequently rolled back due to issues (True) or remains active (False).',
    `rollback_reason` STRING COMMENT 'Business justification or technical reason for rolling back the deployment (e.g., critical bug, performance degradation, player complaints).',
    `rollback_timestamp` TIMESTAMP COMMENT 'The exact date and time when the deployment was rolled back, if applicable. Null if no rollback occurred.',
    `target_environment` STRING COMMENT 'The environment to which the content is being deployed: dev (development), qa (quality assurance), uat (user acceptance testing), staging (pre-production), production (live), or live (player-facing).. Valid values are `dev|qa|uat|staging|production|live`',
    `target_platform_codes` STRING COMMENT 'Comma-separated list of platform codes targeted by this deployment (e.g., PC, PS5, XBOX, IOS, ANDROID, SWITCH). Represents the platforms receiving this content drop.',
    `window_end` TIMESTAMP COMMENT 'The scheduled end time of the deployment maintenance window.',
    `window_start` TIMESTAMP COMMENT 'The scheduled start time of the deployment maintenance window.',
    CONSTRAINT pk_content_deployment PRIMARY KEY(`content_deployment_id`)
) COMMENT 'Deployment event record capturing the act of pushing a content drop, patch, or asset bundle to a live environment or CDN endpoint. Stores deployment timestamp, deployer identity, target environment (dev, staging, live), target platform(s), CDN distribution status, deployment method (full push, delta patch, hotfix), rollback flag, rollback timestamp, deployment duration, and post-deployment validation status. The operational log of every content change reaching live players.';

CREATE OR REPLACE TABLE `gaming_ecm`.`content`.`bundle_manifest_entry` (
    `bundle_manifest_entry_id` BIGINT COMMENT 'Primary key for the bundle_manifest_entry association',
    `asset_bundle_id` BIGINT COMMENT 'Foreign key linking to the asset bundle that contains this asset',
    `asset_id` BIGINT COMMENT 'Foreign key linking to the asset included in this bundle',
    `asset_count` STRING COMMENT 'Total number of individual assets (textures, models, audio files, localization strings, etc.) packaged within this bundle. [Moved from asset_bundle: This is a denormalized aggregate that should be computed from the bundle_manifest_entry association table rather than stored redundantly on asset_bundle. The COUNT of manifest entries provides the true asset count.]',
    `asset_order_in_bundle` STRING COMMENT 'Sequential position of the asset within the bundle manifest, used for load order optimization and dependency resolution',
    `asset_role_in_bundle` STRING COMMENT 'Functional role of the asset within this specific bundle: primary (core content), dependency (required by other assets), optional (can be lazy-loaded), fallback (used if primary fails), locale_variant (language-specific version)',
    `compression_override` STRING COMMENT 'Bundle-specific compression setting that overrides the assets default compression format for this particular packaging context',
    `exclusion_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this asset should be excluded from the bundle in the next build (soft delete for manifest management)',
    `inclusion_timestamp` TIMESTAMP COMMENT 'Timestamp when the asset was added to this bundle manifest, used for version control and audit trail',
    `is_primary_asset` BOOLEAN COMMENT 'Boolean flag indicating whether this asset is a primary deliverable of the bundle (true) or a supporting dependency (false)',
    `last_verified_timestamp` TIMESTAMP COMMENT 'Timestamp when the assets inclusion in this bundle was last verified by the build system or QA',
    `load_priority` STRING COMMENT 'Priority value for asset loading within the bundle (lower numbers load first), used by the game engines streaming system',
    `lod_tier_override` STRING COMMENT 'Level of Detail tier override for this asset in this specific bundle, allowing the same asset to be packaged at different quality levels for different bundles (e.g., mobile vs console builds)',
    CONSTRAINT pk_bundle_manifest_entry PRIMARY KEY(`bundle_manifest_entry_id`)
) COMMENT 'This association product represents the inclusion of a specific asset within an asset bundles manifest. It captures the operational reality of game content packaging where assets are explicitly assigned to bundles with specific ordering, roles, and LOD configurations. Each record links one asset_bundle to one asset with metadata that exists only in the context of this packaging relationship.. Existence Justification: In game development, bundle manifests are operational artifacts that content engineers actively create, version, and manage. A single asset (e.g., a character texture) is routinely packaged into multiple bundles (base game, DLC, platform-specific builds, patch bundles) with different compression settings, LOD tiers, and load priorities. Conversely, each bundle contains hundreds to thousands of assets with explicit ordering and role assignments. This is a core content pipeline operation, not an analytical correlation.';

CREATE OR REPLACE TABLE `gaming_ecm`.`content`.`npc_spawn_configuration` (
    `npc_spawn_configuration_id` BIGINT COMMENT 'Unique identifier for this NPC spawn configuration record. Primary key.',
    `level_map_id` BIGINT COMMENT 'Foreign key linking to the level map where this NPC spawn configuration is defined',
    `npc_definition_id` BIGINT COMMENT 'Foreign key linking to the NPC definition archetype configured to spawn in this level',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this spawn configuration was first created by a level designer.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this spawn configuration is currently active in the level build. Used for A/B testing encounters or seasonal event configurations.',
    `is_boss_variant` BOOLEAN COMMENT 'Indicates whether this spawn configuration represents a boss encounter variant with modified stats or behavior for this specific level.',
    `level_specific_loot_override` STRING COMMENT 'Reference to a level-specific loot table that overrides the NPC definitions default loot table for this particular level. Used for level-specific rewards.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this spawn configuration was last modified during encounter balancing or level iteration.',
    `spawn_count_max` STRING COMMENT 'Maximum number of instances of this NPC archetype that can spawn simultaneously in this level. Used for encounter balancing and performance budgeting.',
    `spawn_count_min` STRING COMMENT 'Minimum number of instances of this NPC archetype that can spawn simultaneously in this level. Used for encounter balancing and performance budgeting.',
    `spawn_weight` DECIMAL(18,2) COMMENT 'Relative probability weight for this NPC archetype spawning in this level compared to other configured NPCs. Used for randomized encounter variety.',
    `spawn_zone_code` STRING COMMENT 'Identifier for the specific spawn zone or region within the level where this NPC archetype is configured to appear. References level geometry zones.',
    CONSTRAINT pk_npc_spawn_configuration PRIMARY KEY(`npc_spawn_configuration_id`)
) COMMENT 'This association product represents the spawn configuration between level_map and npc_definition. It captures the authoritative encounter design decisions made by level designers specifying which NPC archetypes appear in which levels, under what conditions, and with what spawn parameters. Each record links one level_map to one npc_definition with spawn-specific attributes that exist only in the context of this level-NPC pairing.. Existence Justification: In game development, level designers actively manage encounter design by configuring which NPC archetypes spawn in which levels. A single level contains multiple different NPC types (enemies, vendors, quest givers), and a single NPC archetype definition is reused across multiple levels with level-specific spawn parameters. This is a recognized operational business process called encounter design or spawn configuration management.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `gaming_ecm`.`content`.`asset` ADD CONSTRAINT `fk_content_asset_parent_asset_id` FOREIGN KEY (`parent_asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ADD CONSTRAINT `fk_content_asset_version_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ADD CONSTRAINT `fk_content_asset_version_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ADD CONSTRAINT `fk_content_asset_version_rollback_from_version_id` FOREIGN KEY (`rollback_from_version_id`) REFERENCES `gaming_ecm`.`content`.`asset_version`(`asset_version_id`);
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ADD CONSTRAINT `fk_content_asset_bundle_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ADD CONSTRAINT `fk_content_localization_string_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`content`.`localization_translation` ADD CONSTRAINT `fk_content_localization_translation_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`content`.`localization_translation` ADD CONSTRAINT `fk_content_localization_translation_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`content`.`localization_translation` ADD CONSTRAINT `fk_content_localization_translation_localization_string_id` FOREIGN KEY (`localization_string_id`) REFERENCES `gaming_ecm`.`content`.`localization_string`(`localization_string_id`);
ALTER TABLE `gaming_ecm`.`content`.`level_map` ADD CONSTRAINT `fk_content_level_map_asset_bundle_id` FOREIGN KEY (`asset_bundle_id`) REFERENCES `gaming_ecm`.`content`.`asset_bundle`(`asset_bundle_id`);
ALTER TABLE `gaming_ecm`.`content`.`level_map` ADD CONSTRAINT `fk_content_level_map_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`content`.`level_map` ADD CONSTRAINT `fk_content_level_map_seasonal_event_id` FOREIGN KEY (`seasonal_event_id`) REFERENCES `gaming_ecm`.`content`.`seasonal_event`(`seasonal_event_id`);
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ADD CONSTRAINT `fk_content_npc_definition_asset_bundle_id` FOREIGN KEY (`asset_bundle_id`) REFERENCES `gaming_ecm`.`content`.`asset_bundle`(`asset_bundle_id`);
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ADD CONSTRAINT `fk_content_npc_definition_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ADD CONSTRAINT `fk_content_npc_definition_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`content`.`patch` ADD CONSTRAINT `fk_content_patch_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ADD CONSTRAINT `fk_content_seasonal_event_asset_bundle_id` FOREIGN KEY (`asset_bundle_id`) REFERENCES `gaming_ecm`.`content`.`asset_bundle`(`asset_bundle_id`);
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ADD CONSTRAINT `fk_content_seasonal_event_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ADD CONSTRAINT `fk_content_content_deployment_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ADD CONSTRAINT `fk_content_content_deployment_patch_id` FOREIGN KEY (`patch_id`) REFERENCES `gaming_ecm`.`content`.`patch`(`patch_id`);
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ADD CONSTRAINT `fk_content_content_deployment_seasonal_event_id` FOREIGN KEY (`seasonal_event_id`) REFERENCES `gaming_ecm`.`content`.`seasonal_event`(`seasonal_event_id`);
ALTER TABLE `gaming_ecm`.`content`.`bundle_manifest_entry` ADD CONSTRAINT `fk_content_bundle_manifest_entry_asset_bundle_id` FOREIGN KEY (`asset_bundle_id`) REFERENCES `gaming_ecm`.`content`.`asset_bundle`(`asset_bundle_id`);
ALTER TABLE `gaming_ecm`.`content`.`bundle_manifest_entry` ADD CONSTRAINT `fk_content_bundle_manifest_entry_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`content`.`npc_spawn_configuration` ADD CONSTRAINT `fk_content_npc_spawn_configuration_level_map_id` FOREIGN KEY (`level_map_id`) REFERENCES `gaming_ecm`.`content`.`level_map`(`level_map_id`);
ALTER TABLE `gaming_ecm`.`content`.`npc_spawn_configuration` ADD CONSTRAINT `fk_content_npc_spawn_configuration_npc_definition_id` FOREIGN KEY (`npc_definition_id`) REFERENCES `gaming_ecm`.`content`.`npc_definition`(`npc_definition_id`);

-- ========= TAGS =========
ALTER SCHEMA `gaming_ecm`.`content` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `gaming_ecm`.`content` SET TAGS ('dbx_domain' = 'content');
ALTER TABLE `gaming_ecm`.`content`.`asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`content`.`asset` SET TAGS ('dbx_subdomain' = 'asset_production');
ALTER TABLE `gaming_ecm`.`content`.`asset` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier');
ALTER TABLE `gaming_ecm`.`content`.`asset` ALTER COLUMN `age_rating_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Age Rating Cert Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`asset` ALTER COLUMN `game_server_id` SET TAGS ('dbx_business_glossary_term' = 'Game Server Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`asset` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Studio ID');
ALTER TABLE `gaming_ecm`.`content`.`asset` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`content`.`asset` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`asset` ALTER COLUMN `parent_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Asset ID');
ALTER TABLE `gaming_ecm`.`content`.`asset` ALTER COLUMN `repo_id` SET TAGS ('dbx_business_glossary_term' = 'Repo Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`asset` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `gaming_ecm`.`content`.`asset` ALTER COLUMN `asset_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Code');
ALTER TABLE `gaming_ecm`.`content`.`asset` ALTER COLUMN `asset_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Description');
ALTER TABLE `gaming_ecm`.`content`.`asset` ALTER COLUMN `asset_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Name');
ALTER TABLE `gaming_ecm`.`content`.`asset` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Type');
ALTER TABLE `gaming_ecm`.`content`.`asset` ALTER COLUMN `audio_bit_depth` SET TAGS ('dbx_business_glossary_term' = 'Audio Bit Depth');
ALTER TABLE `gaming_ecm`.`content`.`asset` ALTER COLUMN `audio_channel_config` SET TAGS ('dbx_business_glossary_term' = 'Audio Channel Configuration');
ALTER TABLE `gaming_ecm`.`content`.`asset` ALTER COLUMN `audio_channel_config` SET TAGS ('dbx_value_regex' = 'mono|stereo|5.1|7.1|atmos');
ALTER TABLE `gaming_ecm`.`content`.`asset` ALTER COLUMN `audio_middleware_format` SET TAGS ('dbx_business_glossary_term' = 'Audio Middleware Format');
ALTER TABLE `gaming_ecm`.`content`.`asset` ALTER COLUMN `audio_middleware_format` SET TAGS ('dbx_value_regex' = 'wwise|fmod|unity_audio|unreal_audio|proprietary');
ALTER TABLE `gaming_ecm`.`content`.`asset` ALTER COLUMN `audio_sample_rate_hz` SET TAGS ('dbx_business_glossary_term' = 'Audio Sample Rate (Hz)');
ALTER TABLE `gaming_ecm`.`content`.`asset` ALTER COLUMN `cdn_url` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) URL');
ALTER TABLE `gaming_ecm`.`content`.`asset` ALTER COLUMN `classification_tags` SET TAGS ('dbx_business_glossary_term' = 'Classification Tags');
ALTER TABLE `gaming_ecm`.`content`.`asset` ALTER COLUMN `content_hash` SET TAGS ('dbx_business_glossary_term' = 'Content Hash');
ALTER TABLE `gaming_ecm`.`content`.`asset` ALTER COLUMN `deprecated_date` SET TAGS ('dbx_business_glossary_term' = 'Deprecated Date');
ALTER TABLE `gaming_ecm`.`content`.`asset` ALTER COLUMN `download_count` SET TAGS ('dbx_business_glossary_term' = 'Download Count');
ALTER TABLE `gaming_ecm`.`content`.`asset` ALTER COLUMN `drm_protected` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Protected Flag');
ALTER TABLE `gaming_ecm`.`content`.`asset` ALTER COLUMN `engine_compatibility` SET TAGS ('dbx_business_glossary_term' = 'Engine Compatibility');
ALTER TABLE `gaming_ecm`.`content`.`asset` ALTER COLUMN `engine_compatibility` SET TAGS ('dbx_value_regex' = 'unity|unreal|proprietary|cross_engine');
ALTER TABLE `gaming_ecm`.`content`.`asset` ALTER COLUMN `feature_area` SET TAGS ('dbx_business_glossary_term' = 'Feature Area');
ALTER TABLE `gaming_ecm`.`content`.`asset` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size (Bytes)');
ALTER TABLE `gaming_ecm`.`content`.`asset` ALTER COLUMN `format` SET TAGS ('dbx_business_glossary_term' = 'Asset Format');
ALTER TABLE `gaming_ecm`.`content`.`asset` ALTER COLUMN `ip_rights_status` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Rights Status');
ALTER TABLE `gaming_ecm`.`content`.`asset` ALTER COLUMN `ip_rights_status` SET TAGS ('dbx_value_regex' = 'owned|licensed|third_party|public_domain|pending');
ALTER TABLE `gaming_ecm`.`content`.`asset` ALTER COLUMN `ip_rights_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`content`.`asset` ALTER COLUMN `is_locale_variant` SET TAGS ('dbx_business_glossary_term' = 'Is Locale Variant Flag');
ALTER TABLE `gaming_ecm`.`content`.`asset` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `gaming_ecm`.`content`.`asset` ALTER COLUMN `license_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiry Date');
ALTER TABLE `gaming_ecm`.`content`.`asset` ALTER COLUMN `license_expiry_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`content`.`asset` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `gaming_ecm`.`content`.`asset` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'draft|review|approved|published|deprecated|archived');
ALTER TABLE `gaming_ecm`.`content`.`asset` ALTER COLUMN `lod_tier` SET TAGS ('dbx_business_glossary_term' = 'Level of Detail (LOD) Tier');
ALTER TABLE `gaming_ecm`.`content`.`asset` ALTER COLUMN `lod_tier` SET TAGS ('dbx_value_regex' = 'lod0|lod1|lod2|lod3|lod4|lod5');
ALTER TABLE `gaming_ecm`.`content`.`asset` ALTER COLUMN `moderation_status` SET TAGS ('dbx_business_glossary_term' = 'Moderation Status');
ALTER TABLE `gaming_ecm`.`content`.`asset` ALTER COLUMN `moderation_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|flagged|under_review');
ALTER TABLE `gaming_ecm`.`content`.`asset` ALTER COLUMN `platform_target` SET TAGS ('dbx_business_glossary_term' = 'Platform Target');
ALTER TABLE `gaming_ecm`.`content`.`asset` ALTER COLUMN `published_date` SET TAGS ('dbx_business_glossary_term' = 'Published Date');
ALTER TABLE `gaming_ecm`.`content`.`asset` ALTER COLUMN `resolution_spec` SET TAGS ('dbx_business_glossary_term' = 'Resolution Specification');
ALTER TABLE `gaming_ecm`.`content`.`asset` ALTER COLUMN `supported_locales` SET TAGS ('dbx_business_glossary_term' = 'Supported Locales');
ALTER TABLE `gaming_ecm`.`content`.`asset` ALTER COLUMN `ugc_flag` SET TAGS ('dbx_business_glossary_term' = 'User-Generated Content (UGC) Flag');
ALTER TABLE `gaming_ecm`.`content`.`asset` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `gaming_ecm`.`content`.`asset` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `gaming_ecm`.`content`.`asset` ALTER COLUMN `creation_date` SET TAGS ('dbx_business_glossary_term' = 'Creation Date');
ALTER TABLE `gaming_ecm`.`content`.`asset_version` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`content`.`asset_version` SET TAGS ('dbx_subdomain' = 'asset_production');
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Version ID');
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Drop ID');
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Studio ID');
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ALTER COLUMN `repo_id` SET TAGS ('dbx_business_glossary_term' = 'Repo Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ALTER COLUMN `rollback_from_version_id` SET TAGS ('dbx_business_glossary_term' = 'Rollback From Version ID');
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ALTER COLUMN `asset_category` SET TAGS ('dbx_business_glossary_term' = 'Asset Category');
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ALTER COLUMN `audio_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Audio Duration (Seconds)');
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ALTER COLUMN `branch_name` SET TAGS ('dbx_business_glossary_term' = 'Branch Name');
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ALTER COLUMN `build_error_message` SET TAGS ('dbx_business_glossary_term' = 'Build Error Message');
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ALTER COLUMN `build_pipeline_status` SET TAGS ('dbx_business_glossary_term' = 'Build Pipeline Status');
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ALTER COLUMN `build_pipeline_status` SET TAGS ('dbx_value_regex' = 'pending|processing|success|failed|skipped');
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ALTER COLUMN `build_pipeline_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Build Pipeline Timestamp');
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ALTER COLUMN `cdn_distribution_status` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Distribution Status');
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ALTER COLUMN `cdn_distribution_status` SET TAGS ('dbx_value_regex' = 'not_distributed|distributing|distributed|failed');
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ALTER COLUMN `cdn_distribution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Distribution Timestamp');
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ALTER COLUMN `change_description` SET TAGS ('dbx_business_glossary_term' = 'Change Description');
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ALTER COLUMN `changelist_number` SET TAGS ('dbx_business_glossary_term' = 'Changelist Number (CL)');
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_business_glossary_term' = 'Checksum (MD5)');
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_value_regex' = '^[a-f0-9]{32}$');
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ALTER COLUMN `commit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Commit Timestamp');
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ALTER COLUMN `compression_format` SET TAGS ('dbx_business_glossary_term' = 'Compression Format');
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ALTER COLUMN `deprecated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deprecated Timestamp');
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ALTER COLUMN `drm_protected` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Protected');
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size (Bytes)');
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ALTER COLUMN `file_size_delta_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size Delta (Bytes)');
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ALTER COLUMN `file_type` SET TAGS ('dbx_business_glossary_term' = 'File Type');
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ALTER COLUMN `is_deprecated` SET TAGS ('dbx_business_glossary_term' = 'Is Deprecated');
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ALTER COLUMN `localization_language_code` SET TAGS ('dbx_business_glossary_term' = 'Localization Language Code');
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ALTER COLUMN `localization_language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ALTER COLUMN `lod_level` SET TAGS ('dbx_business_glossary_term' = 'Level of Detail (LOD) Level');
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ALTER COLUMN `platform_target` SET TAGS ('dbx_business_glossary_term' = 'Platform Target');
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ALTER COLUMN `polygon_count` SET TAGS ('dbx_business_glossary_term' = 'Polygon Count');
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ALTER COLUMN `promoted_to_live_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Promoted to Live Timestamp');
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ALTER COLUMN `promoted_to_staging_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Promoted to Staging Timestamp');
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ALTER COLUMN `promotion_stage` SET TAGS ('dbx_business_glossary_term' = 'Promotion Stage');
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ALTER COLUMN `promotion_stage` SET TAGS ('dbx_value_regex' = 'dev|qa|staging|live|archived');
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ALTER COLUMN `texture_resolution` SET TAGS ('dbx_business_glossary_term' = 'Texture Resolution');
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ALTER COLUMN `ugc_moderation_status` SET TAGS ('dbx_business_glossary_term' = 'User-Generated Content (UGC) Moderation Status');
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ALTER COLUMN `ugc_moderation_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|flagged|none');
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` SET TAGS ('dbx_subdomain' = 'asset_production');
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ALTER COLUMN `asset_bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Bundle Identifier (ID)');
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ALTER COLUMN `age_rating_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Age Rating Cert Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ALTER COLUMN `cdn_node_id` SET TAGS ('dbx_business_glossary_term' = 'Cdn Node Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Drop Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Studio Identifier (ID)');
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title Identifier (ID)');
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ALTER COLUMN `server_fleet_id` SET TAGS ('dbx_business_glossary_term' = 'Server Fleet Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ALTER COLUMN `build_configuration` SET TAGS ('dbx_business_glossary_term' = 'Build Configuration');
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ALTER COLUMN `build_configuration` SET TAGS ('dbx_value_regex' = 'debug|development|shipping|gold_master');
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ALTER COLUMN `bundle_code` SET TAGS ('dbx_business_glossary_term' = 'Bundle Code');
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ALTER COLUMN `bundle_name` SET TAGS ('dbx_business_glossary_term' = 'Bundle Name');
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ALTER COLUMN `bundle_status` SET TAGS ('dbx_business_glossary_term' = 'Bundle Status');
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ALTER COLUMN `bundle_status` SET TAGS ('dbx_value_regex' = 'draft|in_development|qa_testing|approved|published|deprecated');
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ALTER COLUMN `bundle_type` SET TAGS ('dbx_business_glossary_term' = 'Bundle Type');
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ALTER COLUMN `bundle_type` SET TAGS ('dbx_value_regex' = 'base_game|dlc|hotfix|patch|seasonal_event|expansion');
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ALTER COLUMN `cdn_distribution_path` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Distribution Path');
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ALTER COLUMN `cdn_distribution_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ALTER COLUMN `compressed_size_mb` SET TAGS ('dbx_business_glossary_term' = 'Compressed Size (Megabytes)');
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ALTER COLUMN `compression_format` SET TAGS ('dbx_business_glossary_term' = 'Compression Format');
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ALTER COLUMN `compression_format` SET TAGS ('dbx_value_regex' = 'zip|gzip|lz4|zstd|proprietary');
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ALTER COLUMN `deprecated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deprecated Timestamp');
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ALTER COLUMN `download_count` SET TAGS ('dbx_business_glossary_term' = 'Download Count');
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ALTER COLUMN `encryption_enabled` SET TAGS ('dbx_business_glossary_term' = 'Encryption Enabled Flag');
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ALTER COLUMN `error_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Download Error Rate (Percent)');
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ALTER COLUMN `localization_languages` SET TAGS ('dbx_business_glossary_term' = 'Localization Languages');
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ALTER COLUMN `lod_variant_included` SET TAGS ('dbx_business_glossary_term' = 'Level of Detail (LOD) Variant Included Flag');
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ALTER COLUMN `manifest_hash` SET TAGS ('dbx_business_glossary_term' = 'Bundle Manifest Hash');
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ALTER COLUMN `minimum_engine_version` SET TAGS ('dbx_business_glossary_term' = 'Minimum Engine Version');
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Bundle Notes');
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ALTER COLUMN `published_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Published Timestamp');
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ALTER COLUMN `requires_player_consent` SET TAGS ('dbx_business_glossary_term' = 'Requires Player Consent Flag');
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ALTER COLUMN `target_platform` SET TAGS ('dbx_business_glossary_term' = 'Target Platform');
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ALTER COLUMN `ugc_content_included` SET TAGS ('dbx_business_glossary_term' = 'User-Generated Content (UGC) Included Flag');
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ALTER COLUMN `uncompressed_size_mb` SET TAGS ('dbx_business_glossary_term' = 'Uncompressed Size (Megabytes)');
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `gaming_ecm`.`content`.`localization_string` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`content`.`localization_string` SET TAGS ('dbx_subdomain' = 'localization_management');
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ALTER COLUMN `localization_string_id` SET TAGS ('dbx_business_glossary_term' = 'Localization String ID');
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Audio Asset Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ALTER COLUMN `audio_vo_required` SET TAGS ('dbx_business_glossary_term' = 'Audio Voice-Over (VO) Required');
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ALTER COLUMN `character_limit` SET TAGS ('dbx_business_glossary_term' = 'Character Limit');
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ALTER COLUMN `content_warning_flags` SET TAGS ('dbx_business_glossary_term' = 'Content Warning Flags');
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ALTER COLUMN `context_notes` SET TAGS ('dbx_business_glossary_term' = 'Context Notes');
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ALTER COLUMN `deployment_date` SET TAGS ('dbx_business_glossary_term' = 'Deployment Date');
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ALTER COLUMN `deployment_status` SET TAGS ('dbx_business_glossary_term' = 'Deployment Status');
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ALTER COLUMN `deployment_status` SET TAGS ('dbx_value_regex' = 'draft|staged|deployed|archived');
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ALTER COLUMN `deprecation_date` SET TAGS ('dbx_business_glossary_term' = 'Deprecation Date');
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ALTER COLUMN `esrb_rating_impact` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Software Rating Board (ESRB) Rating Impact');
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ALTER COLUMN `esrb_rating_impact` SET TAGS ('dbx_value_regex' = 'none|mild|moderate|strong');
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ALTER COLUMN `feature_area` SET TAGS ('dbx_business_glossary_term' = 'Feature Area');
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ALTER COLUMN `gender_variant_required` SET TAGS ('dbx_business_glossary_term' = 'Gender Variant Required');
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ALTER COLUMN `gender_variant_required` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ALTER COLUMN `gender_variant_required` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ALTER COLUMN `is_placeholder` SET TAGS ('dbx_business_glossary_term' = 'Is Placeholder');
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ALTER COLUMN `pegi_rating_impact` SET TAGS ('dbx_business_glossary_term' = 'Pan European Game Information (PEGI) Rating Impact');
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ALTER COLUMN `pegi_rating_impact` SET TAGS ('dbx_value_regex' = 'none|mild|moderate|strong');
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ALTER COLUMN `perforce_changelist` SET TAGS ('dbx_business_glossary_term' = 'Perforce Changelist');
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ALTER COLUMN `perforce_changelist` SET TAGS ('dbx_value_regex' = '^[0-9]+$');
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ALTER COLUMN `perforce_path` SET TAGS ('dbx_business_glossary_term' = 'Perforce Path');
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ALTER COLUMN `plural_variant_required` SET TAGS ('dbx_business_glossary_term' = 'Plural Variant Required');
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ALTER COLUMN `source_language_code` SET TAGS ('dbx_business_glossary_term' = 'Source Language Code');
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ALTER COLUMN `source_language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ALTER COLUMN `source_text` SET TAGS ('dbx_business_glossary_term' = 'Source Text');
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ALTER COLUMN `string_category` SET TAGS ('dbx_business_glossary_term' = 'String Category');
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ALTER COLUMN `string_key` SET TAGS ('dbx_business_glossary_term' = 'String Key');
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ALTER COLUMN `string_key` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,128}$');
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ALTER COLUMN `subtitle_timing_end` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Timing End');
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ALTER COLUMN `subtitle_timing_start` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Timing Start');
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ALTER COLUMN `supports_rich_text` SET TAGS ('dbx_business_glossary_term' = 'Supports Rich Text');
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ALTER COLUMN `supports_variables` SET TAGS ('dbx_business_glossary_term' = 'Supports Variables');
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ALTER COLUMN `translation_status` SET TAGS ('dbx_business_glossary_term' = 'Translation Status');
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ALTER COLUMN `variable_list` SET TAGS ('dbx_business_glossary_term' = 'Variable List');
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+.[0-9]+$');
ALTER TABLE `gaming_ecm`.`content`.`localization_translation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`content`.`localization_translation` SET TAGS ('dbx_subdomain' = 'localization_management');
ALTER TABLE `gaming_ecm`.`content`.`localization_translation` ALTER COLUMN `localization_translation_id` SET TAGS ('dbx_business_glossary_term' = 'Localization Translation ID');
ALTER TABLE `gaming_ecm`.`content`.`localization_translation` ALTER COLUMN `age_rating_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Age Rating Cert Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`localization_translation` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Audio Asset Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`localization_translation` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Release Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`localization_translation` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`localization_translation` ALTER COLUMN `localization_string_id` SET TAGS ('dbx_business_glossary_term' = 'Localization String ID');
ALTER TABLE `gaming_ecm`.`content`.`localization_translation` ALTER COLUMN `character_count` SET TAGS ('dbx_business_glossary_term' = 'Character Count');
ALTER TABLE `gaming_ecm`.`content`.`localization_translation` ALTER COLUMN `context_notes` SET TAGS ('dbx_business_glossary_term' = 'Context Notes');
ALTER TABLE `gaming_ecm`.`content`.`localization_translation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`content`.`localization_translation` ALTER COLUMN `cultural_adaptation_notes` SET TAGS ('dbx_business_glossary_term' = 'Cultural Adaptation Notes');
ALTER TABLE `gaming_ecm`.`content`.`localization_translation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `gaming_ecm`.`content`.`localization_translation` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `gaming_ecm`.`content`.`localization_translation` ALTER COLUMN `glossary_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Glossary Compliance Flag');
ALTER TABLE `gaming_ecm`.`content`.`localization_translation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`content`.`localization_translation` ALTER COLUMN `locale_code` SET TAGS ('dbx_business_glossary_term' = 'Locale Code');
ALTER TABLE `gaming_ecm`.`content`.`localization_translation` ALTER COLUMN `locale_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}_[A-Z]{2}$');
ALTER TABLE `gaming_ecm`.`content`.`localization_translation` ALTER COLUMN `machine_translation_flag` SET TAGS ('dbx_business_glossary_term' = 'Machine Translation Flag');
ALTER TABLE `gaming_ecm`.`content`.`localization_translation` ALTER COLUMN `platform_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Platform Certification Status');
ALTER TABLE `gaming_ecm`.`content`.`localization_translation` ALTER COLUMN `platform_certification_status` SET TAGS ('dbx_value_regex' = 'not_submitted|pending_certification|certified|failed_certification');
ALTER TABLE `gaming_ecm`.`content`.`localization_translation` ALTER COLUMN `qa_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Flag');
ALTER TABLE `gaming_ecm`.`content`.`localization_translation` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `gaming_ecm`.`content`.`localization_translation` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `gaming_ecm`.`content`.`localization_translation` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `gaming_ecm`.`content`.`localization_translation` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'pending|in_review|approved|rejected|revision_requested');
ALTER TABLE `gaming_ecm`.`content`.`localization_translation` ALTER COLUMN `reviewer_identity` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Identity');
ALTER TABLE `gaming_ecm`.`content`.`localization_translation` ALTER COLUMN `reviewer_identity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`content`.`localization_translation` ALTER COLUMN `revision_count` SET TAGS ('dbx_business_glossary_term' = 'Revision Count');
ALTER TABLE `gaming_ecm`.`content`.`localization_translation` ALTER COLUMN `source_text_hash` SET TAGS ('dbx_business_glossary_term' = 'Source Text Hash');
ALTER TABLE `gaming_ecm`.`content`.`localization_translation` ALTER COLUMN `translated_text` SET TAGS ('dbx_business_glossary_term' = 'Translated Text');
ALTER TABLE `gaming_ecm`.`content`.`localization_translation` ALTER COLUMN `translation_cost` SET TAGS ('dbx_business_glossary_term' = 'Translation Cost');
ALTER TABLE `gaming_ecm`.`content`.`localization_translation` ALTER COLUMN `translation_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`content`.`localization_translation` ALTER COLUMN `translation_date` SET TAGS ('dbx_business_glossary_term' = 'Translation Date');
ALTER TABLE `gaming_ecm`.`content`.`localization_translation` ALTER COLUMN `translation_memory_match_score` SET TAGS ('dbx_business_glossary_term' = 'Translation Memory (TM) Match Score');
ALTER TABLE `gaming_ecm`.`content`.`localization_translation` ALTER COLUMN `translator_identity` SET TAGS ('dbx_business_glossary_term' = 'Translator Identity');
ALTER TABLE `gaming_ecm`.`content`.`localization_translation` ALTER COLUMN `translator_identity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`content`.`localization_translation` ALTER COLUMN `translator_type` SET TAGS ('dbx_business_glossary_term' = 'Translator Type');
ALTER TABLE `gaming_ecm`.`content`.`localization_translation` ALTER COLUMN `translator_type` SET TAGS ('dbx_value_regex' = 'internal_team|external_vendor|machine_translation|community_contributor|hybrid');
ALTER TABLE `gaming_ecm`.`content`.`localization_translation` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `gaming_ecm`.`content`.`localization_translation` ALTER COLUMN `word_count` SET TAGS ('dbx_business_glossary_term' = 'Word Count');
ALTER TABLE `gaming_ecm`.`content`.`level_map` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`content`.`level_map` SET TAGS ('dbx_subdomain' = 'game_design');
ALTER TABLE `gaming_ecm`.`content`.`level_map` ALTER COLUMN `level_map_id` SET TAGS ('dbx_business_glossary_term' = 'Level Map ID');
ALTER TABLE `gaming_ecm`.`content`.`level_map` ALTER COLUMN `asset_bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Bundle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`level_map` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Drop Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`level_map` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`level_map` ALTER COLUMN `seasonal_event_id` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Event Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`level_map` ALTER COLUMN `accessibility_features` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Features');
ALTER TABLE `gaming_ecm`.`content`.`level_map` ALTER COLUMN `audio_ambience_profile` SET TAGS ('dbx_business_glossary_term' = 'Audio Ambience Profile');
ALTER TABLE `gaming_ecm`.`content`.`level_map` ALTER COLUMN `build_status` SET TAGS ('dbx_business_glossary_term' = 'Build Status');
ALTER TABLE `gaming_ecm`.`content`.`level_map` ALTER COLUMN `build_status` SET TAGS ('dbx_value_regex' = 'blockout|art_pass|optimization|gold|deprecated');
ALTER TABLE `gaming_ecm`.`content`.`level_map` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`content`.`level_map` ALTER COLUMN `day_night_cycle_enabled` SET TAGS ('dbx_business_glossary_term' = 'Day-Night Cycle Enabled');
ALTER TABLE `gaming_ecm`.`content`.`level_map` ALTER COLUMN `deprecated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deprecated Timestamp');
ALTER TABLE `gaming_ecm`.`content`.`level_map` ALTER COLUMN `difficulty_rating` SET TAGS ('dbx_business_glossary_term' = 'Difficulty Rating');
ALTER TABLE `gaming_ecm`.`content`.`level_map` ALTER COLUMN `difficulty_rating` SET TAGS ('dbx_value_regex' = 'easy|normal|hard|expert|nightmare');
ALTER TABLE `gaming_ecm`.`content`.`level_map` ALTER COLUMN `estimated_play_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Play Duration (Minutes)');
ALTER TABLE `gaming_ecm`.`content`.`level_map` ALTER COLUMN `game_mode_compatibility` SET TAGS ('dbx_business_glossary_term' = 'Game Mode Compatibility');
ALTER TABLE `gaming_ecm`.`content`.`level_map` ALTER COLUMN `geometry_complexity_tier` SET TAGS ('dbx_business_glossary_term' = 'Geometry Complexity Tier');
ALTER TABLE `gaming_ecm`.`content`.`level_map` ALTER COLUMN `geometry_complexity_tier` SET TAGS ('dbx_value_regex' = 'low|medium|high|ultra');
ALTER TABLE `gaming_ecm`.`content`.`level_map` ALTER COLUMN `interactive_object_count` SET TAGS ('dbx_business_glossary_term' = 'Interactive Object Count');
ALTER TABLE `gaming_ecm`.`content`.`level_map` ALTER COLUMN `known_bug_count` SET TAGS ('dbx_business_glossary_term' = 'Known Bug Count');
ALTER TABLE `gaming_ecm`.`content`.`level_map` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`content`.`level_map` ALTER COLUMN `level_code` SET TAGS ('dbx_business_glossary_term' = 'Level Code');
ALTER TABLE `gaming_ecm`.`content`.`level_map` ALTER COLUMN `level_name` SET TAGS ('dbx_business_glossary_term' = 'Level Name');
ALTER TABLE `gaming_ecm`.`content`.`level_map` ALTER COLUMN `level_type` SET TAGS ('dbx_business_glossary_term' = 'Level Type');
ALTER TABLE `gaming_ecm`.`content`.`level_map` ALTER COLUMN `lighting_model` SET TAGS ('dbx_business_glossary_term' = 'Lighting Model');
ALTER TABLE `gaming_ecm`.`content`.`level_map` ALTER COLUMN `lighting_model` SET TAGS ('dbx_value_regex' = 'baked|dynamic|mixed');
ALTER TABLE `gaming_ecm`.`content`.`level_map` ALTER COLUMN `localization_string_count` SET TAGS ('dbx_business_glossary_term' = 'Localization String Count');
ALTER TABLE `gaming_ecm`.`content`.`level_map` ALTER COLUMN `memory_budget_mb` SET TAGS ('dbx_business_glossary_term' = 'Memory Budget (Megabytes)');
ALTER TABLE `gaming_ecm`.`content`.`level_map` ALTER COLUMN `minimum_fps_target` SET TAGS ('dbx_business_glossary_term' = 'Minimum FPS (Frames Per Second) Target');
ALTER TABLE `gaming_ecm`.`content`.`level_map` ALTER COLUMN `navmesh_complexity` SET TAGS ('dbx_business_glossary_term' = 'Navigation Mesh (Navmesh) Complexity');
ALTER TABLE `gaming_ecm`.`content`.`level_map` ALTER COLUMN `navmesh_complexity` SET TAGS ('dbx_value_regex' = 'simple|moderate|complex|none');
ALTER TABLE `gaming_ecm`.`content`.`level_map` ALTER COLUMN `npc_spawn_zones_count` SET TAGS ('dbx_business_glossary_term' = 'NPC (Non-Player Character) Spawn Zones Count');
ALTER TABLE `gaming_ecm`.`content`.`level_map` ALTER COLUMN `objective_marker_count` SET TAGS ('dbx_business_glossary_term' = 'Objective Marker Count');
ALTER TABLE `gaming_ecm`.`content`.`level_map` ALTER COLUMN `physics_configuration` SET TAGS ('dbx_business_glossary_term' = 'Physics Configuration');
ALTER TABLE `gaming_ecm`.`content`.`level_map` ALTER COLUMN `physics_configuration` SET TAGS ('dbx_value_regex' = 'standard|high_fidelity|simplified|disabled');
ALTER TABLE `gaming_ecm`.`content`.`level_map` ALTER COLUMN `published_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Published Timestamp');
ALTER TABLE `gaming_ecm`.`content`.`level_map` ALTER COLUMN `qa_test_pass_count` SET TAGS ('dbx_business_glossary_term' = 'QA (Quality Assurance) Test Pass Count');
ALTER TABLE `gaming_ecm`.`content`.`level_map` ALTER COLUMN `spawn_point_count` SET TAGS ('dbx_business_glossary_term' = 'Spawn Point Count');
ALTER TABLE `gaming_ecm`.`content`.`level_map` ALTER COLUMN `streaming_strategy` SET TAGS ('dbx_business_glossary_term' = 'Streaming Strategy');
ALTER TABLE `gaming_ecm`.`content`.`level_map` ALTER COLUMN `streaming_strategy` SET TAGS ('dbx_value_regex' = 'full_load|streaming_chunks|hybrid');
ALTER TABLE `gaming_ecm`.`content`.`level_map` ALTER COLUMN `supported_platforms` SET TAGS ('dbx_business_glossary_term' = 'Supported Platforms');
ALTER TABLE `gaming_ecm`.`content`.`level_map` ALTER COLUMN `target_player_count_max` SET TAGS ('dbx_business_glossary_term' = 'Target Player Count Maximum');
ALTER TABLE `gaming_ecm`.`content`.`level_map` ALTER COLUMN `target_player_count_min` SET TAGS ('dbx_business_glossary_term' = 'Target Player Count Minimum');
ALTER TABLE `gaming_ecm`.`content`.`level_map` ALTER COLUMN `ugc_enabled` SET TAGS ('dbx_business_glossary_term' = 'UGC (User-Generated Content) Enabled');
ALTER TABLE `gaming_ecm`.`content`.`level_map` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `gaming_ecm`.`content`.`level_map` ALTER COLUMN `vertical_layers_count` SET TAGS ('dbx_business_glossary_term' = 'Vertical Layers Count');
ALTER TABLE `gaming_ecm`.`content`.`level_map` ALTER COLUMN `weather_system_enabled` SET TAGS ('dbx_business_glossary_term' = 'Weather System Enabled');
ALTER TABLE `gaming_ecm`.`content`.`level_map` ALTER COLUMN `world_size_square_meters` SET TAGS ('dbx_business_glossary_term' = 'World Size (Square Meters)');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` SET TAGS ('dbx_subdomain' = 'game_design');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ALTER COLUMN `npc_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Non-Player Character (NPC) Definition ID');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ALTER COLUMN `asset_bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Audio Asset Bundle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Drop Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Studio ID');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Model Asset Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ALTER COLUMN `repo_id` SET TAGS ('dbx_business_glossary_term' = 'Repo Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ALTER COLUMN `aggro_range` SET TAGS ('dbx_business_glossary_term' = 'Aggression Range');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ALTER COLUMN `ai_behavior_profile` SET TAGS ('dbx_business_glossary_term' = 'Artificial Intelligence (AI) Behavior Profile');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ALTER COLUMN `animation_rig_reference` SET TAGS ('dbx_business_glossary_term' = 'Animation Rig Reference');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ALTER COLUMN `approved_by_user` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ALTER COLUMN `archetype_type` SET TAGS ('dbx_business_glossary_term' = 'NPC Archetype Type');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ALTER COLUMN `archetype_type` SET TAGS ('dbx_value_regex' = 'enemy|ally|vendor|quest_giver|boss|ambient');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ALTER COLUMN `base_attack_power` SET TAGS ('dbx_business_glossary_term' = 'Base Attack Power');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ALTER COLUMN `base_defense_rating` SET TAGS ('dbx_business_glossary_term' = 'Base Defense Rating');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ALTER COLUMN `base_health_points` SET TAGS ('dbx_business_glossary_term' = 'Base Health Points (HP)');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ALTER COLUMN `base_health_points` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ALTER COLUMN `base_health_points` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ALTER COLUMN `base_movement_speed` SET TAGS ('dbx_business_glossary_term' = 'Base Movement Speed');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ALTER COLUMN `collision_profile` SET TAGS ('dbx_business_glossary_term' = 'Collision Profile');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ALTER COLUMN `collision_profile` SET TAGS ('dbx_value_regex' = 'small|medium|large|boss|none');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ALTER COLUMN `deployed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deployed Timestamp');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ALTER COLUMN `deprecated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deprecated Timestamp');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ALTER COLUMN `design_notes` SET TAGS ('dbx_business_glossary_term' = 'Design Notes');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ALTER COLUMN `dialogue_tree_reference` SET TAGS ('dbx_business_glossary_term' = 'Dialogue Tree Reference');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ALTER COLUMN `experience_reward` SET TAGS ('dbx_business_glossary_term' = 'Experience Points (XP) Reward');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ALTER COLUMN `faction` SET TAGS ('dbx_business_glossary_term' = 'NPC Faction');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ALTER COLUMN `is_quest_critical` SET TAGS ('dbx_business_glossary_term' = 'Quest Critical Flag');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'NPC Definition Lifecycle Status');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'draft|approved|active|deprecated|retired');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ALTER COLUMN `localization_key_prefix` SET TAGS ('dbx_business_glossary_term' = 'Localization Key Prefix');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ALTER COLUMN `localization_key_prefix` SET TAGS ('dbx_value_regex' = '^[A-Z_]{3,30}$');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ALTER COLUMN `lod_variant_count` SET TAGS ('dbx_business_glossary_term' = 'Level of Detail (LOD) Variant Count');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ALTER COLUMN `loot_table_reference` SET TAGS ('dbx_business_glossary_term' = 'Loot Table Reference');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ALTER COLUMN `npc_code` SET TAGS ('dbx_business_glossary_term' = 'Non-Player Character (NPC) Code');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ALTER COLUMN `npc_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ALTER COLUMN `npc_definition_description` SET TAGS ('dbx_business_glossary_term' = 'NPC Description');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ALTER COLUMN `npc_name` SET TAGS ('dbx_business_glossary_term' = 'Non-Player Character (NPC) Name');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ALTER COLUMN `perforce_changelist` SET TAGS ('dbx_business_glossary_term' = 'Perforce Changelist Number');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ALTER COLUMN `respawn_cooldown_seconds` SET TAGS ('dbx_business_glossary_term' = 'Respawn Cooldown Duration (Seconds)');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ALTER COLUMN `respawn_enabled` SET TAGS ('dbx_business_glossary_term' = 'Respawn Enabled Flag');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ALTER COLUMN `spawn_rule_set` SET TAGS ('dbx_business_glossary_term' = 'Spawn Rule Set');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ALTER COLUMN `texture_asset_path` SET TAGS ('dbx_business_glossary_term' = 'Texture Asset Path');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Content Version Number');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^v[0-9]+.[0-9]+.[0-9]+$');
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ALTER COLUMN `voice_actor_credit` SET TAGS ('dbx_business_glossary_term' = 'Voice Actor Credit');
ALTER TABLE `gaming_ecm`.`content`.`content_release` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`content`.`content_release` SET TAGS ('dbx_subdomain' = 'release_operations');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Release Identifier');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `age_rating_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Age Rating Cert Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `cdn_node_id` SET TAGS ('dbx_business_glossary_term' = 'Cdn Node Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Studio ID');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `server_fleet_id` SET TAGS ('dbx_business_glossary_term' = 'Server Fleet Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `actual_go_live_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Go-Live Timestamp');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `asset_bundle_references` SET TAGS ('dbx_business_glossary_term' = 'Asset Bundle References');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `cdn_distribution_status` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Distribution Status');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `cdn_distribution_status` SET TAGS ('dbx_value_regex' = 'pending|distributing|completed|failed');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `critical_issues_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Issues Count');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `deployment_status` SET TAGS ('dbx_business_glossary_term' = 'Deployment Status');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `deployment_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|failed');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `download_size_mb_console` SET TAGS ('dbx_business_glossary_term' = 'Download Size Megabytes (MB) Console');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `download_size_mb_mobile` SET TAGS ('dbx_business_glossary_term' = 'Download Size Megabytes (MB) Mobile');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `download_size_mb_mobile` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `download_size_mb_mobile` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `download_size_mb_pc` SET TAGS ('dbx_business_glossary_term' = 'Download Size Megabytes (MB) PC');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `drop_name` SET TAGS ('dbx_business_glossary_term' = 'Content Drop Name');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `eligibility_rules` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rules');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `event_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event End Timestamp');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `event_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Start Timestamp');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `event_theme` SET TAGS ('dbx_business_glossary_term' = 'Event Theme');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `exclusive_rewards` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Rewards');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `featured_bundles` SET TAGS ('dbx_business_glossary_term' = 'Featured Bundles');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `gold_master_date` SET TAGS ('dbx_business_glossary_term' = 'Gold Master Date');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `live_ops_owner` SET TAGS ('dbx_business_glossary_term' = 'Live Operations (Live Ops) Owner');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `minimum_client_version` SET TAGS ('dbx_business_glossary_term' = 'Minimum Client Version');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `minimum_client_version` SET TAGS ('dbx_value_regex' = '^d+.d+.d+$');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `notes_url` SET TAGS ('dbx_business_glossary_term' = 'Release Notes Uniform Resource Locator (URL)');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `notes_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `participation_mechanics` SET TAGS ('dbx_business_glossary_term' = 'Participation Mechanics');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `patch_type` SET TAGS ('dbx_business_glossary_term' = 'Patch Type');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `patch_type` SET TAGS ('dbx_value_regex' = 'major|minor|hotfix');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `player_feedback_score` SET TAGS ('dbx_business_glossary_term' = 'Player Feedback Score');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `qa_sign_off_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Sign-Off Date');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `recurrence_pattern` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Pattern');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `recurrence_pattern` SET TAGS ('dbx_value_regex' = 'one_time|annual|quarterly|monthly|weekly');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `release_status` SET TAGS ('dbx_business_glossary_term' = 'Release Status');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `release_type` SET TAGS ('dbx_business_glossary_term' = 'Release Type');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `release_type` SET TAGS ('dbx_value_regex' = 'seasonal_event|patch|hotfix|battle_pass_season|dlc_drop|limited_time_event');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `rollback_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Rollback Timestamp');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `scheduled_go_live_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Go-Live Timestamp');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `target_platforms` SET TAGS ('dbx_business_glossary_term' = 'Target Platforms');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `trc_tcr_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Technical Requirements Checklist (TRC) / Technical Certification Requirements (TCR) Certification Status');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `trc_tcr_certification_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|passed|failed');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `version_string` SET TAGS ('dbx_business_glossary_term' = 'Version String');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `version_string` SET TAGS ('dbx_value_regex' = '^d+.d+.d+$');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `window` SET TAGS ('dbx_business_glossary_term' = 'Release Window');
ALTER TABLE `gaming_ecm`.`content`.`content_release` ALTER COLUMN `window` SET TAGS ('dbx_value_regex' = 'soft_launch|hard_launch|phased_rollout|global_simultaneous');
ALTER TABLE `gaming_ecm`.`content`.`patch` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`content`.`patch` SET TAGS ('dbx_subdomain' = 'release_operations');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `patch_id` SET TAGS ('dbx_business_glossary_term' = 'Patch Identifier');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `age_rating_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Age Rating Cert Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `cdn_node_id` SET TAGS ('dbx_business_glossary_term' = 'Cdn Node Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Drop Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `build_number` SET TAGS ('dbx_business_glossary_term' = 'Build Number');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `cdn_distribution_status` SET TAGS ('dbx_business_glossary_term' = 'CDN (Content Delivery Network) Distribution Status');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `cdn_distribution_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|failed');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `content_drop_flag` SET TAGS ('dbx_business_glossary_term' = 'Content Drop Flag');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `deployment_date_console` SET TAGS ('dbx_business_glossary_term' = 'Deployment Date Console');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `deployment_date_mobile` SET TAGS ('dbx_business_glossary_term' = 'Deployment Date Mobile');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `deployment_date_mobile` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `deployment_date_mobile` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `deployment_date_pc` SET TAGS ('dbx_business_glossary_term' = 'Deployment Date PC');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `dlc_included` SET TAGS ('dbx_business_glossary_term' = 'DLC (Downloadable Content) Included');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `drm_version` SET TAGS ('dbx_business_glossary_term' = 'DRM (Digital Rights Management) Version');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `esrb_rating_impact` SET TAGS ('dbx_business_glossary_term' = 'ESRB (Entertainment Software Rating Board) Rating Impact');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `esrb_rating_impact` SET TAGS ('dbx_value_regex' = 'none|content_descriptor_added|rating_change_pending');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `gold_master_date` SET TAGS ('dbx_business_glossary_term' = 'Gold Master Date');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `internal_change_log` SET TAGS ('dbx_business_glossary_term' = 'Internal Change Log');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `internal_change_log` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory Flag');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `localization_languages` SET TAGS ('dbx_business_glossary_term' = 'Localization Languages');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `minimum_client_version` SET TAGS ('dbx_business_glossary_term' = 'Minimum Client Version');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `minimum_client_version` SET TAGS ('dbx_value_regex' = '^d+.d+.d+$');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Patch Notes');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `patch_name` SET TAGS ('dbx_business_glossary_term' = 'Patch Name');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `patch_status` SET TAGS ('dbx_business_glossary_term' = 'Patch Status');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `patch_type` SET TAGS ('dbx_business_glossary_term' = 'Patch Type');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `patch_type` SET TAGS ('dbx_value_regex' = 'hotfix|minor|major|balance|content|security');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `pegi_rating_impact` SET TAGS ('dbx_business_glossary_term' = 'PEGI (Pan European Game Information) Rating Impact');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `pegi_rating_impact` SET TAGS ('dbx_value_regex' = 'none|content_descriptor_added|rating_change_pending');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `performance_improvement_notes` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Notes');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `qa_sign_off_reference` SET TAGS ('dbx_business_glossary_term' = 'QA (Quality Assurance) Sign-Off Reference');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `rollback_date` SET TAGS ('dbx_business_glossary_term' = 'Rollback Date');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `rollback_reason` SET TAGS ('dbx_business_glossary_term' = 'Rollback Reason');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `security_fixes_included` SET TAGS ('dbx_business_glossary_term' = 'Security Fixes Included Flag');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `size_console_mb` SET TAGS ('dbx_business_glossary_term' = 'Patch Size Console (MB)');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `size_mobile_mb` SET TAGS ('dbx_business_glossary_term' = 'Patch Size Mobile (MB)');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `size_mobile_mb` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `size_mobile_mb` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `size_pc_mb` SET TAGS ('dbx_business_glossary_term' = 'Patch Size PC (MB)');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `target_platforms` SET TAGS ('dbx_business_glossary_term' = 'Target Platforms');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `trc_approval_date` SET TAGS ('dbx_business_glossary_term' = 'TRC (Technical Requirements Checklist) Approval Date');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `trc_submission_date` SET TAGS ('dbx_business_glossary_term' = 'TRC (Technical Requirements Checklist) Submission Date');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Patch Version');
ALTER TABLE `gaming_ecm`.`content`.`patch` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = '^d+.d+.d+(-[a-zA-Z0-9]+)?$');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` SET TAGS ('dbx_subdomain' = 'release_operations');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `seasonal_event_id` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Event ID');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `asset_bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Bundle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Campaign ID');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Drop Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `loot_box_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Loot Box Disclosure Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `matchmaking_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Matchmaking Pool Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `network_region_id` SET TAGS ('dbx_business_glossary_term' = 'Network Region Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `title_season_id` SET TAGS ('dbx_business_glossary_term' = 'Title Season Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `actual_participation_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Participation Count');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Platform Certification Status');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'not_submitted|submitted|in_review|approved|rejected');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `content_rating` SET TAGS ('dbx_business_glossary_term' = 'Content Rating');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `content_version` SET TAGS ('dbx_business_glossary_term' = 'Content Version');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `content_version` SET TAGS ('dbx_value_regex' = '^v[0-9]+.[0-9]+.[0-9]+$');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event End Timestamp');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `estimated_participation_count` SET TAGS ('dbx_business_glossary_term' = 'Estimated Participation Count');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `event_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Event Budget Amount');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `event_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `event_code` SET TAGS ('dbx_business_glossary_term' = 'Event Code');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `event_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{4,20}$');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `event_name` SET TAGS ('dbx_business_glossary_term' = 'Event Name');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'draft|scheduled|active|paused|completed|cancelled');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `event_theme` SET TAGS ('dbx_business_glossary_term' = 'Event Theme');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `exclusive_cosmetic_reward_ids` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Cosmetic Reward IDs');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `featured_content_bundle_ids` SET TAGS ('dbx_business_glossary_term' = 'Featured Content Bundle IDs');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `localization_status` SET TAGS ('dbx_business_glossary_term' = 'Localization Status');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `localization_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|approved');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `min_player_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Player Level');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Event Notes');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `participation_mechanics` SET TAGS ('dbx_business_glossary_term' = 'Participation Mechanics');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `player_eligibility_rules` SET TAGS ('dbx_business_glossary_term' = 'Player Eligibility Rules');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `qa_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Status');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `qa_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|passed|failed|blocked');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `recurrence_pattern` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Pattern');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `recurrence_pattern` SET TAGS ('dbx_value_regex' = 'one_time|annual|quarterly|monthly|weekly|custom');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `recurrence_schedule` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Schedule');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `reward_structure` SET TAGS ('dbx_business_glossary_term' = 'Reward Structure');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Start Timestamp');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `supported_languages` SET TAGS ('dbx_business_glossary_term' = 'Supported Languages');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `target_dau_lift_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Daily Active Users (DAU) Lift Percent');
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ALTER COLUMN `target_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Target Revenue Amount');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` SET TAGS ('dbx_subdomain' = 'release_operations');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `content_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Content Deployment ID');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `age_rating_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Age Rating Cert Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `build_id` SET TAGS ('dbx_business_glossary_term' = 'Build Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `cdn_node_id` SET TAGS ('dbx_business_glossary_term' = 'Cdn Node Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Drop ID');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `network_region_id` SET TAGS ('dbx_business_glossary_term' = 'Network Region Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `patch_id` SET TAGS ('dbx_business_glossary_term' = 'Patch Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `platform_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Sku Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `seasonal_event_id` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Event Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `server_fleet_id` SET TAGS ('dbx_business_glossary_term' = 'Server Fleet Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `tournament_id` SET TAGS ('dbx_business_glossary_term' = 'Tournament Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Deployment Approval Status');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|auto_approved');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `asset_bundle_size_mb` SET TAGS ('dbx_business_glossary_term' = 'Asset Bundle Size (MB - Megabytes)');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `asset_count` SET TAGS ('dbx_business_glossary_term' = 'Asset Count');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `cdn_distribution_status` SET TAGS ('dbx_business_glossary_term' = 'CDN (Content Delivery Network) Distribution Status');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `cdn_distribution_status` SET TAGS ('dbx_value_regex' = 'not_started|distributing|distributed|failed|partial');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `cdn_endpoint_url` SET TAGS ('dbx_business_glossary_term' = 'CDN (Content Delivery Network) Endpoint URL');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deployment Completed Timestamp');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `deployment_method` SET TAGS ('dbx_business_glossary_term' = 'Deployment Method');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `deployment_method` SET TAGS ('dbx_value_regex' = 'full_push|delta_patch|hotfix|rollback|staged_rollout|canary');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `deployment_number` SET TAGS ('dbx_business_glossary_term' = 'Deployment Number');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `deployment_number` SET TAGS ('dbx_value_regex' = '^DEP-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `deployment_status` SET TAGS ('dbx_business_glossary_term' = 'Deployment Status');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `deployment_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|failed|rolled_back|cancelled');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `deployment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deployment Timestamp');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `deployment_type` SET TAGS ('dbx_business_glossary_term' = 'Deployment Type');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `deployment_type` SET TAGS ('dbx_value_regex' = 'content_drop|patch|hotfix|dlc|seasonal_event|live_ops');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `downtime_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Downtime Duration (Minutes)');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `downtime_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Downtime Required Flag');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Deployment Duration (Seconds)');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Deployment Notes');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `perforce_changelist_number` SET TAGS ('dbx_business_glossary_term' = 'Perforce Changelist Number');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `player_impact_level` SET TAGS ('dbx_business_glossary_term' = 'Player Impact Level');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `player_impact_level` SET TAGS ('dbx_value_regex' = 'none|low|medium|high|critical');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `post_deployment_validation_status` SET TAGS ('dbx_business_glossary_term' = 'Post-Deployment Validation Status');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `post_deployment_validation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|passed|failed|skipped');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `region_codes` SET TAGS ('dbx_business_glossary_term' = 'Deployment Region Codes');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Retry Count');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `rollback_flag` SET TAGS ('dbx_business_glossary_term' = 'Rollback Flag');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `rollback_reason` SET TAGS ('dbx_business_glossary_term' = 'Rollback Reason');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `rollback_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Rollback Timestamp');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `target_environment` SET TAGS ('dbx_business_glossary_term' = 'Target Environment');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `target_environment` SET TAGS ('dbx_value_regex' = 'dev|qa|uat|staging|production|live');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `target_platform_codes` SET TAGS ('dbx_business_glossary_term' = 'Target Platform Codes');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `window_end` SET TAGS ('dbx_business_glossary_term' = 'Deployment Window End');
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ALTER COLUMN `window_start` SET TAGS ('dbx_business_glossary_term' = 'Deployment Window Start');
ALTER TABLE `gaming_ecm`.`content`.`bundle_manifest_entry` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `gaming_ecm`.`content`.`bundle_manifest_entry` SET TAGS ('dbx_subdomain' = 'asset_production');
ALTER TABLE `gaming_ecm`.`content`.`bundle_manifest_entry` SET TAGS ('dbx_association_edges' = 'content.asset_bundle,content.asset');
ALTER TABLE `gaming_ecm`.`content`.`bundle_manifest_entry` ALTER COLUMN `bundle_manifest_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Manifest Entry - Bundle Manifest Entry Id');
ALTER TABLE `gaming_ecm`.`content`.`bundle_manifest_entry` ALTER COLUMN `asset_bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Manifest Entry - Asset Bundle Id');
ALTER TABLE `gaming_ecm`.`content`.`bundle_manifest_entry` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Manifest Entry - Asset Id');
ALTER TABLE `gaming_ecm`.`content`.`bundle_manifest_entry` ALTER COLUMN `asset_count` SET TAGS ('dbx_business_glossary_term' = 'Asset Count');
ALTER TABLE `gaming_ecm`.`content`.`bundle_manifest_entry` ALTER COLUMN `asset_order_in_bundle` SET TAGS ('dbx_business_glossary_term' = 'Asset Order in Bundle');
ALTER TABLE `gaming_ecm`.`content`.`bundle_manifest_entry` ALTER COLUMN `asset_role_in_bundle` SET TAGS ('dbx_business_glossary_term' = 'Asset Role in Bundle');
ALTER TABLE `gaming_ecm`.`content`.`bundle_manifest_entry` ALTER COLUMN `compression_override` SET TAGS ('dbx_business_glossary_term' = 'Compression Override');
ALTER TABLE `gaming_ecm`.`content`.`bundle_manifest_entry` ALTER COLUMN `exclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Flag');
ALTER TABLE `gaming_ecm`.`content`.`bundle_manifest_entry` ALTER COLUMN `inclusion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Timestamp');
ALTER TABLE `gaming_ecm`.`content`.`bundle_manifest_entry` ALTER COLUMN `is_primary_asset` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Asset');
ALTER TABLE `gaming_ecm`.`content`.`bundle_manifest_entry` ALTER COLUMN `last_verified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Verified Timestamp');
ALTER TABLE `gaming_ecm`.`content`.`bundle_manifest_entry` ALTER COLUMN `load_priority` SET TAGS ('dbx_business_glossary_term' = 'Load Priority');
ALTER TABLE `gaming_ecm`.`content`.`bundle_manifest_entry` ALTER COLUMN `lod_tier_override` SET TAGS ('dbx_business_glossary_term' = 'LOD Tier Override');
ALTER TABLE `gaming_ecm`.`content`.`npc_spawn_configuration` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `gaming_ecm`.`content`.`npc_spawn_configuration` SET TAGS ('dbx_subdomain' = 'game_design');
ALTER TABLE `gaming_ecm`.`content`.`npc_spawn_configuration` SET TAGS ('dbx_association_edges' = 'content.level_map,content.npc_definition');
ALTER TABLE `gaming_ecm`.`content`.`npc_spawn_configuration` ALTER COLUMN `npc_spawn_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'NPC Spawn Configuration ID');
ALTER TABLE `gaming_ecm`.`content`.`npc_spawn_configuration` ALTER COLUMN `level_map_id` SET TAGS ('dbx_business_glossary_term' = 'Npc Spawn Configuration - Level Map Id');
ALTER TABLE `gaming_ecm`.`content`.`npc_spawn_configuration` ALTER COLUMN `npc_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Npc Spawn Configuration - Npc Definition Id');
ALTER TABLE `gaming_ecm`.`content`.`npc_spawn_configuration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`content`.`npc_spawn_configuration` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `gaming_ecm`.`content`.`npc_spawn_configuration` ALTER COLUMN `is_boss_variant` SET TAGS ('dbx_business_glossary_term' = 'Is Boss Variant');
ALTER TABLE `gaming_ecm`.`content`.`npc_spawn_configuration` ALTER COLUMN `level_specific_loot_override` SET TAGS ('dbx_business_glossary_term' = 'Level-Specific Loot Override');
ALTER TABLE `gaming_ecm`.`content`.`npc_spawn_configuration` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`content`.`npc_spawn_configuration` ALTER COLUMN `spawn_count_max` SET TAGS ('dbx_business_glossary_term' = 'Spawn Count Maximum');
ALTER TABLE `gaming_ecm`.`content`.`npc_spawn_configuration` ALTER COLUMN `spawn_count_min` SET TAGS ('dbx_business_glossary_term' = 'Spawn Count Minimum');
ALTER TABLE `gaming_ecm`.`content`.`npc_spawn_configuration` ALTER COLUMN `spawn_weight` SET TAGS ('dbx_business_glossary_term' = 'Spawn Weight');
ALTER TABLE `gaming_ecm`.`content`.`npc_spawn_configuration` ALTER COLUMN `spawn_zone_code` SET TAGS ('dbx_business_glossary_term' = 'Spawn Zone Identifier');
