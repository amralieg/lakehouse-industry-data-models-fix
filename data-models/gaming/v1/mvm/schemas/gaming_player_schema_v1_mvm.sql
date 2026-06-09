-- Schema for Domain: player | Business: Gaming | Version: v1_mvm
-- Generated on: 2026-05-08 09:46:27

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `gaming_ecm`.`player` COMMENT 'Single source of truth for all player identity, profiles, accounts, authentication, preferences, and segmentation across console, PC, and mobile platforms. Owns player registration, parental controls, COPPA/GDPR consent records, player demographics, behavior patterns, engagement metrics (DAU, MAU, WAU, retention), LTV calculations, and player lifecycle management. The authoritative domain for WHO the business serves.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `gaming_ecm`.`player`.`player_account` (
    `player_account_id` BIGINT COMMENT 'Unique identifier for the player account. Primary key for the player_account entity. This is the root identity to which all other player domain entities relate.',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to platform.storefront. Business justification: Player accounts originate on a specific storefront (PSN, Steam, mobile). Platform holder revenue attribution, cross-platform account migration, and acquisition channel reporting require the origin sto',
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
    `storefront_id` BIGINT COMMENT 'Foreign key linking to platform.storefront. Business justification: Player profiles have a primary storefront preference driving personalization, storefront-specific content delivery, and platform holder reporting. preferred_storefront and platform_preference are ',
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
    `device_id` BIGINT COMMENT 'Foreign key linking to player.device. Business justification: When a player links an external platform identity (PSN, Xbox Gamertag, Nintendo Account, Steam), the linking action is performed from a specific device. Capturing device_id on platform_identity enable',
    `player_account_id` BIGINT COMMENT 'Reference to the internal player account that owns this platform identity linkage. Links to the authoritative player account record in the Player domain.',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to platform.storefront. Business justification: A platform identity (PSN, Steam, Xbox Live) maps directly to a storefront. Cross-platform play eligibility, platform holder identity verification, and OAuth token management require linking platform i',
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

