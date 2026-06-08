-- Schema for Domain: platform | Business: Gaming | Version: v1_mvm
-- Generated on: 2026-05-08 09:46:27

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `gaming_ecm`.`platform` COMMENT 'Manages gaming platforms, distribution channels, console SDK integrations (PlayStation, Xbox, Nintendo), PC storefronts (Steamworks, Epic Games Store), mobile app store pipelines (Apple App Store, Google Play), platform certification submissions, TRC/TCR compliance checklists, DRM entitlement systems, and cross-platform compatibility. Enables multi-platform distribution and deployment.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `gaming_ecm`.`platform`.`storefront` (
    `storefront_id` BIGINT COMMENT 'Unique identifier for the digital distribution storefront. Primary key.',
    `ad_network_id` BIGINT COMMENT 'Foreign key linking to marketing.ad_network. Business justification: Storefronts integrate with ad networks for user acquisition (Apple Search Ads for App Store, Google UAC for Play Store). Attribution flows, cost reporting, and campaign setup require knowing which ad ',
    `cdn_node_id` BIGINT COMMENT 'Foreign key linking to infrastructure.cdn_node. Business justification: Storefront content delivery (game builds, trailers, assets) routes through specific CDN nodes. Platform ops and incident triage teams need this link for latency SLA reporting, CDN failover decisions, ',
    `consent_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.consent_policy. Business justification: Storefronts must operate under a governing consent policy for player data collection, cookie consent, and privacy notices. Platform compliance teams require this link to verify each storefronts activ',
    `developer_account_id` BIGINT COMMENT 'Foreign key linking to platform.developer_account. Business justification: A storefront is managed through a specific developer account on the platform holders developer portal. This is the primary link to connect the siloed developer_account product. N:1 relationship - man',
    `network_region_id` BIGINT COMMENT 'Foreign key linking to infrastructure.network_region. Business justification: Storefronts are deployed in specific network regions for content delivery and latency optimization. Critical for regional availability planning, CDN topology design, and storefront performance SLAs. G',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Each storefront operates under a specific platform content and operational policy. Compliance teams track which policy version governs each storefront for enforcement, audit, and policy change impact ',
    `age_rating_system` STRING COMMENT 'Primary age rating classification system required for games on this storefront: ESRB (North America), PEGI (Europe), USK (Germany), CERO (Japan), GRAC (South Korea), or IARC (International Age Rating Coalition for digital storefronts).. Valid values are `ESRB|PEGI|USK|CERO|GRAC|IARC`',
    `analytics_integration` STRING COMMENT 'Native analytics and reporting platform provided by this storefront for tracking sales, player engagement, and performance metrics (e.g., Steamworks Analytics, App Store Analytics, Google Play Console).',
    `api_endpoint` STRING COMMENT 'Base URL of the storefronts API for programmatic integration, build uploads, metadata management, and analytics retrieval.',
    `cdn_provider` STRING COMMENT 'Content delivery network provider used by this storefront for game distribution and patch delivery (e.g., Akamai, Amazon CloudFront, platform-native CDN).',
    `certification_required` BOOLEAN COMMENT 'Indicates whether game builds must pass formal platform certification (TRC/TCR compliance) before release. True for console storefronts, typically false for open PC storefronts.',
    `contact_email` STRING COMMENT 'Primary business contact email address for developer relations, technical support, or partnership inquiries for this storefront.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this storefront record was first created in the system.',
    `currency` STRING COMMENT 'Primary currency used for pricing and transactions on this storefront. ISO 4217 three-letter currency code (e.g., USD, EUR, JPY, GBP). May support multiple currencies by region.. Valid values are `^[A-Z]{3}$`',
    `developer_portal_url` STRING COMMENT 'Web URL of the developer portal or partner center for this storefront where game submissions, builds, and metadata are managed (e.g., Steamworks, Epic Dev Portal, App Store Connect, Google Play Console).',
    `drm_system` STRING COMMENT 'Digital rights management and entitlement system used by this storefront to control game access and prevent piracy (e.g., Steam DRM, Denuvo, platform-native entitlement, none for DRM-free stores like GOG).',
    `launch_date` DATE COMMENT 'Date when this storefront officially launched and became available for game distribution and player purchases.',
    `maximum_build_size_gb` STRING COMMENT 'Maximum game build package size in gigabytes accepted by this storefront. Null if no hard limit enforced.',
    `minimum_build_size_mb` STRING COMMENT 'Minimum game build package size in megabytes accepted by this storefront. Null if no minimum enforced.',
    `platform_generation` STRING COMMENT 'Hardware or platform generation supported by this storefront (e.g., PS5, Xbox Series X|S, Nintendo Switch, PC, iOS 15+, Android 12+). May support multiple generations.',
    `platform_holder_type` STRING COMMENT 'Classification of the platform holder operating this storefront: console OEM (Sony, Microsoft, Nintendo), PC storefront (Valve, Epic), mobile app store (Apple, Google), or cloud gaming platform.. Valid values are `console_oem|pc_storefront|mobile_app_store|cloud_gaming_platform`',
    `refund_policy_days` STRING COMMENT 'Number of days within which players can request refunds for game purchases on this storefront (e.g., 14 for Steam, 14 for Epic). Null if no standard refund window.',
    `region_availability` STRING COMMENT 'Geographic regions or countries where this storefront is available for game distribution and player purchases. Comma-separated ISO 3166-1 alpha-3 country codes or region identifiers.',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of gross revenue retained by the platform holder as commission (e.g., 30.00 for standard 30% platform fee, 70.00 means publisher receives 70%). Business-confidential commercial term.',
    `sdk_version` STRING COMMENT 'Current version of the platform SDK or integration library required for game builds submitted to this storefront (e.g., Steamworks SDK 1.55, Epic Online Services 1.15, iOS SDK 16.2).',
    `storefront_code` STRING COMMENT 'Standardized short code identifier for the storefront used in internal systems and integrations (e.g., PSN_STORE, XBOX_STORE, STEAM, EPIC, APPLE_APP, GOOGLE_PLAY).. Valid values are `^[A-Z0-9_]{2,20}$`',
    `storefront_name` STRING COMMENT 'Official business name of the digital distribution storefront (e.g., PlayStation Store, Xbox Marketplace, Steam, Epic Games Store, Apple App Store, Google Play).',
    `storefront_status` STRING COMMENT 'Current operational status of the storefront: active (accepting submissions and sales), deprecated (legacy support only), sunset (end-of-life), beta (limited access), or coming soon (announced but not launched).. Valid values are `active|deprecated|sunset|beta|coming_soon`',
    `sunset_date` DATE COMMENT 'Planned or actual date when this storefront will cease operations or no longer accept new game submissions. Null if storefront is active with no announced sunset.',
    `supported_payment_methods` STRING COMMENT 'Payment instruments accepted by this storefront (e.g., credit card, debit card, PayPal, platform wallet, gift card, carrier billing). Comma-separated list.',
    `supports_cross_platform` BOOLEAN COMMENT 'Indicates whether this storefront supports cross-platform multiplayer, cross-save, or cross-buy features with other platforms.',
    `supports_dlc` BOOLEAN COMMENT 'Indicates whether this storefront supports distribution of downloadable content, expansions, and add-ons for base games.',
    `supports_early_access` BOOLEAN COMMENT 'Indicates whether this storefront supports early access or soft launch programs where games can be released in incomplete or beta state with player access.',
    `supports_iap` BOOLEAN COMMENT 'Indicates whether this storefront supports in-app purchases and microtransactions within games. True for most mobile and modern console/PC storefronts.',
    `supports_subscriptions` BOOLEAN COMMENT 'Indicates whether this storefront supports recurring subscription billing for games or services (e.g., Xbox Game Pass, PlayStation Plus, Apple Arcade).',
    `supports_ugc` BOOLEAN COMMENT 'Indicates whether this storefront provides infrastructure for user-generated content distribution (e.g., Steam Workshop, console mod support).',
    `tax_calculation_method` STRING COMMENT 'Method by which sales tax or VAT is calculated and displayed: inclusive (tax included in displayed price), exclusive (tax added at checkout), or varies by region.. Valid values are `inclusive|exclusive|varies_by_region`',
    `trc_tcr_version` STRING COMMENT 'Version identifier of the platforms technical requirements checklist that games must comply with for certification (e.g., PlayStation TRC v5.2, Xbox TCR 2023-Q2). Null if certification not required.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this storefront record was last modified.',
    CONSTRAINT pk_storefront PRIMARY KEY(`storefront_id`)
) COMMENT 'Master catalog of digital distribution storefronts, platform channels, and their governing platform holders through which game titles are published and sold. Covers first-party console storefronts (PlayStation Store, Xbox Marketplace, Nintendo eShop), PC storefronts (Steamworks, Epic Games Store, GOG), and mobile app stores (Apple App Store, Google Play). Tracks storefront identity, owning platform holder (Sony, Microsoft, Nintendo, Apple, Google, Valve), platform holder type (console OEM, PC storefront, mobile app store), region availability, supported payment methods, revenue share terms, developer portal URL, integration SDK version, and supported platform generations. This is the SSOT for all distribution channel and platform holder definitions.';

CREATE OR REPLACE TABLE `gaming_ecm`.`platform`.`platform_sku` (
    `platform_sku_id` BIGINT COMMENT 'Unique identifier for the platform-specific SKU representing a game titles releasable, purchasable, and discoverable unit on a specific storefront or console platform.',
    `age_rating_cert_id` BIGINT COMMENT 'Foreign key linking to compliance.age_rating_cert. Business justification: Every SKU requires age rating certification before sale. Real business process: certification tracking for release approval and storefront listing compliance. Age ratings determine regional availabili',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: Platform SKU version management: cert teams and release managers must track which content_release version backs each purchasable SKU. Drives what build a player receives on purchase and is required fo',
    `game_edition_id` BIGINT COMMENT 'Foreign key linking to title.game_edition. Business justification: A platform SKU represents a specific game edition (Standard, Deluxe, Ultimate) on a storefront. Storefront merchandising, entitlement delivery, and content packaging all require mapping platform_sku t',
    `game_title_id` BIGINT COMMENT 'Reference to the parent game title that this platform SKU represents. Links to the master game title entity.',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: SKUs for licensed IP content (Marvels Spider-Man, FIFA) require agreement reference for royalty calculation on unit sales, revenue share enforcement, and territory restriction compliance per commerci',
    `network_region_id` BIGINT COMMENT 'Foreign key linking to infrastructure.network_region. Business justification: SKU regional availability is constrained by infrastructure deployment regions. Required for regional launch planning, content distribution strategy, and ensuring SKUs are only sold where infrastructur',
    `storefront_id` BIGINT COMMENT 'Reference to the gaming platform or storefront where this SKU is distributed (e.g., PlayStation, Xbox, Steam, Epic Games Store, Apple App Store, Google Play).',
    `aso_keywords` STRING COMMENT 'Comma-separated list of search keywords and phrases optimized for storefront search algorithms and organic discoverability. Used for ASO strategy on mobile and PC storefronts.',
    `base_price_usd` DECIMAL(18,2) COMMENT 'Base list price in United States Dollars (USD) before regional adjustments, promotions, or discounts.',
    `certification_approval_date` DATE COMMENT 'Date when the platform approved the SKU after successful TRC/TCR certification, clearing it for release.',
    `certification_submission_date` DATE COMMENT 'Date when the SKU build was submitted to the platform for TRC/TCR certification and compliance review.',
    `content_descriptors` STRING COMMENT 'Comma-separated list of content warning descriptors from rating boards (e.g., Violence, Blood, Strong Language, Suggestive Themes, Use of Alcohol, In-Game Purchases, Online Interactions).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this platform SKU record was first created in the system, marking the beginning of the SKUs lifecycle in the catalog.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the primary market of this SKU (e.g., USD, EUR, GBP, JPY, KRW).. Valid values are `^[A-Z]{3}$`',
    `drm_entitlement_type` STRING COMMENT 'Type of DRM or entitlement system used to manage ownership and access rights (e.g., Steam DRM, Epic Games Services, PlayStation Network, Xbox Live, Nintendo Account, Apple ID, Google Play, DRM-Free, Proprietary). [ENUM-REF-CANDIDATE: steam|epic|psn|xbox_live|nintendo_account|apple_id|google_play|drm_free|proprietary — 9 candidates stripped; promote to reference product]',
    `esrb_rating` STRING COMMENT 'ESRB content rating for North American markets (EC=Early Childhood, E=Everyone, E10+=Everyone 10+, T=Teen, M=Mature 17+, AO=Adults Only 18+, RP=Rating Pending). [ENUM-REF-CANDIDATE: ec|e|e10|t|m|ao|rp — 7 candidates stripped; promote to reference product]',
    `feature_bullets` STRING COMMENT 'Pipe-separated list of key feature bullet points highlighting gameplay mechanics, content offerings, and unique selling propositions (e.g., Single Player Campaign|Multiplayer Co-op|Cross-Platform Play|4K Graphics|Ray Tracing Support).',
    `genre_tags` STRING COMMENT 'Comma-separated list of genre and gameplay tags for discoverability and filtering (e.g., FPS, Open World, Multiplayer, Co-op, PvP, PvE, Battle Royale, MOBA, MMO, Roguelike, Metroidvania).',
    `hardware_generation` STRING COMMENT 'Supported hardware generation or platform version (e.g., PlayStation 5, Xbox Series X|S, Nintendo Switch, PC, iOS 15+, Android 12+). Indicates minimum or target hardware compatibility.',
    `is_early_access` BOOLEAN COMMENT 'Boolean flag indicating whether this SKU is released in early access or beta state, allowing players to purchase and play an unfinished version during development.',
    `is_preorder_available` BOOLEAN COMMENT 'Boolean flag indicating whether this SKU is available for pre-order purchase before the official release date. True if pre-orders are enabled, False otherwise.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the storefront listing metadata, including changes to description, screenshots, pricing, or availability.',
    `listing_status` STRING COMMENT 'Current lifecycle status of the storefront listing (draft=being prepared, pending_review=submitted for platform certification, in_review=under TRC/TCR review, approved=passed certification, live=publicly available, delisted=removed from sale, suspended=temporarily unavailable, rejected=failed certification). [ENUM-REF-CANDIDATE: draft|pending_review|in_review|approved|live|delisted|suspended|rejected — 8 candidates stripped; promote to reference product]',
    `listing_title` STRING COMMENT 'Public-facing title displayed on the storefront listing page. May differ from the master game title to include edition information or platform-specific branding.',
    `localization_language` STRING COMMENT 'Primary language code (ISO 639-1) for this storefront listings metadata and promotional content (e.g., en, es, fr, de, ja, ko, zh). Separate SKUs may exist for different language markets.',
    `long_description` STRING COMMENT 'Full product description displayed on the storefront detail page. Includes gameplay features, story synopsis, key selling points, and system requirements. Optimized for SEO and conversion.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this platform SKU record, tracking any changes to SKU attributes, metadata, or configuration.',
    `pegi_rating` STRING COMMENT 'PEGI age rating for European markets (3, 7, 12, 16, 18). Indicates minimum recommended age for content appropriateness.. Valid values are `3|7|12|16|18`',
    `platform_product_identifier` STRING COMMENT 'Platform-specific unique product identifier assigned by the storefront or console manufacturer (e.g., Steam AppID, PlayStation Content ID, Apple Bundle ID, Google Play Package Name, Epic Games Store Catalog Item ID).',
    `pricing_tier` STRING COMMENT 'Pricing tier or price point category assigned by the platform (e.g., $9.99, $19.99, $29.99, $39.99, $49.99, $59.99, $69.99, Free-to-Play). Used for storefront pricing strategy and regional pricing matrix.',
    `regional_availability` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes where this SKU is available for purchase and download (e.g., USA,CAN,GBR,DEU,FRA,JPN). Used for geo-restriction and regional distribution management.',
    `release_date` DATE COMMENT 'Official release date when this SKU became available for purchase and download on the platform storefront. May differ from master game title release date for platform-specific launches.',
    `review_count` STRING COMMENT 'Total number of user reviews and ratings submitted for this SKU on the platform storefront. Used to calculate review score confidence and social proof.',
    `screenshot_asset_urls` STRING COMMENT 'Comma-separated list of URLs or asset references pointing to promotional screenshots displayed on the storefront listing. Typically 5-10 high-resolution images showcasing gameplay and features.',
    `short_description` STRING COMMENT 'Brief promotional description or tagline displayed in storefront search results and browse views. Typically 80-160 characters optimized for discoverability and conversion.',
    `sku_code` STRING COMMENT 'Internal SKU code used for inventory, distribution, and catalog management across platforms.',
    `storefront_category` STRING COMMENT 'Primary storefront category or section where this SKU is listed (e.g., Action, Adventure, RPG, Strategy, Sports, Simulation, Puzzle, Casual). Platform-specific taxonomy.',
    `supported_languages` STRING COMMENT 'Comma-separated list of ISO 639-1 language codes for in-game language support including interface, audio, and subtitles (e.g., en,es,fr,de,ja,ko,zh-Hans,zh-Hant,pt,ru,it).',
    `supports_achievements` BOOLEAN COMMENT 'Boolean flag indicating whether this SKU implements platform achievements, trophies, or gamerscore functionality.',
    `supports_cloud_saves` BOOLEAN COMMENT 'Boolean flag indicating whether this SKU supports cloud-based save game synchronization across devices through the platforms cloud storage service.',
    `supports_crossplay` BOOLEAN COMMENT 'Boolean flag indicating whether this SKU supports cross-platform multiplayer gameplay with players on other platforms. True if crossplay is enabled, False otherwise.',
    `supports_leaderboards` BOOLEAN COMMENT 'Boolean flag indicating whether this SKU implements platform leaderboards for competitive score tracking and ranking.',
    `trailer_asset_urls` STRING COMMENT 'Comma-separated list of URLs or asset references pointing to promotional video trailers displayed on the storefront listing. Includes launch trailers, gameplay trailers, and feature spotlights.',
    `user_review_score` DECIMAL(18,2) COMMENT 'Aggregate user review score or rating displayed on the storefront (typically 0.00 to 5.00 or 0.00 to 10.00 scale depending on platform). Calculated from player reviews and ratings.',
    CONSTRAINT pk_platform_sku PRIMARY KEY(`platform_sku_id`)
) COMMENT 'Platform-specific SKU (Stock Keeping Unit) representing a game titles complete releasable, purchasable, and discoverable unit on a specific storefront or console platform. Captures platform-specific product identifier (e.g., Steam AppID, PlayStation Content ID, Apple Bundle ID), edition type (Standard, Deluxe, Gold), supported hardware generation, pricing tier, regional availability, DRM entitlement type, and all public-facing storefront listing metadata including listing title, short and long descriptions, feature bullet points, screenshot and trailer asset references, localization language, storefront category and genre tags, ASO keywords, user review score aggregate, review count, listing status (draft, pending review, live, delisted), and last updated timestamp. This is the SSOT for what a game looks like as both a purchasable product and a discoverable listing on each platform storefront.';

CREATE OR REPLACE TABLE `gaming_ecm`.`platform`.`cert_submission` (
    `cert_submission_id` BIGINT COMMENT 'Unique identifier for the platform certification submission record. Primary key for the certification submission lifecycle tracking from build preparation through platform holder review and outcome resolution.',
    `age_rating_cert_id` BIGINT COMMENT 'Foreign key linking to compliance.age_rating_cert. Business justification: Certification submissions often include or reference age rating certificates as part of platform holder approval. Real business process: platform certification requires proof of content rating complia',
    `build_artifact_id` BIGINT COMMENT 'Foreign key linking to title.build_artifact. Business justification: Platform certification submissions validate specific build artifacts for TRC/TCR compliance. Real cert processes (Sony, Microsoft, Nintendo) require exact build version tracking with checksums, engine',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to licensing.compliance_obligation. Business justification: Certification submissions may directly satisfy licensor-mandated compliance obligations (platform_certification_requirement in compliance_obligation). This link enables audit tracking of whether cert ',
    `consent_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.consent_policy. Business justification: Certification submissions for GDPR/COPPA-applicable platforms must document the consent policy version in effect at submission time. Platform cert checklists (TRC/TCR) include consent compliance verif',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: Certification submission workflow: cert submissions are made against a specific content_release build for TRC/TCR review. Platform cert teams require this link to trace which content release was submi',
    `developer_account_id` BIGINT COMMENT 'Foreign key linking to platform.developer_account. Business justification: Certification submissions are filed through a developer account on the platform holders developer portal. While platform_cert_submission has game_studio_id (cross-domain reference to the studio entit',
    `game_studio_id` BIGINT COMMENT 'Reference to the game development studio responsible for creating and submitting the build for certification. Links the submission to the development team accountable for build quality and certification compliance.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title being submitted for platform certification. Links this submission to the specific game product undergoing certification review.',
    `infrastructure_deployment_id` BIGINT COMMENT 'Foreign key linking to infrastructure.infrastructure_deployment. Business justification: Cert submissions require deploying the build to test infrastructure. Linking to the specific infrastructure deployment enables cert teams to trace which deployment environment was used for each submis',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: Certification submissions for licensed content must reference governing IP agreement to verify compliance with brand usage guidelines, rating board requirements, and licensor approval workflows mandat',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Cert submissions target specific jurisdictions (PEGI for EU, ESRB for NA, CERO for Japan). Compliance teams need direct jurisdiction linkage on submissions to apply correct regulatory requirements, ra',
    `loot_box_disclosure_id` BIGINT COMMENT 'Foreign key linking to compliance.loot_box_disclosure. Business justification: Cert submissions for games with IAP/loot boxes must reference the loot_box_disclosure record. Platform certification review (TRC/TCR) explicitly requires verified loot box disclosure compliance before',
    `maintenance_window_id` BIGINT COMMENT 'Foreign key linking to infrastructure.maintenance_window. Business justification: Cert submission test infrastructure is subject to maintenance windows that can block or delay certification testing. Platform cert teams track this dependency to manage resubmission deadlines and avoi',
    `platform_sku_id` BIGINT COMMENT 'Foreign key linking to platform.platform_sku. Business justification: A platform certification submission is filed for a specific platform SKU — the releasable unit being certified. platform_sku is the platform-specific product unit (game title + storefront + edition), ',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_policy. Business justification: Cert submissions must adhere to internal compliance policies that implement regulatory requirements. Real business process: policy enforcement during certification review. Submissions are validated ag',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Cert submissions must comply with specific regulatory obligations (accessibility requirements, data privacy, content standards). Real business process: compliance checklist validation against regulato',
    `sdk_integration_id` BIGINT COMMENT 'Foreign key linking to platform.sdk_integration. Business justification: A cert submission validates a build against a specific SDK integration version. platform_cert_submission.platform_sdk_version is a denormalized string that should be replaced by a FK to sdk_integratio',
    `storefront_id` BIGINT COMMENT 'Reference to the target gaming platform for this certification submission (PlayStation, Xbox, Nintendo, Steam, Epic Games Store, Apple App Store, Google Play).',
    `game_server_id` BIGINT COMMENT 'Foreign key linking to infrastructure.game_server. Business justification: Certification testing for multiplayer/online features requires specific test game servers. Critical for tracking which server environment was used for cert validation, reproducing cert failures, and e',
    `accessibility_features_included` BOOLEAN COMMENT 'Boolean flag indicating whether this build includes accessibility features such as colorblind modes, subtitle options, controller remapping, or assistive technology support. Platform holders increasingly require or incentivize accessibility compliance.',
    `approval_date` DATE COMMENT 'Date when the build received final certification approval from the platform holder. This is the official date of certification grant and may be used for contractual and regulatory purposes. Null if certification has not been approved.',
    `certification_outcome` STRING COMMENT 'Final outcome of the platform holder certification review for the current review cycle. Pass indicates full certification approval, fail indicates rejection requiring resubmission, conditional pass indicates approval with minor required fixes, pending indicates review in progress, and not reviewed indicates submission not yet evaluated.. Valid values are `pass|fail|conditional_pass|pending|not_reviewed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification submission record was first created in the system. Used for audit trails, data lineage tracking, and submission lifecycle analysis.',
    `cross_platform_compatible` BOOLEAN COMMENT 'Boolean flag indicating whether this build supports cross-platform play or cross-platform progression with other platform versions of the game. True indicates cross-platform features are enabled and certified, false indicates platform-exclusive build.',
    `esrb_rating` STRING COMMENT 'ESRB content rating assigned to the game title for North American distribution. E (Everyone), E10+ (Everyone 10+), T (Teen), M (Mature 17+), AO (Adults Only 18+), RP (Rating Pending). Required for platform certification and storefront listing in North America.. Valid values are `E|E10|T|M|AO|RP`',
    `failure_categories` STRING COMMENT 'Comma-separated list of TRC/TCR failure categories or violation codes identified by the platform holder during certification review. Categories may include performance issues, stability problems, UI/UX violations, accessibility failures, content policy violations, or technical requirement breaches. Used for root cause analysis and quality improvement.',
    `failure_count` STRING COMMENT 'Total number of certification failures or rejections for this submission across all review cycles. Increments with each failed review, used to track submission quality and identify problematic builds requiring significant rework.',
    `in_app_purchases_enabled` BOOLEAN COMMENT 'Boolean flag indicating whether this build includes in-app purchase or microtransaction functionality. True indicates IAP features are present and must comply with platform holder commerce policies and PCI DSS requirements, false indicates no monetization features.',
    `multiplayer_enabled` BOOLEAN COMMENT 'Boolean flag indicating whether this build includes online multiplayer functionality. True indicates multiplayer features are present and must pass platform holder online service certification requirements, false indicates single-player only build.',
    `pegi_rating` STRING COMMENT 'PEGI content rating assigned to the game title for European distribution. Ratings are 3, 7, 12, 16, or 18 indicating minimum age suitability. Required for platform certification and storefront listing in Europe.. Valid values are `3|7|12|16|18`',
    `platform_reviewer_notes` STRING COMMENT 'Detailed notes and feedback provided by the platform holder certification reviewers. May include specific issues identified, recommendations for improvement, clarifications on TRC/TCR interpretation, and guidance for resubmission. Confidential business communication between platform holder and developer.',
    `resubmission_deadline` DATE COMMENT 'Date by which a corrected build must be resubmitted following a certification failure. Platform holders typically impose deadlines to maintain release schedules and certification queue management. Null if submission passed or no deadline was set.',
    `review_completion_date` DATE COMMENT 'Date when the platform holder completed certification review and issued the final outcome (pass, fail, or conditional pass). Used to calculate total review cycle time and track platform holder SLA performance.',
    `review_start_date` DATE COMMENT 'Date when the platform holder began active certification review of the submitted build. May differ from submission date if there is a queue or validation period. Used to calculate actual review duration.',
    `submission_date` DATE COMMENT 'Date when the build was formally submitted to the platform holder for certification review. Marks the start of the platform holder review SLA and is used for certification timeline tracking and reporting.',
    `submission_notes` STRING COMMENT 'Internal notes and comments from the development or publishing team regarding this certification submission. May include context on build changes, known issues, special testing instructions, or coordination details. For internal use only, not shared with platform holder.',
    `submission_number` STRING COMMENT 'Externally-known unique identifier or tracking number assigned to this certification submission by the platform holder or internal submission system. Used for communication and tracking with platform certification teams.',
    `submission_status` STRING COMMENT 'Current status of the certification submission in the end-to-end pipeline. Tracks progression from build packaging through platform holder review to final outcome. Packaging indicates build preparation, uploading is transfer to platform holder, validating is automated checks, submitted is awaiting review, in-review is active platform holder evaluation, approved is certification granted, rejected is certification denied, conditional pass requires minor fixes, and withdrawn is submission cancelled. [ENUM-REF-CANDIDATE: packaging|uploading|validating|submitted|in_review|approved|rejected|conditional_pass|withdrawn — 9 candidates stripped; promote to reference product]',
    `submission_type` STRING COMMENT 'Classification of the submission type. Initial is the first submission for a new title, resubmission is a corrected submission after rejection, patch is a post-launch bug fix, DLC is downloadable content certification, and update is a content or feature update.. Valid values are `initial|resubmission|patch|dlc|update`',
    `target_release_date` DATE COMMENT 'Planned commercial release date for the game title or update associated with this certification submission. Used for release planning, marketing coordination, and certification timeline management. May be adjusted based on certification outcomes.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification submission record was last modified. Tracks the most recent update to submission status, review outcomes, or metadata. Used for change tracking and audit purposes.',
    `waiver_details` STRING COMMENT 'Detailed description of any waivers or exceptions granted by the platform holder, including the specific TRC/TCR requirements waived, justification for the waiver, and any conditions or limitations imposed. Null if no waiver was granted.',
    `waiver_granted` BOOLEAN COMMENT 'Boolean flag indicating whether the platform holder granted a waiver or exception for one or more TRC/TCR requirements that the build did not fully meet. True indicates a waiver was granted allowing certification despite non-compliance, false indicates no waivers were needed or granted.',
    CONSTRAINT pk_cert_submission PRIMARY KEY(`cert_submission_id`)
) COMMENT 'Transactional record of the complete platform certification lifecycle from build preparation and packaging through formal platform holder submission, review, and outcome resolution. At the build level: captures build version string, build type (debug, release candidate, gold master, patch, hotfix), target platform, build size (bytes), build hash/checksum, submission pipeline status (packaging, uploading, validating, submitted, in-review, approved, rejected), submission channel (PlayStation DevNet, Xbox Partner Center, App Store Connect, Steamworks), and gold master flag. At the submission level: captures TRC/TCR checklist version applied, submission type (initial, resubmission, patch), and platform holder review tracking. At the result level: captures certification outcome per review cycle (pass, fail, conditional pass), failure count and categories, waiver grants, resubmission deadline, certification certificate ID, gold master approval flag, and platform holder reviewer notes. One submission may have multiple result records across resubmission cycles. This is the SSOT for the entire build-to-certification pipeline including build preparation, formal submission, and all platform holder review outcomes.';

