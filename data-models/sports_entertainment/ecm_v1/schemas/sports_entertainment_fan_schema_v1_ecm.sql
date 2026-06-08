-- Schema for Domain: fan | Business: Sports Entertainment | Version: v1_ecm
-- Generated on: 2026-05-09 01:42:55

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `sports_entertainment_ecm`.`fan` COMMENT 'Primary customer-facing domain and SSOT for all fan identity, demographic, and relationship data. Manages fan profiles, CRM segmentation, loyalty programs, membership tiers, NPS tracking, engagement history, and consent/privacy preferences under GDPR and CCPA. Serves B2C individual fans, family accounts, season ticket holders, VIP members, and fan club memberships across all engagement channels.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` (
    `fan_profile_id` BIGINT COMMENT 'Unique surrogate identifier for each fan profile record. This is the golden record primary key for fan identity across all engagement channels. All other fan domain entities reference this via fan_profile_id.',
    `franchise_id` BIGINT COMMENT 'Foreign key linking to league.franchise. Business justification: Fan CRM segmentation, personalization engines, and targeted marketing campaigns depend on knowing a fans preferred franchise. Sports-entertainment CRM systems universally store preferred team as a FK',
    `venue_id` BIGINT COMMENT 'Foreign key linking to venue.venue. Business justification: CRM personalization and fan segmentation reports require a proper FK to the preferred venue. fan_profile.preferred_venue is a denormalized plain-text field; replacing it with preferred_venue_id enforc',
    `accessibility_requirements` STRING COMMENT 'Free-text description of any accessibility needs or disability accommodations required by the fan for venue attendance (e.g., wheelchair access, hearing loop, visual impairment assistance). Used by venue operations to fulfill Americans with Disabilities Act (ADA) obligations.',
    `account_status` STRING COMMENT 'Current lifecycle status of the fans account. Controls access to digital platforms, ticketing, loyalty programs, and communications. merged indicates the record was consolidated into another golden record. [ENUM-REF-CANDIDATE: active|inactive|suspended|pending_verification|deactivated|merged — promote to reference product]. Valid values are `active|inactive|suspended|pending_verification|deactivated|merged`',
    `aep_profile_reference` STRING COMMENT 'Unified profile identifier assigned by Adobe Experience Platform for fan engagement, personalization, and analytics. Enables cross-channel identity resolution.',
    `birth_date` DATE COMMENT 'Fans date of birth in ISO 8601 format (yyyy-MM-dd). Used for age verification, age-gated content access, birthday promotions, and demographic segmentation.',
    `ccpa_applicable` BOOLEAN COMMENT 'Indicates whether the fan is subject to California Consumer Privacy Act (CCPA) requirements based on their state of residence. Drives opt-out of sale rights and California-specific data handling procedures.',
    `communication_opt_in_email` BOOLEAN COMMENT 'Indicates whether the fan has provided explicit consent to receive marketing and promotional communications via email. Must be True before any commercial email is sent. Governed by GDPR Article 6 and CAN-SPAM Act.',
    `communication_opt_in_push` BOOLEAN COMMENT 'Indicates whether the fan has consented to receive push notifications via the mobile application. Controls delivery of real-time event alerts, score updates, and personalized offers.',
    `communication_opt_in_sms` BOOLEAN COMMENT 'Indicates whether the fan has provided explicit consent to receive marketing and transactional communications via SMS/text message. Governed by GDPR Article 6 and TCPA regulations.',
    `consent_capture_date` DATE COMMENT 'Date on which the fans most recent privacy consent preferences were recorded. Required for GDPR and CCPA audit trails to demonstrate lawful basis for data processing.',
    `consent_version` STRING COMMENT 'Version identifier of the privacy policy and consent notice that the fan agreed to at the time of consent capture. Enables compliance teams to identify fans who need re-consent when policies are updated.',
    `country_of_residence_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the fans current country of residence. Determines applicable privacy regulations (GDPR for EU residents, CCPA for California residents) and geo-targeted content.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the fan profile record was first created in the Silver Layer data product. Serves as the audit trail creation marker for data lineage and GDPR data inventory purposes.',
    `crm_contact_reference` STRING COMMENT 'External identifier for this fan record as stored in Salesforce CRM. Used to synchronize and reconcile the golden record with the operational CRM system.',
    `crm_segment_code` STRING COMMENT 'CRM segmentation code assigned to the fan based on behavioral, demographic, and transactional attributes. Used for targeted marketing campaigns, personalized offers, and Lifetime Value (LTV) optimization. Managed in Salesforce CRM.',
    `data_sharing_consent` BOOLEAN COMMENT 'Indicates whether the fan has consented to sharing their personal data with third-party partners, sponsors, and advertisers. Required for sponsor activation and targeted advertising programs.',
    `display_name` STRING COMMENT 'Preferred public-facing name or username chosen by the fan for use on digital platforms, fan clubs, and engagement channels. May differ from legal name.',
    `email` STRING COMMENT 'Primary email address used for all fan communications, account authentication, ticketing confirmations, and CRM outreach. Subject to GDPR and CCPA consent requirements.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `fan_type` STRING COMMENT 'Classification of the fan account type. Determines applicable business rules, pricing tiers, and service levels. family_account indicates a parent account with linked sub-profiles. vip denotes Very Important Person (VIP) status with premium service entitlements.. Valid values are `individual|family_account|corporate|vip|fan_club`',
    `first_name` STRING COMMENT 'Legal given name of the fan as captured at registration. Used for personalized communications and identity verification.',
    `gdpr_applicable` BOOLEAN COMMENT 'Indicates whether the fan is subject to General Data Protection Regulation (GDPR) requirements based on their country of residence (EU/EEA). Drives data processing rules, retention policies, and right-to-erasure workflows.',
    `gender` STRING COMMENT 'Self-reported gender identity of the fan. Used for demographic analytics, personalization, and inclusive marketing. Collected with explicit consent per GDPR and CCPA.. Valid values are `male|female|non_binary|prefer_not_to_say|other`',
    `is_fan_club_member` BOOLEAN COMMENT 'Indicates whether the fan is an active member of an official fan club. Fan club members receive exclusive content, early ticket access, and community engagement opportunities.',
    `is_season_ticket_holder` BOOLEAN COMMENT 'Indicates whether the fan currently holds an active season ticket for any league or team. Season ticket holders receive priority access, dedicated account management, and exclusive benefits.',
    `is_vip_member` BOOLEAN COMMENT 'Indicates whether the fan holds active Very Important Person (VIP) membership status, entitling them to premium hospitality, backstage access, and dedicated concierge services.',
    `last_engagement_date` DATE COMMENT 'Date of the fans most recent engagement activity across any channel (ticket purchase, content view, merchandise order, event attendance, app interaction). Used for recency scoring in CRM segmentation and churn risk models.',
    `last_login_timestamp` TIMESTAMP COMMENT 'Timestamp of the fans most recent authenticated login to any digital platform (web, mobile app, OTT). Used for engagement recency scoring, dormancy detection, and re-engagement campaign targeting.',
    `last_name` STRING COMMENT 'Legal family name or surname of the fan as captured at registration. Used in combination with first_name for full identity.',
    `loyalty_enrollment_date` DATE COMMENT 'Date on which the fan enrolled in the loyalty program. Used to calculate program tenure, anniversary rewards, and cohort-based retention analytics.',
    `loyalty_points_balance` STRING COMMENT 'Current unredeemed loyalty points balance for the fan. Points are earned through ticket purchases, merchandise, event attendance, and digital engagement. Used to determine redemption eligibility.',
    `loyalty_tier` STRING COMMENT 'Current tier level within the fan loyalty program. Determines reward multipliers, exclusive access privileges, and personalized offers. Tier is recalculated periodically based on engagement and spend activity.. Valid values are `bronze|silver|gold|platinum|elite`',
    `nationality_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the fans nationality. Used for international market segmentation, broadcast rights geo-restrictions, and regulatory compliance.. Valid values are `^[A-Z]{3}$`',
    `nps_score` STRING COMMENT 'Most recent Net Promoter Score (NPS) provided by the fan, ranging from 0 to 10. Used to measure fan loyalty and likelihood to recommend the brand. Drives CRM segmentation into Promoters (9-10), Passives (7-8), and Detractors (0-6).',
    `nps_survey_date` DATE COMMENT 'Date on which the most recent Net Promoter Score (NPS) survey response was captured. Used to determine recency of sentiment data and schedule follow-up surveys.',
    `phone` STRING COMMENT 'Primary mobile or landline phone number for the fan in E.164 international format. Used for SMS notifications, two-factor authentication, and event alerts.. Valid values are `^+?[1-9]d{1,14}$`',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the fans primary residence. Used for geographic market segmentation, venue proximity analysis, regional sponsorship targeting, and local event promotion.',
    `preferred_language_code` STRING COMMENT 'IETF BCP 47 language tag representing the fans preferred language for communications, digital platform content, and customer service interactions (e.g., en-US, es-MX, fr-FR).. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `preferred_sport` STRING COMMENT 'The sport or sports property the fan most closely identifies with (e.g., NFL Football, NBA Basketball, MLS Soccer, UFC). Used for content personalization, targeted promotions, and event recommendations. Free-text to accommodate multi-sport organizations.',
    `registration_channel` STRING COMMENT 'The channel through which the fan originally registered their account. Used for acquisition analytics, channel attribution, and Direct-To-Consumer (DTC) strategy reporting.. Valid values are `web|mobile_app|in_venue|call_centre|partner|social_media`',
    `registration_date` DATE COMMENT 'Date on which the fan first registered their account. Used to calculate fan tenure, cohort analysis, and Customer Acquisition Cost (CAC) reporting.',
    `secondary_email` STRING COMMENT 'Alternate email address for the fan, used as a fallback contact channel or for family account management. Subject to the same consent requirements as the primary email.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to any field in the fan profile record. Used for change data capture, incremental ETL processing, and audit trail compliance.',
    CONSTRAINT pk_fan_profile PRIMARY KEY(`fan_profile_id`)
) COMMENT 'SSOT master identity record for every individual fan across all engagement channels. Captures core demographic data (name, DOB, gender, nationality), contact details, preferred language, communication preferences, accessibility requirements, and account status. Sourced from Salesforce CRM and Adobe Experience Platform. Serves B2C individual fans, family account holders, season ticket holders, VIP members, and fan club members. This is the golden record for fan identity — all other fan domain entities reference this via fan_profile_id.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`fan`.`account` (
    `account_id` BIGINT COMMENT 'Primary key for account',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign that drove the fans initial account registration. Used for Customer Acquisition Cost (CAC) attribution, campaign Return on Investment (ROI) analysis, and cohort performance reporting.',
    `club_membership_id` BIGINT COMMENT 'Reference to the official fan club membership record associated with this account. Null if the account is not enrolled in a fan club. Enables fan club benefit delivery, exclusive content access, and supporter group governance.',
    `fan_profile_id` BIGINT COMMENT 'Reference to the fan identity record (fan_profile) that owns this account. Links the transactional account to the underlying fan identity and demographic record managed in the fan domain.',
    `franchise_id` BIGINT COMMENT 'Reference to the fans primary supported team or franchise. Used for personalized content delivery, targeted marketing, and team-specific loyalty benefit routing. Sourced from fan registration preference or CRM profile.',
    `loyalty_program_id` BIGINT COMMENT 'Reference to the loyalty program in which this account is enrolled. A fan account may be enrolled in one active loyalty program at a time. Drives points accrual, tier progression, and redemption eligibility.',
    `team_id` BIGINT COMMENT 'Reference to the fans primary supported team or franchise. Used for personalized content delivery, targeted marketing, and team-specific loyalty benefit routing. Sourced from fan registration preference or CRM profile.',
    `venue_id` BIGINT COMMENT 'Reference to the fans primary home venue for event attendance. Used for venue-specific promotions, parking pre-registration, and in-venue personalization services.',
    `account_status` STRING COMMENT 'Current lifecycle state of the fan account. Active indicates a fully operational account; suspended indicates temporary restriction (e.g., fraud review); closed indicates permanently deactivated; pending_verification indicates registration awaiting email or identity confirmation; locked indicates security lockout after failed authentication attempts; deactivated indicates voluntary closure by the fan. Serves as LIFECYCLE_STATUS for this MASTER_AGREEMENT entity.. Valid values are `active|suspended|closed|pending_verification|locked|deactivated`',
    `account_tier` STRING COMMENT 'Loyalty and service tier assigned to the fan account, determining access to benefits, priority services, and promotional offers. Tiers range from standard (base) through silver, gold, platinum, vip, and elite. Drives CRM segmentation, targeted marketing, and loyalty redemption rules. [ENUM-REF-CANDIDATE: standard|silver|gold|platinum|vip|elite — promote to reference product]. Valid values are `standard|silver|gold|platinum|vip|elite`',
    `account_type` STRING COMMENT 'Classification of the account by the nature of the fan relationship. Individual covers single-fan B2C accounts; family covers household multi-fan accounts; corporate_group covers B2B group purchasers; season_ticket_holder denotes dedicated season pass accounts; vip_member covers premium hospitality accounts; fan_club covers organized supporter group accounts. Serves as CLASSIFICATION_OR_TYPE for this MASTER_AGREEMENT entity. [ENUM-REF-CANDIDATE: individual|family|corporate_group|season_ticket_holder|vip_member|fan_club — promote to reference product]. Valid values are `individual|family|corporate_group|season_ticket_holder|vip_member|fan_club`',
    `card_brand` STRING COMMENT 'Brand of the default payment card on file (e.g., Visa, Mastercard, Amex). Non-sensitive card metadata retained for display and routing purposes. Does not constitute PAN or sensitive authentication data under PCI-DSS.. Valid values are `Visa|Mastercard|Amex|Discover|UnionPay|Other`',
    `card_expiry_date` DATE COMMENT 'Expiration date of the default payment card on file. Used to proactively notify fans of upcoming card expiry and prompt payment method updates before renewal or purchase failures occur.',
    `card_last_four` STRING COMMENT 'Last four digits of the default payment card on file. Retained as permitted truncated PAN under PCI-DSS for fan-facing display and customer service verification. Does not constitute full PAN.. Valid values are `^[0-9]{4}$`',
    `ccpa_opt_out_flag` BOOLEAN COMMENT 'Indicates whether the fan has exercised their CCPA right to opt out of the sale or sharing of personal information. True when the fan has submitted a Do Not Sell or Share request. Drives data sharing suppression for California-resident accounts.',
    `closure_date` DATE COMMENT 'Calendar date on which the fan account was permanently closed or deactivated. Null for accounts that remain open. Serves as EFFECTIVE_UNTIL for this MASTER_AGREEMENT entity. Required for GDPR right-to-erasure audit trails and churn analysis.',
    `consent_recorded_timestamp` TIMESTAMP COMMENT 'Timestamp at which the fans most recent consent preferences were recorded or last updated. Used as the audit timestamp for GDPR and CCPA consent records. Required for demonstrating lawful basis of processing under GDPR Article 7.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp at which the fan account record was first created in the source system (Salesforce CRM). Serves as the RECORD_AUDIT_CREATED field for this MASTER_AGREEMENT entity. Used for data lineage, audit trails, and registration cohort analysis.',
    `crm_account_number` STRING COMMENT 'Externally-known alphanumeric account number assigned by Salesforce CRM. Used as the business-facing identifier on correspondence, ticketing portals, and fan-facing digital platforms. Serves as the BUSINESS_IDENTIFIER for this MASTER_AGREEMENT entity.. Valid values are `^[A-Z0-9]{6,20}$`',
    `crm_segment_code` STRING COMMENT 'CRM-assigned segmentation code classifying the fan account into a marketing or engagement segment (e.g., HIGH_VALUE, LAPSED, NEW_FAN, REACTIVATED). Used by Salesforce CRM and Adobe Experience Platform for targeted campaign execution and personalization.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `currency` STRING COMMENT 'ISO 4217 three-letter currency code representing the fans preferred transaction currency (e.g., USD, GBP, EUR, AUD). Used for pricing display, ticketing transactions, and merchandise purchases on the fans account.. Valid values are `^[A-Z]{3}$`',
    `data_residency_country` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating the jurisdiction in which the fans personal data must be stored and processed. Drives data residency enforcement, GDPR adequacy decisions, and cross-border transfer controls.. Valid values are `^[A-Z]{3}$`',
    `default_payment_flag` BOOLEAN COMMENT 'Indicates whether the stored payment instrument is designated as the default payment method for this account. True when this is the primary instrument used for automated renewals, loyalty redemptions, and one-click purchases.',
    `gdpr_consent_flag` BOOLEAN COMMENT 'Indicates whether the fan has provided explicit GDPR consent for personal data processing. True when valid consent has been recorded. Mandatory for fan accounts in EU jurisdictions. Drives data processing eligibility and marketing suppression lists.',
    `language` STRING COMMENT 'BCP 47 language tag representing the fans preferred language for communications and digital platform content (e.g., en-US, es-MX, fr-FR, pt-BR). Used for localized content delivery, email template selection, and multilingual customer service routing.. Valid values are `^[a-z]{2,3}(-[A-Z]{2,3})?$`',
    `last_login_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful authentication event on the fan account. Used for dormancy detection, re-engagement campaign targeting, and security anomaly detection. Sourced from Salesforce CRM or Adobe Experience Platform session logs.',
    `login_failure_count` STRING COMMENT 'Number of consecutive failed login attempts since the last successful authentication. Used to trigger account lockout policies per security standards. Resets to zero upon successful login. Sourced from Salesforce CRM identity management.',
    `loyalty_points_balance` STRING COMMENT 'Current unredeemed loyalty points balance on the fan account at the time of the last update. Raw operational balance used for redemption eligibility checks and tier qualification. Not a calculated aggregate — sourced directly from the CRM loyalty ledger.',
    `loyalty_points_ytd_earned` STRING COMMENT 'Total loyalty points earned by the fan account in the current calendar or fiscal year. Used for annual tier qualification thresholds and year-end loyalty reporting. Resets at the start of each program year.',
    `marketing_email_opt_in_flag` BOOLEAN COMMENT 'Indicates whether the fan has opted in to receive marketing and promotional email communications. True when explicit opt-in consent has been recorded. Used by CRM to control email campaign eligibility and suppression lists.',
    `membership_number` STRING COMMENT 'Unique alphanumeric membership identifier printed on physical or digital membership cards. Used for in-venue access control, loyalty redemption at Point of Sale (POS), and fan-facing account lookup. Distinct from crm_account_number — this is the fan-visible card number.. Valid values are `^[A-Z0-9]{8,16}$`',
    `mfa_enabled_flag` BOOLEAN COMMENT 'Indicates whether Multi-Factor Authentication (MFA) is currently enabled on the fan account. True when the fan has enrolled a second authentication factor (e.g., SMS OTP, authenticator app). Used for security compliance reporting and risk-based access control.',
    `nps_score` STRING COMMENT 'Most recent Net Promoter Score (NPS) recorded for this fan account, on a scale of 0–10. Collected via post-event or periodic surveys. Used for fan satisfaction tracking, churn prediction, and experience improvement initiatives. Raw survey response — not a calculated aggregate.',
    `nps_survey_date` DATE COMMENT 'Date on which the most recent NPS survey response was recorded for this fan account. Used to determine survey recency, control survey frequency, and align NPS scores with event or season context.',
    `password_last_changed_date` DATE COMMENT 'Date on which the fan last changed their account password. Used for security policy enforcement, forced password rotation reminders, and breach response workflows. Does not store the password itself — credential metadata only.',
    `pci_payment_token` STRING COMMENT 'PCI-DSS compliant tokenized representation of the fans default payment instrument on file. The token is issued by the payment processor and replaces the actual card number (PAN). Never stores raw card data. Used for recurring purchases, loyalty redemptions, and ticketing transactions.. Valid values are `^[A-Za-z0-9-_]{16,64}$`',
    `primary_email` STRING COMMENT 'Primary email address associated with the fan account, used for login authentication, transactional notifications, and marketing communications. Subject to GDPR and CCPA consent requirements. Sourced from Salesforce CRM Account email field.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_phone` STRING COMMENT 'Primary contact phone number for the fan account in E.164 international format. Used for two-factor authentication (2FA), SMS notifications, and customer service outreach. Subject to GDPR and CCPA consent requirements.. Valid values are `^+?[1-9]d{6,14}$`',
    `push_notification_opt_in_flag` BOOLEAN COMMENT 'Indicates whether the fan has enabled push notifications on the mobile app. True when the fan has granted notification permissions. Used for real-time event alerts, score updates, and personalized offers via Adobe Experience Platform.',
    `registration_channel` STRING COMMENT 'The channel through which the fan account was originally created. Web covers desktop/browser self-registration; mobile_app covers iOS/Android app registration; in_venue_kiosk covers on-site registration terminals; call_center covers agent-assisted registration; third_party_partner covers registrations via ticketing or partner platforms; pos covers Point of Sale (POS) terminal registration at venue merchandise or box office. Used for channel attribution and acquisition cost analysis.. Valid values are `web|mobile_app|in_venue_kiosk|call_center|third_party_partner|pos`',
    `registration_date` DATE COMMENT 'Calendar date on which the fan account was first registered and activated. Serves as EFFECTIVE_FROM for this MASTER_AGREEMENT entity. Used for cohort analysis, loyalty tenure calculations, and anniversary-based promotions.',
    `season_ticket_holder_flag` BOOLEAN COMMENT 'Indicates whether the fan account holds at least one active season ticket package for the current season. True when one or more season ticket entitlements are linked to this account. Used for priority access, renewal campaigns, and season ticket holder benefit eligibility.',
    `sms_opt_in_flag` BOOLEAN COMMENT 'Indicates whether the fan has opted in to receive SMS/text message marketing communications. True when explicit opt-in consent has been recorded. Required for TCPA compliance in the US and equivalent regulations in other jurisdictions.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp at which the fan account record was most recently modified in the source system (Salesforce CRM). Used for incremental data pipeline processing, change detection, and audit trail maintenance in the Silver Layer lakehouse.',
    `username` STRING COMMENT 'Unique login username chosen by the fan for digital platform authentication. Used across web, mobile app, and OTT (Over-The-Top Streaming) platforms. Must be unique across all active accounts. Sourced from Salesforce CRM identity management.. Valid values are `^[a-zA-Z0-9._-]{3,50}$`',
    `vip_flag` BOOLEAN COMMENT 'Indicates whether the fan account is designated as a Very Important Person (VIP), qualifying for premium hospitality, dedicated concierge services, and exclusive event access. Set by CRM administrators based on spend thresholds or manual designation.',
    CONSTRAINT pk_account PRIMARY KEY(`account_id`)
) COMMENT 'Operational account record linking a fan profile to their registered digital or venue account. Tracks account type (individual, family, corporate group), account status, registration channel (web, mobile, in-venue kiosk), login credentials metadata, account tier, and tokenized payment methods on file (card brand, last four digits, expiry, default flag, PCI-DSS token). Distinct from fan_profile (identity) — this is the transactional account used for purchases, ticketing, loyalty redemptions, and stored payment instruments. Sourced from Salesforce CRM Account object.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`fan`.`household` (
    `household_id` BIGINT COMMENT 'Unique surrogate identifier for the household record in the fan domain. Primary key for the household data product. Entity role: MASTER_PARTY — represents a family/household unit that the business interacts with as a B2C counterparty.',
    `club_membership_id` BIGINT COMMENT 'Identifier for the households official fan club membership, if applicable. Links the household to a specific fan club organization for club-level benefits, communications, and event access.',
    `franchise_id` BIGINT COMMENT 'Reference to the households primary preferred team or franchise. Drives team-specific marketing, merchandise recommendations, and event notifications for home games.',
    `fan_profile_id` BIGINT COMMENT 'Reference to the primary account holder fan profile within this household. The designated head-of-household fan who holds primary contractual and billing responsibility. Used for season ticket holder family accounts and loyalty aggregation. PARTY_REFERENCE category.',
    `merged_into_household_id` BIGINT COMMENT 'If this household record was merged into another household (status = merged), this field references the surviving household_id. Enables data lineage tracking and ensures historical records can be traced to the canonical household.',
    `team_id` BIGINT COMMENT 'Reference to the households primary preferred team or franchise. Drives team-specific marketing, merchandise recommendations, and event notifications for home games.',
    `venue_id` BIGINT COMMENT 'Reference to the households most frequently attended or preferred venue. Used for venue-specific promotions, parking pre-sales, and facility upgrade notifications.',
    `primary_fan_fan_profile_id` BIGINT COMMENT 'Reference to the primary account holder fan profile within this household. The designated head-of-household fan who holds primary contractual and billing responsibility. Used for season ticket holder family accounts and loyalty aggregation. PARTY_REFERENCE category.',
    `season_ticket_account_id` BIGINT COMMENT 'Foreign key linking to ticketing.season_ticket_account. Business justification: Household-level STH management — renewal campaigns, family account benefit allocation, and household LTV reporting require a direct household-to-STH-account link. season_ticket_account_number on house',
    `acquisition_channel` STRING COMMENT 'The channel through which the household was first acquired as a fan relationship. dtc_app refers to Direct-To-Consumer (DTC) mobile or web application. Used for Customer Acquisition Cost (CAC) analysis and channel ROI (Return on Investment) reporting. [ENUM-REF-CANDIDATE: ticketing|merchandise|dtc_app|event_registration|fan_club|referral|social_media|venue_kiosk — 8 candidates stripped; promote to reference product]',
    `acquisition_date` DATE COMMENT 'Date on which the household was first established as a fan relationship record. Used for cohort analysis, tenure-based loyalty calculations, and LTV (Lifetime Value) trajectory modeling.',
    `address_line1` STRING COMMENT 'Primary street address line for the household. Used for direct mail campaigns, season ticket holder correspondence, merchandise shipping, and deduplication of household records. Critical for direct mail deduplication per product description.',
    `address_line2` STRING COMMENT 'Secondary address line for the household (apartment, suite, unit number). Supplements address_line1 for complete postal address resolution and direct mail accuracy.',
    `annual_spend_usd` DECIMAL(18,2) COMMENT 'Total spend in US dollars attributed to the household across all revenue streams (ticketing, merchandise, concessions, streaming) in the current or most recent fiscal year. Sourced from SAP S/4HANA FI. Used for household-level revenue reporting and tier qualification.',
    `ccpa_opt_out_flag` BOOLEAN COMMENT 'Indicates whether the household has exercised their CCPA right to opt out of the sale or sharing of personal information. When True, the households data must not be sold or shared with third parties for commercial purposes.',
    `city` STRING COMMENT 'City of the households primary mailing address. Used for geographic market segmentation, regional event targeting, and RSN (Regional Sports Network) audience analysis.',
    `combined_ltv_usd` DECIMAL(18,2) COMMENT 'Aggregated Lifetime Value (LTV) in US dollars across all fan members within the household, sourced from SAP S/4HANA SD and Ticketmaster transaction history. Represents total cumulative revenue attributed to the household. Used for household-level spend analysis, VIP qualification, and retention investment prioritization. Note: this is a sourced/loaded value from the operational system, not a real-time calculation.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code for the households primary address (e.g., USA, GBR, CAN). Determines applicable privacy regulation (GDPR for EU households, CCPA for California/USA households) and international fan base reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the household record was first created in the system of record. Conforms to ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). RECORD_AUDIT_CREATED category per MASTER_PARTY role.',
    `crm_account_reference` STRING COMMENT 'External identifier for this household as recorded in the Salesforce CRM system. Enables cross-system reconciliation between the lakehouse silver layer and the operational CRM. Serves as the business-facing household reference number.',
    `data_enrichment_source` STRING COMMENT 'Indicates the origin of demographic and enrichment data for this household record. self_reported means data was provided directly by the household; third_party means sourced from a data provider; inferred means derived from behavioral signals; crm_import means loaded from Salesforce CRM; combined means multiple sources merged.. Valid values are `self_reported|third_party|inferred|crm_import|combined`',
    `deduplication_key` STRING COMMENT 'Composite hash or normalized key used for direct mail deduplication and household matching across source systems. Typically derived from a normalized combination of household name, address, and postal code. Critical for preventing duplicate mailings and double-counting in household-level spend analysis.',
    `gdpr_consent_flag` BOOLEAN COMMENT 'Indicates whether the household has provided valid GDPR consent for data processing and marketing communications. Mandatory for EU-resident households. When False, data processing must be restricted to legitimate interest or contractual necessity bases only.',
    `household_name` STRING COMMENT 'Human-readable display name for the household unit, typically the family surname or a chosen household label (e.g., The Johnson Family). Used in direct mail, CRM correspondence, and fan engagement communications. IDENTITY_LABEL category per MASTER_PARTY role.',
    `household_status` STRING COMMENT 'Current lifecycle state of the household record. active indicates an engaged household with at least one active fan member. merged indicates the household was consolidated into another. deceased indicates all primary members are deceased. LIFECYCLE_STATUS category per MASTER_PARTY role.. Valid values are `active|inactive|suspended|merged|deceased`',
    `household_type` STRING COMMENT 'Classification of the household composition. family denotes a multi-generational unit; couple denotes a two-adult unit; individual denotes a single-person household; corporate denotes a business account grouped as a household; fan_club denotes an organized fan club treated as a household unit. CLASSIFICATION_OR_TYPE category per MASTER_PARTY role.. Valid values are `family|couple|individual|corporate|fan_club`',
    `income_band` STRING COMMENT 'Estimated annual household income range derived from third-party demographic enrichment or self-reported data. Used for premium product targeting (VIP packages, luxury suites, premium season tickets), sponsorship audience profiling, and household-level spend propensity modeling.. Valid values are `under_30k|30k_60k|60k_100k|100k_150k|150k_250k|over_250k`',
    `is_season_ticket_holder` BOOLEAN COMMENT 'Indicates whether the household currently holds at least one active season ticket package across any league or venue. Critical flag for season ticket holder family account management, priority renewal communications, and dedicated account services.',
    `is_vip_member` BOOLEAN COMMENT 'Indicates whether the household holds an active VIP (Very Important Person) membership entitling members to premium hospitality, exclusive event access, and dedicated concierge services.',
    `last_engagement_date` DATE COMMENT 'Date of the most recent engagement activity recorded for any member of the household (ticket purchase, event attendance, app login, merchandise purchase, or content interaction). Used for churn risk scoring and re-engagement campaign targeting.',
    `loyalty_points_balance` STRING COMMENT 'Current aggregate loyalty points balance accumulated across all household members. Used for redemption eligibility checks, tier qualification calculations, and household-level loyalty reporting.',
    `loyalty_tier` STRING COMMENT 'Current loyalty program tier assigned to the household based on aggregated member spend, attendance, and engagement. Determines household-level benefits including priority ticketing access, merchandise discounts, and VIP event invitations. Supports multi-member loyalty aggregation as described in the product scope.. Valid values are `bronze|silver|gold|platinum|elite`',
    `marketing_opt_in_flag` BOOLEAN COMMENT 'Indicates whether the household has opted in to receive marketing communications across all channels. Distinct from GDPR consent (which is jurisdiction-specific); this is the operational marketing suppression flag used by Salesforce CRM and Adobe Experience Platform campaign tools.',
    `member_count` STRING COMMENT 'Total number of individual fan profiles currently associated with this household. Used for family ticket package eligibility, loyalty tier aggregation, and household-level capacity planning.',
    `nps_score` STRING COMMENT 'Most recent Net Promoter Score (NPS) recorded for the household, ranging from 0 to 10. Captures household-level fan satisfaction and likelihood to recommend. Supports household-level NPS tracking as specified in the product scope. Used for churn risk identification and fan experience improvement initiatives.',
    `nps_survey_date` DATE COMMENT 'Date on which the most recent NPS survey response was recorded for the household. Used to determine survey recency, schedule follow-up surveys, and track NPS trend over time.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the households primary mailing address. Used for direct mail deduplication, geographic segmentation, and proximity-based venue targeting.',
    `preferred_communication_channel` STRING COMMENT 'Households preferred channel for receiving marketing and operational communications. Drives outbound campaign channel selection in Salesforce CRM and Adobe Experience Platform to maximize engagement and respect household preferences.. Valid values are `email|sms|push|direct_mail|phone`',
    `preferred_language` STRING COMMENT 'BCP 47 language tag representing the households preferred language for communications and digital content (e.g., en, es, fr, pt-BR). Supports multilingual fan engagement across global markets.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `preferred_sport` STRING COMMENT 'Primary sport preference declared or inferred for the household (e.g., NFL, NBA, MLB, NHL, MLS, UFC). Used for targeted event recommendations, broadcast content personalization, and sponsorship audience segmentation. [ENUM-REF-CANDIDATE: NFL|NBA|MLB|NHL|MLS|UFC|ATP|FIFA|other — promote to reference product]',
    `primary_email` STRING COMMENT 'Primary email address for household-level communications including family ticket offers, loyalty program statements, and newsletter distribution. PRIMARY_CONTACT category per MASTER_PARTY role.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_phone` STRING COMMENT 'Primary contact phone number for the household. Used for outbound fan engagement calls, event notifications, and emergency contact for season ticket holders.',
    `segment_code` STRING COMMENT 'CRM-assigned segmentation code classifying the household into a strategic fan segment (e.g., SUPER_FAN, CASUAL_ATTENDEE, LAPSED, HIGH_VALUE). Drives targeted marketing campaigns, loyalty tier assignment, and personalization strategies via Adobe Experience Platform. [ENUM-REF-CANDIDATE: promote to reference product as segment codes are business-defined and numerous]',
    `state_province` STRING COMMENT 'State or province of the households primary mailing address. Used for regional compliance (CCPA for California households), tax jurisdiction determination, and geographic fan base analysis.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the household record in the system of record. Conforms to ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change data capture (CDC) processing in the Databricks lakehouse silver layer.',
    CONSTRAINT pk_household PRIMARY KEY(`household_id`)
) COMMENT 'Groups individual fan profiles into a household or family unit for B2C relationship management. Tracks household name, primary account holder reference, number of members, household address, combined lifetime value, household income band, and household segment classification. Enables family ticket packages, household-level NPS tracking, multi-member loyalty aggregation, and season ticket holder family accounts. Critical for direct mail deduplication and household-level spend analysis.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` (
    `loyalty_program_id` BIGINT COMMENT 'Unique surrogate identifier for each loyalty program record in the Sports Entertainment fan domain. Primary key for all enrollment, transaction, and tier association records.',
    `asset_id` BIGINT COMMENT 'Foreign key linking this entitlement record to the specific digital content asset being made available under the loyalty program.',
    `contract_template_id` BIGINT COMMENT 'Foreign key linking to legal.contract_template. Business justification: Loyalty program terms and conditions (points expiry, redemption rules, data use) are managed as legal contract templates requiring formal approval. Legal teams must link each loyalty program to its go',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Loyalty programs have significant operating costs (points liability fulfillment, technology, marketing) tracked against a dedicated cost center. Finance uses this link for loyalty program ROI analysis',
    `data_processing_record_id` BIGINT COMMENT 'Foreign key linking to compliance.data_processing_record. Business justification: Loyalty programs process personal data for behavioral tracking and points calculation. Under GDPR Article 30, this processing activity must be documented in the ROPA. A DPO would expect each loyalty p',
    `franchise_id` BIGINT COMMENT 'Foreign key linking to league.franchise. Business justification: Franchise-specific loyalty programs (e.g., Team X Rewards) are a standard sports-entertainment construct. Program scoping, franchise-level program performance reporting, and fan targeting require a ',
    `league_id` BIGINT COMMENT 'Reference to the league (e.g., NBA, NFL, MLB, NHL, MLS) that governs or sponsors this loyalty program. Nullable for venue-only or digital-platform-scoped programs not affiliated with a specific league.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Loyalty programs operate under specific compliance policies governing data processing consent, GDPR lawful basis, and CCPA opt-out. The program has gdpr_applicable and ccpa_applicable flags but no FK ',
    `regulatory_license_id` BIGINT COMMENT 'Foreign key linking to legal.regulatory_license. Business justification: Loyalty programs with wagering, gambling, or sweepstakes earning components require jurisdiction-specific regulatory licenses. Legal tracks license expiry and conditions; linking to the loyalty progra',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: Loyalty program revenue (paid memberships, points monetization, partner earn fees) maps to a specific finance revenue stream. Finance uses this link to budget loyalty-driven revenue separately from ti',
    `sponsor_id` BIGINT COMMENT 'Foreign key linking to sponsorship.sponsor. Business justification: Co-branded loyalty programs (e.g., Visa Rewards) are governed by a sponsor relationship. Linking loyalty_program to sponsor enables sponsor-attributed loyalty reporting, renewal analysis, and replac',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to partner.vendor_contract. Business justification: Partner loyalty programs are governed by vendor contracts specifying points liability, redemption terms, and revenue share. Linking loyalty_program to vendor_contract enables contract compliance track',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to partner.vendor. Business justification: Co-branded loyalty programs in sports entertainment are operated with specific partner vendors (retail, F&B, travel). Linking loyalty_program to vendor enables partner program management, revenue-shar',
    `venue_id` BIGINT COMMENT 'Reference to the specific venue or arena associated with this loyalty program when scope_type is venue. Nullable for league-wide or digital-platform programs. Links to Archtics venue seating and inventory management.',
    `access_tier_required` STRING COMMENT 'The minimum membership tier within the loyalty program that a fan must hold in order to access this content asset. Belongs to the entitlement, not to the program or asset alone, because the same asset may require different tiers under different programs.',
    `ccpa_applicable` BOOLEAN COMMENT 'Indicates whether this loyalty program is subject to CCPA compliance requirements due to enrollment of California-resident fans. When True, fan data processing must comply with CCPA opt-out, data deletion, and disclosure requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this loyalty program record was first created in the data platform. Follows ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for audit trail, data lineage, and SOX financial controls compliance.',
    `crm_program_reference` STRING COMMENT 'External identifier for this loyalty program as recorded in Salesforce CRM. Used for cross-system reconciliation between the lakehouse Silver layer and the Salesforce CRM operational system of record. Enables audit traceability back to the source system.',
    `currency_name` STRING COMMENT 'Branded name of the loyalty currency unit used within this program (e.g., Fan Points, Arena Credits, Court Cash, Ice Coins). Displayed to fans in all engagement touchpoints and digital wallet interfaces.',
    `currency_symbol` STRING COMMENT 'Short symbol or abbreviation representing the loyalty currency in UI displays and statements (e.g., FP, AC, pts). Used in fan-facing digital platforms and printed membership materials.. Valid values are `^.{1,10}$`',
    `digital_wallet_enabled` BOOLEAN COMMENT 'Indicates whether loyalty currency balances for this program are accessible via a digital wallet interface in the fan mobile app or OTT platform. Drives integration with Adobe Experience Platform digital wallet features and DTC fan engagement flows.',
    `earning_period_type` STRING COMMENT 'Defines the time window used for the max_earning_per_period cap. Season aligns with the sports league calendar; calendar_year resets on January 1; rolling_12_months is a continuous window; monthly resets each calendar month.. Valid values are `season|calendar_year|rolling_12_months|monthly`',
    `earning_rules_summary` STRING COMMENT 'Human-readable summary of the rules governing how fans earn loyalty currency (e.g., 1 point per $1 spent on tickets; 2x points on merchandise; 5x points on PPV purchases). Operational detail is managed in the loyalty_earning_rule reference product; this field provides a concise program-level description for reporting and fan communications.',
    `effective_end_date` DATE COMMENT 'Calendar date on which the loyalty program closes to new enrollments and earning activity. Nullable for open-ended programs with no planned sunset. Programs past this date transition to retired status.',
    `effective_start_date` DATE COMMENT 'Calendar date on which the loyalty program becomes active and open for fan enrollment and point/credit earning. Governs eligibility windows for all associated transactions.',
    `enrollment_channel` STRING COMMENT 'Primary channel through which fans enroll in this loyalty program. Web and mobile_app channels are DTC digital; venue_kiosk and POS (Point of Sale) are in-venue; crm_agent enrollments are processed by Salesforce CRM agents; partner enrollments originate from co-branded or coalition partners.. Valid values are `web|mobile_app|venue_kiosk|pos|crm_agent|partner`',
    `exclusive_window_end` DATE COMMENT 'Calendar date on which the exclusivity period for this content asset under this loyalty program ends. After this date the asset may become available more broadly or under other programs.',
    `exclusive_window_start` DATE COMMENT 'Calendar date on which this content asset becomes exclusively available to members of this loyalty program. Defines the start of the exclusivity period during which the asset is gated to this programs members only.',
    `gdpr_applicable` BOOLEAN COMMENT 'Indicates whether this loyalty program is subject to GDPR compliance requirements due to enrollment of fans in EU jurisdictions. When True, all fan data processing under this program must comply with GDPR consent, data minimisation, and right-to-erasure requirements.',
    `is_auto_enroll` BOOLEAN COMMENT 'Indicates whether fans are automatically enrolled in this program upon meeting eligibility criteria (e.g., purchasing a season ticket or subscribing to an OTT streaming service) without requiring an explicit opt-in action. True = automatic enrollment; False = explicit opt-in required.',
    `is_paid_membership` BOOLEAN COMMENT 'Indicates whether enrollment in this loyalty program requires a recurring or one-time membership fee. True = fee-based program (e.g., premium fan club subscription); False = free-to-join program. Drives billing integration with SAP S/4HANA SD module.',
    `launch_market` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the primary market in which this loyalty program was launched (e.g., USA, GBR, CAN, AUS). Used for regulatory compliance scoping, market performance reporting, and multi-market program governance.. Valid values are `^[A-Z]{3}$`',
    `loyalty_program_status` STRING COMMENT 'Current lifecycle state of the loyalty program. Active programs accept new enrollments and transactions; draft programs are in design/approval; suspended programs are temporarily halted; retired programs are closed to new activity but historical records are preserved.. Valid values are `active|inactive|draft|suspended|retired`',
    `max_earning_per_period` DECIMAL(18,2) COMMENT 'Cap on the total loyalty currency units a fan can earn within a defined period (e.g., per season, per calendar year). Controls program financial liability and prevents gaming. Null if no periodic earning cap is defined.',
    `max_earning_per_transaction` DECIMAL(18,2) COMMENT 'Cap on the number of loyalty currency units a fan can earn from a single transaction (e.g., ticket purchase, merchandise order, PPV event). Prevents abuse and controls program liability. Null if no per-transaction cap is defined.',
    `membership_fee_amount` DECIMAL(18,2) COMMENT 'Annual or periodic membership fee charged to fans for enrollment in paid loyalty programs. Expressed in the programs operating currency. Null for free-to-join programs where is_paid_membership = False. Used in SAP S/4HANA FI/CO revenue recognition.',
    `membership_fee_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the membership fee amount (e.g., USD, GBP, EUR, CAD). Required for multi-market programs operating across global leagues and venues.. Valid values are `^[A-Z]{3}$`',
    `membership_fee_frequency` STRING COMMENT 'Billing frequency for the loyalty program membership fee. Annual and seasonal fees align with sports league calendars; monthly fees support subscription-style DTC programs; one_time fees apply to lifetime memberships. Null for free programs.. Valid values are `annual|monthly|one_time|seasonal`',
    `merchandise_redemption_enabled` BOOLEAN COMMENT 'Indicates whether fans can redeem loyalty currency for merchandise purchases through the Shopify Plus e-commerce platform. When True, the program is integrated with Shopify Plus SKU catalog for redemption workflows.',
    `min_redemption_threshold` DECIMAL(18,2) COMMENT 'Minimum accumulated loyalty currency balance required before a fan is eligible to redeem points or credits. Prevents micro-redemptions and controls operational overhead (e.g., minimum 500 Fan Points before redemption is permitted).',
    `nps_tracking_enabled` BOOLEAN COMMENT 'Indicates whether Net Promoter Score (NPS) surveys are triggered for fans enrolled in this loyalty program. When True, NPS survey workflows are activated in Adobe Experience Platform following key engagement events such as event attendance or redemption.',
    `partner_program_flag` BOOLEAN COMMENT 'Indicates whether this loyalty program is operated in partnership with an external sponsor or coalition partner (e.g., co-branded credit card loyalty, airline miles partner, retail partner). True = partner-operated or co-branded; False = wholly owned by Sports Entertainment.',
    `points_cost` DECIMAL(18,2) COMMENT 'Number of loyalty currency units a fan must spend to unlock access to this content asset under this specific loyalty program. Belongs to the entitlement because the same asset may carry different points costs across different programs.',
    `points_expiry_policy` STRING COMMENT 'Policy governing when accumulated loyalty currency expires for enrolled fans. Rolling policies expire points a fixed period after earning; annual_reset clears balances at a calendar year boundary; event_based expiry ties to specific events such as season end; no_expiry means points never expire.. Valid values are `no_expiry|rolling_12_months|rolling_24_months|annual_reset|event_based`',
    `ppv_earning_enabled` BOOLEAN COMMENT 'Indicates whether fans earn loyalty currency on Pay-Per-View (PPV) broadcast purchases. When True, PPV transactions from the broadcast platform are eligible for loyalty point accrual, driving cross-domain fan engagement between broadcast and loyalty.',
    `program_code` STRING COMMENT 'Externally-known alphanumeric business identifier for the loyalty program used in CRM, ticketing, and digital platform integrations (e.g., NBA_FANPTS_2024, ARENA_CREDITS_VIP). Sourced from Salesforce CRM program catalog.. Valid values are `^[A-Z0-9_]{3,30}$`',
    `program_description` STRING COMMENT 'Full marketing and operational description of the loyalty program including its value proposition, target fan segment, and key benefits. Used in Adobe Experience Platform content personalization, CRM campaign materials, and fan-facing digital platforms.',
    `program_name` STRING COMMENT 'Human-readable marketing name of the loyalty program as displayed to fans across all channels (e.g., Fan Points Rewards, Arena Credits Club, Season Ticket Holder Elite). Used in Adobe Experience Platform personalization and fan-facing communications.',
    `program_type` STRING COMMENT 'Classification of the loyalty program structure. Points-based programs award redeemable points per transaction; tier-based programs unlock benefits at spend thresholds; hybrid combines both; subscription requires recurring fee; coalition programs span multiple partner brands.. Valid values are `points_based|tier_based|hybrid|subscription|coalition`',
    `program_version` STRING COMMENT 'Integer version number tracking major structural changes to the loyalty program rules, tier definitions, or earning/redemption rates. Incremented when program terms materially change. Supports historical analysis of program evolution and fan communication of rule changes.',
    `redemption_count` BIGINT COMMENT 'Running count of the number of times fans have redeemed this specific program-asset entitlement. Belongs to the entitlement record as an operational metric tracking demand for this content under this program.',
    `redemption_rate` DECIMAL(18,2) COMMENT 'Monetary value of one loyalty currency unit when redeemed (e.g., 0.01 means 1 Fan Point = $0.01 USD). Used to calculate redemption value in fan-facing statements and in SAP S/4HANA FI liability accounting for outstanding points balances.',
    `redemption_rules_summary` STRING COMMENT 'Human-readable summary of the rules governing how fans redeem accumulated loyalty currency (e.g., 100 points = $1 off ticket purchase; minimum 500 points to redeem; valid on GA and VIP tickets). Operational detail is managed in the loyalty_redemption_rule reference product.',
    `scope_type` STRING COMMENT 'Defines the organizational scope at which the loyalty program operates. League-scoped programs apply across all teams in a league; venue-scoped programs are specific to a single arena or stadium; team-scoped programs are tied to a single franchise; digital_platform programs operate exclusively on OTT or DTC channels; multi-property programs span multiple business units.. Valid values are `league|venue|team|digital_platform|multi_property`',
    `target_fan_segment` STRING COMMENT 'CRM-defined fan segment or audience profile that this loyalty program is designed to serve (e.g., Season Ticket Holders, VIP Members, Casual Fans, Family Accounts, Digital-Only Subscribers). Drives Adobe Experience Platform audience targeting and Salesforce CRM campaign segmentation.',
    `ticket_redemption_enabled` BOOLEAN COMMENT 'Indicates whether fans can redeem loyalty currency toward ticket purchases or upgrades through Ticketmaster/AXS or Archtics. When True, the program is integrated with the ticketing platform redemption API.',
    `tier_count` STRING COMMENT 'Number of distinct membership tiers defined within this loyalty program (e.g., 3 for Bronze/Silver/Gold; 4 for Standard/Plus/Elite/VIP). Applicable for tier_based and hybrid program types. Zero or null for pure points-based programs with no tier structure.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this loyalty program record. Follows ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change detection in downstream Silver-to-Gold ETL pipelines and audit compliance.',
    CONSTRAINT pk_loyalty_program PRIMARY KEY(`loyalty_program_id`)
) COMMENT 'Master definition of each fan loyalty program offered across leagues, venues, and digital platforms. Captures program name, program type (points-based, tier-based, hybrid), earning rules summary, redemption rules summary, program currency name (e.g., Fan Points, Arena Credits), program status, effective dates, and associated league or venue scope. Reference entity that governs all loyalty enrollment and transaction records.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` (
    `loyalty_enrollment_id` BIGINT COMMENT 'Unique surrogate identifier for a fans enrollment record in a specific loyalty program. Primary key for this entity.',
    `digital_touchpoint_id` BIGINT COMMENT 'Foreign key linking to platform.digital_touchpoint. Business justification: Digital enrollment channel attribution and touchpoint conversion funnel reporting are standard loyalty program KPIs in sports-entertainment DTC operations. Linking loyalty_enrollment to digital_touchp',
    `fan_profile_id` BIGINT COMMENT 'Reference to the fan profile record representing the individual enrolled in the loyalty program. Sourced from Salesforce CRM fan master.',
    `franchise_id` BIGINT COMMENT 'Reference to the fans primary affiliated team within the loyalty program context. Used to route team-specific rewards, communications, and event access offers.',
    `team_id` BIGINT COMMENT 'Reference to the fans primary affiliated team within the loyalty program context. Used to route team-specific rewards, communications, and event access offers.',
    `venue_id` BIGINT COMMENT 'Reference to the fans primary home venue associated with this loyalty enrollment. Used for venue-specific benefit delivery, seat upgrade offers, and venue operations planning.',
    `season_id` BIGINT COMMENT 'Foreign key linking to league.season. Business justification: Season-based loyalty programs require enrollment records linked to a specific league season for annual tier resets, points expiry processing, and season-end loyalty reporting. No existing unlinked can',
    `loyalty_program_id` BIGINT COMMENT 'Reference to the loyalty program definition record that this enrollment belongs to. One fan may hold multiple enrollments across different programs.',
    `primary_loyalty_fan_profile_id` BIGINT COMMENT 'Reference to the fan profile record representing the individual enrolled in the loyalty program. Sourced from Salesforce CRM fan master.',
    `referred_by_fan_fan_profile_id` BIGINT COMMENT 'The fan ID of the existing loyalty member who referred this fan to the program. Used to credit referral bonuses and track viral growth of the loyalty program.',
    `auto_renewal_enabled` BOOLEAN COMMENT 'Indicates whether the fan has opted in to automatic renewal of their loyalty membership at the end of the current enrollment period. Drives renewal billing and communication workflows.',
    `ccpa_opt_out` BOOLEAN COMMENT 'Indicates whether the fan has exercised their California Consumer Privacy Act (CCPA) right to opt out of the sale or sharing of their personal data associated with this loyalty enrollment.',
    `consent_timestamp` TIMESTAMP COMMENT 'The precise date and time at which the fans consent preferences (GDPR, CCPA, marketing opt-in) were last captured or updated for this enrollment. Required for regulatory audit trails.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time at which this loyalty enrollment record was first created in the data platform. Supports audit trail, data lineage, and Silver layer ingestion tracking.',
    `current_points_balance` BIGINT COMMENT 'The fans current redeemable points balance available for redemption against rewards, merchandise, tickets, or experiences. Reflects earned points minus redeemed and expired points.',
    `current_tier` STRING COMMENT 'The fans current membership tier within the loyalty program (e.g., Bronze, Silver, Gold, Platinum, Diamond). Tier determines reward multipliers, exclusive access rights, and benefit eligibility. [ENUM-REF-CANDIDATE: Bronze|Silver|Gold|Platinum|Diamond — promote to reference product if tiers vary by program]. Valid values are `Bronze|Silver|Gold|Platinum|Diamond`',
    `enrollment_channel` STRING COMMENT 'The channel through which the fan completed their loyalty program enrollment. Supports omnichannel attribution analysis and channel effectiveness reporting. [ENUM-REF-CANDIDATE: web|mobile_app|venue_kiosk|pos|call_center|partner|social_media — promote to reference product]',
    `enrollment_date` DATE COMMENT 'Calendar date on which the fan formally enrolled in the loyalty program. Used as the anchor date for anniversary-based rewards, tenure calculations, and cohort analysis.',
    `enrollment_number` STRING COMMENT 'Externally visible alphanumeric reference code assigned to this enrollment at the time of registration. Used on fan-facing communications, membership cards, and CRM lookups. Format: LYL- followed by 8–16 alphanumeric characters.. Valid values are `^LYL-[A-Z0-9]{8,16}$`',
    `enrollment_status` STRING COMMENT 'Current lifecycle state of the fans enrollment in the loyalty program. active indicates the fan is in good standing and accruing/redeeming points; suspended indicates a temporary hold; terminated indicates the enrollment has been permanently closed; pending indicates awaiting verification; expired indicates the enrollment lapsed due to inactivity or tier expiry.. Valid values are `active|suspended|terminated|pending|expired`',
    `enrollment_timestamp` TIMESTAMP COMMENT 'Precise date and time (with timezone offset) at which the fans enrollment was recorded in the source system. Supports intraday analytics and audit trail requirements.',
    `fan_club_member` BOOLEAN COMMENT 'Indicates whether the fan is also a registered fan club member in conjunction with this loyalty enrollment. Fan club membership may confer additional points multipliers or exclusive content access.',
    `gdpr_consent_given` BOOLEAN COMMENT 'Indicates whether the fan has provided explicit GDPR-compliant consent for the processing of their personal data in connection with this loyalty enrollment. Mandatory for fans in EU jurisdictions.',
    `is_primary_enrollment` BOOLEAN COMMENT 'Indicates whether this enrollment is the fans primary or preferred loyalty program when the fan holds multiple enrollments. Used for default display, primary benefit application, and CRM segmentation.',
    `lifetime_points_earned` BIGINT COMMENT 'Cumulative total of all loyalty points earned by the fan since enrollment inception, regardless of redemptions or expirations. Used as a long-term engagement metric and for Lifetime Value (LTV) analysis.',
    `marketing_opt_in` BOOLEAN COMMENT 'Indicates whether the fan has opted in to receive marketing communications (email, push, SMS) related to this loyalty program. Distinct from GDPR consent — this governs direct marketing specifically.',
    `membership_card_issued_date` DATE COMMENT 'The date on which the loyalty membership card (physical or digital) was issued to the fan. Used for card lifecycle management and replacement tracking.',
    `membership_card_number` STRING COMMENT 'The physical or digital membership card number issued to the fan for this loyalty enrollment. Used for venue access, Point of Sale (POS) identification, and reward redemption. Classified as confidential PII as it uniquely identifies the fan.. Valid values are `^[A-Z0-9]{10,20}$`',
    `next_tier_points_required` BIGINT COMMENT 'Number of additional qualifying points the fan needs to earn to reach the next loyalty tier. Supports personalized upgrade progress communications and fan engagement nudges.',
    `nps_score` STRING COMMENT 'The most recent Net Promoter Score (NPS) survey response (0–10) provided by this fan in relation to their loyalty program experience. Used to measure fan satisfaction and program advocacy. Null if no survey response has been recorded.',
    `nps_survey_date` DATE COMMENT 'The date on which the most recent NPS survey response was collected from the fan. Used to determine survey recency and schedule follow-up outreach.',
    `points_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code representing the monetary currency associated with points valuation for programs that peg points to a currency equivalent (e.g., USD, GBP, EUR). Null for pure point-based programs with no currency peg.. Valid values are `^[A-Z]{3}$`',
    `points_expiry_date` DATE COMMENT 'The date on which the fans current redeemable points balance will expire if not redeemed. Used to trigger expiry warning communications and drive redemption activity.',
    `preferred_reward_category` STRING COMMENT 'The fans stated or inferred preferred category for loyalty reward redemption (e.g., tickets, merchandise, experiences). Used for personalized reward recommendations and program design analytics.. Valid values are `tickets|merchandise|experiences|food_beverage|digital_content|charity`',
    `previous_tier` STRING COMMENT 'The fans loyalty tier immediately prior to the most recent tier change. Used for win-back campaigns, downgrade communications, and tier transition analytics.. Valid values are `Bronze|Silver|Gold|Platinum|Diamond`',
    `referral_source_code` STRING COMMENT 'Campaign or referral code used at the time of enrollment to attribute the fans sign-up to a specific marketing campaign, partner promotion, or referral event. Supports Customer Acquisition Cost (CAC) and Return on Investment (ROI) analysis.',
    `renewal_date` DATE COMMENT 'The date on which the fans loyalty enrollment is scheduled for renewal. Used to trigger renewal reminders, billing events, and lapse prevention campaigns.',
    `season_ticket_holder` BOOLEAN COMMENT 'Indicates whether the fan enrolled in this loyalty program is also a season ticket holder. Season ticket holders typically receive enhanced tier benefits and accelerated points earning rates.',
    `source_system_code` STRING COMMENT 'Identifies the operational source system from which this loyalty enrollment record was ingested into the Silver layer. Supports data lineage, reconciliation, and master data management. Values: salesforce_crm, adobe_aep, archtics, manual.. Valid values are `salesforce_crm|adobe_aep|archtics|manual`',
    `source_system_record_reference` STRING COMMENT 'The native primary key or record identifier of this enrollment in the originating source system (e.g., Salesforce CRM record ID or Adobe AEP profile ID). Used for cross-system reconciliation and lineage tracing.',
    `termination_date` DATE COMMENT 'The date on which the fans loyalty enrollment was permanently terminated or cancelled. Null if the enrollment is still active. Supports GDPR right-to-erasure and CCPA opt-out compliance workflows.',
    `termination_reason` STRING COMMENT 'The business reason for the termination of the fans loyalty enrollment. Used for churn analysis, compliance reporting, and program health monitoring.. Valid values are `fan_request|non_renewal|fraud|program_closure|inactivity|deceased`',
    `tier_change_reason` STRING COMMENT 'The business reason for the most recent change to the fans loyalty tier. Supports audit trails, fan communications, and program governance reporting.. Valid values are `upgrade|downgrade|initial_assignment|program_restructure|manual_override`',
    `tier_expiry_date` DATE COMMENT 'The date on which the fans current tier status expires if qualifying activity thresholds are not maintained. After this date, the fan may be downgraded to a lower tier per program rules.',
    `tier_qualification_date` DATE COMMENT 'The date on which the fan qualified for their current loyalty tier. Used to determine tier anniversary, tier protection windows, and downgrade eligibility assessments.',
    `tier_qualifying_points_ytd` BIGINT COMMENT 'Points accumulated within the current qualification period (typically a rolling 12-month or calendar year window) that count toward tier maintenance or upgrade thresholds. Distinct from redeemable balance.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time at which this loyalty enrollment record was most recently modified in the data platform. Used for change detection, incremental processing, and audit compliance.',
    `vip_status` BOOLEAN COMMENT 'Indicates whether the fan holds Very Important Person (VIP) designation within this loyalty enrollment, granting access to premium experiences, hospitality suites, and exclusive events.',
    CONSTRAINT pk_loyalty_enrollment PRIMARY KEY(`loyalty_enrollment_id`)
) COMMENT 'Records a fans active enrollment in a specific loyalty program. Tracks enrollment date, current tier (e.g., Bronze, Silver, Gold, Platinum), tier qualification date, tier expiry date, cumulative points earned lifetime, current redeemable points balance, points expiry date, enrollment channel, and enrollment status. One fan may be enrolled in multiple programs. Sourced from Salesforce CRM and Adobe Experience Platform loyalty modules.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` (
    `loyalty_transaction_id` BIGINT COMMENT 'Unique surrogate identifier for each loyalty point transaction record in the ledger. Primary key for the loyalty_transaction data product.',
    `calendar_id` BIGINT COMMENT 'Foreign key linking to event.event_calendar. Business justification: Season-level loyalty earning aggregation drives annual tier qualification resets and season-end loyalty reporting — a core loyalty program business process. loyalty_transaction has league_id but no se',
    `digital_touchpoint_id` BIGINT COMMENT 'Foreign key linking to platform.digital_touchpoint. Business justification: Channel-level loyalty earning attribution (points earned via mobile app vs. web portal vs. stadium kiosk) is a standard loyalty operations KPI in sports-entertainment. Linking loyalty_transaction to d',
    `engagement_event_id` BIGINT COMMENT 'Reference to the sports or entertainment event associated with this loyalty transaction (e.g., the game or concert at which a check-in was recorded or a ticket was purchased). Enables event-level loyalty analytics and attendance-based point attribution.',
    `fan_profile_id` BIGINT COMMENT 'Reference to the fan profile who is the subject of this loyalty transaction. Supports direct fan-level reporting without requiring a join through enrollment.',
    `franchise_id` BIGINT COMMENT 'Foreign key linking to league.franchise. Business justification: Franchise-level loyalty transaction reporting (points earned at specific franchise events, franchise-attributed redemptions) and revenue sharing calculations between league and franchises require a fr',
    `league_id` BIGINT COMMENT 'Reference to the league or competition governing body associated with this loyalty transaction. Supports multi-league organizations (e.g., NFL, NBA, MLS) in attributing loyalty activity to specific league properties for revenue sharing and reporting.',
    `loyalty_enrollment_id` BIGINT COMMENT 'Reference to the fan loyalty program enrollment record that owns this transaction. Links the transaction to the specific fans program membership.',
    `loyalty_program_id` BIGINT COMMENT 'Reference to the specific loyalty program under which this transaction was processed. Supports organizations running multiple loyalty programs (e.g., league-wide program vs. venue-specific program vs. broadcast subscription program).',
    `membership_tier_id` BIGINT COMMENT 'Reference to the fans loyalty membership tier at the time of this transaction (e.g., Bronze, Silver, Gold, Platinum, VIP). Captures the tier context for point multiplier application and tier-based benefit eligibility at the time of the event.',
    `nps_survey_id` BIGINT COMMENT 'Reference to an NPS survey completion event that triggered this loyalty transaction, if the activity_type is survey_completion. Null for all other activity types. Links loyalty incentivization to fan satisfaction measurement programs.',
    `pipeline_run_id` BIGINT COMMENT 'Identifier for the batch processing run that generated or confirmed this loyalty transaction, if applicable (e.g., nightly post-event check-in reconciliation batch or monthly points expiry batch). Null for real-time transactions. Supports batch reconciliation and reprocessing.',
    `ppv_package_id` BIGINT COMMENT 'Foreign key linking to broadcast.ppv_package. Business justification: Loyalty points redeemed for PPV access must reference the specific PPV package being redeemed. loyalty_program has ppv_earning_enabled flag; this FK enables redemption fulfillment tracking and PPV-loy',
    `primary_loyalty_fan_profile_id` BIGINT COMMENT 'Reference to the fan profile who is the subject of this loyalty transaction. Supports direct fan-level reporting without requiring a join through enrollment.',
    `promotion_id` BIGINT COMMENT 'Reference to the promotional campaign or bonus multiplier offer that influenced the points calculation for this transaction. Null if no promotion was applied. Supports promotion performance measurement and ROI analysis.',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: Loyalty points transactions must be classified against a revenue stream for deferred revenue accounting (points liability) and revenue recognition upon redemption. Finance uses this to report loyalty ',
    `reversal_of_transaction_loyalty_transaction_id` BIGINT COMMENT 'Self-referencing identifier pointing to the original loyalty transaction that this record reverses or corrects. Null for original transactions. Enables full audit chain reconstruction for reversed or adjusted point movements.',
    `reward_id` BIGINT COMMENT 'Reference to the specific reward catalog item redeemed in this transaction. Populated only for redemption-type transactions. Enables reward popularity analytics and redemption rate reporting.',
    `ticket_order_id` BIGINT COMMENT 'Reference to the originating order or purchase transaction that triggered this loyalty earn or redemption event (e.g., a ticket order in Ticketmaster/AXS or a merchandise order in Shopify Plus). Null for non-order-triggered transactions such as check-ins or content views.',
    `transfer_target_fan_fan_profile_id` BIGINT COMMENT 'For transfer-type transactions, the fan profile ID of the recipient who receives the transferred points. Null for all non-transfer transaction types. Supports family account and fan-to-fan transfer tracking.',
    `venue_id` BIGINT COMMENT 'Reference to the venue where the triggering activity occurred, if applicable (e.g., in-venue check-in, POS purchase, or gate scan). Null for digital or non-venue activities. Enables venue-level loyalty analytics and location-based engagement reporting.',
    `wager_id` BIGINT COMMENT 'Foreign key linking to gaming.wager. Business justification: Loyalty points earned on wagers: when a bettor earns loyalty points for placing a wager, the loyalty transaction must reference the originating wager for points calculation audit, dispute resolution, ',
    `activity_channel` STRING COMMENT 'The engagement channel through which the triggering activity was performed. Distinguishes between mobile app, web portal, venue Point of Sale (POS) terminal, call center, or partner system. Supports omnichannel loyalty analytics and channel attribution.. Valid values are `mobile_app|web|venue_kiosk|pos|call_center|partner`',
    `activity_type` STRING COMMENT 'The specific fan activity that triggered this loyalty transaction. Identifies the business action that caused the point movement, enabling activity-level analytics and program ROI measurement. [ENUM-REF-CANDIDATE: ticket_purchase|merchandise_purchase|event_check_in|content_view|referral|social_share|survey_completion|app_login|ppv_purchase|subscription_renewal — promote to reference product]',
    `base_points_amount` DECIMAL(18,2) COMMENT 'The raw points amount calculated before any multiplier, bonus, or promotional adjustment is applied. Together with points_multiplier and points_amount, provides a full audit trail of the points calculation logic.',
    `ccpa_opt_out` BOOLEAN COMMENT 'Indicates whether the fan has exercised their CCPA right to opt out of the sale or sharing of personal data at the time of this transaction. True = fan has opted out; False = no opt-out recorded. Required for California market compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this loyalty transaction record was first created in the data platform. Audit field supporting data lineage, SLA compliance measurement, and Silver layer ingestion tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the monetary_value associated with this loyalty transaction (e.g., USD, GBP, EUR). Supports multi-currency operations across global markets.. Valid values are `^[A-Z]{3}$`',
    `gdpr_consent_verified` BOOLEAN COMMENT 'Indicates whether the fans GDPR consent for loyalty data processing was verified as active at the time of this transaction. True = consent confirmed; False = consent not confirmed or withdrawn. Critical for EU market compliance and data processing lawfulness.',
    `is_bonus_transaction` BOOLEAN COMMENT 'Indicates whether this transaction represents a bonus points award outside of the standard earn rate (e.g., birthday bonus, milestone bonus, welcome bonus, special event bonus). True = bonus transaction; False = standard transaction. Supports bonus program analytics and cost tracking.',
    `is_tier_qualifying` BOOLEAN COMMENT 'Indicates whether the points from this transaction count toward the fans tier qualification threshold (some programs separate qualifying points from total points). True = counts toward tier qualification; False = does not count (e.g., bonus or promotional points). Supports tier progression analytics.',
    `monetary_value` DECIMAL(18,2) COMMENT 'The monetary spend amount (in the operating currency) associated with the triggering activity for this transaction. Used to calculate earn rates (points per dollar spent) and to measure the financial value of loyalty-driving purchases. Applicable for purchase-triggered transactions.',
    `notes` STRING COMMENT 'Free-text field for customer service agents or loyalty operations staff to record contextual notes about this transaction (e.g., manual adjustment rationale, escalation context, special circumstance). Supports operational transparency and audit documentation.',
    `points_amount` DECIMAL(18,2) COMMENT 'The number of loyalty points earned, redeemed, adjusted, expired, or transferred in this transaction. Positive values represent points added to the balance; negative values represent points deducted. Decimal precision supports fractional point awards from multiplier promotions.',
    `points_balance_after` DECIMAL(18,2) COMMENT 'The fans total loyalty point balance immediately after this transaction was applied. Provides a running ledger balance for audit trail purposes and enables point balance reconstruction at any point in time without aggregation.',
    `points_expiry_date` DATE COMMENT 'The date on which the points earned in this transaction are scheduled to expire if not redeemed, per the loyalty programs expiration policy. Null for non-earn transactions or programs with no expiry. Supports proactive fan communications and expiry-driven engagement campaigns.',
    `points_multiplier` DECIMAL(18,2) COMMENT 'The multiplier factor applied to the base points calculation for this transaction, driven by membership tier, active promotions, or special event bonuses. A value of 1.00 indicates no multiplier; 2.00 indicates double points. Supports audit of why a fan received a specific points amount.',
    `processing_date` DATE COMMENT 'The calendar date on which the loyalty transaction was processed and applied to the fans balance by the loyalty management system. May differ from transaction_timestamp for batch-processed or delayed-confirmation transactions (e.g., post-event check-in reconciliation).',
    `redemption_value` DECIMAL(18,2) COMMENT 'The monetary equivalent value of the points redeemed in this transaction, expressed in the operating currency. Populated only for redemption-type transactions. Used for loyalty liability accounting, reward cost tracking, and EBITDA impact analysis.',
    `reversal_reason` STRING COMMENT 'Free-text or coded explanation for why a transaction was reversed or adjusted. Populated only when transaction_status is reversed or transaction_type is adjust. Supports audit compliance and customer service resolution tracking.',
    `source_system_code` STRING COMMENT 'Identifies the operational system of record that originated this loyalty transaction event. Supports data lineage, reconciliation, and system-of-record traceability across the loyalty ecosystem. [ENUM-REF-CANDIDATE: salesforce_crm|adobe_aep|ticketmaster|axs|shopify|sap_s4|archtics|manual — promote to reference product]',
    `source_transaction_reference` STRING COMMENT 'The native transaction identifier from the originating source system (e.g., Ticketmaster order number, Shopify order ID, SAP document number). Enables cross-system reconciliation and traceability back to the system of record.',
    `tier_qualifying_points` DECIMAL(18,2) COMMENT 'The number of points from this transaction that count specifically toward the fans tier qualification balance, which may differ from the total points_amount when bonus or promotional points are excluded from tier calculations.',
    `transaction_reference_number` STRING COMMENT 'Externally visible, human-readable reference number assigned to this loyalty transaction. Used in fan-facing communications, customer service lookups, and audit trails. Format: LT- followed by 10 digits.. Valid values are `^LT-[0-9]{10}$`',
    `transaction_status` STRING COMMENT 'Current workflow state of the loyalty transaction. Pending indicates awaiting confirmation from the triggering system; confirmed indicates points have been applied to the balance; reversed indicates a corrective rollback; failed indicates a processing error; cancelled indicates voided before application.. Valid values are `pending|confirmed|reversed|failed|cancelled`',
    `transaction_timestamp` TIMESTAMP COMMENT 'The precise date and time at which the loyalty point event occurred in the real world (e.g., when the ticket was purchased, when the check-in was recorded, when the content was viewed). This is the principal business event time, distinct from record audit timestamps.',
    `transaction_type` STRING COMMENT 'Classifies the nature of the loyalty point movement: earn (points awarded for qualifying activity), redeem (points spent by fan), adjust (manual correction or bonus), expire (points removed due to inactivity or policy), transfer (points moved between accounts).. Valid values are `earn|redeem|adjust|expire|transfer`',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this loyalty transaction record was most recently modified in the data platform (e.g., status update from pending to confirmed, or reversal applied). Supports change data capture and audit trail completeness.',
    CONSTRAINT pk_loyalty_transaction PRIMARY KEY(`loyalty_transaction_id`)
) COMMENT 'Transactional ledger of all loyalty point earning and redemption events for a fan. Captures transaction type (earn, redeem, adjust, expire, transfer), points amount, transaction date, triggering activity (ticket purchase, merchandise buy, check-in, content view, referral), reference order or event ID, running balance after transaction, and transaction status. Provides full audit trail for loyalty currency movements per fan enrollment.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`fan`.`membership` (
    `membership_id` BIGINT COMMENT 'Unique system-generated surrogate key identifying a fan membership record. Primary key for the membership data product within the fan domain.',
    `access_zone_id` BIGINT COMMENT 'Foreign key linking to the physical access zone to which access is being granted.',
    `seat_id` BIGINT COMMENT 'Foreign key linking to venue.seat. Business justification: Season ticket membership management requires tracking the specific assigned seat for each member — core to seat manifest reconciliation, ADA compliance reporting, and renewal/relocation workflows. Rol',
    `benefit_package_id` BIGINT COMMENT 'Reference to the standardized benefit package definition assigned to this membership, specifying the bundle of entitlements (priority ticketing, parking, merchandise discount, VIP lounge, meet-and-greet, exclusive content). Separates the benefit catalog from the individual membership record.',
    `calendar_id` BIGINT COMMENT 'Foreign key linking to event.event_calendar. Business justification: Season ticket memberships are fundamentally season-scoped products; renewal campaigns, seat allocation, and season-over-season retention reporting all operate at the event_calendar (season) level. mem',
    `contract_template_id` BIGINT COMMENT 'Foreign key linking to legal.contract_template. Business justification: Season ticket and VIP memberships are governed by legal contract templates defining T&Cs, IP rights, data privacy clauses, and termination conditions. Legal compliance audits and renewal reviews requi',
    `account_id` BIGINT COMMENT 'Reference to the corporate account record in Salesforce CRM when is_corporate is True. Links individual membership seats to the parent corporate purchaser for consolidated billing and reporting.',
    `digital_subscription_id` BIGINT COMMENT 'Foreign key linking to platform.digital_subscription. Business justification: Sports-entertainment fan memberships (season tickets, VIP) frequently bundle digital streaming subscriptions as a benefit. Linking membership to digital_subscription enables bundled product renewal co',
    `employee_id` BIGINT COMMENT 'Reference to the internal sales representative or account manager in Salesforce CRM who sold or manages this membership. Used for commission tracking and sales performance reporting.',
    `family_account_id` BIGINT COMMENT 'Reference to the family account grouping record when this membership is part of a family plan. Enables consolidated family membership management, shared benefit pools, and family-level reporting.',
    `fan_fan_profile_id` BIGINT COMMENT 'Reference to the fan profile record that holds this membership. Links the membership contractual record to the fan identity master in the Salesforce CRM fan domain.',
    `fan_profile_id` BIGINT COMMENT 'Reference to the fan profile record that holds this membership. Links the membership contractual record to the fan identity master in the Salesforce CRM fan domain.',
    `franchise_id` BIGINT COMMENT 'Reference to the sports team or franchise for which this membership is issued. Supports multi-team enterprise environments (e.g., NBA, NFL, MLS franchises under a single ownership group).',
    `league_id` BIGINT COMMENT 'Reference to the governing league or competition body under which this membership is issued (e.g., NFL, NBA, MLS, UFC). Supports cross-league membership analytics and compliance reporting.',
    `season_id` BIGINT COMMENT 'Foreign key linking to league.season. Business justification: Season ticket memberships are explicitly tied to a league season for renewal processing, revenue recognition by season, and compliance reporting. Sports-entertainment domain experts universally expect',
    `parking_lot_id` BIGINT COMMENT 'Foreign key linking to venue.parking_lot. Business justification: Season ticket memberships include parking pass benefits tied to a designated lot. Parking operations teams use this FK for lot capacity planning, pass fulfillment, and member benefit audits. membershi',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: Membership fee revenue (season tickets, VIP, corporate) is classified by revenue stream for financial reporting and budgeting. Finance requires this link to produce membership revenue reports by strea',
    `sales_rep_employee_id` BIGINT COMMENT 'Reference to the internal sales representative or account manager in Salesforce CRM who sold or manages this membership. Used for commission tracking and sales performance reporting.',
    `season_ticket_package_id` BIGINT COMMENT 'Foreign key linking to ticketing.season_ticket_package. Business justification: STH membership management — renewal processing, benefit fulfilment, and loyalty tier qualification all require knowing which season_ticket_package the membership is based on. A sports-entertainment ST',
    `seating_section_id` BIGINT COMMENT 'Reference to the assigned seat block or seating inventory allocation associated with this membership (e.g., season ticket seat section/row/seat range). Sourced from Archtics venue seating and inventory management system.',
    `tax_jurisdiction_id` BIGINT COMMENT 'Foreign key linking to finance.tax_jurisdiction. Business justification: Membership fees are subject to jurisdiction-specific entertainment taxes and sales taxes. Finance requires tax jurisdiction on the membership record to calculate correct tax liability, support multi-s',
    `team_id` BIGINT COMMENT 'Reference to the sports team or franchise for which this membership is issued. Supports multi-team enterprise environments (e.g., NBA, NFL, MLS franchises under a single ownership group).',
    `venue_id` BIGINT COMMENT 'Reference to the primary venue associated with this membership (e.g., home arena or stadium for a season ticket holder). Links to the venue domain master record.',
    `access_tier` STRING COMMENT 'The tier level at which this membership is permitted to access the zone. Determines the scope of privileges within the zone (e.g., a VIP membership may have a higher access tier than a standard season ticket in the same zone). Belongs to the grant, not to the membership or zone alone.',
    `auto_renew_flag` BOOLEAN COMMENT 'Indicates whether the membership is configured to automatically renew at the end of the current term without requiring explicit fan action. Drives automated billing cycles in SAP S/4HANA FI and renewal notifications in Adobe Experience Platform.',
    `cancellation_date` DATE COMMENT 'Date on which the membership was formally cancelled by the fan or the organization. Null if the membership has not been cancelled. Used for churn analysis, refund processing, and GDPR data retention scheduling.',
    `cancellation_reason` STRING COMMENT 'Reason code for membership cancellation. Used for churn root-cause analysis, retention strategy development, and reporting to league governance bodies.. Valid values are `fan_request|non_payment|relocation|dissatisfaction|deceased|corporate_termination`',
    `ccpa_opt_out_flag` BOOLEAN COMMENT 'Indicates whether the fan has exercised their CCPA (California Consumer Privacy Act) right to opt out of the sale or sharing of their personal information. Mandatory for California-resident members. Drives data sharing restrictions in Salesforce CRM and Adobe Experience Platform.',
    `channel` STRING COMMENT 'Sales or acquisition channel through which the fan purchased or enrolled in the membership. Used for channel attribution, CAC (Customer Acquisition Cost) analysis, and marketing ROI reporting.. Valid values are `online|mobile_app|box_office|phone|corporate|partner`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the membership record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Serves as the RECORD_AUDIT_CREATED field for this MASTER_AGREEMENT entity. Used for data lineage, audit trails, and SLA compliance.',
    `credential_type` STRING COMMENT 'The credential format required to exercise this specific zone access grant for this membership. May differ from the zones default credential_type_required when a membership tier is granted an override credential method. Belongs to the grant, not to the zone alone.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the membership fee and any financial values on this record (e.g., USD, GBP, EUR, AUD). Supports multi-market operations across global leagues.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary discount applied to the standard membership fee for this fan (e.g., loyalty discount, promotional offer, staff complimentary reduction). Used in net revenue calculations and promotional effectiveness reporting.',
    `end_date` DATE COMMENT 'Calendar date on which the membership agreement expires and benefits cease. Nullable for open-ended memberships. Serves as the EFFECTIVE_UNTIL for this MASTER_AGREEMENT entity. Formatted yyyy-MM-dd per platform convention.',
    `exclusive_content_flag` BOOLEAN COMMENT 'Indicates whether this membership grants access to exclusive digital content (behind-the-scenes footage, member-only streams, editorial content) via OTT (Over-The-Top Streaming) or DTC (Direct-To-Consumer) platforms.',
    `fee` DECIMAL(18,2) COMMENT 'Gross fee amount charged to the fan for the membership per payment frequency cycle, in the operating currency. Represents the contractual price before any discounts or waivers. Used in revenue recognition and EBITDA reporting.',
    `gdpr_consent_flag` BOOLEAN COMMENT 'Indicates whether the fan has provided valid GDPR (General Data Protection Regulation) consent for processing their personal data in connection with this membership. Mandatory for EU-market members. Drives data processing eligibility in Adobe Experience Platform.',
    `grant_status` STRING COMMENT 'Current lifecycle status of this zone access grant. Allows individual membership-zone permissions to be suspended or revoked independently of the membership status or zone status — e.g., revoking field-level access for a member under investigation without cancelling their full membership.',
    `is_corporate` BOOLEAN COMMENT 'Indicates whether this membership is held under a corporate account (B2B) rather than an individual fan (B2C). Corporate memberships may have different billing, benefit allocation, and compliance requirements.',
    `is_vip` BOOLEAN COMMENT 'Indicates whether this membership grants VIP (Very Important Person) status, entitling the fan to premium hospitality, lounge access, and priority services. Distinct from membership_tier — a flag used operationally for real-time access control at venues.',
    `lounge_access_flag` BOOLEAN COMMENT 'Indicates whether this membership grants access to VIP (Very Important Person) lounge facilities at the venue. Operationally consumed by Ticketmaster/AXS access control and venue operations teams.',
    `marketing_opt_in_flag` BOOLEAN COMMENT 'Indicates whether the member has opted in to receive marketing communications (email, SMS, push notifications) from the organization. Distinct from GDPR consent — this governs direct marketing specifically. Consumed by Adobe Experience Platform campaign orchestration.',
    `meet_greet_allotment` STRING COMMENT 'Number of meet-and-greet experiences allocated to this membership per season or membership term. Zero indicates no meet-and-greet benefit. Used for experience inventory management and fan engagement reporting.',
    `membership_number` STRING COMMENT 'Externally visible, human-readable membership identifier printed on membership cards and used in fan-facing communications. Sourced from Archtics venue seating and inventory management system. Serves as the BUSINESS_IDENTIFIER for this MASTER_AGREEMENT entity.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `membership_status` STRING COMMENT 'Current lifecycle state of the membership agreement. Drives access control decisions in Ticketmaster/AXS, benefit eligibility checks, and CRM segmentation in Salesforce. Serves as the LIFECYCLE_STATUS for this MASTER_AGREEMENT entity.. Valid values are `active|suspended|cancelled|expired|pending_renewal|pending_activation`',
    `membership_tier` STRING COMMENT 'Benefit tier level within a membership type, defining the package of perks and privileges available to the fan (e.g., Bronze through Diamond for VIP club memberships). Drives benefit entitlement rules and pricing.. Valid values are `bronze|silver|gold|platinum|diamond`',
    `membership_type` STRING COMMENT 'Classification of the membership product tier. Distinguishes paid contractual relationships (season ticket holder, VIP club, fan club, OTT subscription, corporate) from complimentary grants. Drives benefit package assignment and revenue reporting. Serves as the CLASSIFICATION_OR_TYPE for this MASTER_AGREEMENT entity.. Valid values are `season_ticket_holder|vip_club|fan_club|ott_subscription|complimentary|corporate`',
    `merchandise_discount_pct` DECIMAL(18,2) COMMENT 'Percentage discount on merchandise purchases granted to the member as part of their benefit package. Applied at point of sale in Shopify Plus e-commerce and venue POS (Point of Sale) systems.',
    `net_fee` DECIMAL(18,2) COMMENT 'Actual fee payable by the fan after applying discounts and waivers (membership_fee minus discount_amount). Used for revenue recognition, accounts receivable, and fan-facing billing statements.',
    `nps_score` STRING COMMENT 'Most recent NPS (Net Promoter Score) survey response from the member, on a 0–10 scale. Captured via Adobe Experience Platform fan surveys. Used for membership satisfaction tracking, churn prediction, and renewal propensity modeling.',
    `nps_survey_date` DATE COMMENT 'Date on which the most recent NPS (Net Promoter Score) survey response was recorded for this member. Used to assess recency of satisfaction data and trigger re-survey workflows.',
    `parking_pass_flag` BOOLEAN COMMENT 'Indicates whether a parking pass benefit is included in this membership. Drives parking inventory allocation in venue operations and access control at parking facilities.',
    `payment_frequency` STRING COMMENT 'Cadence at which the membership fee is charged to the fan. Determines billing schedule in SAP S/4HANA FI/CO and payment plan configuration in Ticketmaster/AXS.. Valid values are `annual|semi_annual|quarterly|monthly|one_time`',
    `payment_plan_flag` BOOLEAN COMMENT 'Indicates whether the fan is on an installment payment plan rather than paying the full membership fee upfront. Drives installment schedule management in SAP S/4HANA FI and Ticketmaster/AXS.',
    `priority_ticketing_flag` BOOLEAN COMMENT 'Indicates whether this membership grants priority access to ticket purchases before general public on-sale dates. Operationally consumed by Ticketmaster/AXS pre-sale access control.',
    `renewal_status` STRING COMMENT 'Indicates whether the fan has renewed, declined, or is pending a renewal decision for the upcoming membership term. Used by CRM teams in Salesforce for retention campaigns and churn risk scoring.. Valid values are `renewed|not_renewed|pending|lapsed|cancelled`',
    `seat_block_reference` BIGINT COMMENT 'Reference to the assigned seat block or seating inventory allocation associated with this membership (e.g., season ticket seat section/row/seat range). Sourced from Archtics venue seating and inventory management system.',
    `start_date` DATE COMMENT 'Calendar date on which the membership agreement becomes effective and benefits are first accessible to the fan. Serves as the EFFECTIVE_FROM for this MASTER_AGREEMENT entity. Formatted yyyy-MM-dd per platform convention.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the membership record, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change data capture (CDC) in the Databricks Silver Layer pipeline and audit trail compliance.',
    `valid_until` DATE COMMENT 'Calendar date on which this zone access grant expires. Enables time-bounded access permissions independent of the membership end date (e.g., field-level access only during playoffs). Belongs to the grant, not to the membership or zone alone.',
    `waitlist_flag` BOOLEAN COMMENT 'Indicates whether this membership record represents a fan on the waitlist for a sold-out membership tier (e.g., season ticket waitlist). Waitlisted records have membership_status of pending_activation until inventory becomes available.',
    `waitlist_position` STRING COMMENT 'Numeric position of the fan on the membership waitlist when waitlist_flag is True. Lower numbers indicate higher priority for membership offer. Null when not on waitlist.',
    `zone_access_level` STRING COMMENT 'The specific level of access within the zone granted to this membership — e.g., entry-only vs. full access vs. escorted access only. Varies per membership-zone combination and belongs to the grant record.',
    `valid_from` DATE COMMENT 'Calendar date from which this zone access grant becomes effective. Allows access permissions to be pre-configured before a season or event and activated on a specific date. Belongs to the grant, not to the membership or zone alone.',
    CONSTRAINT pk_membership PRIMARY KEY(`membership_id`)
) COMMENT 'Master record for a fans paid or complimentary membership and its associated benefits. Tracks membership type (season ticket holder, VIP club, fan club, OTT subscription), membership number, start/end dates, renewal status, auto-renew flag, fee, payment frequency, assigned seat block, and membership status. Also defines attached benefits: benefit type (priority ticketing, parking pass, merchandise discount, VIP lounge access, meet-and-greet, exclusive content), quantity/usage limits, redemption method, benefit value, and validity period. Distinct from loyalty enrollment — membership is a paid contractual relationship with defined benefit packages, not a points program.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` (
    `membership_benefit_id` BIGINT COMMENT 'Unique surrogate identifier for each membership benefit record in the fan domain. Primary key for the membership_benefit data product.',
    `access_entitlement_id` BIGINT COMMENT 'Foreign key linking to ticketing.access_entitlement. Business justification: Membership benefit fulfilment tracking — complimentary tickets and VIP access benefits are fulfilled as access entitlements. Operations teams must reconcile which entitlement was issued per benefit fo',
    `ada_accommodation_id` BIGINT COMMENT 'Foreign key linking to compliance.ada_accommodation. Business justification: Membership benefits include ADA accommodations (companion seats, accessible parking, interpreter services). Linking the membership benefit entitlement to the compliance ADA accommodation record enable',
    `athlete_profile_id` BIGINT COMMENT 'Foreign key linking to athlete.athlete_profile. Business justification: Athlete appearance and meet-and-greet benefit fulfillment: VIP and premium membership packages in sports entertainment include athlete-specific benefits (signed merchandise, meet-and-greet allotments,',
    `competition_round_id` BIGINT COMMENT 'Foreign key linking to event.competition_round. Business justification: Playoff/round-specific membership benefit packages (e.g., playoff round access, finals hospitality) are a standard sports entertainment membership product. membership_benefit has fixture_id for si',
    `asset_id` BIGINT COMMENT 'Foreign key linking to content.asset. Business justification: Exclusive content entitlement: membership benefits grant access to specific content assets (e.g., behind-the-scenes video, PPV highlights). Sports entertainment operations track which content asset is',
    `deal_id` BIGINT COMMENT 'Foreign key linking to sponsorship.deal. Business justification: Sponsorship deals contractually fund specific membership benefits (e.g., a sponsor provides hospitality access or merchandise discounts to season ticket holders). Linking membership_benefit to deal en',
    `event_fixture_id` BIGINT COMMENT 'Reference to a specific event to which this benefit is scoped, when the benefit is event-specific rather than season-wide (e.g., a meet-and-greet benefit valid only for a specific fixture or concert). Nullable for season-wide or perpetual benefits.',
    `fixture_id` BIGINT COMMENT 'Reference to a specific event to which this benefit is scoped, when the benefit is event-specific rather than season-wide (e.g., a meet-and-greet benefit valid only for a specific fixture or concert). Nullable for season-wide or perpetual benefits.',
    `franchise_id` BIGINT COMMENT 'Foreign key linking to league.franchise. Business justification: Franchise-specific membership benefits (meet-and-greet with home team, franchise merchandise discounts, exclusive franchise content access) require a franchise FK for benefit eligibility rules and fra',
    `membership_id` BIGINT COMMENT 'Reference to the individual fan membership record to which this benefit is directly assigned. Populated when the benefit is granted at the individual membership level rather than at the tier level. Nullable when benefit is tier-wide.',
    `membership_tier_id` BIGINT COMMENT 'Reference to the membership tier to which this benefit is attached. Links the benefit to a specific tier level (e.g., Silver, Gold, Platinum, VIP) within the fan loyalty program.',
    `ppv_package_id` BIGINT COMMENT 'Foreign key linking to broadcast.ppv_package. Business justification: Premium and VIP membership benefits include PPV access grants. Linking membership_benefit to the specific ppv_package enables benefit fulfillment tracking, entitlement validation at purchase, and repo',
    `promotion_id` BIGINT COMMENT 'Foreign key linking to merchandise.promotion. Business justification: Membership benefits are frequently fulfilled via merchandise promotions (e.g., 25% off licensed apparel for gold members). Linking membership_benefit to the specific promotion enables benefit redempti',
    `service_order_id` BIGINT COMMENT 'Foreign key linking to partner.service_order. Business justification: VIP and premium membership benefits (meet-and-greet, hospitality suite, event-day services) are operationally fulfilled via vendor service orders. Linking membership_benefit to service_order enables f',
    `sku_catalog_id` BIGINT COMMENT 'Foreign key linking to merchandise.sku_catalog. Business justification: Membership benefit fulfilment (e.g., free jersey for VIP tier) requires knowing the exact SKU to reserve inventory and trigger pick-pack-ship. Sports entertainment operators track which merchandise SK',
    `sponsor_id` BIGINT COMMENT 'Reference to the sponsorship or commercial partner responsible for co-funding or delivering this benefit (e.g., a sponsor providing branded merchandise discounts or hospitality experiences). Links to the sponsorship domain for partner benefit attribution and ROI reporting.',
    `tournament_id` BIGINT COMMENT 'Foreign key linking to event.tournament. Business justification: Tournament access membership benefits (full tournament passes, hospitality packages for multi-day tournaments) are a named product in sports entertainment. membership_benefit has fixture_id for single',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to partner.vendor_contract. Business justification: Membership benefits (lounge access, F&B credits, merchandise discounts) are fulfilled under specific vendor contracts. Linking membership_benefit to vendor_contract enables benefit cost allocation, co',
    `vendor_id` BIGINT COMMENT 'Reference to the sponsorship or commercial partner responsible for co-funding or delivering this benefit (e.g., a sponsor providing branded merchandise discounts or hospitality experiences). Links to the sponsorship domain for partner benefit attribution and ROI reporting.',
    `venue_id` BIGINT COMMENT 'Foreign key linking to venue.venue. Business justification: Membership benefits (lounge access, priority entry, in-venue discounts) are often venue-specific. Benefit fulfillment and redemption reporting requires knowing which venue a benefit applies to. member',
    `benefit_category` STRING COMMENT 'High-level grouping of the benefit for reporting and analytics segmentation. Distinguishes between access-based benefits (venue, lounge), discount-based benefits (merchandise, F&B), experiential benefits (meet-and-greet, behind-the-scenes), content benefits (OTT, exclusive digital), physical goods (merchandise packs), and service benefits (concierge, priority support).. Valid values are `access|discount|experience|content|physical_goods|service`',
    `benefit_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the benefit definition within the benefit catalogue (e.g., PRIO-TKT-001, MERCH-DISC-15, VIP-LOUNGE-ACC). Used for benefit fulfilment lookups and cross-system reconciliation.. Valid values are `^[A-Z0-9_-]{3,30}$`',
    `benefit_description` STRING COMMENT 'Detailed narrative description of the benefit, including what is included, any conditions of use, and the fan experience it delivers. Used in fan-facing portals, CRM communications, and VIP experience management documentation.',
    `benefit_group_code` STRING COMMENT 'Code grouping related benefits into a logical bundle or package (e.g., VIP-HOSPITALITY-PKG, SEASON-TICKET-BUNDLE). Enables package-level reporting, bulk activation/deactivation, and sponsor benefit attribution across grouped entitlements.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `benefit_name` STRING COMMENT 'Human-readable name of the membership benefit as displayed to fans and staff (e.g., Priority Ticket Access, VIP Lounge Pass, 15% Merchandise Discount, Exclusive Content Access). Used in fan-facing communications and CRM dashboards.',
    `benefit_status` STRING COMMENT 'Current lifecycle state of the membership benefit record. Controls whether the benefit is available for redemption. active = available for use; suspended = temporarily blocked; expired = past validity window; pending = awaiting activation; cancelled = permanently revoked.. Valid values are `active|inactive|suspended|expired|pending|cancelled`',
    `benefit_type` STRING COMMENT 'Categorical classification of the benefit by its fulfilment domain. Drives routing to the appropriate fulfilment system (e.g., Ticketmaster/AXS for ticketing, Archtics for venue access, Shopify Plus for merchandise, Dalet/Adobe for content). [ENUM-REF-CANDIDATE: ticketing|parking|merchandise|lounge_access|meet_and_greet|content_access|hospitality|discount|experience|other — promote to reference product]',
    `benefit_value_amount` DECIMAL(18,2) COMMENT 'The monetary value of the benefit as assessed for financial reporting, sponsor valuation, and VIP package costing (e.g., a meet-and-greet valued at $500, a parking pass valued at $50). Used in ROI analysis for membership programs and sponsor benefit packages. Expressed in the operating currency.',
    `consent_required` BOOLEAN COMMENT 'Indicates whether the fan must provide explicit consent (e.g., for data sharing with a sponsor partner or for personalised content delivery) before this benefit can be activated. Supports GDPR and CCPA consent management workflows in Adobe Experience Platform.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this membership benefit record was first created in the system. Used for audit trail, data lineage, and compliance reporting under GDPR and SOX requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the benefit_value_amount (e.g., USD, GBP, EUR, AUD). Supports multi-market operations across global leagues and events.. Valid values are `^[A-Z]{3}$`',
    `discount_percentage` DECIMAL(18,2) COMMENT 'The percentage discount applied to merchandise, F&B, or other purchases as part of this benefit (e.g., 15.00 for a 15% merchandise discount). Applicable when benefit_type is merchandise or discount. Null for non-discount benefit types. Used by Shopify Plus and POS systems to apply the discount at checkout.',
    `effective_from` DATE COMMENT 'The date from which this benefit becomes valid and available for redemption by the fan. Aligns with the membership period start or a specific event/season window. Used for benefit activation scheduling and validity enforcement.',
    `effective_until` DATE COMMENT 'The date on which this benefit expires and is no longer available for redemption. Nullable for open-ended or perpetual benefits. Used for automated benefit expiry processing and fan communication triggers.',
    `fulfilment_channel` STRING COMMENT 'The channel through which the benefit is delivered or redeemed by the fan. venue = redeemed at the physical venue; online = redeemed via web portal; mobile_app = redeemed via fan mobile application; mail = physically mailed to fan; third_party = fulfilled by an external partner; pos = redeemed at a Point of Sale (POS) terminal.. Valid values are `venue|online|mobile_app|mail|third_party|pos`',
    `fulfilment_reference` STRING COMMENT 'External reference number or code from the fulfilment system (e.g., Ticketmaster/AXS order reference, Shopify Plus order ID, Archtics credential ID) confirming that the benefit has been provisioned. Used for cross-system reconciliation and fan support queries.',
    `fulfilment_status` STRING COMMENT 'Current operational status of the benefit fulfilment process, distinct from the benefit lifecycle status. Tracks whether the benefit has been successfully delivered to the fan. partially_fulfilled applies when only some units of a multi-quantity benefit have been delivered.. Valid values are `pending|fulfilled|partially_fulfilled|failed|cancelled`',
    `is_auto_renewed` BOOLEAN COMMENT 'Indicates whether this benefit is automatically renewed at the start of each new membership period or season (True) or requires manual re-activation (False). Drives automated benefit provisioning workflows in Salesforce CRM and Adobe Experience Platform.',
    `is_stackable` BOOLEAN COMMENT 'Indicates whether this benefit can be combined with other benefits or promotions simultaneously (True) or whether it is exclusive and cannot be stacked (False). For example, a merchandise discount benefit may not be stackable with a promotional sale discount. Used by Shopify Plus and POS discount engines.',
    `is_transferable` BOOLEAN COMMENT 'Indicates whether the fan may transfer this benefit to another person (True) or whether it is non-transferable and tied to the named member only (False). Relevant for guest passes, parking passes, and hospitality benefits. Enforced at the point of redemption.',
    `last_redeemed_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent redemption of this benefit by the fan. Used for engagement analytics, benefit utilisation reporting, and identifying dormant benefits for fan re-engagement campaigns in Adobe Experience Platform.',
    `nps_eligible` BOOLEAN COMMENT 'Indicates whether redemption of this benefit triggers an NPS survey to the fan for experience feedback collection. Supports fan satisfaction measurement and VIP experience improvement programmes managed via Adobe Experience Platform and Salesforce CRM.',
    `priority_rank` STRING COMMENT 'Numeric rank indicating the priority order of this benefit relative to other benefits within the same membership tier or membership record. Lower values indicate higher priority. Used to resolve conflicts when multiple benefits apply simultaneously and to order benefit display in fan-facing portals.',
    `quantity_allocated` STRING COMMENT 'The total number of units of this benefit allocated to the membership or tier (e.g., 4 priority ticket windows, 2 parking passes, 1 meet-and-greet slot). Null or zero indicates unlimited allocation. Used for benefit inventory management and fulfilment tracking.',
    `quantity_redeemed` STRING COMMENT 'The number of benefit units that have been redeemed by the fan to date within the current validity period. Used alongside quantity_allocated to determine remaining entitlement and drive fulfilment controls.',
    `redemption_end_timestamp` TIMESTAMP COMMENT 'The precise date and time after which the benefit can no longer be redeemed. Provides finer-grained control than effective_until for time-sensitive benefits such as pre-event VIP access windows or flash merchandise discounts.',
    `redemption_method` STRING COMMENT 'The technical mechanism by which the fan redeems the benefit. Drives integration with access control and POS systems. barcode and qr_code are used with Ticketmaster/AXS; rfid with Archtics venue access; voucher_code with Shopify Plus merchandise; auto_applied for benefits applied automatically at checkout or entry. [ENUM-REF-CANDIDATE: barcode|qr_code|rfid|voucher_code|digital_wallet|manual|auto_applied — 7 candidates stripped; promote to reference product]',
    `redemption_start_timestamp` TIMESTAMP COMMENT 'The precise date and time from which the fan may begin redeeming this benefit. May differ from effective_from when a benefit window opens at a specific time (e.g., priority ticket sales opening at 10:00 AM on a specific date). Used for time-gated benefit activation.',
    `season_year` STRING COMMENT 'The sports season year to which this benefit applies (e.g., 2024 for the 2024 season, or 2024 for a 2024/25 season). Used to scope benefits to a specific competitive season for season ticket holders and annual membership programs.',
    `source_system` STRING COMMENT 'The operational system of record from which this benefit record originated or is primarily managed. Used for data lineage, integration audit, and conflict resolution in the Silver layer of the Databricks Lakehouse. [ENUM-REF-CANDIDATE: salesforce_crm|adobe_experience_platform|archtics|ticketmaster_axs|shopify_plus|sap_s4hana|manual — 7 candidates stripped; promote to reference product]',
    `terms_and_conditions_url` STRING COMMENT 'URL linking to the full terms and conditions governing the use of this benefit. Required for GDPR and CCPA compliance to ensure fans have access to the conditions under which their benefit entitlements are granted and may be revoked.. Valid values are `^https?://.+$`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this membership benefit record was last modified. Used for change data capture (CDC) in the Databricks Lakehouse Silver layer, incremental ETL processing, and audit trail compliance.',
    `usage_limit_per_event` STRING COMMENT 'Maximum number of times this benefit can be redeemed at a single event. For example, a VIP lounge pass may allow entry once per event, or a priority ticket window may allow purchase of up to 4 tickets per event. Null indicates no per-event restriction.',
    `venue_zone` STRING COMMENT 'The specific zone or area within the venue where this benefit is applicable or redeemable (e.g., VIP Lounge Level 3, Club Concourse, Premium Parking Zone A). Used by Archtics for access control configuration and venue operations staff for benefit fulfilment.',
    `vip_tier_level` STRING COMMENT 'The VIP tier classification associated with this benefit, indicating the prestige level of the benefit within the fan loyalty hierarchy. Used for VIP experience management, venue access prioritisation, and fan segmentation in Adobe Experience Platform and Salesforce CRM.. Valid values are `standard|silver|gold|platinum|diamond|vip`',
    CONSTRAINT pk_membership_benefit PRIMARY KEY(`membership_benefit_id`)
) COMMENT 'Defines the specific benefits attached to a membership tier or individual membership record. Captures benefit type (priority ticketing, parking pass, merchandise discount, VIP lounge access, meet-and-greet, exclusive content access), benefit description, quantity or usage limit, redemption method, benefit value, and validity period. Enables benefit fulfillment tracking and VIP experience management across venues and events.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`fan`.`segment` (
    `segment_id` BIGINT COMMENT 'Primary key for segment',
    `fan_segment_id` BIGINT COMMENT 'Unique surrogate primary key for the CRM fan segment record in the Silver Layer lakehouse. Globally unique identifier for each segment definition managed across Adobe Experience Platform and Salesforce CRM.',
    `data_processing_record_id` BIGINT COMMENT 'Foreign key linking to compliance.data_processing_record. Business justification: Fan segmentation involves profiling personal data, which must be documented as a processing activity under GDPR Article 30. A DPO managing ROPA compliance would expect each segment definition to refer',
    `fan_behavior_model_id` BIGINT COMMENT 'Identifier of the AI/ML predictive model used to generate this segment, applicable when segment_type is predictive. References the Adobe Experience Platform Customer AI model or custom ML model deployed for churn prediction, propensity scoring, or LTV forecasting.',
    `franchise_id` BIGINT COMMENT 'Identifier of the specific team or franchise associated with this segment. Enables team-level fan segmentation for localized marketing, merchandise promotions, and event-specific campaigns.',
    `season_id` BIGINT COMMENT 'Foreign key linking to league.season. Business justification: Fan segments are frequently season-scoped (e.g., Current season STH, 2024 lapsed ticket buyers). Season-specific segment refresh schedules and campaign targeting require a direct FK to league seas',
    `pia_assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.pia_assessment. Business justification: Large-scale fan profiling and segmentation requires a DPIA under GDPR Article 35. Each segment involving sensitive profiling (behavioral, demographic, LTV scoring) should reference the PIA assessment ',
    `pipeline_run_id` BIGINT COMMENT 'Foreign key linking to analytics.pipeline_run. Business justification: Segment refresh is executed by analytics pipelines. The segment record must reference the pipeline_run that last computed it for refresh audit, SLA tracking, and data lineage reporting — a standard op',
    `source_segment_id` BIGINT COMMENT 'Native identifier of this segment in the originating source system (e.g., Adobe Experience Platform audience GUID or Salesforce CRM campaign segment ID). Enables traceability and reconciliation between the lakehouse Silver Layer and the operational CRM/CDP systems.',
    `team_id` BIGINT COMMENT 'Identifier of the specific team or franchise associated with this segment. Enables team-level fan segmentation for localized marketing, merchandise promotions, and event-specific campaigns.',
    `age_band_max` STRING COMMENT 'Maximum age (in years) of fans included in this segment. Used in conjunction with age_band_min to define a demographic age range for targeted campaigns. Nullable if no upper age bound is defined.',
    `age_band_min` STRING COMMENT 'Minimum age (in years) of fans included in this segment when demographic segmentation is applied. Used for age-gated content, alcohol sponsorship campaigns, and youth-specific engagement programs. Supports ADA and child privacy compliance.',
    `ccpa_applicable` BOOLEAN COMMENT 'Indicates whether this segment includes California residents subject to CCPA regulation. When true, opt-out of sale rights and data disclosure requirements must be honored before campaign activation.',
    `channel_applicability` STRING COMMENT 'Comma-separated list of marketing and engagement channels for which this segment is activated (e.g., email, push_notification, sms, in_app, paid_social, display). Guides campaign execution teams on appropriate activation channels. [ENUM-REF-CANDIDATE: email|push_notification|sms|in_app|paid_social|display|direct_mail — promote to reference product]',
    `consent_requirement` STRING COMMENT 'Specifies the consent basis required for fans to be included in this segment and activated for marketing. Explicit consent is required for GDPR-regulated EU fans; legitimate interest may apply for certain analytics use cases. Ensures compliance with GDPR and CCPA.. Valid values are `explicit_consent|legitimate_interest|opt_out_honored|no_requirement`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this segment record was first created in the source system and ingested into the Silver Layer. Formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX. Provides audit trail for segment lifecycle management.',
    `definition_criteria` STRING COMMENT 'Structured or semi-structured expression of the business rules and logic used to qualify fans into this segment (e.g., SQL predicate, JSON rule set, or natural-language description of inclusion/exclusion criteria). Sourced from Adobe Experience Platform segment builder or Salesforce CRM campaign filter logic.',
    `definition_format` STRING COMMENT 'Format of the definition_criteria field, indicating how the segment logic is expressed. PQL refers to Adobe Experience Platform Profile Query Language. Enables downstream systems to parse and execute the segment definition correctly.. Valid values are `sql|json|natural_language|pql|xml`',
    `effective_from_date` DATE COMMENT 'Date from which this segment definition is considered active and eligible for campaign use. Formatted as yyyy-MM-dd. Supports time-bounded segmentation strategies such as seasonal campaigns or event-specific audiences.',
    `effective_until_date` DATE COMMENT 'Date after which this segment definition expires and is no longer eligible for active campaign targeting. Nullable for evergreen segments with no defined end date. Formatted as yyyy-MM-dd.',
    `engagement_score_max` DECIMAL(18,2) COMMENT 'Maximum fan engagement score for inclusion in this segment. Used in conjunction with engagement_score_min to define a score band for precise audience targeting. Nullable if no upper bound is defined.',
    `engagement_score_min` DECIMAL(18,2) COMMENT 'Minimum fan engagement score required for inclusion in this segment, as calculated by Adobe Experience Platform. Engagement scores reflect fan interaction frequency, recency, and depth across digital and physical touchpoints.',
    `fan_count` STRING COMMENT 'Number of fan profiles qualifying for this segment as of the last refresh date. Represents the segment size used for campaign reach estimation, budget planning, and audience reporting. Not a real-time count — reflects the most recent batch evaluation.',
    `gdpr_applicable` BOOLEAN COMMENT 'Indicates whether this segment includes fans subject to GDPR regulation (EU/EEA residents). When true, additional consent validation and data processing restrictions apply before campaign activation.',
    `geographic_scope` STRING COMMENT 'Geographic scope of the segment, expressed as ISO 3166-1 alpha-3 country codes or region identifiers (e.g., USA, GBR, DEU). Defines the geographic boundary for campaign activation and regulatory compliance determination.',
    `is_dtc_eligible` BOOLEAN COMMENT 'Indicates whether this segment is approved for Direct-To-Consumer (DTC) marketing activation, including OTT streaming promotions, DTC merchandise offers, and subscription upsell campaigns. Supports DTC revenue strategy.',
    `is_suppression_list` BOOLEAN COMMENT 'Indicates whether this segment functions as a suppression or exclusion list, identifying fans who should be excluded from specific campaigns (e.g., opted-out fans, recent purchasers, VIP do-not-contact lists). Critical for GDPR and CCPA compliance.',
    `last_refresh_timestamp` TIMESTAMP COMMENT 'Date and time when the segment membership was most recently evaluated and the fan_count was last updated. Formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX. Critical for assessing data freshness before campaign activation.',
    `ltv_band` STRING COMMENT 'Lifetime Value (LTV) classification band for fans in this segment, indicating their predicted or historical revenue contribution over their relationship with the organization. High-LTV segments receive premium personalization and VIP treatment. Supports ARPU and LTV analytics.. Valid values are `high|medium|low|unknown`',
    `membership_tier_filter` STRING COMMENT 'Fan loyalty membership tier(s) included in this segment (e.g., bronze, silver, gold, platinum, vip). Enables tier-specific personalization, exclusive offers, and loyalty program communications. [ENUM-REF-CANDIDATE: bronze|silver|gold|platinum|vip|season_ticket_holder|fan_club — promote to reference product]',
    `model_score_threshold` DECIMAL(18,2) COMMENT 'Minimum propensity or confidence score from the predictive model required for fan inclusion in this segment. Expressed as a decimal between 0 and 1 (e.g., 0.7500 = 75% confidence). Applicable only when segment_type is predictive.',
    `next_refresh_timestamp` TIMESTAMP COMMENT 'Scheduled date and time for the next segment membership evaluation run. Used by campaign operations teams to plan activation timing and ensure segment data is current before campaign launch.',
    `nps_band` STRING COMMENT 'Net Promoter Score (NPS) classification band associated with fans in this segment: promoters (score 9-10), passives (score 7-8), detractors (score 0-6), or unknown if NPS data is unavailable. Enables NPS-driven personalization and retention campaigns.. Valid values are `promoter|passive|detractor|unknown`',
    `owning_business_unit` STRING COMMENT 'Name of the business unit or department responsible for this segment (e.g., Fan Engagement, Ticket Sales, Sponsorship Marketing, Merchandise, Broadcast DTC). Determines accountability for segment maintenance and campaign activation.',
    `owning_campaign_id` STRING COMMENT 'Identifier of the primary Salesforce CRM campaign or Adobe Experience Platform journey that owns or originated this segment. Links the segment to its marketing campaign context for attribution and ROI reporting.',
    `refresh_frequency` STRING COMMENT 'How frequently the segment membership is re-evaluated and updated. Real-time segments use Adobe Experience Platform streaming segmentation; batch segments are evaluated on a scheduled cadence. Impacts campaign freshness and system resource planning.. Valid values are `real_time|hourly|daily|weekly|monthly|on_demand`',
    `rfm_tier` STRING COMMENT 'RFM (Recency, Frequency, Monetary) tier classification assigned to fans in this segment, applicable when segment_type is rfm. Champions are high-value frequent buyers; lost fans have not engaged recently. Drives targeted retention and reactivation campaigns.. Valid values are `champions|loyal|at_risk|lost|new|potential`',
    `season_ticket_holder_flag` BOOLEAN COMMENT 'Indicates whether this segment is scoped exclusively to season ticket holders. Season ticket holders represent the highest-value fan cohort and receive dedicated CRM treatment, renewal campaigns, and VIP experiences.',
    `segment_code` STRING COMMENT 'Externally-known alphanumeric business identifier for the segment, sourced from Adobe Experience Platform audience segment key or Salesforce CRM campaign segment code. Used for cross-system referencing and campaign targeting.. Valid values are `^[A-Z0-9_-]{3,50}$`',
    `segment_description` STRING COMMENT 'Free-text business description of the segments purpose, intended use case, and strategic rationale. Authored by the campaign or analytics team to provide context for downstream users and stakeholders.',
    `segment_name` STRING COMMENT 'Human-readable business name of the fan segment (e.g., High-Value Season Ticket Holders, Lapsed Casual Fans, Gen-Z Digital Natives). Used in campaign targeting, reporting dashboards, and personalization workflows.',
    `segment_status` STRING COMMENT 'Current lifecycle state of the segment definition. Active segments are available for campaign targeting; draft segments are under construction; archived segments are retained for historical reference but not used in live campaigns.. Valid values are `active|inactive|draft|archived|under_review`',
    `segment_type` STRING COMMENT 'Classification of the segmentation methodology applied: RFM (Recency, Frequency, Monetary), behavioral (engagement actions), demographic (age, gender, location), psychographic (interests, values), predictive (ML-model-driven), or geographic. Drives which analytics model and personalization engine is applied.. Valid values are `rfm|behavioral|demographic|psychographic|predictive|geographic`',
    `source_system` STRING COMMENT 'Operational system of record from which this segment definition was sourced or created. Adobe Experience Platform is the primary source for behavioral and predictive segments; Salesforce CRM is the primary source for relationship-based and campaign segments.. Valid values are `adobe_experience_platform|salesforce_crm|manual|third_party`',
    `subtype` STRING COMMENT 'Secondary classification providing finer granularity within the segment type (e.g., churn_risk, upsell_candidate, loyalty_tier_upgrade, event_attendee, merchandise_buyer). Enables more precise campaign targeting and personalization. [ENUM-REF-CANDIDATE: churn_risk|upsell_candidate|loyalty_tier_upgrade|event_attendee|merchandise_buyer|lapsed|reactivation — promote to reference product]',
    `tags` STRING COMMENT 'Comma-separated business tags or labels applied to the segment for discoverability, governance, and categorization (e.g., retention, q4_campaign, nfl_season, vip, churn_prevention). Supports segment catalog search and filtering in Adobe Experience Platform and Salesforce CRM.',
    `target_league` STRING COMMENT 'Name or code of the sports league associated with this segment (e.g., NFL, NBA, MLB, NHL, MLS, FIFA). Scopes the segment to fans of a specific league for league-specific campaign targeting and personalization.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this segment record was most recently modified, including changes to definition criteria, status, configuration, or metadata. Formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX. Supports change tracking and data lineage.',
    `version_number` STRING COMMENT 'Monotonically incrementing version number for the segment definition. Incremented each time the segment criteria, name, or configuration is materially changed. Supports audit trail and change management for segment governance.',
    CONSTRAINT pk_segment PRIMARY KEY(`segment_id`)
) COMMENT 'CRM segmentation records classifying fans into behavioral, demographic, and value-based segments for targeted marketing and personalization. Captures segment name, segment type (RFM, behavioral, demographic, psychographic, predictive), definition criteria, segment size, creation date, last refresh date, and owning campaign or business unit. Sourced from Adobe Experience Platform audience segments and Salesforce CRM campaigns. Enables personalized fan engagement, DTC marketing, and campaign targeting.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` (
    `segment_assignment_id` BIGINT COMMENT 'Primary key for segment_assignment',
    `assigned_by_user_employee_id` BIGINT COMMENT 'Reference to the internal CRM user or analyst who manually created or overrode this segment assignment. Populated only when assignment_method is manual. Supports accountability and audit trail.',
    `employee_id` BIGINT COMMENT 'Reference to the internal CRM user or analyst who manually created or overrode this segment assignment. Populated only when assignment_method is manual. Supports accountability and audit trail.',
    `fan_behavior_model_id` BIGINT COMMENT 'Foreign key linking to analytics.fan_behavior_model. Business justification: Model-driven segment assignments must reference the fan behavior model that produced the propensity score. Sports entertainment CRM teams require this link for model governance, assignment explainabil',
    `fan_profile_id` BIGINT COMMENT 'Reference to the fan profile record in the fan master data product. Identifies the individual fan being assigned to a CRM segment.',
    `model_run_id` BIGINT COMMENT 'Foreign key linking to analytics.model_run. Business justification: Batch model scoring runs produce segment assignments. Each assignment must reference the specific model_run that generated the score for MLOps audit, score reproducibility, and regulatory explainabili',
    `notification_campaign_id` BIGINT COMMENT 'Reference to the CRM campaign for which this segment assignment was created or is being used. Links the fans segment membership to a specific marketing or fan engagement campaign.',
    `segment_id` BIGINT COMMENT 'Reference to the CRM segment definition record. Identifies which audience segment the fan has been assigned to for campaign targeting, personalization, or NPS cohort analysis.',
    `segment_rule_id` BIGINT COMMENT 'Reference to the specific CRM segmentation rule or audience definition that triggered this assignment. Applicable when assignment_method is rule_based. Supports rule performance analysis and audit.',
    `ab_test_variant` STRING COMMENT 'The A/B or multivariate test variant assigned to this fan within the segment for campaign experimentation. Supports controlled testing of personalization strategies, messaging, and offer effectiveness across fan cohorts.. Valid values are `control|variant_a|variant_b|variant_c`',
    `activation_destination` STRING COMMENT 'The downstream system or platform to which this segment membership was activated (e.g., Adobe Target, Google Ads, Salesforce Marketing Cloud, Meta Ads). Supports multi-channel activation tracking and attribution.',
    `activation_status` STRING COMMENT 'Indicates whether this segment membership has been activated for downstream use in a campaign, personalization engine, or ad platform. activated means the membership has been pushed to an activation destination such as Adobe Target or a paid media platform.. Valid values are `not_activated|activated|activation_failed|deactivated`',
    `activation_timestamp` TIMESTAMP COMMENT 'The date and time when this segment membership was activated and pushed to the downstream destination system. Distinct from assignment_timestamp; supports latency measurement between assignment and activation.',
    `assignment_channel` STRING COMMENT 'The system or interface channel through which the assignment was executed. crm = Salesforce CRM automation; aep = Adobe Experience Platform (AEP) audience activation; api = external API call; batch = scheduled batch job; manual_ui = CRM analyst via user interface.. Valid values are `crm|aep|api|batch|manual_ui`',
    `assignment_date` DATE COMMENT 'The calendar date on which the fan was first assigned to this segment. Used for time-variant segment membership analysis and campaign eligibility windows.',
    `assignment_method` STRING COMMENT 'The mechanism by which the fan was assigned to this segment. rule_based indicates automated CRM rule evaluation; manual indicates a CRM analyst override; ml_predicted indicates an ML model classification; imported indicates a bulk data import; api_triggered indicates an external system API call via Adobe Experience Platform or Salesforce API.. Valid values are `rule_based|manual|ml_predicted|imported|api_triggered`',
    `assignment_score` DECIMAL(18,2) COMMENT 'Numeric score or confidence value associated with this assignment, typically produced by an ML model or rule engine. For ML-predicted assignments, this represents the models probability or propensity score (0.0–1.0). For rule-based assignments, this may represent a weighted rule match score.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of this fan-segment membership record. active means the fan is currently a member of the segment; expired means the assignment passed its expiry date; revoked means it was manually removed; pending means awaiting confirmation; suspended means temporarily paused.. Valid values are `active|expired|revoked|pending|suspended`',
    `assignment_timestamp` TIMESTAMP COMMENT 'Precise date and time (with timezone) when the fan was assigned to this segment. Supports real-time campaign triggering and audit trail requirements.',
    `consent_basis` STRING COMMENT 'The legal basis under which the fans data is processed for this segment assignment. Required for GDPR Article 6 compliance documentation. explicit_consent = fan actively opted in; legitimate_interest = business interest assessment conducted; contract = necessary for service delivery; legal_obligation = required by law; opt_out_not_exercised = CCPA default.. Valid values are `explicit_consent|legitimate_interest|contract|legal_obligation|opt_out_not_exercised`',
    `consent_verified` BOOLEAN COMMENT 'Indicates whether the fans data processing consent has been verified as valid and current at the time of this segment assignment. Ensures GDPR and CCPA compliance for targeted marketing use of this membership record.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this segment assignment record was first created in the data platform. Serves as the audit trail creation marker for the Silver Layer lakehouse record.',
    `data_suppression_flag` BOOLEAN COMMENT 'Indicates whether this fan has exercised a right-to-suppress or opt-out request that should prevent this segment assignment from being used in outbound marketing or data sharing. Supports GDPR right to erasure and CCPA opt-out compliance.',
    `engagement_score_at_assignment` DECIMAL(18,2) COMMENT 'The fans overall engagement score at the time of this segment assignment, as calculated by the CRM or Adobe Experience Platform. Captured as a point-in-time snapshot to support longitudinal analysis of how engagement drives segment membership.',
    `expiry_date` DATE COMMENT 'The date on which this fans membership in the segment is scheduled to expire. Null indicates an open-ended assignment with no planned expiry. Supports time-limited campaign cohorts and seasonal segment windows.',
    `fan_type_at_assignment` STRING COMMENT 'The fans account classification at the time of this segment assignment. Captured as a point-in-time snapshot to support historical cohort analysis. Values: individual consumer, family account, season ticket holder, VIP member, or fan club member.. Valid values are `individual|family|season_ticket_holder|vip_member|fan_club`',
    `geographic_market` STRING COMMENT 'The geographic market or region associated with this segment assignment (e.g., USA, GBR, AUS). Uses ISO 3166-1 alpha-3 country codes. Supports geo-targeted campaign execution and regional compliance (GDPR for EU markets, CCPA for California).',
    `is_primary_segment` BOOLEAN COMMENT 'Indicates whether this segment is the fans primary or highest-priority segment assignment when a fan belongs to multiple segments simultaneously. Used for personalization and communication preference resolution.',
    `last_evaluated_timestamp` TIMESTAMP COMMENT 'The most recent date and time when the segment rule engine or ML model re-evaluated this fans eligibility for the segment. Supports freshness monitoring and identifies stale assignments that may need re-evaluation.',
    `loyalty_tier_at_assignment` STRING COMMENT 'The fans loyalty program membership tier at the time of this segment assignment. Captured as a point-in-time snapshot to support time-variant analysis of how loyalty tier influences segment membership and campaign response.. Valid values are `bronze|silver|gold|platinum|vip`',
    `membership_duration_days` STRING COMMENT 'The number of days the fan has been (or was) a member of this segment, calculated as the difference between assignment_date and either the current date (for active memberships) or revocation_date/expiry_date. Stored as a business-meaningful snapshot for reporting without requiring real-time calculation.',
    `next_evaluation_date` DATE COMMENT 'The scheduled date for the next automated re-evaluation of this fans segment eligibility. Supports segment refresh scheduling and ensures time-sensitive segments (e.g., event-proximity segments) are kept current.',
    `nps_cohort_flag` BOOLEAN COMMENT 'Indicates whether this segment assignment is specifically designated for NPS (Net Promoter Score) survey cohort analysis. When true, the fan is included in NPS measurement campaigns for fan satisfaction tracking.',
    `override_reason` STRING COMMENT 'Free-text justification provided by a CRM analyst when manually assigning or revoking a fans segment membership, overriding automated rule-based or ML-predicted assignment. Populated only when assignment_method is manual.',
    `priority_rank` STRING COMMENT 'Numeric rank indicating the priority of this segment assignment relative to other active segment memberships for the same fan. Lower values indicate higher priority. Used for conflict resolution when a fan belongs to multiple segments with competing campaign rules.',
    `revocation_date` DATE COMMENT 'The date on which this fans segment membership was revoked or removed, either by automated rule exit, manual override, or consent withdrawal. Null if the membership has not been revoked.',
    `revocation_reason` STRING COMMENT 'The reason code explaining why this fans segment membership was revoked. rule_exit = fan no longer meets segment criteria; consent_withdrawn = GDPR/CCPA consent revoked; manual_removal = analyst override; data_quality = data integrity issue; segment_deprecated = segment definition retired; opt_out = fan opted out of communications.. Valid values are `rule_exit|consent_withdrawn|manual_removal|data_quality|segment_deprecated|opt_out`',
    `score_model_version` STRING COMMENT 'Version identifier of the ML model or rule engine that produced the assignment_score. Enables model governance, reproducibility, and performance tracking over time. Applicable when assignment_method is ml_predicted.',
    `score_percentile` DECIMAL(18,2) COMMENT 'The percentile rank of the fans assignment score within the segment population at the time of assignment (0.00–100.00). Used for tiered targeting and prioritization within a segment cohort.',
    `segment_category` STRING COMMENT 'The analytical category of the segment to which the fan is assigned. Denormalized from the segment definition for query performance. Supports filtering and reporting by segment type without joining to the segment master.. Valid values are `behavioral|demographic|geographic|psychographic|transactional|predictive`',
    `segment_version` STRING COMMENT 'Version label of the segment definition that was active at the time of this assignment. Enables historical analysis of how segment criteria evolved and ensures reproducibility of cohort membership.',
    `source_record_reference` STRING COMMENT 'The native record identifier from the originating source system (e.g., Salesforce CRM Campaign Member ID, Adobe AEP Segment Membership ID). Supports data lineage, reconciliation, and cross-system traceability.',
    `source_system` STRING COMMENT 'The operational system of record that originated this segment assignment. Identifies the upstream data source for lineage and reconciliation purposes.. Valid values are `salesforce_crm|adobe_aep|ticketmaster|axs|shopify|manual`',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this segment assignment record was most recently modified in the data platform. Supports change data capture, incremental processing, and audit trail requirements.',
    CONSTRAINT pk_segment_assignment PRIMARY KEY(`segment_assignment_id`)
) COMMENT 'Association table recording which fans belong to which CRM segments at a given point in time. Tracks fan profile ID, segment ID, assignment date, assignment method (rule-based, manual, ML-predicted), assignment score or confidence, expiry date, and active flag. Supports time-variant segment membership for campaign targeting, personalization, and NPS cohort analysis. Carries its own business data (assignment method, score) beyond a simple M:N link.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` (
    `consent_preference_id` BIGINT COMMENT 'Unique surrogate identifier for each consent preference record. Primary key for the consent_preference data product in the fan domain.',
    `auth_session_id` BIGINT COMMENT 'Session identifier from the digital platform (web, mobile app) during which the fan submitted their consent. Links consent capture to the broader fan session for audit and fraud detection purposes.',
    `corporate_entity_id` BIGINT COMMENT 'Identifier of the legal entity acting as the data controller responsible for this consent record. Supports multi-entity sports organisations where different leagues, clubs, or subsidiaries act as separate data controllers.',
    `data_controller_corporate_entity_id` BIGINT COMMENT 'Identifier of the legal entity acting as the data controller responsible for this consent record. Supports multi-entity sports organisations where different leagues, clubs, or subsidiaries act as separate data controllers.',
    `data_processing_record_id` BIGINT COMMENT 'Foreign key linking to compliance.data_processing_record. Business justification: Under GDPR Article 30, each consent record must be traceable to the ROPA processing activity it authorizes. A DPO managing data subject rights fulfillment and DPIA reviews would expect consent prefere',
    `data_processor_corporate_entity_id` BIGINT COMMENT 'Identifier of the third-party data processor (e.g., Adobe Experience Platform, Salesforce CRM) acting on behalf of the data controller for this consent type. Required for GDPR Article 28 processor accountability.',
    `fan_profile_id` BIGINT COMMENT 'Identifier of the fan whose consent preference this record captures. Links to the fan master profile as the primary party reference.',
    `matter_id` BIGINT COMMENT 'Foreign key linking to legal.legal_matter. Business justification: GDPR/CCPA enforcement actions and data privacy complaints involving specific consent records are tracked as legal matters. Legal teams need to link disputed or investigated consent preferences to the ',
    `parental_guardian_fan_profile_id` BIGINT COMMENT 'Fan ID of the parent or legal guardian who provided consent on behalf of a minor fan. Null for adult fans. Links to the guardians fan profile for family account management.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: GDPR/CCPA consent management requires each consent record to reference the governing compliance policy that defines the lawful basis, consent notice version, and processing purpose. A DPO would expect',
    `primary_consent_fan_profile_id` BIGINT COMMENT 'Identifier of the fan whose consent preference this record captures. Links to the fan master profile as the primary party reference.',
    `vendor_id` BIGINT COMMENT 'Identifier of the third-party data processor (e.g., Adobe Experience Platform, Salesforce CRM) acting on behalf of the data controller for this consent type. Required for GDPR Article 28 processor accountability.',
    `aep_consent_reference` STRING COMMENT 'External identifier of the corresponding consent record in Adobe Experience Platform. Supports synchronisation of consent signals to the fan engagement and personalisation platform.',
    `consent_category` STRING COMMENT 'High-level category grouping for this consent type, aligned with IAB TCF (Transparency and Consent Framework) and cookie consent banner classifications. Supports consent management platform (CMP) integration and reporting.. Valid values are `functional|analytics|marketing|personalisation|third_party`',
    `consent_date` TIMESTAMP COMMENT 'Timestamp at which the fan actively granted this consent. Represents the principal business event timestamp for the consent lifecycle. Stored in ISO 8601 format with timezone offset.',
    `consent_language_code` STRING COMMENT 'ISO 639-1 language code (optionally with ISO 3166-1 country subtag) of the language in which the consent notice was presented to the fan. Ensures consent was given in the fans understood language, a GDPR requirement.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `consent_notice_url` STRING COMMENT 'URL of the specific privacy notice or consent form presented to the fan at the time of consent capture. Provides an auditable link to the exact disclosure document the fan reviewed.',
    `consent_proof_reference` STRING COMMENT 'Reference identifier or URL pointing to the stored evidence of consent (e.g., a screenshot, form submission log, call recording reference, or digital audit token). Required for demonstrating consent under GDPR Article 7(1).',
    `consent_reference_number` STRING COMMENT 'Externally-known alphanumeric reference number assigned to this consent record, used for audit trails, regulatory inquiries, and fan-facing acknowledgement receipts. Generated at point of consent capture.',
    `consent_renewal_reminder_date` DATE COMMENT 'Date on which a consent renewal reminder should be sent to the fan, typically triggered before the effective_until date. Supports proactive consent lifecycle management to avoid consent lapse.',
    `consent_source` STRING COMMENT 'The channel or touchpoint through which the fan provided or updated their consent. Used for audit purposes and to validate that consent was obtained through an appropriate mechanism. Values: web_form, mobile_app, in_venue_kiosk, call_center, paper_form, third_party.. Valid values are `web_form|mobile_app|in_venue_kiosk|call_center|paper_form|third_party`',
    `consent_status` STRING COMMENT 'Current lifecycle state of this consent record. granted indicates active consent; withdrawn indicates the fan has revoked consent; pending indicates consent request issued but not yet confirmed; expired indicates consent has lapsed past its validity period.. Valid values are `granted|withdrawn|pending|expired`',
    `consent_type` STRING COMMENT 'Classification of the specific data processing activity for which consent is being captured. Covers marketing email, SMS, push notification, data sharing with partners, profiling/personalization, and cookie consent. [ENUM-REF-CANDIDATE: marketing_email|sms|push_notification|data_sharing_partner|profiling_personalization|cookie — promote to reference product if additional types are required]. Valid values are `marketing_email|sms|push_notification|data_sharing_partner|profiling_personalization|cookie`',
    `consent_version` STRING COMMENT 'Version identifier of the privacy policy, terms of service, or consent notice document that the fan agreed to at the time of consent. Enables tracking of consent against specific policy versions for regulatory compliance.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp at which this consent preference record was first created in the system. Audit trail field for data lineage and regulatory record-keeping under GDPR Article 30.',
    `crm_consent_record_reference` STRING COMMENT 'External identifier of the corresponding consent record in Salesforce CRM. Enables bi-directional reconciliation between the lakehouse silver layer and the operational CRM system of record.',
    `data_portability_requested` BOOLEAN COMMENT 'Indicates whether the fan has submitted a Data Portability request under GDPR Article 20, requesting their personal data in a machine-readable format. Triggers data export workflows.',
    `device_type` STRING COMMENT 'Type of device used by the fan when submitting their consent. Supports channel analytics and ensures consent UI was appropriate for the device used.. Valid values are `desktop|mobile|tablet|kiosk|smart_tv|other`',
    `double_opt_in_date` TIMESTAMP COMMENT 'Timestamp at which the fan completed the double opt-in confirmation step. Null if double opt-in was not required or not completed. Supports audit evidence for email marketing consent.',
    `double_opt_in_flag` BOOLEAN COMMENT 'Indicates whether the fan completed a double opt-in confirmation process (True) for this consent, such as clicking a confirmation link in an email. Provides stronger evidence of consent for email marketing under GDPR.',
    `effective_from` DATE COMMENT 'Date from which this consent record is binding and processing under this consent is permitted. Supports forward-dated consent activations and consent version transitions.',
    `effective_until` DATE COMMENT 'Date on which this consent record expires and processing must cease unless renewed. Null for open-ended consents with no defined expiry. Supports consent validity period management.',
    `erasure_request_date` TIMESTAMP COMMENT 'Timestamp at which the fan submitted their Right to Erasure or CCPA deletion request. Null if no erasure request has been made. Starts the regulatory response clock (30 days under GDPR, 45 days under CCPA).',
    `iab_tcf_purpose_code` STRING COMMENT 'Numeric identifier of the IAB TCF v2.2 purpose associated with this consent record. Enables interoperability with programmatic advertising and digital media ecosystems for broadcast and OTT platforms.',
    `ip_address` STRING COMMENT 'IP address of the device from which the fan submitted their consent. Used as supporting evidence of consent origin and geographic jurisdiction determination. May be considered PII under GDPR.',
    `jurisdiction` STRING COMMENT 'The regulatory framework and geographic jurisdiction under which this consent record is governed. Determines which privacy law obligations apply. Values: EU_GDPR, CA_CCPA, UK_GDPR, BR_LGPD, AU_PRIVACY. [ENUM-REF-CANDIDATE: EU_GDPR|CA_CCPA|UK_GDPR|BR_LGPD|AU_PRIVACY|other — promote to reference product for full global coverage]. Valid values are `EU_GDPR|CA_CCPA|UK_GDPR|BR_LGPD|AU_PRIVACY`',
    `last_reviewed_date` DATE COMMENT 'Date on which this consent record was last reviewed or reconfirmed by the fan or by a compliance officer. Supports periodic consent refresh requirements and demonstrates ongoing validity.',
    `legal_basis` STRING COMMENT 'The GDPR Article 6 lawful basis under which personal data is processed for this consent record. While this product primarily captures consent, the legal basis field supports cases where processing may shift to another basis (e.g., contract fulfilment). Values: consent, legitimate_interest, contract, legal_obligation, vital_interest, public_task.. Valid values are `consent|legitimate_interest|contract|legal_obligation|vital_interest|public_task`',
    `minor_flag` BOOLEAN COMMENT 'Indicates whether the fan is a minor (under 16 in EU, under 13 in US) at the time of consent. Triggers parental consent verification workflows and restricts certain processing activities under GDPR Article 8 and COPPA.',
    `opt_in_flag` BOOLEAN COMMENT 'Indicates whether the fan has actively opted in (True) or opted out (False) for this consent type. Provides a direct boolean signal for downstream marketing suppression lists and personalisation engines.',
    `parental_consent_flag` BOOLEAN COMMENT 'Indicates whether verifiable parental consent has been obtained for a minor fan (True) or not (False). Required for fans identified as minors under GDPR Article 8 and COPPA.',
    `processing_purpose` STRING COMMENT 'Detailed description of the specific data processing purpose for which consent is granted, as disclosed to the fan. Examples include personalised match recommendations, third-party sponsor marketing, fan behaviour analytics. Supports GDPR purpose limitation principle.',
    `right_to_erasure_requested` BOOLEAN COMMENT 'Indicates whether the fan has submitted a Right to Erasure (Right to be Forgotten) request under GDPR Article 17 or CCPA deletion request. Triggers downstream data deletion workflows across all processing systems.',
    `suppression_flag` BOOLEAN COMMENT 'Indicates whether this fan is on a global marketing suppression list (True), overriding all consent grants for outbound marketing communications. Used by Salesforce CRM and Adobe Experience Platform to enforce hard suppression.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp at which this consent preference record was last modified. Supports change tracking, audit trails, and incremental data pipeline processing in the Databricks Lakehouse silver layer.',
    `withdrawal_date` TIMESTAMP COMMENT 'Timestamp at which the fan withdrew or revoked this consent. Null if consent has not been withdrawn. Required for GDPR and CCPA audit trails demonstrating timely cessation of processing.',
    `withdrawal_method` STRING COMMENT 'The channel or mechanism through which the fan withdrew their consent. Null if consent has not been withdrawn. Supports audit trails and ensures withdrawal was as easy as granting consent per GDPR Article 7(3).. Valid values are `web_form|mobile_app|email_unsubscribe|call_center|in_venue_kiosk|automated_expiry`',
    `withdrawal_reason` STRING COMMENT 'Free-text or categorised reason provided by the fan or system for withdrawing consent. Supports fan experience analysis and identification of consent friction points. Null if consent has not been withdrawn.',
    CONSTRAINT pk_consent_preference PRIMARY KEY(`consent_preference_id`)
) COMMENT 'GDPR and CCPA compliance record capturing each fans data privacy consent and communication preferences. Tracks consent type (marketing email, SMS, push notification, data sharing with partners, profiling/personalization, cookie consent), consent status (granted, withdrawn, pending), consent date, withdrawal date, consent source (web form, mobile app, in-venue kiosk, call center), jurisdiction (EU-GDPR, CA-CCPA, UK-GDPR), and consent version. SSOT for all fan privacy obligations.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` (
    `nps_survey_id` BIGINT COMMENT 'Unique system-generated identifier for each NPS survey campaign or response record. Serves as the primary key for the nps_survey data product within the fan domain.',
    `athlete_profile_id` BIGINT COMMENT 'Foreign key linking to athlete.athlete_profile. Business justification: Athlete-specific NPS and reputation management: post-meet-and-greet, athlete appearance, and athlete-branded event surveys require linking NPS scores to the specific athlete. This drives athlete reput',
    `calendar_id` BIGINT COMMENT 'Foreign key linking to event.event_calendar. Business justification: Season-level NPS surveys (end-of-season satisfaction benchmarking) are a standard sports entertainment CRM process distinct from fixture-level surveys. nps_survey already has fixture_id for game-level',
    `asset_id` BIGINT COMMENT 'Foreign key linking to content.asset. Business justification: Post-content-consumption NPS measurement: OTT/streaming sports platforms trigger NPS surveys after fans watch specific content assets. Content performance reporting requires linking survey scores to t',
    `digital_touchpoint_id` BIGINT COMMENT 'Foreign key linking to platform.digital_touchpoint. Business justification: Touchpoint-level NPS benchmarking is a standard digital KPI in sports-entertainment (app NPS vs. web NPS vs. stadium kiosk NPS). The digital_touchpoint product has an nps_target field implying this me',
    `event_fixture_id` BIGINT COMMENT 'Reference to the specific event (game, concert, match) associated with this NPS survey or response. Populated for post-event survey types; null for relationship or seasonal surveys not tied to a specific event.',
    `fan_profile_id` BIGINT COMMENT 'Reference to the fan profile who submitted this NPS response. Links to the fan master record in the fan domain, enabling CRM segmentation, detractor recovery workflows, and loyalty program correlation. Populated for authenticated responses; null for anonymous responses.',
    `fixture_id` BIGINT COMMENT 'Reference to the specific event (game, concert, match) associated with this NPS survey or response. Populated for post-event survey types; null for relationship or seasonal surveys not tied to a specific event.',
    `franchise_id` BIGINT COMMENT 'Foreign key linking to league.franchise. Business justification: NPS surveys are frequently franchise-specific (post-game fan satisfaction surveys for a specific team). Franchise-level NPS benchmarking, fan satisfaction dashboards, and CRM follow-up routing require',
    `league_id` BIGINT COMMENT 'Reference to the league or competition governing body associated with this NPS survey campaign. Enables league-level NPS benchmarking and compliance reporting to governing bodies such as NFL, NBA, FIFA, or MLS.',
    `season_id` BIGINT COMMENT 'Foreign key linking to league.season. Business justification: Season-level NPS benchmarking and year-over-year fan satisfaction trend analysis are standard sports-entertainment analytics reports. Linking NPS surveys to a league season enables season-cohort compa',
    `notification_campaign_id` BIGINT COMMENT 'Foreign key linking to platform.notification_campaign. Business justification: NPS surveys in sports-entertainment are frequently triggered by notification campaigns (post-event, post-purchase). Linking nps_survey to notification_campaign enables campaign-level NPS impact measur',
    `service_case_id` BIGINT COMMENT 'Reference identifier for the Salesforce CRM case created as part of the Detractor recovery workflow for this NPS response. Enables traceability between NPS feedback and CRM service resolution. Null when no CRM case has been raised.',
    `ticket_order_id` BIGINT COMMENT 'External reference identifier for the ticket purchase, merchandise order, or other commercial transaction that triggered this post-purchase NPS survey. Sourced from Ticketmaster/AXS or Shopify Plus order records. Null for non-purchase-triggered survey types.',
    `tournament_id` BIGINT COMMENT 'Foreign key linking to event.tournament. Business justification: Post-tournament NPS surveys (e.g., playoff satisfaction, World Cup experience) are a named business process in sports entertainment distinct from single-fixture surveys. nps_survey has fixture_id but ',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to partner.vendor. Business justification: Sports entertainment operators run NPS surveys specifically targeting vendor-delivered services (F&B, parking, security, cleaning). Linking nps_survey to vendor enables vendor-level satisfaction scori',
    `venue_id` BIGINT COMMENT 'Reference to the venue where the associated event took place or where an in-venue kiosk survey was administered. Enables venue-level NPS analysis and facility management feedback loops. Null for non-venue-specific survey types.',
    `close_date` DATE COMMENT 'The calendar date on which the NPS survey campaign was closed and no longer accepting responses. Defines the end of the survey collection window. Null for open-ended campaigns.',
    `completion_time_seconds` STRING COMMENT 'Time in seconds taken by the fan to complete the NPS survey from first interaction to submission. Used to assess survey fatigue, optimize survey length, and identify potentially low-quality responses (e.g., unusually fast completions).',
    `consent_captured` BOOLEAN COMMENT 'Indicates whether explicit fan consent for processing survey response data (including verbatim comments) was captured at the point of survey submission, in compliance with GDPR and CCPA requirements. True when consent was affirmatively given; False when not captured.',
    `consent_version` STRING COMMENT 'Version identifier of the privacy consent notice presented to the fan at the time of survey submission. Enables audit trail for GDPR and CCPA compliance, ensuring the correct consent language was in effect at the time of data collection.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time at which this NPS survey record was first created in the system. Serves as the audit creation timestamp for data lineage and Silver layer governance.',
    `delivery_channel` STRING COMMENT 'The communication channel through which the NPS survey invitation was delivered to the fan. Drives channel-level response rate analysis and informs omnichannel fan engagement strategy. [ENUM-REF-CANDIDATE: email|in_app|sms|in_venue_kiosk|web|push_notification — promote to reference product]. Valid values are `email|in_app|sms|in_venue_kiosk|web|push_notification`',
    `device_type` STRING COMMENT 'Type of device used by the fan to complete the NPS survey. Informs UX optimization and channel strategy for future survey deployments across Adobe Experience Platform.. Valid values are `mobile|tablet|desktop|kiosk|smart_tv`',
    `followup_action_required` BOOLEAN COMMENT 'Indicates whether this NPS response has triggered a follow-up action, typically for Detractor recovery workflows in Salesforce CRM case management. True when a CRM case or outreach task has been created; False otherwise.',
    `followup_status` STRING COMMENT 'Current status of the CRM follow-up action associated with this NPS response. Pending indicates a case has been created but not yet actioned; in_progress means outreach is underway; resolved means the fan concern has been addressed; no_action means no follow-up was warranted.. Valid values are `pending|in_progress|resolved|no_action`',
    `invitations_sent` STRING COMMENT 'Total number of survey invitations dispatched to fans for this campaign. Used as the denominator in response rate calculation and campaign reach reporting.',
    `is_anonymous` BOOLEAN COMMENT 'Indicates whether the fan submitted this NPS response anonymously (True) or as an authenticated, identified fan (False). Determines whether fan_id can be populated and governs GDPR/CCPA data linkage permissions for this response.',
    `market_region` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the geographic market in which this survey was administered (e.g., USA, GBR, BRA). Supports regional NPS benchmarking and compliance with jurisdiction-specific privacy regulations (GDPR for EU markets, CCPA for California).. Valid values are `^[A-Z]{3}$`',
    `membership_tier` STRING COMMENT 'Loyalty or membership tier of the fan respondent at the time of survey submission (e.g., General, Silver, Gold, Platinum, VIP). Enables NPS segmentation by membership tier to identify satisfaction differentials across fan loyalty segments.. Valid values are `general|silver|gold|platinum|vip`',
    `nps_benchmark_version` STRING COMMENT 'Version identifier of the NPS benchmarking framework applied to this survey campaign (e.g., NPS2_2024, SPORTS_BENCH_V3). Ensures consistent year-over-year comparability when benchmark methodologies are updated.',
    `nps_score` STRING COMMENT 'The individual fans likelihood-to-recommend score on the standard NPS scale of 0 to 10. Scores 0-6 classify as Detractors, 7-8 as Passives, and 9-10 as Promoters. This is the principal quantitative outcome of the survey response. Null at the campaign header level; populated at the individual response level.',
    `open_date` DATE COMMENT 'The calendar date on which the NPS survey campaign was opened and made available for fan responses. Defines the start of the survey collection window.',
    `reminder_sent` BOOLEAN COMMENT 'Indicates whether a reminder communication was sent to the fan for this survey invitation. Used to assess the impact of reminders on response rates and to prevent over-communication in compliance with fan communication preferences.',
    `reminder_timestamp` TIMESTAMP COMMENT 'Date and time at which the survey reminder communication was dispatched to the fan. Null when no reminder was sent. Used for communication cadence analysis and deliverability reporting.',
    `respondent_category` STRING COMMENT 'Classification of the fan respondent based on their NPS score: Promoter (score 9-10), Passive (score 7-8), or Detractor (score 0-6). Drives CRM case management workflows, detractor recovery outreach, and promoter advocacy programs.. Valid values are `promoter|passive|detractor`',
    `response_rate` DECIMAL(18,2) COMMENT 'Proportion of survey invitations that resulted in a completed response, expressed as a decimal (e.g., 0.2350 = 23.50%). Stored as a raw ratio to support benchmarking and trend analysis without requiring recalculation. Populated at campaign close.',
    `response_timestamp` TIMESTAMP COMMENT 'The precise date and time (ISO 8601 with timezone offset) at which the fan submitted their NPS survey response. Used for time-series analysis, response rate calculation, and audit trail. This is the principal business event timestamp for the response record.',
    `responses_received` STRING COMMENT 'Total number of completed NPS survey responses received for this campaign. Used as the numerator in response rate calculation and for statistical significance assessment.',
    `season_ticket_holder` BOOLEAN COMMENT 'Indicates whether the fan respondent held a season ticket at the time of survey submission. Season ticket holders (STH) represent a high-value fan segment and their NPS scores are tracked separately for retention and renewal strategy.',
    `source_system` STRING COMMENT 'Operational system of record from which this NPS survey record originated. Supports data lineage, reconciliation, and Silver layer ingestion auditing across the Databricks Lakehouse.. Valid values are `salesforce_crm|adobe_experience_platform|in_venue_kiosk|sms_platform|email_platform`',
    `survey_code` STRING COMMENT 'Externally-known alphanumeric business identifier for the survey campaign, used in Salesforce CRM and Adobe Experience Platform for cross-system reference and reporting. Format: NPS- followed by 4-20 alphanumeric characters.. Valid values are `^NPS-[A-Z0-9]{4,20}$`',
    `survey_language` STRING COMMENT 'ISO 639-1 language code (optionally with ISO 3166-1 alpha-2 region subtag) in which the survey was presented to the fan (e.g., en, es, fr, pt-BR). Supports multilingual fan engagement across global markets.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `survey_name` STRING COMMENT 'Human-readable name of the NPS survey campaign (e.g., Post-Match Fan Experience Survey Q3 2024, Season Ticket Holder Relationship NPS). Used for reporting, CRM case management, and stakeholder communications.',
    `survey_status` STRING COMMENT 'Current lifecycle state of the NPS survey campaign. Draft indicates the survey is being configured; active means it is open for responses; paused means collection is temporarily halted; closed means the survey window has ended; archived means the record is retained for historical analysis only.. Valid values are `draft|active|paused|closed|archived`',
    `survey_type` STRING COMMENT 'Classification of the NPS survey by its business trigger or cadence. Post-event surveys are tied to a specific game or concert; post-purchase surveys follow a ticket or merchandise transaction; seasonal surveys are periodic; relationship surveys measure overall fan sentiment; onboarding surveys target new fans.. Valid values are `post_event|post_purchase|seasonal|relationship|onboarding`',
    `target_segment_code` STRING COMMENT 'CRM audience segment code identifying the fan population targeted by this survey campaign (e.g., STH_GOLD, VIP_SUITE, GA_CASUAL). Sourced from Salesforce CRM segmentation and Adobe Experience Platform audience definitions. Enables segment-level NPS benchmarking.',
    `touchpoint_type` STRING COMMENT 'The specific fan experience touchpoint that this NPS survey is measuring (e.g., game_day experience, broadcast/streaming experience, merchandise purchase, ticketing process, mobile app, venue service, fan club membership). Enables touchpoint-level NPS decomposition for targeted improvement initiatives. [ENUM-REF-CANDIDATE: game_day|broadcast|merchandise|ticketing|app|venue_service|fan_club — promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time at which this NPS survey record was most recently modified. Used for incremental data pipeline processing, change data capture, and audit trail maintenance in the Databricks Silver layer.',
    `verbatim_comment` STRING COMMENT 'Open-text qualitative feedback provided by the fan in response to the follow-up question (e.g., What is the main reason for your score?). Used for sentiment analysis, thematic reporting, and CRM case management. May contain personally identifiable information and must be handled per GDPR and CCPA data minimization principles.',
    CONSTRAINT pk_nps_survey PRIMARY KEY(`nps_survey_id`)
) COMMENT 'NPS (Net Promoter Score) survey program and response records. Captures survey campaign details: survey name, type (post-event, post-purchase, seasonal, relationship), associated event or touchpoint, channel (email, in-app, SMS, in-venue kiosk), open/close dates, target segment, and response rate. Also captures individual fan responses: NPS score (0-10), promoter/passive/detractor classification, verbatim comment text, response timestamp, follow-up action flag, and associated event or purchase reference. SSOT for fan satisfaction measurement. Feeds CRM case management for detractor recovery workflows.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`fan`.`nps_response` (
    `nps_response_id` BIGINT COMMENT 'Unique surrogate identifier for each individual NPS survey response record. Primary key for the nps_response data product within the fan domain.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to content.asset. Business justification: Content-level NPS analytics: individual NPS responses triggered by content consumption must link to the specific asset for content performance dashboards. Sports streaming operators report NPS by cont',
    `digital_touchpoint_id` BIGINT COMMENT 'Foreign key linking to platform.digital_touchpoint. Business justification: Touchpoint-level NPS analysis (app NPS vs. web NPS) is a standard digital product KPI in sports-entertainment. Linking nps_response to digital_touchpoint enables response channel segmentation, touchpo',
    `event_fixture_id` BIGINT COMMENT 'Reference to the live event (game, concert, match) associated with this NPS response, if the survey was triggered by event attendance. Nullable for non-event-triggered surveys.',
    `fan_profile_id` BIGINT COMMENT 'Reference to the fan profile who submitted this NPS response. Links to the fan master profile record in the fan domain SSOT.',
    `fixture_id` BIGINT COMMENT 'Reference to the live event (game, concert, match) associated with this NPS response, if the survey was triggered by event attendance. Nullable for non-event-triggered surveys.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: NPS detractor follow-up workflows assign specific CX staff to each response requiring action. Sports entertainment CX managers track employee ownership of follow-up tasks for SLA compliance, coaching,',
    `franchise_id` BIGINT COMMENT 'Foreign key linking to league.franchise. Business justification: Franchise-level fan satisfaction reporting, CRM follow-up workflows, and franchise operations escalation routing require knowing which franchise an NPS response relates to. New attribute uses target P',
    `league_id` BIGINT COMMENT 'Reference to the sports league or competition governing body associated with the event or context that triggered this NPS survey. Enables NPS benchmarking and analysis across leagues (e.g., NFL, NBA, MLS, NHL).',
    `season_id` BIGINT COMMENT 'Foreign key linking to league.season. Business justification: Season-level NPS response analysis and fan satisfaction trend reporting by season are standard sports-entertainment analytics. Linking responses to a specific season enables season-cohort NPS tracking',
    `nps_survey_id` BIGINT COMMENT 'Reference to the NPS survey instrument that generated this response. Identifies the specific survey campaign, version, and configuration used.',
    `security_incident_id` BIGINT COMMENT 'Foreign key linking to security.security_incident. Business justification: Post-incident NPS surveys are a standard fan recovery process in sports entertainment. Linking the individual NPS response to the triggering security incident enables incident-driven satisfaction trac',
    `service_case_id` BIGINT COMMENT 'Reference to the Salesforce CRM case created for detractor recovery workflow. Populated when follow-up action is initiated for low NPS scores. Null if no case has been opened.',
    `session_id` BIGINT COMMENT 'Foreign key linking to gaming.gaming_session. Business justification: Post-session NPS measurement: sports betting operators trigger NPS surveys at gaming session end as a standard responsible gaming and CX practice. Linking the NPS response to the specific gaming sessi',
    `sponsorship_activation_id` BIGINT COMMENT 'Foreign key linking to sponsorship.activation. Business justification: Post-activation NPS surveys measure fan sentiment attributable to specific sponsorship activations. Sponsors require activation-level NPS data for ROI reports and renewal negotiations. This link enabl',
    `streaming_subscription_id` BIGINT COMMENT 'Reference to the OTT or broadcast streaming subscription associated with this NPS response, if the survey was triggered by a streaming or broadcast experience. Null for in-venue or non-broadcast contexts.',
    `ticket_order_id` BIGINT COMMENT 'Reference to the ticket, merchandise, or subscription purchase transaction that triggered this NPS survey, if applicable. Supports post-purchase satisfaction measurement.',
    `venue_id` BIGINT COMMENT 'Reference to the venue associated with the event or experience that triggered this NPS survey. Enables venue-level NPS benchmarking and facility management feedback analysis.',
    `consent_given` BOOLEAN COMMENT 'Indicates whether the fan provided explicit consent for their survey response data (including verbatim comments) to be used for analytics, personalization, and CRM purposes at the time of submission.',
    `consent_version` STRING COMMENT 'The version identifier of the privacy consent notice presented to the fan at the time of survey submission. Enables compliance audit trails demonstrating which consent terms were in effect when data was collected.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this NPS response record was first ingested and created in the Silver layer data product. Audit trail field for data lineage and compliance.',
    `data_retention_expiry_date` DATE COMMENT 'The date after which this NPS response record must be purged or anonymised in accordance with the applicable data retention policy. Supports GDPR right to erasure and CCPA deletion request compliance.',
    `device_type` STRING COMMENT 'The type of device used by the fan to complete the NPS survey. Enables channel and device-level analysis of survey completion rates and score distributions.. Valid values are `mobile|tablet|desktop|kiosk|smart_tv|other`',
    `external_response_ref` STRING COMMENT 'The externally-known unique identifier for this response as assigned by the survey platform (e.g., Adobe Experience Platform response GUID or third-party NPS tool reference). Used for cross-system reconciliation.',
    `fan_locale_country_code` STRING COMMENT 'The ISO 3166-1 alpha-3 country code representing the fans locale at the time of survey response. Enables geographic segmentation of NPS scores across global markets.. Valid values are `^[A-Z]{3}$`',
    `fan_tenure_days` STRING COMMENT 'The number of days the fan has been a registered member as of the response date. Enables cohort analysis of NPS scores by fan tenure and lifecycle stage.',
    `follow_up_completed_date` DATE COMMENT 'The actual date on which the follow-up action for this NPS response was completed and resolved. Used to measure SLA adherence and time-to-resolution for detractor recovery.',
    `follow_up_due_date` DATE COMMENT 'The target date by which the follow-up action for a detractor response must be completed, as defined by the fan engagement Service Level Agreement (SLA). Null if no follow-up is required.',
    `follow_up_required` BOOLEAN COMMENT 'Indicates whether this NPS response requires a follow-up action, typically triggered for detractor scores (0-6) to initiate CRM recovery workflows. True = follow-up action is required; False = no follow-up needed.',
    `follow_up_status` STRING COMMENT 'Current status of the follow-up action for this NPS response. Tracks the detractor recovery workflow lifecycle from initial identification through resolution. not_required for passive and promoter responses where no action was triggered.. Valid values are `pending|in_progress|resolved|closed|not_required`',
    `is_anonymous` BOOLEAN COMMENT 'Indicates whether the fan opted to submit this NPS response anonymously. True = anonymous submission where fan identity is not linked; False = identified submission linked to fan profile. Impacts GDPR data subject rights applicability.',
    `is_first_response` BOOLEAN COMMENT 'Indicates whether this is the fans first-ever NPS survey response on record. Used for new fan onboarding analytics and baseline satisfaction benchmarking.',
    `membership_tier_at_response` STRING COMMENT 'The fans loyalty membership tier at the time of survey response (e.g., standard, silver, gold, platinum, VIP). Captured as a snapshot to enable NPS analysis by membership tier without dependency on current tier status. [ENUM-REF-CANDIDATE: standard|silver|gold|platinum|vip|season_ticket_holder — promote to reference product]',
    `nps_category` STRING COMMENT 'Derived classification of the fan based on their NPS score: promoter (score 9-10), passive (score 7-8), or detractor (score 0-6). Used for CRM segmentation, detractor recovery workflows, and NPS calculation reporting.. Valid values are `promoter|passive|detractor`',
    `nps_score` STRING COMMENT 'The fans raw NPS rating on a scale of 0 to 10, where 0 is extremely unlikely to recommend and 10 is extremely likely to recommend. The principal quantitative measurement of fan satisfaction. Scores 0-6 = Detractor, 7-8 = Passive, 9-10 = Promoter.',
    `primary_feedback_theme` STRING COMMENT 'The dominant topic or theme identified from the verbatim comment through NLP text classification (e.g., venue_experience, ticketing, broadcast_quality, athlete_performance, food_beverage, customer_service). Used for root cause analysis of NPS drivers. [ENUM-REF-CANDIDATE: venue_experience|ticketing|broadcast_quality|athlete_performance|food_beverage|customer_service|merchandise|parking|app_experience — promote to reference product]',
    `prior_nps_score` STRING COMMENT 'The fans NPS score from their most recent previous survey response, captured as a snapshot at the time of this response. Enables score delta analysis and trend tracking without requiring a self-join.',
    `response_channel` STRING COMMENT 'The channel through which the fan received and submitted the NPS survey. Used to analyze satisfaction scores by engagement channel and optimize survey distribution strategy.. Valid values are `email|sms|mobile_app|web|kiosk|in_venue`',
    `response_latency_minutes` STRING COMMENT 'The elapsed time in minutes between the survey invitation being sent and the fan submitting their response. Used to assess recency bias and optimize survey timing for maximum response quality.',
    `response_status` STRING COMMENT 'Current lifecycle status of the NPS response record. submitted = complete and valid; partial = survey started but not fully completed; withdrawn = fan requested removal; invalid = failed validation rules; duplicate = identified as a duplicate submission.. Valid values are `submitted|partial|withdrawn|invalid|duplicate`',
    `response_timestamp` TIMESTAMP COMMENT 'The exact date and time when the fan submitted the NPS survey response. Principal business event timestamp representing the moment of fan satisfaction measurement. Stored in ISO 8601 format with timezone offset.',
    `score_change_direction` STRING COMMENT 'Categorical indicator of whether the fans NPS score improved, declined, or remained unchanged compared to their prior response. first_response when no prior score exists. Supports trend analysis and loyalty program effectiveness measurement.. Valid values are `improved|declined|unchanged|first_response`',
    `sentiment_label` STRING COMMENT 'Categorical sentiment classification derived from NLP analysis of the verbatim comment. Complements the numeric sentiment score for reporting and CRM segmentation purposes.. Valid values are `positive|neutral|negative|mixed`',
    `sentiment_score` DECIMAL(18,2) COMMENT 'Numeric sentiment polarity score derived from NLP analysis of the verbatim comment, ranging from -1.0000 (most negative) to 1.0000 (most positive). Populated by the Adobe Experience Platform AI/ML sentiment analysis pipeline.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this NPS response was ingested into the Silver layer. Supports data lineage, reconciliation, and multi-platform survey consolidation.. Valid values are `aep|salesforce_crm|medallia|qualtrics|internal`',
    `survey_completion_time_seconds` STRING COMMENT 'The elapsed time in seconds from when the fan opened the survey to when they submitted it. Used to assess survey engagement quality and identify potentially rushed or bot-generated responses.',
    `survey_invitation_timestamp` TIMESTAMP COMMENT 'The date and time when the NPS survey invitation was sent to the fan. Used to calculate response latency (time between invitation and submission) and to assess survey recency bias.',
    `survey_language_code` STRING COMMENT 'The ISO 639-1 language code (optionally with ISO 3166-1 country subtag) in which the survey was presented and the fan responded. Supports multilingual NPS analysis across global markets.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `survey_trigger_type` STRING COMMENT 'The business event or rule that triggered the NPS survey invitation to the fan. Enables analysis of satisfaction scores by trigger context and optimization of survey timing strategy.. Valid values are `post_event|post_purchase|periodic|onboarding|churn_risk|manual`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this NPS response record was last modified, such as when follow-up status was updated or a CRM case was linked. Supports audit trail and change tracking.',
    `verbatim_comment` STRING COMMENT 'The free-text open-ended comment provided by the fan explaining their NPS score. Contains qualitative feedback used for sentiment analysis, theme identification, and CRM case management. May contain sensitive personal opinions.',
    CONSTRAINT pk_nps_response PRIMARY KEY(`nps_response_id`)
) COMMENT 'Individual fan NPS survey response record. Captures fan profile ID, survey ID, NPS score (0-10), promoter/passive/detractor classification, verbatim comment text, response channel, response timestamp, follow-up action flag, follow-up status, and associated event or purchase reference. SSOT for fan satisfaction measurement. Feeds CRM case management for detractor recovery workflows.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` (
    `engagement_event_id` BIGINT COMMENT 'Unique surrogate identifier for each discrete fan engagement interaction record in the Silver layer lakehouse. Primary key for this table.',
    `access_zone_id` BIGINT COMMENT 'Identifier of the specific in-venue Bluetooth Low Energy (BLE) beacon zone that detected the fan during an in-venue engagement event. Enables micro-location analytics, concession proximity targeting, and crowd flow analysis.',
    `athlete_profile_id` BIGINT COMMENT 'Foreign key linking to athlete.athlete_profile. Business justification: Athlete-attributed fan engagement analytics: sports entertainment operators track which athletes drive fan engagement (highlight views, social interactions, appearance events) to inform NIL valuations',
    `auth_session_id` BIGINT COMMENT 'Identifier grouping multiple engagement events within a single continuous fan session (e.g., a single app visit or in-venue stay). Enables session-level analytics, funnel analysis, and dwell time calculation in Adobe Experience Platform.',
    `broadcast_schedule_id` BIGINT COMMENT 'Foreign key linking to broadcast.broadcast_schedule. Business justification: Fan digital engagement events (app opens, social interactions, content views) during a broadcast must be correlated with the specific broadcast schedule slot for audience analytics, ratings supplement',
    `broadcast_stream_live_feed_id` BIGINT COMMENT 'Reference to the live broadcast or OTT (Over-The-Top) stream being watched during a live stream watch engagement event. Nullable for non-broadcast engagement types. Links to broadcast schedule and rights data.',
    `campaign_id` BIGINT COMMENT 'Identifier of the marketing or fan engagement campaign that triggered or is associated with this engagement event. Used for campaign performance measurement, Cost Per Mille (CPM) reporting, and Gross Rating Point (GRP) attribution.',
    `asset_id` BIGINT COMMENT 'Reference to the specific content asset (video, article, highlight reel, podcast) consumed or interacted with during this engagement. Nullable for non-content engagement types.',
    `contest_id` BIGINT COMMENT 'Identifier of the fan contest or sweepstakes associated with a contest entry engagement event. Nullable for non-contest engagement types. Used for contest participation tracking and prize fulfillment.',
    `digital_touchpoint_id` BIGINT COMMENT 'Foreign key linking to platform.digital_touchpoint. Business justification: Digital touchpoint attribution for fan engagement events is a core channel performance analytics requirement in sports-entertainment. Linking engagement_event to digital_touchpoint enables touchpoint-',
    `event_fixture_id` BIGINT COMMENT 'Reference to the sports or entertainment event associated with this engagement interaction (e.g., game, concert, match). Nullable for non-event-specific engagements such as app browsing or content views.',
    `fan_profile_id` BIGINT COMMENT 'Reference to the fan profile who performed this engagement interaction. Core party reference linking behavioral data to the fan identity and CRM record in Salesforce CRM.',
    `fixture_id` BIGINT COMMENT 'Reference to the sports or entertainment event associated with this engagement interaction (e.g., game, concert, match). Nullable for non-event-specific engagements such as app browsing or content views.',
    `live_feed_id` BIGINT COMMENT 'Reference to the live broadcast or OTT (Over-The-Top) stream being watched during a live stream watch engagement event. Nullable for non-broadcast engagement types. Links to broadcast schedule and rights data.',
    `loyalty_program_id` BIGINT COMMENT 'Reference to the loyalty program under which a loyalty redemption or points-earning engagement event occurred. Nullable for non-loyalty engagement types. Links to loyalty program master data for tier and points management.',
    `merch_order_id` BIGINT COMMENT 'Foreign key linking to merchandise.merch_order. Business justification: Engagement events that result in a completed merchandise purchase (e.g., in-app buy, stadium kiosk tap) must reference the resulting merch_order for conversion funnel analysis and attribution reportin',
    `ppv_transaction_id` BIGINT COMMENT 'Foreign key linking to broadcast.ppv_transaction. Business justification: Fan engagement events during PPV streams (viewing duration, quality drops, abandonment) must reference the PPV transaction for access validation and rights-holder audience reporting. engagement_event ',
    `sku_catalog_id` BIGINT COMMENT 'Foreign key linking to merchandise.sku_catalog. Business justification: Merchandise engagement events (browse, add-to-cart, wishlist) reference a specific SKU. Replacing the denormalized merchandise_sku string with a proper FK enables merchandise conversion funnel analyti',
    `sponsorship_activation_id` BIGINT COMMENT 'Foreign key linking to sponsorship.activation. Business justification: Sponsorship activation performance measurement requires attributing fan engagement events (app interactions, in-venue scans, content views) to specific activations. This is a core sponsorship ROI repo',
    `ticket_inventory_id` BIGINT COMMENT 'Reference to the ticket associated with an attendance check-in engagement event. Links the behavioral engagement record to the ticketing transaction in Ticketmaster/AXS for attendance verification and season ticket holder analytics.',
    `ticket_order_line_id` BIGINT COMMENT 'Reference to the ticket associated with an attendance check-in engagement event. Links the behavioral engagement record to the ticketing transaction in Ticketmaster/AXS for attendance verification and season ticket holder analytics.',
    `venue_id` BIGINT COMMENT 'Reference to the physical venue where an in-venue engagement occurred (e.g., beacon detection, check-in, kiosk interaction). Nullable for digital-only engagement types. Links to venue master data for location-based analytics.',
    `aep_experience_event_reference` STRING COMMENT 'The source system event identifier assigned by Adobe Experience Platform at the point of behavioral data capture. Used for lineage tracing and deduplication against the AEP raw event stream.',
    `aep_segment_ids` STRING COMMENT 'Pipe-delimited list of Adobe Experience Platform (AEP) audience segment identifiers that the fan belonged to at the time of this engagement event. Captures the real-time segmentation state for personalization attribution and segment performance analysis. Stored as a delimited string per Silver layer no-complex-type convention.',
    `app_version` STRING COMMENT 'Version number of the mobile or web application from which the engagement event was generated. Used for feature adoption tracking, bug correlation, and release impact analysis.. Valid values are `^d+.d+.d+$`',
    `consent_analytics` BOOLEAN COMMENT 'Indicates whether the fan had active analytics and behavioral tracking consent at the time of this engagement event. Governs whether this event can be used in behavioral analytics models and personalization under GDPR and CCPA.',
    `consent_marketing` BOOLEAN COMMENT 'Indicates whether the fan had active marketing communications consent at the time of this engagement event, as recorded in the consent management platform. Governs whether this event can be used for personalized marketing activation under GDPR and CCPA.',
    `content_progress_pct` DECIMAL(18,2) COMMENT 'Percentage of a content asset (video, podcast, article) consumed by the fan during a content view or live stream watch engagement event. Ranges from 0.00 to 100.00. Used for content completion rate analytics and personalization model features.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this engagement event record was first written to the Silver layer lakehouse. Used for audit trail, data lineage, and SLA monitoring of the AEP ingestion pipeline. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `crm_interaction_reference` STRING COMMENT 'The corresponding interaction or activity record identifier in Salesforce CRM, if this engagement event was surfaced or actioned through the CRM platform. Used for cross-system reconciliation between AEP behavioral data and Salesforce CRM fan interaction history.',
    `data_quality_flag` STRING COMMENT 'Result of the Silver layer data quality validation applied to this engagement event record. Indicates whether the record passed all quality checks, has warnings (e.g., missing optional fields), failed critical checks, or is pending manual review.. Valid values are `passed|warning|failed|pending_review`',
    `device_os` STRING COMMENT 'Operating system of the device used during the engagement event. Used for platform-specific analytics, app version targeting, and technical performance monitoring. [ENUM-REF-CANDIDATE: ios|android|windows|macos|tvos|roku|fire_os|unknown — 8 candidates stripped; promote to reference product]',
    `device_type` STRING COMMENT 'Category of device used by the fan to generate this engagement event. Informs device-specific personalization, app performance optimization, and cross-device identity resolution in Adobe Experience Platform. [ENUM-REF-CANDIDATE: smartphone|tablet|desktop|smart_tv|wearable|kiosk|set_top_box|unknown — 8 candidates stripped; promote to reference product]',
    `duration_seconds` STRING COMMENT 'Duration of the engagement interaction in seconds. Applicable to content views, live stream watches, app sessions, and in-venue beacon detections. Used for watch-time analysis, dwell time reporting, and fan lifetime value (LTV) modeling.',
    `engagement_channel` STRING COMMENT 'The interface or platform through which the fan engagement occurred. Distinguishes mobile app, web, in-venue, broadcast, social, Over-The-Top (OTT) streaming, email, and kiosk interactions for omnichannel analytics. [ENUM-REF-CANDIDATE: mobile_app|web|in_venue|broadcast|social|ott|email|kiosk — promote to reference product]',
    `engagement_date` DATE COMMENT 'Calendar date of the fan engagement interaction, derived from engagement_timestamp. Used as a partition key and for day-level aggregation in reporting, event-day analysis, and fan attendance correlation. Format: yyyy-MM-dd.',
    `engagement_status` STRING COMMENT 'Current processing lifecycle state of the engagement event record within the Silver layer pipeline. Indicates whether the event has been captured from AEP, validated, enriched with fan profile data, rejected due to quality issues, or flagged as a duplicate.. Valid values are `captured|validated|enriched|rejected|duplicate`',
    `engagement_timestamp` TIMESTAMP COMMENT 'The precise real-world date and time when the fan engagement interaction occurred, as recorded by the source system. Principal business event time used for time-series analysis, session stitching, and RFM recency scoring. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `engagement_type` STRING COMMENT 'Categorical discriminator identifying the kind of fan engagement interaction captured. Drives segmentation, RFM scoring, and personalization model feature engineering. [ENUM-REF-CANDIDATE: attendance_checkin|app_session|content_view|social_share|merchandise_browse|loyalty_redemption|live_stream_watch|beacon_detection|contest_entry|watchlist_action — promote to reference product]',
    `engagement_value_score` DECIMAL(18,2) COMMENT 'Weighted numeric score representing the business value of this individual engagement interaction, assigned by the AEP scoring model based on engagement type, duration, and channel. Primary input to RFM (Recency, Frequency, Monetary) scoring and fan LTV (Lifetime Value) calculation.',
    `geo_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the geographic location of the fan at the time of the engagement event, derived from device GPS, IP geolocation, or venue context. Used for international market segmentation and GDPR/CCPA jurisdiction determination.. Valid values are `^[A-Z]{3}$`',
    `geo_region_code` STRING COMMENT 'ISO 3166-2 subdivision code (state, province, or region) of the fans location at the time of engagement. Used for Regional Sports Network (RSN) blackout rule enforcement, regional sponsorship attribution, and market-level reporting.. Valid values are `^[A-Z]{2}-[A-Z0-9]{1,3}$`',
    `ip_address` STRING COMMENT 'Internet Protocol (IP) address of the device at the time of the engagement event. Used for geolocation enrichment, fraud detection, and broadcast blackout rule enforcement. Classified as confidential PII as it may identify an individual in certain jurisdictions under GDPR.',
    `is_authenticated` BOOLEAN COMMENT 'Indicates whether the fan was authenticated (logged in) at the time of the engagement event. Authenticated events can be linked to a known fan profile; unauthenticated events are anonymous. Critical for identity resolution and GDPR/CCPA consent enforcement.',
    `loyalty_points_earned` STRING COMMENT 'Number of loyalty points awarded to the fan as a result of this engagement event. Applicable to qualifying engagement types such as attendance check-in, content view, and merchandise browse. Zero for non-qualifying events.',
    `loyalty_points_redeemed` STRING COMMENT 'Number of loyalty points consumed by the fan during a loyalty redemption engagement event. Zero for non-redemption events. Used for loyalty liability tracking and redemption rate analytics.',
    `nps_score` BOOLEAN COMMENT 'Net Promoter Score (NPS) rating submitted by the fan during this engagement event, on a scale of 0 to 10. Captured when the engagement type includes an NPS survey prompt. Used for fan satisfaction tracking and loyalty segmentation.',
    `referral_source` STRING COMMENT 'The originating source or campaign that drove the fan to this engagement event (e.g., push notification, email campaign, paid social ad, organic search, direct). Used for Customer Acquisition Cost (CAC) attribution and campaign Return on Investment (ROI) analysis.',
    `social_platform` STRING COMMENT 'The social media platform on which a social share engagement event occurred. Nullable for non-social engagement types. Used for social channel performance analytics and influencer attribution. [ENUM-REF-CANDIDATE: twitter|instagram|facebook|tiktok|youtube|snapchat|other — 7 candidates stripped; promote to reference product]',
    `source_system` STRING COMMENT 'Identifies the operational system of record that originated this engagement event record. Primary source is Adobe Experience Platform (AEP); secondary sources include Ticketmaster/AXS for check-in events and Shopify Plus for merchandise browse events. [ENUM-REF-CANDIDATE: aep|ticketmaster|archtics|shopify|salesforce|dalet|hudl|manual — 8 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this engagement event record was last modified in the Silver layer, such as during enrichment, status update, or data quality correction. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    CONSTRAINT pk_engagement_event PRIMARY KEY(`engagement_event_id`)
) COMMENT 'High-volume transactional record of every discrete fan engagement interaction across all channels — event attendance check-in, app session, content view, social share, merchandise browse, loyalty redemption, live stream watch, in-venue beacon detection, contest entry, and content follow/watchlist actions. Captures engagement type, channel (mobile app, web, in-venue, broadcast, social), timestamp, duration, associated event or content ID, device type, location context, and engagement value score. Sourced from Adobe Experience Platform behavioral data stream. Primary feed for RFM scoring, personalization models, and fan lifetime value calculation.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`fan`.`communication` (
    `communication_id` BIGINT COMMENT 'Primary key for communication',
    `bonus_offer_id` BIGINT COMMENT 'Foreign key linking to gaming.bonus_offer. Business justification: Bonus offer marketing compliance: communications promoting specific betting bonus offers must reference the bonus_offer record for conversion tracking, regulatory bonus advertising compliance (terms m',
    `broadcast_schedule_id` BIGINT COMMENT 'Foreign key linking to broadcast.broadcast_schedule. Business justification: Fan communications triggered by broadcast schedules (pre-game channel alerts, PPV reminders, live broadcast notifications) must reference the specific broadcast schedule slot. Enables broadcast-trigge',
    `asset_id` BIGINT COMMENT 'Foreign key linking to content.asset. Business justification: Content-driven fan communication: push notifications and emails in sports entertainment feature specific content assets (Watch this highlight). Linking communication to the featured asset enables co',
    `digital_touchpoint_id` BIGINT COMMENT 'Foreign key linking to platform.digital_touchpoint. Business justification: Cross-channel communication performance reporting requires attributing each fan communication to its delivery touchpoint (mobile app, email, SMS gateway). A marketing operations analyst in sports-ente',
    `engagement_event_id` BIGINT COMMENT 'Reference to the sports or entertainment event associated with this communication (e.g., a game-day reminder, post-event survey, or ticket offer for a specific fixture). Links to the event domain.',
    `fan_fan_profile_id` BIGINT COMMENT 'Reference to the fan profile who is the recipient of this communication. Links to the fan master profile record in the fan domain.',
    `fan_profile_id` BIGINT COMMENT 'Reference to the fan profile who is the recipient of this communication. Links to the fan master profile record in the fan domain.',
    `fixture_id` BIGINT COMMENT 'Reference to the sports or entertainment event associated with this communication (e.g., a game-day reminder, post-event survey, or ticket offer for a specific fixture). Links to the event domain.',
    `notification_campaign_id` BIGINT COMMENT 'Reference to the marketing campaign or journey that triggered this communication. Sourced from Salesforce CRM or Adobe Experience Platform campaign execution logs.',
    `promotion_id` BIGINT COMMENT 'Foreign key linking to merchandise.promotion. Business justification: Fan communications (email, push, SMS) promoting merchandise offers must reference the specific promotion to measure campaign-to-redemption conversion, enforce usage limits, and attribute revenue to th',
    `segment_id` BIGINT COMMENT 'Reference to the fan audience segment or CRM list that this communication was targeted to. Used for communication fatigue management and audience analytics.',
    `sponsorship_activation_id` BIGINT COMMENT 'Foreign key linking to sponsorship.activation. Business justification: Sponsor-branded fan communications (emails, push notifications) are activation deliverables requiring proof-of-performance reporting. Linking communication to activation enables fulfillment tracking o',
    `communication_template_id` BIGINT COMMENT 'Identifier of the content template used to render this communication. References the template version in Salesforce CRM or Adobe Experience Platform. Enables template performance analysis.',
    `ab_test_variant` STRING COMMENT 'Identifier of the A/B or multivariate test variant assigned to this communication (e.g., A, B, control). Used to measure the performance of different subject lines, content, or send times in campaign optimisation.',
    `bounce_type` STRING COMMENT 'Classification of the delivery bounce when delivery_status is bounced. Hard bounce = permanent delivery failure (invalid address); Soft bounce = temporary failure (mailbox full, server unavailable); Block = rejected by receiving server due to spam or policy rules.. Valid values are `hard|soft|block`',
    `campaign_name` STRING COMMENT 'Human-readable name of the campaign, journey, or automation workflow that generated this communication. Sourced from Salesforce CRM or Adobe Experience Platform campaign execution logs.',
    `channel` STRING COMMENT 'The delivery channel used to send this communication to the fan. Supports omnichannel fan engagement tracking across email, SMS, push notification, in-app message, and direct mail.. Valid values are `email|sms|push_notification|in_app|direct_mail`',
    `click_timestamp` TIMESTAMP COMMENT 'The date and time (UTC) at which the fan first clicked a link or call-to-action within the communication. Null if no click was recorded. Used for click-through rate (CTR) and conversion analysis.',
    `click_url` STRING COMMENT 'The specific URL or deep link that the fan clicked within the communication. Captures the primary or first-click URL for conversion attribution and content performance analysis.',
    `communication_type` STRING COMMENT 'Classification of the communication by business purpose. Transactional messages are triggered by fan actions (e.g., ticket purchase confirmation); marketing messages are campaign-driven; loyalty messages relate to loyalty program activity; service messages are operational; alerts are time-sensitive notifications.. Valid values are `transactional|marketing|loyalty|service|alert`',
    `consent_basis` STRING COMMENT 'The GDPR lawful basis under which this communication was sent to the fan. Explicit consent = fan actively opted in; Legitimate interest = business interest basis; Contractual = required for contract fulfilment (e.g., ticket confirmation); Vital interest = emergency safety communication.. Valid values are `explicit_consent|legitimate_interest|contractual|vital_interest`',
    `consent_version` STRING COMMENT 'The version identifier of the consent or privacy notice that was in effect at the time this communication was sent. Enables audit trail demonstrating which consent terms governed the communication.',
    `conversion_flag` BOOLEAN COMMENT 'Indicates whether the fan completed the intended conversion action (e.g., ticket purchase, merchandise order, loyalty enrolment) within the attribution window following this communication. True = conversion attributed to this communication.',
    `conversion_timestamp` TIMESTAMP COMMENT 'The date and time (UTC) at which the fan completed the attributed conversion action following this communication. Null if no conversion was recorded. Used for attribution window analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time (UTC) at which this communication record was first created in the Silver Layer data product. Audit field for data lineage and record provenance.',
    `delivery_status` STRING COMMENT 'Current delivery lifecycle state of the communication as reported by the delivery provider. Sent = dispatched to provider; Delivered = confirmed receipt by recipient server/device; Bounced = undeliverable; Failed = system error; Pending = queued.. Valid values are `sent|delivered|bounced|failed|pending`',
    `delivery_timestamp` TIMESTAMP COMMENT 'The date and time (UTC) at which delivery of the communication was confirmed by the receiving server or device. Null if delivery has not been confirmed or if the message bounced.',
    `device_type` STRING COMMENT 'The type of device on which the fan opened or interacted with the communication, as reported by the delivery platform. Used for channel optimisation and responsive content design decisions.. Valid values are `mobile|desktop|tablet|smart_tv|unknown`',
    `external_message_reference` STRING COMMENT 'The unique message identifier assigned by the originating system of record (Salesforce CRM, Adobe Experience Platform, or third-party ESP/SMS gateway). Used for deduplication and cross-system traceability.',
    `fatigue_score` STRING COMMENT 'Numeric score representing the fans communication fatigue level at the time this message was sent, calculated from recent communication frequency. Used to enforce fatigue caps and optimise send cadence. Higher values indicate greater fatigue risk.',
    `language_code` STRING COMMENT 'ISO 639-1 language code (optionally with ISO 3166-1 alpha-2 region suffix) indicating the language in which the communication was rendered and delivered to the fan. Supports multilingual global fan engagement.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `loyalty_tier` STRING COMMENT 'The fans loyalty membership tier at the time this communication was sent (e.g., Bronze, Silver, Gold, Platinum, VIP). Captured as a point-in-time snapshot to support loyalty-segmented communication performance analysis.',
    `nps_survey_flag` BOOLEAN COMMENT 'Indicates whether this communication included or was a Net Promoter Score (NPS) survey request. True = NPS survey was embedded or linked in this message. Supports fan satisfaction tracking and NPS programme management.',
    `open_timestamp` TIMESTAMP COMMENT 'The date and time (UTC) at which the fan first opened or viewed the communication. Applicable to email (pixel tracking) and in-app messages. Null if the communication was not opened.',
    `opt_out_flag` BOOLEAN COMMENT 'Indicates whether the fan unsubscribed or opted out of future communications as a result of receiving this specific message. True = opt-out action was triggered by this communication. Critical for GDPR suppression compliance and CAN-SPAM adherence.',
    `opt_out_timestamp` TIMESTAMP COMMENT 'The date and time (UTC) at which the fan submitted an opt-out or unsubscribe request linked to this communication. Null if no opt-out was recorded. Required for GDPR and CCPA suppression audit trails.',
    `personalization_flag` BOOLEAN COMMENT 'Indicates whether this communication was dynamically personalized using fan profile data (e.g., name, favourite team, loyalty tier, purchase history). True = personalized content was applied; False = generic broadcast content.',
    `priority_level` STRING COMMENT 'Business priority classification of this communication, used to determine send order and fatigue override eligibility. Critical messages (e.g., safety alerts, account security) may bypass fatigue caps.. Valid values are `critical|high|standard|low`',
    `scheduled_send_timestamp` TIMESTAMP COMMENT 'The date and time (UTC) at which the communication was originally scheduled to be sent. May differ from send_timestamp if the send was delayed or rescheduled. Used for send-time optimisation analysis.',
    `send_timestamp` TIMESTAMP COMMENT 'The date and time (UTC) at which the communication was dispatched from the sending platform to the delivery provider (ESP, SMS gateway, push service). This is the principal business event timestamp for this transaction.',
    `source_record_reference` STRING COMMENT 'The native record identifier from the originating source system (Salesforce CRM activity ID or Adobe Experience Platform event ID). Enables lineage tracing and reconciliation between the Silver Layer and the operational system.',
    `source_system` STRING COMMENT 'The operational system of record that originated and executed this communication. Salesforce CRM for CRM-driven campaigns; Adobe AEP (Adobe Experience Platform) for journey-based and real-time triggered messages; Manual for operator-initiated sends.. Valid values are `salesforce_crm|adobe_aep|manual`',
    `subject_line` STRING COMMENT 'The subject line or headline of the communication as delivered to the fan. Applicable primarily to email and push notifications. Used for A/B test analysis and engagement reporting.',
    `suppression_flag` BOOLEAN COMMENT 'Indicates whether this communication was suppressed before send due to an active suppression rule (e.g., GDPR opt-out, communication fatigue cap, DNC list, or regulatory restriction). True = suppressed and not delivered.',
    `suppression_reason` STRING COMMENT 'The reason this communication was suppressed and not sent to the fan. Used for compliance audit and communication fatigue management reporting. Populated only when suppression_flag is True.. Valid values are `gdpr_optout|ccpa_optout|fatigue_cap|dnc_list|hard_bounce|regulatory`',
    `trigger_type` STRING COMMENT 'Indicates how this communication was initiated — whether by a scheduled campaign, an automated journey step, a real-time event trigger (e.g., ticket purchase, game day), an API call, or a manual send by a CRM operator.. Valid values are `campaign|journey|event_trigger|api|manual`',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time (UTC) at which this communication record was last modified in the Silver Layer data product, typically reflecting a delivery status update, open event, or click event ingested from the source system.',
    CONSTRAINT pk_communication PRIMARY KEY(`communication_id`)
) COMMENT 'Record of every outbound communication sent to a fan across all channels (email, SMS, push notification, direct mail, in-app message). Captures communication type, campaign or trigger name, channel, send timestamp, delivery status, open timestamp, click timestamp, opt-out flag, and associated segment or journey. Sourced from Salesforce CRM and Adobe Experience Platform campaign execution logs. Enables communication fatigue management and GDPR suppression compliance.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`fan`.`service_case` (
    `service_case_id` BIGINT COMMENT 'Primary key for service_case',
    `ada_accommodation_id` BIGINT COMMENT 'Foreign key linking to compliance.ada_accommodation. Business justification: Fan service cases opened for accessibility complaints or ADA accommodation denials must reference the compliance ADA accommodation record. ADA complaint management requires linking the fan-facing CRM ',
    `assigned_agent_employee_id` BIGINT COMMENT 'Reference to the CRM agent or support staff member currently assigned to own and resolve this service case. Used for workload balancing, performance reporting, and escalation routing.',
    `concession_stand_id` BIGINT COMMENT 'Foreign key linking to venue.concession_stand. Business justification: Fan services operations route food quality complaints, wait-time issues, and health incidents to the responsible concession operator. A direct FK enables stand-level case routing, operator accountabil',
    `asset_id` BIGINT COMMENT 'Foreign key linking to content.asset. Business justification: Content access dispute resolution: fan service cases in OTT sports platforms frequently involve specific content assets (playback failures, PPV access issues, rights blackouts). Linking service_case t',
    `digital_touchpoint_id` BIGINT COMMENT 'Foreign key linking to platform.digital_touchpoint. Business justification: Digital channel support volume reporting and SLA tracking by touchpoint require attributing service cases to their originating digital touchpoint. A fan experience operations manager in sports-enterta',
    `employee_id` BIGINT COMMENT 'Reference to the CRM agent or support staff member currently assigned to own and resolve this service case. Used for workload balancing, performance reporting, and escalation routing.',
    `event_fixture_id` BIGINT COMMENT 'Reference to the sports or entertainment event associated with this service case, if applicable (e.g., a ticketing dispute or lost-and-found case linked to a specific game or concert). Null for cases not tied to a specific event.',
    `fan_fan_profile_id` BIGINT COMMENT 'Reference to the fan account associated with this service case. Links the case to the fans identity, demographic, and CRM profile in the fan domain.',
    `fan_profile_id` BIGINT COMMENT 'Reference to the fan account associated with this service case. Links the case to the fans identity, demographic, and CRM profile in the fan domain.',
    `fixture_id` BIGINT COMMENT 'Reference to the sports or entertainment event associated with this service case, if applicable (e.g., a ticketing dispute or lost-and-found case linked to a specific game or concert). Null for cases not tied to a specific event.',
    `franchise_id` BIGINT COMMENT 'Foreign key linking to league.franchise. Business justification: Franchise-level fan service reporting, SLA compliance tracking per team, and escalation routing to franchise operations teams require a direct franchise FK on service cases. Sports-entertainment fan s',
    `incident_report_id` BIGINT COMMENT 'Foreign key linking to compliance.incident_report. Business justification: Fan service cases involving data breaches, ADA violations, or regulatory complaints escalate to compliance incident reports. The escalation workflow from CRM case to compliance incident tracking is a ',
    `insurance_claim_id` BIGINT COMMENT 'Foreign key linking to legal.insurance_claim. Business justification: Fan service cases involving venue injuries, property damage, or incidents generate insurance claims. Legal and risk management teams must trace insurance claims back to originating fan service cases f',
    `litigation_case_id` BIGINT COMMENT 'Foreign key linking to legal.litigation_case. Business justification: Fan service cases involving injuries, discrimination, or fraud can escalate to formal litigation. Legal ops teams routinely trace litigation back to originating fan service cases for case management, ',
    `matter_id` BIGINT COMMENT 'Foreign key linking to legal.legal_matter. Business justification: Fan complaints (ADA accommodation disputes, data privacy complaints, refund disputes) are tracked as legal matters before formal litigation. Legal matter management requires linking to the originating',
    `membership_id` BIGINT COMMENT 'Reference to the fans membership or season ticket holder account associated with this service case, particularly for membership billing disputes, tier changes, or loyalty program issues.',
    `merch_order_id` BIGINT COMMENT 'Foreign key linking to merchandise.merch_order. Business justification: Customer service cases about merchandise issues (wrong item, non-delivery, quality complaint) must reference the originating merch_order. Agents need this link to pull order details, initiate refunds,',
    `ppv_transaction_id` BIGINT COMMENT 'Foreign key linking to broadcast.ppv_transaction. Business justification: Service cases for PPV access failures, billing disputes, and refund requests must reference the specific PPV transaction. Enables CRM agents to pull purchase details, access tokens, and payment status',
    `related_case_service_case_id` BIGINT COMMENT 'Reference to a parent or related service case when this case is part of a case hierarchy (e.g., a sub-case spawned from an escalation, or a duplicate linked to a master case). Null for standalone cases.',
    `return_request_id` BIGINT COMMENT 'Foreign key linking to merchandise.return_request. Business justification: Customer service cases escalated from merchandise return disputes (e.g., refund denied, return window exception) must reference the originating return_request. Agents need this link to review return s',
    `seat_id` BIGINT COMMENT 'Foreign key linking to venue.seat. Business justification: Fan service cases for broken seats, obstructed-view disputes, and ADA accommodation requests must reference the specific seat. Venue operations and ADA compliance teams use this link to track seat-lev',
    `security_incident_id` BIGINT COMMENT 'Foreign key linking to security.security_incident. Business justification: CRM service cases opened for fan injury claims, property damage, or wrongful ejection appeals require direct reference to the triggering security incident for case resolution, insurance claim filing, ',
    `settlement_agreement_id` BIGINT COMMENT 'Foreign key linking to legal.settlement_agreement. Business justification: Fan service cases resolved through formal settlement agreements require linking to track resolution type, payment obligations, and compliance monitoring. Fan operations teams need to close service cas',
    `streaming_subscription_id` BIGINT COMMENT 'Foreign key linking to broadcast.streaming_subscription. Business justification: CRM service cases for streaming access issues, billing disputes, and cancellation requests require direct reference to the subscription record. CRM agents need subscription status, plan tier, and bill',
    `ticket_order_id` BIGINT COMMENT 'Reference to the ticket order or transaction associated with this service case, particularly for ticketing disputes, refund requests, or access control issues. Sourced from Ticketmaster / AXS order records.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to partner.vendor. Business justification: Fan service cases frequently involve vendor-delivered services (concession complaints, parking issues, merchandise defects, security incidents). Linking service_case to vendor enables vendor accountab',
    `venue_id` BIGINT COMMENT 'Reference to the venue associated with this service case, if applicable (e.g., in-venue accessibility accommodation, lost-and-found, or facility complaint). Null for cases not tied to a specific venue.',
    `wager_id` BIGINT COMMENT 'Foreign key linking to gaming.wager. Business justification: Wager dispute resolution: customer service cases for disputed wager settlements, incorrect payouts, or voided bets require direct reference to the specific wager for case investigation, refund process',
    `accessibility_accommodation_type` STRING COMMENT 'Specific type of accessibility accommodation requested or arranged for the fan (e.g., wheelchair seating, hearing loop, visual impairment assistance, companion seating). Populated for cases of type accessibility_accommodation. Supports ADA compliance reporting.',
    `assigned_team` STRING COMMENT 'Name of the support team or queue to which the case is currently assigned (e.g., Ticketing Support, VIP Concierge, Membership Services, Accessibility Team). Supports team-level workload and performance reporting.',
    `case_category` STRING COMMENT 'Secondary classification grouping cases into operational categories for routing and reporting. Complements case_type with a broader operational lens. Corresponds to the Reason field on the Salesforce CRM Case object. [ENUM-REF-CANDIDATE: billing|access_control|fan_experience|safety_security|content_access|merchandise|general — 7 candidates stripped; promote to reference product]',
    `case_description` STRING COMMENT 'Full narrative description of the fans issue, request, or complaint as submitted. Captures the complete context of the case including relevant event details, ticket information, or membership concerns. Corresponds to the Description field on the Salesforce CRM Case object.',
    `case_number` STRING COMMENT 'Externally visible, human-readable case reference number assigned by Salesforce CRM at case creation (e.g., CAS-00012345). Used in all fan-facing communications and agent workflows as the primary business identifier for the case.. Valid values are `^CAS-[0-9]{8}$`',
    `case_reopen_count` STRING COMMENT 'Number of times this service case has been reopened after a prior resolution or closure. A high reopen count indicates unresolved fan issues and is a key quality metric for support operations.',
    `case_status` STRING COMMENT 'Current lifecycle state of the service case within the support workflow. Drives SLA tracking, agent workload management, and fan communication triggers. Corresponds to the Status field on the Salesforce CRM Case object. [ENUM-REF-CANDIDATE: new|open|pending_fan|pending_internal|escalated|resolved|closed — 7 candidates stripped; promote to reference product]',
    `case_sub_category` STRING COMMENT 'Granular sub-classification within the case_category, providing detailed routing and root-cause analysis capability (e.g., within billing: duplicate_charge, incorrect_tier, failed_payment). Corresponds to a custom sub-reason field in Salesforce CRM.',
    `case_subject` STRING COMMENT 'Short, one-line summary of the fans issue or request as entered by the fan or agent. Corresponds to the Subject field on the Salesforce CRM Case object. Used in case list views, dashboards, and agent queues.',
    `case_type` STRING COMMENT 'High-level classification of the service case category. Drives routing rules, SLA targets, and reporting segmentation. [ENUM-REF-CANDIDATE: ticketing_dispute|membership_billing|lost_and_found|accessibility_accommodation|complaint_escalation|vip_concierge|general_inquiry|refund_request|merchandise_issue|broadcast_access — promote to reference product]',
    `ccpa_opt_out_flag` BOOLEAN COMMENT 'Indicates whether the fan has exercised their CCPA right to opt out of the sale of personal information in the context of this case interaction. Supports CCPA compliance and consent management workflows.',
    `close_date` TIMESTAMP COMMENT 'Date and timestamp when the service case was formally closed after resolution confirmation or fan acknowledgement. Distinct from resolution_date — a case may be resolved but remain open pending fan confirmation before closure.',
    `crm_case_source_reference` STRING COMMENT 'The native Salesforce CRM Case record ID (18-character Salesforce ID) from the source system. Enables traceability and reconciliation between the Silver Layer lakehouse record and the originating Salesforce CRM Case object.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the refund_amount (e.g., USD, GBP, EUR). Supports multi-currency operations across global markets.. Valid values are `^[A-Z]{3}$`',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether this service case has been formally escalated to a senior agent, supervisor, or management tier. True when the case has been escalated at any point in its lifecycle. Corresponds to the IsEscalated field on the Salesforce CRM Case object.',
    `escalation_reason` STRING COMMENT 'Narrative or coded reason explaining why the case was escalated (e.g., unresolved after SLA breach, fan dissatisfaction, legal threat, media risk, VIP status). Populated when escalation_flag is True.',
    `escalation_timestamp` TIMESTAMP COMMENT 'Date and time when the case was first escalated. Used to measure escalation response time and track escalation lifecycle duration.',
    `fan_sentiment` STRING COMMENT 'Agent-assessed or AI-derived sentiment classification of the fans tone and emotional state during the case interaction. Used for NPS (Net Promoter Score) correlation analysis and fan experience improvement programs.. Valid values are `very_negative|negative|neutral|positive|very_positive`',
    `first_response_timestamp` TIMESTAMP COMMENT 'Date and time when the assigned agent first responded to the fan on this case. Used to measure first-response SLA compliance and agent responsiveness KPIs.',
    `gdpr_data_request_flag` BOOLEAN COMMENT 'Indicates whether this service case involves a GDPR data subject request (e.g., right to access, right to erasure, data portability). True when the case is classified as a GDPR-related request. Supports GDPR compliance reporting and regulatory response tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and timestamp when the service case record was last updated in the source Salesforce CRM system. Used for incremental data ingestion, audit trails, and change detection in the Silver Layer pipeline.',
    `nps_score` STRING COMMENT 'Fan-provided NPS rating (0–10) submitted via post-case satisfaction survey. Null if the survey was not sent or not completed. Used to measure case resolution quality and overall fan experience.',
    `nps_survey_sent_flag` BOOLEAN COMMENT 'Indicates whether a post-case NPS satisfaction survey was sent to the fan upon case closure. True when the survey has been dispatched. Supports NPS tracking and fan experience measurement programs.',
    `open_date` TIMESTAMP COMMENT 'The date and timestamp when the service case was first created and entered into the CRM system. Serves as the principal business event timestamp for SLA measurement and case aging calculations. Corresponds to CreatedDate on the Salesforce CRM Case object.',
    `origin_channel` STRING COMMENT 'The channel through which the fan initiated the service case. Used for channel mix analysis, staffing optimization, and omnichannel CRM reporting. Corresponds to the Origin field on the Salesforce CRM Case object. [ENUM-REF-CANDIDATE: phone|email|chat|social|in_venue|web_form|mobile_app — 7 candidates stripped; promote to reference product]',
    `priority` STRING COMMENT 'Business priority level assigned to the service case, determining SLA response and resolution time targets. Critical priority is reserved for VIP concierge, safety-related, or high-profile escalations. Corresponds to the Priority field on the Salesforce CRM Case object.. Valid values are `low|medium|high|critical`',
    `refund_amount` DECIMAL(18,2) COMMENT 'Monetary value of any refund issued to the fan as part of the case resolution. Expressed in the local operating currency. Null if no refund was issued. Used for financial reconciliation and fan compensation reporting.',
    `resolution_date` TIMESTAMP COMMENT 'Date and timestamp when the service case was marked as resolved by the assigned agent or automated workflow. Used for resolution SLA compliance measurement and case duration analytics.',
    `resolution_notes` STRING COMMENT 'Free-text notes entered by the agent documenting the resolution action taken, outcome, and any compensatory measures offered (e.g., ticket replacement, refund issued, VIP upgrade). Corresponds to the Resolution field on the Salesforce CRM Case object.',
    `resolution_type` STRING COMMENT 'Standardized classification of the resolution action taken to close the case. Used for resolution outcome analytics, cost-of-service reporting, and fan compensation tracking. [ENUM-REF-CANDIDATE: refund_issued|ticket_replaced|upgrade_offered|apology_sent|information_provided|no_action_required|escalated_to_management|voucher_issued|policy_exception — promote to reference product]',
    `season_ticket_holder_flag` BOOLEAN COMMENT 'Indicates whether the fan is a season ticket holder at the time the case was opened. Season ticket holders may receive priority handling and dedicated support queues.',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether the case exceeded its SLA target resolution time. True when the case was not resolved within the sla_target_hours window. Used for SLA compliance dashboards and agent performance reviews.',
    `sla_target_hours` DECIMAL(18,2) COMMENT 'The contracted or policy-defined target number of hours within which this case must be resolved, based on case type and priority. Drives SLA compliance reporting and breach alerting.',
    `vip_flag` BOOLEAN COMMENT 'Indicates whether the fan associated with this case holds VIP (Very Important Person) status, triggering elevated service protocols, dedicated concierge routing, and expedited SLA targets.',
    CONSTRAINT pk_service_case PRIMARY KEY(`service_case_id`)
) COMMENT 'CRM service case record for fan support interactions — ticketing disputes, membership billing issues, lost-and-found, accessibility accommodation requests, complaint escalations, and VIP concierge requests. Captures case type, case subject, description, priority, status, open date, resolution date, resolution notes, assigned agent, channel of origin (phone, email, chat, social, in-venue), and associated fan account. Sourced from Salesforce CRM Case object.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`fan`.`payment_method` (
    `payment_method_id` BIGINT COMMENT 'Primary key for payment_method',
    `account_id` BIGINT COMMENT 'Foreign key linking to fan.account. Business justification: Payment methods are stored on operational accounts, not just fan profiles. The account table contains payment-related context (pci_payment_token, card_brand, card_last_four, card_expiry_date, default_',
    `fan_profile_id` BIGINT COMMENT 'Reference to the fan account that owns this payment instrument. Links the payment method to the fan identity and CRM profile for one-click purchases, membership auto-renewals, and merchandise checkout.',
    `auto_renewal_enabled` BOOLEAN COMMENT 'Indicates whether this payment instrument is authorized by the fan for automatic recurring charges such as season ticket renewals, membership subscriptions, and OTT streaming plan renewals. Requires explicit fan consent per GDPR and CCPA mandates.',
    `avs_response_code` STRING COMMENT 'Response code returned by the card issuers Address Verification Service (AVS) during the enrollment authorization. Indicates the degree of match between the billing address provided by the fan and the address on file with the issuer. Used in fraud scoring and risk decisioning.',
    `bank_account_last_four` STRING COMMENT 'Last four digits of the bank account number for direct debit payment methods. Displayed to the fan for identification purposes. Applicable only when payment_method_type is direct_debit. Null for card-based instruments.. Valid values are `^[0-9]{4}$`',
    `bank_routing_code` STRING COMMENT 'Bank routing number (US ACH) or sort code (UK/EU) associated with a direct debit payment method. Used for ACH or SEPA payment processing. Stored in truncated or tokenized form. Null for non-direct-debit instruments.',
    `billing_address_line1` STRING COMMENT 'Primary street address line of the billing address associated with this payment instrument. Used for Address Verification Service (AVS) checks during card-not-present transactions on ticketing and merchandise platforms.',
    `billing_address_line2` STRING COMMENT 'Secondary street address line (apartment, suite, unit number) of the billing address. Optional supplementary address detail for Address Verification Service (AVS) processing.',
    `billing_city` STRING COMMENT 'City component of the billing address associated with this payment instrument. Used for AVS verification, fraud scoring, and geographic revenue reporting.',
    `billing_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the billing address (e.g., USA, GBR, DEU). Determines applicable privacy regulation (GDPR for EU/EEA, CCPA for California), currency routing, and cross-border payment processing rules.. Valid values are `^[A-Z]{3}$`',
    `billing_postal_code` STRING COMMENT 'Postal or ZIP code of the billing address. Critical input for Address Verification Service (AVS) checks on card-not-present transactions. Also used for geographic segmentation and tax jurisdiction mapping.',
    `billing_state_province` STRING COMMENT 'State or province component of the billing address. Used for AVS verification, tax jurisdiction determination, and CCPA/GDPR applicability assessment for fan data privacy compliance.',
    `bin_number` STRING COMMENT 'First 6–8 digits of the payment card number identifying the issuing institution and card product type. Used for routing decisions, interchange category determination, and fraud analysis. Stored as a non-sensitive BIN (not the full PAN) per PCI-DSS truncation rules.. Valid values are `^[0-9]{6,8}$`',
    `card_brand` STRING COMMENT 'Payment network or card scheme brand associated with the instrument (e.g., Visa, Mastercard, Amex). Applicable for credit and debit card types. Null for non-card payment methods such as digital wallets or direct debit. Used for interchange fee analysis and brand-level reporting.. Valid values are `Visa|Mastercard|Amex|Discover|UnionPay|Other`',
    `card_funding_type` STRING COMMENT 'Funding classification of the payment card as determined from BIN lookup. Distinguishes credit, debit, prepaid, and charge cards. Impacts interchange fee rates, refund processing timelines, and eligibility for certain promotional financing offers on season tickets.. Valid values are `credit|debit|prepaid|charge|unknown`',
    `card_last_four` STRING COMMENT 'Last four digits of the payment card Primary Account Number (PAN). Displayed to the fan in account management and checkout screens to identify their saved card without exposing the full PAN. Permitted display element under PCI-DSS truncation rules.. Valid values are `^[0-9]{4}$`',
    `cardholder_name` STRING COMMENT 'Name of the individual as it appears on the payment card or as registered with the payment instrument. Used for display in account management screens and for AVS/identity verification during high-value transactions. Stored only where operationally required per PCI-DSS data minimization principles.',
    `consent_capture_timestamp` TIMESTAMP COMMENT 'Date and time when the fan explicitly consented to storing this payment instrument and authorizing recurring charges. Recorded in ISO 8601 format with timezone offset. Required for GDPR Article 6 lawful basis documentation and CCPA compliance audit trails.',
    `consent_version` STRING COMMENT 'Version identifier of the terms and conditions or privacy policy under which the fan consented to storing this payment instrument. Enables compliance teams to identify fans who consented under outdated policy versions requiring re-consent.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code associated with the payment instrument (e.g., USD, GBP, EUR). Supports multi-currency fan accounts across global markets. Relevant for gift card balances, direct debit mandates, and cross-border transaction routing.. Valid values are `^[A-Z]{3}$`',
    `direct_debit_mandate_ref` STRING COMMENT 'Unique mandate reference number assigned for SEPA Direct Debit or ACH authorization agreements. Required for recurring direct debit collections such as installment-based season ticket payment plans. Null for non-direct-debit instruments.',
    `enrollment_channel` STRING COMMENT 'Channel through which the fan added this payment instrument to their account. Supports fraud analysis, channel attribution, and UX optimization. pos — Point of Sale terminal at venue; partner_api — enrolled via third-party integration (e.g., Ticketmaster, Shopify Plus).. Valid values are `web|mobile_app|pos|call_center|kiosk|partner_api`',
    `enrollment_timestamp` TIMESTAMP COMMENT 'Date and time when the payment instrument was first added to the fan account. Used for lifecycle management, fraud velocity checks, and compliance audit trails. Recorded in ISO 8601 format with timezone offset.',
    `expiry_month` STRING COMMENT 'Two-digit calendar month (1–12) in which the payment card expires. Used in conjunction with expiry_year to determine card validity and trigger pre-expiry notification workflows for membership auto-renewal continuity.',
    `expiry_notification_sent` BOOLEAN COMMENT 'Indicates whether a pre-expiry notification has been dispatched to the fan via their preferred communication channel (email, SMS, push) to prompt card update before membership or season ticket auto-renewal fails. Managed by Adobe Experience Platform journey automation.',
    `expiry_year` STRING COMMENT 'Four-digit calendar year in which the payment card expires. Combined with expiry_month to assess card validity. Triggers automated pre-expiry fan communications to update payment details and prevent lapsed season ticket or membership renewals.',
    `fraud_risk_score` DECIMAL(18,2) COMMENT 'Numeric risk score (0.00–100.00) assigned to this payment instrument by the fraud detection engine at enrollment or last transaction. Higher scores indicate elevated fraud risk. Used to trigger step-up authentication, manual review, or instrument suspension. Not a calculated KPI — raw score from fraud provider.',
    `gift_card_balance` DECIMAL(18,2) COMMENT 'Current monetary balance remaining on a stored-value gift card payment instrument. Applicable only when payment_method_type is gift_card. Updated after each redemption transaction. Null for non-gift-card instruments. Denominated in the currency indicated by currency_code.',
    `is_default` BOOLEAN COMMENT 'Indicates whether this payment instrument is the fans designated default method for one-click purchases, membership auto-renewals, and express checkout. Only one payment method per fan account should have this flag set to True at any time.',
    `issuer_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the financial institution that issued the payment card. Derived from the card BIN (Bank Identification Number). Used for cross-border transaction fee assessment, currency mismatch detection, and regulatory reporting.. Valid values are `^[A-Z]{3}$`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this payment method record was most recently modified (e.g., billing address update, status change, token refresh). Supports audit trail requirements and Silver Layer data lineage tracking in the Databricks Lakehouse.',
    `last_used_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent successful transaction processed against this payment instrument. Used to identify dormant payment methods for cleanup workflows and to assess instrument activity for fraud monitoring.',
    `method_status` STRING COMMENT 'Current lifecycle status of the payment instrument. active — valid and available for transactions; expired — card expiry date has passed; suspended — temporarily blocked due to fraud or dispute; removed — fan has deleted the instrument; pending_verification — awaiting micro-deposit or 3DS verification.. Valid values are `active|expired|suspended|removed|pending_verification`',
    `network_transaction_reference` STRING COMMENT 'Unique identifier assigned by the card network (Visa, Mastercard) during the initial card-on-file enrollment authorization. Required for subsequent MIT (Merchant-Initiated Transaction) recurring charges such as season ticket auto-renewals, ensuring compliance with card network stored credential mandates.',
    `payment_method_type` STRING COMMENT 'Classification of the payment instrument category. Drives checkout flow logic, fee structures, and refund eligibility across ticketing (Ticketmaster/AXS), merchandise (Shopify Plus), and membership auto-renewal workflows.. Valid values are `credit_card|debit_card|digital_wallet|direct_debit|gift_card|prepaid_card`',
    `pci_compliance_status` STRING COMMENT 'Indicates the PCI-DSS compliance posture of this payment instrument record. compliant — token and data handling meet PCI-DSS v4.0 requirements; non_compliant — a compliance gap has been identified requiring remediation; pending_review — under compliance assessment. Supports PCI SSC audit reporting.. Valid values are `compliant|non_compliant|pending_review`',
    `source_system_token_ref` STRING COMMENT 'External reference identifier for this payment token as recorded in the originating operational system (e.g., Ticketmaster/AXS vault ID, Shopify Plus payment method ID, Salesforce CRM payment record ID). Enables cross-system reconciliation and lineage tracing in the Silver Layer.',
    `token_value` DECIMAL(18,2) COMMENT 'Opaque tokenized representation of the underlying payment instrument issued by the tokenization provider (e.g., Braintree, Stripe, Adyen). Replaces the raw PAN in all downstream systems. Never stores the actual card number. Compliant with PCI-DSS tokenization standards.',
    `tokenization_provider` STRING COMMENT 'Name of the third-party PCI-DSS compliant tokenization service provider that issued and manages the payment token. Used for routing, reconciliation, and vendor management. [ENUM-REF-CANDIDATE: Braintree|Adyen|Stripe|CyberSource|Worldpay|Checkout.com|Spreedly — promote to reference product if provider list grows beyond 6]. Valid values are `Braintree|Adyen|Stripe|CyberSource|Worldpay|Other`',
    `verification_method` STRING COMMENT 'Method used to verify the payment instrument at enrollment. 3ds — 3-D Secure authentication (Visa Secure / Mastercard Identity Check); avs — Address Verification Service; micro_deposit — two small deposits for bank account verification; cvv_check — card security code validation; none — no additional verification performed.. Valid values are `3ds|avs|micro_deposit|none|cvv_check`',
    `verification_status` STRING COMMENT 'Outcome of the payment instrument verification process. verified — successfully authenticated; unverified — verification not yet completed; failed — verification attempt was unsuccessful; pending — verification in progress. Determines eligibility for high-value transactions such as season ticket purchases.. Valid values are `verified|unverified|failed|pending`',
    `wallet_provider` STRING COMMENT 'Name of the digital wallet service when payment_method_type is digital_wallet. Identifies the wallet ecosystem for routing, reconciliation, and fan experience analytics. Null for non-wallet payment types.. Valid values are `Apple Pay|Google Pay|PayPal|Samsung Pay|Venmo|Other`',
    CONSTRAINT pk_payment_method PRIMARY KEY(`payment_method_id`)
) COMMENT 'Tokenized payment instrument records stored on file for a fan account. Captures payment method type (credit card, debit card, digital wallet, direct debit, gift card), card brand, last four digits, expiry month/year, billing address reference, tokenization provider, token value, default payment flag, and PCI-DSS compliance status. Enables one-click ticket purchases, auto-renewal of memberships, and merchandise checkout. Compliant with PCI-DSS tokenization standards.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`fan`.`club` (
    `club_id` BIGINT COMMENT 'Unique surrogate identifier for the fan club record. Primary key for the fan_club data product in the fan domain.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Official fan clubs in sports entertainment are administered by a designated workforce employee (e.g., fan engagement coordinator). HR and fan engagement teams need this link for staff accountability, ',
    `affiliated_athlete_athlete_profile_id` BIGINT COMMENT 'Reference to the individual athlete this fan club is dedicated to, where the club is athlete-specific rather than team-specific (e.g., a player fan club). Nullable for team-based clubs.',
    `team_id` BIGINT COMMENT 'Reference to the team or franchise this fan club is primarily associated with. Enables fan club segmentation by team for engagement programs and event access privileges.',
    `athlete_profile_id` BIGINT COMMENT 'Reference to the individual athlete this fan club is dedicated to, where the club is athlete-specific rather than team-specific (e.g., a player fan club). Nullable for team-based clubs.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Official fan clubs with operating budgets (event allocations, merchandise discounts, administrative costs) are tracked against a dedicated cost center. Finance uses this link for fan club P&L reportin',
    `deal_id` BIGINT COMMENT 'Foreign key linking to sponsorship.deal. Business justification: Fan club sponsorships are governed by specific deals (e.g., Official Fan Club Sponsor deal). fan_club already has sponsor_id but not deal_id. Linking to the specific deal enables contractual obligat',
    `franchise_id` BIGINT COMMENT 'Reference to the team or franchise this fan club is primarily associated with. Enables fan club segmentation by team for engagement programs and event access privileges.',
    `governance_document_id` BIGINT COMMENT 'Foreign key linking to legal.governance_document. Business justification: Official fan clubs operate under governance documents (charters, affiliation agreements, bylaws) maintained by legal. Linking fan club records to their governing document enables legal review cycles, ',
    `venue_id` BIGINT COMMENT 'Foreign key linking to venue.venue. Business justification: Official fan clubs are affiliated with a specific home venue for event ticket allocation, supporter section management, and venue partnership agreements. Role-prefix home_ matches the business conce',
    `league_id` BIGINT COMMENT 'Reference to the league or competition governing body that the affiliated team participates in. Used for league-level fan club reporting and compliance with league fan engagement policies.',
    `parent_club_id` BIGINT COMMENT 'Self-referencing identifier for the parent fan club when this record represents a regional chapter or sub-chapter of a larger national or international fan club organization. Null for top-level clubs.',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: Official fan clubs generate membership dues revenue tracked as a distinct revenue stream. Finance needs this link to report fan club revenue contribution, budget annual dues income, and support interc',
    `sponsor_id` BIGINT COMMENT 'Reference to the primary commercial sponsor or brand partner associated with the fan club, enabling co-branded engagement programs and sponsorship ROI (Return on Investment) tracking.',
    `sponsorship_partner_sponsor_id` BIGINT COMMENT 'Reference to the primary commercial sponsor or brand partner associated with the fan club, enabling co-branded engagement programs and sponsorship ROI (Return on Investment) tracking.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to partner.vendor. Business justification: Official fan clubs in sports entertainment have designated merchandise and service vendors (kit suppliers, event caterers, print vendors). Linking fan_club to vendor enables official vendor relationsh',
    `annual_revenue_usd` DECIMAL(18,2) COMMENT 'Total annual revenue generated by the fan club from membership dues, merchandise sales, and events in USD. Used for financial planning, EBITDA contribution analysis, and sponsorship valuation. Sourced from SAP S/4HANA FI/CO.',
    `ccpa_applicable` BOOLEAN COMMENT 'Indicates whether the fan clubs member data processing is subject to CCPA requirements, based on California residency of members or club operations.',
    `charter_document_ref` STRING COMMENT 'Reference identifier or URL to the fan clubs official charter, constitution, or founding document stored in the Digital Asset Management (DAM) system. Used for governance and compliance audits.',
    `city` STRING COMMENT 'City where the fan club is headquartered or primarily based. Used for geographic segmentation, event planning, and chapter assignment.',
    `club_code` STRING COMMENT 'Externally-known alphanumeric business identifier for the fan club, used in CRM systems, ticketing platforms, and member communications (e.g., MAN-UTD-OSC-NYC). Sourced from Salesforce CRM.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `club_name` STRING COMMENT 'Official full name of the fan club as registered with the league or governing body (e.g., Manchester United Official Supporters Club – New York Chapter).',
    `club_status` STRING COMMENT 'Current lifecycle status of the fan club. active = fully operational; inactive = dormant but not dissolved; suspended = temporarily restricted by governing body; pending_approval = awaiting official recognition; dissolved = permanently closed.. Valid values are `active|inactive|suspended|pending_approval|dissolved`',
    `club_type` STRING COMMENT 'Classification of the fan club by its organizational structure and affiliation level. official = league/team-sanctioned club; supporters_trust = member-owned democratic body; regional_chapter = geographic sub-chapter of a parent club; booster_club = fundraising-oriented; fan_society = informal affinity group.. Valid values are `official|supporters_trust|regional_chapter|booster_club|fan_society`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code representing the primary country of operation for the fan club (e.g., USA, GBR, BRA). Used for regulatory compliance, GDPR/CCPA applicability, and international fan engagement reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the fan club record was first created in the system, in ISO 8601 format with timezone offset (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for audit trail, data lineage, and compliance reporting.',
    `crm_account_reference` STRING COMMENT 'External identifier for the fan club record in Salesforce CRM, enabling bi-directional synchronization between the lakehouse silver layer and the CRM system of record for fan and sponsor relationship management.',
    `current_member_count` STRING COMMENT 'Current total number of active enrolled members in the fan club as of the last refresh. Used for capacity monitoring, reporting, and engagement benchmarking. Not a calculated aggregate — sourced directly from the CRM enrollment system.',
    `dissolution_date` DATE COMMENT 'The date on which the fan club was officially dissolved or deregistered. Null for active clubs. Used for lifecycle reporting and historical record retention.',
    `event_ticket_allocation` STRING COMMENT 'Number of event tickets allocated to the fan club per event or season by the team or venue, enabling priority access for members. Managed in coordination with Ticketmaster/AXS and Archtics inventory systems.',
    `founding_date` DATE COMMENT 'The official date on which the fan club was formally established or chartered. Used for anniversary recognition, eligibility calculations, and historical reporting.',
    `gdpr_applicable` BOOLEAN COMMENT 'Indicates whether the fan clubs member data processing is subject to GDPR requirements, based on the clubs country of operation or member residency in the European Union.',
    `geographic_territory` STRING COMMENT 'The defined geographic territory or region in which the fan club operates and recruits members (e.g., Northeast USA, Greater London, Southeast Asia). Used for regional segmentation and chapter management.',
    `has_voting_rights` BOOLEAN COMMENT 'Indicates whether the fan club grants members voting rights on club governance matters (e.g., election of club officers, rule changes). True for supporters trusts and democratic fan organizations.',
    `is_official_partner` BOOLEAN COMMENT 'Indicates whether the fan club holds an official partnership or affiliation agreement with the team, league, or governing body, granting access to official branding, event allocations, and co-marketing programs.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the fan club record, in ISO 8601 format with timezone offset. Used for change tracking, incremental data loads, and audit compliance.',
    `max_membership_capacity` STRING COMMENT 'Maximum number of members the fan club is authorized or operationally designed to accommodate. Null indicates no cap. Used for waitlist management and capacity planning.',
    `membership_fee_amount` DECIMAL(18,2) COMMENT 'Standard annual membership fee charged to join the fan club, expressed in the clubs operating currency. Used for revenue tracking, dues management, and tier pricing analysis.',
    `membership_fee_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the membership fee (e.g., USD, GBP, EUR). Required for multi-currency fan club operations across global markets.. Valid values are `^[A-Z]{3}$`',
    `membership_fee_frequency` STRING COMMENT 'Billing frequency for the fan club membership fee. Determines renewal cycle and dues collection schedule.. Valid values are `annual|semi_annual|quarterly|monthly|one_time`',
    `membership_tier_structure` STRING COMMENT 'Describes whether the fan club operates a single uniform membership level or a multi-tier structure with differentiated benefits (e.g., standard, premium, VIP). Drives benefit entitlement logic and dues pricing.. Valid values are `single_tier|multi_tier|tiered_with_vip`',
    `merchandise_discount_pct` DECIMAL(18,2) COMMENT 'Standard percentage discount on official merchandise offered to fan club members as a membership benefit. Applied at point of sale via Shopify Plus or POS systems.',
    `nps_score` DECIMAL(18,2) COMMENT 'Most recent Net Promoter Score (NPS) for the fan club, derived from member satisfaction surveys. Ranges from -100 to 100. Used to measure fan club health, member loyalty, and engagement quality.',
    `nps_survey_date` DATE COMMENT 'Date on which the most recent NPS survey was conducted for the fan club. Used to assess recency of satisfaction data and schedule future surveys.',
    `preferred_language_code` STRING COMMENT 'IETF BCP 47 language tag representing the primary language used for fan club communications and content delivery (e.g., en-US, es-MX, pt-BR). Used for localization of member communications and digital content.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `primary_sport` STRING COMMENT 'The sport that the fan club is primarily associated with (e.g., Football, Basketball, Baseball, Soccer). Used for cross-sport segmentation and content targeting.',
    `recognition_date` DATE COMMENT 'The date on which the fan club received official recognition or accreditation from the league, team, or governing body. May differ from founding_date for clubs that operated informally before formal recognition.',
    `short_name` STRING COMMENT 'Abbreviated or display name of the fan club used in UI, printed materials, and broadcast graphics (e.g., MUSC New York).',
    `social_media_handle` STRING COMMENT 'Primary social media handle or username for the fan clubs official social media presence (e.g., @MUSC_NewYork). Used for digital engagement tracking and fan community management via Adobe Experience Platform.',
    `website_url` STRING COMMENT 'Official website URL for the fan club. Used for digital engagement, member self-service, and fan discovery across the sports entertainment platform.. Valid values are `^https?://[^s/$.?#].[^s]*$`',
    CONSTRAINT pk_club PRIMARY KEY(`club_id`)
) COMMENT 'Master record for official fan clubs and their membership enrollments. Captures fan club name, associated team or athlete, club type (official, supporters trust, regional chapter), founding date, membership fee structure, club status, geographic territory, and club administrator contact. Also tracks individual member enrollments: membership number, join date, renewal date, membership tier within the club, dues payment status, voting rights, and chapter assignment. Enables fan club community participation, event access privileges, and engagement programs.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`fan`.`club_membership` (
    `club_membership_id` BIGINT COMMENT 'Primary key for club_membership',
    `chapter_id` BIGINT COMMENT 'Reference to the geographic or organizational chapter of the fan club to which this member is assigned. Fan clubs may be organized into regional chapters (e.g., city, country, or venue-based) to facilitate local events and community activities.',
    `club_id` BIGINT COMMENT 'Reference to the specific fan club this membership belongs to. Identifies the community, team-affiliated club, or sport-specific fan organization the fan has joined.',
    `fan_profile_id` BIGINT COMMENT 'Reference to the fan profile record that holds this club membership. Links the membership to the fans identity, demographic, and CRM data in the fan_profile product.',
    `season_id` BIGINT COMMENT 'Foreign key linking to league.season. Business justification: Fan club memberships are annually renewed aligned to league seasons; season-level club membership reporting, dues collection cycles, and ticket allocation management require linking club memberships t',
    `primary_club_fan_profile_id` BIGINT COMMENT 'Reference to the fan profile record that holds this club membership. Links the membership to the fans identity, demographic, and CRM data in the fan_profile product.',
    `referred_by_fan_fan_profile_id` BIGINT COMMENT 'Fan profile ID of the existing member who referred this fan to the club. Enables member-get-member referral program tracking, referral reward attribution, and network-effect analytics.',
    `auto_renewal_enabled` BOOLEAN COMMENT 'Indicates whether the fan has opted into automatic renewal of their membership at the end of each term. When True, the dues payment is processed automatically via the stored payment method on the renewal date.',
    `card_delivery_status` STRING COMMENT 'Current fulfillment status of the physical membership card. Tracks the card from issuance through delivery to the fans registered address. returned indicates the card was undeliverable and returned to sender.. Valid values are `not_issued|pending|dispatched|delivered|returned`',
    `card_issued_date` DATE COMMENT 'Date on which the current membership card was issued or last reissued to the fan. Used to track card lifecycle, replacement requests, and access control validity.',
    `ccpa_applicable` BOOLEAN COMMENT 'Indicates whether this membership record is subject to CCPA (California Consumer Privacy Act) obligations. When True, the fan has the right to opt out of sale of personal information and request deletion.',
    `consent_capture_date` DATE COMMENT 'Date on which the fans data processing and marketing consent was most recently captured or updated for this membership record. Required for GDPR and CCPA compliance audit trails.',
    `consent_version` STRING COMMENT 'Version identifier of the privacy consent notice and terms accepted by the fan at the time of consent_capture_date. Enables compliance teams to identify members who need re-consent when terms are updated (e.g., v1.0, v2.3).. Valid values are `^v[0-9]+.[0-9]+$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fan club membership record was first created in the system. Serves as the audit creation marker for data lineage, SOX financial controls, and GDPR processing records.',
    `crm_record_reference` STRING COMMENT 'Identifier of the corresponding membership record in the Salesforce CRM (Customer Relationship Management) system. Enables bi-directional synchronization between the lakehouse silver layer and the operational CRM for fan engagement workflows.',
    `dues_amount` DECIMAL(18,2) COMMENT 'Monetary amount charged for the current membership term in the billing currency. Reflects the tier-specific dues schedule and any negotiated or promotional rate applied at enrollment or renewal.',
    `dues_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the dues_amount (e.g., USD, GBP, EUR). Supports multi-currency operations across global fan club markets.. Valid values are `^[A-Z]{3}$`',
    `dues_paid_date` DATE COMMENT 'Date on which the membership dues for the current term were confirmed as received and settled. Used for financial reconciliation, access activation, and audit trails.',
    `dues_payment_status` STRING COMMENT 'Current payment status of the membership dues for the active term. paid = dues received and confirmed; pending = payment initiated but not yet settled; overdue = payment not received by due date; waived = dues formally waived (e.g., honorary members); refunded = dues returned to the fan.. Valid values are `paid|pending|overdue|waived|refunded`',
    `effective_date` DATE COMMENT 'Date from which the current membership term is active and benefits are accessible. For renewals this differs from join_date; it marks the start of the current billing/benefit period.',
    `enrollment_channel` STRING COMMENT 'Channel through which the fan originally enrolled in the fan club. Used for acquisition attribution, channel ROI (Return on Investment) analysis, and optimizing fan acquisition spend across DTC (Direct-To-Consumer) and partner channels. [ENUM-REF-CANDIDATE: web|mobile_app|venue_kiosk|call_centre|retail|event|partner — promote to reference product if channels expand]',
    `expiry_date` DATE COMMENT 'Date on which the current membership term ends and benefits cease unless renewed. Drives renewal reminder campaigns, lapse processing, and access revocation workflows.',
    `gdpr_applicable` BOOLEAN COMMENT 'Indicates whether this membership record is subject to GDPR (General Data Protection Regulation) obligations based on the fans country of residence. When True, data subject rights requests (access, erasure, portability) must be honored within statutory timeframes.',
    `has_voting_rights` BOOLEAN COMMENT 'Indicates whether this member holds voting rights within the fan club governance structure (e.g., eligible to vote in club elections, rule changes, or fan representative selections). Typically granted to full-dues-paying members above a minimum tenure threshold.',
    `is_founding_member` BOOLEAN COMMENT 'Indicates whether the fan was among the original founding cohort of the fan club. Founding members may receive permanent tier upgrades, exclusive merchandise, or lifetime recognition benefits.',
    `join_date` DATE COMMENT 'Calendar date on which the fan officially joined the fan club and the membership became effective for the first time. Used for tenure calculations, anniversary recognition, and founding-member eligibility.',
    `marketing_opt_in` BOOLEAN COMMENT 'Indicates whether the fan has consented to receive marketing communications from the fan club, including promotional offers, sponsor messages, and merchandise promotions. Distinct from operational membership communications.',
    `membership_card_number` STRING COMMENT 'Physical or digital membership card number issued to the fan. Used for access control at venues, merchandise discounts, and identity verification at fan club events. Treated as a confidential identifier as it can be used to access member benefits.. Valid values are `^[0-9]{12,16}$`',
    `membership_number` STRING COMMENT 'Externally-visible, human-readable membership identifier assigned to the fan upon joining the club. Used on membership cards, correspondence, and access control. Format: club-prefix followed by numeric sequence (e.g., MAN-000123456).. Valid values are `^[A-Z]{2,4}-[0-9]{6,10}$`',
    `membership_status` STRING COMMENT 'Current lifecycle state of the fan club membership. active = dues paid and privileges in force; pending = application submitted awaiting approval or payment; suspended = temporarily restricted due to conduct or non-payment; lapsed = renewal window passed without renewal; cancelled = voluntarily terminated; expired = term ended without renewal action.. Valid values are `active|pending|suspended|lapsed|cancelled|expired`',
    `membership_tier` STRING COMMENT 'Tier classification within the fan club that governs the level of privileges, benefits, and access rights granted to the member. Higher tiers typically carry greater dues, exclusive content access, priority ticketing, and VIP (Very Important Person) event invitations. [ENUM-REF-CANDIDATE: standard|silver|gold|platinum|founding|vip — promote to reference product if tiers expand beyond 6]. Valid values are `standard|silver|gold|platinum|founding|vip`',
    `membership_type` STRING COMMENT 'Classification of the membership by the category of fan or account it covers. Determines eligibility rules, dues schedules, and benefit packages. family allows multiple household members under one membership; corporate is for business-sponsored fan groups; honorary is granted without dues to distinguished individuals.. Valid values are `individual|family|corporate|youth|student|honorary`',
    `nps_score` STRING COMMENT 'Most recent NPS (Net Promoter Score) survey response from this fan regarding their fan club membership experience, on a scale of 0–10. Used to measure member satisfaction, identify detractors for intervention, and track club-level NPS trends.',
    `nps_survey_date` DATE COMMENT 'Date on which the most recent NPS (Net Promoter Score) survey response was captured for this membership. Used to determine survey recency and schedule follow-up outreach.',
    `preferred_contact_channel` STRING COMMENT 'Fans preferred communication channel for fan club communications such as renewal reminders, event invitations, and member newsletters. Overrides the global preference on the fan profile for club-specific communications.. Valid values are `email|sms|push|post|none`',
    `referral_source_code` STRING COMMENT 'Campaign or referral code used at the time of enrollment to attribute the membership acquisition to a specific marketing campaign, partner promotion, or fan referral program. Supports CAC (Customer Acquisition Cost) and LTV (Lifetime Value) analytics.',
    `renewal_count` STRING COMMENT 'Total number of times this membership has been renewed since the original join date. Used to identify long-tenured members for loyalty recognition, retention risk scoring, and anniversary milestone campaigns.',
    `renewal_date` DATE COMMENT 'Scheduled or actual date on which the membership was most recently renewed. Distinct from expiry_date; captures the transactional renewal event date for renewal-rate analytics and CRM (Customer Relationship Management) campaign attribution.',
    `suspension_end_date` DATE COMMENT 'Date on which the membership suspension is scheduled to end and full benefits are reinstated. Null if the suspension is indefinite or the membership has never been suspended.',
    `suspension_reason` STRING COMMENT 'Free-text or coded description of the reason for the membership suspension (e.g., code of conduct violation, abusive behaviour at venue, payment dispute under investigation). Supports governance and compliance audit requirements.',
    `suspension_start_date` DATE COMMENT 'Date from which the membership was placed in suspended status, restricting access to benefits and club activities. Null if the membership has never been suspended.',
    `termination_date` DATE COMMENT 'Date on which the membership was formally terminated, cancelled, or permanently closed. Null for active memberships. Used for churn analysis, data retention scheduling, and GDPR erasure request processing.',
    `termination_reason` STRING COMMENT 'Reason code explaining why the membership was terminated. Used for churn root-cause analysis, conduct governance reporting, and financial write-off classification. [ENUM-REF-CANDIDATE: voluntary_cancellation|non_payment|conduct_violation|deceased|duplicate|club_dissolved — promote to reference product if reasons expand]. Valid values are `voluntary_cancellation|non_payment|conduct_violation|deceased|duplicate|club_dissolved`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this fan club membership record. Used for change data capture, incremental ETL processing, and audit trail maintenance in the Databricks Lakehouse Silver Layer.',
    CONSTRAINT pk_club_membership PRIMARY KEY(`club_membership_id`)
) COMMENT 'Association record linking a fan profile to a specific fan club with membership details. Captures membership number, join date, renewal date, membership status, membership tier within the club, dues payment status, voting rights flag, and chapter assignment. Distinct from the broader loyalty enrollment or venue membership — this specifically governs fan club community participation and associated privileges.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`fan`.`personalization_rule` (
    `personalization_rule_id` BIGINT COMMENT 'Primary key for the personalization_rule association',
    `asset_id` BIGINT COMMENT 'Foreign key linking this personalization rule to the content asset being assigned',
    `segment_id` BIGINT COMMENT 'Foreign key linking this personalization rule to the fan segment being targeted',
    `ab_test_variant` STRING COMMENT 'Identifier of the A/B or multivariate test arm under which this segment-asset assignment is active (e.g., CONTROL, VARIANT_A, VARIANT_B). Belongs to the assignment, not to the segment or asset independently.',
    `activation_status` STRING COMMENT 'Current operational state of this personalization rule assignment. Controls whether the asset is actively being served to the segment. Belongs to the relationship lifecycle, not to either entity alone.',
    `assignment_timestamp` TIMESTAMP COMMENT 'Date and time when this content asset was assigned to the fan segment by a CRM or content operations user. Belongs to the relationship record, not to either entity alone.',
    `expiry_date` DATE COMMENT 'Date on which this specific segment-to-asset assignment expires and the content ceases to be served under this rule. Distinct from the assets own expiry_date (rights/licence expiry) — this expiry governs the targeting assignment window.',
    `priority_rank` BIGINT COMMENT 'Numeric ranking that determines the delivery priority of this asset relative to other assets assigned to the same fan segment. A lower value indicates higher priority. Belongs to the segment-asset pairing, not to either entity alone.',
    `rule_logic` STRING COMMENT 'The structured expression or named rule governing how and when this content asset is delivered to the fan segment. Sourced from the detection phase as personalization_rule. Belongs to the assignment, not to the segment or asset independently.',
    CONSTRAINT pk_personalization_rule PRIMARY KEY(`personalization_rule_id`)
) COMMENT 'This association product represents the Content Personalization Rule — the operational contract between a fan segment and a content asset within the sports entertainment personalization engine. Each record captures a deliberate, managed assignment of a specific digital content asset to a specific fan segment, including the activation window, priority ranking, A/B test variant, and rule logic governing delivery. Records are created, updated, and retired by CRM and content operations teams as part of campaign and DTC personalization workflows.. Existence Justification: In sports entertainment personalization, content teams actively assign specific digital assets (video highlights, editorial articles, social media content) to fan segments as part of campaign and personalization workflows. A single fan segment (e.g., High-Value Season Ticket Holders) can be targeted with many different content assets, and a single asset (e.g., a playoff highlight reel) can be assigned to multiple segments simultaneously. This relationship is operationally managed — marketers create, update, and retire these assignments with specific activation windows, priority rankings, and A/B test variants.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`fan`.`campaign` (
    `campaign_id` BIGINT COMMENT 'Primary key for campaign',
    `approved_by_employee_id` BIGINT COMMENT 'Identifier of the employee who approved the campaign for execution.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or team responsible for managing and executing the campaign.',
    `segment_id` BIGINT COMMENT 'Identifier of the fan segment targeted by this campaign.',
    `parent_campaign_id` BIGINT COMMENT 'Self-referencing FK on campaign (parent_campaign_id)',
    `actual_conversions` BIGINT COMMENT 'Actual number of conversions achieved by the campaign.',
    `actual_impressions` BIGINT COMMENT 'Actual number of impressions or views delivered by the campaign.',
    `actual_spend_amount` DECIMAL(18,2) COMMENT 'Total amount actually spent on the campaign to date in USD.',
    `approval_status` STRING COMMENT 'Current approval status of the campaign by management or compliance review.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the campaign was approved for execution.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Total allocated budget for the campaign in USD. Single-currency operation.',
    `campaign_code` STRING COMMENT 'Externally-known unique business identifier for the campaign, used in marketing materials and tracking URLs.',
    `campaign_name` STRING COMMENT 'Human-readable name of the marketing campaign.',
    `campaign_status` STRING COMMENT 'Current lifecycle status of the campaign.',
    `campaign_type` STRING COMMENT 'Classification of the campaign based on its primary business objective.',
    `channel` STRING COMMENT 'Primary marketing channel through which the campaign is delivered to fans.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the campaign record was first created in the system.',
    `creative_asset_url` STRING COMMENT 'URL or file path to the primary creative asset (image, video, banner) used in the campaign.',
    `campaign_description` STRING COMMENT 'Detailed narrative describing the campaign objectives, messaging, and creative approach.',
    `end_date` DATE COMMENT 'Date when the campaign concludes. Nullable for ongoing campaigns.',
    `is_automated` BOOLEAN COMMENT 'Indicates whether the campaign is executed through automated marketing workflows (True) or manual execution (False).',
    `landing_page_url` STRING COMMENT 'URL of the landing page where fans are directed when engaging with the campaign.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the campaign record was last modified.',
    `notes` STRING COMMENT 'Free-text field for internal notes, learnings, or observations about the campaign execution.',
    `priority` STRING COMMENT 'Business priority level assigned to the campaign for resource allocation and scheduling.',
    `start_date` DATE COMMENT 'Date when the campaign becomes active and begins execution.',
    `tags` STRING COMMENT 'Comma-separated list of tags or keywords for campaign categorization and search.',
    `target_audience` STRING COMMENT 'Description of the intended fan segment or demographic group targeted by this campaign.',
    `target_conversions` BIGINT COMMENT 'Planned number of conversions (ticket purchases, sign-ups, etc.) the campaign aims to achieve.',
    `target_impressions` BIGINT COMMENT 'Planned number of impressions or views the campaign aims to achieve.',
    `tracking_code` STRING COMMENT 'Unique tracking or UTM code used to measure campaign performance across analytics platforms.',
    CONSTRAINT pk_campaign PRIMARY KEY(`campaign_id`)
) COMMENT 'Master reference table for campaign. Referenced by acquisition_campaign_id.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`fan`.`chapter` (
    `chapter_id` BIGINT COMMENT 'Primary key for chapter',
    `parent_chapter_id` BIGINT COMMENT 'Self-referencing FK on chapter (parent_chapter_id)',
    `activation_date` DATE COMMENT 'Date when the chapter became operationally active and began engaging fans.',
    `active_member_count` STRING COMMENT 'Number of members who have engaged with chapter activities in the current period.',
    `address_line_1` STRING COMMENT 'Primary street address for the chapter headquarters or meeting location. Organizational contact data classified as confidential.',
    `address_line_2` STRING COMMENT 'Secondary address information (suite, building, floor) for the chapter location. Organizational contact data classified as confidential.',
    `affiliation_tier` STRING COMMENT 'Tier level of the chapters affiliation with the parent organization, reflecting benefits and recognition.',
    `annual_dues_amount` DECIMAL(18,2) COMMENT 'Annual membership dues amount required for chapter membership, in local currency.',
    `chapter_code` STRING COMMENT 'Unique business identifier code for the chapter used in external communications and systems.',
    `chapter_name` STRING COMMENT 'Official name of the fan chapter (e.g., New York City Chapter, London Supporters Club).',
    `chapter_president_email` STRING COMMENT 'Email address of the chapter president for official communications.',
    `chapter_president_name` STRING COMMENT 'Full name of the current chapter president or primary leader.',
    `chapter_president_phone` STRING COMMENT 'Phone number of the chapter president.',
    `chapter_type` STRING COMMENT 'Classification of the chapter based on its organizational relationship and structure.',
    `charter_document_url` STRING COMMENT 'URL or file path to the official chapter charter or founding document.',
    `city` STRING COMMENT 'Primary city where the chapter is headquartered or most active.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the chapter is primarily based.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the chapter record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for financial transactions related to the chapter.',
    `chapter_description` STRING COMMENT 'Detailed description of the chapters mission, activities, and community focus.',
    `founding_date` DATE COMMENT 'Date when the chapter was officially established.',
    `geographic_region` STRING COMMENT 'Primary geographic region or territory served by the chapter (e.g., Northeast US, Greater London, Asia Pacific).',
    `is_verified` BOOLEAN COMMENT 'Indicates whether the chapter has been officially verified and recognized by the parent organization.',
    `last_event_date` DATE COMMENT 'Date of the most recent event or activity hosted by the chapter.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the chapter record was last updated.',
    `meeting_frequency` STRING COMMENT 'Typical frequency of chapter meetings or gatherings.',
    `member_count` STRING COMMENT 'Current number of registered members in the chapter.',
    `next_scheduled_event_date` DATE COMMENT 'Date of the next planned chapter event or gathering.',
    `notes` STRING COMMENT 'Internal notes or comments about the chapter for operational reference.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the chapters primary address. Organizational contact data classified as confidential.',
    `primary_contact_email` STRING COMMENT 'Official email address for chapter communications and inquiries. Organizational contact data classified as confidential.',
    `primary_contact_phone` STRING COMMENT 'Primary phone number for reaching chapter leadership or coordinators. Organizational contact data classified as confidential.',
    `primary_venue_name` STRING COMMENT 'Name of the primary venue or location where the chapter holds regular meetings or watch parties.',
    `recognition_awards_count` STRING COMMENT 'Total number of recognition awards or honors the chapter has received from the parent organization.',
    `social_media_handle` STRING COMMENT 'Primary social media handle or username used by the chapter across platforms.',
    `sponsorship_level` STRING COMMENT 'Level of corporate or organizational sponsorship the chapter has secured.',
    `state_province` STRING COMMENT 'State, province, or administrative region where the chapter operates.',
    `chapter_status` STRING COMMENT 'Current lifecycle status of the chapter.',
    `termination_date` DATE COMMENT 'Date when the chapter was officially dissolved or terminated. Null for active chapters.',
    `website_url` STRING COMMENT 'Official website URL for the chapter, if maintained.',
    CONSTRAINT pk_chapter PRIMARY KEY(`chapter_id`)
) COMMENT 'Master reference table for chapter. Referenced by chapter_id.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`fan`.`communication_template` (
    `communication_template_id` BIGINT COMMENT 'Primary key for communication_template',
    `brand_id` BIGINT COMMENT 'Reference to the brand or sub-brand associated with this communication template for multi-brand organizations.',
    `parent_template_id` BIGINT COMMENT 'Reference to the parent template from which this version was derived, supporting template versioning and inheritance.',
    `derived_from_communication_template_id` BIGINT COMMENT 'Self-referencing FK on communication_template (derived_from_communication_template_id)',
    `a_b_test_enabled` BOOLEAN COMMENT 'Indicates whether this template is part of an A/B testing experiment for optimization and performance comparison.',
    `audience_segment` STRING COMMENT 'Target fan segment or persona for which this template is designed, used for personalization and targeting.',
    `body_content` STRING COMMENT 'Main body content of the communication template including text, HTML markup, and merge field placeholders.',
    `call_to_action_text` STRING COMMENT 'Primary call-to-action button or link text encouraging recipient engagement.',
    `call_to_action_url` STRING COMMENT 'Target URL for the primary call-to-action link, may include tracking parameters.',
    `character_limit` STRING COMMENT 'Maximum character count allowed for the template content, applicable to SMS and push notifications with length restrictions.',
    `compliance_approval_date` DATE COMMENT 'Date when the template received compliance and legal approval for use in fan communications.',
    `compliance_approved` BOOLEAN COMMENT 'Indicates whether the template has been reviewed and approved by legal and compliance teams for regulatory adherence.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the communication template record was first created in the system.',
    `design_layout` STRING COMMENT 'Visual layout structure of the communication template defining content arrangement and formatting.',
    `effective_end_date` DATE COMMENT 'Date when the template expires and is no longer available for new communications, nullable for indefinite templates.',
    `effective_start_date` DATE COMMENT 'Date when the template becomes active and available for use in communication campaigns.',
    `footer_content` STRING COMMENT 'Standard footer content including legal disclaimers, physical address, and unsubscribe information required by regulations.',
    `html_version` STRING COMMENT 'HTML-formatted version of the template content for rich email clients and web display.',
    `language_code` STRING COMMENT 'ISO 639-1 language code with optional ISO 3166-1 country code indicating the language of the template content.',
    `last_used_timestamp` TIMESTAMP COMMENT 'Timestamp when the template was most recently used to send a communication.',
    `merge_fields` STRING COMMENT 'Comma-separated list of merge field tokens available in the template for dynamic content insertion (e.g., {{first_name}}, {{event_date}}).',
    `modified_by` STRING COMMENT 'Username or identifier of the user who last modified the communication template.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the communication template record was last updated or modified.',
    `notes` STRING COMMENT 'Internal notes and comments about the template for documentation and team collaboration purposes.',
    `personalization_enabled` BOOLEAN COMMENT 'Indicates whether the template includes dynamic personalization merge fields that are populated at send time.',
    `plain_text_version` STRING COMMENT 'Plain text version of the template content for text-only email clients and accessibility compliance.',
    `preheader_text` STRING COMMENT 'Preview text displayed in email clients before the email is opened, used to increase open rates.',
    `reply_to_email` STRING COMMENT 'Email address where recipient replies will be directed, may differ from sender email.',
    `sender_email` STRING COMMENT 'Email address used as the sender for email communications sent using this template.',
    `sender_name` STRING COMMENT 'Display name of the sender shown to recipients in the from field of communications.',
    `communication_template_status` STRING COMMENT 'Current lifecycle status of the communication template indicating availability for use.',
    `subject_line` STRING COMMENT 'Subject line or headline text for the communication template, applicable to email and push notifications.',
    `template_category` STRING COMMENT 'Business category classification of the template based on communication purpose and intent.',
    `template_code` STRING COMMENT 'Unique business identifier code for the template used in system integrations and API references.',
    `template_name` STRING COMMENT 'Human-readable name of the communication template used for identification and selection purposes.',
    `template_type` STRING COMMENT 'Classification of the communication template by delivery channel type.',
    `test_variant_group` STRING COMMENT 'Identifier for the A/B test variant group this template belongs to, used to group related test versions.',
    `unsubscribe_link_required` BOOLEAN COMMENT 'Indicates whether the template must include an unsubscribe link to comply with email marketing regulations.',
    `unsubscribe_link_text` STRING COMMENT 'Display text for the unsubscribe link included in the template footer for opt-out compliance.',
    `usage_count` BIGINT COMMENT 'Total number of times this template has been used to send communications to fans.',
    `version_number` STRING COMMENT 'Sequential version number of the template tracking iterations and updates over time.',
    `created_by` STRING COMMENT 'Username or identifier of the user who created the communication template.',
    CONSTRAINT pk_communication_template PRIMARY KEY(`communication_template_id`)
) COMMENT 'Master reference table for communication_template. Referenced by template_id.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`fan`.`reward` (
    `reward_id` BIGINT COMMENT 'Primary key for reward',
    `loyalty_program_id` BIGINT COMMENT 'Identifier of the loyalty or rewards program to which this reward belongs.',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor or supplier providing the reward.',
    `upgraded_reward_id` BIGINT COMMENT 'Self-referencing FK on reward (upgraded_reward_id)',
    `age_restriction_minimum` STRING COMMENT 'Minimum age required for fans to redeem this reward. Null indicates no minimum age.',
    `reward_category` STRING COMMENT 'Business category or grouping for the reward (e.g., merchandise, hospitality, travel).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the reward record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the monetary value.',
    `reward_description` STRING COMMENT 'Detailed description of the reward, including benefits, terms, and conditions.',
    `effective_end_date` DATE COMMENT 'Date when the reward is no longer available for redemption. Null indicates no expiration.',
    `effective_start_date` DATE COMMENT 'Date when the reward becomes available for redemption.',
    `eligibility_criteria` STRING COMMENT 'Criteria that fans must meet to be eligible for this reward (e.g., tier level, geographic location, age).',
    `fulfillment_method` STRING COMMENT 'Method by which the reward is delivered to the fan.',
    `geographic_restriction` STRING COMMENT 'Geographic regions or countries where the reward is available. Null indicates no restriction.',
    `image_url` STRING COMMENT 'URL to the primary image or visual representation of the reward.',
    `is_exclusive` BOOLEAN COMMENT 'Indicates whether the reward is exclusive to certain fan segments or membership tiers.',
    `is_featured` BOOLEAN COMMENT 'Indicates whether the reward is featured or promoted in fan-facing channels.',
    `monetary_value` DECIMAL(18,2) COMMENT 'Estimated monetary value of the reward in the base currency.',
    `reward_name` STRING COMMENT 'Human-readable name of the reward displayed to fans.',
    `partner_name` STRING COMMENT 'Name of the external partner or sponsor providing the reward, if applicable.',
    `points_required` STRING COMMENT 'Number of loyalty points required to redeem this reward.',
    `priority_rank` STRING COMMENT 'Display priority or ranking of the reward in fan-facing interfaces. Lower numbers indicate higher priority.',
    `quantity_available` STRING COMMENT 'Number of reward units currently available for redemption. Null indicates unlimited availability.',
    `quantity_redeemed` STRING COMMENT 'Total number of times this reward has been redeemed by fans.',
    `redemption_instructions` STRING COMMENT 'Step-by-step instructions for fans on how to redeem the reward.',
    `redemption_limit_per_fan` STRING COMMENT 'Maximum number of times a single fan can redeem this reward. Null indicates no limit.',
    `reward_code` STRING COMMENT 'Externally-known unique code for the reward, used for redemption and tracking across systems.',
    `reward_type` STRING COMMENT 'Category of reward offered to fans.',
    `reward_status` STRING COMMENT 'Current lifecycle status of the reward.',
    `terms_and_conditions` STRING COMMENT 'Legal terms and conditions governing the reward redemption and usage.',
    `tier` STRING COMMENT 'Membership tier or level required to access this reward.',
    `updated_by` STRING COMMENT 'Username or identifier of the user who last updated the reward record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the reward record was last modified.',
    `created_by` STRING COMMENT 'Username or identifier of the user who created the reward record.',
    CONSTRAINT pk_reward PRIMARY KEY(`reward_id`)
) COMMENT 'Master reference table for reward. Referenced by reward_id.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`fan`.`membership_tier` (
    `membership_tier_id` BIGINT COMMENT 'Primary key for membership_tier',
    `next_membership_tier_id` BIGINT COMMENT 'Self-referencing FK on membership_tier (next_membership_tier_id)',
    `annual_fee_amount` DECIMAL(18,2) COMMENT 'Standard annual membership fee charged for this tier. Null for complimentary tiers.',
    `auto_upgrade_eligible_flag` BOOLEAN COMMENT 'Indicates whether members can be automatically upgraded to this tier when qualification thresholds are met, or if manual approval is required.',
    `complimentary_tickets_annual` STRING COMMENT 'Number of complimentary event tickets granted annually to members of this tier. Zero for tiers without this benefit.',
    `concession_discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount on food and beverage concessions granted to members of this tier.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this membership tier record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the annual fee (e.g., USD, EUR, GBP).',
    `dedicated_support_flag` BOOLEAN COMMENT 'Indicates whether members of this tier receive dedicated customer support through a specialized service team or account manager.',
    `membership_tier_description` STRING COMMENT 'Detailed business description of the membership tier, including benefits summary and positioning statement for marketing and customer service use.',
    `display_order` STRING COMMENT 'Numeric value controlling the presentation order of tiers in user interfaces, marketing materials, and reports.',
    `early_renewal_window_days` STRING COMMENT 'Number of days before general renewal period that members of this tier can renew their membership, providing priority renewal access.',
    `effective_end_date` DATE COMMENT 'Date when this membership tier was or will be retired and no longer available for new enrollments. Null for currently active tiers.',
    `effective_start_date` DATE COMMENT 'Date when this membership tier became or will become available for member enrollment and assignment.',
    `icon_url` STRING COMMENT 'URL path to the digital icon or badge image representing this tier in mobile apps, websites, and digital communications.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this membership tier record was most recently updated.',
    `lounge_access_flag` BOOLEAN COMMENT 'Indicates whether members of this tier have access to premium lounges and hospitality areas at venues.',
    `marketing_color_code` STRING COMMENT 'Hexadecimal color code used for brand-consistent visual representation of this tier in digital and print materials.',
    `max_guest_passes_annual` STRING COMMENT 'Maximum number of guest passes that can be issued annually to members of this tier for bringing non-members to events or facilities.',
    `meet_and_greet_eligibility_flag` BOOLEAN COMMENT 'Indicates whether members of this tier are eligible for meet-and-greet opportunities with athletes, performers, or talent.',
    `merchandise_discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount on merchandise purchases granted to members of this tier (e.g., 10.00 for 10% discount).',
    `modified_by_user` STRING COMMENT 'Username or identifier of the system user or administrator who last modified this tier configuration.',
    `parking_benefit_flag` BOOLEAN COMMENT 'Indicates whether members of this tier receive complimentary or discounted parking at venues.',
    `points_earning_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to base points earning rate for this tier (e.g., 1.0 for standard, 1.5 for premium, 2.0 for elite).',
    `priority_access_flag` BOOLEAN COMMENT 'Indicates whether members of this tier receive priority access to ticket sales, events, and exclusive experiences.',
    `qualification_events_attended_threshold` STRING COMMENT 'Minimum number of events attended annually to qualify for or maintain this tier. Null for tiers without attendance requirements.',
    `qualification_points_threshold` STRING COMMENT 'Minimum loyalty points required to qualify for or maintain this tier. Null for entry-level tiers.',
    `qualification_spend_threshold` DECIMAL(18,2) COMMENT 'Minimum annual spend amount required to qualify for or maintain this tier. Null for entry-level tiers.',
    `membership_tier_status` STRING COMMENT 'Current lifecycle status of the membership tier indicating whether it is available for new enrollments or existing member assignments.',
    `terms_and_conditions_url` STRING COMMENT 'URL to the legal terms and conditions document governing this membership tier.',
    `tier_category` STRING COMMENT 'Classification of the tier into broad business segments for marketing and operational purposes.',
    `tier_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the tier for system integration and reporting (e.g., BRZ, SLV, GLD, PLT, VIP).',
    `tier_level` STRING COMMENT 'Numeric ranking of the tier within the membership hierarchy, where higher numbers indicate premium tiers (e.g., 1=Bronze, 2=Silver, 3=Gold, 4=Platinum, 5=VIP).',
    `tier_name` STRING COMMENT 'Human-readable name of the membership tier (e.g., Bronze, Silver, Gold, Platinum, VIP).',
    `transferable_flag` BOOLEAN COMMENT 'Indicates whether membership benefits for this tier can be transferred to another individual or shared with family members.',
    CONSTRAINT pk_membership_tier PRIMARY KEY(`membership_tier_id`)
) COMMENT 'Master reference table for membership_tier. Referenced by membership_tier_id.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`fan`.`benefit_package` (
    `benefit_package_id` BIGINT COMMENT 'Primary key for benefit_package',
    `parent_benefit_package_id` BIGINT COMMENT 'Self-referencing FK on benefit_package (parent_benefit_package_id)',
    `age_restriction_minimum` STRING COMMENT 'Minimum age requirement for enrollment in this benefit package. Null if no minimum age.',
    `annual_price` DECIMAL(18,2) COMMENT 'Standard annual price for the benefit package in the base currency. Used for season ticket and membership pricing.',
    `auto_renewal_enabled` BOOLEAN COMMENT 'Indicates whether automatic renewal is enabled by default for this benefit package type.',
    `cancellation_notice_days` STRING COMMENT 'Number of days advance notice required for cancellation of this benefit package without penalty.',
    `created_by_user` STRING COMMENT 'Username or identifier of the business user who created this benefit package record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this benefit package record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for package pricing.',
    `benefit_package_description` STRING COMMENT 'Detailed description of the benefits, perks, and privileges included in this package for fan communication and marketing purposes.',
    `display_order` STRING COMMENT 'Numeric sequence controlling the display order of benefit packages in fan-facing applications and websites.',
    `effective_end_date` DATE COMMENT 'Date when the benefit package expires or is no longer available. Nullable for open-ended packages.',
    `effective_start_date` DATE COMMENT 'Date when the benefit package becomes active and available for fan enrollment or assignment.',
    `enrollment_close_date` DATE COMMENT 'Date when enrollment or registration closes for this benefit package. Null if open enrollment.',
    `enrollment_open_date` DATE COMMENT 'Date when enrollment or registration opens for this benefit package.',
    `geographic_restriction` STRING COMMENT 'Geographic region or market restriction for this benefit package. Null if available globally.',
    `includes_exclusive_content` BOOLEAN COMMENT 'Indicates whether this benefit package grants access to exclusive digital content, behind-the-scenes footage, or premium streaming.',
    `includes_hospitality_access` BOOLEAN COMMENT 'Indicates whether this benefit package includes access to premium hospitality areas, lounges, or VIP sections.',
    `includes_meet_and_greet` BOOLEAN COMMENT 'Indicates whether this benefit package includes opportunities for meet-and-greet experiences with athletes or performers.',
    `includes_merchandise_discount` BOOLEAN COMMENT 'Indicates whether this benefit package includes discounts on official merchandise purchases.',
    `includes_parking` BOOLEAN COMMENT 'Indicates whether this benefit package includes complimentary or discounted parking at venues.',
    `loyalty_points_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to loyalty points earned by fans with this benefit package. Standard is 1.00, premium packages may have 1.5x, 2.0x, etc.',
    `marketing_campaign_code` STRING COMMENT 'Code linking this benefit package to a specific marketing campaign or promotional initiative.',
    `max_active_memberships` STRING COMMENT 'Maximum number of active memberships or enrollments allowed for this benefit package across all fans. Null if unlimited.',
    `max_guest_passes` STRING COMMENT 'Maximum number of guest passes or companion tickets included with this benefit package per season or period.',
    `merchandise_discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount on merchandise purchases granted to holders of this benefit package. Null if no discount applies.',
    `minimum_commitment_months` STRING COMMENT 'Minimum number of months a fan must commit to when enrolling in this benefit package. Null if no minimum commitment.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the business user who last modified this benefit package record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this benefit package record was last modified or updated.',
    `monthly_price` DECIMAL(18,2) COMMENT 'Monthly subscription price for the benefit package if offered on a recurring payment basis.',
    `package_code` STRING COMMENT 'Externally-known unique business identifier code for the benefit package used in marketing materials and fan communications.',
    `package_name` STRING COMMENT 'Human-readable name of the benefit package displayed to fans and members.',
    `package_type` STRING COMMENT 'Classification of the benefit package indicating the category of fan benefits offered.',
    `priority_access_level` STRING COMMENT 'Numeric ranking of priority access for ticket purchases, event reservations, and exclusive content. Higher values indicate greater priority.',
    `renewal_eligible` BOOLEAN COMMENT 'Indicates whether this benefit package is eligible for automatic or priority renewal at the end of the term.',
    `requires_membership_verification` BOOLEAN COMMENT 'Indicates whether enrollment in this benefit package requires identity or membership verification.',
    `seat_upgrade_eligible` BOOLEAN COMMENT 'Indicates whether holders of this benefit package are eligible for complimentary or discounted seat upgrades.',
    `short_description` STRING COMMENT 'Brief summary description of the benefit package used in mobile apps, listings, and condensed displays.',
    `benefit_package_status` STRING COMMENT 'Current lifecycle status of the benefit package indicating availability and operational state.',
    `target_audience` STRING COMMENT 'Primary target audience or fan segment for this benefit package.',
    `terms_and_conditions_url` STRING COMMENT 'URL link to the full terms and conditions document governing this benefit package.',
    `tier_level` STRING COMMENT 'Hierarchical tier level of the benefit package within the loyalty or membership program structure.',
    `transferable` BOOLEAN COMMENT 'Indicates whether the benefits in this package can be transferred to another fan or family member.',
    CONSTRAINT pk_benefit_package PRIMARY KEY(`benefit_package_id`)
) COMMENT 'Master reference table for benefit_package. Referenced by benefit_package_id.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`fan`.`segment_rule` (
    `segment_rule_id` BIGINT COMMENT 'Primary key for segment_rule',
    `parent_rule_id` BIGINT COMMENT 'Reference to a parent segment rule if this rule is a variant, refinement, or sub-rule of another segment rule. Null if this is a top-level rule.',
    `parent_segment_rule_id` BIGINT COMMENT 'Self-referencing FK on segment_rule (parent_segment_rule_id)',
    `applies_to_member_types` STRING COMMENT 'Comma-separated list or description of fan membership types to which this rule applies (e.g., individual, family, season_ticket_holder, VIP, fan_club_member).',
    `approval_status` STRING COMMENT 'Current approval status of the segment rule in the governance workflow before it can be activated.',
    `approved_by` STRING COMMENT 'Name or identifier of the user or role who approved this segment rule for production use.',
    `approved_timestamp` TIMESTAMP COMMENT 'The timestamp when this segment rule was approved for production use.',
    `business_owner` STRING COMMENT 'Name or identifier of the business unit, team, or individual responsible for defining and maintaining this segment rule.',
    `channel_scope` STRING COMMENT 'Engagement channels to which this segment rule applies (e.g., all_channels, digital_only, in_venue_only, broadcast, mobile_app).',
    `consent_required` BOOLEAN COMMENT 'Indicates whether explicit fan consent is required before applying this segment rule for marketing or personalization purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this segment rule record was first created in the system.',
    `segment_rule_description` STRING COMMENT 'Detailed business description of the segment rule explaining its purpose, criteria, and intended use cases.',
    `effective_end_date` DATE COMMENT 'The date on which this segment rule expires or is no longer applied to fan segmentation. Null indicates an open-ended rule.',
    `effective_start_date` DATE COMMENT 'The date from which this segment rule becomes active and begins being applied to fan segmentation.',
    `estimated_fan_count` BIGINT COMMENT 'Estimated or last calculated number of fans who qualify for this segment rule based on the most recent evaluation.',
    `evaluation_frequency` STRING COMMENT 'How often the segment rule is evaluated and applied to the fan base to refresh segment membership.',
    `geographic_scope` STRING COMMENT 'Geographic scope or market to which this segment rule applies (e.g., global, USA, specific region, specific venue market).',
    `is_ccpa_compliant` BOOLEAN COMMENT 'Indicates whether this segment rule has been reviewed and approved for compliance with CCPA privacy requirements for California fan data processing.',
    `is_exclusive` BOOLEAN COMMENT 'Indicates whether a fan can belong to only this segment (true) or can belong to multiple segments simultaneously (false).',
    `is_gdpr_compliant` BOOLEAN COMMENT 'Indicates whether this segment rule has been reviewed and approved for compliance with GDPR privacy requirements for fan data processing.',
    `last_evaluation_timestamp` TIMESTAMP COMMENT 'The timestamp when this segment rule was last evaluated and applied to the fan base.',
    `lookback_period_days` STRING COMMENT 'The number of days in the past that the rule evaluates when assessing fan behavior or transactions (e.g., 90 days for recent purchase activity, 365 days for annual spend).',
    `marketing_use_allowed` BOOLEAN COMMENT 'Indicates whether fans identified by this segment rule can be targeted for marketing campaigns and promotional communications.',
    `maximum_threshold_value` DECIMAL(18,2) COMMENT 'The maximum numeric threshold value that must not be exceeded for a fan to qualify for this segment (e.g., maximum days since last purchase, maximum churn risk score).',
    `minimum_threshold_value` DECIMAL(18,2) COMMENT 'The minimum numeric threshold value that must be met for a fan to qualify for this segment (e.g., minimum spend amount, minimum attendance count, minimum engagement score).',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this segment rule record was last modified or updated.',
    `next_evaluation_timestamp` TIMESTAMP COMMENT 'The timestamp when this segment rule is scheduled to be evaluated next based on the evaluation frequency.',
    `notes` STRING COMMENT 'Free-form notes or comments about the segment rule for internal documentation, business context, or special handling instructions.',
    `priority` STRING COMMENT 'Numeric priority or ranking of the segment rule used to resolve conflicts when a fan qualifies for multiple segments (lower number = higher priority).',
    `rule_category` STRING COMMENT 'Business category or grouping for the segment rule used for organizational and reporting purposes (e.g., VIP Identification, Churn Risk, High Value, Season Ticket Holder).',
    `rule_code` STRING COMMENT 'Unique business code or identifier for the segment rule used in external systems and reporting.',
    `rule_logic` STRING COMMENT 'The logical expression or criteria definition that defines how fans are evaluated and assigned to this segment (e.g., SQL WHERE clause, JSON rule definition, or business rule syntax).',
    `rule_name` STRING COMMENT 'Human-readable name of the segment rule used for identification and display purposes.',
    `rule_type` STRING COMMENT 'Classification of the segment rule based on the type of criteria it evaluates (demographic, behavioral, transactional, engagement, loyalty, or predictive).',
    `segment_rule_status` STRING COMMENT 'Current lifecycle status of the segment rule indicating whether it is actively being used for fan segmentation.',
    `target_audience` STRING COMMENT 'Description of the intended target audience or fan persona that this segment rule is designed to identify (e.g., High-Value Season Ticket Holders, Lapsed Fans, Family Attendees).',
    `threshold_unit` STRING COMMENT 'The unit of measure for the threshold values (e.g., USD, events, days, points, percentage, count).',
    `version_number` STRING COMMENT 'Version number of the segment rule used to track changes and iterations to the rule logic or criteria over time.',
    CONSTRAINT pk_segment_rule PRIMARY KEY(`segment_rule_id`)
) COMMENT 'Master reference table for segment_rule. Referenced by segment_rule_id.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`fan`.`brand` (
    `brand_id` BIGINT COMMENT 'Primary key for brand',
    `brand_category` STRING COMMENT 'High-level category classifying the brand by its entertainment genre or sports discipline.',
    `brand_health_index` DECIMAL(18,2) COMMENT 'Composite metric measuring overall brand strength including awareness, perception, loyalty, and market performance, scaled 0-100.',
    `brand_manager_email` STRING COMMENT 'Business email address of the brand manager for internal communication and coordination.',
    `brand_manager_name` STRING COMMENT 'Full name of the individual responsible for managing the brand strategy and operations.',
    `brand_value_usd` DECIMAL(18,2) COMMENT 'Estimated monetary value of the brand in US dollars based on market analysis and revenue generation potential.',
    `broadcast_rights_holder` STRING COMMENT 'Name of the media company or network that holds exclusive broadcasting rights for brand content.',
    `brand_code` STRING COMMENT 'Short alphanumeric code used to uniquely identify the brand in operational systems and reporting.',
    `content_rating` STRING COMMENT 'Age-appropriateness rating assigned to brand content for viewer guidance and regulatory compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this brand record was first created in the system.',
    `brand_description` STRING COMMENT 'Detailed narrative description of the brand, its positioning, and its role in the sports entertainment portfolio.',
    `fan_club_enabled_flag` BOOLEAN COMMENT 'Indicates whether the brand has an official fan club or membership program for dedicated supporters.',
    `fan_engagement_score` DECIMAL(18,2) COMMENT 'Composite metric measuring the level of fan interaction and engagement with the brand across all channels, scaled 0-100.',
    `geographic_scope` STRING COMMENT 'Geographic reach and market coverage of the brand indicating its operational footprint.',
    `international_expansion_flag` BOOLEAN COMMENT 'Indicates whether the brand is actively pursuing or has achieved international market expansion beyond its primary market.',
    `is_featured_flag` BOOLEAN COMMENT 'Indicates whether the brand is currently featured in promotional campaigns or homepage displays.',
    `launch_date` DATE COMMENT 'Date when the brand was officially launched or introduced to the market and fans.',
    `licensing_tier` STRING COMMENT 'Classification of the brand based on its licensing value and revenue potential for merchandise and partnerships.',
    `logo_url` STRING COMMENT 'Web address pointing to the official brand logo image file used across digital channels.',
    `loyalty_program_id` BIGINT COMMENT 'Reference to the loyalty program associated with this brand for fan rewards and engagement tracking.',
    `marketing_budget_usd` DECIMAL(18,2) COMMENT 'Annual marketing budget allocated to the brand for promotional activities and fan engagement initiatives.',
    `merchandise_enabled_flag` BOOLEAN COMMENT 'Indicates whether the brand has licensed merchandise available for sale to fans.',
    `brand_name` STRING COMMENT 'Official name of the brand as recognized by fans and the market.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, comments, or context about the brand not captured in structured fields.',
    `parent_brand_id` BIGINT COMMENT 'Reference to the parent brand if this brand is a sub-brand or franchise within a larger brand portfolio.',
    `partnership_tier` STRING COMMENT 'Classification of the brands partnership and sponsorship value for corporate collaborations.',
    `primary_color_hex` STRING COMMENT 'Hexadecimal color code representing the primary brand color used in visual identity and marketing materials.',
    `primary_market_country_code` STRING COMMENT 'Three-letter ISO country code representing the primary market where the brand has its strongest presence and fan base.',
    `retirement_date` DATE COMMENT 'Date when the brand was officially retired or discontinued from active use. Null if brand is still active.',
    `season_year` STRING COMMENT 'Current or most recent season year associated with the brand for time-based content and event organization.',
    `secondary_color_hex` STRING COMMENT 'Hexadecimal color code representing the secondary brand color used in visual identity and marketing materials.',
    `social_media_handle` STRING COMMENT 'Primary social media username or handle used across platforms for brand identity and fan engagement.',
    `brand_status` STRING COMMENT 'Current lifecycle status of the brand indicating its operational state and availability for fan engagement.',
    `streaming_platform` STRING COMMENT 'Primary digital streaming service where brand content is distributed to fans.',
    `tagline` STRING COMMENT 'Official marketing tagline or slogan associated with the brand for promotional and fan engagement purposes.',
    `target_audience` STRING COMMENT 'Primary demographic or psychographic audience segment that the brand is designed to appeal to and engage.',
    `trademark_expiry_date` DATE COMMENT 'Date when the current trademark registration expires and requires renewal to maintain legal protection.',
    `trademark_registration_date` DATE COMMENT 'Date when the brand trademark was officially registered with the relevant intellectual property authority.',
    `trademark_registration_number` STRING COMMENT 'Official registration number assigned by the trademark authority for legal protection of the brand name and identity.',
    `brand_type` STRING COMMENT 'Classification of the brand by its primary business function within the sports entertainment ecosystem.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this brand record was last modified in the system.',
    `website_url` STRING COMMENT 'Official website address for the brand where fans can access content, merchandise, and engagement opportunities.',
    CONSTRAINT pk_brand PRIMARY KEY(`brand_id`)
) COMMENT 'Master reference table for brand. Referenced by brand_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ADD CONSTRAINT `fk_fan_account_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`campaign`(`campaign_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ADD CONSTRAINT `fk_fan_account_club_membership_id` FOREIGN KEY (`club_membership_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`club_membership`(`club_membership_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ADD CONSTRAINT `fk_fan_account_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ADD CONSTRAINT `fk_fan_account_loyalty_program_id` FOREIGN KEY (`loyalty_program_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`loyalty_program`(`loyalty_program_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ADD CONSTRAINT `fk_fan_household_club_membership_id` FOREIGN KEY (`club_membership_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`club_membership`(`club_membership_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ADD CONSTRAINT `fk_fan_household_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ADD CONSTRAINT `fk_fan_household_merged_into_household_id` FOREIGN KEY (`merged_into_household_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`household`(`household_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ADD CONSTRAINT `fk_fan_household_primary_fan_fan_profile_id` FOREIGN KEY (`primary_fan_fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ADD CONSTRAINT `fk_fan_loyalty_enrollment_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ADD CONSTRAINT `fk_fan_loyalty_enrollment_loyalty_program_id` FOREIGN KEY (`loyalty_program_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`loyalty_program`(`loyalty_program_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ADD CONSTRAINT `fk_fan_loyalty_enrollment_primary_loyalty_fan_profile_id` FOREIGN KEY (`primary_loyalty_fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ADD CONSTRAINT `fk_fan_loyalty_enrollment_referred_by_fan_fan_profile_id` FOREIGN KEY (`referred_by_fan_fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ADD CONSTRAINT `fk_fan_loyalty_transaction_engagement_event_id` FOREIGN KEY (`engagement_event_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`engagement_event`(`engagement_event_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ADD CONSTRAINT `fk_fan_loyalty_transaction_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ADD CONSTRAINT `fk_fan_loyalty_transaction_loyalty_enrollment_id` FOREIGN KEY (`loyalty_enrollment_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`loyalty_enrollment`(`loyalty_enrollment_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ADD CONSTRAINT `fk_fan_loyalty_transaction_loyalty_program_id` FOREIGN KEY (`loyalty_program_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`loyalty_program`(`loyalty_program_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ADD CONSTRAINT `fk_fan_loyalty_transaction_membership_tier_id` FOREIGN KEY (`membership_tier_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`membership_tier`(`membership_tier_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ADD CONSTRAINT `fk_fan_loyalty_transaction_nps_survey_id` FOREIGN KEY (`nps_survey_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`nps_survey`(`nps_survey_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ADD CONSTRAINT `fk_fan_loyalty_transaction_primary_loyalty_fan_profile_id` FOREIGN KEY (`primary_loyalty_fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ADD CONSTRAINT `fk_fan_loyalty_transaction_reversal_of_transaction_loyalty_transaction_id` FOREIGN KEY (`reversal_of_transaction_loyalty_transaction_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`loyalty_transaction`(`loyalty_transaction_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ADD CONSTRAINT `fk_fan_loyalty_transaction_reward_id` FOREIGN KEY (`reward_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`reward`(`reward_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ADD CONSTRAINT `fk_fan_loyalty_transaction_transfer_target_fan_fan_profile_id` FOREIGN KEY (`transfer_target_fan_fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ADD CONSTRAINT `fk_fan_membership_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ADD CONSTRAINT `fk_fan_membership_account_id` FOREIGN KEY (`account_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`account`(`account_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ADD CONSTRAINT `fk_fan_membership_family_account_id` FOREIGN KEY (`family_account_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`account`(`account_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ADD CONSTRAINT `fk_fan_membership_fan_fan_profile_id` FOREIGN KEY (`fan_fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ADD CONSTRAINT `fk_fan_membership_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ADD CONSTRAINT `fk_fan_membership_benefit_membership_id` FOREIGN KEY (`membership_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`membership`(`membership_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ADD CONSTRAINT `fk_fan_membership_benefit_membership_tier_id` FOREIGN KEY (`membership_tier_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`membership_tier`(`membership_tier_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ADD CONSTRAINT `fk_fan_segment_source_segment_id` FOREIGN KEY (`source_segment_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`segment`(`segment_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ADD CONSTRAINT `fk_fan_segment_assignment_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ADD CONSTRAINT `fk_fan_segment_assignment_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`segment`(`segment_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ADD CONSTRAINT `fk_fan_segment_assignment_segment_rule_id` FOREIGN KEY (`segment_rule_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`segment_rule`(`segment_rule_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ADD CONSTRAINT `fk_fan_consent_preference_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ADD CONSTRAINT `fk_fan_consent_preference_parental_guardian_fan_profile_id` FOREIGN KEY (`parental_guardian_fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ADD CONSTRAINT `fk_fan_consent_preference_primary_consent_fan_profile_id` FOREIGN KEY (`primary_consent_fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ADD CONSTRAINT `fk_fan_nps_survey_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ADD CONSTRAINT `fk_fan_nps_survey_service_case_id` FOREIGN KEY (`service_case_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`service_case`(`service_case_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ADD CONSTRAINT `fk_fan_nps_response_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ADD CONSTRAINT `fk_fan_nps_response_nps_survey_id` FOREIGN KEY (`nps_survey_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`nps_survey`(`nps_survey_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ADD CONSTRAINT `fk_fan_nps_response_service_case_id` FOREIGN KEY (`service_case_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`service_case`(`service_case_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ADD CONSTRAINT `fk_fan_engagement_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`campaign`(`campaign_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ADD CONSTRAINT `fk_fan_engagement_event_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ADD CONSTRAINT `fk_fan_engagement_event_loyalty_program_id` FOREIGN KEY (`loyalty_program_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`loyalty_program`(`loyalty_program_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ADD CONSTRAINT `fk_fan_communication_engagement_event_id` FOREIGN KEY (`engagement_event_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`engagement_event`(`engagement_event_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ADD CONSTRAINT `fk_fan_communication_fan_fan_profile_id` FOREIGN KEY (`fan_fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ADD CONSTRAINT `fk_fan_communication_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ADD CONSTRAINT `fk_fan_communication_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`segment`(`segment_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ADD CONSTRAINT `fk_fan_communication_communication_template_id` FOREIGN KEY (`communication_template_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`communication_template`(`communication_template_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ADD CONSTRAINT `fk_fan_service_case_fan_fan_profile_id` FOREIGN KEY (`fan_fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ADD CONSTRAINT `fk_fan_service_case_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ADD CONSTRAINT `fk_fan_service_case_membership_id` FOREIGN KEY (`membership_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`membership`(`membership_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ADD CONSTRAINT `fk_fan_service_case_related_case_service_case_id` FOREIGN KEY (`related_case_service_case_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`service_case`(`service_case_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ADD CONSTRAINT `fk_fan_payment_method_account_id` FOREIGN KEY (`account_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`account`(`account_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ADD CONSTRAINT `fk_fan_payment_method_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ADD CONSTRAINT `fk_fan_club_parent_club_id` FOREIGN KEY (`parent_club_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`club`(`club_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ADD CONSTRAINT `fk_fan_club_membership_chapter_id` FOREIGN KEY (`chapter_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`chapter`(`chapter_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ADD CONSTRAINT `fk_fan_club_membership_club_id` FOREIGN KEY (`club_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`club`(`club_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ADD CONSTRAINT `fk_fan_club_membership_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ADD CONSTRAINT `fk_fan_club_membership_primary_club_fan_profile_id` FOREIGN KEY (`primary_club_fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ADD CONSTRAINT `fk_fan_club_membership_referred_by_fan_fan_profile_id` FOREIGN KEY (`referred_by_fan_fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`personalization_rule` ADD CONSTRAINT `fk_fan_personalization_rule_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`segment`(`segment_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`campaign` ADD CONSTRAINT `fk_fan_campaign_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`segment`(`segment_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`campaign` ADD CONSTRAINT `fk_fan_campaign_parent_campaign_id` FOREIGN KEY (`parent_campaign_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`campaign`(`campaign_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`chapter` ADD CONSTRAINT `fk_fan_chapter_parent_chapter_id` FOREIGN KEY (`parent_chapter_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`chapter`(`chapter_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication_template` ADD CONSTRAINT `fk_fan_communication_template_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`brand`(`brand_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication_template` ADD CONSTRAINT `fk_fan_communication_template_parent_template_id` FOREIGN KEY (`parent_template_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`communication_template`(`communication_template_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication_template` ADD CONSTRAINT `fk_fan_communication_template_derived_from_communication_template_id` FOREIGN KEY (`derived_from_communication_template_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`communication_template`(`communication_template_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`reward` ADD CONSTRAINT `fk_fan_reward_loyalty_program_id` FOREIGN KEY (`loyalty_program_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`loyalty_program`(`loyalty_program_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`reward` ADD CONSTRAINT `fk_fan_reward_upgraded_reward_id` FOREIGN KEY (`upgraded_reward_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`reward`(`reward_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_tier` ADD CONSTRAINT `fk_fan_membership_tier_next_membership_tier_id` FOREIGN KEY (`next_membership_tier_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`membership_tier`(`membership_tier_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`benefit_package` ADD CONSTRAINT `fk_fan_benefit_package_parent_benefit_package_id` FOREIGN KEY (`parent_benefit_package_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_rule` ADD CONSTRAINT `fk_fan_segment_rule_parent_rule_id` FOREIGN KEY (`parent_rule_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`segment_rule`(`segment_rule_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_rule` ADD CONSTRAINT `fk_fan_segment_rule_parent_segment_rule_id` FOREIGN KEY (`parent_segment_rule_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`segment_rule`(`segment_rule_id`);

-- ========= TAGS =========
ALTER SCHEMA `sports_entertainment_ecm`.`fan` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `sports_entertainment_ecm`.`fan` SET TAGS ('dbx_domain' = 'fan');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `fan_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Fan Profile ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `franchise_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Franchise Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `venue_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Venue Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `accessibility_requirements` SET TAGS ('dbx_business_glossary_term' = 'Fan Accessibility Requirements');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `accessibility_requirements` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Fan Account Status');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_verification|deactivated|merged');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `aep_profile_reference` SET TAGS ('dbx_business_glossary_term' = 'Adobe Experience Platform (AEP) Profile ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `aep_profile_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `aep_profile_reference` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `birth_date` SET TAGS ('dbx_business_glossary_term' = 'Fan Date of Birth');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `birth_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `birth_date` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `ccpa_applicable` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Applicability Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `communication_opt_in_email` SET TAGS ('dbx_business_glossary_term' = 'Email Communication Opt-In Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `communication_opt_in_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `communication_opt_in_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `communication_opt_in_push` SET TAGS ('dbx_business_glossary_term' = 'Push Notification Opt-In Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `communication_opt_in_sms` SET TAGS ('dbx_business_glossary_term' = 'SMS Communication Opt-In Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `consent_capture_date` SET TAGS ('dbx_business_glossary_term' = 'Privacy Consent Capture Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `consent_version` SET TAGS ('dbx_business_glossary_term' = 'Privacy Consent Policy Version');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `country_of_residence_code` SET TAGS ('dbx_business_glossary_term' = 'Fan Country of Residence Code');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `country_of_residence_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `country_of_residence_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `country_of_residence_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `crm_contact_reference` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Contact ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `crm_contact_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `crm_contact_reference` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `crm_segment_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Segment Code');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `data_sharing_consent` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Data Sharing Consent Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `display_name` SET TAGS ('dbx_business_glossary_term' = 'Fan Display Name');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `display_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `display_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Fan Primary Email Address');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `fan_type` SET TAGS ('dbx_business_glossary_term' = 'Fan Account Type');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `fan_type` SET TAGS ('dbx_value_regex' = 'individual|family_account|corporate|vip|fan_club');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Fan First Name');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `gdpr_applicable` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Applicability Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Fan Gender Identity');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|non_binary|prefer_not_to_say|other');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `is_fan_club_member` SET TAGS ('dbx_business_glossary_term' = 'Fan Club Member Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `is_season_ticket_holder` SET TAGS ('dbx_business_glossary_term' = 'Season Ticket Holder Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `is_vip_member` SET TAGS ('dbx_business_glossary_term' = 'Very Important Person (VIP) Member Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `last_engagement_date` SET TAGS ('dbx_business_glossary_term' = 'Fan Last Engagement Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `last_login_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Fan Last Login Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Fan Last Name');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `loyalty_enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Fan Loyalty Program Enrollment Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `loyalty_points_balance` SET TAGS ('dbx_business_glossary_term' = 'Fan Loyalty Points Balance');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `loyalty_tier` SET TAGS ('dbx_business_glossary_term' = 'Fan Loyalty Program Tier');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `loyalty_tier` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold|platinum|elite');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `nationality_code` SET TAGS ('dbx_business_glossary_term' = 'Fan Nationality Country Code');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `nationality_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `nationality_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `nps_survey_date` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Survey Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `phone` SET TAGS ('dbx_business_glossary_term' = 'Fan Primary Phone Number');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Fan Postal Code');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `preferred_language_code` SET TAGS ('dbx_business_glossary_term' = 'Fan Preferred Language Code');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `preferred_language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `preferred_sport` SET TAGS ('dbx_business_glossary_term' = 'Fan Preferred Sport');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `registration_channel` SET TAGS ('dbx_business_glossary_term' = 'Fan Registration Channel');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `registration_channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|in_venue|call_centre|partner|social_media');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Fan Account Registration Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `secondary_email` SET TAGS ('dbx_business_glossary_term' = 'Fan Secondary Email Address');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `secondary_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `secondary_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `secondary_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Campaign ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `club_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Fan Club Membership ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `fan_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Fan Profile ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `fan_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `fan_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `franchise_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Team ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `loyalty_program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Team ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `venue_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Venue ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|suspended|closed|pending_verification|locked|deactivated');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `account_tier` SET TAGS ('dbx_business_glossary_term' = 'Account Tier');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `account_tier` SET TAGS ('dbx_value_regex' = 'standard|silver|gold|platinum|vip|elite');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'individual|family|corporate_group|season_ticket_holder|vip_member|fan_club');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `card_brand` SET TAGS ('dbx_business_glossary_term' = 'Payment Card Brand');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `card_brand` SET TAGS ('dbx_value_regex' = 'Visa|Mastercard|Amex|Discover|UnionPay|Other');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `card_brand` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `card_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Card Expiry Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `card_expiry_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `card_last_four` SET TAGS ('dbx_business_glossary_term' = 'Card Last Four Digits');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `card_last_four` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `card_last_four` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `card_last_four` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `ccpa_opt_out_flag` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Opt-Out Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Account Closure Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `consent_recorded_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Recorded Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Account Created Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `crm_account_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Account Number');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `crm_account_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `crm_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `crm_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `crm_segment_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Segment Code');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `crm_segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Account Currency Code');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `data_residency_country` SET TAGS ('dbx_business_glossary_term' = 'Data Residency Country');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `data_residency_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `default_payment_flag` SET TAGS ('dbx_business_glossary_term' = 'Default Payment Method Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `gdpr_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Consent Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Account Preferred Language');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `language` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}(-[A-Z]{2,3})?$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `last_login_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Login Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `login_failure_count` SET TAGS ('dbx_business_glossary_term' = 'Login Failure Count');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `loyalty_points_balance` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Balance');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `loyalty_points_ytd_earned` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Year-to-Date (YTD) Earned');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `marketing_email_opt_in_flag` SET TAGS ('dbx_business_glossary_term' = 'Marketing Email Opt-In Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `marketing_email_opt_in_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `marketing_email_opt_in_flag` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `membership_number` SET TAGS ('dbx_business_glossary_term' = 'Membership Number');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `membership_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,16}$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `membership_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `membership_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `mfa_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Multi-Factor Authentication (MFA) Enabled Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `nps_survey_date` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Survey Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `password_last_changed_date` SET TAGS ('dbx_business_glossary_term' = 'Password Last Changed Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `pci_payment_token` SET TAGS ('dbx_business_glossary_term' = 'Payment Card Industry (PCI) Payment Token');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `pci_payment_token` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9-_]{16,64}$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `pci_payment_token` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `pci_payment_token` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `primary_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Email Address');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `primary_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `primary_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `primary_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `primary_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone Number');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `primary_phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{6,14}$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `primary_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `push_notification_opt_in_flag` SET TAGS ('dbx_business_glossary_term' = 'Push Notification Opt-In Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `registration_channel` SET TAGS ('dbx_business_glossary_term' = 'Registration Channel');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `registration_channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|in_venue_kiosk|call_center|third_party_partner|pos');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Account Registration Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `season_ticket_holder_flag` SET TAGS ('dbx_business_glossary_term' = 'Season Ticket Holder Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `sms_opt_in_flag` SET TAGS ('dbx_business_glossary_term' = 'SMS Marketing Opt-In Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Account Last Updated Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `username` SET TAGS ('dbx_business_glossary_term' = 'Account Username');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `username` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._-]{3,50}$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `username` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `username` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ALTER COLUMN `vip_flag` SET TAGS ('dbx_business_glossary_term' = 'Very Important Person (VIP) Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `club_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Fan Club Membership ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `franchise_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Team ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `fan_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Fan ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `merged_into_household_id` SET TAGS ('dbx_business_glossary_term' = 'Merged Into Household ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Team ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `venue_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Venue ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `primary_fan_fan_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Fan ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `season_ticket_account_id` SET TAGS ('dbx_business_glossary_term' = 'Season Ticket Account Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `acquisition_channel` SET TAGS ('dbx_business_glossary_term' = 'Household Acquisition Channel');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Household Acquisition Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Household Address Line 1');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Household Address Line 2');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `annual_spend_usd` SET TAGS ('dbx_business_glossary_term' = 'Household Annual Spend in USD');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `annual_spend_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `annual_spend_usd` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `ccpa_opt_out_flag` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Opt-Out Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Household City');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `combined_ltv_usd` SET TAGS ('dbx_business_glossary_term' = 'Combined Household Lifetime Value (LTV) in USD');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `combined_ltv_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `combined_ltv_usd` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Household Country Code');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `crm_account_reference` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Account ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `data_enrichment_source` SET TAGS ('dbx_business_glossary_term' = 'Data Enrichment Source');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `data_enrichment_source` SET TAGS ('dbx_value_regex' = 'self_reported|third_party|inferred|crm_import|combined');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `deduplication_key` SET TAGS ('dbx_business_glossary_term' = 'Household Deduplication Key');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `gdpr_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Consent Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `household_name` SET TAGS ('dbx_business_glossary_term' = 'Household Name');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `household_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `household_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `household_status` SET TAGS ('dbx_business_glossary_term' = 'Household Status');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `household_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|merged|deceased');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `household_type` SET TAGS ('dbx_business_glossary_term' = 'Household Type');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `household_type` SET TAGS ('dbx_value_regex' = 'family|couple|individual|corporate|fan_club');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `income_band` SET TAGS ('dbx_business_glossary_term' = 'Household Income Band');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `income_band` SET TAGS ('dbx_value_regex' = 'under_30k|30k_60k|60k_100k|100k_150k|150k_250k|over_250k');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `income_band` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `is_season_ticket_holder` SET TAGS ('dbx_business_glossary_term' = 'Season Ticket Holder Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `is_vip_member` SET TAGS ('dbx_business_glossary_term' = 'Very Important Person (VIP) Member Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `last_engagement_date` SET TAGS ('dbx_business_glossary_term' = 'Household Last Engagement Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `loyalty_points_balance` SET TAGS ('dbx_business_glossary_term' = 'Household Loyalty Points Balance');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `loyalty_tier` SET TAGS ('dbx_business_glossary_term' = 'Household Loyalty Tier');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `loyalty_tier` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold|platinum|elite');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `marketing_opt_in_flag` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt-In Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `member_count` SET TAGS ('dbx_business_glossary_term' = 'Household Member Count');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `nps_survey_date` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Survey Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Household Postal Code');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Channel');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_value_regex' = 'email|sms|push|direct_mail|phone');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Household Preferred Language');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `preferred_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `preferred_sport` SET TAGS ('dbx_business_glossary_term' = 'Household Preferred Sport');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `primary_email` SET TAGS ('dbx_business_glossary_term' = 'Household Primary Email Address');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `primary_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `primary_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `primary_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `primary_phone` SET TAGS ('dbx_business_glossary_term' = 'Household Primary Phone Number');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `primary_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Household Segment Code');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'Household State or Province');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` SET TAGS ('dbx_subdomain' = 'loyalty_rewards');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `loyalty_program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Entitlement - Asset Id');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `contract_template_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Template Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `data_processing_record_id` SET TAGS ('dbx_business_glossary_term' = 'Data Processing Record Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `franchise_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `league_id` SET TAGS ('dbx_business_glossary_term' = 'League ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `regulatory_license_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory License Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `sponsor_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `venue_id` SET TAGS ('dbx_business_glossary_term' = 'Venue ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `access_tier_required` SET TAGS ('dbx_business_glossary_term' = 'Required Access Tier');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `ccpa_applicable` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Applicable Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `crm_program_reference` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Program ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `currency_name` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Currency Name');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `currency_symbol` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Currency Symbol');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `currency_symbol` SET TAGS ('dbx_value_regex' = '^.{1,10}$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `digital_wallet_enabled` SET TAGS ('dbx_business_glossary_term' = 'Digital Wallet Enabled Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `earning_period_type` SET TAGS ('dbx_business_glossary_term' = 'Earning Period Type');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `earning_period_type` SET TAGS ('dbx_value_regex' = 'season|calendar_year|rolling_12_months|monthly');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `earning_rules_summary` SET TAGS ('dbx_business_glossary_term' = 'Earning Rules Summary');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Effective End Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Effective Start Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Channel');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|venue_kiosk|pos|crm_agent|partner');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `exclusive_window_end` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Window End');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `exclusive_window_start` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Window Start');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `gdpr_applicable` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Applicable Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `is_auto_enroll` SET TAGS ('dbx_business_glossary_term' = 'Auto-Enrollment Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `is_paid_membership` SET TAGS ('dbx_business_glossary_term' = 'Paid Membership Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `launch_market` SET TAGS ('dbx_business_glossary_term' = 'Launch Market Country Code');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `launch_market` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `loyalty_program_status` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Status');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `loyalty_program_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|suspended|retired');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `max_earning_per_period` SET TAGS ('dbx_business_glossary_term' = 'Maximum Earning Per Period');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `max_earning_per_transaction` SET TAGS ('dbx_business_glossary_term' = 'Maximum Earning Per Transaction');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `membership_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Membership Fee Amount');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `membership_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `membership_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Membership Fee Currency Code');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `membership_fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `membership_fee_frequency` SET TAGS ('dbx_business_glossary_term' = 'Membership Fee Frequency');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `membership_fee_frequency` SET TAGS ('dbx_value_regex' = 'annual|monthly|one_time|seasonal');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `merchandise_redemption_enabled` SET TAGS ('dbx_business_glossary_term' = 'Merchandise Redemption Enabled Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `min_redemption_threshold` SET TAGS ('dbx_business_glossary_term' = 'Minimum Redemption Threshold');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `nps_tracking_enabled` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Tracking Enabled Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `partner_program_flag` SET TAGS ('dbx_business_glossary_term' = 'Partner Program Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `points_cost` SET TAGS ('dbx_business_glossary_term' = 'Points Redemption Cost');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `points_expiry_policy` SET TAGS ('dbx_business_glossary_term' = 'Points Expiry Policy');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `points_expiry_policy` SET TAGS ('dbx_value_regex' = 'no_expiry|rolling_12_months|rolling_24_months|annual_reset|event_based');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `ppv_earning_enabled` SET TAGS ('dbx_business_glossary_term' = 'Pay-Per-View (PPV) Earning Enabled Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Code');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,30}$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `program_description` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Description');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Name');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Type');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'points_based|tier_based|hybrid|subscription|coalition');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `program_version` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Version');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `redemption_count` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Redemption Count');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `redemption_rate` SET TAGS ('dbx_business_glossary_term' = 'Redemption Rate');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `redemption_rules_summary` SET TAGS ('dbx_business_glossary_term' = 'Redemption Rules Summary');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `scope_type` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Scope Type');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `scope_type` SET TAGS ('dbx_value_regex' = 'league|venue|team|digital_platform|multi_property');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `target_fan_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Fan Segment');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `ticket_redemption_enabled` SET TAGS ('dbx_business_glossary_term' = 'Ticket Redemption Enabled Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `tier_count` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Tier Count');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` SET TAGS ('dbx_subdomain' = 'loyalty_rewards');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `loyalty_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Enrollment ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `digital_touchpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Touchpoint Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `fan_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Fan ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `franchise_id` SET TAGS ('dbx_business_glossary_term' = 'Home Team ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Home Team ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `venue_id` SET TAGS ('dbx_business_glossary_term' = 'Home Venue ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'League Season Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `loyalty_program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `primary_loyalty_fan_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Fan ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `referred_by_fan_fan_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Referred By Fan ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `auto_renewal_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Enabled Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `ccpa_opt_out` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Opt-Out Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Capture Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `current_points_balance` SET TAGS ('dbx_business_glossary_term' = 'Current Redeemable Points Balance');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `current_tier` SET TAGS ('dbx_business_glossary_term' = 'Current Loyalty Tier');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `current_tier` SET TAGS ('dbx_value_regex' = 'Bronze|Silver|Gold|Platinum|Diamond');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Enrollment Channel');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Enrollment Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Enrollment Number');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_value_regex' = '^LYL-[A-Z0-9]{8,16}$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Enrollment Status');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'active|suspended|terminated|pending|expired');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `enrollment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Enrollment Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `fan_club_member` SET TAGS ('dbx_business_glossary_term' = 'Fan Club Member Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `gdpr_consent_given` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Consent Given Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `is_primary_enrollment` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Enrollment Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `lifetime_points_earned` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Points Earned');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `marketing_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Marketing Communications Opt-In Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `membership_card_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Membership Card Issued Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `membership_card_number` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Membership Card Number');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `membership_card_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `membership_card_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `membership_card_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `next_tier_points_required` SET TAGS ('dbx_business_glossary_term' = 'Next Tier Points Required');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `nps_survey_date` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Survey Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `points_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Points Currency Code');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `points_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `points_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Points Expiry Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `preferred_reward_category` SET TAGS ('dbx_business_glossary_term' = 'Preferred Reward Category');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `preferred_reward_category` SET TAGS ('dbx_value_regex' = 'tickets|merchandise|experiences|food_beverage|digital_content|charity');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `previous_tier` SET TAGS ('dbx_business_glossary_term' = 'Previous Loyalty Tier');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `previous_tier` SET TAGS ('dbx_value_regex' = 'Bronze|Silver|Gold|Platinum|Diamond');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `referral_source_code` SET TAGS ('dbx_business_glossary_term' = 'Referral Source Code');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Enrollment Renewal Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `season_ticket_holder` SET TAGS ('dbx_business_glossary_term' = 'Season Ticket Holder Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'salesforce_crm|adobe_aep|archtics|manual');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `source_system_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Enrollment Termination Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Enrollment Termination Reason');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'fan_request|non_renewal|fraud|program_closure|inactivity|deceased');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `tier_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Tier Change Reason');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `tier_change_reason` SET TAGS ('dbx_value_regex' = 'upgrade|downgrade|initial_assignment|program_restructure|manual_override');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `tier_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Tier Expiry Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `tier_qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Tier Qualification Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `tier_qualifying_points_ytd` SET TAGS ('dbx_business_glossary_term' = 'Tier Qualifying Points Year-to-Date (YTD)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ALTER COLUMN `vip_status` SET TAGS ('dbx_business_glossary_term' = 'Very Important Person (VIP) Status Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` SET TAGS ('dbx_subdomain' = 'loyalty_rewards');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `loyalty_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Transaction ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Event Calendar Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `digital_touchpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Touchpoint Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `engagement_event_id` SET TAGS ('dbx_business_glossary_term' = 'Source Event ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `fan_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Fan ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `franchise_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `league_id` SET TAGS ('dbx_business_glossary_term' = 'League ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `loyalty_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Enrollment ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `loyalty_program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `membership_tier_id` SET TAGS ('dbx_business_glossary_term' = 'Membership Tier ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `nps_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Survey ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `pipeline_run_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Batch Run ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `ppv_package_id` SET TAGS ('dbx_business_glossary_term' = 'Ppv Package Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `primary_loyalty_fan_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Fan ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Promotion ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `reversal_of_transaction_loyalty_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Reversal of Loyalty Transaction ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `reward_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Reward ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `ticket_order_id` SET TAGS ('dbx_business_glossary_term' = 'Source Order ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `transfer_target_fan_fan_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Target Fan ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `venue_id` SET TAGS ('dbx_business_glossary_term' = 'Venue ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `wager_id` SET TAGS ('dbx_business_glossary_term' = 'Wager Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `activity_channel` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Activity Channel');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `activity_channel` SET TAGS ('dbx_value_regex' = 'mobile_app|web|venue_kiosk|pos|call_center|partner');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Triggering Activity Type');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `base_points_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Loyalty Points Amount');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `ccpa_opt_out` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Opt-Out Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `gdpr_consent_verified` SET TAGS ('dbx_business_glossary_term' = 'GDPR Consent Verified Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `is_bonus_transaction` SET TAGS ('dbx_business_glossary_term' = 'Is Bonus Transaction Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `is_tier_qualifying` SET TAGS ('dbx_business_glossary_term' = 'Is Tier Qualifying Transaction Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `monetary_value` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Transaction Monetary Value');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `monetary_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `monetary_value` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Transaction Notes');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `points_amount` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Amount');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `points_balance_after` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Running Balance After Transaction');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `points_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Expiry Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `points_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Multiplier');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `processing_date` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Transaction Processing Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `redemption_value` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Redemption Monetary Value');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `redemption_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `redemption_value` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Transaction Reversal Reason');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `source_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Transaction Reference');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `tier_qualifying_points` SET TAGS ('dbx_business_glossary_term' = 'Tier Qualifying Points Amount');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `transaction_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Transaction Reference Number');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `transaction_reference_number` SET TAGS ('dbx_value_regex' = '^LT-[0-9]{10}$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Transaction Status');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|reversed|failed|cancelled');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Transaction Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Transaction Type');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'earn|redeem|adjust|expire|transfer');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` SET TAGS ('dbx_subdomain' = 'membership_services');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `membership_id` SET TAGS ('dbx_business_glossary_term' = 'Membership ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `access_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Zone Access Grant - Access Zone Id');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `seat_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Seat Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Event Calendar Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `contract_template_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Template Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `digital_subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Subscription Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `family_account_id` SET TAGS ('dbx_business_glossary_term' = 'Family Account ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `fan_fan_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Fan ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `fan_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Fan ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `franchise_id` SET TAGS ('dbx_business_glossary_term' = 'Team ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `league_id` SET TAGS ('dbx_business_glossary_term' = 'League ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'League Season Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `parking_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Parking Lot Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `sales_rep_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `season_ticket_package_id` SET TAGS ('dbx_business_glossary_term' = 'Season Ticket Package Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `seating_section_id` SET TAGS ('dbx_business_glossary_term' = 'Seat Block ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `tax_jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Team ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `venue_id` SET TAGS ('dbx_business_glossary_term' = 'Venue ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `access_tier` SET TAGS ('dbx_business_glossary_term' = 'Access Tier');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `auto_renew_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renew Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Membership Cancellation Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Membership Cancellation Reason');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_value_regex' = 'fan_request|non_payment|relocation|dissatisfaction|deceased|corporate_termination');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `ccpa_opt_out_flag` SET TAGS ('dbx_business_glossary_term' = 'CCPA Opt-Out Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Channel');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'online|mobile_app|box_office|phone|corporate|partner');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `credential_type` SET TAGS ('dbx_business_glossary_term' = 'Credential Type');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Membership Discount Amount');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `discount_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Membership End Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `exclusive_content_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Content Access Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `fee` SET TAGS ('dbx_business_glossary_term' = 'Membership Fee');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `fee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `fee` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `gdpr_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'GDPR Consent Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `grant_status` SET TAGS ('dbx_business_glossary_term' = 'Grant Status');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `is_corporate` SET TAGS ('dbx_business_glossary_term' = 'Corporate Membership Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `is_vip` SET TAGS ('dbx_business_glossary_term' = 'VIP (Very Important Person) Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `lounge_access_flag` SET TAGS ('dbx_business_glossary_term' = 'VIP Lounge Access Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `marketing_opt_in_flag` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt-In Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `meet_greet_allotment` SET TAGS ('dbx_business_glossary_term' = 'Meet-and-Greet Allotment');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `membership_number` SET TAGS ('dbx_business_glossary_term' = 'Membership Number');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `membership_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `membership_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `membership_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_business_glossary_term' = 'Membership Status');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_value_regex' = 'active|suspended|cancelled|expired|pending_renewal|pending_activation');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `membership_tier` SET TAGS ('dbx_business_glossary_term' = 'Membership Tier');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `membership_tier` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold|platinum|diamond');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `membership_type` SET TAGS ('dbx_business_glossary_term' = 'Membership Type');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `membership_type` SET TAGS ('dbx_value_regex' = 'season_ticket_holder|vip_club|fan_club|ott_subscription|complimentary|corporate');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `merchandise_discount_pct` SET TAGS ('dbx_business_glossary_term' = 'Merchandise Discount Percentage');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `net_fee` SET TAGS ('dbx_business_glossary_term' = 'Net Membership Fee');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `net_fee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `net_fee` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `nps_survey_date` SET TAGS ('dbx_business_glossary_term' = 'NPS Survey Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `parking_pass_flag` SET TAGS ('dbx_business_glossary_term' = 'Parking Pass Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly|one_time');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `payment_plan_flag` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `priority_ticketing_flag` SET TAGS ('dbx_business_glossary_term' = 'Priority Ticketing Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `renewal_status` SET TAGS ('dbx_value_regex' = 'renewed|not_renewed|pending|lapsed|cancelled');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `seat_block_reference` SET TAGS ('dbx_business_glossary_term' = 'Seat Block ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Membership Start Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `valid_until` SET TAGS ('dbx_business_glossary_term' = 'Grant Valid Until');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `waitlist_flag` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `waitlist_position` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Position');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `zone_access_level` SET TAGS ('dbx_business_glossary_term' = 'Zone Access Level');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ALTER COLUMN `valid_from` SET TAGS ('dbx_business_glossary_term' = 'Grant Valid From');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` SET TAGS ('dbx_subdomain' = 'membership_services');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `membership_benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Membership Benefit ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `access_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Access Entitlement Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `ada_accommodation_id` SET TAGS ('dbx_business_glossary_term' = 'Ada Accommodation Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `athlete_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Athlete Profile Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `competition_round_id` SET TAGS ('dbx_business_glossary_term' = 'Competition Round Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `event_fixture_id` SET TAGS ('dbx_business_glossary_term' = 'Event ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `fixture_id` SET TAGS ('dbx_business_glossary_term' = 'Event ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `franchise_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `membership_id` SET TAGS ('dbx_business_glossary_term' = 'Membership ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `membership_tier_id` SET TAGS ('dbx_business_glossary_term' = 'Membership Tier ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `ppv_package_id` SET TAGS ('dbx_business_glossary_term' = 'Ppv Package Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `service_order_id` SET TAGS ('dbx_business_glossary_term' = 'Service Order Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `sku_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Catalog Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `sponsor_id` SET TAGS ('dbx_business_glossary_term' = 'Partner ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `tournament_id` SET TAGS ('dbx_business_glossary_term' = 'Tournament Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Partner ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `venue_id` SET TAGS ('dbx_business_glossary_term' = 'Venue Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `benefit_category` SET TAGS ('dbx_business_glossary_term' = 'Benefit Category');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `benefit_category` SET TAGS ('dbx_value_regex' = 'access|discount|experience|content|physical_goods|service');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `benefit_code` SET TAGS ('dbx_business_glossary_term' = 'Benefit Code');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `benefit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,30}$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `benefit_description` SET TAGS ('dbx_business_glossary_term' = 'Benefit Description');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `benefit_group_code` SET TAGS ('dbx_business_glossary_term' = 'Benefit Group Code');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `benefit_group_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `benefit_name` SET TAGS ('dbx_business_glossary_term' = 'Benefit Name');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `benefit_status` SET TAGS ('dbx_business_glossary_term' = 'Benefit Status');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `benefit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|expired|pending|cancelled');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `benefit_type` SET TAGS ('dbx_business_glossary_term' = 'Benefit Type');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `benefit_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Benefit Value Amount');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `benefit_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `consent_required` SET TAGS ('dbx_business_glossary_term' = 'Consent Required Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `fulfilment_channel` SET TAGS ('dbx_business_glossary_term' = 'Fulfilment Channel');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `fulfilment_channel` SET TAGS ('dbx_value_regex' = 'venue|online|mobile_app|mail|third_party|pos');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `fulfilment_reference` SET TAGS ('dbx_business_glossary_term' = 'Fulfilment Reference');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `fulfilment_status` SET TAGS ('dbx_business_glossary_term' = 'Fulfilment Status');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `fulfilment_status` SET TAGS ('dbx_value_regex' = 'pending|fulfilled|partially_fulfilled|failed|cancelled');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `is_auto_renewed` SET TAGS ('dbx_business_glossary_term' = 'Is Auto-Renewed Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `is_stackable` SET TAGS ('dbx_business_glossary_term' = 'Is Stackable Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `is_transferable` SET TAGS ('dbx_business_glossary_term' = 'Is Transferable Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `last_redeemed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Redeemed Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `nps_eligible` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Eligible Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `quantity_allocated` SET TAGS ('dbx_business_glossary_term' = 'Quantity Allocated');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `quantity_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Quantity Redeemed');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `redemption_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Redemption End Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `redemption_method` SET TAGS ('dbx_business_glossary_term' = 'Redemption Method');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `redemption_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Redemption Start Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `season_year` SET TAGS ('dbx_business_glossary_term' = 'Season Year');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `terms_and_conditions_url` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions URL');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `terms_and_conditions_url` SET TAGS ('dbx_value_regex' = '^https?://.+$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `usage_limit_per_event` SET TAGS ('dbx_business_glossary_term' = 'Usage Limit Per Event');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `venue_zone` SET TAGS ('dbx_business_glossary_term' = 'Venue Zone');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `vip_tier_level` SET TAGS ('dbx_business_glossary_term' = 'VIP (Very Important Person) Tier Level');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ALTER COLUMN `vip_tier_level` SET TAGS ('dbx_value_regex' = 'standard|silver|gold|platinum|diamond|vip');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` SET TAGS ('dbx_subdomain' = 'engagement_operations');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Identifier');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `fan_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Fan Segment ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `data_processing_record_id` SET TAGS ('dbx_business_glossary_term' = 'Data Processing Record Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `fan_behavior_model_id` SET TAGS ('dbx_business_glossary_term' = 'Predictive Model ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `franchise_id` SET TAGS ('dbx_business_glossary_term' = 'Target Team ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'League Season Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `pia_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Pia Assessment Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `pipeline_run_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Run Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `source_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Source System Segment ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Target Team ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `age_band_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Age Band');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `age_band_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age Band');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `ccpa_applicable` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Applicable Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `channel_applicability` SET TAGS ('dbx_business_glossary_term' = 'Channel Applicability');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `consent_requirement` SET TAGS ('dbx_business_glossary_term' = 'Consent Requirement');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `consent_requirement` SET TAGS ('dbx_value_regex' = 'explicit_consent|legitimate_interest|opt_out_honored|no_requirement');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Segment Created Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `definition_criteria` SET TAGS ('dbx_business_glossary_term' = 'Segment Definition Criteria');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `definition_format` SET TAGS ('dbx_business_glossary_term' = 'Segment Definition Format');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `definition_format` SET TAGS ('dbx_value_regex' = 'sql|json|natural_language|pql|xml');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Segment Effective From Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `effective_until_date` SET TAGS ('dbx_business_glossary_term' = 'Segment Effective Until Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `engagement_score_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Engagement Score Threshold');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `engagement_score_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Engagement Score Threshold');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `fan_count` SET TAGS ('dbx_business_glossary_term' = 'Segment Fan Count');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `gdpr_applicable` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Applicable Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `is_dtc_eligible` SET TAGS ('dbx_business_glossary_term' = 'Direct-To-Consumer (DTC) Eligible Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `is_suppression_list` SET TAGS ('dbx_business_glossary_term' = 'Suppression List Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `last_refresh_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Segment Last Refresh Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `ltv_band` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Value (LTV) Band');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `ltv_band` SET TAGS ('dbx_value_regex' = 'high|medium|low|unknown');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `membership_tier_filter` SET TAGS ('dbx_business_glossary_term' = 'Membership Tier Filter');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `model_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Predictive Model Score Threshold');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `next_refresh_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Segment Next Scheduled Refresh Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `nps_band` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Band');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `nps_band` SET TAGS ('dbx_value_regex' = 'promoter|passive|detractor|unknown');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `owning_business_unit` SET TAGS ('dbx_business_glossary_term' = 'Owning Business Unit');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `owning_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Owning Campaign ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `refresh_frequency` SET TAGS ('dbx_business_glossary_term' = 'Segment Refresh Frequency');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `refresh_frequency` SET TAGS ('dbx_value_regex' = 'real_time|hourly|daily|weekly|monthly|on_demand');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `rfm_tier` SET TAGS ('dbx_business_glossary_term' = 'Recency Frequency Monetary (RFM) Tier');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `rfm_tier` SET TAGS ('dbx_value_regex' = 'champions|loyal|at_risk|lost|new|potential');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `season_ticket_holder_flag` SET TAGS ('dbx_business_glossary_term' = 'Season Ticket Holder Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,50}$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `segment_description` SET TAGS ('dbx_business_glossary_term' = 'Segment Description');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `segment_name` SET TAGS ('dbx_business_glossary_term' = 'Segment Name');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_business_glossary_term' = 'Segment Status');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|archived|under_review');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `segment_type` SET TAGS ('dbx_business_glossary_term' = 'Segment Type');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `segment_type` SET TAGS ('dbx_value_regex' = 'rfm|behavioral|demographic|psychographic|predictive|geographic');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Segment Source System');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'adobe_experience_platform|salesforce_crm|manual|third_party');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `subtype` SET TAGS ('dbx_business_glossary_term' = 'Segment Subtype');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Segment Tags');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `target_league` SET TAGS ('dbx_business_glossary_term' = 'Target League');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Segment Last Updated Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Segment Version Number');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` SET TAGS ('dbx_subdomain' = 'engagement_operations');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `segment_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Assignment Identifier');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `assigned_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned By User ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `assigned_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `assigned_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned By User ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `fan_behavior_model_id` SET TAGS ('dbx_business_glossary_term' = 'Fan Behavior Model Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `fan_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Fan Profile ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `model_run_id` SET TAGS ('dbx_business_glossary_term' = 'Model Run Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `notification_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `segment_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Rule ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `ab_test_variant` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `ab_test_variant` SET TAGS ('dbx_value_regex' = 'control|variant_a|variant_b|variant_c');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `activation_destination` SET TAGS ('dbx_business_glossary_term' = 'Activation Destination');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `activation_status` SET TAGS ('dbx_business_glossary_term' = 'Segment Activation Status');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `activation_status` SET TAGS ('dbx_value_regex' = 'not_activated|activated|activation_failed|deactivated');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `activation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Segment Activation Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `assignment_channel` SET TAGS ('dbx_business_glossary_term' = 'Segment Assignment Channel');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `assignment_channel` SET TAGS ('dbx_value_regex' = 'crm|aep|api|batch|manual_ui');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Segment Assignment Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `assignment_method` SET TAGS ('dbx_business_glossary_term' = 'Segment Assignment Method');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `assignment_method` SET TAGS ('dbx_value_regex' = 'rule_based|manual|ml_predicted|imported|api_triggered');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `assignment_score` SET TAGS ('dbx_business_glossary_term' = 'Segment Assignment Score');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Segment Assignment Status');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|expired|revoked|pending|suspended');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `assignment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Segment Assignment Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `consent_basis` SET TAGS ('dbx_business_glossary_term' = 'Consent Legal Basis');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `consent_basis` SET TAGS ('dbx_value_regex' = 'explicit_consent|legitimate_interest|contract|legal_obligation|opt_out_not_exercised');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `consent_verified` SET TAGS ('dbx_business_glossary_term' = 'Consent Verified Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `data_suppression_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Suppression Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `engagement_score_at_assignment` SET TAGS ('dbx_business_glossary_term' = 'Fan Engagement Score at Assignment');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Segment Membership Expiry Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `fan_type_at_assignment` SET TAGS ('dbx_business_glossary_term' = 'Fan Account Type at Assignment');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `fan_type_at_assignment` SET TAGS ('dbx_value_regex' = 'individual|family|season_ticket_holder|vip_member|fan_club');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `geographic_market` SET TAGS ('dbx_business_glossary_term' = 'Geographic Market');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `is_primary_segment` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Segment Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `last_evaluated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Segment Evaluation Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `loyalty_tier_at_assignment` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Tier at Assignment');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `loyalty_tier_at_assignment` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold|platinum|vip');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `membership_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Segment Membership Duration Days');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `next_evaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Next Segment Evaluation Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `nps_cohort_flag` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Cohort Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Manual Override Reason');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Segment Priority Rank');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Segment Membership Revocation Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Segment Membership Revocation Reason');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_value_regex' = 'rule_exit|consent_withdrawn|manual_removal|data_quality|segment_deprecated|opt_out');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `score_model_version` SET TAGS ('dbx_business_glossary_term' = 'Score Model Version');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `score_percentile` SET TAGS ('dbx_business_glossary_term' = 'Segment Score Percentile');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `segment_category` SET TAGS ('dbx_business_glossary_term' = 'Segment Category');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `segment_category` SET TAGS ('dbx_value_regex' = 'behavioral|demographic|geographic|psychographic|transactional|predictive');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `segment_version` SET TAGS ('dbx_business_glossary_term' = 'Segment Definition Version');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'salesforce_crm|adobe_aep|ticketmaster|axs|shopify|manual');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `consent_preference_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Preference ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `auth_session_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Session ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `corporate_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Data Controller ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `data_controller_corporate_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Data Controller ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `data_processing_record_id` SET TAGS ('dbx_business_glossary_term' = 'Data Processing Record Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `data_processor_corporate_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Data Processor ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `fan_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Fan ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `fan_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `fan_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Matter Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `parental_guardian_fan_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Parental Guardian Fan ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `parental_guardian_fan_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `parental_guardian_fan_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `primary_consent_fan_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Fan ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `primary_consent_fan_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `primary_consent_fan_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Data Processor ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `aep_consent_reference` SET TAGS ('dbx_business_glossary_term' = 'Adobe Experience Platform (AEP) Consent ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `consent_category` SET TAGS ('dbx_business_glossary_term' = 'Consent Category');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `consent_category` SET TAGS ('dbx_value_regex' = 'functional|analytics|marketing|personalisation|third_party');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Granted Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `consent_language_code` SET TAGS ('dbx_business_glossary_term' = 'Consent Language Code');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `consent_language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `consent_notice_url` SET TAGS ('dbx_business_glossary_term' = 'Consent Notice URL');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `consent_proof_reference` SET TAGS ('dbx_business_glossary_term' = 'Consent Proof Reference');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `consent_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Consent Reference Number');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `consent_renewal_reminder_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Renewal Reminder Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `consent_source` SET TAGS ('dbx_business_glossary_term' = 'Consent Source Channel');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `consent_source` SET TAGS ('dbx_value_regex' = 'web_form|mobile_app|in_venue_kiosk|call_center|paper_form|third_party');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'granted|withdrawn|pending|expired');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `consent_type` SET TAGS ('dbx_value_regex' = 'marketing_email|sms|push_notification|data_sharing_partner|profiling_personalization|cookie');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `consent_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Version');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `consent_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `crm_consent_record_reference` SET TAGS ('dbx_business_glossary_term' = 'CRM (Customer Relationship Management) Consent Record ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `data_portability_requested` SET TAGS ('dbx_business_glossary_term' = 'Data Portability Request Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Capture Device Type');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet|kiosk|smart_tv|other');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `double_opt_in_date` SET TAGS ('dbx_business_glossary_term' = 'Double Opt-In Confirmation Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `double_opt_in_flag` SET TAGS ('dbx_business_glossary_term' = 'Double Opt-In Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Consent Effective From Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Consent Effective Until Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `erasure_request_date` SET TAGS ('dbx_business_glossary_term' = 'Erasure Request Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `iab_tcf_purpose_code` SET TAGS ('dbx_business_glossary_term' = 'IAB Transparency and Consent Framework (TCF) Purpose ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Consent Capture IP Address');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = 'EU_GDPR|CA_CCPA|UK_GDPR|BR_LGPD|AU_PRIVACY');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Last Reviewed Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `legal_basis` SET TAGS ('dbx_business_glossary_term' = 'Legal Basis for Processing');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `legal_basis` SET TAGS ('dbx_value_regex' = 'consent|legitimate_interest|contract|legal_obligation|vital_interest|public_task');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `minor_flag` SET TAGS ('dbx_business_glossary_term' = 'Minor Fan Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `opt_in_flag` SET TAGS ('dbx_business_glossary_term' = 'Opt-In Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `parental_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Parental Consent Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `processing_purpose` SET TAGS ('dbx_business_glossary_term' = 'Data Processing Purpose');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `right_to_erasure_requested` SET TAGS ('dbx_business_glossary_term' = 'Right to Erasure Request Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `suppression_flag` SET TAGS ('dbx_business_glossary_term' = 'Marketing Suppression Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Withdrawal Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `withdrawal_method` SET TAGS ('dbx_business_glossary_term' = 'Consent Withdrawal Method');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `withdrawal_method` SET TAGS ('dbx_value_regex' = 'web_form|mobile_app|email_unsubscribe|call_center|in_venue_kiosk|automated_expiry');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Consent Withdrawal Reason');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` SET TAGS ('dbx_subdomain' = 'engagement_operations');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `nps_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Survey ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `athlete_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Athlete Profile Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Event Calendar Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `digital_touchpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Touchpoint Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `event_fixture_id` SET TAGS ('dbx_business_glossary_term' = 'Event ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `fan_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Fan ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `fixture_id` SET TAGS ('dbx_business_glossary_term' = 'Event ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `franchise_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `league_id` SET TAGS ('dbx_business_glossary_term' = 'League ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'League Season Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `notification_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Notification Campaign Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `service_case_id` SET TAGS ('dbx_business_glossary_term' = 'Salesforce CRM Case ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `ticket_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Reference ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `tournament_id` SET TAGS ('dbx_business_glossary_term' = 'Tournament Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `venue_id` SET TAGS ('dbx_business_glossary_term' = 'Venue ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `close_date` SET TAGS ('dbx_business_glossary_term' = 'Survey Close Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `completion_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Survey Completion Time (Seconds)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `consent_captured` SET TAGS ('dbx_business_glossary_term' = 'Data Processing Consent Captured Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `consent_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Version');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `delivery_channel` SET TAGS ('dbx_business_glossary_term' = 'Survey Delivery Channel');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `delivery_channel` SET TAGS ('dbx_value_regex' = 'email|in_app|sms|in_venue_kiosk|web|push_notification');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Survey Device Type');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'mobile|tablet|desktop|kiosk|smart_tv');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `followup_action_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Action Required Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `followup_status` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Action Status');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `followup_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|resolved|no_action');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `invitations_sent` SET TAGS ('dbx_business_glossary_term' = 'Survey Invitations Sent Count');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `is_anonymous` SET TAGS ('dbx_business_glossary_term' = 'Anonymous Response Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `market_region` SET TAGS ('dbx_business_glossary_term' = 'Market Region Country Code');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `market_region` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `membership_tier` SET TAGS ('dbx_business_glossary_term' = 'Fan Membership Tier');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `membership_tier` SET TAGS ('dbx_value_regex' = 'general|silver|gold|platinum|vip');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `nps_benchmark_version` SET TAGS ('dbx_business_glossary_term' = 'NPS Benchmark Version');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Response Score');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `open_date` SET TAGS ('dbx_business_glossary_term' = 'Survey Open Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `reminder_sent` SET TAGS ('dbx_business_glossary_term' = 'Survey Reminder Sent Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `reminder_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Survey Reminder Sent Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `respondent_category` SET TAGS ('dbx_business_glossary_term' = 'NPS Respondent Category');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `respondent_category` SET TAGS ('dbx_value_regex' = 'promoter|passive|detractor');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `response_rate` SET TAGS ('dbx_business_glossary_term' = 'Survey Response Rate');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'NPS Response Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `responses_received` SET TAGS ('dbx_business_glossary_term' = 'Survey Responses Received Count');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `season_ticket_holder` SET TAGS ('dbx_business_glossary_term' = 'Season Ticket Holder Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'salesforce_crm|adobe_experience_platform|in_venue_kiosk|sms_platform|email_platform');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `survey_code` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Survey Code');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `survey_code` SET TAGS ('dbx_value_regex' = '^NPS-[A-Z0-9]{4,20}$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `survey_language` SET TAGS ('dbx_business_glossary_term' = 'Survey Language Code');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `survey_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `survey_name` SET TAGS ('dbx_business_glossary_term' = 'NPS Survey Campaign Name');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `survey_status` SET TAGS ('dbx_business_glossary_term' = 'NPS Survey Status');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `survey_status` SET TAGS ('dbx_value_regex' = 'draft|active|paused|closed|archived');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `survey_type` SET TAGS ('dbx_business_glossary_term' = 'NPS Survey Type');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `survey_type` SET TAGS ('dbx_value_regex' = 'post_event|post_purchase|seasonal|relationship|onboarding');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `target_segment_code` SET TAGS ('dbx_business_glossary_term' = 'Target Segment Code');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `touchpoint_type` SET TAGS ('dbx_business_glossary_term' = 'Fan Touchpoint Type');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `verbatim_comment` SET TAGS ('dbx_business_glossary_term' = 'NPS Verbatim Comment');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ALTER COLUMN `verbatim_comment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` SET TAGS ('dbx_subdomain' = 'engagement_operations');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `nps_response_id` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Response ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `digital_touchpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Touchpoint Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `event_fixture_id` SET TAGS ('dbx_business_glossary_term' = 'Event ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `fan_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Fan Profile ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `fixture_id` SET TAGS ('dbx_business_glossary_term' = 'Event ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Followup Employee Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `franchise_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `league_id` SET TAGS ('dbx_business_glossary_term' = 'League ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'League Season Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `nps_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Survey ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `security_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Security Incident Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `service_case_id` SET TAGS ('dbx_business_glossary_term' = 'CRM (Customer Relationship Management) Case ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Gaming Session Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `sponsorship_activation_id` SET TAGS ('dbx_business_glossary_term' = 'Activation Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `streaming_subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Subscription ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `ticket_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Transaction ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `venue_id` SET TAGS ('dbx_business_glossary_term' = 'Venue ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `consent_given` SET TAGS ('dbx_business_glossary_term' = 'Consent Given Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `consent_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Version');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `data_retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Expiry Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'mobile|tablet|desktop|kiosk|smart_tv|other');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `external_response_ref` SET TAGS ('dbx_business_glossary_term' = 'External Response Reference');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `fan_locale_country_code` SET TAGS ('dbx_business_glossary_term' = 'Fan Locale Country Code');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `fan_locale_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `fan_tenure_days` SET TAGS ('dbx_business_glossary_term' = 'Fan Tenure Days');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `follow_up_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Completed Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `follow_up_due_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Due Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `follow_up_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `follow_up_status` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Status');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `follow_up_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|resolved|closed|not_required');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `is_anonymous` SET TAGS ('dbx_business_glossary_term' = 'Is Anonymous Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `is_first_response` SET TAGS ('dbx_business_glossary_term' = 'Is First Response Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `membership_tier_at_response` SET TAGS ('dbx_business_glossary_term' = 'Membership Tier at Response');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `nps_category` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Category');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `nps_category` SET TAGS ('dbx_value_regex' = 'promoter|passive|detractor');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Score');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `primary_feedback_theme` SET TAGS ('dbx_business_glossary_term' = 'Primary Feedback Theme');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `prior_nps_score` SET TAGS ('dbx_business_glossary_term' = 'Prior NPS Score');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `response_channel` SET TAGS ('dbx_business_glossary_term' = 'Response Channel');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `response_channel` SET TAGS ('dbx_value_regex' = 'email|sms|mobile_app|web|kiosk|in_venue');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `response_latency_minutes` SET TAGS ('dbx_business_glossary_term' = 'Response Latency Minutes');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `response_status` SET TAGS ('dbx_business_glossary_term' = 'Response Status');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `response_status` SET TAGS ('dbx_value_regex' = 'submitted|partial|withdrawn|invalid|duplicate');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Response Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `score_change_direction` SET TAGS ('dbx_business_glossary_term' = 'Score Change Direction');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `score_change_direction` SET TAGS ('dbx_value_regex' = 'improved|declined|unchanged|first_response');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `sentiment_label` SET TAGS ('dbx_business_glossary_term' = 'Sentiment Label');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `sentiment_label` SET TAGS ('dbx_value_regex' = 'positive|neutral|negative|mixed');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `sentiment_score` SET TAGS ('dbx_business_glossary_term' = 'Sentiment Score');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'aep|salesforce_crm|medallia|qualtrics|internal');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `survey_completion_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Survey Completion Time Seconds');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `survey_invitation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Survey Invitation Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `survey_language_code` SET TAGS ('dbx_business_glossary_term' = 'Survey Language Code');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `survey_language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `survey_trigger_type` SET TAGS ('dbx_business_glossary_term' = 'Survey Trigger Type');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `survey_trigger_type` SET TAGS ('dbx_value_regex' = 'post_event|post_purchase|periodic|onboarding|churn_risk|manual');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `verbatim_comment` SET TAGS ('dbx_business_glossary_term' = 'Verbatim Comment');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ALTER COLUMN `verbatim_comment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` SET TAGS ('dbx_subdomain' = 'engagement_operations');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `engagement_event_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Event ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `access_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Beacon Zone ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `athlete_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Athlete Profile Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `auth_session_id` SET TAGS ('dbx_business_glossary_term' = 'Session ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `broadcast_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Schedule Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `broadcast_stream_live_feed_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Stream ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `contest_id` SET TAGS ('dbx_business_glossary_term' = 'Contest ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `digital_touchpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Touchpoint Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `event_fixture_id` SET TAGS ('dbx_business_glossary_term' = 'Event ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `fan_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Fan ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `fixture_id` SET TAGS ('dbx_business_glossary_term' = 'Event ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `live_feed_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Stream ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `loyalty_program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `merch_order_id` SET TAGS ('dbx_business_glossary_term' = 'Merch Order Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `ppv_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Ppv Transaction Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `sku_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Catalog Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `sponsorship_activation_id` SET TAGS ('dbx_business_glossary_term' = 'Activation Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `ticket_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Ticket ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `ticket_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Ticket ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `venue_id` SET TAGS ('dbx_business_glossary_term' = 'Venue ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `aep_experience_event_reference` SET TAGS ('dbx_business_glossary_term' = 'Adobe Experience Platform (AEP) Experience Event ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `aep_segment_ids` SET TAGS ('dbx_business_glossary_term' = 'Adobe Experience Platform (AEP) Segment IDs');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `app_version` SET TAGS ('dbx_business_glossary_term' = 'Application Version');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `app_version` SET TAGS ('dbx_value_regex' = '^d+.d+.d+$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `consent_analytics` SET TAGS ('dbx_business_glossary_term' = 'Analytics Consent Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `consent_marketing` SET TAGS ('dbx_business_glossary_term' = 'Marketing Consent Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `content_progress_pct` SET TAGS ('dbx_business_glossary_term' = 'Content Progress Percentage');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `crm_interaction_reference` SET TAGS ('dbx_business_glossary_term' = 'CRM Interaction ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'passed|warning|failed|pending_review');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `device_os` SET TAGS ('dbx_business_glossary_term' = 'Device Operating System');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Engagement Duration (Seconds)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `engagement_channel` SET TAGS ('dbx_business_glossary_term' = 'Engagement Channel');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `engagement_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement Event Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `engagement_status` SET TAGS ('dbx_business_glossary_term' = 'Engagement Event Status');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `engagement_status` SET TAGS ('dbx_value_regex' = 'captured|validated|enriched|rejected|duplicate');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `engagement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Engagement Event Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `engagement_type` SET TAGS ('dbx_business_glossary_term' = 'Engagement Type');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `engagement_value_score` SET TAGS ('dbx_business_glossary_term' = 'Engagement Value Score');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `geo_country_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Country Code');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `geo_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `geo_region_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region Code');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `geo_region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}-[A-Z0-9]{1,3}$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `is_authenticated` SET TAGS ('dbx_business_glossary_term' = 'Is Authenticated Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `loyalty_points_earned` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Earned');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `loyalty_points_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Redeemed');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `referral_source` SET TAGS ('dbx_business_glossary_term' = 'Referral Source');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `social_platform` SET TAGS ('dbx_business_glossary_term' = 'Social Platform');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` SET TAGS ('dbx_subdomain' = 'engagement_operations');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `communication_id` SET TAGS ('dbx_business_glossary_term' = 'Communication Identifier');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `bonus_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Bonus Offer Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `broadcast_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Schedule Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `digital_touchpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Touchpoint Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `engagement_event_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Event ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `fan_fan_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Fan ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `fan_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Fan ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `fixture_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Event ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `notification_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `sponsorship_activation_id` SET TAGS ('dbx_business_glossary_term' = 'Activation Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `communication_template_id` SET TAGS ('dbx_business_glossary_term' = 'Message Template ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `ab_test_variant` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `bounce_type` SET TAGS ('dbx_business_glossary_term' = 'Bounce Type');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `bounce_type` SET TAGS ('dbx_value_regex' = 'hard|soft|block');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `campaign_name` SET TAGS ('dbx_business_glossary_term' = 'Campaign or Journey Name');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Communication Channel');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'email|sms|push_notification|in_app|direct_mail');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `click_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Click Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `click_url` SET TAGS ('dbx_business_glossary_term' = 'Clicked URL');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `communication_type` SET TAGS ('dbx_business_glossary_term' = 'Communication Type');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `communication_type` SET TAGS ('dbx_value_regex' = 'transactional|marketing|loyalty|service|alert');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `consent_basis` SET TAGS ('dbx_business_glossary_term' = 'Consent Legal Basis');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `consent_basis` SET TAGS ('dbx_value_regex' = 'explicit_consent|legitimate_interest|contractual|vital_interest');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `consent_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Version');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `conversion_flag` SET TAGS ('dbx_business_glossary_term' = 'Conversion Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `conversion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Conversion Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'sent|delivered|bounced|failed|pending');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Recipient Device Type');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'mobile|desktop|tablet|smart_tv|unknown');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `external_message_reference` SET TAGS ('dbx_business_glossary_term' = 'External Message ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `fatigue_score` SET TAGS ('dbx_business_glossary_term' = 'Communication Fatigue Score');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Communication Language Code');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `loyalty_tier` SET TAGS ('dbx_business_glossary_term' = 'Fan Loyalty Tier at Send');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `nps_survey_flag` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Survey Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `open_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Open Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `opt_out_flag` SET TAGS ('dbx_business_glossary_term' = 'Opt-Out Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `opt_out_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Opt-Out Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `personalization_flag` SET TAGS ('dbx_business_glossary_term' = 'Personalization Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Communication Priority Level');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|standard|low');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `scheduled_send_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Send Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `send_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Send Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'salesforce_crm|adobe_aep|manual');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `subject_line` SET TAGS ('dbx_business_glossary_term' = 'Communication Subject Line');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `suppression_flag` SET TAGS ('dbx_business_glossary_term' = 'Suppression Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `suppression_reason` SET TAGS ('dbx_business_glossary_term' = 'Suppression Reason');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `suppression_reason` SET TAGS ('dbx_value_regex' = 'gdpr_optout|ccpa_optout|fatigue_cap|dnc_list|hard_bounce|regulatory');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `trigger_type` SET TAGS ('dbx_business_glossary_term' = 'Communication Trigger Type');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `trigger_type` SET TAGS ('dbx_value_regex' = 'campaign|journey|event_trigger|api|manual');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` SET TAGS ('dbx_subdomain' = 'engagement_operations');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `service_case_id` SET TAGS ('dbx_business_glossary_term' = 'Service Case Identifier');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `ada_accommodation_id` SET TAGS ('dbx_business_glossary_term' = 'Ada Accommodation Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `assigned_agent_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Agent ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `concession_stand_id` SET TAGS ('dbx_business_glossary_term' = 'Concession Stand Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `digital_touchpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Touchpoint Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Agent ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `event_fixture_id` SET TAGS ('dbx_business_glossary_term' = 'Event ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `fan_fan_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Fan ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `fan_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Fan ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `fixture_id` SET TAGS ('dbx_business_glossary_term' = 'Event ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `franchise_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `incident_report_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Report Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `insurance_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Claim Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `litigation_case_id` SET TAGS ('dbx_business_glossary_term' = 'Litigation Case Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Matter Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `membership_id` SET TAGS ('dbx_business_glossary_term' = 'Membership ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `merch_order_id` SET TAGS ('dbx_business_glossary_term' = 'Merch Order Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `ppv_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Ppv Transaction Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `related_case_service_case_id` SET TAGS ('dbx_business_glossary_term' = 'Related Case ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `return_request_id` SET TAGS ('dbx_business_glossary_term' = 'Return Request Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `seat_id` SET TAGS ('dbx_business_glossary_term' = 'Seat Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `security_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Security Incident Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `settlement_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Agreement Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `streaming_subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Streaming Subscription Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `ticket_order_id` SET TAGS ('dbx_business_glossary_term' = 'Ticket Order ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `venue_id` SET TAGS ('dbx_business_glossary_term' = 'Venue ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `wager_id` SET TAGS ('dbx_business_glossary_term' = 'Wager Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `accessibility_accommodation_type` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Accommodation Type');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `assigned_team` SET TAGS ('dbx_business_glossary_term' = 'Assigned Support Team');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `case_category` SET TAGS ('dbx_business_glossary_term' = 'Case Category');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `case_description` SET TAGS ('dbx_business_glossary_term' = 'Case Description');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Case Number');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `case_number` SET TAGS ('dbx_value_regex' = '^CAS-[0-9]{8}$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `case_reopen_count` SET TAGS ('dbx_business_glossary_term' = 'Case Reopen Count');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Case Status');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `case_sub_category` SET TAGS ('dbx_business_glossary_term' = 'Case Sub-Category');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `case_subject` SET TAGS ('dbx_business_glossary_term' = 'Case Subject');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `case_type` SET TAGS ('dbx_business_glossary_term' = 'Case Type');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `ccpa_opt_out_flag` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Opt-Out Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `close_date` SET TAGS ('dbx_business_glossary_term' = 'Case Close Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `crm_case_source_reference` SET TAGS ('dbx_business_glossary_term' = 'CRM Case Source ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Escalation Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `fan_sentiment` SET TAGS ('dbx_business_glossary_term' = 'Fan Sentiment');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `fan_sentiment` SET TAGS ('dbx_value_regex' = 'very_negative|negative|neutral|positive|very_positive');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `first_response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'First Response Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `gdpr_data_request_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Data Request Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Score');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `nps_survey_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Survey Sent Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `open_date` SET TAGS ('dbx_business_glossary_term' = 'Case Open Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `origin_channel` SET TAGS ('dbx_business_glossary_term' = 'Case Origin Channel');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Case Priority');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `refund_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `refund_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Case Resolution Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Case Resolution Notes');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `resolution_type` SET TAGS ('dbx_business_glossary_term' = 'Resolution Type');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `season_ticket_holder_flag` SET TAGS ('dbx_business_glossary_term' = 'Season Ticket Holder Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Hours');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ALTER COLUMN `vip_flag` SET TAGS ('dbx_business_glossary_term' = 'VIP (Very Important Person) Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `payment_method_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Identifier');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `fan_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Fan Profile ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `auto_renewal_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Enabled Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `avs_response_code` SET TAGS ('dbx_business_glossary_term' = 'Address Verification Service (AVS) Response Code');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `bank_account_last_four` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Last Four Digits');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `bank_account_last_four` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `bank_account_last_four` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `bank_account_last_four` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `bank_routing_code` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing / Sort Code');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `bank_routing_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `billing_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code / ZIP Code');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Billing State / Province');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `bin_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Identification Number (BIN) / Issuer Identification Number (IIN)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `bin_number` SET TAGS ('dbx_value_regex' = '^[0-9]{6,8}$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `bin_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `card_brand` SET TAGS ('dbx_business_glossary_term' = 'Card Brand / Network');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `card_brand` SET TAGS ('dbx_value_regex' = 'Visa|Mastercard|Amex|Discover|UnionPay|Other');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `card_funding_type` SET TAGS ('dbx_business_glossary_term' = 'Card Funding Type');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `card_funding_type` SET TAGS ('dbx_value_regex' = 'credit|debit|prepaid|charge|unknown');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `card_last_four` SET TAGS ('dbx_business_glossary_term' = 'Card Last Four Digits');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `card_last_four` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `card_last_four` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `card_last_four` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Name');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `consent_capture_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Consent Capture Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `consent_version` SET TAGS ('dbx_business_glossary_term' = 'Payment Consent Version');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `direct_debit_mandate_ref` SET TAGS ('dbx_business_glossary_term' = 'Direct Debit Mandate Reference');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `direct_debit_mandate_ref` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Enrollment Channel');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|pos|call_center|kiosk|partner_api');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `enrollment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Enrollment Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `expiry_month` SET TAGS ('dbx_business_glossary_term' = 'Card Expiry Month');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `expiry_notification_sent` SET TAGS ('dbx_business_glossary_term' = 'Expiry Notification Sent Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `expiry_year` SET TAGS ('dbx_business_glossary_term' = 'Card Expiry Year');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `fraud_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Payment Fraud Risk Score');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `fraud_risk_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `gift_card_balance` SET TAGS ('dbx_business_glossary_term' = 'Gift Card Remaining Balance');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `gift_card_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `gift_card_balance` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Default Payment Method Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `issuer_country_code` SET TAGS ('dbx_business_glossary_term' = 'Card Issuer Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `issuer_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Last Updated Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `last_used_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Last Used Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `method_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Status');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `method_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|removed|pending_verification');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `network_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Network Transaction ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `payment_method_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Type');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `payment_method_type` SET TAGS ('dbx_value_regex' = 'credit_card|debit_card|digital_wallet|direct_debit|gift_card|prepaid_card');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `pci_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Card Industry Data Security Standard (PCI-DSS) Compliance Status');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `pci_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `source_system_token_ref` SET TAGS ('dbx_business_glossary_term' = 'Source System Token Reference');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `token_value` SET TAGS ('dbx_business_glossary_term' = 'Payment Token Value');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `token_value` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `token_value` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `tokenization_provider` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Provider');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `tokenization_provider` SET TAGS ('dbx_value_regex' = 'Braintree|Adyen|Stripe|CyberSource|Worldpay|Other');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Verification Method');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = '3ds|avs|micro_deposit|none|cvv_check');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Instrument Verification Status');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|failed|pending');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `wallet_provider` SET TAGS ('dbx_business_glossary_term' = 'Digital Wallet Provider');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`payment_method` ALTER COLUMN `wallet_provider` SET TAGS ('dbx_value_regex' = 'Apple Pay|Google Pay|PayPal|Samsung Pay|Venmo|Other');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` SET TAGS ('dbx_subdomain' = 'community_affiliation');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `club_id` SET TAGS ('dbx_business_glossary_term' = 'Fan Club ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Administrator Employee Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `affiliated_athlete_athlete_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Affiliated Athlete ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Affiliated Team ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `athlete_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Affiliated Athlete ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `franchise_id` SET TAGS ('dbx_business_glossary_term' = 'Affiliated Team ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `governance_document_id` SET TAGS ('dbx_business_glossary_term' = 'Governance Document Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `venue_id` SET TAGS ('dbx_business_glossary_term' = 'Home Venue Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `league_id` SET TAGS ('dbx_business_glossary_term' = 'League ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `parent_club_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Fan Club ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `sponsor_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Partner ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `sponsorship_partner_sponsor_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Partner ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `annual_revenue_usd` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue (USD)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `annual_revenue_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `ccpa_applicable` SET TAGS ('dbx_business_glossary_term' = 'CCPA (California Consumer Privacy Act) Applicable Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `charter_document_ref` SET TAGS ('dbx_business_glossary_term' = 'Charter Document Reference');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Fan Club City');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `club_code` SET TAGS ('dbx_business_glossary_term' = 'Fan Club Code');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `club_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `club_name` SET TAGS ('dbx_business_glossary_term' = 'Fan Club Name');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `club_status` SET TAGS ('dbx_business_glossary_term' = 'Fan Club Status');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `club_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|dissolved');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `club_type` SET TAGS ('dbx_business_glossary_term' = 'Fan Club Type');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `club_type` SET TAGS ('dbx_value_regex' = 'official|supporters_trust|regional_chapter|booster_club|fan_society');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `crm_account_reference` SET TAGS ('dbx_business_glossary_term' = 'CRM (Customer Relationship Management) Account ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `current_member_count` SET TAGS ('dbx_business_glossary_term' = 'Current Member Count');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `dissolution_date` SET TAGS ('dbx_business_glossary_term' = 'Fan Club Dissolution Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `event_ticket_allocation` SET TAGS ('dbx_business_glossary_term' = 'Event Ticket Allocation');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `founding_date` SET TAGS ('dbx_business_glossary_term' = 'Fan Club Founding Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `gdpr_applicable` SET TAGS ('dbx_business_glossary_term' = 'GDPR (General Data Protection Regulation) Applicable Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `geographic_territory` SET TAGS ('dbx_business_glossary_term' = 'Geographic Territory');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `has_voting_rights` SET TAGS ('dbx_business_glossary_term' = 'Voting Rights Indicator');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `is_official_partner` SET TAGS ('dbx_business_glossary_term' = 'Official Partner Indicator');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `max_membership_capacity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Membership Capacity');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `membership_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Membership Fee Amount');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `membership_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `membership_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Membership Fee Currency');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `membership_fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `membership_fee_frequency` SET TAGS ('dbx_business_glossary_term' = 'Membership Fee Frequency');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `membership_fee_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly|one_time');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `membership_tier_structure` SET TAGS ('dbx_business_glossary_term' = 'Membership Tier Structure');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `membership_tier_structure` SET TAGS ('dbx_value_regex' = 'single_tier|multi_tier|tiered_with_vip');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `merchandise_discount_pct` SET TAGS ('dbx_business_glossary_term' = 'Merchandise Discount Percentage');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `merchandise_discount_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `nps_survey_date` SET TAGS ('dbx_business_glossary_term' = 'NPS (Net Promoter Score) Survey Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `preferred_language_code` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language Code');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `preferred_language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `primary_sport` SET TAGS ('dbx_business_glossary_term' = 'Primary Sport');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Official Recognition Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Fan Club Short Name');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `social_media_handle` SET TAGS ('dbx_business_glossary_term' = 'Social Media Handle');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Fan Club Website URL');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ALTER COLUMN `website_url` SET TAGS ('dbx_value_regex' = '^https?://[^s/$.?#].[^s]*$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` SET TAGS ('dbx_subdomain' = 'community_affiliation');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `club_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Club Membership Identifier');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `chapter_id` SET TAGS ('dbx_business_glossary_term' = 'Fan Club Chapter ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `club_id` SET TAGS ('dbx_business_glossary_term' = 'Fan Club ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `fan_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Fan Profile ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'League Season Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `primary_club_fan_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Fan Profile ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `referred_by_fan_fan_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Referred By Fan ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `auto_renewal_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Enabled Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `card_delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Membership Card Delivery Status');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `card_delivery_status` SET TAGS ('dbx_value_regex' = 'not_issued|pending|dispatched|delivered|returned');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `card_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Membership Card Issued Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `ccpa_applicable` SET TAGS ('dbx_business_glossary_term' = 'CCPA Applicable Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `consent_capture_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Capture Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `consent_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Version');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `consent_version` SET TAGS ('dbx_value_regex' = '^v[0-9]+.[0-9]+$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `crm_record_reference` SET TAGS ('dbx_business_glossary_term' = 'CRM Record ID');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `dues_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Dues Amount');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `dues_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `dues_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Dues Currency Code');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `dues_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `dues_paid_date` SET TAGS ('dbx_business_glossary_term' = 'Dues Paid Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `dues_payment_status` SET TAGS ('dbx_business_glossary_term' = 'Dues Payment Status');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `dues_payment_status` SET TAGS ('dbx_value_regex' = 'paid|pending|overdue|waived|refunded');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Membership Effective Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Channel');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Membership Expiry Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `gdpr_applicable` SET TAGS ('dbx_business_glossary_term' = 'GDPR Applicable Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `has_voting_rights` SET TAGS ('dbx_business_glossary_term' = 'Voting Rights Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `is_founding_member` SET TAGS ('dbx_business_glossary_term' = 'Founding Member Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `join_date` SET TAGS ('dbx_business_glossary_term' = 'Membership Join Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `marketing_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt-In Flag');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `membership_card_number` SET TAGS ('dbx_business_glossary_term' = 'Membership Card Number');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `membership_card_number` SET TAGS ('dbx_value_regex' = '^[0-9]{12,16}$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `membership_card_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `membership_card_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `membership_number` SET TAGS ('dbx_business_glossary_term' = 'Membership Number');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `membership_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{6,10}$');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_business_glossary_term' = 'Membership Status');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_value_regex' = 'active|pending|suspended|lapsed|cancelled|expired');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `membership_tier` SET TAGS ('dbx_business_glossary_term' = 'Membership Tier');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `membership_tier` SET TAGS ('dbx_value_regex' = 'standard|silver|gold|platinum|founding|vip');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `membership_type` SET TAGS ('dbx_business_glossary_term' = 'Membership Type');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `membership_type` SET TAGS ('dbx_value_regex' = 'individual|family|corporate|youth|student|honorary');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `nps_survey_date` SET TAGS ('dbx_business_glossary_term' = 'NPS Survey Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `preferred_contact_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Channel');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `preferred_contact_channel` SET TAGS ('dbx_value_regex' = 'email|sms|push|post|none');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `referral_source_code` SET TAGS ('dbx_business_glossary_term' = 'Referral Source Code');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `renewal_count` SET TAGS ('dbx_business_glossary_term' = 'Membership Renewal Count');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Membership Renewal Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `suspension_end_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension End Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `suspension_start_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Start Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Membership Termination Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Membership Termination Reason');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'voluntary_cancellation|non_payment|conduct_violation|deceased|duplicate|club_dissolved');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`personalization_rule` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`personalization_rule` SET TAGS ('dbx_subdomain' = 'engagement_operations');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`personalization_rule` SET TAGS ('dbx_association_edges' = 'fan.segment,content.asset');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`personalization_rule` ALTER COLUMN `personalization_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Personalization Rule - Personalization Rule Id');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`personalization_rule` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Personalization Rule - Asset Id');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`personalization_rule` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Personalization Rule - Fan Fan Segment Id');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`personalization_rule` ALTER COLUMN `ab_test_variant` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`personalization_rule` ALTER COLUMN `activation_status` SET TAGS ('dbx_business_glossary_term' = 'Activation Status');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`personalization_rule` ALTER COLUMN `assignment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`personalization_rule` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Expiry Date');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`personalization_rule` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`personalization_rule` ALTER COLUMN `rule_logic` SET TAGS ('dbx_business_glossary_term' = 'Personalization Rule Logic');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`campaign` SET TAGS ('dbx_subdomain' = 'engagement_operations');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`campaign` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`campaign` ALTER COLUMN `parent_campaign_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`campaign` ALTER COLUMN `actual_spend_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`campaign` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`chapter` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`chapter` SET TAGS ('dbx_subdomain' = 'community_affiliation');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`chapter` ALTER COLUMN `chapter_id` SET TAGS ('dbx_business_glossary_term' = 'Chapter Identifier');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`chapter` ALTER COLUMN `parent_chapter_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`chapter` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`chapter` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`chapter` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`chapter` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`chapter` ALTER COLUMN `annual_dues_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`chapter` ALTER COLUMN `chapter_president_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`chapter` ALTER COLUMN `chapter_president_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`chapter` ALTER COLUMN `chapter_president_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`chapter` ALTER COLUMN `chapter_president_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`chapter` ALTER COLUMN `chapter_president_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`chapter` ALTER COLUMN `chapter_president_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`chapter` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`chapter` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`chapter` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`chapter` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`chapter` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`chapter` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication_template` SET TAGS ('dbx_subdomain' = 'engagement_operations');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication_template` ALTER COLUMN `communication_template_id` SET TAGS ('dbx_business_glossary_term' = 'Communication Template Identifier');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication_template` ALTER COLUMN `derived_from_communication_template_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication_template` ALTER COLUMN `reply_to_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication_template` ALTER COLUMN `sender_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`reward` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`reward` SET TAGS ('dbx_subdomain' = 'loyalty_rewards');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`reward` ALTER COLUMN `reward_id` SET TAGS ('dbx_business_glossary_term' = 'Reward Identifier');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`reward` ALTER COLUMN `upgraded_reward_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_tier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_tier` SET TAGS ('dbx_subdomain' = 'membership_services');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_tier` ALTER COLUMN `membership_tier_id` SET TAGS ('dbx_business_glossary_term' = 'Membership Tier Identifier');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_tier` ALTER COLUMN `next_membership_tier_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`benefit_package` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`benefit_package` SET TAGS ('dbx_subdomain' = 'membership_services');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`benefit_package` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Identifier');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`benefit_package` ALTER COLUMN `parent_benefit_package_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_rule` SET TAGS ('dbx_subdomain' = 'engagement_operations');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_rule` ALTER COLUMN `segment_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Rule Identifier');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_rule` ALTER COLUMN `parent_segment_rule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`brand` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`brand` SET TAGS ('dbx_subdomain' = 'engagement_operations');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`brand` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Identifier');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`brand` ALTER COLUMN `brand_manager_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`brand` ALTER COLUMN `brand_manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`brand` ALTER COLUMN `brand_value_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`brand` ALTER COLUMN `broadcast_rights_holder` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`brand` ALTER COLUMN `marketing_budget_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`fan`.`brand` ALTER COLUMN `trademark_registration_number` SET TAGS ('dbx_confidential' = 'true');