CREATE OR REPLACE TABLE `gaming_ecm`.`player`.`preference` (
    `preference_id` BIGINT COMMENT 'Unique identifier for the player preference record. Primary key.',
    `consent_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.consent_policy. Business justification: Privacy preferences (data_sharing_analytics_enabled, data_sharing_marketing_enabled, data_sharing_third_party_enabled) must reference the consent policy version under which player made choices. Requir',
    `device_id` BIGINT COMMENT 'Foreign key linking to player.device. Business justification: Preferences can be scoped to a specific device (preference_scope = device), enabling per-device configuration such as control schemes, display settings, push notification tokens, and accessibility s',
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
    `player_account_id` BIGINT COMMENT 'Identifier of the player who owns or uses this device. A player may own multiple devices; a device may be shared by household members.',
    `device_player_account_id` BIGINT COMMENT 'First-party platform account identifier (e.g., PlayStation Network ID, Xbox Live Gamertag, Steam ID) associated with this device.',
    `network_region_id` BIGINT COMMENT 'Foreign key linking to infrastructure.network_region. Business justification: Player devices connect from geographic locations that must be mapped to network regions for CDN routing, latency optimization, and data residency compliance. Network operations teams use this to route',
    `sdk_integration_id` BIGINT COMMENT 'Foreign key linking to platform.sdk_integration. Business justification: Devices run specific SDK integration versions. Platform SDK compliance tracking and forced-upgrade campaigns require knowing which SDK integration is on each device. platform_sdk_version is a denorm',
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

CREATE OR REPLACE TABLE `gaming_ecm`.`player`.`session` (
    `session_id` BIGINT COMMENT 'Unique identifier for the gameplay session. Primary key.',
    `ab_experiment_id` BIGINT COMMENT 'Foreign key linking to analytics.ab_experiment. Business justification: Session-level experiment exposure tracking is fundamental to gaming A/B analysis — the session during which a player first encounters a variant determines experiment attribution. Gaming analytics team',
    `build_id` BIGINT COMMENT 'Foreign key linking to studio.build. Business justification: Build quality reporting: QA and engineering teams correlate session-level quality_score, average_fps, average_latency_ms, and disconnect_reason against specific studio builds to detect regressions pos',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.marketing_campaign. Business justification: Session-level campaign attribution: analytics and UA teams measure ROAS, session quality, and LTV by acquisition campaign. A gaming analytics expert expects sessions to be attributable to the marketin',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: Live ops and version adoption reporting require knowing which content release version was active during each session. Deployment rollback decisions and patch adoption dashboards depend on this link. A',
    `device_id` BIGINT COMMENT 'Reference to the specific device used for this session.',
    `event_id` BIGINT COMMENT 'Foreign key linking to community.community_event. Business justification: Game sessions occur within community events (tournaments, seasonal events, live ops). Linking session to community_event enables event participation analytics, prize eligibility verification, and live',
    `game_mode_id` BIGINT COMMENT 'Foreign key linking to title.game_mode. Business justification: Matchmaking analytics, session quality reporting, live-ops balancing, and mode-level retention analysis all require knowing which game_mode a session was played in. Gaming operations teams routinely s',
    `game_server_id` BIGINT COMMENT 'Foreign key linking to infrastructure.game_server. Business justification: Player sessions occur on specific game servers. This is a fundamental operational link for session tracking, performance analysis, and incident correlation. Enables answering questions like which ser',
    `game_title_id` BIGINT COMMENT 'Reference to the game title played during this session.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Real-time compliance enforcement during sessions (loot box disclosure requirements, spend limit enforcement, age-gated content) depends on the jurisdiction active at session time. Storing jurisdiction',
    `level_map_id` BIGINT COMMENT 'Foreign key linking to content.level_map. Business justification: Game analytics and live ops teams track session quality, engagement, and revenue per level/map. Map popularity reports, balance tuning decisions, and server capacity planning all depend on knowing whi',
    `match_id` BIGINT COMMENT 'Foreign key linking to esports.match. Business justification: Competitive integrity auditing and match technical review require correlating infrastructure session records with esports match records. Esports ops teams investigate server issues, latency complaints',
    `matchmaking_ticket_id` BIGINT COMMENT 'Foreign key linking to infrastructure.matchmaking_ticket. Business justification: Links a fulfilled player session back to its originating matchmaking ticket. Enables matchmaking funnel analysis (queue wait time → session quality), algorithm tuning, and SLA breach reporting. Standa',
    `network_region_id` BIGINT COMMENT 'Foreign key linking to infrastructure.network_region. Business justification: Sessions are hosted in specific network regions for latency optimization, data residency compliance, and capacity planning. Operations teams analyze session distribution across regions to balance load',
    `offer_campaign_id` BIGINT COMMENT 'Foreign key linking to licensing.offer_campaign. Business justification: In-session offer conversion reporting: offer campaigns are surfaced to players during active sessions (in-game store popups, limited-time offers). Monetization teams track which offer campaign was pre',
    `player_account_id` BIGINT COMMENT 'Reference to the player who initiated this session. Links to the player master entity.',
    `sdk_integration_id` BIGINT COMMENT 'Foreign key linking to platform.sdk_integration. Business justification: Sessions are initiated via a specific SDK integration version. Platform SDK health monitoring, crash rate analysis by SDK version, and certification compliance require knowing which SDK integration wa',
    `seasonal_event_id` BIGINT COMMENT 'Foreign key linking to content.seasonal_event. Business justification: Live ops teams attribute session counts, revenue, and DAU lift to specific seasonal events. Querying sessions during Event X is a standard live ops KPI report. Every gaming operator tracks event-dri',
    `server_session_id` BIGINT COMMENT 'Foreign key linking to infrastructure.server_session. Business justification: Links client-side player session to authoritative server-side session record. Essential for QoS reporting, latency investigation, and anti-cheat correlation. Gaming ops engineers join these daily to d',
    `storefront_id` BIGINT COMMENT 'Reference to the platform on which the session was played (console, PC, mobile).',
    `subscription_id` BIGINT COMMENT 'Foreign key linking to billing.subscription. Business justification: Session-level subscription benefit auditing: knowing which subscription was active during a session is required to audit XP-boost delivery, premium matchmaking access, and ad-free gameplay entitlement',
    `telemetry_pipeline_id` BIGINT COMMENT 'Foreign key linking to analytics.telemetry_pipeline. Business justification: Sessions are ingested through specific telemetry pipelines; tracking which pipeline processed each session enables data quality auditing, pipeline SLA monitoring, and debugging of session data gaps or',
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

CREATE OR REPLACE TABLE `gaming_ecm`.`player`.`lifecycle_event` (
    `lifecycle_event_id` BIGINT COMMENT 'Unique identifier for the player lifecycle event record. Primary key for the immutable event log.',
    `ab_experiment_id` BIGINT COMMENT 'Foreign key linking to analytics.ab_experiment. Business justification: Lifecycle events (registration, first purchase, churn, reactivation) are primary outcome metrics for A/B experiments. Linking lifecycle events to the active experiment enables experiment outcome attri',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing or retention campaign that triggered or influenced this event, if applicable (e.g., reactivation email campaign, in-game event promotion).',
    `consent_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.consent_policy. Business justification: GDPR/CCPA compliance requires an immutable audit trail linking each consent_granted or consent_withdrawn lifecycle event to the exact consent policy version active at that moment. consent_version is a',
    `content_deployment_id` BIGINT COMMENT 'Foreign key linking to content.content_deployment. Business justification: Mandatory content deployments trigger forced-logout and re-authentication lifecycle events. Live ops deployment impact analysis requires attributing these lifecycle events to the specific deployment. ',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: Content releases drive reactivation spikes, churn events, and tutorial resets. Live ops and marketing analytics attribute lifecycle events (reactivation, churn, first-login) to content releases for re',
    `crm_campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.crm_campaign. Business justification: CRM campaign conversion tracking: CRM campaigns (push notifications, win-back emails) trigger lifecycle events (login, reactivation). Gaming CRM teams track which crm_campaign triggered each lifecycle',
    `device_id` BIGINT COMMENT 'Unique identifier for the device from which the event was triggered (e.g., console serial, mobile IDFA/GAID, browser fingerprint). Used for fraud detection and device-level analytics.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title in which the event occurred, if applicable. Null for account-level events not tied to a specific game.',
    `iap_transaction_id` BIGINT COMMENT 'Foreign key linking to licensing.iap_transaction. Business justification: CRM and monetization attribution: lifecycle events such as f2p_conversion, first_purchase, and reactivation are directly triggered by IAP transactions. Linking enables the CRM team to attribute lifecy',
    `infrastructure_incident_id` BIGINT COMMENT 'Foreign key linking to infrastructure.infrastructure_incident. Business justification: Mass lifecycle events (login failures, forced disconnects) are correlated with infrastructure incidents for post-mortem analysis and regulatory reporting. Gaming ops teams link player impact data to i',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: The jurisdiction active at the time of a lifecycle event (account creation, consent grant, age verification) determines which regulatory framework applied. GDPR/CCPA compliance audits require knowing ',
    `player_account_id` BIGINT COMMENT 'Reference to the player who triggered or is the subject of this lifecycle or authentication event.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Lifecycle events triggered by regulatory obligations (mandatory re-consent under new regulation, COPPA age-verification events, right-to-erasure confirmations) must be traceable to the specific obliga',
    `sdk_integration_id` BIGINT COMMENT 'Foreign key linking to platform.sdk_integration. Business justification: Lifecycle events (authentication, consent capture, GDPR opt-out) are emitted by SDK integrations. Debugging auth failures and GDPR compliance audits require tracing which SDK integration version emitt',
    `server_session_id` BIGINT COMMENT 'Foreign key linking to infrastructure.server_session. Business justification: Lifecycle events (disconnect, crash, forced logout) must be traceable to the specific server session for incident root-cause analysis and player appeal investigations. Gaming support teams require thi',
    `session_id` BIGINT COMMENT 'Unique identifier for the player session during which this event occurred. Used to correlate multiple events within a single play session.',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to platform.storefront. Business justification: Player lifecycle events (registration, login, churn) are storefront-scoped. Retention and funnel analytics require filtering events by storefront (iOS App Store vs Steam vs PSN). The existing plain p',
    `storefront_order_id` BIGINT COMMENT 'Foreign key linking to billing.storefront_order. Business justification: Purchase funnel event-order reconciliation: lifecycle events of type purchase_completed or checkout_initiated must reference the triggering storefront_order for purchase funnel analysis, revenue a',
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
    CONSTRAINT pk_lifecycle_event PRIMARY KEY(`lifecycle_event_id`)
) COMMENT 'Immutable event log and SINGLE authoritative source for all discrete player lifecycle milestones and authentication/security events, serving as the unified audit trail for the player domain. Lifecycle event types: account_registered, email_verified, age_verified, first_login, ftue_completed, first_purchase, reactivated, churned, suspended, banned, account_deleted, gdpr_erasure_requested, parental_consent_granted, parental_consent_revoked. Authentication event types: login_success, login_failure, logout, password_reset, mfa_challenge, session_token_refresh. Stores event type, event timestamp, event source system, platform, device reference, IP address, geolocation, authentication method, failure reason, suspicious_activity_flag, triggering context, and event metadata payload. This is the ONLY product in the player domain that records authentication events — no other product duplicates this responsibility. Serves GDPR/COPPA compliance, fraud detection, account security investigation, and lifecycle funnel analysis. Sourced from authentication services, platform SDK callbacks, and Salesforce CRM.';

CREATE OR REPLACE TABLE `gaming_ecm`.`player`.`ban_record` (
    `ban_record_id` BIGINT COMMENT 'Unique identifier for the ban record. Primary key.',
    `device_id` BIGINT COMMENT 'Foreign key linking to player.device. Business justification: A ban_record can be a hardware-level ban tied to a specific device (console, PC, mobile). The existing hardware_identifier STRING column is a denormalized device fingerprint/serial that duplicates dat',
    `game_title_id` BIGINT COMMENT 'Identifier of the game title where the violation occurred and the ban was issued. Links to the game title master record.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Ban enforcement is jurisdiction-specific: COPPA bans, GDPR-mandated suspensions, and regional gambling law violations each require different procedures. Compliance audits and regulatory reporting requ',
    `moderation_action_id` BIGINT COMMENT 'Foreign key linking to community.moderation_action. Business justification: Platform ban records are issued as enforcement outcomes of community moderation actions. Linking ban_record to the originating moderation_action provides the complete enforcement audit trail required ',
    `patch_id` BIGINT COMMENT 'Foreign key linking to content.patch. Business justification: Trust & safety and compliance teams track which patch version an exploit or cheat was present in. Ban records linked to patches enable root cause analysis, patch validation sign-off, and regulatory ev',
    `payment_id` BIGINT COMMENT 'Foreign key linking to billing.payment. Business justification: Fraud-triggered ban linkage: trust & safety teams ban accounts based on fraudulent payment evidence. Linking ban_record directly to the triggering payment supports fraud investigation workflows, charg',
    `player_account_id` BIGINT COMMENT 'Identifier of the player who received the enforcement action. Links to the player master record.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Each ban is executed under a specific internal policy (anti-cheat policy, underage monetization policy, fair play policy). Linking ban_record to the governing policy enables policy effectiveness repor',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Bans issued to fulfill a specific regulatory obligation (e.g., mandatory COPPA account suspension, GDPR enforcement action) must be traceable to that obligation for regulatory audit trails and complia',
    `server_session_id` BIGINT COMMENT 'Foreign key linking to infrastructure.server_session. Business justification: Anti-cheat bans are triggered by flags raised during a specific server session. Linking ban_record to server_session provides evidence traceability required for ban appeals, compliance audits, and ant',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to platform.storefront. Business justification: Bans are platform-scoped (PSN ban ≠ Steam ban). Trust & Safety and platform holder compliance reporting require querying bans by storefront. platform_code is a denormalized string replaced by this F',
    `tournament_id` BIGINT COMMENT 'Foreign key linking to esports.tournament. Business justification: Tournament-scoped bans (cheating, match-fixing, conduct violations during a specific event) are issued by tournament organizers. Compliance and legal teams must reference the exact tournament in ban r',
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
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this ban record was first created in the system. Audit trail for record creation.',
    `data_retention_expiry_date` DATE COMMENT 'Date when this ban record is eligible for deletion or anonymization per data retention policies and regulatory requirements. Calculated based on compliance jurisdiction and ban type.',
    `evidence_reference` STRING COMMENT 'Reference identifier or URI to supporting evidence for the ban (anti-cheat logs, chat transcripts, video recordings, player reports). Used for audit and appeal review.',
    `ip_address` STRING COMMENT 'IP address associated with the player at the time of the violation. Used for IP-level bans and fraud pattern analysis.',
    `issuing_system` STRING COMMENT 'System or process that issued the ban: automated_anticheat (anti-cheat engine detection), manual_trust_safety (human moderator review), platform_enforcement (first-party platform action), community_report_system (player report threshold trigger), payment_fraud_detection (payment system fraud alert).. Valid values are `automated_anticheat|manual_trust_safety|platform_enforcement|community_report_system|payment_fraud_detection`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this ban record was last updated. Audit trail for record modifications (status changes, appeal updates).',
    `notes` STRING COMMENT 'Internal operational notes for trust & safety team. May include investigation details, escalation history, or special handling instructions.',
    `notification_channel` STRING COMMENT 'Channel used to notify the player of the ban: email, in_game (in-game message), platform_message (console/platform notification), sms, push_notification (mobile push).. Valid values are `email|in_game|platform_message|sms|push_notification`',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether the player was notified of the ban via email, in-game message, or platform notification. True if notification sent, False otherwise.',
    `notification_sent_timestamp` TIMESTAMP COMMENT 'Date and time when the ban notification was sent to the player. Null if notification has not been sent.',
    `prior_ban_count` STRING COMMENT 'Number of previous bans issued to this player before this enforcement action. Used for progressive discipline and escalation.',
    `repeat_offender_flag` BOOLEAN COMMENT 'Indicates whether this player has prior ban records. True if this is not the first ban, False if first offense. Used for escalation policies.',
    `severity_level` STRING COMMENT 'Severity classification of the violation: low (minor TOS breach), medium (repeated minor violations or single moderate violation), high (serious cheating, harassment), critical (extreme toxicity, fraud, COPPA violation, illegal activity).. Valid values are `low|medium|high|critical`',
    CONSTRAINT pk_ban_record PRIMARY KEY(`ban_record_id`)
) COMMENT 'Authoritative record of all player enforcement actions including temporary suspensions, permanent bans, hardware bans, IP bans, chat restrictions, and competitive cooldowns. Stores ban type, ban reason category (cheating/exploiting, harassment/toxicity, TOS violation, payment fraud, COPPA violation, account sharing), ban start/end timestamps, ban status (active, expired, appealed, overturned), issuing system (automated anti-cheat, manual trust & safety review, platform enforcement), appeal status, and resolution notes. Supports the full enforcement lifecycle: issuance → notification → appeal → review → resolution. Critical for trust & safety operations and platform certification requirements.';

CREATE OR REPLACE TABLE `gaming_ecm`.`player`.`title_progress` (
    `title_progress_id` BIGINT COMMENT 'Unique identifier for the players progress record within a specific game title. Primary key.',
    `battle_pass_entitlement_id` BIGINT COMMENT 'Foreign key linking to licensing.battle_pass_entitlement. Business justification: Battle pass progression display and reward reconciliation: title_progress.season_pass_id links to the battle_pass product definition, but the players actual ownership instance (current_tier, xp, rewa',
    `battle_pass_id` BIGINT COMMENT 'Reference to the active season pass the player is participating in for this game title. Null if no season pass is active.',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: Player progression snapshots (level, XP, skill_rating) are only meaningful relative to the content release active at snapshot time. Balance patches reset or shift progression baselines. Live ops and a',
    `economy_config_id` BIGINT COMMENT 'Foreign key linking to licensing.economy_config. Business justification: Economy audit and compliance: economy_config governs earn caps, exchange rates, and balance caps that determine how title_progress currency balances and XP are calculated. Live-ops teams must audit wh',
    `esports_season_id` BIGINT COMMENT 'Foreign key linking to esports.esports_season. Business justification: Season-end rank snapshots, competitive eligibility checks, and season reset logic all require knowing which esports season a title_progress record belongs to. Ranked ladder progress is season-specific',
    `game_title_id` BIGINT COMMENT 'Reference to the game title for which this progress is tracked. Links to the game title master entity.',
    `guild_id` BIGINT COMMENT 'Reference to the guild or clan the player belongs to in this game title. Null if the player is not in a guild.',
    `live_ops_cycle_id` BIGINT COMMENT 'Foreign key linking to studio.live_ops_cycle. Business justification: LiveOps season reporting and player retention analysis requires knowing which live_ops_cycle a players current progress belongs to. battle_pass_tier, premium_currency_balance, and churn_risk_score on',
    `matchmaking_pool_id` BIGINT COMMENT 'Foreign key linking to infrastructure.matchmaking_pool. Business justification: A players current skill_rating and rank tier in title_progress determines their assigned matchmaking pool. This FK supports matchmaking eligibility queries, rank-based pool assignment reporting, and ',
    `platform_sku_id` BIGINT COMMENT 'Foreign key linking to platform.platform_sku. Business justification: Title progress is edition-specific — Standard vs Deluxe vs Game Pass SKUs unlock different content tiers. Live service entitlement-gated progression and SKU-tier reporting require linking progress rec',
    `player_account_id` BIGINT COMMENT 'Reference to the player who owns this progress record. Links to the player master entity.',
    `player_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.player_segment. Business justification: Game-scoped player segmentation: marketing teams segment players by title-specific progress metrics (churn risk, LTV tier, playstyle) to power re-engagement and upsell campaigns. A gaming CRM expert e',
    `seasonal_event_id` BIGINT COMMENT 'Foreign key linking to content.seasonal_event. Business justification: Title progress tracks battle_pass_tier, premium_currency_balance, and last_purchase_timestamp — all directly tied to seasonal events. Live ops post-event analysis requires linking player progress reco',
    `spend_limit_control_id` BIGINT COMMENT 'Foreign key linking to compliance.spend_limit_control. Business justification: title_progress tracks total_mtx_spend, premium_currency_balance, and in_game_currency_balance per player per title. Linking to the governing spend_limit_control enables real-time enforcement checks an',
    `storefront_id` BIGINT COMMENT 'Reference to the platform on which this progress was recorded (console, PC, mobile). Links to the platform master entity.',
    `subscription_id` BIGINT COMMENT 'Foreign key linking to billing.subscription. Business justification: Subscription-gated content access: title_progress tracks battle_pass_tier and premium_currency_balance whose values depend on the active subscription. A direct FK enables subscription-churn-vs-progres',
    `virtual_currency_account_id` BIGINT COMMENT 'Foreign key linking to licensing.virtual_currency_account. Business justification: Economy reconciliation process: title_progress tracks in_game_currency_balance and premium_currency_balance per title. Linking to the authoritative virtual_currency_account enables live-ops and financ',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `gaming_ecm`.`player`.`profile` ADD CONSTRAINT `fk_player_profile_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ADD CONSTRAINT `fk_player_platform_identity_device_id` FOREIGN KEY (`device_id`) REFERENCES `gaming_ecm`.`player`.`device`(`device_id`);
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ADD CONSTRAINT `fk_player_platform_identity_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`player`.`preference` ADD CONSTRAINT `fk_player_preference_device_id` FOREIGN KEY (`device_id`) REFERENCES `gaming_ecm`.`player`.`device`(`device_id`);
ALTER TABLE `gaming_ecm`.`player`.`preference` ADD CONSTRAINT `fk_player_preference_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`player`.`preference` ADD CONSTRAINT `fk_player_preference_preference_player_account_id` FOREIGN KEY (`preference_player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`player`.`device` ADD CONSTRAINT `fk_player_device_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`player`.`device` ADD CONSTRAINT `fk_player_device_device_player_account_id` FOREIGN KEY (`device_player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`player`.`session` ADD CONSTRAINT `fk_player_session_device_id` FOREIGN KEY (`device_id`) REFERENCES `gaming_ecm`.`player`.`device`(`device_id`);
ALTER TABLE `gaming_ecm`.`player`.`session` ADD CONSTRAINT `fk_player_session_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ADD CONSTRAINT `fk_player_lifecycle_event_device_id` FOREIGN KEY (`device_id`) REFERENCES `gaming_ecm`.`player`.`device`(`device_id`);
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ADD CONSTRAINT `fk_player_lifecycle_event_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ADD CONSTRAINT `fk_player_lifecycle_event_session_id` FOREIGN KEY (`session_id`) REFERENCES `gaming_ecm`.`player`.`session`(`session_id`);
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ADD CONSTRAINT `fk_player_ban_record_device_id` FOREIGN KEY (`device_id`) REFERENCES `gaming_ecm`.`player`.`device`(`device_id`);
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ADD CONSTRAINT `fk_player_ban_record_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ADD CONSTRAINT `fk_player_title_progress_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);