CREATE OR REPLACE TABLE `gaming_ecm`.`platform`.`drm_entitlement` (
    `drm_entitlement_id` BIGINT COMMENT 'Unique identifier for the DRM entitlement record. Primary key for both entitlement rules and individual player grants.',
    `consent_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.consent_policy. Business justification: DRM entitlements involve player data processing and require consent under GDPR/CCPA. Real business process: legal basis validation for entitlement grants and data retention compliance. Entitlements tr',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: Version-locked DRM entitlements: DRM systems scope entitlements to specific content release versions (e.g., early access to a content drop). Auditing which content version a player is entitled to acce',
    `entitlement_id` BIGINT COMMENT 'Foreign key linking to licensing.entitlement. Business justification: DRM entitlements on the platform must be issued within the scope of a B2B licensing entitlement (territory, platform, DRM limits). This link enables DRM compliance audits and territory enforcement — a',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: DRM entitlements have region_lock_enabled and allowed_regions attributes requiring jurisdiction-specific compliance (EU digital resale rights, China online game regulations). Direct jurisdiction FK en',
    `platform_identity_id` BIGINT COMMENT 'The players account identifier on the external platform (Steam ID, PSN ID, Xbox Live Gamertag, Epic Account ID, etc.). Used for platform-level entitlement verification.',
    `platform_sku_id` BIGINT COMMENT 'Foreign key linking to platform.platform_sku. Business justification: DRM entitlements govern access rights for a specific platform SKU — the exact platform-specific releasable unit (edition, region, platform variant). drm_entitlement has title_sku_id (cross-domain FK t',
    `player_account_id` BIGINT COMMENT 'Unique identifier of the player who received this entitlement grant. Links to the player master record. Null for rule-level records, populated for grant-level records.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: DRM entitlements enforce platform policies governing offline play, device limits, transfer rights, and revocation. Compliance audits require knowing which policy version governs each entitlement type,',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to platform.storefront. Business justification: DRM entitlements are platform and storefront-specific — a players right to access a game is governed by the storefront through which it was acquired (Steam, PlayStation Store, Xbox Marketplace, etc.)',
    `storefront_order_id` BIGINT COMMENT 'Foreign key linking to billing.storefront_order. Business justification: DRM entitlement revocation on refund or chargeback requires tracing the entitlement back to its originating purchase order. Gaming platforms must revoke entitlements when orders are refunded. grant_so',
    `allowed_regions` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes where this entitlement is valid. Empty if region_lock_enabled is false. Example: USA,CAN,GBR,DEU.',
    `concurrent_device_limit` STRING COMMENT 'Maximum number of devices that can simultaneously use this entitlement. Applicable for multi-device license scope. Null for single-device or unlimited scope.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this entitlement record was first created in the system. Audit trail field for record creation tracking.',
    `device_binding_code` STRING COMMENT 'Unique identifier of the device to which this entitlement is bound. Applicable for single-device license scope. May be device serial number, hardware fingerprint, or platform device ID.',
    `entitlement_notes` STRING COMMENT 'Free-text field for additional notes, special conditions, or administrative comments related to this entitlement. Used for documenting exceptions, special grants, or support case references.',
    `entitlement_type` STRING COMMENT 'The type of entitlement governing access rights. Purchase = permanent ownership, Subscription = recurring access, Trial = time-limited evaluation, F2P = free-to-play access, Rental = temporary paid access, Promotional = marketing grant.. Valid values are `purchase|subscription|trial|f2p|rental|promotional`',
    `expiry_duration_days` STRING COMMENT 'Number of days from grant timestamp until entitlement expires. Applicable only when expiry_rule is duration_days. Null for other expiry rule types.',
    `expiry_fixed_date` DATE COMMENT 'Specific calendar date when entitlement expires. Applicable only when expiry_rule is fixed_date. Null for other expiry rule types.',
    `expiry_rule` STRING COMMENT 'Defines how entitlement expiration is calculated. Perpetual = never expires, Fixed-date = expires on specific date, Duration-days = expires N days after grant, Subscription-cycle = expires with subscription period.. Valid values are `perpetual|fixed_date|duration_days|subscription_cycle`',
    `family_share_enabled` BOOLEAN COMMENT 'Indicates whether this entitlement can be shared with family group members as defined by the platforms family sharing feature. True = shareable, False = not shareable.',
    `grant_channel` STRING COMMENT 'The channel or method through which this entitlement was granted. Storefront-purchase = direct store purchase, Key-redemption = activation code, Promotional-grant = marketing campaign, Subscription-benefit = included in subscription, Bundle-inclusion = part of bundle purchase, Platform-plus = platform subscription service (PS Plus, Game Pass).. Valid values are `storefront_purchase|key_redemption|promotional_grant|subscription_benefit|bundle_inclusion|platform_plus`',
    `grant_expiry_timestamp` TIMESTAMP COMMENT 'The calculated date and time when this specific entitlement grant expires. Computed based on grant_timestamp and expiry_rule configuration. Null for perpetual entitlements.',
    `grant_source_transaction_reference` STRING COMMENT 'Reference identifier to the originating transaction that triggered this entitlement grant. May reference IAP transaction, subscription activation, promotional campaign, or key redemption event.',
    `grant_timestamp` TIMESTAMP COMMENT 'The exact date and time when this entitlement was granted to the player. Null for rule-level records, populated for grant-level records.',
    `last_verification_timestamp` TIMESTAMP COMMENT 'The date and time when this entitlement was last verified with the platform DRM service. Used to enforce verification_required_interval_hours policy.',
    `license_scope` STRING COMMENT 'Defines the scope of device/account binding for this entitlement. Single-device = locked to one device, Multi-device = usable across multiple devices, Family-share = shareable within family group, Account-bound = tied to player account regardless of device.. Valid values are `single_device|multi_device|family_share|account_bound`',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this entitlement record was last modified. Audit trail field for change tracking.',
    `offline_play_allowed` BOOLEAN COMMENT 'Indicates whether this entitlement permits offline gameplay without active internet connection. True = offline play enabled, False = requires online verification.',
    `region_lock_enabled` BOOLEAN COMMENT 'Indicates whether geographic region restrictions apply to this entitlement. True = region-locked, False = globally accessible.',
    `revocation_grace_period_hours` STRING COMMENT 'Number of hours of continued access after revocation is triggered. Applicable only when revocation_policy is grace_period. Null for other policies.',
    `revocation_policy` STRING COMMENT 'Defines the policy for revoking this entitlement. Immediate = access removed instantly, Grace-period = access continues for defined period, Non-revocable = cannot be revoked once granted.. Valid values are `immediate|grace_period|non_revocable`',
    `revocation_reason` STRING COMMENT 'The reason why this entitlement was revoked. Chargeback = payment reversed, Fraud = fraudulent acquisition detected, Policy-violation = terms of service breach, Subscription-cancellation = subscription ended, Refund = purchase refunded, Admin-action = manual revocation by support.. Valid values are `chargeback|fraud|policy_violation|subscription_cancellation|refund|admin_action`',
    `revocation_status` STRING COMMENT 'Current status of this entitlement grant. Active = valid and usable, Revoked = access removed by admin/system, Suspended = temporarily disabled, Expired = past expiry timestamp.. Valid values are `active|revoked|suspended|expired`',
    `revocation_timestamp` TIMESTAMP COMMENT 'The date and time when this entitlement was revoked or suspended. Null if revocation_status is active or expired.',
    `transfer_allowed` BOOLEAN COMMENT 'Indicates whether this entitlement can be transferred to another player account. True = transferable, False = non-transferable. Most digital entitlements are non-transferable per platform policies.',
    `verification_required_interval_hours` STRING COMMENT 'Number of hours between required online entitlement verification checks. Applicable for entitlements that allow offline play but require periodic online check-ins. Null for always-online or fully-offline entitlements.',
    CONSTRAINT pk_drm_entitlement PRIMARY KEY(`drm_entitlement_id`)
) COMMENT 'Master and transactional record governing DRM (Digital Rights Management) entitlement rules and the complete audit trail of individual player-level access grants for platform SKUs. At the rule level: captures entitlement type (purchase, subscription, trial, F2P, rental), license scope (single-device, multi-device, family share), offline play allowance, region lock configuration, expiry rules, and revocation policy. At the grant level: tracks individual player entitlement grants including grant timestamp, source transaction reference (IAP, promotion, subscription, key redemption), platform account ID, device binding, grant channel (storefront purchase, key redemption, promotional grant, subscription benefit), grant expiry, and revocation status. This is the SSOT for both DRM licensing policy definitions and the complete audit trail of player access rights across all platforms. Supports entitlement verification, access revocation, and compliance audit queries.';

CREATE OR REPLACE TABLE `gaming_ecm`.`platform`.`entitlement_grant` (
    `entitlement_grant_id` BIGINT COMMENT 'Unique identifier for the entitlement grant record. Primary key for this transactional record of DRM (Digital Rights Management) entitlement provisioning.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.marketing_campaign. Business justification: Entitlement grants issued via marketing promotions (free game giveaways, influencer keys, campaign rewards) must be attributed to the originating campaign for ROI tracking and budget reconciliation — ',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: Content drop entitlement fulfillment: grants tied to season pass content drops or DLC releases must reference the triggering content_release for fulfillment audit, player support, and revenue recognit',
    `device_id` BIGINT COMMENT 'Unique identifier of the device where the entitlement was first activated (console serial, mobile device IDFA/GAID, PC hardware fingerprint). Used for device binding and DRM enforcement.',
    `dlc_bundle_id` BIGINT COMMENT 'Reference to the product bundle if this entitlement was granted as part of a bundle purchase. Null for individual item grants.',
    `drm_entitlement_id` BIGINT COMMENT 'Foreign key linking to platform.drm_entitlement. Business justification: entitlement_grant is a transactional record of a DRM entitlement being granted to a player. drm_entitlement is the master record defining the entitlement rules and policies. The grant should reference',
    `entitlement_id` BIGINT COMMENT 'Foreign key linking to licensing.entitlement. Business justification: Player entitlement grants must be validated against the B2B licensing entitlements authorized platforms, territories, and seat limits. This link enables compliance reporting: confirming each player g',
    `game_title_id` BIGINT COMMENT 'Reference to the game title or content SKU (Stock Keeping Unit) that this entitlement grants access to.',
    `iap_transaction_id` BIGINT COMMENT 'Foreign key linking to licensing.iap_transaction. Business justification: When a player purchases an IAP, an entitlement_grant is created. Linking to iap_transaction enables reconciliation between grants and purchases for refund processing, fraud detection, and revenue reco',
    `parent_entitlement_entitlement_grant_id` BIGINT COMMENT 'Reference to a parent entitlement grant if this is a child or dependent entitlement (e.g., DLC requiring base game, season pass content unlock). Null for standalone entitlements.',
    `platform_identity_id` BIGINT COMMENT 'The players unique account identifier on the external platform (PSN ID, Xbox Live Gamertag, Nintendo Account ID, Steam ID, Epic Account ID, Apple ID, Google Play ID). Used for cross-platform entitlement verification.',
    `platform_sku_id` BIGINT COMMENT 'Foreign key linking to platform.platform_sku. Business justification: An entitlement grant records the granting of access to a specific platform SKU. entitlement_grant.sku is a denormalized string field that should be replaced by a FK to platform_sku, the master record ',
    `player_account_id` BIGINT COMMENT 'Reference to the player account receiving the entitlement. Links to the player master record.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Entitlement grants (promotional, comp, subscription-based) must reference the policy under which they were issued for compliance audit trails. Regulatory investigations into unauthorized grants or pol',
    `seasonal_event_id` BIGINT COMMENT 'Foreign key linking to content.seasonal_event. Business justification: Event reward grant tracking: entitlement grants issued as seasonal event participation rewards (exclusive cosmetics, event currency) must reference the seasonal_event for event reward auditing, player',
    `spend_limit_control_id` BIGINT COMMENT 'Foreign key linking to compliance.spend_limit_control. Business justification: IAP/MTX entitlement grants must reference the applicable spend limit control to enforce spending cap compliance (Belgium, Netherlands, UK gambling-adjacent regulations). Compliance teams use this link',
    `storefront_id` BIGINT COMMENT 'Reference to the gaming platform where the entitlement is granted (PlayStation, Xbox, Nintendo, Steam, Epic Games Store, Apple App Store, Google Play).',
    `storefront_order_id` BIGINT COMMENT 'Foreign key linking to billing.storefront_order. Business justification: Entitlement grants triggered by purchases must reference the originating storefront order for refund-triggered revocation, customer support audit trails, and entitlement delivery confirmation. source_',
    `subscription_id` BIGINT COMMENT 'Reference to the active subscription if this entitlement is a subscription benefit (GaaS membership perk). Null for non-subscription grants.',
    `activation_date` DATE COMMENT 'The date when the entitlement becomes active and usable by the player. May differ from grant_timestamp for pre-orders or scheduled content releases.',
    `content_version` STRING COMMENT 'The version or build number of the content that this entitlement grants access to. Used for patch management and backward compatibility tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this entitlement grant record was first created in the database. Used for audit trail and data lineage tracking.',
    `current_activations` STRING COMMENT 'The current number of active device or account activations for this entitlement. Used to enforce max_activations limits and track concurrent usage.',
    `device_binding_enabled` BOOLEAN COMMENT 'Indicates whether this entitlement is bound to a specific device (true) or can be used across multiple devices (false). Enforces DRM device restrictions per platform TRC/TCR requirements.',
    `drm_token` STRING COMMENT 'The encrypted DRM token or license key used by the platform SDK to validate entitlement at runtime. Confidential credential for content protection.',
    `entitlement_description` STRING COMMENT 'Detailed description of what the entitlement grants access to, including content items, features, or benefits. Used for player communication and support documentation.',
    `expiry_date` DATE COMMENT 'The date when the entitlement expires and is no longer valid. Null for permanent entitlements. Used for time-limited content, subscriptions, and promotional access.',
    `grant_channel` STRING COMMENT 'The channel or method through which the entitlement was granted: storefront_purchase (IAP or store transaction), key_redemption (product key activation), promotional_grant (marketing campaign), subscription_benefit (GaaS membership perk), bundle_unlock (part of bundle purchase), support_compensation (customer service remedy).. Valid values are `storefront_purchase|key_redemption|promotional_grant|subscription_benefit|bundle_unlock|support_compensation`',
    `grant_notes` STRING COMMENT 'Free-text notes or comments about the entitlement grant, typically used by customer support for manual grants or special circumstances. Used for audit documentation.',
    `grant_source_system` STRING COMMENT 'The system or platform SDK that originated the entitlement grant (Steamworks API, Epic Online Services, PlayStation Network API, Xbox Live Services, Apple StoreKit, Google Play Billing). Used for audit trail and cross-platform reconciliation.',
    `grant_status` STRING COMMENT 'Current lifecycle status of the entitlement grant: active (valid and usable), revoked (administratively withdrawn), expired (past validity period), pending (awaiting activation), suspended (temporarily disabled).. Valid values are `active|revoked|expired|pending|suspended`',
    `grant_timestamp` TIMESTAMP COMMENT 'The precise date and time when the entitlement was granted to the player account. Primary business event timestamp for this transaction.',
    `is_transferable` BOOLEAN COMMENT 'Indicates whether this entitlement can be transferred to another player account (true) or is permanently bound to the original recipient (false). Enforces platform transfer policies and secondary market restrictions.',
    `max_activations` STRING COMMENT 'The maximum number of devices or accounts that can activate this entitlement concurrently. Null indicates unlimited activations. Enforces platform TRC/TCR device limits.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this entitlement grant record was last modified. Used for audit trail and change tracking.',
    `region_code` STRING COMMENT 'Three-letter ISO country code indicating the geographic region where this entitlement is valid. Used for regional licensing restrictions and content rating compliance (ESRB, PEGI, CERO, USK).. Valid values are `^[A-Z]{3}$`',
    `revocation_reason` STRING COMMENT 'The business reason for entitlement revocation: chargeback (payment disputed), fraud (fraudulent acquisition), policy_violation (terms of service breach), refund (purchase refunded), account_closure (player account terminated), license_transfer (moved to different account).. Valid values are `chargeback|fraud|policy_violation|refund|account_closure|license_transfer`',
    `revocation_timestamp` TIMESTAMP COMMENT 'The date and time when the entitlement was revoked, if applicable. Null for active entitlements. Used for audit trail of access rights withdrawal.',
    CONSTRAINT pk_entitlement_grant PRIMARY KEY(`entitlement_grant_id`)
) COMMENT 'Transactional record of a DRM entitlement being granted to a player account on a specific platform. Captures grant timestamp, entitlement type, source transaction reference (IAP, promotion, subscription), platform account ID, device binding details, grant expiry date, revocation status, and grant channel (storefront purchase, key redemption, promotional grant, subscription benefit). Enables audit of player access rights across all platforms.';

CREATE OR REPLACE TABLE `gaming_ecm`.`platform`.`sdk_integration` (
    `sdk_integration_id` BIGINT COMMENT 'Unique identifier for the SDK integration record. Primary key.',
    `ad_network_id` BIGINT COMMENT 'Foreign key linking to marketing.ad_network. Business justification: Ad network SDKs (ironSource, AppLovin, Unity Ads) are integrated into game builds via sdk_integration records. Linking to ad_network enables reconciliation of deployed SDK version against ad network c',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to licensing.compliance_obligation. Business justification: SDK integrations must satisfy licensor-mandated compliance obligations (DRM requirements, data handling requirements). Linking sdk_integration to the specific compliance_obligation it addresses enable',
    `consent_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.consent_policy. Business justification: SDK integrations with analytics_enabled, voice_chat_enabled, or iap_enabled collect player data and must operate under a specific consent policy. GDPR/CCPA compliance requires knowing which consent po',
    `developer_account_id` BIGINT COMMENT 'Foreign key linking to platform.developer_account. Business justification: SDK integrations are registered and managed through a developer account on the platform holders portal. The integration_owner string field becomes redundant as it can be retrieved via JOIN to develop',
    `game_title_id` BIGINT COMMENT 'Reference to the game title for which this SDK is integrated.',
    `network_region_id` BIGINT COMMENT 'Foreign key linking to infrastructure.network_region. Business justification: SDK integrations are region-specific: compliance requirements, latency thresholds, and feature availability (crossplay, matchmaking) vary by network region. Platform teams need this link to enforce re',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: SDK integrations must comply with platform SDK policies governing API usage, data handling, and feature enablement. Compliance teams track which policy version governs each SDK integration for certifi',
    `storefront_id` BIGINT COMMENT 'Reference to the gaming platform (PlayStation, Xbox, Nintendo, PC, Mobile) for this SDK integration.',
    `achievements_enabled` BOOLEAN COMMENT 'Indicates whether the achievements feature is enabled in this SDK integration. True if achievements/trophies are implemented.',
    `analytics_enabled` BOOLEAN COMMENT 'Indicates whether SDK-provided analytics and telemetry collection is enabled. True if player behavior events are sent to platform analytics services.',
    `api_key` STRING COMMENT 'API key or application identifier assigned by the platform for this SDK integration. Used for authentication and entitlement validation. Business-confidential credential.',
    `certification_approval_date` DATE COMMENT 'Date when the platform approved this SDK integration for production release. Null if not yet approved.',
    `certification_compliance_status` STRING COMMENT 'Current compliance status of this SDK integration against platform Technical Requirements Checklist (TRC) or Technical Certification Requirements (TCR). Compliant indicates all requirements met; non-compliant indicates failures; pending-review indicates submission under evaluation; conditionally-approved indicates approval with minor fixes required; not-submitted indicates not yet submitted for certification.. Valid values are `compliant|non-compliant|pending-review|conditionally-approved|not-submitted`',
    `certification_submission_date` DATE COMMENT 'Date when the build with this SDK integration was submitted to the platform for certification review.',
    `cloud_saves_enabled` BOOLEAN COMMENT 'Indicates whether cloud save synchronization is enabled in this SDK integration. True if player progress is backed up to platform cloud storage.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this SDK integration record was first created in the system. Audit trail field.',
    `cross_play_enabled` BOOLEAN COMMENT 'Indicates whether cross-platform multiplayer (cross-play) is enabled in this SDK integration. True if players on different platforms can play together.',
    `deprecation_notice_date` DATE COMMENT 'Date when the platform announced deprecation of this SDK version. Null if SDK is not deprecated.',
    `drm_enabled` BOOLEAN COMMENT 'Indicates whether Digital Rights Management (DRM) entitlement validation is enabled in this SDK integration. True if SDK enforces license verification.',
    `iap_enabled` BOOLEAN COMMENT 'Indicates whether In-App Purchase (IAP) or microtransaction (MTX) functionality is enabled in this SDK integration. True if platform commerce APIs are integrated.',
    `integration_date` DATE COMMENT 'Date when the SDK was first integrated into the game build.',
    `integration_notes` STRING COMMENT 'Free-text notes documenting integration-specific details, known issues, workarounds, or special configuration requirements for this SDK integration.',
    `integration_status` STRING COMMENT 'Current lifecycle status of the SDK integration. Active indicates production-ready; deprecated indicates scheduled for replacement; pending-update indicates newer version available; in-development indicates integration in progress; failed indicates integration issues; sunset indicates SDK no longer supported.. Valid values are `active|deprecated|pending-update|in-development|failed|sunset`',
    `last_validation_date` DATE COMMENT 'Date when this SDK integration was last validated for compliance and functionality. Used for tracking re-certification cycles.',
    `leaderboards_enabled` BOOLEAN COMMENT 'Indicates whether the leaderboards feature is enabled in this SDK integration. True if competitive leaderboards are implemented.',
    `matchmaking_enabled` BOOLEAN COMMENT 'Indicates whether platform matchmaking services are enabled in this SDK integration. True if SDK-provided matchmaking is used.',
    `migration_target_sdk_version` STRING COMMENT 'Target SDK version to which this integration should be migrated when deprecated. Defines the deprecation migration path. Null if no migration required.',
    `minimum_firmware_version` STRING COMMENT 'Minimum console firmware version required for this SDK integration (applicable to console platforms). Used for certification submission validation.',
    `minimum_os_version` STRING COMMENT 'Minimum operating system or firmware version required by this SDK (e.g., iOS 15.0, Android 11, PS5 System Software 21.02-04.00.00). Critical for Technical Requirements Checklist (TRC) and Technical Certification Requirements (TCR) compliance.',
    `sdk_name` STRING COMMENT 'Name of the platform SDK integrated into the game build (e.g., Steamworks, PlayStation SDK, Xbox GDK, Nintendo SDK, Apple GameKit, Google Play Games Services). [ENUM-REF-CANDIDATE: Steamworks|PlayStation SDK|Xbox GDK|Nintendo SDK|Apple GameKit|Google Play Games Services|Epic Online Services|Unity Gaming Services|GameAnalytics SDK|AppsFlyer SDK — 10 candidates stripped; promote to reference product]',
    `sdk_update_deadline` DATE COMMENT 'Deadline date by which this SDK must be updated to a newer version to maintain platform compliance. Critical for avoiding deprecation and ensuring continued certification eligibility.',
    `sdk_version` STRING COMMENT 'Version number of the SDK integrated (e.g., 1.58, 12.0.1, 2023.1.15). Critical for certification compliance and compatibility tracking.',
    `sunset_date` DATE COMMENT 'Date when this SDK version will no longer be supported by the platform and must be replaced. Null if no sunset date announced.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this SDK integration record was last modified. Audit trail field for tracking changes to integration configuration or status.',
    `voice_chat_enabled` BOOLEAN COMMENT 'Indicates whether voice chat functionality is enabled in this SDK integration. True if in-game voice communication is supported.',
    CONSTRAINT pk_sdk_integration PRIMARY KEY(`sdk_integration_id`)
) COMMENT 'Master record of a platform SDK (Software Development Kit) integration registered for a game title build on a specific platform. Tracks SDK name (Steamworks, PlayStation SDK, Xbox GDK, Nintendo SDK, Apple GameKit, Google Play Games Services), SDK version, integration status (active, deprecated, pending-update), minimum OS/firmware requirement, feature flags enabled (achievements, leaderboards, cloud saves, voice chat, cross-play, matchmaking), certification compliance status, SDK update deadline, and deprecation migration path. Enables multi-platform SDK lifecycle management and ensures builds maintain certification-ready SDK versions.';

