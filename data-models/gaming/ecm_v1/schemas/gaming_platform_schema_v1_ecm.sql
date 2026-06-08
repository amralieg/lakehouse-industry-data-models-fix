-- Schema for Domain: platform | Business: Gaming | Version: v1_ecm
-- Generated on: 2026-05-08 06:58:04

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `gaming_ecm`.`platform` COMMENT 'Manages gaming platforms, distribution channels, console SDK integrations (PlayStation, Xbox, Nintendo), PC storefronts (Steamworks, Epic Games Store), mobile app store pipelines (Apple App Store, Google Play), platform certification submissions, TRC/TCR compliance checklists, DRM entitlement systems, and cross-platform compatibility. Enables multi-platform distribution and deployment.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `gaming_ecm`.`platform`.`storefront` (
    `storefront_id` BIGINT COMMENT 'Unique identifier for the digital distribution storefront. Primary key.',
    `ad_network_id` BIGINT COMMENT 'Foreign key linking to marketing.ad_network. Business justification: Storefronts integrate with ad networks for user acquisition (Apple Search Ads for App Store, Google UAC for Play Store). Attribution flows, cost reporting, and campaign setup require knowing which ad ',
    `developer_account_id` BIGINT COMMENT 'Foreign key linking to platform.developer_account. Business justification: A storefront is managed through a specific developer account on the platform holders developer portal. This is the primary link to connect the siloed developer_account product. N:1 relationship - man',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Storefronts operate under specific jurisdictional regulations (GDPR, COPPA, age verification, content restrictions). Compliance teams must know which regulations apply to each storefront for content p',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Storefronts are operated by legal entities for tax compliance, revenue recognition, and regulatory filings. Essential for financial reporting and intercompany transaction tracking in multi-entity gami',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: Storefronts distribute licensed middleware (Unity, Unreal SDKs) and branded content. Tracks which IP assets are available per storefront for developer onboarding, SDK distribution, and brand partnersh',
    `network_region_id` BIGINT COMMENT 'Foreign key linking to infrastructure.network_region. Business justification: Storefronts are deployed in specific network regions for content delivery and latency optimization. Critical for regional availability planning, CDN topology design, and storefront performance SLAs. G',
    `org_unit_id` BIGINT COMMENT 'Reference to the platform holder entity that owns and operates this storefront (e.g., Sony, Microsoft, Valve, Apple, Google).',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Storefronts must comply with platform-specific regulatory obligations (payment processing, refunds, consumer rights). Real business process: storefront operations compliance and regulatory audit prepa',
    `age_rating_system` STRING COMMENT 'Primary age rating classification system required for games on this storefront: ESRB (North America), PEGI (Europe), USK (Germany), CERO (Japan), GRAC (South Korea), or IARC (International Age Rating Coalition for digital storefronts).. Valid values are `ESRB|PEGI|USK|CERO|GRAC|IARC`',
    `analytics_integration` STRING COMMENT 'Native analytics and reporting platform provided by this storefront for tracking sales, player engagement, and performance metrics (e.g., Steamworks Analytics, App Store Analytics, Google Play Console).',
    `api_endpoint` STRING COMMENT 'Base URL of the storefronts API for programmatic integration, build uploads, metadata management, and analytics retrieval.',
    `cdn_provider` STRING COMMENT 'Content delivery network provider used by this storefront for game distribution and patch delivery (e.g., Akamai, Amazon CloudFront, platform-native CDN).',
    `certification_required` BOOLEAN COMMENT 'Indicates whether game builds must pass formal platform certification (TRC/TCR compliance) before release. True for console storefronts, typically false for open PC storefronts.',
    `contact_email` STRING COMMENT 'Primary business contact email address for developer relations, technical support, or partnership inquiries for this storefront.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `content_policy_url` STRING COMMENT 'Web URL of the storefronts content policy and submission guidelines that define acceptable game content, prohibited material, and editorial standards.',
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
    `game_title_id` BIGINT COMMENT 'Reference to the parent game title that this platform SKU represents. Links to the master game title entity.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to content.asset. Business justification: Storefront SKU listings require hero image assets for merchandising. Marketing teams manage asset references for each platform SKUs store presence. Real-world process: SKU listing creation workflow.',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: SKUs for licensed IP content (Marvels Spider-Man, FIFA) require agreement reference for royalty calculation on unit sales, revenue share enforcement, and territory restriction compliance per commerci',
    `marketing_campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Marketing campaigns drive installs/purchases of specific SKUs. UA teams need to track which product edition (standard/deluxe/ultimate) a campaign targets for creative approval, pricing alignment, and ',
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
    `edition_type` STRING COMMENT 'The edition or tier of the game product (e.g., Standard, Deluxe, Gold, Ultimate, Collectors Edition, Game of the Year Edition, Complete Edition). [ENUM-REF-CANDIDATE: standard|deluxe|gold|ultimate|collectors|goty|complete|starter|premium — 9 candidates stripped; promote to reference product]',
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

CREATE OR REPLACE TABLE `gaming_ecm`.`platform`.`platform_cert_submission` (
    `platform_cert_submission_id` BIGINT COMMENT 'Unique identifier for the platform certification submission record. Primary key for the certification submission lifecycle tracking from build preparation through platform holder review and outcome resolution.',
    `age_rating_cert_id` BIGINT COMMENT 'Foreign key linking to compliance.age_rating_cert. Business justification: Certification submissions often include or reference age rating certificates as part of platform holder approval. Real business process: platform certification requires proof of content rating complia',
    `build_artifact_id` BIGINT COMMENT 'Foreign key linking to title.build_artifact. Business justification: Platform certification submissions validate specific build artifacts for TRC/TCR compliance. Real cert processes (Sony, Microsoft, Nintendo) require exact build version tracking with checksums, engine',
    `build_submission_id` BIGINT COMMENT 'Foreign key linking to platform.build_submission. Business justification: A certification submission is for a specific build submission. These two entities have significant attribute overlap, suggesting cert_submission should reference build_submission rather than duplicate',
    `certification_certificate_id` BIGINT COMMENT 'Unique identifier of the official certification certificate issued by the platform holder upon successful certification approval. This certificate ID is required for commercial distribution and may be referenced in platform storefronts and distribution systems. Null if certification has not been granted.',
    `certification_checklist_id` BIGINT COMMENT 'Foreign key linking to platform.certification_checklist. Business justification: A certification submission is evaluated against a specific TRC/TCR checklist version. The trc_tcr_checklist_version string becomes redundant as the version can be retrieved via JOIN to certification_c',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Certification work hours and external fees are allocated to cost centers for studio P&L, project accounting, and budget variance analysis. Standard practice in game development financial tracking.',
    `drm_entitlement_id` BIGINT COMMENT 'Unique identifier for the DRM entitlement or license configuration associated with this certified build. Links the build to the digital rights management system that controls access, distribution, and anti-piracy measures. Confidential business data.',
    `employee_id` BIGINT COMMENT 'Reference to the user or developer who initiated and submitted the build through the platform holder submission portal. Used for accountability, audit trails, and submission workflow tracking.',
    `game_studio_id` BIGINT COMMENT 'Reference to the game development studio responsible for creating and submitting the build for certification. Links the submission to the development team accountable for build quality and certification compliance.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title being submitted for platform certification. Links this submission to the specific game product undergoing certification review.',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: Certification submissions for licensed content must reference governing IP agreement to verify compliance with brand usage guidelines, rating board requirements, and licensor approval workflows mandat',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_policy. Business justification: Cert submissions must adhere to internal compliance policies that implement regulatory requirements. Real business process: policy enforcement during certification review. Submissions are validated ag',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Cert submissions must comply with specific regulatory obligations (accessibility requirements, data privacy, content standards). Real business process: compliance checklist validation against regulato',
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
    `platform_sdk_version` STRING COMMENT 'Version of the platform SDK used to build and compile the submitted game build. Platform holders require builds to be compiled with approved SDK versions, and this field tracks SDK compliance for certification purposes.',
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
    CONSTRAINT pk_platform_cert_submission PRIMARY KEY(`platform_cert_submission_id`)
) COMMENT 'Transactional record of the complete platform certification lifecycle from build preparation and packaging through formal platform holder submission, review, and outcome resolution. At the build level: captures build version string, build type (debug, release candidate, gold master, patch, hotfix), target platform, build size (bytes), build hash/checksum, submission pipeline status (packaging, uploading, validating, submitted, in-review, approved, rejected), submission channel (PlayStation DevNet, Xbox Partner Center, App Store Connect, Steamworks), and gold master flag. At the submission level: captures TRC/TCR checklist version applied, submission type (initial, resubmission, patch), and platform holder review tracking. At the result level: captures certification outcome per review cycle (pass, fail, conditional pass), failure count and categories, waiver grants, resubmission deadline, certification certificate ID, gold master approval flag, and platform holder reviewer notes. One submission may have multiple result records across resubmission cycles. This is the SSOT for the entire build-to-certification pipeline including build preparation, formal submission, and all platform holder review outcomes.';

CREATE OR REPLACE TABLE `gaming_ecm`.`platform`.`certification_checklist` (
    `certification_checklist_id` BIGINT COMMENT 'Unique identifier for the certification checklist version. Primary key.',
    `org_unit_id` BIGINT COMMENT 'Reference to the platform holder entity (Sony, Microsoft, Nintendo, Apple, Google) that issued this certification checklist.',
    `superseded_by_checklist_certification_checklist_id` BIGINT COMMENT 'Reference to the newer certification checklist version that supersedes this one. Null if this is the current active version.',
    `accessibility_requirements_flag` BOOLEAN COMMENT 'Indicates whether this checklist includes accessibility requirements (e.g., colorblind modes, subtitle support, controller remapping).',
    `advisory_requirement_count` STRING COMMENT 'The number of requirements in this checklist that are classified as advisory or recommended but not mandatory.',
    `age_rating_requirements_flag` BOOLEAN COMMENT 'Indicates whether this checklist includes requirements related to age rating compliance (ESRB, PEGI, CERO, etc.).',
    `average_review_duration_days` STRING COMMENT 'The typical number of business days the platform holder takes to review a certification submission against this checklist.',
    `category_taxonomy` STRING COMMENT 'The hierarchical categorization scheme used to organize requirements in this checklist (e.g., Audio, Video, Network, Save Data, Accessibility, Age Rating, Performance, Security). Stored as a structured taxonomy reference.',
    `certification_checklist_status` STRING COMMENT 'Current lifecycle status of the certification checklist: Draft (under development), Active (in use), Deprecated (phasing out), Superseded (replaced by newer version), Archived (historical record only).. Valid values are `Draft|Active|Deprecated|Superseded|Archived`',
    `certification_fee_amount` DECIMAL(18,2) COMMENT 'The fee charged by the platform holder for certification review against this checklist, if applicable. Null if no fee is charged.',
    `certification_fee_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the certification fee (e.g., USD, EUR, JPY).. Valid values are `^[A-Z]{3}$`',
    `checklist_code` STRING COMMENT 'The official code or identifier assigned by the platform holder to this checklist version (e.g., PS5-TRC-2024-Q1, XBOX-TCR-V3.2).. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `checklist_name` STRING COMMENT 'Human-readable name of the certification checklist (e.g., PlayStation 5 Technical Requirements Checklist Q1 2024).',
    `checklist_type` STRING COMMENT 'The type of certification checklist: TRC (Technical Requirements Checklist), TCR (Technical Certification Requirements), Submission Guidelines, or Compliance Checklist.. Valid values are `TRC|TCR|Submission Guidelines|Compliance Checklist`',
    `conditional_requirement_count` STRING COMMENT 'The number of requirements that are mandatory only under specific conditions (e.g., if game uses online features, if game targets specific age rating).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification checklist record was first created in the system.',
    `cross_platform_compatibility_flag` BOOLEAN COMMENT 'Indicates whether this checklist includes requirements for cross-platform play, cross-save, or cross-progression features.',
    `documentation_url` STRING COMMENT 'URL to the official platform holder documentation or developer portal page for this checklist version.. Valid values are `^https?://.*$`',
    `drm_requirements_flag` BOOLEAN COMMENT 'Indicates whether this checklist includes specific DRM or entitlement system requirements that must be implemented.',
    `effective_date` DATE COMMENT 'The date from which this checklist version becomes active and must be used for new certification submissions.',
    `expiry_date` DATE COMMENT 'The date after which this checklist version is no longer valid for new submissions. Nullable for open-ended checklists.',
    `mandatory_requirement_count` STRING COMMENT 'The number of requirements in this checklist that are classified as mandatory for certification approval.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification checklist record was last modified in the system.',
    `platform_generation` STRING COMMENT 'The platform generation or hardware version this checklist applies to (e.g., PS5, Xbox Series X|S, Nintendo Switch 2, iOS 17, Android 14).',
    `platform_holder_contact` STRING COMMENT 'Primary contact information or support channel for questions about this checklist version (e.g., developer relations email, support portal URL).',
    `privacy_compliance_flag` BOOLEAN COMMENT 'Indicates whether this checklist includes privacy and data protection requirements (GDPR, COPPA, etc.).',
    `published_date` DATE COMMENT 'The date when this checklist version was officially published and made available to developers.',
    `release_notes` STRING COMMENT 'Summary of changes, additions, and removals in this checklist version compared to the previous version. Includes rationale for major changes.',
    `resubmission_policy` STRING COMMENT 'Policy and guidelines for resubmitting a game build after a failed certification attempt, including any limitations or fees.',
    `sdk_version_minimum` STRING COMMENT 'The minimum SDK version required to comply with this checklist (e.g., PS5 SDK 7.0, Xbox GDK June 2024).',
    `sdk_version_recommended` STRING COMMENT 'The recommended SDK version for optimal compliance and feature support with this checklist.',
    `submission_format` STRING COMMENT 'The required format for submitting certification evidence against this checklist (e.g., Excel spreadsheet, online portal form, PDF report).',
    `total_requirement_count` STRING COMMENT 'The total number of individual requirement line items contained in this checklist version.',
    `version_number` STRING COMMENT 'The semantic version number of this checklist (e.g., 3.2.1, 2.0).. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    `waiver_process_description` STRING COMMENT 'Description of the process for requesting waivers or exceptions to specific requirements in this checklist, including eligibility criteria and approval workflow.',
    CONSTRAINT pk_certification_checklist PRIMARY KEY(`certification_checklist_id`)
) COMMENT 'Master record of a TRC (Technical Requirements Checklist) or TCR (Technical Certification Requirements) checklist version issued by a platform holder, including all individual requirement line items at full granularity. Captures checklist version number, platform holder (Sony/Microsoft/Nintendo/Apple/Google), platform generation (PS5, Xbox Series, Switch 2), effective date, expiry date, total requirement count, mandatory vs. advisory breakdown, and category taxonomy. Each requirement line item includes requirement code, title, detailed description, category (audio, video, network, save data, accessibility, age rating), severity (mandatory, advisory, conditional), platform holder guidance notes, waiver eligibility flag, and associated test case reference. This is the SSOT for all platform certification requirements and their hierarchical organization within versioned checklists.';

CREATE OR REPLACE TABLE `gaming_ecm`.`platform`.`checklist_requirement` (
    `checklist_requirement_id` BIGINT COMMENT 'Unique identifier for the certification checklist requirement line item.',
    `certification_checklist_id` BIGINT COMMENT 'Reference to the parent TRC/TCR certification checklist submission that this requirement belongs to.',
    `employee_id` BIGINT COMMENT 'Reference to the QA tester or engineer assigned to verify compliance with this requirement.',
    `actual_effort_hours` DECIMAL(18,2) COMMENT 'Actual number of hours spent on implementing, testing, or remediating this requirement.',
    `applicable_platforms` STRING COMMENT 'Comma-separated list of gaming platforms (PlayStation, Xbox, Nintendo Switch, Steam, Epic Games Store, iOS, Android) to which this requirement applies.',
    `build_version_tested` STRING COMMENT 'Game build version or SDK version number that was tested for compliance with this requirement.',
    `checklist_requirement_category` STRING COMMENT 'Functional category of the certification requirement. [ENUM-REF-CANDIDATE: audio|video|network|save_data|accessibility|age_rating|input|ui_ux|performance|stability|security|privacy|commerce|social|multiplayer|cloud_save|achievements|localization — promote to reference product]. Valid values are `audio|video|network|save_data|accessibility|age_rating`',
    `compliance_status` STRING COMMENT 'Current compliance status of this requirement within the certification submission workflow.. Valid values are `not_started|in_progress|passed|failed|waived|not_applicable`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this checklist requirement record was first created in the system.',
    `deprecated_flag` BOOLEAN COMMENT 'Indicates whether this requirement has been deprecated or superseded by a newer version in updated platform certification guidelines.',
    `effective_date` DATE COMMENT 'Date when this requirement version became effective and enforceable by the platform holder.',
    `estimated_effort_hours` DECIMAL(18,2) COMMENT 'Estimated number of development or testing hours required to implement or verify compliance with this requirement.',
    `failure_reason` STRING COMMENT 'Detailed explanation of why the requirement failed certification testing, including specific non-compliant behaviors or missing functionality.',
    `jira_ticket_key` STRING COMMENT 'Reference to the associated Jira ticket or issue tracking the implementation or remediation work for this requirement.. Valid values are `^[A-Z]{2,10}-[0-9]+$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this checklist requirement record was last modified or updated.',
    `platform_holder_feedback` STRING COMMENT 'Official feedback, comments, or clarifications provided by the platform holder certification team regarding this requirement during the submission review process.',
    `platform_holder_guidance` STRING COMMENT 'Additional implementation guidance, clarifications, or notes provided by the platform holder (Sony, Microsoft, Nintendo, Valve, Epic, Apple, Google) to assist developers in meeting the requirement.',
    `priority_level` STRING COMMENT 'Internal priority level assigned to this requirement based on business impact, risk, and certification timeline constraints.. Valid values are `critical|high|medium|low`',
    `remediation_plan` STRING COMMENT 'Action plan and steps required to address a failed requirement and achieve compliance, including assigned owners and target completion dates.',
    `requirement_code` STRING COMMENT 'The official platform holder requirement code identifier (e.g., XR-045, PS-1023A, NSW-0412). This is the externally-known unique identifier assigned by the platform holder.. Valid values are `^[A-Z]{2,4}-[0-9]{3,4}[A-Z]?$`',
    `requirement_description` STRING COMMENT 'Detailed description of the certification requirement including expected behavior, implementation guidance, and compliance criteria as specified by the platform holder.',
    `requirement_title` STRING COMMENT 'Short descriptive title of the certification requirement as defined by the platform holder.',
    `requirement_version` STRING COMMENT 'Version number of the requirement specification as platform holders periodically update their TRC/TCR guidelines.',
    `retest_required_flag` BOOLEAN COMMENT 'Indicates whether this requirement needs to be retested after remediation or code changes.',
    `severity` STRING COMMENT 'Severity classification indicating whether the requirement is mandatory (must pass for certification), advisory (recommended but not blocking), or conditional (mandatory only under specific circumstances).. Valid values are `mandatory|advisory|conditional`',
    `test_case_reference` STRING COMMENT 'Reference identifier to the associated QA test case or test plan used to verify compliance with this requirement during certification testing.',
    `test_execution_date` DATE COMMENT 'Date when compliance testing for this requirement was executed by the QA team.',
    `test_result_notes` STRING COMMENT 'Detailed notes from QA testing documenting test execution, observed behavior, pass/fail rationale, and any issues encountered during compliance verification.',
    `waiver_approval_status` STRING COMMENT 'Status of the waiver request as determined by the platform holder certification team.. Valid values are `pending|approved|denied|not_requested`',
    `waiver_eligible_flag` BOOLEAN COMMENT 'Indicates whether this requirement is eligible for a waiver or exception request from the platform holder under specific circumstances.',
    `waiver_request_notes` STRING COMMENT 'Business justification and technical rationale submitted to the platform holder when requesting a waiver or exception for this requirement.',
    CONSTRAINT pk_checklist_requirement PRIMARY KEY(`checklist_requirement_id`)
) COMMENT 'Individual requirement line item within a TRC/TCR certification checklist. Captures requirement code, requirement title, detailed description, category (audio, video, network, save data, accessibility, age rating), severity (mandatory, advisory, conditional), platform holder guidance notes, waiver eligibility flag, and associated test case reference. Enables granular compliance tracking at the requirement level across certification submissions.';