-- ========= TAGS =========
ALTER SCHEMA `gaming_ecm`.`player` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `gaming_ecm`.`player` SET TAGS ('dbx_domain' = 'player');
ALTER TABLE `gaming_ecm`.`player`.`player_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`player`.`player_account` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player Account ID');
ALTER TABLE `gaming_ecm`.`player`.`player_account` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Storefront Id (Foreign Key)');
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
ALTER TABLE `gaming_ecm`.`player`.`profile` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Id (Foreign Key)');
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
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `device_id` SET TAGS ('dbx_business_glossary_term' = 'Device Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `device_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `device_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player Account ID');
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Id (Foreign Key)');
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
ALTER TABLE `gaming_ecm`.`player`.`preference` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`player`.`preference` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `preference_id` SET TAGS ('dbx_business_glossary_term' = 'Preference ID');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `device_id` SET TAGS ('dbx_business_glossary_term' = 'Device Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `device_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`preference` ALTER COLUMN `device_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `device_player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Account ID');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `device_player_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `device_player_account_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `network_region_id` SET TAGS ('dbx_business_glossary_term' = 'Network Region Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`device` ALTER COLUMN `sdk_integration_id` SET TAGS ('dbx_business_glossary_term' = 'Sdk Integration Id (Foreign Key)');
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
ALTER TABLE `gaming_ecm`.`player`.`session` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`player`.`session` SET TAGS ('dbx_subdomain' = 'activity_tracking');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Session ID');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `ab_experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Ab Experiment Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `build_id` SET TAGS ('dbx_business_glossary_term' = 'Build Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Campaign Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Release Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `device_id` SET TAGS ('dbx_business_glossary_term' = 'Device ID');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `device_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `device_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Community Event Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `game_mode_id` SET TAGS ('dbx_business_glossary_term' = 'Game Mode Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `game_server_id` SET TAGS ('dbx_business_glossary_term' = 'Server Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `level_map_id` SET TAGS ('dbx_business_glossary_term' = 'Level Map Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `match_id` SET TAGS ('dbx_business_glossary_term' = 'Match Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `matchmaking_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Matchmaking Ticket Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `network_region_id` SET TAGS ('dbx_business_glossary_term' = 'Network Region Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `offer_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Offer Campaign Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `sdk_integration_id` SET TAGS ('dbx_business_glossary_term' = 'Sdk Integration Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `seasonal_event_id` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Event Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `server_session_id` SET TAGS ('dbx_business_glossary_term' = 'Server Session Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`session` ALTER COLUMN `telemetry_pipeline_id` SET TAGS ('dbx_business_glossary_term' = 'Telemetry Pipeline Id (Foreign Key)');
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
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` SET TAGS ('dbx_subdomain' = 'activity_tracking');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `lifecycle_event_id` SET TAGS ('dbx_business_glossary_term' = 'Player Lifecycle Event ID');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `ab_experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Ab Experiment Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `content_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Content Deployment Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Release Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `crm_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Crm Campaign Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `device_id` SET TAGS ('dbx_business_glossary_term' = 'Device ID');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `device_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `device_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `iap_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Iap Transaction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `infrastructure_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Infrastructure Incident Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `sdk_integration_id` SET TAGS ('dbx_business_glossary_term' = 'Sdk Integration Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `server_session_id` SET TAGS ('dbx_business_glossary_term' = 'Server Session Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Session ID');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `storefront_order_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Order Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `telemetry_pipeline_id` SET TAGS ('dbx_business_glossary_term' = 'Ingestion Batch ID');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `attribution_source` SET TAGS ('dbx_business_glossary_term' = 'Attribution Source');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `authentication_method` SET TAGS ('dbx_business_glossary_term' = 'Authentication Method');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `authentication_method` SET TAGS ('dbx_value_regex' = 'password|oauth|sso|biometric|mfa|token');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `authentication_provider` SET TAGS ('dbx_business_glossary_term' = 'Authentication Provider');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `consent_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Version');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `coppa_protected_flag` SET TAGS ('dbx_business_glossary_term' = 'Childrens Online Privacy Protection Act (COPPA) Protected Flag');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `days_since_previous_event` SET TAGS ('dbx_business_glossary_term' = 'Days Since Previous Event');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `event_metadata_payload` SET TAGS ('dbx_business_glossary_term' = 'Event Metadata Payload');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `event_source_system` SET TAGS ('dbx_business_glossary_term' = 'Event Source System');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'account_registered|email_verified|age_verified|first_login|ftue_completed|first_purchase');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Failure Reason');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `game_version` SET TAGS ('dbx_business_glossary_term' = 'Game Version');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `gdpr_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Consent Flag');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `geolocation_city` SET TAGS ('dbx_business_glossary_term' = 'Geolocation City');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `geolocation_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `geolocation_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `geolocation_country_code` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Country Code');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `geolocation_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `geolocation_country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `geolocation_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `geolocation_region` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Region');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `geolocation_region` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `geolocation_region` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Platform');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `platform` SET TAGS ('dbx_value_regex' = 'console|pc|mobile|web|vr|ar');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `previous_event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Previous Event Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `referrer_url` SET TAGS ('dbx_business_glossary_term' = 'Referrer Uniform Resource Locator (URL)');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `sdk_version` SET TAGS ('dbx_business_glossary_term' = 'Software Development Kit (SDK) Version');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `suspicious_activity_flag` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Flag');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `triggering_context` SET TAGS ('dbx_business_glossary_term' = 'Triggering Context');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` SET TAGS ('dbx_subdomain' = 'activity_tracking');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `ban_record_id` SET TAGS ('dbx_business_glossary_term' = 'Ban Record ID');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `device_id` SET TAGS ('dbx_business_glossary_term' = 'Device Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `device_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `device_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `moderation_action_id` SET TAGS ('dbx_business_glossary_term' = 'Moderation Action Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `patch_id` SET TAGS ('dbx_business_glossary_term' = 'Patch Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `server_session_id` SET TAGS ('dbx_business_glossary_term' = 'Server Session Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `tournament_id` SET TAGS ('dbx_business_glossary_term' = 'Tournament Id (Foreign Key)');
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
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `data_retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Expiry Date');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `evidence_reference` SET TAGS ('dbx_business_glossary_term' = 'Evidence Reference');
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
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `prior_ban_count` SET TAGS ('dbx_business_glossary_term' = 'Prior Ban Count');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `repeat_offender_flag` SET TAGS ('dbx_business_glossary_term' = 'Repeat Offender Flag');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` SET TAGS ('dbx_subdomain' = 'activity_tracking');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `title_progress_id` SET TAGS ('dbx_business_glossary_term' = 'Title Progress ID');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `battle_pass_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Battle Pass Entitlement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `battle_pass_id` SET TAGS ('dbx_business_glossary_term' = 'Season Pass ID');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Release Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `economy_config_id` SET TAGS ('dbx_business_glossary_term' = 'Economy Config Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `esports_season_id` SET TAGS ('dbx_business_glossary_term' = 'Esports Season Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `guild_id` SET TAGS ('dbx_business_glossary_term' = 'Guild ID');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `live_ops_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Live Ops Cycle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `matchmaking_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Matchmaking Pool Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `platform_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Sku Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `player_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Player Segment Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `seasonal_event_id` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Event Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `spend_limit_control_id` SET TAGS ('dbx_business_glossary_term' = 'Spend Limit Control Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ALTER COLUMN `virtual_currency_account_id` SET TAGS ('dbx_business_glossary_term' = 'Virtual Currency Account Id (Foreign Key)');
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