CREATE OR REPLACE TABLE `gaming_ecm`.`platform`.`release_schedule` (
    `release_schedule_id` BIGINT COMMENT 'Unique identifier for the release schedule record. Primary key for this entity.',
    `age_rating_cert_id` BIGINT COMMENT 'Foreign key linking to compliance.age_rating_cert. Business justification: Release schedules depend on age rating certification completion. Real business process: launch planning and regional availability determination. Releases cannot proceed without valid age ratings for t',
    `cdn_node_id` BIGINT COMMENT 'Foreign key linking to infrastructure.cdn_node. Business justification: Game launches require CDN pre-warming on specific nodes before release. Release coordinators assign a primary CDN node to each release schedule to ensure build availability at launch. This link drives',
    `commercial_term_id` BIGINT COMMENT 'Foreign key linking to licensing.commercial_term. Business justification: Release schedules must respect exclusivity windows, territory expansion options, and marketing approval requirements defined in commercial_term. Release coordinators validate planned release dates and',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: Release scheduling: a release schedule entry coordinates the go-live of a specific content_release on a storefront. Release coordinators align marketing, cert, and deployment timelines against this li',
    `developer_account_id` BIGINT COMMENT 'Foreign key linking to platform.developer_account. Business justification: Release schedules are managed and submitted by developer accounts through the platform portal. Linking release_schedule to developer_account enables tracking which developer account is responsible for',
    `dlc_bundle_id` BIGINT COMMENT 'Foreign key linking to title.dlc_bundle. Business justification: DLC bundles have their own platform release schedules separate from the base game. Release coordinators need this FK to schedule DLC certification submissions, embargo lifts, and go-live timestamps pe',
    `esports_season_id` BIGINT COMMENT 'Foreign key linking to esports.esports_season. Business justification: In live-service games, major patch and content releases are coordinated with esports season start dates. Release coordinators schedule platform releases to align with season launches. This link enable',
    `game_title_id` BIGINT COMMENT 'Reference to the game title being released. Links to the game title master record.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Releases are planned per jurisdiction based on regulatory approval status and regional restrictions. Real business process: regional launch coordination and compliance verification. Jurisdictions dete',
    `launch_event_id` BIGINT COMMENT 'Foreign key linking to marketing.launch_event. Business justification: Release schedules (platform ops) and launch events (marketing) track the same launch from different perspectives. Marketing needs release_schedule dates for embargo planning; platform ops needs launch',
    `maintenance_window_id` BIGINT COMMENT 'Foreign key linking to infrastructure.maintenance_window. Business justification: Release schedules must be validated against planned maintenance windows to prevent launch conflicts. Platform release coordinators use this link to detect scheduling collisions and adjust planned_rele',
    `platform_sku_id` BIGINT COMMENT 'Foreign key linking to platform.platform_sku. Business justification: A release schedule entry plans the release of a specific platform SKU on a storefront. While release_schedule has game_title_id and storefront_id, it lacks a direct FK to the platform_sku which is the',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Release schedules must comply with platform release policies governing embargo periods, preorder rules, and regional release restrictions. Compliance teams use this link in release readiness reviews t',
    `storefront_id` BIGINT COMMENT 'Reference to the gaming platform for this release (PlayStation, Xbox, Nintendo, PC, Mobile). Links to platform master record.',
    `server_fleet_id` BIGINT COMMENT 'Foreign key linking to infrastructure.server_fleet. Business justification: Release schedules coordinate with specific server fleet deployments for launch day. Critical for capacity planning, ensuring fleet readiness at release time, and coordinating marketing/platform releas',
    `actual_release_date` DATE COMMENT 'Actual date when the game title was released and became available to players on this platform and storefront. Null until release occurs.',
    `cancellation_reason` STRING COMMENT 'Explanation for cancellation of the release if status is cancelled. Captures business rationale such as project termination, platform discontinuation, or strategic pivot.',
    `content_rating` STRING COMMENT 'Age and content rating assigned by the governing rating board for this release region (e.g., ESRB: E, E10+, T, M, AO; PEGI: 3, 7, 12, 16, 18; CERO: A, B, C, D, Z). Critical for compliance and storefront listing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this release schedule record was first created in the system. Audit trail for record creation.',
    `cross_platform_enabled` BOOLEAN COMMENT 'Indicates whether cross-platform play or progression is enabled for this release. True if players on this platform can interact with players on other platforms.',
    `day_one_patch_required` BOOLEAN COMMENT 'Indicates whether a mandatory day-one patch is required for the release. True if a patch must be downloaded on launch day to enable full functionality.',
    `delay_reason` STRING COMMENT 'Explanation for any delay or rescheduling of the release. Captures business rationale such as quality issues, certification failures, market conditions, or strategic decisions.',
    `dlc_available` BOOLEAN COMMENT 'Indicates whether downloadable content is available at launch for this release. True if DLC, expansions, or season pass content is offered.',
    `drm_system` STRING COMMENT 'Digital Rights Management system used for this release (e.g., Steamworks DRM, Denuvo, Epic Online Services, platform-native DRM). Manages entitlement and anti-piracy protection.',
    `embargo_lift_timestamp` TIMESTAMP COMMENT 'Date and time when media embargo restrictions are lifted and press/influencers can publish reviews and coverage. Critical for coordinating marketing and PR activities.',
    `excluded_regions` STRING COMMENT 'Geographic regions or markets explicitly excluded from this release due to regulatory, licensing, or business reasons. Comma-separated list of ISO 3166-1 alpha-3 country codes.',
    `gold_master_date` DATE COMMENT 'Date when the game build was declared Gold Master (final, release-ready build). Marks completion of development and readiness for manufacturing or digital distribution.',
    `launch_edition` STRING COMMENT 'Edition or SKU variant for this release (e.g., Standard Edition, Deluxe Edition, Ultimate Edition, Collectors Edition). Defines content bundle and pricing tier.',
    `marketing_golive_date` DATE COMMENT 'Date when marketing campaigns and promotional activities are activated for this release. Coordinates advertising, social media, and promotional efforts.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this release schedule record was last modified. Audit trail for tracking changes to release plans.',
    `mtx_enabled` BOOLEAN COMMENT 'Indicates whether in-game microtransactions are enabled for this release. True if players can make in-app purchases for virtual goods, currency, or content.',
    `physical_release` BOOLEAN COMMENT 'Indicates whether a physical disc or cartridge version is available for this release. True if physical media is manufactured and distributed.',
    `planned_release_date` DATE COMMENT 'Originally planned date for the game title release on this platform and storefront. Used for initial launch planning and coordination.',
    `platform_approval_status` STRING COMMENT 'Current status of the platform holder certification and approval process. Tracks TRC/TCR compliance review and approval workflow. [ENUM-REF-CANDIDATE: not_submitted|submitted|under_review|approved|rejected|conditional_approval|resubmission_required — 7 candidates stripped; promote to reference product]',
    `preorder_discount_percent` DECIMAL(18,2) COMMENT 'Percentage discount offered for pre-order purchases. Null if no pre-order discount is available.',
    `preorder_start_date` DATE COMMENT 'Date when pre-order sales begin on this platform and storefront. Enables early revenue capture and demand forecasting.',
    `price_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the release price (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `release_coordinator_name` STRING COMMENT 'Name of the individual or team responsible for coordinating this release. Primary point of contact for release planning and execution.',
    `release_identifier` STRING COMMENT 'Business identifier for this release event. May be a combination of game title code, platform code, and release wave identifier used for tracking and coordination.',
    `release_notes` STRING COMMENT 'Internal notes and comments about this release schedule. Captures coordination details, special requirements, known issues, or stakeholder communications.',
    `release_price` DECIMAL(18,2) COMMENT 'Standard retail price for the game at release on this platform and storefront. Expressed in the storefronts default currency.',
    `release_region_scope` STRING COMMENT 'Geographic regions or markets included in this release. Comma-separated list of ISO 3166-1 alpha-3 country codes or region identifiers (e.g., USA,CAN,MEX or EMEA or APAC). Defines market availability.',
    `release_status` STRING COMMENT 'Current lifecycle status of the release schedule. Tracks progression from planning through platform certification to actual release or cancellation. [ENUM-REF-CANDIDATE: planned|scheduled|submitted|approved|rejected|delayed|released|cancelled — 8 candidates stripped; promote to reference product]',
    `release_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the game title went live on the storefront. Captures exact moment of availability for time-zone-specific launches and coordinated global releases.',
    `release_type` STRING COMMENT 'Classification of the release event type. Worldwide indicates simultaneous global launch, regional indicates specific geographic markets, soft launch indicates limited market testing, hard launch indicates full market entry, early access indicates paid pre-release access, full launch indicates final public release. [ENUM-REF-CANDIDATE: worldwide|regional|soft_launch|hard_launch|early_access|full_launch|beta|alpha|demo — 9 candidates stripped; promote to reference product]',
    `scheduled_release_date` DATE COMMENT 'Current scheduled date for the release after any adjustments or delays. This is the active target date for launch coordination.',
    CONSTRAINT pk_release_schedule PRIMARY KEY(`release_schedule_id`)
) COMMENT 'Master record of a planned or confirmed game title release event on a specific platform and storefront. Captures planned release date, actual release date, release type (worldwide, regional, soft launch, hard launch, early access, full launch), embargo lift datetime, pre-order availability date, platform holder approval status, marketing go-live date, and release region scope. Enables multi-platform launch coordination and release calendar management.';

