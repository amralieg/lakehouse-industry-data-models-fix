-- Schema for Domain: title | Business: Gaming | Version: v1_ecm
-- Generated on: 2026-05-08 06:58:05

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `gaming_ecm`.`title` COMMENT 'Master catalog of all game titles, SKUs, editions, versions, builds, releases, and DLC/content bundles published or distributed. Owns the game product lifecycle from concept greenlight through gold master, platform certification (TRC/TCR), ESRB/PEGI/CERO ratings, genre classification, IP ownership, and end-of-life. The authoritative SSOT for WHAT the business offers across all storefronts.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `gaming_ecm`.`title`.`game_title` (
    `game_title_id` BIGINT COMMENT 'Unique identifier for the game title. Primary key for the master catalog of all game intellectual property (IP) published or distributed by Gaming.',
    `franchise_id` BIGINT COMMENT 'Reference to the parent franchise or series to which this game title belongs. Enables franchise-level analytics and IP portfolio management.',
    `genre_classification_id` BIGINT COMMENT 'Foreign key linking to title.genre_classification. Business justification: Game titles are classified by genre using a standardized taxonomy. Currently game_title.primary_genre is a STRING with no referential integrity. Adding primary_genre_id FK to genre_classification norm',
    `business_model` STRING COMMENT 'The monetization model for the game title. F2P (Free-to-Play) indicates no upfront cost with in-game monetization; premium indicates upfront purchase; subscription indicates recurring access fee; hybrid combines multiple models.. Valid values are `f2p|premium|subscription|hybrid|ad_supported|freemium`',
    `cero_rating` STRING COMMENT 'The CERO content rating assigned to the game title for Japanese distribution. A (All Ages), B (12+), C (15+), D (17+), Z (18+). Required for retail and platform distribution in Japan.. Valid values are `A|B|C|D|Z`',
    `coppa_compliance_required` BOOLEAN COMMENT 'Flag indicating whether this game title is subject to COPPA compliance requirements due to targeting or attracting children under 13. True if COPPA applies; false otherwise. Drives data collection and parental consent requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this game title record was first created in the master catalog system. Used for audit trail and data lineage tracking.',
    `end_of_life_date` DATE COMMENT 'The date on which the game title reached end-of-life status with all support, servers, and distribution ceased. Used for historical reporting and compliance with data retention policies.',
    `epic_catalog_item_code` STRING COMMENT 'The unique catalog item identifier assigned by Epic Games for distribution on the Epic Games Store. Used for sales tracking and platform integration.',
    `esrb_rating` STRING COMMENT 'The ESRB content rating assigned to the game title for North American distribution. E (Everyone), E10+ (Everyone 10+), T (Teen), M (Mature 17+), AO (Adults Only 18+), RP (Rating Pending). Required for retail and platform distribution in North America.. Valid values are `E|E10+|T|M|AO|RP`',
    `game_engine` STRING COMMENT 'The game engine or technology platform used to develop the title (e.g., Unity, Unreal Engine, proprietary engine). Important for technical support, licensing, and development resource planning.',
    `game_modes` STRING COMMENT 'Comma-separated list of gameplay modes supported by the title (e.g., campaign, multiplayer, co-op, battle royale, sandbox, competitive, casual). Used for feature marketing and player expectation setting.',
    `gdpr_scope` STRING COMMENT 'Indicates whether this game title is subject to GDPR requirements based on player base and data processing activities. In-scope titles must comply with EU data protection regulations; out-of-scope titles do not process EU player data; partial indicates limited EU exposure.. Valid values are `in_scope|out_of_scope|partial`',
    `has_dlc` BOOLEAN COMMENT 'Flag indicating whether this game title has associated downloadable content (DLC) or expansion packs available for purchase. True if DLC exists; false otherwise.',
    `has_loot_boxes` BOOLEAN COMMENT 'Flag indicating whether this game title includes loot boxes or randomized reward mechanics. True if loot boxes are present; false otherwise. Subject to regulatory scrutiny in multiple jurisdictions.',
    `has_microtransactions` BOOLEAN COMMENT 'Flag indicating whether this game title includes in-game microtransactions (MTX) for virtual goods, currency, or cosmetics. True if MTX are present; false otherwise. Critical for regulatory disclosure and player expectations.',
    `initial_release_date` DATE COMMENT 'The date on which the game title was first released to the public on any platform. Used for lifecycle analytics, anniversary marketing, and historical reporting.',
    `ip_ownership_entity` STRING COMMENT 'The legal entity that owns the intellectual property rights for this game title. Critical for licensing, royalty calculations, and legal compliance.',
    `is_cross_play_supported` BOOLEAN COMMENT 'Flag indicating whether players on different platforms can play together in the same session. True if cross-play is enabled; false otherwise. Key feature for player acquisition and retention.',
    `is_esports_title` BOOLEAN COMMENT 'Flag indicating whether this game title is actively supported as an esports title with competitive leagues, tournaments, or official competitive infrastructure. True if esports-enabled; false otherwise.',
    `is_gaas` BOOLEAN COMMENT 'Flag indicating whether this title operates as a Game as a Service (GaaS) with ongoing live operations, content updates, seasons, and continuous player engagement. True for live-service games; false for traditional release-and-done titles.',
    `is_ugc_enabled` BOOLEAN COMMENT 'Flag indicating whether this game title supports user-generated content (UGC) such as custom levels, mods, or in-game creations. True if UGC is enabled; false otherwise. Impacts moderation requirements and community engagement strategy.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this game title record was last updated in the master catalog system. Used for change tracking and data freshness monitoring.',
    `latest_release_date` DATE COMMENT 'The date of the most recent major release, re-release, or remaster of the game title. Tracks ongoing release activity for titles with multiple platform launches or editions.',
    `lifecycle_stage` STRING COMMENT 'Current stage in the game titles lifecycle from initial concept through end-of-life. Concept indicates ideation; greenlight indicates approved for development; production indicates active development; gold master indicates final build approved for release; live indicates publicly available; sunset indicates winding down support; end-of-life indicates no longer supported. [ENUM-REF-CANDIDATE: concept|greenlight|pre_production|production|alpha|beta|gold_master|live|sunset|end_of_life — 10 candidates stripped; promote to reference product]',
    `marketing_tagline` STRING COMMENT 'The official marketing tagline or slogan used in promotional materials and advertising campaigns for the game title. Used for brand consistency and campaign tracking.',
    `max_player_count` STRING COMMENT 'The maximum number of players supported in a single session or match. Critical for infrastructure planning and marketing (e.g., 100-player battle royale).',
    `min_player_count` STRING COMMENT 'The minimum number of players required or supported for gameplay. Typically 1 for single-player games; may be higher for multiplayer-only titles.',
    `official_title_name` STRING COMMENT 'The official, publicly-facing name of the game title as it appears on storefronts, marketing materials, and platform certifications. This is the authoritative display name for the intellectual property.',
    `official_website_url` STRING COMMENT 'The URL of the official website for the game title. Used for player information, marketing campaigns, and community engagement.',
    `online_capability` STRING COMMENT 'Indicates whether the game requires an internet connection to play. Online-only titles require persistent connectivity; offline-only titles do not; hybrid titles support both modes.. Valid values are `online_only|offline_only|online_and_offline`',
    `pci_dss_applicable` BOOLEAN COMMENT 'Flag indicating whether this game title processes payment card data directly and is therefore subject to PCI DSS compliance requirements. True if PCI DSS applies; false if payment processing is handled entirely by third-party platforms.',
    `pegi_rating` STRING COMMENT 'The PEGI content rating assigned to the game title for European distribution. PEGI 3, 7, 12, 16, or 18 indicating minimum age suitability. Required for retail and platform distribution in Europe.. Valid values are `PEGI_3|PEGI_7|PEGI_12|PEGI_16|PEGI_18`',
    `planned_sunset_date` DATE COMMENT 'The planned date for sunsetting live operations or ending active support for the game title. Used for resource planning and player communication. Nullable for titles with indefinite support.',
    `record_status` STRING COMMENT 'The current status of this master catalog record. Active indicates the record is current and in use; inactive indicates temporarily disabled; archived indicates historical record retained for compliance; deleted indicates soft-deleted pending purge.. Valid values are `active|inactive|archived|deleted`',
    `secondary_genre` STRING COMMENT 'Optional secondary genre classification for hybrid or multi-genre titles. Supports more nuanced player targeting and discovery. [ENUM-REF-CANDIDATE: action|adventure|rpg|strategy|simulation|sports|racing|puzzle|fighting|shooter|platformer|horror — 12 candidates stripped; promote to reference product]',
    `steam_app_code` STRING COMMENT 'The unique application identifier assigned by Valve for distribution on the Steam platform. Used for sales tracking, API integration, and platform analytics.',
    `supported_platforms` STRING COMMENT 'Comma-separated list of platforms on which this game title is available or planned for release (e.g., PlayStation 5, Xbox Series X, PC, Nintendo Switch, iOS, Android). Critical for platform certification tracking and distribution planning.',
    `target_age_max` STRING COMMENT 'The maximum age of the intended player demographic for marketing and design purposes. Used for player acquisition targeting and content design decisions.',
    `target_age_min` STRING COMMENT 'The minimum age of the intended player demographic for marketing and design purposes. May differ from regulatory ratings. Used for player acquisition targeting and content design decisions.',
    `working_title` STRING COMMENT 'Internal codename or working title used during development before the official title name is finalized. Used for project tracking and confidentiality during pre-announcement phases.',
    CONSTRAINT pk_game_title PRIMARY KEY(`game_title_id`)
) COMMENT 'Master catalog record for every game title (IP) published or distributed by Gaming. Represents the top-level intellectual property entity and the authoritative SSOT for a games identity across all storefronts and systems. Key attributes: official title name, working title, franchise reference, primary/secondary genre classification, IP ownership entity, business model (F2P, premium, hybrid, subscription), GaaS flag, supported platforms, game modes (campaign, multiplayer, co-op, battle royale, sandbox), player count range, online/offline capability, cross-play support, engine/technology reference, and overall lifecycle stage. All SKUs, editions, builds, DLC bundles, seasons, and territory rights roll up to this entity.';

