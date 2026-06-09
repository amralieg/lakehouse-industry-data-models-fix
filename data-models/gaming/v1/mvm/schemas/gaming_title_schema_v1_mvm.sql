-- Schema for Domain: title | Business: Gaming | Version: v1_mvm
-- Generated on: 2026-05-08 09:46:28

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `gaming_ecm`.`title` COMMENT 'Master catalog of all game titles, SKUs, editions, versions, builds, releases, and DLC/content bundles published or distributed. Owns the game product lifecycle from concept greenlight through gold master, platform certification (TRC/TCR), ESRB/PEGI/CERO ratings, genre classification, IP ownership, and end-of-life. The authoritative SSOT for WHAT the business offers across all storefronts.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `gaming_ecm`.`title`.`game_title` (
    `game_title_id` BIGINT COMMENT 'Unique identifier for the game title. Primary key for the master catalog of all game intellectual property (IP) published or distributed by Gaming.',
    `franchise_id` BIGINT COMMENT 'Reference to the parent franchise or series to which this game title belongs. Enables franchise-level analytics and IP portfolio management.',
    `game_studio_id` BIGINT COMMENT 'Foreign key linking to studio.game_studio. Business justification: Every game title is developed and published by a studio — fundamental for royalty reporting, IP ownership attribution, and developer/publisher contract management. Titles without a franchise have no p',
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
    `steam_app_code` STRING COMMENT 'The unique application identifier assigned by Valve for distribution on the Steam platform. Used for sales tracking, API integration, and platform analytics.',
    `supported_platforms` STRING COMMENT 'Comma-separated list of platforms on which this game title is available or planned for release (e.g., PlayStation 5, Xbox Series X, PC, Nintendo Switch, iOS, Android). Critical for platform certification tracking and distribution planning.',
    `target_age_max` STRING COMMENT 'The maximum age of the intended player demographic for marketing and design purposes. Used for player acquisition targeting and content design decisions.',
    `target_age_min` STRING COMMENT 'The minimum age of the intended player demographic for marketing and design purposes. May differ from regulatory ratings. Used for player acquisition targeting and content design decisions.',
    `working_title` STRING COMMENT 'Internal codename or working title used during development before the official title name is finalized. Used for project tracking and confidentiality during pre-announcement phases.',
    CONSTRAINT pk_game_title PRIMARY KEY(`game_title_id`)
) COMMENT 'Master catalog record for every game title (IP) published or distributed by Gaming. Represents the top-level intellectual property entity and the authoritative SSOT for a games identity across all storefronts and systems. Key attributes: official title name, working title, franchise reference, primary/secondary genre classification, IP ownership entity, business model (F2P, premium, hybrid, subscription), GaaS flag, supported platforms, game modes (campaign, multiplayer, co-op, battle royale, sandbox), player count range, online/offline capability, cross-play support, engine/technology reference, and overall lifecycle stage. All SKUs, editions, builds, DLC bundles, seasons, and territory rights roll up to this entity.';