CREATE OR REPLACE TABLE `gaming_ecm`.`platform`.`storefront_listing` (
    `storefront_listing_id` BIGINT COMMENT 'Unique identifier for the storefront listing record. Primary key.',
    `age_rating_cert_id` BIGINT COMMENT 'Foreign key linking to compliance.age_rating_cert. Business justification: Storefront listings display age ratings and require valid certificates. Real business process: listing approval and content descriptor display. Listings cannot be published without valid age rating ce',
    `asset_bundle_id` BIGINT COMMENT 'Foreign key linking to content.asset_bundle. Business justification: Downloadable content package association: storefront listings must reference the asset_bundle representing the downloadable game package for CDN distribution, download size reporting to players, and p',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Campaigns drive traffic to specific storefront listing variants. ASO and paid UA teams run A/B tests where different campaigns target different listing variants (screenshots, descriptions) to measure ',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: Storefront listing version management: a listing reflects a specific content_release version for update prompts, version display, and compliance. Listing managers need this link to trigger listing upd',
    `dlc_bundle_id` BIGINT COMMENT 'Foreign key linking to title.dlc_bundle. Business justification: DLC bundles are listed and sold as independent items on storefronts with their own listing pages, pricing, and descriptions. Storefront merchandising teams need this FK to manage DLC listings separate',
    `game_title_id` BIGINT COMMENT 'Reference to the game title that this listing represents.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to content.asset. Business justification: Storefront listings require icon assets for display. Marketing teams manage specific asset references for each listing. Replaces denormalized icon_asset_reference with proper FK for asset management w',
    `launch_event_id` BIGINT COMMENT 'Foreign key linking to marketing.launch_event. Business justification: Store page publish date is a key milestone in launch event planning. Marketing tracks store_featuring_status on launch_event; linking storefront_listing to launch_event enables launch readiness report',
    `league_id` BIGINT COMMENT 'Foreign key linking to esports.league. Business justification: Storefronts sell esports league passes and season content as distinct listings. Linking storefront_listing to league enables commercial reporting on league-specific storefront revenue, featured placem',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: Storefront listings for licensed IP content require IP reference for trademark attribution compliance, brand usage guideline enforcement, and automated royalty reporting on listing views/conversions p',
    `loot_box_disclosure_id` BIGINT COMMENT 'Foreign key linking to compliance.loot_box_disclosure. Business justification: Listings with loot boxes must display probability disclosures per regulatory requirements. Real business process: consumer protection compliance and disclosure enforcement. Listings cannot be publishe',
    `platform_sku_id` BIGINT COMMENT 'Reference to the purchasable product definition and pricing tier that this listing represents on the storefront.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Storefront listings must comply with content policies governing descriptions, screenshots, and feature claims. Compliance teams audit listings against policy versions; privacy_policy_url and terms_of_',
    `pricing_id` BIGINT COMMENT 'Foreign key linking to platform.pricing. Business justification: A storefront listing displays pricing information for the game title. Linking storefront_listing to pricing normalizes the price display on the listing page, enabling the listing to reference the auth',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Storefront listings with in_app_purchases, multiplayer_support, or UGC trigger specific regulatory obligations (disclosure requirements, age verification, data protection notices). Compliance teams ne',
    `release_schedule_id` BIGINT COMMENT 'Foreign key linking to platform.release_schedule. Business justification: A storefront listing is published in conjunction with a release schedule event. Linking storefront_listing to release_schedule enables tracking the listings publication status against the planned rel',
    `seasonal_event_id` BIGINT COMMENT 'Foreign key linking to content.seasonal_event. Business justification: Event-driven merchandising: storefront listings are created specifically for seasonal events (holiday sales, event DLC). Platform merchandising teams link listings to seasonal events for event-driven ',
    `storefront_id` BIGINT COMMENT 'Reference to the specific storefront platform where this listing is published (Steam, Epic Games Store, PlayStation Store, Xbox Store, Nintendo eShop, Apple App Store, Google Play).',
    `tournament_id` BIGINT COMMENT 'Foreign key linking to esports.tournament. Business justification: Tournament spectator passes, entry bundles, and tournament-specific DLC are sold as storefront listings. Linking storefront_listing to tournament enables tournament-specific commercial tracking, reven',
    `aggregate_review_score` DECIMAL(18,2) COMMENT 'Average user review rating for this listing, typically on a scale of 0.00 to 5.00. Calculated by the storefront platform from user-submitted reviews.',
    `aso_keywords` STRING COMMENT 'Comma-separated list of keywords optimized for storefront search ranking and discovery. Used for ASO strategy and A/B testing. Confidential competitive intelligence.',
    `content_descriptors` STRING COMMENT 'Comma-separated list of content warning descriptors associated with the content rating (e.g., Violence, Blood, Strong Language, In-Game Purchases, Online Interactions).',
    `content_rating` STRING COMMENT 'Age-appropriateness rating assigned by the governing body for the storefront region (e.g., ESRB: E, E10+, T, M, AO; PEGI: 3, 7, 12, 16, 18; CERO: A, B, C, D, Z).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this storefront listing record was first created in the system.',
    `cross_platform_play` BOOLEAN COMMENT 'Indicates whether the game supports cross-platform multiplayer (e.g., PlayStation players can play with Xbox players).',
    `developer_name` STRING COMMENT 'Name of the game developer or studio displayed on the storefront listing.',
    `drm_type` STRING COMMENT 'The type of DRM system applied to this listing (e.g., Steamworks, Denuvo, Epic Online Services, None).',
    `feature_bullets` STRING COMMENT 'Comma-separated or newline-separated list of key game features and highlights presented as bullet points on the listing page.',
    `file_size_mb` DECIMAL(18,2) COMMENT 'The download file size of the game in megabytes. Critical for user download decisions, especially on mobile platforms.',
    `genre_tags` STRING COMMENT 'Comma-separated list of genre tags applied to the listing for discovery and filtering (e.g., FPS, MMORPG, Battle Royale, Roguelike, Metroidvania).',
    `hero_image_asset_reference` STRING COMMENT 'Asset ID or URL referencing the large hero banner image displayed at the top of the listing page.',
    `in_app_purchases` BOOLEAN COMMENT 'Indicates whether the game offers in-app purchases or microtransactions (MTX). Required disclosure for mobile storefronts.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this storefront listing record was last modified in the system.',
    `last_updated_date` DATE COMMENT 'The date when the game or listing content was last updated on the storefront (e.g., patch release, content update, metadata refresh).',
    `listing_status` STRING COMMENT 'Current lifecycle status of the storefront listing. Draft: being prepared; Pending Review: submitted for platform certification; Live: publicly visible; Delisted: removed from storefront; Rejected: failed certification; Suspended: temporarily removed.. Valid values are `draft|pending_review|live|delisted|rejected|suspended`',
    `listing_title` STRING COMMENT 'The public-facing product title displayed on the storefront listing page. May differ from the canonical game title for App Store Optimization (ASO) purposes.',
    `localization_language_code` STRING COMMENT 'ISO 639-1 language code (with optional ISO 3166-1 alpha-2 country code) for the language of this listing version (e.g., en-US, ja-JP, de-DE, fr-FR).. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `long_description` STRING COMMENT 'Full marketing description of the game displayed on the detailed listing page. Includes gameplay features, story overview, and key selling points.',
    `multiplayer_support` BOOLEAN COMMENT 'Indicates whether the game supports multiplayer gameplay (online or local).',
    `primary_category` STRING COMMENT 'The main storefront category under which this listing is classified (e.g., Action, Adventure, Role-Playing, Strategy, Sports). Category taxonomy varies by storefront.',
    `published_timestamp` TIMESTAMP COMMENT 'Timestamp when this listing was first published and made live on the storefront platform.',
    `publisher_name` STRING COMMENT 'Name of the game publisher displayed on the storefront listing.',
    `release_date` DATE COMMENT 'The official release date of the game on this storefront platform. May differ from the global launch date for regional releases.',
    `review_count` BIGINT COMMENT 'Total number of user reviews submitted for this listing on the storefront platform.',
    `screenshot_asset_references` STRING COMMENT 'Comma-separated list of asset IDs or URLs referencing the screenshot images displayed on the listing page. Order determines display sequence.',
    `short_description` STRING COMMENT 'Brief marketing description of the game, typically displayed in search results and browse views. Character limits vary by storefront (e.g., 80 chars for mobile app stores).',
    `support_url` STRING COMMENT 'URL to the player support or help center for this game.',
    `supported_languages` STRING COMMENT 'Comma-separated list of languages supported by the game for interface, audio, and subtitles (e.g., English, Japanese, Spanish, French, German).',
    `supported_platforms` STRING COMMENT 'Comma-separated list of platform hardware or operating systems this listing supports (e.g., PlayStation 5, Xbox Series X, Windows 10, iOS 15+, Android 11+).',
    `trailer_asset_references` STRING COMMENT 'Comma-separated list of asset IDs or URLs referencing the video trailers displayed on the listing page. Order determines display sequence.',
    `version_number` STRING COMMENT 'The current version number of the game build associated with this listing (e.g., 1.0.0, 2.3.1).',
    CONSTRAINT pk_storefront_listing PRIMARY KEY(`storefront_listing_id`)
) COMMENT 'Master record of a game titles public-facing product listing page on a specific storefront, managing all consumer-visible metadata and ASO (App Store Optimization) content. Captures listing title, short and long descriptions, feature bullet points, screenshot and trailer asset references, localization language, storefront category and genre tags, ASO keywords, user review score aggregate, review count, listing status (draft, pending review, live, delisted), and last updated timestamp. Distinct from platform_sku which owns the purchasable product definition and pricing tier — this product owns the marketing/discovery presentation layer. Enables storefront presence management, A/B testing of listing content, and ASO optimization across all distribution channels.';