CREATE OR REPLACE TABLE `gaming_ecm`.`platform`.`submission_result` (
    `submission_result_id` BIGINT COMMENT 'Unique identifier for the certification submission result record. Primary key.',
    `certification_certificate_id` BIGINT COMMENT 'Unique certificate identifier issued by the platform holder upon successful certification. Null if result was not pass.',
    `platform_cert_submission_id` BIGINT COMMENT 'Reference to the parent certification submission that this result evaluates. Links to the submission that underwent platform holder review.',
    `appeal_deadline_date` DATE COMMENT 'Date by which the studio must submit a formal appeal if they wish to contest the certification result. Null if appeal is not eligible.',
    `appeal_eligible_flag` BOOLEAN COMMENT 'Indicates whether the studio is eligible to appeal the certification result through the platform holders formal appeal process.',
    `content_policy_failure_count` STRING COMMENT 'Number of failures related to content rating compliance, inappropriate content, or platform content policy violations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this submission result record was first created in the system.',
    `critical_failure_count` STRING COMMENT 'Number of critical severity failures that must be resolved before resubmission. Critical failures block certification approval.',
    `detailed_failure_report_url` STRING COMMENT 'URL or file path to the comprehensive failure report document provided by the platform holder, containing screenshots, logs, and reproduction steps.',
    `executive_summary` STRING COMMENT 'High-level summary of the certification result intended for studio leadership and project stakeholders.',
    `fast_track_resubmission_eligible_flag` BOOLEAN COMMENT 'Indicates whether the submission qualifies for expedited fast-track resubmission review, typically for minor fixes only.',
    `functional_failure_count` STRING COMMENT 'Number of failures related to game functionality, gameplay mechanics, or feature implementation.',
    `gold_master_approved_flag` BOOLEAN COMMENT 'Indicates whether this result represents final gold master approval, authorizing the build for commercial distribution.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this submission result record was last updated or modified.',
    `localization_failure_count` STRING COMMENT 'Number of failures related to language translation, regional content adaptation, or cultural compliance.',
    `major_failure_count` STRING COMMENT 'Number of major severity failures identified. Major failures significantly impact user experience or platform compliance.',
    `minor_failure_count` STRING COMMENT 'Number of minor severity failures identified. Minor failures have limited impact and may be eligible for waivers.',
    `network_failure_count` STRING COMMENT 'Number of failures related to online connectivity, multiplayer functionality, or network error handling.',
    `performance_failure_count` STRING COMMENT 'Number of failures related to performance metrics such as frame rate (FPS), load times, or memory usage.',
    `platform_holder_reviewer_email` STRING COMMENT 'Email address of the platform holder reviewer for follow-up communication regarding the certification result.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `platform_holder_reviewer_name` STRING COMMENT 'Name of the platform holder certification reviewer who conducted the evaluation and issued the result.',
    `resubmission_deadline_date` DATE COMMENT 'Date by which the studio must resubmit a corrected build if the result was fail or conditional pass. Null if result was pass.',
    `result_notification_sent_timestamp` TIMESTAMP COMMENT 'Timestamp when the platform holder sent the formal result notification to the studio via email or platform portal.',
    `result_sequence_number` STRING COMMENT 'Sequential ordering of result records for a given submission across resubmission cycles. First submission is 1, first resubmission is 2, etc.',
    `result_status` STRING COMMENT 'Current lifecycle status of the result record. Active indicates the current result, superseded indicates a newer result exists, appealed indicates under appeal review, archived indicates historical record.. Valid values are `active|superseded|appealed|archived`',
    `result_type` STRING COMMENT 'Outcome classification of the certification review. Pass indicates full approval, fail requires resubmission, conditional pass requires minor fixes, waiver granted allows exceptions, withdrawn indicates studio cancellation, cancelled indicates platform holder cancellation.. Valid values are `pass|fail|conditional_pass|waiver_granted|withdrawn|cancelled`',
    `review_completion_date` DATE COMMENT 'Date when the platform holder completed their certification review and issued the formal result.',
    `review_duration_hours` DECIMAL(18,2) COMMENT 'Total number of hours the platform holder spent conducting the certification review for this submission.',
    `reviewer_notes` STRING COMMENT 'Detailed notes and feedback from the platform holder reviewer explaining failures, waivers, and recommendations for resubmission.',
    `studio_acknowledged_timestamp` TIMESTAMP COMMENT 'Timestamp when the studio acknowledged receipt and review of the certification result.',
    `test_environment_configuration` STRING COMMENT 'Description of the hardware, firmware, and software configuration used by the platform holder during certification testing.',
    `total_failure_count` STRING COMMENT 'Total number of Technical Requirements Checklist (TRC) or Technical Certification Requirements (TCR) failures identified in this review cycle.',
    `ui_ux_failure_count` STRING COMMENT 'Number of failures related to user interface design, navigation, accessibility, or user experience standards.',
    `waiver_granted_count` STRING COMMENT 'Number of failures for which the platform holder granted waivers, allowing the submission to proceed despite non-compliance.',
    CONSTRAINT pk_submission_result PRIMARY KEY(`submission_result_id`)
) COMMENT 'Outcome record for a certification submission review cycle, capturing the platform holders formal response. Tracks result type (pass, fail, conditional pass), number of failures, number of waivers granted, failure category breakdown, resubmission deadline, certification certificate ID (if passed), gold master approval flag, and platform holder reviewer notes. One submission may have multiple result records across resubmission cycles.';

CREATE OR REPLACE TABLE `gaming_ecm`.`platform`.`drm_entitlement` (
    `drm_entitlement_id` BIGINT COMMENT 'Unique identifier for the DRM entitlement record. Primary key for both entitlement rules and individual player grants.',
    `age_verification_event_id` BIGINT COMMENT 'Foreign key linking to compliance.age_verification_event. Business justification: DRM entitlements for age-restricted content require age verification. Real business process: age gate enforcement for mature content access. Entitlements cannot be granted without verified age for res',
    `consent_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.consent_policy. Business justification: DRM entitlements involve player data processing and require consent under GDPR/CCPA. Real business process: legal basis validation for entitlement grants and data retention compliance. Entitlements tr',
    `employee_id` BIGINT COMMENT 'Identifier of the admin or system user who initiated the revocation. Null for automated system revocations.',
    `entitlement_rule_id` BIGINT COMMENT 'Reference to the master entitlement rule definition that governs this grant. Links grant-level records to their governing rule-level configuration. Null for rule-level records themselves.',
    `platform_identity_id` BIGINT COMMENT 'The players account identifier on the external platform (Steam ID, PSN ID, Xbox Live Gamertag, Epic Account ID, etc.). Used for platform-level entitlement verification.',
    `player_account_id` BIGINT COMMENT 'Unique identifier of the player who received this entitlement grant. Links to the player master record. Null for rule-level records, populated for grant-level records.',
    `title_sku_id` BIGINT COMMENT 'Foreign key linking to title.sku. Business justification: DRM entitlements protect specific SKUs with region locks, offline play rules, and device binding. Real DRM systems (Denuvo, platform DRM) enforce at SKU level for regional licensing compliance, editio',
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
    `age_verification_event_id` BIGINT COMMENT 'Foreign key linking to compliance.age_verification_event. Business justification: Entitlement grants for age-restricted content must be preceded by age verification. Real business process: compliance with age-appropriate content access rules. Grants track verification events for au',
    `dlc_bundle_id` BIGINT COMMENT 'Reference to the product bundle if this entitlement was granted as part of a bundle purchase. Null for individual item grants.',
    `consent_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.consent_policy. Business justification: Entitlement grants process player data and require documented consent. Real business process: privacy compliance for digital rights management. Grants track player identity, device binding, and usage ',
    `device_id` BIGINT COMMENT 'Unique identifier of the device where the entitlement was first activated (console serial, mobile device IDFA/GAID, PC hardware fingerprint). Used for device binding and DRM enforcement.',
    `drm_entitlement_id` BIGINT COMMENT 'Foreign key linking to platform.drm_entitlement. Business justification: entitlement_grant is a transactional record of a DRM entitlement being granted to a player. drm_entitlement is the master record defining the entitlement rules and policies. The grant should reference',
    `employee_id` BIGINT COMMENT 'Reference to the internal user or system account that initiated the entitlement grant (customer support agent, automated system process). Used for audit trail and accountability.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title or content SKU (Stock Keeping Unit) that this entitlement grants access to.',
    `parent_entitlement_entitlement_grant_id` BIGINT COMMENT 'Reference to a parent entitlement grant if this is a child or dependent entitlement (e.g., DLC requiring base game, season pass content unlock). Null for standalone entitlements.',
    `platform_identity_id` BIGINT COMMENT 'The players unique account identifier on the external platform (PSN ID, Xbox Live Gamertag, Nintendo Account ID, Steam ID, Epic Account ID, Apple ID, Google Play ID). Used for cross-platform entitlement verification.',
    `player_account_id` BIGINT COMMENT 'Reference to the player account receiving the entitlement. Links to the player master record.',
    `promo_code_id` BIGINT COMMENT 'Reference to the promotional code or campaign if this entitlement was granted through a promotional redemption. Null for non-promotional grants.',
    `storefront_id` BIGINT COMMENT 'Reference to the gaming platform where the entitlement is granted (PlayStation, Xbox, Nintendo, Steam, Epic Games Store, Apple App Store, Google Play).',
    `subscription_id` BIGINT COMMENT 'Reference to the active subscription if this entitlement is a subscription benefit (GaaS membership perk). Null for non-subscription grants.',
    `title_sku_id` BIGINT COMMENT 'Foreign key linking to title.sku. Business justification: Entitlement grants authorize access to specific SKUs (title+platform+region+edition combinations). Real entitlement systems (Steam, PSN, Xbox Live) grant at SKU granularity for regional licensing, edi',
    `activation_date` DATE COMMENT 'The date when the entitlement becomes active and usable by the player. May differ from grant_timestamp for pre-orders or scheduled content releases.',
    `content_version` STRING COMMENT 'The version or build number of the content that this entitlement grants access to. Used for patch management and backward compatibility tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this entitlement grant record was first created in the database. Used for audit trail and data lineage tracking.',
    `current_activations` STRING COMMENT 'The current number of active device or account activations for this entitlement. Used to enforce max_activations limits and track concurrent usage.',
    `device_binding_enabled` BOOLEAN COMMENT 'Indicates whether this entitlement is bound to a specific device (true) or can be used across multiple devices (false). Enforces DRM device restrictions per platform TRC/TCR requirements.',
    `drm_token` STRING COMMENT 'The encrypted DRM token or license key used by the platform SDK to validate entitlement at runtime. Confidential credential for content protection.',
    `entitlement_description` STRING COMMENT 'Detailed description of what the entitlement grants access to, including content items, features, or benefits. Used for player communication and support documentation.',
    `entitlement_name` STRING COMMENT 'Human-readable name or title of the entitlement (e.g., Deluxe Edition, Season 1 Pass, Premium Currency Pack). Used for player-facing displays and support interactions.',
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
    `sku` STRING COMMENT 'The platform-specific product SKU or item identifier for the entitlement. Maps to storefront catalog entries and platform certification submissions.',
    `source_transaction_reference` STRING COMMENT 'External reference identifier to the originating transaction (IAP receipt ID, promotional campaign ID, subscription order ID, support ticket ID) that triggered this entitlement grant.',
    CONSTRAINT pk_entitlement_grant PRIMARY KEY(`entitlement_grant_id`)
) COMMENT 'Transactional record of a DRM entitlement being granted to a player account on a specific platform. Captures grant timestamp, entitlement type, source transaction reference (IAP, promotion, subscription), platform account ID, device binding details, grant expiry date, revocation status, and grant channel (storefront purchase, key redemption, promotional grant, subscription benefit). Enables audit of player access rights across all platforms.';

CREATE OR REPLACE TABLE `gaming_ecm`.`platform`.`sdk_integration` (
    `sdk_integration_id` BIGINT COMMENT 'Unique identifier for the SDK integration record. Primary key.',
    `certification_checklist_id` BIGINT COMMENT 'Foreign key linking to platform.certification_checklist. Business justification: SDK integrations must comply with a specific TRC/TCR checklist version for the target platform. The trc_checklist_version string becomes redundant. N:1 relationship.',
    `developer_account_id` BIGINT COMMENT 'Foreign key linking to platform.developer_account. Business justification: SDK integrations are registered and managed through a developer account on the platform holders portal. The integration_owner string field becomes redundant as it can be retrieved via JOIN to develop',
    `game_title_id` BIGINT COMMENT 'Reference to the game title for which this SDK is integrated.',
    `matchmaking_pool_id` BIGINT COMMENT 'Foreign key linking to infrastructure.matchmaking_pool. Business justification: SDK integrations enable matchmaking features tied to specific matchmaking pools. Required for tracking which SDK version supports which matchmaking configuration, validating SDK-pool compatibility, an',
    `middleware_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.middleware_agreement. Business justification: SDK integrations ARE middleware license implementations. Links integration to governing agreement for revenue share calculation, support entitlement verification, update compliance tracking, and audit',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: SDK integrations must comply with platform-specific regulatory requirements (data collection, privacy APIs, age gates). Real business process: SDK compliance validation before certification. SDKs ofte',
    `storefront_id` BIGINT COMMENT 'Reference to the gaming platform (PlayStation, Xbox, Nintendo, PC, Mobile) for this SDK integration.',
    `third_party_processor_id` BIGINT COMMENT 'Foreign key linking to compliance.third_party_processor. Business justification: SDK integrations often involve third-party data processors (analytics, ads, social). Real business process: data processing agreement validation and privacy compliance. SDKs must be vetted for GDPR/CC',
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

CREATE OR REPLACE TABLE `gaming_ecm`.`platform`.`build_submission` (
    `build_submission_id` BIGINT COMMENT 'Unique identifier for the build submission record. Primary key.',
    `age_rating_cert_id` BIGINT COMMENT 'Foreign key linking to compliance.age_rating_cert. Business justification: Build submissions require valid age rating certificates before platform approval. Real business process: release gate enforcement. Builds cannot be certified without proof of content rating compliance',
    `capex_project_id` BIGINT COMMENT 'Foreign key linking to finance.capex_project. Business justification: Build submissions represent capitalized development milestones tracked in capex projects for amortization calculation and asset valuation. Required for GAAP/IFRS compliance on intangible asset account',
    `certification_checklist_id` BIGINT COMMENT 'Foreign key linking to platform.certification_checklist. Business justification: Build submissions are prepared to comply with a specific TRC/TCR checklist version for the target platform. This links the build preparation process to the compliance requirements. N:1 relationship.',
    `employee_id` BIGINT COMMENT 'Reference to the internal user (developer, build engineer, release manager) who initiated the build submission.',
    `game_studio_id` BIGINT COMMENT 'Reference to the game development studio responsible for creating this build.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title for which this build was created.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_policy. Business justification: Build submissions are validated against compliance policies before platform submission. Real business process: pre-submission compliance gate. Builds must pass policy checks before certification submi',
    `sdk_integration_id` BIGINT COMMENT 'Foreign key linking to platform.sdk_integration. Business justification: A build submission uses a specific SDK integration configuration for the target platform. The target_sdk_version string becomes redundant as it can be retrieved via JOIN to sdk_integration. N:1 relati',
    `storefront_id` BIGINT COMMENT 'Reference to the target platform for this build submission (PlayStation, Xbox, Nintendo, Steam, Epic Games Store, Apple App Store, Google Play).',
    `server_fleet_id` BIGINT COMMENT 'Foreign key linking to infrastructure.server_fleet. Business justification: Build submissions target specific server fleets for deployment. Essential for build deployment pipeline, tracking which fleet version a build is deployed to, and coordinating build releases with infra',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the build submission was approved by the platform holder. Null if not yet approved or if rejected.',
    `build_configuration` STRING COMMENT 'The build configuration environment used to compile the build (development, staging, production). Affects feature flags, logging levels, and API endpoints.. Valid values are `development|staging|production`',
    `build_hash` STRING COMMENT 'Cryptographic hash (SHA-256 or MD5) of the build package for integrity verification and tamper detection.',
    `build_pipeline_code` STRING COMMENT 'Identifier of the CI/CD (Continuous Integration/Continuous Deployment) pipeline job or workflow that generated this build. Used for traceability to source control and build automation.',
    `build_size_bytes` BIGINT COMMENT 'Total size of the build package in bytes. Used for storage planning, bandwidth estimation, and platform size limit compliance.',
    `build_type` STRING COMMENT 'Classification of the build based on its stage in the development and release lifecycle. [ENUM-REF-CANDIDATE: debug|alpha|beta|release_candidate|gold_master|patch|hotfix — 7 candidates stripped; promote to reference product]',
    `build_version` STRING COMMENT 'Semantic version string of the build (e.g., 1.2.3, 2.0.1-rc1). Follows semantic versioning conventions.',
    `content_rating` STRING COMMENT 'Age-appropriateness rating assigned by the governing body for the target region (ESRB, PEGI, USK, CERO, GRAC). Required for platform certification.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this build submission record was first created in the system.',
    `drm_type` STRING COMMENT 'Type of Digital Rights Management (DRM) protection applied to the build to prevent piracy and unauthorized distribution.. Valid values are `steamworks|epic_eac|denuvo|platform_native|none`',
    `is_cross_platform` BOOLEAN COMMENT 'Indicates whether this build supports cross-platform play or cross-platform progression. True if cross-platform features are enabled.',
    `is_gold_master` BOOLEAN COMMENT 'Indicates whether this build is the final gold master version approved for commercial release. True if this is the gold master build.',
    `minimum_os_version` STRING COMMENT 'Minimum operating system version required to run this build. Used for platform compatibility checks and player device targeting.',
    `packaging_completed_timestamp` TIMESTAMP COMMENT 'Date and time when the build packaging process completed successfully. Null if packaging failed or is still in progress.',
    `packaging_started_timestamp` TIMESTAMP COMMENT 'Date and time when the build packaging process began. Used for pipeline performance tracking.',
    `rejected_timestamp` TIMESTAMP COMMENT 'Date and time when the build submission was rejected by the platform holder. Null if not rejected.',
    `rejection_reason` STRING COMMENT 'Detailed explanation provided by the platform holder for why the build submission was rejected. Null if not rejected. Used for remediation planning.',
    `release_notes` STRING COMMENT 'Detailed description of changes, new features, bug fixes, and known issues included in this build. Submitted to platform holders and used for player communication.',
    `requires_day_one_patch` BOOLEAN COMMENT 'Indicates whether this gold master build requires a mandatory day-one patch to be playable. True if a day-one patch is planned.',
    `source_commit_hash` STRING COMMENT 'Git or Perforce commit hash/changelist number from which this build was compiled. Enables traceability to exact source code version.',
    `submission_channel` STRING COMMENT 'The platform partner portal or SDK (Software Development Kit) channel through which the build was submitted. [ENUM-REF-CANDIDATE: steamworks|playstation_devnet|xbox_partner_center|nintendo_developer_portal|epic_games_store|app_store_connect|google_play_console — 7 candidates stripped; promote to reference product]',
    `submission_notes` STRING COMMENT 'Internal notes and instructions for the platform certification team. May include testing instructions, known edge cases, or special configuration requirements.',
    `submission_number` STRING COMMENT 'Externally-known unique identifier for this build submission, often used in platform partner portals and certification tracking.',
    `submission_status` STRING COMMENT 'Current status of the build submission in the platform distribution pipeline. Tracks the technical submission workflow, distinct from certification review status.. Valid values are `packaging|uploading|validating|submitted|approved|rejected`',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the build was submitted to the platform distribution channel. Represents the principal business event for this transaction.',
    `supported_languages` STRING COMMENT 'Comma-separated list of ISO 639-1 language codes supported in this build (e.g., en,es,fr,de,ja). Used for localization coverage tracking.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this build submission record was last modified.',
    `upload_completed_timestamp` TIMESTAMP COMMENT 'Date and time when the build upload to the platform partner portal completed successfully. Null if upload failed or is still in progress.',
    `upload_started_timestamp` TIMESTAMP COMMENT 'Date and time when the build upload to the platform partner portal began.',
    `validation_completed_timestamp` TIMESTAMP COMMENT 'Date and time when automated platform validation checks completed. Null if validation failed or is still in progress.',
    `validation_started_timestamp` TIMESTAMP COMMENT 'Date and time when automated platform validation checks began (file integrity, metadata compliance, technical requirements).',
    CONSTRAINT pk_build_submission PRIMARY KEY(`build_submission_id`)
) COMMENT 'Master record of a game build package prepared and submitted for platform distribution or certification. Captures build version string, build type (debug, release candidate, gold master, patch, hotfix), target platform, build size (bytes), build hash/checksum, submission pipeline status (packaging, uploading, validating, submitted, approved), submission channel (Steamworks partner portal, PlayStation DevNet, Xbox Partner Center, App Store Connect), and gold master flag. Distinct from certification_submission which tracks the formal platform holder review process.';

CREATE OR REPLACE TABLE `gaming_ecm`.`platform`.`release_schedule` (
    `release_schedule_id` BIGINT COMMENT 'Unique identifier for the release schedule record. Primary key for this entity.',
    `age_rating_cert_id` BIGINT COMMENT 'Foreign key linking to compliance.age_rating_cert. Business justification: Release schedules depend on age rating certification completion. Real business process: launch planning and regional availability determination. Releases cannot proceed without valid age ratings for t',
    `build_submission_id` BIGINT COMMENT 'Foreign key linking to platform.build_submission. Business justification: A release schedule specifies which build submission will be released on the target date. The build_version string becomes redundant as it can be retrieved via JOIN to build_submission. N:1 relationshi',
    `capacity_plan_id` BIGINT COMMENT 'Foreign key linking to infrastructure.capacity_plan. Business justification: Releases require capacity plans for expected player load at launch. Essential for launch day planning, ensuring adequate server capacity, and coordinating release timing with infrastructure scaling. E',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Release dates drive marketing spend timing, revenue forecasts, and budget phasing. Critical for quarterly earnings guidance and budget-to-actual variance reporting in title P&L management.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title being released. Links to the game title master record.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Releases are planned per jurisdiction based on regulatory approval status and regional restrictions. Real business process: regional launch coordination and compliance verification. Jurisdictions dete',
    `launch_event_id` BIGINT COMMENT 'Foreign key linking to marketing.launch_event. Business justification: Release schedules (platform ops) and launch events (marketing) track the same launch from different perspectives. Marketing needs release_schedule dates for embargo planning; platform ops needs launch',
    `platform_cert_submission_id` BIGINT COMMENT 'Foreign key linking to platform.cert_submission. Business justification: A release schedule is contingent on certification approval. Linking to cert_submission provides the authoritative certification status and dates. The date columns become redundant. N:1 relationship.',
    `platform_storefront_id` BIGINT COMMENT 'Reference to the gaming platform for this release (PlayStation, Xbox, Nintendo, PC, Mobile). Links to platform master record.',
    `server_fleet_id` BIGINT COMMENT 'Foreign key linking to infrastructure.server_fleet. Business justification: Release schedules coordinate with specific server fleet deployments for launch day. Critical for capacity planning, ensuring fleet readiness at release time, and coordinating marketing/platform releas',
    `storefront_id` BIGINT COMMENT 'Reference to the digital storefront or distribution channel (Steam, Epic Games Store, PlayStation Store, Xbox Store, Nintendo eShop, App Store, Google Play). Links to storefront master record.',
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

CREATE OR REPLACE TABLE `gaming_ecm`.`platform`.`compliance_event` (
    `compliance_event_id` BIGINT COMMENT 'Unique identifier for the compliance event record. Primary key.',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: Compliance incidents often result from or trigger audit findings. Real business process: incident investigation and audit remediation linkage. Events are documented as findings for remediation trackin',
    `certification_checklist_id` BIGINT COMMENT 'Foreign key linking to platform.certification_checklist. Business justification: Compliance events represent violations or issues related to specific TRC/TCR checklist requirements. The trc_tcr_reference field contains the requirement code, but the checklist itself should be linke',
    `finance_tax_record_id` BIGINT COMMENT 'Foreign key linking to finance.finance_tax_record. Business justification: Platform compliance violations trigger tax penalties, regulatory filings, and accruals. Links compliance events to tax records for penalty tracking, audit trails, and regulatory disclosure requirement',
    `game_title_id` BIGINT COMMENT 'Reference to the game title affected by this compliance event.',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: Platform compliance violations on licensed content (TRC failures, content policy breaches) trigger IP agreement review for breach notification, penalty assessment, and potential royalty withholding pe',
    `platform_cert_submission_id` BIGINT COMMENT 'Foreign key linking to platform.cert_submission. Business justification: Compliance violations often originate from certification failures or post-release issues discovered during cert review. Real business process: incident tracking and remediation tied to specific submis',
    `sdk_integration_id` BIGINT COMMENT 'Reference to the platform integration (console SDK, storefront, or mobile app store pipeline) where this compliance event originated.',
    `platform_sku_id` BIGINT COMMENT 'Reference to the platform-specific SKU affected by this compliance event.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_policy. Business justification: Compliance incidents trigger policy review and enforcement actions. Real business process: incident response and policy adherence tracking. Events are classified and remediated according to policy vio',
    `previous_event_compliance_event_id` BIGINT COMMENT 'Reference to the previous compliance event ID if this is a recurrence. Null if this is the first occurrence.',
    `release_schedule_id` BIGINT COMMENT 'Foreign key linking to platform.release_schedule. Business justification: Compliance incidents can delay or block scheduled releases. Real business process: release risk management and regulatory hold tracking. Incidents trigger release postponement or regional exclusions.',
    `affected_platform_code` STRING COMMENT 'Code representing the gaming platform affected by this compliance event: PS5 (PlayStation 5), PS4 (PlayStation 4), XBSX (Xbox Series X/S), XBONE (Xbox One), NSW (Nintendo Switch), PC_STEAM (Steam), PC_EPIC (Epic Games Store), IOS (Apple App Store), ANDROID (Google Play). [ENUM-REF-CANDIDATE: PS5|PS4|XBSX|XBONE|NSW|PC_STEAM|PC_EPIC|IOS|ANDROID — 9 candidates stripped; promote to reference product]',
    `assigned_department` STRING COMMENT 'Department responsible for handling this compliance event: platform_engineering (SDK and integration team), legal (legal counsel), compliance (compliance and regulatory affairs), qa (quality assurance), publishing (publishing operations), studio (game development studio).. Valid values are `platform_engineering|legal|compliance|qa|publishing|studio`',
    `assigned_owner_email` STRING COMMENT 'Email address of the individual or team responsible for managing and resolving this compliance event.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `assigned_owner_name` STRING COMMENT 'Full name of the individual or team lead assigned to manage this compliance event.',
    `communication_thread_url` STRING COMMENT 'URL link to the email thread, ticketing system, or collaboration platform where communication regarding this compliance event is tracked (e.g., Jira ticket, Zendesk case, email thread).',
    `compliance_deadline` DATE COMMENT 'Date by which remediation action must be completed to maintain platform compliance. Format: yyyy-MM-dd. Null if no specific deadline is imposed.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this compliance event record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `documentation_url` STRING COMMENT 'URL link to supporting documentation, evidence, or remediation artifacts related to this compliance event (e.g., updated build, policy acknowledgment, certification submission).',
    `escalation_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this compliance event has been escalated to senior management or legal counsel. True if escalated, False otherwise.',
    `escalation_reason` STRING COMMENT 'Explanation of why the compliance event was escalated, including business impact, legal risk, or deadline urgency.',
    `escalation_timestamp` TIMESTAMP COMMENT 'Date and time when the compliance event was escalated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Null if not escalated.',
    `event_reference_number` STRING COMMENT 'Externally-known unique reference number for this compliance event, typically assigned by the platform holder or regulatory body. Format: platform code (3 letters), date (8 digits YYYYMMDD), sequence (6 alphanumeric).. Valid values are `^[A-Z]{3}-[0-9]{8}-[A-Z0-9]{6}$`',
    `event_status` STRING COMMENT 'Current lifecycle status of the compliance event: open (newly reported), in_progress (remediation underway), pending_review (awaiting platform holder or regulatory review), resolved (remediation completed), closed (event finalized), escalated (elevated to senior management or legal).. Valid values are `open|in_progress|pending_review|resolved|closed|escalated`',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the compliance event was reported or detected. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `event_type` STRING COMMENT 'Type of compliance event: policy_violation (platform policy breach), sdk_update_required (mandatory SDK version update), age_rating_review (content rating re-evaluation trigger), gdpr_flag (General Data Protection Regulation compliance issue), coppa_flag (Childrens Online Privacy Protection Act compliance issue), age_gate_enforcement (age verification enforcement action).. Valid values are `policy_violation|sdk_update_required|age_rating_review|gdpr_flag|coppa_flag|age_gate_enforcement`',
    `financial_penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty or fine imposed by the platform holder or regulatory body for this compliance violation. Null if no penalty was assessed.',
    `financial_penalty_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the financial penalty amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `notification_received_timestamp` TIMESTAMP COMMENT 'Date and time when the compliance event notification was received by the organization. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `originating_entity` STRING COMMENT 'Name of the platform holder, regulatory body, or certification authority that issued this compliance event (e.g., Sony Interactive Entertainment, Apple App Store Review, ESRB, FTC, European Commission).',
    `originating_entity_type` STRING COMMENT 'Type of entity that originated the compliance event: platform_holder (console manufacturer or storefront operator), regulatory_body (government agency), certification_authority (rating board or standards organization), internal_audit (self-identified compliance issue).. Valid values are `platform_holder|regulatory_body|certification_authority|internal_audit`',
    `platform_suspension_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the platform SKU or game title was suspended or removed from the platform as a result of this compliance event. True if suspended, False otherwise.',
    `policy_section_reference` STRING COMMENT 'Reference to the specific section or clause of the platform policy, regulatory statute, or certification guideline that was violated or triggered this event.',
    `recurrence_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this compliance event is a recurrence of a previously reported issue for the same platform SKU or game title. True if recurrence, False otherwise.',
    `remediation_action_required` STRING COMMENT 'Description of the corrective action required to resolve the compliance event, as specified by the originating entity or determined by internal compliance team.',
    `remediation_status` STRING COMMENT 'Status of the remediation action: not_started (no action taken yet), in_progress (remediation underway), completed (action finished, awaiting verification), verified (remediation accepted by originating entity), rejected (remediation deemed insufficient).. Valid values are `not_started|in_progress|completed|verified|rejected`',
    `resolution_notes` STRING COMMENT 'Detailed notes documenting the resolution process, actions taken, and verification outcome for this compliance event.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the compliance event was resolved and remediation was verified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Null if not yet resolved.',
    `severity_level` STRING COMMENT 'Severity classification of the compliance event: critical (immediate action required, potential platform removal), high (urgent remediation needed), medium (standard priority), low (minor issue), informational (notification only, no action required).. Valid values are `critical|high|medium|low|informational`',
    `suspension_end_date` DATE COMMENT 'Date when the platform suspension was lifted and the SKU or title was reinstated. Format: yyyy-MM-dd. Null if suspension is ongoing or no suspension occurred.',
    `suspension_start_date` DATE COMMENT 'Date when the platform suspension began. Format: yyyy-MM-dd. Null if no suspension occurred.',
    `trc_tcr_reference` STRING COMMENT 'Reference to the specific TRC or TCR requirement violated or flagged in this compliance event. TRC applies to PlayStation, TCR applies to Xbox.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this compliance event record was last modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `violation_description` STRING COMMENT 'Detailed description of the compliance violation, policy breach, or regulatory issue identified by the originating entity.',
    CONSTRAINT pk_compliance_event PRIMARY KEY(`compliance_event_id`)
) COMMENT 'Transactional record of a compliance-related event occurring on a platform integration, such as a policy violation notice, mandatory SDK update requirement, age rating re-review trigger, GDPR/COPPA compliance flag, COPPA age-gate enforcement action, or platform policy change notification. Captures event type, originating platform holder or regulatory body, affected platform SKU, compliance deadline, remediation action required, assigned owner, and resolution status. Enables proactive platform compliance management.';