CREATE OR REPLACE TABLE `gaming_ecm`.`title`.`title_sku` (
    `title_sku_id` BIGINT COMMENT 'Unique identifier for the SKU record. Primary key.',
    `build_id` BIGINT COMMENT 'Foreign key linking to studio.build. Business justification: Platform certification audits and recall/rollback decisions require tracing exactly which build a SKU was certified against. QA and cert teams use this link to validate that the distributed SKU matche',
    `consent_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.consent_policy. Business justification: SKU checkout and storefront listing flows must reference the active consent policy governing that SKUs sale — especially for age-gated, loot box, or microtransaction SKUs. Compliance audits require k',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to title.content_rating. Business justification: title_sku carries age_rating_code as a denormalized STRING. The content_rating table is the authoritative SSOT for official age ratings per game title within this domain. A SKU is sold in a specific r',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: SKU activation management: storefront and release operations teams track which content_release made each title_sku live on a platform. Required for go-live reconciliation, rollback decisions, and plat',
    `game_edition_id` BIGINT COMMENT 'Foreign key linking to title.game_edition. Business justification: A SKU represents a specific purchasable variant of a game edition. Each SKU belongs to one edition tier (Standard, Deluxe, Ultimate, etc.). The current edition_type STRING field should be replaced wit',
    `game_title_id` BIGINT COMMENT 'Reference to the parent game title that this SKU belongs to.',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to platform.storefront. Business justification: Title SKU distribution is storefront-specific — pricing, availability windows, and DRM type are all configured per storefront. Publishing operations teams need this FK to manage SKU availability and c',
    `age_gate_required_flag` BOOLEAN COMMENT 'Indicates whether age verification is required before purchase or download of this SKU.',
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
    `upc_code` STRING COMMENT '12-digit Universal Product Code for physical SKU variants, used for retail inventory and point-of-sale systems.. Valid values are `^[0-9]{12}$`',
    CONSTRAINT pk_title_sku PRIMARY KEY(`title_sku_id`)
) COMMENT 'Stock Keeping Unit record representing a distinct purchasable or distributable product variant of a game title. Each SKU maps to a specific edition (Standard, Deluxe, Ultimate, GOTY), platform (PS5, Xbox Series X, PC-Steam, iOS, Android), region, and distribution channel (digital, physical). Tracks MSRP, regional pricing tier, release date per storefront, availability window, age-gate flag, and SKU lifecycle status. The SSOT for what is listed and sold on any storefront.';

CREATE OR REPLACE TABLE `gaming_ecm`.`title`.`game_edition` (
    `game_edition_id` BIGINT COMMENT 'Unique identifier for the game edition. Primary key for the game edition entity.',
    `age_rating_cert_id` BIGINT COMMENT 'Foreign key linking to compliance.age_rating_cert. Business justification: Collectors or Deluxe editions with bonus mature content may require a different age rating cert than the Standard Edition. Edition-level cert tracking is required for storefront compliance and region',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: Edition delivery tracking: product managers track which content_release delivered each game_editions content package (Deluxe, Ultimate, etc.) to storefronts. Required for edition-level rollback decis',
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
    `age_rating_cert_id` BIGINT COMMENT 'Foreign key linking to compliance.age_rating_cert. Business justification: Rating bodies (ESRB, PEGI) issue certs against specific submitted builds. build_artifact has submitted_for_cert_timestamp and cert_approved_timestamp, confirming the build is the unit of certification',
    `asset_bundle_id` BIGINT COMMENT 'Foreign key linking to content.asset_bundle. Business justification: Build artifacts package asset bundles for deployment. Build pipelines, certification submissions, and rollback procedures require tracking which asset bundles are included in each build version.',
    `build_id` BIGINT COMMENT 'Foreign key reference to the parent build entity that tracks high-level build metadata. Links this artifact to the broader build management system.',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: Build-to-release deployment tracking: release engineering tracks which content_release consumed each build_artifact for deployment. Required for rollback decisions (identifying which build_artifact to',
    `game_title_id` BIGINT COMMENT 'Foreign key reference to the game title for which this build artifact was created. Links this build to the master game product catalog.',
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
    `age_rating_cert_id` BIGINT COMMENT 'Foreign key linking to compliance.age_rating_cert. Business justification: Release management gates go-live on a valid age rating certificate for the target region/platform. Compliance and release teams need to trace which cert authorized each release event. No existing FK c',
    `build_artifact_id` BIGINT COMMENT 'Foreign key linking to title.build_artifact. Business justification: A title release event deploys a specific build artifact to a platform/storefront. Currently title_release.build_id points to studio.build (cross-domain). Within the title domain, the authoritative bui',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign associated with this release event.',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to title.content_rating. Business justification: title_release stores content_rating (STRING) and content_rating_authority (STRING) as denormalized fields. The content_rating table is the authoritative record for official ratings including certifica',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: Release reconciliation: title_release records the platform go-live event; content_release is the content delivery mechanism backing it. Release engineering teams link these to reconcile platform certi',
    `developer_account_id` BIGINT COMMENT 'Foreign key linking to platform.developer_account. Business justification: Every title release is submitted and managed through a platform developer account — this is the core platform publishing workflow. Release management reports and platform submission audits require kno',
    `milestone_id` BIGINT COMMENT 'Foreign key linking to studio.milestone. Business justification: A title_release is gated by a milestone (gold master sign-off, cert approval). Release gate compliance reporting requires tracing which milestone authorized a given release. Publisher-facing milestone',
    `storefront_id` BIGINT COMMENT 'Reference to the target gaming platform (console, PC, mobile) for this release.',
    `actual_release_date` DATE COMMENT 'Actual date when the title release went live on the target platform and storefront. Null if not yet released.',
    `announcement_url` STRING COMMENT 'URL to the public release announcement or blog post for this release.',
    `certification_approval_date` DATE COMMENT 'Date when the platform holder approved the build for release. Null if not yet approved.',
    `certification_status` STRING COMMENT 'Platform certification status indicating compliance with Technical Requirements Checklist (TRC) or Technical Certification Requirements (TCR) for console releases.. Valid values are `not_submitted|submitted|in_review|approved|rejected|waived`',
    `certification_submission_date` DATE COMMENT 'Date when the build was submitted to the platform holder for certification review.',
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
    `age_rating_cert_id` BIGINT COMMENT 'Foreign key linking to compliance.age_rating_cert. Business justification: DLC bundles with mature content require separate age rating certification in jurisdictions like PEGI/ESRB when content exceeds the base game rating. dlc_bundle has certification_status and certificati',
    `asset_bundle_id` BIGINT COMMENT 'Foreign key linking to content.asset_bundle. Business justification: DLC bundles are distributed as asset bundles to players. Content delivery systems, storefront integration, and CDN distribution workflows depend on linking DLC products to their packaged asset bundles',
    `build_id` BIGINT COMMENT 'Foreign key linking to studio.build. Business justification: DLC releases require specific build tracking for deployment, certification submission, and version management. Critical for live ops release planning and platform certification workflows in GaaS title',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign associated with this DLC launch. Used for attribution, ROI tracking, and cross-channel campaign coordination.',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to title.content_rating. Business justification: dlc_bundle carries content_rating (STRING) as a denormalized field. DLC bundles receive their own content ratings from rating authorities (e.g., a DLC with mature content may have a separate ESRB rati',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: DLC delivery tracking: live-ops and monetization teams track which content_release published each DLC bundle to players. Essential for DLC rollback, revenue recognition timing, and platform certificat',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to studio.dev_project. Business justification: DLC developed as sub-projects or within main project scope. Critical for content roadmap planning, resource allocation, milestone tracking, and coordinating DLC certification with base game updates.',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to platform.storefront. Business justification: DLC platform exclusivity is a contractual and commercial arrangement tracked per storefront. Publishing and licensing teams need this FK to enforce exclusivity windows, manage timed exclusives, and re',
    `game_studio_id` BIGINT COMMENT 'Foreign key linking to studio.game_studio. Business justification: DLC may be developed by different studio than base game (outsourcing, co-development). Critical for multi-studio coordination, IP rights management, revenue sharing, and tracking studio-specific DLC p',
    `game_title_id` BIGINT COMMENT 'Reference to the parent game title that this DLC bundle is associated with. Links the DLC to its base game.',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: DLC often contains licensed content (music packs, branded cosmetics, celebrity likenesses). Required for royalty calculation per DLC sale and content rights verification.',
    `title_season_id` BIGINT COMMENT 'Foreign key linking to title.title_season. Business justification: DLC bundles are often part of a live-service season (season pass content, seasonal events). Currently dlc_bundle.season_number is an INT with no referential integrity. Adding title_season_id FK normal',
    `base_price_usd` DECIMAL(18,2) COMMENT 'The standard retail price of the DLC bundle in US dollars before any regional pricing adjustments or promotional discounts.',
    `battle_pass_tier` STRING COMMENT 'The tier level within a battle pass system where this bundle is unlocked. Nullable for non-battle-pass content. Used for progression and monetization design.',
    `bundle_code` STRING COMMENT 'Unique alphanumeric code used for internal tracking, SKU management, and platform certification. The externally-known identifier for this DLC bundle.. Valid values are `^[A-Z0-9_-]{4,20}$`',
    `bundle_name` STRING COMMENT 'The marketing name of the DLC bundle as displayed in storefronts and in-game menus. Human-readable identifier for the content offering.',
    `bundle_status` STRING COMMENT 'Current lifecycle status of the DLC bundle from concept through retirement. Tracks the bundle through development, certification, release, and end-of-life phases. [ENUM-REF-CANDIDATE: concept|in_development|submitted_for_cert|certified|released|deprecated|retired — 7 candidates stripped; promote to reference product]',
    `certification_date` DATE COMMENT 'The date when the DLC bundle received final platform certification approval. Nullable until certification is complete. Used for release readiness tracking.',
    `certification_status` STRING COMMENT 'Current status of platform certification process (TRC/TCR compliance). Tracks progress through first-party approval gates required for release.. Valid values are `not_submitted|submitted|in_review|approved|rejected|resubmitted`',
    `content_descriptors` STRING COMMENT 'Comma-separated list of content warning descriptors (violence, language, blood, etc.) as defined by rating boards. Required for platform certification and consumer transparency.',
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
    `exclusivity_end_date` DATE COMMENT 'The date when platform exclusivity expires and the DLC becomes available on other platforms. Nullable for permanent exclusives. Used for release planning.',
    `file_size_mb` DECIMAL(18,2) COMMENT 'Total download size of the DLC bundle in megabytes. Critical for player bandwidth planning and platform storage requirements.',
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
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to studio.dev_project. Business justification: Rating certification submissions are initiated by a dev project team. Compliance teams track which project submission produced which rating certificate for regulatory audit trails (ESRB, PEGI, CERO). ',
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

CREATE OR REPLACE TABLE `gaming_ecm`.`title`.`franchise` (
    `franchise_id` BIGINT COMMENT 'Unique identifier for the game franchise or intellectual property (IP) family. Primary key.',
    `game_studio_id` BIGINT COMMENT 'Reference to the primary game studio or development organization responsible for the franchise. Links to the studio master data for organizational hierarchy and resource allocation.',
    `genre_classification_id` BIGINT COMMENT 'Foreign key linking to title.genre_classification. Business justification: Franchises have a primary genre identity (e.g., Call of Duty = Shooter, FIFA = Sports). Currently franchise.primary_genre is a STRING. Adding primary_genre_id FK to genre_classification normalizes fra',
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

CREATE OR REPLACE TABLE `gaming_ecm`.`title`.`title_season` (
    `title_season_id` BIGINT COMMENT 'Unique identifier for the title season. Primary key for the title_season product.',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: Season launch tracking: each title_season is activated via a content_release drop. Live-ops teams link these for season scheduling, rollback planning, and player communication. Existing FK covers seas',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to studio.dev_project. Business justification: A season is a major content deliverable managed as a dev project workstream. Season-level project reporting, headcount allocation per season, and milestone tracking require a direct season-to-project ',
    `game_title_id` BIGINT COMMENT 'Reference to the parent game title that this season belongs to. Links to the master game title catalog.',
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

CREATE OR REPLACE TABLE `gaming_ecm`.`title`.`game_mode` (
    `game_mode_id` BIGINT COMMENT 'Unique identifier for the game mode. Primary key for the game mode entity.',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: Mode introduction tracking: new or updated game modes are introduced via content_releases. Live-ops teams track which content_release activated each game_mode for rollback decisions, player changelog ',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to studio.dev_project. Business justification: Game modes are discrete deliverables owned by a dev project. Feature ownership tracking, mode-specific bug triage routing, and project scope reporting all require knowing which dev project built and o',
    `game_title_id` BIGINT COMMENT 'Reference to the parent game title that contains this mode. Links the mode to its owning title in the master catalog.',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: Game modes may use licensed IP (branded maps, celebrity characters). Required for usage tracking, content approval, and per-mode royalty calculation in live service games.',
    `parent_game_mode_id` BIGINT COMMENT 'Self-referencing FK on game_mode (parent_game_mode_id)',
    `title_season_id` BIGINT COMMENT 'Foreign key linking to title.title_season. Business justification: game_mode has a seasonal_flag (BOOLEAN) indicating the mode is tied to a live-service season, but no FK to title_season. For GaaS titles, seasonal game modes (e.g., a limited-time ranked mode, a seaso',
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
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: Achievement activation tracking: achievements are introduced or modified via content_releases. Achievement management and compliance teams (platform certification requires achievement lists per releas',
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
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: Leaderboard creation and reset tracking: leaderboards are established or reset as part of content_releases (season drops, major patches). Operations teams link these to schedule resets, manage eligibi',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to studio.dev_project. Business justification: Leaderboards developed as competitive features within projects. Required for backend system design, anti-cheat integration, ranking algorithm development, and esports infrastructure planning.',
    `game_mode_id` BIGINT COMMENT 'Reference to the specific game mode this leaderboard tracks (e.g., ranked PvP, time trial, battle royale).',
    `game_title_id` BIGINT COMMENT 'Reference to the game title this leaderboard belongs to.',
    `live_ops_cycle_id` BIGINT COMMENT 'Foreign key linking to studio.live_ops_cycle. Business justification: Leaderboards in GaaS titles reset and launch with live ops cycles. Essential for seasonal competitive content planning, player engagement tracking, and coordinating leaderboard rewards with content re',
    `parent_leaderboard_id` BIGINT COMMENT 'Self-referencing FK on leaderboard (parent_leaderboard_id)',
    `seasonal_event_id` BIGINT COMMENT 'Reference to the live event this leaderboard is associated with (null for non-event leaderboards).',
    `title_season_id` BIGINT COMMENT 'Reference to the game season this leaderboard is associated with (null for non-seasonal leaderboards).',
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

CREATE OR REPLACE TABLE `gaming_ecm`.`title`.`playable_character` (
    `playable_character_id` BIGINT COMMENT 'Primary key for playable_character',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to studio.dev_project. Business justification: Playable characters are content deliverables produced by a dev project (base game or DLC project). IP attribution, content ownership reporting, and bug triage for character-specific issues require kno',
    `dlc_bundle_id` BIGINT COMMENT 'Foreign key linking to title.dlc_bundle. Business justification: playable_character has unlock_method (STRING) and is_premium_exclusive (BOOLEAN) and is_limited_edition (BOOLEAN) indicating that characters can be unlocked via DLC purchase. The dlc_bundle table is t',
    `evolved_from_playable_character_id` BIGINT COMMENT 'Self-referencing FK on playable_character (evolved_from_playable_character_id)',
    `game_title_id` BIGINT COMMENT 'Foreign key linking to title.game_title. Business justification: playable_character does not have game_title_id in visible schema. Characters belong to specific game titles - this is a fundamental parent-child relationship. New FK needed. No redundant columns visib',
    `live_ops_cycle_id` BIGINT COMMENT 'Foreign key linking to studio.live_ops_cycle. Business justification: Characters introduced in a live_ops_cycle (seasonal character drops, battle pass unlocks) must be traceable to that cycle for content calendar management, revenue attribution per cycle, and live ops p',
    `asset_id` BIGINT COMMENT 'Foreign key linking to content.asset. Business justification: Character asset pipeline management: playable_character.character_model_asset_path is a denormalized string. A proper FK to content.asset enables LOD update tracking, platform certification asset vali',
    `title_season_id` BIGINT COMMENT 'Foreign key linking to title.title_season. Business justification: playable_character does not have title_season_id in visible schema. Business case: new characters are frequently released as seasonal content in GaaS titles (e.g., Season 2 introduces 3 new champions',
    `age_rating_restriction` STRING COMMENT 'Any specific age rating restrictions or content warnings associated with this characters design, dialogue, or abilities that may affect the games overall rating.',
    `base_attack_power` STRING COMMENT 'The starting attack damage value for the character at level 1 or base configuration.',
    `base_defense_rating` STRING COMMENT 'The starting defensive capability value for the character at level 1 or base configuration.',
    `base_health_points` STRING COMMENT 'The starting health points value for the character at level 1 or base configuration, used for game balance and design.',
    `base_speed_rating` STRING COMMENT 'The starting movement or action speed value for the character at level 1 or base configuration.',
    `character_class` STRING COMMENT 'The gameplay class or role of the character (e.g., warrior, mage, assassin, tank, support, marksman). Defines core gameplay mechanics and abilities.',
    `character_code` STRING COMMENT 'Internal unique alphanumeric code used to reference the character in game systems, configuration files, and APIs.',
    `character_description` STRING COMMENT 'A narrative description of the characters backstory, personality, and role in the game world, used for player engagement and marketing.',
    `character_icon_asset_path` STRING COMMENT 'The file system path or asset reference to the characters icon image used in UI, menus, and selection screens.',
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
    `playable_character_status` STRING COMMENT 'The current lifecycle status of the character in the games live environment.',
    `popularity_score` DECIMAL(18,2) COMMENT 'A calculated score representing the characters popularity among players, based on pick rate, win rate, and community engagement metrics.',
    `primary_weapon_type` STRING COMMENT 'The default or signature weapon type used by this character (e.g., sword, bow, staff, gun, fists).',
    `rarity_tier` STRING COMMENT 'The rarity classification of the character, typically affecting unlock difficulty, monetization strategy, and player desirability.',
    `release_date` DATE COMMENT 'The date when this character was first made available to players in the live game environment.',
    `special_ability_description` STRING COMMENT 'Detailed description of what the characters special ability does, including mechanics and effects.',
    `special_ability_name` STRING COMMENT 'The name of the characters signature or ultimate special ability.',
    `species` STRING COMMENT 'The species, race, or creature type of the character (e.g., human, elf, orc, robot, alien) as defined in the game universe.',
    `unlock_method` STRING COMMENT 'The primary method by which players can unlock or acquire this character.',
    `voice_actor_name` STRING COMMENT 'The name of the voice actor who provides the characters voice performance, used for credits and marketing.',
    CONSTRAINT pk_playable_character PRIMARY KEY(`playable_character_id`)
) COMMENT 'Master reference table for playable_character. Referenced by champion_character_id.';

CREATE OR REPLACE TABLE `gaming_ecm`.`title`.`edition_content_inclusion` (
    `edition_content_inclusion_id` BIGINT COMMENT 'Unique identifier for this edition-DLC inclusion record. Primary key.',
    `dlc_bundle_id` BIGINT COMMENT 'Foreign key linking to the DLC bundle included in this edition',
    `game_edition_id` BIGINT COMMENT 'Foreign key linking to the game edition that includes this DLC bundle',
    `created_by_user` STRING COMMENT 'Username or identifier of the product manager or system user who configured this content inclusion.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this inclusion record was created in the system.',
    `display_order` STRING COMMENT 'Numeric sort order for displaying this DLC bundle in the editions content list on storefronts and marketing materials. Lower numbers appear first.',
    `effective_date` DATE COMMENT 'The date when this DLC bundle becomes available to owners of this edition. May differ from edition launch date for timed releases or season pass content.',
    `expiration_date` DATE COMMENT 'Optional date when this DLC bundle inclusion expires (for timed exclusives or promotional bundles). Null for permanent inclusions.',
    `included_in_edition` STRING COMMENT 'Comma-separated list of game editions (Deluxe, Ultimate, Gold) that include this DLC bundle at no additional cost. Used for bundling and upsell strategies. [Moved from dlc_bundle: This STRING attribute on dlc_bundle is a denormalized representation of the M:N relationship. It stores a comma-separated list of edition names, which is a classic anti-pattern indicating an underlying many-to-many relationship that should be properly modeled in the association table. The association table replaces this denormalized field with proper relational structure.]',
    `inclusion_type` STRING COMMENT 'Classification of how this DLC is included in the edition (bundled at launch, pre-order bonus, season pass entitlement, early access window, timed exclusive). Drives entitlement logic and marketing messaging.',
    `is_primary_content` BOOLEAN COMMENT 'Indicates whether this DLC bundle is a primary selling point for this edition tier (featured in marketing) versus secondary/bonus content.',
    `price_contribution_usd` DECIMAL(18,2) COMMENT 'The estimated value contribution of this DLC bundle to the editions total MSRP in USD. Used for pricing analysis and value proposition calculations.',
    CONSTRAINT pk_edition_content_inclusion PRIMARY KEY(`edition_content_inclusion_id`)
) COMMENT 'This association product represents the bundling relationship between game editions and DLC bundles. It captures which DLC content bundles are included in which edition tiers, with attributes that define how the content is packaged and presented. Each record links one game_edition to one dlc_bundle with inclusion-specific metadata that exists only in the context of this bundling relationship.. Existence Justification: In gaming publishing, edition content bundling is a core commercial product configuration process. Publishers define edition tiers (Standard, Deluxe, Ultimate, Collectors) where each edition includes different combinations of DLC bundles, and the same DLC bundle (e.g., Year 1 Season Pass, Cosmetic Pack) is routinely included across multiple edition tiers with different inclusion terms. Product managers actively configure these bundles, track which content is in which editions, and manage inclusion-specific attributes like display order, inclusion type (pre-order bonus vs. bundled), and price contribution for value proposition analysis.';

CREATE OR REPLACE TABLE `gaming_ecm`.`title`.`mode_character_roster` (
    `mode_character_roster_id` BIGINT COMMENT 'Unique identifier for this mode-character roster configuration record. Primary key.',
    `game_mode_id` BIGINT COMMENT 'Foreign key linking to the game mode in which this character availability is defined',
    `playable_character_id` BIGINT COMMENT 'Foreign key linking to the playable character whose availability is being configured for this mode',
    `availability_status` STRING COMMENT 'Current availability status of this character in this mode. Values: available (playable), disabled (temporarily unavailable), banned (prohibited for competitive integrity), restricted (requires unlock).',
    `balance_override_version` STRING COMMENT 'Version identifier for mode-specific balance adjustments applied to this character in this mode. References a balance patch or configuration version that modifies character stats for this mode only.',
    `ban_rate_percentage` DECIMAL(18,2) COMMENT 'Calculated percentage representing how often this character is banned in this mode (for modes with draft/ban mechanics). Used for competitive balance analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this roster configuration record was first created in the system.',
    `effective_end_date` DATE COMMENT 'The date when this character was removed or disabled from this mode. Null if currently available. Used for limited-time events and competitive season rotations.',
    `effective_start_date` DATE COMMENT 'The date when this character became available in this mode. Used for tracking character roster changes over time and limited-time availability windows.',
    `is_default_available` BOOLEAN COMMENT 'Indicates whether this character is available by default in this mode (true) or requires unlock/purchase (false). Used for free-to-play roster management.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this roster configuration record was last modified in the system.',
    `pick_rate_percentage` DECIMAL(18,2) COMMENT 'Calculated percentage representing how often this character is selected in this mode. Used for balance analysis and esports meta tracking.',
    `unlock_requirement_override` STRING COMMENT 'Mode-specific unlock requirement for this character if it differs from the base game unlock. Examples: ranked_level_10, battle_pass_tier_25, premium_purchase. Null if base unlock applies.',
    `win_rate_percentage` DECIMAL(18,2) COMMENT 'Calculated win rate for this character in this mode. Used for balance monitoring and identifying overpowered/underpowered characters per mode.',
    CONSTRAINT pk_mode_character_roster PRIMARY KEY(`mode_character_roster_id`)
) COMMENT 'This association product represents the character availability and balance configuration between game modes and playable characters. It captures which characters are permitted in which game modes, with mode-specific balance overrides and unlock requirements. Each record links one game_mode to one playable_character with attributes that exist only in the context of this mode-character pairing.. Existence Justification: In live-service and competitive gaming, character roster management per game mode is a first-class operational entity. A single game mode (e.g., Ranked Competitive) has many playable characters available, and a single character (e.g., a specific hero) is available across many game modes (Campaign, Casual, Ranked, Limited-Time Events). The business actively manages this relationship through balance patches, competitive bans, unlock requirements, and limited-time availability windows.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `gaming_ecm`.`title`.`game_title` ADD CONSTRAINT `fk_title_game_title_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `gaming_ecm`.`title`.`franchise`(`franchise_id`);
ALTER TABLE `gaming_ecm`.`title`.`game_title` ADD CONSTRAINT `fk_title_game_title_genre_classification_id` FOREIGN KEY (`genre_classification_id`) REFERENCES `gaming_ecm`.`title`.`genre_classification`(`genre_classification_id`);
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ADD CONSTRAINT `fk_title_title_sku_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `gaming_ecm`.`title`.`content_rating`(`content_rating_id`);
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ADD CONSTRAINT `fk_title_title_sku_game_edition_id` FOREIGN KEY (`game_edition_id`) REFERENCES `gaming_ecm`.`title`.`game_edition`(`game_edition_id`);
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ADD CONSTRAINT `fk_title_title_sku_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`title`.`game_edition` ADD CONSTRAINT `fk_title_game_edition_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ADD CONSTRAINT `fk_title_build_artifact_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`title`.`title_release` ADD CONSTRAINT `fk_title_title_release_build_artifact_id` FOREIGN KEY (`build_artifact_id`) REFERENCES `gaming_ecm`.`title`.`build_artifact`(`build_artifact_id`);
ALTER TABLE `gaming_ecm`.`title`.`title_release` ADD CONSTRAINT `fk_title_title_release_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `gaming_ecm`.`title`.`content_rating`(`content_rating_id`);
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ADD CONSTRAINT `fk_title_dlc_bundle_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `gaming_ecm`.`title`.`content_rating`(`content_rating_id`);
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ADD CONSTRAINT `fk_title_dlc_bundle_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ADD CONSTRAINT `fk_title_dlc_bundle_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);
ALTER TABLE `gaming_ecm`.`title`.`content_rating` ADD CONSTRAINT `fk_title_content_rating_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`title`.`franchise` ADD CONSTRAINT `fk_title_franchise_genre_classification_id` FOREIGN KEY (`genre_classification_id`) REFERENCES `gaming_ecm`.`title`.`genre_classification`(`genre_classification_id`);
ALTER TABLE `gaming_ecm`.`title`.`genre_classification` ADD CONSTRAINT `fk_title_genre_classification_parent_genre_genre_classification_id` FOREIGN KEY (`parent_genre_genre_classification_id`) REFERENCES `gaming_ecm`.`title`.`genre_classification`(`genre_classification_id`);
ALTER TABLE `gaming_ecm`.`title`.`title_season` ADD CONSTRAINT `fk_title_title_season_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ADD CONSTRAINT `fk_title_game_mode_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ADD CONSTRAINT `fk_title_game_mode_parent_game_mode_id` FOREIGN KEY (`parent_game_mode_id`) REFERENCES `gaming_ecm`.`title`.`game_mode`(`game_mode_id`);
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ADD CONSTRAINT `fk_title_game_mode_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);
ALTER TABLE `gaming_ecm`.`title`.`achievement` ADD CONSTRAINT `fk_title_achievement_dlc_bundle_id` FOREIGN KEY (`dlc_bundle_id`) REFERENCES `gaming_ecm`.`title`.`dlc_bundle`(`dlc_bundle_id`);
ALTER TABLE `gaming_ecm`.`title`.`achievement` ADD CONSTRAINT `fk_title_achievement_game_mode_id` FOREIGN KEY (`game_mode_id`) REFERENCES `gaming_ecm`.`title`.`game_mode`(`game_mode_id`);
ALTER TABLE `gaming_ecm`.`title`.`achievement` ADD CONSTRAINT `fk_title_achievement_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`title`.`achievement` ADD CONSTRAINT `fk_title_achievement_prerequisite_achievement_id` FOREIGN KEY (`prerequisite_achievement_id`) REFERENCES `gaming_ecm`.`title`.`achievement`(`achievement_id`);
ALTER TABLE `gaming_ecm`.`title`.`achievement` ADD CONSTRAINT `fk_title_achievement_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ADD CONSTRAINT `fk_title_leaderboard_game_mode_id` FOREIGN KEY (`game_mode_id`) REFERENCES `gaming_ecm`.`title`.`game_mode`(`game_mode_id`);
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ADD CONSTRAINT `fk_title_leaderboard_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ADD CONSTRAINT `fk_title_leaderboard_parent_leaderboard_id` FOREIGN KEY (`parent_leaderboard_id`) REFERENCES `gaming_ecm`.`title`.`leaderboard`(`leaderboard_id`);
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ADD CONSTRAINT `fk_title_leaderboard_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);
ALTER TABLE `gaming_ecm`.`title`.`playable_character` ADD CONSTRAINT `fk_title_playable_character_dlc_bundle_id` FOREIGN KEY (`dlc_bundle_id`) REFERENCES `gaming_ecm`.`title`.`dlc_bundle`(`dlc_bundle_id`);
ALTER TABLE `gaming_ecm`.`title`.`playable_character` ADD CONSTRAINT `fk_title_playable_character_evolved_from_playable_character_id` FOREIGN KEY (`evolved_from_playable_character_id`) REFERENCES `gaming_ecm`.`title`.`playable_character`(`playable_character_id`);
ALTER TABLE `gaming_ecm`.`title`.`playable_character` ADD CONSTRAINT `fk_title_playable_character_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`title`.`playable_character` ADD CONSTRAINT `fk_title_playable_character_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);
ALTER TABLE `gaming_ecm`.`title`.`edition_content_inclusion` ADD CONSTRAINT `fk_title_edition_content_inclusion_dlc_bundle_id` FOREIGN KEY (`dlc_bundle_id`) REFERENCES `gaming_ecm`.`title`.`dlc_bundle`(`dlc_bundle_id`);
ALTER TABLE `gaming_ecm`.`title`.`edition_content_inclusion` ADD CONSTRAINT `fk_title_edition_content_inclusion_game_edition_id` FOREIGN KEY (`game_edition_id`) REFERENCES `gaming_ecm`.`title`.`game_edition`(`game_edition_id`);
ALTER TABLE `gaming_ecm`.`title`.`mode_character_roster` ADD CONSTRAINT `fk_title_mode_character_roster_game_mode_id` FOREIGN KEY (`game_mode_id`) REFERENCES `gaming_ecm`.`title`.`game_mode`(`game_mode_id`);
ALTER TABLE `gaming_ecm`.`title`.`mode_character_roster` ADD CONSTRAINT `fk_title_mode_character_roster_playable_character_id` FOREIGN KEY (`playable_character_id`) REFERENCES `gaming_ecm`.`title`.`playable_character`(`playable_character_id`);