CREATE OR REPLACE TABLE `gaming_ecm`.`platform`.`pricing` (
    `pricing_id` BIGINT COMMENT 'Unique identifier for the pricing record. Primary key for the pricing configuration entity.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Promotional campaigns are timed with pricing changes (launch discounts, seasonal sales). Campaign creative must reflect current pricing; UA teams need to know which campaign drove purchases at which p',
    `commercial_term_id` BIGINT COMMENT 'Foreign key linking to licensing.commercial_term. Business justification: Platform pricing must comply with MAP (minimum advertised price) and royalty basis defined in commercial_term. Pricing approval workflows require this link to validate that promotional discounts and p',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: Content release pricing configuration: pricing records are created when new content releases (DLC, expansions, season passes) launch. Pricing teams link prices to content_release for revenue reporting',
    `game_title_id` BIGINT COMMENT 'Reference to the game title for which this pricing configuration applies.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Pricing must comply with jurisdiction-specific tax rules, consumer protection laws, and currency regulations. Real business process: regional pricing strategy and tax compliance. Jurisdictions determi',
    `league_id` BIGINT COMMENT 'Foreign key linking to esports.league. Business justification: League passes and season subscriptions sold on the platform have dedicated pricing records. Linking pricing to league enables league-specific pricing strategy management, regional price differentiatio',
    `loot_box_disclosure_id` BIGINT COMMENT 'Foreign key linking to compliance.loot_box_disclosure. Business justification: Pricing records for loot box content must reference the loot_box_disclosure to ensure disclosed odds align with pricing tiers. Regulatory audits in Belgium/Netherlands require verifiable linkage betwe',
    `network_region_id` BIGINT COMMENT 'Foreign key linking to infrastructure.network_region. Business justification: Pricing is region-scoped (regional_pricing_strategy, regional_availability). The plain region_code attribute is a denormalized network_region reference. Linking to network_region supports regional pri',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Pricing records must comply with platform pricing policies governing promotional discounts, price parity, and regional pricing strategies. Compliance teams track which policy version governs each pric',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Pricing records must comply with regulatory obligations including price transparency laws, VAT display requirements, and minimum advertised price rules. Compliance teams use this link to audit pricing',
    `release_schedule_id` BIGINT COMMENT 'Foreign key linking to platform.release_schedule. Business justification: Pricing configurations are often tied to specific release events — launch pricing, preorder pricing windows, and day-one discounts are all release-schedule-driven. Linking pricing to release_schedule ',
    `seasonal_event_id` BIGINT COMMENT 'Foreign key linking to content.seasonal_event. Business justification: Seasonal promotional pricing: pricing records created for seasonal event promotions must reference the triggering seasonal_event for event ROI reporting, promotional discount audit, and loot box discl',
    `spend_limit_control_id` BIGINT COMMENT 'Foreign key linking to compliance.spend_limit_control. Business justification: MTX/IAP pricing records must reference applicable spend limit controls to ensure pricing tiers comply with spending cap regulations. Compliance teams verify that pricing structures do not circumvent s',
    `storefront_id` BIGINT COMMENT 'Reference to the digital storefront or platform where this pricing is configured (e.g., Steam, Epic Games Store, PlayStation Store, Xbox Store, Nintendo eShop, Apple App Store, Google Play).',
    `title_sku_id` BIGINT COMMENT 'Foreign key linking to title.sku. Business justification: Pricing is set per SKU for regional/edition differentiation. Real pricing systems manage SKU-level price points (Standard vs Deluxe, US vs EU) with promotional tiers, revenue share calculations, and t',
    `approval_status` STRING COMMENT 'Platform certification or internal approval status for the pricing configuration. Required for compliance with platform holder pricing policies.. Valid values are `not_submitted|pending|approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the person or system that approved the pricing configuration.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the pricing configuration was approved.',
    `base_price` DECIMAL(18,2) COMMENT 'Standard retail price for the game title in the specified currency before any promotional discounts or adjustments.',
    `bundle_eligible` BOOLEAN COMMENT 'Indicates whether this pricing configuration can be included in promotional bundles or multi-game packages.',
    `content_type` STRING COMMENT 'Type of game content being priced. Base Game = full game, DLC (Downloadable Content) = add-on content, Season Pass = bundle of future DLC, Expansion = major content addition, Cosmetic = visual items, Currency = in-game virtual currency, Subscription = recurring access. [ENUM-REF-CANDIDATE: base_game|dlc|season_pass|expansion|cosmetic|currency|subscription — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this pricing record was first created in the system.',
    `cross_platform_pricing_group` STRING COMMENT 'Identifier for grouping pricing records that should maintain parity across multiple platforms (e.g., same price on Steam and Epic Games Store). Used for cross-platform pricing strategy enforcement.. Valid values are `^[A-Z0-9_]{1,30}$`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the pricing (e.g., USD, EUR, GBP, JPY, AUD).. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date when this pricing configuration expires or is replaced. Null for open-ended pricing.',
    `effective_start_date` DATE COMMENT 'Date when this pricing configuration becomes active and available for purchase.',
    `minimum_advertised_price` DECIMAL(18,2) COMMENT 'Minimum Advertised Price - the lowest price at which the game title can be advertised or promoted, as stipulated by publisher agreements or platform policies. Null if no MAP restriction applies.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this pricing record was last modified.',
    `notes` STRING COMMENT 'Free-text notes or comments about the pricing configuration, including special conditions, exceptions, or context for pricing decisions.',
    `platform_revenue_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of gross revenue retained by the platform holder (e.g., 30.00 for Steams standard 30% cut, 12.00 for Epic Games Stores 12% cut). Used for net revenue calculation.',
    `previous_base_price` DECIMAL(18,2) COMMENT 'The base price that was in effect immediately before the current pricing configuration. Used for price history tracking and change analysis.',
    `price_change_date` DATE COMMENT 'Date when the most recent price change occurred. Null if this is the original pricing.',
    `price_change_reason` STRING COMMENT 'Business justification or reason code for the price change (e.g., seasonal promotion, competitive adjustment, currency fluctuation, content update, end-of-life discount).',
    `price_lock_enabled` BOOLEAN COMMENT 'Indicates whether the pricing is locked and cannot be changed without special authorization. Used for contractual price guarantees or regulatory compliance.',
    `price_lock_reason` STRING COMMENT 'Explanation for why the pricing is locked (e.g., contractual obligation, pre-order guarantee, regulatory requirement). Null if price_lock_enabled is false.',
    `price_tier` STRING COMMENT 'Platform-specific pricing tier or bracket identifier used by storefronts for regional price standardization (e.g., TIER_1, TIER_5, PREMIUM, BUDGET).. Valid values are `^[A-Z0-9_]{1,20}$`',
    `pricing_status` STRING COMMENT 'Current lifecycle status of the pricing configuration. Draft = being configured, Pending Approval = submitted for review, Approved = ready for activation, Active = currently in effect, Suspended = temporarily disabled, Archived = historical record.. Valid values are `draft|pending_approval|approved|active|suspended|archived`',
    `promotional_discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied during the promotional period (e.g., 25.00 for 25% off). Null if no active promotion.',
    `promotional_end_date` DATE COMMENT 'Date when the promotional pricing expires and base price resumes. Null if no active promotion or open-ended promotion.',
    `promotional_price` DECIMAL(18,2) COMMENT 'Discounted price during a promotional period. Null if no active promotion.',
    `promotional_start_date` DATE COMMENT 'Date when the promotional pricing becomes effective. Null if no active promotion.',
    `recommended_retail_price` DECIMAL(18,2) COMMENT 'Recommended Retail Price - the suggested retail price set by the publisher. May differ from actual base price due to regional adjustments or retailer discretion.',
    `regional_pricing_strategy` STRING COMMENT 'Pricing strategy applied for this region. Standard = base conversion, Purchasing Power Parity = adjusted for local economic conditions, Competitive = matched to local market, Premium = higher tier positioning, Budget = value positioning.. Valid values are `standard|purchasing_power_parity|competitive|premium|budget`',
    `sku` STRING COMMENT 'Stock Keeping Unit - unique product identifier used by the storefront for inventory and sales tracking. Platform-specific identifier.. Valid values are `^[A-Z0-9_-]{1,50}$`',
    `tax_handling_method` STRING COMMENT 'Indicates whether the displayed price includes tax (inclusive), excludes tax to be added at checkout (exclusive), or is tax-exempt.. Valid values are `inclusive|exclusive|exempt`',
    `tax_rate_percentage` DECIMAL(18,2) COMMENT 'Applicable sales tax, VAT (Value Added Tax), or GST (Goods and Services Tax) rate percentage for the region (e.g., 20.00 for UK VAT, 10.00 for Japan consumption tax). Null if tax-exempt.',
    CONSTRAINT pk_pricing PRIMARY KEY(`pricing_id`)
) COMMENT 'Master record of a game titles pricing configuration on a specific storefront and region. Captures base price, currency, regional price tier, promotional price, promotional window start/end dates, price history, platform holder revenue share percentage, tax handling method (inclusive/exclusive), and pricing approval status. Enables multi-region, multi-storefront pricing management and revenue share calculation inputs.';