CREATE OR REPLACE TABLE `gaming_ecm`.`title`.`title_sku` (
    `title_sku_id` BIGINT COMMENT 'Unique identifier for the SKU record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: SKUs track creating employee for product management accountability, pricing approval workflows, and operational audit trails in storefront/distribution management.',
    `game_edition_id` BIGINT COMMENT 'Foreign key linking to title.game_edition. Business justification: A SKU represents a specific purchasable variant of a game edition. Each SKU belongs to one edition tier (Standard, Deluxe, Ultimate, etc.). The current edition_type STRING field should be replaced wit',
    `game_title_id` BIGINT COMMENT 'Reference to the parent game title that this SKU belongs to.',
    `age_gate_required_flag` BOOLEAN COMMENT 'Indicates whether age verification is required before purchase or download of this SKU.',
    `age_rating_code` STRING COMMENT 'Age rating classification code assigned by the regional rating authority (e.g., ESRB: E, T, M; PEGI: 3, 7, 12, 16, 18; CERO: A, B, C, D, Z).',
    `availability_end_date` DATE COMMENT 'Date when this SKU will no longer be available for purchase. Null for indefinite availability.',
    `availability_start_date` DATE COMMENT 'Date when this SKU becomes available for sale, which may differ from the release date for pre-orders or soft launches.',
    `bundle_component_flag` BOOLEAN COMMENT 'Indicates whether this SKU is part of a larger bundle offering and may not be sold separately.',
    `certification_date` DATE COMMENT 'Date when this SKU received platform certification approval (TRC/TCR compliance).',
    `certification_status` STRING COMMENT 'Current status of platform certification process (TRC/TCR compliance) for this SKU.. Valid values are `not_submitted|in_review|approved|rejected|conditional_approval`',
    `content_type` STRING COMMENT 'Type of content this SKU represents (base game, DLC, expansion, season pass, cosmetic pack, soundtrack, artbook, virtual currency). [ENUM-REF-CANDIDATE: base_game|dlc|expansion|season_pass|cosmetic_pack|soundtrack|artbook|virtual_currency — 8 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this SKU record was first created in the system.',
    `cross_buy_eligible_flag` BOOLEAN COMMENT 'Indicates whether purchasing this SKU grants access to the same title on other platforms within the same ecosystem (e.g., PS4 to PS5 upgrade).',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the MSRP amount (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `distribution_channel` STRING COMMENT 'Primary distribution method for this SKU (digital download, physical media, subscription service, or bundle).. Valid values are `digital|physical|subscription|bundle`',
    `drm_type` STRING COMMENT 'Type of digital rights management technology applied to this SKU (none, Steam DRM, Denuvo, Epic DRM, platform native, proprietary).. Valid values are `none|steam_drm|denuvo|epic_drm|platform_native|proprietary`',
    `ean_code` STRING COMMENT '13-digit European Article Number for physical SKU variants, used in international retail distribution.. Valid values are `^[0-9]{13}$`',
    `exclusive_flag` BOOLEAN COMMENT 'Indicates whether this SKU is exclusive to a specific platform, storefront, or region for a defined period.',
    `file_size_gb` DECIMAL(18,2) COMMENT 'Total download or installation size of the SKU in gigabytes, applicable to digital distribution.',
    `gold_master_date` DATE COMMENT 'Date when the final production-ready build (gold master) was completed and approved for manufacturing or distribution.',
    `launch_type` STRING COMMENT 'Type of launch strategy for this SKU (hard launch, soft launch, early access, beta, limited release).. Valid values are `hard_launch|soft_launch|early_access|beta|limited_release`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this SKU record was last modified.',
    `msrp_amount` DECIMAL(18,2) COMMENT 'The manufacturers suggested retail price for this SKU in the local currency.',
    `package_type` STRING COMMENT 'Physical or digital packaging format for this SKU (digital download, disc, cartridge, code-in-box, steelbook, collectors box).. Valid values are `digital_download|disc|cartridge|code_in_box|steelbook|collectors_box`',
    `platform_code` STRING COMMENT 'Target gaming platform for this SKU (PS5, Xbox Series X, PC-Steam, iOS, Android, etc.). [ENUM-REF-CANDIDATE: ps5|ps4|xbox_series_x|xbox_one|pc_steam|pc_epic|pc_gog|nintendo_switch|ios|android|stadia|luna — 12 candidates stripped; promote to reference product]',
    `pre_order_eligible_flag` BOOLEAN COMMENT 'Indicates whether this SKU is available for pre-order before the official release date.',
    `pricing_tier` STRING COMMENT 'Regional pricing tier classification for this SKU (budget, standard, premium, AAA, indie).. Valid values are `budget|standard|premium|aaa|indie`',
    `promotional_flag` BOOLEAN COMMENT 'Indicates whether this SKU is currently part of an active promotional campaign or discount offer.',
    `refund_eligible_flag` BOOLEAN COMMENT 'Indicates whether this SKU is eligible for refund according to platform and regional policies.',
    `region_code` STRING COMMENT 'ISO 3166-1 alpha-3 country or region code where this SKU is available for sale (e.g., USA, GBR, JPN, EUR).. Valid values are `^[A-Z]{3}$`',
    `release_date` DATE COMMENT 'Official release date when this SKU became available for purchase on the specified storefront and region.',
    `sku_code` STRING COMMENT 'Externally-known unique alphanumeric code identifying this SKU across all storefronts and distribution channels.. Valid values are `^[A-Z0-9]{6,20}$`',
    `sku_description` STRING COMMENT 'Detailed marketing description of the SKU, including features, content, and value proposition for the specific edition and platform.',
    `sku_name` STRING COMMENT 'Human-readable name of the SKU, typically including edition and platform information (e.g., Game Title - Deluxe Edition - PS5).',
    `sku_status` STRING COMMENT 'Current lifecycle status of the SKU (planned, pre-release, active, delisted, discontinued, sunset).. Valid values are `planned|pre_release|active|delisted|discontinued|sunset`',
    `storefront_code` STRING COMMENT 'Identifier for the digital or physical storefront where this SKU is listed (e.g., Steam, Epic Games Store, PlayStation Store, Xbox Store, retail partner code).',
    `upc_code` STRING COMMENT '12-digit Universal Product Code for physical SKU variants, used for retail inventory and point-of-sale systems.. Valid values are `^[0-9]{12}$`',
    CONSTRAINT pk_title_sku PRIMARY KEY(`title_sku_id`)
) COMMENT 'Stock Keeping Unit record representing a distinct purchasable or distributable product variant of a game title. Each SKU maps to a specific edition (Standard, Deluxe, Ultimate, GOTY), platform (PS5, Xbox Series X, PC-Steam, iOS, Android), region, and distribution channel (digital, physical). Tracks MSRP, regional pricing tier, release date per storefront, availability window, age-gate flag, and SKU lifecycle status. The SSOT for what is listed and sold on any storefront.';

CREATE OR REPLACE TABLE `gaming_ecm`.`title`.`game_edition` (
    `game_edition_id` BIGINT COMMENT 'Unique identifier for the game edition. Primary key for the game edition entity.',
    `build_id` BIGINT COMMENT 'Foreign key linking to studio.build. Business justification: Physical and digital editions reference specific gold master builds for manufacturing and distribution. Essential for SKU fulfillment, platform certification tracking, and edition-specific content ent',
    `game_title_id` BIGINT COMMENT 'Reference to the parent game title that this edition belongs to. Links edition to the base game product.',
    `base_game_included` BOOLEAN COMMENT 'Indicates whether this edition includes the full base game or is an add-on/expansion-only package.',
    `bonus_content_description` STRING COMMENT 'Detailed description of bonus digital or physical content included with this edition (e.g., artbook, soundtrack, in-game items, cosmetics, early access).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this edition record was first created in the system.',
    `discontinuation_date` DATE COMMENT 'The date when this edition was discontinued or removed from active sale, if applicable.',
    `display_order` STRING COMMENT 'Numeric sort order for displaying this edition in storefronts and product listings, typically ordered from base to premium tiers.',
    `dlc_bundle_count` STRING COMMENT 'Number of DLC content bundles included with this edition at time of purchase.',
    `early_access_days` STRING COMMENT 'Number of days of early access to the game granted to purchasers of this edition before the standard launch date.',
    `edition_code` STRING COMMENT 'Short alphanumeric code used internally and in systems to identify the edition (e.g., STD, DLX, ULT, COLL, GOTY).. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `edition_name` STRING COMMENT 'The marketing name of the edition tier (e.g., Standard, Deluxe, Ultimate, Collectors, Game of the Year, Gold, Platinum, Limited, Special).',
    `edition_tier` STRING COMMENT 'Hierarchical tier classification of the edition for pricing and content segmentation purposes.. Valid values are `base|premium|deluxe|ultimate|collectors|limited`',
    `edition_type` STRING COMMENT 'Type classification of the edition indicating its market positioning and content scope. [ENUM-REF-CANDIDATE: standard|special|limited|collectors|anniversary|goty|complete|definitive — 8 candidates stripped; promote to reference product]',
    `game_edition_status` STRING COMMENT 'Current lifecycle status of the edition indicating its availability and operational state.. Valid values are `planned|active|discontinued|retired|limited_availability|pre_order`',
    `is_digital` BOOLEAN COMMENT 'Indicates whether this edition is available as a digital download through online storefronts.',
    `is_limited_availability` BOOLEAN COMMENT 'Indicates whether this edition has limited production run or time-limited availability (e.g., pre-order exclusive, launch edition).',
    `is_physical` BOOLEAN COMMENT 'Indicates whether this edition includes physical components (disc, box, collectibles) or is digital-only.',
    `is_pre_order_exclusive` BOOLEAN COMMENT 'Indicates whether this edition is only available through pre-order channels before official launch.',
    `launch_date` DATE COMMENT 'The official release date when this edition became available for purchase or pre-order.',
    `marketing_description` STRING COMMENT 'Edition-level marketing copy describing the value proposition, target audience, and key selling points for promotional use.',
    `msrp_amount` DECIMAL(18,2) COMMENT 'The suggested retail price for this edition in the base currency, used as pricing guidance across regions and platforms.',
    `msrp_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the MSRP amount (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `physical_collectibles_description` STRING COMMENT 'Description of physical collectible items included in collectors or special editions (e.g., statue, steelbook, map, poster, art cards).',
    `platform_availability` STRING COMMENT 'Comma-separated list of platforms where this edition is available (e.g., PlayStation 5, Xbox Series X, PC, Nintendo Switch). [ENUM-REF-CANDIDATE: playstation_5|xbox_series_x|xbox_series_s|pc|nintendo_switch|playstation_4|xbox_one|mobile|cloud — promote to reference product]',
    `pre_order_end_date` DATE COMMENT 'The date when pre-orders for this edition closed, typically at or near the launch date.',
    `pre_order_start_date` DATE COMMENT 'The date when pre-orders for this edition opened to customers.',
    `region_availability` STRING COMMENT 'Comma-separated list of geographic regions or markets where this edition is available for sale (e.g., North America, Europe, Asia-Pacific).',
    `season_pass_included` BOOLEAN COMMENT 'Indicates whether this edition includes a season pass granting access to future DLC (Downloadable Content) releases.',
    `sku_template_flag` BOOLEAN COMMENT 'Indicates whether this edition serves as a reusable template that multiple platform-specific and region-specific SKUs reference.',
    `storefront_availability` STRING COMMENT 'Comma-separated list of digital storefronts and retail channels where this edition is sold (e.g., Steam, Epic Games Store, PlayStation Store, Xbox Store, retail). [ENUM-REF-CANDIDATE: steam|epic_games_store|playstation_store|xbox_store|nintendo_eshop|gog|retail|direct — promote to reference product]',
    `units_produced` STRING COMMENT 'Total number of units manufactured or allocated for this edition, particularly relevant for limited and collectors editions.',
    `updated_by` STRING COMMENT 'User or system identifier that last modified this edition record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this edition record was last modified in the system.',
    `created_by` STRING COMMENT 'User or system identifier that created this edition record.',
    CONSTRAINT pk_game_edition PRIMARY KEY(`game_edition_id`)
) COMMENT 'Defines the named edition tiers for a game title (e.g., Standard, Deluxe, Ultimate, Collectors, Game of the Year). Captures edition name, included content entitlements, bonus DLC bundle references, physical vs digital flag, limited availability flag, and edition-level marketing description. Editions are reusable templates that multiple SKUs reference across platforms and regions.';

CREATE OR REPLACE TABLE `gaming_ecm`.`title`.`build_artifact` (
    `build_artifact_id` BIGINT COMMENT 'Unique identifier for the build artifact. Primary key.',
    `asset_bundle_id` BIGINT COMMENT 'Foreign key linking to content.asset_bundle. Business justification: Build artifacts package asset bundles for deployment. Build pipelines, certification submissions, and rollback procedures require tracking which asset bundles are included in each build version.',
    `build_id` BIGINT COMMENT 'Foreign key reference to the parent build entity that tracks high-level build metadata. Links this artifact to the broader build management system.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Build artifacts track creating employee for engineering accountability, build pipeline ownership, and release management audit trails in CI/CD operations.',
    `game_title_id` BIGINT COMMENT 'Foreign key reference to the game title for which this build artifact was created. Links this build to the master game product catalog.',
    `middleware_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.middleware_agreement. Business justification: Builds use middleware covered by specific agreements (engine versions, SDK licenses). Required for compliance verification, royalty calculation, and certification approval.',
    `release_gate_id` BIGINT COMMENT 'Foreign key reference to the release gate approval that authorized this build for deployment. Links to governance and approval workflow.',
    `repo_id` BIGINT COMMENT 'Foreign key reference to the source code repository from which this build was compiled. Enables traceability to version control system.',
    `anti_cheat_version` STRING COMMENT 'The version of the anti-cheat system integrated into this build. Critical for competitive multiplayer and esports integrity.',
    `binary_size_mb` DECIMAL(18,2) COMMENT 'The total size of the compiled build artifact in megabytes. Critical for platform certification requirements, download optimization, and storage planning.',
    `build_timestamp` TIMESTAMP COMMENT 'The exact date and time when this build artifact was compiled by the CI/CD pipeline. The principal business event timestamp for this entity.',
    `build_type` STRING COMMENT 'The classification of the build artifact indicating its purpose and stage in the development lifecycle. Gold master represents the final certified build submitted to platform holders. [ENUM-REF-CANDIDATE: debug|release_candidate|gold_master|hotfix|patch|content_update|dlc_build|internal_playtest — 8 candidates stripped; promote to reference product]',
    `cert_approved_timestamp` TIMESTAMP COMMENT 'The date and time when this build received platform certification approval. Null if not yet approved or if certification was rejected.',
    `certification_status` STRING COMMENT 'The status of platform holder certification (TRC/TCR compliance review). Required for all console and major storefront releases. Approved status is mandatory before live deployment.. Valid values are `not_submitted|submitted|in_review|approved|rejected|conditional_approval`',
    `checksum_sha256` STRING COMMENT 'The SHA-256 cryptographic hash of the build artifact binary. Used for integrity verification, tamper detection, and secure distribution validation.. Valid values are `^[a-fA-F0-9]{64}$`',
    `content_rating` STRING COMMENT 'The age-appropriateness rating assigned by governing bodies (ESRB, PEGI, CERO, USK) for this build. Required for legal distribution and platform compliance. [ENUM-REF-CANDIDATE: ESRB_E|ESRB_E10|ESRB_T|ESRB_M|ESRB_AO|PEGI_3|PEGI_7|PEGI_12|PEGI_16|PEGI_18|CERO_A|CERO_B|CERO_C|CERO_D|CERO_Z|USK_0|USK_6|USK_12|USK_16|USK_18 — 20 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this build artifact record was first created in the data system. Audit trail field.',
    `delta_patch_size_mb` DECIMAL(18,2) COMMENT 'The size of the incremental patch from the previous build version in megabytes. Used for optimizing player download experience and CDN (Content Delivery Network) bandwidth planning.',
    `deployed_timestamp` TIMESTAMP COMMENT 'The date and time when this build was deployed to live production servers or released to players. Null if not yet deployed.',
    `deployment_status` STRING COMMENT 'The current deployment lifecycle state of this build artifact. Tracks whether the build is awaiting deployment, live in production, or has been rolled back.. Valid values are `pending|staged|deployed|rolled_back|deprecated`',
    `deprecated_timestamp` TIMESTAMP COMMENT 'The date and time when this build was marked as deprecated and no longer supported. Null if still active or supported.',
    `drm_enabled` BOOLEAN COMMENT 'Indicates whether this build includes digital rights management protection. Varies by platform and distribution agreement requirements.',
    `includes_mtx` BOOLEAN COMMENT 'Indicates whether this build includes in-game microtransaction functionality. Affects content rating disclosures and regulatory compliance (COPPA, consumer protection laws).',
    `includes_ugc` BOOLEAN COMMENT 'Indicates whether this build supports user-generated content features. Affects content moderation requirements and platform certification criteria.',
    `internal_notes` STRING COMMENT 'Internal developer and operations notes about this build, including technical details, deployment instructions, known risks, and rollback procedures. Not shared with players.',
    `is_mandatory_update` BOOLEAN COMMENT 'Indicates whether players are required to download and install this build to continue playing. True for critical security patches and breaking changes; false for optional content updates.',
    `is_rollback_available` BOOLEAN COMMENT 'Indicates whether this build can be rolled back to a previous version in case of critical issues. False for builds with irreversible database migrations or economy changes.',
    `max_ccu_supported` STRING COMMENT 'The maximum number of concurrent users this build is designed and tested to support. Critical for infrastructure capacity planning and live operations scaling.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this build artifact record was last updated in the data system. Audit trail field.',
    `multiplayer_mode` STRING COMMENT 'The multiplayer capability of this build. Determines server infrastructure requirements, network testing scope, and platform certification paths.. Valid values are `single_player|local_multiplayer|online_multiplayer|mmo|hybrid`',
    `patch_notes` STRING COMMENT 'Player-facing release notes describing new features, bug fixes, balance changes, and known issues in this build. Published to community channels and in-game news feeds.',
    `pipeline_reference` STRING COMMENT 'The identifier or URL of the CI/CD (Continuous Integration/Continuous Deployment) pipeline job that produced this build. Links to build logs, test results, and automation history.',
    `qa_status` STRING COMMENT 'The current quality assurance testing status of this build artifact. Determines whether the build is approved for progression to the next stage (UAT, certification, or live deployment).. Valid values are `not_tested|in_testing|passed|failed|conditional_pass|waived`',
    `semantic_version` STRING COMMENT 'The semantic version string following the major.minor.patch format (e.g., 2.5.1 or 1.0.0-beta). Used for player-facing version identification and compatibility tracking.. Valid values are `^d+.d+.d+(-.+)?$`',
    `source_branch` STRING COMMENT 'The version control branch from which this build was compiled (e.g., main, release/2.5, hotfix/critical-crash). Enables traceability back to source code and supports rollback scenarios.',
    `source_changelist` STRING COMMENT 'The specific changelist or commit identifier in the version control system that was used to produce this build. Provides exact source code traceability.',
    `storage_location_uri` STRING COMMENT 'The cloud storage or CDN URI where this build artifact binary is stored. Used for deployment automation and distribution. Confidential to prevent unauthorized access.',
    `submitted_for_cert_timestamp` TIMESTAMP COMMENT 'The date and time when this build was submitted to the platform holder for TRC/TCR certification review. Null if not yet submitted.',
    `target_platform` STRING COMMENT 'The gaming platform or console for which this build artifact was compiled and packaged. Critical for platform certification (TRC/TCR) tracking and distribution management. [ENUM-REF-CANDIDATE: pc|playstation_5|playstation_4|xbox_series_x|xbox_one|nintendo_switch|ios|android|web|stadia|multi_platform — 11 candidates stripped; promote to reference product]',
    CONSTRAINT pk_build_artifact PRIMARY KEY(`build_artifact_id`)
) COMMENT 'Represents a specific compiled and versioned game build artifact produced during development or live operations. Tracks build number, semantic version, target platform, source branch, build type (debug, release candidate, gold master, hotfix, patch, content update, DLC build), CI/CD pipeline reference, binary size, QA status, patch notes, mandatory/optional deployment flag, rollback availability, and delta patch size. The SSOT for what code artifact was submitted to platform certification, deployed to live servers, or delivered as a player-facing update (including patches and hotfixes).';

CREATE OR REPLACE TABLE `gaming_ecm`.`title`.`title_release` (
    `title_release_id` BIGINT COMMENT 'Unique identifier for the title release event. Primary key.',
    `build_artifact_id` BIGINT COMMENT 'Foreign key linking to title.build_artifact. Business justification: A title release event deploys a specific build artifact to a platform/storefront. Currently title_release.build_id points to studio.build (cross-domain). Within the title domain, the authoritative bui',
    `build_id` BIGINT COMMENT 'Reference to the specific game build version being deployed in this release.',
    `employee_id` BIGINT COMMENT 'Reference to the employee responsible for managing and coordinating this release event.',
    `marketing_campaign_id` BIGINT COMMENT 'Reference to the marketing campaign associated with this release event.',
    `platform_storefront_id` BIGINT COMMENT 'Reference to the target gaming platform (console, PC, mobile) for this release.',
    `storefront_id` BIGINT COMMENT 'Reference to the digital storefront or distribution channel (Steam, Epic Games Store, PlayStation Store, Xbox Store, App Store, Google Play).',
    `title_sku_id` BIGINT COMMENT 'Reference to the specific game title SKU being released (base game, edition, bundle).',
    `actual_release_date` DATE COMMENT 'Actual date when the title release went live on the target platform and storefront. Null if not yet released.',
    `announcement_url` STRING COMMENT 'URL to the public release announcement or blog post for this release.',
    `certification_approval_date` DATE COMMENT 'Date when the platform holder approved the build for release. Null if not yet approved.',
    `certification_status` STRING COMMENT 'Platform certification status indicating compliance with Technical Requirements Checklist (TRC) or Technical Certification Requirements (TCR) for console releases.. Valid values are `not_submitted|submitted|in_review|approved|rejected|waived`',
    `certification_submission_date` DATE COMMENT 'Date when the build was submitted to the platform holder for certification review.',
    `content_rating` STRING COMMENT 'Age and content rating assigned by the governing body for the target region (ESRB, PEGI, CERO, USK, GRAC).',
    `content_rating_authority` STRING COMMENT 'The governing body that issued the content rating for this release.. Valid values are `ESRB|PEGI|CERO|USK|GRAC|other`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this release record was first created in the system.',
    `deprecation_date` DATE COMMENT 'Date when this release version is scheduled to be deprecated or sunset. Null if no deprecation is planned.',
    `early_access_flag` BOOLEAN COMMENT 'Indicates whether this release is part of an early access program allowing players to access the game before full launch.',
    `forced_update_flag` BOOLEAN COMMENT 'Indicates whether players are required to update to this release version to continue playing.',
    `go_live_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the release was made available to players on the storefront.',
    `gold_master_flag` BOOLEAN COMMENT 'Indicates whether this release represents the gold master build approved for manufacturing or final distribution.',
    `minimum_client_version` STRING COMMENT 'Minimum game client version required for compatibility with this release.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this release record was last modified.',
    `notes` STRING COMMENT 'Public-facing or internal release notes describing new features, fixes, and changes included in this release.',
    `patch_size_mb` DECIMAL(18,2) COMMENT 'Size of the release package or patch in megabytes that players must download.',
    `phased_rollout_flag` BOOLEAN COMMENT 'Indicates whether this release is being deployed in phases to a subset of players before full rollout.',
    `pre_order_flag` BOOLEAN COMMENT 'Indicates whether this release is available for pre-order before the official launch date.',
    `priority` STRING COMMENT 'Business priority level assigned to this release event for resource allocation and scheduling.. Valid values are `critical|high|medium|low`',
    `region_scope` STRING COMMENT 'Geographic region or territory scope for this release (e.g., NA, EU, APAC, global). Pipe-separated list of ISO 3166-1 alpha-3 country codes or region identifiers.',
    `release_number` STRING COMMENT 'Business identifier for the release event, typically following semantic versioning or internal release numbering convention.',
    `release_status` STRING COMMENT 'Current lifecycle status of the release event in the deployment workflow. [ENUM-REF-CANDIDATE: planned|scheduled|in_certification|approved|live|rolled_back|cancelled|deprecated — 8 candidates stripped; promote to reference product]',
    `release_type` STRING COMMENT 'Classification of the release event type indicating the nature and scope of the deployment. [ENUM-REF-CANDIDATE: soft_launch|hard_launch|early_access|beta|alpha|patch|hotfix|dlc_drop|season_update|content_update|expansion — 11 candidates stripped; promote to reference product]',
    `rollback_flag` BOOLEAN COMMENT 'Indicates whether this release was rolled back after deployment due to critical issues.',
    `rollback_reason` STRING COMMENT 'Business explanation for why the release was rolled back, including critical defects or compliance issues.',
    `rollback_timestamp` TIMESTAMP COMMENT 'Timestamp when the release was rolled back. Null if no rollback occurred.',
    `rollout_percentage` DECIMAL(18,2) COMMENT 'Percentage of the player base targeted for this release phase (0.00 to 100.00). Applicable for phased rollouts.',
    `scheduled_release_date` DATE COMMENT 'Planned date for the title release to go live on the target platform and storefront.',
    `territory_restriction_flag` BOOLEAN COMMENT 'Indicates whether this release has geographic or territorial restrictions applied.',
    CONSTRAINT pk_title_release PRIMARY KEY(`title_release_id`)
) COMMENT 'Captures a planned or executed release event for a game title SKU on a specific platform and storefront. Tracks release type (soft launch, hard launch, early access, patch, DLC drop, season update), scheduled release date, actual release date, region/territory scope, go-live status, rollback flag, and release manager. Links a build to a SKU and a platform storefront. The SSOT for when and where a title went live.';

CREATE OR REPLACE TABLE `gaming_ecm`.`title`.`dlc_bundle` (
    `dlc_bundle_id` BIGINT COMMENT 'Unique identifier for the DLC bundle. Primary key for the DLC bundle entity.',
    `asset_bundle_id` BIGINT COMMENT 'Foreign key linking to content.asset_bundle. Business justification: DLC bundles are distributed as asset bundles to players. Content delivery systems, storefront integration, and CDN distribution workflows depend on linking DLC products to their packaged asset bundles',
    `build_id` BIGINT COMMENT 'Foreign key linking to studio.build. Business justification: DLC releases require specific build tracking for deployment, certification submission, and version management. Critical for live ops release planning and platform certification workflows in GaaS title',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to studio.dev_project. Business justification: DLC developed as sub-projects or within main project scope. Critical for content roadmap planning, resource allocation, milestone tracking, and coordinating DLC certification with base game updates.',
    `game_studio_id` BIGINT COMMENT 'Foreign key linking to studio.game_studio. Business justification: DLC may be developed by different studio than base game (outsourcing, co-development). Critical for multi-studio coordination, IP rights management, revenue sharing, and tracking studio-specific DLC p',
    `game_title_id` BIGINT COMMENT 'Reference to the parent game title that this DLC bundle is associated with. Links the DLC to its base game.',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: DLC often contains licensed content (music packs, branded cosmetics, celebrity likenesses). Required for royalty calculation per DLC sale and content rights verification.',
    `marketing_campaign_id` BIGINT COMMENT 'Reference to the marketing campaign associated with this DLC launch. Used for attribution, ROI tracking, and cross-channel campaign coordination.',
    `title_season_id` BIGINT COMMENT 'Foreign key linking to title.title_season. Business justification: DLC bundles are often part of a live-service season (season pass content, seasonal events). Currently dlc_bundle.season_number is an INT with no referential integrity. Adding title_season_id FK normal',
    `base_price_usd` DECIMAL(18,2) COMMENT 'The standard retail price of the DLC bundle in US dollars before any regional pricing adjustments or promotional discounts.',
    `battle_pass_tier` STRING COMMENT 'The tier level within a battle pass system where this bundle is unlocked. Nullable for non-battle-pass content. Used for progression and monetization design.',
    `bundle_code` STRING COMMENT 'Unique alphanumeric code used for internal tracking, SKU management, and platform certification. The externally-known identifier for this DLC bundle.. Valid values are `^[A-Z0-9_-]{4,20}$`',
    `bundle_name` STRING COMMENT 'The marketing name of the DLC bundle as displayed in storefronts and in-game menus. Human-readable identifier for the content offering.',
    `bundle_status` STRING COMMENT 'Current lifecycle status of the DLC bundle from concept through retirement. Tracks the bundle through development, certification, release, and end-of-life phases. [ENUM-REF-CANDIDATE: concept|in_development|submitted_for_cert|certified|released|deprecated|retired — 7 candidates stripped; promote to reference product]',
    `certification_date` DATE COMMENT 'The date when the DLC bundle received final platform certification approval. Nullable until certification is complete. Used for release readiness tracking.',
    `certification_status` STRING COMMENT 'Current status of platform certification process (TRC/TCR compliance). Tracks progress through first-party approval gates required for release.. Valid values are `not_submitted|submitted|in_review|approved|rejected|resubmitted`',
    `content_descriptors` STRING COMMENT 'Comma-separated list of content warning descriptors (violence, language, blood, etc.) as defined by rating boards. Required for platform certification and consumer transparency.',
    `content_rating` STRING COMMENT 'Age-appropriateness rating assigned by governing bodies (ESRB, PEGI, CERO, USK, GRAC). May differ from base game rating if DLC introduces new content types.',
    `created_by_user` STRING COMMENT 'The username or identifier of the person who created this DLC bundle record. Used for accountability and audit purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this DLC bundle record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the base price. Supports multi-currency pricing strategies across global markets.. Valid values are `^[A-Z]{3}$`',
    `description_long` STRING COMMENT 'Detailed marketing description of the DLC bundle content, features, and value proposition. Used on product detail pages and press releases.',
    `description_short` STRING COMMENT 'Brief marketing description of the DLC bundle, typically used in storefront listings and promotional materials. Limited to 150-200 characters.',
    `developer_notes` STRING COMMENT 'Internal notes from the development team regarding design decisions, technical constraints, or known issues. Confidential business information not shared with players.',
    `dlc_type` STRING COMMENT 'Classification of the DLC bundle by content type. Determines the nature of the content offering and its business model.. Valid values are `expansion_pack|season_pass|cosmetic_bundle|map_pack|story_dlc|battle_pass`',
    `end_of_sale_date` DATE COMMENT 'The date when the DLC bundle will no longer be available for purchase. Nullable for evergreen content. Used for limited-time offers and seasonal content.',
    `entitlement_count` STRING COMMENT 'Number of individual entitlements (items, skins, maps, missions) included in this DLC bundle. Used for value communication and inventory management.',
    `entitlement_summary` STRING COMMENT 'High-level summary of what content the player receives (e.g., 5 new maps, 10 character skins, 1 story mission). Used for marketing and player communication.',
    `exclusive_platform` STRING COMMENT 'The platform name if this DLC is platform-exclusive. Nullable for multi-platform releases. Used for tracking exclusivity agreements and first-party partnerships.',
    `exclusivity_end_date` DATE COMMENT 'The date when platform exclusivity expires and the DLC becomes available on other platforms. Nullable for permanent exclusives. Used for release planning.',
    `file_size_mb` DECIMAL(18,2) COMMENT 'Total download size of the DLC bundle in megabytes. Critical for player bandwidth planning and platform storage requirements.',
    `included_in_edition` STRING COMMENT 'Comma-separated list of game editions (Deluxe, Ultimate, Gold) that include this DLC bundle at no additional cost. Used for bundling and upsell strategies.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this DLC bundle record is currently active in the system. False for soft-deleted or archived records. Used for data lifecycle management.',
    `is_free` BOOLEAN COMMENT 'Indicates whether the DLC bundle is offered at no cost to players. True for free updates, promotional content, and community goodwill releases.',
    `is_platform_exclusive` BOOLEAN COMMENT 'Indicates whether this DLC bundle is exclusive to a specific platform (e.g., PlayStation-exclusive content). Used for partnership agreements and marketing.',
    `is_pre_order_bonus` BOOLEAN COMMENT 'Indicates whether this DLC bundle was offered as a pre-order incentive for the base game or another DLC. Used for marketing attribution and exclusivity tracking.',
    `is_time_limited` BOOLEAN COMMENT 'Indicates whether this DLC bundle is available for a limited time only. True for seasonal events, holiday content, and promotional offers.',
    `modified_by_user` STRING COMMENT 'The username or identifier of the person who last modified this DLC bundle record. Used for change management and audit trail.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this DLC bundle record was last updated. Used for change tracking and data freshness monitoring.',
    `planned_release_date` DATE COMMENT 'The originally scheduled release date for the DLC bundle. Used for roadmap planning and marketing campaign coordination.',
    `platform_availability` STRING COMMENT 'Comma-separated list of platforms where this DLC bundle is available (PC, PlayStation, Xbox, Nintendo Switch, Mobile). Tracks cross-platform release strategy.',
    `release_date` DATE COMMENT 'The date when the DLC bundle was first made available to players across any platform. Represents the official launch date for the content.',
    `requires_base_game` BOOLEAN COMMENT 'Indicates whether the player must own the base game title to access this DLC. False for standalone expansions that can be played independently.',
    `storefront_image_url` STRING COMMENT 'URL to the primary storefront thumbnail or hero image for the DLC bundle. Used across digital storefronts and in-game menus.',
    `trailer_url` STRING COMMENT 'URL to the official promotional trailer or gameplay video for the DLC bundle. Used in storefront listings and marketing materials.',
    CONSTRAINT pk_dlc_bundle PRIMARY KEY(`dlc_bundle_id`)
) COMMENT 'Master record for Downloadable Content (DLC) and content bundle offerings associated with a game title. Covers expansion packs, season passes, cosmetic bundles, map packs, story DLC, and battle pass content tiers. Tracks DLC type, included entitlements, pricing, platform availability, release date, content rating applicability, file size, and whether the DLC is included in any edition. The SSOT for all post-launch paid and free content offerings.';

CREATE OR REPLACE TABLE `gaming_ecm`.`title`.`content_rating` (
    `content_rating_id` BIGINT COMMENT 'Unique identifier for the content rating record. Primary key.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title that received this content rating. Links to the master game title catalog.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Content ratings are issued by jurisdiction-specific authorities (ESRB/US, PEGI/EU, CERO/Japan). Essential for regional compliance reporting, multi-territory launch planning, and rating authority coord',
    `appeal_date` DATE COMMENT 'The date when an appeal was filed with the rating authority, if applicable.',
    `appeal_resolution_date` DATE COMMENT 'The date when the rating authority resolved the appeal and issued a final decision.',
    `appeal_status` STRING COMMENT 'Status of any appeal filed by the publisher if they disagreed with the initial rating decision. Tracks the appeal process through resolution.. Valid values are `not_appealed|appeal_pending|appeal_approved|appeal_denied`',
    `certification_date` DATE COMMENT 'The date when the rating authority officially certified and issued the content rating. This is the authoritative date for compliance and distribution purposes.',
    `certification_number` STRING COMMENT 'The unique certification or registration number issued by the rating authority upon approval. Used for official documentation and compliance verification.',
    `compliance_officer` STRING COMMENT 'Name or identifier of the internal compliance officer or legal team member responsible for managing this rating submission and ensuring regulatory adherence.',
    `content_descriptors` STRING COMMENT 'Comma-separated list of content descriptors that explain why the game received its rating. Examples: Violence, Blood, Strong Language, Suggestive Themes, Use of Alcohol, In-Game Purchases. Descriptors vary by rating authority.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this content rating record was first created in the system. Used for audit trail and data lineage.',
    `digital_certificate_url` STRING COMMENT 'URL or file path to the digital certificate or official documentation issued by the rating authority as proof of certification.',
    `expiration_date` DATE COMMENT 'The date when this content rating expires or requires renewal, if applicable. Some rating authorities require periodic re-certification for live service games with evolving content.',
    `in_game_purchases_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the game includes in-app purchases (IAP), microtransactions (MTX), or other monetization features that must be disclosed to consumers and rating authorities.',
    `interactive_elements` STRING COMMENT 'Comma-separated list of interactive features that may affect the player experience but are not part of the rated content. Examples: Users Interact, Shares Location, In-Game Purchases, Unrestricted Internet, Digital Purchases.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this content rating is currently active and valid for distribution. Inactive ratings may be superseded by newer ratings or expired.',
    `loot_box_disclosure` BOOLEAN COMMENT 'Boolean flag indicating whether the game contains loot boxes, gacha mechanics, or randomized in-game purchases that require consumer disclosure under emerging regulations.',
    `online_notice_required` BOOLEAN COMMENT 'Boolean flag indicating whether the game requires an online privacy notice or additional disclosure due to online features, user-generated content (UGC), or data collection practices. Required for COPPA (Childrens Online Privacy Protection Act) and GDPR (General Data Protection Regulation) compliance.',
    `platform_scope` STRING COMMENT 'Comma-separated list of platforms or distribution channels covered by this rating certification. Examples: PlayStation 5, Xbox Series X, PC, Nintendo Switch, iOS, Android, Steam, Epic Games Store. Some ratings are platform-specific.',
    `publisher_contact_email` STRING COMMENT 'The email address of the publisher representative who submitted the rating application and serves as the primary contact for the rating authority.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `rating_artwork_url` STRING COMMENT 'URL or file path to the official rating logo or artwork provided by the rating authority for use on game packaging, marketing materials, and digital storefronts.',
    `rating_authority` STRING COMMENT 'The official ratings organization that issued this content rating. ESRB (Entertainment Software Rating Board) for North America, PEGI (Pan European Game Information) for Europe, CERO (Computer Entertainment Rating Organization) for Japan, USK (Unterhaltungssoftware Selbstkontrolle) for Germany, GRAC (Game Rating and Administration Committee) for South Korea, ACB (Australian Classification Board) for Australia.. Valid values are `ESRB|PEGI|CERO|USK|GRAC|ACB`',
    `rating_fee_amount` DECIMAL(18,2) COMMENT 'The fee charged by the rating authority for processing and certifying the content rating. Fee structures vary by authority, game budget, and platform.',
    `rating_fee_currency` STRING COMMENT 'The currency in which the rating fee was charged. Uses ISO 4217 3-letter currency codes.. Valid values are `USD|EUR|JPY|GBP|AUD|KRW`',
    `rating_status` STRING COMMENT 'Current lifecycle status of the content rating application or certification. Tracks the rating from initial submission through approval or rejection. [ENUM-REF-CANDIDATE: pending|submitted|under_review|approved|rejected|expired|revoked|appealed — 8 candidates stripped; promote to reference product]',
    `rating_summary` STRING COMMENT 'A brief textual summary provided by the rating authority explaining the rationale for the assigned rating and highlighting key content elements that influenced the decision.',
    `rating_type` STRING COMMENT 'The type of rating submission. Initial rating for new game releases, re-rating for content changes, update for patches, DLC (Downloadable Content) or expansion for additional content packages.. Valid values are `initial|re_rating|update|dlc|expansion|patch`',
    `rating_value` DECIMAL(18,2) COMMENT 'The age rating or classification assigned by the rating authority. Examples: E (Everyone), T (Teen), M (Mature) for ESRB; PEGI 3, PEGI 7, PEGI 12, PEGI 16, PEGI 18 for PEGI; A (All Ages), B (12+), C (15+), D (17+), Z (18+) for CERO. Format varies by authority.',
    `rating_version` STRING COMMENT 'Version identifier for the game build or content package that was rated. Links the rating to a specific game version or SKU (Stock Keeping Unit) to ensure compliance tracking.',
    `region_scope` STRING COMMENT 'Geographic region or jurisdiction where this content rating is valid and recognized. Examples: USA, CAN (Canada), EUR (Europe), JPN (Japan), KOR (South Korea), AUS (Australia). Uses 3-letter country codes.',
    `reviewer_notes` STRING COMMENT 'Internal notes or feedback provided by the rating authority reviewers during the evaluation process. May include guidance for content adjustments or clarifications. Confidential business information.',
    `submission_date` DATE COMMENT 'The date when the game title was submitted to the rating authority for content evaluation and age classification.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this content rating record was last modified. Used for audit trail and change tracking.',
    CONSTRAINT pk_content_rating PRIMARY KEY(`content_rating_id`)
) COMMENT 'Stores the official content age rating assigned to a game title by a recognized ratings authority (ESRB, PEGI, CERO, USK, GRAC, ACB). Captures rating authority, rating value, content descriptors, interactive elements, and certification date. Single source of truth for all game content ratings.';

CREATE OR REPLACE TABLE `gaming_ecm`.`title`.`title_lifecycle_event` (
    `title_lifecycle_event_id` BIGINT COMMENT 'Unique identifier for the title lifecycle event record. Primary key.',
    `build_id` BIGINT COMMENT 'Reference to the specific game build associated with this lifecycle event, if applicable.',
    `changelist_id` BIGINT COMMENT 'Reference to the version control changelist or commit associated with this milestone, if applicable.',
    `dev_project_id` BIGINT COMMENT 'Reference to the development project associated with this lifecycle event.',
    `game_studio_id` BIGINT COMMENT 'Reference to the game studio responsible for this lifecycle milestone.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title that this lifecycle event pertains to.',
    `title_release_id` BIGINT COMMENT 'Reference to the release record associated with this lifecycle event, if applicable.',
    `actual_date` DATE COMMENT 'The actual date on which the lifecycle milestone was achieved, used for variance analysis against the planned date.',
    `affected_platforms` STRING COMMENT 'Comma-separated list of platform codes affected by this lifecycle event (e.g., PS5, XBOX, PC, IOS, ANDROID).',
    `announcement_url` STRING COMMENT 'The URL of the public announcement or press release for this lifecycle milestone, if applicable.',
    `approver_role` STRING COMMENT 'The organizational role or title of the approving authority (e.g., Executive Producer, Studio Head, Publishing Director).',
    `approving_authority` STRING COMMENT 'The name or identifier of the individual, role, or committee that approved or authorized this lifecycle milestone transition.',
    `build_version` STRING COMMENT 'The version number or label of the game build associated with this milestone (e.g., 1.0.0, 2.3.1-beta).',
    `certification_status` STRING COMMENT 'The platform certification status at the time of this event. Relevant for milestones requiring Technical Requirements Checklist (TRC) or Technical Certification Requirements (TCR) compliance.. Valid values are `not_applicable|pending|in_progress|passed|failed|conditional_pass`',
    `content_rating` STRING COMMENT 'The content rating assigned to the title at this milestone (e.g., ESRB: E, T, M; PEGI: 3, 7, 12, 16, 18; CERO: A, B, C, D, Z).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this lifecycle event record was first created in the system.',
    `data_deletion_date` DATE COMMENT 'For end-of-life events: the scheduled date on which player data will be permanently deleted from production systems.',
    `data_retention_policy` STRING COMMENT 'For end-of-life events: description of how player data will be retained, archived, or deleted following service termination.',
    `epic_key` STRING COMMENT 'The Jira epic key associated with this lifecycle milestone, representing the larger body of work.',
    `event_date` DATE COMMENT 'The calendar date on which the lifecycle milestone event occurred.',
    `event_metadata` STRING COMMENT 'Additional structured or semi-structured metadata associated with this lifecycle event, such as key decisions, stakeholder notes, or external dependencies.',
    `event_timestamp` TIMESTAMP COMMENT 'The precise date and time when the lifecycle milestone event was recorded, including timezone information.',
    `is_public_announcement` BOOLEAN COMMENT 'Indicates whether this lifecycle milestone was publicly announced to players, media, or stakeholders.',
    `jira_issue_key` STRING COMMENT 'The Jira issue key (e.g., PROJ-1234) tracking this lifecycle milestone in the project management system.',
    `milestone_status` STRING COMMENT 'The current status of this lifecycle milestone event.. Valid values are `scheduled|in_progress|completed|cancelled|deferred`',
    `milestone_type` STRING COMMENT 'The type of lifecycle milestone reached by the title. Represents the stage in the game development and publishing lifecycle. [ENUM-REF-CANDIDATE: concept_approval|greenlight|pre_production|production|alpha|beta|gold_master|launch|live_operations|end_of_life|server_sunset|delisting — 12 candidates stripped; promote to reference product]',
    `modified_by` STRING COMMENT 'The username or identifier of the user who last modified this lifecycle event record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this lifecycle event record was last modified.',
    `notes` STRING COMMENT 'Free-text notes or comments providing additional context, decisions, or observations about this lifecycle milestone event.',
    `planned_date` DATE COMMENT 'The originally planned or scheduled date for this lifecycle milestone, used for variance tracking and project management.',
    `player_notification_date` DATE COMMENT 'For end-of-life events: the date on which players were officially notified of the upcoming service termination or delisting.',
    `player_notification_method` STRING COMMENT 'For end-of-life, server sunset, or delisting events: the method used to notify players (e.g., in-game message, email, website announcement, social media).',
    `rating_authority` STRING COMMENT 'The governing body that issued the content rating (e.g., ESRB for North America, PEGI for Europe).. Valid values are `ESRB|PEGI|CERO|USK|GRAC|other`',
    `refund_policy` STRING COMMENT 'For end-of-life or delisting events: description of the refund policy offered to players for in-game purchases, subscriptions, or DLC.',
    `regulatory_compliance_notes` STRING COMMENT 'Free-text notes documenting regulatory compliance considerations, actions taken, or certifications obtained for this lifecycle event.',
    `variance_days` STRING COMMENT 'The number of days between the planned date and the actual date. Positive values indicate delays; negative values indicate early completion.',
    `created_by` STRING COMMENT 'The username or identifier of the user who created this lifecycle event record.',
    CONSTRAINT pk_title_lifecycle_event PRIMARY KEY(`title_lifecycle_event_id`)
) COMMENT 'Audit log tracking a game titles progression through defined business milestones: concept approval, greenlight, pre-production, production, alpha, beta, gold master, launch, live operations, end-of-life, server sunset, and delisting. Each record captures milestone type, event date, approving authority, associated build or release reference, affected platforms, and event metadata. For end-of-life events: player notification method, refund policy, data retention policy, and regulatory compliance notes. The SSOT for lifecycle reporting, milestone tracking, and formal title retirement decisions.';

CREATE OR REPLACE TABLE `gaming_ecm`.`title`.`franchise` (
    `franchise_id` BIGINT COMMENT 'Unique identifier for the game franchise or intellectual property (IP) family. Primary key.',
    `game_studio_id` BIGINT COMMENT 'Reference to the primary game studio or development organization responsible for the franchise. Links to the studio master data for organizational hierarchy and resource allocation.',
    `genre_classification_id` BIGINT COMMENT 'Foreign key linking to title.genre_classification. Business justification: Franchises have a primary genre identity (e.g., Call of Duty = Shooter, FIFA = Sports). Currently franchise.primary_genre is a STRING. Adding primary_genre_id FK to genre_classification normalizes fra',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Franchises are strategic P&L reporting units in gaming. Finance teams track franchise-level profitability, EBITDA, and ROI in profit centers for portfolio management, investment decisions, and executi',
    `active_titles_count` STRING COMMENT 'The number of titles within the franchise that are currently active in market (available for purchase, receiving live operations support, or in active development). Used for portfolio health monitoring.',
    `brand_guidelines_url` STRING COMMENT 'URL or document reference to the official brand guidelines, style guide, and usage policies for the franchise IP. Used by marketing, licensing, and external partners.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this franchise record was first created in the system. Used for data lineage and audit trail purposes.',
    `cross_media_comics_flag` BOOLEAN COMMENT 'Indicates whether the franchise has been extended into comics, graphic novels, or manga. True if published comic content exists.',
    `cross_media_film_flag` BOOLEAN COMMENT 'Indicates whether the franchise has been adapted into film or streaming media. True if film/TV adaptations exist or are in production.',
    `cross_media_merchandise_flag` BOOLEAN COMMENT 'Indicates whether the franchise has licensed merchandise programs (toys, apparel, collectibles). True if merchandise licensing agreements are active.',
    `cross_media_theme_park_flag` BOOLEAN COMMENT 'Indicates whether the franchise has been adapted into theme park attractions, experiences, or location-based entertainment. True if theme park partnerships exist.',
    `cross_media_tv_flag` BOOLEAN COMMENT 'Indicates whether the franchise has been adapted into television series or episodic streaming content. True if TV adaptations exist or are in production.',
    `esports_enabled_flag` BOOLEAN COMMENT 'Indicates whether the franchise supports competitive esports leagues, tournaments, or organized competitive play. True if official esports programs exist.',
    `franchise_code` STRING COMMENT 'Short alphanumeric code used internally for franchise identification in systems, reporting, and SKU (Stock Keeping Unit) generation. Typically 3-10 uppercase characters.. Valid values are `^[A-Z0-9]{3,10}$`',
    `franchise_name` STRING COMMENT 'The official brand name of the game franchise or IP family (e.g., Call of Duty, FIFA, The Legend of Zelda). This is the primary business identifier used across all marketing, publishing, and distribution channels.',
    `franchise_status` STRING COMMENT 'Current lifecycle state of the franchise: active (currently publishing titles), dormant (no active development but IP retained), retired (end-of-life, no future titles planned), in_development (new franchise being established).. Valid values are `active|dormant|retired|in_development`',
    `franchise_tier` STRING COMMENT 'Strategic tier classification indicating investment level and market positioning: AAA flagship (highest budget, global reach), AA mid-tier (moderate budget, targeted markets), indie (small budget, niche audience), mobile-first (optimized for mobile platforms), experimental (proof-of-concept or emerging IP).. Valid values are `aaa_flagship|aa_midtier|indie|mobile_first|experimental`',
    `inception_year` STRING COMMENT 'The year the franchise was first established or the first title in the franchise was released. Used for franchise age calculations and historical analysis.',
    `ip_owner_entity` STRING COMMENT 'Legal entity or organization that owns the intellectual property rights to the franchise. May be the publishing studio, parent company, or external licensor.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this franchise record is currently active in the system. False if the record has been logically deleted or archived. Used for data filtering and reporting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this franchise record was most recently updated. Used for change tracking and data quality monitoring.',
    `last_title_release_date` DATE COMMENT 'The date the most recent title in the franchise was released. Used to assess franchise recency and activity level.',
    `launch_date` DATE COMMENT 'The date the first title in the franchise was officially released to market. Used for franchise anniversary celebrations and historical analysis.',
    `lifetime_revenue_usd` DECIMAL(18,2) COMMENT 'The cumulative revenue generated by all titles within the franchise since inception, measured in US dollars. Used for franchise performance analysis and ROI (Return on Investment) calculations. Confidential financial data.',
    `localization_languages_supported` STRING COMMENT 'Comma-separated list of languages that titles in the franchise are typically localized into (e.g., English, Spanish, French, German, Japanese, Chinese). Used for localization planning and market reach analysis.',
    `monetization_model` STRING COMMENT 'The dominant revenue model for titles in this franchise: premium (upfront purchase), F2P (Free-to-Play with MTX), freemium (free base with paid upgrades), subscription (recurring access fee), GaaS (Game as a Service with ongoing content).. Valid values are `premium|f2p|freemium|subscription|gaas`',
    `next_planned_release_date` DATE COMMENT 'The anticipated release date for the next title in the franchise pipeline. Nullable if no future release is currently planned. Confidential for competitive reasons.',
    `primary_platform_focus` STRING COMMENT 'The primary platform or device category that the franchise targets: console (PlayStation, Xbox, Nintendo), PC (Windows, Mac, Linux), mobile (iOS, Android), cross-platform (multi-device), VR (Virtual Reality), cloud (streaming services).. Valid values are `console|pc|mobile|cross_platform|vr|cloud`',
    `record_source_system` STRING COMMENT 'The name of the source system or application that created or last updated this franchise record (e.g., Jira, SAP S/4HANA, Salesforce CRM). Used for data lineage and troubleshooting.',
    `secondary_genre` STRING COMMENT 'Optional secondary genre classification for franchises that blend multiple gameplay styles (e.g., action-RPG, sports-simulation). Nullable if franchise has single clear genre.',
    `social_media_handle` STRING COMMENT 'The primary social media handle or username used across platforms (Twitter, Instagram, Facebook) for official franchise communications. Used for community management and brand monitoring.',
    `strategic_priority_level` STRING COMMENT 'Internal classification of the franchises strategic importance to the business portfolio: critical (flagship, highest investment), high (key growth driver), medium (stable contributor), low (maintenance mode), sunset (planned phase-out). Confidential strategic data.. Valid values are `critical|high|medium|low|sunset`',
    `target_audience_rating` STRING COMMENT 'The typical age rating classification for titles in this franchise based on ESRB (Entertainment Software Rating Board) or PEGI (Pan European Game Information) standards. Used for marketing and compliance planning. [ENUM-REF-CANDIDATE: ec|e|e10|t|m|ao|pegi_3|pegi_7|pegi_12|pegi_16|pegi_18 — promote to reference product]',
    `target_market_regions` STRING COMMENT 'Comma-separated list of primary geographic markets or regions where the franchise is actively marketed and distributed (e.g., North America, Europe, Asia-Pacific). Used for regional strategy and localization planning.',
    `total_titles_count` STRING COMMENT 'The cumulative number of game titles released under this franchise across all platforms and editions. Includes base games, expansions, and major DLC (Downloadable Content) releases that are tracked as separate SKUs.',
    `ugc_enabled_flag` BOOLEAN COMMENT 'Indicates whether titles in the franchise support user-generated content creation, modding, or community content tools. True if UGC features are available.',
    `universe_description` STRING COMMENT 'A narrative description of the shared fictional universe, lore, setting, or thematic elements that connect titles within the franchise. Used for creative alignment and marketing messaging.',
    `valuation_usd` DECIMAL(18,2) COMMENT 'The estimated market valuation of the franchise IP in US dollars. Used for portfolio management, investment decisions, and M&A (Mergers and Acquisitions) analysis. Confidential financial data.',
    `website_url` STRING COMMENT 'The official public-facing website URL for the franchise. Used for marketing campaigns, community engagement, and player acquisition.',
    CONSTRAINT pk_franchise PRIMARY KEY(`franchise_id`)
) COMMENT 'Master record for a game franchise or IP family grouping multiple related game titles under a shared brand universe (e.g., a long-running RPG series, annual sports franchise, shared-universe shooter). Tracks franchise name, IP owner entity, franchise inception year, active/dormant/retired status, brand guidelines reference, total titles count, cross-media flags (film, TV, comics, merchandise, theme parks), and franchise tier classification (AAA flagship, AA mid-tier, indie). Enables portfolio-level IP valuation, franchise performance roll-up, and strategic planning.';

CREATE OR REPLACE TABLE `gaming_ecm`.`title`.`genre_classification` (
    `genre_classification_id` BIGINT COMMENT 'Unique identifier for the genre classification record. Primary key.',
    `parent_genre_genre_classification_id` BIGINT COMMENT 'Reference to the parent genre classification for hierarchical taxonomy (e.g., Metroidvania sub-genre links to Action parent). Null for top-level primary genres.',
    `art_style` STRING COMMENT 'Visual art style classification (e.g., Realistic, Stylized, Pixel Art, Cel-Shaded, Low Poly, Photorealistic). Used for visual preference-based recommendation engines.',
    `average_session_length_minutes` STRING COMMENT 'Typical average session length in minutes for games in this genre. Used for live operations planning, engagement modeling, and monetization strategy.',
    `camera_perspective` STRING COMMENT 'Primary camera viewpoint used in the game (e.g., first-person, third-person, top-down, isometric, side-scrolling). Important for player preference segmentation and storefront filtering. [ENUM-REF-CANDIDATE: first_person|third_person|top_down|isometric|side_scrolling|fixed_camera|mixed — 7 candidates stripped; promote to reference product]',
    `complexity_level` STRING COMMENT 'Gameplay complexity and learning curve classification (e.g., low, medium, high, expert). Used for player onboarding and FTUE design guidance.. Valid values are `low|medium|high|expert`',
    `console_store_category` STRING COMMENT 'Corresponding console platform store category (PlayStation Store, Xbox Store, Nintendo eShop) for this genre. Used for first-party platform certification and storefront alignment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this genre classification record was first created in the system. Used for audit trail and data lineage tracking.',
    `discovery_priority` STRING COMMENT 'Numeric priority ranking (1=highest) for storefront discovery and featured placement. Used by merchandising and marketing teams for genre-based promotions.',
    `epic_store_category` STRING COMMENT 'Corresponding Epic Games Store category mapping for this genre. Used for Epic storefront categorization and discovery optimization.',
    `esrb_rating_guidance` STRING COMMENT 'Typical ESRB (Entertainment Software Rating Board) rating associated with this genre (e.g., E, E10+, T, M, AO). Used for content planning and compliance guidance.. Valid values are `EC|E|E10|T|M|AO`',
    `gameplay_tag` STRING COMMENT 'Descriptive gameplay mechanic or feature tag used for discovery and recommendation (e.g., Open World, Crafting, Permadeath, Procedural Generation, Co-op, Competitive).',
    `genre_classification_description` STRING COMMENT 'Detailed business description of the genre classification, including defining characteristics, typical gameplay mechanics, and examples. Used for internal training and external storefront descriptions.',
    `genre_classification_status` STRING COMMENT 'Current lifecycle status of this genre classification (e.g., active, deprecated, retired, proposed, under_review). Used for taxonomy governance and change management.. Valid values are `active|deprecated|retired|proposed|under_review`',
    `genre_code` STRING COMMENT 'Short alphanumeric code representing the genre classification (e.g., ACT, RPG, STR, SPT, SIM, PUZ, HOR). Used as a business identifier for storefront categorization and internal systems.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `genre_name` STRING COMMENT 'Human-readable name of the primary genre (e.g., Action, Role-Playing Game, Strategy, Sports, Simulation, Puzzle, Horror).',
    `genre_type` STRING COMMENT 'Classification level indicating whether this is a primary genre, sub-genre, hybrid classification, or gameplay tag.. Valid values are `primary|sub_genre|hybrid|tag`',
    `industry_standard_alignment` STRING COMMENT 'Comma-separated list of industry standards and taxonomies this genre classification aligns with (e.g., IGDA, Steam, ESRB, PEGI, Metacritic). Used for cross-platform consistency and compliance.',
    `is_active` BOOLEAN COMMENT 'Flag indicating whether this genre classification is currently active and available for use in title catalog assignment. False for deprecated or retired genre classifications.',
    `marketing_segment` STRING COMMENT 'Marketing segmentation category for this genre (e.g., AAA Blockbuster, Indie Darling, Casual Mobile, Competitive Esports). Used for campaign targeting and player acquisition strategy.',
    `mobile_store_category` STRING COMMENT 'Corresponding mobile app store category (Apple App Store, Google Play) for this genre. Used for mobile ASO and storefront categorization.',
    `modified_by` STRING COMMENT 'User or system identifier that last modified this genre classification record. Used for change management and audit compliance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this genre classification record was last modified. Used for change tracking and audit compliance.',
    `monetization_model` STRING COMMENT 'Primary revenue model associated with this genre classification (e.g., premium, F2P, freemium, subscription, GaaS, DLC, IAP, ad-supported). Used for business model alignment and revenue forecasting. [ENUM-REF-CANDIDATE: premium|f2p|freemium|subscription|gaas|dlc|iap|ad_supported|mixed — 9 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Free-text notes and comments about this genre classification. Used for taxonomy governance discussions, change rationale, and business context documentation.',
    `pegi_rating_guidance` STRING COMMENT 'Typical PEGI (Pan European Game Information) rating associated with this genre (e.g., PEGI 3, PEGI 7, PEGI 12, PEGI 16, PEGI 18). Used for European market content planning and compliance.. Valid values are `PEGI_3|PEGI_7|PEGI_12|PEGI_16|PEGI_18`',
    `platform_affinity` STRING COMMENT 'Platform types where this genre typically performs well (e.g., Console, PC, Mobile, VR, AR, Cloud). Used for platform distribution strategy and SKU planning.',
    `player_mode` STRING COMMENT 'Supported player interaction modes (e.g., single-player, multiplayer, co-op, PvP, PvE, MMO, Battle Royale). Used for matchmaking categorization and marketing segmentation. [ENUM-REF-CANDIDATE: single_player|multiplayer|co_op|pvp|pve|mmo|battle_royale|mixed — 8 candidates stripped; promote to reference product]',
    `recommendation_weight` DECIMAL(18,2) COMMENT 'Numeric weight (0.00 to 100.00) used in recommendation engine algorithms to prioritize genre affinity matching. Higher weights indicate stronger genre preference signals.',
    `setting_theme` STRING COMMENT 'Narrative or world setting theme (e.g., Fantasy, Sci-Fi, Historical, Modern, Post-Apocalyptic, Cyberpunk, Medieval). Used for thematic discovery and content recommendation.',
    `steam_tag_mapping` STRING COMMENT 'Comma-separated list of corresponding Steam store tags for this genre classification. Used for Steam storefront categorization and ASO (App Store Optimization).',
    `sub_genre_name` STRING COMMENT 'Specific sub-genre classification providing granular categorization (e.g., Metroidvania, Roguelike, MOBA, Battle Royale, Soulslike, Tactical RPG, 4X Strategy).',
    `target_audience` STRING COMMENT 'Intended player demographic segment (e.g., casual, core, hardcore, family, children, mature). Aligns with marketing segmentation and ESRB/PEGI rating guidance.. Valid values are `casual|core|hardcore|family|children|mature`',
    `taxonomy_version` STRING COMMENT 'Version identifier for the genre classification taxonomy (e.g., v1.0, v2.1). Tracks evolution of genre definitions as industry trends emerge (e.g., Battle Royale emergence in 2017).. Valid values are `^vd+.d+(.d+)?$`',
    `typical_retention_d1_pct` DECIMAL(18,2) COMMENT 'Industry benchmark Day 1 retention percentage for this genre. Used for performance benchmarking and KPI target setting.',
    `typical_retention_d30_pct` DECIMAL(18,2) COMMENT 'Industry benchmark Day 30 retention percentage for this genre. Used for long-term engagement forecasting and LTV modeling.',
    `typical_retention_d7_pct` DECIMAL(18,2) COMMENT 'Industry benchmark Day 7 retention percentage for this genre. Used for performance benchmarking and player lifecycle analysis.',
    `usage_count` STRING COMMENT 'Number of game titles currently assigned to this genre classification. Used for taxonomy optimization and genre popularity analysis.',
    `version_effective_date` DATE COMMENT 'Date when this taxonomy version became effective. Used for historical genre classification analysis and trend tracking.',
    `version_end_date` DATE COMMENT 'Date when this taxonomy version was superseded by a newer version. Null for the current active version. Used for temporal genre classification queries.',
    `created_by` STRING COMMENT 'User or system identifier that created this genre classification record. Used for audit trail and data governance.',
    CONSTRAINT pk_genre_classification PRIMARY KEY(`genre_classification_id`)
) COMMENT 'Versioned reference taxonomy defining the standardized genre and sub-genre classification system for the game title catalog. Captures primary genre (Action, RPG, Strategy, Sports, Simulation, Puzzle, Horror), sub-genre (Metroidvania, Roguelike, MOBA, Battle Royale), gameplay tags, camera perspective, and alignment with industry standards (IGDA, Steam tags, platform store taxonomies). Taxonomy is versioned to track evolution with industry trends. Used for storefront categorization, discovery algorithms, recommendation engines, and marketing segmentation.';

CREATE OR REPLACE TABLE `gaming_ecm`.`title`.`localization_version` (
    `localization_version_id` BIGINT COMMENT 'Unique identifier for the localization version record. Primary key.',
    `build_id` BIGINT COMMENT 'Reference to the specific game build or patch version that this localization is compatible with or bundled into.',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to studio.dev_project. Business justification: Localization managed within dev projects for resource allocation, milestone tracking, and certification coordination. Critical for multi-region release planning and localization vendor management with',
    `live_ops_cycle_id` BIGINT COMMENT 'Foreign key linking to studio.live_ops_cycle. Business justification: Localization updates ship with live ops cycles for seasonal content, new narratives, and regional events. Essential for coordinating translation delivery with content releases and managing localizatio',
    `game_studio_id` BIGINT COMMENT 'Foreign key linking to studio.game_studio. Business justification: Localization often outsourced to specialized studios. Replaces denormalized localization_vendor string with proper FK for vendor management, quality tracking, and multi-studio localization coordinatio',
    `game_title_id` BIGINT COMMENT 'Reference to the parent game title or DLC (Downloadable Content) that this localization version applies to.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Localizations must comply with jurisdiction-specific language requirements, cultural adaptation rules, and legal text mandates. Essential for localization compliance tracking, regional certification w',
    `music_sync_license_id` BIGINT COMMENT 'Foreign key linking to licensing.music_sync_license. Business justification: Localized versions may have region-specific music licenses due to territory restrictions. Required for regional compliance and per-territory royalty tracking.',
    `title_sku_id` BIGINT COMMENT 'Reference to the specific SKU (Stock Keeping Unit) or edition that includes this localization variant, if applicable.',
    `audio_duration_minutes` DECIMAL(18,2) COMMENT 'Total duration in minutes of localized voice-over audio content for this language version. Used for production planning and vendor billing.',
    `certification_status` STRING COMMENT 'Current status of platform certification (TRC/TCR) for this localization version with first-party console manufacturers (Sony, Microsoft, Nintendo) or app stores (Apple, Google).. Valid values are `not_submitted|submitted|in_review|approved|rejected|conditional_approval`',
    `character_encoding` STRING COMMENT 'Character encoding standard used for text assets in this localization (e.g., UTF-8, UTF-16, Shift_JIS for Japanese, GB2312 for Simplified Chinese, Big5 for Traditional Chinese).. Valid values are `UTF-8|UTF-16|Shift_JIS|GB2312|Big5|ISO-8859-1`',
    `completeness_percentage` DECIMAL(18,2) COMMENT 'Percentage of localization work completed for this language and region, ranging from 0.00 to 100.00. Used to track localization progress and readiness.',
    `content_rating_code` STRING COMMENT 'The assigned content rating code for this localization version from the applicable regional rating board (e.g., ESRB: E, T, M; PEGI: 3, 7, 12, 16, 18; CERO: A, B, C, D, Z).',
    `content_rating_required` BOOLEAN COMMENT 'Boolean flag indicating whether this localization version requires a separate content rating submission to regional rating boards (ESRB, PEGI, CERO, USK, GRAC) due to language-specific content differences.',
    `created_by_user` STRING COMMENT 'Username or identifier of the user or system that created this localization version record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this localization version record was first created in the system.',
    `cultural_adaptation_notes` STRING COMMENT 'Free-text notes documenting cultural adaptations, censorship changes, or content modifications made for this region to comply with local laws, cultural norms, or platform policies.',
    `font_support_verified` BOOLEAN COMMENT 'Boolean flag indicating whether the game engine and UI (User Interface) fonts have been verified to correctly render all characters required for this localization (critical for non-Latin scripts).',
    `included_in_base_sku` BOOLEAN COMMENT 'Boolean flag indicating whether this localization is included in the base SKU (Stock Keeping Unit) at no additional cost (True) or sold separately as a language pack or regional variant (False).',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this localization version is currently active and available (True) or has been deprecated, delisted, or archived (False).',
    `language_code` STRING COMMENT 'Two-letter ISO 639-1 language code representing the localized language (e.g., en, fr, de, ja, zh, es, pt, ru, ko, it).. Valid values are `^[a-z]{2}$`',
    `legal_compliance_status` STRING COMMENT 'Status of legal compliance review for this localization version against regional regulations (GDPR, COPPA, local content laws, gambling regulations, data residency requirements).. Valid values are `compliant|pending_review|non_compliant|requires_modification|exempt`',
    `locale_identifier` STRING COMMENT 'Combined locale identifier in language_REGION format (e.g., en_US, fr_FR, de_DE, ja_JP, zh_CN, pt_BR, es_MX) for precise localization targeting.. Valid values are `^[a-z]{2}_[A-Z]{2,3}$`',
    `localization_cost_usd` DECIMAL(18,2) COMMENT 'Total cost in USD (United States Dollar) for producing this localization version, including translation, voice acting, QA (Quality Assurance), and cultural adaptation.',
    `localization_scope` STRING COMMENT 'Defines the extent of localization coverage: full audio dub (voice acting), subtitles only, UI (User Interface) text only, partial localization, audio and subtitles, or text only.. Valid values are `full_audio_dub|subtitles_only|ui_text_only|partial_localization|audio_and_subtitles|text_only`',
    `platform_certification_required` BOOLEAN COMMENT 'Boolean flag indicating whether this localization version requires separate platform certification (TRC/TCR - Technical Requirements Checklist/Technical Certification Requirements) for first-party console manufacturers or app stores.',
    `qa_sign_off_date` DATE COMMENT 'Date when QA (Quality Assurance) formally approved this localization version for release, confirming linguistic accuracy and functional correctness.',
    `qa_status` STRING COMMENT 'Current QA (Quality Assurance) sign-off status for the localization version. Tracks whether linguistic and functional testing has been completed and approved.. Valid values are `not_started|in_progress|qa_review|qa_approved|qa_rejected|rework_required`',
    `region_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country or region code for the localization target market (e.g., USA, GBR, DEU, JPN, CHN, FRA, BRA, KOR).. Valid values are `^[A-Z]{3}$`',
    `release_date` DATE COMMENT 'Date when this localization version was officially released or made available to players in the target region.',
    `storefront_listing_status` STRING COMMENT 'Current status of this localization version on digital storefronts (Steam, Epic Games Store, PlayStation Store, Xbox Store, Nintendo eShop, App Store, Google Play).. Valid values are `not_listed|draft|pending_approval|live|delisted|region_blocked`',
    `subtitle_format` STRING COMMENT 'Technical format used for subtitle files in this localization (e.g., SRT, VTT, ASS, SSA, proprietary engine format, or none if no subtitles).. Valid values are `srt|vtt|ass|ssa|proprietary|none`',
    `sunset_date` DATE COMMENT 'Date when this localization version was or will be retired, delisted, or no longer supported. Nullable for active localizations.',
    `text_direction` STRING COMMENT 'Text rendering direction for this localization: left-to-right (ltr), right-to-left (rtl) for languages like Arabic and Hebrew, or top-to-bottom (ttb) for certain Asian scripts.. Valid values are `ltr|rtl|ttb`',
    `translation_memory_reference` STRING COMMENT 'Reference identifier to the translation memory (TM) database or glossary used for this localization, enabling consistency across titles and updates.',
    `updated_by_user` STRING COMMENT 'Username or identifier of the user or system that last updated this localization version record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this localization version record was last modified or updated.',
    `version_number` STRING COMMENT 'Semantic version number for this localization variant (e.g., 1.0, 1.1, 2.0), tracking updates and patches to localized content.. Valid values are `^d+.d+(.d+)?$`',
    `voice_actor_credits` STRING COMMENT 'Comma-separated or structured list of voice actors who performed localized audio dubbing for this language version. Used for credits and rights management.',
    `word_count` STRING COMMENT 'Total word count of localized text content (UI strings, dialogue, subtitles, in-game text) for this language version. Used for vendor billing and scope estimation.',
    CONSTRAINT pk_localization_version PRIMARY KEY(`localization_version_id`)
) COMMENT 'Tracks localization variants of a game title or DLC for each supported language and region. Captures language code (ISO 639-1), region/locale, localization completeness percentage, coverage scope (full audio dub, subtitles only, UI text only), localization vendor, QA sign-off status, and whether included in base SKU or sold separately. Critical for global publishing compliance, regional storefront listing accuracy, and platform certification language requirements.';

CREATE OR REPLACE TABLE `gaming_ecm`.`title`.`title_season` (
    `title_season_id` BIGINT COMMENT 'Unique identifier for the title season. Primary key for the title_season product.',
    `brand_partnership_id` BIGINT COMMENT 'Foreign key linking to licensing.brand_partnership. Business justification: Seasons often feature brand partnerships (Fortnite x Marvel, Apex Legends x Star Wars). Essential for revenue share calculation and partnership performance tracking.',
    `build_id` BIGINT COMMENT 'Foreign key linking to studio.build. Business justification: Seasons deploy via specific builds containing seasonal content, balance patches, and new features. Essential for GaaS release management, rollback planning, and coordinating season launches with build',
    `game_title_id` BIGINT COMMENT 'Reference to the parent game title that this season belongs to. Links to the master game title catalog.',
    `live_ops_cycle_id` BIGINT COMMENT 'Reference to the live operations cycle or sprint that governs this seasons content delivery and event schedule.',
    `actual_duration_days` STRING COMMENT 'Actual duration of the season in days from start to end. Calculated after season conclusion for retrospective analysis.',
    `announcement_date` DATE COMMENT 'Date when the season was officially announced to the player community. Used for marketing timeline tracking.',
    `balance_patch_version` STRING COMMENT 'Version number of the game balance patch deployed at season launch (e.g., 2.4.0, 3.1.5). Used for tracking gameplay changes.',
    `battle_pass_included` BOOLEAN COMMENT 'Indicates whether this season includes a battle pass progression system. True if battle pass is available; False if season has no battle pass.',
    `competitive_season_flag` BOOLEAN COMMENT 'Indicates whether this season includes a competitive ranked mode or esports tournament cycle. True if competitive season is active.',
    `content_rating` STRING COMMENT 'Age rating or content classification for this seasons content (e.g., ESRB: Teen, PEGI: 16). May differ from base game if season introduces mature content.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this season record was first created in the system. Used for audit and data lineage tracking.',
    `dlc_bundle_count` STRING COMMENT 'Number of DLC bundles or content packs released during this season. Used for monetization tracking and content planning.',
    `end_date` DATE COMMENT 'Date when the season officially concludes and transitions to the next season. Nullable for indefinite or ongoing seasons.',
    `featured_content_description` STRING COMMENT 'Detailed description of the headline content and features introduced in this season. Used for marketing materials and player communications.',
    `free_to_play_content_flag` BOOLEAN COMMENT 'Indicates whether this season includes free content available to all players without purchase. True if free content is included.',
    `leaderboard_reset_flag` BOOLEAN COMMENT 'Indicates whether player leaderboards and rankings were reset at the start of this season. True if reset occurred.',
    `marketing_tagline` STRING COMMENT 'Short marketing tagline or slogan for the season used in promotional materials and advertising campaigns.',
    `mid_season_update_flag` BOOLEAN COMMENT 'Indicates whether a major mid-season content update or refresh was released. True if mid-season update occurred.',
    `narrative_summary` STRING COMMENT 'Summary of the story or narrative arc for this season. Used for lore tracking and community engagement.',
    `new_characters_count` STRING COMMENT 'Number of new playable characters, heroes, or operators introduced in this season. Key metric for content-driven games.',
    `new_maps_count` STRING COMMENT 'Number of new maps or levels introduced in this season. Used for content tracking and player communication.',
    `new_modes_count` STRING COMMENT 'Number of new game modes introduced in this season (e.g., new PvP modes, limited-time events). Used for content tracking and marketing.',
    `new_weapons_count` STRING COMMENT 'Number of new weapons, items, or equipment introduced in this season. Used for balance tracking and content marketing.',
    `pass_required` BOOLEAN COMMENT 'Indicates whether players must own a season pass to access this seasons content. True if season pass is mandatory; False if content is free or available via other means.',
    `planned_duration_days` STRING COMMENT 'Originally planned duration of the season in days. Used for performance analysis and comparing planned vs actual season length.',
    `platform_availability` STRING COMMENT 'Comma-separated list of platforms where this season is available (e.g., PC,PlayStation,Xbox,Mobile). Used for cross-platform tracking.',
    `pre_season_event_flag` BOOLEAN COMMENT 'Indicates whether a pre-season teaser event or content drop occurred before the official season launch. True if pre-season event was held.',
    `region_availability` STRING COMMENT 'Comma-separated list of geographic regions where this season is available (e.g., NA,EU,APAC). Used for regional content management.',
    `season_code` STRING COMMENT 'Internal code or abbreviation for the season used in operational systems and analytics (e.g., S1, S2Q1, SHADOW).',
    `season_name` STRING COMMENT 'Marketing name of the season (e.g., Shadow Realm, Neon Uprising, Winter Warfare). Used in player-facing communications and in-game UI.',
    `season_number` STRING COMMENT 'Sequential number of the season within the titles live-service lifecycle (e.g., 1, 2, 3). Used for ordering and player communication.',
    `start_date` DATE COMMENT 'Date when the season officially launches and becomes available to players. Used for scheduling live operations and marketing campaigns.',
    `target_dau` STRING COMMENT 'Target daily active user count goal for this season. Used for performance benchmarking and live operations planning.',
    `target_revenue_amount` DECIMAL(18,2) COMMENT 'Target revenue goal for this season in the titles primary currency. Used for financial planning and performance evaluation.',
    `target_revenue_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the target revenue amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `theme` STRING COMMENT 'Narrative or visual theme of the season (e.g., Cyberpunk, Medieval Fantasy, Post-Apocalyptic). Guides content creation and marketing messaging.',
    `title_season_status` STRING COMMENT 'Current lifecycle status of the season. Upcoming: not yet launched; Active: currently live; Concluded: ended normally; Cancelled: terminated early; Extended: duration prolonged beyond original end date.. Valid values are `upcoming|active|concluded|cancelled|extended`',
    `trailer_url` STRING COMMENT 'URL link to the official season announcement or launch trailer. Used for marketing and community engagement.',
    `updated_by` STRING COMMENT 'Username or identifier of the user who last modified this season record. Used for audit and accountability.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this season record was last modified. Used for audit and change tracking.',
    `created_by` STRING COMMENT 'Username or identifier of the user who created this season record. Used for audit and accountability.',
    CONSTRAINT pk_title_season PRIMARY KEY(`title_season_id`)
) COMMENT 'Defines the live-service seasons for a GaaS title — the structured content and progression cycles that drive player engagement and monetization (e.g., Season 1: Shadow Realm, Season 4: Neon Uprising). Captures season number, season name, start date, end date, battle pass inclusion flag, featured content themes, new map/mode introductions, associated DLC bundles, and season status (upcoming, active, concluded). The SSOT for the live operations content calendar of a title.';

CREATE OR REPLACE TABLE `gaming_ecm`.`title`.`territory_rights` (
    `territory_rights_id` BIGINT COMMENT 'Unique identifier for the territory rights record. Primary key.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title for which these territory rights apply.',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: Territory rights are governed by IP agreements that define regional licensing terms. Essential for storefront availability decisions and regional compliance tracking.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Territory rights are fundamentally jurisdiction-bound for legal enforcement, regulatory compliance verification, and storefront availability decisions. Rights management systems require jurisdiction l',
    `certification_status` STRING COMMENT 'Status of platform certification (TRC/TCR compliance) for this territory: not_started, in_progress, passed (certified), failed (rejected), waived (not required).. Valid values are `not_started|in_progress|passed|failed|waived`',
    `channel_scope` STRING COMMENT 'Distribution channel scope covered by these rights: digital (online stores, downloads), physical (retail, disc), or both.. Valid values are `digital|physical|both`',
    `content_rating` STRING COMMENT 'The age/content rating assigned by the rating authority for this territory (e.g., E, T, M for ESRB; 3, 7, 12, 16, 18 for PEGI; A, B, C, D, Z for CERO).',
    `contract_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for financial terms associated with these territory rights (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `contract_reference_number` STRING COMMENT 'Reference number or identifier of the underlying legal contract or agreement that establishes these territory rights.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this territory rights record was first created in the system.',
    `effective_date` DATE COMMENT 'Date when these territory rights become active and enforceable.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the rights holder has exclusive rights in this territory (True) or non-exclusive rights (False).',
    `expiry_date` DATE COMMENT 'Date when these territory rights expire. Null indicates perpetual or indefinite rights.',
    `first_party_approval_required` BOOLEAN COMMENT 'Indicates whether first-party platform holder approval (e.g., Sony, Microsoft, Nintendo) is required for distribution in this territory (True) or not (False).',
    `ip_owner_entity` STRING COMMENT 'Legal entity that owns the underlying intellectual property (IP) for the game title. May differ from the rights holder if rights are licensed.',
    `language_support` STRING COMMENT 'Comma-separated list of language codes (ISO 639-1) supported for this territory (e.g., en, fr, de, es, ja, zh). Used for localization compliance and storefront metadata.',
    `launch_date` DATE COMMENT 'Planned or actual launch date for the game title in this territory. May differ from global launch date due to regional release strategies.',
    `localization_required` BOOLEAN COMMENT 'Indicates whether localization (translation, cultural adaptation) is required for this territory (True) or not (False).',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'Minimum guaranteed payment amount (if any) that the rights holder must pay or receive for these territory rights, in the contract currency.',
    `notes` STRING COMMENT 'Additional free-text notes or comments about these territory rights, including special conditions, exceptions, or operational guidance.',
    `platform_scope` STRING COMMENT 'Comma-separated list of platforms covered by these rights (e.g., PlayStation, Xbox, PC, Nintendo Switch, Mobile). Empty means all platforms.',
    `rating_authority` STRING COMMENT 'The content rating authority applicable to this territory: ESRB (North America), PEGI (Europe), USK (Germany), CERO (Japan), GRAC (South Korea), ACB (Australia), IARC (International Age Rating Coalition). [ENUM-REF-CANDIDATE: ESRB|PEGI|USK|CERO|GRAC|ACB|IARC — 7 candidates stripped; promote to reference product]',
    `regulatory_compliance_notes` STRING COMMENT 'Free-text notes capturing territory-specific regulatory requirements, restrictions, or compliance obligations (e.g., GDPR for EU, COPPA for US, content restrictions, age verification requirements).',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of revenue allocated to the rights holder for this territory, expressed as a decimal (e.g., 70.00 for 70%). Used for financial reporting and royalty calculations.',
    `rights_holder_entity` STRING COMMENT 'Legal entity name that holds the publishing or distribution rights for this title in this territory (e.g., publisher name, subsidiary, partner).',
    `rights_type` STRING COMMENT 'Type of rights granted: publish (full publishing rights), distribute (distribution only), co-publish (shared publishing), sub-license (licensed from another party), exclusive_distribution, non-exclusive_distribution.. Valid values are `publish|distribute|co-publish|sub-license|exclusive_distribution|non-exclusive_distribution`',
    `storefront_availability` STRING COMMENT 'Comma-separated list of digital storefronts where the title may be offered in this territory (e.g., Steam, Epic Games Store, PlayStation Store, Xbox Store, Nintendo eShop, App Store, Google Play). Used for storefront gating logic.',
    `sub_licensing_permitted` BOOLEAN COMMENT 'Indicates whether the rights holder is permitted to sub-license these rights to third parties (True) or not (False).',
    `termination_date` DATE COMMENT 'Date when these territory rights were terminated or cancelled, if applicable. Null if rights are still active or expired naturally.',
    `termination_reason` STRING COMMENT 'Free-text explanation of why the territory rights were terminated (e.g., breach of contract, mutual agreement, strategic decision, regulatory change).',
    `territory_rights_status` STRING COMMENT 'Current lifecycle status of the territory rights record: active (in force), pending (awaiting activation), expired (past expiry date), terminated (cancelled before expiry), suspended (temporarily inactive), under_review (being evaluated).. Valid values are `active|pending|expired|terminated|suspended|under_review`',
    `updated_by` STRING COMMENT 'User ID or system identifier of the person or process that last updated this territory rights record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this territory rights record was last modified.',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or process that created this territory rights record.',
    CONSTRAINT pk_territory_rights PRIMARY KEY(`territory_rights_id`)
) COMMENT 'Records the publishing and distribution rights for a game title by territory/region. Captures territory (country or region group), rights holder entity, rights type (publish, distribute, co-publish), channel scope (digital, physical, both), effective date, expiry date, exclusivity flag, and sub-licensing permissions. Critical for global publishing compliance, storefront availability gating, and IP rights management. Distinct from licensing domain contracts — this is the operational rights record per title per territory.';

CREATE OR REPLACE TABLE `gaming_ecm`.`title`.`game_mode` (
    `game_mode_id` BIGINT COMMENT 'Unique identifier for the game mode. Primary key for the game mode entity.',
    `game_title_id` BIGINT COMMENT 'Reference to the parent game title that contains this mode. Links the mode to its owning title in the master catalog.',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: Game modes may use licensed IP (branded maps, celebrity characters). Required for usage tracking, content approval, and per-mode royalty calculation in live service games.',
    `parent_game_mode_id` BIGINT COMMENT 'Self-referencing FK on game_mode (parent_game_mode_id)',
    `age_rating_override` STRING COMMENT 'Optional age rating specific to this mode if it differs from the base game title rating (e.g., a mature-rated mode within a teen-rated game). References ESRB, PEGI, CERO standards.',
    `anti_cheat_required_flag` BOOLEAN COMMENT 'Indicates whether anti-cheat software must be active to play this mode (True, typically for competitive modes) or if it is optional/disabled (False).',
    `content_warning_flags` STRING COMMENT 'Comma-separated list of content warnings specific to this mode (e.g., violence, blood, strong_language, user_interaction). Used for parental controls and compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this game mode record was first created in the system. Used for audit trail and data lineage.',
    `cross_play_supported_flag` BOOLEAN COMMENT 'Indicates whether players on different platforms can play together in this mode (True) or if platform segregation is enforced (False).',
    `cross_progression_enabled_flag` BOOLEAN COMMENT 'Indicates whether player progression and unlocks in this mode carry across platforms (True) or are platform-specific (False).',
    `display_order` STRING COMMENT 'Numeric value controlling the sort order of this mode in game menus and mode selection screens. Lower values appear first.',
    `esports_eligible_flag` BOOLEAN COMMENT 'Indicates whether this mode is approved for competitive esports tournaments and league play (True) or is casual-only (False).',
    `friendly_fire_enabled_flag` BOOLEAN COMMENT 'Indicates whether players can damage their own teammates in this mode (True) or if friendly fire is disabled (False).',
    `game_mode_description` STRING COMMENT 'Detailed text description of the game mode explaining its rules, objectives, and unique features. Used for player-facing UI and marketing materials.',
    `game_mode_status` STRING COMMENT 'Current operational status of the game mode indicating availability to players and lifecycle stage. [ENUM-REF-CANDIDATE: active|inactive|beta|deprecated|seasonal|limited_time|maintenance — 7 candidates stripped; promote to reference product]',
    `gameplay_category` STRING COMMENT 'Specific gameplay category or sub-genre that defines the core mechanics and objectives of this mode (e.g., PvP, PvE, Battle Royale, Team Deathmatch). [ENUM-REF-CANDIDATE: campaign|pvp|pve|battle_royale|team_deathmatch|capture_flag|survival|sandbox|story|arena — 10 candidates stripped; promote to reference product]',
    `launch_date` DATE COMMENT 'The date when this game mode was first made available to players. Used for lifecycle tracking and analytics.',
    `limited_time_event_flag` BOOLEAN COMMENT 'Indicates whether this mode is a limited-time event (True) available only during specific promotional periods or a permanent fixture (False).',
    `matchmaking_algorithm` STRING COMMENT 'The matchmaking algorithm or strategy used to pair players in this mode (e.g., skill-based, connection-based, ranked ELO). [ENUM-REF-CANDIDATE: skill_based|connection_based|hybrid|random|ranked_elo|glicko|trueskill — 7 candidates stripped; promote to reference product]',
    `matchmaking_enabled_flag` BOOLEAN COMMENT 'Indicates whether automated matchmaking is available for this mode (True) or if players must form custom lobbies (False).',
    `max_player_count` STRING COMMENT 'The maximum number of players that can participate simultaneously in this game mode. Defines capacity limits for matchmaking and server allocation.',
    `min_player_count` STRING COMMENT 'The minimum number of players required to start or participate in this game mode. Used for matchmaking and lobby requirements.',
    `mode_code` STRING COMMENT 'Internal system code or abbreviation for the game mode used in telemetry, analytics, and backend systems (e.g., SP_CAMPAIGN, MP_PVP, BR_SOLO).. Valid values are `^[A-Z0-9_]{2,20}$`',
    `mode_name` STRING COMMENT 'The official display name of the game mode as shown to players (e.g., Campaign, Multiplayer, Battle Royale, Ranked Competitive).',
    `mode_type` STRING COMMENT 'High-level classification of the mode type indicating the primary gameplay structure and player interaction model. [ENUM-REF-CANDIDATE: single_player|multiplayer|co_op|competitive|casual|ranked|tutorial|practice — 8 candidates stripped; promote to reference product]',
    `monetization_enabled_flag` BOOLEAN COMMENT 'Indicates whether in-game purchases, microtransactions (MTX), or monetization features are available within this mode (True) or disabled (False).',
    `online_required_flag` BOOLEAN COMMENT 'Indicates whether an active internet connection is required to play this mode (True for online multiplayer) or if offline play is supported (False for single-player campaign).',
    `platform_availability` STRING COMMENT 'Comma-separated list of platforms where this mode is available (e.g., PC, PS5, Xbox Series X, Nintendo Switch, iOS, Android). Empty if available on all platforms.',
    `progression_enabled_flag` BOOLEAN COMMENT 'Indicates whether player progression (XP, levels, unlocks) is tracked and awarded in this mode (True) or if it is a non-progression mode (False, as in practice modes).',
    `ranked_mode_flag` BOOLEAN COMMENT 'Indicates whether this mode is a competitive ranked mode with skill rating and leaderboard tracking (True) or casual unranked play (False).',
    `respawn_enabled_flag` BOOLEAN COMMENT 'Indicates whether players can respawn after elimination in this mode (True) or if elimination is permanent for the session (False, as in Battle Royale).',
    `rules_summary` STRING COMMENT 'Concise summary of the core gameplay rules and win conditions for this mode. Used for quick reference and onboarding.',
    `seasonal_flag` BOOLEAN COMMENT 'Indicates whether this mode is tied to a specific game season or live ops cycle (True) or is a permanent mode (False).',
    `session_duration_max_minutes` STRING COMMENT 'The typical maximum duration of a gameplay session in this mode, measured in minutes. Used for server resource planning and player engagement analytics.',
    `session_duration_min_minutes` STRING COMMENT 'The typical minimum duration of a gameplay session in this mode, measured in minutes. Used for player engagement analytics and session planning.',
    `spectator_mode_enabled_flag` BOOLEAN COMMENT 'Indicates whether non-playing users can spectate live matches in this mode (True) or if spectating is disabled (False). Important for esports and streaming.',
    `sunset_date` DATE COMMENT 'The planned or actual date when this mode will be or was removed from the game. Null if no sunset is planned.',
    `team_based_flag` BOOLEAN COMMENT 'Indicates whether this mode organizes players into teams (True) or is free-for-all individual play (False).',
    `team_size` STRING COMMENT 'The number of players per team when team_based_flag is True. Null for non-team modes.',
    `text_chat_enabled_flag` BOOLEAN COMMENT 'Indicates whether in-game text chat is enabled for this mode (True) or disabled (False). Relevant for player communication and moderation.',
    `tutorial_available_flag` BOOLEAN COMMENT 'Indicates whether a dedicated tutorial or First-Time User Experience (FTUE) is available for this mode (True) or if players must learn through play (False).',
    `updated_by` STRING COMMENT 'The username or system identifier of the user or process that last modified this game mode record. Used for audit and accountability.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this game mode record was last modified. Used for change tracking and audit trail.',
    `voice_chat_enabled_flag` BOOLEAN COMMENT 'Indicates whether in-game voice communication is enabled for this mode (True) or disabled (False). Relevant for team coordination and community management.',
    `created_by` STRING COMMENT 'The username or system identifier of the user or process that created this game mode record. Used for audit and accountability.',
    CONSTRAINT pk_game_mode PRIMARY KEY(`game_mode_id`)
) COMMENT 'Master definition of playable game modes within a title — single-player campaign, multiplayer PvP, co-op PvE, battle royale, ranked competitive — with mode-specific rules, player count limits, and matchmaking requirements.';

CREATE OR REPLACE TABLE `gaming_ecm`.`title`.`achievement` (
    `achievement_id` BIGINT COMMENT 'Unique identifier for the achievement. Primary key.',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to studio.dev_project. Business justification: Achievements designed and implemented within dev projects as core progression systems. Required for feature planning, design documentation tracking, and platform achievement certification (Xbox Gamers',
    `dlc_bundle_id` BIGINT COMMENT 'Reference to the DLC bundle that introduced this achievement, if applicable. Null for base game achievements.',
    `game_mode_id` BIGINT COMMENT 'Foreign key linking to title.game_mode. Business justification: achievement does not have game_mode_id in visible schema. Business case: many achievements are mode-specific (e.g., Win 10 ranked matches, Complete campaign on hard difficulty). New FK needed to l',
    `game_title_id` BIGINT COMMENT 'Reference to the game title this achievement belongs to.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to content.asset. Business justification: Achievements display icon assets in player UIs. Asset management, CDN delivery, and platform certification (Xbox, PlayStation, Steam) require formal links to icon assets, not just URL strings.',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: Achievements may unlock licensed content (branded skins, music tracks) requiring rights tracking. Needed for content approval workflows and usage reporting to licensors.',
    `live_ops_cycle_id` BIGINT COMMENT 'Foreign key linking to studio.live_ops_cycle. Business justification: Seasonal achievements tied to live ops cycles for time-limited events and battle pass progression. Critical for player engagement planning, reward system design, and coordinating achievement unlocks w',
    `prerequisite_achievement_id` BIGINT COMMENT 'Reference to another achievement that must be unlocked before this achievement becomes available, creating achievement chains or progression paths.',
    `title_season_id` BIGINT COMMENT 'Reference to the game season that introduced this achievement, applicable for live service games with seasonal content.',
    `achievement_code` STRING COMMENT 'Internal unique code or identifier used by developers to reference this achievement in game logic and telemetry systems.',
    `achievement_name` STRING COMMENT 'The display name of the achievement shown to players in-game and on platform storefronts.',
    `achievement_status` STRING COMMENT 'Current lifecycle status of the achievement: active (live and unlockable), inactive (temporarily disabled), deprecated (removed from game), planned (in development), testing (QA phase).. Valid values are `active|inactive|deprecated|planned|testing`',
    `achievement_type` STRING COMMENT 'Classification of the achievement based on gameplay context: story milestones, challenge completion, collection tasks, progression markers, hidden secrets, multiplayer feats, time-limited events, or seasonal content. [ENUM-REF-CANDIDATE: story|challenge|collection|progression|secret|multiplayer|time_limited|seasonal — 8 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this achievement record was first created in the system.',
    `deprecation_date` DATE COMMENT 'The date when this achievement was removed or deprecated, applicable for time-limited or seasonal achievements that are no longer obtainable.',
    `description_long` STRING COMMENT 'Detailed description of the achievement including unlock criteria, context, and any special conditions or tips for players.',
    `description_short` STRING COMMENT 'Brief description of the achievement displayed in achievement lists and notifications, typically one sentence.',
    `display_order` STRING COMMENT 'The sort order for displaying this achievement in achievement lists, allowing developers to control the presentation sequence.',
    `epic_achievement_code` STRING COMMENT 'The platform-specific unique identifier for this achievement in the Epic Games Store achievement system.',
    `is_hidden` BOOLEAN COMMENT 'Indicates whether the achievement details are hidden from players until unlocked, typically used for story spoilers or secret content.',
    `is_platinum_trophy` BOOLEAN COMMENT 'Indicates whether this achievement is a platinum trophy (PlayStation-specific) awarded for completing all other trophies in the game.',
    `is_secret` BOOLEAN COMMENT 'Indicates whether the achievement is classified as a secret achievement, requiring players to discover unlock conditions without explicit guidance.',
    `is_time_limited` BOOLEAN COMMENT 'Indicates whether this achievement is only available for a limited time period, such as seasonal events or promotional campaigns.',
    `localization_required` BOOLEAN COMMENT 'Indicates whether this achievement requires localization for international markets, including translated names, descriptions, and culturally adapted content.',
    `platform_availability` STRING COMMENT 'Comma-separated list of platforms where this achievement is available (e.g., Xbox, PlayStation, Steam, Epic, Nintendo Switch, Mobile).',
    `playstation_trophy_code` STRING COMMENT 'The platform-specific unique identifier for this achievement in the PlayStation Network trophy system.',
    `playstation_trophy_type` STRING COMMENT 'The trophy tier classification for PlayStation platform: bronze (common), silver (uncommon), gold (rare), or platinum (complete all trophies).. Valid values are `bronze|silver|gold|platinum`',
    `point_value` STRING COMMENT 'The point or score value awarded to the player upon unlocking this achievement, used for gamerscore or trophy level calculations.',
    `rarity_tier` STRING COMMENT 'The rarity classification of the achievement based on difficulty and expected unlock rate: common (easy), uncommon (moderate), rare (challenging), epic (very difficult), legendary (extremely rare).. Valid values are `common|uncommon|rare|epic|legendary`',
    `release_date` DATE COMMENT 'The date when this achievement was first made available to players, typically aligned with game launch or DLC release.',
    `reward_description` STRING COMMENT 'Description of the in-game reward or benefit the player receives for unlocking this achievement, if applicable.',
    `reward_type` STRING COMMENT 'The type of in-game reward granted upon unlocking this achievement: none (points only), cosmetic (skins/emotes), currency (virtual currency), item (equipment/consumables), unlock (content access).. Valid values are `none|cosmetic|currency|item|unlock`',
    `steam_achievement_code` STRING COMMENT 'The platform-specific unique identifier for this achievement in the Steam achievement system.',
    `time_limit_end` TIMESTAMP COMMENT 'The timestamp when this time-limited achievement is no longer available for unlock, after which it becomes unobtainable.',
    `time_limit_start` TIMESTAMP COMMENT 'The timestamp when this time-limited achievement becomes available for unlock, used for seasonal or event-based achievements.',
    `unlock_criteria` STRING COMMENT 'Technical specification of the conditions required to unlock this achievement, including gameplay actions, thresholds, and dependencies.',
    `unlock_percentage` DECIMAL(18,2) COMMENT 'The percentage of players who have unlocked this achievement across the entire player base, used to measure actual rarity and difficulty.',
    `updated_by` STRING COMMENT 'The username or identifier of the user who last modified this achievement record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this achievement record was last modified, tracking any changes to achievement properties or metadata.',
    `xbox_achievement_code` STRING COMMENT 'The platform-specific unique identifier for this achievement in the Xbox Live achievement system.',
    `xbox_gamerscore` STRING COMMENT 'The gamerscore value for this achievement on Xbox platform, contributing to the players overall Xbox gamerscore total.',
    `created_by` STRING COMMENT 'The username or identifier of the user who created this achievement record in the content management system.',
    CONSTRAINT pk_achievement PRIMARY KEY(`achievement_id`)
) COMMENT 'Master catalog of in-game achievements, trophies, and badges per game title with unlock criteria, point values, rarity tiers, and platform-specific achievement IDs (Xbox Gamerscore, PlayStation Trophies, Steam Achievements).';

CREATE OR REPLACE TABLE `gaming_ecm`.`title`.`leaderboard` (
    `leaderboard_id` BIGINT COMMENT 'Unique identifier for the leaderboard. Primary key.',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to studio.dev_project. Business justification: Leaderboards developed as competitive features within projects. Required for backend system design, anti-cheat integration, ranking algorithm development, and esports infrastructure planning.',
    `game_mode_id` BIGINT COMMENT 'Reference to the specific game mode this leaderboard tracks (e.g., ranked PvP, time trial, battle royale).',
    `game_title_id` BIGINT COMMENT 'Reference to the game title this leaderboard belongs to.',
    `live_ops_cycle_id` BIGINT COMMENT 'Foreign key linking to studio.live_ops_cycle. Business justification: Leaderboards in GaaS titles reset and launch with live ops cycles. Essential for seasonal competitive content planning, player engagement tracking, and coordinating leaderboard rewards with content re',
    `seasonal_event_id` BIGINT COMMENT 'Reference to the live event this leaderboard is associated with (null for non-event leaderboards).',
    `title_season_id` BIGINT COMMENT 'Reference to the game season this leaderboard is associated with (null for non-seasonal leaderboards).',
    `parent_leaderboard_id` BIGINT COMMENT 'Self-referencing FK on leaderboard (parent_leaderboard_id)',
    `anti_cheat_enabled` BOOLEAN COMMENT 'Indicates whether anti-cheat validation is applied to leaderboard submissions.',
    `api_endpoint` STRING COMMENT 'API endpoint URL for retrieving leaderboard data programmatically.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the leaderboard record was first created in the system.',
    `display_order` STRING COMMENT 'Sort order for displaying this leaderboard in the game UI when multiple leaderboards are available.',
    `display_percentile` BOOLEAN COMMENT 'Indicates whether player percentile ranking is displayed (e.g., top 5 percent).',
    `display_player_count` BOOLEAN COMMENT 'Indicates whether the total number of ranked players is displayed on the leaderboard UI.',
    `eligibility_criteria` STRING COMMENT 'Business rules defining which players are eligible to appear on this leaderboard (e.g., minimum level, account age, region, platform).',
    `end_date` DATE COMMENT 'Date when the leaderboard closes and stops accepting new submissions (null for permanent leaderboards).',
    `is_featured` BOOLEAN COMMENT 'Indicates whether this leaderboard is featured prominently in the game UI.',
    `last_reset_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent leaderboard reset.',
    `leaderboard_code` STRING COMMENT 'Unique business identifier code for the leaderboard used in APIs and system integrations.',
    `leaderboard_description` STRING COMMENT 'Detailed description of the leaderboard purpose, rules, and objectives displayed to players.',
    `leaderboard_name` STRING COMMENT 'Human-readable name of the leaderboard displayed to players.',
    `leaderboard_status` STRING COMMENT 'Current lifecycle status of the leaderboard.. Valid values are `active|inactive|archived|scheduled`',
    `leaderboard_type` STRING COMMENT 'Classification of the leaderboard scope (global, regional, friends-only, guild-based, seasonal, or event-specific).. Valid values are `global|regional|friends|guild|seasonal|event`',
    `manual_review_required` BOOLEAN COMMENT 'Indicates whether top scores require manual review before being posted to the leaderboard.',
    `max_rank_displayed` STRING COMMENT 'Maximum number of top-ranked players displayed on the leaderboard UI (e.g., top 100, top 1000).',
    `min_matches_played` STRING COMMENT 'Minimum number of matches a player must complete to qualify for ranking (null if no minimum).',
    `min_player_level` STRING COMMENT 'Minimum player level required to participate in this leaderboard (null if no minimum).',
    `next_reset_timestamp` TIMESTAMP COMMENT 'Scheduled timestamp for the next leaderboard reset.',
    `platform_scope` STRING COMMENT 'Platforms included in this leaderboard (all, console, PC, mobile, or specific platform codes).',
    `ranking_algorithm` STRING COMMENT 'Algorithm used to calculate player rankings (Elo, Glicko, TrueSkill, raw points, fastest time, highest score).. Valid values are `elo|glicko|trueskill|points|time|score`',
    `ranking_metric` STRING COMMENT 'The primary metric used for ranking (e.g., total kills, win rate, completion time, score, rating points).',
    `region_scope` STRING COMMENT 'Geographic regions included in this leaderboard (global, or specific region codes).',
    `reset_cadence` STRING COMMENT 'Frequency at which the leaderboard rankings are reset (never, daily, weekly, monthly, per season, or per event).. Valid values are `never|daily|weekly|monthly|seasonal|event`',
    `reset_day_of_week` STRING COMMENT 'Day of the week when weekly leaderboards reset (null for non-weekly cadences). [ENUM-REF-CANDIDATE: monday|tuesday|wednesday|thursday|friday|saturday|sunday — 7 candidates stripped; promote to reference product]',
    `reset_time_utc` STRING COMMENT 'Time of day in UTC when the leaderboard resets (HH:mm format).',
    `reward_distribution_flag` BOOLEAN COMMENT 'Indicates whether rewards are distributed to top-ranked players (true) or if the leaderboard is purely for prestige (false).',
    `reward_tier_count` STRING COMMENT 'Number of reward tiers defined for this leaderboard (e.g., top 10, top 100, top 1000).',
    `sort_order` STRING COMMENT 'Direction of ranking sort (ascending for time-based, descending for score-based).. Valid values are `ascending|descending`',
    `start_date` DATE COMMENT 'Date when the leaderboard becomes active and begins accepting submissions.',
    `tie_break_rule` STRING COMMENT 'Business rule for resolving ties in rankings (e.g., earliest submission time, secondary metric, shared rank).',
    `updated_by` STRING COMMENT 'User or system identifier that last modified the leaderboard record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the leaderboard record was last modified.',
    `created_by` STRING COMMENT 'User or system identifier that created the leaderboard record.',
    CONSTRAINT pk_leaderboard PRIMARY KEY(`leaderboard_id`)
) COMMENT 'Master definition of competitive leaderboards per game title and game mode, capturing ranking algorithm, reset cadence, eligibility criteria, and reward tiers.';

CREATE OR REPLACE TABLE `gaming_ecm`.`title`.`leaderboard_entry` (
    `leaderboard_entry_id` BIGINT COMMENT 'Unique identifier for this leaderboard entry. Primary key.',
    `leaderboard_id` BIGINT COMMENT 'Foreign key linking to the leaderboard on which this entry appears',
    `player_account_id` BIGINT COMMENT 'Foreign key linking to the player account who achieved this leaderboard entry',
    `title_season_id` BIGINT COMMENT 'Reference to the game season during which this leaderboard entry was achieved. Null for non-seasonal leaderboards. Critical for seasonal rewards and historical competitive tracking.',
    `entry_status` STRING COMMENT 'Current lifecycle status of this leaderboard entry. Active entries are displayed on the leaderboard. Under_review entries are pending anti-cheat validation. Disqualified entries are removed due to cheating. Expired entries are from past seasons/resets.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this leaderboard entry was last updated (rank change, score improvement, status change). Used for change tracking and real-time leaderboard updates.',
    `percentile` DECIMAL(18,2) COMMENT 'The players percentile ranking on this leaderboard (e.g., 95.5 means top 4.5%). Calculated based on total ranked players. Used for player feedback and competitive context.',
    `platform_code` STRING COMMENT 'The platform on which the player achieved this score (console, PC, mobile, or specific platform). Used for platform-specific leaderboards and cross-platform competitive analysis.',
    `rank_position` STRING COMMENT 'The players current rank position on this leaderboard (1 = top rank). Changes as other players submit scores. Used for rewards distribution and competitive display.',
    `rank_tier` STRING COMMENT 'The competitive tier or bracket the player belongs to based on their rank position (e.g., top 10 = grandmaster, top 100 = master). Used for rewards distribution and player recognition.',
    `reward_claimed_flag` BOOLEAN COMMENT 'Indicates whether the player has claimed their reward for this leaderboard placement. Used for rewards distribution workflows and preventing duplicate claims.',
    `score_value` DECIMAL(18,2) COMMENT 'The players score or metric value that determines their rank on this leaderboard. Could be kills, win rate, completion time, points, etc., depending on the leaderboards ranking_metric.',
    `submission_count` STRING COMMENT 'Number of times the player has submitted a score to this leaderboard. Used to enforce min_matches_played eligibility criteria and track player engagement.',
    `timestamp_achieved` TIMESTAMP COMMENT 'Date and time when the player achieved this score or rank. Used for tie-breaking, historical tracking, and determining eligibility for time-bound rewards.',
    CONSTRAINT pk_leaderboard_entry PRIMARY KEY(`leaderboard_entry_id`)
) COMMENT 'This association product represents the competitive ranking entry between a player account and a leaderboard. It captures each players participation and performance on a specific leaderboard, including their rank position, score achieved, timestamp of achievement, season context, platform, rank tier, and percentile. Each record links one player_account to one leaderboard with attributes that exist only in the context of this competitive participation. This is the operational record used for rewards distribution, competitive matchmaking, player recognition, and leaderboard display.. Existence Justification: In gaming platforms, players compete on multiple leaderboards simultaneously (global, seasonal, mode-specific, regional, event-based), and each leaderboard ranks thousands to millions of players. The business actively manages leaderboard entries as operational records with lifecycle states (active, under review, disqualified, expired), tracks rank changes in real-time, enforces eligibility criteria, distributes rewards based on rank tiers, and uses entries for competitive matchmaking. Leaderboard entries are not derived analytics—they are operational business entities that players and game systems create, update, and query continuously.';

CREATE OR REPLACE TABLE `gaming_ecm`.`title`.`sku_deployment` (
    `sku_deployment_id` BIGINT COMMENT 'Unique identifier for this deployment record. Primary key.',
    `build_artifact_id` BIGINT COMMENT 'Foreign key linking to the build artifact being deployed',
    `employee_id` BIGINT COMMENT 'Reference to the user or system account that initiated this deployment. Critical for audit trail and accountability.',
    `title_sku_id` BIGINT COMMENT 'Foreign key linking to the SKU receiving the deployment',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when this deployment was approved by release management. Part of the deployment workflow and governance process.',
    `certification_status` STRING COMMENT 'Platform certification status for this specific build-SKU deployment. Explicitly identified in detection phase relationship data. Different from build-level certification as each SKU may require separate platform approval.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this deployment record was created in the system.',
    `deployment_date` TIMESTAMP COMMENT 'The date and time when this build artifact was deployed to this SKU. Explicitly identified in detection phase relationship data.',
    `deployment_notes` STRING COMMENT 'Internal notes about this specific deployment, including special considerations, dependencies, or operational context.',
    `deployment_status` STRING COMMENT 'Current lifecycle status of this deployment. Explicitly identified in detection phase relationship data. Tracks whether the deployment is planned, active, rolled back, or deprecated.',
    `deployment_type` STRING COMMENT 'Classification of the deployment strategy used for this build-SKU combination. Determines rollout approach and risk management.',
    `is_active_build` BOOLEAN COMMENT 'Indicates whether this is the currently active build for this SKU. Explicitly identified in detection phase relationship data. Only one deployment per SKU should have this flag set to true at any time.',
    `phased_rollout_percentage` DECIMAL(18,2) COMMENT 'The percentage of users receiving this build in a phased rollout strategy. Explicitly identified in detection phase relationship data. Ranges from 0.00 to 100.00, enabling gradual deployment to mitigate risk.',
    `rollback_flag` BOOLEAN COMMENT 'Indicates whether this deployment was rolled back due to issues. Explicitly identified in detection phase relationship data. Critical for incident tracking and deployment history.',
    `rollback_reason` STRING COMMENT 'Explanation for why this deployment was rolled back. Critical for post-mortem analysis and process improvement.',
    `rollback_timestamp` TIMESTAMP COMMENT 'Date and time when this deployment was rolled back, if applicable. Null if deployment was never rolled back.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this deployment record was last modified.',
    CONSTRAINT pk_sku_deployment PRIMARY KEY(`sku_deployment_id`)
) COMMENT 'This association product represents the deployment event between build_artifact and sku. It captures the operational process of deploying a specific build artifact to a specific SKU, including certification, rollout strategy, and lifecycle management. Each record links one build_artifact to one sku with attributes that exist only in the context of this deployment relationship. This is the authoritative record of what build is live on which SKU at any point in time.. Existence Justification: In game publishing operations, a single build artifact can be deployed to multiple SKUs (e.g., the same build deployed to PS5 Standard Edition, PS5 Deluxe Edition, and Xbox Series X Standard Edition), and a single SKU receives multiple build artifacts over its lifecycle (patches, hotfixes, content updates). Release engineering teams actively manage each deployment as a distinct operational event with its own certification workflow, phased rollout strategy, approval process, and potential rollback. This is not a reference lookup—it is a managed business process.';

CREATE OR REPLACE TABLE `gaming_ecm`.`title`.`title_cert_submission` (
    `title_cert_submission_id` BIGINT COMMENT 'Primary key for title_cert_submission',
    `build_artifact_id` BIGINT COMMENT 'Foreign key linking to title.build_artifact. Business justification: title_cert_submission has build_version (STRING) but no build_artifact_id FK. Certification submissions are for specific build artifacts. New FK needed. Remove build_version as it becomes redundant - ',
    `platform_cert_submission_id` BIGINT COMMENT 'Unique identifier for this certification submission record. Primary key.',
    `certification_checklist_id` BIGINT COMMENT 'Foreign key linking to the specific certification checklist version being certified against',
    `game_title_id` BIGINT COMMENT 'Foreign key linking to the game title being submitted for certification',
    `assigned_qa_lead` STRING COMMENT 'The QA lead or certification specialist assigned to manage this submission and coordinate with the platform holder.',
    `certification_date` DATE COMMENT 'The date on which the platform holder granted certification approval for this game title against this checklist version. Null if not yet certified.',
    `compliance_status` STRING COMMENT 'Current status of this game titles compliance with this specific certification checklist. Tracks the submission through its lifecycle from initial assessment to final certification outcome.',
    `estimated_completion_date` DATE COMMENT 'The estimated date by which certification is expected to be completed, based on platform holder review duration and remediation timelines.',
    `failure_categories` STRING COMMENT 'Comma-separated list of requirement categories in which this submission failed (e.g., audio, network, accessibility). Used to track remediation focus areas.',
    `notes` STRING COMMENT 'Free-text notes capturing submission-specific context, waiver justifications, platform holder feedback, and remediation plans.',
    `platform_holder_ticket_reference` STRING COMMENT 'The ticket or case ID assigned by the platform holders certification portal for tracking this submission.',
    `resubmission_count` STRING COMMENT 'The number of times this game title has been resubmitted for certification against this checklist version after initial failure. Tracks remediation cycles.',
    `submission_date` DATE COMMENT 'The date on which the game build was officially submitted to the platform holder for certification review against this checklist version.',
    `waiver_count` STRING COMMENT 'The number of certification requirements for which waivers or exceptions were granted by the platform holder for this specific submission.',
    CONSTRAINT pk_title_cert_submission PRIMARY KEY(`title_cert_submission_id`)
) COMMENT 'This association product represents the submission and certification process between a game title and a platform certification checklist. It captures the operational workflow of submitting a game build for platform certification, tracking compliance status, waivers, failures, and resubmissions. Each record links one game title to one certification checklist version with attributes that exist only in the context of this specific certification attempt.. Existence Justification: In gaming operations, a single game title must be certified against multiple platform certification checklists (Sony TRC, Microsoft XR, Nintendo lotcheck, each with versioned requirements), and each checklist applies to many game titles across the publishers portfolio. The certification submission process is an operational business entity that teams actively manage, tracking compliance status, submission dates, waivers granted, failure remediation, and resubmission cycles for each title-checklist combination.';

CREATE OR REPLACE TABLE `gaming_ecm`.`title`.`ip_usage` (
    `ip_usage_id` BIGINT COMMENT 'Primary key uniquely identifying each title-IP usage relationship record',
    `game_title_id` BIGINT COMMENT 'Foreign key linking to the game title that uses the licensed IP asset',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to the licensed IP asset being used in the game title',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this usage relationship record was created in the system',
    `effective_date` DATE COMMENT 'The date when this specific IP usage license became effective for this game title. Critical for royalty calculation and compliance tracking.',
    `expiry_date` DATE COMMENT 'The date when this specific IP usage license expires for this game title. Null indicates perpetual license. Essential for lifecycle management and renewal tracking.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this usage relationship record was last updated',
    `minimum_guarantee_paid` DECIMAL(18,2) COMMENT 'The minimum guarantee amount (in USD) paid specifically for this title-IP usage. Null if no MG applies or if using standard MG from licensed_ip.',
    `revenue_attributed` DECIMAL(18,2) COMMENT 'The cumulative revenue (in USD) attributed to this specific IP usage within this game title. Used for royalty calculation and IP ROI analysis. This is relationship-specific because revenue attribution varies by title-IP combination.',
    `royalty_rate` DECIMAL(18,2) COMMENT 'The royalty rate (as decimal) negotiated specifically for this title-IP combination. May differ from the standard_royalty_rate in licensed_ip due to title-specific negotiations, volume discounts, or strategic partnerships.',
    `territory_override` STRING COMMENT 'Comma-separated list of territories where this specific title-IP usage has different terms than the base licensed_ip territory_restrictions. Null if no override applies.',
    `usage_count` BIGINT COMMENT 'Quantitative measure of IP usage intensity (e.g., number of API calls for engine SDK, number of music tracks used, number of character assets). Used for usage-based licensing models.',
    `usage_scope` STRING COMMENT 'Defines the scope of IP usage within the game title (e.g., full game, DLC only, specific platform, specific territory, limited feature). This attribute exists because the same IP may be licensed differently for different parts of the same game.',
    `usage_status` STRING COMMENT 'Current operational status of this IP usage relationship. Tracks lifecycle state for compliance and operational management.',
    CONSTRAINT pk_ip_usage PRIMARY KEY(`ip_usage_id`)
) COMMENT 'This association product represents the licensing usage relationship between game titles and licensed intellectual property assets. It captures the operational reality that a single game title incorporates multiple licensed IP components (game engine, middleware, music, art assets, brands) and each licensed IP asset is used across multiple game titles. Each record links one game title to one licensed IP with attributes that exist only in the context of this specific usage relationship, including usage scope, licensing duration, title-specific royalty terms, and revenue attribution.. Existence Justification: In the gaming industry, a single game title routinely incorporates multiple licensed IP assets simultaneously (game engine like Unreal, physics middleware like Havok, music libraries, brand licenses, art assets). Conversely, a single licensed IP asset (e.g., Unreal Engine, a music composition library) is used across dozens or hundreds of different game titles. The business actively manages these usage relationships with title-specific licensing terms, royalty rates, usage scopes, and revenue attribution tracking.';

CREATE OR REPLACE TABLE `gaming_ecm`.`title`.`studio_contribution` (
    `studio_contribution_id` BIGINT COMMENT 'Unique surrogate identifier for this title-studio contribution relationship. Primary key.',
    `game_studio_id` BIGINT COMMENT 'Foreign key linking to the game studio providing development contribution',
    `game_title_id` BIGINT COMMENT 'Foreign key linking to the game title receiving studio contribution',
    `budget_allocated_usd` DECIMAL(18,2) COMMENT 'Total budget allocated in US dollars for this studios work on this title. Used for financial planning and cost tracking. Sourced from financial planning system.',
    `contract_type` STRING COMMENT 'Financial arrangement type for this studios work on this title. Fixed Fee indicates predetermined payment; Revenue Share indicates performance-based payment; Hybrid combines both; Internal Transfer indicates internal studio with transfer pricing.',
    `contribution_percentage` DECIMAL(18,2) COMMENT 'Estimated percentage of total development effort contributed by this studio to this title. Used for resource allocation planning, budget distribution, and credit attribution. Sum across all studios for a title may exceed 100% for overlapping work. Sourced from project planning and financial systems.',
    `contribution_status` STRING COMMENT 'Current lifecycle status of this studios contribution to this title. Planned indicates future engagement; Active indicates ongoing work; On Hold indicates temporarily paused; Completed indicates work finished; Cancelled indicates engagement terminated before completion.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this contribution record was created in the data platform.',
    `development_role` STRING COMMENT 'The specific role this studio plays in the development of this title. Lead Developer owns primary development; Co-Developer shares core development; Art Outsourcing provides art assets; QA Support provides testing; Port Studio handles platform ports; Live Ops Support manages post-launch operations; DLC Developer creates downloadable content; Technical Support provides engineering assistance. Sourced from project management system and contract agreements.',
    `end_date` DATE COMMENT 'Date on which this studio completed or is planned to complete development work on this title. May be actual (for completed work) or planned (for ongoing work). Null indicates ongoing indefinite engagement (common for live ops support).',
    `ip_rights_share` STRING COMMENT 'Intellectual property ownership arrangement for this studios contribution to this title. None indicates work-for-hire with no IP retention; Shared indicates co-ownership arrangement; Full indicates studio retains full IP (rare, typically only for licensed IP); Negotiated indicates custom arrangement defined in contract. Critical for legal and financial reporting.',
    `primary_deliverable` STRING COMMENT 'Description of the primary deliverable or scope of work for this studio on this title. Examples: Character models and animations, PlayStation 5 port, Season 3 content pack, Multiplayer backend services. Provides human-readable context for the contribution.',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of net game revenue payable to this studio for this title under the contractual agreement. Zero for fixed-fee arrangements. Used for royalty calculation and financial forecasting. Sourced from contract management system.',
    `start_date` DATE COMMENT 'Date on which this studio began active development work on this title. Marks the commencement of the contractual engagement or internal assignment. Used for timeline tracking and resource planning.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this contribution record was last updated in the data platform.',
    CONSTRAINT pk_studio_contribution PRIMARY KEY(`studio_contribution_id`)
) COMMENT 'This association product represents the development contribution relationship between game titles and game studios. It captures the multi-studio collaboration model common in modern game development, where a single title involves lead development, co-development, outsourcing, porting, and support studios. Each record links one game title to one studio with attributes that define the studios specific role, contribution scope, timeline, and financial arrangements for that title.. Existence Justification: In modern game development, a single title routinely involves multiple studios in different capacities: a lead developer, art outsourcing partners, QA studios, port studios for different platforms, and live operations support teams. Simultaneously, each studio works on multiple titles across its portfolio. The business actively manages these studio-title relationships as distinct operational entities, tracking each studios specific role, contribution scope, timeline, deliverables, and financial arrangements per title.';

CREATE OR REPLACE TABLE `gaming_ecm`.`title`.`edition_content_bundle` (
    `edition_content_bundle_id` BIGINT COMMENT 'Unique identifier for this edition-DLC bundle inclusion record. Primary key.',
    `dlc_bundle_id` BIGINT COMMENT 'Foreign key linking to the DLC bundle included in this edition',
    `game_edition_id` BIGINT COMMENT 'Foreign key linking to the game edition that includes this DLC bundle',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this edition-DLC bundle association record was created in the system.',
    `display_order` STRING COMMENT 'Numeric sort order for displaying this DLC bundle in the editions content list on storefronts, product pages, and in-game menus. Lower numbers appear first.',
    `edition_content_bundle_status` STRING COMMENT 'Current status of this DLC bundles inclusion in this edition (active, planned, deprecated, removed). Tracks the lifecycle of the bundling relationship independently from the edition or DLC lifecycle.',
    `inclusion_date` DATE COMMENT 'The date when this DLC bundle was added to this editions content offering. Tracks when the bundling relationship was established, important for edition updates and content roadmap management.',
    `is_default_unlocked` BOOLEAN COMMENT 'Indicates whether this DLC bundle is automatically unlocked and available to the player upon edition purchase, or requires additional action to claim or unlock.',
    `is_pre_order_exclusive` BOOLEAN COMMENT 'Indicates whether this specific DLC bundle inclusion is exclusive to pre-order purchases of this edition. Tracks pre-order incentive bundling at the edition-DLC level.',
    `unlock_method` STRING COMMENT 'The mechanism by which the player gains access to this DLC bundle within this edition (e.g., automatic, manual_claim, code_redemption, time_gated, achievement_unlock). Defines the entitlement delivery method.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this edition-DLC bundle association record was last modified.',
    CONSTRAINT pk_edition_content_bundle PRIMARY KEY(`edition_content_bundle_id`)
) COMMENT 'This association product represents the bundling relationship between game editions and DLC bundles. It captures which DLC content bundles are included with each edition tier, how they are unlocked, and their presentation order in storefronts and entitlement systems. Each record links one game edition to one DLC bundle with attributes that exist only in the context of this inclusion relationship.. Existence Justification: In gaming publishing, edition tiers are designed by marketing and product teams who select which DLC bundles to include in each edition (Standard, Deluxe, Ultimate, etc.). A single edition includes multiple DLC bundles (e.g., Ultimate Edition includes Season Pass + Cosmetic Pack + Soundtrack), and a single DLC bundle can be included in multiple editions (e.g., Cosmetic Pack appears in both Deluxe and Ultimate). This is an actively managed business relationship with its own attributes governing how content is unlocked, displayed, and entitled.';

CREATE OR REPLACE TABLE `gaming_ecm`.`title`.`mode_map_availability` (
    `mode_map_availability_id` BIGINT COMMENT 'Unique identifier for this mode-map availability configuration record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the live ops team member or system process that last modified this configuration.',
    `game_mode_id` BIGINT COMMENT 'Foreign key linking to the game mode participating in this mode-map pairing',
    `level_map_id` BIGINT COMMENT 'Foreign key linking to the level map available for this game mode',
    `availability_end_date` TIMESTAMP COMMENT 'Timestamp when this mode-map pairing is removed from matchmaking availability. Null indicates indefinite availability. Supports limited-time events and content rotation.',
    `availability_start_date` TIMESTAMP COMMENT 'Timestamp when this mode-map pairing becomes available for matchmaking. Supports time-gated content releases and seasonal availability windows.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this mode-map pairing configuration was first created in the system.',
    `is_featured` BOOLEAN COMMENT 'Indicates whether this mode-map pairing is currently featured in the UI, promotional materials, or priority matchmaking queues. Managed by live ops for content promotion.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this mode-map pairing configuration.',
    `mode_map_availability_status` STRING COMMENT 'Current operational status of this mode-map pairing: active (live in matchmaking), disabled (temporarily removed), testing (QA/beta testing only), deprecated (scheduled for removal).',
    `playlist_weight` DECIMAL(18,2) COMMENT 'Relative probability weight for this map to be selected within the modes matchmaking pool. Higher weights increase selection frequency. Used to balance map variety and player preferences.',
    `rotation_order` STRING COMMENT 'Sequence position of this map within the modes playlist rotation schedule. Used by matchmaking systems to determine map selection order in automated rotation.',
    CONSTRAINT pk_mode_map_availability PRIMARY KEY(`mode_map_availability_id`)
) COMMENT 'This association product represents the operational configuration between game modes and level maps in the live game environment. It captures playlist rotation scheduling, featured content promotion, and availability windows managed by live operations teams. Each record links one game mode to one level map with rotation metadata, featured status, and time-bound availability that exists only in the context of this pairing for matchmaking and content delivery.. Existence Justification: In gaming operations, game modes are played on multiple maps (Team Deathmatch can be played on Crimson Fortress, Desert Outpost, Urban Ruins, etc.), and maps support multiple game modes (Crimson Fortress supports Team Deathmatch, Capture the Flag, Domination, etc.). Live operations teams actively manage these mode-map pairings through playlist configuration, rotating maps in and out of availability, featuring specific pairings for promotional events, and adjusting selection weights based on player engagement metrics and seasonal content strategies.';

CREATE OR REPLACE TABLE `gaming_ecm`.`title`.`title_campaign` (
    `title_campaign_id` BIGINT COMMENT 'Primary key for title_campaign',
    `marketing_campaign_id` BIGINT COMMENT 'Unique identifier for this influencer marketing campaign engagement. Primary key for the association.',
    `game_title_id` BIGINT COMMENT 'Foreign key linking to the game title being promoted in this influencer marketing campaign',
    `influencer_id` BIGINT COMMENT 'Foreign key linking to the influencer or content creator engaged in this marketing campaign',
    `title_season_id` BIGINT COMMENT 'Foreign key linking to title.title_season. Business justification: title_campaign does not have title_season_id in visible schema. Business case: marketing campaigns for GaaS titles are often season-specific (e.g., Season 3 Launch Campaign). New FK needed to link c',
    `activation_date` DATE COMMENT 'The date when the influencer campaign was activated and content creation/publishing began. Explicitly identified in detection phase relationship data.',
    `budget` DECIMAL(18,2) COMMENT 'The budget allocated for this specific title-influencer campaign, which may differ from the influencers standard rate card based on campaign scope and deliverables.',
    `campaign_status` STRING COMMENT 'Current operational status of the influencer campaign for this title-influencer pairing.',
    `content_approval_status` STRING COMMENT 'The approval status of content submitted by the influencer for this campaign, tracking the review and approval workflow.',
    `content_type` STRING COMMENT 'The type of promotional content the influencer is contracted to create for this campaign (e.g., live stream, YouTube video, TikTok short, Instagram post, full review, sponsored gameplay integration). Explicitly identified in detection phase relationship data.',
    `cpi` DECIMAL(18,2) COMMENT 'The actual Cost Per Install (CPI) achieved for this specific title-influencer campaign, calculated as campaign_budget divided by total_installs.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the campaign budget (e.g., USD, EUR, GBP).',
    `deliverables_count` STRING COMMENT 'The number of content pieces or posts the influencer is contracted to deliver as part of this campaign. Explicitly identified in detection phase relationship data.',
    `end_date` DATE COMMENT 'The planned or actual end date for this influencer campaign. Nullable for ongoing campaigns.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether this specific campaign includes exclusivity terms preventing the influencer from promoting competing titles during the campaign period. Campaign-specific exclusivity that may differ from the influencers general contract terms. Explicitly identified in detection phase relationship data.',
    `notes` STRING COMMENT 'Free-text notes about this specific campaign engagement, including special terms, creative direction, or performance observations.',
    `performance_tier` STRING COMMENT 'The performance classification of this specific campaign based on engagement metrics, conversion rates, and ROI. Used to evaluate campaign effectiveness and inform future influencer selection. Explicitly identified in detection phase relationship data.',
    `roas` DECIMAL(18,2) COMMENT 'The actual Return on Ad Spend (ROAS) achieved for this specific title-influencer campaign, measuring revenue generated relative to campaign budget.',
    `start_date` DATE COMMENT 'The planned or actual start date for this influencer campaign.',
    `total_clicks` BIGINT COMMENT 'The total number of clicks on campaign links (store links, affiliate codes) generated by this influencer for this title.',
    `total_installs` BIGINT COMMENT 'The total number of game installs or purchases attributed to this influencer campaign through tracking codes.',
    `total_views` BIGINT COMMENT 'The total number of views or impressions generated by this influencer for this specific game title campaign.',
    CONSTRAINT pk_title_campaign PRIMARY KEY(`title_campaign_id`)
) COMMENT 'This association product represents the marketing campaign engagement between a game title and an influencer. It captures the operational relationship where influencers are contracted to create and publish promotional content for specific game titles. Each record links one game title to one influencer with campaign-specific attributes including activation dates, content deliverables, exclusivity terms, and performance metrics that exist only in the context of this promotional relationship.. Existence Justification: In gaming influencer marketing operations, a single game title engages multiple influencers simultaneously across different platforms and audience segments (e.g., a AAA title launch might work with 50+ influencers ranging from mega streamers to niche content creators). Conversely, each influencer promotes multiple game titles over time and often concurrently (a variety streamer might have active campaigns for 3-5 different games in a given month). Marketing teams actively manage a portfolio of title-influencer campaign relationships, tracking activation dates, content deliverables, exclusivity terms, and performance metrics for each unique pairing.';

CREATE OR REPLACE TABLE `gaming_ecm`.`title`.`publishing_agreement` (
    `publishing_agreement_id` BIGINT COMMENT 'Unique identifier for this publishing agreement record. Primary key.',
    `game_title_id` BIGINT COMMENT 'Foreign key linking to the game title being published under this agreement',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to the legal entity that holds publishing rights under this agreement',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the publishing agreement. DRAFT indicates negotiation phase. ACTIVE means currently in force. SUSPENDED indicates temporary hold. EXPIRED means past expiry_date. TERMINATED indicates early termination.',
    `created_by_user` STRING COMMENT 'User identifier of the person who created this publishing agreement record.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this publishing agreement record was created in the system.',
    `effective_date` DATE COMMENT 'The date on which this publishing agreement becomes effective and the legal entity gains publishing rights for the specified territory. Used for revenue recognition cutoff and rights management.',
    `expiry_date` DATE COMMENT 'The date on which this publishing agreement expires or terminates. May be null for perpetual agreements. Used for rights management and contract renewal workflows.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this publishing agreement record was last modified.',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'The minimum guaranteed payment amount (if any) that the publishing entity commits to pay regardless of actual sales performance. Used for advance payments and financial forecasting. Null if no minimum guarantee exists.',
    `minimum_guarantee_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the minimum guarantee amount. Required if minimum_guarantee_amount is not null.',
    `publishing_rights_type` STRING COMMENT 'Classification of the publishing rights granted under this agreement. EXCLUSIVE means only this entity can publish in the territory. NON_EXCLUSIVE allows multiple publishers. CO_PUBLISHING indicates shared publishing responsibilities. DISTRIBUTION_ONLY limits rights to distribution without marketing. FULL_RIGHTS includes all publishing, marketing, and distribution rights.',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'The percentage of net revenue allocated to this legal entity under the publishing agreement. Critical for revenue recognition, transfer pricing, and royalty calculations. Varies by territory and entity relationship.',
    `territory_scope` STRING COMMENT 'Geographic territory or region covered by this publishing agreement. Can be specific country codes (ISO 3166-1 alpha-2/3), regional groupings (NA, EU, APAC, LATAM), or GLOBAL. Defines where this legal entity has publishing rights.',
    CONSTRAINT pk_publishing_agreement PRIMARY KEY(`publishing_agreement_id`)
) COMMENT 'This association product represents the contractual publishing arrangement between a game title and a legal entity. It captures territory-specific publishing rights, revenue sharing terms, and the temporal scope of the publishing relationship. Each record links one game title to one legal entity with attributes that define the commercial terms of the publishing agreement for specific territories.. Existence Justification: In the gaming industry, a single game title is routinely published by multiple legal entities across different territories with distinct commercial terms. For example, a AAA title may be published by the parent company in North America, a regional subsidiary in Europe, and a joint venture partner in Asia-Pacific, each with different revenue share percentages and rights types. Conversely, each legal entity (studio subsidiary, regional publisher, JV) publishes multiple game titles in their assigned territories. The business actively manages these publishing agreements as contractual arrangements with specific territory scopes, revenue splits, effective dates, and rights classifications.';

CREATE OR REPLACE TABLE `gaming_ecm`.`title`.`playable_character` (
    `playable_character_id` BIGINT COMMENT 'Primary key for playable_character',
    `game_title_id` BIGINT COMMENT 'Foreign key linking to title.game_title. Business justification: playable_character does not have game_title_id in visible schema. Characters belong to specific game titles - this is a fundamental parent-child relationship. New FK needed. No redundant columns visib',
    `title_season_id` BIGINT COMMENT 'Foreign key linking to title.title_season. Business justification: playable_character does not have title_season_id in visible schema. Business case: new characters are frequently released as seasonal content in GaaS titles (e.g., Season 2 introduces 3 new champions',
    `evolved_from_playable_character_id` BIGINT COMMENT 'Self-referencing FK on playable_character (evolved_from_playable_character_id)',
    `age_rating_restriction` STRING COMMENT 'Any specific age rating restrictions or content warnings associated with this characters design, dialogue, or abilities that may affect the games overall rating.',
    `base_attack_power` STRING COMMENT 'The starting attack damage value for the character at level 1 or base configuration.',
    `base_defense_rating` STRING COMMENT 'The starting defensive capability value for the character at level 1 or base configuration.',
    `base_health_points` STRING COMMENT 'The starting health points value for the character at level 1 or base configuration, used for game balance and design.',
    `base_speed_rating` STRING COMMENT 'The starting movement or action speed value for the character at level 1 or base configuration.',
    `character_class` STRING COMMENT 'The gameplay class or role of the character (e.g., warrior, mage, assassin, tank, support, marksman). Defines core gameplay mechanics and abilities.',
    `character_code` STRING COMMENT 'Internal unique alphanumeric code used to reference the character in game systems, configuration files, and APIs.',
    `character_description` STRING COMMENT 'A narrative description of the characters backstory, personality, and role in the game world, used for player engagement and marketing.',
    `character_icon_asset_path` STRING COMMENT 'The file system path or asset reference to the characters icon image used in UI, menus, and selection screens.',
    `character_model_asset_path` STRING COMMENT 'The file system path or asset reference to the 3D character model used in the game engine.',
    `character_name` STRING COMMENT 'The display name of the playable character as shown to players in-game and in marketing materials.',
    `character_type` STRING COMMENT 'Classification of the characters role archetype within the game narrative and mechanics.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this character record was first created in the system.',
    `difficulty_rating` STRING COMMENT 'The skill level required to effectively play this character, helping players choose appropriate characters for their skill level.',
    `faction_affiliation` STRING COMMENT 'The faction, team, or organization the character belongs to within the game lore and mechanics.',
    `gender` STRING COMMENT 'The gender identity or presentation of the character as defined in the game lore and character design.',
    `intellectual_property_owner` STRING COMMENT 'The legal entity that owns the intellectual property rights to this character, important for licensing, royalties, and legal compliance.',
    `is_esports_viable` BOOLEAN COMMENT 'Indicates whether this character is approved and balanced for competitive esports tournament play.',
    `is_limited_edition` BOOLEAN COMMENT 'Indicates whether this character was released as a limited-time offering and may no longer be available for unlock.',
    `is_premium_exclusive` BOOLEAN COMMENT 'Indicates whether this character is only available through premium purchase or subscription, not through free-to-play progression.',
    `is_starter_character` BOOLEAN COMMENT 'Indicates whether this character is available to all players from the beginning without requiring unlock.',
    `last_balance_update_date` DATE COMMENT 'The most recent date when this characters stats, abilities, or mechanics were adjusted for game balance purposes.',
    `licensing_status` STRING COMMENT 'The legal licensing arrangement for this characters intellectual property.',
    `lore_biography` STRING COMMENT 'Extended lore and backstory text for the character, providing deep narrative context for engaged players.',
    `max_level` STRING COMMENT 'The highest level or rank this character can achieve through player progression.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this character record was last modified in the system.',
    `popularity_score` DECIMAL(18,2) COMMENT 'A calculated score representing the characters popularity among players, based on pick rate, win rate, and community engagement metrics.',
    `primary_weapon_type` STRING COMMENT 'The default or signature weapon type used by this character (e.g., sword, bow, staff, gun, fists).',
    `rarity_tier` STRING COMMENT 'The rarity classification of the character, typically affecting unlock difficulty, monetization strategy, and player desirability.',
    `release_date` DATE COMMENT 'The date when this character was first made available to players in the live game environment.',
    `special_ability_description` STRING COMMENT 'Detailed description of what the characters special ability does, including mechanics and effects.',
    `special_ability_name` STRING COMMENT 'The name of the characters signature or ultimate special ability.',
    `species` STRING COMMENT 'The species, race, or creature type of the character (e.g., human, elf, orc, robot, alien) as defined in the game universe.',
    `playable_character_status` STRING COMMENT 'The current lifecycle status of the character in the games live environment.',
    `unlock_method` STRING COMMENT 'The primary method by which players can unlock or acquire this character.',
    `voice_actor_name` STRING COMMENT 'The name of the voice actor who provides the characters voice performance, used for credits and marketing.',
    CONSTRAINT pk_playable_character PRIMARY KEY(`playable_character_id`)
) COMMENT 'Master reference table for playable_character. Referenced by champion_character_id.';

CREATE OR REPLACE TABLE `gaming_ecm`.`title`.`checkpoint` (
    `checkpoint_id` BIGINT COMMENT 'Primary key for checkpoint',
    `achievement_id` BIGINT COMMENT 'Reference to the achievement or trophy unlocked by this checkpoint, if applicable.',
    `dlc_bundle_id` BIGINT COMMENT 'Foreign key linking to title.dlc_bundle. Business justification: checkpoint does not have dlc_bundle_id in visible schema. Business case: checkpoints can be part of DLC content (e.g., expansion campaign checkpoints). New FK needed. Nullable - base game checkpoints ',
    `game_title_id` BIGINT COMMENT 'Reference to the game title this checkpoint belongs to.',
    `level_map_id` BIGINT COMMENT 'Reference to the game level or stage where this checkpoint is located.',
    `mission_id` BIGINT COMMENT 'Reference to the mission or quest associated with this checkpoint, if applicable.',
    `title_season_id` BIGINT COMMENT 'Foreign key linking to title.title_season. Business justification: checkpoint does not have title_season_id in visible schema. Business case: checkpoints can be part of seasonal content in GaaS titles (e.g., seasonal story missions). New FK needed. Nullable - not all',
    `previous_checkpoint_id` BIGINT COMMENT 'Self-referencing FK on checkpoint (previous_checkpoint_id)',
    `achievement_linked` BOOLEAN COMMENT 'Indicates whether reaching this checkpoint unlocks or contributes to a game achievement or trophy.',
    `audio_cue_code` BIGINT COMMENT 'Reference to the audio asset played when the checkpoint is activated.',
    `average_completion_time_seconds` STRING COMMENT 'Average time in seconds players take to reach this checkpoint from the previous checkpoint or level start, based on telemetry data.',
    `build_version_deprecated` STRING COMMENT 'Game build version number when this checkpoint was deprecated or removed, if applicable.',
    `build_version_introduced` STRING COMMENT 'Game build version number when this checkpoint was first introduced.',
    `checkpoint_code` STRING COMMENT 'Unique business identifier code for the checkpoint, used for external reference and integration.',
    `checkpoint_name` STRING COMMENT 'Human-readable name of the checkpoint as displayed to players and developers.',
    `checkpoint_status` STRING COMMENT 'Current lifecycle status of the checkpoint in the game build.',
    `checkpoint_type` STRING COMMENT 'Classification of the checkpoint mechanism: manual (player-triggered), automatic (system-triggered), story (narrative milestone), mission (objective completion), level (stage transition), autosave (periodic system save), or quicksave (player quick-save).',
    `cooldown_seconds` STRING COMMENT 'Time in seconds before this checkpoint can be triggered again after initial activation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this checkpoint record was first created in the system.',
    `design_notes` STRING COMMENT 'Internal design and development notes about the checkpoint implementation, balancing, or player experience considerations.',
    `difficulty_level` STRING COMMENT 'Game difficulty setting at which this checkpoint is available or behaves differently.',
    `effective_end_date` DATE COMMENT 'Date when this checkpoint is no longer active or available in the game, if applicable.',
    `effective_start_date` DATE COMMENT 'Date when this checkpoint becomes active and available in the game.',
    `is_hidden` BOOLEAN COMMENT 'Indicates whether this checkpoint is hidden from the player (e.g., secret checkpoint, easter egg).',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this checkpoint must be reached to progress in the game (mandatory) or is optional.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the user who last modified this checkpoint record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this checkpoint record was last modified.',
    `localization_key` STRING COMMENT 'Localization key for translating checkpoint name and description across supported languages.',
    `narrative_description` STRING COMMENT 'Story or narrative context associated with this checkpoint for design and documentation purposes.',
    `platform_availability` STRING COMMENT 'Comma-separated list of gaming platforms where this checkpoint is available (e.g., PC, PS5, Xbox Series X, Switch, Mobile).',
    `player_reach_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of players who reach this checkpoint out of those who started the level or mission, based on telemetry data.',
    `respawn_coordinates_x` DECIMAL(18,2) COMMENT 'X-axis coordinate where the player respawns when using this checkpoint.',
    `respawn_coordinates_y` DECIMAL(18,2) COMMENT 'Y-axis coordinate where the player respawns when using this checkpoint.',
    `respawn_coordinates_z` DECIMAL(18,2) COMMENT 'Z-axis coordinate where the player respawns when using this checkpoint.',
    `respawn_enabled` BOOLEAN COMMENT 'Indicates whether players can respawn at this checkpoint after death or failure.',
    `save_state_included` BOOLEAN COMMENT 'Indicates whether this checkpoint triggers a full game state save (inventory, progress, stats).',
    `sequence_number` STRING COMMENT 'Ordinal position of this checkpoint within the level or mission progression sequence.',
    `telemetry_enabled` BOOLEAN COMMENT 'Indicates whether player interaction with this checkpoint is tracked for analytics and telemetry.',
    `trigger_condition` STRING COMMENT 'Game logic condition or event that activates this checkpoint (e.g., player proximity, objective completion, time elapsed).',
    `visual_indicator_type` STRING COMMENT 'Type of visual marker or indicator used to represent this checkpoint in the game world.',
    `world_coordinates_x` DECIMAL(18,2) COMMENT 'X-axis coordinate of the checkpoint location in the game world coordinate system.',
    `world_coordinates_y` DECIMAL(18,2) COMMENT 'Y-axis coordinate of the checkpoint location in the game world coordinate system.',
    `world_coordinates_z` DECIMAL(18,2) COMMENT 'Z-axis coordinate of the checkpoint location in the game world coordinate system.',
    `created_by` STRING COMMENT 'Username or identifier of the game designer or developer who created this checkpoint record.',
    CONSTRAINT pk_checkpoint PRIMARY KEY(`checkpoint_id`)
) COMMENT 'Master reference table for checkpoint. Referenced by last_checkpoint_id.';

CREATE OR REPLACE TABLE `gaming_ecm`.`title`.`mission` (
    `mission_id` BIGINT COMMENT 'Primary key for mission',
    `prerequisite_mission_id` BIGINT COMMENT 'Self-referencing FK on mission (prerequisite_mission_id)',
    `asset_bundle_id` STRING COMMENT 'Reference to the game engine asset bundle or content package containing the missions 3D models, textures, audio, and scripts.',
    `chapter_number` STRING COMMENT 'The chapter or act number within the games narrative structure where this mission appears. Used for story sequencing.',
    `completion_rate_target` DECIMAL(18,2) COMMENT 'Target percentage of players expected to successfully complete this mission, used for difficulty tuning and design validation.',
    `content_rating` STRING COMMENT 'Entertainment Software Rating Board (ESRB) content rating for this specific mission if it differs from the titles overall rating.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this mission record was first created in the content management system.',
    `deprecation_date` DATE COMMENT 'Date when this mission was or will be removed from active gameplay. Applicable for seasonal or time-limited content.',
    `difficulty_level` STRING COMMENT 'The intended challenge level of the mission, used for player matchmaking and progression balancing.',
    `estimated_duration_minutes` STRING COMMENT 'Expected time in minutes for an average player to complete the mission. Used for session planning and analytics.',
    `failure_condition` STRING COMMENT 'Conditions under which the mission is considered failed (e.g., time limit exceeded, objective target destroyed, player death).',
    `genre_tags` STRING COMMENT 'Comma-separated list of gameplay genre tags associated with this mission (e.g., stealth, combat, puzzle, exploration) for content filtering and recommendation.',
    `is_multiplayer` BOOLEAN COMMENT 'Indicates whether this mission supports or requires multiplayer participation.',
    `is_optional` BOOLEAN COMMENT 'Indicates whether this mission is required for main story progression or is optional side content.',
    `is_repeatable` BOOLEAN COMMENT 'Indicates whether players can replay this mission multiple times for rewards or progression.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the content designer or system user who last modified this mission record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this mission record was last updated in the content management system.',
    `localization_key` STRING COMMENT 'Unique key used to retrieve localized mission text (name, description, objectives) from the games localization system.',
    `location_name` STRING COMMENT 'The in-game geographic location, map, or environment where the mission takes place.',
    `maximum_players` STRING COMMENT 'Maximum number of players who can participate in this mission simultaneously. Defines multiplayer capacity.',
    `minimum_player_level` STRING COMMENT 'The minimum character or account level required to unlock and access this mission.',
    `minimum_players` STRING COMMENT 'Minimum number of players required to start this mission. Relevant for cooperative or team-based content.',
    `mission_code` STRING COMMENT 'Unique alphanumeric code identifying the mission within the game title. Used for internal tracking and content management systems.',
    `mission_description` STRING COMMENT 'Detailed narrative description of the mission objectives, storyline, and context provided to players.',
    `mission_name` STRING COMMENT 'The display name of the mission as shown to players in-game.',
    `mission_status` STRING COMMENT 'Current lifecycle state of the mission in the content pipeline: concept (design phase), development (in production), testing (QA), active (live in game), deprecated (scheduled for removal), removed (no longer available).',
    `mission_type` STRING COMMENT 'Classification of the mission based on its role in the game structure: story (main campaign), side (optional content), challenge (skill-based), tutorial (onboarding), bonus (special event), or daily (recurring).',
    `objective_summary` STRING COMMENT 'Brief summary of the primary mission objectives and win conditions.',
    `platform_availability` STRING COMMENT 'Comma-separated list of gaming platforms where this mission is available (e.g., PC, PlayStation, Xbox, Nintendo Switch, Mobile). Used for platform-specific content management.',
    `release_date` DATE COMMENT 'Date when this mission was first made available to players. May differ from title release date for DLC or live-service content.',
    `reward_currency_amount` DECIMAL(18,2) COMMENT 'Amount of in-game currency awarded upon mission completion.',
    `reward_currency_type` STRING COMMENT 'Type of in-game currency awarded as mission reward.',
    `reward_experience_points` STRING COMMENT 'Amount of experience points awarded to players upon successful mission completion.',
    `sequence_order` STRING COMMENT 'The sequential position of this mission within its chapter or mission group. Determines unlock order and progression flow.',
    `success_condition` STRING COMMENT 'Conditions that must be met for the mission to be considered successfully completed.',
    `telemetry_enabled` BOOLEAN COMMENT 'Indicates whether player behavior and performance telemetry is collected for this mission for analytics and balancing purposes.',
    `time_limit_seconds` STRING COMMENT 'Maximum time allowed in seconds to complete the mission. Null if no time limit applies.',
    `title_id` BIGINT COMMENT 'Reference to the game title this mission belongs to.',
    `unlock_condition` STRING COMMENT 'Business rule or prerequisite condition that must be met before this mission becomes available to players (e.g., complete previous mission, reach level threshold, own specific DLC).',
    `version_number` STRING COMMENT 'Semantic version number of the mission content (e.g., 1.2.3) tracking design iterations and balance updates.',
    `created_by` STRING COMMENT 'Username or identifier of the content designer or system user who created this mission record.',
    CONSTRAINT pk_mission PRIMARY KEY(`mission_id`)
) COMMENT 'Master reference table for mission. Referenced by mission_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `gaming_ecm`.`title`.`game_title` ADD CONSTRAINT `fk_title_game_title_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `gaming_ecm`.`title`.`franchise`(`franchise_id`);
ALTER TABLE `gaming_ecm`.`title`.`game_title` ADD CONSTRAINT `fk_title_game_title_genre_classification_id` FOREIGN KEY (`genre_classification_id`) REFERENCES `gaming_ecm`.`title`.`genre_classification`(`genre_classification_id`);
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ADD CONSTRAINT `fk_title_title_sku_game_edition_id` FOREIGN KEY (`game_edition_id`) REFERENCES `gaming_ecm`.`title`.`game_edition`(`game_edition_id`);
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ADD CONSTRAINT `fk_title_title_sku_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`title`.`game_edition` ADD CONSTRAINT `fk_title_game_edition_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ADD CONSTRAINT `fk_title_build_artifact_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`title`.`title_release` ADD CONSTRAINT `fk_title_title_release_build_artifact_id` FOREIGN KEY (`build_artifact_id`) REFERENCES `gaming_ecm`.`title`.`build_artifact`(`build_artifact_id`);
ALTER TABLE `gaming_ecm`.`title`.`title_release` ADD CONSTRAINT `fk_title_title_release_title_sku_id` FOREIGN KEY (`title_sku_id`) REFERENCES `gaming_ecm`.`title`.`title_sku`(`title_sku_id`);
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ADD CONSTRAINT `fk_title_dlc_bundle_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ADD CONSTRAINT `fk_title_dlc_bundle_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);
ALTER TABLE `gaming_ecm`.`title`.`content_rating` ADD CONSTRAINT `fk_title_content_rating_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`title`.`title_lifecycle_event` ADD CONSTRAINT `fk_title_title_lifecycle_event_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`title`.`title_lifecycle_event` ADD CONSTRAINT `fk_title_title_lifecycle_event_title_release_id` FOREIGN KEY (`title_release_id`) REFERENCES `gaming_ecm`.`title`.`title_release`(`title_release_id`);
ALTER TABLE `gaming_ecm`.`title`.`franchise` ADD CONSTRAINT `fk_title_franchise_genre_classification_id` FOREIGN KEY (`genre_classification_id`) REFERENCES `gaming_ecm`.`title`.`genre_classification`(`genre_classification_id`);
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ADD CONSTRAINT `fk_title_genre_classification_parent_genre_genre_classification_id` FOREIGN KEY (`parent_genre_genre_classification_id`) REFERENCES `gaming_ecm`.`title`.`genre_classification`(`genre_classification_id`);
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ADD CONSTRAINT `fk_title_localization_version_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ADD CONSTRAINT `fk_title_localization_version_title_sku_id` FOREIGN KEY (`title_sku_id`) REFERENCES `gaming_ecm`.`title`.`title_sku`(`title_sku_id`);
ALTER TABLE `gaming_ecm`.`title`.`title_season` ADD CONSTRAINT `fk_title_title_season_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`title`.`territory_rights` ADD CONSTRAINT `fk_title_territory_rights_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ADD CONSTRAINT `fk_title_game_mode_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ADD CONSTRAINT `fk_title_game_mode_parent_game_mode_id` FOREIGN KEY (`parent_game_mode_id`) REFERENCES `gaming_ecm`.`title`.`game_mode`(`game_mode_id`);
ALTER TABLE `gaming_ecm`.`title`.`achievement` ADD CONSTRAINT `fk_title_achievement_dlc_bundle_id` FOREIGN KEY (`dlc_bundle_id`) REFERENCES `gaming_ecm`.`title`.`dlc_bundle`(`dlc_bundle_id`);
ALTER TABLE `gaming_ecm`.`title`.`achievement` ADD CONSTRAINT `fk_title_achievement_game_mode_id` FOREIGN KEY (`game_mode_id`) REFERENCES `gaming_ecm`.`title`.`game_mode`(`game_mode_id`);
ALTER TABLE `gaming_ecm`.`title`.`achievement` ADD CONSTRAINT `fk_title_achievement_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`title`.`achievement` ADD CONSTRAINT `fk_title_achievement_prerequisite_achievement_id` FOREIGN KEY (`prerequisite_achievement_id`) REFERENCES `gaming_ecm`.`title`.`achievement`(`achievement_id`);
ALTER TABLE `gaming_ecm`.`title`.`achievement` ADD CONSTRAINT `fk_title_achievement_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ADD CONSTRAINT `fk_title_leaderboard_game_mode_id` FOREIGN KEY (`game_mode_id`) REFERENCES `gaming_ecm`.`title`.`game_mode`(`game_mode_id`);
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ADD CONSTRAINT `fk_title_leaderboard_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ADD CONSTRAINT `fk_title_leaderboard_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ADD CONSTRAINT `fk_title_leaderboard_parent_leaderboard_id` FOREIGN KEY (`parent_leaderboard_id`) REFERENCES `gaming_ecm`.`title`.`leaderboard`(`leaderboard_id`);
ALTER TABLE `gaming_ecm`.`title`.`leaderboard_entry` ADD CONSTRAINT `fk_title_leaderboard_entry_leaderboard_id` FOREIGN KEY (`leaderboard_id`) REFERENCES `gaming_ecm`.`title`.`leaderboard`(`leaderboard_id`);
ALTER TABLE `gaming_ecm`.`title`.`leaderboard_entry` ADD CONSTRAINT `fk_title_leaderboard_entry_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);
ALTER TABLE `gaming_ecm`.`title`.`sku_deployment` ADD CONSTRAINT `fk_title_sku_deployment_build_artifact_id` FOREIGN KEY (`build_artifact_id`) REFERENCES `gaming_ecm`.`title`.`build_artifact`(`build_artifact_id`);
ALTER TABLE `gaming_ecm`.`title`.`sku_deployment` ADD CONSTRAINT `fk_title_sku_deployment_title_sku_id` FOREIGN KEY (`title_sku_id`) REFERENCES `gaming_ecm`.`title`.`title_sku`(`title_sku_id`);
ALTER TABLE `gaming_ecm`.`title`.`title_cert_submission` ADD CONSTRAINT `fk_title_title_cert_submission_build_artifact_id` FOREIGN KEY (`build_artifact_id`) REFERENCES `gaming_ecm`.`title`.`build_artifact`(`build_artifact_id`);
ALTER TABLE `gaming_ecm`.`title`.`title_cert_submission` ADD CONSTRAINT `fk_title_title_cert_submission_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`title`.`ip_usage` ADD CONSTRAINT `fk_title_ip_usage_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`title`.`studio_contribution` ADD CONSTRAINT `fk_title_studio_contribution_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`title`.`edition_content_bundle` ADD CONSTRAINT `fk_title_edition_content_bundle_dlc_bundle_id` FOREIGN KEY (`dlc_bundle_id`) REFERENCES `gaming_ecm`.`title`.`dlc_bundle`(`dlc_bundle_id`);
ALTER TABLE `gaming_ecm`.`title`.`edition_content_bundle` ADD CONSTRAINT `fk_title_edition_content_bundle_game_edition_id` FOREIGN KEY (`game_edition_id`) REFERENCES `gaming_ecm`.`title`.`game_edition`(`game_edition_id`);
ALTER TABLE `gaming_ecm`.`title`.`mode_map_availability` ADD CONSTRAINT `fk_title_mode_map_availability_game_mode_id` FOREIGN KEY (`game_mode_id`) REFERENCES `gaming_ecm`.`title`.`game_mode`(`game_mode_id`);
ALTER TABLE `gaming_ecm`.`title`.`title_campaign` ADD CONSTRAINT `fk_title_title_campaign_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`title`.`title_campaign` ADD CONSTRAINT `fk_title_title_campaign_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);
ALTER TABLE `gaming_ecm`.`title`.`publishing_agreement` ADD CONSTRAINT `fk_title_publishing_agreement_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`title`.`playable_character` ADD CONSTRAINT `fk_title_playable_character_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`title`.`playable_character` ADD CONSTRAINT `fk_title_playable_character_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);
ALTER TABLE `gaming_ecm`.`title`.`playable_character` ADD CONSTRAINT `fk_title_playable_character_evolved_from_playable_character_id` FOREIGN KEY (`evolved_from_playable_character_id`) REFERENCES `gaming_ecm`.`title`.`playable_character`(`playable_character_id`);
ALTER TABLE `gaming_ecm`.`title`.`checkpoint` ADD CONSTRAINT `fk_title_checkpoint_achievement_id` FOREIGN KEY (`achievement_id`) REFERENCES `gaming_ecm`.`title`.`achievement`(`achievement_id`);
ALTER TABLE `gaming_ecm`.`title`.`checkpoint` ADD CONSTRAINT `fk_title_checkpoint_dlc_bundle_id` FOREIGN KEY (`dlc_bundle_id`) REFERENCES `gaming_ecm`.`title`.`dlc_bundle`(`dlc_bundle_id`);
ALTER TABLE `gaming_ecm`.`title`.`checkpoint` ADD CONSTRAINT `fk_title_checkpoint_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`title`.`checkpoint` ADD CONSTRAINT `fk_title_checkpoint_mission_id` FOREIGN KEY (`mission_id`) REFERENCES `gaming_ecm`.`title`.`mission`(`mission_id`);
ALTER TABLE `gaming_ecm`.`title`.`checkpoint` ADD CONSTRAINT `fk_title_checkpoint_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);
ALTER TABLE `gaming_ecm`.`title`.`checkpoint` ADD CONSTRAINT `fk_title_checkpoint_previous_checkpoint_id` FOREIGN KEY (`previous_checkpoint_id`) REFERENCES `gaming_ecm`.`title`.`checkpoint`(`checkpoint_id`);
ALTER TABLE `gaming_ecm`.`title`.`mission` ADD CONSTRAINT `fk_title_mission_prerequisite_mission_id` FOREIGN KEY (`prerequisite_mission_id`) REFERENCES `gaming_ecm`.`title`.`mission`(`mission_id`);

