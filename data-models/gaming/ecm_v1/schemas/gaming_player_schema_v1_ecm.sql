-- Schema for Domain: player | Business: Gaming | Version: v1_ecm
-- Generated on: 2026-05-08 06:58:04

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `gaming_ecm`.`player` COMMENT 'Single source of truth for all player identity, profiles, accounts, authentication, preferences, and segmentation across console, PC, and mobile platforms. Owns player registration, parental controls, COPPA/GDPR consent records, player demographics, behavior patterns, engagement metrics (DAU, MAU, WAU, retention), LTV calculations, and player lifecycle management. The authoritative domain for WHO the business serves.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `gaming_ecm`.`player`.`player_account` (
    `player_account_id` BIGINT COMMENT 'Unique identifier for the player account. Primary key for the player_account entity. This is the root identity to which all other player domain entities relate.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Gaming studios require employees (QA, designers, developers) to maintain test accounts for playtesting, bug reproduction, and compliance verification. Tracking which employee owns each test account is',
    `account_level` STRING COMMENT 'Players overall account progression level, earned through gameplay achievements and experience points. Used for matchmaking, content gating, and progression analytics.',
    `account_status` STRING COMMENT 'Current lifecycle status of the player account. Active accounts have full access; suspended accounts have temporary restrictions; banned accounts are permanently blocked; deactivated accounts are player-initiated closures; pending_verification accounts await email confirmation; locked accounts require password reset.. Valid values are `active|suspended|banned|deactivated|pending_verification|locked`',
    `account_tier` STRING COMMENT 'Subscription or membership tier of the player account. Determines access to premium features, exclusive content, and priority support. Founder tier for early supporters; developer tier for internal testing accounts.. Valid values are `free|premium|vip|founder|developer`',
    `age_verified_flag` BOOLEAN COMMENT 'Indicates whether the players age has been verified through a trusted mechanism (ID verification, credit card validation, or parental consent for minors). Required for access to age-restricted content and features.',
    `avatar_url` STRING COMMENT 'URL pointing to the players profile avatar image stored in the CDN (Content Delivery Network). Used for display in social features, leaderboards, and player profiles.',
    `bio` STRING COMMENT 'Player-written biography or description displayed on their public profile. Limited to 500 characters. Subject to content moderation policies.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the players country of residence. Used for regional content delivery, compliance with local regulations (GDPR, COPPA, PEGI, ESRB), and geo-specific monetization strategies.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this player_account record was first created in the data warehouse. Used for audit trails and data lineage tracking.',
    `creation_source` STRING COMMENT 'Marketing attribution source indicating how the player discovered and registered for the game. Used for CPI (Cost Per Install), ROAS (Return on Ad Spend), and marketing campaign effectiveness analysis. [ENUM-REF-CANDIDATE: organic|paid_social|influencer|referral|cross_promotion|app_store|web_direct — 7 candidates stripped; promote to reference product]',
    `data_processing_consent_flag` BOOLEAN COMMENT 'Indicates whether the player has provided explicit consent for data processing activities beyond essential service delivery (analytics, personalization, third-party sharing). Required for GDPR compliance.',
    `data_processing_consent_timestamp` TIMESTAMP COMMENT 'Date and time when the player provided data processing consent. Required for GDPR audit trails demonstrating lawful basis for processing.',
    `date_of_birth` DATE COMMENT 'Players date of birth. Required for age verification, COPPA compliance (children under 13), GDPR consent requirements, and age-gated content access (ESRB, PEGI ratings).',
    `display_name` STRING COMMENT 'Public-facing display name shown to other players in-game and in social features. May differ from username and can be changed by the player.',
    `email_address` STRING COMMENT 'Primary email address used for account registration, authentication, password recovery, and marketing communications. Must be unique and verified.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `email_verified_flag` BOOLEAN COMMENT 'Indicates whether the player has verified their email address through the verification link sent during registration.',
    `experience_points` BIGINT COMMENT 'Total experience points (XP) accumulated by the player through gameplay activities. Used to calculate account level progression and unlock rewards.',
    `failed_login_attempts` STRING COMMENT 'Count of consecutive failed login attempts since the last successful login. Used for account lockout policies and fraud detection. Reset to zero upon successful authentication.',
    `gdpr_right_to_erasure_requested_flag` BOOLEAN COMMENT 'Indicates whether the player has submitted a GDPR Article 17 Right to Erasure (Right to be Forgotten) request. Triggers data deletion workflows while preserving legally required records.',
    `gender_identity` STRING COMMENT 'Self-reported gender identity of the player. Optional field used for demographic analytics and personalized content recommendations. Collected with explicit consent per GDPR and privacy regulations.. Valid values are `male|female|non_binary|prefer_not_to_say|other`',
    `last_login_timestamp` TIMESTAMP COMMENT 'Date and time of the players most recent successful login. Used for DAU (Daily Active Users), MAU (Monthly Active Users), WAU (Weekly Active Users) calculations, churn prediction, and re-engagement campaigns.',
    `last_profile_update_timestamp` TIMESTAMP COMMENT 'Date and time when the player last modified their profile information (display name, avatar, bio, or privacy settings). Used for audit trails and profile activity tracking.',
    `locale` STRING COMMENT 'Locale identifier combining language and region (e.g., en_US, fr_FR, ja_JP). Used for region-specific formatting of dates, numbers, currency, and culturally appropriate content.. Valid values are `^[a-z]{2}_[A-Z]{2}$`',
    `marketing_opt_in_flag` BOOLEAN COMMENT 'Indicates whether the player has consented to receive marketing communications (newsletters, promotional offers, game updates). Required for GDPR and CAN-SPAM compliance.',
    `parental_consent_flag` BOOLEAN COMMENT 'Indicates whether verifiable parental consent has been obtained for players under the age of 13 (COPPA) or under 16 (GDPR Article 8). Required for data collection and processing of minors.',
    `password_last_changed_timestamp` TIMESTAMP COMMENT 'Date and time when the player last changed their account password. Used for security audits, password expiration policies, and breach response.',
    `platform_of_origin` STRING COMMENT 'The platform through which the player originally registered their account. Used for platform-specific analytics, cross-platform progression tracking, and attribution analysis. [ENUM-REF-CANDIDATE: steam|psn|xbox_live|nintendo_switch|epic_games|mobile_ios|mobile_android|web — 8 candidates stripped; promote to reference product]',
    `preferred_language` STRING COMMENT 'Two-letter ISO 639-1 language code representing the players preferred language for UI, communications, and in-game content. Used for localization and content delivery.. Valid values are `^[a-z]{2}$`',
    `profile_visibility` STRING COMMENT 'Privacy setting controlling who can view the players profile information. Public profiles are visible to all; friends_only profiles are visible to approved connections; private profiles are visible only to the player.. Valid values are `public|friends_only|private`',
    `referral_code` STRING COMMENT 'Unique referral code used by the player during registration, linking them to the referring player for viral growth tracking and K-Factor (Viral Coefficient) calculation.',
    `registration_timestamp` TIMESTAMP COMMENT 'Date and time when the player account was first created in the system. Used for cohort analysis, retention calculations, and LTV (Lifetime Value) modeling.',
    `reputation_score` STRING COMMENT 'Community reputation score based on player behavior, reports, commendations, and moderation actions. Used for matchmaking, trust scoring, and identifying toxic players. Negative scores indicate poor behavior.',
    `suspension_expiry_timestamp` TIMESTAMP COMMENT 'Date and time when a temporary account suspension will automatically expire and the account will be reactivated. Null for permanent bans.',
    `suspension_reason` STRING COMMENT 'Detailed reason for account suspension or ban, referencing specific Terms of Service or Community Standards violations. Used for player communication, appeals processing, and moderation analytics.',
    `suspension_timestamp` TIMESTAMP COMMENT 'Date and time when the account was suspended or banned. Used for suspension duration tracking and appeals processing.',
    `timezone` STRING COMMENT 'IANA timezone identifier (e.g., America/New_York, Europe/London, Asia/Tokyo) representing the players local timezone. Used for scheduling live events, daily login rewards, and time-based game mechanics.',
    `total_playtime_minutes` BIGINT COMMENT 'Cumulative total playtime across all sessions since account creation, measured in minutes. Used for engagement analysis, LTV (Lifetime Value) modeling, and player segmentation.',
    `two_factor_auth_enabled_flag` BOOLEAN COMMENT 'Indicates whether the player has enabled two-factor authentication (2FA) for enhanced account security. Recommended for high-value accounts and required for certain privileged operations.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this player_account record was last modified in the data warehouse. Used for change tracking and incremental ETL (Extract, Transform, Load) processing.',
    `username` STRING COMMENT 'Unique username chosen by the player during registration. Used for login and public identification across platforms. Must be unique system-wide.. Valid values are `^[a-zA-Z0-9_-]{3,20}$`',
    CONSTRAINT pk_player_account PRIMARY KEY(`player_account_id`)
) COMMENT 'Master identity record and single source of truth for every registered player across all platforms (console, PC, mobile). Stores the canonical player_id, username, display name, avatar, bio, preferred language, locale, timezone, account status (active, suspended, banned, deactivated), account tier, registration timestamp, platform of origin, country of residence, age-verified flag, date of birth, gender identity (self-reported), profile visibility settings, account creation source, and last profile update timestamp. This is the root entity to which all other player domain entities relate via FK. Encompasses both the authentication/identity layer and the player-facing social/demographic profile layer as a single unified entity — industry standard in gaming platforms (PlayFab, AccelByte, GameSparks). Supports GDPR right-to-erasure workflows. Sourced from platform SDK registration flows (Steamworks, PSN, Xbox Live, Nintendo) and Salesforce CRM.';

CREATE OR REPLACE TABLE `gaming_ecm`.`player`.`profile` (
    `profile_id` BIGINT COMMENT 'Unique identifier for the player profile. Primary key. Distinct from account_id (authentication layer) — this is the social and demographic identity layer.',
    `player_account_id` BIGINT COMMENT 'Foreign key reference to the player account (authentication/identity layer). Links this profile to the underlying authentication record.',
    `accessibility_settings` STRING COMMENT 'JSON or delimited string capturing players accessibility preferences (e.g., colorblind mode, subtitle size, controller remapping, audio cues). Used to personalize game experience for players with disabilities.',
    `avatar_url` STRING COMMENT 'URL to the players profile avatar image stored in CDN (Content Delivery Network). Used for visual identity across platforms.',
    `bio` STRING COMMENT 'Player-authored biography or profile description. Free-text field subject to content moderation. May be displayed on public profiles.',
    `communication_language` STRING COMMENT 'Two-letter ISO 639-1 language code for player support and marketing communications. May differ from preferred_language (UI language). Used for customer service routing and localized campaigns.. Valid values are `^[a-z]{2}$`',
    `content_rating_preference` STRING COMMENT 'Players preferred ESRB (Entertainment Software Rating Board) content rating level for game recommendations and parental controls. Values: E (Everyone), E10 (Everyone 10+), T (Teen), M (Mature 17+), AO (Adults Only 18+).. Valid values are `E|E10|T|M|AO`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the player profile was first created. Used for player tenure analysis, cohort segmentation, and lifecycle tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `email_verified` BOOLEAN COMMENT 'Boolean flag indicating whether the players email address has been verified through a confirmation link or code. Required for account recovery and secure communications.',
    `external_profile_code` STRING COMMENT 'Unique identifier from the source system (e.g., Salesforce Contact ID, Steam ID, Epic Account ID). Used for cross-system reconciliation and data lineage tracking.',
    `gdpr_erasure_completed_timestamp` TIMESTAMP COMMENT 'Timestamp when GDPR erasure request was completed and PII (Personally Identifiable Information) was anonymized or deleted. Null if no erasure has been performed. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `gdpr_erasure_requested` BOOLEAN COMMENT 'Boolean flag indicating whether the player has requested data erasure under GDPR Article 17 (Right to Erasure). Triggers anonymization workflow and profile soft-deletion.',
    `locale` STRING COMMENT 'Locale identifier combining language and region (e.g., en_US, es_MX, fr_FR, de_DE, ja_JP). Used for localization of content, currency, and regional settings.. Valid values are `^[a-z]{2}_[A-Z]{2}$`',
    `parental_consent_verified` BOOLEAN COMMENT 'Boolean flag indicating whether verifiable parental consent has been obtained for players under 13 (COPPA) or under 16 (GDPR Article 8). Required for minors to access online features.',
    `phone_verified` BOOLEAN COMMENT 'Boolean flag indicating whether the players phone number has been verified through SMS or voice call. Used for two-factor authentication (2FA) and account security.',
    `platform_preference` STRING COMMENT 'Players preferred gaming platform. Used for personalized content recommendations, platform-specific events, and cross-platform analytics. Values: console, pc, mobile, vr (Virtual Reality), cross_platform.. Valid values are `console|pc|mobile|vr|cross_platform`',
    `player_segment` STRING COMMENT 'Marketing or behavioral segment assigned to this player (e.g., whale, casual, hardcore, lapsed, at_risk_churn). Used for targeted campaigns, personalized offers, and retention strategies. [ENUM-REF-CANDIDATE: whale|casual|hardcore|lapsed|at_risk_churn|new_player|returning_player — promote to reference product]',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the players location. Used for regional analytics, tax compliance, and geo-targeted marketing. May be required for payment processing.',
    `preferred_language` STRING COMMENT 'Two-letter ISO 639-1 language code representing the players preferred language for UI (User Interface) and communications (e.g., en, es, fr, de, ja, zh).. Valid values are `^[a-z]{2}$`',
    `profile_status` STRING COMMENT 'Current lifecycle status of the player profile. Values: active (normal operation), suspended (temporary restriction), banned (permanent restriction), deleted (soft-deleted per GDPR right-to-erasure), pending_verification (awaiting age/identity verification).. Valid values are `active|suspended|banned|deleted|pending_verification`',
    `referral_code` STRING COMMENT 'Unique referral code assigned to this player for viral marketing and K-Factor (Viral Coefficient) tracking. Used when this player refers new players to earn rewards.',
    `referred_by_code` STRING COMMENT 'Referral code of the player who referred this player. Used for attribution tracking, referral reward distribution, and viral growth analysis.',
    `region` STRING COMMENT 'Sub-national region, state, or province (e.g., California, Ontario, Bavaria). Used for regional analytics, localized events, and compliance with regional regulations.',
    `source_system` STRING COMMENT 'Operational system of record that originated this profile record. Values: salesforce_crm (Salesforce CRM Contact object), unity_player_services, epic_games_services, steam, console_sdk, mobile_sdk. Used for data lineage and reconciliation.. Valid values are `salesforce_crm|unity_player_services|epic_games_services|steam|console_sdk|mobile_sdk`',
    `timezone` STRING COMMENT 'IANA timezone identifier (e.g., America/New_York, Europe/London, Asia/Tokyo). Used for scheduling live events, daily rewards, and time-based features.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent profile update (any field change). Used for tracking profile activity and data freshness. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `vip_tier` STRING COMMENT 'Players VIP tier based on spending, engagement, or loyalty. Used for tiered rewards, exclusive content access, and premium support. Values: none, bronze, silver, gold, platinum, diamond.. Valid values are `none|bronze|silver|gold|platinum|diamond`',
    CONSTRAINT pk_profile PRIMARY KEY(`profile_id`)
) COMMENT 'Player-facing identity and demographic profile record linked to an account. Stores display name, avatar URL, bio, preferred language, locale, timezone, date of birth, gender identity (self-reported), country, region, profile visibility settings, and last profile update timestamp. Distinct from the account (authentication/identity) — the profile is the social and demographic layer. Supports GDPR right-to-erasure workflows by tracking consent-linked profile fields. Sourced from Salesforce CRM Contact object.';

CREATE OR REPLACE TABLE `gaming_ecm`.`player`.`platform_identity` (
    `platform_identity_id` BIGINT COMMENT 'Unique identifier for the platform identity linkage record. Primary key.',
    `player_account_id` BIGINT COMMENT 'Reference to the internal player account that owns this platform identity linkage. Links to the authoritative player account record in the Player domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this platform identity linkage record was first created in the system. Audit field for data lineage and compliance.',
    `cross_platform_play_enabled_flag` BOOLEAN COMMENT 'Boolean indicator of whether the player has opted in to cross-platform play (crossplay) using this platform identity. True indicates the player allows matchmaking and interaction with players on other platforms; false indicates platform-exclusive play only.',
    `external_platform_user_code` STRING COMMENT 'The unique user identifier assigned by the external platform (e.g., PSN ID, Xbox Gamertag, Steam ID, Epic Account ID). This is the authoritative identifier used by the platform provider to identify the player on their ecosystem.',
    `fraud_risk_score` DECIMAL(18,2) COMMENT 'A calculated risk score (0.00 to 100.00) indicating the likelihood that this platform identity linkage is fraudulent or suspicious. Higher scores indicate higher risk. Derived from fraud detection algorithms analyzing linkage patterns, device fingerprints, and platform reputation signals.',
    `last_activity_timestamp` TIMESTAMP COMMENT 'The date and time when the player last used this platform identity to authenticate or play. Used for identity staleness detection and account security monitoring.',
    `last_verified_timestamp` TIMESTAMP COMMENT 'The date and time when the platform identity linkage was most recently verified or re-authenticated. Used to track OAuth token refresh cycles and ensure the link remains valid.',
    `link_device_type` STRING COMMENT 'The type of device from which the platform identity linkage was performed. Used for device-based analytics and cross-device identity resolution.. Valid values are `console|pc|mobile|tablet|web_browser`',
    `link_ip_address` STRING COMMENT 'The IP address from which the platform identity linkage request originated. Used for fraud detection, geolocation verification, and security auditing.',
    `link_method` STRING COMMENT 'The technical method or flow used to establish the platform identity linkage. OAuth indicates standard OAuth 2.0 authorization flow; sdk_native indicates platform SDK native sign-in; manual_entry indicates player manually entered credentials; platform_sso indicates single sign-on federation; account_merge indicates linkage created during account merge operation.. Valid values are `oauth|sdk_native|manual_entry|platform_sso|account_merge`',
    `link_source` STRING COMMENT 'The application or channel through which the platform identity linkage was initiated. Game_client indicates in-game linking; web_portal indicates account management website; mobile_app indicates companion app; customer_support indicates manual linking by support agent; account_migration indicates bulk migration; platform_auto_link indicates automatic linkage by platform SDK.. Valid values are `game_client|web_portal|mobile_app|customer_support|account_migration|platform_auto_link`',
    `link_status` STRING COMMENT 'Current lifecycle status of the platform identity linkage. Active indicates the link is valid and operational; inactive indicates the player has disconnected the link; suspended indicates temporary restriction; revoked indicates permanent removal; pending_verification indicates awaiting platform OAuth confirmation; expired indicates the OAuth token or link has lapsed.. Valid values are `active|inactive|suspended|revoked|pending_verification|expired`',
    `linked_timestamp` TIMESTAMP COMMENT 'The date and time when the platform identity was first successfully linked to the player account. Represents the initial OAuth authorization or SDK linkage event.',
    `notes` STRING COMMENT 'Free-text field for operational notes, customer support annotations, or special handling instructions related to this platform identity linkage. Used for documenting manual interventions, escalations, or account-specific context.',
    `oauth_access_token_hash` STRING COMMENT 'One-way cryptographic hash of the OAuth 2.0 access token issued by the platform provider. Stored for audit and token rotation tracking; the actual token is stored in a secure vault. Hash enables token lifecycle management without exposing the credential.',
    `oauth_refresh_token_hash` STRING COMMENT 'One-way cryptographic hash of the OAuth 2.0 refresh token issued by the platform provider. Stored for audit and token rotation tracking; the actual token is stored in a secure vault.',
    `platform_account_creation_date` DATE COMMENT 'The date when the player originally created their account on the external platform (e.g., when they first registered for PSN, Xbox Live, or Steam). Sourced from platform API profile data where available.',
    `platform_account_tier` STRING COMMENT 'The subscription or membership tier of the players account on the external platform (e.g., PlayStation Plus, Xbox Game Pass Ultimate, Nintendo Switch Online). Indicates premium service level and entitlements on the platform.. Valid values are `free|basic|premium|plus|gold|ultimate`',
    `platform_achievement_count` STRING COMMENT 'The total number of achievements, trophies, or gamerscore points the player has earned on the external platform. Sourced from platform achievements API. Used for player engagement and skill segmentation.',
    `platform_age_verified_flag` BOOLEAN COMMENT 'Boolean indicator of whether the players age has been verified by the external platform provider. True indicates the platform has confirmed the player meets age requirements; false indicates unverified. Critical for COPPA and GDPR compliance.',
    `platform_communication_consent_flag` BOOLEAN COMMENT 'Boolean indicator of whether the player has granted consent for the game publisher to communicate with them via the external platform (e.g., platform notifications, messages). True indicates consent granted; false indicates opt-out.',
    `platform_data_sharing_consent_flag` BOOLEAN COMMENT 'Boolean indicator of whether the player has granted consent for the game publisher to receive and process their platform profile data (e.g., friends list, achievements, playtime). True indicates consent granted; false indicates opt-out.',
    `platform_display_name` STRING COMMENT 'The human-readable display name or gamertag shown on the external platform (e.g., Xbox Gamertag, PSN Online ID, Steam Profile Name). This is the public-facing identity the player uses on that platform.',
    `platform_email_verified_flag` BOOLEAN COMMENT 'Boolean indicator of whether the players email address has been verified by the external platform provider. True indicates the platform has confirmed email ownership; false indicates unverified. Used for trust scoring and fraud prevention.',
    `platform_friend_count` STRING COMMENT 'The total number of friends or connections the player has on the external platform. Sourced from platform social graph API. Used for social feature enablement and viral coefficient (K-Factor) analysis.',
    `platform_language_code` STRING COMMENT 'The two-letter ISO 639-1 language code representing the players preferred language setting on the external platform. Used for localized content delivery and communication.. Valid values are `^[a-z]{2}$`',
    `platform_parental_control_flag` BOOLEAN COMMENT 'Boolean indicator of whether parental controls are enabled on the players external platform account. True indicates the account is subject to parental restrictions (e.g., content filtering, spending limits, communication restrictions); false indicates no parental controls.',
    `platform_privacy_level` STRING COMMENT 'The privacy setting configured by the player on the external platform for their profile and activity visibility. Public allows all users to view; friends_only restricts to approved connections; private hides from all users.. Valid values are `public|friends_only|private`',
    `platform_region_code` STRING COMMENT 'The three-letter ISO 3166-1 alpha-3 country or region code associated with the players account on the external platform. Determines regional content availability, pricing, and compliance requirements (e.g., GDPR for EU, COPPA for USA).. Valid values are `^[A-Z]{3}$`',
    `platform_total_playtime_hours` DECIMAL(18,2) COMMENT 'The cumulative total playtime (in hours) the player has logged on the external platform across all games. Sourced from platform activity API where available. Used for player engagement profiling and LTV (Lifetime Value) modeling.',
    `platform_type` STRING COMMENT 'The external gaming platform or ecosystem to which this identity is linked. Represents the first-party platform provider (console manufacturer or digital storefront). [ENUM-REF-CANDIDATE: psn|xbox_live|nintendo_online|steam|epic_games|apple_game_center|google_play_games — 7 candidates stripped; promote to reference product]',
    `primary_identity_flag` BOOLEAN COMMENT 'Boolean indicator of whether this platform identity is designated as the players primary or preferred identity for cross-platform features. True indicates this is the primary identity used for display name, friends list, and social features; false indicates a secondary linked identity.',
    `token_expiry_timestamp` TIMESTAMP COMMENT 'The date and time when the current OAuth access token will expire and require refresh. Used to trigger proactive token renewal before expiration to maintain seamless cross-platform authentication.',
    `unlinked_timestamp` TIMESTAMP COMMENT 'The date and time when the platform identity was disconnected or revoked by the player or system. Null if the link is still active.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this platform identity linkage record was most recently modified. Audit field for change tracking and data lineage.',
    CONSTRAINT pk_platform_identity PRIMARY KEY(`platform_identity_id`)
) COMMENT 'Tracks a players linked external platform identities (PSN ID, Xbox Gamertag, Nintendo Account, Steam ID, Epic Games ID, Apple Game Center, Google Play Games). Each row represents one platform-to-account linkage, storing the external platform type, external platform user ID, platform display name, link status, link timestamp, and last verified timestamp. Enables cross-platform identity resolution and single sign-on federation. Sourced from Steamworks, Console SDKs, and Epic Games Store SDK integrations.';