CREATE OR REPLACE TABLE `gaming_ecm`.`platform`.`crossplay_feature` (
    `crossplay_feature_id` BIGINT COMMENT 'Unique identifier for the cross-platform feature capability record.',
    `certification_checklist_id` BIGINT COMMENT 'Reference identifier to the platform-specific TRC/TCR compliance checklist document for this cross-platform feature.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title that supports this cross-platform feature.',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: Crossplay features using licensed middleware (Epic Online Services, Photon) require agreement reference for revenue share calculation on cross-platform CCU, platform holder approval coordination, and ',
    `matchmaking_pool_id` BIGINT COMMENT 'Foreign key linking to infrastructure.matchmaking_pool. Business justification: Crossplay features require unified matchmaking pools that span multiple platforms. Essential for configuring cross-platform matchmaking, tracking which pool supports crossplay, and managing platform-s',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Crossplay features involve cross-border data transfer and must comply with data localization and privacy regulations. Real business process: feature approval and regulatory impact assessment. Crosspla',
    `storefront_id` BIGINT COMMENT 'Reference to the primary or host platform for this cross-platform feature.',
    `approval_date` DATE COMMENT 'Date when the platform holder approved this cross-platform feature for deployment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this cross-platform feature record was first created in the system.',
    `data_sharing_scope` STRING COMMENT 'Description of what player data is shared across platforms for this feature (e.g., player ID, progression data, inventory, friends list).',
    `deprecation_date` DATE COMMENT 'Date when this cross-platform feature was deprecated or discontinued.',
    `deprecation_reason` STRING COMMENT 'Business or technical reason for deprecating this cross-platform feature (e.g., platform holder policy change, low adoption, technical limitations).',
    `entitlement_sync_enabled` BOOLEAN COMMENT 'Indicates whether DRM (Digital Rights Management) entitlements and IAP (In-App Purchase) are synchronized across platforms for this feature (true/false).',
    `estimated_ccu_impact` STRING COMMENT 'Estimated increase in concurrent users resulting from enabling this cross-platform feature.',
    `feature_code` STRING COMMENT 'Business identifier code for the cross-platform feature (e.g., XPLAY_PS5_PC, XSAVE_ALL).. Valid values are `^[A-Z0-9_]{3,20}$`',
    `feature_name` STRING COMMENT 'Human-readable name of the cross-platform feature capability.',
    `feature_status` STRING COMMENT 'Current lifecycle status of the cross-platform feature capability.. Valid values are `planned|in_development|certification_pending|active|deprecated`',
    `feature_type` STRING COMMENT 'Type of cross-platform capability: cross-play (multiplayer across platforms), cross-save (save file portability), cross-progression (shared progression), or cross-purchase (buy once play anywhere).. Valid values are `cross-play|cross-save|cross-progression|cross-purchase`',
    `fps_parity_enforced` BOOLEAN COMMENT 'Indicates whether frame rate parity is enforced across platforms to ensure competitive fairness (true/false).',
    `friend_list_integration` STRING COMMENT 'Type of friend list integration across platforms: none (no cross-platform friends), platform-native (each platforms own list), unified social graph (single cross-platform friends list), or hybrid (both).. Valid values are `none|platform_native|unified_social_graph|hybrid`',
    `input_method_balancing_enabled` BOOLEAN COMMENT 'Indicates whether matchmaking or gameplay balancing accounts for input method differences (controller vs keyboard/mouse) across platforms (true/false).',
    `launch_date` DATE COMMENT 'Date when this cross-platform feature was first made available to players.',
    `matchmaking_pool_unified` BOOLEAN COMMENT 'Indicates whether players from all supported platforms share a unified matchmaking pool for PvP (Player versus Player) or co-op gameplay (true/false).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this cross-platform feature record was last modified.',
    `notes` STRING COMMENT 'Additional notes, comments, or context about this cross-platform feature capability.',
    `party_system_supported` BOOLEAN COMMENT 'Indicates whether players can form cross-platform parties or squads before entering matchmaking (true/false).',
    `platform_holder_approval_status` STRING COMMENT 'Approval status from the platform holder (Sony, Microsoft, Nintendo, Valve, Epic) for this cross-platform feature.. Valid values are `not_submitted|submitted|under_review|approved|rejected|conditional_approval`',
    `platform_icon_display_enabled` BOOLEAN COMMENT 'Indicates whether player platform icons are displayed in-game to identify which platform each player is using (true/false).',
    `platform_revenue_share_agreement` STRING COMMENT 'Description of revenue sharing terms with platform holders for cross-platform transactions (e.g., MTX (Microtransactions), IAP (In-App Purchase)).',
    `player_adoption_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of eligible players who have opted into or are actively using this cross-platform feature.',
    `player_consent_required` BOOLEAN COMMENT 'Indicates whether explicit player consent is required before enabling this cross-platform feature (true/false).',
    `player_opt_in_policy` STRING COMMENT 'Policy governing whether players must opt-in or can opt-out of the cross-platform feature (mandatory, opt-in by default, opt-out by default, or player choice).. Valid values are `mandatory|opt_in_default|opt_out_default|player_choice`',
    `relay_server_region` STRING COMMENT 'Geographic region or CDN (Content Delivery Network) zone hosting the relay server infrastructure for this cross-platform feature.',
    `supported_platform_combination` STRING COMMENT 'Comma-separated list of platform codes that participate in this cross-platform feature (e.g., PS5,XBOX_SERIES_X,PC_STEAM).',
    `technical_implementation_approach` STRING COMMENT 'Technical architecture used to implement the cross-platform feature (relay server for matchmaking, peer-to-peer for direct connection, cloud sync for save data, platform API for entitlements).. Valid values are `relay_server|peer_to_peer|hybrid|cloud_sync|platform_api`',
    `text_chat_supported` BOOLEAN COMMENT 'Indicates whether text chat is supported across platforms for this cross-play feature (true/false).',
    `voice_chat_supported` BOOLEAN COMMENT 'Indicates whether voice chat is supported across platforms for this cross-play feature (true/false).',
    CONSTRAINT pk_crossplay_feature PRIMARY KEY(`crossplay_feature_id`)
) COMMENT 'Master record defining a cross-platform feature capability (cross-play, cross-save, cross-progression, cross-purchase) supported by a game title across a set of platforms. Captures feature type, supported platform combinations, feature enablement status per platform pair, platform holder approval status for cross-play, technical implementation approach (relay server, peer-to-peer), and player opt-in/opt-out policy. Enables management of cross-platform compatibility commitments.';

CREATE OR REPLACE TABLE `gaming_ecm`.`platform`.`storefront_listing` (
    `storefront_listing_id` BIGINT COMMENT 'Unique identifier for the storefront listing record. Primary key.',
    `age_rating_cert_id` BIGINT COMMENT 'Foreign key linking to compliance.age_rating_cert. Business justification: Storefront listings display age ratings and require valid certificates. Real business process: listing approval and content descriptor display. Listings cannot be published without valid age rating ce',
    `aso_listing_id` BIGINT COMMENT 'Foreign key linking to marketing.aso_listing. Business justification: ASO listings represent metadata experiments (title, keywords, screenshots). Storefront_listing must link to the aso_listing variant its currently displaying for A/B test tracking, conversion rate att',
    `compatibility_profile_id` BIGINT COMMENT 'Foreign key linking to platform.compatibility_profile. Business justification: A storefront listing displays compatibility information from a compatibility profile. The string fields for system requirements become redundant as detailed specs can be retrieved via JOIN to compatib',
    `game_title_id` BIGINT COMMENT 'Reference to the game title that this listing represents.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to content.asset. Business justification: Storefront listings require icon assets for display. Marketing teams manage specific asset references for each listing. Replaces denormalized icon_asset_reference with proper FK for asset management w',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: Storefront listings for licensed IP content require IP reference for trademark attribution compliance, brand usage guideline enforcement, and automated royalty reporting on listing views/conversions p',
    `loot_box_disclosure_id` BIGINT COMMENT 'Foreign key linking to compliance.loot_box_disclosure. Business justification: Listings with loot boxes must display probability disclosures per regulatory requirements. Real business process: consumer protection compliance and disclosure enforcement. Listings cannot be publishe',
    `marketing_campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Campaigns drive traffic to specific storefront listing variants. ASO and paid UA teams run A/B tests where different campaigns target different listing variants (screenshots, descriptions) to measure ',
    `platform_sku_id` BIGINT COMMENT 'Reference to the purchasable product definition and pricing tier that this listing represents on the storefront.',
    `storefront_id` BIGINT COMMENT 'Reference to the specific storefront platform where this listing is published (Steam, Epic Games Store, PlayStation Store, Xbox Store, Nintendo eShop, Apple App Store, Google Play).',
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
    `privacy_policy_url` STRING COMMENT 'URL to the games privacy policy, required for compliance with GDPR, COPPA, and platform policies.',
    `published_timestamp` TIMESTAMP COMMENT 'Timestamp when this listing was first published and made live on the storefront platform.',
    `publisher_name` STRING COMMENT 'Name of the game publisher displayed on the storefront listing.',
    `release_date` DATE COMMENT 'The official release date of the game on this storefront platform. May differ from the global launch date for regional releases.',
    `review_count` BIGINT COMMENT 'Total number of user reviews submitted for this listing on the storefront platform.',
    `screenshot_asset_references` STRING COMMENT 'Comma-separated list of asset IDs or URLs referencing the screenshot images displayed on the listing page. Order determines display sequence.',
    `secondary_category` STRING COMMENT 'Optional secondary storefront category for cross-classification (e.g., a game may be both Action and Multiplayer).',
    `short_description` STRING COMMENT 'Brief marketing description of the game, typically displayed in search results and browse views. Character limits vary by storefront (e.g., 80 chars for mobile app stores).',
    `support_url` STRING COMMENT 'URL to the player support or help center for this game.',
    `supported_languages` STRING COMMENT 'Comma-separated list of languages supported by the game for interface, audio, and subtitles (e.g., English, Japanese, Spanish, French, German).',
    `supported_platforms` STRING COMMENT 'Comma-separated list of platform hardware or operating systems this listing supports (e.g., PlayStation 5, Xbox Series X, Windows 10, iOS 15+, Android 11+).',
    `terms_of_service_url` STRING COMMENT 'URL to the games terms of service or end-user license agreement (EULA).',
    `trailer_asset_references` STRING COMMENT 'Comma-separated list of asset IDs or URLs referencing the video trailers displayed on the listing page. Order determines display sequence.',
    `version_number` STRING COMMENT 'The current version number of the game build associated with this listing (e.g., 1.0.0, 2.3.1).',
    CONSTRAINT pk_storefront_listing PRIMARY KEY(`storefront_listing_id`)
) COMMENT 'Master record of a game titles public-facing product listing page on a specific storefront, managing all consumer-visible metadata and ASO (App Store Optimization) content. Captures listing title, short and long descriptions, feature bullet points, screenshot and trailer asset references, localization language, storefront category and genre tags, ASO keywords, user review score aggregate, review count, listing status (draft, pending review, live, delisted), and last updated timestamp. Distinct from platform_sku which owns the purchasable product definition and pricing tier — this product owns the marketing/discovery presentation layer. Enables storefront presence management, A/B testing of listing content, and ASO optimization across all distribution channels.';

CREATE OR REPLACE TABLE `gaming_ecm`.`platform`.`pricing` (
    `pricing_id` BIGINT COMMENT 'Unique identifier for the pricing record. Primary key for the pricing configuration entity.',
    `deferred_revenue_id` BIGINT COMMENT 'Foreign key linking to finance.deferred_revenue. Business justification: Pricing changes affect deferred revenue recognition patterns for existing liabilities. Required for revenue waterfall analysis and contract modification accounting under ASC 606.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title for which this pricing configuration applies.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Pricing must comply with jurisdiction-specific tax rules, consumer protection laws, and currency regulations. Real business process: regional pricing strategy and tax compliance. Jurisdictions determi',
    `marketing_campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Promotional campaigns are timed with pricing changes (launch discounts, seasonal sales). Campaign creative must reflect current pricing; UA teams need to know which campaign drove purchases at which p',
    `platform_sku_id` BIGINT COMMENT 'Platform-specific product identifier used for entitlement and DRM (Digital Rights Management) systems. Format varies by platform (e.g., Apple App Store product ID, Google Play product ID, Steam App ID).. Valid values are `^[A-Za-z0-9._-]{1,100}$`',
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
    `region_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country or region code where this pricing applies (e.g., USA, GBR, JPN, DEU, AUS).. Valid values are `^[A-Z]{3}$`',
    `regional_pricing_strategy` STRING COMMENT 'Pricing strategy applied for this region. Standard = base conversion, Purchasing Power Parity = adjusted for local economic conditions, Competitive = matched to local market, Premium = higher tier positioning, Budget = value positioning.. Valid values are `standard|purchasing_power_parity|competitive|premium|budget`',
    `sku` STRING COMMENT 'Stock Keeping Unit - unique product identifier used by the storefront for inventory and sales tracking. Platform-specific identifier.. Valid values are `^[A-Z0-9_-]{1,50}$`',
    `tax_handling_method` STRING COMMENT 'Indicates whether the displayed price includes tax (inclusive), excludes tax to be added at checkout (exclusive), or is tax-exempt.. Valid values are `inclusive|exclusive|exempt`',
    `tax_rate_percentage` DECIMAL(18,2) COMMENT 'Applicable sales tax, VAT (Value Added Tax), or GST (Goods and Services Tax) rate percentage for the region (e.g., 20.00 for UK VAT, 10.00 for Japan consumption tax). Null if tax-exempt.',
    CONSTRAINT pk_pricing PRIMARY KEY(`pricing_id`)
) COMMENT 'Master record of a game titles pricing configuration on a specific storefront and region. Captures base price, currency, regional price tier, promotional price, promotional window start/end dates, price history, platform holder revenue share percentage, tax handling method (inclusive/exclusive), and pricing approval status. Enables multi-region, multi-storefront pricing management and revenue share calculation inputs.';