-- ========= TAGS =========
ALTER SCHEMA `gaming_ecm`.`title` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `gaming_ecm`.`title` SET TAGS ('dbx_domain' = 'title');
ALTER TABLE `gaming_ecm`.`title`.`game_title` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`title`.`game_title` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `franchise_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise ID');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `genre_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Genre Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `business_model` SET TAGS ('dbx_business_glossary_term' = 'Business Model');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `business_model` SET TAGS ('dbx_value_regex' = 'f2p|premium|subscription|hybrid|ad_supported|freemium');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `cero_rating` SET TAGS ('dbx_business_glossary_term' = 'Computer Entertainment Rating Organization (CERO) Rating');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `cero_rating` SET TAGS ('dbx_value_regex' = 'A|B|C|D|Z');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `coppa_compliance_required` SET TAGS ('dbx_business_glossary_term' = 'Childrens Online Privacy Protection Act (COPPA) Compliance Required');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `end_of_life_date` SET TAGS ('dbx_business_glossary_term' = 'End of Life Date');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `epic_catalog_item_code` SET TAGS ('dbx_business_glossary_term' = 'Epic Games Store Catalog Item ID');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `esrb_rating` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Software Rating Board (ESRB) Rating');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `esrb_rating` SET TAGS ('dbx_value_regex' = 'E|E10+|T|M|AO|RP');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `game_engine` SET TAGS ('dbx_business_glossary_term' = 'Game Engine');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `game_modes` SET TAGS ('dbx_business_glossary_term' = 'Game Modes');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `gdpr_scope` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Scope');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `gdpr_scope` SET TAGS ('dbx_value_regex' = 'in_scope|out_of_scope|partial');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `has_dlc` SET TAGS ('dbx_business_glossary_term' = 'Has Downloadable Content (DLC)');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `has_loot_boxes` SET TAGS ('dbx_business_glossary_term' = 'Has Loot Boxes');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `has_microtransactions` SET TAGS ('dbx_business_glossary_term' = 'Has Microtransactions (MTX)');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `initial_release_date` SET TAGS ('dbx_business_glossary_term' = 'Initial Release Date');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `ip_ownership_entity` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Ownership Entity');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `ip_ownership_entity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `is_cross_play_supported` SET TAGS ('dbx_business_glossary_term' = 'Is Cross-Play Supported');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `is_esports_title` SET TAGS ('dbx_business_glossary_term' = 'Is Esports Title');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `is_gaas` SET TAGS ('dbx_business_glossary_term' = 'Is Game as a Service (GaaS)');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `is_ugc_enabled` SET TAGS ('dbx_business_glossary_term' = 'Is User-Generated Content (UGC) Enabled');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `latest_release_date` SET TAGS ('dbx_business_glossary_term' = 'Latest Release Date');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Stage');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `marketing_tagline` SET TAGS ('dbx_business_glossary_term' = 'Marketing Tagline');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `max_player_count` SET TAGS ('dbx_business_glossary_term' = 'Maximum Player Count');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `min_player_count` SET TAGS ('dbx_business_glossary_term' = 'Minimum Player Count');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `official_title_name` SET TAGS ('dbx_business_glossary_term' = 'Official Title Name');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `official_website_url` SET TAGS ('dbx_business_glossary_term' = 'Official Website URL');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `online_capability` SET TAGS ('dbx_business_glossary_term' = 'Online Capability');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `online_capability` SET TAGS ('dbx_value_regex' = 'online_only|offline_only|online_and_offline');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `pci_dss_applicable` SET TAGS ('dbx_business_glossary_term' = 'Payment Card Industry Data Security Standard (PCI DSS) Applicable');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `pegi_rating` SET TAGS ('dbx_business_glossary_term' = 'Pan European Game Information (PEGI) Rating');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `pegi_rating` SET TAGS ('dbx_value_regex' = 'PEGI_3|PEGI_7|PEGI_12|PEGI_16|PEGI_18');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `planned_sunset_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Sunset Date');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived|deleted');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `secondary_genre` SET TAGS ('dbx_business_glossary_term' = 'Secondary Genre');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `steam_app_code` SET TAGS ('dbx_business_glossary_term' = 'Steam Application ID');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `supported_platforms` SET TAGS ('dbx_business_glossary_term' = 'Supported Platforms');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `target_age_max` SET TAGS ('dbx_business_glossary_term' = 'Target Age Maximum');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `target_age_min` SET TAGS ('dbx_business_glossary_term' = 'Target Age Minimum');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `working_title` SET TAGS ('dbx_business_glossary_term' = 'Working Title');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `title_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `game_edition_id` SET TAGS ('dbx_business_glossary_term' = 'Game Edition Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `age_gate_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Age Gate Required Flag');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `age_rating_code` SET TAGS ('dbx_business_glossary_term' = 'Age Rating Code');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `availability_end_date` SET TAGS ('dbx_business_glossary_term' = 'Availability End Date');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `availability_start_date` SET TAGS ('dbx_business_glossary_term' = 'Availability Start Date');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `bundle_component_flag` SET TAGS ('dbx_business_glossary_term' = 'Bundle Component Flag');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Platform Certification Date');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Platform Certification Status');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'not_submitted|in_review|approved|rejected|conditional_approval');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `content_type` SET TAGS ('dbx_business_glossary_term' = 'Content Type');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `cross_buy_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Buy Eligible Flag');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_value_regex' = 'digital|physical|subscription|bundle');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `drm_type` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Type');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `drm_type` SET TAGS ('dbx_value_regex' = 'none|steam_drm|denuvo|epic_drm|platform_native|proprietary');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `ean_code` SET TAGS ('dbx_business_glossary_term' = 'European Article Number (EAN)');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `ean_code` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `exclusive_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Flag');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `file_size_gb` SET TAGS ('dbx_business_glossary_term' = 'File Size (GB)');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `gold_master_date` SET TAGS ('dbx_business_glossary_term' = 'Gold Master Date');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `launch_type` SET TAGS ('dbx_business_glossary_term' = 'Launch Type');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `launch_type` SET TAGS ('dbx_value_regex' = 'hard_launch|soft_launch|early_access|beta|limited_release');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `msrp_amount` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Suggested Retail Price (MSRP) Amount');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `package_type` SET TAGS ('dbx_value_regex' = 'digital_download|disc|cartridge|code_in_box|steelbook|collectors_box');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `platform_code` SET TAGS ('dbx_business_glossary_term' = 'Platform Code');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `pre_order_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Pre-Order Eligible Flag');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_business_glossary_term' = 'Pricing Tier');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_value_regex' = 'budget|standard|premium|aaa|indie');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `promotional_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotional Flag');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `refund_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Refund Eligible Flag');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `sku_code` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Code');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `sku_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `sku_description` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Description');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `sku_name` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Name');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `sku_status` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Status');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `sku_status` SET TAGS ('dbx_value_regex' = 'planned|pre_release|active|delisted|discontinued|sunset');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `storefront_code` SET TAGS ('dbx_business_glossary_term' = 'Storefront Code');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `upc_code` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `upc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `gaming_ecm`.`title`.`game_edition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`title`.`game_edition` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `gaming_ecm`.`title`.`game_edition` ALTER COLUMN `game_edition_id` SET TAGS ('dbx_business_glossary_term' = 'Game Edition ID');
ALTER TABLE `gaming_ecm`.`title`.`game_edition` ALTER COLUMN `build_id` SET TAGS ('dbx_business_glossary_term' = 'Build Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`game_edition` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`title`.`game_edition` ALTER COLUMN `base_game_included` SET TAGS ('dbx_business_glossary_term' = 'Base Game Included Flag');
ALTER TABLE `gaming_ecm`.`title`.`game_edition` ALTER COLUMN `bonus_content_description` SET TAGS ('dbx_business_glossary_term' = 'Bonus Content Description');
ALTER TABLE `gaming_ecm`.`title`.`game_edition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`game_edition` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Edition Discontinuation Date');
ALTER TABLE `gaming_ecm`.`title`.`game_edition` ALTER COLUMN `display_order` SET TAGS ('dbx_business_glossary_term' = 'Display Order');
ALTER TABLE `gaming_ecm`.`title`.`game_edition` ALTER COLUMN `dlc_bundle_count` SET TAGS ('dbx_business_glossary_term' = 'DLC (Downloadable Content) Bundle Count');
ALTER TABLE `gaming_ecm`.`title`.`game_edition` ALTER COLUMN `early_access_days` SET TAGS ('dbx_business_glossary_term' = 'Early Access Days');
ALTER TABLE `gaming_ecm`.`title`.`game_edition` ALTER COLUMN `edition_code` SET TAGS ('dbx_business_glossary_term' = 'Edition Code');
ALTER TABLE `gaming_ecm`.`title`.`game_edition` ALTER COLUMN `edition_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `gaming_ecm`.`title`.`game_edition` ALTER COLUMN `edition_name` SET TAGS ('dbx_business_glossary_term' = 'Edition Name');
ALTER TABLE `gaming_ecm`.`title`.`game_edition` ALTER COLUMN `edition_tier` SET TAGS ('dbx_business_glossary_term' = 'Edition Tier');
ALTER TABLE `gaming_ecm`.`title`.`game_edition` ALTER COLUMN `edition_tier` SET TAGS ('dbx_value_regex' = 'base|premium|deluxe|ultimate|collectors|limited');
ALTER TABLE `gaming_ecm`.`title`.`game_edition` ALTER COLUMN `edition_type` SET TAGS ('dbx_business_glossary_term' = 'Edition Type');
ALTER TABLE `gaming_ecm`.`title`.`game_edition` ALTER COLUMN `game_edition_status` SET TAGS ('dbx_business_glossary_term' = 'Edition Status');
ALTER TABLE `gaming_ecm`.`title`.`game_edition` ALTER COLUMN `game_edition_status` SET TAGS ('dbx_value_regex' = 'planned|active|discontinued|retired|limited_availability|pre_order');
ALTER TABLE `gaming_ecm`.`title`.`game_edition` ALTER COLUMN `is_digital` SET TAGS ('dbx_business_glossary_term' = 'Digital Edition Flag');
ALTER TABLE `gaming_ecm`.`title`.`game_edition` ALTER COLUMN `is_limited_availability` SET TAGS ('dbx_business_glossary_term' = 'Limited Availability Flag');
ALTER TABLE `gaming_ecm`.`title`.`game_edition` ALTER COLUMN `is_physical` SET TAGS ('dbx_business_glossary_term' = 'Physical Edition Flag');
ALTER TABLE `gaming_ecm`.`title`.`game_edition` ALTER COLUMN `is_pre_order_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Pre-Order Exclusive Flag');
ALTER TABLE `gaming_ecm`.`title`.`game_edition` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Edition Launch Date');
ALTER TABLE `gaming_ecm`.`title`.`game_edition` ALTER COLUMN `marketing_description` SET TAGS ('dbx_business_glossary_term' = 'Marketing Description');
ALTER TABLE `gaming_ecm`.`title`.`game_edition` ALTER COLUMN `msrp_amount` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Suggested Retail Price (MSRP) Amount');
ALTER TABLE `gaming_ecm`.`title`.`game_edition` ALTER COLUMN `msrp_currency_code` SET TAGS ('dbx_business_glossary_term' = 'MSRP (Manufacturer Suggested Retail Price) Currency Code');
ALTER TABLE `gaming_ecm`.`title`.`game_edition` ALTER COLUMN `msrp_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`title`.`game_edition` ALTER COLUMN `physical_collectibles_description` SET TAGS ('dbx_business_glossary_term' = 'Physical Collectibles Description');
ALTER TABLE `gaming_ecm`.`title`.`game_edition` ALTER COLUMN `platform_availability` SET TAGS ('dbx_business_glossary_term' = 'Platform Availability');
ALTER TABLE `gaming_ecm`.`title`.`game_edition` ALTER COLUMN `pre_order_end_date` SET TAGS ('dbx_business_glossary_term' = 'Pre-Order End Date');
ALTER TABLE `gaming_ecm`.`title`.`game_edition` ALTER COLUMN `pre_order_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pre-Order Start Date');
ALTER TABLE `gaming_ecm`.`title`.`game_edition` ALTER COLUMN `region_availability` SET TAGS ('dbx_business_glossary_term' = 'Region Availability');
ALTER TABLE `gaming_ecm`.`title`.`game_edition` ALTER COLUMN `season_pass_included` SET TAGS ('dbx_business_glossary_term' = 'Season Pass Included Flag');
ALTER TABLE `gaming_ecm`.`title`.`game_edition` ALTER COLUMN `sku_template_flag` SET TAGS ('dbx_business_glossary_term' = 'SKU (Stock Keeping Unit) Template Flag');
ALTER TABLE `gaming_ecm`.`title`.`game_edition` ALTER COLUMN `storefront_availability` SET TAGS ('dbx_business_glossary_term' = 'Storefront Availability');
ALTER TABLE `gaming_ecm`.`title`.`game_edition` ALTER COLUMN `units_produced` SET TAGS ('dbx_business_glossary_term' = 'Units Produced');
ALTER TABLE `gaming_ecm`.`title`.`game_edition` ALTER COLUMN `units_produced` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`game_edition` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By');
ALTER TABLE `gaming_ecm`.`title`.`game_edition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`game_edition` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `build_artifact_id` SET TAGS ('dbx_business_glossary_term' = 'Build Artifact ID');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `asset_bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Bundle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `build_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Build ID');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `middleware_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Middleware Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `release_gate_id` SET TAGS ('dbx_business_glossary_term' = 'Release Gate ID');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `repo_id` SET TAGS ('dbx_business_glossary_term' = 'Repository ID');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `anti_cheat_version` SET TAGS ('dbx_business_glossary_term' = 'Anti-Cheat System Version');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `binary_size_mb` SET TAGS ('dbx_business_glossary_term' = 'Binary Size (MB)');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `build_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Build Compilation Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `build_type` SET TAGS ('dbx_business_glossary_term' = 'Build Type');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `cert_approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Certification Approved Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Platform Certification Status');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'not_submitted|submitted|in_review|approved|rejected|conditional_approval');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `checksum_sha256` SET TAGS ('dbx_business_glossary_term' = 'SHA-256 Checksum');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `checksum_sha256` SET TAGS ('dbx_value_regex' = '^[a-fA-F0-9]{64}$');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `content_rating` SET TAGS ('dbx_business_glossary_term' = 'Content Rating');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `delta_patch_size_mb` SET TAGS ('dbx_business_glossary_term' = 'Delta Patch Size (MB)');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `deployed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deployed to Production Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `deployment_status` SET TAGS ('dbx_business_glossary_term' = 'Deployment Status');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `deployment_status` SET TAGS ('dbx_value_regex' = 'pending|staged|deployed|rolled_back|deprecated');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `deprecated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deprecated Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `drm_enabled` SET TAGS ('dbx_business_glossary_term' = 'DRM (Digital Rights Management) Enabled');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `includes_mtx` SET TAGS ('dbx_business_glossary_term' = 'Includes MTX (Microtransactions)');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `includes_ugc` SET TAGS ('dbx_business_glossary_term' = 'Includes UGC (User-Generated Content)');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Build Notes');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `internal_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `is_mandatory_update` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Update Flag');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `is_rollback_available` SET TAGS ('dbx_business_glossary_term' = 'Rollback Available Flag');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `max_ccu_supported` SET TAGS ('dbx_business_glossary_term' = 'Maximum CCU (Concurrent Users) Supported');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `multiplayer_mode` SET TAGS ('dbx_business_glossary_term' = 'Multiplayer Mode');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `multiplayer_mode` SET TAGS ('dbx_value_regex' = 'single_player|local_multiplayer|online_multiplayer|mmo|hybrid');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `patch_notes` SET TAGS ('dbx_business_glossary_term' = 'Patch Notes');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `pipeline_reference` SET TAGS ('dbx_business_glossary_term' = 'CI/CD Pipeline Reference');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `qa_status` SET TAGS ('dbx_business_glossary_term' = 'QA (Quality Assurance) Status');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `qa_status` SET TAGS ('dbx_value_regex' = 'not_tested|in_testing|passed|failed|conditional_pass|waived');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `semantic_version` SET TAGS ('dbx_business_glossary_term' = 'Semantic Version');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `semantic_version` SET TAGS ('dbx_value_regex' = '^d+.d+.d+(-.+)?$');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `source_branch` SET TAGS ('dbx_business_glossary_term' = 'Source Branch');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `source_changelist` SET TAGS ('dbx_business_glossary_term' = 'Source Changelist');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `storage_location_uri` SET TAGS ('dbx_business_glossary_term' = 'Storage Location URI');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `storage_location_uri` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `submitted_for_cert_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submitted for Certification Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `target_platform` SET TAGS ('dbx_business_glossary_term' = 'Target Platform');
ALTER TABLE `gaming_ecm`.`title`.`title_release` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`title`.`title_release` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `title_release_id` SET TAGS ('dbx_business_glossary_term' = 'Title Release ID');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `build_artifact_id` SET TAGS ('dbx_business_glossary_term' = 'Build Artifact Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `build_id` SET TAGS ('dbx_business_glossary_term' = 'Build ID');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Release Manager ID');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `marketing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Campaign ID');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `platform_storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront ID');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `title_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Title Stock Keeping Unit (SKU) ID');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `actual_release_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Release Date');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `announcement_url` SET TAGS ('dbx_business_glossary_term' = 'Release Announcement URL');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `certification_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Approval Date');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'not_submitted|submitted|in_review|approved|rejected|waived');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `certification_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Submission Date');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `content_rating` SET TAGS ('dbx_business_glossary_term' = 'Content Rating');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `content_rating_authority` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Authority');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `content_rating_authority` SET TAGS ('dbx_value_regex' = 'ESRB|PEGI|CERO|USK|GRAC|other');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `deprecation_date` SET TAGS ('dbx_business_glossary_term' = 'Deprecation Date');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `early_access_flag` SET TAGS ('dbx_business_glossary_term' = 'Early Access Flag');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `forced_update_flag` SET TAGS ('dbx_business_glossary_term' = 'Forced Update Flag');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `go_live_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Go-Live Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `gold_master_flag` SET TAGS ('dbx_business_glossary_term' = 'Gold Master Flag');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `minimum_client_version` SET TAGS ('dbx_business_glossary_term' = 'Minimum Client Version');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Release Notes');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `patch_size_mb` SET TAGS ('dbx_business_glossary_term' = 'Patch Size (MB)');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `phased_rollout_flag` SET TAGS ('dbx_business_glossary_term' = 'Phased Rollout Flag');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `pre_order_flag` SET TAGS ('dbx_business_glossary_term' = 'Pre-Order Flag');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Release Priority');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `region_scope` SET TAGS ('dbx_business_glossary_term' = 'Region Scope');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `release_number` SET TAGS ('dbx_business_glossary_term' = 'Release Number');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `release_status` SET TAGS ('dbx_business_glossary_term' = 'Release Status');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `release_type` SET TAGS ('dbx_business_glossary_term' = 'Release Type');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `rollback_flag` SET TAGS ('dbx_business_glossary_term' = 'Rollback Flag');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `rollback_reason` SET TAGS ('dbx_business_glossary_term' = 'Rollback Reason');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `rollback_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Rollback Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `rollout_percentage` SET TAGS ('dbx_business_glossary_term' = 'Rollout Percentage');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `scheduled_release_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Release Date');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `territory_restriction_flag` SET TAGS ('dbx_business_glossary_term' = 'Territory Restriction Flag');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `dlc_bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Downloadable Content (DLC) Bundle Identifier');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `asset_bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Bundle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `build_id` SET TAGS ('dbx_business_glossary_term' = 'Build Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Studio Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title Identifier');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `marketing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Campaign Identifier');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `title_season_id` SET TAGS ('dbx_business_glossary_term' = 'Title Season Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `base_price_usd` SET TAGS ('dbx_business_glossary_term' = 'Base Price (USD)');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `battle_pass_tier` SET TAGS ('dbx_business_glossary_term' = 'Battle Pass Tier');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `bundle_code` SET TAGS ('dbx_business_glossary_term' = 'DLC Bundle Code');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `bundle_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,20}$');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `bundle_name` SET TAGS ('dbx_business_glossary_term' = 'DLC Bundle Name');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `bundle_status` SET TAGS ('dbx_business_glossary_term' = 'DLC Bundle Status');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'not_submitted|submitted|in_review|approved|rejected|resubmitted');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `content_descriptors` SET TAGS ('dbx_business_glossary_term' = 'Content Descriptors');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `content_rating` SET TAGS ('dbx_business_glossary_term' = 'Content Rating');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `description_long` SET TAGS ('dbx_business_glossary_term' = 'Long Description');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `description_short` SET TAGS ('dbx_business_glossary_term' = 'Short Description');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `developer_notes` SET TAGS ('dbx_business_glossary_term' = 'Developer Notes');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `developer_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `dlc_type` SET TAGS ('dbx_business_glossary_term' = 'DLC Type');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `dlc_type` SET TAGS ('dbx_value_regex' = 'expansion_pack|season_pass|cosmetic_bundle|map_pack|story_dlc|battle_pass');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `end_of_sale_date` SET TAGS ('dbx_business_glossary_term' = 'End of Sale Date');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `entitlement_count` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Count');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `entitlement_summary` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Summary');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `exclusive_platform` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Platform');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `exclusivity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity End Date');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `file_size_mb` SET TAGS ('dbx_business_glossary_term' = 'File Size (Megabytes)');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `included_in_edition` SET TAGS ('dbx_business_glossary_term' = 'Included in Edition');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `is_free` SET TAGS ('dbx_business_glossary_term' = 'Is Free Content');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `is_platform_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Is Platform Exclusive');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `is_pre_order_bonus` SET TAGS ('dbx_business_glossary_term' = 'Is Pre-Order Bonus');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `is_time_limited` SET TAGS ('dbx_business_glossary_term' = 'Is Time Limited');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `planned_release_date` SET TAGS ('dbx_business_glossary_term' = 'Planned DLC Release Date');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `platform_availability` SET TAGS ('dbx_business_glossary_term' = 'Platform Availability');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'DLC Release Date');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `requires_base_game` SET TAGS ('dbx_business_glossary_term' = 'Requires Base Game');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `storefront_image_url` SET TAGS ('dbx_business_glossary_term' = 'Storefront Image URL');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `trailer_url` SET TAGS ('dbx_business_glossary_term' = 'Trailer URL');
ALTER TABLE `gaming_ecm`.`title`.`content_rating` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`title`.`content_rating` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `gaming_ecm`.`title`.`content_rating` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating ID');
ALTER TABLE `gaming_ecm`.`title`.`content_rating` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`title`.`content_rating` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`content_rating` ALTER COLUMN `appeal_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Date');
ALTER TABLE `gaming_ecm`.`title`.`content_rating` ALTER COLUMN `appeal_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Resolution Date');
ALTER TABLE `gaming_ecm`.`title`.`content_rating` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `gaming_ecm`.`title`.`content_rating` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'not_appealed|appeal_pending|appeal_approved|appeal_denied');
ALTER TABLE `gaming_ecm`.`title`.`content_rating` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `gaming_ecm`.`title`.`content_rating` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `gaming_ecm`.`title`.`content_rating` ALTER COLUMN `compliance_officer` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer');
ALTER TABLE `gaming_ecm`.`title`.`content_rating` ALTER COLUMN `content_descriptors` SET TAGS ('dbx_business_glossary_term' = 'Content Descriptors');
ALTER TABLE `gaming_ecm`.`title`.`content_rating` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`content_rating` ALTER COLUMN `digital_certificate_url` SET TAGS ('dbx_business_glossary_term' = 'Digital Certificate URL');
ALTER TABLE `gaming_ecm`.`title`.`content_rating` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `gaming_ecm`.`title`.`content_rating` ALTER COLUMN `in_game_purchases_flag` SET TAGS ('dbx_business_glossary_term' = 'In-Game Purchases (IAP) Flag');
ALTER TABLE `gaming_ecm`.`title`.`content_rating` ALTER COLUMN `interactive_elements` SET TAGS ('dbx_business_glossary_term' = 'Interactive Elements');
ALTER TABLE `gaming_ecm`.`title`.`content_rating` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `gaming_ecm`.`title`.`content_rating` ALTER COLUMN `loot_box_disclosure` SET TAGS ('dbx_business_glossary_term' = 'Loot Box Disclosure');
ALTER TABLE `gaming_ecm`.`title`.`content_rating` ALTER COLUMN `online_notice_required` SET TAGS ('dbx_business_glossary_term' = 'Online Notice Required');
ALTER TABLE `gaming_ecm`.`title`.`content_rating` ALTER COLUMN `platform_scope` SET TAGS ('dbx_business_glossary_term' = 'Platform Scope');
ALTER TABLE `gaming_ecm`.`title`.`content_rating` ALTER COLUMN `publisher_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Publisher Contact Email');
ALTER TABLE `gaming_ecm`.`title`.`content_rating` ALTER COLUMN `publisher_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `gaming_ecm`.`title`.`content_rating` ALTER COLUMN `publisher_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`content_rating` ALTER COLUMN `publisher_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`content_rating` ALTER COLUMN `rating_artwork_url` SET TAGS ('dbx_business_glossary_term' = 'Rating Artwork URL');
ALTER TABLE `gaming_ecm`.`title`.`content_rating` ALTER COLUMN `rating_authority` SET TAGS ('dbx_business_glossary_term' = 'Rating Authority');
ALTER TABLE `gaming_ecm`.`title`.`content_rating` ALTER COLUMN `rating_authority` SET TAGS ('dbx_value_regex' = 'ESRB|PEGI|CERO|USK|GRAC|ACB');
ALTER TABLE `gaming_ecm`.`title`.`content_rating` ALTER COLUMN `rating_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Rating Fee Amount');
ALTER TABLE `gaming_ecm`.`title`.`content_rating` ALTER COLUMN `rating_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`content_rating` ALTER COLUMN `rating_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Rating Fee Currency');
ALTER TABLE `gaming_ecm`.`title`.`content_rating` ALTER COLUMN `rating_fee_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|GBP|AUD|KRW');
ALTER TABLE `gaming_ecm`.`title`.`content_rating` ALTER COLUMN `rating_status` SET TAGS ('dbx_business_glossary_term' = 'Rating Status');
ALTER TABLE `gaming_ecm`.`title`.`content_rating` ALTER COLUMN `rating_summary` SET TAGS ('dbx_business_glossary_term' = 'Rating Summary');
ALTER TABLE `gaming_ecm`.`title`.`content_rating` ALTER COLUMN `rating_type` SET TAGS ('dbx_business_glossary_term' = 'Rating Type');
ALTER TABLE `gaming_ecm`.`title`.`content_rating` ALTER COLUMN `rating_type` SET TAGS ('dbx_value_regex' = 'initial|re_rating|update|dlc|expansion|patch');
ALTER TABLE `gaming_ecm`.`title`.`content_rating` ALTER COLUMN `rating_value` SET TAGS ('dbx_business_glossary_term' = 'Rating Value');
ALTER TABLE `gaming_ecm`.`title`.`content_rating` ALTER COLUMN `rating_version` SET TAGS ('dbx_business_glossary_term' = 'Rating Version');
ALTER TABLE `gaming_ecm`.`title`.`content_rating` ALTER COLUMN `region_scope` SET TAGS ('dbx_business_glossary_term' = 'Region Scope');
ALTER TABLE `gaming_ecm`.`title`.`content_rating` ALTER COLUMN `reviewer_notes` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Notes');
ALTER TABLE `gaming_ecm`.`title`.`content_rating` ALTER COLUMN `reviewer_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`content_rating` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `gaming_ecm`.`title`.`content_rating` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`title_lifecycle_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`title`.`title_lifecycle_event` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `gaming_ecm`.`title`.`title_lifecycle_event` ALTER COLUMN `title_lifecycle_event_id` SET TAGS ('dbx_business_glossary_term' = 'Title Lifecycle Event ID');
ALTER TABLE `gaming_ecm`.`title`.`title_lifecycle_event` ALTER COLUMN `build_id` SET TAGS ('dbx_business_glossary_term' = 'Build ID');
ALTER TABLE `gaming_ecm`.`title`.`title_lifecycle_event` ALTER COLUMN `changelist_id` SET TAGS ('dbx_business_glossary_term' = 'Changelist ID');
ALTER TABLE `gaming_ecm`.`title`.`title_lifecycle_event` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `gaming_ecm`.`title`.`title_lifecycle_event` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Studio ID');
ALTER TABLE `gaming_ecm`.`title`.`title_lifecycle_event` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Title ID');
ALTER TABLE `gaming_ecm`.`title`.`title_lifecycle_event` ALTER COLUMN `title_release_id` SET TAGS ('dbx_business_glossary_term' = 'Release ID');
ALTER TABLE `gaming_ecm`.`title`.`title_lifecycle_event` ALTER COLUMN `actual_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Date');
ALTER TABLE `gaming_ecm`.`title`.`title_lifecycle_event` ALTER COLUMN `affected_platforms` SET TAGS ('dbx_business_glossary_term' = 'Affected Platforms');
ALTER TABLE `gaming_ecm`.`title`.`title_lifecycle_event` ALTER COLUMN `announcement_url` SET TAGS ('dbx_business_glossary_term' = 'Announcement URL');
ALTER TABLE `gaming_ecm`.`title`.`title_lifecycle_event` ALTER COLUMN `approver_role` SET TAGS ('dbx_business_glossary_term' = 'Approver Role');
ALTER TABLE `gaming_ecm`.`title`.`title_lifecycle_event` ALTER COLUMN `approving_authority` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority');
ALTER TABLE `gaming_ecm`.`title`.`title_lifecycle_event` ALTER COLUMN `build_version` SET TAGS ('dbx_business_glossary_term' = 'Build Version');
ALTER TABLE `gaming_ecm`.`title`.`title_lifecycle_event` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `gaming_ecm`.`title`.`title_lifecycle_event` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'not_applicable|pending|in_progress|passed|failed|conditional_pass');
ALTER TABLE `gaming_ecm`.`title`.`title_lifecycle_event` ALTER COLUMN `content_rating` SET TAGS ('dbx_business_glossary_term' = 'Content Rating');
ALTER TABLE `gaming_ecm`.`title`.`title_lifecycle_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`title_lifecycle_event` ALTER COLUMN `data_deletion_date` SET TAGS ('dbx_business_glossary_term' = 'Data Deletion Date');
ALTER TABLE `gaming_ecm`.`title`.`title_lifecycle_event` ALTER COLUMN `data_retention_policy` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Policy');
ALTER TABLE `gaming_ecm`.`title`.`title_lifecycle_event` ALTER COLUMN `epic_key` SET TAGS ('dbx_business_glossary_term' = 'Epic Key');
ALTER TABLE `gaming_ecm`.`title`.`title_lifecycle_event` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Event Date');
ALTER TABLE `gaming_ecm`.`title`.`title_lifecycle_event` ALTER COLUMN `event_metadata` SET TAGS ('dbx_business_glossary_term' = 'Event Metadata');
ALTER TABLE `gaming_ecm`.`title`.`title_lifecycle_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`title_lifecycle_event` ALTER COLUMN `is_public_announcement` SET TAGS ('dbx_business_glossary_term' = 'Is Public Announcement');
ALTER TABLE `gaming_ecm`.`title`.`title_lifecycle_event` ALTER COLUMN `jira_issue_key` SET TAGS ('dbx_business_glossary_term' = 'Jira Issue Key');
ALTER TABLE `gaming_ecm`.`title`.`title_lifecycle_event` ALTER COLUMN `milestone_status` SET TAGS ('dbx_business_glossary_term' = 'Milestone Status');
ALTER TABLE `gaming_ecm`.`title`.`title_lifecycle_event` ALTER COLUMN `milestone_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|deferred');
ALTER TABLE `gaming_ecm`.`title`.`title_lifecycle_event` ALTER COLUMN `milestone_type` SET TAGS ('dbx_business_glossary_term' = 'Milestone Type');
ALTER TABLE `gaming_ecm`.`title`.`title_lifecycle_event` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `gaming_ecm`.`title`.`title_lifecycle_event` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`title_lifecycle_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `gaming_ecm`.`title`.`title_lifecycle_event` ALTER COLUMN `planned_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Date');
ALTER TABLE `gaming_ecm`.`title`.`title_lifecycle_event` ALTER COLUMN `player_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Player Notification Date');
ALTER TABLE `gaming_ecm`.`title`.`title_lifecycle_event` ALTER COLUMN `player_notification_method` SET TAGS ('dbx_business_glossary_term' = 'Player Notification Method');
ALTER TABLE `gaming_ecm`.`title`.`title_lifecycle_event` ALTER COLUMN `rating_authority` SET TAGS ('dbx_business_glossary_term' = 'Rating Authority');
ALTER TABLE `gaming_ecm`.`title`.`title_lifecycle_event` ALTER COLUMN `rating_authority` SET TAGS ('dbx_value_regex' = 'ESRB|PEGI|CERO|USK|GRAC|other');
ALTER TABLE `gaming_ecm`.`title`.`title_lifecycle_event` ALTER COLUMN `refund_policy` SET TAGS ('dbx_business_glossary_term' = 'Refund Policy');
ALTER TABLE `gaming_ecm`.`title`.`title_lifecycle_event` ALTER COLUMN `regulatory_compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Notes');
ALTER TABLE `gaming_ecm`.`title`.`title_lifecycle_event` ALTER COLUMN `variance_days` SET TAGS ('dbx_business_glossary_term' = 'Variance Days');
ALTER TABLE `gaming_ecm`.`title`.`title_lifecycle_event` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `gaming_ecm`.`title`.`franchise` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`title`.`franchise` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `franchise_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Identifier (ID)');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Studio Identifier (ID)');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `genre_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Genre Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `active_titles_count` SET TAGS ('dbx_business_glossary_term' = 'Active Titles Count');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `brand_guidelines_url` SET TAGS ('dbx_business_glossary_term' = 'Brand Guidelines Reference URL');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `brand_guidelines_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `cross_media_comics_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Media Comics/Graphic Novel Flag');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `cross_media_film_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Media Film Adaptation Flag');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `cross_media_merchandise_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Media Merchandise Flag');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `cross_media_theme_park_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Media Theme Park Attraction Flag');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `cross_media_tv_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Media Television Adaptation Flag');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `esports_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Esports Enabled Flag');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `franchise_code` SET TAGS ('dbx_business_glossary_term' = 'Franchise Code');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `franchise_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `franchise_name` SET TAGS ('dbx_business_glossary_term' = 'Franchise Name');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `franchise_status` SET TAGS ('dbx_business_glossary_term' = 'Franchise Lifecycle Status');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `franchise_status` SET TAGS ('dbx_value_regex' = 'active|dormant|retired|in_development');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `franchise_tier` SET TAGS ('dbx_business_glossary_term' = 'Franchise Tier Classification');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `franchise_tier` SET TAGS ('dbx_value_regex' = 'aaa_flagship|aa_midtier|indie|mobile_first|experimental');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `inception_year` SET TAGS ('dbx_business_glossary_term' = 'Franchise Inception Year');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `ip_owner_entity` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Owner Entity');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `ip_owner_entity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Record Flag');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `last_title_release_date` SET TAGS ('dbx_business_glossary_term' = 'Last Title Release Date');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Franchise Launch Date');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `lifetime_revenue_usd` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Revenue (USD)');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `lifetime_revenue_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `localization_languages_supported` SET TAGS ('dbx_business_glossary_term' = 'Localization Languages Supported');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `monetization_model` SET TAGS ('dbx_business_glossary_term' = 'Primary Monetization Model');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `monetization_model` SET TAGS ('dbx_value_regex' = 'premium|f2p|freemium|subscription|gaas');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `next_planned_release_date` SET TAGS ('dbx_business_glossary_term' = 'Next Planned Release Date');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `next_planned_release_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `primary_platform_focus` SET TAGS ('dbx_business_glossary_term' = 'Primary Platform Focus');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `primary_platform_focus` SET TAGS ('dbx_value_regex' = 'console|pc|mobile|cross_platform|vr|cloud');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `secondary_genre` SET TAGS ('dbx_business_glossary_term' = 'Secondary Game Genre');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `social_media_handle` SET TAGS ('dbx_business_glossary_term' = 'Primary Social Media Handle');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `strategic_priority_level` SET TAGS ('dbx_business_glossary_term' = 'Strategic Priority Level');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `strategic_priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|sunset');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `strategic_priority_level` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `target_audience_rating` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Age Rating');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `target_market_regions` SET TAGS ('dbx_business_glossary_term' = 'Target Market Regions');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `total_titles_count` SET TAGS ('dbx_business_glossary_term' = 'Total Titles Count');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `ugc_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'User-Generated Content (UGC) Enabled Flag');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `universe_description` SET TAGS ('dbx_business_glossary_term' = 'Franchise Universe Description');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `valuation_usd` SET TAGS ('dbx_business_glossary_term' = 'Franchise Valuation (USD)');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `valuation_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Franchise Official Website URL');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ALTER COLUMN `genre_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Genre Classification ID');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ALTER COLUMN `parent_genre_genre_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Genre ID');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ALTER COLUMN `art_style` SET TAGS ('dbx_business_glossary_term' = 'Art Style');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ALTER COLUMN `average_session_length_minutes` SET TAGS ('dbx_business_glossary_term' = 'Average Session Length (Minutes)');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ALTER COLUMN `camera_perspective` SET TAGS ('dbx_business_glossary_term' = 'Camera Perspective');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ALTER COLUMN `complexity_level` SET TAGS ('dbx_business_glossary_term' = 'Complexity Level');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ALTER COLUMN `complexity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|expert');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ALTER COLUMN `console_store_category` SET TAGS ('dbx_business_glossary_term' = 'Console Store Category');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ALTER COLUMN `discovery_priority` SET TAGS ('dbx_business_glossary_term' = 'Discovery Priority');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ALTER COLUMN `epic_store_category` SET TAGS ('dbx_business_glossary_term' = 'Epic Games Store Category');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ALTER COLUMN `esrb_rating_guidance` SET TAGS ('dbx_business_glossary_term' = 'ESRB Rating Guidance');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ALTER COLUMN `esrb_rating_guidance` SET TAGS ('dbx_value_regex' = 'EC|E|E10|T|M|AO');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ALTER COLUMN `gameplay_tag` SET TAGS ('dbx_business_glossary_term' = 'Gameplay Tag');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ALTER COLUMN `genre_classification_description` SET TAGS ('dbx_business_glossary_term' = 'Genre Classification Description');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ALTER COLUMN `genre_classification_status` SET TAGS ('dbx_business_glossary_term' = 'Genre Classification Status');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ALTER COLUMN `genre_classification_status` SET TAGS ('dbx_value_regex' = 'active|deprecated|retired|proposed|under_review');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ALTER COLUMN `genre_code` SET TAGS ('dbx_business_glossary_term' = 'Genre Code');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ALTER COLUMN `genre_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ALTER COLUMN `genre_name` SET TAGS ('dbx_business_glossary_term' = 'Genre Name');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ALTER COLUMN `genre_type` SET TAGS ('dbx_business_glossary_term' = 'Genre Type');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ALTER COLUMN `genre_type` SET TAGS ('dbx_value_regex' = 'primary|sub_genre|hybrid|tag');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ALTER COLUMN `industry_standard_alignment` SET TAGS ('dbx_business_glossary_term' = 'Industry Standard Alignment');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ALTER COLUMN `marketing_segment` SET TAGS ('dbx_business_glossary_term' = 'Marketing Segment');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ALTER COLUMN `mobile_store_category` SET TAGS ('dbx_business_glossary_term' = 'Mobile Store Category');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ALTER COLUMN `mobile_store_category` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ALTER COLUMN `mobile_store_category` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ALTER COLUMN `monetization_model` SET TAGS ('dbx_business_glossary_term' = 'Monetization Model');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Genre Classification Notes');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ALTER COLUMN `pegi_rating_guidance` SET TAGS ('dbx_business_glossary_term' = 'PEGI Rating Guidance');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ALTER COLUMN `pegi_rating_guidance` SET TAGS ('dbx_value_regex' = 'PEGI_3|PEGI_7|PEGI_12|PEGI_16|PEGI_18');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ALTER COLUMN `platform_affinity` SET TAGS ('dbx_business_glossary_term' = 'Platform Affinity');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ALTER COLUMN `player_mode` SET TAGS ('dbx_business_glossary_term' = 'Player Mode');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ALTER COLUMN `recommendation_weight` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Weight');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ALTER COLUMN `setting_theme` SET TAGS ('dbx_business_glossary_term' = 'Setting Theme');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ALTER COLUMN `steam_tag_mapping` SET TAGS ('dbx_business_glossary_term' = 'Steam Tag Mapping');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ALTER COLUMN `sub_genre_name` SET TAGS ('dbx_business_glossary_term' = 'Sub-Genre Name');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ALTER COLUMN `target_audience` SET TAGS ('dbx_value_regex' = 'casual|core|hardcore|family|children|mature');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ALTER COLUMN `taxonomy_version` SET TAGS ('dbx_business_glossary_term' = 'Taxonomy Version');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ALTER COLUMN `taxonomy_version` SET TAGS ('dbx_value_regex' = '^vd+.d+(.d+)?$');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ALTER COLUMN `typical_retention_d1_pct` SET TAGS ('dbx_business_glossary_term' = 'Typical Day 1 (D1) Retention Percentage');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ALTER COLUMN `typical_retention_d30_pct` SET TAGS ('dbx_business_glossary_term' = 'Typical Day 30 (D30) Retention Percentage');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ALTER COLUMN `typical_retention_d7_pct` SET TAGS ('dbx_business_glossary_term' = 'Typical Day 7 (D7) Retention Percentage');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ALTER COLUMN `version_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Version Effective Date');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ALTER COLUMN `version_end_date` SET TAGS ('dbx_business_glossary_term' = 'Version End Date');
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `localization_version_id` SET TAGS ('dbx_business_glossary_term' = 'Localization Version Identifier (ID)');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `build_id` SET TAGS ('dbx_business_glossary_term' = 'Game Build Identifier (ID)');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `live_ops_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Gaas Live Ops Cycle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Studio Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title Identifier (ID)');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `music_sync_license_id` SET TAGS ('dbx_business_glossary_term' = 'Music Sync License Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `title_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier (ID)');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `audio_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Localized Audio Duration (Minutes)');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Platform Certification Status');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'not_submitted|submitted|in_review|approved|rejected|conditional_approval');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `character_encoding` SET TAGS ('dbx_business_glossary_term' = 'Character Encoding Standard');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `character_encoding` SET TAGS ('dbx_value_regex' = 'UTF-8|UTF-16|Shift_JIS|GB2312|Big5|ISO-8859-1');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `completeness_percentage` SET TAGS ('dbx_business_glossary_term' = 'Localization Completeness Percentage');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `content_rating_code` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Code');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `content_rating_required` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Required Flag');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `cultural_adaptation_notes` SET TAGS ('dbx_business_glossary_term' = 'Cultural Adaptation Notes');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `font_support_verified` SET TAGS ('dbx_business_glossary_term' = 'Font Support Verified Flag');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `included_in_base_sku` SET TAGS ('dbx_business_glossary_term' = 'Included in Base Stock Keeping Unit (SKU) Flag');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Status Flag');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code (ISO 639-1)');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `legal_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Legal Compliance Status');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `legal_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|pending_review|non_compliant|requires_modification|exempt');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `locale_identifier` SET TAGS ('dbx_business_glossary_term' = 'Locale Identifier (Language-Region)');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `locale_identifier` SET TAGS ('dbx_value_regex' = '^[a-z]{2}_[A-Z]{2,3}$');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `localization_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Localization Cost (United States Dollar - USD)');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `localization_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `localization_scope` SET TAGS ('dbx_business_glossary_term' = 'Localization Scope');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `localization_scope` SET TAGS ('dbx_value_regex' = 'full_audio_dub|subtitles_only|ui_text_only|partial_localization|audio_and_subtitles|text_only');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `platform_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Platform Certification Required Flag');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `qa_sign_off_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Sign-Off Date');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `qa_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Status');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `qa_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|qa_review|qa_approved|qa_rejected|rework_required');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Localization Release Date');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `storefront_listing_status` SET TAGS ('dbx_business_glossary_term' = 'Storefront Listing Status');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `storefront_listing_status` SET TAGS ('dbx_value_regex' = 'not_listed|draft|pending_approval|live|delisted|region_blocked');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `subtitle_format` SET TAGS ('dbx_business_glossary_term' = 'Subtitle File Format');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `subtitle_format` SET TAGS ('dbx_value_regex' = 'srt|vtt|ass|ssa|proprietary|none');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `sunset_date` SET TAGS ('dbx_business_glossary_term' = 'Localization Sunset Date');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `text_direction` SET TAGS ('dbx_business_glossary_term' = 'Text Direction');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `text_direction` SET TAGS ('dbx_value_regex' = 'ltr|rtl|ttb');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `translation_memory_reference` SET TAGS ('dbx_business_glossary_term' = 'Translation Memory Identifier (ID)');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Localization Version Number');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^d+.d+(.d+)?$');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `voice_actor_credits` SET TAGS ('dbx_business_glossary_term' = 'Voice Actor Credits');
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ALTER COLUMN `word_count` SET TAGS ('dbx_business_glossary_term' = 'Localized Word Count');
ALTER TABLE `gaming_ecm`.`title`.`title_season` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`title`.`title_season` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `gaming_ecm`.`title`.`title_season` ALTER COLUMN `title_season_id` SET TAGS ('dbx_business_glossary_term' = 'Title Season ID');
ALTER TABLE `gaming_ecm`.`title`.`title_season` ALTER COLUMN `brand_partnership_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Partnership Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`title_season` ALTER COLUMN `build_id` SET TAGS ('dbx_business_glossary_term' = 'Build Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`title_season` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`title`.`title_season` ALTER COLUMN `live_ops_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Live Operations (Ops) Cycle ID');
ALTER TABLE `gaming_ecm`.`title`.`title_season` ALTER COLUMN `actual_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration Days');
ALTER TABLE `gaming_ecm`.`title`.`title_season` ALTER COLUMN `announcement_date` SET TAGS ('dbx_business_glossary_term' = 'Announcement Date');
ALTER TABLE `gaming_ecm`.`title`.`title_season` ALTER COLUMN `balance_patch_version` SET TAGS ('dbx_business_glossary_term' = 'Balance Patch Version');
ALTER TABLE `gaming_ecm`.`title`.`title_season` ALTER COLUMN `battle_pass_included` SET TAGS ('dbx_business_glossary_term' = 'Battle Pass Included Flag');
ALTER TABLE `gaming_ecm`.`title`.`title_season` ALTER COLUMN `competitive_season_flag` SET TAGS ('dbx_business_glossary_term' = 'Competitive Season Flag');
ALTER TABLE `gaming_ecm`.`title`.`title_season` ALTER COLUMN `content_rating` SET TAGS ('dbx_business_glossary_term' = 'Content Rating');
ALTER TABLE `gaming_ecm`.`title`.`title_season` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`title_season` ALTER COLUMN `dlc_bundle_count` SET TAGS ('dbx_business_glossary_term' = 'Downloadable Content (DLC) Bundle Count');
ALTER TABLE `gaming_ecm`.`title`.`title_season` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Season End Date');
ALTER TABLE `gaming_ecm`.`title`.`title_season` ALTER COLUMN `featured_content_description` SET TAGS ('dbx_business_glossary_term' = 'Featured Content Description');
ALTER TABLE `gaming_ecm`.`title`.`title_season` ALTER COLUMN `free_to_play_content_flag` SET TAGS ('dbx_business_glossary_term' = 'Free-to-Play (F2P) Content Flag');
ALTER TABLE `gaming_ecm`.`title`.`title_season` ALTER COLUMN `leaderboard_reset_flag` SET TAGS ('dbx_business_glossary_term' = 'Leaderboard Reset Flag');
ALTER TABLE `gaming_ecm`.`title`.`title_season` ALTER COLUMN `marketing_tagline` SET TAGS ('dbx_business_glossary_term' = 'Marketing Tagline');
ALTER TABLE `gaming_ecm`.`title`.`title_season` ALTER COLUMN `mid_season_update_flag` SET TAGS ('dbx_business_glossary_term' = 'Mid-Season Update Flag');
ALTER TABLE `gaming_ecm`.`title`.`title_season` ALTER COLUMN `narrative_summary` SET TAGS ('dbx_business_glossary_term' = 'Narrative Summary');
ALTER TABLE `gaming_ecm`.`title`.`title_season` ALTER COLUMN `new_characters_count` SET TAGS ('dbx_business_glossary_term' = 'New Characters Count');
ALTER TABLE `gaming_ecm`.`title`.`title_season` ALTER COLUMN `new_maps_count` SET TAGS ('dbx_business_glossary_term' = 'New Maps Count');
ALTER TABLE `gaming_ecm`.`title`.`title_season` ALTER COLUMN `new_modes_count` SET TAGS ('dbx_business_glossary_term' = 'New Game Modes Count');
ALTER TABLE `gaming_ecm`.`title`.`title_season` ALTER COLUMN `new_weapons_count` SET TAGS ('dbx_business_glossary_term' = 'New Weapons Count');
ALTER TABLE `gaming_ecm`.`title`.`title_season` ALTER COLUMN `pass_required` SET TAGS ('dbx_business_glossary_term' = 'Season Pass Required Flag');
ALTER TABLE `gaming_ecm`.`title`.`title_season` ALTER COLUMN `planned_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Planned Duration Days');
ALTER TABLE `gaming_ecm`.`title`.`title_season` ALTER COLUMN `platform_availability` SET TAGS ('dbx_business_glossary_term' = 'Platform Availability');
ALTER TABLE `gaming_ecm`.`title`.`title_season` ALTER COLUMN `pre_season_event_flag` SET TAGS ('dbx_business_glossary_term' = 'Pre-Season Event Flag');
ALTER TABLE `gaming_ecm`.`title`.`title_season` ALTER COLUMN `region_availability` SET TAGS ('dbx_business_glossary_term' = 'Region Availability');
ALTER TABLE `gaming_ecm`.`title`.`title_season` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `gaming_ecm`.`title`.`title_season` ALTER COLUMN `season_name` SET TAGS ('dbx_business_glossary_term' = 'Season Name');
ALTER TABLE `gaming_ecm`.`title`.`title_season` ALTER COLUMN `season_number` SET TAGS ('dbx_business_glossary_term' = 'Season Number');
ALTER TABLE `gaming_ecm`.`title`.`title_season` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Season Start Date');
ALTER TABLE `gaming_ecm`.`title`.`title_season` ALTER COLUMN `target_dau` SET TAGS ('dbx_business_glossary_term' = 'Target Daily Active Users (DAU)');
ALTER TABLE `gaming_ecm`.`title`.`title_season` ALTER COLUMN `target_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Target Revenue Amount');
ALTER TABLE `gaming_ecm`.`title`.`title_season` ALTER COLUMN `target_revenue_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`title_season` ALTER COLUMN `target_revenue_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Target Revenue Currency Code');
ALTER TABLE `gaming_ecm`.`title`.`title_season` ALTER COLUMN `target_revenue_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`title`.`title_season` ALTER COLUMN `theme` SET TAGS ('dbx_business_glossary_term' = 'Season Theme');
ALTER TABLE `gaming_ecm`.`title`.`title_season` ALTER COLUMN `title_season_status` SET TAGS ('dbx_business_glossary_term' = 'Season Status');
ALTER TABLE `gaming_ecm`.`title`.`title_season` ALTER COLUMN `title_season_status` SET TAGS ('dbx_value_regex' = 'upcoming|active|concluded|cancelled|extended');
ALTER TABLE `gaming_ecm`.`title`.`title_season` ALTER COLUMN `trailer_url` SET TAGS ('dbx_business_glossary_term' = 'Trailer Uniform Resource Locator (URL)');
ALTER TABLE `gaming_ecm`.`title`.`title_season` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `gaming_ecm`.`title`.`title_season` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`title_season` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `gaming_ecm`.`title`.`territory_rights` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`title`.`territory_rights` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `gaming_ecm`.`title`.`territory_rights` ALTER COLUMN `territory_rights_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Rights ID');
ALTER TABLE `gaming_ecm`.`title`.`territory_rights` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`title`.`territory_rights` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`territory_rights` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`territory_rights` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `gaming_ecm`.`title`.`territory_rights` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|passed|failed|waived');
ALTER TABLE `gaming_ecm`.`title`.`territory_rights` ALTER COLUMN `channel_scope` SET TAGS ('dbx_business_glossary_term' = 'Channel Scope');
ALTER TABLE `gaming_ecm`.`title`.`territory_rights` ALTER COLUMN `channel_scope` SET TAGS ('dbx_value_regex' = 'digital|physical|both');
ALTER TABLE `gaming_ecm`.`title`.`territory_rights` ALTER COLUMN `content_rating` SET TAGS ('dbx_business_glossary_term' = 'Content Rating');
ALTER TABLE `gaming_ecm`.`title`.`territory_rights` ALTER COLUMN `contract_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Contract Currency Code');
ALTER TABLE `gaming_ecm`.`title`.`territory_rights` ALTER COLUMN `contract_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`title`.`territory_rights` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `gaming_ecm`.`title`.`territory_rights` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`territory_rights` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`territory_rights` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `gaming_ecm`.`title`.`territory_rights` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `gaming_ecm`.`title`.`territory_rights` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `gaming_ecm`.`title`.`territory_rights` ALTER COLUMN `first_party_approval_required` SET TAGS ('dbx_business_glossary_term' = 'First Party Approval Required');
ALTER TABLE `gaming_ecm`.`title`.`territory_rights` ALTER COLUMN `ip_owner_entity` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Owner Entity');
ALTER TABLE `gaming_ecm`.`title`.`territory_rights` ALTER COLUMN `ip_owner_entity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`territory_rights` ALTER COLUMN `language_support` SET TAGS ('dbx_business_glossary_term' = 'Language Support');
ALTER TABLE `gaming_ecm`.`title`.`territory_rights` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Territory Launch Date');
ALTER TABLE `gaming_ecm`.`title`.`territory_rights` ALTER COLUMN `localization_required` SET TAGS ('dbx_business_glossary_term' = 'Localization Required');
ALTER TABLE `gaming_ecm`.`title`.`territory_rights` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee Amount');
ALTER TABLE `gaming_ecm`.`title`.`territory_rights` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`territory_rights` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Territory Rights Notes');
ALTER TABLE `gaming_ecm`.`title`.`territory_rights` ALTER COLUMN `platform_scope` SET TAGS ('dbx_business_glossary_term' = 'Platform Scope');
ALTER TABLE `gaming_ecm`.`title`.`territory_rights` ALTER COLUMN `rating_authority` SET TAGS ('dbx_business_glossary_term' = 'Rating Authority');
ALTER TABLE `gaming_ecm`.`title`.`territory_rights` ALTER COLUMN `regulatory_compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Notes');
ALTER TABLE `gaming_ecm`.`title`.`territory_rights` ALTER COLUMN `regulatory_compliance_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`territory_rights` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `gaming_ecm`.`title`.`territory_rights` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`territory_rights` ALTER COLUMN `rights_holder_entity` SET TAGS ('dbx_business_glossary_term' = 'Rights Holder Entity');
ALTER TABLE `gaming_ecm`.`title`.`territory_rights` ALTER COLUMN `rights_holder_entity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`territory_rights` ALTER COLUMN `rights_type` SET TAGS ('dbx_business_glossary_term' = 'Rights Type');
ALTER TABLE `gaming_ecm`.`title`.`territory_rights` ALTER COLUMN `rights_type` SET TAGS ('dbx_value_regex' = 'publish|distribute|co-publish|sub-license|exclusive_distribution|non-exclusive_distribution');
ALTER TABLE `gaming_ecm`.`title`.`territory_rights` ALTER COLUMN `storefront_availability` SET TAGS ('dbx_business_glossary_term' = 'Storefront Availability');
ALTER TABLE `gaming_ecm`.`title`.`territory_rights` ALTER COLUMN `sub_licensing_permitted` SET TAGS ('dbx_business_glossary_term' = 'Sub-Licensing Permitted');
ALTER TABLE `gaming_ecm`.`title`.`territory_rights` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `gaming_ecm`.`title`.`territory_rights` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `gaming_ecm`.`title`.`territory_rights` ALTER COLUMN `termination_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`territory_rights` ALTER COLUMN `territory_rights_status` SET TAGS ('dbx_business_glossary_term' = 'Territory Rights Status');
ALTER TABLE `gaming_ecm`.`title`.`territory_rights` ALTER COLUMN `territory_rights_status` SET TAGS ('dbx_value_regex' = 'active|pending|expired|terminated|suspended|under_review');
ALTER TABLE `gaming_ecm`.`title`.`territory_rights` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `gaming_ecm`.`title`.`territory_rights` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`territory_rights` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` SET TAGS ('dbx_data_type' = 'Master');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` SET TAGS ('dbx_subdomain' = 'gameplay_experience');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `game_mode_id` SET TAGS ('dbx_business_glossary_term' = 'Game Mode Identifier (ID)');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title Identifier (ID)');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `parent_game_mode_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `age_rating_override` SET TAGS ('dbx_business_glossary_term' = 'Age Rating Override');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `anti_cheat_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Anti-Cheat Required Flag');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `content_warning_flags` SET TAGS ('dbx_business_glossary_term' = 'Content Warning Flags');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `cross_play_supported_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Play Supported Flag');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `cross_progression_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Progression Enabled Flag');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `display_order` SET TAGS ('dbx_business_glossary_term' = 'Display Order Sequence');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `esports_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Esports Eligible Flag');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `friendly_fire_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Friendly Fire Enabled Flag');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `game_mode_description` SET TAGS ('dbx_business_glossary_term' = 'Game Mode Description');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `game_mode_status` SET TAGS ('dbx_business_glossary_term' = 'Game Mode Status');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `gameplay_category` SET TAGS ('dbx_business_glossary_term' = 'Gameplay Category');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Mode Launch Date');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `limited_time_event_flag` SET TAGS ('dbx_business_glossary_term' = 'Limited Time Event (LTE) Flag');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `matchmaking_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Matchmaking Algorithm');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `matchmaking_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Matchmaking Enabled Flag');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `max_player_count` SET TAGS ('dbx_business_glossary_term' = 'Maximum Player Count');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `min_player_count` SET TAGS ('dbx_business_glossary_term' = 'Minimum Player Count');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `mode_code` SET TAGS ('dbx_business_glossary_term' = 'Game Mode Code');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `mode_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `mode_name` SET TAGS ('dbx_business_glossary_term' = 'Game Mode Name');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `mode_type` SET TAGS ('dbx_business_glossary_term' = 'Game Mode Type');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `monetization_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Monetization Enabled Flag');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `online_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Online Connection Required Flag');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `platform_availability` SET TAGS ('dbx_business_glossary_term' = 'Platform Availability');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `progression_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Progression Enabled Flag');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `ranked_mode_flag` SET TAGS ('dbx_business_glossary_term' = 'Ranked Mode Flag');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `respawn_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Respawn Enabled Flag');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `rules_summary` SET TAGS ('dbx_business_glossary_term' = 'Mode Rules Summary');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `seasonal_flag` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Mode Flag');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `session_duration_max_minutes` SET TAGS ('dbx_business_glossary_term' = 'Maximum Session Duration in Minutes');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `session_duration_min_minutes` SET TAGS ('dbx_business_glossary_term' = 'Minimum Session Duration in Minutes');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `spectator_mode_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Spectator Mode Enabled Flag');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `sunset_date` SET TAGS ('dbx_business_glossary_term' = 'Mode Sunset Date');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `team_based_flag` SET TAGS ('dbx_business_glossary_term' = 'Team-Based Mode Flag');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `team_size` SET TAGS ('dbx_business_glossary_term' = 'Team Size');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `text_chat_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Text Chat Enabled Flag');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `tutorial_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Tutorial Available Flag');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `voice_chat_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Voice Chat Enabled Flag');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `gaming_ecm`.`title`.`achievement` SET TAGS ('dbx_data_type' = 'Master');
ALTER TABLE `gaming_ecm`.`title`.`achievement` SET TAGS ('dbx_subdomain' = 'gameplay_experience');
ALTER TABLE `gaming_ecm`.`title`.`achievement` ALTER COLUMN `achievement_id` SET TAGS ('dbx_business_glossary_term' = 'Achievement ID');
ALTER TABLE `gaming_ecm`.`title`.`achievement` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`achievement` ALTER COLUMN `dlc_bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Downloadable Content (DLC) Bundle ID');
ALTER TABLE `gaming_ecm`.`title`.`achievement` ALTER COLUMN `game_mode_id` SET TAGS ('dbx_business_glossary_term' = 'Game Mode Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`achievement` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`title`.`achievement` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Icon Asset Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`achievement` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`achievement` ALTER COLUMN `live_ops_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Live Ops Cycle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`achievement` ALTER COLUMN `prerequisite_achievement_id` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Achievement ID');
ALTER TABLE `gaming_ecm`.`title`.`achievement` ALTER COLUMN `title_season_id` SET TAGS ('dbx_business_glossary_term' = 'Season ID');
ALTER TABLE `gaming_ecm`.`title`.`achievement` ALTER COLUMN `achievement_code` SET TAGS ('dbx_business_glossary_term' = 'Achievement Code');
ALTER TABLE `gaming_ecm`.`title`.`achievement` ALTER COLUMN `achievement_name` SET TAGS ('dbx_business_glossary_term' = 'Achievement Name');
ALTER TABLE `gaming_ecm`.`title`.`achievement` ALTER COLUMN `achievement_status` SET TAGS ('dbx_business_glossary_term' = 'Achievement Status');
ALTER TABLE `gaming_ecm`.`title`.`achievement` ALTER COLUMN `achievement_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|planned|testing');
ALTER TABLE `gaming_ecm`.`title`.`achievement` ALTER COLUMN `achievement_type` SET TAGS ('dbx_business_glossary_term' = 'Achievement Type');
ALTER TABLE `gaming_ecm`.`title`.`achievement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`achievement` ALTER COLUMN `deprecation_date` SET TAGS ('dbx_business_glossary_term' = 'Deprecation Date');
ALTER TABLE `gaming_ecm`.`title`.`achievement` ALTER COLUMN `description_long` SET TAGS ('dbx_business_glossary_term' = 'Long Description');
ALTER TABLE `gaming_ecm`.`title`.`achievement` ALTER COLUMN `description_short` SET TAGS ('dbx_business_glossary_term' = 'Short Description');
ALTER TABLE `gaming_ecm`.`title`.`achievement` ALTER COLUMN `display_order` SET TAGS ('dbx_business_glossary_term' = 'Display Order');
ALTER TABLE `gaming_ecm`.`title`.`achievement` ALTER COLUMN `epic_achievement_code` SET TAGS ('dbx_business_glossary_term' = 'Epic Achievement ID');
ALTER TABLE `gaming_ecm`.`title`.`achievement` ALTER COLUMN `is_hidden` SET TAGS ('dbx_business_glossary_term' = 'Is Hidden Flag');
ALTER TABLE `gaming_ecm`.`title`.`achievement` ALTER COLUMN `is_platinum_trophy` SET TAGS ('dbx_business_glossary_term' = 'Is Platinum Trophy Flag');
ALTER TABLE `gaming_ecm`.`title`.`achievement` ALTER COLUMN `is_secret` SET TAGS ('dbx_business_glossary_term' = 'Is Secret Flag');
ALTER TABLE `gaming_ecm`.`title`.`achievement` ALTER COLUMN `is_time_limited` SET TAGS ('dbx_business_glossary_term' = 'Is Time Limited Flag');
ALTER TABLE `gaming_ecm`.`title`.`achievement` ALTER COLUMN `localization_required` SET TAGS ('dbx_business_glossary_term' = 'Localization Required Flag');
ALTER TABLE `gaming_ecm`.`title`.`achievement` ALTER COLUMN `platform_availability` SET TAGS ('dbx_business_glossary_term' = 'Platform Availability');
ALTER TABLE `gaming_ecm`.`title`.`achievement` ALTER COLUMN `playstation_trophy_code` SET TAGS ('dbx_business_glossary_term' = 'PlayStation Trophy ID');
ALTER TABLE `gaming_ecm`.`title`.`achievement` ALTER COLUMN `playstation_trophy_type` SET TAGS ('dbx_business_glossary_term' = 'PlayStation Trophy Type');
ALTER TABLE `gaming_ecm`.`title`.`achievement` ALTER COLUMN `playstation_trophy_type` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold|platinum');
ALTER TABLE `gaming_ecm`.`title`.`achievement` ALTER COLUMN `point_value` SET TAGS ('dbx_business_glossary_term' = 'Point Value');
ALTER TABLE `gaming_ecm`.`title`.`achievement` ALTER COLUMN `rarity_tier` SET TAGS ('dbx_business_glossary_term' = 'Rarity Tier');
ALTER TABLE `gaming_ecm`.`title`.`achievement` ALTER COLUMN `rarity_tier` SET TAGS ('dbx_value_regex' = 'common|uncommon|rare|epic|legendary');
ALTER TABLE `gaming_ecm`.`title`.`achievement` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `gaming_ecm`.`title`.`achievement` ALTER COLUMN `reward_description` SET TAGS ('dbx_business_glossary_term' = 'Reward Description');
ALTER TABLE `gaming_ecm`.`title`.`achievement` ALTER COLUMN `reward_type` SET TAGS ('dbx_business_glossary_term' = 'Reward Type');
ALTER TABLE `gaming_ecm`.`title`.`achievement` ALTER COLUMN `reward_type` SET TAGS ('dbx_value_regex' = 'none|cosmetic|currency|item|unlock');
ALTER TABLE `gaming_ecm`.`title`.`achievement` ALTER COLUMN `steam_achievement_code` SET TAGS ('dbx_business_glossary_term' = 'Steam Achievement ID');
ALTER TABLE `gaming_ecm`.`title`.`achievement` ALTER COLUMN `time_limit_end` SET TAGS ('dbx_business_glossary_term' = 'Time Limit End Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`achievement` ALTER COLUMN `time_limit_start` SET TAGS ('dbx_business_glossary_term' = 'Time Limit Start Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`achievement` ALTER COLUMN `unlock_criteria` SET TAGS ('dbx_business_glossary_term' = 'Unlock Criteria');
ALTER TABLE `gaming_ecm`.`title`.`achievement` ALTER COLUMN `unlock_percentage` SET TAGS ('dbx_business_glossary_term' = 'Unlock Percentage');
ALTER TABLE `gaming_ecm`.`title`.`achievement` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `gaming_ecm`.`title`.`achievement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`achievement` ALTER COLUMN `xbox_achievement_code` SET TAGS ('dbx_business_glossary_term' = 'Xbox Achievement ID');
ALTER TABLE `gaming_ecm`.`title`.`achievement` ALTER COLUMN `xbox_gamerscore` SET TAGS ('dbx_business_glossary_term' = 'Xbox Gamerscore');
ALTER TABLE `gaming_ecm`.`title`.`achievement` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` SET TAGS ('dbx_data_type' = 'Master');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` SET TAGS ('dbx_subdomain' = 'gameplay_experience');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `leaderboard_id` SET TAGS ('dbx_business_glossary_term' = 'Leaderboard ID');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `game_mode_id` SET TAGS ('dbx_business_glossary_term' = 'Game Mode ID');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `live_ops_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Live Ops Cycle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `seasonal_event_id` SET TAGS ('dbx_business_glossary_term' = 'Event ID');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `title_season_id` SET TAGS ('dbx_business_glossary_term' = 'Season ID');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `parent_leaderboard_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `anti_cheat_enabled` SET TAGS ('dbx_business_glossary_term' = 'Anti-Cheat Enabled');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `api_endpoint` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Endpoint');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `display_order` SET TAGS ('dbx_business_glossary_term' = 'Display Order');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `display_percentile` SET TAGS ('dbx_business_glossary_term' = 'Display Percentile');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `display_player_count` SET TAGS ('dbx_business_glossary_term' = 'Display Player Count');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `is_featured` SET TAGS ('dbx_business_glossary_term' = 'Is Featured');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `last_reset_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reset Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `leaderboard_code` SET TAGS ('dbx_business_glossary_term' = 'Leaderboard Code');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `leaderboard_description` SET TAGS ('dbx_business_glossary_term' = 'Leaderboard Description');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `leaderboard_name` SET TAGS ('dbx_business_glossary_term' = 'Leaderboard Name');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `leaderboard_status` SET TAGS ('dbx_business_glossary_term' = 'Leaderboard Status');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `leaderboard_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived|scheduled');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `leaderboard_type` SET TAGS ('dbx_business_glossary_term' = 'Leaderboard Type');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `leaderboard_type` SET TAGS ('dbx_value_regex' = 'global|regional|friends|guild|seasonal|event');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `manual_review_required` SET TAGS ('dbx_business_glossary_term' = 'Manual Review Required');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `max_rank_displayed` SET TAGS ('dbx_business_glossary_term' = 'Maximum Rank Displayed');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `min_matches_played` SET TAGS ('dbx_business_glossary_term' = 'Minimum Matches Played');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `min_player_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Player Level');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `next_reset_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Next Reset Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `platform_scope` SET TAGS ('dbx_business_glossary_term' = 'Platform Scope');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `ranking_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Ranking Algorithm');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `ranking_algorithm` SET TAGS ('dbx_value_regex' = 'elo|glicko|trueskill|points|time|score');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `ranking_metric` SET TAGS ('dbx_business_glossary_term' = 'Ranking Metric');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `region_scope` SET TAGS ('dbx_business_glossary_term' = 'Region Scope');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `reset_cadence` SET TAGS ('dbx_business_glossary_term' = 'Reset Cadence');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `reset_cadence` SET TAGS ('dbx_value_regex' = 'never|daily|weekly|monthly|seasonal|event');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `reset_day_of_week` SET TAGS ('dbx_business_glossary_term' = 'Reset Day of Week');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `reset_time_utc` SET TAGS ('dbx_business_glossary_term' = 'Reset Time Universal Time Coordinated (UTC)');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `reward_distribution_flag` SET TAGS ('dbx_business_glossary_term' = 'Reward Distribution Flag');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `reward_tier_count` SET TAGS ('dbx_business_glossary_term' = 'Reward Tier Count');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `sort_order` SET TAGS ('dbx_business_glossary_term' = 'Sort Order');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `sort_order` SET TAGS ('dbx_value_regex' = 'ascending|descending');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `tie_break_rule` SET TAGS ('dbx_business_glossary_term' = 'Tie Break Rule');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard_entry` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard_entry` SET TAGS ('dbx_subdomain' = 'gameplay_experience');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard_entry` SET TAGS ('dbx_association_edges' = 'player.player_account,title.leaderboard');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard_entry` ALTER COLUMN `leaderboard_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Leaderboard Entry ID');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard_entry` ALTER COLUMN `leaderboard_id` SET TAGS ('dbx_business_glossary_term' = 'Leaderboard Entry - Leaderboard Id');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard_entry` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Leaderboard Entry - Player Account Id');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard_entry` ALTER COLUMN `title_season_id` SET TAGS ('dbx_business_glossary_term' = 'Season ID');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard_entry` ALTER COLUMN `entry_status` SET TAGS ('dbx_business_glossary_term' = 'Entry Status');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard_entry` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard_entry` ALTER COLUMN `percentile` SET TAGS ('dbx_business_glossary_term' = 'Percentile');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard_entry` ALTER COLUMN `platform_code` SET TAGS ('dbx_business_glossary_term' = 'Platform Code');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard_entry` ALTER COLUMN `rank_position` SET TAGS ('dbx_business_glossary_term' = 'Rank Position');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard_entry` ALTER COLUMN `rank_tier` SET TAGS ('dbx_business_glossary_term' = 'Rank Tier');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard_entry` ALTER COLUMN `reward_claimed_flag` SET TAGS ('dbx_business_glossary_term' = 'Reward Claimed Flag');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard_entry` ALTER COLUMN `score_value` SET TAGS ('dbx_business_glossary_term' = 'Score Value');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard_entry` ALTER COLUMN `submission_count` SET TAGS ('dbx_business_glossary_term' = 'Submission Count');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard_entry` ALTER COLUMN `timestamp_achieved` SET TAGS ('dbx_business_glossary_term' = 'Timestamp Achieved');
ALTER TABLE `gaming_ecm`.`title`.`sku_deployment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `gaming_ecm`.`title`.`sku_deployment` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `gaming_ecm`.`title`.`sku_deployment` SET TAGS ('dbx_association_edges' = 'title.build_artifact,title.sku');
ALTER TABLE `gaming_ecm`.`title`.`sku_deployment` ALTER COLUMN `sku_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'SKU Deployment ID');
ALTER TABLE `gaming_ecm`.`title`.`sku_deployment` ALTER COLUMN `build_artifact_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Deployment - Build Artifact Id');
ALTER TABLE `gaming_ecm`.`title`.`sku_deployment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Deployed By User ID');
ALTER TABLE `gaming_ecm`.`title`.`sku_deployment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`sku_deployment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`sku_deployment` ALTER COLUMN `title_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Deployment - Sku Id');
ALTER TABLE `gaming_ecm`.`title`.`sku_deployment` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`sku_deployment` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `gaming_ecm`.`title`.`sku_deployment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`sku_deployment` ALTER COLUMN `deployment_date` SET TAGS ('dbx_business_glossary_term' = 'Deployment Date');
ALTER TABLE `gaming_ecm`.`title`.`sku_deployment` ALTER COLUMN `deployment_notes` SET TAGS ('dbx_business_glossary_term' = 'Deployment Notes');
ALTER TABLE `gaming_ecm`.`title`.`sku_deployment` ALTER COLUMN `deployment_status` SET TAGS ('dbx_business_glossary_term' = 'Deployment Status');
ALTER TABLE `gaming_ecm`.`title`.`sku_deployment` ALTER COLUMN `deployment_type` SET TAGS ('dbx_business_glossary_term' = 'Deployment Type');
ALTER TABLE `gaming_ecm`.`title`.`sku_deployment` ALTER COLUMN `is_active_build` SET TAGS ('dbx_business_glossary_term' = 'Is Active Build');
ALTER TABLE `gaming_ecm`.`title`.`sku_deployment` ALTER COLUMN `phased_rollout_percentage` SET TAGS ('dbx_business_glossary_term' = 'Phased Rollout Percentage');
ALTER TABLE `gaming_ecm`.`title`.`sku_deployment` ALTER COLUMN `rollback_flag` SET TAGS ('dbx_business_glossary_term' = 'Rollback Flag');
ALTER TABLE `gaming_ecm`.`title`.`sku_deployment` ALTER COLUMN `rollback_reason` SET TAGS ('dbx_business_glossary_term' = 'Rollback Reason');
ALTER TABLE `gaming_ecm`.`title`.`sku_deployment` ALTER COLUMN `rollback_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Rollback Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`sku_deployment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`title_cert_submission` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `gaming_ecm`.`title`.`title_cert_submission` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `gaming_ecm`.`title`.`title_cert_submission` SET TAGS ('dbx_association_edges' = 'title.game_title,platform.certification_checklist');
ALTER TABLE `gaming_ecm`.`title`.`title_cert_submission` ALTER COLUMN `title_cert_submission_id` SET TAGS ('dbx_business_glossary_term' = 'title_cert_submission Identifier');
ALTER TABLE `gaming_ecm`.`title`.`title_cert_submission` ALTER COLUMN `build_artifact_id` SET TAGS ('dbx_business_glossary_term' = 'Build Artifact Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`title_cert_submission` ALTER COLUMN `platform_cert_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Submission ID');
ALTER TABLE `gaming_ecm`.`title`.`title_cert_submission` ALTER COLUMN `certification_checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Cert Submission - Certification Checklist Id');
ALTER TABLE `gaming_ecm`.`title`.`title_cert_submission` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Cert Submission - Game Title Id');
ALTER TABLE `gaming_ecm`.`title`.`title_cert_submission` ALTER COLUMN `assigned_qa_lead` SET TAGS ('dbx_business_glossary_term' = 'Assigned QA Lead');
ALTER TABLE `gaming_ecm`.`title`.`title_cert_submission` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `gaming_ecm`.`title`.`title_cert_submission` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `gaming_ecm`.`title`.`title_cert_submission` ALTER COLUMN `estimated_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Completion Date');
ALTER TABLE `gaming_ecm`.`title`.`title_cert_submission` ALTER COLUMN `failure_categories` SET TAGS ('dbx_business_glossary_term' = 'Failure Categories');
ALTER TABLE `gaming_ecm`.`title`.`title_cert_submission` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Submission Notes');
ALTER TABLE `gaming_ecm`.`title`.`title_cert_submission` ALTER COLUMN `platform_holder_ticket_reference` SET TAGS ('dbx_business_glossary_term' = 'Platform Holder Ticket ID');
ALTER TABLE `gaming_ecm`.`title`.`title_cert_submission` ALTER COLUMN `resubmission_count` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Count');
ALTER TABLE `gaming_ecm`.`title`.`title_cert_submission` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `gaming_ecm`.`title`.`title_cert_submission` ALTER COLUMN `waiver_count` SET TAGS ('dbx_business_glossary_term' = 'Waiver Count');
ALTER TABLE `gaming_ecm`.`title`.`ip_usage` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `gaming_ecm`.`title`.`ip_usage` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `gaming_ecm`.`title`.`ip_usage` SET TAGS ('dbx_association_edges' = 'title.game_title,licensing.licensed_ip');
ALTER TABLE `gaming_ecm`.`title`.`ip_usage` ALTER COLUMN `ip_usage_id` SET TAGS ('dbx_business_glossary_term' = 'Title IP Usage ID');
ALTER TABLE `gaming_ecm`.`title`.`ip_usage` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Ip Usage - Game Title Id');
ALTER TABLE `gaming_ecm`.`title`.`ip_usage` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Title Ip Usage - Licensed Ip Id');
ALTER TABLE `gaming_ecm`.`title`.`ip_usage` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `gaming_ecm`.`title`.`ip_usage` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `gaming_ecm`.`title`.`ip_usage` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `gaming_ecm`.`title`.`ip_usage` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `gaming_ecm`.`title`.`ip_usage` ALTER COLUMN `minimum_guarantee_paid` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee Paid');
ALTER TABLE `gaming_ecm`.`title`.`ip_usage` ALTER COLUMN `minimum_guarantee_paid` SET TAGS ('dbx_financial' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`ip_usage` ALTER COLUMN `revenue_attributed` SET TAGS ('dbx_business_glossary_term' = 'Revenue Attributed to IP');
ALTER TABLE `gaming_ecm`.`title`.`ip_usage` ALTER COLUMN `revenue_attributed` SET TAGS ('dbx_financial' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`ip_usage` ALTER COLUMN `royalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Title-Specific Royalty Rate');
ALTER TABLE `gaming_ecm`.`title`.`ip_usage` ALTER COLUMN `territory_override` SET TAGS ('dbx_business_glossary_term' = 'Territory Override');
ALTER TABLE `gaming_ecm`.`title`.`ip_usage` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `gaming_ecm`.`title`.`ip_usage` ALTER COLUMN `usage_scope` SET TAGS ('dbx_business_glossary_term' = 'Usage Scope');
ALTER TABLE `gaming_ecm`.`title`.`ip_usage` ALTER COLUMN `usage_status` SET TAGS ('dbx_business_glossary_term' = 'Usage Status');
ALTER TABLE `gaming_ecm`.`title`.`studio_contribution` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `gaming_ecm`.`title`.`studio_contribution` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `gaming_ecm`.`title`.`studio_contribution` SET TAGS ('dbx_association_edges' = 'title.game_title,studio.game_studio');
ALTER TABLE `gaming_ecm`.`title`.`studio_contribution` ALTER COLUMN `studio_contribution_id` SET TAGS ('dbx_business_glossary_term' = 'Title Studio Contribution ID');
ALTER TABLE `gaming_ecm`.`title`.`studio_contribution` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Title Studio Contribution - Game Studio Id');
ALTER TABLE `gaming_ecm`.`title`.`studio_contribution` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Studio Contribution - Game Title Id');
ALTER TABLE `gaming_ecm`.`title`.`studio_contribution` ALTER COLUMN `budget_allocated_usd` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocated USD');
ALTER TABLE `gaming_ecm`.`title`.`studio_contribution` ALTER COLUMN `budget_allocated_usd` SET TAGS ('dbx_financial' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`studio_contribution` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `gaming_ecm`.`title`.`studio_contribution` ALTER COLUMN `contribution_percentage` SET TAGS ('dbx_business_glossary_term' = 'Contribution Percentage');
ALTER TABLE `gaming_ecm`.`title`.`studio_contribution` ALTER COLUMN `contribution_status` SET TAGS ('dbx_business_glossary_term' = 'Contribution Status');
ALTER TABLE `gaming_ecm`.`title`.`studio_contribution` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`studio_contribution` ALTER COLUMN `development_role` SET TAGS ('dbx_business_glossary_term' = 'Development Role');
ALTER TABLE `gaming_ecm`.`title`.`studio_contribution` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Contribution End Date');
ALTER TABLE `gaming_ecm`.`title`.`studio_contribution` ALTER COLUMN `ip_rights_share` SET TAGS ('dbx_business_glossary_term' = 'IP Rights Share');
ALTER TABLE `gaming_ecm`.`title`.`studio_contribution` ALTER COLUMN `primary_deliverable` SET TAGS ('dbx_business_glossary_term' = 'Primary Deliverable');
ALTER TABLE `gaming_ecm`.`title`.`studio_contribution` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `gaming_ecm`.`title`.`studio_contribution` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_financial' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`studio_contribution` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Contribution Start Date');
ALTER TABLE `gaming_ecm`.`title`.`studio_contribution` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`edition_content_bundle` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `gaming_ecm`.`title`.`edition_content_bundle` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `gaming_ecm`.`title`.`edition_content_bundle` SET TAGS ('dbx_association_edges' = 'title.game_edition,title.dlc_bundle');
ALTER TABLE `gaming_ecm`.`title`.`edition_content_bundle` ALTER COLUMN `edition_content_bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Edition Content Bundle ID');
ALTER TABLE `gaming_ecm`.`title`.`edition_content_bundle` ALTER COLUMN `dlc_bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Edition Content Bundle - Dlc Bundle Id');
ALTER TABLE `gaming_ecm`.`title`.`edition_content_bundle` ALTER COLUMN `game_edition_id` SET TAGS ('dbx_business_glossary_term' = 'Edition Content Bundle - Game Edition Id');
ALTER TABLE `gaming_ecm`.`title`.`edition_content_bundle` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`edition_content_bundle` ALTER COLUMN `display_order` SET TAGS ('dbx_business_glossary_term' = 'Display Order');
ALTER TABLE `gaming_ecm`.`title`.`edition_content_bundle` ALTER COLUMN `edition_content_bundle_status` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Status');
ALTER TABLE `gaming_ecm`.`title`.`edition_content_bundle` ALTER COLUMN `inclusion_date` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Date');
ALTER TABLE `gaming_ecm`.`title`.`edition_content_bundle` ALTER COLUMN `is_default_unlocked` SET TAGS ('dbx_business_glossary_term' = 'Default Unlocked Flag');
ALTER TABLE `gaming_ecm`.`title`.`edition_content_bundle` ALTER COLUMN `is_pre_order_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Pre-Order Exclusive Flag');
ALTER TABLE `gaming_ecm`.`title`.`edition_content_bundle` ALTER COLUMN `unlock_method` SET TAGS ('dbx_business_glossary_term' = 'Unlock Method');
ALTER TABLE `gaming_ecm`.`title`.`edition_content_bundle` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`mode_map_availability` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `gaming_ecm`.`title`.`mode_map_availability` SET TAGS ('dbx_subdomain' = 'gameplay_experience');
ALTER TABLE `gaming_ecm`.`title`.`mode_map_availability` SET TAGS ('dbx_association_edges' = 'title.game_mode,content.level_map');
ALTER TABLE `gaming_ecm`.`title`.`mode_map_availability` ALTER COLUMN `mode_map_availability_id` SET TAGS ('dbx_business_glossary_term' = 'Mode-Map Availability Identifier');
ALTER TABLE `gaming_ecm`.`title`.`mode_map_availability` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modifying User Identifier');
ALTER TABLE `gaming_ecm`.`title`.`mode_map_availability` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`mode_map_availability` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`mode_map_availability` ALTER COLUMN `game_mode_id` SET TAGS ('dbx_business_glossary_term' = 'Mode Map Availability - Game Mode Id');
ALTER TABLE `gaming_ecm`.`title`.`mode_map_availability` ALTER COLUMN `level_map_id` SET TAGS ('dbx_business_glossary_term' = 'Mode Map Availability - Level Map Id');
ALTER TABLE `gaming_ecm`.`title`.`mode_map_availability` ALTER COLUMN `availability_end_date` SET TAGS ('dbx_business_glossary_term' = 'Availability End Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`mode_map_availability` ALTER COLUMN `availability_start_date` SET TAGS ('dbx_business_glossary_term' = 'Availability Start Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`mode_map_availability` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`mode_map_availability` ALTER COLUMN `is_featured` SET TAGS ('dbx_business_glossary_term' = 'Featured Status Flag');
ALTER TABLE `gaming_ecm`.`title`.`mode_map_availability` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`mode_map_availability` ALTER COLUMN `mode_map_availability_status` SET TAGS ('dbx_business_glossary_term' = 'Pairing Status');
ALTER TABLE `gaming_ecm`.`title`.`mode_map_availability` ALTER COLUMN `playlist_weight` SET TAGS ('dbx_business_glossary_term' = 'Playlist Selection Weight');
ALTER TABLE `gaming_ecm`.`title`.`mode_map_availability` ALTER COLUMN `rotation_order` SET TAGS ('dbx_business_glossary_term' = 'Playlist Rotation Order');
ALTER TABLE `gaming_ecm`.`title`.`title_campaign` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `gaming_ecm`.`title`.`title_campaign` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `gaming_ecm`.`title`.`title_campaign` SET TAGS ('dbx_association_edges' = 'title.game_title,marketing.influencer');
ALTER TABLE `gaming_ecm`.`title`.`title_campaign` ALTER COLUMN `title_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'title_campaign Identifier');
ALTER TABLE `gaming_ecm`.`title`.`title_campaign` ALTER COLUMN `marketing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier');
ALTER TABLE `gaming_ecm`.`title`.`title_campaign` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign - Game Title Id');
ALTER TABLE `gaming_ecm`.`title`.`title_campaign` ALTER COLUMN `influencer_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign - Influencer Id');
ALTER TABLE `gaming_ecm`.`title`.`title_campaign` ALTER COLUMN `title_season_id` SET TAGS ('dbx_business_glossary_term' = 'Title Season Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`title_campaign` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign Activation Date');
ALTER TABLE `gaming_ecm`.`title`.`title_campaign` ALTER COLUMN `budget` SET TAGS ('dbx_business_glossary_term' = 'Campaign Budget');
ALTER TABLE `gaming_ecm`.`title`.`title_campaign` ALTER COLUMN `campaign_status` SET TAGS ('dbx_business_glossary_term' = 'Campaign Status');
ALTER TABLE `gaming_ecm`.`title`.`title_campaign` ALTER COLUMN `content_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Content Approval Status');
ALTER TABLE `gaming_ecm`.`title`.`title_campaign` ALTER COLUMN `content_type` SET TAGS ('dbx_business_glossary_term' = 'Content Type');
ALTER TABLE `gaming_ecm`.`title`.`title_campaign` ALTER COLUMN `cpi` SET TAGS ('dbx_business_glossary_term' = 'Campaign Cost Per Install');
ALTER TABLE `gaming_ecm`.`title`.`title_campaign` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`title`.`title_campaign` ALTER COLUMN `deliverables_count` SET TAGS ('dbx_business_glossary_term' = 'Deliverables Count');
ALTER TABLE `gaming_ecm`.`title`.`title_campaign` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign End Date');
ALTER TABLE `gaming_ecm`.`title`.`title_campaign` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Campaign Exclusivity Flag');
ALTER TABLE `gaming_ecm`.`title`.`title_campaign` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Campaign Notes');
ALTER TABLE `gaming_ecm`.`title`.`title_campaign` ALTER COLUMN `performance_tier` SET TAGS ('dbx_business_glossary_term' = 'Campaign Performance Tier');
ALTER TABLE `gaming_ecm`.`title`.`title_campaign` ALTER COLUMN `roas` SET TAGS ('dbx_business_glossary_term' = 'Campaign Return on Ad Spend');
ALTER TABLE `gaming_ecm`.`title`.`title_campaign` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign Start Date');
ALTER TABLE `gaming_ecm`.`title`.`title_campaign` ALTER COLUMN `total_clicks` SET TAGS ('dbx_business_glossary_term' = 'Total Campaign Clicks');
ALTER TABLE `gaming_ecm`.`title`.`title_campaign` ALTER COLUMN `total_installs` SET TAGS ('dbx_business_glossary_term' = 'Total Campaign Installs');
ALTER TABLE `gaming_ecm`.`title`.`title_campaign` ALTER COLUMN `total_views` SET TAGS ('dbx_business_glossary_term' = 'Total Campaign Views');
ALTER TABLE `gaming_ecm`.`title`.`publishing_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `gaming_ecm`.`title`.`publishing_agreement` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `gaming_ecm`.`title`.`publishing_agreement` SET TAGS ('dbx_association_edges' = 'title.game_title,finance.legal_entity');
ALTER TABLE `gaming_ecm`.`title`.`publishing_agreement` ALTER COLUMN `publishing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Publishing Agreement Identifier');
ALTER TABLE `gaming_ecm`.`title`.`publishing_agreement` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Publishing Agreement - Game Title Id');
ALTER TABLE `gaming_ecm`.`title`.`publishing_agreement` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Publishing Agreement - Legal Entity Id');
ALTER TABLE `gaming_ecm`.`title`.`publishing_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `gaming_ecm`.`title`.`publishing_agreement` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `gaming_ecm`.`title`.`publishing_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`publishing_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Effective Date');
ALTER TABLE `gaming_ecm`.`title`.`publishing_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Expiry Date');
ALTER TABLE `gaming_ecm`.`title`.`publishing_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`publishing_agreement` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee Amount');
ALTER TABLE `gaming_ecm`.`title`.`publishing_agreement` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`publishing_agreement` ALTER COLUMN `minimum_guarantee_currency` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee Currency');
ALTER TABLE `gaming_ecm`.`title`.`publishing_agreement` ALTER COLUMN `publishing_rights_type` SET TAGS ('dbx_business_glossary_term' = 'Publishing Rights Type');
ALTER TABLE `gaming_ecm`.`title`.`publishing_agreement` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `gaming_ecm`.`title`.`publishing_agreement` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`publishing_agreement` ALTER COLUMN `territory_scope` SET TAGS ('dbx_business_glossary_term' = 'Territory Scope');
ALTER TABLE `gaming_ecm`.`title`.`playable_character` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`title`.`playable_character` SET TAGS ('dbx_subdomain' = 'gameplay_experience');
ALTER TABLE `gaming_ecm`.`title`.`playable_character` ALTER COLUMN `playable_character_id` SET TAGS ('dbx_business_glossary_term' = 'Playable Character Identifier');
ALTER TABLE `gaming_ecm`.`title`.`playable_character` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`playable_character` ALTER COLUMN `title_season_id` SET TAGS ('dbx_business_glossary_term' = 'Title Season Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`playable_character` ALTER COLUMN `evolved_from_playable_character_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`playable_character` ALTER COLUMN `intellectual_property_owner` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`playable_character` ALTER COLUMN `licensing_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`checkpoint` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`title`.`checkpoint` SET TAGS ('dbx_subdomain' = 'gameplay_experience');
ALTER TABLE `gaming_ecm`.`title`.`checkpoint` ALTER COLUMN `checkpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Checkpoint Identifier');
ALTER TABLE `gaming_ecm`.`title`.`checkpoint` ALTER COLUMN `dlc_bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Dlc Bundle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`checkpoint` ALTER COLUMN `title_season_id` SET TAGS ('dbx_business_glossary_term' = 'Title Season Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`checkpoint` ALTER COLUMN `previous_checkpoint_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`mission` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`title`.`mission` SET TAGS ('dbx_subdomain' = 'gameplay_experience');
ALTER TABLE `gaming_ecm`.`title`.`mission` ALTER COLUMN `mission_id` SET TAGS ('dbx_business_glossary_term' = 'Mission Identifier');
ALTER TABLE `gaming_ecm`.`title`.`mission` ALTER COLUMN `prerequisite_mission_id` SET TAGS ('dbx_self_ref_fk' = 'true');