-- ========= TAGS =========
ALTER SCHEMA `gaming_ecm`.`title` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `gaming_ecm`.`title` SET TAGS ('dbx_domain' = 'title');
ALTER TABLE `gaming_ecm`.`title`.`game_title` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`title`.`game_title` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `franchise_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise ID');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Game Studio Id (Foreign Key)');
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
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `steam_app_code` SET TAGS ('dbx_business_glossary_term' = 'Steam Application ID');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `supported_platforms` SET TAGS ('dbx_business_glossary_term' = 'Supported Platforms');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `target_age_max` SET TAGS ('dbx_business_glossary_term' = 'Target Age Maximum');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `target_age_min` SET TAGS ('dbx_business_glossary_term' = 'Target Age Minimum');
ALTER TABLE `gaming_ecm`.`title`.`game_title` ALTER COLUMN `working_title` SET TAGS ('dbx_business_glossary_term' = 'Working Title');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `title_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `build_id` SET TAGS ('dbx_business_glossary_term' = 'Build Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Release Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `game_edition_id` SET TAGS ('dbx_business_glossary_term' = 'Game Edition Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `age_gate_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Age Gate Required Flag');
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
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `upc_code` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ALTER COLUMN `upc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `gaming_ecm`.`title`.`game_edition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`title`.`game_edition` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `gaming_ecm`.`title`.`game_edition` ALTER COLUMN `game_edition_id` SET TAGS ('dbx_business_glossary_term' = 'Game Edition ID');
ALTER TABLE `gaming_ecm`.`title`.`game_edition` ALTER COLUMN `age_rating_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Age Rating Cert Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`game_edition` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Release Id (Foreign Key)');
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
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` SET TAGS ('dbx_subdomain' = 'release_operations');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `build_artifact_id` SET TAGS ('dbx_business_glossary_term' = 'Build Artifact ID');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `age_rating_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Age Rating Cert Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `asset_bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Bundle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `build_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Build ID');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Release Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
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
ALTER TABLE `gaming_ecm`.`title`.`title_release` SET TAGS ('dbx_subdomain' = 'release_operations');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `title_release_id` SET TAGS ('dbx_business_glossary_term' = 'Title Release ID');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `age_rating_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Age Rating Cert Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `build_artifact_id` SET TAGS ('dbx_business_glossary_term' = 'Build Artifact Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Campaign ID');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Release Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `developer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Developer Account Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Milestone Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `actual_release_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Release Date');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `announcement_url` SET TAGS ('dbx_business_glossary_term' = 'Release Announcement URL');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `certification_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Approval Date');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'not_submitted|submitted|in_review|approved|rejected|waived');
ALTER TABLE `gaming_ecm`.`title`.`title_release` ALTER COLUMN `certification_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Submission Date');
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
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `age_rating_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Age Rating Cert Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `asset_bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Bundle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `build_id` SET TAGS ('dbx_business_glossary_term' = 'Build Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Campaign Identifier');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Release Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Storefront Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Studio Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title Identifier');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
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
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `exclusivity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity End Date');
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ALTER COLUMN `file_size_mb` SET TAGS ('dbx_business_glossary_term' = 'File Size (Megabytes)');
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
ALTER TABLE `gaming_ecm`.`title`.`content_rating` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
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
ALTER TABLE `gaming_ecm`.`title`.`franchise` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`title`.`franchise` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `franchise_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Identifier (ID)');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Studio Identifier (ID)');
ALTER TABLE `gaming_ecm`.`title`.`franchise` ALTER COLUMN `genre_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Genre Id (Foreign Key)');
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
ALTER TABLE `gaming_ecm`.`title`.`title_season` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`title`.`title_season` SET TAGS ('dbx_subdomain' = 'engagement_mechanics');
ALTER TABLE `gaming_ecm`.`title`.`title_season` ALTER COLUMN `title_season_id` SET TAGS ('dbx_business_glossary_term' = 'Title Season ID');
ALTER TABLE `gaming_ecm`.`title`.`title_season` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Release Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`title_season` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`title_season` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
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
ALTER TABLE `gaming_ecm`.`title`.`game_mode` SET TAGS ('dbx_data_type' = 'Master');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` SET TAGS ('dbx_subdomain' = 'engagement_mechanics');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `game_mode_id` SET TAGS ('dbx_business_glossary_term' = 'Game Mode Identifier (ID)');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Release Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title Identifier (ID)');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `parent_game_mode_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ALTER COLUMN `title_season_id` SET TAGS ('dbx_business_glossary_term' = 'Title Season Id (Foreign Key)');
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
ALTER TABLE `gaming_ecm`.`title`.`achievement` SET TAGS ('dbx_subdomain' = 'engagement_mechanics');
ALTER TABLE `gaming_ecm`.`title`.`achievement` ALTER COLUMN `achievement_id` SET TAGS ('dbx_business_glossary_term' = 'Achievement ID');
ALTER TABLE `gaming_ecm`.`title`.`achievement` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Release Id (Foreign Key)');
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
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` SET TAGS ('dbx_subdomain' = 'engagement_mechanics');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `leaderboard_id` SET TAGS ('dbx_business_glossary_term' = 'Leaderboard ID');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Release Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `game_mode_id` SET TAGS ('dbx_business_glossary_term' = 'Game Mode ID');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `live_ops_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Live Ops Cycle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `parent_leaderboard_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `seasonal_event_id` SET TAGS ('dbx_business_glossary_term' = 'Event ID');
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ALTER COLUMN `title_season_id` SET TAGS ('dbx_business_glossary_term' = 'Season ID');
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
ALTER TABLE `gaming_ecm`.`title`.`playable_character` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`title`.`playable_character` SET TAGS ('dbx_subdomain' = 'engagement_mechanics');
ALTER TABLE `gaming_ecm`.`title`.`playable_character` ALTER COLUMN `playable_character_id` SET TAGS ('dbx_business_glossary_term' = 'Playable Character Identifier');
ALTER TABLE `gaming_ecm`.`title`.`playable_character` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`playable_character` ALTER COLUMN `dlc_bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Dlc Bundle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`playable_character` ALTER COLUMN `evolved_from_playable_character_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`playable_character` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`playable_character` ALTER COLUMN `live_ops_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Live Ops Cycle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`playable_character` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Model Asset Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`playable_character` ALTER COLUMN `title_season_id` SET TAGS ('dbx_business_glossary_term' = 'Title Season Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`title`.`playable_character` ALTER COLUMN `base_health_points` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`playable_character` ALTER COLUMN `base_health_points` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`playable_character` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`playable_character` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`playable_character` ALTER COLUMN `intellectual_property_owner` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`playable_character` ALTER COLUMN `licensing_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`title`.`edition_content_inclusion` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `gaming_ecm`.`title`.`edition_content_inclusion` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `gaming_ecm`.`title`.`edition_content_inclusion` SET TAGS ('dbx_association_edges' = 'title.game_edition,title.dlc_bundle');
ALTER TABLE `gaming_ecm`.`title`.`edition_content_inclusion` ALTER COLUMN `edition_content_inclusion_id` SET TAGS ('dbx_business_glossary_term' = 'Edition Content Inclusion ID');
ALTER TABLE `gaming_ecm`.`title`.`edition_content_inclusion` ALTER COLUMN `dlc_bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Edition Content Inclusion - Dlc Bundle Id');
ALTER TABLE `gaming_ecm`.`title`.`edition_content_inclusion` ALTER COLUMN `game_edition_id` SET TAGS ('dbx_business_glossary_term' = 'Edition Content Inclusion - Game Edition Id');
ALTER TABLE `gaming_ecm`.`title`.`edition_content_inclusion` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `gaming_ecm`.`title`.`edition_content_inclusion` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`edition_content_inclusion` ALTER COLUMN `display_order` SET TAGS ('dbx_business_glossary_term' = 'Display Order');
ALTER TABLE `gaming_ecm`.`title`.`edition_content_inclusion` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `gaming_ecm`.`title`.`edition_content_inclusion` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `gaming_ecm`.`title`.`edition_content_inclusion` ALTER COLUMN `included_in_edition` SET TAGS ('dbx_business_glossary_term' = 'Included in Edition');
ALTER TABLE `gaming_ecm`.`title`.`edition_content_inclusion` ALTER COLUMN `inclusion_type` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Type');
ALTER TABLE `gaming_ecm`.`title`.`edition_content_inclusion` ALTER COLUMN `is_primary_content` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Content');
ALTER TABLE `gaming_ecm`.`title`.`edition_content_inclusion` ALTER COLUMN `price_contribution_usd` SET TAGS ('dbx_business_glossary_term' = 'Price Contribution USD');
ALTER TABLE `gaming_ecm`.`title`.`mode_character_roster` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `gaming_ecm`.`title`.`mode_character_roster` SET TAGS ('dbx_subdomain' = 'engagement_mechanics');
ALTER TABLE `gaming_ecm`.`title`.`mode_character_roster` SET TAGS ('dbx_association_edges' = 'title.game_mode,title.playable_character');
ALTER TABLE `gaming_ecm`.`title`.`mode_character_roster` ALTER COLUMN `mode_character_roster_id` SET TAGS ('dbx_business_glossary_term' = 'Mode Character Roster ID');
ALTER TABLE `gaming_ecm`.`title`.`mode_character_roster` ALTER COLUMN `game_mode_id` SET TAGS ('dbx_business_glossary_term' = 'Mode Character Roster - Game Mode Id');
ALTER TABLE `gaming_ecm`.`title`.`mode_character_roster` ALTER COLUMN `playable_character_id` SET TAGS ('dbx_business_glossary_term' = 'Mode Character Roster - Playable Character Id');
ALTER TABLE `gaming_ecm`.`title`.`mode_character_roster` ALTER COLUMN `availability_status` SET TAGS ('dbx_business_glossary_term' = 'Availability Status');
ALTER TABLE `gaming_ecm`.`title`.`mode_character_roster` ALTER COLUMN `balance_override_version` SET TAGS ('dbx_business_glossary_term' = 'Balance Override Version');
ALTER TABLE `gaming_ecm`.`title`.`mode_character_roster` ALTER COLUMN `ban_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ban Rate Percentage');
ALTER TABLE `gaming_ecm`.`title`.`mode_character_roster` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`mode_character_roster` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `gaming_ecm`.`title`.`mode_character_roster` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `gaming_ecm`.`title`.`mode_character_roster` ALTER COLUMN `is_default_available` SET TAGS ('dbx_business_glossary_term' = 'Is Default Available');
ALTER TABLE `gaming_ecm`.`title`.`mode_character_roster` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`title`.`mode_character_roster` ALTER COLUMN `pick_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Pick Rate Percentage');
ALTER TABLE `gaming_ecm`.`title`.`mode_character_roster` ALTER COLUMN `unlock_requirement_override` SET TAGS ('dbx_business_glossary_term' = 'Unlock Requirement Override');
ALTER TABLE `gaming_ecm`.`title`.`mode_character_roster` ALTER COLUMN `win_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Win Rate Percentage');