CREATE OR REPLACE TABLE `gaming_ecm`.`player`.`consent_snapshot` (
    `consent_snapshot_id` BIGINT COMMENT 'Unique identifier for the consent snapshot record. Primary key.',
    `device_id` BIGINT COMMENT 'Device identifier (IDFA, GAID, console ID) from which consent was granted. Used for cross-platform consent tracking and device-level consent management.',
    `consent_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.consent_policy. Business justification: GDPR Article 7 requires linking each consent record to the specific policy version player agreed to. Essential for audit defense, consent withdrawal validation, and demonstrating lawful basis. Gaming ',
    `player_account_id` BIGINT COMMENT 'Identifier of the player who provided or withdrew consent. Links to the player master record.',
    `age_verification_method` STRING COMMENT 'The method used to verify the players age. Includes government ID check, credit card verification, third-party age verification service, self-declaration, parental verification, or not_verified if no verification performed.. Valid values are `government_id|credit_card|third_party_service|self_declaration|parental_verification|not_verified`',
    `age_verification_status` STRING COMMENT 'Status of age verification for age-gated content and COPPA/GDPR compliance. Verified indicates successful age check, pending indicates in-progress verification, failed indicates unsuccessful verification, not_required indicates no age gate applies, self_declared indicates player-provided age without verification.. Valid values are `verified|pending|failed|not_required|self_declared`',
    `analytics_tracking_allowed` BOOLEAN COMMENT 'Indicates whether the player has consented to behavioral analytics tracking and telemetry collection. Used for GameAnalytics, Amplitude, and similar player behavior tracking platforms.',
    `collection_method` STRING COMMENT 'The channel or interface through which consent was collected. Includes in-game prompts, web portals, mobile apps, parental consent portals, customer support interactions, email, SMS, console SDK flows, and platform OAuth consent screens. [ENUM-REF-CANDIDATE: in_game_prompt|web_portal|mobile_app|parental_portal|customer_support|email|sms|console_sdk|platform_oauth — 9 candidates stripped; promote to reference product]',
    `collection_platform` STRING COMMENT 'The gaming platform on which consent was collected. Tracks platform-specific consent requirements and first-party platform certification compliance. [ENUM-REF-CANDIDATE: pc|console_playstation|console_xbox|console_nintendo|mobile_ios|mobile_android|web|vr|cloud_gaming — 9 candidates stripped; promote to reference product]',
    `compliance_notes` STRING COMMENT 'Free-text field for recording compliance-related notes, exceptions, special handling instructions, or regulatory authority communications related to this consent record.',
    `consent_audit_trail` STRING COMMENT 'JSON or structured text containing the full audit trail of consent changes, including timestamps, user actions, system events, and regulatory compliance checkpoints. Provides complete consent lifecycle history.',
    `consent_expiry_timestamp` TIMESTAMP COMMENT 'Date and time when time-bound consent expires. Null for indefinite consent. Used for age-gated content re-verification and periodic consent refresh requirements.',
    `consent_granted_timestamp` TIMESTAMP COMMENT 'Date and time when the player granted consent. Critical for GDPR Article 7 proof-of-consent requirements and COPPA parental consent audit trails.',
    `consent_ip_address` STRING COMMENT 'IP address from which consent was granted. Used for audit trail, fraud detection, and jurisdiction determination. May be considered PII in some jurisdictions.',
    `consent_language` STRING COMMENT 'ISO 639-1 two-letter language code indicating the language in which consent was presented and obtained. Ensures consent was provided in a language the player understands.',
    `consent_scope` STRING COMMENT 'Detailed description of what data processing activities this consent covers. May include specific game titles, data types, processing purposes, or third-party sharing arrangements.',
    `consent_status` STRING COMMENT 'Current state of the consent. Granted indicates active consent, withdrawn indicates player-initiated removal, pending indicates awaiting parental approval, expired indicates time-bound consent has lapsed, revoked indicates system or regulatory removal, not_required indicates consent not applicable for this player/jurisdiction.. Valid values are `granted|withdrawn|pending|expired|revoked|not_required`',
    `consent_type` STRING COMMENT 'The category of consent being recorded. Includes GDPR (General Data Protection Regulation) data processing consent, COPPA (Childrens Online Privacy Protection Act) parental consent, marketing opt-in, analytics tracking, cookie consent, and age verification.. Valid values are `gdpr_data_processing|coppa_parental_consent|marketing_opt_in|analytics_tracking|cookie_consent|age_verification`',
    `consent_user_agent` STRING COMMENT 'Browser or application user agent string captured at the time of consent. Provides technical context for consent collection audit trail.',
    `consent_withdrawn_timestamp` TIMESTAMP COMMENT 'Date and time when the player withdrew consent. Null if consent has not been withdrawn. Required for GDPR right to withdraw consent tracking.',
    `cookie_consent_granted` BOOLEAN COMMENT 'Indicates whether the player has consented to non-essential cookies and tracking technologies on web and mobile platforms. Required for GDPR and ePrivacy Directive compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this consent snapshot record was first created in the system. Used for audit trail and data lineage tracking.',
    `data_portability_requested` BOOLEAN COMMENT 'Indicates whether the player has requested a copy of their data under GDPR Article 20 right to data portability. True triggers data export workflows.',
    `data_retention_period_days` STRING COMMENT 'Number of days player data will be retained under this consent. Null indicates indefinite retention subject to regulatory limits. Used for GDPR storage limitation principle and right to erasure compliance.',
    `erasure_request_timestamp` TIMESTAMP COMMENT 'Date and time when the player requested data erasure. Null if no erasure request has been made. Used to track compliance with GDPR 30-day response requirement.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this is the current active consent record for this player and consent type. True for active records, false for historical or superseded records. Used for slowly changing dimension (SCD) Type 2 tracking.',
    `jurisdiction` STRING COMMENT 'The legal jurisdiction governing this consent record, represented as ISO 3166-1 alpha-3 country code or regional code (e.g., USA, GBR, DEU, EU, JPN, KOR). Determines applicable privacy regulations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this consent snapshot record was last updated. Used for audit trail and change tracking.',
    `legal_basis` STRING COMMENT 'The GDPR Article 6 legal basis for processing player data. Consent indicates explicit player agreement, contract indicates processing necessary for service delivery, legal_obligation indicates regulatory requirement, vital_interests indicates protection of life, public_task indicates public interest, legitimate_interests indicates business interest balanced against player rights.. Valid values are `consent|contract|legal_obligation|vital_interests|public_task|legitimate_interests`',
    `marketing_opt_in` BOOLEAN COMMENT 'Indicates whether the player has opted in to receive marketing communications (email, SMS, push notifications). True indicates opt-in, false indicates opt-out.',
    `parent_email` STRING COMMENT 'Email address of the parent or legal guardian who provided consent for an underage player. Null for players not requiring parental consent.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `parental_consent_required` BOOLEAN COMMENT 'Indicates whether parental consent is required for this player based on age and jurisdiction. True for players under 13 in COPPA jurisdictions or under 16 in GDPR jurisdictions.',
    `parental_consent_verified` BOOLEAN COMMENT 'Indicates whether parental consent has been verified through an approved method. True if verification completed, false if pending or not verified.',
    `parental_verification_method` STRING COMMENT 'The method used to verify parental consent for underage players. Includes FTC-approved COPPA verification methods: credit card verification, government ID check, video conference, signed consent form, toll-free call, email plus credit card. Not_applicable for players not requiring parental consent. [ENUM-REF-CANDIDATE: credit_card|government_id|video_conference|signed_form|toll_free_call|email_plus_credit_card|not_applicable — 7 candidates stripped; promote to reference product]',
    `portability_request_timestamp` TIMESTAMP COMMENT 'Date and time when the player requested data portability. Null if no portability request has been made. Used to track compliance with GDPR 30-day response requirement.',
    `record_source_system` STRING COMMENT 'Name of the source system or application that created or last modified this consent record. Examples include Salesforce CRM, in-game consent manager, parental portal, customer support system.',
    `right_to_erasure_requested` BOOLEAN COMMENT 'Indicates whether the player has requested deletion of their data under GDPR Article 17 right to erasure or COPPA parental deletion rights. True triggers data deletion workflows.',
    `third_party_sharing_allowed` BOOLEAN COMMENT 'Indicates whether the player has consented to sharing their data with third parties (advertisers, analytics providers, platform partners). Critical for GDPR Article 6 and COPPA compliance.',
    CONSTRAINT pk_consent_snapshot PRIMARY KEY(`consent_snapshot_id`)
) COMMENT 'Authoritative SSOT for all player consent and regulatory compliance records. Stores consent type (GDPR data processing, COPPA parental consent, marketing opt-in, analytics tracking, cookie consent, age verification), consent status (granted, withdrawn, pending), consent version, consent timestamp, withdrawal timestamp, consent collection method (in-game, web, parental portal), jurisdiction, and the specific legal basis. Critical for GDPR Article 7, COPPA compliance, and ESRB/PEGI age-gating enforcement. One row per consent type per player.';

CREATE OR REPLACE TABLE `gaming_ecm`.`player`.`parental_control` (
    `parental_control_id` BIGINT COMMENT 'Unique identifier for the parental control configuration record.',
    `player_account_id` BIGINT COMMENT 'Reference to the minor player account subject to this parental control configuration.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Parental control enforcement rules vary by jurisdiction (COPPA age 13 in US, GDPR age varies by EU member state, different content restrictions in China/Korea). Essential for applying correct age gate',
    `primary_parental_player_account_id` BIGINT COMMENT 'Reference to the parent or guardian player account who owns and manages this parental control configuration.',
    `tertiary_parental_created_by_player_player_account_id` BIGINT COMMENT 'Reference to the player account (parent or authorized administrator) who initially created this parental control configuration.',
    `auto_expire_on_age_flag` BOOLEAN COMMENT 'Indicates whether this parental control configuration should automatically expire when the child player reaches the age of majority in their jurisdiction.',
    `chat_enabled_flag` BOOLEAN COMMENT 'Indicates whether the child player is allowed to use text chat features in games and platforms.',
    `consent_granted_timestamp` TIMESTAMP COMMENT 'Date and time when parental consent was granted for the minor player account.',
    `consent_method` STRING COMMENT 'Method used to verify parental consent, ensuring the person granting consent is the actual parent or legal guardian.. Valid values are `email_verification|credit_card_verification|government_id|video_conference|signed_form|platform_sdk`',
    `consent_status` STRING COMMENT 'Status of parental consent for the minor player account, required for COPPA compliance and data collection authorization.. Valid values are `granted|denied|pending|revoked|expired`',
    `content_rating_restriction` STRING COMMENT 'Maximum content rating level the child player is allowed to access, enforcing age-appropriate content restrictions based on ESRB, PEGI, CERO, or USK rating systems. [ENUM-REF-CANDIDATE: ESRB_E|ESRB_E10|ESRB_T|ESRB_M|ESRB_AO|PEGI_3|PEGI_7|PEGI_12|PEGI_16|PEGI_18|CERO_A|CERO_B|CERO_C|CERO_D|CERO_Z|USK_0|USK_6|USK_12|USK_16|USK_18 — promote to reference product]',
    `control_status` STRING COMMENT 'Current lifecycle status of the parental control configuration indicating whether restrictions are actively enforced.. Valid values are `active|inactive|suspended|pending_verification`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this parental control configuration record was first created in the system.',
    `daily_playtime_limit_minutes` STRING COMMENT 'Maximum number of minutes the child player is allowed to play per calendar day.',
    `daily_spending_limit_amount` DECIMAL(18,2) COMMENT 'Maximum amount the child player can spend on in-app purchases (IAP) and microtransactions (MTX) per calendar day.',
    `data_collection_allowed_flag` BOOLEAN COMMENT 'Indicates whether the platform is allowed to collect behavioral and analytics data from the child player account beyond what is strictly necessary for service provision.',
    `effective_end_date` DATE COMMENT 'Date when this parental control configuration expires or is scheduled to be deactivated, nullable for indefinite configurations.',
    `effective_start_date` DATE COMMENT 'Date when this parental control configuration becomes active and restrictions begin to be enforced.',
    `enforcement_mode` STRING COMMENT 'Mode of enforcement for parental control restrictions: strict (hard block), flexible (warnings with override), or advisory (informational only).. Valid values are `strict|flexible|advisory`',
    `friend_requests_allowed_flag` BOOLEAN COMMENT 'Indicates whether the child player is allowed to send or receive friend requests and build social connections.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this parental control configuration was last updated by the parent or guardian.',
    `location_sharing_allowed_flag` BOOLEAN COMMENT 'Indicates whether the child player is allowed to share their geographic location with other players or services.',
    `marketing_communications_allowed_flag` BOOLEAN COMMENT 'Indicates whether the child player is allowed to receive marketing communications, promotional offers, and advertising content.',
    `monthly_spending_limit_amount` DECIMAL(18,2) COMMENT 'Maximum amount the child player can spend on in-app purchases (IAP) and microtransactions (MTX) per calendar month.',
    `multiplayer_allowed_flag` BOOLEAN COMMENT 'Indicates whether the child player is allowed to participate in multiplayer game modes including PvP (Player versus Player) and PvE (Player versus Environment).',
    `notes` STRING COMMENT 'Free-text notes or comments entered by the parent regarding the parental control configuration, restrictions rationale, or special instructions.',
    `notification_email` STRING COMMENT 'Email address where the parent receives notifications about the child player activity, spending, and policy violations.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `notification_frequency` STRING COMMENT 'Frequency at which the parent receives activity and compliance notifications for the child player account.. Valid values are `real_time|daily|weekly|monthly|on_violation`',
    `override_pin_hash` STRING COMMENT 'Hashed PIN code that allows the parent to temporarily override parental control restrictions for the child player session.',
    `platform_identifier` STRING COMMENT 'Specific platform identifier or SDK source where this parental control configuration originated (e.g., PlayStation Network, Xbox Live, Nintendo Switch Online, Steam, Epic Games Store, Apple App Store, Google Play).',
    `platform_type` STRING COMMENT 'Gaming platform type where this parental control configuration is enforced (console, PC, mobile, web, VR, AR).. Valid values are `console|pc|mobile|web|vr|ar`',
    `spending_limit_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for spending limits (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `ugc_access_allowed_flag` BOOLEAN COMMENT 'Indicates whether the child player is allowed to view, create, or share user-generated content (UGC).',
    `voice_chat_enabled_flag` BOOLEAN COMMENT 'Indicates whether the child player is allowed to use voice chat features in games and platforms.',
    `weekly_playtime_limit_minutes` STRING COMMENT 'Maximum number of minutes the child player is allowed to play per calendar week.',
    CONSTRAINT pk_parental_control PRIMARY KEY(`parental_control_id`)
) COMMENT 'Manages parental control configurations for minor player accounts, required for COPPA compliance and ESRB/PEGI age-gating. Stores parent/guardian account reference, child account reference, parental consent status, spending limit (daily/monthly IAP cap), playtime limit (daily hours), content rating restriction (ESRB E/T/M, PEGI 3/7/12/16/18), communication restrictions (chat enabled, voice enabled, friend requests allowed), and last modified timestamp. Sourced from platform parental control SDKs and in-game parental portal.';

CREATE OR REPLACE TABLE `gaming_ecm`.`player`.`preference` (
    `preference_id` BIGINT COMMENT 'Unique identifier for the player preference record. Primary key.',
    `consent_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.consent_policy. Business justification: Privacy preferences (data_sharing_analytics_enabled, data_sharing_marketing_enabled, data_sharing_third_party_enabled) must reference the consent policy version under which player made choices. Requir',
    `game_title_id` BIGINT COMMENT 'Reference to the specific game title these preferences apply to. Null if preferences are platform-level or account-level.',
    `player_account_id` BIGINT COMMENT 'Reference to the player or support agent who last modified these preferences. Supports audit and compliance.',
    `preference_player_account_id` BIGINT COMMENT 'Reference to the player who owns these preferences. Links to the player master entity.',
    `storefront_id` BIGINT COMMENT 'Reference to the gaming platform (console, PC, mobile) where these preferences apply.',
    `audio_language` STRING COMMENT 'ISO 639-2 three-letter language code for in-game voice-over and audio. Supports localization.. Valid values are `^[A-Z]{3}$`',
    `auto_update_enabled` BOOLEAN COMMENT 'Platform preference controlling whether game updates and patches are automatically downloaded and installed.',
    `colorblind_mode` STRING COMMENT 'Accessibility setting for colorblind players. Adjusts in-game color palettes for improved visibility.. Valid values are `none|protanopia|deuteranopia|tritanopia`',
    `control_scheme` STRING COMMENT 'Player-configured controller or keyboard/mouse input mapping scheme.. Valid values are `default|custom|inverted|southpaw|legacy|tactical`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this preference record was first created in the system. Audit trail.',
    `crossplay_enabled` BOOLEAN COMMENT 'Gameplay preference controlling whether the player can be matched with players on other platforms in multiplayer modes.',
    `data_sharing_analytics_enabled` BOOLEAN COMMENT 'Privacy setting controlling whether player gameplay data can be used for analytics and product improvement. GDPR consent for analytics processing.',
    `data_sharing_marketing_enabled` BOOLEAN COMMENT 'Privacy setting controlling whether player data can be used for targeted marketing and personalization. GDPR consent for marketing processing.',
    `data_sharing_third_party_enabled` BOOLEAN COMMENT 'Privacy setting controlling whether player data can be shared with third-party partners (e.g., ad networks, analytics providers). GDPR consent for third-party sharing.',
    `difficulty_level` STRING COMMENT 'Player-selected gameplay difficulty setting. Drives game balancing and challenge scaling.. Valid values are `easy|normal|hard|expert|custom`',
    `effective_date` DATE COMMENT 'The date when these preference settings became active. Supports preference history and audit trails.',
    `email_enabled` BOOLEAN COMMENT 'Master toggle for all email communications. When false, no emails are sent regardless of category settings.',
    `email_newsletter_enabled` BOOLEAN COMMENT 'Opt-in for email newsletters with game news, community highlights, and developer updates.',
    `email_promotional_enabled` BOOLEAN COMMENT 'Opt-in for promotional emails about sales, offers, and special events. Marketing consent.',
    `email_transactional_enabled` BOOLEAN COMMENT 'Opt-in for transactional emails such as purchase receipts, account security alerts, and service notifications. Typically cannot be disabled for operational reasons.',
    `expiration_date` DATE COMMENT 'The date when these preference settings expire or were superseded by a newer version. Null if currently active.',
    `friend_discovery_enabled` BOOLEAN COMMENT 'Privacy setting controlling whether other players can find and send friend requests to this player.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this preference record is currently active. False if superseded or expired.',
    `matchmaking_region` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the players preferred geographic region for multiplayer matchmaking. Affects latency and server selection.. Valid values are `^[A-Z]{3}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this preference record was last modified. Audit trail.',
    `preference_scope` STRING COMMENT 'The scope at which these preferences apply: account-wide, platform-specific, game-specific, or session-only.. Valid values are `account|platform|game|session`',
    `preference_source` STRING COMMENT 'The system or channel through which these preferences were set. Supports audit and troubleshooting.. Valid values are `in_game|web_portal|mobile_app|crm|support|default`',
    `preferred_storefront` STRING COMMENT 'Players preferred digital storefront for purchases and content discovery. Drives personalization and cross-platform entitlement. [ENUM-REF-CANDIDATE: steam|epic|playstation|xbox|nintendo|mobile_ios|mobile_android|web — 8 candidates stripped; promote to reference product]',
    `profanity_filter_enabled` BOOLEAN COMMENT 'Communication preference controlling whether profanity and offensive language are filtered in chat. Often required for COPPA compliance for child accounts.',
    `profile_visibility` STRING COMMENT 'Privacy setting controlling who can view the players profile, stats, and activity. Public = everyone, Friends = friends only, Private = only the player.. Valid values are `public|friends|private`',
    `push_game_updates_enabled` BOOLEAN COMMENT 'Opt-in for push notifications about game updates, patches, and new content releases.',
    `push_notification_enabled` BOOLEAN COMMENT 'Master toggle for all push notifications. When false, no push notifications are sent regardless of category settings.',
    `push_promotional_enabled` BOOLEAN COMMENT 'Opt-in for push notifications about sales, offers, and promotional campaigns. Marketing consent.',
    `push_social_enabled` BOOLEAN COMMENT 'Opt-in for push notifications about friend activity, guild events, and social interactions.',
    `sms_enabled` BOOLEAN COMMENT 'Master toggle for SMS text message communications. When false, no SMS messages are sent.',
    `sms_promotional_enabled` BOOLEAN COMMENT 'Opt-in for promotional SMS messages about sales and offers. Marketing consent.',
    `subtitle_enabled` BOOLEAN COMMENT 'Indicates whether subtitles are enabled for this player. Accessibility feature.',
    `subtitle_language` STRING COMMENT 'ISO 639-2 three-letter language code for in-game subtitle display. Supports localization and accessibility.. Valid values are `^[A-Z]{3}$`',
    `telemetry_enabled` BOOLEAN COMMENT 'Privacy setting controlling whether detailed gameplay telemetry (performance metrics, crash reports, usage patterns) is collected. Distinct from analytics consent.',
    `text_chat_enabled` BOOLEAN COMMENT 'Communication preference controlling whether the player participates in in-game text chat.',
    `voice_chat_enabled` BOOLEAN COMMENT 'Communication preference controlling whether the player participates in in-game voice chat.',
    CONSTRAINT pk_preference PRIMARY KEY(`preference_id`)
) COMMENT 'Stores player-configured in-game and platform preferences including notification settings (push, email, SMS opt-in per category), gameplay preferences (difficulty, control scheme, accessibility settings such as colorblind mode and subtitle language), privacy settings (profile visibility, friend discovery, data sharing), communication preferences, and preferred storefront. Distinct from profile (demographic) and consent_record (legal compliance) — preferences are operational player settings that drive personalization and UX. Sourced from in-game settings and Salesforce CRM preference center.';

CREATE OR REPLACE TABLE `gaming_ecm`.`player`.`device` (
    `device_id` BIGINT COMMENT 'Unique identifier for the player-owned device. Primary key.',
    `network_region_id` BIGINT COMMENT 'Foreign key linking to infrastructure.network_region. Business justification: Player devices connect from geographic locations that must be mapped to network regions for CDN routing, latency optimization, and data residency compliance. Network operations teams use this to route',
    `platform_account_id` BIGINT COMMENT 'First-party platform account identifier (e.g., PlayStation Network ID, Xbox Live Gamertag, Steam ID) associated with this device.',
    `player_account_id` BIGINT COMMENT 'Identifier of the player who owns or uses this device. A player may own multiple devices; a device may be shared by household members.',
    `advertising_identifier` STRING COMMENT 'Platform-specific advertising identifier (IDFA for iOS, GAID for Android). Used for attribution tracking and ad targeting. May be reset by user.',
    `app_version` STRING COMMENT 'Version of the game client or platform app installed on this device. Used for compatibility checks and feature rollout management.',
    `ban_expiry_timestamp` TIMESTAMP COMMENT 'Timestamp when a temporary device ban expires. Null for permanent bans or unbanned devices. Used for automated ban lift processing.',
    `ban_reason` STRING COMMENT 'Reason for device ban if device_status is banned. Null if device is not banned. Used for policy enforcement tracking and appeals processing.',
    `ban_timestamp` TIMESTAMP COMMENT 'Timestamp when the device was banned. Null if device is not banned. Used for ban duration tracking and policy enforcement auditing.',
    `carrier_name` STRING COMMENT 'Mobile network carrier name for mobile devices. Used for carrier billing integration and network performance analysis.',
    `connection_type` STRING COMMENT 'Type of network connection last used by the device. Used for content delivery optimization and network performance analytics.. Valid values are `wifi|cellular|ethernet|unknown`',
    `cpu_architecture` STRING COMMENT 'Processor architecture of the device (e.g., x86_64, ARM64). Used for build compatibility and performance optimization.',
    `device_status` STRING COMMENT 'Current lifecycle status of the device in the platform. Banned status enforces hardware bans for policy violations.. Valid values are `active|inactive|banned|suspended|pending_verification`',
    `device_type` STRING COMMENT 'Category of device used to access games and platform services. Determines platform-specific feature gating and content delivery.. Valid values are `console|pc|mobile|tablet|vr_headset|handheld`',
    `fingerprint_hash` STRING COMMENT 'Cryptographic hash of the device fingerprint used for fraud detection and device identification. Enables detection of multiple accounts per device and device spoofing.',
    `first_seen_timestamp` TIMESTAMP COMMENT 'Timestamp when this device was first registered or detected in the platform. Used for device age analysis and fraud detection.',
    `gpu_model` STRING COMMENT 'Graphics processor model of the device. Used for graphics quality settings and performance profiling.',
    `ip_address_last_known` STRING COMMENT 'Most recent IP address observed from this device. Used for geolocation, fraud detection, and regional content delivery.',
    `is_emulator` BOOLEAN COMMENT 'Indicates whether the device is detected as an emulator or virtual device. True if emulator, False otherwise. Used for fraud detection and policy enforcement.',
    `is_primary_device` BOOLEAN COMMENT 'Indicates whether this is the players primary device for game access and notifications. True if primary, False otherwise.',
    `is_rooted_or_jailbroken` BOOLEAN COMMENT 'Indicates whether the device has been rooted (Android) or jailbroken (iOS). True if modified, False otherwise. Used for security risk assessment and anti-cheat enforcement.',
    `language` STRING COMMENT 'Primary language setting of the device in ISO 639-1 format (e.g., en, en-US, ja-JP). Used for localized content delivery and player segmentation.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `last_seen_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent activity from this device. Used for device activity tracking and dormancy detection.',
    `mac_address` STRING COMMENT 'Network hardware address of the device. Used for device identification and network-level fraud detection.. Valid values are `^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$`',
    `make` STRING COMMENT 'Manufacturer or brand of the device (e.g., Sony, Microsoft, Apple, Samsung, Valve).',
    `model` STRING COMMENT 'Specific model identifier of the device (e.g., PlayStation 5, Xbox Series X, iPhone 14 Pro, Galaxy S23).',
    `notes` STRING COMMENT 'Free-text notes or comments about the device. Used for customer support annotations and fraud investigation tracking.',
    `os_name` STRING COMMENT 'Name of the operating system running on the device (e.g., iOS, Android, Windows, PlayStation OS, Xbox OS).',
    `os_version` STRING COMMENT 'Version number of the operating system. Used for compatibility checks and platform-specific feature gating.',
    `platform_sdk_version` STRING COMMENT 'Version of the platform SDK installed on the device. Critical for API compatibility and feature availability checks.',
    `push_notification_token` STRING COMMENT 'Platform-specific token used for routing push notifications to this device. Required for live operations and player engagement campaigns.',
    `registration_timestamp` TIMESTAMP COMMENT 'Timestamp when the device was formally registered to the player account. Distinct from first_seen_timestamp which may capture earlier detection.',
    `screen_resolution` STRING COMMENT 'Display resolution of the device (e.g., 1920x1080, 3840x2160). Used for graphics quality settings and asset delivery optimization.',
    `serial_number` STRING COMMENT 'Manufacturer-assigned serial number of the device. Used for warranty tracking and hardware ban enforcement.',
    `storage_capacity_gb` STRING COMMENT 'Total storage capacity of the device in gigabytes. Used for download size recommendations and storage management features.',
    `timezone_offset` STRING COMMENT 'Timezone offset from UTC for the devices location (e.g., +00:00, -08:00). Used for scheduling live events and time-based content delivery.',
    `total_memory_mb` STRING COMMENT 'Total system memory (RAM) available on the device in megabytes. Used for performance optimization and minimum spec enforcement.',
    `trust_score` DECIMAL(18,2) COMMENT 'Calculated trust score (0.00 to 100.00) indicating the devices trustworthiness based on behavior patterns, fraud signals, and usage history. Used for fraud detection and risk assessment.',
    CONSTRAINT pk_device PRIMARY KEY(`device_id`)
) COMMENT 'Tracks player-owned devices used to access games and platform services. Stores device type (console, PC, mobile, tablet, VR headset, handheld), device make/model, OS version, platform SDK version, device fingerprint hash, first seen timestamp, last seen timestamp, is_primary_device flag, push notification token, and device trust score. Enables device-based fraud detection (multiple accounts per device, device spoofing), platform-specific feature gating, push notification delivery routing, and hardware ban enforcement. One player may have multiple devices; one device may be shared by household members. Distinct from infrastructure domain server/CDN assets.';

CREATE OR REPLACE TABLE `gaming_ecm`.`player`.`segment` (
    `segment_id` BIGINT COMMENT 'Unique identifier for the player segment. Primary key.',
    `ml_model_registry_id` BIGINT COMMENT 'Identifier of the ML model used for segment assignment, if assignment_method is ml_model or hybrid. Null for rule-based segments.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Player segments are created and maintained by analytics or marketing employees. The existing segment_owner text field should be normalized to a proper FK for accountability, access control (only owner',
    `parent_segment_id` BIGINT COMMENT 'Reference to a parent segment if this segment is a sub-segment or refinement of a broader segment. Null for top-level segments. Enables hierarchical segment taxonomies.',
    `acquisition_channel` STRING COMMENT 'Marketing channel or source for acquisition-source segments (e.g., organic, facebook_ads, influencer, app_store_feature). Null for non-acquisition segments.',
    `age_range_max` STRING COMMENT 'Maximum age for demographic age-based segments. Null for open-ended or non-age segments.',
    `age_range_min` STRING COMMENT 'Minimum age for demographic age-based segments. Null for non-age segments. Used for COPPA compliance and age-gated content targeting.',
    `approval_status` STRING COMMENT 'Workflow approval state for segment definition: draft (being created), pending_review (submitted for approval), approved (ready for use), rejected (not approved).. Valid values are `draft|pending_review|approved|rejected`',
    `approved_by` STRING COMMENT 'Username or identifier of the business user who approved this segment for production use. Null if not yet approved.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this segment was approved for production use. Null if not yet approved.',
    `assignment_method` STRING COMMENT 'How players are assigned to this segment: rule_based (deterministic business rules), ml_model (machine learning classification), manual (analyst-curated), or hybrid (combination).. Valid values are `rule_based|ml_model|manual|hybrid`',
    `churn_risk_score_max` DECIMAL(18,2) COMMENT 'Maximum churn risk probability score (0.0000 to 1.0000) for churn-risk segments. Null for non-churn segments.',
    `churn_risk_score_min` DECIMAL(18,2) COMMENT 'Minimum churn risk probability score (0.0000 to 1.0000) for churn-risk segments. Null for non-churn segments.',
    `coppa_safe` BOOLEAN COMMENT 'Indicates whether this segment is safe for targeting players under 13 years old per COPPA requirements (True) or restricted to 13+ audiences (False).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this segment record was first created in the system.',
    `definition_criteria` STRING COMMENT 'Business rule or logic defining segment membership (e.g., Players with LTV > $500, Retained on Day 7, No login in 30 days). May reference rule engine or ML model.',
    `effective_end_date` DATE COMMENT 'Date when this segment definition was retired or superseded. Null for currently active segments.',
    `effective_start_date` DATE COMMENT 'Date when this segment definition became active and players began being assigned to it.',
    `engagement_tier` STRING COMMENT 'Engagement level classification for engagement-based segments: high (daily active), medium (weekly active), low (monthly active), inactive (lapsed). Null for non-engagement segments.. Valid values are `high|medium|low|inactive`',
    `gdpr_compliant` BOOLEAN COMMENT 'Indicates whether this segment definition complies with GDPR requirements for player data processing and consent (True) or requires review (False). Critical for EU player targeting.',
    `geo_filter` STRING COMMENT 'Geographic restriction for this segment using ISO 3166-1 alpha-3 country codes (e.g., USA, JPN, DEU) or region codes. Null for global segments.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this segment is currently active and being used for player assignment and targeting (True) or has been retired (False).',
    `is_standard_segment` BOOLEAN COMMENT 'Indicates whether this is a standard, enterprise-wide segment (True) used across all games and teams, or a custom segment (False) created for specific campaigns or experiments.',
    `last_refresh_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent segment membership recalculation run.',
    `max_ltv_threshold` DECIMAL(18,2) COMMENT 'Maximum LTV value for segment membership, applicable to LTV-based segments (e.g., Minnow tier upper bound). Null for open-ended or non-LTV segments.',
    `min_ltv_threshold` DECIMAL(18,2) COMMENT 'Minimum LTV value required for segment membership, applicable to LTV-based segments (e.g., Whale tier). Null for non-LTV segments.',
    `modified_by` STRING COMMENT 'Username or identifier of the business user who last modified this segment definition.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this segment record was last modified.',
    `platform_filter` STRING COMMENT 'Platform restriction for this segment (e.g., console, pc, mobile, all). Used when segment is platform-specific.',
    `player_count` BIGINT COMMENT 'Current number of players assigned to this segment as of last_refresh_timestamp. Snapshot metric for segment size monitoring.',
    `priority_rank` STRING COMMENT 'Priority ranking for segment assignment when a player qualifies for multiple segments. Lower numbers indicate higher priority. Used for conflict resolution in targeting logic.',
    `refresh_frequency` STRING COMMENT 'How often player membership in this segment is recalculated: real_time (streaming), hourly, daily, weekly, monthly, or on_demand (manual trigger).. Valid values are `real_time|hourly|daily|weekly|monthly|on_demand`',
    `retention_day_threshold` STRING COMMENT 'Day number used for retention-based segments (e.g., 1 for D1 retained, 7 for D7 retained, 30 for D30 retained). Null for non-retention segments.',
    `segment_code` STRING COMMENT 'Short alphanumeric code for the segment used in system integrations and reporting (e.g., WHALE_01, D7_RET, CHURN_HIGH).',
    `segment_description` STRING COMMENT 'Detailed business description of the segment purpose, membership criteria, and intended use cases. Provides context for analysts and marketers.',
    `segment_name` STRING COMMENT 'Human-readable name of the player segment (e.g., Whale, Dolphin, Minnow, D7 Retained, High Churn Risk, FTUE Incomplete).',
    `segment_type` STRING COMMENT 'Classification of the segment methodology: behavioral (play patterns), demographic (age, geo), LTV-based (spend tiers), engagement_based (DAU/MAU/WAU), acquisition_source (organic, paid), or churn_risk (predictive).. Valid values are `behavioral|demographic|ltv_based|engagement_based|acquisition_source|churn_risk`',
    `spend_tier` STRING COMMENT 'Monetization tier classification for spend-based segments: whale (high spenders), dolphin (medium spenders), minnow (low spenders), non_payer (F2P only). Null for non-spend segments.. Valid values are `whale|dolphin|minnow|non_payer`',
    `tags` STRING COMMENT 'Comma-separated list of business tags for segment categorization and search (e.g., monetization, retention, high_value, experimental). Used for segment discovery and filtering.',
    `target_use_case` STRING COMMENT 'Primary business use case for this segment (e.g., Live-ops event targeting, Personalized offers, Churn prevention campaign, A/B test cohort, Retention analysis).',
    `created_by` STRING COMMENT 'Username or identifier of the business user who created this segment definition.',
    CONSTRAINT pk_segment PRIMARY KEY(`segment_id`)
) COMMENT 'Defines player segmentation classifications used for live-ops targeting, personalization, and lifecycle management in GaaS operations. Stores segment name, segment type (behavioral, demographic, LTV-based, engagement-based, acquisition-source, churn-risk), definition criteria (rule-based or ML-assigned), segment owner (marketing, product, live-ops), effective date range, and is_active flag. Standard segments: Whale/Dolphin/Minnow (spend tiers), D1/D7/D30 retained cohorts, F2P converter, churned, lapsed, FTUE incomplete, high-churn-risk. This is the authoritative player classification taxonomy consumed by marketing and live-ops for campaign targeting and intervention workflows.';

CREATE OR REPLACE TABLE `gaming_ecm`.`player`.`segment_membership` (
    `segment_membership_id` BIGINT COMMENT 'Unique identifier for the segment membership record. Primary key for tracking individual player-segment associations over time.',
    `game_title_id` BIGINT COMMENT 'Reference to the specific game title for which this segment membership applies. Null indicates a cross-game or account-level segment. Enables game-specific player segmentation and title-level retention strategies.',
    `marketing_campaign_id` BIGINT COMMENT 'Reference to the marketing or retention campaign that this segment membership supports. Null if the segment is not campaign-specific. Links segment membership to campaign performance tracking and ROI analysis.',
    `player_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.player_segment. Business justification: Segment_membership assigns players to marketing-defined segments for CRM campaigns, email/push targeting, and lifecycle marketing automation. Marketing.player_segment represents marketing teams segme',
    `player_account_id` BIGINT COMMENT 'Reference to the player account that is assigned to this segment. Links to the authoritative player identity in the Player domain.',
    `segment_id` BIGINT COMMENT 'Reference to the segment definition that this player is assigned to. Links to the segment configuration and rules.',
    `assignment_batch_code` STRING COMMENT 'Identifier for the batch processing run that created this segment membership record, if applicable. Null for real-time or manual assignments. Used for troubleshooting, reprocessing, and audit trail of bulk segment updates.',
    `assignment_method` STRING COMMENT 'The mechanism by which the player was assigned to this segment. Rule-based assignments use predefined business logic, manual assignments are curator-driven, ML-model assignments use predictive algorithms, API-trigger assignments come from external systems, batch-process assignments occur during scheduled ETL runs, and real-time-event assignments happen during live gameplay or transaction events.. Valid values are `rule_based|manual|ml_model|api_trigger|batch_process|real_time_event`',
    `assignment_reason` STRING COMMENT 'Business justification or rule description explaining why the player was assigned to this segment. May contain rule identifiers, campaign names, or free-text explanations for manual assignments. Supports transparency and auditability of segmentation decisions.',
    `assignment_source` STRING COMMENT 'The system, process, or user that initiated this segment assignment. Examples include system names (GameAnalytics, Amplitude, internal segmentation engine), batch job identifiers, or user IDs for manual assignments. Provides audit trail for segment membership origin.',
    `assignment_timestamp` TIMESTAMP COMMENT 'The exact date and time when the player was assigned to this segment. Critical for point-in-time segment membership queries, cohort analysis, and retention campaign execution. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `churn_risk_score` DECIMAL(18,2) COMMENT 'Predicted probability (0.0000 to 1.0000) that the player will churn within the next 30 days, calculated at the time of segment assignment. Higher scores indicate higher churn risk. Used for proactive retention targeting and at-risk player segments.',
    `confidence_score` DECIMAL(18,2) COMMENT 'Confidence or probability score (0.0000 to 1.0000) assigned by ML models or rule engines indicating the certainty of this segment assignment. Higher scores indicate stronger confidence. Null for manual or deterministic assignments. Used for segment quality assessment and threshold-based filtering.',
    `consent_status` STRING COMMENT 'Player consent status for being included in this segment and receiving segment-targeted communications or offers. Granted indicates explicit consent, denied indicates opt-out, not_required indicates consent is not needed for this segment type, pending indicates consent request is outstanding. Critical for GDPR and COPPA compliance.. Valid values are `granted|denied|not_required|pending`',
    `consent_timestamp` TIMESTAMP COMMENT 'Date and time when the player granted or denied consent for this segment membership. Null if consent is not required. Required for regulatory audit trails under GDPR and COPPA. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp recording when this segment membership record was first created in the data platform. Distinct from assignment_timestamp which reflects the business event time. Used for data lineage and audit purposes. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `days_since_last_session` STRING COMMENT 'Number of days since the players last gameplay session at the time of segment assignment. Captured as a snapshot to understand recency patterns within segments. Critical for lapsed player segments and reactivation campaigns.',
    `effective_end_date` DATE COMMENT 'The date on which this segment membership ceases to be active for business purposes. Null indicates an ongoing membership. Format: yyyy-MM-dd.',
    `effective_start_date` DATE COMMENT 'The date from which this segment membership becomes active for business purposes. May differ from assignment_timestamp if the segment is scheduled to activate in the future. Format: yyyy-MM-dd.',
    `engagement_score` DECIMAL(18,2) COMMENT 'Composite engagement score (0.00 to 100.00) calculated at the time of segment assignment. Combines metrics such as DAU, session length, feature usage, and social interactions. Provides a snapshot of player engagement level for segment quality validation.',
    `exclusion_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this player should be excluded from segment-targeted campaigns despite meeting segment criteria. True indicates exclusion (e.g., VIP player, employee account, test account, player request). Used to override automated segment assignments for special cases.',
    `exclusion_reason` STRING COMMENT 'Free-text explanation for why the player is excluded from segment-targeted activities when exclusion_flag is True. Examples include VIP status, employee account, test account, player opt-out request, regulatory restriction. Null when exclusion_flag is False.',
    `expiry_timestamp` TIMESTAMP COMMENT 'The date and time when this segment membership expires or was terminated. Null indicates an active, ongoing membership. Used to track segment transitions and historical membership periods. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `geo_region` STRING COMMENT 'Geographic region or market for which this segment membership is relevant. Uses 3-letter ISO country codes (USA, GBR, JPN) or regional groupings. Null indicates global segment. Supports geo-targeted campaigns and regional player behavior analysis.',
    `is_current` BOOLEAN COMMENT 'Boolean flag indicating whether this is the current active segment membership record for this player-segment combination. True for active memberships, False for historical records. Enables efficient queries for current segment state without date filtering.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp recording when this segment membership record was last updated. Used to track changes to membership status, expiry dates, or other mutable fields. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `ltv_estimate` DECIMAL(18,2) COMMENT 'Estimated lifetime value of the player in USD at the time of segment assignment. Captured as a snapshot to track how LTV estimates evolve as players move between segments. Used for high-value player identification and retention investment decisions.',
    `membership_status` STRING COMMENT 'Current lifecycle status of this segment membership. Active memberships are in effect, expired memberships have passed their end date, suspended memberships are temporarily inactive, revoked memberships were manually terminated, and pending memberships are scheduled for future activation.. Valid values are `active|expired|suspended|revoked|pending`',
    `model_version` STRING COMMENT 'Version identifier of the ML model used for assignment, if assignment_method is ml_model. Null for non-ML assignments. Enables tracking of model performance and segment quality over time as models are retrained and updated.',
    `notes` STRING COMMENT 'Free-text field for additional context, comments, or metadata about this segment membership. Used by analysts and campaign managers to document special circumstances, manual overrides, or observations about segment behavior.',
    `priority_rank` STRING COMMENT 'Numeric priority ranking when a player belongs to multiple segments simultaneously. Lower numbers indicate higher priority. Used by live-ops and marketing systems to determine which segment-specific content or offers to present when conflicts arise.',
    `segment_entry_event` STRING COMMENT 'The specific player behavior, transaction, or milestone event that triggered entry into this segment. Examples include first_purchase, 7_day_inactive, level_50_reached, high_spender_threshold_crossed. Provides behavioral context for segment transitions.',
    `segment_exit_event` STRING COMMENT 'The specific player behavior, transaction, or milestone event that triggered exit from this segment. Examples include returned_to_active, subscription_cancelled, moved_to_whale_segment. Null for active memberships. Tracks segment transition patterns.',
    `segment_tenure_days` STRING COMMENT 'Number of days the player has been continuously assigned to this segment. Calculated as the difference between current date and effective_start_date. Used to identify long-term segment residents and track segment stability.',
    `target_platform` STRING COMMENT 'The gaming platform for which this segment membership is relevant. Console includes PlayStation, Xbox, Nintendo; PC includes Steam, Epic Games Store; mobile includes iOS and Android; cross-platform indicates segment applies across all platforms. Enables platform-specific segmentation strategies.. Valid values are `console|pc|mobile|cross_platform`',
    `total_spend_to_date` DECIMAL(18,2) COMMENT 'Cumulative amount in USD that the player has spent across all in-app purchases, microtransactions, and subscriptions at the time of segment assignment. Snapshot value used for spend-based segmentation (whale, dolphin, minnow, free-to-play).',
    CONSTRAINT pk_segment_membership PRIMARY KEY(`segment_membership_id`)
) COMMENT 'Association table recording which players belong to which segments at any point in time. Stores player account reference, segment reference, assignment method (rule-based, manual, ML-model), assignment timestamp, expiry timestamp, and is_current flag. Enables point-in-time segment membership queries for cohort analysis, live-ops targeting, and retention campaign execution. Tracks segment transitions (e.g., player moved from active to lapsed segment) as separate rows for historical accuracy.';

CREATE OR REPLACE TABLE `gaming_ecm`.`player`.`session` (
    `session_id` BIGINT COMMENT 'Unique identifier for the gameplay session. Primary key.',
    `device_id` BIGINT COMMENT 'Reference to the specific device used for this session.',
    `game_server_id` BIGINT COMMENT 'Foreign key linking to infrastructure.game_server. Business justification: Player sessions occur on specific game servers. This is a fundamental operational link for session tracking, performance analysis, and incident correlation. Enables answering questions like which ser',
    `game_title_id` BIGINT COMMENT 'Reference to the game title played during this session.',
    `network_region_id` BIGINT COMMENT 'Foreign key linking to infrastructure.network_region. Business justification: Sessions are hosted in specific network regions for latency optimization, data residency compliance, and capacity planning. Operations teams analyze session distribution across regions to balance load',
    `player_account_id` BIGINT COMMENT 'Reference to the player who initiated this session. Links to the player master entity.',
    `storefront_id` BIGINT COMMENT 'Reference to the platform on which the session was played (console, PC, mobile).',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: QA and development teams conduct playtesting sessions that must be distinguished from organic player sessions for analytics accuracy. Linking sessions to the testing employee enables bug attribution, ',
    `ab_test_variant` STRING COMMENT 'The A/B test or experiment variant assigned to the player during this session. Used for feature testing and optimization analysis.',
    `attribution_source` STRING COMMENT 'The marketing attribution source that led to this players acquisition (e.g., organic, paid ad campaign, influencer). Sourced from AppsFlyer or Adjust. Used for CPI (Cost Per Install) and ROAS (Return on Ad Spend) analysis.',
    `average_fps` DECIMAL(18,2) COMMENT 'The average frames per second experienced during the session. FPS is a key performance indicator for game rendering quality and player experience. Low FPS indicates performance issues.',
    `average_latency_ms` STRING COMMENT 'The average network latency in milliseconds experienced during the session. High latency negatively impacts player experience, especially in real-time multiplayer games.',
    `ccu_bucket` STRING COMMENT 'The concurrent user count bucket at the time this session started. CCU represents the number of players actively playing at the same time. Used for server capacity planning and peak load analysis.. Valid values are `0-100|101-500|501-1000|1001-5000|5001-10000|10000+`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this session record was first created in the analytics system. Used for data lineage and audit trail.',
    `data_source` STRING COMMENT 'The source system that captured and transmitted this session event (GameAnalytics, Amplitude, Unity Analytics, Unreal Engine telemetry, or custom instrumentation). Used for data quality and reconciliation.. Valid values are `gameanalytics|amplitude|unity|unreal|custom`',
    `disconnect_reason` STRING COMMENT 'The reason the session ended. Normal indicates player-initiated logout. Other values indicate technical or administrative disconnections. Used for quality assurance and player experience analysis. [ENUM-REF-CANDIDATE: normal|timeout|crash|network_error|kicked|banned|server_shutdown — 7 candidates stripped; promote to reference product]',
    `duration_seconds` STRING COMMENT 'Total duration of the gameplay session measured in seconds. Calculated as the difference between session end and start timestamps. Key metric for session length KPI (Key Performance Indicator) and engagement analysis.',
    `end_timestamp` TIMESTAMP COMMENT 'The exact date and time when the player ended or disconnected from the gameplay session. Null if session is still active.',
    `event_count` STRING COMMENT 'Total number of tracked in-game events (achievements, level completions, item pickups, etc.) that occurred during this session. Used for engagement depth analysis.',
    `game_version` STRING COMMENT 'The specific version or build number of the game title that was active during this session. Used for version-based analytics and quality assurance tracking.',
    `ip_address` STRING COMMENT 'The IP address from which the player connected to the game session. Used for geolocation analysis and security monitoring.',
    `is_cross_platform` BOOLEAN COMMENT 'Boolean flag indicating whether this session involved players from multiple platforms (cross-play). Used for cross-platform engagement analysis.',
    `is_first_session` BOOLEAN COMMENT 'Boolean flag indicating whether this is the players first-ever session with this game title. Used for FTUE (First-Time User Experience) analysis and D1 (Day 1) retention tracking.',
    `is_tutorial_completed` BOOLEAN COMMENT 'Boolean flag indicating whether the player completed the tutorial during this session. Used for onboarding funnel analysis.',
    `matchmaking_wait_seconds` STRING COMMENT 'The time in seconds the player waited in matchmaking queue before the session started. Null for non-matchmaking sessions. Used for matchmaking efficiency analysis.',
    `mtx_transaction_count` STRING COMMENT 'The number of microtransaction purchases made during this session. Used for conversion rate and monetization funnel analysis.',
    `party_size` STRING COMMENT 'The number of players in the party or group at session start. 1 indicates solo play. Used for social play pattern analysis.',
    `quality_score` DECIMAL(18,2) COMMENT 'A composite quality score (0-100) calculated from FPS, latency, and other technical metrics. Used to assess overall session experience quality.',
    `revenue_usd` DECIMAL(18,2) COMMENT 'Total revenue generated during this session from MTX (Microtransactions), IAP (In-App Purchases), or other monetization events. Measured in US dollars. Used for ARPU (Average Revenue Per User) and ARPPU (Average Revenue Per Paying User) calculations.',
    `sdk_version` STRING COMMENT 'The version of the game SDK or analytics SDK used to capture this session data. Used for data quality and version compatibility tracking.',
    `session_type` STRING COMMENT 'The gameplay mode or type of session. FTUE (First-Time User Experience) indicates onboarding sessions. PvP (Player versus Player) and PvE (Player versus Environment) indicate competitive modes. [ENUM-REF-CANDIDATE: matchmaking|solo|co-op|pvp|pve|tutorial|ftue|practice|ranked|casual — 10 candidates stripped; promote to reference product]',
    `start_timestamp` TIMESTAMP COMMENT 'The exact date and time when the player initiated the gameplay session. Primary business event timestamp for session lifecycle. Used for DAU (Daily Active Users), WAU (Weekly Active Users), and MAU (Monthly Active Users) calculations.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this session record was last updated in the analytics system. Used for data lineage and audit trail.',
    CONSTRAINT pk_session PRIMARY KEY(`session_id`)
) COMMENT 'Records individual player gameplay sessions as discrete business events. Stores session start timestamp, session end timestamp, session duration (seconds), platform, game title reference, game version, session type (matchmaking, solo, co-op, tutorial, FTUE), device reference, IP geolocation (country/region), CCU bucket at session start, disconnect reason, and session quality indicators (average FPS, latency ms). The foundational event entity for DAU/WAU/MAU calculations, D1/D7/D30 retention, and session length KPIs. Sourced from GameAnalytics/Amplitude event streams.';

CREATE OR REPLACE TABLE `gaming_ecm`.`player`.`engagement_metric` (
    `engagement_metric_id` BIGINT COMMENT 'Unique identifier for the engagement metric record. Primary key for this operational engagement snapshot.',
    `player_account_id` BIGINT COMMENT 'Reference to the player for whom this engagement metric snapshot was recorded. Links to the authoritative player identity in the Player domain.',
    `achievement_unlock_count` STRING COMMENT 'Number of achievements or trophies the player unlocked during the metric period. Measures progression and goal-oriented engagement.',
    `average_session_length_minutes` DECIMAL(18,2) COMMENT 'Mean duration of gameplay sessions in minutes during the metric period. Calculated as total playtime divided by session count.',
    `churn_risk_score` DECIMAL(18,2) COMMENT 'Predictive score (0-100) indicating the likelihood of player churn within the next 7 days. Calculated from engagement patterns, session frequency, and days since last session.',
    `cohort_identifier` STRING COMMENT 'Identifier for the player cohort to which this player belongs, typically based on registration date or acquisition campaign. Used for cohort-based retention and LTV analysis.',
    `days_since_last_session` STRING COMMENT 'Number of calendar days elapsed since the players most recent session prior to this metric date. Used for churn risk assessment and re-engagement targeting.',
    `engagement_score` DECIMAL(18,2) COMMENT 'Composite engagement score calculated from session frequency, playtime, and retention metrics. Normalized 0-100 scale for player segmentation and lifecycle management.',
    `engagement_tier` STRING COMMENT 'Categorical segmentation of player engagement level. Whale = high-value highly engaged; Core = regular engaged; Casual = occasional; Dormant = at-risk; Churned = inactive; New = first-time.. Valid values are `whale|core|casual|dormant|churned|new`',
    `first_session_date` DATE COMMENT 'The date of the players very first session across all platforms and titles. Anchors all retention calculations (D1, D7, D30).',
    `ftue_completed` BOOLEAN COMMENT 'Boolean flag indicating whether the player has completed the First-Time User Experience tutorial or onboarding flow. Critical for retention analysis.',
    `game_titles_played_count` STRING COMMENT 'Number of distinct game titles the player engaged with during the metric period. Measures cross-title engagement for multi-game publishers.',
    `in_game_event_participation_count` STRING COMMENT 'Number of live in-game events (seasonal events, limited-time modes, tournaments) the player participated in during the metric period. Measures live-ops engagement.',
    `is_d1_retained` BOOLEAN COMMENT 'Boolean flag indicating whether the player returned on the day after their first session (D1 retention). Critical metric for First-Time User Experience (FTUE) effectiveness.',
    `is_d30_retained` BOOLEAN COMMENT 'Boolean flag indicating whether the player was active 30 days after their first session (D30 retention). Measures long-term player retention and game stickiness.',
    `is_d7_retained` BOOLEAN COMMENT 'Boolean flag indicating whether the player was active 7 days after their first session (D7 retention). Key indicator of early player lifecycle health.',
    `is_dau` BOOLEAN COMMENT 'Boolean flag indicating whether the player was active on this metric date. True if the player had at least one session during the day.',
    `is_mau` BOOLEAN COMMENT 'Boolean flag indicating whether the player was active during the month containing this metric date. True if the player had at least one session during the 30-day period.',
    `is_wau` BOOLEAN COMMENT 'Boolean flag indicating whether the player was active during the week containing this metric date. True if the player had at least one session during the 7-day period.',
    `last_session_timestamp` TIMESTAMP COMMENT 'Timestamp of the players most recent session end as of this metric date. Used for real-time churn prediction and re-engagement workflows.',
    `lifecycle_stage` STRING COMMENT 'Current stage in the player lifecycle journey. Onboarding = new player in FTUE; Active = regular player; Engaged = highly active; At-risk = declining engagement; Churned = inactive; Reactivated = returned after churn.. Valid values are `onboarding|active|engaged|at_risk|churned|reactivated`',
    `login_streak_days` STRING COMMENT 'Number of consecutive days the player has logged in as of this metric date. Used for streak-based rewards and engagement incentives.',
    `metric_date` DATE COMMENT 'The calendar date for which this engagement metric snapshot was calculated. Represents the business event date for the engagement measurement period.',
    `metric_grain` STRING COMMENT 'The aggregation period for this engagement metric snapshot. Indicates whether this record represents daily, weekly, or monthly engagement data.. Valid values are `daily|weekly|monthly`',
    `peak_ccu_contribution` BOOLEAN COMMENT 'Boolean flag indicating whether the player was online during the peak concurrent user period for this metric date. Used for capacity planning and live-ops scheduling.',
    `primary_platform` STRING COMMENT 'The platform on which the player spent the majority of their playtime during the metric period. Used for platform-specific engagement analysis.. Valid values are `console|pc|mobile|web`',
    `pve_session_count` STRING COMMENT 'Number of PvE cooperative or solo gameplay sessions the player completed during the metric period. Measures single-player or co-op engagement.',
    `pvp_match_count` STRING COMMENT 'Number of PvP competitive matches the player participated in during the metric period. Measures competitive engagement.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this engagement metric record was first created in the lakehouse. Used for data lineage and audit trail.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this engagement metric record was last updated in the lakehouse. Used for change tracking and data freshness monitoring.',
    `session_count` STRING COMMENT 'Total number of distinct gameplay sessions the player initiated during the metric period. A session is defined as a continuous period of player activity.',
    `social_interaction_count` STRING COMMENT 'Number of social interactions (friend invites, guild joins, chat messages, co-op sessions) the player initiated during the metric period. Measures social engagement.',
    `source_system` STRING COMMENT 'The analytics platform or system of record from which this engagement metric snapshot was sourced (e.g., GameAnalytics, Amplitude, internal telemetry).',
    `total_playtime_minutes` DECIMAL(18,2) COMMENT 'Cumulative playtime in minutes across all sessions during the metric period. Measures total player engagement duration.',
    `ugc_contribution_count` STRING COMMENT 'Number of user-generated content items (levels, mods, skins, replays) the player created or published during the metric period. Measures creative engagement.',
    CONSTRAINT pk_engagement_metric PRIMARY KEY(`engagement_metric_id`)
) COMMENT 'Daily/weekly/monthly pre-aggregated engagement metric snapshots per player, serving as the Silver Layer operational record for retention and engagement tracking. Stores metric date, metric grain (daily/weekly/monthly), DAU flag, WAU flag, MAU flag, session count, total playtime minutes, days_since_last_session, D1/D7/D30 retention flags, login streak, and game titles played count. This is NOT an analytics product — it is the operational engagement record that feeds live-ops, player support, and lifecycle management workflows. Sourced from GameAnalytics/Amplitude cohort outputs.';

CREATE OR REPLACE TABLE `gaming_ecm`.`player`.`ltv_record` (
    `ltv_record_id` BIGINT COMMENT 'Unique identifier for the LTV record. Primary key.',
    `game_title_id` BIGINT COMMENT 'Foreign key reference to the specific game title for which this LTV record applies. Enables per-game LTV tracking in multi-title portfolios.',
    `player_account_id` BIGINT COMMENT 'Foreign key reference to the player for whom this LTV record is calculated.',
    `acquisition_channel` STRING COMMENT 'Marketing channel through which this player was originally acquired. Used to calculate channel-specific LTV and ROAS (Return on Ad Spend). [ENUM-REF-CANDIDATE: organic|paid-social|paid-search|influencer|referral|app-store|cross-promotion|unknown — 8 candidates stripped; promote to reference product]',
    `arpu_contribution` DECIMAL(18,2) COMMENT 'This players contribution to the overall ARPU metric, calculated as total spend divided by days since registration. Used for cohort analysis and player value benchmarking.',
    `average_transaction_value` DECIMAL(18,2) COMMENT 'Average monetary value per In-App Purchase transaction for this player, calculated as total_iap_spend divided by total_iap_count. Null for non-payers.',
    `calculation_date` DATE COMMENT 'The date on which this LTV calculation was performed. Represents the snapshot date for this LTV record.',
    `churn_risk_score` DECIMAL(18,2) COMMENT 'Predictive score (0.0000 to 1.0000) indicating the likelihood that this player will churn (stop playing or spending) within the next 30 days. Higher scores indicate higher churn risk. Used for proactive retention interventions.',
    `cohort_month` STRING COMMENT 'Year-month (YYYY-MM) when the player first registered. Used for cohort-based LTV analysis and retention tracking.. Valid values are `^[0-9]{4}-[0-9]{2}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this LTV record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary values in this record (e.g., USD, EUR, GBP). Ensures consistent currency interpretation across multi-region operations.. Valid values are `^[A-Z]{3}$`',
    `data_source` STRING COMMENT 'Source system from which the LTV calculation data was derived. GameAnalytics and Amplitude are primary player behavior analytics platforms; internal-billing refers to first-party transaction systems.. Valid values are `GameAnalytics|Amplitude|internal-billing|hybrid`',
    `days_since_first_purchase` STRING COMMENT 'Number of days elapsed between the players first purchase date and the calculation date. Null for non-payers. Used for payer lifecycle analysis.',
    `days_since_last_purchase` STRING COMMENT 'Number of days elapsed between the players last purchase date and the calculation date. Null for non-payers. Used to identify at-risk payers and trigger win-back campaigns.',
    `first_purchase_date` DATE COMMENT 'The date of the players first In-App Purchase (IAP). Null for non-payers. Used to calculate time-to-first-purchase and conversion funnel metrics.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this player is currently active (has played within the last 30 days as of calculation date). Used to filter active vs dormant player LTV.',
    `is_paying_user` BOOLEAN COMMENT 'Boolean flag indicating whether this player has made at least one In-App Purchase (IAP). True if the player is a payer, False if non-payer.',
    `last_purchase_date` DATE COMMENT 'The date of the players most recent In-App Purchase (IAP). Null for non-payers. Used to identify dormant payers and trigger re-engagement campaigns.',
    `ltv_segment` STRING COMMENT 'Business segment classification based on LTV predictions and engagement patterns. Used for targeted marketing campaigns and personalized offers.. Valid values are `high-value|medium-value|low-value|at-risk|dormant|new`',
    `model_version` STRING COMMENT 'Version identifier of the LTV prediction model used for this calculation (e.g., v1.0, v2.3.1). Enables tracking of model evolution and A/B testing.. Valid values are `^v[0-9]+.[0-9]+(.[0-9]+)?$`',
    `payer_tier` STRING COMMENT 'Classification of the player into spending tiers based on cumulative spend thresholds. Whale: high-value spender (top 1-5%), Dolphin: moderate spender, Minnow: low-value spender, Non-payer: no purchases.. Valid values are `whale|dolphin|minnow|non-payer`',
    `platform` STRING COMMENT 'Primary gaming platform on which this players LTV was calculated. Console includes PlayStation, Xbox, Nintendo; PC includes Steam, Epic; Mobile includes iOS and Android.. Valid values are `console|pc|mobile|cross-platform`',
    `predicted_ltv_180d` DECIMAL(18,2) COMMENT 'Predicted total revenue from this player over the next 180 days, calculated using the LTV model. Used for medium-term revenue forecasting and marketing ROI analysis.',
    `predicted_ltv_365d` DECIMAL(18,2) COMMENT 'Predicted total revenue from this player over the next 365 days, calculated using the LTV model. Used for annual revenue forecasting and long-term player value assessment.',
    `predicted_ltv_90d` DECIMAL(18,2) COMMENT 'Predicted total revenue from this player over the next 90 days, calculated using the LTV model. Used for short-term revenue forecasting and player segmentation.',
    `realized_ltv` DECIMAL(18,2) COMMENT 'Cumulative actual spend by this player from registration to the calculation date. Represents the historical revenue contribution of the player.',
    `total_iap_count` STRING COMMENT 'Total number of In-App Purchase transactions made by this player from registration to calculation date. Used for purchase frequency analysis.',
    `total_iap_spend` DECIMAL(18,2) COMMENT 'Cumulative monetary value of all In-App Purchases made by this player from registration to calculation date. Equivalent to realized_ltv but explicitly sourced from IAP transactions.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this LTV record was last updated. Used for audit trail and incremental data processing.',
    CONSTRAINT pk_ltv_record PRIMARY KEY(`ltv_record_id`)
) COMMENT 'Stores the current and historical Lifetime Value (LTV) calculations per player, serving as the operational LTV record for player lifecycle management, spend tier classification, and churn intervention triggers. Stores LTV calculation date, LTV model version, predicted LTV (90-day, 180-day, 365-day), realized LTV (cumulative actual spend), ARPU contribution, ARPPU flag, payer tier (whale/dolphin/minnow/non-payer), first purchase date, last purchase date, total IAP count, and total IAP spend. Sourced from billing domain transaction feeds and GameAnalytics/Amplitude.';

CREATE OR REPLACE TABLE `gaming_ecm`.`player`.`player_lifecycle_event` (
    `player_lifecycle_event_id` BIGINT COMMENT 'Unique identifier for the player lifecycle event record. Primary key for the immutable event log.',
    `device_id` BIGINT COMMENT 'Unique identifier for the device from which the event was triggered (e.g., console serial, mobile IDFA/GAID, browser fingerprint). Used for fraud detection and device-level analytics.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title in which the event occurred, if applicable. Null for account-level events not tied to a specific game.',
    `marketing_campaign_id` BIGINT COMMENT 'Reference to the marketing or retention campaign that triggered or influenced this event, if applicable (e.g., reactivation email campaign, in-game event promotion).',
    `parental_control_id` BIGINT COMMENT 'Reference to the parental consent record associated with this event, if applicable (for COPPA-compliant child accounts).',
    `player_account_id` BIGINT COMMENT 'Reference to the player who triggered or is the subject of this lifecycle or authentication event.',
    `session_id` BIGINT COMMENT 'Unique identifier for the player session during which this event occurred. Used to correlate multiple events within a single play session.',
    `telemetry_pipeline_id` BIGINT COMMENT 'Identifier for the ETL (Extract, Transform, Load) batch or streaming job that ingested this event record into the lakehouse.',
    `attribution_source` STRING COMMENT 'The marketing attribution source for this event (e.g., organic, paid_search, social_media, influencer, referral). Populated for acquisition and reactivation events.',
    `authentication_method` STRING COMMENT 'The method used to authenticate the player for this event: password (username/password), oauth (third-party OAuth provider), sso (single sign-on), biometric (fingerprint, face recognition), mfa (multi-factor authentication), token (session token refresh).. Valid values are `password|oauth|sso|biometric|mfa|token`',
    `authentication_provider` STRING COMMENT 'The identity provider used for authentication (e.g., internal, Google, Facebook, Apple, Steam, Epic Games, Xbox Live, PlayStation Network).',
    `consent_version` STRING COMMENT 'The version identifier of the terms of service, privacy policy, or parental consent document that was in effect at the time of the event (e.g., TOS-2024-01, GDPR-Consent-v3).',
    `coppa_protected_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) marking whether the player was subject to COPPA protections (under age 13 in the US) at the time of the event.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this event record was first inserted into the data platform (audit timestamp). Distinct from event_timestamp, which is the business event time.',
    `days_since_previous_event` STRING COMMENT 'The number of calendar days elapsed between this event and the previous event for this player. Used for retention and reactivation analysis.',
    `event_metadata_payload` STRING COMMENT 'JSON-formatted string containing additional event-specific metadata and context that does not fit into structured columns (e.g., custom event properties, extended attributes, diagnostic data).',
    `event_source_system` STRING COMMENT 'The name or identifier of the system that emitted or recorded this event (e.g., authentication service, Salesforce CRM, platform SDK, game client).',
    `event_timestamp` TIMESTAMP COMMENT 'The precise date and time when the lifecycle or authentication event occurred in the real world, recorded in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). This is the business event time, distinct from audit timestamps.',
    `event_type` STRING COMMENT 'Discriminator for the kind of lifecycle or authentication event. Lifecycle event types: account_registered, email_verified, age_verified, first_login, ftue_completed, first_purchase, reactivated, churned, suspended, banned, account_deleted, gdpr_erasure_requested, parental_consent_granted, parental_consent_revoked. Authentication event types: login_success, login_failure, logout, password_reset, mfa_challenge, session_token_refresh. [ENUM-REF-CANDIDATE: account_registered|email_verified|age_verified|first_login|ftue_completed|first_purchase|reactivated|churned|suspended|banned|account_deleted|gdpr_erasure_requested|parental_consent_granted|parental_consent_revoked|login_success|login_failure|logout|password_reset|mfa_challenge|session_token_refresh — promote to reference product]. Valid values are `account_registered|email_verified|age_verified|first_login|ftue_completed|first_purchase`',
    `failure_reason` STRING COMMENT 'For failed authentication events (login_failure, mfa_challenge failure), the reason code or message explaining why the authentication failed (e.g., invalid_credentials, account_locked, mfa_timeout, network_error).',
    `game_version` STRING COMMENT 'The version or build number of the game client from which the event was triggered (e.g., 1.2.3, 2024.03.15-hotfix).',
    `gdpr_consent_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) marking whether the player had active GDPR consent at the time of the event.',
    `geolocation_city` STRING COMMENT 'The city derived from the IP address at the time of the event.',
    `geolocation_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code derived from the IP address at the time of the event (e.g., USA, GBR, JPN).. Valid values are `^[A-Z]{3}$`',
    `geolocation_region` STRING COMMENT 'The region, state, or province derived from the IP address at the time of the event (e.g., California, Ontario, Bavaria).',
    `ip_address` STRING COMMENT 'The Internet Protocol (IP) address from which the event originated. Used for geolocation, fraud detection, and security investigation.',
    `platform` STRING COMMENT 'The gaming platform on which the event occurred: console (PlayStation, Xbox, Nintendo), PC (Windows, Mac, Linux), mobile (iOS, Android), web, VR (Virtual Reality), AR (Augmented Reality).. Valid values are `console|pc|mobile|web|vr|ar`',
    `previous_event_timestamp` TIMESTAMP COMMENT 'The timestamp of the previous lifecycle or authentication event for this player, used to calculate time-between-events and detect anomalies.',
    `referrer_url` STRING COMMENT 'The HTTP referrer URL from which the player navigated to trigger this event, if applicable (for web-based events).',
    `risk_score` DECIMAL(18,2) COMMENT 'Numeric risk score (0.00 to 100.00) assigned by fraud detection or security systems at the time of the event. Higher scores indicate higher risk of fraudulent or malicious activity.',
    `sdk_version` STRING COMMENT 'The version of the platform SDK (Software Development Kit) or authentication SDK used by the game client at the time of the event.',
    `suspicious_activity_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) marking whether this event was flagged by fraud detection or security systems as potentially suspicious or anomalous.',
    `triggering_context` STRING COMMENT 'Free-text description of the business context or user action that triggered this event (e.g., player completed tutorial level 5, player clicked purchase button, automated churn detection job).',
    `user_agent` STRING COMMENT 'The user agent string from the HTTP request header, identifying the browser, operating system, and device type for web-based events.',
    CONSTRAINT pk_player_lifecycle_event PRIMARY KEY(`player_lifecycle_event_id`)
) COMMENT 'Immutable event log and SINGLE authoritative source for all discrete player lifecycle milestones and authentication/security events, serving as the unified audit trail for the player domain. Lifecycle event types: account_registered, email_verified, age_verified, first_login, ftue_completed, first_purchase, reactivated, churned, suspended, banned, account_deleted, gdpr_erasure_requested, parental_consent_granted, parental_consent_revoked. Authentication event types: login_success, login_failure, logout, password_reset, mfa_challenge, session_token_refresh. Stores event type, event timestamp, event source system, platform, device reference, IP address, geolocation, authentication method, failure reason, suspicious_activity_flag, triggering context, and event metadata payload. This is the ONLY product in the player domain that records authentication events — no other product duplicates this responsibility. Serves GDPR/COPPA compliance, fraud detection, account security investigation, and lifecycle funnel analysis. Sourced from authentication services, platform SDK callbacks, and Salesforce CRM.';