CREATE OR REPLACE TABLE `gaming_ecm`.`platform`.`patch_release` (
    `patch_release_id` BIGINT COMMENT 'Unique identifier for the patch release record. Primary key.',
    `age_rating_cert_id` BIGINT COMMENT 'Foreign key linking to compliance.age_rating_cert. Business justification: Patches with content changes may require age rating re-certification. Real business process: content update compliance and rating maintenance. Material content changes trigger rating review and potent',
    `employee_id` BIGINT COMMENT 'Reference to the user who approved this patch for release. Governance and accountability.',
    `build_submission_id` BIGINT COMMENT 'Foreign key linking to platform.build_submission. Business justification: A patch release is applied on top of a base build submission. Using label prefix base_ to distinguish this from the patchs own build. The minimum_base_version_required string becomes redundant. N:1',
    `build_artifact_id` BIGINT COMMENT 'Foreign key linking to title.build_artifact. Business justification: Patch releases deploy specific build artifacts to platforms. Real patch management tracks exact artifact versions for rollback capability, delta patch calculation, certification compliance, and player',
    `capex_project_id` BIGINT COMMENT 'Foreign key linking to finance.capex_project. Business justification: Post-launch patches may be capitalized as part of ongoing development projects or expensed based on accounting policy. Links patches to capex tracking for amortization and impairment testing.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title this patch applies to.',
    `infrastructure_deployment_id` BIGINT COMMENT 'Foreign key linking to infrastructure.infrastructure_deployment. Business justification: Patch releases trigger infrastructure deployments with specific rollout strategies and deployment windows. Essential for coordinating client and server patch rollouts, tracking deployment status, and ',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: Patches to licensed content require agreement reference for certification compliance verification when middleware versions change, brand asset updates occur, or content modifications trigger licensor ',
    `asset_bundle_id` BIGINT COMMENT 'Foreign key linking to content.asset_bundle. Business justification: Platform patches deploy specific asset bundles containing updated content. Live ops teams track which bundle is included in each platform patch for version control and player support.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Patches that change monetization, data collection, or content must comply with regulatory disclosure requirements. Real business process: patch approval and player notification requirements. Material ',
    `release_schedule_id` BIGINT COMMENT 'Foreign key linking to platform.release_schedule. Business justification: A patch_release represents a game update deployed on a specific platform. The release_schedule governs the planned release window and approval timeline for game releases and updates. Linking patch_rel',
    `server_fleet_id` BIGINT COMMENT 'Foreign key linking to infrastructure.server_fleet. Business justification: Patches are deployed to specific server fleets with coordinated rollout strategies. Required for patch deployment tracking, fleet version management, and coordinating client patch releases with server',
    `storefront_id` BIGINT COMMENT 'Reference to the platform on which this patch is released (PlayStation, Xbox, Nintendo, Steam, Epic Games Store, Apple App Store, Google Play).',
    `age_rating_impact` STRING COMMENT 'Indicates whether this patch affects the games age rating: none (no impact), content_descriptor_added (new content descriptors required), rating_change_required (full re-rating needed). Compliance with ESRB, PEGI, CERO, USK, GRAC.. Valid values are `none|content_descriptor_added|rating_change_required`',
    `anti_cheat_version` STRING COMMENT 'Version of anti-cheat system included in this patch. Critical for competitive and esports titles.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when this patch was approved for release. Governance audit trail.',
    `build_number` STRING COMMENT 'Internal build identifier from the CI/CD (Continuous Integration/Continuous Deployment) pipeline. Links patch to specific code commit and build artifacts.',
    `cdn_distribution_url` STRING COMMENT 'Content Delivery Network URL for patch distribution. Confidential infrastructure endpoint.',
    `certification_date` DATE COMMENT 'Date when the patch passed platform certification (TRC/TCR approval). Nullable if not yet certified.',
    `certification_status` STRING COMMENT 'Current status of platform certification process: not_submitted (not yet sent), pending (awaiting review), in_review (under evaluation), approved (passed TRC/TCR), rejected (failed certification), conditional_approval (approved with minor fixes required).. Valid values are `not_submitted|pending|in_review|approved|rejected|conditional_approval`',
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
    `sdk_version` STRING COMMENT 'Version of the platform SDK (Software Development Kit) used to build this patch. Required for platform certification compliance.',
    `submission_date` DATE COMMENT 'Date when the patch was submitted to the platform holder for certification review (TRC/TCR compliance).',
    `trc_checklist_version` STRING COMMENT 'Version of the Technical Requirements Checklist used for certification. Platform-specific compliance document version.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this patch release record was last modified. Audit trail for lifecycle changes.',
    CONSTRAINT pk_patch_release PRIMARY KEY(`patch_release_id`)
) COMMENT 'Master record of a game title patch or update released on a specific platform. Captures patch version, patch type (mandatory, optional, hotfix, content update, DLC unlock), patch size (bytes), release date per platform, patch notes summary, minimum base game version required, platform certification status for the patch, and rollout strategy (staged rollout percentage, full rollout). Enables patch lifecycle management across all platforms.';

CREATE OR REPLACE TABLE `gaming_ecm`.`platform`.`compatibility_profile` (
    `compatibility_profile_id` BIGINT COMMENT 'Unique identifier for the compatibility profile record. Primary key.',
    `certification_checklist_id` BIGINT COMMENT 'Foreign key linking to platform.certification_checklist. Business justification: Compatibility profiles are certified against a specific TRC/TCR checklist. The certification_status and certification_date track the outcome, but the checklist itself should be linked. N:1 relationshi',
    `game_title_id` BIGINT COMMENT 'Reference to the game title for which this compatibility profile is defined.',
    `middleware_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.middleware_agreement. Business justification: Compatibility profiles for middleware-dependent features (ray tracing via NVIDIA RTX, physics via Havok) require agreement reference for support entitlement verification, SDK version compliance, and p',
    `storefront_id` BIGINT COMMENT 'Reference to the gaming platform (PlayStation, Xbox, Nintendo, PC, Mobile) for which this compatibility profile applies.',
    `api_version` STRING COMMENT 'Version of the graphics or platform API used (e.g., DirectX 12, Vulkan 1.3, Metal 3).',
    `ar_support_flag` BOOLEAN COMMENT 'Indicates whether the game supports AR features on this platform.',
    `certification_date` DATE COMMENT 'Date when the compatibility profile received platform certification approval.',
    `certification_expiry_date` DATE COMMENT 'Date when the platform certification expires and requires renewal or recertification.',
    `certification_status` STRING COMMENT 'Current status of the platform certification process for this compatibility profile.. Valid values are `draft|submitted|in_review|certified|rejected|expired`',
    `colorblind_mode_flag` BOOLEAN COMMENT 'Indicates whether the game provides colorblind accessibility modes on this platform.',
    `controller_support_types` STRING COMMENT 'Comma-separated list of supported controller types (e.g., keyboard_mouse, gamepad, touch, motion_controls, adaptive_controller).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this compatibility profile record was first created in the system.',
    `cross_platform_play_flag` BOOLEAN COMMENT 'Indicates whether the game supports cross-platform multiplayer with other platforms.',
    `cross_save_flag` BOOLEAN COMMENT 'Indicates whether the game supports cross-platform save file synchronization.',
    `drm_system` STRING COMMENT 'Name of the DRM system used for entitlement and copy protection on this platform (e.g., Denuvo, Steam DRM, Epic Online Services).',
    `effective_date` DATE COMMENT 'Date when this compatibility profile becomes active and applicable for game distribution.',
    `end_of_support_date` DATE COMMENT 'Date when this compatibility profile will no longer be supported or maintained.',
    `hdr_support_flag` BOOLEAN COMMENT 'Indicates whether the game supports HDR rendering on this platform.',
    `local_multiplayer_flag` BOOLEAN COMMENT 'Indicates whether the game supports local split-screen or couch co-op multiplayer on this platform.',
    `max_concurrent_players` STRING COMMENT 'Maximum number of concurrent players supported in a single multiplayer session on this platform.',
    `min_cpu_spec` STRING COMMENT 'Minimum CPU requirement for the game on this platform, including processor model and clock speed.',
    `min_gpu_spec` STRING COMMENT 'Minimum GPU requirement for the game on this platform, including graphics card model and VRAM.',
    `min_ram_gb` DECIMAL(18,2) COMMENT 'Minimum system RAM required in gigabytes to run the game on this platform.',
    `min_storage_gb` DECIMAL(18,2) COMMENT 'Minimum disk storage space required in gigabytes to install and run the game.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this compatibility profile record was last modified.',
    `online_multiplayer_flag` BOOLEAN COMMENT 'Indicates whether the game supports online multiplayer gameplay on this platform.',
    `performance_notes` STRING COMMENT 'Additional notes regarding performance characteristics, known issues, or optimization details for this platform.',
    `profile_code` STRING COMMENT 'Business identifier code for the compatibility profile, typically combining game SKU and platform abbreviation.. Valid values are `^[A-Z0-9_-]{4,20}$`',
    `profile_name` STRING COMMENT 'Human-readable name of the compatibility profile, typically including game title and platform.',
    `profile_version` STRING COMMENT 'Semantic version number of the compatibility profile, incremented with each hardware or OS requirement update.. Valid values are `^[0-9]+.[0-9]+.[0-9]+$`',
    `ray_tracing_support_flag` BOOLEAN COMMENT 'Indicates whether the game supports real-time ray tracing on this platform.',
    `recommended_cpu_spec` STRING COMMENT 'Recommended CPU specification for optimal game performance on this platform.',
    `recommended_gpu_spec` STRING COMMENT 'Recommended GPU specification for optimal game performance and visual quality on this platform.',
    `recommended_ram_gb` DECIMAL(18,2) COMMENT 'Recommended system RAM in gigabytes for optimal game performance on this platform.',
    `recommended_storage_gb` DECIMAL(18,2) COMMENT 'Recommended disk storage space in gigabytes for optimal game experience including DLC and updates.',
    `remappable_controls_flag` BOOLEAN COMMENT 'Indicates whether the game allows players to remap control inputs on this platform.',
    `sdk_version` STRING COMMENT 'Version of the platform SDK used to build this compatibility profile.. Valid values are `^[0-9]+.[0-9]+.[0-9]+$`',
    `subtitle_support_flag` BOOLEAN COMMENT 'Indicates whether the game provides subtitle accessibility features on this platform.',
    `supported_os_versions` STRING COMMENT 'Comma-separated list of supported operating system versions for this platform (e.g., Windows 10, Windows 11, macOS 12+, iOS 15+).',
    `supported_resolutions` STRING COMMENT 'Comma-separated list of supported display resolutions (e.g., 1080p, 1440p, 4K, 8K).',
    `target_frame_rates` STRING COMMENT 'Comma-separated list of target frame rates per second supported (e.g., 30fps, 60fps, 120fps, 144fps).',
    `text_to_speech_flag` BOOLEAN COMMENT 'Indicates whether the game provides text-to-speech accessibility features on this platform.',
    `vr_support_flag` BOOLEAN COMMENT 'Indicates whether the game supports VR headsets and gameplay on this platform.',
    CONSTRAINT pk_compatibility_profile PRIMARY KEY(`compatibility_profile_id`)
) COMMENT 'Master record defining the hardware and OS compatibility profile for a game title on a specific platform. Captures minimum hardware spec (CPU, GPU, RAM, storage), recommended hardware spec, supported OS versions, supported display resolutions (1080p, 4K, 8K), HDR support flags, frame rate targets (30fps, 60fps, 120fps), accessibility feature support (subtitles, colorblind modes, remappable controls), and platform-specific performance certification status. Enables cross-platform compatibility management and platform certification readiness.';

CREATE OR REPLACE TABLE `gaming_ecm`.`platform`.`developer_account` (
    `developer_account_id` BIGINT COMMENT 'Unique identifier for the developer account record. Primary key.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Developer accounts are registered under specific jurisdictions with applicable tax and legal requirements. Real business process: account setup and regulatory compliance tracking. Jurisdiction determi',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Developer accounts are registered to legal entities for contract execution, payment processing, and tax withholding. Essential for vendor master data, 1099 reporting, and intercompany royalty tracking',
    `licensee_id` BIGINT COMMENT 'Foreign key linking to licensing.licensee. Business justification: Developer accounts ARE licensees holding platform SDK licenses, middleware agreements, and brand partnership rights. Fundamental business identity link for contract management, royalty reporting, comp',
    `org_unit_id` BIGINT COMMENT 'Reference to the platform holder (console manufacturer or storefront operator) that hosts this developer portal account.',
    `third_party_processor_id` BIGINT COMMENT 'Foreign key linking to compliance.third_party_processor. Business justification: Developer accounts may use third-party processors for payment, analytics, or services. Real business process: vendor management and data processing compliance. Accounts must document third-party data ',
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

CREATE OR REPLACE TABLE `gaming_ecm`.`platform`.`storefront_campaign` (
    `storefront_campaign_id` BIGINT COMMENT 'Unique identifier for this storefront-campaign placement record. Primary key.',
    `marketing_campaign_id` BIGINT COMMENT 'Foreign key linking to the marketing campaign being executed on this storefront',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to the digital distribution storefront where this campaign is executed',
    `attribution_link_override` STRING COMMENT 'Storefront-specific attribution tracking URL or deep link that overrides the campaign-level attribution link to enable storefront-level performance tracking.',
    `budget_allocated` DECIMAL(18,2) COMMENT 'Budget amount allocated specifically for this campaign on this storefront. Part of the overall campaign budget is distributed across storefronts based on targeting strategy.',
    `budget_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the storefront-specific budget allocation (e.g., USD, EUR, GBP).',
    `co_marketing_agreement_flag` BOOLEAN COMMENT 'Indicates whether a co-marketing agreement with the platform holder (Sony, Microsoft, Nintendo, Valve, etc.) is in place for this campaign on this storefront, which may include cost-sharing or featured placement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this storefront-campaign placement record was created in the system.',
    `end_date` DATE COMMENT 'Date when this campaign ends on this specific storefront. May differ from the overall campaign end date due to storefront-specific performance or budget exhaustion.',
    `featured_placement_secured` BOOLEAN COMMENT 'Indicates whether featured or premium placement (homepage banner, featured carousel, etc.) has been secured for this campaign on this storefront.',
    `placement_status` STRING COMMENT 'Current operational status of this campaign placement on this storefront: planned (scheduled but not yet live), active (currently running), paused (temporarily stopped), completed (ended successfully), cancelled (terminated early).',
    `start_date` DATE COMMENT 'Date when this campaign begins running on this specific storefront. May differ from the overall campaign start date due to phased rollouts or storefront-specific launch timing.',
    `storefront_specific_creative_url` STRING COMMENT 'URL or reference to creative assets customized for this storefront, accounting for platform-specific requirements (aspect ratios, file formats, content policies).',
    `targeting_rules` STRING COMMENT 'Platform-specific targeting configuration for this campaign on this storefront, such as device type filters, OS version requirements, or storefront-specific audience segments.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this storefront-campaign placement record was last modified.',
    CONSTRAINT pk_storefront_campaign PRIMARY KEY(`storefront_campaign_id`)
) COMMENT 'This association product represents the placement and execution of a marketing campaign on a specific digital storefront. It captures the business reality that campaigns are executed across multiple storefronts with storefront-specific budgets, targeting rules, co-marketing agreements with platform holders, and featured placement timing. Each record links one storefront to one campaign with attributes that exist only in the context of this specific storefront-campaign execution.. Existence Justification: In gaming marketing operations, campaigns are executed across multiple digital storefronts (Steam, Epic Games Store, PlayStation Store, Xbox Marketplace, etc.), and each storefront hosts multiple campaigns from various publishers. The business actively manages these placements as distinct operational entities, allocating storefront-specific budgets, configuring platform-specific targeting rules, negotiating co-marketing agreements with platform holders, and tracking featured placement timing and performance per storefront-campaign combination.';

CREATE OR REPLACE TABLE `gaming_ecm`.`platform`.`creative_listing_assignment` (
    `creative_listing_assignment_id` BIGINT COMMENT 'Unique identifier for this creative-listing assignment record. Primary key.',
    `ad_creative_id` BIGINT COMMENT 'Foreign key linking to the advertising creative asset used in this assignment',
    `storefront_listing_id` BIGINT COMMENT 'Foreign key linking to the storefront listing that this creative drives traffic to',
    `ab_test_group` STRING COMMENT 'Identifier for the A/B test group or experiment this creative-listing pairing belongs to. Enables grouping of related test variants for performance comparison.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of this creative-listing assignment. ACTIVE: currently running; PAUSED: temporarily stopped; COMPLETED: test concluded; CANCELLED: test terminated early.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this creative-listing assignment record was created in the system.',
    `creative_listing_variant` STRING COMMENT 'Identifier for the specific listing variant being tested with this creative (e.g., VARIANT_A, VARIANT_B, CONTROL). Used to track which listing presentation is paired with which creative in A/B tests.',
    `impression_to_listing_view_rate` DECIMAL(18,2) COMMENT 'Conversion rate from ad impression to storefront listing page view for this specific creative-listing pairing. Key performance metric for creative effectiveness in driving traffic.',
    `listing_view_to_install_rate` DECIMAL(18,2) COMMENT 'Conversion rate from listing page view to game install for this specific creative-listing pairing. Measures the combined effectiveness of creative messaging and listing presentation.',
    `test_end_date` DATE COMMENT 'Date when this creative-listing assignment was deactivated or the test concluded. Null if the assignment is still active. Used to calculate test duration and finalize performance metrics.',
    `test_start_date` DATE COMMENT 'Date when this creative-listing assignment was activated for testing or campaign deployment. Marks the beginning of performance tracking for this pairing.',
    `total_impressions` BIGINT COMMENT 'Total number of ad impressions served for this creative-listing pairing. Used to calculate conversion rates and performance metrics.',
    `total_installs` BIGINT COMMENT 'Total number of game installs attributed to this creative-listing pairing. Final conversion metric for UA campaign effectiveness.',
    `total_listing_views` BIGINT COMMENT 'Total number of storefront listing page views attributed to this creative-listing pairing. Measures traffic driven by the creative to the specific listing.',
    `created_by` STRING COMMENT 'Identifier of the user or system that created this creative-listing assignment.',
    CONSTRAINT pk_creative_listing_assignment PRIMARY KEY(`creative_listing_assignment_id`)
) COMMENT 'This association product represents the assignment between ad_creative and storefront_listing. It captures the operational linkage between advertising creative assets and the specific storefront listing variants they drive traffic to, enabling A/B testing, conversion funnel tracking, and creative performance optimization. Each record links one ad_creative to one storefront_listing with performance metrics and test configuration that exist only in the context of this pairing.. Existence Justification: In gaming UA operations, ad creatives are strategically assigned to multiple storefront listing variants as part of A/B testing and conversion optimization campaigns. A single video creative may drive traffic to different listing presentations (control vs. variant) to test messaging alignment, while a single listing is promoted by multiple creative formats (video, playable, static) across different audience segments and platforms. Marketing teams actively manage these assignments as operational entities, tracking impression-to-view and view-to-install conversion rates for each creative-listing pairing to optimize the full funnel from ad exposure to game installation.';