CREATE OR REPLACE TABLE `gaming_ecm`.`platform`.`patch_release` (
    `patch_release_id` BIGINT COMMENT 'Unique identifier for the patch release record. Primary key.',
    `age_rating_cert_id` BIGINT COMMENT 'Foreign key linking to compliance.age_rating_cert. Business justification: Patches with content changes may require age rating re-certification. Real business process: content update compliance and rating maintenance. Material content changes trigger rating review and potent',
    `build_artifact_id` BIGINT COMMENT 'Foreign key linking to title.build_artifact. Business justification: Patch releases deploy specific build artifacts to platforms. Real patch management tracks exact artifact versions for rollback capability, delta patch calculation, certification compliance, and player',
    `cdn_node_id` BIGINT COMMENT 'Foreign key linking to infrastructure.cdn_node. Business justification: Patch releases are distributed via CDN. The existing cdn_distribution_url is a denormalized CDN reference. Linking to cdn_node enables patch download performance monitoring, CDN incident impact assess',
    `cert_submission_id` BIGINT COMMENT 'Foreign key linking to platform.platform_cert_submission. Business justification: Patch releases require platform certification before deployment. patch_release has certification_date and certification_status as denormalized fields that duplicate data from platform_cert_submission.',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to licensing.compliance_obligation. Business justification: Patch releases may be required to satisfy specific licensor compliance obligations (e.g., mandatory DRM updates, content restriction clause enforcement). Linking patch_release to the compliance_obliga',
    `consent_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.consent_policy. Business justification: Patches with requires_player_consent=true or privacy_policy_updated=true must reference the new consent policy version being deployed. Compliance teams use this link to track which consent policy vers',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: Cross-domain patch traceability: platform patch_release is the platform-side distribution record; content_release is the content-side record. Linking them enables end-to-end patch audit trails require',
    `developer_account_id` BIGINT COMMENT 'Foreign key linking to platform.developer_account. Business justification: Patch releases are published through a developer account on the platform portal. Linking patch_release to developer_account enables tracking which developer account submitted and published each patch,',
    `game_title_id` BIGINT COMMENT 'Reference to the game title this patch applies to.',
    `infrastructure_deployment_id` BIGINT COMMENT 'Foreign key linking to infrastructure.infrastructure_deployment. Business justification: Patch releases trigger infrastructure deployments with specific rollout strategies and deployment windows. Essential for coordinating client and server patch rollouts, tracking deployment status, and ',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: Patches to licensed content require agreement reference for certification compliance verification when middleware versions change, brand asset updates occur, or content modifications trigger licensor ',
    `loot_box_disclosure_id` BIGINT COMMENT 'Foreign key linking to compliance.loot_box_disclosure. Business justification: Patches with contains_monetization_changes=true that modify loot box mechanics must reference the updated loot_box_disclosure record. Platform cert review and regulatory compliance require verifying d',
    `maintenance_window_id` BIGINT COMMENT 'Foreign key linking to infrastructure.maintenance_window. Business justification: Patches are routinely deployed during scheduled maintenance windows to minimize player disruption. Linking patch_release to maintenance_window enables patch deployment scheduling, player communication',
    `asset_bundle_id` BIGINT COMMENT 'Foreign key linking to content.asset_bundle. Business justification: Platform patches deploy specific asset bundles containing updated content. Live ops teams track which bundle is included in each platform patch for version control and player support.',
    `platform_sku_id` BIGINT COMMENT 'Foreign key linking to platform.platform_sku. Business justification: A patch release targets a specific platform SKU — the exact platform-specific version of the game being patched. While patch_release has game_title_id and storefront_id, it lacks a direct FK to the pl',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Patch releases must comply with platform content and certification policies. Compliance teams track which policy version governs each patch for cert submission validation, especially for patches with ',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Patches that change monetization, data collection, or content must comply with regulatory disclosure requirements. Real business process: patch approval and player notification requirements. Material ',
    `release_schedule_id` BIGINT COMMENT 'Foreign key linking to platform.release_schedule. Business justification: A patch_release represents a game update deployed on a specific platform. The release_schedule governs the planned release window and approval timeline for game releases and updates. Linking patch_rel',
    `sdk_integration_id` BIGINT COMMENT 'Foreign key linking to platform.sdk_integration. Business justification: Patches frequently include SDK updates (e.g., updating from SDK 3.1 to 3.2 for a platform). patch_release.sdk_version is a denormalized string that should be replaced by a FK to sdk_integration, the m',
    `server_fleet_id` BIGINT COMMENT 'Foreign key linking to infrastructure.server_fleet. Business justification: Patches are deployed to specific server fleets with coordinated rollout strategies. Required for patch deployment tracking, fleet version management, and coordinating client patch releases with server',
    `storefront_id` BIGINT COMMENT 'Reference to the platform on which this patch is released (PlayStation, Xbox, Nintendo, Steam, Epic Games Store, Apple App Store, Google Play).',
    `title_season_id` BIGINT COMMENT 'Foreign key linking to title.title_season. Business justification: Patches are frequently tied to season launches — season patches, balance updates, and mid-season content drops are coordinated live-ops events. Live-ops and platform teams need this FK to associate pa',
    `age_rating_impact` STRING COMMENT 'Indicates whether this patch affects the games age rating: none (no impact), content_descriptor_added (new content descriptors required), rating_change_required (full re-rating needed). Compliance with ESRB, PEGI, CERO, USK, GRAC.. Valid values are `none|content_descriptor_added|rating_change_required`',
    `anti_cheat_version` STRING COMMENT 'Version of anti-cheat system included in this patch. Critical for competitive and esports titles.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when this patch was approved for release. Governance audit trail.',
    `build_number` STRING COMMENT 'Internal build identifier from the CI/CD (Continuous Integration/Continuous Deployment) pipeline. Links patch to specific code commit and build artifacts.',
    `checksum_md5` STRING COMMENT 'MD5 hash of the patch file for integrity verification. Ensures download was not corrupted.. Valid values are `^[a-f0-9]{32}$`',
    `checksum_sha256` STRING COMMENT 'SHA-256 hash of the patch file for enhanced integrity verification and security validation.. Valid values are `^[a-f0-9]{64}$`',
    `contains_monetization_changes` BOOLEAN COMMENT 'Indicates whether this patch includes changes to in-game monetization, microtransactions (MTX), or in-app purchases (IAP). May require additional platform review.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this patch release record was first created in the system. Audit trail.',
    `download_priority` STRING COMMENT 'Priority level for patch download and installation: critical (immediate mandatory), high (recommended urgent), normal (standard update), low (optional enhancement).. Valid values are `critical|high|normal|low`',
    `drm_version` STRING COMMENT 'Version of Digital Rights Management system included in this patch. Ensures entitlement validation and anti-piracy measures.',
    `estimated_install_time_minutes` STRING COMMENT 'Estimated time in minutes for patch installation and verification. Helps set player expectations.',
    `is_cross_platform_compatible` BOOLEAN COMMENT 'Indicates whether this patch maintains cross-platform play compatibility with other platforms. Critical for multiplayer games.',
    `known_issues_url` STRING COMMENT 'URL to documentation of known issues in this patch. Transparency for player support.',
    `localization_languages_added` STRING COMMENT 'Comma-separated list of new language codes added in this patch (ISO 639-1 format). Expands market reach.',
    `patch_notes_summary` STRING COMMENT 'High-level summary of changes included in this patch. Player-facing description of bug fixes, features, and improvements.',
    `patch_size_bytes` BIGINT COMMENT 'Total download size of the patch in bytes. Critical for player experience and bandwidth planning.',
    `patch_status` STRING COMMENT 'Current lifecycle status of the patch: development (in progress), submitted (sent to platform for certification), certified (passed TRC/TCR), released (live to players), rolled_back (reverted due to issues), deprecated (superseded by newer patch).. Valid values are `development|submitted|certified|released|rolled_back|deprecated`',
    `patch_type` STRING COMMENT 'Classification of the patch: mandatory (required for play), optional (player choice), hotfix (critical bug fix), content_update (new features/content), dlc_unlock (downloadable content enabler), balance_patch (gameplay tuning).. Valid values are `mandatory|optional|hotfix|content_update|dlc_unlock|balance_patch`',
    `patch_version` STRING COMMENT 'Semantic version number of the patch (e.g., 1.2.3 or 1.2.3.4). Follows semantic versioning convention.. Valid values are `^[0-9]+.[0-9]+.[0-9]+(.[0-9]+)?$`',
    `privacy_policy_updated` BOOLEAN COMMENT 'Indicates whether this patch includes updates to the games privacy policy or data collection practices. Triggers consent requirements under GDPR and COPPA.',
    `release_date` DATE COMMENT 'Date when the patch was released to players on this platform. Represents the go-live event.',
    `release_notes_url` STRING COMMENT 'URL to the full detailed release notes for this patch. Player-facing documentation.',
    `requires_player_consent` BOOLEAN COMMENT 'Indicates whether this patch requires explicit player consent before installation (e.g., for terms of service updates, data collection changes). Compliance requirement.',
    `rollback_available` BOOLEAN COMMENT 'Indicates whether players can rollback to the previous version if issues occur. Platform-dependent capability.',
    `rollout_percentage` DECIMAL(18,2) COMMENT 'Percentage of player base receiving the patch in staged rollout (0.00 to 100.00). Used for gradual deployment to monitor stability.',
    `rollout_strategy` STRING COMMENT 'Deployment strategy for the patch: full (immediate global release), staged (gradual percentage rollout), regional (specific geographic markets first), beta (limited test audience).. Valid values are `full|staged|regional|beta`',
    `submission_date` DATE COMMENT 'Date when the patch was submitted to the platform holder for certification review (TRC/TCR compliance).',
    `trc_checklist_version` STRING COMMENT 'Version of the Technical Requirements Checklist used for certification. Platform-specific compliance document version.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this patch release record was last modified. Audit trail for lifecycle changes.',
    CONSTRAINT pk_patch_release PRIMARY KEY(`patch_release_id`)
) COMMENT 'Master record of a game title patch or update released on a specific platform. Captures patch version, patch type (mandatory, optional, hotfix, content update, DLC unlock), patch size (bytes), release date per platform, patch notes summary, minimum base game version required, platform certification status for the patch, and rollout strategy (staged rollout percentage, full rollout). Enables patch lifecycle management across all platforms.';

CREATE OR REPLACE TABLE `gaming_ecm`.`platform`.`developer_account` (
    `developer_account_id` BIGINT COMMENT 'Unique identifier for the developer account record. Primary key.',
    `consent_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.consent_policy. Business justification: Developer accounts operating in GDPR/CCPA jurisdictions must operate under a specific consent policy governing their data processing as data controllers/processors. Developer onboarding compliance rev',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Developer accounts are registered under specific jurisdictions with applicable tax and legal requirements. Real business process: account setup and regulatory compliance tracking. Jurisdiction determi',
    `licensee_id` BIGINT COMMENT 'Foreign key linking to licensing.licensee. Business justification: Developer accounts ARE licensees holding platform SDK licenses, middleware agreements, and brand partnership rights. Fundamental business identity link for contract management, royalty reporting, comp',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Developer accounts must comply with platform developer policies governing SDK usage, revenue share, and content standards. Compliance teams track which policy version governs each developer account fo',
    `account_identifier` STRING COMMENT 'The externally-known unique account identifier or username assigned by the platform holders developer portal (e.g., PlayStation DevNet account ID, Xbox Partner Center account ID, Steamworks partner account ID).',
    `account_manager_email` STRING COMMENT 'Email address of the platform holders account manager for direct support and escalation.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `account_manager_name` STRING COMMENT 'Name of the platform holders account manager or partner representative assigned to this developer account.',
    `account_name` STRING COMMENT 'The registered legal or business name associated with the developer account.',
    `account_tier` STRING COMMENT 'The tier or level of the developer account, which may determine access to resources, support level, and revenue share terms.. Valid values are `indie|standard|professional|enterprise|partner|preferred`',
    `account_type` STRING COMMENT 'Classification of the account role within the platform ecosystem (developer, publisher, or combined developer-publisher).. Valid values are `developer|publisher|developer_publisher|contractor|service_provider|middleware_provider`',
    `api_key` STRING COMMENT 'The API key or access token issued to this developer account for programmatic access to platform services.',
    `business_address` STRING COMMENT 'The registered business address of the developer or publisher organization.',
    `certification_access_flag` BOOLEAN COMMENT 'Indicates whether the account has access to submit titles for platform certification and TRC (Technical Requirements Checklist) / TCR (Technical Certification Requirements) compliance review.',
    `contract_status` STRING COMMENT 'Current status of the developer agreement or contract with the platform holder.. Valid values are `active|expired|pending_renewal|terminated|under_negotiation`',
    `country_code` STRING COMMENT 'Three-letter ISO country code representing the primary country of business operations for this developer account.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this developer account record was first created in the system.',
    `cross_platform_enabled` BOOLEAN COMMENT 'Indicates whether the account is enabled for cross-platform development and deployment capabilities.',
    `dev_kit_access_flag` BOOLEAN COMMENT 'Indicates whether the account has been granted access to order or receive development hardware kits.',
    `drm_entitlement_access` BOOLEAN COMMENT 'Indicates whether the account has access to DRM entitlement systems for managing digital rights and licenses.',
    `enrolled_programs` STRING COMMENT 'Comma-separated list of platform-specific programs the account is enrolled in (e.g., dev kit access, early SDK (Software Development Kit) access, beta programs, ID@Xbox, PlayStation Indies).',
    `enrollment_date` DATE COMMENT 'The date when the developer account was first enrolled and approved by the platform holder.',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the developer account enrollment with the platform holder.. Valid values are `active|suspended|pending|terminated|under_review|probation`',
    `last_login_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent login to the developer portal by this account.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this developer account record was last modified or updated.',
    `nda_expiry_date` DATE COMMENT 'The date when the non-disclosure agreement expires and requires renewal.',
    `nda_signed_date` DATE COMMENT 'The date when the developer signed the non-disclosure agreement required by the platform holder.',
    `notes` STRING COMMENT 'Free-text notes or comments about the developer account for internal tracking and relationship management.',
    `payment_terms` STRING COMMENT 'Description of the payment terms and revenue share agreement between the developer and platform holder.',
    `portal_url` STRING COMMENT 'The web URL of the platform holders developer portal where this account is managed.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary contact person for account communications and notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary contact person for this developer account.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary contact person for urgent account matters.',
    `reinstatement_date` DATE COMMENT 'The date when a previously suspended account was reinstated to active status.',
    `revenue_threshold_tier` STRING COMMENT 'Revenue-based tier classification that may affect revenue share percentages, support priority, and program eligibility.. Valid values are `tier_1|tier_2|tier_3|tier_4|tier_5|enterprise`',
    `sdk_access_level` STRING COMMENT 'The level of SDK (Software Development Kit) access granted to the account, determining which SDK versions and features are available.. Valid values are `none|basic|standard|advanced|full|early_access`',
    `supported_platforms` STRING COMMENT 'Comma-separated list of platforms this account is authorized to develop for (e.g., PlayStation 5, Xbox Series X, Nintendo Switch, PC, iOS, Android).',
    `suspension_date` DATE COMMENT 'The date when the account was suspended, if applicable.',
    `suspension_reason` STRING COMMENT 'Explanation or reason code if the account has been suspended or placed on probation by the platform holder.',
    `tax_identifier` STRING COMMENT 'The tax identification number (EIN, VAT, or equivalent) registered for this developer account for tax reporting purposes.',
    `termination_date` DATE COMMENT 'The date when the developer account was permanently terminated or closed.',
    `two_factor_auth_enabled` BOOLEAN COMMENT 'Indicates whether two-factor authentication (2FA) is enabled for this developer account to enhance security.',
    CONSTRAINT pk_developer_account PRIMARY KEY(`developer_account_id`)
) COMMENT 'Master record of a registered developer or publisher account on a platform holders developer portal. Covers PlayStation DevNet, Xbox Partner Center, Nintendo Developer Portal, App Store Connect, Google Play Console, and Steamworks partner accounts. Captures portal-specific account ID, account type (developer, publisher, both), enrollment status (active, suspended, pending), enrolled platform programs (dev kit access, early SDK access, beta programs), account tier, revenue threshold tier, account manager contact, and two-factor authentication status. Enables multi-portal developer identity management, access provisioning, and platform relationship tracking.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ADD CONSTRAINT `fk_platform_storefront_developer_account_id` FOREIGN KEY (`developer_account_id`) REFERENCES `gaming_ecm`.`platform`.`developer_account`(`developer_account_id`);
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ADD CONSTRAINT `fk_platform_platform_sku_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ADD CONSTRAINT `fk_platform_cert_submission_developer_account_id` FOREIGN KEY (`developer_account_id`) REFERENCES `gaming_ecm`.`platform`.`developer_account`(`developer_account_id`);
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ADD CONSTRAINT `fk_platform_cert_submission_platform_sku_id` FOREIGN KEY (`platform_sku_id`) REFERENCES `gaming_ecm`.`platform`.`platform_sku`(`platform_sku_id`);
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ADD CONSTRAINT `fk_platform_cert_submission_sdk_integration_id` FOREIGN KEY (`sdk_integration_id`) REFERENCES `gaming_ecm`.`platform`.`sdk_integration`(`sdk_integration_id`);
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ADD CONSTRAINT `fk_platform_cert_submission_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ADD CONSTRAINT `fk_platform_drm_entitlement_platform_sku_id` FOREIGN KEY (`platform_sku_id`) REFERENCES `gaming_ecm`.`platform`.`platform_sku`(`platform_sku_id`);
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ADD CONSTRAINT `fk_platform_drm_entitlement_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ADD CONSTRAINT `fk_platform_entitlement_grant_drm_entitlement_id` FOREIGN KEY (`drm_entitlement_id`) REFERENCES `gaming_ecm`.`platform`.`drm_entitlement`(`drm_entitlement_id`);
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ADD CONSTRAINT `fk_platform_entitlement_grant_parent_entitlement_entitlement_grant_id` FOREIGN KEY (`parent_entitlement_entitlement_grant_id`) REFERENCES `gaming_ecm`.`platform`.`entitlement_grant`(`entitlement_grant_id`);
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ADD CONSTRAINT `fk_platform_entitlement_grant_platform_sku_id` FOREIGN KEY (`platform_sku_id`) REFERENCES `gaming_ecm`.`platform`.`platform_sku`(`platform_sku_id`);
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ADD CONSTRAINT `fk_platform_entitlement_grant_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ADD CONSTRAINT `fk_platform_sdk_integration_developer_account_id` FOREIGN KEY (`developer_account_id`) REFERENCES `gaming_ecm`.`platform`.`developer_account`(`developer_account_id`);
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ADD CONSTRAINT `fk_platform_sdk_integration_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ADD CONSTRAINT `fk_platform_release_schedule_developer_account_id` FOREIGN KEY (`developer_account_id`) REFERENCES `gaming_ecm`.`platform`.`developer_account`(`developer_account_id`);
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ADD CONSTRAINT `fk_platform_release_schedule_platform_sku_id` FOREIGN KEY (`platform_sku_id`) REFERENCES `gaming_ecm`.`platform`.`platform_sku`(`platform_sku_id`);
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ADD CONSTRAINT `fk_platform_release_schedule_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ADD CONSTRAINT `fk_platform_storefront_listing_platform_sku_id` FOREIGN KEY (`platform_sku_id`) REFERENCES `gaming_ecm`.`platform`.`platform_sku`(`platform_sku_id`);
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ADD CONSTRAINT `fk_platform_storefront_listing_pricing_id` FOREIGN KEY (`pricing_id`) REFERENCES `gaming_ecm`.`platform`.`pricing`(`pricing_id`);
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ADD CONSTRAINT `fk_platform_storefront_listing_release_schedule_id` FOREIGN KEY (`release_schedule_id`) REFERENCES `gaming_ecm`.`platform`.`release_schedule`(`release_schedule_id`);
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ADD CONSTRAINT `fk_platform_storefront_listing_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ADD CONSTRAINT `fk_platform_pricing_release_schedule_id` FOREIGN KEY (`release_schedule_id`) REFERENCES `gaming_ecm`.`platform`.`release_schedule`(`release_schedule_id`);
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ADD CONSTRAINT `fk_platform_pricing_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ADD CONSTRAINT `fk_platform_patch_release_cert_submission_id` FOREIGN KEY (`cert_submission_id`) REFERENCES `gaming_ecm`.`platform`.`cert_submission`(`cert_submission_id`);
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ADD CONSTRAINT `fk_platform_patch_release_developer_account_id` FOREIGN KEY (`developer_account_id`) REFERENCES `gaming_ecm`.`platform`.`developer_account`(`developer_account_id`);
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ADD CONSTRAINT `fk_platform_patch_release_platform_sku_id` FOREIGN KEY (`platform_sku_id`) REFERENCES `gaming_ecm`.`platform`.`platform_sku`(`platform_sku_id`);
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ADD CONSTRAINT `fk_platform_patch_release_release_schedule_id` FOREIGN KEY (`release_schedule_id`) REFERENCES `gaming_ecm`.`platform`.`release_schedule`(`release_schedule_id`);
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ADD CONSTRAINT `fk_platform_patch_release_sdk_integration_id` FOREIGN KEY (`sdk_integration_id`) REFERENCES `gaming_ecm`.`platform`.`sdk_integration`(`sdk_integration_id`);
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ADD CONSTRAINT `fk_platform_patch_release_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);