CREATE OR REPLACE TABLE `gaming_ecm`.`player`.`ban_record` (
    `ban_record_id` BIGINT COMMENT 'Unique identifier for the ban record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the trust & safety agent or automated system that issued the ban. May be employee ID for manual reviews or system identifier for automated actions.',
    `game_title_id` BIGINT COMMENT 'Identifier of the game title where the violation occurred and the ban was issued. Links to the game title master record.',
    `player_account_id` BIGINT COMMENT 'Identifier of the player who received the enforcement action. Links to the player master record.',
    `appeal_resolution_notes` STRING COMMENT 'Internal notes documenting the appeal review decision, evidence considered, and rationale for approval or denial.',
    `appeal_reviewed_by` STRING COMMENT 'Identifier of the trust & safety agent who reviewed the appeal. Employee ID or agent identifier.',
    `appeal_reviewed_timestamp` TIMESTAMP COMMENT 'Date and time when the appeal review was completed. Null if appeal has not been reviewed.',
    `appeal_status` STRING COMMENT 'Current status of the appeal process: not_appealed (no appeal submitted), pending (appeal received, awaiting review), under_review (trust & safety team reviewing), approved (ban overturned), denied (ban upheld).. Valid values are `not_appealed|pending|under_review|approved|denied`',
    `appeal_submitted_flag` BOOLEAN COMMENT 'Indicates whether the player has submitted an appeal for this ban. True if appeal exists, False otherwise.',
    `appeal_submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the player submitted an appeal for this ban. Null if no appeal has been submitted.',
    `automated_detection_confidence` DECIMAL(18,2) COMMENT 'Confidence score (0.00 to 100.00) from automated detection systems (anti-cheat, fraud detection) indicating certainty of the violation. Null for manual reviews.',
    `ban_duration_days` STRING COMMENT 'Duration of the ban in days. Null for permanent bans. Used for temporary suspensions and competitive cooldowns.',
    `ban_end_timestamp` TIMESTAMP COMMENT 'Date and time when the ban is scheduled to expire. Null for permanent bans or bans with indefinite duration.',
    `ban_number` STRING COMMENT 'Externally-visible unique ban identifier used in player communications and appeals. Format: BAN-XXXXXXXXXX.. Valid values are `^BAN-[0-9]{10}$`',
    `ban_reason_category` STRING COMMENT 'High-level category of the violation that triggered the ban: cheating/exploiting (use of unauthorized software, game exploits), harassment/toxicity (abusive behavior, hate speech), TOS violation (terms of service breach), payment fraud (chargeback fraud, stolen payment methods), COPPA violation (underage account without parental consent), account sharing (credential sharing, account trading).. Valid values are `cheating_exploiting|harassment_toxicity|tos_violation|payment_fraud|coppa_violation|account_sharing`',
    `ban_reason_detail` STRING COMMENT 'Detailed explanation of the specific violation or behavior that led to the enforcement action. May include evidence references, incident IDs, or rule citations.',
    `ban_start_timestamp` TIMESTAMP COMMENT 'Date and time when the ban was issued and enforcement began. Represents the principal business event timestamp for this enforcement action.',
    `ban_status` STRING COMMENT 'Current lifecycle status of the ban: active (currently enforced), expired (time-limited ban that has ended), appealed (player has submitted an appeal), overturned (ban reversed after review), pending_review (under trust & safety investigation).. Valid values are `active|expired|appealed|overturned|pending_review`',
    `ban_type` STRING COMMENT 'Type of enforcement action applied: temporary suspension (time-limited account suspension), permanent ban (indefinite account termination), hardware ban (device-level block), IP ban (network-level block), chat restriction (communication privileges revoked), competitive cooldown (ranked play suspension), shadow ban (hidden matchmaking penalty). [ENUM-REF-CANDIDATE: temporary_suspension|permanent_ban|hardware_ban|ip_ban|chat_restriction|competitive_cooldown|shadow_ban — 7 candidates stripped; promote to reference product]',
    `compliance_jurisdiction` STRING COMMENT 'Regulatory jurisdiction governing this ban action (USA, EU, UK, JPN, KOR, CHN, AUS, CAN, BRA, GLOBAL). Determines applicable privacy laws (GDPR, COPPA, CCPA) and data retention policies. [ENUM-REF-CANDIDATE: USA|EU|UK|JPN|KOR|CHN|AUS|CAN|BRA|GLOBAL — 10 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this ban record was first created in the system. Audit trail for record creation.',
    `data_retention_expiry_date` DATE COMMENT 'Date when this ban record is eligible for deletion or anonymization per data retention policies and regulatory requirements. Calculated based on compliance jurisdiction and ban type.',
    `evidence_reference` STRING COMMENT 'Reference identifier or URI to supporting evidence for the ban (anti-cheat logs, chat transcripts, video recordings, player reports). Used for audit and appeal review.',
    `hardware_identifier` STRING COMMENT 'Device hardware identifier (HWID, MAC address, console serial) used for hardware-level bans. Enables enforcement across account changes on the same device.',
    `ip_address` STRING COMMENT 'IP address associated with the player at the time of the violation. Used for IP-level bans and fraud pattern analysis.',
    `issuing_system` STRING COMMENT 'System or process that issued the ban: automated_anticheat (anti-cheat engine detection), manual_trust_safety (human moderator review), platform_enforcement (first-party platform action), community_report_system (player report threshold trigger), payment_fraud_detection (payment system fraud alert).. Valid values are `automated_anticheat|manual_trust_safety|platform_enforcement|community_report_system|payment_fraud_detection`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this ban record was last updated. Audit trail for record modifications (status changes, appeal updates).',
    `notes` STRING COMMENT 'Internal operational notes for trust & safety team. May include investigation details, escalation history, or special handling instructions.',
    `notification_channel` STRING COMMENT 'Channel used to notify the player of the ban: email, in_game (in-game message), platform_message (console/platform notification), sms, push_notification (mobile push).. Valid values are `email|in_game|platform_message|sms|push_notification`',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether the player was notified of the ban via email, in-game message, or platform notification. True if notification sent, False otherwise.',
    `notification_sent_timestamp` TIMESTAMP COMMENT 'Date and time when the ban notification was sent to the player. Null if notification has not been sent.',
    `platform_code` STRING COMMENT 'Platform where the ban was issued: PC, PS5, PS4, XBOX_SERIES, XBOX_ONE, SWITCH, MOBILE_IOS, MOBILE_ANDROID, STEAM, EPIC, CONSOLE_GENERIC. Supports cross-platform enforcement tracking. [ENUM-REF-CANDIDATE: PC|PS5|PS4|XBOX_SERIES|XBOX_ONE|SWITCH|MOBILE_IOS|MOBILE_ANDROID|STEAM|EPIC|CONSOLE_GENERIC — 11 candidates stripped; promote to reference product]',
    `prior_ban_count` STRING COMMENT 'Number of previous bans issued to this player before this enforcement action. Used for progressive discipline and escalation.',
    `repeat_offender_flag` BOOLEAN COMMENT 'Indicates whether this player has prior ban records. True if this is not the first ban, False if first offense. Used for escalation policies.',
    `severity_level` STRING COMMENT 'Severity classification of the violation: low (minor TOS breach), medium (repeated minor violations or single moderate violation), high (serious cheating, harassment), critical (extreme toxicity, fraud, COPPA violation, illegal activity).. Valid values are `low|medium|high|critical`',
    CONSTRAINT pk_ban_record PRIMARY KEY(`ban_record_id`)
) COMMENT 'Authoritative record of all player enforcement actions including temporary suspensions, permanent bans, hardware bans, IP bans, chat restrictions, and competitive cooldowns. Stores ban type, ban reason category (cheating/exploiting, harassment/toxicity, TOS violation, payment fraud, COPPA violation, account sharing), ban start/end timestamps, ban status (active, expired, appealed, overturned), issuing system (automated anti-cheat, manual trust & safety review, platform enforcement), appeal status, and resolution notes. Supports the full enforcement lifecycle: issuance → notification → appeal → review → resolution. Critical for trust & safety operations and platform certification requirements.';

CREATE OR REPLACE TABLE `gaming_ecm`.`player`.`authentication_log` (
    `authentication_log_id` BIGINT COMMENT 'Unique identifier for the authentication event record. Primary key for the authentication log.',
    `device_id` BIGINT COMMENT 'Unique identifier of the device used for authentication. May be console ID, mobile device IMEI, or browser fingerprint. Used for fraud detection and account security.',
    `network_region_id` BIGINT COMMENT 'Foreign key linking to infrastructure.network_region. Business justification: Authentication events occur from geographic locations that map to network regions for fraud detection, compliance auditing, and regional access control enforcement. Security teams analyze authenticati',
    `player_account_id` BIGINT COMMENT 'Unique identifier of the player who initiated the authentication event. Links to the player master record.',
    `session_id` BIGINT COMMENT 'Unique identifier for the player session created upon successful authentication. Used to correlate authentication events with gameplay sessions.',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to platform.storefront. Business justification: Authentication events occur via specific storefronts (Steam login, PSN login, Xbox Live login). Essential for platform-specific security monitoring, fraud detection, and platform holder compliance rep',
    `account_age_days` STRING COMMENT 'Age of the player account in days at the time of authentication. Used for fraud detection and player lifecycle analysis.',
    `age_gate_passed_flag` BOOLEAN COMMENT 'Indicates whether the player passed age verification requirements during authentication. Used for age-restricted content compliance.',
    `api_version` STRING COMMENT 'Version of the authentication API endpoint called. Used for API lifecycle management and deprecation tracking.',
    `authentication_method` STRING COMMENT 'Method used to authenticate the player. Includes password-based, single sign-on, platform-specific tokens, biometric authentication, and third-party OAuth providers. [ENUM-REF-CANDIDATE: password|sso|platform_token|biometric|oauth|steam|epic|psn|xbox_live — 9 candidates stripped; promote to reference product]',
    `client_version` STRING COMMENT 'Version number of the game client or application used for authentication. Used for compatibility tracking and forced update enforcement.',
    `consent_version` STRING COMMENT 'Version of terms of service and privacy policy that the player consented to at the time of authentication. Critical for GDPR and COPPA compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this authentication log record was created in the system. Used for audit trail and data lineage tracking.',
    `event_timestamp` TIMESTAMP COMMENT 'Precise date and time when the authentication event occurred in UTC. Critical for security audit trails and GDPR compliance.',
    `event_type` STRING COMMENT 'Type of authentication event. Distinguishes between successful logins, failed attempts, logouts, password resets, multi-factor authentication challenges, and session token refreshes.. Valid values are `login_success|login_failure|logout|password_reset|mfa_challenge|session_token_refresh`',
    `failure_reason` STRING COMMENT 'Reason for authentication failure if event_type is login_failure. Null for successful events. Used for security monitoring and player support. [ENUM-REF-CANDIDATE: invalid_credentials|account_locked|account_suspended|mfa_failed|token_expired|ip_blocked|device_blocked|maintenance_mode — 8 candidates stripped; promote to reference product]',
    `gdpr_region_flag` BOOLEAN COMMENT 'Indicates whether the authentication originated from a GDPR-regulated region. Triggers additional data protection and consent workflows.',
    `ip_address` STRING COMMENT 'Internet Protocol address from which the authentication request originated. Used for geolocation, fraud detection, and security analysis.',
    `login_attempt_count` STRING COMMENT 'Number of consecutive failed login attempts before this event. Used for account lockout policies and brute force attack detection.',
    `login_duration_ms` STRING COMMENT 'Time taken to complete the authentication process in milliseconds. Used for performance monitoring and user experience optimization.',
    `mfa_method` STRING COMMENT 'Multi-factor authentication method used if MFA was required for this authentication event. None if MFA was not triggered.. Valid values are `sms|email|authenticator_app|hardware_token|none`',
    `mfa_success_flag` BOOLEAN COMMENT 'Indicates whether multi-factor authentication was successfully completed. Null if MFA was not required.',
    `parental_control_flag` BOOLEAN COMMENT 'Indicates whether parental controls were active for this authentication session. Required for COPPA compliance for players under 13.',
    `previous_login_timestamp` TIMESTAMP COMMENT 'Timestamp of the players previous successful login. Used to calculate session gaps and detect unusual login patterns.',
    `referrer_url` STRING COMMENT 'URL of the page or application that referred the player to the authentication flow. Used for marketing attribution and user journey analysis.',
    `risk_score` DECIMAL(18,2) COMMENT 'Calculated risk score for the authentication event based on fraud detection algorithms. Range 0.00 to 100.00, with higher scores indicating greater risk.',
    `sdk_version` STRING COMMENT 'Version of the authentication SDK used by the client application. Used for troubleshooting and compatibility analysis.',
    `suspicious_activity_flag` BOOLEAN COMMENT 'Indicates whether the authentication event was flagged as potentially suspicious by fraud detection algorithms. Triggers security review workflows.',
    `user_agent` STRING COMMENT 'Browser or application user agent string. Provides device type, operating system, and client version information for analytics and compatibility tracking.',
    CONSTRAINT pk_authentication_log PRIMARY KEY(`authentication_log_id`)
) COMMENT 'Business-level authentication event log tracking player login and logout events for security, fraud detection, and compliance purposes. Stores event type (login_success, login_failure, logout, password_reset, mfa_challenge, session_token_refresh), timestamp, platform, device reference, IP address, geolocation (country/region), authentication method (password, SSO, platform token, biometric), failure reason (if applicable), and suspicious_activity_flag. Distinct from IT system access logs — this is the player-facing authentication business record required for GDPR audit trails and account security workflows.';

CREATE OR REPLACE TABLE `gaming_ecm`.`player`.`title_progress` (
    `title_progress_id` BIGINT COMMENT 'Unique identifier for the players progress record within a specific game title. Primary key.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title for which this progress is tracked. Links to the game title master entity.',
    `guild_id` BIGINT COMMENT 'Reference to the guild or clan the player belongs to in this game title. Null if the player is not in a guild.',
    `checkpoint_id` BIGINT COMMENT 'Identifier of the last checkpoint or save point reached by the player in this game title. Used for player support and progress recovery.',
    `player_account_id` BIGINT COMMENT 'Reference to the player who owns this progress record. Links to the player master entity.',
    `battle_pass_id` BIGINT COMMENT 'Reference to the active season pass the player is participating in for this game title. Null if no season pass is active.',
    `storefront_id` BIGINT COMMENT 'Reference to the platform on which this progress was recorded (console, PC, mobile). Links to the platform master entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Employee playtesters accumulate title progress during QA cycles. Tracking which employee owns test progress records enables test coverage analysis ("has every level been tested by QA?"), separates tes',
    `achievement_count` STRING COMMENT 'Total number of achievements or trophies unlocked by the player in this game title.',
    `average_session_length_minutes` DECIMAL(18,2) COMMENT 'Average duration of gameplay sessions in minutes for this player in this title. Key engagement quality metric.',
    `battle_pass_tier` STRING COMMENT 'Current tier or level achieved in the active battle pass for this game title. Null if no battle pass is active.',
    `character_class` STRING COMMENT 'Primary character class or role the player uses in this game title (e.g., Warrior, Mage, Support). Null for titles without class systems.',
    `churn_risk_score` DECIMAL(18,2) COMMENT 'Predictive score (0.00 to 100.00) indicating the likelihood of the player churning from this title. Generated by analytics models for retention campaigns.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of game content completed by the player (0.00 to 100.00). Includes story missions, side quests, collectibles, and achievements.',
    `content_rating` STRING COMMENT 'Age-appropriate content rating for this game title as assigned by governing bodies (ESRB, PEGI, CERO, etc.). Used for compliance and parental controls.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this title progress record was first created in the system. Audit trail for record creation.',
    `current_level` STRING COMMENT 'The players current level or rank within the game title. Represents progression milestone achieved.',
    `d1_retention_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the player returned to play on Day 1 after first session. Critical early retention metric.',
    `d30_retention_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the player returned to play on Day 30 after first session. Long-term retention indicator.',
    `d7_retention_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the player returned to play on Day 7 after first session. Key retention milestone.',
    `difficulty_setting` STRING COMMENT 'Current difficulty level selected by the player for this game title. Used for personalization and challenge balancing.. Valid values are `easy|normal|hard|expert|custom`',
    `experience_points` BIGINT COMMENT 'Total experience points (XP) accumulated by the player in this game title. Used to track progression and unlock rewards.',
    `first_played_timestamp` TIMESTAMP COMMENT 'Timestamp when the player first started playing this game title. Used for cohort analysis and FTUE (First-Time User Experience) tracking.',
    `highest_rank_achieved` STRING COMMENT 'The highest competitive rank or tier the player has achieved in this game title (e.g., Diamond, Master, Legend). Free-form text to accommodate various ranking systems.',
    `in_game_currency_balance` BIGINT COMMENT 'Current balance of the primary in-game virtual currency for this player in this title. Used for virtual economy management.',
    `language_preference` STRING COMMENT 'Preferred language for in-game content and UI for this player in this title. ISO 639-1 two-letter language code.',
    `last_played_timestamp` TIMESTAMP COMMENT 'Timestamp of the players most recent session in this game title. Critical for churn prediction and re-engagement campaigns.',
    `last_purchase_timestamp` TIMESTAMP COMMENT 'Timestamp of the players most recent in-game purchase or microtransaction in this title. Used for monetization analysis.',
    `parental_controls_enabled_flag` BOOLEAN COMMENT 'Boolean flag indicating whether parental controls are active for this player in this game title. Required for COPPA compliance.',
    `playstyle_classification` STRING COMMENT 'Classification of the players dominant playstyle in this title: PvP (Player versus Player), PvE (Player versus Environment), casual, competitive, mixed, or explorer. Used for personalization and matchmaking.. Valid values are `pvp|pve|casual|competitive|mixed|explorer`',
    `premium_currency_balance` BIGINT COMMENT 'Current balance of premium (purchasable) virtual currency for this player in this title. Used for MTX (Microtransactions) tracking.',
    `progress_status` STRING COMMENT 'Current lifecycle status of the players progress in this title. Indicates whether the player is actively playing, has completed, or has abandoned the title.. Valid values are `active|inactive|completed|abandoned|suspended|new`',
    `region_code` STRING COMMENT 'Geographic region or server cluster where the player primarily plays this title. Used for matchmaking and latency optimization.',
    `session_count` STRING COMMENT 'Total number of gameplay sessions the player has initiated for this game title. Used for engagement frequency analysis.',
    `skill_rating` STRING COMMENT 'Numerical skill rating or matchmaking rank (MMR) for the player in this game title. Used for competitive matchmaking and leaderboards.',
    `total_losses` STRING COMMENT 'Total number of competitive matches or games lost by the player in this title. Used for win-rate calculations and skill assessment.',
    `total_mtx_spend` DECIMAL(18,2) COMMENT 'Total amount spent by the player on microtransactions (MTX) in this game title. Used for ARPPU (Average Revenue Per Paying User) and LTV (Lifetime Value) calculations.',
    `total_playtime_hours` DECIMAL(18,2) COMMENT 'Total number of hours the player has spent playing this game title. Key engagement metric for GaaS (Game as a Service) operations.',
    `total_wins` STRING COMMENT 'Total number of competitive matches or games won by the player in this title. Used for win-rate calculations and skill assessment.',
    `tutorial_completed_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the player has completed the tutorial or FTUE (First-Time User Experience) for this game title.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this title progress record was last modified. Audit trail for record updates.',
    CONSTRAINT pk_title_progress PRIMARY KEY(`title_progress_id`)
) COMMENT 'Tracks a players progression state within a specific game title, serving as the operational record for game-as-a-service (GaaS) live-ops and player support. Stores game title reference, current level/rank, XP total, hours played in title, last played timestamp, completion percentage, active season pass reference, battle pass tier, achievement count, and playstyle classification (PvP/PvE/casual/competitive). One row per player per game title. Enables live-ops personalization, player support context, and title-level retention analysis.';

CREATE OR REPLACE TABLE `gaming_ecm`.`player`.`dlc_purchase` (
    `dlc_purchase_id` BIGINT COMMENT 'Unique identifier for this DLC purchase transaction. Primary key for the association.',
    `dlc_bundle_id` BIGINT COMMENT 'Foreign key linking to the DLC bundle that was purchased',
    `player_account_id` BIGINT COMMENT 'Foreign key linking to the player account who made the purchase',
    `storefront_order_id` BIGINT COMMENT 'External transaction identifier from the platform storefront (Steam, PSN, Xbox Store, App Store, Google Play). Used for reconciliation with platform payment reports, refund processing, and dispute resolution.',
    `activation_timestamp` TIMESTAMP COMMENT 'Date and time when the player first activated or downloaded the DLC content after purchase. Nullable if purchased but not yet activated. Used for engagement analytics and to distinguish purchased-but-unused content.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the purchase_price_paid. Supports multi-currency transactions and regional pricing strategies.',
    `discount_applied` DECIMAL(18,2) COMMENT 'Total discount amount applied to this purchase in the transaction currency. Nullable if no discount. Used for promotional campaign effectiveness analysis.',
    `entitlement_status` STRING COMMENT 'Current status of the players entitlement to access this DLC content. Active means player has access, revoked indicates access removed (e.g., chargeback), refunded means purchase was refunded, pending indicates payment processing, expired for time-limited content. Drives content access control systems.',
    `payment_method` STRING COMMENT 'Type of payment method used for the purchase (credit_card, paypal, platform_wallet, gift_card, promotional_code). Used for payment analytics and fraud detection.',
    `platform_code` STRING COMMENT 'The platform through which the purchase was made (PC, PlayStation, Xbox, Nintendo, Mobile). Critical for cross-platform entitlement management and platform-specific revenue sharing calculations.',
    `purchase_price_paid` DECIMAL(18,2) COMMENT 'The actual amount paid by the player for this DLC bundle at the time of purchase. May differ from base_price_usd due to regional pricing, discounts, sales, or promotional offers. Critical for revenue recognition and refund calculations.',
    `purchase_timestamp` TIMESTAMP COMMENT 'Date and time when the player completed the purchase transaction. Used for revenue recognition timing, refund eligibility windows, and purchase history tracking.',
    `refund_amount` DECIMAL(18,2) COMMENT 'Amount refunded to the player. Nullable if never refunded. May differ from purchase_price_paid due to partial refunds or platform fees.',
    `refund_timestamp` TIMESTAMP COMMENT 'Date and time when the purchase was refunded. Nullable if never refunded. Triggers entitlement_status change to refunded and revenue reversal.',
    CONSTRAINT pk_dlc_purchase PRIMARY KEY(`dlc_purchase_id`)
) COMMENT 'This association product represents the transactional event between player_account and dlc_bundle. It captures the monetization relationship where players purchase downloadable content. Each record links one player_account to one dlc_bundle with transaction-specific attributes including purchase price, timestamp, platform, entitlement status, and activation details. This is the SSOT for revenue recognition, content access control, refund processing, and cross-platform entitlement management.. Existence Justification: In the gaming industry, players purchase multiple DLC bundles over their account lifetime, and each DLC bundle is purchased by thousands or millions of players. This is a core monetization relationship where the business actively manages individual purchase transactions with transaction-specific data (price paid, timestamp, platform, entitlement status, activation). The relationship is not derivable—it is the operational source of truth for revenue recognition, content access control, and refund processing.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `gaming_ecm`.`player`.`profile` ADD CONSTRAINT `fk_player_profile_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ADD CONSTRAINT `fk_player_platform_identity_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ADD CONSTRAINT `fk_player_consent_snapshot_device_id` FOREIGN KEY (`device_id`) REFERENCES `gaming_ecm`.`player`.`device`(`device_id`);
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ADD CONSTRAINT `fk_player_consent_snapshot_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`player`.`parental_control` ADD CONSTRAINT `fk_player_parental_control_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`player`.`parental_control` ADD CONSTRAINT `fk_player_parental_control_primary_parental_player_account_id` FOREIGN KEY (`primary_parental_player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`player`.`parental_control` ADD CONSTRAINT `fk_player_parental_control_tertiary_parental_created_by_player_player_account_id` FOREIGN KEY (`tertiary_parental_created_by_player_player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`player`.`preference` ADD CONSTRAINT `fk_player_preference_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`player`.`preference` ADD CONSTRAINT `fk_player_preference_preference_player_account_id` FOREIGN KEY (`preference_player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`player`.`device` ADD CONSTRAINT `fk_player_device_platform_account_id` FOREIGN KEY (`platform_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`player`.`device` ADD CONSTRAINT `fk_player_device_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`player`.`segment` ADD CONSTRAINT `fk_player_segment_parent_segment_id` FOREIGN KEY (`parent_segment_id`) REFERENCES `gaming_ecm`.`player`.`segment`(`segment_id`);
ALTER TABLE `gaming_ecm`.`player`.`segment_membership` ADD CONSTRAINT `fk_player_segment_membership_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`player`.`segment_membership` ADD CONSTRAINT `fk_player_segment_membership_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `gaming_ecm`.`player`.`segment`(`segment_id`);
ALTER TABLE `gaming_ecm`.`player`.`session` ADD CONSTRAINT `fk_player_session_device_id` FOREIGN KEY (`device_id`) REFERENCES `gaming_ecm`.`player`.`device`(`device_id`);
ALTER TABLE `gaming_ecm`.`player`.`session` ADD CONSTRAINT `fk_player_session_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`player`.`engagement_metric` ADD CONSTRAINT `fk_player_engagement_metric_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`player`.`ltv_record` ADD CONSTRAINT `fk_player_ltv_record_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ADD CONSTRAINT `fk_player_player_lifecycle_event_device_id` FOREIGN KEY (`device_id`) REFERENCES `gaming_ecm`.`player`.`device`(`device_id`);
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ADD CONSTRAINT `fk_player_player_lifecycle_event_parental_control_id` FOREIGN KEY (`parental_control_id`) REFERENCES `gaming_ecm`.`player`.`parental_control`(`parental_control_id`);
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ADD CONSTRAINT `fk_player_player_lifecycle_event_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ADD CONSTRAINT `fk_player_player_lifecycle_event_session_id` FOREIGN KEY (`session_id`) REFERENCES `gaming_ecm`.`player`.`session`(`session_id`);
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ADD CONSTRAINT `fk_player_ban_record_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`player`.`authentication_log` ADD CONSTRAINT `fk_player_authentication_log_device_id` FOREIGN KEY (`device_id`) REFERENCES `gaming_ecm`.`player`.`device`(`device_id`);
ALTER TABLE `gaming_ecm`.`player`.`authentication_log` ADD CONSTRAINT `fk_player_authentication_log_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`player`.`authentication_log` ADD CONSTRAINT `fk_player_authentication_log_session_id` FOREIGN KEY (`session_id`) REFERENCES `gaming_ecm`.`player`.`session`(`session_id`);
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ADD CONSTRAINT `fk_player_title_progress_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`player`.`dlc_purchase` ADD CONSTRAINT `fk_player_dlc_purchase_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);

-- ========= TAGS =========
ALTER SCHEMA `gaming_ecm`.`player` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `gaming_ecm`.`player` SET TAGS ('dbx_domain' = 'player');
ALTER TABLE `gaming_ecm`.`player`.`player_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`player`.`player_account` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player Account ID');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Test Account Employee Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `account_level` SET TAGS ('dbx_business_glossary_term' = 'Account Level');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|suspended|banned|deactivated|pending_verification|locked');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `account_tier` SET TAGS ('dbx_business_glossary_term' = 'Account Tier');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `account_tier` SET TAGS ('dbx_value_regex' = 'free|premium|vip|founder|developer');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `age_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Age Verified Flag');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `avatar_url` SET TAGS ('dbx_business_glossary_term' = 'Avatar URL (Uniform Resource Locator)');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `bio` SET TAGS ('dbx_business_glossary_term' = 'Player Biography');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `creation_source` SET TAGS ('dbx_business_glossary_term' = 'Account Creation Source');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `data_processing_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Processing Consent Flag');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `data_processing_consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Data Processing Consent Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `display_name` SET TAGS ('dbx_business_glossary_term' = 'Player Display Name');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `display_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `display_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Player Email Address');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `email_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Email Verified Flag');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `email_verified_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `email_verified_flag` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `experience_points` SET TAGS ('dbx_business_glossary_term' = 'Experience Points (XP)');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `failed_login_attempts` SET TAGS ('dbx_business_glossary_term' = 'Failed Login Attempts');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `gdpr_right_to_erasure_requested_flag` SET TAGS ('dbx_business_glossary_term' = 'GDPR (General Data Protection Regulation) Right to Erasure Requested Flag');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `gender_identity` SET TAGS ('dbx_business_glossary_term' = 'Gender Identity');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `gender_identity` SET TAGS ('dbx_value_regex' = 'male|female|non_binary|prefer_not_to_say|other');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `gender_identity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `last_login_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Login Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `last_profile_update_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Profile Update Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `locale` SET TAGS ('dbx_business_glossary_term' = 'Locale');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `locale` SET TAGS ('dbx_value_regex' = '^[a-z]{2}_[A-Z]{2}$');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `marketing_opt_in_flag` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt-In Flag');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `parental_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Parental Consent Flag');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `password_last_changed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Password Last Changed Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `platform_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Platform of Origin');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `preferred_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `profile_visibility` SET TAGS ('dbx_business_glossary_term' = 'Profile Visibility');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `profile_visibility` SET TAGS ('dbx_value_regex' = 'public|friends_only|private');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `referral_code` SET TAGS ('dbx_business_glossary_term' = 'Referral Code');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `registration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Registration Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `reputation_score` SET TAGS ('dbx_business_glossary_term' = 'Reputation Score');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `suspension_expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Account Suspension Expiry Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Account Suspension Reason');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `suspension_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Account Suspension Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `timezone` SET TAGS ('dbx_business_glossary_term' = 'Timezone');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `total_playtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Playtime Minutes');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `two_factor_auth_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Two-Factor Authentication (2FA) Enabled Flag');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `username` SET TAGS ('dbx_business_glossary_term' = 'Player Username');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `username` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9_-]{3,20}$');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `username` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `username` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`player`.`profile` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `gaming_ecm`.`player`.`profile` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Profile ID');
ALTER TABLE `gaming_ecm`.`player`.`profile` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `gaming_ecm`.`player`.`profile` ALTER COLUMN `accessibility_settings` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Settings');
ALTER TABLE `gaming_ecm`.`player`.`profile` ALTER COLUMN `avatar_url` SET TAGS ('dbx_business_glossary_term' = 'Avatar URL (Uniform Resource Locator)');
ALTER TABLE `gaming_ecm`.`player`.`profile` ALTER COLUMN `bio` SET TAGS ('dbx_business_glossary_term' = 'Biography');
ALTER TABLE `gaming_ecm`.`player`.`profile` ALTER COLUMN `communication_language` SET TAGS ('dbx_business_glossary_term' = 'Communication Language');
ALTER TABLE `gaming_ecm`.`player`.`profile` ALTER COLUMN `communication_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `gaming_ecm`.`player`.`profile` ALTER COLUMN `content_rating_preference` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Preference');
ALTER TABLE `gaming_ecm`.`player`.`profile` ALTER COLUMN `content_rating_preference` SET TAGS ('dbx_value_regex' = 'E|E10|T|M|AO');
ALTER TABLE `gaming_ecm`.`player`.`profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Profile Created Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`profile` ALTER COLUMN `email_verified` SET TAGS ('dbx_business_glossary_term' = 'Email Verified');
ALTER TABLE `gaming_ecm`.`player`.`profile` ALTER COLUMN `email_verified` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`profile` ALTER COLUMN `email_verified` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`profile` ALTER COLUMN `external_profile_code` SET TAGS ('dbx_business_glossary_term' = 'External Profile ID');
ALTER TABLE `gaming_ecm`.`player`.`profile` ALTER COLUMN `external_profile_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`profile` ALTER COLUMN `external_profile_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`profile` ALTER COLUMN `gdpr_erasure_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'GDPR (General Data Protection Regulation) Erasure Completed Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`profile` ALTER COLUMN `gdpr_erasure_requested` SET TAGS ('dbx_business_glossary_term' = 'GDPR (General Data Protection Regulation) Erasure Requested');
ALTER TABLE `gaming_ecm`.`player`.`profile` ALTER COLUMN `locale` SET TAGS ('dbx_business_glossary_term' = 'Locale');
ALTER TABLE `gaming_ecm`.`player`.`profile` ALTER COLUMN `locale` SET TAGS ('dbx_value_regex' = '^[a-z]{2}_[A-Z]{2}$');
ALTER TABLE `gaming_ecm`.`player`.`profile` ALTER COLUMN `parental_consent_verified` SET TAGS ('dbx_business_glossary_term' = 'Parental Consent Verified');
ALTER TABLE `gaming_ecm`.`player`.`profile` ALTER COLUMN `phone_verified` SET TAGS ('dbx_business_glossary_term' = 'Phone Verified');
ALTER TABLE `gaming_ecm`.`player`.`profile` ALTER COLUMN `phone_verified` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`profile` ALTER COLUMN `phone_verified` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`profile` ALTER COLUMN `platform_preference` SET TAGS ('dbx_business_glossary_term' = 'Platform Preference');
ALTER TABLE `gaming_ecm`.`player`.`profile` ALTER COLUMN `platform_preference` SET TAGS ('dbx_value_regex' = 'console|pc|mobile|vr|cross_platform');
ALTER TABLE `gaming_ecm`.`player`.`profile` ALTER COLUMN `player_segment` SET TAGS ('dbx_business_glossary_term' = 'Player Segment');
ALTER TABLE `gaming_ecm`.`player`.`profile` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `gaming_ecm`.`player`.`profile` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`profile` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`profile` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language');
ALTER TABLE `gaming_ecm`.`player`.`profile` ALTER COLUMN `preferred_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `gaming_ecm`.`player`.`profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_business_glossary_term' = 'Profile Status');
ALTER TABLE `gaming_ecm`.`player`.`profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_value_regex' = 'active|suspended|banned|deleted|pending_verification');
ALTER TABLE `gaming_ecm`.`player`.`profile` ALTER COLUMN `referral_code` SET TAGS ('dbx_business_glossary_term' = 'Referral Code');
ALTER TABLE `gaming_ecm`.`player`.`profile` ALTER COLUMN `referred_by_code` SET TAGS ('dbx_business_glossary_term' = 'Referred By Code');
ALTER TABLE `gaming_ecm`.`player`.`profile` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `gaming_ecm`.`player`.`profile` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `gaming_ecm`.`player`.`profile` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'salesforce_crm|unity_player_services|epic_games_services|steam|console_sdk|mobile_sdk');
ALTER TABLE `gaming_ecm`.`player`.`profile` ALTER COLUMN `timezone` SET TAGS ('dbx_business_glossary_term' = 'Timezone');
ALTER TABLE `gaming_ecm`.`player`.`profile` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Profile Updated Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`profile` ALTER COLUMN `vip_tier` SET TAGS ('dbx_business_glossary_term' = 'VIP (Very Important Player) Tier');
ALTER TABLE `gaming_ecm`.`player`.`profile` ALTER COLUMN `vip_tier` SET TAGS ('dbx_value_regex' = 'none|bronze|silver|gold|platinum|diamond');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `platform_identity_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Identity ID');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player Account ID');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `cross_platform_play_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Platform Play Enabled Flag');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `external_platform_user_code` SET TAGS ('dbx_business_glossary_term' = 'External Platform User ID');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `external_platform_user_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `external_platform_user_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `fraud_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Risk Score');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `last_activity_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Activity Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `last_verified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Verified Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `link_device_type` SET TAGS ('dbx_business_glossary_term' = 'Link Device Type');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `link_device_type` SET TAGS ('dbx_value_regex' = 'console|pc|mobile|tablet|web_browser');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `link_ip_address` SET TAGS ('dbx_business_glossary_term' = 'Link IP Address');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `link_ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `link_ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `link_method` SET TAGS ('dbx_business_glossary_term' = 'Link Method');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `link_method` SET TAGS ('dbx_value_regex' = 'oauth|sdk_native|manual_entry|platform_sso|account_merge');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `link_source` SET TAGS ('dbx_business_glossary_term' = 'Link Source');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `link_source` SET TAGS ('dbx_value_regex' = 'game_client|web_portal|mobile_app|customer_support|account_migration|platform_auto_link');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `link_status` SET TAGS ('dbx_business_glossary_term' = 'Link Status');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `link_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|revoked|pending_verification|expired');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `linked_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Linked Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `oauth_access_token_hash` SET TAGS ('dbx_business_glossary_term' = 'OAuth Access Token Hash');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `oauth_access_token_hash` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `oauth_access_token_hash` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `oauth_refresh_token_hash` SET TAGS ('dbx_business_glossary_term' = 'OAuth Refresh Token Hash');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `oauth_refresh_token_hash` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `oauth_refresh_token_hash` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `platform_account_creation_date` SET TAGS ('dbx_business_glossary_term' = 'Platform Account Creation Date');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `platform_account_tier` SET TAGS ('dbx_business_glossary_term' = 'Platform Account Tier');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `platform_account_tier` SET TAGS ('dbx_value_regex' = 'free|basic|premium|plus|gold|ultimate');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `platform_achievement_count` SET TAGS ('dbx_business_glossary_term' = 'Platform Achievement Count');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `platform_age_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Platform Age Verified Flag');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `platform_communication_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Platform Communication Consent Flag');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `platform_data_sharing_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Platform Data Sharing Consent Flag');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `platform_display_name` SET TAGS ('dbx_business_glossary_term' = 'Platform Display Name');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `platform_display_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `platform_display_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `platform_email_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Platform Email Verified Flag');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `platform_email_verified_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `platform_email_verified_flag` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `platform_friend_count` SET TAGS ('dbx_business_glossary_term' = 'Platform Friend Count');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `platform_language_code` SET TAGS ('dbx_business_glossary_term' = 'Platform Language Code');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `platform_language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `platform_parental_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Platform Parental Control Flag');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `platform_privacy_level` SET TAGS ('dbx_business_glossary_term' = 'Platform Privacy Level');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `platform_privacy_level` SET TAGS ('dbx_value_regex' = 'public|friends_only|private');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `platform_region_code` SET TAGS ('dbx_business_glossary_term' = 'Platform Region Code');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `platform_region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `platform_total_playtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Platform Total Playtime Hours');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `platform_type` SET TAGS ('dbx_business_glossary_term' = 'Platform Type');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `primary_identity_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Identity Flag');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `token_expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Token Expiry Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `unlinked_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Unlinked Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `consent_snapshot_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Snapshot ID');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `device_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Device ID');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `device_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `device_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `age_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Age Verification Method');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `age_verification_method` SET TAGS ('dbx_value_regex' = 'government_id|credit_card|third_party_service|self_declaration|parental_verification|not_verified');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `age_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Age Verification Status');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `age_verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|failed|not_required|self_declared');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `analytics_tracking_allowed` SET TAGS ('dbx_business_glossary_term' = 'Analytics Tracking Allowed Flag');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `collection_method` SET TAGS ('dbx_business_glossary_term' = 'Consent Collection Method');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `collection_platform` SET TAGS ('dbx_business_glossary_term' = 'Consent Collection Platform');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `consent_audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Consent Audit Trail');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `consent_expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Expiry Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `consent_granted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Granted Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `consent_ip_address` SET TAGS ('dbx_business_glossary_term' = 'Consent IP Address');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `consent_ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `consent_ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `consent_language` SET TAGS ('dbx_business_glossary_term' = 'Consent Language Code');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `consent_scope` SET TAGS ('dbx_business_glossary_term' = 'Consent Scope');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'granted|withdrawn|pending|expired|revoked|not_required');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `consent_type` SET TAGS ('dbx_value_regex' = 'gdpr_data_processing|coppa_parental_consent|marketing_opt_in|analytics_tracking|cookie_consent|age_verification');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `consent_user_agent` SET TAGS ('dbx_business_glossary_term' = 'Consent User Agent String');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `consent_user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `consent_user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `consent_withdrawn_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Withdrawn Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `cookie_consent_granted` SET TAGS ('dbx_business_glossary_term' = 'Cookie Consent Granted Flag');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `data_portability_requested` SET TAGS ('dbx_business_glossary_term' = 'Data Portability Requested Flag');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `data_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period (Days)');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `erasure_request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Erasure Request Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Record Flag');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Consent Jurisdiction');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `legal_basis` SET TAGS ('dbx_business_glossary_term' = 'Legal Basis for Processing');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `legal_basis` SET TAGS ('dbx_value_regex' = 'consent|contract|legal_obligation|vital_interests|public_task|legitimate_interests');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `marketing_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt-In Flag');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `parent_email` SET TAGS ('dbx_business_glossary_term' = 'Parent Email Address');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `parent_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `parent_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `parent_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `parental_consent_required` SET TAGS ('dbx_business_glossary_term' = 'Parental Consent Required Flag');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `parental_consent_verified` SET TAGS ('dbx_business_glossary_term' = 'Parental Consent Verified Flag');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `parental_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Parental Verification Method');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `portability_request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Data Portability Request Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `right_to_erasure_requested` SET TAGS ('dbx_business_glossary_term' = 'Right to Erasure Requested Flag');
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ALTER COLUMN `third_party_sharing_allowed` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Sharing Allowed Flag');
ALTER TABLE `gaming_ecm`.`player`.`parental_control` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`player`.`parental_control` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `gaming_ecm`.`player`.`parental_control` ALTER COLUMN `parental_control_id` SET TAGS ('dbx_business_glossary_term' = 'Parental Control ID');
ALTER TABLE `gaming_ecm`.`player`.`parental_control` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Child Player ID');
ALTER TABLE `gaming_ecm`.`player`.`parental_control` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`parental_control` ALTER COLUMN `primary_parental_player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Player ID');
ALTER TABLE `gaming_ecm`.`player`.`parental_control` ALTER COLUMN `tertiary_parental_created_by_player_player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Player ID');
ALTER TABLE `gaming_ecm`.`player`.`parental_control` ALTER COLUMN `auto_expire_on_age_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Expire on Age Flag');
ALTER TABLE `gaming_ecm`.`player`.`parental_control` ALTER COLUMN `chat_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Chat Enabled Flag');
ALTER TABLE `gaming_ecm`.`player`.`parental_control` ALTER COLUMN `consent_granted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Granted Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`parental_control` ALTER COLUMN `consent_method` SET TAGS ('dbx_business_glossary_term' = 'Consent Verification Method');
ALTER TABLE `gaming_ecm`.`player`.`parental_control` ALTER COLUMN `consent_method` SET TAGS ('dbx_value_regex' = 'email_verification|credit_card_verification|government_id|video_conference|signed_form|platform_sdk');
ALTER TABLE `gaming_ecm`.`player`.`parental_control` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Parental Consent Status');
ALTER TABLE `gaming_ecm`.`player`.`parental_control` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'granted|denied|pending|revoked|expired');
ALTER TABLE `gaming_ecm`.`player`.`parental_control` ALTER COLUMN `content_rating_restriction` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Restriction');
ALTER TABLE `gaming_ecm`.`player`.`parental_control` ALTER COLUMN `control_status` SET TAGS ('dbx_business_glossary_term' = 'Parental Control Status');
ALTER TABLE `gaming_ecm`.`player`.`parental_control` ALTER COLUMN `control_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_verification');
ALTER TABLE `gaming_ecm`.`player`.`parental_control` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`parental_control` ALTER COLUMN `daily_playtime_limit_minutes` SET TAGS ('dbx_business_glossary_term' = 'Daily Playtime Limit Minutes');
ALTER TABLE `gaming_ecm`.`player`.`parental_control` ALTER COLUMN `daily_spending_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Daily Spending Limit Amount');
ALTER TABLE `gaming_ecm`.`player`.`parental_control` ALTER COLUMN `data_collection_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Allowed Flag');
ALTER TABLE `gaming_ecm`.`player`.`parental_control` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `gaming_ecm`.`player`.`parental_control` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `gaming_ecm`.`player`.`parental_control` ALTER COLUMN `enforcement_mode` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Mode');
ALTER TABLE `gaming_ecm`.`player`.`parental_control` ALTER COLUMN `enforcement_mode` SET TAGS ('dbx_value_regex' = 'strict|flexible|advisory');
ALTER TABLE `gaming_ecm`.`player`.`parental_control` ALTER COLUMN `friend_requests_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Friend Requests Allowed Flag');
ALTER TABLE `gaming_ecm`.`player`.`parental_control` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`parental_control` ALTER COLUMN `location_sharing_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Location Sharing Allowed Flag');
ALTER TABLE `gaming_ecm`.`player`.`parental_control` ALTER COLUMN `marketing_communications_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Marketing Communications Allowed Flag');
ALTER TABLE `gaming_ecm`.`player`.`parental_control` ALTER COLUMN `monthly_spending_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Monthly Spending Limit Amount');
ALTER TABLE `gaming_ecm`.`player`.`parental_control` ALTER COLUMN `multiplayer_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Multiplayer Allowed Flag');
ALTER TABLE `gaming_ecm`.`player`.`parental_control` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Parental Control Notes');
ALTER TABLE `gaming_ecm`.`player`.`parental_control` ALTER COLUMN `notification_email` SET TAGS ('dbx_business_glossary_term' = 'Notification Email Address');
ALTER TABLE `gaming_ecm`.`player`.`parental_control` ALTER COLUMN `notification_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `gaming_ecm`.`player`.`parental_control` ALTER COLUMN `notification_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`parental_control` ALTER COLUMN `notification_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`parental_control` ALTER COLUMN `notification_frequency` SET TAGS ('dbx_business_glossary_term' = 'Notification Frequency');
ALTER TABLE `gaming_ecm`.`player`.`parental_control` ALTER COLUMN `notification_frequency` SET TAGS ('dbx_value_regex' = 'real_time|daily|weekly|monthly|on_violation');
ALTER TABLE `gaming_ecm`.`player`.`parental_control` ALTER COLUMN `override_pin_hash` SET TAGS ('dbx_business_glossary_term' = 'Override Personal Identification Number (PIN) Hash');
ALTER TABLE `gaming_ecm`.`player`.`parental_control` ALTER COLUMN `override_pin_hash` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`parental_control` ALTER COLUMN `platform_identifier` SET TAGS ('dbx_business_glossary_term' = 'Platform Identifier');
ALTER TABLE `gaming_ecm`.`player`.`parental_control` ALTER COLUMN `platform_type` SET TAGS ('dbx_business_glossary_term' = 'Platform Type');
ALTER TABLE `gaming_ecm`.`player`.`parental_control` ALTER COLUMN `platform_type` SET TAGS ('dbx_value_regex' = 'console|pc|mobile|web|vr|ar');
ALTER TABLE `gaming_ecm`.`player`.`parental_control` ALTER COLUMN `spending_limit_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Spending Limit Currency Code');
ALTER TABLE `gaming_ecm`.`player`.`parental_control` ALTER COLUMN `spending_limit_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`player`.`parental_control` ALTER COLUMN `ugc_access_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'User-Generated Content (UGC) Access Allowed Flag');
ALTER TABLE `gaming_ecm`.`player`.`parental_control` ALTER COLUMN `voice_chat_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Voice Chat Enabled Flag');
ALTER TABLE `gaming_ecm`.`player`.`parental_control` ALTER COLUMN `weekly_playtime_limit_minutes` SET TAGS ('dbx_business_glossary_term' = 'Weekly Playtime Limit Minutes');
ALTER TABLE `gaming_ecm`.`player`.`preference` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`player`.`preference` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `preference_id` SET TAGS ('dbx_business_glossary_term' = 'Preference ID');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `preference_player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `audio_language` SET TAGS ('dbx_business_glossary_term' = 'Audio Language');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `audio_language` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `auto_update_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto Update Enabled');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `colorblind_mode` SET TAGS ('dbx_business_glossary_term' = 'Colorblind Mode');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `colorblind_mode` SET TAGS ('dbx_value_regex' = 'none|protanopia|deuteranopia|tritanopia');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `control_scheme` SET TAGS ('dbx_business_glossary_term' = 'Control Scheme');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `control_scheme` SET TAGS ('dbx_value_regex' = 'default|custom|inverted|southpaw|legacy|tactical');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `crossplay_enabled` SET TAGS ('dbx_business_glossary_term' = 'Crossplay Enabled');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `data_sharing_analytics_enabled` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Analytics Enabled');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `data_sharing_marketing_enabled` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Marketing Enabled');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `data_sharing_third_party_enabled` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Third Party Enabled');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `difficulty_level` SET TAGS ('dbx_business_glossary_term' = 'Difficulty Level');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `difficulty_level` SET TAGS ('dbx_value_regex' = 'easy|normal|hard|expert|custom');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `email_enabled` SET TAGS ('dbx_business_glossary_term' = 'Email Enabled');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `email_enabled` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `email_enabled` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `email_newsletter_enabled` SET TAGS ('dbx_business_glossary_term' = 'Email Newsletter Enabled');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `email_newsletter_enabled` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `email_newsletter_enabled` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `email_promotional_enabled` SET TAGS ('dbx_business_glossary_term' = 'Email Promotional Enabled');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `email_promotional_enabled` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `email_promotional_enabled` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `email_transactional_enabled` SET TAGS ('dbx_business_glossary_term' = 'Email Transactional Enabled');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `email_transactional_enabled` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `email_transactional_enabled` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `friend_discovery_enabled` SET TAGS ('dbx_business_glossary_term' = 'Friend Discovery Enabled');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `matchmaking_region` SET TAGS ('dbx_business_glossary_term' = 'Matchmaking Region');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `matchmaking_region` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `preference_scope` SET TAGS ('dbx_business_glossary_term' = 'Preference Scope');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `preference_scope` SET TAGS ('dbx_value_regex' = 'account|platform|game|session');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `preference_source` SET TAGS ('dbx_business_glossary_term' = 'Preference Source');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `preference_source` SET TAGS ('dbx_value_regex' = 'in_game|web_portal|mobile_app|crm|support|default');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `preferred_storefront` SET TAGS ('dbx_business_glossary_term' = 'Preferred Storefront');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `profanity_filter_enabled` SET TAGS ('dbx_business_glossary_term' = 'Profanity Filter Enabled');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `profile_visibility` SET TAGS ('dbx_business_glossary_term' = 'Profile Visibility');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `profile_visibility` SET TAGS ('dbx_value_regex' = 'public|friends|private');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `push_game_updates_enabled` SET TAGS ('dbx_business_glossary_term' = 'Push Game Updates Enabled');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `push_notification_enabled` SET TAGS ('dbx_business_glossary_term' = 'Push Notification Enabled');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `push_promotional_enabled` SET TAGS ('dbx_business_glossary_term' = 'Push Promotional Enabled');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `push_social_enabled` SET TAGS ('dbx_business_glossary_term' = 'Push Social Enabled');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `sms_enabled` SET TAGS ('dbx_business_glossary_term' = 'SMS (Short Message Service) Enabled');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `sms_promotional_enabled` SET TAGS ('dbx_business_glossary_term' = 'SMS (Short Message Service) Promotional Enabled');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `subtitle_enabled` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Enabled');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `subtitle_language` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Language');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `subtitle_language` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `telemetry_enabled` SET TAGS ('dbx_business_glossary_term' = 'Telemetry Enabled');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `text_chat_enabled` SET TAGS ('dbx_business_glossary_term' = 'Text Chat Enabled');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `voice_chat_enabled` SET TAGS ('dbx_business_glossary_term' = 'Voice Chat Enabled');
ALTER TABLE `gaming_ecm`.`player`.`device` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`player`.`device` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `device_id` SET TAGS ('dbx_business_glossary_term' = 'Device ID');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `device_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `device_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `network_region_id` SET TAGS ('dbx_business_glossary_term' = 'Network Region Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `platform_account_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Account ID');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `platform_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `platform_account_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `advertising_identifier` SET TAGS ('dbx_business_glossary_term' = 'Advertising ID');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `advertising_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `advertising_identifier` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `app_version` SET TAGS ('dbx_business_glossary_term' = 'Application (App) Version');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `ban_expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ban Expiry Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `ban_reason` SET TAGS ('dbx_business_glossary_term' = 'Ban Reason');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `ban_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ban Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `connection_type` SET TAGS ('dbx_business_glossary_term' = 'Connection Type');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `connection_type` SET TAGS ('dbx_value_regex' = 'wifi|cellular|ethernet|unknown');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `cpu_architecture` SET TAGS ('dbx_business_glossary_term' = 'Central Processing Unit (CPU) Architecture');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `device_status` SET TAGS ('dbx_business_glossary_term' = 'Device Status');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `device_status` SET TAGS ('dbx_value_regex' = 'active|inactive|banned|suspended|pending_verification');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'console|pc|mobile|tablet|vr_headset|handheld');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `fingerprint_hash` SET TAGS ('dbx_business_glossary_term' = 'Device Fingerprint Hash');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `fingerprint_hash` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `fingerprint_hash` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `first_seen_timestamp` SET TAGS ('dbx_business_glossary_term' = 'First Seen Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `gpu_model` SET TAGS ('dbx_business_glossary_term' = 'Graphics Processing Unit (GPU) Model');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `ip_address_last_known` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address Last Known');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `ip_address_last_known` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `ip_address_last_known` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `is_emulator` SET TAGS ('dbx_business_glossary_term' = 'Is Emulator Flag');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `is_primary_device` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Device Flag');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `is_rooted_or_jailbroken` SET TAGS ('dbx_business_glossary_term' = 'Is Rooted or Jailbroken Flag');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Device Language');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `last_seen_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Seen Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `mac_address` SET TAGS ('dbx_business_glossary_term' = 'Media Access Control (MAC) Address');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `mac_address` SET TAGS ('dbx_value_regex' = '^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `mac_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `mac_address` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `make` SET TAGS ('dbx_business_glossary_term' = 'Device Make');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `model` SET TAGS ('dbx_business_glossary_term' = 'Device Model');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Device Notes');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `os_name` SET TAGS ('dbx_business_glossary_term' = 'Operating System (OS) Name');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `os_version` SET TAGS ('dbx_business_glossary_term' = 'Operating System (OS) Version');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `platform_sdk_version` SET TAGS ('dbx_business_glossary_term' = 'Platform Software Development Kit (SDK) Version');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `push_notification_token` SET TAGS ('dbx_business_glossary_term' = 'Push Notification Token');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `push_notification_token` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `registration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Registration Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `screen_resolution` SET TAGS ('dbx_business_glossary_term' = 'Screen Resolution');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Device Serial Number');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `serial_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `serial_number` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `storage_capacity_gb` SET TAGS ('dbx_business_glossary_term' = 'Storage Capacity Gigabytes (GB)');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `timezone_offset` SET TAGS ('dbx_business_glossary_term' = 'Timezone Offset');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `total_memory_mb` SET TAGS ('dbx_business_glossary_term' = 'Total Memory Megabytes (MB)');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `trust_score` SET TAGS ('dbx_business_glossary_term' = 'Device Trust Score');
ALTER TABLE `gaming_ecm`.`player`.`segment` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `gaming_ecm`.`player`.`segment` SET TAGS ('dbx_subdomain' = 'behavioral_analytics');
ALTER TABLE `gaming_ecm`.`player`.`segment` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment ID');
ALTER TABLE `gaming_ecm`.`player`.`segment` ALTER COLUMN `ml_model_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Machine Learning (ML) Model ID');
ALTER TABLE `gaming_ecm`.`player`.`segment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`segment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`segment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`segment` ALTER COLUMN `parent_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Segment ID');
ALTER TABLE `gaming_ecm`.`player`.`segment` ALTER COLUMN `acquisition_channel` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Channel');
ALTER TABLE `gaming_ecm`.`player`.`segment` ALTER COLUMN `age_range_max` SET TAGS ('dbx_business_glossary_term' = 'Age Range Maximum');
ALTER TABLE `gaming_ecm`.`player`.`segment` ALTER COLUMN `age_range_min` SET TAGS ('dbx_business_glossary_term' = 'Age Range Minimum');
ALTER TABLE `gaming_ecm`.`player`.`segment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `gaming_ecm`.`player`.`segment` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|rejected');
ALTER TABLE `gaming_ecm`.`player`.`segment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `gaming_ecm`.`player`.`segment` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`segment` ALTER COLUMN `assignment_method` SET TAGS ('dbx_business_glossary_term' = 'Assignment Method');
ALTER TABLE `gaming_ecm`.`player`.`segment` ALTER COLUMN `assignment_method` SET TAGS ('dbx_value_regex' = 'rule_based|ml_model|manual|hybrid');
ALTER TABLE `gaming_ecm`.`player`.`segment` ALTER COLUMN `churn_risk_score_max` SET TAGS ('dbx_business_glossary_term' = 'Churn Risk Score Maximum');
ALTER TABLE `gaming_ecm`.`player`.`segment` ALTER COLUMN `churn_risk_score_min` SET TAGS ('dbx_business_glossary_term' = 'Churn Risk Score Minimum');
ALTER TABLE `gaming_ecm`.`player`.`segment` ALTER COLUMN `coppa_safe` SET TAGS ('dbx_business_glossary_term' = 'Childrens Online Privacy Protection Act (COPPA) Safe Flag');
ALTER TABLE `gaming_ecm`.`player`.`segment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`segment` ALTER COLUMN `definition_criteria` SET TAGS ('dbx_business_glossary_term' = 'Definition Criteria');
ALTER TABLE `gaming_ecm`.`player`.`segment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `gaming_ecm`.`player`.`segment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `gaming_ecm`.`player`.`segment` ALTER COLUMN `engagement_tier` SET TAGS ('dbx_business_glossary_term' = 'Engagement Tier');
ALTER TABLE `gaming_ecm`.`player`.`segment` ALTER COLUMN `engagement_tier` SET TAGS ('dbx_value_regex' = 'high|medium|low|inactive');
ALTER TABLE `gaming_ecm`.`player`.`segment` ALTER COLUMN `gdpr_compliant` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Compliant Flag');
ALTER TABLE `gaming_ecm`.`player`.`segment` ALTER COLUMN `geo_filter` SET TAGS ('dbx_business_glossary_term' = 'Geographic Filter');
ALTER TABLE `gaming_ecm`.`player`.`segment` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `gaming_ecm`.`player`.`segment` ALTER COLUMN `is_standard_segment` SET TAGS ('dbx_business_glossary_term' = 'Is Standard Segment Flag');
ALTER TABLE `gaming_ecm`.`player`.`segment` ALTER COLUMN `last_refresh_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Refresh Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`segment` ALTER COLUMN `max_ltv_threshold` SET TAGS ('dbx_business_glossary_term' = 'Maximum Lifetime Value (LTV) Threshold');
ALTER TABLE `gaming_ecm`.`player`.`segment` ALTER COLUMN `min_ltv_threshold` SET TAGS ('dbx_business_glossary_term' = 'Minimum Lifetime Value (LTV) Threshold');
ALTER TABLE `gaming_ecm`.`player`.`segment` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `gaming_ecm`.`player`.`segment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`segment` ALTER COLUMN `platform_filter` SET TAGS ('dbx_business_glossary_term' = 'Platform Filter');
ALTER TABLE `gaming_ecm`.`player`.`segment` ALTER COLUMN `player_count` SET TAGS ('dbx_business_glossary_term' = 'Player Count');
ALTER TABLE `gaming_ecm`.`player`.`segment` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `gaming_ecm`.`player`.`segment` ALTER COLUMN `refresh_frequency` SET TAGS ('dbx_business_glossary_term' = 'Refresh Frequency');
ALTER TABLE `gaming_ecm`.`player`.`segment` ALTER COLUMN `refresh_frequency` SET TAGS ('dbx_value_regex' = 'real_time|hourly|daily|weekly|monthly|on_demand');
ALTER TABLE `gaming_ecm`.`player`.`segment` ALTER COLUMN `retention_day_threshold` SET TAGS ('dbx_business_glossary_term' = 'Retention Day Threshold');
ALTER TABLE `gaming_ecm`.`player`.`segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `gaming_ecm`.`player`.`segment` ALTER COLUMN `segment_description` SET TAGS ('dbx_business_glossary_term' = 'Segment Description');
ALTER TABLE `gaming_ecm`.`player`.`segment` ALTER COLUMN `segment_name` SET TAGS ('dbx_business_glossary_term' = 'Segment Name');
ALTER TABLE `gaming_ecm`.`player`.`segment` ALTER COLUMN `segment_type` SET TAGS ('dbx_business_glossary_term' = 'Segment Type');
ALTER TABLE `gaming_ecm`.`player`.`segment` ALTER COLUMN `segment_type` SET TAGS ('dbx_value_regex' = 'behavioral|demographic|ltv_based|engagement_based|acquisition_source|churn_risk');
ALTER TABLE `gaming_ecm`.`player`.`segment` ALTER COLUMN `spend_tier` SET TAGS ('dbx_business_glossary_term' = 'Spend Tier');
ALTER TABLE `gaming_ecm`.`player`.`segment` ALTER COLUMN `spend_tier` SET TAGS ('dbx_value_regex' = 'whale|dolphin|minnow|non_payer');
ALTER TABLE `gaming_ecm`.`player`.`segment` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Segment Tags');
ALTER TABLE `gaming_ecm`.`player`.`segment` ALTER COLUMN `target_use_case` SET TAGS ('dbx_business_glossary_term' = 'Target Use Case');
ALTER TABLE `gaming_ecm`.`player`.`segment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `gaming_ecm`.`player`.`segment_membership` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `gaming_ecm`.`player`.`segment_membership` SET TAGS ('dbx_subdomain' = 'behavioral_analytics');
ALTER TABLE `gaming_ecm`.`player`.`segment_membership` ALTER COLUMN `segment_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Membership ID');
ALTER TABLE `gaming_ecm`.`player`.`segment_membership` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`player`.`segment_membership` ALTER COLUMN `marketing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `gaming_ecm`.`player`.`segment_membership` ALTER COLUMN `player_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Player Segment Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`segment_membership` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player Account ID');
ALTER TABLE `gaming_ecm`.`player`.`segment_membership` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment ID');
ALTER TABLE `gaming_ecm`.`player`.`segment_membership` ALTER COLUMN `assignment_batch_code` SET TAGS ('dbx_business_glossary_term' = 'Assignment Batch ID');
ALTER TABLE `gaming_ecm`.`player`.`segment_membership` ALTER COLUMN `assignment_method` SET TAGS ('dbx_business_glossary_term' = 'Assignment Method');
ALTER TABLE `gaming_ecm`.`player`.`segment_membership` ALTER COLUMN `assignment_method` SET TAGS ('dbx_value_regex' = 'rule_based|manual|ml_model|api_trigger|batch_process|real_time_event');
ALTER TABLE `gaming_ecm`.`player`.`segment_membership` ALTER COLUMN `assignment_reason` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reason');
ALTER TABLE `gaming_ecm`.`player`.`segment_membership` ALTER COLUMN `assignment_source` SET TAGS ('dbx_business_glossary_term' = 'Assignment Source');
ALTER TABLE `gaming_ecm`.`player`.`segment_membership` ALTER COLUMN `assignment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`segment_membership` ALTER COLUMN `churn_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Churn Risk Score');
ALTER TABLE `gaming_ecm`.`player`.`segment_membership` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Confidence Score');
ALTER TABLE `gaming_ecm`.`player`.`segment_membership` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `gaming_ecm`.`player`.`segment_membership` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'granted|denied|not_required|pending');
ALTER TABLE `gaming_ecm`.`player`.`segment_membership` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`segment_membership` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`segment_membership` ALTER COLUMN `days_since_last_session` SET TAGS ('dbx_business_glossary_term' = 'Days Since Last Session (D1/D7/D30)');
ALTER TABLE `gaming_ecm`.`player`.`segment_membership` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `gaming_ecm`.`player`.`segment_membership` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `gaming_ecm`.`player`.`segment_membership` ALTER COLUMN `engagement_score` SET TAGS ('dbx_business_glossary_term' = 'Engagement Score');
ALTER TABLE `gaming_ecm`.`player`.`segment_membership` ALTER COLUMN `exclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Flag');
ALTER TABLE `gaming_ecm`.`player`.`segment_membership` ALTER COLUMN `exclusion_reason` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Reason');
ALTER TABLE `gaming_ecm`.`player`.`segment_membership` ALTER COLUMN `expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Expiry Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`segment_membership` ALTER COLUMN `geo_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `gaming_ecm`.`player`.`segment_membership` ALTER COLUMN `is_current` SET TAGS ('dbx_business_glossary_term' = 'Is Current Flag');
ALTER TABLE `gaming_ecm`.`player`.`segment_membership` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`segment_membership` ALTER COLUMN `ltv_estimate` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Value (LTV) Estimate');
ALTER TABLE `gaming_ecm`.`player`.`segment_membership` ALTER COLUMN `ltv_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`segment_membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_business_glossary_term' = 'Membership Status');
ALTER TABLE `gaming_ecm`.`player`.`segment_membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|revoked|pending');
ALTER TABLE `gaming_ecm`.`player`.`segment_membership` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Machine Learning (ML) Model Version');
ALTER TABLE `gaming_ecm`.`player`.`segment_membership` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `gaming_ecm`.`player`.`segment_membership` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `gaming_ecm`.`player`.`segment_membership` ALTER COLUMN `segment_entry_event` SET TAGS ('dbx_business_glossary_term' = 'Segment Entry Event');
ALTER TABLE `gaming_ecm`.`player`.`segment_membership` ALTER COLUMN `segment_exit_event` SET TAGS ('dbx_business_glossary_term' = 'Segment Exit Event');
ALTER TABLE `gaming_ecm`.`player`.`segment_membership` ALTER COLUMN `segment_tenure_days` SET TAGS ('dbx_business_glossary_term' = 'Segment Tenure Days');
ALTER TABLE `gaming_ecm`.`player`.`segment_membership` ALTER COLUMN `target_platform` SET TAGS ('dbx_business_glossary_term' = 'Target Platform');
ALTER TABLE `gaming_ecm`.`player`.`segment_membership` ALTER COLUMN `target_platform` SET TAGS ('dbx_value_regex' = 'console|pc|mobile|cross_platform');
ALTER TABLE `gaming_ecm`.`player`.`segment_membership` ALTER COLUMN `total_spend_to_date` SET TAGS ('dbx_business_glossary_term' = 'Total Spend to Date');
ALTER TABLE `gaming_ecm`.`player`.`segment_membership` ALTER COLUMN `total_spend_to_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`segment_membership` ALTER COLUMN `total_spend_to_date` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`session` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`player`.`session` SET TAGS ('dbx_subdomain' = 'behavioral_analytics');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Session ID');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `device_id` SET TAGS ('dbx_business_glossary_term' = 'Device ID');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `device_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `device_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `game_server_id` SET TAGS ('dbx_business_glossary_term' = 'Server Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `network_region_id` SET TAGS ('dbx_business_glossary_term' = 'Network Region Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Tester Employee Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `ab_test_variant` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `attribution_source` SET TAGS ('dbx_business_glossary_term' = 'Attribution Source');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `average_fps` SET TAGS ('dbx_business_glossary_term' = 'Average FPS (Frames Per Second)');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `average_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Average Latency (Milliseconds)');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `ccu_bucket` SET TAGS ('dbx_business_glossary_term' = 'CCU (Concurrent Users) Bucket');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `ccu_bucket` SET TAGS ('dbx_value_regex' = '0-100|101-500|501-1000|1001-5000|5001-10000|10000+');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'gameanalytics|amplitude|unity|unreal|custom');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `disconnect_reason` SET TAGS ('dbx_business_glossary_term' = 'Disconnect Reason');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Session Duration (Seconds)');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session End Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `event_count` SET TAGS ('dbx_business_glossary_term' = 'Session Event Count');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `game_version` SET TAGS ('dbx_business_glossary_term' = 'Game Version');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP (Internet Protocol) Address');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `is_cross_platform` SET TAGS ('dbx_business_glossary_term' = 'Is Cross-Platform Session Flag');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `is_first_session` SET TAGS ('dbx_business_glossary_term' = 'Is First Session Flag');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `is_tutorial_completed` SET TAGS ('dbx_business_glossary_term' = 'Is Tutorial Completed Flag');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `matchmaking_wait_seconds` SET TAGS ('dbx_business_glossary_term' = 'Matchmaking Wait Time (Seconds)');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `mtx_transaction_count` SET TAGS ('dbx_business_glossary_term' = 'MTX (Microtransaction) Transaction Count');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `party_size` SET TAGS ('dbx_business_glossary_term' = 'Party Size');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `quality_score` SET TAGS ('dbx_business_glossary_term' = 'Session Quality Score');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `revenue_usd` SET TAGS ('dbx_business_glossary_term' = 'Session Revenue (USD)');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `sdk_version` SET TAGS ('dbx_business_glossary_term' = 'SDK (Software Development Kit) Version');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `session_type` SET TAGS ('dbx_business_glossary_term' = 'Session Type');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session Start Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`engagement_metric` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`player`.`engagement_metric` SET TAGS ('dbx_subdomain' = 'behavioral_analytics');
ALTER TABLE `gaming_ecm`.`player`.`engagement_metric` ALTER COLUMN `engagement_metric_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Metric ID');
ALTER TABLE `gaming_ecm`.`player`.`engagement_metric` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`player`.`engagement_metric` ALTER COLUMN `achievement_unlock_count` SET TAGS ('dbx_business_glossary_term' = 'Achievement Unlock Count');
ALTER TABLE `gaming_ecm`.`player`.`engagement_metric` ALTER COLUMN `average_session_length_minutes` SET TAGS ('dbx_business_glossary_term' = 'Average Session Length Minutes');
ALTER TABLE `gaming_ecm`.`player`.`engagement_metric` ALTER COLUMN `churn_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Churn Risk Score');
ALTER TABLE `gaming_ecm`.`player`.`engagement_metric` ALTER COLUMN `cohort_identifier` SET TAGS ('dbx_business_glossary_term' = 'Cohort Identifier');
ALTER TABLE `gaming_ecm`.`player`.`engagement_metric` ALTER COLUMN `days_since_last_session` SET TAGS ('dbx_business_glossary_term' = 'Days Since Last Session');
ALTER TABLE `gaming_ecm`.`player`.`engagement_metric` ALTER COLUMN `engagement_score` SET TAGS ('dbx_business_glossary_term' = 'Engagement Score');
ALTER TABLE `gaming_ecm`.`player`.`engagement_metric` ALTER COLUMN `engagement_tier` SET TAGS ('dbx_business_glossary_term' = 'Engagement Tier');
ALTER TABLE `gaming_ecm`.`player`.`engagement_metric` ALTER COLUMN `engagement_tier` SET TAGS ('dbx_value_regex' = 'whale|core|casual|dormant|churned|new');
ALTER TABLE `gaming_ecm`.`player`.`engagement_metric` ALTER COLUMN `first_session_date` SET TAGS ('dbx_business_glossary_term' = 'First Session Date');
ALTER TABLE `gaming_ecm`.`player`.`engagement_metric` ALTER COLUMN `ftue_completed` SET TAGS ('dbx_business_glossary_term' = 'First-Time User Experience (FTUE) Completed Flag');
ALTER TABLE `gaming_ecm`.`player`.`engagement_metric` ALTER COLUMN `game_titles_played_count` SET TAGS ('dbx_business_glossary_term' = 'Game Titles Played Count');
ALTER TABLE `gaming_ecm`.`player`.`engagement_metric` ALTER COLUMN `in_game_event_participation_count` SET TAGS ('dbx_business_glossary_term' = 'In-Game Event Participation Count');
ALTER TABLE `gaming_ecm`.`player`.`engagement_metric` ALTER COLUMN `is_d1_retained` SET TAGS ('dbx_business_glossary_term' = 'Day 1 (D1) Retention Flag');
ALTER TABLE `gaming_ecm`.`player`.`engagement_metric` ALTER COLUMN `is_d30_retained` SET TAGS ('dbx_business_glossary_term' = 'Day 30 (D30) Retention Flag');
ALTER TABLE `gaming_ecm`.`player`.`engagement_metric` ALTER COLUMN `is_d7_retained` SET TAGS ('dbx_business_glossary_term' = 'Day 7 (D7) Retention Flag');
ALTER TABLE `gaming_ecm`.`player`.`engagement_metric` ALTER COLUMN `is_dau` SET TAGS ('dbx_business_glossary_term' = 'Daily Active User (DAU) Flag');
ALTER TABLE `gaming_ecm`.`player`.`engagement_metric` ALTER COLUMN `is_mau` SET TAGS ('dbx_business_glossary_term' = 'Monthly Active User (MAU) Flag');
ALTER TABLE `gaming_ecm`.`player`.`engagement_metric` ALTER COLUMN `is_wau` SET TAGS ('dbx_business_glossary_term' = 'Weekly Active User (WAU) Flag');
ALTER TABLE `gaming_ecm`.`player`.`engagement_metric` ALTER COLUMN `last_session_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Session Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`engagement_metric` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Stage');
ALTER TABLE `gaming_ecm`.`player`.`engagement_metric` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_value_regex' = 'onboarding|active|engaged|at_risk|churned|reactivated');
ALTER TABLE `gaming_ecm`.`player`.`engagement_metric` ALTER COLUMN `login_streak_days` SET TAGS ('dbx_business_glossary_term' = 'Login Streak Days');
ALTER TABLE `gaming_ecm`.`player`.`engagement_metric` ALTER COLUMN `metric_date` SET TAGS ('dbx_business_glossary_term' = 'Metric Date');
ALTER TABLE `gaming_ecm`.`player`.`engagement_metric` ALTER COLUMN `metric_grain` SET TAGS ('dbx_business_glossary_term' = 'Metric Grain');
ALTER TABLE `gaming_ecm`.`player`.`engagement_metric` ALTER COLUMN `metric_grain` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly');
ALTER TABLE `gaming_ecm`.`player`.`engagement_metric` ALTER COLUMN `peak_ccu_contribution` SET TAGS ('dbx_business_glossary_term' = 'Peak Concurrent Users (PCU) Contribution Flag');
ALTER TABLE `gaming_ecm`.`player`.`engagement_metric` ALTER COLUMN `primary_platform` SET TAGS ('dbx_business_glossary_term' = 'Primary Platform');
ALTER TABLE `gaming_ecm`.`player`.`engagement_metric` ALTER COLUMN `primary_platform` SET TAGS ('dbx_value_regex' = 'console|pc|mobile|web');
ALTER TABLE `gaming_ecm`.`player`.`engagement_metric` ALTER COLUMN `pve_session_count` SET TAGS ('dbx_business_glossary_term' = 'Player versus Environment (PvE) Session Count');
ALTER TABLE `gaming_ecm`.`player`.`engagement_metric` ALTER COLUMN `pvp_match_count` SET TAGS ('dbx_business_glossary_term' = 'Player versus Player (PvP) Match Count');
ALTER TABLE `gaming_ecm`.`player`.`engagement_metric` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`engagement_metric` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`engagement_metric` ALTER COLUMN `session_count` SET TAGS ('dbx_business_glossary_term' = 'Session Count');
ALTER TABLE `gaming_ecm`.`player`.`engagement_metric` ALTER COLUMN `social_interaction_count` SET TAGS ('dbx_business_glossary_term' = 'Social Interaction Count');
ALTER TABLE `gaming_ecm`.`player`.`engagement_metric` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `gaming_ecm`.`player`.`engagement_metric` ALTER COLUMN `total_playtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Playtime Minutes');
ALTER TABLE `gaming_ecm`.`player`.`engagement_metric` ALTER COLUMN `ugc_contribution_count` SET TAGS ('dbx_business_glossary_term' = 'User-Generated Content (UGC) Contribution Count');
ALTER TABLE `gaming_ecm`.`player`.`ltv_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`player`.`ltv_record` SET TAGS ('dbx_subdomain' = 'behavioral_analytics');
ALTER TABLE `gaming_ecm`.`player`.`ltv_record` ALTER COLUMN `ltv_record_id` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Value (LTV) Record ID');
ALTER TABLE `gaming_ecm`.`player`.`ltv_record` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`player`.`ltv_record` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`player`.`ltv_record` ALTER COLUMN `acquisition_channel` SET TAGS ('dbx_business_glossary_term' = 'Player Acquisition Channel');
ALTER TABLE `gaming_ecm`.`player`.`ltv_record` ALTER COLUMN `arpu_contribution` SET TAGS ('dbx_business_glossary_term' = 'Average Revenue Per User (ARPU) Contribution');
ALTER TABLE `gaming_ecm`.`player`.`ltv_record` ALTER COLUMN `average_transaction_value` SET TAGS ('dbx_business_glossary_term' = 'Average Transaction Value');
ALTER TABLE `gaming_ecm`.`player`.`ltv_record` ALTER COLUMN `calculation_date` SET TAGS ('dbx_business_glossary_term' = 'LTV Calculation Date');
ALTER TABLE `gaming_ecm`.`player`.`ltv_record` ALTER COLUMN `churn_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Churn Risk Score');
ALTER TABLE `gaming_ecm`.`player`.`ltv_record` ALTER COLUMN `cohort_month` SET TAGS ('dbx_business_glossary_term' = 'Player Cohort Month');
ALTER TABLE `gaming_ecm`.`player`.`ltv_record` ALTER COLUMN `cohort_month` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-[0-9]{2}$');
ALTER TABLE `gaming_ecm`.`player`.`ltv_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`ltv_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`player`.`ltv_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`player`.`ltv_record` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'LTV Data Source System');
ALTER TABLE `gaming_ecm`.`player`.`ltv_record` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'GameAnalytics|Amplitude|internal-billing|hybrid');
ALTER TABLE `gaming_ecm`.`player`.`ltv_record` ALTER COLUMN `days_since_first_purchase` SET TAGS ('dbx_business_glossary_term' = 'Days Since First Purchase');
ALTER TABLE `gaming_ecm`.`player`.`ltv_record` ALTER COLUMN `days_since_last_purchase` SET TAGS ('dbx_business_glossary_term' = 'Days Since Last Purchase');
ALTER TABLE `gaming_ecm`.`player`.`ltv_record` ALTER COLUMN `first_purchase_date` SET TAGS ('dbx_business_glossary_term' = 'First Purchase Date');
ALTER TABLE `gaming_ecm`.`player`.`ltv_record` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Player Flag');
ALTER TABLE `gaming_ecm`.`player`.`ltv_record` ALTER COLUMN `is_paying_user` SET TAGS ('dbx_business_glossary_term' = 'Is Paying User Flag');
ALTER TABLE `gaming_ecm`.`player`.`ltv_record` ALTER COLUMN `last_purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Date');
ALTER TABLE `gaming_ecm`.`player`.`ltv_record` ALTER COLUMN `ltv_segment` SET TAGS ('dbx_business_glossary_term' = 'LTV Segment Classification');
ALTER TABLE `gaming_ecm`.`player`.`ltv_record` ALTER COLUMN `ltv_segment` SET TAGS ('dbx_value_regex' = 'high-value|medium-value|low-value|at-risk|dormant|new');
ALTER TABLE `gaming_ecm`.`player`.`ltv_record` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'LTV Model Version');
ALTER TABLE `gaming_ecm`.`player`.`ltv_record` ALTER COLUMN `model_version` SET TAGS ('dbx_value_regex' = '^v[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `gaming_ecm`.`player`.`ltv_record` ALTER COLUMN `payer_tier` SET TAGS ('dbx_business_glossary_term' = 'Payer Tier Classification');
ALTER TABLE `gaming_ecm`.`player`.`ltv_record` ALTER COLUMN `payer_tier` SET TAGS ('dbx_value_regex' = 'whale|dolphin|minnow|non-payer');
ALTER TABLE `gaming_ecm`.`player`.`ltv_record` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Gaming Platform');
ALTER TABLE `gaming_ecm`.`player`.`ltv_record` ALTER COLUMN `platform` SET TAGS ('dbx_value_regex' = 'console|pc|mobile|cross-platform');
ALTER TABLE `gaming_ecm`.`player`.`ltv_record` ALTER COLUMN `predicted_ltv_180d` SET TAGS ('dbx_business_glossary_term' = 'Predicted Lifetime Value (LTV) 180-Day');
ALTER TABLE `gaming_ecm`.`player`.`ltv_record` ALTER COLUMN `predicted_ltv_365d` SET TAGS ('dbx_business_glossary_term' = 'Predicted Lifetime Value (LTV) 365-Day');
ALTER TABLE `gaming_ecm`.`player`.`ltv_record` ALTER COLUMN `predicted_ltv_90d` SET TAGS ('dbx_business_glossary_term' = 'Predicted Lifetime Value (LTV) 90-Day');
ALTER TABLE `gaming_ecm`.`player`.`ltv_record` ALTER COLUMN `realized_ltv` SET TAGS ('dbx_business_glossary_term' = 'Realized Lifetime Value (LTV)');
ALTER TABLE `gaming_ecm`.`player`.`ltv_record` ALTER COLUMN `total_iap_count` SET TAGS ('dbx_business_glossary_term' = 'Total In-App Purchase (IAP) Count');
ALTER TABLE `gaming_ecm`.`player`.`ltv_record` ALTER COLUMN `total_iap_spend` SET TAGS ('dbx_business_glossary_term' = 'Total In-App Purchase (IAP) Spend');
ALTER TABLE `gaming_ecm`.`player`.`ltv_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` SET TAGS ('dbx_subdomain' = 'security_enforcement');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ALTER COLUMN `player_lifecycle_event_id` SET TAGS ('dbx_business_glossary_term' = 'Player Lifecycle Event ID');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ALTER COLUMN `device_id` SET TAGS ('dbx_business_glossary_term' = 'Device ID');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ALTER COLUMN `device_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ALTER COLUMN `device_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ALTER COLUMN `marketing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ALTER COLUMN `parental_control_id` SET TAGS ('dbx_business_glossary_term' = 'Parental Consent ID');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Session ID');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ALTER COLUMN `telemetry_pipeline_id` SET TAGS ('dbx_business_glossary_term' = 'Ingestion Batch ID');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ALTER COLUMN `attribution_source` SET TAGS ('dbx_business_glossary_term' = 'Attribution Source');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ALTER COLUMN `authentication_method` SET TAGS ('dbx_business_glossary_term' = 'Authentication Method');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ALTER COLUMN `authentication_method` SET TAGS ('dbx_value_regex' = 'password|oauth|sso|biometric|mfa|token');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ALTER COLUMN `authentication_provider` SET TAGS ('dbx_business_glossary_term' = 'Authentication Provider');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ALTER COLUMN `consent_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Version');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ALTER COLUMN `coppa_protected_flag` SET TAGS ('dbx_business_glossary_term' = 'Childrens Online Privacy Protection Act (COPPA) Protected Flag');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ALTER COLUMN `days_since_previous_event` SET TAGS ('dbx_business_glossary_term' = 'Days Since Previous Event');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ALTER COLUMN `event_metadata_payload` SET TAGS ('dbx_business_glossary_term' = 'Event Metadata Payload');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ALTER COLUMN `event_source_system` SET TAGS ('dbx_business_glossary_term' = 'Event Source System');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'account_registered|email_verified|age_verified|first_login|ftue_completed|first_purchase');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ALTER COLUMN `failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Failure Reason');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ALTER COLUMN `game_version` SET TAGS ('dbx_business_glossary_term' = 'Game Version');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ALTER COLUMN `gdpr_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Consent Flag');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ALTER COLUMN `geolocation_city` SET TAGS ('dbx_business_glossary_term' = 'Geolocation City');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ALTER COLUMN `geolocation_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ALTER COLUMN `geolocation_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ALTER COLUMN `geolocation_country_code` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Country Code');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ALTER COLUMN `geolocation_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ALTER COLUMN `geolocation_country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ALTER COLUMN `geolocation_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ALTER COLUMN `geolocation_region` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Region');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ALTER COLUMN `geolocation_region` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ALTER COLUMN `geolocation_region` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Platform');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ALTER COLUMN `platform` SET TAGS ('dbx_value_regex' = 'console|pc|mobile|web|vr|ar');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ALTER COLUMN `previous_event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Previous Event Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ALTER COLUMN `referrer_url` SET TAGS ('dbx_business_glossary_term' = 'Referrer Uniform Resource Locator (URL)');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ALTER COLUMN `sdk_version` SET TAGS ('dbx_business_glossary_term' = 'Software Development Kit (SDK) Version');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ALTER COLUMN `suspicious_activity_flag` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Flag');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ALTER COLUMN `triggering_context` SET TAGS ('dbx_business_glossary_term' = 'Triggering Context');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` SET TAGS ('dbx_subdomain' = 'security_enforcement');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `ban_record_id` SET TAGS ('dbx_business_glossary_term' = 'Ban Record ID');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Agent ID');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `appeal_resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Appeal Resolution Notes');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `appeal_reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Appeal Reviewed By');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `appeal_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Appeal Reviewed Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'not_appealed|pending|under_review|approved|denied');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `appeal_submitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Submitted Flag');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `appeal_submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Appeal Submitted Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `automated_detection_confidence` SET TAGS ('dbx_business_glossary_term' = 'Automated Detection Confidence');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `ban_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Ban Duration Days');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `ban_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ban End Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `ban_number` SET TAGS ('dbx_business_glossary_term' = 'Ban Number');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `ban_number` SET TAGS ('dbx_value_regex' = '^BAN-[0-9]{10}$');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `ban_reason_category` SET TAGS ('dbx_business_glossary_term' = 'Ban Reason Category');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `ban_reason_category` SET TAGS ('dbx_value_regex' = 'cheating_exploiting|harassment_toxicity|tos_violation|payment_fraud|coppa_violation|account_sharing');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `ban_reason_detail` SET TAGS ('dbx_business_glossary_term' = 'Ban Reason Detail');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `ban_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ban Start Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `ban_status` SET TAGS ('dbx_business_glossary_term' = 'Ban Status');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `ban_status` SET TAGS ('dbx_value_regex' = 'active|expired|appealed|overturned|pending_review');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `ban_type` SET TAGS ('dbx_business_glossary_term' = 'Ban Type');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `compliance_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Compliance Jurisdiction');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `data_retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Expiry Date');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `evidence_reference` SET TAGS ('dbx_business_glossary_term' = 'Evidence Reference');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `hardware_identifier` SET TAGS ('dbx_business_glossary_term' = 'Hardware Identifier');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `hardware_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `hardware_identifier` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `issuing_system` SET TAGS ('dbx_business_glossary_term' = 'Issuing System');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `issuing_system` SET TAGS ('dbx_value_regex' = 'automated_anticheat|manual_trust_safety|platform_enforcement|community_report_system|payment_fraud_detection');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `notification_channel` SET TAGS ('dbx_business_glossary_term' = 'Notification Channel');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `notification_channel` SET TAGS ('dbx_value_regex' = 'email|in_game|platform_message|sms|push_notification');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `notification_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `platform_code` SET TAGS ('dbx_business_glossary_term' = 'Platform Code');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `prior_ban_count` SET TAGS ('dbx_business_glossary_term' = 'Prior Ban Count');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `repeat_offender_flag` SET TAGS ('dbx_business_glossary_term' = 'Repeat Offender Flag');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `gaming_ecm`.`player`.`authentication_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`player`.`authentication_log` SET TAGS ('dbx_subdomain' = 'security_enforcement');
ALTER TABLE `gaming_ecm`.`player`.`authentication_log` ALTER COLUMN `authentication_log_id` SET TAGS ('dbx_business_glossary_term' = 'Authentication Log ID');
ALTER TABLE `gaming_ecm`.`player`.`authentication_log` ALTER COLUMN `device_id` SET TAGS ('dbx_business_glossary_term' = 'Device ID');
ALTER TABLE `gaming_ecm`.`player`.`authentication_log` ALTER COLUMN `device_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`authentication_log` ALTER COLUMN `device_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`authentication_log` ALTER COLUMN `network_region_id` SET TAGS ('dbx_business_glossary_term' = 'Network Region Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`authentication_log` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`player`.`authentication_log` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Session ID');
ALTER TABLE `gaming_ecm`.`player`.`authentication_log` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`authentication_log` ALTER COLUMN `account_age_days` SET TAGS ('dbx_business_glossary_term' = 'Account Age Days');
ALTER TABLE `gaming_ecm`.`player`.`authentication_log` ALTER COLUMN `age_gate_passed_flag` SET TAGS ('dbx_business_glossary_term' = 'Age Gate Passed Flag');
ALTER TABLE `gaming_ecm`.`player`.`authentication_log` ALTER COLUMN `api_version` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Version');
ALTER TABLE `gaming_ecm`.`player`.`authentication_log` ALTER COLUMN `authentication_method` SET TAGS ('dbx_business_glossary_term' = 'Authentication Method');
ALTER TABLE `gaming_ecm`.`player`.`authentication_log` ALTER COLUMN `client_version` SET TAGS ('dbx_business_glossary_term' = 'Client Version');
ALTER TABLE `gaming_ecm`.`player`.`authentication_log` ALTER COLUMN `consent_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Version');
ALTER TABLE `gaming_ecm`.`player`.`authentication_log` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`authentication_log` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`authentication_log` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `gaming_ecm`.`player`.`authentication_log` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'login_success|login_failure|logout|password_reset|mfa_challenge|session_token_refresh');
ALTER TABLE `gaming_ecm`.`player`.`authentication_log` ALTER COLUMN `failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Failure Reason');
ALTER TABLE `gaming_ecm`.`player`.`authentication_log` ALTER COLUMN `gdpr_region_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Region Flag');
ALTER TABLE `gaming_ecm`.`player`.`authentication_log` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `gaming_ecm`.`player`.`authentication_log` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`authentication_log` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`authentication_log` ALTER COLUMN `login_attempt_count` SET TAGS ('dbx_business_glossary_term' = 'Login Attempt Count');
ALTER TABLE `gaming_ecm`.`player`.`authentication_log` ALTER COLUMN `login_duration_ms` SET TAGS ('dbx_business_glossary_term' = 'Login Duration Milliseconds');
ALTER TABLE `gaming_ecm`.`player`.`authentication_log` ALTER COLUMN `mfa_method` SET TAGS ('dbx_business_glossary_term' = 'Multi-Factor Authentication (MFA) Method');
ALTER TABLE `gaming_ecm`.`player`.`authentication_log` ALTER COLUMN `mfa_method` SET TAGS ('dbx_value_regex' = 'sms|email|authenticator_app|hardware_token|none');
ALTER TABLE `gaming_ecm`.`player`.`authentication_log` ALTER COLUMN `mfa_success_flag` SET TAGS ('dbx_business_glossary_term' = 'Multi-Factor Authentication (MFA) Success Flag');
ALTER TABLE `gaming_ecm`.`player`.`authentication_log` ALTER COLUMN `parental_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Parental Control Flag');
ALTER TABLE `gaming_ecm`.`player`.`authentication_log` ALTER COLUMN `previous_login_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Previous Login Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`authentication_log` ALTER COLUMN `referrer_url` SET TAGS ('dbx_business_glossary_term' = 'Referrer Uniform Resource Locator (URL)');
ALTER TABLE `gaming_ecm`.`player`.`authentication_log` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `gaming_ecm`.`player`.`authentication_log` ALTER COLUMN `sdk_version` SET TAGS ('dbx_business_glossary_term' = 'Software Development Kit (SDK) Version');
ALTER TABLE `gaming_ecm`.`player`.`authentication_log` ALTER COLUMN `suspicious_activity_flag` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Flag');
ALTER TABLE `gaming_ecm`.`player`.`authentication_log` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent');
ALTER TABLE `gaming_ecm`.`player`.`authentication_log` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`authentication_log` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` SET TAGS ('dbx_subdomain' = 'progression_monetization');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `title_progress_id` SET TAGS ('dbx_business_glossary_term' = 'Title Progress ID');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `guild_id` SET TAGS ('dbx_business_glossary_term' = 'Guild ID');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `checkpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Last Checkpoint ID');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `battle_pass_id` SET TAGS ('dbx_business_glossary_term' = 'Season Pass ID');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Tester Employee Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `achievement_count` SET TAGS ('dbx_business_glossary_term' = 'Achievement Count');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `average_session_length_minutes` SET TAGS ('dbx_business_glossary_term' = 'Average Session Length (Minutes)');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `battle_pass_tier` SET TAGS ('dbx_business_glossary_term' = 'Battle Pass Tier');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `character_class` SET TAGS ('dbx_business_glossary_term' = 'Character Class');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `churn_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Churn Risk Score');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completion Percentage');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `content_rating` SET TAGS ('dbx_business_glossary_term' = 'Content Rating');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `current_level` SET TAGS ('dbx_business_glossary_term' = 'Current Level');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `d1_retention_flag` SET TAGS ('dbx_business_glossary_term' = 'Day 1 (D1) Retention Flag');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `d30_retention_flag` SET TAGS ('dbx_business_glossary_term' = 'Day 30 (D30) Retention Flag');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `d7_retention_flag` SET TAGS ('dbx_business_glossary_term' = 'Day 7 (D7) Retention Flag');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `difficulty_setting` SET TAGS ('dbx_business_glossary_term' = 'Difficulty Setting');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `difficulty_setting` SET TAGS ('dbx_value_regex' = 'easy|normal|hard|expert|custom');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `experience_points` SET TAGS ('dbx_business_glossary_term' = 'Experience Points (XP)');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `first_played_timestamp` SET TAGS ('dbx_business_glossary_term' = 'First Played Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `highest_rank_achieved` SET TAGS ('dbx_business_glossary_term' = 'Highest Rank Achieved');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `in_game_currency_balance` SET TAGS ('dbx_business_glossary_term' = 'In-Game Currency Balance');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `last_played_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Played Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `last_purchase_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `parental_controls_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Parental Controls Enabled Flag');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `playstyle_classification` SET TAGS ('dbx_business_glossary_term' = 'Playstyle Classification');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `playstyle_classification` SET TAGS ('dbx_value_regex' = 'pvp|pve|casual|competitive|mixed|explorer');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `premium_currency_balance` SET TAGS ('dbx_business_glossary_term' = 'Premium Currency Balance');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `progress_status` SET TAGS ('dbx_business_glossary_term' = 'Progress Status');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `progress_status` SET TAGS ('dbx_value_regex' = 'active|inactive|completed|abandoned|suspended|new');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `session_count` SET TAGS ('dbx_business_glossary_term' = 'Session Count');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `skill_rating` SET TAGS ('dbx_business_glossary_term' = 'Skill Rating');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `total_losses` SET TAGS ('dbx_business_glossary_term' = 'Total Losses');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `total_mtx_spend` SET TAGS ('dbx_business_glossary_term' = 'Total Microtransaction (MTX) Spend');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `total_mtx_spend` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `total_playtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Playtime Hours');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `total_wins` SET TAGS ('dbx_business_glossary_term' = 'Total Wins');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `tutorial_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Tutorial Completed Flag');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`dlc_purchase` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `gaming_ecm`.`player`.`dlc_purchase` SET TAGS ('dbx_subdomain' = 'progression_monetization');
ALTER TABLE `gaming_ecm`.`player`.`dlc_purchase` SET TAGS ('dbx_association_edges' = 'player.player_account,title.dlc_bundle');
ALTER TABLE `gaming_ecm`.`player`.`dlc_purchase` ALTER COLUMN `dlc_purchase_id` SET TAGS ('dbx_business_glossary_term' = 'DLC Purchase ID');
ALTER TABLE `gaming_ecm`.`player`.`dlc_purchase` ALTER COLUMN `dlc_bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Dlc Purchase - Dlc Bundle Id');
ALTER TABLE `gaming_ecm`.`player`.`dlc_purchase` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Dlc Purchase - Player Account Id');
ALTER TABLE `gaming_ecm`.`player`.`dlc_purchase` ALTER COLUMN `storefront_order_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Transaction ID');
ALTER TABLE `gaming_ecm`.`player`.`dlc_purchase` ALTER COLUMN `activation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activation Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`dlc_purchase` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`player`.`dlc_purchase` ALTER COLUMN `discount_applied` SET TAGS ('dbx_business_glossary_term' = 'Discount Applied');
ALTER TABLE `gaming_ecm`.`player`.`dlc_purchase` ALTER COLUMN `entitlement_status` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Status');
ALTER TABLE `gaming_ecm`.`player`.`dlc_purchase` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `gaming_ecm`.`player`.`dlc_purchase` ALTER COLUMN `payment_method` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`dlc_purchase` ALTER COLUMN `platform_code` SET TAGS ('dbx_business_glossary_term' = 'Platform Code');
ALTER TABLE `gaming_ecm`.`player`.`dlc_purchase` ALTER COLUMN `purchase_price_paid` SET TAGS ('dbx_business_glossary_term' = 'Purchase Price Paid');
ALTER TABLE `gaming_ecm`.`player`.`dlc_purchase` ALTER COLUMN `purchase_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Purchase Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`dlc_purchase` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `gaming_ecm`.`player`.`dlc_purchase` ALTER COLUMN `refund_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Timestamp');