CREATE OR REPLACE TABLE `gaming_ecm`.`platform`.`storefront_release` (
    `storefront_release_id` BIGINT COMMENT 'Unique surrogate identifier for each storefront release record. Primary key.',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to the game development project being released on this storefront',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to the digital distribution storefront where this project is published',
    `age_rating` STRING COMMENT 'The age rating assigned to this game for this storefront (e.g., ESRB: E, T, M; PEGI: 3, 7, 12, 16, 18). Rating can vary by region and storefront.',
    `approval_date` DATE COMMENT 'Date when this storefront approved the game listing and build for publication.',
    `base_price_usd` DECIMAL(18,2) COMMENT 'The base retail price in US Dollars for this game on this storefront. Pricing can vary by storefront based on platform holder policies and regional strategies.',
    `build_version` STRING COMMENT 'The specific game build version or build number submitted to this storefront (e.g., 1.0.3, 2.5.1). Build versions can differ across storefronts.',
    `certification_status` STRING COMMENT 'Current status of platform certification (TRC/TCR compliance) for this project on this storefront. Values: not_submitted, in_review, failed, passed, certified, waived. Explicitly identified in detection phase as relationship data.',
    `created_at` TIMESTAMP COMMENT 'Timestamp when this storefront release record was created in the system.',
    `delisting_date` DATE COMMENT 'Date when this game was delisted or removed from this storefront, if applicable.',
    `listing_url` STRING COMMENT 'The public URL of the game listing page on this storefront.',
    `pricing_tier` STRING COMMENT 'The pricing tier or SKU variant for this project on this storefront (e.g., free, budget, standard, premium, deluxe, ultimate). Explicitly identified in detection phase as relationship data. Pricing strategy can vary by storefront.',
    `regional_availability` STRING COMMENT 'Geographic regions or countries where this project is available on this storefront (e.g., NA, EU, APAC, or specific country codes). Explicitly identified in detection phase as relationship data. Availability varies by storefront and project.',
    `release_date` DATE COMMENT 'The date this game project was released or is scheduled to be released on this specific storefront. Explicitly identified in detection phase as relationship data.',
    `revenue_share_override_pct` DECIMAL(18,2) COMMENT 'Project-specific revenue share percentage negotiated with this storefront, if different from the storefronts standard revenue_share_percentage. Null if using standard terms.',
    `storefront_listing_status` STRING COMMENT 'Current lifecycle status of the game listing on this storefront. Values: draft, submitted, under_review, approved, live, delisted, sunset. Explicitly identified in detection phase as relationship data.',
    `storefront_sku` STRING COMMENT 'The storefront-specific SKU or product identifier assigned by the platform holder for this game on this storefront.',
    `submission_date` DATE COMMENT 'Date when the game build was submitted to this storefront for certification and review.',
    `supports_achievements` BOOLEAN COMMENT 'Indicates whether this project-storefront release implements platform-specific achievements or trophies.',
    `supports_cloud_saves` BOOLEAN COMMENT 'Indicates whether this project-storefront release supports cloud save synchronization on this platform.',
    `updated_at` TIMESTAMP COMMENT 'Timestamp when this storefront release record was last updated.',
    CONSTRAINT pk_storefront_release PRIMARY KEY(`storefront_release_id`)
) COMMENT 'This association product represents the Release Event between dev_project and storefront. It captures the publication and distribution lifecycle of a game development project on a specific digital storefront. Each record links one dev_project to one storefront with attributes that exist only in the context of this specific platform release: release dates, pricing strategy, regional availability, certification status, and listing lifecycle state.. Existence Justification: In the gaming industry, a single game development project publishes to multiple digital storefronts simultaneously (e.g., Fortnite releases on PlayStation Store, Xbox Store, Steam, Epic Games Store, Nintendo eShop), and each storefront hosts thousands of game titles. Each project-storefront pairing has distinct operational attributes: release dates vary by platform (staggered launches), pricing differs based on platform holder policies, regional availability is storefront-specific, and certification is a per-storefront process (Sony TRC, Microsoft TCR, Nintendo lotcheck). Platform/publishing teams actively manage these storefront releases as distinct operational entities with their own lifecycle (submission, certification, approval, live, delisted).';

CREATE OR REPLACE TABLE `gaming_ecm`.`platform`.`developer_compliance` (
    `developer_compliance_id` BIGINT COMMENT 'Unique identifier for this developer account compliance record. Primary key.',
    `developer_account_id` BIGINT COMMENT 'Foreign key linking to the developer account subject to this regulatory obligation',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to the specific regulatory obligation that applies to this developer account',
    `audit_date` DATE COMMENT 'Date of the most recent audit of this developer accounts compliance with this specific regulatory obligation. Explicitly identified in detection reasoning.',
    `certification_date` DATE COMMENT 'Date when this developer account was certified as compliant with this regulatory obligation. Explicitly identified in detection reasoning.',
    `compliance_status` STRING COMMENT 'Current compliance status of this developer account with respect to this specific regulatory obligation. Explicitly identified in detection reasoning.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance relationship record was first created in the system.',
    `evidence_document_url` STRING COMMENT 'URL or file path to documentation evidencing this developer accounts compliance with this regulatory obligation. Explicitly identified in detection reasoning.',
    `exemption_reason` STRING COMMENT 'Justification for why this developer account is exempt from this regulatory obligation, if applicable.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance relationship record was most recently updated.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review of this developer accounts compliance with this obligation.',
    `remediation_plan` STRING COMMENT 'Description of remediation actions required or in progress if the developer account is non-compliant with this obligation.',
    `responsible_contact` STRING COMMENT 'Name or identifier of the individual responsible for ensuring this developer accounts compliance with this specific obligation. Explicitly identified in detection reasoning.',
    CONSTRAINT pk_developer_compliance PRIMARY KEY(`developer_compliance_id`)
) COMMENT 'This association product represents the compliance relationship between developer accounts and regulatory obligations. It captures the compliance status, certification dates, audit results, and evidence documentation for each developer accounts adherence to specific regulatory requirements. Each record links one developer account to one regulatory obligation with attributes that exist only in the context of this compliance relationship.. Existence Justification: In gaming platform operations, each developer account must comply with multiple regulatory obligations (GDPR, COPPA, loot box disclosure, age rating mandates, tax reporting, etc.), and each regulatory obligation applies to multiple developer accounts across the platform. The compliance team actively manages this many-to-many relationship by tracking per-account, per-obligation compliance status, conducting audits, maintaining certification dates, and storing evidence documentation. This is not a derivable correlation but an operational compliance management process.';