-- ========= TAGS =========
ALTER SCHEMA `gaming_ecm`.`platform` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `gaming_ecm`.`platform` SET TAGS ('dbx_domain' = 'platform');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` SET TAGS ('dbx_subdomain' = 'distribution_channels');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront ID');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `ad_network_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Network Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `cdn_node_id` SET TAGS ('dbx_business_glossary_term' = 'Cdn Node Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `developer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Developer Account Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `network_region_id` SET TAGS ('dbx_business_glossary_term' = 'Network Region Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `age_rating_system` SET TAGS ('dbx_business_glossary_term' = 'Age Rating System');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `age_rating_system` SET TAGS ('dbx_value_regex' = 'ESRB|PEGI|USK|CERO|GRAC|IARC');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `analytics_integration` SET TAGS ('dbx_business_glossary_term' = 'Analytics Integration');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `api_endpoint` SET TAGS ('dbx_business_glossary_term' = 'API (Application Programming Interface) Endpoint');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `cdn_provider` SET TAGS ('dbx_business_glossary_term' = 'CDN (Content Delivery Network) Provider');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `certification_required` SET TAGS ('dbx_business_glossary_term' = 'Certification Required');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Storefront Currency');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `developer_portal_url` SET TAGS ('dbx_business_glossary_term' = 'Developer Portal URL (Uniform Resource Locator)');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `drm_system` SET TAGS ('dbx_business_glossary_term' = 'DRM (Digital Rights Management) System');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Launch Date');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `maximum_build_size_gb` SET TAGS ('dbx_business_glossary_term' = 'Maximum Build Size (GB - Gigabytes)');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `minimum_build_size_mb` SET TAGS ('dbx_business_glossary_term' = 'Minimum Build Size (MB - Megabytes)');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `platform_generation` SET TAGS ('dbx_business_glossary_term' = 'Platform Generation');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `platform_holder_type` SET TAGS ('dbx_business_glossary_term' = 'Platform Holder Type');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `platform_holder_type` SET TAGS ('dbx_value_regex' = 'console_oem|pc_storefront|mobile_app_store|cloud_gaming_platform');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `refund_policy_days` SET TAGS ('dbx_business_glossary_term' = 'Refund Policy Days');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `region_availability` SET TAGS ('dbx_business_glossary_term' = 'Region Availability');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `sdk_version` SET TAGS ('dbx_business_glossary_term' = 'SDK (Software Development Kit) Version');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `storefront_code` SET TAGS ('dbx_business_glossary_term' = 'Storefront Code');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `storefront_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `storefront_name` SET TAGS ('dbx_business_glossary_term' = 'Storefront Name');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `storefront_status` SET TAGS ('dbx_business_glossary_term' = 'Storefront Status');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `storefront_status` SET TAGS ('dbx_value_regex' = 'active|deprecated|sunset|beta|coming_soon');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `sunset_date` SET TAGS ('dbx_business_glossary_term' = 'Sunset Date');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `supported_payment_methods` SET TAGS ('dbx_business_glossary_term' = 'Supported Payment Methods');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `supports_cross_platform` SET TAGS ('dbx_business_glossary_term' = 'Supports Cross-Platform');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `supports_dlc` SET TAGS ('dbx_business_glossary_term' = 'Supports DLC (Downloadable Content)');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `supports_early_access` SET TAGS ('dbx_business_glossary_term' = 'Supports Early Access');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `supports_iap` SET TAGS ('dbx_business_glossary_term' = 'Supports IAP (In-App Purchase)');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `supports_subscriptions` SET TAGS ('dbx_business_glossary_term' = 'Supports Subscriptions');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `supports_ugc` SET TAGS ('dbx_business_glossary_term' = 'Supports UGC (User-Generated Content)');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `tax_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Tax Calculation Method');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `tax_calculation_method` SET TAGS ('dbx_value_regex' = 'inclusive|exclusive|varies_by_region');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `trc_tcr_version` SET TAGS ('dbx_business_glossary_term' = 'TRC (Technical Requirements Checklist) / TCR (Technical Certification Requirements) Version');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` SET TAGS ('dbx_subdomain' = 'distribution_channels');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `platform_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Stock Keeping Unit (SKU) ID');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `age_rating_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Age Rating Cert Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Release Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `game_edition_id` SET TAGS ('dbx_business_glossary_term' = 'Game Edition Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `network_region_id` SET TAGS ('dbx_business_glossary_term' = 'Network Region Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `aso_keywords` SET TAGS ('dbx_business_glossary_term' = 'App Store Optimization (ASO) Keywords');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `base_price_usd` SET TAGS ('dbx_business_glossary_term' = 'Base Price United States Dollar (USD)');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `certification_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Approval Date');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `certification_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Submission Date');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `content_descriptors` SET TAGS ('dbx_business_glossary_term' = 'Content Descriptors');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `drm_entitlement_type` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Entitlement Type');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `esrb_rating` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Software Rating Board (ESRB) Rating');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `feature_bullets` SET TAGS ('dbx_business_glossary_term' = 'Feature Bullets');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `genre_tags` SET TAGS ('dbx_business_glossary_term' = 'Genre Tags');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `hardware_generation` SET TAGS ('dbx_business_glossary_term' = 'Hardware Generation');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `is_early_access` SET TAGS ('dbx_business_glossary_term' = 'Is Early Access');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `is_preorder_available` SET TAGS ('dbx_business_glossary_term' = 'Is Pre-Order Available');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `listing_status` SET TAGS ('dbx_business_glossary_term' = 'Listing Status');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `listing_title` SET TAGS ('dbx_business_glossary_term' = 'Listing Title');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `localization_language` SET TAGS ('dbx_business_glossary_term' = 'Localization Language');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `long_description` SET TAGS ('dbx_business_glossary_term' = 'Long Description');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `pegi_rating` SET TAGS ('dbx_business_glossary_term' = 'Pan European Game Information (PEGI) Rating');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `pegi_rating` SET TAGS ('dbx_value_regex' = '3|7|12|16|18');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `platform_product_identifier` SET TAGS ('dbx_business_glossary_term' = 'Platform Product Identifier');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_business_glossary_term' = 'Pricing Tier');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `regional_availability` SET TAGS ('dbx_business_glossary_term' = 'Regional Availability');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `review_count` SET TAGS ('dbx_business_glossary_term' = 'Review Count');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `screenshot_asset_urls` SET TAGS ('dbx_business_glossary_term' = 'Screenshot Asset Uniform Resource Locators (URLs)');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `short_description` SET TAGS ('dbx_business_glossary_term' = 'Short Description');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `sku_code` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Code');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `storefront_category` SET TAGS ('dbx_business_glossary_term' = 'Storefront Category');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `supported_languages` SET TAGS ('dbx_business_glossary_term' = 'Supported Languages');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `supports_achievements` SET TAGS ('dbx_business_glossary_term' = 'Supports Achievements');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `supports_cloud_saves` SET TAGS ('dbx_business_glossary_term' = 'Supports Cloud Saves');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `supports_crossplay` SET TAGS ('dbx_business_glossary_term' = 'Supports Cross-Platform Play (Crossplay)');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `supports_leaderboards` SET TAGS ('dbx_business_glossary_term' = 'Supports Leaderboards');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `trailer_asset_urls` SET TAGS ('dbx_business_glossary_term' = 'Trailer Asset Uniform Resource Locators (URLs)');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `user_review_score` SET TAGS ('dbx_business_glossary_term' = 'User Review Score');
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` SET TAGS ('dbx_subdomain' = 'certification_compliance');
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ALTER COLUMN `cert_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Submission ID');
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ALTER COLUMN `age_rating_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Age Rating Cert Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ALTER COLUMN `build_artifact_id` SET TAGS ('dbx_business_glossary_term' = 'Build Artifact Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Release Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ALTER COLUMN `developer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Developer Account Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Studio ID');
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ALTER COLUMN `infrastructure_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Infrastructure Deployment Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ALTER COLUMN `loot_box_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Loot Box Disclosure Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ALTER COLUMN `maintenance_window_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ALTER COLUMN `platform_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Sku Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ALTER COLUMN `sdk_integration_id` SET TAGS ('dbx_business_glossary_term' = 'Sdk Integration Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ALTER COLUMN `game_server_id` SET TAGS ('dbx_business_glossary_term' = 'Test Game Server Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ALTER COLUMN `accessibility_features_included` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Features Included Flag');
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Approval Date');
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ALTER COLUMN `certification_outcome` SET TAGS ('dbx_business_glossary_term' = 'Certification Outcome');
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ALTER COLUMN `certification_outcome` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass|pending|not_reviewed');
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ALTER COLUMN `cross_platform_compatible` SET TAGS ('dbx_business_glossary_term' = 'Cross-Platform Compatible Flag');
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ALTER COLUMN `esrb_rating` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Software Rating Board (ESRB) Rating');
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ALTER COLUMN `esrb_rating` SET TAGS ('dbx_value_regex' = 'E|E10|T|M|AO|RP');
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ALTER COLUMN `failure_categories` SET TAGS ('dbx_business_glossary_term' = 'Failure Categories');
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ALTER COLUMN `failure_count` SET TAGS ('dbx_business_glossary_term' = 'Certification Failure Count');
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ALTER COLUMN `in_app_purchases_enabled` SET TAGS ('dbx_business_glossary_term' = 'In-App Purchases (IAP) Enabled Flag');
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ALTER COLUMN `multiplayer_enabled` SET TAGS ('dbx_business_glossary_term' = 'Multiplayer Enabled Flag');
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ALTER COLUMN `pegi_rating` SET TAGS ('dbx_business_glossary_term' = 'Pan European Game Information (PEGI) Rating');
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ALTER COLUMN `pegi_rating` SET TAGS ('dbx_value_regex' = '3|7|12|16|18');
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ALTER COLUMN `platform_reviewer_notes` SET TAGS ('dbx_business_glossary_term' = 'Platform Holder Reviewer Notes');
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ALTER COLUMN `platform_reviewer_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ALTER COLUMN `resubmission_deadline` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Deadline Date');
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ALTER COLUMN `review_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ALTER COLUMN `review_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Start Date');
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ALTER COLUMN `submission_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Submission Notes');
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ALTER COLUMN `submission_number` SET TAGS ('dbx_business_glossary_term' = 'Submission Number');
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Pipeline Status');
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_business_glossary_term' = 'Submission Type');
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_value_regex' = 'initial|resubmission|patch|dlc|update');
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ALTER COLUMN `target_release_date` SET TAGS ('dbx_business_glossary_term' = 'Target Release Date');
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ALTER COLUMN `waiver_details` SET TAGS ('dbx_business_glossary_term' = 'Waiver Details');
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ALTER COLUMN `waiver_granted` SET TAGS ('dbx_business_glossary_term' = 'Waiver Granted Flag');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` SET TAGS ('dbx_subdomain' = 'entitlement_management');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `drm_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Entitlement ID');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Release Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `platform_identity_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Account ID');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `platform_identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `platform_identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `platform_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Sku Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `player_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `player_account_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `storefront_order_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Order Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `allowed_regions` SET TAGS ('dbx_business_glossary_term' = 'Allowed Geographic Regions');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `concurrent_device_limit` SET TAGS ('dbx_business_glossary_term' = 'Concurrent Device Limit');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `device_binding_code` SET TAGS ('dbx_business_glossary_term' = 'Device Binding ID');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `device_binding_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `device_binding_code` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `entitlement_notes` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Notes');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `entitlement_type` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Type');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `entitlement_type` SET TAGS ('dbx_value_regex' = 'purchase|subscription|trial|f2p|rental|promotional');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `expiry_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Expiry Duration in Days');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `expiry_fixed_date` SET TAGS ('dbx_business_glossary_term' = 'Fixed Expiry Date');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `expiry_rule` SET TAGS ('dbx_business_glossary_term' = 'Expiry Rule Type');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `expiry_rule` SET TAGS ('dbx_value_regex' = 'perpetual|fixed_date|duration_days|subscription_cycle');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `family_share_enabled` SET TAGS ('dbx_business_glossary_term' = 'Family Share Enabled Flag');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `grant_channel` SET TAGS ('dbx_business_glossary_term' = 'Grant Channel');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `grant_channel` SET TAGS ('dbx_value_regex' = 'storefront_purchase|key_redemption|promotional_grant|subscription_benefit|bundle_inclusion|platform_plus');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `grant_expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Grant Expiry Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `grant_source_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Grant Source Transaction ID');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `grant_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Grant Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `last_verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Verification Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `license_scope` SET TAGS ('dbx_business_glossary_term' = 'License Scope');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `license_scope` SET TAGS ('dbx_value_regex' = 'single_device|multi_device|family_share|account_bound');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `offline_play_allowed` SET TAGS ('dbx_business_glossary_term' = 'Offline Play Allowed Flag');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `region_lock_enabled` SET TAGS ('dbx_business_glossary_term' = 'Region Lock Enabled Flag');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `revocation_grace_period_hours` SET TAGS ('dbx_business_glossary_term' = 'Revocation Grace Period in Hours');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `revocation_policy` SET TAGS ('dbx_business_glossary_term' = 'Revocation Policy');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `revocation_policy` SET TAGS ('dbx_value_regex' = 'immediate|grace_period|non_revocable');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_value_regex' = 'chargeback|fraud|policy_violation|subscription_cancellation|refund|admin_action');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `revocation_status` SET TAGS ('dbx_business_glossary_term' = 'Revocation Status');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `revocation_status` SET TAGS ('dbx_value_regex' = 'active|revoked|suspended|expired');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `revocation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Revocation Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `transfer_allowed` SET TAGS ('dbx_business_glossary_term' = 'Transfer Allowed Flag');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `verification_required_interval_hours` SET TAGS ('dbx_business_glossary_term' = 'Verification Required Interval in Hours');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` SET TAGS ('dbx_subdomain' = 'entitlement_management');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `entitlement_grant_id` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Grant ID');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Campaign Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Release Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `device_id` SET TAGS ('dbx_business_glossary_term' = 'Device ID');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `device_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `device_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `dlc_bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle ID');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `drm_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Drm Entitlement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `iap_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Iap Transaction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `parent_entitlement_entitlement_grant_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Entitlement ID');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `platform_identity_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Account ID');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `platform_identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `platform_identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `platform_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Sku Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player Account ID');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `seasonal_event_id` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Event Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `spend_limit_control_id` SET TAGS ('dbx_business_glossary_term' = 'Spend Limit Control Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `storefront_order_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Order Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription ID');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `content_version` SET TAGS ('dbx_business_glossary_term' = 'Content Version');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `current_activations` SET TAGS ('dbx_business_glossary_term' = 'Current Activations');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `device_binding_enabled` SET TAGS ('dbx_business_glossary_term' = 'Device Binding Enabled');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `drm_token` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Token');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `drm_token` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `entitlement_description` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Description');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `grant_channel` SET TAGS ('dbx_business_glossary_term' = 'Grant Channel');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `grant_channel` SET TAGS ('dbx_value_regex' = 'storefront_purchase|key_redemption|promotional_grant|subscription_benefit|bundle_unlock|support_compensation');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `grant_notes` SET TAGS ('dbx_business_glossary_term' = 'Grant Notes');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `grant_source_system` SET TAGS ('dbx_business_glossary_term' = 'Grant Source System');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `grant_status` SET TAGS ('dbx_business_glossary_term' = 'Grant Status');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `grant_status` SET TAGS ('dbx_value_regex' = 'active|revoked|expired|pending|suspended');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `grant_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Grant Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `is_transferable` SET TAGS ('dbx_business_glossary_term' = 'Is Transferable');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `max_activations` SET TAGS ('dbx_business_glossary_term' = 'Maximum Activations');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_value_regex' = 'chargeback|fraud|policy_violation|refund|account_closure|license_transfer');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `revocation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Revocation Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` SET TAGS ('dbx_subdomain' = 'certification_compliance');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ALTER COLUMN `sdk_integration_id` SET TAGS ('dbx_business_glossary_term' = 'Software Development Kit (SDK) Integration ID');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ALTER COLUMN `ad_network_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Network Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ALTER COLUMN `developer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Developer Account Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ALTER COLUMN `network_region_id` SET TAGS ('dbx_business_glossary_term' = 'Network Region Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ALTER COLUMN `achievements_enabled` SET TAGS ('dbx_business_glossary_term' = 'Achievements Enabled Flag');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ALTER COLUMN `analytics_enabled` SET TAGS ('dbx_business_glossary_term' = 'Analytics Enabled Flag');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ALTER COLUMN `api_key` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Key');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ALTER COLUMN `api_key` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ALTER COLUMN `certification_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Approval Date');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ALTER COLUMN `certification_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Compliance Status');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ALTER COLUMN `certification_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non-compliant|pending-review|conditionally-approved|not-submitted');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ALTER COLUMN `certification_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Submission Date');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ALTER COLUMN `cloud_saves_enabled` SET TAGS ('dbx_business_glossary_term' = 'Cloud Saves Enabled Flag');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ALTER COLUMN `cross_play_enabled` SET TAGS ('dbx_business_glossary_term' = 'Cross-Play Enabled Flag');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ALTER COLUMN `deprecation_notice_date` SET TAGS ('dbx_business_glossary_term' = 'Deprecation Notice Date');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ALTER COLUMN `drm_enabled` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Enabled Flag');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ALTER COLUMN `iap_enabled` SET TAGS ('dbx_business_glossary_term' = 'In-App Purchase (IAP) Enabled Flag');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ALTER COLUMN `integration_date` SET TAGS ('dbx_business_glossary_term' = 'Integration Date');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ALTER COLUMN `integration_notes` SET TAGS ('dbx_business_glossary_term' = 'Integration Notes');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ALTER COLUMN `integration_status` SET TAGS ('dbx_business_glossary_term' = 'Integration Status');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ALTER COLUMN `integration_status` SET TAGS ('dbx_value_regex' = 'active|deprecated|pending-update|in-development|failed|sunset');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ALTER COLUMN `last_validation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Validation Date');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ALTER COLUMN `leaderboards_enabled` SET TAGS ('dbx_business_glossary_term' = 'Leaderboards Enabled Flag');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ALTER COLUMN `matchmaking_enabled` SET TAGS ('dbx_business_glossary_term' = 'Matchmaking Enabled Flag');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ALTER COLUMN `migration_target_sdk_version` SET TAGS ('dbx_business_glossary_term' = 'Migration Target Software Development Kit (SDK) Version');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ALTER COLUMN `minimum_firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Minimum Firmware Version');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ALTER COLUMN `minimum_os_version` SET TAGS ('dbx_business_glossary_term' = 'Minimum Operating System (OS) Version');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ALTER COLUMN `sdk_name` SET TAGS ('dbx_business_glossary_term' = 'Software Development Kit (SDK) Name');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ALTER COLUMN `sdk_update_deadline` SET TAGS ('dbx_business_glossary_term' = 'Software Development Kit (SDK) Update Deadline');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ALTER COLUMN `sdk_version` SET TAGS ('dbx_business_glossary_term' = 'Software Development Kit (SDK) Version');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ALTER COLUMN `sunset_date` SET TAGS ('dbx_business_glossary_term' = 'Sunset Date');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ALTER COLUMN `voice_chat_enabled` SET TAGS ('dbx_business_glossary_term' = 'Voice Chat Enabled Flag');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` SET TAGS ('dbx_subdomain' = 'distribution_channels');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `release_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Release Schedule ID');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `age_rating_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Age Rating Cert Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `cdn_node_id` SET TAGS ('dbx_business_glossary_term' = 'Cdn Node Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `commercial_term_id` SET TAGS ('dbx_business_glossary_term' = 'Commercial Term Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Release Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `developer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Developer Account Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `dlc_bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Dlc Bundle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `esports_season_id` SET TAGS ('dbx_business_glossary_term' = 'Esports Season Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `launch_event_id` SET TAGS ('dbx_business_glossary_term' = 'Launch Event Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `maintenance_window_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `platform_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Sku Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `server_fleet_id` SET TAGS ('dbx_business_glossary_term' = 'Server Fleet Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `actual_release_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Release Date');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `content_rating` SET TAGS ('dbx_business_glossary_term' = 'Content Rating');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `cross_platform_enabled` SET TAGS ('dbx_business_glossary_term' = 'Cross-Platform Enabled');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `day_one_patch_required` SET TAGS ('dbx_business_glossary_term' = 'Day One Patch Required');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `delay_reason` SET TAGS ('dbx_business_glossary_term' = 'Delay Reason');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `dlc_available` SET TAGS ('dbx_business_glossary_term' = 'Downloadable Content (DLC) Available');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `drm_system` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) System');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `embargo_lift_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Embargo Lift Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `excluded_regions` SET TAGS ('dbx_business_glossary_term' = 'Excluded Regions');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `gold_master_date` SET TAGS ('dbx_business_glossary_term' = 'Gold Master Date');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `launch_edition` SET TAGS ('dbx_business_glossary_term' = 'Launch Edition');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `marketing_golive_date` SET TAGS ('dbx_business_glossary_term' = 'Marketing Go-Live Date');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `mtx_enabled` SET TAGS ('dbx_business_glossary_term' = 'Microtransactions (MTX) Enabled');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `physical_release` SET TAGS ('dbx_business_glossary_term' = 'Physical Release');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `planned_release_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Release Date');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `platform_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Platform Approval Status');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `preorder_discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Pre-Order (Preorder) Discount Percent');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `preorder_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pre-Order (Preorder) Start Date');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `price_currency` SET TAGS ('dbx_business_glossary_term' = 'Price Currency');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `price_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `release_coordinator_name` SET TAGS ('dbx_business_glossary_term' = 'Release Coordinator Name');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `release_identifier` SET TAGS ('dbx_business_glossary_term' = 'Release Identifier');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `release_notes` SET TAGS ('dbx_business_glossary_term' = 'Release Notes');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `release_price` SET TAGS ('dbx_business_glossary_term' = 'Release Price');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `release_region_scope` SET TAGS ('dbx_business_glossary_term' = 'Release Region Scope');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `release_status` SET TAGS ('dbx_business_glossary_term' = 'Release Status');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Release Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `release_type` SET TAGS ('dbx_business_glossary_term' = 'Release Type');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `scheduled_release_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Release Date');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` SET TAGS ('dbx_subdomain' = 'distribution_channels');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `storefront_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Listing ID');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `age_rating_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Age Rating Cert Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `asset_bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Bundle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Release Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `dlc_bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Dlc Bundle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Icon Asset Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `launch_event_id` SET TAGS ('dbx_business_glossary_term' = 'Launch Event Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `league_id` SET TAGS ('dbx_business_glossary_term' = 'League Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `loot_box_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Loot Box Disclosure Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `platform_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Stock Keeping Unit (SKU) ID');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `pricing_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `release_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Release Schedule Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `seasonal_event_id` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Event Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront ID');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `tournament_id` SET TAGS ('dbx_business_glossary_term' = 'Tournament Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `aggregate_review_score` SET TAGS ('dbx_business_glossary_term' = 'Aggregate Review Score');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `aso_keywords` SET TAGS ('dbx_business_glossary_term' = 'App Store Optimization (ASO) Keywords');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `aso_keywords` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `content_descriptors` SET TAGS ('dbx_business_glossary_term' = 'Content Descriptors');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `content_rating` SET TAGS ('dbx_business_glossary_term' = 'Content Rating');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `cross_platform_play` SET TAGS ('dbx_business_glossary_term' = 'Cross-Platform Play');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `developer_name` SET TAGS ('dbx_business_glossary_term' = 'Developer Name');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `drm_type` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Type');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `feature_bullets` SET TAGS ('dbx_business_glossary_term' = 'Feature Bullet Points');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `file_size_mb` SET TAGS ('dbx_business_glossary_term' = 'File Size (MB)');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `genre_tags` SET TAGS ('dbx_business_glossary_term' = 'Genre Tags');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `hero_image_asset_reference` SET TAGS ('dbx_business_glossary_term' = 'Hero Image Asset Reference');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `in_app_purchases` SET TAGS ('dbx_business_glossary_term' = 'In-App Purchases (IAP)');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Date');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `listing_status` SET TAGS ('dbx_business_glossary_term' = 'Listing Status');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `listing_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|live|delisted|rejected|suspended');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `listing_title` SET TAGS ('dbx_business_glossary_term' = 'Listing Title');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `localization_language_code` SET TAGS ('dbx_business_glossary_term' = 'Localization Language Code');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `localization_language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `long_description` SET TAGS ('dbx_business_glossary_term' = 'Long Description');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `multiplayer_support` SET TAGS ('dbx_business_glossary_term' = 'Multiplayer Support');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `primary_category` SET TAGS ('dbx_business_glossary_term' = 'Primary Category');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `published_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Published Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `publisher_name` SET TAGS ('dbx_business_glossary_term' = 'Publisher Name');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `review_count` SET TAGS ('dbx_business_glossary_term' = 'Review Count');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `screenshot_asset_references` SET TAGS ('dbx_business_glossary_term' = 'Screenshot Asset References');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `short_description` SET TAGS ('dbx_business_glossary_term' = 'Short Description');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `support_url` SET TAGS ('dbx_business_glossary_term' = 'Support URL');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `supported_languages` SET TAGS ('dbx_business_glossary_term' = 'Supported Languages');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `supported_platforms` SET TAGS ('dbx_business_glossary_term' = 'Supported Platforms');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `trailer_asset_references` SET TAGS ('dbx_business_glossary_term' = 'Trailer Asset References');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` SET TAGS ('dbx_subdomain' = 'distribution_channels');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `pricing_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing ID');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `commercial_term_id` SET TAGS ('dbx_business_glossary_term' = 'Commercial Term Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Release Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `league_id` SET TAGS ('dbx_business_glossary_term' = 'League Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `loot_box_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Loot Box Disclosure Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `network_region_id` SET TAGS ('dbx_business_glossary_term' = 'Network Region Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `release_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Release Schedule Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `seasonal_event_id` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Event Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `spend_limit_control_id` SET TAGS ('dbx_business_glossary_term' = 'Spend Limit Control Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront ID');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `title_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_submitted|pending|approved|rejected');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `base_price` SET TAGS ('dbx_business_glossary_term' = 'Base Price');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `bundle_eligible` SET TAGS ('dbx_business_glossary_term' = 'Bundle Eligible');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `content_type` SET TAGS ('dbx_business_glossary_term' = 'Content Type');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `cross_platform_pricing_group` SET TAGS ('dbx_business_glossary_term' = 'Cross-Platform Pricing Group');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `cross_platform_pricing_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{1,30}$');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `minimum_advertised_price` SET TAGS ('dbx_business_glossary_term' = 'Minimum Advertised Price (MAP)');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `minimum_advertised_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Pricing Notes');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `platform_revenue_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Platform Revenue Share Percentage');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `platform_revenue_share_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `previous_base_price` SET TAGS ('dbx_business_glossary_term' = 'Previous Base Price');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `price_change_date` SET TAGS ('dbx_business_glossary_term' = 'Price Change Date');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `price_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Price Change Reason');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `price_lock_enabled` SET TAGS ('dbx_business_glossary_term' = 'Price Lock Enabled');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `price_lock_reason` SET TAGS ('dbx_business_glossary_term' = 'Price Lock Reason');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `price_tier` SET TAGS ('dbx_business_glossary_term' = 'Price Tier');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `price_tier` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{1,20}$');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `pricing_status` SET TAGS ('dbx_business_glossary_term' = 'Pricing Status');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `pricing_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|active|suspended|archived');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `promotional_discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Promotional Discount Percentage');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `promotional_end_date` SET TAGS ('dbx_business_glossary_term' = 'Promotional End Date');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `promotional_price` SET TAGS ('dbx_business_glossary_term' = 'Promotional Price');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `promotional_start_date` SET TAGS ('dbx_business_glossary_term' = 'Promotional Start Date');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `recommended_retail_price` SET TAGS ('dbx_business_glossary_term' = 'Recommended Retail Price (RRP)');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `regional_pricing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Regional Pricing Strategy');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `regional_pricing_strategy` SET TAGS ('dbx_value_regex' = 'standard|purchasing_power_parity|competitive|premium|budget');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `sku` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,50}$');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `tax_handling_method` SET TAGS ('dbx_business_glossary_term' = 'Tax Handling Method');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `tax_handling_method` SET TAGS ('dbx_value_regex' = 'inclusive|exclusive|exempt');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `tax_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Percentage');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` SET TAGS ('dbx_subdomain' = 'certification_compliance');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `patch_release_id` SET TAGS ('dbx_business_glossary_term' = 'Patch Release ID');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `age_rating_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Age Rating Cert Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `build_artifact_id` SET TAGS ('dbx_business_glossary_term' = 'Build Artifact Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `cdn_node_id` SET TAGS ('dbx_business_glossary_term' = 'Cdn Node Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `cert_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Cert Submission Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Release Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `developer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Developer Account Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `infrastructure_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Infrastructure Deployment Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `loot_box_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Loot Box Disclosure Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `maintenance_window_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `asset_bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Patch Asset Bundle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `platform_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Sku Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `release_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Release Schedule Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `sdk_integration_id` SET TAGS ('dbx_business_glossary_term' = 'Sdk Integration Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `server_fleet_id` SET TAGS ('dbx_business_glossary_term' = 'Server Fleet Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `title_season_id` SET TAGS ('dbx_business_glossary_term' = 'Title Season Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `age_rating_impact` SET TAGS ('dbx_business_glossary_term' = 'Age Rating Impact');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `age_rating_impact` SET TAGS ('dbx_value_regex' = 'none|content_descriptor_added|rating_change_required');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `anti_cheat_version` SET TAGS ('dbx_business_glossary_term' = 'Anti-Cheat System Version');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `build_number` SET TAGS ('dbx_business_glossary_term' = 'Build Number');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_business_glossary_term' = 'MD5 Checksum');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_value_regex' = '^[a-f0-9]{32}$');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `checksum_sha256` SET TAGS ('dbx_business_glossary_term' = 'SHA-256 Checksum');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `checksum_sha256` SET TAGS ('dbx_value_regex' = '^[a-f0-9]{64}$');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `contains_monetization_changes` SET TAGS ('dbx_business_glossary_term' = 'Contains Monetization Changes Flag');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `download_priority` SET TAGS ('dbx_business_glossary_term' = 'Download Priority Level');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `download_priority` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `drm_version` SET TAGS ('dbx_business_glossary_term' = 'DRM (Digital Rights Management) Version');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `estimated_install_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Installation Time in Minutes');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `is_cross_platform_compatible` SET TAGS ('dbx_business_glossary_term' = 'Cross-Platform Compatibility Flag');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `known_issues_url` SET TAGS ('dbx_business_glossary_term' = 'Known Issues URL');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `localization_languages_added` SET TAGS ('dbx_business_glossary_term' = 'Localization Languages Added');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `patch_notes_summary` SET TAGS ('dbx_business_glossary_term' = 'Patch Notes Summary');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `patch_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Patch Size in Bytes');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `patch_status` SET TAGS ('dbx_business_glossary_term' = 'Patch Release Status');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `patch_status` SET TAGS ('dbx_value_regex' = 'development|submitted|certified|released|rolled_back|deprecated');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `patch_type` SET TAGS ('dbx_business_glossary_term' = 'Patch Type');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `patch_type` SET TAGS ('dbx_value_regex' = 'mandatory|optional|hotfix|content_update|dlc_unlock|balance_patch');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `patch_version` SET TAGS ('dbx_business_glossary_term' = 'Patch Version Number');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `patch_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `privacy_policy_updated` SET TAGS ('dbx_business_glossary_term' = 'Privacy Policy Updated Flag');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Patch Release Date');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `release_notes_url` SET TAGS ('dbx_business_glossary_term' = 'Release Notes URL');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `requires_player_consent` SET TAGS ('dbx_business_glossary_term' = 'Player Consent Required Flag');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `rollback_available` SET TAGS ('dbx_business_glossary_term' = 'Rollback Available Flag');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `rollout_percentage` SET TAGS ('dbx_business_glossary_term' = 'Rollout Percentage');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `rollout_strategy` SET TAGS ('dbx_business_glossary_term' = 'Patch Rollout Strategy');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `rollout_strategy` SET TAGS ('dbx_value_regex' = 'full|staged|regional|beta');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Platform Submission Date');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `trc_checklist_version` SET TAGS ('dbx_business_glossary_term' = 'TRC (Technical Requirements Checklist) Version');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` SET TAGS ('dbx_subdomain' = 'certification_compliance');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `developer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Developer Account ID');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `licensee_id` SET TAGS ('dbx_business_glossary_term' = 'Licensee Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `account_identifier` SET TAGS ('dbx_business_glossary_term' = 'Developer Account Identifier');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `account_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `account_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `account_manager_email` SET TAGS ('dbx_business_glossary_term' = 'Account Manager Email');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `account_manager_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `account_manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `account_manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `account_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Account Manager Name');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'Developer Account Name');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `account_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `account_tier` SET TAGS ('dbx_business_glossary_term' = 'Account Tier');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `account_tier` SET TAGS ('dbx_value_regex' = 'indie|standard|professional|enterprise|partner|preferred');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Developer Account Type');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'developer|publisher|developer_publisher|contractor|service_provider|middleware_provider');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `api_key` SET TAGS ('dbx_business_glossary_term' = 'API (Application Programming Interface) Key');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `api_key` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `business_address` SET TAGS ('dbx_business_glossary_term' = 'Business Address');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `business_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `business_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `certification_access_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Access Flag');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'active|expired|pending_renewal|terminated|under_negotiation');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `contract_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `cross_platform_enabled` SET TAGS ('dbx_business_glossary_term' = 'Cross-Platform Enabled');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `dev_kit_access_flag` SET TAGS ('dbx_business_glossary_term' = 'Dev Kit Access Flag');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `drm_entitlement_access` SET TAGS ('dbx_business_glossary_term' = 'DRM (Digital Rights Management) Entitlement Access');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `enrolled_programs` SET TAGS ('dbx_business_glossary_term' = 'Enrolled Programs');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'active|suspended|pending|terminated|under_review|probation');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `last_login_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Login Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `nda_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'NDA (Non-Disclosure Agreement) Expiry Date');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `nda_expiry_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `nda_signed_date` SET TAGS ('dbx_business_glossary_term' = 'NDA (Non-Disclosure Agreement) Signed Date');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `nda_signed_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Account Notes');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `payment_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `portal_url` SET TAGS ('dbx_business_glossary_term' = 'Developer Portal URL (Uniform Resource Locator)');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `reinstatement_date` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Date');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `reinstatement_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `revenue_threshold_tier` SET TAGS ('dbx_business_glossary_term' = 'Revenue Threshold Tier');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `revenue_threshold_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4|tier_5|enterprise');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `revenue_threshold_tier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `sdk_access_level` SET TAGS ('dbx_business_glossary_term' = 'SDK (Software Development Kit) Access Level');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `sdk_access_level` SET TAGS ('dbx_value_regex' = 'none|basic|standard|advanced|full|early_access');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `supported_platforms` SET TAGS ('dbx_business_glossary_term' = 'Supported Platforms');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `suspension_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Date');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `suspension_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax ID');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `termination_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `two_factor_auth_enabled` SET TAGS ('dbx_business_glossary_term' = 'Two-Factor Authentication Enabled');