CREATE OR REPLACE TABLE `gaming_ecm`.`platform`.`certification_certificate` (
    `certification_certificate_id` BIGINT COMMENT 'Primary key for certification_certificate',
    `game_title_id` BIGINT COMMENT 'Reference to the game title that this certification certificate applies to.',
    `storefront_id` BIGINT COMMENT 'Reference to the gaming platform for which this certificate was issued (PlayStation, Xbox, Nintendo, Steam, Epic Games Store, Apple App Store, Google Play).',
    `renewed_certification_certificate_id` BIGINT COMMENT 'Self-referencing FK on certification_certificate (renewed_certification_certificate_id)',
    `age_rating` STRING COMMENT 'Age rating classification assigned by the certification authority (ESRB or PEGI ratings).',
    `approval_date` DATE COMMENT 'Date when the certification was officially approved by the platform holder or certification authority.',
    `approval_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the certification was officially approved by the platform holder or certification authority.',
    `certificate_document_url` STRING COMMENT 'URL or file path to the official certificate document issued by the certification authority.',
    `certificate_number` STRING COMMENT 'Externally-known unique certificate number issued by the platform holder or certification authority.',
    `certificate_status` STRING COMMENT 'Current lifecycle status of the certification certificate in the submission and approval workflow.',
    `certificate_type` STRING COMMENT 'Type of certification certificate: Technical Requirements Checklist (TRC), Technical Certification Requirements (TCR), age rating, content rating, technical compliance, or security audit.',
    `certification_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged by the platform holder or certification authority for processing this certification submission.',
    `certification_fee_currency` STRING COMMENT 'Currency code for the certification fee (ISO 4217 three-letter code).',
    `certification_region` STRING COMMENT 'Geographic region or market for which this certification is valid (ISO 3166-1 alpha-3 country code).',
    `content_descriptors` STRING COMMENT 'Comma-separated list of content descriptors or warnings associated with the age rating (e.g., violence, language, blood, online interactions).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification certificate record was first created in the system.',
    `critical_issues_count` STRING COMMENT 'Number of critical issues identified during certification that must be resolved before approval.',
    `cross_platform_compatible` BOOLEAN COMMENT 'Indicates whether this certified build supports cross-platform play or progression.',
    `drm_entitlement_enabled` BOOLEAN COMMENT 'Indicates whether DRM entitlement systems are enabled for this certified build.',
    `effective_date` DATE COMMENT 'Date from which the certification certificate becomes valid and the game build is authorized for distribution on the platform.',
    `expiration_date` DATE COMMENT 'Date when the certification certificate expires and the game build is no longer authorized for distribution without recertification.',
    `external_notes` STRING COMMENT 'Notes and feedback provided by the platform holder or certification authority regarding this submission.',
    `failed_test_cases` STRING COMMENT 'Number of test cases that failed during the certification process.',
    `game_build_version` STRING COMMENT 'Specific game build version number that was submitted for certification (semantic versioning format).',
    `internal_notes` STRING COMMENT 'Internal notes and comments from the development team or certification coordinator regarding this submission.',
    `issuing_authority` STRING COMMENT 'Name of the platform holder, certification body, or regulatory authority that issued the certificate (e.g., Sony Interactive Entertainment, Microsoft Xbox, Nintendo, ESRB, PEGI).',
    `issuing_authority_contact_email` STRING COMMENT 'Primary email address of the issuing authority for correspondence regarding this certification.',
    `major_issues_count` STRING COMMENT 'Number of major issues identified during certification that should be resolved before approval.',
    `minor_issues_count` STRING COMMENT 'Number of minor issues identified during certification that may be addressed in future updates.',
    `passed_test_cases` STRING COMMENT 'Number of test cases that passed during the certification process.',
    `rejection_reason` STRING COMMENT 'Detailed explanation provided by the certification authority if the submission was rejected.',
    `resubmission_count` STRING COMMENT 'Number of times this certification has been resubmitted after initial rejection or failure.',
    `resubmission_required` BOOLEAN COMMENT 'Indicates whether a resubmission is required after addressing identified issues.',
    `review_start_date` DATE COMMENT 'Date when the platform holder or certification authority began reviewing the submission.',
    `reviewer_email` STRING COMMENT 'Email address of the primary reviewer or certification analyst assigned to this submission.',
    `reviewer_name` STRING COMMENT 'Name of the primary reviewer or certification analyst assigned to this submission.',
    `sdk_version` STRING COMMENT 'Version of the platform SDK used to build the game for this certification submission.',
    `submission_date` DATE COMMENT 'Date when the certification submission was formally submitted to the platform holder or certification authority.',
    `submission_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the certification submission was formally submitted to the platform holder or certification authority.',
    `total_test_cases` STRING COMMENT 'Total number of test cases executed during the certification process.',
    `trc_checklist_version` STRING COMMENT 'Version number of the Technical Requirements Checklist (TRC) or Technical Certification Requirements (TCR) that was used for this certification.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification certificate record was last updated in the system.',
    `waived_test_cases` STRING COMMENT 'Number of test cases that were waived or exempted by the certification authority.',
    CONSTRAINT pk_certification_certificate PRIMARY KEY(`certification_certificate_id`)
) COMMENT 'Master reference table for certification_certificate. Referenced by certification_certificate_id.';

CREATE OR REPLACE TABLE `gaming_ecm`.`platform`.`entitlement_rule` (
    `entitlement_rule_id` BIGINT COMMENT 'Primary key for entitlement_rule',
    `storefront_id` BIGINT COMMENT 'Reference to the gaming platform this entitlement rule applies to (PlayStation, Xbox, Nintendo, Steam, Epic Games Store, mobile app stores).',
    `parent_entitlement_rule_id` BIGINT COMMENT 'Self-referencing FK on entitlement_rule (parent_entitlement_rule_id)',
    `age_rating_requirement` STRING COMMENT 'Minimum age rating classification required for users to access this entitlement, based on ESRB or PEGI standards.',
    `approval_required` BOOLEAN COMMENT 'Indicates whether changes to this entitlement rule require formal approval before activation.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when this entitlement rule was approved for activation.',
    `approved_by` STRING COMMENT 'Username or identifier of the user who approved this entitlement rule for activation.',
    `auto_renewal_enabled` BOOLEAN COMMENT 'Indicates whether this entitlement automatically renews upon expiration (applicable to subscription-based entitlements).',
    `certification_date` DATE COMMENT 'Date on which this entitlement rule received platform compliance certification approval.',
    `certification_status` STRING COMMENT 'Current status of platform compliance certification for this entitlement rule (not required, pending review, approved, rejected, or expired).',
    `compliance_certification_required` BOOLEAN COMMENT 'Indicates whether this entitlement rule requires platform-specific compliance certification (TRC/TCR) before activation.',
    `concurrent_device_limit` STRING COMMENT 'The maximum number of devices that can simultaneously use this entitlement. Null indicates no device limit.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this entitlement rule record was first created in the system.',
    `drm_system` STRING COMMENT 'The DRM or entitlement system that enforces this rule (Steamworks, Epic EOS, PlayStation Network DRM, Xbox Live, Nintendo eShop, Google Play, Apple App Store).',
    `effective_end_date` DATE COMMENT 'The date on which this entitlement rule expires or is no longer enforceable. Null indicates indefinite validity.',
    `effective_start_date` DATE COMMENT 'The date from which this entitlement rule becomes active and enforceable.',
    `entitlement_scope` STRING COMMENT 'The scope of content or features this entitlement rule grants: full game, downloadable content (DLC), season pass, cosmetic items, in-game currency, subscription tier, or beta access.',
    `grace_period_days` STRING COMMENT 'Number of days after expiration during which the entitlement remains accessible before being fully revoked. Null indicates no grace period.',
    `internal_notes` STRING COMMENT 'Internal operational notes or comments about this entitlement rule for use by platform operations and compliance teams.',
    `is_stackable` BOOLEAN COMMENT 'Indicates whether multiple instances of this entitlement can be stacked or combined for cumulative effect (e.g., multiple time-limited passes).',
    `is_transferable` BOOLEAN COMMENT 'Indicates whether this entitlement can be transferred or traded between user accounts.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the user who last modified this entitlement rule record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this entitlement rule record was last modified.',
    `max_activations` STRING COMMENT 'The maximum number of times this entitlement can be activated or redeemed. Null indicates unlimited activations.',
    `priority_level` STRING COMMENT 'Numeric priority level for conflict resolution when multiple entitlement rules apply to the same user or product. Higher values indicate higher priority.',
    `product_sku` STRING COMMENT 'The product SKU or catalog identifier this entitlement rule governs access to.',
    `region_restriction` STRING COMMENT 'ISO 3166-1 alpha-3 country codes or region codes where this entitlement is valid. Pipe-separated list for multiple regions. Empty indicates global availability.',
    `revocation_policy` STRING COMMENT 'Policy governing under what conditions this entitlement can be revoked: permanent (never revoked), revocable on refund, revocable on terms violation, revocable on expiry, or non-revocable.',
    `rule_code` STRING COMMENT 'Business-facing unique code for the entitlement rule used in platform configurations and external integrations.',
    `rule_description` STRING COMMENT 'Detailed description of the entitlement rule, including business logic, conditions, and intended use cases.',
    `rule_name` STRING COMMENT 'Human-readable name of the entitlement rule describing its purpose or scope.',
    `rule_status` STRING COMMENT 'Current lifecycle status of the entitlement rule indicating whether it is actively enforced, inactive, deprecated, pending approval, or suspended.',
    `rule_type` STRING COMMENT 'Classification of the entitlement rule by its functional purpose: license-based, subscription-based, consumable (in-game currency, items), time-limited access, feature flag, or platform access control.',
    `trial_duration_days` STRING COMMENT 'Number of days for which this entitlement is granted as a trial before requiring purchase or subscription. Null indicates no trial period.',
    `version_number` STRING COMMENT 'Version number of this entitlement rule, incremented with each modification to track rule evolution and changes.',
    `created_by` STRING COMMENT 'Username or identifier of the user who created this entitlement rule record.',
    CONSTRAINT pk_entitlement_rule PRIMARY KEY(`entitlement_rule_id`)
) COMMENT 'Master reference table for entitlement_rule. Referenced by entitlement_rule_id.';

CREATE OR REPLACE TABLE `gaming_ecm`.`platform`.`platform_holder` (
    `platform_holder_id` BIGINT COMMENT 'Primary key for platform_holder',
    `parent_platform_holder_id` BIGINT COMMENT 'Self-referencing FK on platform_holder (parent_platform_holder_id)',
    `achievements_system_name` STRING COMMENT 'Name of the platform holders proprietary achievements or trophies system (e.g., PlayStation Trophies, Xbox Achievements, Steam Achievements, Google Play Games Achievements).',
    `age_rating_system` STRING COMMENT 'Primary age rating classification system required or recognized by the platform holder. ESRB (North America), PEGI (Europe), CERO (Japan), USK (Germany), ACB (Australia), GRAC (South Korea).',
    `analytics_sdk_available` BOOLEAN COMMENT 'Indicates whether the platform holder provides an analytics SDK for tracking player behavior, engagement metrics, and performance data.',
    `api_version` STRING COMMENT 'Current version of the platform holders API used for integration, submission, and entitlement management.',
    `auto_renewal_enabled` BOOLEAN COMMENT 'Indicates whether the partnership agreement with the platform holder automatically renews upon expiration.',
    `backward_compatibility_supported` BOOLEAN COMMENT 'Indicates whether the platform holder supports running games from previous platform generations on current hardware.',
    `business_development_contact` STRING COMMENT 'Email address or contact identifier for business development, partnership negotiations, and commercial discussions with the platform holder.',
    `certification_process_type` STRING COMMENT 'Type of technical certification or compliance review process required by the platform holder. TRC (Technical Requirements Checklist) for PlayStation, TCR (Technical Certification Requirements) for Xbox, Lotcheck for Nintendo, Steamworks Review for Steam, App Review for Apple, Play Review for Google.',
    `cloud_save_supported` BOOLEAN COMMENT 'Indicates whether the platform holder provides cloud-based game save storage and synchronization services.',
    `platform_holder_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the platform holder for system integration and API usage (e.g., SONY, MSFT, NINTENDO, VALVE, EPIC, APPLE, GOOGLE).',
    `contract_end_date` DATE COMMENT 'Date when the current partnership or developer agreement with the platform holder expires or is scheduled for renewal.',
    `contract_start_date` DATE COMMENT 'Date when the formal partnership or developer agreement with the platform holder became effective.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this platform holder record was first created in the system.',
    `developer_portal_url` STRING COMMENT 'Web address of the platform holders developer portal where SDK documentation, certification guidelines, and submission tools are accessed.',
    `drm_system_name` STRING COMMENT 'Name of the proprietary DRM and entitlement system used by the platform holder to manage game licenses and access control.',
    `headquarters_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the platform holders corporate headquarters location.',
    `legal_entity_name` STRING COMMENT 'Full legal registered name of the platform holder entity as it appears in corporate filings and contracts.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this platform holder record was last updated or modified.',
    `platform_holder_name` STRING COMMENT 'Official business name of the platform holder organization (e.g., Sony Interactive Entertainment, Microsoft Corporation, Nintendo Co. Ltd., Valve Corporation, Epic Games, Apple Inc., Google LLC).',
    `notes` STRING COMMENT 'Free-text field for additional information, special requirements, integration notes, or partnership-specific details related to the platform holder.',
    `partnership_tier` STRING COMMENT 'Classification of the business relationship strength and priority level with the platform holder.',
    `patch_approval_required` BOOLEAN COMMENT 'Indicates whether game updates and patches require formal approval from the platform holder before deployment.',
    `payment_processing_system` STRING COMMENT 'Name of the payment processing and transaction system used by the platform holder for in-game purchases and game sales.',
    `platform_generation` STRING COMMENT 'Generation or version identifier for console platform holders (e.g., PlayStation 5, Xbox Series X|S, Nintendo Switch). Not applicable for PC and mobile storefronts.',
    `primary_contact_email` STRING COMMENT 'Primary email address for business development and partnership communications with the platform holder.',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'Standard percentage of game revenue retained by the platform holder as distribution fee (e.g., 30.00 for typical 30% platform fee, 70.00 goes to publisher).',
    `sdk_integration_required` BOOLEAN COMMENT 'Indicates whether games must integrate the platform holders proprietary SDK for distribution on their platform.',
    `social_features_supported` BOOLEAN COMMENT 'Indicates whether the platform holder provides integrated social networking features such as friends lists, messaging, and activity feeds.',
    `platform_holder_status` STRING COMMENT 'Current operational status of the platform holder in the gaming ecosystem. Active indicates current business relationship; deprecated indicates phasing out; sunset indicates end-of-life; emerging indicates new partnership.',
    `submission_lead_time_days` STRING COMMENT 'Typical number of business days required for the platform holder to complete certification review and approve a game submission.',
    `supports_cross_platform_play` BOOLEAN COMMENT 'Indicates whether the platform holder allows and supports cross-platform multiplayer functionality with other platforms.',
    `supports_cross_platform_progression` BOOLEAN COMMENT 'Indicates whether the platform holder supports cross-platform save data and player progression synchronization.',
    `supports_in_game_purchases` BOOLEAN COMMENT 'Indicates whether the platform holder provides infrastructure and APIs for in-game microtransactions and virtual goods.',
    `supports_subscription_model` BOOLEAN COMMENT 'Indicates whether the platform holder offers a subscription service that includes game access (e.g., PlayStation Plus, Xbox Game Pass, Apple Arcade).',
    `technical_support_contact` STRING COMMENT 'Email address or contact identifier for technical support and SDK integration assistance from the platform holder.',
    `platform_holder_type` STRING COMMENT 'Classification of the platform holder based on the primary distribution channel or technology they provide.',
    CONSTRAINT pk_platform_holder PRIMARY KEY(`platform_holder_id`)
) COMMENT 'Master reference table for platform_holder. Referenced by platform_holder_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ADD CONSTRAINT `fk_platform_storefront_developer_account_id` FOREIGN KEY (`developer_account_id`) REFERENCES `gaming_ecm`.`platform`.`developer_account`(`developer_account_id`);
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ADD CONSTRAINT `fk_platform_platform_sku_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ADD CONSTRAINT `fk_platform_platform_cert_submission_build_submission_id` FOREIGN KEY (`build_submission_id`) REFERENCES `gaming_ecm`.`platform`.`build_submission`(`build_submission_id`);
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ADD CONSTRAINT `fk_platform_platform_cert_submission_certification_certificate_id` FOREIGN KEY (`certification_certificate_id`) REFERENCES `gaming_ecm`.`platform`.`certification_certificate`(`certification_certificate_id`);
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ADD CONSTRAINT `fk_platform_platform_cert_submission_certification_checklist_id` FOREIGN KEY (`certification_checklist_id`) REFERENCES `gaming_ecm`.`platform`.`certification_checklist`(`certification_checklist_id`);
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ADD CONSTRAINT `fk_platform_platform_cert_submission_drm_entitlement_id` FOREIGN KEY (`drm_entitlement_id`) REFERENCES `gaming_ecm`.`platform`.`drm_entitlement`(`drm_entitlement_id`);
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ADD CONSTRAINT `fk_platform_platform_cert_submission_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`platform`.`certification_checklist` ADD CONSTRAINT `fk_platform_certification_checklist_superseded_by_checklist_certification_checklist_id` FOREIGN KEY (`superseded_by_checklist_certification_checklist_id`) REFERENCES `gaming_ecm`.`platform`.`certification_checklist`(`certification_checklist_id`);
ALTER TABLE `gaming_ecm`.`platform`.`checklist_requirement` ADD CONSTRAINT `fk_platform_checklist_requirement_certification_checklist_id` FOREIGN KEY (`certification_checklist_id`) REFERENCES `gaming_ecm`.`platform`.`certification_checklist`(`certification_checklist_id`);
ALTER TABLE `gaming_ecm`.`platform`.`submission_result` ADD CONSTRAINT `fk_platform_submission_result_certification_certificate_id` FOREIGN KEY (`certification_certificate_id`) REFERENCES `gaming_ecm`.`platform`.`certification_certificate`(`certification_certificate_id`);
ALTER TABLE `gaming_ecm`.`platform`.`submission_result` ADD CONSTRAINT `fk_platform_submission_result_platform_cert_submission_id` FOREIGN KEY (`platform_cert_submission_id`) REFERENCES `gaming_ecm`.`platform`.`platform_cert_submission`(`platform_cert_submission_id`);
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ADD CONSTRAINT `fk_platform_drm_entitlement_entitlement_rule_id` FOREIGN KEY (`entitlement_rule_id`) REFERENCES `gaming_ecm`.`platform`.`entitlement_rule`(`entitlement_rule_id`);
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ADD CONSTRAINT `fk_platform_entitlement_grant_drm_entitlement_id` FOREIGN KEY (`drm_entitlement_id`) REFERENCES `gaming_ecm`.`platform`.`drm_entitlement`(`drm_entitlement_id`);
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ADD CONSTRAINT `fk_platform_entitlement_grant_parent_entitlement_entitlement_grant_id` FOREIGN KEY (`parent_entitlement_entitlement_grant_id`) REFERENCES `gaming_ecm`.`platform`.`entitlement_grant`(`entitlement_grant_id`);
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ADD CONSTRAINT `fk_platform_entitlement_grant_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ADD CONSTRAINT `fk_platform_sdk_integration_certification_checklist_id` FOREIGN KEY (`certification_checklist_id`) REFERENCES `gaming_ecm`.`platform`.`certification_checklist`(`certification_checklist_id`);
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ADD CONSTRAINT `fk_platform_sdk_integration_developer_account_id` FOREIGN KEY (`developer_account_id`) REFERENCES `gaming_ecm`.`platform`.`developer_account`(`developer_account_id`);
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ADD CONSTRAINT `fk_platform_sdk_integration_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ADD CONSTRAINT `fk_platform_build_submission_certification_checklist_id` FOREIGN KEY (`certification_checklist_id`) REFERENCES `gaming_ecm`.`platform`.`certification_checklist`(`certification_checklist_id`);
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ADD CONSTRAINT `fk_platform_build_submission_sdk_integration_id` FOREIGN KEY (`sdk_integration_id`) REFERENCES `gaming_ecm`.`platform`.`sdk_integration`(`sdk_integration_id`);
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ADD CONSTRAINT `fk_platform_build_submission_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ADD CONSTRAINT `fk_platform_release_schedule_build_submission_id` FOREIGN KEY (`build_submission_id`) REFERENCES `gaming_ecm`.`platform`.`build_submission`(`build_submission_id`);
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ADD CONSTRAINT `fk_platform_release_schedule_platform_cert_submission_id` FOREIGN KEY (`platform_cert_submission_id`) REFERENCES `gaming_ecm`.`platform`.`platform_cert_submission`(`platform_cert_submission_id`);
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ADD CONSTRAINT `fk_platform_release_schedule_platform_storefront_id` FOREIGN KEY (`platform_storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ADD CONSTRAINT `fk_platform_release_schedule_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ADD CONSTRAINT `fk_platform_compliance_event_certification_checklist_id` FOREIGN KEY (`certification_checklist_id`) REFERENCES `gaming_ecm`.`platform`.`certification_checklist`(`certification_checklist_id`);
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ADD CONSTRAINT `fk_platform_compliance_event_platform_cert_submission_id` FOREIGN KEY (`platform_cert_submission_id`) REFERENCES `gaming_ecm`.`platform`.`platform_cert_submission`(`platform_cert_submission_id`);
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ADD CONSTRAINT `fk_platform_compliance_event_sdk_integration_id` FOREIGN KEY (`sdk_integration_id`) REFERENCES `gaming_ecm`.`platform`.`sdk_integration`(`sdk_integration_id`);
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ADD CONSTRAINT `fk_platform_compliance_event_platform_sku_id` FOREIGN KEY (`platform_sku_id`) REFERENCES `gaming_ecm`.`platform`.`platform_sku`(`platform_sku_id`);
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ADD CONSTRAINT `fk_platform_compliance_event_previous_event_compliance_event_id` FOREIGN KEY (`previous_event_compliance_event_id`) REFERENCES `gaming_ecm`.`platform`.`compliance_event`(`compliance_event_id`);
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ADD CONSTRAINT `fk_platform_compliance_event_release_schedule_id` FOREIGN KEY (`release_schedule_id`) REFERENCES `gaming_ecm`.`platform`.`release_schedule`(`release_schedule_id`);
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` ADD CONSTRAINT `fk_platform_crossplay_feature_certification_checklist_id` FOREIGN KEY (`certification_checklist_id`) REFERENCES `gaming_ecm`.`platform`.`certification_checklist`(`certification_checklist_id`);
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` ADD CONSTRAINT `fk_platform_crossplay_feature_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ADD CONSTRAINT `fk_platform_storefront_listing_compatibility_profile_id` FOREIGN KEY (`compatibility_profile_id`) REFERENCES `gaming_ecm`.`platform`.`compatibility_profile`(`compatibility_profile_id`);
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ADD CONSTRAINT `fk_platform_storefront_listing_platform_sku_id` FOREIGN KEY (`platform_sku_id`) REFERENCES `gaming_ecm`.`platform`.`platform_sku`(`platform_sku_id`);
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ADD CONSTRAINT `fk_platform_storefront_listing_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ADD CONSTRAINT `fk_platform_pricing_platform_sku_id` FOREIGN KEY (`platform_sku_id`) REFERENCES `gaming_ecm`.`platform`.`platform_sku`(`platform_sku_id`);
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ADD CONSTRAINT `fk_platform_pricing_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ADD CONSTRAINT `fk_platform_patch_release_build_submission_id` FOREIGN KEY (`build_submission_id`) REFERENCES `gaming_ecm`.`platform`.`build_submission`(`build_submission_id`);
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ADD CONSTRAINT `fk_platform_patch_release_release_schedule_id` FOREIGN KEY (`release_schedule_id`) REFERENCES `gaming_ecm`.`platform`.`release_schedule`(`release_schedule_id`);
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ADD CONSTRAINT `fk_platform_patch_release_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ADD CONSTRAINT `fk_platform_compatibility_profile_certification_checklist_id` FOREIGN KEY (`certification_checklist_id`) REFERENCES `gaming_ecm`.`platform`.`certification_checklist`(`certification_checklist_id`);
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ADD CONSTRAINT `fk_platform_compatibility_profile_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`platform`.`storefront_campaign` ADD CONSTRAINT `fk_platform_storefront_campaign_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`platform`.`creative_listing_assignment` ADD CONSTRAINT `fk_platform_creative_listing_assignment_storefront_listing_id` FOREIGN KEY (`storefront_listing_id`) REFERENCES `gaming_ecm`.`platform`.`storefront_listing`(`storefront_listing_id`);
ALTER TABLE `gaming_ecm`.`platform`.`storefront_release` ADD CONSTRAINT `fk_platform_storefront_release_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`platform`.`developer_compliance` ADD CONSTRAINT `fk_platform_developer_compliance_developer_account_id` FOREIGN KEY (`developer_account_id`) REFERENCES `gaming_ecm`.`platform`.`developer_account`(`developer_account_id`);
ALTER TABLE `gaming_ecm`.`platform`.`certification_certificate` ADD CONSTRAINT `fk_platform_certification_certificate_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`platform`.`certification_certificate` ADD CONSTRAINT `fk_platform_certification_certificate_renewed_certification_certificate_id` FOREIGN KEY (`renewed_certification_certificate_id`) REFERENCES `gaming_ecm`.`platform`.`certification_certificate`(`certification_certificate_id`);
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_rule` ADD CONSTRAINT `fk_platform_entitlement_rule_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_rule` ADD CONSTRAINT `fk_platform_entitlement_rule_parent_entitlement_rule_id` FOREIGN KEY (`parent_entitlement_rule_id`) REFERENCES `gaming_ecm`.`platform`.`entitlement_rule`(`entitlement_rule_id`);
ALTER TABLE `gaming_ecm`.`platform`.`platform_holder` ADD CONSTRAINT `fk_platform_platform_holder_parent_platform_holder_id` FOREIGN KEY (`parent_platform_holder_id`) REFERENCES `gaming_ecm`.`platform`.`platform_holder`(`platform_holder_id`);

-- ========= TAGS =========
ALTER SCHEMA `gaming_ecm`.`platform` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `gaming_ecm`.`platform` SET TAGS ('dbx_domain' = 'platform');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` SET TAGS ('dbx_subdomain' = 'distribution_commerce');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront ID');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `ad_network_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Network Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `developer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Developer Account Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `network_region_id` SET TAGS ('dbx_business_glossary_term' = 'Network Region Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Holder ID');
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
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
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ALTER COLUMN `content_policy_url` SET TAGS ('dbx_business_glossary_term' = 'Content Policy URL (Uniform Resource Locator)');
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
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` SET TAGS ('dbx_subdomain' = 'distribution_commerce');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `platform_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Stock Keeping Unit (SKU) ID');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `age_rating_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Age Rating Cert Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Hero Image Asset Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `marketing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
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
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ALTER COLUMN `edition_type` SET TAGS ('dbx_business_glossary_term' = 'Edition Type');
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
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` SET TAGS ('dbx_subdomain' = 'certification_compliance');
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ALTER COLUMN `platform_cert_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Submission ID');
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ALTER COLUMN `age_rating_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Age Rating Cert Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ALTER COLUMN `build_artifact_id` SET TAGS ('dbx_business_glossary_term' = 'Build Artifact Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ALTER COLUMN `build_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Build Submission Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ALTER COLUMN `certification_certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Certificate ID');
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ALTER COLUMN `certification_checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Checklist Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ALTER COLUMN `drm_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Entitlement ID');
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ALTER COLUMN `drm_entitlement_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Submitted By User ID');
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Studio ID');
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ALTER COLUMN `game_server_id` SET TAGS ('dbx_business_glossary_term' = 'Test Game Server Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ALTER COLUMN `accessibility_features_included` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Features Included Flag');
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Approval Date');
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ALTER COLUMN `certification_outcome` SET TAGS ('dbx_business_glossary_term' = 'Certification Outcome');
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ALTER COLUMN `certification_outcome` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass|pending|not_reviewed');
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ALTER COLUMN `cross_platform_compatible` SET TAGS ('dbx_business_glossary_term' = 'Cross-Platform Compatible Flag');
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ALTER COLUMN `esrb_rating` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Software Rating Board (ESRB) Rating');
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ALTER COLUMN `esrb_rating` SET TAGS ('dbx_value_regex' = 'E|E10|T|M|AO|RP');
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ALTER COLUMN `failure_categories` SET TAGS ('dbx_business_glossary_term' = 'Failure Categories');
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ALTER COLUMN `failure_count` SET TAGS ('dbx_business_glossary_term' = 'Certification Failure Count');
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ALTER COLUMN `in_app_purchases_enabled` SET TAGS ('dbx_business_glossary_term' = 'In-App Purchases (IAP) Enabled Flag');
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ALTER COLUMN `multiplayer_enabled` SET TAGS ('dbx_business_glossary_term' = 'Multiplayer Enabled Flag');
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ALTER COLUMN `pegi_rating` SET TAGS ('dbx_business_glossary_term' = 'Pan European Game Information (PEGI) Rating');
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ALTER COLUMN `pegi_rating` SET TAGS ('dbx_value_regex' = '3|7|12|16|18');
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ALTER COLUMN `platform_reviewer_notes` SET TAGS ('dbx_business_glossary_term' = 'Platform Holder Reviewer Notes');
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ALTER COLUMN `platform_reviewer_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ALTER COLUMN `platform_sdk_version` SET TAGS ('dbx_business_glossary_term' = 'Platform Software Development Kit (SDK) Version');
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ALTER COLUMN `resubmission_deadline` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Deadline Date');
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ALTER COLUMN `review_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ALTER COLUMN `review_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Start Date');
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ALTER COLUMN `submission_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Submission Notes');
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ALTER COLUMN `submission_number` SET TAGS ('dbx_business_glossary_term' = 'Submission Number');
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Pipeline Status');
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_business_glossary_term' = 'Submission Type');
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_value_regex' = 'initial|resubmission|patch|dlc|update');
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ALTER COLUMN `target_release_date` SET TAGS ('dbx_business_glossary_term' = 'Target Release Date');
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ALTER COLUMN `waiver_details` SET TAGS ('dbx_business_glossary_term' = 'Waiver Details');
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ALTER COLUMN `waiver_granted` SET TAGS ('dbx_business_glossary_term' = 'Waiver Granted Flag');
ALTER TABLE `gaming_ecm`.`platform`.`certification_checklist` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`platform`.`certification_checklist` SET TAGS ('dbx_subdomain' = 'certification_compliance');
ALTER TABLE `gaming_ecm`.`platform`.`certification_checklist` ALTER COLUMN `certification_checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Checklist ID');
ALTER TABLE `gaming_ecm`.`platform`.`certification_checklist` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Holder ID');
ALTER TABLE `gaming_ecm`.`platform`.`certification_checklist` ALTER COLUMN `superseded_by_checklist_certification_checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Checklist ID');
ALTER TABLE `gaming_ecm`.`platform`.`certification_checklist` ALTER COLUMN `accessibility_requirements_flag` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Requirements Flag');
ALTER TABLE `gaming_ecm`.`platform`.`certification_checklist` ALTER COLUMN `advisory_requirement_count` SET TAGS ('dbx_business_glossary_term' = 'Advisory Requirement Count');
ALTER TABLE `gaming_ecm`.`platform`.`certification_checklist` ALTER COLUMN `age_rating_requirements_flag` SET TAGS ('dbx_business_glossary_term' = 'Age Rating Requirements Flag');
ALTER TABLE `gaming_ecm`.`platform`.`certification_checklist` ALTER COLUMN `average_review_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Average Review Duration Days');
ALTER TABLE `gaming_ecm`.`platform`.`certification_checklist` ALTER COLUMN `category_taxonomy` SET TAGS ('dbx_business_glossary_term' = 'Category Taxonomy');
ALTER TABLE `gaming_ecm`.`platform`.`certification_checklist` ALTER COLUMN `certification_checklist_status` SET TAGS ('dbx_business_glossary_term' = 'Checklist Status');
ALTER TABLE `gaming_ecm`.`platform`.`certification_checklist` ALTER COLUMN `certification_checklist_status` SET TAGS ('dbx_value_regex' = 'Draft|Active|Deprecated|Superseded|Archived');
ALTER TABLE `gaming_ecm`.`platform`.`certification_checklist` ALTER COLUMN `certification_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Certification Fee Amount');
ALTER TABLE `gaming_ecm`.`platform`.`certification_checklist` ALTER COLUMN `certification_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`certification_checklist` ALTER COLUMN `certification_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Certification Fee Currency');
ALTER TABLE `gaming_ecm`.`platform`.`certification_checklist` ALTER COLUMN `certification_fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`platform`.`certification_checklist` ALTER COLUMN `checklist_code` SET TAGS ('dbx_business_glossary_term' = 'Checklist Code');
ALTER TABLE `gaming_ecm`.`platform`.`certification_checklist` ALTER COLUMN `checklist_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `gaming_ecm`.`platform`.`certification_checklist` ALTER COLUMN `checklist_name` SET TAGS ('dbx_business_glossary_term' = 'Checklist Name');
ALTER TABLE `gaming_ecm`.`platform`.`certification_checklist` ALTER COLUMN `checklist_type` SET TAGS ('dbx_business_glossary_term' = 'Checklist Type');
ALTER TABLE `gaming_ecm`.`platform`.`certification_checklist` ALTER COLUMN `checklist_type` SET TAGS ('dbx_value_regex' = 'TRC|TCR|Submission Guidelines|Compliance Checklist');
ALTER TABLE `gaming_ecm`.`platform`.`certification_checklist` ALTER COLUMN `conditional_requirement_count` SET TAGS ('dbx_business_glossary_term' = 'Conditional Requirement Count');
ALTER TABLE `gaming_ecm`.`platform`.`certification_checklist` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`certification_checklist` ALTER COLUMN `cross_platform_compatibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Platform Compatibility Flag');
ALTER TABLE `gaming_ecm`.`platform`.`certification_checklist` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation URL');
ALTER TABLE `gaming_ecm`.`platform`.`certification_checklist` ALTER COLUMN `documentation_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `gaming_ecm`.`platform`.`certification_checklist` ALTER COLUMN `drm_requirements_flag` SET TAGS ('dbx_business_glossary_term' = 'DRM (Digital Rights Management) Requirements Flag');
ALTER TABLE `gaming_ecm`.`platform`.`certification_checklist` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `gaming_ecm`.`platform`.`certification_checklist` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `gaming_ecm`.`platform`.`certification_checklist` ALTER COLUMN `mandatory_requirement_count` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Requirement Count');
ALTER TABLE `gaming_ecm`.`platform`.`certification_checklist` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`certification_checklist` ALTER COLUMN `platform_generation` SET TAGS ('dbx_business_glossary_term' = 'Platform Generation');
ALTER TABLE `gaming_ecm`.`platform`.`certification_checklist` ALTER COLUMN `platform_holder_contact` SET TAGS ('dbx_business_glossary_term' = 'Platform Holder Contact');
ALTER TABLE `gaming_ecm`.`platform`.`certification_checklist` ALTER COLUMN `platform_holder_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`certification_checklist` ALTER COLUMN `privacy_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Privacy Compliance Flag');
ALTER TABLE `gaming_ecm`.`platform`.`certification_checklist` ALTER COLUMN `published_date` SET TAGS ('dbx_business_glossary_term' = 'Published Date');
ALTER TABLE `gaming_ecm`.`platform`.`certification_checklist` ALTER COLUMN `release_notes` SET TAGS ('dbx_business_glossary_term' = 'Release Notes');
ALTER TABLE `gaming_ecm`.`platform`.`certification_checklist` ALTER COLUMN `resubmission_policy` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Policy');
ALTER TABLE `gaming_ecm`.`platform`.`certification_checklist` ALTER COLUMN `sdk_version_minimum` SET TAGS ('dbx_business_glossary_term' = 'SDK (Software Development Kit) Version Minimum');
ALTER TABLE `gaming_ecm`.`platform`.`certification_checklist` ALTER COLUMN `sdk_version_recommended` SET TAGS ('dbx_business_glossary_term' = 'SDK (Software Development Kit) Version Recommended');
ALTER TABLE `gaming_ecm`.`platform`.`certification_checklist` ALTER COLUMN `submission_format` SET TAGS ('dbx_business_glossary_term' = 'Submission Format');
ALTER TABLE `gaming_ecm`.`platform`.`certification_checklist` ALTER COLUMN `total_requirement_count` SET TAGS ('dbx_business_glossary_term' = 'Total Requirement Count');
ALTER TABLE `gaming_ecm`.`platform`.`certification_checklist` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `gaming_ecm`.`platform`.`certification_checklist` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `gaming_ecm`.`platform`.`certification_checklist` ALTER COLUMN `waiver_process_description` SET TAGS ('dbx_business_glossary_term' = 'Waiver Process Description');
ALTER TABLE `gaming_ecm`.`platform`.`checklist_requirement` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `gaming_ecm`.`platform`.`checklist_requirement` SET TAGS ('dbx_subdomain' = 'certification_compliance');
ALTER TABLE `gaming_ecm`.`platform`.`checklist_requirement` ALTER COLUMN `checklist_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Checklist Requirement ID');
ALTER TABLE `gaming_ecm`.`platform`.`checklist_requirement` ALTER COLUMN `certification_checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Checklist ID');
ALTER TABLE `gaming_ecm`.`platform`.`checklist_requirement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Quality Assurance (QA) Tester ID');
ALTER TABLE `gaming_ecm`.`platform`.`checklist_requirement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`checklist_requirement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`checklist_requirement` ALTER COLUMN `actual_effort_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Effort Hours');
ALTER TABLE `gaming_ecm`.`platform`.`checklist_requirement` ALTER COLUMN `applicable_platforms` SET TAGS ('dbx_business_glossary_term' = 'Applicable Platforms');
ALTER TABLE `gaming_ecm`.`platform`.`checklist_requirement` ALTER COLUMN `build_version_tested` SET TAGS ('dbx_business_glossary_term' = 'Build Version Tested');
ALTER TABLE `gaming_ecm`.`platform`.`checklist_requirement` ALTER COLUMN `checklist_requirement_category` SET TAGS ('dbx_business_glossary_term' = 'Requirement Category');
ALTER TABLE `gaming_ecm`.`platform`.`checklist_requirement` ALTER COLUMN `checklist_requirement_category` SET TAGS ('dbx_value_regex' = 'audio|video|network|save_data|accessibility|age_rating');
ALTER TABLE `gaming_ecm`.`platform`.`checklist_requirement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `gaming_ecm`.`platform`.`checklist_requirement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|passed|failed|waived|not_applicable');
ALTER TABLE `gaming_ecm`.`platform`.`checklist_requirement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`checklist_requirement` ALTER COLUMN `deprecated_flag` SET TAGS ('dbx_business_glossary_term' = 'Deprecated Flag');
ALTER TABLE `gaming_ecm`.`platform`.`checklist_requirement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `gaming_ecm`.`platform`.`checklist_requirement` ALTER COLUMN `estimated_effort_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Effort Hours');
ALTER TABLE `gaming_ecm`.`platform`.`checklist_requirement` ALTER COLUMN `failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Failure Reason');
ALTER TABLE `gaming_ecm`.`platform`.`checklist_requirement` ALTER COLUMN `jira_ticket_key` SET TAGS ('dbx_business_glossary_term' = 'Jira Ticket Key');
ALTER TABLE `gaming_ecm`.`platform`.`checklist_requirement` ALTER COLUMN `jira_ticket_key` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,10}-[0-9]+$');
ALTER TABLE `gaming_ecm`.`platform`.`checklist_requirement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`checklist_requirement` ALTER COLUMN `platform_holder_feedback` SET TAGS ('dbx_business_glossary_term' = 'Platform Holder Feedback');
ALTER TABLE `gaming_ecm`.`platform`.`checklist_requirement` ALTER COLUMN `platform_holder_guidance` SET TAGS ('dbx_business_glossary_term' = 'Platform Holder Guidance Notes');
ALTER TABLE `gaming_ecm`.`platform`.`checklist_requirement` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `gaming_ecm`.`platform`.`checklist_requirement` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `gaming_ecm`.`platform`.`checklist_requirement` ALTER COLUMN `remediation_plan` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan');
ALTER TABLE `gaming_ecm`.`platform`.`checklist_requirement` ALTER COLUMN `requirement_code` SET TAGS ('dbx_business_glossary_term' = 'Technical Requirements Checklist (TRC) / Technical Certification Requirements (TCR) Requirement Code');
ALTER TABLE `gaming_ecm`.`platform`.`checklist_requirement` ALTER COLUMN `requirement_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{3,4}[A-Z]?$');
ALTER TABLE `gaming_ecm`.`platform`.`checklist_requirement` ALTER COLUMN `requirement_description` SET TAGS ('dbx_business_glossary_term' = 'Requirement Description');
ALTER TABLE `gaming_ecm`.`platform`.`checklist_requirement` ALTER COLUMN `requirement_title` SET TAGS ('dbx_business_glossary_term' = 'Requirement Title');
ALTER TABLE `gaming_ecm`.`platform`.`checklist_requirement` ALTER COLUMN `requirement_version` SET TAGS ('dbx_business_glossary_term' = 'Requirement Version');
ALTER TABLE `gaming_ecm`.`platform`.`checklist_requirement` ALTER COLUMN `retest_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Retest Required Flag');
ALTER TABLE `gaming_ecm`.`platform`.`checklist_requirement` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Requirement Severity');
ALTER TABLE `gaming_ecm`.`platform`.`checklist_requirement` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'mandatory|advisory|conditional');
ALTER TABLE `gaming_ecm`.`platform`.`checklist_requirement` ALTER COLUMN `test_case_reference` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Test Case Reference');
ALTER TABLE `gaming_ecm`.`platform`.`checklist_requirement` ALTER COLUMN `test_execution_date` SET TAGS ('dbx_business_glossary_term' = 'Test Execution Date');
ALTER TABLE `gaming_ecm`.`platform`.`checklist_requirement` ALTER COLUMN `test_result_notes` SET TAGS ('dbx_business_glossary_term' = 'Test Result Notes');
ALTER TABLE `gaming_ecm`.`platform`.`checklist_requirement` ALTER COLUMN `waiver_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approval Status');
ALTER TABLE `gaming_ecm`.`platform`.`checklist_requirement` ALTER COLUMN `waiver_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|denied|not_requested');
ALTER TABLE `gaming_ecm`.`platform`.`checklist_requirement` ALTER COLUMN `waiver_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver Eligible Flag');
ALTER TABLE `gaming_ecm`.`platform`.`checklist_requirement` ALTER COLUMN `waiver_request_notes` SET TAGS ('dbx_business_glossary_term' = 'Waiver Request Notes');
ALTER TABLE `gaming_ecm`.`platform`.`submission_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`platform`.`submission_result` SET TAGS ('dbx_subdomain' = 'certification_compliance');
ALTER TABLE `gaming_ecm`.`platform`.`submission_result` ALTER COLUMN `submission_result_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Result ID');
ALTER TABLE `gaming_ecm`.`platform`.`submission_result` ALTER COLUMN `certification_certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Certificate ID');
ALTER TABLE `gaming_ecm`.`platform`.`submission_result` ALTER COLUMN `platform_cert_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Submission ID');
ALTER TABLE `gaming_ecm`.`platform`.`submission_result` ALTER COLUMN `appeal_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Deadline Date');
ALTER TABLE `gaming_ecm`.`platform`.`submission_result` ALTER COLUMN `appeal_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Eligible Flag');
ALTER TABLE `gaming_ecm`.`platform`.`submission_result` ALTER COLUMN `content_policy_failure_count` SET TAGS ('dbx_business_glossary_term' = 'Content Policy Failure Count');
ALTER TABLE `gaming_ecm`.`platform`.`submission_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`submission_result` ALTER COLUMN `critical_failure_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Failure Count');
ALTER TABLE `gaming_ecm`.`platform`.`submission_result` ALTER COLUMN `detailed_failure_report_url` SET TAGS ('dbx_business_glossary_term' = 'Detailed Failure Report URL');
ALTER TABLE `gaming_ecm`.`platform`.`submission_result` ALTER COLUMN `executive_summary` SET TAGS ('dbx_business_glossary_term' = 'Executive Summary');
ALTER TABLE `gaming_ecm`.`platform`.`submission_result` ALTER COLUMN `fast_track_resubmission_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Fast Track Resubmission Eligible Flag');
ALTER TABLE `gaming_ecm`.`platform`.`submission_result` ALTER COLUMN `functional_failure_count` SET TAGS ('dbx_business_glossary_term' = 'Functional Failure Count');
ALTER TABLE `gaming_ecm`.`platform`.`submission_result` ALTER COLUMN `gold_master_approved_flag` SET TAGS ('dbx_business_glossary_term' = 'Gold Master Approved Flag');
ALTER TABLE `gaming_ecm`.`platform`.`submission_result` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`submission_result` ALTER COLUMN `localization_failure_count` SET TAGS ('dbx_business_glossary_term' = 'Localization Failure Count');
ALTER TABLE `gaming_ecm`.`platform`.`submission_result` ALTER COLUMN `major_failure_count` SET TAGS ('dbx_business_glossary_term' = 'Major Failure Count');
ALTER TABLE `gaming_ecm`.`platform`.`submission_result` ALTER COLUMN `minor_failure_count` SET TAGS ('dbx_business_glossary_term' = 'Minor Failure Count');
ALTER TABLE `gaming_ecm`.`platform`.`submission_result` ALTER COLUMN `network_failure_count` SET TAGS ('dbx_business_glossary_term' = 'Network Failure Count');
ALTER TABLE `gaming_ecm`.`platform`.`submission_result` ALTER COLUMN `performance_failure_count` SET TAGS ('dbx_business_glossary_term' = 'Performance Failure Count');
ALTER TABLE `gaming_ecm`.`platform`.`submission_result` ALTER COLUMN `platform_holder_reviewer_email` SET TAGS ('dbx_business_glossary_term' = 'Platform Holder Reviewer Email');
ALTER TABLE `gaming_ecm`.`platform`.`submission_result` ALTER COLUMN `platform_holder_reviewer_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `gaming_ecm`.`platform`.`submission_result` ALTER COLUMN `platform_holder_reviewer_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`submission_result` ALTER COLUMN `platform_holder_reviewer_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`submission_result` ALTER COLUMN `platform_holder_reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Platform Holder Reviewer Name');
ALTER TABLE `gaming_ecm`.`platform`.`submission_result` ALTER COLUMN `platform_holder_reviewer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`submission_result` ALTER COLUMN `resubmission_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Deadline Date');
ALTER TABLE `gaming_ecm`.`platform`.`submission_result` ALTER COLUMN `result_notification_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Result Notification Sent Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`submission_result` ALTER COLUMN `result_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Result Sequence Number');
ALTER TABLE `gaming_ecm`.`platform`.`submission_result` ALTER COLUMN `result_status` SET TAGS ('dbx_business_glossary_term' = 'Result Status');
ALTER TABLE `gaming_ecm`.`platform`.`submission_result` ALTER COLUMN `result_status` SET TAGS ('dbx_value_regex' = 'active|superseded|appealed|archived');
ALTER TABLE `gaming_ecm`.`platform`.`submission_result` ALTER COLUMN `result_type` SET TAGS ('dbx_business_glossary_term' = 'Result Type');
ALTER TABLE `gaming_ecm`.`platform`.`submission_result` ALTER COLUMN `result_type` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass|waiver_granted|withdrawn|cancelled');
ALTER TABLE `gaming_ecm`.`platform`.`submission_result` ALTER COLUMN `review_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `gaming_ecm`.`platform`.`submission_result` ALTER COLUMN `review_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Review Duration Hours');
ALTER TABLE `gaming_ecm`.`platform`.`submission_result` ALTER COLUMN `reviewer_notes` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Notes');
ALTER TABLE `gaming_ecm`.`platform`.`submission_result` ALTER COLUMN `studio_acknowledged_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Studio Acknowledged Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`submission_result` ALTER COLUMN `test_environment_configuration` SET TAGS ('dbx_business_glossary_term' = 'Test Environment Configuration');
ALTER TABLE `gaming_ecm`.`platform`.`submission_result` ALTER COLUMN `total_failure_count` SET TAGS ('dbx_business_glossary_term' = 'Total Failure Count');
ALTER TABLE `gaming_ecm`.`platform`.`submission_result` ALTER COLUMN `ui_ux_failure_count` SET TAGS ('dbx_business_glossary_term' = 'User Interface and User Experience (UI/UX) Failure Count');
ALTER TABLE `gaming_ecm`.`platform`.`submission_result` ALTER COLUMN `waiver_granted_count` SET TAGS ('dbx_business_glossary_term' = 'Waiver Granted Count');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` SET TAGS ('dbx_subdomain' = 'entitlement_integration');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `drm_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Entitlement ID');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `age_verification_event_id` SET TAGS ('dbx_business_glossary_term' = 'Age Verification Event Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Revoked By User ID');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `entitlement_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Rule ID');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `platform_identity_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Account ID');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `platform_identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `platform_identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `player_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `player_account_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ALTER COLUMN `title_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
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
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` SET TAGS ('dbx_subdomain' = 'entitlement_integration');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `entitlement_grant_id` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Grant ID');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `age_verification_event_id` SET TAGS ('dbx_business_glossary_term' = 'Age Verification Event Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `dlc_bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle ID');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `device_id` SET TAGS ('dbx_business_glossary_term' = 'Device ID');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `device_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `device_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `drm_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Drm Entitlement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Granted By User ID');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `parent_entitlement_entitlement_grant_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Entitlement ID');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `platform_identity_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Account ID');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `platform_identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `platform_identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player Account ID');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `promo_code_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Code ID');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription ID');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `title_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `content_version` SET TAGS ('dbx_business_glossary_term' = 'Content Version');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `current_activations` SET TAGS ('dbx_business_glossary_term' = 'Current Activations');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `device_binding_enabled` SET TAGS ('dbx_business_glossary_term' = 'Device Binding Enabled');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `drm_token` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Token');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `drm_token` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `entitlement_description` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Description');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `entitlement_name` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Name');
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
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ALTER COLUMN `source_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Transaction ID');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` SET TAGS ('dbx_subdomain' = 'entitlement_integration');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ALTER COLUMN `sdk_integration_id` SET TAGS ('dbx_business_glossary_term' = 'Software Development Kit (SDK) Integration ID');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ALTER COLUMN `certification_checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Checklist Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ALTER COLUMN `developer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Developer Account Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ALTER COLUMN `matchmaking_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Matchmaking Pool Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ALTER COLUMN `middleware_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Middleware Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ALTER COLUMN `third_party_processor_id` SET TAGS ('dbx_business_glossary_term' = 'Third Party Processor Id (Foreign Key)');
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
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` SET TAGS ('dbx_subdomain' = 'entitlement_integration');
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ALTER COLUMN `build_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Build Submission ID');
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ALTER COLUMN `age_rating_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Age Rating Cert Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ALTER COLUMN `capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Project Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ALTER COLUMN `certification_checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Checklist Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Submitted By User ID');
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Studio ID');
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ALTER COLUMN `sdk_integration_id` SET TAGS ('dbx_business_glossary_term' = 'Sdk Integration Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ALTER COLUMN `server_fleet_id` SET TAGS ('dbx_business_glossary_term' = 'Target Server Fleet Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ALTER COLUMN `build_configuration` SET TAGS ('dbx_business_glossary_term' = 'Build Configuration');
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ALTER COLUMN `build_configuration` SET TAGS ('dbx_value_regex' = 'development|staging|production');
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ALTER COLUMN `build_hash` SET TAGS ('dbx_business_glossary_term' = 'Build Hash Checksum');
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ALTER COLUMN `build_pipeline_code` SET TAGS ('dbx_business_glossary_term' = 'Build Pipeline ID');
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ALTER COLUMN `build_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Build Size in Bytes');
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ALTER COLUMN `build_type` SET TAGS ('dbx_business_glossary_term' = 'Build Type');
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ALTER COLUMN `build_version` SET TAGS ('dbx_business_glossary_term' = 'Build Version String');
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ALTER COLUMN `content_rating` SET TAGS ('dbx_business_glossary_term' = 'Content Rating');
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ALTER COLUMN `drm_type` SET TAGS ('dbx_business_glossary_term' = 'DRM (Digital Rights Management) Type');
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ALTER COLUMN `drm_type` SET TAGS ('dbx_value_regex' = 'steamworks|epic_eac|denuvo|platform_native|none');
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ALTER COLUMN `is_cross_platform` SET TAGS ('dbx_business_glossary_term' = 'Cross-Platform Flag');
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ALTER COLUMN `is_gold_master` SET TAGS ('dbx_business_glossary_term' = 'Gold Master Flag');
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ALTER COLUMN `minimum_os_version` SET TAGS ('dbx_business_glossary_term' = 'Minimum Operating System (OS) Version');
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ALTER COLUMN `packaging_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Packaging Completed Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ALTER COLUMN `packaging_started_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Packaging Started Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ALTER COLUMN `rejected_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Rejection Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ALTER COLUMN `release_notes` SET TAGS ('dbx_business_glossary_term' = 'Release Notes');
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ALTER COLUMN `requires_day_one_patch` SET TAGS ('dbx_business_glossary_term' = 'Requires Day One Patch Flag');
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ALTER COLUMN `source_commit_hash` SET TAGS ('dbx_business_glossary_term' = 'Source Commit Hash');
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ALTER COLUMN `submission_channel` SET TAGS ('dbx_business_glossary_term' = 'Submission Channel');
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ALTER COLUMN `submission_notes` SET TAGS ('dbx_business_glossary_term' = 'Submission Notes');
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ALTER COLUMN `submission_number` SET TAGS ('dbx_business_glossary_term' = 'Build Submission Number');
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Pipeline Status');
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ALTER COLUMN `submission_status` SET TAGS ('dbx_value_regex' = 'packaging|uploading|validating|submitted|approved|rejected');
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ALTER COLUMN `supported_languages` SET TAGS ('dbx_business_glossary_term' = 'Supported Languages');
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ALTER COLUMN `upload_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Upload Completed Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ALTER COLUMN `upload_started_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Upload Started Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ALTER COLUMN `validation_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Completed Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ALTER COLUMN `validation_started_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Started Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` SET TAGS ('dbx_subdomain' = 'distribution_commerce');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `release_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Release Schedule ID');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `age_rating_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Age Rating Cert Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `build_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Build Submission Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `capacity_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Plan Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `launch_event_id` SET TAGS ('dbx_business_glossary_term' = 'Launch Event Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `platform_cert_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Cert Submission Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `platform_storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `server_fleet_id` SET TAGS ('dbx_business_glossary_term' = 'Server Fleet Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront ID');
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
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` SET TAGS ('dbx_subdomain' = 'certification_compliance');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `compliance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Event ID');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `certification_checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Checklist Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `finance_tax_record_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Tax Record Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `platform_cert_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Cert Submission Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `sdk_integration_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Integration ID');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `platform_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Stock Keeping Unit (SKU) ID');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `previous_event_compliance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Compliance Event ID');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `release_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Release Schedule Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `affected_platform_code` SET TAGS ('dbx_business_glossary_term' = 'Affected Platform Code');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `assigned_department` SET TAGS ('dbx_business_glossary_term' = 'Assigned Department');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `assigned_department` SET TAGS ('dbx_value_regex' = 'platform_engineering|legal|compliance|qa|publishing|studio');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `assigned_owner_email` SET TAGS ('dbx_business_glossary_term' = 'Assigned Owner Email Address');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `assigned_owner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `assigned_owner_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `assigned_owner_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `assigned_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Assigned Owner Name');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `assigned_owner_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `assigned_owner_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `communication_thread_url` SET TAGS ('dbx_business_glossary_term' = 'Communication Thread Uniform Resource Locator (URL)');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline Date');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation Uniform Resource Locator (URL)');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Escalation Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `event_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Compliance Event Reference Number');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `event_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Event Status');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|pending_review|resolved|closed|escalated');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Compliance Event Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Compliance Event Type');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'policy_violation|sdk_update_required|age_rating_review|gdpr_flag|coppa_flag|age_gate_enforcement');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `financial_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Penalty Amount');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `financial_penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `financial_penalty_currency` SET TAGS ('dbx_business_glossary_term' = 'Financial Penalty Currency Code');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `financial_penalty_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `notification_received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Received Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `originating_entity` SET TAGS ('dbx_business_glossary_term' = 'Originating Entity Name');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `originating_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Originating Entity Type');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `originating_entity_type` SET TAGS ('dbx_value_regex' = 'platform_holder|regulatory_body|certification_authority|internal_audit');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `platform_suspension_flag` SET TAGS ('dbx_business_glossary_term' = 'Platform Suspension Flag');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `policy_section_reference` SET TAGS ('dbx_business_glossary_term' = 'Policy Section Reference');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `recurrence_flag` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Flag');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `remediation_action_required` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action Required');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|verified|rejected');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Compliance Event Severity Level');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|informational');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `suspension_end_date` SET TAGS ('dbx_business_glossary_term' = 'Platform Suspension End Date');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `suspension_start_date` SET TAGS ('dbx_business_glossary_term' = 'Platform Suspension Start Date');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `trc_tcr_reference` SET TAGS ('dbx_business_glossary_term' = 'Technical Requirements Checklist (TRC) / Technical Certification Requirements (TCR) Reference');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ALTER COLUMN `violation_description` SET TAGS ('dbx_business_glossary_term' = 'Compliance Violation Description');
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` SET TAGS ('dbx_subdomain' = 'entitlement_integration');
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` ALTER COLUMN `crossplay_feature_id` SET TAGS ('dbx_business_glossary_term' = 'Cross-Play Feature ID');
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` ALTER COLUMN `certification_checklist_id` SET TAGS ('dbx_business_glossary_term' = 'TRC (Technical Requirements Checklist) / TCR (Technical Certification Requirements) Compliance Checklist ID');
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` ALTER COLUMN `matchmaking_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Matchmaking Pool Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Platform ID');
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Platform Holder Approval Date');
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` ALTER COLUMN `data_sharing_scope` SET TAGS ('dbx_business_glossary_term' = 'Cross-Platform Data Sharing Scope');
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` ALTER COLUMN `deprecation_date` SET TAGS ('dbx_business_glossary_term' = 'Cross-Play Feature Deprecation Date');
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` ALTER COLUMN `deprecation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cross-Play Feature Deprecation Reason');
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` ALTER COLUMN `entitlement_sync_enabled` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Synchronization Enabled Flag');
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` ALTER COLUMN `estimated_ccu_impact` SET TAGS ('dbx_business_glossary_term' = 'Estimated CCU (Concurrent Users) Impact');
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` ALTER COLUMN `feature_code` SET TAGS ('dbx_business_glossary_term' = 'Cross-Play Feature Code');
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` ALTER COLUMN `feature_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` ALTER COLUMN `feature_name` SET TAGS ('dbx_business_glossary_term' = 'Cross-Play Feature Name');
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` ALTER COLUMN `feature_status` SET TAGS ('dbx_business_glossary_term' = 'Cross-Play Feature Status');
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` ALTER COLUMN `feature_status` SET TAGS ('dbx_value_regex' = 'planned|in_development|certification_pending|active|deprecated');
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` ALTER COLUMN `feature_type` SET TAGS ('dbx_business_glossary_term' = 'Cross-Platform Feature Type');
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` ALTER COLUMN `feature_type` SET TAGS ('dbx_value_regex' = 'cross-play|cross-save|cross-progression|cross-purchase');
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` ALTER COLUMN `fps_parity_enforced` SET TAGS ('dbx_business_glossary_term' = 'FPS (Frames Per Second) Parity Enforced Flag');
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` ALTER COLUMN `friend_list_integration` SET TAGS ('dbx_business_glossary_term' = 'Friend List Integration Type');
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` ALTER COLUMN `friend_list_integration` SET TAGS ('dbx_value_regex' = 'none|platform_native|unified_social_graph|hybrid');
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` ALTER COLUMN `input_method_balancing_enabled` SET TAGS ('dbx_business_glossary_term' = 'Input Method Balancing Enabled Flag');
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Cross-Play Feature Launch Date');
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` ALTER COLUMN `matchmaking_pool_unified` SET TAGS ('dbx_business_glossary_term' = 'Unified Matchmaking Pool Flag');
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Cross-Play Feature Notes');
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` ALTER COLUMN `party_system_supported` SET TAGS ('dbx_business_glossary_term' = 'Cross-Platform Party System Supported Flag');
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` ALTER COLUMN `platform_holder_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Platform Holder Approval Status');
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` ALTER COLUMN `platform_holder_approval_status` SET TAGS ('dbx_value_regex' = 'not_submitted|submitted|under_review|approved|rejected|conditional_approval');
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` ALTER COLUMN `platform_icon_display_enabled` SET TAGS ('dbx_business_glossary_term' = 'Platform Icon Display Enabled Flag');
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` ALTER COLUMN `platform_revenue_share_agreement` SET TAGS ('dbx_business_glossary_term' = 'Platform Revenue Share Agreement');
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` ALTER COLUMN `platform_revenue_share_agreement` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` ALTER COLUMN `player_adoption_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Player Adoption Rate Percentage');
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` ALTER COLUMN `player_consent_required` SET TAGS ('dbx_business_glossary_term' = 'Player Consent Required Flag');
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` ALTER COLUMN `player_opt_in_policy` SET TAGS ('dbx_business_glossary_term' = 'Player Opt-In Policy');
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` ALTER COLUMN `player_opt_in_policy` SET TAGS ('dbx_value_regex' = 'mandatory|opt_in_default|opt_out_default|player_choice');
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` ALTER COLUMN `relay_server_region` SET TAGS ('dbx_business_glossary_term' = 'Relay Server Region');
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` ALTER COLUMN `supported_platform_combination` SET TAGS ('dbx_business_glossary_term' = 'Supported Platform Combination');
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` ALTER COLUMN `technical_implementation_approach` SET TAGS ('dbx_business_glossary_term' = 'Technical Implementation Approach');
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` ALTER COLUMN `technical_implementation_approach` SET TAGS ('dbx_value_regex' = 'relay_server|peer_to_peer|hybrid|cloud_sync|platform_api');
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` ALTER COLUMN `text_chat_supported` SET TAGS ('dbx_business_glossary_term' = 'Cross-Platform Text Chat Supported Flag');
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` ALTER COLUMN `voice_chat_supported` SET TAGS ('dbx_business_glossary_term' = 'Cross-Platform Voice Chat Supported Flag');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` SET TAGS ('dbx_subdomain' = 'distribution_commerce');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `storefront_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Listing ID');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `age_rating_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Age Rating Cert Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `aso_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Aso Listing Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `compatibility_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Compatibility Profile Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Icon Asset Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `loot_box_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Loot Box Disclosure Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `marketing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `platform_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Stock Keeping Unit (SKU) ID');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront ID');
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
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `privacy_policy_url` SET TAGS ('dbx_business_glossary_term' = 'Privacy Policy URL');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `published_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Published Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `publisher_name` SET TAGS ('dbx_business_glossary_term' = 'Publisher Name');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `review_count` SET TAGS ('dbx_business_glossary_term' = 'Review Count');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `screenshot_asset_references` SET TAGS ('dbx_business_glossary_term' = 'Screenshot Asset References');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `secondary_category` SET TAGS ('dbx_business_glossary_term' = 'Secondary Category');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `short_description` SET TAGS ('dbx_business_glossary_term' = 'Short Description');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `support_url` SET TAGS ('dbx_business_glossary_term' = 'Support URL');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `supported_languages` SET TAGS ('dbx_business_glossary_term' = 'Supported Languages');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `supported_platforms` SET TAGS ('dbx_business_glossary_term' = 'Supported Platforms');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `terms_of_service_url` SET TAGS ('dbx_business_glossary_term' = 'Terms of Service URL');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `trailer_asset_references` SET TAGS ('dbx_business_glossary_term' = 'Trailer Asset References');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` SET TAGS ('dbx_subdomain' = 'distribution_commerce');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `pricing_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing ID');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `deferred_revenue_id` SET TAGS ('dbx_business_glossary_term' = 'Deferred Revenue Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `marketing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `platform_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `platform_sku_id` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._-]{1,100}$');
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
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `regional_pricing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Regional Pricing Strategy');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `regional_pricing_strategy` SET TAGS ('dbx_value_regex' = 'standard|purchasing_power_parity|competitive|premium|budget');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `sku` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,50}$');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `tax_handling_method` SET TAGS ('dbx_business_glossary_term' = 'Tax Handling Method');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `tax_handling_method` SET TAGS ('dbx_value_regex' = 'inclusive|exclusive|exempt');
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ALTER COLUMN `tax_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Percentage');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` SET TAGS ('dbx_subdomain' = 'entitlement_integration');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `patch_release_id` SET TAGS ('dbx_business_glossary_term' = 'Patch Release ID');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `age_rating_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Age Rating Cert Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `build_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Base Build Submission Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `build_artifact_id` SET TAGS ('dbx_business_glossary_term' = 'Build Artifact Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Project Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `infrastructure_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Infrastructure Deployment Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `asset_bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Patch Asset Bundle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `release_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Release Schedule Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `server_fleet_id` SET TAGS ('dbx_business_glossary_term' = 'Server Fleet Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `age_rating_impact` SET TAGS ('dbx_business_glossary_term' = 'Age Rating Impact');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `age_rating_impact` SET TAGS ('dbx_value_regex' = 'none|content_descriptor_added|rating_change_required');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `anti_cheat_version` SET TAGS ('dbx_business_glossary_term' = 'Anti-Cheat System Version');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `build_number` SET TAGS ('dbx_business_glossary_term' = 'Build Number');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `cdn_distribution_url` SET TAGS ('dbx_business_glossary_term' = 'CDN (Content Delivery Network) Distribution URL');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `cdn_distribution_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Platform Certification Date');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Platform Certification Status');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'not_submitted|pending|in_review|approved|rejected|conditional_approval');
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
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `sdk_version` SET TAGS ('dbx_business_glossary_term' = 'SDK (Software Development Kit) Version');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Platform Submission Date');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `trc_checklist_version` SET TAGS ('dbx_business_glossary_term' = 'TRC (Technical Requirements Checklist) Version');
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` SET TAGS ('dbx_subdomain' = 'entitlement_integration');
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ALTER COLUMN `compatibility_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Compatibility Profile ID');
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ALTER COLUMN `certification_checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Checklist Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ALTER COLUMN `middleware_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Middleware Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ALTER COLUMN `api_version` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Version');
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ALTER COLUMN `ar_support_flag` SET TAGS ('dbx_business_glossary_term' = 'Augmented Reality (AR) Support Flag');
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Platform Certification Date');
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Platform Certification Status');
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|in_review|certified|rejected|expired');
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ALTER COLUMN `colorblind_mode_flag` SET TAGS ('dbx_business_glossary_term' = 'Colorblind Mode Support Flag');
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ALTER COLUMN `controller_support_types` SET TAGS ('dbx_business_glossary_term' = 'Controller Support Types');
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ALTER COLUMN `cross_platform_play_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Platform Play Support Flag');
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ALTER COLUMN `cross_save_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Save Support Flag');
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ALTER COLUMN `drm_system` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) System');
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ALTER COLUMN `end_of_support_date` SET TAGS ('dbx_business_glossary_term' = 'End of Support Date');
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ALTER COLUMN `hdr_support_flag` SET TAGS ('dbx_business_glossary_term' = 'High Dynamic Range (HDR) Support Flag');
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ALTER COLUMN `local_multiplayer_flag` SET TAGS ('dbx_business_glossary_term' = 'Local Multiplayer Support Flag');
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ALTER COLUMN `max_concurrent_players` SET TAGS ('dbx_business_glossary_term' = 'Maximum Concurrent Players (CCU)');
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ALTER COLUMN `min_cpu_spec` SET TAGS ('dbx_business_glossary_term' = 'Minimum Central Processing Unit (CPU) Specification');
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ALTER COLUMN `min_gpu_spec` SET TAGS ('dbx_business_glossary_term' = 'Minimum Graphics Processing Unit (GPU) Specification');
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ALTER COLUMN `min_ram_gb` SET TAGS ('dbx_business_glossary_term' = 'Minimum Random Access Memory (RAM) in Gigabytes (GB)');
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ALTER COLUMN `min_storage_gb` SET TAGS ('dbx_business_glossary_term' = 'Minimum Storage in Gigabytes (GB)');
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ALTER COLUMN `online_multiplayer_flag` SET TAGS ('dbx_business_glossary_term' = 'Online Multiplayer Support Flag');
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ALTER COLUMN `performance_notes` SET TAGS ('dbx_business_glossary_term' = 'Performance Notes');
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ALTER COLUMN `profile_code` SET TAGS ('dbx_business_glossary_term' = 'Compatibility Profile Code');
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ALTER COLUMN `profile_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,20}$');
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ALTER COLUMN `profile_name` SET TAGS ('dbx_business_glossary_term' = 'Compatibility Profile Name');
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ALTER COLUMN `profile_version` SET TAGS ('dbx_business_glossary_term' = 'Profile Version');
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ALTER COLUMN `profile_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+.[0-9]+$');
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ALTER COLUMN `ray_tracing_support_flag` SET TAGS ('dbx_business_glossary_term' = 'Ray Tracing Support Flag');
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ALTER COLUMN `recommended_cpu_spec` SET TAGS ('dbx_business_glossary_term' = 'Recommended Central Processing Unit (CPU) Specification');
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ALTER COLUMN `recommended_gpu_spec` SET TAGS ('dbx_business_glossary_term' = 'Recommended Graphics Processing Unit (GPU) Specification');
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ALTER COLUMN `recommended_ram_gb` SET TAGS ('dbx_business_glossary_term' = 'Recommended Random Access Memory (RAM) in Gigabytes (GB)');
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ALTER COLUMN `recommended_storage_gb` SET TAGS ('dbx_business_glossary_term' = 'Recommended Storage in Gigabytes (GB)');
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ALTER COLUMN `remappable_controls_flag` SET TAGS ('dbx_business_glossary_term' = 'Remappable Controls Support Flag');
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ALTER COLUMN `sdk_version` SET TAGS ('dbx_business_glossary_term' = 'Software Development Kit (SDK) Version');
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ALTER COLUMN `sdk_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+.[0-9]+$');
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ALTER COLUMN `subtitle_support_flag` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Support Flag');
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ALTER COLUMN `supported_os_versions` SET TAGS ('dbx_business_glossary_term' = 'Supported Operating System (OS) Versions');
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ALTER COLUMN `supported_resolutions` SET TAGS ('dbx_business_glossary_term' = 'Supported Display Resolutions');
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ALTER COLUMN `target_frame_rates` SET TAGS ('dbx_business_glossary_term' = 'Target Frame Rates (FPS)');
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ALTER COLUMN `text_to_speech_flag` SET TAGS ('dbx_business_glossary_term' = 'Text-to-Speech Support Flag');
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ALTER COLUMN `vr_support_flag` SET TAGS ('dbx_business_glossary_term' = 'Virtual Reality (VR) Support Flag');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` SET TAGS ('dbx_subdomain' = 'entitlement_integration');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `developer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Developer Account ID');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `licensee_id` SET TAGS ('dbx_business_glossary_term' = 'Licensee Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Holder ID');
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ALTER COLUMN `third_party_processor_id` SET TAGS ('dbx_business_glossary_term' = 'Third Party Processor Id (Foreign Key)');
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
ALTER TABLE `gaming_ecm`.`platform`.`storefront_campaign` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_campaign` SET TAGS ('dbx_subdomain' = 'distribution_commerce');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_campaign` SET TAGS ('dbx_association_edges' = 'platform.storefront,marketing.campaign');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_campaign` ALTER COLUMN `storefront_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Campaign Placement ID');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_campaign` ALTER COLUMN `marketing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Campaign - Campaign Id');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_campaign` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Campaign - Storefront Id');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_campaign` ALTER COLUMN `attribution_link_override` SET TAGS ('dbx_business_glossary_term' = 'Storefront-Specific Attribution Link');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_campaign` ALTER COLUMN `budget_allocated` SET TAGS ('dbx_business_glossary_term' = 'Storefront-Specific Campaign Budget');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_campaign` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_campaign` ALTER COLUMN `co_marketing_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Platform Holder Co-Marketing Agreement');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_campaign` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_campaign` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign End Date on Storefront');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_campaign` ALTER COLUMN `featured_placement_secured` SET TAGS ('dbx_business_glossary_term' = 'Featured Placement Secured');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_campaign` ALTER COLUMN `placement_status` SET TAGS ('dbx_business_glossary_term' = 'Placement Status');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_campaign` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign Start Date on Storefront');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_campaign` ALTER COLUMN `storefront_specific_creative_url` SET TAGS ('dbx_business_glossary_term' = 'Storefront-Specific Creative Asset URL');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_campaign` ALTER COLUMN `targeting_rules` SET TAGS ('dbx_business_glossary_term' = 'Storefront-Specific Targeting Rules');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_campaign` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`creative_listing_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `gaming_ecm`.`platform`.`creative_listing_assignment` SET TAGS ('dbx_subdomain' = 'distribution_commerce');
ALTER TABLE `gaming_ecm`.`platform`.`creative_listing_assignment` SET TAGS ('dbx_association_edges' = 'platform.storefront_listing,marketing.ad_creative');
ALTER TABLE `gaming_ecm`.`platform`.`creative_listing_assignment` ALTER COLUMN `creative_listing_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Listing Assignment ID');
ALTER TABLE `gaming_ecm`.`platform`.`creative_listing_assignment` ALTER COLUMN `ad_creative_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Listing Assignment - Ad Creative Id');
ALTER TABLE `gaming_ecm`.`platform`.`creative_listing_assignment` ALTER COLUMN `storefront_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Listing Assignment - Storefront Listing Id');
ALTER TABLE `gaming_ecm`.`platform`.`creative_listing_assignment` ALTER COLUMN `ab_test_group` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Group');
ALTER TABLE `gaming_ecm`.`platform`.`creative_listing_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `gaming_ecm`.`platform`.`creative_listing_assignment` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `gaming_ecm`.`platform`.`creative_listing_assignment` ALTER COLUMN `creative_listing_variant` SET TAGS ('dbx_business_glossary_term' = 'Creative Listing Variant');
ALTER TABLE `gaming_ecm`.`platform`.`creative_listing_assignment` ALTER COLUMN `impression_to_listing_view_rate` SET TAGS ('dbx_business_glossary_term' = 'Impression to Listing View Rate');
ALTER TABLE `gaming_ecm`.`platform`.`creative_listing_assignment` ALTER COLUMN `listing_view_to_install_rate` SET TAGS ('dbx_business_glossary_term' = 'Listing View to Install Rate');
ALTER TABLE `gaming_ecm`.`platform`.`creative_listing_assignment` ALTER COLUMN `test_end_date` SET TAGS ('dbx_business_glossary_term' = 'Test End Date');
ALTER TABLE `gaming_ecm`.`platform`.`creative_listing_assignment` ALTER COLUMN `test_start_date` SET TAGS ('dbx_business_glossary_term' = 'Test Start Date');
ALTER TABLE `gaming_ecm`.`platform`.`creative_listing_assignment` ALTER COLUMN `total_impressions` SET TAGS ('dbx_business_glossary_term' = 'Total Impressions');
ALTER TABLE `gaming_ecm`.`platform`.`creative_listing_assignment` ALTER COLUMN `total_installs` SET TAGS ('dbx_business_glossary_term' = 'Total Installs');
ALTER TABLE `gaming_ecm`.`platform`.`creative_listing_assignment` ALTER COLUMN `total_listing_views` SET TAGS ('dbx_business_glossary_term' = 'Total Listing Views');
ALTER TABLE `gaming_ecm`.`platform`.`creative_listing_assignment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_release` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_release` SET TAGS ('dbx_subdomain' = 'distribution_commerce');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_release` SET TAGS ('dbx_association_edges' = 'studio.dev_project,platform.storefront');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_release` ALTER COLUMN `storefront_release_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Release Identifier');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_release` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Release - Dev Project Id');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_release` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Release - Storefront Id');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_release` ALTER COLUMN `age_rating` SET TAGS ('dbx_business_glossary_term' = 'Age Rating');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_release` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_release` ALTER COLUMN `base_price_usd` SET TAGS ('dbx_business_glossary_term' = 'Base Price USD');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_release` ALTER COLUMN `build_version` SET TAGS ('dbx_business_glossary_term' = 'Build Version');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_release` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_release` ALTER COLUMN `created_at` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_release` ALTER COLUMN `delisting_date` SET TAGS ('dbx_business_glossary_term' = 'Delisting Date');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_release` ALTER COLUMN `listing_url` SET TAGS ('dbx_business_glossary_term' = 'Listing URL');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_release` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_business_glossary_term' = 'Pricing Tier');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_release` ALTER COLUMN `regional_availability` SET TAGS ('dbx_business_glossary_term' = 'Regional Availability');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_release` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_release` ALTER COLUMN `revenue_share_override_pct` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Override Percentage');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_release` ALTER COLUMN `storefront_listing_status` SET TAGS ('dbx_business_glossary_term' = 'Storefront Listing Status');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_release` ALTER COLUMN `storefront_sku` SET TAGS ('dbx_business_glossary_term' = 'Storefront SKU');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_release` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_release` ALTER COLUMN `supports_achievements` SET TAGS ('dbx_business_glossary_term' = 'Supports Achievements');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_release` ALTER COLUMN `supports_cloud_saves` SET TAGS ('dbx_business_glossary_term' = 'Supports Cloud Saves');
ALTER TABLE `gaming_ecm`.`platform`.`storefront_release` ALTER COLUMN `updated_at` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`developer_compliance` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `gaming_ecm`.`platform`.`developer_compliance` SET TAGS ('dbx_subdomain' = 'certification_compliance');
ALTER TABLE `gaming_ecm`.`platform`.`developer_compliance` SET TAGS ('dbx_association_edges' = 'platform.developer_account,compliance.regulatory_obligation');
ALTER TABLE `gaming_ecm`.`platform`.`developer_compliance` ALTER COLUMN `developer_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Developer Compliance Record Identifier');
ALTER TABLE `gaming_ecm`.`platform`.`developer_compliance` ALTER COLUMN `developer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Developer Compliance - Developer Account Id');
ALTER TABLE `gaming_ecm`.`platform`.`developer_compliance` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Developer Compliance - Regulatory Obligation Id');
ALTER TABLE `gaming_ecm`.`platform`.`developer_compliance` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Date');
ALTER TABLE `gaming_ecm`.`platform`.`developer_compliance` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Date');
ALTER TABLE `gaming_ecm`.`platform`.`developer_compliance` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `gaming_ecm`.`platform`.`developer_compliance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`developer_compliance` ALTER COLUMN `evidence_document_url` SET TAGS ('dbx_business_glossary_term' = 'Compliance Evidence Document URL');
ALTER TABLE `gaming_ecm`.`platform`.`developer_compliance` ALTER COLUMN `exemption_reason` SET TAGS ('dbx_business_glossary_term' = 'Compliance Exemption Reason');
ALTER TABLE `gaming_ecm`.`platform`.`developer_compliance` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `gaming_ecm`.`platform`.`developer_compliance` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Compliance Review Date');
ALTER TABLE `gaming_ecm`.`platform`.`developer_compliance` ALTER COLUMN `remediation_plan` SET TAGS ('dbx_business_glossary_term' = 'Compliance Remediation Plan');
ALTER TABLE `gaming_ecm`.`platform`.`developer_compliance` ALTER COLUMN `responsible_contact` SET TAGS ('dbx_business_glossary_term' = 'Compliance Responsible Contact');
ALTER TABLE `gaming_ecm`.`platform`.`certification_certificate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`platform`.`certification_certificate` SET TAGS ('dbx_subdomain' = 'certification_compliance');
ALTER TABLE `gaming_ecm`.`platform`.`certification_certificate` ALTER COLUMN `certification_certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Certificate Identifier');
ALTER TABLE `gaming_ecm`.`platform`.`certification_certificate` ALTER COLUMN `renewed_certification_certificate_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`certification_certificate` ALTER COLUMN `certificate_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`certification_certificate` ALTER COLUMN `certification_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`certification_certificate` ALTER COLUMN `internal_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`certification_certificate` ALTER COLUMN `issuing_authority_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`certification_certificate` ALTER COLUMN `reviewer_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`certification_certificate` ALTER COLUMN `reviewer_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`certification_certificate` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_rule` SET TAGS ('dbx_subdomain' = 'entitlement_integration');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_rule` ALTER COLUMN `entitlement_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Rule Identifier');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_rule` ALTER COLUMN `parent_entitlement_rule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_rule` ALTER COLUMN `internal_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`platform_holder` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`platform`.`platform_holder` SET TAGS ('dbx_subdomain' = 'entitlement_integration');
ALTER TABLE `gaming_ecm`.`platform`.`platform_holder` ALTER COLUMN `platform_holder_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Holder Identifier');
ALTER TABLE `gaming_ecm`.`platform`.`platform_holder` ALTER COLUMN `parent_platform_holder_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`platform_holder` ALTER COLUMN `business_development_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`platform_holder` ALTER COLUMN `business_development_contact` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`platform_holder` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`platform_holder` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`platform_holder` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`platform_holder` ALTER COLUMN `technical_support_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`platform`.`platform_holder` ALTER COLUMN `technical_support_contact` SET TAGS ('dbx_pii_email' = 'true');
